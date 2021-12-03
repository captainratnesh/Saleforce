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
 * This class is a test class of SoapApi33Domain class.
 * @author Aman Jain
 */

@isTest
public with sharing class SoapApi33Domain_Test {
  static testMethod void myUnitTest() {
    SoapApi33Domain.AddInvoiceApplicationToAdjustment addInvoiceApplicationToAdjustment = new SoapApi33Domain.AddInvoiceApplicationToAdjustment();
    SoapApi33Domain.errors_element errors_element = new SoapApi33Domain.errors_element();
    SoapApi33Domain.UsageLookupTable usageLookupTable = new SoapApi33Domain.UsageLookupTable();
    SoapApi33Domain.OrderItemUsageRules orderItemUsageRules = new SoapApi33Domain.OrderItemUsageRules();
    SoapApi33Domain.UsageLookupTables usageLookupTables = new SoapApi33Domain.UsageLookupTables();
    SoapApi33Domain.AgreementCounterResetCriteria agreementCounterResetCriteria = new SoapApi33Domain.AgreementCounterResetCriteria();
    SoapApi33Domain.SuspendService suspendService = new SoapApi33Domain.SuspendService();
    SoapApi33Domain.AgreementService agreementService = new SoapApi33Domain.AgreementService();
    SoapApi33Domain.SalesOrderItem salesOrderItem = new SoapApi33Domain.SalesOrderItem();

    SoapApi33Domain.AddCustomFieldValueToBillingAccount addCustomFieldValueToBillingAccount = new SoapApi33Domain.AddCustomFieldValueToBillingAccount();
    SoapApi33Domain.RemoveCustomFieldValueFromBillingAccount removeCustomFieldValueFromBillingAccount = new SoapApi33Domain.RemoveCustomFieldValueFromBillingAccount();
    SoapApi33Domain.ConfirmOrder confirmOrder = new SoapApi33Domain.ConfirmOrder();
    SoapApi33Domain.ResumeBillingAccount resumeBillingAccount = new SoapApi33Domain.ResumeBillingAccount();
    SoapApi33Domain.GLAccountingEntries gLAccountingEntries = new SoapApi33Domain.GLAccountingEntries();
    SoapApi33Domain.UsageEvent usageEvent = new SoapApi33Domain.UsageEvent();

    SoapApi33Domain.OrderItemCommand orderItemCommand = new SoapApi33Domain.OrderItemCommand();
    SoapApi33Domain.CashPaymentMethod cashPaymentMethod = new SoapApi33Domain.CashPaymentMethod();
    SoapApi33Domain.MatchAllServiceUsageRule matchAllServiceUsageRule = new SoapApi33Domain.MatchAllServiceUsageRule();
    SoapApi33Domain.UsageEvents usageEvents = new SoapApi33Domain.UsageEvents();
    SoapApi33Domain.OrderBy orderBy = new SoapApi33Domain.OrderBy();
    SoapApi33Domain.ServicePrice servicePrice = new SoapApi33Domain.ServicePrice();
    SoapApi33Domain.MatchAllProductUsageRule matchAllProductUsageRule = new SoapApi33Domain.MatchAllProductUsageRule();
    SoapApi33Domain.OperationAttributes operationAttributes = new SoapApi33Domain.OperationAttributes();
    SoapApi33Domain.CustomFieldValue customFieldValue = new SoapApi33Domain.CustomFieldValue();
    SoapApi33Domain.AgreementServices agreementServices = new SoapApi33Domain.AgreementServices();
    SoapApi33Domain.HttpRequestOperation httpRequestOperation = new SoapApi33Domain.HttpRequestOperation();
    SoapApi33Domain.UsageRules usageRules = new SoapApi33Domain.UsageRules();
    SoapApi33Domain.ScheduledCharge scheduledCharge = new SoapApi33Domain.ScheduledCharge();

    SoapApi33Domain.GLAccountCategory gLAccountCategory = new SoapApi33Domain.GLAccountCategory();
    SoapApi33Domain.GlobalOrderItemUsageRule globalOrderItemUsageRule = new SoapApi33Domain.GlobalOrderItemUsageRule();
    SoapApi33Domain.RateTable rateTable = new SoapApi33Domain.RateTable();
    SoapApi33Domain.RemoveServiceUsageRuleFromService removeServiceUsageRuleFromService = new SoapApi33Domain.RemoveServiceUsageRuleFromService();
    SoapApi33Domain.GeneralLedgers generalLedgers = new SoapApi33Domain.GeneralLedgers();
    SoapApi33Domain.UsageRuleCounter usageRuleCounter = new SoapApi33Domain.UsageRuleCounter();
    SoapApi33Domain.BillingAccountSegments billingAccountSegments = new SoapApi33Domain.BillingAccountSegments();
    SoapApi33Domain.EmailOperation emailOperation = new SoapApi33Domain.EmailOperation();
    SoapApi33Domain.Action action = new SoapApi33Domain.Action();

    SoapApi33Domain.BillingAccountCommand billingAccountCommand = new SoapApi33Domain.BillingAccountCommand();
    SoapApi33Domain.ServiceAction serviceAction = new SoapApi33Domain.ServiceAction();
    SoapApi33Domain.NameAddressPaymentMethod nameAddressPaymentMethod = new SoapApi33Domain.NameAddressPaymentMethod();
    SoapApi33Domain.ServiceDeviceInventoryItems serviceDeviceInventoryItems = new SoapApi33Domain.ServiceDeviceInventoryItems();
    SoapApi33Domain.ReversedInvoiceAdjustmentApplication reversedInvoiceAdjustmentApplication = new SoapApi33Domain.ReversedInvoiceAdjustmentApplication();
    SoapApi33Domain.DiscountIdentifiers discountIdentifiers = new SoapApi33Domain.DiscountIdentifiers();

    SoapApi33Domain.UsageLookupTableEntry usageLookupTableEntry = new SoapApi33Domain.UsageLookupTableEntry();
    SoapApi33Domain.OrderCommand orderCommand = new SoapApi33Domain.OrderCommand();
    SoapApi33Domain.ServiceCommand serviceCommand = new SoapApi33Domain.ServiceCommand();
    SoapApi33Domain.Discounts discounts = new SoapApi33Domain.Discounts();
    SoapApi33Domain.UpdateOpenCounters updateOpenCounters = new SoapApi33Domain.UpdateOpenCounters();
    SoapApi33Domain.CheckPaymentMethod checkPaymentMethod = new SoapApi33Domain.CheckPaymentMethod();
    SoapApi33Domain.GlobalUsageRules globalUsageRules = new SoapApi33Domain.GlobalUsageRules();
    SoapApi33Domain.UsageRuleTemplate usageRuleTemplate = new SoapApi33Domain.UsageRuleTemplate();
    SoapApi33Domain.FlatUsageRate flatUsageRate = new SoapApi33Domain.FlatUsageRate();
    SoapApi33Domain.ServiceResourceCommand serviceResourceCommand = new SoapApi33Domain.ServiceResourceCommand();
    SoapApi33Domain.BaseTractObject baseTractObject = new SoapApi33Domain.BaseTractObject();
    SoapApi33Domain.UsageRule usageRule = new SoapApi33Domain.UsageRule();
    SoapApi33Domain.WireTransferPaymentMethod wireTransferPaymentMethod = new SoapApi33Domain.WireTransferPaymentMethod();
    SoapApi33Domain.ApplyPayment applyPayment = new SoapApi33Domain.ApplyPayment();

    SoapApi33Domain.RemoveCustomFieldValueFromOrder removeCustomFieldValueFromOrder = new SoapApi33Domain.RemoveCustomFieldValueFromOrder();
    SoapApi33Domain.AdjustmentReasons adjustmentReasons = new SoapApi33Domain.AdjustmentReasons();
    SoapApi33Domain.AddAgreementToService addAgreementToService = new SoapApi33Domain.AddAgreementToService();
    SoapApi33Domain.PassThroughUsageRate passThroughUsageRate = new SoapApi33Domain.PassThroughUsageRate();
    SoapApi33Domain.Refund refund = new SoapApi33Domain.Refund();

    SoapApi33Domain.AddDiscountIdentifierToService addDiscountIdentifierToService = new SoapApi33Domain.AddDiscountIdentifierToService();
    SoapApi33Domain.SuspendBillingAccount suspendBillingAccount = new SoapApi33Domain.SuspendBillingAccount();
    SoapApi33Domain.ServiceQuery serviceQuery = new SoapApi33Domain.ServiceQuery();
    SoapApi33Domain.InvoiceItemCharges invoiceItemCharges = new SoapApi33Domain.InvoiceItemCharges();
    SoapApi33Domain.Promotion promotion = new SoapApi33Domain.Promotion();
    SoapApi33Domain.GenerateReferrerToken generateReferrerToken = new SoapApi33Domain.GenerateReferrerToken();
    SoapApi33Domain.RequestServiceResource requestServiceResource = new SoapApi33Domain.RequestServiceResource();

    SoapApi33Domain.invoices_element invoices_element = new SoapApi33Domain.invoices_element();
    SoapApi33Domain.ApplyRefund applyRefund = new SoapApi33Domain.ApplyRefund();

    SoapApi33Domain.addresses_element addresses_element = new SoapApi33Domain.addresses_element();
    SoapApi33Domain.ServiceUsageRule serviceUsageRule = new SoapApi33Domain.ServiceUsageRule();
    SoapApi33Domain.AgreementQuery agreementQuery = new SoapApi33Domain.AgreementQuery();
    SoapApi33Domain.ProductSaleAction productSaleAction = new SoapApi33Domain.ProductSaleAction();
    SoapApi33Domain.GLAccounts glAccounts = new SoapApi33Domain.GLAccounts();
    SoapApi33Domain.DenyAction denyAction = new SoapApi33Domain.DenyAction();
    SoapApi33Domain.Discount discount = new SoapApi33Domain.Discount();
    SoapApi33Domain.ApplyRefundResponse applyRefundResponse = new SoapApi33Domain.ApplyRefundResponse();
    SoapApi33Domain.GlobalUsageRule globalUsageRule = new SoapApi33Domain.GlobalUsageRule();
    SoapApi33Domain.VoidDraftOrder voidDraftOrder = new SoapApi33Domain.VoidDraftOrder();
    SoapApi33Domain.CustomField customField = new SoapApi33Domain.CustomField();
    SoapApi33Domain.AddCustomFieldValueToOrder addCustomFieldValueToOrder = new SoapApi33Domain.AddCustomFieldValueToOrder();
    SoapApi33Domain.TractObject tractObject = new SoapApi33Domain.TractObject();
    SoapApi33Domain.Counter counter = new SoapApi33Domain.Counter();
    SoapApi33Domain.Currency_x currency_x = new SoapApi33Domain.Currency_x();
    SoapApi33Domain.PaymentMethod paymentMethod = new SoapApi33Domain.PaymentMethod();
    SoapApi33Domain.ChangeOrder changeOrder = new SoapApi33Domain.ChangeOrder();
    SoapApi33Domain.AdjustmentCommand adjustmentCommand = new SoapApi33Domain.AdjustmentCommand();
    SoapApi33Domain.TaxOrderItemCharge taxOrderItemCharge = new SoapApi33Domain.TaxOrderItemCharge();
    SoapApi33Domain.AdjustmentCategories adjustmentCategories = new SoapApi33Domain.AdjustmentCategories();
    SoapApi33Domain.CouponResource couponResource = new SoapApi33Domain.CouponResource();
    SoapApi33Domain.DiscountCategories discountCategories = new SoapApi33Domain.DiscountCategories();
    SoapApi33Domain.ApplyPaymentResponse applyPaymentResponse = new SoapApi33Domain.ApplyPaymentResponse();
    SoapApi33Domain.BaseOrderItem baseOrderItem = new SoapApi33Domain.BaseOrderItem();

    SoapApi33Domain.ServicePrices servicePrices = new SoapApi33Domain.ServicePrices();
    SoapApi33Domain.PriceList priceList = new SoapApi33Domain.PriceList();
    SoapApi33Domain.AddAddressToParty addAddressToParty = new SoapApi33Domain.AddAddressToParty();
    SoapApi33Domain.AdjustmentApplications adjustmentApplications = new SoapApi33Domain.AdjustmentApplications();
    SoapApi33Domain.AgreementConfiguration agreementConfiguration = new SoapApi33Domain.AgreementConfiguration();
    SoapApi33Domain.StandardInvoiceAdjustmentApplication standardInvoiceAdjustmentApplication = new SoapApi33Domain.StandardInvoiceAdjustmentApplication();
    SoapApi33Domain.Currencies currencies = new SoapApi33Domain.Currencies();
    SoapApi33Domain.SystemSettings systemSettings = new SoapApi33Domain.SystemSettings();
    SoapApi33Domain.ServiceUsageRules serviceUsageRules = new SoapApi33Domain.ServiceUsageRules();
    SoapApi33Domain.GLAggregateBatch glAggregateBatch = new SoapApi33Domain.GLAggregateBatch();
    SoapApi33Domain.RenewServiceResponse renewServiceResponse = new SoapApi33Domain.RenewServiceResponse();
    SoapApi33Domain.DeactivateService deactivateService = new SoapApi33Domain.DeactivateService();
    SoapApi33Domain.DeactivateServiceResource deactivateServiceResource = new SoapApi33Domain.DeactivateServiceResource();
    SoapApi33Domain.ServicePriceRange servicePriceRange = new SoapApi33Domain.ServicePriceRange();
    SoapApi33Domain.RenewalOrder renewalOrder = new SoapApi33Domain.RenewalOrder();
    SoapApi33Domain.SuspensionReason suspensionReason = new SoapApi33Domain.SuspensionReason();
    SoapApi33Domain.GLExtractBatch glExtractBatch = new SoapApi33Domain.GLExtractBatch();
    SoapApi33Domain.PartyCategory partyCategory = new SoapApi33Domain.PartyCategory();
    SoapApi33Domain.RenewService renewService = new SoapApi33Domain.RenewService();
    SoapApi33Domain.BillingAccountRecurringPayment billingAccountRecurringPayment = new SoapApi33Domain.BillingAccountRecurringPayment();
    SoapApi33Domain.WhereClause whereClause = new SoapApi33Domain.WhereClause();
    SoapApi33Domain.AddServiceUsageRuleToService addServiceUsageRuleToService = new SoapApi33Domain.AddServiceUsageRuleToService();
    SoapApi33Domain.People people = new SoapApi33Domain.People();

    SoapApi33Domain.DeactivateBillingAccount deactivateBillingAccount = new SoapApi33Domain.DeactivateBillingAccount();
    SoapApi33Domain.DiscountCode discountCode = new SoapApi33Domain.DiscountCode();
    SoapApi33Domain.OrderItemCharge orderItemCharge = new SoapApi33Domain.OrderItemCharge();
    SoapApi33Domain.VoidUsageEvent voidUsageEvent = new SoapApi33Domain.VoidUsageEvent();
    SoapApi33Domain.ReallocatePayment reallocatePayment = new SoapApi33Domain.ReallocatePayment();

    SoapApi33Domain.ChangeOrders changeOrders = new SoapApi33Domain.ChangeOrders();
    SoapApi33Domain.DiscountChargeCategories discountChargeCategories = new SoapApi33Domain.DiscountChargeCategories();
    SoapApi33Domain.PayPalPaymentMethod payPalPaymentMethod = new SoapApi33Domain.PayPalPaymentMethod();
    SoapApi33Domain.ProductRelation productRelation = new SoapApi33Domain.ProductRelation();

    SoapApi33Domain.ProductUsageRules productUsageRules = new SoapApi33Domain.ProductUsageRules();
    SoapApi33Domain.ProductQuery productQuery = new SoapApi33Domain.ProductQuery();
    SoapApi33Domain.GeneralLedger generalLedger = new SoapApi33Domain.GeneralLedger();
    SoapApi33Domain.ApproveAction approveAction = new SoapApi33Domain.ApproveAction();
    SoapApi33Domain.DeactivationReason deactivationReason = new SoapApi33Domain.DeactivationReason();
    SoapApi33Domain.AbstractServiceResource abstractServiceResource = new SoapApi33Domain.AbstractServiceResource();
    SoapApi33Domain.DiscountCategory discountCategory = new SoapApi33Domain.DiscountCategory();
    SoapApi33Domain.InvoiceItemCharge invoiceItemCharge = new SoapApi33Domain.InvoiceItemCharge();
    SoapApi33Domain.ProductSaleOperationAttribute productSaleOperationAttribute = new SoapApi33Domain.ProductSaleOperationAttribute();
    SoapApi33Domain.Actions actions = new SoapApi33Domain.Actions();
    SoapApi33Domain.RateTables rateTables = new SoapApi33Domain.RateTables();

    SoapApi33Domain.GLAggregateBatches glAggregateBatches = new SoapApi33Domain.GLAggregateBatches();
    SoapApi33Domain.DiscountIdentifier discountIdentifier = new SoapApi33Domain.DiscountIdentifier();
    SoapApi33Domain.PartyCategories partyCategories = new SoapApi33Domain.PartyCategories();
    SoapApi33Domain.OrderItemUsageRule orderItemUsageRule = new SoapApi33Domain.OrderItemUsageRule();
    SoapApi33Domain.AdjustmentApplication adjustmentApplication = new SoapApi33Domain.AdjustmentApplication();
    SoapApi33Domain.SegmentedMonthlyBillCycle segmentedMonthlyBillCycle = new SoapApi33Domain.SegmentedMonthlyBillCycle();
    SoapApi33Domain.BuildableDataQuery buildableDataQuery = new SoapApi33Domain.BuildableDataQuery();
    SoapApi33Domain.UsageEventCounter usageEventCounter = new SoapApi33Domain.UsageEventCounter();
    SoapApi33Domain.Page_x page_x = new SoapApi33Domain.Page_x();
    SoapApi33Domain.MatchAllOrderItemUsageRule matchAllOrderItemUsageRule = new SoapApi33Domain.MatchAllOrderItemUsageRule();
    SoapApi33Domain.AddServiceResourceToService addServiceResourceToService = new SoapApi33Domain.AddServiceResourceToService();
    SoapApi33Domain.SalesOrderCommand salesOrderCommand = new SoapApi33Domain.SalesOrderCommand();
    SoapApi33Domain.GeneratePaymentCollectionReferrerToken generatePaymentCollectionReferrerToken = new SoapApi33Domain.GeneratePaymentCollectionReferrerToken();
    SoapApi33Domain.ResumeService resumeService = new SoapApi33Domain.ResumeService();
    SoapApi33Domain.OrderCommandResponse orderCommandResponse = new SoapApi33Domain.OrderCommandResponse();

    SoapApi33Domain.CreditCardPaymentMethod creditCardPaymentMethod = new SoapApi33Domain.CreditCardPaymentMethod();
    SoapApi33Domain.BillingAccountActionCommand billingAccountActionCommand = new SoapApi33Domain.BillingAccountActionCommand();
    SoapApi33Domain.ReverseAdjustment reverseAdjustment = new SoapApi33Domain.ReverseAdjustment();
    SoapApi33Domain.TaxOrderItem taxOrderItem = new SoapApi33Domain.TaxOrderItem();
    SoapApi33Domain.BillingAccountSegment billingAccountSegment = new SoapApi33Domain.BillingAccountSegment();
    SoapApi33Domain.ServicePriceRanges servicePriceRanges = new SoapApi33Domain.ServicePriceRanges();
    SoapApi33Domain.AdjustmentCategory adjustmentCategory = new SoapApi33Domain.AdjustmentCategory();
    SoapApi33Domain.AddCounterToService addCounterToService = new SoapApi33Domain.AddCounterToService();
    SoapApi33Domain.UsagePriceCategories usagePriceCategories = new SoapApi33Domain.UsagePriceCategories();
    SoapApi33Domain.ChangeServiceCommand changeServiceCommand = new SoapApi33Domain.ChangeServiceCommand();
    SoapApi33Domain.Promotions promotions = new SoapApi33Domain.Promotions();
    SoapApi33Domain.ServiceDeviceInventoryItem serviceDeviceInventoryItem = new SoapApi33Domain.ServiceDeviceInventoryItem();
    SoapApi33Domain.ServicePeriod servicePeriod = new SoapApi33Domain.ServicePeriod();
    SoapApi33Domain.GLAccountCategories glAccountCategories = new SoapApi33Domain.GLAccountCategories();
    SoapApi33Domain.ChargeCategory chargeCategory = new SoapApi33Domain.ChargeCategory();
    SoapApi33Domain.CancelPayment cancelPayment = new SoapApi33Domain.CancelPayment();
    SoapApi33Domain.Address address = new SoapApi33Domain.Address();
    SoapApi33Domain.ServicePeriods servicePeriods = new SoapApi33Domain.ServicePeriods();

    SoapApi33Domain.DiscountChargeCategory discountChargeCategory = new SoapApi33Domain.DiscountChargeCategory();
    SoapApi33Domain.BillingAccountSegmentField billingAccountSegmentField = new SoapApi33Domain.BillingAccountSegmentField();
    SoapApi33Domain.Operation operation = new SoapApi33Domain.Operation();
    SoapApi33Domain.Counters counters = new SoapApi33Domain.Counters();
    SoapApi33Domain.InvoiceAdjustmentApplication invoiceAdjustmentApplication = new SoapApi33Domain.InvoiceAdjustmentApplication();
    SoapApi33Domain.InvoiceItem invoiceItem = new SoapApi33Domain.InvoiceItem();
    SoapApi33Domain.Orders orders = new SoapApi33Domain.Orders();
    SoapApi33Domain.GLAggregateEntry glAggregateEntry = new SoapApi33Domain.GLAggregateEntry();
    SoapApi33Domain.AddRecurringPaymentToBillingAccount addRecurringPaymentToBillingAccount = new SoapApi33Domain.AddRecurringPaymentToBillingAccount();
    SoapApi33Domain.ProductCategories productCategories = new SoapApi33Domain.ProductCategories();
    SoapApi33Domain.ScheduledCharges scheduledCharges = new SoapApi33Domain.ScheduledCharges();
    SoapApi33Domain.InvoiceItems invoiceItems = new SoapApi33Domain.InvoiceItems();
    SoapApi33Domain.BillingAccountSegmentFields billingAccountSegmentFields = new SoapApi33Domain.BillingAccountSegmentFields();
    SoapApi33Domain.GlobalProductUsageRule globalProductUsageRule = new SoapApi33Domain.GlobalProductUsageRule();
    SoapApi33Domain.AccountType accountType = new SoapApi33Domain.AccountType();
    SoapApi33Domain.BankPaymentMethod bankPaymentMethod = new SoapApi33Domain.BankPaymentMethod();
    SoapApi33Domain.GLAccount glAccount = new SoapApi33Domain.GLAccount();
    SoapApi33Domain.ChangeServiceResource changeServiceResource = new SoapApi33Domain.ChangeServiceResource();

    SoapApi33Domain.ReverseInvoiceApplicationFromAdjustment reverseInvoiceApplicationFromAdjustment = new SoapApi33Domain.ReverseInvoiceApplicationFromAdjustment();
    SoapApi33Domain.ProductUsageRule productUsageRule = new SoapApi33Domain.ProductUsageRule();
    SoapApi33Domain.GLAggregateEntries glAggregateEntries = new SoapApi33Domain.GLAggregateEntries();
    SoapApi33Domain.UsageRate usageRate = new SoapApi33Domain.UsageRate();
    SoapApi33Domain.AddCustomFieldValueToService addCustomFieldValueToService = new SoapApi33Domain.AddCustomFieldValueToService();
    SoapApi33Domain.FormulaProductUsageRule formulaProductUsageRule = new SoapApi33Domain.FormulaProductUsageRule();
    SoapApi33Domain.ApproveOrderItem approveOrderItem = new SoapApi33Domain.ApproveOrderItem();

    SoapApi33Domain.InventoryItem inventoryItem = new SoapApi33Domain.InventoryItem();
    SoapApi33Domain.OperationAttribute operationAttribute = new SoapApi33Domain.OperationAttribute();
    SoapApi33Domain.Operations operations = new SoapApi33Domain.Operations();
    SoapApi33Domain.TractResponseObject tractResponseObject = new SoapApi33Domain.TractResponseObject();
    SoapApi33Domain.Organizations organizations = new SoapApi33Domain.Organizations();
    SoapApi33Domain.AddPersonToBillingAccount addPersonToBillingAccount = new SoapApi33Domain.AddPersonToBillingAccount();
    SoapApi33Domain.SystemSetting systemSetting = new SoapApi33Domain.SystemSetting();
    //SoapApi33Domain.Order Order = new SoapApi33Domain.Order();

    SoapApi33Domain.ApprovalOperation approvalOperation = new SoapApi33Domain.ApprovalOperation();
    SoapApi33Domain.UsageLookupTableEntries usageLookupTableEntries = new SoapApi33Domain.UsageLookupTableEntries();
    SoapApi33Domain.CounterResetCriteria counterResetCriteria = new SoapApi33Domain.CounterResetCriteria();
    SoapApi33Domain.GLAccountingEntry gLAccountingEntry = new SoapApi33Domain.GLAccountingEntry();
    SoapApi33Domain.responses_element responses_element = new SoapApi33Domain.responses_element();
    SoapApi33Domain.ServicePeriodCounterResetCriteria servicePeriodCounterResetCriteria = new SoapApi33Domain.ServicePeriodCounterResetCriteria();
    SoapApi33Domain.Reasons reasons = new SoapApi33Domain.Reasons();
    SoapApi33Domain.RemoveCustomFieldValueFromService removeCustomFieldValueFromService = new SoapApi33Domain.RemoveCustomFieldValueFromService();
    SoapApi33Domain.UsageChargeCounter usageChargeCounter = new SoapApi33Domain.UsageChargeCounter();
    SoapApi33Domain.BuildableQuery buildableQuery = new SoapApi33Domain.BuildableQuery();
    SoapApi33Domain.FormulaServiceUsageRule formulaServiceUsageRule = new SoapApi33Domain.FormulaServiceUsageRule();
    SoapApi33Domain.UsagePriceCategory usagePriceCategory = new SoapApi33Domain.UsagePriceCategory();
    SoapApi33Domain.DenyOrderItem denyOrderItem = new SoapApi33Domain.DenyOrderItem();
    SoapApi33Domain.RefundReason refundReason = new SoapApi33Domain.RefundReason();
    SoapApi33Domain.Reason reason = new SoapApi33Domain.Reason();
    SoapApi33Domain.RemovePersonFromBillingAccount removePersonFromBillingAccount = new SoapApi33Domain.RemovePersonFromBillingAccount();
    SoapApi33Domain.CommandObject commandObject = new SoapApi33Domain.CommandObject();

    SoapApi33Domain.RemoveServiceResourceFromService removeServiceResourceFromService = new SoapApi33Domain.RemoveServiceResourceFromService();
    SoapApi33Domain.RenewalOrders renewalOrders = new SoapApi33Domain.RenewalOrders();
    SoapApi33Domain.PromotionQuery promotionQuery = new SoapApi33Domain.PromotionQuery();
    SoapApi33Domain.ReferencedCreditCardPaymentMethod ref = new SoapApi33Domain.ReferencedCreditCardPaymentMethod();
    SoapApi33Domain.GlobalServiceUsageRule globalServiceUsageRule = new SoapApi33Domain.GlobalServiceUsageRule();
    SoapApi33Domain.DiscountCodes discountCodes = new SoapApi33Domain.DiscountCodes();
    SoapApi33Domain.PriceLists priceLists = new SoapApi33Domain.PriceLists();
    SoapApi33Domain.PostAdjustment postAdjustment = new SoapApi33Domain.PostAdjustment();
    //SoapApi33Domain.Order orderss = new SoapApi33Domain.Order();
    SoapApi33Domain.ServiceResourceCategories srvc = new SoapApi33Domain.ServiceResourceCategories();
    SoapApi33Domain.AdjustmentInvoiceItems items = new SoapApi33Domain.AdjustmentInvoiceItems();
    SoapApi33Domain.ProductTag tag = new SoapApi33Domain.ProductTag();
    SoapApi33Domain.BatchResponse responce = new SoapApi33Domain.BatchResponse();
    SoapApi33Domain.BatchRequest request = new SoapApi33Domain.BatchRequest();
    SoapApi33Domain.ChangeServiceQuantityCommand command = new SoapApi33Domain.ChangeServiceQuantityCommand();
    SoapApi33Domain.ProductTags tags = new SoapApi33Domain.ProductTags();
    SoapApi33Domain.MoveBillingAccountToBillCycle cycle = new SoapApi33Domain.MoveBillingAccountToBillCycle();
    SoapApi33Domain.ChangeService service1 = new SoapApi33Domain.ChangeService();
    SoapApi33Domain.InvoiceAdjustmentApplications app = new SoapApi33Domain.InvoiceAdjustmentApplications();
    //SoapApi33Domain.ServiceSuspensionReason reasons1 = new  SoapApi33Domain.AdjustmentInvoiceItems();
    SoapApi33Domain.ProductInvoiceItem item1 = new SoapApi33Domain.ProductInvoiceItem();
    SoapApi33Domain.AddDiscountIdentifierToDiscountCode code1 = new SoapApi33Domain.AddDiscountIdentifierToDiscountCode();
    SoapApi33Domain.GLAccountingTransactions sactions = new SoapApi33Domain.GLAccountingTransactions();
    SoapApi33Domain.DiscountCodeService service2 = new SoapApi33Domain.DiscountCodeService();
    SoapApi33Domain.CommandResponse cresponce1 = new SoapApi33Domain.CommandResponse();
    SoapApi33Domain.AdditionalFeeInvoiceItem item2 = new SoapApi33Domain.AdditionalFeeInvoiceItem();
    SoapApi33Domain.RemoveParentBillingAccount account3 = new SoapApi33Domain.RemoveParentBillingAccount();
    SoapApi33Domain.AddAddressToService service3 = new SoapApi33Domain.AddAddressToService();
    SoapApi33Domain.TableUsageRate rate = new SoapApi33Domain.TableUsageRate();
    SoapApi33Domain.requests_element element = new SoapApi33Domain.requests_element();
    SoapApi33Domain.RemoveDiscountIdentifierFromDiscountCode dcode = new SoapApi33Domain.RemoveDiscountIdentifierFromDiscountCode();
    SoapApi33Domain.NegativeInvoiceAdjustmentApplication adapp = new SoapApi33Domain.NegativeInvoiceAdjustmentApplication();
    SoapApi33Domain.PaymentApplications papp = new SoapApi33Domain.PaymentApplications();
    SoapApi33Domain.PayByPayPalPaymentMethod pmethod = new SoapApi33Domain.PayByPayPalPaymentMethod();
    SoapApi33Domain.RequestedServiceResource rrequest = new SoapApi33Domain.RequestedServiceResource();
    SoapApi33Domain.GLPaymentAccountingTransaction atrans = new SoapApi33Domain.GLPaymentAccountingTransaction();
    SoapApi33Domain.GLAccountingTransaction gtans = new SoapApi33Domain.GLAccountingTransaction();
    SoapApi33Domain.ChangeServiceScheduledOneTimePriceCharges changecharge = new SoapApi33Domain.ChangeServiceScheduledOneTimePriceCharges();
    SoapApi33Domain.NegativeInvoiceAdjustmentApplications napp = new SoapApi33Domain.NegativeInvoiceAdjustmentApplications();
    SoapApi33Domain.GLAdjustmentAccountingTransaction gltrans = new SoapApi33Domain.GLAdjustmentAccountingTransaction();
    SoapApi33Domain.ServiceInvoiceItem sitem2 = new SoapApi33Domain.ServiceInvoiceItem();
    SoapApi33Domain.DiscountCodeServices dservice = new SoapApi33Domain.DiscountCodeServices();
    SoapApi33Domain.ReversedInvoicePaymentApplications revapp = new SoapApi33Domain.ReversedInvoicePaymentApplications();
    SoapApi33Domain.CreateResponse cresp = new SoapApi33Domain.CreateResponse();
    SoapApi33Domain.scheduledOneTimePriceCharges_element pelem = new SoapApi33Domain.scheduledOneTimePriceCharges_element();
    SoapApi33Domain.DiscountConfiguration sconfig = new SoapApi33Domain.DiscountConfiguration();
    SoapApi33Domain.RemoveAddressFromService fromser = new SoapApi33Domain.RemoveAddressFromService();
    SoapApi33Domain.ChangeParentBillingAccount billAccount = new SoapApi33Domain.ChangeParentBillingAccount();
    SoapApi33Domain.BasePriceCharge basecharge = new SoapApi33Domain.BasePriceCharge();

    SoapApi33Domain.StandardInvoiceAdjustmentApplications adapp1 = new SoapApi33Domain.StandardInvoiceAdjustmentApplications();
    SoapApi33Domain.ChangeServiceScheduledCharges scharges2 = new SoapApi33Domain.ChangeServiceScheduledCharges();
    SoapApi33Domain.OneTimeProductPrices onetprice = new SoapApi33Domain.OneTimeProductPrices();
    SoapApi33Domain.RecurringProductPrices recprice = new SoapApi33Domain.RecurringProductPrices();
    SoapApi33Domain.ScheduledOneTimePriceCharge onetchatge = new SoapApi33Domain.ScheduledOneTimePriceCharge();
    SoapApi33Domain.changeServiceAbstractPriceChargesCommand chargecomm = new SoapApi33Domain.changeServiceAbstractPriceChargesCommand();
    SoapApi33Domain.ScheduledOneTimePriceCharges timepricecharge = new SoapApi33Domain.ScheduledOneTimePriceCharges();
    //SoapApi33Domain.FormulaOrderItemUsageRuleobj sageruleobj = new  SoapApi33Domain.FormulaOrderItemUsageRule();
    SoapApi33Domain.AdditionalInformation additionalInformationobj = new SoapApi33Domain.AdditionalInformation();

    SoapApi33Domain.WriteOffsAdjustmentApplications writeOffsAdjustmentApplicationsobj = new SoapApi33Domain.WriteOffsAdjustmentApplications();
    SoapApi33Domain.UsageInvoiceItem usageInvoiceItemobj = new SoapApi33Domain.UsageInvoiceItem();
    SoapApi33Domain.writeOffAdjustmentApplication writeOffAdjustmentApplicationobj = new SoapApi33Domain.writeOffAdjustmentApplication();
    SoapApi33Domain.ProductPrice productPriceobj = new SoapApi33Domain.ProductPrice();
    SoapApi33Domain.ApplyRemainingPaymentToInvoice applyRemainingPaymentToInvoiceobj = new SoapApi33Domain.ApplyRemainingPaymentToInvoice();
    SoapApi33Domain.Refunds refundsobj = new SoapApi33Domain.Refunds();
    SoapApi33Domain.AuthorizationResponse authorizationResponseobj = new SoapApi33Domain.AuthorizationResponse();
    SoapApi33Domain.DiscountConfigurations discountConfigurationsobj = new SoapApi33Domain.DiscountConfigurations();
    SoapApi33Domain.RemoveAdjustment removeAdjustmentobj = new SoapApi33Domain.RemoveAdjustment();
    SoapApi33Domain.ChangeServicePriceCommand changeServicePriceCommandobj = new SoapApi33Domain.ChangeServicePriceCommand();
    SoapApi33Domain.UsageInvoiceItems itemobj2 = new SoapApi33Domain.UsageInvoiceItems();
    SoapApi33Domain.GLInvoiceAccountingTransaction tranobj = new SoapApi33Domain.GLInvoiceAccountingTransaction();
    SoapApi33Domain.ReversedInvoiceAdjustmentApplications addapp = new SoapApi33Domain.ReversedInvoiceAdjustmentApplications();
    SoapApi33Domain.abstractDiscountCodeServiceBillingAccount absbillacc = new SoapApi33Domain.abstractDiscountCodeServiceBillingAccount();
    SoapApi33Domain.ProductInvoiceItems provoiceitem = new SoapApi33Domain.ProductInvoiceItems();
    SoapApi33Domain.scheduledCharges_element schelement = new SoapApi33Domain.scheduledCharges_element();
    SoapApi33Domain.StandardInvoicePaymentApplication stpapp = new SoapApi33Domain.StandardInvoicePaymentApplication();
    SoapApi33Domain.UpdateResponse updateresp = new SoapApi33Domain.UpdateResponse();
    SoapApi33Domain.PaymentApplication papps = new SoapApi33Domain.PaymentApplication();
    SoapApi33Domain.TaxInvoiceItem txitem = new SoapApi33Domain.TaxInvoiceItem();
    SoapApi33Domain.ChangeOrderItemScheduledCharges cocharges = new SoapApi33Domain.ChangeOrderItemScheduledCharges();
    SoapApi33Domain.DiscountCodeCommand dccommand = new SoapApi33Domain.DiscountCodeCommand();
    SoapApi33Domain.ReverseDebitAdjustment rdadjustment = new SoapApi33Domain.ReverseDebitAdjustment();
    SoapApi33Domain.ChangeOrderItemScheduledOneTimePriceCharges tpcharge = new SoapApi33Domain.ChangeOrderItemScheduledOneTimePriceCharges();
    SoapApi33Domain.GLTransactionBatches glbatch = new SoapApi33Domain.GLTransactionBatches();
    SoapApi33Domain.Order order4 = new SoapApi33Domain.Order();
    SoapApi33Domain.changeOrderItemAbstractPriceChargesCommand pccommand = new SoapApi33Domain.changeOrderItemAbstractPriceChargesCommand();
    SoapApi33Domain.AdditionalFeeInvoiceItems afiitem = new SoapApi33Domain.AdditionalFeeInvoiceItems();
    SoapApi33Domain.StandardInvoicePaymentApplications stapp = new SoapApi33Domain.StandardInvoicePaymentApplications();
    SoapApi33Domain.BasePayment basep = new SoapApi33Domain.BasePayment();
    SoapApi33Domain.ReversedInvoicePaymentApplication rtapp = new SoapApi33Domain.ReversedInvoicePaymentApplication();
    SoapApi33Domain.ServiceInvoiceItems sinitems = new SoapApi33Domain.ServiceInvoiceItems();
    SoapApi33Domain.OneTimeProductPrice onetpass = new SoapApi33Domain.OneTimeProductPrice();
    // SoapApi33Domain.VGLTransactionBatch vbatch = new  SoapApi33Domain.VGLTransactionBatch();
    SoapApi33Domain.Referrer refferobj = new SoapApi33Domain.Referrer();

    SoapApi33Domain.EventCharge eventcharge = new SoapApi33Domain.EventCharge();
    SoapApi33Domain.AdjustmentItemCharge adjustment = new SoapApi33Domain.AdjustmentItemCharge();

    SoapApi33Domain.ServiceAdjustmentItem serviceAdjustmentItem = new SoapApi33Domain.ServiceAdjustmentItem();
    SoapApi33Domain.CustomFieldValueReferences customFieldValueReferences = new SoapApi33Domain.CustomFieldValueReferences();
    SoapApi33Domain.TaxPriceCategory taxPriceCategory = new SoapApi33Domain.TaxPriceCategory();
    SoapApi33Domain.FormulaOrderItemUsageRule formulaOrderItemUsageRule = new SoapApi33Domain.FormulaOrderItemUsageRule();
    SoapApi33Domain.LateFeeAdjustmentItem lateFeeAdjustmentItem = new SoapApi33Domain.LateFeeAdjustmentItem();
    SoapApi33Domain.CustomFieldValueReference customFieldValueReference = new SoapApi33Domain.CustomFieldValueReference();
    SoapApi33Domain.TaxInvoiceItems taxInvoiceItems = new SoapApi33Domain.TaxInvoiceItems();
    SoapApi33Domain.TrueUpChargeTypes trueUpChargeTypes = new SoapApi33Domain.TrueUpChargeTypes();
    SoapApi33Domain.UpdateRequest updateRequest = new SoapApi33Domain.UpdateRequest();
    SoapApi33Domain.AddParentBillingAccount addParentBillingAccount = new SoapApi33Domain.AddParentBillingAccount();
    SoapApi33Domain.OrderItemAdjustmentItem orderItemAdjustmentItem = new SoapApi33Domain.OrderItemAdjustmentItem();
    SoapApi33Domain.GLTransactionBatch gLTransactionBatch = new SoapApi33Domain.GLTransactionBatch();
    SoapApi33Domain.TokenizedCreditCardPaymentMethod tokenizedCreditCardPaymentMethod = new SoapApi33Domain.TokenizedCreditCardPaymentMethod();
    SoapApi33Domain.SepaDirectDebitPaymentMethod sepaDirectDebitPaymentMethod = new SoapApi33Domain.SepaDirectDebitPaymentMethod();
    SoapApi33Domain.User user = new SoapApi33Domain.User();
    SoapApi33Domain.Note note = new SoapApi33Domain.Note();
    SoapApi33Domain.NoteType noteType = new SoapApi33Domain.NoteType();
    SoapApi33Domain.Notes notes = new SoapApi33Domain.Notes();
    SoapApi33Domain.MobileCarrierPayment mobileCarrierPayment = new SoapApi33Domain.MobileCarrierPayment();
    SoapApi33Domain.BpayPaymentMethod bpayPaymentMethod = new SoapApi33Domain.BpayPaymentMethod();
    SoapApi33Domain.AuthorizationRequest authorizationRequest = new SoapApi33Domain.AuthorizationRequest();
    System.assertNotEquals(note, null);
  }
}