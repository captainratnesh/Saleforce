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
 * This class is a test class of TractProductDetailExt class.
 * @author Aman Jain
 */

@isTest
public class TractProductDetailExt_test {
  static testMethod void tractProductDetailExttest2() {
    TRACT_Setup__c tractSetup = HelperClass.getAPI1TRACT();
    insert tractSetup;
    Product2 product = HelperClass.getProduct2();
    product.eid__c = '12345';
    product.ProductCode = 'TRACT_SUBSCRIPTION';
    product.minServiceResources__c = 10;
    product.IsActive = false;
    product.Price_Information__c = '[{"thruDate":null,"scheduledCharges":false,"recurringPaymentRequired":false,"recurrencePeriod":"MONTH","priceType":"OneTime","priceRangesList":[{"quantityEndRange":null,"quantityBeginRange":0.00,"price":100.00,"level":1,"eid":"14702","currencyType":"USD"}],"priceOverride":true,"priceListEid":"228","paymentOnPurchaseRequired":false,"fromDate":"2014-11-07T06:00:00.000Z","eid":"13700","currencyType":"USD"},{"thruDate":null,"scheduledCharges":false,"recurringPaymentRequired":false,"recurrencePeriod":"BILLCYCLE","priceType":"Recurring","priceRangesList":[{"quantityEndRange":1.00,"quantityBeginRange":0.00,"price":5.00,"level":1,"eid":"47138","currencyType":"USD"},{"quantityEndRange":null,"quantityBeginRange":1.00,"price":0.00,"level":2,"eid":"47140","currencyType":"USD"}],"priceOverride":true,"priceListEid":"228","paymentOnPurchaseRequired":false,"fromDate":"2018-08-30T05:00:00.000Z","eid":"43272","currencyType":"USD"}]';
    product.Agreement_Information__c = '[{"terminationFlatCharge":"$0.0","status":"ACTIVE","prorateOnCancel":null,"Name":"Agreement 1!","maxTerminationFlatCharge":null,"isSelected":null,"endAction":"RENEW_AGREEMENT","eid":"4316","currencyType":"USD","agreementPeriodType":"MONTHs","agreementPeriod":3,"adjustmentCategory":"Default Adjustment Category"}]';
    product.maxServiceResources__c = 10;
    system.assert(product != null);
    insert product;
    ProductRelationWrapper relationWrapper = new ProductRelationWrapper();
    ProductChargeRuleWrapper chargeWrapp = new ProductChargeRuleWrapper();
    string jsonstring = JSON.serialize(chargeWrapp);
    Test.startTest();
    TractProductDetailExt.getAPIVersion();
    TractProductDetailExt.showChargeRuleModel();
    TractProductDetailExt.getchargeListBytesMethod();
    TractProductDetailExt.getFormulaUsageRuleSpecificationListMethod();
    TractProductDetailExt.checkProduct(product.Id);
    TractProductDetailExt.getProductId(product.Id);
    TractProductDetailExt.getDiscountCode(product.Id);
    TractProductDetailExt.getOneTimeProductPrices(product.Id);
    TractProductDetailExt.getRecurringProductPrices(product.Id);
    TractProductDetailExt.getproductCustomFieldsList(product.Id);
    TractProductDetailExt.getAgreements(product.Id);
    TractProductDetailExt.getproductCustomFieldValueList(product.Id);
    TractProductDetailExt.saveProductCustomFieldValues(product.Id, '123');
    TractProductDetailExt.queryProductUsageChargeRule(product.Id, '123');
    TractProductDetailExt.queryProductRelationList(product.id);
    TractProductDetailExt.deleteProductRelations(
      JSON.serialize(relationWrapper),
      '1234'
    );
    TractProductDetailExt.addChargerules(product.Id, '1243', jsonstring);
    TractProductDetailExt.activateProduct(product.Id);
    Test.stopTest();
  }

  static testMethod void tractProductDetailExttest3() {
    TRACT_Setup__c tractSetup = HelperClass.getAPI2TRACT();
    insert tractSetup;
    list<ProductAgreementWrapper> wrapList = new List<ProductAgreementWrapper>();
    ProductChargeRuleWrapper chargeWrapp = new ProductChargeRuleWrapper();
    string chargeWrapString = JSON.serialize(chargeWrapp);
    ProductAgreementWrapper agreWrap = new ProductAgreementWrapper();
    agreWrap.eid = '12345';
    String jjstr = JSON.serialize(agreWrap);
    wrapList.add(agreWrap);
    String jsonString = JSON.serialize(wrapList);
    Product2 product = HelperClass.getProduct2();
    product.eid__c = '';
    product.ProductCode = 'TRACT_SUBSCRIPTION';
    product.minServiceResources__c = 10;
    product.IsActive = false;
    product.Price_Information__c = '[{"thruDate":null,"scheduledCharges":false,"recurringPaymentRequired":false,"recurrencePeriod":"MONTH","priceType":"OneTime","priceRangesList":[{"quantityEndRange":null,"quantityBeginRange":0.00,"price":100.00,"level":1,"eid":"14702","currencyType":"USD"}],"priceOverride":true,"priceListEid":"228","paymentOnPurchaseRequired":false,"fromDate":"2014-11-07T06:00:00.000Z","eid":"13700","currencyType":"USD"},{"thruDate":null,"scheduledCharges":false,"recurringPaymentRequired":false,"recurrencePeriod":"BILLCYCLE","priceType":"Recurring","priceRangesList":[{"quantityEndRange":1.00,"quantityBeginRange":0.00,"price":5.00,"level":1,"eid":"47138","currencyType":"USD"},{"quantityEndRange":null,"quantityBeginRange":1.00,"price":0.00,"level":2,"eid":"47140","currencyType":"USD"}],"priceOverride":true,"priceListEid":"228","paymentOnPurchaseRequired":false,"fromDate":"2018-08-30T05:00:00.000Z","eid":"43272","currencyType":"USD"}]';
    product.Agreement_Information__c = '[{"terminationFlatCharge":"$0.0","status":"ACTIVE","prorateOnCancel":null,"Name":"Agreement 1!","maxTerminationFlatCharge":null,"isSelected":null,"endAction":"RENEW_AGREEMENT","eid":"4316","currencyType":"USD","agreementPeriodType":"MONTHs","agreementPeriod":3,"adjustmentCategory":"Default Adjustment Category"}]';
    product.maxServiceResources__c = 10;
    system.assert(product != null);
    insert product;
    ProductRelationWrapper relationWrapper = new ProductRelationWrapper();
    Test.startTest();
    TractProductDetailExt.getAPIVersion();
    TractProductDetailExt.showChargeRuleModel();
    TractProductDetailExt.getchargeListBytesMethod();
    TractProductDetailExt.getFormulaUsageRuleSpecificationListMethod();
    TractProductDetailExt.checkProduct(product.Id);
    TractProductDetailExt.getProductId(product.Id);
    TractProductDetailExt.getDiscountCode(product.Id);
    TractProductDetailExt.activateProduct(product.Id);
    TractProductDetailExt.getOneTimeProductPrices(product.Id);
    TractProductDetailExt.getRecurringProductPrices(product.Id);
    TractProductDetailExt.getproductCustomFieldsList(product.Id);
    TractProductDetailExt.getproductCustomFieldValueList(product.Id);
    TractProductDetailExt.getAllProductAgreements();
    TractProductDetailExt.getAgreements(product.Id);
    TractProductDetailExt.setAgreements(jsonString, product.id);
    TractProductDetailExt.deleteProductAgreementRelation(product.id, jjstr);
    TractProductDetailExt.queryProductRelationList(product.id);
    TractProductDetailExt.queryProductUsageChargeRule(product.Id, '123');
    TractProductDetailExt.deleteProductRelations(
      JSON.serialize(relationWrapper),
      '1234'
    );
    TractProductDetailExt.addChargerules(product.Id, '1243', chargeWrapString);
    Test.stopTest();
  }
  static testMethod void tractProductDetailExttest4() {
    TRACT_Setup__c tractSetup = HelperClass.getAPI2TRACT();
    insert tractSetup;
    list<ProductAgreementWrapper> wrapList = new List<ProductAgreementWrapper>();
    ProductAgreementWrapper agreWrap = new ProductAgreementWrapper();
    agreWrap.eid = '12345';
    String jjstr = JSON.serialize(agreWrap);
    wrapList.add(agreWrap);
    String jsonString = JSON.serialize(wrapList);
    Product2 product = HelperClass.getProduct2();
    product.eid__c = '';
    product.ProductCode = 'TRACT_SUBSCRIPTION';
    product.minServiceResources__c = 10;
    product.IsActive = false;
    product.Price_Information__c = '[{"thruDate":null,"scheduledCharges":false,"recurringPaymentRequired":false,"recurrencePeriod":"MONTH","priceType":"OneTime","priceRangesList":[{"quantityEndRange":null,"quantityBeginRange":0.00,"price":100.00,"level":1,"eid":"14702","currencyType":"USD"}],"priceOverride":true,"priceListEid":"228","paymentOnPurchaseRequired":false,"fromDate":"2014-11-07T06:00:00.000Z","eid":"13700","currencyType":"USD"},{"thruDate":null,"scheduledCharges":false,"recurringPaymentRequired":false,"recurrencePeriod":"BILLCYCLE","priceType":"Recurring","priceRangesList":[{"quantityEndRange":1.00,"quantityBeginRange":0.00,"price":5.00,"level":1,"eid":"47138","currencyType":"USD"},{"quantityEndRange":null,"quantityBeginRange":1.00,"price":0.00,"level":2,"eid":"47140","currencyType":"USD"}],"priceOverride":true,"priceListEid":"228","paymentOnPurchaseRequired":false,"fromDate":"2018-08-30T05:00:00.000Z","eid":"43272","currencyType":"USD"}]';
    product.Agreement_Information__c = '[{"terminationFlatCharge":"$0.0","status":"ACTIVE","prorateOnCancel":null,"Name":"Agreement 1!","maxTerminationFlatCharge":null,"isSelected":null,"endAction":"RENEW_AGREEMENT","eid":"4316","currencyType":"USD","agreementPeriodType":"MONTHs","agreementPeriod":3,"adjustmentCategory":"Default Adjustment Category"}]';
    product.maxServiceResources__c = 10;
    system.assert(product != null);
    insert product;
    list<ProductCustomFieldWrapper> wrapperList = new List<ProductCustomFieldWrapper>();
    ProductCustomFieldWrapper wrapper = new ProductCustomFieldWrapper();
    wrapper.name = 'Test';
    wrapper.eid = 'Test';
    wrapper.value = 'Test';
    wrapperList.add(wrapper);
    Test.startTest();
    TractProductDetailExt.getAPIVersion();
    TractProductDetailExt.showChargeRuleModel();
    TractProductDetailExt.getchargeListBytesMethod();
    TractProductDetailExt.getFormulaUsageRuleSpecificationListMethod();
    TractProductDetailExt.checkProduct(product.Id);
    TractProductDetailExt.getProductId(product.Id);
    TractProductDetailExt.getDiscountCode(product.Id);
    TractProductDetailExt.activateProduct(product.Id);
    TractProductDetailExt.getAllProductAgreements();
    TractProductDetailExt.getOneTimeProductPrices(product.Id);
    TractProductDetailExt.getRecurringProductPrices(product.Id);
    TractProductDetailExt.getAgreements(product.Id);
    TractProductDetailExt.getproductCustomFieldsList(product.Id);
    TractProductDetailExt.getproductCustomFieldValueList(product.Id);
    TractProductDetailExt.saveProductCustomFieldValues(
      product.Id,
      JSON.serialize(wrapperList)
    );
    TractProductDetailExt.setAgreements(jsonString, product.id);
    TractProductDetailExt.deleteProductAgreementRelation(product.id, jjstr);
    Test.stopTest();
  }
}