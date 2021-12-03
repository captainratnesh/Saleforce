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
 * This class is a test class of TractOppProduct_LT class.
 * @author Aman Jain
 */

@isTest
public class TractOppProduct_LT_Test {
  static testMethod void oppProductMethod() {
    Account acc = HelperClass.getAccount();
    insert acc;
    Pricebook2 pb22 = HelperClass.getPriceBook2();
    insert pb22;
    Price_List__c priceList = HelperClass.getPricelist();
    insert priceList;
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

    List<ProductPriceWrapper> ppList = new List<ProductPriceWrapper>();
    ProductPriceWrapper pp = new ProductPriceWrapper();
    pp.priceType = 'Recurring';
    pp.eid = '2342';
    pp.thruDate = system.today();
    pp.currencyType = 'USD';
    pp.priceListEid = '2732';
    pp.recurrencePeriod = 'Month';
    pp.scheduledCharges = false;
    pp.priceOverride = true;

    ProductPriceRangeWrapper priceRange = new ProductPriceRangeWrapper();
    priceRange.price = 20;
    List<ProductPriceRangeWrapper> priceRangeList = new List<ProductPriceRangeWrapper>();
    priceRangeList.add(priceRange);
    pp.priceRangesList = priceRangeList;
    ppList.add(pp);

    ProductPriceWrapper pp2 = new ProductPriceWrapper();
    pp2.priceType = 'One-Time';
    pp2.eid = '2342';
    pp2.thruDate = system.today();
    pp2.currencyType = 'USD';
    pp2.priceListEid = '12345';
    pp2.recurrencePeriod = 'Month';
    pp2.scheduledCharges = false;
    pp2.priceOverride = true;

    pp2.priceRangesList = priceRangeList;
    ppList.add(pp2);

    ScheduleChargeWrapper scheduleWrapper = new ScheduleChargeWrapper();
    scheduleWrapper.Name = 'test';
    scheduleWrapper.SchdeuleAmount = '20';
    scheduleWrapper.SchdeuleDate = system.today();
    scheduleWrapper.SchdeuleDescription = 'test';

    product2[] prodList = new List<product2>();
    product2 prod = new product2();
    prod.Name = 'test';
    prod.PriceLists__c = 'test:12345';
    prod.eid__c = '10';
    prod.IsActive = true;
    prod.description = 'testdescription';
    prod.ProductCode = 'Add-on';
    prod.RuleType__c = 'Test';
    prod.RuleOverride__c = false;
    prod.Agreement_Information__c = JSON.serialize(agreementWrapperList);
    prod.Price_Information__c = JSON.serialize(ppList);
    prod.minServiceResources__c = 1;
    prodList.add(prod);

    product2 prod2 = new product2();
    prod2.Name = 'test';
    prod2.PriceLists__c = 'test:12345';
    prod2.eid__c = '32933';
    prod2.IsActive = true;
    prod2.description = 'testdescription';
    prod2.productCode = 'SUBSCRIPTION';
    prod2.RuleType__c = 'Test';
    prod2.RuleOverride__c = false;
    prod2.Agreement_Information__c = JSON.serialize(agreementWrapperList);
    prod2.Price_Information__c = JSON.serialize(ppList);
    prod2.minServiceResources__c = 1;
    prodList.add(prod2);

    product2 prod3 = new product2();
    prod3.Name = 'test';
    prod3.PriceLists__c = 'test:12345';
    prod3.eid__c = '32934';
    prod3.IsActive = true;
    prod3.description = 'testdescription';
    prod3.productCode = 'One-Time';
    prod3.RuleType__c = 'Test';
    prod3.RuleOverride__c = false;
    prod3.Agreement_Information__c = JSON.serialize(agreementWrapperList);
    prod3.Price_Information__c = JSON.serialize(ppList);
    prodList.add(prod3);

    insert prodList;
    Opportunity opp = new Opportunity();
    opp.Name = 'test';
    opp.stageName = 'Qualification';
    opp.Pricebook2Id = pb22.id;
    opp.AccountId = acc.id;
    opp.closeDate = system.today();
    opp.GTV_Order_Type__c = 'order';
    insert opp;
    Id pricebookId = Test.getStandardPricebookId();
    PricebookEntry standardPrice = new PricebookEntry(
      Pricebook2Id = pricebookId,
      Product2Id = prod.Id,
      UnitPrice = 10000,
      IsActive = true
    );
    insert standardPrice;
    PricebookEntry standardPrice2 = new PricebookEntry(
      Pricebook2Id = pricebookId,
      Product2Id = prod2.Id,
      UnitPrice = 10000,
      IsActive = true
    );
    insert standardPrice2;
    PricebookEntry standardPrice3 = new PricebookEntry(
      Pricebook2Id = pricebookId,
      Product2Id = prod3.Id,
      UnitPrice = 10000,
      IsActive = true
    );
    insert standardPrice3;
    PricebookEntry pbe2 = new PricebookEntry(
      unitprice = 1,
      Product2Id = prod.Id,
      Pricebook2Id = pb22.id,
      isActive = true
    );
    insert pbe2;
    PricebookEntry pbe3 = new PricebookEntry(
      unitprice = 1,
      Product2Id = prod2.Id,
      Pricebook2Id = pb22.id,
      isActive = true
    );
    insert pbe3;
    PricebookEntry pbe4 = new PricebookEntry(
      unitprice = 1,
      Product2Id = prod3.Id,
      Pricebook2Id = pb22.id,
      isActive = true
    );
    insert pbe4;
    List<OpportunityLineItem> opportunityLineItemList = new List<OpportunityLineItem>();
    OpportunityLineItem oPplineitem = new OpportunityLineItem(
      Quantity = 25,
      OpportunityId = opp.Id,
      UnitPrice = 1,
      PriceBookEntryId = pbe2.Id,
      eid__c = '10',
      recurringPrice__c = 20,
      oneTimePrice__c = 15,
      Service__c = prod2.id,
      description = 'Test',
      Discount_eid__c = 'Test',
      Discount__c = 'Test',
      Applied_Agreement_Eid__c = '1234',
      agreementEndAction__c = 'Test',
      overrideAgreementEndDate__c = system.today(),
      Service_Resource_Eid__c = '1234',
      Tract_Service_Resource_Name__c = 'Test',
      New_Service_Resource__c = 'TEST|Tes',
      recurringProductPriceEid__c = '2342',
      OneTimeProductPriceEid__c = '2342'
    );
    OpportunityLineItem oPplineitem1 = new OpportunityLineItem(
      Quantity = 25,
      OpportunityId = opp.Id,
      UnitPrice = 1,
      PriceBookEntryId = pbe3.Id,
      eid__c = '32933',
      recurringPrice__c = 20,
      oneTimePrice__c = 15,
      description = 'Test',
      Discount_eid__c = 'Test',
      Discount__c = 'Test',
      Applied_Agreement_Eid__c = '1234',
      agreementEndAction__c = 'Test',
      overrideAgreementEndDate__c = system.today(),
      Service_Resource_Eid__c = '1234',
      Tract_Service_Resource_Name__c = 'Test',
      New_Service_Resource__c = 'TEST|Tes'
    );
    OpportunityLineItem oPplineitem2 = new OpportunityLineItem(
      Existing_Service__c = true,
      Quantity = 25,
      OpportunityId = opp.Id,
      UnitPrice = 1,
      PriceBookEntryId = pbe4.Id,
      eid__c = '32934',
      oneTimePrice__c = 15,
      recurringPrice__c = 20,
      description = 'Test'
    );
    opportunityLineItemList.add(oPplineitem);
    opportunityLineItemList.add(oPplineitem1);
    opportunityLineItemList.add(oPplineitem2);
    system.assert(opportunityLineItemList != null);
    insert opportunityLineItemList;
    OpportunityLineItem oPplineitem4 = new OpportunityLineItem(
      Quantity = 25,
      productEid__c = 32934,
      OpportunityId = opp.Id,
      UnitPrice = 1,
      PriceBookEntryId = pbe2.Id,
      priceList_Eid__c = '2732',
      eid__c = '10',
      recurringPrice__c = 20,
      oneTimePrice__c = 15,
      Service__c = prod2.id,
      description = 'Test',
      Discount_eid__c = 'Test',
      Discount__c = 'Test',
      Applied_Agreement_Eid__c = '1234',
      agreementEndAction__c = 'Test',
      overrideAgreementEndDate__c = system.today(),
      Service_Resource_Eid__c = '1234',
      Tract_Service_Resource_Name__c = 'Test',
      New_Service_Resource__c = 'TEST|Tes',
      Price_Override__c = false
    );
    insert oPplineitem4;
    List<string> proName = new List<string>();
    string pro = 'EUR';
    string pro1 = 'EUR';
    proName.add(pro);
    proName.add(pro1);

    //update prod;
    Tract_Service_Custom_Field__c serv = new Tract_Service_Custom_Field__c();
    serv.StoreListValue__c = '10';
    insert serv;
    TRACT_Setup__c tract = HelperClass.getAPI2TRACT();
    insert tract;

    List<OrderUsageRule__c> usageList = new List<OrderUsageRule__c>();
    OrderUsageRule__c orderUseRule = new OrderUsageRule__c();
    orderUseRule.AllowanceType__c = 'UNLIMITED';
    orderUseRule.ProductEid__c = '20';
    orderUseRule.ProductUsageValue__c = 'Match All Events';
    orderUseRule.RateTypeValue__c = 'Table Rate';
    orderUseRule.ChargeCategoryEid__c = 'test';
    orderUseRule.Status__c = 'Qualify';
    orderUseRule.RuleType__c = 'test';
    orderUseRule.OpportunityID__c = opp.id;
    orderUseRule.Status__c = 'Test';
    orderUseRule.RateTableEid__c = 'Test';
    orderUseRule.UsageRate__c = 20;
    orderUseRule.UsageRateUom__c = 'Test';

    usageList.add(orderUseRule);
    OrderUsageRule__c orderUseRule2 = new OrderUsageRule__c();
    orderUseRule2.AllowanceType__c = 'UNLIMITED';
    orderUseRule2.ProductEid__c = '20';
    orderUseRule2.ProductUsageValue__c = 'test';
    orderUseRule2.RateTypeValue__c = 'Table Rate';
    orderUseRule2.ChargeCategoryEid__c = 'test';
    orderUseRule2.Status__c = 'Qualify';
    orderUseRule2.RuleType__c = 'test';
    orderUseRule2.OpportunityID__c = opp.id;
    usageList.add(orderUseRule2);
    system.assert(orderUseRule != null);
    insert orderUseRule;
    list<ServiceCustomFieldValuesWrapper> wrap1List = new List<ServiceCustomFieldValuesWrapper>();
    ServiceCustomFieldValuesWrapper servWrap = new ServiceCustomFieldValuesWrapper();
    servWrap.Name = 'test1234';
    servWrap.checkListtype = true;
    servWrap.Eid = 'test';
    servWrap.Value = 'test';
    wrap1List.add(servWrap);
    string jsonstring1 = Json.serialize(wrap1List);
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
    wrap.RecurrencPerValue = '2342';
    wrap.OneTimePerValue = '2342';
    wrap.agreementId = null;
    wrap.OLineItem = oPplineitem2;
    wrap.oliId = oPplineitem2.id;
    wrap.agreementPeriod = 10;
    wrap.newServiceResource = 'test1';
    wrap.priceOverridden = false;
    wrap.scheduleChargeList.add(scheduleWrapper);
    wrap.serviceCustomFieldValueList.add(servWrap);
    wrap.discountEid = '5';
    wrapList.add(wrap);
    string jsonstring = Json.serialize(wrap);
    string jsonListstring = Json.serialize(wrapList);

    list<Schdeule_Charge__c> schdleLst = new List<Schdeule_Charge__c>();
    Schdeule_Charge__c schdle = new Schdeule_Charge__c();
    schdle.Schdeule_Amount__c = '';
    schdle.Schdeule_Description__c = '';
    schdleLst.add(schdle);
    string jsonstring2 = Json.serialize(schdleLst);
    list<ProductUsesWrapper> tractoppList = new List<ProductUsesWrapper>();
    ProductUsesWrapper tractopp = new ProductUsesWrapper();
    tractopp.ChargeName = 'Testcharge';
    tractopp.ChargeType = 'Cash';
    tractopp.Rule = 'test';
    tractopp.UsageRuleEid = '10';
    tractopp.ChargeCategory = '';
    tractopp.FromDate = 'test';
    tractopp.ThruDate = 'test';
    tractopp.recordId = 'test';
    tractopp.ChargeCategory = 'Recurring';
    tractopp.Taper = 'test';
    tractopp.Rate = '10';
    tractopp.FromDate = '5-5-2016';
    tractopp.ThruDate = '6-5-2016';
    tractopp.Status = 'Qualify';
    tractoppList.add(tractopp);
    string jsonstring3 = Json.serialize(tractoppList);
    TractOppProduct_LT.ChargeRulesWrapper chargeRuleWrap = new TractOppProduct_LT.ChargeRulesWrapper();
    chargeRuleWrap.selectStatusListValue = 'Qualified';
    chargeRuleWrap.chargesPicklistValue = 'Flat';
    chargeRuleWrap.chargesPicklistValue2 = 'FLAT';
    chargeRuleWrap.rateTypeListValue = 'TEST';
    chargeRuleWrap.productUsageRuleListValue = 'Match All Events';
    chargeRuleWrap.allowanceTypeListValue = 'Unlimited';
    chargeRuleWrap.prorateOnOrder = true;
    chargeRuleWrap.prorateOnCancel = true;
    chargeRuleWrap.chargeListBytesValue = 'Table Rate';
    string jsonstring4 = Json.serialize(chargeRuleWrap);
    ActivityUsagesWrapper objwrapper = new ActivityUsagesWrapper();
    objwrapper.createdDate = '';
    objwrapper.accountNumber = '';
    objwrapper.serviceID = '';
    AgreementWrapper agWrapper = new AgreementWrapper();
    agWrapper.mapOfAgreementPeriodType = new Map<String, String>();
    agWrapper.hasAgreement = false;

    Tract_Order_Custom_Field__c orderFld = new Tract_Order_Custom_Field__c();
    orderFld.Name = 'Test';
    orderFld.Eid__c = 'Test';
    orderFld.Value__c = 'Test';
    orderFld.Store_Order_List_Value__c = 'Test';
    orderFld.orderCustomFieldType__c = 'LIST';
    system.assert(orderFld != null);
    insert orderFld;

    list<ServiceResourceWrapper> srwList = new List<ServiceResourceWrapper>();
    ServiceResourceWrapper srw = new ServiceResourceWrapper();
    srw.eid = '10';
    srw.identifier = '15';
    srw.errorMessage = 'NotFound';
    srwList.add(srw);
    String sw = JSON.serialize(srwList);

    list<Service_Custom_Field__c> serviceCustomFieldList = new List<Service_Custom_Field__c>();
    Service_Custom_Field__c serviceCustomField = new Service_Custom_Field__c();
    serviceCustomField.name = 'test';
    serviceCustomField.eid__c = 'test';
    serviceCustomField.value__c = 'test';
    serviceCustomField.ProductId__c = oPplineitem1.id;
    serviceCustomFieldList.add(serviceCustomField);

    Service_Custom_Field__c serviceCustomField4 = new Service_Custom_Field__c();
    serviceCustomField4.name = 'test';
    serviceCustomField4.eid__c = 'test';
    serviceCustomField4.value__c = 'test';
    serviceCustomField4.ProductId__c = oPplineitem4.id;
    serviceCustomFieldList.add(serviceCustomField4);

    Service_Custom_Field__c serviceCustomField1 = new Service_Custom_Field__c();
    serviceCustomField1.name = 'test';
    serviceCustomField1.eid__c = 'test';
    serviceCustomField1.value__c = 'test';
    serviceCustomField1.ProductId__c = oPplineitem.id;
    system.assert(serviceCustomField1 != null);
    serviceCustomFieldList.add(serviceCustomField1);
    insert serviceCustomFieldList;

    list<Schdeule_Charge__c> scheduleChargesList = new List<Schdeule_Charge__c>();
    Schdeule_Charge__c recurringCharges = new Schdeule_Charge__c();
    recurringCharges.Schdeule_Amount__c = '25';
    recurringCharges.Charge_Type__c = 'Recurring';
    recurringCharges.Schdeule_Description__c = 'Recurring';
    recurringCharges.Schdeule_Date__c = system.today();
    recurringCharges.ProductId__c = oPplineitem1.id;
    scheduleChargesList.add(recurringCharges);

    Schdeule_Charge__c recurringCharges1 = new Schdeule_Charge__c();
    recurringCharges1.Schdeule_Amount__c = '25';
    recurringCharges1.Charge_Type__c = 'Recurring';
    recurringCharges1.Schdeule_Description__c = 'Recurring';
    recurringCharges1.Schdeule_Date__c = system.today();
    recurringCharges1.ProductId__c = oPplineitem.id;
    scheduleChargesList.add(recurringCharges1);

    Schdeule_Charge__c oneTimeCharges = new Schdeule_Charge__c();
    oneTimeCharges.Schdeule_Amount__c = '25';
    oneTimeCharges.Charge_Type__c = 'OneTime';
    oneTimeCharges.Schdeule_Description__c = 'Recurring';
    oneTimeCharges.Schdeule_Date__c = system.today();
    oneTimeCharges.ProductId__c = oPplineitem1.id;
    scheduleChargesList.add(oneTimeCharges);

    Schdeule_Charge__c oneTimeCharges1 = new Schdeule_Charge__c();
    oneTimeCharges1.Schdeule_Amount__c = '25';
    oneTimeCharges1.Charge_Type__c = 'OneTime';
    oneTimeCharges1.Schdeule_Description__c = 'Recurring';
    oneTimeCharges1.Schdeule_Date__c = system.today();
    oneTimeCharges1.ProductId__c = oPplineitem.id;
    scheduleChargesList.add(oneTimeCharges1);

    Schdeule_Charge__c oneTimeCharges5 = new Schdeule_Charge__c();
    oneTimeCharges5.Schdeule_Amount__c = '25';
    oneTimeCharges5.Charge_Type__c = 'OneTime';
    oneTimeCharges5.Schdeule_Description__c = 'Recurring';
    oneTimeCharges5.Schdeule_Date__c = system.today();
    oneTimeCharges5.ProductId__c = oPplineitem4.id;
    scheduleChargesList.add(oneTimeCharges5);

    Schdeule_Charge__c oneTimeCharges2 = new Schdeule_Charge__c();
    oneTimeCharges2.Schdeule_Amount__c = '25';
    oneTimeCharges2.Charge_Type__c = 'OneTime';
    oneTimeCharges2.Schdeule_Description__c = 'Recurring';
    oneTimeCharges2.Schdeule_Date__c = system.today();
    oneTimeCharges2.ProductId__c = oPplineitem2.id;
    system.assert(oneTimeCharges2 != null);
    scheduleChargesList.add(oneTimeCharges2);
    insert scheduleChargesList;
    string amount = '123';
    string todaydate = string.valueOf(system.date.today());

    test.startTest();
    TractOppProduct_LT.getOliDetails(oPplineitem4.id);
    TractOppProduct_LT.saveOLiDetails(jsonstring, oPplineitem4.id);
    TractOppProduct_LT.applySrIdToProduct(sw, jsonstring);
    TractOppProduct_LT.getInformation(opp, acc, tract, '123');
    TractOppProduct_LT.getApiVersion();
    TractOppProduct_LT.getAllProductList(opp.id);
    TractOppProduct_LT.getProductDetails(prod, opp.id);
    TractOppProduct_LT.getExistingOliProduct(opp.id);
    TractOppProduct_LT.getProductAgreement(prod.id, 'USD');
    TractOppProduct_LT.getOrderCustomField(opp.id);
    TractOppProduct_LT.saveOrderCustomField(jsonstring1, opp.id);
    TractOppProduct_LT.getDisountCode(jsonstring, '');
    TractOppProduct_LT.getServiceResource(jsonstring);
    TractOppProduct_LT.saveScheduleCharges(jsonstring2, 10, '20', prod.id);
    TractOppProduct_LT.showActivityChargeRule('20', opp.id);
    TractOppProduct_LT.getChargeRulesWrapper();
    TractOppProduct_LT.createNewActivityChargeRule(
      jsonstring4,
      jsonstring3,
      '20',
      opp.id
    );
    TractOppProduct_LT.createOrderApex(opp.id);
    TractOppProduct_LT.getOppProductListApex(opp.id);
    TractOppProduct_LT.getOppProductListApex1(opp.id);
    TractOppProduct_LT.deleteChargeRule('Test');
    TractOppProduct_LT.removeOppProductApex(oPplineitem2, opp.id);
    TractOppProduct_LT.getParentServices(
      opp.Id,
      prodList[0].eid__c,
      jsonListstring
    );
    TractOppProduct_LT.createSalesOrderApex(jsonListstring, opp.id);
    TractOppProduct_LT.createSalesOrderApex(jsonListstring, opp.id);
    TractOppProduct_LT.getRelatedProductNameList('22');
    TractOppProduct_LT.getOLIProductPricesInformation(jsonstring, oPplineitem4);
    TractOppProduct_LT.getServiceCustomField(
      '20',
      '[{"checkListtype":false,"Eid":"598","fieldValidationType":"TEXT","Name":"SCF1","ServiceListType":[],"Value":"1"},{"checkListtype":false,"Eid":"604","fieldValidationType":"TEXT","Name":"SCF2","ServiceListType":[],"Value":"3"}]'
    );
    TractOppProduct_LT.configureScheduleCharges(amount, todaydate);
    TractOppProduct_LT.checkExistingServiceResource('Test');
    TractOppProduct_LT.changeOrderIndicator(opp.Id);
    TractOppProduct_LT.getActiveServiceList(opp.Id);
    TractOppProduct_LT.createOppLineItem(
      '{"compatibleProductList":[{"label":"Test01/2 Sub2 Solomiia","value":"17252"},{"label":"SubProd_03","value":"13052"},{"label":"Sub_01","value":"13318"},{"label":"Subprod_01 8/4","value":"17150"},{"label":"S-orad","value":"17174"},{"label":"S-orad2","value":"17178"},{"label":"S-tax","value":"17202"},{"label":"S-orad-n","value":"17204"},{"label":"Sub","value":"17206"},{"label":"Sub taxable","value":"17234"},{"label":"Test01/1 Sub1 Solomiia","value":"17242"},{"label":"Test02 Sub Solomiia","value":"17256"},{"label":"Subprod 8/23","value":"17330"},{"label":"Subprod_01 8/23","value":"17334"},{"label":"Subprod_3 8/24","value":"17360"},{"label":"3-S","value":"17394"},{"label":"Subprod_01 8/28","value":"17396"},{"label":"Prod_01 8/28","value":"17400"},{"label":"Subprod_02 8/28","value":"17404"},{"label":"Subprod_04 8/28","value":"17408"},{"label":"3-S-1","value":"17410"},{"label":"Subprod_01 9/4","value":"17456"},{"label":"Subprod_01 9/4 tax","value":"17460"},{"label":"Subprod_04 tax","value":"17462"},{"label":"DSU Subscription","value":"17736"},{"label":"DSU Subscription #2","value":"17738"},{"label":"Subprod_01 10/4","value":"17794"},{"label":"Sub Twelve Weeks","value":"17870"},{"label":"Subprod_01 10/9","value":"17882"},{"label":"1-1","value":"17968"},{"label":"Subprod_01 10/18","value":"18040"},{"label":"Subprod_04 10/18","value":"18044"},{"label":"Subprod_01 10/19","value":"18094"},{"label":"Subprod_02 10/19","value":"18096"},{"label":"299739","value":"18112"},{"label":"299739-2","value":"18114"},{"label":"Subprod_01 10/20","value":"18182"},{"label":"Subprod_02 10/20","value":"18184"},{"label":"4-s","value":"18280"},{"label":"Subprod_01 10/26","value":"18302"},{"label":"Sub_1","value":"18498"},{"label":"Sub_2","value":"18500"},{"label":"Sub_01 11/2","value":"18532"},{"label":"Sub_02 11/2 no tax","value":"18534"},{"label":"Sub_03 11/2","value":"18536"},{"label":"Sub_04 11/2","value":"18540"},{"label":"UPROM-477","value":"18546"},{"label":"Sub_01 11.3","value":"18578"},{"label":"Sub_tax1","value":"18582"},{"label":"Sub_2 tax","value":"18588"}],"currencyType":"USD","currentProductId":"17252","currentServiceId":"2346616","EmailReciept":false,"MapofProductEidVsSerializedFlag":{},"MapOfProductIdVsOneTimePriceList":{"17738":[{"label":"One-Time /10.0","value":"49264"}],"18096":[{"label":"One-Time /70.0","value":"22334"}]},"MapOfProductIdVsRecurrencePriceList":{"13052":[{"label":"Bill Cycle/340.0","value":"18826"}],"13318":[{"label":"Bill Cycle/198.0","value":"19128"}],"17150":[{"label":"Bill Cycle/10.0","value":"20292"}],"17174":[{"label":"Bill Cycle/10.0","value":"20314"}],"17178":[{"label":"Bill Cycle/-10.0","value":"20318"}],"17202":[{"label":"Bill Cycle/100.0","value":"20362"}],"17204":[{"label":"Bill Cycle/-100.0","value":"20364"}],"17206":[{"label":"Bill Cycle/100.0","value":"20366"}],"17234":[{"label":"Bill Cycle/140.0","value":"20402"}],"17242":[{"label":"Bill Cycle/10.0","value":"20412"},{"label":"Two Years/10.0","value":"56358"}],"17252":[{"label":"Bill Cycle/10.0","value":"20424"}],"17256":[{"label":"Bill Cycle/20.0","value":"20428"}],"17330":[{"label":"Bill Cycle/0.0","value":"20510"}],"17334":[{"label":"Bill Cycle/100.0","value":"49940"}],"17360":[{"label":"Bill Cycle/10.0","value":"20540"}],"17394":[{"label":"Bill Cycle/0.0","value":"20586"}],"17396":[{"label":"Bill Cycle/10.0","value":"20588"}],"17400":[{"label":"Bill Cycle/0.0","value":"20592"}],"17404":[{"label":"Bill Cycle/0.0","value":"20596"}],"17408":[{"label":"Bill Cycle/100.0","value":"20600"}],"17410":[{"label":"Bill Cycle/0.0","value":"20602"}],"17456":[{"label":"Bill Cycle/100.0","value":"20656"}],"17460":[{"label":"Bill Cycle/100.0","value":"20660"}],"17462":[{"label":"Bill Cycle/55.0","value":"20664"}],"17736":[{"label":"Bill Cycle/10.0","value":"20970"}],"17738":[{"label":"Bill Cycle/10.0","value":"20972"}],"17794":[{"label":"Bill Cycle/100.0","value":"21042"}],"17870":[{"label":"Twelve Weeks/600.0","value":"21118"}],"17882":[{"label":"Bill Cycle/100.0","value":"21130"}],"17968":[{"label":"Bill Cycle/-100.0","value":"21244"}],"18040":[{"label":"Bill Cycle/100.0","value":"21344"}],"18044":[{"label":"Month/100.0","value":"21348"}],"18094":[{"label":"Bill Cycle/100.0","value":"21404"}],"18096":[{"label":"Bill Cycle/100.0","value":"21406"}],"18112":[{"label":"Bill Cycle/100.0","value":"21422"}],"18114":[{"label":"Bill Cycle/50.0","value":"21424"}],"18182":[{"label":"Bill Cycle/100.0","value":"21500"}],"18184":[{"label":"Bill Cycle/80.0","value":"21502"}],"18280":[{"label":"Bill Cycle/20.0","value":"21622"}],"18302":[{"label":"Bill Cycle/100.0","value":"21654"}],"18498":[{"label":"Bill Cycle/100.0","value":"21900"}],"18500":[{"label":"Bill Cycle/100.0","value":"21902"}],"18532":[{"label":"Bill Cycle/100.0","value":"21934"}],"18534":[{"label":"Bill Cycle/100.0","value":"21936"}],"18536":[{"label":"Bill Cycle/100.0","value":"21938"}],"18540":[{"label":"Bill Cycle/100.0","value":"21942"}],"18546":[{"label":"Month/150.0","value":"21948"}],"18578":[{"label":"Bill Cycle/10.0","value":"21986"}],"18582":[{"label":"Bill Cycle/10.0","value":"21990"}],"18588":[{"label":"Bill Cycle/10.0","value":"21996"}]},"MapofProductPriceEidVsPriceOverrideFlag":{"18826":true,"19128":true,"20292":true,"20314":true,"20318":true,"20362":true,"20364":true,"20366":true,"20402":true,"20412":true,"20424":true,"20428":true,"20510":true,"20540":true,"20586":true,"20588":true,"20592":true,"20596":true,"20600":true,"20602":true,"20656":true,"20660":true,"20664":true,"20970":true,"20972":true,"21042":true,"21118":true,"21130":true,"21244":true,"21344":true,"21348":true,"21404":true,"21406":true,"21422":true,"21424":true,"21500":true,"21502":true,"21622":true,"21654":true,"21900":true,"21902":true,"21934":true,"21936":true,"21938":true,"21942":true,"21948":true,"21986":true,"21990":true,"21996":true,"22334":false,"49264":true,"49940":true,"56358":true},"mapOfProductPriceEidVsPriceRangeList":{"18826":[{"currencyType":"USD","eid":"21016","level":1,"price":340,"quantityBeginRange":0}],"19128":[{"currencyType":"USD","eid":"21328","level":1,"price":198,"quantityBeginRange":0}],"20292":[{"currencyType":"USD","eid":"23218","level":1,"price":10,"quantityBeginRange":0}],"20314":[{"currencyType":"USD","eid":"23250","level":1,"price":10,"quantityBeginRange":0}],"20318":[{"currencyType":"USD","eid":"23254","level":1,"price":-10,"quantityBeginRange":0}],"20362":[{"currencyType":"USD","eid":"23326","level":1,"price":100,"quantityBeginRange":0}],"20364":[{"currencyType":"USD","eid":"23328","level":1,"price":-100,"quantityBeginRange":0}],"20366":[{"currencyType":"USD","eid":"23330","level":1,"price":100,"quantityBeginRange":0}],"20402":[{"currencyType":"USD","eid":"23366","level":1,"price":140,"quantityBeginRange":0}],"20412":[{"currencyType":"USD","eid":"23376","level":1,"price":10,"quantityBeginRange":0}],"20424":[{"currencyType":"USD","eid":"23388","level":1,"price":10,"quantityBeginRange":0}],"20428":[{"currencyType":"USD","eid":"23392","level":1,"price":20,"quantityBeginRange":0}],"20510":[{"currencyType":"USD","eid":"23528","level":1,"price":0,"quantityBeginRange":0}],"20540":[{"currencyType":"USD","eid":"23558","level":1,"price":10,"quantityBeginRange":0}],"20586":[{"currencyType":"USD","eid":"23604","level":1,"price":0,"quantityBeginRange":0}],"20588":[{"currencyType":"USD","eid":"23606","level":1,"price":10,"quantityBeginRange":0}],"20592":[{"currencyType":"USD","eid":"23610","level":1,"price":0,"quantityBeginRange":0}],"20596":[{"currencyType":"USD","eid":"23614","level":1,"price":0,"quantityBeginRange":0}],"20600":[{"currencyType":"USD","eid":"23618","level":1,"price":100,"quantityBeginRange":0}],"20602":[{"currencyType":"USD","eid":"23620","level":1,"price":0,"quantityBeginRange":0}],"20656":[{"currencyType":"USD","eid":"23680","level":1,"price":100,"quantityBeginRange":0}],"20660":[{"currencyType":"USD","eid":"23684","level":1,"price":100,"quantityBeginRange":0}],"20664":[{"currencyType":"USD","eid":"23688","level":1,"price":55,"quantityBeginRange":0}],"20970":[{"currencyType":"USD","eid":"24030","level":1,"price":10,"quantityBeginRange":0}],"20972":[{"currencyType":"USD","eid":"24032","level":1,"price":10,"quantityBeginRange":0}],"21042":[{"currencyType":"USD","eid":"24106","level":1,"price":100,"quantityBeginRange":0}],"21118":[{"currencyType":"USD","eid":"24210","level":1,"price":600,"quantityBeginRange":0}],"21130":[{"currencyType":"USD","eid":"24222","level":1,"price":100,"quantityBeginRange":0}],"21244":[{"currencyType":"USD","eid":"24336","level":1,"price":-100,"quantityBeginRange":0}],"21344":[{"currencyType":"USD","eid":"24436","level":1,"price":100,"quantityBeginRange":0}],"21348":[{"currencyType":"USD","eid":"24440","level":1,"price":100,"quantityBeginRange":0}],"21404":[{"currencyType":"USD","eid":"24496","level":1,"price":100,"quantityBeginRange":0}],"21406":[{"currencyType":"USD","eid":"24498","level":1,"price":100,"quantityBeginRange":0}],"21422":[{"currencyType":"USD","eid":"24514","level":1,"price":100,"quantityBeginRange":0}],"21424":[{"currencyType":"USD","eid":"24516","level":1,"price":50,"quantityBeginRange":0}],"21500":[{"currencyType":"USD","eid":"24592","level":1,"price":100,"quantityBeginRange":0}],"21502":[{"currencyType":"USD","eid":"24594","level":1,"price":80,"quantityBeginRange":0}],"21622":[{"currencyType":"USD","eid":"24722","level":1,"price":20,"quantityBeginRange":0}],"21654":[{"currencyType":"USD","eid":"24754","level":1,"price":100,"quantityBeginRange":0}],"21900":[{"currencyType":"USD","eid":"25000","level":1,"price":100,"quantityBeginRange":0}],"21902":[{"currencyType":"USD","eid":"25002","level":1,"price":100,"quantityBeginRange":0}],"21934":[{"currencyType":"USD","eid":"25034","level":1,"price":100,"quantityBeginRange":0}],"21936":[{"currencyType":"USD","eid":"25036","level":1,"price":100,"quantityBeginRange":0}],"21938":[{"currencyType":"USD","eid":"25038","level":1,"price":100,"quantityBeginRange":0}],"21942":[{"currencyType":"USD","eid":"25042","level":1,"price":100,"quantityBeginRange":0}],"21948":[{"currencyType":"USD","eid":"25048","level":1,"price":150,"quantityBeginRange":0}],"21986":[{"currencyType":"USD","eid":"25086","level":1,"price":10,"quantityBeginRange":0}],"21990":[{"currencyType":"USD","eid":"25090","level":1,"price":10,"quantityBeginRange":0}],"21996":[{"currencyType":"USD","eid":"25096","level":1,"price":10,"quantityBeginRange":0}],"22334":[{"currencyType":"USD","eid":"25454","level":1,"price":70,"quantityBeginRange":0}],"49264":[{"currencyType":"USD","eid":"53434","level":1,"price":10,"quantityBeginRange":0}],"49940":[{"currencyType":"USD","eid":"54122","level":1,"price":100,"quantityBeginRange":0}],"56358":[{"currencyType":"USD","eid":"61836","level":1,"price":10,"quantityBeginRange":0}]},"OrderDate":"2021-06-01","originalServiceName":"Test01/2 Sub2 Solomiia(2346616)","priceListId":"696","Quantity":1,"Recurringprice":10,"RecurringpriceId":"20424","totalPrice":10,"Type":"Subscription"}',
      opp.id
    );
    test.stopTest();
  }

  static testMethod void oppProductMethod1() {
    Account acc = HelperClass.getAccount();
    insert acc;
    Pricebook2 pb22 = HelperClass.getPriceBook2();
    insert pb22;
    Price_List__c priceList = HelperClass.getPricelist();
    insert priceList;
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
    prod.eid__c = '10';
    prod.IsActive = true;
    prod.description = 'testdescription';
    prod.ProductCode = 'Add-on';
    prod.RuleType__c = 'Test';
    prod.RuleOverride__c = false;
    prod.Agreement_Information__c = JSON.serialize(agreementWrapperList);
    prodList.add(prod);
    insert prodList;
    Opportunity opp = new Opportunity();
    opp.Name = 'test';
    opp.stageName = 'Qualification';
    opp.Pricebook2Id = pb22.id;
    opp.AccountId = acc.id;
    opp.closeDate = system.today();
    system.assert(opp != null);
    insert opp;
    Id pricebookId = Test.getStandardPricebookId();
    PricebookEntry standardPrice = new PricebookEntry(
      Pricebook2Id = pricebookId,
      Product2Id = prod.Id,
      UnitPrice = 10000,
      IsActive = true
    );
    system.assert(standardPrice != null);
    insert standardPrice;
    PricebookEntry pbe2 = new PricebookEntry(
      unitprice = 1,
      Product2Id = prod.Id,
      Pricebook2Id = pb22.id,
      isActive = true
    );
    system.assert(pbe2 != null);
    insert pbe2;

    OpportunityLineItem oPplineitem2 = new OpportunityLineItem(
      Quantity = 25,
      OpportunityId = opp.Id,
      UnitPrice = 1,
      PriceBookEntryId = pbe2.Id
    );
    system.assert(oPplineitem2 != null);
    insert oPplineitem2;
    OpportunityLineItem oPplineitem4 = new OpportunityLineItem(
      Quantity = 25,
      productEid__c = 32934,
      OpportunityId = opp.Id,
      UnitPrice = 1,
      PriceBookEntryId = pbe2.Id,
      priceList_Eid__c = '2732',
      eid__c = '10',
      Service__c = prod.id,
      description = 'Test',
      Discount_eid__c = 'Test',
      Discount__c = 'Test',
      Applied_Agreement_Eid__c = '1234',
      agreementEndAction__c = 'Test',
      overrideAgreementEndDate__c = system.today(),
      Service_Resource_Eid__c = '1234',
      Tract_Service_Resource_Name__c = 'Test',
      New_Service_Resource__c = 'TEST|Tes'
    );
    insert oPplineitem4;
    List<string> proName = new List<string>();
    string pro = 'EUR';
    string pro1 = 'EUR';
    proName.add(pro);
    proName.add(pro1);

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
    ppList.add(pp);

    ProductPriceRangeWrapper priceRange = new ProductPriceRangeWrapper();
    priceRange.price = 20;

    List<ProductPriceRangeWrapper> priceRangeList = new List<ProductPriceRangeWrapper>();
    priceRangeList.add(priceRange);

    pp.priceRangesList = priceRangeList;

    prod.Price_Information__c = JSON.serialize(ppList);
    update prod;
    Tract_Service_Custom_Field__c serv = new Tract_Service_Custom_Field__c();
    serv.StoreListValue__c = '10';
    insert serv;
    TRACT_Setup__c tract = new TRACT_Setup__c();
    tract.name = 'tract';
    tract.Tract_User_Name__c = 'test';
    tract.Active__c = true;
    tract.OrderStatus__c = 'FINAL';
    tract.Api_Version__c = 'API Version 2.0';
    system.assert(tract != null);
    insert tract;
    OrderUsageRule__c orderUseRule = new OrderUsageRule__c();
    orderUseRule.AllowanceType__c = 'UNLIMITED';
    orderUseRule.ProductEid__c = '20';
    orderUseRule.ProductUsageValue__c = 'Formula';
    orderUseRule.RateTypeValue__c = 'Table Rate';
    orderUseRule.ChargeCategoryEid__c = 'test';
    orderUseRule.Status__c = 'Qualify';
    orderUseRule.RuleType__c = 'test';
    orderUseRule.OpportunityID__c = opp.id;
    orderUseRule.Status__c = 'Test';
    orderUseRule.RateTableEid__c = 'Test';
    orderUseRule.UsageRate__c = 20;
    orderUseRule.UsageRateUom__c = 'Test';
    system.assert(orderUseRule != null);
    insert orderUseRule;
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
    wrap.agreementId = null;
    wrap.OLineItem = oPplineitem2;
    wrap.oliId = oPplineitem2.id;
    wrap.agreementPeriod = 10;
    wrap.newServiceResource = 'test1';
    wrap.discountEid = '5';
    wrapList.add(wrap);
    string jsonstring = Json.serialize(wrap);
    string jsonListstring = Json.serialize(wrapList);
    list<ServiceCustomFieldValuesWrapper> wrap1List = new List<ServiceCustomFieldValuesWrapper>();
    ServiceCustomFieldValuesWrapper servWrap = new ServiceCustomFieldValuesWrapper();
    servWrap.Name = 'test';
    servWrap.checkListtype = true;
    servWrap.Eid = 'test';
    servWrap.Value = 'test';
    wrap1List.add(servWrap);
    string jsonstring1 = Json.serialize(wrap1List);
    list<Schdeule_Charge__c> schdleLst = new List<Schdeule_Charge__c>();
    Schdeule_Charge__c schdle = new Schdeule_Charge__c();
    schdle.Schdeule_Amount__c = '';
    schdle.Schdeule_Description__c = '';
    schdleLst.add(schdle);
    string jsonstring2 = Json.serialize(schdleLst);
    list<ProductUsesWrapper> tractoppList = new List<ProductUsesWrapper>();
    ProductUsesWrapper tractopp = new ProductUsesWrapper();
    tractopp.ChargeName = 'Testcharge';
    tractopp.ChargeType = 'Cash';
    tractopp.Rule = 'test';
    tractopp.UsageRuleEid = '10';
    tractopp.ChargeCategory = 'Recurring';
    tractopp.Taper = 'test';
    tractopp.Rate = '10';
    tractopp.FromDate = '5-5-2016';
    tractopp.ThruDate = '6-5-2016';
    tractopp.Status = 'Qualify';
    tractoppList.add(tractopp);
    string jsonstring3 = Json.serialize(tractoppList);
    TractOppProduct_LT.ChargeRulesWrapper chargeRuleWrap = new TractOppProduct_LT.ChargeRulesWrapper();
    chargeRuleWrap.selectStatusListValue = 'Qualified';
    chargeRuleWrap.chargesPicklistValue = 'Flat';
    chargeRuleWrap.chargesPicklistValue2 = 'FLAT';
    chargeRuleWrap.rateTypeListValue = 'TEST';
    chargeRuleWrap.productUsageRuleListValue = 'Match All Events';
    chargeRuleWrap.allowanceTypeListValue = 'Unlimited';
    chargeRuleWrap.prorateOnOrder = true;
    chargeRuleWrap.prorateOnCancel = true;
    chargeRuleWrap.chargeListBytesValue = 'Table Rate';
    string jsonstring4 = Json.serialize(chargeRuleWrap);

    test.startTest();
    //TractOppProduct_LT.getProductLists(opp.id);
    //TractOppProduct_LT.getProductLists(opp.id);
    //TractOppProduct_LT.getProductPricesApex(jsonstring);
    TractOppProduct_LT.getProductAgreement(prod.id, 'USD');
    TractOppProduct_LT.getOrderCustomField(opp.id);
    TractOppProduct_LT.saveOrderCustomField(jsonstring1, opp.id);
    TractOppProduct_LT.getDisountCode(jsonstring, '');
    TractOppProduct_LT.getServiceResource(jsonstring);
    TractOppProduct_LT.saveScheduleCharges(jsonstring2, 10, '20', prod.id);
    TractOppProduct_LT.showActivityChargeRule('20', opp.id);
    TractOppProduct_LT.getChargeRulesWrapper();
    TractOppProduct_LT.createNewActivityChargeRule(
      jsonstring4,
      jsonstring3,
      '20',
      opp.id
    );
    TractOppProduct_LT.createOrderApex(opp.id);
    TractOppProduct_LT.getOppProductListApex(opp.id);
    TractOppProduct_LT.removeOppProductApex(oPplineitem2, opp.id);
    TractOppProduct_LT.getParentServices(
      opp.Id,
      prodList[0].eid__c,
      jsonListstring
    );
    TractOppProduct_LT.createSalesOrderApex(jsonListstring, opp.id);
    TractOppProduct_LT.createSalesOrderApex(jsonListstring, opp.id);
    TractOppProduct_LT.getServiceCustomField(
      '20',
      '[{"checkListtype":false,"Eid":"598","fieldValidationType":"TEXT","Name":"SCF1","ServiceListType":[],"Value":"1"},{"checkListtype":false,"Eid":"604","fieldValidationType":"TEXT","Name":"SCF2","ServiceListType":[],"Value":"3"}]'
    );
    test.stopTest();
  }

  static testMethod void mytestMethod() {
    Account acc = HelperClass.getAccount();
    insert acc;
    Pricebook2 pb22 = HelperClass.getPriceBook2();
    insert pb22;
    Price_List__c priceList = HelperClass.getPricelist();
    insert priceList;
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
    prod.eid__c = '10';
    prod.IsActive = true;
    prod.description = 'testdescription';
    prod.ProductCode = 'Add-on';
    prod.RuleType__c = 'Test';
    prod.RuleOverride__c = false;
    prod.Agreement_Information__c = JSON.serialize(agreementWrapperList);
    prodList.add(prod);
    insert prodList;
    Opportunity opp = new Opportunity();
    opp.Name = 'test';
    opp.stageName = 'Qualification';
    opp.Pricebook2Id = pb22.id;
    opp.AccountId = acc.id;
    opp.closeDate = system.today();
    system.assert(opp != null);
    insert opp;
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

    OpportunityLineItem oPplineitem2 = new OpportunityLineItem(
      Quantity = 25,
      OpportunityId = opp.Id,
      UnitPrice = 1,
      PriceBookEntryId = pbe2.Id,
      eid__c = '10',
      Existing_Service__c = true
    );
    insert oPplineitem2;
    List<string> proName = new List<string>();
    string pro = 'EUR';
    string pro1 = 'EUR';
    proName.add(pro);
    proName.add(pro1);
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
    Tract_Service_Custom_Field__c serv = new Tract_Service_Custom_Field__c();
    serv.StoreListValue__c = '10';
    insert serv;
    TRACT_Setup__c tract = new TRACT_Setup__c();
    tract.name = 'tract';
    tract.Tract_User_Name__c = 'test';
    tract.Active__c = true;
    tract.OrderStatus__c = 'DRAFT';
    tract.Api_Version__c = 'API Version 2.0';
    insert tract;
    List<OrderUsageRule__c> usageList = new List<OrderUsageRule__c>();
    OrderUsageRule__c orderUseRule = new OrderUsageRule__c();
    orderUseRule.AllowanceType__c = 'UNLIMITED';
    orderUseRule.ProductEid__c = '20';
    orderUseRule.ProductUsageValue__c = 'Match All Events';
    orderUseRule.RateTypeValue__c = 'Table Rate';
    orderUseRule.ChargeCategoryEid__c = 'test';
    orderUseRule.Status__c = 'Qualify';
    orderUseRule.RuleType__c = 'test';
    orderUseRule.OpportunityID__c = opp.id;
    orderUseRule.Status__c = 'Test';
    orderUseRule.RateTableEid__c = 'Test';
    orderUseRule.UsageRate__c = 20;
    orderUseRule.UsageRateUom__c = 'Test';

    usageList.add(orderUseRule);
    OrderUsageRule__c orderUseRule2 = new OrderUsageRule__c();
    orderUseRule2.AllowanceType__c = 'UNLIMITED';
    orderUseRule2.ProductEid__c = '20';
    orderUseRule2.ProductUsageValue__c = 'test';
    orderUseRule2.RateTypeValue__c = 'Table Rate';
    orderUseRule2.ChargeCategoryEid__c = 'test';
    orderUseRule2.Status__c = 'Qualify';
    orderUseRule2.RuleType__c = 'test';
    orderUseRule2.OpportunityID__c = opp.id;
    usageList.add(orderUseRule2);

    insert orderUseRule;
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
    wrap.agreementId = null;
    wrap.OLineItem = oPplineitem2;
    wrap.oliId = oPplineitem2.id;
    wrap.agreementPeriod = 10;
    wrap.newServiceResource = 'test1';
    wrap.discountEid = '5';
    wrapList.add(wrap);
    string jsonstring = Json.serialize(wrap);
    string jsonListstring = Json.serialize(wrapList);
    list<ServiceCustomFieldValuesWrapper> wrap1List = new List<ServiceCustomFieldValuesWrapper>();
    ServiceCustomFieldValuesWrapper servWrap = new ServiceCustomFieldValuesWrapper();
    servWrap.Name = 'test';
    servWrap.checkListtype = true;
    servWrap.Eid = 'test';
    servWrap.Value = 'test';
    wrap1List.add(servWrap);
    string jsonstring1 = Json.serialize(wrap1List);
    list<Schdeule_Charge__c> schdleLst = new List<Schdeule_Charge__c>();
    Schdeule_Charge__c schdle = new Schdeule_Charge__c();
    schdle.Schdeule_Amount__c = '';
    schdle.Schdeule_Description__c = '';
    schdleLst.add(schdle);
    string jsonstring2 = Json.serialize(schdleLst);
    list<ProductUsesWrapper> tractoppList = new List<ProductUsesWrapper>();
    ProductUsesWrapper tractopp = new ProductUsesWrapper();
    tractopp.ChargeName = 'Testcharge';
    tractopp.ChargeType = 'Cash';
    tractopp.Rule = 'test';
    tractopp.UsageRuleEid = '10';
    tractopp.ChargeCategory = 'Recurring';
    tractopp.Taper = 'test';
    tractopp.Rate = '10';
    tractopp.FromDate = '5-5-2016';
    tractopp.ThruDate = '6-5-2016';
    tractopp.Status = 'Qualify';
    tractoppList.add(tractopp);
    string jsonstring3 = Json.serialize(tractoppList);
    TractOppProduct_LT.ChargeRulesWrapper chargeRuleWrap = new TractOppProduct_LT.ChargeRulesWrapper();
    chargeRuleWrap.selectStatusListValue = 'Qualified';
    chargeRuleWrap.chargesPicklistValue = 'Flat';
    chargeRuleWrap.chargesPicklistValue2 = 'FLAT';
    chargeRuleWrap.rateTypeListValue = 'TEST';
    chargeRuleWrap.productUsageRuleListValue = 'Match All Events';
    chargeRuleWrap.allowanceTypeListValue = 'Unlimited';
    chargeRuleWrap.prorateOnOrder = true;
    chargeRuleWrap.prorateOnCancel = true;
    chargeRuleWrap.chargeListBytesValue = 'Table Rate';
    string jsonstring4 = Json.serialize(chargeRuleWrap);

    Tract_Order_Custom_Field__c orderFld = new Tract_Order_Custom_Field__c();
    orderFld.Name = 'Test';
    orderFld.Eid__c = 'Test';
    orderFld.Value__c = 'Test';
    orderFld.Store_Order_List_Value__c = 'Test';
    orderFld.orderCustomFieldType__c = 'LIST';
    system.assert(orderFld != null);
    insert orderFld;

    test.startTest();
    //TractOppProduct_LT.getProductLists(opp.id);
    //TractOppProduct_LT.getProductLists(opp.id);
    //TractOppProduct_LT.getProductPricesApex(jsonstring);
    TractOppProduct_LT.getProductAgreement(prod.id, 'USD');
    TractOppProduct_LT.getOrderCustomField(opp.id);
    TractOppProduct_LT.saveOrderCustomField(jsonstring1, opp.id);
    TractOppProduct_LT.getDisountCode(jsonstring, '');
    TractOppProduct_LT.getServiceResource(jsonstring);
    TractOppProduct_LT.saveScheduleCharges(jsonstring2, 10, '20', prod.id);
    TractOppProduct_LT.showActivityChargeRule('20', opp.id);
    TractOppProduct_LT.getChargeRulesWrapper();
    TractOppProduct_LT.createNewActivityChargeRule(
      jsonstring4,
      jsonstring3,
      '20',
      opp.id
    );
    TractOppProduct_LT.createOrderApex(opp.id);
    TractOppProduct_LT.getOppProductListApex(opp.id);
    TractOppProduct_LT.removeOppProductApex(oPplineitem2, opp.id);
    TractOppProduct_LT.getParentServices(
      opp.Id,
      prodList[0].eid__c,
      jsonListstring
    );
    TractOppProduct_LT.createSalesOrderApex(jsonListstring, opp.id);
    TractOppProduct_LT.createSalesOrderApex(jsonListstring, opp.id);
    TractOppProduct_LT.getRelatedProductNameList('22');
    //TractOppProduct_LT.getAllAvailableServiceResource();
    TractOppProduct_LT.getAppliedServiceResources(jsonstring);
    test.stopTest();
  }

  static testMethod void myTestMethod2() {
    Account acc = HelperClass.getAccount();
    insert acc;
    Pricebook2 pb22 = HelperClass.getPriceBook2();
    insert pb22;
    Price_List__c priceList = HelperClass.getPricelist();
    insert priceList;
    TRACT_Setup__c tract = HelperClass.getAPI2TRACT();
    insert tract;
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
    prod.eid__c = '10';
    prod.IsActive = true;
    prod.description = 'testdescription';
    prod.ProductCode = 'Add-on';
    prod.RuleType__c = 'Test';
    prod.RuleOverride__c = false;
    prod.Agreement_Information__c = JSON.serialize(agreementWrapperList);
    prodList.add(prod);
    insert prodList;
    Opportunity opp = new Opportunity();
    opp.Name = 'test';
    opp.stageName = 'Qualification';
    opp.AccountId = acc.id;
    opp.closeDate = system.today();
    system.assert(opp != null);
    insert opp;
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
    //TractOppProduct_LT.getProductLists(opp.id);
  }

  static testMethod void oppProductMethod4() {
    Account acc = HelperClass.getAccount();
    insert acc;
    Pricebook2 pb22 = HelperClass.getPriceBook2();
    insert pb22;
    Price_List__c priceList = HelperClass.getPricelist();
    insert priceList;
    TRACT_Setup__c tract = HelperClass.getAPI1TRACT();
    insert tract;
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

    List<ProductPriceWrapper> ppList = new List<ProductPriceWrapper>();
    ProductPriceWrapper pp = new ProductPriceWrapper();
    pp.priceType = 'Recurring';
    pp.eid = '2342';
    pp.thruDate = system.today();
    pp.currencyType = 'USD';
    pp.priceListEid = '2732';
    pp.recurrencePeriod = 'Month';
    pp.scheduledCharges = false;
    pp.priceOverride = true;

    ProductPriceRangeWrapper priceRange = new ProductPriceRangeWrapper();
    priceRange.price = 20;
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
    pp2.priceOverride = true;

    pp2.priceRangesList = priceRangeList;
    ppList.add(pp2);

    product2[] prodList = new List<product2>();
    product2 prod = new product2();
    prod.Name = 'test';
    prod.PriceLists__c = 'test:12345';
    prod.eid__c = '10';
    prod.IsActive = true;
    prod.description = 'testdescription';
    prod.ProductCode = 'Add-on';
    prod.RuleType__c = 'Test';
    prod.RuleOverride__c = false;
    prod.Agreement_Information__c = JSON.serialize(agreementWrapperList);
    prod.Price_Information__c = JSON.serialize(ppList);
    prod.minServiceResources__c = 1;
    prodList.add(prod);

    product2 prod2 = new product2();
    prod2.Name = 'test';
    prod2.PriceLists__c = 'test:12345';
    prod2.eid__c = '32933';
    prod2.IsActive = true;
    prod2.description = 'testdescription';
    prod2.productCode = 'SUBSCRIPTION';
    prod2.RuleType__c = 'Test';
    prod2.RuleOverride__c = false;
    prod2.Agreement_Information__c = JSON.serialize(agreementWrapperList);
    prod2.Price_Information__c = JSON.serialize(ppList);
    prod2.minServiceResources__c = 1;
    prodList.add(prod2);

    product2 prod3 = new product2();
    prod3.Name = 'test';
    prod3.PriceLists__c = 'test:12345';
    prod3.eid__c = '32934';
    prod3.IsActive = true;
    prod3.description = 'testdescription';
    prod3.productCode = 'One-Time';
    prod3.RuleType__c = 'Test';
    prod3.RuleOverride__c = false;
    prod3.Agreement_Information__c = JSON.serialize(agreementWrapperList);
    prod3.Price_Information__c = JSON.serialize(ppList);
    prodList.add(prod3);

    insert prodList;
    Opportunity opp = new Opportunity();
    opp.Name = 'test';
    opp.stageName = 'Qualification';
    opp.Pricebook2Id = pb22.id;
    opp.AccountId = acc.id;
    opp.closeDate = system.today();
    insert opp;
    Id pricebookId = Test.getStandardPricebookId();
    PricebookEntry standardPrice = new PricebookEntry(
      Pricebook2Id = pricebookId,
      Product2Id = prod.Id,
      UnitPrice = 10000,
      IsActive = true
    );
    insert standardPrice;
    PricebookEntry standardPrice2 = new PricebookEntry(
      Pricebook2Id = pricebookId,
      Product2Id = prod2.Id,
      UnitPrice = 10000,
      IsActive = true
    );
    insert standardPrice2;
    PricebookEntry standardPrice3 = new PricebookEntry(
      Pricebook2Id = pricebookId,
      Product2Id = prod3.Id,
      UnitPrice = 10000,
      IsActive = true
    );
    insert standardPrice3;
    PricebookEntry pbe2 = new PricebookEntry(
      unitprice = 1,
      Product2Id = prod.Id,
      Pricebook2Id = pb22.id,
      isActive = true
    );
    insert pbe2;
    PricebookEntry pbe3 = new PricebookEntry(
      unitprice = 1,
      Product2Id = prod2.Id,
      Pricebook2Id = pb22.id,
      isActive = true
    );
    insert pbe3;
    PricebookEntry pbe4 = new PricebookEntry(
      unitprice = 1,
      Product2Id = prod3.Id,
      Pricebook2Id = pb22.id,
      isActive = true
    );
    insert pbe4;
    List<OpportunityLineItem> opportunityLineItemList = new List<OpportunityLineItem>();
    OpportunityLineItem oPplineitem = new OpportunityLineItem(
      Quantity = 25,
      OpportunityId = opp.Id,
      UnitPrice = 1,
      PriceBookEntryId = pbe2.Id,
      eid__c = '10',
      recurringPrice__c = 20,
      oneTimePrice__c = 15,
      Service__c = prod2.id,
      description = 'Test',
      Discount_eid__c = 'Test',
      Discount__c = 'Test',
      Applied_Agreement_Eid__c = '1234',
      agreementEndAction__c = 'Test',
      overrideAgreementEndDate__c = system.today(),
      Service_Resource_Eid__c = '1234',
      Tract_Service_Resource_Name__c = 'Test',
      New_Service_Resource__c = 'TEST|Tes',
      ParentServiceEid__c = '12345',
      recurringProductPriceEid__c = '2342',
      OneTimeProductPriceEid__c = '2342'
    );
    OpportunityLineItem oPplineitem1 = new OpportunityLineItem(
      Quantity = 25,
      OpportunityId = opp.Id,
      UnitPrice = 1,
      PriceBookEntryId = pbe3.Id,
      eid__c = '32933',
      recurringPrice__c = 20,
      oneTimePrice__c = 15,
      description = 'Test',
      Discount_eid__c = 'Test',
      Discount__c = 'Test',
      Applied_Agreement_Eid__c = '1234',
      agreementEndAction__c = 'Test',
      overrideAgreementEndDate__c = system.today(),
      Service_Resource_Eid__c = '1234',
      Tract_Service_Resource_Name__c = 'Test',
      New_Service_Resource__c = 'TEST|Tes'
    );
    OpportunityLineItem oPplineitem2 = new OpportunityLineItem(
      Quantity = 25,
      OpportunityId = opp.Id,
      UnitPrice = 1,
      PriceBookEntryId = pbe4.Id,
      eid__c = '32934',
      oneTimePrice__c = 15,
      recurringPrice__c = 20,
      description = 'Test'
    );
    opportunityLineItemList.add(oPplineitem);
    opportunityLineItemList.add(oPplineitem1);
    opportunityLineItemList.add(oPplineitem2);
    insert opportunityLineItemList;
    List<string> proName = new List<string>();
    string pro = 'EUR';
    string pro1 = 'EUR';
    proName.add(pro);
    proName.add(pro1);

    Tract_Service_Custom_Field__c serv = new Tract_Service_Custom_Field__c();
    serv.StoreListValue__c = '10';
    insert serv;
    List<OrderUsageRule__c> usageList = new List<OrderUsageRule__c>();
    OrderUsageRule__c orderUseRule = new OrderUsageRule__c();
    orderUseRule.AllowanceType__c = 'UNLIMITED';
    orderUseRule.ProductEid__c = '32933';
    orderUseRule.ProductUsageValue__c = 'Match All Events';
    orderUseRule.RateTypeValue__c = 'Table Rate';
    orderUseRule.ChargeCategoryEid__c = 'test';
    orderUseRule.Status__c = 'Qualify';
    orderUseRule.RuleType__c = 'test';
    orderUseRule.OpportunityID__c = opp.id;
    orderUseRule.Status__c = 'Test';
    orderUseRule.RateTableEid__c = 'Test';
    orderUseRule.UsageRate__c = 20;
    orderUseRule.UsageRateUom__c = 'Test';
    orderUseRule.ProratedOnOrder__c = 'true';
    orderUseRule.ProratedOnCancel__c = 'true';
    usageList.add(orderUseRule);

    OrderUsageRule__c orderUseRule1 = new OrderUsageRule__c();
    orderUseRule1.AllowanceType__c = 'UNLIMITED';
    orderUseRule1.ProductEid__c = '32933';
    orderUseRule1.ProductUsageValue__c = 'Formula';
    orderUseRule1.RateTypeValue__c = 'Table Rate';
    orderUseRule1.ChargeCategoryEid__c = 'test';
    orderUseRule1.Status__c = 'Qualify';
    orderUseRule1.RuleType__c = 'test';
    orderUseRule1.OpportunityID__c = opp.id;
    orderUseRule1.Status__c = 'Test';
    orderUseRule1.RateTableEid__c = 'Test';
    orderUseRule1.UsageRate__c = 20;
    orderUseRule1.UsageRateUom__c = 'Test';
    orderUseRule1.ProratedOnOrder__c = 'true';
    orderUseRule1.ProratedOnCancel__c = 'true';
    usageList.add(orderUseRule1);

    OrderUsageRule__c orderUseRule2 = new OrderUsageRule__c();
    orderUseRule2.AllowanceType__c = 'UNLIMITED';
    orderUseRule2.ProductEid__c = '10';
    orderUseRule2.ProductUsageValue__c = 'test';
    orderUseRule2.RateTypeValue__c = 'Table Rate';
    orderUseRule2.ChargeCategoryEid__c = 'test';
    orderUseRule2.Status__c = 'Qualify';
    orderUseRule2.RuleType__c = 'test';
    orderUseRule2.OpportunityID__c = opp.id;
    orderUseRule2.ProratedOnOrder__c = 'true';
    orderUseRule2.ProratedOnCancel__c = 'true';
    usageList.add(orderUseRule2);

    OrderUsageRule__c orderUseRule3 = new OrderUsageRule__c();
    orderUseRule3.AllowanceType__c = 'UNLIMITED';
    orderUseRule3.ProductEid__c = '32933';
    orderUseRule3.ProductUsageValue__c = 'Global';
    orderUseRule3.RateTypeValue__c = 'Table Rate';
    orderUseRule3.ChargeCategoryEid__c = 'test';
    orderUseRule3.Status__c = 'Qualify';
    orderUseRule3.RuleType__c = 'test';
    orderUseRule3.OpportunityID__c = opp.id;
    orderUseRule3.ProratedOnOrder__c = 'true';
    orderUseRule3.ProratedOnCancel__c = 'true';
    usageList.add(orderUseRule3);
    system.assert(usageList != null);
    insert usageList;

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
    wrap.agreementId = null;
    wrap.OLineItem = oPplineitem2;
    wrap.oliId = oPplineitem2.id;
    wrap.agreementPeriod = 10;
    wrap.newServiceResource = 'test1';
    wrap.discountEid = '5';
    wrapList.add(wrap);
    string jsonstring = Json.serialize(wrap);
    string jsonListstring = Json.serialize(wrapList);
    list<ServiceCustomFieldValuesWrapper> wrap1List = new List<ServiceCustomFieldValuesWrapper>();
    ServiceCustomFieldValuesWrapper servWrap = new ServiceCustomFieldValuesWrapper();
    servWrap.Name = 'test';
    servWrap.checkListtype = true;
    servWrap.Eid = 'test';
    servWrap.Value = 'test';
    wrap1List.add(servWrap);
    string jsonstring1 = Json.serialize(wrap1List);
    list<Schdeule_Charge__c> schdleLst = new List<Schdeule_Charge__c>();
    Schdeule_Charge__c schdle = new Schdeule_Charge__c();
    schdle.Schdeule_Amount__c = '';
    schdle.Schdeule_Description__c = '';
    schdleLst.add(schdle);
    string jsonstring2 = Json.serialize(schdleLst);
    list<ProductUsesWrapper> tractoppList = new List<ProductUsesWrapper>();
    ProductUsesWrapper tractopp = new ProductUsesWrapper();
    tractopp.ChargeName = 'Testcharge';
    tractopp.ChargeType = 'Cash';
    tractopp.Rule = 'test';
    tractopp.UsageRuleEid = '10';
    tractopp.ChargeCategory = '';
    tractopp.FromDate = 'test';
    tractopp.ThruDate = 'test';
    tractopp.recordId = 'test';
    tractopp.ChargeCategory = 'Recurring';
    tractopp.Taper = 'test';
    tractopp.Rate = '10';
    tractopp.FromDate = '5-5-2016';
    tractopp.ThruDate = '6-5-2016';
    tractopp.Status = 'Qualify';
    tractoppList.add(tractopp);
    string jsonstring3 = Json.serialize(tractoppList);
    TractOppProduct_LT.ChargeRulesWrapper chargeRuleWrap = new TractOppProduct_LT.ChargeRulesWrapper();
    chargeRuleWrap.selectStatusListValue = 'Qualified';
    chargeRuleWrap.chargesPicklistValue = 'Flat';
    chargeRuleWrap.chargesPicklistValue2 = 'FLAT';
    chargeRuleWrap.rateTypeListValue = 'TEST';
    chargeRuleWrap.productUsageRuleListValue = 'Match All Events';
    chargeRuleWrap.allowanceTypeListValue = 'Unlimited';
    chargeRuleWrap.prorateOnOrder = true;
    chargeRuleWrap.prorateOnCancel = true;
    chargeRuleWrap.chargeListBytesValue = 'Table Rate';
    string jsonstring4 = Json.serialize(chargeRuleWrap);
    ActivityUsagesWrapper objwrapper = new ActivityUsagesWrapper();
    objwrapper.createdDate = '';
    objwrapper.accountNumber = '';
    objwrapper.serviceID = '';
    AgreementWrapper agWrapper = new AgreementWrapper();
    agWrapper.mapOfAgreementPeriodType = new Map<String, String>();
    agWrapper.hasAgreement = false;

    Tract_Order_Custom_Field__c orderFld = new Tract_Order_Custom_Field__c();
    orderFld.Name = 'Test';
    orderFld.Eid__c = 'Test';
    orderFld.Value__c = 'Test';
    orderFld.Store_Order_List_Value__c = 'Test';
    orderFld.orderCustomFieldType__c = 'LIST';
    system.assert(orderFld != null);
    insert orderFld;
    list<ServiceResourceWrapper> srwList = new List<ServiceResourceWrapper>();
    ServiceResourceWrapper srw = new ServiceResourceWrapper();
    srw.eid = '10';
    srw.identifier = '15';
    srw.errorMessage = 'NotFound';
    srwList.add(srw);
    String sw = JSON.serialize(srwList);

    list<Service_Custom_Field__c> serviceCustomFieldList = new List<Service_Custom_Field__c>();
    Service_Custom_Field__c serviceCustomField = new Service_Custom_Field__c();
    serviceCustomField.name = 'test';
    serviceCustomField.eid__c = 'test';
    serviceCustomField.value__c = 'test';
    serviceCustomField.ProductId__c = oPplineitem1.id;
    serviceCustomFieldList.add(serviceCustomField);

    Service_Custom_Field__c serviceCustomField1 = new Service_Custom_Field__c();
    serviceCustomField1.name = 'test';
    serviceCustomField1.eid__c = 'test';
    serviceCustomField1.value__c = 'test';
    serviceCustomField1.ProductId__c = oPplineitem.id;
    serviceCustomFieldList.add(serviceCustomField1);
    insert serviceCustomFieldList;

    list<Schdeule_Charge__c> scheduleChargesList = new List<Schdeule_Charge__c>();
    Schdeule_Charge__c recurringCharges = new Schdeule_Charge__c();
    recurringCharges.Schdeule_Amount__c = '25';
    recurringCharges.Charge_Type__c = 'Recurring';
    recurringCharges.Schdeule_Description__c = 'Recurring';
    recurringCharges.Schdeule_Date__c = system.today();
    recurringCharges.ProductId__c = oPplineitem1.id;
    scheduleChargesList.add(recurringCharges);

    Schdeule_Charge__c recurringCharges1 = new Schdeule_Charge__c();
    recurringCharges1.Schdeule_Amount__c = '25';
    recurringCharges1.Charge_Type__c = 'Recurring';
    recurringCharges1.Schdeule_Description__c = 'Recurring';
    recurringCharges1.Schdeule_Date__c = system.today();
    recurringCharges1.ProductId__c = oPplineitem.id;
    scheduleChargesList.add(recurringCharges1);

    Schdeule_Charge__c oneTimeCharges = new Schdeule_Charge__c();
    oneTimeCharges.Schdeule_Amount__c = '25';
    oneTimeCharges.Charge_Type__c = 'OneTime';
    oneTimeCharges.Schdeule_Description__c = 'Recurring';
    oneTimeCharges.Schdeule_Date__c = system.today();
    oneTimeCharges.ProductId__c = oPplineitem1.id;
    scheduleChargesList.add(oneTimeCharges);

    Schdeule_Charge__c oneTimeCharges1 = new Schdeule_Charge__c();
    oneTimeCharges1.Schdeule_Amount__c = '25';
    oneTimeCharges1.Charge_Type__c = 'OneTime';
    oneTimeCharges1.Schdeule_Description__c = 'Recurring';
    oneTimeCharges1.Schdeule_Date__c = system.today();
    oneTimeCharges1.ProductId__c = oPplineitem.id;
    scheduleChargesList.add(oneTimeCharges1);

    Schdeule_Charge__c oneTimeCharges2 = new Schdeule_Charge__c();
    oneTimeCharges2.Schdeule_Amount__c = '25';
    oneTimeCharges2.Charge_Type__c = 'OneTime';
    oneTimeCharges2.Schdeule_Description__c = 'Recurring';
    oneTimeCharges2.Schdeule_Date__c = system.today();
    oneTimeCharges2.ProductId__c = oPplineitem2.id;
    scheduleChargesList.add(oneTimeCharges2);
    system.assert(scheduleChargesList != null);
    insert scheduleChargesList;

    test.startTest();
    TractOppProduct_LT.applySrIdToProduct(sw, jsonstring);
    TractOppProduct_LT.getInformation(opp, acc, tract, '123');
    //TractOppProduct_LT.getProductLists(opp.id);
    //TractOppProduct_LT.getProductLists(opp.id);
    //TractOppProduct_LT.getProductPricesApex(jsonstring);
    TractOppProduct_LT.getProductAgreement(prod.id, 'USD');
    TractOppProduct_LT.getOrderCustomField(opp.id);
    TractOppProduct_LT.saveOrderCustomField(jsonstring1, opp.id);
    TractOppProduct_LT.getDisountCode(jsonstring, '');
    TractOppProduct_LT.getServiceResource(jsonstring);
    TractOppProduct_LT.saveScheduleCharges(jsonstring2, 10, '20', prod.id);
    TractOppProduct_LT.showActivityChargeRule('20', opp.id);
    TractOppProduct_LT.getChargeRulesWrapper();
    TractOppProduct_LT.createNewActivityChargeRule(
      jsonstring4,
      jsonstring3,
      '20',
      opp.id
    );
    TractOppProduct_LT.createOrderApex(opp.id);
    TractOppProduct_LT.getOppProductListApex(opp.id);
    TractOppProduct_LT.removeOppProductApex(oPplineitem2, opp.id);
    TractOppProduct_LT.getParentServices(
      opp.Id,
      prodList[0].eid__c,
      jsonListstring
    );
    TractOppProduct_LT.createSalesOrderApex(jsonListstring, opp.id);
    TractOppProduct_LT.createSalesOrderApex(jsonListstring, opp.id);
    TractOppProduct_LT.getRelatedProductNameList('22');
    TractOppProduct_LT.getServiceCustomField(
      '20',
      '[{"checkListtype":false,"Eid":"598","fieldValidationType":"TEXT","Name":"SCF1","ServiceListType":[],"Value":"1"},{"checkListtype":false,"Eid":"604","fieldValidationType":"TEXT","Name":"SCF2","ServiceListType":[],"Value":"3"}]'
    );
    test.stopTest();
  }

  static testMethod void oppProductMethod5() {
    Account acc = HelperClass.getAccount();
    insert acc;
    Pricebook2 pb22 = HelperClass.getPriceBook2();
    insert pb22;
    Price_List__c priceList = HelperClass.getPricelist();
    insert priceList;
    TRACT_Setup__c tract = HelperClass.getAPI2TRACT();
    insert tract;
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

    List<ProductPriceWrapper> ppList = new List<ProductPriceWrapper>();
    ProductPriceWrapper pp = new ProductPriceWrapper();
    pp.priceType = 'Recurring';
    pp.eid = '2342';
    pp.thruDate = system.today();
    pp.currencyType = 'USD';
    pp.priceListEid = '2732';
    pp.recurrencePeriod = 'Month';
    pp.scheduledCharges = false;
    pp.priceOverride = true;

    ProductPriceRangeWrapper priceRange = new ProductPriceRangeWrapper();
    priceRange.price = 20;
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
    pp2.priceOverride = true;

    pp2.priceRangesList = priceRangeList;
    ppList.add(pp2);

    product2[] prodList = new List<product2>();
    product2 prod = new product2();
    prod.Name = 'test';
    prod.PriceLists__c = 'test:12345';
    prod.eid__c = '10';
    prod.IsActive = true;
    prod.description = 'testdescription';
    prod.ProductCode = 'Add-on';
    prod.RuleType__c = 'Test';
    prod.RuleOverride__c = false;
    prod.Agreement_Information__c = JSON.serialize(agreementWrapperList);
    prod.Price_Information__c = JSON.serialize(ppList);
    prod.minServiceResources__c = 1;
    prodList.add(prod);

    product2 prod2 = new product2();
    prod2.Name = 'test';
    prod2.PriceLists__c = 'test:12345';
    prod2.eid__c = '32933';
    prod2.IsActive = true;
    prod2.description = 'testdescription';
    prod2.productCode = 'SUBSCRIPTION';
    prod2.RuleType__c = 'Test';
    prod2.RuleOverride__c = false;
    prod2.Agreement_Information__c = JSON.serialize(agreementWrapperList);
    prod2.Price_Information__c = JSON.serialize(ppList);
    prod2.minServiceResources__c = 1;
    prodList.add(prod2);

    product2 prod3 = new product2();
    prod3.Name = 'test';
    prod3.PriceLists__c = 'test:12345';
    prod3.eid__c = '32934';
    prod3.IsActive = true;
    prod3.description = 'testdescription';
    prod3.productCode = 'One-Time';
    prod3.RuleType__c = 'Test';
    prod3.RuleOverride__c = false;
    prod3.Agreement_Information__c = JSON.serialize(agreementWrapperList);
    prod3.Price_Information__c = JSON.serialize(ppList);
    prodList.add(prod3);

    insert prodList;
    Opportunity opp = new Opportunity();
    opp.Name = 'test';
    opp.stageName = 'Qualification';
    opp.Pricebook2Id = pb22.id;
    opp.AccountId = acc.id;
    opp.closeDate = system.today();
    system.assert(opp != null);
    insert opp;
    Id pricebookId = Test.getStandardPricebookId();
    PricebookEntry standardPrice = new PricebookEntry(
      Pricebook2Id = pricebookId,
      Product2Id = prod.Id,
      UnitPrice = 10000,
      IsActive = true
    );
    insert standardPrice;
    PricebookEntry standardPrice2 = new PricebookEntry(
      Pricebook2Id = pricebookId,
      Product2Id = prod2.Id,
      UnitPrice = 10000,
      IsActive = true
    );
    insert standardPrice2;
    PricebookEntry standardPrice3 = new PricebookEntry(
      Pricebook2Id = pricebookId,
      Product2Id = prod3.Id,
      UnitPrice = 10000,
      IsActive = true
    );
    insert standardPrice3;
    PricebookEntry pbe2 = new PricebookEntry(
      unitprice = 1,
      Product2Id = prod.Id,
      Pricebook2Id = pb22.id,
      isActive = true
    );
    insert pbe2;
    PricebookEntry pbe3 = new PricebookEntry(
      unitprice = 1,
      Product2Id = prod2.Id,
      Pricebook2Id = pb22.id,
      isActive = true
    );
    insert pbe3;
    PricebookEntry pbe4 = new PricebookEntry(
      unitprice = 1,
      Product2Id = prod3.Id,
      Pricebook2Id = pb22.id,
      isActive = true
    );
    insert pbe4;
    List<OpportunityLineItem> opportunityLineItemList = new List<OpportunityLineItem>();
    OpportunityLineItem oPplineitem = new OpportunityLineItem(
      Quantity = 25,
      OpportunityId = opp.Id,
      UnitPrice = 1,
      PriceBookEntryId = pbe2.Id,
      eid__c = '10',
      recurringPrice__c = 20,
      oneTimePrice__c = 15,
      Service__c = prod2.id,
      description = 'Test',
      Discount_eid__c = 'Test',
      Discount__c = 'Test',
      Applied_Agreement_Eid__c = '1234',
      agreementEndAction__c = 'Test',
      overrideAgreementEndDate__c = system.today(),
      Service_Resource_Eid__c = '1234',
      Tract_Service_Resource_Name__c = 'Test',
      New_Service_Resource__c = 'TEST|Tes'
    );
    OpportunityLineItem oPplineitem1 = new OpportunityLineItem(
      Quantity = 25,
      OpportunityId = opp.Id,
      UnitPrice = 1,
      PriceBookEntryId = pbe3.Id,
      eid__c = '32933',
      recurringPrice__c = 20,
      oneTimePrice__c = 15,
      description = 'Test',
      Discount_eid__c = 'Test',
      Discount__c = 'Test',
      Applied_Agreement_Eid__c = '1234',
      agreementEndAction__c = 'Test',
      overrideAgreementEndDate__c = system.today(),
      Service_Resource_Eid__c = '1234',
      Tract_Service_Resource_Name__c = 'Test',
      New_Service_Resource__c = 'TEST|Tes'
    );
    OpportunityLineItem oPplineitem2 = new OpportunityLineItem(
      Quantity = 25,
      OpportunityId = opp.Id,
      UnitPrice = 1,
      PriceBookEntryId = pbe4.Id,
      eid__c = '32934',
      oneTimePrice__c = 15,
      recurringPrice__c = 20,
      description = 'Test'
    );
    opportunityLineItemList.add(oPplineitem);
    opportunityLineItemList.add(oPplineitem1);
    opportunityLineItemList.add(oPplineitem2);
    insert opportunityLineItemList;
    List<string> proName = new List<string>();
    string pro = 'EUR';
    string pro1 = 'EUR';
    proName.add(pro);
    proName.add(pro1);

    //update prod;
    Tract_Service_Custom_Field__c serv = new Tract_Service_Custom_Field__c();
    serv.StoreListValue__c = '10';
    insert serv;
    List<OrderUsageRule__c> usageList = new List<OrderUsageRule__c>();
    OrderUsageRule__c orderUseRule = new OrderUsageRule__c();
    orderUseRule.AllowanceType__c = 'UNLIMITED';
    orderUseRule.ProductEid__c = '20';
    orderUseRule.ProductUsageValue__c = 'Match All Events';
    orderUseRule.RateTypeValue__c = 'Table Rate';
    orderUseRule.ChargeCategoryEid__c = 'test';
    orderUseRule.Status__c = 'Qualify';
    orderUseRule.RuleType__c = 'test';
    orderUseRule.OpportunityID__c = opp.id;
    orderUseRule.Status__c = 'Test';
    orderUseRule.RateTableEid__c = 'Test';
    orderUseRule.UsageRate__c = 20;
    orderUseRule.UsageRateUom__c = 'Test';

    usageList.add(orderUseRule);
    OrderUsageRule__c orderUseRule2 = new OrderUsageRule__c();
    orderUseRule2.AllowanceType__c = 'UNLIMITED';
    orderUseRule2.ProductEid__c = '20';
    orderUseRule2.ProductUsageValue__c = 'test';
    orderUseRule2.RateTypeValue__c = 'Table Rate';
    orderUseRule2.ChargeCategoryEid__c = 'test';
    orderUseRule2.Status__c = 'Qualify';
    orderUseRule2.RuleType__c = 'test';
    orderUseRule2.OpportunityID__c = opp.id;
    usageList.add(orderUseRule2);

    insert orderUseRule;
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
    wrap.agreementId = null;
    wrap.OLineItem = oPplineitem2;
    wrap.oliId = oPplineitem2.id;
    wrap.agreementPeriod = 10;
    wrap.newServiceResource = 'test1';
    wrap.discountEid = '5';
    wrapList.add(wrap);
    string jsonstring = Json.serialize(wrap);
    string jsonListstring = Json.serialize(wrapList);
    list<ServiceCustomFieldValuesWrapper> wrap1List = new List<ServiceCustomFieldValuesWrapper>();
    ServiceCustomFieldValuesWrapper servWrap = new ServiceCustomFieldValuesWrapper();
    servWrap.Name = 'test';
    servWrap.checkListtype = true;
    servWrap.Eid = 'test';
    servWrap.Value = 'test';
    wrap1List.add(servWrap);
    string jsonstring1 = Json.serialize(wrap1List);
    list<Schdeule_Charge__c> schdleLst = new List<Schdeule_Charge__c>();
    Schdeule_Charge__c schdle = new Schdeule_Charge__c();
    schdle.Schdeule_Amount__c = '';
    schdle.Schdeule_Description__c = '';
    schdleLst.add(schdle);
    string jsonstring2 = Json.serialize(schdleLst);
    list<ProductUsesWrapper> tractoppList = new List<ProductUsesWrapper>();
    ProductUsesWrapper tractopp = new ProductUsesWrapper();
    tractopp.ChargeName = 'Testcharge';
    tractopp.ChargeType = 'Cash';
    tractopp.Rule = 'test';
    tractopp.UsageRuleEid = '10';
    tractopp.ChargeCategory = '';
    tractopp.FromDate = 'test';
    tractopp.ThruDate = 'test';
    tractopp.recordId = 'test';
    tractopp.ChargeCategory = 'Recurring';
    tractopp.Taper = 'test';
    tractopp.Rate = '10';
    tractopp.FromDate = '5-5-2016';
    tractopp.ThruDate = '6-5-2016';
    tractopp.Status = 'Qualify';
    tractoppList.add(tractopp);
    string jsonstring3 = Json.serialize(tractoppList);
    TractOppProduct_LT.ChargeRulesWrapper chargeRuleWrap = new TractOppProduct_LT.ChargeRulesWrapper();
    chargeRuleWrap.selectStatusListValue = 'Qualified';
    chargeRuleWrap.chargesPicklistValue = 'Flat';
    chargeRuleWrap.chargesPicklistValue2 = 'FLAT';
    chargeRuleWrap.rateTypeListValue = 'TEST';
    chargeRuleWrap.productUsageRuleListValue = 'Match All Events';
    chargeRuleWrap.allowanceTypeListValue = 'Unlimited';
    chargeRuleWrap.prorateOnOrder = true;
    chargeRuleWrap.prorateOnCancel = true;
    chargeRuleWrap.chargeListBytesValue = 'Table Rate';
    string jsonstring4 = Json.serialize(chargeRuleWrap);
    ActivityUsagesWrapper objwrapper = new ActivityUsagesWrapper();
    objwrapper.createdDate = '';
    objwrapper.accountNumber = '';
    objwrapper.serviceID = '';
    AgreementWrapper agWrapper = new AgreementWrapper();
    agWrapper.mapOfAgreementPeriodType = new Map<String, String>();
    agWrapper.hasAgreement = false;

    Tract_Order_Custom_Field__c orderFld = new Tract_Order_Custom_Field__c();
    orderFld.Name = 'Test';
    orderFld.Eid__c = 'Test';
    orderFld.Value__c = 'Test';
    orderFld.Store_Order_List_Value__c = 'Test';
    orderFld.orderCustomFieldType__c = 'LIST';
    insert orderFld;
    list<ServiceResourceWrapper> srwList = new List<ServiceResourceWrapper>();
    ServiceResourceWrapper srw = new ServiceResourceWrapper();
    srw.eid = '10';
    srw.identifier = '15';
    srw.errorMessage = 'NotFound';
    srwList.add(srw);
    String sw = JSON.serialize(srwList);

    test.startTest();
    TractOppProduct_LT.applySrIdToProduct(sw, jsonstring);
    TractOppProduct_LT.getInformation(opp, acc, tract, '123');
    //TractOppProduct_LT.getProductLists(opp.id);
    //TractOppProduct_LT.getProductLists(opp.id);
    //TractOppProduct_LT.getProductPricesApex(jsonstring);
    TractOppProduct_LT.getProductAgreement(prod.id, 'USD');
    TractOppProduct_LT.getOrderCustomField(opp.id);
    TractOppProduct_LT.saveOrderCustomField(jsonstring1, opp.id);
    TractOppProduct_LT.getDisountCode(jsonstring, '');
    TractOppProduct_LT.getServiceResource(jsonstring);
    TractOppProduct_LT.saveScheduleCharges(jsonstring2, 10, '20', prod.id);
    TractOppProduct_LT.showActivityChargeRule('20', opp.id);
    TractOppProduct_LT.getChargeRulesWrapper();
    TractOppProduct_LT.createNewActivityChargeRule(
      jsonstring4,
      jsonstring3,
      '20',
      opp.id
    );
    TractOppProduct_LT.createOrderApex(opp.id);
    TractOppProduct_LT.getOppProductListApex(opp.id);
    TractOppProduct_LT.removeOppProductApex(oPplineitem2, opp.id);
    TractOppProduct_LT.getParentServices(
      opp.Id,
      prodList[0].eid__c,
      jsonListstring
    );
    TractOppProduct_LT.createSalesOrderApex(jsonListstring, opp.id);
    TractOppProduct_LT.createSalesOrderApex(jsonListstring, opp.id);
    TractOppProduct_LT.getRelatedProductNameList('22');
    //GlobalGTVActions.createOrderApex(opp.id);

    test.stopTest();
  }

  static testMethod void oppProductMethod6() {
    Account acc = HelperClass.getAccount();
    insert acc;
    Pricebook2 pb22 = HelperClass.getPriceBook2();
    insert pb22;
    Price_List__c priceList = HelperClass.getPricelist();
    insert priceList;
    TRACT_Setup__c tract = HelperClass.getAPI1TRACT();
    insert tract;
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

    List<ProductPriceWrapper> ppList = new List<ProductPriceWrapper>();
    ProductPriceWrapper pp = new ProductPriceWrapper();
    pp.priceType = 'Recurring';
    pp.eid = '2342';
    pp.thruDate = system.today();
    pp.currencyType = 'USD';
    pp.priceListEid = '2732';
    pp.recurrencePeriod = 'Month';
    pp.scheduledCharges = false;
    pp.priceOverride = true;

    ProductPriceRangeWrapper priceRange = new ProductPriceRangeWrapper();
    priceRange.price = 20;
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
    pp2.priceOverride = true;

    pp2.priceRangesList = priceRangeList;
    ppList.add(pp2);

    product2[] prodList = new List<product2>();
    product2 prod = new product2();
    prod.Name = 'test';
    prod.PriceLists__c = 'test:12345';
    prod.eid__c = '10';
    prod.IsActive = true;
    prod.description = 'testdescription';
    prod.ProductCode = 'Add-on';
    prod.RuleType__c = 'Test';
    prod.RuleOverride__c = false;
    prod.Agreement_Information__c = JSON.serialize(agreementWrapperList);
    prod.Price_Information__c = JSON.serialize(ppList);
    prod.minServiceResources__c = 1;
    prodList.add(prod);

    product2 prod2 = new product2();
    prod2.Name = 'test';
    prod2.PriceLists__c = 'test:12345';
    prod2.eid__c = '32933';
    prod2.IsActive = true;
    prod2.description = 'testdescription';
    prod2.productCode = 'SUBSCRIPTION';
    prod2.RuleType__c = 'Test';
    prod2.RuleOverride__c = false;
    prod2.Agreement_Information__c = JSON.serialize(agreementWrapperList);
    prod2.Price_Information__c = JSON.serialize(ppList);
    prod2.minServiceResources__c = 1;
    prodList.add(prod2);

    product2 prod3 = new product2();
    prod3.Name = 'test';
    prod3.PriceLists__c = 'test:12345';
    prod3.eid__c = '32934';
    prod3.IsActive = true;
    prod3.description = 'testdescription';
    prod3.productCode = 'One-Time';
    prod3.RuleType__c = 'Test';
    prod3.RuleOverride__c = false;
    prod3.Agreement_Information__c = JSON.serialize(agreementWrapperList);
    prod3.Price_Information__c = JSON.serialize(ppList);
    prodList.add(prod3);

    product2 prod4 = new product2();
    prod4.Name = 'test2';
    prod4.PriceLists__c = 'test:12345';
    prod4.eid__c = '10000';
    prod4.IsActive = true;
    prod4.description = 'testdescription';
    prod4.ProductCode = 'Add-on';
    prod4.RuleType__c = 'Test';
    prod4.RuleOverride__c = false;
    prod4.Agreement_Information__c = JSON.serialize(agreementWrapperList);
    prod4.Price_Information__c = JSON.serialize(ppList);
    prod4.minServiceResources__c = 1;
    prodList.add(prod4);

    insert prodList;
    Opportunity opp = new Opportunity();
    opp.Name = 'test';
    opp.stageName = 'Qualification';
    opp.Pricebook2Id = pb22.id;
    opp.AccountId = acc.id;
    opp.closeDate = system.today();
    system.assert(opp != null);
    insert opp;
    Id pricebookId = Test.getStandardPricebookId();
    PricebookEntry standardPrice = new PricebookEntry(
      Pricebook2Id = pricebookId,
      Product2Id = prod.Id,
      UnitPrice = 10000,
      IsActive = true
    );
    system.assert(standardPrice != null);
    insert standardPrice;
    PricebookEntry standardPrice2 = new PricebookEntry(
      Pricebook2Id = pricebookId,
      Product2Id = prod2.Id,
      UnitPrice = 10000,
      IsActive = true
    );
    system.assert(standardPrice2 != null);
    insert standardPrice2;
    PricebookEntry standardPrice3 = new PricebookEntry(
      Pricebook2Id = pricebookId,
      Product2Id = prod3.Id,
      UnitPrice = 10000,
      IsActive = true
    );
    system.assert(standardPrice3 != null);
    insert standardPrice3;
    PricebookEntry pbe2 = new PricebookEntry(
      unitprice = 1,
      Product2Id = prod.Id,
      Pricebook2Id = pb22.id,
      isActive = true
    );
    system.assert(pbe2 != null);
    insert pbe2;
    PricebookEntry pbe3 = new PricebookEntry(
      unitprice = 1,
      Product2Id = prod2.Id,
      Pricebook2Id = pb22.id,
      isActive = true
    );
    system.assert(pbe3 != null);
    insert pbe3;
    PricebookEntry pbe4 = new PricebookEntry(
      unitprice = 1,
      Product2Id = prod3.Id,
      Pricebook2Id = pb22.id,
      isActive = true
    );
    system.assert(pbe4 != null);
    insert pbe4;
    List<OpportunityLineItem> opportunityLineItemList = new List<OpportunityLineItem>();
    OpportunityLineItem oPplineitem = new OpportunityLineItem(
      Quantity = 25,
      OpportunityId = opp.Id,
      UnitPrice = 1,
      Product2Id = prod4.Id,
      PriceBookEntryId = pbe2.Id,
      eid__c = '10',
      recurringPrice__c = 20,
      oneTimePrice__c = 15,
      Service__c = prod2.id,
      description = 'Test',
      Discount_eid__c = 'Test',
      Discount__c = 'Test',
      Applied_Agreement_Eid__c = '1234',
      agreementEndAction__c = 'Test',
      overrideAgreementEndDate__c = system.today(),
      New_Service_Resource__c = 'TEST|Tes',
      ParentServiceEid__c = '12345'
    );
    OpportunityLineItem oPplineitem1 = new OpportunityLineItem(
      Quantity = 25,
      OpportunityId = opp.Id,
      UnitPrice = 1,
      PriceBookEntryId = pbe3.Id,
      eid__c = '32933',
      recurringPrice__c = 20,
      oneTimePrice__c = 15,
      description = 'Test',
      Discount_eid__c = 'Test',
      Discount__c = 'Test',
      Applied_Agreement_Eid__c = '1234',
      agreementEndAction__c = 'Test',
      overrideAgreementEndDate__c = system.today(),
      New_Service_Resource__c = 'TEST|Tes'
    );
    OpportunityLineItem oPplineitem2 = new OpportunityLineItem(
      Quantity = 25,
      OpportunityId = opp.Id,
      UnitPrice = 1,
      PriceBookEntryId = pbe4.Id,
      eid__c = '32934',
      oneTimePrice__c = 15,
      recurringPrice__c = 20,
      description = 'Test'
    );
    OpportunityLineItem oPplineitem3 = new OpportunityLineItem(
      Quantity = 25,
      OpportunityId = opp.Id,
      Product2Id = prod.Id,
      UnitPrice = 1,
      PriceBookEntryId = pbe4.Id,
      eid__c = '32935',
      oneTimePrice__c = 15,
      recurringPrice__c = 20,
      description = 'Test',
      Service__c = prod4.id
    );
    opportunityLineItemList.add(oPplineitem);
    opportunityLineItemList.add(oPplineitem1);
    opportunityLineItemList.add(oPplineitem2);
    opportunityLineItemList.add(oPplineitem3);
    insert opportunityLineItemList;
    List<string> proName = new List<string>();
    string pro = 'EUR';
    string pro1 = 'EUR';
    proName.add(pro);
    proName.add(pro1);

    Tract_Service_Custom_Field__c serv = new Tract_Service_Custom_Field__c();
    serv.StoreListValue__c = '10';
    insert serv;
    List<OrderUsageRule__c> usageList = new List<OrderUsageRule__c>();
    OrderUsageRule__c orderUseRule = new OrderUsageRule__c();
    orderUseRule.AllowanceType__c = 'UNLIMITED';
    orderUseRule.ProductEid__c = '32933';
    orderUseRule.ProductUsageValue__c = 'Match All Events';
    orderUseRule.RateTypeValue__c = 'Table Rate';
    orderUseRule.ChargeCategoryEid__c = 'test';
    orderUseRule.Status__c = 'Qualify';
    orderUseRule.RuleType__c = 'test';
    orderUseRule.OpportunityID__c = opp.id;
    orderUseRule.Status__c = 'Test';
    orderUseRule.RateTableEid__c = 'Test';
    orderUseRule.UsageRate__c = 20;
    orderUseRule.UsageRateUom__c = 'Test';
    orderUseRule.ProratedOnOrder__c = 'true';
    orderUseRule.ProratedOnCancel__c = 'true';
    usageList.add(orderUseRule);

    OrderUsageRule__c orderUseRule1 = new OrderUsageRule__c();
    orderUseRule1.AllowanceType__c = 'UNLIMITED';
    orderUseRule1.ProductEid__c = '32933';
    orderUseRule1.ProductUsageValue__c = 'Formula';
    orderUseRule1.RateTypeValue__c = 'Table Rate';
    orderUseRule1.ChargeCategoryEid__c = 'test';
    orderUseRule1.Status__c = 'Qualify';
    orderUseRule1.RuleType__c = 'test';
    orderUseRule1.OpportunityID__c = opp.id;
    orderUseRule1.Status__c = 'Test';
    orderUseRule1.RateTableEid__c = 'Test';
    orderUseRule1.UsageRate__c = 20;
    orderUseRule1.UsageRateUom__c = 'Test';
    orderUseRule1.ProratedOnOrder__c = 'true';
    orderUseRule1.ProratedOnCancel__c = 'true';
    usageList.add(orderUseRule1);

    OrderUsageRule__c orderUseRule2 = new OrderUsageRule__c();
    orderUseRule2.AllowanceType__c = 'UNLIMITED';
    orderUseRule2.ProductEid__c = '10';
    orderUseRule2.ProductUsageValue__c = 'test';
    orderUseRule2.RateTypeValue__c = 'Table Rate';
    orderUseRule2.ChargeCategoryEid__c = 'test';
    orderUseRule2.Status__c = 'Qualify';
    orderUseRule2.RuleType__c = 'test';
    orderUseRule2.OpportunityID__c = opp.id;
    orderUseRule2.ProratedOnOrder__c = 'true';
    orderUseRule2.ProratedOnCancel__c = 'true';
    usageList.add(orderUseRule2);

    OrderUsageRule__c orderUseRule3 = new OrderUsageRule__c();
    orderUseRule3.AllowanceType__c = 'UNLIMITED';
    orderUseRule3.ProductEid__c = '32933';
    orderUseRule3.ProductUsageValue__c = 'Global';
    orderUseRule3.RateTypeValue__c = 'Table Rate';
    orderUseRule3.ChargeCategoryEid__c = 'test';
    orderUseRule3.Status__c = 'Qualify';
    orderUseRule3.RuleType__c = 'test';
    orderUseRule3.OpportunityID__c = opp.id;
    orderUseRule3.ProratedOnOrder__c = 'true';
    orderUseRule3.ProratedOnCancel__c = 'true';
    usageList.add(orderUseRule3);
    insert usageList;

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
    wrap.agreementId = null;
    wrap.OLineItem = oPplineitem2;
    wrap.oliId = oPplineitem2.id;
    wrap.agreementPeriod = 10;
    wrap.newServiceResource = 'test1';
    wrap.discountEid = '5';
    wrapList.add(wrap);
    string jsonstring = Json.serialize(wrap);
    string jsonListstring = Json.serialize(wrapList);
    list<ServiceCustomFieldValuesWrapper> wrap1List = new List<ServiceCustomFieldValuesWrapper>();
    ServiceCustomFieldValuesWrapper servWrap = new ServiceCustomFieldValuesWrapper();
    servWrap.Name = 'test';
    servWrap.checkListtype = true;
    servWrap.Eid = 'test';
    servWrap.Value = 'test';
    wrap1List.add(servWrap);
    string jsonstring1 = Json.serialize(wrap1List);
    list<Schdeule_Charge__c> schdleLst = new List<Schdeule_Charge__c>();
    Schdeule_Charge__c schdle = new Schdeule_Charge__c();
    schdle.Schdeule_Amount__c = '';
    schdle.Schdeule_Description__c = '';
    schdleLst.add(schdle);
    string jsonstring2 = Json.serialize(schdleLst);
    list<ProductUsesWrapper> tractoppList = new List<ProductUsesWrapper>();
    ProductUsesWrapper tractopp = new ProductUsesWrapper();
    tractopp.ChargeName = 'Testcharge';
    tractopp.ChargeType = 'Cash';
    tractopp.Rule = 'test';
    tractopp.UsageRuleEid = '10';
    tractopp.ChargeCategory = '';
    tractopp.FromDate = 'test';
    tractopp.ThruDate = 'test';
    tractopp.recordId = 'test';
    tractopp.ChargeCategory = 'Recurring';
    tractopp.Taper = 'test';
    tractopp.Rate = '10';
    tractopp.FromDate = '5-5-2016';
    tractopp.ThruDate = '6-5-2016';
    tractopp.Status = 'Qualify';
    tractoppList.add(tractopp);
    string jsonstring3 = Json.serialize(tractoppList);
    TractOppProduct_LT.ChargeRulesWrapper chargeRuleWrap = new TractOppProduct_LT.ChargeRulesWrapper();
    chargeRuleWrap.selectStatusListValue = 'Qualified';
    chargeRuleWrap.chargesPicklistValue = 'Flat';
    chargeRuleWrap.chargesPicklistValue2 = 'FLAT';
    chargeRuleWrap.rateTypeListValue = 'TEST';
    chargeRuleWrap.productUsageRuleListValue = 'Match All Events';
    chargeRuleWrap.allowanceTypeListValue = 'Unlimited';
    chargeRuleWrap.prorateOnOrder = true;
    chargeRuleWrap.prorateOnCancel = true;
    chargeRuleWrap.chargeListBytesValue = 'Table Rate';
    string jsonstring4 = Json.serialize(chargeRuleWrap);
    ActivityUsagesWrapper objwrapper = new ActivityUsagesWrapper();
    objwrapper.createdDate = '';
    objwrapper.accountNumber = '';
    objwrapper.serviceID = '';
    AgreementWrapper agWrapper = new AgreementWrapper();
    agWrapper.mapOfAgreementPeriodType = new Map<String, String>();
    agWrapper.hasAgreement = false;

    Tract_Order_Custom_Field__c orderFld = new Tract_Order_Custom_Field__c();
    orderFld.Name = 'Test';
    orderFld.Eid__c = 'Test';
    orderFld.Value__c = 'Test';
    orderFld.Store_Order_List_Value__c = 'Test';
    orderFld.orderCustomFieldType__c = 'LIST';
    system.assert(orderFld != null);
    insert orderFld;
    list<ServiceResourceWrapper> srwList = new List<ServiceResourceWrapper>();
    ServiceResourceWrapper srw = new ServiceResourceWrapper();
    srw.eid = '10';
    srw.identifier = '15';
    srw.errorMessage = 'NotFound';
    srwList.add(srw);
    String sw = JSON.serialize(srwList);

    test.startTest();
    TractOppProduct_LT.applySrIdToProduct(sw, jsonstring);
    TractOppProduct_LT.getInformation(opp, acc, tract, '123');
    //TractOppProduct_LT.getProductLists(opp.id);
    //TractOppProduct_LT.getProductLists(opp.id);
    //TractOppProduct_LT.getProductPricesApex(jsonstring);
    TractOppProduct_LT.getProductAgreement(prod.id, 'USD');
    TractOppProduct_LT.getOrderCustomField(opp.id);
    TractOppProduct_LT.saveOrderCustomField(jsonstring1, opp.id);
    TractOppProduct_LT.getDisountCode(jsonstring, '');
    TractOppProduct_LT.getServiceResource(jsonstring);
    TractOppProduct_LT.saveScheduleCharges(jsonstring2, 10, '20', prod.id);
    TractOppProduct_LT.showActivityChargeRule('20', opp.id);
    TractOppProduct_LT.getChargeRulesWrapper();
    TractOppProduct_LT.createNewActivityChargeRule(
      jsonstring4,
      jsonstring3,
      '20',
      opp.id
    );
    TractOppProduct_LT.createOrderApex(opp.id);
    // GTVService.createOrder(opp.id);
    //GlobalGTVActions.createOrderApex(opp.id);
    TractOppProduct_LT.getOppProductListApex(opp.id);
    //TractOppProduct_LT.removeOppProductApex(oPplineitem2,opp.id);
    TractOppProduct_LT.getParentServices(
      opp.Id,
      prodList[0].eid__c,
      jsonListstring
    );
    TractOppProduct_LT.createSalesOrderApex(jsonListstring, opp.id);
    TractOppProduct_LT.createSalesOrderApex(jsonListstring, opp.id);
    TractOppProduct_LT.getRelatedProductNameList('22');
    TractOppProduct_LT.getServiceCustomField(
      '20',
      '[{"checkListtype":false,"Eid":"598","fieldValidationType":"TEXT","Name":"SCF1","ServiceListType":[],"Value":"1"},{"checkListtype":false,"Eid":"604","fieldValidationType":"TEXT","Name":"SCF2","ServiceListType":[],"Value":"3"}]'
    );
    test.stopTest();
  }

  static testMethod void oppProductMethod8() {
    Product2 pro = HelperClass.getProduct2();
    pro.Price_Information__c = '[{"thruDate":null,"scheduledCharges":false,"recurringPaymentRequired":false,"recurrencePeriod":"MONTH","priceType":"Recurring","priceRangesList":[{"quantityEndRange":null,"quantityBeginRange":0.00,"price":100.00,"level":1,"eid":"14702","currencyType":"USD"}],"priceOverride":true,"priceListEid":"228","paymentOnPurchaseRequired":false,"fromDate":"2014-11-07T06:00:00.000Z","eid":"123456","currencyType":"USD"},{"thruDate":null,"scheduledCharges":false,"recurringPaymentRequired":false,"recurrencePeriod":"BILLCYCLE","priceType":"OneTime","priceRangesList":[{"quantityEndRange":1.00,"quantityBeginRange":0.00,"price":5.00,"level":1,"eid":"47138","currencyType":"USD"},{"quantityEndRange":null,"quantityBeginRange":1.00,"price":0.00,"level":2,"eid":"47140","currencyType":"USD"}],"priceOverride":true,"priceListEid":"12345","paymentOnPurchaseRequired":false,"fromDate":"2018-08-30T05:00:00.000Z","eid":"123456","currencyType":"USD"}]';
    pro.Serialized__c = true;
    insert pro;

    Opportunity opp = HelperClass.getOpportunity();
    insert opp;

    Id pricebookId = Test.getStandardPricebookId();

    PricebookEntry pricebookEntryobj = new PricebookEntry();
    pricebookEntryobj.Pricebook2Id = pricebookId;
    pricebookEntryobj.Product2Id = pro.Id;
    pricebookEntryobj.product2 = pro;
    pricebookEntryobj.UnitPrice = 10000;
    pricebookEntryobj.IsActive = true;
    system.assert(pricebookEntryobj != null);
    insert pricebookEntryobj;

    OpportunityLineItem opportunityLineItemObj = new OpportunityLineItem();
    opportunityLineItemObj.PricebookEntryId = pricebookEntryobj.id;
    opportunityLineItemObj.TotalPrice = 2000;
    opportunityLineItemObj.Quantity = 2;
    opportunityLineItemObj.eid__c = '12345';
    opportunityLineItemObj.username__c = 'user';
    opportunityLineItemObj.Email__c = 'ravi.6380@yahoo.com';
    opportunityLineItemObj.RecurringPrice__c = 100;
    opportunityLineItemObj.OneTimePrice__c = 500;
    opportunityLineItemObj.priceList_Eid__c = '12345';
    opportunityLineItemObj.OpportunityId = opp.Id;
    opportunityLineItemObj.Price_Override__c = false;
    opportunityLineItemObj.RecurringProductPriceEid__c = '123456';

    insert opportunityLineItemObj;

    OpportunityLineItem opportunityLineItemObj2 = new OpportunityLineItem();
    opportunityLineItemObj2.PricebookEntryId = pricebookEntryobj.id;
    opportunityLineItemObj2.TotalPrice = 2000;
    opportunityLineItemObj2.Quantity = 2;
    opportunityLineItemObj2.eid__c = '12345';
    opportunityLineItemObj2.username__c = 'user';
    opportunityLineItemObj2.Email__c = 'ravi.6380@yahoo.com';
    opportunityLineItemObj2.RecurringPrice__c = 100;
    opportunityLineItemObj2.OneTimePrice__c = 500;

    opportunityLineItemObj2.OpportunityId = opp.Id;
    opportunityLineItemObj2.Price_Override__c = false;
    opportunityLineItemObj2.RecurringProductPriceEid__c = '123456';

    insert opportunityLineItemObj2;

    delete opportunityLineItemObj;
  }
  static testMethod void oppProductMethod9() {
    Product2 pro = HelperClass.getProduct2();
    pro.Price_Information__c = '[{"thruDate":null,"scheduledCharges":false,"recurringPaymentRequired":false,"recurrencePeriod":"MONTH","priceType":"Recurring","priceRangesList":[{"quantityEndRange":1,"quantityBeginRange":0.00,"price":null,"level":1,"eid":"14702","currencyType":"USD"}],"priceOverride":true,"priceListEid":"228","paymentOnPurchaseRequired":false,"fromDate":"2014-11-07T06:00:00.000Z","eid":"123456","currencyType":"USD"},{"thruDate":null,"scheduledCharges":false,"recurringPaymentRequired":false,"recurrencePeriod":"BILLCYCLE","priceType":"OneTime","priceRangesList":[{"quantityEndRange":1.00,"quantityBeginRange":0.00,"price":5.00,"level":1,"eid":"47138","currencyType":"USD"},{"quantityEndRange":null,"quantityBeginRange":1.00,"price":0.00,"level":2,"eid":"47140","currencyType":"USD"}],"priceOverride":true,"priceListEid":"12345","paymentOnPurchaseRequired":false,"fromDate":"2018-08-30T05:00:00.000Z","eid":"123456","currencyType":"USD"}]';
    pro.Serialized__c = true;
    insert pro;

    Opportunity opp = HelperClass.getOpportunity();
    insert opp;

    Id pricebookId = Test.getStandardPricebookId();

    PricebookEntry pricebookEntryobj = new PricebookEntry();
    pricebookEntryobj.Pricebook2Id = pricebookId;
    pricebookEntryobj.Product2Id = pro.Id;
    pricebookEntryobj.product2 = pro;
    pricebookEntryobj.UnitPrice = 10000;
    pricebookEntryobj.IsActive = true;
    system.assert(pricebookEntryobj != null);
    insert pricebookEntryobj;

    OpportunityLineItem opportunityLineItemObj = new OpportunityLineItem();
    opportunityLineItemObj.PricebookEntryId = pricebookEntryobj.id;
    opportunityLineItemObj.TotalPrice = 2000;
    opportunityLineItemObj.Quantity = 2;
    opportunityLineItemObj.eid__c = '12345';
    opportunityLineItemObj.username__c = 'user';
    opportunityLineItemObj.Email__c = 'ravi.6380@yahoo.com';
    opportunityLineItemObj.RecurringPrice__c = 100;
    opportunityLineItemObj.OneTimePrice__c = 500;
    opportunityLineItemObj.priceList_Eid__c = '12345';
    opportunityLineItemObj.OpportunityId = opp.Id;
    opportunityLineItemObj.Price_Override__c = false;
    opportunityLineItemObj.RecurringProductPriceEid__c = '123456';

    insert opportunityLineItemObj;

    OpportunityLineItem opportunityLineItemObj2 = new OpportunityLineItem();
    opportunityLineItemObj2.PricebookEntryId = pricebookEntryobj.id;
    opportunityLineItemObj2.TotalPrice = 2000;
    opportunityLineItemObj2.Quantity = 2;
    opportunityLineItemObj2.eid__c = '12345';
    opportunityLineItemObj2.username__c = 'user';
    opportunityLineItemObj2.Email__c = 'ravi.6380@yahoo.com';
    opportunityLineItemObj2.RecurringPrice__c = 100;
    opportunityLineItemObj2.OneTimePrice__c = 500;

    opportunityLineItemObj2.OpportunityId = opp.Id;
    opportunityLineItemObj2.Price_Override__c = false;
    opportunityLineItemObj2.RecurringProductPriceEid__c = '123456';

    insert opportunityLineItemObj2;

    delete opportunityLineItemObj;
  }
  static testMethod void oppProductMethod10() {
    Product2 pro = HelperClass.getProduct2();
    pro.Price_Information__c = '[{"thruDate":null,"scheduledCharges":false,"recurringPaymentRequired":false,"recurrencePeriod":"MONTH","priceType":"Recurring","priceRangesList":[{"quantityEndRange":1,"quantityBeginRange":0.00,"price":null,"level":1,"eid":"14702","currencyType":"USD"}],"priceOverride":true,"priceListEid":"228","paymentOnPurchaseRequired":false,"fromDate":"2014-11-07T06:00:00.000Z","eid":"123456","currencyType":"USD"},{"thruDate":null,"scheduledCharges":false,"recurringPaymentRequired":false,"recurrencePeriod":"BILLCYCLE","priceType":"OneTime","priceRangesList":[{"quantityEndRange":null,"quantityBeginRange":0.00,"price":null,"level":1,"eid":"47138","currencyType":"USD"},{"quantityEndRange":null,"quantityBeginRange":1.00,"price":0.00,"level":2,"eid":"47140","currencyType":"USD"}],"priceOverride":true,"priceListEid":"12345","paymentOnPurchaseRequired":false,"fromDate":"2018-08-30T05:00:00.000Z","eid":"123456","currencyType":"USD"}]';
    pro.Serialized__c = true;
    insert pro;

    Opportunity opp = HelperClass.getOpportunity();
    insert opp;

    Id pricebookId = Test.getStandardPricebookId();

    PricebookEntry pricebookEntryobj = new PricebookEntry();
    pricebookEntryobj.Pricebook2Id = pricebookId;
    pricebookEntryobj.Product2Id = pro.Id;
    pricebookEntryobj.product2 = pro;
    pricebookEntryobj.UnitPrice = 10000;
    pricebookEntryobj.IsActive = true;
    system.assert(pricebookEntryobj != null);
    insert pricebookEntryobj;

    OpportunityLineItem opportunityLineItemObj = new OpportunityLineItem();
    opportunityLineItemObj.PricebookEntryId = pricebookEntryobj.id;
    opportunityLineItemObj.TotalPrice = 2000;
    opportunityLineItemObj.Quantity = 2;
    opportunityLineItemObj.eid__c = '12345';
    opportunityLineItemObj.username__c = 'user';
    opportunityLineItemObj.Email__c = 'ravi.6380@yahoo.com';
    opportunityLineItemObj.RecurringPrice__c = 100;
    opportunityLineItemObj.OneTimePrice__c = 500;
    opportunityLineItemObj.priceList_Eid__c = '12345';
    opportunityLineItemObj.OpportunityId = opp.Id;
    opportunityLineItemObj.Price_Override__c = false;
    opportunityLineItemObj.RecurringProductPriceEid__c = '123456';

    insert opportunityLineItemObj;

    OpportunityLineItem opportunityLineItemObj2 = new OpportunityLineItem();
    opportunityLineItemObj2.PricebookEntryId = pricebookEntryobj.id;
    opportunityLineItemObj2.TotalPrice = 2000;
    opportunityLineItemObj2.Quantity = 2;
    opportunityLineItemObj2.eid__c = '12345';
    opportunityLineItemObj2.username__c = 'user';
    opportunityLineItemObj2.Email__c = 'ravi.6380@yahoo.com';
    opportunityLineItemObj2.RecurringPrice__c = 100;
    opportunityLineItemObj2.OneTimePrice__c = 500;

    opportunityLineItemObj2.OpportunityId = opp.Id;
    opportunityLineItemObj2.Price_Override__c = false;
    opportunityLineItemObj2.RecurringProductPriceEid__c = '123456';

    insert opportunityLineItemObj2;

    delete opportunityLineItemObj;
  }

  static testMethod void oppProductMethod11() {
    Account acc = HelperClass.getAccount();
    insert acc;

    TRACT_Setup__c tract = HelperClass.getAPI2TRACT();
    insert tract;

    Pricebook2 pb22 = HelperClass.getPriceBook2();
    insert pb22;

    Product2 pro = HelperClass.getProduct2();
    pro.Price_Information__c = '[{"thruDate":null,"scheduledCharges":false,"recurringPaymentRequired":false,"recurrencePeriod":"MONTH","priceType":"Recurring","priceRangesList":[{"quantityEndRange":1,"quantityBeginRange":0.00,"price":null,"level":1,"eid":"14702","currencyType":"USD"}],"priceOverride":true,"priceListEid":"228","paymentOnPurchaseRequired":false,"fromDate":"2014-11-07T06:00:00.000Z","eid":"123456","currencyType":"USD"},{"thruDate":null,"scheduledCharges":false,"recurringPaymentRequired":false,"recurrencePeriod":"BILLCYCLE","priceType":"OneTime","priceRangesList":[{"quantityEndRange":null,"quantityBeginRange":0.00,"price":null,"level":1,"eid":"47138","currencyType":"USD"},{"quantityEndRange":null,"quantityBeginRange":1.00,"price":0.00,"level":2,"eid":"47140","currencyType":"USD"}],"priceOverride":true,"priceListEid":"12345","paymentOnPurchaseRequired":false,"fromDate":"2018-08-30T05:00:00.000Z","eid":"123456","currencyType":"USD"}]';
    pro.Serialized__c = true;
    insert pro;

    Opportunity opp = HelperClass.getOpportunity();
    opp.Tract_Sales_Order__c = null;
    opp.AccountId = acc.id;
    insert opp;

    Id pricebookId = Test.getStandardPricebookId();

    PricebookEntry pricebookEntryobj = new PricebookEntry();
    pricebookEntryobj.Pricebook2Id = pricebookId;
    pricebookEntryobj.Product2Id = pro.Id;
    pricebookEntryobj.product2 = pro;
    pricebookEntryobj.UnitPrice = 10000;
    pricebookEntryobj.IsActive = true;
    system.assert(pricebookEntryobj != null);
    insert pricebookEntryobj;

    TractOppProduct_LT.getActiveServiceList(opp.Id);
  }
}