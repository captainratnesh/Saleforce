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
 * This class is no longer in use and can't be delted as it is a global class.
 * @author AMAN JAIN
 */

global class TractBatchSyncProducts implements Database.Batchable<sObject>, Database.AllowsCallouts, Database.Stateful {
  global SoapApi22Domain.Product[] results;
  global long totalExecution = 0;
  global static Integer totalLimit;
  global Integer totalSizeOfProduct = 0;

  @deprecated
  global TractSetup__c tractConfig;

  public Tract_Setup__c tractSetup;

  global String entityType;
  global String paramName;
  global String paramValue;
  global String queryScope;
  global long totalElements;

  @deprecated
  global TractBatchSyncProducts(
    TractSetup__c tractConfig,
    String entityType,
    String paramName,
    String paramValue,
    String queryScope,
    long totalElements
  ) {
  }

  public TractBatchSyncProducts(
    Tract_Setup__c tractSetup,
    String entityType,
    String paramName,
    String paramValue,
    String queryScope,
    long totalElements
  ) {
    this.tractSetup = tractSetup;
    this.entityType = entityType;
    this.paramName = paramName;
    this.paramValue = paramValue;
    this.queryScope = queryScope;
    this.totalElements = totalElements;
  }

  global Database.QueryLocator start(Database.BatchableContext bc) {
    totalExecution = (totalElements / 10) + 1;
    String query = 'select id FROM Account limit ' + totalExecution;

    return Database.getQueryLocator(query);
  }
  global void execute(Database.BatchableContext bC, list<sObject> scope) {
  }
  global void finish(Database.BatchableContext bC) {
  }
}