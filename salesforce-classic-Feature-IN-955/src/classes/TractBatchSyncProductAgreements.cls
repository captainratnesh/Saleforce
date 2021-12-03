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
 * This is a batch class to sync agreements from GTV to salesforce.
 * @author AMAN JAIN
 */

global with sharing class TractBatchSyncProductAgreements implements Database.Batchable<sObject>, Database.AllowsCallouts, Database.Stateful {
  @deprecated
  global TractSetup__c tractConfig;
  public Tract_Setup__c tractSetup;
  public list<Product2> productListToUpdate;
  public APIDataService dataService;
  /**
   * @description: Contructor to intialize the class variables.
   */
  global TractBatchSyncProductAgreements() {
    productListToUpdate = new List<Product2>();
    dataService = GTVDataService.getService();
  }
  /**
   * @description: Contructor to intialize the class variables.
   * @param tractConfig configuration setting to configure data from tract.
   */
  @deprecated
  global TractBatchSyncProductAgreements(TractSetup__c tractConfig) {
    this.tractConfig = tractConfig;
    productListToUpdate = new List<Product2>();
  }
  /**
   * @description: Contructor to intialize the class variables.
   * @param tractConfig configuration setting to configure data from tract.
   */
  global TractBatchSyncProductAgreements(Tract_Setup__c tractConfig) {
    this.tractSetup = tractConfig;
  }
  /**
   * @description: start method to query product with there agreement information whether they have or not.
   * @return list of products
   */
  global Database.QueryLocator start(Database.BatchableContext bc) {
    String query = 'select Agreement_Information__c, eid__c, name, id  from Product2 where eid__c <> null';
    return Database.getQueryLocator(query);
  }
  /**
   * @description: execute method to update product list with there realted agreements.
   */
  global void execute(Database.BatchableContext bc, list<sObject> scope) {
    List<Product2> listOfProducts = (list<Product2>) scope;
    List<Product2> currentProductList = new List<Product2>();
    if (listOfProducts != null && !listOfProducts.isEmpty()) {
      currentProductList = dataService.getGTVAgreeements(listOfProducts);
      productListToUpdate.addAll(currentProductList);
    }
  }
  /**
   * @description: finish method to perform update dml to update product with there realted agreements.
   */
  global void finish(Database.BatchableContext bc) {
    if (null != productListToUpdate && !productListToUpdate.isEmpty()) {
      update productListToUpdate;
    }
    TRACT_Setup__c tract;
    list<TRACT_Setup__c> tractList = new List<TRACT_Setup__c>();
    /* Querying the TRACT Setup Object */
    tractList = [
      SELECT
        id,
        TPassword__c,
        Tract_User_Name__c,
        TRACT_URL__c,
        Api_Version__c,
        Active__c,
        TRACT_URL2_0__c,
        X_API_Key__c,
        OrderStatus__c,
        Mapped_Custom_Field_Id__c,
        Batch_Triggered__c
      FROM TRACT_Setup__c
      WHERE Active__c = TRUE
      LIMIT 1
    ];
    /* Checking if the TRACT Setup record exist */
    if (!tractList.IsEmpty()) {
      tract = tractList.get(0);
      tract.Batch_Triggered__c = false;
      if (
        TRACTAPIUtil.checkFieldLevelSecurity(
          'TRACT3__TRACT_Setup__c',
          'Batch_Triggered__c',
          'Update'
        )
      ) {
        update tract;
      }
    }
  }
}