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
 * This class is a test class of TractSFDC_Util class.
 * @author Aman Jain
 */

@isTest
private class TractSFDC_Util_Test {
  static testMethod void myUnitTest() {
    TRACT_Setup__c tract = HelperClass.getTract();
    tract.Active__c = true;
    tract.Api_Version__c = '30';
    system.assert(tract != null);
    insert tract;

    Service_Resource__c serviceResource = HelperClass.getServiceresource();
    system.assert(serviceResource != null);
    insert serviceResource;

    Opportunity opportunity = HelperClass.getOpportunity();
    //opportunity.eid__c = '12345';
    system.assert(opportunity != null);
    insert opportunity;

    Product2 product = HelperClass.getProduct2();
    product.eid__c = '12345';
    product.ProductCode = 'TRACT_SUBSCRIPTION';
    product.minServiceResources__c = 10;
    product.maxServiceResources__c = 10;
    system.assert(product != null);
    insert product;

    List<ProductPriceWrapper> ppList = new List<ProductPriceWrapper>();
    ProductPriceWrapper pp = new ProductPriceWrapper();
    pp.priceType = 'Recurring';
    pp.eid = '2342';
    pp.thruDate = system.today();
    pp.currencyType = 'EUR';
    pp.priceListEid = '2732';
    pp.recurrencePeriod = 'Month';
    pp.scheduledCharges = false;
    pp.priceOverride = false;

    ProductPriceRangeWrapper priceRange = new ProductPriceRangeWrapper();
    PriceRange.price = 20;
    PriceRange.quantityBeginRange = 1;
    PriceRange.quantityEndRange = 20;
    List<ProductPriceRangeWrapper> priceRangeList = new List<ProductPriceRangeWrapper>();
    PriceRangeList.add(PriceRange);
    pp.priceRangesList = PriceRangeList;
    ppList.add(pp);

    ProductPriceWrapper pp2 = new ProductPriceWrapper();
    pp2.priceType = 'OneTime';
    pp2.eid = '2342';
    pp2.thruDate = system.today();
    pp2.currencyType = 'EUR';
    pp2.priceListEid = '2732';
    pp2.recurrencePeriod = 'Month';
    pp2.scheduledCharges = false;
    pp2.priceOverride = false;

    pp2.priceRangesList = PriceRangeList;
    ppList.add(pp2);

    product.Price_Information__c = JSON.serialize(ppList);
    update product;

    OpportunityLineItem oppLineItem = HelperClass.getOpportunityLineItem();
    oppLineItem.Service_Resource__c = serviceResource.Id;
    oppLineItem.New_Service_Resource__c = 'newServiceResourec';
    oppLineItem.OpportunityId = opportunity.Id;
    oppLineItem.recurringProductPriceEid__c = '12345';
    oppLineItem.productEid__c = 12345;
    oppLineItem.agreementEndAction__c = 'EndAction';
    oppLineItem.overrideAgreementEndDate__c = Date.valueOf('2016-5-4');
    system.assert(oppLineItem != null);
    insert oppLineItem;

    String accountNum = '12345';
    Account account = HelperClass.getAccount();
    account.Tract_Billing_Account__c = accountNum;
    system.assert(account != null);
    insert account;

    String orderNum = '12206';
    String tractEid = '12345';
    Map<String, String> information = new Map<String, String>();
    information.put('OpportunityId', opportunity.Id);
    Decimal quantity = 5;
    String srIdentifierName = 'identifire';
    String decryptedStr = '12345';
    String input = 'ravi,kant,maurya';
    String separator = ',';
    string milestoneDate = String.valueOf(Date.today());
    DateTime productPriceDate = Datetime.newInstance(1960, 2, 17);
    String currencyIsoCode = 'AUD';
    list<String> selectedString = new List<string>();
    selectedString.add('Test');
    Test.startTest();
    TractSFDC_Util.updateOpportunity(opportunity.Id, orderNum, accountnum);
    TractSFDC_Util.getProductFromOpportunity(information);
    TractSFDC_Util.isNull(decryptedStr);
    TractSFDC_Util.convertToCamelCase(input, separator);
    TractSFDC_Util.changeDateFormat(milestoneDate);
    TractSFDC_Util.productPriceFormat(productPriceDate);
    TractSFDC_Util.getCurrencySymbole(currencyIsoCode);
    TractSFDC_Util.getAdjustmentType('Test');
    TractSFDC_Util.getPhone('Test', 'test', 'test', 'test');
    TractSFDC_Util.getCountry('Test');
    TractSFDC_Util.getState('Test');
    TractSFDC_Util.convertInvoiceTypeToCamelCase('Test', 'Test');
    TractSFDC_Util.removePriceListFromProduct(selectedString, 'Test');
    TractSFDC_Util.getRecurrencePeriod('Test');
    TractSFDC_Util.getRandomNumberString();
    TractSFDC_Util.getServiceStatus('test');
    Test.stopTest();
  }
}