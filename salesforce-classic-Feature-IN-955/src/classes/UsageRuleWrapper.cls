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
 * This Wrapper class is used to carry the Usage allowance information to the service detail lightning component.
 * @author Aman Jain
 */

public with sharing class UsageRuleWrapper {
  @AuraEnabled
  public String name { get; set; }
  @AuraEnabled
  public String rule { get; set; }
  @AuraEnabled
  public String rate { get; set; }
  @AuraEnabled
  public String allowance { get; set; }
  @AuraEnabled
  public String status { get; set; }
}