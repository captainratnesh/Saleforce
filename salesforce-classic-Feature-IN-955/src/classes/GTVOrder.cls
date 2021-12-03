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
 * The DTO to capture the required information for creating a sales order.
 * @author AMAN JAIN
 */
global class GTVOrder {
  global List<GTVCustomFieldValue> orderCustomFieldValues { get; set; }
  global String orderStatus { get; set; }
  @deprecated
  global String orderDate { get; set; }
  global DateTime orderPlacedDate { get; set; }
  global String note { get; set; }
  global String purchaseOrderNumber { get; set; }
  global Boolean emailReceipt { get; set; }
  global List<GTVOrderItem> orderItems { get; set; }

  global class GTVOrderItem {
    global Double quantity { get; set; }
    global String description { get; set; }
    global GTVProduct product { get; set; }
    global String priceListId { get; set; }
    global Long sequence { get; set; }
    global Datetime requestedEffectiveDate { get; set; }
    global Integer overrideTrialDays { get; set; }
    global GTVAgreement orderItemAgreement { get; set; }
    global List<GTVServiceResource> serviceResources { get; set; }
    global GTVDiscount orderItemDiscount { get; set; }
    global List<GTVCustomFieldValue> orderItemCustomFieldValues { get; set; }
    global String parentServiceId { get; set; }
    global List<GTVOrderItem> addOnOrderItems { get; set; }
    global List<GTVPrice> orderItemPrices { get; set; }
  }

  global class GTVProduct {
    global String id { get; set; }
    global String productType { get; set; }
    global String name { get; set; }
  }

  global class GTVAgreement {
    global String agreementId { get; set; }
    global Datetime endDate { get; set; }
    global String endAction { get; set; }
    global String nextAgreementId { get; set; }
    global String nextEndAction { get; set; }
    global Boolean preserveServicePrice { get; set; }
    global Boolean nextPreserveServicePrice { get; set; }
    global Integer agreementPeriod { get; set; }
  }

  global class GTVServiceResource {
    global String id { get; set; }
    global String identifier { get; set; }
    global String description { get; set; }
    global String resourceCategoryId { get; set; }
  }

  global class GTVDiscount {
    global String id { get; set; }
    global String identifier { get; set; }
  }

  global class GTVCustomFieldValue {
    global String id { get; set; }
    global String value { get; set; }
  }

  global class GTVPrice {
    global String priceType { get; set; }
    global String id { get; set; }
    global List<GTVPriceRange> priceRanges { get; set; }
    global List<GTVPriceCharge> scheduledCharges { get; set; }
    global List<GTVUsageRule> usageRules { get; set; }
  }

  global class GTVPriceRange {
    global Double price { get; set; }
    global Double quantityBeginRange { get; set; }
    global Double quantityEndRange { get; set; }
    global Integer level { get; set; }
    global String currencyCode { get; set; }
  }

  global class GTVPriceCharge {
    global String description { get; set; }
    global Double amount { get; set; }
    global Date chargeDate { get; set; }
  }

  global class GTVUsageRule {
    global String name { get; set; }
    global Double allowanceAmount { get; set; }
    global String allowanceUom { get; set; }
    global String allowanceType { get; set; }
    global Boolean proratedOnOrder { get; set; }
    global Boolean proratedOnCancel { get; set; }
    global String rolloverType { get; set; }
    global String ruleType { get; set; }
    global GTVUsageRate usageRate { get; set; }
    global GTVUsageRuleSpecification spec { get; set; }
    global String status { get; set; }
  }

  global class GTVUsageRate {
    global String rateType { get; set; }
    global String uom { get; set; }
    global Double rate { get; set; }
    global String usageChargeCategoryId { get; set; }
    global String usageFieldName { get; set; }
    global String rateTableId { get; set; }
  }

  global class GTVUsageRuleSpecification {
    global String specificationType { get; set; }
    global String operator { get; set; }
    global String fieldName { get; set; }
    global String fieldValue { get; set; }
  }
}