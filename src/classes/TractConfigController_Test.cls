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
 * This class is a test class of TractConfigController class.
 * @author Aman Jain
 */

@isTest
public with sharing class TractConfigController_Test {
  @isTest
  public static void myunitTest() {
    TRACT_Setup__c tractSetup = HelperClass.getAPI2TRACT();
    insert tractSetup;

    Account newAccount = HelperClass.getAccount();
    newAccount.Name = 'TRACT Account Mapping';
    insert newAccount;

    /*TRACT_Mappings__c tractMap = new TRACT_Mappings__c();
        tractMap.Name ='TRACT Account Mapping';
        tractMap.TRACT_Account_Fields__c = 'TSet';
        
        insert tractMap;*/

    product2 prod = new product2();
    prod.Name = 'Test';
    prod.eid__c = '1234';
    system.assert(prod != null);
    insert prod;

    List<SelectOption> options = new List<SelectOption>();
    options.add(new SelectOption('US', 'US'));
    options.add(new SelectOption('CANADA', 'Canada'));
    options.add(new SelectOption('MEXICO', 'Mexico'));

    GTVBillingWrapper billingWrapper = new GTVBillingWrapper();
    billingWrapper.tractUrl = 'https://qlik.tract-staging.com/t/s/billing/1.30?wsdl';
    billingWrapper.userName = 'testUser';
    billingWrapper.password = 'password';
    billingWrapper.tractUrl2 = 'https://qlik.tract-staging.com/t/s/billing/1.30?wsdl';
    billingWrapper.selectedAPIVersion = 'API Version 2.0';
    billingWrapper.apiKey = '1454564gd555555555555';
    billingWrapper.orderStatusValue = 'DRAFT';
    billingWrapper.selectedAccountCustomFieldId = 'External Account Number';
    billingWrapper.accountCreationStateValue = 'Automatically When a Salesforce Account is saved';
    billingWrapper.tract = tractSetup;
    system.assert(billingWrapper != null);

    List<PermSetWrapper> testlist = new List<PermSetWrapper>();
    PermSetWrapper testobj = new PermSetWrapper();
    testobj.getsets = 'Sales';
    testobj.Name = 'Show Invoice Section';
    testobj.Status = true;
    testobj.Order = 1;
    testlist.add(testobj);
    system.assert(testlist != null);

    String val = JSON.serialize(testlist);
    GetPermissionSet__c newval = new GetPermissionSet__c(
      Name = 'Show Invoice Section',
      SetName__c = 'Sales',
      SetStatus__c = true,
      Order_by__c = 1
    );
    system.assert(newval != null);
    insert newval;

    Test.startTest();
    TractConfigurationController.getPermissionSetList();
    TractConfigurationController.getGTVBillingWrap();
    TractConfigurationController.validatelist('Sales');
    TractConfigurationController.validatelist('TRACT_Permission');
    TractConfigurationController.validatelist('');
    TractConfigurationController.Submit(JSON.serialize(billingWrapper));
    TractConfigurationController.getupdatedPermissionSetlist(
      JSON.serialize(testlist)
    );
    TractConfigurationController.getGTVEntities(JSON.serialize(billingWrapper));
    TractConfigurationController.ApiConnectionTest(
      JSON.serialize(billingWrapper)
    );
    TractConfigurationController.syncTRACTInformation();
    TractConfigurationController.getObjectFieldValue('Account', 'Name');
    TractConfigurationController.getObjectFieldValue(
      'Account',
      'MasterRecordId'
    );
    TractConfigurationController.getRecordType('Opportunity');
    TractConfigurationController.getPicklistValues('Opportunity', 'Name');
    TractConfigurationController.ScheduleBatch();
    try {
      billingWrapper.tractUrl2 = null;
      TractConfigurationController.validateGTVDetails(billingWrapper);
      billingWrapper.tractUrl2 = 'https://qlik.tract-staging.com/t/s/billing/1.30?wsdl';
    } catch (exception e) {
    }
    try {
      billingWrapper.apiKey = null;
      TractConfigurationController.validateGTVDetails(billingWrapper);
      billingWrapper.apiKey = '1454564gd555555555555';
    } catch (exception e) {
    }

    AccountMappingWrapper wrap = new AccountMappingWrapper();
    TractConfigurationController.mapAccountNumber(wrap);

    //list<TRACT_Mappings__c> listToDelete = [ Select id,Name,TRACT_Account_Fields__c from TRACT_Mappings__c where Name='TRACT Account Mapping' limit 1];
    //delete listToDelete;
    //TractConfigurationController.mapDefaultAccount();

    // string whereclause = ' AccountId=:'+newAccount.Id;
    //String strId = Id.valueOf(newAccount.Id);
    //TractConfigurationController.getAccountFieldValue(strId,'Name',wrap,whereclause);
    //TractConfigurationController.showFieldList();
    Test.stopTest();
  }
  @isTest
  public static void myunitTest2() {
    TRACT_Setup__c tractSetup = HelperClass.getTract();
    insert tractSetup;

    List<SelectOption> options = new List<SelectOption>();
    options.add(new SelectOption('US', 'US'));
    options.add(new SelectOption('CANADA', 'Canada'));
    options.add(new SelectOption('MEXICO', 'Mexico'));
    map<String, String> mapOfNamesVsFieldValues = new Map<String, String>();
    mapOfNamesVsFieldValues.put('AccountName', 'Contact.Name');
    mapOfNamesVsFieldValues.put('AccountNumber', 'AccountNumber');
    mapOfNamesVsFieldValues.put('BillingStreet', 'BillingStreet');

    map<String, String> mapOfConditionVsValues = new Map<String, String>();
    mapOfConditionVsValues.put('AccountName', 'Name starts with test');
    mapOfConditionVsValues.put('AccountNumber', '');
    mapOfConditionVsValues.put('BillingStreet', '');

    map<String, String> mapOfNamesVsStatus = new Map<String, String>();
    mapOfNamesVsStatus.put('AccountName', 'Select from the Related List');
    mapOfNamesVsStatus.put('AccountNumber', 'Select from the Same Record');
    mapOfNamesVsStatus.put('BillingStreet', 'Select from the Same Record');

    AccountMappingWrapper accMap = new AccountMappingWrapper();
    accMap.mapOfNamesVsFieldValues = mapOfNamesVsFieldValues;
    accMap.mapOfConditionVsValues = mapOfConditionVsValues;
    accMap.mapOfNamesVsStatus = mapOfNamesVsStatus;

    GTVBillingWrapper billingWrapper = new GTVBillingWrapper();
    billingWrapper.tractUrl = 'https://qlik.tract-staging.com/t/s/billing/1.30?wsdl';
    billingWrapper.userName = 'testUser';
    billingWrapper.password = 'password';
    billingWrapper.tractUrl2 = 'https://qlik.tract-staging.com/t/s/billing/1.30?wsdl';
    billingWrapper.selectedAPIVersion = 'API Version 2.0';
    billingWrapper.apiKey = '1454564gd555555555555';
    billingWrapper.orderStatusValue = 'DRAFT';
    billingWrapper.selectedAccountCustomFieldId = 'External Account Number';
    billingWrapper.accountCreationStateValue = 'Automatically When a Salesforce Account is saved';
    billingWrapper.accountMappingWrapper = accMap;
    system.assert(billingWrapper != null);
    TractConfigurationController.Submit(JSON.serialize(billingWrapper));
  }

  @isTest
  public static void myunitTest3() {
    TRACT_Setup__c tractSetup = HelperClass.getAPI1TRACT();
    insert tractSetup;

    List<SelectOption> options = new List<SelectOption>();
    options.add(new SelectOption('US', 'US'));
    options.add(new SelectOption('CANADA', 'Canada'));
    options.add(new SelectOption('MEXICO', 'Mexico'));

    GTVBillingWrapper billingWrapper = new GTVBillingWrapper();
    billingWrapper.tractUrl = 'https://qlik.tract-staging.com/t/s/billing/1.30?wsdl';
    billingWrapper.userName = 'testUser';
    billingWrapper.password = 'password';
    billingWrapper.tractUrl2 = 'https://qlik.tract-staging.com/t/s/billing/1.30?wsdl';
    billingWrapper.selectedAPIVersion = 'API Version 1.0';
    billingWrapper.apiKey = '1454564gd555555555555';
    billingWrapper.orderStatusValue = 'DRAFT';
    billingWrapper.selectedAccountCustomFieldId = 'External Account Number';
    billingWrapper.accountCreationStateValue = 'Automatically When a Salesforce Account is saved';
    billingWrapper.tract = tractSetup;
    system.assert(billingWrapper != null);

    List<PermSetWrapper> testlist = new List<PermSetWrapper>();
    PermSetWrapper testobj = new PermSetWrapper();
    testobj.getsets = 'Sales';
    testobj.Name = 'Show Invoice Section';
    testobj.Status = true;
    testobj.Order = 1;
    testlist.add(testobj);
    String val = JSON.serialize(testlist);

    TRACT_Mappings__c maptract = new TRACT_Mappings__c();
    maptract.name = 'TRACT Account Mapping';
    maptract.TRACT_Account_Fields__c = '{ "AccountName":[ "Contact.Name", "Select from the Related List", "Name starts with test" ], "AccountNumber":[ "ParentId.AccountNumber", "Select from the Same Record", "" ], "BillingStreet":[ "BillingStreet", "Select from the Same Record", "" ], "BillingCity":[ "Contact.MailingCity", "Select from the Related List", "MailingCity equals test" ], "BillingCode":[ "Contact.MailingPostalCode", "Select from the Related List", "MailingPostalCode contains 1234" ], "BillingState":[ "BillingState", "Select from the Same Record", "" ], "BillingCountry":[ "Contact.MailingCountry", "Select from the Related List", "MailingCountry ends with test" ], "ShippingStreet":[ "ShippingStreet", "Select from the Same Record", "" ], "ShippingCity":[ "ShippingCity", "Select from the Same Record", "" ], "ShippingCode":[ "ShippingPostalCode", "Select from the Same Record", "" ], "ShippingState":[ "ShippingState", "Select from the Same Record", "" ], "ShippingCountry":[ "ShippingCountry", "Select from the Same Record", "" ], "Phone":[ "Phone", "Select from the Same Record", "" ], "GotransverseEmail":[ "TRACT3__Email__c", "Select from the Same Record", "" ] }';
    insert maptract;
    map<String, String> mapOfNamesVsFieldValues = new Map<String, String>();
    mapOfNamesVsFieldValues.put('AccountName', 'Contact.Name');
    mapOfNamesVsFieldValues.put('AccountNumber', 'AccountNumber');
    mapOfNamesVsFieldValues.put('BillingStreet', 'BillingStreet');

    map<String, String> mapOfConditionVsValues = new Map<String, String>();
    mapOfConditionVsValues.put('AccountName', 'Name starts with test');
    mapOfConditionVsValues.put('AccountNumber', '');
    mapOfConditionVsValues.put('BillingStreet', '');

    map<String, String> mapOfNamesVsStatus = new Map<String, String>();
    mapOfNamesVsStatus.put('AccountName', 'Select from the Related List');
    mapOfNamesVsStatus.put('AccountNumber', 'Select from the Same Record');
    mapOfNamesVsStatus.put('BillingStreet', 'Select from the Same Record');

    AccountMappingWrapper accMap = new AccountMappingWrapper();
    accMap.mapOfNamesVsFieldValues = mapOfNamesVsFieldValues;
    accMap.mapOfConditionVsValues = mapOfConditionVsValues;
    accMap.mapOfNamesVsStatus = mapOfNamesVsStatus;

    billingWrapper.accountMappingWrapper = accMap;

    GetPermissionSet__c newval = new GetPermissionSet__c(
      Name = 'Show Invoice Section',
      SetName__c = 'Sales',
      SetStatus__c = true,
      Order_by__c = 1
    );
    system.assert(newval != null);
    insert newval;

    Test.startTest();
    TractConfigurationController.getPermissionSetList();
    TractConfigurationController.getGTVBillingWrap();
    TractConfigurationController.validatelist('Sales');
    TractConfigurationController.Submit(JSON.serialize(billingWrapper));
    TractConfigurationController.getupdatedPermissionSetlist(
      JSON.serialize(testlist)
    );
    TractConfigurationController.getGTVEntities(JSON.serialize(billingWrapper));
    TractConfigurationController.ApiConnectionTest(
      JSON.serialize(billingWrapper)
    );

    try {
      billingWrapper.tractUrl = null;
      TractConfigurationController.validateGTVDetails(billingWrapper);
      billingWrapper.tractUrl = 'https://qlik.tract-staging.com/t/s/billing/1.30?wsdl';
    } catch (exception e) {
    }
    try {
      billingWrapper.userName = null;
      TractConfigurationController.validateGTVDetails(billingWrapper);
      billingWrapper.userName = 'testUser';
    } catch (exception e) {
    }
    try {
      billingWrapper.password = null;
      TractConfigurationController.validateGTVDetails(billingWrapper);
      billingWrapper.password = 'password';
    } catch (exception e) {
    }
    Test.stopTest();
  }
}