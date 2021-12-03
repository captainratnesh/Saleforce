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
 * This class is a test class of CreateProductController class.
 * @author Aman Jain
 */

@isTest
public with sharing class CreateProductController_test {
  static testMethod void createProductControllertest2() {
    TRACT_Setup__c tractSetup = new TRACT_Setup__c();
    tractSetup.name = 'tract';
    tractSetup.TPassword__c = 'tpass';
    tractSetup.Tract_User_Name__c = ' username ';
    tractSetup.TRACT_URL__c = 'https://tract-qa2.gotransverse.com/t/s/billing/1.28?wsdl';
    tractSetup.Active__c = true;
    tractSetup.Description__c = 'description';
    tractSetup.OrderStatus__c = 'DRAFT';
    // tractSetup.Api_Version__c = '30';
    tractSetup.Active__c = true;
    tractSetup.Api_Version__c = 'API Version 2.0';
    system.assert(tractSetup != null);
    insert tractSetup;

    Product2 product = HelperClass.getProduct2();
    product.eid__c = '12345';
    product.ProductCode = 'TRACT_SUBSCRIPTION';
    product.minServiceResources__c = 10;
    product.IsActive = false;
    product.Price_Information__c = '[{"thruDate":null,"scheduledCharges":false,"recurringPaymentRequired":false,"recurrencePeriod":"MONTH","priceType":"Recurring","priceRangesList":[{"quantityEndRange":null,"quantityBeginRange":0.00,"price":100.00,"level":1,"eid":"14702","currencyType":"USD"}],"priceOverride":true,"priceListEid":"228","paymentOnPurchaseRequired":false,"fromDate":"2014-11-07T06:00:00.000Z","eid":"13700","currencyType":"USD"},{"thruDate":null,"scheduledCharges":false,"recurringPaymentRequired":false,"recurrencePeriod":"BILLCYCLE","priceType":"Recurring","priceRangesList":[{"quantityEndRange":1.00,"quantityBeginRange":0.00,"price":5.00,"level":1,"eid":"47138","currencyType":"USD"},{"quantityEndRange":null,"quantityBeginRange":1.00,"price":0.00,"level":2,"eid":"47140","currencyType":"USD"}],"priceOverride":true,"priceListEid":"228","paymentOnPurchaseRequired":false,"fromDate":"2018-08-30T05:00:00.000Z","eid":"43272","currencyType":"USD"}]';
    product.maxServiceResources__c = 10;
    system.assert(product != null);
    insert product;
    CreateProductWrapper prodWrap = new CreateProductWrapper();
    prodWrap.productName = 'test';
    prodWrap.sku = 'test';
    prodWrap.externalName = 'test';
    prodWrap.internalName = 'test';
    prodWrap.description = 'test';
    prodWrap.shortDescription = 'test';
    prodWrap.unique = true;
    prodWrap.taxable = true;
    String jString = JSON.serialize(prodWrap);
    Test.startTest();
    CreateProductController.getCreateProductWrapper(product.id);
    CreateProductController.createProduct(jString);
    Test.stopTest();
  }
  static testMethod void createProductControllertest3() {
    TRACT_Setup__c tractSetup = new TRACT_Setup__c();
    tractSetup.name = 'tract';
    tractSetup.TPassword__c = 'tpass';
    tractSetup.Tract_User_Name__c = ' username ';
    tractSetup.TRACT_URL__c = 'https://tract-qa2.gotransverse.com/t/s/billing/1.28?wsdl';
    tractSetup.Active__c = true;
    tractSetup.Description__c = 'description';
    tractSetup.OrderStatus__c = 'DRAFT';
    // tractSetup.Api_Version__c = '30';
    tractSetup.Active__c = true;
    tractSetup.Api_Version__c = 'API Version 1.0';
    system.assert(tractSetup != null);
    insert tractSetup;

    Product2 product = HelperClass.getProduct2();
    product.eid__c = '12345';
    product.ProductCode = 'TRACT_SUBSCRIPTION';
    product.minServiceResources__c = 10;
    product.IsActive = false;
    product.Price_Information__c = '[{"thruDate":null,"scheduledCharges":false,"recurringPaymentRequired":false,"recurrencePeriod":"MONTH","priceType":"Recurring","priceRangesList":[{"quantityEndRange":null,"quantityBeginRange":0.00,"price":100.00,"level":1,"eid":"14702","currencyType":"USD"}],"priceOverride":true,"priceListEid":"228","paymentOnPurchaseRequired":false,"fromDate":"2014-11-07T06:00:00.000Z","eid":"13700","currencyType":"USD"},{"thruDate":null,"scheduledCharges":false,"recurringPaymentRequired":false,"recurrencePeriod":"BILLCYCLE","priceType":"Recurring","priceRangesList":[{"quantityEndRange":1.00,"quantityBeginRange":0.00,"price":5.00,"level":1,"eid":"47138","currencyType":"USD"},{"quantityEndRange":null,"quantityBeginRange":1.00,"price":0.00,"level":2,"eid":"47140","currencyType":"USD"}],"priceOverride":true,"priceListEid":"228","paymentOnPurchaseRequired":false,"fromDate":"2018-08-30T05:00:00.000Z","eid":"43272","currencyType":"USD"}]';
    product.maxServiceResources__c = 10;
    system.assert(product != null);
    insert product;
    CreateProductWrapper prodWrap = new CreateProductWrapper();
    prodWrap.productName = 'test';
    prodWrap.sku = 'test';
    prodWrap.externalName = 'test';
    prodWrap.internalName = 'test';
    prodWrap.description = 'test';
    prodWrap.shortDescription = 'test';
    prodWrap.unique = true;
    prodWrap.taxable = true;
    String jString = JSON.serialize(prodWrap);
    Test.startTest();
    CreateProductController.getCreateProductWrapper(product.id);
    CreateProductController.createProduct(jString);
    Test.stopTest();
  }
}