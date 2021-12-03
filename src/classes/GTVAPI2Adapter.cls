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
 * This class is use to make the REST API's callouts.
 * @author AMAN JAIN
 */

public with sharing class GTVAPI2Adapter {
  public static GTVAPIClient api2ClientObj;
  /**
   * Query GTV API setup object from Salesforce
   * @return TRACT_Setup__c The GTV API setup object
   */
  private static TRACT_Setup__c getTractSetup() {
    TRACT_Setup__c tractConfigObj = [
      SELECT
        id,
        Api_Version__c,
        TRACT_URL__c,
        Tract_User_Name__c,
        TPassword__c,
        X_API_Key__c,
        Active__c,
        TRACT_URL2_0__c,
        OrderStatus__c,
        Gotransverse_Hosted_Payment_URL__c
      FROM TRACT_Setup__c
      WHERE Active__c = TRUE
      LIMIT 1
    ];
    return tractConfigObj;
  }

  /**
   * Provides the GTVAPIClient to authorize API2 callouts
   * @return GTVAPIClient the GTVAPIClient object to authorize API2 callouts
   */
  public static GTVAPIClient getGTVAPICredentials() {
    if (api2ClientObj == null) {
      TRACT_Setup__c tractSetupObj = getTractSetup();
      api2ClientObj = new GTVAPIClient(tractSetupObj);
      if (null != tractSetupObj) {
        api2ClientObj.setApiKey(tractSetupObj.X_API_Key__c, 'x-api-key');
      }
    }
    return api2ClientObj;
  }

  /**
   * Query a BillingAccount from TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static GTVAPIRestClient.ResponseWrapper querybillingAccount(
    Map<String, Object> paramsMap
  ) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVAPIBillingAccountService req = new RestAPI2Service.GTVAPIBillingAccountService(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    GTVAPIRestClient.ResponseWrapper reswrap;
    if (!Test.isRunningTest()) {
      reswrap = req.queryBillingAccounts(paramsMap);
    } else {
      reswrap = RestApiTestUtil.querybillingAccount();
    }
    return reswrap;
  }

  /**
   * Query payments from TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static GTVAPIRestClient.ResponseWrapper queryPayments(
    Map<String, Object> paramsMap
  ) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVAPIPaymentService req = new RestAPI2Service.GTVAPIPaymentService(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    GTVAPIRestClient.ResponseWrapper reswrap;
    if (!Test.isRunningTest()) {
      reswrap = req.queryPaymentsByBillingAccount(paramsMap);
    } else {
      reswrap = RestApiTestUtil.queryPayments();
    }
    return reswrap;
  }

  /**
   * Query payment applications from TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static GTVAPIRestClient.ResponseWrapper queryPaymentApplications(
    Map<String, Object> paramsMap
  ) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVAPIPaymentApplicationService req = new RestAPI2Service.GTVAPIPaymentApplicationService(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    GTVAPIRestClient.ResponseWrapper reswrap;
    if (!Test.isRunningTest()) {
      reswrap = req.queryPaymentApplications(paramsMap);
    } else {
      reswrap = RestApiTestUtil.queryPaymentApplications();
    }
    return reswrap;
  }
  /**
   * download Pdf from TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static GTVAPIRestClient.ResponseWrapper downloadInvoices(
    Map<String, Object> paramsMap
  ) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVAPIInvoiceService req = new RestAPI2Service.GTVAPIInvoiceService(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    GTVAPIRestClient.ResponseWrapper reswrap;
    if (!Test.isRunningTest()) {
      reswrap = req.getRenderedInvoice(paramsMap);
    } else {
      reswrap = new GTVAPIRestClient.ResponseWrapper();
      reswrap.returnObject = Blob.valueof('abccccc');
    }
    return reswrap;
  }

  /**
   * Query Invoices from TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static GTVAPIRestClient.ResponseWrapper queryInvoices(
    Map<String, Object> paramsMap
  ) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVAPIInvoiceService req = new RestAPI2Service.GTVAPIInvoiceService(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    GTVAPIRestClient.ResponseWrapper reswrap;
    if (!Test.isRunningTest()) {
      reswrap = req.queryInvoices(paramsMap);
    } else {
      reswrap = RestApiTestUtil.queryInvoices();
    }
    return reswrap;
  }

  /**
   * Query Debit Adjustments from TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static GTVAPIRestClient.ResponseWrapper queryDebitAdjustments(
    Map<String, Object> paramsMap
  ) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVAPIAdjustmentService req = new RestAPI2Service.GTVAPIAdjustmentService(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    GTVAPIRestClient.ResponseWrapper reswrap;
    if (!Test.isRunningTest()) {
      reswrap = req.queryDebitAdjustments(paramsMap);
    } else {
      reswrap = RestApiTestUtil.queryDebitAdjustments();
    }
    return reswrap;
  }

  /**
   * Query Credit Adjustments from TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static GTVAPIRestClient.ResponseWrapper queryCreditAdjustments(
    Map<String, Object> paramsMap
  ) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVAPIAdjustmentService req = new RestAPI2Service.GTVAPIAdjustmentService(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    GTVAPIRestClient.ResponseWrapper reswrap;
    if (!Test.isRunningTest()) {
      reswrap = req.queryCreditAdjustments(paramsMap);
    } else {
      reswrap = RestApiTestUtil.queryCreditAdjustments();
    }
    return reswrap;
  }

  /**
   * Query Persons from TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static GTVAPIRestClient.ResponseWrapper queryPersons(
    Map<String, Object> paramsMap
  ) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVAPIPersonService req = new RestAPI2Service.GTVAPIPersonService(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    GTVAPIRestClient.ResponseWrapper reswrap;
    if (!Test.isRunningTest()) {
      reswrap = req.queryPeople(paramsMap);
    } else {
      reswrap = RestApiTestUtil.queryPersons();
    }
    return reswrap;
  }

  /**
   * Query Payment Methods from TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static GTVAPIRestClient.ResponseWrapper queryPaymentMethods(
    Map<String, Object> paramsMap
  ) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVAPIRecurringPaymentService req = new RestAPI2Service.GTVAPIRecurringPaymentService(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    GTVAPIRestClient.ResponseWrapper reswrap;
    if (!Test.isRunningTest()) {
      reswrap = req.queryRecurringPayments(paramsMap);
    } else {
      reswrap = RestApiTestUtil.queryPaymentMethods();
    }
    return reswrap;
  }

  /**
   * Query Sales Order from TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static GTVAPIRestClient.ResponseWrapper querySalesOrders(
    Map<String, Object> paramsMap
  ) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVAPIOrderService req = new RestAPI2Service.GTVAPIOrderService(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    GTVAPIRestClient.ResponseWrapper reswrap;
    if (!Test.isRunningTest()) {
      reswrap = req.queryOrders(paramsMap);
    } else {
      reswrap = RestApiTestUtil.querySalesOrder();
    }
    return reswrap;
  }

  /**
   * Query Products from TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static GTVAPIRestClient.ResponseWrapper queryProducts(
    Map<String, Object> paramsMap
  ) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVAPIProductService req = new RestAPI2Service.GTVAPIProductService(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    GTVAPIRestClient.ResponseWrapper reswrap;
    if (!Test.isRunningTest()) {
      reswrap = req.queryProducts(paramsMap);
    } else {
      reswrap = RestApiTestUtil.queryProducts();
    }
    return reswrap;
  }

  /**
   * Query usage Events from TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static GTVAPIRestClient.ResponseWrapper queryUsageEvents(
    Map<String, Object> paramsMap
  ) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVAPIUsageEventService req = new RestAPI2Service.GTVAPIUsageEventService(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    GTVAPIRestClient.ResponseWrapper reswrap;
    if (!Test.isRunningTest()) {
      reswrap = req.queryUsageEvents(paramsMap);
    } else {
      reswrap = RestApiTestUtil.queryUsageEvents();
    }
    return reswrap;
  }
  /**
   * Query usage Events from TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static GTVAPIRestClient.ResponseWrapper getAgreementRelation(
    Map<String, Object> paramsMap
  ) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVAPIProductService req = new RestAPI2Service.GTVAPIProductService(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    GTVAPIRestClient.ResponseWrapper reswrap;
    if (!Test.isRunningTest()) {
      reswrap = req.queryProductAgreementRelations(paramsMap);
    } else {
      reswrap = RestApiTestUtil.queryProductAgreementRelations();
    }
    return reswrap;
  }
  /**
   * Query Service Resource from TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static GTVAPIRestClient.ResponseWrapper queryServiceResource(
    Map<String, Object> paramsMap
  ) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVAPIServiceResourceService req = new RestAPI2Service.GTVAPIServiceResourceService(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    GTVAPIRestClient.ResponseWrapper reswrap;
    if (!Test.isRunningTest()) {
      reswrap = req.queryServiceResources(paramsMap);
    } else {
      reswrap = RestApiTestUtil.queryServiceResource();
    }
    return reswrap;
  }
  /**
   * Query Bill Cycles from TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static GTVAPIRestClient.ResponseWrapper queryBillCycles(
    Map<String, Object> paramsMap
  ) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVAPIBillCycleService req = new RestAPI2Service.GTVAPIBillCycleService(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    GTVAPIRestClient.ResponseWrapper reswrap;
    if (!Test.isRunningTest()) {
      reswrap = req.queryBillCycles(paramsMap);
    } else {
      reswrap = RestApiTestUtil.queryBillCycles();
    }
    return reswrap;
  }

  /**
   * Query Discount Code from TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static GTVAPIRestClient.ResponseWrapper getProductDiscountCodeList(
    Map<String, Object> paramsMap
  ) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVAPIDiscountCodeService req = new RestAPI2Service.GTVAPIDiscountCodeService(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    GTVAPIRestClient.ResponseWrapper reswrap;
    if (!Test.isRunningTest()) {
      reswrap = req.queryDiscountCodes(paramsMap);
    } else {
      reswrap = RestApiTestUtil.getProductDiscountCodeList();
    }
    return reswrap;
  }
  /**
   * Query Charge category from TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static GTVAPIRestClient.ResponseWrapper queryChargeCatogory(
    Map<String, Object> paramsMap
  ) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVAPIChargeCategoryService req = new RestAPI2Service.GTVAPIChargeCategoryService(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    GTVAPIRestClient.ResponseWrapper reswrap;
    if (!Test.isRunningTest()) {
      reswrap = req.queryChargeCategories(paramsMap);
    } else {
      reswrap = RestApiTestUtil.queryChargeCatogory();
    }
    return reswrap;
  }
  /*
   * Query Rate Tables from TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static GTVAPIRestClient.ResponseWrapper queryRateTables(
    Map<String, Object> paramsMap
  ) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVAPIRateTableService req = new RestAPI2Service.GTVAPIRateTableService(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    GTVAPIRestClient.ResponseWrapper reswrap;
    if (!Test.isRunningTest()) {
      reswrap = req.queryRateTables(paramsMap);
    } else {
      reswrap = RestApiTestUtil.queryRateTables();
    }
    return reswrap;
  }
  /**
   * Create Usage Rule from TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static GTVAPIRestClient.ResponseWrapper createUsageRule(
    Map<String, Object> paramsMap
  ) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVServiceApi req = new RestAPI2Service.GTVServiceApi(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    GTVAPIRestClient.ResponseWrapper reswrap;
    if (!Test.isRunningTest()) {
      reswrap = req.createServiceUsageRules(paramsMap);
    }
    return reswrap;
  }

  /**
   * Query Usage Rule from TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static GTVAPIRestClient.ResponseWrapper queryUsageRule(
    Map<String, Object> paramsMap
  ) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVAPIServiceUsageRule req = new RestAPI2Service.GTVAPIServiceUsageRule(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    GTVAPIRestClient.ResponseWrapper reswrap;
    if (!Test.isRunningTest()) {
      reswrap = req.queryServiceUsageRules(paramsMap);
    } else {
      reswrap = RestApiTestUtil.queryUsageRule();
    }
    return reswrap;
  }
  /**
   * delete Usage Rule from TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static void deleteUsageRule(Map<String, Object> paramsMap) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVServiceApi req = new RestAPI2Service.GTVServiceApi(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    if (!Test.isRunningTest()) {
      req.removeServiceUsageRule(paramsMap);
    }
  }
  /**
   * Query BillingAccountCategory from TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static GTVAPIRestClient.ResponseWrapper queryBillingAccountCategory(
    Map<String, Object> paramsMap
  ) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVAPIBillingAccountCategoryService req = new RestAPI2Service.GTVAPIBillingAccountCategoryService(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    GTVAPIRestClient.ResponseWrapper reswrap;
    if (!Test.isRunningTest()) {
      reswrap = req.queryBillingAccountCategories(paramsMap);
    } else {
      reswrap = RestApiTestUtil.queryBillingAccountCategory();
    }
    return reswrap;
  }
  /**
   * Query OrderCustomFields from TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static GTVAPIRestClient.ResponseWrapper queryOrderCustomFields(
    Map<String, Object> paramsMap
  ) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVAPIOrderCustomFieldService req = new RestAPI2Service.GTVAPIOrderCustomFieldService(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    GTVAPIRestClient.ResponseWrapper reswrap;
    if (!Test.isRunningTest()) {
      reswrap = req.queryOrderCustomFields(paramsMap);
    } else {
      reswrap = RestApiTestUtil.queryOrderCustomFields();
    }
    return reswrap;
  }
  /**
   * Query OrderCustomFields from TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static GTVAPIRestClient.ResponseWrapper queryAccountCustomFields(
    Map<String, Object> paramsMap
  ) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVAPIBillingAccountCustomFieldService req = new RestAPI2Service.GTVAPIBillingAccountCustomFieldService(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    GTVAPIRestClient.ResponseWrapper reswrap;
    if (!Test.isRunningTest()) {
      reswrap = req.queryBillingAccountCustomFields(paramsMap);
    } else {
      reswrap = RestApiTestUtil.queryAccountCustomFields();
    }
    return reswrap;
  }
  /**
   * Query AccountCustomFieldValue from TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static GTVAPIRestClient.ResponseWrapper queryAccountCustomFieldValues(
    Map<String, Object> paramsMap
  ) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVAPIBillingAccountService req = new RestAPI2Service.GTVAPIBillingAccountService(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    GTVAPIRestClient.ResponseWrapper reswrap;
    if (!Test.isRunningTest()) {
      reswrap = req.queryBillingAccountCustomFieldValues(paramsMap);
    } else {
      reswrap = RestApiTestUtil.queryAccountCustomFieldValues();
    }
    return reswrap;
  }
  /**
   * Query PriceLists from TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static GTVAPIRestClient.ResponseWrapper queryPriceLists(
    Map<String, Object> paramsMap
  ) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVAPIPriceListService req = new RestAPI2Service.GTVAPIPriceListService(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    GTVAPIRestClient.ResponseWrapper reswrap;
    if (!Test.isRunningTest()) {
      reswrap = req.queryPriceLists(paramsMap);
    } else {
      reswrap = RestApiTestUtil.queryPriceLists();
    }
    return reswrap;
  }
  /**
   * Query PaymentTerms from TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static GTVAPIRestClient.ResponseWrapper queryPaymentTerms(
    Map<String, Object> paramsMap
  ) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVAPIPaymentTermService req = new RestAPI2Service.GTVAPIPaymentTermService(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    GTVAPIRestClient.ResponseWrapper reswrap;
    if (!Test.isRunningTest()) {
      reswrap = req.queryPaymentTerms(paramsMap);
    } else {
      reswrap = RestApiTestUtil.queryPaymentTerms();
    }
    return reswrap;
  }
  /**
   * Query Agreements from TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static GTVAPIRestClient.ResponseWrapper queryAgreements(
    Map<String, Object> paramsMap
  ) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVAPIAgreementService req = new RestAPI2Service.GTVAPIAgreementService(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    GTVAPIRestClient.ResponseWrapper reswrap;
    if (!Test.isRunningTest()) {
      reswrap = req.queryAgreements(paramsMap);
    } else {
      reswrap = RestApiTestUtil.queryAgreements();
    }
    return reswrap;
  }

  /**
   * Make a query to fetch pricelist from TRACT db to check TRACT configuration
   * @param tractConfigObj The TRACT_Setup__c object instance (required)
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static void queryPriceListsForTestingConnection(
    TRACT_Setup__c tractConfigObj
  ) {
    GTVAPIClient client = api2ClientObj = new GTVAPIClient(tractConfigObj);
    client.setApiKey(tractConfigObj.X_API_Key__c, 'x-api-key');
    RestAPI2Service.GTVAPIPriceListService req = new RestAPI2Service.GTVAPIPriceListService(
      client
    );
    Map<String, Object> paramsMap = new Map<String, Object>();
    paramsMap.put('prefer', 'x-api-key');
    if (!Test.isRunningTest()) {
      GTVAPIRestClient.ResponseWrapper reswrap = req.queryPriceLists(paramsMap);
    }
  }
  /**
   * DeactivateService from TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static void deactivateService(Map<String, Object> paramsMap) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVServiceApi req = new RestAPI2Service.GTVServiceApi(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    req.deactivateService(paramsMap);
  }
  /**
   * query OrderItems from TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static GTVAPIRestClient.ResponseWrapper queryOrderItems(
    Map<String, Object> paramsMap
  ) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVAPIOrderItemService req = new RestAPI2Service.GTVAPIOrderItemService(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    GTVAPIRestClient.ResponseWrapper reswrap;
    if (!Test.isRunningTest()) {
      reswrap = req.queryOrderItems(paramsMap);
    } else {
      reswrap = RestApiTestUtil.queryOrderItems();
    }
    //GTVAPIRestClient.ResponseWrapper reswrap = req.queryOrderItems(paramsMap);
    return reswrap;
  }

  /**
   * query DiscountCOdeService from TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static GTVAPIRestClient.ResponseWrapper queryDiscountCodeService(
    Map<String, Object> paramsMap
  ) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVServiceApi req = new RestAPI2Service.GTVServiceApi(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    GTVAPIRestClient.ResponseWrapper reswrap;
    if (!Test.isRunningTest()) {
      reswrap = req.queryDiscountCodeServices(paramsMap);
    } else {
      reswrap = RestApiTestUtil.queryDiscountCodeServices();
    }
    return reswrap;
  }

  /**
   * query Discount from TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static GTVAPIRestClient.ResponseWrapper queryDiscountsByIdentifier(
    Map<String, Object> paramsMap
  ) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVAPIDiscountService req = new RestAPI2Service.GTVAPIDiscountService(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    GTVAPIRestClient.ResponseWrapper reswrap;
    if (!Test.isRunningTest()) {
      reswrap = req.queryDiscounts(paramsMap);
    } else {
      reswrap = RestApiTestUtil.queryDiscounts();
    }
    return reswrap;
  }
  /**
   * Change Service from TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static GTVAPIRestClient.ResponseWrapper changeService(
    Map<String, Object> paramsMap
  ) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVServiceApi req = new RestAPI2Service.GTVServiceApi(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    GTVAPIRestClient.ResponseWrapper reswrap = req.changeService(paramsMap);
    return reswrap;
  }
  /**
   * SuspendService from TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static void suspendService(Map<String, Object> paramsMap) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVServiceApi req = new RestAPI2Service.GTVServiceApi(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    req.suspendService(paramsMap);
  }
  /**
   * Get Product Relation from TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static GTVAPIRestClient.ResponseWrapper queryProductRelation(
    Map<String, Object> paramsMap
  ) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVAPIProductRelationService req = new RestAPI2Service.GTVAPIProductRelationService(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    GTVAPIRestClient.ResponseWrapper reswrap;
    if (!Test.isRunningTest()) {
      reswrap = req.queryProductRelations(paramsMap);
    } else {
      reswrap = RestApiTestUtil.queryProductRelation();
    }
    return reswrap;
  }

  /**
   * Query Service from TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static GTVAPIRestClient.ResponseWrapper queryServices(
    Map<String, Object> paramsMap
  ) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVServiceApi req = new RestAPI2Service.GTVServiceApi(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    GTVAPIRestClient.ResponseWrapper reswrap;
    if (!Test.isRunningTest()) {
      reswrap = req.queryServices(paramsMap);
    } else {
      reswrap = RestApiTestUtil.queryServices();
    }
    return reswrap;
  }

  /**
   * Query Service Resources from TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static GTVAPIRestClient.ResponseWrapper queryServiceResourcesByService(
    Map<String, Object> paramsMap
  ) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVServiceApi req = new RestAPI2Service.GTVServiceApi(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    GTVAPIRestClient.ResponseWrapper reswrap = req.queryServiceResourcesByService(
      paramsMap
    );
    return reswrap;
  }

  /**
   * Add service address to the specified service
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static GTVAPIRestClient.ResponseWrapper saveAddress(
    Map<String, Object> paramsMap
  ) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVServiceApi req = new RestAPI2Service.GTVServiceApi(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    GTVAPIRestClient.ResponseWrapper reswrap = req.addServiceAddress(paramsMap);
    return reswrap;
  }

  /**
   * Add service Serource to the specified service
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static GTVAPIRestClient.ResponseWrapper saveServiceResource(
    Map<String, Object> paramsMap
  ) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVServiceApi req = new RestAPI2Service.GTVServiceApi(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    GTVAPIRestClient.ResponseWrapper reswrap = req.addServiceResource(
      paramsMap
    );
    return reswrap;
  }
  /**
   * Get service By ID to the specified service
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static GTVAPIRestClient.ResponseWrapper queryResourceCategory(
    Map<String, Object> paramsMap
  ) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVAPIResourceCategoryService req = new RestAPI2Service.GTVAPIResourceCategoryService(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    GTVAPIRestClient.ResponseWrapper reswrap;
    if (!Test.isRunningTest()) {
      reswrap = req.queryResourceCategories(paramsMap);
    } else {
      reswrap = RestApiTestUtil.queryResourceCategory();
    }
    return reswrap;
  }

  public static GTVAPIRestClient.ResponseWrapper queryCreditAdjustmentReason(
    Map<String, Object> paramsMap
  ) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVAPIReasonService req = new RestAPI2Service.GTVAPIReasonService(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    GTVAPIRestClient.ResponseWrapper reswrap;
    if (!Test.isRunningTest()) {
      reswrap = req.queryCreditAdjustmentReasons(paramsMap);
    } else {
      reswrap = RestApiTestUtil.queryCreditAdjustmentReason();
    }
    return reswrap;
  }

  /**
   * Query Reasons from TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static GTVAPIRestClient.ResponseWrapper queryServiceDeactivationReasons(
    Map<String, Object> paramsMap
  ) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVAPIReasonService req = new RestAPI2Service.GTVAPIReasonService(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    GTVAPIRestClient.ResponseWrapper reswrap;
    if (!Test.isRunningTest()) {
      reswrap = req.queryServiceDeactivationReasons(paramsMap);
    } else {
      reswrap = RestApiTestUtil.queryServiceDeactivationReasons();
    }
    return reswrap;
  }
  /**
   * Query Reasons from TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static GTVAPIRestClient.ResponseWrapper queryServiceSuspensionReasons(
    Map<String, Object> paramsMap
  ) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVAPIReasonService req = new RestAPI2Service.GTVAPIReasonService(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    GTVAPIRestClient.ResponseWrapper reswrap;
    if (!Test.isRunningTest()) {
      reswrap = req.queryServiceSuspensionReasons(paramsMap);
    } else {
      reswrap = RestApiTestUtil.queryServiceSuspensionReasons();
    }
    return reswrap;
  }

  /**
   * create credit Adjustment to the TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static GTVAPIRestClient.ResponseWrapper createCreditAdjustment(
    Map<String, Object> paramsMap
  ) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVAPIAdjustmentService req = new RestAPI2Service.GTVAPIAdjustmentService(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    paramsMap.put('prefer', 'x-api-key');
    GTVAPIRestClient.ResponseWrapper reswrap;
    if (!Test.isRunningTest()) {
      reswrap = req.createCreditAdjustment(paramsMap);
    } else {
      reswrap = RestApiTestUtil.createCreditAdjustment();
    }
    return reswrap;
  }
  /**
   * create Sales Order to the TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static GTVAPIRestClient.ResponseWrapper createSalesOrder(
    Map<String, Object> paramsMap
  ) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVAPIOrderService req = new RestAPI2Service.GTVAPIOrderService(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    GTVAPIRestClient.ResponseWrapper reswrap;
    if (!Test.isRunningTest()) {
      reswrap = req.createOrder(paramsMap);
    } else {
      reswrap = RestApiTestUtil.createSalesOrder();
    }
    return reswrap;
  }

  /**
   * Post credit Adjustment to the TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static void postCreditAdjustment(Map<String, Object> paramsMap) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVAPIAdjustmentService req = new RestAPI2Service.GTVAPIAdjustmentService(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    req.postCreditAdjustment(paramsMap);
  }

  /**
   * Query debit Adjustment Reason from TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static GTVAPIRestClient.ResponseWrapper queryDeditAdjustmentReason(
    Map<String, Object> paramsMap
  ) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVAPIReasonService req = new RestAPI2Service.GTVAPIReasonService(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    GTVAPIRestClient.ResponseWrapper reswrap;
    if (!Test.isRunningTest()) {
      reswrap = req.queryDebitAdjustmentReasons(paramsMap);
    } else {
      reswrap = RestApiTestUtil.queryDeditAdjustmentReason();
    }
    return reswrap;
  }

  /**
   * create debit Adjustment to the TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static GTVAPIRestClient.ResponseWrapper createdebitAdjustment(
    Map<String, Object> paramsMap
  ) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVAPIAdjustmentService req = new RestAPI2Service.GTVAPIAdjustmentService(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    GTVAPIRestClient.ResponseWrapper reswrap;
    if (!Test.isRunningTest()) {
      reswrap = req.createDebitAdjustment(paramsMap);
    } else {
      reswrap = RestApiTestUtil.createdebitAdjustment();
    }
    return reswrap;
  }

  /**
   * Post debit Adjustment to the TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static void postDebitAdjustment(Map<String, Object> paramsMap) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVAPIAdjustmentService req = new RestAPI2Service.GTVAPIAdjustmentService(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    req.postDebitAdjustment(paramsMap);
  }
  /**
   * Update Service Quantity to the TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static void updateServiceQuantity(Map<String, Object> paramsMap) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVServiceApi req = new RestAPI2Service.GTVServiceApi(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    req.changeServiceQuantity(paramsMap);
  }

  /**
   * Resume Service to the TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static void resumeService(Map<String, Object> paramsMap) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVServiceApi req = new RestAPI2Service.GTVServiceApi(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    req.resumeService(paramsMap);
  }
  /**
   * Convert Service to the TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static void convertService(Map<String, Object> paramsMap) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVServiceApi req = new RestAPI2Service.GTVServiceApi(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    req.convertTrialService(paramsMap);
  }

  /**
   * get billing Account deactivation reasons
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static GTVAPIRestClient.ResponseWrapper getBillingAccountDeativationReasons(
    Map<String, Object> paramsMap
  ) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVAPIReasonService req = new RestAPI2Service.GTVAPIReasonService(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    GTVAPIRestClient.ResponseWrapper reswrap;
    if (!Test.isRunningTest()) {
      reswrap = req.queryBillingAccountDeactivationReasons(paramsMap);
    } else {
      reswrap = RestApiTestUtil.getBillingAccountDeativationReasons();
    }
    return reswrap;
  }

  /**
   * get billing Account suspension reasons
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static GTVAPIRestClient.ResponseWrapper getBillingAccountSuspensionReasons(
    Map<String, Object> paramsMap
  ) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVAPIReasonService req = new RestAPI2Service.GTVAPIReasonService(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    GTVAPIRestClient.ResponseWrapper reswrap;
    if (!Test.isRunningTest()) {
      reswrap = req.queryBillingAccountSuspensionReasons(paramsMap);
    } else {
      reswrap = RestApiTestUtil.getBillingAccountSuspensionReasons();
    }
    return reswrap;
  }

  /**
   * suspend billing account to the TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static void suspendBillingAccount(Map<String, Object> paramsMap) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVAPIBillingAccountService req = new RestAPI2Service.GTVAPIBillingAccountService(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    req.suspendBillingAccount(paramsMap);
  }
  /**
   * save Account Custom Field Value to the TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static void saveAccountCustomField(Map<String, Object> paramsMap) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVAPIBillingAccountService req = new RestAPI2Service.GTVAPIBillingAccountService(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    req.createBillingAccountCustomFieldValue(paramsMap);
  }

  /**
   * Deactivate billing account to the TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static void deactivateBillingAccount(Map<String, Object> paramsMap) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVAPIBillingAccountService req = new RestAPI2Service.GTVAPIBillingAccountService(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    req.deactivateBillingAccount(paramsMap);
  }

  /**
   * Resume billing account to the TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static void resumeBillingAccount(Map<String, Object> paramsMap) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVAPIBillingAccountService req = new RestAPI2Service.GTVAPIBillingAccountService(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    req.resumeBillingAccount(paramsMap);
  }

  /**
   * create billing account to the TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static void createBillingAccount(
    Id accountId,
    String billingAccountString
  ) {
    String billingAccountString1 = String.valueof(billingAccountString);
    RestAPI2Domain.GTVAPICreateBillingAccount tractBillingAccountObj = (RestAPI2Domain.GTVAPICreateBillingAccount) JSON.deserialize(
      billingAccountString1,
      RestAPI2Domain.GTVAPICreateBillingAccount.class
    );
    GTVAPIClient client = getGTVAPICredentials();
    Map<String, Object> paramsMap = new Map<String, Object>();
    RestAPI2Service.GTVAPIBillingAccountService req = new RestAPI2Service.GTVAPIBillingAccountService(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    paramsMap.put('billingAccount', tractBillingAccountObj);
    GTVAPIRestClient.ResponseWrapper billingAccountResponseWrap = req.createBillingAccount(
      paramsMap
    );
    RestAPI2Domain.GTVAPIBillingAccount billingAccountInstance = (RestAPI2Domain.GTVAPIBillingAccount) billingAccountResponseWrap.returnObject;
    if (
      billingAccountInstance != null &&
      billingAccountInstance.accountNum != null
    ) {
      list<Account> thisAccountList = [
        SELECT
          id,
          Name,
          Currency_Type__c,
          Tract_Billing_Account__c,
          Error_Message__c,
          status__c
        FROM Account
        WHERE id = :accountId
        LIMIT 1
      ];
      GTVRESTMappingService.mapBillingAccount(
        billingAccountInstance,
        thisAccountList
      );
    }
  }

  @future(callout=true)
  public static void makeFutureCalloutForAccountCreation(
    Id accountId,
    String billingAccountString
  ) {
    try {
      createBillingAccount(accountId, billingAccountString);
    } catch (Exception exp) {
      Account thisAccount = [
        SELECT
          id,
          Name,
          Currency_Type__c,
          Tract_Billing_Account__c,
          Error_Message__c,
          status__c
        FROM Account
        WHERE id = :accountId
        LIMIT 1
      ];
      thisAccount.Error_Message__c = exp.getmessage();
      thisAccount.Status__c = 'Error Occurred';
      if (
        TRACTAPIUtil.checkFieldLevelSecurity(
          'Account',
          'status__c,Error_Message__c',
          'Update'
        )
      ) {
        update thisAccount;
      }
    }
  }
  public static CreateAccountResponse globalActionCalloutForAccountCreation(
    Id accountId,
    String billingAccountString
  ) {
    CreateAccountResponse accountRes = new CreateAccountResponse();
    try {
      String billingAccountString1 = String.valueof(billingAccountString);
      RestAPI2Domain.GTVAPICreateBillingAccount tractBillingAccountObj = (RestAPI2Domain.GTVAPICreateBillingAccount) JSON.deserialize(
        billingAccountString1,
        RestAPI2Domain.GTVAPICreateBillingAccount.class
      );
      GTVAPIClient client = getGTVAPICredentials();
      Map<String, Object> paramsMap = new Map<String, Object>();
      RestAPI2Service.GTVAPIBillingAccountService req = new RestAPI2Service.GTVAPIBillingAccountService(
        client
      );
      paramsMap.put('prefer', 'x-api-key');
      paramsMap.put('billingAccount', tractBillingAccountObj);
      GTVAPIRestClient.ResponseWrapper billingAccountResponseWrap = req.createBillingAccount(
        paramsMap
      );
      RestAPI2Domain.GTVAPIBillingAccount billingAccountInstance = (RestAPI2Domain.GTVAPIBillingAccount) billingAccountResponseWrap.returnObject;
      if (billingAccountInstance != null && billingAccountInstance.Id != null) {
        accountRes.salesforceAccountId = accountId;
        accountRes.responseSuccess = true;
        accountRes.responseMessage = billingAccountResponseWrap.responseMessage;
        accountRes.responseCode = billingAccountResponseWrap.responseCode;
        accountRes.gtvAccountId = billingAccountInstance.id;
        accountRes.gtvAccountNumber = billingAccountInstance.accountNum;
      }
    } catch (Exception exp) {
      accountRes.salesforceAccountId = accountId;
      accountRes.responseSuccess = false;
      accountRes.responseMessage = exp.getmessage();
    }
    return accountRes;
  }

  /**
   * Query sales order from the TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static GTVAPIRestClient.ResponseWrapper querySalesOrder(
    Map<String, Object> paramsMap
  ) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVAPIOrderService req = new RestAPI2Service.GTVAPIOrderService(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    GTVAPIRestClient.ResponseWrapper reswrap;
    if (!Test.isRunningTest()) {
      reswrap = req.queryOrders(paramsMap);
    } else {
      reswrap = RestApiTestUtil.querySalesOrder();
    }
    return reswrap;
  }

  /**
   * Query Agreements from TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static GTVAPIRestClient.ResponseWrapper getAgreements(
    Map<String, Object> paramsMap
  ) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVAPIAgreementService req = new RestAPI2Service.GTVAPIAgreementService(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    GTVAPIRestClient.ResponseWrapper reswrap;
    if (!Test.isRunningTest()) {
      reswrap = req.getAgreement(paramsMap);
    } else {
      reswrap = RestApiTestUtil.getAgreements();
    }
    return reswrap;
  }
  /**
   * Query Agreements from TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static GTVAPIRestClient.ResponseWrapper queryInvoiceIems(
    Map<String, Object> paramsMap
  ) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVAPIInvoiceItemService req = new RestAPI2Service.GTVAPIInvoiceItemService(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    GTVAPIRestClient.ResponseWrapper reswrap;
    if (!Test.isRunningTest()) {
      reswrap = req.queryInvoiceItems(paramsMap);
    } else {
      reswrap = RestApiTestUtil.queryInvoiceItems();
    }
    return reswrap;
  }

  /**
   * Query Service from TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static GTVAPIRestClient.ResponseWrapper getService(
    Map<String, Object> paramsMap
  ) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVServiceApi req = new RestAPI2Service.GTVServiceApi(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    GTVAPIRestClient.ResponseWrapper reswrap;
    if (!Test.isRunningTest()) {
      reswrap = req.getService(paramsMap);
    } else {
      reswrap = RestApiTestUtil.queryService();
    }
    //GTVAPIRestClient.ResponseWrapper reswrap = req.getService(paramsMap);
    return reswrap;
  }

  /**
   * Query service custopm fields from the TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static GTVAPIRestClient.ResponseWrapper queryServiceCustomFields(
    Map<String, Object> paramsMap
  ) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVAPIServiceCustomFieldService req = new RestAPI2Service.GTVAPIServiceCustomFieldService(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    GTVAPIRestClient.ResponseWrapper reswrap;
    if (!Test.isRunningTest()) {
      reswrap = req.queryServiceCustomFields(paramsMap);
    } else {
      reswrap = RestApiTestUtil.queryServiceCustomFields();
    }
    return reswrap;
  }

  /**
   * Query discount code from the TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static GTVAPIRestClient.ResponseWrapper getDiscountCodesByProduct(
    Map<String, Object> paramsMap
  ) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVAPIDiscountCodeService req = new RestAPI2Service.GTVAPIDiscountCodeService(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    GTVAPIRestClient.ResponseWrapper reswrap;
    if (!Test.isRunningTest()) {
      reswrap = req.queryDiscountCodes(paramsMap);
    } else {
      reswrap = RestApiTestUtil.getDiscountCodesByProduct();
    }
    return reswrap;
  }

  /**
   * Query product category from the TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static GTVAPIRestClient.ResponseWrapper getProductCategory(
    Map<String, Object> paramsMap
  ) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVAPIProductCategoryService req = new RestAPI2Service.GTVAPIProductCategoryService(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    GTVAPIRestClient.ResponseWrapper reswrap;
    if (!Test.isRunningTest()) {
      reswrap = req.queryProductCategories(paramsMap);
    } else {
      reswrap = RestApiTestUtil.queryProductCategories();
    }
    return reswrap;
  }

  /**
   * Query product Tag from the TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static GTVAPIRestClient.ResponseWrapper getProductTags(
    Map<String, Object> paramsMap
  ) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVAPIProductTagService req = new RestAPI2Service.GTVAPIProductTagService(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    GTVAPIRestClient.ResponseWrapper reswrap;
    if (!Test.isRunningTest()) {
      reswrap = req.queryProductTags(paramsMap);
    } else {
      reswrap = RestApiTestUtil.queryProductTags();
    }
    return reswrap;
  }

  /**
   * create Product to the TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static GTVAPIRestClient.ResponseWrapper createGtvProduct(
    Map<String, Object> paramsMap
  ) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVAPIProductService req = new RestAPI2Service.GTVAPIProductService(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    GTVAPIRestClient.ResponseWrapper reswrap;
    if (!Test.isRunningTest()) {
      reswrap = req.createProduct(paramsMap);
    } else {
      reswrap = RestApiTestUtil.createProducts();
    }
    return reswrap;
  }

  /**
   * Query product Register Types from the TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static GTVAPIRestClient.ResponseWrapper getProductRegisterTypes(
    Map<String, Object> paramsMap
  ) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVAPIProductRegisterTypeService req = new RestAPI2Service.GTVAPIProductRegisterTypeService(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    GTVAPIRestClient.ResponseWrapper reswrap;
    if (!Test.isRunningTest()) {
      reswrap = req.queryProductRegisterTypes(paramsMap);
    } else {
      reswrap = RestApiTestUtil.queryProductRegisterTypes();
    }
    return reswrap;
  }
  /**
   * Query product Register Types from the TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static GTVAPIRestClient.ResponseWrapper createProductAgreement(
    Map<String, Object> paramsMap
  ) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVAPIProductService req = new RestAPI2Service.GTVAPIProductService(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    GTVAPIRestClient.ResponseWrapper reswrap;
    if (!Test.isRunningTest()) {
      reswrap = req.createProductAgreementRelation(paramsMap);
    }
    return reswrap;
  }

  /**
   * Query product Price Group from the TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static GTVAPIRestClient.ResponseWrapper getProductPriceGroups(
    Map<String, Object> paramsMap
  ) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVAPIProductPriceGroupService req = new RestAPI2Service.GTVAPIProductPriceGroupService(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    GTVAPIRestClient.ResponseWrapper reswrap;
    if (!Test.isRunningTest()) {
      reswrap = req.queryProductPriceGroups(paramsMap);
    } else {
      reswrap = RestApiTestUtil.queryProductPriceGroups();
    }
    return reswrap;
  }
  /**
   * Remove Agreement Relation from the TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static void removeAgreementRelation(Map<String, Object> paramsMap) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVAPIProductService req = new RestAPI2Service.GTVAPIProductService(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    GTVAPIRestClient.ResponseWrapper reswrap;
    if (!Test.isRunningTest()) {
      req.removeProductAgreementRelation(paramsMap);
    }
  }

  /**
   * create Product price to the TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static GTVAPIRestClient.ResponseWrapper createGtvProductPrice(
    Map<String, Object> paramsMap
  ) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVAPIProductService req = new RestAPI2Service.GTVAPIProductService(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    GTVAPIRestClient.ResponseWrapper reswrap;
    if (!Test.isRunningTest()) {
      reswrap = req.createProductPrice(paramsMap);
    } else {
      reswrap = RestApiTestUtil.createProductPrice();
    }
    return reswrap;
  }

  public static GTVAPIRestClient.ResponseWrapper updateGtvProductPrice(
    Map<String, Object> paramsMap
  ) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVAPIProductService req = new RestAPI2Service.GTVAPIProductService(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    GTVAPIRestClient.ResponseWrapper reswrap;
    if (!Test.isRunningTest()) {
      reswrap = req.updateProductPrice(paramsMap);
    } else {
      reswrap = RestApiTestUtil.createProductPrice();
    }
    return reswrap;
  }

  /**
   * Remove Agreement Relation from the TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static void activateProduct(Map<String, Object> paramsMap) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVAPIProductService req = new RestAPI2Service.GTVAPIProductService(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    GTVAPIRestClient.ResponseWrapper reswrap;
    if (!Test.isRunningTest()) {
      req.activateProduct(paramsMap);
    }
  }

  /**
   * Query product custom field from the TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static GTVAPIRestClient.ResponseWrapper getProductCustomFields(
    Map<String, Object> paramsMap
  ) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVAPIProductCustomFieldService req = new RestAPI2Service.GTVAPIProductCustomFieldService(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    GTVAPIRestClient.ResponseWrapper reswrap;
    if (!Test.isRunningTest()) {
      reswrap = req.queryProductCustomFields(paramsMap);
    } else {
      reswrap = RestApiTestUtil.queryProductCustomFields();
    }
    return reswrap;
  }

  /**
   * Query ProductCustomFieldValue from TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static GTVAPIRestClient.ResponseWrapper queryProductCustomFieldValues(
    Map<String, Object> paramsMap
  ) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVAPIProductCustomFieldValueService req = new RestAPI2Service.GTVAPIProductCustomFieldValueService(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    GTVAPIRestClient.ResponseWrapper reswrap;
    if (!Test.isRunningTest()) {
      reswrap = req.queryProductCustomFieldValues(paramsMap);
    } else {
      reswrap = RestApiTestUtil.queryProductCustomFieldValues();
    }
    return reswrap;
  }

  /**
   * save Product Custom Field Value to the TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static void saveProductCustomFieldValue(
    Map<String, Object> paramsMap
  ) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVAPIProductCustomFieldValueService req = new RestAPI2Service.GTVAPIProductCustomFieldValueService(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    req.createProductCustomFieldValue(paramsMap);
  }
  /**
   * query MarketPlace to the TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static GTVAPIRestClient.ResponseWrapper queryMarketPlaces(
    Map<String, Object> paramsMap
  ) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVAPIMarketplaceService req = new RestAPI2Service.GTVAPIMarketplaceService(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    GTVAPIRestClient.ResponseWrapper reswrap;
    if (!Test.isRunningTest()) {
      reswrap = req.queryMarketPlaces(paramsMap);
    } else {
      reswrap = RestApiTestUtil.queryMarketPlaces();
    }
    return reswrap;
  }
  /**
   * query MarketPlace PerriceList to the TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static GTVAPIRestClient.ResponseWrapper queryMarketPlacePriceList(
    Map<String, Object> paramsMap
  ) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVAPIMarketplaceService req = new RestAPI2Service.GTVAPIMarketplaceService(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    GTVAPIRestClient.ResponseWrapper reswrap;
    if (!Test.isRunningTest()) {
      reswrap = req.queryMarketplacePriceLists(paramsMap);
    }
    return reswrap;
  }
  /**
   * Remove Agreement Relation from the TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static void associateProduct(Map<String, Object> paramsMap) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVAPIPriceListService req = new RestAPI2Service.GTVAPIPriceListService(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    GTVAPIRestClient.ResponseWrapper reswrap;
    if (!Test.isRunningTest()) {
      req.associateProductToPriceList(paramsMap);
    }
  }
  /**
   * delete MarketPlace PerriceList to the TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static void removeMarketPlace(Map<String, Object> paramsMap) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVAPIMarketplaceService req = new RestAPI2Service.GTVAPIMarketplaceService(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    if (!Test.isRunningTest()) {
      req.removeMarketplace(paramsMap);
    }
  }
  /**
   * Get PriceList Relation to the TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static GTVAPIRestClient.ResponseWrapper getPriceListRelation(
    Map<String, Object> paramsMap
  ) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVAPIPriceListService req = new RestAPI2Service.GTVAPIPriceListService(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    GTVAPIRestClient.ResponseWrapper reswrap;
    if (!Test.isRunningTest()) {
      reswrap = req.getPriceListProductRelation(paramsMap);
    } else {
      reswrap = RestApiTestUtil.getPriceListProductRelation();
    }
    return reswrap;
  }
  /**
   * delete MarketPlace PerriceList to the TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static void removePriceListProductRelation(
    Map<String, Object> paramsMap
  ) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVAPIPriceListService req = new RestAPI2Service.GTVAPIPriceListService(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    if (!Test.isRunningTest()) {
      req.removePriceListProductRelation(paramsMap);
    }
  }

  /**
   * delete product relation to the TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static void removeProductRelation(Map<String, Object> paramsMap) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVAPIProductRelationService req = new RestAPI2Service.GTVAPIProductRelationService(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    if (!Test.isRunningTest()) {
      req.removeProductRelation(paramsMap);
    }
  }

  /**
   * Get Product prices to the TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static GTVAPIRestClient.ResponseWrapper queryProductPrices(
    Map<String, Object> paramsMap
  ) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVAPIProductPriceService req = new RestAPI2Service.GTVAPIProductPriceService(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    GTVAPIRestClient.ResponseWrapper reswrap;
    if (!Test.isRunningTest()) {
      reswrap = req.queryProductPrices(paramsMap);
    } else {
      reswrap = RestApiTestUtil.queryProductPrices();
    }
    return reswrap;
  }

  /**
   * Query Discount Resource from the TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static GTVAPIRestClient.ResponseWrapper getProductDiscountResourceList(
    Map<String, Object> paramsMap
  ) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVAPIDiscountResourceService req = new RestAPI2Service.GTVAPIDiscountResourceService(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    GTVAPIRestClient.ResponseWrapper reswrap;
    if (!Test.isRunningTest()) {
      reswrap = req.queryDiscountResources(paramsMap);
    } else {
      reswrap = RestApiTestUtil.queryDiscountResources();
    }
    return reswrap;
  }
  /**
   * Query OrderCustomFields from TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static GTVAPIRestClient.ResponseWrapper queryAccountCustomFields(
    Map<String, Object> paramsMap,
    TRACT_Setup__c tractConfigObj
  ) {
    GTVAPIClient client = api2ClientObj = new GTVAPIClient(tractConfigObj);
    client.setApiKey(tractConfigObj.X_API_Key__c, 'x-api-key');
    RestAPI2Service.GTVAPIBillingAccountCustomFieldService req = new RestAPI2Service.GTVAPIBillingAccountCustomFieldService(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    GTVAPIRestClient.ResponseWrapper reswrap;
    if (!Test.isRunningTest()) {
      reswrap = req.queryBillingAccountCustomFields(paramsMap);
    } else {
      reswrap = RestApiTestUtil.queryAccountCustomFields();
    }
    return reswrap;
  }
  /**
   * query MarketPlace to the TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static GTVAPIRestClient.ResponseWrapper queryMarketPlaces(
    Map<String, Object> paramsMap,
    TRACT_Setup__c tractConfig
  ) {
    GTVAPIClient client = api2ClientObj = new GTVAPIClient(tractConfig);
    client.setApiKey(tractConfig.X_API_Key__c, 'x-api-key');
    RestAPI2Service.GTVAPIMarketplaceService req = new RestAPI2Service.GTVAPIMarketplaceService(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    GTVAPIRestClient.ResponseWrapper reswrap;
    if (!Test.isRunningTest()) {
      reswrap = req.queryMarketPlaces(paramsMap);
    } else {
      reswrap = RestApiTestUtil.queryMarketPlaces();
    }
    return reswrap;
  }
  /**
   * download Pdf from TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static GTVAPIRestClient.ResponseWrapper queryProductChargeRules(
    Map<String, Object> paramsMap
  ) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVAPIProductUsageRuleService req = new RestAPI2Service.GTVAPIProductUsageRuleService(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    GTVAPIRestClient.ResponseWrapper reswrap;

    if (!Test.isRunningTest()) {
      reswrap = req.queryProductUsageRules(paramsMap);
    } else {
      reswrap = RestApiTestUtil.queryProductChargeRules();
    }
    return reswrap;
  }
  /**
   * Create Usage Rule from TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static GTVAPIRestClient.ResponseWrapper createProductUsageRule(
    Map<String, Object> paramsMap
  ) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVAPIProductUsageRuleService req = new RestAPI2Service.GTVAPIProductUsageRuleService(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    GTVAPIRestClient.ResponseWrapper reswrap;
    if (!Test.isRunningTest()) {
      reswrap = req.createProductUsageRule(paramsMap);
    }
    return reswrap;
  }

  public static GTVAPIRestClient.ResponseWrapper getPaymentToken(
    Map<String, Object> paramsMap
  ) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVAPICreatePaymentService req = new RestAPI2Service.GTVAPICreatePaymentService(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    GTVAPIRestClient.ResponseWrapper reswrap;
    if (!Test.isRunningTest()) {
      reswrap = req.getPaymentRefererToken(paramsMap);
    } else {
      reswrap = RestApiTestUtil.getRefererToken();
    }
    return reswrap;
  }
  public static GTVAPIRestClient.ResponseWrapper createPaymentMethod(
    Map<String, Object> paramsMap
  ) {
    TRACT_Setup__c tractSetupObj = getTractSetup();
    GTVAPIClient client = new GTVAPIClient(tractSetupObj);
    client.basePath = tractSetupObj.Gotransverse_Hosted_Payment_URL__c;
    RestAPI2Service.GTVAPICreatePaymentService req = new RestAPI2Service.GTVAPICreatePaymentService(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    GTVAPIRestClient.ResponseWrapper reswrap;
    if (!Test.isRunningTest()) {
      reswrap = req.getPaymentToken(paramsMap);
    } else {
      reswrap = RestApiTestUtil.getPaymentToken();
    }
    return reswrap;
  }
  public static GTVAPIRestClient.ResponseWrapper createRecurringPayment(
    Map<String, Object> paramsMap
  ) {
    TRACT_Setup__c tractSetupObj = getTractSetup();
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVAPIBillingAccountService req = new RestAPI2Service.GTVAPIBillingAccountService(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    GTVAPIRestClient.ResponseWrapper reswrap;
    if (!Test.isRunningTest()) {
      reswrap = req.createRecurringPayment(paramsMap);
    } else {
      reswrap = RestApiTestUtil.createPayment();
    }
    return reswrap;
  }
  public static GTVAPIRestClient.ResponseWrapper createBillingAccountPayment(
    Map<String, Object> paramsMap
  ) {
    TRACT_Setup__c tractSetupObj = getTractSetup();
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVAPIBillingAccountService req = new RestAPI2Service.GTVAPIBillingAccountService(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    GTVAPIRestClient.ResponseWrapper reswrap;
    if (!Test.isRunningTest()) {
      reswrap = req.createPayment(paramsMap);
    } else {
      reswrap = RestApiTestUtil.createPayment();
    }
    return reswrap;
  }

  /**
   * Compatible Products from TRACT db to the specified parameters
   * @param paramsMap The map of parameters (required)
   * @return GTVAPIRestClient.ResponseWrapper
   * @throws GTVAPIRestClient.ApiException if fails to make API call
   */
  public static GTVAPIRestClient.ResponseWrapper getCompatibleProducts(
    Map<String, Object> paramsMap
  ) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVServiceApi req = new RestAPI2Service.GTVServiceApi(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    GTVAPIRestClient.ResponseWrapper reswrap;
    if (!Test.isRunningTest()) {
      reswrap = req.getCompatibleProducts(paramsMap);
    } else {
      reswrap = RestApiTestUtil.queryProducts();
    }
    return reswrap;
  }

  public static GTVAPIRestClient.ResponseWrapper createChangeOrders(
    Map<String, Object> paramsMap
  ) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVServiceApi req = new RestAPI2Service.GTVServiceApi(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    GTVAPIRestClient.ResponseWrapper reswrap;
    if (!Test.isRunningTest()) {
      reswrap = req.changeService(paramsMap);
    }
    return reswrap;
  }

  public static GTVAPIRestClient.ResponseWrapper createServiceResources(
    Map<String, Object> paramsMap
  ) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVAPIServiceResourceService req = new RestAPI2Service.GTVAPIServiceResourceService(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    GTVAPIRestClient.ResponseWrapper reswrap;
    if (!Test.isRunningTest()) {
      reswrap = req.createServiceResource(paramsMap);
    }
    return reswrap;
  }

  public static GTVAPIRestClient.ResponseWrapper createBillingAccount(
    Map<String, Object> paramsMap
  ) {
    GTVAPIClient client = getGTVAPICredentials();
    RestAPI2Service.GTVAPIBillingAccountService req = new RestAPI2Service.GTVAPIBillingAccountService(
      client
    );
    paramsMap.put('prefer', 'x-api-key');
    GTVAPIRestClient.ResponseWrapper reswrap;
    if (!Test.isRunningTest()) {
      reswrap = req.createBillingAccount(paramsMap);
    } else {
      reswrap = RestApiTestUtil.getbillingAccount();
    }
    return reswrap;
  }
}