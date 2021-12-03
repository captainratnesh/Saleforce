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
 * This Wrapper is used to carry the usage rule information to the lightning component.
 * @author Aman Jain
 */

public class ProductUsesWrapper {
  @AuraEnabled
  public String chargeName { get; set; }
  @AuraEnabled
  public String chargeType { get; set; }
  @AuraEnabled
  public String rule { get; set; }
  @AuraEnabled
  public String usageRuleEid { get; set; }
  @AuraEnabled
  public String chargeCategory { get; set; }
  @AuraEnabled
  public String taper { get; set; }
  @AuraEnabled
  public String rate { get; set; }
  @AuraEnabled
  public String fromDate { get; set; }
  @AuraEnabled
  public String thruDate { get; set; }
  @AuraEnabled
  public String status { get; set; }
  @AuraEnabled
  public String recordId { get; set; }
}