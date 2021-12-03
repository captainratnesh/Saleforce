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
 * This class is use to make the SOAP API's callouts.
 * @author AMAN JAIN
 */

public with sharing class GTVAPI133Adapter {
  public static TRACT_Setup__c tractConfig;

  /**
   * Query GTV API setup object from Salesforce
   * @return TRACT_Setup__c The GTV API setup object
   */
  private static TRACT_Setup__c getTractSetup() {
    if (tractConfig == null) {
      tractConfig = [
        SELECT
          id,
          TPassword__c,
          Tract_User_Name__c,
          TRACT_URL__c,
          Api_Version__c,
          Active__c,
          TRACT_URL2_0__c,
          OrderStatus__c
        FROM TRACT_Setup__c
        WHERE Active__c = TRUE
        LIMIT 1
      ];
    }
    return tractConfig;
  }

  /**
   * Intialize Tract Service Endpoint
   * @param tractConfig configuration setting detail to configure with tract
   * @return port
   */
  public static SoapApi33Service.TractPort getTractServicePort(
    TRACT_Setup__c tractConfig
  ) {
    SoapApi33Service.TractPort port = new SoapApi33Service.TractPort();

    //Prepare String for base64 Encoding
    String userPass =
      tractConfig.Tract_User_Name__c +
      ':' +
      tractConfig.TPassword__c;
    String encodedusernameandpassword = EncodingUtil.base64Encode(
      Blob.valueOf(userPass)
    );

    //Set Authorization Header
    port.inputHttpHeaders_x = new Map<String, String>();
    port.inputHttpHeaders_x.put(
      'Authorization',
      'Basic ' + encodedusernameandpassword
    );
    port.endpoint_x = tractConfig.TRACT_URL__c;
    port.timeout_x = 120000;

    return port;
  }
  /**
   * @description method to query data from tract using parameter and values
   * @param tractConfig configuration setting detail to configure with tract
   * @param entityType entity type to query detail
   * @param paramName parameter name
   * @param paramValue parameter value
   * @param pageNumber pagenumber from which data to be fetched for the entity
   * @param pageSize size of page
   * @param queryScope scope of the query
   * @return response
   */
  public static SoapApi33Domain.QueryResponse queryTractByParamAndValue(
    TRACT_Setup__c tractConfig,
    String entityType,
    String paramName,
    String paramValue,
    Integer pageNumber,
    Integer pageSize,
    String queryScope
  ) {
    //Prepare Query
    SoapApi33Domain.SimpleDataQuery sdq = new SoapApi33Domain.SimpleDataQuery();

    if (entityType != null) {
      sdq.type_x = entityType;
    }
    if (paramName != null && paramValue != null) {
      SoapApi33Domain.ParameterAndValue[] params = new List<SoapApi33Domain.ParameterAndValue>();
      SoapApi33Domain.ParameterAndValue paramAndValue = new SoapApi33Domain.ParameterAndValue();
      paramAndValue.parameter = paramName;
      paramAndValue.parameterValue = paramvalue;
      paramAndValue.operator = 'EQ';
      params.add(paramAndValue);
      sdq.parameter = params;
    }

    if (pageNumber != null) {
      sdq.pageNumber = pageNumber;
    }

    if (pageSize != null) {
      sdq.pageSize = pageSize;
    }

    SoapApi33Domain.QueryRequest queryRequest = new SoapApi33Domain.QueryRequest();
    queryRequest.simpleDataQuery = sdq;

    if (queryScope != null) {
      queryRequest.queryScope = queryScope;
    }

    SoapApi33Service.TractPort tract = getTractServicePort(tractConfig);
    tract.timeout_x = 120000;
    if (!Test.isRunningTest()) {
      SoapApi33Domain.QueryResponse response = tract.query(queryRequest);
      return response;
    } else
      return null;
  }
  /**
   * @description method to query data from tract.
   * @param tractConfig configuration setting detail to configure with tract
   * @param entityType entity type to query detail
   * @param params parameters for query
   * @param pageNumber pagenumber from which data to be fetched for the entity
   * @param pageSize size of page
   * @param queryScope scope of the query
   * @return response
   */
  public static SoapApi33Domain.QueryResponse queryTract(
    TRACT_Setup__c tractConfig,
    String entityType,
    SoapApi33Domain.ParameterAndValue[] params,
    Integer pageNumber,
    Integer pageSize,
    String queryScope
  ) {
    //Prepare Query
    SoapApi33Domain.SimpleDataQuery sdq = new SoapApi33Domain.SimpleDataQuery();

    if (entityType != null)
      sdq.type_x = entityType;

    if (params != null && params.size() > 0) {
      sdq.parameter = params;
    }

    if (pageNumber != null) {
      sdq.pageNumber = pageNumber;
    }

    if (pageSize != null) {
      sdq.pageSize = pageSize;
    }

    SoapApi33Domain.QueryRequest queryRequest = new SoapApi33Domain.QueryRequest();
    queryRequest.simpleDataQuery = sdq;

    if (queryScope != null) {
      queryRequest.queryScope = queryScope;
    }
    SoapApi33Service.TractPort tract = getTractServicePort(tractConfig);
    if (!Test.isRunningTest()) {
      SoapApi33Domain.QueryResponse response = tract.query(queryRequest);
      return response;
    } else {
      return null;
    }
  }

  /**
   * @description method to query data from tract by Where Clause.
   * @param tractConfig configuration setting detail to configure with tract
   * @param entityType entity type to query detail
   * @param entityTypeName name of the entity type for where clause
   * @param clauseValue value for where clause
   * @param pageNumber pagenumber from which data to be fetched for the entity
   * @param pageSize size of page
   * @param queryScope scope of the query
   * @return response
   */
  public static SoapApi33Domain.QueryResponse queryTractByWhereClause(
    TRACT_Setup__c tractConfig,
    String entityType,
    String entityTypeName,
    String clauseValue,
    Integer pageNumber,
    Integer pageSize,
    String queryScope
  ) {
    //Prepare Query
    SoapApi33Domain.SimpleDataQuery sdq = new SoapApi33Domain.SimpleDataQuery();

    if (entityType != null) {
      sdq.type_x = entityType;
    }
    if (entityTypeName != null && clauseValue != null) {
      SoapApi33Domain.WhereClause[] clauses = new List<SoapApi33Domain.WhereClause>();
      SoapApi33Domain.WhereClause clauseValues = new SoapApi33Domain.WhereClause();
      clauseValues.entityType = entityTypeName;
      clauseValues.clause = clauseValue;
      clauses.add(clauseValues);
      sdq.whereClause = clauses;
    }

    if (pageNumber != null) {
      sdq.pageNumber = pageNumber;
    }

    if (pageSize != null) {
      sdq.pageSize = pageSize;
    }

    SoapApi33Domain.QueryRequest queryRequest = new SoapApi33Domain.QueryRequest();
    queryRequest.simpleDataQuery = sdq;

    if (queryScope != null) {
      queryRequest.queryScope = queryScope;
    }

    SoapApi33Service.TractPort tract = getTractServicePort(tractConfig);
    tract.timeout_x = 120000;
    if (!Test.isRunningTest()) {
      SoapApi33Domain.QueryResponse response = tract.query(queryRequest);
      return response;
    } else
      return null;
  }
  /**
   * @description method to get system setting.
   * @param systemSettingMap map of <string,string>
   * @return systemSettingMap after updating required setting in the map.
   */
  public static Map<String, String> getSystemSetting(
    Map<String, String> systemSettingMap
  ) {
    String value, location;
    for (System_Setting__c settings : System_Setting__c.getall().values()) {
      if (settings.name == 'Currency Identification') {
        value = settings.value__c;
        systemSettingMap.put('value', value);
      }
      if (settings.name == 'Currency Location') {
        location = settings.value__c;
        systemSettingMap.put('location', location);
      }
    }
    return systemSettingMap;
  }

  /**
   * Query a BillingAccount from GTV db to the specified parameters
   * @param accountNum The account number of GTV billing account(required)
   * @param queryScope The scope of query(required)
   * @return SoapApi33Domain.BillingAccount[]
   */
  public static SoapApi33Domain.BillingAccount[] getBillingAccountByNumber(
    string accountNum,
    string queryScope
  ) {
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Domain.BillingAccount[] billingAccounts;
    SoapApi33Domain.QueryResponse queryResponse;
    if (!Test.isRunningTest()) {
      queryResponse = queryTractByParamAndValue(
        tractConfig,
        'BillingAccount',
        'accountNum',
        accountNum,
        1,
        1,
        queryScope
      );
    } else {
      queryResponse = SoapApi33TestUtil.getBillingAccounts();
    }
    if (
      queryResponse.successful &&
      null != queryResponse.billingAccounts.billingAccount
    ) {
      billingAccounts = queryResponse.billingAccounts.billingAccount;
    } else {
      //TODOs: Either request failed or account not found.
      billingAccounts = new List<SoapApi33Domain.BillingAccount>();
    }
    return billingAccounts;
  }

  /**
   * Query payments from GTV db to the specified parameters
   * @param tractBillingAccount The billing account wrapper(required)
   * @param pageNumber, pagenumber from which data to be fetched for the entity(required)
   * @return SoapApi33Domain.QueryResponse
   */
  public static SoapApi33Domain.QueryResponse getBillingAccountPayments(
    TRACTAccountWrapper tractBillingAccount,
    Integer pageNumber
  ) {
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Domain.QueryResponse queryResponse;
    /* Querying Payments records from Tract by making callout */
    if (!Test.isRunningTest()) {
      queryResponse = queryTractByParamAndValue(
        tractConfig,
        'Payment',
        'accountNum',
        tractBillingAccount.billingAccount.Tract_Billing_Account__c,
        pageNumber,
        null,
        'SHALLOW'
      );
    } else {
      queryResponse = SoapApi33TestUtil.getPayments();
    }
    return queryResponse;
  }

  /**
   * Query payment applications from GTV db to the specified parameters
   * @param condition The filter to fetch payment applications(required)
   * @return Map<String,String>
   */
  public static Map<String, String> getPaymentApplication(String condition) {
    TRACT_Setup__c tractConfig = getTractSetup();
    Integer totelpagePaymentApplication;
    SoapApi33Domain.QueryResponse queryResponse1;
    SoapApi33Domain.QueryResponse queryResponse2;
    Map<String, String> paymentEidvsInvoiceIdMap = new Map<String, String>();
    /* Querying PaymentApplications records from Tract by making callout */
    if (!Test.isRunningTest()) {
      queryResponse1 = queryTractByWhereClause(
        tractConfig,
        'PaymentApplication',
        'PaymentApplication',
        condition,
        1,
        50,
        'DEEP'
      );
    } else {
      queryResponse1 = SoapApi33TestUtil.getPaymentApplication();
    }
    /* Check if Payments records exist or not */
    if (
      queryResponse1.successful &&
      null !=
      queryResponse1.paymentApplications.standardInvoicePaymentApplication
    ) {
      /* Total number of record pages */
      if (queryResponse1.PaymentApplications.totalPages != null) {
        totelpagePaymentApplication = queryResponse1.PaymentApplications.totalPages;
      }
      for (Integer i = 2; i <= totelpagePaymentApplication; i++) {
        if (!Test.isRunningTest())
          queryResponse2 = queryTractByWhereClause(
            tractConfig,
            'PaymentApplication',
            'PaymentApplication',
            condition,
            i,
            50,
            'DEEP'
          );
        else
          queryResponse2 = SoapApi33TestUtil.getPaymentApplication();
        if (
          queryResponse2.successful &&
          null !=
          queryResponse2.PaymentApplications.standardInvoicePaymentApplication
        )
          queryResponse1.PaymentApplications.standardInvoicePaymentApplication.addall(
            queryResponse2.PaymentApplications.standardInvoicePaymentApplication
          );
      }
      for (
        SoapApi33Domain.StandardInvoicePaymentApplication tempInvPaymentApp : queryResponse1.PaymentApplications.standardInvoicePaymentApplication
      ) {
        if (
          paymentEidvsInvoiceIdMap.containsKey(tempInvPaymentApp.payment.eid)
        ) {
          String value = paymentEidvsInvoiceIdMap.get(
            tempInvPaymentApp.payment.eid
          );
          value += ', ' + tempInvPaymentApp.invoice.invoiceNum;
          paymentEidvsInvoiceIdMap.put(tempInvPaymentApp.payment.eid, value);
        } else {
          paymentEidvsInvoiceIdMap.put(
            tempInvPaymentApp.payment.eid,
            tempInvPaymentApp.invoice.invoiceNum
          );
        }
      }
    }
    return paymentEidvsInvoiceIdMap;
  }

  /**
   * Query Invoices from GTV db to the specified parameters
   * @param tractBillingAccount The billing account wrapper(required)
   * @param pageNumber page number from which data to be fetched for the entity(required)
   * @return SoapApi33Domain.QueryResponse
   */
  public static SoapApi33Domain.QueryResponse getBillingAccountInvoices(
    TRACTAccountWrapper tractBillingAccount,
    Integer pageNumber
  ) {
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Domain.QueryResponse queryResponse;
    /* Querying Invoices from Tract by making callout */
    if (!Test.isRunningTest()) {
      queryResponse = queryTractByParamAndValue(
        tractConfig,
        'Invoice',
        'accountNum',
        tractBillingAccount.billingAccount.Tract_Billing_Account__c,
        pageNumber,
        null,
        'SHALLOW'
      );
    } else {
      queryResponse = SoapApi33TestUtil.getInvoices();
    }
    return queryResponse;
  }
  /**
   * Query Adjustments from GTV db to the specified parameters
   * @param tractBillingAccount The billing account wrapper(required)
   * @param pageNumber page number from which data to be fetched for the entity(required)
   * @return SoapApi33Domain.QueryResponse
   */
  public static SoapApi33Domain.QueryResponse getBillingAccountAdjustments(
    TRACTAccountWrapper tractBillingAccount,
    Integer pageNumber
  ) {
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Domain.QueryResponse queryResponse;
    /* Querying Adjustment records from Tract by making callout */
    if (!Test.isRunningTest()) {
      queryResponse = queryTractByParamAndValue(
        tractConfig,
        'Adjustment',
        'accountNum',
        tractBillingAccount.billingAccount.Tract_Billing_Account__c,
        pageNumber,
        null,
        'DEEP'
      );
    } else {
      queryResponse = SoapApi33TestUtil.getAdjustments();
    }
    return queryResponse;
  }
  /**
   * Query service usage rules from GTV db to the specified parameters
   * @param activityProductEid product id of tract(required)
   * @return SoapApi33Domain.QueryResponse
   */
  public static SoapApi33Domain.QueryResponse getserviceUsageRules(
    String activityProductEid
  ) {
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Domain.QueryResponse queryResponse;
    if (!Test.isRunningTest()) {
      queryResponse = queryTractByParamAndValue(
        tractConfig,
        'ServiceUsageRule',
        'serviceEid',
        activityProductEid,
        1,
        50,
        'DEEP'
      );
    } else {
      queryResponse = SoapApi33TestUtil.getserviceUsageRules();
    }
    return queryResponse;
  }
  /**
   * Query account from GTV db to the specified parameters
   * @param AccountNumber tract account number(required)
   * @return SoapApi33Domain.QueryResponse
   */
  public static SoapApi33Domain.QueryResponse queryBillingAccount(
    String accountNumber
  ) {
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Domain.QueryResponse queryResponse;
    if (!Test.isRunningTest()) {
      queryResponse = queryTractByParamAndValue(
        tractConfig,
        'BillingAccount',
        'accountNum',
        accountNumber,
        null,
        null,
        'DEEP'
      );
    } else {
      queryResponse = SoapApi33TestUtil.getBillingAccounts();
    }
    return queryResponse;
  }

  /**
   * Query Invoice Adjustment Applications from GTV db to the specified parameters
   * @param invoiceAdjustmentFilter filter of invoice adjustments(required)
   * @return SoapApi33Domain.QueryResponse
   */
  public static Map<String, String> getInvoiceAdjustmentApplications(
    String invoiceAdjustmentFilter
  ) {
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Domain.QueryResponse invoiceAdjustmentApplicationResponse;
    Map<String, String> adjustmentEidvsInvoiceIdMap = new Map<String, String>();

    /* Querying InvoiceAdjustmentApplication records from Tract by making callout */
    if (!Test.isRunningTest()) {
      invoiceAdjustmentApplicationResponse = queryTractByWhereClause(
        tractConfig,
        'InvoiceAdjustmentApplication',
        'InvoiceAdjustmentApplication',
        invoiceAdjustmentFilter,
        1,
        50,
        'DEEP'
      );
    } else {
      invoiceAdjustmentApplicationResponse = SoapApi33TestUtil.getinvoiceAdjustmentApplications();
    }
    /* getting invoiceNum from InvoiceAdjustmentApplication response */
    if (
      invoiceAdjustmentApplicationResponse.successful &&
      invoiceAdjustmentApplicationResponse != null &&
      invoiceAdjustmentApplicationResponse.invoiceAdjustmentApplications !=
      null &&
      invoiceAdjustmentApplicationResponse.invoiceAdjustmentApplications.standardInvoiceAdjustmentApplication !=
      null &&
      !invoiceAdjustmentApplicationResponse.invoiceAdjustmentApplications.standardInvoiceAdjustmentApplication.isEmpty()
    ) {
      for (
        SoapApi33Domain.StandardInvoiceAdjustmentApplication standardInvoices : invoiceAdjustmentApplicationResponse.invoiceAdjustmentApplications.standardInvoiceAdjustmentApplication
      ) {
        if (
          adjustmentEidvsInvoiceIdMap.containsKey(
            standardInvoices.accountAdjustment.eid
          )
        ) {
          String value = adjustmentEidvsInvoiceIdMap.get(
            standardInvoices.accountAdjustment.eid
          );
          value += ', ' + standardInvoices.invoice.invoiceNum;
          adjustmentEidvsInvoiceIdMap.put(
            standardInvoices.accountAdjustment.eid,
            value
          );
        } else {
          adjustmentEidvsInvoiceIdMap.put(
            standardInvoices.accountAdjustment.eid,
            standardInvoices.invoice.invoiceNum
          );
        }
      }
    }
    return adjustmentEidvsInvoiceIdMap;
  }
  /**
   * Query Notes from GTV db to the specified parameters
   * @param tractBillingAccount The billing account wrapper(required)
   * @param pageNumber page number from which data to be fetched for the entity(required)
   * @return SoapApi33Domain.QueryResponse
   */
  public static SoapApi33Domain.QueryResponse notes(
    TRACTAccountWrapper tractBillingAccount,
    Integer pageNumber
  ) {
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Domain.QueryResponse queryResponse;
    /* Querying Notes records from Tract by making callout */
    if (!Test.isRunningTest()) {
      queryResponse = queryTractByParamAndValue(
        tractConfig,
        'Note',
        'billingAccountEid',
        tractBillingAccount.eid,
        pageNumber,
        50,
        'DEEP'
      );
    } else {
      queryResponse = SoapApi33TestUtil.getNotes();
    }
    return queryResponse;
  }
  /**
   * Query Contacts from GTV db to the specified parameters
   * @param tractBillingAccount The billing account wrapper(required)
   * @param pageNumber page number from which data to be fetched for the entity(required)
   * @return SoapApi33Domain.QueryResponse
   */
  public static SoapApi33Domain.QueryResponse contacts(
    TRACTAccountWrapper tractBillingAccount,
    Integer pageNumber
  ) {
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Domain.QueryResponse queryResponse;
    /* Querying Adjustment records from Tract by making callout */
    if (!Test.isRunningTest()) {
      queryResponse = queryTractByParamAndValue(
        tractConfig,
        'Person',
        'billingAccountEid',
        tractBillingAccount.eid,
        pageNumber,
        50,
        'DEEP'
      );
    } else {
      queryResponse = SoapApi33TestUtil.getContacts();
    }
    return queryResponse;
  }
  /**
   * Query Sales order from GTV db to the specified parameters
   * @param tractBillingAccount The billing account wrapper(required)
   * @param pageNumber page number from which data to be fetched for the entity(required)
   * @return SoapApi33Domain.QueryResponse
   */
  public static SoapApi33Domain.QueryResponse getBillingAccountSalesOrders(
    TRACTAccountWrapper tractBillingAccount,
    Integer pagenumber
  ) {
    TRACT_Setup__c tractConfig = getTractSetup();
    /* Added to query all the records of the entity as in a single callout we only get 50 records of the entity */
    SoapApi33Domain.SalesOrder[] accountOrders;
    SoapApi33Domain.QueryResponse queryResponse;
    Integer totelpage;
    TractSalesOrderWrapper orderWrapper = new TractSalesOrderWrapper();

    /* Querying SalesOrder from Tract by making callout */
    if (!Test.isRunningTest()) {
      queryResponse = queryTractByParamAndValue(
        tractConfig,
        'SalesOrder',
        'accountNum',
        tractBillingAccount.billingAccount.Tract_Billing_Account__c,
        pagenumber,
        null,
        'SHALLOW'
      );
    } else {
      queryResponse = SoapApi33TestUtil.getSalesOrders();
    }
    return queryResponse;
  }
  /**
   * Query payment Method from GTV db to the specified parameters
   * @param tractBillingAccount The billing account wrapper(required)
   * @param pageNumber page number from which data to be fetched for the entity(required)
   * @return SoapApi33Domain.QueryResponse
   */
  public static SoapApi33Domain.QueryResponse getpaymentMethodRecords(
    TRACTAccountWrapper tractBillingAccount,
    Integer pageNumber
  ) {
    SoapApi33Domain.QueryResponse paymentMethodsQueryResponse;
    TRACT_Setup__c tractConfig = getTractSetup();
    if (!Test.isRunningTest()) {
      paymentMethodsQueryResponse = queryTractByParamAndValue(
        tractConfig,
        'BillingAccountRecurringPayment',
        'accountNum',
        tractBillingAccount.billingAccount.Tract_Billing_Account__c,
        pageNumber,
        50,
        'DEEP'
      );
    } else {
      paymentMethodsQueryResponse = SoapApi33TestUtil.getPaymentMethods();
    }
    return paymentMethodsQueryResponse;
  }
  /**
   * Query Activity/Events from GTV db to the specified parameters
   * @param tractBillingAccount The billing account wrapper(required)
   * @param pageNumber page number from which data to be fetched for the entity(required)
   * @return SoapApi33Domain.QueryResponse
   */
  public static SoapApi33Domain.QueryResponse getActivityEvents(
    TRACTAccountWrapper tractBillingAccount,
    Integer pagenumber
  ) {
    SoapApi33Domain.QueryResponse activityEventsQueryResponse;
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Domain.ParameterAndValue[] params = new List<SoapApi33Domain.ParameterAndValue>{};

    /* Setting the parameters while querying events */
    SoapApi33Domain.ParameterAndValue param1 = new SoapApi33Domain.ParameterAndValue();
    param1.parameter = 'accountNum';
    param1.parameterValue = tractBillingAccount.billingAccount.Tract_Billing_Account__c;
    param1.operator = 'EQ';

    SoapApi33Domain.ParameterAndValue param2 = new SoapApi33Domain.ParameterAndValue();
    param2.parameter = 'closed';
    param2.parameterValue = 'false';
    param2.operator = 'EQ';

    params.add(param1);
    params.add(param2);

    if (!Test.isRunningTest()) {
      activityEventsQueryResponse = queryTract(
        tractConfig,
        'UsageEvent',
        params,
        pagenumber,
        25,
        'DEEP'
      );
    } else {
      activityEventsQueryResponse = SoapApi33TestUtil.getusageRules();
    }
    return activityEventsQueryResponse;
  }
  /**
   * Query pricelists from GTV db to the specified parameters
   * @param marketPlaceId tract marketplace id(required)
   * @return SoapApi33Domain.QueryResponse
   */
  public static SoapApi33Domain.QueryResponse getPriceLists(
    String marketPlaceId
  ) {
    SoapApi33Domain.QueryResponse queryResponse;
    TRACT_Setup__c tractConfig = getTractSetup();
    if (!Test.isRunningTest()) {
      queryResponse = queryTractByParamAndValue(
        tractConfig,
        'PriceList',
        'marketPlaceEid',
        marketPlaceId,
        null,
        null,
        'DEEP'
      );
    } else {
      queryResponse = SoapApi33TestUtil.getPriceListValue();
    }
    return queryResponse;
  }
  /**
   * Query system setting from GTV db to the specified parameters
   * @return SoapApi33Domain.QueryResponse
   */
  public static SoapApi33Domain.QueryResponse getSystemSettings() {
    SoapApi33Domain.QueryResponse systemSettingsQueryResponse;
    TRACT_Setup__c tractConfig = getTractSetup();
    if (!Test.isRunningTest()) {
      systemSettingsQueryResponse = queryTractByWhereClause(
        tractConfig,
        'SystemSetting',
        'SystemSetting',
        'name like \'Currency%\'',
        1,
        50,
        'DEEP'
      );
    } else {
      systemSettingsQueryResponse = SoapApi33TestUtil.getSystemSettings();
    }
    return systemSettingsQueryResponse;
  }
  /**
   * Query sales order using Eid from GTV db to the specified parameters
   * @param returnEid order id(required)
   * @return SoapApi33Domain.QueryResponse
   */
  public static SoapApi33Domain.QueryResponse getSalesOrdersByEid(
    String returnEid
  ) {
    SoapApi33Domain.QueryResponse queryResponse;
    TRACT_Setup__c tractConfig = getTractSetup();
    if (!Test.isRunningTest()) {
      queryResponse = queryTractByParamAndValue(
        tractConfig,
        'SalesOrder',
        'eid',
        returnEid,
        null,
        null,
        null
      );
    } else {
      queryResponse = SoapApi33TestUtil.getSalesOrders();
    }
    return queryResponse;
  }
  /**
   * Query bill cycles from GTV db to the specified parameters
   * @return SoapApi33Domain.QueryResponse
   */
  public static SoapApi33Domain.QueryResponse getBillCycles() {
    SoapApi33Domain.QueryResponse billCyclesQueryResponse;
    SoapApi33Domain.QueryResponse billCyclesQueryResponseInLoop;
    TRACT_Setup__c tractConfig = getTractSetup();
    if (!Test.isRunningTest()) {
      billCyclesQueryResponse = queryTractByParamAndValue(
        tractConfig,
        'BillCycle',
        'status',
        'ACTIVE',
        null,
        null,
        null
      );
    } else {
      billCyclesQueryResponse = SoapApi33TestUtil.getBillCycles();
    }
    if (
      billCyclesQueryResponse.successful &&
      billCyclesQueryResponse.billCycles.totalPages > 1
    ) {
      Integer totalpage = billCyclesQueryResponse.billCycles.totalPages;
      if (null == billCyclesQueryResponse.billCycles.dailyBillCycle) {
        billCyclesQueryResponse.billCycles.dailyBillCycle = new List<SoapApi33Domain.DailyBillCycle>();
      }
      if (null == billCyclesQueryResponse.billCycles.monthlyBillCycle) {
        billCyclesQueryResponse.billCycles.monthlyBillCycle = new List<SoapApi33Domain.MonthlyBillCycle>();
      }
      if (null == billCyclesQueryResponse.billCycles.quarterlyBillCycle) {
        billCyclesQueryResponse.billCycles.quarterlyBillCycle = new List<SoapApi33Domain.QuarterlyBillCycle>();
      }
      if (
        null == billCyclesQueryResponse.billCycles.segmentedMonthlyBillCycle
      ) {
        billCyclesQueryResponse.billCycles.segmentedMonthlyBillCycle = new List<SoapApi33Domain.SegmentedMonthlyBillCycle>();
      }
      if (null == billCyclesQueryResponse.billCycles.yearlyBillCycle) {
        billCyclesQueryResponse.billCycles.yearlyBillCycle = new List<SoapApi33Domain.YearlyBillCycle>();
      }
      for (Integer i = 2; i <= totalpage; i++) {
        if (!Test.isRunningTest()) {
          billCyclesQueryResponseInLoop = queryTractByParamAndValue(
            tractConfig,
            'BillCycle',
            'status',
            'ACTIVE',
            i,
            50,
            null
          );
        } else {
          billCyclesQueryResponseInLoop = SoapApi33TestUtil.getBillCycles();
        }
        if (billCyclesQueryResponseInLoop.successful) {
          if (null != billCyclesQueryResponseInLoop.billCycles.dailyBillCycle) {
            billCyclesQueryResponse.billCycles.dailyBillCycle.addAll(
              billCyclesQueryResponseInLoop.billCycles.dailyBillCycle
            );
          }
          if (
            null != billCyclesQueryResponseInLoop.billCycles.monthlyBillCycle
          ) {
            billCyclesQueryResponse.billCycles.monthlyBillCycle.addAll(
              billCyclesQueryResponseInLoop.billCycles.monthlyBillCycle
            );
          }
          if (
            null != billCyclesQueryResponseInLoop.billCycles.quarterlyBillCycle
          ) {
            billCyclesQueryResponse.billCycles.quarterlyBillCycle.addAll(
              billCyclesQueryResponseInLoop.billCycles.quarterlyBillCycle
            );
          }
          if (
            null !=
            billCyclesQueryResponseInLoop.billCycles.segmentedMonthlyBillCycle
          ) {
            billCyclesQueryResponse.billCycles.segmentedMonthlyBillCycle.addAll(
              billCyclesQueryResponseInLoop.billCycles.segmentedMonthlyBillCycle
            );
          }
          if (
            null != billCyclesQueryResponseInLoop.billCycles.yearlyBillCycle
          ) {
            billCyclesQueryResponse.billCycles.yearlyBillCycle.addAll(
              billCyclesQueryResponseInLoop.billCycles.yearlyBillCycle
            );
          }
        }
      }
    }
    return billCyclesQueryResponse;
  }
  /**
   * Query Billing Account Categories setting from GTV db to the specified parameters
   * @return SoapApi33Domain.QueryResponse
   */
  public static SoapApi33Domain.QueryResponse getBillingAccountCategories() {
    SoapApi33Domain.QueryResponse billingAccountCategoriesQueryResponse;
    SoapApi33Domain.QueryResponse billingAccountCategoriesqueryResponseInLoop;
    TRACT_Setup__c tractConfig = getTractSetup();
    if (!Test.isRunningTest()) {
      billingAccountCategoriesQueryResponse = queryTractByParamAndValue(
        tractConfig,
        'BillingAccountCategory',
        'status',
        'BA_CATEGORY_ACTIVE',
        null,
        null,
        null
      );
    } else {
      billingAccountCategoriesQueryResponse = SoapApi33TestUtil.getBillingAccountCategories();
    }
    if (
      billingAccountCategoriesQueryResponse.successful &&
      null !=
      billingAccountCategoriesQueryResponse.billingAccountCategories.billingAccountCategory
    ) {
      Integer totalPages = billingAccountCategoriesQueryResponse.billingAccountCategories.totalPages;
      if (totalPages > 1) {
        for (Integer i = 2; i <= totalPages; i++) {
          billingAccountCategoriesqueryResponseInLoop = queryTractByParamAndValue(
            tractConfig,
            'BillingAccountCategory',
            'status',
            'BA_CATEGORY_ACTIVE',
            i,
            50,
            null
          );
          if (
            billingAccountCategoriesqueryResponseInLoop.successful &&
            null !=
            billingAccountCategoriesqueryResponseInLoop.billingAccountCategories.billingAccountCategory
          ) {
            billingAccountCategoriesQueryResponse.billingAccountCategories.billingAccountCategory.addAll(
              billingAccountCategoriesqueryResponseInLoop.billingAccountCategories.billingAccountCategory
            );
          }
        }
      }
    }
    return billingAccountCategoriesQueryResponse;
  }
  /**
   * Query Payment Terms setting from GTV db to the specified parameters
   * @return SoapApi33Domain.QueryResponse
   */
  public static SoapApi33Domain.QueryResponse getPaymentTerms() {
    SoapApi33Domain.QueryResponse paymentTermsQueryResponse;
    TRACT_Setup__c tractConfig = getTractSetup();
    if (!Test.isRunningTest()) {
      paymentTermsQueryResponse = queryTractByParamAndValue(
        tractConfig,
        'PaymentTerm',
        null,
        null,
        null,
        null,
        null
      );
    } else {
      paymentTermsQueryResponse = SoapApi33TestUtil.getPaymentTerms();
    }
    return paymentTermsQueryResponse;
  }
  /**
   * Query services for specific account from GTV db to the specified parameters
   * @param thisAccount salesforce account
   * @return SoapApi33Domain.QueryResponse
   */
  public static SoapApi33Domain.QueryResponse getBillingAccountServices(
    Account thisAccount
  ) {
    SoapApi33Domain.QueryResponse servicesQueryResponse;
    TRACT_Setup__c tractConfig = getTractSetup();
    if (!Test.isRunningTest()) {
      servicesQueryResponse = queryTractByParamAndValue(
        tractConfig,
        'Service',
        'accountNum',
        thisAccount.Tract_Billing_Account__c,
        1,
        50,
        'DEEP'
      );
    } else {
      servicesQueryResponse = SoapApi33TestUtil.getServices();
    }
    return servicesQueryResponse;
  }
  /**
   * Query product reated to price list from GTV db to the specified parameters
   * @param priceListEid tract price list id
   * @return SoapApi33Domain.Product[]
   */
  public static SoapApi33Domain.Product[] getProducts(String priceListEid) {
    SoapApi33Domain.QueryResponse productQueryResponse = new SoapApi33Domain.QueryResponse();
    SoapApi33Domain.QueryResponse productQueryResponse1 = new SoapApi33Domain.QueryResponse();
    integer pagenumber = 1;
    integer totelpage = 0;
    SoapApi33Domain.Product[] products = new List<SoapApi33Domain.Product>();
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Domain.ParameterAndValue[] params = new List<SoapApi33Domain.ParameterAndValue>{};
    SoapApi33Domain.ParameterAndValue param1 = new SoapApi33Domain.ParameterAndValue();
    param1.parameter = 'priceListEid';
    param1.parameterValue = priceListEid;
    param1.operator = 'EQ';
    SoapApi33Domain.ParameterAndValue param2 = new SoapApi33Domain.ParameterAndValue();
    param2.parameter = 'productState';
    param2.parameterValue = 'PRODUCT_AVAILABLE';
    param2.operator = 'EQ';
    SoapApi33Domain.ParameterAndValue param3 = new SoapApi33Domain.ParameterAndValue();
    param3.parameter = 'productTypeCode';
    param3.parameterValue = 'PACKAGE';
    param3.operator = 'NEQ';
    params.add(param1);
    params.add(param2);
    params.add(param3);
    if (!Test.isRunningTest()) {
      productQueryResponse = queryTract(
        tractConfig,
        'Product',
        params,
        pagenumber,
        50,
        'DEEP'
      );
    } else {
      productQueryResponse = SoapApi33TestUtil.getProducts();
    }
    totelpage = productQueryResponse.products.totalPages;
    if (
      productQueryResponse.successful &&
      null != productQueryResponse.products.product
    ) {
      products = productQueryResponse.products.product;
      for (Integer i = 2; i <= totelpage; i++) {
        if (!Test.isRunningTest()) {
          productQueryResponse1 = queryTract(
            tractConfig,
            'Product',
            params,
            i,
            50,
            'DEEP'
          );
        } else {
          productQueryResponse1 = SoapApi33TestUtil.getProducts();
        }
        if (
          productQueryResponse1.successful &&
          null != productQueryResponse1.products.product
        )
          products.addall(productQueryResponse1.products.product);
      }
    }
    return products;
  }
  /**
   * Query Agreements for specific product from GTV db to the specified parameters
   * @param productEid tract product id
   * @return SoapApi33Domain.QueryResponse
   */
  public static SoapApi33Domain.QueryResponse getAgreements(String productEid) {
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Domain.QueryResponse queryResponse;
    if (!Test.isRunningTest()) {
      queryResponse = queryTractByParamAndValue(
        tractConfig,
        'Agreement',
        'productEid',
        productEid,
        null,
        null,
        null
      );
    } else {
      queryResponse = SoapApi33TestUtil.getProductAgreements();
    }
    return queryResponse;
  }
  /**
   * Query Agreements from GTV db to the specified parameters
   * @return SoapApi33Domain.QueryResponse
   */
  public static SoapApi33Domain.QueryResponse queryAgreements() {
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Domain.QueryResponse queryResponse;
    if (!Test.isRunningTest()) {
      queryResponse = queryTractByParamAndValue(
        tractConfig,
        'Agreement',
        'status',
        'ACTIVE',
        null,
        null,
        null
      );
    } else {
      queryResponse = SoapApi33TestUtil.getProductAgreements();
    }
    return queryResponse;
  }
  /* Querying custom fields from GTV */
  /**
   * Query custom fields from GTV db to the specified parameters
   * @param customFieldType tract custon field type
   * @return SoapApi33Domain.QueryResponse
   */
  public static SoapApi33Domain.QueryResponse getCustomFieldList(
    String customFieldType
  ) {
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Domain.QueryResponse customFieldQueryResponse;
    if (!Test.isRunningTest()) {
      customFieldQueryResponse = queryTractByParamAndValue(
        tractConfig,
        'CustomField',
        'type',
        customFieldType,
        null,
        null,
        'DEEP'
      );
    } else {
      customFieldQueryResponse = SoapApi33TestUtil.getCustomFields();
    }
    return customFieldQueryResponse;
  }
  /* Querying custom fields from GTV */
  /**
   * Query Order custom fields from GTV db to the specified parameters
   * @param customFieldType tract custon field type
   * @return SoapApi33Domain.QueryResponse
   */
  public static SoapApi33Domain.QueryResponse getOrderCustomFieldList(
    String customFieldType
  ) {
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Domain.QueryResponse customFieldQueryResponse;
    SoapApi33Domain.ParameterAndValue[] params = new List<SoapApi33Domain.ParameterAndValue>{};
    SoapApi33Domain.ParameterAndValue param1 = new SoapApi33Domain.ParameterAndValue();
    param1.parameter = 'type';
    param1.parameterValue = customFieldType;
    param1.operator = 'EQ';
    SoapApi33Domain.ParameterAndValue param2 = new SoapApi33Domain.ParameterAndValue();
    param2.parameter = 'enabled';
    param2.parameterValue = 'true';
    param2.operator = 'EQ';
    SoapApi33Domain.ParameterAndValue param3 = new SoapApi33Domain.ParameterAndValue();
    param3.parameter = 'searchable';
    param3.parameterValue = 'true';
    param3.operator = 'EQ';
    params.add(param1);
    params.add(param2);
    params.add(param3);
    if (!Test.isRunningTest()) {
      customFieldQueryResponse = queryTract(
        tractConfig,
        'CustomField',
        params,
        null,
        50,
        'DEEP'
      );
    } else {
      customFieldQueryResponse = SoapApi33TestUtil.getCustomFields();
    }
    return customFieldQueryResponse;
  }
  /**
   * Query Account custom fields from GTV db to the specified parameters
   * @param customFieldType tract custon field type
   * @return SoapApi33Domain.QueryResponse
   */
  public static SoapApi33Domain.QueryResponse getAccountCustomFieldList(
    String customFieldType
  ) {
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Domain.QueryResponse queryResponse;
    SoapApi33Domain.QueryResponse queryResponseInLoop;
    if (!Test.isRunningTest()) {
      queryResponse = queryTractByParamAndValue(
        tractConfig,
        'CustomField',
        'type',
        customFieldType,
        1,
        50,
        'DEEP'
      );
    } else {
      queryResponse = SoapApi33TestUtil.getCustomFields();
    }
    if (queryResponse.successful) {
      if (queryResponse.customFields.totalPages > 1) {
        Integer totalpage = queryResponse.customFields.totalPages;
        for (Integer i = 2; i <= totalpage; i++) {
          queryResponseInLoop = queryTractByParamAndValue(
            tractConfig,
            'CustomField',
            'type',
            customFieldType,
            i,
            50,
            'DEEP'
          );
          if (queryResponseInLoop.successful) {
            queryResponse.customFields.customField.addAll(
              queryResponseInLoop.customFields.customField
            );
          }
        }
      }
    }
    return queryResponse;
  }
  /* Querying custom fields Value from GTV */
  /**
   * Query custom fields values from GTV db to the specified parameters
   * @param billingAccountNumber tract billing account number
   * @return SoapApi33Domain.QueryResponse
   */
  public static SoapApi33Domain.QueryResponse getCustomFieldValueList(
    String billingAccountNumber
  ) {
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Domain.QueryResponse queryResponse;
    if (!Test.isRunningTest()) {
      queryResponse = queryTractByParamAndValue(
        tractConfig,
        'CustomFieldValue',
        'accountNum',
        billingAccountNumber,
        1,
        50,
        'DEEP'
      );
    } else {
      queryResponse = SoapApi33TestUtil.getcustomFieldValues();
    }
    return queryResponse;
  }
  /**
   * deactivate current service In GTV
   * @param deactivateCurrentService SoapApi33Domain.CommandRequest
   * @return SoapApi33Domain.CommandResponse
   */
  public static SoapApi33Domain.CommandResponse getCommandresponse(
    SoapApi33Domain.CommandRequest deactivateCurrentService
  ) {
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Service.TractPort tractBilling = getTractServicePort(tractConfig);
    SoapApi33Domain.CommandResponse commandResDeactivate;
    if (!Test.isRunningTest()) {
      commandResDeactivate = tractBilling.command(deactivateCurrentService);
    } else {
      commandResDeactivate = SoapApi33TestUtil.getCommandresponse();
    }
    return commandResDeactivate;
  }
  /**
   * create Activity Charge Rule In GTV
   * @param newChargeRule SoapApi33Domain.CommandRequest
   * @return SoapApi33Domain.CommandResponse
   */
  public static SoapApi33Domain.CommandResponse createActivityChargeRule(
    SoapApi33Domain.CommandRequest newChargeRule
  ) {
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Service.TractPort tractBilling = getTractServicePort(tractConfig);
    SoapApi33Domain.CommandResponse commandResChargeRule;
    if (!Test.isRunningTest())
      commandResChargeRule = tractBilling.command(newChargeRule);
    else {
      commandResChargeRule = new SoapApi33Domain.CommandResponse();
      commandResChargeRule.successful = true;
    }
    return commandResChargeRule;
  }
  /**
   * renewal Order In GTV
   * @param renewalOrder SoapApi33Domain.CommandRequest
   * @return SoapApi33Domain.CommandResponse
   */
  public static SoapApi33Domain.CommandResponse popUpServices(
    SoapApi33Domain.CommandRequest renewalOrder
  ) {
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Service.TractPort tractBilling = getTractServicePort(tractConfig);
    SoapApi33Domain.CommandResponse renewalOrderResponse;
    if (!Test.isRunningTest())
      renewalOrderResponse = tractBilling.command(renewalOrder);
    else {
      renewalOrderResponse = new SoapApi33Domain.CommandResponse();
      renewalOrderResponse.successful = true;
    }
    return renewalOrderResponse;
  }
  /**
   * update Quantity of product In GTV
   * @param updateQuantityReq SoapApi33Domain.CommandRequest
   * @return SoapApi33Domain.CommandResponse
   */
  public static SoapApi33Domain.CommandResponse updateQuantity(
    SoapApi33Domain.CommandRequest updateQuantityReq
  ) {
    SoapApi33Domain.CommandResponse updateQuantityRes;
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Service.TractPort tractBilling = getTractServicePort(tractConfig);
    if (!Test.isRunningTest()) {
      updateQuantityRes = tractBilling.command(updateQuantityReq);
    } else {
      updateQuantityRes = SoapApi33TestUtil.getCommandresponse();
    }
    return updateQuantityRes;
  }
  /**
   * create Adjustment In GTV
   * @param createReq SoapApi33Domain.CreateRequest
   * @return SoapApi33Domain.CreateResponse
   */
  public static SoapApi33Domain.CreateResponse createAdjustmentResponse(
    SoapApi33Domain.CreateRequest createReq
  ) {
    SoapApi33Domain.CreateResponse creteRes;
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Service.TractPort tractBilling = getTractServicePort(tractConfig);
    if (!Test.isRunningTest()) {
      creteRes = tractBilling.create(createReq);
    } else {
      creteRes = SoapApi33TestUtil.gettractBilling();
    }
    return creteRes;
  }
  /**
   * save Adjustments In GTV
   * @param postCreditAdjustment SoapApi33Domain.CommandRequest
   * @return SoapApi33Domain.CommandResponse
   */
  public static SoapApi33Domain.CommandResponse saveAdjustments(
    SoapApi33Domain.CommandRequest postCreditAdjustment
  ) {
    SoapApi33Domain.CommandResponse adjustmentRes;
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Service.TractPort tractBilling = getTractServicePort(tractConfig);
    if (!Test.isRunningTest()) {
      adjustmentRes = tractBilling.command(postCreditAdjustment);
    } else {
      adjustmentRes = SoapApi33TestUtil.getCommandresponse();
    }
    return adjustmentRes;
  }
  /**
   * resume Account In GTV
   * @param resumeAccount SoapApi33Domain.CommandRequest
   */
  public static void resumeAccount(
    SoapApi33Domain.CommandRequest resumeAccount
  ) {
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Service.TractPort tractBilling = getTractServicePort(tractConfig);
    if (!Test.isRunningTest()) {
      tractBilling.command(resumeAccount);
    } else {
      SoapApi33TestUtil.getCommandresponse();
    }
  }
  /**
   * Query Currency Type from GTV db to the specified parameters
   * @return SoapApi33Domain.QueryResponse
   */
  public static SoapApi33Domain.QueryResponse getCurrencyType() {
    SoapApi33Domain.QueryResponse currencyTypeQueryResponse;
    TRACT_Setup__c tractConfig = getTractSetup();
    if (!Test.isRunningTest()) {
      currencyTypeQueryResponse = queryTractByParamAndValue(
        tractConfig,
        'Currency',
        null,
        null,
        null,
        null,
        'DEEP'
      );
    } else {
      //currencyTypeQueryResponse = SoapApi30TestUtil.getPaymentTerms();
    }
    return currencyTypeQueryResponse;
  }
  /**
   * suspend Account In GTV
   * @param suspendAccount SoapApi33Domain.CommandRequest
   */
  public static void suspendAccount(
    SoapApi33Domain.CommandRequest suspendAccount
  ) {
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Service.TractPort tractBilling = getTractServicePort(tractConfig);
    if (!Test.isRunningTest()) {
      tractBilling.command(suspendAccount);
    } else {
      SoapApi33TestUtil.getCommandresponse();
    }
  }
  /**
   * deactivate Account In GTV
   * @param suspendAccount SoapApi33Domain.CommandRequest
   */
  public static void deactivateAccount(
    SoapApi33Domain.CommandRequest deactivateAccount
  ) {
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Service.TractPort tractBilling = getTractServicePort(tractConfig);
    if (!Test.isRunningTest()) {
      tractBilling.command(deactivateAccount);
    } else {
      SoapApi33TestUtil.getCommandresponse();
    }
  }
  /**
   * request to resume service In GTV
   * @param resumeServiceReq SoapApi33Domain.CommandRequest
   * @return SoapApi33Domain.CommandResponse
   */
  public static SoapApi33Domain.CommandResponse resumeService(
    SoapApi33Domain.CommandRequest resumeServiceReq
  ) {
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Domain.CommandResponse resumeServiceRes;
    SoapApi33Service.TractPort tractBilling = getTractServicePort(tractConfig);
    if (!Test.isRunningTest()) {
      resumeServiceRes = tractBilling.command(resumeServiceReq);
    } else {
      resumeServiceRes = SoapApi33TestUtil.getCommandresponse();
    }
    return resumeServiceRes;
  }
  /**
   * request to create draft order In GTV
   * @param createDraftOrderCmd SoapApi33Domain.CommandRequest
   * @return SoapApi33Domain.CommandResponse
   */
  public static SoapApi33Domain.CommandResponse createDraftOrder(
    SoapApi33Domain.CommandRequest createDraftOrderCmd
  ) {
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Domain.CommandResponse commandRes;
    SoapApi33Service.TractPort tractBilling = getTractServicePort(tractConfig);
    if (!Test.isRunningTest()) {
      commandRes = tractBilling.command(createDraftOrderCmd);
    } else {
      commandRes = SoapApi33TestUtil.getCommandresponse();
    }
    return commandRes;
  }
  /**
   * request to convert service In GTV
   * @param convertServiceReq SoapApi33Domain.CommandRequest
   * @return SoapApi33Domain.CommandResponse
   */
  public static SoapApi33Domain.CommandResponse convertService(
    SoapApi33Domain.CommandRequest convertServiceReq
  ) {
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Domain.CommandResponse commandRes;
    SoapApi33Service.TractPort tractBilling = getTractServicePort(tractConfig);
    if (!Test.isRunningTest()) {
      commandRes = tractBilling.command(convertServiceReq);
    } else {
      commandRes = SoapApi33TestUtil.getCommandresponse();
    }
    return commandRes;
  }
  /**
   * request to create sales order In GTV
   * @param createSalesOrderCmd SoapApi33Domain.CreateRequest
   * @return SoapApi33Domain.CreateResponse
   */
  public static SoapApi33Domain.CreateResponse createSalesOrder(
    SoapApi33Domain.CreateRequest createSalesOrderCmd
  ) {
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Domain.CreateResponse createRes;
    SoapApi33Service.TractPort tractBilling = getTractServicePort(tractConfig);
    if (!Test.isRunningTest()) {
      createRes = tractBilling.create(createSalesOrderCmd);
    } else {
      createRes = SoapApi33TestUtil.getCreateresponce();
    }
    return createRes;
  }
  /**
   * request to update Quantity and Add Product In GTV
   * @param updateQuantityReq SoapApi33Domain.CommandRequest
   * @return SoapApi33Domain.CommandResponse
   */
  public static SoapApi33Domain.CommandResponse updateQuantityAddProduct(
    SoapApi33Domain.CommandRequest updateQuantityReq
  ) {
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Domain.CommandResponse updateQuantityRes;
    SoapApi33Service.TractPort tractBilling = getTractServicePort(tractConfig);
    if (!Test.isRunningTest()) {
      updateQuantityRes = tractBilling.command(updateQuantityReq);
    } else {
      updateQuantityRes = SoapApi33TestUtil.getCommandresponse();
    }
    return updateQuantityRes;
  }
  /**
   * request to suspend Service In GTV
   * @param suspendServiceReq SoapApi33Domain.CommandRequest
   * @return SoapApi33Domain.CommandResponse
   */
  public static SoapApi33Domain.CommandResponse suspendService(
    SoapApi33Domain.CommandRequest suspendServiceReq
  ) {
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Domain.CommandResponse suspendServiceRes;
    SoapApi33Service.TractPort tractBilling = getTractServicePort(tractConfig);
    if (!Test.isRunningTest()) {
      suspendServiceRes = tractBilling.command(suspendServiceReq);
    } else {
      suspendServiceRes = SoapApi33TestUtil.getCommandresponse();
    }
    return suspendServiceRes;
  }
  /**
   * request to change Service In GTV
   * @param changeCurrentService SoapApi33Domain.CommandRequest
   * @return SoapApi33Domain.CommandResponse
   */
  public static SoapApi33Domain.CommandResponse saveChangeService(
    SoapApi33Domain.CommandRequest changeCurrentService
  ) {
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Domain.CommandResponse changeCurrentServiceRes;
    SoapApi33Service.TractPort tractBilling = getTractServicePort(tractConfig);
    if (!Test.isRunningTest()) {
      changeCurrentServiceRes = tractBilling.command(changeCurrentService);
    } else {
      changeCurrentServiceRes = SoapApi33TestUtil.getCommandresponse();
    }
    return changeCurrentServiceRes;
  }
  /**
   * request to remove usage rules In GTV
   * @param removeServiceUsageRule SoapApi33Domain.CommandRequest
   * @return SoapApi33Domain.CommandResponse
   */
  public static SoapApi33Domain.CommandResponse removeUsageRule(
    SoapApi33Domain.CommandRequest removeServiceUsageRule
  ) {
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Domain.CommandResponse commandResUsageRule;
    SoapApi33Service.TractPort tractBilling = getTractServicePort(tractConfig);
    if (!Test.isRunningTest())
      commandResUsageRule = tractBilling.command(removeServiceUsageRule);
    else {
      commandResUsageRule = new SoapApi33Domain.CommandResponse();
      commandResUsageRule.successful = true;
    }
    return commandResUsageRule;
  }
  /**
   * request to apply service resource In GTV
   * @param addServiceResourceToServiceCommand SoapApi33Domain.CommandRequest
   * @return SoapApi33Domain.CommandResponse
   */
  public static void applyServiceResource(
    SoapApi33Domain.CommandRequest addServiceResourceToServiceCommand
  ) {
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Service.TractPort tractBilling = getTractServicePort(tractConfig);
    if (!Test.isRunningTest()) {
      tractBilling.command(addServiceResourceToServiceCommand);
    } else {
      SoapApi33TestUtil.getCommandresponse();
    }
  }
  /**
   * request to apply change Service Resource In GTV
   * @param changeServiceResourceCommand SoapApi33Domain.CommandRequest
   * @return SoapApi33Domain.CommandResponse
   */
  public static void applyChangeServiceResource(
    SoapApi33Domain.CommandRequest changeServiceResourceCommand
  ) {
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Service.TractPort tractBilling = getTractServicePort(tractConfig);
    if (!Test.isRunningTest()) {
      tractBilling.command(changeServiceResourceCommand);
    } else {
      SoapApi33TestUtil.getCommandresponse();
    }
  }
  /**
   * request to save address In GTV
   * @param addAddressToServiceReq SoapApi33Domain.CommandRequest
   * @return SoapApi33Domain.CommandResponse
   */
  public static SoapApi33Domain.CommandResponse saveAddress(
    SoapApi33Domain.CommandRequest addAddressToServiceReq
  ) {
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Domain.CommandResponse addAddressToServiceRes;
    SoapApi33Service.TractPort tractBilling = getTractServicePort(tractConfig);
    if (!Test.isRunningTest())
      addAddressToServiceRes = tractBilling.command(addAddressToServiceReq);
    else {
      addAddressToServiceRes = SoapApi33TestUtil.getCommandresponse();
    }
    return addAddressToServiceRes;
  }
  /**
   * request to create service In GTV
   * @param serviceCommandRequest SoapApi33Domain.CommandRequest
   * @return SoapApi33Domain.CommandResponse
   */
  public static SoapApi33Domain.CommandResponse createService(
    SoapApi33Domain.CommandRequest serviceCommandRequest
  ) {
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Domain.CommandResponse createServiceCommand;
    SoapApi33Service.TractPort tractBilling = getTractServicePort(tractConfig);
    if (!Test.isRunningTest())
      createServiceCommand = tractBilling.command(serviceCommandRequest);
    else {
      createServiceCommand = SoapApi33TestUtil.getCommandresponse();
    }
    return createServiceCommand;
  }
  /**
   * request to remove agreement In GTV
   * @param agreementCommandRequest SoapApi33Domain.CommandRequest
   * @return SoapApi33Domain.CommandResponse
   */
  public static SoapApi33Domain.CommandResponse removeAgreements(
    SoapApi33Domain.CommandRequest agreementCommandRequest
  ) {
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Domain.CommandResponse createAgreementCommand;
    SoapApi33Service.TractPort tractBilling = getTractServicePort(tractConfig);
    if (!Test.isRunningTest())
      createAgreementCommand = tractBilling.command(agreementCommandRequest);
    else {
      createAgreementCommand = SoapApi33TestUtil.getCommandresponse();
    }
    return createAgreementCommand;
  }
  /**
   * request to save account custom field In GTV
   * @param commandRequestList List<SoapApi33Domain.CommandRequest>
   * @return error message if any!
   */
  public static String saveAccountCustomField(
    List<SoapApi33Domain.CommandRequest> commandRequestList
  ) {
    String emessage = 'No error';
    SoapApi33Domain.BatchResponse commandResAddBillingCustom;
    SoapApi33Domain.CommandBatchRequest batchRequest = new SoapApi33Domain.CommandBatchRequest();
    batchRequest.requests = new SoapApi33Domain.commandRequests_element();
    batchRequest.requests.command = commandRequestList;
    batchRequest.stopOnError = true;
    batchRequest.transactional = true;
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Service.TractPort tractBilling = getTractServicePort(tractConfig);
    if (!Test.isRunningTest()) {
      commandResAddBillingCustom = tractBilling.Batchcommand(batchRequest);
    } else {
      commandResAddBillingCustom = SoapApi33TestUtil.saveAccountCustomField();
    }

    if (commandResAddBillingCustom.errorOccurred) {
      if (
        commandResAddBillingCustom.errors != null &&
        commandResAddBillingCustom.errors.error.size() > 0
      ) {
        for (
          SoapApi33Service.FaultResponse fault : commandResAddBillingCustom.errors.error
        ) {
          if (emessage == 'No Error') {
            String error = fault.message.substringAfter('Validation ');
            emessage = error;
          } else {
            emessage += ',' + fault.message.substringAfter('Validation ');
          }
        }
      }
    }
    return emessage;
  }
  /**
   * create request to create billing account In GTV
   * @param accountId salesforce account id
   * @param tractBillingString billing account details in json format
   */
  public static void createRequestForBillingAccount(
    String accountId,
    String tractBillingString
  ) {
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Domain.CreateResponse creteRes;
    SoapApi33Domain.BillingAccount tractBillingAccountObj = (SoapApi33Domain.BillingAccount) JSON.deserialize(
      tractBillingString,
      SoapApi33Domain.BillingAccount.class
    );
    SoapApi33Domain.CreateRequest createReq = new SoapApi33Domain.CreateRequest();
    SoapApi33Domain.QueryResponse queryResponse;
    SoapApi33Service.TractPort tractBilling;
    String accountNum;

    tractBilling = getTractServicePort(tractConfig);
    createReq.billingAccount = tractBillingAccountObj;

    if (!Test.isRunningTest()) {
      try {
        creteRes = tractBilling.create(createReq);
      } catch (CalloutException e) {
        throw new MyException(' ' + e);
      }
    } else {
      creteRes = SoapApi33TestUtil.getCreateresponce();
    }
    if (creteRes.successful) {
      String billingAccountEid = zConvert.toString(creteRes.eid)
        .replace(',', '');
      if (!Test.isRunningTest())
        queryResponse = queryTractByParamAndValue(
          tractConfig,
          'BillingAccount',
          'eid',
          billingAccountEid,
          null,
          null,
          null
        );
      else
        queryResponse = SoapApi33TestUtil.getBillingAccounts();
      if (
        queryResponse.successful &&
        null != queryResponse.billingAccounts &&
        null != queryResponse.billingAccounts.billingAccount &&
        !queryResponse.billingAccounts.billingAccount.isEmpty()
      ) {
        accountNum = queryResponse.billingAccounts.billingAccount[0].accountNum;
      } else {
        throw new MyException(
          'Billing Account created successfully but unable to find out the Billing Account on TRACT.'
        );
      }
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
      if (thisAccount != null) {
        if (string.isNotBlank(tractBillingAccountObj.currencyType)) {
          thisAccount.Currency_Type__c = tractBillingAccountObj.currencyType;
        } else {
          thisAccount.Currency_Type__c = 'USD';
        }
        thisAccount.Tract_Billing_Account__c = accountNum;
        thisAccount.status__c = 'Moved';
        thisAccount.Error_Message__c = '';
        if (
          TRACTAPIUtil.checkFieldLevelSecurity(
            'Account',
            'status__c,Error_Message__c,Tract_Billing_Account__c,Currency_Type__c',
            'Update'
          )
        ) {
          update thisAccount;
        }
      } else {
        thisAccount = new Account();
        thisAccount.Name = tractBillingAccountObj.organization.name;
        if (string.isNotBlank(tractBillingAccountObj.currencyType)) {
          thisAccount.Currency_Type__c = tractBillingAccountObj.currencyType;
        } else {
          thisAccount.Currency_Type__c = 'USD';
        }
        thisAccount.Tract_Billing_Account__c = accountNum;
        thisAccount.status__c = 'Moved';
        thisAccount.Error_Message__c = '';
        if (
          TRACTAPIUtil.checkFieldLevelSecurity(
            'Account',
            'name,status__c,Error_Message__c,Tract_Billing_Account__c,Currency_Type__c',
            'Create'
          )
        ) {
          insert thisAccount;
        }
      }
    } else {
      throw new MyException(
        'Unable to create Organization Billing Account in Tract'
      );
    }
  }
  /**
   * create a future callout request to create billing account In GTV
   * @param accountId salesforce account id
   * @param tractBillingString billing account details in json format
   */
  @future(callout=true)
  public static void makeFutureCalloutForAccountCreation(
    Id accountId,
    String billingAccountString
  ) {
    try {
      createRequestForBillingAccount(accountId, billingAccountString);
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
      Account accountObj = [
        SELECT id, name, Error_Message__c, Status__c
        FROM Account
        WHERE id = :AccountId
      ];
      accountObj.Error_Message__c = errorMessage;
      accountObj.Status__c = 'Error Occurred';
      if (
        TRACTAPIUtil.checkFieldLevelSecurity(
          'Account',
          'status__c,Error_Message__c',
          'Update'
        )
      ) {
        update accountObj;
      }
    }
  }
  /**
   * create request to create billing account In GTV
   * @param accountId salesforce account id
   * @param billingAccountString billing account details in json format
   */
  public static CreateAccountResponse globalActionCalloutForAccountCreation(
    Id accountId,
    String billingAccountString
  ) {
    CreateAccountResponse accountRes = new CreateAccountResponse();
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Domain.CreateResponse creteRes;
    SoapApi33Domain.BillingAccount tractBillingAccountObj = (SoapApi33Domain.BillingAccount) JSON.deserialize(
      billingAccountString,
      SoapApi33Domain.BillingAccount.class
    );
    SoapApi33Domain.CreateRequest createReq = new SoapApi33Domain.CreateRequest();
    SoapApi33Domain.QueryResponse queryResponse;
    SoapApi33Service.TractPort tractBilling;
    String accountNum;

    tractBilling = getTractServicePort(tractConfig);
    createReq.billingAccount = tractBillingAccountObj;

    if (!Test.isRunningTest()) {
      try {
        creteRes = tractBilling.create(createReq);
      } catch (CalloutException e) {
        accountRes.salesforceAccountId = accountId;
        accountRes.responseSuccess = false;
        accountRes.responseMessage = e.getMessage();
      }
    } else {
      creteRes = SoapApi33TestUtil.getCreateresponce();
    }
    if (creteRes.successful) {
      String billingAccountEid = zConvert.toString(creteRes.eid)
        .replace(',', '');
      if (!Test.isRunningTest())
        queryResponse = queryTractByParamAndValue(
          tractConfig,
          'BillingAccount',
          'eid',
          billingAccountEid,
          null,
          null,
          null
        );
      else
        queryResponse = SoapApi33TestUtil.getBillingAccounts();
      if (
        queryResponse.successful &&
        null != queryResponse.billingAccounts &&
        null != queryResponse.billingAccounts.billingAccount &&
        !queryResponse.billingAccounts.billingAccount.isEmpty()
      ) {
        accountNum = queryResponse.billingAccounts.billingAccount[0].accountNum;
        accountRes.gtvAccountId = billingAccountEid;
        accountRes.gtvAccountNumber = accountNum;
        accountRes.salesforceAccountId = accountId;
        accountRes.responseSuccess = true;
      }
    } else {
      accountRes.salesforceAccountId = accountId;
      accountRes.responseSuccess = false;
      accountRes.responseMessage = 'Unable to create Organization Billing Account in Tract';
    }
    return accountRes;
  }
  /**
   * query order item list from GTV db
   * @param orderNumber tract order number
   * @return SoapApi33Domain.QueryResponse
   */
  public static SoapApi33Domain.QueryResponse getOrderItemsList(
    String orderNumber
  ) {
    SoapApi33Domain.QueryResponse orderItemsQueryResponse;
    TRACT_Setup__c tractConfig = getTractSetup();
    if (!Test.isRunningTest()) {
      orderItemsQueryResponse = queryTractByParamAndValue(
        tractConfig,
        'OrderItem',
        'orderNum',
        orderNumber,
        null,
        null,
        'DEEP'
      );
    } else {
      orderItemsQueryResponse = SoapApi33TestUtil.getorderItems();
    }
    return orderItemsQueryResponse;
  }
  /**
   * query Order Item By Service Eid from GTV db
   * @param currentProductEid tract product id
   * @return SoapApi33Domain.QueryResponse
   */
  public static SoapApi33Domain.QueryResponse getOrderItemByServiceEid(
    String currentProductEid
  ) {
    SoapApi33Domain.QueryResponse queryResponse;
    TRACT_Setup__c tractConfig = getTractSetup();
    if (!Test.isRunningTest()) {
      queryResponse = queryTractByParamAndValue(
        tractConfig,
        'OrderItem',
        'serviceEid',
        currentProductEid,
        null,
        null,
        'DEEP'
      );
    } else {
      queryResponse = SoapApi33TestUtil.getorderItems();
    }
    return queryResponse;
  }
  /**
   * query Order By Order Number from GTV db
   * @param orderNumber tract order number
   * @return SoapApi33Domain.QueryResponse
   */
  public static SoapApi33Domain.QueryResponse getOrderByOrderNumber(
    String orderNumber
  ) {
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Domain.QueryResponse orderQueryResponse;
    if (!Test.isRunningTest()) {
      orderQueryResponse = queryTractByParamAndValue(
        tractConfig,
        'Order',
        'orderNum',
        orderNumber,
        null,
        null,
        'SHALLOW'
      );
    } else {
      orderQueryResponse = SoapApi33TestUtil.getOrders();
    }
    return orderQueryResponse;
  }
  /**
   * query service Resources By Order Item Eid from GTV db
   * @param orderItemEid tract order item id
   * @return SoapApi33Domain.QueryResponse
   */
  public static SoapApi33Domain.QueryResponse getserviceResourcesByOrderItemEid(
    String orderItemEid
  ) {
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Domain.QueryResponse serviceResourcesQueryResponse;
    if (!Test.isRunningTest()) {
      serviceResourcesQueryResponse = queryTractByParamAndValue(
        tractConfig,
        'ServiceResource',
        'orderItemEid',
        orderItemEid,
        null,
        null,
        null
      );
    } else {
      serviceResourcesQueryResponse = SoapApi33TestUtil.getserviceResources();
    }
    return serviceResourcesQueryResponse;
  }
  /**
   * query service Resources By Service Eid from GTV db
   * @param parentServiceEid tract service id
   * @return SoapApi33Domain.QueryResponse
   */
  public static SoapApi33Domain.QueryResponse getserviceResourcesByServiceEid(
    String parentServiceEid
  ) {
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Domain.QueryResponse queryResponse;
    if (!Test.isRunningTest()) {
      queryResponse = queryTractByParamAndValue(
        tractConfig,
        'ServiceResource',
        'serviceEid',
        parentServiceEid,
        1,
        50,
        null
      );
    } else {
      queryResponse = SoapApi33TestUtil.getserviceResources();
    }
    return queryResponse;
  }
  /**
   * query Services By OrderNumber And OrderItem Sequence from GTV db
   * @param orderNumber tract order order number
   * @param orderItemSequence order item sequence
   * @return SoapApi33Domain.QueryResponse
   */
  public static SoapApi33Domain.QueryResponse getServicesByOrderNumberAndOrderItemSequence(
    String orderNumber,
    String orderItemSequence
  ) {
    SoapApi33Domain.Service[] services;
    SoapApi33Domain.QueryResponse servicesQueryResponse;
    SoapApi33Domain.ParameterAndValue[] params = new List<SoapApi33Domain.ParameterAndValue>{};
    SoapApi33Domain.ParameterAndValue param1 = new SoapApi33Domain.ParameterAndValue();
    param1.parameter = 'originalOrderNum';
    param1.parameterValue = orderNumber;
    param1.operator = 'EQ';

    SoapApi33Domain.ParameterAndValue param2 = new SoapApi33Domain.ParameterAndValue();
    param2.parameter = 'originalOrderItemSequence';
    param2.parameterValue = orderItemSequence;
    param2.operator = 'EQ';

    params.add(param1);
    params.add(param2);
    if (!test.isRunningTest()) {
      servicesQueryResponse = queryTract(
        tractConfig,
        'Service',
        params,
        null,
        null,
        'DEEP'
      );
    } else {
      servicesQueryResponse = SoapApi33TestUtil.getServices();
    }
    return servicesQueryResponse;
  }
  /**
   * query Product Discount Code List from GTV db
   * @param productEid tract product id
   * @return SoapApi33Domain.QueryResponse
   */
  public static SoapApi33Domain.QueryResponse getProductDiscountCodeList(
    String productEid
  ) {
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Domain.QueryResponse productDiscountCodeQueryResponse;
    if (!Test.isRunningTest()) {
      productDiscountCodeQueryResponse = queryTractByParamAndValue(
        tractConfig,
        'DiscountCode',
        'productEid',
        productEid,
        1,
        50,
        'DEEP'
      );
    } else {
      productDiscountCodeQueryResponse = SoapApi33TestUtil.getDiscountCodes();
    }
    return productDiscountCodeQueryResponse;
  }
  /**
   * query product by Eid from GTV db
   * @param productEid tract product id
   * @return SoapApi33Domain.Product[]
   */
  public static SoapApi33Domain.Product[] queryProductbyEid(String productEid) {
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Domain.QueryResponse productQueryResponse;
    SoapApi33Domain.Product[] products = new List<SoapApi33Domain.Product>();
    if (!Test.isRunningTest()) {
      productQueryResponse = queryTractByParamAndValue(
        tractConfig,
        'Product',
        'eid',
        productEid,
        1,
        50,
        'DEEP'
      );
    } else {
      productQueryResponse = SoapApi33TestUtil.getProducts();
    }
    if (
      productQueryResponse.successful &&
      null != productQueryResponse.products.product
    ) {
      products.addall(productQueryResponse.products.product);
    }
    return products;
  }
  /**
   * query discounts from GTV db
   * @param discountName
   * @return SoapApi33Domain.QueryResponse
   */
  public static SoapApi33Domain.QueryResponse getDisounts(String discountName) {
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Domain.QueryResponse queryResponse;
    if (!Test.isRunningTest()) {
      queryResponse = queryTractByParamAndValue(
        tractConfig,
        'DiscountIdentifier',
        'identifier',
        discountName,
        1,
        50,
        'DEEP'
      );
    } else {
      queryResponse = SoapApi33TestUtil.getdiscountIdentifiers();
    }
    return queryResponse;
  }
  /**
   * query service Resources from GTV db
   * @param srId tract service resource id
   * @return SoapApi33Domain.QueryResponse
   */
  public static SoapApi33Domain.QueryResponse getServiceResource(String srId) {
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Domain.QueryResponse queryResponse;
    if (!Test.isRunningTest()) {
      queryResponse = queryTractByParamAndValue(
        tractConfig,
        'ServiceResource',
        'identifier',
        srId,
        1,
        50,
        'DEEP'
      );
    } else {
      queryResponse = SoapApi33TestUtil.getserviceResources();
    }
    return queryResponse;
  }
  /**
   * query service from GTV db
   * @param ServiceEid tract service id
   * @return SoapApi33Domain.QueryResponse
   */
  public static SoapApi33Domain.QueryResponse queryService(String serviceEid) {
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Domain.QueryResponse queryResponse;
    if (!Test.isRunningTest()) {
      queryResponse = queryTractByParamAndValue(
        tractConfig,
        'Service',
        'eid',
        ServiceEid,
        1,
        50,
        'DEEP'
      );
    } else {
      queryResponse = SoapApi33TestUtil.getServices();
    }
    return queryResponse;
  }
  /**
   * query global usage rules from GTV db
   * @return SoapApi33Domain.QueryResponse
   */
  public static SoapApi33Domain.QueryResponse getGlobalUsageRules() {
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Domain.QueryResponse queryResponse;
    if (!Test.isRunningTest()) {
      queryResponse = queryTractByParamAndValue(
        tractConfig,
        'GlobalUsageRule',
        null,
        null,
        1,
        50,
        'DEEP'
      );
    } else {
      queryResponse = SoapApi33TestUtil.geglobalUsageRules();
    }
    return queryResponse;
  }
  /**
   * query usage Price Categories from GTV db
   * @return SoapApi33Domain.QueryResponse
   */
  public static SoapApi33Domain.QueryResponse getusagePriceCategories() {
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Domain.QueryResponse queryResponse;
    if (!Test.isRunningTest()) {
      queryResponse = queryTractByParamAndValue(
        tractConfig,
        'UsagePriceCategory',
        null,
        null,
        1,
        50,
        'DEEP'
      );
    } else {
      queryResponse = SoapApi33TestUtil.getusagePriceCategories();
    }
    return queryResponse;
  }
  /**
   * query product relations from GTV db
   * @param productEid tract product id
   * @return SoapApi33Domain.QueryResponse
   */
  public static SoapApi33Domain.QueryResponse getProductRelations(
    String productEid
  ) {
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Domain.QueryResponse queryResponse;
    if (!Test.isRunningTest()) {
      queryResponse = queryTractByParamAndValue(
        tractConfig,
        'ProductRelation',
        'productEid',
        productEid,
        null,
        null,
        null
      );
    } else {
      queryResponse = SoapApi33TestUtil.getProductRelations();
    }
    return queryResponse;
  }
  /**
   * query All Service Resource from GTV db
   * @return SoapApi33Domain.QueryResponse
   */
  public static SoapApi33Domain.QueryResponse getAllServiceResource() {
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Domain.QueryResponse queryResponse;
    queryResponse = queryTractByParamAndValue(
      tractConfig,
      'ServiceResource',
      'status',
      'AVAILABLE',
      1,
      50,
      'DEEP'
    );
    return queryResponse;
  }
  /**
   * query Price Lists For Testing Connection from GTV db
   * @param tractConfig configuration setting
   */
  public static void queryPriceListsForTestingConnection(
    TRACT_Setup__c tractConfig
  ) {
    SoapApi33Domain.QueryResponse queryResponse;
    if (!Test.isRunningTest()) {
      queryResponse = queryTractByParamAndValue(
        tractConfig,
        'PriceList',
        null,
        null,
        null,
        null,
        'DEEP'
      );
    } else {
      queryResponse = SoapApi33TestUtil.getPaymentMethods();
    }
  }
  /**
   * query Discount Codes By Product from GTV db
   * @param productEid tract product id
   * @return SoapApi33Domain.QueryResponse
   */
  public static SoapApi33Domain.QueryResponse getDiscountCodesByProduct(
    String productEid
  ) {
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Domain.QueryResponse queryResponse;
    if (!Test.isRunningTest()) {
      queryResponse = queryTractByParamAndValue(
        tractConfig,
        'DiscountCode',
        'productEid',
        productEid,
        null,
        null,
        null
      );
    } else {
      queryResponse = SoapApi33TestUtil.getDiscountCodes();
    }
    return queryResponse;
  }
  /**
   * query raye tables from GTV db
   * @return SoapApi33Domain.QueryResponse
   */
  public static SoapApi33Domain.QueryResponse getRateTables() {
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Domain.QueryResponse queryResponse;
    if (!Test.isRunningTest()) {
      queryResponse = queryTractByParamAndValue(
        tractConfig,
        'RateTable',
        null,
        null,
        1,
        50,
        'DEEP'
      );
    } else {
      queryResponse = SoapApi33TestUtil.getrateTables();
    }
    return queryResponse;
  }
  /**
   * query Rate Table by Eid from GTV db
   * @param rateTableEid tract rate table id
   * @return SoapApi33Domain.QueryResponse
   */
  public static SoapApi33Domain.QueryResponse getRateTablebyEid(
    String rateTableEid
  ) {
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Domain.QueryResponse queryResponse;
    if (!Test.isRunningTest()) {
      queryResponse = queryTractByParamAndValue(
        tractConfig,
        'RateTable',
        'eid',
        rateTableEid,
        1,
        50,
        'DEEP'
      );
    } else {
      queryResponse = SoapApi33TestUtil.getrateTables();
    }
    return queryResponse;
  }
  /**
   * query reasons from GTV db
   * @return SoapApi33Domain.QueryResponse
   */
  public static SoapApi33Domain.QueryResponse getreasons() {
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Domain.QueryResponse queryResponse;
    if (!Test.isRunningTest()) {
      queryResponse = queryTractByParamAndValue(
        tractConfig,
        'Reason',
        null,
        null,
        1,
        50,
        'DEEP'
      );
    } else {
      queryResponse = SoapApi33TestUtil.getreasons();
    }
    return queryResponse;
  }

  /**
   * query adjustment Reasons from GTV db
   * @return SoapApi33Domain.QueryResponse
   */
  public static SoapApi33Domain.QueryResponse getadjustmentReasons() {
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Domain.QueryResponse queryResponse;
    if (!Test.isRunningTest()) {
      queryResponse = queryTractByParamAndValue(
        tractConfig,
        'AdjustmentReason',
        'status',
        'ACTIVE',
        1,
        50,
        'DEEP'
      );
    } else {
      queryResponse = SoapApi33TestUtil.getadjustmentReasons();
    }
    return queryResponse;
  }
  /**
   * query Service Custom Fields By Product from GTV db
   * @param productEid tract product id
   * @return SoapApi33Domain.QueryResponse
   */
  public static SoapApi33Domain.QueryResponse queryServiceCustomFieldsByProduct(
    String productEid
  ) {
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Domain.QueryResponse queryResponse;
    if (!Test.isRunningTest()) {
      queryResponse = queryTractByParamAndValue(
        tractConfig,
        'CustomField',
        'productEid',
        productEid,
        null,
        null,
        null
      );
    } else {
      //queryResponse = SoapApi33TestUtil.getDiscountCodes();
    }
    return queryResponse;
  }
  /**
   * query Service Custom Fields By id from GTV db
   * @param srId tract service resouce id
   * @return SoapApi33Domain.QueryResponse
   */
  public static SoapApi33Domain.QueryResponse queryServiceResourceById(
    String srId
  ) {
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Domain.QueryResponse queryResponse;
    if (!Test.isRunningTest()) {
      queryResponse = queryTractByParamAndValue(
        tractConfig,
        'ServiceResource',
        'identifier',
        srId,
        1,
        50,
        'DEEP'
      );
    } else {
      queryResponse = SoapApi33TestUtil.getserviceResources();
    }
    return queryResponse;
  }
  /**
   * query Product Relation By Product from GTV db
   * @param productEid tract product id
   * @return SoapApi33Domain.QueryResponse
   */
  public static SoapApi33Domain.QueryResponse queryProductRelationByProduct(
    String productEid
  ) {
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Domain.QueryResponse queryResponse;
    if (!Test.isRunningTest()) {
      queryResponse = queryTractByParamAndValue(
        tractConfig,
        'ProductRelation',
        'productEid',
        productEid,
        null,
        null,
        null
      );
    } else {
      queryResponse = SoapApi33TestUtil.getProductRelations();
    }
    return queryResponse;
  }
  /**
   * query Billing Account Service from GTV db
   * @param sfdcAccount salesforce account
   * @return SoapApi33Domain.QueryResponse
   */
  public static SoapApi33Domain.QueryResponse queryBillingAccountService(
    Account sfdcAccount
  ) {
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Domain.QueryResponse queryResponse;
    if (!Test.isRunningTest()) {
      queryResponse = queryTractByParamAndValue(
        tractConfig,
        'Service',
        'accountNum',
        sfdcAccount.Tract_Billing_Account__c,
        1,
        50,
        'DEEP'
      );
      if (
        queryResponse.successful &&
        null != queryResponse.services.service &&
        queryResponse.services.totalPages > 1
      ) {
        for (
          Integer pageNumber = 2;
          pageNumber >= queryResponse.services.totalPages;
          pageNumber++
        ) {
          SoapApi33Domain.QueryResponse queryResponseInLoop = queryTractByParamAndValue(
            tractConfig,
            'Service',
            'accountNum',
            sfdcAccount.Tract_Billing_Account__c,
            pageNumber,
            50,
            'DEEP'
          );
          queryResponse.services.service.addAll(
            queryResponseInLoop.services.service
          );
        }
      }
    } else {
      queryResponse = SoapApi33TestUtil.getServices();
    }
    return queryResponse;
  }
  /**
   * query Order By Account Number from GTV db
   * @param accountNum tract account number
   * @return SoapApi33Domain.QueryResponse
   */
  public static SoapApi33Domain.QueryResponse queryOrderByAccountNumber(
    String accountNum
  ) {
    SoapApi33Domain.QueryResponse orderQueryResponse;
    SoapApi33Domain.QueryResponse orderQueryResponseInLoop;
    TRACT_Setup__c tractConfig = getTractSetup();
    /* Querying SalesOrder from Tract by making callout */
    if (!Test.isRunningTest()) {
      orderQueryResponse = queryTractByParamAndValue(
        tractConfig,
        'SalesOrder',
        'accountNum',
        accountNum,
        1,
        null,
        'DEEP'
      );
    } else {
      orderQueryResponse = SoapApi33TestUtil.getSalesOrders();
    }
    if (
      orderQueryResponse.successful &&
      null != orderQueryResponse.SalesOrders.salesOrder
    ) {
      Integer totalPages = orderQueryResponse.SalesOrders.totalPages;
      if (totalPages > 1) {
        for (Integer i = 2; i <= totalPages; i++) {
          if (!Test.isRunningTest()) {
            orderQueryResponseInLoop = queryTractByParamAndValue(
              tractConfig,
              'SalesOrder',
              'accountNum',
              accountNum,
              i,
              null,
              'DEEP'
            );
          } else {
            orderQueryResponseInLoop = SoapApi33TestUtil.getSalesOrders();
          }
          if (
            orderQueryResponseInLoop.successful &&
            null != orderQueryResponseInLoop.SalesOrders.salesOrder
          ) {
            orderQueryResponse.SalesOrders.salesOrder.addAll(
              orderQueryResponseInLoop.SalesOrders.salesOrder
            );
          }
        }
      }
    }
    return orderQueryResponse;
  }
  /**
   * query Services By Billing Account from GTV db
   * @param sfdcAccount salesforce account
   * @param pageNumber page number from which data to be fetched for the entity
   * @return SoapApi33Domain.QueryResponse
   */
  public static SoapApi33Domain.QueryResponse queryServicesByBillingAccount(
    Account sfdcAccount,
    Integer pageNumber
  ) {
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Domain.QueryResponse queryResponse;
    if (!Test.isRunningTest()) {
      queryResponse = queryTractByParamAndValue(
        tractConfig,
        'Service',
        'accountNum',
        sfdcAccount.Tract_Billing_Account__c,
        pageNumber,
        50,
        'DEEP'
      );
    } else {
      queryResponse = SoapApi33TestUtil.getServices();
    }
    return queryResponse;
  }

  /**
   * Query Invoices number from GTV db to the specified parameters
   * @param invNumber tract invoice number(required)
   * @return SoapApi33Domain.QueryResponse
   */
  public static SoapApi33Domain.QueryResponse getInvoicesNumber(
    String invNumber
  ) {
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Domain.QueryResponse queryResponse;
    /* Querying Invoices from Tract by making callout */
    if (!Test.isRunningTest()) {
      queryResponse = queryTractByParamAndValue(
        tractConfig,
        'Invoice',
        'invoiceNum',
        invNumber,
        null,
        null,
        'DEEP'
      );
    } else {
      queryResponse = SoapApi33TestUtil.getInvoices();
    }
    return queryResponse;
  }
  /**
   * Query Discount Code Services from GTV db to the specified parameters
   * @param serviceEid tract service id(required)
   * @return SoapApi33Domain.QueryResponse
   */
  public static SoapApi33Domain.QueryResponse queryDiscountCodeServices(
    String serviceEid
  ) {
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Domain.QueryResponse serviceDiscountCodeQueryResponse;
    if (!Test.isRunningTest()) {
      serviceDiscountCodeQueryResponse = queryTractByParamAndValue(
        tractConfig,
        'DiscountCodeService',
        'serviceEid',
        serviceEid,
        1,
        50,
        'DEEP'
      );
    } else {
      serviceDiscountCodeQueryResponse = SoapApi33TestUtil.queryDiscountCodeServices();
    }
    return serviceDiscountCodeQueryResponse;
  }
  /**
   * Query Product Categories from GTV db to the specified parameters
   * @return SoapApi33Domain.QueryResponse
   */
  public static SoapApi33Domain.QueryResponse queryProductCategories() {
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Domain.QueryResponse productCategoryQueryResponse;
    if (!Test.isRunningTest()) {
      productCategoryQueryResponse = queryTractByParamAndValue(
        tractConfig,
        'ProductCategory',
        null,
        null,
        1,
        50,
        'DEEP'
      );
    } else {
      productCategoryQueryResponse = SoapApi33TestUtil.queryProductCategory();
    }
    return productCategoryQueryResponse;
  }
  /**
   * Query Service Resource Categories from GTV db to the specified parameters
   * @return SoapApi33Domain.QueryResponse
   */
  public static SoapApi33Domain.QueryResponse queryServiceResourceCategories() {
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Domain.QueryResponse serviceResourceCategoryQueryResponse;
    if (!Test.isRunningTest()) {
      serviceResourceCategoryQueryResponse = queryTractByParamAndValue(
        tractConfig,
        'ServiceResourceCategory',
        null,
        null,
        1,
        50,
        'DEEP'
      );
    } else {
      serviceResourceCategoryQueryResponse = SoapApi33TestUtil.queryServiceResourceCategories();
    }
    return serviceResourceCategoryQueryResponse;
  }
  /**
   * create product in GTV db to the specified parameters
   * @param createReq SoapApi33Domain.CreateRequest(required)
   * @return SoapApi33Domain.CreateResponse
   */
  public static SoapApi33Domain.CreateResponse createGTVProduct(
    SoapApi33Domain.CreateRequest createReq
  ) {
    SoapApi33Domain.CreateResponse creteRes;
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Service.TractPort tractBilling = getTractServicePort(tractConfig);
    if (!Test.isRunningTest()) {
      creteRes = tractBilling.create(createReq);
    } else {
      creteRes = SoapApi33TestUtil.gettractBilling();
    }
    return creteRes;
  }
  /**
   * Query Product Tags from GTV db to the specified parameters
   * @return SoapApi33Domain.QueryResponse
   */
  public static SoapApi33Domain.QueryResponse queryProductTags() {
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Domain.QueryResponse productTagQueryResponse;
    if (!Test.isRunningTest()) {
      productTagQueryResponse = queryTractByParamAndValue(
        tractConfig,
        'ProductTag',
        null,
        null,
        1,
        50,
        'DEEP'
      );
    } else {
      productTagQueryResponse = SoapApi33TestUtil.queryProductTags();
    }
    return productTagQueryResponse;
  }
  /**
   * Query Product Register Types from GTV db to the specified parameters
   * @return SoapApi33Domain.QueryResponse
   */
  public static SoapApi33Domain.QueryResponse queryProductRegisterTypes() {
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Domain.QueryResponse productRegisterTypesQueryResponse;
    if (!Test.isRunningTest()) {
      productRegisterTypesQueryResponse = queryTractByParamAndValue(
        tractConfig,
        'ProductRegisterType',
        null,
        null,
        1,
        50,
        'DEEP'
      );
    } else {
      //serviceDiscountCodeQueryResponse = SoapApi33TestUtil.queryDiscountCodeServices();
    }
    return productRegisterTypesQueryResponse;
  }
  /**
   * Query all agreements from GTV db to the specified parameters
   * @param commandRequestList List<SoapApi33Domain.CommandRequest>
   * @return error msg
   */
  public static String addAllAgreements(
    List<SoapApi33Domain.CommandRequest> commandRequestList
  ) {
    String emessage = 'No error';
    SoapApi33Domain.BatchResponse commandResAddBillingCustom;
    SoapApi33Domain.CommandBatchRequest batchRequest = new SoapApi33Domain.CommandBatchRequest();
    batchRequest.requests = new SoapApi33Domain.commandRequests_element();
    batchRequest.requests.command = commandRequestList;
    batchRequest.stopOnError = true;
    batchRequest.transactional = true;
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Service.TractPort tractBilling = getTractServicePort(tractConfig);
    if (!Test.isRunningTest()) {
      commandResAddBillingCustom = tractBilling.Batchcommand(batchRequest);
    } else {
      //commandResAddBillingCustom = SoapApi33TestUtil.saveAccountCustomField();
    }

    if (commandResAddBillingCustom.errorOccurred) {
      if (
        commandResAddBillingCustom.errors != null &&
        commandResAddBillingCustom.errors.error.size() > 0
      ) {
        for (
          SoapApi33Service.FaultResponse fault : commandResAddBillingCustom.errors.error
        ) {
          if (emessage == 'No Error') {
            String error = fault.message.substringAfter('Validation ');
            emessage = error;
          } else {
            emessage += ',' + fault.message.substringAfter('Validation ');
          }
        }
      }
    }
    return emessage;
  }
  /**
   * request to activate product In GTV
   * @param serviceCommandRequest SoapApi33Domain.CommandRequest
   * @return SoapApi33Domain.CommandResponse
   */
  public static SoapApi33Domain.CommandResponse activateProduct(
    SoapApi33Domain.CommandRequest serviceCommandRequest
  ) {
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Domain.CommandResponse activateProductCommand;
    SoapApi33Service.TractPort tractBilling = getTractServicePort(tractConfig);
    if (!Test.isRunningTest())
      activateProductCommand = tractBilling.command(serviceCommandRequest);
    else {
      activateProductCommand = SoapApi33TestUtil.getCommandresponse();
    }
    return activateProductCommand;
  }
  /**
   * Query Price Catogories from GTV db to the specified parameters
   * @return SoapApi33Domain.QueryResponse
   */
  public static SoapApi33Domain.QueryResponse queryPriceCatogories() {
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Domain.QueryResponse queryResponse;
    if (!Test.isRunningTest()) {
      queryResponse = queryTractByParamAndValue(
        tractConfig,
        'PriceCategory',
        null,
        null,
        1,
        50,
        'DEEP'
      );
    } else {
      //  queryResponse = SoapApi33TestUtil.getServices();
    }
    return queryResponse;
  }
  /**
   * request to add Product Price In GTV
   * @param serviceCommandRequest SoapApi33Domain.CommandRequest
   * @return SoapApi33Domain.CommandResponse
   */
  public static SoapApi33Domain.CommandResponse addProductPrice(
    SoapApi33Domain.CommandRequest serviceCommandRequest
  ) {
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Domain.CommandResponse addProductPriceCommand;
    SoapApi33Service.TractPort tractBilling = getTractServicePort(tractConfig);
    if (!Test.isRunningTest())
      addProductPriceCommand = tractBilling.command(serviceCommandRequest);
    else {
      addProductPriceCommand = SoapApi33TestUtil.getCommandresponse();
    }
    return addProductPriceCommand;
  }
  /**
   * query Product Price from GTV db to the specified parameters
   * @param productEid tract product id
   * @return SoapApi33Domain.QueryResponse
   */
  public static SoapApi33Domain.QueryResponse queryProductPrice(
    String productEid
  ) {
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Domain.QueryResponse productPriceQueryResponse;
    if (!Test.isRunningTest()) {
      productPriceQueryResponse = queryTractByParamAndValue(
        tractConfig,
        'ProductPrice',
        'productEid',
        productEid,
        1,
        50,
        'DEEP'
      );
    } else {
      //productPriceQueryResponse = SoapApi33TestUtil.queryDiscountCodeServices();
    }
    return productPriceQueryResponse;
  }
  /**
   * query Product Price For Price List from GTV db to the specified parameters
   * @param priceListEid tract price list id
   * @param productEid tract product id
   * @return SoapApi33Domain.QueryResponse
   */
  public static SoapApi33Domain.QueryResponse queryProductPriceForPriceList(
    String priceListEid,
    String productEid
  ) {
    SoapApi33Domain.QueryResponse productPriceQueryResponse;
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Domain.ParameterAndValue[] params = new List<SoapApi33Domain.ParameterAndValue>{};
    SoapApi33Domain.ParameterAndValue param1 = new SoapApi33Domain.ParameterAndValue();
    param1.parameter = 'priceListEid';
    param1.parameterValue = priceListEid;
    param1.operator = 'EQ';
    SoapApi33Domain.ParameterAndValue param2 = new SoapApi33Domain.ParameterAndValue();
    param2.parameter = 'productEid';
    param2.parameterValue = productEid;
    param2.operator = 'EQ';
    params.add(param1);
    params.add(param2);
    if (!Test.isRunningTest()) {
      productPriceQueryResponse = queryTract(
        tractConfig,
        'ProductPrice',
        params,
        1,
        50,
        'DEEP'
      );
    } else {
      //productQueryResponse = SoapApi33TestUtil.getProducts();
    }

    return productPriceQueryResponse;
  }
  /**
   * query market places from GTV db to the specified parameters
   * @return SoapApi33Domain.QueryResponse
   */
  public static SoapApi33Domain.QueryResponse queryMarketPlaces() {
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Domain.QueryResponse queryResponse;
    if (!Test.isRunningTest()) {
      queryResponse = queryTractByParamAndValue(
        tractConfig,
        'MarketPlace',
        null,
        null,
        1,
        50,
        'DEEP'
      );
    } else {
      queryResponse = SoapApi33TestUtil.queryMarketPlaces();
    }
    return queryResponse;
  }
  /**
   * query Price Lists By Market Place Eid from GTV db to the specified parameters
   * @param marketPlaceEid tract market place id
   * @return SoapApi33Domain.QueryResponse
   */
  public static SoapApi33Domain.QueryResponse queryPriceListsByMarketPlaceEid(
    String marketPlaceEid
  ) {
    SoapApi33Domain.QueryResponse queryResponse;
    TRACT_Setup__c tractConfig = getTractSetup();
    if (!Test.isRunningTest()) {
      queryResponse = queryTractByParamAndValue(
        tractConfig,
        'PriceList',
        'marketPlaceEid',
        marketPlaceEid,
        null,
        null,
        'DEEP'
      );
    } else {
      queryResponse = SoapApi33TestUtil.getPriceListValue();
    }
    return queryResponse;
  }
  /**
   * add Product To Price List in GTV db to the specified parameters
   * @param commandRequestList List<SoapApi33Domain.CommandRequest>
   * @return error
   */

  public static String addProductToPriceList(
    List<SoapApi33Domain.CommandRequest> commandRequestList
  ) {
    String emessage = 'No error';
    SoapApi33Domain.BatchResponse commandResAddProductToPriceList;
    SoapApi33Domain.CommandBatchRequest batchRequest = new SoapApi33Domain.CommandBatchRequest();
    batchRequest.requests = new SoapApi33Domain.commandRequests_element();
    batchRequest.requests.command = commandRequestList;
    batchRequest.stopOnError = true;
    batchRequest.transactional = true;
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Service.TractPort tractBilling = getTractServicePort(tractConfig);
    if (!Test.isRunningTest()) {
      commandResAddProductToPriceList = tractBilling.Batchcommand(batchRequest);
    } else {
      commandResAddProductToPriceList = SoapApi33TestUtil.saveAccountCustomField();
    }

    if (commandResAddProductToPriceList.errorOccurred) {
      if (
        commandResAddProductToPriceList.errors != null &&
        commandResAddProductToPriceList.errors.error.size() > 0
      ) {
        for (
          SoapApi33Service.FaultResponse fault : commandResAddProductToPriceList.errors.error
        ) {
          if (emessage == 'No Error') {
            String error = fault.message.substringAfter('Validation ');
            emessage = error;
          } else {
            emessage += ',' + fault.message.substringAfter('Validation ');
          }
        }
      }
    }
    return Emessage;
  }
  /**
   * remove Product To Price List in GTV db to the specified parameters
   * @param commandRequestList List<SoapApi33Domain.CommandRequest>
   * @return error
   */
  public static String removeProductFromPriceList(
    List<SoapApi33Domain.CommandRequest> commandRequestList
  ) {
    String emessage = 'No error';
    SoapApi33Domain.BatchResponse commandResAddProductToPriceList;
    SoapApi33Domain.CommandBatchRequest batchRequest = new SoapApi33Domain.CommandBatchRequest();
    batchRequest.requests = new SoapApi33Domain.commandRequests_element();
    batchRequest.requests.command = commandRequestList;
    batchRequest.stopOnError = true;
    batchRequest.transactional = true;
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Service.TractPort tractBilling = getTractServicePort(tractConfig);
    if (!Test.isRunningTest()) {
      commandResAddProductToPriceList = tractBilling.Batchcommand(batchRequest);
    } else {
      commandResAddProductToPriceList = SoapApi33TestUtil.saveAccountCustomField();
    }

    if (commandResAddProductToPriceList.errorOccurred) {
      if (
        commandResAddProductToPriceList.errors != null &&
        commandResAddProductToPriceList.errors.error.size() > 0
      ) {
        for (
          SoapApi33Service.FaultResponse fault : commandResAddProductToPriceList.errors.error
        ) {
          if (emessage == 'No Error') {
            String error = fault.message.substringAfter('Validation ');
            emessage = error;
          } else {
            emessage += ',' + fault.message.substringAfter('Validation ');
          }
        }
      }
    }
    return emessage;
  }
  /**
   * delete market place in GTV db to the specified parameters
   * @param deleteMarketPlace SoapApi33Domain.CommandRequest
   */
  public static void deleteMarketPlace(
    SoapApi33Domain.CommandRequest deleteMarketPlace
  ) {
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Service.TractPort tractBilling = getTractServicePort(tractConfig);
    if (!Test.isRunningTest()) {
      tractBilling.command(deleteMarketPlace);
    }
  }
  /**
   * delete Product Relation in GTV db to the specified parameters
   * @param deleteMarketPlace SoapApi33Domain.CommandRequest
   */
  public static void deleteProductRelation(
    SoapApi33Domain.CommandRequest deleteMarketPlace
  ) {
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Service.TractPort tractBilling = getTractServicePort(tractConfig);
    if (!Test.isRunningTest()) {
      tractBilling.command(deleteMarketPlace);
    }
  }
  /**
   * query Billing Accounts By Responsible Account Eid from GTV db to the specified parameters
   * @param responsibleAccountEid tract account number
   * @return SoapApi33Domain.QueryResponse
   */
  public static SoapApi33Domain.QueryResponse queryBillingAccountsByResponsibleAccountEid(
    String responsibleAccountEid
  ) {
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Domain.QueryResponse queryResponse;
    if (!Test.isRunningTest()) {
      queryResponse = queryTractByParamAndValue(
        tractConfig,
        'BillingAccount',
        'responsibleAccountEid',
        responsibleAccountEid,
        1,
        50,
        'DEEP'
      );
    } else {
      queryResponse = SoapApi33TestUtil.getBillingAccounts();
    }
    return queryResponse;
  }
  /**
   * query query Child Accounts from GTV db to the specified parameters
   * @param accountEid tract account id
   * @return SoapApi33Domain.QueryResponse
   */
  public static SoapApi33Domain.QueryResponse queryChildAccounts(
    String accountEid
  ) {
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Domain.QueryResponse queryResponse;
    if (!Test.isRunningTest()) {
      queryResponse = queryTractByParamAndValue(
        tractConfig,
        'BillingAccount',
        'parentEid',
        accountEid,
        1,
        50,
        'DEEP'
      );
    } else {
      queryResponse = SoapApi33TestUtil.getBillingAccounts();
    }
    return queryResponse;
  }
  /* Querying custom fields from GTV */
  /**
   * query Custom Field List from GTV db to the specified parameters
   * @param customFieldType tract custom field type
   * @param tractConfig tract configuration setting
   * @return SoapApi33Domain.QueryResponse
   */
  public static SoapApi33Domain.QueryResponse getCustomFieldList(
    String customFieldType,
    TRACT_Setup__c tractConfig
  ) {
    SoapApi33Domain.QueryResponse customFieldQueryResponse;
    if (!Test.isRunningTest()) {
      customFieldQueryResponse = queryTractByParamAndValue(
        tractConfig,
        'CustomField',
        'type',
        customFieldType,
        null,
        null,
        'DEEP'
      );
    } else {
      customFieldQueryResponse = SoapApi33TestUtil.getCustomFields();
    }
    return customFieldQueryResponse;
  }
  /**
   * query Market Place from GTV db to the specified parameters
   * @param tractConfig tract configuration setting
   * @return SoapApi33Domain.QueryResponse
   */
  public static SoapApi33Domain.QueryResponse queryMarketPlaces(
    TRACT_Setup__c tractConfig
  ) {
    SoapApi33Domain.QueryResponse queryResponse;
    if (!Test.isRunningTest()) {
      queryResponse = queryTractByParamAndValue(
        tractConfig,
        'MarketPlace',
        null,
        null,
        1,
        50,
        'DEEP'
      );
    } else {
      queryResponse = SoapApi33TestUtil.queryMarketPlaces();
    }
    return queryResponse;
  }
  /**
   * Query sales order using Eid from GTV db to the specified parameters
   * @param productEid order id(required)
   * @return SoapApi33Domain.QueryResponse
   */
  public static SoapApi33Domain.QueryResponse queryProductUsageRules(
    String productEid
  ) {
    SoapApi33Domain.QueryResponse queryResponse;
    TRACT_Setup__c tractConfig = getTractSetup();
    if (!Test.isRunningTest()) {
      queryResponse = queryTractByParamAndValue(
        tractConfig,
        'ProductUsageRule',
        'productPriceEid',
        productEid,
        null,
        null,
        'DEEP'
      );
    } else {
      queryResponse = SoapApi33TestUtil.getSalesOrders();
    }
    return queryResponse;
  }

  public static SoapApi33Domain.QueryResponse getpaymentMethodRecords(
    String gtvBillingAccountNumber
  ) {
    SoapApi33Domain.QueryResponse paymentMethodsQueryResponse;
    TRACT_Setup__c tractConfig = getTractSetup();
    if (!Test.isRunningTest()) {
      paymentMethodsQueryResponse = queryTractByParamAndValue(
        tractConfig,
        'BillingAccountRecurringPayment',
        'accountNum',
        gtvBillingAccountNumber,
        null,
        50,
        'DEEP'
      );
    } else {
      paymentMethodsQueryResponse = SoapApi33TestUtil.getPaymentMethods();
    }
    return paymentMethodsQueryResponse;
  }

  public static SoapApi33Domain.CommandResponse getPaymentReferrerToken(
    SoapApi33Domain.CommandRequest generatePaymentReferrerTokenRequest
  ) {
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Domain.CommandResponse paymentReferrerTokenResponse;
    SoapApi33Service.TractPort tractBilling = getTractServicePort(tractConfig);
    if (!Test.isRunningTest()) {
      paymentReferrerTokenResponse = tractBilling.command(
        generatePaymentReferrerTokenRequest
      );
    }
    return paymentReferrerTokenResponse;
  }

  public static SoapApi33Domain.CreateResponse createPayment(
    SoapApi33Domain.CreateRequest createReq
  ) {
    SoapApi33Domain.CreateResponse creteRes;
    TRACT_Setup__c tractConfig = getTractSetup();
    SoapApi33Service.TractPort tractBilling = getTractServicePort(tractConfig);
    if (!Test.isRunningTest()) {
      creteRes = tractBilling.create(createReq);
    } else {
      creteRes = SoapApi33TestUtil.gettractBilling();
    }
    return creteRes;
  }
}