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
 * This Wrapper is used to carry the configuration information to the Tract Configuration lightning component.
 * @author AMAN JAIN
 */

public with sharing class GTVBillingWrapper {
  @AuraEnabled
  public TRACT_Setup__c tract { get; set; }
  @AuraEnabled
  public String orderStatusValue { get; set; }
  @AuraEnabled
  public String syncTypeValue { get; set; }
  @AuraEnabled
  public String tractUrl { get; set; }
  @AuraEnabled
  public String tractUrl2 { get; set; }
  @AuraEnabled
  public String userName { get; set; }
  @AuraEnabled
  public String password { get; set; }
  @AuraEnabled
  public String selectedAPIVersion { get; set; }
  @AuraEnabled
  public Boolean existingTract { get; set; }
  @AuraEnabled
  public List<SelectOption> apiVersionList { get; set; }
  @AuraEnabled
  public String apiKey { get; set; }
  @AuraEnabled
  public List<SelectOption> orderStateList { get; set; }
  @AuraEnabled
  public List<SelectOption> syncTypeList { get; set; }
  @AuraEnabled
  public List<SelectOption> accountCustomFieldList { get; set; }
  @AuraEnabled
  public String selectedAccountCustomFieldId { get; set; }
  @AuraEnabled
  public List<SelectOption> accountCreationStateList { get; set; }
  @AuraEnabled
  public String accountCreationStateValue { get; set; }
  @AuraEnabled
  public Boolean batchTriggered { get; set; }
  @AuraEnabled
  public List<SelectOption> listOfMarketplaces { get; set; }
  @AuraEnabled
  public String selectedMarketplace { get; set; }
  @AuraEnabled
  public AccountMappingWrapper accountMappingWrapper { get; set; }
  @AuraEnabled
  public String hostedPaymentUrl { get; set; }
  @AuraEnabled
  public List<SelectOption> enabledOrderChangeList { get; set; }
  @AuraEnabled
  public List<SelectOption> changeOrderIndicatorList { get; set; }
  @AuraEnabled
  public string changeOrderIndicatorValue { get; set; }
  @AuraEnabled
  public string changeOrderIndicator { get; set; }
  @AuraEnabled
  public string enabledchangeOrderValue { get; set; }
  @AuraEnabled
  public Map<String, String> opportunityFieldNameVSType { get; set; }
  @AuraEnabled
  public List<SelectOption> oppFieldPicklist { get; set; }
  @AuraEnabled
  public String currencySet { get; set; }

  public GTVBillingWrapper() {
    enabledchangeOrderValue = 'No';
    orderStatusValue = 'DRAFT';
    syncTypeValue = 'MANUAL';
    selectedAccountCustomFieldId = 'External Account Number';
    selectedAPIVersion = 'API Version 1.0';
    accountCreationStateValue = 'I will Embed A Create GTV Account Button';
  }
}