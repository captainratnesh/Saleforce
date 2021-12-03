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
 * This class is a test class of TractOppProductSimple class.
 * @author Aman Jain
 */

@isTest
public with sharing class TractOppProductSimple_Test {
  @isTest
  public static void myunitTest4() {
    Account acc = new Account();
    acc.Name = 'test';
    acc.Tract_Billing_Account__c = '1234';
    insert acc;
    Pricebook2 pb22 = new Pricebook2(Name = 'TRACT EUR', IsActive = true);
    insert pb22;
    ProductAgreementWrapper agreementWrapper = new ProductAgreementWrapper();
    list<ProductAgreementWrapper> agreementWrapperList = new List<ProductAgreementWrapper>();

    agreementWrapper.Name = 'Test Agreement';
    agreementWrapper.agreementPeriod = 2;
    agreementWrapper.agreementPeriodType = 'Months';
    agreementWrapper.endAction = 'RENEW_AGREEMENT';
    agreementWrapper.terminationFlatCharge = '$5';
    agreementWrapper.adjustmentCategory = 'Test';
    agreementWrapper.currencyType = 'USD';
    agreementWrapper.eid = '1234';
    agreementWrapperList.add(agreementWrapper);
    ProductPriceWrapper priceWrapeer = new ProductPriceWrapper();
    product2[] prodList = new List<product2>();
    product2 prod = new product2();
    prod.Name = 'test';
    prod.PriceLists__c = 'test:12345';
    prod.eid__c = '35299';
    prod.IsActive = true;
    prod.description = 'testdescription';
    prod.ProductCode = 'Add-on';
    prod.RuleType__c = 'Test';
    prod.RuleOverride__c = false;
    prod.Agreement_Information__c = JSON.serialize(agreementWrapperList);
    prodList.add(prod);
    insert prodList;
    Id pricebookId = Test.getStandardPricebookId();
    PricebookEntry standardPrice = new PricebookEntry(
      Pricebook2Id = pricebookId,
      Product2Id = prod.Id,
      UnitPrice = 10000,
      IsActive = true
    );
    insert standardPrice;
    PricebookEntry pbe2 = new PricebookEntry(
      unitprice = 1,
      Product2Id = prod.Id,
      Pricebook2Id = pb22.id,
      isActive = true
    );
    insert pbe2;
    Opportunity opp = new Opportunity();
    opp.Name = 'test';
    opp.stageName = 'Qualification';
    opp.Tract_Sales_Order__c = 'test';
    opp.Pricebook2Id = pb22.id;
    opp.AccountId = acc.id;
    opp.closeDate = system.today();
    insert opp;
    List<string> proName = new List<string>();
    string pro = 'EUR';
    string pro1 = 'EUR';
    proName.add(pro);
    proName.add(pro1);
    // List<OpportunityLineItem>OPplineitemList = new List<OpportunityLineItem>();
    OpportunityLineItem oppLineItem2 = new OpportunityLineItem(
      Quantity = 25,
      OpportunityId = opp.Id,
      UnitPrice = 1,
      PriceBookEntryId = pbe2.Id,
      productEid__c = 32933
    );
    insert oppLineItem2;

    List<ProductPriceWrapper> ppList = new List<ProductPriceWrapper>();
    ProductPriceWrapper pp = new ProductPriceWrapper();
    pp.priceType = 'Recurring';
    pp.eid = '2342';
    pp.thruDate = system.today();
    pp.fromDate = system.today();
    pp.currencyType = 'USD';
    pp.priceListEid = '2732';
    pp.recurrencePeriod = 'Month';
    pp.scheduledCharges = false;
    pp.priceOverride = false;
    ProductPriceRangeWrapper priceRange = new ProductPriceRangeWrapper();
    priceRange.price = 20;
    priceRange.quantityBeginRange = 1;
    priceRange.quantityEndRange = 20;
    List<ProductPriceRangeWrapper> priceRangeList = new List<ProductPriceRangeWrapper>();
    priceRangeList.add(priceRange);
    pp.priceRangesList = priceRangeList;
    ppList.add(pp);
    ProductPriceWrapper pp2 = new ProductPriceWrapper();
    pp2.priceType = 'OneTime';
    pp2.eid = '2342';
    pp2.thruDate = system.today();
    pp2.currencyType = 'USD';
    pp2.priceListEid = '2732';
    pp2.recurrencePeriod = 'Month';
    pp2.scheduledCharges = false;
    pp2.priceOverride = false;
    pp2.priceRangesList = priceRangeList;
    ppList.add(pp2);
    prod.Price_Information__c = JSON.serialize(ppList);
    update prod;
    TRACT_Setup__c tractSetup = new TRACT_Setup__c();
    tractSetup.name = 'tract';
    tractSetup.TPassword__c = 'tpass';
    tractSetup.Tract_User_Name__c = ' username ';
    tractSetup.TRACT_URL__c = 'https://tract-qa2.gotransverse.com/t/s/billing/1.28?wsdl';
    tractSetup.Active__c = true;
    tractSetup.Description__c = 'description';
    tractSetup.OrderStatus__c = 'DRAFT';
    tractSetup.Api_Version__c = 'API Version 1.0';
    insert tractSetup;
    Tract_Service_Custom_Field__c serv = new Tract_Service_Custom_Field__c();
    serv.StoreListValue__c = '10';
    serv.FieldType__c = 'LIST';
    insert serv;
    list<TractOppProductSimple.serviceCustomFieldValuesWrapper> serviceCustomFieldValuesWrapperList = new List<TractOppProductSimple.serviceCustomFieldValuesWrapper>();
    TractOppProductSimple.serviceCustomFieldValuesWrapper serviceCustomFieldValuesWrapper = new TractOppProductSimple.serviceCustomFieldValuesWrapper();
    serviceCustomFieldValuesWrapper.Name = 'TestName';
    serviceCustomFieldValuesWrapper.Eid = '12345';
    serviceCustomFieldValuesWrapper.Value = 'TestValue';
    serviceCustomFieldValuesWrapper.checkListtype = true;
    serviceCustomFieldValuesWrapperList.add(serviceCustomFieldValuesWrapper);
    string jsonString2 = Json.serialize(serviceCustomFieldValuesWrapperList);
    map<string, List<ProductPriceRangeWrapper>> priceVsPriceRanges = new Map<string, List<ProductPriceRangeWrapper>>();
    priceVsPriceRanges.put('4', priceRangeList);
    list<Product2AddWrapper> wrapList1 = new List<Product2AddWrapper>();
    Product2AddWrapper wrap1 = new Product2AddWrapper();
    wrap1.prod = prod;
    wrap1.oppId = opp.id;
    wrap1.scheduleChargeEnable = false;
    wrap1.DisableRecurring = false;
    wrap1.oneTimeChargeEnable = false;
    wrap1.PricebookNames = proName;
    wrap1.Disableonetime = false;
    wrap1.DisableRecurring = false;
    wrap1.Disableonetime = false;
    wrap1.priceListValue = '273222';
    wrap1.priceListValue1 = '232133';
    wrap1.Recurringprice = 2055;
    wrap1.totelPriceValue = '$50';
    wrap1.OneTimePrice = 51;
    wrap1.Quantity = 1;
    wrap1.RecurrencPer = '5';
    wrap1.RecurrencPerValue = '4';
    wrap1.discountName = 'test';
    wrap1.discountEid = '2';
    wrap1.newServiceResource = 'test134';
    wrap1.serviceResourceName = 'test1243';
    wrap1.serviceResourceEid = '10';
    wrap1.agreementPeriod = 20;
    wrap1.service = prod.id;
    wrap1.OLineItem = oppLineItem2;
    wrap1.oliId = oppLineItem2.id;
    wrap1.agreementPeriod = 10;
    wrap1.newServiceResource = 'test1';
    wrap1.discountEid = '5';
    wrap1.errorMessage = 'NoError';
    wrapList1.add(wrap1);
    list<string> strList = new List<string>();
    strList.add('test1');
    strList.add('test2');
    list<Product2AddWrapper> wrapList = new List<Product2AddWrapper>();
    Product2AddWrapper wrap = new Product2AddWrapper();
    wrap.prod = prod;
    wrap.oppId = opp.id;
    wrap.scheduleChargeEnable = false;
    wrap.DisableRecurring = false;
    wrap.oneTimeChargeEnable = false;
    wrap.PricebookNames = proName;
    wrap.Disableonetime = false;
    wrap.DisableRecurring = false;
    wrap.Disableonetime = false;
    wrap.priceListValue = '2732';
    wrap.priceListValue1 = '2321';
    wrap.Recurringprice = 20;
    wrap.totelPriceValue = '$50';
    wrap.OneTimePrice = 50;
    wrap.Quantity = 1;
    wrap.RecurrencPer = '5';
    wrap.RecurrencPerValue = '4';
    wrap.discountName = 'test';
    wrap.discountEid = '2';
    wrap.newServiceResource = 'test';
    wrap.serviceResourceName = 'test';
    wrap.serviceResourceEid = '10';
    wrap.agreementPeriod = 20;
    wrap.service = prod.id;
    wrap.OLineItem = oppLineItem2;
    wrap.oliId = oppLineItem2.id;
    wrap.agreementPeriod = 10;
    wrap.priceVsPriceRanges = priceVsPriceRanges;
    wrap.childProducts = wrapList1;
    wrap.newServiceResource = 'test1';
    wrap.discountEid = '5';
    wrap.errorMessage = 'NoError';
    wrapList.add(wrap);
    string jsonstring = Json.serialize(wrap);
    string jsonListstring = Json.serialize(wrapList);
    Tract_Order_Custom_Field__c orderCustomfield = new Tract_Order_Custom_Field__c();
    orderCustomfield.Name = 'Test';
    orderCustomfield.eid__c = '12345';
    orderCustomfield.Value__c = 'TestValue';
    orderCustomfield.orderCustomFieldType__c = 'LIST';
    insert orderCustomfield;
    TractOppProductSimple.ChargeRulesWrapper chargeRuleWrap = new TractOppProductSimple.ChargeRulesWrapper();
    chargeRuleWrap.selectStatusListValue = 'Qualified';
    chargeRuleWrap.chargesPicklistValue = 'Flat';
    chargeRuleWrap.rateTypeListValue = 'TEST';
    chargeRuleWrap.productUsageRuleListValue = 'Match All Events';
    chargeRuleWrap.allowanceTypeListValue = 'Unlimited';
    chargeRuleWrap.prorateOnOrder = true;
    chargeRuleWrap.prorateOnCancel = true;
    chargeRuleWrap.chargeListBytesValue = 'Table Rate';
    string jsonstring4 = Json.serialize(chargeRuleWrap);
    Test.startTest();
    TractOppProductSimple.checkExistingCustomer(opp.id);
    TractOppProductSimple.getProductLists(opp.id);
    TractOppProductSimple.getProductPricesApex(jsonstring);
    TractOppProductSimple.getProductLists(opp.id);
    TractOppProductSimple.getpriceRangeValue(jsonstring);
    TractOppProductSimple.getChargeRulesWrapper();
    TractOppProductSimple.createNewActivityChargeRule(jsonstring4, '', '');
    TractOppProductSimple.getProductListsByName(strList, 'test');
    TractOppProductSimple.getProductDetailListsExisting(opp.Id);
    TractOppProductSimple.getDisounts(jsonstring);
    TractOppProductSimple.getInformation(opp, acc, tractSetup, '123');
    TractOppProductSimple.checkExistingOrder(opp.id);
    TractOppProductSimple.getServiceResource(jsonstring);
    Test.stopTest();
    System.assertNotEquals(orderCustomfield, null);
  }

  @isTest
  public static void myunitTest5() {
    Account acc = new Account();
    acc.Name = 'test';
    acc.Tract_Billing_Account__c = '1234';
    insert acc;
    Pricebook2 pb22 = new Pricebook2(Name = 'TRACT EUR', IsActive = true);
    insert pb22;
    ProductAgreementWrapper agreementWrapper = new ProductAgreementWrapper();
    list<ProductAgreementWrapper> agreementWrapperList = new List<ProductAgreementWrapper>();
    agreementWrapper.Name = 'Test Agreement';
    agreementWrapper.agreementPeriod = 2;
    agreementWrapper.agreementPeriodType = 'Months';
    agreementWrapper.endAction = 'RENEW_AGREEMENT';
    agreementWrapper.terminationFlatCharge = '$5';
    agreementWrapper.adjustmentCategory = 'Test';
    agreementWrapper.currencyType = 'USD';
    agreementWrapper.eid = '1234';
    agreementWrapperList.add(agreementWrapper);
    product2[] prodList = new List<product2>();
    product2 prod = new product2();
    prod.Name = 'test';
    prod.PriceLists__c = 'test:12345';
    prod.eid__c = '32933';
    prod.IsActive = true;
    prod.description = 'testdescription';
    prod.ProductCode = 'Add-on';
    prod.RuleType__c = 'Test';
    prod.RuleOverride__c = false;
    prod.Agreement_Information__c = JSON.serialize(agreementWrapperList);
    prodList.add(prod);
    insert prodList;
    Id pricebookId = Test.getStandardPricebookId();
    PricebookEntry standardPrice = new PricebookEntry(
      Pricebook2Id = pricebookId,
      Product2Id = prod.Id,
      UnitPrice = 10000,
      IsActive = true
    );
    insert standardPrice;
    PricebookEntry pbe2 = new PricebookEntry(
      unitprice = 1,
      Product2Id = prod.Id,
      Pricebook2Id = pb22.id,
      isActive = true
    );
    insert pbe2;
    Opportunity opp = new Opportunity();
    opp.Name = 'test';
    opp.stageName = 'Qualification';
    opp.Tract_Sales_Order__c = 'test';
    opp.Pricebook2Id = pb22.id;
    opp.AccountId = acc.id;
    opp.closeDate = system.today();
    insert opp;
    Opportunity opp2 = new Opportunity();
    opp2.Name = 'test1';
    opp2.stageName = 'Qualification';
    opp2.Tract_Sales_Order__c = 'test';
    opp2.Pricebook2Id = pb22.id;
    opp2.closeDate = system.today();
    insert opp2;
    List<string> proName = new List<string>();
    string pro = 'EUR';
    string pro1 = 'EUR';
    proName.add(pro);
    proName.add(pro1);
    OpportunityLineItem oppLineItem2 = new OpportunityLineItem(
      Quantity = 25,
      OpportunityId = opp.Id,
      UnitPrice = 1,
      PriceBookEntryId = pbe2.Id,
      Product2Id = prodList[0].id,
      productEid__c = 123456
    );
    insert oppLineItem2;
    List<ProductPriceWrapper> ppList = new List<ProductPriceWrapper>();
    ProductPriceWrapper pp = new ProductPriceWrapper();
    pp.priceType = 'Recurring';
    pp.eid = '2342';
    pp.thruDate = system.today();
    pp.currencyType = 'EUR';
    pp.priceListEid = '2732';
    pp.recurrencePeriod = 'Month';
    pp.scheduledCharges = false;
    pp.priceOverride = false;
    ProductPriceRangeWrapper priceRange = new ProductPriceRangeWrapper();
    priceRange.price = 20;
    priceRange.quantityBeginRange = 1;
    priceRange.quantityEndRange = 20;
    List<ProductPriceRangeWrapper> priceRangeList = new List<ProductPriceRangeWrapper>();
    priceRangeList.add(priceRange);
    pp.priceRangesList = priceRangeList;
    ppList.add(pp);
    ProductPriceWrapper pp2 = new ProductPriceWrapper();
    pp2.priceType = 'OneTime';
    pp2.eid = '2342';
    pp2.thruDate = system.today();
    pp2.currencyType = 'EUR';
    pp2.priceListEid = '2732';
    pp2.recurrencePeriod = 'Month';
    pp2.scheduledCharges = false;
    pp2.priceOverride = false;
    pp2.priceRangesList = priceRangeList;
    ppList.add(pp2);
    prod.Price_Information__c = JSON.serialize(ppList);
    update prod;
    TRACT_Setup__c tractSetup = new TRACT_Setup__c();
    tractSetup.name = 'tract';
    tractSetup.TPassword__c = 'tpass';
    tractSetup.Tract_User_Name__c = ' username ';
    tractSetup.TRACT_URL__c = 'https://tract-qa2.gotransverse.com/t/s/billing/1.28?wsdl';
    tractSetup.Active__c = true;
    tractSetup.Description__c = 'description';
    tractSetup.OrderStatus__c = 'DRAFT';
    tractSetup.Api_Version__c = 'API Version 1.0';
    insert tractSetup;
    Tract_Service_Custom_Field__c serv = new Tract_Service_Custom_Field__c();
    serv.StoreListValue__c = '10';
    serv.FieldType__c = 'LIST';
    insert serv;
    list<TractOppProductSimple.serviceCustomFieldValuesWrapper> serviceCustomFieldValuesWrapperList = new List<TractOppProductSimple.serviceCustomFieldValuesWrapper>();
    TractOppProductSimple.serviceCustomFieldValuesWrapper serviceCustomFieldValuesWrapper = new TractOppProductSimple.serviceCustomFieldValuesWrapper();
    serviceCustomFieldValuesWrapper.Name = 'TestName';
    serviceCustomFieldValuesWrapper.Eid = '12345';
    serviceCustomFieldValuesWrapper.Value = 'TestValue';
    serviceCustomFieldValuesWrapper.checkListtype = true;
    serviceCustomFieldValuesWrapperList.add(serviceCustomFieldValuesWrapper);
    string jsonString2 = Json.serialize(serviceCustomFieldValuesWrapperList);
    map<string, List<ProductPriceRangeWrapper>> priceVsPriceRanges = new Map<string, List<ProductPriceRangeWrapper>>();
    priceVsPriceRanges.put('4', priceRangeList);
    list<Product2AddWrapper> wrapList1 = new List<Product2AddWrapper>();
    Product2AddWrapper wrap1 = new Product2AddWrapper();
    wrap1.prod = prod;
    wrap1.oppId = opp.id;
    wrap1.scheduleChargeEnable = false;
    wrap1.DisableRecurring = false;
    wrap1.oneTimeChargeEnable = false;
    wrap1.PricebookNames = proName;
    wrap1.Disableonetime = false;
    wrap1.DisableRecurring = false;
    wrap1.Disableonetime = false;
    wrap1.priceListValue = '273222';
    wrap1.priceListValue1 = '232133';
    wrap1.Recurringprice = 2055;
    wrap1.OneTimePrice = 51;
    wrap1.Quantity = 1;
    wrap1.RecurrencPer = '5';
    wrap1.RecurrencPerValue = '4';
    wrap1.discountName = 'test';
    wrap1.discountEid = '2';
    wrap1.newServiceResource = 'test134';
    wrap1.serviceResourceName = 'test1243';
    wrap1.serviceResourceEid = '10';
    wrap1.agreementPeriod = 20;
    wrap1.service = prod.id;
    wrap1.OLineItem = oppLineItem2;
    wrap1.oliId = oppLineItem2.id;
    wrap1.agreementPeriod = 10;
    wrap1.priceVsPriceRanges = priceVsPriceRanges;
    wrap1.newServiceResource = 'test1';
    wrap1.discountEid = '5';
    wrapList1.add(wrap1);
    list<string> strList = new List<string>();
    strList.add('test1');
    strList.add('test2');
    list<Product2AddWrapper> wrapList = new List<Product2AddWrapper>();
    Product2AddWrapper wrap = new Product2AddWrapper();
    wrap.prod = prod;
    wrap.oppId = opp.id;
    wrap.scheduleChargeEnable = false;
    wrap.DisableRecurring = false;
    wrap.oneTimeChargeEnable = false;
    wrap.PricebookNames = proName;
    wrap.Disableonetime = false;
    wrap.DisableRecurring = false;
    wrap.Disableonetime = false;
    wrap.priceListValue = '2732';
    wrap.priceListValue1 = '2321';
    wrap.Recurringprice = 20;
    wrap.OneTimePrice = 5;
    wrap.Quantity = 1;
    wrap.RecurrencPer = '5';
    wrap.RecurrencPerValue = '4';
    wrap.discountName = 'test';
    wrap.discountEid = '2';
    wrap.newServiceResource = 'test';
    wrap.serviceResourceName = 'test';
    wrap.serviceResourceEid = '10';
    wrap.agreementPeriod = 20;
    wrap.service = prod.id;
    wrap.OLineItem = oppLineItem2;
    wrap.oliId = oppLineItem2.id;
    wrap.agreementPeriod = 10;
    wrap.priceVsPriceRanges = priceVsPriceRanges;
    wrap.childProducts = wrapList1;
    wrap.newServiceResource = 'test1';
    wrap.discountEid = '5';
    wrap.errorMessage = 'NoError';
    wrapList.add(wrap);
    string jsonstring = Json.serialize(wrap);
    String jsin = '[' + jsonstring + ']';
    string jsonListstring = Json.serialize(wrapList);
    Tract_Order_Custom_Field__c orderCustomfield = new Tract_Order_Custom_Field__c();
    orderCustomfield.Name = 'Test';
    orderCustomfield.eid__c = '12345';
    orderCustomfield.Value__c = 'TestValue';
    orderCustomfield.orderCustomFieldType__c = 'LIST';
    insert orderCustomfield;
    TractOppProductSimple.ChargeRulesWrapper chargeRuleWrap = new TractOppProductSimple.ChargeRulesWrapper();
    chargeRuleWrap.selectStatusListValue = 'Qualified';
    chargeRuleWrap.chargesPicklistValue = 'Flat';
    chargeRuleWrap.rateTypeListValue = 'TEST';
    chargeRuleWrap.productUsageRuleListValue = 'Match All Events';
    chargeRuleWrap.allowanceTypeListValue = 'Unlimited';
    chargeRuleWrap.prorateOnOrder = true;
    chargeRuleWrap.prorateOnCancel = true;
    chargeRuleWrap.chargeListBytesValue = 'Table Rate';
    string jsonstring4 = Json.serialize(chargeRuleWrap);
    Schdeule_Charge__c sc = new Schdeule_Charge__c();
    sc.Schdeule_Description__c = 'Test Description';
    sc.Schdeule_Amount__c = '500.00';
    sc.Schdeule_Date__c = Date.newInstance(2017, 12, 25);
    List<Schdeule_Charge__c> listOfSchedule = new List<Schdeule_Charge__c>{
      sc
    };
    string jsonSchCharge = Json.serialize(listOfSchedule);
    Test.startTest();
    TractOppProductSimple.createSalesOrderApex(jsin, opp.id, jsin);
    TractOppProductSimple.checkExistingCustomer(opp.id);
    TractOppProductSimple.getProductLists(opp2.id);
    TractOppProductSimple.getProductDetailLists(prodList, opp.id);
    TractOppProductSimple.getProductPricesApex(jsonstring);
    TractOppProductSimple.getpriceRangeValue(jsonstring);
    TractOppProductSimple.getChargeRulesWrapper();
    TractOppProductSimple.createNewActivityChargeRule(jsonstring4, '', '');
    TractOppProductSimple.getProductListsByName(strList, 'test');
    TractOppProductSimple.getProductDetailListsExisting(opp.Id);
    TractOppProductSimple.getDisounts(jsonstring);
    TractOppProductSimple.saveScheduleCharges(
      jsonSchCharge,
      500,
      prodList[0].id,
      opp.id
    );
    TractOppProductSimple.createSalesOrderApexExisting(jsonListstring, opp.id);
    TractOppProductSimple.getInformation(opp, acc, tractSetup, '123');
    TractOppProductSimple.createOrderApex(opp.id);
    TractOppProductSimple.checkExistingOrder(opp.id);
    TractOppProductSimple.getServiceResource(jsonstring);
    Test.stopTest();
    System.assertNotEquals(orderCustomfield, null);
  }

  @isTest
  public static void myunitTest6() {
    Account acc = new Account();
    acc.Name = 'test';
    acc.Tract_Billing_Account__c = '1234';
    insert acc;
    Pricebook2 pb22 = new Pricebook2(Name = 'TRACT EUR', IsActive = true);
    insert pb22;
    ProductAgreementWrapper agreementWrapper = new ProductAgreementWrapper();
    list<ProductAgreementWrapper> agreementWrapperList = new List<ProductAgreementWrapper>();

    agreementWrapper.Name = 'Test Agreement';
    agreementWrapper.agreementPeriod = 2;
    agreementWrapper.agreementPeriodType = 'Months';
    agreementWrapper.endAction = 'RENEW_AGREEMENT';
    agreementWrapper.terminationFlatCharge = '$5';
    agreementWrapper.adjustmentCategory = 'Test';
    agreementWrapper.currencyType = 'USD';
    agreementWrapper.eid = '1234';
    agreementWrapperList.add(agreementWrapper);
    ProductPriceWrapper priceWrapeer = new ProductPriceWrapper();
    product2[] prodList = new List<product2>();
    product2 prod = new product2();
    prod.Name = 'test';
    prod.PriceLists__c = 'test:12345';
    prod.eid__c = '35299';
    prod.IsActive = true;
    prod.description = 'testdescription';
    prod.ProductCode = 'Add-on';
    prod.RuleType__c = 'Test';
    prod.RuleOverride__c = false;
    prod.Agreement_Information__c = JSON.serialize(agreementWrapperList);
    prodList.add(prod);
    insert prodList;
    Id pricebookId = Test.getStandardPricebookId();
    PricebookEntry standardPrice = new PricebookEntry(
      Pricebook2Id = pricebookId,
      Product2Id = prod.Id,
      UnitPrice = 10000,
      IsActive = true
    );
    insert standardPrice;
    PricebookEntry pbe2 = new PricebookEntry(
      unitprice = 1,
      Product2Id = prod.Id,
      Pricebook2Id = pb22.id,
      isActive = true
    );
    insert pbe2;
    Opportunity opp = new Opportunity();
    opp.Name = 'test';
    opp.stageName = 'Qualification';
    opp.Tract_Sales_Order__c = 'test';
    opp.Pricebook2Id = pb22.id;
    opp.AccountId = acc.id;
    opp.closeDate = system.today();
    insert opp;
    List<string> proName = new List<string>();
    string pro = 'EUR';
    string pro1 = 'EUR';
    proName.add(pro);
    proName.add(pro1);
    OpportunityLineItem oppLineItem2 = new OpportunityLineItem(
      Quantity = 25,
      OpportunityId = opp.Id,
      UnitPrice = 1,
      PriceBookEntryId = pbe2.Id,
      productEid__c = 32933
    );
    insert oppLineItem2;
    List<ProductPriceWrapper> ppList = new List<ProductPriceWrapper>();
    ProductPriceWrapper pp = new ProductPriceWrapper();
    pp.priceType = 'Recurring';
    pp.eid = '2342';
    pp.thruDate = system.today();
    pp.fromDate = system.today();
    pp.currencyType = 'USD';
    pp.priceListEid = '2732';
    pp.recurrencePeriod = 'Month';
    pp.scheduledCharges = false;
    pp.priceOverride = false;
    ProductPriceRangeWrapper priceRange = new ProductPriceRangeWrapper();
    priceRange.price = 20;
    priceRange.quantityBeginRange = 1;
    priceRange.quantityEndRange = 20;
    List<ProductPriceRangeWrapper> priceRangeList = new List<ProductPriceRangeWrapper>();
    priceRangeList.add(priceRange);
    pp.priceRangesList = priceRangeList;
    ppList.add(pp);
    ProductPriceWrapper pp2 = new ProductPriceWrapper();
    pp2.priceType = 'OneTime';
    pp2.eid = '2342';
    pp2.thruDate = system.today();
    pp2.currencyType = 'USD';
    pp2.priceListEid = '2732';
    pp2.recurrencePeriod = 'Month';
    pp2.scheduledCharges = false;
    pp2.priceOverride = false;
    pp2.priceRangesList = priceRangeList;
    ppList.add(pp2);
    prod.Price_Information__c = JSON.serialize(ppList);
    update prod;
    TRACT_Setup__c tractSetup = new TRACT_Setup__c();
    tractSetup.name = 'tract';
    tractSetup.TPassword__c = 'tpass';
    tractSetup.Tract_User_Name__c = ' username ';
    tractSetup.TRACT_URL__c = 'https://tract-qa2.gotransverse.com/t/s/billing/1.28?wsdl';
    tractSetup.Active__c = true;
    tractSetup.Description__c = 'description';
    tractSetup.OrderStatus__c = 'DRAFT';
    tractSetup.Api_Version__c = 'API Version 2.0';
    insert tractSetup;
    Tract_Service_Custom_Field__c serv = new Tract_Service_Custom_Field__c();
    serv.StoreListValue__c = '10';
    serv.FieldType__c = 'LIST';
    insert serv;
    list<TractOppProductSimple.serviceCustomFieldValuesWrapper> serviceCustomFieldValuesWrapperList = new List<TractOppProductSimple.serviceCustomFieldValuesWrapper>();
    TractOppProductSimple.serviceCustomFieldValuesWrapper serviceCustomFieldValuesWrapper = new TractOppProductSimple.serviceCustomFieldValuesWrapper();
    serviceCustomFieldValuesWrapper.Name = 'TestName';
    serviceCustomFieldValuesWrapper.Eid = '12345';
    serviceCustomFieldValuesWrapper.Value = 'TestValue';
    serviceCustomFieldValuesWrapper.checkListtype = true;
    serviceCustomFieldValuesWrapperList.add(serviceCustomFieldValuesWrapper);
    string jsonString2 = Json.serialize(serviceCustomFieldValuesWrapperList);
    map<string, List<ProductPriceRangeWrapper>> priceVsPriceRanges = new Map<string, List<ProductPriceRangeWrapper>>();
    priceVsPriceRanges.put('4', priceRangeList);
    list<Product2AddWrapper> wrapList1 = new List<Product2AddWrapper>();
    Product2AddWrapper wrap1 = new Product2AddWrapper();
    wrap1.prod = prod;
    wrap1.oppId = opp.id;
    wrap1.scheduleChargeEnable = false;
    wrap1.DisableRecurring = false;
    wrap1.oneTimeChargeEnable = false;
    wrap1.PricebookNames = proName;
    wrap1.Disableonetime = false;
    wrap1.DisableRecurring = false;
    wrap1.Disableonetime = false;
    wrap1.priceListValue = '273222';
    wrap1.priceListValue1 = '232133';
    wrap1.Recurringprice = 2055;
    wrap1.totelPriceValue = '$50';
    wrap1.OneTimePrice = 51;
    wrap1.Quantity = 1;
    wrap1.RecurrencPer = '5';
    wrap1.RecurrencPerValue = '4';
    wrap1.discountName = 'test';
    wrap1.discountEid = '2';
    wrap1.newServiceResource = 'test134';
    wrap1.serviceResourceName = 'test1243';
    wrap1.serviceResourceEid = '10';
    wrap1.agreementPeriod = 20;
    wrap1.service = prod.id;
    wrap1.OLineItem = oppLineItem2;
    wrap1.oliId = oppLineItem2.id;
    wrap1.agreementPeriod = 10;
    wrap1.newServiceResource = 'test1';
    wrap1.discountEid = '5';
    wrap1.errorMessage = 'NoError';
    wrapList1.add(wrap1);
    list<string> strList = new List<string>();
    strList.add('test1');
    strList.add('test2');
    list<Product2AddWrapper> wrapList = new List<Product2AddWrapper>();
    Product2AddWrapper wrap = new Product2AddWrapper();
    wrap.prod = prod;
    wrap.oppId = opp.id;
    wrap.scheduleChargeEnable = false;
    wrap.DisableRecurring = false;
    wrap.oneTimeChargeEnable = false;
    wrap.PricebookNames = proName;
    wrap.Disableonetime = false;
    wrap.DisableRecurring = false;
    wrap.Disableonetime = false;
    wrap.priceListValue = '2732';
    wrap.priceListValue1 = '2321';
    wrap.Recurringprice = 20;
    wrap.totelPriceValue = '$50';
    wrap.OneTimePrice = 50;
    wrap.Quantity = 1;
    wrap.RecurrencPer = '5';
    wrap.RecurrencPerValue = '4';
    wrap.discountName = 'test';
    wrap.discountEid = '2';
    wrap.newServiceResource = 'test';
    wrap.serviceResourceName = 'test';
    wrap.serviceResourceEid = '10';
    wrap.agreementPeriod = 20;
    wrap.service = prod.id;
    wrap.OLineItem = oppLineItem2;
    wrap.oliId = oppLineItem2.id;
    wrap.agreementPeriod = 10;
    wrap.priceVsPriceRanges = priceVsPriceRanges;
    wrap.childProducts = wrapList1;
    wrap.newServiceResource = 'test1';
    wrap.discountEid = '5';
    wrap.errorMessage = 'NoError';
    wrapList.add(wrap);
    string jsonstring = Json.serialize(wrap);
    string jsonListstring = Json.serialize(wrapList);
    Tract_Order_Custom_Field__c orderCustomfield = new Tract_Order_Custom_Field__c();
    orderCustomfield.Name = 'Test';
    orderCustomfield.eid__c = '12345';
    orderCustomfield.Value__c = 'TestValue';
    orderCustomfield.orderCustomFieldType__c = 'LIST';
    insert orderCustomfield;
    TractOppProductSimple.ChargeRulesWrapper chargeRuleWrap = new TractOppProductSimple.ChargeRulesWrapper();
    chargeRuleWrap.selectStatusListValue = 'Qualified';
    chargeRuleWrap.chargesPicklistValue = 'Flat';
    chargeRuleWrap.rateTypeListValue = 'TEST';
    chargeRuleWrap.productUsageRuleListValue = 'Match All Events';
    chargeRuleWrap.allowanceTypeListValue = 'Unlimited';
    chargeRuleWrap.prorateOnOrder = true;
    chargeRuleWrap.prorateOnCancel = true;
    chargeRuleWrap.chargeListBytesValue = 'Table Rate';
    string jsonstring4 = Json.serialize(chargeRuleWrap);

    OrderUsageRule__c usageRule = new OrderUsageRule__c();
    usageRule.ProductUsageValue__c = 'Match All Events';
    usageRule.ChargeCategoryEid__c = '12345';
    usageRule.ProductEid__c = '12345';
    usageRule.name = 'chargeUsage';
    usageRule.ProratedOnOrder__c = 'true';
    usageRule.ProratedOnCancel__c = 'false';
    usageRule.RateTypeValue__c = 'Flat';
    usageRule.OpportunityID__c = '1234';
    insert usageRule;
    OrderUsageRule__c usageRule1 = new OrderUsageRule__c();
    usageRule1.ProductUsageValue__c = 'Formula';
    usageRule1.ChargeCategoryEid__c = '12345';
    usageRule1.ProductEid__c = '12345';
    usageRule1.name = 'chargeUsage';
    usageRule1.ProratedOnOrder__c = 'true';
    usageRule1.ProratedOnCancel__c = 'false';
    usageRule1.RateTypeValue__c = 'Flat';
    usageRule1.OpportunityID__c = '1234';
    insert usageRule1;
    OrderUsageRule__c usageRule2 = new OrderUsageRule__c();
    usageRule2.ProductUsageValue__c = 'Global';
    usageRule2.ChargeCategoryEid__c = '12345';
    usageRule2.ProductEid__c = '12345';
    usageRule2.name = 'chargeUsage';
    usageRule2.ProratedOnOrder__c = 'true';
    usageRule2.ProratedOnCancel__c = 'false';
    usageRule2.RateTypeValue__c = 'Flat';
    usageRule2.OpportunityID__c = '1234';
    insert usageRule2;
    Test.startTest();
    TractOppProductSimple.checkExistingCustomer(opp.id);
    TractOppProductSimple.getProductLists(opp.id);
    TractOppProductSimple.getProductPricesApex(jsonstring);
    TractOppProductSimple.getProductLists(opp.id);
    TractOppProductSimple.getpriceRangeValue(jsonstring);
    TractOppProductSimple.showActivityChargeRule('12345', '1234');
    TractOppProductSimple.getChargeRulesWrapper();
    TractOppProductSimple.createNewActivityChargeRule(jsonstring4, '', '');
    TractOppProductSimple.getProductListsByName(strList, 'test');
    TractOppProductSimple.getProductDetailListsExisting(opp.Id);
    TractOppProductSimple.getDisounts(jsonstring);
    TractOppProductSimple.createOrderApex(opp.id);
    TractOppProductSimple.checkExistingOrder(opp.id);
    TractOppProductSimple.getInformation(opp, acc, tractSetup, '123');
    TractOppProductSimple.getServiceResource(jsonstring);
    Test.stopTest();
    System.assertNotEquals(orderCustomfield, null);
  }
}