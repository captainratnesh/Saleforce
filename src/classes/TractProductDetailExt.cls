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
 * This class is the Controller to handle the product detail module.
 * @author AMAN JAIN
 */

public with sharing class TractProductDetailExt {
  /**
   *Method to get API version
   *@return boolean value
   */
  @AuraEnabled
  public static boolean getAPIVersion() {
    TRACT_Setup__c tractList = new TRACT_Setup__c();
    tractList = [
      SELECT id, TPassword__c, Tract_User_Name__c, TRACT_URL__c, Api_Version__c
      FROM TRACT_Setup__c
      LIMIT 1
    ];
    GTVAPIVersion vers = TractSFDC_Util.getAPIEnumValue(
      tractList.Api_Version__c
    );
    if (vers.name() == 'API_V1') {
      return false;
    } else {
      return true;
    }
  }

  /**
   *Method to get Product Details
   *@param productId Product SalesforceID
   *@return Product
   */
  @AuraEnabled
  public static Product2 getProductId(String productId) {
    Product2 prod = [
      SELECT Id, ProductCode, IsActive, eid__c, Price_Information__c
      FROM Product2
      WHERE id = :productId
      LIMIT 1
    ];
    return prod;
  }

  /**
   *Method to check whether product is Active or not.
   *@param productId Product SalesforceID
   *@return error message
   */
  @AuraEnabled
  public static String checkProduct(String productId) {
    String errorMessage = 'No Error';
    Product2 prod = [
      SELECT Id, IsActive, Price_Information__c
      FROM Product2
      WHERE id = :productId
      LIMIT 1
    ];
    if (prod.IsActive) {
      return 'Product is not in \'DRAFT\' state and can not be activated.';
    } else if (
      prod.Price_Information__c == null ||
      prod.Price_Information__c == ''
    ) {
      return 'Product does not have a product price and can not be activated.';
    }
    return errorMessage;
  }

  /**
   *Method to Activate Product.
   *@param productId Product SalesforceID
   *@return error message
   */
  @AuraEnabled
  public static String activateProduct(String productId) {
    String error = 'NoError';
    Product2 prod = [
      SELECT Id, eid__c, IsActive, Price_Information__c
      FROM Product2
      WHERE id = :productId
      LIMIT 1
    ];
    try {
      APIDataService dataService = GTVDataService.getService();
      dataService.makeProductAvailable(prod.eid__c);
    } catch (Exception e) {
      if (e.getmessage().contains('Web service callout failed')) {
        return e.getmessage()
          .substringBetween(
            'Web service callout failed: WebService returned a SOAP Fault:',
            ' faultcode=soap:Server faultactor='
          );
      } else if (e.getmessage().contains('Validation error')) {
        return e.getmessage().substringAfter('Validation error:');
      } else {
        return e.getmessage();
      }
    }
    prod.IsActive = true;
    update prod;
    return error;
  }

  /**
   *Method to get product price list of one time products.
   *@param productId Product SalesforceID
   *@return oneTimeproductPriceList
   */
  @AuraEnabled
  public static List<ProductPriceWrapper> getOneTimeProductPrices(
    String productId
  ) {
    list<ProductPriceWrapper> oneTimeproductPriceList = new List<ProductPriceWrapper>();
    Product2 prod = [
      SELECT Id, Price_Information__c
      FROM Product2
      WHERE id = :productId
    ];
    for (
      ProductPriceWrapper productPriceWrapObj : (list<ProductPriceWrapper>) JSON.deserialize(
        prod.Price_Information__c,
        list<ProductPriceWrapper>.class
      )
    ) {
      if (
        productPriceWrapObj.priceType == 'OneTime' ||
        productPriceWrapObj.priceType == 'one-time'
      ) {
        oneTimeproductPriceList.add(productPriceWrapObj);
      }
    }
    return oneTimeproductPriceList;
  }

  /**
   *Method to get product price list of Recurring products.
   *@param productId Product SalesforceID
   *@return recurringproductPriceList
   */
  @AuraEnabled
  public static List<ProductPriceWrapper> getRecurringProductPrices(
    String productId
  ) {
    list<ProductPriceWrapper> recurringproductPriceList = new List<ProductPriceWrapper>();
    Product2 prod = [
      SELECT Id, Price_Information__c, eid__c
      FROM Product2
      WHERE id = :productId
    ];
    for (
      ProductPriceWrapper productPriceWrapObj : (list<ProductPriceWrapper>) JSON.deserialize(
        prod.Price_Information__c,
        list<ProductPriceWrapper>.class
      )
    ) {
      if (productPriceWrapObj.priceType == 'Recurring') {
        productPriceWrapObj.productEid = prod.TRACT3__eid__c;
        recurringproductPriceList.add(productPriceWrapObj);
      }
    }
    return recurringproductPriceList;
  }

  /**
   *Method to get the list of Agreements on Product.
   *@param productId Product SalesforceID
   *@return agreementList
   */
  @AuraEnabled
  public static List<ProductAgreementWrapper> getAgreements(String productId) {
    List<ProductAgreementWrapper> agreementList = new List<ProductAgreementWrapper>();
    if (productId != null) {
      product2 prod = [
        SELECT name, id, eid__c, Requires_Agreement__c, Agreement_Information__c
        FROM product2
        WHERE id = :productId
      ];
      agreementList = (List<ProductAgreementWrapper>) JSON.deserialize(
        prod.Agreement_Information__c,
        List<ProductAgreementWrapper>.class
      );
    }
    return agreementList;
  }

  /**
   *Method to get the list of Discount Codes on Product.
   *@param productId Product SalesforceID
   *@return discountCodeList
   */
  @AuraEnabled
  public static list<DiscountCodeWrapper> getDiscountCode(String productId) {
    Product2 product = new Product2();
    product = [SELECT id, name, eid__c FROM Product2 WHERE id = :productId];
    list<DiscountCodeWrapper> discountCodeList = new List<DiscountCodeWrapper>();
    APIDataService dataService = GTVDataService.getService();
    discountCodeList = dataService.getDiscountCodesByProduct(product.eid__c);
    return discountCodeList;
  }

  /**
   *Method to get the list of All Agreements.
   *@return agreementList
   */
  @AuraEnabled
  public static List<ProductAgreementWrapper> getAllProductAgreements() {
    List<ProductAgreementWrapper> agreementList = new List<ProductAgreementWrapper>();
    APIDataService dataService = GTVDataService.getService();
    agreementList = dataService.getAllAgreements();
    return agreementList;
  }

  /**
   *Method to map agreements with product.
   *@param productId Product SalesforceID
   *@param agreementWrapper
   *@return error message
   */
  @AuraEnabled
  public static String setAgreements(
    String agreementWrapper,
    String productId
  ) {
    List<ProductAgreementWrapper> agreementList = (list<ProductAgreementWrapper>) JSON.deserialize(
      agreementWrapper,
      list<ProductAgreementWrapper>.class
    );
    list<Product2> product = new List<Product2>();
    product = [
      SELECT id, name, eid__c, Agreement_Information__c
      FROM Product2
      WHERE id = :productId
      LIMIT 1
    ];
    try {
      APIDataService dataService = GTVDataService.getService();
      dataService.setProductAgreement(agreementList, product[0].eid__c);
      list<Product2> productList = new List<Product2>();
      productList = dataService.getGTVAgreeements(product);
      update productList;
    } catch (Exception e) {
      if (e.getmessage().contains('Web service callout failed')) {
        return e.getmessage()
          .substringBetween(
            'Web service callout failed: WebService returned a SOAP Fault:',
            ' faultcode=soap:Server faultactor='
          );
      } else {
        if (e.getmessage().contains('Validation error')) {
          return e.getmessage().substringAfter('Validation error:');
        }
      }
    }
    return 'NoError';
  }

  /**
   *Method to remove product agreement relation.
   *@param productId Product SalesforceID
   *@param currentAgreement
   *@return error message
   */
  @AuraEnabled
  public static String deleteProductAgreementRelation(
    String productId,
    String currentAgreement
  ) {
    system.debug('currentAgreement:::' + currentAgreement);
    list<Product2> product = new List<Product2>();
    product = [
      SELECT id, name, eid__c, Agreement_Information__c
      FROM Product2
      WHERE id = :productId
      LIMIT 1
    ];
    ProductAgreementWrapper agreementWrap = (ProductAgreementWrapper) JSON.deserialize(
      currentAgreement,
      ProductAgreementWrapper.class
    );
    try {
      APIDataService dataService = GTVDataService.getService();
      dataService.removeAgreementRelation(product[0].eid__c, agreementWrap);
      list<Product2> productList = new List<Product2>();
      productList = dataService.getGTVAgreeements(product);
      update productList;
    } catch (Exception e) {
      if (e.getmessage().contains('Web service callout failed')) {
        return e.getmessage()
          .substringBetween(
            'Web service callout failed: WebService returned a SOAP Fault:',
            ' faultcode=soap:Server faultactor='
          );
      } else {
        if (e.getmessage().contains('Validation error')) {
          return e.getmessage().substringAfter('Validation error:');
        }
      }
    }
    return 'NoError';
  }

  /**
   *Method to get product Custom Fields List.
   *@param productId Product SalesforceID
   *@return ProductCustomFieldList
   */
  @AuraEnabled
  public static List<ProductCustomFieldWrapper> getproductCustomFieldsList(
    String productId
  ) {
    List<ProductCustomFieldWrapper> productCustomFieldList = new List<ProductCustomFieldWrapper>();
    APIDataService dataService = GTVDataService.getService();
    productCustomFieldList = dataService.queryProductCustomFields(productId);
    return ProductCustomFieldList;
  }

  /**
   *Method to get product Custom Field value List.
   *@param ProductEid
   *@return productCustomFieldValueList
   */
  @AuraEnabled
  public static List<productCustomFieldValueWrapper> getproductCustomFieldValueList(
    String productEid
  ) {
    List<productCustomFieldValueWrapper> productCustomFieldValueList = new List<productCustomFieldValueWrapper>();
    APIDataService dataService = GTVDataService.getService();
    productCustomFieldValueList = dataService.queryProductCustomFieldValues(
      productEid
    );
    return productCustomFieldValueList;
  }

  /**
   *Method to save product Custom Field values.
   *@param ProductEid
   *@param customFildWrapper
   *@return error message
   */
  @AuraEnabled
  public static String saveProductCustomFieldValues(
    String productEid,
    String customFildWrapper
  ) {
    String emessage;
    APIDataService dataService = GTVDataService.getService();
    emessage = dataService.saveProductCustomFieldValues(
      productEid,
      customFildWrapper
    );
    return emessage;
  }

  /**
   *Method to get list of Product relation.
   *@param productId Product SalesforceID
   *@return productRelationList
   */
  @AuraEnabled
  public static List<ProductRelationWrapper> queryProductRelationList(
    String productId
  ) {
    List<ProductRelationWrapper> productRelationList = new List<ProductRelationWrapper>();
    APIDataService dataService = GTVDataService.getService();
    productRelationList = dataService.queryProductRelation(productId);
    return productRelationList;
  }

  /**
   *Method to remove Product relations.
   *@param productId Product SalesforceID
   *@param productRelation
   *@return productRelationList
   */
  @AuraEnabled
  public static String deleteProductRelations(
    String productRelation,
    String productId
  ) {
    system.debug('productRelation:::' + productRelation);
    ProductRelationWrapper relationWrap = (ProductRelationWrapper) JSON.deserialize(
      productRelation,
      ProductRelationWrapper.class
    );
    try {
      APIDataService dataService = GTVDataService.getService();
      dataService.removeProductRelation(productId, relationWrap);
    } catch (Exception e) {
      if (e.getmessage().contains('Web service callout failed')) {
        return e.getmessage()
          .substringBetween(
            'Web service callout failed: WebService returned a SOAP Fault:',
            ' faultcode=soap:Server faultactor='
          );
      } else {
        if (e.getmessage().contains('Validation error')) {
          return e.getmessage().substringAfter('Validation error:');
        }
      }
    }
    return 'NoError';
  }

  @AuraEnabled
  public static list<ProductUsesWrapper> queryProductUsageChargeRule(
    String productId,
    String recurringPriceId
  ) {
    system.debug('recurringPriceId:::' + recurringPriceId);
    list<ProductUsesWrapper> usgaeWrapList = new List<ProductUsesWrapper>();
    APIDataService dataService = GTVDataService.getService();
    usgaeWrapList = dataService.getProductChargeRules(
      productId,
      recurringPriceId
    );
    return usgaeWrapList;
  }
  @AuraEnabled
  public static ProductChargeRuleWrapper showChargeRuleModel() {
    TRACT_Setup__c tract = [
      SELECT
        id,
        TPassword__c,
        Tract_User_Name__c,
        TRACT_URL__c,
        Active__c,
        Api_Version__c,
        TRACT_URL2_0__c
      FROM TRACT_Setup__c
      WHERE Active__c = TRUE
      LIMIT 1
    ];

    ProductChargeRuleWrapper chargeRules = new ProductChargeRuleWrapper();
    chargeRules.selectStatusListValue = 'Draft';
    chargeRules.selectStatusListValue = 'Active';
    chargeRules.productUsageRuleListValue = 'Match All Events';
    chargeRules.rateTypeListValue = 'Flat';
    chargeRules.chargesPicklistValue = ' ';
    chargeRules.allowanceTypeListValue = 'Recurring';
    chargeRules.roleOverListValue = 'None';
    chargeRules.formulaFieldValue = ' ';
    chargeRules.operationListValue = ' ';
    chargeRules.passThroughChargeListValue = ' ';
    chargeRules.formulaUsageRuleListValue = ' ';
    chargeRules.chargeListBytesValue = ' ';
    if (tract.Api_Version__c == 'API Version 2.0') {
      chargeRules.productUsageRuleList = chargeRules.productUsageRuleListAPI2;
      chargeRules.operationList = chargeRules.operationListAPI2;
    } else {
      chargeRules.productUsageRuleList = chargeRules.productUsageRuleList1;
      chargeRules.operationList = chargeRules.operationList1;
    }
    chargeRules.chargeCategoryListValue = ' ';
    chargeRules.productUsageRuleName = ' ';
    chargeRules.chargeCategoryList = getchargeCategoryListMethod();
    chargeRules.chargeListBytes = getchargeListBytesMethod();
    chargeRules.formulaUsageRuleList = getFormulaUsageRuleSpecificationListMethod();
    chargeRules.chargeValue = 0;
    chargeRules.ammountValue = 0;
    chargeRules.ActivityFormulaValue = ' ';
    chargeRules.prorateOnOrder = false;
    chargeRules.prorateOnCancel = false;
    system.debug('chargeRules::::' + chargeRules);
    return chargeRules;
  }

  @AuraEnabled
  public static String addChargerules(
    String productEid,
    String recurringPriceId,
    String chargeRuleWrapper
  ) {
    system.debug('chargeRuleWrapper:::' + chargeRuleWrapper);
    ProductChargeRuleWrapper chargeRuleWrap = (ProductChargeRuleWrapper) JSON.deserialize(
      chargeRuleWrapper,
      ProductChargeRuleWrapper.class
    );
    try {
      APIDataService dataService = GTVDataService.getService();
      dataService.createChargeRules(
        productEid,
        recurringPriceId,
        chargeRuleWrap
      );
    } catch (Exception e) {
      if (e.getmessage().contains('Web service callout failed')) {
        return e.getmessage().substringAfter('Web service callout failed: ');
      } else {
        if (e.getmessage().contains('Validation error')) {
          return e.getmessage().substringAfter('Validation error:');
        } else {
          return e.getmessage();
        }
      }
    }
    return 'NoError';
  }

  private static list<selectOption> getchargeCategoryListMethod() {
    list<SelectOption> chargeCategoryList = new List<SelectOption>();
    APIDataService dataService = GTVDataService.getService();
    chargeCategoryList = (list<SelectOption>) dataService.getAllChargeCategory();
    return chargeCategoryList;
  }

  /*
   * @return  List<SelectOption>, map Charge Lists
   * @description - This method is used to get the Charge List
   **/
  public static list<SelectOption> getchargeListBytesMethod() {
    list<SelectOption> chargeListBytes = new List<SelectOption>();
    APIDataService dataService = GTVDataService.getService();
    chargeListBytes = dataService.getchargeListBytesMethod();

    return chargeListBytes;
  }

  /*
   * @return  List<SelectOption>, map Formula UsageRule Specification List
   * @description - This method is used to get the Formula UsageRule Specification List
   **/
  public static list<SelectOption> getFormulaUsageRuleSpecificationListMethod() {
    list<SelectOption> FormulaUsageRuleSpecificationList = new List<SelectOption>();
    APIDataService dataService = GTVDataService.getService();
    FormulaUsageRuleSpecificationList = dataService.getFormulaUsageRuleSpecificationListMethod();
    return FormulaUsageRuleSpecificationList;
  }
}