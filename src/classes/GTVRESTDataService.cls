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
 * This class Fetch the data using REST API's and Maps the datafetched in salesforce object and wrapper class.
 * @author AMAN JAIN
 */

public with sharing class GTVRESTDataService implements APIDataService {
  /**
   * @description: Query a BillingAccount from GTV db and return UI wrapper after mapping the API response
   * @param sfdcAccountId The Salesforce Account object Id
   * @return TRACTAccountWrapper The billing account wrapper to be used on UI
   * @throws GTVAPIRestClient.ApiException if fails to make API call
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
    TRACTAccountWrapper sfdcBillingAccountWrapper;
    Map<String, Object> paramsMap = new Map<String, Object>();
    //prepare parameters for API callout
    paramsMap.put('accountNum', sfdcAccount.Tract_Billing_Account__c);
    //make the API callout
    GTVAPIRestClient.ResponseWrapper apiCallOutResponse = GTVAPI2Adapter.querybillingAccount(
      paramsMap
    );
    //type cast the response from object to RestAPI2Domain billing account wrapper
    RestAPI2Domain.GTVAPIBillingAccount tractBillingAccount = ((List<RestAPI2Domain.GTVAPIBillingAccount>) apiCallOutResponse.returnObject)[0];
    if (null != tractBillingAccount) {
      //call the method to parse the domain wrapper and mapp to the UI wrapper
      sfdcBillingAccountWrapper = GTVRESTMappingService.parseBillingAccount(
        tractBillingAccount
      );
    }
    return sfdcBillingAccountWrapper;
  }

  /**
   * @description: Query payments for BillingAccount from GTV db and return UI wrapper after mapping the API response
   * @param sfdcAccountWrapper TRACTAccountWrapper Instance
   * @param pageNumber to be set while Querying Entity
   * @return TractPaymentWrapper The billing account payment wrapper to be used on UI
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public TractPaymentWrapper getPayments(
    TRACTAccountWrapper sfdcAccountWrapper,
    Integer pageNumber
  ) {
    TractPaymentWrapper sfdcPaymentWrapper;
    Map<String, Object> paymentQueryParamsMap = new Map<String, Object>();
    Map<String, Object> paymentApplicationsQueryParamsMap = new Map<String, Object>();
    List<RestAPI2Domain.GTVAPIPaymentApplication> tractPaymentApplicationList;
    //prepare the param for querying payments from GTV db
    paymentQueryParamsMap.put('id', sfdcAccountWrapper.eid);
    paymentQueryParamsMap.put('pageNumber', pageNumber);
    //query payments from GTV db
    GTVAPIRestClient.ResponseWrapper apiCallOutPaymentResponse = GTVAPI2Adapter.queryPayments(
      paymentQueryParamsMap
    );
    //type cast the response from Object to domain payments wrapper
    List<RestAPI2Domain.GTVAPIPayment> tractPaymentsList = (List<RestAPI2Domain.GTVAPIPayment>) apiCallOutPaymentResponse.returnObject;
    paymentApplicationsQueryParamsMap.put(
      'billingAccountId',
      sfdcAccountWrapper.eid
    );
    paymentApplicationsQueryParamsMap.put('pageNumber', 1);
    //query payment aplications from GTV db
    GTVAPIRestClient.ResponseWrapper apiCallOutPaymentApplicationResponse = GTVAPI2Adapter.queryPaymentApplications(
      paymentApplicationsQueryParamsMap
    );

    //type cast the API response
    tractPaymentApplicationList = (List<RestAPI2Domain.GTVAPIPaymentApplication>) apiCallOutPaymentApplicationResponse.returnObject;
    Integer totalPages = Integer.valueOf(
      apiCallOutPaymentApplicationResponse.totalPages
    );
    //check if there are more than one page in the response
    if (totalPages > 1) {
      for (Integer count = 2; count <= totalPages; count++) {
        //make API callouts to get each page
        Map<String, Object> paymentApplicationsQueryParamsMapInLoop = new Map<String, Object>();
        paymentApplicationsQueryParamsMap.put(
          'billingAccountId',
          sfdcAccountWrapper.eid
        );
        paymentApplicationsQueryParamsMap.put('pageNumber', count);
        GTVAPIRestClient.ResponseWrapper apiCallOutPaymentApplicationResponseInLoop = GTVAPI2Adapter.queryPaymentApplications(
          paymentApplicationsQueryParamsMap
        );
        tractPaymentApplicationList.addAll(
          (List<RestAPI2Domain.GTVAPIPaymentApplication>) apiCallOutPaymentApplicationResponseInLoop.returnObject
        );
      }
    }
    //call the method from mapping class to parse the domain wrapper and map values to UI wrapper
    sfdcPaymentWrapper = GTVRESTMappingService.parsePayments(
      tractPaymentsList,
      tractPaymentApplicationList,
      sfdcAccountWrapper.accountCurrency
    );
    //set total pages
    sfdcPaymentWrapper.totalPage = Integer.valueOf(
      apiCallOutPaymentResponse.totalPages
    );
    return sfdcPaymentWrapper;
  }

  /**
   * @description: Query invoices for BillingAccount from GTV db and return UI wrapper after mapping the API response
   * @param sfdcAccountWrapper TRACTAccountWrapper Instance
   * @param pageNumber to be set while Querying Entity
   * @return TractInvoiceWrapper The billing account invoice wrapper to be used on UI
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public TractInvoiceWrapper getInvoices(
    TRACTAccountWrapper sfdcAccountWrapper,
    Integer pageNumber
  ) {
    TractInvoiceWrapper sfdcInvoiceWrapperObj = new TractInvoiceWrapper();
    Map<String, Object> invoiceQueryParamsMap = new Map<String, Object>();
    invoiceQueryParamsMap.put('pageNumber', pageNumber);
    invoiceQueryParamsMap.put(
      'accountNum',
      sfdcAccountWrapper.TractBillingAccountNumber
    );
    GTVAPIRestClient.ResponseWrapper apiCallOutInvoiceResponse = GTVAPI2Adapter.queryInvoices(
      invoiceQueryParamsMap
    );
    List<RestAPI2Domain.GTVAPIInvoice> tractInvoiceList = (List<RestAPI2Domain.GTVAPIInvoice>) apiCallOutInvoiceResponse.returnObject;
    if (null != tractInvoiceList && !tractInvoiceList.isEmpty()) {
      sfdcInvoiceWrapperObj = GTVRESTMappingService.parseInvoices(
        tractInvoiceList,
        sfdcAccountWrapper.accountCurrency
      );
    }
    sfdcInvoiceWrapperObj.totalPage = Integer.valueOf(
      apiCallOutInvoiceResponse.totalPages
    );
    return sfdcInvoiceWrapperObj;
  }

  /**
   * @description: Query invoices Pdf from GTV db and return Blob response
   * @param invoiceNumber GTV Invoice Number
   * @return Blob The blob response for invoice pdf
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public Blob downloadInvoices(String invoiceNumber) {
    Blob pdfContent;
    Map<String, Object> invoiceQueryParamsMap = new Map<String, Object>();
    invoiceQueryParamsMap.put('id', invoiceNumber);
    GTVAPIRestClient.ResponseWrapper responseInvoice = GTVAPI2Adapter.downloadInvoices(
      invoiceQueryParamsMap
    );
    pdfContent = (Blob) responseInvoice.returnObject;
    return pdfContent;
  }

  /**
   * @description: Query Debit Adjustments from GTV db and return UI wrapper after mapping the API response
   * @param sfdcAccountWrapper TRACTAccountWrapper Instance
   * @param pageNumber to be set while Querying Entity
   * @return TractAdjustmentWrapper The billing account adjustment wrapper to be used on UI
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public TractAdjustmentWrapper getDebitAdjustments(
    TRACTAccountWrapper sfdcAccountWrapper,
    Integer pageNumber
  ) {
    TractAdjustmentWrapper sfdcDebitAdjustmentsWrapperObj = new TractAdjustmentWrapper();
    Map<String, Object> debitAdjustmentQueryParamsMap = new Map<String, Object>();
    debitAdjustmentQueryParamsMap.put('pageNumber', pageNumber);
    debitAdjustmentQueryParamsMap.put(
      'accountNum',
      sfdcAccountWrapper.TractBillingAccountNumber
    );
    GTVAPIRestClient.ResponseWrapper apiCallOutDebitAdjustmentsResponse = GTVAPI2Adapter.queryDebitAdjustments(
      debitAdjustmentQueryParamsMap
    );
    List<RestAPI2Domain.GTVAPIDebitAccountAdjustment> tractDebitAdjustmentsList = (List<RestAPI2Domain.GTVAPIDebitAccountAdjustment>) apiCallOutDebitAdjustmentsResponse.returnObject;
    if (
      null != tractDebitAdjustmentsList && !tractDebitAdjustmentsList.isEmpty()
    ) {
      sfdcDebitAdjustmentsWrapperObj = GTVRESTMappingService.parseDebitAdjustments(
        tractDebitAdjustmentsList,
        sfdcAccountWrapper.accountCurrency
      );
    }
    sfdcDebitAdjustmentsWrapperObj.totalPage = Integer.valueOf(
      apiCallOutDebitAdjustmentsResponse.totalPages
    );
    return sfdcDebitAdjustmentsWrapperObj;
  }

  /**
   * @description: Query Credit Adjustments from GTV db and return UI wrapper after mapping the API response
   * @param sfdcAccountWrapper TRACTAccountWrapper Instance
   * @param pageNumber to be set while Querying Entity
   * @return TractAdjustmentWrapper The billing account adjustment wrapper to be used on UI
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public TractAdjustmentWrapper getCreditAdjustments(
    TRACTAccountWrapper sfdcAccountWrapper,
    Integer pageNumber
  ) {
    TractAdjustmentWrapper sfdcCreditAdjustmentsWrapperObj = new TractAdjustmentWrapper();
    Map<String, Object> creditAdjustmentQueryParamsMap = new Map<String, Object>();
    creditAdjustmentQueryParamsMap.put('pageNumber', pageNumber);
    creditAdjustmentQueryParamsMap.put(
      'accountNum',
      sfdcAccountWrapper.TractBillingAccountNumber
    );
    GTVAPIRestClient.ResponseWrapper apiCallOutCreditAdjustmentsResponse = GTVAPI2Adapter.queryCreditAdjustments(
      creditAdjustmentQueryParamsMap
    );
    List<RestAPI2Domain.GTVAPICreditAccountAdjustment> tractCreditAdjustmentsList = (List<RestAPI2Domain.GTVAPICreditAccountAdjustment>) apiCallOutCreditAdjustmentsResponse.returnObject;
    if (
      null != tractCreditAdjustmentsList &&
      !tractCreditAdjustmentsList.isEmpty()
    ) {
      sfdcCreditAdjustmentsWrapperObj = GTVRESTMappingService.parseCreditAdjustments(
        tractCreditAdjustmentsList,
        sfdcAccountWrapper.accountCurrency
      );
    }
    sfdcCreditAdjustmentsWrapperObj.totalPage = Integer.valueOf(
      apiCallOutCreditAdjustmentsResponse.totalPages
    );
    return sfdcCreditAdjustmentsWrapperObj;
  }

  /**
   * @description: Query Notes from GTV db and return UI wrapper after mapping the API response
   * @param sfdcAccountWrapper TRACTAccountWrapper Instance
   * @param pageNumber to be set while Querying Entity
   * @return TRACTNoteWrapper The billing account contact wrapper to be used on UI
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public TRACTNoteWrapper getNotes(
    TRACTAccountWrapper tractBillingAccount,
    Integer pageNumber
  ) {
    TRACTNoteWrapper notesWrapperObj = new TRACTNoteWrapper();
    return notesWrapperObj;
  }

  /**
   * @description: Query Contacts from GTV db and return UI wrapper after mapping the API response
   * @param sfdcAccountWrapper TRACTAccountWrapper Instance
   * @param pageNumber to be set while Querying Entity
   * @return TRACTContactWrapper The billing account contact wrapper to be used on UI
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public TRACTContactWrapper getContacts(
    TRACTAccountWrapper sfdcAccountWrapper,
    Integer pageNumber
  ) {
    TRACTContactWrapper sfdcContactsWrapperObj = new TRACTContactWrapper();
    Map<String, Object> contactsQueryParamsMap = new Map<String, Object>();
    contactsQueryParamsMap.put('pageNumber', pageNumber);
    contactsQueryParamsMap.put(
      'accountNum',
      sfdcAccountWrapper.TractBillingAccountNumber
    );
    GTVAPIRestClient.ResponseWrapper apiCallOutContactsResponse = GTVAPI2Adapter.queryPersons(
      contactsQueryParamsMap
    );
    List<RestAPI2Domain.GTVAPIPerson> tractContactsList = (List<RestAPI2Domain.GTVAPIPerson>) apiCallOutContactsResponse.returnObject;
    if (null != tractContactsList && !tractContactsList.isEmpty()) {
      sfdcContactsWrapperObj = GTVRESTMappingService.parseContacts(
        tractContactsList
      );
    }
    sfdcContactsWrapperObj.totalPage = Integer.valueOf(
      apiCallOutContactsResponse.totalPages
    );
    return sfdcContactsWrapperObj;
  }

  /**
   * @description: Query Payment methods from GTV db and return UI wrapper after mapping the API response
   * @param sfdcAccountWrapper TRACTAccountWrapper Instance
   * @param pageNumber to be set while Querying Entity
   * @return TRACTPaymentMethodWrapper The billing account payment method wrapper to be used on UI
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public TRACTPaymentMethodWrapper getPaymentMethods(
    TRACTAccountWrapper sfdcAccountWrapper,
    Integer pageNumber
  ) {
    TRACTPaymentMethodWrapper sfdcPaymentMethodWrapperObj = new TRACTPaymentMethodWrapper();
    Map<String, Object> paymentMethodQueryParamsMap = new Map<String, Object>();
    paymentMethodQueryParamsMap.put('pageNumber', pageNumber);
    paymentMethodQueryParamsMap.put(
      'accountNum',
      sfdcAccountWrapper.TractBillingAccountNumber
    );
    GTVAPIRestClient.ResponseWrapper apiCallOutPaymentMethodResponse = GTVAPI2Adapter.queryPaymentMethods(
      paymentMethodQueryParamsMap
    );
    List<RestAPI2Domain.GTVAPIRecurringPayment> tractPaymentMethodList = (List<RestAPI2Domain.GTVAPIRecurringPayment>) apiCallOutPaymentMethodResponse.returnObject;
    if (null != tractPaymentMethodList && !tractPaymentMethodList.isEmpty()) {
      sfdcPaymentMethodWrapperObj = GTVRESTMappingService.parsePaymentMethodRecords(
        tractPaymentMethodList
      );
    }
    system.debug('sfdcPaymentMethodWrapperObj::' + sfdcPaymentMethodWrapperObj);
    sfdcPaymentMethodWrapperObj.totalPage = Integer.valueOf(
      apiCallOutPaymentMethodResponse.totalPages
    );
    return sfdcPaymentMethodWrapperObj;
  }

  /**
   * @description: Query Payment methods from GTV db and return UI wrapper after mapping the API response
   * @param sfdcAccountWrapper TRACTAccountWrapper Instance
   * @param pageNumber to be set while Querying Entity
   * @return TractSalesOrderWrapper The billing account payment method wrapper to be used on UI
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public TractSalesOrderWrapper getSalesOrders(
    TRACTAccountWrapper sfdcAccountWrapper,
    Integer pageNumber
  ) {
    TractSalesOrderWrapper sfdcSalesOrdersWrapperObj = new TractSalesOrderWrapper();
    Map<String, Object> salesOrdersQueryParamsMap = new Map<String, Object>();
    salesOrdersQueryParamsMap.put('pageNumber', pageNumber);
    salesOrdersQueryParamsMap.put(
      'accountNum',
      sfdcAccountWrapper.TractBillingAccountNumber
    );
    GTVAPIRestClient.ResponseWrapper apiCallOutSalesOrdersResponse = GTVAPI2Adapter.querySalesOrders(
      salesOrdersQueryParamsMap
    );
    List<RestAPI2Domain.GTVAPIOrder> tractSalesOrdersList = (List<RestAPI2Domain.GTVAPIOrder>) apiCallOutSalesOrdersResponse.returnObject;
    if (null != tractSalesOrdersList && !tractSalesOrdersList.isEmpty()) {
      sfdcSalesOrdersWrapperObj = GTVRESTMappingService.parseSalesOrders(
        tractSalesOrdersList
      );
    }
    sfdcSalesOrdersWrapperObj.totalPage = Integer.valueOf(
      apiCallOutSalesOrdersResponse.totalPages
    );
    return sfdcSalesOrdersWrapperObj;
  }
  /**
   * @description: Query Usage Events from GTV db and return UI wrapper after mapping the API response
   * @param sfdcAccountWrapper TRACTAccountWrapper Instance
   * @param pageNumber to be set while Querying Entity
   * @return ActivityEventsWrapper The billing account activity event wrapper to be used on UI
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public ActivityEventsWrapper getUsagesEvents(
    TRACTAccountWrapper sfdcAccountWrapper,
    Integer pagenumber
  ) {
    ActivityEventsWrapper eventWrapperObj = new ActivityEventsWrapper();
    Map<String, Object> sactivityUsageQueryParamsMap = new Map<String, Object>();
    sactivityUsageQueryParamsMap.put('pageNumber', pageNumber);
    sactivityUsageQueryParamsMap.put(
      'accountNum',
      sfdcAccountWrapper.TractBillingAccountNumber
    );
    sactivityUsageQueryParamsMap.put('closed', false);
    GTVAPIRestClient.ResponseWrapper apiCallOutActivityUsageResponse = GTVAPI2Adapter.queryUsageEvents(
      sactivityUsageQueryParamsMap
    );
    List<RestAPI2Domain.GTVAPIUsageEvent> tractUsageEventsList = (List<RestAPI2Domain.GTVAPIUsageEvent>) apiCallOutActivityUsageResponse.returnObject;
    if (null != tractUsageEventsList && !tractUsageEventsList.isEmpty()) {
      eventWrapperObj = GTVRESTMappingService.parseUsageEvents(
        tractUsageEventsList,
        sfdcAccountWrapper.accountCurrency
      );
    }
    eventWrapperObj.size = Integer.valueOf(
      apiCallOutActivityUsageResponse.totalPages
    );
    return eventWrapperObj;
  }

  /**
   * @description: Query Bill Cycles from GTV db and return UI wrapper after mapping the API response
   * @return List<TRACT_Bill_Cycle__c> The list of TRACT_Bill_Cycle__c Salesforce object.
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public List<TRACT_Bill_Cycle__c> getBillCycles() {
    List<TRACT_Bill_Cycle__c> listOfActiveBillCycles = new List<TRACT_Bill_Cycle__c>();
    Map<String, Object> billCyclesQueryParamsMap = new Map<String, Object>();
    billCyclesQueryParamsMap.put('status', 'ACTIVE');
    GTVAPIRestClient.ResponseWrapper billCyclesResponse = GTVAPI2Adapter.queryBillCycles(
      billCyclesQueryParamsMap
    );
    List<RestAPI2Domain.GTVAPIBillCycle> tractBillCycleList = (List<RestAPI2Domain.GTVAPIBillCycle>) billCyclesResponse.returnObject;
    if (Integer.valueOf(billCyclesResponse.totalPages) > 1) {
      for (
        integer i = 2; i <= Integer.valueOf(billCyclesResponse.totalPages); i++
      ) {
        Map<String, Object> billCyclesQueryParamsLoopMap = new Map<String, Object>();
        billCyclesQueryParamsLoopMap.put('status', 'ACTIVE');
        billCyclesQueryParamsLoopMap.put('pageNumber', i);
        GTVAPIRestClient.ResponseWrapper billCyclesResponseInLoop = GTVAPI2Adapter.queryBillCycles(
          billCyclesQueryParamsLoopMap
        );
        tractBillCycleList.addall(
          (List<RestAPI2Domain.GTVAPIBillCycle>) billCyclesResponseInLoop.returnObject
        );
      }
    }
    if (null != tractBillCycleList && !tractBillCycleList.isEmpty()) {
      listOfActiveBillCycles = GTVRESTMappingService.parseBillCycles(
        tractBillCycleList
      );
    }
    //GTVAPIUtil.updateBillCyclePickListValues(listOfActiveBillCycles);
    return listOfActiveBillCycles;
  }

  /**
   * @description: Query Billing Account Category from GTV db and return UI wrapper after mapping the API response
   * @return List<TRACTBillingAccountCategory__c> The list of TRACTBillingAccountCategory__c Salesforce object.
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public List<TRACTBillingAccountCategory__c> getBillingAccountCategories() {
    List<TRACTBillingAccountCategory__c> bacList = new List<TRACTBillingAccountCategory__c>();
    Map<String, Object> billingAccountCategoryMap = new Map<String, Object>();
    billingAccountCategoryMap.put('status', 'ACTIVE');
    GTVAPIRestClient.ResponseWrapper billingAccountCategoryResponse = GTVAPI2Adapter.queryBillingAccountCategory(
      billingAccountCategoryMap
    );
    List<RestAPI2Domain.GTVAPIBillingAccountCategory> tractBillingAccountCategoryList = (List<RestAPI2Domain.GTVAPIBillingAccountCategory>) billingAccountCategoryResponse.returnObject;
    if (Integer.valueOf(billingAccountCategoryResponse.totalPages) > 1) {
      for (
        integer i = 2;
        i <= Integer.valueOf(billingAccountCategoryResponse.totalPages);
        i++
      ) {
        Map<String, Object> billingAccountCategoryLoopMap = new Map<String, Object>();
        billingAccountCategoryLoopMap.put('status', 'ACTIVE');
        billingAccountCategoryLoopMap.put('pageNumber', i);
        GTVAPIRestClient.ResponseWrapper billingAccountCategoryResponseInLoop = GTVAPI2Adapter.queryBillingAccountCategory(
          billingAccountCategoryLoopMap
        );
        tractBillingAccountCategoryList.addall(
          (List<RestAPI2Domain.GTVAPIBillingAccountCategory>) billingAccountCategoryResponseInLoop.returnObject
        );
      }
    }
    if (
      null != tractBillingAccountCategoryList &&
      !tractBillingAccountCategoryList.isEmpty()
    ) {
      bacList = GTVRESTMappingService.parseBillingAccountCategory(
        tractBillingAccountCategoryList
      );
    }
    //GTVAPIUtil.updateBillingAccountCategoriesPickListValues(bacList);
    return bacList;
  }

  /**
   * @description: Query PriceLists from GTV db and return UI wrapper after mapping the API response
   * @param marketPlaceId GTV Marketplace Id
   * @return List<Price_List__c> The list of Price_List__c Salesforce object.
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public list<Price_List__c> getPriceLists(String marketPlaceId) {
    list<Price_List__c> priceLists = new List<Price_List__c>();
    Map<String, Object> priceListsMap = new Map<String, Object>();
    priceListsMap.put('marketplaceId', marketPlaceId);
    GTVAPIRestClient.ResponseWrapper priceListResponse = GTVAPI2Adapter.queryPriceLists(
      priceListsMap
    );
    List<RestAPI2Domain.GTVAPIPriceList> tractPriceLists = (List<RestAPI2Domain.GTVAPIPriceList>) priceListResponse.returnObject;
    if (Integer.valueOf(priceListResponse.totalPages) > 1) {
      for (
        integer i = 2; i <= Integer.valueOf(priceListResponse.totalPages); i++
      ) {
        Map<String, Object> priceListLoopMap = new Map<String, Object>();
        priceListLoopMap.put('marketplaceId', marketPlaceId);
        priceListLoopMap.put('pageNumber', i);
        GTVAPIRestClient.ResponseWrapper priceListResponseInLoop = GTVAPI2Adapter.queryPriceLists(
          priceListLoopMap
        );
        tractPriceLists.addall(
          (List<RestAPI2Domain.GTVAPIPriceList>) priceListResponseInLoop.returnObject
        );
      }
    }
    if (null != tractPriceLists && !tractPriceLists.isEmpty()) {
      priceLists = GTVRESTMappingService.parsePriceLists(tractPriceLists);
    }
    return priceLists;
  }

  /**
   * @description: Query PaymentTerms from GTV db and return UI wrapper after mapping the API response
   * @return List<Payment_Term__c> The list of Payment_Term__c Salesforce object.
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public list<Payment_Term__c> getPaymentTerms() {
    list<Payment_Term__c> PaymentTerms = new List<Payment_Term__c>();
    Map<String, Object> PaymentTermsMap = new Map<String, Object>();
    GTVAPIRestClient.ResponseWrapper PaymentTermsResponse = GTVAPI2Adapter.queryPaymentTerms(
      PaymentTermsMap
    );
    List<RestAPI2Domain.GTVAPIPaymentTerm> tractPaymentTerms = (List<RestAPI2Domain.GTVAPIPaymentTerm>) PaymentTermsResponse.returnObject;
    if (Integer.valueOf(PaymentTermsResponse.totalPages) > 1) {
      for (
        integer i = 2;
        i <= Integer.valueOf(PaymentTermsResponse.totalPages);
        i++
      ) {
        Map<String, Object> PaymentTermsLoopMap = new Map<String, Object>();
        PaymentTermsLoopMap.put('pageNumber', i);
        GTVAPIRestClient.ResponseWrapper PaymentTermsResponseInLoop = GTVAPI2Adapter.queryPaymentTerms(
          PaymentTermsLoopMap
        );
        tractPaymentTerms.addall(
          (List<RestAPI2Domain.GTVAPIPaymentTerm>) PaymentTermsResponseInLoop.returnObject
        );
      }
    }
    if (null != tractPaymentTerms && !tractPaymentTerms.isEmpty()) {
      PaymentTerms = GTVRESTMappingService.parsePaymentTerms(tractPaymentTerms);
    }
    //GTVAPIUtil.updatePaymentTermsPickListValues(PaymentTerms);
    return PaymentTerms;
  }

  /**
   * @description: Query Agreements from GTV db and return product instance after mapping the API response
   * @param currentProductList The List of salesforce product object.
   * @return Product2 The List of salesforce product object.
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public list<Product2> getGTVAgreeements(list<Product2> currentProductList) {
    Map<String, Object> AgreementsMap = new Map<String, Object>();
    list<Product2> proList = new List<Product2>();
    for (Product2 currentProduct : currentProductList) {
      list<ProductAgreementWrapper> listOfAgreements = new List<ProductAgreementWrapper>();
      AgreementsMap.put('productId', currentProduct.eid__c);
      AgreementsMap.put('status', 'ACTIVE');
      GTVAPIRestClient.ResponseWrapper AgreementsResponse = GTVAPI2Adapter.queryAgreements(
        AgreementsMap
      );
      List<RestAPI2Domain.GTVAPIAgreement> tractAgreements = (List<RestAPI2Domain.GTVAPIAgreement>) AgreementsResponse.returnObject;
      if (null != tractAgreements && !tractAgreements.isEmpty()) {
        listOfAgreements = GTVRESTMappingService.parseAgreements(
          tractAgreements
        );
      }
      currentProduct.Agreement_Information__c = JSON.serialize(
        listOfAgreements
      );
      proList.add(currentProduct);
    }
    return proList;
  }

  /*Method to make test callouts to Gotransverse */
  public void queryPriceListsForTestingConnection(TRACT_Setup__c tractConfig) {
    GTVAPI2Adapter.queryPriceListsForTestingConnection(tractConfig);
  }

  /**
   * @description: Query Products from GTV db
   * @param listOfPriceList The List of salesforce Price_List__c object.
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public void getGTVProducts(list<Price_List__c> listOfPriceList) {
    Price_List__c priceList = listOfPriceList[0];
    Map<String, Object> productsMap = new Map<String, Object>();
    productsMap.put('productState', 'AVAILABLE');
    productsMap.put('priceListId', priceList.eid__c);
    GTVAPIRestClient.ResponseWrapper productsResponse = GTVAPI2Adapter.queryProducts(
      productsMap
    );
    List<RestAPI2Domain.GTVAPIProduct> gtvProducts = (List<RestAPI2Domain.GTVAPIProduct>) productsResponse.returnObject;
    if (Integer.valueOf(productsResponse.totalPages) > 1) {
      for (
        integer i = 2; i <= Integer.valueOf(productsResponse.totalPages); i++
      ) {
        Map<String, Object> productsLoopMap = new Map<String, Object>();
        productsLoopMap.put('productState', 'AVAILABLE');
        productsLoopMap.put('priceListId', priceList.eid__c);
        productsLoopMap.put('pageNumber', i);
        GTVAPIRestClient.ResponseWrapper productsResponseInLoop = GTVAPI2Adapter.queryProducts(
          productsLoopMap
        );
        gtvProducts.addall(
          (List<RestAPI2Domain.GTVAPIProduct>) productsResponseInLoop.returnObject
        );
      }
    }
    if (null != gtvProducts && !gtvProducts.isEmpty()) {
      GTVRESTMappingService.saveProducts(gtvProducts, listOfPriceList);
    }
  }

  /**
   * @description: Deactivate service in GTV db and return a string
   * @param serviceEid The name of the parameter (required)
   * @param reasonEid the id of deactivation reason(required)
   * @param deactivationDate (required)
   * @return String A string that contains message to be used on UI
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public String saveDeactivateService(
    String serviceEid,
    String reasonEid,
    String deactivationDate
  ) {
    String emessage = 'NoError';
    Map<String, Object> deactivateServiceMap = new Map<String, Object>();
    RestAPI2Domain.GTVAPIDeactivateService deactivateService = new RestAPI2Domain.GTVAPIDeactivateService();
    deactivateService = GTVRESTReverseMappingService.mapDeactivateService(
      reasonEid,
      deactivationDate
    );
    deactivateServiceMap.put('id', serviceEid);
    deactivateServiceMap.put('deactivateService', deactivateService);
    try {
      GTVAPI2Adapter.deactivateService(deactivateServiceMap);
    } catch (Exception e) {
      emessage = string.valueof(e.getmessage() + e.getLineNumber());
      if (emessage.contains('Web service callout failed')) {
        emessage = emessage.substringBetween(
          'Web service callout failed: WebService returned a SOAP Fault:',
          ' faultcode=soap:Server faultactor='
        );
      }
    }

    return emessage;
  }

  /**
   * @description: Query order custom fields from GTV db and return list<Tract_Order_Custom_Field__c> after mapping the API response
   * @return list<Tract_Order_Custom_Field__c> The list of salesforce Tract_Order_Custom_Field__c object.
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public list<Tract_Order_Custom_Field__c> getOrderCustomFields() {
    list<Tract_Order_Custom_Field__c> orderCustomFieldsList = new List<Tract_Order_Custom_Field__c>();
    Map<String, Object> orderCustomFieldValueQueryMap = new Map<String, Object>();
    orderCustomFieldValueQueryMap.put('enabled', true);
    orderCustomFieldValueQueryMap.put('searchable', true);
    GTVAPIRestClient.ResponseWrapper orderCustomFieldsResponseWrap = GTVAPI2Adapter.queryOrderCustomFields(
      orderCustomFieldValueQueryMap
    );
    List<RestAPI2Domain.GTVAPIOrderCustomField> orderCustomFieldResponse = (List<RestAPI2Domain.GTVAPIOrderCustomField>) orderCustomFieldsResponseWrap.returnObject;
    if (orderCustomFieldResponse != null) {
      orderCustomFieldsList = GTVRESTMappingService.parseOrderCustomFields(
        orderCustomFieldResponse
      );
    }
    return orderCustomFieldsList;
  }

  /**
   * @description: Query orderitems from GTV db and return GTVSalesOrderDetailWrapper after mapping the API response
   * @param orderNumber order number for which order items to be fetched (required)
   * @param currencyType The currencyType of the billing account (required)
   * @return GTVSalesOrderDetailWrapper The billing account Salesorder Detail wrapper to be used on UI
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public GTVSalesOrderDetailWrapper getOrderItemList(
    String orderNumber,
    String currencyType
  ) {
    GTVSalesOrderDetailWrapper salesOrderWrapper = new GTVSalesOrderDetailWrapper();
    Decimal taxShow;
    Map<String, RestAPI2Domain.GTVAPIAgreement> mapOfOrderItemIdVSAgreement = new Map<String, RestAPI2Domain.GTVAPIAgreement>();
    Map<String, RestAPI2Domain.GTVAPIService> mapOfOrderItemIdVSParentService = new Map<String, RestAPI2Domain.GTVAPIService>();
    Map<String, Object> queryOrderFilterMap = new Map<String, Object>();
    queryOrderFilterMap.put('orderNum', orderNumber);
    GTVAPIRestClient.ResponseWrapper salesOrderResponseWrap = GTVAPI2Adapter.querySalesOrder(
      queryOrderFilterMap
    );
    List<RestAPI2Domain.GTVAPIOrder> salesOrderResponse = (List<RestAPI2Domain.GTVAPIOrder>) salesOrderResponseWrap.returnObject;
    if (salesOrderResponse != null) {
      for (
        RestAPI2Domain.GTVAPIOrderItem orderItem : salesOrderResponse[0]
          .orderItems
      ) {
        if (null != orderItem.orderItemAgreement) {
          Map<String, Object> queryAgreementFilterMap = new Map<String, Object>();
          queryAgreementFilterMap.put(
            'id',
            orderItem.orderItemAgreement.agreement.id
          );
          GTVAPIRestClient.ResponseWrapper agreementResponseWrap = GTVAPI2Adapter.getAgreements(
            queryAgreementFilterMap
          );
          RestAPI2Domain.GTVAPIAgreement agreementResponse = (RestAPI2Domain.GTVAPIAgreement) agreementResponseWrap.returnObject;
          mapOfOrderItemIdVSAgreement.put(orderItem.id, agreementResponse);
        }
        if (null != orderItem.parentService) {
          system.debug(
            ' orderItem.parentService:::::' + orderItem.parentService
          );
          Map<String, Object> queryParentServiceFilterMap = new Map<String, Object>();
          queryParentServiceFilterMap.put('id', orderItem.parentService.id);
          GTVAPIRestClient.ResponseWrapper parentServiceResponseWrap = GTVAPI2Adapter.getService(
            queryParentServiceFilterMap
          );
          RestAPI2Domain.GTVAPIService parentServiceResponse = (RestAPI2Domain.GTVAPIService) parentServiceResponseWrap.returnObject;
          system.debug(' parentServiceResponse:::::' + parentServiceResponse);
          mapOfOrderItemIdVSParentService.put(
            orderItem.id,
            parentServiceResponse
          );
          system.debug(
            ' mapOfOrderItemIdVSParentService:::::' +
            mapOfOrderItemIdVSParentService
          );
        }
        if (null != orderItem.orderItems && !orderItem.orderItems.isEmpty()) {
          for (
            RestAPI2Domain.GTVAPIAddonServiceProductOrderItem childOrderItem : orderItem.orderItems
          ) {
            if (null != childOrderItem.orderItemAgreement) {
              Map<String, Object> queryChildAgreementFilterMap = new Map<String, Object>();
              queryChildAgreementFilterMap.put(
                'id',
                childOrderItem.orderItemAgreement.agreement.id
              );
              GTVAPIRestClient.ResponseWrapper childAgreementResponseWrap = GTVAPI2Adapter.getAgreements(
                queryChildAgreementFilterMap
              );
              RestAPI2Domain.GTVAPIAgreement childAgreementResponse = (RestAPI2Domain.GTVAPIAgreement) childAgreementResponseWrap.returnObject;
              mapOfOrderItemIdVSAgreement.put(
                childOrderItem.id,
                childAgreementResponse
              );
            }
            if (null != childOrderItem.parentService) {
              Map<String, Object> queryParentServiceFilterMap = new Map<String, Object>();
              queryParentServiceFilterMap.put(
                'id',
                childOrderItem.parentService.id
              );
              GTVAPIRestClient.ResponseWrapper parentServiceResponseWrap = GTVAPI2Adapter.getService(
                queryParentServiceFilterMap
              );
              RestAPI2Domain.GTVAPIService parentServiceResponse = (RestAPI2Domain.GTVAPIService) parentServiceResponseWrap.returnObject;
              mapOfOrderItemIdVSParentService.put(
                childOrderItem.id,
                parentServiceResponse
              );
            }
            if (
              null != childOrderItem.orderItems &&
              !childOrderItem.orderItems.isEmpty()
            ) {
              for (
                RestAPI2Domain.GTVAPIAddonServiceProductOrderItem grandChildOrderItem : childOrderItem.orderItems
              ) {
                if (null != grandChildOrderItem.orderItemAgreement) {
                  Map<String, Object> queryGrandChildAgreementFilterMap = new Map<String, Object>();
                  queryGrandChildAgreementFilterMap.put(
                    'id',
                    grandChildOrderItem.orderItemAgreement.agreement.id
                  );
                  GTVAPIRestClient.ResponseWrapper grandChildAgreementResponseWrap = GTVAPI2Adapter.getAgreements(
                    queryGrandChildAgreementFilterMap
                  );
                  RestAPI2Domain.GTVAPIAgreement grandChildAgreementResponse = (RestAPI2Domain.GTVAPIAgreement) grandChildAgreementResponseWrap.returnObject;
                  mapOfOrderItemIdVSAgreement.put(
                    grandChildOrderItem.id,
                    grandChildAgreementResponse
                  );
                }
                if (null != grandChildOrderItem.parentService) {
                  Map<String, Object> queryParentServiceFilterMap = new Map<String, Object>();
                  queryParentServiceFilterMap.put(
                    'id',
                    grandChildOrderItem.parentService.id
                  );
                  GTVAPIRestClient.ResponseWrapper parentServiceResponseWrap = GTVAPI2Adapter.getService(
                    queryParentServiceFilterMap
                  );
                  RestAPI2Domain.GTVAPIService parentServiceResponse = (RestAPI2Domain.GTVAPIService) parentServiceResponseWrap.returnObject;
                  mapOfOrderItemIdVSParentService.put(
                    grandChildOrderItem.id,
                    parentServiceResponse
                  );
                }
              }
            }
          }
        }
      }
      salesOrderWrapper = GTVRESTMappingService.mapOrderItems(
        salesOrderResponse[0],
        currencyType,
        mapOfOrderItemIdVSAgreement,
        mapOfOrderItemIdVSParentService
      );
    }
    return salesOrderWrapper;
  }

  /**
   * @description: Query billing account custom fields from GTV db and return List<AccountCustomFieldWrapper> after mapping the API response
   * @param tractBillingAccount wrapper class that contains account Information. (required)
   * @return List<AccountCustomFieldWrapper> The list of AccountCustomFieldWrapper to be shown on the UI.
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public List<AccountCustomFieldWrapper> getAccountCustomFields(
    TRACTAccountWrapper tractBillingAccount
  ) {
    List<AccountCustomFieldWrapper> accountCustomFieldsWrapperList = new List<AccountCustomFieldWrapper>();
    Map<String, String> accountCustomFieldValuesMap = new Map<String, String>();
    Map<String, Object> accountCustomFieldValueQueryMap = new Map<String, Object>();
    accountCustomFieldValueQueryMap.put('id', tractBillingAccount.eid);
    GTVAPIRestClient.ResponseWrapper AccountCustomFieldsValueResponse = GTVAPI2Adapter.queryAccountCustomFieldValues(
      accountCustomFieldValueQueryMap
    );
    List<RestAPI2Domain.GTVAPIBillingAccountCustomFieldVal> ValueResponseMap = (List<RestAPI2Domain.GTVAPIBillingAccountCustomFieldVal>) AccountCustomFieldsValueResponse.returnObject;
    accountCustomFieldValuesMap = GTVRESTMappingService.mapAccountCustomFieldValues(
      ValueResponseMap
    );
    Map<String, Object> accountCustomFieldsMap = new Map<String, Object>();
    accountCustomFieldsMap.put('enabled', true);
    accountCustomFieldsMap.put('searchable', true);
    GTVAPIRestClient.ResponseWrapper AccountCustomFieldsResponse = GTVAPI2Adapter.queryAccountCustomFields(
      accountCustomFieldsMap
    );
    List<RestAPI2Domain.GTVAPIBillingAccountCustomField> tractAccountCustomFieldsList = (List<RestAPI2Domain.GTVAPIBillingAccountCustomField>) AccountCustomFieldsResponse.returnObject;
    if (
      null != tractAccountCustomFieldsList &&
      !tractAccountCustomFieldsList.isEmpty()
    ) {
      accountCustomFieldsWrapperList = GTVRESTMappingService.parseAccountCustomFields(
        tractAccountCustomFieldsList,
        accountCustomFieldValuesMap
      );
    }
    return accountCustomFieldsWrapperList;
  }

  /**
   * @description: Get request to create billing account in GTV db
   * @param Account Salesforce Account to be created in GTV(required)
   * @param billCycle billcycle choose by user while creating account(required)
   * @param bACEid The Id of billing account category(required)
   * @param paymentTerm The Id of payment term(required)
   * @param fieldToMapAccountId The Id of account custom field to be mapped with salesforce account id(required)
   * @return string The request instance in stringify form.
   */
  public string getBillingAccountForCreateRequest(
    list<Account> thisAccountList,
    TRACT_Bill_Cycle__c billCycle,
    string bACEid,
    string paymentTerm,
    string fieldToMapAccountId
  ) {
    Account thisAccount = thisAccountList[0];
    String billingAccountString;
    RestAPI2Domain.GTVAPICreateBillingAccount billAccount = GTVRESTReverseMappingService.getBillingAccountCreationMapping(
      thisAccount,
      billCycle,
      bACEid,
      paymentTerm,
      fieldToMapAccountId
    );
    billingAccountString = JSON.serialize(billAccount);
    billingAccountString = billingAccountString.replace('propertyMappings', '');
    return billingAccountString;
  }

  /**
   * @description: Create billing account in GTV db using Trigger.
   * @param AccountId The id of the Salesforce Account to be created in GTV(required)
   * @param billingAccountString billing account create request in stringify form(required)
   */
  public void AccountcreationForTrigger(
    Id AccountId,
    String billingAccountString
  ) {
    //GTVAPI2Adapter.makeFutureCalloutForAccountCreation(AccountId,billingAccountString);
  }

  /**
   * @description: Query billing account custom field values from GTV db and return List<AccountCustomFieldValueWrapper> after mapping the API response
   * @param accountId The id of salesforce account. (required)
   * @return List<AccountCustomFieldValueWrapper> The list of AccountCustomFieldValueWrapper to be shown on the UI.
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public List<AccountCustomFieldValueWrapper> getAccountCustomFieldValueList(
    String accountId
  ) {
    TRACTAccountWrapper billingAccountWrapper = getBillingAccount(accountId);
    List<AccountCustomFieldValueWrapper> valueWrapperList = new List<AccountCustomFieldValueWrapper>();
    Map<String, Object> accountCustomFieldValueQueryMap = new Map<String, Object>();
    accountCustomFieldValueQueryMap.put('id', billingAccountWrapper.Eid);
    GTVAPIRestClient.ResponseWrapper AccountCustomFieldsValueResponse = GTVAPI2Adapter.queryAccountCustomFieldValues(
      accountCustomFieldValueQueryMap
    );
    List<RestAPI2Domain.GTVAPIBillingAccountCustomFieldVal> ValueResponseMap = (List<RestAPI2Domain.GTVAPIBillingAccountCustomFieldVal>) AccountCustomFieldsValueResponse.returnObject;
    valueWrapperList = GTVRESTMappingService.mapAccountCustomFieldsValue(
      ValueResponseMap
    );
    return valueWrapperList;
  }

  /**
   * @description: Create adjustments in GTV db.
   * @param accountId The id of salesforce account.(required)
   * @param adjustmentReasonEid the id of adjustment reason(required)
   * @param ammount the amount of adjustment(required)
   * @param description the description of adjustment(required)
   * @param effectiveDate the effective date on adjustment(required)
   * @param manualInvoice if the adjustments to be associated to invoice manually(required)
   * @param isCredit if the adjustment is a credit adjustment or not(required)
   * @param deactivationDate (required)
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public void saveAdjustmentGTV(
    String accountId,
    string adjustmentReasonEid,
    String ammount,
    String description,
    String effectiveDate,
    boolean manualInvoice,
    boolean isCredit
  ) {
    RestAPI2Domain.GTVAPICreateAccountAdjustment createAdjustment = new RestAPI2Domain.GTVAPICreateAccountAdjustment();
    Map<String, Object> addAdjustmentMap = new Map<String, Object>();
    TRACTAccountWrapper tAccount = getBillingAccount(accountId);
    createAdjustment = GTVRESTReverseMappingService.mapAdjustment(
      effectiveDate,
      adjustmentReasonEid,
      ammount,
      description,
      tAccount,
      manualInvoice,
      isCredit
    );
    addAdjustmentMap.put('adjustment', createAdjustment);
    if (isCredit) {
      saveCreditAdjustment(addAdjustmentMap);
    } else {
      saveDebitAdjustment(addAdjustmentMap);
    }
  }

  /**
   * @description: Create credit adjustment in GTV db.
   * @param addCreditAdjustmentMap The Map of callout parameters(required)
   */
  public void saveCreditAdjustment(Map<String, Object> addCreditAdjustmentMap) {
    GTVAPIRestClient.ResponseWrapper addCreditAdjustmentResponse = GTVAPI2Adapter.createCreditAdjustment(
      addCreditAdjustmentMap
    );
    RestAPI2Domain.GTVAPICreditAccountAdjustment creditAdjustmentInstance = (RestAPI2Domain.GTVAPICreditAccountAdjustment) addCreditAdjustmentResponse.returnObject;
    if (null != creditAdjustmentInstance) {
      Map<String, Object> postCreditAdjustmentMap = new Map<String, Object>();
      postCreditAdjustmentMap.put('id', creditAdjustmentInstance.id);
      GTVAPI2Adapter.PostCreditAdjustment(postCreditAdjustmentMap);
    }
  }

  /**
   * @description: Create debit adjustment in GTV db.
   * @param addDebitAdjustmentMap The Map of callout parameters(required)
   */
  public void saveDebitAdjustment(Map<String, Object> addDebitAdjustmentMap) {
    GTVAPIRestClient.ResponseWrapper addDebitAdjustmentResponse = GTVAPI2Adapter.createdebitAdjustment(
      addDebitAdjustmentMap
    );
    RestAPI2Domain.GTVAPIDebitAccountAdjustment debitAdjustmentInstance = (RestAPI2Domain.GTVAPIDebitAccountAdjustment) addDebitAdjustmentResponse.returnObject;
    if (null != debitAdjustmentInstance) {
      Map<String, Object> postDebitAdjustmentMap = new Map<String, Object>();
      postDebitAdjustmentMap.put('id', debitAdjustmentInstance.id);
      GTVAPI2Adapter.PostDebitAdjustment(postDebitAdjustmentMap);
    }
  }

  /**
   * @description: Delete activity charge rule on a service in GTV db.
   * @param activityProductEid The Id of GTV service
   * @param deletedUsageEid The Id of GTV activity charge rule
   */
  public void deleteActivityChargeRule(
    String activityProductEid,
    String deletedUsageEid,
    String activityRuleName
  ) {
    Map<String, Object> deleteChargeRuleMap = new Map<String, Object>();
    deleteChargeRuleMap.put('serviceId', activityProductEid);
    deleteChargeRuleMap.put('id', deletedUsageEid);
    GTVAPI2Adapter.deleteUsageRule(deleteChargeRuleMap);
  }

  /**
   * @description: Create billing account in GTV db using button on account.
   * @param Account Salesforce Account to be created in GTV(required)
   * @param billCycle billcycle choose by user while creating account(required)
   * @param bACEid The Id of billing account category(required)
   * @param paymentTerm The Id of payment term(required)
   * @param fieldToMapAccountId The Id of account custom field to be mapped with salesforce account id(required)
   */
  public void BillingAccountCreationMapping(
    list<Account> thisAccountList,
    TRACT_Bill_Cycle__c billCycle,
    string bACEid,
    string paymentTerm,
    string fieldToMapAccountId
  ) {
    Account thisAccount = thisAccountList[0];
    String billingAccountString;
    RestAPI2Domain.GTVAPICreateBillingAccount billAccount = GTVRESTReverseMappingService.getBillingAccountCreationMapping(
      thisAccount,
      billCycle,
      bACEid,
      paymentTerm,
      fieldToMapAccountId
    );
    billingAccountString = JSON.serialize(billAccount);
    billingAccountString = billingAccountString.replace('propertyMappings', '');
    GTVAPI2Adapter.createBillingAccount(thisAccount.id, billingAccountString);
  }

  public Object getDiscounts(String productWrapperString, String discountName) {
    Product2AddWrapper productWrapper = (Product2AddWrapper) JSON.deserialize(
      productWrapperString,
      Product2AddWrapper.class
    );
    productWrapper.errorMessage = 'NoError';
    Object prodObject;
    Map<String, Object> discountMap = new Map<String, Object>();
    List<RestAPI2Domain.GTVAPIDiscountResource> ValueResponseMap;
    try {
      if (discountName != null && discountName != '') {
        discountName = discountName.trim();
        discountMap.put('identifier', discountName);
      }
      GTVAPIRestClient.ResponseWrapper discountCodeResponse = GTVAPI2Adapter.getProductDiscountResourceList(
        discountMap
      );
      ValueResponseMap = (List<RestAPI2Domain.GTVAPIDiscountResource>) discountCodeResponse.returnObject;
    } catch (exception e) {
      productWrapper.errorMessage = e.getmessage();
      return productWrapper;
    }
    prodObject = (Object) GTVRESTMappingService.mapDiscountResource(
      productWrapper,
      ValueResponseMap,
      discountName
    );
    return prodObject;
  }

  public Object getDiscountsQuickAdd(String productWrapperString) {
    Product2AddWrapper productWrapper = (Product2AddWrapper) JSON.deserialize(
      productWrapperString,
      Product2AddWrapper.class
    );
    productWrapper.errorMessage = 'NoError';
    Object prodObject;
    String discountName = '';
    Map<String, Object> discountMap = new Map<String, Object>();
    List<RestAPI2Domain.GTVAPIDiscountCode> ValueResponseMap;
    try {
      if (
        productWrapper.discountName != null &&
        productWrapper.discountName != ''
      ) {
        discountName = productWrapper.discountName.trim();
        productWrapper.discountName = productWrapper.discountName.trim();
        discountMap.put('name', discountName);
      }
      GTVAPIRestClient.ResponseWrapper discountCodeResponse = GTVAPI2Adapter.getProductDiscountCodeList(
        discountMap
      );
      ValueResponseMap = (List<RestAPI2Domain.GTVAPIDiscountCode>) discountCodeResponse.returnObject;
    } catch (exception e) {
      productWrapper.errorMessage = e.getmessage();
      return productWrapper;
    }
    prodObject = (Object) GTVRESTMappingService.mapDiscounts(
      productWrapper,
      ValueResponseMap,
      discountName
    );
    return prodObject;
  }

  /**
   * @description: This method query service resource with the specified identifier in GTV db.
   * @param srId The service resource identifier (required)
   * @return ServiceResourceWrapper , The ServiceResourceWrapper wrapper instance.
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public ServiceResourceWrapper getServiceResource(String srId) {
    ServiceResourceWrapper srWrapper = new ServiceResourceWrapper();
    srWrapper.errorMessage = 'NoError';
    Map<String, Object> servicesResourceQueryParamsMap = new Map<String, Object>();
    servicesResourceQueryParamsMap.put('identifier', srId);
    GTVAPIRestClient.ResponseWrapper getServiceResource = GTVAPI2Adapter.queryServiceResource(
      servicesResourceQueryParamsMap
    );
    List<RestAPI2Domain.GTVAPIServiceResource> responseServiceResourceMap = (List<RestAPI2Domain.GTVAPIServiceResource>) getServiceResource.returnObject;
    srWrapper = GTVRESTMappingService.mapServiceResource(
      responseServiceResourceMap,
      srId
    );
    return srWrapper;
  }

  /**
   * Suspend service in GTV db
   * @param serviceEid The id of the service to be deactivated(required)
   * @param reasonEid the id of suspension reason(required)
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public void suspendServiceGTV(String serviceEid, String reasonEid) {
    Map<String, Object> suspendServiceMap = new Map<String, Object>();
    RestAPI2Domain.GTVAPISuspendService suspendService = new RestAPI2Domain.GTVAPISuspendService();
    suspendService = GTVRESTReverseMappingService.mapSuspendService(reasonEid);
    suspendServiceMap.put('id', serviceEid);
    suspendServiceMap.put('suspendService', suspendService);
    GTVAPI2Adapter.suspendService(suspendServiceMap);
  }

  /**
   * save account custom field value in GTV db
   * @param tractBillingAccount The wrapper of the billing account(required)
   * @param customFildWrapper the list of account custom field wrapper in stringify form(required)
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public String saveAccountCustomField(
    TRACTAccountWrapper tractBillingAccount,
    String customFildWrapper
  ) {
    String emessage = 'No error';
    list<AccountCustomFieldWrapper> wrap = (list<AccountCustomFieldWrapper>) JSON.deserialize(
      customFildWrapper,
      List<AccountCustomFieldWrapper>.class
    );
    list<RestAPI2Domain.GTVAPICreateBillingAccountCustomFi> MapCustomFieldRequest = GTVRESTReverseMappingService.mapSaveAccountCustomField(
      wrap
    );
    if (MapCustomFieldRequest.size() > 0) {
      for (
        RestAPI2Domain.GTVAPICreateBillingAccountCustomFi Value : MapCustomFieldRequest
      ) {
        Map<String, Object> saveAccountCustomFieldsQueryMap = new Map<String, Object>();
        saveAccountCustomFieldsQueryMap.put('id', tractBillingAccount.eid);
        saveAccountCustomFieldsQueryMap.put(
          'billingAccountCustomFieldValue',
          Value
        );
        try {
          GTVAPI2Adapter.saveAccountCustomField(
            saveAccountCustomFieldsQueryMap
          );
        } catch (Exception e) {
          if (e.getmessage().contains('Validation')) {
            emessage = e.getmessage()
              .substring(
                e.getmessage().indexOf('Validation error: '),
                e.getmessage().indexOf(' faultcode=')
              );
          } else if (e.getmessage().contains('ExecutionException')) {
            emessage = string.valueof(e.getmessage());
            emessage = emessage.substringAfter(
              'common.apex.runtime.impl.ExecutionException:'
            );
          } else {
            emessage = string.valueof(e.getmessage());
          }
        }
      }
    }
    return emessage;
  }

  public void saveChangeServicesOnApex(
    String newSubscriptionId,
    String effectiveDateValue,
    String currentServiceEid,
    list<Account> accList,
    Boolean payonPurchaseValue,
    Map<String, Decimal> MapOfAgreementPeriod,
    Map<String, String> productPriceIdToEidMap,
    Integer qtyOfChangedService,
    String agreementRenewActionForChangedService,
    String agreementEidForChangedService,
    Decimal recurringPrice,
    String recurringPriceId,
    String priceOverridden
  ) {
  }

  /**
   * Resume billing account in GTV db
   * @param tractBillingAccount The name of the parameter (required)
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public void resumeBillingAccount(TRACTAccountWrapper tractBillingAccount) {
    Map<String, Object> resumeBillingAccountParamMap = new Map<String, Object>();
    resumeBillingAccountParamMap.put('id', tractBillingAccount.eid);
    resumeBillingAccountParamMap.put(
      'resumeBillingAccount',
      GTVRESTReverseMappingService.mapResumeBillingAccount()
    );
    GTVAPI2Adapter.resumeBillingAccount(resumeBillingAccountParamMap);
  }

  /**
   * Suspend billing account in GTV db
   * @param tractBillingAccount The name of the parameter (required)
   * @param reasonEid the id of suspension reason(required)
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public void suspendBillingAccount(
    TRACTAccountWrapper tractBillingAccount,
    String reasonEid
  ) {
    Map<String, Object> suspendBillingAccountParamMap = new Map<String, Object>();
    suspendBillingAccountParamMap.put('id', tractBillingAccount.eid);
    suspendBillingAccountParamMap.put(
      'suspendBillingAccount',
      GTVRESTReverseMappingService.mapSuspendBillingAccount(reasonEid)
    );
    GTVAPI2Adapter.suspendBillingAccount(suspendBillingAccountParamMap);
  }

  /**
   * Deactivate billing account in GTV db
   * @param tractBillingAccount The name of the parameter (required)
   * @param reasonEid the id of deactivation reason(required)
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public void deactivateBillingAccount(
    TRACTAccountWrapper tractBillingAccount,
    String reasonEid
  ) {
    Map<String, Object> deactivateBillingAccountParamMap = new Map<String, Object>();
    deactivateBillingAccountParamMap.put('id', tractBillingAccount.eid);
    deactivateBillingAccountParamMap.put(
      'deactivateBillingAccount',
      GTVRESTReverseMappingService.mapDeactivateBillingAccount(reasonEid)
    );
    GTVAPI2Adapter.deactivateBillingAccount(deactivateBillingAccountParamMap);
  }

  public List<SelectOption> getCurrencyType() {
    list<SelectOption> currencyList = new List<SelectOption>();
    TRACT3__GTV_Currencies__c currencies = TRACT3__GTV_Currencies__c.getValues(
      'Currency'
    );
    system.debug('currencies   ' + currencies);
    list<String> listOfCurrencies = currencies.TRACT3__GTV_Currency_List__c.split(
      ','
    );
    for (String curr : listOfCurrencies) {
      currencyList.add(new SelectOption(curr, curr));
    }
    return currencyList;
  }

  public List<ProductUsesWrapper> showUsageRule(String activityProductEid) {
    List<ProductUsesWrapper> listOfUsageRules = new List<ProductUsesWrapper>();
    Map<String, Object> usageRuleParamMap = new Map<String, Object>();
    usageRuleParamMap.put('serviceId', activityProductEid);
    GTVAPIRestClient.ResponseWrapper addUsageRuleResponse = GTVAPI2Adapter.queryUsageRule(
      usageRuleParamMap
    );
    List<RestAPI2Domain.GTVAPIServiceUsageRule> usageRuleResponseMap = (List<RestAPI2Domain.GTVAPIServiceUsageRule>) addUsageRuleResponse.returnObject;
    if (null != usageRuleResponseMap && !usageRuleResponseMap.isEmpty()) {
      listOfUsageRules = GTVRESTMappingService.mapServiceUsageRules(
        usageRuleResponseMap
      );
    }
    return listOfUsageRules;
  }

  /**
   * Resume service in GTV db
   * @param serviceEidValue the id of the service to be resumed (required)
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public void resumeServiceGTV(String serviceEidValue) {
    Map<String, Object> resumeServiceParamMap = new Map<String, Object>();
    resumeServiceParamMap.put('id', serviceEidValue);
    GTVAPI2Adapter.resumeService(resumeServiceParamMap);
  }

  /**
   * Convert service in GTV db
   * @param serviceEidValue the id of the service to be resumed (required)
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public void convertServiceGTV(String serviceEidValue) {
    Map<String, Object> resumeServiceParamMap = new Map<String, Object>();
    resumeServiceParamMap.put('id', serviceEidValue);
    GTVAPI2Adapter.convertService(resumeServiceParamMap);
  }

  /**
   * Add service Address on specified service in GTV db
   * @param currentServiceEid the id of the service(required)
   * @param ShippingCountry value of country on the address(required)
   * @param addressLine1 value of addressLine1 on the address(required)
   * @param addressLine2 value of addressLine2 on the address(required)
   * @param ShippingCity value of city on the address(required)
   * @param stateValue value of state on the address(required)
   * @param postalCode value of postalCode on the address(required)
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public void saveAddAddressGTV(
    String currentServiceEid,
    String ShippingCountry,
    String addressLine1,
    String addressLine2,
    String ShippingCity,
    String stateValue,
    String postalCode
  ) {
    Map<String, Object> addServiceAddressMap = new Map<String, Object>();
    addServiceAddressMap.put('serviceId', currentServiceEid);
    addServiceAddressMap.put(
      'addServiceAddress',
      GTVRESTReverseMappingService.mapAddAddressGTV(
        ShippingCountry,
        addressLine1,
        addressLine2,
        ShippingCity,
        stateValue,
        postalCode
      )
    );
    GTVAPIRestClient.ResponseWrapper addServicsAddressResponse = GTVAPI2Adapter.saveAddress(
      addServiceAddressMap
    );
  }

  /**
   * Update quantity on specified service in GTV db
   * @param updateserviceQuantity value of updated quantity on the service(required)
   * @param serviceEidValue the id of the service(required)
   * @param displayEffectiveDate if date fields should be shown to the user on the modal or not(required)
   * @param effectiveDate date from which the new quantity will be effective(required)
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public void updateQuantityInGTV(
    Decimal updateserviceQuantity,
    String serviceEidValue,
    Boolean displayEffectiveDate,
    String effectiveDate
  ) {
    Map<String, Object> updateQuantityParamMap = new Map<String, Object>();
    updateQuantityParamMap.put('id', serviceEidValue);
    updateQuantityParamMap.put(
      'changeServiceQuantity',
      GTVRESTReverseMappingService.mapServiceQuantity(
        updateserviceQuantity,
        displayEffectiveDate,
        effectiveDate
      )
    );
    GTVAPI2Adapter.updateServiceQuantity(updateQuantityParamMap);
  }

  /**
   * get Invoice By Number on specified service in GTV db
   * @param InvoiceWrapper The instance od the invoice wrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public InvoiceDetailWrapper getInvoiceByNumber(InvoiceWrapper wrapperObj) {
    InvoiceDetailWrapper detail = new InvoiceDetailWrapper();
    Map<String, String> invoiceItemServiceMap = new Map<String, String>();
    Map<String, Object> invoiceParamsMap = new Map<String, Object>();
    invoiceParamsMap.put('invoiceNum', wrapperObj.Name);
    system.debug('invoiceParamsMap::::' + invoiceParamsMap);
    GTVAPIRestClient.ResponseWrapper apiCallOutInvoiceItemResponse = GTVAPI2Adapter.queryInvoiceIems(
      invoiceParamsMap
    );
    List<RestAPI2Domain.GTVAPIInvoiceItem> tractInvoiceItemList = (List<RestAPI2Domain.GTVAPIInvoiceItem>) apiCallOutInvoiceItemResponse.returnObject;
    if (null != tractInvoiceItemList && !tractInvoiceItemList.isEmpty()) {
      for (RestAPI2Domain.GTVAPIInvoiceItem item : tractInvoiceItemList) {
        if (item.service != null) {
          Map<String, Object> invoiceServiceMap = new Map<String, Object>();
          invoiceServiceMap.put('id', item.service.id);
          GTVAPIRestClient.ResponseWrapper apiCallOutServiceResponse = GTVAPI2Adapter.getService(
            invoiceServiceMap
          );
          RestAPI2Domain.GTVAPIService servic = (RestAPI2Domain.GTVAPIService) apiCallOutServiceResponse.returnObject;
          if (null != servic) {
            invoiceItemServiceMap.put(item.service.id, servic.description);
          }
        }
      }
    }
    GTVAPIRestClient.ResponseWrapper apiCallOutInvoiceResponse = GTVAPI2Adapter.queryInvoices(
      invoiceParamsMap
    );
    List<RestAPI2Domain.GTVAPIInvoice> tractInvoiceList = (List<RestAPI2Domain.GTVAPIInvoice>) apiCallOutInvoiceResponse.returnObject;
    if (null != tractInvoiceList && !tractInvoiceList.isEmpty()) {
      detail = GTVRESTMappingService.mapInvoiceData(
        tractInvoiceList,
        wrapperObj,
        invoiceItemServiceMap
      );
    }
    system.debug('detail::::' + detail);
    return detail;
  }

  /**
   * Query service deactivation reasons from GTV db and return list<selectOption> after mapping the API response
   * @return list<selectOption> The list of selectOption wrapper class.
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public list<selectOption> getDeactivateReasons() {
    list<selectOption> serviceDeactivationReasonList = new List<selectOption>();
    Map<String, Object> deactivationReasonMap = new Map<String, Object>();
    deactivationReasonMap.put('status', 'ACTIVE');
    GTVAPIRestClient.ResponseWrapper reasonResponse = GTVAPI2Adapter.queryServiceDeactivationReasons(
      deactivationReasonMap
    );
    List<RestAPI2Domain.GTVAPIServiceDeactivationReason> serviceDeactivationReasonResponse = (List<RestAPI2Domain.GTVAPIServiceDeactivationReason>) reasonResponse.returnObject;
    if (
      null != serviceDeactivationReasonResponse &&
      !serviceDeactivationReasonResponse.isEmpty()
    ) {
      serviceDeactivationReasonList = GTVRESTMappingService.mapServiceDeactivationReasons(
        serviceDeactivationReasonResponse
      );
    }
    return serviceDeactivationReasonList;
  }

  /**
   * Query service suspension reasons from GTV db and return list<selectOption> after mapping the API response
   * @return list<selectOption> The list of selectOption wrapper class.
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public list<selectOption> getSuspendReasons() {
    list<selectOption> serviceSuspensionReasonList = new List<selectOption>();
    Map<String, Object> suspensionReasonMap = new Map<String, Object>();
    suspensionReasonMap.put('status', 'ACTIVE');
    GTVAPIRestClient.ResponseWrapper reasonResponse = GTVAPI2Adapter.queryServiceSuspensionReasons(
      suspensionReasonMap
    );
    List<RestAPI2Domain.GTVAPIServiceSuspensionReason> serviceSuspensionReasonResponse = (List<RestAPI2Domain.GTVAPIServiceSuspensionReason>) reasonResponse.returnObject;
    if (
      null != serviceSuspensionReasonResponse &&
      !serviceSuspensionReasonResponse.isEmpty()
    ) {
      serviceSuspensionReasonList = GTVRESTMappingService.mapServiceSuspentionReasons(
        serviceSuspensionReasonResponse
      );
    }
    return serviceSuspensionReasonList;
  }

  public list<selectOption> getFormulaUsageRuleSpecificationListMethod() {
    return null;
  }

  /**
   * Query usage charge category from GTV db and return list<selectOption> after mapping the API response
   * @return list<selectOption> The list of selectOption wrapper class.
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public list<selectOption> getchargeCategoryListMethod() {
    list<selectOption> listOfchargeCategory = new List<selectOption>();
    Map<String, Object> chargeCategoryQueryParamsMap = new Map<String, Object>();
    chargeCategoryQueryParamsMap.put('status', 'ACTIVE');
    chargeCategoryQueryParamsMap.put('r_type', 'usage-charge');
    GTVAPIRestClient.ResponseWrapper categoryResponse = GTVAPI2Adapter.queryChargeCatogory(
      chargeCategoryQueryParamsMap
    );
    List<RestAPI2Domain.GTVAPIChargeCategory> categoryResponseMap = (List<RestAPI2Domain.GTVAPIChargeCategory>) categoryResponse.returnObject;
    if (null != categoryResponseMap && !categoryResponseMap.isEmpty()) {
      listOfchargeCategory = GTVRESTMappingService.mapChargeCategory(
        categoryResponseMap
      );
    }
    return listOfchargeCategory;
  }

  /**
   * Query rate tables UOM from GTV db
   * @param rateTableEid The GTV rate table id
   * @return string, The rate table UOM.
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public string getUOMRateTable(String rateTableEid) {
    String uom;
    Map<String, Object> rateTableQueryParamsMap = new Map<String, Object>();
    rateTableQueryParamsMap.put('status', 'ACTIVE');
    rateTableQueryParamsMap.put('id', rateTableEid);
    GTVAPIRestClient.ResponseWrapper TableResponse = GTVAPI2Adapter.queryRateTables(
      rateTableQueryParamsMap
    );
    List<RestAPI2Domain.GTVAPIRateTable> RateTableResponseMap = (List<RestAPI2Domain.GTVAPIRateTable>) TableResponse.returnObject;
    if (null != RateTableResponseMap && !RateTableResponseMap.isEmpty()) {
      uom = GTVRESTMappingService.mapRateTablesUom(RateTableResponseMap);
    }
    return uom;
  }

  /**
   * Query rate tables from GTV db and return list<selectOption> after mapping the API response
   * @return list<selectOption> The list of selectOption wrapper class.
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public list<selectOption> getchargeListBytesMethod() {
    list<selectOption> listOfRateTables = new List<selectOption>();
    Map<String, Object> rateTableQueryParamsMap = new Map<String, Object>();
    rateTableQueryParamsMap.put('status', 'ACTIVE');
    GTVAPIRestClient.ResponseWrapper TableResponse = GTVAPI2Adapter.queryRateTables(
      rateTableQueryParamsMap
    );
    List<RestAPI2Domain.GTVAPIRateTable> RateTableResponseMap = (List<RestAPI2Domain.GTVAPIRateTable>) TableResponse.returnObject;
    if (null != RateTableResponseMap && !RateTableResponseMap.isEmpty()) {
      listOfRateTables = GTVRESTMappingService.mapRateTables(
        RateTableResponseMap
      );
    }
    return listOfRateTables;
  }

  /**
   * Query credit adjustments reasons from GTV db and return list<selectOption> after mapping the API response
   * @return list<selectOption> The list of selectOption wrapper class.
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public list<selectOption> showCreditAdjustment() {
    list<selectOption> CreditAdjustmentReasonList = new List<selectOption>();
    Map<String, Object> creditAdjustmentReasonQueryMap = new Map<String, Object>();
    GTVAPIRestClient.ResponseWrapper creditAdjustmentResponseWrap = GTVAPI2Adapter.queryCreditAdjustmentReason(
      creditAdjustmentReasonQueryMap
    );
    List<RestAPI2Domain.GTVAPIAdjustmentReason> creditAdjustmentReasonResponse = (List<RestAPI2Domain.GTVAPIAdjustmentReason>) creditAdjustmentResponseWrap.returnObject;
    if (
      null != creditAdjustmentReasonResponse &&
      !creditAdjustmentReasonResponse.isEmpty()
    ) {
      CreditAdjustmentReasonList = GTVRESTMappingService.mapCreditAdjustmentReasons(
        creditAdjustmentReasonResponse
      );
    }
    return CreditAdjustmentReasonList;
  }

  /**
   * Query debit adjustments reasons from GTV db and return list<selectOption> after mapping the API response
   * @return list<selectOption> The list of selectOption wrapper class.
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public list<selectOption> showDebitAdjustment() {
    list<selectOption> debitAdjustmentReasonList = new List<selectOption>();
    Map<String, Object> debitAdjustmentReasonQueryMap = new Map<String, Object>();
    GTVAPIRestClient.ResponseWrapper debitAdjustmentResponseWrap = GTVAPI2Adapter.queryDeditAdjustmentReason(
      debitAdjustmentReasonQueryMap
    );
    List<RestAPI2Domain.GTVAPIAdjustmentReason> debitAdjustmentReasonResponse = (List<RestAPI2Domain.GTVAPIAdjustmentReason>) debitAdjustmentResponseWrap.returnObject;
    if (
      null != debitAdjustmentReasonResponse &&
      !debitAdjustmentReasonResponse.isEmpty()
    ) {
      debitAdjustmentReasonList = GTVRESTMappingService.mapDebitAdjustmentReasons(
        debitAdjustmentReasonResponse
      );
    }
    return debitAdjustmentReasonList;
  }

  /**
   * Query billing account suspension or deactivation reasons from GTV db and return list<selectOption> after mapping the API response
   * @param reasonFor The name of the reason to be fetched (required)
   * @return list<selectOption> The list of selectOption wrapper class.
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public list<selectOption> getBillingAccountStatus(String reasonFor) {
    list<selectOption> billingAccountReasonList = new List<selectOption>();
    Map<String, Object> accountReasonsParamMap = new Map<String, Object>();
    if (reasonFor == 'Suspend') {
      GTVAPIRestClient.ResponseWrapper billingAccountSuspensionReasonResponseWrap = GTVAPI2Adapter.getBillingAccountSuspensionReasons(
        accountReasonsParamMap
      );
      List<RestAPI2Domain.GTVAPIBillingAccountSuspensionReason> billingAccountSuspensionReasonResponse = (List<RestAPI2Domain.GTVAPIBillingAccountSuspensionReason>) billingAccountSuspensionReasonResponseWrap.returnObject;
      if (
        null != billingAccountSuspensionReasonResponse &&
        !billingAccountSuspensionReasonResponse.isEmpty()
      ) {
        billingAccountReasonList = GTVRESTMappingService.mapBillingAccountSuspensionReasons(
          billingAccountSuspensionReasonResponse
        );
      }
    } else if (reasonFor == 'Deactivate') {
      GTVAPIRestClient.ResponseWrapper billingAccountDeactivationReasonResponseWrap = GTVAPI2Adapter.getBillingAccountDeativationReasons(
        accountReasonsParamMap
      );
      List<RestAPI2Domain.GTVAPIBillingAccountDeactivationReason> billingAccountDeactivationReasonResponse = (List<RestAPI2Domain.GTVAPIBillingAccountDeactivationReason>) billingAccountDeactivationReasonResponseWrap.returnObject;
      if (
        null != billingAccountDeactivationReasonResponse &&
        !billingAccountDeactivationReasonResponse.isEmpty()
      ) {
        billingAccountReasonList = GTVRESTMappingService.mapBillingAccountDeactivationReasons(
          billingAccountDeactivationReasonResponse
        );
      }
    }
    return billingAccountReasonList;
  }

  /**
   * Query discount code from GTV db and return List<DiscountCodeWrapper> after mapping the API response
   * @param productEid The id of the product for which discount to be fetched (required)
   * @return list<DiscountCodeWrapper> The list of DiscountCodeWrapper wrapper class.
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public List<DiscountCodeWrapper> getDiscountCodesByProduct(
    String productEid
  ) {
    List<DiscountCodeWrapper> discountCodeList = new List<DiscountCodeWrapper>();
    Map<String, Object> discountCodeQueryFilterMap = new Map<String, Object>();
    discountCodeQueryFilterMap.put('productId', productEid);
    GTVAPIRestClient.ResponseWrapper discountCodeResponseWrap = GTVAPI2Adapter.getDiscountCodesByProduct(
      discountCodeQueryFilterMap
    );
    List<RestAPI2Domain.GTVAPIDiscountCode> discountCodeResponse = (List<RestAPI2Domain.GTVAPIDiscountCode>) discountCodeResponseWrap.returnObject;
    if (null != discountCodeResponse && !discountCodeResponse.isEmpty()) {
      discountCodeList = GTVRESTMappingService.mapDiscountCodeResponse(
        discountCodeResponse
      );
    }
    return discountCodeList;
  }

  /**
   * Create activity charge rule on a service in GTV db
   * @param serviceWrapper, The ProductServiceWrapper wrapper instance
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public void createNewActivityChargeRule(
    ProductServiceWrapper serviceWrapper
  ) {
    Map<String, Object> ActivityChargeRuleParamsMap = new Map<String, Object>();
    ActivityChargeRuleParamsMap.put('serviceId', serviceWrapper.serviceEid);
    ActivityChargeRuleParamsMap.put(
      'createServiceUsageRule',
      GTVRESTReverseMappingService.mapNewActivityChargeRule(serviceWrapper)
    );
    GTVAPIRestClient.ResponseWrapper relationResponse = GTVAPI2Adapter.createUsageRule(
      ActivityChargeRuleParamsMap
    );
  }

  public TractServiceWrapper getServiceByBillingAccount(List<Account> accList) {
    Account sfdcAccount;
    if (accList.size() > 0) {
      sfdcAccount = accList[0];
    }
    TractServiceWrapper billingAccountServiceWrapper = new TractServiceWrapper();
    Map<String, Object> servicesQueryParamsMap = new Map<String, Object>();
    servicesQueryParamsMap.put(
      'accountNum',
      sfdcAccount.Tract_Billing_Account__c
    );
    GTVAPIRestClient.ResponseWrapper serviceResponse = GTVAPI2Adapter.queryServices(
      servicesQueryParamsMap
    );
    List<RestAPI2Domain.GTVAPISFService> responseServiceMap = (List<RestAPI2Domain.GTVAPISFService>) serviceResponse.returnObject;
    if (null != responseServiceMap && !responseServiceMap.isEmpty()) {
      billingAccountServiceWrapper = GTVRESTMappingService.parseServices(
        responseServiceMap
      );
    }

    return billingAccountServiceWrapper;
  }
  /* API not available */
  public list<System_Setting__c> getSystemSettings() {
    return null;
  }

  public list<string> getRelatedProductNameByProductCode(String productEid) {
    list<String> listOfParentName = new List<String>();
    Map<String, Object> ProductRelationQueryParamsMap = new Map<String, Object>();
    ProductRelationQueryParamsMap.put('productId', productEid);
    GTVAPIRestClient.ResponseWrapper relationResponse = GTVAPI2Adapter.queryProductRelation(
      ProductRelationQueryParamsMap
    );
    List<RestAPI2Domain.GTVAPIProductRelation> responseRelationMap = (List<RestAPI2Domain.GTVAPIProductRelation>) relationResponse.returnObject;
    if (null != responseRelationMap && !responseRelationMap.isEmpty()) {
      listOfParentName = GTVRESTMappingService.mapProductRelation(
        responseRelationMap
      );
    }
    return listOfParentName;
  }

  public Set<String> getRelatedProductIdSet(String productEid) {
    Set<String> relatedProductIdSet = new Set<String>();
    Map<String, Object> ProductRelationQueryParamsMap = new Map<String, Object>();
    ProductRelationQueryParamsMap.put('productId', productEid);
    GTVAPIRestClient.ResponseWrapper relationResponse = GTVAPI2Adapter.queryProductRelation(
      ProductRelationQueryParamsMap
    );
    List<RestAPI2Domain.GTVAPIProductRelation> responseRelationMap = (List<RestAPI2Domain.GTVAPIProductRelation>) relationResponse.returnObject;
    if (null != responseRelationMap && !responseRelationMap.isEmpty()) {
      relatedProductIdSet = GTVRESTMappingService.mapProductRelationSelectService(
        responseRelationMap
      );
    }
    return relatedProductIdSet;
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
    Map<String, Object> servicesQueryParamsMap = new Map<String, Object>();
    Map<String, List<RestAPI2Domain.GTVAPIServiceResource>> servicesIDvsResoucesMap = new Map<String, List<RestAPI2Domain.GTVAPIServiceResource>>();
    servicesQueryParamsMap.put(
      'accountNum',
      thisAccount.Tract_Billing_Account__c
    );
    servicesQueryParamsMap.put('pageNumber', pagenumber);
    GTVAPIRestClient.ResponseWrapper getServices = GTVAPI2Adapter.queryServices(
      servicesQueryParamsMap
    );
    List<RestAPI2Domain.GTVAPISFService> responseServiceList = (List<RestAPI2Domain.GTVAPISFService>) getServices.returnObject;
    if (null != responseServiceList && !responseServiceList.isEmpty()) {
      for (RestAPI2Domain.GTVAPISFService srv : responseServiceList) {
        if (srv.serviceResources != null && srv.serviceResources.size() > 0) {
          Map<String, Object> serviceResourceQueryParamsMap = new Map<String, Object>();
          serviceResourceQueryParamsMap.put('serviceId', srv.id);
          GTVAPIRestClient.ResponseWrapper getServiceResources = GTVAPI2Adapter.queryServiceResourcesByService(
            serviceResourceQueryParamsMap
          );
          List<RestAPI2Domain.GTVAPIServiceResource> responseServiceResourceMap = (List<RestAPI2Domain.GTVAPIServiceResource>) getServiceResources.returnObject;
          if (
            null != responseServiceResourceMap &&
            !responseServiceResourceMap.isEmpty()
          ) {
            servicesIDvsResoucesMap.put(srv.id, responseServiceResourceMap);
          }
        }
      }
      serviceWrapper = GTVRESTMappingService.mapBillingAccountServices(
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
        responseServiceList,
        servicesIDvsResoucesMap,
        Integer.valueOf(getServices.totalPages)
      );
    }

    return serviceWrapper;
  }

  /* API not available */
  public RenewServiceWrapper showServices(
    list<Account> accList,
    String serviceRenewEid
  ) {
    return null;
  }
  public ServiceDetailWrapper getServiceById(
    ProductServiceWrapper serviceWrapper
  ) {
    ServiceDetailWrapper servDetail = new ServiceDetailWrapper();
    Map<String, Object> orderQueryParamsMap = new Map<String, Object>();
    orderQueryParamsMap.put('serviceId', serviceWrapper.serviceEid);
    GTVAPIRestClient.ResponseWrapper orderItemResponse = GTVAPI2Adapter.queryOrderItems(
      orderQueryParamsMap
    );
    List<RestAPI2Domain.GTVAPIOrderItem> responseOrderItemMap = (List<RestAPI2Domain.GTVAPIOrderItem>) orderItemResponse.returnObject;
    if (responseOrderItemMap != null && !responseOrderItemMap.isEmpty()) {
      servDetail = GTVRESTMappingService.mapServiceDetails(
        responseOrderItemMap
      );
    }
    servDetail.usageRuleInf = showUsageRule(serviceWrapper.serviceEid);

    Map<String, Object> serviceQueryParamsMap = new Map<String, Object>();
    serviceQueryParamsMap.put('id', serviceWrapper.serviceEid);
    GTVAPIRestClient.ResponseWrapper serviceResponse = GTVAPI2Adapter.getService(
      serviceQueryParamsMap
    );
    RestAPI2Domain.GTVAPIService serviceResponseMap = (RestAPI2Domain.GTVAPIService) serviceResponse.returnObject;
    if (null != serviceResponseMap) {
      servDetail.status = serviceResponseMap.status.name();
      servDetail.startDate = Date.valueOf(serviceResponseMap.startDate);
      servDetail.endDate = Date.valueOf(serviceResponseMap.endDate);
      servDetail.addressInf = GTVRESTMappingService.mapServiceAddress(
        serviceResponseMap
      );
    }
    List<DiscountCodeWrapper> codeList = new List<DiscountCodeWrapper>();
    GTVAPIRestClient.ResponseWrapper serviceDsicountResponse = GTVAPI2Adapter.queryDiscountCodeService(
      orderQueryParamsMap
    );
    List<RestAPI2Domain.GTVAPIDiscountCodeService> discountServiceResponse = (List<RestAPI2Domain.GTVAPIDiscountCodeService>) serviceDsicountResponse.returnObject;
    if (null != discountServiceResponse) {
      for (
        RestAPI2Domain.GTVAPIDiscountCodeService res : discountServiceResponse
      ) {
        DiscountCodeWrapper codeWrap = new DiscountCodeWrapper();
        Map<String, Object> QueryDiscountParamsMap = new Map<String, Object>();
        QueryDiscountParamsMap.put(
          'discountResourceId',
          res.discountResource.id
        );
        GTVAPIRestClient.ResponseWrapper DsicountIdentifierResponse = GTVAPI2Adapter.queryDiscountsByIdentifier(
          QueryDiscountParamsMap
        );
        List<RestAPI2Domain.GTVAPIDiscount> DsicountIdentifierResponseResponseMap = (List<RestAPI2Domain.GTVAPIDiscount>) DsicountIdentifierResponse.returnObject;
        codeWrap = GTVRESTMappingService.addDiscountCode(
          DsicountIdentifierResponseResponseMap[0]
        );
        codeWrap.code = res.discountCode.name;
        codeWrap.validFrom = Date.valueOf(res.validFrom);
        codeWrap.validTo = Date.valueOf(res.validTo);
        codeList.add(codeWrap);
      }
    }

    servDetail.discountInf = codeList;
    return servDetail;
  }

  public Object getAllChargeCategory() {
    Object listOfchargeCategory;
    Map<String, Object> chargeCategoryQueryParamsMap = new Map<String, Object>();
    chargeCategoryQueryParamsMap.put('status', 'ACTIVE');
    chargeCategoryQueryParamsMap.put('r_type', 'usage-charge');
    GTVAPIRestClient.ResponseWrapper categoryResponse = GTVAPI2Adapter.queryChargeCatogory(
      chargeCategoryQueryParamsMap
    );
    List<RestAPI2Domain.GTVAPIChargeCategory> categoryResponseMap = (List<RestAPI2Domain.GTVAPIChargeCategory>) categoryResponse.returnObject;
    if (null != categoryResponseMap && !categoryResponseMap.isEmpty()) {
      listOfchargeCategory = (Object) GTVRESTMappingService.mapChargeCategory(
        categoryResponseMap
      );
    }
    return listOfchargeCategory;
  }

  public Object getAllChargeBytes() {
    object listOfRateTables;
    Map<String, Object> chargeCategoryQueryParamsMap = new Map<String, Object>();
    chargeCategoryQueryParamsMap.put('status', 'ACTIVE');
    GTVAPIRestClient.ResponseWrapper TableResponse = GTVAPI2Adapter.queryRateTables(
      chargeCategoryQueryParamsMap
    );
    List<RestAPI2Domain.GTVAPIRateTable> RateTableResponseMap = (List<RestAPI2Domain.GTVAPIRateTable>) TableResponse.returnObject;
    if (null != RateTableResponseMap && !RateTableResponseMap.isEmpty()) {
      listOfRateTables = (Object) GTVRESTMappingService.mapRateTables(
        RateTableResponseMap
      );
    }
    return listOfRateTables;
  }

  public void getAccount(list<Account> thisAccount) {
  }

  public Object getAllGlobalUsageRule() {
    return null;
  }

  public ServiceResourceWrapper getServiceResourceById(String srId) {
    ServiceResourceWrapper srWrapper = new ServiceResourceWrapper();
    Map<String, Object> servicesResourceQueryParamsMap = new Map<String, Object>();
    servicesResourceQueryParamsMap.put('identifier', srId);
    GTVAPIRestClient.ResponseWrapper getServiceResource = GTVAPI2Adapter.queryServiceResource(
      servicesResourceQueryParamsMap
    );
    List<RestAPI2Domain.GTVAPIServiceResource> responseServiceResourceMap = (List<RestAPI2Domain.GTVAPIServiceResource>) getServiceResource.returnObject;
    srWrapper = GTVRESTMappingService.mapServiceResource(
      responseServiceResourceMap,
      srId
    );
    return srWrapper;
  }

  public void updateQuantityAddProduct(List<OpportunityLineItem> existingOLI) {
  }
  public String tractCreateDraftOrder(Map<String, String> information) {
    String emessage;
    Map<String, Object> orderParamsMap = new Map<String, Object>();
    RestAPI2Domain.GTVAPICreateSalesOrder createSalesOrder = new RestAPI2Domain.GTVAPICreateSalesOrder();
    RestAPI2Domain.GTVAPIOrder responseOrderMap;
    String orderNum;
    String accountNum;
    try {
      createSalesOrder = GTVRESTReverseMappingService.getDraftOrderRequest(
        information
      );
      orderParamsMap.put('id', information.get('BillingAccounteid'));
      orderParamsMap.put('order', createSalesOrder);
      GTVAPIRestClient.ResponseWrapper createOrder = GTVAPI2Adapter.createSalesOrder(
        orderParamsMap
      );
      responseOrderMap = (RestAPI2Domain.GTVAPIOrder) createOrder.returnObject;
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
    if (null != responseOrderMap) {
      orderNum = responseOrderMap.orderNum;
      accountNum = responseOrderMap.billingAccount.accountNum;
    } else {
      throw new MyException('Unable to find Sales Order Information in Tract');
    }
    TractSFDC_Util.updateOpportunity(
      information.get('OpportunityId'),
      orderNum,
      accountNum
    );
    return null;
  }

  public String tractCreateSalesOrder(Map<String, String> information) {
    String emessage;
    Map<String, Object> orderParamsMap = new Map<String, Object>();
    RestAPI2Domain.GTVAPICreateSalesOrder createSalesOrder = new RestAPI2Domain.GTVAPICreateSalesOrder();
    RestAPI2Domain.GTVAPIOrder responseOrderMap;
    String orderNum;
    String accountNum;
    try {
      createSalesOrder = GTVRESTReverseMappingService.getSalesOrderRequest(
        information
      );
      orderParamsMap.put('id', information.get('BillingAccounteid'));
      orderParamsMap.put('order', createSalesOrder);
      GTVAPIRestClient.ResponseWrapper createOrder = GTVAPI2Adapter.createSalesOrder(
        orderParamsMap
      );
      responseOrderMap = (RestAPI2Domain.GTVAPIOrder) createOrder.returnObject;
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
    if (null != responseOrderMap) {
      orderNum = responseOrderMap.orderNum;
      accountNum = responseOrderMap.billingAccount.accountNum;
    } else {
      throw new MyException('Unable to find Sales Order Information in Tract');
    }
    TractSFDC_Util.updateOpportunity(
      information.get('OpportunityId'),
      orderNum,
      accountNum
    );
    return null;
  }

  public ChangeSubscriptionWrapper showPopupService(
    String currentProductEid,
    String currencyType,
    Boolean preserveAgreement
  ) {
    ChangeSubscriptionWrapper subscriptionWrapper = new ChangeSubscriptionWrapper();
    try {
      Map<String, Object> orderItemQueryParamsMap = new Map<String, Object>();
      orderItemQueryParamsMap.put('serviceId', currentProductEid);
      Map<String, Object> compatibleProductsParamsMap = new Map<String, Object>();
      String priceListEid;
      Boolean enablePreserveAgreement;
      GTVAPIRestClient.ResponseWrapper orderItemResponse = GTVAPI2Adapter.queryOrderItems(
        orderItemQueryParamsMap
      );
      List<RestAPI2Domain.GTVAPIOrderItem> responseOrderItemMap = (List<RestAPI2Domain.GTVAPIOrderItem>) orderItemResponse.returnObject;
      if (null != responseOrderItemMap && !responseOrderItemMap.isEmpty()) {
        priceListEid = responseOrderItemMap[0].priceList.id;
        if (responseOrderItemMap[0].orderItemAgreement != null) {
          enablePreserveAgreement = true;
        } else {
          enablePreserveAgreement = false;
        }
      }
      compatibleProductsParamsMap.put('id', currentProductEid);
      GTVAPIRestClient.ResponseWrapper compatibleProductResponse = GTVAPI2Adapter.getCompatibleProducts(
        compatibleProductsParamsMap
      );
      List<RestAPI2Domain.GTVAPIProduct> compatibleProductList = (List<RestAPI2Domain.GTVAPIProduct>) compatibleProductResponse.returnObject;
      subscriptionWrapper = GTVRESTMappingService.mapCompatibleProducts(
        compatibleProductList,
        priceListEid,
        currencyType,
        enablePreserveAgreement
      );
    } catch (Exception ex) {
      subscriptionWrapper.errorMessage = ex.getMessage();
    }
    return subscriptionWrapper;
  }

  public void applyServiceResourceToService(
    String ServiceEid,
    String srId,
    Boolean isNew,
    String effectiveDate
  ) {
    Map<String, Object> addServiceResourceMap = new Map<String, Object>();
    Map<String, Object> serviceCategoryQueryMap = new Map<String, Object>();
    serviceCategoryQueryMap.put('resourceCategoryName', 'Default');
    GTVAPIRestClient.ResponseWrapper serviceResponseWrap = GTVAPI2Adapter.queryResourceCategory(
      serviceCategoryQueryMap
    );
    list<RestAPI2Domain.GTVAPIResourceCategory> serviceResponsemap = (list<RestAPI2Domain.GTVAPIResourceCategory>) serviceResponseWrap.returnObject;
    addServiceResourceMap.put('serviceId', ServiceEid);
    addServiceResourceMap.put(
      'addServiceResource',
      GTVRESTReverseMappingService.mapAddServiceResoure(
        srId,
        serviceResponsemap,
        effectiveDate
      )
    );
    GTVAPIRestClient.ResponseWrapper addServicsReourceResponse = GTVAPI2Adapter.saveServiceResource(
      addServiceResourceMap
    );
  }

  /* API not available */
  public void savePopupRenew(
    String renewAgreementEid,
    list<Account> accList,
    String serviceRenewEid,
    String recurringPriceString,
    String oneTimePriceString,
    Boolean dateOverridden,
    String deactivateDateString
  ) {
  }
  public void changeServiceResource(
    ProductServiceWrapper wrapperObj,
    String serviceResourceToBeApplied,
    Boolean isNewServiceResource,
    String effectiveDate,
    String parentServiceEid
  ) {
  }
  public List<Tract_Service_Custom_Field__c> getServiceCustomFieldByProduct(
    String productEid
  ) {
    List<Tract_Service_Custom_Field__c> serviceCustomFieldList = new List<Tract_Service_Custom_Field__c>();
    Map<String, Object> serviceCustomFieldsQueryMap = new Map<String, Object>();
    serviceCustomFieldsQueryMap.put('enabled', true);
    serviceCustomFieldsQueryMap.put('searchable', true);
    GTVAPIRestClient.ResponseWrapper serviceCustomFieldsResponseWrap = GTVAPI2Adapter.queryServiceCustomFields(
      serviceCustomFieldsQueryMap
    );
    List<RestAPI2Domain.GTVAPIServiceCustomField> serviceCustomFieldsResponse = (List<RestAPI2Domain.GTVAPIServiceCustomField>) serviceCustomFieldsResponseWrap.returnObject;
    if (
      null != serviceCustomFieldsResponse &&
      !serviceCustomFieldsResponse.isEmpty()
    ) {
      serviceCustomFieldList = GTVRESTMappingService.parseServiceCustomFields(
        serviceCustomFieldsResponse
      );
    }
    return serviceCustomFieldList;
  }

  /**
   * @description: Query related child products of the specified product in GTV db
   * @param productEid, The GTV product eid.
   * @return set<String>, The set of eid's of related products.
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public set<String> getRelatedChidProducts(String productEid) {
    set<String> setofRelatedProduct = new Set<String>();
    Map<String, Object> productRelationQueryParamsMap = new Map<String, Object>();
    ProductRelationQueryParamsMap.put('productId', productEid);
    GTVAPIRestClient.ResponseWrapper relationResponse = GTVAPI2Adapter.queryProductRelation(
      productRelationQueryParamsMap
    );
    List<RestAPI2Domain.GTVAPIProductRelation> responseRelationMap = (List<RestAPI2Domain.GTVAPIProductRelation>) relationResponse.returnObject;
    if (null != responseRelationMap && !responseRelationMap.isEmpty()) {
      setofRelatedProduct = GTVRESTMappingService.getRelatedChildProductNameList(
        responseRelationMap
      );
    }
    return setofRelatedProduct;
  }

  /**
   * @description: Query account custom field in GTV db
   * @param tractConfig, The tract setup custom setting instance.
   * @return list<SelectOption>, The list of account custom fields to be show as select option list on UI.
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public list<SelectOption> getCustomFieldForBilling(
    TRACT_Setup__c tractConfig
  ) {
    List<SelectOption> accountCustomFieldsWrapperList = new List<SelectOption>();
    Map<String, Object> accountCustomFieldsMap = new Map<String, Object>();
    accountCustomFieldsMap.put('enabled', true);
    accountCustomFieldsMap.put('searchable', true);
    GTVAPIRestClient.ResponseWrapper accountCustomFieldsResponse = GTVAPI2Adapter.queryAccountCustomFields(
      accountCustomFieldsMap,
      tractConfig
    );
    List<RestAPI2Domain.GTVAPIBillingAccountCustomField> tractAccountCustomFieldsList = (List<RestAPI2Domain.GTVAPIBillingAccountCustomField>) accountCustomFieldsResponse.returnObject;
    if (
      null != tractAccountCustomFieldsList &&
      !tractAccountCustomFieldsList.isEmpty()
    ) {
      accountCustomFieldsWrapperList = GTVRESTMappingService.parseAccountCustomFieldsForSYnc(
        tractAccountCustomFieldsList
      );
    }
    return accountCustomFieldsWrapperList;
  }

  /**
   * @description: Query one time order item from GTV db and return UI wrapper after mapping the API response
   * @param sfdcAccountWrapper TRACTAccountWrapper Instance
   * @return List<GTVOneTimeOrderItemWrapper>, The list of one time order item wrapper to be used on UI
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public List<GTVOneTimeOrderItemWrapper> getOneTimeOrderItemList(
    TRACTAccountWrapper sfdcAccountWrapper
  ) {
    List<GTVOneTimeOrderItemWrapper> oneTimeOrderItemWrapperList = new List<GTVOneTimeOrderItemWrapper>();
    Map<String, Object> orderFilterMap = new Map<String, Object>();
    orderFilterMap.put(
      'accountNum',
      sfdcAccountWrapper.TractBillingAccountNumber
    );
    GTVAPIRestClient.ResponseWrapper orderResponse = GTVAPI2Adapter.querySalesOrders(
      orderFilterMap
    );
    List<RestAPI2Domain.GTVAPIOrder> tractSalesOrdersList = (List<RestAPI2Domain.GTVAPIOrder>) orderResponse.returnObject;
    if (Integer.valueOf(orderResponse.totalPages) > 1) {
      for (integer i = 2; i <= Integer.valueOf(orderResponse.totalPages); i++) {
        Map<String, Object> orderQueryParamsLoopMap = new Map<String, Object>();
        orderQueryParamsLoopMap.put(
          'accountNum',
          sfdcAccountWrapper.TractBillingAccountNumber
        );
        orderQueryParamsLoopMap.put('pageNumber', i);
        GTVAPIRestClient.ResponseWrapper orderResponseInLoop = GTVAPI2Adapter.querySalesOrders(
          orderQueryParamsLoopMap
        );
        tractSalesOrdersList.addall(
          (List<RestAPI2Domain.GTVAPIOrder>) orderResponseInLoop.returnObject
        );
      }
    }
    if (null != tractSalesOrdersList && !tractSalesOrdersList.isEmpty()) {
      oneTimeOrderItemWrapperList = GTVRESTMappingService.parseOneTimeOrderItem(
        tractSalesOrdersList,
        sfdcAccountWrapper.accountCurrency
      );
    }
    return oneTimeOrderItemWrapperList;
  }

  /**
   * @description: Query product categories in GTV db
   * @return list<SelectOption>, The list of product categories to be show as select option list on UI.
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public list<SelectOption> queryProductCategories() {
    List<SelectOption> productCategoryList = new List<SelectOption>();
    Map<String, Object> productCategoryQueryMap = new Map<String, Object>();
    GTVAPIRestClient.ResponseWrapper productCategoryResponse = GTVAPI2Adapter.getProductCategory(
      productCategoryQueryMap
    );
    List<RestAPI2Domain.GTVAPIProductCategory> productCategoryResponseList = (List<RestAPI2Domain.GTVAPIProductCategory>) productCategoryResponse.returnObject;
    if (
      null != productCategoryResponseList &&
      !productCategoryResponseList.isEmpty()
    ) {
      productCategoryList = GTVRESTMappingService.mapProductcategoryResponse(
        productCategoryResponseList
      );
    }
    return productCategoryList;
  }

  /**
   * @description: Query service resource categories in GTV db
   * @return list<SelectOption>, The list of service resource categories to be show as select option list on UI.
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public list<SelectOption> queryServiceResourceCategories() {
    List<SelectOption> serviceResourceCategoryList = new List<SelectOption>();
    Map<String, Object> serviceResourceCategoryQueryMap = new Map<String, Object>();
    serviceResourceCategoryQueryMap.put('resourceType', 'service');
    GTVAPIRestClient.ResponseWrapper serviceResourceCategoryResponse = GTVAPI2Adapter.queryResourceCategory(
      serviceResourceCategoryQueryMap
    );
    List<RestAPI2Domain.GTVAPIResourceCategory> serviceResourceCategoryResponseList = (List<RestAPI2Domain.GTVAPIResourceCategory>) serviceResourceCategoryResponse.returnObject;
    if (
      null != serviceResourceCategoryResponseList &&
      !serviceResourceCategoryResponseList.isEmpty()
    ) {
      serviceResourceCategoryList = GTVRESTMappingService.mapServiceResourceCategoryResponse(
        serviceResourceCategoryResponseList
      );
    }
    return serviceResourceCategoryList;
  }

  /**
   * @description: Query product tags in GTV db
   * @return list<SelectOption>, The list of product tags to be show as select option list on UI.
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public list<SelectOption> queryProductTags() {
    List<SelectOption> productTagList = new List<SelectOption>();
    Map<String, Object> productTagQueryMap = new Map<String, Object>();
    GTVAPIRestClient.ResponseWrapper productTagResponse = GTVAPI2Adapter.getProductTags(
      ProductTagQueryMap
    );
    List<RestAPI2Domain.GTVAPIProductTag> productTagResponseList = (List<RestAPI2Domain.GTVAPIProductTag>) productTagResponse.returnObject;
    if (null != productTagResponseList && !productTagResponseList.isEmpty()) {
      productTagList = GTVRESTMappingService.mapProductTagResponse(
        productTagResponseList
      );
    }
    return productTagList;
  }

  /**
   * @description: Creates product in GTV db
   * @param createProductWrapper, The CreateProductWrapper wrapper instance.
   * @return String, Errormessage, if any
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public String createGtvProduct(CreateProductWrapper createProductWrapper) {
    String emessage = 'NoError';
    Map<String, Object> productParamsMap = new Map<String, Object>();
    RestAPI2Domain.GTVAPICreateProduct createGtvProduct = new RestAPI2Domain.GTVAPICreateProduct();
    RestAPI2Domain.GTVAPIProduct productResponse;
    try {
      createGtvProduct = GTVRESTReverseMappingService.getCreateProductRequest(
        createProductWrapper
      );
      productParamsMap.put('createProduct', createGtvProduct);
      GTVAPIRestClient.ResponseWrapper createProduct = GTVAPI2Adapter.createGtvProduct(
        productParamsMap
      );
      productResponse = (RestAPI2Domain.GTVAPIProduct) createProduct.returnObject;
      if (productResponse != null) {
        GTVRESTMappingService.mapProductCreationResponse(
          createProductWrapper.sfdcProductId,
          productResponse
        );
      }
    } catch (Exception e) {
      emessage = string.valueof(e.getmessage());
      return emessage;
    }
    return emessage;
  }

  /**
   * @description: get product type code list
   * @return list<SelectOption>, The list of product type code to be show as select option list on UI.
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public List<SelectOption> getProductTypeCode() {
    List<SelectOption> productTypeList = new List<SelectOption>();
    productTypeList.add(new selectOption('', 'Choose One'));
    productTypeList.add(new selectOption('add-on', 'Add-on'));
    productTypeList.add(new selectOption('general', 'One-Time'));
    productTypeList.add(
      new selectOption('customer-subscription', 'Subscription')
    );
    return productTypeList;
  }

  /**
   * @description: Query product Register types in GTV db
   * @return list<SelectOption>, The list of roduct Register types to be show as select option list on UI.
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public list<SelectOption> queryProductRegisterTypes() {
    List<SelectOption> productRegisterTypeList = new List<SelectOption>();
    Map<String, Object> productRegisterTypeQueryMap = new Map<String, Object>();
    GTVAPIRestClient.ResponseWrapper productRegisterTypeResponse = GTVAPI2Adapter.getProductRegisterTypes(
      productRegisterTypeQueryMap
    );
    List<RestAPI2Domain.GTVAPIProductRegisterType> productRegisterTypeResponseList = (List<RestAPI2Domain.GTVAPIProductRegisterType>) productRegisterTypeResponse.returnObject;
    if (
      null != productRegisterTypeResponseList &&
      !productRegisterTypeResponseList.isEmpty()
    ) {
      productRegisterTypeList = GTVRESTMappingService.mapProductRegisterTypeResponse(
        productRegisterTypeResponseList
      );
    }
    return productRegisterTypeList;
  }

  /**
   * @description: Query Agreements in GTV db
   * @return List<ProductAgreementWrapper>, The list of ProductAgreementWrapper.
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public List<ProductAgreementWrapper> getAllAgreements() {
    list<ProductAgreementWrapper> listOfAgreements = new List<ProductAgreementWrapper>();
    Map<String, Object> agreementsMap = new Map<String, Object>();
    AgreementsMap.put('status', 'ACTIVE');
    GTVAPIRestClient.ResponseWrapper agreementsResponse = GTVAPI2Adapter.queryAgreements(
      agreementsMap
    );
    List<RestAPI2Domain.GTVAPIAgreement> tractAgreements = (List<RestAPI2Domain.GTVAPIAgreement>) agreementsResponse.returnObject;
    if (Integer.valueOf(AgreementsResponse.totalPages) > 1) {
      for (
        integer i = 2; i <= Integer.valueOf(AgreementsResponse.totalPages); i++
      ) {
        Map<String, Object> agreementsQueryParamsLoopMap = new Map<String, Object>();
        agreementsQueryParamsLoopMap.put('status', 'ACTIVE');
        agreementsQueryParamsLoopMap.put('pageNumber', i);
        GTVAPIRestClient.ResponseWrapper agreementsResponseInLoop = GTVAPI2Adapter.queryAgreements(
          agreementsQueryParamsLoopMap
        );
        tractAgreements.addall(
          (List<RestAPI2Domain.GTVAPIAgreement>) agreementsResponseInLoop.returnObject
        );
      }
    }
    if (null != tractAgreements && !tractAgreements.isEmpty()) {
      listOfAgreements = GTVRESTMappingService.mapAllAgreements(
        tractAgreements
      );
    }
    return listOfAgreements;
  }

  /**
   * @description: Creates Agreement on a product in GTV db
   * @param agreementList, The list of agreement to be created in GTV.
   * @param productId, The GTV product id.
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public void setProductAgreement(
    List<ProductAgreementWrapper> agreementList,
    String productId
  ) {
    for (ProductAgreementWrapper agreement : agreementList) {
      Map<String, Object> agreementsMap = new Map<String, Object>();
      agreementsMap.put('productId', productId);
      agreementsMap.put(
        'createProductAgreementRelation',
        GTVRESTReverseMappingService.mapProductNewAgreements(agreement)
      );
      GTVAPIRestClient.ResponseWrapper agreementsResponse = GTVAPI2Adapter.createProductAgreement(
        agreementsMap
      );
    }
  }

  /**
   * @description: Get recurrence period from Enum
   * @return list<SelectOption>, The list of recurrence period to be show as select option list on UI.
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public list<SelectOption> getRecurrencePeriod() {
    List<SelectOption> recurrencePeriodList = new List<SelectOption>();
    List<RestAPI2Domain.GTVAPIRecurrencePeriod> recurrencePeriodEnumList = RestAPI2Domain.GTVAPIRecurrencePeriod.values();
    if (recurrencePeriodEnumList != null) {
      recurrencePeriodList = GTVRESTMappingService.mapRecurrencePeriod(
        recurrencePeriodEnumList
      );
    }
    return recurrencePeriodList;
  }

  /**
   * @description: Query product price group in GTV db
   * @return list<SelectOption>, The list of product price groups to be show as select option list on UI.
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public list<SelectOption> getProductPriceGroup() {
    List<SelectOption> productPriceGroupList = new List<SelectOption>();
    Map<String, Object> productPriceGroupQueryMap = new Map<String, Object>();
    GTVAPIRestClient.ResponseWrapper productPriceGroupResponse = GTVAPI2Adapter.getProductPriceGroups(
      productPriceGroupQueryMap
    );
    List<RestAPI2Domain.GTVAPIProductPriceGroup> productPriceGroupResponseList = (List<RestAPI2Domain.GTVAPIProductPriceGroup>) productPriceGroupResponse.returnObject;
    if (
      null != productPriceGroupResponseList &&
      !productPriceGroupResponseList.isEmpty()
    ) {
      productPriceGroupList = GTVRESTMappingService.mapProductPriceGroupResponse(
        productPriceGroupResponseList
      );
    }
    return productPriceGroupList;
  }

  /**
   * @description: Creates recurring product price in GTV db
   * @param productId, The GTV product id.
   * @param agreementWrap, The ProductAgreementWrapper wrapper instance.
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public void removeAgreementRelation(
    String productId,
    ProductAgreementWrapper agreementWrap
  ) {
    Map<String, Object> agreementsMap = new Map<String, Object>();
    agreementsMap.put('productId', productId);
    agreementsMap.put('agreement_id', agreementWrap.eid);
    GTVAPIRestClient.ResponseWrapper agreementRelationResponse = GTVAPI2Adapter.getAgreementRelation(
      agreementsMap
    );
    List<RestAPI2Domain.GTVAPIProductAgreementRelation> agreementRelationResponseList = (List<RestAPI2Domain.GTVAPIProductAgreementRelation>) agreementRelationResponse.returnObject;
    String agreementRelationId = agreementRelationResponseList[0].id;
    agreementsMap = new Map<String, Object>();
    agreementsMap.put('productId', productId);
    agreementsMap.put('id', agreementRelationId);
    GTVAPI2Adapter.removeAgreementRelation(agreementsMap);
  }

  /**
   * @description: Query price category in GTV db
   * @return list<SelectOption>, The list of price categories to be show as select option list on UI.
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public list<SelectOption> queryPriceCategories() {
    List<SelectOption> priceCategoryList = new List<SelectOption>();
    Map<String, Object> priceCategoryQueryMap = new Map<String, Object>();
    priceCategoryQueryMap.put('r_type', 'price');
    GTVAPIRestClient.ResponseWrapper priceCategoryResponse = GTVAPI2Adapter.queryChargeCatogory(
      priceCategoryQueryMap
    );
    List<RestAPI2Domain.GTVAPIChargeCategory> priceCategoryResponseList = (List<RestAPI2Domain.GTVAPIChargeCategory>) priceCategoryResponse.returnObject;
    if (
      null != priceCategoryResponseList && !priceCategoryResponseList.isEmpty()
    ) {
      priceCategoryList = GTVRESTMappingService.mappriceCategoryResponse(
        priceCategoryResponseList
      );
    }
    return priceCategoryList;
  }

  /**
   * @description: Creates recurring product price in GTV db
   * @param createProductPriceWrapper, The CreateRecurringChargePriceWrapper wrapper instance.
   * @param priceListId, The GTV pricelist id.
   * @return String, Errormessage, if any
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public String createGtvRecurringProductPrice(
    CreateRecurringChargePriceWrapper createProductPriceWrapper,
    String priceListId
  ) {
    String emessage = 'NoError';
    Map<String, Object> recurringProductPriceParamsMap = new Map<String, Object>();
    RestAPI2Domain.GTVAPICreateProductPrice createProductPriceRequest = new RestAPI2Domain.GTVAPICreateProductPrice();
    RestAPI2Domain.GTVAPIProductPrice productPriceCreationResponse;
    try {
      createProductPriceRequest = GTVRESTReverseMappingService.getCreateProductPriceRequest(
        createProductPriceWrapper
      );
      recurringProductPriceParamsMap.put(
        'createProductPrice',
        createProductPriceRequest
      );
      recurringProductPriceParamsMap.put(
        'productId',
        createProductPriceWrapper.productId
      );
      if (createProductPriceWrapper.eid != null) {
        recurringProductPriceParamsMap.put('id', createProductPriceWrapper.eid);
      }
      GTVAPIRestClient.ResponseWrapper createProductPrice = GTVAPI2Adapter.createGtvProductPrice(
        recurringProductPriceParamsMap
      );
      productPriceCreationResponse = (RestAPI2Domain.GTVAPIProductPrice) createProductPrice.returnObject;
      if (productPriceCreationResponse != null) {
        List<RestAPI2Domain.GTVAPIProductPrice> productPriceList = new List<RestAPI2Domain.GTVAPIProductPrice>();
        Map<String, Object> productPriceQueryMap = new Map<String, Object>();
        productPriceQueryMap.put(
          'productId',
          createProductPriceWrapper.productId
        );
        GTVAPIRestClient.ResponseWrapper queryProductPrice = GTVAPI2Adapter.queryProductPrices(
          productPriceQueryMap
        );
        if (queryProductPrice != null) {
          productPriceList = (List<RestAPI2Domain.GTVAPIProductPrice>) queryProductPrice.returnObject;
          GTVRESTMappingService.mapProductPriceCreationResponse(
            createProductPriceWrapper.sfdcProductId,
            productPriceList
          );
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
    boolean updateProductPriceFlag = true;
    Map<String, Object> recurringProductPriceParamsMap = new Map<String, Object>();
    RestAPI2Domain.GTVAPICreateProductPrice createProductPriceRequest = new RestAPI2Domain.GTVAPICreateProductPrice();
    RestAPI2Domain.GTVAPIProductPrice productPriceCreationResponse;
    try {
      createProductPriceRequest = GTVRESTReverseMappingService.getCreateProductPriceRequest(
        createProductPriceWrapper
      );
      recurringProductPriceParamsMap.put(
        'createProductPrice',
        createProductPriceRequest
      );
      recurringProductPriceParamsMap.put(
        'productId',
        createProductPriceWrapper.productId
      );
      recurringProductPriceParamsMap.put(
        'updateProductPrice',
        updateProductPriceflag
      );
      recurringProductPriceParamsMap.put('id', createProductPriceWrapper.eid);
      GTVAPIRestClient.ResponseWrapper updateProductPrice = GTVAPI2Adapter.updateGtvProductPrice(
        recurringProductPriceParamsMap
      );
      productPriceCreationResponse = (RestAPI2Domain.GTVAPIProductPrice) updateProductPrice.returnObject;
      if (productPriceCreationResponse != null) {
        List<RestAPI2Domain.GTVAPIProductPrice> productPriceList = new List<RestAPI2Domain.GTVAPIProductPrice>();
        Map<String, Object> productPriceQueryMap = new Map<String, Object>();
        productPriceQueryMap.put(
          'productId',
          createProductPriceWrapper.productId
        );
        GTVAPIRestClient.ResponseWrapper queryProductPrice = GTVAPI2Adapter.queryProductPrices(
          productPriceQueryMap
        );
        if (queryProductPrice != null) {
          productPriceList = (List<RestAPI2Domain.GTVAPIProductPrice>) queryProductPrice.returnObject;
          GTVRESTMappingService.mapProductPriceCreationResponse(
            createProductPriceWrapper.sfdcProductId,
            productPriceList
          );
        }
      }
    } catch (Exception e) {
      emessage = string.valueof(e.getmessage());
      return emessage;
    }
    return emessage;
  }

  /**
   * @description: Change the status of a product to available in GTV db
   * @param productId, The GTV product id.
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public void makeProductAvailable(String productId) {
    Map<String, Object> productMap = new Map<String, Object>();
    productMap.put('id', productId);
    GTVAPI2Adapter.activateProduct(productMap);
  }

  /**
   * @description: Creates one time product price in GTV db
   * @param createOneTimeProductPriceWrapper, The createOneTimeProductPriceWrapper wrapper instance.
   * @param priceListId, The GTV pricelist id.
   * @return String, Errormessage, if any
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public String createGtvOneTimeProductPrice(
    CreateOneTimeChargePriceWrapper createOneTimeProductPriceWrapper,
    String priceListId
  ) {
    String emessage = 'NoError';
    Map<String, Object> oneTimeProductPriceParamsMap = new Map<String, Object>();
    RestAPI2Domain.GTVAPICreateProductPrice createProductPriceRequest = new RestAPI2Domain.GTVAPICreateProductPrice();
    RestAPI2Domain.GTVAPIProductPrice productPriceCreationResponse;
    try {
      createProductPriceRequest = GTVRESTReverseMappingService.getCreateOneTimeProductPriceRequest(
        createOneTimeProductPriceWrapper
      );
      oneTimeProductPriceParamsMap.put(
        'createProductPrice',
        createProductPriceRequest
      );
      oneTimeProductPriceParamsMap.put(
        'productId',
        createOneTimeProductPriceWrapper.productId
      );
      GTVAPIRestClient.ResponseWrapper createProductPrice = GTVAPI2Adapter.createGtvProductPrice(
        oneTimeProductPriceParamsMap
      );
      productPriceCreationResponse = (RestAPI2Domain.GTVAPIProductPrice) createProductPrice.returnObject;
      if (productPriceCreationResponse != null) {
        List<RestAPI2Domain.GTVAPIProductPrice> productPriceList = new List<RestAPI2Domain.GTVAPIProductPrice>();
        Map<String, Object> productPriceQueryMap = new Map<String, Object>();
        productPriceQueryMap.put(
          'productId',
          createOneTimeProductPriceWrapper.productId
        );
        GTVAPIRestClient.ResponseWrapper queryProductPrice = GTVAPI2Adapter.queryProductPrices(
          productPriceQueryMap
        );
        if (queryProductPrice != null) {
          productPriceList = (List<RestAPI2Domain.GTVAPIProductPrice>) queryProductPrice.returnObject;
          GTVRESTMappingService.mapProductPriceCreationResponse(
            createOneTimeProductPriceWrapper.sfdcProductId,
            productPriceList
          );
        }
      }
    } catch (Exception e) {
      emessage = string.valueof(e.getmessage());
      return emessage;
    }
    return emessage;
  }

  /**
   * @description: Query Product custom field in GTV db
   * @param productId, The GTV product id(required)
   * @return list<productCustomFieldValueWrapper>, the list of product custom field wrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public list<ProductCustomFieldWrapper> queryProductCustomFields(
    String productId
  ) {
    List<ProductCustomFieldWrapper> productCustomFieldList = new List<ProductCustomFieldWrapper>();
    Map<String, Object> productCustomFieldValueQueryMap = new Map<String, Object>();
    Map<String, String> productCustomFieldValuesMap = new Map<String, String>();
    productCustomFieldValueQueryMap.put('productId', productId);
    GTVAPIRestClient.ResponseWrapper productCustomFieldsValueResponse = GTVAPI2Adapter.queryProductCustomFieldValues(
      productCustomFieldValueQueryMap
    );
    List<RestAPI2Domain.GTVAPIProductCustomFieldValue> valueResponseMap = (List<RestAPI2Domain.GTVAPIProductCustomFieldValue>) productCustomFieldsValueResponse.returnObject;
    if (null != ValueResponseMap && !ValueResponseMap.isEmpty()) {
      productCustomFieldValuesMap = GTVRESTMappingService.mapProductCustomFieldValues(
        valueResponseMap
      );
    }
    Map<String, Object> productCustomFieldQueryMap = new Map<String, Object>();
    productCustomFieldQueryMap.put('enabled', true);
    productCustomFieldQueryMap.put('searchable', true);
    GTVAPIRestClient.ResponseWrapper productCustomFieldResponse = GTVAPI2Adapter.getProductCustomFields(
      productCustomFieldQueryMap
    );
    List<RestAPI2Domain.GTVAPIProductCustomField> productCustomFieldResponseList = (List<RestAPI2Domain.GTVAPIProductCustomField>) productCustomFieldResponse.returnObject;
    if (
      null != productCustomFieldResponseList &&
      !productCustomFieldResponseList.isEmpty()
    ) {
      productCustomFieldList = GTVRESTMappingService.parseproductCustomFields(
        productCustomFieldResponseList,
        productCustomFieldValuesMap
      );
    }
    return ProductCustomFieldList;
  }

  /**
   * @description: Query Product custom field value in GTV db
   * @param productEid, The GTV product id(required)
   * @return list<productCustomFieldValueWrapper>, the list of product custom field wrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public list<productCustomFieldValueWrapper> queryProductCustomFieldValues(
    String productEid
  ) {
    List<productCustomFieldValueWrapper> productCustomFieldValueList = new List<productCustomFieldValueWrapper>();
    Map<String, Object> productCustomFieldValueQueryMap = new Map<String, Object>();
    productCustomFieldValueQueryMap.put('productId', productEid);
    GTVAPIRestClient.ResponseWrapper productCustomFieldsValueResponse = GTVAPI2Adapter.queryProductCustomFieldValues(
      productCustomFieldValueQueryMap
    );
    List<RestAPI2Domain.GTVAPIProductCustomFieldValue> valueResponseMap = (List<RestAPI2Domain.GTVAPIProductCustomFieldValue>) productCustomFieldsValueResponse.returnObject;
    if (null != ValueResponseMap && !ValueResponseMap.isEmpty()) {
      productCustomFieldValueList = GTVRESTMappingService.parseProductCustomFieldValues(
        valueResponseMap
      );
    }
    return productCustomFieldValueList;
  }

  /**
   * @description: save Product custom field value in GTV db
   * @param tractBillingAccount The wrapper of the billing account(required)
   * @param customFildWrapper the list of product custom field wrapper in stringify form(required)
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public String saveProductCustomFieldValues(
    String productEid,
    String customFildWrapper
  ) {
    String emessage = 'No error';
    list<ProductCustomFieldWrapper> wrap = (list<ProductCustomFieldWrapper>) JSON.deserialize(
      customFildWrapper,
      List<ProductCustomFieldWrapper>.class
    );
    list<RestAPI2Domain.GTVAPICreateProductCustomFieldValue> mapCustomFieldRequest = GTVRESTReverseMappingService.mapProductCustomFieldValueRequest(
      wrap
    );
    if (mapCustomFieldRequest.size() > 0) {
      for (
        RestAPI2Domain.GTVAPICreateProductCustomFieldValue Value : mapCustomFieldRequest
      ) {
        Map<String, Object> saveProductCustomFieldValueParameterMap = new Map<String, Object>();
        saveProductCustomFieldValueParameterMap.put('productId', productEid);
        saveProductCustomFieldValueParameterMap.put(
          'productCustomFieldValue',
          Value
        );
        try {
          GTVAPI2Adapter.saveProductCustomFieldValue(
            saveProductCustomFieldValueParameterMap
          );
        } catch (Exception e) {
          if (e.getmessage().contains('Validation')) {
            emessage = e.getmessage()
              .substring(
                e.getmessage().indexOf('Validation error: '),
                e.getmessage().indexOf(' faultcode=')
              );
          } else if (e.getmessage().contains('ExecutionException')) {
            emessage = string.valueof(e.getmessage());
            emessage = emessage.substringAfter(
              'common.apex.runtime.impl.ExecutionException:'
            );
          } else {
            emessage = string.valueof(e.getmessage());
          }
        }
      }
    }
    return emessage;
  }

  /**
   * @description: This method queryMarketPlace in GTV db.
   * @return list<MarketPlaceWrapper>, The MarketPlaceWrapper wrapper list
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public list<MarketPlaceWrapper> getMarketPlace() {
    List<MarketPlaceWrapper> marketPlaceValueList = new List<MarketPlaceWrapper>();
    Map<String, Object> marketPlaceValueParameterMap = new Map<String, Object>();
    GTVAPIRestClient.ResponseWrapper marketPlaceValueResponse = GTVAPI2Adapter.queryMarketPlaces(
      marketPlaceValueParameterMap
    );
    List<RestAPI2Domain.GTVAPIMarketplace> valueResponseMap = (List<RestAPI2Domain.GTVAPIMarketplace>) marketPlaceValueResponse.returnObject;
    if (null != valueResponseMap && !valueResponseMap.isEmpty()) {
      marketPlaceValueList = GTVRESTMappingService.parseMarketPlaceValues(
        valueResponseMap
      );
    }
    return marketPlaceValueList;
  }

  /**
   * @description: This method query pricelist in the specified marketplace.
   * @param MarketPlaceWrap, The MarketPlaceWrapper wrapper instance(required)
   * @return list<PriceListWrapper>, The PriceListWrapper wrapper list
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public list<PriceListWrapper> getMarketPlacePriceList(
    MarketPlaceWrapper marketPlaceWrap
  ) {
    List<PriceListWrapper> marketPlacePriceListValueList = new List<PriceListWrapper>();
    Map<String, Object> marketPlaceValueParameterMap = new Map<String, Object>();
    marketPlaceValueParameterMap.put('marketplaceId', marketPlaceWrap.mplaceId);
    GTVAPIRestClient.ResponseWrapper marketPlaceValueResponse = GTVAPI2Adapter.queryPriceLists(
      marketPlaceValueParameterMap
    );
    List<RestAPI2Domain.GTVAPIPriceList> valueResponseMap = (List<RestAPI2Domain.GTVAPIPriceList>) marketPlaceValueResponse.returnObject;
    if (null != valueResponseMap && !valueResponseMap.isEmpty()) {
      marketPlacePriceListValueList = GTVRESTMappingService.parseMarketPlacePriceLists(
        valueResponseMap
      );
    }
    return marketPlacePriceListValueList;
  }

  /**
   * @description: This method add products to pricelist in GTV db.
   * @param priceListEid, The GTV pricelist id(required)
   * @param selectedProducts, The list of product to add to the pricelist(required)
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public void addProductToPriceList(
    String priceListEid,
    list<String> selectedProducts
  ) {
    if (selectedProducts.size() > 0) {
      for (String str : selectedProducts) {
        Map<String, Object> addProductMap = new Map<String, Object>();
        addProductMap.put('priceListId', priceListEid);
        addProductMap.put(
          'productRelation',
          GTVRESTReverseMappingService.mapProductToPriceList(str)
        );
        GTVAPI2Adapter.associateProduct(addProductMap);
      }
      TractSFDC_Util.addPriceListToProduct(selectedProducts, priceListEid);
    }
  }

  /**
   * @description: This method remove products from pricelist in GTV db.
   * @param priceListEid, The GTV pricelist id(required)
   * @param selectedProducts, The list of product to be removed from the pricelist(required)
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public void removeProductToPriceList(
    String priceListEid,
    list<String> selectedProducts
  ) {
    if (selectedProducts.size() > 0) {
      for (String str : selectedProducts) {
        Map<String, Object> productRelationMap = new Map<String, Object>();
        productRelationMap.put('priceListId', priceListEid);
        productRelationMap.put('productId', str);
        GTVAPIRestClient.ResponseWrapper productRelationValueResponse = GTVAPI2Adapter.getPriceListRelation(
          productRelationMap
        );
        list<RestAPI2Domain.GTVAPIPriceListProductRelation> valueResponseMap = (List<RestAPI2Domain.GTVAPIPriceListProductRelation>) productRelationValueResponse.returnObject;
        Map<String, Object> productPriceListRelationMap = new Map<String, Object>();
        productRelationMap.put('priceListId', priceListEid);
        productRelationMap.put('id', valueResponseMap[0].id);
        GTVAPI2Adapter.removePriceListProductRelation(productRelationMap);
      }
      TractSFDC_Util.removePriceListFromProduct(selectedProducts, priceListEid);
    }
  }

  /**
   * @description: This method remove marketplace in GTV db.
   * @param mPlaceId, The GTV marketplace id
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public void removeThisMarketPlace(String mPlaceId) {
    Map<String, Object> marketPlaceIdMap = new Map<String, Object>();
    marketPlaceIdMap.put('id', mPlaceId);
    GTVAPI2Adapter.removeMarketPlace(marketPlaceIdMap);
  }

  /**
   * @description: This method query product relation in GTV db.
   * @param productId, The GTV product id
   * @return list<ProductRelationWrapper>, The product relation wrapper list
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public list<ProductRelationWrapper> queryProductRelation(String productEid) {
    list<ProductRelationWrapper> productRelationWrapperList = new List<ProductRelationWrapper>();
    Map<String, Object> productRelationQueryParamsMap = new Map<String, Object>();
    ProductRelationQueryParamsMap.put('productId', productEid);
    GTVAPIRestClient.ResponseWrapper relationResponse = GTVAPI2Adapter.queryProductRelation(
      productRelationQueryParamsMap
    );
    List<RestAPI2Domain.GTVAPIProductRelation> productRelationResponse = (List<RestAPI2Domain.GTVAPIProductRelation>) relationResponse.returnObject;
    if (null != productRelationResponse && !productRelationResponse.isEmpty()) {
      productRelationWrapperList = GTVRESTMappingService.mapProductRelationShip(
        productRelationResponse
      );
    }
    return productRelationWrapperList;
  }

  /**
   * @description: This method remove product relation in GTV db.
   * @param productId, The GTV product id(required)
   * @param relationWrap, The product relation wrapper instance(required)
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public void removeProductRelation(
    String productId,
    ProductRelationWrapper relationWrap
  ) {
    Map<String, Object> productRelationMap = new Map<String, Object>();
    productRelationMap.put('productId', productId);
    productRelationMap.put('id', relationWrap.productRelationShipEid);
    GTVAPI2Adapter.removeProductRelation(productRelationMap);
  }

  /**
   * @description: This method query child billing account in GTV db.
   * @param accountEid The parent billing account id(required)
   * @return list<TRACTAccountWrapper> , The list of billing account wrapper to be used on UI.
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public list<TRACTAccountWrapper> getChildDetails(String accountEid) {
    list<TRACTAccountWrapper> sfdcBillingAccountWrapperList = new List<TRACTAccountWrapper>();
    Map<String, Object> paramsMap = new Map<String, Object>();
    //prepare parameters for API callout
    paramsMap.put('parentId', accountEid);
    //make the API callout
    GTVAPIRestClient.ResponseWrapper apiCallOutResponse = GTVAPI2Adapter.querybillingAccount(
      paramsMap
    );
    //type cast the response from object to RestAPI2Domain billing account wrapper
    List<RestAPI2Domain.GTVAPIBillingAccount> tractBillingAccount = (List<RestAPI2Domain.GTVAPIBillingAccount>) apiCallOutResponse.returnObject;
    if (null != tractBillingAccount) {
      //call the method to parse the domain wrapper and mapp to the UI wrapper
      sfdcBillingAccountWrapperList = GTVRESTMappingService.parseChildAccountList(
        tractBillingAccount
      );
    }
    return sfdcBillingAccountWrapperList;
  }

  public BillingHierarchyWrapper queryBillingHierarchy(
    String responsibleAccountEid
  ) {
    BillingHierarchyWrapper billingHierarchyWrap = new BillingHierarchyWrapper();
    return billingHierarchyWrap;
  }

  /**
   * @description: This method query default MarketPlace in GTV db.
   * @return String , The GTV id of default marketplace.
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public String getDefaultMarketPlaceId() {
    Map<String, Object> marketPlaceValueParameterMap = new Map<String, Object>();
    marketPlaceValueParameterMap.put('name', 'Default Marketplace');
    GTVAPIRestClient.ResponseWrapper marketPlaceValueResponse = GTVAPI2Adapter.queryMarketPlaces(
      marketPlaceValueParameterMap
    );
    List<RestAPI2Domain.GTVAPIMarketplace> valueResponseMap = (List<RestAPI2Domain.GTVAPIMarketplace>) marketPlaceValueResponse.returnObject;
    if (null != valueResponseMap && !valueResponseMap.isEmpty()) {
      return valueResponseMap[0].id;
    }
    return null;
  }

  /**
   * @description: This method query MarketPlace in GTV db.
   * @param tractConfig The configuration custom setting instance(required)
   * @return List<SelectOption> , List of marketplaces as selection option to be shown on GTV UI.
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public List<SelectOption> getAllMarketPlace(TRACT_Setup__c tractConfig) {
    list<SelectOption> listOfMarketPlace = new List<SelectOption>();
    Map<String, Object> marketPlaceValueParameterMap = new Map<String, Object>();
    GTVAPIRestClient.ResponseWrapper marketPlaceValueResponse = GTVAPI2Adapter.queryMarketPlaces(
      marketPlaceValueParameterMap,
      tractConfig
    );
    List<RestAPI2Domain.GTVAPIMarketplace> valueResponseMap = (List<RestAPI2Domain.GTVAPIMarketplace>) marketPlaceValueResponse.returnObject;
    if (null != valueResponseMap && !valueResponseMap.isEmpty()) {
      listOfMarketPlace = GTVRESTMappingService.parseMarketPlaces(
        valueResponseMap
      );
    }
    return listOfMarketPlace;
  }

  /**
   * @description: This method checks existing service resource with the specified identifier in GTV db.
   * @param srId The service resource identifier (required)
   * @return String , error message, if any
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public String checkExistingServicesource(String srId) {
    String emessage = 'NoError';
    Map<String, Object> servicesResourceQueryParamsMap = new Map<String, Object>();
    servicesResourceQueryParamsMap.put('identifier', srId);
    GTVAPIRestClient.ResponseWrapper existingServiceResource = GTVAPI2Adapter.queryServiceResource(
      servicesResourceQueryParamsMap
    );
    List<RestAPI2Domain.GTVAPIServiceResource> responseServiceResourceMap = (List<RestAPI2Domain.GTVAPIServiceResource>) existingServiceResource.returnObject;
    if (
      responseServiceResourceMap != null &&
      responseServiceResourceMap.size() > 0
    ) {
      emessage = 'Entered Service Identifier already exists in system.';
    }
    return emessage;
  }
  /**
   * @description: Create billing account in GTV db using Global Action.
   * @param AccountId The id of the Salesforce Account to be created in GTV(required)
   * @param billingAccountString billing account create request in stringify form(required)
   * @return CreateAccountResponse AccountResponse returned when creating an account
   */
  public CreateAccountResponse createAccountGlobalAction(
    Id accountId,
    String billingAccountString
  ) {
    CreateAccountResponse accountRes = GTVAPI2Adapter.globalActionCalloutForAccountCreation(
      AccountId,
      billingAccountString
    );
    return accountRes;
  }
  public CreateOrderResponse createOrderGlobalAction(
    Map<String, String> orderInformation
  ) {
    CreateOrderResponse orderRes = new CreateOrderResponse();
    String emessage;
    Map<String, Object> orderParamsMap = new Map<String, Object>();
    RestAPI2Domain.GTVAPICreateSalesOrder createSalesOrder = new RestAPI2Domain.GTVAPICreateSalesOrder();
    RestAPI2Domain.GTVAPIOrder responseOrderMap;
    String orderNum;
    String orderEid;
    String accountNum;
    try {
      if (orderInformation.get('OrderStatus') == 'DRAFT')
        createSalesOrder = GTVRESTReverseMappingService.getDraftOrderRequest(
          orderInformation
        );
      else {
        createSalesOrder = GTVRESTReverseMappingService.getSalesOrderRequest(
          orderInformation
        );
      }
      orderParamsMap.put('id', orderInformation.get('BillingAccounteid'));
      orderParamsMap.put('order', createSalesOrder);
      GTVAPIRestClient.ResponseWrapper createOrder = GTVAPI2Adapter.createSalesOrder(
        orderParamsMap
      );
      responseOrderMap = (RestAPI2Domain.GTVAPIOrder) createOrder.returnObject;
    } catch (Exception e) {
      emessage = string.valueof(e.getmessage());
      if (emessage.contains('Web')) {
        emessage = emessage.substringBetween(
          'Web service callout failed: WebService returned a SOAP Fault:',
          ' faultcode=soap:Server faultactor='
        );
        orderRes.responsemessage = emessage;
        orderRes.responseSuccess = false;
      }

      return orderRes;
    }
    if (null != responseOrderMap) {
      orderNum = responseOrderMap.orderNum;
      orderEid = responseOrderMap.id;
      accountNum = responseOrderMap.billingAccount.accountNum;
      orderRes.gtvOrderId = orderEid;
      orderRes.responseSuccess = true;
      orderRes.gtvOrderNumber = orderNum;
    } else {
      orderRes.responsemessage = 'Unable to find Sales Order Information in Tract';
      orderRes.responseSuccess = false;
    }
    return orderRes;
  }

  public list<ProductUsesWrapper> getProductChargeRules(
    String prodEid,
    String recurringPriceId
  ) {
    Map<String, Object> chargeRulesrMap = new Map<String, Object>();
    list<ProductUsesWrapper> usgaeWrapList = new List<ProductUsesWrapper>();
    system.debug('prodEid:::' + prodEid);
    ChargeRulesrMap.put('productId', prodEid);
    ChargeRulesrMap.put('productPriceId', recurringPriceId);
    GTVAPIRestClient.ResponseWrapper chargeRulesResponse = GTVAPI2Adapter.queryProductChargeRules(
      chargeRulesrMap
    );
    List<RestAPI2Domain.GTVAPIProductUsageRule> valueResponseMap = (List<RestAPI2Domain.GTVAPIProductUsageRule>) chargeRulesResponse.returnObject;
    if (null != valueResponseMap && !valueResponseMap.isEmpty()) {
      usgaeWrapList = GTVRESTMappingService.parseProductUsageRule(
        valueResponseMap
      );
    }
    return usgaeWrapList;
  }

  public void createChargeRules(
    String productEid,
    String recurringPriceId,
    ProductChargeRuleWrapper ruleWrapper
  ) {
    Map<String, Object> activityChargeRuleParamsMap = new Map<String, Object>();
    activityChargeRuleParamsMap.put('productId', productEid);
    activityChargeRuleParamsMap.put('productPriceId', recurringPriceId);
    activityChargeRuleParamsMap.put(
      'usageRules',
      GTVRESTReverseMappingService.mapNewProductActivityChargeRule(ruleWrapper)
    );
    GTVAPIRestClient.ResponseWrapper relationResponse = GTVAPI2Adapter.createProductUsageRule(
      activityChargeRuleParamsMap
    );
  }

  public String getPaymentRefererToken() {
    Map<String, Object> paymentCreateParamsMap = new Map<String, Object>();
    paymentCreateParamsMap.put(
      'getRefererToken',
      GTVRESTReverseMappingService.mapReferTokenURL()
    );
    GTVAPIRestClient.ResponseWrapper valueResponseMap = GTVAPI2Adapter.getPaymentToken(
      paymentCreateParamsMap
    );
    RestAPI2Domain.GTVAPIGetPaymentRefererToken paymentTokenResponse = (RestAPI2Domain.GTVAPIGetPaymentRefererToken) valueResponseMap.returnObject;
    if (null != paymentTokenResponse) {
      return paymentTokenResponse.token;
    }
    return null;
  }

  public String generatePaymentToken(Map<String, Object> paymentDataMap) {
    Map<String, Object> paymentMethodCreateParamsMap = new Map<String, Object>();
    RestAPI2Domain.GTVAPICreatePaymentMethod mapCustomFieldRequest = GTVRESTReverseMappingService.mapNewPaymentMethodData(
      paymentDataMap
    );
    paymentMethodCreateParamsMap.put('getPaymentToken', mapCustomFieldRequest);
    GTVAPIRestClient.ResponseWrapper valueResponseMap = GTVAPI2Adapter.createPaymentMethod(
      paymentMethodCreateParamsMap
    );
    RestAPI2Domain.GTVAPIGetPaymentMethodResponse getPaymentTokenResponse = (RestAPI2Domain.GTVAPIGetPaymentMethodResponse) valueResponseMap.returnObject;
    if (null != getPaymentTokenResponse) {
      return getPaymentTokenResponse.reference;
    }
    return null;
  }

  public String createRecurringPayment(
    String token,
    String billingAccountEid,
    boolean isAutoPayment
  ) {
    Map<String, Object> recurringPaymentCreateParamsMap = new Map<String, Object>();
    recurringPaymentCreateParamsMap.put('id', billingAccountEid);
    recurringPaymentCreateParamsMap.put(
      'recurringPayment',
      GTVRESTReverseMappingService.mapPaymentMethodCreate(token, isAutoPayment)
    );
    GTVAPIRestClient.ResponseWrapper valueResponseMap = GTVAPI2Adapter.createRecurringPayment(
      recurringPaymentCreateParamsMap
    );
    RestAPI2Domain.GTVAPIRecurringPayment getPaymentMethodResponse = (RestAPI2Domain.GTVAPIRecurringPayment) valueResponseMap.returnObject;
    return getPaymentMethodResponse.id;
  }

  public String createBillingPayment(
    Map<String, Object> mapOfPaymentData,
    String billingAccountEid
  ) {
    Map<String, Object> billingPaymentCreateParamsMap = new Map<String, Object>();
    billingPaymentCreateParamsMap.put('id', billingAccountEid);
    billingPaymentCreateParamsMap.put(
      'payment',
      GTVRESTReverseMappingService.mapBillingPaymentCreate(mapOfPaymentData)
    );
    GTVAPIRestClient.ResponseWrapper valueResponseMap = GTVAPI2Adapter.createBillingAccountPayment(
      billingPaymentCreateParamsMap
    );
    return 'PaymentCreated';
  }

  /**
   * @description: Query Payment methods from GTV db and return UI wrapper after mapping the API response
   * @param sfdcAccountWrapper TRACTAccountWrapper Instance
   * @param pageNumber to be set while Querying Entity
   * @return TRACTPaymentMethodWrapper The billing account payment method wrapper to be used on UI
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public GTVPaymentWrapper getPaymentMethodAsSelectOption(
    String gtvBillingAccountNumber
  ) {
    GTVPaymentWrapper paymentMethodList = new GTVPaymentWrapper();
    Map<String, Object> paymentMethodQueryParamsMap = new Map<String, Object>();
    paymentMethodQueryParamsMap.put('accountNum', gtvBillingAccountNumber);
    GTVAPIRestClient.ResponseWrapper apiCallOutPaymentMethodResponse = GTVAPI2Adapter.queryPaymentMethods(
      paymentMethodQueryParamsMap
    );
    List<RestAPI2Domain.GTVAPIRecurringPayment> tractPaymentMethodList = (List<RestAPI2Domain.GTVAPIRecurringPayment>) apiCallOutPaymentMethodResponse.returnObject;
    if (null != tractPaymentMethodList && !tractPaymentMethodList.isEmpty()) {
      paymentMethodList = GTVRESTMappingService.parsePaymentMethods(
        tractPaymentMethodList
      );
    }
    return paymentMethodList;
  }

  public CreateChangeOrderWrapper getCreateChangeOrderWrapper(
    String currentServiceId,
    String currencyType
  ) {
    CreateChangeOrderWrapper changeOrderWrapper = new CreateChangeOrderWrapper();
    try {
      Map<String, Object> orderItemQueryParamsMap = new Map<String, Object>();
      orderItemQueryParamsMap.put('serviceId', currentServiceId);
      Map<String, Object> compatibleProductsParamsMap = new Map<String, Object>();
      String priceListEid;
      Boolean enablePreserveAgreement;
      String productId;
      String productName;
      List<String> srIdentifierList = new List<String>();
      GTVAPIRestClient.ResponseWrapper orderItemResponse = GTVAPI2Adapter.queryOrderItems(
        orderItemQueryParamsMap
      );
      List<RestAPI2Domain.GTVAPIOrderItem> responseOrderItemMap = (List<RestAPI2Domain.GTVAPIOrderItem>) orderItemResponse.returnObject;
      compatibleProductsParamsMap.put('id', currentServiceId);
      GTVAPIRestClient.ResponseWrapper compatibleProductResponse = GTVAPI2Adapter.getCompatibleProducts(
        compatibleProductsParamsMap
      );
      List<RestAPI2Domain.GTVAPIProduct> compatibleProductList = (List<RestAPI2Domain.GTVAPIProduct>) compatibleProductResponse.returnObject;
      if (Integer.valueOf(compatibleProductResponse.totalPages) > 1) {
        for (
          integer i = 2;
          i <= Integer.valueOf(compatibleProductResponse.totalPages);
          i++
        ) {
          Map<String, Object> compatibleProductsParamsLoopMap = new Map<String, Object>();
          compatibleProductsParamsLoopMap.put('id', currentServiceId);
          compatibleProductsParamsLoopMap.put('pageNumber', i);
          GTVAPIRestClient.ResponseWrapper compatibleproductsResponseInLoop = GTVAPI2Adapter.getCompatibleProducts(
            compatibleProductsParamsLoopMap
          );
          compatibleProductList.addall(
            (List<RestAPI2Domain.GTVAPIProduct>) compatibleproductsResponseInLoop.returnObject
          );
        }
      }
      changeOrderWrapper = GTVRESTMappingService.getCreateChangeOrderWrapper(
        compatibleProductList,
        responseOrderItemMap,
        currentServiceId,
        currencyType
      );
    } catch (exception ex) {
      //subscriptionWrapper.errorMessage = ex.getMessage();
    }
    return changeOrderWrapper;
  }

  public void createChangeOrderInGTV(
    CreateChangeOrderWrapper changeOrderWrapper
  ) {
    Map<String, Object> changeOrderRequestMap = new Map<string, object>();
    changeOrderRequestMap.put('id', changeOrderWrapper.currentServiceId);
    changeOrderRequestMap.put(
      'changeService',
      GTVRESTReverseMappingService.getChangeCreateOrderRequest(
        ChangeOrderWrapper
      )
    );
    System.debug('changeOrderRequestMap::::::::' + changeOrderRequestMap);
    GTVAPI2Adapter.createChangeOrders(changeOrderRequestMap);
  }

  public void createChangeOrderRequestInGTV(String opportunityId) {
    Map<String, Object> changeOrderRequestMap = new Map<string, object>();
    Opportunity opportunity = [
      SELECT id, Name, account.Tract_Billing_Account__c
      FROM opportunity
      WHERE id = :OpportunityId
      LIMIT 1
    ];
    OpportunityLineItem oli = [
      SELECT
        id,
        RecurringPrice__c,
        RecurringProductPriceEid__c,
        OneTimePrice__c,
        OneTimeProductPriceEid__c,
        overrideAgreementEndDate__c,
        Agreement_Name__c,
        Agreement_Period__c,
        agreementEndAction__c,
        Gotransverse_NextAgreementEndAction__c,
        Applied_Agreement_Eid__c,
        GTV_Renewal_Price__c,
        GTV_Next_Renewal_Price__c,
        ProductID__c,
        Quantity,
        ServiceName__c,
        Existing_Service_Eid__c,
        GTV_Recurring_Price_Range_Information__c,
        GTV_OneTime_Price_Range_Information__c,
        priceList_Eid__c,
        Email_Reciept__c,
        ServiceDate,
        Opportunity.account.Currency_Type__c
      FROM OpportunityLineItem
      WHERE OpportunityId = :OpportunityId
      LIMIT 1
    ];
    changeOrderRequestMap.put('id', oli.Existing_Service_Eid__c);
    changeOrderRequestMap.put(
      'changeService',
      GTVRESTReverseMappingService.getChangeCreateOrderRequest(oli)
    );
    GTVAPIRestClient.ResponseWrapper changeOrderResponse = GTVAPI2Adapter.createChangeOrders(
      changeOrderRequestMap
    );
    RestAPI2Domain.GTVAPIChangeOrder changeOrderResponseMap = (RestAPI2Domain.GTVAPIChangeOrder) changeOrderResponse.returnObject;
    if (changeOrderResponseMap != null) {
      TractSFDC_Util.updateOpportunity(
        OpportunityId,
        changeOrderResponseMap.orderNum,
        opportunity.account.Tract_Billing_Account__c
      );
    }
  }

  public List<SelectOption> getServiceResourceIdentifier(
    String serviceResourceCategoryId
  ) {
    system.debug('serviceResourceCategoryId:::::' + serviceResourceCategoryId);
    List<SelectOption> identifierList = new List<SelectOption>();
    Map<String, Object> identifierQueryParamsMap = new Map<String, Object>();
    identifierQueryParamsMap.put(
      'resourceCategoryId',
      serviceResourceCategoryId
    );
    identifierQueryParamsMap.put('status', 'AVAILABLE');
    GTVAPIRestClient.ResponseWrapper getServiceResource = GTVAPI2Adapter.queryServiceResource(
      identifierQueryParamsMap
    );
    List<RestAPI2Domain.GTVAPIServiceResource> responseServiceResourceMap = (List<RestAPI2Domain.GTVAPIServiceResource>) getServiceResource.returnObject;
    if (Integer.valueOf(getServiceResource.totalPages) > 1) {
      for (
        integer i = 2; i <= Integer.valueOf(getServiceResource.totalPages); i++
      ) {
        Map<String, Object> identifierQueryParamsLoopMap = new Map<String, Object>();
        identifierQueryParamsLoopMap.put(
          'resourceCategoryId',
          serviceResourceCategoryId
        );
        identifierQueryParamsLoopMap.put('status', 'AVAILABLE');
        identifierQueryParamsLoopMap.put('pageNumber', i);
        GTVAPIRestClient.ResponseWrapper getServiceResourceInLoop = GTVAPI2Adapter.queryServiceResource(
          identifierQueryParamsLoopMap
        );
        responseServiceResourceMap.addall(
          (List<RestAPI2Domain.GTVAPIServiceResource>) getServiceResourceInLoop.returnObject
        );
      }
    }
    if (responseServiceResourceMap != null) {
      identifierList = GTVRESTMappingService.parseServiceResource(
        responseServiceResourceMap
      );
    }
    return identifierList;
  }

  public void createServiceResourceInGTV(
    String identifier,
    String resourceCategoryId
  ) {
    Map<String, Object> createServiceResourceRequestMap = new Map<string, object>();
    createServiceResourceRequestMap.put(
      'createServiceResource',
      GTVRESTReverseMappingService.getCreateserviceResourceRequest(
        identifier,
        resourceCategoryId
      )
    );
    GTVAPI2Adapter.createServiceResources(createServiceResourceRequestMap);
  }

  public List<GTVServiceWrapper> queryAllActiveAccountServices(
    String accountNumber,
    String currencyType
  ) {
    List<GTVServiceWrapper> gtvServiceWrapList = new List<GTVServiceWrapper>();
    Map<String, Object> servicesQueryParamsMap = new Map<String, Object>();
    servicesQueryParamsMap.put('accountNum', accountNumber);
    servicesQueryParamsMap.put('pageNumber', 1);
    servicesQueryParamsMap.put('status', 'ACTIVE');
    GTVAPIRestClient.ResponseWrapper serviceResponseWrapper = GTVAPI2Adapter.queryServices(
      servicesQueryParamsMap
    );
    List<RestAPI2Domain.GTVAPISFService> gtvServices = (List<RestAPI2Domain.GTVAPISFService>) serviceResponseWrapper.returnObject;
    if (Integer.valueOf(serviceResponseWrapper.totalPages) > 1) {
      for (
        integer i = 2;
        i <= Integer.valueOf(serviceResponseWrapper.totalPages);
        i++
      ) {
        Map<String, Object> serviceResponseWrapperLoopMap = new Map<String, Object>();
        serviceResponseWrapperLoopMap.put('accountNum', accountNumber);
        serviceResponseWrapperLoopMap.put('pageNumber', i);
        serviceResponseWrapperLoopMap.put('status', 'ACTIVE');
        GTVAPIRestClient.ResponseWrapper ServiceResponseInLoop = GTVAPI2Adapter.queryServices(
          serviceResponseWrapperLoopMap
        );
        gtvServices.addall(
          (List<RestAPI2Domain.GTVAPISFService>) ServiceResponseInLoop.returnObject
        );
      }
    }
    if (GTVServices != null) {
      gtvServiceWrapList = GTVRESTMappingService.parseGTVServices(
        GTVServices,
        currencyType
      );
    }
    return gtvServiceWrapList;
  }

  public CreateAccountResponse createAccount(
    String salesforceAccountId,
    GTVAccount gtvAccount
  ) {
    CreateAccountResponse accountResponse = new CreateAccountResponse();
    Map<String, Object> accountCreationParamsMap = new Map<String, Object>();
    accountCreationParamsMap.put(
      'billingAccount',
      GTVRESTReverseMappingService.getBillingAccountCreationRequest(
        salesforceAccountId,
        gtvAccount
      )
    );
    GTVAPIRestClient.ResponseWrapper billingAccountResponseWrapper = GTVAPI2Adapter.createBillingAccount(
      accountCreationParamsMap
    );
    RestAPI2Domain.GTVAPIBillingAccount billingAccountCreationResponse = (RestAPI2Domain.GTVAPIBillingAccount) billingAccountResponseWrapper.returnObject;
    if (billingAccountCreationResponse != null) {
      accountResponse = GTVRESTMappingService.mapBillingAccountCreationResponse(
        salesforceAccountId,
        billingAccountCreationResponse,
        billingAccountResponseWrapper.responseCode,
        billingAccountResponseWrapper.responsemessage
      );
      Account salesforceAccount = new Account(
        Id = salesforceAccountId,
        Tract_Billing_Account__c = accountResponse.gtvAccountNumber
      );
      update salesforceAccount;
    }
    return accountResponse;
  }

  public CreateOrderResponse createOrder(
    String salesforceAccountId,
    GTVOrder gtvOrder
  ) {
    list<TRACT_Setup__c> tractList = [
      SELECT Id, Active__c
      FROM TRACT_Setup__c
      WHERE Active__c = TRUE
      LIMIT 1
    ];
    if (tractList.size() == 0) {
      throw new MyException(
        'Please ask your administrator to setup the TRACT Configuration.'
      );
    }
    List<Account> accountList = [
      SELECT Id, Name, Tract_Billing_Account__c
      FROM Account
      WHERE Id = :salesforceAccountId
    ];
    if (
      accountList.size() > 0 &&
      accountList[0].Tract_Billing_Account__c == null
    ) {
      throw new MyException('Please provide a correct billing account.');
    }
    TRACTAccountWrapper billingAccountWrapper = getBillingAccount(
      salesforceAccountId
    );
    CreateOrderResponse orderResponse = new CreateOrderResponse();
    Map<String, Object> orderCreationParamsMap = new Map<String, Object>();
    orderCreationParamsMap.put('id', billingAccountWrapper.eid);
    orderCreationParamsMap.put(
      'order',
      GTVRESTReverseMappingService.getSalesOrderCreationRequest(
        salesforceAccountId,
        gtvOrder
      )
    );
    GTVAPIRestClient.ResponseWrapper orderCreationResponseWrapper = GTVAPI2Adapter.createSalesOrder(
      orderCreationParamsMap
    );
    RestAPI2Domain.GTVAPIOrder orderCreationResponse = (RestAPI2Domain.GTVAPIOrder) orderCreationResponseWrapper.returnObject;
    if (orderCreationResponse != null) {
      orderResponse = GTVRESTMappingService.mapSalesOrderCreationResponse(
        salesforceAccountId,
        orderCreationResponse,
        orderCreationResponseWrapper.responseCode,
        orderCreationResponseWrapper.responsemessage,
        billingAccountWrapper.eid
      );
    }
    return orderResponse;
  }

  public QueryServiceResourceCategoryIdResponse getServiceResourceCategoryId(
    String serviceResourceCategoryName
  ) {
    QueryServiceResourceCategoryIdResponse categoryIdResponse = new QueryServiceResourceCategoryIdResponse();
    Map<String, Object> resourceCategoryQueryParamsMap = new Map<String, Object>();
    resourceCategoryQueryParamsMap.put(
      'resourceCategoryName',
      serviceResourceCategoryName
    );
    resourceCategoryQueryParamsMap.put('resourceType', 'service');
    GTVAPIRestClient.ResponseWrapper resourceCategoryResponseWrapper = GTVAPI2Adapter.queryResourceCategory(
      resourceCategoryQueryParamsMap
    );
    List<RestAPI2Domain.GTVAPIResourceCategory> resourceCategories = (List<RestAPI2Domain.GTVAPIResourceCategory>) resourceCategoryResponseWrapper.returnObject;
    categoryIdResponse = GTVRESTMappingService.mapServiceCategoryResponse(
      resourceCategories,
      resourceCategoryResponseWrapper.responseCode,
      resourceCategoryResponseWrapper.responsemessage
    );
    return categoryIdResponse;
  }

  public queryServiceResourceResponse queryServiceResources(
    String serviceResourceCategoryId
  ) {
    QueryServiceResourceResponse serviceResourceResponse = new QueryServiceResourceResponse();
    Map<String, Object> resourceQueryParamsMap = new Map<String, Object>();
    resourceQueryParamsMap.put('resourceCategoryId', serviceResourceCategoryId);
    resourceQueryParamsMap.put('status', 'AVAILABLE');
    GTVAPIRestClient.ResponseWrapper serviceResourceResponseWrapper = GTVAPI2Adapter.queryServiceResource(
      resourceQueryParamsMap
    );
    List<RestAPI2Domain.GTVAPIServiceResource> resourceResponse = (List<RestAPI2Domain.GTVAPIServiceResource>) serviceResourceResponseWrapper.returnObject;
    serviceResourceResponse = GTVRESTMappingService.mapExistingServiceResourceResponse(
      resourceResponse,
      serviceResourceResponseWrapper.responseCode,
      serviceResourceResponseWrapper.responsemessage
    );
    return serviceResourceResponse;
  }

  public QueryDiscountIdentifierResponse querydiscountIdentifier(
    String gtvProductId
  ) {
    QueryDiscountIdentifierResponse discountIdentifierResponse = new QueryDiscountIdentifierResponse();
    Map<String, Object> discountIdentifierQueryParamsMap = new Map<String, Object>();
    discountIdentifierQueryParamsMap.put('productId', gtvProductId);
    discountIdentifierQueryParamsMap.put('status', 'ACTIVE');
    GTVAPIRestClient.ResponseWrapper discountCodesResponseWrapper = GTVAPI2Adapter.getDiscountCodesByProduct(
      discountIdentifierQueryParamsMap
    );
    List<RestAPI2Domain.GTVAPIDiscountCode> discountCodes = (List<RestAPI2Domain.GTVAPIDiscountCode>) discountCodesResponseWrapper.returnObject;
    discountIdentifierResponse = GTVRESTMappingService.mapdiscountIdentifierResponse(
      discountCodes,
      discountCodesResponseWrapper.responseCode,
      discountCodesResponseWrapper.responsemessage
    );
    return discountIdentifierResponse;
  }

  public QueryDiscountResourceIdResponse querydiscountResourceId(
    String discountIdentifier
  ) {
    QueryDiscountResourceIdResponse discountResourceIdResponse = new QueryDiscountResourceIdResponse();
    Map<String, Object> discountResourceIdQueryParamsMap = new Map<String, Object>();
    discountResourceIdQueryParamsMap.put('identifier', discountIdentifier);
    GTVAPIRestClient.ResponseWrapper discountResourcesResponseWrapper = GTVAPI2Adapter.getProductDiscountResourceList(
      discountResourceIdQueryParamsMap
    );
    List<RestAPI2Domain.GTVAPIDiscountResource> discountResources = (List<RestAPI2Domain.GTVAPIDiscountResource>) discountResourcesResponseWrapper.returnObject;
    discountResourceIdResponse = GTVRESTMappingService.mapdiscountResourceIdResponse(
      discountResources,
      discountResourcesResponseWrapper.responseCode,
      discountResourcesResponseWrapper.responsemessage
    );
    return discountResourceIdResponse;
  }

  public QueryUsageChargeCategoriesResposne queryUsageChargeCategory() {
    QueryUsageChargeCategoriesResposne usageChargeCategoriesResponse = new QueryUsageChargeCategoriesResposne();
    Map<String, Object> usageChargeCategoryQueryParamsMap = new Map<String, Object>();
    usageChargeCategoryQueryParamsMap.put('status', 'ACTIVE');
    usageChargeCategoryQueryParamsMap.put('r_type', 'usage-charge');
    GTVAPIRestClient.ResponseWrapper usageChargeCategoryResponseWrapper = GTVAPI2Adapter.queryChargeCatogory(
      usageChargeCategoryQueryParamsMap
    );
    List<RestAPI2Domain.GTVAPIChargeCategory> usageChargeCategories = (List<RestAPI2Domain.GTVAPIChargeCategory>) usageChargeCategoryResponseWrapper.returnObject;
    usageChargeCategoriesResponse = GTVRESTMappingService.mapUsageChargeCategoryResponse(
      usageChargeCategories,
      usageChargeCategoryResponseWrapper.responseCode,
      usageChargeCategoryResponseWrapper.responsemessage
    );
    return usageChargeCategoriesResponse;
  }

  public QueryServiceCustomFieldResponse queryServiceCustomFields(
    String gtvProductId
  ) {
    QueryServiceCustomFieldResponse serviceCustomFieldResponse = new QueryServiceCustomFieldResponse();
    Map<String, Object> serviceCustomFieldsQueryParamsMap = new Map<String, Object>();
    serviceCustomFieldsQueryParamsMap.put('enabled', true);
    serviceCustomFieldsQueryParamsMap.put('searchable', true);
    serviceCustomFieldsQueryParamsMap.put('productId', gtvProductId);
    GTVAPIRestClient.ResponseWrapper serviceCustomFieldResponseWrapper = GTVAPI2Adapter.queryServiceCustomFields(
      serviceCustomFieldsQueryParamsMap
    );
    List<RestAPI2Domain.GTVAPIServiceCustomField> serviceCustomFields = (List<RestAPI2Domain.GTVAPIServiceCustomField>) serviceCustomFieldResponseWrapper.returnObject;
    serviceCustomFieldResponse = GTVRESTMappingService.mapServiceCustomFieldsResponse(
      serviceCustomFields,
      serviceCustomFieldResponseWrapper.responseCode,
      serviceCustomFieldResponseWrapper.responsemessage
    );
    return serviceCustomFieldResponse;
  }

  public QueryOrderCustomFieldResponse queryOrderCustomFields() {
    QueryOrderCustomFieldResponse orderCustomFieldResponse = new QueryOrderCustomFieldResponse();
    Map<String, Object> orderCustomFieldsQueryParamsMap = new Map<String, Object>();
    orderCustomFieldsQueryParamsMap.put('enabled', true);
    orderCustomFieldsQueryParamsMap.put('searchable', true);
    GTVAPIRestClient.ResponseWrapper orderCustomFieldResponseWrapper = GTVAPI2Adapter.queryOrderCustomFields(
      orderCustomFieldsQueryParamsMap
    );
    List<RestAPI2Domain.GTVAPIOrderCustomField> orderCustomFields = (List<RestAPI2Domain.GTVAPIOrderCustomField>) orderCustomFieldResponseWrapper.returnObject;
    orderCustomFieldResponse = GTVRESTMappingService.mapOrderCustomFieldsResponse(
      orderCustomFields,
      orderCustomFieldResponseWrapper.responseCode,
      orderCustomFieldResponseWrapper.responsemessage
    );
    return orderCustomFieldResponse;
  }

  public QueryRateTableResponse queryRateTables() {
    QueryRateTableResponse rateTableResponse = new QueryRateTableResponse();
    Map<String, Object> rateTableQueryParamsMap = new Map<String, Object>();
    rateTableQueryParamsMap.put('status', 'ACTIVE');
    GTVAPIRestClient.ResponseWrapper rateTableResponseWrapper = GTVAPI2Adapter.queryRateTables(
      rateTableQueryParamsMap
    );
    List<RestAPI2Domain.GTVAPIRateTable> rateTables = (List<RestAPI2Domain.GTVAPIRateTable>) rateTableResponseWrapper.returnObject;
    rateTableResponse = GTVRESTMappingService.mapRateTableResponse(
      rateTables,
      rateTableResponseWrapper.responseCode,
      rateTableResponseWrapper.responsemessage
    );
    return rateTableResponse;
  }

  public QueryParentServiceResponse queryParentServices(
    String salesforceAccountId,
    String gtvProductId
  ) {
    QueryParentServiceResponse parentServiceResponse = new QueryParentServiceResponse();
    List<Account> accountList = [
      SELECT Id, Name, Tract_Billing_Account__c
      FROM Account
      WHERE Id = :salesforceAccountId
    ];
    if (
      accountList.size() > 0 &&
      accountList[0].Tract_Billing_Account__c == null
    ) {
      throw new MyException('Please provide a correct billing account.');
    }
    Set<String> parentProductIdSet = getRelatedProductIdSet(gtvProductId);
    System.debug('parentProductIdSet::::::' + parentProductIdSet);
    Map<String, Object> parentServiceQueryParamsMap = new Map<String, Object>();
    parentServiceQueryParamsMap.put('status', 'ACTIVE');
    parentServiceQueryParamsMap.put(
      'accountNum',
      accountList[0].Tract_Billing_Account__c
    );
    GTVAPIRestClient.ResponseWrapper serviceResponseWrapper = GTVAPI2Adapter.queryServices(
      parentServiceQueryParamsMap
    );
    List<RestAPI2Domain.GTVAPISFService> services = (List<RestAPI2Domain.GTVAPISFService>) serviceResponseWrapper.returnObject;
    if (Integer.valueOf(serviceResponseWrapper.totalPages) > 1) {
      for (
        integer i = 2;
        i <= Integer.valueOf(serviceResponseWrapper.totalPages);
        i++
      ) {
        Map<String, Object> parentServiceQueryParamsInLoop = new Map<String, Object>();
        parentServiceQueryParamsInLoop.put(
          'accountNum',
          accountList[0].Tract_Billing_Account__c
        );
        parentServiceQueryParamsInLoop.put('pageNumber', i);
        parentServiceQueryParamsInLoop.put('status', 'ACTIVE');
        GTVAPIRestClient.ResponseWrapper serviceResponseInLoop = GTVAPI2Adapter.queryServices(
          parentServiceQueryParamsInLoop
        );
        services.addall(
          (List<RestAPI2Domain.GTVAPISFService>) serviceResponseInLoop.returnObject
        );
      }
    }
    parentServiceResponse = GTVRESTMappingService.mapParentServiceResponse(
      services,
      parentProductIdSet,
      serviceResponseWrapper.responseCode,
      serviceResponseWrapper.responsemessage
    );
    return parentServiceResponse;
  }
}