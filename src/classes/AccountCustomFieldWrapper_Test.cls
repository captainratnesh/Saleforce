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
 * This class is a test class of AccountCustomFieldWrapper class.
 * @author Anurag Srivastava
 */

@istest
public with sharing class AccountCustomFieldWrapper_Test {
  @istest
  public static void unitTest() {
    AccountCustomFieldWrapper wrap = new AccountCustomFieldWrapper();
    wrap.Name = '';
    wrap.Eid = '';
    wrap.Value = '';
    wrap.selectedListTypeValue = '';
    wrap.Value = '';
    wrap.fieldValidationType = '';
    wrap.checkListtype = false;
    wrap.storeListTypeValues = new List<SelectOption>();
    System.assert(wrap != null);
    wrap.AccountCustomFieldWrapper();

    AgreementWrapper wrap2 = new AgreementWrapper();
    wrap2.agreementList = new List<SelectOption>();
    wrap2.renewAction = new List<SelectOption>();
    wrap2.mapOfAgreementPeriod = new Map<String, Decimal>();
    System.assert(wrap2 != null);

    ContactWrapper wrap3 = new ContactWrapper();
    wrap3.Name = '';
    wrap3.categoryName = '';
    wrap3.department = '';
    wrap3.title = '';
    wrap3.Phone = '';
    wrap3.Email = '';
    System.assert(wrap3 != null);

    DiscountCodeWrapper wrap4 = new DiscountCodeWrapper();
    wrap4.Name = '';
    wrap4.status = '';
    wrap4.description = '';
    wrap4.chargeCategory = '';
    wrap4.availableFrom = '';
    wrap4.discount = '';
    System.assert(wrap4 != null);
  }

  @isTest
  public static void unitTest2() {
    AccountCustomFieldValueWrapper wrapp = new AccountCustomFieldValueWrapper();
    wrapp.Name = '';
    wrapp.Eid = '';
    wrapp.Value = '';
  }
  @isTest
  public static void usageRuleWrapperTest() {
    UsageRuleWrapper wrap = new UsageRuleWrapper();
    wrap.name = '';
    wrap.rule = '';
    wrap.rate = '';
    wrap.allowance = '';
    wrap.status = '';
  }
  @isTest
  public static void gTVOneTimeOrderItemWrapperTest() {
    GTVOneTimeOrderItemWrapper wrap = new GTVOneTimeOrderItemWrapper();
    wrap.productName = '';
    wrap.description = '';
    wrap.orderNumber = '';
    wrap.status = '';
    wrap.quantity = 0;
    wrap.unitPrice = '';
    wrap.totalPrice = '';
    wrap.purchaseDate = null;
    wrap.priceCategory = '';
    wrap.id = '';
    wrap.overridden = '';
    wrap.scheduleChargeInf = new List<ScheduleChargesWapper>();
    wrap.productDescription = '';
  }

  @isTest
  public static void product2WrapperTest() {
    Product2Wrapper wrapp = new Product2Wrapper();
    wrapp.IsSelected = false;
    wrapp.prod = null;
    wrapp.errorMessage = '';
  }

  @isTest
  public static void productCustomFieldWrapperTest() {
    ProductCustomFieldWrapper wrap = new ProductCustomFieldWrapper();
    wrap.Name = '';
    wrap.Eid = '';
    wrap.Value = '';
    wrap.storeListTypeValues = new List<SelectOption>();
    wrap.selectedListTypeValue = '';
    wrap.checkListtype = true;
    wrap.fieldValidationType = '';
    wrap.AccountCustomFieldWrapper();
  }
}