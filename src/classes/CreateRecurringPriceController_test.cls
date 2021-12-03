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
 * This class is a test class of CreateRecurringPriceController class.
 * @author Aman Jain
 */

@isTest
public with sharing class CreateRecurringPriceController_test {
  static testMethod void createRecurringChargePricetest2() {
    TRACT_Setup__c tractSetup = HelperClass.getAPI1TRACT();
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

    ProductPriceWrapper productPriceWapp = new ProductPriceWrapper();
    productPriceWapp.eid = '1234';
    productPriceWapp.fromDate = System.today();
    productPriceWapp.priceCategory = '1234';
    productPriceWapp.priceType = 'USD';
    productPriceWapp.recurringPaymentRequired = true;
    productPriceWapp.currencyType = 'USD';
    productPriceWapp.billInAdvance = true;
    productPriceWapp.hasProductEid = true;
    productPriceWapp.paymentOnPurchaseRequired = true;
    productPriceWapp.priceOverride = true;
    productPriceWapp.proratedOnOrder = true;
    productPriceWapp.proratedOnOrderNoCharge = true;
    productPriceWapp.proratedOnCancel = true;
    productPriceWapp.priceCategoryId = '1234';
    productPriceWapp.recurrencePeriod = 'DAY';
    productPriceWapp.priceGroupId = '1234';

    ProductPriceRangeWrapper priceRange = new ProductPriceRangeWrapper();
    priceRange.price = 20;
    priceRange.quantityBeginRange = 20;
    priceRange.quantityEndRange = 20;
    priceRange.level = 20;
    priceRange.currencyType = 'USD';
    priceRange.eid = '20';
    List<ProductPriceRangeWrapper> priceRangeList = new List<ProductPriceRangeWrapper>();
    priceRangeList.add(priceRange);
    productPriceWapp.priceRangesList = priceRangeList;
    CreateRecurringChargePriceWrapper recurringWrap = new CreateRecurringChargePriceWrapper();
    recurringWrap.priceCategory = '12345';
    recurringWrap.selectedcurrency = 'USD';
    recurringWrap.fromDate = System.today();
    recurringWrap.taperedPricing = true;
    recurringWrap.sfdcProductId = product.id;
    String jsonString = JSON.serialize(productPriceWapp);
    String jString = JSON.serialize(recurringWrap);

    Price_List__c priceList = HelperClass.getPricelist();
    insert priceList;

    Test.startTest();
    CreateRecurringChargePriceController.getCreateRecurringChargePriceWrapper(
      product.Id,
      jsonString
    );
    CreateRecurringChargePriceController.getCreatePriceRangeWrapper();
    CreateRecurringChargePriceController.createProductPrice(jString, '12345');
    Test.stopTest();
  }
  static testMethod void createRecurringChargePricetest3() {
    TRACT_Setup__c tractSetup = HelperClass.getAPI2TRACT();
    insert tractSetup;

    GTV_Currencies__c getCurrency = new GTV_Currencies__c();
    getCurrency.name = 'Currency';
    getCurrency.TRACT3__GTV_Currency_List__c = 'USD,AUD';
    insert getCurrency;
    Product2 product = HelperClass.getProduct2();
    product.eid__c = '12345';
    product.ProductCode = 'TRACT_SUBSCRIPTION';
    product.minServiceResources__c = 10;
    product.IsActive = false;
    product.Price_Information__c = '[{"thruDate":null,"scheduledCharges":false,"recurringPaymentRequired":false,"recurrencePeriod":"MONTH","priceType":"Recurring","priceRangesList":[{"quantityEndRange":null,"quantityBeginRange":0.00,"price":100.00,"level":1,"eid":"14702","currencyType":"USD"}],"priceOverride":true,"priceListEid":"228","paymentOnPurchaseRequired":false,"fromDate":"2014-11-07T06:00:00.000Z","eid":"13700","currencyType":"USD"},{"thruDate":null,"scheduledCharges":false,"recurringPaymentRequired":false,"recurrencePeriod":"BILLCYCLE","priceType":"Recurring","priceRangesList":[{"quantityEndRange":1.00,"quantityBeginRange":0.00,"price":5.00,"level":1,"eid":"47138","currencyType":"USD"},{"quantityEndRange":null,"quantityBeginRange":1.00,"price":0.00,"level":2,"eid":"47140","currencyType":"USD"}],"priceOverride":true,"priceListEid":"228","paymentOnPurchaseRequired":false,"fromDate":"2018-08-30T05:00:00.000Z","eid":"43272","currencyType":"USD"}]';
    product.maxServiceResources__c = 10;
    system.assert(product != null);
    insert product;

    ProductPriceWrapper productPriceWapp = new ProductPriceWrapper();
    productPriceWapp.eid = '1234';
    productPriceWapp.fromDate = System.today();
    productPriceWapp.hasProductEid = true;
    productPriceWapp.priceCategory = '1234';
    productPriceWapp.priceType = 'USD';
    productPriceWapp.recurringPaymentRequired = true;
    productPriceWapp.currencyType = 'USD';
    productPriceWapp.billInAdvance = true;
    String jsonString = JSON.serialize(productPriceWapp);

    CreateRecurringChargePriceWrapper recurringWrap = new CreateRecurringChargePriceWrapper();
    recurringWrap.priceCategory = '12345';
    recurringWrap.selectedcurrency = 'USD';
    recurringWrap.fromDate = system.today();
    recurringWrap.taperedPricing = true;
    recurringWrap.sfdcProductId = product.id;
    String jString = JSON.serialize(recurringWrap);

    Price_List__c priceList = HelperClass.getPricelist();
    insert priceList;

    Test.startTest();
    CreateRecurringChargePriceController.getCreateRecurringChargePriceWrapper(
      product.Id,
      jsonString
    );
    CreateRecurringChargePriceController.getCreatePriceRangeWrapper();
    CreateRecurringChargePriceController.createProductPrice(jString, '12345');
    Test.stopTest();
  }

  static testMethod void createRecurringChargePricetest4() {
    TRACT_Setup__c tractSetup = HelperClass.getAPI2TRACT();
    insert tractSetup;

    GTV_Currencies__c getCurrency = new GTV_Currencies__c();
    getCurrency.name = 'Currency';
    getCurrency.TRACT3__GTV_Currency_List__c = 'USD,AUD';
    insert getCurrency;
    Product2 product = HelperClass.getProduct2();
    product.eid__c = '12345';
    product.ProductCode = 'TRACT_SUBSCRIPTION';
    product.minServiceResources__c = 10;
    product.IsActive = false;
    product.Price_Information__c = '[{"thruDate":null,"scheduledCharges":false,"recurringPaymentRequired":false,"recurrencePeriod":"MONTH","priceType":"Recurring","priceRangesList":[{"quantityEndRange":null,"quantityBeginRange":0.00,"price":100.00,"level":1,"eid":"14702","currencyType":"USD"}],"priceOverride":true,"priceListEid":"228","paymentOnPurchaseRequired":false,"fromDate":"2014-11-07T06:00:00.000Z","eid":"13700","currencyType":"USD"},{"thruDate":null,"scheduledCharges":false,"recurringPaymentRequired":false,"recurrencePeriod":"BILLCYCLE","priceType":"Recurring","priceRangesList":[{"quantityEndRange":1.00,"quantityBeginRange":0.00,"price":5.00,"level":1,"eid":"47138","currencyType":"USD"},{"quantityEndRange":null,"quantityBeginRange":1.00,"price":0.00,"level":2,"eid":"47140","currencyType":"USD"}],"priceOverride":true,"priceListEid":"228","paymentOnPurchaseRequired":false,"fromDate":"2018-08-30T05:00:00.000Z","eid":"43272","currencyType":"USD"}]';
    product.maxServiceResources__c = 10;
    system.assert(product != null);
    insert product;

    ProductPriceWrapper productPriceWapp = new ProductPriceWrapper();
    productPriceWapp.eid = '1234';
    productPriceWapp.fromDate = System.today();
    productPriceWapp.hasProductEid = true;
    productPriceWapp.priceCategory = '1234';
    productPriceWapp.priceType = 'USD';
    productPriceWapp.recurringPaymentRequired = true;
    productPriceWapp.currencyType = 'USD';
    productPriceWapp.billInAdvance = true;
    String jsonString = JSON.serialize(productPriceWapp);

    CreateRecurringChargePriceWrapper recurringWrap = new CreateRecurringChargePriceWrapper();
    recurringWrap.priceCategory = '12345';
    recurringWrap.selectedcurrency = 'USD';
    recurringWrap.fromDate = system.today();
    recurringWrap.taperedPricing = true;
    recurringWrap.eid = '12456';
    String jString = JSON.serialize(recurringWrap);

    Price_List__c priceList = HelperClass.getPricelist();
    insert priceList;

    Test.startTest();
    CreateRecurringChargePriceController.getCreateRecurringChargePriceWrapper(
      product.Id,
      jsonString
    );
    CreateRecurringChargePriceController.getCreatePriceRangeWrapper();
    CreateRecurringChargePriceController.createProductPrice(jString, '12345');
    Test.stopTest();
  }
}