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
 * This class is a test class of ProductPriceRangeWrapper class.
 * @author Aman Jain
 */

@isTest
public with sharing class ProductPriceRangeWrapper_test {
  @isTest
  public static void unitTest() {
    ProductPriceRangeWrapper proPriceRange = new ProductPriceRangeWrapper();
    proPriceRange.quantityBeginRange = 2;
    proPriceRange.quantityEndRange = 5;
    proPriceRange.price = 1000;
    proPriceRange.level = 10;
    proPriceRange.currencyType = 'USD';
    proPriceRange.eid = '10';
    ProductPriceRangeWrapper prodPriceRange1 = new ProductPriceRangeWrapper();
    System.assertNotEquals(proPriceRange, null);
  }
}