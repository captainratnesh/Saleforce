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
 * This class provides methods to fetch data and create data using the SOAP API.
 * @author AMAN JAIN
 */

public with sharing class GTVSOAP133DataService implements APIDataService {
  /**
   * @params sfdcAccountId Id of the currrent Account
   *
   * @return TRACTAccountWrapper wrapper containing all the details for an account
   *@description - Method to get the Billing Account from Gotransverse
   */

  public TRACTAccountWrapper getBillingAccount(String sfdcAccountId) {
    Account sfdcAccount = [
      SELECT
        Id,
        Name,
        BillingStreet,
        BillingCity,
        BillingPostalCode,
        BillingState,
        NumberOfEmployees,
        BillingCountry,
        ShippingStreet,
        ShippingCity,
        ShippingPostalCode,
        ShippingState,
        ShippingCountry,
        Phone,
        Currency_Type__c,
        Tract_Billing_Account__c,
        Email__c
      FROM Account
      WHERE id = :sfdcAccountId
      LIMIT 1
    ];
    TRACTAccountWrapper sfdcBillingAccount = new TRACTAccountWrapper();
    list<SoapApi33Domain.BillingAccount> billingAccounts;
    String queryScope = 'DEEP';
    billingAccounts = GTVAPI133Adapter.getBillingAccountByNumber(
      sfdcAccount.Tract_Billing_Account__c,
      queryScope
    );
    /*Parsing the response from Gotransverse to Salesforce */
    if (null != billingAccounts) {
      sfdcBillingAccount = GTVSOAP133MappingService.parseBillingAccount(
        billingAccounts,
        queryScope
      );
    }
    return sfdcBillingAccount;
  }

  /**
   * @params TractBillingAccountNumber Account Number of the currrent Account
   *
   * @return TRACTAccountWrapper wrapper containing all the details for an account
   *@description - Method to get the Billing Account from Gotransverse based on Account Number
   */

  private TRACTAccountWrapper getBillingAccountByNumber(
    String tractBillingAccountNumber
  ) {
    TRACTAccountWrapper sfdcBillingAccount = new TRACTAccountWrapper();
    list<SoapApi33Domain.BillingAccount> billingAccounts;
    String queryScope = 'DEEP';
    billingAccounts = GTVAPI133Adapter.getBillingAccountByNumber(
      tractBillingAccountNumber,
      queryScope
    );
    /*Parsing the response from Gotransverse to Salesforce */
    if (null != billingAccounts) {
      sfdcBillingAccount = GTVSOAP133MappingService.parseBillingAccount(
        billingAccounts,
        queryScope
      );
    }
    return sfdcBillingAccount;
  }

  /**
   * @params thisAccountList The accounts Liist
   *
   * @return TRACTAccountWrapper wrapper containing all the details for an account
   *@description - Method to get the Billing Account from Gotransverse based on Account Number
   */

  public void getAccount(list<Account> thisAccountList) {
    Account thisAccount = thisAccountList[0];
    TRACTAccountWrapper tractBillingAccount = new TRACTAccountWrapper();
    tractBillingAccount = getBillingAccountByNumber(
      thisAccount.Tract_Billing_Account__c
    );
    if (tractBillingAccount.billingAccount.Tract_Billing_Account__c != null) {
      GTVSOAP133MappingService.mapAccount(thisAccount, tractBillingAccount);
    } else {
      return;
    }
  }

  /**
   * @params tractBillingAccount Wrapper containing account Details
   *  @params pageNumber PAge Number of payments
   * @return TractPaymentWrapper wrapper containing all the details for an payment
   *@description - Method to get Payments from Gotransverse
   */

  public TractPaymentWrapper getPayments(
    TRACTAccountWrapper tractBillingAccount,
    Integer pageNumber
  ) {
    SoapApi33Domain.QueryResponse paymentResponse;
    Map<String, String> getpaymentEidvsInvoiceIdMap;
    TractPaymentWrapper paymentwrap = new TractPaymentWrapper();
    paymentResponse = GTVAPI133Adapter.getBillingAccountPayments(
      tractBillingAccount,
      pageNumber
    );
    if (null != paymentResponse) {
      /*Parsing the response from Gotransverse to Salesforce */
      paymentwrap = GTVSOAP133MappingService.parsePayments(
        paymentResponse,
        tractBillingAccount
      );
      String condition = '';
      condition = GTVSOAP133MappingService.getConditions(paymentwrap);
      if (condition != '') {
        condition = condition.substring(0, condition.lastIndexOf(' or'));
        getPaymentEidvsInvoiceIdMap = GTVAPI133Adapter.getPaymentApplication(
          condition
        );
      }
      paymentwrap = GTVSOAP133MappingService.mapPayments(
        getPaymentEidvsInvoiceIdMap,
        paymentwrap
      );
    }
    return paymentwrap;
  }
  /**
   * @params invoiceNumber Invoice number to downloafd
   * @return Blob
   *@description - Method to get download invoices from Gotransverse
   */
  public Blob downloadInvoices(String invoiceNumber) {
    return null;
  }

  /**
   * @params rateTableEid Eid of rate tables
   * @return string
   *@description - Method to get get Rate tables
   */
  public string getUOMRateTable(String rateTableEid) {
    String uom;
    SoapApi33Domain.QueryResponse queryResponse;
    queryResponse = GTVAPI133Adapter.getRateTablebyEid(rateTableEid);
    if (queryResponse != null) {
      uom = GTVSOAP133MappingService.getRateTableUom(queryResponse);
    }
    return uom;
  }
  /**
   * @params tractBillingAccount Account Details Wrapper
   * @params pageNumber page number of invoices
   * @return TractInvoiceWrapper wrapper containing invoice details
   *@description -Method to get Invoices from Gotransverse
   */
  public TractInvoiceWrapper getInvoices(
    TRACTAccountWrapper tractBillingAccount,
    Integer pageNumber
  ) {
    TractInvoiceWrapper invoiceWrap = new TractInvoiceWrapper();
    SoapApi33Domain.QueryResponse queryResponse;
    queryResponse = GTVAPI133Adapter.getBillingAccountInvoices(
      tractBillingAccount,
      pageNumber
    );
    /*Parsing the response from Gotransverse to Salesforce */
    if (null != queryResponse) {
      invoiceWrap = GTVSOAP133MappingService.parseInvoices(
        queryResponse,
        tractBillingAccount
      );
    }
    return invoiceWrap;
  }
  /**
   * @params tractBillingAccount Account Details Wrapper
   * @params pageNumber page number of adjustments
   * @return TractAdjustmentWrapper wrapper containing adjustments details
   *@description -Method to get Debit adjustments from Gotransverse
   */
  public TractAdjustmentWrapper getDebitAdjustments(
    TRACTAccountWrapper tractBillingAccount,
    Integer pageNumber
  ) {
    TractAdjustmentWrapper adjustmentWrap = new TractAdjustmentWrapper();
    SoapApi33Domain.QueryResponse queryResponse;
    String adjustment = 'debit';
    Map<String, String> adjustmentEidvsInvoiceIdMap = new Map<String, String>();
    queryResponse = GTVAPI133Adapter.getBillingAccountAdjustments(
      tractBillingAccount,
      pageNumber
    );
    if (null != queryResponse) {
      adjustmentWrap = GTVSOAP133MappingService.parseAdjustments(
        queryResponse,
        tractBillingAccount,
        adjustment
      );
      String invoiceAdjustmentFilter = '';
      invoiceAdjustmentFilter = GTVSOAP133MappingService.conditionToQueryInvoiceAdjustmentApp(
        adjustmentWrap
      );
      if (invoiceAdjustmentFilter != '') {
        invoiceAdjustmentFilter = invoiceAdjustmentFilter.substring(
          0,
          invoiceAdjustmentFilter.lastIndexOf(' or')
        );
        adjustmentEidvsInvoiceIdMap = GTVAPI133Adapter.getInvoiceAdjustmentApplications(
          invoiceAdjustmentFilter
        );
      }
      adjustmentWrap = GTVSOAP133MappingService.mapAdjustments(
        adjustmentEidvsInvoiceIdMap,
        adjustmentWrap
      );
    }
    return adjustmentWrap;
  }
  /**
   * @params tractBillingAccount Account Details Wrapper
   * @params pageNumber page number of adjustments
   * @return TractAdjustmentWrapper wrapper containing adjustments details
   *@description -Method to get Credit adjustments from Gotransverse
   */
  public TractAdjustmentWrapper getCreditAdjustments(
    TRACTAccountWrapper tractBillingAccount,
    Integer pageNumber
  ) {
    TractAdjustmentWrapper adjustmentWrap = new TractAdjustmentWrapper();
    SoapApi33Domain.QueryResponse queryResponse;
    String adjustment = 'credit';
    Map<String, String> adjustmentEidvsInvoiceIdMap = new Map<String, String>();
    queryResponse = GTVAPI133Adapter.getBillingAccountAdjustments(
      tractBillingAccount,
      pageNumber
    );
    if (null != queryResponse) {
      adjustmentWrap = GTVSOAP133MappingService.parseAdjustments(
        queryResponse,
        tractBillingAccount,
        adjustment
      );
      String invoiceAdjustmentFilter = '';
      invoiceAdjustmentFilter = GTVSOAP133MappingService.conditionToQueryInvoiceAdjustmentApp(
        adjustmentWrap
      );
      if (invoiceAdjustmentFilter != '') {
        invoiceAdjustmentFilter = invoiceAdjustmentFilter.substring(
          0,
          invoiceAdjustmentFilter.lastIndexOf(' or')
        );
        adjustmentEidvsInvoiceIdMap = GTVAPI133Adapter.getInvoiceAdjustmentApplications(
          invoiceAdjustmentFilter
        );
      }
      adjustmentWrap = GTVSOAP133MappingService.mapAdjustments(
        adjustmentEidvsInvoiceIdMap,
        adjustmentWrap
      );
    }
    return adjustmentWrap;
  }
  /**
   * @params tractBillingAccount Account Details Wrapper
   * @params pageNumber page number of adjustments
   * @return TractAdjustmentWrapper wrapper containing notes details
   *@description -Method to get Notes from Gotransverse
   */
  public TRACTNoteWrapper getNotes(
    TRACTAccountWrapper tractBillingAccount,
    Integer pageNumber
  ) {
    TRACTNoteWrapper notesWrapper = new TRACTNoteWrapper();
    SoapApi33Domain.QueryResponse queryResponse;
    queryResponse = GTVAPI133Adapter.Notes(tractBillingAccount, pageNumber);
    if (null != queryResponse) {
      notesWrapper = GTVSOAP133MappingService.parseNotes(queryResponse);
    }
    return notesWrapper;
  }
  /**
   *
   * @return list<selectOption> Map of Adjustment reason Name and Id
   *@description -Method to show Credit Adjusments Reasons from Gotransverse
   */
  public list<selectOption> showCreditAdjustment() {
    list<selectOption> creditAdjustmentList = new List<selectOption>();
    SoapApi33Domain.QueryResponse creditAdjustmentResponse;
    creditAdjustmentResponse = GTVAPI133Adapter.getadjustmentReasons();
    if (
      creditAdjustmentResponse.successful &&
      creditAdjustmentResponse != null &&
      creditAdjustmentResponse.adjustmentReasons != null
    ) {
      creditAdjustmentList = GTVSOAP133MappingService.mapCreditAdjustmentReasons(
        creditAdjustmentResponse
      );
    }
    return CreditAdjustmentList;
  }
  /**
   *
   * @return list<selectOption> Map of Adjustment reason Name and Id
   *@description -Method to show Debit Adjusments Reasons from Gotransverse
   */
  public list<SelectOption> showDebitAdjustment() {
    list<SelectOption> debitAdjustmentList = new List<SelectOption>();
    SoapApi33Domain.QueryResponse debitAdjustmentResponse;
    debitAdjustmentResponse = GTVAPI133Adapter.getadjustmentReasons();
    if (
      debitAdjustmentResponse.successful &&
      debitAdjustmentResponse != null &&
      debitAdjustmentResponse.adjustmentReasons != null
    ) {
      debitAdjustmentList = GTVSOAP133MappingService.mapDebitAdjustmentReasons(
        debitAdjustmentResponse
      );
    }
    return debitAdjustmentList;
  }
  /**
   * @params tractBillingAccount Account Details Wrapper
   * @params pageNumber page number of adjustments
   * @return TRACTContactWrapper wrapper containing contact details
   *@description -Method to get Contacts from Gotransverse
   */

  public TRACTContactWrapper getContacts(
    TRACTAccountWrapper tractBillingAccount,
    Integer pageNumber
  ) {
    TRACTContactWrapper contactWrapper = new TRACTContactWrapper();
    SoapApi33Domain.QueryResponse queryResponse;
    queryResponse = GTVAPI133Adapter.Contacts(tractBillingAccount, pageNumber);
    if (null != queryResponse) {
      contactWrapper = GTVSOAP133MappingService.parseContacts(queryResponse);
    }
    return contactWrapper;
  }
  /**
   * @params tractBillingAccount Account Details Wrapper
   * @params pageNumber page number of adjustments
   * @return TractSalesOrderWrapper wrapper containing Sales Order details
   *@description -Method to get the related Orders from Gotransverse
   */

  public TractSalesOrderWrapper getSalesOrders(
    TRACTAccountWrapper sfdcAccountWrapper,
    Integer pageNumber
  ) {
    SoapApi33Domain.QueryResponse salesOrderQueryResponse;
    TractSalesOrderWrapper salesOrderWrapper = new TractSalesOrderWrapper();
    salesOrderQueryResponse = GTVAPI133Adapter.getBillingAccountSalesOrders(
      sfdcAccountWrapper,
      pageNumber
    );
    if (null != salesOrderQueryResponse) {
      salesOrderWrapper = GTVSOAP133MappingService.parseOrders(
        salesOrderQueryResponse
      );
    }

    return salesOrderWrapper;
  }
  /**
   * @params tractBillingAccount Account Details Wrapper
   * @params pageNumber page number of adjustments
   * @return TRACTPaymentMethodWrapper wrapper containing Payment Wrapper details
   *@description -Method to get Payment Method Records from Gotransverse
   */
  public TRACTPaymentMethodWrapper getPaymentMethods(
    TRACTAccountWrapper sfdcAccountWrapper,
    Integer pageNumber
  ) {
    SoapApi33Domain.QueryResponse paymentMethodsQueryResponse;
    TRACTPaymentMethodWrapper paymentMethodWrapper = new TRACTPaymentMethodWrapper();
    paymentMethodsQueryResponse = GTVAPI133Adapter.getpaymentMethodRecords(
      sfdcAccountWrapper,
      pageNumber
    );
    if (null != paymentMethodsQueryResponse) {
      paymentMethodWrapper = GTVSOAP133MappingService.parsePaymentMethodRecords(
        paymentMethodsQueryResponse
      );
    }
    return paymentMethodWrapper;
  }

  /**
   *@param accountString account wrapper in string form
   *@param pagenumber to be set while Querying Entity
   *
   *@return ActivityEventsWrapper
   */
  public ActivityEventsWrapper getUsagesEvents(
    TRACTAccountWrapper tractBillingAccount,
    Integer pagenumber
  ) {
    SoapApi33Domain.QueryResponse queryResponse;
    ActivityEventsWrapper activityWrap = new ActivityEventsWrapper();
    queryResponse = GTVAPI133Adapter.getActivityEvents(
      tractBillingAccount,
      pagenumber
    );
    if (null != queryResponse) {
      activityWrap = GTVSOAP133MappingService.parseActivityEvents(
        queryResponse,
        tractBillingAccount
      );
    }
    return activityWrap;
  }
  /**
    * @params listOfPriceList list of pricelists
    * @return void

    *@description -Method to get Products from Gotransverse based on Pricelist
    */
  public void getGTVProducts(list<Price_List__c> listOfPriceList) {
    Price_List__c priceList = listOfPriceList[0];
    SoapApi33Domain.Product[] gtvProducts;
    gtvProducts = GTVAPI133Adapter.getProducts(priceList.eid__c);
    if (null != gtvProducts && !gtvProducts.isEmpty()) {
      GTVSOAP133MappingService.saveProducts(gtvProducts, listOfPriceList);
    }
  }
  /**
    * @params currentProductList list of producs
    * @return list<Product2> list of products after saving the corresponding agreements in them
    
    *@description -Method to get Agreements from Gotransverse based on Products
    */
  public list<Product2> getGTVAgreeements(list<Product2> currentProductList) {
    SoapApi33Domain.QueryResponse queryResponse;
    list<Product2> proList = new List<Product2>();
    for (Product2 currentProduct : currentProductList) {
      list<ProductAgreementWrapper> listOfAgreements = new List<ProductAgreementWrapper>();
      queryResponse = GTVAPI133Adapter.getAgreements(currentProduct.eid__c);
      if (null != queryResponse) {
        listOfAgreements = GTVSOAP133MappingService.saveAgreements(
          queryResponse
        );
      }
      currentProduct.Agreement_Information__c = JSON.serialize(
        listOfAgreements
      );
      proList.add(currentProduct);
    }
    return proList;
  }

  /**
    * @return list<TRACT_Bill_Cycle__c> list of Bill cycles
    
    *@description -Method to get billcycles from Gotransverse 
    */
  public List<TRACT_Bill_Cycle__c> getBillCycles() {
    List<TRACT_Bill_Cycle__c> billCycleList = new List<TRACT_Bill_Cycle__c>();
    SoapApi33Domain.QueryResponse billCyclesQueryResponse;
    billCyclesQueryResponse = GTVAPI133Adapter.getBillCycles();
    if (null != billCyclesQueryResponse) {
      billCycleList = GTVSOAP133MappingService.parseBillCycles(
        billCyclesQueryResponse
      );
      //GTVAPI133Adapter.updateBillCyclePickListValues(billCycleList);
    }
    return billCycleList;
  }
  /**
    * @return list<Payment_Term__c> list of Payment Terms
    
    *@description -Method to get paymentTerms from Gotransverse 
    */
  public List<Payment_Term__c> getPaymentTerms() {
    List<Payment_Term__c> paymentTermsList = new List<Payment_Term__c>();
    SoapApi33Domain.QueryResponse paymentTermsQueryResponse;
    paymentTermsQueryResponse = GTVAPI133Adapter.getPaymentTerms();
    if (null != paymentTermsQueryResponse) {
      paymentTermsList = GTVSOAP133MappingService.parsePaymentTerms(
        paymentTermsQueryResponse
      );
      //GTVAPI133Adapter.updatePaymentTermsPickListValues(paymentTermsList);
    }
    return paymentTermsList;
  }
  /**
     *  @params activityProductEid product Eid
    * @return list<ProductUsesWrapper> usage rules wrapper
    
    *@description -Method to get usage rules from Gotransverse 
    */
  public List<ProductUsesWrapper> showUsageRule(String activityProductEid) {
    List<ProductUsesWrapper> ruleOverrides = new List<ProductUsesWrapper>();
    SoapApi33Domain.QueryResponse usageRuleResponse;
    usageRuleResponse = GTVAPI133Adapter.getserviceUsageRules(
      activityProductEid
    );
    if (
      usageRuleResponse.successful &&
      null != usageRuleResponse &&
      null != usageRuleResponse.serviceUsageRules
    ) {
      ruleOverrides = GTVSOAP133MappingService.mapServiceUsageRule(
        usageRuleResponse
      );
    }
    return ruleOverrides;
  }
  /**
    * @return list<TRACTBillingAccountCategory__c> list of Billing Account Categories
    
    *@description -Method to get billing Account Categories from Gotransverse 
    */
  public List<TRACTBillingAccountCategory__c> getBillingAccountCategories() {
    List<TRACTBillingAccountCategory__c> bacList = new List<TRACTBillingAccountCategory__c>();
    SoapApi33Domain.QueryResponse billingAccountCategoriesQueryResponse;
    billingAccountCategoriesQueryResponse = GTVAPI133Adapter.getBillingAccountCategories();
    if (null != billingAccountCategoriesQueryResponse) {
      bacList = GTVSOAP133MappingService.parseBillingAccountCategories(
        billingAccountCategoriesQueryResponse
      );
      //GTVAPI133Adapter.updateBillingAccountCategoriesPickListValues(bacList);
    }
    return bacList;
  }
  /**
    * @return list<Tract_Order_Custom_Field__c> list of Order Custom Fields
    
    *@description -Method to get order custom field from Gotransverse 
    */
  public list<Tract_Order_Custom_Field__c> getOrderCustomFields() {
    list<Tract_Order_Custom_Field__c> orderCustomFieldsList = new List<Tract_Order_Custom_Field__c>();
    SoapApi33Domain.QueryResponse orderCustomFieldsQueryResponse;
    orderCustomFieldsQueryResponse = GTVAPI133Adapter.getOrderCustomFieldList(
      'ORDER'
    );
    if (null != orderCustomFieldsQueryResponse) {
      orderCustomFieldsList = GTVSOAP133MappingService.parseOrderCustomField(
        orderCustomFieldsQueryResponse
      );
    }
    return orderCustomFieldsList;
  }
  /**
     * @params tractConfig TRACT Setups 
    * @return list<SelectOption> Map of Custom fields
    
    *@description -Method to get custom field from Gotransverse 
    */
  public list<SelectOption> getCustomFieldForBilling(
    TRACT_Setup__c tractConfig
  ) {
    List<SelectOption> customFields = new List<SelectOption>();
    SoapApi33Domain.QueryResponse customFieldsQueryResponse;
    customFieldsQueryResponse = GTVAPI133Adapter.getCustomFieldList(
      'BILLING_ACCOUNT',
      tractConfig
    );
    customFields = GTVSOAP133MappingService.mapCustomFieldForBilling(
      customFieldsQueryResponse
    );
    return customFields;
  }
  /**
    * @params serviceEid Service Eid
    * @params srId Service Resource Id
    * @params isNew true/false
    * @params effectiveDate 
    * @return void
    
    *@description -Method to apply Service Resource to Service
    */
  public void applyServiceResourceToService(
    String serviceEid,
    String srId,
    Boolean isNew,
    String effectiveDate
  ) {
    SoapApi33Domain.QueryResponse queryResponse;
    SoapApi33Domain.Service service = new SoapApi33Domain.Service();
    service.eid = serviceEid;
    SoapApi33Domain.ServiceResource serviceResource = new SoapApi33Domain.ServiceResource();
    SoapApi33Domain.CommandRequest addServiceResourceToServiceCommand = new SoapApi33Domain.CommandRequest();
    if (isNew) {
      queryResponse = GTVAPI133Adapter.queryService(serviceEid);
      if (
        queryResponse.successful &&
        null != queryResponse.services.service &&
        null !=
        queryResponse.services.service[0].product.serviceResourceCategory
      ) {
        serviceResource.category = queryResponse.services.service[0]
          .product.serviceResourceCategory;
      }
      serviceResource.identifier = srId;
    } else {
      serviceResource.eid = srId;
    }
    addServiceResourceToServiceCommand = GTVSOAP133ReverseMappingService.mapServiceResourceToService(
      service,
      serviceResource,
      effectiveDate
    );
    GTVAPI133Adapter.applyServiceResource(addServiceResourceToServiceCommand);
  }

  /**
    * @params ProductServiceWrapper wrapper containing product services
    * @params serviceResourceToBeApplied 
    * @params isNewServiceResource true/false
    * @params effectiveDate
    * @params parentServiceEid parent Service Id  
    * @return void
    
    *@description -Method to apply Service Resource to Service
    */

  public void changeServiceResource(
    ProductServiceWrapper wrapperObj,
    String serviceResourceToBeApplied,
    Boolean isNewServiceResource,
    String effectiveDate,
    String parentServiceEid
  ) {
    SoapApi33Domain.QueryResponse queryResponse;
    SoapApi33Domain.ServiceResourceCategory category;
    SoapApi33Domain.CommandRequest changeServiceResourceCommand = new SoapApi33Domain.CommandRequest();
    SoapApi33Domain.ServiceResource changeToServiceResource = new SoapApi33Domain.ServiceResource();
    if (isNewServiceResource) {
      queryResponse = GTVAPI133Adapter.getserviceResourcesByServiceEid(
        parentServiceEid
      );
      if (
        queryResponse.successful &&
        queryResponse.serviceResources.serviceResource != null
      ) {
        category = queryResponse.serviceResources.serviceResource[0].category;
      }

      changeToServiceResource = GTVSOAP133MappingService.mapServiceResourceCategory(
        category,
        serviceResourceToBeApplied
      );
    } else {
      changeToServiceResource.eid = serviceResourceToBeApplied;
    }
    changeServiceResourceCommand = GTVSOAP133ReverseMappingService.mapChangeServiceResource(
      wrapperObj,
      effectiveDate,
      parentServiceEid,
      changeToServiceResource
    );
    GTVAPI133Adapter.applyChangeServiceResource(changeServiceResourceCommand);
  }

  /*Method to get Account custom field from Gotransverse */
  public List<AccountCustomFieldWrapper> getAccountCustomFields(
    TRACTAccountWrapper tractBillingAccount
  ) {
    Map<String, String> mapOfEidVSName = new Map<String, String>();
    List<AccountCustomFieldWrapper> accountCustomFieldList = new List<AccountCustomFieldWrapper>();
    SoapApi33Domain.QueryResponse customFieldsvalueResponse;
    SoapApi33Domain.QueryResponse accountCustomFieldsQueryResponse;
    customFieldsvalueResponse = GTVAPI133Adapter.getCustomFieldValueList(
      tractBillingAccount.billingAccount.Tract_Billing_Account__c
    );
    if (
      customFieldsvalueResponse.successful &&
      null != customFieldsvalueResponse.customFieldValues.customFieldValue &&
      customFieldsvalueResponse.customFieldValues.customFieldValue.size() > 0
    ) {
      mapOfEidVSName = GTVSOAP133MappingService.mapAccountCustomFields(
        customFieldsvalueResponse
      );
    }
    accountCustomFieldsQueryResponse = GTVAPI133Adapter.getCustomFieldList(
      'BILLING_ACCOUNT'
    );
    if (null != accountCustomFieldsQueryResponse) {
      accountCustomFieldList = GTVSOAP133MappingService.parseAccountCustomFields(
        accountCustomFieldsQueryResponse,
        mapOfEidVSName
      );
    }
    return accountCustomFieldList;
  }
  /*Method to get Account custom field value from Gotransverse */
  public List<AccountCustomFieldValueWrapper> getAccountCustomFieldValueList(
    String accountId
  ) {
    list<AccountCustomFieldValueWrapper> listOfConfiguredCustomField = new List<AccountCustomFieldValueWrapper>();
    Account thisAccount = [
      SELECT id, name, Tract_Billing_Account__c
      FROM Account
      WHERE id = :accountId
      LIMIT 1
    ];
    SoapApi33Domain.QueryResponse accountCustomFieldsValueQueryResponse;
    accountCustomFieldsValueQueryResponse = GTVAPI133Adapter.getCustomFieldValueList(
      thisAccount.Tract_Billing_Account__c
    );
    if (null != accountCustomFieldsValueQueryResponse) {
      listOfConfiguredCustomField = GTVSOAP133MappingService.parseAccountCustomFieldValues(
        accountCustomFieldsValueQueryResponse
      );
    }
    return listOfConfiguredCustomField;
  }
  /*Method to create Billing Account for the request */
  public void billingAccountCreationMapping(
    list<Account> thisAccountList,
    TRACT_Bill_Cycle__c billCycle,
    string bACEid,
    string paymentTerm,
    string fieldToMapAccountId
  ) {
    Account thisAccount = thisAccountList[0];
    String billingAccountString;
    SoapApi33Domain.BillingAccount billAccount = GTVSOAP133ReverseMappingService.getBillingAccountCreationMapping(
      thisAccount,
      billCycle,
      bACEid,
      paymentTerm,
      fieldToMapAccountId
    );
    billingAccountString = JSON.serialize(billAccount);
    GTVAPI133Adapter.createRequestForBillingAccount(
      thisAccount.id,
      billingAccountString
    );
  }
  /*Method to create Billing Account for the request */
  public string getBillingAccountForCreateRequest(
    list<Account> thisAccountList,
    TRACT_Bill_Cycle__c billCycle,
    string bACEid,
    string paymentTerm,
    string fieldToMapAccountId
  ) {
    Account thisAccount = thisAccountList[0];
    String billingAccountString;
    SoapApi33Domain.BillingAccount billAccount = GTVSOAP133ReverseMappingService.getBillingAccountCreationMapping(
      thisAccount,
      billCycle,
      bACEid,
      paymentTerm,
      fieldToMapAccountId
    );
    billingAccountString = JSON.serialize(billAccount);
    return billingAccountString;
  }
  public void AccountcreationForTrigger(
    Id accountId,
    String billingAccountString
  ) {
    GTVAPI133Adapter.makeFutureCalloutForAccountCreation(
      accountId,
      billingAccountString
    );
  }
  public ChangeSubscriptionWrapper showPopupService(
    String currentProductEid,
    String currencyType,
    Boolean preserveAgreement
  ) {
    SoapApi33Domain.QueryResponse popupServiceResponse;
    SoapApi33Domain.CommandRequest serviceCommandRequest = new SoapApi33Domain.CommandRequest();
    SoapApi33Domain.CommandResponse commandResponse;
    String emessage = 'NoError';
    Boolean enablePreserveAgreement;
    String priceListEid;
    ChangeSubscriptionWrapper subscriptionWrapper = new ChangeSubscriptionWrapper();
    popupServiceResponse = GTVAPI133Adapter.getOrderItemByServiceEid(
      currentProductEid
    );
    if (
      null != popupServiceResponse &&
      null != popupServiceResponse.orderItems.orderItem &&
      popupServiceResponse.orderItems.orderItem.size() > 0
    ) {
      // Get Pricelist eid from the queried order item
      priceListEid = popupServiceResponse.orderItems.orderItem[0].priceList.eid;
      // If the orderItem has Agreement associated with it, then the checkbox is enabled that allows user to select whether agreement should be
      // preserved or not
      if (
        null == popupServiceResponse.orderItems.orderItem[0].selectedAgreement
      ) {
        enablePreserveAgreement = false;
      } else {
        enablePreserveAgreement = true;
      }
    }
    serviceCommandRequest = GTVSOAP133ReverseMappingService.mapPopupService(
      currentProductEid,
      preserveAgreement
    );
    try {
      commandResponse = GTVAPI133Adapter.createService(serviceCommandRequest);
    } catch (Exception e) {
      emessage = string.valueof(e.getmessage() + e.getLineNumber());
      emessage = emessage.substringBetween(
        'Web service callout failed: WebService returned a SOAP Fault:',
        ' faultcode=soap:Server faultactor='
      );
      subscriptionWrapper.errorMessage = emessage;
      return subscriptionWrapper;
    }
    if (
      null != commandResponse &&
      commandResponse.successful &&
      null != commandResponse.CompatibleForChangeServiceResponse &&
      null !=
      commandResponse.compatibleForChangeServiceResponse.products.product
    ) {
      subscriptionWrapper = GTVSOAP133MappingService.mapService(
        commandResponse,
        currencyType,
        priceListEid,
        enablePreserveAgreement,
        emessage
      );
    }
    return subscriptionWrapper;
  }
  public void savePopupRenew(
    String renewAgreementEid,
    list<Account> accList,
    String serviceRenewEid,
    String recurringPriceString,
    String oneTimePriceString,
    Boolean dateOverridden,
    String deactivateDateString
  ) {
    Account sfdcAccount = accList[0];
    TRACTAccountWrapper tAccount = getBillingAccountByNumber(
      sfdcAccount.Tract_Billing_Account__c
    );
    SoapApi33Domain.QueryResponse queryResponse;
    queryResponse = GTVAPI133Adapter.getBillingAccountServices(sfdcAccount);
    if (
      queryResponse.successful &&
      queryResponse != null &&
      queryResponse.services != null
    ) {
      SoapApi33Domain.Service[] allServices = queryResponse.services.service;
      for (SoapApi33Domain.Service currentService : allServices) {
        if (currentService.eid == serviceRenewEid || test.isrunningtest()) {
          SoapApi33Domain.CommandResponse renewalOrderResponse;
          SoapApi33Domain.CommandRequest renewalOrder = new SoapApi33Domain.CommandRequest();
          renewalOrder = GTVSOAP133ReverseMappingService.mapPopupRenew(
            tAccount,
            renewAgreementEid,
            serviceRenewEid,
            queryResponse,
            recurringPriceString,
            oneTimePriceString,
            dateOverridden,
            deactivateDateString,
            currentService
          );
          renewalOrderResponse = GTVAPI133Adapter.popUpServices(renewalOrder);
        }
      }
    }
  }
  /* Update Quantity in GTV*/
  public void updateQuantityInGTV(
    Decimal updateserviceQuantity,
    String serviceEidValue,
    Boolean displayEffectiveDate,
    String effectiveDate
  ) {
    SoapApi33Domain.CommandRequest updateQuantityReq = new SoapApi33Domain.CommandRequest();
    SoapApi33Domain.CommandResponse updateQuantityRes;
    updateQuantityReq = GTVSOAP133ReverseMappingService.mapQuantity(
      updateserviceQuantity,
      serviceEidValue,
      displayEffectiveDate,
      effectiveDate
    );
    updateQuantityRes = GTVAPI133Adapter.updateQuantity(updateQuantityReq);
  }
  /* Update Quantity in AddTractProduct GTV*/
  public void updateQuantityAddProduct(List<OpportunityLineItem> existingOLI) {
    SoapApi33Domain.CommandRequest updateQuantityReq = new SoapApi33Domain.CommandRequest();
    SoapApi33Domain.CommandResponse updateQuantityRes;
    for (OpportunityLineItem oli : existingOLI) {
      Decimal updateserviceQuantity;
      updateserviceQuantity = oli.Quantity;
      updateQuantityReq = GTVSOAP133ReverseMappingService.mapQuantityAddProduct(
        oli,
        updateserviceQuantity
      );
      updateQuantityRes = GTVAPI133Adapter.updateQuantityAddProduct(
        updateQuantityReq
      );
    }
  }
  /* Resume Account in GTV*/
  public void resumeBillingAccount(TRACTAccountWrapper tractBillingAccount) {
    SoapApi33Domain.CommandRequest resumeAccount = new SoapApi33Domain.CommandRequest();
    resumeAccount = GTVSOAP133ReverseMappingService.mapResumeAccount(
      tractBillingAccount
    );
    GTVAPI133Adapter.resumeAccount(resumeAccount);
  }
  /* Suspend Account in GTV*/
  public void suspendBillingAccount(
    TRACTAccountWrapper tractBillingAccount,
    String reasonEid
  ) {
    SoapApi33Domain.CommandRequest suspendAccount = new SoapApi33Domain.CommandRequest();
    suspendAccount = GTVSOAP133ReverseMappingService.mapSuspendAccount(
      tractBillingAccount,
      reasonEid
    );
    GTVAPI133Adapter.suspendAccount(suspendAccount);
  }
  /* Deactivate Account in GTV*/
  public void deactivateBillingAccount(
    TRACTAccountWrapper tractBillingAccount,
    String reasonEid
  ) {
    SoapApi33Domain.CommandRequest deactivateAccount = new SoapApi33Domain.CommandRequest();
    deactivateAccount = GTVSOAP133ReverseMappingService.mapDeactivateAccount(
      tractBillingAccount,
      reasonEid
    );
    GTVAPI133Adapter.deactivateAccount(deactivateAccount);
  }
  /* delete Activity Charge Rule in GTV*/
  public void deleteActivityChargeRule(
    String activityProductEid,
    String deletedUsageEid,
    String activityRuleName
  ) {
    SoapApi33Domain.CommandRequest removeServiceUsageRule = new SoapApi33Domain.CommandRequest();
    SoapApi33Domain.CommandResponse commandResUsageRule;
    if (null != deletedUsageEid && null != activityRuleName) {
      removeServiceUsageRule = GTVSOAP133ReverseMappingService.mapChargeRule(
        activityProductEid,
        deletedUsageEid,
        activityRuleName
      );
    }
    commandResUsageRule = GTVAPI133Adapter.removeUsageRule(
      removeServiceUsageRule
    );
  }
  /* Save Address in GTV*/
  public void saveAddAddressGTV(
    String currentServiceEid,
    String countryListValue,
    String billingCity,
    String shippingCountry,
    String shippingCity,
    String stateValue,
    String postalCode
  ) {
    SoapApi33Domain.CommandRequest addAddressToServiceReq = new SoapApi33Domain.CommandRequest();
    SoapApi33Domain.CommandResponse addAddressToServiceRes;
    addAddressToServiceReq = GTVSOAP133ReverseMappingService.mapAddAddressGTV(
      currentServiceEid,
      countryListValue,
      billingCity,
      shippingCountry,
      shippingCity,
      stateValue,
      postalCode
    );
    addAddressToServiceRes = GTVAPI133Adapter.saveAddress(
      addAddressToServiceReq
    );
  }
  /* Save Change Service in GTV*/
  public void saveChangeServicesOnApex(
    String newSubscriptionId,
    String effectiveDateValue,
    String currentServiceEid,
    list<Account> accList,
    Boolean payonPurchaseValue,
    Map<String, Decimal> mapOfAgreementPeriod,
    Map<String, String> productPriceIdToEidMap,
    Integer qtyOfChangedService,
    String agreementRenewActionForChangedService,
    String agreementEidForChangedService,
    Decimal recurringPrice,
    String recurringPriceId,
    String priceOverridden
  ) {
    Account account = accList[0];
    SoapApi33Domain.CommandRequest changeCurrentService = new SoapApi33Domain.CommandRequest();
    SoapApi33Domain.CommandResponse changeCurrentServiceRes;
    TRACTAccountWrapper tAccount = getBillingAccountByNumber(
      account.Tract_Billing_Account__c
    );
    changeCurrentService = GTVSOAP133ReverseMappingService.mapSaveChangeService(
      tAccount,
      newSubscriptionId,
      effectiveDateValue,
      currentServiceEid,
      account,
      payonPurchaseValue,
      mapOfAgreementPeriod,
      productPriceIdToEidMap,
      qtyOfChangedService,
      agreementRenewActionForChangedService,
      agreementEidForChangedService,
      recurringPrice,
      recurringPriceId,
      priceOverridden
    );
    changeCurrentServiceRes = GTVAPI133Adapter.SaveChangeService(
      changeCurrentService
    );
  }
  /* Resume Service in GTV*/
  public void resumeServiceGTV(String serviceEidValue) {
    SoapApi33Domain.CommandRequest resumeServiceReq = new SoapApi33Domain.CommandRequest();
    SoapApi33Domain.CommandResponse resumeServiceRes;
    resumeServiceReq = GTVSOAP133ReverseMappingService.mapServiceGTV(
      serviceEidValue
    );
    resumeServiceRes = GTVAPI133Adapter.resumeService(resumeServiceReq);
  }
  /* Convert Service in GTV*/
  public void convertServiceGTV(String serviceEidValue) {
    SoapApi33Domain.CommandRequest convertServiceReq = new SoapApi33Domain.CommandRequest();
    SoapApi33Domain.CommandResponse convertServiceRes;
    convertServiceReq = GTVSOAP133ReverseMappingService.mapconvertServiceGTV(
      serviceEidValue
    );
    convertServiceRes = GTVAPI133Adapter.resumeService(convertServiceReq);
  }
  /* Suspend Service in GTV*/
  public void suspendServiceGTV(String serviceEid, String reasonEid) {
    SoapApi33Domain.CommandRequest suspendServiceReq = new SoapApi33Domain.CommandRequest();
    SoapApi33Domain.CommandResponse suspendServiceRes;
    suspendServiceReq = GTVSOAP133ReverseMappingService.mapSuspendServiceGTV(
      serviceEid,
      reasonEid
    );
    suspendServiceRes = GTVAPI133Adapter.suspendService(suspendServiceReq);
  }
  /* Save Adjustments in GTV*/
  public void saveAdjustmentGTV(
    String accountId,
    string adjustmentReasonEid,
    String ammount,
    String description,
    String effectiveDate,
    boolean manualInvoice,
    boolean isCredit
  ) {
    SoapApi33Domain.CreateResponse creteRes;
    SoapApi33Domain.CreateRequest createReq = new SoapApi33Domain.CreateRequest();
    TRACTAccountWrapper tAccount = getBillingAccount(accountId);
    SoapApi33Domain.CreateAdjustment adjustment = new SoapApi33Domain.CreateAdjustment();
    adjustment = GTVSOAP133ReverseMappingService.mapAdjustment(
      effectiveDate,
      adjustmentReasonEid,
      ammount,
      description,
      tAccount,
      manualInvoice,
      isCredit
    );
    createReq = GTVSOAP133ReverseMappingService.createAdjustmentRequest(
      adjustment
    );
    creteRes = GTVAPI133Adapter.createAdjustmentResponse(createReq);
    if (null != creteRes && creteRes.successful) {
      SoapApi33Domain.CommandResponse postAddCredit;
      SoapApi33Domain.CommandRequest postCreditAdjustment = new SoapApi33Domain.CommandRequest();
      postCreditAdjustment = GTVSOAP133ReverseMappingService.mapPostAdjustment(
        creteRes,
        adjustment
      );
      postAddCredit = GTVAPI133Adapter.saveAdjustments(postCreditAdjustment);
    }
  }
  public static String tractCreateSalesOrder(Map<String, String> information) {
    Id accountId = information.get('AccountId');
    String tractAccountNumber = '';
    String tractAccounteid = '';
    String emessage;
    SoapApi33Domain.QueryResponse queryResponse;
    SoapApi33Domain.BillingAccount billingAccount1 = new SoapApi33Domain.BillingAccount();
    SoapApi33Domain.CreateResponse creteRes;
    SoapApi33Domain.CreateRequest createReq = new SoapApi33Domain.CreateRequest();
    tractAccountNumber = information.get('BillingAccountNum');
    tractAccounteid = information.get('BillingAccounteid');
    String oppId = information.get('OpportunityId');
    if (null != tractAccountNumber && tractAccountNumber != '') {
      queryResponse = GTVAPI133Adapter.queryBillingAccount(tractAccountNumber);
      if (
        queryResponse.successful &&
        null != queryResponse.billingAccounts &&
        null != queryResponse.billingAccounts.billingAccount &&
        queryResponse.billingAccounts.billingAccount.size() > 0
      ) {
        billingAccount1 = queryResponse.billingAccounts.billingAccount[0];
      } else {
        if (information.get('orderFromLightning') == 'true') {
          information.put(
            'ErrorMessage',
            'Unable to find Billing Account # ' +
            tractAccountNumber +
            ' Information in Tract'
          );
        } else
          throw new MyException(
            'Unable to find Billing Account # ' +
            tractAccountNumber +
            ' Information in Tract'
          );
      }
    } else {
      if (information.get('orderFromLightning') == 'true') {
        information.put(
          'ErrorMessage',
          'Account is not mapped with Tract Billing Account'
        );
      } else
        throw new MyException(
          'Account is not mapped with Tract Billing Account'
        );
    }
    String orderNum;
    String accountNum;
    try {
      createReq = GTVSOAP133ReverseMappingService.tractPlaceSalesOrder(
        billingAccount1,
        information
      );
      creteRes = GTVAPI133Adapter.createSalesOrder(createReq);
    } catch (Exception e) {
      emessage = string.valueof(e.getmessage());
      if (emessage.contains('Web')) {
        emessage = emessage.substringBetween(
          'Web service callout failed: WebService returned a SOAP Fault:',
          ' faultcode=soap:Server faultactor='
        );
      }
      if (information.get('orderFromLightning') == 'true') {
        information.put('ErrorMessage', emessage);
      } else {
        ApexPages.Message myMsg = new ApexPages.Message(
          ApexPages.Severity.ERROR,
          emessage
        );
        ApexPages.addMessage(myMsg);
      }
      return emessage;
    }

    if (creteRes.successful) {
      String returnEid = zConvert.toString(creteRes.eid).replace(',', '');
      queryResponse = GTVAPI133Adapter.getSalesOrdersByEid(returnEid);
    }
    if (queryResponse != null) {
      if (queryResponse.successful) {
        //queryResults = queryResponse.results;
        if (queryResponse.salesOrders.salesOrder != null) {
          orderNum = queryResponse.salesOrders.salesOrder[0].orderNum;
          accountNum = queryResponse.salesOrders.salesOrder[0]
            .billingAccount.accountNum;
          /*if(null != SrIdentifier && SrIdentifier != ''){
                        if((orderNum != null || orderNum != '' || orderNum != 'TRACT GENERATED') && (accountNum != null || accountNum != '' || accountNum != 'TRACT GENERATED')){
                            TractSFDC_Util.accountServiceResourceUpdateById(accountNum,SrIdentifier);
                        }
                    }*/
        } else {
          throw new MyException('Sales Order List is Empty from Tract');
        }
      } else {
        throw new MyException(
          'Unable to find Sales Order Information in Tract'
        );
      }
    }
    TractSFDC_Util.updateOpportunity(
      information.get('OpportunityId'),
      orderNum,
      accountNum
    );
    return null;
  }
  public static String tractCreateDraftOrder(Map<String, String> information) {
    SoapApi33Domain.CommandRequest createDraftOrderCmd = new SoapApi33Domain.CommandRequest();
    SoapApi33Domain.CommandResponse commandRes;
    String emessage;
    SoapApi33Domain.BillingAccount billingAccount1 = new SoapApi33Domain.BillingAccount();
    List<SoapApi33Domain.SalesOrder> salesOrders = new List<SoapApi33Domain.SalesOrder>();
    List<SoapApi33Domain.BillingAccount> billingAccounts = new List<SoapApi33Domain.BillingAccount>();
    /*
     * GET TRACT BILLING ACCOUNT */
    Id accountId = information.get('AccountId');
    String tractAccountNumber = information.get('BillingAccountNum');
    String tractAccounteid = information.get('BillingAccounteid');
    if (null != tractAccounteid && tractAccounteid != '') {
      billingAccount1.eid = tractAccounteid;
      billingAccount1.accountNum = information.get('BillingAccountNum');
    } else if (null != tractAccountNumber && tractAccountNumber != '') {
      billingAccounts = GTVAPI133Adapter.getBillingAccountByNumber(
        tractAccountNumber,
        'DEEP'
      );
      if (billingAccounts.size() > 0) {
        billingAccount1 = billingAccounts[0];
      } else {
        if (information.get('orderFromLightning') == 'true') {
          information.put(
            'ErrorMessage',
            'Unable to find Billing Account # ' +
            tractAccountNumber +
            ' Information in Tract'
          );
        } else
          throw new MyException(
            'Unable to find Billing Account # ' +
            tractAccountNumber +
            ' Information in Tract'
          );
      }
    } else {
      if (information.get('orderFromLightning') == 'true') {
        information.put(
          'ErrorMessage',
          'Account is not mapped with Tract Billing Account'
        );
      } else
        throw new MyException(
          'Account is not mapped with Tract Billing Account'
        );
    }
    String orderNum;
    String accountNum;
    try {
      createDraftOrderCmd = GTVSOAP133ReverseMappingService.tractPlaceDraftOrder(
        billingAccount1,
        information
      );
      commandRes = GTVAPI133Adapter.createDraftOrder(createDraftOrderCmd);
    } catch (Exception e) {
      emessage = string.valueof(e.getmessage());
      if (emessage.contains('Web')) {
        emessage = emessage.substringBetween(
          'Web service callout failed: WebService returned a SOAP Fault:',
          ' faultcode=soap:Server faultactor='
        );
      }
      if (information.get('orderFromLightning') == 'true') {
        information.put('ErrorMessage', emessage);
      } else {
        ApexPages.Message myMsg = new ApexPages.Message(
          ApexPages.Severity.ERROR,
          emessage
        );
        ApexPages.addMessage(myMsg);
      }
      return emessage;
    }
    if (commandRes.successful) {
      SoapApi33Domain.QueryResponse queryResponse;
      String returnEid = zConvert.toString(commandRes.orderResponse.eid)
        .replace(',', '');
      queryResponse = GTVAPI133Adapter.getSalesOrdersByEid(returnEid);
      salesOrders = GTVSOAP133MappingService.getSalesOrders(queryResponse);
    } else {
      if (information.get('orderFromLightning') == 'true') {
        information.put(
          'ErrorMessage',
          'Unable to create Draft Order in Tract.'
        );
      } else
        throw new MyException('Unable to create Draft Order in Tract.');
    }
    if (salesOrders != null) {
      if (salesOrders != null && salesOrders.size() > 0) {
        //queryResults = queryResponse.results;
        if (salesOrders.get(0) != null) {
          orderNum = salesOrders.get(0).orderNum;
          accountNum = salesOrders.get(0).billingAccount.accountNum;
        } else {
          throw new MyException('Sales Order List is Empty from Tract');
        }
      } else {
        throw new MyException(
          'Unable to find Sales Order Information in Tract'
        );
      }
    }
    TractSFDC_Util.updateOpportunity(
      information.get('OpportunityId'),
      orderNum,
      accountNum
    );
    return null;
  }

  /* Save Account Custom Field in GTV*/
  public String saveAccountCustomField(
    TRACTAccountWrapper tractBillingAccount,
    String customFildWrapper
  ) {
    String emessage;
    String accountEid;
    if (tractBillingAccount.eid != null) {
      accountEid = tractBillingAccount.eid;
    }
    List<SoapApi33Domain.CommandRequest> commandRequestList = new List<SoapApi33Domain.CommandRequest>();
    /*Deserializing the Wrapper from Lightning component */
    list<AccountCustomFieldWrapper> wrap = (list<AccountCustomFieldWrapper>) JSON.deserialize(
      customFildWrapper,
      List<AccountCustomFieldWrapper>.class
    );
    commandRequestList = GTVSOAP133ReverseMappingService.mapAccountCustomField(
      accountEid,
      wrap
    );
    if (commandRequestList.size() > 0) {
      emessage = GTVAPI133Adapter.saveAccountCustomField(commandRequestList);
    }
    return emessage;
  }

  /* Method to get list of order Items*/
  public static GTVSalesOrderDetailWrapper getOrderItemList(
    String orderNumber,
    String currencyType
  ) {
    SoapApi33Domain.QueryResponse orderItemQueryResponse;
    SoapApi33Domain.QueryResponse orderQueryResponse;
    SoapApi33Domain.QueryResponse serviceResourceQueryResponse;
    SoapApi33Domain.QueryResponse serviceQueryResponse;
    Decimal taxShow;
    Map<String, List<SoapApi33Domain.serviceResource>> mapOfOrderItemEidVSServiceResourceList = new Map<String, List<SoapApi33Domain.serviceResource>>();
    Map<String, List<SoapApi33Domain.Service>> mapOfOrderItemEidVSService = new Map<String, List<SoapApi33Domain.Service>>();
    GTVSalesOrderDetailWrapper salesOrderWrapper = new GTVSalesOrderDetailWrapper();
    orderItemQueryResponse = GTVAPI133Adapter.getOrderItemsList(orderNumber);
    if (
      orderItemQueryResponse.successful &&
      orderItemQueryResponse != null &&
      orderItemQueryResponse.orderItems != null
    ) {
      if (
        orderItemQueryResponse.orderItems.orderItem != null &&
        !orderItemQueryResponse.orderItems.orderItem.isEmpty()
      ) {
        orderQueryResponse = GTVAPI133Adapter.getOrderByOrderNumber(
          orderNumber
        );
        if (
          orderQueryResponse.successful &&
          null != orderQueryResponse.orders.salesOrder
        ) {
          taxShow = orderQueryResponse.orders.salesOrder.taxTotal.setScale(2);
        } else {
          taxShow = 0.00;
        }
        for (
          SoapApi33Domain.orderItem orderItem : orderItemQueryResponse.orderItems.orderItem
        ) {
          serviceResourceQueryResponse = GTVAPI133Adapter.getserviceResourcesByOrderItemEid(
            orderItem.eid
          );
          serviceQueryResponse = GTVAPI133Adapter.getServicesByOrderNumberAndOrderItemSequence(
            orderNumber,
            String.valueOf(orderItem.sequence)
          );
          if (
            serviceResourceQueryResponse.successful &&
            serviceResourceQueryResponse.serviceResources.serviceResource !=
            null
          ) {
            mapOfOrderItemEidVSServiceResourceList.put(
              orderItem.eid,
              serviceResourceQueryResponse.serviceResources.serviceResource
            );
          }
          if (
            serviceQueryResponse.successful &&
            null != serviceQueryResponse.services.service
          ) {
            mapOfOrderItemEidVSService.put(
              orderItem.eid,
              serviceQueryResponse.services.service
            );
          }
        }
        salesOrderWrapper = GTVSOAP133MappingService.mapOrderItems(
          orderItemQueryResponse.orderItems.orderItem,
          currencyType,
          taxShow,
          mapOfOrderItemEidVSServiceResourceList,
          mapOfOrderItemEidVSService
        );
      }
    }
    return salesOrderWrapper;
  }

  public TractServiceWrapper setUpServices(
    list<Account> accList,
    list<SelectOption> stateCan,
    list<SelectOption> stateMex,
    list<SelectOption> stateUsa,
    list<SelectOption> countryList,
    List<SelectOption> serviceReasons,
    List<SelectOption> suspendServicesReason,
    TRACTAccountWrapper tractBillingAccount,
    AccountDetailController_LT.ChargeRulesWrapper chargeRules,
    TRACT_Setup__c tract,
    Integer pagenumber
  ) {
    Account thisAccount = accList[0];
    TractServiceWrapper serviceWrapper = new TractServiceWrapper();
    SoapApi33Domain.QueryResponse servicesQueryResponse;
    SoapApi33Domain.QueryResponse serviceResourceResponse;
    Integer totalpage;
    Map<String, String> systemSettingAccountMap = new Map<String, String>();
    systemSettingAccountMap = getSystemSettingsMap();
    map<String, list<SoapApi33Domain.serviceResource>> servicesIDvsResoucesMap = new Map<String, list<SoapApi33Domain.serviceResource>>();
    servicesQueryResponse = GTVAPI133Adapter.queryServicesByBillingAccount(
      thisAccount,
      pageNumber
    );
    if (servicesQueryResponse.successful && servicesQueryResponse != null) {
      SoapApi33Domain.Service[] accountServices;
      if (
        servicesQueryResponse.successful &&
        null != servicesQueryResponse.services.service
      ) {
        accountServices = servicesQueryResponse.services.service;
        totalpage = servicesQueryResponse.services.totalPages;
      }
      serviceWrapper.totalPage = totalpage;
      if (accountServices != null && !accountServices.isEmpty()) {
        for (SoapApi33Domain.Service srv : accountServices) {
          if (
            srv.serviceResources != null &&
            srv.serviceResources.totalElements > 0
          ) {
            serviceResourceResponse = GTVAPI133Adapter.getserviceResourcesByServiceEid(
              srv.eid
            );
            if (
              serviceResourceResponse.serviceResources.serviceResource != null
            ) {
              servicesIDvsResoucesMap.put(
                srv.eid,
                serviceResourceResponse.serviceResources.serviceResource
              );
            }
          }
        }
        serviceWrapper = GTVSOAP133MappingService.mapBillingAccountServices(
          thisAccount,
          stateCan,
          stateMex,
          stateUsa,
          countryList,
          serviceReasons,
          suspendServicesReason,
          tractBillingAccount,
          chargeRules,
          tract,
          accountServices,
          servicesIDvsResoucesMap,
          totalpage,
          systemSettingAccountMap
        );
      }
    }
    return serviceWrapper;
  }
  /**
    
    * @return Object
    
    *@description - Method to get discounts Quick Add
    */
  public Object getDiscountsQuickAdd(String productWrapperString) {
    Product2AddWrapper productWrapper = (Product2AddWrapper) JSON.deserialize(
      productWrapperString,
      Product2AddWrapper.class
    );
    productWrapper.errorMessage = 'NoError';
    SoapApi33Domain.QueryResponse discountResponse;
    Object prodObject;
    String discountName = '';
    try {
      if (
        productWrapper.discountName != null &&
        productWrapper.discountName != ''
      ) {
        discountName = productWrapper.discountName.trim();
        productWrapper.discountName = productWrapper.discountName.trim();
      }
      discountResponse = GTVAPI133Adapter.getDisounts(discountName);
    } catch (exception e) {
      productWrapper.errorMessage = e.getmessage();
      return productWrapper;
    }
    prodObject = (Object) GTVSOAP133MappingService.mapDiscounts(
      productWrapper,
      discountResponse,
      discountName
    );
    return prodObject;
  }
  /**
    
    * @return Object
    
    *@description - Method to get discounts
    */
  public Object getDiscounts(String productWrapperString, String discountName) {
    Product2AddWrapper productWrapper = (Product2AddWrapper) JSON.deserialize(
      productWrapperString,
      Product2AddWrapper.class
    );
    productWrapper.errorMessage = 'NoError';
    SoapApi33Domain.QueryResponse discountResponse;
    Object prodObject;
    try {
      if (discountName != null && discountName != '') {
        discountName = discountName.trim();
      }
      discountResponse = GTVAPI133Adapter.getDisounts(discountName);
    } catch (exception e) {
      productWrapper.errorMessage = e.getmessage();
      return productWrapper;
    }
    prodObject = (Object) GTVSOAP133MappingService.mapDiscounts(
      productWrapper,
      discountResponse,
      discountName
    );
    return prodObject;
  }
  /**
    
    * @return ServiceResourceWrapper wrapper containing service resources by id
    
    *@description - Method to get service resources by id
    */
  public ServiceResourceWrapper getServiceResource(String srId) {
    ServiceResourceWrapper srWrapper = new ServiceResourceWrapper();
    SoapApi33Domain.QueryResponse serviceResourceResponse;
    srWrapper.errorMessage = 'NoError';
    serviceResourceResponse = GTVAPI133Adapter.getServiceResource(srId);
    if (
      serviceResourceResponse.successful &&
      serviceResourceResponse != null &&
      serviceResourceResponse.serviceResources != null &&
      serviceResourceResponse.serviceResources.serviceResource != null &&
      !serviceResourceResponse.serviceResources.serviceResource.isEmpty()
    ) {
      srWrapper = GTVSOAP133MappingService.mapServiceResource(
        serviceResourceResponse,
        srId,
        srWrapper
      );
    } else {
      srWrapper.errorMessage = srId + ' is an invalid service resource.';
    }
    return srWrapper;
  }
  /**
   * @return list<SelectOption> Map of reasons
   * @description - Method to get Deactivate Reasons
   */
  public list<SelectOption> getDeactivateReasons() {
    list<SelectOption> reasonList = new List<SelectOption>();
    SoapApi33Domain.QueryResponse reasonResponse;
    reasonResponse = GTVAPI133Adapter.getreasons();
    if (
      reasonResponse.successful &&
      reasonResponse != null &&
      reasonResponse.reasons != null
    ) {
      reasonList = GTVSOAP133MappingService.mapDeactivateReasons(
        reasonResponse
      );
    }
    return reasonList;
  }

  /**
   * @return list<SelectOption> Map of reasons
   * @description - Method to get Suspend Reasons
   */
  public list<SelectOption> getSuspendReasons() {
    list<SelectOption> reasonList = new List<SelectOption>();
    SoapApi33Domain.QueryResponse reasonResponse;
    reasonResponse = GTVAPI133Adapter.getreasons();
    if (
      reasonResponse.successful &&
      reasonResponse != null &&
      reasonResponse.reasons != null
    ) {
      reasonList = GTVSOAP133MappingService.mapSuspendReasons(reasonResponse);
    }
    return reasonList;
  }
  /**
   * @return list<SelectOption> Map of reasons
   * @description - Method to get Billing Account Status
   */
  public list<SelectOption> getBillingAccountStatus(String reasonFor) {
    list<SelectOption> reasonList = new List<SelectOption>();
    SoapApi33Domain.QueryResponse reasonResponse;
    reasonResponse = GTVAPI133Adapter.getreasons();
    if (
      reasonResponse.successful &&
      reasonResponse != null &&
      reasonResponse.reasons != null
    ) {
      reasonList = GTVSOAP133MappingService.mapBillingAccountChangeReason(
        reasonResponse,
        reasonFor
      );
    }
    return reasonList;
  }

  /**
   * @return list<SelectOption> Map of global usage rules
   * @description - Method to get FormulaUsageRules list
   */
  public list<SelectOption> getFormulaUsageRuleSpecificationListMethod() {
    list<SelectOption> formulaUsageRuleSpecificationList = new List<SelectOption>();
    SoapApi33Domain.QueryResponse formulaResponse;
    formulaResponse = GTVAPI133Adapter.getGlobalUsageRules();
    if (
      formulaResponse.successful &&
      formulaResponse != null &&
      formulaResponse.globalUsageRules != null
    ) {
      formulaUsageRuleSpecificationList = GTVSOAP133MappingService.mapGlobalUsageRules(
        formulaResponse
      );
    }
    return formulaUsageRuleSpecificationList;
  }

  /**
   * @return list<SelectOption> Map of usage price categories
   * @description - Method to get Chharge Category list
   */
  public list<SelectOption> getchargeCategoryListMethod() {
    list<SelectOption> chargeCategoryList = new List<SelectOption>();
    SoapApi33Domain.QueryResponse chargeCategoryResponse;
    chargeCategoryResponse = GTVAPI133Adapter.getusagePriceCategories();
    if (
      chargeCategoryResponse.successful &&
      chargeCategoryResponse != null &&
      chargeCategoryResponse.usagePriceCategories != null
    ) {
      chargeCategoryList = GTVSOAP133MappingService.mapUsagePriceCategories(
        chargeCategoryResponse
      );
    }
    return chargeCategoryList;
  }

  /**
   * @return list<SelectOption> Map of Rate tables
   * @description - Method to get Chharge Bytes Method
   */
  public list<SelectOption> getchargeListBytesMethod() {
    list<SelectOption> chargeListBytes = new List<SelectOption>();
    SoapApi33Domain.QueryResponse chargeCategoryResponse;
    chargeCategoryResponse = GTVAPI133Adapter.getRateTables();
    if (
      chargeCategoryResponse.successful &&
      chargeCategoryResponse != null &&
      chargeCategoryResponse.rateTables != null
    ) {
      chargeListBytes = GTVSOAP133MappingService.getchargeListBytes(
        chargeCategoryResponse
      );
    }
    return chargeListBytes;
  }

  /**
   * @return String errorMessgae
   * @description - Method to DEACTIVATE SERVICE
   */
  public String saveDeactivateService(
    String serviceEid,
    String reasonEid,
    String deactivationDate
  ) {
    String emessage = 'NoError';
    SoapApi33Domain.CommandRequest deactivateCurrentService = new SoapApi33Domain.CommandRequest();
    deactivateCurrentService = GTVSOAP133ReverseMappingService.mapDeactivateService(
      serviceEid,
      reasonEid,
      deactivationDate
    );
    SoapApi33Domain.CommandResponse commandResDeactivate;
    try {
      commandResDeactivate = GTVAPI133Adapter.getCommandresponse(
        deactivateCurrentService
      );
    } catch (Exception e) {
      emessage = string.valueof(e.getmessage() + e.getLineNumber());
      emessage = emessage.substringBetween(
        'Web service callout failed: WebService returned a SOAP Fault:',
        ' faultcode=soap:Server faultactor='
      );
    }
    return emessage;
  }

  /**
   * @return list<Price_List__c> list of pricelists
   * @description - Method to get pricelists from Gotransverse
   */
  public list<Price_List__c> getPriceLists(String marketPlaceId) {
    SoapApi33Domain.QueryResponse priceListQueryResponse;
    list<Price_List__c> priceLists = new List<Price_List__c>();
    priceListQueryResponse = GTVAPI133Adapter.getPriceLists(marketPlaceId);
    if (priceListQueryResponse != null) {
      priceLists = GTVSOAP133MappingService.parsePriceLists(
        priceListQueryResponse
      );
    }
    return priceLists;
  }

  /**
   * @return VOID
   * @description - Method to get system settings from Gotransverse
   */
  public list<System_Setting__c> getSystemSettings() {
    SoapApi33Domain.QueryResponse systemSettingsQueryResponse;
    list<System_Setting__c> systemSettingListToInsert = new List<System_Setting__c>();
    systemSettingsQueryResponse = GTVAPI133Adapter.getSystemSettings();
    if (systemSettingsQueryResponse != null) {
      systemSettingListToInsert = GTVSOAP133MappingService.parseSystemSettingsResponse(
        systemSettingsQueryResponse
      );
    }
    return systemSettingListToInsert;
  }

  /**
   * @return VOID
   * @description - Method to get system settings from Gotransverse
   */
  public Map<String, String> getSystemSettingsMap() {
    SoapApi33Domain.QueryResponse systemSettingsQueryResponse;
    Map<String, String> systemSettingMap = new Map<String, String>();
    systemSettingsQueryResponse = GTVAPI133Adapter.getSystemSettings();
    if (systemSettingsQueryResponse != null) {
      systemSettingMap = GTVSOAP133MappingService.mapSystemSettings(
        systemSettingsQueryResponse
      );
    }
    return systemSettingMap;
  }

  /**
   * @return VOID
   * @description - Method to make test callouts to Gotransverse
   */
  public void queryPriceListsForTestingConnection(TRACT_Setup__c tractConfig) {
    GTVAPI133Adapter.queryPriceListsForTestingConnection(tractConfig);
  }

  /**
   * @return List<DiscountCodeWrapper> wrapper containing discount codes
   * @description - Method to get Discount Code by productId
   */
  public List<DiscountCodeWrapper> getDiscountCodesByProduct(
    String productEid
  ) {
    List<DiscountCodeWrapper> productDiscountCodeList = new List<DiscountCodeWrapper>();
    SoapApi33Domain.QueryResponse discountCodeQueryResponse;
    discountCodeQueryResponse = GTVAPI133Adapter.getDiscountCodesByProduct(
      productEid
    );
    if (
      discountCodeQueryResponse.successful && discountCodeQueryResponse != null
    ) {
      productDiscountCodeList = GTVSOAP133MappingService.parseDiscountCode(
        discountCodeQueryResponse
      );
    }
    return productDiscountCodeList;
  }

  /**
   * @return List<Tract_Service_Custom_Field__c> list of service custom fields
   * @description - Method to get service custom fields by product id
   */
  public List<Tract_Service_Custom_Field__c> getServiceCustomFieldByProduct(
    String productEid
  ) {
    SoapApi33Domain.QueryResponse queryResponse;
    List<Tract_Service_Custom_Field__c> serviceCustomFieldList = new List<Tract_Service_Custom_Field__c>();
    queryResponse = GTVAPI133Adapter.queryServiceCustomFieldsByProduct(
      productEid
    );
    if (null != queryResponse) {
      serviceCustomFieldList = GTVSOAP133MappingService.parseServiceCustomFields(
        queryResponse
      );
    }
    return serviceCustomFieldList;
  }

  /**
   * @return ServiceResourceWrapper wrapper containing service resources
   * @description - Method to get service resource by id
   */
  public ServiceResourceWrapper getServiceResourceById(String srId) {
    ServiceResourceWrapper srWrapper = new ServiceResourceWrapper();
    SoapApi33Domain.QueryResponse queryResponse;
    queryResponse = GTVAPI133Adapter.queryServiceResourceById(srId);
    if (queryResponse.successful && null != queryResponse) {
      srWrapper = GTVSOAP133MappingService.mapServiceResource(
        queryResponse,
        srId
      );
    }
    return srWrapper;
  }

  /**
   * @return Object
   * @description - Get all the Global Usage Rules
   */
  public Object getAllGlobalUsageRule() {
    SoapApi33Domain.QueryResponse queryResponse;
    Object formulaUsageRuleList;
    queryResponse = GTVAPI133Adapter.getGlobalUsageRules();
    if (queryResponse.successful && null != queryResponse) {
      formulaUsageRuleList = (Object) GTVSOAP133MappingService.mapGlobalUsageRules(
        queryResponse
      );
    }
    return formulaUsageRuleList;
  }

  /**
   * @return Object
   * @description - Get all the charge Bytes
   */
  public Object getAllChargeBytes() {
    SoapApi33Domain.QueryResponse queryResponse;
    Object chargeListBytes;
    queryResponse = GTVAPI133Adapter.getRateTables();
    if (queryResponse.successful && null != queryResponse) {
      chargeListBytes = (Object) GTVSOAP133MappingService.getchargeListBytes(
        queryResponse
      );
    }
    return chargeListBytes;
  }

  /**
   * @return Object
   * @description - Get all the charge Categories
   */
  public Object getAllChargeCategory() {
    SoapApi33Domain.QueryResponse queryResponse;
    Object chargeListBytes;
    queryResponse = GTVAPI133Adapter.getusagePriceCategories();
    if (queryResponse.successful && null != queryResponse) {
      chargeListBytes = (Object) GTVSOAP133MappingService.mapUsagePriceCategories(
        queryResponse
      );
    }
    return chargeListBytes;
  }

  /**
   * @return RenewServiceWrapper Get all the Billing Account Services
   * @description - Method to Get all the Billing Account Services
   */
  public RenewServiceWrapper showServices(
    list<Account> accList,
    String serviceRenewEid
  ) {
    SoapApi33Domain.QueryResponse serviceResponse;
    SoapApi33Domain.QueryResponse queryResponseAgreement;
    Account thisAccount = accList[0];
    RenewServiceWrapper serviceWrapper = new RenewServiceWrapper();
    serviceResponse = GTVAPI133Adapter.getBillingAccountServices(thisAccount);
    if (
      serviceResponse.successful &&
      serviceResponse != null &&
      serviceResponse.services != null
    ) {
      serviceWrapper = GTVSOAP133MappingService.parseServices(
        serviceResponse,
        serviceRenewEid
      );
    }
    if (serviceWrapper.serviceProductEid != null) {
      queryResponseAgreement = GTVAPI133Adapter.getAgreements(
        serviceWrapper.serviceProductEid
      );
      if (
        queryResponseAgreement.successful &&
        queryResponseAgreement != null &&
        queryResponseAgreement.agreements != null
      ) {
        serviceWrapper = GTVSOAP133MappingService.mapServiceAgreements(
          queryResponseAgreement,
          serviceWrapper
        );
      }
    }
    return serviceWrapper;
  }

  /**
   * @return Set<String> get related product
   * @description - method to get related product Id for the particular product
   */
  public Set<String> getRelatedProductIdSet(String productEid) {
    Set<String> relatedProductIdSet = new Set<String>();
    SoapApi33Domain.QueryResponse queryResponse;
    queryResponse = GTVAPI133Adapter.queryProductRelationByProduct(productEid);
    if (queryResponse.successful && queryResponse != null) {
      relatedProductIdSet = GTVSOAP133MappingService.getRelatedProductIdList(
        queryResponse
      );
    }
    return relatedProductIdSet;
  }

  /**
   * @return  void
   * @description - method to create new Activity Charge RUle
   */
  public void createNewActivityChargeRule(
    ProductServiceWrapper serviceWrapper
  ) {
    SoapApi33Domain.CommandRequest newChargeRule = new SoapApi33Domain.CommandRequest();
    SoapApi33Domain.CommandResponse commandResChargeRule;
    Map<String, String> rateTableVsUomMap = new Map<String, String>();
    System.debug(
      'serviceWrapper.chargeRuleWrapper.chargeListBytesValue' +
      serviceWrapper.chargeRuleWrapper.chargeListBytesValue
    );
    if (
      serviceWrapper.chargeRuleWrapper.chargeListBytesValue != null &&
      serviceWrapper.chargeRuleWrapper.chargeListBytesValue != ' '
    ) {
      String uom = getUOMRateTable(
        serviceWrapper.chargeRuleWrapper.chargeListBytesValue
      );
      rateTableVsUomMap.put(
        serviceWrapper.chargeRuleWrapper.ServiceUsageRuleName,
        uom
      );
    }
    newChargeRule = GTVSOAP133ReverseMappingService.mapNewActivityChargeRule(
      serviceWrapper,
      rateTableVsUomMap
    );
    commandResChargeRule = GTVAPI133Adapter.createActivityChargeRule(
      newChargeRule
    );
  }

  /**
   * @return  list<String> get related product map
   * @description - mothod to get the related product by product
   */
  public list<String> getRelatedProductNameByProductCode(String productEid) {
    list<String> listofRelatedProduct = new List<String>();
    SoapApi33Domain.QueryResponse queryResponse;
    queryResponse = GTVAPI133Adapter.queryProductRelationByProduct(productEid);
    if (queryResponse.successful && queryResponse != null) {
      listofRelatedProduct = GTVSOAP133MappingService.getRelatedProductNameList(
        queryResponse
      );
    }
    return listofRelatedProduct;
  }

  /**
   * @return  TractServiceWrapper service details
   * @description - Method to get Service realted to a billing account
   */
  public TractServiceWrapper getServiceByBillingAccount(List<Account> accList) {
    Account sfdcAccount;
    if (accList.size() > 0) {
      sfdcAccount = accList[0];
    }
    TractServiceWrapper billingAccountServiceWrapper = new TractServiceWrapper();
    SoapApi33Domain.QueryResponse queryResponse;
    queryResponse = GTVAPI133Adapter.queryBillingAccountService(sfdcAccount);
    if (queryResponse.successful && queryResponse != null) {
      billingAccountServiceWrapper = GTVSOAP133MappingService.parseBillingAccountServices(
        queryResponse
      );
    }
    return billingAccountServiceWrapper;
  }

  /**
   * @return  List<String> query child products relations
   * @description - Method to get products relation by product Id
   */
  public set<String> getRelatedChidProducts(String productEid) {
    set<String> setofRelatedProduct = new Set<String>();
    SoapApi33Domain.QueryResponse queryResponse;
    queryResponse = GTVAPI133Adapter.queryProductRelationByProduct(productEid);
    if (queryResponse.successful && queryResponse != null) {
      setofRelatedProduct = GTVSOAP133MappingService.getRelatedChildProductNameList(
        queryResponse
      );
    }
    return setofRelatedProduct;
  }

  /**
   * @return  List<GTVOneTimeOrderItemWrapper> wrapper containing one time order items
   * @description - Method to get one time order items
   */
  public List<GTVOneTimeOrderItemWrapper> getOneTimeOrderItemList(
    TRACTAccountWrapper sfdcAccountWrapper
  ) {
    List<GTVOneTimeOrderItemWrapper> oneTimeOrderItemWrapperList = new List<GTVOneTimeOrderItemWrapper>();
    SoapApi33Domain.QueryResponse queryResponse;
    queryResponse = GTVAPI133Adapter.queryOrderByAccountNumber(
      sfdcAccountWrapper.TractBillingAccountNumber
    );
    if (
      queryResponse.successful &&
      queryResponse != null &&
      queryResponse.SalesOrders.salesOrder != null
    ) {
      oneTimeOrderItemWrapperList = GTVSOAP133MappingService.parseOneTimeOrderItem(
        queryResponse,
        sfdcAccountWrapper.accountCurrency
      );
    }
    return oneTimeOrderItemWrapperList;
  }

  /**
   * @return InvoiceDetailWrapper wrapper containing invoice details
   * @description - Method to get Invoices from Gotransverse
   */
  public InvoiceDetailWrapper getInvoiceByNumber(InvoiceWrapper wrapperObj) {
    InvoiceDetailWrapper invoiceWrap = new InvoiceDetailWrapper();
    SoapApi33Domain.QueryResponse queryResponse;
    queryResponse = GTVAPI133Adapter.getInvoicesNumber(wrapperObj.Name);
    if (null != queryResponse) {
      invoiceWrap = GTVSOAP133MappingService.parseInvoiceDetail(
        queryResponse,
        wrapperObj
      );
    }
    return invoiceWrap;
  }

  /**
   * @return ServiceDetailWrapper wrapper containing service details
   * @description - method to query Order items by service Id
   */
  public ServiceDetailWrapper getServiceById(
    ProductServiceWrapper serviceWrapper
  ) {
    ServiceDetailWrapper servDetail = new ServiceDetailWrapper();
    SoapApi33Domain.QueryResponse queryResponse;
    SoapApi33Domain.QueryResponse serviceResponse;
    SoapApi33Domain.QueryResponse discountResponse;
    queryResponse = GTVAPI133Adapter.getOrderItemByServiceEid(
      serviceWrapper.serviceEid
    );
    if (queryResponse != null) {
      servDetail = GTVSOAP133MappingService.mapServiceDetails(queryResponse);
    }
    servDetail.usageRuleInf = showUsageRule(serviceWrapper.serviceEid);
    serviceResponse = GTVAPI133Adapter.queryService(serviceWrapper.serviceEid);
    if (serviceResponse != null) {
      SoapApi33Domain.Service serviceResponseMap = serviceResponse.services.service[0];
      if (serviceResponseMap.status == 'SERVICE_ACTIVE') {
        servDetail.status = 'ACTIVE';
      } else if (serviceResponseMap.status == 'SERVICE_DEACTIVATED') {
        servDetail.status = 'DEACTIVATED';
      } else if (serviceResponseMap.status == 'SERVICE_SUSPENDED') {
        servDetail.status = 'SUSPENDED';
      }
      servDetail.startDate = Date.valueOf(serviceResponseMap.startDate);
      servDetail.endDate = Date.valueOf(serviceResponseMap.endDate);
      if (serviceResponseMap.addresses.postalAddress != null) {
        servDetail.addressInf = GTVSOAP133MappingService.mapServiceAddress(
          serviceResponseMap
        );
      }
    }
    discountResponse = GTVAPI133Adapter.queryDiscountCodeServices(
      serviceWrapper.serviceEid
    );
    if (null != discountResponse) {
      servDetail.discountInf = GTVSOAP133MappingService.mapServiceDiscount(
        discountResponse
      );
    }
    return servDetail;
  }

  /**
   * @return List<SelectOption> map of Currency type
   * @description - method to query Currency type
   */
  public list<SelectOption> getCurrencyType() {
    list<SelectOption> listOfCurrencyType = new List<SelectOption>();
    SoapApi33Domain.QueryResponse currencyTypeQueryResponse;
    currencyTypeQueryResponse = GTVAPI133Adapter.getCurrencyType();
    if (currencyTypeQueryResponse != null) {
      listOfCurrencyType = GTVSOAP133MappingService.mapCurrencyType(
        currencyTypeQueryResponse
      );
    }
    return listOfCurrencyType;
  }

  /**
   * @return List<SelectOption> map of Product Categories
   * @description - method to query Product Categories
   */
  public list<SelectOption> queryProductCategories() {
    List<SelectOption> productCategoryList = new List<SelectOption>();
    SoapApi33Domain.QueryResponse productCategoryQueryResponse;
    productCategoryQueryResponse = GTVAPI133Adapter.queryProductCategories();
    if (
      productCategoryQueryResponse.successful &&
      productCategoryQueryResponse != null &&
      productCategoryQueryResponse.productCategories.productCategories != null
    ) {
      productCategoryList = GTVSOAP133MappingService.mapProductCategories(
        productCategoryQueryResponse
      );
    }
    return productCategoryList;
  }

  /**
   * @return List<SelectOption> map of Service Resource Categories
   * @description - method to query Service Resource Categories
   */
  public list<SelectOption> queryServiceResourceCategories() {
    List<SelectOption> serviceResourceCategoryList = new List<SelectOption>();
    SoapApi33Domain.QueryResponse serviceResourceCategoryQueryResponse;
    serviceResourceCategoryQueryResponse = GTVAPI133Adapter.queryServiceResourceCategories();
    if (
      serviceResourceCategoryQueryResponse.successful &&
      serviceResourceCategoryQueryResponse != null &&
      serviceResourceCategoryQueryResponse.serviceResourceCategories.serviceResourceCategory !=
      null
    ) {
      serviceResourceCategoryList = GTVSOAP133MappingService.mapServiceResourceCategories(
        serviceResourceCategoryQueryResponse
      );
    }
    return serviceResourceCategoryList;
  }

  /**
   * @return List<SelectOption> map of product Tags
   * @description - method to query Prodyct Tags
   */
  public list<SelectOption> queryProductTags() {
    List<SelectOption> productTagList = new List<SelectOption>();
    SoapApi33Domain.QueryResponse productTagQueryResponse;
    productTagQueryResponse = GTVAPI133Adapter.queryProductTags();
    if (
      productTagQueryResponse.successful &&
      productTagQueryResponse != null &&
      productTagQueryResponse.productTags.productTags != null
    ) {
      productTagList = GTVSOAP133MappingService.mapProductTags(
        productTagQueryResponse
      );
    }
    return productTagList;
  }

  /**
   * @return String error message
   * @description - method to create GTV product
   */
  public String createGtvProduct(CreateProductWrapper createProductWrapper) {
    String emessage = 'NoError';
    SoapApi33Domain.Product[] productQueryResponse;
    SoapApi33Domain.CreateResponse creteRes;
    SoapApi33Domain.CreateRequest createReq = new SoapApi33Domain.CreateRequest();
    try {
      createReq = GTVSOAP133ReverseMappingService.mapCreateGTVProduct(
        createProductWrapper
      );
      creteRes = GTVAPI133Adapter.createGTVProduct(createReq);
      if (creteRes != null) {
        system.debug('productEid::::::' + creteRes.eid);

        productQueryResponse = GTVAPI133Adapter.queryProductbyEid(
          String.valueOf(creteRes.eid)
        );
        system.debug('productQueryResponse::::::' + productQueryResponse);
        GTVSOAP133MappingService.mapProductCreationResponse(
          productQueryResponse[0],
          createProductWrapper
        );
      }
    } catch (Exception e) {
      emessage = string.valueof(e.getmessage());
      return emessage;
    }
    return emessage;
  }

  /**
   * @return List<SelectOption> map of product Type code
   * @description - method to query Prodyct Type code
   */
  public List<SelectOption> getProductTypeCode() {
    List<SelectOption> productTypeList = new List<SelectOption>();
    productTypeList.add(new selectOption('', 'Choose One'));
    productTypeList.add(new selectOption('ADDON', 'Add-on'));
    productTypeList.add(new selectOption('GENERAL_PRODUCT', 'One-Time'));
    productTypeList.add(new selectOption('SUBSCRIPTION', 'Subscription'));
    return productTypeList;
  }

  /**
   * @return List<SelectOption> map of product Type
   * @description - method to query Prodyct Types
   */

  public list<SelectOption> queryProductRegisterTypes() {
    List<SelectOption> productRegisterTypeList = new List<SelectOption>();
    SoapApi33Domain.QueryResponse productRegisterTypesQueryResponse;
    /*productRegisterTypesQueryResponse = GTVAPI133Adapter.queryProductRegisterTypes();
        if(productRegisterTypesQueryResponse.successful && productRegisterTypesQueryResponse != null && productRegisterTypesQueryResponse.productTags.productTags != null){
          //productRegisterTypeList = GTVSOAP133MappingService.mapProductTags(productTagQueryResponse);
        } */
    return productRegisterTypeList;
  }

  /**
   * @return List<ProductAgreementWrapper> get Agreements Wrapper
   * @description - method to get al agreements
   */
  public List<ProductAgreementWrapper> getAllAgreements() {
    list<ProductAgreementWrapper> listOfAgreements = new List<ProductAgreementWrapper>();
    SoapApi33Domain.QueryResponse queryResponse;
    queryResponse = GTVAPI133Adapter.queryAgreements();
    if (null != queryResponse) {
      listOfAgreements = GTVSOAP133MappingService.mapAllAgreements(
        queryResponse
      );
    }
    return listOfAgreements;
  }

  /**
   * @return void
   * @description - method to set agreements to a product
   */
  public void setProductAgreement(
    List<ProductAgreementWrapper> agreementList,
    String productId
  ) {
    List<SoapApi33Domain.CommandRequest> commandRequestList = new List<SoapApi33Domain.CommandRequest>();
    commandRequestList = GTVSOAP133ReverseMappingService.mapProductNewAgreements(
      agreementList,
      productId
    );
    if (commandRequestList.size() > 0) {
      String emessage = GTVAPI133Adapter.addAllAgreements(commandRequestList);
      system.debug('emessage::::::::' + emessage);
    }
  }

  /**
   * @return list<SelectOption> get recurrence map
   * @description - method to get recurrence map
   */
  public list<SelectOption> getRecurrencePeriod() {
    List<SelectOption> recurrencePeriodList = new List<SelectOption>();
    recurrencePeriodList.add(new selectOption('', 'Choose One'));
    recurrencePeriodList.add(new selectOption('BILLCYCLE', 'BILLCYCLE'));
    recurrencePeriodList.add(new selectOption('DAY', 'DAY'));
    recurrencePeriodList.add(new selectOption('FOURYEARS', 'FOURYEARS'));
    recurrencePeriodList.add(new selectOption('FIVEYEARS', 'FIVEYEARS'));
    recurrencePeriodList.add(new selectOption('MONTH', 'MONTH'));
    recurrencePeriodList.add(new selectOption('QUARTER', 'QUARTER'));
    recurrencePeriodList.add(new selectOption('THREEYEARS', 'THREEYEARS'));
    recurrencePeriodList.add(new selectOption('TWELVEWEEKS', 'TWELVEWEEKS'));
    recurrencePeriodList.add(new selectOption('TWICEAMONTH', 'TWICEAMONTH'));
    recurrencePeriodList.add(new selectOption('TWICEAYEAR', 'TWICEAYEAR'));
    recurrencePeriodList.add(new selectOption('TWOWEEKS', 'TWOWEEKS'));
    recurrencePeriodList.add(new selectOption('TWOYEARS', 'TWOYEARS'));
    recurrencePeriodList.add(new selectOption('WEEK', 'WEEK'));
    recurrencePeriodList.add(new selectOption('YEAR', 'YEAR'));
    recurrencePeriodList.add(new selectOption('FOURMONTHS', 'FOURMONTHS'));

    return recurrencePeriodList;
  }

  /**
   * @return void
   * @description - method to remove agreement relation
   */
  public void removeAgreementRelation(
    String productId,
    ProductAgreementWrapper agreementWrap
  ) {
    SoapApi33Domain.CommandRequest commandRequest = new SoapApi33Domain.CommandRequest();
    SoapApi33Domain.CommandResponse res;
    commandRequest = GTVSOAP133ReverseMappingService.mapProductAgreementsRelation(
      agreementWrap,
      productId
    );
    if (commandRequest != null) {
      res = GTVAPI133Adapter.removeAgreements(commandRequest);
    }
  }

  /**
   * @return list<SelectOption> map of price Categories
   * @description - method to query price Groups
   */
  public list<SelectOption> getProductPriceGroup() {
    List<SelectOption> productPriceGroupList = new List<SelectOption>();
    return productPriceGroupList;
  }

  /**
   * @return list<SelectOption> map of price Categories
   * @description - method to query price Categories
   */
  public list<SelectOption> queryPriceCategories() {
    List<SelectOption> priceCategoryList = new List<SelectOption>();
    SoapApi33Domain.QueryResponse queryResponse;
    queryResponse = GTVAPI133Adapter.queryPriceCatogories();
    if (queryResponse != null) {
      priceCategoryList = GTVSOAP133MappingService.mapPriceCategories(
        queryResponse
      );
    }
    return priceCategoryList;
  }

  /**
   * @params createProductPriceWrapper Recurring product Price wrapper
   * @params priceListId pricelist Id
   * @return String, errorMessage if any
   *@description - method to create Recurring TIme price of a product
   */
  public String createGtvRecurringProductPrice(
    CreateRecurringChargePriceWrapper createProductPriceWrapper,
    String priceListId
  ) {
    String emessage = 'NoError';
    SoapApi33Domain.CommandRequest commandRequest = new SoapApi33Domain.CommandRequest();
    SoapApi33Domain.CommandResponse res;
    SoapApi33Domain.QueryResponse productPriceCreationResponse;
    try {
      commandRequest = GTVSOAP133ReverseMappingService.mapRecurringProductPrice(
        createProductPriceWrapper,
        priceListId
      );
      if (commandRequest != null) {
        res = GTVAPI133Adapter.addProductPrice(commandRequest);
        if (res.successful && res.addResponse != null) {
          //productPriceCreationResponse = GTVAPI133Adapter.queryProductPrice(res.addResponse.eid);
          if (priceListId == null) {
            productPriceCreationResponse = GTVAPI133Adapter.queryProductPrice(
              createProductPriceWrapper.productId
            );
          } else {
            productPriceCreationResponse = GTVAPI133Adapter.queryProductPriceForPriceList(
              priceListId,
              createProductPriceWrapper.productId
            );
          }
          if (productPriceCreationResponse != null) {
            GTVSOAP133MappingService.mapProductPriceCreationResponse(
              createProductPriceWrapper.sfdcProductId,
              productPriceCreationResponse,
              priceListId
            );
          }
        }
      }
    } catch (Exception e) {
      emessage = string.valueof(e.getmessage());
      return emessage;
    }

    return emessage;
  }

  public String updateGtvRecurringProductPrice(
    CreateRecurringChargePriceWrapper createProductPriceWrapper,
    String priceListId
  ) {
    String emessage = 'NoError';
    SoapApi33Domain.CommandRequest commandRequest = new SoapApi33Domain.CommandRequest();
    SoapApi33Domain.CommandResponse res;
    SoapApi33Domain.QueryResponse productPriceCreationResponse;
    try {
      commandRequest = GTVSOAP133ReverseMappingService.mapRecurringProductPrice(
        createProductPriceWrapper,
        priceListId
      );
      if (commandRequest != null) {
        res = GTVAPI133Adapter.addProductPrice(commandRequest);
        if (res.successful && res.addResponse != null) {
          //productPriceCreationResponse = GTVAPI133Adapter.queryProductPrice(res.addResponse.eid);
          if (priceListId == null) {
            productPriceCreationResponse = GTVAPI133Adapter.queryProductPrice(
              createProductPriceWrapper.productId
            );
          } else {
            productPriceCreationResponse = GTVAPI133Adapter.queryProductPriceForPriceList(
              priceListId,
              createProductPriceWrapper.productId
            );
          }
          if (productPriceCreationResponse != null) {
            GTVSOAP133MappingService.mapProductPriceCreationResponse(
              createProductPriceWrapper.sfdcProductId,
              productPriceCreationResponse,
              priceListId
            );
          }
        }
      }
    } catch (Exception e) {
      emessage = string.valueof(e.getmessage());
      return emessage;
    }

    return emessage;
  }

  /**
   * @params productId Id of a product to activate
   * @return void
   *@description - method to activate a product
   */
  public void makeProductAvailable(String productId) {
    SoapApi33Domain.CommandRequest commandRequest = new SoapApi33Domain.CommandRequest();
    SoapApi33Domain.CommandResponse res;
    commandRequest = GTVSOAP133ReverseMappingService.mapActivateProduct(
      productId
    );
    if (commandRequest != null) {
      res = GTVAPI133Adapter.activateProduct(commandRequest);
    }
  }

  /**
   * @params createOneTimeProductPriceWrapper One Time product Price wrapper
   * @params priceListId pricelist Id
   * @return String, errorMessage if any
   *@description - method to create one TIme price of a product
   */
  public String createGtvOneTimeProductPrice(
    CreateOneTimeChargePriceWrapper createOneTimeProductPriceWrapper,
    String priceListId
  ) {
    String emessage = 'NoError';
    SoapApi33Domain.CommandRequest commandRequest = new SoapApi33Domain.CommandRequest();
    SoapApi33Domain.CommandResponse res;
    SoapApi33Domain.QueryResponse productPriceCreationResponse;
    try {
      commandRequest = GTVSOAP133ReverseMappingService.mapOneTimeProductPrice(
        createOneTimeProductPriceWrapper,
        priceListId
      );
      if (commandRequest != null) {
        res = GTVAPI133Adapter.addProductPrice(commandRequest);
        if (res.successful && res.addResponse != null) {
          if (res.successful && res.addResponse != null) {
            //productPriceCreationResponse = GTVAPI133Adapter.queryProductPrice(res.addResponse.eid);
            if (priceListId == null) {
              productPriceCreationResponse = GTVAPI133Adapter.queryProductPrice(
                createOneTimeProductPriceWrapper.productId
              );
            } else {
              productPriceCreationResponse = GTVAPI133Adapter.queryProductPriceForPriceList(
                priceListId,
                createOneTimeProductPriceWrapper.productId
              );
            }
            if (productPriceCreationResponse != null) {
              GTVSOAP133MappingService.mapProductPriceCreationResponse(
                createOneTimeProductPriceWrapper.sfdcProductId,
                productPriceCreationResponse,
                priceListId
              );
            }
          }
        }
      }
    } catch (Exception e) {
      emessage = string.valueof(e.getmessage());
      return emessage;
    }
    return emessage;
  }

  /**
   * @params productEid product Eid
   * @return list<productCustomFieldValueWrapper> product Custom Field wrapper list
   * @description - method to query product Custom Field
   */
  public list<ProductCustomFieldWrapper> queryProductCustomFields(
    String productId
  ) {
    List<ProductCustomFieldWrapper> productCustomFieldList = new List<ProductCustomFieldWrapper>();
    return ProductCustomFieldList;
  }

  /**
   * @params productEid product Eid
   * @return list<productCustomFieldValueWrapper> product Custom Field wrapper list
   *@description - method to query product Custom Field
   */
  public list<productCustomFieldValueWrapper> queryProductCustomFieldValues(
    String productEid
  ) {
    List<productCustomFieldValueWrapper> productCustomFieldValueList = new List<productCustomFieldValueWrapper>();
    return productCustomFieldValueList;
  }

  /**
   * @params productEid product Eid
   * @params customFildWrapper wrapper containing custom fields
   * @return String error message If any
   * @description - method to save custom field values
   */
  public String saveProductCustomFieldValues(
    String productEid,
    String customFildWrapper
  ) {
    String emessage = 'No error';
    return emessage;
  }

  /**
   * @return list<MarketPlaceWrapper> wrapper containing marketplace Information
   * @description - method to query marketplace
   */
  public list<MarketPlaceWrapper> getMarketPlace() {
    List<MarketPlaceWrapper> marketPlaceValueList = new List<MarketPlaceWrapper>();
    SoapApi33Domain.QueryResponse marketPlaceQueryResponse;
    marketPlaceQueryResponse = GTVAPI133Adapter.queryMarketPlaces();
    if (
      marketPlaceQueryResponse.successful &&
      marketPlaceQueryResponse != null &&
      marketPlaceQueryResponse.marketPlaces.marketPlace != null
    ) {
      marketPlaceValueList = GTVSOAP133MappingService.mapMarketPlaces(
        marketPlaceQueryResponse
      );
    }
    return marketPlaceValueList;
  }

  /**
   * @params marketPlaceWrap wrapper containing marketplaces
   * @return list<PriceListWrapper> pricelist based on marketplaces
   * @description - method to query pricelist for marketplaces
   */
  public list<PriceListWrapper> getMarketPlacePriceList(
    MarketPlaceWrapper marketPlaceWrap
  ) {
    List<PriceListWrapper> marketPlacePriceListValueList = new List<PriceListWrapper>();
    SoapApi33Domain.QueryResponse marketPlacePriceListQueryResponse;
    marketPlacePriceListQueryResponse = GTVAPI133Adapter.queryPriceListsByMarketPlaceEid(
      marketPlaceWrap.mplaceId
    );
    if (
      marketPlacePriceListQueryResponse.successful &&
      marketPlacePriceListQueryResponse != null &&
      marketPlacePriceListQueryResponse.priceLists.priceList != null
    ) {
      marketPlacePriceListValueList = GTVSOAP133MappingService.mapMarketPlacePriceList(
        marketPlacePriceListQueryResponse
      );
    }
    return marketPlacePriceListValueList;
  }

  /**
   * @params priceListEid PriceList Id
   * @params selectedProducts products list
   * @return void
   *@description - method to add product from a pricelist
   */
  public void addProductToPriceList(
    String priceListEid,
    list<String> selectedProducts
  ) {
    String emessage = 'No error';
    List<SoapApi33Domain.CommandRequest> commandRequestList = new List<SoapApi33Domain.CommandRequest>();
    commandRequestList = GTVSOAP133ReverseMappingService.addProductToPriceListRequest(
      priceListEid,
      selectedProducts
    );
    if (commandRequestList.size() > 0) {
      emessage = GTVAPI133Adapter.addProductToPriceList(commandRequestList);
      if (emessage == 'No error') {
        TractSFDC_Util.addPriceListToProduct(selectedProducts, priceListEid);
      }
    }
  }

  /**
   * @params priceListEid PriceList Id
   * @params selectedProducts products list
   * @return void
   * @description - method to remove product from a pricelist
   */
  public void removeProductToPriceList(
    String priceListEid,
    list<String> selectedProducts
  ) {
    String emessage = 'No error';
    List<SoapApi33Domain.CommandRequest> commandRequestList = new List<SoapApi33Domain.CommandRequest>();
    commandRequestList = GTVSOAP133ReverseMappingService.removeProductFromPriceListRequest(
      priceListEid,
      selectedProducts
    );
    if (commandRequestList.size() > 0) {
      emessage = GTVAPI133Adapter.removeProductFromPriceList(
        commandRequestList
      );
      if (emessage == 'No error') {
        TractSFDC_Util.removePriceListFromProduct(
          selectedProducts,
          priceListEid
        );
      }
    }
  }

  /**
   * @params mPlaceId Marketplace Id
   * @return void
   * @description - method to remove marketplace
   */
  public void removeThisMarketPlace(String mPlaceId) {
    SoapApi33Domain.CommandRequest commandRequest = new SoapApi33Domain.CommandRequest();
    commandRequest = GTVSOAP133ReverseMappingService.deleteMarketPlaceRequest(
      mPlaceId
    );
    GTVAPI133Adapter.deleteMarketPlace(commandRequest);
  }

  /**
   * @params productId Id of the Product
   * @return list<ProductRelationWrapper> product relation  by product wrapper
   * @description -Method to query product relation  from a given product
   */
  public list<ProductRelationWrapper> queryProductRelation(String productEid) {
    list<ProductRelationWrapper> productRelationWrapperList = new List<ProductRelationWrapper>();
    SoapApi33Domain.QueryResponse productRelationQueryResponse;
    productRelationQueryResponse = GTVAPI133Adapter.queryProductRelationByProduct(
      productEid
    );
    if (
      productRelationQueryResponse.successful &&
      productRelationQueryResponse != null
    ) {
      productRelationWrapperList = GTVSOAP133MappingService.mapProductRelation(
        productRelationQueryResponse
      );
    }
    return productRelationWrapperList;
  }

  /**
   * @params productId Id of the Product
   * @params ProductRelationWrapper wrapper containing product relations
   * @return void
   * @description -Method to remove product relation  from a given product
   */
  public void removeProductRelation(
    String productId,
    ProductRelationWrapper relationWrap
  ) {
    SoapApi33Domain.CommandRequest commandRequest = new SoapApi33Domain.CommandRequest();
    commandRequest = GTVSOAP133ReverseMappingService.deleteProductRelationRequest(
      productId,
      relationWrap
    );
    GTVAPI133Adapter.deleteProductRelation(commandRequest);
  }

  /**
   * @params accountEid,Account Id
   * @return list<TRACTAccountWrapper> child account details
   * @description -Method to get child billing account hierarchy from Gotransverse
   */
  public list<TRACTAccountWrapper> getChildDetails(String accountEid) {
    list<TRACTAccountWrapper> sfdcBillingAccountWrapperList = new List<TRACTAccountWrapper>();
    SoapApi33Domain.QueryResponse queryResponse;
    queryResponse = GTVAPI133Adapter.queryChildAccounts(accountEid);
    if (queryResponse.successful && queryResponse != null) {
      sfdcBillingAccountWrapperList = GTVSOAP133MappingService.parseChildAccountList(
        queryResponse
      );
    }
    return sfdcBillingAccountWrapperList;
  }

  /**
   * @params responsibleAccountEid,Account Id
   * @return BillingHierarchyWrapper
   * @description -Method to getaccount billing hierarcy from Gotransverse
   */
  public BillingHierarchyWrapper queryBillingHierarchy(
    String responsibleAccountEid
  ) {
    BillingHierarchyWrapper billingHierarchyWrap = new BillingHierarchyWrapper();
    SoapApi33Domain.QueryResponse queryResponse;
    queryResponse = GTVAPI133Adapter.queryBillingAccountsByResponsibleAccountEid(
      responsibleAccountEid
    );
    if (queryResponse.successful && queryResponse != null) {
      billingHierarchyWrap = GTVSOAP133MappingService.mapResponsibleAccounts(
        queryResponse
      );
    }
    return billingHierarchyWrap;
  }

  /**
   * @return string, Marketplace Eid
   * @description -Method to get default marketplace from Gotransverse
   */
  public string getDefaultMarketPlaceId() {
    SoapApi33Domain.QueryResponse marketPlaceQueryResponse;
    marketPlaceQueryResponse = GTVAPI133Adapter.queryMarketPlaces();
    if (
      marketPlaceQueryResponse.successful &&
      marketPlaceQueryResponse != null &&
      marketPlaceQueryResponse.marketPlaces.marketPlace != null
    ) {
      if (
        marketPlaceQueryResponse.marketPlaces.marketPlace != null &&
        marketPlaceQueryResponse.marketPlaces.marketPlace.size() > 0
      ) {
        return marketPlaceQueryResponse.marketPlaces.marketPlace[0].eid;
      }
    }
    return null;
  }

  /**
   * @params tractConfig TRACT Version
   * @return List<SelectOption>, map of marketplace Id vs names
   * @description -Method to get all the marketplaces from Gotransverse
   */
  public List<SelectOption> getAllMarketPlace(TRACT_Setup__c tractConfig) {
    list<SelectOption> listOfMarketPlace = new List<SelectOption>();
    SoapApi33Domain.QueryResponse marketPlaceQueryResponse;
    marketPlaceQueryResponse = GTVAPI133Adapter.queryMarketPlaces(tractConfig);
    if (
      marketPlaceQueryResponse.successful &&
      marketPlaceQueryResponse != null &&
      marketPlaceQueryResponse.marketPlaces.marketPlace != null
    ) {
      listOfMarketPlace = GTVSOAP133MappingService.mapMarketplaceResponse(
        marketPlaceQueryResponse
      );
    }
    return listOfMarketPlace;
  }

  /**
   * @params srId Service resource Id
   * @return String, error message if any
   * @description -Method to check whether or not the service resource exists
   */
  public String checkExistingServicesource(String srId) {
    String emessage = 'NoError';
    SoapApi33Domain.QueryResponse queryResponse;
    queryResponse = GTVAPI133Adapter.queryServiceResourceById(srId);
    if (
      queryResponse.successful &&
      null != queryResponse &&
      queryResponse.serviceResources.serviceResource != null
    ) {
      emessage = 'Entered Service Identifier already exists in system.';
    }
    return emessage;
  }
  public CreateAccountResponse createAccountGlobalAction(
    Id accountId,
    String billingAccountString
  ) {
    CreateAccountResponse accountRes = GTVAPI133Adapter.globalActionCalloutForAccountCreation(
      accountId,
      billingAccountString
    );
    return accountRes;
  }

  public CreateOrderResponse createOrderGlobalAction(
    Map<String, String> information
  ) {
    CreateOrderResponse orderRes = new CreateOrderResponse();
    Id accountId = information.get('AccountId');
    String tractAccountNumber = '';
    String tractAccounteid = '';
    String emessage;
    SoapApi33Domain.CommandRequest createDraftOrderCmd = new SoapApi33Domain.CommandRequest();
    SoapApi33Domain.CommandResponse commandRes;
    SoapApi33Domain.QueryResponse queryResponse;
    SoapApi33Domain.BillingAccount billingAccount1 = new SoapApi33Domain.BillingAccount();
    SoapApi33Domain.CreateResponse creteRes;
    List<SoapApi33Domain.SalesOrder> salesOrders = new List<SoapApi33Domain.SalesOrder>();
    SoapApi33Domain.CreateRequest createReq = new SoapApi33Domain.CreateRequest();
    tractAccountNumber = information.get('BillingAccountNum');
    tractAccounteid = information.get('BillingAccounteid');
    String oppId = information.get('OpportunityId');
    if (null != tractAccountNumber && tractAccountNumber != '') {
      queryResponse = GTVAPI133Adapter.queryBillingAccount(tractAccountNumber);
      if (
        queryResponse.successful &&
        null != queryResponse.billingAccounts &&
        null != queryResponse.billingAccounts.billingAccount &&
        queryResponse.billingAccounts.billingAccount.size() > 0
      ) {
        billingAccount1 = queryResponse.billingAccounts.billingAccount[0];
      } else {
        orderRes.responseMessage =
          'Unable to find Billing Account # ' +
          tractAccountNumber +
          ' Information in Tract';
        orderRes.responseSuccess = false;
      }
    } else {
      orderRes.responseMessage = 'Account is not mapped with Tract Billing Account';
      orderRes.responseSuccess = false;
    }
    String orderNum;
    String accountNum;
    try {
      if (information.get('OrderStatus') == 'DRAFT') {
        createDraftOrderCmd = GTVSOAP133ReverseMappingService.tractPlaceDraftOrder(
          billingAccount1,
          information
        );
        commandRes = GTVAPI133Adapter.createDraftOrder(createDraftOrderCmd);
      } else {
        createReq = GTVSOAP133ReverseMappingService.tractPlaceSalesOrder(
          billingAccount1,
          information
        );
        creteRes = GTVAPI133Adapter.createSalesOrder(createReq);
      }
    } catch (Exception e) {
      emessage = string.valueof(e.getmessage());
      if (emessage.contains('Web')) {
        emessage = emessage.substringBetween(
          'Web service callout failed: WebService returned a SOAP Fault:',
          ' faultcode=soap:Server faultactor='
        );
      }
      orderRes.responseMessage = emessage;
      orderRes.responseSuccess = false;
      return orderRes;
    }

    if (information.get('OrderStatus') != 'DRAFT' && creteRes.successful) {
      String returnEid = zConvert.toString(creteRes.eid).replace(',', '');
      queryResponse = GTVAPI133Adapter.getSalesOrdersByEid(returnEid);
      if (queryResponse != null) {
        if (queryResponse.successful) {
          if (queryResponse.salesOrders.salesOrder != null) {
            orderNum = queryResponse.salesOrders.salesOrder[0].orderNum;
            accountNum = queryResponse.salesOrders.salesOrder[0]
              .billingAccount.accountNum;
            orderRes.gtvOrderId = returnEid;
            orderRes.responseSuccess = true;
          } else {
            orderRes.responseMessage = 'Sales Order List is Empty from Tract';
            orderRes.responseSuccess = false;
          }
        } else {
          orderRes.responseMessage = 'Unable to find Sales Order Information in Tract';
          orderRes.responseSuccess = false;
        }
      }
    }
    String returnDraftOrderEid;
    if (information.get('OrderStatus') == 'DRAFT' && commandRes.successful) {
      returnDraftOrderEid = zConvert.toString(commandRes.orderResponse.eid)
        .replace(',', '');
      queryResponse = GTVAPI133Adapter.getSalesOrdersByEid(returnDraftOrderEid);
      salesOrders = GTVSOAP133MappingService.getSalesOrders(queryResponse);
    } else {
      orderRes.responseMessage = 'Unable to create Draft Order in Tract.';
      orderRes.responseSuccess = false;
    }
    if (salesOrders != null) {
      if (salesOrders != null && salesOrders.size() > 0) {
        if (salesOrders.get(0) != null) {
          orderNum = salesOrders.get(0).orderNum;
          accountNum = salesOrders.get(0).billingAccount.accountNum;
          orderRes.gtvOrderId = returnDraftOrderEid;
          orderRes.responseSuccess = true;
        } else {
          orderRes.responseMessage = ' Sales Order List is Empty from Tract';
          orderRes.responseSuccess = false;
        }
      } else {
        orderRes.responseMessage = ' Unable to find Sales Order Information in Tract';
        orderRes.responseSuccess = false;
      }
    }
    return orderRes;
  }
  public list<ProductUsesWrapper> getProductChargeRules(
    String prodEid,
    String recurringPriceId
  ) {
    list<ProductUsesWrapper> usgaeWrapList = new List<ProductUsesWrapper>();
    SoapApi33Domain.QueryResponse productUsageQueryResponse;
    productUsageQueryResponse = GTVAPI133Adapter.queryProductUsageRules(
      recurringPriceId
    );
    if (
      productUsageQueryResponse.successful &&
      null != productUsageQueryResponse &&
      null != productUsageQueryResponse.productUsageRules
    ) {
      usgaeWrapList = GTVSOAP133MappingService.mapProductUsageRules(
        productUsageQueryResponse
      );
    }
    return usgaeWrapList;
  }
  public void createChargeRules(
    String productEid,
    String recurringPriceId,
    ProductChargeRuleWrapper ruleWrapper
  ) {
    SoapApi33Domain.CommandRequest newChargeRule = new SoapApi33Domain.CommandRequest();
    SoapApi33Domain.CommandResponse commandResChargeRule;
    Map<String, String> rateTableVsUomMap = new Map<String, String>();
    if (
      ruleWrapper.chargeListBytesValue != null &&
      ruleWrapper.chargeListBytesValue != ' '
    ) {
      String uom = getUOMRateTable(ruleWrapper.chargeListBytesValue);
      rateTableVsUomMap.put(ruleWrapper.productUsageRuleName, uom);
    }
    newChargeRule = GTVSOAP133ReverseMappingService.mapNewProductActivityChargeRule(
      ruleWrapper,
      rateTableVsUomMap,
      recurringPriceId
    );
    commandResChargeRule = GTVAPI133Adapter.createActivityChargeRule(
      newChargeRule
    );
  }
  public String getPaymentRefererToken() {
    String referrerToken = '';
    SoapApi33Domain.CommandRequest paymentReferrerTokenRequest = new SoapApi33Domain.CommandRequest();
    SoapApi33Domain.CommandResponse paymentReferrerTokenResponse;
    paymentReferrerTokenRequest = GTVSOAP133ReverseMappingService.generatePaymentReferrerTokenRequest();
    paymentReferrerTokenResponse = GTVAPI133Adapter.getPaymentReferrerToken(
      paymentReferrerTokenRequest
    );
    if (
      null != paymentReferrerTokenResponse &&
      paymentReferrerTokenResponse.successful &&
      null != paymentReferrerTokenResponse.generatedReferrerToken
    ) {
      referrerToken = paymentReferrerTokenResponse.generatedReferrerToken.referrerToken;
    }
    return referrerToken;
  }
  public String generatePaymentToken(Map<String, Object> paymentDataMap) {
    return null;
  }
  public String createRecurringPayment(
    String token,
    String billingAccountEid,
    boolean isAutoPayment
  ) {
    return null;
  }
  public String createBillingPayment(
    Map<String, Object> mapOfPaymentData,
    String billingAccountEid
  ) {
    SoapApi33Domain.CreateResponse creteRes;
    SoapApi33Domain.CreateRequest paymentCreationRequest = new SoapApi33Domain.CreateRequest();
    paymentCreationRequest = GTVSOAP133ReverseMappingService.getPayentCreationRequest(
      mapOfPaymentData,
      billingAccountEid
    );
    creteRes = GTVAPI133Adapter.createPayment(paymentCreationRequest);
    if (null != creteRes && creteRes.successful) {
    }
    return 'Payment Successfully Created';
  }
  public GTVPaymentWrapper getPaymentMethodAsSelectOption(
    String gtvBillingAccountNumber
  ) {
    SoapApi33Domain.QueryResponse paymentMethodsQueryResponse;
    GTVPaymentWrapper paymentWrap = new GTVPaymentWrapper();
    paymentMethodsQueryResponse = GTVAPI133Adapter.getpaymentMethodRecords(
      gtvBillingAccountNumber
    );
    if (null != paymentMethodsQueryResponse) {
      paymentWrap = GTVSOAP133MappingService.parsePaymentMethods(
        paymentMethodsQueryResponse
      );
    }
    return paymentWrap;
  }
}