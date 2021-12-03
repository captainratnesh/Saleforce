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
 * This class is used to call the API request to create a product from Salesforce to GTV.
 * @author AMAN JAIN
 */

public class CreateProductController {
  /**
   * @params productId Id of the currrent Product
   * @return CreateProductWrapper details of the product
   *@description - creating a wrapper CreateProductWrapper and mapping the current product entities
   */
  @AuraEnabled
  public static CreateProductWrapper getCreateProductWrapper(String productId) {
    CreateProductWrapper createProductWrapper = new CreateProductWrapper();
    createProductWrapper.sfdcProductId = productId;
    APIDataService dataService = GTVDataService.getService();
    /* Setting up the list of Product Type*/
    Product2 pro = [
      SELECT Id, name, eid__c
      FROM Product2
      WHERE Id = :productId
      LIMIT 1
    ];
    createProductWrapper.eid = pro.eid__c;
    createProductWrapper.productName = pro.name;
    /* Setting up the list of Product Type Code */
    createProductWrapper.productTypeList = dataService.getProductTypeCode();
    /* Setting up the list of Product Category*/
    createProductWrapper.productCategoryList = dataService.queryProductCategories();
    /* Setting up the list of identifier Category*/
    createProductWrapper.identifierCategoryList = dataService.queryServiceResourceCategories();
    /* Setting up the list of Product Tags*/
    createProductWrapper.productTagList = dataService.queryProductTags();
    /* Setting up the list of Product Register Types*/
    createProductWrapper.productRegisterTypeList = dataService.queryProductRegisterTypes();
    /* Setting up the Rule mode*/
    List<SelectOption> ruleModeList = new List<SelectOption>();
    ruleModeList.add(new selectOption('APPEND', 'Append'));
    ruleModeList.add(new selectOption('OVERWRITE', 'Overwrite'));
    ruleModeList.add(new selectOption('SELF', 'Self'));
    createProductWrapper.ruleModeList = ruleModeList;
    /* Setting up the Rule Type*/
    List<SelectOption> ruleTypeList = new List<SelectOption>();
    ruleTypeList.add(new selectOption('TAPERED', 'Taper'));
    ruleTypeList.add(new selectOption('TIERED', 'Tier'));
    createProductWrapper.ruleTypeList = ruleTypeList;
    return createProductWrapper;
  }
  /**
   * @params createProductWrapperString Product Information contained in a JSON string
   * @return String error message if any
   *@description - to create a product in Gotransverse
   */
  @AuraEnabled
  public static String createProduct(String createProductWrapperString) {
    String emessage = '';
    CreateProductWrapper createProductWrapper = (CreateProductWrapper) JSON.deserialize(
      createProductWrapperString,
      CreateProductWrapper.class
    );
    APIDataService dataService = GTVDataService.getService();
    emessage = dataService.createGtvProduct(createProductWrapper);
    return emessage;
  }
}