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
 * The wrapper is used to parse the queried services response for the change order functionality on opportunity.
 * @author AMAN JAIN
 */
public with sharing class GTVServiceWrapper {
  @AuraEnabled
  public string serviceName { get; set; }
  @AuraEnabled
  public string productType { get; set; }
  @AuraEnabled
  public string description { get; set; }
  @AuraEnabled
  public Integer quantity { get; set; }
  @AuraEnabled
  public String total { get; set; }
  @AuraEnabled
  public string serviceId { get; set; }
}