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
 * This Wrapper is used to carry the Schedule charges information to the Schedule charge lightning component.
 * @author Aman Jain
 */

public with sharing class ScheduleChargeWrapper {
  @AuraEnabled
  public String chargeType;
  @AuraEnabled
  public String productId;
  @AuraEnabled
  public String productEid;
  @AuraEnabled
  public String schdeuleAmount;
  @AuraEnabled
  public Date schdeuleDate;
  @AuraEnabled
  public String schdeuleDescription;
  @AuraEnabled
  public String name;
  @AuraEnabled
  public String id;
}