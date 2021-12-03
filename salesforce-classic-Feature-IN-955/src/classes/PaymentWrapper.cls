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
 * This Wrapper is used to parse the API response for Payments.
 * @author Aman Jain
 */

public with sharing class PaymentWrapper {
  @AuraEnabled
  public String paymentAmount;
  @AuraEnabled
  public String createdBy;
  @AuraEnabled
  public String description;
  @AuraEnabled
  public String invoicesPaid;
  @AuraEnabled
  public Datetime occurredOn;
  @AuraEnabled
  public String paidBy;
  @AuraEnabled
  public Datetime paidDate;
  @AuraEnabled
  public String paymentMethodType;
  @AuraEnabled
  public String status;
  @AuraEnabled
  public String name;
}