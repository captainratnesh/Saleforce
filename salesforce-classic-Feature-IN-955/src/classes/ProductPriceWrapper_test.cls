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
 * This class is a test class of ProductPriceWrapper class.
 * @author Aman Jain
 */

@isTest
public class ProductPriceWrapper_test {
  @isTest
  public static void unitTest() {
    ProductPriceWrapper proPrice = new ProductPriceWrapper();
    proPrice.fromDate = system.today();
    proPrice.thruDate = system.today();
    proPrice.priceOverride = true;
    proPrice.priceType = 'dol';
    proPrice.paymentOnPurchaseRequired = false;
    proPrice.recurringPaymentRequired = false;
    proPrice.recurrencePeriod = '6months';
    proPrice.currencyType = 'USD';
    proPrice.scheduledCharges = false;
    proPrice.eid = '10';
    proPrice.priceListEid = '15';
    list<ProductPriceRangeWrapper> priceRangesList = new List<ProductPriceRangeWrapper>();
    ProductPriceRangeWrapper proPriceRange = new ProductPriceRangeWrapper();
    proPriceRange.quantityBeginRange = 2;
    proPriceRange.quantityEndRange = 5;
    proPriceRange.price = 1000;
    proPriceRange.level = 10;
    proPriceRange.currencyType = 'USD';
    proPriceRange.eid = '10';
    priceRangesList.add(proPriceRange);
    ProductPriceWrapper prodPrice1 = new ProductPriceWrapper();
    System.assertNotEquals(proPrice, null);
  }
}