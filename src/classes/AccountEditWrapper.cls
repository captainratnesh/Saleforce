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
 * This Wrapper class is used to carry the billing account information while configuring the billing account.
 * @author Aman Jain
 */

public class AccountEditWrapper {
  @AuraEnabled
  public list<SelectOption> currencyType { get; set; }
  @AuraEnabled
  public list<SelectOption> paymentTermList { get; set; }
  @AuraEnabled
  public List<SelectOption> accountCategoryList { get; set; }
  @AuraEnabled
  public List<SelectOption> billCycleList { get; set; }
  @AuraEnabled
  public List<SelectOption> billTypeList { get; set; }
  @AuraEnabled
  public String accountCategory { get; set; }
  @AuraEnabled
  public String accountCategoryName { get; set; }
  @AuraEnabled
  public String billCycleName { get; set; }
  @AuraEnabled
  public String paymentTerm { get; set; }
  @AuraEnabled
  public Date createDate { get; set; }
  @AuraEnabled
  public Boolean taxExempt { get; set; }
  @AuraEnabled
  public Boolean gtvBillingAccountNo { get; set; }
  @AuraEnabled
  public String selectedCurrency { get; set; }
  @AuraEnabled
  public String billType { get; set; }
  @AuraEnabled
  public String email { get; set; }

  public AccountEditWrapper() {
    accountCategory = ' ';
    billCycleName = ' ';
    paymentTerm = ' ';
    taxExempt = false;
    selectedCurrency = 'USD';
    billType = ' ';
    email = ' ';
  }
}