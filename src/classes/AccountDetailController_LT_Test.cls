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
 * This class is a test class of AccountDetailController_LT class.
 * @author Aman Jain
 */

@isTest
public with sharing class AccountDetailController_LT_Test {
  static testMethod void testAccountdetail2() {
    String dayOrDate = '2015-06-30';
    String getwrap = '{}';
    Test.setMock(WebServiceMock.class, new AccountDetailMock_Test());
    Account acc = HelperClass.getAccount();
    insert acc;
    System_Setting__c settings = HelperClass.getSystemSettings();
    insert settings;
    Contact cont = new Contact(LastName = 'Testcont', AccountId = Acc.id);
    system.assert(cont != null);
    insert cont;
    TRACT_Setup__c tract = HelperClass.getAPI1TRACT();
    insert tract;
    TRACT_Mappings__c maptract = new TRACT_Mappings__c();
    maptract.name = 'TRACT Account Mapping';
    maptract.TRACT_Account_Fields__c = '{ "AccountName":[ "Contact.Name", "Select from the Related List", "Name starts with test" ], "AccountNumber":[ "ParentId.AccountNumber", "Select from the Same Record", "" ], "BillingStreet":[ "BillingStreet", "Select from the Same Record", "" ], "BillingCity":[ "Contact.MailingCity", "Select from the Related List", "MailingCity equals test" ], "BillingCode":[ "Contact.MailingPostalCode", "Select from the Related List", "MailingPostalCode contains 1234" ], "BillingState":[ "BillingState", "Select from the Same Record", "" ], "BillingCountry":[ "Contact.MailingCountry", "Select from the Related List", "MailingCountry ends with test" ], "ShippingStreet":[ "ShippingStreet", "Select from the Same Record", "" ], "ShippingCity":[ "ShippingCity", "Select from the Same Record", "" ], "ShippingCode":[ "ShippingPostalCode", "Select from the Same Record", "" ], "ShippingState":[ "ShippingState", "Select from the Same Record", "" ], "ShippingCountry":[ "ShippingCountry", "Select from the Same Record", "" ], "Phone":[ "Phone", "Select from the Same Record", "" ], "GotransverseEmail":[ "TRACT3__Email__c", "Select from the Same Record", "" ] }';
    insert maptract;
    TRACTBillingAccountCategory__c tractBilling = HelperClass.getAccountCategory();
    insert tractBilling;
    TRACT_Bill_Cycle__c billcycle = HelperClass.getBillCycle();
    billcycle.Billing_Account_Category_Eid__c = '1234';
    billcycle.TRACT_Bill_Cycle_Currency_Type__c = 'USD';
    insert billcycle;
    Payment_Term__c paymentTerms = HelperClass.getPaymentTerms();
    insert paymentTerms;
    list<ProductServiceWrapper> wrapperclsList = new List<ProductServiceWrapper>();
    ProductServiceWrapper wrappercls = new ProductServiceWrapper();
    wrappercls.createBillingAccount = true;
    wrappercls.serviceEid = 'tst';
    wrappercls.servicProducteName = 'prod';
    wrappercls.serviceEid = 'service';
    wrapperclsList.add(wrappercls);
    Map<String, Decimal> mapOfAgreementPeriod = new Map<String, Decimal>();
    Map<String, String> productPriceIdToEidMap = new Map<String, String>();
    TractAdjustmentWrapper taw = new TractAdjustmentWrapper();
    list<AdjustmentWrapper> adList = new List<AdjustmentWrapper>();
    AdjustmentWrapper adjustWrap1 = new AdjustmentWrapper();
    adjustWrap1.Name = 'test';
    adjustWrap1.Type = 'Manual Adjustment';
    adjustWrap1.reason = 'Default Debit Adjustment Reason';
    adjustWrap1.description = 'test';
    adjustWrap1.Status = 'Pending';
    adjustWrap1.ManuallyApply = 'No';
    adjustWrap1.credit = true;
    adList.add(adjustWrap1);
    AdjustmentWrapper adjustWrap2 = new AdjustmentWrapper();
    adjustWrap2.Name = 'test';
    adjustWrap2.Type = 'Manual Adjustment';
    adjustWrap2.reason = 'Default Debit Adjustment Reason';
    adjustWrap2.description = 'test';
    adjustWrap2.Status = 'Pending';
    adjustWrap2.ManuallyApply = 'No';
    adjustWrap2.credit = false;
    adList.add(adjustWrap2);
    TRACTAccountWrapper accountWrap = new TRACTAccountWrapper();
    accountWrap.accountCategory = 'All accounts';
    accountWrap.status = 'Active';
    accountWrap.billType = 'Email';
    accountWrap.billCycleType = 'Monthly';
    accountWrap.billCycleName = 'All accounts';
    accountWrap.eid = '12345';
    accountWrap.TractBillingAccountNumber = '12345';
    accountWrap.accountCurrency = 'USD';
    accountWrap.billingAccount = Acc;
    String accWrap = JSON.serialize(accountWrap);
    list<AccountCustomFieldWrapper> customFieldWrapList = new List<AccountCustomFieldWrapper>();
    AccountCustomFieldWrapper wrap = new AccountCustomFieldWrapper();
    wrap.Name = '';
    wrap.Eid = '';
    wrap.Value = 'Test';
    wrap.selectedListTypeValue = 'test';
    wrap.fieldValidationType = '';
    wrap.checkListtype = false;
    wrap.storeListTypeValues = new List<SelectOption>();
    customFieldWrapList.add(wrap);
    String customfieldWrapperString = JSON.serialize(customFieldWrapList);
    AccountEditWrapper accountEditWrap = new AccountEditWrapper();
    List<ProductPriceWrapper> productPriceMapList = new List<ProductPriceWrapper>();
    ProductPriceWrapper productPriceWapp = new ProductPriceWrapper();
    productPriceWapp.eid = '1234';
    productPriceWapp.fromDate = System.today();
    productPriceWapp.priceCategory = '1234';
    productPriceWapp.priceType = 'Recurring';
    productPriceWapp.recurringPaymentRequired = true;
    productPriceWapp.currencyType = 'USD';
    productPriceWapp.billInAdvance = true;
    productPriceWapp.hasProductEid = true;
    productPriceWapp.paymentOnPurchaseRequired = true;
    productPriceWapp.priceOverride = true;
    productPriceWapp.proratedOnOrder = true;
    productPriceWapp.proratedOnOrderNoCharge = true;
    productPriceWapp.proratedOnCancel = true;
    productPriceWapp.priceCategoryId = '1234';
    productPriceWapp.recurrencePeriod = 'DAY';
    productPriceWapp.priceGroupId = '1234';
    ProductPriceRangeWrapper priceRange = new ProductPriceRangeWrapper();
    priceRange.price = 20;
    priceRange.quantityBeginRange = 20;
    priceRange.quantityEndRange = 20;
    priceRange.level = 20;
    priceRange.currencyType = 'USD';
    priceRange.eid = '20';
    List<ProductPriceRangeWrapper> priceRangeList = new List<ProductPriceRangeWrapper>();
    priceRangeList.add(priceRange);
    productPriceWapp.priceRangesList = priceRangeList;
    productPriceMapList.add(productPriceWapp);
    ChangeSubscriptionWrapper subscriptionWrapper = new ChangeSubscriptionWrapper();
    list<Product2> lstProduct = new List<Product2>();
    Product2 prod = HelperClass.getProduct2();
    lstProduct.add(prod);
    insert lstProduct;
    subscriptionWrapper.subscriptionId = lstProduct[0].Id;
    subscriptionWrapper.productIdToProductPriceMap = new Map<String, List<ProductPriceWrapper>>();
    subscriptionWrapper.productIdToProductPriceMap.put(
      subscriptionWrapper.subscriptionId,
      productPriceMapList
    );
    subscriptionWrapper.productPriceIdtoPriceRangesMap = new Map<String, List<ProductPriceRangeWrapper>>();
    subscriptionWrapper.productPriceIdtoPriceRangesMap.put(
      '1234',
      PriceRangeList
    );
    test.startTest();
    Account billingAccount = AccountDetailController_LT.getBillingAccount(
      Acc.id
    );
    System.assert(billingAccount.Tract_Billing_Account__c != null);
    System.assertEquals(billingAccount.Name, acc.Name);
    AccountDetailController_LT.setUpServices(accWrap, 1);
    AccountDetailController_LT.getSalesOrder(accWrap, 1);
    AccountDetailController_LT.getBillingAccount(tract, Acc);
    AccountDetailController_LT.setUpPayments(accWrap, 1);
    AccountDetailController_LT.setUpDebitAdjustment(accWrap, 1);
    AccountDetailController_LT.setUpCreditAdjustment(accWrap, 1);
    AccountDetailController_LT.setUpInvoices(accWrap, 1);
    AccountDetailController_LT.showServices(acc, 'test');
    AccountDetailController_LT.savePopupRenew(
      'renewAgreementEid',
      tract,
      Acc,
      'serviceRenewEid',
      '102',
      '21',
      true,
      string.valueOf(System.today())
    );
    AccountDetailController_LT.saveDeactivateService(
      'serviceEid',
      'reasonEid',
      '10-09-2016'
    );
    AccountDetailController_LT.suspendServiceTract('serviceEid', 'reasonEid');
    AccountDetailController_LT.saveChangeServicesOnApex(
      'newSubscriptionEid',
      'effectiveDateValue',
      'currentServiceEid',
      Acc,
      true,
      mapOfAgreementPeriod,
      productPriceIdToEidMap,
      4,
      'RENEW_AGREEMENT',
      'agreementEidForChangedService',
      20.3,
      'recurringPriceId',
      JSON.serialize(true)
    );
    AccountDetailController_LT.saveAddAddressTract(
      'currentServiceEid',
      'countryListValue',
      'BillingCity',
      'BillingCity',
      'ShippingCity',
      'stateValue',
      '223344'
    );
    AccountDetailController_LT.showActivityChargeRule('activityProductEid');
    AccountDetailController_LT.showDebitAdjustment();
    AccountDetailController_LT.showCreditAdjustment();
    AccountDetailController_LT.resumeServiceTract('serviceEidValue');
    AccountDetailController_LT.deleteActivityChargeRule(
      tract,
      'activityProductEid',
      'deletedUsageEid',
      'activityRuleName'
    );
    AccountDetailController_LT.getServiceReason();
    AccountDetailController_LT.getBillingAccountdetail(Acc.id);
    AccountDetailController_LT.saveDebitAdjustmentTract(
      Acc.id,
      'adjustmentReasonEid',
      '100',
      'description',
      String.valueOf(Date.today())
    );
    AccountDetailController_LT.saveCreditAdjustmentTract(
      Acc.id,
      'adjustmentReasonEid',
      '100',
      'description',
      String.valueOf(Date.today()),
      true
    );
    AccountDetailController_LT.getOneTimeOrderItemList(accWrap);
    AccountDetailController_LT.UpdateQuantityInTract(
      'serviceEidValue',
      '10',
      true,
      String.valueOf(Date.today())
    );
    AccountDetailController_LT.showUpdateQuantity();
    AccountDetailController_LT.getpermissions();
    AccountDetailController_LT.setUpUsagesEvents(accWrap, 4);
    AccountDetailController_LT.getContactDetail(cont.id);
    AccountDetailController_LT.pdfDownload(
      Acc.id,
      'https://tractlightning/getinvoices/01p7F00000C7bDy/p'
    );
    AccountDetailController_LT.saveAccountCustomField(
      customfieldWrapperString,
      accWrap
    );
    AccountDetailController_LT.showPopupChangeService('12345', 'USD', true);
    AccountDetailController_LT.getChildAccountDetails('12345');
    AccountDetailController_LT.getBillingHierarchy('12345');
    AccountDetailController_LT.getConfigDetails(Acc.id);
    AccountDetailController_LT.createPaymentMethod(
      '{"firstName":"Test","middleName":"Test","lastName":"Test","suffix":"Mr.","cardType":[],"cardTypeSelect":"VISA","cardNumber":"41111111111111111","cvv":"234","expiryDate":"05/2025","email":"test@gmail.com","street":"Test1","city":"New York","country":"United States","postalCode":"23456","autoPayment" : true}',
      Acc.id
    );
    AccountDetailController_LT.getPaymentMethodForPayment(Acc.Id);
    AccountDetailController_LT.executePayment(
      Acc.id,
      '{"firstName":"Test","middleName":"Test","lastName":"Test","suffix":"Mr.","cardType":[],"cardTypeSelect":"VISA","cardNumber":"41111111111111111","cvv":"234","expiryDate":"05/2025","email":"test@gmail.com","street":"Test1","city":"New York","country":"United States","postalCode":"23456"}'
    );
    AccountDetailController_LT.getCreateChangeServiceWrapper('Test', 'Test');
    AccountDetailController_LT.createChangeOrderInGTV(
      '{"compatibleProductList":[{"label":"Test01/2 Sub2 Solomiia","value":"17252"},{"label":"SubProd_03","value":"13052"},{"label":"Sub_01","value":"13318"},{"label":"Subprod_01 8/4","value":"17150"},{"label":"S-orad","value":"17174"},{"label":"S-orad2","value":"17178"},{"label":"S-tax","value":"17202"},{"label":"S-orad-n","value":"17204"},{"label":"Sub","value":"17206"},{"label":"Sub taxable","value":"17234"},{"label":"Test01/1 Sub1 Solomiia","value":"17242"},{"label":"Test02 Sub Solomiia","value":"17256"},{"label":"Subprod 8/23","value":"17330"},{"label":"Subprod_01 8/23","value":"17334"},{"label":"Subprod_3 8/24","value":"17360"},{"label":"3-S","value":"17394"},{"label":"Subprod_01 8/28","value":"17396"},{"label":"Prod_01 8/28","value":"17400"},{"label":"Subprod_02 8/28","value":"17404"},{"label":"Subprod_04 8/28","value":"17408"},{"label":"3-S-1","value":"17410"},{"label":"Subprod_01 9/4","value":"17456"},{"label":"Subprod_01 9/4 tax","value":"17460"},{"label":"Subprod_04 tax","value":"17462"},{"label":"DSU Subscription","value":"17736"},{"label":"DSU Subscription #2","value":"17738"},{"label":"Subprod_01 10/4","value":"17794"},{"label":"Sub Twelve Weeks","value":"17870"},{"label":"Subprod_01 10/9","value":"17882"},{"label":"1-1","value":"17968"},{"label":"Subprod_01 10/18","value":"18040"},{"label":"Subprod_04 10/18","value":"18044"},{"label":"Subprod_01 10/19","value":"18094"},{"label":"Subprod_02 10/19","value":"18096"},{"label":"299739","value":"18112"},{"label":"299739-2","value":"18114"},{"label":"Subprod_01 10/20","value":"18182"},{"label":"Subprod_02 10/20","value":"18184"},{"label":"4-s","value":"18280"},{"label":"Subprod_01 10/26","value":"18302"},{"label":"Sub_1","value":"18498"},{"label":"Sub_2","value":"18500"},{"label":"Sub_01 11/2","value":"18532"},{"label":"Sub_02 11/2 no tax","value":"18534"},{"label":"Sub_03 11/2","value":"18536"},{"label":"Sub_04 11/2","value":"18540"},{"label":"UPROM-477","value":"18546"},{"label":"Sub_01 11.3","value":"18578"},{"label":"Sub_tax1","value":"18582"},{"label":"Sub_2 tax","value":"18588"}],"currencyType":"USD","currentProductId":"17252","currentServiceId":"2346616","EmailReciept":false,"MapofProductEidVsSerializedFlag":{},"MapOfProductIdVsOneTimePriceList":{"17738":[{"label":"One-Time /10.0","value":"49264"}],"18096":[{"label":"One-Time /70.0","value":"22334"}]},"MapOfProductIdVsRecurrencePriceList":{"13052":[{"label":"Bill Cycle/340.0","value":"18826"}],"13318":[{"label":"Bill Cycle/198.0","value":"19128"}],"17150":[{"label":"Bill Cycle/10.0","value":"20292"}],"17174":[{"label":"Bill Cycle/10.0","value":"20314"}],"17178":[{"label":"Bill Cycle/-10.0","value":"20318"}],"17202":[{"label":"Bill Cycle/100.0","value":"20362"}],"17204":[{"label":"Bill Cycle/-100.0","value":"20364"}],"17206":[{"label":"Bill Cycle/100.0","value":"20366"}],"17234":[{"label":"Bill Cycle/140.0","value":"20402"}],"17242":[{"label":"Bill Cycle/10.0","value":"20412"},{"label":"Two Years/10.0","value":"56358"}],"17252":[{"label":"Bill Cycle/10.0","value":"20424"}],"17256":[{"label":"Bill Cycle/20.0","value":"20428"}],"17330":[{"label":"Bill Cycle/0.0","value":"20510"}],"17334":[{"label":"Bill Cycle/100.0","value":"49940"}],"17360":[{"label":"Bill Cycle/10.0","value":"20540"}],"17394":[{"label":"Bill Cycle/0.0","value":"20586"}],"17396":[{"label":"Bill Cycle/10.0","value":"20588"}],"17400":[{"label":"Bill Cycle/0.0","value":"20592"}],"17404":[{"label":"Bill Cycle/0.0","value":"20596"}],"17408":[{"label":"Bill Cycle/100.0","value":"20600"}],"17410":[{"label":"Bill Cycle/0.0","value":"20602"}],"17456":[{"label":"Bill Cycle/100.0","value":"20656"}],"17460":[{"label":"Bill Cycle/100.0","value":"20660"}],"17462":[{"label":"Bill Cycle/55.0","value":"20664"}],"17736":[{"label":"Bill Cycle/10.0","value":"20970"}],"17738":[{"label":"Bill Cycle/10.0","value":"20972"}],"17794":[{"label":"Bill Cycle/100.0","value":"21042"}],"17870":[{"label":"Twelve Weeks/600.0","value":"21118"}],"17882":[{"label":"Bill Cycle/100.0","value":"21130"}],"17968":[{"label":"Bill Cycle/-100.0","value":"21244"}],"18040":[{"label":"Bill Cycle/100.0","value":"21344"}],"18044":[{"label":"Month/100.0","value":"21348"}],"18094":[{"label":"Bill Cycle/100.0","value":"21404"}],"18096":[{"label":"Bill Cycle/100.0","value":"21406"}],"18112":[{"label":"Bill Cycle/100.0","value":"21422"}],"18114":[{"label":"Bill Cycle/50.0","value":"21424"}],"18182":[{"label":"Bill Cycle/100.0","value":"21500"}],"18184":[{"label":"Bill Cycle/80.0","value":"21502"}],"18280":[{"label":"Bill Cycle/20.0","value":"21622"}],"18302":[{"label":"Bill Cycle/100.0","value":"21654"}],"18498":[{"label":"Bill Cycle/100.0","value":"21900"}],"18500":[{"label":"Bill Cycle/100.0","value":"21902"}],"18532":[{"label":"Bill Cycle/100.0","value":"21934"}],"18534":[{"label":"Bill Cycle/100.0","value":"21936"}],"18536":[{"label":"Bill Cycle/100.0","value":"21938"}],"18540":[{"label":"Bill Cycle/100.0","value":"21942"}],"18546":[{"label":"Month/150.0","value":"21948"}],"18578":[{"label":"Bill Cycle/10.0","value":"21986"}],"18582":[{"label":"Bill Cycle/10.0","value":"21990"}],"18588":[{"label":"Bill Cycle/10.0","value":"21996"}]},"MapofProductPriceEidVsPriceOverrideFlag":{"18826":true,"19128":true,"20292":true,"20314":true,"20318":true,"20362":true,"20364":true,"20366":true,"20402":true,"20412":true,"20424":true,"20428":true,"20510":true,"20540":true,"20586":true,"20588":true,"20592":true,"20596":true,"20600":true,"20602":true,"20656":true,"20660":true,"20664":true,"20970":true,"20972":true,"21042":true,"21118":true,"21130":true,"21244":true,"21344":true,"21348":true,"21404":true,"21406":true,"21422":true,"21424":true,"21500":true,"21502":true,"21622":true,"21654":true,"21900":true,"21902":true,"21934":true,"21936":true,"21938":true,"21942":true,"21948":true,"21986":true,"21990":true,"21996":true,"22334":false,"49264":true,"49940":true,"56358":true},"mapOfProductPriceEidVsPriceRangeList":{"18826":[{"currencyType":"USD","eid":"21016","level":1,"price":340,"quantityBeginRange":0}],"19128":[{"currencyType":"USD","eid":"21328","level":1,"price":198,"quantityBeginRange":0}],"20292":[{"currencyType":"USD","eid":"23218","level":1,"price":10,"quantityBeginRange":0}],"20314":[{"currencyType":"USD","eid":"23250","level":1,"price":10,"quantityBeginRange":0}],"20318":[{"currencyType":"USD","eid":"23254","level":1,"price":-10,"quantityBeginRange":0}],"20362":[{"currencyType":"USD","eid":"23326","level":1,"price":100,"quantityBeginRange":0}],"20364":[{"currencyType":"USD","eid":"23328","level":1,"price":-100,"quantityBeginRange":0}],"20366":[{"currencyType":"USD","eid":"23330","level":1,"price":100,"quantityBeginRange":0}],"20402":[{"currencyType":"USD","eid":"23366","level":1,"price":140,"quantityBeginRange":0}],"20412":[{"currencyType":"USD","eid":"23376","level":1,"price":10,"quantityBeginRange":0}],"20424":[{"currencyType":"USD","eid":"23388","level":1,"price":10,"quantityBeginRange":0}],"20428":[{"currencyType":"USD","eid":"23392","level":1,"price":20,"quantityBeginRange":0}],"20510":[{"currencyType":"USD","eid":"23528","level":1,"price":0,"quantityBeginRange":0}],"20540":[{"currencyType":"USD","eid":"23558","level":1,"price":10,"quantityBeginRange":0}],"20586":[{"currencyType":"USD","eid":"23604","level":1,"price":0,"quantityBeginRange":0}],"20588":[{"currencyType":"USD","eid":"23606","level":1,"price":10,"quantityBeginRange":0}],"20592":[{"currencyType":"USD","eid":"23610","level":1,"price":0,"quantityBeginRange":0}],"20596":[{"currencyType":"USD","eid":"23614","level":1,"price":0,"quantityBeginRange":0}],"20600":[{"currencyType":"USD","eid":"23618","level":1,"price":100,"quantityBeginRange":0}],"20602":[{"currencyType":"USD","eid":"23620","level":1,"price":0,"quantityBeginRange":0}],"20656":[{"currencyType":"USD","eid":"23680","level":1,"price":100,"quantityBeginRange":0}],"20660":[{"currencyType":"USD","eid":"23684","level":1,"price":100,"quantityBeginRange":0}],"20664":[{"currencyType":"USD","eid":"23688","level":1,"price":55,"quantityBeginRange":0}],"20970":[{"currencyType":"USD","eid":"24030","level":1,"price":10,"quantityBeginRange":0}],"20972":[{"currencyType":"USD","eid":"24032","level":1,"price":10,"quantityBeginRange":0}],"21042":[{"currencyType":"USD","eid":"24106","level":1,"price":100,"quantityBeginRange":0}],"21118":[{"currencyType":"USD","eid":"24210","level":1,"price":600,"quantityBeginRange":0}],"21130":[{"currencyType":"USD","eid":"24222","level":1,"price":100,"quantityBeginRange":0}],"21244":[{"currencyType":"USD","eid":"24336","level":1,"price":-100,"quantityBeginRange":0}],"21344":[{"currencyType":"USD","eid":"24436","level":1,"price":100,"quantityBeginRange":0}],"21348":[{"currencyType":"USD","eid":"24440","level":1,"price":100,"quantityBeginRange":0}],"21404":[{"currencyType":"USD","eid":"24496","level":1,"price":100,"quantityBeginRange":0}],"21406":[{"currencyType":"USD","eid":"24498","level":1,"price":100,"quantityBeginRange":0}],"21422":[{"currencyType":"USD","eid":"24514","level":1,"price":100,"quantityBeginRange":0}],"21424":[{"currencyType":"USD","eid":"24516","level":1,"price":50,"quantityBeginRange":0}],"21500":[{"currencyType":"USD","eid":"24592","level":1,"price":100,"quantityBeginRange":0}],"21502":[{"currencyType":"USD","eid":"24594","level":1,"price":80,"quantityBeginRange":0}],"21622":[{"currencyType":"USD","eid":"24722","level":1,"price":20,"quantityBeginRange":0}],"21654":[{"currencyType":"USD","eid":"24754","level":1,"price":100,"quantityBeginRange":0}],"21900":[{"currencyType":"USD","eid":"25000","level":1,"price":100,"quantityBeginRange":0}],"21902":[{"currencyType":"USD","eid":"25002","level":1,"price":100,"quantityBeginRange":0}],"21934":[{"currencyType":"USD","eid":"25034","level":1,"price":100,"quantityBeginRange":0}],"21936":[{"currencyType":"USD","eid":"25036","level":1,"price":100,"quantityBeginRange":0}],"21938":[{"currencyType":"USD","eid":"25038","level":1,"price":100,"quantityBeginRange":0}],"21942":[{"currencyType":"USD","eid":"25042","level":1,"price":100,"quantityBeginRange":0}],"21948":[{"currencyType":"USD","eid":"25048","level":1,"price":150,"quantityBeginRange":0}],"21986":[{"currencyType":"USD","eid":"25086","level":1,"price":10,"quantityBeginRange":0}],"21990":[{"currencyType":"USD","eid":"25090","level":1,"price":10,"quantityBeginRange":0}],"21996":[{"currencyType":"USD","eid":"25096","level":1,"price":10,"quantityBeginRange":0}],"22334":[{"currencyType":"USD","eid":"25454","level":1,"price":70,"quantityBeginRange":0}],"49264":[{"currencyType":"USD","eid":"53434","level":1,"price":10,"quantityBeginRange":0}],"49940":[{"currencyType":"USD","eid":"54122","level":1,"price":100,"quantityBeginRange":0}],"56358":[{"currencyType":"USD","eid":"61836","level":1,"price":10,"quantityBeginRange":0}]},"OrderDate":"2021-06-01","originalServiceName":"Test01/2 Sub2 Solomiia(2346616)","priceListId":"696","Quantity":1,"Recurringprice":10,"RecurringpriceId":"20424","totalPrice":10,"Type":"Subscription"}'
    );
    AccountDetailController_LT.getIdentifierList('test');
    AccountDetailController_LT.createIdentifier('test', 'test');
    /*********test for newactivitywrapper*******/
    ProductServiceWrapper testobj = new ProductServiceWrapper();
    testobj.serviceName = 'test';
    testobj.thistract = tract;
    testobj.thisAccount = Acc;
    testobj.TractUrl = '';
    testobj.Quantity = 12.2;
    testobj.servicePrice = 'USD';
    testobj.checkRuleOverrideValue = true;
    testobj.ruleTypeValue = 'Test';
    testobj.parentServiceName = 'TestService';
    testobj.committedThru = 'Active';
    testobj.renewAction = 'True';
    testobj.statusDate = '12/2/2017';
    testobj.status = 'Active';
    testobj.serviceEid = 'A123';
    testobj.checkDeactivateService = false;
    testobj.checkChildElement = true;
    testobj.checkSuspendService = true;
    testobj.serialized = false;
    testobj.productEid = 'Prd1234';
    testobj.serviceProductCode = 'Code123';
    testobj.checkServiceResource = true;
    testobj.childServiceSuspendCheck = true;
    testobj.createBillingAccount = true;
    testobj.reasonList = new List<SelectOption>();
    testobj.suspendReasonList = new List<SelectOption>();
    testobj.countryListTract = new List<SelectOption>();
    testobj.stateUsaTract = new List<SelectOption>();
    testobj.stateMexTract = new List<SelectOption>();
    testobj.stateCanTract = new List<SelectOption>();
    testobj.chargeRuleWrapper = new AccountDetailController_LT.ChargeRulesWrapper();
    testobj.childElements = new List<ProductServiceWrapper>();
    testobj.chargeRuleWrapper.selectStatusListValue = 'Draft';
    testobj.chargeRuleWrapper.productUsageRuleListValue = 'Match All Events';
    testobj.chargeRuleWrapper.rateTypeListValue = 'Flat';
    testobj.chargeRuleWrapper.chargesPicklistValue = ' ';
    testobj.chargeRuleWrapper.allowanceTypeListValue = 'Recurring';
    testobj.chargeRuleWrapper.roleOverListValue = 'None';
    testobj.chargeRuleWrapper.formulaFieldValue = ' ';
    testobj.chargeRuleWrapper.operationListValue = ' ';
    testobj.chargeRuleWrapper.passThroughChargeListValue = ' ';
    testobj.chargeRuleWrapper.formulaUsageRuleListValue = ' ';
    testobj.chargeRuleWrapper.chargeListBytesValue = ' ';
    testobj.chargeRuleWrapper.chargeCategoryListValue = ' ';
    testobj.chargeRuleWrapper.ServiceUsageRuleName = ' ';
    testobj.chargeRuleWrapper.chargeValue = 0;
    testobj.chargeRuleWrapper.ammountValue = 0;
    testobj.chargeRuleWrapper.ActivityFormulaValue = ' ';
    testobj.chargeRuleWrapper.prorateOnOrder = false;
    testobj.chargeRuleWrapper.prorateOnCancel = false;
    testobj.chargeRuleWrapper.amountChargePickList = 'test';
    InvoiceWrapper invoiceWrap = new InvoiceWrapper();
    invoiceWrap.currencyType = 'USD';
    getwrap = Json.serialize(testobj);
    string getProdWrap = Json.serialize(testobj);
    AccountDetailController_LT.deserializeProductServiceWrapper(getProdWrap);
    AccountDetailController_LT.createNewActivityChargeRule(getwrap);
    AccountDetailController_LT.paymentRecords(accWrap, 1);
    AccountDetailController_LT.Notes(JSON.serialize(Acc), 1);
    AccountDetailController_LT.getBillingAccountStatusChangeReason('Suspend');
    AccountDetailController_LT.getBillingAccountStatusChangeReason(
      'Deactivate'
    );
    AccountDetailController_LT.getServiceResource('identifire');
    AccountDetailController_LT.resumeBillingAccount(JSON.serialize(Acc));
    AccountDetailController_LT.deactivateBillingAccount(
      JSON.serialize(Acc),
      '1234'
    );
    AccountDetailController_LT.suspendBillingAccount(
      JSON.serialize(Acc),
      '1234'
    );
    AccountDetailController_LT.changeServiceResource(
      JSON.serialize(wrappercls),
      'test',
      true,
      JSON.serialize(System.today()),
      '12345'
    );
    AccountDetailController_LT.changeServiceResource(
      JSON.serialize(wrappercls),
      'test',
      false,
      JSON.serialize(System.today()),
      '12345'
    );
    AccountDetailController_LT.applyServiceResourceToService(
      '1234',
      'test',
      true,
      String.valueof(System.today())
    );
    AccountDetailController_LT.applyServiceResourceToService(
      '1234',
      'test',
      false,
      String.valueof(System.today())
    );
    AccountDetailController_LT.getAccountCustomFieldValueList(Acc.Id);
    AccountDetailController_LT.getAccountCustomFieldsList(JSON.serialize(Acc));
    AccountDetailController_LT.contacts(JSON.serialize(Acc), 1);
    AccountDetailController_LT.getServiceDetail(JSON.serialize(testobj));
    AccountDetailController_LT.getInvoiceData(JSON.serialize(invoiceWrap));
    AccountDetailController_LT.saveAccountDetails(
      Acc.Id,
      JSON.serialize(accountEditWrap)
    );
    AccountDetailController_LT.getAccountEntityData(Acc.Id);
    AccountDetailController_LT.getBillCycleData('USD', '1234');
    AccountDetailController_LT.getAgreementAndPriceConfigurationForChangedService(
      JSON.serialize(subscriptionWrapper),
      'USD'
    );
    AccountDetailController_LT.convertServiceTract('1234');
    test.stopTest();
  }

  static testMethod void testAccountdetail3() {
    String dayOrDate = '2015-06-30';
    String getwrap = '{}';
    Test.setMock(WebServiceMock.class, new AccountDetailMock_Test());
    Account acc = HelperClass.getAccount();
    insert acc;
    System_Setting__c settings = new System_Setting__c(
      name = 'Currency Identification',
      Value__c = 'ISO Code'
    );
    system.assert(settings != null);
    insert settings;
    Contact cont = new Contact(LastName = 'Testcont', AccountId = Acc.id);
    system.assert(cont != null);
    insert cont;
    TRACT_Setup__c tract = HelperClass.getAPI2TRACT();
    insert tract;
    TRACT_Mappings__c maptract = new TRACT_Mappings__c();
    maptract.name = 'TRACT Account Mapping';
    maptract.TRACT_Account_Fields__c = '{ "AccountName":[ "Contact.Name", "Select from the Related List", "Name starts with test" ], "AccountNumber":[ "ParentId.AccountNumber", "Select from the Same Record", "" ], "BillingStreet":[ "BillingStreet", "Select from the Same Record", "" ], "BillingCity":[ "Contact.MailingCity", "Select from the Related List", "MailingCity equals test" ], "BillingCode":[ "Contact.MailingPostalCode", "Select from the Related List", "MailingPostalCode contains 1234" ], "BillingState":[ "BillingState", "Select from the Same Record", "" ], "BillingCountry":[ "Contact.MailingCountry", "Select from the Related List", "MailingCountry ends with test" ], "ShippingStreet":[ "ShippingStreet", "Select from the Same Record", "" ], "ShippingCity":[ "ShippingCity", "Select from the Same Record", "" ], "ShippingCode":[ "ShippingPostalCode", "Select from the Same Record", "" ], "ShippingState":[ "ShippingState", "Select from the Same Record", "" ], "ShippingCountry":[ "ShippingCountry", "Select from the Same Record", "" ], "Phone":[ "Phone", "Select from the Same Record", "" ], "GotransverseEmail":[ "TRACT3__Email__c", "Select from the Same Record", "" ] }';
    insert maptract;
    list<ProductServiceWrapper> wrapperclsList = new List<ProductServiceWrapper>();
    ProductServiceWrapper wrappercls = new ProductServiceWrapper();
    wrappercls.createBillingAccount = true;
    wrappercls.serviceEid = 'tst';
    wrappercls.servicProducteName = 'prod';
    wrappercls.serviceEid = 'service';
    wrapperclsList.add(wrappercls);
    Map<String, Decimal> mapOfAgreementPeriod = new Map<String, Decimal>();
    Map<String, String> productPriceIdToEidMap = new Map<String, String>();
    TractAdjustmentWrapper taw = new TractAdjustmentWrapper();
    list<AdjustmentWrapper> adList = new List<AdjustmentWrapper>();
    AdjustmentWrapper adjustWrap1 = new AdjustmentWrapper();
    adjustWrap1.Name = 'test';
    adjustWrap1.Type = 'Manual Adjustment';
    adjustWrap1.reason = 'Default Debit Adjustment Reason';
    adjustWrap1.description = 'test';
    adjustWrap1.Status = 'Pending';
    adjustWrap1.ManuallyApply = 'No';
    adjustWrap1.credit = true;
    adList.add(adjustWrap1);
    AdjustmentWrapper adjustWrap2 = new AdjustmentWrapper();
    adjustWrap2.Name = 'test';
    adjustWrap2.Type = 'Manual Adjustment';
    adjustWrap2.reason = 'Default Debit Adjustment Reason';
    adjustWrap2.description = 'test';
    adjustWrap2.Status = 'Pending';
    adjustWrap2.ManuallyApply = 'No';
    adjustWrap2.credit = false;
    adList.add(adjustWrap2);
    TRACTAccountWrapper accountWrap = new TRACTAccountWrapper();
    accountWrap.accountCategory = 'All accounts';
    accountWrap.status = 'Active';
    accountWrap.billType = 'Email';
    accountWrap.billCycleType = 'Monthly';
    accountWrap.billCycleName = 'All accounts';
    accountWrap.eid = '12345';
    accountWrap.TractBillingAccountNumber = '12345';
    accountWrap.accountCurrency = 'USD';
    accountWrap.billingAccount = Acc;
    String accWrap = JSON.serialize(accountWrap);
    list<AccountCustomFieldWrapper> customFieldWrapList = new List<AccountCustomFieldWrapper>();
    AccountCustomFieldWrapper wrap = new AccountCustomFieldWrapper();
    wrap.Name = '';
    wrap.Eid = '';
    wrap.Value = 'Test';
    wrap.selectedListTypeValue = 'test';
    wrap.fieldValidationType = '';
    wrap.checkListtype = false;
    wrap.storeListTypeValues = new List<SelectOption>();
    customFieldWrapList.add(wrap);
    String customfieldWrapperString = JSON.serialize(customFieldWrapList);
    list<Product2> lstProduct = new List<Product2>();
    Product2 prod = HelperClass.getProduct2();
    prod.eid__c = '2679616';
    lstProduct.add(prod);
    insert lstProduct;
    test.startTest();
    Account billingAccount = AccountDetailController_LT.getBillingAccount(
      Acc.id
    );
    System.assert(billingAccount.Tract_Billing_Account__c != null);
    System.assertEquals(billingAccount.Name, Acc.Name);
    AccountDetailController_LT.setUpServices(accWrap, 1);
    AccountDetailController_LT.getSalesOrder(accWrap, 1);
    AccountDetailController_LT.getBillingAccount(tract, Acc);
    AccountDetailController_LT.setUpPayments(accWrap, 1);
    AccountDetailController_LT.setUpDebitAdjustment(accWrap, 1);
    AccountDetailController_LT.setUpCreditAdjustment(accWrap, 1);
    AccountDetailController_LT.setUpInvoices(accWrap, 1);
    AccountDetailController_LT.showServices(Acc, 'test');
    AccountDetailController_LT.savePopupRenew(
      'renewAgreementEid',
      tract,
      Acc,
      'serviceRenewEid',
      '102',
      '21',
      true,
      string.valueOf(System.today())
    );
    AccountDetailController_LT.saveDeactivateService(
      'serviceEid',
      'reasonEid',
      '10-09-2016'
    );
    AccountDetailController_LT.suspendServiceTract('serviceEid', 'reasonEid');
    AccountDetailController_LT.saveChangeServicesOnApex(
      'newSubscriptionEid',
      'effectiveDateValue',
      'currentServiceEid',
      Acc,
      true,
      mapOfAgreementPeriod,
      productPriceIdToEidMap,
      4,
      'RENEW_AGREEMENT',
      'agreementEidForChangedService',
      20.3,
      'recurringPriceId',
      JSON.serialize(true)
    );
    AccountDetailController_LT.saveAddAddressTract(
      'currentServiceEid',
      'countryListValue',
      'BillingCity',
      'BillingCity',
      'ShippingCity',
      'stateValue',
      '223344'
    );
    AccountDetailController_LT.showActivityChargeRule('activityProductEid');
    AccountDetailController_LT.showDebitAdjustment();
    AccountDetailController_LT.showCreditAdjustment();
    AccountDetailController_LT.resumeServiceTract('serviceEidValue');
    AccountDetailController_LT.deleteActivityChargeRule(
      tract,
      'activityProductEid',
      'deletedUsageEid',
      'activityRuleName'
    );
    AccountDetailController_LT.getServiceReason();
    AccountDetailController_LT.getBillingAccountdetail(Acc.id);
    AccountDetailController_LT.saveDebitAdjustmentTract(
      Acc.id,
      'adjustmentReasonEid',
      '100',
      'description',
      String.valueOf(Date.today())
    );
    AccountDetailController_LT.saveCreditAdjustmentTract(
      Acc.id,
      'adjustmentReasonEid',
      '100',
      'description',
      String.valueOf(Date.today()),
      true
    );
    AccountDetailController_LT.getOneTimeOrderItemList(accWrap);
    AccountDetailController_LT.UpdateQuantityInTract(
      'serviceEidValue',
      '10',
      true,
      String.valueOf(Date.today())
    );
    AccountDetailController_LT.showUpdateQuantity();
    AccountDetailController_LT.getpermissions();
    AccountDetailController_LT.setUpUsagesEvents(accWrap, 4);
    AccountDetailController_LT.getContactDetail(cont.id);
    AccountDetailController_LT.pdfDownload(
      Acc.id,
      'https://tractlightning/getinvoices/01p7F00000C7bDy/d'
    );
    AccountDetailController_LT.saveAccountCustomField(
      customfieldWrapperString,
      accWrap
    );
    AccountDetailController_LT.showPopupChangeService('12345', 'USD', true);
    AccountDetailController_LT.getChildAccountDetails('12345');
    AccountDetailController_LT.getBillingHierarchy('12345');
    AccountDetailController_LT.createPaymentMethod(
      '{"firstName":"Test","middleName":"Test","lastName":"Test","suffix":"Mr.","cardType":[],"cardTypeSelect":"VISA","cardNumber":"41111111111111111","cvv":"234","expiryDate":"05/2025","email":"test@gmail.com","street":"Test1","city":"New York","country":"United States","postalCode":"23456","autoPayment" : true}',
      Acc.id
    );
    AccountDetailController_LT.getConfigDetails(Acc.id);
    AccountDetailController_LT.getPaymentMethodForPayment(Acc.Id);
    AccountDetailController_LT.executePayment(
      Acc.id,
      '{"firstName":"Test","middleName":"Test","lastName":"Test","suffix":"Mr.","cardType":[],"cardTypeSelect":"VISA","cardNumber":"41111111111111111","cvv":"234","expiryDate":"05/2025","email":"test@gmail.com","street":"Test1","city":"New York","country":"United States","postalCode":"23456"}'
    );
    AccountDetailController_LT.getCreateChangeServiceWrapper('Test', 'USD');
    AccountDetailController_LT.createChangeOrderInGTV(
      '{"compatibleProductList":[{"label":"Test01/2 Sub2 Solomiia","value":"17252"},{"label":"SubProd_03","value":"13052"},{"label":"Sub_01","value":"13318"},{"label":"Subprod_01 8/4","value":"17150"},{"label":"S-orad","value":"17174"},{"label":"S-orad2","value":"17178"},{"label":"S-tax","value":"17202"},{"label":"S-orad-n","value":"17204"},{"label":"Sub","value":"17206"},{"label":"Sub taxable","value":"17234"},{"label":"Test01/1 Sub1 Solomiia","value":"17242"},{"label":"Test02 Sub Solomiia","value":"17256"},{"label":"Subprod 8/23","value":"17330"},{"label":"Subprod_01 8/23","value":"17334"},{"label":"Subprod_3 8/24","value":"17360"},{"label":"3-S","value":"17394"},{"label":"Subprod_01 8/28","value":"17396"},{"label":"Prod_01 8/28","value":"17400"},{"label":"Subprod_02 8/28","value":"17404"},{"label":"Subprod_04 8/28","value":"17408"},{"label":"3-S-1","value":"17410"},{"label":"Subprod_01 9/4","value":"17456"},{"label":"Subprod_01 9/4 tax","value":"17460"},{"label":"Subprod_04 tax","value":"17462"},{"label":"DSU Subscription","value":"17736"},{"label":"DSU Subscription #2","value":"17738"},{"label":"Subprod_01 10/4","value":"17794"},{"label":"Sub Twelve Weeks","value":"17870"},{"label":"Subprod_01 10/9","value":"17882"},{"label":"1-1","value":"17968"},{"label":"Subprod_01 10/18","value":"18040"},{"label":"Subprod_04 10/18","value":"18044"},{"label":"Subprod_01 10/19","value":"18094"},{"label":"Subprod_02 10/19","value":"18096"},{"label":"299739","value":"18112"},{"label":"299739-2","value":"18114"},{"label":"Subprod_01 10/20","value":"18182"},{"label":"Subprod_02 10/20","value":"18184"},{"label":"4-s","value":"18280"},{"label":"Subprod_01 10/26","value":"18302"},{"label":"Sub_1","value":"18498"},{"label":"Sub_2","value":"18500"},{"label":"Sub_01 11/2","value":"18532"},{"label":"Sub_02 11/2 no tax","value":"18534"},{"label":"Sub_03 11/2","value":"18536"},{"label":"Sub_04 11/2","value":"18540"},{"label":"UPROM-477","value":"18546"},{"label":"Sub_01 11.3","value":"18578"},{"label":"Sub_tax1","value":"18582"},{"label":"Sub_2 tax","value":"18588"}],"currencyType":"USD","currentProductId":"17252","currentServiceId":"2346616","EmailReciept":false,"MapofProductEidVsSerializedFlag":{},"MapOfProductIdVsOneTimePriceList":{"17738":[{"label":"One-Time /10.0","value":"49264"}],"18096":[{"label":"One-Time /70.0","value":"22334"}]},"MapOfProductIdVsRecurrencePriceList":{"13052":[{"label":"Bill Cycle/340.0","value":"18826"}],"13318":[{"label":"Bill Cycle/198.0","value":"19128"}],"17150":[{"label":"Bill Cycle/10.0","value":"20292"}],"17174":[{"label":"Bill Cycle/10.0","value":"20314"}],"17178":[{"label":"Bill Cycle/-10.0","value":"20318"}],"17202":[{"label":"Bill Cycle/100.0","value":"20362"}],"17204":[{"label":"Bill Cycle/-100.0","value":"20364"}],"17206":[{"label":"Bill Cycle/100.0","value":"20366"}],"17234":[{"label":"Bill Cycle/140.0","value":"20402"}],"17242":[{"label":"Bill Cycle/10.0","value":"20412"},{"label":"Two Years/10.0","value":"56358"}],"17252":[{"label":"Bill Cycle/10.0","value":"20424"}],"17256":[{"label":"Bill Cycle/20.0","value":"20428"}],"17330":[{"label":"Bill Cycle/0.0","value":"20510"}],"17334":[{"label":"Bill Cycle/100.0","value":"49940"}],"17360":[{"label":"Bill Cycle/10.0","value":"20540"}],"17394":[{"label":"Bill Cycle/0.0","value":"20586"}],"17396":[{"label":"Bill Cycle/10.0","value":"20588"}],"17400":[{"label":"Bill Cycle/0.0","value":"20592"}],"17404":[{"label":"Bill Cycle/0.0","value":"20596"}],"17408":[{"label":"Bill Cycle/100.0","value":"20600"}],"17410":[{"label":"Bill Cycle/0.0","value":"20602"}],"17456":[{"label":"Bill Cycle/100.0","value":"20656"}],"17460":[{"label":"Bill Cycle/100.0","value":"20660"}],"17462":[{"label":"Bill Cycle/55.0","value":"20664"}],"17736":[{"label":"Bill Cycle/10.0","value":"20970"}],"17738":[{"label":"Bill Cycle/10.0","value":"20972"}],"17794":[{"label":"Bill Cycle/100.0","value":"21042"}],"17870":[{"label":"Twelve Weeks/600.0","value":"21118"}],"17882":[{"label":"Bill Cycle/100.0","value":"21130"}],"17968":[{"label":"Bill Cycle/-100.0","value":"21244"}],"18040":[{"label":"Bill Cycle/100.0","value":"21344"}],"18044":[{"label":"Month/100.0","value":"21348"}],"18094":[{"label":"Bill Cycle/100.0","value":"21404"}],"18096":[{"label":"Bill Cycle/100.0","value":"21406"}],"18112":[{"label":"Bill Cycle/100.0","value":"21422"}],"18114":[{"label":"Bill Cycle/50.0","value":"21424"}],"18182":[{"label":"Bill Cycle/100.0","value":"21500"}],"18184":[{"label":"Bill Cycle/80.0","value":"21502"}],"18280":[{"label":"Bill Cycle/20.0","value":"21622"}],"18302":[{"label":"Bill Cycle/100.0","value":"21654"}],"18498":[{"label":"Bill Cycle/100.0","value":"21900"}],"18500":[{"label":"Bill Cycle/100.0","value":"21902"}],"18532":[{"label":"Bill Cycle/100.0","value":"21934"}],"18534":[{"label":"Bill Cycle/100.0","value":"21936"}],"18536":[{"label":"Bill Cycle/100.0","value":"21938"}],"18540":[{"label":"Bill Cycle/100.0","value":"21942"}],"18546":[{"label":"Month/150.0","value":"21948"}],"18578":[{"label":"Bill Cycle/10.0","value":"21986"}],"18582":[{"label":"Bill Cycle/10.0","value":"21990"}],"18588":[{"label":"Bill Cycle/10.0","value":"21996"}]},"MapofProductPriceEidVsPriceOverrideFlag":{"18826":true,"19128":true,"20292":true,"20314":true,"20318":true,"20362":true,"20364":true,"20366":true,"20402":true,"20412":true,"20424":true,"20428":true,"20510":true,"20540":true,"20586":true,"20588":true,"20592":true,"20596":true,"20600":true,"20602":true,"20656":true,"20660":true,"20664":true,"20970":true,"20972":true,"21042":true,"21118":true,"21130":true,"21244":true,"21344":true,"21348":true,"21404":true,"21406":true,"21422":true,"21424":true,"21500":true,"21502":true,"21622":true,"21654":true,"21900":true,"21902":true,"21934":true,"21936":true,"21938":true,"21942":true,"21948":true,"21986":true,"21990":true,"21996":true,"22334":false,"49264":true,"49940":true,"56358":true},"mapOfProductPriceEidVsPriceRangeList":{"18826":[{"currencyType":"USD","eid":"21016","level":1,"price":340,"quantityBeginRange":0}],"19128":[{"currencyType":"USD","eid":"21328","level":1,"price":198,"quantityBeginRange":0}],"20292":[{"currencyType":"USD","eid":"23218","level":1,"price":10,"quantityBeginRange":0}],"20314":[{"currencyType":"USD","eid":"23250","level":1,"price":10,"quantityBeginRange":0}],"20318":[{"currencyType":"USD","eid":"23254","level":1,"price":-10,"quantityBeginRange":0}],"20362":[{"currencyType":"USD","eid":"23326","level":1,"price":100,"quantityBeginRange":0}],"20364":[{"currencyType":"USD","eid":"23328","level":1,"price":-100,"quantityBeginRange":0}],"20366":[{"currencyType":"USD","eid":"23330","level":1,"price":100,"quantityBeginRange":0}],"20402":[{"currencyType":"USD","eid":"23366","level":1,"price":140,"quantityBeginRange":0}],"20412":[{"currencyType":"USD","eid":"23376","level":1,"price":10,"quantityBeginRange":0}],"20424":[{"currencyType":"USD","eid":"23388","level":1,"price":10,"quantityBeginRange":0}],"20428":[{"currencyType":"USD","eid":"23392","level":1,"price":20,"quantityBeginRange":0}],"20510":[{"currencyType":"USD","eid":"23528","level":1,"price":0,"quantityBeginRange":0}],"20540":[{"currencyType":"USD","eid":"23558","level":1,"price":10,"quantityBeginRange":0}],"20586":[{"currencyType":"USD","eid":"23604","level":1,"price":0,"quantityBeginRange":0}],"20588":[{"currencyType":"USD","eid":"23606","level":1,"price":10,"quantityBeginRange":0}],"20592":[{"currencyType":"USD","eid":"23610","level":1,"price":0,"quantityBeginRange":0}],"20596":[{"currencyType":"USD","eid":"23614","level":1,"price":0,"quantityBeginRange":0}],"20600":[{"currencyType":"USD","eid":"23618","level":1,"price":100,"quantityBeginRange":0}],"20602":[{"currencyType":"USD","eid":"23620","level":1,"price":0,"quantityBeginRange":0}],"20656":[{"currencyType":"USD","eid":"23680","level":1,"price":100,"quantityBeginRange":0}],"20660":[{"currencyType":"USD","eid":"23684","level":1,"price":100,"quantityBeginRange":0}],"20664":[{"currencyType":"USD","eid":"23688","level":1,"price":55,"quantityBeginRange":0}],"20970":[{"currencyType":"USD","eid":"24030","level":1,"price":10,"quantityBeginRange":0}],"20972":[{"currencyType":"USD","eid":"24032","level":1,"price":10,"quantityBeginRange":0}],"21042":[{"currencyType":"USD","eid":"24106","level":1,"price":100,"quantityBeginRange":0}],"21118":[{"currencyType":"USD","eid":"24210","level":1,"price":600,"quantityBeginRange":0}],"21130":[{"currencyType":"USD","eid":"24222","level":1,"price":100,"quantityBeginRange":0}],"21244":[{"currencyType":"USD","eid":"24336","level":1,"price":-100,"quantityBeginRange":0}],"21344":[{"currencyType":"USD","eid":"24436","level":1,"price":100,"quantityBeginRange":0}],"21348":[{"currencyType":"USD","eid":"24440","level":1,"price":100,"quantityBeginRange":0}],"21404":[{"currencyType":"USD","eid":"24496","level":1,"price":100,"quantityBeginRange":0}],"21406":[{"currencyType":"USD","eid":"24498","level":1,"price":100,"quantityBeginRange":0}],"21422":[{"currencyType":"USD","eid":"24514","level":1,"price":100,"quantityBeginRange":0}],"21424":[{"currencyType":"USD","eid":"24516","level":1,"price":50,"quantityBeginRange":0}],"21500":[{"currencyType":"USD","eid":"24592","level":1,"price":100,"quantityBeginRange":0}],"21502":[{"currencyType":"USD","eid":"24594","level":1,"price":80,"quantityBeginRange":0}],"21622":[{"currencyType":"USD","eid":"24722","level":1,"price":20,"quantityBeginRange":0}],"21654":[{"currencyType":"USD","eid":"24754","level":1,"price":100,"quantityBeginRange":0}],"21900":[{"currencyType":"USD","eid":"25000","level":1,"price":100,"quantityBeginRange":0}],"21902":[{"currencyType":"USD","eid":"25002","level":1,"price":100,"quantityBeginRange":0}],"21934":[{"currencyType":"USD","eid":"25034","level":1,"price":100,"quantityBeginRange":0}],"21936":[{"currencyType":"USD","eid":"25036","level":1,"price":100,"quantityBeginRange":0}],"21938":[{"currencyType":"USD","eid":"25038","level":1,"price":100,"quantityBeginRange":0}],"21942":[{"currencyType":"USD","eid":"25042","level":1,"price":100,"quantityBeginRange":0}],"21948":[{"currencyType":"USD","eid":"25048","level":1,"price":150,"quantityBeginRange":0}],"21986":[{"currencyType":"USD","eid":"25086","level":1,"price":10,"quantityBeginRange":0}],"21990":[{"currencyType":"USD","eid":"25090","level":1,"price":10,"quantityBeginRange":0}],"21996":[{"currencyType":"USD","eid":"25096","level":1,"price":10,"quantityBeginRange":0}],"22334":[{"currencyType":"USD","eid":"25454","level":1,"price":70,"quantityBeginRange":0}],"49264":[{"currencyType":"USD","eid":"53434","level":1,"price":10,"quantityBeginRange":0}],"49940":[{"currencyType":"USD","eid":"54122","level":1,"price":100,"quantityBeginRange":0}],"56358":[{"currencyType":"USD","eid":"61836","level":1,"price":10,"quantityBeginRange":0}]},"OrderDate":"2021-06-01","originalServiceName":"Test01/2 Sub2 Solomiia(2346616)","priceListId":"696","Quantity":1,"Recurringprice":10,"RecurringpriceId":"20424","totalPrice":10,"Type":"Subscription"}'
    );
    AccountDetailController_LT.getIdentifierList('test');
    AccountDetailController_LT.createIdentifier('test', 'test');
    /*********test for newactivitywrapper*******/
    ProductServiceWrapper testobj = new ProductServiceWrapper();
    testobj.serviceName = 'test';
    testobj.thistract = tract;
    testobj.thisAccount = Acc;
    testobj.TractUrl = '';
    testobj.Quantity = 12.2;
    testobj.servicePrice = 'USD';
    testobj.checkRuleOverrideValue = true;
    testobj.ruleTypeValue = 'Test';
    testobj.parentServiceName = 'TestService';
    testobj.committedThru = 'Active';
    testobj.renewAction = 'True';
    testobj.statusDate = '12/2/2017';
    testobj.status = 'Active';
    testobj.serviceEid = 'A123';
    testobj.checkDeactivateService = false;
    testobj.checkChildElement = true;
    testobj.checkSuspendService = true;
    testobj.serialized = false;
    testobj.productEid = 'Prd1234';
    testobj.serviceProductCode = 'Code123';
    testobj.checkServiceResource = true;
    testobj.childServiceSuspendCheck = true;
    testobj.createBillingAccount = true;
    testobj.reasonList = new List<SelectOption>();
    testobj.suspendReasonList = new List<SelectOption>();
    testobj.countryListTract = new List<SelectOption>();
    testobj.stateUsaTract = new List<SelectOption>();
    testobj.stateMexTract = new List<SelectOption>();
    testobj.stateCanTract = new List<SelectOption>();
    testobj.chargeRuleWrapper = new AccountDetailController_LT.ChargeRulesWrapper();
    testobj.childElements = new List<ProductServiceWrapper>();
    testobj.chargeRuleWrapper.selectStatusListValue = 'Draft';
    testobj.chargeRuleWrapper.productUsageRuleListValue = 'Match All Events';
    testobj.chargeRuleWrapper.rateTypeListValue = 'Flat';
    testobj.chargeRuleWrapper.chargesPicklistValue = ' ';
    testobj.chargeRuleWrapper.allowanceTypeListValue = 'Recurring';
    testobj.chargeRuleWrapper.roleOverListValue = 'None';
    testobj.chargeRuleWrapper.formulaFieldValue = ' ';
    testobj.chargeRuleWrapper.operationListValue = ' ';
    testobj.chargeRuleWrapper.passThroughChargeListValue = ' ';
    testobj.chargeRuleWrapper.formulaUsageRuleListValue = ' ';
    testobj.chargeRuleWrapper.chargeListBytesValue = ' ';
    testobj.chargeRuleWrapper.chargeCategoryListValue = ' ';
    testobj.chargeRuleWrapper.ServiceUsageRuleName = ' ';
    testobj.chargeRuleWrapper.chargeValue = 0;
    testobj.chargeRuleWrapper.ammountValue = 0;
    testobj.chargeRuleWrapper.ActivityFormulaValue = ' ';
    testobj.chargeRuleWrapper.prorateOnOrder = false;
    testobj.chargeRuleWrapper.prorateOnCancel = false;
    testobj.chargeRuleWrapper.amountChargePickList = 'test';
    InvoiceWrapper invoiceWrap = new InvoiceWrapper();
    invoiceWrap.currencyType = 'USD';
    getwrap = Json.serialize(testobj);
    string getProdWrap = Json.serialize(testobj);
    AccountDetailController_LT.deserializeProductServiceWrapper(getProdWrap);
    AccountDetailController_LT.createNewActivityChargeRule(getwrap);
    AccountDetailController_LT.paymentRecords(accWrap, 1);
    AccountDetailController_LT.Notes(JSON.serialize(Acc), 1);
    AccountDetailController_LT.getBillingAccountStatusChangeReason('Suspend');
    AccountDetailController_LT.getBillingAccountStatusChangeReason(
      'Deactivate'
    );
    AccountDetailController_LT.getServiceResource('identifire');
    AccountDetailController_LT.resumeBillingAccount(JSON.serialize(Acc));
    AccountDetailController_LT.deactivateBillingAccount(
      JSON.serialize(Acc),
      '1234'
    );
    AccountDetailController_LT.suspendBillingAccount(
      JSON.serialize(Acc),
      '1234'
    );
    AccountDetailController_LT.changeServiceResource(
      JSON.serialize(wrappercls),
      'test',
      true,
      JSON.serialize(System.today()),
      '12345'
    );
    AccountDetailController_LT.changeServiceResource(
      JSON.serialize(wrappercls),
      'test',
      false,
      JSON.serialize(System.today()),
      '12345'
    );
    AccountDetailController_LT.applyServiceResourceToService(
      '1234',
      'test',
      true,
      String.valueof(System.today())
    );
    AccountDetailController_LT.applyServiceResourceToService(
      '1234',
      'test',
      false,
      String.valueof(System.today())
    );
    AccountDetailController_LT.getAccountCustomFieldValueList(Acc.Id);
    AccountDetailController_LT.getAccountCustomFieldsList(JSON.serialize(Acc));
    AccountDetailController_LT.contacts(JSON.serialize(Acc), 1);
    AccountDetailController_LT.getServiceDetail(JSON.serialize(testobj));
    AccountDetailController_LT.getInvoiceData(JSON.serialize(invoiceWrap));
    AccountDetailController_LT.convertServiceTract('1234');
    test.stopTest();
  }
}