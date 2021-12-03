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
 * This Wrapper is used for Mapping of Account.
 * @author Aman Jain
 */

public with sharing class AccountMappingWrapper {
  @AuraEnabled
  public String accName;
  @AuraEnabled
  public String accNumber;
  @AuraEnabled
  public String fieldValue;
  @AuraEnabled
  public String selectedFieldValue;
  @AuraEnabled
  public String selectedConditionsValue;
  @AuraEnabled
  public map<String, String> mapOfNamesVsFieldValues;
  @AuraEnabled
  public map<String, String> mapOfNamesVsStatus;
  @AuraEnabled
  public map<String, String> mapOfNamesVsVales;
  @AuraEnabled
  public map<String, String> mapOfConditionVsValues;
  @AuraEnabled
  public List<SelectOption> accountStateList { get; set; }
  @AuraEnabled
  public String accountStatusValue { get; set; }
  @AuraEnabled
  public map<String, String> mapOfFieldNameOfObject;
  @AuraEnabled
  public list<sObject> accountRelatedListRecords { get; set; }
  @AuraEnabled
  public Boolean isRelatedList { get; set; }
  @AuraEnabled
  public List<SelectOption> setSonditions { get; set; }
  public AccountMappingWrapper() {
    accName = ' ';
    accNumber = '';
    accountStatusValue = 'Select from the Same Record';
    accountRelatedListRecords = new List<sObject>();
    isRelatedList = false;
    mapOfConditionVsValues = new Map<String, String>();
  }
}