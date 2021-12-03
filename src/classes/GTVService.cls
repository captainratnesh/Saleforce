/**
 * Unpublished Work. Copyright 2009-2018 Transverse, LLC. All Rights Reserved.
 * This software contains confidential and trade secret information of:
 * Transverse, LLC.
 * 620 Congress Ave.
 * Suite 200
 * Austin, TX 78701
 * USA
 * Use, duplication or disclosure of this software is prohibited
 * without prior written permission of Transverse, LLC.
 */

/**
 * This class provides global methods to create a billing account and sales order.
 * @author AMAN JAIN
 */

global with sharing class GTVService {
  /*****************************************************************************************************************************
   * @description Method to create a billing Account in Gtv and handle the error if any!
   * @param salesforceAccountId, Salesforce Account Id
   * @return CreateAccountResponse, The billing account creation response wrapper.
   */
  global CreateAccountResponse createAccount(String salesforceAccountId) {
    CreateAccountResponse accountRes;
    list<Account> accountObjectListToUpdate = new List<Account>();
    Account thisAccount = [
      SELECT
        Id,
        Name,
        BillingStreet,
        BillingCity,
        GTV_Bill_Cycle__c,
        BillingPostalCode,
        BillingState,
        BillingCountry,
        AccountNumber,
        ShippingStreet,
        ShippingCity,
        ShippingPostalCode,
        ShippingState,
        ShippingCountry,
        Description,
        Phone,
        NumberOfEmployees,
        Tract_Billing_Account__c,
        Email__c,
        GTV_Payment_Term__c,
        Account_Create_Date__c,
        GTV_Account_Category__c,
        Currency_Type__c,
        Tax_Exempt__c,
        Error_Message__c,
        Status__c,
        Gotransverse_Bill_Type__c
      FROM Account
      WHERE id = :salesforceAccountId
      LIMIT 1
    ];
    if (thisAccount.Tract_Billing_Account__c == null) {
      accountRes = saveAccount(thisAccount);
    }
    return accountRes;
  }

  private static CreateAccountResponse saveAccount(Account thisAccount) {
    string error = 'NoError';
    list<TRACT_Setup__c> tractList = new List<TRACT_Setup__c>();
    TRACTBillingAccountCategory__c billingAccountCategory;
    string billingAccountCategoryEid;
    string paymentTermEid;
    TRACT_Bill_Cycle__c billCycle;
    String billingAccountString;
    List<Account> accountList = new List<Account>();
    accountList.add(thisAccount);
    CreateAccountResponse accountRes = new CreateAccountResponse();
    tractList = [
      SELECT
        id,
        TPassword__c,
        Tract_User_Name__c,
        TRACT_URL__c,
        Mapped_Custom_Field_Id__c,
        Active__c
      FROM TRACT_Setup__c
      WHERE Active__c = TRUE
      LIMIT 1
    ];
    TRACT_Setup__c tract = new TRACT_Setup__c();
    if (tractList.size() > 0) {
      tract = tractList[0];
      billingAccountCategory = getBillingAccountCategory(
        thisAccount.GTV_Account_Category__c
      );
      if (billingAccountCategory == null) {
        error = 'Please select the Billing Account Category.';
        accountRes.responseMessage = error;
        accountRes.salesforceAccountId = thisAccount.id;
        accountRes.responseSuccess = false;
        return accountRes;
      } else {
        billingAccountCategoryEid = billingAccountCategory.eid__c;
      }
      paymentTermEid = getPaymentTermEid(thisAccount.GTV_Payment_Term__c);
      if (paymentTermEid == null) {
        error = 'Please select a Payment Term.';
        accountRes.responseMessage = error;
        accountRes.salesforceAccountId = thisAccount.id;
        accountRes.responseSuccess = false;
        return accountRes;
      }
      billCycle = getBillCycle(thisAccount.GTV_Bill_Cycle__c);
      if (billCycle == null) {
        error = 'Please select the Bill Cycle.';
        accountRes.responseMessage = error;
        accountRes.salesforceAccountId = thisAccount.id;
        accountRes.responseSuccess = false;
        return accountRes;
      }
      APIDataService dataService = GTVDataService.getService();
      try {
        billingAccountString = dataService.getBillingAccountForCreateRequest(
          accountList,
          billCycle,
          billingAccountCategoryEid,
          paymentTermEid,
          tract.Mapped_Custom_Field_Id__c
        );
      } catch (Exception exp) {
        string errorMessage;
        string exMessage = ' ' + exp;
        if (exMessage.contains('Unexpected element')) {
          errorMessage = 'The TRACT Login UserId & Password is incorrect! Please Verify the input and try again.';
        } else if (exMessage.contains('WebService returned a SOAP Fault')) {
          errorMessage = exMessage.substring(
            exMessage.indexOf('WebService returned a SOAP Fault:') + 33,
            exMessage.indexOf('faultcode')
          );
        } else if (exMessage.contains('IO Exception')) {
          errorMessage =
            'The TRACT URL is incorrect. ' +
            exMessage.substring(exMessage.indexOf('IO Exception') + 13);
        } else {
          errorMessage = 'TRACT Server ' + exMessage;
        }
        error = errorMessage;
        accountRes.responseMessage = error;
        accountRes.salesforceAccountId = thisAccount.id;
        accountRes.responseSuccess = false;
        return accountRes;
      }
      accountRes = dataService.createAccountGlobalAction(
        thisAccount.id,
        billingAccountString
      );
    }
    return accountRes;
  }

  private static TRACTBillingAccountCategory__c getBillingAccountCategory(
    String billingAccountCategoryType
  ) {
    TRACTBillingAccountCategory__c bAC;
    List<TRACTBillingAccountCategory__c> bACList = [
      SELECT id, eid__c, type_x__c
      FROM TRACTBillingAccountCategory__c
      WHERE type_x__c = :billingAccountCategoryType
      LIMIT 1
    ];
    if (bACList.size() > 0) {
      bAC = bACList[0];
    }
    return bAC;
  }

  private static string getPaymentTermEid(String paymentTermName) {
    string paymentTermEid;
    map<String, Payment_Term__c> mapOfNameVSPaymentTerm = new Map<String, Payment_Term__c>();
    list<Payment_Term__c> paymentTermList = [
      SELECT Name, eid__c
      FROM Payment_Term__c
      LIMIT 1000
    ];
    for (Payment_Term__c paymentTerm : paymentTermList) {
      MapOfNameVSPaymentTerm.put(paymentTerm.Name, paymentTerm);
    }
    if (MapOfNameVSPaymentTerm.containsKey(PaymentTermName)) {
      paymentTermEid = MapOfNameVSPaymentTerm.get(PaymentTermName).eid__c;
      return paymentTermEid;
    } else if (MapOfNameVSPaymentTerm.containsKey('Net 30')) {
      paymentTermEid = MapOfNameVSPaymentTerm.get('Net 30').eid__c;
      return paymentTermEid;
    }
    return paymentTermEid;
  }

  private static TRACT_Bill_Cycle__c getBillCycle(String billCycleName) {
    TRACT_Bill_Cycle__c billCycle;
    List<TRACT_Bill_Cycle__c> billCycleList = [
      SELECT
        id,
        Eid__c,
        Name,
        Bill_Cycle_Type__c,
        TRACT_Bill_Cycle_Currency_Type__c
      FROM TRACT_Bill_Cycle__c
      WHERE Name = :billCycleName
      LIMIT 1
    ];
    if (billCycleList.size() > 0) {
      billCycle = billCycleList[0];
    }
    return billCycle;
  }

  /************************************************************************************************************
   * @description Method to create order in Gtv and to handle the error if any!
   * @param opportunityId, Salesforce opportunity Id
   * @return CreateOrderResponse, The wrapper response for order creation
   */
  global CreateOrderResponse createOrder(String opportunityId) {
    CreateOrderResponse orderRes;
    if (opportunityId != null) {
      orderRes = createGTVOrder(opportunityId);
    }
    return orderRes;
  }

  /****************************************************************************************************************************************************
   * @description Method to collect all information to create order In GTV and call respective method to create draft or final order as pr configuration.
   * @param OpportunityId Salesforce Opportunity Id associated with the order details.
   * @return Terrormessage
   */
  public static CreateOrderResponse createGTVOrder(String opportunityId) {
    String terrormessage = 'NoError';
    String pricebook2Id;
    CreateOrderResponse orderRes = new CreateOrderResponse();
    TRACT_Setup__c tract;
    tract = [
      SELECT
        id,
        Tract_User_Name__c,
        TPassword__c,
        TRACT_URL__c,
        Active__c,
        OrderStatus__c
      FROM TRACT_Setup__c
      WHERE Active__c = TRUE
      LIMIT 1
    ];
    if (tract == null) {
      Terrormessage = 'Unable to find TRACT Configuration details. Please ask your Administrator to Setup the TRACT Configuration.';
      orderRes.responseMessage = Terrormessage;
      orderRes.responseSuccess = false;
      return orderRes;
    }
    Opportunity thisOpp = [
      SELECT
        Id,
        Name,
        Account.Name,
        Amount,
        CloseDate,
        Description,
        Owner.Name,
        TotalOpportunityQuantity,
        Probability,
        StageName,
        Type,
        Campaign.Name,
        LeadSource,
        NextStep,
        Tract_Sales_Order__c,
        Pricebook2Id,
        Account.Tract_Billing_Account__c,
        ExpectedRevenue,
        FiscalQuarter,
        Fiscal,
        FiscalYear,
        ForecastCategory,
        ForecastCategoryName,
        LastActivityDate,
        Order_Date__c,
        IsWon,
        IsDeleted,
        IsClosed,
        HasOpportunityLineItem,
        Billing_Account__c,
        AccountId
      FROM Opportunity
      WHERE id = :OpportunityId
    ];

    if (
      thisOpp.AccountId == null ||
      thisOpp.Account.Tract_Billing_Account__c == null
    ) {
      terrormessage = 'No BillingAccount is selected for this Opportunity. Please select a BillingAccount first.';
      orderRes.responseMessage = terrormessage;
      orderRes.responseSuccess = false;
      return orderRes;
    }
    Account acc = [
      SELECT id, Tract_Billing_Account__c, Currency_Type__c
      FROM Account
      WHERE Id = :thisOpp.AccountId
    ];

    APIDataService dataService = GTVDataService.getService();
    TRACTAccountWrapper sfdcBillingAccount = dataService.getBillingAccount(
      acc.id
    );
    String accountEid = sfdcBillingAccount.eid;
    for (Pricebook2 pricebook : [SELECT id, Name FROM Pricebook2]) {
      if (pricebook.Name.contains(acc.Currency_Type__c)) {
        pricebook2Id = pricebook.Id;
        break;
      }
    }
    thisOpp.Pricebook2Id = pricebook2Id;
    //update thisOpp;

    if (thisOpp.Pricebook2Id != null) {
      List<pricebook2> pb2 = [
        SELECT id, CurrencyType__c, name
        FROM pricebook2
        WHERE id = :thisOpp.Pricebook2Id
        LIMIT 1
      ];
      if (pb2[0].name != null && pb2[0].name != '') {
        List<String> str_List = (pb2[0].name).split(' ');
        if (
          str_List.size() == 4 &&
          str_List[0] == 'GTV' &&
          str_List[2] == 'Price' &&
          str_List[3] == 'Book' &&
          str_List[1].length() == 3
        ) {
          Set<String> uniqueNames = new Set<String>();
          Map<String, OpportunityLineItem> eidOLIMap = new Map<String, OpportunityLineItem>();
          OpportunityLineItem[] opLI = [
            SELECT
              eid__c,
              Service_Resource__c,
              minServiceResources__c,
              username__c,
              firstname__c,
              lastname__c,
              Email__c,
              New_Service_Resource__c,
              RecurringPrice__c,
              PricebookEntryId,
              Existing_Service__c,
              Quantity,
              Existing_Service_Eid__c
            FROM OpportunityLineItem
            WHERE OpportunityId = :thisOpp.Id
            LIMIT 50000
          ];
          if (opLI.size() == 0) {
            terrormessage = 'Cannot create an order with 0 products';
            orderRes.responseMessage = Terrormessage;
            orderRes.responseSuccess = false;
            return orderRes;
          }
          if (thisOpp.Tract_Sales_Order__c != null) {
            terrormessage = 'This opportunity has already been moved in Tract.';
            orderRes.responseMessage = Terrormessage;
            orderRes.responseSuccess = false;
            return orderRes;
          }

          List<OpportunityLineItem> existingOLI = new List<OpportunityLineItem>();
          for (OpportunityLineItem oli : opLI) {
            if (oli.Existing_Service__c) {
              existingOLI.add(oli);
            }
          }
          if (existingOLI.size() > 0) {
            String msg = UpdateQuantityInTract(tract, existingOLI);
            if (msg != 'NoError') {
              orderRes.responseMessage = msg;
              orderRes.responseSuccess = false;
              return orderRes;
            }
          }
          String[] tractProdEid = new List<String>();
          for (OpportunityLineItem tempOPLI : opLI) {
            if (
              !(tempOPLI.eid__c == null ||
              tempOPLI.eid__c == '' ||
              tempOPLI.Existing_Service__c == true)
            ) {
              tractProdEid.add(tempOPLI.eid__c);
            }
            eidOLIMap.put(tempOPLI.eid__c, tempOPLI);
          }
          Product2[] tractProducts = [
            SELECT
              eid__c,
              IsActive,
              PriceOverride__c,
              Requires_Agreement__c,
              name,
              minServiceResources__c,
              ProductCode
            FROM Product2
            WHERE eid__c = :tractProdEid
            LIMIT 50000
          ];
          if (tractProducts.size() > 0) {
            for (Product2 tempTractProducts : tractProducts) {
              //ErrorMessage = 'Unable to Place the TRACT Sales order. Please select an Agreement for Opportunity Line Item :'+  cc.Service_Resource__c+'.sgsg ';
              OpportunityLineItem currentOLI = eidOLIMap.get(
                tempTractProducts.eid__c
              );
              if (
                currentOLI.Service_Resource__c == null &&
                currentOLI.New_Service_Resource__c == null &&
                currentOLI.minServiceResources__c > 0
              ) {
                terrormessage =
                  'Unable to Place the TRACT Sales order. Please select Service Resource' +
                  'for the Opportunity Line Item :' +
                  tempTractProducts.name +
                  '. ';
                orderRes.responseMessage = terrormessage;
                orderRes.responseSuccess = false;
                return orderRes;
              }
              if (!tempTractProducts.IsActive) {
                terrormessage =
                  'Unable to Place the TRACT Sales order.' +
                  ' Support for Opportunity Line Item :' +
                  tempTractProducts.name +
                  ' have been Stopped. ';
                orderRes.responseMessage = terrormessage;
                orderRes.responseSuccess = false;
                return orderRes;
              }
              if (tempTractProducts.ProductCode == 'TRACT_SUBSCRIPTION') {
                if (
                  currentOLI.username__c == null ||
                  currentOLI.Email__c == null ||
                  currentOLI.firstname__c == null ||
                  currentOLI.lastname__c == null ||
                  currentOLI.username__c == '' ||
                  currentOLI.Email__c == '' ||
                  currentOLI.firstname__c == '' ||
                  currentOLI.lastname__c == ''
                ) {
                  terrormessage =
                    'Unable to Place the TRACT Sales order.' +
                    ' Please provide complete TRACT Administrator Information for' +
                    ' Opportunity Line Item :' +
                    tempTractProducts.name +
                    '. ';
                  orderRes.responseMessage = terrormessage;
                  orderRes.responseSuccess = false;
                  return orderRes;
                }
              }
            }
            Map<String, String> orderInformation = getInformation(
              thisOpp,
              acc,
              tract,
              accountEid
            );
            orderRes = createGotransverseOrder(orderInformation);
          }
        }
      }
    }

    return orderRes;
  }

  /******************************************************************************************************************************************************************************************
   * @description Method to create Final Order In GTV. this method calls a method of GTVDataService class which uses API calls to create order using eithter REST or SOAP as per configuration
   * @param orderInformation Map of Opportunity Id vs order details
   * */
  public static CreateOrderResponse createGotransverseOrder(
    Map<String, String> orderInformation
  ) {
    String error;
    APIDataService dataService = GTVDataService.getService();
    CreateOrderResponse orderRes = dataService.createOrderGlobalAction(
      orderInformation
    );
    return orderRes;
  }

  private static String updateQuantityInTract(
    TRACT_Setup__c tract,
    List<OpportunityLineItem> existingOLI
  ) {
    String emessage = 'NoError';
    try {
      APIDataService dataService = GTVDataService.getService();
      dataService.updateQuantityAddProduct(existingOLI);
    } catch (Exception e) {
      emessage = string.valueof(e.getmessage() + e.getLineNumber());
      emessage = Emessage.substringBetween(
        'Web service callout failed: WebService returned a SOAP Fault:',
        ' faultcode=soap:Server faultactor='
      );
    }
    return emessage;
  }

  /*************************************************************************************************************
   * @description Method to get Account and order Information from GTV to show the details on accountDetail page.
   * @param thisOpp Salesforce Opportunity Object
   * @param acc Salesforce Account Object
   * @param tract Tract configuration details
   * @param accountEid Tract Billing Account Eid
   * */
  @TestVisible
  public static Map<String, String> getInformation(
    Opportunity thisOpp,
    Account acc,
    TRACT_Setup__c tract,
    String accountEid
  ) {
    Map<String, String> information = new Map<String, String>{
      'ErrorMessage' => 'NoError',
      'orderFromLightning' => 'true',
      'OpportunityId' => zConvert.ToString(thisOpp.Id),
      'AccountId' => zConvert.ToString(thisOpp.AccountId),
      'Amount' => zConvert.ToString(thisOpp.Amount),
      'CampaignId' => zConvert.ToString(thisOpp.CampaignId),
      'CloseDate' => zConvert.ToString(thisOpp.CloseDate),
      'Description' => zConvert.ToString(thisOpp.Description),
      'ExpectedRevenue' => zConvert.ToString(thisOpp.ExpectedRevenue),
      'Fiscal' => zConvert.ToString(thisOpp.Fiscal),
      'FiscalQuarter' => zConvert.ToString(thisOpp.FiscalQuarter),
      'FiscalYear' => zConvert.ToString(thisOpp.FiscalYear),
      'ForecastCategory' => zConvert.ToString(thisOpp.ForecastCategory),
      'ForecastCategoryName' => zConvert.ToString(thisOpp.ForecastCategoryName),
      'HasOpportunityLineItem' => zConvert.ToString(
        thisOpp.HasOpportunityLineItem
      ),
      'IsClosed' => zConvert.ToString(thisOpp.IsClosed),
      'IsDeleted' => zConvert.ToString(thisOpp.IsDeleted),
      'IsWon' => zConvert.ToString(thisOpp.IsWon),
      'LastActivityDate' => zConvert.ToString(thisOpp.LastActivityDate),
      'LeadSource' => zConvert.ToString(thisOpp.LeadSource),
      'Name' => zConvert.ToString(thisOpp.Name),
      'NextStep' => zConvert.ToString(thisOpp.NextStep),
      'OwnerId' => zConvert.ToString(thisOpp.OwnerId),
      'Pricebook2Id' => zConvert.ToString(thisOpp.Pricebook2Id),
      'Probability' => zConvert.ToString(thisOpp.Probability),
      'StageName' => zConvert.ToString(thisOpp.StageName),
      'TotalOpportunityQuantity' => zConvert.ToString(
        thisOpp.TotalOpportunityQuantity
      ),
      'Type' => zConvert.ToString(thisOpp.Type),
      'TRACT_APP__Tract_User_Name__c' => tract.Tract_User_Name__c,
      'TRACT_APP__Tract_Password__c' => tract.TPassword__c,
      'TRACT_APP__TPassword__c' => tract.TPassword__c,
      'TRACT_APP__TRACT_URL__c' => tract.TRACT_URL__c,
      'BillingAccounteid' => accountEid,
      'BillingAccountNum' => acc.Tract_Billing_Account__c,
      'OrderDate' => zConvert.ToString(thisOpp.Order_Date__c),
      'OrderStatus' => tract.OrderStatus__c
    };
    return information;
  }

  /*****************************************************************************************************************************
   * @description Method to create a billing Account in GTV and handle the errors if any!
   * @param salesforceAccountId, The Salesforce account record Id.
   * @param GTVAccount gtvAccount, The DTO to capture the required information for creating a billing account.
   * @return CreateAccountResponse, The billing account creation response wrapper.
   */
  global CreateAccountResponse createAccount(
    String salesforceAccountId,
    GTVAccount gtvAccount
  ) {
    CreateAccountResponse accountResponse = new CreateAccountResponse();
    try {
      GTVRESTDataService restDataService = new GTVRESTDataService();
      accountResponse = restDataService.createAccount(
        salesforceAccountId,
        gtvAccount
      );
    } catch (GTVAPIRestClient.ApiException ex) {
      accountResponse.responseMessage = ex.getBody();
      accountResponse.salesforceAccountId = salesforceAccountId;
      accountResponse.responseSuccess = false;
      accountResponse.responseCode = ex.getStatusCode();
      return accountResponse;
    } catch (exception ex) {
      accountResponse.responseMessage = ex.getMessage();
      accountResponse.salesforceAccountId = salesforceAccountId;
      accountResponse.responseSuccess = false;
      return accountResponse;
    }
    return accountResponse;
  }

  global QueryServiceResourceCategoryIdResponse getServiceResourceCategoryId(
    String serviceResourceCategoryName
  ) {
    QueryServiceResourceCategoryIdResponse categoryIdResponse = new QueryServiceResourceCategoryIdResponse();
    try {
      GTVRESTDataService restDataService = new GTVRESTDataService();
      categoryIdResponse = restDataService.getServiceResourceCategoryId(
        serviceResourceCategoryName
      );
    } catch (GTVAPIRestClient.ApiException ex) {
      categoryIdResponse.responseMessage = ex.getBody();
      categoryIdResponse.responseSuccess = false;
      categoryIdResponse.responseCode = ex.getStatusCode();
      return categoryIdResponse;
    } catch (exception ex) {
      categoryIdResponse.responseMessage = ex.getMessage();
      categoryIdResponse.responseSuccess = false;
      return categoryIdResponse;
    }
    return categoryIdResponse;
  }

  @deprecated
  global QueryServiceResourceResponse queryExisitngServiceResources(
    String serviceResourceCategoryId
  ) {
    return null;
  }

  global QueryServiceResourceResponse queryServiceResources(
    String serviceResourceCategoryId
  ) {
    QueryServiceResourceResponse serviceResourceResponse = new QueryServiceResourceResponse();
    try {
      GTVRESTDataService restDataService = new GTVRESTDataService();
      serviceResourceResponse = restDataService.queryServiceResources(
        serviceResourceCategoryId
      );
    } catch (GTVAPIRestClient.ApiException ex) {
      serviceResourceResponse.responseMessage = ex.getBody();
      serviceResourceResponse.responseSuccess = false;
      serviceResourceResponse.responseCode = ex.getStatusCode();
      return serviceResourceResponse;
    } catch (exception ex) {
      serviceResourceResponse.responseMessage = ex.getMessage();
      serviceResourceResponse.responseSuccess = false;
      return serviceResourceResponse;
    }
    return serviceResourceResponse;
  }

  global QueryDiscountIdentifierResponse queryDiscountIdentifier(
    String gtvProductId
  ) {
    QueryDiscountIdentifierResponse discountIdentifierResponse = new QueryDiscountIdentifierResponse();
    try {
      GTVRESTDataService restDataService = new GTVRESTDataService();
      discountIdentifierResponse = restDataService.querydiscountIdentifier(
        gtvProductId
      );
    } catch (GTVAPIRestClient.ApiException ex) {
      discountIdentifierResponse.responseMessage = ex.getBody();
      discountIdentifierResponse.responseSuccess = false;
      discountIdentifierResponse.responseCode = ex.getStatusCode();
      return discountIdentifierResponse;
    } catch (exception ex) {
      discountIdentifierResponse.responseMessage = ex.getMessage();
      discountIdentifierResponse.responseSuccess = false;
      return discountIdentifierResponse;
    }
    return discountIdentifierResponse;
  }

  global QueryDiscountResourceIdResponse getDiscountResourceId(
    String discountIdentifier
  ) {
    QueryDiscountResourceIdResponse discountResourceIdResponse = new QueryDiscountResourceIdResponse();
    try {
      GTVRESTDataService restDataService = new GTVRESTDataService();
      discountResourceIdResponse = restDataService.querydiscountResourceId(
        discountIdentifier
      );
    } catch (GTVAPIRestClient.ApiException ex) {
      discountResourceIdResponse.responseMessage = ex.getBody();
      discountResourceIdResponse.responseSuccess = false;
      discountResourceIdResponse.responseCode = ex.getStatusCode();
      return discountResourceIdResponse;
    } catch (exception ex) {
      discountResourceIdResponse.responseMessage = ex.getMessage();
      discountResourceIdResponse.responseSuccess = false;
      return discountResourceIdResponse;
    }
    return discountResourceIdResponse;
  }

  global QueryUsageChargeCategoriesResposne queryUsageChargeCategory() {
    QueryUsageChargeCategoriesResposne usageChargeCategoriesResponse = new QueryUsageChargeCategoriesResposne();
    try {
      GTVRESTDataService restDataService = new GTVRESTDataService();
      usageChargeCategoriesResponse = restDataService.queryUsageChargeCategory();
    } catch (GTVAPIRestClient.ApiException ex) {
      usageChargeCategoriesResponse.responseMessage = ex.getBody();
      usageChargeCategoriesResponse.responseSuccess = false;
      usageChargeCategoriesResponse.responseCode = ex.getStatusCode();
      return usageChargeCategoriesResponse;
    } catch (exception ex) {
      usageChargeCategoriesResponse.responseMessage = ex.getMessage();
      usageChargeCategoriesResponse.responseSuccess = false;
      return usageChargeCategoriesResponse;
    }
    return usageChargeCategoriesResponse;
  }

  global QueryServiceCustomFieldResponse queryServiceCustomFields(
    String gtvProductId
  ) {
    QueryServiceCustomFieldResponse serviceCustomFieldResponse = new QueryServiceCustomFieldResponse();
    try {
      GTVRESTDataService restDataService = new GTVRESTDataService();
      serviceCustomFieldResponse = restDataService.queryServiceCustomFields(
        gtvProductId
      );
    } catch (GTVAPIRestClient.ApiException ex) {
      serviceCustomFieldResponse.responseMessage = ex.getBody();
      serviceCustomFieldResponse.responseSuccess = false;
      serviceCustomFieldResponse.responseCode = ex.getStatusCode();
      return serviceCustomFieldResponse;
    } catch (exception ex) {
      serviceCustomFieldResponse.responseMessage = ex.getMessage();
      serviceCustomFieldResponse.responseSuccess = false;
      return serviceCustomFieldResponse;
    }
    return serviceCustomFieldResponse;
  }

  global QueryOrderCustomFieldResponse queryOrderCustomFields() {
    QueryOrderCustomFieldResponse orderCustomFieldResponse = new QueryOrderCustomFieldResponse();
    try {
      GTVRESTDataService restDataService = new GTVRESTDataService();
      orderCustomFieldResponse = restDataService.queryOrderCustomFields();
    } catch (GTVAPIRestClient.ApiException ex) {
      orderCustomFieldResponse.responseMessage = ex.getBody();
      orderCustomFieldResponse.responseSuccess = false;
      orderCustomFieldResponse.responseCode = ex.getStatusCode();
      return orderCustomFieldResponse;
    } catch (exception ex) {
      orderCustomFieldResponse.responseMessage = ex.getMessage();
      orderCustomFieldResponse.responseSuccess = false;
      return orderCustomFieldResponse;
    }
    return orderCustomFieldResponse;
  }

  global QueryRateTableResponse queryRateTables() {
    QueryRateTableResponse rateTableResponse = new QueryRateTableResponse();
    try {
      GTVRESTDataService restDataService = new GTVRESTDataService();
      rateTableResponse = restDataService.queryRateTables();
    } catch (GTVAPIRestClient.ApiException ex) {
      rateTableResponse.responseMessage = ex.getBody();
      rateTableResponse.responseSuccess = false;
      rateTableResponse.responseCode = ex.getStatusCode();
      return rateTableResponse;
    } catch (exception ex) {
      rateTableResponse.responseMessage = ex.getMessage();
      rateTableResponse.responseSuccess = false;
      return rateTableResponse;
    }
    return rateTableResponse;
  }

  global QueryParentServiceResponse queryParentServices(
    String salesforceAccountId,
    String gtvProductId
  ) {
    QueryParentServiceResponse parentServiceResponse = new QueryParentServiceResponse();
    try {
      GTVRESTDataService restDataService = new GTVRESTDataService();
      parentServiceResponse = restDataService.queryParentServices(
        salesforceAccountId,
        gtvProductId
      );
    } catch (GTVAPIRestClient.ApiException ex) {
      parentServiceResponse.responseMessage = ex.getBody();
      parentServiceResponse.responseSuccess = false;
      parentServiceResponse.responseCode = ex.getStatusCode();
      return parentServiceResponse;
    } catch (exception ex) {
      parentServiceResponse.responseMessage = ex.getMessage();
      parentServiceResponse.responseSuccess = false;
      return parentServiceResponse;
    }
    return parentServiceResponse;
  }

  global CreateOrderResponse createOrder(
    String salesforceAccountId,
    GTVOrder gtvOrder
  ) {
    CreateOrderResponse orderResponse = new CreateOrderResponse();
    try {
      GTVRESTDataService restDataService = new GTVRESTDataService();
      orderResponse = restDataService.createOrder(
        salesforceAccountId,
        gtvOrder
      );
    } catch (GTVAPIRestClient.ApiException ex) {
      orderResponse.responseMessage = ex.getBody();
      orderResponse.salesforceAccountId = salesforceAccountId;
      orderResponse.responseSuccess = false;
      orderResponse.responseCode = ex.getStatusCode();
      return orderResponse;
    } catch (exception ex) {
      orderResponse.responseMessage = ex.getMessage();
      orderResponse.salesforceAccountId = salesforceAccountId;
      orderResponse.responseSuccess = false;
      return orderResponse;
    }
    return orderResponse;
  }
}