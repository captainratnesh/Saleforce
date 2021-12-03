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
 * This class is a Wrapper class of Sales Order Mapping.
 * @author Aman Jain
 */

public with sharing class SalesWrapper {
  @AuraEnabled
  public String orderStatus;
  @AuraEnabled
  public String purchaseOrderNumber;
  @AuraEnabled
  public Datetime orderDate;
  @AuraEnabled
  public String note;
  @AuraEnabled
  public String name;
}