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
 * This class is a test class of RestAPI2Service class.
 * @author Aman Jain
 */

@isTest
public with sharing class RestAPI2Service_Test {
  @isTest
  public static void myUnitTest() {
    Map<String, Object> params = new Map<String, Object>();
    params.put(
      'billingAccount',
      new RestAPI2Domain.GTVAPICreateBillingAccount()
    );
    params.put('prefer', 'x-api-key');
    RestAPI2Service.GTVAPIBillingAccountService obj = new RestAPI2Service.GTVAPIBillingAccountService();
    System.assert(obj != null);
    obj.createBillingAccount(params);
    params.put('id', '123');
    params.put('payment', new RestAPI2Domain.GTVAPICreatePayment());
    obj.createPayment(params);
    params.put(
      'recurringPayment',
      new RestAPI2Domain.GTVAPICreateRecurringPayment()
    );
    obj.createRecurringPayment(params);
    params.put(
      'billingAccountCustomFieldValue',
      new RestAPI2Domain.GTVAPICreateBillingAccountCustomFi()
    );
    obj.createBillingAccountCustomFieldValue(params);
    obj.getBillingAccount(params);
    params.put('customFieldValueId', '123');
    obj.getBillingAccountCustomFieldValue(params);
    params.put('orderId', '123');
    obj.getOrderByBillingAccount(params);
    obj.getParentBillingAccount(params);
    params.put('paymentId', '123');
    obj.getPaymentByBillingAccount(params);
    params.put('recurringPaymentId', '123');
    obj.getRecurringPaymentByBillingAccount(params);
    obj.getResponsibleAccount(params);
    obj.queryBillingAccountCustomFieldValues(params);
    obj.removeBillingAccountCustomFieldValue(params);
    obj.removeParentAccount(params);
    obj.removeResponsibleAccount(params);
    params.put('billingAccount', new RestAPI2Domain.GTVAPIBillingAccount());
    obj.updateBillingAccount(params);
    obj.queryBillingAccounts(params);
    params.put(
      'suspendBillingAccount',
      new RestAPI2Domain.GTVAPISuspendBillingAccount()
    );
    obj.suspendBillingAccount(params);
    params.put(
      'deactivateBillingAccount',
      new RestAPI2Domain.GTVAPIDeactivateBillingAccount()
    );
    obj.deactivateBillingAccount(params);
    params.put(
      'resumeBillingAccount',
      new RestAPI2Domain.GTVAPIResumeBillingAccount()
    );
    obj.resumeBillingAccount(params);

    RestAPI2Service.GTVAPIBillingAccountCategoryService billingAccountCategoryServiceObj = new RestAPI2Service.GTVAPIBillingAccountCategoryService();
    System.assert(billingAccountCategoryServiceObj != null);
    billingAccountCategoryServiceObj.queryBillingAccountCategories(params);
    billingAccountCategoryServiceObj.getBillingAccountCategory(params);

    RestAPI2Service.GTVAPIOrderService orderServiceObj = new RestAPI2Service.GTVAPIOrderService();
    System.assert(orderServiceObj != null);
    params.put('order', new RestAPI2Domain.GTVAPICreateSalesOrder());
    orderServiceObj.createOrder(params);
    orderServiceObj.queryOrders(params);
    params.put('order', new RestAPI2Domain.GTVAPIConfirmDraftOrder());
    orderServiceObj.confirmOrder(params);
    params.put(
      'orderCustomFieldValue',
      new RestAPI2Domain.GTVAPICreateOrderCustomFieldValue()
    );
    orderServiceObj.createOrderCustomFieldValue(params);
    orderServiceObj.getOrder(params);
    params.put('orderId', '123');
    orderServiceObj.getOrderByBillingAccount(params);
    orderServiceObj.getOrderCustomFieldValue(params);
    orderServiceObj.queryOrders(params);

    RestAPI2Service.GTVAPIPersonService personServiceObj = new RestAPI2Service.GTVAPIPersonService();
    System.assert(personServiceObj != null);
    params.put('personId', '123');
    params.put('addAddress', new RestAPI2Domain.GTVAPICreateAddress());
    personServiceObj.addPersonAddress(params);
    personServiceObj.getPerson(params);
    personServiceObj.getPersonAddress(params);
    personServiceObj.queryPeople(params);
    personServiceObj.queryPersonAddresses(params);
    params.put('person', new RestAPI2Domain.GTVAPIPerson());
    personServiceObj.updatePerson(params);

    RestAPI2Service.GTVAPIInvoiceService invoiceServiceObj = new RestAPI2Service.GTVAPIInvoiceService();
    System.assert(invoiceServiceObj != null);
    invoiceServiceObj.getInvoice(params);
    //invoiceServiceObj.getRenderedInvoice(params);
    invoiceServiceObj.queryInvoices(params);

    RestAPI2Service.GTVAPIPaymentService paymentServiceObj = new RestAPI2Service.GTVAPIPaymentService();
    System.assert(paymentServiceObj != null);
    paymentServiceObj.createPayment(params);
    paymentServiceObj.getPaymentByBillingAccount(params);
    paymentServiceObj.getPaymentByOrder(params);
    paymentServiceObj.queryPaymentsByBillingAccount(params);
    paymentServiceObj.queryPaymentsByOrder(params);

    RestAPI2Service.GTVAPIProductService productServiceObj = new RestAPI2Service.GTVAPIProductService();
    productServiceObj.getProduct(params);
    productServiceObj.queryProducts(params);
    productServiceObj.activateProduct(params);
    params.put('productId', '123');
    productServiceObj.getProductAgreementRelation(params);
    productServiceObj.queryProductAgreementRelations(params);
    params.put('createProduct', new RestAPI2Domain.GTVAPICreateProduct());
    productServiceObj.createProduct(params);
    params.put(
      'createProductAgreementRelation',
      new RestAPI2Domain.GTVAPICreateProductAgreementRelation()
    );
    productServiceObj.createProductAgreementRelation(params);
    productServiceObj.removeProductAgreementRelation(params);
    params.put(
      'createProductPrice',
      new RestAPI2Domain.GTVAPICreateProductPrice()
    );
    productServiceObj.createProductPrice(params);
    productServiceObj.updateProductPrice(params);

    RestAPI2Service.GTVAPIOrderItemService orderItemServiceObj = new RestAPI2Service.GTVAPIOrderItemService();
    orderItemServiceObj.getOrderItem(params);
    orderItemServiceObj.queryOrderItems(params);

    RestAPI2Service.GTVAPIAdjustmentService adjustmentServiceObj = new RestAPI2Service.GTVAPIAdjustmentService();
    params.put(
      'adjustment',
      new RestAPI2Domain.GTVAPICreateAccountAdjustment()
    );
    adjustmentServiceObj.createCreditAdjustment(params);
    adjustmentServiceObj.createDebitAdjustment(params);
    adjustmentServiceObj.getCreditAdjustment(params);
    adjustmentServiceObj.postCreditAdjustment(params);
    adjustmentServiceObj.postDebitAdjustment(params);
    adjustmentServiceObj.queryCreditAdjustments(params);
    adjustmentServiceObj.queryDebitAdjustments(params);

    RestAPI2Service.GTVAPIRecurringPaymentService recurringPaymentServiceObj = new RestAPI2Service.GTVAPIRecurringPaymentService();
    recurringPaymentServiceObj.activateAutoPayment(params);
    recurringPaymentServiceObj.deactivateAutoPayment(params);
    params.put('billerCode', '123');
    params.put('customerReferenceNumber', '123');
    recurringPaymentServiceObj.getBPayRecurringPayment(params);
    recurringPaymentServiceObj.getRecurringPayment(params);
    recurringPaymentServiceObj.queryRecurringPayments(params);

    RestAPI2Service.GTVAPIPaymentApplicationService paymentApplicationServiceObj = new RestAPI2Service.GTVAPIPaymentApplicationService();
    paymentApplicationServiceObj.getPaymentApplication(params);
    paymentApplicationServiceObj.queryPaymentApplications(params);

    RestAPI2Service.GTVAPIUsageEventService usageEventServiceObj = new RestAPI2Service.GTVAPIUsageEventService();
    params.put(
      'bulkUsageEventsRequest',
      new RestAPI2Domain.GTVAPICreateBulkUsageEvents()
    );
    usageEventServiceObj.createUsageEvents(params);
    usageEventServiceObj.getUsageEvent(params);
    usageEventServiceObj.queryUsageEvents(params);
    usageEventServiceObj.simulateUsageEvents(params);
    params.put(
      'bulkUsageEventsVoidRequest',
      new RestAPI2Domain.GTVAPICreateBulkVoidUsageEvents()
    );
    usageEventServiceObj.voidUsageEvents(params);

    RestAPI2Service.GTVAPIOrderCustomFieldService orderCustomFieldServiceObj = new RestAPI2Service.GTVAPIOrderCustomFieldService();
    orderCustomFieldServiceObj.getOrderCustomField(params);
    params.put('customFieldId', '123');
    orderCustomFieldServiceObj.queryOrderCustomFieldValueReferences(params);
    orderCustomFieldServiceObj.queryOrderCustomFields(params);

    RestAPI2Service.GTVAPIBillingAccountCustomFieldService billingAccountCustomFieldServiceObj = new RestAPI2Service.GTVAPIBillingAccountCustomFieldService();
    billingAccountCustomFieldServiceObj.getBillingAccountCustomField(params);
    billingAccountCustomFieldServiceObj.queryBillingAccountCustomFieldValueReferences(
      params
    );
    billingAccountCustomFieldServiceObj.queryBillingAccountCustomFields(params);

    RestAPI2Service.GTVAPIServiceCustomFieldService serviceCustomFieldObj = new RestAPI2Service.GTVAPIServiceCustomFieldService();
    serviceCustomFieldObj.getServiceCustomField(params);
    serviceCustomFieldObj.queryServiceCustomFieldValueReferences(params);
    serviceCustomFieldObj.queryServiceCustomFields(params);

    RestAPI2Service.GTVAPIPriceListService priceListServiceObj = new RestAPI2Service.GTVAPIPriceListService();
    priceListServiceObj.getPriceList(params);
    priceListServiceObj.queryPriceLists(params);
    params.put('priceListId', '123');
    priceListServiceObj.getPriceListProductRelation(params);
    priceListServiceObj.removePriceListProductRelation(params);
    params.put('productRelation', new RestAPI2Domain.GTVAPIProductRelation());
    priceListServiceObj.associateProductToPriceList(params);

    RestAPI2Service.GTVAPIBillCycleService billCycleServiceObj = new RestAPI2Service.GTVAPIBillCycleService();
    billCycleServiceObj.activateBillCycle(params);
    billCycleServiceObj.cancelBillCycle(params);
    params.put('billCycle', new RestAPI2Domain.GTVAPIChangeBillCycleCommand());
    billCycleServiceObj.changeBillCycle(params);
    params.put('billCycle', new RestAPI2Domain.GTVAPICreateBillCycle());
    billCycleServiceObj.createBillCycle(params);
    params.put('billCycleId', '123');
    billCycleServiceObj.getActionByBillCycle(params);
    billCycleServiceObj.getBillCycle(params);
    billCycleServiceObj.queryActionsByBillCycle(params);
    billCycleServiceObj.queryBillCycles(params);
    billCycleServiceObj.suspendBillCycle(params);
    params.put('updateBillCycle', new RestAPI2Domain.GTVAPIBillCycle());
    billCycleServiceObj.updateBillCycle(params);

    RestAPI2Service.GTVAPIPaymentTermService paymentTermServiceObj = new RestAPI2Service.GTVAPIPaymentTermService();
    paymentTermServiceObj.getPaymentTerm(params);
    paymentTermServiceObj.queryPaymentTerms(params);

    RestAPI2Service.GTVAPIAgreementService agreementServiceObj = new RestAPI2Service.GTVAPIAgreementService();
    agreementServiceObj.getAgreement(params);
    agreementServiceObj.queryAgreements(params);

    RestAPI2Service.GTVServiceApi serviceObj = new RestAPI2Service.GTVServiceApi();
    params.put('serviceId', '1234');
    params.put(
      'addServiceAddress',
      new RestAPI2Domain.GTVAPIAddServiceAddress()
    );
    serviceObj.addServiceAddress(params);
    params.put(
      'addServiceResource',
      new RestAPI2Domain.GTVAPIAddServiceResource()
    );
    serviceObj.addServiceResource(params);
    params.put(
      'importServiceResources',
      new RestAPI2Domain.GTVAPIImportBulkServiceResources()
    );
    serviceObj.addServiceResourcesBulk(params);
    params.put('changeService', new RestAPI2Domain.GTVAPIChangeService());
    serviceObj.changeService(params);
    serviceObj.getCompatibleProducts(params);
    params.put(
      'changeServiceQuantity',
      new RestAPI2Domain.GTVAPIChangeServiceQuantity()
    );
    serviceObj.changeServiceQuantity(params);
    serviceObj.convertTrialService(params);
    params.put(
      'createAgreementService',
      new RestAPI2Domain.GTVAPICreateAgreementService()
    );
    serviceObj.createAgreementService(params);
    params.put(
      'createRecurringPrice',
      new RestAPI2Domain.GTVAPICreateServicePrice()
    );
    serviceObj.createCurrentRecurringPrice(params);
    params.put(
      'createDiscountCodeService',
      new RestAPI2Domain.GTVAPICreateDiscountCodeService()
    );
    serviceObj.createDiscountCodeService(params);
    params.put(
      'createQuantityChange',
      new RestAPI2Domain.GTVAPICreateQuantityChange()
    );
    serviceObj.createQuantityChange(params);
    params.put(
      'serviceCustomFieldValue',
      new RestAPI2Domain.GTVAPICreateServiceCustomFieldValue()
    );
    serviceObj.createServiceCustomFieldValue(params);
    params.put(
      'createServiceUsageRule',
      new RestAPI2Domain.GTVAPICreateServiceUsageRule()
    );
    serviceObj.createServiceUsageRules(params);
    params.put(
      'deactivateService',
      new RestAPI2Domain.GTVAPIDeactivateService()
    );
    serviceObj.deactivateService(params);
    serviceObj.getCurrentAgreementService(params);
    serviceObj.getCurrentRecurringPrice(params);
    serviceObj.getCurrentRecurringPriceRange(params);
    serviceObj.getDiscountCodeService(params);
    serviceObj.getQuantityChangeByService(params);
    serviceObj.getService(params);
    serviceObj.getServiceAddress(params);
    serviceObj.getServiceCustomFieldValue(params);
    serviceObj.getServicePeriodByService(params);
    serviceObj.getServicePriceByService(params);
    params.put('servicePriceId', '123');
    serviceObj.getServicePriceRangeById(params);
    serviceObj.getServiceResourceByService(params);
    serviceObj.getServiceUsageRuleByService(params);
    serviceObj.getServiceUsageRuleByService_0(params);
    serviceObj.queryCurrentRecurringPriceRanges(params);
    serviceObj.queryDiscountCodeServices(params);
    serviceObj.queryServiceAddresses(params);
    serviceObj.queryServiceCustomFieldValues(params);
    serviceObj.queryServicePeriodsByService(params);
    serviceObj.queryServicePricesByService(params);
    serviceObj.queryServicePricesRanges(params);
    serviceObj.queryServiceResourcesByService(params);
    serviceObj.queryServiceUsageRulesByService(params);
    serviceObj.queryServices(params);
    serviceObj.resumeService(params);
    params.put('suspendService', new RestAPI2Domain.GTVAPISuspendService());
    serviceObj.suspendService(params);
    serviceObj.removeDiscountCodeService(params);
    serviceObj.removeQuantityChange(params);
    serviceObj.removeServiceAddress(params);
    serviceObj.removeServiceCustomFieldValue(params);
    serviceObj.removeServiceResourceByService(params);
    serviceObj.removeServiceUsageRule(params);
    params.put('updateService', new RestAPI2Domain.GTVAPISFService());
    serviceObj.updateService(params);
    params.put(
      'serviceCustomFieldValue',
      new RestAPI2Domain.GTVAPIServiceCustomFieldValue()
    );
    serviceObj.updateServiceCustomFieldValue(params);
    params.put('updateServicePeriod', new RestAPI2Domain.GTVAPIServicePeriod());
    serviceObj.updateServicePeriod(params);
    serviceObj.removeServiceUsageRule(params);
    params.put(
      'replaceServiceResource',
      new RestAPI2Domain.GTVAPIAddServiceResource()
    );
    serviceObj.replaceServiceResource(params);

    RestAPI2Service.GTVAPIResourceCategoryService resourceCategoryObj = new RestAPI2Service.GTVAPIResourceCategoryService();
    resourceCategoryObj.getResourceCategory(params);
    resourceCategoryObj.queryResourceCategories(params);
    resourceCategoryObj.requestServiceResourceByCategory(params);

    RestAPI2Service.GTVAPIReasonService reasonServiceObj = new RestAPI2Service.GTVAPIReasonService();
    reasonServiceObj.getBillingAccountDeactivationReason(params);
    reasonServiceObj.getBillingAccountSuspensionReason(params);
    reasonServiceObj.getCreditAdjustmentReason(params);
    reasonServiceObj.getDebitAdjustmentReason(params);
    reasonServiceObj.getManualInvoiceReason(params);
    reasonServiceObj.getPaymentChangeReason(params);
    reasonServiceObj.getServiceDeactivationReason(params);
    reasonServiceObj.getServiceSuspensionReason(params);
    reasonServiceObj.queryBillingAccountDeactivationReasons(params);
    reasonServiceObj.queryBillingAccountSuspensionReasons(params);
    reasonServiceObj.queryCreditAdjustmentReasons(params);
    reasonServiceObj.queryDebitAdjustmentReasons(params);
    reasonServiceObj.queryManualInvoiceReasons(params);
    reasonServiceObj.queryPaymentChangeReasons(params);
    reasonServiceObj.queryServiceDeactivationReasons(params);
    reasonServiceObj.queryServiceSuspensionReasons(params);

    RestAPI2Service.GTVAPIServiceUsageRule serviceusageRuleObj = new RestAPI2Service.GTVAPIServiceUsageRule();
    serviceusageRuleObj.getServiceUsageRule(params);
    serviceusageRuleObj.getServiceUsageRuleByService(params);
    serviceusageRuleObj.queryServiceUsageRules(params);
    serviceusageRuleObj.queryServiceUsageRulesByService(params);
    params.put('serviceUsageRule', new RestAPI2Domain.GTVAPIServiceUsageRule());
    serviceusageRuleObj.updateServiceUsageRule(params);
    serviceusageRuleObj.updateServiceUsageRuleByService(params);

    RestAPI2Service.GTVAPIProductRelationService productRelationObj = new RestAPI2Service.GTVAPIProductRelationService();
    productRelationObj.getProductRelation(params);
    productRelationObj.queryProductRelations(params);
    productRelationObj.removeProductRelation(params);

    RestAPI2Service.GTVAPIDiscountCodeService discountCodeObj = new RestAPI2Service.GTVAPIDiscountCodeService();
    discountCodeObj.getDiscountCode(params);
    discountCodeObj.queryDiscountCodes(params);

    RestAPI2Service.GTVAPIProductUsageRuleService productUsageObj = new RestAPI2Service.GTVAPIProductUsageRuleService();
    productUsageObj.getProductUsageRule(params);
    productUsageObj.queryProductUsageRules(params);
    params.put('productPriceId', 'productPriceId');
    params.put('usageRules', new RestAPI2Domain.GTVAPICreateProductUsageRule());
    productUsageObj.createProductUsageRule(params);

    RestAPI2Service.GTVAPIServiceResourceService serviceResourceObj = new RestAPI2Service.GTVAPIServiceResourceService();
    serviceResourceObj.addServiceResource(params);
    params.put('orderItemId', '1234');
    params.put(
      'addCreateServiceResource',
      new RestAPI2Domain.GTVAPICreateOrAddServiceResource()
    );
    serviceResourceObj.addServiceResourceByOrderItem(params);
    params.put(
      'importServiceResources',
      new RestAPI2Domain.GTVAPIImportBulkServiceResources()
    );
    serviceResourceObj.addServiceResourcesBulk(params);
    serviceResourceObj.availableServiceResource(params);
    params.put(
      'createServiceResource',
      new RestAPI2Domain.GTVAPICreateServiceResource()
    );
    serviceResourceObj.createServiceResource(params);
    serviceResourceObj.deactivateServiceResource(params);
    serviceResourceObj.getServiceResource(params);
    serviceResourceObj.getServiceResourceByOrderItem(params);
    serviceResourceObj.getServiceResourceByService(params);
    serviceResourceObj.queryServiceResources(params);
    serviceResourceObj.queryServiceResourcesByOrderItem(params);
    serviceResourceObj.queryServiceResourcesByService(params);
    serviceResourceObj.removeServiceResource(params);
    serviceResourceObj.removeServiceResourceByOrderItem(params);
    serviceResourceObj.removeServiceResourceByService(params);
    params.put(
      'replaceServiceResource',
      new RestAPI2Domain.GTVAPIAddServiceResource()
    );
    serviceResourceObj.replaceServiceResource(params);
    serviceResourceObj.requestServiceResource(params);
    serviceResourceObj.requestServiceResourceByCategory(params);
    params.put(
      'updateServiceResource',
      new RestAPI2Domain.GTVAPIServiceResource()
    );
    serviceResourceObj.updateServiceResource(params);

    RestAPI2Service.GTVAPIChargeCategoryService chargeCategoryServiceObj = new RestAPI2Service.GTVAPIChargeCategoryService();
    chargeCategoryServiceObj.getChargeCategory(params);
    chargeCategoryServiceObj.queryChargeCategories(params);

    RestAPI2Service.GTVAPIRateTableService rateTableServiceObj = new RestAPI2Service.GTVAPIRateTableService();
    params.put('rateTable', new RestAPI2Domain.GTVAPICreateRateTable());
    rateTableServiceObj.addRateTable(params);
    params.put('rateTableId', '1234');
    params.put(
      'rateTableEntry',
      new RestAPI2Domain.GTVAPICreateRateTableEntry()
    );
    rateTableServiceObj.addRateTableEntry(params);
    rateTableServiceObj.getRateTable(params);
    rateTableServiceObj.getRateTableEntryByRateTable(params);
    rateTableServiceObj.queryRateTables(params);
    rateTableServiceObj.queryRateTablesEntries(params);
    rateTableServiceObj.removeRateTable(params);
    rateTableServiceObj.removeRateTableEntry(params);
    params.put('rateTable', new RestAPI2Domain.GTVAPIRateTable());
    rateTableServiceObj.updateRateTable(params);
    params.put('rateTableEntry', new RestAPI2Domain.GTVAPIRateTableEntry());
    rateTableServiceObj.updateRateTableEntry(params);

    RestAPI2Service.GTVAPIProductCategoryService productCategoryServiceObj = new RestAPI2Service.GTVAPIProductCategoryService();
    productCategoryServiceObj.queryProductCategories(params);

    RestAPI2Service.GTVAPIProductTagService productTagServiceObj = new RestAPI2Service.GTVAPIProductTagService();
    productTagServiceObj.queryProductTags(params);

    RestAPI2Service.GTVAPIProductRegisterTypeService productRegisterTypeServiceObj = new RestAPI2Service.GTVAPIProductRegisterTypeService();
    productRegisterTypeServiceObj.queryProductRegisterTypes(params);

    RestAPI2Service.GTVAPIProductPriceGroupService productPriceGroupServiceObj = new RestAPI2Service.GTVAPIProductPriceGroupService();
    productPriceGroupServiceObj.queryProductPriceGroups(params);

    RestAPI2Service.GTVAPIProductCustomFieldService productCustomFieldServiceObj = new RestAPI2Service.GTVAPIProductCustomFieldService();
    productCustomFieldServiceObj.queryProductCustomFields(params);

    RestAPI2Service.GTVAPIProductCustomFieldValueService productCustomFieldValueServiceObj = new RestAPI2Service.GTVAPIProductCustomFieldValueService();
    params.put('productId', 'productId');
    productCustomFieldValueServiceObj.queryProductCustomFieldValues(params);
    params.put(
      'productCustomFieldValue',
      new RestAPI2Domain.GTVAPICreateProductCustomFieldValue()
    );
    productCustomFieldValueServiceObj.createProductCustomFieldValue(params);

    RestAPI2Service.GTVAPIMarketplaceService marketplaceServiceObj = new RestAPI2Service.GTVAPIMarketplaceService();
    params.put(
      'createMarketplace',
      new RestAPI2Domain.GTVAPICreateMarketplace()
    );
    marketplaceServiceObj.createMarketplace(params);
    params.put('marketplaceId', 'marketplaceId');
    params.put(
      'createPriceListRelation',
      new RestAPI2Domain.GTVAPICreatePriceListRelation()
    );
    marketplaceServiceObj.createPriceListsToMarketplaceRelation(params);
    marketplaceServiceObj.getMarketplace(params);
    marketplaceServiceObj.getPriceListRelation(params);
    marketplaceServiceObj.queryMarketplacePriceLists(params);
    marketplaceServiceObj.queryMarketplaces(params);
    marketplaceServiceObj.removeMarketplace(params);
    marketplaceServiceObj.removePriceListRelation(params);
    params.put('updateMarketplace', new RestAPI2Domain.GTVAPIMarketplace());
    marketplaceServiceObj.updateMarketplace(params);

    RestAPI2Service.GTVAPIProductPriceService productPriceServiceObj = new RestAPI2Service.GTVAPIProductPriceService();
    productPriceServiceObj.queryProductPrices(params);

    RestAPI2Service.GTVAPIDiscountResourceService discountResourceServiceObj = new RestAPI2Service.GTVAPIDiscountResourceService();
    discountResourceServiceObj.getDiscountResource(params);
    discountResourceServiceObj.queryDiscountResources(params);

    RestAPI2Service.GTVAPIDiscountService discountServiceObj = new RestAPI2Service.GTVAPIDiscountService();
    discountServiceObj.getDiscount(params);
    discountServiceObj.queryDiscounts(params);

    RestAPI2Service.GTVAPIInvoiceItemService invoiceItemServiceObj = new RestAPI2Service.GTVAPIInvoiceItemService();
    invoiceItemServiceObj.getInvoiceItem(params);
    invoiceItemServiceObj.queryInvoiceItems(params);

    RestAPI2Service.GTVAPICreatePaymentService createPaymentServiceObj = new RestAPI2Service.GTVAPICreatePaymentService();
    params.put(
      'getRefererToken',
      new RestAPI2Domain.GTVAPIPaymentRefererToken()
    );
    createPaymentServiceObj.getPaymentRefererToken(params);
    params.put(
      'getPaymentToken',
      new RestAPI2Domain.GTVAPICreatePaymentMethod()
    );
    createPaymentServiceObj.getPaymentToken(params);
  }
}