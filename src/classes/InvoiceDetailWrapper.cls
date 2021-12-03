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
 * This Wrapper is used to carry the Invoice information to the Invoice lightning component.
 * @author Aman Jain
 */

public with sharing class InvoiceDetailWrapper {
  @AuraEnabled
  public String invoiceType;
  @AuraEnabled
  public String invoiceAmountToPay;
  @AuraEnabled
  public Date dueDate;
  @AuraEnabled
  public String paidBy;
  @AuraEnabled
  public Datetime occuredOn;
  @AuraEnabled
  public String billPeriod;
  @AuraEnabled
  public String billCycle;
  @AuraEnabled
  public Boolean isBillCycle;
  @AuraEnabled
  public String billBatch;
  @AuraEnabled
  public Boolean isBillBatch;
  @AuraEnabled
  public String disputed;
  @AuraEnabled
  public String name;
  @AuraEnabled
  public String serviceCharges;
  @AuraEnabled
  public String serviceActivityCharge;
  @AuraEnabled
  public String otherCharge;
  @AuraEnabled
  public String taxFees;
  @AuraEnabled
  public String totalCharge;
  @AuraEnabled
  public list<InvoiceItemWrapper> invoiceItems;
}