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
 * This class is a test class of TractBatchServiceResource class.
 * @author Aman Jain
 */

@isTest
private class TractBatchServiceResource_Test {
  static testMethod void myUnitTest() {
    TractSetup__c tract = new TractSetup__c();
    tract.Name = 'test';
    tract.Api_Version__c = '30';
    tract.TRACT_URL__c = 'https://digitalocean.tract-staging.com/t/s/billing/1.30?wsdl';
    tract.Tract_User_Name__c = 'sfdc-3';
    system.assert(tract != null);
    insert tract;

    Account acc = new Account();
    acc.Name = 'test';
    insert acc;

    Product2 product2obj = (Product2) SmartFactory.createSObject('Product2');
    product2obj.Requires_Agreement__c = true;
    product2obj.eid__c = '12345';
    product2obj.Name = 'product';
    system.assert(product2obj != null);
    insert product2obj;

    list<String> str = new List<String>();
    str.add('1');
    str.add('2');

    //System.assertNotEquals(agreement,Null);
    Test.startTest();
    TractBatchServiceResource batchObj1 = new TractBatchServiceResource(
      tract,
      'entityType',
      'paramName',
      'paramValue',
      'queryScope',
      str,
      10
    );
    batchObj1.serviceResourceCategoryEids = '1';
    database.executebatch(batchObj1);
    Test.stopTest();
  }

  static testMethod void myTestMethod1() {
    TractSetup__c tract = new TractSetup__c();
    tract.Name = 'test';
    system.assert(tract != null);
    insert tract;

    Product2 product2obj = (Product2) SmartFactory.createSObject('Product2');
    product2obj.Requires_Agreement__c = true;
    product2obj.eid__c = '12345';
    product2obj.Name = 'product';
    system.assert(product2obj != null);
    insert product2obj;

    // System.assertNotEquals(agreement,Null);
    list<String> str = new List<String>();
    Test.startTest();
    //TractBatchServiceResource batchObj1 = new TractBatchServiceResource(tract, 'entityType', 'paramName', 'paramValue', 'queryScope', str, 10);
    // database.executebatch(batchObj1);
    Test.stopTest();
  }
}