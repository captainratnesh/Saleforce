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
 * This Interface provides methods to be implemented by both SOAP and REST Data service Class.
 * @author AMAN JAIN
 */

public interface APIDataService {
  TRACTAccountWrapper getBillingAccount(String sfdcAccountId);
  TractPaymentWrapper getPayments(
    TRACTAccountWrapper sfdcAccountWrapper,
    Integer pageNumber
  );
  TractInvoiceWrapper getInvoices(
    TRACTAccountWrapper sfdcAccountWrapper,
    Integer pageNumber
  );
  TractAdjustmentWrapper getDebitAdjustments(
    TRACTAccountWrapper sfdcAccountWrapper,
    Integer pageNumber
  );
  TractAdjustmentWrapper getCreditAdjustments(
    TRACTAccountWrapper sfdcAccountWrapper,
    Integer pageNumber
  );
  TRACTNoteWrapper getNotes(
    TRACTAccountWrapper tractBillingAccount,
    Integer pageNumber
  );
  TRACTContactWrapper getContacts(
    TRACTAccountWrapper sfdcAccountWrapper,
    Integer pageNumber
  );
  TRACTPaymentMethodWrapper getPaymentMethods(
    TRACTAccountWrapper sfdcAccountWrapper,
    Integer pageNumber
  );
  TractSalesOrderWrapper getSalesOrders(
    TRACTAccountWrapper sfdcAccountWrapper,
    Integer pageNumber
  );
  ActivityEventsWrapper getUsagesEvents(
    TRACTAccountWrapper sfdcAccountWrapper,
    Integer pagenumber
  );
  list<Product2> getGTVAgreeements(list<Product2> currentProductList);
  List<TRACT_Bill_Cycle__c> getBillCycles();
  list<SelectOption> getCustomFieldForBilling(TRACT_Setup__c tractConfig);
  List<Payment_Term__c> getPaymentTerms();
  List<SelectOption> getCurrencyType();
  List<TRACTBillingAccountCategory__c> getBillingAccountCategories();
  List<Price_List__c> getPriceLists(String marketPlaceId);
  String getUOMRateTable(String rateTableEid);
  List<ProductAgreementWrapper> getAllAgreements();
  void setProductAgreement(
    List<ProductAgreementWrapper> agreementList,
    String productId
  );
  String saveDeactivateService(
    String serviceEid,
    String reasonEid,
    String deactivationDate
  );
  void convertServiceGTV(String serviceEidValue);
  void getGTVProducts(list<Price_List__c> listOfPriceList);
  void queryPriceListsForTestingConnection(TRACT_Setup__c tractConfigObj);
  InvoiceDetailWrapper getInvoiceByNumber(InvoiceWrapper wrapperObj);
  list<Tract_Order_Custom_Field__c> getOrderCustomFields();
  ServiceDetailWrapper getServiceById(ProductServiceWrapper serviceWrapper);
  GTVSalesOrderDetailWrapper getOrderItemList(
    String orderNumber,
    String currencyType
  );
  List<AccountCustomFieldWrapper> getAccountCustomFields(
    TRACTAccountWrapper tractBillingAccount
  );
  string getBillingAccountForCreateRequest(
    list<Account> thisAccountList,
    TRACT_Bill_Cycle__c billCycle,
    string bACEid,
    string paymentTerm,
    string fieldToMapAccountId
  );
  void accountcreationForTrigger(Id AccountId, String billingAccountString);
  List<AccountCustomFieldValueWrapper> getAccountCustomFieldValueList(
    String accountId
  );
  void saveAdjustmentGTV(
    String accountId,
    string adjustmentReasonEid,
    String ammount,
    String description,
    String effectiveDate,
    boolean manualInvoice,
    boolean isCredit
  );
  void deleteActivityChargeRule(
    String activityProductEid,
    String deletedUsageEid,
    String activityRuleName
  );
  void billingAccountCreationMapping(
    list<Account> thisAccountList,
    TRACT_Bill_Cycle__c billCycle,
    string bACEid,
    string paymentTerm,
    string fieldToMapAccountId
  );
  Object getDiscounts(String productWrapperString, String discountName);
  Object getDiscountsQuickAdd(String productWrapperString);
  ServiceResourceWrapper getServiceResource(String srId);
  void suspendServiceGTV(String serviceEid, String reasonEid);
  Blob downloadInvoices(String invoiceNumber);
  String saveAccountCustomField(
    TRACTAccountWrapper tractBillingAccount,
    String customFildWrapper
  );
  void saveChangeServicesOnApex(
    String newSubscriptionId,
    String effectiveDateValue,
    String currentServiceEid,
    list<Account> accList,
    Boolean payonPurchaseValue,
    Map<String, Decimal> mapOfAgreementPeriod,
    Map<String, String> productPriceIdToEidMap,
    Integer qtyOfChangedService,
    String agreementRenewActionForChangedService,
    String agreementEidForChangedService,
    Decimal recurringPrice,
    String recurringPriceId,
    String priceOverridden
  );
  void resumeBillingAccount(TRACTAccountWrapper tractBillingAccount);
  void suspendBillingAccount(
    TRACTAccountWrapper tractBillingAccount,
    String reasonEid
  );
  void deactivateBillingAccount(
    TRACTAccountWrapper tractBillingAccount,
    String reasonEid
  );
  List<ProductUsesWrapper> showUsageRule(String activityProductEid);
  void resumeServiceGTV(String serviceEidValue);
  void saveAddAddressGTV(
    String currentServiceEid,
    String countryListValue,
    String billingCity,
    String shippingCountry,
    String shippingCity,
    String stateValue,
    String postalCode
  );
  void updateQuantityInGTV(
    Decimal updateserviceQuantity,
    String serviceEidValue,
    Boolean displayEffectiveDate,
    String effectiveDate
  );
  list<selectOption> getDeactivateReasons();
  list<selectOption> getSuspendReasons();
  list<selectOption> getFormulaUsageRuleSpecificationListMethod();
  list<selectOption> getchargeCategoryListMethod();
  list<selectOption> getchargeListBytesMethod();
  list<selectOption> showCreditAdjustment();
  list<selectOption> showDebitAdjustment();
  list<selectOption> getBillingAccountStatus(String reasonFor);
  List<DiscountCodeWrapper> getDiscountCodesByProduct(String productEid);
  void createNewActivityChargeRule(ProductServiceWrapper serviceWrapper);
  TractServiceWrapper getServiceByBillingAccount(List<Account> accList);
  list<System_Setting__c> getSystemSettings();
  List<SelectOption> getProductTypeCode();
  list<string> getRelatedProductNameByProductCode(String productEid);
  Set<String> getRelatedProductIdSet(String productEid);
  TractServiceWrapper setUpServices(
    list<Account> accList,
    list<SelectOption> stateCan,
    list<SelectOption> stateMex,
    list<SelectOption> stateUsa,
    list<SelectOption> countryList,
    List<SelectOption> serviceReasons,
    List<SelectOption> suspendServicesReason,
    TRACTAccountWrapper tractBillingAccount,
    AccountDetailController_LT.ChargeRulesWrapper chargeRules,
    TRACT_Setup__c tract,
    Integer pagenumber
  );
  RenewServiceWrapper showServices(
    list<Account> accList,
    String serviceRenewEid
  );
  Object getAllChargeCategory();
  Object getAllChargeBytes();
  void getAccount(list<Account> thisAccount);
  Object getAllGlobalUsageRule();
  ServiceResourceWrapper getServiceResourceById(String srId);
  void updateQuantityAddProduct(List<OpportunityLineItem> existingOLI);
  String tractCreateDraftOrder(Map<String, String> information);
  String tractCreateSalesOrder(Map<String, String> information);
  ChangeSubscriptionWrapper showPopupService(
    String currentProductEid,
    String currencyType,
    Boolean preserveAgreement
  );
  void applyServiceResourceToService(
    String ServiceEid,
    String srId,
    Boolean isNew,
    String effectiveDate
  );
  void savePopupRenew(
    String renewAgreementEid,
    list<Account> accList,
    String serviceRenewEid,
    String recurringPriceString,
    String oneTimePriceString,
    Boolean dateOverridden,
    String deactivateDateString
  );
  void changeServiceResource(
    ProductServiceWrapper wrapperObj,
    String serviceResourceToBeApplied,
    Boolean isNewServiceResource,
    String effectiveDate,
    String parentServiceEid
  );
  List<Tract_Service_Custom_Field__c> getServiceCustomFieldByProduct(
    String productEid
  );
  set<String> getRelatedChidProducts(String productEid);
  List<GTVOneTimeOrderItemWrapper> getOneTimeOrderItemList(
    TRACTAccountWrapper sfdcAccountWrapper
  );
  list<SelectOption> queryProductCategories();
  list<SelectOption> queryServiceResourceCategories();
  list<SelectOption> queryProductTags();
  String createGtvProduct(CreateProductWrapper createProductWrapper);
  list<SelectOption> queryProductRegisterTypes();
  void removeAgreementRelation(
    String productId,
    ProductAgreementWrapper agreementWrap
  );
  list<SelectOption> getRecurrencePeriod();
  list<SelectOption> getProductPriceGroup();
  list<SelectOption> queryPriceCategories();
  String createGtvRecurringProductPrice(
    CreateRecurringChargePriceWrapper createProductPriceWrapper,
    String priceListId
  );
  String updateGtvRecurringProductPrice(
    CreateRecurringChargePriceWrapper createProductPriceWrapper,
    String priceListId
  );
  void makeProductAvailable(String productId);
  String createGtvOneTimeProductPrice(
    CreateOneTimeChargePriceWrapper createOneTimeProductPriceWrapper,
    String priceListId
  );
  list<ProductCustomFieldWrapper> queryProductCustomFields(String productId);
  list<productCustomFieldValueWrapper> queryProductCustomFieldValues(
    String productEid
  );
  String saveProductCustomFieldValues(
    String productEid,
    String customFildWrapper
  );
  list<MarketPlaceWrapper> getMarketPlace();
  list<PriceListWrapper> getMarketPlacePriceList(
    MarketPlaceWrapper marketPlaceWrap
  );
  void addProductToPriceList(
    String priceListEid,
    list<String> selectedProducts
  );
  void removeProductToPriceList(
    String priceListEid,
    list<String> selectedProducts
  );
  void removeThisMarketPlace(String mPlaceId);
  list<ProductRelationWrapper> queryProductRelation(String productEid);
  void removeProductRelation(
    String productId,
    ProductRelationWrapper relationWrap
  );
  list<TRACTAccountWrapper> getChildDetails(String accountEid);
  BillingHierarchyWrapper queryBillingHierarchy(String responsibleAccountEid);
  string getDefaultMarketPlaceId();
  List<SelectOption> getAllMarketPlace(TRACT_Setup__c tractConfig);
  String checkExistingServicesource(String srId);
  CreateAccountResponse createAccountGlobalAction(
    Id accountId,
    String billingAccountString
  );
  CreateOrderResponse createOrderGlobalAction(
    Map<String, String> orderInformation
  );
  list<ProductUsesWrapper> getProductChargeRules(
    String prodEid,
    String recurringPriceId
  );
  void createChargeRules(
    String productEid,
    String recurringPriceId,
    ProductChargeRuleWrapper ruleWrapper
  );
  String getPaymentRefererToken();
  String generatePaymentToken(Map<String, Object> paymentDataMap);
  String createRecurringPayment(
    String token,
    String billingAccountEid,
    boolean isAutoPayment
  );
  String createBillingPayment(
    Map<String, Object> mapOfPaymentData,
    String billingAccountEid
  );
  GTVPaymentWrapper getPaymentMethodAsSelectOption(
    String gTVBillingAccountNumber
  );
}