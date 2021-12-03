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
 * This class contains the inner classes to parse XML Response for various entities.
 * @Author AMAN JAIN
 */

public class SoapApi33Domain {
  //Manually added by Abhinav Bhatia from 1.30 version
  public class EventCharge {
    public SoapApi33Domain.UsageEvent usageEvent;
    public SoapApi33Domain.UsageRule usageRule;
    public SoapApi33Domain.UsagePriceCategory chargeCategory;
    public Decimal charge;
    public String usageUom;
    public Decimal usageAmount;
    private String[] usageEvent_type_info = new List<String>{
      'usageEvent',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] usageRule_type_info = new List<String>{
      'usageRule',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] chargeCategory_type_info = new List<String>{
      'chargeCategory',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] charge_att_info = new List<String>{ 'charge' };
    private String[] usageUom_att_info = new List<String>{ 'usageUom' };
    private String[] usageAmount_att_info = new List<String>{ 'usageAmount' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'usageEvent',
      'usageRule',
      'chargeCategory'
    };
  }
  public class AddInvoiceApplicationToAdjustment {
    public SoapApi33Domain.StandardInvoiceAdjustmentApplication invoiceAdjustmentApplication;
    private String[] invoiceAdjustmentApplication_type_info = new List<String>{
      'invoiceAdjustmentApplication',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'invoiceAdjustmentApplication'
    };
  }
  public class errors_element {
    public SoapApi33Service.FaultResponse[] error;
    private String[] error_type_info = new List<String>{
      'error',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'error' };
  }
  public class UsageLookupTable {
    public SoapApi33Domain.UsageLookupTableEntries entries;
    public String name;
    public String status;
    private String[] entries_type_info = new List<String>{
      'entries',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] name_att_info = new List<String>{ 'name' };
    private String[] status_att_info = new List<String>{ 'status' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'entries' };
  }
  public class OrderItemUsageRules {
    public SoapApi33Domain.MatchAllOrderItemUsageRule matchAllOrderItemUsageRule;
    public SoapApi33Domain.FormulaOrderItemUsageRule formulaOrderItemUsageRule;
    public SoapApi33Domain.GlobalOrderItemUsageRule globalOrderItemUsageRule;
    private String[] matchAllOrderItemUsageRule_type_info = new List<String>{
      'matchAllOrderItemUsageRule',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] formulaOrderItemUsageRule_type_info = new List<String>{
      'formulaOrderItemUsageRule',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] globalOrderItemUsageRule_type_info = new List<String>{
      'globalOrderItemUsageRule',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'matchAllOrderItemUsageRule',
      'formulaOrderItemUsageRule',
      'globalOrderItemUsageRule'
    };
  }
  public class AdjustmentInvoiceItems {
    public SoapApi33Domain.AdjustmentInvoiceItem[] adjustmentInvoiceItem;
    private String[] adjustmentInvoiceItem_type_info = new List<String>{
      'adjustmentInvoiceItem',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'adjustmentInvoiceItem'
    };
  }
  public class UsageLookupTables {
    public SoapApi33Domain.UsageLookupTable[] usageLookupTable;
    private String[] usageLookupTable_type_info = new List<String>{
      'usageLookupTable',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'usageLookupTable'
    };
  }
  public class AgreementCounterResetCriteria {
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class ProductTag {
    public String name;
    public String description;
    public Integer priority;
    public String eid;
    private String[] eid_att_info = new List<String>{ 'eid' };
    private String[] name_att_info = new List<String>{ 'name' };
    private String[] description_att_info = new List<String>{ 'description' };
    private String[] priority_att_info = new List<String>{ 'priority' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class SuspendService {
    public SoapApi33Domain.ServiceSuspensionReason reason;
    public SoapApi33Domain.Service service;
    private String[] reason_type_info = new List<String>{
      'reason',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] service_type_info = new List<String>{
      'service',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'reason',
      'service'
    };
  }
  public class BatchResponse {
    public SoapApi33Domain.responses_element responses;
    public SoapApi33Domain.errors_element errors;
    public Boolean errorOccurred;
    public Integer numRequestsProcessed;
    public Boolean successful;
    private String[] responses_type_info = new List<String>{
      'responses',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] errors_type_info = new List<String>{
      'errors',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] errorOccurred_att_info = new List<String>{
      'errorOccurred'
    };
    private String[] numRequestsProcessed_att_info = new List<String>{
      'numRequestsProcessed'
    };
    private String[] successful_att_info = new List<String>{ 'successful' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'responses',
      'errors'
    };
  }
  public class BatchRequest {
    public SoapApi33Domain.requests_element requests;
    public Boolean stopOnError;
    public Boolean transactional;
    private String[] requests_type_info = new List<String>{
      'requests',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] stopOnError_att_info = new List<String>{ 'stopOnError' };
    private String[] transactional_att_info = new List<String>{
      'transactional'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'requests' };
  }

  public class CommandBatchRequest {
    public SoapApi33Domain.commandRequests_element requests;
    public Boolean stopOnError;
    public Boolean transactional;
    private String[] requests_type_info = new List<String>{
      'requests',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] stopOnError_att_info = new List<String>{ 'stopOnError' };
    private String[] transactional_att_info = new List<String>{
      'transactional'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'requests' };
  }

  public class commandRequests_element {
    public SoapApi33Domain.CommandRequest[] command;
    private String[] command_type_info = new List<String>{
      'command',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'command' };
  }

  public class AgreementService {
    public SoapApi33Domain.Agreement agreement;
    public SoapApi33Domain.Agreement nextAgreement;
    public SoapApi33Domain.Product nextServiceProduct;
    public SoapApi33Domain.RecurringProductPrice nextServiceProductPrice;

    //Manullay added by Abhinav Bhatia from 1.30 version
    public SoapApi33Domain.TrueUpChargeTypes trueUpChargeTypes;

    public DateTime startDate;
    public DateTime endDate;
    public String endAction;
    public String nextEndAction;
    public Boolean nextServicePayOnPurchase;
    public Boolean renewed;
    public Boolean preserveServicePrice;
    public Boolean nextPreserveServicePrice;
    private String[] agreement_type_info = new List<String>{
      'agreement',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] nextAgreement_type_info = new List<String>{
      'nextAgreement',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] nextServiceProduct_type_info = new List<String>{
      'nextServiceProduct',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] nextServiceProductPrice_type_info = new List<String>{
      'nextServiceProductPrice',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] trueUpChargeTypes_type_info = new List<String>{
      'trueUpChargeTypes',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] startDate_att_info = new List<String>{ 'startDate' };
    private String[] endDate_att_info = new List<String>{ 'endDate' };
    private String[] endAction_att_info = new List<String>{ 'endAction' };
    private String[] nextEndAction_att_info = new List<String>{
      'nextEndAction'
    };
    private String[] nextServicePayOnPurchase_att_info = new List<String>{
      'nextServicePayOnPurchase'
    };
    private String[] renewed_att_info = new List<String>{ 'renewed' };
    private String[] preserveServicePrice_att_info = new List<String>{
      'preserveServicePrice'
    };
    private String[] nextPreserveServicePrice_att_info = new List<String>{
      'nextPreserveServicePrice'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'agreement',
      'nextAgreement',
      'nextServiceProduct',
      'nextServiceProductPrice',
      'trueUpChargeTypes'
    };
  }
  public class ChangeServiceQuantityCommand {
    public Decimal newQuantity;
    public String effectiveDate;

    public SoapApi33Domain.Service service;

    private String[] newQuantity_att_info = new List<String>{ 'newQuantity' };
    private String[] effectiveDate_att_info = new List<String>{
      'effectiveDate'
    };
    private String[] service_type_info = new List<String>{
      'service',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'service' };
  }

  public class payByPayPalPayment {
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ '' };
  }

  public class Payment {
    /* @Jrathore - From line below to next blank line copied
     *  from BillCycle Apex Class generated above to process
     *  response received from Tract.
     *
     *  Copied from BasePayment.
     */
    public SoapApi33Domain.BillingAccount billingAccount;
    public SoapApi33Domain.BankPaymentMethod bankPayment;
    public SoapApi33Domain.CashPaymentMethod cashPayment;
    public SoapApi33Domain.CheckPaymentMethod checkPayment;
    public SoapApi33Domain.CreditCardPaymentMethod creditCardPayment;
    public SoapApi33Domain.ReferencedCreditCardPaymentMethod referencedCreditCardPayment;
    public SoapApi33Domain.PayPalPaymentMethod payPalPayment;
    public PayByPayPalPayment payByPayPalPayment;
    public SoapApi33Domain.WireTransferPaymentMethod wireTransferPayment;
    public SoapApi33Domain.TokenizedCreditCardPaymentMethod tokenizedCreditCardPaymentMethod;
    public SoapApi33Domain.Refunds refunds;
    public String eid;
    public Decimal amount;
    public String description;
    public String authorization;
    public String reference;
    public DateTime occurredOn;
    public Boolean useRecurringPayment;
    public String status;
    public String invoicesPaid;
    public SoapApi33Domain.MobileCarrierPayment mobileCarrierPayment;
    public SoapApi33Domain.CustomPaymentMethod customPaymentMethod;
    public SoapApi33Domain.sepaDirectDebitPaymentMethod sepaDirectDebitPaymentMethod;
    private String[] sepaDirectDebitPaymentMethod_type_info = new List<String>{
      'sepaDirectDebitPaymentMethod',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] mobileCarrierPayment_type_info = new List<String>{
      'mobileCarrierPayment',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] tokenizedCreditCardPaymentMethod_type_info = new List<String>{
      'tokenizedCreditCardPaymentMethod',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] invoicesPaid_att_info = new List<String>{ 'invoicesPaid' };
    private String[] eid_att_info = new List<String>{ 'eid' };
    private String[] billingAccount_type_info = new List<String>{
      'billingAccount',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] bankPayment_type_info = new List<String>{
      'bankPayment',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] cashPayment_type_info = new List<String>{
      'cashPayment',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] checkPayment_type_info = new List<String>{
      'checkPayment',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] creditCardPayment_type_info = new List<String>{
      'creditCardPayment',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] referencedCreditCardPayment_type_info = new List<String>{
      'referencedCreditCardPayment',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] payPalPayment_type_info = new List<String>{
      'payPalPayment',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] payByPayPalPayment_type_info = new List<String>{
      'payByPayPalPayment',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] customPaymentMethod_type_info = new List<String>{
      'customPaymentMethod',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] wireTransferPayment_type_info = new List<String>{
      'wireTransferPayment',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] amount_att_info = new List<String>{ 'amount' };
    private String[] description_att_info = new List<String>{ 'description' };
    private String[] authorization_att_info = new List<String>{
      'authorization'
    };
    private String[] reference_att_info = new List<String>{ 'reference' };
    private String[] occurredOn_att_info = new List<String>{ 'occurredOn' };
    private String[] useRecurringPayment_att_info = new List<String>{
      'useRecurringPayment'
    };
    private String[] status_att_info = new List<String>{ 'status' };
    private String[] refunds_type_info = new List<String>{
      'refunds',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'billingAccount',
      'bankPayment',
      'cashPayment',
      'checkPayment',
      'creditCardPayment',
      'referencedCreditCardPayment',
      'payPalPayment',
      'payByPayPalPayment',
      'wireTransferPayment',
      'refunds',
      'customPaymentMethod',
      'tokenizedCreditCardPaymentMethod',
      'sepaDirectDebitPaymentMethod'
    };
  }

  public class SalesOrderItem {
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class AddCustomFieldValueToBillingAccount {
    public SoapApi33Domain.CustomFieldValue customFieldValue;
    public SoapApi33Domain.BillingAccount billingAccount;
    private String[] billingAccount_type_info = new List<String>{
      'billingAccount',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] customFieldValue_type_info = new List<String>{
      'customFieldValue',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };

    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'customFieldValue',
      'billingAccount'
    };
  }
  public class RemoveCustomFieldValueFromBillingAccount {
    public SoapApi33Domain.CustomFieldValue customFieldValue;
    public SoapApi33Domain.BillingAccount billingAccount;
    private String[] customFieldValue_type_info = new List<String>{
      'customFieldValue',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] billingAccount_type_info = new List<String>{
      'billingAccount',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'billingAccount',
      'customFieldValue'
    };
  }
  public class ConfirmOrder {
    public SoapApi33Domain.Payment payment;
    private String[] payment_type_info = new List<String>{
      'payment',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'payment' };
  }
  public class ResumeBillingAccount {
    public DateTime startDate;
    public SoapApi33Domain.BillingAccount billingAccount;
    private String[] billingAccount_type_info = new List<String>{
      'billingAccount',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] startDate_att_info = new List<String>{ 'startDate' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'billingAccount'
    };
  }
  public class Page_x {
    public Integer pageNumber;
    public Integer pageSize;
    public Long totalElements;
    public Integer elementCount;
    public Integer totalPages;
    private String[] pageNumber_att_info = new List<String>{ 'pageNumber' };
    private String[] pageSize_att_info = new List<String>{ 'pageSize' };
    private String[] totalElements_att_info = new List<String>{
      'totalElements'
    };
    private String[] elementCount_att_info = new List<String>{ 'elementCount' };
    private String[] totalPages_att_info = new List<String>{ 'totalPages' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class EmailAddress {
    public String purpose;
    public String email;
    private String[] purpose_att_info = new List<String>{ 'purpose' };
    private String[] email_att_info = new List<String>{ 'email' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class GLAccountingEntries {
    public SoapApi33Domain.GLAccountingEntry[] glAccountingEntry;
    private String[] glAccountingEntry_type_info = new List<String>{
      'glAccountingEntry',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'glAccountingEntry'
    };
  }
  public class OrderItemCommand {
    public SoapApi33Domain.OrderItem orderItem;
    private String[] orderItem_type_info = new List<String>{
      'orderItem',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'orderItem' };
  }

  public class AdjustmentItems {
    public SoapApi33Domain.ManualAdjustmentItem manualAdjustmentItem;
    public SoapApi33Domain.LateFeeAdjustmentItem lateFeeAdjustmentItem;
    public SoapApi33Domain.TerminationChargeAdjustmentItem terminationChargeAdjustmentItem;
    public SoapApi33Domain.ServiceAdjustmentItem serviceAdjustmentItem;
    public SoapApi33Domain.OrderItemAdjustmentItem orderItemAdjustmentItem;
    public SoapApi33Domain.TrueUpChargeAdjustmentItem trueUpChargeAdjustmentItem;
    private String[] manualAdjustmentItem_type_info = new List<String>{
      'manualAdjustmentItem',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] lateFeeAdjustmentItem_type_info = new List<String>{
      'lateFeeAdjustmentItem',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] terminationChargeAdjustmentItem_type_info = new List<String>{
      'terminationChargeAdjustmentItem',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] serviceAdjustmentItem_type_info = new List<String>{
      'serviceAdjustmentItem',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] orderItemAdjustmentItem_type_info = new List<String>{
      'orderItemAdjustmentItem',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] trueUpChargeAdjustmentItem_type_info = new List<String>{
      'trueUpChargeAdjustmentItem',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'manualAdjustmentItem',
      'lateFeeAdjustmentItem',
      'terminationChargeAdjustmentItem',
      'serviceAdjustmentItem',
      'orderItemAdjustmentItem',
      'trueUpChargeAdjustmentItem'
    };
  }

  public class EventCharges {
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ '' };
  }

  public class UsageEvent {
    public String serviceResourceType;
    public Decimal totalCharge;
    public EventCharges eventCharges;
    public String description;
    public DateTime startTime;
    public DateTime endTime;
    public String serviceResourceId;
    public String usageUom;
    public Decimal usageAmount;
    public String referenceId;
    public String sequenceId;
    public String text01;
    public String text02;
    public String text03;
    public String text04;
    public String text05;
    public Decimal number01;
    public Decimal number02;
    public Decimal number03;
    public Decimal number04;
    public Decimal number05;
    public Boolean boolean01;
    public Boolean boolean02;
    public Boolean boolean03;
    public Boolean boolean04;
    public Boolean boolean05;
    public String date01;
    public String date02;
    public String date03;
    public String date04;
    public String date05;
    private String[] serviceResourceType_type_info = new List<String>{
      'serviceResourceType',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] eventCharges_type_info = new List<String>{
      'eventCharges',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] totalCharge_att_info = new List<String>{ 'totalCharge' };
    private String[] description_att_info = new List<String>{ 'description' };
    private String[] startTime_att_info = new List<String>{ 'startTime' };
    private String[] endTime_att_info = new List<String>{ 'endTime' };
    private String[] serviceResourceId_att_info = new List<String>{
      'serviceResourceId'
    };
    private String[] usageUom_att_info = new List<String>{ 'usageUom' };
    private String[] usageAmount_att_info = new List<String>{ 'usageAmount' };
    private String[] referenceId_att_info = new List<String>{ 'referenceId' };
    private String[] sequenceId_att_info = new List<String>{ 'sequenceId' };
    private String[] text01_att_info = new List<String>{ 'text01' };
    private String[] text02_att_info = new List<String>{ 'text02' };
    private String[] text03_att_info = new List<String>{ 'text03' };
    private String[] text04_att_info = new List<String>{ 'text04' };
    private String[] text05_att_info = new List<String>{ 'text05' };
    private String[] number01_att_info = new List<String>{ 'number01' };
    private String[] number02_att_info = new List<String>{ 'number02' };
    private String[] number03_att_info = new List<String>{ 'number03' };
    private String[] number04_att_info = new List<String>{ 'number04' };
    private String[] number05_att_info = new List<String>{ 'number05' };
    private String[] boolean01_att_info = new List<String>{ 'boolean01' };
    private String[] boolean02_att_info = new List<String>{ 'boolean02' };
    private String[] boolean03_att_info = new List<String>{ 'boolean03' };
    private String[] boolean04_att_info = new List<String>{ 'boolean04' };
    private String[] boolean05_att_info = new List<String>{ 'boolean05' };
    private String[] date01_att_info = new List<String>{ 'date01' };
    private String[] date02_att_info = new List<String>{ 'date02' };
    private String[] date03_att_info = new List<String>{ 'date03' };
    private String[] date04_att_info = new List<String>{ 'date04' };
    private String[] date05_att_info = new List<String>{ 'date05' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'serviceResourceType',
      'eventCharges'
    };
  }
  public class CashPaymentMethod {
    public String eid;
    public SoapApi33Domain.CustomFieldValues customFieldValues;
    private String[] eid_att_info = new List<String>{ 'eid' };
    private String[] customFieldValues_type_info = new List<String>{
      'customFieldValues',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'customFieldValues'
    };
  }
  public class MatchAllServiceUsageRule {
    public String status;
    public String usageUom;
    public String name;
    public String rollOverType;
    public String eid;
    public String ruleType;
    public String allowanceType;
    public String order;
    public Double limit_x;
    public Boolean proratedOnOrder;
    public Boolean proratedOnCancel;
    private String[] status_att_info = new List<String>{ 'status' };
    private String[] usageUom_att_info = new List<String>{ 'usageUom' };
    private String[] name_att_info = new List<String>{ 'name' };
    private String[] rollOverType_att_info = new List<String>{ 'rollOverType' };
    private String[] eid_att_info = new List<String>{ 'eid' };
    private String[] ruleType_att_info = new List<String>{ 'ruleType' };
    private String[] allowanceType_att_info = new List<String>{
      'allowanceType'
    };
    private String[] order_att_info = new List<String>{ 'order' };
    private String[] limit_x_att_info = new List<String>{ 'limit' };
    private String[] proratedOnOrder_att_info = new List<String>{
      'proratedOnOrder'
    };
    private String[] proratedOnCancel_att_info = new List<String>{
      'proratedOnCancel'
    };

    public SoapApi33Domain.ChargeCategory chargeCategory;
    public SoapApi33Domain.FlatUsageRate flatUsageRate;

    public SoapApi33Domain.MatchAllOrderItemUsageRule matchAllOrderItemUsageRule;
    public SoapApi33Domain.MatchAllProductUsageRule matchAllProductUsageRule;
    public SoapApi33Domain.TableUsageRate tableUsageRate;
    public SoapApi33Domain.RateTable rateTable;
    public SoapApi33Domain.PassThroughUsageRate passThroughUsageRate;
    public SoapApi33Domain.RateTableEntries rateTableEntries;
    private String[] chargeCategory_type_info = new List<String>{
      'chargeCategory',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] flatUsageRate_type_info = new List<String>{
      'flatUsageRate',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] matchAllOrderItemUsageRule_type_info = new List<String>{
      'matchAllOrderItemUsageRule',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] matchAllProductUsageRule_type_info = new List<String>{
      'matchAllProductUsageRule',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] tableUsageRate_type_info = new List<String>{
      'tableUsageRate',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] rateTable_type_info = new List<String>{
      'rateTable',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] passThroughUsageRate_type_info = new List<String>{
      'passThroughUsageRate',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] rateTableEntries_type_info = new List<String>{
      'rateTableEntries',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'chargeCategory',
      'flatUsageRate',
      'matchAllOrderItemUsageRule',
      'matchAllProductUsageRule',
      'tableUsageRate',
      'rateTable',
      'passThroughUsageRate',
      'rateTableEntries'
    };
  }
  public class UsageEvents {
    public Integer pageNumber;
    public Integer pageSize;
    public Long totalElements;
    public Integer elementCount;
    public Integer totalPages;
    private String[] pageNumber_att_info = new List<String>{ 'pageNumber' };
    private String[] pageSize_att_info = new List<String>{ 'pageSize' };
    private String[] totalElements_att_info = new List<String>{
      'totalElements'
    };
    private String[] elementCount_att_info = new List<String>{ 'elementCount' };
    private String[] totalPages_att_info = new List<String>{ 'totalPages' };
    public SoapApi33Domain.UsageEvent[] usageEvent;
    private String[] usageEvent_type_info = new List<String>{
      'usageEvent',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'usageEvent' };
  }
  public class OrderBy {
    public String attribute;
    public Boolean ascending;
    private String[] attribute_att_info = new List<String>{ 'attribute' };
    private String[] ascending_att_info = new List<String>{ 'ascending' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class ServicePrice {
    public SoapApi33Domain.Promotion promotion;
    public SoapApi33Domain.ServicePriceRanges servicePriceRanges;
    public SoapApi33Domain.ScheduledCharges scheduledCharges;
    //Manually addded by Abhinav Bhatia from 1.30 version
    public SoapApi33Domain.OneTimeProductPrice oneTimeProductPrice;
    public SoapApi33Domain.RecurringProductPrice recurringProductPrice;

    public Decimal amount;
    public DateTime startDate;
    public DateTime endDate;
    public Boolean billInAdvance;
    public String recurrencePeriod;
    private String[] promotion_type_info = new List<String>{
      'promotion',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] servicePriceRanges_type_info = new List<String>{
      'servicePriceRanges',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] scheduledCharges_type_info = new List<String>{
      'scheduledCharges',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    //Manually addded by Abhinav Bhatia from 1.30 version
    private String[] oneTimeProductPrice_type_info = new List<String>{
      'oneTimeProductPrice',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] recurringProductPrice_type_info = new List<String>{
      'recurringProductPrice',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };

    private String[] amount_att_info = new List<String>{ 'amount' };
    private String[] startDate_att_info = new List<String>{ 'startDate' };
    private String[] endDate_att_info = new List<String>{ 'endDate' };
    private String[] billInAdvance_att_info = new List<String>{
      'billInAdvance'
    };
    private String[] recurrencePeriod_att_info = new List<String>{
      'recurrencePeriod'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'promotion',
      'servicePriceRanges',
      'scheduledCharges',
      'oneTimeProductPrice',
      'recurringProductPrice'
    };
  }
  public class ProductTags {
    public SoapApi33Domain.ProductTag[] productTags;
    private String[] productTags_type_info = new List<String>{
      'productTags',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'productTags' };
  }
  public class MoveBillingAccountToBillCycle {
    public SoapApi33Domain.BillCycle billCycle;
    public SoapApi33Domain.BillingAccount billingAccount;
    private String[] billingAccount_type_info = new List<String>{
      'billingAccount',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] billCycle_type_info = new List<String>{
      'billCycle',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'billCycle',
      'billingAccount'
    };
  }
  //Manually added by Abhinav Bhatia from 1.30 version
  public class TrueUpChargeAdjustmentItem {
    public SoapApi33Domain.AgreementService agreementService;
    public SoapApi33Domain.Adjustment adjustment;
    public SoapApi33Domain.AdjustmentReason reason;
    public SoapApi33Domain.AdjustmentReason secondaryReason;
    public SoapApi33Domain.AdjustmentCategory category;
    private String[] adjustment_type_info = new List<String>{
      'adjustment',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] reason_type_info = new List<String>{
      'reason',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] secondaryReason_type_info = new List<String>{
      'secondaryReason',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] category_type_info = new List<String>{
      'category',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] agreementService_type_info = new List<String>{
      'agreementService',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'agreementService',
      'adjustment',
      'reason',
      'secondaryReason',
      'category'
    };
  }
  public class PaymentTerms {
    public SoapApi33Domain.PaymentTerm[] paymentTerm;
    private String[] paymentTerm_type_info = new List<String>{
      'paymentTerm',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'paymentTerm' };
  }
  //Manually added by Abhinav Bhatia from 1.30 version
  public class AdjustmentItemCharge {
    public SoapApi33Domain.ManualAdjustmentItem manualAdjustmentItem;
    public SoapApi33Domain.LateFeeAdjustmentItem lateFeeAdjustmentItem;
    public SoapApi33Domain.TerminationChargeAdjustmentItem terminationChargeAdjustmentItem;
    public SoapApi33Domain.ServiceAdjustmentItem serviceAdjustmentItem;
    public SoapApi33Domain.OrderItemAdjustmentItem orderItemAdjustmentItem;
    public SoapApi33Domain.TrueUpChargeAdjustmentItem trueUpChargeAdjustmentItem;
    public SoapApi33Domain.PriceCategory priceCategory;
    public SoapApi33Domain.TaxPriceCategory taxPriceCategory;
    public Decimal amount;
    private String[] manualAdjustmentItem_type_info = new List<String>{
      'manualAdjustmentItem',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] lateFeeAdjustmentItem_type_info = new List<String>{
      'lateFeeAdjustmentItem',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] terminationChargeAdjustmentItem_type_info = new List<String>{
      'terminationChargeAdjustmentItem',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] serviceAdjustmentItem_type_info = new List<String>{
      'serviceAdjustmentItem',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] orderItemAdjustmentItem_type_info = new List<String>{
      'orderItemAdjustmentItem',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] trueUpChargeAdjustmentItem_type_info = new List<String>{
      'trueUpChargeAdjustmentItem',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] priceCategory_type_info = new List<String>{
      'priceCategory',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] taxPriceCategory_type_info = new List<String>{
      'taxPriceCategory',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] amount_att_info = new List<String>{ 'amount' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'manualAdjustmentItem',
      'lateFeeAdjustmentItem',
      'terminationChargeAdjustmentItem',
      'serviceAdjustmentItem',
      'orderItemAdjustmentItem',
      'trueUpChargeAdjustmentItem',
      'priceCategory',
      'taxPriceCategory'
    };
  }
  public class MatchAllProductUsageRule {
    public String status;
    public String name;
    public DateTime validFrom;
    public Double limit_x;
    public String eid;
    public String allowanceType;
    public String usageUom;
    public String rollOverType;
    public String ruleType;
    public Boolean proratedOnOrder;
    public Boolean proratedOnCancel;

    public SoapApi33Domain.ChargeCategory chargeCategory;
    public SoapApi33Domain.FlatUsageRate flatUsageRate;
    private String[] status_att_info = new List<String>{ 'status' };
    private String[] name_att_info = new List<String>{ 'name' };
    private String[] validFrom_att_info = new List<String>{ 'validFrom' };
    private String[] limit_x_att_info = new List<String>{ 'limit' };
    private String[] eid_att_info = new List<String>{ 'eid' };
    private String[] allowanceType_att_info = new List<String>{
      'allowanceType'
    };
    private String[] usageUom_att_info = new List<String>{ 'usageUom' };
    private String[] rollOverType_att_info = new List<String>{ 'rollOverType' };
    private String[] ruleType_att_info = new List<String>{ 'ruleType' };
    private String[] proratedOnOrder_att_info = new List<String>{
      'proratedOnOrder'
    };
    private String[] proratedOnCancel_att_info = new List<String>{
      'proratedOnCancel'
    };

    public SoapApi33Domain.TableUsageRate tableUsageRate;
    public SoapApi33Domain.RateTable rateTable;
    public SoapApi33Domain.PassThroughUsageRate passThroughUsageRate;
    public SoapApi33Domain.RateTableEntries rateTableEntries;
    private String[] chargeCategory_type_info = new List<String>{
      'chargeCategory',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] flatUsageRate_type_info = new List<String>{
      'flatUsageRate',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] tableUsageRate_type_info = new List<String>{
      'tableUsageRate',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] rateTable_type_info = new List<String>{
      'rateTable',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] passThroughUsageRate_type_info = new List<String>{
      'passThroughUsageRate',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] rateTableEntries_type_info = new List<String>{
      'rateTableEntries',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'chargeCategory',
      'flatUsageRate',
      'tableUsageRate',
      'rateTable',
      'passThroughUsageRate',
      'rateTableEntries'
    };
  }
  public class OperationAttributes {
    public SoapApi33Domain.ProductSaleOperationAttribute[] productSaleOperationAttribute;
    private String[] productSaleOperationAttribute_type_info = new List<String>{
      'productSaleOperationAttribute',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'productSaleOperationAttribute'
    };
  }
  public class CustomFieldValue {
    public SoapApi33Domain.CustomField customField;
    public String value;
    public String eid;
    private String[] customField_type_info = new List<String>{
      'customField',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] value_att_info = new List<String>{ 'value' };
    private String[] eid_att_info = new List<String>{ 'eid' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'customField' };
  }
  public class ChangeService {
    public Long changedServiceOrderEid;
    private String[] changedServiceOrderEid_att_info = new List<String>{
      'changedServiceOrderEid'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class AgreementServices {
    public SoapApi33Domain.AgreementService[] agreementService;
    private String[] agreementService_type_info = new List<String>{
      'agreementService',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'agreementService'
    };
  }
  public class SalesOrder {
    /**
     * Tract: Copied from Order.
     */
    public SoapApi33Domain.OrderItems orderItems;
    public SoapApi33Domain.BillingAccount billingAccount;
    public SoapApi33Domain.Payments payments;
    public SoapApi33Domain.CustomFieldValues customFieldValues;
    public String orderNum;
    public String note;
    public String purchaseOrderNumber;
    public Boolean emailReceipt;
    public String referral;
    public String orderDate;
    public Decimal totalAmount;
    public String orderStatus;

    /* Tract Added */
    public String eid;
    public Decimal taxTotal;
    private String[] eid_att_info = new List<String>{ 'eid' };
    private String[] orderItems_type_info = new List<String>{
      'orderItems',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] billingAccount_type_info = new List<String>{
      'billingAccount',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] payments_type_info = new List<String>{
      'payments',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] customFieldValues_type_info = new List<String>{
      'customFieldValues',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] orderNum_att_info = new List<String>{ 'orderNum' };
    private String[] note_att_info = new List<String>{ 'note' };
    private String[] purchaseOrderNumber_att_info = new List<String>{
      'purchaseOrderNumber'
    };
    private String[] emailReceipt_att_info = new List<String>{ 'emailReceipt' };
    private String[] referral_att_info = new List<String>{ 'referral' };
    private String[] orderDate_att_info = new List<String>{ 'orderDate' };
    private String[] totalAmount_att_info = new List<String>{ 'totalAmount' };
    private String[] orderStatus_att_info = new List<String>{ 'orderStatus' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'orderItems',
      'billingAccount',
      'payments',
      'customFieldValues'
    };
    private String[] taxTotal_att_info = new List<String>{ 'taxTotal' };
    //private String[] apex_schema_type_info = new String[]{'http://www.tractbilling.com/billing/1_33/domain','true','false'};
    //private String[] field_order_type_info = new String[]{};
  }
  public class HttpRequestOperation {
    public String url;
    private String[] url_att_info = new List<String>{ 'url' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class UsageRules {
    public SoapApi33Domain.UsageRule[] usageRule;
    private String[] usageRule_type_info = new List<String>{
      'usageRule',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'usageRule' };
  }
  public class InvoiceAdjustmentApplications {
    public SoapApi33Domain.StandardInvoiceAdjustmentApplication[] standardInvoiceAdjustmentApplication;
    public SoapApi33Domain.ReversedInvoiceAdjustmentApplication[] reversedInvoiceAdjustmentApplication;
    public SoapApi33Domain.NegativeInvoiceAdjustmentApplication[] negativeInvoiceAdjustmentApplication;
    /* Added manually to get the details for pages */
    public Integer pageNumber;
    public Integer pageSize;
    public Long totalElements;
    public Integer elementCount;
    public Integer totalPages;
    private String[] pageNumber_att_info = new List<String>{ 'pageNumber' };
    private String[] pageSize_att_info = new List<String>{ 'pageSize' };
    private String[] totalElements_att_info = new List<String>{
      'totalElements'
    };
    private String[] elementCount_att_info = new List<String>{ 'elementCount' };
    private String[] totalPages_att_info = new List<String>{ 'totalPages' };

    private String[] standardInvoiceAdjustmentApplication_type_info = new List<String>{
      'standardInvoiceAdjustmentApplication',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] reversedInvoiceAdjustmentApplication_type_info = new List<String>{
      'reversedInvoiceAdjustmentApplication',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] negativeInvoiceAdjustmentApplication_type_info = new List<String>{
      'negativeInvoiceAdjustmentApplication',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'standardInvoiceAdjustmentApplication',
      'reversedInvoiceAdjustmentApplication',
      'negativeInvoiceAdjustmentApplication'
    };
  }
  public class PaymentTerm {
    public String eid;
    public String name;
    public Integer termDays;
    public Integer graceDays;
    private String[] name_att_info = new List<String>{ 'name' };
    private String[] eid_att_info = new List<String>{ 'eid' };
    private String[] termDays_att_info = new List<String>{ 'termDays' };
    private String[] graceDays_att_info = new List<String>{ 'graceDays' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class ScheduledCharge {
    public String eid;
    public String description;
    public Decimal amount;
    public Boolean invoiced;
    public String chargeDate;

    private String[] description_att_info = new List<String>{ 'description' };
    private String[] invoiced_att_info = new List<String>{ 'invoiced' };
    private String[] amount_att_info = new List<String>{ 'amount' };
    private String[] chargeDate_att_info = new List<String>{ 'chargeDate' };
    private String[] eid_att_info = new List<String>{ 'eid' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  //Manuallly added by Abhinav Bhatia from 1.30 version
  public class ServiceAdjustmentItem {
    public SoapApi33Domain.Service service;
    public SoapApi33Domain.Adjustment adjustment;
    public SoapApi33Domain.AdjustmentReason reason;
    public SoapApi33Domain.AdjustmentReason secondaryReason;
    public SoapApi33Domain.AdjustmentCategory category;
    public SOAPAPI33Domain.AdjustmentItemCharges charges;
    private String[] charges_type_info = new List<String>{
      'charges',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] adjustment_type_info = new List<String>{
      'adjustment',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] reason_type_info = new List<String>{
      'reason',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] secondaryReason_type_info = new List<String>{
      'secondaryReason',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] category_type_info = new List<String>{
      'category',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] service_type_info = new List<String>{
      'service',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'service',
      'adjustment',
      'reason',
      'secondaryReason',
      'category',
      'charges'
    };
  }

  public class GLAccountCategory {
    public SoapApi33Domain.AccountType accountType;
    public String name;
    public String description;
    public String status;
    private String[] accountType_type_info = new List<String>{
      'accountType',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] name_att_info = new List<String>{ 'name' };
    private String[] description_att_info = new List<String>{ 'description' };
    private String[] status_att_info = new List<String>{ 'status' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'accountType' };
  }
  public class BillCycle {
    public String eid;
    public String name;
    public DateTime startDate;
    public DateTime endDate;
    public String billCycleType;
    public Boolean autoBill;
    public Boolean usePaymentTerm;
    public String status;
    public String currencyType;
    private String[] eid_att_info = new List<String>{ 'eid' };
    private String[] name_att_info = new List<String>{ 'name' };
    private String[] startDate_att_info = new List<String>{ 'startDate' };
    private String[] endDate_att_info = new List<String>{ 'endDate' };
    private String[] billCycleType_att_info = new List<String>{
      'billCycleType'
    };
    private String[] autoBill_att_info = new List<String>{ 'autoBill' };
    private String[] usePaymentTerm_att_info = new List<String>{
      'usePaymentTerm'
    };
    private String[] status_att_info = new List<String>{ 'status' };
    private String[] currencyType_att_info = new List<String>{ 'currencyType' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class GlobalOrderItemUsageRule {
    public SoapApi33Domain.GlobalProductUsageRule globalProductUsageRule;
    public SoapApi33Domain.GlobalUsageRule globalUsageRule;

    public SoapApi33Domain.ChargeCategory chargeCategory;
    public SoapApi33Domain.PassThroughUsageRate passThroughUsageRate;

    public SoapApi33Domain.TableUsageRate tableUsageRate;
    public SoapApi33Domain.RateTable rateTable;

    public String name;
    public String eid;
    public String allowanceType;
    public String usageUom;
    public String status;
    public Double limit_x;

    public String rollOverType;
    public String ruleType;
    public Boolean proratedOnOrder;
    public Boolean proratedOnCancel;

    private String[] globalProductUsageRule_type_info = new List<String>{
      'globalProductUsageRule',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] globalUsageRule_type_info = new List<String>{
      'globalUsageRule',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] chargeCategory_type_info = new List<String>{
      'chargeCategory',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] passThroughUsageRate_type_info = new List<String>{
      'passThroughUsageRate',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] tableUsageRate_type_info = new List<String>{
      'tableUsageRate',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] rateTable_type_info = new List<String>{
      'rateTable',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };

    private String[] name_att_info = new List<String>{ 'name' };
    private String[] eid_att_info = new List<String>{ 'eid' };
    private String[] allowanceType_att_info = new List<String>{
      'allowanceType'
    };
    private String[] usageUom_att_info = new List<String>{ 'usageUom' };
    private String[] status_att_info = new List<String>{ 'status' };
    private String[] limit_x_att_info = new List<String>{ 'limit' };
    private String[] rollOverType_att_info = new List<String>{ 'rollOverType' };
    private String[] ruleType_att_info = new List<String>{ 'ruleType' };
    private String[] proratedOnOrder_att_info = new List<String>{
      'proratedOnOrder'
    };
    private String[] proratedOnCancel_att_info = new List<String>{
      'proratedOnCancel'
    };

    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'globalProductUsageRule',
      'globalUsageRule',
      'chargeCategory',
      'passThroughUsageRate',
      'tableUsageRate',
      'rateTable'
    };
  }
  public class RateTable {
    public SoapApi33Domain.RateTableEntries rateTableEntries;
    public String uom;
    public String name;
    public String status;
    public String description;
    public String eid;
    private String[] rateTableEntries_type_info = new List<String>{
      'rateTableEntries',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] uom_att_info = new List<String>{ 'uom' };
    private String[] name_att_info = new List<String>{ 'name' };
    private String[] status_att_info = new List<String>{ 'status' };
    private String[] description_att_info = new List<String>{ 'description' };
    private String[] eid_att_info = new List<String>{ 'eid' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'rateTableEntries'
    };
  }
  public class ServiceSuspensionReason {
    public String name;
    public String status;
    public String reasonType;
    public String eid;
    private String[] name_att_info = new List<String>{ 'name' };
    private String[] status_att_info = new List<String>{ 'status' };
    private String[] reasonType_att_info = new List<String>{ 'reasonType' };
    private String[] eid_att_info = new List<String>{ 'eid' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class ProductInvoiceItem {
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class RemoveServiceUsageRuleFromService {
    public SoapApi33Domain.MatchAllServiceUsageRule matchAllServiceUsageRule;
    public SoapApi33Domain.FormulaServiceUsageRule formulaServiceUsageRule;
    public SoapApi33Domain.GlobalServiceUsageRule globalServiceUsageRule;
    public SoapApi33Domain.Service service;
    private String[] matchAllServiceUsageRule_type_info = new List<String>{
      'matchAllServiceUsageRule',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] formulaServiceUsageRule_type_info = new List<String>{
      'formulaServiceUsageRule',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] globalServiceUsageRule_type_info = new List<String>{
      'globalServiceUsageRule',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] service_type_info = new List<String>{
      'service',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'matchAllServiceUsageRule',
      'formulaServiceUsageRule',
      'globalServiceUsageRule',
      'service'
    };
  }
  public class AdjustmentReason {
    public String name;
    public String description;
    public String status;
    public Boolean creditOnly;
    public String level;
    private String[] name_att_info = new List<String>{ 'name' };
    private String[] description_att_info = new List<String>{ 'description' };
    private String[] status_att_info = new List<String>{ 'status' };
    private String[] creditOnly_att_info = new List<String>{ 'creditOnly' };
    private String[] level_att_info = new List<String>{ 'level' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};

    public String eid;
    private String[] eid_att_info = new List<String>{ 'eid' };
  }
  public class AddDiscountIdentifierToDiscountCode {
    public SoapApi33Domain.DiscountIdentifier discountIdentifier;
    private String[] discountIdentifier_type_info = new List<String>{
      'discountIdentifier',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'discountIdentifier'
    };
  }
  public class GeneralLedgers {
    public SoapApi33Domain.GeneralLedger[] generalLedger;
    private String[] generalLedger_type_info = new List<String>{
      'generalLedger',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'generalLedger'
    };
  }
  public class UsageRuleCounter {
    public Decimal amount;
    public String uom;
    public Decimal threshold;
    private String[] amount_att_info = new List<String>{ 'amount' };
    private String[] uom_att_info = new List<String>{ 'uom' };
    private String[] threshold_att_info = new List<String>{ 'threshold' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class BillingAccountSegments {
    public SoapApi33Domain.BillingAccountSegment[] billingAccountSegment;
    private String[] billingAccountSegment_type_info = new List<String>{
      'billingAccountSegment',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'billingAccountSegment'
    };
  }
  //Manually added by Abhinav Bhatia from Api version 1.30
  public class RateTableEntry {
    public SoapApi33Domain.RateTable rateTable;
    public Decimal rate;
    public String lookup;
    public DateTime validFrom;
    public DateTime validTo;
    private String[] rateTable_type_info = new List<String>{
      'rateTable',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] rate_att_info = new List<String>{ 'rate' };
    private String[] lookup_att_info = new List<String>{ 'lookup' };
    private String[] validFrom_att_info = new List<String>{ 'validFrom' };
    private String[] validTo_att_info = new List<String>{ 'validTo' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'rateTable',
      'lookup',
      'validFrom',
      'validTo'
    };
  }
  public class EmailOperation {
    public String recipientEmail;
    public Boolean useDefaultEmail;
    public Boolean promptForEmail;
    private String[] recipientEmail_att_info = new List<String>{
      'recipientEmail'
    };
    private String[] useDefaultEmail_att_info = new List<String>{
      'useDefaultEmail'
    };
    private String[] promptForEmail_att_info = new List<String>{
      'promptForEmail'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class Action {
    public SoapApi33Domain.Operations operations;
    public String name;
    public Boolean enabled;
    public String friendlyName;
    public Boolean supportsApproval;
    private String[] operations_type_info = new List<String>{
      'operations',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] name_att_info = new List<String>{ 'name' };
    private String[] enabled_att_info = new List<String>{ 'enabled' };
    private String[] friendlyName_att_info = new List<String>{ 'friendlyName' };
    private String[] supportsApproval_att_info = new List<String>{
      'supportsApproval'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'operations' };
  }
  public class GLAccountingTransactions {
    public SoapApi33Domain.GLAccountingTransaction glAccountingTransaction;
    public SoapApi33Domain.GLAdjustmentAccountingTransaction glAdjustmentAccountingTransaction;
    public SoapApi33Domain.GLPaymentAccountingTransaction glPaymentAccountingTransaction;
    public SoapApi33Domain.GLInvoiceAccountingTransaction glInvoiceAccountingTransaction;
    private String[] glAccountingTransaction_type_info = new List<String>{
      'glAccountingTransaction',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] glAdjustmentAccountingTransaction_type_info = new List<String>{
      'glAdjustmentAccountingTransaction',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] glPaymentAccountingTransaction_type_info = new List<String>{
      'glPaymentAccountingTransaction',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] glInvoiceAccountingTransaction_type_info = new List<String>{
      'glInvoiceAccountingTransaction',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'glAccountingTransaction',
      'glAdjustmentAccountingTransaction',
      'glPaymentAccountingTransaction',
      'glInvoiceAccountingTransaction'
    };
  }
  public class DiscountCodeService {
    public SoapApi33Domain.Service service;
    public SoapApi33Domain.DiscountChargeCategory discountChargeCategory;
    public SoapApi33Domain.Discount discount;
    public SoapApi33Domain.DiscountCategory discountCategory;
    public SoapApi33Domain.DiscountCode discountCode;
    public SoapApi33Domain.DiscountIdentifier discountIdentifier;
    public Decimal percentage;
    public Decimal amount;
    public Datetime validFrom;
    public Datetime validTo;
    public Integer duration;

    private String[] validFrom_att_info = new List<String>{ 'validFrom' };
    private String[] validTo_att_info = new List<String>{ 'validTo' };
    private String[] duration_att_info = new List<String>{ 'duration' };
    private String[] service_type_info = new List<String>{
      'service',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] discountChargeCategory_type_info = new List<String>{
      'discountChargeCategory',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] discount_type_info = new List<String>{
      'discount',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] discountCategory_type_info = new List<String>{
      'discountCategory',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] discountCode_type_info = new List<String>{
      'discountCode',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] discountIdentifier_type_info = new List<String>{
      'discountIdentifier',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };

    private String[] percentage_att_info = new List<String>{ 'percentage' };
    private String[] amount_att_info = new List<String>{ 'amount' };

    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'service',
      'discountChargeCategory',
      'discount',
      'discountCategory',
      'discountCode',
      'discountIdentifier'
    };
  }
  public class BillingAccountCommand {
    public SoapApi33Domain.BillingAccount billingAccount;
    private String[] billingAccount_type_info = new List<String>{
      'billingAccount',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'billingAccount'
    };
  }
  public class ServiceAction {
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  //Manually added by Abhinav Bhatia from Api version 1.30 version
  public class AddEntryToRateTable {
    public SoapApi33Domain.RateTableEntry rateTableEntry;
    private String[] rateTableEntry_type_info = new List<String>{
      'rateTableEntry',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'rateTableEntry'
    };
  }
  public class ServiceDeviceInventoryItems {
    public SoapApi33Domain.ServiceDeviceInventoryItem[] serviceDeviceInventoryItem;
    private String[] serviceDeviceInventoryItem_type_info = new List<String>{
      'serviceDeviceInventoryItem',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'serviceDeviceInventoryItem'
    };
  }
  public class NameAddressPaymentMethod {
    public SoapApi33Domain.EmailAddress emailAddress;
    public SoapApi33Domain.PostalAddress postalAddress;
    public SoapApi33Domain.TelecomAddress telecomAddress;
    public String nickname;
    private String[] emailAddress_type_info = new List<String>{
      'emailAddress',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] postalAddress_type_info = new List<String>{
      'postalAddress',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] telecomAddress_type_info = new List<String>{
      'telecomAddress',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] nickname_att_info = new List<String>{ 'nickname' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'emailAddress',
      'postalAddress',
      'telecomAddress'
    };
  }
  public class ReversedInvoiceAdjustmentApplication {
    public SoapApi33Domain.StandardInvoiceAdjustmentApplication reversedApplication;
    private String[] reversedApplication_type_info = new List<String>{
      'reversedApplication',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'reversedApplication'
    };
  }
  public class YearlyBillCycle {
    public SoapApi33Domain.BillingAccountCategory billingAccountCategory;
    private String[] billingAccountCategory_type_info = new List<String>{
      'billingAccountCategory',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    public Integer dayOfYear;
    private String[] dayOfYear_att_info = new List<String>{ 'dayOfYear' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'billingAccountCategory'
    };

    /* @Jrathore - From line below to next blank line copied
     *  from BillCycle Apex Class generated above to process
     *  response received from Tract.
     */
    public String eid;
    public String name;
    public DateTime startDate;
    public DateTime endDate;
    public String billCycleType;
    public Boolean autoBill;
    public Boolean usePaymentTerm;
    public String status;
    public String currencyType;
    private String[] eid_att_info = new List<String>{ 'eid' };
    private String[] name_att_info = new List<String>{ 'name' };
    private String[] startDate_att_info = new List<String>{ 'startDate' };
    private String[] endDate_att_info = new List<String>{ 'endDate' };
    private String[] billCycleType_att_info = new List<String>{
      'billCycleType'
    };
    private String[] autoBill_att_info = new List<String>{ 'autoBill' };
    private String[] usePaymentTerm_att_info = new List<String>{
      'usePaymentTerm'
    };
    private String[] status_att_info = new List<String>{ 'status' };
    private String[] currencyType_att_info = new List<String>{ 'currencyType' };
    //private String[] apex_schema_type_info = new String[]{'http://www.tractbilling.com/billing/1_33/domain','true','false'};
    //private String[] field_order_type_info = new String[]{};
  }
  public class CommandResponse {
    public SoapApi33Domain.Referrer generatedReferrerToken;
    public SoapApi33Domain.ChangeService changeService;
    public SoapApi33Domain.ApplyPaymentResponse applyPaymentResponse;
    public SoapApi33Domain.ApplyRefundResponse applyRefundResponse;
    public SoapApi33Domain.RequestedServiceResource requestedServiceResource;
    public SoapApi33Domain.RenewServiceResponse renewService;
    public SoapApi33Domain.OrderCommandResponse orderResponse;
    public SoapApi33Domain.AddResponse addResponse;
    public Boolean successful;

    public SoapApi33Domain.CompatibleForChangeServiceResponse compatibleForChangeServiceResponse;
    private String[] compatibleForChangeServiceResponse_type_info = new List<String>{
      'compatibleForChangeServiceResponse',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };

    private String[] generatedReferrerToken_type_info = new List<String>{
      'generatedReferrerToken',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] changeService_type_info = new List<String>{
      'changeService',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] applyPaymentResponse_type_info = new List<String>{
      'applyPaymentResponse',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] applyRefundResponse_type_info = new List<String>{
      'applyRefundResponse',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] requestedServiceResource_type_info = new List<String>{
      'requestedServiceResource',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] renewService_type_info = new List<String>{
      'renewService',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] orderResponse_type_info = new List<String>{
      'orderResponse',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] addResponse_type_info = new List<String>{
      'addResponse',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] successful_att_info = new List<String>{ 'successful' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'generatedReferrerToken',
      'changeService',
      'applyPaymentResponse',
      'applyRefundResponse',
      'requestedServiceResource',
      'renewService',
      'orderResponse',
      'addResponse',
      'compatibleForChangeServiceResponse'
    };
  }
  public class DiscountIdentifiers {
    public SoapApi33Domain.DiscountIdentifier[] discountIdentifier;
    private String[] discountIdentifier_type_info = new List<String>{
      'discountIdentifier',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'discountIdentifier'
    };
  }
  public class UsageLookupTableEntry {
    public String key;
    public String value;
    private String[] key_att_info = new List<String>{ 'key' };
    private String[] value_att_info = new List<String>{ 'value' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class OrderCommand {
    public SoapApi33Domain.SalesOrder salesOrder;
    public SoapApi33Domain.RenewalOrder renewalOrder;
    private String[] salesOrder_type_info = new List<String>{
      'salesOrder',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] renewalOrder_type_info = new List<String>{
      'renewalOrder',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'salesOrder',
      'renewalOrder'
    };
  }
  public class ServiceCommand {
    public SoapApi33Domain.Service service;
    private String[] service_type_info = new List<String>{
      'service',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'service' };
  }
  public class Discounts {
    public SoapApi33Domain.Discount[] discount;
    private String[] discount_type_info = new List<String>{
      'discount',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'discount' };
  }
  public class UpdateOpenCounters {
    public SoapApi33Domain.UsageRuleCounter usageRuleCounter;
    public SoapApi33Domain.UsageEventCounter usageEventCounter;
    public SoapApi33Domain.UsageChargeCounter usageChargeCounter;
    private String[] usageRuleCounter_type_info = new List<String>{
      'usageRuleCounter',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] usageEventCounter_type_info = new List<String>{
      'usageEventCounter',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] usageChargeCounter_type_info = new List<String>{
      'usageChargeCounter',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'usageRuleCounter',
      'usageEventCounter',
      'usageChargeCounter'
    };
  }
  public class AdditionalFeeInvoiceItem {
    public SoapApi33Domain.Service service;
    private String[] service_type_info = new List<String>{
      'service',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'service' };
  }
  public class CheckPaymentMethod {
    public String checkNumber;
    public String routingNumber;
    public String accountNumber;
    public String customerName;
    public String description;
    public SoapApi33Domain.CustomFieldValues customFieldValues;
    private String[] customFieldValues_type_info = new List<String>{
      'customFieldValues',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] checkNumber_att_info = new List<String>{ 'checkNumber' };
    private String[] routingNumber_att_info = new List<String>{
      'routingNumber'
    };
    private String[] accountNumber_att_info = new List<String>{
      'accountNumber'
    };
    private String[] customerName_att_info = new List<String>{ 'customerName' };
    private String[] description_att_info = new List<String>{ 'description' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'customFieldValues'
    };
  }
  public class RemoveParentBillingAccount {
    public SoapApi33Domain.BillingAccount parentBillingAccount;
    public DateTime validTo;
    private String[] parentBillingAccount_type_info = new List<String>{
      'parentBillingAccount',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] validTo_att_info = new List<String>{ 'validTo' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'parentBillingAccount'
    };
  }
  //Added manually from 1.30 version by Abhinav Bhatia
  public class CustomFieldValueReferences {
    public SoapApi33Domain.CustomFieldValueReference[] customFieldValueReference;
    private String[] customFieldValueReference_type_info = new List<String>{
      'customFieldValueReference',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'customFieldValueReference'
    };
  }
  public class GlobalUsageRules {
    public SoapApi33Domain.GlobalUsageRule[] globalUsageRule;
    private String[] globalUsageRule_type_info = new List<String>{
      'globalUsageRule',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'globalUsageRule'
    };
  }
  public class FlatUsageRate {
    public Decimal rate;
    public String uom;
    private String[] rate_att_info = new List<String>{ 'rate' };
    private String[] uom_att_info = new List<String>{ 'uom' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class UsageRuleTemplate {
    public SoapApi33Domain.UsagePriceCategory chargeCategory;
    public SoapApi33Domain.FlatUsageRate flatUsageRate;
    public SoapApi33Domain.TableUsageRate tableUsageRate;
    public SoapApi33Domain.PassThroughUsageRate passThroughUsageRate;
    public Decimal limit_x;
    public String usageUom;
    public String name;
    public Integer order;
    public Boolean proratedOnOrder;
    public Boolean proratedOnCancel;
    public String rollOverType;
    public String allowanceType;
    public DateTime validFrom;
    public DateTime validTo;
    public String ruleType;
    private String[] chargeCategory_type_info = new List<String>{
      'chargeCategory',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] flatUsageRate_type_info = new List<String>{
      'flatUsageRate',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] tableUsageRate_type_info = new List<String>{
      'tableUsageRate',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] passThroughUsageRate_type_info = new List<String>{
      'passThroughUsageRate',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] limit_x_att_info = new List<String>{ 'limit' };
    private String[] usageUom_att_info = new List<String>{ 'usageUom' };
    private String[] name_att_info = new List<String>{ 'name' };
    private String[] order_att_info = new List<String>{ 'order' };
    private String[] proratedOnOrder_att_info = new List<String>{
      'proratedOnOrder'
    };
    private String[] proratedOnCancel_att_info = new List<String>{
      'proratedOnCancel'
    };
    private String[] rollOverType_att_info = new List<String>{ 'rollOverType' };
    private String[] allowanceType_att_info = new List<String>{
      'allowanceType'
    };
    private String[] validFrom_att_info = new List<String>{ 'validFrom' };
    private String[] validTo_att_info = new List<String>{ 'validTo' };
    private String[] ruleType_att_info = new List<String>{ 'ruleType' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'chargeCategory',
      'flatUsageRate',
      'tableUsageRate',
      'passThroughUsageRate'
    };
  }
  public class AddAddressToService {
    public SoapApi33Domain.PostalAddress postalAddress;
    public SoapApi33Domain.Service service;
    private String[] postalAddress_type_info = new List<String>{
      'postalAddress',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] service_type_info = new List<String>{
      'service',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'postalAddress',
      'service'
    };
  }
  public class DeactivateServiceResource {
    public SoapApi33Domain.ServiceResource serviceResource;
    private String[] serviceResource_type_info = new List<String>{
      'serviceResource',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'serviceResource'
    };
  }
  public class ServiceResourceCommand {
    public SoapApi33Domain.ServiceResource serviceResource;
    private String[] serviceResource_type_info = new List<String>{
      'serviceResource',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'serviceResource'
    };
  }
  public class BaseTractObject {
    public String queryScope;
    private String[] queryScope_att_info = new List<String>{ 'queryScope' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class UsageRule {
    public Decimal limit_x;
    public Decimal remaining;
    public Decimal used;
    public Decimal rollover;
    public Decimal currentAllowance;
    public String serviceName;
    public String usageRuleName;
    private String[] limit_x_att_info = new List<String>{ 'limit' };
    private String[] remaining_att_info = new List<String>{ 'remaining' };
    private String[] used_att_info = new List<String>{ 'used' };
    private String[] rollover_att_info = new List<String>{ 'rollover' };
    private String[] currentAllowance_att_info = new List<String>{
      'currentAllowance'
    };
    private String[] serviceName_att_info = new List<String>{ 'serviceName' };
    private String[] usageRuleName_att_info = new List<String>{
      'usageRuleName'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  //Manually added by Abhinav Bhatia from 1.30 version
  public class TaxPriceCategory {
    public String taxTypeCode;
    public String jurisdictionType;
    public String jurisdictionCode;
    private String[] taxTypeCode_att_info = new List<String>{ 'taxTypeCode' };
    private String[] jurisdictionType_att_info = new List<String>{
      'jurisdictionType'
    };
    private String[] jurisdictionCode_att_info = new List<String>{
      'jurisdictionCode'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class ApplyPayment {
    public SoapApi33Domain.Payment payment;
    public SoapApi33Domain.invoices_element invoices;
    private String[] payment_type_info = new List<String>{
      'payment',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] invoices_type_info = new List<String>{
      'invoices',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'payment',
      'invoices'
    };
  }
  public class BillingAccounts {
    public SoapApi33Domain.BillingAccount[] billingAccount;
    private String[] billingAccount_type_info = new List<String>{
      'billingAccount',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'billingAccount'
    };
  }
  public class WireTransferPaymentMethod {
    public String reference;
    public SoapApi33Domain.CustomFieldValues customFieldValues;
    private String[] customFieldValues_type_info = new List<String>{
      'customFieldValues',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] reference_att_info = new List<String>{ 'reference' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'customFieldValues'
    };
  }
  public class RemoveCustomFieldValueFromOrder {
    public SoapApi33Domain.CustomFieldValue customFieldValue;
    private String[] customFieldValue_type_info = new List<String>{
      'customFieldValue',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'customFieldValue'
    };
  }
  public class AdjustmentReasons {
    public SoapApi33Domain.AdjustmentReason[] adjustmentReason;
    private String[] adjustmentReason_type_info = new List<String>{
      'adjustmentReason',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'adjustmentReason'
    };
  }
  public class TableUsageRate {
    public SoapApi33Domain.RateTable rateTable;
    public String usageFieldName;
    public String uom;
    private String[] rateTable_type_info = new List<String>{
      'rateTable',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] usageFieldName_att_info = new List<String>{
      'usageFieldName'
    };
    private String[] uom_att_info = new List<String>{ 'uom' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'rateTable' };
  }
  public class AddAgreementToService {
    public SoapApi33Domain.AgreementService agreementService;
    private String[] agreementService_type_info = new List<String>{
      'agreementService',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'agreementService'
    };
  }
  public class PassThroughUsageRate {
    public String usageFieldName;
    private String[] usageFieldName_att_info = new List<String>{
      'usageFieldName'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class requests_element {
    public SoapApi33Domain.CreateRequest create;
    public SoapApi33Domain.UpdateRequest update_x;
    public SoapApi33Domain.CommandRequest[] command;
    public SoapApi33Domain.AuthorizationRequest authorization;
    private String[] create_type_info = new List<String>{
      'create',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] update_x_type_info = new List<String>{
      'update',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] command_type_info = new List<String>{
      'command',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] authorization_type_info = new List<String>{
      'authorization',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'create',
      'update_x',
      'command',
      'authorization'
    };
  }
  public class RemoveDiscountIdentifierFromDiscountCode {
    public SoapApi33Domain.DiscountIdentifier discountIdentifier;
    private String[] discountIdentifier_type_info = new List<String>{
      'discountIdentifier',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'discountIdentifier'
    };
  }
  public class Refund {
    public SoapApi33Domain.RefundReason paymentChangeReason;
    public SoapApi33Domain.Payment originalPayment;
    private String[] paymentChangeReason_type_info = new List<String>{
      'paymentChangeReason',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] originalPayment_type_info = new List<String>{
      'originalPayment',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'paymentChangeReason',
      'originalPayment'
    };
  }
  public class AddDiscountIdentifierToService {
    public SoapApi33Domain.DiscountIdentifier discountIdentifier;
    public Decimal overrideAmount;
    public Decimal overridePercentage;
    public Integer overrideDuration;
    private String[] discountIdentifier_type_info = new List<String>{
      'discountIdentifier',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] overrideAmount_att_info = new List<String>{
      'overrideAmount'
    };
    private String[] overridePercentage_att_info = new List<String>{
      'overridePercentage'
    };
    private String[] overrideDuration_att_info = new List<String>{
      'overrideDuration'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'discountIdentifier'
    };
  }
  public class NegativeInvoiceAdjustmentApplication {
    public SoapApi33Domain.Adjustment accountAdjustment;
    public SoapApi33Domain.Invoice invoice;
    private String[] invoice_type_info = new List<String>{
      'invoice',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] accountAdjustment_type_info = new List<String>{
      'accountAdjustment',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'accountAdjustment',
      'invoice'
    };
  }
  //Manually added by Abhinav Bhatia from 1.30 version
  public class PriceCategories {
    public SoapApi33Domain.PriceCategory[] priceCategory;
    private String[] priceCategory_type_info = new List<String>{
      'priceCategory',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'priceCategory'
    };
  }
  public class SuspendBillingAccount {
    public SoapApi33Domain.SuspensionReason reason;
    public DateTime startDate;
    public SoapApi33Domain.BillingAccount billingAccount;
    private String[] reason_type_info = new List<String>{
      'reason',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] billingAccount_type_info = new List<String>{
      'billingAccount',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] startDate_att_info = new List<String>{ 'startDate' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'reason',
      'billingAccount'
    };
  }
  public class PaymentApplications {
    public SoapApi33Domain.StandardInvoicePaymentApplication[] standardInvoicePaymentApplication;
    public SoapApi33Domain.ReversedInvoicePaymentApplication[] reversedInvoicePaymentApplication;
    public Integer totalPages;
    private String[] totalPages_att_info = new List<String>{ 'totalPages' };
    private String[] standardInvoicePaymentApplication_type_info = new List<String>{
      'standardInvoicePaymentApplication',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] reversedInvoicePaymentApplication_type_info = new List<String>{
      'reversedInvoicePaymentApplication',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'standardInvoicePaymentApplication',
      'reversedInvoicePaymentApplication'
    };
  }
  public class PayByPayPalPaymentMethod {
    public String reference;
    private String[] reference_att_info = new List<String>{ 'reference' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class CustomPaymentMethod {
    public String eid;
    public String reference;
    public SoapApi33Domain.CustomFieldValues customFieldValues;
    private String[] eid_att_info = new List<String>{ 'eid' };
    private String[] reference_att_info = new List<String>{ 'reference' };
    private String[] customFieldValues_type_info = new List<String>{
      'customFieldValues',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'eid' };
  }
  public class RequestedServiceResource {
    public Long requestedServiceResourceEid;
    private String[] requestedServiceResourceEid_att_info = new List<String>{
      'requestedServiceResourceEid'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class ServiceQuery {
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class InvoiceItemCharges {
    public SoapApi33Domain.InvoiceItemCharge[] invoiceItemCharge;
    private String[] invoiceItemCharge_type_info = new List<String>{
      'invoiceItemCharge',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'invoiceItemCharge'
    };
  }
  public class Promotion {
    public String name;
    public String type_x;
    public String code;
    public String description;
    public Date fromDate;
    public Date thruDate;
    public Decimal amount;
    public Integer ttlDays;
    public Boolean percentage;
    public Boolean auto;
    public String status;
    private String[] name_att_info = new List<String>{ 'name' };
    private String[] type_x_att_info = new List<String>{ 'type' };
    private String[] code_att_info = new List<String>{ 'code' };
    private String[] description_att_info = new List<String>{ 'description' };
    private String[] fromDate_att_info = new List<String>{ 'fromDate' };
    private String[] thruDate_att_info = new List<String>{ 'thruDate' };
    private String[] amount_att_info = new List<String>{ 'amount' };
    private String[] ttlDays_att_info = new List<String>{ 'ttlDays' };
    private String[] percentage_att_info = new List<String>{ 'percentage' };
    private String[] auto_att_info = new List<String>{ 'auto' };
    private String[] status_att_info = new List<String>{ 'status' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class GenerateReferrerToken {
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class RequestServiceResource {
    public SoapApi33Domain.ServiceResourceCategory serviceResourceCategory;
    private String[] serviceResourceCategory_type_info = new List<String>{
      'serviceResourceCategory',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'serviceResourceCategory'
    };
  }
  public class GLPaymentAccountingTransaction {
    public SoapApi33Domain.Payment payment;
    private String[] payment_type_info = new List<String>{
      'payment',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'payment' };
  }
  public class ApplyRefund {
    public SoapApi33Domain.Payment payment;
    public SoapApi33Domain.Refund refund;
    private String[] payment_type_info = new List<String>{
      'payment',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] refund_type_info = new List<String>{
      'refund',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'payment',
      'refund'
    };
  }
  public class invoices_element {
    public SoapApi33Domain.Invoice[] invoice;
    private String[] invoice_type_info = new List<String>{
      'invoice',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'invoice' };
  }
  public class addresses_element {
    /*public SoapApi33Domain.PostalAddress[] postalAddress;
        private String[] postalAddress_type_info = new String[]{'postalAddress','http://www.tractbilling.com/billing/1_33/domain',null,'0','-1','false'};
        private String[] apex_schema_type_info = new String[]{'http://www.tractbilling.com/billing/1_33/domain','true','false'};
        private String[] field_order_type_info = new String[]{'postalAddress'};*/

    public SoapApi33Domain.EmailAddress[] emailAddress;
    public SoapApi33Domain.PostalAddress[] postalAddress;
    public SoapApi33Domain.TelecomAddress[] telecomAddress;
    private String[] emailAddress_type_info = new List<String>{
      'emailAddress',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] postalAddress_type_info = new List<String>{
      'postalAddress',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] telecomAddress_type_info = new List<String>{
      'telecomAddress',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'emailAddress',
      'postalAddress',
      'telecomAddress'
    };
  }
  public class ServiceUsageRule {
    public SoapApi33Domain.MatchAllOrderItemUsageRule matchAllOrderItemUsageRule;
    public SoapApi33Domain.FormulaOrderItemUsageRule formulaOrderItemUsageRule;
    public SoapApi33Domain.GlobalOrderItemUsageRule globalOrderItemUsageRule;
    public String status;
    private String[] matchAllOrderItemUsageRule_type_info = new List<String>{
      'matchAllOrderItemUsageRule',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] formulaOrderItemUsageRule_type_info = new List<String>{
      'formulaOrderItemUsageRule',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] globalOrderItemUsageRule_type_info = new List<String>{
      'globalOrderItemUsageRule',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] status_att_info = new List<String>{ 'status' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'matchAllOrderItemUsageRule',
      'formulaOrderItemUsageRule',
      'globalOrderItemUsageRule'
    };
  }
  public class GLAccountingTransaction {
    public SoapApi33Domain.GLAccountingEntries glAccountingEntries;
    public DateTime occurredOn;
    public DateTime postedOn;
    public String type_x;
    public Decimal amount;
    public String currencyType;
    public Decimal originalAmount;
    public String originalCurrencyType;
    private String[] glAccountingEntries_type_info = new List<String>{
      'glAccountingEntries',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] occurredOn_att_info = new List<String>{ 'occurredOn' };
    private String[] postedOn_att_info = new List<String>{ 'postedOn' };
    private String[] type_x_att_info = new List<String>{ 'type' };
    private String[] amount_att_info = new List<String>{ 'amount' };
    private String[] currencyType_att_info = new List<String>{ 'currencyType' };
    private String[] originalAmount_att_info = new List<String>{
      'originalAmount'
    };
    private String[] originalCurrencyType_att_info = new List<String>{
      'originalCurrencyType'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'glAccountingEntries'
    };
  }
  public class AgreementQuery {
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class ChangeServiceScheduledOneTimePriceCharges {
    public SoapApi33Domain.scheduledOneTimePriceCharges_element scheduledOneTimePriceCharges;
    private String[] scheduledOneTimePriceCharges_type_info = new List<String>{
      'scheduledOneTimePriceCharges',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'scheduledOneTimePriceCharges'
    };
  }
  public class NegativeInvoiceAdjustmentApplications {
    public SoapApi33Domain.NegativeInvoiceAdjustmentApplication[] negativeInvoiceAdjustmentApplication;
    private String[] negativeInvoiceAdjustmentApplication_type_info = new List<String>{
      'negativeInvoiceAdjustmentApplication',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'negativeInvoiceAdjustmentApplication'
    };
  }
  public class ProductSaleAction {
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  /*public class BillingAccountCategory {
        public SoapApi33Domain.PaymentTerm paymentTerm;
        public String type_x;
        public String description;
        public String status;
        private String[] paymentTerm_type_info = new String[]{'paymentTerm','http://www.tractbilling.com/billing/1_33/domain',null,'0','1','false'};
        private String[] type_x_att_info = new String[]{'type'};
        private String[] description_att_info = new String[]{'description'};
        private String[] status_att_info = new String[]{'status'};
        private String[] apex_schema_type_info = new String[]{'http://www.tractbilling.com/billing/1_33/domain','true','false'};
        private String[] field_order_type_info = new String[]{'paymentTerm'};
    }*/
  public class BillingAccountCategory {
    public String eid;
    public SoapApi33Domain.PaymentTerm paymentTerm;
    public String type_x;
    public String description;
    public String status;
    public Integer autoPayOffset;
    private String[] eid_att_info = new List<String>{ 'eid' };
    private String[] paymentTerm_type_info = new List<String>{
      'paymentTerm',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] type_x_att_info = new List<String>{ 'type' };
    private String[] description_att_info = new List<String>{ 'description' };
    private String[] status_att_info = new List<String>{ 'status' };
    private String[] autoPayOffset_att_info = new List<String>{
      'autoPayOffset'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'paymentTerm' };
  }
  public class GLAdjustmentAccountingTransaction {
    public SoapApi33Domain.Adjustment accountAdjustment;
    private String[] accountAdjustment_type_info = new List<String>{
      'accountAdjustment',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'accountAdjustment'
    };
  }
  public class GLAccounts {
    public SoapApi33Domain.GLAccount[] glAccount;
    private String[] glAccount_type_info = new List<String>{
      'glAccount',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'glAccount' };
  }
  public class DenyAction {
    public SoapApi33Domain.SalesOrder order;
    public Long sequence;
    private String[] order_type_info = new List<String>{
      'order',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] sequence_att_info = new List<String>{ 'sequence' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'order' };
  }
  public class BillingAccountCategories {
    public SoapApi33Domain.BillingAccountCategory[] billingAccountCategory;
    public Integer totalPages;
    private String[] totalPages_att_info = new List<String>{ 'totalPages' };
    private String[] billingAccountCategory_type_info = new List<String>{
      'billingAccountCategory',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'billingAccountCategory'
    };
  }
  public class Discount {
    public SoapApi33Domain.DiscountCategory discountCategory;
    public String name;
    public String status;
    public String description;
    public String type_x;
    public Decimal amount;
    public String currencyType;
    public Decimal percentage;
    public Integer duration;
    public Boolean oneTime;
    public Boolean recurring;
    public Boolean amountOverride;
    public Boolean durationOverride;
    private String[] discountCategory_type_info = new List<String>{
      'discountCategory',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] name_att_info = new List<String>{ 'name' };
    private String[] status_att_info = new List<String>{ 'status' };
    private String[] description_att_info = new List<String>{ 'description' };
    private String[] type_x_att_info = new List<String>{ 'type' };
    private String[] amount_att_info = new List<String>{ 'amount' };
    private String[] currencyType_att_info = new List<String>{ 'currencyType' };
    private String[] percentage_att_info = new List<String>{ 'percentage' };
    private String[] duration_att_info = new List<String>{ 'duration' };
    private String[] oneTime_att_info = new List<String>{ 'oneTime' };
    private String[] recurring_att_info = new List<String>{ 'recurring' };
    private String[] amountOverride_att_info = new List<String>{
      'amountOverride'
    };
    private String[] durationOverride_att_info = new List<String>{
      'durationOverride'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'discountCategory'
    };
  }
  public class ServiceInvoiceItem {
    public SoapApi33Domain.Service service;
    public SoapApi33Domain.InvoiceItemCharges invoiceItemCharges;
    public Decimal quantity;
    public Decimal unitAmount;
    public Decimal totalAmount;
    public String description;
    public Boolean taxable;
    public Decimal proratedPercentage;
    public DateTime chargeStartDate;
    public DateTime chargeEndDate;
    public String lineItemType;
    private String[] service_type_info = new List<String>{
      'service',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] quantity_att_info = new List<String>{ 'quantity' };
    private String[] unitAmount_att_info = new List<String>{ 'unitAmount' };
    private String[] totalAmount_att_info = new List<String>{ 'totalAmount' };
    private String[] description_att_info = new List<String>{ 'description' };
    private String[] taxable_att_info = new List<String>{ 'taxable' };
    private String[] proratedPercentage_att_info = new List<String>{
      'proratedPercentage'
    };
    private String[] chargeStartDate_att_info = new List<String>{
      'chargeStartDate'
    };
    private String[] chargeEndDate_att_info = new List<String>{
      'chargeEndDate'
    };
    private String[] lineItemType_att_info = new List<String>{ 'lineItemType' };
    private String[] invoiceItemCharges_type_info = new List<String>{
      'invoiceItemCharges',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'service',
      'invoiceItemCharges'
    };
  }
  public class ManualInvoiceItem {
    public SoapApi33Domain.Service service;
    public SoapApi33Domain.InvoiceItemCharges invoiceItemCharges;
    public SoapApi33Domain.InvoiceItem previousItem;
    public Decimal quantity;
    public Decimal unitAmount;
    public Decimal totalAmount;
    public String description;
    public Boolean taxable;
    public Decimal proratedPercentage;
    public DateTime chargeStartDate;
    public DateTime chargeEndDate;
    public String lineItemType;
    private String[] service_type_info = new List<String>{
      'service',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] invoiceItemCharges_type_info = new List<String>{
      'invoiceItemCharges',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] previousItem_type_info = new List<String>{
      'previousItem',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] quantity_att_info = new List<String>{ 'quantity' };
    private String[] unitAmount_att_info = new List<String>{ 'unitAmount' };
    private String[] totalAmount_att_info = new List<String>{ 'totalAmount' };
    private String[] description_att_info = new List<String>{ 'description' };
    private String[] taxable_att_info = new List<String>{ 'taxable' };
    private String[] proratedPercentage_att_info = new List<String>{
      'proratedPercentage'
    };
    private String[] chargeStartDate_att_info = new List<String>{
      'chargeStartDate'
    };
    private String[] chargeEndDate_att_info = new List<String>{
      'chargeEndDate'
    };
    private String[] lineItemType_att_info = new List<String>{ 'lineItemType' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'service',
      'invoiceItemCharges',
      'previousItem'
    };
  }
  public class ManualServiceInvoiceItem {
    public SoapApi33Domain.Service service;
    public SoapApi33Domain.InvoiceItemCharges invoiceItemCharges;
    public SoapApi33Domain.InvoiceItem previousItem;
    public String eid;
    public Decimal quantity;
    public Decimal unitAmount;
    public Decimal totalAmount;
    public String description;
    public Boolean taxable;
    public Decimal proratedPercentage;
    public DateTime chargeStartDate;
    public DateTime chargeEndDate;
    public String lineItemType;
    private String[] eid_att_info = new List<String>{ 'eid' };
    private String[] service_type_info = new List<String>{
      'service',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] previousItem_type_info = new List<String>{
      'previousItem',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] quantity_att_info = new List<String>{ 'quantity' };
    private String[] unitAmount_att_info = new List<String>{ 'unitAmount' };
    private String[] totalAmount_att_info = new List<String>{ 'totalAmount' };
    private String[] description_att_info = new List<String>{ 'description' };
    private String[] taxable_att_info = new List<String>{ 'taxable' };
    private String[] proratedPercentage_att_info = new List<String>{
      'proratedPercentage'
    };
    private String[] chargeStartDate_att_info = new List<String>{
      'chargeStartDate'
    };
    private String[] chargeEndDate_att_info = new List<String>{
      'chargeEndDate'
    };
    private String[] lineItemType_att_info = new List<String>{ 'lineItemType' };
    private String[] invoiceItemCharges_type_info = new List<String>{
      'invoiceItemCharges',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'service',
      'invoiceItemCharges',
      'previousItem'
    };
  }
  public class ApplyRefundResponse {
    public SoapApi33Domain.Refund refund;
    private String[] refund_type_info = new List<String>{
      'refund',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'refund' };
  }
  public class GlobalUsageRule {
    public String name;
    public String status;
    public String eid;
    private String[] name_att_info = new List<String>{ 'name' };
    private String[] status_att_info = new List<String>{ 'status' };
    private String[] eid_att_info = new List<String>{ 'eid' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class VoidDraftOrder {
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  /*public class CustomField {
        public String customFieldType;
        public String name;
        public String description;
        public Boolean enabled;
        public Boolean searchable;
        public String fieldType;
        private String[] customFieldType_att_info = new String[]{'customFieldType'};
        private String[] name_att_info = new String[]{'name'};
        private String[] description_att_info = new String[]{'description'};
        private String[] enabled_att_info = new String[]{'enabled'};
        private String[] searchable_att_info = new String[]{'searchable'};
        private String[] fieldType_att_info = new String[]{'fieldType'};
        private String[] apex_schema_type_info = new String[]{'http://www.tractbilling.com/billing/1_33/domain','true','false'};
        private String[] field_order_type_info = new String[]{};
    }*/
  public class CustomField {
    //Added manually from 1.30 version by Abhinav Bhatia
    public SoapApi33Domain.CustomFieldValueReferences customFieldValueReferences;

    public String customFieldType;
    public String name;
    public String description;
    public Boolean enabled;
    public Boolean searchable;
    public String fieldType;
    public String eid;
    //Added manually from 1.30 version by Abhinav Bhatia
    public String fieldValidationType;
    public String regex;

    private String[] customFieldValueReferences_type_info = new List<String>{
      'customFieldValueReferences',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] customFieldType_att_info = new List<String>{
      'customFieldType'
    };
    private String[] name_att_info = new List<String>{ 'name' };
    private String[] description_att_info = new List<String>{ 'description' };
    private String[] enabled_att_info = new List<String>{ 'enabled' };
    private String[] searchable_att_info = new List<String>{ 'searchable' };
    private String[] fieldType_att_info = new List<String>{ 'fieldType' };
    private String[] eid_att_info = new List<String>{ 'eid' };
    private String[] fieldValidationType_att_info = new List<String>{
      'fieldValidationType'
    };
    private String[] regex_att_info = new List<String>{ 'regex' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'customFieldValueReferences'
    };
  }
  public class CustomFields {
    public SoapApi33Domain.CustomField[] customField;
    public Integer totalPages;
    private String[] totalPages_att_info = new List<String>{ 'totalPages' };
    private String[] customField_type_info = new List<String>{
      'customField',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'customField' };
  }
  public class DiscountCodeServices {
    public SoapApi33Domain.DiscountCodeService[] discountCodeService;
    private String[] discountCodeService_type_info = new List<String>{
      'discountCodeService',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'discountCodeService'
    };
  }
  public class AddCustomFieldValueToOrder {
    public SoapApi33Domain.CustomFieldValue customFieldValue;
    private String[] customFieldValue_type_info = new List<String>{
      'customFieldValue',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'customFieldValue'
    };
  }
  public class TractObject {
    public Long eid;
    private String[] eid_att_info = new List<String>{ 'eid' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class ParameterAndValue {
    public String parameter;
    public String parameterValue;
    public String operator;
    private String[] parameter_att_info = new List<String>{ 'parameter' };
    private String[] parameterValue_att_info = new List<String>{
      'parameterValue'
    };
    private String[] operator_att_info = new List<String>{ 'operator' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class Counter {
    public SoapApi33Domain.ServicePeriodCounterResetCriteria servicePeriodCounterResetCriteria;
    public SoapApi33Domain.AgreementCounterResetCriteria agreementCounterResetCriteria;
    public String name;
    public String description;
    public DateTime fromDate;
    public DateTime thruDate;
    public String status;
    public String type_x;
    public String entityRelationtype;
    private String[] servicePeriodCounterResetCriteria_type_info = new List<String>{
      'servicePeriodCounterResetCriteria',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] agreementCounterResetCriteria_type_info = new List<String>{
      'agreementCounterResetCriteria',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] name_att_info = new List<String>{ 'name' };
    private String[] description_att_info = new List<String>{ 'description' };
    private String[] fromDate_att_info = new List<String>{ 'fromDate' };
    private String[] thruDate_att_info = new List<String>{ 'thruDate' };
    private String[] status_att_info = new List<String>{ 'status' };
    private String[] type_x_att_info = new List<String>{ 'type' };
    private String[] entityRelationtype_att_info = new List<String>{
      'entityRelationtype'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'servicePeriodCounterResetCriteria',
      'agreementCounterResetCriteria'
    };
  }
  public class Agreements {
    public SoapApi33Domain.Agreement[] agreement;
    private String[] agreement_type_info = new List<String>{
      'agreement',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'agreement' };
  }
  public class PaymentMethod {
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class ReversedInvoicePaymentApplications {
    public SoapApi33Domain.ReversedInvoicePaymentApplication[] reversedInvoicePaymentApplication;
    private String[] reversedInvoicePaymentApplication_type_info = new List<String>{
      'reversedInvoicePaymentApplication',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'reversedInvoicePaymentApplication'
    };
  }
  public class ChangeOrder {
    public String eid;
    private String[] eid_att_info = new List<String>{ 'eid' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class AdjustmentCommand {
    public SoapApi33Domain.Adjustment adjustment;
    private String[] adjustment_type_info = new List<String>{
      'adjustment',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'adjustment' };
  }
  public class TaxOrderItemCharge {
    public Integer categoryId;
    public String description;
    public String code;
    public String level;
    public Decimal rate;
    public String jurisdiction;
    private String[] categoryId_att_info = new List<String>{ 'categoryId' };
    private String[] description_att_info = new List<String>{ 'description' };
    private String[] code_att_info = new List<String>{ 'code' };
    private String[] level_att_info = new List<String>{ 'level' };
    private String[] rate_att_info = new List<String>{ 'rate' };
    private String[] jurisdiction_att_info = new List<String>{ 'jurisdiction' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class AdjustmentCategories {
    public SoapApi33Domain.AdjustmentCategory[] adjustmentCategories;
    private String[] adjustmentCategories_type_info = new List<String>{
      'adjustmentCategories',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'adjustmentCategories'
    };
  }
  public class CouponResource {
    public String status;
    //Tract Manually added
    public String name;
    public String type_x;
    public String eid;
    public String identifier;
    public String description;
    public SoapApi33Domain.ServiceResourceCategory category;

    private String[] identifier_att_info = new List<String>{ 'identifier' };
    private String[] description_att_info = new List<String>{ 'description' };
    private String[] eid_att_info = new List<String>{ 'eid' };
    private String[] name_att_info = new List<String>{ 'name' };
    private String[] type_x_att_info = new List<String>{ 'type' };
    private String[] status_att_info = new List<String>{ 'status' };
    private String[] category_type_info = new List<String>{
      'category',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'category' };
  }
  public class DiscountCategories {
    public SoapApi33Domain.DiscountCategory[] discountCategory;
    private String[] discountCategory_type_info = new List<String>{
      'discountCategory',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'discountCategory'
    };
  }
  public class CreateResponse {
    public Boolean successful;
    public Long eid;
    private String[] successful_att_info = new List<String>{ 'successful' };
    private String[] eid_att_info = new List<String>{ 'eid' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class ApplyPaymentResponse {
    public SoapApi33Domain.Payment payment;
    private String[] payment_type_info = new List<String>{
      'payment',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'payment' };
  }
  public class BaseOrderItem {
    public SoapApi33Domain.OrderItems orderItems;
    public SoapApi33Domain.OrderItemUsageRules orderItemUsageRules;
    public SoapApi33Domain.RecurringProductPrice recurringProductPrice;
    public Decimal unitPrice;
    public Decimal recurringUnitPrice;
    public Decimal quantity;
    public Long sequence;
    public String description;
    private String[] orderItems_type_info = new List<String>{
      'orderItems',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] orderItemUsageRules_type_info = new List<String>{
      'orderItemUsageRules',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] recurringProductPrice_type_info = new List<String>{
      'recurringProductPrice',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] unitPrice_att_info = new List<String>{ 'unitPrice' };
    private String[] recurringUnitPrice_att_info = new List<String>{
      'recurringUnitPrice'
    };
    private String[] quantity_att_info = new List<String>{ 'quantity' };
    private String[] sequence_att_info = new List<String>{ 'sequence' };
    private String[] description_att_info = new List<String>{ 'description' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'orderItems',
      'orderItemUsageRules',
      'recurringProductPrice'
    };
  }
  public class scheduledOneTimePriceCharges_element {
    public SoapApi33Domain.ScheduledOneTimePriceCharge[] scheduledOneTimePriceCharge;
    private String[] scheduledOneTimePriceCharge_type_info = new List<String>{
      'scheduledOneTimePriceCharge',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'scheduledOneTimePriceCharge'
    };
  }
  public class ServicePrices {
    public SoapApi33Domain.ServicePrice[] servicePrice;
    private String[] servicePrice_type_info = new List<String>{
      'servicePrice',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'servicePrice' };
  }
  public class PriceList {
    public String name;
    public String eid;
    public SoapApi33Domain.Products products;
    public String description;
    private String[] description_att_info = new List<String>{ 'description' };
    private String[] name_att_info = new List<String>{ 'name' };
    private String[] eid_att_info = new List<String>{ 'eid' };
    private String[] products_type_info = new List<String>{
      'products',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'products' };
  }
  public class AddAddressToParty {
    public SoapApi33Domain.Person person;
    public SoapApi33Domain.Organization organization;
    public SoapApi33Domain.PostalAddress postalAddress;
    public SoapApi33Domain.EmailAddress emailAddress;
    public SoapApi33Domain.TelecomAddress telecomAddress;
    private String[] person_type_info = new List<String>{
      'person',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] organization_type_info = new List<String>{
      'organization',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] postalAddress_type_info = new List<String>{
      'postalAddress',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] emailAddress_type_info = new List<String>{
      'emailAddress',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] telecomAddress_type_info = new List<String>{
      'telecomAddress',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'person',
      'organization',
      'postalAddress',
      'emailAddress',
      'telecomAddress'
    };
  }
  public class AdjustmentApplications {
    public SoapApi33Domain.StandardInvoiceAdjustmentApplication standardInvoiceAdjustmentApplication;
    public SoapApi33Domain.ReversedInvoiceAdjustmentApplication reversedInvoiceAdjustmentApplication;
    public SoapApi33Domain.NegativeInvoiceAdjustmentApplication negativeInvoiceAdjustmentApplication;
    public SoapApi33Domain.writeOffAdjustmentApplication writeOffAdjustmentApplication;
    private String[] standardInvoiceAdjustmentApplication_type_info = new List<String>{
      'standardInvoiceAdjustmentApplication',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] reversedInvoiceAdjustmentApplication_type_info = new List<String>{
      'reversedInvoiceAdjustmentApplication',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] negativeInvoiceAdjustmentApplication_type_info = new List<String>{
      'negativeInvoiceAdjustmentApplication',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] writeOffAdjustmentApplication_type_info = new List<String>{
      'writeOffAdjustmentApplication',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'standardInvoiceAdjustmentApplication',
      'reversedInvoiceAdjustmentApplication',
      'negativeInvoiceAdjustmentApplication',
      'writeOffAdjustmentApplication'
    };
  }
  public class AgreementConfiguration {
    public SoapApi33Domain.Agreement nextAgreement;
    public SoapApi33Domain.Product nextServiceProduct;
    public SoapApi33Domain.RecurringProductPrice nextServiceProductPrice;
    public DateTime endDate;
    public String endAction;
    public String nextEndAction;
    public Boolean preserveServicePrice;
    public Boolean nextPreserveServicePrice;
    public Decimal minimumAmount;

    //Manually added by Abhinav Bhatia from 1.30 version
    public SoapApi33Domain.TrueUpChargeTypes trueUpChargeTypes;

    //Manually added by Aman
    public Integer agreementPeriod;
    private String[] agreementPeriod_att_info = new List<String>{
      'agreementPeriod'
    };

    private String[] nextAgreement_type_info = new List<String>{
      'nextAgreement',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] nextServiceProduct_type_info = new List<String>{
      'nextServiceProduct',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] nextServiceProductPrice_type_info = new List<String>{
      'nextServiceProductPrice',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] endDate_att_info = new List<String>{ 'endDate' };
    private String[] endAction_att_info = new List<String>{ 'endAction' };
    private String[] nextEndAction_att_info = new List<String>{
      'nextEndAction'
    };
    private String[] preserveServicePrice_att_info = new List<String>{
      'preserveServicePrice'
    };
    private String[] nextPreserveServicePrice_att_info = new List<String>{
      'nextPreserveServicePrice'
    };
    private String[] minimumAmount_att_info = new List<String>{
      'minimumAmount'
    };
    //Manually added by Abhinav Bhatia from 1.30 version
    private String[] trueUpChargeTypes_type_info = new List<String>{
      'trueUpChargeTypes',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };

    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'nextAgreement',
      'nextServiceProduct',
      'nextServiceProductPrice',
      'trueUpChargeTypes'
    };
  }
  public class ProductCategory {
    public String name;
    public String description;
    public String status;
    public String eid;
    private String[] eid_att_info = new List<String>{ 'eid' };
    private String[] name_att_info = new List<String>{ 'name' };
    private String[] description_att_info = new List<String>{ 'description' };
    private String[] status_att_info = new List<String>{ 'status' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class BillCycles {
    public SoapApi33Domain.DailyBillCycle[] dailyBillCycle;
    public SoapApi33Domain.MonthlyBillCycle[] monthlyBillCycle;
    public SoapApi33Domain.QuarterlyBillCycle[] quarterlyBillCycle;
    public SoapApi33Domain.YearlyBillCycle[] yearlyBillCycle;
    public SoapApi33Domain.SegmentedMonthlyBillCycle[] segmentedMonthlyBillCycle;
    public Integer totalPages;
    private String[] totalPages_att_info = new List<String>{ 'totalPages' };
    private String[] dailyBillCycle_type_info = new List<String>{
      'dailyBillCycle',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] monthlyBillCycle_type_info = new List<String>{
      'monthlyBillCycle',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] quarterlyBillCycle_type_info = new List<String>{
      'quarterlyBillCycle',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] yearlyBillCycle_type_info = new List<String>{
      'yearlyBillCycle',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] segmentedMonthlyBillCycle_type_info = new List<String>{
      'segmentedMonthlyBillCycle',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'dailyBillCycle',
      'monthlyBillCycle',
      'quarterlyBillCycle',
      'yearlyBillCycle',
      'segmentedMonthlyBillCycle'
    };
  }
  public class StandardInvoiceAdjustmentApplication {
    public SoapApi33Domain.Adjustment accountAdjustment;
    public SoapApi33Domain.Invoice invoice;
    public SoapApi33Domain.Payment payment;
    public Boolean reversed;
    private String[] payment_type_info = new List<String>{
      'payment',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] invoice_type_info = new List<String>{
      'invoice',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] accountAdjustment_type_info = new List<String>{
      'accountAdjustment',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };

    private String[] reversed_att_info = new List<String>{ 'reversed' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'payment',
      'invoice',
      'accountAdjustment'
    };
  }
  public class DiscountConfiguration {
    public SoapApi33Domain.DiscountIdentifier discountIdentifier;
    public Decimal overrideAmount;
    public Decimal overridePercentage;
    public Integer overrideDuration;
    private String[] discountIdentifier_type_info = new List<String>{
      'discountIdentifier',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] overrideAmount_att_info = new List<String>{
      'overrideAmount'
    };
    private String[] overridePercentage_att_info = new List<String>{
      'overridePercentage'
    };
    private String[] overrideDuration_att_info = new List<String>{
      'overrideDuration'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'discountIdentifier'
    };
  }
  public class Currencies {
    public SoapApi33Domain.Currency_x[] currency_x;
    private String[] currency_x_type_info = new List<String>{
      'currency',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'currency_x' };
  }
  public class SystemSettings {
    public SoapApi33Domain.SystemSetting[] systemSetting;
    private String[] systemSetting_type_info = new List<String>{
      'systemSetting',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'systemSetting'
    };
  }
  public class Services {
    public SoapApi33Domain.Service[] service;
    /* Added manually to get the details for pages */
    public Integer pageNumber;
    public Integer pageSize;
    public Long totalElements;
    public Integer elementCount;
    public Integer totalPages;
    private String[] pageNumber_att_info = new List<String>{ 'pageNumber' };
    private String[] pageSize_att_info = new List<String>{ 'pageSize' };
    private String[] totalElements_att_info = new List<String>{
      'totalElements'
    };
    private String[] elementCount_att_info = new List<String>{ 'elementCount' };
    private String[] totalPages_att_info = new List<String>{ 'totalPages' };

    private String[] service_type_info = new List<String>{
      'service',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'service' };
  }
  public class ServiceUsageRules {
    public SoapApi33Domain.MatchAllServiceUsageRule[] matchAllServiceUsageRule;
    public SoapApi33Domain.FormulaServiceUsageRule[] formulaServiceUsageRule;
    public SoapApi33Domain.GlobalServiceUsageRule[] globalServiceUsageRule;
    private String[] matchAllServiceUsageRule_type_info = new List<String>{
      'matchAllServiceUsageRule',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] formulaServiceUsageRule_type_info = new List<String>{
      'formulaServiceUsageRule',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] globalServiceUsageRule_type_info = new List<String>{
      'globalServiceUsageRule',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'matchAllServiceUsageRule',
      'formulaServiceUsageRule',
      'globalServiceUsageRule'
    };
  }
  public class RemoveAddressFromService {
    public SoapApi33Domain.PostalAddress postalAddress;
    private String[] postalAddress_type_info = new List<String>{
      'postalAddress',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'postalAddress'
    };
  }
  public class ChangeParentBillingAccount {
    public SoapApi33Domain.BillingAccount parentBillingAccount;
    public DateTime validFrom;
    private String[] parentBillingAccount_type_info = new List<String>{
      'parentBillingAccount',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] validFrom_att_info = new List<String>{ 'validFrom' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'parentBillingAccount'
    };
  }
  public class GLAggregateBatch {
    public SoapApi33Domain.GLAggregateEntries glAggregateEntries;
    public Date batchCreatedOn;
    public Date batchPostedOn;
    public Boolean exported;
    public Long sequence;
    private String[] glAggregateEntries_type_info = new List<String>{
      'glAggregateEntries',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] batchCreatedOn_att_info = new List<String>{
      'batchCreatedOn'
    };
    private String[] batchPostedOn_att_info = new List<String>{
      'batchPostedOn'
    };
    private String[] exported_att_info = new List<String>{ 'exported' };
    private String[] sequence_att_info = new List<String>{ 'sequence' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'glAggregateEntries'
    };
  }
  //Manually added by Abhinav Bhatia from 1.30 version
  public class ManualAdjustmentItem {
    public SoapApi33Domain.Adjustment adjustment;
    public SoapApi33Domain.AdjustmentReason reason;
    public SoapApi33Domain.AdjustmentReason secondaryReason;
    public SoapApi33Domain.AdjustmentCategory category;
    private String[] adjustment_type_info = new List<String>{
      'adjustment',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] reason_type_info = new List<String>{
      'reason',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] secondaryReason_type_info = new List<String>{
      'secondaryReason',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] category_type_info = new List<String>{
      'category',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'adjustment',
      'reason',
      'secondaryReason',
      'category'
    };
  }
  public class SalesOrders {
    public SoapApi33Domain.SalesOrder[] salesOrder;
    /* Added manually to get the details for pages */
    public Integer pageNumber;
    public Integer pageSize;
    public Long totalElements;
    public Integer elementCount;
    public Integer totalPages;
    private String[] pageNumber_att_info = new List<String>{ 'pageNumber' };
    private String[] pageSize_att_info = new List<String>{ 'pageSize' };
    private String[] totalElements_att_info = new List<String>{
      'totalElements'
    };
    private String[] elementCount_att_info = new List<String>{ 'elementCount' };
    private String[] totalPages_att_info = new List<String>{ 'totalPages' };

    private String[] salesOrder_type_info = new List<String>{
      'salesOrder',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'salesOrder' };
  }
  public class RenewServiceResponse {
    public Long renewalOrderEid;
    public DateTime renewalDate;
    private String[] renewalOrderEid_att_info = new List<String>{
      'renewalOrderEid'
    };
    private String[] renewalDate_att_info = new List<String>{ 'renewalDate' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class DeactivateService {
    public SoapApi33Domain.ServiceDeactivationReason reason;
    public SoapApi33Domain.Service service;
    public String effectiveDate;
    private String[] reason_type_info = new List<String>{
      'reason',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] service_type_info = new List<String>{
      'service',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] effectiveDate_att_info = new List<String>{
      'effectiveDate'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'reason',
      'service'
    };
  }
  public class BasePriceCharge {
    public String description;
    public Decimal amount;
    public Boolean invoiced;
    public DateTime chargeDate;
    private String[] description_att_info = new List<String>{ 'description' };
    private String[] amount_att_info = new List<String>{ 'amount' };
    private String[] invoiced_att_info = new List<String>{ 'invoiced' };
    private String[] chargeDate_att_info = new List<String>{ 'chargeDate' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class ServicePriceRange {
    public Decimal quantityBeginRange;
    public Decimal quantityEndRange;
    public Decimal price;
    private String[] quantityBeginRange_att_info = new List<String>{
      'quantityBeginRange'
    };
    private String[] quantityEndRange_att_info = new List<String>{
      'quantityEndRange'
    };
    private String[] price_att_info = new List<String>{ 'price' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class StandardInvoiceAdjustmentApplications {
    public SoapApi33Domain.StandardInvoiceAdjustmentApplication[] standardInvoiceAdjustmentApplication;
    private String[] standardInvoiceAdjustmentApplication_type_info = new List<String>{
      'standardInvoiceAdjustmentApplication',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'standardInvoiceAdjustmentApplication'
    };
  }
  public class RenewalOrder {
    public DateTime renewalDate;
    private String[] renewalDate_att_info = new List<String>{ 'renewalDate' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class SuspensionReason {
    public String name;
    public String status;
    public String reasonType;
    public String eid;

    private String[] name_att_info = new List<String>{ 'name' };
    private String[] status_att_info = new List<String>{ 'status' };
    private String[] reasonType_att_info = new List<String>{ 'reasonType' };
    private String[] eid_att_info = new List<String>{ 'eid' };

    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class GLExtractBatch {
    public String batchNumber;
    public String description;
    public Integer totalRecords;
    public String status;
    public String xref;
    public String xrefMsg;
    public String xrefImportedDate;
    private String[] batchNumber_att_info = new List<String>{ 'batchNumber' };
    private String[] description_att_info = new List<String>{ 'description' };
    private String[] totalRecords_att_info = new List<String>{ 'totalRecords' };
    private String[] status_att_info = new List<String>{ 'status' };
    private String[] xref_att_info = new List<String>{ 'xref' };
    private String[] xrefMsg_att_info = new List<String>{ 'xrefMsg' };
    private String[] xrefImportedDate_att_info = new List<String>{
      'xrefImportedDate'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class ChangeServiceScheduledCharges {
    public SoapApi33Domain.scheduledCharges_element scheduledCharges;
    private String[] scheduledCharges_type_info = new List<String>{
      'scheduledCharges',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'scheduledCharges'
    };
  }
  public class PartyCategory {
    public String eid;
    public String name;
    public String description;
    public String status;
    private String[] eid_att_info = new List<String>{ 'eid' };
    private String[] name_att_info = new List<String>{ 'name' };
    private String[] description_att_info = new List<String>{ 'description' };
    private String[] status_att_info = new List<String>{ 'status' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  /*public class PriceRange {
        public Decimal quantityBeginRange;
        public Decimal quantityEndRange;
        public Decimal price;
        public Integer level;
        public String currencyType;
        private String[] quantityBeginRange_att_info = new String[]{'quantityBeginRange'};
        private String[] quantityEndRange_att_info = new String[]{'quantityEndRange'};
        private String[] price_att_info = new String[]{'price'};
        private String[] level_att_info = new String[]{'level'};
        private String[] currencyType_att_info = new String[]{'currencyType'};
        private String[] apex_schema_type_info = new String[]{'http://www.tractbilling.com/billing/1_33/domain','true','false'};
        private String[] field_order_type_info = new String[]{};
    }*/
  public class PriceRange {
    public Decimal quantityBeginRange;
    public Decimal quantityEndRange;
    public Decimal price;
    public Integer level;
    public String currencyType;

    /** Tract */
    public String eid;
    private String[] eid_att_info = new List<String>{ 'eid' };

    private String[] quantityBeginRange_att_info = new List<String>{
      'quantityBeginRange'
    };
    private String[] quantityEndRange_att_info = new List<String>{
      'quantityEndRange'
    };
    private String[] price_att_info = new List<String>{ 'price' };
    private String[] level_att_info = new List<String>{ 'level' };
    private String[] currencyType_att_info = new List<String>{ 'currencyType' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  //Manually added by Abhinav Bhatia from 1.30 version
  public class AdjustmentConfiguration {
    public Decimal amount;
    public Boolean credit;
    private String[] amount_att_info = new List<String>{ 'amount' };
    private String[] credit_att_info = new List<String>{ 'credit' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  //Manually added by Abhinav Bhatia from 1.30 version
  public class ActivateUsagePool {
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  //Manually added by Abhinav Bhatia from 1.30 version
  public class PriceCategory {
    public String name;
    public String description;
    public String eid;
    private String[] name_att_info = new List<String>{ 'name' };
    private String[] eid_att_info = new List<String>{ 'eid' };
    private String[] description_att_info = new List<String>{ 'description' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }

  public class Invoices {
    public SoapApi33Domain.Invoice[] invoice;
    public SoapApi33Domain.Invoice[] manualInvoice;
    public SoapApi33Domain.Invoice[] onDemandInvoice;
    public Integer pageNumber;
    public Integer pageSize;
    public Long totalElements;
    public Integer elementCount;
    public Integer totalPages;
    private String[] pageNumber_att_info = new List<String>{ 'pageNumber' };
    private String[] pageSize_att_info = new List<String>{ 'pageSize' };
    private String[] totalElements_att_info = new List<String>{
      'totalElements'
    };
    private String[] elementCount_att_info = new List<String>{ 'elementCount' };
    private String[] totalPages_att_info = new List<String>{ 'totalPages' };
    private String[] manualInvoice_type_info = new List<String>{
      'manualInvoice',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] onDemandInvoice_type_info = new List<String>{
      'onDemandInvoice',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] invoice_type_info = new List<String>{
      'invoice',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'invoice',
      'manualInvoice',
      'onDemandInvoice'
    };
  }
  public class RenewService {
    public SoapApi33Domain.SalesOrder order;
    public SoapApi33Domain.Service service;
    public Boolean preservePricing;
    private String[] order_type_info = new List<String>{
      'order',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] service_type_info = new List<String>{
      'service',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] preservePricing_att_info = new List<String>{
      'preservePricing'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'order',
      'service'
    };
  }
  public class BillingAccountRecurringPayment {
    public SoapApi33Domain.BpayPaymentMethod bpayPaymentMethod;
    public SoapApi33Domain.MobileCarrierPayment mobileCarrierPayment;
    public SoapApi33Domain.sepaDirectDebitPaymentMethod sepaDirectDebitPaymentMethod;
    public SoapApi33Domain.TokenizedCreditCardPaymentMethod tokenizedCreditCardPaymentMethod;
    public SoapApi33Domain.CreditCardPaymentMethod creditCardPaymentMethod;
    public SoapApi33Domain.BankPaymentMethod bankPaymentMethod;
    public SoapApi33Domain.ReferencedCreditCardPaymentMethod referencedCreditCardPaymentMethod;
    public SoapApi33Domain.PayPalPaymentMethod payPalPaymentMethod;
    public SoapApi33Domain.BillingAccount billingAccount;
    public SoapApi33Domain.CustomPaymentMethod customPaymentMethod;
    public DateTime validFrom;
    public DateTime validTo;
    public String eid;
    private String[] eid_att_info = new List<String>{ 'eid' };
    private String[] bpayPaymentMethod_type_info = new List<String>{
      'bpayPaymentMethod',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] mobileCarrierPayment_type_info = new List<String>{
      'mobileCarrierPayment',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] sepaDirectDebitPaymentMethod_type_info = new List<String>{
      'sepaDirectDebitPaymentMethod',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] tokenizedCreditCardPaymentMethod_type_info = new List<String>{
      'tokenizedCreditCardPaymentMethod',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] creditCardPaymentMethod_type_info = new List<String>{
      'creditCardPaymentMethod',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] bankPaymentMethod_type_info = new List<String>{
      'bankPaymentMethod',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] referencedCreditCardPaymentMethod_type_info = new List<String>{
      'referencedCreditCardPaymentMethod',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] payPalPaymentMethod_type_info = new List<String>{
      'payPalPaymentMethod',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] billingAccount_type_info = new List<String>{
      'billingAccount',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] customPaymentMethod_type_info = new List<String>{
      'customPaymentMethod',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] validFrom_att_info = new List<String>{ 'validFrom' };
    private String[] validTo_att_info = new List<String>{ 'validTo' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'tokenizedCreditCardPaymentMethod',
      'creditCardPaymentMethod',
      'bankPaymentMethod',
      'referencedCreditCardPaymentMethod',
      'payPalPaymentMethod',
      'billingAccount',
      'customPaymentMethod'
    };
  }
  public class WhereClause {
    public String entityType;
    public String clause;
    private String[] entityType_att_info = new List<String>{ 'entityType' };
    private String[] clause_att_info = new List<String>{ 'clause' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class OneTimeProductPrices {
    public SoapApi33Domain.OneTimeProductPrice[] oneTimeProductPrice;
    private String[] oneTimeProductPrice_type_info = new List<String>{
      'oneTimeProductPrice',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'oneTimeProductPrice'
    };
  }
  public class AddServiceUsageRuleToService {
    public SoapApi33Domain.MatchAllServiceUsageRule matchAllServiceUsageRule;
    public SoapApi33Domain.FormulaServiceUsageRule formulaServiceUsageRule;
    public SoapApi33Domain.GlobalServiceUsageRule globalServiceUsageRule;
    public SoapApi33Domain.Service service;
    private String[] matchAllServiceUsageRule_type_info = new List<String>{
      'matchAllServiceUsageRule',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] formulaServiceUsageRule_type_info = new List<String>{
      'formulaServiceUsageRule',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] globalServiceUsageRule_type_info = new List<String>{
      'globalServiceUsageRule',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] service_type_info = new List<String>{
      'service',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'matchAllServiceUsageRule',
      'formulaServiceUsageRule',
      'globalServiceUsageRule',
      'service'
    };
  }
  public class DeactivateBillingAccount {
    public SoapApi33Domain.DeactivationReason reason;
    public DateTime startDate;
    public SoapApi33Domain.BillingAccount billingAccount;
    private String[] billingAccount_type_info = new List<String>{
      'billingAccount',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] startDate_att_info = new List<String>{ 'startDate' };
    private String[] reason_type_info = new List<String>{
      'reason',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'reason',
      'billingAccount'
    };
  }
  public class People {
    public SoapApi33Domain.Person[] person;
    public Integer totalPages;
    private String[] totalPages_att_info = new List<String>{ 'totalPages' };
    private String[] person_type_info = new List<String>{
      'person',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'person' };
  }
  public class DiscountCode {
    public SoapApi33Domain.DiscountChargeCategory discountChargeCategory;
    public SoapApi33Domain.Discount discount;
    public SoapApi33Domain.DiscountCategory discountCategory;
    public String name;
    public String status;
    public String description;
    public DateTime validFrom;
    public DateTime validTo;
    private String[] discountChargeCategory_type_info = new List<String>{
      'discountChargeCategory',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] discount_type_info = new List<String>{
      'discount',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] discountCategory_type_info = new List<String>{
      'discountCategory',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] name_att_info = new List<String>{ 'name' };
    private String[] status_att_info = new List<String>{ 'status' };
    private String[] description_att_info = new List<String>{ 'description' };
    private String[] validFrom_att_info = new List<String>{ 'validFrom' };
    private String[] validTo_att_info = new List<String>{ 'validTo' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'discountChargeCategory',
      'discount',
      'discountCategory'
    };
  }
  public class Service {
    public SoapApi33Domain.BillingAccount billingAccount;
    public SoapApi33Domain.ServiceResource serviceResource;
    public SoapApi33Domain.ServiceResources serviceResources;
    public SoapApi33Domain.Product product;
    public SoapApi33Domain.Service parentService;
    public SoapApi33Domain.ServicePeriods servicePeriods;
    public SoapApi33Domain.AgreementService currentAgreementService;
    public SoapApi33Domain.ServicePrices servicePrices;
    public SoapApi33Domain.Service nextService;
    public SoapApi33Domain.ServiceUsageRules serviceUsageRules;
    public SoapApi33Domain.Counters counters;
    public SoapApi33Domain.CustomFieldValues customFieldValues;
    public SoapApi33Domain.addresses_element addresses;
    //Manually added by Abhinav Bhatia from 1.30 verison
    public SoapApi33Domain.Services childServices;
    public SoapApi33Domain.ServiceSuspensionReason serviceSuspensionReason;
    public SoapApi33Domain.ServiceDeactivationReason serviceDeactivationReason;
    public Decimal amount;
    public DateTime startDate;
    public DateTime endDate;
    public String status;
    public String description;
    public Integer renewalCount;
    public DateTime commitmentEndDate;
    public Integer oldLevel;
    public Integer currentLevel;
    public Decimal quantity;
    private String[] billingAccount_type_info = new List<String>{
      'billingAccount',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] serviceResource_type_info = new List<String>{
      'serviceResource',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] serviceResources_type_info = new List<String>{
      'serviceResources',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] product_type_info = new List<String>{
      'product',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] parentService_type_info = new List<String>{
      'parentService',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] servicePeriods_type_info = new List<String>{
      'servicePeriods',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] currentAgreementService_type_info = new List<String>{
      'currentAgreementService',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] servicePrices_type_info = new List<String>{
      'servicePrices',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] nextService_type_info = new List<String>{
      'nextService',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] serviceUsageRules_type_info = new List<String>{
      'serviceUsageRules',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] counters_type_info = new List<String>{
      'counters',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] customFieldValues_type_info = new List<String>{
      'customFieldValues',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] addresses_type_info = new List<String>{
      'addresses',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };

    private String[] childServices_type_info = new List<String>{
      'childServices',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] serviceSuspensionReason_type_info = new List<String>{
      'serviceSuspensionReason',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] serviceDeactivationReason_type_info = new List<String>{
      'serviceDeactivationReason',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] amount_att_info = new List<String>{ 'amount' };
    private String[] startDate_att_info = new List<String>{ 'startDate' };
    private String[] endDate_att_info = new List<String>{ 'endDate' };
    private String[] status_att_info = new List<String>{ 'status' };
    private String[] description_att_info = new List<String>{ 'description' };
    private String[] renewalCount_att_info = new List<String>{ 'renewalCount' };
    private String[] commitmentEndDate_att_info = new List<String>{
      'commitmentEndDate'
    };
    private String[] oldLevel_att_info = new List<String>{ 'oldLevel' };
    private String[] currentLevel_att_info = new List<String>{ 'currentLevel' };
    private String[] quantity_att_info = new List<String>{ 'quantity' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'billingAccount',
      'serviceResource',
      'serviceResources',
      'product',
      'parentService',
      'servicePeriods',
      'currentAgreementService',
      'servicePrices',
      'nextService',
      'serviceUsageRules',
      'counters',
      'customFieldValues',
      'addresses',
      'childServices',
      'serviceSuspensionReason',
      'serviceDeactivationReason'
    };

    public String eid;
    private String[] eid_att_info = new List<String>{ 'eid' };
  }
  public class OrderItemCharge {
    public String productName;
    public String priceCategory;
    public DateTime orderDate;
    public Decimal amount;
    private String[] productName_att_info = new List<String>{ 'productName' };
    private String[] priceCategory_att_info = new List<String>{
      'priceCategory'
    };
    private String[] orderDate_att_info = new List<String>{ 'orderDate' };
    private String[] amount_att_info = new List<String>{ 'amount' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class VoidUsageEvent {
    public SoapApi33Domain.UsageEvent usageEvent;
    private String[] usageEvent_type_info = new List<String>{
      'usageEvent',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'usageEvent' };
  }
  public class ReallocatePayment {
    public SoapApi33Domain.Payment payment;
    public SoapApi33Domain.RefundReason reason;
    public SoapApi33Domain.invoices_element invoices;
    public String description;
    public String occurredOn;
    private String[] payment_type_info = new List<String>{
      'payment',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] reason_type_info = new List<String>{
      'reason',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] invoices_type_info = new List<String>{
      'invoices',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] description_att_info = new List<String>{ 'description' };
    private String[] occurredOn_att_info = new List<String>{ 'occurredOn' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'payment',
      'reason',
      'invoices'
    };
  }
  public class ChangeOrders {
    public SoapApi33Domain.ChangeOrder[] changeOrder;
    private String[] changeOrder_type_info = new List<String>{
      'changeOrder',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'changeOrder' };
  }
  public class RecurringProductPrices {
    public SoapApi33Domain.RecurringProductPrice[] recurringRecurringProductPrice;
    private String[] recurringRecurringProductPrice_type_info = new List<String>{
      'recurringRecurringProductPrice',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'recurringRecurringProductPrice'
    };
  }
  public class DiscountChargeCategories {
    public SoapApi33Domain.DiscountChargeCategory[] discountChargeCategory;
    private String[] discountChargeCategory_type_info = new List<String>{
      'discountChargeCategory',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'discountChargeCategory'
    };
  }
  public class PayPalPaymentMethod {
    public String preapprovalKey;
    public SoapApi33Domain.CustomFieldValues customFieldValues;
    public String eid;
    private String[] eid_att_info = new List<String>{ 'eid' };
    private String[] customFieldValues_type_info = new List<String>{
      'customFieldValues',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] preapprovalKey_att_info = new List<String>{
      'preapprovalKey'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  /*public class ScheduledOneTimePriceCharge {
        private String[] apex_schema_type_info = new String[]{'http://www.tractbilling.com/billing/1_33/domain','true','false'};
        private String[] field_order_type_info = new String[]{};
    }*/
  public class ScheduledOneTimePriceCharge {
    public String eid;
    public String description;
    public Decimal amount;
    public Boolean invoiced;
    public String chargeDate;
    public String status;
    private String[] status_att_info = new List<String>{ 'status' };
    private String[] description_att_info = new List<String>{ 'description' };
    private String[] invoiced_att_info = new List<String>{ 'invoiced' };
    private String[] amount_att_info = new List<String>{ 'amount' };
    private String[] chargeDate_att_info = new List<String>{ 'chargeDate' };
    private String[] eid_att_info = new List<String>{ 'eid' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class ProductRelation {
    public SoapApi33Domain.Product product;
    public String type_x;
    public String eid;
    public String scope;
    private String[] scope_att_info = new List<String>{ 'scope' };
    private String[] eid_att_info = new List<String>{ 'eid' };
    private String[] product_type_info = new List<String>{
      'product',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] type_x_att_info = new List<String>{ 'type' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'product' };
  }
  public class ProductUsageRules {
    public SoapApi33Domain.MatchAllProductUsageRule[] matchAllProductUsageRule;
    public SoapApi33Domain.FormulaProductUsageRule[] formulaProductUsageRule;
    public SoapApi33Domain.GlobalProductUsageRule[] globalProductUsageRule;
    private String[] matchAllProductUsageRule_type_info = new List<String>{
      'matchAllProductUsageRule',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] formulaProductUsageRule_type_info = new List<String>{
      'formulaProductUsageRule',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] globalProductUsageRule_type_info = new List<String>{
      'globalProductUsageRule',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'matchAllProductUsageRule',
      'formulaProductUsageRule',
      'globalProductUsageRule'
    };
  }
  public class RateTableEntries {
    public SoapApi33Domain.RateTableEntry[] rateTableEntry;
    private String[] rateTableEntry_type_info = new List<String>{
      'rateTableEntry',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'rateTableEntry'
    };
  }
  public class ProductQuery {
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class GeneralLedger {
    public SoapApi33Domain.GLAccounts chartOfAccounts;
    public String name;
    public String description;
    public String status;
    public String targetCurrencyType;
    private String[] chartOfAccounts_type_info = new List<String>{
      'chartOfAccounts',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] name_att_info = new List<String>{ 'name' };
    private String[] description_att_info = new List<String>{ 'description' };
    private String[] status_att_info = new List<String>{ 'status' };
    private String[] targetCurrencyType_att_info = new List<String>{
      'targetCurrencyType'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'chartOfAccounts'
    };
  }
  public class ProductRelations {
    public SoapApi33Domain.ProductRelation[] productRelation;
    private String[] productRelation_type_info = new List<String>{
      'productRelation',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'productRelation'
    };
  }
  public class ApproveAction {
    public SoapApi33Domain.SalesOrder order;
    public Long sequence;
    private String[] order_type_info = new List<String>{
      'order',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] sequence_att_info = new List<String>{ 'sequence' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'order' };
  }
  public class changeServiceAbstractPriceChargesCommand {
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class ServiceDeactivationReason {
    public String reason;
    public String name;
    public String eid;
    private String[] eid_att_info = new List<String>{ 'eid' };
    private String[] reason_att_info = new List<String>{ 'reason' };
    private String[] name_att_info = new List<String>{ 'name' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class ScheduledOneTimePriceCharges {
    public SoapApi33Domain.ScheduledOneTimePriceCharge[] scheduledOneTimePriceCharge;
    private String[] scheduledOneTimePriceCharge_type_info = new List<String>{
      'scheduledOneTimePriceCharge',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'scheduledOneTimePriceCharge'
    };
  }
  public class DeactivationReason {
    public String name;
    public String status;
    public String reasonType;
    public String eid;

    private String[] name_att_info = new List<String>{ 'name' };
    private String[] status_att_info = new List<String>{ 'status' };
    private String[] reasonType_att_info = new List<String>{ 'reasonType' };
    private String[] eid_att_info = new List<String>{ 'eid' };

    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class AbstractServiceResource {
    public SoapApi33Domain.ServiceResourceCategory category;
    public String identifier;
    public String description;
    private String[] category_type_info = new List<String>{
      'category',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] identifier_att_info = new List<String>{ 'identifier' };
    private String[] description_att_info = new List<String>{ 'description' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'category' };
  }
  public class FormulaOrderItemUsageRule {
    public SoapApi33Domain.UsageLookupTable lookupTable;
    public SoapApi33Domain.FormulaProductUsageRule formulaProductUsageRule;
    public String fieldName;
    public String operator;
    public String fieldValue;
    public String lookupTableFieldValue;

    public String name;
    public String eid;
    public String usageUom;
    public String allowanceType;
    public String status;
    public Double limit_x;
    public Boolean proratedOnOrder;
    public Boolean proratedOnCancel;
    public String rollOverType;
    public String ruleType;

    public SoapApi33Domain.ChargeCategory chargeCategory;
    public SoapApi33Domain.FlatUsageRate flatUsageRate;

    public SoapApi33Domain.TableUsageRate tableUsageRate;
    public SoapApi33Domain.RateTable rateTable;
    public SoapApi33Domain.PassThroughUsageRate passThroughUsageRate;
    public SoapApi33Domain.RateTableEntries rateTableEntries;
    private String[] lookupTable_type_info = new List<String>{
      'lookupTable',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] formulaProductUsageRule_type_info = new List<String>{
      'formulaProductUsageRule',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] fieldName_att_info = new List<String>{ 'fieldName' };
    private String[] operator_att_info = new List<String>{ 'operator' };
    private String[] fieldValue_att_info = new List<String>{ 'fieldValue' };
    private String[] lookupTableFieldValue_att_info = new List<String>{
      'lookupTableFieldValue',
      'formulaProductUsageRule'
    };

    private String[] name_att_info = new List<String>{ 'name' };
    private String[] eid_att_info = new List<String>{ 'eid' };
    private String[] usageUom_att_info = new List<String>{ 'usageUom' };
    private String[] allowanceType_att_info = new List<String>{
      'allowanceType'
    };
    private String[] status_att_info = new List<String>{ 'status' };
    private String[] limit_x_att_info = new List<String>{ 'limit' };
    private String[] proratedOnOrder_att_info = new List<String>{
      'proratedOnOrder'
    };
    private String[] proratedOnCancel_att_info = new List<String>{
      'proratedOnCancel'
    };
    private String[] rollOverType_att_info = new List<String>{ 'rollOverType' };
    private String[] ruleType_att_info = new List<String>{ 'ruleType' };

    private String[] chargeCategory_type_info = new List<String>{
      'chargeCategory',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] flatUsageRate_type_info = new List<String>{
      'flatUsageRate',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };

    private String[] tableUsageRate_type_info = new List<String>{
      'tableUsageRate',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] rateTable_type_info = new List<String>{
      'rateTable',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] passThroughUsageRate_type_info = new List<String>{
      'passThroughUsageRate',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] rateTableEntries_type_info = new List<String>{
      'rateTableEntries',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'lookupTable',
      'formulaProductUsageRule',
      'chargeCategory',
      'flatUsageRate',
      'tableUsageRate',
      'rateTable',
      'passThroughUsageRate',
      'rateTableEntries'
    };
  }
  public class DiscountCategory {
    public String name;
    public String description;
    public String status;
    private String[] name_att_info = new List<String>{ 'name' };
    private String[] description_att_info = new List<String>{ 'description' };
    private String[] status_att_info = new List<String>{ 'status' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class InvoiceItemCharge {
    public Decimal unProratedAmount;
    public Decimal amount;
    public String priceCategory;
    public Decimal balance;
    public Boolean paid;
    public Boolean recurringCharge;
    public Boolean billInAdvance;
    public String taxDescription;
    public String taxLevel;
    public Decimal taxRate;
    public String chargeDescription;
    public String type_x;
    private String[] unProratedAmount_att_info = new List<String>{
      'unProratedAmount'
    };
    private String[] amount_att_info = new List<String>{ 'amount' };
    private String[] priceCategory_att_info = new List<String>{
      'priceCategory'
    };
    private String[] balance_att_info = new List<String>{ 'balance' };
    private String[] paid_att_info = new List<String>{ 'paid' };
    private String[] recurringCharge_att_info = new List<String>{
      'recurringCharge'
    };
    private String[] billInAdvance_att_info = new List<String>{
      'billInAdvance'
    };
    private String[] taxDescription_att_info = new List<String>{
      'taxDescription'
    };
    private String[] taxLevel_att_info = new List<String>{ 'taxLevel' };
    private String[] taxRate_att_info = new List<String>{ 'taxRate' };
    private String[] chargeDescription_att_info = new List<String>{
      'chargeDescription'
    };
    private String[] type_x_att_info = new List<String>{ 'type' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class AdditionalInformation {
    public String name;
    public String value;
    public String additionalInformationType;
    private String[] name_att_info = new List<String>{ 'name' };
    private String[] value_att_info = new List<String>{ 'value' };
    private String[] additionalInformationType_att_info = new List<String>{
      'additionalInformationType'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class WriteOffsAdjustmentApplications {
    public SoapApi33Domain.writeOffAdjustmentApplication[] writeOffAdjustmentApplication;
    private String[] writeOffAdjustmentApplication_type_info = new List<String>{
      'writeOffAdjustmentApplication',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'writeOffAdjustmentApplication'
    };
  }
  public class UsageInvoiceItem {
    public SoapApi33Domain.Service service;
    private String[] service_type_info = new List<String>{
      'service',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'service' };
  }
  public class ProductSaleOperationAttribute {
    public DateTime autoApproveDate;
    private String[] autoApproveDate_att_info = new List<String>{
      'autoApproveDate'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class Actions {
    public SoapApi33Domain.ProductSaleAction productSaleAction;
    public SoapApi33Domain.ServiceAction serviceAction;
    private String[] productSaleAction_type_info = new List<String>{
      'productSaleAction',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] serviceAction_type_info = new List<String>{
      'serviceAction',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'productSaleAction',
      'serviceAction'
    };
  }
  public class RateTables {
    public SoapApi33Domain.RateTable[] rateTable;
    private String[] rateTable_type_info = new List<String>{
      'rateTable',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'rateTable' };
  }
  //Manually added by Abhinav Bhatia from 1.30 version
  public class LateFeeAdjustmentItem {
    public SoapApi33Domain.Invoice latePaymentInvoice;
    public Decimal lateAmount;
    public SoapApi33Domain.Adjustment adjustment;
    public SoapApi33Domain.AdjustmentReason reason;
    public SoapApi33Domain.AdjustmentReason secondaryReason;
    public SoapApi33Domain.AdjustmentCategory category;
    private String[] adjustment_type_info = new List<String>{
      'adjustment',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] reason_type_info = new List<String>{
      'reason',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] secondaryReason_type_info = new List<String>{
      'secondaryReason',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] category_type_info = new List<String>{
      'category',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] latePaymentInvoice_type_info = new List<String>{
      'latePaymentInvoice',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] lateAmount_att_info = new List<String>{ 'lateAmount' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'latePaymentInvoice',
      'adjustment',
      'reason',
      'secondaryReason',
      'category'
    };
  }

  public class QuarterlyBillCycle {
    /* @Jrathore - From line below to next blank line copied
     *  from BillCycle Apex Class generated above to process
     *  response received from Tract.
     */
    public SoapApi33Domain.BillingAccountCategory billingAccountCategory;
    private String[] billingAccountCategory_type_info = new List<String>{
      'billingAccountCategory',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    public String eid;
    public String name;
    public DateTime startDate;
    public DateTime endDate;
    public String billCycleType;
    public Boolean autoBill;
    public Boolean usePaymentTerm;
    public String status;
    public String currencyType;
    private String[] eid_att_info = new List<String>{ 'eid' };
    private String[] name_att_info = new List<String>{ 'name' };
    private String[] startDate_att_info = new List<String>{ 'startDate' };
    private String[] endDate_att_info = new List<String>{ 'endDate' };
    private String[] billCycleType_att_info = new List<String>{
      'billCycleType'
    };
    private String[] autoBill_att_info = new List<String>{ 'autoBill' };
    private String[] usePaymentTerm_att_info = new List<String>{
      'usePaymentTerm'
    };
    private String[] status_att_info = new List<String>{ 'status' };
    private String[] currencyType_att_info = new List<String>{ 'currencyType' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'billingAccountCategory'
    };
    public Integer endMonth;
    public Integer dayOfMonth;
    private String[] endMonth_att_info = new List<String>{ 'endMonth' };
    private String[] dayOfMonth_att_info = new List<String>{ 'dayOfMonth' };
  }
  public class Currency_x {
    public String name;
    public String currencyType;
    public String symbol;
    public String numericCode;
    public Boolean default_x;
    private String[] name_att_info = new List<String>{ 'name' };
    private String[] currencyType_att_info = new List<String>{ 'currencyType' };
    private String[] symbol_att_info = new List<String>{ 'symbol' };
    private String[] numericCode_att_info = new List<String>{ 'numericCode' };
    private String[] default_x_att_info = new List<String>{ 'default' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }

  public class Adjustment {
    public SoapApi33Domain.Invoice billedInvoice;
    public SoapApi33Domain.BillingAccount billingAccount;
    public SoapApi33Domain.AdjustmentReason reason;
    public SoapApi33Domain.AdjustmentReason secondaryReason;
    public SoapApi33Domain.AdjustmentApplications adjustmentApplications;
    public SoapApi33Domain.AdjustmentItems adjustmentItems;
    public String eid;
    public DateTime occurredOn;
    public Decimal amount;
    public String description;
    public Boolean invoiced;
    public Boolean credit;
    public String status;
    public String type_x;
    public DateTime postedOn;
    public String postedBy;
    public Boolean manualInvoiceApplication;
    public Decimal unappliedAmount;
    public String creditNumber;
    private String[] eid_att_info = new List<String>{ 'eid' };
    private String[] billedInvoice_type_info = new List<String>{
      'billedInvoice',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] billingAccount_type_info = new List<String>{
      'billingAccount',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] reason_type_info = new List<String>{
      'reason',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] secondaryReason_type_info = new List<String>{
      'secondaryReason',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] adjustmentApplications_type_info = new List<String>{
      'adjustmentApplications',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] adjustmentItems_type_info = new List<String>{
      'adjustmentItems',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] occurredOn_att_info = new List<String>{ 'occurredOn' };
    private String[] amount_att_info = new List<String>{ 'amount' };
    private String[] description_att_info = new List<String>{ 'description' };
    private String[] invoiced_att_info = new List<String>{ 'invoiced' };
    private String[] credit_att_info = new List<String>{ 'credit' };
    private String[] status_att_info = new List<String>{ 'status' };
    private String[] type_x_att_info = new List<String>{ 'type' };
    private String[] postedOn_att_info = new List<String>{ 'postedOn' };
    private String[] postedBy_att_info = new List<String>{ 'postedBy' };
    private String[] creditNumber_att_info = new List<String>{ 'creditNumber' };
    private String[] unappliedAmount_att_info = new List<String>{
      'unappliedAmount'
    };
    private String[] manualInvoiceApplication_att_info = new List<String>{
      'manualInvoiceApplication'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'billedInvoice',
      'billingAccount',
      'reason',
      'secondaryReason',
      'adjustmentApplications',
      'adjustmentItems'
    };
  }
  public class writeOffAdjustmentApplication {
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class GLAggregateBatches {
    public SoapApi33Domain.GLAggregateBatch[] glAggregateBatch;
    private String[] glAggregateBatch_type_info = new List<String>{
      'glAggregateBatch',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'glAggregateBatch'
    };
  }
  public class AdjustmentInvoiceItem {
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class DiscountIdentifier {
    public String status;
    public Boolean unlimited;
    public Integer limit_x;
    public Integer uses;
    private String[] status_att_info = new List<String>{ 'status' };
    private String[] unlimited_att_info = new List<String>{ 'unlimited' };
    private String[] limit_x_att_info = new List<String>{ 'limit' };
    private String[] uses_att_info = new List<String>{ 'uses' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };

    //Manuall Added
    public String eid;
    private String[] eid_att_info = new List<String>{ 'eid' };
    public String identifier;
    private String[] identifier_att_info = new List<String>{ 'identifier' };

    public SoapApi33Domain.ServiceResourceCategory category;
    public String description;
    private String[] category_type_info = new List<String>{
      'category',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] description_att_info = new List<String>{ 'description' };
    private String[] field_order_type_info = new List<String>{ 'category' };
  }
  public class BillingAccountRecurringPayments {
    public SoapApi33Domain.BillingAccountRecurringPayment[] recurringPayment;
    public Integer totalPages;
    private String[] totalPages_att_info = new List<String>{ 'totalPages' };
    private String[] recurringPayment_type_info = new List<String>{
      'recurringPayment',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'recurringPayment'
    };
  }
  public abstract class Party {
    public SoapApi33Domain.addresses_element addresses;
    public String taxIdNumber;
    private String[] addresses_type_info = new List<String>{
      'addresses',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] taxIdNumber_att_info = new List<String>{ 'taxIdNumber' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'addresses' };
  }
  public class PartyCategories {
    public SoapApi33Domain.PartyCategory[] partyCategory;
    private String[] partyCategory_type_info = new List<String>{
      'partyCategory',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'partyCategory'
    };
  }
  public class ProductPrice {
    public SoapApi33Domain.PriceRanges priceRanges;
    public SoapApi33Domain.ProductUsageRules productUsageRules;

    //Manually added by Abhinav Bhatia from 1.30 version
    public SoapApi33Domain.PriceCategory priceCategory;

    public DateTime fromDate;
    public DateTime thruDate;
    public Boolean priceOverride;
    public String type_x;
    public Boolean paymentOnPurchaseRequired;
    public Boolean recurringPaymentRequired;
    public String recurrencePeriod;
    public String currencyType;
    public Boolean allowScheduledCharges;

    //Manuall Added
    public String eid;
    public Boolean billInAdvance;
    public Boolean proratedOnCancel;
    private String[] billInAdvance_att_info = new List<String>{
      'billInAdvance'
    };
    private String[] proratedOnCancel_att_info = new List<String>{
      'proratedOnCancel'
    };
    private String[] eid_att_info = new List<String>{ 'eid' };

    private String[] priceRanges_type_info = new List<String>{
      'priceRanges',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] productUsageRules_type_info = new List<String>{
      'productUsageRules',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };

    //Manually added by Abhinav Bhatia from 1.30 version
    private String[] priceCategory_type_info = new List<String>{
      'priceCategory',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };

    private String[] fromDate_att_info = new List<String>{ 'fromDate' };
    private String[] thruDate_att_info = new List<String>{ 'thruDate' };
    private String[] priceOverride_att_info = new List<String>{
      'priceOverride'
    };
    private String[] type_x_att_info = new List<String>{ 'type' };
    private String[] allowScheduledCharges_att_info = new List<String>{
      'allowScheduledCharges'
    };
    private String[] paymentOnPurchaseRequired_att_info = new List<String>{
      'paymentOnPurchaseRequired'
    };
    private String[] recurringPaymentRequired_att_info = new List<String>{
      'recurringPaymentRequired'
    };
    private String[] recurrencePeriod_att_info = new List<String>{
      'recurrencePeriod'
    };
    private String[] currencyType_att_info = new List<String>{ 'currencyType' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'priceRanges',
      'productUsageRules',
      'priceCategory'
    };
  }
  public class AdjustmentApplication {
    public SoapApi33Domain.Adjustment accountAdjustment;
    public DateTime appliedOn;
    public Decimal amount;
    public String type_x;
    private String[] accountAdjustment_type_info = new List<String>{
      'accountAdjustment',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] appliedOn_att_info = new List<String>{ 'appliedOn' };
    private String[] amount_att_info = new List<String>{ 'amount' };
    private String[] type_x_att_info = new List<String>{ 'type' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'accountAdjustment'
    };
  }
  public class OrderItemUsageRule {
    public String status;
    private String[] status_att_info = new List<String>{ 'status' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class CommandRequest {
    public SoapApi33Domain.ApproveAction approveAction;
    public SoapApi33Domain.DenyAction denyAction;
    public SoapApi33Domain.DeactivateService deactivateService;
    public SoapApi33Domain.SuspendService suspendService;
    public SoapApi33Domain.ResumeService resumeService;
    public SoapApi33Domain.ChangeServiceCommand changeService;
    public SoapApi33Domain.ServiceCommand convertTrialService;
    public SoapApi33Domain.DeactivateBillingAccount deactivateBillingAccount;
    public SoapApi33Domain.SuspendBillingAccount suspendBillingAccount;
    public SoapApi33Domain.ResumeBillingAccount resumeBillingAccount;
    public SoapApi33Domain.GenerateReferrerToken generateReferrerToken;
    public SoapApi33Domain.GeneratePaymentCollectionReferrerToken generatePaymentCollectionReferrerToken;
    public SoapApi33Domain.DeactivateServiceResource deactivateServiceResource;
    public SoapApi33Domain.ChangeServiceResource changeServiceResource;
    public SoapApi33Domain.PostAdjustment postAdjustment;
    public SoapApi33Domain.VoidUsageEvent voidUsageEvent;
    public SoapApi33Domain.RemoveCustomFieldValueFromBillingAccount removeCustomFieldValueFromBillingAccount;
    public SoapApi33Domain.AddCustomFieldValueToBillingAccount addCustomFieldValueToBillingAccount;
    public SoapApi33Domain.RemoveCustomFieldValueFromOrder removeCustomFieldValueFromOrder;
    public SoapApi33Domain.AddCustomFieldValueToOrder addCustomFieldValueToOrder;
    public SoapApi33Domain.VoidDraftOrder voidDraftOrder;
    public SoapApi33Domain.CreateDraftOrder createDraftOrder;
    public SoapApi33Domain.ConfirmOrder confirmOrder;
    public SoapApi33Domain.ApproveOrderItem approveOrderItem;
    public SoapApi33Domain.DenyOrderItem denyOrderItem;
    public SoapApi33Domain.UpdateOpenCounters updateOpenCounters;
    public SoapApi33Domain.RemoveAdjustment removeAdjustment;
    public SoapApi33Domain.MoveBillingAccountToBillCycle moveBillingAccountToBillCycle;
    public SoapApi33Domain.ApplyPayment applyPayment;
    public SoapApi33Domain.ApplyRefund applyRefund;
    public SoapApi33Domain.AddRecurringPaymentToBillingAccount addRecurringPaymentToBillingAccount;
    public SoapApi33Domain.AddAddressToParty addAddressToParty;
    public SoapApi33Domain.AddServiceResourceToService addServiceResourceToService;
    public SoapApi33Domain.RemoveServiceResourceFromService removeServiceResourceFromService;
    public SoapApi33Domain.AddAgreementToService addAgreementToService;
    public SoapApi33Domain.RequestServiceResource requestServiceResource;
    public SoapApi33Domain.RenewService renewService;
    public SoapApi33Domain.CancelPayment cancelPayment;
    public SoapApi33Domain.ReallocatePayment reallocatePayment;
    public SoapApi33Domain.AddPersonToBillingAccount addPersonToBillingAccount;
    public SoapApi33Domain.RemovePersonFromBillingAccount removePersonFromBillingAccount;
    public SoapApi33Domain.AddServiceUsageRuleToService addServiceUsageRuleToService;
    public SoapApi33Domain.RemoveServiceUsageRuleFromService removeServiceUsageRuleFromService;
    public SoapApi33Domain.AddInvoiceApplicationToAdjustment addInvoiceApplicationToAdjustment;
    public SoapApi33Domain.RemoveCustomFieldValueFromService removeCustomFieldValueFromService;
    public SoapApi33Domain.AddCustomFieldValueToService addCustomFieldValueToService;
    public SoapApi33Domain.AddCounterToService addCounterToService;
    public SoapApi33Domain.ReverseInvoiceApplicationFromAdjustment reverseInvoiceApplicationFromAdjustment;
    public SoapApi33Domain.ReverseAdjustment reverseAdjustment;
    public SoapApi33Domain.AddDiscountIdentifierToService addDiscountIdentifierToService;
    public SoapApi33Domain.ChangeServiceQuantityCommand changeServiceQuantity;
    public SoapApi33Domain.ChangeServicePriceCommand changeServicePrice;
    public SoapApi33Domain.AddParentBillingAccount addParentBillingAccount;
    public SoapApi33Domain.RemoveParentBillingAccount removeParentBillingAccount;
    public SoapApi33Domain.ChangeParentBillingAccount changeParentBillingAccount;
    public SoapApi33Domain.AddProductUsageRuleToRecurringProductPrice addProductUsageRuleToRecurringProductPrice;
    public SoapApi33Domain.AddAgreementToProduct addAgreementToProduct;
    public SoapApi33Domain.removeAgreementFromProduct removeAgreementFromProduct;
    public SoapApi33Domain.ReverseDebitAdjustment reverseDebitAdjustment;
    public SoapApi33Domain.ActivateProduct activateProduct;
    public SoapApi33Domain.ApplyRemainingPaymentToInvoice applyRemainingPaymentToInvoice;
    public SoapApi33Domain.ChangeServiceScheduledOneTimePriceCharges changeServiceScheduledOneTimePriceCharges;
    public SoapApi33Domain.ChangeServiceScheduledCharges changeServiceScheduledCharges;
    public SoapApi33Domain.ChangeOrderItemScheduledOneTimePriceCharges changeOrderItemScheduledOneTimePriceCharges;
    public SoapApi33Domain.ChangeOrderItemScheduledCharges changeOrderItemScheduledCharges;
    public SoapApi33Domain.AddAddressToService addAddressToService;
    public SoapApi33Domain.RemoveAddressFromService removeAddressFromService;
    public SoapApi33Domain.AddDiscountIdentifierToDiscountCode addDiscountIdentifierToDiscountCode;
    public SoapApi33Domain.RemoveDiscountIdentifierFromDiscountCode removeDiscountIdentifierFromDiscountCode;
    public SoapApi33Domain.AddProductPriceToProduct addProductPriceToProduct;
    public SoapApi33Domain.CompatibleForChangeService compatibleForChangeService;
    public SOAPAPI33Domain.AddProductToPriceList addProductToPriceList;
    public SOAPAPI33Domain.RemoveProductFromPriceList removeProductFromPriceList;
    public SOAPAPI33Domain.DeleteMarketPlace deleteMarketPlace;
    public SOAPAPI33Domain.RemoveProductRelation removeProductRelation;
    private String[] removeProductRelation_type_info = new List<String>{
      'removeProductRelation',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] deleteMarketPlace_type_info = new List<String>{
      'deleteMarketPlace',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] removeProductFromPriceList_type_info = new List<String>{
      'removeProductFromPriceList',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] addProductToPriceList_type_info = new List<String>{
      'addProductToPriceList',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] compatibleForChangeService_type_info = new List<String>{
      'compatibleForChangeService',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] approveAction_type_info = new List<String>{
      'approveAction',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] denyAction_type_info = new List<String>{
      'denyAction',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] deactivateService_type_info = new List<String>{
      'deactivateService',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] convertTrialService_type_info = new List<String>{
      'convertTrialService',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] suspendService_type_info = new List<String>{
      'suspendService',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] activateProduct_type_info = new List<String>{
      'activateProduct',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] resumeService_type_info = new List<String>{
      'resumeService',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] changeService_type_info = new List<String>{
      'changeService',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] deactivateBillingAccount_type_info = new List<String>{
      'deactivateBillingAccount',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] suspendBillingAccount_type_info = new List<String>{
      'suspendBillingAccount',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] resumeBillingAccount_type_info = new List<String>{
      'resumeBillingAccount',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] addProductPriceToProduct_type_info = new List<String>{
      'addProductPriceToProduct',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] generateReferrerToken_type_info = new List<String>{
      'generateReferrerToken',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] generatePaymentCollectionReferrerToken_type_info = new List<String>{
      'generatePaymentCollectionReferrerToken',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] addAgreementToProduct_type_info = new List<String>{
      'addAgreementToProduct',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] removeAgreementFromProduct_type_info = new List<String>{
      'removeAgreementFromProduct',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] deactivateServiceResource_type_info = new List<String>{
      'deactivateServiceResource',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] changeServiceResource_type_info = new List<String>{
      'changeServiceResource',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] postAdjustment_type_info = new List<String>{
      'postAdjustment',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] voidUsageEvent_type_info = new List<String>{
      'voidUsageEvent',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] removeCustomFieldValueFromBillingAccount_type_info = new List<String>{
      'removeCustomFieldValueFromBillingAccount',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] addCustomFieldValueToBillingAccount_type_info = new List<String>{
      'addCustomFieldValueToBillingAccount',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] removeCustomFieldValueFromOrder_type_info = new List<String>{
      'removeCustomFieldValueFromOrder',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] addCustomFieldValueToOrder_type_info = new List<String>{
      'addCustomFieldValueToOrder',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] voidDraftOrder_type_info = new List<String>{
      'voidDraftOrder',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] createDraftOrder_type_info = new List<String>{
      'createDraftOrder',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] confirmOrder_type_info = new List<String>{
      'confirmOrder',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] approveOrderItem_type_info = new List<String>{
      'approveOrderItem',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] denyOrderItem_type_info = new List<String>{
      'denyOrderItem',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] updateOpenCounters_type_info = new List<String>{
      'updateOpenCounters',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] removeAdjustment_type_info = new List<String>{
      'removeAdjustment',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] moveBillingAccountToBillCycle_type_info = new List<String>{
      'moveBillingAccountToBillCycle',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] applyPayment_type_info = new List<String>{
      'applyPayment',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] applyRefund_type_info = new List<String>{
      'applyRefund',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] addRecurringPaymentToBillingAccount_type_info = new List<String>{
      'addRecurringPaymentToBillingAccount',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] addAddressToParty_type_info = new List<String>{
      'addAddressToParty',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] addServiceResourceToService_type_info = new List<String>{
      'addServiceResourceToService',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] removeServiceResourceFromService_type_info = new List<String>{
      'removeServiceResourceFromService',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] addAgreementToService_type_info = new List<String>{
      'addAgreementToService',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] requestServiceResource_type_info = new List<String>{
      'requestServiceResource',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] renewService_type_info = new List<String>{
      'renewService',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] cancelPayment_type_info = new List<String>{
      'cancelPayment',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] reallocatePayment_type_info = new List<String>{
      'reallocatePayment',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] addPersonToBillingAccount_type_info = new List<String>{
      'addPersonToBillingAccount',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] removePersonFromBillingAccount_type_info = new List<String>{
      'removePersonFromBillingAccount',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] addServiceUsageRuleToService_type_info = new List<String>{
      'addServiceUsageRuleToService',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] removeServiceUsageRuleFromService_type_info = new List<String>{
      'removeServiceUsageRuleFromService',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] addInvoiceApplicationToAdjustment_type_info = new List<String>{
      'addInvoiceApplicationToAdjustment',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] removeCustomFieldValueFromService_type_info = new List<String>{
      'removeCustomFieldValueFromService',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] addCustomFieldValueToService_type_info = new List<String>{
      'addCustomFieldValueToService',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] addCounterToService_type_info = new List<String>{
      'addCounterToService',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] reverseInvoiceApplicationFromAdjustment_type_info = new List<String>{
      'reverseInvoiceApplicationFromAdjustment',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] reverseAdjustment_type_info = new List<String>{
      'reverseAdjustment',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] addDiscountIdentifierToService_type_info = new List<String>{
      'addDiscountIdentifierToService',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] changeServiceQuantity_type_info = new List<String>{
      'changeServiceQuantity',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] changeServicePrice_type_info = new List<String>{
      'changeServicePrice',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] addParentBillingAccount_type_info = new List<String>{
      'addParentBillingAccount',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] removeParentBillingAccount_type_info = new List<String>{
      'removeParentBillingAccount',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] changeParentBillingAccount_type_info = new List<String>{
      'changeParentBillingAccount',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] addProductUsageRuleToRecurringProductPrice_type_info = new List<String>{
      'addProductUsageRuleToRecurringProductPrice',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] reverseDebitAdjustment_type_info = new List<String>{
      'reverseDebitAdjustment',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] applyRemainingPaymentToInvoice_type_info = new List<String>{
      'applyRemainingPaymentToInvoice',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] changeServiceScheduledOneTimePriceCharges_type_info = new List<String>{
      'changeServiceScheduledOneTimePriceCharges',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] changeServiceScheduledCharges_type_info = new List<String>{
      'changeServiceScheduledCharges',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] changeOrderItemScheduledOneTimePriceCharges_type_info = new List<String>{
      'changeOrderItemScheduledOneTimePriceCharges',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] changeOrderItemScheduledCharges_type_info = new List<String>{
      'changeOrderItemScheduledCharges',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] addAddressToService_type_info = new List<String>{
      'addAddressToService',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] removeAddressFromService_type_info = new List<String>{
      'removeAddressFromService',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] addDiscountIdentifierToDiscountCode_type_info = new List<String>{
      'addDiscountIdentifierToDiscountCode',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] removeDiscountIdentifierFromDiscountCode_type_info = new List<String>{
      'removeDiscountIdentifierFromDiscountCode',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'compatibleForChangeService',
      'addProductPriceToProduct',
      'activateProduct',
      'approveAction',
      'denyAction',
      'addAgreementToProduct',
      'removeAgreementFromProduct',
      'deactivateService',
      'convertTrialService',
      'suspendService',
      'resumeService',
      'changeService',
      'deactivateBillingAccount',
      'suspendBillingAccount',
      'resumeBillingAccount',
      'generateReferrerToken',
      'generatePaymentCollectionReferrerToken',
      'deactivateServiceResource',
      'changeServiceResource',
      'postAdjustment',
      'voidUsageEvent',
      'removeCustomFieldValueFromBillingAccount',
      'addCustomFieldValueToBillingAccount',
      'removeCustomFieldValueFromOrder',
      'addCustomFieldValueToOrder',
      'voidDraftOrder',
      'createDraftOrder',
      'confirmOrder',
      'approveOrderItem',
      'denyOrderItem',
      'updateOpenCounters',
      'removeAdjustment',
      'moveBillingAccountToBillCycle',
      'applyPayment',
      'applyRefund',
      'addRecurringPaymentToBillingAccount',
      'addAddressToParty',
      'addServiceResourceToService',
      'removeServiceResourceFromService',
      'addAgreementToService',
      'requestServiceResource',
      'renewService',
      'cancelPayment',
      'reallocatePayment',
      'addPersonToBillingAccount',
      'removePersonFromBillingAccount',
      'addServiceUsageRuleToService',
      'removeServiceUsageRuleFromService',
      'addInvoiceApplicationToAdjustment',
      'removeCustomFieldValueFromService',
      'addCustomFieldValueToService',
      'addCounterToService',
      'reverseInvoiceApplicationFromAdjustment',
      'reverseAdjustment',
      'addDiscountIdentifierToService',
      'changeServiceQuantity',
      'changeServicePrice',
      'addParentBillingAccount',
      'removeParentBillingAccount',
      'changeParentBillingAccount',
      'reverseDebitAdjustment',
      'applyRemainingPaymentToInvoice',
      'changeServiceScheduledOneTimePriceCharges',
      'changeServiceScheduledCharges',
      'changeOrderItemScheduledOneTimePriceCharges',
      'changeOrderItemScheduledCharges',
      'addAddressToService',
      'removeAddressFromService',
      'addDiscountIdentifierToDiscountCode',
      'removeDiscountIdentifierFromDiscountCode',
      'addProductToPriceList',
      'removeProductFromPriceList',
      'deleteMarketPlace',
      'removeProductRelation',
      'addProductUsageRuleToRecurringProductPrice'
    };
  }
  public class AddAgreementToProduct {
    public SoapApi33Domain.Agreement relatedAgreement;
    public SoapApi33Domain.Product product;
    private String[] product_type_info = new List<String>{
      'product',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] relatedAgreement_type_info = new List<String>{
      'relatedAgreement',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'relatedAgreement',
      'product'
    };
  }
  public class AddProductUsageRuleToRecurringProductPrice {
    public SoapApi33Domain.MatchAllProductUsageRule matchAllProductUsageRule;
    public SoapApi33Domain.FormulaProductUsageRule formulaProductUsageRule;
    public SoapApi33Domain.GlobalProductUsageRule globalProductUsageRule;
    public SoapApi33Domain.RecurringProductPrice recurringPrice;
    private String[] recurringPrice_type_info = new List<String>{
      'recurringPrice',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] matchAllProductUsageRule_type_info = new List<String>{
      'matchAllProductUsageRule',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] formulaProductUsageRule_type_info = new List<String>{
      'formulaProductUsageRule',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] globalProductUsageRule_type_info = new List<String>{
      'globalProductUsageRule',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'matchAllProductUsageRule',
      'formulaProductUsageRule',
      'globalProductUsageRule',
      'recurringPrice'
    };
  }
  public class removeAgreementFromProduct {
    public SoapApi33Domain.Agreement relatedAgreement;
    public SoapApi33Domain.Product product;
    private String[] product_type_info = new List<String>{
      'product',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] relatedAgreement_type_info = new List<String>{
      'relatedAgreement',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'relatedAgreement',
      'product'
    };
  }
  public class AddProductPriceToProduct {
    public SoapApi33Domain.RecurringProductPrice recurringProductPrice;
    public SoapApi33Domain.OneTimeProductPrice oneTimeProductPrice;
    public SoapApi33Domain.PriceList priceList;
    public SoapApi33Domain.Product product;
    private String[] product_type_info = new List<String>{
      'product',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] recurringProductPrice_type_info = new List<String>{
      'recurringProductPrice',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] oneTimeProductPrice_type_info = new List<String>{
      'oneTimeProductPrice',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] priceList_type_info = new List<String>{
      'priceList',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'recurringProductPrice',
      'oneTimeProductPrice',
      'priceList',
      'product'
    };
  }
  public class ActivateProduct {
    public SoapApi33Domain.Product product;
    private String[] product_type_info = new List<String>{
      'product',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'product' };
  }
  public class SegmentedMonthlyBillCycle {
    public SoapApi33Domain.BillingAccountCategory billingAccountCategory;
    private String[] billingAccountCategory_type_info = new List<String>{
      'billingAccountCategory',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    public String daysOfMonth;
    private String[] daysOfMonth_att_info = new List<String>{ 'daysOfMonth' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'billingAccountCategory'
    };

    /* @Jrathore - From line below to next blank line copied
     *  from BillCycle Apex Class generated above to process
     *  response received from Tract.
     */
    public String eid;
    public String name;
    public DateTime startDate;
    public DateTime endDate;
    public String billCycleType;
    public Boolean autoBill;
    public Boolean usePaymentTerm;
    public String status;
    public String currencyType;
    private String[] eid_att_info = new List<String>{ 'eid' };
    private String[] name_att_info = new List<String>{ 'name' };
    private String[] startDate_att_info = new List<String>{ 'startDate' };
    private String[] endDate_att_info = new List<String>{ 'endDate' };
    private String[] billCycleType_att_info = new List<String>{
      'billCycleType'
    };
    private String[] autoBill_att_info = new List<String>{ 'autoBill' };
    private String[] usePaymentTerm_att_info = new List<String>{
      'usePaymentTerm'
    };
    private String[] status_att_info = new List<String>{ 'status' };
    private String[] currencyType_att_info = new List<String>{ 'currencyType' };
    //private String[] apex_schema_type_info = new String[]{'http://www.tractbilling.com/billing/1_33/domain','true','false'};
    //private String[] field_order_type_info = new String[]{};

    /** @jrathore - Commenting out as duplicate
        private String[] apex_schema_type_info = new String[]{'http://www.tractbilling.com/billing/1_33/domain','true','false'};
        private String[] field_order_type_info = new String[]{};
        */
  }

  //Added manually for 1.30 version by Abhinav Bhatia
  public class CustomFieldValueReference {
    public String status;
    public SoapApi33Domain.CustomField customField;
    public String value;
    public String eid;
    private String[] status_type_info = new List<String>{
      'status',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] customField_type_info = new List<String>{
      'customField',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] value_att_info = new List<String>{ 'value' };
    private String[] eid_att_info = new List<String>{ 'eid' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'status',
      'customField'
    };
  }
  public class TaxInvoiceItems {
    public SoapApi33Domain.TaxInvoiceItem[] taxInvoiceItem;
    private String[] taxInvoiceItem_type_info = new List<String>{
      'taxInvoiceItem',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'taxInvoiceItem'
    };
  }
  public class BuildableDataQuery {
    public SoapApi33Domain.ProductQuery productQuery;
    public SoapApi33Domain.ServiceQuery serviceQuery;
    public SoapApi33Domain.AgreementQuery agreementQuery;
    public SoapApi33Domain.PromotionQuery promotionQuery;
    public Integer pageNumber;
    public Integer pageSize;
    private String[] productQuery_type_info = new List<String>{
      'productQuery',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] serviceQuery_type_info = new List<String>{
      'serviceQuery',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] agreementQuery_type_info = new List<String>{
      'agreementQuery',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] promotionQuery_type_info = new List<String>{
      'promotionQuery',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] pageNumber_att_info = new List<String>{ 'pageNumber' };
    private String[] pageSize_att_info = new List<String>{ 'pageSize' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'productQuery',
      'serviceQuery',
      'agreementQuery',
      'promotionQuery'
    };
  }
  public class ApplyRemainingPaymentToInvoice {
    public SoapApi33Domain.Payment payment;
    public SoapApi33Domain.Invoice invoice;
    public Decimal amount;
    private String[] payment_type_info = new List<String>{
      'payment',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] invoice_type_info = new List<String>{
      'invoice',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] amount_att_info = new List<String>{ 'amount' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'payment',
      'invoice'
    };
  }
  public class UsageEventCounter {
    public Integer event;
    public Integer threshold;
    private String[] event_att_info = new List<String>{ 'event' };
    private String[] threshold_att_info = new List<String>{ 'threshold' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class MatchAllOrderItemUsageRule {
    public String status;
    public String usageUom;
    public String name;
    public String rollOverType;
    public String eid;
    public String ruleType;
    public String allowanceType;
    public String order;
    public Double limit_x;
    public Boolean proratedOnOrder;
    public Boolean proratedOnCancel;
    private String[] status_att_info = new List<String>{ 'status' };
    private String[] usageUom_att_info = new List<String>{ 'usageUom' };
    private String[] name_att_info = new List<String>{ 'name' };
    private String[] rollOverType_att_info = new List<String>{ 'rollOverType' };
    private String[] eid_att_info = new List<String>{ 'eid' };
    private String[] ruleType_att_info = new List<String>{ 'ruleType' };
    private String[] allowanceType_att_info = new List<String>{
      'allowanceType'
    };
    private String[] order_att_info = new List<String>{ 'order' };
    private String[] limit_x_att_info = new List<String>{ 'limit' };
    private String[] proratedOnOrder_att_info = new List<String>{
      'proratedOnOrder'
    };
    private String[] proratedOnCancel_att_info = new List<String>{
      'proratedOnCancel'
    };

    public SoapApi33Domain.MatchAllProductUsageRule matchAllProductUsageRule;

    public SoapApi33Domain.ChargeCategory chargeCategory;
    public SoapApi33Domain.FlatUsageRate flatUsageRate;
    public SoapApi33Domain.TableUsageRate tableUsageRate;
    public SoapApi33Domain.RateTable rateTable;
    public SoapApi33Domain.PassThroughUsageRate passThroughUsageRate;
    public SoapApi33Domain.RateTableEntries rateTableEntries;
    private String[] matchAllProductUsageRule_type_info = new List<String>{
      'matchAllProductUsageRule',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] chargeCategory_type_info = new List<String>{
      'chargeCategory',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] flatUsageRate_type_info = new List<String>{
      'flatUsageRate',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] tableUsageRate_type_info = new List<String>{
      'tableUsageRate',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] rateTable_type_info = new List<String>{
      'rateTable',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] passThroughUsageRate_type_info = new List<String>{
      'passThroughUsageRate',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] rateTableEntries_type_info = new List<String>{
      'rateTableEntries',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'matchAllProductUsageRule',
      'chargeCategory',
      'flatUsageRate',
      'tableUsageRate',
      'rateTable',
      'passThroughUsageRate',
      'rateTableEntries'
    };
  }
  public class Refunds {
    public SoapApi33Domain.Refund[] refund;
    private String[] refund_type_info = new List<String>{
      'refund',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'refund' };
  }
  public class AddServiceResourceToService {
    public SoapApi33Domain.ServiceResource serviceResource;
    public SoapApi33Domain.Service service;
    public Date effectiveDate;
    private String[] serviceResource_type_info = new List<String>{
      'serviceResource',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] service_type_info = new List<String>{
      'service',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] effectiveDate_att_info = new List<String>{
      'effectiveDate'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'serviceResource',
      'service'
    };
  }
  public class SalesOrderCommand {
    public SoapApi33Domain.SalesOrder salesOrder;
    private String[] salesOrder_type_info = new List<String>{
      'salesOrder',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'salesOrder' };
  }
  public class GeneratePaymentCollectionReferrerToken {
    public String errorUrl;
    public String cancelUrl;
    public String completeUrl;
    private String[] errorUrl_type_info = new List<String>{
      'errorUrl',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] cancelUrl_type_info = new List<String>{
      'cancelUrl',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] completeUrl_type_info = new List<String>{
      'completeUrl',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'errorUrl',
      'cancelUrl',
      'completeUrl'
    };
  }
  public class ResumeService {
    public SoapApi33Domain.Service service;
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] service_type_info = new List<String>{
      'service',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'service' };
  }
  public class OrderCommandResponse {
    public Long eid;
    private String[] eid_att_info = new List<String>{ 'eid' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'eid' };
  }
  public class CreditCardPaymentMethod {
    public String cardType;
    public String cardHolderFirstName;
    public String cardHolderMiddleName;
    public String cardHolderLastName;
    public String cardHolderSuffix;
    public String cardIdentifierNumber;
    public String cardVerificationNumber;
    public String cardExpiration;
    public SoapApi33Domain.CustomFieldValues customFieldValues;
    public SoapApi33Domain.PostalAddress postalAddress;
    public SoapApi33Domain.EmailAddress emailAddress;
    public SoapApi33Domain.TelecomAddress telecomAddress;
    public String nickname;
    public String eid;
    private String[] eid_att_info = new List<String>{ 'eid' };
    private String[] nickname_att_info = new List<String>{ 'nickname' };
    private String[] telecomAddress_type_info = new List<String>{
      'telecomAddress',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] emailAddress_type_info = new List<String>{
      'emailAddress',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] postalAddress_type_info = new List<String>{
      'postalAddress',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] customFieldValues_type_info = new List<String>{
      'customFieldValues',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] cardType_att_info = new List<String>{ 'cardType' };
    private String[] cardHolderFirstName_att_info = new List<String>{
      'cardHolderFirstName'
    };
    private String[] cardHolderMiddleName_att_info = new List<String>{
      'cardHolderMiddleName'
    };
    private String[] cardHolderLastName_att_info = new List<String>{
      'cardHolderLastName'
    };
    private String[] cardHolderSuffix_att_info = new List<String>{
      'cardHolderSuffix'
    };
    private String[] cardIdentifierNumber_att_info = new List<String>{
      'cardIdentifierNumber'
    };
    private String[] cardVerificationNumber_att_info = new List<String>{
      'cardVerificationNumber'
    };
    private String[] cardExpiration_att_info = new List<String>{
      'cardExpiration'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class BillingAccountActionCommand {
    public DateTime startDate;
    public String notes;
    private String[] startDate_type_info = new List<String>{
      'startDate',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] notes_type_info = new List<String>{
      'notes',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'startDate',
      'notes'
    };
  }
  //Manually added by Abhinav Bhatia from 1.30 version
  public class TerminationChargeAdjustmentItem {
    public SoapApi33Domain.Service service;
    public SoapApi33Domain.Adjustment adjustment;
    public SoapApi33Domain.AdjustmentReason reason;
    public SoapApi33Domain.AdjustmentReason secondaryReason;
    public SoapApi33Domain.AdjustmentCategory category;
    private String[] adjustment_type_info = new List<String>{
      'adjustment',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] reason_type_info = new List<String>{
      'reason',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] secondaryReason_type_info = new List<String>{
      'secondaryReason',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] category_type_info = new List<String>{
      'category',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] service_type_info = new List<String>{
      'service',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'service',
      'adjustment',
      'reason',
      'secondaryReason',
      'category'
    };
  }
  public class AuthorizationResponse {
    public Boolean successful;
    private String[] successful_att_info = new List<String>{ 'successful' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class ReverseAdjustment {
    public Boolean fullAmount;
    private String[] fullAmount_att_info = new List<String>{ 'fullAmount' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class TaxOrderItem {
    public Decimal total;

    public SoapApi33Domain.OrderItems orderItems;
    public SoapApi33Domain.OrderItemUsageRules orderItemUsageRules;

    private String[] total_att_info = new List<String>{ 'total' };

    private String[] orderItems_type_info = new List<String>{
      'orderItems',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] orderItemUsageRules_type_info = new List<String>{
      'orderItemUsageRules',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'orderItems',
      'orderItemUsageRules'
    };
  }
  public class DiscountConfigurations {
    public SoapApi33Domain.DiscountConfiguration[] discountConfiguration;
    public Long totalElements;
    private String[] discountConfiguration_type_info = new List<String>{
      'discountConfiguration',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] totalElements_att_info = new List<String>{
      'totalElements'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'discountConfiguration'
    };
  }
  public class RemoveAdjustment {
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class BillingAccountSegment {
    public SoapApi33Domain.BillingAccountSegmentFields billingAccountSegmentFields;
    public String name;
    public String description;
    public String status;
    private String[] billingAccountSegmentFields_type_info = new List<String>{
      'billingAccountSegmentFields',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] name_att_info = new List<String>{ 'name' };
    private String[] description_att_info = new List<String>{ 'description' };
    private String[] status_att_info = new List<String>{ 'status' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'billingAccountSegmentFields'
    };
  }
  public class ServicePriceRanges {
    public SoapApi33Domain.ServicePriceRange[] servicePriceRange;
    private String[] servicePriceRange_type_info = new List<String>{
      'servicePriceRange',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'servicePriceRange'
    };
  }
  public class AdjustmentCategory {
    public String name;
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] name_att_info = new List<String>{ 'name' };
    private String[] field_order_type_info = new List<String>{};
  }
  public class ChangeServicePriceCommand {
    public Decimal newRecurringUnitPrice;
    private String[] newRecurringUnitPrice_att_info = new List<String>{
      'newRecurringUnitPrice'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class AddCounterToService {
    public SoapApi33Domain.UsageRuleCounter usageRuleCounter;
    public SoapApi33Domain.UsageEventCounter usageEventCounter;
    public SoapApi33Domain.UsageChargeCounter usageChargeCounter;
    private String[] usageRuleCounter_type_info = new List<String>{
      'usageRuleCounter',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] usageEventCounter_type_info = new List<String>{
      'usageEventCounter',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] usageChargeCounter_type_info = new List<String>{
      'usageChargeCounter',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'usageRuleCounter',
      'usageEventCounter',
      'usageChargeCounter'
    };
  }
  public class UsagePriceCategories {
    public SoapApi33Domain.UsagePriceCategory[] usagePriceCategory;
    private String[] usagePriceCategory_type_info = new List<String>{
      'usagePriceCategory',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'usagePriceCategory'
    };
  }
  public class MonthlyBillCycle {
    public SoapApi33Domain.BillingAccountCategory billingAccountCategory;
    private String[] billingAccountCategory_type_info = new List<String>{
      'billingAccountCategory',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    public Integer dayOfMonth;
    private String[] dayOfMonth_att_info = new List<String>{ 'dayOfMonth' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'billingAccountCategory'
    };

    /* @Jrathore - From line below to next blank line copied
     *  from BillCycle Apex Class generated above to process
     *  response received from Tract.
     */
    public String eid;
    public String name;
    public DateTime startDate;
    public DateTime endDate;
    public String billCycleType;
    public Boolean autoBill;
    public Boolean usePaymentTerm;
    public String status;
    public String currencyType;
    private String[] eid_att_info = new List<String>{ 'eid' };
    private String[] name_att_info = new List<String>{ 'name' };
    private String[] startDate_att_info = new List<String>{ 'startDate' };
    private String[] endDate_att_info = new List<String>{ 'endDate' };
    private String[] billCycleType_att_info = new List<String>{
      'billCycleType'
    };
    private String[] autoBill_att_info = new List<String>{ 'autoBill' };
    private String[] usePaymentTerm_att_info = new List<String>{
      'usePaymentTerm'
    };
    private String[] status_att_info = new List<String>{ 'status' };
    private String[] currencyType_att_info = new List<String>{ 'currencyType' };
    //private String[] apex_schema_type_info = new String[]{'http://www.tractbilling.com/billing/1_33/domain','true','false'};
    //private String[] field_order_type_info = new String[]{};

    /** @jrathore - Commenting Out as duplicate.
        
        private String[] apex_schema_type_info = new String[]{'http://www.tractbilling.com/billing/1_33/domain','true','false'};
        private String[] field_order_type_info = new String[]{};
        */
  }
  public class ChangeServiceCommand {
    public SoapApi33Domain.SalesOrder order;
    //public SoapApi33Domain.Order order;
    public SoapApi33Domain.Service service;
    public Boolean preserveAgreement;
    public String effectiveDate;
    public Boolean payOnPurchase;
    //private String[] salesorder_type_info = new String[]{'salesorder','http://www.tractbilling.com/billing/1_33/domain',null,'0','1','false'};
    private String[] order_type_info = new List<String>{
      'order',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] service_type_info = new List<String>{
      'service',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] preserveAgreement_att_info = new List<String>{
      'preserveAgreement'
    };
    private String[] effectiveDate_att_info = new List<String>{
      'effectiveDate'
    };
    private String[] payOnPurchase_att_info = new List<String>{
      'payOnPurchase'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'order',
      'service'
    };
  }
  public class UsageInvoiceItems {
    public SoapApi33Domain.UsageInvoiceItem[] usageInvoiceItem;
    private String[] usageInvoiceItem_type_info = new List<String>{
      'usageInvoiceItem',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'usageInvoiceItem'
    };
  }
  public class DailyBillCycle {
    public SoapApi33Domain.BillingAccountCategory billingAccountCategory;
    private String[] billingAccountCategory_type_info = new List<String>{
      'billingAccountCategory',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'billingAccountCategory'
    };
    public String eid;
    public String name;
    public DateTime startDate;
    public DateTime endDate;
    public String billCycleType;
    public Boolean autoBill;
    public Boolean usePaymentTerm;
    public String status;
    public String currencyType;
    private String[] eid_att_info = new List<String>{ 'eid' };
    private String[] name_att_info = new List<String>{ 'name' };
    private String[] startDate_att_info = new List<String>{ 'startDate' };
    private String[] endDate_att_info = new List<String>{ 'endDate' };
    private String[] billCycleType_att_info = new List<String>{
      'billCycleType'
    };
    private String[] autoBill_att_info = new List<String>{ 'autoBill' };
    private String[] usePaymentTerm_att_info = new List<String>{
      'usePaymentTerm'
    };
    private String[] status_att_info = new List<String>{ 'status' };
    private String[] currencyType_att_info = new List<String>{ 'currencyType' };
    //private String[] apex_schema_type_info = new String[]{'http://www.tractbilling.com/billing/1_33/domain','true','false'};
    //private String[] field_order_type_info = new String[]{};
  }
  public class Promotions {
    public SoapApi33Domain.Promotion[] promotion;
    private String[] promotion_type_info = new List<String>{
      'promotion',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'promotion' };
  }
  public class ServicePeriod {
    public SoapApi33Domain.Service service;
    public SoapApi33Domain.UsageRules usageRules;
    public SoapApi33Domain.UsageEvents usageEvents;
    public DateTime start;
    public DateTime end_x;
    public Boolean closed;
    private String[] service_type_info = new List<String>{
      'service',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] usageRules_type_info = new List<String>{
      'usageRules',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] usageEvents_type_info = new List<String>{
      'usageEvents',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] start_att_info = new List<String>{ 'start' };
    private String[] end_x_att_info = new List<String>{ 'end' };
    private String[] closed_att_info = new List<String>{ 'closed' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'service',
      'usageRules',
      'usageEvents'
    };
  }
  public class PostalAddress {
    public String purpose;
    public String country;
    public String city;
    public String regionOrState;
    public String attention;
    public String postalCode;
    public String line1;
    public String line2;
    private String[] purpose_att_info = new List<String>{ 'purpose' };
    private String[] country_att_info = new List<String>{ 'country' };
    private String[] city_att_info = new List<String>{ 'city' };
    private String[] regionOrState_att_info = new List<String>{
      'regionOrState'
    };
    private String[] attention_att_info = new List<String>{ 'attention' };
    private String[] postalCode_att_info = new List<String>{ 'postalCode' };
    private String[] line1_att_info = new List<String>{ 'line1' };
    private String[] line2_att_info = new List<String>{ 'line2' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class ServiceDeviceInventoryItem {
    public SoapApi33Domain.ServiceResource serviceResource;
    private String[] serviceResource_type_info = new List<String>{
      'serviceResource',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'serviceResource'
    };
  }
  public class Payments {
    public SoapApi33Domain.Payment[] payment;
    /* Added manually to get the details for pages */
    public Integer pageNumber;
    public Integer pageSize;
    public Long totalElements;
    public Integer elementCount;
    public Integer totalPages;
    private String[] pageNumber_att_info = new List<String>{ 'pageNumber' };
    private String[] pageSize_att_info = new List<String>{ 'pageSize' };
    private String[] totalElements_att_info = new List<String>{
      'totalElements'
    };
    private String[] elementCount_att_info = new List<String>{ 'elementCount' };
    private String[] totalPages_att_info = new List<String>{ 'totalPages' };

    private String[] payment_type_info = new List<String>{
      'payment',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'payment' };
  }
  public class GLAccountCategories {
    public SoapApi33Domain.GLAccountCategory[] glAccountCategory;
    private String[] glAccountCategory_type_info = new List<String>{
      'glAccountCategory',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'glAccountCategory'
    };
  }

  public class GLInvoiceAccountingTransaction {
    public SoapApi33Domain.Invoice invoice;
    private String[] invoice_type_info = new List<String>{
      'invoice',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'invoice' };
  }
  public class CustomFieldValues {
    public SoapApi33Domain.CustomFieldValue[] customFieldValue;
    private String[] customFieldValue_type_info = new List<String>{
      'customFieldValue',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'customFieldValue'
    };
  }
  public class CancelPayment {
    public SoapApi33Domain.Payment payment;
    public SoapApi33Domain.RefundReason reason;
    public String description;
    public Boolean partial;
    public String occurredOn;
    private String[] payment_type_info = new List<String>{
      'payment',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] reason_type_info = new List<String>{
      'reason',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] description_att_info = new List<String>{ 'description' };
    private String[] partial_att_info = new List<String>{ 'partial' };
    private String[] occurredOn_att_info = new List<String>{ 'occurredOn' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'payment',
      'reason'
    };
  }
  public class ChargeCategory {
    public String name;
    public String description;
    public Long priority;
    public String status;
    public String eid;
    private String[] name_att_info = new List<String>{ 'name' };
    private String[] description_att_info = new List<String>{ 'description' };
    private String[] priority_att_info = new List<String>{ 'priority' };
    private String[] status_att_info = new List<String>{ 'status' };
    private String[] eid_att_info = new List<String>{ 'eid' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class TelecomAddress {
    public String purpose;
    public String dialingPrefix;
    public String countryCode;
    public String areaCode;
    public String number_x;
    public String extension;
    private String[] purpose_att_info = new List<String>{ 'purpose' };
    private String[] dialingPrefix_att_info = new List<String>{
      'dialingPrefix'
    };
    private String[] countryCode_att_info = new List<String>{ 'countryCode' };
    private String[] areaCode_att_info = new List<String>{ 'areaCode' };
    private String[] number_x_att_info = new List<String>{ 'number' };
    private String[] extension_att_info = new List<String>{ 'extension' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class Address {
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class ReversedInvoiceAdjustmentApplications {
    public SoapApi33Domain.ReversedInvoiceAdjustmentApplication[] reversedInvoiceAdjustmentApplication;
    private String[] reversedInvoiceAdjustmentApplication_type_info = new List<String>{
      'reversedInvoiceAdjustmentApplication',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'reversedInvoiceAdjustmentApplication'
    };
  }
  public class abstractDiscountCodeServiceBillingAccount {
    public SoapApi33Domain.DiscountCode discountCode;
    public SoapApi33Domain.DiscountIdentifier discountIdentifier;
    public DateTime validFrom;
    public DateTime validTo;
    public Integer duration;
    public Decimal amount;
    public Decimal percentage;
    private String[] discountCode_type_info = new List<String>{
      'discountCode',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] discountIdentifier_type_info = new List<String>{
      'discountIdentifier',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] validFrom_att_info = new List<String>{ 'validFrom' };
    private String[] validTo_att_info = new List<String>{ 'validTo' };
    private String[] duration_att_info = new List<String>{ 'duration' };
    private String[] amount_att_info = new List<String>{ 'amount' };
    private String[] percentage_att_info = new List<String>{ 'percentage' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'discountCode',
      'discountIdentifier'
    };
  }
  //Manually addded by Abhinav Bhatia from Api version 1.30
  public class TrueUpChargeTypes {
    public String[] trueUpChargeType;
    private String[] trueUpChargeType_type_info = new List<String>{
      'trueUpChargeType',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'trueUpChargeType'
    };
  }
  public class ServicePeriods {
    public SoapApi33Domain.ServicePeriod[] servicePeriod;
    private String[] servicePeriod_type_info = new List<String>{
      'servicePeriod',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'servicePeriod'
    };
  }
  public class ProductInvoiceItems {
    public SoapApi33Domain.ProductInvoiceItem[] productInvoiceItem;
    private String[] productInvoiceItem_type_info = new List<String>{
      'productInvoiceItem',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'productInvoiceItem'
    };
  }
  public class DiscountChargeCategory {
    public String name;
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] name_att_info = new List<String>{ 'name' };
    private String[] field_order_type_info = new List<String>{};
  }
  /*public class Person {
        public SoapApi33Domain.PartyCategory category;
        public String firstName;
        public String lastName;
        public String middleName;
        public String suffix;
        public Date dob;
        public String company;
        public String department;
        public String title;
        private String[] category_type_info = new String[]{'category','http://www.tractbilling.com/billing/1_33/domain',null,'0','1','false'};
        private String[] firstName_att_info = new String[]{'firstName'};
        private String[] lastName_att_info = new String[]{'lastName'};
        private String[] middleName_att_info = new String[]{'middleName'};
        private String[] suffix_att_info = new String[]{'suffix'};
        private String[] dob_att_info = new String[]{'dob'};
        private String[] company_att_info = new String[]{'company'};
        private String[] department_att_info = new String[]{'department'};
        private String[] title_att_info = new String[]{'title'};
        private String[] apex_schema_type_info = new String[]{'http://www.tractbilling.com/billing/1_33/domain','true','false'};
        private String[] field_order_type_info = new String[]{'category'};
    }*/
  public class Person extends Party {
    public SoapApi33Domain.addresses_element addresses;
    public String taxIdNumber;
    public SoapApi33Domain.PartyCategory category;
    public String firstName;
    public String lastName;
    public String middleName;
    public String suffix;
    public Date dob;
    public String company;
    public String department;
    public String title;
    private String[] category_type_info = new List<String>{
      'category',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] firstName_att_info = new List<String>{ 'firstName' };
    private String[] lastName_att_info = new List<String>{ 'lastName' };
    private String[] middleName_att_info = new List<String>{ 'middleName' };
    private String[] suffix_att_info = new List<String>{ 'suffix' };
    private String[] dob_att_info = new List<String>{ 'dob' };
    private String[] company_att_info = new List<String>{ 'company' };
    private String[] department_att_info = new List<String>{ 'department' };
    private String[] title_att_info = new List<String>{ 'title' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'addresses',
      'category'
    };

    /* Copied from Party.
     *  SFDC does not support complex object yet.
     */

    private String[] addresses_type_info = new List<String>{
      'addresses',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] taxIdNumber_att_info = new List<String>{ 'taxIdNumber' };
  }
  public class BillingAccountSegmentField {
    public SoapApi33Domain.BillingAccountSegment billingAccountSegment;
    public String billingAccountSegmentFieldType;
    public String name;
    public Boolean required;
    private String[] billingAccountSegment_type_info = new List<String>{
      'billingAccountSegment',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] billingAccountSegmentFieldType_att_info = new List<String>{
      'billingAccountSegmentFieldType'
    };
    private String[] name_att_info = new List<String>{ 'name' };
    private String[] required_att_info = new List<String>{ 'required' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'billingAccountSegment'
    };
  }
  public class ServiceResourceCategory {
    public String name;
    public String type_x;
    public String status;
    //Tract - Manually Added.
    public String eid;
    private String[] eid_att_info = new List<String>{ 'eid' };
    private String[] name_att_info = new List<String>{ 'name' };
    private String[] type_x_att_info = new List<String>{ 'type' };
    private String[] status_att_info = new List<String>{ 'status' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class Adjustments {
    public SoapApi33Domain.Adjustment[] adjustment;
    /* Added manually to get the details for pages */
    public Integer pageNumber;
    public Integer pageSize;
    public Long totalElements;
    public Integer elementCount;
    public Integer totalPages;
    private String[] pageNumber_att_info = new List<String>{ 'pageNumber' };
    private String[] pageSize_att_info = new List<String>{ 'pageSize' };
    private String[] totalElements_att_info = new List<String>{
      'totalElements'
    };
    private String[] elementCount_att_info = new List<String>{ 'elementCount' };
    private String[] totalPages_att_info = new List<String>{ 'totalPages' };

    private String[] adjustment_type_info = new List<String>{
      'adjustment',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'adjustment' };
  }
  public class Operation {
    public String name;
    public Boolean enabled;
    private String[] name_att_info = new List<String>{ 'name' };
    private String[] enabled_att_info = new List<String>{ 'enabled' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  /*public class Products {
        public SoapApi33Domain.Product[] product;
        private String[] product_type_info = new String[]{'product','http://www.tractbilling.com/billing/1_33/domain',null,'0','-1','false'};
        private String[] apex_schema_type_info = new String[]{'http://www.tractbilling.com/billing/1_33/domain','true','false'};
        private String[] field_order_type_info = new String[]{'product'};
    }*/
  public class Products {
    public Integer pageNumber;
    public Integer pageSize;
    public Long totalElements;
    public Integer elementCount;
    public Integer totalPages;
    private String[] pageNumber_att_info = new List<String>{ 'pageNumber' };
    private String[] pageSize_att_info = new List<String>{ 'pageSize' };
    private String[] totalElements_att_info = new List<String>{
      'totalElements'
    };
    private String[] elementCount_att_info = new List<String>{ 'elementCount' };
    private String[] totalPages_att_info = new List<String>{ 'totalPages' };

    public SoapApi33Domain.Product[] product;
    private String[] product_type_info = new List<String>{
      'product',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'product' };
  }
  public class Counters {
    public SoapApi33Domain.UsageChargeCounter usageChargeCounter;
    public SoapApi33Domain.UsageEventCounter usageEventCounter;
    public SoapApi33Domain.UsageRuleCounter usageRuleCounter;
    private String[] usageChargeCounter_type_info = new List<String>{
      'usageChargeCounter',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] usageEventCounter_type_info = new List<String>{
      'usageEventCounter',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] usageRuleCounter_type_info = new List<String>{
      'usageRuleCounter',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'usageChargeCounter',
      'usageEventCounter',
      'usageRuleCounter'
    };
  }
  /*public class CreateDraftOrder {
        private String[] apex_schema_type_info = new String[]{'http://www.tractbilling.com/billing/1_33/domain','true','false'};
        private String[] field_order_type_info = new String[]{};
    }*/
  public class CreateDraftOrder {
    public SoapApi33Domain.SalesOrder salesOrder;
    private String[] salesOrder_type_info = new List<String>{
      'salesOrder',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'salesOrder' };
  }
  public class InvoiceAdjustmentApplication {
    public SoapApi33Domain.Invoice invoice;
    private String[] invoice_type_info = new List<String>{
      'invoice',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'invoice' };
  }
  public class scheduledCharges_element {
    public SoapApi33Domain.ScheduledCharge[] scheduledCharge;
    private String[] scheduledCharge_type_info = new List<String>{
      'scheduledCharge',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'scheduledCharge'
    };
  }
  public class Organization {
    /*public String name;
        private String[] name_att_info = new String[]{'name'};
        private String[] apex_schema_type_info = new String[]{'http://www.tractbilling.com/billing/1_33/domain','true','false'};
        private String[] field_order_type_info = new String[]{};*/

    public String name;
    private String[] name_att_info = new List<String>{ 'name' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    //private String[] field_order_type_info = new String[]{};

    /** Copied from Party */
    public SoapApi33Domain.addresses_element addresses;
    public String taxIdNumber;
    private String[] addresses_type_info = new List<String>{
      'addresses',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] taxIdNumber_att_info = new List<String>{ 'taxIdNumber' };
    private String[] field_order_type_info = new List<String>{ 'addresses' };
  }
  public class InvoiceItem {
    public SoapApi33Domain.InvoiceItemCharges invoiceItemCharges;
    public SoapApi33Domain.Service service;
    public Decimal quantity;
    public Decimal unitAmount;
    public Decimal totalAmount;
    public String description;
    public Boolean taxable;
    public Decimal proratedPercentage;
    public DateTime chargeStartDate;
    public DateTime chargeEndDate;
    public String lineItemType;
    public String type_x;
    private String[] service_type_info = new List<String>{
      'service',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] invoiceItemCharges_type_info = new List<String>{
      'invoiceItemCharges',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] quantity_att_info = new List<String>{ 'quantity' };
    private String[] unitAmount_att_info = new List<String>{ 'unitAmount' };
    private String[] totalAmount_att_info = new List<String>{ 'totalAmount' };
    private String[] description_att_info = new List<String>{ 'description' };
    private String[] taxable_att_info = new List<String>{ 'taxable' };
    private String[] proratedPercentage_att_info = new List<String>{
      'proratedPercentage'
    };
    private String[] chargeStartDate_att_info = new List<String>{
      'chargeStartDate'
    };
    private String[] chargeEndDate_att_info = new List<String>{
      'chargeEndDate'
    };
    private String[] lineItemType_att_info = new List<String>{ 'lineItemType' };
    private String[] type_x_att_info = new List<String>{ 'type' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'invoiceItemCharges',
      'service'
    };
  }
  public class Orders {
    public SoapApi33Domain.SalesOrder salesOrder;
    public SoapApi33Domain.RenewalOrder renewalOrder;
    public Integer totalPages;
    private String[] totalPages_att_info = new List<String>{ 'totalPages' };
    private String[] salesOrder_type_info = new List<String>{
      'salesOrder',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] renewalOrder_type_info = new List<String>{
      'renewalOrder',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'salesOrder',
      'renewalOrder'
    };
  }
  public class AddRecurringPaymentToBillingAccount {
    public SoapApi33Domain.BillingAccountRecurringPayment recurringPayment;
    private String[] recurringPayment_type_info = new List<String>{
      'recurringPayment',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'recurringPayment'
    };
  }
  public class GLAggregateEntry {
    public SoapApi33Domain.GLAccount glAccount;
    public SoapApi33Domain.BillingAccountCategory billingAccountCategory;
    public SoapApi33Domain.BillingAccount billingAccount;
    public Decimal amount;
    public String entryType;
    public Long count;
    public String currencyType;
    public Decimal originalAmount;
    public String originalCurrencyType;
    public String country;
    private String[] glAccount_type_info = new List<String>{
      'glAccount',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] billingAccountCategory_type_info = new List<String>{
      'billingAccountCategory',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] billingAccount_type_info = new List<String>{
      'billingAccount',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] amount_att_info = new List<String>{ 'amount' };
    private String[] entryType_att_info = new List<String>{ 'entryType' };
    private String[] count_att_info = new List<String>{ 'count' };
    private String[] currencyType_att_info = new List<String>{ 'currencyType' };
    private String[] originalAmount_att_info = new List<String>{
      'originalAmount'
    };
    private String[] originalCurrencyType_att_info = new List<String>{
      'originalCurrencyType'
    };
    private String[] country_att_info = new List<String>{ 'country' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'glAccount',
      'billingAccountCategory',
      'billingAccount'
    };
  }
  public class ProductCategories {
    public SoapApi33Domain.ProductCategory[] productCategories;
    private String[] productCategories_type_info = new List<String>{
      'productCategories',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'productCategories'
    };
  }
  public class ScheduledCharges {
    public SoapApi33Domain.ScheduledCharge[] scheduledCharge;
    private String[] scheduledCharge_type_info = new List<String>{
      'scheduledCharge',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'scheduledCharge'
    };
  }
  public class InvoiceItems {
    public SoapApi33Domain.AdditionalFeeInvoiceItem additionalFeeInvoiceItem;
    public SoapApi33Domain.AdjustmentInvoiceItem adjustmentInvoiceItem;
    public SoapApi33Domain.ProductInvoiceItem productInvoiceItem;
    public SoapApi33Domain.ServiceInvoiceItem[] serviceInvoiceItem;
    public SoapApi33Domain.TaxInvoiceItem[] taxInvoiceItem;
    public SoapApi33Domain.ManualInvoiceItem[] manualInvoiceItem;
    public SoapApi33Domain.UsageInvoiceItem[] usageInvoiceItem;
    public SoapApi33Domain.ManualServiceInvoiceItem[] manualServiceInvoiceItem;
    public SoapApi33Domain.AdditionalFeeInvoiceItem[] manualAdditionalFeeInvoiceItem;
    private String[] manualAdditionalFeeInvoiceItem_type_info = new List<String>{
      'manualAdditionalFeeInvoiceItem',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] manualServiceInvoiceItem_type_info = new List<String>{
      'manualServiceInvoiceItem',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] additionalFeeInvoiceItem_type_info = new List<String>{
      'additionalFeeInvoiceItem',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] adjustmentInvoiceItem_type_info = new List<String>{
      'adjustmentInvoiceItem',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] productInvoiceItem_type_info = new List<String>{
      'productInvoiceItem',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] serviceInvoiceItem_type_info = new List<String>{
      'serviceInvoiceItem',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] manualInvoiceItem_type_info = new List<String>{
      'manualInvoiceItem',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] taxInvoiceItem_type_info = new List<String>{
      'taxInvoiceItem',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] usageInvoiceItem_type_info = new List<String>{
      'usageInvoiceItem',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'manualAdditionalFeeInvoiceItem',
      'manualServiceInvoiceItem',
      'manualInvoiceItem',
      'additionalFeeInvoiceItem',
      'adjustmentInvoiceItem',
      'productInvoiceItem',
      'serviceInvoiceItem',
      'taxInvoiceItem',
      'usageInvoiceItem'
    };
  }

  public class BillingAccountSegmentFields {
    public SoapApi33Domain.BillingAccountSegmentField[] billingAccountSegmentField;
    private String[] billingAccountSegmentField_type_info = new List<String>{
      'billingAccountSegmentField',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'billingAccountSegmentField'
    };
  }
  public class GlobalProductUsageRule {
    public String name;
    public String eid;
    public String allowanceType;
    public String usageUom;
    public String status;
    public Double limit_x;
    public DateTime validFrom;
    public String rollOverType;
    public String ruleType;
    public Boolean proratedOnOrder;
    public Boolean proratedOnCancel;

    public SoapApi33Domain.GlobalUsageRule globalUsageRule;

    public SoapApi33Domain.ChargeCategory chargeCategory;
    public SoapApi33Domain.PassThroughUsageRate passThroughUsageRate;
    public SoapApi33Domain.FlatUsageRate flatUsageRate;
    public SoapApi33Domain.RateTable rateTable;
    public SoapApi33Domain.TableUsageRate tableUsageRate;
    public SoapApi33Domain.GlobalOrderItemUsageRule globalOrderItemUsageRule;
    private String[] globalUsageRule_type_info = new List<String>{
      'globalUsageRule',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] chargeCategory_type_info = new List<String>{
      'chargeCategory',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] passThroughUsageRate_type_info = new List<String>{
      'passThroughUsageRate',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] globalOrderItemUsageRule_type_info = new List<String>{
      'globalOrderItemUsageRule',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    // private String[] globalProductUsageRule_type_info = new String[]{'globalProductUsageRule','http://www.tractbilling.com/billing/1_33/domain',null,'0','1','false'};
    private String[] name_att_info = new List<String>{ 'name' };
    private String[] eid_att_info = new List<String>{ 'eid' };
    private String[] allowanceType_att_info = new List<String>{
      'allowanceType'
    };
    private String[] usageUom_att_info = new List<String>{ 'usageUom' };
    private String[] status_att_info = new List<String>{ 'status' };
    private String[] limit_x_att_info = new List<String>{ 'limit' };
    private String[] rollOverType_att_info = new List<String>{ 'rollOverType' };
    private String[] ruleType_att_info = new List<String>{ 'ruleType' };
    private String[] validFrom_att_info = new List<String>{ 'validFrom' };
    private String[] proratedOnOrder_att_info = new List<String>{
      'proratedOnOrder'
    };
    private String[] proratedOnCancel_att_info = new List<String>{
      'proratedOnCancel'
    };
    private String[] flatUsageRate_type_info = new List<String>{
      'flatUsageRate',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] tableUsageRate_type_info = new List<String>{
      'tableUsageRate',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] rateTable_type_info = new List<String>{
      'rateTable',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'globalUsageRule',
      'chargeCategory',
      'passThroughUsageRate',
      'globalOrderItemUsageRule',
      'flatUsageRate',
      'tableUsageRate',
      'rateTable'
    };
  }
  public class StandardInvoicePaymentApplication {
    public SoapApi33Domain.ReversedInvoicePaymentApplication reversedApplication;
    public SoapApi33Domain.Payment payment;
    public SoapApi33Domain.Invoice invoice;
    private String[] payment_type_info = new List<String>{
      'payment',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] invoice_type_info = new List<String>{
      'invoice',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] reversedApplication_type_info = new List<String>{
      'reversedApplication',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'reversedApplication',
      'payment',
      'invoice'
    };
  }
  public class UpdateResponse {
    public Boolean successful;
    public Long eid;
    private String[] successful_att_info = new List<String>{ 'successful' };
    private String[] eid_att_info = new List<String>{ 'eid' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class AccountType {
    public String name;
    public String description;
    private String[] name_att_info = new List<String>{ 'name' };
    private String[] description_att_info = new List<String>{ 'description' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class SimpleDataQuery {
    public String type_x;
    public SoapApi33Domain.ParameterAndValue[] parameter;
    public SoapApi33Domain.OrderBy[] orderBy;
    public SoapApi33Domain.WhereClause[] whereClause;
    public Integer pageNumber;
    public Integer pageSize;
    private String[] type_x_type_info = new List<String>{
      'type',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] parameter_type_info = new List<String>{
      'parameter',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] orderBy_type_info = new List<String>{
      'orderBy',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] whereClause_type_info = new List<String>{
      'whereClause',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] pageNumber_att_info = new List<String>{ 'pageNumber' };
    private String[] pageSize_att_info = new List<String>{ 'pageSize' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'type_x',
      'parameter',
      'orderBy',
      'whereClause'
    };
  }
  public class PaymentApplication {
    public SoapApi33Domain.Payment payment;
    public SoapApi33Domain.Invoice invoice;
    public DateTime updatedOn;
    public Decimal amount;
    public String type_x;
    private String[] payment_type_info = new List<String>{
      'payment',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] invoice_type_info = new List<String>{
      'invoice',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] updatedOn_att_info = new List<String>{ 'updatedOn' };
    private String[] amount_att_info = new List<String>{ 'amount' };
    private String[] type_x_att_info = new List<String>{ 'type' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'payment',
      'invoice'
    };
  }
  public class TaxInvoiceItem {
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class UpdateRequest {
    public SoapApi33Domain.BillingAccount billingAccount;
    public SoapApi33Domain.Person person;
    public SoapApi33Domain.Organization organization;
    public SoapApi33Domain.AgreementService agreementService;
    public SoapApi33Domain.GLAggregateBatch glAggregateBatch;
    public SoapApi33Domain.GLTransactionBatch glTransactionBatch;
    public SoapApi33Domain.ServiceResource serviceResource;
    public SoapApi33Domain.CustomFieldValue customFieldValue;
    public SoapApi33Domain.Service service;
    public SoapApi33Domain.MatchAllServiceUsageRule matchAllServiceUsageRule;
    public SoapApi33Domain.FormulaServiceUsageRule formulaServiceUsageRule;
    public SoapApi33Domain.GlobalServiceUsageRule globalServiceUsageRule;
    public SoapApi33Domain.UsageChargeCounter usageChargeCounter;
    public SoapApi33Domain.UsageEventCounter usageEventCounter;
    public SoapApi33Domain.UsageRuleCounter usageRuleCounter;
    public SoapApi33Domain.Adjustment adjustment;
    public SoapApi33Domain.SalesOrder salesOrder;
    public SoapApi33Domain.ChangeOrder changeOrder;
    private String[] billingAccount_type_info = new List<String>{
      'billingAccount',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] person_type_info = new List<String>{
      'person',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] organization_type_info = new List<String>{
      'organization',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] agreementService_type_info = new List<String>{
      'agreementService',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] glAggregateBatch_type_info = new List<String>{
      'glAggregateBatch',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] glTransactionBatch_type_info = new List<String>{
      'glTransactionBatch',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] serviceResource_type_info = new List<String>{
      'serviceResource',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] customFieldValue_type_info = new List<String>{
      'customFieldValue',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] service_type_info = new List<String>{
      'service',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] matchAllServiceUsageRule_type_info = new List<String>{
      'matchAllServiceUsageRule',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] formulaServiceUsageRule_type_info = new List<String>{
      'formulaServiceUsageRule',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] globalServiceUsageRule_type_info = new List<String>{
      'globalServiceUsageRule',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] usageChargeCounter_type_info = new List<String>{
      'usageChargeCounter',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] usageEventCounter_type_info = new List<String>{
      'usageEventCounter',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] usageRuleCounter_type_info = new List<String>{
      'usageRuleCounter',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] adjustment_type_info = new List<String>{
      'adjustment',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] salesOrder_type_info = new List<String>{
      'salesOrder',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] changeOrder_type_info = new List<String>{
      'changeOrder',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'billingAccount',
      'person',
      'organization',
      'agreementService',
      'glAggregateBatch',
      'glTransactionBatch',
      'serviceResource',
      'customFieldValue',
      'service',
      'matchAllServiceUsageRule',
      'formulaServiceUsageRule',
      'globalServiceUsageRule',
      'usageChargeCounter',
      'usageEventCounter',
      'usageRuleCounter',
      'adjustment',
      'salesOrder',
      'changeOrder'
    };
  }
  public class Product {
    public SoapApi33Domain.ProductPrices productPrices;
    public SoapApi33Domain.ProductCategory productCategory;
    public SoapApi33Domain.ServiceResourceCategory serviceResourceCategory;
    public SoapApi33Domain.Actions actions;
    public SoapApi33Domain.ProductUsageRules productUsageRules;
    public SoapApi33Domain.ProductTags productTags;
    public SoapApi33Domain.ProductRegisterType registerType;
    public String name;
    public String description;
    public String shortDescription;
    public String productTypeCode;
    public String productState;
    public String sku;
    public Boolean requiresAgreement;
    public Boolean serialized;
    public Boolean taxable;
    public Boolean trial;
    public Integer trialDays;
    public Datetime introductionDate;
    public Decimal defaultQuantity;
    public String internalName;
    public String externalProductNumber;
    public Integer minServiceResources;
    public Integer maxServiceResources;
    public Boolean trialOverride;
    public Integer productLevel;
    public Boolean ruleOverride;
    public String ruleType;
    public String ruleMode;

    /** Added Manually eid*/
    public String eid;
    private String[] registerType_type_info = new List<String>{
      'registerType',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] eid_att_info = new List<String>{ 'eid' };
    private String[] productPrices_type_info = new List<String>{
      'productPrices',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] productCategory_type_info = new List<String>{
      'productCategory',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] serviceResourceCategory_type_info = new List<String>{
      'serviceResourceCategory',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] actions_type_info = new List<String>{
      'actions',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] productUsageRules_type_info = new List<String>{
      'productUsageRules',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] productTags_type_info = new List<String>{
      'productTags',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    //private String[] productTypeCode_type_info = new String[]{'productTypeCode','http://www.tractbilling.com/billing/1_33/domain',null,'0','1','false'};
    private String[] name_att_info = new List<String>{ 'name' };
    private String[] description_att_info = new List<String>{ 'description' };
    private String[] shortDescription_att_info = new List<String>{
      'shortDescription'
    };
    private String[] productTypeCode_att_info = new List<String>{
      'productTypeCode'
    };
    private String[] productState_att_info = new List<String>{ 'productState' };
    private String[] sku_att_info = new List<String>{ 'sku' };
    private String[] requiresAgreement_att_info = new List<String>{
      'requiresAgreement'
    };
    private String[] introductionDate_att_info = new List<String>{
      'introductionDate'
    };
    private String[] serialized_att_info = new List<String>{ 'serialized' };
    private String[] taxable_att_info = new List<String>{ 'taxable' };
    private String[] trial_att_info = new List<String>{ 'trial' };
    private String[] trialDays_att_info = new List<String>{ 'trialDays' };
    private String[] defaultQuantity_att_info = new List<String>{
      'defaultQuantity'
    };
    private String[] internalName_att_info = new List<String>{ 'internalName' };
    private String[] externalProductNumber_att_info = new List<String>{
      'externalProductNumber'
    };
    private String[] minServiceResources_att_info = new List<String>{
      'minServiceResources'
    };
    private String[] maxServiceResources_att_info = new List<String>{
      'maxServiceResources'
    };
    private String[] trialOverride_att_info = new List<String>{
      'trialOverride'
    };
    private String[] productLevel_att_info = new List<String>{ 'productLevel' };
    private String[] ruleOverride_att_info = new List<String>{ 'ruleOverride' };
    private String[] ruleType_att_info = new List<String>{ 'ruleType' };
    private String[] ruleMode_att_info = new List<String>{ 'ruleMode' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'productPrices',
      'productCategory',
      'serviceResourceCategory',
      'actions',
      'productUsageRules',
      'productTags',
      'registerType'
    };
  }

  public class BankPaymentMethod {
    public String bankName;
    public String bankRoutingNumber;
    public String bankAccountType;
    public String bankAccountNumber;
    public String bankCheckNumber;
    public String nickname;
    public SoapApi33Domain.PostalAddress postalAddress;
    public SoapApi33Domain.EmailAddress emailAddress;
    public SoapApi33Domain.TelecomAddress telecomAddress;
    public SoapApi33Domain.CustomFieldValues customFieldValues;
    public String eid;
    private String[] eid_att_info = new List<String>{ 'eid' };
    private String[] bankName_att_info = new List<String>{ 'bankName' };
    private String[] bankRoutingNumber_att_info = new List<String>{
      'bankRoutingNumber'
    };
    private String[] bankAccountType_att_info = new List<String>{
      'bankAccountType'
    };
    private String[] bankCheckNumber_att_info = new List<String>{
      'bankCheckNumber'
    };
    private String[] nickname_att_info = new List<String>{ 'nickname' };
    private String[] bankAccountNumber_att_info = new List<String>{
      'bankAccountNumber'
    };
    private String[] postalAddress_type_info = new List<String>{
      'postalAddress',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] emailAddress_type_info = new List<String>{
      'emailAddress',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] telecomAddress_type_info = new List<String>{
      'telecomAddress',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] customFieldValues_type_info = new List<String>{
      'customFieldValues',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class ChangeOrderItemScheduledCharges {
    public SoapApi33Domain.scheduledCharges_element scheduledCharges;
    private String[] scheduledCharges_type_info = new List<String>{
      'scheduledCharges',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'scheduledCharges'
    };
  }
  public class GLAccount {
    public SoapApi33Domain.GLAccount parent;
    public SoapApi33Domain.GLAccountCategory glAccountCategory;
    public SoapApi33Domain.AccountType type_x;
    public SoapApi33Domain.GeneralLedger generalLedger;
    public Decimal currentBalance;
    public String accountNum;
    public String name;
    public String description;
    public DateTime validFrom;
    public DateTime validTo;
    public String currencyType;
    private String[] parent_type_info = new List<String>{
      'parent',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] glAccountCategory_type_info = new List<String>{
      'glAccountCategory',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] type_x_type_info = new List<String>{
      'type',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] generalLedger_type_info = new List<String>{
      'generalLedger',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] currentBalance_att_info = new List<String>{
      'currentBalance'
    };
    private String[] accountNum_att_info = new List<String>{ 'accountNum' };
    private String[] name_att_info = new List<String>{ 'name' };
    private String[] description_att_info = new List<String>{ 'description' };
    private String[] validFrom_att_info = new List<String>{ 'validFrom' };
    private String[] validTo_att_info = new List<String>{ 'validTo' };
    private String[] currencyType_att_info = new List<String>{ 'currencyType' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'parent',
      'glAccountCategory',
      'type_x',
      'generalLedger'
    };
  }
  public class Invoice {
    public SoapApi33Domain.BillingAccount billingAccount;
    public SoapApi33Domain.DailyBillCycle dailyBillCycle;
    public SoapApi33Domain.MonthlyBillCycle monthlyBillCycle;
    public SoapApi33Domain.QuarterlyBillCycle quarterlyBillCycle;
    public SoapApi33Domain.YearlyBillCycle yearlyBillCycle;
    public SoapApi33Domain.SegmentedMonthlyBillCycle segmentedMonthlyBillCycle;
    public SoapApi33Domain.InvoiceItems invoiceItems;
    public SoapApi33Domain.BillingStatement billingStatement;
    public SoapApi33Domain.BillingStatement adhocBillingStatement;
    public SoapApi33Domain.Invoice previousInvoice;
    public String invoiceNum;
    public Decimal amount;
    public String description;
    public String pdfPath;
    public DateTime occurredOn;
    public Date dueDate;
    public Date paidDate;
    public Decimal amountToPay;
    public Boolean lateFeeCharged;
    public String status;
    public String usageCsvPath;
    private String[] previousInvoice_type_info = new List<String>{
      'previousInvoice',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] adhocBillingStatement_type_info = new List<String>{
      'adhocBillingStatement',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] billingAccount_type_info = new List<String>{
      'billingAccount',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] dailyBillCycle_type_info = new List<String>{
      'dailyBillCycle',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] monthlyBillCycle_type_info = new List<String>{
      'monthlyBillCycle',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] quarterlyBillCycle_type_info = new List<String>{
      'quarterlyBillCycle',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] yearlyBillCycle_type_info = new List<String>{
      'yearlyBillCycle',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] segmentedMonthlyBillCycle_type_info = new List<String>{
      'segmentedMonthlyBillCycle',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] invoiceItems_type_info = new List<String>{
      'invoiceItems',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] billingStatement_type_info = new List<String>{
      'billingStatement',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] invoiceNum_att_info = new List<String>{ 'invoiceNum' };
    private String[] amount_att_info = new List<String>{ 'amount' };
    private String[] description_att_info = new List<String>{ 'description' };
    private String[] pdfPath_att_info = new List<String>{ 'pdfPath' };
    private String[] occurredOn_att_info = new List<String>{ 'occurredOn' };
    private String[] dueDate_att_info = new List<String>{ 'dueDate' };
    private String[] paidDate_att_info = new List<String>{ 'paidDate' };
    private String[] amountToPay_att_info = new List<String>{ 'amountToPay' };
    private String[] lateFeeCharged_att_info = new List<String>{
      'lateFeeCharged'
    };
    private String[] status_att_info = new List<String>{ 'status' };
    private String[] usageCsvPath_att_info = new List<String>{ 'usageCsvPath' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'previousInvoice',
      'adhocBillingStatement',
      'billingAccount',
      'dailyBillCycle',
      'monthlyBillCycle',
      'quarterlyBillCycle',
      'yearlyBillCycle',
      'segmentedMonthlyBillCycle',
      'invoiceItems',
      'billingStatement'
    };
  }
  public class ReverseInvoiceApplicationFromAdjustment {
    public SoapApi33Domain.StandardInvoiceAdjustmentApplication invoiceAdjustmentApplication;
    private String[] invoiceAdjustmentApplication_type_info = new List<String>{
      'invoiceAdjustmentApplication',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'invoiceAdjustmentApplication'
    };
  }
  public class ChangeServiceResource {
    public SoapApi33Domain.ServiceResource changeToServiceResource;
    public SoapApi33Domain.Service service;
    public Date effectiveDate;
    public SoapApi33Domain.ServiceResource serviceResource;
    private String[] serviceResource_type_info = new List<String>{
      'serviceResource',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] changeToServiceResource_type_info = new List<String>{
      'changeToServiceResource',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] service_type_info = new List<String>{
      'service',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] effectiveDate_att_info = new List<String>{
      'effectiveDate'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'changeToServiceResource',
      'service',
      'serviceResource'
    };
  }
  public class DiscountCodeCommand {
    public SoapApi33Domain.DiscountCode discountCode;
    private String[] discountCode_type_info = new List<String>{
      'discountCode',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'discountCode' };
  }
  public class ProductUsageRule {
    public String status;
    private String[] status_att_info = new List<String>{ 'status' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class ReverseDebitAdjustment {
    public SoapApi33Domain.AdjustmentReason reason;
    public SoapApi33Domain.AdjustmentReason secondaryReason;
    public String description;
    private String[] reason_type_info = new List<String>{
      'reason',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] secondaryReason_type_info = new List<String>{
      'secondaryReason',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] description_att_info = new List<String>{ 'description' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'reason',
      'secondaryReason'
    };
  }
  public class Agreement {
    public SoapApi33Domain.AdjustmentCategory adjustmentCategory;
    public SoapApi33Domain.Agreement nextAgreement;
    public String name;
    public Integer agreementPeriod;
    public String agreementPeriodType;
    public String status;
    public Decimal terminationFlatCharge;
    public Decimal terminationPercentageCharge;
    public Decimal maxTerminationCharge;
    public Boolean prorateOnCancel;
    public String endAction;
    public String terminationFeeCurrencyType;
    public String maxTerminationFeeCurrencyType;
    public DateTime fromDate;
    public DateTime thruDate;
    public Decimal minimumAmount;
    public String minimumAmountCurrencyType;
    //Manually added by Abhinav Bhatia from version 1.30
    public SoapApi33Domain.TrueUpChargeTypes trueUpChargeTypes;
    public SoapApi33Domain.AdjustmentReason trueUpAdjustmentReason;

    private String[] adjustmentCategory_type_info = new List<String>{
      'adjustmentCategory',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] nextAgreement_type_info = new List<String>{
      'nextAgreement',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] name_att_info = new List<String>{ 'name' };
    private String[] agreementPeriod_att_info = new List<String>{
      'agreementPeriod'
    };
    private String[] agreementPeriodType_att_info = new List<String>{
      'agreementPeriodType'
    };
    private String[] minimumAmountCurrencyType_att_info = new List<String>{
      'minimumAmountCurrencyType'
    };
    private String[] status_att_info = new List<String>{ 'status' };
    private String[] terminationFlatCharge_att_info = new List<String>{
      'terminationFlatCharge'
    };
    private String[] terminationPercentageCharge_att_info = new List<String>{
      'terminationPercentageCharge'
    };
    private String[] maxTerminationCharge_att_info = new List<String>{
      'maxTerminationCharge'
    };
    private String[] prorateOnCancel_att_info = new List<String>{
      'prorateOnCancel'
    };
    private String[] endAction_att_info = new List<String>{ 'endAction' };
    private String[] fromDate_att_info = new List<String>{ 'fromDate' };
    private String[] thruDate_att_info = new List<String>{ 'thruDate' };
    private String[] minimumAmount_att_info = new List<String>{
      'minimumAmount'
    };

    private String[] trueUpChargeTypes_type_info = new List<String>{
      'trueUpChargeTypes',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] trueUpAdjustmentReason_type_info = new List<String>{
      'trueUpAdjustmentReason',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };

    private String[] terminationFeeCurrencyType_att_info = new List<String>{
      'terminationFeeCurrencyType'
    };
    private String[] maxTerminationFeeCurrencyType_att_info = new List<String>{
      'maxTerminationFeeCurrencyType'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'adjustmentCategory',
      'nextAgreement',
      'trueUpChargeTypes',
      'trueUpAdjustmentReason'
    };

    //Tract - Manually Added
    public String eid;
    private String[] eid_att_info = new List<String>{ 'eid' };
  }
  public class UsageRate {
    public String uom;
    public DateTime validFrom;
    public DateTime validTo;
    private String[] uom_att_info = new List<String>{ 'uom' };
    private String[] validFrom_att_info = new List<String>{ 'validFrom' };
    private String[] validTo_att_info = new List<String>{ 'validTo' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class GLAggregateEntries {
    public SoapApi33Domain.GLAggregateEntry[] glAggregateEntry;
    private String[] glAggregateEntry_type_info = new List<String>{
      'glAggregateEntry',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'glAggregateEntry'
    };
  }
  public class ChangeOrderItemScheduledOneTimePriceCharges {
    public SoapApi33Domain.scheduledOneTimePriceCharges_element scheduledOneTimePriceCharges;
    private String[] scheduledOneTimePriceCharges_type_info = new List<String>{
      'scheduledOneTimePriceCharges',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'scheduledOneTimePriceCharges'
    };
  }
  public class ServiceResourceCategories {
    public SoapApi33Domain.ServiceResourceCategory[] serviceResourceCategory;
    private String[] serviceResourceCategory_type_info = new List<String>{
      'serviceResourceCategory',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'serviceResourceCategory'
    };
  }
  public class AddCustomFieldValueToService {
    public SoapApi33Domain.CustomFieldValue customFieldValue;
    private String[] customFieldValue_type_info = new List<String>{
      'customFieldValue',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'customFieldValue'
    };
  }
  public class FormulaProductUsageRule {
    public SoapApi33Domain.UsageLookupTable lookupTable;
    public String fieldName;
    public String operator;
    public String fieldValue;
    public String lookupTableFieldValue;
    public String name;
    public String eid;
    public Double limit_x;
    public String usageUom;
    public String allowanceType;
    public String status;
    public DateTime validFrom;
    public Boolean proratedOnOrder;
    public Boolean proratedOnCancel;
    public String rollOverType;
    public String ruleType;
    //Manually added by Abhinav Bhatia from 1.30 version
    public SoapApi33Domain.ChargeCategory chargeCategory;
    public SoapApi33Domain.FlatUsageRate flatUsageRate;

    public SoapApi33Domain.TableUsageRate tableUsageRate;
    public SoapApi33Domain.RateTable rateTable;
    public SoapApi33Domain.PassThroughUsageRate passThroughUsageRate;
    public SoapApi33Domain.RateTableEntries rateTableEntries;
    public SoapApi33Domain.FormulaOrderItemUsageRule formulaOrderItemUsageRule;
    private String[] lookupTable_type_info = new List<String>{
      'lookupTable',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] fieldName_att_info = new List<String>{ 'fieldName' };
    private String[] operator_att_info = new List<String>{ 'operator' };
    private String[] fieldValue_att_info = new List<String>{ 'fieldValue' };
    private String[] validFrom_att_info = new List<String>{ 'validFrom' };
    private String[] lookupTableFieldValue_att_info = new List<String>{
      'lookupTableFieldValue'
    };
    private String[] chargeCategory_type_info = new List<String>{
      'chargeCategory',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] flatUsageRate_type_info = new List<String>{
      'flatUsageRate',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    //private String[] formulaProductUsageRule_type_info = new String[]{'formulaProductUsageRule','http://www.tractbilling.com/billing/1_33/domain',null,'0','1','false'};
    private String[] formulaOrderItemUsageRule_type_info = new List<String>{
      'formulaOrderItemUsageRule',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] name_att_info = new List<String>{ 'name' };
    private String[] eid_att_info = new List<String>{ 'eid' };
    private String[] usageUom_att_info = new List<String>{ 'usageUom' };
    private String[] allowanceType_att_info = new List<String>{
      'allowanceType'
    };
    private String[] status_att_info = new List<String>{ 'status' };
    private String[] limit_x_att_info = new List<String>{ 'limit' };
    private String[] proratedOnOrder_att_info = new List<String>{
      'proratedOnOrder'
    };
    private String[] proratedOnCancel_att_info = new List<String>{
      'proratedOnCancel'
    };
    private String[] rollOverType_att_info = new List<String>{ 'rollOverType' };
    private String[] ruleType_att_info = new List<String>{ 'ruleType' };
    private String[] tableUsageRate_type_info = new List<String>{
      'tableUsageRate',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] rateTable_type_info = new List<String>{
      'rateTable',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] passThroughUsageRate_type_info = new List<String>{
      'passThroughUsageRate',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] rateTableEntries_type_info = new List<String>{
      'rateTableEntries',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'lookupTable',
      'chargeCategory',
      'flatUsageRate',
      'formulaOrderItemUsageRule',
      'tableUsageRate',
      'rateTable',
      'passThroughUsageRate',
      'rateTableEntries'
    };
  }
  public class ApproveOrderItem {
    public Date approvalDate;
    private String[] approvalDate_att_info = new List<String>{ 'approvalDate' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class QueryRequest {
    public SoapApi33Domain.BuildableDataQuery buildableDataQuery;
    public SoapApi33Domain.SimpleDataQuery simpleDataQuery;
    public String queryScope;
    private String[] buildableDataQuery_type_info = new List<String>{
      'buildableDataQuery',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] simpleDataQuery_type_info = new List<String>{
      'simpleDataQuery',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] queryScope_att_info = new List<String>{ 'queryScope' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'buildableDataQuery',
      'simpleDataQuery'
    };
  }
  public class InventoryItem {
    public SoapApi33Domain.Product product;
    public String serialNumber;
    public String status;
    private String[] product_type_info = new List<String>{
      'product',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] serialNumber_att_info = new List<String>{ 'serialNumber' };
    private String[] status_att_info = new List<String>{ 'status' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'product' };
  }
  public class GLTransactionBatches {
    public SoapApi33Domain.GLTransactionBatch[] glTransactionBatch;
    private String[] glTransactionBatch_type_info = new List<String>{
      'glTransactionBatch',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'glTransactionBatch'
    };
  }
  public class TractResponseObject {
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class AddResponse {
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};

    public String eid;
    private String[] eid_att_info = new List<String>{ 'eid' };
  }
  public class Organizations {
    public SoapApi33Domain.Organization[] organization;
    private String[] organization_type_info = new List<String>{
      'organization',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'organization' };
  }
  public class Operations {
    public SoapApi33Domain.ApprovalOperation approvalOperation;
    public SoapApi33Domain.HttpRequestOperation httpRequestOperation;
    public SoapApi33Domain.EmailOperation emailOperation;
    private String[] approvalOperation_type_info = new List<String>{
      'approvalOperation',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] httpRequestOperation_type_info = new List<String>{
      'httpRequestOperation',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] emailOperation_type_info = new List<String>{
      'emailOperation',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'approvalOperation',
      'httpRequestOperation',
      'emailOperation'
    };
  }

  //Added by Abhinav Bhatia from 1.30 version
  public class BillingStatement {
    public Decimal totalAmount;
    public Decimal balance;
    public Decimal serviceCharges;
    public Decimal activityCharges;
    public Decimal otherChargesAndCredits;
    public Decimal taxesAndFees;
    public Decimal totalCurrentCharges;
    public Decimal paymentsReceivedAmount;
    public Decimal paymentsCanceledAmount;
    public Decimal creditAdjustmentsPostedAmount;
    public Decimal creditAdjustmentsWriteOffAmount;
    private String[] totalAmount_att_info = new List<String>{ 'totalAmount' };
    private String[] balance_att_info = new List<String>{ 'balance' };
    private String[] serviceCharges_att_info = new List<String>{
      'serviceCharges'
    };
    private String[] activityCharges_att_info = new List<String>{
      'activityCharges'
    };
    private String[] otherChargesAndCredits_att_info = new List<String>{
      'otherChargesAndCredits'
    };
    private String[] taxesAndFees_att_info = new List<String>{ 'taxesAndFees' };
    private String[] totalCurrentCharges_att_info = new List<String>{
      'totalCurrentCharges'
    };
    private String[] paymentsReceivedAmount_att_info = new List<String>{
      'paymentsReceivedAmount'
    };
    private String[] paymentsCanceledAmount_att_info = new List<String>{
      'paymentsCanceledAmount'
    };
    private String[] creditAdjustmentsPostedAmount_att_info = new List<String>{
      'creditAdjustmentsPostedAmount'
    };
    private String[] creditAdjustmentsWriteOffAmount_att_info = new List<String>{
      'creditAdjustmentsWriteOffAmount'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }

  public class OperationAttribute {
    public SoapApi33Domain.ApprovalOperation approvalOperation;
    public SoapApi33Domain.HttpRequestOperation httpRequestOperation;
    public SoapApi33Domain.EmailOperation emailOperation;
    public String emailAddress;
    private String[] approvalOperation_type_info = new List<String>{
      'approvalOperation',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] httpRequestOperation_type_info = new List<String>{
      'httpRequestOperation',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] emailOperation_type_info = new List<String>{
      'emailOperation',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] emailAddress_att_info = new List<String>{ 'emailAddress' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'approvalOperation',
      'httpRequestOperation',
      'emailOperation'
    };
  }
  public class OrderItemCharges {
    public SoapApi33Domain.OrderItemCharge orderItemCharge;
    public SoapApi33Domain.TaxOrderItemCharge taxOrderItemCharge;
    private String[] orderItemCharge_type_info = new List<String>{
      'orderItemCharge',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] taxOrderItemCharge_type_info = new List<String>{
      'taxOrderItemCharge',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'orderItemCharge',
      'taxOrderItemCharge'
    };
  }
  public class AddPersonToBillingAccount {
    public SoapApi33Domain.Person person;
    public SoapApi33Domain.BillingAccount billingAccount;
    private String[] person_type_info = new List<String>{
      'person',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] billingAccount_type_info = new List<String>{
      'billingAccount',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'person',
      'billingAccount'
    };
  }
  public class SystemSetting {
    public String name;
    public String value;
    public String description;
    private String[] name_att_info = new List<String>{ 'name' };
    private String[] value_att_info = new List<String>{ 'value' };
    private String[] description_att_info = new List<String>{ 'description' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class Order {
    public SoapApi33Domain.OrderItems orderItems;
    public SoapApi33Domain.BillingAccount billingAccount;
    public SoapApi33Domain.Payments payments;
    public SoapApi33Domain.CustomFieldValues customFieldValues;
    public String orderNum;
    public String note;
    public String purchaseOrderNumber;
    public Boolean emailReceipt;
    public String referral;
    public DateTime orderDate;
    public Decimal totalAmount;
    public String orderStatus;
    private String[] orderItems_type_info = new List<String>{
      'orderItems',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] billingAccount_type_info = new List<String>{
      'billingAccount',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] payments_type_info = new List<String>{
      'payments',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] customFieldValues_type_info = new List<String>{
      'customFieldValues',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] orderNum_att_info = new List<String>{ 'orderNum' };
    private String[] note_att_info = new List<String>{ 'note' };
    private String[] purchaseOrderNumber_att_info = new List<String>{
      'purchaseOrderNumber'
    };
    private String[] emailReceipt_att_info = new List<String>{ 'emailReceipt' };
    private String[] referral_att_info = new List<String>{ 'referral' };
    private String[] orderDate_att_info = new List<String>{ 'orderDate' };
    private String[] totalAmount_att_info = new List<String>{ 'totalAmount' };
    private String[] orderStatus_att_info = new List<String>{ 'orderStatus' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'orderItems',
      'billingAccount',
      'payments',
      'customFieldValues'
    };
  }
  public class changeOrderItemAbstractPriceChargesCommand {
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class PostAdjustment {
    public SoapApi33Domain.CreateAdjustment adjustment;
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] adjustment_type_info = new List<String>{
      'adjustment',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'adjustment' };
  }
  public class AdditionalFeeInvoiceItems {
    public SoapApi33Domain.AdditionalFeeInvoiceItem[] additionalFeeInvoiceItem;
    private String[] additionalFeeInvoiceItem_type_info = new List<String>{
      'additionalFeeInvoiceItem',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'additionalFeeInvoiceItem'
    };
  }
  public class DiscountCodes {
    public SoapApi33Domain.DiscountCode[] discountCode;
    private String[] discountCode_type_info = new List<String>{
      'discountCode',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'discountCode' };
  }
  public class PriceLists {
    public SoapApi33Domain.PriceList[] priceList;
    private String[] priceList_type_info = new List<String>{
      'priceList',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'priceList' };
  }
  public class StandardInvoicePaymentApplications {
    public SoapApi33Domain.StandardInvoicePaymentApplication[] standardInvoicePaymentApplication;
    private String[] standardInvoicePaymentApplication_type_info = new List<String>{
      'standardInvoicePaymentApplication',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'standardInvoicePaymentApplication'
    };
  }
  public class QueryResponse {
    public SoapApi33Domain.GLAccountCategories glAccountCategories;
    public SoapApi33Domain.Agreements agreements;
    public SoapApi33Domain.BillCycles billCycles;
    public SoapApi33Domain.BillingAccountCategories billingAccountCategories;
    public SoapApi33Domain.BillingAccountRecurringPayments recurringPayments;
    public SoapApi33Domain.BillingAccounts billingAccounts;
    public SoapApi33Domain.CustomFields customFields;
    public SoapApi33Domain.CustomFieldValues customFieldValues;
    public SoapApi33Domain.Refunds refunds;
    public SoapApi33Domain.GeneralLedgers generalLedgers;
    public SoapApi33Domain.GLAccounts glAccounts;
    public SoapApi33Domain.GLAccountingEntries glAccountingEntries;
    public SoapApi33Domain.GLAggregateEntries glAggregateEntries;
    public SoapApi33Domain.GLAggregateBatches glAggregateBatches;
    public SoapApi33Domain.Invoices invoices;
    public SoapApi33Domain.InvoiceItems invoiceItems;
    public SoapApi33Domain.InvoiceItemCharges invoiceItemCharges;
    public SoapApi33Domain.SalesOrders salesOrders;
    public SoapApi33Domain.ChangeOrders changeOrders;
    public SoapApi33Domain.OrderItemCharges orderItemCharges;
    public SoapApi33Domain.Organizations organizations;
    public SoapApi33Domain.Payments payments;
    public SoapApi33Domain.PaymentTerms paymentTerms;
    public SoapApi33Domain.People people;
    public SoapApi33Domain.OrderItems orderItems;
    public SoapApi33Domain.Products products;
    public SoapApi33Domain.ProductCategories productCategories;
    public SoapApi33Domain.PriceLists priceLists;
    public SoapApi33Domain.ProductPrices productPrices;
    public SoapApi33Domain.PriceRanges priceRanges;
    public SoapApi33Domain.Promotions promotions;
    public SoapApi33Domain.Reasons reasons;
    public SoapApi33Domain.ServiceDeviceInventoryItems serviceDeviceInventoryItems;
    public SoapApi33Domain.ServiceResources serviceResources;
    public SoapApi33Domain.AgreementServices agreementServices;
    public SoapApi33Domain.Services services;
    public SoapApi33Domain.ServicePeriods servicePeriods;
    public SoapApi33Domain.ServicePrices servicePrices;
    public SoapApi33Domain.ServicePriceRanges servicePriceRanges;
    public SoapApi33Domain.ScheduledCharges scheduledCharges;
    public SoapApi33Domain.UsageEvents usageEvents;
    public SoapApi33Domain.UsageRules usageRules;
    public SoapApi33Domain.ServiceResourceCategories serviceResourceCategories;
    public SoapApi33Domain.AdjustmentReasons adjustmentReasons;
    public SoapApi33Domain.Adjustments adjustments;
    public SoapApi33Domain.ProductRelations productRelations;
    public SoapApi33Domain.Actions actions;
    public SoapApi33Domain.Operations operations;
    public SoapApi33Domain.OperationAttributes operationAttributes;
    public SoapApi33Domain.Orders orders;
    public SoapApi33Domain.RenewalOrders renewalOrders;
    public SoapApi33Domain.PartyCategories partyCategories;
    public SoapApi33Domain.SystemSettings systemSettings;
    public SoapApi33Domain.AdjustmentCategories adjustmentCategories;
    public SoapApi33Domain.ServiceUsageRules serviceUsageRules;
    public SoapApi33Domain.UsageLookupTables usageLookupTables;
    public SoapApi33Domain.UsageLookupTableEntries usageLookupTableEntries;
    public SoapApi33Domain.RateTables rateTables;
    public SoapApi33Domain.RateTableEntries rateTableEntries;
    public SoapApi33Domain.GlobalUsageRules globalUsageRules;
    public SoapApi33Domain.OrderItemUsageRules orderItemUsageRules;
    public SoapApi33Domain.ProductUsageRules productUsageRules;
    public SoapApi33Domain.UsagePriceCategories usagePriceCategories;
    public SoapApi33Domain.Counters counters;
    public SoapApi33Domain.AdjustmentApplications adjustmentApplications;
    public SoapApi33Domain.BillingAccountSegments billingAccountSegments;
    public SoapApi33Domain.BillingAccountSegmentFields billingAccountSegmentFields;
    public SoapApi33Domain.DiscountCategories discountCategories;
    public SoapApi33Domain.DiscountIdentifiers discountIdentifiers;
    public SoapApi33Domain.Currencies currencies;
    public SoapApi33Domain.DiscountChargeCategories discountChargeCategories;
    public SoapApi33Domain.Discounts discounts;
    public SoapApi33Domain.DiscountCodes discountCodes;
    public SoapApi33Domain.RecurringProductPrices recurringProductPrices;
    public SoapApi33Domain.OneTimeProductPrices oneTimeProductPrices;
    public SoapApi33Domain.ProductTags productTags;
    public SoapApi33Domain.GLTransactionBatches glTransactionBatches;
    public SoapApi33Domain.GLAccountingTransactions glAccountingTransactions;
    public SoapApi33Domain.AdditionalFeeInvoiceItems additionalFeeInvoiceItems;
    public SoapApi33Domain.AdjustmentInvoiceItems adjustmentInvoiceItems;
    public SoapApi33Domain.ProductInvoiceItems productInvoiceItems;
    public SoapApi33Domain.ServiceInvoiceItems serviceInvoiceItems;
    public SoapApi33Domain.TaxInvoiceItems taxInvoiceItems;
    public SoapApi33Domain.UsageInvoiceItems usageInvoiceItems;
    public SoapApi33Domain.DiscountCodeServices discountCodeServices;
    public SoapApi33Domain.ScheduledOneTimePriceCharges scheduledOneTimePriceCharges;
    public SoapApi33Domain.InvoiceAdjustmentApplications invoiceAdjustmentApplications;
    public SoapApi33Domain.StandardInvoiceAdjustmentApplications standardInvoiceAdjustmentApplications;
    public SoapApi33Domain.NegativeInvoiceAdjustmentApplications negativeInvoiceAdjustmentApplications;
    public SoapApi33Domain.ReversedInvoiceAdjustmentApplications reversedInvoiceAdjustmentApplications;
    public SoapApi33Domain.WriteOffsAdjustmentApplications writeOffAdjustmentApplications;
    public SoapApi33Domain.PaymentApplications paymentApplications;
    public SoapApi33Domain.StandardInvoicePaymentApplications standardInvoicePaymentApplications;
    public SoapApi33Domain.ReversedInvoicePaymentApplications reversedInvoicePaymentApplications;
    public SoapApi33Domain.AdjustmentItems adjustmentItems;
    public Boolean successful;
    public SoapApi33Domain.Notes notes;
    public SoapApi33Domain.PriceCategories priceCategories;
    public SOAPAPI33Domain.MarketPlaces marketPlaces;
    private String[] marketPlaces_type_info = new List<String>{
      'marketPlaces',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] glAccountCategories_type_info = new List<String>{
      'glAccountCategories',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] agreements_type_info = new List<String>{
      'agreements',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] billCycles_type_info = new List<String>{
      'billCycles',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] billingAccountCategories_type_info = new List<String>{
      'billingAccountCategories',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] recurringPayments_type_info = new List<String>{
      'recurringPayments',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] billingAccounts_type_info = new List<String>{
      'billingAccounts',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] customFields_type_info = new List<String>{
      'customFields',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] customFieldValues_type_info = new List<String>{
      'customFieldValues',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] refunds_type_info = new List<String>{
      'refunds',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] generalLedgers_type_info = new List<String>{
      'generalLedgers',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] glAccounts_type_info = new List<String>{
      'glAccounts',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] glAccountingEntries_type_info = new List<String>{
      'glAccountingEntries',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] glAggregateEntries_type_info = new List<String>{
      'glAggregateEntries',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] glAggregateBatches_type_info = new List<String>{
      'glAggregateBatches',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] invoices_type_info = new List<String>{
      'invoices',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] invoiceItems_type_info = new List<String>{
      'invoiceItems',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] invoiceItemCharges_type_info = new List<String>{
      'invoiceItemCharges',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] salesOrders_type_info = new List<String>{
      'salesOrders',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] changeOrders_type_info = new List<String>{
      'changeOrders',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] orderItemCharges_type_info = new List<String>{
      'orderItemCharges',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] organizations_type_info = new List<String>{
      'organizations',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] payments_type_info = new List<String>{
      'payments',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] paymentTerms_type_info = new List<String>{
      'paymentTerms',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] people_type_info = new List<String>{
      'people',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] orderItems_type_info = new List<String>{
      'orderItems',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] products_type_info = new List<String>{
      'products',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] productCategories_type_info = new List<String>{
      'productCategories',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] priceLists_type_info = new List<String>{
      'priceLists',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] productPrices_type_info = new List<String>{
      'productPrices',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] priceRanges_type_info = new List<String>{
      'priceRanges',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] promotions_type_info = new List<String>{
      'promotions',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] reasons_type_info = new List<String>{
      'reasons',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] serviceDeviceInventoryItems_type_info = new List<String>{
      'serviceDeviceInventoryItems',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] serviceResources_type_info = new List<String>{
      'serviceResources',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] agreementServices_type_info = new List<String>{
      'agreementServices',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] services_type_info = new List<String>{
      'services',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] servicePeriods_type_info = new List<String>{
      'servicePeriods',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] servicePrices_type_info = new List<String>{
      'servicePrices',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] servicePriceRanges_type_info = new List<String>{
      'servicePriceRanges',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] scheduledCharges_type_info = new List<String>{
      'scheduledCharges',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] usageEvents_type_info = new List<String>{
      'usageEvents',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] usageRules_type_info = new List<String>{
      'usageRules',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] serviceResourceCategories_type_info = new List<String>{
      'serviceResourceCategories',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] adjustmentReasons_type_info = new List<String>{
      'adjustmentReasons',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] adjustments_type_info = new List<String>{
      'adjustments',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] productRelations_type_info = new List<String>{
      'productRelations',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] actions_type_info = new List<String>{
      'actions',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] operations_type_info = new List<String>{
      'operations',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] operationAttributes_type_info = new List<String>{
      'operationAttributes',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] orders_type_info = new List<String>{
      'orders',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] renewalOrders_type_info = new List<String>{
      'renewalOrders',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] partyCategories_type_info = new List<String>{
      'partyCategories',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] systemSettings_type_info = new List<String>{
      'systemSettings',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] adjustmentCategories_type_info = new List<String>{
      'adjustmentCategories',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] serviceUsageRules_type_info = new List<String>{
      'serviceUsageRules',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] usageLookupTables_type_info = new List<String>{
      'usageLookupTables',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] usageLookupTableEntries_type_info = new List<String>{
      'usageLookupTableEntries',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] rateTables_type_info = new List<String>{
      'rateTables',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] rateTableEntries_type_info = new List<String>{
      'rateTableEntries',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] globalUsageRules_type_info = new List<String>{
      'globalUsageRules',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] orderItemUsageRules_type_info = new List<String>{
      'orderItemUsageRules',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] productUsageRules_type_info = new List<String>{
      'productUsageRules',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] usagePriceCategories_type_info = new List<String>{
      'usagePriceCategories',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] counters_type_info = new List<String>{
      'counters',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] adjustmentApplications_type_info = new List<String>{
      'adjustmentApplications',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] billingAccountSegments_type_info = new List<String>{
      'billingAccountSegments',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] billingAccountSegmentFields_type_info = new List<String>{
      'billingAccountSegmentFields',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] discountCategories_type_info = new List<String>{
      'discountCategories',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] discountIdentifiers_type_info = new List<String>{
      'discountIdentifiers',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] currencies_type_info = new List<String>{
      'currencies',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] discountChargeCategories_type_info = new List<String>{
      'discountChargeCategories',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] discounts_type_info = new List<String>{
      'discounts',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] discountCodes_type_info = new List<String>{
      'discountCodes',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] recurringProductPrices_type_info = new List<String>{
      'recurringProductPrices',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] oneTimeProductPrices_type_info = new List<String>{
      'oneTimeProductPrices',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] productTags_type_info = new List<String>{
      'productTags',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] glTransactionBatches_type_info = new List<String>{
      'glTransactionBatches',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] glAccountingTransactions_type_info = new List<String>{
      'glAccountingTransactions',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] additionalFeeInvoiceItems_type_info = new List<String>{
      'additionalFeeInvoiceItems',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] adjustmentInvoiceItems_type_info = new List<String>{
      'adjustmentInvoiceItems',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] productInvoiceItems_type_info = new List<String>{
      'productInvoiceItems',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] serviceInvoiceItems_type_info = new List<String>{
      'serviceInvoiceItems',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] taxInvoiceItems_type_info = new List<String>{
      'taxInvoiceItems',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] usageInvoiceItems_type_info = new List<String>{
      'usageInvoiceItems',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] discountCodeServices_type_info = new List<String>{
      'discountCodeServices',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] scheduledOneTimePriceCharges_type_info = new List<String>{
      'scheduledOneTimePriceCharges',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] invoiceAdjustmentApplications_type_info = new List<String>{
      'invoiceAdjustmentApplications',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] standardInvoiceAdjustmentApplications_type_info = new List<String>{
      'standardInvoiceAdjustmentApplications',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] negativeInvoiceAdjustmentApplications_type_info = new List<String>{
      'negativeInvoiceAdjustmentApplications',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] reversedInvoiceAdjustmentApplications_type_info = new List<String>{
      'reversedInvoiceAdjustmentApplications',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] writeOffAdjustmentApplications_type_info = new List<String>{
      'writeOffAdjustmentApplications',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] paymentApplications_type_info = new List<String>{
      'paymentApplications',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] standardInvoicePaymentApplications_type_info = new List<String>{
      'standardInvoicePaymentApplications',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] reversedInvoicePaymentApplications_type_info = new List<String>{
      'reversedInvoicePaymentApplications',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] adjustmentItems_type_info = new List<String>{
      'adjustmentItems',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] successful_att_info = new List<String>{ 'successful' };
    private String[] priceCategories_type_info = new List<String>{
      'priceCategories',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] notes_type_info = new List<String>{
      'notes',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'glAccountCategories',
      'agreements',
      'billCycles',
      'billingAccountCategories',
      'priceCategories',
      'recurringPayments',
      'billingAccounts',
      'customFields',
      'customFieldValues',
      'refunds',
      'generalLedgers',
      'glAccounts',
      'glAccountingEntries',
      'glAggregateEntries',
      'glAggregateBatches',
      'invoices',
      'invoiceItems',
      'invoiceItemCharges',
      'salesOrders',
      'changeOrders',
      'orderItemCharges',
      'organizations',
      'payments',
      'paymentTerms',
      'people',
      'orderItems',
      'products',
      'productCategories',
      'priceLists',
      'productPrices',
      'priceRanges',
      'promotions',
      'reasons',
      'serviceDeviceInventoryItems',
      'serviceResources',
      'agreementServices',
      'services',
      'servicePeriods',
      'servicePrices',
      'servicePriceRanges',
      'scheduledCharges',
      'usageEvents',
      'usageRules',
      'serviceResourceCategories',
      'adjustmentReasons',
      'adjustments',
      'productRelations',
      'actions',
      'operations',
      'operationAttributes',
      'orders',
      'renewalOrders',
      'partyCategories',
      'systemSettings',
      'adjustmentCategories',
      'serviceUsageRules',
      'usageLookupTables',
      'usageLookupTableEntries',
      'rateTables',
      'rateTableEntries',
      'globalUsageRules',
      'orderItemUsageRules',
      'productUsageRules',
      'usagePriceCategories',
      'counters',
      'adjustmentApplications',
      'billingAccountSegments',
      'billingAccountSegmentFields',
      'discountCategories',
      'discountIdentifiers',
      'currencies',
      'discountChargeCategories',
      'discounts',
      'discountCodes',
      'recurringProductPrices',
      'oneTimeProductPrices',
      'productTags',
      'glTransactionBatches',
      'glAccountingTransactions',
      'additionalFeeInvoiceItems',
      'adjustmentInvoiceItems',
      'productInvoiceItems',
      'serviceInvoiceItems',
      'taxInvoiceItems',
      'usageInvoiceItems',
      'discountCodeServices',
      'scheduledOneTimePriceCharges',
      'invoiceAdjustmentApplications',
      'standardInvoiceAdjustmentApplications',
      'negativeInvoiceAdjustmentApplications',
      'reversedInvoiceAdjustmentApplications',
      'writeOffAdjustmentApplications',
      'paymentApplications',
      'standardInvoicePaymentApplications',
      'reversedInvoicePaymentApplications',
      'adjustmentItems',
      'payment'
    };
  }
  public class GlobalServiceUsageRule {
    public SoapApi33Domain.GlobalUsageRule globalUsageRule;

    public SoapApi33Domain.ChargeCategory chargeCategory;
    public SoapApi33Domain.PassThroughUsageRate passThroughUsageRate;

    public SoapApi33Domain.GlobalOrderItemUsageRule globalOrderItemUsageRule;
    public SoapApi33Domain.GlobalProductUsageRule globalProductUsageRule;
    public String name;
    public String eid;
    public String allowanceType;
    public String usageUom;
    public String status;
    public Double limit_x;

    public String rollOverType;
    public String ruleType;
    public Boolean proratedOnOrder;
    public Boolean proratedOnCancel;
    public SoapApi33Domain.FlatUsageRate flatUsageRate;
    public SoapApi33Domain.TableUsageRate tableUsageRate;
    public SoapApi33Domain.RateTable rateTable;

    private String[] globalUsageRule_type_info = new List<String>{
      'globalUsageRule',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] chargeCategory_type_info = new List<String>{
      'chargeCategory',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] passThroughUsageRate_type_info = new List<String>{
      'passThroughUsageRate',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] globalOrderItemUsageRule_type_info = new List<String>{
      'globalOrderItemUsageRule',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] globalProductUsageRule_type_info = new List<String>{
      'globalProductUsageRule',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] name_att_info = new List<String>{ 'name' };
    private String[] eid_att_info = new List<String>{ 'eid' };
    private String[] allowanceType_att_info = new List<String>{
      'allowanceType'
    };
    private String[] usageUom_att_info = new List<String>{ 'usageUom' };
    private String[] status_att_info = new List<String>{ 'status' };
    private String[] limit_x_att_info = new List<String>{ 'limit' };
    private String[] rollOverType_att_info = new List<String>{ 'rollOverType' };
    private String[] ruleType_att_info = new List<String>{ 'ruleType' };
    private String[] proratedOnOrder_att_info = new List<String>{
      'proratedOnOrder'
    };
    private String[] proratedOnCancel_att_info = new List<String>{
      'proratedOnCancel'
    };
    private String[] flatUsageRate_type_info = new List<String>{
      'flatUsageRate',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] tableUsageRate_type_info = new List<String>{
      'tableUsageRate',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] rateTable_type_info = new List<String>{
      'rateTable',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'globalUsageRule',
      'chargeCategory',
      'passThroughUsageRate',
      'globalOrderItemUsageRule',
      'globalProductUsageRule',
      'flatUsageRate',
      'tableUsageRate',
      'rateTable'
    };
  }
  public class PromotionQuery {
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class ReferencedCreditCardPaymentMethod {
    public String referenceKey;
    public String eid;
    private String[] eid_att_info = new List<String>{ 'eid' };
    private String[] referenceKey_att_info = new List<String>{ 'referenceKey' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }

  public class BillingAccount {
    public SoapApi33Domain.DailyBillCycle dailyBillCycle;
    public SoapApi33Domain.MonthlyBillCycle monthlyBillCycle;
    public SoapApi33Domain.QuarterlyBillCycle quarterlyBillCycle;
    public SoapApi33Domain.YearlyBillCycle yearlyBillCycle;
    public SoapApi33Domain.SegmentedMonthlyBillCycle segmentedMonthlyBillCycle;
    public SoapApi33Domain.Person person;
    public SoapApi33Domain.Organization organization;
    public SoapApi33Domain.BillingAccountRecurringPayments recurringPayments;
    public SoapApi33Domain.BillingAccountCategory billingAccountCategory;
    public SoapApi33Domain.Services services;
    public SoapApi33Domain.OrderItemCharges pendingCharges;
    public SoapApi33Domain.CustomFieldValues customFieldValues;
    public SoapApi33Domain.People people;
    public SoapApi33Domain.PaymentTerm paymentTerm;
    public SoapApi33Domain.BillingAccountSegment billingAccountSegment;
    public SoapApi33Domain.BillingAccount parentBillingAccount;
    public SoapApi33Domain.DeactivationReason deactivationReason;
    public SoapApi33Domain.SuspensionReason suspensionReason;
    public SoapApi33Domain.BillingAccount responsibleAccount;
    public String accountNum;
    public String externalAccountNum;
    public String billType;
    public Boolean automaticRecurringPayment;
    public String status;
    public Decimal pendingChargesTotal;
    public Decimal balance;
    public String startDate;
    public DateTime endDate;
    public Boolean taxExempt;
    public String currencyType;
    public Integer autoPayOffset;

    /* Tract Added */
    public String eid;
    private String[] eid_att_info = new List<String>{ 'eid' };

    public String responsibleAccountInvoiceRenderingType;
    private String[] responsibleAccountInvoiceRenderingType_att_info = new List<String>{
      'responsibleAccountInvoiceRenderingType'
    };

    private String[] dailyBillCycle_type_info = new List<String>{
      'dailyBillCycle',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] monthlyBillCycle_type_info = new List<String>{
      'monthlyBillCycle',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] quarterlyBillCycle_type_info = new List<String>{
      'quarterlyBillCycle',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] yearlyBillCycle_type_info = new List<String>{
      'yearlyBillCycle',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] segmentedMonthlyBillCycle_type_info = new List<String>{
      'segmentedMonthlyBillCycle',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] person_type_info = new List<String>{
      'person',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] organization_type_info = new List<String>{
      'organization',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] recurringPayments_type_info = new List<String>{
      'recurringPayments',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] billingAccountCategory_type_info = new List<String>{
      'billingAccountCategory',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] services_type_info = new List<String>{
      'services',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] pendingCharges_type_info = new List<String>{
      'pendingCharges',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] customFieldValues_type_info = new List<String>{
      'customFieldValues',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] people_type_info = new List<String>{
      'people',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] paymentTerm_type_info = new List<String>{
      'paymentTerm',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] billingAccountSegment_type_info = new List<String>{
      'billingAccountSegment',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] parentBillingAccount_type_info = new List<String>{
      'parentBillingAccount',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };

    private String[] deactivationReason_type_info = new List<String>{
      'deactivationReason',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] suspensionReason_type_info = new List<String>{
      'suspensionReason',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] responsibleAccount_type_info = new List<String>{
      'responsibleAccount',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };

    private String[] accountNum_att_info = new List<String>{ 'accountNum' };
    private String[] externalAccountNum_att_info = new List<String>{
      'externalAccountNum'
    };
    private String[] billType_att_info = new List<String>{ 'billType' };
    private String[] automaticRecurringPayment_att_info = new List<String>{
      'automaticRecurringPayment'
    };
    private String[] status_att_info = new List<String>{ 'status' };
    private String[] pendingChargesTotal_att_info = new List<String>{
      'pendingChargesTotal'
    };
    private String[] balance_att_info = new List<String>{ 'balance' };
    private String[] startDate_att_info = new List<String>{ 'startDate' };
    private String[] endDate_att_info = new List<String>{ 'endDate' };
    private String[] taxExempt_att_info = new List<String>{ 'taxExempt' };
    private String[] currencyType_att_info = new List<String>{ 'currencyType' };
    private String[] autoPayOffset_att_info = new List<String>{
      'autoPayOffset'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'dailyBillCycle',
      'monthlyBillCycle',
      'quarterlyBillCycle',
      'yearlyBillCycle',
      'segmentedMonthlyBillCycle',
      'person',
      'organization',
      'recurringPayments',
      'billingAccountCategory',
      'services',
      'pendingCharges',
      'customFieldValues',
      'people',
      'paymentTerm',
      'billingAccountSegment',
      'parentBillingAccount',
      'deactivationReason',
      'suspensionReason',
      'responsibleAccount'
    };
  }
  public class RenewalOrders {
    public SoapApi33Domain.RenewalOrder[] renewalOrder;
    private String[] renewalOrder_type_info = new List<String>{
      'renewalOrder',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'renewalOrder' };
  }
  public class RemoveServiceResourceFromService {
    public SoapApi33Domain.ServiceResource serviceResource;
    public Date effectiveDate;
    private String[] serviceResource_type_info = new List<String>{
      'serviceResource',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] effectiveDate_att_info = new List<String>{
      'effectiveDate'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'serviceResource'
    };
  }
  public class BasePayment {
    public SoapApi33Domain.BillingAccount billingAccount;
    public SoapApi33Domain.BankPaymentMethod bankPayment;
    public SoapApi33Domain.CashPaymentMethod cashPayment;
    public SoapApi33Domain.CheckPaymentMethod checkPayment;
    public SoapApi33Domain.CreditCardPaymentMethod creditCardPayment;
    public SoapApi33Domain.ReferencedCreditCardPaymentMethod referencedCreditCardPayment;
    public SoapApi33Domain.PayPalPaymentMethod payPalPayment;
    public SoapApi33Domain.WireTransferPaymentMethod wireTransferPayment;
    public SoapApi33Domain.PayByPayPalPaymentMethod payByPayPalPayment;
    public Decimal amount;
    public String description;
    public String authorization;
    public String reference;
    public String occurredOn;
    public Boolean useRecurringPayment;
    public String status;
    public Decimal unappliedAmount;
    private String[] billingAccount_type_info = new List<String>{
      'billingAccount',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] bankPayment_type_info = new List<String>{
      'bankPayment',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] cashPayment_type_info = new List<String>{
      'cashPayment',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] checkPayment_type_info = new List<String>{
      'checkPayment',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] creditCardPayment_type_info = new List<String>{
      'creditCardPayment',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] referencedCreditCardPayment_type_info = new List<String>{
      'referencedCreditCardPayment',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] payPalPayment_type_info = new List<String>{
      'payPalPayment',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] wireTransferPayment_type_info = new List<String>{
      'wireTransferPayment',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] payByPayPalPayment_type_info = new List<String>{
      'payByPayPalPayment',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] amount_att_info = new List<String>{ 'amount' };
    private String[] description_att_info = new List<String>{ 'description' };
    private String[] authorization_att_info = new List<String>{
      'authorization'
    };
    private String[] reference_att_info = new List<String>{ 'reference' };
    private String[] occurredOn_att_info = new List<String>{ 'occurredOn' };
    private String[] useRecurringPayment_att_info = new List<String>{
      'useRecurringPayment'
    };
    private String[] status_att_info = new List<String>{ 'status' };
    private String[] unappliedAmount_att_info = new List<String>{
      'unappliedAmount'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'billingAccount',
      'bankPayment',
      'cashPayment',
      'checkPayment',
      'creditCardPayment',
      'referencedCreditCardPayment',
      'payPalPayment',
      'wireTransferPayment',
      'payByPayPalPayment'
    };
  }
  public class AddParentBillingAccount {
    public SoapApi33Domain.BillingAccount parentBillingAccount;
    public DateTime validFrom;
    private String[] parentBillingAccount_type_info = new List<String>{
      'parentBillingAccount',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] validFrom_att_info = new List<String>{ 'validFrom' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'parentBillingAccount'
    };
  }
  public class CreateRequest {
    public SoapApi33Domain.BillingAccount billingAccount;
    public SoapApi33Domain.BillingAccountRecurringPayment recurringPayment;
    public SoapApi33Domain.Payment payment;
    public SoapApi33Domain.SalesOrder salesOrder;
    public SoapApi33Domain.Product product;
    public SoapApi33Domain.UsageEvent usage;
    public SoapApi33Domain.ServiceResource serviceResource;
    public SoapApi33Domain.CreateAdjustment adjustment;
    public SoapApi33Domain.Refund refund;
    private String[] billingAccount_type_info = new List<String>{
      'billingAccount',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] recurringPayment_type_info = new List<String>{
      'recurringPayment',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] payment_type_info = new List<String>{
      'payment',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] product_type_info = new List<String>{
      'product',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] salesOrder_type_info = new List<String>{
      'salesOrder',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] usage_type_info = new List<String>{
      'usage',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] serviceResource_type_info = new List<String>{
      'serviceResource',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] adjustment_type_info = new List<String>{
      'adjustment',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] refund_type_info = new List<String>{
      'refund',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'billingAccount',
      'recurringPayment',
      'payment',
      'product',
      'salesOrder',
      'usage',
      'serviceResource',
      'adjustment',
      'refund'
    };
  }
  public class ServiceResource {
    public Boolean autoSelect;
    public String status;
    private String[] autoSelect_att_info = new List<String>{ 'autoSelect' };
    private String[] status_att_info = new List<String>{ 'status' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'category' };
    public SoapApi33Domain.ServiceResourceCategory category;
    public String identifier;
    public String description;
    public String eid;
    private String[] eid_att_info = new List<String>{ 'eid' };
    private String[] category_type_info = new List<String>{
      'category',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] identifier_att_info = new List<String>{ 'identifier' };
    private String[] description_att_info = new List<String>{ 'description' };
  }
  public class OrderItems {
    public SoapApi33Domain.OrderItem[] orderItem;
    public SoapApi33Domain.TenantOrderItem[] tenantOrderItem;
    public SoapApi33Domain.TaxOrderItem[] taxOrderItem;
    private String[] orderItem_type_info = new List<String>{
      'orderItem',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] tenantOrderItem_type_info = new List<String>{
      'tenantOrderItem',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] taxOrderItem_type_info = new List<String>{
      'taxOrderItem',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'orderItem',
      'tenantOrderItem',
      'taxOrderItem'
    };
  }
  public class CommandObject {
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class RemovePersonFromBillingAccount {
    public SoapApi33Domain.Person person;
    private String[] person_type_info = new List<String>{
      'person',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'person' };
  }
  public class ReversedInvoicePaymentApplication {
    public SoapApi33Domain.StandardInvoicePaymentApplication reversedApplication;
    public SoapApi33Domain.Payment payment;
    public SoapApi33Domain.Invoice invoice;
    private String[] payment_type_info = new List<String>{
      'payment',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] invoice_type_info = new List<String>{
      'invoice',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] reversedApplication_type_info = new List<String>{
      'reversedApplication',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'reversedApplication',
      'payment',
      'invoice'
    };
  }
  public class ServiceInvoiceItems {
    public SoapApi33Domain.ServiceInvoiceItem[] serviceInvoiceItem;
    private String[] serviceInvoiceItem_type_info = new List<String>{
      'serviceInvoiceItem',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'serviceInvoiceItem'
    };
  }
  public class Reason {
    public String name;
    public String description;
    public String status;
    public String reasonType;
    private String[] name_att_info = new List<String>{ 'name' };
    private String[] description_att_info = new List<String>{ 'description' };
    private String[] status_att_info = new List<String>{ 'status' };
    private String[] reasonType_att_info = new List<String>{ 'reasonType' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class ProductPrices {
    public SoapApi33Domain.RecurringProductPrice[] recurringProductPrice;
    public SoapApi33Domain.OneTimeProductPrice[] oneTimeProductPrice;
    private String[] recurringProductPrice_type_info = new List<String>{
      'recurringProductPrice',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] oneTimeProductPrice_type_info = new List<String>{
      'oneTimeProductPrice',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'recurringProductPrice',
      'oneTimeProductPrice'
    };
  }

  public class RecurringProductPrice {
    public Boolean recurringPaymentRequired;
    public String recurrencePeriod;
    public Decimal recurrenceAmount;
    public Boolean proratedOnOrder;
    public Boolean proratedOnCancel;
    public Boolean proratedOnOrderNoCharge;
    public Boolean billInAdvance;
    public DateTime fromDate;
    public DateTime thruDate;
    public Boolean priceOverride;
    public String type_x;
    public String currencyType;
    public Boolean allowScheduledCharges;
    public Boolean paymentOnPurchaseRequired;
    public SoapApi33Domain.PriceRanges priceRanges;
    public SoapApi33Domain.ProductUsageRules productUsageRules;

    //Manually added by Abhinav Bhatia from 1.30 version
    public SoapApi33Domain.PriceCategory priceCategory;

    public String eid;
    private String[] eid_att_info = new List<String>{ 'eid' };
    private String[] recurringPaymentRequired_att_info = new List<String>{
      'recurringPaymentRequired'
    };
    private String[] recurrencePeriod_att_info = new List<String>{
      'recurrencePeriod'
    };
    private String[] recurrenceAmount_att_info = new List<String>{
      'recurrenceAmount'
    };
    private String[] proratedOnOrder_att_info = new List<String>{
      'proratedOnOrder'
    };
    private String[] proratedOnCancel_att_info = new List<String>{
      'proratedOnCancel'
    };
    private String[] proratedOnOrderNoCharge_att_info = new List<String>{
      'proratedOnOrderNoCharge'
    };
    private String[] billInAdvance_att_info = new List<String>{
      'billInAdvance'
    };
    private String[] fromDate_att_info = new List<String>{ 'fromDate' };
    private String[] thruDate_att_info = new List<String>{ 'thruDate' };
    private String[] priceOverride_att_info = new List<String>{
      'priceOverride'
    };
    private String[] type_x_att_info = new List<String>{ 'type' };
    private String[] currencyType_att_info = new List<String>{ 'currencyType' };
    private String[] allowScheduledCharges_att_info = new List<String>{
      'allowScheduledCharges'
    };
    private String[] paymentOnPurchaseRequired_att_info = new List<String>{
      'paymentOnPurchaseRequired'
    };
    private String[] priceRanges_type_info = new List<String>{
      'priceRanges',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] productUsageRules_type_info = new List<String>{
      'productUsageRules',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] priceCategory_type_info = new List<String>{
      'priceCategory',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'priceRanges',
      'productUsageRules',
      'priceCategory'
    };
  }
  //Manually added by Abhinav Bhatia from 1.30 version
  public class OrderItemAdjustmentItem {
    public SoapApi33Domain.OrderItem orderItem;
    public SoapApi33Domain.Adjustment adjustment;
    public SoapApi33Domain.AdjustmentReason reason;
    public SoapApi33Domain.AdjustmentReason secondaryReason;
    public SoapApi33Domain.AdjustmentCategory category;
    public SoapApi33Domain.AdjustmentItemCharges charges;
    private String[] charges_type_info = new List<String>{
      'charges',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] adjustment_type_info = new List<String>{
      'adjustment',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] reason_type_info = new List<String>{
      'reason',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] secondaryReason_type_info = new List<String>{
      'secondaryReason',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] category_type_info = new List<String>{
      'category',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] orderItem_type_info = new List<String>{
      'orderItem',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'orderItem',
      'adjustment',
      'reason',
      'secondaryReason',
      'category',
      'charges'
    };
  }
  public class OneTimeProductPrice {
    public Boolean chargeDuringRenewal;
    public SoapApi33Domain.PriceRanges priceRanges;
    public Boolean priceOverride;
    public String type_x;
    public String currencyType;
    public Boolean allowScheduledCharges;
    public String eid;
    public DateTime fromDate;
    public DateTime thruDate;
    public SoapApi33Domain.ProductUsageRules productUsageRules;

    //Manually added by Abhinav Bhatia from 1.30 version
    public SoapApi33Domain.PriceCategory priceCategory;
    public Boolean paymentOnPurchaseRequired;
    private String[] paymentOnPurchaseRequired_att_info = new List<String>{
      'paymentOnPurchaseRequired'
    };

    private String[] chargeDuringRenewal_att_info = new List<String>{
      'chargeDuringRenewal'
    };
    private String[] priceOverride_att_info = new List<String>{
      'priceOverride'
    };
    private String[] type_x_att_info = new List<String>{ 'type' };
    private String[] currencyType_att_info = new List<String>{ 'currencyType' };
    private String[] allowScheduledCharges_att_info = new List<String>{
      'allowScheduledCharges'
    };
    private String[] eid_att_info = new List<String>{ 'eid' };
    private String[] fromDate_att_info = new List<String>{ 'fromDate' };
    private String[] thruDate_att_info = new List<String>{ 'thruDate' };
    private String[] productUsageRules_type_info = new List<String>{
      'productUsageRules',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] priceRanges_type_info = new List<String>{
      'priceRanges',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] priceCategory_type_info = new List<String>{
      'priceCategory',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'priceRanges',
      'productUsageRules',
      'priceCategory'
    };
  }

  public class RefundReason {
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class DenyOrderItem {
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class ServiceResources {
    public Integer pageNumber;
    public Integer pageSize;
    public Long totalElements;
    public Integer elementCount;
    public Integer totalPages;
    private String[] pageNumber_att_info = new List<String>{ 'pageNumber' };
    private String[] pageSize_att_info = new List<String>{ 'pageSize' };
    private String[] totalElements_att_info = new List<String>{
      'totalElements'
    };
    private String[] elementCount_att_info = new List<String>{ 'elementCount' };
    private String[] totalPages_att_info = new List<String>{ 'totalPages' };

    public SoapApi33Domain.ServiceResource[] serviceResource;
    public SoapApi33Domain.CouponResource[] couponResource;
    private String[] serviceResource_type_info = new List<String>{
      'serviceResource',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] couponResource_type_info = new List<String>{
      'couponResource',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'serviceResource',
      'couponResource'
    };
  }
  public class PriceRanges {
    public SoapApi33Domain.PriceRange[] priceRange;
    private String[] priceRange_type_info = new List<String>{
      'priceRange',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'priceRange' };
  }
  public class UsagePriceCategory {
    public String eid;
    public String name;
    public String status;
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] eid_att_info = new List<String>{ 'eid' };
    private String[] name_att_info = new List<String>{ 'name' };
    private String[] status_att_info = new List<String>{ 'status' };
    private String[] field_order_type_info = new List<String>{};
  }
  public class FormulaServiceUsageRule {
    public SoapApi33Domain.UsageLookupTable lookupTable;
    public String fieldName;
    public String operator;
    public String fieldValue;
    public String lookupTableFieldValue;

    public SoapApi33Domain.ChargeCategory chargeCategory;
    public SoapApi33Domain.FlatUsageRate flatUsageRate;
    public SoapApi33Domain.FormulaProductUsageRule formulaProductUsageRule;
    public SoapApi33Domain.FormulaOrderItemUsageRule formulaOrderItemUsageRule;

    public String name;
    public String eid;
    public String usageUom;
    public String allowanceType;
    public String status;
    public Double limit_x;
    public Boolean proratedOnOrder;
    public Boolean proratedOnCancel;
    public String rollOverType;
    public String ruleType;

    public SoapApi33Domain.TableUsageRate tableUsageRate;
    public SoapApi33Domain.RateTable rateTable;
    public SoapApi33Domain.PassThroughUsageRate passThroughUsageRate;
    public SoapApi33Domain.RateTableEntries rateTableEntries;
    private String[] lookupTable_type_info = new List<String>{
      'lookupTable',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] fieldName_att_info = new List<String>{ 'fieldName' };
    private String[] operator_att_info = new List<String>{ 'operator' };
    private String[] fieldValue_att_info = new List<String>{ 'fieldValue' };
    private String[] lookupTableFieldValue_att_info = new List<String>{
      'lookupTableFieldValue'
    };
    private String[] chargeCategory_type_info = new List<String>{
      'chargeCategory',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] flatUsageRate_type_info = new List<String>{
      'flatUsageRate',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] formulaProductUsageRule_type_info = new List<String>{
      'formulaProductUsageRule',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] formulaOrderItemUsageRule_type_info = new List<String>{
      'formulaOrderItemUsageRule',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] name_att_info = new List<String>{ 'name' };
    private String[] eid_att_info = new List<String>{ 'eid' };
    private String[] usageUom_att_info = new List<String>{ 'usageUom' };
    private String[] allowanceType_att_info = new List<String>{
      'allowanceType'
    };
    private String[] status_att_info = new List<String>{ 'status' };
    private String[] limit_x_att_info = new List<String>{ 'limit' };
    private String[] proratedOnOrder_att_info = new List<String>{
      'proratedOnOrder'
    };
    private String[] proratedOnCancel_att_info = new List<String>{
      'proratedOnCancel'
    };
    private String[] rollOverType_att_info = new List<String>{ 'rollOverType' };
    private String[] ruleType_att_info = new List<String>{ 'ruleType' };
    private String[] tableUsageRate_type_info = new List<String>{
      'tableUsageRate',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] rateTable_type_info = new List<String>{
      'rateTable',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] passThroughUsageRate_type_info = new List<String>{
      'passThroughUsageRate',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] rateTableEntries_type_info = new List<String>{
      'rateTableEntries',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'lookupTable',
      'chargeCategory',
      'flatUsageRate',
      'formulaProductUsageRule',
      'formulaOrderItemUsageRule',
      'tableUsageRate',
      'rateTable',
      'passThroughUsageRate',
      'rateTableEntries'
    };
  }
  public class AuthorizationRequest {
    public SoapApi33Domain.UsageEvent usage;
    private String[] usage_type_info = new List<String>{
      'usage',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'usage' };
  }
  public class BuildableQuery {
    public SoapApi33Domain.ParameterAndValue[] parameter;
    private String[] parameter_type_info = new List<String>{
      'parameter',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'parameter' };
  }
  public class UsageChargeCounter {
    public Decimal charge;
    public Decimal threshold;
    private String[] charge_att_info = new List<String>{ 'charge' };
    private String[] threshold_att_info = new List<String>{ 'threshold' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class GLTransactionBatch {
    public SoapApi33Domain.GLAccountingTransactions glTransactions;
    public DateTime createdOn;
    public DateTime postedOn;
    public Boolean exported;
    public Long sequence;
    private String[] glTransactions_type_info = new List<String>{
      'glTransactions',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] createdOn_att_info = new List<String>{ 'createdOn' };
    private String[] postedOn_att_info = new List<String>{ 'postedOn' };
    private String[] exported_att_info = new List<String>{ 'exported' };
    private String[] sequence_att_info = new List<String>{ 'sequence' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'glTransactions'
    };
  }
  public class Referrer {
    public String referrerToken;
    private String[] referrerToken_att_info = new List<String>{
      'referrerToken'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class RemoveCustomFieldValueFromService {
    public SoapApi33Domain.CustomFieldValue customFieldValue;
    private String[] customFieldValue_type_info = new List<String>{
      'customFieldValue',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'customFieldValue'
    };
  }
  public class Reasons {
    public SoapApi33Domain.DeactivationReason[] deactivationReason;
    public SoapApi33Domain.SuspensionReason[] suspensionReason;
    public SoapApi33Domain.RefundReason[] paymentChangeReason;
    public SoapApi33Domain.RefundReason[] paymentPlanChangeReason;
    public SoapApi33Domain.ServiceDeactivationReason[] serviceDeactivationReason;
    public SoapApi33Domain.ServiceSuspensionReason[] serviceSuspensionReason;
    public SOAPAPI33Domain.ManualInvoiceReason manualInvoiceReason;
    private String[] manualInvoiceReason_type_info = new List<String>{
      'manualInvoiceReason',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] deactivationReason_type_info = new List<String>{
      'deactivationReason',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] suspensionReason_type_info = new List<String>{
      'suspensionReason',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] paymentChangeReason_type_info = new List<String>{
      'paymentChangeReason',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] paymentPlanChangeReason_type_info = new List<String>{
      'paymentPlanChangeReason',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] serviceDeactivationReason_type_info = new List<String>{
      'serviceDeactivationReason',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] serviceSuspensionReason_type_info = new List<String>{
      'serviceSuspensionReason',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'deactivationReason',
      'suspensionReason',
      'paymentChangeReason',
      'paymentPlanChangeReason',
      'serviceDeactivationReason',
      'serviceSuspensionReason',
      'manualInvoiceReason'
    };
  }
  public class responses_element {
    public SoapApi33Domain.CreateResponse create;
    public SoapApi33Domain.UpdateResponse update_x;
    public SoapApi33Domain.CommandResponse command;
    public SoapApi33Domain.AuthorizationResponse authorization;
    private String[] create_type_info = new List<String>{
      'create',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] update_x_type_info = new List<String>{
      'update',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] command_type_info = new List<String>{
      'command',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] authorization_type_info = new List<String>{
      'authorization',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'create',
      'update_x',
      'command',
      'authorization'
    };
  }
  public class ServicePeriodCounterResetCriteria {
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  /*public class OrderItem {
        public SoapApi33Domain.Product product;
        public SoapApi33Domain.PriceList priceList;
        public SoapApi33Domain.Agreement selectedAgreement;
        public SoapApi33Domain.ServiceResources serviceResources;
        public SoapApi33Domain.ServiceDeviceInventoryItem inventoryItem;
        public SoapApi33Domain.Service parentService;
        public SoapApi33Domain.OperationAttributes operationAttributes;
        public SoapApi33Domain.AgreementConfiguration agreementConfiguration;
        public SoapApi33Domain.ScheduledCharges scheduledCharges;
        public SoapApi33Domain.CustomFieldValues customFieldValues;
        public SoapApi33Domain.DiscountConfigurations discountConfigurations;
        public SoapApi33Domain.ScheduledOneTimePriceCharges scheduledOneTimePriceCharges;
        public SoapApi33Domain.addresses_element addresses;
        public Boolean awaitingApproval;
        public DateTime requestedEffectiveDate;
        public Integer overrideTrialDays;
        private String[] product_type_info = new String[]{'product','http://www.tractbilling.com/billing/1_33/domain',null,'1','1','false'};
        private String[] priceList_type_info = new String[]{'priceList','http://www.tractbilling.com/billing/1_33/domain',null,'0','1','false'};
        private String[] selectedAgreement_type_info = new String[]{'selectedAgreement','http://www.tractbilling.com/billing/1_33/domain',null,'0','1','false'};
        private String[] serviceResources_type_info = new String[]{'serviceResources','http://www.tractbilling.com/billing/1_33/domain',null,'0','1','false'};
        private String[] inventoryItem_type_info = new String[]{'inventoryItem','http://www.tractbilling.com/billing/1_33/domain',null,'0','1','false'};
        private String[] parentService_type_info = new String[]{'parentService','http://www.tractbilling.com/billing/1_33/domain',null,'0','1','false'};
        private String[] operationAttributes_type_info = new String[]{'operationAttributes','http://www.tractbilling.com/billing/1_33/domain',null,'0','1','false'};
        private String[] agreementConfiguration_type_info = new String[]{'agreementConfiguration','http://www.tractbilling.com/billing/1_33/domain',null,'0','1','false'};
        private String[] scheduledCharges_type_info = new String[]{'scheduledCharges','http://www.tractbilling.com/billing/1_33/domain',null,'0','1','false'};
        private String[] customFieldValues_type_info = new String[]{'customFieldValues','http://www.tractbilling.com/billing/1_33/domain',null,'0','1','false'};
        private String[] discountConfigurations_type_info = new String[]{'discountConfigurations','http://www.tractbilling.com/billing/1_33/domain',null,'0','1','false'};
        private String[] scheduledOneTimePriceCharges_type_info = new String[]{'scheduledOneTimePriceCharges','http://www.tractbilling.com/billing/1_33/domain',null,'0','1','false'};
        private String[] addresses_type_info = new String[]{'addresses','http://www.tractbilling.com/billing/1_33/domain',null,'0','1','false'};
        private String[] awaitingApproval_att_info = new String[]{'awaitingApproval'};
        private String[] requestedEffectiveDate_att_info = new String[]{'requestedEffectiveDate'};
        private String[] overrideTrialDays_att_info = new String[]{'overrideTrialDays'};
        private String[] apex_schema_type_info = new String[]{'http://www.tractbilling.com/billing/1_33/domain','true','false'};
        private String[] field_order_type_info = new String[]{'product','priceList','selectedAgreement','serviceResources','inventoryItem','parentService','operationAttributes','agreementConfiguration','scheduledCharges','customFieldValues','discountConfigurations','scheduledOneTimePriceCharges','addresses'};
    }*/
  public class OrderItem {
    //Added from BaseOrderItem
    public SoapApi33Domain.OrderItems orderItems;
    public SoapApi33Domain.OrderItemUsageRules orderItemUsageRules;
    public SoapApi33Domain.ProductPrice recurringProductPrice;
    public SOAPAPI33Domain.OrderItemPrices orderItemPrices;
    public SOAPAPI33Domain.ProductRegisterType registerType;
    public Decimal unitPrice;
    public Decimal recurringUnitPrice;
    public Decimal quantity;
    public Long sequence;
    public String approvalDate;
    public String description;
    public String eid;
    public String status;
    private String[] registerType_type_info = new List<String>{
      'registerType',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] orderItemPrices_type_info = new List<String>{
      'orderItemPrices',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] status_att_info = new List<String>{ 'status' };
    private String[] orderItems_type_info = new List<String>{
      'orderItems',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] orderItemUsageRules_type_info = new List<String>{
      'orderItemUsageRules',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] recurringProductPrice_type_info = new List<String>{
      'recurringProductPrice',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] unitPrice_att_info = new List<String>{ 'unitPrice' };
    private String[] recurringUnitPrice_att_info = new List<String>{
      'recurringUnitPrice'
    };
    private String[] quantity_att_info = new List<String>{ 'quantity' };
    private String[] sequence_att_info = new List<String>{ 'sequence' };
    private String[] approvalDate_att_info = new List<String>{ 'approvalDate' };
    private String[] description_att_info = new List<String>{ 'description' };
    private String[] eid_att_info = new List<String>{ 'eid' };

    public SoapApi33Domain.addresses_element addresses;
    public SoapApi33Domain.Product product;
    public SoapApi33Domain.PriceList priceList;
    public SoapApi33Domain.Agreement selectedAgreement;
    public SoapApi33Domain.ServiceResources serviceResources;
    public SoapApi33Domain.ServiceDeviceInventoryItem inventoryItem;
    public SoapApi33Domain.Service parentService;
    public SoapApi33Domain.OperationAttributes operationAttributes;
    public SoapApi33Domain.AgreementConfiguration agreementConfiguration;
    public SoapApi33Domain.ScheduledCharges scheduledCharges;
    public SoapApi33Domain.CustomFieldValues customFieldValues;
    public SoapApi33Domain.DiscountIdentifiers discountIdentifiers;
    public SoapApi33Domain.DiscountConfigurations discountConfigurations;
    public SoapApi33Domain.ScheduledOneTimePriceCharges scheduledOneTimePriceCharges;
    public SoapApi33Domain.SalesOrder salesOrder;
    public SoapApi33Domain.ChangeOrder changeOrder;
    public Boolean awaitingApproval;
    public DateTime requestedEffectiveDate;
    public Integer overrideTrialDays;

    private String[] product_type_info = new List<String>{
      'product',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] priceList_type_info = new List<String>{
      'priceList',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] selectedAgreement_type_info = new List<String>{
      'selectedAgreement',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] serviceResources_type_info = new List<String>{
      'serviceResources',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] inventoryItem_type_info = new List<String>{
      'inventoryItem',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] parentService_type_info = new List<String>{
      'parentService',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] operationAttributes_type_info = new List<String>{
      'operationAttributes',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] agreementConfiguration_type_info = new List<String>{
      'agreementConfiguration',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] scheduledCharges_type_info = new List<String>{
      'scheduledCharges',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] customFieldValues_type_info = new List<String>{
      'customFieldValues',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] discountIdentifiers_type_info = new List<String>{
      'discountIdentifiers',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] discountConfigurations_type_info = new List<String>{
      'discountConfigurations',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] scheduledOneTimePriceCharges_type_info = new List<String>{
      'scheduledOneTimePriceCharges',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] salesOrder_type_info = new List<String>{
      'salesOrder',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] changeOrder_type_info = new List<String>{
      'changeOrder',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] addresses_type_info = new List<String>{
      'addresses',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] awaitingApproval_att_info = new List<String>{
      'awaitingApproval'
    };
    private String[] requestedEffectiveDate_att_info = new List<String>{
      'requestedEffectiveDate'
    };
    private String[] overrideTrialDays_att_info = new List<String>{
      'overrideTrialDays'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'orderItems',
      'orderItemUsageRules',
      'recurringProductPrice',
      'product',
      'priceList',
      'selectedAgreement',
      'serviceResources',
      'inventoryItem',
      'parentService',
      'operationAttributes',
      'agreementConfiguration',
      'scheduledCharges',
      'customFieldValues',
      'discountIdentifiers',
      'discountConfigurations',
      'scheduledOneTimePriceCharges',
      'salesOrder',
      'addresses',
      'changeOrder',
      'orderItemPrices',
      'registerType'
    };
  }

  public class GLAccountingEntry {
    public SoapApi33Domain.GLAccount glAccount;
    public SoapApi33Domain.InvoiceItem invoiceItem;
    public SoapApi33Domain.AdditionalInformation[] additionalInformation;
    public Decimal amount;
    public Date occurredOn;
    public Boolean credit;
    public String description;
    public String currencyType;
    public Decimal convertedRate;
    public Decimal originalAmount;
    public String originalCurrencyType;
    private String[] glAccount_type_info = new List<String>{
      'glAccount',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] invoiceItem_type_info = new List<String>{
      'invoiceItem',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] additionalInformation_type_info = new List<String>{
      'additionalInformation',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] amount_att_info = new List<String>{ 'amount' };
    private String[] occurredOn_att_info = new List<String>{ 'occurredOn' };
    private String[] credit_att_info = new List<String>{ 'credit' };
    private String[] description_att_info = new List<String>{ 'description' };
    private String[] currencyType_att_info = new List<String>{ 'currencyType' };
    private String[] convertedRate_att_info = new List<String>{
      'convertedRate'
    };
    private String[] originalAmount_att_info = new List<String>{
      'originalAmount'
    };
    private String[] originalCurrencyType_att_info = new List<String>{
      'originalCurrencyType'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'glAccount',
      'invoiceItem',
      'additionalInformation'
    };
  }
  public class CounterResetCriteria {
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  /*public class TenantOrderItem {
        public String userName;
        public String firstName;
        public String lastName;
        public String email;
        public String timezone;
        public String currencyType;
        public String chargeFileType;
        public String website;
        private String[] userName_att_info = new String[]{'userName'};
        private String[] firstName_att_info = new String[]{'firstName'};
        private String[] lastName_att_info = new String[]{'lastName'};
        private String[] email_att_info = new String[]{'email'};
        private String[] timezone_att_info = new String[]{'timezone'};
        private String[] currencyType_att_info = new String[]{'currencyType'};
        private String[] chargeFileType_att_info = new String[]{'chargeFileType'};
        private String[] website_att_info = new String[]{'website'};
        private String[] apex_schema_type_info = new String[]{'http://www.tractbilling.com/billing/1_33/domain','true','false'};
        private String[] field_order_type_info = new String[]{};
    }*/
  public class TenantOrderItem {
    public String userName;
    public String firstName;
    public String lastName;
    public String email;
    private String[] userName_att_info = new List<String>{ 'userName' };
    private String[] firstName_att_info = new List<String>{ 'firstName' };
    private String[] lastName_att_info = new List<String>{ 'lastName' };
    private String[] email_att_info = new List<String>{ 'email' };

    //Copied from BaseOrderItem
    public SoapApi33Domain.OrderItems orderItems;
    public SoapApi33Domain.OrderItemUsageRules orderItemUsageRules;
    public SoapApi33Domain.ProductPrice recurringProductPrice;
    public Decimal unitPrice;
    public Decimal recurringUnitPrice;
    public Integer quantity;
    public Long sequence;
    public String approvalDate;
    public String description;
    private String[] orderItems_type_info = new List<String>{
      'orderItems',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] orderItemUsageRules_type_info = new List<String>{
      'orderItemUsageRules',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] recurringProductPrice_type_info = new List<String>{
      'recurringProductPrice',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] unitPrice_att_info = new List<String>{ 'unitPrice' };
    private String[] recurringUnitPrice_att_info = new List<String>{
      'recurringUnitPrice'
    };
    private String[] quantity_att_info = new List<String>{ 'quantity' };
    private String[] sequence_att_info = new List<String>{ 'sequence' };
    private String[] approvalDate_att_info = new List<String>{ 'approvalDate' };
    private String[] description_att_info = new List<String>{ 'description' };

    public String timezone;
    public String currencyType;
    public String chargeFileType;
    public String website;

    //Copied from OrderItem
    public SoapApi33Domain.Product product;
    public SoapApi33Domain.PriceList priceList;
    public SoapApi33Domain.Agreement selectedAgreement;
    public SoapApi33Domain.ServiceResources serviceResources;
    public SoapApi33Domain.ServiceDeviceInventoryItem inventoryItem;
    public SoapApi33Domain.Service parentService;
    public SoapApi33Domain.OperationAttributes operationAttributes;
    public SoapApi33Domain.AgreementConfiguration agreementConfiguration;
    public SoapApi33Domain.ScheduledCharges scheduledCharges;
    public SoapApi33Domain.CustomFieldValues customFieldValues;
    public SoapApi33Domain.DiscountIdentifiers discountIdentifiers;
    public Boolean awaitingApproval;
    public DateTime requestedEffectiveDate;
    public Integer overrideTrialDays;
    private String[] product_type_info = new List<String>{
      'product',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] priceList_type_info = new List<String>{
      'priceList',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] selectedAgreement_type_info = new List<String>{
      'selectedAgreement',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] serviceResources_type_info = new List<String>{
      'serviceResources',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] inventoryItem_type_info = new List<String>{
      'inventoryItem',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] parentService_type_info = new List<String>{
      'parentService',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] operationAttributes_type_info = new List<String>{
      'operationAttributes',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] agreementConfiguration_type_info = new List<String>{
      'agreementConfiguration',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] scheduledCharges_type_info = new List<String>{
      'scheduledCharges',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] customFieldValues_type_info = new List<String>{
      'customFieldValues',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] discountIdentifiers_type_info = new List<String>{
      'discountIdentifiers',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] awaitingApproval_att_info = new List<String>{
      'awaitingApproval'
    };
    private String[] timezone_att_info = new List<String>{ 'timezone' };
    private String[] currencyType_att_info = new List<String>{ 'currencyType' };
    private String[] chargeFileType_att_info = new List<String>{
      'chargeFileType'
    };
    private String[] website_att_info = new List<String>{ 'website' };
    private String[] requestedEffectiveDate_att_info = new List<String>{
      'requestedEffectiveDate'
    };
    private String[] overrideTrialDays_att_info = new List<String>{
      'overrideTrialDays'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'product',
      'priceList',
      'selectedAgreement',
      'serviceResources',
      'inventoryItem',
      'parentService',
      'operationAttributes',
      'agreementConfiguration',
      'scheduledCharges',
      'customFieldValues',
      'discountIdentifiers'
    };
  }
  public class ApprovalOperation {
    public DateTime autoApprovalDate;
    public Boolean autoApproveEnabled;
    private String[] autoApprovalDate_att_info = new List<String>{
      'autoApprovalDate'
    };
    private String[] autoApproveEnabled_att_info = new List<String>{
      'autoApproveEnabled'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class UsageLookupTableEntries {
    public SoapApi33Domain.UsageLookupTableEntry[] usageLookupTableEntry;
    private String[] usageLookupTableEntry_type_info = new List<String>{
      'usageLookupTableEntry',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'usageLookupTableEntry'
    };
  }
  public class TokenizedCreditCardPaymentMethod {
    public String token;
    public String cardType;
    public String cardHolderFirstName;
    public String cardHolderLastName;
    public String cardIdentifierNumber;
    public String cardExpiration;
    public String nickname;
    public String eid;
    public SoapApi33Domain.CustomFieldValues customFieldValues;
    public SoapApi33Domain.PostalAddress postalAddress;
    public SoapApi33Domain.EmailAddress emailAddress;
    public SoapApi33Domain.TelecomAddress telecomAddress;
    private String[] eid_att_info = new List<String>{ 'eid' };
    private String[] token_att_info = new List<String>{ 'token' };
    private String[] cardType_att_info = new List<String>{ 'cardType' };
    private String[] cardHolderFirstName_att_info = new List<String>{
      'cardHolderFirstName'
    };
    private String[] cardHolderLastName_att_info = new List<String>{
      'cardHolderLastName'
    };
    private String[] cardIdentifierNumber_att_info = new List<String>{
      'cardIdentifierNumber'
    };
    private String[] cardExpiration_att_info = new List<String>{
      'cardExpiration'
    };
    private String[] nickname_att_info = new List<String>{ 'nickname' };
    private String[] customFieldValues_type_info = new List<String>{
      'customFieldValues',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] postalAddress_type_info = new List<String>{
      'postalAddress',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] emailAddress_type_info = new List<String>{
      'emailAddress',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] telecomAddress_type_info = new List<String>{
      'telecomAddress',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class SepaDirectDebitPaymentMethod {
    public string reference;
    public SoapApi33Domain.CustomFieldValues customFieldValues;
    public String eid;
    public String iban;
    public string ownerName;
    private String[] ownerName_att_info = new List<String>{ 'ownerName' };
    private String[] iban_att_info = new List<String>{ 'iban' };
    private String[] eid_att_info = new List<String>{ 'eid' };
    private String[] reference_att_info = new List<String>{ 'reference' };
    private String[] customFieldValues_type_info = new List<String>{
      'customFieldValues',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }

  public class User {
    public String username;
    public String firstName;
    public String lastName;
    public String tenantEid;
    public String email;
    public String queryScope;
    private String[] username_att_info = new List<String>{ 'username' };
    private String[] firstName_att_info = new List<String>{ 'firstName' };
    private String[] lastName_att_info = new List<String>{ 'lastName' };
    private String[] tenantEid_att_info = new List<String>{ 'tenantEid' };
    private String[] email_att_info = new List<String>{ 'email' };
    private String[] queryScope_att_info = new List<String>{ 'queryScope' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }

  public class Note {
    public SoapApi33Domain.Organization organization;
    public SoapApi33Domain.Person person;
    public SoapApi33Domain.User user;
    public SoapApi33Domain.BillingAccount billingAccount;
    public String content;
    public SoapApi33Domain.NoteType noteType;
    private String[] noteType_type_info = new List<String>{
      'noteType',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] organization_type_info = new List<String>{
      'organization',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] person_type_info = new List<String>{
      'person',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] user_type_info = new List<String>{
      'user',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] billingAccount_type_info = new List<String>{
      'billingAccount',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
    private String[] content_att_info = new List<String>{ 'content' };
  }

  public class Notes {
    public SoapApi33Domain.Note[] note;
    public Integer totalPages;
    private String[] totalPages_att_info = new List<String>{ 'totalPages' };
    private String[] note_type_info = new List<String>{
      'note',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'note' };
  }

  public class NoteType {
    public String name;
    public String status;
    public String queryScope;
    private String[] name_att_info = new List<String>{ 'name' };
    private String[] status_att_info = new List<String>{ 'status' };
    private String[] queryScope_att_info = new List<String>{ 'queryScope' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }

  public class MobileCarrierPayment {
    public String msisdn;
    public String carrierName;
    public String nickname;
    public String eid;
    public SoapApi33Domain.CustomFieldValues customFieldValues;
    public SoapApi33Domain.PostalAddress postalAddress;
    public SoapApi33Domain.EmailAddress emailAddress;
    public SoapApi33Domain.TelecomAddress telecomAddress;
    private String[] msisdn_att_info = new List<String>{ 'msisdn' };
    private String[] carrierName_att_info = new List<String>{ 'carrierName' };
    private String[] nickname_att_info = new List<String>{ 'nickname' };
    private String[] eid_att_info = new List<String>{ 'eid' };
    private String[] customFieldValues_type_info = new List<String>{
      'customFieldValues',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] postalAddress_type_info = new List<String>{
      'postalAddress',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] emailAddress_type_info = new List<String>{
      'emailAddress',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] telecomAddress_type_info = new List<String>{
      'telecomAddress',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }

  public class BpayPaymentMethod {
    public String billerCode;
    public String customerReferenceNumber;
    public String eid;
    private String[] eid_att_info = new List<String>{ 'eid' };
    private String[] billerCode_att_info = new List<String>{ 'billerCode' };
    private String[] customerReferenceNumber_att_info = new List<String>{
      'customerReferenceNumber'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }

  public class CompatibleForChangeService {
    public Boolean preserveAgreement;
    public SoapApi33Domain.Service service;
    private String[] service_type_info = new List<String>{
      'service',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] preserveAgreement_att_info = new List<String>{
      'preserveAgreement'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'service' };
  }

  public class CompatibleForChangeServiceResponse {
    public SoapApi33Domain.Products products;
    private String[] products_type_info = new List<String>{
      'products',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'products' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
  }

  public class CreateAdjustment {
    public SoapApi33Domain.Invoice billedInvoice;
    public SoapApi33Domain.BillingAccount billingAccount;
    public SoapApi33Domain.AdjustmentReason reason;
    public SoapApi33Domain.AdjustmentApplications adjustmentApplications;
    public SoapApi33Domain.AdjustmentItems adjustmentItems;
    public String eid;
    public DateTime occurredOn;
    public Decimal amount;
    public String description;
    public Boolean invoiced;
    public Boolean credit;
    public String status;
    public String type_x;
    public DateTime postedOn;
    public String postedBy;
    public Boolean manualInvoiceApplication;
    public Decimal unappliedAmount;
    public String creditNumber;
    private String[] eid_att_info = new List<String>{ 'eid' };
    private String[] billedInvoice_type_info = new List<String>{
      'billedInvoice',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] billingAccount_type_info = new List<String>{
      'billingAccount',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] reason_type_info = new List<String>{
      'reason',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] adjustmentApplications_type_info = new List<String>{
      'adjustmentApplications',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] adjustmentItems_type_info = new List<String>{
      'adjustmentItems',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] occurredOn_att_info = new List<String>{ 'occurredOn' };
    private String[] amount_att_info = new List<String>{ 'amount' };
    private String[] description_att_info = new List<String>{ 'description' };
    private String[] invoiced_att_info = new List<String>{ 'invoiced' };
    private String[] credit_att_info = new List<String>{ 'credit' };
    private String[] status_att_info = new List<String>{ 'status' };
    private String[] type_x_att_info = new List<String>{ 'type' };
    private String[] postedOn_att_info = new List<String>{ 'postedOn' };
    private String[] postedBy_att_info = new List<String>{ 'postedBy' };
    private String[] creditNumber_att_info = new List<String>{ 'creditNumber' };
    private String[] unappliedAmount_att_info = new List<String>{
      'unappliedAmount'
    };
    private String[] manualInvoiceApplication_att_info = new List<String>{
      'manualInvoiceApplication'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'billedInvoice',
      'billingAccount',
      'reason',
      'adjustmentApplications',
      'adjustmentItems'
    };
  }

  public class ProductRegisterType {
    public String name;
    public String eid;
    public String queryScope;
    private String[] name_att_info = new List<String>{ 'name' };
    private String[] eid_att_info = new List<String>{ 'eid' };
    private String[] queryScope_att_info = new List<String>{ 'queryScope' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }

  public class ManualInvoiceReason {
    public String name;
    public String status;
    public String reasonType;
    public String eid;
    private String[] name_att_info = new List<String>{ 'name' };
    private String[] status_att_info = new List<String>{ 'status' };
    private String[] reasonType_att_info = new List<String>{ 'reasonType' };
    private String[] eid_att_info = new List<String>{ 'eid' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }

  public class OrderItemPrices {
    public SOAPAPI33Domain.OrderItemRecurringPrice orderItemRecurringPrice;
    public SOAPAPI33Domain.OrderItemOneTimePrice orderItemOneTimePrice;
    private String[] orderItemRecurringPrice_type_info = new List<String>{
      'orderItemRecurringPrice',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] orderItemOneTimePrice_type_info = new List<String>{
      'orderItemOneTimePrice',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'orderItemRecurringPrice',
      'orderItemOneTimePrice'
    };
  }

  public class OrderItemRecurringPrice {
    public Boolean prorateOnOrder;
    public Boolean prorateOnCancel;
    public Boolean prorateOnOrderNoCharge;
    public SoapApi33Domain.RecurringProductPrice recurringProductPrice;
    public SOAPAPI33Domain.OrderItemPriceRanges orderItempriceRanges;
    public SOAPAPI33Domain.PriceCategory priceCategory;
    public Decimal amount;
    public String eid;
    private String[] eid_att_info = new List<String>{ 'eid' };
    private String[] amount_att_info = new List<String>{ 'amount' };
    private String[] orderItempriceRanges_type_info = new List<String>{
      'orderItempriceRanges',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] priceCategory_type_info = new List<String>{
      'priceCategory',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] recurringProductPrice_type_info = new List<String>{
      'recurringProductPrice',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] prorateOnOrder_att_info = new List<String>{
      'prorateOnOrder'
    };
    private String[] prorateOnCancel_att_info = new List<String>{
      'prorateOnCancel'
    };
    private String[] prorateOnOrderNoCharge_att_info = new List<String>{
      'prorateOnOrderNoCharge'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'recurringProductPrice',
      'orderItempriceRanges',
      'priceCategory'
    };
  }

  public class OrderItemOneTimePrice {
    public SoapApi33Domain.OneTimeProductPrice oneTimeProductPrice;
    public SOAPAPI33Domain.OrderItemPriceRanges orderItempriceRanges;
    public SOAPAPI33Domain.PriceCategory priceCategory;
    public Decimal amount;
    public String eid;
    private String[] eid_att_info = new List<String>{ 'eid' };
    private String[] amount_att_info = new List<String>{ 'amount' };
    private String[] orderItempriceRanges_type_info = new List<String>{
      'orderItempriceRanges',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] priceCategory_type_info = new List<String>{
      'priceCategory',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] oneTimeProductPrice_type_info = new List<String>{
      'oneTimeProductPrice',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'oneTimeProductPrice',
      'orderItempriceRanges',
      'priceCategory'
    };
  }

  public class OrderItemPriceRanges {
    public SOAPAPI33Domain.OrderItemPriceRange[] orderItemPriceRange;
    private String[] orderItemPriceRange_type_info = new List<String>{
      'orderItemPriceRange',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'orderItemPriceRange'
    };
  }

  public class OrderItemPriceRange {
    public String quantityBeginRange;
    public String quantityEndRange;
    public String price;
    public Integer level;
    public String currencyType;
    private String[] quantityBeginRange_att_info = new List<String>{
      'quantityBeginRange'
    };
    private String[] quantityEndRange_att_info = new List<String>{
      'quantityEndRange'
    };
    private String[] price_att_info = new List<String>{ 'price' };
    private String[] level_att_info = new List<String>{ 'level' };
    private String[] currencyType_att_info = new List<String>{ 'currencyType' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }

  public class OrderItemChargeAdjustmentItemCharge {
    public SOAPAPI33Domain.OrderItemCharge orderItemCharge;
    public SoapApi33Domain.OrderItemAdjustmentItem orderItemAdjustmentItem;
    public SOAPAPI33Domain.PriceCategory[] priceCategory;
    public SoapApi33Domain.ServiceAdjustmentItem serviceAdjustmentItem;
    private String[] serviceAdjustmentItem_type_info = new List<String>{
      'serviceAdjustmentItem',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] priceCategory_type_info = new List<String>{
      'priceCategory',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] orderItemAdjustmentItem_type_info = new List<String>{
      'orderItemAdjustmentItem',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] orderItemCharge_type_info = new List<String>{
      'orderItemCharge',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'orderItemCharge',
      'orderItemAdjustmentItem',
      'priceCategory',
      'serviceAdjustmentItem'
    };
  }

  public class ServicePriceAdjustmentItemCharge {
    public SOAPAPI33Domain.ServicePrice servicePrice;
    public SoapApi33Domain.ServiceAdjustmentItem serviceAdjustmentItem;
    public SOAPAPI33Domain.PriceCategory priceCategory;
    private String[] priceCategory_type_info = new List<String>{
      'priceCategory',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] serviceAdjustmentItem_type_info = new List<String>{
      'serviceAdjustmentItem',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] servicePrice_type_info = new List<String>{
      'servicePrice',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'servicePrice',
      'serviceAdjustmentItem',
      'priceCategory'
    };
  }

  public class TaxAdjustmentItemCharge {
    public Integer taxCategoryId;
    public String description;
    public String code;
    public String level;
    public Decimal rate;
    public String jurisdiction;
    public SoapApi33Domain.ServiceAdjustmentItem serviceAdjustmentItem;
    public SOAPAPI33Domain.TaxPriceCategory taxPriceCategory;
    private String[] taxPriceCategory_type_info = new List<String>{
      'taxPriceCategory',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] serviceAdjustmentItem_type_info = new List<String>{
      'serviceAdjustmentItem',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] taxCategoryId_att_info = new List<String>{
      'taxCategoryId'
    };
    private String[] description_att_info = new List<String>{ 'description' };
    private String[] code_att_info = new List<String>{ 'code' };
    private String[] level_att_info = new List<String>{ 'level' };
    private String[] rate_att_info = new List<String>{ 'rate' };
    private String[] jurisdiction_att_info = new List<String>{ 'jurisdiction' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'serviceAdjustmentItem',
      'taxPriceCategory'
    };
  }

  public class AdjustmentItemCharges {
    public SOAPAPI33Domain.OrderItemChargeAdjustmentItemCharge orderItemChargeAdjustmentItemCharge;
    public SOAPAPI33Domain.ServicePriceAdjustmentItemCharge servicePriceAdjustmentItemCharge;
    public SOAPAPI33Domain.TaxAdjustmentItemCharge taxAdjustmentItemCharge;
    private String[] orderItemChargeAdjustmentItemCharge_type_info = new List<String>{
      'orderItemChargeAdjustmentItemCharge',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] servicePriceAdjustmentItemCharge_type_info = new List<String>{
      'servicePriceAdjustmentItemCharge',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] taxAdjustmentItemCharge_type_info = new List<String>{
      'taxAdjustmentItemCharge',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'orderItemChargeAdjustmentItemCharge',
      'servicePriceAdjustmentItemCharge',
      'taxAdjustmentItemCharge'
    };
  }

  public class MarketPlaces {
    public SOAPAPI33Domain.MarketPlace[] marketPlace;
    private String[] marketPlace_type_info = new List<String>{
      'marketPlace',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '-1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'marketPlace' };
  }

  public class MarketPlace {
    public SOAPAPI33Domain.PriceLists priceLists;
    public String name;
    public DateTime fromDate;
    public DateTime thruDate;
    public String description;
    public String eid;
    private String[] eid_att_info = new List<String>{ 'eid' };
    private String[] priceLists_type_info = new List<String>{
      'priceLists',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '0',
      '1',
      'false'
    };
    private String[] name_att_info = new List<String>{ 'name' };
    private String[] fromDate_att_info = new List<String>{ 'fromDate' };
    private String[] thruDate_att_info = new List<String>{ 'thruDate' };
    private String[] description_att_info = new List<String>{ 'description' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'priceLists' };
  }

  public class AddProductToPriceList {
    public SOAPAPI33Domain.Product product;
    public SOAPAPI33Domain.PriceList priceList;
    private String[] priceList_type_info = new List<String>{
      'priceList',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] product_type_info = new List<String>{
      'product',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'product',
      'priceList'
    };
  }

  public class RemoveProductFromPriceList {
    public SOAPAPI33Domain.Product product;
    public SOAPAPI33Domain.PriceList priceList;
    private String[] priceList_type_info = new List<String>{
      'priceList',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] product_type_info = new List<String>{
      'product',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'product',
      'priceList'
    };
  }

  public class DeleteMarketPlace {
    public SOAPAPI33Domain.MarketPlace marketPlace;
    private String[] marketPlace_type_info = new List<String>{
      'marketPlace',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'marketPlace' };
  }

  public class RemoveProductRelation {
    public SOAPAPI33Domain.Product relatedProduct;
    public SOAPAPI33Domain.Product product;
    public String type_x;
    public String eid;
    private String[] eid_att_info = new List<String>{ 'eid' };
    private String[] relatedProduct_type_info = new List<String>{
      'relatedProduct',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] product_type_info = new List<String>{
      'product',
      'http://www.tractbilling.com/billing/1_33/domain',
      null,
      '1',
      '1',
      'false'
    };
    private String[] type_x_att_info = new List<String>{ 'type' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/domain',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'relatedProduct',
      'product'
    };
  }
}