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
 * This class is a test class of CreateContactOnTRACTExtension class.
 * @author Aman Jain
 */

@isTest
public class CreateContactOnTRACTExtension_Test {
  static testMethod void testContactWithoutParentId() {
    Account account = HelperClass.getAccount();
    account.Tract_Billing_Account__c = null;
    System.assert(account != null);
    insert account;

    Contact conTestObj = new Contact(
      lastName = 'Test',
      Accountid = account.id,
      Tract_Contact_Eid__c = '123345'
    );
    insert conTestObj;

    Test.startTest();
    PageReference pageRef = Page.CreateContactOnTRACT;
    Test.setCurrentPage(pageRef);
    ApexPages.StandardController sc = new ApexPages.standardController(
      conTestObj
    );
    CreateContactOnTRACTExtension page = new CreateContactOnTRACTExtension(sc);
    page.createContactOnTract();
    Test.stopTest();
  }
  static testMethod void testContactWithParentId() {
    Account account = HelperClass.getAccount();
    System.assert(account != null);
    insert account;

    Contact conTestObj = new Contact(
      lastName = 'Test',
      Accountid = account.id,
      Tract_Contact_Eid__c = '123345'
    );
    insert conTestObj;

    Test.startTest();
    PageReference pageRef = Page.CreateContactOnTRACT;
    Test.setCurrentPage(pageRef);
    ApexPages.StandardController sc = new ApexPages.standardController(
      conTestObj
    );
    CreateContactOnTRACTExtension page = new CreateContactOnTRACTExtension(sc);
    page.createContactOnTract();
    Test.stopTest();
  }
  static testMethod void testContactWithoutEid() {
    Account account = HelperClass.getAccount();
    System.assert(account != null);
    insert account;

    Contact conTestObj = new Contact(lastName = 'Test', Accountid = account.id);
    insert conTestObj;

    Test.startTest();
    PageReference pageRef = Page.CreateContactOnTRACT;
    Test.setCurrentPage(pageRef);
    ApexPages.StandardController sc = new ApexPages.standardController(
      conTestObj
    );
    CreateContactOnTRACTExtension page = new CreateContactOnTRACTExtension(sc);
    page.createContactOnTract();
    Test.stopTest();
  }
}