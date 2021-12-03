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
 * This class is used to call the API request to query and create marketplaces.
 * @author AMAN JAIN
 */

public with sharing class MarketPlaceController {
  /**
   * get API version 1.0 for SOAP and 2.0 for REST
   * @return boolean
   * */
  @AuraEnabled
  public static boolean getApiVersion() {
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
      return true;
    } else {
      return false;
    }
  }
  /**
   * get Available Market Places
   * @return list<MarketPlaceWrapper>
   * */
  @AuraEnabled
  public static list<MarketPlaceWrapper> getAvailableMarketPlaces() {
    list<MarketPlaceWrapper> mwrap = new List<MarketPlaceWrapper>();
    APIDataService dataService = GTVDataService.getService();
    mwrap = dataService.getMarketPlace();
    return mwrap;
  }
  /**
   * get Market Place Price Lists
   * @param marketPlaceWrapString marketplace wrapper in json format
   * @return List<PriceListWrapper>
   * */
  @AuraEnabled
  public static List<PriceListWrapper> getMarketPlacePriceLists(
    String marketPlaceWrapString
  ) {
    List<PriceListWrapper> marketPlacePriceListValueList = new List<PriceListWrapper>();
    MarketPlaceWrapper marketPlaceWrap = (MarketPlaceWrapper) JSON.deserialize(
      marketPlaceWrapString,
      MarketPlaceWrapper.class
    );
    APIDataService dataService = GTVDataService.getService();
    marketPlacePriceListValueList = dataService.getMarketPlacePriceList(
      marketPlaceWrap
    );
    return marketPlacePriceListValueList;
  }
  /**
   * get Product By Price List Eid
   * @param priceListEid tract pricelist id
   * @return list<PriceListProductWrapper>
   * */
  @AuraEnabled
  public static list<PriceListProductWrapper> getProductByPriceListEid(
    String priceListEid
  ) {
    list<PriceListProductWrapper> productWrapList = new List<PriceListProductWrapper>();
    List<product2> productList = [
      SELECT
        id,
        Name,
        isActive,
        ProductCode,
        eid__c,
        PriceLists__c,
        Gotransverse_Product_Category__c
      FROM Product2
      WHERE eid__c != NULL AND isActive = TRUE
    ];
    List<product2> productListInPriceList = new List<product2>();
    for (product2 product : productList) {
      if (product.PriceLists__c != null) {
        for (String priceList : product.PriceLists__c.split(',')) {
          list<String> priceLists = new List<String>();
          priceLists = priceList.split(':');
          if (priceList != null && priceLists.size() > 1) {
            if (priceLists[1] == priceListEid) {
              ProductCategoryWrapper catWrap = (ProductCategoryWrapper) JSON.deserialize(
                product.Gotransverse_Product_Category__c,
                ProductCategoryWrapper.class
              );
              PriceListProductWrapper priceListWrap = new PriceListProductWrapper();
              priceListWrap.productCategoryName = catWrap.Name;
              priceListWrap.productName = product.Name;
              priceListWrap.productEid = product.eid__c;
              priceListWrap.productType = product.ProductCode;
              priceListWrap.sfdcProductId = product.id;
              productWrapList.add(priceListWrap);
            }
          }
        }
      }
    }
    return productWrapList;
  }
  /**
   * get Product List
   * @param priceListEid tract pricelist id
   * @return AvailableAndSelectedProductsWrapper
   * */
  @AuraEnabled
  public static AvailableAndSelectedProductsWrapper getProductsList(
    String priceListEid
  ) {
    AvailableAndSelectedProductsWrapper prodWrapper = new AvailableAndSelectedProductsWrapper();
    list<selectOption> listOfAvailableProducts = new List<selectOption>();
    List<product2> productList = [
      SELECT
        id,
        Name,
        isActive,
        ProductCode,
        eid__c,
        PriceLists__c,
        Gotransverse_Product_Category__c
      FROM Product2
      WHERE eid__c != NULL AND isActive = TRUE
    ];
    for (product2 product : productList) {
      if (product.PriceLists__c != null) {
        if (!product.PriceLists__c.contains(priceListEid)) {
          listOfAvailableProducts.add(
            new selectOption(product.eid__c, product.Name)
          );
        }
      }
    }
    prodWrapper.listOfAvailableProducts = listOfAvailableProducts;
    return prodWrapper;
  }
  /**
   * get Products List To Remove
   * @param priceListEid tract pricelist id
   * @return AvailableAndSelectedProductsWrapper
   * */
  @AuraEnabled
  public static AvailableAndSelectedProductsWrapper getProductsListToRemove(
    String priceListEid
  ) {
    AvailableAndSelectedProductsWrapper prodWrapper = new AvailableAndSelectedProductsWrapper();
    list<selectOption> listOfAvailableProducts = new List<selectOption>();
    List<product2> productList = [
      SELECT
        id,
        Name,
        isActive,
        ProductCode,
        eid__c,
        PriceLists__c,
        Gotransverse_Product_Category__c
      FROM Product2
      WHERE eid__c != NULL AND isActive = TRUE
    ];
    for (product2 product : productList) {
      if (product.PriceLists__c != null) {
        for (String priceList : product.PriceLists__c.split(',')) {
          list<String> priceLists = new List<String>();
          priceLists = priceList.split(':');
          if (priceList != null && priceLists.size() > 1) {
            if (priceList.contains(priceListEid)) {
              listOfAvailableProducts.add(
                new selectOption(product.eid__c, product.Name)
              );
              break;
            }
          }
        }
      }
    }
    prodWrapper.listOfAvailableProducts = listOfAvailableProducts;
    return prodWrapper;
  }
  /**
   * add Product To Price List
   * @param priceListEid tract pricelist id
   * @param addSelectedProducts AvailableAndSelectedProductsWrapper in json format
   * @return error msg
   * */
  @AuraEnabled
  public static String addProductToPriceList(
    String priceListEid,
    String addSelectedProducts
  ) {
    String error = 'NoError';
    AvailableAndSelectedProductsWrapper allProductsWrap = (AvailableAndSelectedProductsWrapper) JSON.deserialize(
      addSelectedProducts,
      AvailableAndSelectedProductsWrapper.class
    );
    try {
      APIDataService dataService = GTVDataService.getService();
      dataService.addProductToPriceList(
        priceListEid,
        allProductsWrap.listOfSelectedProducts
      );
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
        return e.getMessage();
      }
    }
    return error;
  }
  /**
   * remove Product from Price List
   * @param priceListEid tract pricelist id
   * @param removeSelectedProducts AvailableAndSelectedProductsWrapper in json format
   * @return error msg
   * */
  @AuraEnabled
  public static String removeProductFromPriceList(
    String priceListEid,
    String removeSelectedProducts
  ) {
    String error = 'NoError';
    AvailableAndSelectedProductsWrapper allProductsWrap = (AvailableAndSelectedProductsWrapper) JSON.deserialize(
      removeSelectedProducts,
      AvailableAndSelectedProductsWrapper.class
    );
    try {
      APIDataService dataService = GTVDataService.getService();
      dataService.removeProductToPriceList(
        priceListEid,
        allProductsWrap.listOfSelectedProducts
      );
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
        return e.getMessage();
      }
    }
    return error;
  }
  /**
   * delete MarketPlace
   * @param marketPlaceId tract marketplaceid
   * @return error msg
   * */
  @AuraEnabled
  public static String deleteThisMarketPlace(String marketPlaceId) {
    String error = 'NoError';
    try {
      APIDataService dataService = GTVDataService.getService();
      dataService.removeThisMarketPlace(marketPlaceId);
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
        return e.getMessage();
      }
    }
    return error;
  }
  /**
   * get One Time Product Price
   * @param productId tract product id
   * @param priceListEid tract pricelist id
   * @return List<ProductPriceWrapper>
   * */
  @AuraEnabled
  public static List<ProductPriceWrapper> getOneTimeProductPrice(
    String productId,
    String priceListEid
  ) {
    list<ProductPriceWrapper> oneTimeproductPriceList = new List<ProductPriceWrapper>();
    Product2 prod = [
      SELECT Id, eid__c, Price_Information__c
      FROM Product2
      WHERE eid__c = :productId
    ];
    for (
      ProductPriceWrapper productPriceWrapObj : (list<ProductPriceWrapper>) JSON.deserialize(
        prod.Price_Information__c,
        list<ProductPriceWrapper>.class
      )
    ) {
      if (
        (productPriceWrapObj.priceType == 'OneTime' ||
        productPriceWrapObj.priceType == 'one-time') &&
        productPriceWrapObj.priceListEid == priceListEid
      ) {
        oneTimeproductPriceList.add(productPriceWrapObj);
      }
    }
    return oneTimeproductPriceList;
  }
  /**
   * get Recurring Product Price
   * @param productId tract product id
   * @param priceListEid tract pricelist id
   * @return List<ProductPriceWrapper>
   * */
  @AuraEnabled
  public static List<ProductPriceWrapper> getRecurringProductPrice(
    String productId,
    String priceListEid
  ) {
    list<ProductPriceWrapper> recurringproductPriceList = new List<ProductPriceWrapper>();
    Product2 prod = [
      SELECT Id, eid__c, Price_Information__c
      FROM Product2
      WHERE eid__c = :productId
    ];
    for (
      ProductPriceWrapper productPriceWrapObj : (list<ProductPriceWrapper>) JSON.deserialize(
        prod.Price_Information__c,
        list<ProductPriceWrapper>.class
      )
    ) {
      if (
        productPriceWrapObj.priceType == 'Recurring' &&
        productPriceWrapObj.priceListEid == priceListEid
      ) {
        recurringproductPriceList.add(productPriceWrapObj);
      }
    }
    return recurringproductPriceList;
  }
}