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
 * This class is a test class of TractSalesOrderController_LT class.
 * @author Aman Jain
 */

@isTest
public class TractSalesOrderController_LT_Test {
  static testMethod void salesorderMethod2() {
    Opportunity opp = HelperClass.getOpportunity();
    insert opp;

    TRACT_Setup__c tractSetup = HelperClass.getAPI1TRACT();
    insert tractSetup;

    Account acc = HelperClass.getAccount();
    insert acc;

    list<TractSalesOrderController_LT.ProductShowWrapper> proWrapList = new List<TractSalesOrderController_LT.ProductShowWrapper>();
    TractSalesOrderController_LT.ProductShowWrapper proWrap = new TractSalesOrderController_LT.ProductShowWrapper();
    proWrap.productName = 'test';
    proWrap.agreementName = 'test';
    proWrap.agreementCheck = true;
    proWrap.orderItemEid = 'test';
    proWrap.appliedTo = true;
    proWrap.appliedToName = 'test';
    proWrap.recurringPrice = '40';
    proWrap.endAction = 'test';
    proWrap.serviceVar = true;
    proWrap.unitPrice = '20';
    proWrap.tract = tractSetup;
    proWrap.thisAccount = Acc;
    proWrap.thisOpp = opp;
    proWrap.priceShowFinal = 30;
    proWrap.taxTotalShow = 40;
    proWrap.taxShow = 20;
    proWrap.priceShow = 10;
    proWrap.orderItem = true;
    proWrap.totalOrderAmount = 50;
    proWrap.taxAmount = 30;
    proWrap.tractUrl = 'test';
    proWrap.terrormessage = 'error';
    proWrap.shortDescription = '123';
    proWrap.agreementEndDate = '123';
    proWrap.shortDesc = true;
    proWrap.price = '123';
    proWrap.quantity = 123;
    proWrap.total = '123';
    list<string> serviceVal = new List<string>();
    proWrap.serviceValue = serviceVal;
    proWrap.agreementPeriod = '123';
    proWrapList.add(proWrap);

    TractSalesOrderController_LT.SalesOrderWrapper wrap = new TractSalesOrderController_LT.SalesOrderWrapper();
    wrap.taxShow = 20;
    wrap.taxTotalShow = 20;
    wrap.priceShowFinal = 30;
    wrap.taxShow1 = '10';
    wrap.checkOrder = true;
    wrap.productShowWrapper = proWrapList;
    System.assertNotEquals(Acc, null);
    test.startTest();
    TractSalesOrderController_LT.salesOrderList(opp.id);
    test.stopTest();
  }

  static testMethod void salesorderMethod3() {
    Opportunity opp = HelperClass.getOpportunity();
    insert opp;

    TRACT_Setup__c tractSetup = HelperClass.getAPI2TRACT();
    insert tractSetup;

    Account acc = HelperClass.getAccount();
    insert acc;

    list<TractSalesOrderController_LT.ProductShowWrapper> proWrapList = new List<TractSalesOrderController_LT.ProductShowWrapper>();
    TractSalesOrderController_LT.ProductShowWrapper proWrap = new TractSalesOrderController_LT.ProductShowWrapper();
    proWrap.productName = 'test';
    proWrap.agreementName = 'test';
    proWrap.agreementCheck = true;
    proWrap.orderItemEid = 'test';
    proWrap.appliedTo = true;
    proWrap.appliedToName = 'test';
    proWrap.recurringPrice = '40';
    proWrap.endAction = 'test';
    proWrap.serviceVar = true;
    proWrap.unitPrice = '20';
    proWrap.tract = tractSetup;
    proWrap.thisAccount = Acc;
    proWrap.thisOpp = opp;
    proWrap.priceShowFinal = 30;
    proWrap.taxTotalShow = 40;
    proWrap.taxShow = 20;
    proWrap.priceShow = 10;
    proWrap.orderItem = true;
    proWrap.totalOrderAmount = 50;
    proWrap.taxAmount = 30;
    proWrap.tractUrl = 'test';
    proWrap.terrormessage = 'error';
    proWrapList.add(proWrap);

    TractSalesOrderController_LT.SalesOrderWrapper wrap = new TractSalesOrderController_LT.SalesOrderWrapper();
    wrap.taxShow = 20;
    wrap.taxTotalShow = 20;
    wrap.priceShowFinal = 30;
    wrap.taxShow1 = '10';
    wrap.checkOrder = true;
    wrap.tractUrl = 'test';
    wrap.taxTotalShow1 = '40';
    wrap.priceShowFinal1 = '40';
    wrap.productShowWrapper = proWrapList;
    System.assertNotEquals(acc, null);
    test.startTest();
    TractSalesOrderController_LT.salesOrderList(opp.id);
    tractSetup.Api_Version__c = 'API Version 1.0';
    update tractSetup;
    TractSalesOrderController_LT.salesOrderList(opp.id);
    test.stopTest();
  }
}