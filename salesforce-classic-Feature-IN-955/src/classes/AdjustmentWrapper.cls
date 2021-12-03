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
 * This Wrapper is used to parse the API response for Adjustments
 * @author Aman Jain
 */

public with sharing class AdjustmentWrapper {
  @AuraEnabled
  public String type;
  @AuraEnabled
  public String description;
  @AuraEnabled
  public String adjutsmentAmount;
  @AuraEnabled
  public String showAdjustmentAmount;
  @AuraEnabled
  public String reason;
  @AuraEnabled
  public String creditUnappliedAmount;
  @AuraEnabled
  public Datetime occurredOn;
  @AuraEnabled
  public String invoice;
  @AuraEnabled
  public Datetime postedOn;
  @AuraEnabled
  public String manuallyApply;
  @AuraEnabled
  public Boolean credit;
  @AuraEnabled
  public String name;
  @AuraEnabled
  public String eid;
  @AuraEnabled
  public String status;
  @AuraEnabled
  public String orderItemId { get; set; }
}