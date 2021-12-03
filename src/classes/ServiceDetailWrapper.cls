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
 * This class is a wrapper of ServiceDetail.
 * @author Aman Jain
 */

public with sharing class ServiceDetailWrapper {
  @AuraEnabled
  public Date startDate;
  @AuraEnabled
  public Date endDate;
  @AuraEnabled
  public String status;
  @AuraEnabled
  public String productName;
  @AuraEnabled
  public String priceListName;
  @AuraEnabled
  public String orderNumber;
  @AuraEnabled
  public Boolean prepaidBalance;
  @AuraEnabled
  public list<AddressWrapper> addressInf;
  @AuraEnabled
  public list<ProductUsesWrapper> usageRuleInf;
  @AuraEnabled
  public list<ScheduleChargesWapper> scheduleChargeInf;
  @AuraEnabled
  public list<ServicePricesWrapper> servicePricesInf;
  @AuraEnabled
  public list<OneTimePricesWrapper> oneTimePricesInf;
  @AuraEnabled
  public list<DiscountCodeWrapper> discountInf;
}