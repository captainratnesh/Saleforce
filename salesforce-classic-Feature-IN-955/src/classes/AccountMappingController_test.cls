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
 * This class is a test class of AccountMappingController class.
 * @author Aman Jain
 */

@istest
public with sharing class AccountMappingController_test {
  @istest
  public static void testAccountMapping() {
    Account acc = new Account();
    acc.name = 'Test Account';
    insert acc;
    Contact con = new Contact();
    con.FirstName = 'test';
    con.lastName = 'testCon';
    con.MailingCity = 'test';
    con.MailingCountry = 'USA test';
    con.MailingPostalCode = '123456';
    con.AccountId = acc.id;
    insert con;
    TRACT_Mappings__c maptract = new TRACT_Mappings__c();
    maptract.name = 'TRACT Account Mapping';
    maptract.TRACT_Account_Fields__c = '{ "AccountName":[ "Contact.Name", "Select from the Related List", "Name starts with test" ], "AccountNumber":[ "ParentId.AccountNumber", "Select from the Same Record", "" ], "BillingStreet":[ "BillingStreet", "Select from the Same Record", "" ], "BillingCity":[ "Contact.MailingCity", "Select from the Related List", "MailingCity equals test" ], "BillingCode":[ "Contact.MailingPostalCode", "Select from the Related List", "MailingPostalCode contains 1234" ], "BillingState":[ "BillingState", "Select from the Same Record", "" ], "BillingCountry":[ "Contact.MailingCountry", "Select from the Related List", "MailingCountry ends with test" ], "ShippingStreet":[ "ShippingStreet", "Select from the Same Record", "" ], "ShippingCity":[ "ShippingCity", "Select from the Same Record", "" ], "ShippingCode":[ "ShippingPostalCode", "Select from the Same Record", "" ], "ShippingState":[ "ShippingState", "Select from the Same Record", "" ], "ShippingCountry":[ "ShippingCountry", "Select from the Same Record", "" ], "Phone":[ "Phone", "Select from the Same Record", "" ], "GotransverseEmail":[ "TRACT3__Email__c", "Select from the Same Record", "" ] }';
    insert maptract;
    test.startTest();
    AccountMappingController.showAccountMap(acc.id);
    test.stopTest();
  }
}