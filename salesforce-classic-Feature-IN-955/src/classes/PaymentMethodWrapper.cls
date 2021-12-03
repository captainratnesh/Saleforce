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
 * This Wrapper is used to parse the API response for the Payment Methods.
 * @author Aman Jain
 */

public with sharing class PaymentMethodWrapper {
  @AuraEnabled
  public String description { get; set; }
  @AuraEnabled
  public String address { get; set; }
  @AuraEnabled
  public Datetime validFrom { get; set; }
  @AuraEnabled
  public Datetime validTo { get; set; }
  @AuraEnabled
  public String phone { get; set; }
  @AuraEnabled
  public String email { get; set; }
  @AuraEnabled
  public boolean autoPayment { get; set; }
  @AuraEnabled
  public String nickName { get; set; }
}