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
 * This class is used to call the API request to create recurring prices on a product from Salesforce to GTV.
 * @author AMAN JAIN
 */

public with sharing class CreateRecurringChargePriceController {
  /**
   * method to get CreateRecurringChargePriceWrapper
   * @param productId tract product id
   * @return CreateRecurringChargePriceWrapper
   * */
  @AuraEnabled
  public static CreateRecurringChargePriceWrapper getCreateRecurringChargePriceWrapper(
    String productId,
    String selectedPrice
  ) {
    CreateRecurringChargePriceWrapper createRecurringChargePriceWrapper = new CreateRecurringChargePriceWrapper();
    Product2 pro = [
      SELECT Id, name, eid__c
      FROM Product2
      WHERE Id = :productId
      LIMIT 1
    ];
    CreateRecurringChargePriceWrapper.productId = pro.eid__c;
    CreateRecurringChargePriceWrapper.sfdcProductId = productId;
    system.debug('selectedPrice:: ' + selectedPrice);
    APIDataService dataService = GTVDataService.getService();
    /* Setting up the list of Product Category*/
    createRecurringChargePriceWrapper.priceCategoryList = dataService.queryPriceCategories();
    /* Setting up the list of Billing Types*/
    List<SelectOption> billingTypeList = new List<SelectOption>();
    billingTypeList.add(new selectOption('Bill In Advance', 'Bill In Advance'));
    billingTypeList.add(new selectOption('Bill In Arrears', 'Bill In Arrears'));
    createRecurringChargePriceWrapper.billingTypeList = billingTypeList;
    /* Setting up the list of Currencies */
    createRecurringChargePriceWrapper.currencyList = dataService.getCurrencyType();
    /* Setting up the list of Bill In Advance Unit*/
    List<SelectOption> billInAdvanceUnitList = new List<SelectOption>();
    billInAdvanceUnitList.add(new selectOption('', 'Choose One'));
    billInAdvanceUnitList.add(new selectOption('BILLCYCLE', 'Bill Cycle'));
    billInAdvanceUnitList.add(new selectOption('DAY', 'Day'));
    billInAdvanceUnitList.add(new selectOption('WEEK', 'Week'));
    billInAdvanceUnitList.add(new selectOption('MONTH', 'Month'));
    billInAdvanceUnitList.add(new selectOption('YEAR', 'Year'));
    createRecurringChargePriceWrapper.billInAdvanceUnitList = billInAdvanceUnitList;
    /* Setting up the list of product price group */
    createRecurringChargePriceWrapper.productPriceGroupList = dataService.getProductPriceGroup();
    /* Setting up the list of Recurrence Period */
    createRecurringChargePriceWrapper.recurrencePeriodList = dataService.getRecurrencePeriod();
    ProductPriceWrapper productPriceWrapper = (ProductPriceWrapper) JSON.deserialize(
      selectedPrice,
      ProductPriceWrapper.class
    );
    if (productPriceWrapper != null) {
      if (productPriceWrapper.fromDate != null) {
        createRecurringChargePriceWrapper.fromDate = productPriceWrapper.fromDate.date();
      }
      if (productPriceWrapper.recurringPaymentRequired != null) {
        createRecurringChargePriceWrapper.autoPaymentRequired = productPriceWrapper.recurringPaymentRequired;
      }
      if (productPriceWrapper.currencyType != null) {
        createRecurringChargePriceWrapper.selectedcurrency = productPriceWrapper.currencyType;
      }
      if (productPriceWrapper.recurrencePeriod != null) {
        createRecurringChargePriceWrapper.recurrencePeriod = TractSFDC_Util.getRecurrencePeriod(
          productPriceWrapper.recurrencePeriod
        );
      }
      if (productPriceWrapper.paymentOnPurchaseRequired != null) {
        createRecurringChargePriceWrapper.payOnPurchase = productPriceWrapper.paymentOnPurchaseRequired;
      }
      if (productPriceWrapper.priceOverride != null) {
        createRecurringChargePriceWrapper.priceOverride = productPriceWrapper.priceOverride;
      }
      if (productPriceWrapper.priceCategoryId != null) {
        createRecurringChargePriceWrapper.priceCategory = productPriceWrapper.priceCategoryId;
      }
      if (productPriceWrapper.proratedOnOrder != null) {
        createRecurringChargePriceWrapper.proratedOnOrder = productPriceWrapper.proratedOnOrder;
      }
      if (productPriceWrapper.proratedOnOrderNoCharge != null) {
        createRecurringChargePriceWrapper.proratedOnOrderNoCharge = productPriceWrapper.proratedOnOrderNoCharge;
      }
      if (productPriceWrapper.proratedOnCancel != null) {
        createRecurringChargePriceWrapper.proratedOnCancel = productPriceWrapper.proratedOnCancel;
      }
      if (productPriceWrapper.priceRangesList != null) {
        createRecurringChargePriceWrapper.createPriceRangeWrapper.remove(0);
        for (
          ProductPriceRangeWrapper priceRange : productPriceWrapper.priceRangesList
        ) {
          CreatePriceRangeWrapper priceRangeWrap = new CreatePriceRangeWrapper();
          priceRangeWrap.Tier = 'Tier ' + priceRange.level;
          priceRangeWrap.startingQuantity = integer.valueOf(
            priceRange.quantityBeginRange
          );
          priceRangeWrap.endingQuantity = integer.valueOf(
            priceRange.quantityEndRange
          );
          priceRangeWrap.Price = priceRange.price;
          priceRangeWrap.eid = priceRange.eid;
          priceRangeWrap.currencyType = priceRange.currencyType;
          system.debug('priceRangeWrap :' + priceRangeWrap);
          createRecurringChargePriceWrapper.createPriceRangeWrapper.add(
            priceRangeWrap
          );
        }
      }
      if (productPriceWrapper.eid != null)
        createRecurringChargePriceWrapper.eid = productPriceWrapper.eid;
      if (productPriceWrapper.priceGroupId != null) {
        createRecurringChargePriceWrapper.productPriceGroup = productPriceWrapper.priceGroupId;
      }
      if (productPriceWrapper.billInAdvance) {
        createRecurringChargePriceWrapper.billingType = 'Bill In Advance';
        createRecurringChargePriceWrapper.billInAdvance = productPriceWrapper.billInAdvanceAmount;
        createRecurringChargePriceWrapper.billInAdvanceUnit = productPriceWrapper.billInAdvanceUnit;
      } else {
        createRecurringChargePriceWrapper.billingType = 'Bill In Arrears';
      }
    }
    return createRecurringChargePriceWrapper;
  }
  /**
   * method to get CreatePriceRangeWrapper
   * @return CreatePriceRangeWrapper
   * */
  @AuraEnabled
  public static CreatePriceRangeWrapper getCreatePriceRangeWrapper() {
    CreatePriceRangeWrapper createPriceRangeWrapper = new CreatePriceRangeWrapper();
    return createPriceRangeWrapper;
  }
  /**
   * method to create Product Price
   * @param productId tract product id
   * @return error msg
   * */
  @AuraEnabled
  public static String createProductPrice(
    String createProductPriceWrapperString,
    String priceListId
  ) {
    String emessage = '';
    CreateRecurringChargePriceWrapper createProductPriceWrapper = (CreateRecurringChargePriceWrapper) JSON.deserialize(
      createProductPriceWrapperString,
      CreateRecurringChargePriceWrapper.class
    );
    APIDataService dataService = GTVDataService.getService();
    if (createProductPriceWrapper.eid == null) {
      emessage = dataService.createGtvRecurringProductPrice(
        createProductPriceWrapper,
        priceListId
      );
    } else {
      emessage = dataService.updateGtvRecurringProductPrice(
        createProductPriceWrapper,
        priceListId
      );
    }
    return emessage;
  }
}