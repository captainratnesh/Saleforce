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
 * This class is a test class of GlobalGTVActions class.
 * @author Aman Jain
 */

@isTest
public class GlobalGTVActions_test {
  @isTest
  public static void gtvActionsTest1() {
    TRACT_Setup__c tractSetup = HelperClass.getAPI1TRACT();
    insert tractSetup;
    Account acc = HelperClass.getAccount();
    acc.Tract_Billing_Account__c = null;
    insert acc;
    Pricebook2 pb22 = HelperClass.getPriceBook2();
    insert pb22;
    Opportunity opp = HelperClass.getOpportunity();
    opp.Pricebook2Id = pb22.id;
    opp.AccountId = acc.id;
    insert opp;
    GTVAccount gtvAccountWrapper = new GTVAccount();
    gtvAccountWrapper.accountName = 'Test Account';
    gtvAccountWrapper.currencyType = 'USD';
    gtvAccountWrapper.billingAccountCategoryName = 'testBill';
    gtvAccountWrapper.billCycleName = 'testBill';
    gtvAccountWrapper.paymentTermName = 'Net 30';
    gtvAccountWrapper.billingStreet = 'Test Street';
    gtvAccountWrapper.billingCity = 'Austin';
    gtvAccountWrapper.billingState = 'TX';
    gtvAccountWrapper.billingCountry = 'US';
    gtvAccountWrapper.billingPostalCode = '78701';
    gtvAccountWrapper.shippingStreet = 'Test Street';
    gtvAccountWrapper.shippingCity = 'Austin';
    gtvAccountWrapper.shippingState = 'TX';
    gtvAccountWrapper.shippingCountry = 'US';
    gtvAccountWrapper.shippingPostalCode = '78701';
    gtvAccountWrapper.email = 'testmail@gmail.com';
    gtvAccountWrapper.phone = '7894561237';
    gtvAccountWrapper.billType = 'EMAIL';
    gtvAccountWrapper.taxExempt = true;
    gtvAccountWrapper.createDate = system.today();

    Test.startTest();
    GTVService service = new GTVService();
    service.createAccount(acc.id);
    service.createOrder(opp.id);
    service.createAccount(acc.Id, gtvAccountWrapper);
    GlobalGTVActions.createBillingAccount(acc.id);
    GlobalGTVActions.createGotransverseSalesOrder(new Map<String, String>());
    GlobalGTVActions.createGotransverseDraftOrder(new Map<String, String>());
    GlobalGTVActions.createOrderApex(opp.id);
    GlobalGTVActions.createGTVOrder(opp.id);

    Test.stopTest();
  }
  @isTest
  public static void gtvActionsTest2() {
    TRACT_Setup__c tractSetup = HelperClass.getAPI1TRACT();
    insert tractSetup;

    TRACTBillingAccountCategory__c tractBilling = HelperClass.getAccountCategory();
    insert tractBilling;

    TRACT_Bill_Cycle__c billcycle = HelperClass.getBillCycle();
    insert billcycle;

    Payment_Term__c paymentTerms = HelperClass.getPaymentTerms();
    insert paymentTerms;

    Account acc = HelperClass.getAccount();
    acc.Tract_Billing_Account__c = null;
    acc.GTV_Account_Category__c = 'testType';
    acc.GTV_Payment_Term__c = 'Net 30';
    acc.GTV_Bill_Cycle__c = 'testBill';
    insert acc;

    Account account = HelperClass.getAccount();
    account.Tract_Billing_Account__c = '1234';
    insert account;

    Contact con = new Contact();
    con.FirstName = 'test';
    con.lastName = 'testCon';
    con.MailingCity = 'test';
    con.MailingCountry = 'USA test';
    con.MailingPostalCode = '123456';
    con.AccountId = acc.id;
    insert con;

    GTVAccount gtvAccountWrapper = new GTVAccount();
    gtvAccountWrapper.accountName = 'Test Account';
    gtvAccountWrapper.currencyType = 'USD';
    gtvAccountWrapper.billingAccountCategoryName = 'testBill';
    gtvAccountWrapper.billCycleName = 'testBill';
    gtvAccountWrapper.paymentTermName = 'Net 30';
    gtvAccountWrapper.billingStreet = 'Test Street';
    gtvAccountWrapper.billingCity = 'Austin';
    gtvAccountWrapper.billingState = 'TX';
    gtvAccountWrapper.billingCountry = 'US';
    gtvAccountWrapper.billingPostalCode = '78701';
    gtvAccountWrapper.shippingStreet = 'Test Street';
    gtvAccountWrapper.shippingCity = 'Austin';
    gtvAccountWrapper.shippingState = 'TX';
    gtvAccountWrapper.shippingCountry = 'US';
    gtvAccountWrapper.shippingPostalCode = '78701';
    gtvAccountWrapper.email = 'testmail@gmail.com';
    gtvAccountWrapper.phone = '7894561237';
    gtvAccountWrapper.billType = 'EMAIL';
    gtvAccountWrapper.taxExempt = true;
    gtvAccountWrapper.createDate = system.today();

    GTVOrder gtvOrder = new GTVOrder();
    gtvOrder.orderStatus = 'CONFIRMED';
    gtvOrder.orderDate = String.Valueof(System.today());
    gtvOrder.note = 'This order is created through global method';
    gtvOrder.purchaseOrderNumber = 'Test Purchase Order Number';
    gtvOrder.emailReceipt = true;
    gtvOrder.orderCustomFieldValues = new List<GTVOrder.GTVCustomFieldValue>();
    GTVOrder.GTVCustomFieldValue orderCustomFieldValue = new GTVOrder.GTVCustomFieldValue();
    orderCustomFieldValue.id = '2210';
    orderCustomFieldValue.value = 'Test Value';
    gtvOrder.orderCustomFieldValues.add(orderCustomFieldValue);
    gtvOrder.orderItems = new List<GTVOrder.GTVOrderItem>();
    GTVOrder.GTVOrderItem firstOrderItem = new GTVOrder.GTVOrderItem();
    firstOrderItem.quantity = 5;
    firstOrderItem.description = 'Quaterly Subscription';
    firstOrderItem.product = new GTVOrder.GTVProduct();
    firstOrderItem.product.id = '17330';
    firstOrderItem.product.name = 'Subprod 8/23';
    firstOrderItem.product.productType = 'customer-subscription';
    firstOrderItem.priceListId = '696';
    firstOrderItem.sequence = 123456;
    firstOrderItem.requestedEffectiveDate = System.now();
    firstOrderItem.overrideTrialDays = 7;
    firstOrderItem.orderItemAgreement = new GTVOrder.GTVAgreement();
    firstOrderItem.orderItemAgreement.agreementId = '4348';
    firstOrderItem.orderItemAgreement.endDate = system.now() + 100;
    firstOrderItem.orderItemAgreement.endAction = 'RENEW_AGREEMENT';
    firstOrderItem.orderItemAgreement.agreementPeriod = 5;
    firstOrderItem.orderItemAgreement.preserveServicePrice = true;
    firstOrderItem.serviceResources = new List<GTVOrder.GTVServiceResource>();
    GTVOrder.GTVServiceResource serviceResource = new GTVOrder.GTVServiceResource();
    serviceResource.id = '34082';
    serviceResource.identifier = 'SI87';
    serviceResource.description = 'Quaterly subscription service resource';
    serviceResource.resourceCategoryId = '1266';
    firstOrderItem.serviceResources.add(serviceResource);
    firstOrderItem.orderItemDiscount = new GTVOrder.GTVDiscount();
    firstOrderItem.orderItemDiscount.id = '56738';
    firstOrderItem.orderItemDiscount.identifier = '0034';
    firstOrderItem.orderItemCustomFieldValues = new List<GTVOrder.GTVCustomFieldValue>();
    GTVOrder.GTVCustomFieldValue customFieldValue = new GTVOrder.GTVCustomFieldValue();
    customFieldValue.id = '2210';
    customFieldValue.value = 'Test Value';
    firstOrderItem.orderItemCustomFieldValues.add(customFieldValue);
    firstOrderItem.orderItemPrices = new List<GTVOrder.GTVPrice>();
    GTVOrder.GTVPrice orderItemPrice = new GTVOrder.GTVPrice();
    orderItemPrice.priceType = 'recurring';
    orderItemPrice.id = '20510';
    orderItemPrice.priceRanges = new List<GTVOrder.GTVPriceRange>();
    GTVOrder.GTVPriceRange priceRange1 = new GTVOrder.GTVPriceRange();
    priceRange1.price = 20;
    priceRange1.quantityBeginRange = 0;
    priceRange1.quantityEndRange = 1;
    priceRange1.level = 1;
    priceRange1.currencyCode = 'USD';
    GTVOrder.GTVPriceRange priceRange2 = new GTVOrder.GTVPriceRange();
    priceRange2.price = 20;
    priceRange2.quantityBeginRange = 1;
    priceRange2.level = 2;
    priceRange2.currencyCode = 'USD';
    orderItemPrice.priceRanges.add(priceRange1);
    orderItemPrice.priceRanges.add(priceRange2);
    orderItemPrice.usageRules = new List<GTVOrder.GTVUsageRule>();
    GTVOrder.GTVUsageRule usageRule = new GTVOrder.GTVUsageRule();
    usageRule.Name = 'Usage 1';
    usageRule.status = 'Active';
    usageRule.allowanceAmount = 100;
    usageRule.allowanceUom = 'Minute';
    usageRule.allowanceType = 'Recurring';
    usageRule.proratedOnOrder = true;
    usageRule.proratedOnCancel = false;
    usageRule.rolloverType = 'None';
    usageRule.ruleType = 'TAPERED';
    usageRule.usageRate = new GTVOrder.GTVUsageRate();
    usageRule.usageRate.rateType = 'flat';
    usageRule.usageRate.uom = 'MINUTE';
    usageRule.usageRate.rate = 10;
    usageRule.usageRate.usageChargeCategoryId = '3182';
    usageRule.spec = new GTVOrder.GTVUsageRuleSpecification();
    usageRule.spec.specificationType = 'match-all';
    orderItemPrice.usageRules.add(usageRule);
    firstOrderItem.orderItemPrices.add(orderItemPrice);
    GTVOrder.GTVPrice orderItemPrice2 = new GTVOrder.GTVPrice();
    orderItemPrice2.priceType = 'one-time';
    orderItemPrice2.id = '65256';
    orderItemPrice2.priceRanges = new List<GTVOrder.GTVPriceRange>();
    GTVOrder.GTVPriceRange priceRange3 = new GTVOrder.GTVPriceRange();
    priceRange3.price = 20;
    priceRange3.quantityBeginRange = 0;
    priceRange3.level = 1;
    priceRange3.currencyCode = 'USD';
    orderItemPrice2.priceRanges.add(priceRange3);
    orderItemPrice2.scheduledCharges = new List<GTVOrder.GTVPriceCharge>();
    GTVOrder.GTVPriceCharge priceCharge = new GTVOrder.GTVPriceCharge();
    priceCharge.description = 'Test Description';
    priceCharge.amount = 20;
    priceCharge.chargeDate = System.today() + 100;
    orderItemPrice2.scheduledCharges.add(priceCharge);
    firstOrderItem.orderItemPrices.add(orderItemPrice2);
    gtvOrder.orderItems.add(firstOrderItem);

    TRACT_Mappings__c maptract = new TRACT_Mappings__c();
    maptract.name = 'TRACT Account Mapping';
    maptract.TRACT_Account_Fields__c = '{ "AccountName":[ "Contact.Name", "Select from the Related List", "Name starts with test" ], "AccountNumber":[ "ParentId.AccountNumber", "Select from the Same Record", "" ], "BillingStreet":[ "BillingStreet", "Select from the Same Record", "" ], "BillingCity":[ "Contact.MailingCity", "Select from the Related List", "MailingCity equals test" ], "BillingCode":[ "Contact.MailingPostalCode", "Select from the Related List", "MailingPostalCode contains 1234" ], "BillingState":[ "BillingState", "Select from the Same Record", "" ], "BillingCountry":[ "Contact.MailingCountry", "Select from the Related List", "MailingCountry ends with test" ], "ShippingStreet":[ "ShippingStreet", "Select from the Same Record", "" ], "ShippingCity":[ "ShippingCity", "Select from the Same Record", "" ], "ShippingCode":[ "ShippingPostalCode", "Select from the Same Record", "" ], "ShippingState":[ "ShippingState", "Select from the Same Record", "" ], "ShippingCountry":[ "ShippingCountry", "Select from the Same Record", "" ], "Phone":[ "Phone", "Select from the Same Record", "" ], "GotransverseEmail":[ "TRACT3__Email__c", "Select from the Same Record", "" ] }';
    insert maptract;
    Test.startTest();
    GTVService service = new GTVService();
    service.createAccount(acc.id);
    service.createAccount(acc.Id, gtvAccountWrapper);
    service.getServiceResourceCategoryId('default');
    service.queryExisitngServiceResources('1234');
    service.queryServiceResources('1234');
    service.queryDiscountIdentifier('12345');
    service.getDiscountResourceId('0034');
    service.queryOrderCustomFields();
    service.queryUsageChargeCategory();
    service.queryRateTables();
    service.queryServiceCustomFields('12345');
    service.queryParentServices(account.id, '12345');
    service.createOrder(account.id, gtvOrder);
    Test.stopTest();
  }
  @isTest
  public static void gtvActionsTest3() {
    TRACT_Setup__c tractSetup = HelperClass.getAPI1TRACT();
    insert tractSetup;

    TRACTBillingAccountCategory__c tractBilling = HelperClass.getAccountCategory();
    insert tractBilling;

    TRACT_Bill_Cycle__c billcycle = HelperClass.getBillCycle();
    insert billcycle;

    Payment_Term__c paymentTerms = new Payment_Term__c(
      Name = 'Net 30',
      Eid__c = '1234'
    );
    insert paymentTerms;

    Account acc = HelperClass.getAccount();
    acc.Tract_Billing_Account__c = null;
    acc.GTV_Account_Category__c = 'testType';
    insert acc;

    GTVAccount gtvAccountWrapper = new GTVAccount();
    gtvAccountWrapper.accountName = 'Test Account';
    gtvAccountWrapper.currencyType = 'USD';
    gtvAccountWrapper.billingAccountCategoryName = '01/mkrych';
    gtvAccountWrapper.billCycleName = '02/mkrych';
    gtvAccountWrapper.paymentTermName = 'Immediate';
    gtvAccountWrapper.billingStreet = 'Test Street';
    gtvAccountWrapper.billingCity = 'Austin';
    gtvAccountWrapper.billingState = 'TX';
    gtvAccountWrapper.billingCountry = 'US';
    gtvAccountWrapper.billingPostalCode = '78701';
    gtvAccountWrapper.shippingStreet = 'Test Street';
    gtvAccountWrapper.shippingCity = 'Austin';
    gtvAccountWrapper.shippingState = 'TX';
    gtvAccountWrapper.shippingCountry = 'US';
    gtvAccountWrapper.shippingPostalCode = '78701';
    gtvAccountWrapper.email = 'testmail@gmail.com';
    gtvAccountWrapper.phone = '7894561237';
    gtvAccountWrapper.billType = 'EMAIL';
    gtvAccountWrapper.taxExempt = true;
    gtvAccountWrapper.createDate = system.today();

    Test.startTest();
    GTVService service = new GTVService();
    service.createAccount(acc.id);
    service.createAccount(acc.id, gtvAccountWrapper);
    service.queryParentServices(acc.id, '12345');
    service.createOrder(acc.id, new gtvOrder());
    Test.stopTest();
  }
  @isTest
  public static void gtvActionsTest4() {
    TRACT_Setup__c tractSetup = HelperClass.getAPI2TRACT();
    insert tractSetup;
    TRACTBillingAccountCategory__c tractBilling = HelperClass.getAccountCategory();
    insert tractBilling;
    TRACT_Bill_Cycle__c billcycle = HelperClass.getBillCycle();
    insert billcycle;
    Payment_Term__c paymentTerms = HelperClass.getPaymentTerms();
    insert paymentTerms;
    Account acc = HelperClass.getAccount();
    acc.Tract_Billing_Account__c = null;
    acc.GTV_Account_Category__c = 'testType';
    acc.GTV_Payment_Term__c = 'Net 30';
    acc.GTV_Bill_Cycle__c = 'testBill';
    insert acc;
    GTVAccount gtvAccountWrapper = new GTVAccount();
    gtvAccountWrapper.accountName = 'Test Account';
    gtvAccountWrapper.currencyType = 'USD';
    gtvAccountWrapper.billingAccountCategoryName = '01/mkrych';
    gtvAccountWrapper.billCycleName = '02/mkrych';
    gtvAccountWrapper.paymentTermName = 'Immediate';
    gtvAccountWrapper.billingStreet = 'Test Street';
    gtvAccountWrapper.billingCity = 'Austin';
    gtvAccountWrapper.billingState = 'TX';
    gtvAccountWrapper.billingCountry = 'US';
    gtvAccountWrapper.billingPostalCode = '78701';
    gtvAccountWrapper.shippingStreet = 'Test Street';
    gtvAccountWrapper.shippingCity = 'Austin';
    gtvAccountWrapper.shippingState = 'TX';
    gtvAccountWrapper.shippingCountry = 'US';
    gtvAccountWrapper.shippingPostalCode = '78701';
    gtvAccountWrapper.email = 'testmail@gmail.com';
    gtvAccountWrapper.phone = '7894561237';
    gtvAccountWrapper.billType = 'EMAIL';
    gtvAccountWrapper.taxExempt = true;
    gtvAccountWrapper.createDate = system.today();

    Test.startTest();
    GTVService ser = new GTVService();
    ser.createAccount(acc.id);
    ser.createAccount(acc.id, gtvAccountWrapper);
    Test.stopTest();
  }
  @isTest
  public static void gtvActionsTest5() {
    TRACT_Setup__c tract = HelperClass.getAPI1TRACT();
    insert tract;
    Account acc = HelperClass.getAccount();
    insert acc;
    Pricebook2 pb22 = HelperClass.getPriceBook2();
    insert pb22;
    Price_List__c priceList = HelperClass.getPricelist();
    insert priceList;
    list<Product2> proList = new List<Product2>();
    Product2 prod = HelperClass.getProduct2();
    prod.ProductCode = 'SUBSCRIPTION';
    prod.eid__c = '10';
    proList.add(prod);
    Product2 prod2 = HelperClass.getProduct2();
    prod2.ProductCode = 'Add-on';
    prod2.eid__c = '32934';
    proList.add(prod2);
    Product2 prod3 = HelperClass.getProduct2();
    prod3.ProductCode = 'One-Time';
    prod3.eid__c = '32933';
    proList.add(prod3);
    insert proList;
    Opportunity opp = HelperClass.getOpportunity();
    opp.Pricebook2Id = pb22.id;
    opp.AccountId = acc.id;
    opp.Tract_Sales_Order__c = null;
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
    list<PricebookEntry> priceBookEntryList = new List<PricebookEntry>();
    PricebookEntry pbe2 = HelperClass.getPricebookEntry();
    pbe2.Product2Id = prod.Id;
    pbe2.Pricebook2Id = pb22.id;
    priceBookEntryList.add(pbe2);
    PricebookEntry pbe4 = HelperClass.getPricebookEntry();
    pbe4.Product2Id = prod2.Id;
    pbe4.Pricebook2Id = pb22.id;
    priceBookEntryList.add(pbe4);
    PricebookEntry pbe3 = HelperClass.getPricebookEntry();
    pbe3.Product2Id = prod3.Id;
    pbe3.Pricebook2Id = pb22.id;
    priceBookEntryList.add(pbe3);
    insert priceBookEntryList;
    List<OpportunityLineItem> opportunityLineItemList = new List<OpportunityLineItem>();
    OpportunityLineItem oppLineItem = new OpportunityLineItem(
      Quantity = 25,
      firstname__c = 'user',
      lastname__c = 'new',
      username__c = 'user',
      Email__c = 'ravi.6380@yahoo.com',
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
    OpportunityLineItem oppLineItem1 = new OpportunityLineItem(
      Quantity = 25,
      firstname__c = 'user',
      lastname__c = 'new',
      username__c = 'user',
      Email__c = 'ravi.6380@yahoo.com',
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
    OpportunityLineItem oppLineItem2 = new OpportunityLineItem(
      Quantity = 25,
      firstname__c = 'user',
      lastname__c = 'new',
      username__c = 'user',
      Email__c = 'ravi.6380@yahoo.com',
      OpportunityId = opp.Id,
      UnitPrice = 1,
      PriceBookEntryId = pbe4.Id,
      eid__c = '32934',
      oneTimePrice__c = 15,
      recurringPrice__c = 20,
      description = 'Test'
    );
    opportunityLineItemList.add(oppLineItem);
    opportunityLineItemList.add(oppLineItem1);
    opportunityLineItemList.add(oppLineItem2);
    system.assert(opportunityLineItemList != null);
    insert opportunityLineItemList;
    Test.startTest();
    GTVService ser = new GTVService();
    ser.createOrder(opp.id);
    Test.stopTest();
  }
  @isTest
  public static void gtvActionsTest6() {
    TRACT_Setup__c tract = HelperClass.getAPI2TRACT();
    //tract.OrderStatus__c='FINAL';
    insert tract;
    Account acc = HelperClass.getAccount();
    insert acc;
    Pricebook2 pb22 = HelperClass.getPriceBook2();
    insert pb22;
    Price_List__c priceList = HelperClass.getPricelist();
    insert priceList;
    list<Product2> proList = new List<Product2>();
    Product2 prod = HelperClass.getProduct2();
    prod.ProductCode = 'TRACT_SUBSCRIPTION';
    prod.eid__c = '10';
    proList.add(prod);
    Product2 prod2 = HelperClass.getProduct2();
    prod2.ProductCode = 'Add-on';
    prod2.eid__c = '32934';
    proList.add(prod2);
    Product2 prod3 = HelperClass.getProduct2();
    prod3.ProductCode = 'One-Time';
    prod3.eid__c = '32933';
    proList.add(prod3);
    insert proList;
    Opportunity opp = HelperClass.getOpportunity();
    opp.Pricebook2Id = pb22.id;
    opp.AccountId = acc.id;
    opp.Tract_Sales_Order__c = null;
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
    list<PricebookEntry> priceBookEntryList = new List<PricebookEntry>();
    PricebookEntry pbe2 = HelperClass.getPricebookEntry();
    pbe2.Product2Id = prod.Id;
    pbe2.Pricebook2Id = pb22.id;
    priceBookEntryList.add(pbe2);
    PricebookEntry pbe4 = HelperClass.getPricebookEntry();
    pbe4.Product2Id = prod2.Id;
    pbe4.Pricebook2Id = pb22.id;
    priceBookEntryList.add(pbe4);
    PricebookEntry pbe3 = HelperClass.getPricebookEntry();
    pbe3.Product2Id = prod3.Id;
    pbe3.Pricebook2Id = pb22.id;
    priceBookEntryList.add(pbe3);
    insert priceBookEntryList;
    List<OpportunityLineItem> opportunityLineItemList = new List<OpportunityLineItem>();
    OpportunityLineItem oppLineItem = new OpportunityLineItem(
      Quantity = 25,
      firstname__c = 'user',
      lastname__c = 'new',
      username__c = 'user',
      Email__c = 'ravi.6380@yahoo.com',
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
    OpportunityLineItem oppLineItem1 = new OpportunityLineItem(
      Quantity = 25,
      firstname__c = 'user',
      lastname__c = 'new',
      username__c = 'user',
      Email__c = 'ravi.6380@yahoo.com',
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
    OpportunityLineItem oppLineItem2 = new OpportunityLineItem(
      Quantity = 25,
      firstname__c = 'user',
      lastname__c = 'new',
      username__c = 'user',
      Email__c = 'ravi.6380@yahoo.com',
      OpportunityId = opp.Id,
      UnitPrice = 1,
      PriceBookEntryId = pbe4.Id,
      eid__c = '32934',
      oneTimePrice__c = 15,
      recurringPrice__c = 20,
      description = 'Test'
    );
    opportunityLineItemList.add(oppLineItem);
    opportunityLineItemList.add(oppLineItem1);
    opportunityLineItemList.add(oppLineItem2);
    system.assert(opportunityLineItemList != null);
    insert opportunityLineItemList;
    Test.startTest();
    GTVService ser = new GTVService();
    ser.createOrder(opp.id);

    Test.stopTest();
  }
  @isTest
  public static void gtvActionsTest7() {
    TRACT_Setup__c tractSetup = HelperClass.getAPI2TRACT();
    insert tractSetup;

    TRACTBillingAccountCategory__c tractBilling = HelperClass.getAccountCategory();
    insert tractBilling;

    TRACT_Bill_Cycle__c billcycle = HelperClass.getBillCycle();
    insert billcycle;

    Payment_Term__c paymentTerms = HelperClass.getPaymentTerms();
    insert paymentTerms;

    Account acc = HelperClass.getAccount();
    acc.Tract_Billing_Account__c = null;
    acc.GTV_Account_Category__c = 'testType';
    acc.GTV_Payment_Term__c = 'Net 30';
    acc.GTV_Bill_Cycle__c = 'testBill';
    insert acc;
    Contact con = new Contact();
    con.FirstName = 'test';
    con.lastName = 'testCon';
    con.MailingCity = 'test';
    con.MailingCountry = 'USA test';
    con.MailingPostalCode = '123456';
    con.AccountId = acc.id;
    insert con;
    TRACT_Mappings__c maptract = new TRACT_Mappings__c();
    maptract.name = 'TRACT Account Mapping';
    maptract.TRACT_Account_Fields__c = '{ "AccountName":[ "Contact.Name", "Select from the Related List", "Name starts with test" ], "AccountNumber":[ "ParentId.AccountNumber", "Select from the Same Record", "" ], "BillingStreet":[ "BillingStreet", "Select from the Same Record", "" ], "BillingCity":[ "Contact.MailingCity", "Select from the Related List", "MailingCity equals test" ], "BillingCode":[ "Contact.MailingPostalCode", "Select from the Related List", "MailingPostalCode contains 1234" ], "BillingState":[ "BillingState", "Select from the Same Record", "" ], "BillingCountry":[ "Contact.MailingCountry", "Select from the Related List", "MailingCountry ends with test" ], "ShippingStreet":[ "ShippingStreet", "Select from the Same Record", "" ], "ShippingCity":[ "ShippingCity", "Select from the Same Record", "" ], "ShippingCode":[ "ShippingPostalCode", "Select from the Same Record", "" ], "ShippingState":[ "ShippingState", "Select from the Same Record", "" ], "ShippingCountry":[ "ShippingCountry", "Select from the Same Record", "" ], "Phone":[ "Phone", "Select from the Same Record", "" ], "GotransverseEmail":[ "TRACT3__Email__c", "Select from the Same Record", "" ] }';
    insert maptract;
    Test.startTest();
    GTVService ser = new GTVService();
    ser.createAccount(acc.id);
    Test.stopTest();
  }
  @isTest
  public static void globalServiceTest() {
    Test.startTest();
    GTVService service = new GTVService();
    service.getServiceResourceCategoryId('default');
    service.queryExisitngServiceResources('1234');
    service.queryServiceResources('1234');
    service.queryDiscountIdentifier('12345');
    service.getDiscountResourceId('0034');
    service.queryOrderCustomFields();
    service.queryUsageChargeCategory();
    service.queryRateTables();
    service.queryServiceCustomFields('12345');
    Test.stopTest();
  }
}