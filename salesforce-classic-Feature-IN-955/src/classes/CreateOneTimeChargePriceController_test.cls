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
 * This class is a test class of CreateOneTimeChargePriceController class.
 * @author Aman Jain
 */

@isTest
public with sharing class CreateOneTimeChargePriceController_test {
  static testMethod void createOneTimeChargePricetest2() {
    TRACT_Setup__c tractSetup = HelperClass.getAPI2TRACT();
    insert tractSetup;
    Price_List__c price = HelperClass.getPricelist();
    insert price;

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
    CreateOneTimeChargePriceWrapper oneTimeWrap = new CreateOneTimeChargePriceWrapper();
    oneTimeWrap.priceCategory = '12345';
    oneTimeWrap.selectedcurrency = 'USD';
    oneTimeWrap.fromDate = system.today();
    oneTimeWrap.taperedPricing = true;
    oneTimeWrap.sfdcProductId = product.id;
    String jString = JSON.serialize(oneTimeWrap);
    Test.startTest();
    CreateOneTimeChargePriceController.getCreateOneTimeChargePriceWrapper(
      product.id
    );
    CreateOneTimeChargePriceController.getCreatePriceRangeWrapper();
    CreateOneTimeChargePriceController.createOneTimeProductPrice(
      jString,
      '12345'
    );
    Test.stopTest();
  }
  static testMethod void createOneTimeChargePricetest3() {
    TRACT_Setup__c tractSetup = HelperClass.getAPI1TRACT();
    insert tractSetup;
    Price_List__c price = HelperClass.getPricelist();
    insert price;

    Product2 product = HelperClass.getProduct2();
    product.eid__c = '12345';
    product.ProductCode = 'TRACT_SUBSCRIPTION';
    product.minServiceResources__c = 10;
    product.IsActive = false;
    product.Price_Information__c = '[{"thruDate":null,"scheduledCharges":false,"recurringPaymentRequired":false,"recurrencePeriod":"MONTH","priceType":"Recurring","priceRangesList":[{"quantityEndRange":null,"quantityBeginRange":0.00,"price":100.00,"level":1,"eid":"14702","currencyType":"USD"}],"priceOverride":true,"priceListEid":"228","paymentOnPurchaseRequired":false,"fromDate":"2014-11-07T06:00:00.000Z","eid":"13700","currencyType":"USD"},{"thruDate":null,"scheduledCharges":false,"recurringPaymentRequired":false,"recurrencePeriod":"BILLCYCLE","priceType":"Recurring","priceRangesList":[{"quantityEndRange":1.00,"quantityBeginRange":0.00,"price":5.00,"level":1,"eid":"47138","currencyType":"USD"},{"quantityEndRange":null,"quantityBeginRange":1.00,"price":0.00,"level":2,"eid":"47140","currencyType":"USD"}],"priceOverride":true,"priceListEid":"228","paymentOnPurchaseRequired":false,"fromDate":"2018-08-30T05:00:00.000Z","eid":"43272","currencyType":"USD"}]';
    product.maxServiceResources__c = 10;
    system.assert(product != null);
    insert product;
    CreateOneTimeChargePriceWrapper oneTimeWrap = new CreateOneTimeChargePriceWrapper();
    oneTimeWrap.priceCategory = '12345';
    oneTimeWrap.selectedcurrency = 'USD';
    oneTimeWrap.fromDate = system.today();
    oneTimeWrap.taperedPricing = true;
    oneTimeWrap.sfdcProductId = product.id;
    String jString = JSON.serialize(oneTimeWrap);
    Test.startTest();
    CreateOneTimeChargePriceController.getCreateOneTimeChargePriceWrapper(
      product.id
    );
    CreateOneTimeChargePriceController.getCreatePriceRangeWrapper();
    CreateOneTimeChargePriceController.createOneTimeProductPrice(
      jString,
      '12345'
    );
    Test.stopTest();
  }
}