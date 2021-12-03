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
 * This Wrapper class is used to carry the product information from OLI while creating API request to create sales order.
 * @author AMAN JAIN
 */

public class TractProduct {
  public Product2 myProduct;
  public String productTypeCode;
  public Id myID;
  public Decimal quantity;
  public Decimal oneTimePrice;
  public Decimal recurringPrice;
  public String recurringProductPriceEid;
  public String oneTimeProductPriceEid;
  public String description;
  public String shortDescription;
  public String eid;
  public boolean priceOverride;
  public boolean reccPriceOverride;
  public String name;
  public boolean requires_Agreement;
  public String agreement_Name;
  public decimal agreement_Period;
  public String agreement_eid;
  public boolean serialized;
  public decimal minServiceResources;
  public decimal maxServiceResources;
  public String service_Resource_Category;
  public String productCode;
  public String userName;
  public String firstname;
  public String lastName;
  public String email;
  public Integer sequence;
  public String newServiceResource;
  public Service_Resource__c[] myServiceResourceList;
  public String agreementEndAction;
  public Date overrideAgreementEndDate;
  public String serviceId;
  public String productId;
  public String discountCodeName;
  public String discountCodeEid;
  public String tractServiceResourceName;
  public Decimal overridedTrialLength;
  public String tractServiceResourceEid;
  public String opportunityProductId { get; set; }
  public boolean addToExistingService;
  public String parentServiceEid;
  public Decimal productIndex;
  public Decimal parentProductIndex;
  public String priceListEid;
  public list<ProductPriceRangeWrapper> overridedRecurringPriceRangesList;
  public list<ProductPriceRangeWrapper> overridedOneTimePriceRangesList;
  public String nextAgreementEid;
  public String nextAgreementEndAction;
  public String renewalPricing;
  public String nextRenewalPricing;
}