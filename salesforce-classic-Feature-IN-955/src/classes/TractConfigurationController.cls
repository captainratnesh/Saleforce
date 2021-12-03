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
 * This class is the Controller to handle the billing Configuration module.
 * @author AMAN JAIN
 */

global with sharing class TractConfigurationController {
  /**
   * @description: Query GTV configuration information from Tract setup custom setting and return UI wrapper after mapping it.
   * @return GTVBillingWrapper The billing wrapper to be used on UI
   */
  @AuraEnabled
  public static GTVBillingWrapper getGTVBillingWrap() {
    GTVBillingWrapper billingWrapper = new GTVBillingWrapper();
    TRACT_Setup__c tract;
    list<TRACT_Setup__c> tractList = new List<TRACT_Setup__c>();
    /* Querying the TRACT Setup Object */
    tractList = [
      SELECT
        id,
        TPassword__c,
        Selected_Marketplace_Id__c,
        Tract_User_Name__c,
        TRACT_URL__c,
        Api_Version__c,
        Active__c,
        TRACT_URL2_0__c,
        Gotransverse_Sync_Type__c,
        X_API_Key__c,
        OrderStatus__c,
        Mapped_Custom_Field_Id__c,
        Batch_Triggered__c,
        Gotransverse_Hosted_Payment_URL__c,
        Change_Order_Indicator__c,
        Change_Order_Indicator_Value__c
      FROM TRACT_Setup__c
      WHERE Active__c = TRUE
      LIMIT 1
    ];

    if (!tractList.IsEmpty()) {
      set<Id> setofClassIds = new Set<Id>();
      for (ApexClass ac : [
        SELECT Id, Name
        FROM ApexClass
        WHERE
          Name = 'TractBatchSyncProductAgreements'
          OR Name = 'BatchToSyncProductsFromTract'
          OR Name = 'TractBatchCleanProducts'
      ]) {
        setofClassIds.add(ac.id);
      }
      if (!test.isrunningtest()) {
        list<AsyncApexJob> latestApexJob = [
          SELECT
            Id,
            MethodName,
            ApexClassID,
            Status,
            CompletedDate,
            JobItemsProcessed,
            TotalJobItems,
            NumberOfErrors
          FROM AsyncApexJob
          WHERE CompletedDate != NULL AND ApexClassID IN :setofClassIds
          ORDER BY CompletedDate DESC
          LIMIT 1
        ];
        if (!latestApexJob.isEmpty()) {
          if (
            latestApexJob[0].Status == 'Aborted' ||
            (latestApexJob[0].Status == 'Completed' &&
            latestApexJob[0].NumberOfErrors != 0)
          ) {
            tractList.get(0).Batch_Triggered__c = false;
            update tractList;
          }
        }
      }
    }
    /* Checking if the TRACT Setup record exist */
    if (!tractList.IsEmpty()) {
      tract = tractList.get(0);
      billingWrapper.batchTriggered = tract.Batch_Triggered__c;
      billingWrapper.selectedMarketplace = tract.Selected_Marketplace_Id__c;
      billingWrapper.tractUrl = tract.TRACT_URL__c;
      billingWrapper.userName = tract.Tract_User_Name__c;
      billingWrapper.password = tract.TPassword__c;
      billingWrapper.tractUrl2 = tract.TRACT_URL2_0__c;
      billingWrapper.selectedAPIVersion = tract.Api_Version__c;
      billingWrapper.apiKey = tract.X_API_Key__c;
      billingWrapper.orderStatusValue = tract.OrderStatus__c;
      billingWrapper.selectedAccountCustomFieldId = tract.Mapped_Custom_Field_Id__c;
      billingWrapper.hostedPaymentUrl = tract.Gotransverse_Hosted_Payment_URL__c;
      billingWrapper.syncTypeValue = tract.Gotransverse_Sync_Type__c;
      billingWrapper.changeOrderIndicator = tract.Change_Order_Indicator__c;
      billingWrapper.changeOrderIndicatorValue = tract.Change_Order_Indicator_Value__c;
      if (
        billingWrapper.changeOrderIndicator != null &&
        billingWrapper.changeOrderIndicatorValue != null
      ) {
        billingWrapper.enabledchangeOrderValue = 'Yes';
      }
    } else {
      billingWrapper.existingTract = true;
    }
    billingWrapper.tract = tract;
    /* Setting up the list of API versions */
    List<SelectOption> apiVersionList = new List<SelectOption>();
    apiVersionList.add(new selectOption('API Version 1.0', 'API Version 1.0'));
    apiVersionList.add(new selectOption('API Version 2.0', 'API Version 2.0'));
    billingWrapper.apiVersionList = apiVersionList;

    /* Setting up the list of Order states */
    List<SelectOption> orderStateList = new List<SelectOption>();
    orderStateList.add(new selectOption('DRAFT', 'DRAFT'));
    orderStateList.add(new selectOption('FINAL', 'FINAL'));
    billingWrapper.orderStateList = orderStateList;

    /* Setting up the list of Sync types */
    List<SelectOption> syncTypeList = new List<SelectOption>();
    syncTypeList.add(new selectOption('MANUAL', 'Manual Sync'));
    syncTypeList.add(new selectOption('AUTOMATIC', 'Automatic Sync'));
    billingWrapper.syncTypeList = syncTypeList;

    /* Setting up the list of Change Orders */
    List<SelectOption> enabledOrderChangeList = new List<SelectOption>();
    enabledOrderChangeList.add(new SelectOption('Yes', 'Yes'));
    enabledOrderChangeList.add(new SelectOption('No', 'No'));
    billingWrapper.enabledOrderChangeList = enabledOrderChangeList;

    /* Setting up the list of Order states */
    List<SelectOption> accountCreationStateList = new List<SelectOption>();
    accountCreationStateList.add(
      new selectOption(
        'Automatically When a Salesforce Account is saved',
        'Automatically When a Salesforce Account is saved'
      )
    );
    accountCreationStateList.add(
      new selectOption(
        'I will Embed A Create GTV Account Button',
        'I will Embed A Create GTV Account Button'
      )
    );
    billingWrapper.accountCreationStateList = accountCreationStateList;

    /* Setting up account custom field */
    List<SelectOption> accountCustomFieldList = new List<SelectOption>();
    accountCustomFieldList.add(
      new selectOption('External Account Number', 'External Account Number')
    );
    billingWrapper.accountCustomFieldList = accountCustomFieldList;

    if (GTV_Currencies__c.getValues('Currency') != null) {
      billingWrapper.currencySet = GTV_Currencies__c.getValues('Currency')
        .GTV_Currency_List__c;
    }

    insertPermissionSets();
    billingWrapper.accountMappingWrapper = mapDefaultAccount();
    getOpportunityField(billingWrapper);
    // billingWrapper.oppFieldPicklist = getPicklistValues('','');
    return billingWrapper;
  }

  /**
   * @description: Trigger to insert custom settings automatically for permissions on the account detail page.
   */
  private static void insertPermissionSets() {
    GetPermissionSet__c accountConfSectionPermissionSet = GetPermissionSet__c.getInstance(
      'Show Account Configurations Section'
    );
    if (accountConfSectionPermissionSet != null) {
      delete accountConfSectionPermissionSet;
    }
    Map<String, GetPermissionSet__c> existingPermissionSetRecords = GetPermissionSet__c.getAll();
    List<GetPermissionSet__c> addNewPermissionSetRecords = new List<GetPermissionSet__c>();
    Integer i = 0;
    List<String> getnames = new List<String>{
      'Show Billing Address Section',
      'Show Shipping Address Section',
      'Show Account Custom Fields',
      'Show Payments Section',
      'Show Invoices Section',
      'Allow Invoice Download',
      'Show Sales Orders Section',
      'Show Services Section',
      'Allow Services Deactivate',
      'Allow Services Change Service',
      'Allow Services Add Address',
      'Allow Services Suspend',
      'Allow Services Update Quantity',
      'Show One Time Purchase Section',
      'Show Debit Adjustments Section',
      'Allow Debit Adjustments Add',
      'Show Credit Adjustments Section',
      'Allow Credit Adjustments Add',
      'Show Payment Methods Section',
      'Show Contacts Section',
      'Show Notes Section',
      'Show Activity Events Section'
    };
    //Record sequence number to sort custom settings
    List<Integer> getorder = new List<Integer>{
      1,
      2,
      3,
      4,
      5,
      6,
      7,
      8,
      9,
      10,
      11,
      12,
      13,
      14,
      15,
      16,
      17,
      18,
      19,
      20,
      21,
      22
    };
    for (String permissionSetName : getnames) {
      GetPermissionSet__c addSet = new GetPermissionSet__c();
      if (existingPermissionSetRecords.containsKey(permissionSetName)) {
        addSet = existingPermissionSetRecords.get(permissionSetName);
        addSet.Order_by__c = getorder[i];
      } else {
        addSet.Name = permissionSetName;
        addSet.Order_by__c = getorder[i];
        addSet.SetName__c = '';
        addSet.SetStatus__c = true;
      }
      addNewPermissionSetRecords.add(addSet);
      i++;
    }
    if (
      addNewPermissionSetRecords != null &&
      addNewPermissionSetRecords.size() > 0
    ) {
      Database.upsert(addNewPermissionSetRecords, false); // if no records found, insert records
    }
  }

  /**
   * @description: Gets permission set custom settings for Billing page.
   * @return List<PermSetWrapper> The List of the PermSetWrapper to be used on UI
   */
  @AuraEnabled
  public static List<PermSetWrapper> getPermissionSetList() {
    Map<String, GetPermissionSet__c> getall = GetPermissionSet__c.getAll();
    List<PermSetWrapper> newPermissionSet = new List<PermSetWrapper>(); //refers to PermSetWrapper, used as a carrier to lighnting component.
    Map<Integer, String> labels = new Map<Integer, String>();
    Map<Integer, String> nameset = new Map<Integer, String>();
    Map<Integer, Boolean> statusval = new Map<Integer, Boolean>();

    if (getall.values() != null) {
      for (GetPermissionSet__c c : getall.values()) {
        labels.put(Integer.valueOf(c.Order_by__c), c.Name); // Map to store sequence number vs Name

        nameset.put(Integer.valueOf(c.Order_by__c), c.SetName__c); // Map to store sequence number vs Permission Set name
        statusval.put(Integer.valueOf(c.Order_by__c), c.SetStatus__c); // Map to store sequence number vs checkbox status
      }

      for (Integer i = 1; i <= getall.keyset().size(); i++) {
        PermSetWrapper wrap = new PermSetWrapper();
        wrap.Name = labels.get(i);
        wrap.Status = statusval.get(i);
        wrap.getsets = nameset.get(i);
        wrap.Order = i;
        newPermissionSet.add(wrap);
      }
    }
    return newPermissionSet;
  }

  /**
   * @description: Validating the permission Set entered by the user.
   * @return String The Message to be shown to the user on UI
   */
  @AuraEnabled
  public static String validatelist(String permissionSetName) {
    List<PermissionSet> permSetList = [SELECT id, Name FROM PermissionSet];
    if (
      permSetList != null &&
      permissionSetName != null &&
      permissionSetName != '' &&
      permissionSetName.length() > 1 // if permission sets exist
    ) {
      for (PermissionSet permSetInstance : permSetList) {
        if (permSetInstance.Name == permissionSetName) {
          return 'No error';
        }
      }
      return 'No permission set with the given name!';
    } else if (permissionSetName.length() <= 1) {
      return 'NA';
    } else {
      return 'No permission sets found!';
    }
  }

  /**
   * @description : this method syncs all the product informatiom from GTV db to Salesforce (Products, Product Prices, Price Ranges, Agreements)
   * @return String The Message to be shown to the user on UI
   **/
  @AuraEnabled
  public static string syncTRACTInformation() {
    String message = '';
    TRACT_Setup__c tract;
    list<TRACT_Setup__c> tractList = new List<TRACT_Setup__c>();
    /* Querying the TRACT Setup Object */
    tractList = [
      SELECT
        id,
        TPassword__c,
        Tract_User_Name__c,
        TRACT_URL__c,
        Api_Version__c,
        Active__c,
        TRACT_URL2_0__c,
        X_API_Key__c,
        OrderStatus__c,
        Gotransverse_Sync_Type__c,
        Mapped_Custom_Field_Id__c,
        Batch_Triggered__c,
        Gotransverse_Hosted_Payment_URL__c
      FROM TRACT_Setup__c
      WHERE Active__c = TRUE
      LIMIT 1
    ];
    if (tractList[0].Gotransverse_Sync_Type__c == 'AUTOMATIC') {
      ScheduleBatch();
    }
    try {
      TractBatchCleanProducts batchToCleanAndInsertGTVdata = new TractBatchCleanProducts();
      Database.executeBatch(batchToCleanAndInsertGTVdata);
      /* Checking if the TRACT Setup record exist */
      if (!tractList.IsEmpty()) {
        tract = tractList.get(0);
        tract.Batch_Triggered__c = true;
        update tract;
      }
    } catch (Exception e) {
      /* Checking if the TRACT Setup record exist */
      if (!tractList.IsEmpty()) {
        tract = tractList.get(0);
        tract.Batch_Triggered__c = false;
        update tract;
      }
      message = 'Unable to Sync this time please try Again!' + e.getMessage();
      return message;
    }
    message = 'A sync is in progress, please wait for 5 minutes.';
    return message;
  }

  /**
   * @description: Insert the GTV tenant information entered by the user in saleforce db and make callout to the GTV to fetch product and other entities.
   * @param gtvBillingWrap serialized GTVBillingWrapper Instance
   * @return String The Message to be shown to the user on UI
   */
  @AuraEnabled
  public static String submit(String gtvBillingWrap) {
    String error = '';
    list<TRACT_Setup__c> tractList = new List<TRACT_Setup__c>();
    tractList = [
      SELECT
        id,
        TPassword__c,
        Tract_User_Name__c,
        TRACT_URL__c,
        Api_Version__c,
        Selected_Marketplace_Id__c,
        Active__c,
        TRACT_URL2_0__c,
        X_API_Key__c,
        OrderStatus__c,
        Mapped_Custom_Field_Id__c,
        Gotransverse_Hosted_Payment_URL__c,
        Change_Order_Indicator__c,
        Change_Order_Indicator_Value__c
      FROM TRACT_Setup__c
      WHERE Active__c = TRUE
      LIMIT 1
    ];
    GTVBillingWrapper billingWrapper = (GTVBillingWrapper) JSON.deserialize(
      gtvBillingWrap,
      GTVBillingWrapper.class
    );
    String errorMessage = '';
    try {
      errorMessage = validateGTVDetails(billingWrapper);
      if (errorMessage == '') {
        if (
          billingWrapper.tract == null ||
          billingWrapper.tract.Id == null ||
          test.isrunningtest()
        ) {
          TRACT_Setup__c newtract = new TRACT_Setup__c(
            Name = 'GTV Billing Data',
            TRACT_URL__c = billingWrapper.tractUrl != null
              ? billingWrapper.tractUrl.trim()
              : billingWrapper.tractUrl,
            TRACT_URL2_0__c = billingWrapper.tractUrl2 != null
              ? billingWrapper.tractUrl2.trim()
              : billingWrapper.tractUrl2,
            Api_Version__c = billingWrapper.selectedAPIVersion,
            Tract_User_Name__c = billingWrapper.userName,
            TPassword__c = billingWrapper.password,
            Selected_Marketplace_Id__c = billingWrapper.selectedMarketplace,
            Active__c = true,
            OrderStatus__c = billingWrapper.orderStatusValue,
            X_API_Key__c = billingWrapper.apiKey,
            Mapped_Custom_Field_Id__c = billingWrapper.selectedAccountCustomFieldId,
            Gotransverse_Hosted_Payment_URL__c = billingWrapper.hostedPaymentUrl !=
              null
              ? billingWrapper.hostedPaymentUrl.trim()
              : billingWrapper.hostedPaymentUrl,
            Gotransverse_Sync_Type__c = billingWrapper.syncTypeValue,
            Change_Order_Indicator__c = billingWrapper.changeOrderIndicator,
            Change_Order_Indicator_Value__c = billingWrapper.changeOrderIndicatorValue
          );
          billingWrapper.tract = newTract;
        } else {
          if (null != billingWrapper.userName) {
            billingWrapper.tract.Tract_User_Name__c = billingWrapper.userName.trim();
          }
          billingWrapper.tract.Selected_Marketplace_Id__c = billingWrapper.selectedMarketplace;
          billingWrapper.tract.TRACT_URL__c = billingWrapper.tractUrl;
          billingWrapper.tract.TRACT_URL2_0__c = billingWrapper.tractUrl2;
          billingWrapper.tract.Api_Version__c = billingWrapper.selectedAPIVersion;
          billingWrapper.tract.TPassword__c = billingWrapper.password;
          billingWrapper.tract.Active__c = true;
          billingWrapper.tract.X_API_Key__c = billingWrapper.apiKey;
          billingWrapper.tract.OrderStatus__c = billingWrapper.orderStatusValue; //'FINAL';
          billingWrapper.tract.Mapped_Custom_Field_Id__c = billingWrapper.selectedAccountCustomFieldId;
          billingWrapper.tract.Gotransverse_Hosted_Payment_URL__c = billingWrapper.hostedPaymentUrl;
          billingWrapper.tract.Gotransverse_Sync_Type__c = billingWrapper.syncTypeValue;
          billingWrapper.tract.Change_Order_Indicator__c = billingWrapper.changeOrderIndicator;
          billingWrapper.tract.Change_Order_Indicator_Value__c = billingWrapper.changeOrderIndicatorValue;
        }
        APIDataService dataService = GTVDataService.getApiService(
          billingWrapper.tract
        );
        list<CronTrigger> scheduleJob = [
          SELECT Id, CronJobDetail.Id, CronJobDetail.Name, CronJobDetail.JobType
          FROM CronTrigger
          WHERE CronJobDetail.Name = 'Gotransverse Batch Sync'
          ORDER BY CreatedDate DESC
          LIMIT 1
        ];
        if (
          scheduleJob.size() > 0 &&
          billingWrapper.syncTypeValue == 'MANUAL'
        ) {
          System.abortJob(scheduleJob[0].Id);
        }
        // Insert Tract Config
        if (tractList.size() == 0) {
          insert billingWrapper.tract;
        } else {
          billingWrapper.tract.Id = tractList[0].id;
          update billingWrapper.tract;
        }

        if (GTV_Currencies__c.getValues('Currency') != null) {
          GTV_Currencies__c gtvCurrencies = GTV_Currencies__c.getValues(
            'Currency'
          );
          gtvCurrencies.GTV_Currency_List__c = billingWrapper.currencySet;
          update gtvCurrencies;
        } else {
          GTV_Currencies__c gtvCurrencies = new GTV_Currencies__c();
          gtvCurrencies.name = 'Currency';
          gtvCurrencies.GTV_Currency_List__c = billingWrapper.currencySet;
          insert gtvCurrencies;
        }

        // Sync data from TRACT
        error = saveAccountFields(
          JSON.serialize(billingWrapper.accountMappingWrapper)
        );
        if (error == 'NoError') {
          error = syncTRACTInformation();
          if (error == 'A sync is in progress, please wait for 5 minutes.') {
            errorMessage = 'GTV Billing Configuration saved successfully!';
          } else {
            errorMessage = error;
          }
        } else {
          errorMessage = error;
        }
      }
    } catch (Exception ex) {
      if (
        ex.getMessage().contains('Ending position out of bounds') ||
        ex.getMessage().contains('Starting position out of bounds')
      ) {
        errorMessage = 'Please enter the correct Gotransverse URL.';
        return errorMessage;
      } else if (
        ex.getMessage().contains('Unexpected character') ||
        ex.getMessage().contains('Unable to tunnel through proxy.')
      ) {
        errorMessage = 'Please enter the correct Gotransverse URL.';
        return errorMessage;
      } else {
        errorMessage = ex.getMessage(); // + ex.getStackTraceString());
        return errorMessage;
      }
    }
    return errorMessage;
  }

  /**
   * @description: this method Validates the input enter by the user.
   * @param billingWrapper GTVBillingWrapper Instance
   * @return String The error message to be shown to the user on UI
   */
  public static String validateGTVDetails(GTVBillingWrapper billingWrapper) {
    String errorMessage = '';
    if (billingWrapper.selectedAPIVersion == 'API Version 1.0') {
      if ((billingWrapper.tractUrl == null || billingWrapper.tractUrl == '')) {
        errorMessage = 'Please Provide URL  address';
        return errorMessage;
      } else if (
        billingWrapper.userName == null ||
        billingWrapper.userName == ''
      ) {
        errorMessage = 'Please Provide User Name';
        return errorMessage;
      } else if (
        billingWrapper.password == null ||
        billingWrapper.password == ''
      ) {
        errorMessage = 'Please Provide Password ';
        return errorMessage;
      }
    } else if (billingWrapper.selectedAPIVersion == 'API Version 2.0') {
      if (
        (billingWrapper.tractUrl2 == null ||
        billingWrapper.tractUrl2 == '')
      ) {
        errorMessage = 'Please Provide API 2 URL';
        return errorMessage;
      } else if (billingWrapper.apiKey == null || billingWrapper.apiKey == '') {
        errorMessage = 'Please Provide API Key';
        return errorMessage;
      }
    }
    return errorMessage;
  }

  /**
   * @description: Update custom settings based on GTV Billing page.
   * @param permissionSetWrapperString Serialized List<PermSetWrapper> Instance
   */
  @AuraEnabled
  public static void getupdatedPermissionSetlist(
    String permissionSetWrapperString
  ) {
    List<PermSetWrapper> newPermissionSetList = (List<PermSetWrapper>) JSON.deserialize(
      permissionSetWrapperString,
      List<PermSetWrapper>.class
    );
    Map<String, GetPermissionSet__c> getallExistingPermissionSets = GetPermissionSet__c.getAll();
    List<String> sfdcPermissionSetNameList = new List<String>();
    for (PermissionSet existingSalesforceOrgPermissionSet : [
      SELECT id, Name
      FROM PermissionSet
      LIMIT 50000
    ]) {
      sfdcPermissionSetNameList.add(existingSalesforceOrgPermissionSet.Name);
    }
    List<PermissionSet> existingSalesforceOrgPermissionSet = [
      SELECT id, Name
      FROM PermissionSet
      LIMIT 50000
    ];
    list<GetPermissionSet__c> permissionSetListToUpdate = new List<GetPermissionSet__c>();
    for (PermSetWrapper permInstance : newPermissionSetList) {
      if (getallExistingPermissionSets.containskey(permInstance.Name)) {
        GetPermissionSet__c currentPermissionSet = getallExistingPermissionSets.get(
          permInstance.Name
        );
        if (currentPermissionSet.SetStatus__c != permInstance.Status) {
          currentPermissionSet.SetStatus__c = permInstance.Status;
        }
        if (
          sfdcPermissionSetNameList.contains(permInstance.getsets) ||
          permInstance.getsets == ''
        ) {
          currentPermissionSet.SetName__c = permInstance.getsets;
        }
        permissionSetListToUpdate.add(currentPermissionSet);
      }
    }
    if (permissionSetListToUpdate.size() > 0) {
      update permissionSetListToUpdate;
    }
  }

  /**
   * @description: This method make API callout to the GTV and fetch the required entities (Marketplace, Accountcustomfields) on the billing page.
   * @param billingWrapperString Serialized GTVBillingWrapper Instance
   * @return GTVBillingWrapper The wrapper to be shown to the user on UI
   */
  @AuraEnabled
  public static GTVBillingWrapper getGTVEntities(String billingWrapperString) {
    GTVBillingWrapper billingWrapper = (GTVBillingWrapper) JSON.deserialize(
      billingWrapperString,
      GTVBillingWrapper.class
    );
    TRACT_Setup__c tractConfig = getSetupInstance(billingWrapper);
    APIDataService dataService = GTVDataService.getApiService(tractConfig);
    billingWrapper.accountCustomFieldList = getAccountCustomFieldList(
      dataService,
      tractConfig
    );
    billingWrapper.listOfMarketplaces = getMarketPlaceList(
      dataService,
      tractConfig
    );
    if (
      billingWrapper.listOfMarketplaces != null &&
      billingWrapper.listOfMarketplaces.size() > 0 &&
      billingWrapper.selectedMarketplace == null
    ) {
      billingWrapper.selectedMarketplace = billingWrapper.listOfMarketplaces[0]
        .value;
    }
    return billingWrapper;
  }

  /**
   * @description: Querying Account custom field from GTV.
   * @param dataService APIDataService Instance
   * @param tractConfig TRACT_Setup__c Salesforce Custom setting Instance
   * @return list<SelectOption> The list of select option to be shown to the user on UI
   */
  @AuraEnabled
  public static list<SelectOption> getAccountCustomFieldList(
    APIDataService dataService,
    TRACT_Setup__c tractConfig
  ) {
    list<SelectOption> listOfAccountCustomField = new List<SelectOption>();
    listOfAccountCustomField.add(
      new selectOption('External Account Number', 'External Account Number')
    );
    system.debug('dataService:::::' + dataService);
    system.debug('tractConfig:::::' + tractConfig);
    listOfAccountCustomField.addall(
      dataService.getCustomFieldForBilling(tractConfig)
    );
    return listOfAccountCustomField;
  }

  /**
   * @description: Querying Marketplace from GTV.
   * @param dataService APIDataService Instance
   * @param tractConfig TRACT_Setup__c Salesforce Custom setting Instance
   * @return list<SelectOption> The list of select option to be shown to the user on UI
   */
  @AuraEnabled
  public static list<SelectOption> getMarketPlaceList(
    APIDataService dataService,
    TRACT_Setup__c tractConfig
  ) {
    list<SelectOption> listOfMarketplaces = new List<SelectOption>();
    listOfMarketplaces = dataService.getAllMarketPlace(tractConfig);
    return listOfMarketplaces;
  }

  /**
   * @description: This method make API callout to the GTV to verify if the connection with GTV happened successfully.
   * @param billingWrapperString Serialized GTVBillingWrapper Instance
   * @return String The error message to be shown to the user on UI
   */
  @AuraEnabled
  public static String apiConnectionTest(String billingWrapperString) {
    TRACT_Setup__c tractConfig;
    GTVBillingWrapper billingWrapper = (GTVBillingWrapper) JSON.deserialize(
      billingWrapperString,
      GTVBillingWrapper.class
    );
    String errorMessage = '';
    try {
      errorMessage = validateGTVDetails(billingWrapper);
      if (errorMessage == '') {
        tractConfig = getSetupInstance(billingWrapper);
        APIDataService dataService = GTVDataService.getApiService(tractConfig);
        dataService.queryPriceListsForTestingConnection(tractConfig);
      } else {
        return errorMessage;
      }
    } catch (Exception ex) {
      if (
        ex.getMessage().contains('Ending position out of bounds') ||
        ex.getMessage().contains('Starting position out of bounds')
      ) {
        errorMessage = 'Please enter the correct Gotransverse URL.';
        return errorMessage;
      } else if (
        ex.getMessage().contains('Unexpected character') ||
        ex.getMessage().contains('Unable to tunnel through proxy.')
      ) {
        errorMessage = 'Please enter the correct Gotransverse URL.';
        return errorMessage;
      } else {
        errorMessage = ex.getMessage(); // + ex.getStackTraceString());
        return errorMessage;
      }
    }
    return errorMessage;
  }

  /**
   * @description: This method query the instance of the tract setup custom settings.
   * @param billingWrapper GTVBillingWrapper Instance
   * @return TRACT_Setup__c The instance of the tract setup custom settings.
   */
  private static TRACT_Setup__c getSetupInstance(
    GTVBillingWrapper billingWrapper
  ) {
    TRACT_Setup__c tractConfig = new TRACT_Setup__c(
      Name = 'GTV Billing Data',
      Api_Version__c = billingWrapper.selectedAPIVersion
    );
    if (billingWrapper.selectedAPIVersion == 'API Version 1.0') {
      tractConfig.TRACT_URL__c = billingWrapper.tractUrl != null
        ? billingWrapper.tractUrl.trim()
        : billingWrapper.tractUrl;
      tractConfig.Tract_User_Name__c = billingWrapper.userName;
      tractConfig.TPassword__c = billingWrapper.password;
    } else if (billingWrapper.selectedAPIVersion == 'API Version 2.0') {
      tractConfig.TRACT_URL2_0__c = billingWrapper.tractUrl2 != null
        ? billingWrapper.tractUrl2.trim()
        : billingWrapper.tractUrl2;
      tractConfig.X_API_Key__c = billingWrapper.apiKey;
    }
    return tractConfig;
  }

  /**
   * @description: This method provides the default mapping to be used while creating a billing account in GTV.
   * @return AccountMappingWrapper The wrapper to be used on UI.
   */
  @AuraEnabled
  public static AccountMappingWrapper mapDefaultAccount() {
    list<TRACT_Mappings__c> getall = [
      SELECT id, Name, TRACT_Account_Fields__c
      FROM TRACT_Mappings__c
      WHERE Name = 'TRACT Account Mapping'
      LIMIT 1
    ];
    Map<String, Object> mapOfaccountValues = new Map<String, Object>();
    Map<String, String> mapOfaccountFieldsVsValues = new Map<String, String>();
    Map<String, String> mapOfNamesVsStatusValues = new Map<String, String>();
    Map<String, String> mapOfConditionVsValues = new Map<String, String>();
    List<SelectOption> accountCreationStateList = new List<SelectOption>();
    List<SelectOption> conditionsList = new List<SelectOption>();
    Map<String, String> fiedlListMap = new Map<String, String>();
    accountCreationStateList.add(
      new selectOption(
        'Select from the Same Record',
        'Select from the Same Record'
      )
    );
    accountCreationStateList.add(
      new selectOption(
        'Select from the Related List',
        'Select from the Related List'
      )
    );
    conditionsList.add(new selectOption('equals', 'equals'));
    conditionsList.add(new selectOption('starts with', 'starts with'));
    conditionsList.add(new selectOption('ends with', 'ends with'));
    conditionsList.add(new selectOption('contains', 'contains'));
    AccountMappingWrapper wrap = new AccountMappingWrapper();
    if (!getall.isEmpty()) {
      mapOfaccountValues = (Map<String, Object>) JSON.deserializeUntyped(
        getall[0].TRACT_Account_Fields__c
      );
      for (String str : mapOfaccountValues.keySet()) {
        List<Object> strList = (List<Object>) mapOfaccountValues.get(str);
        mapOfaccountFieldsVsValues.put(str, String.valueOf(strList[0]));
        mapOfNamesVsStatusValues.put(str, String.valueOf(strList[1]));
        mapOfConditionVsValues.put(str, String.valueOf(strList[2]));
      }
      wrap.mapOfNamesVsFieldValues = mapOfaccountFieldsVsValues;
      wrap.mapOfNamesVsStatus = mapOfNamesVsStatusValues;
      wrap.mapOfConditionVsValues = mapOfConditionVsValues;
    } else {
      mapOfaccountFieldsVsValues.put('AccountName', 'Name');
      mapOfaccountFieldsVsValues.put('AccountNumber', 'AccountNumber');
      mapOfaccountFieldsVsValues.put('BillingStreet', 'BillingStreet');
      mapOfaccountFieldsVsValues.put('BillingCity', 'BillingCity');
      mapOfaccountFieldsVsValues.put('BillingCode', 'BillingPostalCode');
      mapOfaccountFieldsVsValues.put('BillingState', 'BillingState');
      mapOfaccountFieldsVsValues.put('BillingCountry', 'BillingCountry');
      mapOfaccountFieldsVsValues.put('ShippingStreet', 'ShippingStreet');
      mapOfaccountFieldsVsValues.put('ShippingCity', 'ShippingCity');
      mapOfaccountFieldsVsValues.put('ShippingCode', 'ShippingPostalCode');
      mapOfaccountFieldsVsValues.put('ShippingState', 'ShippingState');
      mapOfaccountFieldsVsValues.put('ShippingCountry', 'ShippingCountry');
      mapOfaccountFieldsVsValues.put('Phone', 'Phone');
      mapOfaccountFieldsVsValues.put('GotransverseEmail', 'TRACT3__Email__c');

      mapOfNamesVsStatusValues.put(
        'AccountName',
        'Select from the Same Record'
      );
      mapOfNamesVsStatusValues.put(
        'AccountNumber',
        'Select from the Same Record'
      );
      mapOfNamesVsStatusValues.put(
        'BillingStreet',
        'Select from the Same Record'
      );
      mapOfNamesVsStatusValues.put(
        'BillingCity',
        'Select from the Same Record'
      );
      mapOfNamesVsStatusValues.put(
        'BillingCode',
        'Select from the Same Record'
      );
      mapOfNamesVsStatusValues.put(
        'BillingState',
        'Select from the Same Record'
      );
      mapOfNamesVsStatusValues.put(
        'BillingCountry',
        'Select from the Same Record'
      );
      mapOfNamesVsStatusValues.put(
        'ShippingStreet',
        'Select from the Same Record'
      );
      mapOfNamesVsStatusValues.put(
        'ShippingCity',
        'Select from the Same Record'
      );
      mapOfNamesVsStatusValues.put(
        'ShippingCode',
        'Select from the Same Record'
      );
      mapOfNamesVsStatusValues.put(
        'ShippingState',
        'Select from the Same Record'
      );
      mapOfNamesVsStatusValues.put(
        'ShippingCountry',
        'Select from the Same Record'
      );
      mapOfNamesVsStatusValues.put('Phone', 'Select from the Same Record');
      mapOfNamesVsStatusValues.put(
        'GotransverseEmail',
        'Select from the Same Record'
      );

      mapOfConditionVsValues.put('AccountName', '');
      mapOfConditionVsValues.put('AccountNumber', '');
      mapOfConditionVsValues.put('BillingStreet', '');
      mapOfConditionVsValues.put('BillingCity', '');
      mapOfConditionVsValues.put('BillingCode', '');
      mapOfConditionVsValues.put('BillingState', '');
      mapOfConditionVsValues.put('BillingCountry', '');
      mapOfConditionVsValues.put('ShippingStreet', '');
      mapOfConditionVsValues.put('ShippingCity', '');
      mapOfConditionVsValues.put('ShippingCode', '');
      mapOfConditionVsValues.put('ShippingState', '');
      mapOfConditionVsValues.put('ShippingCountry', '');
      mapOfConditionVsValues.put('Phone', '');
      mapOfConditionVsValues.put('GotransverseEmail', '');

      wrap.accName = 'Name';
      wrap.accNumber = 'Number';
      wrap.mapOfNamesVsFieldValues = mapOfaccountFieldsVsValues;
      wrap.mapOfNamesVsStatus = mapOfNamesVsStatusValues;
      wrap.mapOfConditionVsValues = mapOfConditionVsValues;
    }
    wrap.accountStateList = accountCreationStateList;

    wrap.setSonditions = conditionsList;

    SObjectType accountType = Schema.getGlobalDescribe().get('Account');
    Map<String, Schema.SObjectField> mfields = accountType.getDescribe()
      .fields.getMap();
    for (String fieldName : mfields.keySet()) {
      if (!mfields.get(fieldName).getDescribe().getReferenceTo().isEmpty()) {
        FiedlListMap.put(
          mfields.get(fieldName).getDescribe().getName(),
          mfields.get(fieldName).getDescribe().getReferenceTo()[0]
            .getDescribe()
            .getName()
        );
      } else {
        FiedlListMap.put(mfields.get(fieldName).getDescribe().getName(), 'No');
      }
    }
    wrap.mapOfNamesVsVales = FiedlListMap;
    wrap.mapOfFieldNameOfObject = getfieldsByObjectName('Contact');
    return wrap;
  }

  /**
   * @description: This method fetch if a field is of lookup type or not.
   * @param ObjectName Salesforce Object Name
   * @return Map<String,String> The Map having Field name as key and lookup object name as value.
   */
  @AuraEnabled
  public static Map<String, String> getfieldsByObjectName(String objectName) {
    Map<String, String> fiedlListMap = new Map<String, String>();
    SObjectType accountType = Schema.getGlobalDescribe().get(objectName);
    Map<String, Schema.SObjectField> mfields = accountType.getDescribe()
      .fields.getMap();
    for (String fName : mfields.keySet()) {
      if (!mfields.get(fName).getDescribe().getReferenceTo().isEmpty()) {
        FiedlListMap.put(
          mfields.get(fName).getDescribe().getName(),
          mfields.get(fName).getDescribe().getReferenceTo()[0]
            .getDescribe()
            .getName()
        );
      } else {
        FiedlListMap.put(mfields.get(fName).getDescribe().getName(), 'No');
      }
    }
    return FiedlListMap;
  }

  /**
   * @description: This method fetch if a field is of lookup type or not.
   * @param ObjectName Salesforce Object Name
   * @param fieldName  Salesforce field Name
   * @return Map<String,String> The Map having Field name as key and lookup object name as value.
   */
  @AuraEnabled
  public static Map<String, String> getObjectFieldValue(
    String objectName,
    String fieldName
  ) {
    Map<String, String> fiedlListMap = new Map<String, String>();
    SObjectType accountType = Schema.getGlobalDescribe().get(ObjectName);
    Map<String, Schema.SObjectField> mfields = accountType.getDescribe()
      .fields.getMap();
    for (String fName : mfields.keySet()) {
      if (!mfields.get(fName).getDescribe().getReferenceTo().isEmpty()) {
        FiedlListMap.put(
          mfields.get(fName).getDescribe().getName(),
          mfields.get(fName).getDescribe().getReferenceTo()[0]
            .getDescribe()
            .getName()
        );
      } else {
        FiedlListMap.put(mfields.get(fName).getDescribe().getName(), 'No');
      }
    }
    return FiedlListMap;
  }

  /**
   * @description: This method inserts the mapping provided by the user to be used while creating a billing account in GTV.
   * @param infoWrap serialized AccountMappingWrapper Instance
   * @return String The error message to be shown to the user on UI
   */
  @AuraEnabled
  public static String saveAccountFields(String infoWrap) {
    String error = 'NoError';
    Map<String, list<String>> mapOfaccountFieldsVsValues = new Map<String, list<String>>();
    AccountMappingWrapper accWrapper = (AccountMappingWrapper) JSON.deserialize(
      infoWrap,
      AccountMappingWrapper.class
    );
    for (String str : accWrapper.mapOfNamesVsFieldValues.keySet()) {
      list<String> newStrList = new List<String>();
      newStrList.add(accWrapper.mapOfNamesVsFieldValues.get(str));
      newStrList.add(accWrapper.mapOfNamesVsStatus.get(str));
      newStrList.add(accWrapper.mapOfConditionVsValues.get(str));
      mapOfaccountFieldsVsValues.put(str, newStrList);
    }
    list<TRACT_Mappings__c> mapTract = [
      SELECT id, Name, TRACT_Account_Fields__c
      FROM TRACT_Mappings__c
      WHERE Name = 'TRACT Account Mapping'
      LIMIT 1
    ];
    if (mapTract.isEmpty()) {
      TRACT_Mappings__c tractMap = new TRACT_Mappings__c();
      tractMap.Name = 'TRACT Account Mapping';
      tractMap.TRACT_Account_Fields__c = json.serialize(
        mapOfaccountFieldsVsValues
      );
      insert tractMap;
    } else {
      try {
        mapTract[0].TRACT_Account_Fields__c = json.serialize(
          mapOfaccountFieldsVsValues
        );
        update mapTract;
      } catch (Exception e) {
        return e.getMessage();
      }
    }
    return error;
  }

  /**
   * @description: Check if the mapping for account number left blank.
   * @param accWrapper AccountMappingWrapper Instance
   * @return String The error message to be shown to the user on UI
   */
  @AuraEnabled
  public static String mapAccountNumber(AccountMappingWrapper accWrapper) {
    String error = 'NoError';
    if (accWrapper.accNumber == null || accWrapper.accNumber == '') {
      return 'One or both of the fields is left blank or null';
    }
    return error;
  }
  public static void scheduleBatch() {
    list<CronTrigger> job = [
      SELECT Id, CronJobDetail.Id, CronJobDetail.Name, CronJobDetail.JobType
      FROM CronTrigger
      WHERE CronJobDetail.Name = 'Gotransverse Batch Sync'
      ORDER BY CreatedDate DESC
      LIMIT 1
    ];
    system.debug('job::::' + job);
    system.debug('jobSize::::' + job.size());
    if (job.size() == 0) {
      TractBatchCleanProducts cleanBatch = new TractBatchCleanProducts();
      // Seconds Minutes Hours Day_of_month Month Day_of_week optional_year
      String cronTime = '0 0 0 ? * * *';
      String jobID = System.schedule(
        'Gotransverse Batch Sync',
        cronTime,
        cleanBatch
      );
    }
  }
  @AuraEnabled
  public static void getOpportunityField(GTVBillingWrapper billingWrapper) {
    list<SelectOption> oppList = new List<SelectOption>();
    oppList.add(new SelectOption('', 'Choose One'));
    Map<string, String> opportunityFieldNameVSType = new Map<string, string>();
    SObjectType opportunityType = Schema.getGlobalDescribe().get('Opportunity');
    Map<String, Schema.SObjectField> oppFields = opportunityType.getDescribe()
      .fields.getMap();
    for (string fieldName : oppFields.keySet()) {
      opportunityFieldNameVSType.put(
        oppFields.get(fieldName).getDescribe().getName(),
        oppFields.get(fieldName).getDescribe().getType().Name()
      );
      oppList.add(
        new SelectOption(
          oppFields.get(fieldName).getDescribe().getName(),
          oppFields.get(fieldName).getDescribe().getLabel()
        )
      );
    }
    billingWrapper.changeOrderIndicatorList = oppList;
    billingWrapper.opportunityFieldNameVSType = opportunityFieldNameVSType;
    //System.debug('oppList::::'+oppList);
    //return oppList;
  }

  @AuraEnabled
  public static List<SelectOption> getPicklistValues(
    String objectName,
    String fieldName
  ) {
    List<SelectOption> pickListValuesList = new List<SelectOption>();
    pickListValuesList.add(new SelectOption('', 'Choose One'));
    SObjectType objectType = Schema.getGlobalDescribe().get(objectName);
    Map<String, Schema.SObjectField> fields = objectType.getDescribe()
      .fields.getMap();
    Schema.DescribeFieldResult fieldResult = Fields.get(fieldName)
      .getDescribe();
    List<Schema.PicklistEntry> ple = fieldResult.getPicklistValues();
    for (Schema.PicklistEntry pickListVal : ple) {
      pickListValuesList.add(
        new selectOption(pickListVal.getLabel(), pickListVal.getLabel())
      );
    }
    system.debug('pickListValuesList::::::' + pickListValuesList);
    return pickListValuesList;
  }

  @AuraEnabled
  public static List<SelectOption> getRecordType(String objectName) {
    List<SelectOption> recordTypeList = new List<SelectOption>();
    recordTypeList.add(new SelectOption('', 'Choose One'));
    for (RecordType recordType : [
      SELECT id, Name, DeveloperName
      FROM recordType
      WHERE SobjectType = :ObjectName
    ]) {
      recordTypeList.add(new selectOption(recordType.id, recordType.Name));
    }
    system.debug('recordTypeList::::::' + recordTypeList);
    return recordTypeList;
  }
}