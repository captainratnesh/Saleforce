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
 * This is a batch class to clean up GTV data persisted in salesforce.
 * @author AMAN JAIN
 */

public class TractBatchCleanProducts implements Database.Batchable<sObject>, Database.AllowsCallouts, Database.Stateful, Schedulable {
  /**
   * Query product from salesforce database
   * */
  public Database.QueryLocator start(Database.BatchableContext bc) {
    // create a query string for all the products having a non null eid
    String query = 'select id,eid__c FROM Product2 where eid__c != null Limit 1';
    return Database.getQueryLocator(query);
  }
  /**
   * Remove existing data from tract in salesforce org
   * */
  public void execute(Database.BatchableContext bc, list<sObject> scope) {
    deleteExistingGTVData();

    set<Id> product2Ids = new Set<Id>();
    List<OpportunityLineItem> oppLineItem = [
      SELECT product2Id
      FROM OpportunityLineItem
      LIMIT 50000
    ];
    for (OpportunityLineItem oli : oppLineItem) {
      product2Ids.add(oli.product2Id);
    }
    //Query the products which have been added to Opportunities
    List<Product2> productWithoutOppLineItem = [
      SELECT Id, name
      FROM Product2
      WHERE id NOT IN :product2Ids AND eid__c != NULL
      LIMIT 50000
    ];
    if (!productWithoutOppLineItem.isEmpty()) {
      if (Product2.sObjectType.getDescribe().isDeletable()) {
        delete productWithoutOppLineItem;
      }
    }
    //Query the products which have not been added to Opportunities
    List<Product2> productWithOppLineItem = [
      SELECT Id, name, PriceLists__c, Price_Information__c
      FROM Product2
      WHERE id IN :Product2Ids AND eid__c != NULL
      LIMIT 50000
    ];
    if (!productWithOppLineItem.isEmpty()) {
      for (Product2 prod : productWithOppLineItem) {
        prod.PriceLists__c = '';
        prod.IsActive = false;
        prod.Price_Information__c = '';
      }
      if (Schema.sObjectType.Product2.isUpdateable()) {
        update productWithOppLineItem;
      }
    }
  }
  /**
   * query and insert new data from tract
   * */
  public void finish(Database.BatchableContext bc) {
    queryAndInsertGTVData();
    TRACT_Setup__c tractSetup = [
      SELECT Id, Gotransverse_Sync_Type__c
      FROM TRACT_Setup__c
      LIMIT 1
    ];
    if (!Test.isrunningTest()) {
      BatchToSyncProductsFromTract syncProducts = new BatchToSyncProductsFromTract();
      Database.executeBatch(syncProducts, 1);
    }
  }

  @TestVisible
  private static void deleteExistingGTVData() {
    // Delete service custome fields
    list<Tract_Service_Custom_Field__c> deleteServiceField = [
      SELECT Id
      FROM Tract_Service_Custom_Field__c
      LIMIT 50000
    ];
    // Delete order custom fields
    list<Tract_Order_Custom_Field__c> deleteOrderCustomField = [
      SELECT Id
      FROM Tract_Order_Custom_Field__c
      LIMIT 50000
    ];
    // Delete Account Custom field
    list<Account_Custom_Field__c> deleteAccountCustomField = [
      SELECT Id
      FROM Account_Custom_Field__c
      LIMIT 50000
    ];
    // Delete payment terms
    list<Payment_Term__c> deletePaymentTermList = [
      SELECT Id
      FROM Payment_Term__c
      LIMIT 50000
    ];
    //PriceList to delete
    list<Price_List__c> deletePriceList = [
      SELECT Id
      FROM Price_List__c
      LIMIT 50000
    ];
    list<TRACT_Bill_Cycle__c> deletebillCycle = [
      SELECT id, Name
      FROM TRACT_Bill_Cycle__c
      LIMIT 50000
    ];
    list<TRACTBillingAccountCategory__c> deleteBillingAccCategory = [
      SELECT id, Name
      FROM TRACTBillingAccountCategory__c
      LIMIT 50000
    ];
    list<System_Setting__c> systemSettingList = System_Setting__c.getall()
      .values();
    // Delete Billing Account Categories
    if (!deleteBillingAccCategory.isEmpty()) {
      if (
        TRACT3__TRACTBillingAccountCategory__c.sObjectType.getDescribe()
          .isDeletable()
      ) {
        delete deleteBillingAccCategory;
      }
    }
    // Delete Bill cycles
    if (!deletebillCycle.isEmpty()) {
      if (TRACT3__TRACT_Bill_Cycle__c.sObjectType.getDescribe().isDeletable()) {
        delete deletebillCycle;
      }
    }
    // Delete Service custom fields
    if (!deleteServiceField.isEmpty()) {
      if (
        TRACT3__Tract_Service_Custom_Field__c.sObjectType.getDescribe()
          .isDeletable()
      ) {
        delete deleteServiceField;
      }
    }
    // Delete account custom fields
    if (!deleteAccountCustomField.isEmpty()) {
      if (
        TRACT3__Account_Custom_Field__c.sObjectType.getDescribe().isDeletable()
      ) {
        delete deleteAccountCustomField;
      }
    }
    // Delete order custom fields
    if (!deleteOrderCustomField.isEmpty()) {
      if (
        TRACT3__Tract_Order_Custom_Field__c.sObjectType.getDescribe()
          .isDeletable()
      ) {
        delete deleteOrderCustomField;
      }
    }

    //delete Price List
    if (!deletePriceList.isEmpty()) {
      if (TRACT3__Price_List__c.sObjectType.getDescribe().isDeletable()) {
        delete deletePriceList;
      }
    }
    // Delete Payment terms
    if (!deletePaymentTermList.isEmpty()) {
      if (TRACT3__Payment_Term__c.sObjectType.getDescribe().isDeletable()) {
        delete deletePaymentTermList;
      }
    }
    // Delete System Settings
    if (!systemSettingList.isEmpty()) {
      if (TRACT3__System_Setting__c.sObjectType.getDescribe().isDeletable()) {
        delete systemSettingList;
      }
    }
  }

  @TestVisible
  private static void queryAndInsertGTVData() {
    list<TRACT_Setup__c> tractList = new List<TRACT_Setup__c>();
    tractList = [
      SELECT
        id,
        TPassword__c,
        Tract_User_Name__c,
        TRACT_URL__c,
        Api_Version__c,
        Selected_Marketplace_Id__c,
        Active__c,
        TRACT_URL2_0__c,
        X_API_Key__c,
        OrderStatus__c,
        Mapped_Custom_Field_Id__c
      FROM TRACT_Setup__c
      WHERE Active__c = TRUE
      LIMIT 1
    ];
    APIDataService dataService = GTVDataService.getService();
    // Get payment terms
    System.debug('paymentTerm starts');
    list<Payment_Term__c> paymentTermList = dataService.getPaymentTerms();
    System.debug('paymentTerm ends');
    // Get Bill cycles
    System.debug('BillCycle starts');
    list<TRACT_Bill_Cycle__c> listToInsertBillCycle = dataService.getBillCycles();
    System.debug('BillCycle ends');

    // Get Billing Account categories
    System.debug('billAccountCategory starts');
    list<TRACTBillingAccountCategory__c> billingAcccategoryList = dataService.getBillingAccountCategories();
    System.debug('billAccountCategory ends');

    // Get system settings
    list<System_Setting__c> systemSettingListToInsert;

    //Get default market place id
    String defaultMarketPlaceId = dataService.getDefaultMarketPlaceId();

    //Get Price List to insert
    list<Price_List__c> priceListToInsert = dataService.getPriceLists(
      tractList[0].Selected_Marketplace_Id__c
    );

    //Get Order Custom Fields
    list<Tract_Order_Custom_Field__c> tracOrderCustomFieldList = dataService.getOrderCustomFields();

    // Insert Bill cycles
    if (!listToInsertBillCycle.isEmpty()) {
      insert listToInsertBillCycle;
    }

    // Insert order custom fields
    if (!tracOrderCustomFieldList.isEmpty()) {
      insert tracOrderCustomFieldList;
    }

    // Insert PriceLists
    if (!priceListToInsert.isEmpty()) {
      insert priceListToInsert;
    }

    // Insert Billing account categories
    if (!billingAcccategoryList.isEmpty()) {
      insert billingAcccategoryList;
    }

    // Insert Payment terms
    if (!paymentTermList.isEmpty()) {
      insert paymentTermList;
    }
  }
  public void execute(SchedulableContext sc) {
    //database.executeBatch(new TractBatchCleanProducts());
  }
}