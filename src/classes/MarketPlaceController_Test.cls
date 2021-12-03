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
 * This class is a test class of MarketPlaceController class.
 * @author Aman Jain
 */

@isTest
public with sharing class MarketPlaceController_Test {
  @isTest
  public static void marketPlaceControllerTest1() {
    TRACT_Setup__c tractSetup = HelperClass.getAPI1TRACT();
    insert tractSetup;
    MarketPlaceWrapper wrap = new MarketPlaceWrapper();
    wrap.mplaceId = '12345';
    Price_List__c price = HelperClass.getPricelist();
    insert price;

    String wrapString = JSON.serialize(wrap);
    list<String> listOfSProduct = new List<String>();
    listOfSProduct.add('12345');
    listOfSProduct.add('67891');
    AvailableAndSelectedProductsWrapper aspw = new AvailableAndSelectedProductsWrapper();
    aspw.listOfSelectedProducts = listOfSProduct;

    ProductCategoryWrapper catWrap = new ProductCategoryWrapper();
    catWrap.categoryId = '12345';
    catWrap.Name = 'test category';
    Product2 pro = new Product2();
    pro.Name = 'Test Product';
    pro.isActive = true;
    pro.eid__c = '12345';
    pro.PriceLists__c = 'test:12345';
    pro.Gotransverse_Product_Category__c = JSON.serialize(catWrap);
    pro.Price_Information__c = '[{"thruDate":null,"scheduledCharges":false,"recurringPaymentRequired":false,"recurrencePeriod":"BILLCYCLE","priceType":"Recurring","priceRangesList":[{"quantityEndRange":null,"quantityBeginRange":0.00,"price":66,"level":1,"eid":"49798","currencyType":"USD"}],"priceOverride":true,"priceListEid":"780","paymentOnPurchaseRequired":false,"hasProductEid":null,"fromDate":"2019-01-30T06:00:00.000Z","eid":"45800","currencyType":"USD"},{"thruDate":null,"scheduledCharges":false,"recurringPaymentRequired":false,"recurrencePeriod":"FIVEYEARS","priceType":"Recurring","priceRangesList":[{"quantityEndRange":null,"quantityBeginRange":0.00,"price":6,"level":1,"eid":"55298","currencyType":"USD"}],"priceOverride":true,"priceListEid":"696","paymentOnPurchaseRequired":false,"hasProductEid":null,"fromDate":"2019-11-26T11:26:01.000Z","eid":"51018","currencyType":"USD"}]';
    insert pro;
    Test.startTest();
    MarketPlaceController.getAvailableMarketPlaces();
    MarketPlaceController.getMarketPlacePriceLists(wrapString);
    MarketPlaceController.getProductByPriceListEid('12345');
    MarketPlaceController.getProductsList('12345');
    MarketPlaceController.getProductsListToRemove('12345');
    MarketPlaceController.addProductToPriceList('2732', JSON.serialize(aspw));
    MarketPlaceController.RemoveProductFromPriceList(
      '2732',
      JSON.serialize(aspw)
    );
    MarketPlaceController.deleteThisMarketPlace('12345');
    MarketPlaceController.getApiVersion();
    MarketPlaceController.getOneTimeProductPrice(pro.eid__c, '12345');
    MarketPlaceController.getRecurringProductPrice(pro.eid__c, '12345');
    Test.stopTest();
  }
  static testMethod void marketPlaceControllerTest2() {
    TRACT_Setup__c tractSetup = HelperClass.getAPI2TRACT();
    insert tractSetup;
    MarketPlaceWrapper wrap = new MarketPlaceWrapper();
    wrap.mplaceId = '12345';
    String wrapString = JSON.serialize(wrap);
    list<String> listOfSProduct = new List<String>();
    listOfSProduct.add('12345');
    listOfSProduct.add('67891');
    AvailableAndSelectedProductsWrapper aspw = new AvailableAndSelectedProductsWrapper();
    aspw.listOfSelectedProducts = listOfSProduct;

    ProductCategoryWrapper catWrap = new ProductCategoryWrapper();
    catWrap.categoryId = '12345';
    catWrap.Name = 'test category';
    Product2 pro = new Product2();
    pro.Name = 'Test Product';
    pro.isActive = true;
    pro.eid__c = '12345';
    pro.PriceLists__c = 'test:12345';
    pro.Price_Information__c = '[{"thruDate":null,"scheduledCharges":false,"recurringPaymentRequired":false,"recurrencePeriod":"BILLCYCLE","priceType":"Recurring","priceRangesList":[{"quantityEndRange":null,"quantityBeginRange":0.00,"price":66,"level":1,"eid":"49798","currencyType":"USD"}],"priceOverride":true,"priceListEid":"780","paymentOnPurchaseRequired":false,"hasProductEid":null,"fromDate":"2019-01-30T06:00:00.000Z","eid":"45800","currencyType":"USD"},{"thruDate":null,"scheduledCharges":false,"recurringPaymentRequired":false,"recurrencePeriod":"FIVEYEARS","priceType":"Recurring","priceRangesList":[{"quantityEndRange":null,"quantityBeginRange":0.00,"price":6,"level":1,"eid":"55298","currencyType":"USD"}],"priceOverride":true,"priceListEid":"696","paymentOnPurchaseRequired":false,"hasProductEid":null,"fromDate":"2019-11-26T11:26:01.000Z","eid":"51018","currencyType":"USD"}]';
    pro.Gotransverse_Product_Category__c = JSON.serialize(catWrap);
    insert pro;
    Test.startTest();
    MarketPlaceController.getAvailableMarketPlaces();
    MarketPlaceController.getMarketPlacePriceLists(wrapString);
    MarketPlaceController.getProductByPriceListEid('12345');
    MarketPlaceController.getProductsList('12345');
    MarketPlaceController.getProductsListToRemove('12345');
    MarketPlaceController.addProductToPriceList('12345', JSON.serialize(aspw));
    MarketPlaceController.RemoveProductFromPriceList(
      '12345',
      JSON.serialize(aspw)
    );
    MarketPlaceController.deleteThisMarketPlace('12345');
    MarketPlaceController.getApiVersion();
    MarketPlaceController.getOneTimeProductPrice(pro.eid__c, '12345');
    MarketPlaceController.getRecurringProductPrice(pro.eid__c, '12345');
    Test.stopTest();
  }
}