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
 * This class is a test class of Product2AddWrapper class.
 * @author Aman Jain
 */

@isTest
public with sharing class Product2AddWrapper_Test {
  @isTest
  public static void unitTest() {
    Product2AddWrapper prodWrop = new Product2AddWrapper();
    prodWrop.prod = new Product2();
    prodWrop.oppId = '';
    prodWrop.scheduleChargeEnable = true;
    prodWrop.disableRecurring = true;
    prodWrop.oneTimeChargeEnable = true;
    prodWrop.disableonetime = true;
    prodWrop.recurringprice = 0.0;
    prodWrop.oneTimePrice = 0.0;
    prodWrop.quantity = 0;
    prodWrop.idAndPriceValueMap = new Map<String, decimal>();
    prodWrop.idAndEidMapOneTime = new Map<String, String>();
    prodWrop.idAndEidMap = new Map<String, String>();
    prodWrop.productPriceList = new List<SelectOption>();
    prodWrop.priceListValue = '';
    prodWrop.priceListValue1 = '';
    prodWrop.recurrenceoptList = new List<SelectOption>();
    prodWrop.recurrencPer = '';
    prodWrop.recurrencPerValue = '';
    prodWrop.discountName = '';
    prodWrop.discountEid = '';
    prodWrop.newServiceResource = '';
    prodWrop.serviceResourceName = '';
    prodWrop.serviceResourceEid = '';
    prodWrop.errorMessage = '';
    prodWrop.oliId = '';
    prodWrop.pricebookNames = new List<String>();
    prodWrop.oLineItem = new opportunityLineItem();
    prodWrop.agreementId = '';
    prodWrop.service = '';
    prodWrop.parentServiceEId = '';
    prodWrop.agreementPeriod = 0.0;
    prodWrop.childProducts = new List<Product2AddWrapper>();
    Product2AddWrapper prodWrop1 = new Product2AddWrapper();
    System.assertNotEquals(prodWrop, null);
  }
}