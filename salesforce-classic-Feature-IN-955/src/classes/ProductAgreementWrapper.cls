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
 * This Wrapper is used to parse the API response for the Agreement.
 * @author Aman Jain
 */

public with sharing class ProductAgreementWrapper {
  @AuraEnabled
  public String name { get; set; }
  @AuraEnabled
  public Integer agreementPeriod { get; set; }
  @AuraEnabled
  public String agreementPeriodType { get; set; }
  @AuraEnabled
  public String endAction { get; set; }
  @AuraEnabled
  public String terminationFlatCharge { get; set; }
  @AuraEnabled
  public String maxTerminationFlatCharge { get; set; }
  @AuraEnabled
  public String adjustmentCategory { get; set; }
  @AuraEnabled
  public String currencyType { get; set; }
  @AuraEnabled
  public String eid { get; set; }
  @AuraEnabled
  public String status { get; set; }
  @AuraEnabled
  public Boolean isSelected { get; set; }
  @AuraEnabled
  public String prorateOnCancel { get; set; }
}