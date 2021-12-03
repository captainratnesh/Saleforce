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
 * This batch class is used sync products from GTV to Salesforce
 * @author AMAN JAIN
 */

public with sharing class BatchToSyncProductsFromTract implements Database.Batchable<sObject>, Database.AllowsCallouts, Database.Stateful {
  public APIDataService dataService;
  /**
   * constructor to initialize class variables
   * */
  public BatchToSyncProductsFromTract() {
    dataService = GTVDataService.getService();
  }
  /**
   * query price lists from org
   * */
  public Database.QueryLocator start(Database.BatchableContext bc) {
    string query = 'select id, Name, eid__c FROM Price_List__c ';
    return Database.getQueryLocator(query);
  }
  /**
   * query product from GTV database in salesforce org
   * @param scope list of pricelist
   * */
  public void execute(Database.BatchableContext bC, list<Price_List__c> scope) {
    dataService.getGTVProducts(scope);
  }
  /**
   * call batch to sync agreements
   * */
  public void finish(Database.BatchableContext bC) {
    TractBatchSyncProductAgreements SyncAgreements = new TractBatchSyncProductAgreements();
    Database.executeBatch(SyncAgreements, 9);
  }
}