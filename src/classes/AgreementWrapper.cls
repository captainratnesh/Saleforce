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
 * This Wrapper is used to carry the Agreement information to the add agreement lightning component.
 * @author Aman Jain
 */

public class AgreementWrapper {
  @AuraEnabled
  public list<SelectOption> agreementList { get; set; }
  @AuraEnabled
  public list<SelectOption> renewAction { get; set; }
  @AuraEnabled
  public Map<String, Decimal> mapOfAgreementPeriod { get; set; }
  @AuraEnabled
  public Map<String, String> mapOfAgreementPeriodType { get; set; }
  @AuraEnabled
  public Boolean hasAgreement { get; set; }
  @AuraEnabled
  public list<SelectOption> nextAgreementList { get; set; }
  @AuraEnabled
  public list<SelectOption> nextRenewAction { get; set; }
  @AuraEnabled
  public list<SelectOption> renewalPricingOption { get; set; }
  @AuraEnabled
  public Map<String, String> mapOfAgreementIdVsAgreementEndAction { get; set; }
}