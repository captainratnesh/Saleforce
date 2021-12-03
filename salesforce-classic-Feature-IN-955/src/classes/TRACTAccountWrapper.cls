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
 * This Wrapper class is used to carry the billing account information to the account detail lightning component.
 * @author AMAN JAIN
 */

public class TRACTAccountWrapper {
  @AuraEnabled
  public String balance;
  @AuraEnabled
  public String accountCategory;
  @AuraEnabled
  public String status;
  @AuraEnabled
  public String billType;
  @AuraEnabled
  public String billCycleType;
  @AuraEnabled
  public String billCycleName;
  @AuraEnabled
  public String eid;
  @AuraEnabled
  public String accountCurrency;
  @AuraEnabled
  public Account billingAccount;
  @AuraEnabled
  public String email;
  @AuraEnabled
  public Date validFrom;
  @AuraEnabled
  public String acccountAddress;
  @AuraEnabled
  public String tractBillingAccountNumber;
  @AuraEnabled
  public String apiVersion;
  @AuraEnabled
  public String paymentTerm;
  @AuraEnabled
  public Boolean taxExempt;
  @AuraEnabled
  public String partyType;
  @AuraEnabled
  public String tracturl;
}