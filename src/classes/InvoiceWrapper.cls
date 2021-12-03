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
 * This Wrapper is used to parse the API response for Invoice.
 * @author Aman Jain
 */

public with sharing class InvoiceWrapper {
  @AuraEnabled
  public String invoiceAmount;
  @AuraEnabled
  public String invoicePdf;
  @AuraEnabled
  public String invoiceAmountToPay;
  @AuraEnabled
  public Datetime dueDate;
  @AuraEnabled
  public String paidBy;
  @AuraEnabled
  public Datetime paidDate;
  @AuraEnabled
  public Datetime invoicedDate;
  @AuraEnabled
  public String status;
  @AuraEnabled
  public Boolean checkInvoiceStatus;
  @AuraEnabled
  public String name;
  @AuraEnabled
  public String currencyType;
}