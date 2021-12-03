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
 * This class is a test class of BatchToSyncProductsFromTract class.
 * @author Aman Jain
 */

@isTest
private class BatchToSyncProductsFromTract_Test {
  static testMethod void myUnitTest2() {
    // retrieve tract to pass to batch class
    Price_List__c priceList = HelperClass.getPricelist();
    insert priceList;

    TRACT_Setup__c tract = HelperClass.getAPI1TRACT();
    insert tract;

    BatchToSyncProductsFromTract batch = new BatchToSyncProductsFromTract();
    Test.startTest();
    Database.executeBatch(batch);
    Test.stopTest();
  }

  static testMethod void myUnitTest3() {
    // retrieve tract to pass to batch class
    Price_List__c priceList = HelperClass.getPricelist();
    insert priceList;

    TRACT_Setup__c tract = HelperClass.getAPI2TRACT();
    insert tract;

    BatchToSyncProductsFromTract batch = new BatchToSyncProductsFromTract();
    Test.startTest();
    Database.executeBatch(batch);
    Test.stopTest();
  }
}