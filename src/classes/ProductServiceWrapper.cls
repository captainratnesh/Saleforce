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
 * This Wrapper is used to carry the service information to the lightning component..
 * @author Aman Jain
 */

public with sharing class ProductServiceWrapper {
  @AuraEnabled
  public string serviceName { get; set; }
  @AuraEnabled
  public TRACT_Setup__c thistract { get; set; }
  @AuraEnabled
  public Account thisAccount;
  @AuraEnabled
  public string tractUrl;
  @AuraEnabled
  public string servicProducteName { get; set; }
  @AuraEnabled
  public decimal quantity { get; set; }
  @AuraEnabled
  public string servicePrice { get; set; }
  @AuraEnabled
  public Boolean checkRuleOverrideValue { get; set; }
  @AuraEnabled
  public string ruleTypeValue { get; set; }
  @AuraEnabled
  public string parentServiceName { get; set; }
  @AuraEnabled
  public string committedThru { get; set; }
  @AuraEnabled
  public string renewAction { get; set; }
  @AuraEnabled
  public string statusDate { get; set; }
  @AuraEnabled
  public string parentServiceEId { get; set; }
  @AuraEnabled
  public string checkParentServiceEId { get; set; }
  @AuraEnabled
  public string status { get; set; }
  @AuraEnabled
  public string serviceEid { get; set; }
  @AuraEnabled
  public boolean checkTrailService { get; set; }
  @AuraEnabled
  public boolean checkDeactivateService { get; set; }
  @AuraEnabled
  public boolean checkChildElement { get; set; }
  @AuraEnabled
  public boolean checkSuspendService { get; set; }
  @AuraEnabled
  public boolean canAddServiceResource { get; set; }
  @AuraEnabled
  public boolean serialized { get; set; }
  @AuraEnabled
  public string productEid { get; set; }
  @AuraEnabled
  public string checkProductEid { get; set; }
  @AuraEnabled
  public string currencyType { get; set; }
  @AuraEnabled
  public string serviceProductCode { get; set; }
  @AuraEnabled
  public decimal serviceResourceNumber { get; set; }
  @AuraEnabled
  public boolean checkServiceResource { get; set; }
  @AuraEnabled
  public boolean childServiceSuspendCheck { get; set; }
  @AuraEnabled
  public boolean createBillingAccount { get; set; }
  @AuraEnabled
  public list<SelectOption> reasonList { get; set; }
  @AuraEnabled
  public list<SelectOption> suspendReasonList { get; set; }
  @AuraEnabled
  public list<SelectOption> countryListTract { get; set; }
  @AuraEnabled
  public list<SelectOption> stateUsaTract { get; set; }
  @AuraEnabled
  public list<SelectOption> stateMexTract { get; set; }
  @AuraEnabled
  public list<SelectOption> stateCanTract { get; set; }
  @AuraEnabled
  public AccountDetailController_LT.ChargeRulesWrapper chargeRuleWrapper {
    get;
    set;
  }
  @AuraEnabled
  public list<ProductServiceWrapper> childElements { get; set; }
}