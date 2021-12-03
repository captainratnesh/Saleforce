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
 * This class is used to call the API request to create the one time prices on a product from Salesforce to GTV.
 * @author AMAN JAIN
 */

public with sharing class CreateOneTimeChargePriceController {
  /**************************************************************************
   * @description This Method returns the wrapper containing one time charge price details.
   * @param productId Id of the product
   * @return CreateOneTimeChargePriceWrapper.
   */
  @AuraEnabled
  public static CreateOneTimeChargePriceWrapper getCreateOneTimeChargePriceWrapper(
    String productId
  ) {
    CreateOneTimeChargePriceWrapper createOneTimeChargePriceWrapper = new CreateOneTimeChargePriceWrapper();
    Product2 pro = [
      SELECT Id, name, eid__c
      FROM Product2
      WHERE Id = :productId
      LIMIT 1
    ];
    createOneTimeChargePriceWrapper.productId = pro.eid__c;
    createOneTimeChargePriceWrapper.sfdcProductId = productId;
    APIDataService dataService = GTVDataService.getService();
    /* Setting up the list of Product Category*/
    createOneTimeChargePriceWrapper.priceCategoryList = dataService.queryPriceCategories();
    /* Setting up the list of Currencies */
    createOneTimeChargePriceWrapper.currencyList = dataService.getCurrencyType();
    /* Setting up the list of product price group */
    createOneTimeChargePriceWrapper.productPriceGroupList = dataService.getProductPriceGroup();
    return createOneTimeChargePriceWrapper;
  }
  /**************************************************************************
   * @description This Method returns the wrapper containing price range.
   *
   * @return createPriceRangeWrapper.
   */
  @AuraEnabled
  public static CreatePriceRangeWrapper getCreatePriceRangeWrapper() {
    CreatePriceRangeWrapper createPriceRangeWrapper = new CreatePriceRangeWrapper();
    return createPriceRangeWrapper;
  }
  /**************************************************************************
   * @description This Method is used to create one time product price.
   * @param createProductPriceWrapperString CreateOneTimeChargePriceWrapper wrapper in JSON format.
   * @return Emessage.
   */
  @AuraEnabled
  public static String createOneTimeProductPrice(
    String createProductPriceWrapperString,
    String priceListId
  ) {
    String emessage = '';
    CreateOneTimeChargePriceWrapper createOneTimeProductPriceWrapper = (CreateOneTimeChargePriceWrapper) JSON.deserialize(
      createProductPriceWrapperString,
      CreateOneTimeChargePriceWrapper.class
    );
    APIDataService dataService = GTVDataService.getService();
    emessage = dataService.createGtvOneTimeProductPrice(
      createOneTimeProductPriceWrapper,
      priceListId
    );
    return emessage;
  }
}