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
 * This Wrapper class is used to carry the billing hierarchy information to the account detail lightning component.
 * @author AMAN JAIN
 */

public with sharing class BillingHierarchyWrapper {
  @AuraEnabled
  public String responsibleAccountName;
  @AuraEnabled
  public String billCycle;
  @AuraEnabled
  public String responsibleAccountNumber;
  @AuraEnabled
  public String responsibleAccountCompanyName;
  @AuraEnabled
  public String renderingType;
  @AuraEnabled
  public Boolean isAvailable;
  @AuraEnabled
  public list<TRACTAccountWrapper> managedAccountList;
}