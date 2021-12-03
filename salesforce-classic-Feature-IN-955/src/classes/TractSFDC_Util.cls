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
 * This class is the helper class to handle SFDC operations.
 * @author AMAN JAIN
 */

public class TractSFDC_Util {
  /**
   * @description: This Method update the field of opportunity after order creation.
   * @param tractOpportunityId Salesforce Opportunity ID
   * @param orderNum GTV Order Number
   * @param accountnum GTV Billing Account Number
   */
  public static void updateOpportunity(
    Id tractOpportunityId,
    String orderNum,
    String accountnum
  ) {
    Opportunity opportunities = new Opportunity(ID = tractOpportunityId);
    try {
      opportunities.Tract_Sales_Order__c = orderNum;
      opportunities.Billing_Account__c = accountnum;
      opportunities.Error_Message__c = 'Order Placed';
      if (
        TRACTAPIUtil.checkFieldLevelSecurity(
          'Opportunity',
          'id,Tract_Sales_Order__c, Billing_Account__c',
          'Update'
        )
      ) {
        update opportunities;
      }
    } catch (System.DmlException e) {
      system.assert(e.getMessage().contains('exists'), e.getMessage());
    }
  }

  /**
   * @description: This Method appends currency to the balance and return it.
   * @param balance
   * @param currencyType
   * @return String The String having currency appended to the balance.
   */
  public static String setBalanceCurrencyType(
    String balance,
    String currencyType
  ) {
    String value, location;
    for (System_Setting__c settings : System_Setting__c.getall().values()) {
      if (settings.name == 'Currency Identification') {
        value = settings.value__c;
      }
      if (settings.name == 'Currency Location') {
        location = settings.value__c;
      }
    }
    String currentBalance;
    if (value == 'ISO Code') {
      if (location == 'After') {
        currentBalance = balance + currencyType;
      } else {
        currentBalance = currencyType + balance;
      }
    } else {
      if (location == 'After') {
        currentBalance =
          balance + TractSFDC_Util.getCurrencySymbole(currencyType);
      } else {
        currentBalance =
          TractSFDC_Util.getCurrencySymbole(currencyType) + balance;
      }
    }
    return currentBalance;
  }

  /**
   * @description: This Method returns the adjustment type to be shown to the user.
   * @param adjustmentType
   * @return String The String having the adjustment type to be used on the UI.
   */
  public static String getAdjustmentType(String adjustmentType) {
    String result = '';
    if (adjustmentType == null) {
      return '';
    } else if (adjustmentType.equalsIgnoreCase('MANUAL')) {
      result = 'Manual Adjustment';
    } else if (adjustmentType.equalsIgnoreCase('LATE_FEE')) {
      result = 'Late Payment Fee';
    } else if (adjustmentType.equalsIgnoreCase('TERMINATION_CHARGE')) {
      result = 'Early Termination Charge';
    } else if (adjustmentType.equalsIgnoreCase('INVOICE_ADJUSTMENT')) {
      result = 'Invoice Adjustment';
    } else {
      result = adjustmentType.replace('_', ' ');
      result = result.toLowerCase().capitalize();
    }
    return result;
  }

  /**
   * @description: This Method returns the phone number by appending countryCode,areaCode,number_x and extension.
   * @param countryCode
   * @param areaCode
   * @param number_x
   * @param extension
   * @return String The String having the adjustment type to be used on the UI.
   */
  public static String getPhone(
    String countryCode,
    String areaCode,
    String number_x,
    String extension
  ) {
    String countryCode1 = '';
    String areaCode1 = '';
    String number_x1 = '';
    String extension1 = '';
    if (countryCode != null) {
      countryCode1 = '+' + countryCode;
    }
    if (areaCode != null) {
      areaCode1 = ' (' + areaCode + ') ';
    }
    if (number_x != null) {
      number_x1 = number_x;
    }
    if (extension != null) {
      extension1 = ' Extension:' + extension;
    }
    return countryCode1 + areaCode1 + number_x1 + extension1;
  }

  /**
   * @description: This Method returns two-three digit country code
   * @param countryString
   * @return String The String having the two-three digit country code.
   */
  public static String getCountry(String countryString) {
    string countryValueToReturn;
    Integer countryLength = countryString.length();
    if (countryLength == 3) {
      countryValueToReturn = countryString;
    } else if (countryLength > 3) {
      string country = CountryAndStateISOCode.getCountryCode(
        countryString.toUpperCase()
      );
      if (country != null) {
        countryValueToReturn = country;
      } else {
        countryValueToReturn = countryString;
      }
    } else if (countryLength == 2) {
      String country = CountryAndStateISOCode.getCountryCodeISo2(
        countryString.toUpperCase()
      );
      if (country != null) {
        countryValueToReturn = country;
      } else {
        countryValueToReturn = countryString;
      }
    } else {
      countryValueToReturn = 'error';
    }
    return countryValueToReturn;
  }

  /**
   * @description: This Method returns two digit State code
   * @param stateString
   * @return String The String having the two digit State code.
   */
  public static String getState(String stateString) {
    String stateValueToReturn;
    Integer stateLength = stateString.length();
    if (stateLength == 2) {
      stateValueToReturn = stateString;
    } else if (stateLength > 2) {
      String state = CountryAndStateISOCode.getStateCode(
        stateString.toUpperCase()
      );
      if (state != null) {
        stateValueToReturn = state;
      } else {
        stateValueToReturn = stateString;
      }
    } else {
      stateValueToReturn = 'error';
    }
    return stateValueToReturn;
  }

  /**
   * @description: This Method maps the value from opportunity line item to a wrapper.
   * @param information
   * @return TractProduct[] The list of wrapper required while creating order in GTV.
   */
  public static TractProduct[] getProductFromOpportunity(
    Map<String, String> information
  ) {
    TractProduct[] myTractProductList = new List<TractProduct>();
    String[] productEidList = new List<String>();
    Id[] serviceResourceIdList = new List<Id>();
    Map<Id, ProductPriceWrapper> prodIdvsProductPriceMap = new Map<Id, ProductPriceWrapper>();
    Map<Id, String> mapNewServiceResourceIdList = new Map<Id, String>();
    Map<String, Product2> mapPriceBLProcuct = new Map<String, Product2>();
    set<String> productIdSet = new Set<String>();
    Map<Id, Id> mapOppId_SRId = new Map<Id, Id>();
    Map<Id, Service_Resource__c> mapSRId_SR = new Map<Id, Service_Resource__c>();
    String priceBookCurrency;
    String tempOppId = information.get('OpportunityId');
    String priceBookId = information.get('Pricebook2Id');
    PriceBook2[] priceBooklist;
    if (TRACTAPIUtil.checkFieldLevelSecurity('PriceBook2', 'Name', 'Query')) {
      priceBooklist = [SELECT Name FROM PriceBook2 WHERE id = :priceBookId];
    }
    if (priceBooklist.size() > 0) {
      list<String> priceBookNameComponents = priceBooklist[0].Name.split(' ');
      priceBookCurrency = priceBookNameComponents[1];
    }
    OpportunityLineItem[] oppLT = [
      SELECT
        username__c,
        Price_Override__c,
        GTV_OneTime_Price_Range_Information__c,
        GTV_Recurring_Price_Range_Information__c,
        Email__c,
        Gotransverse_Overrided_Trial_Length__c,
        New_Service_Resource__c,
        firstname__c,
        lastname__c,
        description,
        Service__c,
        Product2Id,
        Id,
        PricebookEntryId,
        quantity,
        Discount_eid__c,
        Discount__c,
        Service_Resource_Eid__c,
        Tract_Service_Resource_Name__c,
        RecurringPrice__c,
        UnitPrice,
        OneTimePrice__c,
        Service_Resource__c,
        minServiceResources__c,
        maxServiceResources__c,
        eid__c,
        priceList_Eid__c,
        recurringProductPriceEid__c,
        GTV_Renewal_Price__c,
        GTV_Next_Renewal_Price__c,
        OneTimeProductPriceEid__c,
        Gotransverse_Next_Agreement_Eid__c,
        Gotransverse_NextAgreementEndAction__c,
        Applied_Agreement_Eid__c,
        Agreement_Period__c,
        agreementEndAction__c,
        overrideAgreementEndDate__c,
        ParentServiceEid__c
      FROM OpportunityLineItem
      WHERE OpportunityId = :tempOppId AND Existing_Service__c = FALSE
      LIMIT 50000
    ];

    for (OpportunityLineItem oLI : oppLT) {
      productIdSet.add(oLI.Product2Id);
      productEidList.add(oLI.eid__c);
      serviceResourceIdList.add(oLI.Service_Resource__c);
      mapNewServiceResourceIdList.put(oLI.Id, oLI.New_Service_Resource__c);
      mapOppId_SRId.put(oLI.Id, oLI.Service_Resource__c);
    }

    Product2[] productsEntries = [
      SELECT
        Id,
        eid__c,
        PriceOverride__c,
        SRC_eid__c,
        name,
        Requires_Agreement__c,
        Serialized__c,
        minServiceResources__c,
        maxServiceResources__c,
        ProductCode,
        Price_Information__c
      FROM Product2
      WHERE eid__c IN :productEidList
      ORDER BY ProductCode DESC
      LIMIT 50000
    ];

    for (Product2 tempProduct2 : productsEntries) {
      for (
        ProductPriceWrapper productPriceObj : (list<ProductPriceWrapper>) JSON.deserialize(
          tempProduct2.Price_Information__c,
          list<ProductPriceWrapper>.class
        )
      ) {
        if (productPriceObj.currencyType == priceBookCurrency) {
          prodIdvsProductPriceMap.put(tempProduct2.Id, productPriceObj);
        }
      }

      mapPriceBLProcuct.put(tempProduct2.eid__c, tempProduct2);
    }
    Service_Resource__c[] serviceResourceTotal = [
      SELECT Id, Name, Category_Name__c, eid__c, Status__c
      FROM Service_Resource__c
      WHERE Id IN :serviceResourceIdList
      LIMIT 50000
    ];

    for (Service_Resource__c tempSR : serviceResourceTotal) {
      mapSRId_SR.put(tempSR.Id, tempSR);
    }
    for (OpportunityLineItem oLI : oppLT) {
      Product2 tempPB_Prod = mapPriceBLProcuct.get(oLI.eid__c);
      if (tempPB_Prod != null) {
        TractProduct tempTractProduct = new TractProduct();
        tempTractProduct.priceListEid = oLI.priceList_Eid__c;
        tempTractProduct.quantity = oLI.quantity;
        integer strlen = null == oLI.description ? 0 : oLI.description.length();

        if (strlen <= 0) {
          tempTractProduct.description = '';
        } else if (strlen > 0 && strlen < 40) {
          tempTractProduct.description = oLI.description;
        } else if (strlen >= 40) {
          tempTractProduct.description = oLI.description.substring(0, 39);
        }
        if (oLI.Price_Override__c == true && oLI.recurringPrice__c != null) {
          tempTractProduct.recurringPrice = oLI.recurringPrice__c;
          tempTractProduct.overridedRecurringPriceRangesList = (list<ProductPriceRangeWrapper>) JSON.deserialize(
            oLI.GTV_Recurring_Price_Range_Information__c,
            list<ProductPriceRangeWrapper>.class
          );
        }
        if (oLI.Price_Override__c == true && oLI.oneTimePrice__c != null) {
          tempTractProduct.oneTimePrice = oLI.oneTimePrice__c;
          tempTractProduct.overridedOneTimePriceRangesList = (list<ProductPriceRangeWrapper>) JSON.deserialize(
            oLI.GTV_OneTime_Price_Range_Information__c,
            list<ProductPriceRangeWrapper>.class
          );
        }
        tempTractProduct.ServiceId = oLI.Service__c;

        if (oLI.ParentServiceEid__c != null && oLI.ParentServiceEid__c != '') {
          tempTractProduct.addToExistingService = true;
          tempTractProduct.parentServiceEid = oLI.ParentServiceEid__c;
        }

        tempTractProduct.ProductId = oLI.Product2Id;
        tempTractProduct.discountCodeEid = oLI.Discount_eid__c;
        tempTractProduct.discountCodeName = oLI.Discount__c;
        tempTractProduct.TractServiceResourceEid = oLI.Service_Resource_Eid__c;
        tempTractProduct.TractServiceResourceName = oLI.Tract_Service_Resource_Name__c;
        tempTractProduct.opportunityProductId = oLI.Id;
        tempTractProduct.overridedTrialLength = oLI.Gotransverse_Overrided_Trial_Length__c;

        if (oLI.recurringProductPriceEid__c != null) {
          tempTractProduct.recurringProductPriceEid = oLI.recurringProductPriceEid__c;
        }
        if (oLI.OneTimeProductPriceEid__c != null) {
          tempTractProduct.OneTimeProductPriceEid = oLI.OneTimeProductPriceEid__c;
        }
        tempTractProduct.eid = tempPB_Prod.eid__c;
        tempTractProduct.name = tempPB_Prod.name;
        tempTractProduct.Requires_Agreement = tempPB_Prod.Requires_Agreement__c;
        if (
          null != oLI.Applied_Agreement_Eid__c &&
          (!String.isBlank(oLI.agreementEndAction__c) ||
          oLI.overrideAgreementEndDate__c != null)
        ) {
          tempTractProduct.Agreement_Period = oLI.Agreement_Period__c;
          tempTractProduct.Agreement_eid = oLI.Applied_Agreement_Eid__c;
          tempTractProduct.agreementEndAction = oLI.agreementEndAction__c;
          tempTractProduct.overrideAgreementEndDate = oLI.overrideAgreementEndDate__c;
          tempTractProduct.nextAgreementEid = oLI.Gotransverse_Next_Agreement_Eid__c;
          tempTractProduct.nextAgreementEndAction = oLI.Gotransverse_NextAgreementEndAction__c;
          tempTractProduct.renewalPricing = oLI.GTV_Renewal_Price__c;
          tempTractProduct.nextRenewalPricing = oLI.GTV_Next_Renewal_Price__c;
        }

        tempTractProduct.Serialized = tempPB_Prod.Serialized__c;
        tempTractProduct.minServiceResources = tempPB_Prod.minServiceResources__c;
        tempTractProduct.maxServiceResources = tempPB_Prod.maxServiceResources__c;
        tempTractProduct.Service_Resource_Category = tempPB_Prod.SRC_eid__c;
        tempTractProduct.ProductCode = tempPB_Prod.ProductCode;

        if (tempPB_Prod.ProductCode == 'TRACT_SUBSCRIPTION') {
          tempTractProduct.UserName = oLI.username__c;
          tempTractProduct.Firstname = oLI.firstname__c;
          tempTractProduct.LastName = oLI.lastname__c;
          tempTractProduct.Email = oLI.Email__c;
          tempTractProduct.Sequence = 1;
        }

        if (
          tempPB_Prod.minServiceResources__c > 0 ||
          tempPB_Prod.maxServiceResources__c > 0
        ) {
          tempTractProduct.myServiceResourceList = new List<Service_Resource__c>();
          String SREid = mapNewServiceResourceIdList.get(oLI.Id);

          if (null == SREid || SREid == '') {
            tempTractProduct.myServiceResourceList.add(
              mapSRId_SR.get(mapOppId_SRId.get(oLI.Id))
            );
          } else {
            tempTractProduct.NewServiceResource = SREid;
          }
        }

        myTractProductList.add(tempTractProduct);
      }
    }
    return myTractProductList;
  }

  /**
   * @description: This method checks if an argument is null or not".
   * @param value String to be validated.
   * @return Boolean Argument is null or not.
   */
  public static Boolean isNull(String value) {
    if (value != null && value.trim() != '') {
      return false;
    }
    return true;
  }

  /**
   * @description: This method accepts String in argument and convert it to camelcase e.g. "SERVICE_ONY" will be converted "Service Only".
   * @param input The Invoice type to be formatted.
   * @param separator The separator to be replaced.
   * @return String  converted string in camelcase format.
   */
  public static String convertToCamelCase(String input, String separator) {
    String result = '';
    String internalSeparator = separator == null ? '' : separator;
    if (!String.isBlank(input)) {
      String[] elements = input.split(internalSeparator);

      for (String temp : elements) {
        result += ' ' + temp.toLowerCase().capitalize();
      }
    }
    return result.trim();
  }

  /**
   * @description: This Method formats the invoice type and return it.
   * @param input The Invoice type to be formatted.
   * @param separator The separator to be replaced.
   * @return String Formatted Invoice type.
   */
  public static String convertInvoiceTypeToCamelCase(
    String input,
    String separator
  ) {
    String result = '';
    String internalSeparator = separator == null ? '' : separator;
    if (!String.isBlank(input)) {
      String[] elements = input.split(internalSeparator);
      for (String temp : elements) {
        if (result == '') {
          result += temp.toLowerCase().capitalize();
        } else {
          result += ' & ' + temp.toLowerCase().capitalize();
        }
      }
    }
    return result.trim();
  }

  /**
   * @description: This enum comntains the possible values for agreement end action.
   */
  public enum AgreementEndAction {
    RENEW_AGREEMENT,
    SERVICE_ONLY,
    DEACTIVATE_SERVICE,
    CHANGE_AGREEMENT
    //CHANGE_SERVICE
  }

  /**
   * @description: This Method formats a date and returns it.
   * @param milestoneDate The date to be formatted.
   * @return String Formatted date.
   */
  public static String changeDateFormat(String milestoneDate) {
    Date featureDate = Date.valueOf(milestoneDate);
    String monthValue = String.valueof(featureDate.month());
    if (monthValue != null && monthValue != '' && monthValue.length() == 1) {
      monthValue = '0' + monthValue;
    }
    String DateValue = String.valueof(featureDate.day());
    if (DateValue != null && DateValue != '' && DateValue.length() == 1) {
      DateValue = '0' + DateValue;
    }
    String convertedDate =
      monthValue +
      '/' +
      DateValue +
      '/' +
      String.valueof(featureDate.year());
    return convertedDate;
  }

  /**
   * @description: This Method formats a date and returns it.
   * @param productPriceDate The datetime to be formatted.
   * @return DateTime Formatted date time.
   */
  public static DateTime productPriceFormat(DateTime productPriceDate) {
    DateTime finalPriceDate;
    String priceDate = String.valueOf(productPriceDate);
    if (priceDate != null) {
      String checkValue = priceDate.substring(0, 2);
      if (checkValue == '00') {
        priceDate = priceDate.replace(priceDate.substring(0, 2), '20');
        finalPriceDate = DateTime.valueOf(priceDate);
      } else {
        finalPriceDate = DateTime.valueOf(priceDate);
      }
      return finalPriceDate;
    } else {
      return null;
    }
  }

  public static Map<String, String> currencyISOCodeMap1 = null;

  public static String getCurrencySymbole(String currencyIsoCode) {
    String result = '';
    if (currencyISOCodeMap1 == null) {
      currencyISOCodeMap1 = new Map<String, String>();
      currencyISOCodeMap1.put('AUD', '$');
      currencyISOCodeMap1.put('USD', '$');
      currencyISOCodeMap1.put('BHD', 'BD');
      currencyISOCodeMap1.put('GBP', '£');
      currencyISOCodeMap1.put('CAD', '$');
      currencyISOCodeMap1.put('DKK', 'kr');
      currencyISOCodeMap1.put('EGP', '£');
      currencyISOCodeMap1.put('EUR', '€');
      currencyISOCodeMap1.put('INR', 'Rs.');
      currencyISOCodeMap1.put('JPY', '¥');
      currencyISOCodeMap1.put('KWD', 'K.D.');
      currencyISOCodeMap1.put('MXN', '$');
      currencyISOCodeMap1.put('NZD', '$');
      currencyISOCodeMap1.put('NOK', 'kr');
      currencyISOCodeMap1.put('OMR', 'rial');
      currencyISOCodeMap1.put('QAR', 'QR');
      currencyISOCodeMap1.put('ZAR', 'R');
      currencyISOCodeMap1.put('SAR', 'SR');
      currencyISOCodeMap1.put('SEK', 'kr');
      currencyISOCodeMap1.put('AED', 'DH');
      currencyISOCodeMap1.put('SGD', 'SGD');
      currencyISOCodeMap1.put('HKD', 'HK$');
      currencyISOCodeMap1.put('ILS', '₪');
      currencyISOCodeMap1.put('CHF', 'CHF');
    }
    result = currencyISOCodeMap1.get(currencyIsoCode);
    return result;
  }

  /**
   * @description: This Method returns the salesforce sessionId.
   * @param visualforcePage The Page reference for the visualforce page to get salesforce session id (required)
   * @return String A String of salesforce sessionId.
   */
  public static String getSessionIdFromVFPage(PageReference visualforcePage) {
    String content = visualforcePage.getContent().toString();
    Integer s =
        content.indexOf('Start_Of_Session_Id') + 'Start_Of_Session_Id'.length(),
      e = content.indexOf('End_Of_Session_Id');
    return content.substring(s, e);
  }

  /**
   * @description: This Method returns a randomly generated string.
   * @return String A randomly generated string.
   */
  public static String getRandomNumberString() {
    return zConvert.ToString(1000000000 * Math.random())
      .replace(',', 'T')
      .replace('.', 'W');
  }

  /**
   * @description: This Method returns API version enum.
   * @param apiVersion
   * @return GTVAPIVersion The API version enum.
   */
  public static GTVAPIVersion getAPIEnumValue(String apiVersion) {
    if (apiVersion == 'API Version 1.0') {
      return GTVAPIVersion.API_V1;
    } else if (apiVersion == 'API Version 2.0') {
      return GTVAPIVersion.API_V2;
    } else {
      return null;
    }
  }

  /**
   * @description: This Method returns service status in captilize format.
   * @param status
   * @return string The String having service status in captilize format.
   */
  public static string getServiceStatus(string status) {
    string result = '';
    string temp = status.substringAfter('_');
    temp = temp.toLowerCase();
    result = temp.capitalize();
    return result;
  }

  /**
   * @description: This Method updates the pricelistEid field on product.
   * @param selectedProducts
   * @param priceListEid
   */
  public static void addPriceListToProduct(
    list<String> selectedProducts,
    String priceListEid
  ) {
    Price_List__c priceList = [
      SELECT id, name, eid__c
      FROM Price_List__c
      WHERE eid__c = :priceListEid
    ];
    List<product2> productList = [
      SELECT id, Name, priceLists__c
      FROM product2
      WHERE eid__c IN :selectedProducts
    ];
    if (productList != null && !productList.isEmpty()) {
      for (product2 currentProduct : productList) {
        if (
          currentProduct.PriceLists__c == '' ||
          currentProduct.PriceLists__c == null
        ) {
          currentProduct.PriceLists__c = '';
          currentProduct.PriceLists__c =
            priceList.Name +
            ':' +
            priceList.eid__c;
        } else if (
          currentProduct.PriceLists__c != '' &&
          currentProduct.PriceLists__c != null
        ) {
          currentProduct.PriceLists__c +=
            ',' +
            priceList.Name +
            ':' +
            priceList.eid__c;
        }
      }
    }
    update productList;
  }

  /**
   * @description: This Method updates the pricelistEid field on product.
   * @param selectedProducts
   * @param priceListEid
   */
  public static void removePriceListFromProduct(
    list<String> selectedProducts,
    String priceListEid
  ) {
    List<product2> productList = [
      SELECT id, Name, priceLists__c
      FROM product2
      WHERE eid__c IN :selectedProducts
    ];
    if (productList != null && !productList.isEmpty()) {
      for (product2 currentProduct : productList) {
        if (currentProduct.PriceLists__c != null) {
          String priceListValue = '';
          for (String priceList : currentProduct.PriceLists__c.split(',')) {
            if (!priceList.contains(priceListEid)) {
              if (priceListValue == '') {
                priceListValue = priceList;
              } else if (priceListValue != '') {
                priceListValue += ',' + priceList;
              }
            }
          }
          currentProduct.PriceLists__c = priceListValue;
        }
      }
    }
    update productList;
  }

  public static String getRecurrencePeriod(String recurrence) {
    String result = '';
    result = recurrence.replace(' ', '_');
    result = result.toUpperCase();
    return result;
  }
}