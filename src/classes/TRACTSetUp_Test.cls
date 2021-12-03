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
 * This class is a test class of TRACTSetUp class.
 * @author Aman Jain
 */

@isTest
private class TRACTSetUp_Test {
  static testMethod void myUnitTest() {
    // TO DO: implement unit test
    TRACT_Setup__c tract = HelperClass.getTract();
    tract.Api_Version__c = '30';
    System.assert(tract != null);
    insert tract;

    Account account = HelperClass.getAccount();
    insert account;

    List<Account> thisAccountList = new List<Account>();
    thisAccountList.add(account);

    Opportunity opportunity = HelperClass.getOpportunity();
    opportunity.AccountId = account.Id;
    System.assert(opportunity != null);
    insert opportunity;

    List<Opportunity> thisOppList = new List<Opportunity>();
    thisOppList.add(opportunity);

    Service_Resource__c serviceresource = HelperClass.getServiceresource();
    insert serviceresource;

    Pricebook2 pricebook = HelperClass.getPriceBook2();
    insert pricebook;

    Product2 product = (Product2) SmartFactory.createSObject('Product2');
    product.name = 'product';
    product.eid__c = '12345';
    product.ProductCode = 'SUBSCRIPTION';
    product.IsActive = true;
    //product.ReccPriceOverride__c = true;
    product.PriceOverride__c = true;
    system.assert(product != null);
    insert product;

    Id pricebookId = Test.getStandardPricebookId();

    PricebookEntry pricebookEntryObj = (PricebookEntry) SmartFactory.createSObject(
      'PricebookEntry'
    );
    pricebookEntryObj.Pricebook2Id = pricebookId;
    pricebookEntryObj.Product2Id = product.Id;
    insert pricebookEntryObj;

    PricebookEntry pricebookEntryObj1 = (PricebookEntry) SmartFactory.createSObject(
      'PricebookEntry'
    );
    pricebookEntryObj1.Pricebook2Id = pricebook.id;
    pricebookEntryObj1.Product2Id = product.Id;
    pricebookEntryObj1.UnitPrice = 10000;
    pricebookEntryObj1.IsActive = true;
    system.assert(pricebookEntryObj1 != null);
    insert pricebookEntryObj1;

    OpportunityLineItem opportunityLineItemObj = (OpportunityLineItem) SmartFactory.createSObject(
      'OpportunityLineItem'
    );
    opportunityLineItemObj.PricebookEntryId = pricebookEntryobj1.id;
    opportunityLineItemObj.TotalPrice = 2000;
    opportunityLineItemObj.Quantity = 2;
    opportunityLineItemObj.eid__c = '12345';
    opportunityLineItemObj.username__c = 'user';
    opportunityLineItemObj.Email__c = 'ravi.6380@yahoo.com';
    opportunityLineItemObj.RecurringPrice__c = 100;
    opportunityLineItemObj.OneTimePrice__c = 500;
    opportunityLineItemObj.Service_Resource__c = serviceresource.Id;
    opportunityLineItemObj.OpportunityId = opportunity.Id;
    insert opportunityLineItemObj;

    TRACTSetUp.saveServiceResource();
    TRACTSetUp.saveServiceResource();
    TRACTSetUp.savePriceBook();

    TRACTSetUp.setupPriceBookNew(tract);
    TRACTSetUp.saveSalesOrder(opportunity.Id);
  }
}