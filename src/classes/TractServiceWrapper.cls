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
 * This Wrapper class is used to carry the Service information to the account detail lightning component.
 * @author Aman Jain
 */

public with sharing class TractServiceWrapper {
  @AuraEnabled
  public List<Service__c> serviceList { get; set; }
  @AuraEnabled
  public Integer totalPage { get; set; }
  @AuraEnabled
  public List<ProductServiceWrapper> productServiceWrap { get; set; }
  @AuraEnabled
  public String tractUrl { get; set; }
}