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
* This class is the Controller to handle the add product module.
* @author Aman Jain
*/

public class TractOppProduct_LT {
  /**
   * Method to get api version 1.0 for SOAP and 2.0 for REST
   * @return boolean
   */
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
   * Method to get all product list.
   * @param opportunityId salesforce opportunity ID
   * @return GTVProductListWrapper
   */
  @AuraEnabled
  public static GTVProductListWrapper getAllProductList(String opportunityId) {
    String pricebook2Id;
    Set<Id> productIdSet = new Set<Id>();
    GTVProductListWrapper productListWrapper = new GTVProductListWrapper();
    Opportunity opportunity = [
      SELECT
        id,
        Pricebook2Id,
        AccountId,
        Tract_Sales_Order__c,
        Account.Tract_Billing_Account__c,
        Account.Currency_Type__c
      FROM Opportunity
      WHERE id = :opportunityId
      LIMIT 1
    ];
    if (opportunity != null) {
      pricebook2Id = opportunity.Pricebook2Id;
    }
    if (opportunity.Tract_Sales_Order__c != null) {
      productListWrapper.errorMessage = 'OrderCreated';
      return productListWrapper;
    }
    if (
      opportunity.AccountId == null ||
      opportunity.Account.Tract_Billing_Account__c == null
    ) {
      productListWrapper.errorMessage = 'NoBillingAccount';
      return productListWrapper;
    } else if (opportunity.Account.Currency_Type__c == null) {
      productListWrapper.errorMessage = 'NoCurrencyType';
      return productListWrapper;
    }
    for (Pricebook2 pricebook : [SELECT id, Name FROM Pricebook2]) {
      if (pricebook.Name.contains(opportunity.Account.Currency_Type__c)) {
        pricebook2Id = pricebook.Id;
        break;
      }
    }
    if (pricebook2Id == null) {
      productListWrapper.errorMessage = 'NoPriceBook';
      return productListWrapper;
    }
    for (PricebookEntry pbeRecord : [
      SELECT id, name, Pricebook2Id, Product2Id
      FROM PricebookEntry
      WHERE Pricebook2Id = :pricebook2Id
      LIMIT 50000
    ]) {
      productIdSet.add(pbeRecord.Product2Id);
    }

    list<Product2> productList = [
      SELECT
        id,
        name,
        eid__c,
        Requires_Agreement__c,
        Gotransverse_Trail__c,
        Gotransverse_Trail_Days__c,
        Gotransverse_Trial_Length_Override__c,
        description,
        ProductCode,
        Short_Desc__c,
        Serialized__c,
        RuleOverride__c,
        RuleType__c,
        PriceLists__c,
        maxServiceResources__c,
        Agreement_Information__c,
        minServiceResources__c,
        PriceOverride__c,
        Price_Information__c
      FROM Product2
      WHERE
        Id IN :productIdSet
        AND eid__c != NULL
        AND description != 'This Product is No longer available in TRACT'
        AND isActive = TRUE
      ORDER BY Name ASC
    ];
    productListWrapper.productList = productList;
    opportunity.Pricebook2Id = pricebook2Id;
    update opportunity;
    return productListWrapper;
  }
  /**
   * Method to get product details.
   * @param selectedProduct salesforce product object
   * @param opportunityId salesforce opportunity ID
   * @return Product2AddWrapper
   */
  @AuraEnabled
  public static Product2AddWrapper getProductDetails(
    product2 selectedProduct,
    String opportunityId
  ) {
    list<String> pricebookName = new List<String>();
    opportunity opportunity = [
      SELECT id, Pricebook2Id, AccountId
      FROM Opportunity
      WHERE id = :opportunityId
      LIMIT 1
    ];
    string pricebookId = opportunity.Pricebook2Id;
    pricebook2 pricebook = [
      SELECT id, name
      FROM pricebook2
      WHERE ID = :pricebookId
    ];
    if (pricebook != null) {
      pricebookName = pricebook.name.split(' ');
    }
    Product2AddWrapper selectedProductWrapper = new Product2AddWrapper();
    selectedProductWrapper.quantity = 1;
    list<String> priceListEidListForAvailablePrices = new List<String>();
    list<ProductPriceWrapper> listProductPrice = (list<ProductPriceWrapper>) JSON.deserialize(
      selectedProduct.Price_Information__c,
      list<ProductPriceWrapper>.class
    );
    for (ProductPriceWrapper productPriceObj : listProductPrice) {
      if (
        productPriceObj.currencyType == pricebookName[1] &&
        !priceListEidListForAvailablePrices.contains(
          productPriceObj.priceListEid
        )
      ) {
        priceListEidListForAvailablePrices.add(productPriceObj.priceListEid);
      }
    }
    selectedProductWrapper.enabledAgreementConfiguration = (selectedProduct.Requires_Agreement__c ||
    checkEnabledAgreement(
      pricebookName[1],
      selectedProduct.Agreement_Information__c
    ));
    selectedProductWrapper.prod = selectedProduct;
    selectedProductWrapper.productEid = selectedProduct.eid__c;
    selectedProductWrapper.minServiceResource = selectedProduct.minServiceResources__c;
    selectedProductWrapper.maxServiceResource = selectedProduct.maxServiceResources__c;
    selectedProductWrapper.ruleOverride = selectedProduct.RuleOverride__c;
    selectedProductWrapper.productTrial = selectedProduct.Gotransverse_Trail__c;
    selectedProductWrapper.productTrialOverride = selectedProduct.Gotransverse_Trial_Length_Override__c;
    selectedProductWrapper.productTrialDays = selectedProduct.Gotransverse_Trail_Days__c;
    selectedProductWrapper.ruleType = selectedProduct.RuleType__c;
    if (selectedProduct.PriceLists__c != null) {
      selectedProductWrapper.productPriceList = getPriceListInformation(
        selectedProduct,
        priceListEidListForAvailablePrices
      );
      if (
        selectedProductWrapper.productPriceList != null &&
        selectedProductWrapper.productPriceList.size() > 0
      ) {
        selectedProductWrapper.priceListValue = selectedProductWrapper.productPriceList[0]
          .getValue();
        selectedProductWrapper.priceListName = selectedProductWrapper.productPriceList[0]
          .getlabel();
      }
    }
    selectedProductWrapper.pricebookNames = pricebookName;
    String proWrapper = JSON.serialize(selectedProductWrapper);
    selectedProductWrapper = getProductPricesInformation(proWrapper);
    list<Tract_Service_Custom_Field__c> listOfServiceFieldsWrapperList = getServiceFieldList(
      selectedProductWrapper.productEid
    );
    system.debug(
      'listOfServiceFieldsWrapperList::::' +
      listOfServiceFieldsWrapperList.size()
    );
    if (listOfServiceFieldsWrapperList.size() > 0) {
      selectedProductWrapper.hasServiceCustomFields = true;
    }
    return SelectedProductWrapper;
  }

  private static list<selectOption> getPriceListInformation(
    product2 product,
    list<String> priceListEidListForAvailablePrices
  ) {
    List<SelectOption> availablePriceListOnproduct = new List<SelectOption>();
    for (String priceList : product.PriceLists__c.split(',')) {
      list<String> splittedPriceListInformation = new List<String>();
      splittedPriceListInformation = priceList.split(':');
      if (
        splittedPriceListInformation != null &&
        splittedPriceListInformation.size() > 1 &&
        priceListEidListForAvailablePrices.contains(
          splittedPriceListInformation[1]
        )
      ) {
        availablePriceListOnproduct.add(
          new SelectOption(
            splittedPriceListInformation[1],
            splittedPriceListInformation[0]
          )
        );
      }
    }
    return availablePriceListOnproduct;
  }
  /**
   * Method to get product price information.
   * @param productWrapperString Product2AddWrapper in jason format
   * @return Product2AddWrapper
   */
  @AuraEnabled
  public static Product2AddWrapper getProductPricesInformation(
    String productWrapperString
  ) {
    Product2AddWrapper productWrapper = (Product2AddWrapper) JSON.deserialize(
      productWrapperString,
      Product2AddWrapper.class
    );
    String currentPriceListEid = productWrapper.priceListValue;
    if (currentPriceListEid != '' && currentPriceListEid != null) {
      productWrapper.oneTimePrice = null;
      productWrapper.disableonetime = false;
      productWrapper.oneTimeChargeEnable = false;
      productWrapper.oneTimePerValue = null;
      list<ProductPriceWrapper> listOfProductPrices = (list<ProductPriceWrapper>) JSON.deserialize(
        productWrapper.prod.Price_Information__c,
        list<ProductPriceWrapper>.class
      );
      List<SelectOption> listofProductPriceEidVsRecurrencePeriod = new List<SelectOption>();
      Map<String, boolean> mapofProductPriceEidVsPriceOverrideFlag = new Map<String, boolean>();
      Map<String, list<ProductPriceRangeWrapper>> mapOfProductPriceEidVsPriceRangeList = new Map<String, list<ProductPriceRangeWrapper>>();
      for (ProductPriceWrapper productPriceObj : listOfProductPrices) {
        if (
          productPriceObj.priceListEid == currentPriceListEid &&
          productPriceObj.priceType == 'Recurring' &&
          productPriceObj.currencyType == productWrapper.pricebookNames[1]
        ) {
          if (productPriceObj.thruDate != null) {
            Date myDate = date.newinstance(
              productPriceObj.thruDate.year(),
              productPriceObj.thruDate.month(),
              productPriceObj.thruDate.day()
            );
            if (myDate > Date.Today()) {
              listofProductPriceEidVsRecurrencePeriod.add(
                new SelectOption(
                  productPriceObj.eid,
                  productPriceObj.recurrencePeriod
                )
              );
            }
          } else if (productPriceObj.thruDate == null) {
            listofProductPriceEidVsRecurrencePeriod.add(
              new SelectOption(
                productPriceObj.eid,
                productPriceObj.recurrencePeriod
              )
            );
          } else {
            listofProductPriceEidVsRecurrencePeriod.add(
              new SelectOption('', 'No Rec Period')
            );
          }
          mapofProductPriceEidVsPriceOverrideFlag.put(
            productPriceObj.eid,
            productPriceObj.priceOverride
          );
          mapOfProductPriceEidVsPriceRangeList.put(
            productPriceObj.eid,
            new List<ProductPriceRangeWrapper>()
          );
          for (
            ProductPriceRangeWrapper productPriceRangeObj : productPriceObj.priceRangesList
          ) {
            if (productPriceRangeObj.quantityBeginRange == 0.00) {
              productWrapper.recurringprice = productPriceRangeObj.price;
            }
            mapOfProductPriceEidVsPriceRangeList.get(productPriceObj.eid)
              .add(productPriceRangeObj);
          }
          productWrapper.recurrencPerValue = productPriceObj.eid;
        }
        if (
          productPriceObj.priceListEid == currentPriceListEid &&
          (productPriceObj.priceType == 'OneTime' ||
          productPriceObj.priceType == 'one-time') &&
          productPriceObj.currencyType == productWrapper.pricebookNames[1]
        ) {
          productWrapper.disableonetime = productPriceObj.priceOverride;
          productWrapper.oneTimeChargeEnable = productPriceObj.scheduledCharges;
          productWrapper.oneTimePerValue = productPriceObj.eid;
          mapOfProductPriceEidVsPriceRangeList.put(
            productPriceObj.eid,
            new List<ProductPriceRangeWrapper>()
          );
          for (
            ProductPriceRangeWrapper productPriceRangeObj : productPriceObj.priceRangesList
          ) {
            if (productPriceRangeObj.quantityBeginRange == 0.00) {
              productWrapper.oneTimePrice = productPriceRangeObj.price;
            }
            mapOfProductPriceEidVsPriceRangeList.get(productPriceObj.eid)
              .add(productPriceRangeObj);
          }
        }
      }
      productWrapper.recurrenceoptList = listofProductPriceEidVsRecurrencePeriod;
      productWrapper.priceVsPriceRanges = mapOfProductPriceEidVsPriceRangeList;
      productWrapper.mapofProductPriceEidVsPriceOverrideFlag = mapofProductPriceEidVsPriceOverrideFlag;
      if (!listofProductPriceEidVsRecurrencePeriod.isEmpty()) {
        productWrapper.recurringprice = productWrapper.priceVsPriceRanges.get(
            listofProductPriceEidVsRecurrencePeriod[0].getValue()
          )[0]
          .price;
        productWrapper.recurrencPerValue = listofProductPriceEidVsRecurrencePeriod[0]
          .getValue();
        productWrapper.disableRecurring = mapofProductPriceEidVsPriceOverrideFlag.get(
          productWrapper.recurrencPerValue
        );
      }
      if (
        productWrapper.recurringprice != null &&
        productWrapper.oneTimePrice != null
      ) {
        productWrapper.unitPrice =
          productWrapper.oneTimePrice + productWrapper.recurringprice;
        productWrapper.totelPrice =
          productWrapper.unitPrice * productWrapper.quantity;
      } else if (
        productWrapper.recurringprice == null &&
        productWrapper.oneTimePrice != null
      ) {
        productWrapper.unitPrice = productWrapper.oneTimePrice;
        productWrapper.totelPrice =
          productWrapper.unitPrice * productWrapper.quantity;
      } else if (
        productWrapper.recurringprice != null &&
        productWrapper.oneTimePrice == null
      ) {
        productWrapper.unitPrice = productWrapper.recurringprice;
        productWrapper.totelPrice =
          productWrapper.unitPrice * productWrapper.quantity;
      }
    }
    return productWrapper;
  }
  /**
   * Method to get Existing Oli Product.
   * @param opportunityId salesforce opportunity ID
   * @return List<Product2AddWrapper>
   */
  @AuraEnabled
  public static List<Product2AddWrapper> getExistingOliProduct(
    String opportunityId
  ) {
    system.debug('opportunityId:::::' + opportunityId);
    list<Product2AddWrapper> existingOliWrapperList = new List<Product2AddWrapper>();
    Set<Id> productIdSet = new Set<Id>();
    Set<Id> oliIdSet = new Set<Id>();
    Map<Id, Product2> mapOfIdVsProduct = new Map<Id, Product2>();
    List<String> pricebookNames = new List<String>();
    Map<Id, Service_Custom_Field__c> mapOfIdVsServieCustomField = new Map<Id, Service_Custom_Field__c>();
    Map<Id, list<Schdeule_Charge__c>> mapOfOliIdVsScheduleChargesList = new Map<Id, list<Schdeule_Charge__c>>();
    Map<String, Price_List__c> mapOfIdVsPriceList = new Map<String, Price_List__c>();
    Opportunity opp = [
      SELECT Id, Name, Pricebook2Id
      FROM Opportunity
      WHERE Id = :opportunityId
      LIMIT 1
    ];

    PriceBook2 priceBook = [
      SELECT Id, Name
      FROM PriceBook2
      WHERE Id = :opp.Pricebook2Id
      LIMIT 1
    ];
    for (String pName : priceBook.Name.split(' ')) {
      pricebookNames.add(pName);
    }
    OpportunityLineItem[] existingOliList = [
      SELECT
        id,
        Product2Id,
        eid__c,
        Price_Override__c,
        GTV_OneTime_Price_Range_Information__c,
        GTV_Recurring_Price_Range_Information__c,
        Description,
        Discount_eid__c,
        Discount__c,
        overrideAgreementEndDate__c,
        Agreement_Period__c,
        agreementEndAction__c,
        Applied_Agreement_Eid__c,
        Gotransverse_Next_Agreement_Eid__c,
        Gotransverse_NextAgreementEndAction__c,
        productEid__c,
        quantity,
        unitPrice,
        Service_Resource__c,
        minServiceResources__c,
        New_Service_Resource__c,
        GTV_Next_Renewal_Price__c,
        Service_Resource_Eid__c,
        Tract_Service_Resource_Name__c,
        GTV_Renewal_Price__c,
        RecurringPrice__c,
        Service__c,
        ParentServiceEid__c,
        RecurringProductPriceEid__c,
        OneTimeProductPriceEid__c,
        OneTimePrice__c,
        priceList_Eid__c,
        PricebookEntryId
      FROM OpportunityLineItem
      WHERE opportunityId = :opportunityId
      LIMIT 50000
    ];

    if (existingOliList.size() > 0) {
      for (OpportunityLineItem exisitngOLI : existingOliList) {
        productIdSet.add(exisitngOLI.Product2Id);
        oliIdSet.add(exisitngOLI.id);
      }
      list<Product2> productList = [
        SELECT
          id,
          name,
          eid__c,
          Gotransverse_Trail__c,
          Gotransverse_Trail_Days__c,
          Gotransverse_Trial_Length_Override__c,
          description,
          ProductCode,
          Short_Desc__c,
          Serialized__c,
          RuleOverride__c,
          RuleType__c,
          PriceLists__c,
          Agreement_Information__c,
          Requires_Agreement__c,
          maxServiceResources__c,
          minServiceResources__c,
          PriceOverride__c,
          Price_Information__c
        FROM Product2
        WHERE Id IN :productIdSet AND eid__c != NULL
      ];
      for (Product2 prod : productList) {
        mapOfIdVsProduct.put(prod.Id, prod);
      }
      list<Service_Custom_Field__c> serviceFields = [
        SELECT id, Name, value__c, eid__c, ProductId__c
        FROM Service_Custom_Field__c
        WHERE ProductId__c IN :oliIdSet
      ];
      if (!serviceFields.isEmpty()) {
        for (Service_Custom_Field__c serv : serviceFields) {
          mapOfIdVsServieCustomField.put(serv.id, serv);
        }
      }
      list<Schdeule_Charge__c> charge = [
        SELECT
          id,
          ProductId__c,
          Schdeule_Date__c,
          Schdeule_Description__c,
          productEid__c,
          Schdeule_Amount__c
        FROM Schdeule_Charge__c
        WHERE ProductId__c IN :oliIdSet
        LIMIT 50000
      ];
      if (!charge.isEmpty()) {
        for (Schdeule_Charge__c sche : charge) {
          if (mapOfOliIdVsScheduleChargesList.containsKey(sche.ProductId__c)) {
            mapOfOliIdVsScheduleChargesList.get(sche.ProductId__c).add(sche);
          } else {
            mapOfOliIdVsScheduleChargesList.put(
              sche.ProductId__c,
              new List<Schdeule_Charge__c>()
            );
            mapOfOliIdVsScheduleChargesList.get(sche.ProductId__c).add(sche);
          }
        }
      }
      list<Price_List__c> priceList = [
        SELECT Id, name, eid__c
        FROM Price_List__c
      ];
      if (!priceList.isEmpty()) {
        for (Price_List__c plist : priceList) {
          mapOfIdVsPriceList.put(plist.eid__c, plist);
        }
      }
      for (OpportunityLineItem exisitngOLI : existingOliList) {
        Product2AddWrapper existingOliWrapper = new Product2AddWrapper();
        existingOliWrapper.pricebookNames = pricebookNames;
        existingOliWrapper.oLineItem = exisitngOLI;
        existingOliWrapper.discountEid = exisitngOLI.Discount_eid__c;
        existingOliWrapper.discountName = exisitngOLI.Discount__c;
        existingOliWrapper.prod = mapOfIdVsProduct.get(exisitngOLI.Product2Id);
        existingOliWrapper.service = exisitngOLI.TRACT3__Service__c;
        if (
          existingOliWrapper.service != '' &&
          existingOliWrapper.service != null
        ) {
          existingOliWrapper.serviceName = mapOfIdVsProduct.get(
              exisitngOLI.TRACT3__Service__c
            )
            .Name;
        }
        existingOliWrapper.parentServiceEId = exisitngOLI.ParentServiceEid__c !=
          null
          ? exisitngOLI.ParentServiceEid__c
          : ' ';
        existingOliWrapper.productEid = String.valueOf(
          exisitngOLI.productEid__c
        );
        existingOliWrapper.quantity = Integer.valueOf(exisitngOLI.quantity);
        existingOliWrapper.priceOverridden = exisitngOLI.Price_Override__c;
        existingOliWrapper.priceListValue = exisitngOLI.priceList_Eid__c;
        existingOliWrapper.minServiceResource = existingOliWrapper.prod.minServiceResources__c;
        existingOliWrapper.maxServiceResource = existingOliWrapper.prod.maxServiceResources__c;
        existingOliWrapper.ruleOverride = existingOliWrapper.prod.RuleOverride__c;
        existingOliWrapper.productTrial = existingOliWrapper.prod.Gotransverse_Trail__c;
        existingOliWrapper.productTrialOverride = existingOliWrapper.prod.Gotransverse_Trial_Length_Override__c;
        existingOliWrapper.productTrialDays = existingOliWrapper.prod.Gotransverse_Trail_Days__c;
        existingOliWrapper.ruleType = existingOliWrapper.prod.RuleType__c;

        if (existingOliWrapper.priceListValue != null) {
          existingOliWrapper.priceListName = (mapOfIdVsPriceList.get(
              existingOliWrapper.priceListValue
            ))
            .name;
        }
        existingOliWrapper.enabledAgreementConfiguration = (existingOliWrapper.prod.Requires_Agreement__c ||
        checkEnabledAgreement(
          pricebookNames[1],
          existingOliWrapper.prod.Agreement_Information__c
        ));
        existingOliWrapper.oliId = exisitngOLI.Id;
        existingOliWrapper.recurrencPerValue = exisitngOLI.RecurringProductPriceEid__c;
        existingOliWrapper.OneTimePerValue = exisitngOLI.OneTimeProductPriceEid__c;
        existingOliWrapper = getOLIProductPricesInformation(
          JSON.serialize(existingOliWrapper),
          exisitngOLI
        );
        existingOliWrapper.unitPrice = exisitngOLI.UnitPrice;
        existingOliWrapper.totelPrice =
          existingOliWrapper.unitPrice * existingOliWrapper.quantity;
        if (exisitngOLI.New_Service_Resource__c != null) {
          existingOliWrapper.newServiceResource = exisitngOLI.New_Service_Resource__c;
        }
        if (
          exisitngOLI.Service_Resource_Eid__c != null &&
          exisitngOLI.Tract_Service_Resource_Name__c != null
        ) {
          existingOliWrapper.serviceResourceEid = exisitngOLI.Service_Resource_Eid__c;
          existingOliWrapper.serviceResourceName = exisitngOLI.Tract_Service_Resource_Name__c;
        }
        if (exisitngOLI.Applied_Agreement_Eid__c != null) {
          existingOliWrapper.agreementId = exisitngOLI.Applied_Agreement_Eid__c;
          existingOliWrapper.agreementPeriod = exisitngOLI.Agreement_Period__c;
          existingOliWrapper.agreementEndAction = exisitngOLI.agreementEndAction__c;
          existingOliWrapper.overrideAgreementEndDate = exisitngOLI.overrideAgreementEndDate__c;
          existingOliWrapper.nextAgreementId = exisitngOLI.Gotransverse_Next_Agreement_Eid__c;
          existingOliWrapper.nextAgreementEndAction = exisitngOLI.Gotransverse_NextAgreementEndAction__c;
          existingOliWrapper.renewalPrice = exisitngOLI.GTV_Renewal_Price__c;
          existingOliWrapper.nextRenewalPrice = exisitngOLI.GTV_Next_Renewal_Price__c;
          list<ProductAgreementWrapper> agreementWrapList = (list<ProductAgreementWrapper>) JSON.deserialize(
            (mapOfIdVsProduct.get(exisitngOLI.Product2Id))
              .Agreement_Information__c,
            list<ProductAgreementWrapper>.class
          );
          for (ProductAgreementWrapper agreWrap : agreementWrapList) {
            if (agreWrap.eid == exisitngOLI.Applied_Agreement_Eid__c) {
              existingOliWrapper.agreementName = agreWrap.Name;
              existingOliWrapper.agreementPeriodType = agreWrap.agreementPeriodType;
            }
            if (
              agreWrap.eid == exisitngOLI.Gotransverse_Next_Agreement_Eid__c
            ) {
              existingOliWrapper.nextAgreementName = agreWrap.Name;
            }
          }
        }
        if (!(mapOfIdVsServieCustomField.values().isEmpty())) {
          existingOliWrapper.serviceCustomFieldValueList = new List<ServiceCustomFieldValuesWrapper>();
          for (
            Service_Custom_Field__c sfield : mapOfIdVsServieCustomField.values()
          ) {
            if (sfield.ProductId__c == exisitngOLI.Id) {
              ServiceCustomFieldValuesWrapper fieldWrap = new ServiceCustomFieldValuesWrapper();
              fieldWrap.Id = sfield.id;
              fieldWrap.Name = sfield.Name;
              fieldWrap.value = sfield.Value__c;
              fieldWrap.Eid = sfield.eid__c;
              existingOliWrapper.serviceCustomFieldValueList.add(fieldWrap);
            }
          }
        }
        if (mapOfOliIdVsScheduleChargesList.containsKey(exisitngOLI.id)) {
          existingOliWrapper.scheduleChargeList = new List<ScheduleChargeWrapper>();
          for (
            Schdeule_Charge__c sfield : mapOfOliIdVsScheduleChargesList.get(
              exisitngOLI.id
            )
          ) {
            ScheduleChargeWrapper fieldWrap = new ScheduleChargeWrapper();
            fieldWrap.Id = sfield.id;
            fieldWrap.SchdeuleAmount = sfield.Schdeule_Amount__c;
            fieldWrap.SchdeuleDate = sfield.Schdeule_Date__c;
            fieldWrap.SchdeuleDescription = sfield.Schdeule_Description__c;
            existingOliWrapper.scheduleChargeList.add(fieldWrap);
          }
        }

        system.debug('existingOliWrapper:::::' + existingOliWrapper);
        existingOliWrapperList.add(existingOliWrapper);
      }
    }
    system.debug('existingOliWrapperList:::::' + existingOliWrapperList);
    return existingOliWrapperList;
  }
  /**
   * Method to create Sales Order.
   * @param productWrapperString Product2AddWrapper in jason format
   * @param opportunityId salesforce opportunity ID
   * @return error msg
   */
  @AuraEnabled
  public static String createSalesOrderApex(
    string productWrapperString,
    String opportunityId
  ) {
    String terrorMessage = '';
    String priceBookName;
    list<String> productIdList = new List<String>();
    List<Product2AddWrapper> productWrapperList = (List<Product2AddWrapper>) JSON.deserialize(
      productWrapperString,
      List<Product2AddWrapper>.class
    );
    TRACT_Setup__c tract;
    List<opportunityLineItem> OLI_List_to_Insert = new List<opportunityLineItem>();
    Opportunity thisOpp = [
      SELECT
        Id,
        Name,
        Account.Name,
        Amount,
        CloseDate,
        Description,
        Owner.Name,
        TotalOpportunityQuantity,
        Probability,
        StageName,
        Type,
        Campaign.Name,
        LeadSource,
        NextStep,
        Tract_Sales_Order__c,
        Pricebook2Id,
        Account.Tract_Billing_Account__c,
        ExpectedRevenue,
        FiscalQuarter,
        Fiscal,
        FiscalYear,
        ForecastCategory,
        ForecastCategoryName,
        LastActivityDate,
        Order_Date__c,
        IsWon,
        IsDeleted,
        IsClosed,
        HasOpportunityLineItem,
        PriceBook2.Name,
        Billing_Account__c,
        AccountId
      FROM Opportunity
      WHERE id = :opportunityId
    ];

    map<id, id> pricebookentryMap = new Map<id, id>();
    for (PriceBookEntry pbe : [
      SELECT Id, Product2.Id, Pricebook2Id, Product2.Name, Product2Id
      FROM PriceBookEntry
      WHERE Pricebook2Id = :thisOpp.Pricebook2Id
      LIMIT 50000
    ]) {
      pricebookentryMap.put(pbe.Product2Id, pbe.id);
    }
    set<String> idSet = new Set<String>();
    for (Product2AddWrapper wr : productWrapperList) {
      idSet.add(wr.agreementId);
    }

    map<decimal, OpportunityLineItem> opLIMAp = new Map<decimal, OpportunityLineItem>();
    OpportunityLineItem[] opLI = [
      SELECT
        eid__c,
        productEid__c,
        Gotransverse_Overrided_Trial_Length__c,
        quantity,
        Service_Resource__c,
        minServiceResources__c,
        username__c,
        firstname__c,
        lastname__c,
        Email__c,
        New_Service_Resource__c,
        RecurringPrice__c,
        OneTimePrice__c,
        PricebookEntryId
      FROM OpportunityLineItem
      WHERE opportunityId = :opportunityId
      LIMIT 50000
    ];
    delete opLI;
    for (Product2AddWrapper wr : productWrapperList) {
      system.debug('wr:::::' + wr);
      opportunityLineItem oli = new opportunityLineItem();
      oli.Agreement_Period__c = wr.agreementPeriod;
      oli.agreementEndAction__c = wr.agreementEndAction;
      oli.overrideAgreementEndDate__c = wr.overrideAgreementEndDate;
      oli.Gotransverse_Overrided_Trial_Length__c = wr.overridedTrialLength;
      oli.Gotransverse_Next_Agreement_Eid__c = wr.nextAgreementId;
      oli.Gotransverse_NextAgreementEndAction__c = wr.nextAgreementEndAction;
      oli.GTV_Renewal_Price__c = wr.renewalPrice;
      oli.GTV_Next_Renewal_Price__c = wr.nextRenewalPrice;
      if (wr.quantity == null) {
        if (terrorMessage == '') {
          terrorMessage = 'Error: quantity Cannot be NULL';
        } else {
          terrorMessage =
            terrorMessage +
            '\n' +
            'Error: quantity Cannot be NULL';
        }
      } else if (pricebookentryMap.get(wr.prod.id) == null) {
        if (terrorMessage == '') {
          terrorMessage = 'Error: PricebookEntry Cannot be NULL';
        } else {
          terrorMessage =
            terrorMessage +
            '\n' +
            'Error: PricebookEntry Cannot be NULL';
        }
      }
      oli.opportunityId = opportunityId;
      oli.PricebookEntryId = pricebookentryMap.get(wr.prod.id);
      oli.quantity = wr.quantity;
      oli.Discount_eid__c = wr.discountEid;
      oli.Discount__c = wr.discountName;

      oli.Service_Resource_Eid__c = wr.serviceResourceEid;
      oli.Tract_Service_Resource_Name__c = wr.serviceResourceName;
      if (wr.newServiceResource != null) {
        oli.New_Service_Resource__c = wr.newServiceResource;
      }

      if (
        (wr.service == null && wr.parentServiceEId == ' ') &&
        wr.prod.ProductCode == 'Add-on'
      ) {
        if (terrorMessage == '') {
          terrorMessage =
            'Please select a parent service for ' +
            wr.prod.Name +
            '.';
        } else {
          terrorMessage =
            terrorMessage +
            '\n' +
            'Please select a parent service for ' +
            wr.prod.Name +
            '.';
        }
      }
      if (wr.recurringprice != null && wr.oneTimePrice != null)
        oli.unitPrice = wr.oneTimePrice + wr.recurringprice;
      else if (wr.recurringprice == null && wr.oneTimePrice != null)
        oli.unitPrice = wr.oneTimePrice;
      else if (wr.recurringprice != null && wr.oneTimePrice == null)
        oli.unitPrice = wr.recurringprice;
      else if (wr.recurringprice == null && wr.oneTimePrice == null) {
        if (terrorMessage == '') {
          terrorMessage = 'Error : Both Recurring and OneTime pricees are NULL. So, OpportunityLineItem Unitprice cannot be assigned (Since UnitPrice is Addition of both Recurring and Unit Price) ';
        } else {
          terrorMessage =
            terrorMessage +
            '\n' +
            'Error : Both Recurring and OneTime pricees are NULL. So, OpportunityLineItem Unitprice cannot be assigned (Since UnitPrice is Addition of both Recurring and Unit Price) ';
        }
      }
      if (
        (wr.agreementId == null ||
        wr.agreementId == '' ||
        wr.agreementId == ' ') && wr.prod.Requires_Agreement__c == true
      ) {
        oli.Applied_Agreement_Eid__c = null;
        if (terrorMessage == '') {
          terrorMessage =
            'Agreement needs to be selected for Product: ' + wr.prod.Name;
        } else {
          terrorMessage =
            terrorMessage +
            '\n' +
            'Agreement needs to be selected for Product: ' +
            wr.prod.Name;
        }
      } else if (
        (wr.agreementId != null ||
        wr.agreementId != '' ||
        wr.agreementId != ' ')
      ) {
        oli.Applied_Agreement_Eid__c = wr.agreementId;
      }
      if (wr.service != null && wr.service != '') {
        oLI.Service__c = wr.service;
      }
      if (wr.parentServiceEId != null && wr.parentServiceEId != ' ') {
        oLI.ParentServiceEid__c = wr.parentServiceEId;
      }
      oLI.ServiceName__c = wr.prod.Name;
      oLI.Price_Override__c = wr.priceOverridden;

      oLI.productEid__c = Decimal.valueof(wr.prod.eid__c);
      oLI.eid__c = wr.prod.eid__c;
      oLI.productOppEid__c = wr.prod.eid__c + opportunityId;
      if (wr.priceOverridden) {
        if (
          wr.priceVsPriceRanges.containsKey(wr.recurrencPerValue) &&
          wr.mapofProductPriceEidVsPriceOverrideFlag.get(wr.recurrencPerValue)
        ) {
          oLI.GTV_Recurring_Price_Range_Information__c = JSON.serialize(
            wr.priceVsPriceRanges.get(wr.recurrencPerValue)
          );
          oli.RecurringPrice__c = wr.recurringprice;
        }
        if (
          wr.priceVsPriceRanges.containsKey(wr.oneTimePerValue) &&
          wr.disableonetime
        ) {
          oLI.GTV_OneTime_Price_Range_Information__c = JSON.serialize(
            wr.priceVsPriceRanges.get(wr.oneTimePerValue)
          );
          oli.OneTimePrice__c = wr.oneTimePrice;
        }
      }
      //check if recurring price has been overridden
      //if(wr.recurringprice !=null)

      //check if one time price has been overridden
      if (wr.oneTimePrice != null) {
        if (wr.oneTimeChargeEnable && wr.ScheduleChargeList.size() == 0) {
          if (terrorMessage == '') {
            terrorMessage =
              'Schedule One-Time Charges need to be entered for: ' +
              wr.prod.Name;
          } else {
            terrorMessage =
              terrorMessage +
              '\n' +
              'Schedule One-Time Charges need to be entered for: ' +
              wr.prod.Name;
          }
        }
      }
      //oLI.Gotransverse_Price_Range_Information__c   = JSON.serialize(productpriceIdVsPriceRangeMAp);
      if (wr.recurrencPerValue != null) {
        oli.RecurringProductPriceEid__c = wr.recurrencPerValue;
      }
      if (wr.oneTimePerValue != null) {
        oli.OneTimeProductPriceEid__c = wr.oneTimePerValue;
      }
      oli.description = wr.oLineItem.description;
      oli.priceList_Eid__c = wr.priceListValue;
      OLI_List_to_Insert.add(oli);
    }
    if (terrorMessage != '') {
      return terrorMessage;
    }
    if (OLI_List_to_Insert != null && OLI_List_to_Insert.size() > 0) {
      insert OLI_List_to_Insert;
    }
    updateOneTimeCharges(OLI_List_to_Insert);
    for (Integer i = 0; i < OLI_List_to_Insert.size(); i++) {
      productWrapperList[i].oliId = OLI_List_to_Insert[i].Id;
    }
    list<Schdeule_Charge__c> chargeList = new List<Schdeule_Charge__c>();
    list<Service_Custom_Field__c> serviceCustomFld = new List<Service_Custom_Field__c>();
    for (Product2AddWrapper wr : productWrapperList) {
      String oliID = wr.oliId;
      String productEid = wr.prod.Eid__c;
      if (wr.ScheduleChargeList.size() > 0) {
        list<ScheduleChargeWrapper> charge = wr.ScheduleChargeList;
        for (ScheduleChargeWrapper chargeWrapper : charge) {
          Schdeule_Charge__c chargeInstance = new Schdeule_Charge__c();
          //chargeInstance.productEid__c = oliID + productEid;
          chargeInstance.ProductId__c = oliID;
          chargeInstance.Charge_Type__c = 'one-time';
          chargeInstance.Schdeule_Amount__c = chargeWrapper.SchdeuleAmount;
          chargeInstance.Schdeule_Date__c = chargeWrapper.SchdeuleDate;
          chargeInstance.Schdeule_Description__c = chargeWrapper.SchdeuleDescription;
          chargeList.add(chargeInstance);
        }
        /* for(Schdeule_Charge__c chargeInstance :charge){
                        chargeInstance.productEid__c = oliID + productEid;
                        chargeInstance.ProductId__c = oliID;
                        chargeInstance.Charge_Type__c = mapProdIdVsProdPrice.get(wr.prod.Id).priceType;
                        chargeList.add(chargeInstance);
                    }*/
      }
      if (wr.serviceCustomFieldValueList.size() > 0) {
        for (
          ServiceCustomFieldValuesWrapper fld : wr.serviceCustomFieldValueList
        ) {
          if (
            (null != fld.value && fld.value != '') ||
            (null != fld.ServiceListTypeValue &&
            '' != fld.ServiceListTypeValue &&
            'Choose One' != fld.ServiceListTypeValue)
          ) {
            Service_Custom_Field__c serviceFields = new Service_Custom_Field__c();
            serviceFields.Name = fld.Name;
            serviceFields.ProductId__c = oliID;
            if (null != fld.ServiceListTypeValue) {
              serviceFields.Value__c = fld.ServiceListTypeValue;
            } else {
              serviceFields.Value__c = fld.value;
            }
            serviceFields.eid__c = fld.Eid;
            serviceFields.ProductEidMap__c = oliID + productEid;
            serviceCustomFld.add(serviceFields);
          }
        }
      }
    }

    if (serviceCustomFld.size() > 0) {
      insert serviceCustomFld;
    }

    if (chargeList.size() > 0) {
      insert chargeList;
    }
    if (terrorMessage == '') {
      return 'NoError';
    } else {
      return terrorMessage;
    }
  }
  private static void updateOneTimeCharges(
    List<opportunityLineItem> OLI_List_to_Insert
  ) {
    map<String, String> opLIMAp = new Map<String, String>();
    for (OpportunityLineItem oli : OLI_List_to_Insert) {
      opLIMAp.put(oli.productOppEid__c, oli.Id);
    }
    List<Schdeule_Charge__c> chargeToUpdate = new List<Schdeule_Charge__c>();
    for (Schdeule_Charge__c charge : [
      SELECT id, ProductId__c, productEid__c
      FROM Schdeule_Charge__c
      LIMIT 50000
    ]) {
      if (opLIMAp.get(charge.productEid__c) != null) {
        charge.ProductId__c = opLIMAp.get(charge.productEid__c);
        chargeToUpdate.add(charge);
      }
    }
    if (chargeToUpdate != null && chargeToUpdate.size() > 0) {
      update chargeToUpdate;
    }
  }
  /**
   * Method to get OLI Product Prices Information.
   * @param productWrapperString Product2AddWrapper in jason format
   * @param exisitingOLI existing product in OLI
   * @return Product2AddWrapper
   */
  @AuraEnabled
  public static Product2AddWrapper getOLIProductPricesInformation(
    String productWrapperString,
    OpportunityLineItem exisitingOLI
  ) {
    Product2AddWrapper productWrapper = (Product2AddWrapper) JSON.deserialize(
      productWrapperString,
      Product2AddWrapper.class
    );
    String currentPriceListEid = productWrapper.priceListValue;
    if (currentPriceListEid != '' && currentPriceListEid != null) {
      list<ProductPriceWrapper> listOfProductPrices = (list<ProductPriceWrapper>) JSON.deserialize(
        productWrapper.prod.Price_Information__c,
        list<ProductPriceWrapper>.class
      );
      Map<String, list<ProductPriceRangeWrapper>> mapOfProductPriceEidVsPriceRangeList = new Map<String, list<ProductPriceRangeWrapper>>();
      Map<String, boolean> mapofProductPriceEidVsPriceOverrideFlag = new Map<String, boolean>();
      for (ProductPriceWrapper productPriceObj : listOfProductPrices) {
        if (productWrapper.recurrencPerValue == productPriceObj.eid) {
          productWrapper.disableRecurring = productPriceObj.priceOverride;
          mapofProductPriceEidVsPriceOverrideFlag.put(
            productPriceObj.eid,
            productPriceObj.priceOverride
          );
          mapOfProductPriceEidVsPriceRangeList.put(
            productPriceObj.eid,
            new List<ProductPriceRangeWrapper>()
          );
          if (
            exisitingOLI.TRACT3__Price_Override__c &&
            exisitingOLI.RecurringPrice__c != null
          ) {
            productWrapper.recurringprice = exisitingOLI.RecurringPrice__c;
            productWrapper.priceOverridden = exisitingOLI.TRACT3__Price_Override__c;
            list<ProductPriceRangeWrapper> listOfRecurringProductPriceRanges = (list<ProductPriceRangeWrapper>) JSON.deserialize(
              exisitingOLI.TRACT3__GTV_Recurring_Price_Range_Information__c,
              list<ProductPriceRangeWrapper>.class
            );
            mapOfProductPriceEidVsPriceRangeList.get(productPriceObj.eid)
              .addAll(listOfRecurringProductPriceRanges);
          } else if (
            !exisitingOLI.TRACT3__Price_Override__c &&
            exisitingOLI.RecurringPrice__c != null
          ) {
            productWrapper.recurringprice = exisitingOLI.RecurringPrice__c;
            for (
              ProductPriceRangeWrapper productPriceRangeObj : productPriceObj.priceRangesList
            ) {
              mapOfProductPriceEidVsPriceRangeList.get(productPriceObj.eid)
                .add(productPriceRangeObj);
            }
          } else {
            for (
              ProductPriceRangeWrapper productPriceRangeObj : productPriceObj.priceRangesList
            ) {
              if (productPriceRangeObj.quantityEndRange != null) {
                if (
                  productPriceRangeObj.quantityBeginRange <
                  productWrapper.quantity &&
                  productPriceRangeObj.quantityEndRange >=
                  productWrapper.quantity
                ) {
                  productWrapper.recurringprice = productPriceRangeObj.price;
                }
              } else {
                if (
                  productPriceRangeObj.quantityBeginRange <
                  productWrapper.quantity
                ) {
                  productWrapper.recurringprice = productPriceRangeObj.price;
                }
              }
              mapOfProductPriceEidVsPriceRangeList.get(productPriceObj.eid)
                .add(productPriceRangeObj);
            }
          }
        }
        if (productWrapper.oneTimePerValue == productPriceObj.eid) {
          productWrapper.disableonetime = productPriceObj.priceOverride;
          productWrapper.oneTimeChargeEnable = productPriceObj.scheduledCharges;
          mapOfProductPriceEidVsPriceRangeList.put(
            productPriceObj.eid,
            new List<ProductPriceRangeWrapper>()
          );
          if (
            exisitingOLI.TRACT3__Price_Override__c &&
            exisitingOLI.OneTimePrice__c != null
          ) {
            productWrapper.oneTimePrice = exisitingOLI.OneTimePrice__c;
            productWrapper.priceOverridden = exisitingOLI.TRACT3__Price_Override__c;
            list<ProductPriceRangeWrapper> listOfOneTimeProductPriceRanges = (list<ProductPriceRangeWrapper>) JSON.deserialize(
              exisitingOLI.TRACT3__GTV_OneTime_Price_Range_Information__c,
              list<ProductPriceRangeWrapper>.class
            );
            mapOfProductPriceEidVsPriceRangeList.get(productPriceObj.eid)
              .addAll(listOfOneTimeProductPriceRanges);
          } else if (
            !exisitingOLI.TRACT3__Price_Override__c &&
            exisitingOLI.OneTimePrice__c != null
          ) {
            productWrapper.oneTimePrice = exisitingOLI.OneTimePrice__c;
            for (
              ProductPriceRangeWrapper productPriceRangeObj : productPriceObj.priceRangesList
            ) {
              mapOfProductPriceEidVsPriceRangeList.get(productPriceObj.eid)
                .add(productPriceRangeObj);
            }
          } else {
            for (
              ProductPriceRangeWrapper productPriceRangeObj : productPriceObj.priceRangesList
            ) {
              if (productPriceRangeObj.quantityEndRange != null) {
                if (
                  productPriceRangeObj.quantityBeginRange <
                  productWrapper.quantity &&
                  productPriceRangeObj.quantityEndRange >=
                  productWrapper.quantity
                ) {
                  productWrapper.oneTimePrice = productPriceRangeObj.price;
                }
              } else {
                if (
                  productPriceRangeObj.quantityBeginRange <
                  productWrapper.quantity
                ) {
                  productWrapper.oneTimePrice = productPriceRangeObj.price;
                }
              }
              mapOfProductPriceEidVsPriceRangeList.get(productPriceObj.eid)
                .add(productPriceRangeObj);
            }
          }
        }
      }
      productWrapper.priceVsPriceRanges = mapOfProductPriceEidVsPriceRangeList;
      productWrapper.mapofProductPriceEidVsPriceOverrideFlag = mapofProductPriceEidVsPriceOverrideFlag;
    }
    return productWrapper;
  }
  /**
   * Method to check Enabled Agreement.
   * @param currencyType currency type
   * @param agreementInformation list<ProductAgreementWrapper> in json format
   * @return boolean
   */
  public static boolean checkEnabledAgreement(
    String currencyType,
    String agreementInformation
  ) {
    boolean enabledAgreement = false;
    list<ProductAgreementWrapper> listofAgreements = (list<ProductAgreementWrapper>) JSON.deserialize(
      agreementInformation,
      list<ProductAgreementWrapper>.class
    );
    if (null != listofAgreements) {
      for (ProductAgreementWrapper agInstance : listofAgreements) {
        if (agInstance.currencyType == currencyType) {
          return true;
        }
      }
    }
    return enabledAgreement;
  }
  /**
   * Method to get Service Custom Field.
   * @param selectedProductEid tract productID
   * @param serviceCustomFieldValueString List<ServiceCustomFieldValuesWrapper> in json format
   * @return list<ServiceCustomFieldValuesWrapper>
   */
  @AuraEnabled
  public static list<ServiceCustomFieldValuesWrapper> getServiceCustomField(
    String selectedProductEid,
    String serviceCustomFieldValueString
  ) {
    TRACT_Setup__c tractConfig = [
      SELECT id, Tract_User_Name__c, TRACT_URL__c, Active__c, TPassword__c
      FROM TRACT_Setup__c
      WHERE Active__c = TRUE
      LIMIT 1
    ];
    List<ServiceCustomFieldValuesWrapper> configuredValues = (List<ServiceCustomFieldValuesWrapper>) JSON.deserialize(
      serviceCustomFieldValueString,
      List<ServiceCustomFieldValuesWrapper>.class
    );
    List<ServiceCustomFieldValuesWrapper> serviceCustomFieldValuesWrapperList = new List<ServiceCustomFieldValuesWrapper>();
    Map<String, String> serviceCutFldEidVsValueMap = new Map<String, String>();
    for (ServiceCustomFieldValuesWrapper fieldvalueWrapObj : configuredValues) {
      if (
        fieldvalueWrapObj.ServiceListType != null &&
        fieldvalueWrapObj.ServiceListType.size() > 0
      ) {
        serviceCutFldEidVsValueMap.put(
          fieldvalueWrapObj.Eid,
          fieldvalueWrapObj.ServiceListTypeValue
        );
      } else {
        serviceCutFldEidVsValueMap.put(
          fieldvalueWrapObj.Eid,
          fieldvalueWrapObj.Value
        );
      }
    }
    //We are querying Service Custom Fields corresponding to Product on click of link - 'Configure Service Custom Field'
    List<Tract_Service_Custom_Field__c> serviceFld;
    APIDataService dataService = GTVDataService.getService();
    serviceFld = dataService.getServiceCustomFieldByProduct(selectedProductEid);
    if (null != serviceFld && serviceFld.size() > 0) {
      for (Tract_Service_Custom_Field__c serviceCustomField : serviceFld) {
        ServiceCustomFieldValuesWrapper serviceCustomFieldValue = new ServiceCustomFieldValuesWrapper();
        serviceCustomFieldValue.Name = serviceCustomField.Name;
        serviceCustomFieldValue.Eid = serviceCustomField.eid__c;
        serviceCustomFieldValue.checkListtype = false;
        serviceCustomFieldValue.fieldValidationType = String.valueOf(
          serviceCustomField.ValidationType__c
        );
        if (
          serviceCutFldEidVsValueMap.containsKey(serviceCustomFieldValue.Eid)
        ) {
          serviceCustomFieldValue.Value = serviceCutFldEidVsValueMap.get(
            serviceCustomFieldValue.Eid
          );
        }
        serviceCustomFieldValue.ServiceListType = new List<SelectOption>();
        if (serviceCustomField.StoreListValue__c != null) {
          if (
            serviceCutFldEidVsValueMap.containsKey(serviceCustomFieldValue.Eid)
          ) {
            serviceCustomFieldValue.ServiceListTypeValue = serviceCutFldEidVsValueMap.get(
              serviceCustomFieldValue.Eid
            );
          }
          serviceCustomFieldValue.checkListtype = true;
          serviceCustomFieldValue.ServiceListType.add(
            new selectOption('Choose One', 'Choose One')
          );
          for (String str : (serviceCustomField.StoreListValue__c).split(',')) {
            serviceCustomFieldValue.ServiceListType.add(
              new selectOption(str, str)
            );
          }
        }
        serviceCustomFieldValuesWrapperList.add(serviceCustomFieldValue);
      }
    }
    return serviceCustomFieldValuesWrapperList;
  }
  /**
   * Method to get Service Field List.
   * @param selectedProductEid tract productID
   * @return List<Tract_Service_Custom_Field__c>
   */
  @AuraEnabled
  public static List<Tract_Service_Custom_Field__c> getServiceFieldList(
    String selectedProductEid
  ) {
    List<Tract_Service_Custom_Field__c> serviceFld = new List<Tract_Service_Custom_Field__c>();
    APIDataService dataService = GTVDataService.getService();
    serviceFld = dataService.getServiceCustomFieldByProduct(selectedProductEid);
    return serviceFld;
  }
  /**
   * Method to get Oli ID.
   * @param recordId salesforce OLI ID
   * @return OliId
   */
  @AuraEnabled
  public static String getOliId(String recordId) {
    system.debug('recordId::::' + recordId);
    OpportunityLineItem opLI = [
      SELECT
        id,
        eid__c,
        opportunityId,
        priceList_Eid__c,
        TotalPrice,
        Applied_Agreement_Eid__c,
        Agreement_Period__c,
        agreementEndAction__c,
        overrideAgreementEndDate__c,
        productEid__c,
        quantity,
        Service_Resource__c,
        minServiceResources__c,
        username__c,
        firstname__c,
        lastname__c,
        Email__c,
        New_Service_Resource__c,
        RecurringPrice__c,
        OneTimePrice__c,
        PricebookEntryId
      FROM OpportunityLineItem
      WHERE id = :recordId
      LIMIT 1
    ];
    system.debug('opLI.Id::::' + opLI.Id);
    return opLI.Id;
  }
  /**
   * Method to get Oli Details.
   * @param oliId salesforce OLI ID
   * @return Product2AddWrapper
   */
  @AuraEnabled
  public static Product2AddWrapper getOliDetails(String oliId) {
    List<SelectOption> priceListOption = new List<SelectOption>();
    system.debug('oliId::::' + oliId);
    OpportunityLineItem opLI = [
      SELECT
        id,
        eid__c,
        opportunityId,
        priceList_Eid__c,
        TotalPrice,
        Applied_Agreement_Eid__c,
        Agreement_Period__c,
        agreementEndAction__c,
        overrideAgreementEndDate__c,
        productEid__c,
        quantity,
        Service_Resource__c,
        minServiceResources__c,
        username__c,
        firstname__c,
        lastname__c,
        Email__c,
        Service_Resource_Eid__c,
        Tract_Service_Resource_Name__c,
        New_Service_Resource__c,
        Gotransverse_NextAgreementEndAction__c,
        Gotransverse_Next_Agreement_Eid__c,
        RecurringPrice__c,
        OneTimePrice__c,
        PricebookEntryId
      FROM OpportunityLineItem
      WHERE id = :oliId
      LIMIT 1
    ];
    List<String> pricebookNames = new List<String>();
    Product2AddWrapper proWrap = new Product2AddWrapper();
    proWrap.oppId = opLI.opportunityId;
    proWrap.quantity = Integer.valueOf(opLI.quantity);
    if (opLI.New_Service_Resource__c != null) {
      proWrap.newServiceResource = opLI.New_Service_Resource__c;
    }
    if (
      opLI.Service_Resource_Eid__c != null &&
      opLI.Tract_Service_Resource_Name__c != null
    ) {
      proWrap.serviceResourceEid = opLI.Service_Resource_Eid__c;
      proWrap.serviceResourceName = opLI.Tract_Service_Resource_Name__c;
    }
    Opportunity opp = [
      SELECT Id, Name, Pricebook2Id
      FROM Opportunity
      WHERE Id = :opLI.opportunityId
      LIMIT 1
    ];

    PriceBook2 priceBook = [
      SELECT Id, Name
      FROM PriceBook2
      WHERE Id = :opp.Pricebook2Id
      LIMIT 1
    ];
    for (String pName : priceBook.Name.split(' ')) {
      pricebookNames.add(pName);
    }
    proWrap.pricebookNames = pricebookNames;

    String prodEid = String.valueof(opLI.productEid__c);
    product2 prod = [
      SELECT
        Id,
        Name,
        eid__c,
        minServiceResources__c,
        PriceLists__c,
        maxServiceResources__c,
        RuleOverride__c,
        Price_Information__c,
        Agreement_Information__c
      FROM product2
      WHERE eid__c = :prodEid
      LIMIT 1
    ];

    if (opLI.Applied_Agreement_Eid__c != null) {
      proWrap.agreementId = opLI.Applied_Agreement_Eid__c;
      proWrap.agreementPeriod = opLI.Agreement_Period__c;
      proWrap.agreementEndAction = opLI.agreementEndAction__c;
      proWrap.overrideAgreementEndDate = opLI.overrideAgreementEndDate__c;
      proWrap.nextAgreementId = opLI.Gotransverse_Next_Agreement_Eid__c;
      proWrap.nextAgreementEndAction = opLI.Gotransverse_NextAgreementEndAction__c;
      list<ProductAgreementWrapper> agreementWrapList = (list<ProductAgreementWrapper>) JSON.deserialize(
        prod.Agreement_Information__c,
        list<ProductAgreementWrapper>.class
      );
      for (ProductAgreementWrapper agreWrap : agreementWrapList) {
        if (agreWrap.eid == opLI.Applied_Agreement_Eid__c) {
          proWrap.agreementName = agreWrap.Name;
          proWrap.agreementPeriodType = agreWrap.agreementPeriodType;
        }
      }
    }
    if (prod.PriceLists__c != null) {
      for (String priceList : prod.PriceLists__c.split(',')) {
        list<String> priceLists = new List<String>();
        priceLists = priceList.split(':');
        if (priceList != null && priceLists.size() > 0) {
          string priceListName = '';
          string priceListEid = '';
          if (priceLists[0] != null) {
            priceListName = priceLists[0];
          }
          if (priceLists.size() > 1) {
            priceListEid = priceLists[1];
          }
          priceListOption.add(new SelectOption(priceListEid, priceListName));
        }
      }
    }
    proWrap.productPriceList = priceListOption;
    List<ProductPriceWrapper> productPriceWrapList = (list<ProductPriceWrapper>) JSON.deserialize(
      prod.Price_Information__c,
      list<ProductPriceWrapper>.class
    );
    proWrap.prod = prod;
    proWrap.productEid = prod.eid__c;
    proWrap.minServiceResource = prod.minServiceResources__c;
    proWrap.maxServiceResource = prod.maxServiceResources__c;
    proWrap.ruleOverride = prod.RuleOverride__c;
    proWrap.priceListValue = opLI.priceList_Eid__c;
    Price_List__c priceList = [
      SELECT Id, name, eid__c
      FROM Price_List__c
      WHERE eid__c = :proWrap.priceListValue
      LIMIT 1
    ];
    proWrap.priceListValue1 = priceList.Name;
    if (opLI.OneTimePrice__c != null) {
      proWrap.oneTimePrice = opLI.OneTimePrice__c;
    }
    if (opLI.RecurringPrice__c != null) {
      proWrap.recurringprice = opLI.RecurringPrice__c;
    }
    for (ProductPriceWrapper ppw : productPriceWrapList) {
      if (ppw.priceType == 'Recurring') {
        if (ppw.currencyType == proWrap.pricebookNames[1]) {
          proWrap.scheduleChargeEnable = ppw.scheduledCharges;
          proWrap.disableRecurring = ppw.priceOverride;
          ProductPriceRangeWrapper productPriceRangeObj = ppw.priceRangesList[0];
          if (
            proWrap.recurringprice == null &&
            proWrap.priceListValue == ppw.priceListEid
          ) {
            proWrap.recurringprice = productPriceRangeObj.price;
          }
        }
      }

      if (ppw.priceType == 'one-time' || ppw.priceType == 'onetime') {
        if (ppw.currencyType == proWrap.pricebookNames[1]) {
          proWrap.oneTimeChargeEnable = ppw.scheduledCharges;
          proWrap.disableonetime = ppw.priceOverride;
          proWrap.oneTimePerValue = ppw.eid;
          ProductPriceRangeWrapper sfdcProductPrice = ppw.priceRangesList[0];
          if (
            proWrap.oneTimePrice == null &&
            proWrap.priceListValue == ppw.priceListEid
          ) {
            proWrap.oneTimePrice = sfdcProductPrice.price;
          }
        }
      }
    }
    proWrap.usageWrapList = showActivityChargeRule(
      prod.eid__c,
      opLI.opportunityId
    );
    list<Service_Custom_Field__c> serviceFields = [
      SELECT id, Name, value__c, eid__c, ProductId__c
      FROM Service_Custom_Field__c
      WHERE ProductId__c = :oliId
    ];
    if (!serviceFields.isEmpty()) {
      proWrap.serviceCustomFieldValueList = new List<ServiceCustomFieldValuesWrapper>();
      for (Service_Custom_Field__c sfield : serviceFields) {
        ServiceCustomFieldValuesWrapper fieldWrap = new ServiceCustomFieldValuesWrapper();
        fieldWrap.Id = sfield.id;
        fieldWrap.Name = sfield.Name;
        fieldWrap.value = sfield.Value__c;
        fieldWrap.Eid = sfield.eid__c;
        proWrap.serviceCustomFieldValueList.add(fieldWrap);
      }
    }
    list<Schdeule_Charge__c> charge = [
      SELECT
        id,
        ProductId__c,
        Schdeule_Date__c,
        Schdeule_Description__c,
        productEid__c,
        Schdeule_Amount__c
      FROM Schdeule_Charge__c
      WHERE ProductId__c = :oliId
      LIMIT 50000
    ];
    if (!charge.isEmpty()) {
      proWrap.scheduleChargeList = new List<ScheduleChargeWrapper>();
      for (Schdeule_Charge__c sfield : charge) {
        ScheduleChargeWrapper fieldWrap = new ScheduleChargeWrapper();
        fieldWrap.Id = sfield.id;
        fieldWrap.SchdeuleAmount = sfield.Schdeule_Amount__c;
        fieldWrap.SchdeuleDate = sfield.Schdeule_Date__c;
        fieldWrap.SchdeuleDescription = sfield.Schdeule_Description__c;
        proWrap.scheduleChargeList.add(fieldWrap);
      }
    }
    return proWrap;
  }
  /**
   * Method to save Oli Details.
   * @param productWrapString Product2AddWrapper in json format
   * @param oliId salesforce OLI ID
   */
  @AuraEnabled
  public static void saveOLiDetails(String productWrapString, String oliId) {
    list<Service_Custom_Field__c> customFIeldListDeleted = new List<Service_Custom_Field__c>();
    list<Schdeule_Charge__c> scheduleChargeListDeleted = new List<Schdeule_Charge__c>();
    list<Service_Custom_Field__c> serviceCustomFld = new List<Service_Custom_Field__c>();
    list<Schdeule_Charge__c> chargeList = new List<Schdeule_Charge__c>();
    Product2AddWrapper wr = (Product2AddWrapper) JSON.deserialize(
      productWrapString,
      Product2AddWrapper.class
    );
    OpportunityLineItem oLI = [
      SELECT
        id,
        eid__c,
        productEid__c,
        quantity,
        Service_Resource__c,
        minServiceResources__c,
        username__c,
        firstname__c,
        lastname__c,
        Email__c,
        Service_Resource_Eid__c,
        Tract_Service_Resource_Name__c,
        New_Service_Resource__c,
        priceList_Eid__c,
        Gotransverse_Next_Agreement_Eid__c,
        Gotransverse_NextAgreementEndAction__c,
        RecurringPrice__c,
        OneTimePrice__c,
        PricebookEntryId
      FROM OpportunityLineItem
      WHERE id = :oliId
      LIMIT 1
    ];

    if (wr.agreementId == null || wr.agreementId.trim() == '') {
      oli.Applied_Agreement_Eid__c = null;
    } else {
      oli.Applied_Agreement_Eid__c = String.valueof(wr.agreementId);
    }
    oli.Agreement_Period__c = wr.agreementPeriod;
    oli.agreementEndAction__c = wr.agreementEndAction;
    oli.overrideAgreementEndDate__c = wr.overrideAgreementEndDate;
    oli.Gotransverse_Next_Agreement_Eid__c = wr.nextAgreementId;
    oli.Gotransverse_NextAgreementEndAction__c = wr.nextAgreementEndAction;
    oli.priceList_Eid__c = wr.priceListValue;
    oli.quantity = wr.quantity;
    oli.Service_Resource_Eid__c = wr.serviceResourceEid;
    oli.Tract_Service_Resource_Name__c = wr.serviceResourceName;
    oli.New_Service_Resource__c = wr.newServiceResource;
    for (Schdeule_Charge__c scheCharge : [
      SELECT
        Id,
        Name,
        Schdeule_Description__c,
        Schdeule_Amount__c,
        Schdeule_Date__c,
        ProductID__c
      FROM Schdeule_Charge__c
      WHERE ProductID__c = :oliId
    ]) {
      scheduleChargeListDeleted.add(scheCharge);
    }
    delete scheduleChargeListDeleted;

    for (Service_Custom_Field__c serviceCustom : [
      SELECT Id, Name, Value__c, ProductID__c
      FROM Service_Custom_Field__c
      WHERE ProductID__c = :oliId
    ]) {
      customFIeldListDeleted.add(serviceCustom);
    }
    delete customFIeldListDeleted;
    if (wr.ScheduleChargeList.size() > 0) {
      list<ScheduleChargeWrapper> charge = wr.ScheduleChargeList;
      for (ScheduleChargeWrapper chargeWrapper : charge) {
        Schdeule_Charge__c chargeInstance = new Schdeule_Charge__c();
        chargeInstance.ProductID__c = oliID;
        chargeInstance.Charge_Type__c = 'one-time';
        chargeInstance.Schdeule_Amount__c = chargeWrapper.SchdeuleAmount;
        chargeInstance.Schdeule_Date__c = chargeWrapper.SchdeuleDate;
        chargeInstance.Schdeule_Description__c = chargeWrapper.SchdeuleDescription;
        chargeList.add(chargeInstance);
      }
    }
    if (wr.serviceCustomFieldValueList.size() > 0) {
      for (
        ServiceCustomFieldValuesWrapper fld : wr.serviceCustomFieldValueList
      ) {
        Service_Custom_Field__c serviceFields = new Service_Custom_Field__c();
        if (
          (null != fld.value && fld.value != '') ||
          (null != fld.ServiceListTypeValue &&
          '' != fld.ServiceListTypeValue &&
          'Choose One' != fld.ServiceListTypeValue)
        ) {
          serviceFields.Name = fld.Name;
          serviceFields.ProductId__c = oliID;
          if (null != fld.ServiceListTypeValue) {
            serviceFields.Value__c = fld.ServiceListTypeValue;
          } else {
            serviceFields.Value__c = fld.value;
          }
          serviceFields.eid__c = fld.Eid;
          serviceFields.ProductEidMap__c = oliID + wr.prod.Eid__c;
          serviceCustomFld.add(serviceFields);
        }
      }
    }
    if (serviceCustomFld.size() > 0) {
      upsert serviceCustomFld;
    }

    if (chargeList.size() > 0) {
      upsert chargeList;
    }
    upsert oli;
  }
  /**
   * Method to get Product Agreement.
   * @param productId salesforce product id
   * @param currencyType tract currency type
   * @return Agreementwrapper
   */
  @AuraEnabled
  public static Agreementwrapper getProductAgreement(
    String productId,
    String currencyType
  ) {
    Agreementwrapper agreementWrap = new Agreementwrapper();
    Map<String, Decimal> mapOfAgreementPeriod = new Map<String, Decimal>();
    Map<String, String> mapOfAgreementPeriodType = new Map<String, String>();
    List<SelectOption> agreementOption = new List<SelectOption>();
    List<SelectOption> renewActionList = new List<SelectOption>();
    List<SelectOption> nextRenewActionList = new List<SelectOption>();
    list<ProductAgreementWrapper> agreementList = new List<ProductAgreementWrapper>();
    List<SelectOption> nextAgreementOption = new List<SelectOption>();
    List<SelectOption> renewalPricingOption = new List<SelectOption>();
    renewalPricingOption.add(
      new SelectOption('Product Price', 'Product Price')
    );
    renewalPricingOption.add(
      new SelectOption('Service Price', 'Service Price')
    );
    nextAgreementOption.add(new SelectOption(' ', '--Choose One--'));
    if (productId != null) {
      product2 prod = [
        SELECT name, id, eid__c, Requires_Agreement__c, Agreement_Information__c
        FROM product2
        WHERE id = :productId
      ];
      list<ProductAgreementWrapper> listofAgreements = (list<ProductAgreementWrapper>) JSON.deserialize(
        prod.Agreement_Information__c,
        list<ProductAgreementWrapper>.class
      );
      if (null != listofAgreements) {
        for (ProductAgreementWrapper agInstance : listofAgreements) {
          if (agInstance.currencyType == currencyType) {
            agreementList.add(agInstance);
          }
        }
      }
      if (agreementList.size() > 0) {
        if (!prod.Requires_Agreement__c) {
          agreementOption.add(new SelectOption(' ', '--None--'));
        }
        for (ProductAgreementWrapper ag : agreementList) {
          if (ag.currencyType == currencyType) {
            agreementOption.add(new SelectOption(ag.eid, ag.name));
            nextAgreementOption.add(new SelectOption(ag.eid, ag.name));
            mapOfAgreementPeriod.put(ag.eid, ag.agreementPeriod);
            mapOfAgreementPeriodType.put(ag.eid, ag.agreementPeriodType);
          }
        }
        renewActionList.add(new SelectOption(' ', '--Choose One--'));
        nextRenewActionList.add(new SelectOption(' ', '--Choose One--'));
        for (
          TractSFDC_Util.AgreementEndAction endAction : TractSFDC_Util.AgreementEndAction.values()
        ) {
          renewActionList.add(
            new SelectOption(
              endAction.name(),
              TractSFDC_Util.convertToCamelCase(endAction.name(), '_')
            )
          );
          if (endAction.name() != 'CHANGE_AGREEMENT') {
            nextRenewActionList.add(
              new SelectOption(
                endAction.name(),
                TractSFDC_Util.convertToCamelCase(endAction.name(), '_')
              )
            );
          }
        }
      }
    }
    agreementWrap.agreementList = agreementOption;
    agreementWrap.renewAction = renewActionList;
    agreementWrap.mapOfAgreementPeriod = mapOfAgreementPeriod;
    agreementWrap.mapOfAgreementPeriodType = mapOfAgreementPeriodType;
    agreementWrap.nextAgreementList = nextAgreementOption;
    agreementWrap.nextRenewAction = nextRenewActionList;
    agreementWrap.renewalPricingOption = renewalPricingOption;
    return agreementWrap;
  }
  /**
   * Method to get Order Custom Field.
   * @param oppId salesforce opportunity id
   * @return list<ServiceCustomFieldValuesWrapper>
   */
  @AuraEnabled
  public static list<ServiceCustomFieldValuesWrapper> getOrderCustomField(
    String oppId
  ) {
    list<ServiceCustomFieldValuesWrapper> orderCustomFieldValuesWrapperList = new List<ServiceCustomFieldValuesWrapper>();
    List<Order_Custom_Field__c> orderFields = [
      SELECT Name, Eid__c, Value__c
      FROM Order_Custom_Field__c
      WHERE OpportunityIdCheck__c = :oppId
      ORDER BY Name
      LIMIT 50000
    ];
    map<String, String> orderEidVsValueMap = new Map<String, String>();
    for (Order_Custom_Field__c orderFieldsMap : orderFields) {
      orderEidVsValueMap.put(orderFieldsMap.Eid__c, orderFieldsMap.Value__c);
    }
    List<Tract_Order_Custom_Field__c> orderFld = [
      SELECT
        Name,
        Eid__c,
        Value__c,
        Store_Order_List_Value__c,
        orderCustomFieldType__c,
        ValidationType__c
      FROM Tract_Order_Custom_Field__c
      ORDER BY Name
      LIMIT 50000
    ];
    for (Tract_Order_Custom_Field__c serviceCustomField : orderFld) {
      ServiceCustomFieldValuesWrapper serviceCustomFieldValue = new ServiceCustomFieldValuesWrapper();
      serviceCustomFieldValue.Name = serviceCustomField.Name;
      serviceCustomFieldValue.Eid = serviceCustomField.eid__c;
      serviceCustomFieldValue.fieldValidationType = String.valueOf(
        serviceCustomField.ValidationType__c
      );
      if (serviceCustomFieldValue.fieldValidationType == 'DATE') {
        serviceCustomFieldValue.datetype = true;
        if (orderEidVsValueMap.containsKey(serviceCustomField.eid__c)) {
          serviceCustomFieldValue.dateField = orderEidVsValueMap.get(
            serviceCustomField.eid__c
          );
        }
      }
      if (orderEidVsValueMap.containsKey(serviceCustomField.eid__c)) {
        serviceCustomFieldValue.Value = orderEidVsValueMap.get(
          serviceCustomField.eid__c
        );
      } else {
        serviceCustomFieldValue.Value = serviceCustomField.value__c;
      }

      if (serviceCustomField.orderCustomFieldType__c == 'LIST') {
        if (orderEidVsValueMap.containsKey(serviceCustomField.eid__c)) {
          serviceCustomFieldValue.ServiceListTypeValue = orderEidVsValueMap.get(
            serviceCustomField.eid__c
          );
        }
        serviceCustomFieldValue.checkListtype = true;
        serviceCustomFieldValue.ServiceListType = new List<SelectOption>();
        serviceCustomFieldValue.ServiceListType.add(
          new selectOption('', 'Choose One')
        );
        if (serviceCustomField.Store_Order_List_Value__c != null) {
          for (
            String str : (serviceCustomField.Store_Order_List_Value__c)
              .split(',')
          ) {
            serviceCustomFieldValue.ServiceListType.add(
              new selectOption(str, str)
            );
          }
        }
      }

      orderCustomFieldValuesWrapperList.add(serviceCustomFieldValue);
    }

    return orderCustomFieldValuesWrapperList;
  }
  /**
   * Method to save Order Custom Field.
   * @param oppId salesforce opportunity id
   * @param customFildWrapper list<ServiceCustomFieldValuesWrapper> in json format
   */
  @AuraEnabled
  public static void saveOrderCustomField(
    String customFildWrapper,
    String oppId
  ) {
    list<ServiceCustomFieldValuesWrapper> wrap = (list<ServiceCustomFieldValuesWrapper>) JSON.deserialize(
      customFildWrapper,
      List<ServiceCustomFieldValuesWrapper>.class
    );
    List<Order_Custom_Field__c> orderCustomFld = new List<Order_Custom_Field__c>();
    for (ServiceCustomFieldValuesWrapper fld : wrap) {
      if (
        (null != fld.value && fld.value != '') ||
        (null != fld.ServiceListTypeValue)
      ) {
        Order_Custom_Field__c orderFields = new Order_Custom_Field__c();
        orderFields.Name = fld.Name;

        if (
          null != fld.ServiceListTypeValue ||
          fld.ServiceListTypeValue == ''
        ) {
          orderFields.Value__c = fld.ServiceListTypeValue;
        } else {
          orderFields.Value__c = fld.value;
        }
        orderFields.eid__c = fld.Eid;
        orderFields.OpportunityIdCheck__c = oppId;
        orderFields.OpportunityID__c = oppId + fld.Eid;
        orderCustomFld.add(orderFields);
      }
    }
    upsert orderCustomFld OpportunityID__c;
  }
  /**
   * Method to get Disount Code.
   * @param productWrapperString Product2AddWrapper in json format
   * @param discountName tract discount code name
   * @return Product2AddWrapper
   */
  @AuraEnabled
  public static Product2AddWrapper getDisountCode(
    String productWrapperString,
    String discountName
  ) {
    Product2AddWrapper productWrapper;
    APIDataService dataService = GTVDataService.getService();
    productWrapper = (Product2AddWrapper) dataService.getDiscounts(
      productWrapperString,
      discountName
    );
    return productWrapper;
  }
  /**
   * Method to get Service Resource.
   * @param srId service resource id
   * @return ServiceResourceWrapper
   */
  @AuraEnabled
  public static ServiceResourceWrapper getServiceResource(String srId) {
    ServiceResourceWrapper srWrapper = new ServiceResourceWrapper();
    APIDataService dataService = GTVDataService.getService();
    srWrapper = dataService.getServiceResourceById(srId);
    return srWrapper;
  }
  /**
   * @param srWrapper      : The serliazed list of srIds to apply
   * @param productWrapper : The serliazed product wrapper to apply srId
   *
   * @retun The product wrapper after applying srId
   *
   * @description : This method takes the list of srIds and assign them to the corresponding wrapper attributes
   **/
  @AuraEnabled
  public static Product2AddWrapper applySrIdToProduct(
    String srWrapper,
    String productWrapper
  ) {
    // deserialize the paramaters
    List<ServiceResourceWrapper> srIdList = (List<ServiceResourceWrapper>) JSON.deserialize(
      srWrapper,
      List<ServiceResourceWrapper>.class
    );
    Product2AddWrapper prodWrap = (Product2AddWrapper) JSON.deserialize(
      productWrapper,
      Product2AddWrapper.class
    );
    // String to accumulate identifiers of existing Service resources applied
    String srExistingIdentifiers = '';
    // String to accumulate eid of existing Service resources applied
    String srExistingEids = '';
    // String to accumulate identifiers of new service resources applied
    String srNewIdentifiers = '';
    // iterate over list of srId to apply on productwrapper
    for (ServiceResourceWrapper srWrap : srIdList) {
      if (srWrap.eid == null || srWrap.eid == '') {
        if (srNewIdentifiers == '') {
          srNewIdentifiers = srWrap.identifier;
        } else {
          srNewIdentifiers = srNewIdentifiers + '|' + srWrap.identifier;
        }
      } else {
        srExistingIdentifiers = srExistingIdentifiers + '|' + srWrap.identifier;
        srExistingEids = srExistingEids + '|' + srWrap.eid;
      }
    }
    //assign new service resources to wrapper attribute
    prodWrap.newServiceResource = srNewIdentifiers;
    //assign the identifiers and eids to corresponding wrapper attributes
    prodWrap.serviceResourceName = srExistingIdentifiers;
    prodWrap.serviceResourceEid = srExistingEids;
    return prodWrap;
  }

  /**
   * @param prodWrapper : The product wrapper to check applied service resources
   *
   * @return List<ServiceResourceWrapper>
   *
   * @description : This method gets the allready applied service recources from the product wrapper and retunr a wrapper list to be shown on UI.
   **/
  @AuraEnabled
  public static List<ServiceResourceWrapper> getAppliedServiceResources(
    String prodWrapper
  ) {
    Product2AddWrapper productWrapper = (Product2AddWrapper) JSON.deserialize(
      prodWrapper,
      Product2AddWrapper.class
    );
    List<String> newServiceResource = new List<String>();
    List<String> existingServiceResIdentifier = new List<String>();
    List<String> existingServiceResEid = new List<String>();
    List<ServiceResourceWrapper> srWrapper = new List<ServiceResourceWrapper>();
    if (
      productWrapper.newServiceResource != null &&
      productWrapper.newServiceResource != ''
    ) {
      if (productWrapper.newServiceResource.contains('|')) {
        for (
          String str : String.valueOf(productWrapper.newServiceResource)
            .split('\\|')
        ) {
          if (null != str && str.trim() != '') {
            newServiceResource.add(str);
          }
        }
      } else {
        String str = String.valueOf(productWrapper.newServiceResource);
        if (null != str && str.trim() != '') {
          newServiceResource.add(str);
        }
      }
    }
    if (
      productWrapper.serviceResourceName != null &&
      productWrapper.serviceResourceName != ''
    ) {
      for (
        String str : String.valueOf(productWrapper.serviceResourceName)
          .split('\\|')
      ) {
        if (null != str && str.trim() != '') {
          existingServiceResIdentifier.add(str);
        }
      }
    }
    if (
      productWrapper.serviceResourceEid != null &&
      productWrapper.serviceResourceEid != ''
    ) {
      for (
        String str : String.valueOf(productWrapper.serviceResourceEid)
          .split('\\|')
      ) {
        if (null != str && str.trim() != '') {
          existingServiceResEid.add(str);
        }
      }
    }

    ServiceResourceWrapper srWrapObj;
    if (newServiceResource.size() > 0) {
      for (String srId : newServiceResource) {
        srWrapObj = new ServiceResourceWrapper();
        srWrapObj.identifier = srId;
        srWrapper.add(srWrapObj);
      }
    }
    if (
      existingServiceResIdentifier.size() > 0 &&
      existingServiceResEid.size() > 0
    ) {
      for (Integer i = 0; i < existingServiceResIdentifier.size(); i++) {
        srWrapObj = new ServiceResourceWrapper();
        srWrapObj.identifier = existingServiceResIdentifier[i];
        srWrapObj.eid = existingServiceResEid[i];
        srWrapper.add(srWrapObj);
      }
    }
    return srWrapper;
  }
  /**
   * Method to Configure Schedule Charges.
   * @param amount SchdeuleAmount
   * @param dateToday SchdeuleDate
   * @return ScheduleChargeWrapper
   */
  @AuraEnabled
  public static ScheduleChargeWrapper configureScheduleCharges(
    String amount,
    String dateToday
  ) {
    ScheduleChargeWrapper sc = new ScheduleChargeWrapper();
    sc.SchdeuleAmount = String.valueOf(amount);
    sc.SchdeuleDate = Date.valueOf(dateToday);
    return sc;
  }
  /**
   * Method to save Schedule Charges.
   * @param listOfFilledScheduledCharges List<ScheduleChargeWrapper> in json format
   * @param oneTimevalue One-Time Charge Amount
   * @param productEid tract product ID
   * @param oppId salesforce opportunity id
   * @return error msg
   */
  @AuraEnabled
  public static string saveScheduleCharges(
    string listOfFilledScheduledCharges,
    Decimal oneTimevalue,
    string productEid,
    String oppId
  ) {
    List<ScheduleChargeWrapper> listOfFilledScheduledCharges1 = (List<ScheduleChargeWrapper>) JSON.deserialize(
      listOfFilledScheduledCharges,
      List<ScheduleChargeWrapper>.class
    );
    string discountError = 'NoError';
    Integer j = 0;
    Decimal totalOneTime = 0.0;
    for (ScheduleChargeWrapper fieldCheck1 : listOfFilledScheduledCharges1) {
      if (
        fieldCheck1.SchdeuleDescription == null ||
        fieldCheck1.SchdeuleDescription == '' ||
        fieldCheck1.SchdeuleAmount == null ||
        fieldCheck1.SchdeuleAmount == '' ||
        String.ValueOf(fieldCheck1.SchdeuleDate) == null ||
        String.valueOf(fieldCheck1.SchdeuleDate) == ''
      ) {
        j++;
      }
      if (
        fieldCheck1.SchdeuleAmount != null &&
        fieldCheck1.SchdeuleAmount != '' &&
        Pattern.matches('^[0-9]*^[0-9.0-9]*$', fieldCheck1.SchdeuleAmount)
      ) {
        totalOneTime += Double.valueOf(fieldCheck1.SchdeuleAmount);
      }
    }
    if (j > 0) {
      discountError = 'Please enter the value.';
    } else if (totalOneTime != oneTimevalue) {
      discountError = 'Total One-Time Charge Amount must equal the Total Amount.';
    } else {
    }
    return discountError;
  }
  /**
   * Method to show Activity Charge Rule.
   * @param activityProductEid
   * @param oppId salesforce opp id
   * @return List<ProductUsesWrapper>
   */
  @AuraEnabled
  public static List<ProductUsesWrapper> showActivityChargeRule(
    String activityProductEid,
    String oppId
  ) {
    List<ProductUsesWrapper> ruleOverrides = new List<ProductUsesWrapper>();
    if (null != activityProductEid) {
      List<OrderUsageRule__c> orderUsageRuleObjList = new List<OrderUsageRule__c>();
      if (
        TRACTAPIUtil.checkFieldLevelSecurity(
          'TRACT3__OrderUsageRule__c',
          'id, UsageUom__c, UsageRate__c, UsageRateUom__c, Status__c, RuleType__c, RollOverType__c, RateTypeValue__c, RateTableUsageFieldName__c, RateTableEid__c, ProratedOnOrder__c, ProratedOnCancel__c, ProductUsageValue__c, ProductEid__c, Limit__c, GlobalUsageEid__c, FormulaOperator__c, FormulaFieldvalue__c, FormulaFieldName__c, ChargeCategory__c, ChargeCategoryEid__c, AllowanceType__c, Name',
          'Query'
        )
      ) {
        orderUsageRuleObjList = [
          SELECT
            UsageUom__c,
            UsageRate__c,
            UsageRateUom__c,
            Status__c,
            RuleType__c,
            RollOverType__c,
            RateTypeValue__c,
            RateTableUsageFieldName__c,
            RateTableEid__c,
            ProratedOnOrder__c,
            ProratedOnCancel__c,
            ProductUsageValue__c,
            ProductEid__c,
            Limit__c,
            GlobalUsageEid__c,
            FormulaOperator__c,
            FormulaFieldvalue__c,
            FormulaFieldName__c,
            ChargeCategory__c,
            ChargeCategoryEid__c,
            AllowanceType__c,
            Name,
            Id,
            OpportunityID__c
          FROM OrderUsageRule__c
          WHERE
            ProductEid__c = :activityProductEid
            AND OpportunityID__c = :oppId
        ];
      }
      for (OrderUsageRule__c orderUsageRuleObj : orderUsageRuleObjList) {
        if (orderUsageRuleObj.ProductUsageValue__c == 'Match All Events') {
          ProductUsesWrapper productUsesWrapper = new ProductUsesWrapper();
          ProductUsesWrapper.recordId = orderUsageRuleObj.Id;
          productUsesWrapper.ChargeName = orderUsageRuleObj.Name;
          productUsesWrapper.Rule = 'Matches all';
          productUsesWrapper.UsageRuleEid = orderUsageRuleObj.GlobalUsageEid__c;
          productUsesWrapper.ChargeType = orderUsageRuleObj.ProductUsageValue__c;
          if (null != orderUsageRuleObj.UsageRate__c) {
            productUsesWrapper.Rate =
              String.valueOf(orderUsageRuleObj.UsageRate__c.setScale(2)) +
              ' per ' +
              orderUsageRuleObj.UsageRateUom__c.toLowerCase().capitalize();
            if (orderUsageRuleObj.limit__c > 0)
              productUsesWrapper.Taper =
                String.valueOf(orderUsageRuleObj.limit__c.setScale(0)) +
                ' ' +
                orderUsageRuleObj.UsageRateUom__c.toLowerCase().capitalize() +
                's';
            else
              productUsesWrapper.Taper =
                orderUsageRuleObj.AllowanceType__c +
                ' ' +
                orderUsageRuleObj.UsageRateUom__c.toLowerCase().capitalize();
          }
          if (null != orderUsageRuleObj.RateTableEid__c) {
            productUsesWrapper.Rate =
              'Table Rate ' + orderUsageRuleObj.RateTypeValue__c;
            productUsesWrapper.Taper =
              orderUsageRuleObj.AllowanceType__c +
              ' ' +
              orderUsageRuleObj.RateTableUsageFieldName__c;
          }
          if (
            null != orderUsageRuleObj.RateTableUsageFieldName__c &&
            orderUsageRuleObj.RateTableUsageFieldName__c != 'Choose One'
          ) {
            productUsesWrapper.Rate =
              'Pass Through ' + orderUsageRuleObj.RateTableUsageFieldName__c;
            if (orderUsageRuleObj.RateTypeValue__c == 'Flat') {
              productUsesWrapper.Taper =
                String.valueOf(orderUsageRuleObj.limit__c.setScale(0)) +
                ' ' +
                orderUsageRuleObj.UsageRateUom__c.toLowerCase().capitalize() +
                's';
            } else {
              if (String.valueOf(orderUsageRuleObj.limit__c) != null)
                productUsesWrapper.Taper = String.valueOf(
                  orderUsageRuleObj.limit__c.setScale(0)
                );
            }
          }
          if (null != orderUsageRuleObj.Status__c)
            productUsesWrapper.Status = orderUsageRuleObj.Status__c.toLowerCase()
              .capitalize();
          RuleOverrides.add(productUsesWrapper);
        } else if (orderUsageRuleObj.ProductUsageValue__c == 'Formula') {
          ProductUsesWrapper productUsesWrapper = new ProductUsesWrapper();
          ProductUsesWrapper.recordId = orderUsageRuleObj.Id;
          productUsesWrapper.ChargeName = orderUsageRuleObj.name;
          productUsesWrapper.Rule =
            orderUsageRuleObj.FormulaFieldName__c +
            ' = ' +
            orderUsageRuleObj.FormulaFieldvalue__c;
          productUsesWrapper.UsageRuleEid = orderUsageRuleObj.GlobalUsageEid__c;
          productUsesWrapper.ChargeType = orderUsageRuleObj.ProductUsageValue__c;
          if (null != orderUsageRuleObj.UsageRate__c) {
            productUsesWrapper.Rate =
              String.valueOf(orderUsageRuleObj.UsageRate__c.setScale(2)) +
              ' per ' +
              orderUsageRuleObj.UsageRateUom__c.toLowerCase().capitalize();
            if (orderUsageRuleObj.limit__c > 0)
              productUsesWrapper.Taper =
                String.valueOf(orderUsageRuleObj.limit__c.setScale(0)) +
                ' ' +
                orderUsageRuleObj.UsageRateUom__c.toLowerCase().capitalize() +
                's';
            else
              productUsesWrapper.Taper =
                orderUsageRuleObj.AllowanceType__c +
                ' ' +
                orderUsageRuleObj.UsageRateUom__c.toLowerCase().capitalize();
          }
          if (null != orderUsageRuleObj.RateTableEid__c) {
            productUsesWrapper.Rate =
              'Table Rate ' + orderUsageRuleObj.RateTypeValue__c;
            productUsesWrapper.Taper =
              orderUsageRuleObj.AllowanceType__c +
              ' ' +
              orderUsageRuleObj.RateTableUsageFieldName__c;
          }
          if (
            null != orderUsageRuleObj.RateTableUsageFieldName__c &&
            orderUsageRuleObj.RateTableUsageFieldName__c != 'Choose One'
          ) {
            productUsesWrapper.Rate =
              'Pass Through ' + orderUsageRuleObj.RateTableUsageFieldName__c;
            if (orderUsageRuleObj.RateTypeValue__c == 'Flat') {
              productUsesWrapper.Taper =
                String.valueOf(orderUsageRuleObj.limit__c.setScale(0)) +
                ' ' +
                orderUsageRuleObj.UsageRateUom__c.toLowerCase().capitalize() +
                's';
            } else {
              productUsesWrapper.Taper = String.valueOf(
                orderUsageRuleObj.limit__c.setScale(0)
              );
            }
          }
          if (null != orderUsageRuleObj.Status__c)
            productUsesWrapper.Status = orderUsageRuleObj.Status__c.toLowerCase()
              .capitalize();
          RuleOverrides.add(productUsesWrapper);
        } else {
          ProductUsesWrapper productUsesWrapper = new ProductUsesWrapper();
          ProductUsesWrapper.recordId = orderUsageRuleObj.Id;
          productUsesWrapper.ChargeName = orderUsageRuleObj.name;
          productUsesWrapper.Rule = 'Global';
          productUsesWrapper.UsageRuleEid = orderUsageRuleObj.GlobalUsageEid__c;
          productUsesWrapper.ChargeType = orderUsageRuleObj.ProductUsageValue__c;
          if (null != orderUsageRuleObj.UsageRate__c) {
            productUsesWrapper.Rate =
              String.valueOf(orderUsageRuleObj.UsageRate__c.setScale(2)) +
              ' per ' +
              orderUsageRuleObj.UsageRateUom__c.toLowerCase().capitalize();
            if (orderUsageRuleObj.limit__c > 0)
              productUsesWrapper.Taper =
                String.valueOf(orderUsageRuleObj.limit__c.setScale(0)) +
                ' ' +
                orderUsageRuleObj.UsageRateUom__c.toLowerCase().capitalize() +
                's';
            else
              productUsesWrapper.Taper =
                orderUsageRuleObj.AllowanceType__c +
                ' ' +
                orderUsageRuleObj.UsageRateUom__c.toLowerCase().capitalize();
          }
          if (null != orderUsageRuleObj.Status__c)
            productUsesWrapper.Status = orderUsageRuleObj.Status__c.toLowerCase()
              .capitalize();
          RuleOverrides.add(productUsesWrapper);
        }
      }
    }
    return RuleOverrides;
  }
  /**
   * Method to get Charge Rules Wrapper.
   * @return ChargeRulesWrapper
   */
  @AuraEnabled
  public static ChargeRulesWrapper getChargeRulesWrapper() {
    TRACT_Setup__c tract = [
      SELECT
        id,
        Tract_User_Name__c,
        TRACT_URL__c,
        Active__c,
        Api_Version__c,
        TPassword__c
      FROM TRACT_Setup__c
      WHERE Active__c = TRUE
      LIMIT 1
    ];

    list<SelectOption> selectStatusList = new List<SelectOption>();
    list<SelectOption> productUsageRuleList = new List<SelectOption>();
    list<SelectOption> productUsageRuleListAPI2 = new List<SelectOption>();
    list<SelectOption> rateTypeList = new List<SelectOption>();
    list<SelectOption> chargesPicklist = new List<SelectOption>();
    list<SelectOption> allowanceTypeList = new List<SelectOption>();
    list<SelectOption> roleOverList = new List<SelectOption>();
    list<SelectOption> formulaField = new List<SelectOption>();
    list<SelectOption> operationList = new List<SelectOption>();
    list<SelectOption> operationListAPI2 = new List<SelectOption>();
    list<SelectOption> passThroughChargeList = new List<SelectOption>();

    selectStatusList.add(new SelectOption('Draft', 'Draft'));
    selectStatusList.add(new SelectOption('Active', 'Active'));

    productUsageRuleList.add(
      new SelectOption('Match All Events', 'Match All Events')
    );
    productUsageRuleList.add(new SelectOption('Formula', 'Formula'));
    productUsageRuleList.add(new SelectOption('Global', 'Global'));

    productUsageRuleListAPI2.add(
      new SelectOption('Match All Events', 'Match All Events')
    );
    productUsageRuleListAPI2.add(new SelectOption('Formula', 'Formula'));

    rateTypeList.add(new SelectOption('Flat', 'Flat'));
    rateTypeList.add(new SelectOption('Table Rate', 'Table Rate'));
    rateTypeList.add(new SelectOption('Pass Through', 'Pass Through'));

    chargesPicklist.add(new SelectOption('Choose One', 'Choose One'));
    chargesPicklist.add(new SelectOption('Millisecond', 'Millisecond'));
    chargesPicklist.add(new SelectOption('Second', 'Second'));
    chargesPicklist.add(new SelectOption('Minute', 'Minute'));
    chargesPicklist.add(new SelectOption('Hour', 'Hour'));
    chargesPicklist.add(new SelectOption('Day', 'Day'));
    chargesPicklist.add(new SelectOption('Week', 'Week'));
    chargesPicklist.add(new SelectOption('Event', 'Event'));
    chargesPicklist.add(new SelectOption('Byte', 'Byte'));
    chargesPicklist.add(new SelectOption('Kilobyte', 'Kilobyte'));
    chargesPicklist.add(new SelectOption('Megabyte', 'Megabyte'));
    chargesPicklist.add(new SelectOption('Gigabyte', 'Gigabyte'));
    chargesPicklist.add(new SelectOption('Terabyte', 'Terabyte'));
    chargesPicklist.add(new SelectOption('Count', 'Count'));
    chargesPicklist.add(new SelectOption('Currency', 'Currency'));
    chargesPicklist.add(new SelectOption('BITS_PER_SECOND', 'Bits/Second'));
    chargesPicklist.add(
      new SelectOption('KILOBITS_PER_SECOND', 'Kilobits/Second')
    );
    chargesPicklist.add(
      new SelectOption('MEGABITS_PER_SECOND', 'Megabits/Second')
    );
    chargesPicklist.add(
      new SelectOption('GIGABITS_PER_SECOND', 'Gigabits/Second')
    );

    formulaField.add(new SelectOption('Choose One', 'Choose One'));
    formulaField.add(new SelectOption('text01', 'text01'));
    formulaField.add(new SelectOption('text02', 'text02'));
    formulaField.add(new SelectOption('text03', 'text03'));
    formulaField.add(new SelectOption('text04', 'text04'));
    formulaField.add(new SelectOption('text05', 'text05'));
    formulaField.add(new SelectOption('number01', 'number01'));
    formulaField.add(new SelectOption('number02', 'number02'));
    formulaField.add(new SelectOption('number03', 'number03'));
    formulaField.add(new SelectOption('number04', 'number04'));
    formulaField.add(new SelectOption('number05', 'number05'));
    formulaField.add(new SelectOption('boolean01', 'boolean01'));
    formulaField.add(new SelectOption('boolean02', 'boolean02'));
    formulaField.add(new SelectOption('boolean03', 'boolean03'));
    formulaField.add(new SelectOption('boolean04', 'boolean04'));
    formulaField.add(new SelectOption('boolean05', 'boolean05'));
    formulaField.add(new SelectOption('date01', 'date01'));
    formulaField.add(new SelectOption('date02', 'date02'));
    formulaField.add(new SelectOption('date03', 'date03'));
    formulaField.add(new SelectOption('date04', 'date04'));
    formulaField.add(new SelectOption('date05', 'date05'));

    passThroughChargeList.add(new SelectOption('Choose One', 'Choose One'));
    passThroughChargeList.add(new SelectOption('number01', 'number01'));
    passThroughChargeList.add(new SelectOption('number02', 'number02'));
    passThroughChargeList.add(new SelectOption('number03', 'number03'));
    passThroughChargeList.add(new SelectOption('number04', 'number04'));
    passThroughChargeList.add(new SelectOption('number05', 'number05'));

    operationList.add(new SelectOption('Choose One', 'Choose One'));
    operationList.add(new SelectOption('Equals', '='));
    operationList.add(new SelectOption('NotEquals', '<>'));
    operationList.add(new SelectOption('GreaterThan', '>'));
    operationList.add(new SelectOption('GreaterThanEquals', '>='));
    operationList.add(new SelectOption('LessThan', '<'));
    operationList.add(new SelectOption('LessThanEquals', '<='));
    operationList.add(new SelectOption('Lookup', 'Lookup'));

    operationListAPI2.add(new SelectOption('Choose One', 'Choose One'));
    operationListAPI2.add(new SelectOption('EQUALS', '='));
    operationListAPI2.add(new SelectOption('NOT_EQUALS', '<>'));
    operationListAPI2.add(new SelectOption('GREATER_THAN', '>'));
    operationListAPI2.add(new SelectOption('GREATER_THAN_EQUALS', '>='));
    operationListAPI2.add(new SelectOption('LESS_THAN', '<'));
    operationListAPI2.add(new SelectOption('LESS_THAN_EQUALS', '<='));
    operationListAPI2.add(new SelectOption('LOOKUP', 'Lookup'));

    allowanceTypeList.add(new SelectOption('Recurring', 'Recurring'));
    allowanceTypeList.add(new SelectOption('Unlimited', 'Unlimited'));
    allowanceTypeList.add(new SelectOption('OneTime', 'One Time'));

    roleOverList.add(new SelectOption('None', 'None'));
    roleOverList.add(new SelectOption('Uncapped', 'Uncapped'));

    ChargeRulesWrapper chargeRules = new ChargeRulesWrapper();
    chargeRules.selectStatusList1 = selectStatusList;
    chargeRules.selectStatusListValue = 'Draft';
    chargeRules.productUsageRuleListValue = 'Match All Events';
    chargeRules.rateTypeList1 = rateTypeList;
    chargeRules.rateTypeListValue = 'Flat';
    chargeRules.chargesPicklist1 = chargesPicklist;
    chargeRules.chargesPicklistValue = ' ';
    chargeRules.chargesPicklistValue2 = ' ';
    chargeRules.allowanceTypeList1 = allowanceTypeList;
    chargeRules.allowanceTypeListValue = 'Recurring';
    chargeRules.roleOverList1 = roleOverList;
    chargeRules.roleOverListValue = 'None';
    chargeRules.formulaField1 = formulaField;
    chargeRules.formulaFieldValue = ' ';
    if (tract.Api_Version__c == 'API Version 2.0') {
      chargeRules.productUsageRuleList1 = productUsageRuleListAPI2;
      chargeRules.operationList1 = operationListAPI2;
    } else {
      chargeRules.productUsageRuleList1 = productUsageRuleList;
      chargeRules.operationList1 = operationList;
    }
    chargeRules.operationListValue = ' ';
    chargeRules.passThroughChargeList1 = passThroughChargeList;
    chargeRules.passThroughChargeListValue = ' ';
    chargeRules.formulaUsageRuleList = getFormulaUsageRuleSpecificationListMethod();
    chargeRules.formulaUsageRuleListValue = ' ';
    chargeRules.chargeListBytes = getchargeListBytesMethod();
    chargeRules.chargeListBytesValue = ' ';
    chargeRules.chargeCategoryList = getchargeCategoryListMethod();
    chargeRules.chargeCategoryListValue = ' ';
    chargeRules.serviceUsageRuleName = ' ';
    chargeRules.chargeValue = 0;
    chargeRules.ammountValue = 0;
    chargeRules.activityFormulaValue = ' ';
    chargeRules.prorateOnOrder = false;
    chargeRules.prorateOnCancel = false;
    return chargeRules;
  }

  private static list<SelectOption> getFormulaUsageRuleSpecificationListMethod() {
    list<SelectOption> formulaUsageRuleSpecificationList = new List<SelectOption>();
    APIDataService dataService = GTVDataService.getService();
    formulaUsageRuleSpecificationList = (list<SelectOption>) dataService.getAllGlobalUsageRule();
    return formulaUsageRuleSpecificationList;
  }

  private static list<SelectOption> getchargeListBytesMethod() {
    list<SelectOption> chargeListBytes = new List<SelectOption>();
    APIDataService dataService = GTVDataService.getService();
    chargeListBytes = (list<SelectOption>) dataService.getAllChargeBytes();
    return chargeListBytes;
  }

  private static list<selectOption> getchargeCategoryListMethod() {
    list<SelectOption> chargeCategoryList = new List<SelectOption>();
    APIDataService dataService = GTVDataService.getService();
    chargeCategoryList = (list<SelectOption>) dataService.getAllChargeCategory();
    return chargeCategoryList;
  }
  /**
   * Method to save Schedule Charges.
   * @param serviceWrapperString ChargeRulesWrapper in json format
   * @param activityProductEid
   * @param checkRuleTypeValue
   * @param oppId salesforce opportunity id
   * @return error msg
   */
  @AuraEnabled
  public static String createNewActivityChargeRule(
    string serviceWrapperString,
    String activityProductEid,
    string checkRuleTypeValue,
    String oppId
  ) {
    ChargeRulesWrapper chargeRuleWrapper = (ChargeRulesWrapper) JSON.deserialize(
      serviceWrapperString,
      ChargeRulesWrapper.class
    );
    String productUsageValue = chargeRuleWrapper.productUsageRuleListValue;
    String chargeCategoryValue = chargeRuleWrapper.chargeCategoryListValue;
    String allowanceValue = chargeRuleWrapper.allowanceTypeListValue;
    String amoutChargeSelect = chargeRuleWrapper.chargesPicklistValue2;
    String statusValue = chargeRuleWrapper.selectStatusListValue;
    String rateTypeValue = chargeRuleWrapper.rateTypeListValue;
    String selectedCharge = chargeRuleWrapper.chargesPicklistValue;
    String chargeListByteValue = chargeRuleWrapper.chargeListBytesValue;
    String chargeFormulaFieldValue = chargeRuleWrapper.formulaFieldValue;
    String passThroughListValue = chargeRuleWrapper.passThroughChargeListValue;
    String fieldvalue = chargeRuleWrapper.formulaFieldValue;
    String selectedChargeGlobal = chargeRuleWrapper.chargesPicklistValue;
    String rollOverValue = chargeRuleWrapper.roleOverListValue;
    String serviceUsageRuleName = chargeRuleWrapper.serviceUsageRuleName;
    String prorateOnOrder = String.valueOf(chargeRuleWrapper.prorateOnOrder);
    String prorateOnCancel = String.valueOf(chargeRuleWrapper.prorateOnCancel);
    Double ammountValue = chargeRuleWrapper.ammountValue;
    String activityFormulaValue = chargeRuleWrapper.activityFormulaValue;
    Decimal chargeValue = chargeRuleWrapper.chargeValue;
    OrderUsageRule__c storeUsageRuleValue = new OrderUsageRule__c();
    String eMessage = 'NoError';
    storeUsageRuleValue.ProductEid__c = activityProductEid;
    storeUsageRuleValue.ProductUsageValue__c = productUsageValue;
    storeUsageRuleValue.OpportunityID__c = oppId;
    if (productUsageValue == 'Match All Events') {
      if (null != chargeCategoryValue) {
        storeUsageRuleValue.ChargeCategoryEid__c = chargeCategoryValue;
      }
      storeUsageRuleValue.name = serviceUsageRuleName;
      storeUsageRuleValue.AllowanceType__c = allowanceValue;
      storeUsageRuleValue.UsageUom__c = amoutChargeSelect.toUpperCase();
      storeUsageRuleValue.Status__c = statusValue.toUppercase();
      storeUsageRuleValue.ProratedOnOrder__c = prorateOnOrder;
      storeUsageRuleValue.ProratedOnCancel__c = prorateOnCancel;
      storeUsageRuleValue.Limit__c = ammountValue;
      storeUsageRuleValue.RollOverType__c = rollOverValue;
      storeUsageRuleValue.RuleType__c = checkRuleTypeValue;
      storeUsageRuleValue.RateTypeValue__c = rateTypeValue;
      if (rateTypeValue == 'Flat') {
        storeUsageRuleValue.UsageRateUom__c = selectedCharge.toUppercase();
        storeUsageRuleValue.UsageRate__c = chargeValue;
      } else if (rateTypeValue == 'Table Rate') {
        storeUsageRuleValue.RateTableEid__c = chargeListByteValue;
        storeUsageRuleValue.RateTableUsageFieldName__c = chargeFormulaFieldValue;

        if (allowanceValue == 'Unlimited') {
          String uom;
          APIDataService dataService = GTVDataService.getService();
          uom = dataService.getUOMRateTable(chargeListByteValue);
          if (uom != null) {
            storeUsageRuleValue.UsageUom__c = uom.toUpperCase();
          }
        }
      } else {
        storeUsageRuleValue.RateTableUsageFieldName__c = passThroughListValue;
      }
    } else if (productUsageValue == 'Formula') {
      if (null != chargeCategoryValue) {
        storeUsageRuleValue.ChargeCategoryEid__c = chargeCategoryValue;
      }
      storeUsageRuleValue.name = serviceUsageRuleName;
      storeUsageRuleValue.FormulaFieldName__c = fieldvalue;
      storeUsageRuleValue.FormulaOperator__c = chargeRuleWrapper.operationListValue;
      storeUsageRuleValue.FormulaFieldvalue__c = activityFormulaValue;
      storeUsageRuleValue.AllowanceType__c = allowanceValue;
      if (amoutChargeSelect != 'Choose One') {
        storeUsageRuleValue.UsageUom__c = amoutChargeSelect.toUpperCase();
      }
      if (selectedChargeGlobal != 'Choose One') {
        storeUsageRuleValue.UsageUom__c = selectedChargeGlobal.toUpperCase();
      }
      storeUsageRuleValue.Status__c = statusValue.toUppercase();
      storeUsageRuleValue.ProratedOnOrder__c = prorateOnOrder;
      storeUsageRuleValue.ProratedOnCancel__c = prorateOnCancel;
      storeUsageRuleValue.Limit__c = ammountValue;
      storeUsageRuleValue.RollOverType__c = rollOverValue;
      storeUsageRuleValue.RuleType__c = checkRuleTypeValue;
      storeUsageRuleValue.RateTypeValue__c = rateTypeValue;
      if (rateTypeValue == 'Flat') {
        storeUsageRuleValue.UsageRateUom__c = selectedCharge.toUppercase();
        storeUsageRuleValue.UsageRate__c = chargeValue;
      } else if (rateTypeValue == 'Table Rate') {
        storeUsageRuleValue.RateTableEid__c = chargeListByteValue;
        storeUsageRuleValue.RateTableUsageFieldName__c = chargeFormulaFieldValue;

        if (allowanceValue == 'Unlimited') {
          String uom;
          APIDataService dataService = GTVDataService.getService();
          uom = dataService.getUOMRateTable(chargeListByteValue);
          if (uom != null) {
            storeUsageRuleValue.UsageUom__c = uom.toUpperCase();
          }
        }
      } else {
        storeUsageRuleValue.RateTableUsageFieldName__c = passThroughListValue;
      }
    } else {
      if (null != chargeCategoryValue) {
        storeUsageRuleValue.ChargeCategoryEid__c = chargeCategoryValue;
      }
      storeUsageRuleValue.GlobalUsageEid__c = chargeRuleWrapper.formulaUsageRuleListValue;
      storeUsageRuleValue.name = serviceUsageRuleName;
      storeUsageRuleValue.AllowanceType__c = allowanceValue;
      if (allowanceValue == 'Unlimited') {
        storeUsageRuleValue.UsageUom__c = selectedChargeGlobal.toUpperCase();
      } else {
        storeUsageRuleValue.UsageUom__c = amoutChargeSelect.toUpperCase();
      }
      storeUsageRuleValue.Status__c = statusValue.toUppercase();
      storeUsageRuleValue.ProratedOnOrder__c = prorateOnOrder;
      storeUsageRuleValue.ProratedOnCancel__c = prorateOnCancel;
      storeUsageRuleValue.Limit__c = ammountValue;
      storeUsageRuleValue.RollOverType__c = rollOverValue;
      storeUsageRuleValue.RuleType__c = checkRuleTypeValue;
    }
    insert storeUsageRuleValue;
    return eMessage;
  }
  /**
   * Method to delete Charge Rule.
   * @param chargeId charges rule id
   */
  @AuraEnabled
  public static void deleteChargeRule(String chargeId) {
    if (null != chargeId) {
      List<OrderUsageRule__c> chargeList = [
        SELECT Id
        FROM OrderUsageRule__c
        WHERE id = :chargeId
      ];
      if (chargeList.size() > 0) {
        if (TRACT3__OrderUsageRule__c.sObjectType.getDescribe().isDeletable()) {
          delete chargeList;
        }
      }
    }
  }
  /**
   * Method to create Order.
   * @param opportunityId salesforce opportunity id
   * @return error msg
   */
  @AuraEnabled
  public static String createOrderApex(String opportunityId) {
    String terrorMessage = 'NoError';
    TRACT_Setup__c tract;
    try {
      tract = [
        SELECT
          id,
          Tract_User_Name__c,
          TPassword__c,
          TRACT_URL__c,
          Active__c,
          OrderStatus__c
        FROM TRACT_Setup__c
        WHERE Active__c = TRUE
        LIMIT 1
      ];
    } catch (Exception e) {
      terrorMessage = 'Unable to find TRACT Configuration details. Please ask your Administrator to Setup the TRACT Configuration.';
      return terrorMessage;
    }
    if (tract == null) {
      terrorMessage = 'Unable to find TRACT Configuration details. Please ask your Administrator to Setup the TRACT Configuration.';
      return terrorMessage;
    }
    Opportunity thisOpp = [
      SELECT
        Id,
        Name,
        Account.Name,
        Amount,
        CloseDate,
        Description,
        Owner.Name,
        TotalOpportunityQuantity,
        Probability,
        StageName,
        Type,
        Campaign.Name,
        LeadSource,
        NextStep,
        Tract_Sales_Order__c,
        Pricebook2Id,
        Account.Tract_Billing_Account__c,
        ExpectedRevenue,
        FiscalQuarter,
        Fiscal,
        FiscalYear,
        ForecastCategory,
        ForecastCategoryName,
        LastActivityDate,
        Order_Date__c,
        GTV_Order_Type__c,
        IsWon,
        IsDeleted,
        IsClosed,
        HasOpportunityLineItem,
        Billing_Account__c,
        AccountId
      FROM Opportunity
      WHERE id = :opportunityId
    ];

    if (thisOpp.Pricebook2Id == null) {
      terrorMessage = 'Please enter Pricebook, and try again.';
      return terrorMessage;
    }
    if (
      thisOpp.AccountId == null ||
      zconvert.ToString(thisOpp.AccountId) == 'NA'
    ) {
      terrorMessage = 'Please enter Account, and try again.';
      return terrorMessage;
    }

    Account acc = [
      SELECT id, Tract_Billing_Account__c
      FROM Account
      WHERE Id = :thisOpp.AccountId
    ];

    APIDataService dataService = GTVDataService.getService();
    TRACTAccountWrapper sfdcBillingAccount = dataService.getBillingAccount(
      acc.id
    );
    String accountEid = sfdcBillingAccount.eid;

    if (
      acc.Tract_Billing_Account__c == null ||
      acc.Tract_Billing_Account__c == ''
    ) {
      terrorMessage = 'Opportunity is not having a TRACT Billing Account';
      return terrorMessage;
    }
    try {
      if (thisOpp.Pricebook2Id != null) {
        List<pricebook2> pb2 = [
          SELECT id, CurrencyType__c, name
          FROM pricebook2
          WHERE id = :thisOpp.Pricebook2Id
          LIMIT 1
        ];
        if (pb2[0].name != null && pb2[0].name != '') {
          List<String> str_List = (pb2[0].name).split(' ');
          if (
            str_List.size() == 4 &&
            str_List[0] == 'GTV' &&
            str_List[2] == 'Price' &&
            str_List[3] == 'Book' &&
            str_List[1].length() == 3
          ) {
            Set<String> uniqueNames = new Set<String>();

            Map<String, OpportunityLineItem> eidOLIMap = new Map<String, OpportunityLineItem>();

            OpportunityLineItem[] opLI = [
              SELECT
                eid__c,
                Service_Resource__c,
                minServiceResources__c,
                username__c,
                firstname__c,
                lastname__c,
                Email__c,
                New_Service_Resource__c,
                RecurringPrice__c,
                PricebookEntryId,
                Existing_Service__c,
                quantity,
                Existing_Service_Eid__c
              FROM OpportunityLineItem
              WHERE opportunityId = :thisOpp.Id
              LIMIT 50000
            ];

            if (opLI.size() == 0) {
              terrorMessage = 'Cannot create an order with 0 products';
              return terrorMessage;
            }
            if (thisOpp.GTV_Order_Type__c == 'Order') {
              List<OpportunityLineItem> existingOLI = new List<OpportunityLineItem>();
              for (OpportunityLineItem oli : opLI) {
                if (oli.Existing_Service__c) {
                  existingOLI.add(oli);
                }
              }
              if (existingOLI.size() > 0) {
                String msg = updateQuantityInTract(tract, existingOLI);
                if (msg != 'NoError') {
                  return msg;
                }
              }
              String[] tractProdEid = new List<String>();
              for (OpportunityLineItem tempOPLI : opLI) {
                if (
                  !(tempOPLI.eid__c == null ||
                  tempOPLI.eid__c == '' ||
                  tempOPLI.Existing_Service__c == true)
                ) {
                  tractProdEid.add(tempOPLI.eid__c);
                }
                eidOLIMap.put(tempOPLI.eid__c, tempOPLI);
              }
              Product2[] tractProducts = [
                SELECT
                  eid__c,
                  IsActive,
                  PriceOverride__c,
                  Requires_Agreement__c,
                  name,
                  minServiceResources__c,
                  ProductCode
                FROM Product2
                WHERE eid__c = :tractProdEid
                LIMIT 50000
              ];
              if (tractProducts.size() > 0) {
                for (Product2 tempTractProducts : tractProducts) {
                  //ErrorMessage = 'Unable to Place the TRACT Sales order. Please select an Agreement for Opportunity Line Item :'+  cc.Service_Resource__c+'.sgsg ';
                  OpportunityLineItem currentOLI = eidOLIMap.get(
                    tempTractProducts.eid__c
                  );

                  if (
                    currentOLI.Service_Resource__c == null &&
                    currentOLI.New_Service_Resource__c == null &&
                    currentOLI.minServiceResources__c > 0
                  ) {
                    terrorMessage =
                      'Unable to Place the TRACT Sales order. Please select Service Resource' +
                      'for the Opportunity Line Item :' +
                      tempTractProducts.name +
                      '. ';
                    return terrorMessage;
                  }
                  if (!tempTractProducts.IsActive) {
                    terrorMessage =
                      'Unable to Place the TRACT Sales order.' +
                      ' Support for Opportunity Line Item :' +
                      tempTractProducts.name +
                      ' have been Stopped. ';
                    return terrorMessage;
                  }

                  if (tempTractProducts.ProductCode == 'TRACT_SUBSCRIPTION') {
                    if (
                      currentOLI.username__c == null ||
                      currentOLI.Email__c == null ||
                      currentOLI.firstname__c == null ||
                      currentOLI.lastname__c == null ||
                      currentOLI.username__c == '' ||
                      currentOLI.Email__c == '' ||
                      currentOLI.firstname__c == '' ||
                      currentOLI.lastname__c == ''
                    ) {
                      terrorMessage =
                        'Unable to Place the TRACT Sales order.' +
                        ' Please provide complete TRACT Administrator Information for' +
                        ' Opportunity Line Item :' +
                        tempTractProducts.name +
                        '. ';
                      return terrorMessage;
                    }
                  }
                }

                if (
                  tract.OrderStatus__c != null &&
                  tract.OrderStatus__c.equals('DRAFT')
                ) {
                  try {
                    Map<String, String> orderInformation = getInformation(
                      thisOpp,
                      acc,
                      tract,
                      accountEid
                    );
                    dataService.tractCreateDraftOrder(orderInformation);
                    terrorMessage = orderInformation.get('ErrorMessage');
                  } catch (Exception e) {
                    terrorMessage = e.getmessage();
                    return terrorMessage;
                  }
                } else {
                  try {
                    Map<String, String> orderInformation = getInformation(
                      thisOpp,
                      acc,
                      tract,
                      accountEid
                    );
                    dataService.tractCreateSalesOrder(orderInformation);
                    terrorMessage = orderInformation.get('ErrorMessage');
                  } catch (Exception e) {
                    terrorMessage =
                      e.getCause() +
                      String.valueOf(e.getLineNumber()) +
                      e.getStackTraceString() +
                      e.getTypeName();
                    return terrorMessage;
                  }
                }
              }
            } else {
              try {
                GTVRESTDataService restService = new GTVRESTDataService();
                restService.createChangeOrderRequestInGTV(opportunityId);
              } catch (Exception e) {
                terrorMessage = e.getmessage();
                return terrorMessage;
              }
            }
          }
        }
      }
    } catch (MyException ex) {
      terrorMessage = ex.getmessage();
      return terrorMessage;
    }
    return terrorMessage;
  }

  private static String updateQuantityInTract(
    TRACT_Setup__c tract,
    List<OpportunityLineItem> existingOLI
  ) {
    String eMessage = 'NoError';
    try {
      APIDataService dataService = GTVDataService.getService();
      dataService.updateQuantityAddProduct(existingOLI);
    } catch (Exception e) {
      eMessage = string.valueof(e.getmessage() + e.getLineNumber());
      eMessage = eMessage.substringBetween(
        'Web service callout failed: WebService returned a SOAP Fault:',
        ' faultcode=soap:Server faultactor='
      );
    }
    return eMessage;
  }
  /**
   * Method to check Existing Service Resource.
   * @param srId service resource id
   * @return error msg
   */
  @AuraEnabled
  public static String checkExistingServiceResource(String srId) {
    String eMessage = 'NoError';
    APIDataService dataService = GTVDataService.getService();
    eMessage = dataService.checkExistingServicesource(srId);
    return eMessage;
  }
  /**
   * Method to get Information account and order details from GTV
   * @param accountEid tract account id
   * @param TRACT_Setup__c tract configuration setting
   * @param Account salesforce account
   * @param thisOpp salesforce opportunity
   * @return map [key:field api name,value:value from tract db]
   */
  @TestVisible
  public static Map<String, String> getInformation(
    Opportunity thisOpp,
    Account acc,
    TRACT_Setup__c tract,
    String accountEid
  ) {
    Map<String, String> information = new Map<String, String>{
      'ErrorMessage' => 'NoError',
      'orderFromLightning' => 'true',
      'OpportunityId' => zConvert.ToString(thisOpp.Id),
      'AccountId' => zConvert.ToString(thisOpp.AccountId),
      'Amount' => zConvert.ToString(thisOpp.Amount),
      'CampaignId' => zConvert.ToString(thisOpp.CampaignId),
      'CloseDate' => zConvert.ToString(thisOpp.CloseDate),
      'Description' => zConvert.ToString(thisOpp.Description),
      'ExpectedRevenue' => zConvert.ToString(thisOpp.ExpectedRevenue),
      'Fiscal' => zConvert.ToString(thisOpp.Fiscal),
      'FiscalQuarter' => zConvert.ToString(thisOpp.FiscalQuarter),
      'FiscalYear' => zConvert.ToString(thisOpp.FiscalYear),
      'ForecastCategory' => zConvert.ToString(thisOpp.ForecastCategory),
      'ForecastCategoryName' => zConvert.ToString(thisOpp.ForecastCategoryName),
      'HasOpportunityLineItem' => zConvert.ToString(
        thisOpp.HasOpportunityLineItem
      ),
      'IsClosed' => zConvert.ToString(thisOpp.IsClosed),
      'IsDeleted' => zConvert.ToString(thisOpp.IsDeleted),
      'IsWon' => zConvert.ToString(thisOpp.IsWon),
      'LastActivityDate' => zConvert.ToString(thisOpp.LastActivityDate),
      'LeadSource' => zConvert.ToString(thisOpp.LeadSource),
      'Name' => zConvert.ToString(thisOpp.Name),
      'NextStep' => zConvert.ToString(thisOpp.NextStep),
      'OwnerId' => zConvert.ToString(thisOpp.OwnerId),
      'Pricebook2Id' => zConvert.ToString(thisOpp.Pricebook2Id),
      'Probability' => zConvert.ToString(thisOpp.Probability),
      'StageName' => zConvert.ToString(thisOpp.StageName),
      'TotalOpportunityQuantity' => zConvert.ToString(
        thisOpp.TotalOpportunityQuantity
      ),
      'Type' => zConvert.ToString(thisOpp.Type),
      'TRACT_APP__Tract_User_Name__c' => tract.Tract_User_Name__c,
      'TRACT_APP__Tract_Password__c' => tract.TPassword__c,
      'TRACT_APP__TPassword__c' => tract.TPassword__c,
      'TRACT_APP__TRACT_URL__c' => tract.TRACT_URL__c,
      'BillingAccounteid' => accountEid,
      'BillingAccountNum' => acc.Tract_Billing_Account__c,
      'OrderDate' => zConvert.ToString(thisOpp.Order_Date__c)
    };
    return information;
  }

  /**
   * Method to get opp Product List.
   * @param opportunityId salesforce opportunity ID
   * @return OpportunityLineItem[]
   */
  @AuraEnabled
  public static OpportunityLineItem[] getOppProductListApex(
    String opportunityId
  ) {
    OpportunityLineItem[] opLI = [
      SELECT eid__c, Name, Service__c, ServiceName__c, product2.Name
      FROM OpportunityLineItem
      WHERE opportunityId = :opportunityId
      LIMIT 50000
    ];
    return opLI;
  }
  /**
   * Method to get opp Product List.
   * @param opportunityId salesforce opportunity ID
   * @return OpportunityLineItem[]
   */
  @AuraEnabled
  public static OpportunityLineItem[] getOppProductListApex1(
    String opportunityId
  ) {
    OpportunityLineItem[] opLI1 = [
      SELECT eid__c, Name, Service__c, ServiceName__c, product2.Name
      FROM OpportunityLineItem
      WHERE opportunityId = :opportunityId
      LIMIT 50000
    ];
    return opLI1;
  }
  /**
   * Method to get opp Product List.
   * @param oppProduct salesforce OpportunityLineItem
   * @param opportunityId salesforce opportunity ID
   * @return OpportunityLineItem[]
   */
  @AuraEnabled
  public static OpportunityLineItem[] removeOppProductApex(
    OpportunityLineItem oppProduct,
    String opportunityId
  ) {
    if (oppProduct != null) {
      delete oppProduct;
    }
    OpportunityLineItem[] opLI = [
      SELECT eid__c, Name, ServiceName__c, product2.Name
      FROM OpportunityLineItem
      WHERE opportunityId = :opportunityId
      LIMIT 50000
    ];
    return opLI;
  }
  /**
   * Method to get opp Product List.
   * @param productWrapperList List<Product2AddWrapper> in json format
   * @param productEid tract product id
   * @param oppId salesforce opportunity ID
   * @return List<Product2AddWrapper>
   */
  @AuraEnabled
  public static List<Product2AddWrapper> getParentServices(
    String oppId,
    String productEid,
    String productWrapperList
  ) {
    system.debug('oppId:::::' + oppId);
    system.debug('productEid:::::' + productEid);
    system.debug('productWrapperList:::::' + productWrapperList);
    List<Product2AddWrapper> productWrapperLists = (List<Product2AddWrapper>) JSON.deserialize(
      productWrapperList,
      List<Product2AddWrapper>.class
    );
    set<String> setOfParentId = new Set<String>();
    List<Product2AddWrapper> parentServiceList = new List<Product2AddWrapper>();
    APIDataService dataService = GTVDataService.getService();
    if (productEid != null) {
      setOfParentId = dataService.getRelatedProductIdSet(productEid);
      System.debug('setOfParentId:::::::' + setOfParentId);
      if (null != setOfParentId && setOfParentId.size() > 0) {
        for (Product2AddWrapper productsPop : productWrapperLists) {
          if (setOfParentId.contains(productsPop.prod.eid__c)) {
            //if(productsPop.prod.ProductCode == 'Subscription'){
            parentServiceList.add(productsPop);
            //}
          }
        }
        OpportunityLineItem[] opLI = [
          SELECT
            id,
            Name,
            ServiceName__c,
            product2.Name,
            product2.eid__c,
            product2.Id,
            product2.ProductCode
          FROM OpportunityLineItem
          WHERE opportunityId = :oppId
          LIMIT 50000
        ];
        for (OpportunityLineItem oli : opLI) {
          if (setOfParentId.contains(oli.product2.eid__c)) {
            //if(oli.product2.ProductCode == 'Subscription'){
            /*Product2AddWrapper productsPop = new Product2AddWrapper();
                            productsPop.prod = new product2();
                            productsPop.prod.Id = oli.product2.Id;
                            productsPop.prod.Name = oli.product2.Name;
                            parentServiceList.add(productsPop);*/
            // }
          }
        }

        Opportunity opp = [
          SELECT id, Name, AccountId
          FROM Opportunity
          WHERE id = :oppId
          LIMIT 1
        ];

        List<Account> accList = [
          SELECT name, id, Tract_Billing_Account__c
          FROM Account
          WHERE id = :opp.AccountId
          LIMIT 1
        ];

        List<Service__c> servicesList = new List<Service__c>();
        if (accList[0] != null && accList[0].Tract_Billing_Account__c != null) {
          TractServiceWrapper serviceWrapperObj = dataService.getServiceByBillingAccount(
            accList
          );
          servicesList = serviceWrapperObj.serviceList;
        }
        if (servicesList != null && servicesList.size() > 0) {
          for (Service__c srv : servicesList) {
            if (setOfParentId.contains(srv.ProductEid__c)) {
              String convertedDate = '';
              String shortDescription = '';
              if (null != srv.StatusDate__c) {
                convertedDate = ' Start Date: ' + srv.StatusDate__c.format();
              }
              if (srv.ServiceProductName__c != srv.Name) {
                shortDescription = ' - ' + srv.Name;
              }
              Product2AddWrapper productsPop = new Product2AddWrapper();
              productsPop.prod = new product2();
              productsPop.parentServiceEId = srv.ServiceEid__c;
              productsPop.prod.Name =
                srv.ServiceProductName__c +
                shortDescription +
                convertedDate;
              parentServiceList.add(productsPop);
            }
          }
        }
      }
    }
    return parentServiceList;
  }
  /**
   * Method to get Related Product Name List.
   * @param productEid tract product id
   * @return list of related product
   */
  @AuraEnabled
  public static list<String> getRelatedProductNameList(String productEid) {
    list<String> listOfParentName = new List<String>();
    if (productEid != null) {
      APIDataService dataService = GTVDataService.getService();
      listOfParentName = dataService.getRelatedProductNameByProductCode(
        productEid
      );
    }
    return listOfParentName;
  }

  @AuraEnabled
  public static Boolean changeOrderIndicator(String opportunityId) {
    boolean result = false;
    try {
      List<TRACT_Setup__c> tractList = new List<TRACT_Setup__c>();
      tractList = [
        SELECT
          id,
          TPassword__c,
          Selected_Marketplace_Id__c,
          Tract_User_Name__c,
          TRACT_URL__c,
          Api_Version__c,
          Active__c,
          TRACT_URL2_0__c,
          Gotransverse_Sync_Type__c,
          X_API_Key__c,
          OrderStatus__c,
          Mapped_Custom_Field_Id__c,
          Batch_Triggered__c,
          Gotransverse_Hosted_Payment_URL__c,
          Change_Order_Indicator__c,
          Change_Order_Indicator_Value__c
        FROM TRACT_Setup__c
        WHERE Active__c = TRUE
        LIMIT 1
      ];
      if (
        tractList.size() > 0 &&
        tractList[0].Change_Order_Indicator__c != null &&
        tractList[0].Change_Order_Indicator_Value__c != null
      ) {
        String queryString = 'Select ';
        SObjectType opportunityType = Schema.getGlobalDescribe()
          .get('Opportunity');
        Map<String, Schema.SObjectField> oppFields = opportunityType.getDescribe()
          .fields.getMap();
        String fieldType = oppFields.get(tractList[0].Change_Order_Indicator__c)
          .getDescribe()
          .getType()
          .Name();
        for (string fieldName : oppFields.keySet()) {
          queryString += fieldName + ',';
        }
        String queryString2 = queryString.removeEnd(',');
        queryString2 +=
          ' from Opportunity where id=\'' +
          String.escapeSingleQuotes(opportunityId) +
          '\'';
        Opportunity opp = Database.query(queryString2);
        if (
          fieldType == 'Boolean' &&
          opp.get(tractList[0].Change_Order_Indicator__c) ==
          Boolean.valueOf(tractList[0].Change_Order_Indicator_Value__c)
        ) {
          result = true;
          opp.GTV_Order_Type__c = 'Change Order';
          update opp;
        } else if (
          fieldType == 'Date' &&
          opp.get(tractList[0].Change_Order_Indicator__c) ==
          Date.valueOf(tractList[0].Change_Order_Indicator_Value__c)
        ) {
          result = true;
          opp.GTV_Order_Type__c = 'Change Order';
          update opp;
        } else if (
          fieldType == 'DateTime' &&
          opp.get(tractList[0].Change_Order_Indicator__c) ==
          DateTime.valueOf(tractList[0].Change_Order_Indicator_Value__c)
        ) {
          result = true;
          opp.GTV_Order_Type__c = 'Change Order';
          update opp;
        } else if (
          fieldType == 'Integer' &&
          opp.get(tractList[0].Change_Order_Indicator__c) ==
          Integer.valueOf(tractList[0].Change_Order_Indicator_Value__c)
        ) {
          result = true;
          opp.GTV_Order_Type__c = 'Change Order';
          update opp;
        } else if (
          fieldType == 'Double' &&
          opp.get(tractList[0].Change_Order_Indicator__c) ==
          Double.valueOf(tractList[0].Change_Order_Indicator_Value__c)
        ) {
          result = true;
          opp.GTV_Order_Type__c = 'Change Order';
          update opp;
        } else if (
          fieldType == 'Currency' &&
          opp.get(tractList[0].Change_Order_Indicator__c) ==
          Integer.valueOf(tractList[0].Change_Order_Indicator_Value__c)
        ) {
          result = true;
          opp.GTV_Order_Type__c = 'Change Order';
          update opp;
        } else if (
          opp.get(tractList[0].Change_Order_Indicator__c) ==
          tractList[0].Change_Order_Indicator_Value__c
        ) {
          result = true;
          opp.GTV_Order_Type__c = 'Change Order';
          update opp;
        } else {
          opp.GTV_Order_Type__c = 'Order';
          update opp;
        }
      }
    } catch (Exception ex) {
    }

    return result;
  }

  @AuraEnabled
  public static GTVServiceListWrapper getActiveServiceList(
    String opportunityId
  ) {
    GTVServiceListWrapper serviceWrapper = new GTVServiceListWrapper();
    serviceWrapper.errorMessage = 'No Error';
    try {
      String pricebook2Id;
      Opportunity opp = [
        SELECT
          id,
          Name,
          Tract_Sales_Order__c,
          Pricebook2Id,
          account.Tract_Billing_Account__c,
          account.Currency_Type__c,
          (SELECT id FROM opportunityLineItems)
        FROM Opportunity
        WHERE id = :opportunityId
      ];
      if (opp.Tract_Sales_Order__c != null) {
        serviceWrapper.errorMessage = 'This opportunity has already been moved in GTV';
        return serviceWrapper;
      }
      if (
        opp.AccountId == null ||
        opp.Account.Tract_Billing_Account__c == null
      ) {
        serviceWrapper.errorMessage = 'No BillingAccount is  selected for this Opportunity. Please select a BillingAccount first.';
        return serviceWrapper;
      }
      if (opp.OpportunityLineItems.size() > 0) {
        serviceWrapper.errorMessage = 'An Opportunity product has already been added to this opportunity. Please remove the existing product and try again.';
        return serviceWrapper;
      }

      for (Pricebook2 pricebook : [SELECT id, Name FROM Pricebook2]) {
        if (pricebook.Name.contains(opp.Account.Currency_Type__c)) {
          pricebook2Id = pricebook.Id;
          break;
        }
      }

      if (pricebook2Id == null) {
        serviceWrapper.errorMessage = 'No Price book is selected for this Opportunity. Please select a Price book first.';
        return serviceWrapper;
      }

      serviceWrapper.currencyCode = opp.account.Currency_Type__c;
      GTVRESTDataService restDataService = new GTVRESTDataService();
      serviceWrapper.serviceList = restDataService.queryAllActiveAccountServices(
        opp.account.Tract_Billing_Account__c,
        opp.account.Currency_Type__c
      );
      system.debug('gtvServiceWrapList::::' + serviceWrapper.serviceList);

      opp.Pricebook2Id = pricebook2Id;
      update opp;
      return serviceWrapper;
    } catch (Exception ex) {
      system.debug('Error:::' + ex.getMessage());
      serviceWrapper.errorMessage = ex.getMessage();
      return serviceWrapper;
    }
  }

  @AuraEnabled
  public static string createOppLineItem(
    string changeOrderWrapper,
    string opportunityId
  ) {
    string errorMessage = 'No Error';
    system.debug('changeOrderWrapper:::' + changeOrderWrapper);
    try {
      Opportunity thisOpp = [
        SELECT Id, Name, Pricebook2Id
        FROM Opportunity
        WHERE id = :opportunityId
      ];
      map<id, id> pricebookentryMap = new Map<id, id>();
      for (PriceBookEntry pbe : [
        SELECT Id, Product2.Id, Pricebook2Id, Product2.Name, Product2Id
        FROM PriceBookEntry
        WHERE Pricebook2Id = :thisOpp.Pricebook2Id
        LIMIT 50000
      ]) {
        pricebookentryMap.put(pbe.Product2Id, pbe.id);
      }
      CreateChangeOrderWrapper changeOrderWrapp = (CreateChangeOrderWrapper) JSON.deserialize(
        changeOrderWrapper,
        CreateChangeOrderWrapper.class
      );
      OpportunityLineItem oppOLI = new OpportunityLineItem();
      oppOLI.RecurringPrice__c = changeOrderWrapp.recurringprice;
      oppOLI.RecurringProductPriceEid__c = changeOrderWrapp.recurringpriceId;
      oppOLI.OneTimePrice__c = changeOrderWrapp.oneTimePrice;
      oppOLI.OneTimeProductPriceEid__c = changeOrderWrapp.oneTimePriceId;
      oppOLI.overrideAgreementEndDate__c = changeOrderWrapp.overrideAgreementEndDate;
      oppOLI.Agreement_Name__c = changeOrderWrapp.agreementName;
      oppOLI.Agreement_Period__c = changeOrderWrapp.agreementPeriod;
      oppOLI.agreementEndAction__c = changeOrderWrapp.agreementEndAction;
      oppOLI.Gotransverse_NextAgreementEndAction__c = changeOrderWrapp.nextAgreementEndAction;
      oppOLI.Applied_Agreement_Eid__c = changeOrderWrapp.agreementId;
      oppOLI.GTV_Renewal_Price__c = changeOrderWrapp.renewalPrice;
      oppOLI.GTV_Next_Renewal_Price__c = changeOrderWrapp.nextRenewalPrice;
      oppOLI.ProductID__c = changeOrderWrapp.currentProductId;
      oppOLI.priceList_Eid__c = changeOrderWrapp.priceListId;
      oppOLI.quantity = changeOrderWrapp.quantity;
      oppOLI.ServiceName__c = changeOrderWrapp.originalServiceName;
      oppOLI.Email_Reciept__c = changeOrderWrapp.emailReciept;
      oppOLI.Existing_Service_Eid__c = changeOrderWrapp.currentServiceId;
      oppOLI.ServiceDate = Date.valueOf(changeOrderWrapp.orderDate);
      oppOLI.PricebookEntryId = pricebookentryMap.get(
        changeOrderWrapp.mapofProductIdVsProduct.get(
            changeOrderWrapp.currentProductId
          )
          .id
      );
      oppOLI.TotalPrice = changeOrderWrapp.totalPrice;
      oppOLI.opportunityId = opportunityId;
      Map<String, list<ProductPriceRangeWrapper>> mapOfProductPriceEidVsPriceRangeList = changeOrderWrapp.mapOfProductPriceEidVsPriceRangeList;
      List<ProductPriceRangeWrapper> recurringPriceRangeList = mapOfProductPriceEidVsPriceRangeList.get(
        changeOrderWrapp.recurringpriceId
      );
      oppOLI.GTV_Recurring_Price_Range_Information__c = JSON.serialize(
        recurringPriceRangeList
      );
      if (changeOrderWrapp.oneTimePriceId != null) {
        List<ProductPriceRangeWrapper> oneTimePriceRangeList = mapOfProductPriceEidVsPriceRangeList.get(
          changeOrderWrapp.oneTimePriceId
        );
        oppOLI.GTV_OneTime_Price_Range_Information__c = JSON.serialize(
          oneTimePriceRangeList
        );
      }
      insert oppOLI;
    } catch (Exception ex) {
      errorMessage = ex.getMessage();
    }
    return errorMessage;
  }

  String terrorMessage = 'NoError';
  public class ProductListWrapper {
    @AuraEnabled
    public String errorMessage { get; set; }
    @AuraEnabled
    public List<Product2Wrapper> product2WrapperList { get; set; }
    @AuraEnabled
    public List<Product2AddWrapper> product2addWrapperList { get; set; }
  }
  public class Product2Wrapper {
    @AuraEnabled
    public boolean isSelected { get; set; }
    @AuraEnabled
    public product2 prod { get; set; }
    @AuraEnabled
    public String errorMessage { get; set; }
  }
  /*public class Agreementwrapper{
        @AuraEnabled
        public list<SelectOption> agreementList{get;set;}
        @AuraEnabled
        public list<SelectOption> renewAction{get;set;}
        @AuraEnabled
        public Map<String,Decimal> mapOfAgreementPeriod{get;set;}
        @AuraEnabled
        public Map<String,String> mapOfAgreementPeriodType{get;set;}
    }*/

  //Wrapper Class To Show the Addedproducts
  /* public class Product2AddWrapper{
        @AuraEnabled
        public product2 prod{get;set;}
        @AuraEnabled
        public String oppId{get;set;}
        @AuraEnabled
        public String ProductEid{get;set;}
        @AuraEnabled
        public String RuleType{get;set;}
        @AuraEnabled
        public Boolean scheduleChargeEnable{get;set;}
        @AuraEnabled
        public Boolean DisableRecurring{get;set;}
        @AuraEnabled
        public Boolean oneTimeChargeEnable{get;set;}
        @AuraEnabled
        public Boolean Disableonetime{get;set;}
        @AuraEnabled
        public decimal recurringprice{get;set;}
        @AuraEnabled
        public decimal oneTimePrice{get;set;}
        @AuraEnabled
        public decimal maxServiceResource{get;set;}
        @AuraEnabled
        public decimal minServiceResource{get;set;}
        @AuraEnabled
        public boolean ruleOverride{get;set;}
        @AuraEnabled
        public Integer quantity{get;set;}
        @AuraEnabled
        public map<String, decimal> IdAndPriceValueMap{get;set;}
        @AuraEnabled
        public map<String, String> IdAndEidMapOneTime{get;set;}
        @AuraEnabled
        public map<String, String> IdAndEidMap{get;set;}
        @AuraEnabled
        public List<SelectOption> productPriceList{get;set;}
        @AuraEnabled
        public String priceListValue{get;set;}
        @AuraEnabled
        public String priceListValue1{get;set;}
        @AuraEnabled
        public List<SelectOption> RecurrenceoptList{get;set;}
        @AuraEnabled
        public String RecurrencPer{get;set;}
        @AuraEnabled
        public String RecurrencPerValue{get;set;}
        @AuraEnabled
        public String discountName{get;set;}
        @AuraEnabled
        public String discountEid{get;set;}
        @AuraEnabled
        public String newServiceResource{get;set;}
        @AuraEnabled
        public String serviceResourceName{get;set;}
        @AuraEnabled
        public String serviceResourceEid{get;set;}
        @AuraEnabled
        public String errorMessage{get;set;}
        @AuraEnabled
        public String oliId{get;set;}
        @AuraEnabled
        public List<String> pricebookNames{get;set;}
        @AuraEnabled
        public opportunityLineItem OLineItem{get;set;} 
        @AuraEnabled
        public String agreementEndAction{get;set;}
        @AuraEnabled
        public Date overrideAgreementEndDate{get;set;} 
        @AuraEnabled
        public String  agreementId{get;set;} 
        @AuraEnabled
        public String service{get;set;} 
        @AuraEnabled
        public String parentServiceEId{get;set;} 
        @AuraEnabled
        public Decimal agreementPeriod{get;set;} 
        @AuraEnabled 
        public List<ScheduleChargeWrapper> scheduleChargeList{get;set;} 
        @AuraEnabled 
        public List<ServiceCustomFieldValuesWrapper> serviceCustomFieldValueList{get;set;} 
        
        public Product2AddWrapper(){
            priceListValue = ' ';
            priceListValue1 = ' ';
            RecurrencPer = ' ';
            discountName = ' ';
            discountEid = ' ';
            newServiceResource = ' ';
            serviceResourceName = ' ';
            serviceResourceEid = ' ';
            RecurrencPerValue = ' ';
            oliId = ' ';
            parentServiceEId = ' ';
            quantity = 1;
            OLineItem = new opportunityLineItem();
            IdAndPriceValueMap = new map<String, decimal>();
            IdAndEidMapOneTime = new map<String, string>();
            IdAndEidMap = new map<String, string>();
            scheduleChargeList = new List<ScheduleChargeWrapper>();
            serviceCustomFieldValueList = new List<ServiceCustomFieldValuesWrapper>();
        }
    }
    
    public class ServiceCustomFieldValuesWrapper{
        @AuraEnabled
        public String Name{get;set;}
        @AuraEnabled
        public String Eid{get;set;}
        @AuraEnabled
        public String Value{get;set;}
        @AuraEnabled
        public List<SelectOption> ServiceListType{get;set;}
        @AuraEnabled
        public String ServiceListTypeValue{get;set;}
        @AuraEnabled
        public Boolean checkListtype{get;set;}
        @AuraEnabled
        public Boolean datetype{get;set;}
        @AuraEnabled
        public String dateField{get;set;}
        @AuraEnabled
        public String fieldValidationType{get; set;}
        
    }*/

  //Wrapper Class To Show the Product uses Rule
  /*public class ProductUsesWrapper{
        @AuraEnabled
        public String ChargeName{get;set;}
        @AuraEnabled
        public String ChargeType{get;set;}
        @AuraEnabled
        public String Rule{get;set;}     
        @AuraEnabled
        public String UsageRuleEid{get;set;}
        @AuraEnabled
        public String ChargeCategory{get;set;}
        @AuraEnabled
        public String Taper{get;set;}
        @AuraEnabled
        public String Rate{get;set;}
        @AuraEnabled
        public String FromDate{get;set;}
        @AuraEnabled
        public String ThruDate{get;set;}
        @AuraEnabled
        public String Status{get;set;}
        @AuraEnabled
        public String recordId {get; set;}
    }*/

  public class ChargeRulesWrapper {
    @AuraEnabled
    public list<SelectOption> selectStatusList1 { get; set; }
    @AuraEnabled
    public String selectStatusListValue { get; set; }
    @AuraEnabled
    public list<SelectOption> productUsageRuleList1 { get; set; }
    @AuraEnabled
    public String productUsageRuleListValue { get; set; }
    @AuraEnabled
    public list<SelectOption> rateTypeList1 { get; set; }
    @AuraEnabled
    public String rateTypeListValue { get; set; }
    @AuraEnabled
    public list<SelectOption> chargesPicklist1 { get; set; }
    @AuraEnabled
    public String chargesPicklistValue { get; set; }
    @AuraEnabled
    public String chargesPicklistValue2 { get; set; }
    @AuraEnabled
    public list<SelectOption> allowanceTypeList1 { get; set; }
    @AuraEnabled
    public String allowanceTypeListValue { get; set; }
    @AuraEnabled
    public list<SelectOption> roleOverList1 { get; set; }
    @AuraEnabled
    public String roleOverListValue { get; set; }
    @AuraEnabled
    public list<SelectOption> formulaField1 { get; set; }
    @AuraEnabled
    public String formulaFieldValue { get; set; }
    @AuraEnabled
    public list<SelectOption> operationList1 { get; set; }
    @AuraEnabled
    public String operationListValue { get; set; }
    @AuraEnabled
    public list<SelectOption> passThroughChargeList1 { get; set; }
    @AuraEnabled
    public String passThroughChargeListValue { get; set; }
    @AuraEnabled
    public list<SelectOption> formulaUsageRuleList { get; set; }
    @AuraEnabled
    public String formulaUsageRuleListValue { get; set; }
    @AuraEnabled
    public list<SelectOption> chargeListBytes { get; set; }
    @AuraEnabled
    public String chargeListBytesValue { get; set; }
    @AuraEnabled
    public list<SelectOption> chargeCategoryList { get; set; }
    @AuraEnabled
    public String chargeCategoryListValue { get; set; }
    @AuraEnabled
    public String serviceUsageRuleName { get; set; }
    @AuraEnabled
    public Decimal chargeValue { get; set; }
    @AuraEnabled
    public Double ammountValue { get; set; }
    @AuraEnabled
    public String activityFormulaValue { get; set; }
    @AuraEnabled
    public Boolean prorateOnOrder { get; set; }
    @AuraEnabled
    public Boolean prorateOnCancel { get; set; }
  }
  /*public class ScheduleChargeWrapper {
    @AuraEnabled 
    public String ChargeType{get;set;}
    @AuraEnabled 
    public String ProductId{get;set;}
    @AuraEnabled 
    public String productEid{get;set;}
    @AuraEnabled
    public String SchdeuleAmount{get;set;}
    @AuraEnabled
    public Date SchdeuleDate{get;set;}
    @AuraEnabled 
    public String SchdeuleDescription{get;set;}
    @AuraEnabled 
    public String Name{get;set;}
    
}*/
  /*public class SelectOption {
        @AuraEnabled
        public String label{get;set;}  
        @AuraEnabled
        public String value{get;set;} 
        public SelectOption(String value, String label) {
            this.value = value;
            this.label = label;
        }
        public string getValue(){
            return value;
        } 
    }*/
}