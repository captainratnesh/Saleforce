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
 * This class is a test class of SmartFactory class.
 * @author Aman Jain
 */

@isTest
private class SmartFactory_Test {
  static {
    SmartFactory.FillAllFields = true; // increase test coverage without creating custom objects
  }

  static testMethod void createsSingleObjectWithSingleRequiredStringField() {
    Account account = (Account) SmartFactory.createSObject('Account');
    insert account;
    System.assert(account.Id != null);
    System.assert(account.Name != null);
  }

  static testMethod void createsObjectWithCascadeSetsLookupField() {
    Contact contact = (Contact) SmartFactory.createSObject('Contact', true);
    insert contact;
    System.assert(contact.Id != null);
    System.assert(contact.AccountId != null);
  }
  static testMethod void myUnitTest() {
    List<contact> cont = (List<contact>) SmartFactory.createSObjectList(
      'Contact',
      false,
      5
    );
    insert cont;
    System.assertNotEquals(cont.size(), 0);
  }

  static testMethod void createsObjectWithoutCascadeDoesNotSetLookupField() {
    Contact contact = (Contact) SmartFactory.createSObject('Contact', false);
    insert contact;
    System.assert(contact.AccountId == null);
  }

  static testMethod void createObjectWithUnsupportedTypeThrowsException() {
    try {
      SmartFactory.createSObject('Unsupported');
      System.assert(false);
    } catch (Exception ex) {
      System.assert(true);
    }
  }
}