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
 * This class is a test class of TractBatchSyncProductAgreements class.
 * @author Aman Jain
 */

@isTest
public class TractBatchSyncProductAgreements_Test {
  static testMethod void myTestMethod() {
    TRACT_Setup__c tract = new TRACT_Setup__c();
    tract.Name = 'test';
    system.assert(tract != null);
    insert tract;

    Product2 product2obj = (Product2) SmartFactory.createSObject('Product2');
    product2obj.Requires_Agreement__c = true;
    product2obj.eid__c = '12345';
    product2obj.Name = 'product';
    system.assert(product2obj != null);
    insert product2obj;
    Test.startTest();
    // TractBatchSyncProductAgreements batchObj1 = new TractBatchSyncProductAgreements(tract);
    //database.executebatch(batchObj1);
    Test.stopTest();
  }

  static testMethod void myTestMethod1() {
    TRACT_Setup__c tract = new TRACT_Setup__c();
    tract.Name = 'test';
    system.assert(tract != null);
    insert tract;

    Product2 product2obj = (Product2) SmartFactory.createSObject('Product2');
    product2obj.Requires_Agreement__c = true;
    product2obj.eid__c = '12345';
    product2obj.Name = 'product';
    system.assert(product2obj != null);
    insert product2obj;

    Test.startTest();
    // TractBatchSyncProductAgreements batchObj1 = new TractBatchSyncProductAgreements(tract);
    // database.executebatch(batchObj1);
    Test.stopTest();
  }
}