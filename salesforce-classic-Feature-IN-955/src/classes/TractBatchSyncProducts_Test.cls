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
 * This class is a test class of TractBatchSyncProducts class.
 * @author Aman Jain
 */

@isTest
public class TractBatchSyncProducts_Test {
  static testMethod void myTestMethod() {
    //tract setup
    Tract_Setup__c tract2 = new Tract_Setup__c();
    tract2.Name = 'test';
    tract2.TRACT_URL__c = 'http://www.tractbilling.com/billing/1_30/service';
    system.assert(tract2 != null);
    insert tract2;

    List<Account> listofaccount = new List<Account>();
    for (Integer i = 0; i < 10; i++) {
      Account accountobj1 = new Account(name = 'accountToTest' + i);
      listofaccount.add(accountobj1);
    }
    insert listofaccount;

    String entityType = 'etype';
    String paramName = 'param';
    String paramValue = 'value';
    String queryScope = 'scope';
    long totalElements = 100;

    Id pricebookId = Test.getStandardPricebookId();

    Pricebook2 pb = HelperClass.getPriceBook2();
    insert pb;

    Product2 tempProductObj = (Product2) SmartFactory.createSObject('Product2');
    tempProductObj.name = 'test';
    tempProductObj.eid__c = '125';
    insert tempProductObj;

    PricebookEntry standardPrice = new PricebookEntry(
      Pricebook2Id = pricebookId,
      Product2Id = tempProductObj.Id,
      UnitPrice = 10000,
      IsActive = true,
      UseStandardPrice = false
    );
    insert standardPrice;

    PricebookEntry pbe = new PricebookEntry(
      Pricebook2Id = pb.Id,
      Product2Id = tempProductObj.Id,
      UnitPrice = 10000,
      IsActive = true,
      UseStandardPrice = false
    );
    insert pbe;

    /* ProductPrice__c productprice = new ProductPrice__c();
        productprice.Name='pprice';
        productprice.recurringPaymentRequired__c=true;
        productprice.currencyType__c='ctype';
        productprice.eid__c='12345';
        productprice.fromDate__c=date.valueOf('2014-9-9');
        productprice.paymentOnPurchaseRequired__c=true;
        productprice.priceOverride__c=true;
        productprice.parentProduct__c=tempProductObj.Id;
        productprice.parentProduct__r=tempProductObj;
        productprice.recurrencePeriod__c='recprice';
        productprice.thruDate__c=date.valueOf('2016-9-9');
        productprice.type__c='type';
        insert productprice;*/

    /*PricebookEntry PricebookEntry_obj = (PricebookEntry)SmartFactory.createSObject('PricebookEntry'); 
         PricebookEntry_obj.Pricebook2Id=pricebookId;
         PricebookEntry_obj.Product2Id= tempProductObj.Id;
         PricebookEntry_obj.product2=tempProductObj;
         PricebookEntry_obj.UnitPrice=10000;
         PricebookEntry_obj.Product2.Family=tempProductObj.Family;
         PricebookEntry_obj.IsActive=true;
         system.assert(PricebookEntry_obj != null);
         insert PricebookEntry_obj;*/

    Test.startTest();
    TractBatchSyncProducts batchObj = new TractBatchSyncProducts(
      tract2,
      entityType,
      paramName,
      paramValue,
      queryScope,
      totalElements
    );
    database.executebatch(batchObj);
    Test.stopTest();
  }
}