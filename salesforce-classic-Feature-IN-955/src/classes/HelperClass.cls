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
 * This class provides methods that return the object instance to be used in test classes.
 * @author AMAN JAIN
 */

public with sharing class HelperClass {
  /**
   * get TRACT_Setup__c object
   * @return tractSetup
   * */
  public static TRACT_Setup__c getTract() {
    TRACT_Setup__c tractSetup = new TRACT_Setup__c();
    tractSetup.name = 'tract';
    tractSetup.TPassword__c = 'tpass';
    tractSetup.Tract_User_Name__c = ' username ';
    tractSetup.TRACT_URL__c = 'https://tract-qa2.gotransverse.com/t/s/billing/1.28?wsdl';
    tractSetup.Active__c = true;
    tractSetup.Description__c = 'description';
    tractSetup.OrderStatus__c = 'DRAFT';
    tractSetup.Api_Version__c = '30';
    return tractSetup;
  }
  /**
   * get TRACT_Setup__c object for soap api
   * @return tractSetup
   * */
  public static TRACT_Setup__c getAPI1TRACT() {
    TRACT_Setup__c tractSetup = new TRACT_Setup__c();
    tractSetup.name = 'tract';
    tractSetup.TPassword__c = 'tpass';
    tractSetup.Tract_User_Name__c = ' username ';
    tractSetup.TRACT_URL__c = 'https://tract-qa2.gotransverse.com/t/s/billing/1.28?wsdl';
    tractSetup.Active__c = true;
    tractSetup.Description__c = 'description';
    tractSetup.OrderStatus__c = 'FINAL';
    tractSetup.Api_Version__c = 'API Version 1.0';
    tractSetup.Active__c = true;
    system.assert(tractSetup != null);
    return tractSetup;
  }
  /**
   * get TRACT_Setup__c object for rest api
   * @return tractSetup
   * */
  public static TRACT_Setup__c getAPI2TRACT() {
    TRACT_Setup__c tractSetup = new TRACT_Setup__c();
    tractSetup.name = 'tract';
    tractSetup.TPassword__c = 'tpass';
    tractSetup.Tract_User_Name__c = ' username ';
    tractSetup.TRACT_URL__c = 'https://tract-qa2.gotransverse.com/t/s/billing/1.28?wsdl';
    tractSetup.TRACT_URL2_0__c = 'https://customer-solutions-api.gotransverse.com/billing/2';
    tractSetup.Active__c = true;
    tractSetup.Description__c = 'description';
    tractSetup.OrderStatus__c = 'DRAFT';
    tractSetup.Api_Version__c = 'API Version 2.0';
    tractSetup.Active__c = true;
    tractSetup.Change_Order_Indicator__c = 'stageName';
    tractSetup.Change_Order_Indicator_Value__c = 'Qualification';
    system.assert(tractSetup != null);
    return tractSetup;
  }
  //get Account object
  /**
   * get Account object
   * @return account
   * */
  public static Account getAccount() {
    Account account = (Account) SmartFactory.createSObject('Account');
    account.Name = 'Test1';
    account.Tract_Billing_Account__c = '599';
    account.Name = 'account';
    account.Currency_Type__c = 'USD';
    account.BillingStreet = 'bstreet';
    account.BillingCity = 'bcity';
    account.BillingPostalCode = 'bpcode';
    account.BillingState = 'Texas';
    account.BillingCountry = 'United States';
    account.ShippingStreet = 'sstreet';
    account.ShippingCity = 'scity';
    account.ShippingPostalCode = 'spcod';
    account.ShippingState = 'Texas';
    account.ShippingCountry = 'United States';
    account.Phone = 'aphone';
    account.Tract_Billing_Account__c = '12345678';
    account.Email__c = 'ravi.6380@yahoo.com';
    return account;
  }
  /**
   * get Opportunity object
   * @return OpportunityObject
   * */
  public static Opportunity getOpportunity() {
    Opportunity opportunityObject = (Opportunity) SmartFactory.createSObject(
      'Opportunity'
    );
    opportunityObject.Name = 'test';
    opportunityObject.Amount = 12345;
    opportunityObject.CloseDate = date.valueOf('2012-05-04');
    opportunityObject.Description = 'description';
    opportunityObject.Probability = .5;
    opportunityObject.StageName = 'new';
    opportunityObject.Type = 'objectType';
    opportunityObject.LeadSource = 'lsource';
    opportunityObject.NextStep = 'nstep';
    opportunityObject.Tract_Sales_Order__c = 'TRACT GENERATED';
    opportunityObject.Pricebook2Id = null;
    return opportunityObject;
  }

  /**
   * get getPriceBook2 object
   * @return pb2
   * */
  public static PriceBook2 getPriceBook2() {
    PriceBook2 pb2 = new PriceBook2(
      Name = 'GTV USD Price Book',
      Description = 'test'
    );
    return pb2;
  }
  /**
   * get PricebookEntry object
   * @return pricebookEntry
   * */
  public static PricebookEntry getPricebookEntry() {
    PricebookEntry pricebookEntry = (PricebookEntry) SmartFactory.createSObject(
      'PricebookEntry'
    );
    pricebookEntry.UnitPrice = 10000;
    pricebookEntry.IsActive = true;
    return pricebookEntry;
  }
  /**
   * get Service_Resource__c object
   * @return serviceresource
   * */
  public static Service_Resource__c getServiceresource() {
    Service_Resource__c serviceresource = new Service_Resource__c();
    serviceresource.eid__c = '12345';
    serviceresource.Name = 'serviceresource';
    serviceresource.IsActive__c = true;
    serviceresource.Status__c = 'open';
    serviceresource.Category_Name__c = 'category';
    System.assert(serviceresource != null);
    return serviceresource;
  }

  /**
   * get Product2 object
   * @return tempProductObj
   * */
  public static Product2 getProduct2() {
    Product2 tempProductObj = new Product2();
    tempProductObj.Name = 'test';
    tempProductObj.IsActive = true;
    tempProductObj.eid__c = '12345';
    tempProductObj.PriceOverride__c = true;
    tempProductObj.Requires_Agreement__c = true;
    tempProductObj.ProductCode = 'productcode';
    tempProductObj.minServiceResources__c = 10;
    tempProductObj.Price_Information__c =
      '[{ "priceType":"Recurring","thruDate":"' +
      System.now() +
      '","scheduledCharges":false,"recurringPaymentRequired":false,"recurrencePeriod":"MONTH","priceType":"OneTime","priceRangesList":[{"quantityEndRange":null,"quantityBeginRange":0.00,"price":100.00,"level":1,"eid":"14702","currencyType":"USD"}],"priceOverride":true,"priceListEid":"696","paymentOnPurchaseRequired":false,"fromDate":"2014-11-07T06:00:00.000Z","eid":"13700","currencyType":"USD"},{"thruDate":null,"scheduledCharges":false,"recurringPaymentRequired":false,"recurrencePeriod":"BILLCYCLE","priceType":"Recurring","priceRangesList":[{"quantityEndRange":1.00,"quantityBeginRange":0.00,"price":5.00,"level":1,"eid":"47138","currencyType":"USD"},{"quantityEndRange":null,"quantityBeginRange":1.00,"price":0.00,"level":2,"eid":"47140","currencyType":"USD"}],"priceOverride":true,"priceListEid":"228","paymentOnPurchaseRequired":false,"fromDate":"2018-08-30T05:00:00.000Z","eid":"43272","currencyType":"USD"}]';
    tempProductObj.Agreement_Information__c = '[{"terminationFlatCharge":"$0.0","status":"ACTIVE","prorateOnCancel":null,"Name":"Agreement 1!","maxTerminationFlatCharge":null,"isSelected":null,"endAction":"RENEW_AGREEMENT","eid":"4316","currencyType":"USD","agreementPeriodType":"MONTHs","agreementPeriod":3,"adjustmentCategory":"Default Adjustment Category"}]';
    tempProductObj.maxServiceResources__c = 10;
    tempProductObj.PriceLists__c = 'test:12345';
    system.assert(tempProductObj != null);
    return tempProductObj;
  }

  /**
   * get OpportunityLineItem object
   * @return opportunityLineItem_obj
   * */
  public static OpportunityLineItem getOpportunityLineItem() {
    Product2 tempProductObj = (Product2) SmartFactory.createSObject('Product2');
    tempProductObj.name = 'test';
    system.assert(tempProductObj != null);
    insert tempProductObj;
    Pricebook2 pricebook = new Pricebook2(
      Name = 'Standard Price Book',
      Description = 'Price Book 2009 Products',
      IsActive = true
    );
    system.assert(pricebook != null);
    pricebook.CurrencyType__c = 'USD';
    insert pricebook;
    Opportunity opportunity = getOpportunity();
    opportunity.Pricebook2Id = pricebook.Id;
    insert opportunity;
    Id pricebookId = Test.getStandardPricebookId();
    PricebookEntry pricebookEntry_obj = (PricebookEntry) SmartFactory.createSObject(
      'PricebookEntry'
    );
    pricebookEntry_obj.Pricebook2Id = pricebookId;
    pricebookEntry_obj.Product2Id = tempProductObj.Id;
    pricebookEntry_obj.product2 = tempProductObj;
    pricebookEntry_obj.UnitPrice = 10000;
    pricebookEntry_obj.IsActive = true;
    system.assert(pricebookEntry_obj != null);
    insert pricebookEntry_obj;
    pricebookEntry_obj = (PricebookEntry) SmartFactory.createSObject(
      'PricebookEntry'
    );
    pricebookEntry_obj.Pricebook2Id = pricebook.id;
    pricebookEntry_obj.Product2Id = tempProductObj.Id;
    pricebookEntry_obj.product2 = tempProductObj;
    pricebookEntry_obj.UnitPrice = 10000;
    pricebookEntry_obj.IsActive = true;
    system.assert(pricebookEntry_obj != null);
    insert pricebookEntry_obj;
    Service_Resource__c sResource = new Service_Resource__c();
    sResource.Name = 'sresource';
    sResource.Status__c = 'status';
    insert sResource;
    OpportunityLineItem opportunityLineItem_obj = (OpportunityLineItem) SmartFactory.createSObject(
      'OpportunityLineItem'
    );
    opportunityLineItem_obj.PricebookEntryId = PricebookEntry_obj.id;
    opportunityLineItem_obj.TotalPrice = 2000;
    opportunityLineItem_obj.Quantity = 2;
    opportunityLineItem_obj.eid__c = '12345';
    opportunityLineItem_obj.username__c = 'user';
    opportunityLineItem_obj.Email__c = 'ravi.6380@yahoo.com';
    opportunityLineItem_obj.RecurringPrice__c = 100;
    opportunityLineItem_obj.OneTimePrice__c = 500;
    opportunityLineItem_obj.Service_Resource__c = sResource.Id;
    opportunityLineItem_obj.OpportunityId = opportunity.Id;
    return opportunityLineItem_obj;
  }

  /**
   * get OpportunityLineItem object
   * @return opportunityLineItem_obj
   * */
  public static OpportunityLineItem getOpportunityLineItem1() {
    OpportunityLineItem opportunityLineItem_obj = (OpportunityLineItem) SmartFactory.createSObject(
      'OpportunityLineItem'
    );
    opportunityLineItem_obj.TotalPrice = 2000;
    opportunityLineItem_obj.Quantity = 2;
    opportunityLineItem_obj.eid__c = '12345';
    opportunityLineItem_obj.username__c = 'user';
    opportunityLineItem_obj.Email__c = 'ravi.6380@yahoo.com';
    opportunityLineItem_obj.RecurringPrice__c = 100;
    opportunityLineItem_obj.OneTimePrice__c = 500;
    return opportunityLineItem_obj;
  }

  /**
   * get Service__c object
   * @return service
   * */
  public static Service__c getServicec() {
    Service__c service = new Service__c();
    service.Amount_WC__c = 1000;
    service.Amount__c = 1000;
    service.checkDeactivate__c = true;
    service.Service_Amount__c = 1000;
    service.RenewAction__c = 'action';
    service.ServiceEid__c = 'service';
    service.Status__c = 'status';
    return service;
  }
  /**
   * get Account_Custom_Field__c object
   * @return aCustomField
   * */
  public static Account_Custom_Field__c getAccountCustomField() {
    Account_Custom_Field__c aCustomField = new Account_Custom_Field__c();
    aCustomField.Name = 'accountCustomField';
    aCustomField.accountNum__c = 'sresource';
    aCustomField.activeTrigger__c = 'status';
    aCustomField.eid__c = '12345';
    aCustomField.Value__c = 'value';
    return aCustomField;
  }
  /**
   * get System_Setting__c object
   * @return settings
   * */
  public static System_Setting__c getSystemSettings() {
    System_Setting__c settings = new System_Setting__c(
      name = 'Currency Identification',
      Value__c = 'ISO Code'
    );
    system.assert(settings != null);
    return settings;
  }
  /**
   * get Price_List__c object
   * @return priceList
   * */
  public static Price_List__c getPricelist() {
    Price_List__c priceList = new Price_List__c();
    priceList.Name = 'Default Price List';
    priceList.eid__c = '2732';
    system.assert(priceList != null);
    return priceList;
  }
  /**
   * get TRACTBillingAccountCategory__c object
   * @return tractBilling
   * */
  public static TRACTBillingAccountCategory__c getAccountCategory() {
    TRACTBillingAccountCategory__c tractBilling = new TRACTBillingAccountCategory__c(
      name = 'testBill',
      description__c = 'testDescription',
      type_x__c = 'testType'
    );
    System.assert(tractBilling != null);
    return tractBilling;
  }
  /**
   * get TRACT_Bill_Cycle__c object
   * @return billcycle
   * */
  public static TRACT_Bill_Cycle__c getBillCycle() {
    TRACT_Bill_Cycle__c billcycle = new TRACT_Bill_Cycle__c(
      name = 'testBill',
      Eid__c = '1234'
    );
    System.assert(billcycle != null);
    return billcycle;
  }
  /**
   * get Payment_Term__c object
   * @return paymentTerms
   * */
  public static Payment_Term__c getPaymentTerms() {
    Payment_Term__c paymentTerms = new Payment_Term__c(
      name = 'Net 30',
      eid__c = '5'
    );
    System.assert(paymentTerms != null);
    return paymentTerms;
  }
}