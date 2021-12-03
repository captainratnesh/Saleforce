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
 * This Wrapper is used to carry the Schedule charges information to the Service detail lightning component.
 * @author Aman Jain
 */

public with sharing class ScheduleChargesWapper {
  @AuraEnabled
  public String status { get; set; }
  @AuraEnabled
  public String chargeType { get; set; }
  @AuraEnabled
  public String description { get; set; }
  @AuraEnabled
  public String amount { get; set; }
  @AuraEnabled
  public String invoiced { get; set; }
  @AuraEnabled
  public Date chargeDate { get; set; }
}