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
 * This Wrapper is used to parse the API response for Invoice Item.
 * @author Aman Jain
 */

public with sharing class InvoiceItemWrapper {
  @AuraEnabled
  public String type;
  @AuraEnabled
  public String description;
  @AuraEnabled
  public Date dueDate;
  @AuraEnabled
  public String charges;
  @AuraEnabled
  public Datetime occuredOn;
  @AuraEnabled
  public String totalAmount;
  @AuraEnabled
  public String billCycle;
  @AuraEnabled
  public Boolean isBillCycle;
  @AuraEnabled
  public String serviceName;
}