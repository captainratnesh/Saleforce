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
 * This class is a test class of SalesOrderWrapper class.
 * @author Aman Jain
 */

@isTest
private class SalesOrderWrapper_Test {
  static testMethod void myUnitTest() {
    // TO DO: implement unit test
    SalesOrderWrapper salesWrapObj = new SalesOrderWrapper();
    salesWrapObj.TRACTurl = 'Test Url';
    salesWrapObj.taxShow = 1.0;
    salesWrapObj.taxTotalShow = 1.0;
    salesWrapObj.priceShowFinal = 2.0;
    salesWrapObj.taxShow1 = '1.0';
    salesWrapObj.taxTotalShow1 = '2.0';
    salesWrapObj.priceShowFinal1 = '3.0';
    salesWrapObj.checkOrder = false;
    salesWrapObj.productShowWrapper = new List<TractSalesOrderController_LT.ProductShowWrapper>();
    System.assertEquals(salesWrapObj.TRACTurl, 'Test Url');

    ChangeSubscriptionWrapper changeWrapObj = new ChangeSubscriptionWrapper();
    changeWrapObj.changedServiceEid = 'Test Url';
    changeWrapObj.subscriptionId = ' ';
    changeWrapObj.newServiceList = new List<SelectOption>();
    changeWrapObj.productPriceIdtoPriceRangesMap = new Map<String, List<ProductPriceRangeWrapper>>();
    changeWrapObj.productIdToProductPriceMap = new Map<String, List<ProductPriceWrapper>>();
    changeWrapObj.recurringPriceList = new List<SelectOption>();
    changeWrapObj.productPriceIdToPriceValueMap = new Map<String, Decimal>();
    changeWrapObj.productPriceIdToEidMap = new Map<String, String>();
    changeWrapObj.MapOfAgreementPeriod = new Map<String, Decimal>();
    changeWrapObj.recurringPrice = 1.0;
    changeWrapObj.serviceHasAgreement = true;
    changeWrapObj.agreementList = new List<SelectOption>();
    changeWrapObj.renewActionList = new List<SelectOption>();
    changeWrapObj.enablePreserveAgreement = true;
    changeWrapObj.supportsPriceOverride = true;
    changeWrapObj.canUpdateQty = true;
    changeWrapObj.quantity = 1;
    changeWrapObj.errorMessage = '';
  }
}