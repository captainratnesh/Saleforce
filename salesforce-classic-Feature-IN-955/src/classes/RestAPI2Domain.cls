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
 * The class contains the inner classes to parse JSON Response for various entities.
 * @author AMAN JAIN
 */

public with sharing class RestAPI2Domain {
  /**
   * A representation of a TRACT billing account
   */
  public class GTVAPIBillingAccount extends GTVAPIEntity implements GTVAPIRestClient.MappedProperties {
    /**
     * (unique_key)  The internal entity id for this entity representation
     * @return id
     */
    public String id { get; private set; }

    /**
     * (unique_key) The TRACT account number
     * @return accountNum
     */
    public String accountNum { get; private set; }

    /**
     * (unique_key) (nullable) An account number for this account tied to an external system
     * @return externalAccountNum
     */
    public String externalAccountNum { get; set; }

    /**
     * Get billCycle
     * @return billCycle
     */
    public GTVAPIBillCycle billCycle { get; set; }

    /**
     * Get responsibleParty
     * @return responsibleParty
     */
    public GTVAPIParty responsibleParty { get; set; }

    /**
     * Get billingAccountCategory
     * @return billingAccountCategory
     */
    public GTVAPIBillingAccountCategory billingAccountCategory { get; set; }

    /**
     * Get billType
     * @return billType
     */
    public GTVAPIBillType billType { get; set; }

    /**
     * Is the recurring payment used automatically
     * @return autoPaymentAuthorized
     */
    public Boolean autoPaymentAuthorized { get; set; }

    /**
     * Get status
     * @return status
     */
    public GTVAPIBillingAccountStatus status { get; set; }

    /**
     * Get pendingChargesTotal
     * @return pendingChargesTotal
     */
    public Double pendingChargesTotal { get; private set; }

    /**
     * Get balance
     * @return balance
     */
    public Double balance { get; private set; }

    /**
     * Get billingAccountSegment
     * @return billingAccountSegment
     */
    public GTVAPIBillingAccountSegment billingAccountSegment { get; set; }

    /**
     * Get currencyCode
     * @return currencyCode
     */
    public GTVAPICurrencyCode currencyCode { get; set; }

    /**
     * Get recurringPayments
     * @return recurringPayments
     */
    public List<GTVAPIRecurringPayment> recurringPayments { get; set; }

    /**
     * Get services
     * @return services
     */
    // @Resume on March 27, 2019
    public List<GTVAPISFService> services { get; set; }

    /**
     * Get pendingCharges
     * @return pendingCharges
     */
    public List<GTVAPIOrderItemCharge> pendingCharges { get; set; }

    /**
     * Get customFieldValues
     * @return customFieldValues
     */
    public List<GTVAPIBillingAccountCustomFieldVal> customFieldValues {
      get;
      set;
    }

    /**
     * Get contacts
     * @return contacts
     */
    public List<GTVAPIPerson> contacts { get; set; }

    /**
     * Get paymentTerm
     * @return paymentTerm
     */
    public GTVAPIPaymentTerm paymentTerm { get; set; }

    /**
     * Get startDate
     * @return startDate
     */
    public DateTime startDate { get; private set; }

    /**
     * Get endDate
     * @return endDate
     */
    public DateTime endDate { get; private set; }

    /**
     * Get taxExempt
     * @return taxExempt
     */
    public Boolean taxExempt { get; set; }

    /**
     * Get nextInvoiceDate
     * @return nextInvoiceDate
     */
    public DateTime nextInvoiceDate { get; private set; }

    /**
     * Get parentBillingAccount
     * @return parentBillingAccount
     */
    public GTVAPIBillingAccountRef parentBillingAccount { get; set; }

    /**
     * Get responsibleAccount
     * @return responsibleAccount
     */
    public GTVAPIBillingAccountRef responsibleAccount { get; set; }

    /* private final Map<String, Object> propertyMappings = new Map<String, Object>{
        'account_num' => 'accountNum',
        'external_account_num' => 'externalAccountNum',
        'bill_cycle' => new List<String>{'billCycle', 'GTVAPIBillCycle'},
        'responsible_party' => new List<String>{'responsibleParty', 'GTVAPIParty'},
        'billing_account_category' => new List<String>{'billingAccountCategory', 'GTVAPIBillingAccountCategory'},
        'bill_type' => 'billType',
        'auto_payment_authorized' => 'autoPaymentAuthorized',
        'pending_charges_total' => 'pendingChargesTotal',
        'billing_account_segment' => new List<String>{'billingAccountSegment', 'GTVAPIBillingAccountSegment'},
        'currency_code' => 'currencyCode',
        'recurring_payments' => new List<String>{'recurringPayments','GTVAPIRecurringPayment'},
        'pending_charges' => new List<String>{'pendingCharges','GTVAPIOrderItemCharge'},
        'custom_field_values' => new List<String>{'customFieldValues','GTVAPIBillingAccountCustomFieldVal'},
        'payment_term' => new List<String>{'paymentTerm','GTVAPIPaymentTerm'},
        'start_date' => 'startDate',
        'end_date' => 'endDate',
        'tax_exempt' => 'taxExempt',
        'next_invoice_date' => 'nextInvoiceDate',
        'parent_billing_account' => new List<String>{'parentBillingAccount','GTVAPIBillingAccountRef'},
        'responsible_account' => new List<String>{'responsibleAccount','GTVAPIBillingAccountRef'},
        'contacts' => new List<String>{'contacts','GTVAPIPerson'}
        };*/

    public virtual Map<String, Object> getPropertyMappings() {
      Map<String, Object> propertyMappings = new Map<String, Object>{
        'account_num' => 'accountNum',
        'external_account_num' => 'externalAccountNum',
        'bill_cycle' => new List<String>{ 'billCycle', 'GTVAPIBillCycle' },
        'responsible_party' => new List<String>{
          'responsibleParty',
          'GTVAPIParty'
        },
        'billing_account_category' => new List<String>{
          'billingAccountCategory',
          'GTVAPIBillingAccountCategory'
        },
        'bill_type' => 'billType',
        'auto_payment_authorized' => 'autoPaymentAuthorized',
        'pending_charges_total' => 'pendingChargesTotal',
        'billing_account_segment' => new List<String>{
          'billingAccountSegment',
          'GTVAPIBillingAccountSegment'
        },
        'currency_code' => 'currencyCode',
        'recurring_payments' => new List<String>{
          'recurringPayments',
          'GTVAPIRecurringPayment'
        },
        'pending_charges' => new List<String>{
          'pendingCharges',
          'GTVAPIOrderItemCharge'
        },
        'custom_field_values' => new List<String>{
          'customFieldValues',
          'GTVAPIBillingAccountCustomFieldVal'
        },
        'payment_term' => new List<String>{
          'paymentTerm',
          'GTVAPIPaymentTerm'
        },
        'start_date' => 'startDate',
        'end_date' => 'endDate',
        'tax_exempt' => 'taxExempt',
        'next_invoice_date' => 'nextInvoiceDate',
        'parent_billing_account' => new List<String>{
          'parentBillingAccount',
          'GTVAPIBillingAccountRef'
        },
        'responsible_account' => new List<String>{
          'responsibleAccount',
          'GTVAPIBillingAccountRef'
        },
        'contacts' => new List<String>{ 'contacts', 'GTVAPIPerson' }
      };
      return propertyMappings;
    }

    public GTVAPIBillingAccount() {
      autoPaymentAuthorized = false;
      recurringPayments = new List<GTVAPIRecurringPayment>();
      services = new List<GTVAPISFService>();
      pendingCharges = new List<GTVAPIOrderItemCharge>();
      customFieldValues = new List<GTVAPIBillingAccountCustomFieldVal>();
      contacts = new List<GTVAPIPerson>();
    }
  }

  /**
   * A representation of a TRACT entity object
   */
  public virtual class GTVAPIEntity {
    /**
     * (unique_key)  The internal entity id for this entity representation
     * @return id
     */
    public String id { get; set; }

    public virtual Boolean equals(Object obj) {
      if (obj instanceof GTVAPIEntity) {
        GTVAPIEntity entity = (GTVAPIEntity) obj;
        return this.id == entity.id;
      }
      return false;
    }

    public virtual Integer hashCode() {
      Integer hashCode = 43;
      hashCode = (17 * hashCode) + (id == null ? 0 : System.hashCode(id));
      return hashCode;
    }

    //public virtual Map<String, String> getPropertyMappings(){ return null;}
  }

  /**
   * The base object for all command objects.
   */
  public virtual class GTVAPICommand {
  }

  /**
   * A representation of a TRACT bill cycle
   */
  public virtual class GTVAPIBillCycle extends GTVAPIEntity implements GTVAPIRestClient.MappedProperties {
    /**
     * (unique_key)  The internal entity id for this entity representation
     * @return id
     */
    public String id { get; private set; }

    /**
     * Get billCycleType
     * @return billCycleType
     */
    public String billCycleType { get; set; }

    /**
     * (unique_key)
     * @return name
     */
    public String name { get; private set; }

    /**
     * Get startDate
     * @return startDate
     */
    public DateTime startDate { get; private set; }

    /**
     * Get endDate
     * @return endDate
     */
    public DateTime endDate { get; private set; }

    /**
     * Get autoBill
     * @return autoBill
     */
    public Boolean autoBill { get; private set; }

    /**
     * Get usePaymentTerm
     * @return usePaymentTerm
     */
    public Boolean usePaymentTerm { get; private set; }

    /**
     * Get status
     * @return status
     */
    public GTVAPIAccountingStatus status { get; set; }

    /**
     * Get currencyCode
     * @return currencyCode
     */
    public GTVAPICurrencyCode currencyCode { get; set; }

    /**
     * Get billingAccountCategory
     * @return billingAccountCategory
     */
    public GTVAPIBillingAccountCategory billingAccountCategory { get; set; }

    /*private final Map<String, String> propertyMappings = new Map<String, String>{
        'bill_cycle_type' => 'billCycleType',
        'start_date' => 'startDate',
        'end_date' => 'endDate',
        'auto_bill' => 'autoBill',
        'use_payment_term' => 'usePaymentTerm',
        'currency_code' => 'currencyCode'
        };*/

    public virtual Map<String, Object> getPropertyMappings() {
      Map<String, Object> propertyMappings = new Map<String, Object>{
        'bill_cycle_type' => 'billCycleType',
        'start_date' => 'startDate',
        'end_date' => 'endDate',
        'auto_bill' => 'autoBill',
        'use_payment_term' => 'usePaymentTerm',
        'currency_code' => 'currencyCode',
        'billing_account_category' => new List<String>{
          'billingAccountCategory',
          'GTVAPIBillingAccountCategory'
        }
      };
      return propertyMappings;
    }
  }
  public virtual class GTVAPIBillBatch extends GTVAPIEntity implements GTVAPIRestClient.MappedProperties {
    /**
     * (unique_key)  The internal entity id for this entity representation
     * @return id
     */
    public String id { get; private set; }

    /**
     * Get billCycleType
     * @return billCycleType
     */
    public String billCycleType { get; set; }

    /**
     * (unique_key)
     * @return name
     */
    public String name { get; private set; }

    public virtual Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'bill_cycle_type' => 'billCycleType',
        'name' => 'name'
      };
      return propertyMappings;
    }
  }

  /**
   * A representation of the core Monthly Bill Cycle entity. With it, you can view and assign Monthly Bill Cycles that you have created through the Gotransverse user interface.
   */
  public class GTVAPIMonthlyBillCycle extends GTVAPIBillCycle implements GTVAPIRestClient.MappedProperties {
    /**
     * The last date (1 through 31) of the monthly bill cycle.
     * minimum: 1
     * maximum: 31
     * @return dayOfMonth
     */
    public Integer dayOfMonth { get; private set; }

    /*private final Map<String, String> propertyMappings = new Map<String, String>{
        'use_payment_term' => 'usePaymentTerm',
        'internal_render' => 'internalRender',
        'currency_code' => 'currencyCode',
        'billing_account_category' => 'billingAccountCategory',
        'bill_cycle_type' => 'billCycleType',
        'current_bill_cycle_run' => 'currentBillCycleRun',
        'start_date' => 'startDate',
        'end_date' => 'endDate',
        'auto_bill' => 'autoBill',
        'auto_bill_delay_in_days' => 'autoBillDelayInDays',
        'auto_bill_run_up_to_date' => 'autoBillRunUpToDate',
        'invoice_due_date_in_days' => 'invoiceDueDateInDays',
        'day_of_month' => 'dayOfMonth'
    };
*/
    public override Map<String, Object> getPropertyMappings() {
      Map<String, Object> propertyMappings = new Map<String, Object>{
        'use_payment_term' => 'usePaymentTerm',
        'internal_render' => 'internalRender',
        'currency_code' => 'currencyCode',
        'billing_account_category' => 'billingAccountCategory',
        'bill_cycle_type' => 'billCycleType',
        'current_bill_cycle_run' => 'currentBillCycleRun',
        'start_date' => 'startDate',
        'end_date' => 'endDate',
        'auto_bill' => 'autoBill',
        'auto_bill_delay_in_days' => 'autoBillDelayInDays',
        'auto_bill_run_up_to_date' => 'autoBillRunUpToDate',
        'invoice_due_date_in_days' => 'invoiceDueDateInDays',
        'day_of_month' => 'dayOfMonth'
      };
      return propertyMappings;
    }
  }

  /**
   * A representation of the core Yearly Bill Cycle entity. With it, you can view and assign Yearly Bill Cycles that you have created through the Gotransverse user interface.
   */
  public class GTVAPIYearlyBillCycle extends GTVAPIBillCycle implements GTVAPIRestClient.MappedProperties {
    /**
     * The last day of the yearly cycle.
     * minimum: 1
     * maximum: 366
     * @return dayOfYear
     */
    public Integer dayOfYear { get; private set; }

    /* private final Map<String, String> propertyMappings = new Map<String, String>{
        'use_payment_term' => 'usePaymentTerm',
        'internal_render' => 'internalRender',
        'currency_code' => 'currencyCode',
        'billing_account_category' => 'billingAccountCategory',
        'bill_cycle_type' => 'billCycleType',
        'current_bill_cycle_run' => 'currentBillCycleRun',
        'start_date' => 'startDate',
        'end_date' => 'endDate',
        'auto_bill' => 'autoBill',
        'auto_bill_delay_in_days' => 'autoBillDelayInDays',
        'auto_bill_run_up_to_date' => 'autoBillRunUpToDate',
        'invoice_due_date_in_days' => 'invoiceDueDateInDays',
        'day_of_year' => 'dayOfYear'
    };
*/
    public override Map<String, Object> getPropertyMappings() {
      Map<String, Object> propertyMappings = new Map<String, Object>{
        'use_payment_term' => 'usePaymentTerm',
        'internal_render' => 'internalRender',
        'currency_code' => 'currencyCode',
        'billing_account_category' => 'billingAccountCategory',
        'bill_cycle_type' => 'billCycleType',
        'current_bill_cycle_run' => 'currentBillCycleRun',
        'start_date' => 'startDate',
        'end_date' => 'endDate',
        'auto_bill' => 'autoBill',
        'auto_bill_delay_in_days' => 'autoBillDelayInDays',
        'auto_bill_run_up_to_date' => 'autoBillRunUpToDate',
        'invoice_due_date_in_days' => 'invoiceDueDateInDays',
        'day_of_year' => 'dayOfYear'
      };
      return propertyMappings;
    }
  }

  /**
   * A representation of the core Quarterly Bill Cycle entity. With it, you can view and assign Quarterly Bill Cycles that you have created through the Gotransverse user interface.
   */
  public class GTVAPIQuarterlyBillCycle extends GTVAPIBillCycle implements GTVAPIRestClient.MappedProperties {
    /**
     * The last date (1 through 31) of the quarter.
     * minimum: 1
     * maximum: 31
     * @return dayOfMonth
     */
    public Integer dayOfMonth { get; private set; }

    /**
     * The last month (1 through 12) in the quarter.
     * minimum: 1
     * maximum: 12
     * @return endMonth
     */
    public Integer endMonth { get; private set; }

    /* private final Map<String, String> propertyMappings = new Map<String, String>{
        'use_payment_term' => 'usePaymentTerm',
        'internal_render' => 'internalRender',
        'currency_code' => 'currencyCode',
        'billing_account_category' => 'billingAccountCategory',
        'bill_cycle_type' => 'billCycleType',
        'current_bill_cycle_run' => 'currentBillCycleRun',
        'start_date' => 'startDate',
        'end_date' => 'endDate',
        'auto_bill' => 'autoBill',
        'auto_bill_delay_in_days' => 'autoBillDelayInDays',
        'auto_bill_run_up_to_date' => 'autoBillRunUpToDate',
        'invoice_due_date_in_days' => 'invoiceDueDateInDays',
        'day_of_month' => 'dayOfMonth',
        'end_month' => 'endMonth'
    };
*/
    public override Map<String, Object> getPropertyMappings() {
      Map<String, Object> propertyMappings = new Map<String, Object>{
        'use_payment_term' => 'usePaymentTerm',
        'internal_render' => 'internalRender',
        'currency_code' => 'currencyCode',
        'billing_account_category' => 'billingAccountCategory',
        'bill_cycle_type' => 'billCycleType',
        'current_bill_cycle_run' => 'currentBillCycleRun',
        'start_date' => 'startDate',
        'end_date' => 'endDate',
        'auto_bill' => 'autoBill',
        'auto_bill_delay_in_days' => 'autoBillDelayInDays',
        'auto_bill_run_up_to_date' => 'autoBillRunUpToDate',
        'invoice_due_date_in_days' => 'invoiceDueDateInDays',
        'day_of_month' => 'dayOfMonth',
        'end_month' => 'endMonth'
      };
      return propertyMappings;
    }
  }

  /**
   * Gets or Sets BillCycleType
   */
  public enum GTVAPIBillCycleType {
    daily,
    monthly,
    quarterly,
    yearly,
    SEGMENTED_MONTHLY
  }
  /**
   * Gets or Sets AccountingStatus
   */
  public enum GTVAPIAccountingStatus {
    ACTIVE,
    SUSPENDED,
    CANCELED
  }
  /**
   * Supported Currencies
   */
  public enum GTVAPICurrencyCode {
    USD,
    GBP,
    EUR,
    SEK,
    NOK,
    DKK,
    CAD,
    AUD,
    ZAR,
    NZD,
    MXN,
    INR,
    JPY,
    SAR,
    QAR,
    EGP,
    AED,
    BHD,
    KWD,
    TWD,
    PHP,
    OMR,
    HKD,
    CHF,
    ILS,
    CNY,
    BRL,
    PLN,
    COP,
    PEN,
    RUB,
    SGD,
    IDR,
    MYR,
    PKR,
    KRW,
    CZK,
    ARS,
    BWP,
    ISK,
    NGN,
    THB
  }

  /**
   * A command for moving a billing account to the different bill cycle.
   */
  public class GTVAPIChangeBillCycleCommand extends GTVAPICommand implements GTVAPIRestClient.MappedProperties {
    /**
     * Get billCycle
     * @return billCycle
     */
    public GTVAPIBillCycleRef billCycle { get; set; }

    /*private  final Map<String, String> propertyMappings = new Map<String, String>{
            'bill_cycle' => 'billCycle'
        };
*/
    public Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'bill_cycle' => 'billCycle'
      };
      return propertyMappings;
    }
  }

  /**
   * The Bill Cycle Run Action executes before invoices are rendered.
   */
  public class GTVAPIBillCycleRunAction extends GTVAPIAction implements GTVAPIRestClient.MappedProperties {
    /*private final Map<String, String> propertyMappings = new Map<String, String>{
            'friendly_name' => 'friendlyName',
            'supports_approval' => 'supportsApproval',
            'action_type' => 'actionType'
        };*/

    public override Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'friendly_name' => 'friendlyName',
        'supports_approval' => 'supportsApproval',
        'action_type' => 'actionType'
      };
      return propertyMappings;
    }

    public GTVAPIBillCycleRunAction() {
    }
  }

  /**
   * A base object for creating a new core entity.
   */
  public virtual class GTVAPICreateEntity {
  }

  /**
   * An abstract class for creating a bill cycle or bill batch.
   */
  public virtual class GTVAPICreateBillInterval extends GTVAPICreateEntity implements GTVAPIRestClient.MappedProperties {
    /**
     * (unique_key) A name of the bill cycle or bill batch that you have created.
     * @return name
     */
    public String name { get; set; }

    /**
     * Specifies whether the payment terms are used. Payment terms are the period of time between the invoice date and the invoice due date.
     * @return usePaymentTerm
     */
    public Boolean usePaymentTerm { get; set; }

    /*  private final Map<String, String> propertyMappings = new Map<String, String>{
            'use_payment_term' => 'usePaymentTerm'
        };
*/
    public virtual Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'use_payment_term' => 'usePaymentTerm'
      };
      return propertyMappings;
    }
  }

  /**
   * Creates a new bill cycle. A base entity for daily, monthly, quarterly, yearly, and segmented-monthly bill cycles.
   */
  public class GTVAPICreateBillCycle extends GTVAPICreateBillInterval implements GTVAPIRestClient.MappedProperties {
    /**
     * (unique_key) A name of the bill cycle or bill batch that you have created.
     * @return name
     */
    public String name { get; set; }

    /**
     * Specifies whether the payment terms are used. Payment terms are the period of time between the invoice date and the invoice due date.
     * @return usePaymentTerm
     */
    public Boolean usePaymentTerm { get; set; }

    /**
     * Get billCycleType
     * @return billCycleType
     */
    public GTVAPIBillCycleType billCycleType { get; set; }

    /**
     * The start date of the bill cycle.
     * @return startDate
     */
    public Date startDate { get; set; }

    /**
     * Specifies whether the bill cycle is billed automatically. \nGotransverse runs the bill cycles automatically on the day after the billing period expires.\n
     * @return autoBill
     */
    public Boolean autoBill { get; set; }

    /**
     * The number of days the bill cycle run should be run after the original close date.
     * minimum: 0
     * maximum: 100
     * @return autoBillDelayInDays
     */
    public Integer autoBillDelayInDays { get; set; }

    /**
     * The date and time until when the bill cycle automatically runs.
     * @return autoBillRunUpToDate
     */
    public Date autoBillRunUpToDate { get; set; }

    /**
     * Specifies whether the bill cycle is displayed in the Gotransverse user interface.
     * @return internalRender
     */
    public Boolean internalRender { get; set; }

    /**
     * The number of days after the invoice date and before it expires. The default value is 0. To change it, set the \'use_payment_term\' to false.
     * minimum: 0
     * maximum: 36500
     * @return invoiceDueDateInDays
     */
    public Integer invoiceDueDateInDays { get; set; }

    /**
     * Get currencyCode
     * @return currencyCode
     */
    public GTVAPICurrencyCode currencyCode { get; set; }

    /**
     * Get status
     * @return status
     */
    public GTVAPIAccountingStatus status { get; set; }

    /**
     * Get billingAccountCategory
     * @return billingAccountCategory
     */
    public GTVAPIBillingAccountCategoryRef billingAccountCategory { get; set; }

    /*private final Map<String, String> propertyMappings = new Map<String, String>{
                'use_payment_term' => 'usePaymentTerm',
                'bill_cycle_type' => 'billCycleType',
                'start_date' => 'startDate',
                'auto_bill' => 'autoBill',
                'auto_bill_delay_in_days' => 'autoBillDelayInDays',
                'auto_bill_run_up_to_date' => 'autoBillRunUpToDate',
                'internal_render' => 'internalRender',
                'invoice_due_date_in_days' => 'invoiceDueDateInDays',
                'currency_code' => 'currencyCode',
                'billing_account_category' => 'billingAccountCategory'
            };
*/
    public override Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'use_payment_term' => 'usePaymentTerm',
        'bill_cycle_type' => 'billCycleType',
        'start_date' => 'startDate',
        'auto_bill' => 'autoBill',
        'auto_bill_delay_in_days' => 'autoBillDelayInDays',
        'auto_bill_run_up_to_date' => 'autoBillRunUpToDate',
        'internal_render' => 'internalRender',
        'invoice_due_date_in_days' => 'invoiceDueDateInDays',
        'currency_code' => 'currencyCode',
        'billing_account_category' => 'billingAccountCategory'
      };
      return propertyMappings;
    }

    public GTVAPICreateBillCycle() {
      autoBill = false;
    }
  }

  /**
   * A representation of a TRACT party - person or organization
   */
  public virtual class GTVAPIParty extends GTVAPIEntity implements GTVAPIRestClient.MappedProperties {
    /**
     * (unique_key)  The internal entity id for this entity representation
     * @return id
     */
    public String id { get; private set; }

    /**
     * Get partyType
     * @return partyType
     */
    public GTVAPIPartyType partyType { get; set; }

    /**
     * Get taxIdNumber
     * @return taxIdNumber
     */
    public String taxIdNumber { get; private set; }

    /**
     * Get addresses
     * @return addresses
     */
    public List<GTVAPIAddress> addresses { get; set; }

    public string organizationName { get; set; }

    /*private final Map<String, object> propertyMappings = new Map<String, object>{
            'party_type' => 'partyType',
            'tax_id_number' => 'taxIdNumber',
            'addresses' => new List<String>{'addresses', 'GTVAPIAddress'},
            'organization_name' => 'organizationName'
            
            };
*/
    public virtual Map<String, object> getPropertyMappings() {
      Map<String, object> propertyMappings = new Map<String, object>{
        'party_type' => 'partyType',
        'tax_id_number' => 'taxIdNumber',
        'addresses' => new List<String>{ 'addresses', 'GTVAPIAddress' },
        'organization_name' => 'organizationName'
      };
      return propertyMappings;
    }

    public GTVAPIParty() {
      addresses = new List<GTVAPIAddress>();
    }
  }
  /**
   * Gets or Sets PartyType
   */
  public enum GTVAPIPartyType {
    PERSON,
    organization
  }

  /**
   * A representation of a core Organization entity. Organization can only be a responsible party for the billing account, and it cannot be used as an account contact.
   */
  public class GTVAPIOrganization extends GTVAPIParty implements GTVAPIRestClient.MappedProperties {
    /**
     * The name of the organization.
     * @return organizationName
     */
    public String organizationName { get; set; }

    /**
     * Specifies whether the tax ID number has been validated.
     * @return taxIdValidated
     */
    public Boolean taxIdValidated { get; private set; }

    /*  private final Map<String, String> propertyMappings = new Map<String, String>{
        'party_type' => 'partyType',
        'tax_id_number' => 'taxIdNumber',
        'organization_name' => 'organizationName',
        'tax_id_validated' => 'taxIdValidated'
    };
*/
    public override Map<String, Object> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'party_type' => 'partyType',
        'tax_id_number' => 'taxIdNumber',
        'organization_name' => 'organizationName',
        'tax_id_validated' => 'taxIdValidated'
      };
      return propertyMappings;
    }

    public GTVAPIOrganization() {
    }
  }

  /**
   * A representation of a TRACT address
   */
  public virtual class GTVAPIAddress extends GTVAPIEntity implements GTVAPIRestClient.MappedProperties {
    /**
     * (unique_key)  The internal entity id for this entity representation
     * @return id
     */
    public String id { get; private set; }

    /**
     * Get addressType
     * @return addressType
     */
    public GTVAPIAddressType addressType { get; set; }

    /**
     * Get purpose
     * @return purpose
     */
    public AddresssPurpose purpose { get; set; }

    /**
     * Get country
     * @return country
     */
    public String country { get; set; }

    /**
     * Get city
     * @return city
     */
    public String city { get; set; }

    /**
     * Get regionOrState
     * @return regionOrState
     */
    public String regionOrState { get; set; }

    /**
     * Get attention
     * @return attention
     */
    public String attention { get; set; }

    /**
     * Get postalCode
     * @return postalCode
     */
    public String postalCode { get; set; }

    /**
     * Get line1
     * @return line1
     */
    public String line1 { get; set; }

    /**
     * Get line2
     * @return line2
     */
    public String line2 { get; set; }

    /**
     * Get pCode
     * @return pCode
     */
    public Integer pCode { get; set; }

    /**
     * Get pCodeOverridden
     * @return pCodeOverridden
     */
    public Boolean pCodeOverridden { get; set; }

    /**
     * Get email
     * @return email
     */
    public String email { get; set; }

    /**
     * Get dialingPrefix
     * @return dialingPrefix
     */
    public String dialingPrefix { get; set; }

    /**
     * Get countryCode
     * @return countryCode
     */
    public String countryCode { get; set; }

    /**
     * Get areaCode
     * @return areaCode
     */
    public String areaCode { get; set; }

    /**
     * Get r_number
     * @return r_number
     */
    public String r_number { get; set; }

    /**
     * Get extension
     * @return extension
     */
    public String extension { get; set; }

    /*  private final Map<String, String> propertyMappings = new Map<String, String>{
        'address_type' => 'addressType',
        'region_or_state' => 'regionOrState',
        'postal_code' => 'postalCode',
        'p_code' => 'pCode',
        'p_code_overridden' => 'pCodeOverridden',
        'dialing_prefix' => 'dialingPrefix',
        'country_code' => 'countryCode',
        'area_code' => 'areaCode',
        'number' => 'r_number'
        };
*/
    public virtual Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'address_type' => 'addressType',
        'region_or_state' => 'regionOrState',
        'postal_code' => 'postalCode',
        'p_code' => 'pCode',
        'p_code_overridden' => 'pCodeOverridden',
        'dialing_prefix' => 'dialingPrefix',
        'country_code' => 'countryCode',
        'area_code' => 'areaCode',
        'number' => 'r_number'
      };
      return propertyMappings;
    }
  }
  /**
   * Gets or Sets AddressType
   */
  public enum GTVAPIAddressType {
    postal,
    email,
    telecom
  }
  /**
   * Gets or Sets AddresssPurpose
   */
  public enum AddresssPurpose {
    BILLING,
    SHIPPING,
    SERVICE,
    PAYMENT,
    PRIMARY,
    SECONDARY,
    OFFICE,
    HOME,
    FAX,
    MOBILE
  }
  /**
   * The account category for this account. Account categories are used for segmentation purposes and can be used to drive logic and behaviour throughout TRACT
   */
  public class GTVAPIBillingAccountCategory extends GTVAPIEntity {
    /**
     * (unique_key)  The internal entity id for this entity representation
     * @return id
     */
    public String id { get; private set; }

    /**
     * Get name
     * @return name
     */
    public String name { get; private set; }

    /**
     * Get description
     * @return description
     */
    public String description { get; private set; }

    /**
     * Get status
     * @return status
     */
    public GTVAPIBillingAccountCategoryStatus status { get; set; }
  }
  /**
   * Gets or Sets BillingAccountCategoryStatus
   */
  public enum GTVAPIBillingAccountCategoryStatus {
    ACTIVE,
    SUSPENDED,
    CANCELED
  }
  /**
   * Gets or Sets BillType
   */
  public enum GTVAPIBillType {
    PAPER,
    EMAIL,
    PAPER_EMAIL,
    NONE
  }
  /**
   * Gets or Sets BillingAccountStatus
   */
  public enum GTVAPIBillingAccountStatus {
    ACTIVE,
    SUSPENDED,
    PENDING,
    COLLECTION,
    DEACTIVATED,
    FINAL_BILL,
    CLOSED
  }
  /**
   * A Billing Account Segment entity
   */
  public class GTVAPIBillingAccountSegment extends GTVAPIEntity implements GTVAPIRestClient.MappedProperties {
    /**
     * (unique_key)  The internal entity id for this entity representation
     * @return id
     */
    public String id { get; private set; }

    /**
     * (unique_key) The category name
     * @return name
     */
    public String name { get; set; }

    /**
     * Get description
     * @return description
     */
    public String description { get; set; }

    /**
     * Get status
     * @return status
     */
    public GTVAPIBillingAccountSegmentStatus status { get; set; }

    /**
     * Get billingAccountSegmentFields
     * @return billingAccountSegmentFields
     */
    public List<GTVAPIBillingAccountSegmentField> billingAccountSegmentFields {
      get;
      set;
    }

    /*private final Map<String, String> propertyMappings = new Map<String, String>{
        'billing_account_segment_fields' => 'billingAccountSegmentFields'
        };
*/
    public Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'billing_account_segment_fields' => 'billingAccountSegmentFields'
      };
      return propertyMappings;
    }

    public GTVAPIBillingAccountSegment() {
      billingAccountSegmentFields = new List<GTVAPIBillingAccountSegmentField>();
    }
  }
  /**
   * Gets or Sets BillingAccountSegmentStatus
   */
  public enum GTVAPIBillingAccountSegmentStatus {
    DRAFT,
    ACTIVE,
    SUSPENDED
  }
  /**
   * A Billing Account Segment Field object.
   */
  public class GTVAPIBillingAccountSegmentField extends GTVAPIEntity implements GTVAPIRestClient.MappedProperties {
    /**
     * (unique_key)  The internal entity id for this entity representation
     * @return id
     */
    public String id { get; private set; }

    /**
     * Get fieldType
     * @return fieldType
     */
    public GTVAPIBillingAccountSegmentFieldTy fieldType { get; set; }

    /**
     * (unique_key) The field name
     * @return name
     */
    public String name { get; set; }

    /**
     * Get required
     * @return required
     */
    public Boolean required { get; set; }

    /*private final Map<String, String> propertyMappings = new Map<String, String>{
        'field_type' => 'fieldType'
        };
*/
    public Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'field_type' => 'fieldType'
      };
      return propertyMappings;
    }
  }
  /**
   * A TRACT BillingAccount Segment Field Type
   */
  public enum GTVAPIBillingAccountSegmentFieldTy {
    ORDER
  }
  /**
   * A base class for Create Service Resource and Create Discount Resource entities.
   */
  public virtual class GTVAPICreateResource extends GTVAPICreateEntity implements GTVAPIRestClient.MappedProperties {
    /**
     * Get resourceType
     * @return resourceType
     */
    public GTVAPIResourceType resourceType { get; set; }

    /**
     * (unique_key) The name of the resource identifier.
     * @return identifier
     */
    public String identifier { get; set; }

    /**
     * The description of the resource.
     * @return description
     */
    public String description { get; set; }

    /**
     * Get category
     * @return category
     */
    public GTVAPIResourceCategoryRef category { get; set; }
    /*
    private final Map<String, String> propertyMappings = new Map<String, String>{
        'resource_type' => 'resourceType'
    };
*/
    public virtual Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'resource_type' => 'resourceType'
      };
      return propertyMappings;
    }
  }

  /**
   * Creates a new service resource.
   */
  public class GTVAPICreateServiceResource extends GTVAPICreateResource implements GTVAPIRestClient.MappedProperties {
    /*private final Map<String, String> propertyMappings = new Map<String, String>{
        'resource_type' => 'resourceType'
    };
*/
    public override Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'resource_type' => 'resourceType'
      };
      return propertyMappings;
    }
  }
  /**
   * A Billing Account Recurring Payment object.
   */
  public class GTVAPIRecurringPayment extends GTVAPIEntity implements GTVAPIRestClient.MappedProperties {
    /**
     * (unique_key)  The internal entity id for this entity representation
     * @return id
     */
    public String id { get; set; }

    /**
     * Get paymentMethod
     * @return paymentMethod
     */
    public GTVAPIPaymentMethod paymentMethod { get; set; }

    /**
     * Get billingAccount
     * @return billingAccount
     */
    public GTVAPIBillingAccountRef billingAccount { get; set; }

    /**
     * Get validFrom
     * @return validFrom
     */
    public DateTime validFrom { get; private set; }

    /**
     * Get validTo
     * @return validTo
     */
    public DateTime validTo { get; private set; }

    /**
     * Get autoPayment
     * @return autoPayment
     */
    public Boolean autoPayment { get; private set; }

    /* private final Map<String, Object> propertyMappings = new Map<String, Object>{
        'payment_method' => new List<String>{'paymentMethod','GTVAPIPaymentMethod'},
        'billing_account' => 'billingAccount',
        'valid_from' => 'validFrom',
        'valid_to' => 'validTo',
        'auto_payment' => 'autoPayment'
        };
*/
    public Map<String, Object> getPropertyMappings() {
      Map<String, Object> propertyMappings = new Map<String, Object>{
        'payment_method' => new List<String>{
          'paymentMethod',
          'GTVAPIPaymentMethod'
        },
        'billing_account' => 'billingAccount',
        'valid_from' => 'validFrom',
        'valid_to' => 'validTo',
        'auto_payment' => 'autoPayment'
      };
      return propertyMappings;
    }
  }
  /**
   * A representation of the TRACT PaymentMethod
   */
  public class GTVAPIPaymentMethod extends GTVAPIEntity implements GTVAPIRestClient.MappedProperties, GTVAPIRestClient.ReverseMappedProperties {
    /**
     * (unique_key)  The internal entity id for this entity representation
     * @return id
     */
    public String id { get; set; }

    /**
     * Get paymentMethodType
     * @return paymentMethodType
     */
    public String paymentMethodType { get; set; }

    /**
     * Get customFieldValues
     * @return customFieldValues
     */
    public List<GTVAPIPaymentMethodCustomFieldValu> customFieldValues {
      get;
      set;
    }
    /**
     * Get reference key
     * @return reference
     */

    public String reference { get; set; }
    /**
     * Get cardType
     * @return cardType
     */
    public GTVAPICardType cardType { get; set; }

    /**
     * The first name of the person on the credit card.
     * @return firstName
     */
    public String firstName { get; private set; }

    /**
     * The middle name of the person on the credit card.
     * @return middleName
     */
    public String middleName { get; private set; }

    /**
     * The last name of the person on the credit card.
     * @return lastName
     */
    public String lastName { get; private set; }

    /**
     * The suffix of the name, such as "III" or "Jr." of the person on the credit card.
     * @return suffix
     */
    public String suffix { get; private set; }

    /**
     * The number on the credit card (16 digits for most cards).
     * @return identifierNumber
     */
    public String identifierNumber { get; private set; }

    /**
     * The expiration date of the credit card.
     * @return expirationDate
     */
    public String expirationDate { get; private set; }

    /**
     * The last 4 digits of the credit card number.
     * @return lastFour
     */
    public String lastFour { get; private set; }

    public String nickname { get; private set; }

    public GTVAPITelecomAddress telecomAddress { get; set; }

    public GTVAPIPostalAddress postalAddress { get; set; }

    public GTVAPIEmailAddress emailAddress { get; set; }

    public String billerCode { get; private set; }

    public String customerReferenceNumber { get; private set; }

    public String bankName { get; private set; }

    public String routingNumber { get; private set; }
    public String accountType { get; private set; }
    public String accountNumber { get; private set; }
    public String accountHolderName { get; private set; }

    public Map<String, object> getPropertyMappings() {
      Map<String, object> propertyMappings = new Map<String, object>{
        'payment_method_type' => 'paymentMethodType',
        'custom_field_values' => 'customFieldValues',
        'reference_key' => 'reference',
        'email_address' => 'emailAddress',
        'postal_address' => 'postalAddress',
        'telecom_address' => new List<String>{
          'telecomAddress',
          'GTVAPITelecomAddress'
        },
        'postal_address' => new List<String>{
          'postalAddress',
          'GTVAPIPostalAddress'
        },
        'card_type' => 'cardType',
        'first_name' => 'firstName',
        'biller_code' => 'billerCode',
        'customer_reference_number' => 'customerReferenceNumber',
        'bank_name' => 'bankName',
        'account_type' => 'accountType',
        'routing_number' => 'routingNumber',
        'account_number' => 'accountNumber',
        'account_holder_name' => 'accountHolderName',
        'middle_name' => 'middleName',
        'last_name' => 'lastName',
        'identifier_number' => 'identifierNumber',
        'expiration_date' => 'expirationDate',
        'last_four' => 'lastFour'
      };
      return propertyMappings;
    }
    public Map<String, object> getReversePropertyMappings() {
      Map<String, object> reversePropertyMappings = new Map<String, object>{
        'paymentMethodType' => 'payment_method_type',
        'customFieldValues' => 'custom_field_values',
        'reference' => 'reference_key'
      };
      return reversePropertyMappings;
    }
  }
  /**
   * GTVAPIPaymentMethodCustomFieldValu
   */
  public class GTVAPIPaymentMethodCustomFieldValu extends GTVAPICustomFieldValue implements GTVAPIRestClient.MappedProperties {
    /* private final Map<String, String> propertyMappings = new Map<String, String>{
        'custom_field_value_type' => 'customFieldValueType',
        'custom_field' => 'customField' 
        };
*/
    public override Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'custom_field_value_type' => 'customFieldValueType',
        'custom_field' => 'customField'
      };
      return propertyMappings;
    }
  }
  /**
   * The credit card types supported
   */
  public enum GTVAPICardType {
    AMEX,
    DINERSCLUB,
    DISCOVER,
    MASTERCARD,
    VISA
  }
  /**
   * GTVAPITelecomAddress
   */
  public class GTVAPITelecomAddress extends GTVAPIAddress implements GTVAPIRestClient.MappedProperties {
    /**
     * Get purpose
     * @return purpose
     */
    public GTVAPITelecomAddressPurpose purpose { get; set; }

    /**
     * Get dialingPrefix
     * @return dialingPrefix
     */
    public String dialingPrefix { get; set; }

    /**
     * Get countryCode
     * @return countryCode
     */
    public String countryCode { get; set; }

    /**
     * Get areaCode
     * @return areaCode
     */
    public String areaCode { get; set; }

    /**
     * Get r_number
     * @return r_number
     */
    public String r_number { get; set; }

    /**
     * Get extension
     * @return extension
     */
    public String extension { get; set; }

    /*private final Map<String, String> propertyMappings = new Map<String, String>{
        'address_type' => 'addressType',
        'dialing_prefix' => 'dialingPrefix',
        'country_code' => 'countryCode',
        'area_code' => 'areaCode',
        'number' => 'r_number'
        };*/

    public override Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'address_type' => 'addressType',
        'dialing_prefix' => 'dialingPrefix',
        'country_code' => 'countryCode',
        'area_code' => 'areaCode',
        'number' => 'r_number'
      };
      return propertyMappings;
    }
  }
  /**
   * Gets or Sets TelecomAddressPurpose
   */
  public enum GTVAPITelecomAddressPurpose {
    OFFICE,
    HOME,
    FAX,
    MOBILE,
    PAYMENT
  }
  /**
   * GTVAPIPostalAddress
   */
  public class GTVAPIPostalAddress extends GTVAPIAddress implements GTVAPIRestClient.MappedProperties {
    /**
     * Get purpose
     * @return purpose
     */
    public GTVAPIPostalAddressPurpose purpose { get; set; }
    /**
     * Get addressType
     * @return addressType
     */
    public GTVAPIAddressType address_type { get; set; }

    /**
     * Get country
     * @return country
     */
    public String country { get; set; }

    /**
     * Get city
     * @return city
     */
    public String city { get; set; }

    /**
     * Get regionOrState
     * @return regionOrState
     */
    public String region_or_state { get; set; }

    /**
     * Get attention
     * @return attention
     */
    public String attention { get; set; }

    /**
     * Get postalCode
     * @return postalCode
     */
    public String postal_code { get; set; }

    /**
     * Get line1
     * @return line1
     */
    public String line1 { get; set; }

    /**
     * Get line2
     * @return line2
     */
    public String line2 { get; set; }

    /**
     * Get pCode
     * @return pCode
     */
    public Integer pCode { get; set; }

    /**
     * Get pCodeOverridden
     * @return pCodeOverridden
     */
    public Boolean pCodeOverridden { get; set; }

    /* private final Map<String, String> propertyMappings = new Map<String, String>{
        'address_type' => 'addressType',
        'region_or_state' => 'regionOrState',
        'postal_code' => 'postalCode',
        'p_code' => 'pCode',
        'p_code_overridden' => 'pCodeOverridden'
        };
*/
    public override Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'address_type' => 'address_type',
        'region_or_state' => 'region_or_state',
        'postal_code' => 'postal_code',
        'p_code' => 'pCode',
        'p_code_overridden' => 'pCodeOverridden'
      };
      return propertyMappings;
    }
  }
  /**
   * Gets or Sets PostalAddressPurpose
   */
  public enum GTVAPIPostalAddressPurpose {
    BILLING,
    SHIPPING,
    SERVICE,
    PAYMENT,
    POSTAL
  }
  /**
   * GTVAPIEmailAddress
   */
  public class GTVAPIEmailAddress extends GTVAPIAddress implements GTVAPIRestClient.MappedProperties {
    /**
     * Get purpose
     * @return purpose
     */
    public GTVAPIEmailAddressPurpose purpose { get; set; }

    /**
     * Get email
     * @return email
     */
    public String email { get; set; }

    /*private final Map<String, String> propertyMappings = new Map<String, String>{
        'address_type' => 'addressType'
        };
*/
    public override Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'address_type' => 'addressType'
      };
      return propertyMappings;
    }
  }
  /**
   * Gets or Sets EmailAddressPurpose
   */
  public enum GTVAPIEmailAddressPurpose {
    PRIMARY,
    SECONDARY,
    PAYMENT
  }
  /**
   * A representation of a TRACT minimal billing account
   */
  public class GTVAPIBillingAccountRef extends GTVAPIEntityRef implements GTVAPIRestClient.MappedProperties {
    /**
     * (unique_key) The internal entity id for this entity representation
     * @return id
     */
    //public String id { get; set; }

    /**
     * (unique_key) The TRACT account number
     * @return accountNum
     */
    public String accountNum { get; set; }

    /**
     * (unique_key) An account number for this account tied to an external system
     * @return externalAccountNum
     */
    public String externalAccountNum { get; set; }

    /*  private final Map<String, String> propertyMappings = new Map<String, String>{
        'account_num' => 'accountNum',
        'external_account_num' => 'externalAccountNum'
        };
*/
    public Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'account_num' => 'accountNum',
        'external_account_num' => 'externalAccountNum'
      };
      return propertyMappings;
    }
  }
  /**
   * Creates the Postal Addess entity.
   */
  public class GTVAPICreatePostalAddress extends GTVAPICreateAddress implements GTVAPIRestClient.MappedProperties {
    /**
     * Get purpose
     * @return purpose
     */
    public GTVAPIPostalAddressPurpose purpose { get; set; }

    /**
     * The three-digit ISO country code.
     * @return country
     */
    public String country { get; set; }

    /**
     * The city of the address.
     * @return city
     */
    public String city { get; set; }

    /**
     * The two-digit ISO state, province, or region code.
     * @return regionOrState
     */
    public String regionOrState { get; set; }

    /**
     * Who to designate "Attention to:", if applicable.
     * @return attention
     */
    public String attention { get; set; }

    /**
     * The postal code of the address.
     * @return postalCode
     */
    public String postalCode { get; set; }

    /**
     * Address line one (street number).
     * @return line1
     */
    public String line1 { get; set; }

    /**
     * Address line two (apartment number and unit number).
     * @return line2
     */
    public String line2 { get; set; }

    /**
     * The postal code or zip code of the address.
     * @return pCode
     */
    public Integer pCode { get; set; }

    /**
     * Specifies whether the pcode can be set manually. If set to true, the pcode that is provided in a request is used. If set to false, and the pcode is not provided, the postal code is set automatically based on the tax processor.
     * @return pCodeOverridden
     */
    public Boolean pCodeOverridden { get; set; }

    /*  private final Map<String, String> propertyMappings = new Map<String, String>{
        'address_type' => 'addressType',
        'region_or_state' => 'regionOrState',
        'postal_code' => 'postalCode',
        'p_code' => 'pCode',
        'p_code_overridden' => 'pCodeOverridden'
    };*/

    public override Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'address_type' => 'addressType',
        'region_or_state' => 'regionOrState',
        'postal_code' => 'postalCode',
        'p_code' => 'pCode',
        'p_code_overridden' => 'pCodeOverridden'
      };
      return propertyMappings;
    }
  }
  /**
   * GTVAPISFService
   */
  public class GTVAPISFService extends GTVAPIEntity implements GTVAPIRestClient.MappedProperties {
    /**
     * (unique_key)  The internal entity id for this entity representation
     * @return id
     */
    public String id { get; private set; }

    /**
     * Get description
     * @return description
     */
    public String description { get; private set; }

    /**
     * Get amount
     * @return amount
     */
    public Double amount { get; private set; }

    /**
     * Get startDate
     * @return startDate
     */
    public DateTime startDate { get; private set; }

    /**
     * Get endDate
     * @return endDate
     */
    public DateTime endDate { get; private set; }

    /**
     * Get status
     * @return status
     */
    public GTVAPIServiceStatus status { get; set; }

    /**
     * Get statusReason
     * @return statusReason
     */
    public GTVAPIServiceReason statusReason { get; set; }

    /**
     * Get billingAccount
     * @return billingAccount
     */
    public GTVAPIBillingAccountRef billingAccount { get; set; }

    /**
     * Get statusDate
     * @return statusDate
     */
    public DateTime statusDate { get; private set; }

    /**
     * Get customFieldValues
     * @return customFieldValues
     */
    public List<GTVAPIServiceCustomFieldValue> customFieldValues { get; set; }

    /**
     * Get oldLevel
     * @return oldLevel
     */
    public Integer oldLevel { get; private set; }

    /**
     * Get currentLevel
     * @return currentLevel
     */
    public Integer currentLevel { get; private set; }

    /**
     * Get quantity
     * @return quantity
     */
    public Double quantity { get; private set; }

    /**
     * Consume Prepaid Balances
     * @return consumePrepaidBalance
     */
    public Boolean consumePrepaidBalance { get; private set; }

    /**
     * Get addresses
     * @return addresses
     */
    public List<GTVAPIPostalAddress> addresses { get; set; }

    /**
     * Get serviceResources
     * @return serviceResources
     */
    public List<GTVAPIServiceResource> serviceResources { get; set; }

    /**
     * Get product
     * @return product
     */
    public GTVAPIProductRef product { get; set; }

    /**
     * Get parentService
     * @return parentService
     */
    public GTVAPIServiceRef parentService { get; set; }

    /**
     * Get currentAgreementService
     * @return currentAgreementService
     */
    public GTVAPIAgreement currentAgreementService { get; set; }

    /**
     * Get servicePrices
     * @return servicePrices
     */
    public List<GTVAPIServicePrice> servicePrices { get; set; }

    /**
     * Get renewalCount
     * @return renewalCount
     */
    public Integer renewalCount { get; private set; }

    /**
     * Get commitmentEndDate
     * @return commitmentEndDate
     */
    public DateTime commitmentEndDate { get; private set; }

    /**
     * Get nextService
     * @return nextService
     */
    public GTVAPIServiceRef nextService { get; set; }

    /**
     * Get usageRules
     * @return usageRules
     */
    // @ToDo import supported class
    //public List<GTVAPIServiceUsageRule> usageRules { get; set; }

    /*   private final Map<String, object> propertyMappings = new Map<String, object>{
        'start_date' => 'startDate',
        'end_date' => 'endDate',
        'status_reason' => 'statusReason',
        'billing_account' => 'billingAccount',
        'status_date' => 'statusDate',
        'custom_field_values' => 'customFieldValues',
        'old_level' => 'oldLevel',
        'current_level' => 'currentLevel',
        'consume_prepaid_balance' => 'consumePrepaidBalance',
        'service_resources' => 'serviceResources',
        'parent_service' => 'parentService',
        'current_agreement_service' => 'currentAgreementService',
        'service_prices' => 'servicePrices',
        'renewal_count' => 'renewalCount',
        'commitment_end_date' => 'commitmentEndDate',
        'next_service' => 'nextService',
        'product_type' => new List<String>{'productType','GTVAPIProductRef'}
           // 'usage_rules' => 'usageRules'
        };*/

    public Map<String, Object> getPropertyMappings() {
      Map<String, object> propertyMappings = new Map<String, object>{
        'start_date' => 'startDate',
        'end_date' => 'endDate',
        'status_reason' => 'statusReason',
        'billing_account' => 'billingAccount',
        'status_date' => 'statusDate',
        'custom_field_values' => 'customFieldValues',
        'old_level' => 'oldLevel',
        'current_level' => 'currentLevel',
        'consume_prepaid_balance' => 'consumePrepaidBalance',
        'service_resources' => 'serviceResources',
        'parent_service' => 'parentService',
        'current_agreement_service' => 'currentAgreementService',
        'service_prices' => 'servicePrices',
        'renewal_count' => 'renewalCount',
        'commitment_end_date' => 'commitmentEndDate',
        'next_service' => 'nextService',
        'product_type' => new List<String>{ 'productType', 'GTVAPIProductRef' }
        // 'usage_rules' => 'usageRules'
      };
      return propertyMappings;
    }

    public GTVAPISFService() {
      customFieldValues = new List<GTVAPIServiceCustomFieldValue>();
      addresses = new List<GTVAPIPostalAddress>();
      serviceResources = new List<GTVAPIServiceResource>();
      servicePrices = new List<GTVAPIServicePrice>();
      // usageRules = new List<GTVAPIServiceUsageRule>();
    }
  }
  /**
   * Gets or Sets ServiceStatus
   */
  public enum GTVAPIServiceStatus {
    ACTIVE,
    SUSPENDED,
    DEACTIVATED,
    PENDING,
    CANCELED,
    TRANSFERRED,
    REPLACED,
    TRIAL,
    SCHEDULED
  }
  /**
   * GTVAPIServiceReason
   */
  public virtual class GTVAPIServiceReason extends GTVAPIReason implements GTVAPIRestClient.MappedProperties {
    /**
     * Get reasonType
     * @return reasonType
     */
    public string reasonType { get; set; }

    /*  private final Map<String, String> propertyMappings = new Map<String, String>{
        'reason_entity_type' => 'reasonEntityType',
        'reason_type' => 'reasonType'
        };
*/
    public virtual Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'reason_entity_type' => 'reasonEntityType',
        'reason_type' => 'reasonType'
      };
      return propertyMappings;
    }
  }
  /**
   * Gets or Sets ServiceReasonType
   */
  public enum GTVAPIServiceReasonType {
    SERVICE_SUSPENSION,
    SERVIVE_DEACTIVATION
  }
  /**
   * GTVAPIServiceCustomFieldValue
   */
  public class GTVAPIServiceCustomFieldValue extends GTVAPICustomFieldValue implements GTVAPIRestClient.MappedProperties {
    /*   private final Map<String, String> propertyMappings = new Map<String, String>{
        'custom_field_value_type' => 'customFieldValueType',
        'custom_field' => 'customField'
        };
*/
    public override Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'custom_field_value_type' => 'customFieldValueType',
        'custom_field' => 'customField'
      };
      return propertyMappings;
    }
  }
  /**
   * GTVAPIServiceResource
   */
  public class GTVAPIServiceResource extends GTVAPIGenericResource implements GTVAPIRestClient.MappedProperties {
    /**
     * Get autoSelect
     * @return autoSelect
     */
    public Boolean autoSelect { get; set; }

    /**
     * Get status
     * @return status
     */
    public GTVAPIServiceResourceStatus status { get; set; }

    /*  private final Map<String, String> propertyMappings = new Map<String, String>{
        'resource_type' => 'resourceType',
        'auto_select' => 'autoSelect'
        };
*/
    public override Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'resource_type' => 'resourceType',
        'auto_select' => 'autoSelect'
      };
      return propertyMappings;
    }
  }
  /**
   * Gets or Sets ServiceResourceStatus
   */
  public enum GTVAPIServiceResourceStatus {
    REQUESTED,
    AVAILABLE,
    ACTIVE,
    DEACTIVATED,
    QUARANTINED,
    USED,
    RESERVED
  }
  /**
   * GTVAPIProductRef
   */
  public class GTVAPIProductRef extends GTVAPIEntityRef implements GTVAPIRestClient.MappedProperties, GTVAPIRestClient.ReverseMappedProperties {
    /**
     * (unique_key) The internal entity id for this entity representation
     * @return id
     */
    public String id { get; set; }

    /**
     * Get productType
     * @return productType
     */
    public String productType { get; set; }

    /**
     * Get name
     * @return name
     */
    public String name { get; set; }

    /**
     * Get sku
     * @return sku
     */
    public String sku { get; set; }

    /* private final Map<String, String> propertyMappings = new Map<String, String>{
        'product_type' => 'productType'
        };
*/
    public Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'product_type' => 'productType'
      };
      return propertyMappings;
    }
    public Map<String, String> getReversePropertyMappings() {
      Map<String, String> reversePropertyMappings = new Map<String, String>{
        'productType' => 'product_type'
      };
      return reversePropertyMappings;
    }
  }
  /**
   * GTVAPIServiceRef
   */
  public class GTVAPIServiceRef extends GTVAPIEntityRef {
    /**
     * (unique_key) The internal entity id for this entity representation
     * @return id
     */
    //public String id { get; set; }
  }
  /**
   * models the Agreement object in TRACT
   */
  public class GTVAPIAgreement extends GTVAPIEntity implements GTVAPIRestClient.MappedProperties {
    /**
     * (unique_key)  The internal entity id for this entity representation
     * @return id
     */
    public String id { get; private set; }

    /**
     * Get name
     * @return name
     */
    public String name { get; private set; }

    /**
     * Get agreementPeriod
     * @return agreementPeriod
     */
    public Integer agreementPeriod { get; private set; }

    /**
     * Get status
     * @return status
     */
    public String status { get; set; }

    /**
     * Get terminationFlatCharge
     * @return terminationFlatCharge
     */
    public Double terminationFlatCharge { get; private set; }

    /**
     * Get terminationPercentageCharge
     * @return terminationPercentageCharge
     */
    public Decimal terminationPercentageCharge { get; private set; }

    /**
     * Get maxTerminationCharge
     * @return maxTerminationCharge
     */
    public Double maxTerminationCharge { get; private set; }

    /**
     * Get prorateOnCancel
     * @return prorateOnCancel
     */
    public Boolean prorateOnCancel { get; private set; }

    /**
     * Get adjustmentCategory
     * @return adjustmentCategory
     */
    public GTVAPIAdjustmentCategoryRef adjustmentCategory { get; set; }

    /**
     * Get endAction
     * @return endAction
     */
    public GTVAPIAgreementEndActionType endAction { get; set; }

    /**
     * Get terminationFeeCurrencyCode
     * @return terminationFeeCurrencyCode
     */
    public GTVAPICurrencyCode terminationFeeCurrencyCode { get; set; }

    /**
     * Get maxTerminationFeeCurrencyCode
     * @return maxTerminationFeeCurrencyCode
     */
    public GTVAPICurrencyCode maxTerminationFeeCurrencyCode { get; set; }

    /**
     * Get validFrom
     * @return validFrom
     */
    public DateTime validFrom { get; private set; }

    /**
     * Get validTo
     * @return validTo
     */
    public DateTime validTo { get; private set; }

    /**
     * Get nextAgreement
     * @return nextAgreement
     */
    public GTVAPIAgreementRef nextAgreement { get; set; }

    /**
     * Get agreementPeriodType
     * @return agreementPeriodType
     */
    public GTVAPIAgreementPeriodType agreementPeriodType { get; set; }

    /**
     * Get minimumAmount
     * @return minimumAmount
     */
    public Double minimumAmount { get; private set; }

    /**
     * Get minimumAmountCurrencyType
     * @return minimumAmountCurrencyType
     */
    public GTVAPICurrencyCode minimumAmountCurrencyType { get; set; }

    /**
     * Get trueUpAdjustmentReason
     * @return trueUpAdjustmentReason
     */
    public GTVAPIAdjustmentReasonRef trueUpAdjustmentReason { get; set; }

    /**
     * Get trueUpChargeTypes
     * @return trueUpChargeTypes
     */
    public List<GTVAPITrueUpChargeType> trueUpChargeTypes { get; set; }

    /**
     * Get preserveServicePrice
     * @return preserveServicePrice
     */
    public Boolean preserveServicePrice { get; private set; }
    /*
        private final Map<String, String> propertyMappings = new Map<String, String>{
        'agreement_period' => 'agreementPeriod',
        'termination_flat_charge' => 'terminationFlatCharge',
        'termination_percentage_charge' => 'terminationPercentageCharge',
        'max_termination_charge' => 'maxTerminationCharge',
        'prorate_on_cancel' => 'prorateOnCancel',
        'adjustment_category' => 'adjustmentCategory',
        'end_action' => 'endAction',
        'termination_fee_currency_code' => 'terminationFeeCurrencyCode',
        'max_termination_fee_currency_code' => 'maxTerminationFeeCurrencyCode',
        'valid_from' => 'validFrom',
        'valid_to' => 'validTo',
        'next_agreement' => 'nextAgreement',
        'agreement_period_type' => 'agreementPeriodType',
        'minimum_amount' => 'minimumAmount',
        'minimum_amount_currency_type' => 'minimumAmountCurrencyType',
        'true_up_adjustment_reason' => 'trueUpAdjustmentReason',
        'true_up_charge_types' => 'trueUpChargeTypes',
        'preserve_service_price' => 'preserveServicePrice'
        };
*/
    public Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'agreement_period' => 'agreementPeriod',
        'termination_flat_charge' => 'terminationFlatCharge',
        'termination_percentage_charge' => 'terminationPercentageCharge',
        'max_termination_charge' => 'maxTerminationCharge',
        'prorate_on_cancel' => 'prorateOnCancel',
        'adjustment_category' => 'adjustmentCategory',
        'end_action' => 'endAction',
        'termination_fee_currency_code' => 'terminationFeeCurrencyCode',
        'max_termination_fee_currency_code' => 'maxTerminationFeeCurrencyCode',
        'valid_from' => 'validFrom',
        'valid_to' => 'validTo',
        'next_agreement' => 'nextAgreement',
        'agreement_period_type' => 'agreementPeriodType',
        'minimum_amount' => 'minimumAmount',
        'minimum_amount_currency_type' => 'minimumAmountCurrencyType',
        'true_up_adjustment_reason' => 'trueUpAdjustmentReason',
        'true_up_charge_types' => 'trueUpChargeTypes',
        'preserve_service_price' => 'preserveServicePrice'
      };
      return propertyMappings;
    }

    public GTVAPIAgreement() {
      trueUpChargeTypes = new List<GTVAPITrueUpChargeType>();
    }
  }
  /**
   * GTVAPIAdjustmentCategoryRef
   */
  public class GTVAPIAdjustmentCategoryRef extends GTVAPIChargeCategoryRef implements GTVAPIRestClient.MappedProperties {
    /*  private final Map<String, String> propertyMappings = new Map<String, String>{
        'charge_category_type' => 'chargeCategoryType'
        };
*/
    public override Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'charge_category_type' => 'chargeCategoryType'
      };
      return propertyMappings;
    }
  }
  /**
   * Gets or Sets AgreementEndActionType
   */
  public enum GTVAPIAgreementEndActionType {
    RENEW_AGREEMENT,
    SERVICE_ONLY,
    DEACTIVATE_SERVICE,
    CHANGE_AGREEMENT,
    CHANGE_SERVICE,
    CPQ_MANAGED
  }
  /**
   * models the Agreement object in TRACT
   */
  public class GTVAPIAgreementRef extends GTVAPIEntityRef {
    /**
     * (unique_key) The internal entity id for this entity representation
     * @return id
     */
    public String id { get; set; }

    /**
     * Get name
     * @return name
     */
    public String name { get; set; }
  }
  /**
   * Gets or Sets AgreementPeriodType
   */
  public enum GTVAPIAgreementPeriodType {
    MONTH,
    DAY
  }
  /**
   * GTVAPIAdjustmentReasonRef
   */
  public class GTVAPIAdjustmentReasonRef extends GTVAPIEntityRef {
    /**
     * (unique_key) The internal entity id for this entity representation
     * @return id
     */
    // public String id { get; set; }

    /**
     * (unique_key) The name of TRACT adjustment reason
     * @return name
     */
    public String name { get; set; }
  }
  /**
   * Gets or Sets TrueUpChargeType
   */
  public enum GTVAPITrueUpChargeType {
    DISCOUNT,
    ONETIME,
    RECURRING,
    USAGE
  }

  /**
   * A reference to the core Product Recurring Price entity.
   */
  public class GTVAPIProductRecurringPriceRef extends GTVAPIProductPriceRef implements GTVAPIRestClient.MappedProperties {
    /*  private final Map<String, String> propertyMappings = new Map<String, String>{
        'price_type' => 'priceType',
        'product_price_type' => 'productPriceType'
    };
*/
    public override Map<String, Object> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'price_type' => 'priceType',
        'product_price_type' => 'productPriceType'
      };
      return propertyMappings;
    }
  }

  /**
   * Creates an agreement on the specified service.
   */
  public virtual class GTVAPICreateAgreementServiceObject extends GTVAPICreateEntity implements GTVAPIRestClient.MappedProperties {
    /**
     * Get agreement
     * @return agreement
     */
    public GTVAPIAgreementRef agreement { get; set; }

    /**
     * The date when the order item agreement ends.
     * @return endDate
     */
    public Datetime endDate { get; set; }

    /**
     * Get endAction
     * @return endAction
     */
    public GTVAPIAgreementEndActionType endAction { get; set; }

    /**
     * Get nextAgreement
     * @return nextAgreement
     */
    public GTVAPIAgreementRef nextAgreement { get; set; }

    /**
     * Get nextEndAction
     * @return nextEndAction
     */
    public GTVAPIAgreementNextEndActionType nextEndAction { get; set; }

    /**
     * Get nextServiceProduct
     * @return nextServiceProduct
     */
    public GTVAPIProductRef nextServiceProduct { get; set; }

    /**
     * Get nextServiceProductPrice
     * @return nextServiceProductPrice
     */
    public GTVAPIProductRecurringPriceRef nextServiceProductPrice { get; set; }

    /**
     * Specifies whether the price of the renewed service will be the same as the original service price.
     * @return preserveServicePrice
     */
    public Boolean preserveServicePrice { get; set; }

    /**
     * Get nextPreserveServicePrice
     * @return nextPreserveServicePrice
     */
    public Boolean nextPreserveServicePrice { get; set; }

    /**
     * The length of the agreement.
     * @return agreementPeriod
     */
    public Integer agreementPeriod { get; set; }

    /**
     * The minimum change for the agreement, used for true up charges.
     * @return minimumAmount
     */
    public Double minimumAmount { get; set; }

    /**
     * Specifies whether the minimum amount that is minimum change for the agreement is omitted. If set to true, the minimum amount of the agreement is not taken into account. If set to false, the minimum amount is applied to the agreement service.\n
     * @return omitMinimumAmount
     */
    public Boolean omitMinimumAmount { get; set; }

    /**
     * Get trueUpChargeTypes
     * @return trueUpChargeTypes
     */
    public List<GTVAPITrueUpChargeType> trueUpChargeTypes { get; set; }

    /* private final Map<String, String> propertyMappings = new Map<String, String>{
        'end_date' => 'endDate',
        'end_action' => 'endAction',
        'next_agreement' => 'nextAgreement',
        'next_end_action' => 'nextEndAction',
        'next_service_product' => 'nextServiceProduct',
        'next_service_product_price' => 'nextServiceProductPrice',
        'preserve_service_price' => 'preserveServicePrice',
        'next_preserve_service_price' => 'nextPreserveServicePrice',
        'agreement_period' => 'agreementPeriod',
        'minimum_amount' => 'minimumAmount',
        'omit_minimum_amount' => 'omitMinimumAmount',
        'true_up_charge_types' => 'trueUpChargeTypes'
    };
*/
    public virtual Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'end_date' => 'endDate',
        'end_action' => 'endAction',
        'next_agreement' => 'nextAgreement',
        'next_end_action' => 'nextEndAction',
        'next_service_product' => 'nextServiceProduct',
        'next_service_product_price' => 'nextServiceProductPrice',
        'preserve_service_price' => 'preserveServicePrice',
        'next_preserve_service_price' => 'nextPreserveServicePrice',
        'agreement_period' => 'agreementPeriod',
        'minimum_amount' => 'minimumAmount',
        'omit_minimum_amount' => 'omitMinimumAmount',
        'true_up_charge_types' => 'trueUpChargeTypes'
      };
      return propertyMappings;
    }

    public GTVAPICreateAgreementServiceObject() {
      trueUpChargeTypes = new List<GTVAPITrueUpChargeType>();
    }
  }

  /**
   * Creates a new Order Item Agreement.
   */
  public class GTVAPICreateOrderItemAgreement extends GTVAPICreateAgreementServiceObject implements GTVAPIRestClient.MappedProperties, GTVAPIRestClient.ReverseMappedProperties {
    /**
     * Get agreement
     * @return agreement
     */
    public GTVAPIAgreementRef agreement { get; set; }

    /**
     * The date when the order item agreement ends.
     * @return endDate
     */
    public String endDate { get; set; }

    /**
     * Get endAction
     * @return endAction
     */
    public String endAction { get; set; }

    /**
     * Get nextAgreement
     * @return nextAgreement
     */
    public GTVAPIAgreementRef nextAgreement { get; set; }

    /**
     * Get nextEndAction
     * @return nextEndAction
     */
    public String nextEndAction { get; set; }

    /**
     * Get nextServiceProduct
     * @return nextServiceProduct
     */
    public GTVAPIProductRef nextServiceProduct { get; set; }

    /**
     * Get nextServiceProductPrice
     * @return nextServiceProductPrice
     */
    public GTVAPIProductRecurringPriceRef nextServiceProductPrice { get; set; }

    /**
     * Specifies whether the price of the renewed service will be the same as the original service price.
     * @return preserveServicePrice
     */
    public Boolean preserveServicePrice { get; set; }

    /**
     * Get nextPreserveServicePrice
     * @return nextPreserveServicePrice
     */
    public Boolean nextPreserveServicePrice { get; set; }

    /**
     * The length of the agreement.
     * @return agreementPeriod
     */
    public Integer agreement_period { get; set; }

    /**
     * The minimum change for the agreement, used for true up charges.
     * @return minimumAmount
     */
    public Double minimumAmount { get; set; }

    /**
     * Specifies whether the minimum amount that is minimum change for the agreement is omitted. If set to true, the minimum amount of the agreement is not taken into account. If set to false, the minimum amount is applied to the agreement service.\n
     * @return omitMinimumAmount
     */
    public Boolean omitMinimumAmount { get; set; }

    /**
     * Get trueUpChargeTypes
     * @return trueUpChargeTypes
     */
    public List<GTVAPITrueUpChargeType> trueUpChargeTypes { get; set; }
    /*
    private final Map<String, String> propertyMappings = new Map<String, String>{
        'end_date' => 'endDate',
        'end_action' => 'endAction',
        'next_agreement' => 'nextAgreement',
        'next_end_action' => 'nextEndAction',
        'next_service_product' => 'nextServiceProduct',
        'next_service_product_price' => 'nextServiceProductPrice',
        'preserve_service_price' => 'preserveServicePrice',
        'next_preserve_service_price' => 'nextPreserveServicePrice',
        'agreement_period' => 'agreement_period',
        'minimum_amount' => 'minimumAmount',
        'omit_minimum_amount' => 'omitMinimumAmount',
        'true_up_charge_types' => 'trueUpChargeTypes'
    };
    private final Map<String, String> reversePropertyMappings = new Map<String, String>{
        'endDate' => 'end_date',
        'endAction' => 'end_action',
        'nextAgreement' => 'next_agreement',
        'nextEndAction' => 'next_end_action',
        'nextServiceProduct' => 'next_service_product',
        'nextServiceProductPrice' => 'next_service_product_price',
        'preserveServicePrice' => 'preserve_service_price',
        'nextPreserveServicePrice' => 'next_preserve_service_price',
        'agreement_period' => 'agreement_period',
        'minimumAmount' => 'minimum_amount',
        'omitMinimumAmount' => 'omit_minimum_amount',
        'trueUpChargeTypes' => 'true_up_charge_types'
    };
*/
    public override Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'end_date' => 'endDate',
        'end_action' => 'endAction',
        'next_agreement' => 'nextAgreement',
        'next_end_action' => 'nextEndAction',
        'next_service_product' => 'nextServiceProduct',
        'next_service_product_price' => 'nextServiceProductPrice',
        'preserve_service_price' => 'preserveServicePrice',
        'next_preserve_service_price' => 'nextPreserveServicePrice',
        'agreement_period' => 'agreement_period',
        'minimum_amount' => 'minimumAmount',
        'omit_minimum_amount' => 'omitMinimumAmount',
        'true_up_charge_types' => 'trueUpChargeTypes'
      };
      return propertyMappings;
    }
    public Map<String, String> getReversePropertyMappings() {
      Map<String, String> reversePropertyMappings = new Map<String, String>{
        'endDate' => 'end_date',
        'endAction' => 'end_action',
        'nextAgreement' => 'next_agreement',
        'nextEndAction' => 'next_end_action',
        'nextServiceProduct' => 'next_service_product',
        'nextServiceProductPrice' => 'next_service_product_price',
        'preserveServicePrice' => 'preserve_service_price',
        'nextPreserveServicePrice' => 'next_preserve_service_price',
        'agreement_period' => 'agreement_period',
        'minimumAmount' => 'minimum_amount',
        'omitMinimumAmount' => 'omit_minimum_amount',
        'trueUpChargeTypes' => 'true_up_charge_types'
      };
      return reversePropertyMappings;
    }

    public GTVAPICreateOrderItemAgreement() {
      trueUpChargeTypes = new List<GTVAPITrueUpChargeType>();
    }
  }

  /**
   * GTVAPIServicePrice
   */
  public class GTVAPIServicePrice extends GTVAPIPrice implements GTVAPIRestClient.MappedProperties {
    /**
     * Get amount
     * @return amount
     */
    public Double amount { get; private set; }

    /**
     * Get startDate
     * @return startDate
     */
    public DateTime startDate { get; private set; }

    /**
     * Get endDate
     * @return endDate
     */
    public DateTime endDate { get; set; }

    /**
     * Get billInAdvance
     * @return billInAdvance
     */
    public Boolean billInAdvance { get; set; }

    /**
     * Get estimatedInvoiceAmount
     * @return estimatedInvoiceAmount
     */
    public Double estimatedInvoiceAmount { get; private set; }

    /**
     * Get invoiceQuantity
     * @return invoiceQuantity
     */
    public Double invoiceQuantity { get; private set; }

    /**
     * Get prorateOnCancel
     * @return prorateOnCancel
     */
    public Boolean prorateOnCancel { get; private set; }

    /**
     * Get servicePriceRanges
     * @return servicePriceRanges
     */
    /**
     *@ToDo
     * Import supported class
     */
    public List<GTVAPIServicePriceRange> servicePriceRanges { get; set; }

    /**
     * Get recurrencePeriod
     * @return recurrencePeriod
     */
    /**
     *@ToDo
     * Import supported class
     */
    public String recurrencePeriod { get; set; }

    /**
     * Get productPrice
     * @return productPrice
     */
    public GTVAPIProductPriceRef productPrice { get; set; }

    /* private final Map<String, String> propertyMappings = new Map<String, String>{
        'price_type' => 'priceType',
        'currency_code' => 'currencyCode',
        'start_date' => 'startDate',
        'end_date' => 'endDate',
        'bill_in_advance' => 'billInAdvance',
        'estimated_invoice_amount' => 'estimatedInvoiceAmount',
        'invoice_quantity' => 'invoiceQuantity',
        'prorate_on_cancel' => 'prorateOnCancel',
           // 'service_price_ranges' => 'servicePriceRanges',
           // 'recurrence_period' => 'recurrencePeriod',
        'product_price' => 'productPrice'
        };
*/
    public override Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'price_type' => 'priceType',
        'currency_code' => 'currencyCode',
        'start_date' => 'startDate',
        'end_date' => 'endDate',
        'bill_in_advance' => 'billInAdvance',
        'estimated_invoice_amount' => 'estimatedInvoiceAmount',
        'invoice_quantity' => 'invoiceQuantity',
        'prorate_on_cancel' => 'prorateOnCancel',
        'service_price_ranges' => 'servicePriceRanges',
        'recurrence_period' => 'recurrencePeriod',
        'product_price' => 'productPrice'
      };

      return propertyMappings;
    }

    public GTVAPIServicePrice() {
      // servicePriceRanges = new List<GTVAPIServicePriceRange>();
    }
  }
  /**
   * GTVAPIProductPriceRef
   */
  public virtual class GTVAPIProductPriceRef extends GTVAPIEntityRef implements GTVAPIRestClient.MappedProperties {
    /**
     * (unique_key) The internal entity id for this entity representation
     * @return id
     */
    public String id { get; set; }

    /**
     * Get priceType
     * @return priceType
     */
    public String product_price_type { get; set; }
    /**
     * Get validFrom
     * @return DateTime
     */
    public Datetime valid_from { get; set; }
    /**
     * Get recurrencePeriod
     * @return recurrencePeriod
     */

    public String recurrencePeriod { get; set; }

    /* private final Map<String, object> propertyMappings = new Map<String, String>{
        'product_price_type' => 'product_price_type'
        };
*/
    public virtual Map<String, object> getPropertyMappings() {
      Map<String, object> propertyMappings = new Map<String, String>{
        'product_price_type' => 'product_price_type',
        'valid_from' => 'valid_from',
        'recurrence_period' => 'recurrencePeriod'
      };
      return propertyMappings;
    }
  }
  /**
   * A representation of a TRACT entity object that only contains a minimal set of attributes; typically ones that are used for query
   */
  public virtual class GTVAPIEntityRef {
    /**
     * (unique_key) The internal entity id for this entity representation
     * @return id
     */
    public String id { get; set; }
  }
  /**
   * Gets or Sets ServiceUsageRuleStatus
   */
  public enum GTVAPIServiceUsageRuleStatus {
    ACTIVE,
    DEACTIVATED,
    DRAFT
  }
  /**
   * GTVAPIOrderItemCharge
   */
  public class GTVAPIOrderItemCharge extends GTVAPIBaseOrderItemCharge implements GTVAPIRestClient.MappedProperties {
    /*  private final Map<String, String> propertyMappings = new Map<String, String>{
        'product_name' => 'productName',
        'price_category' => 'priceCategory',
        'order_date' => 'orderDate',
        'order_item_charge_type' => 'orderItemChargeType'
        };
*/
    public override Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'product_name' => 'productName',
        'price_category' => 'priceCategory',
        'order_date' => 'orderDate',
        'order_item_charge_type' => 'orderItemChargeType'
      };
      return propertyMappings;
    }
  }
  /**
   * GTVAPIBillingAccountCustomFieldVal
   */
  public class GTVAPIBillingAccountCustomFieldVal extends GTVAPICustomFieldValue implements GTVAPIRestClient.MappedProperties {
    /*    private final Map<String, String> propertyMappings = new Map<String, String>{
        'custom_field_value_type' => 'customFieldValueType',
        'custom_field' => 'customField'
        };
*/
    public override Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'custom_field_value_type' => 'customFieldValueType',
        'custom_field' => 'customField'
      };
      return propertyMappings;
    }
  }
  /**
   * A representation of a TRACT Person entity
   */
  public class GTVAPIPerson extends GTVAPIParty implements GTVAPIRestClient.MappedProperties {
    /**
     * Get firstName
     * @return firstName
     */
    public String firstName { get; set; }

    /**
     * Get lastName
     * @return lastName
     */
    public String lastName { get; set; }

    /**
     * Get middleName
     * @return middleName
     */
    public String middleName { get; set; }

    /**
     * Get suffix
     * @return suffix
     */
    public String suffix { get; set; }

    /**
     * Get dob
     * @return dob
     */
    public Date dob { get; set; }

    /**
     * Get company
     * @return company
     */
    public String company { get; set; }

    /**
     * Get department
     * @return department
     */
    public String department { get; set; }

    /**
     * Get title
     * @return title
     */
    public String title { get; set; }

    /**
     * Get contactCategory
     * @return contactCategory
     */
    public GTVAPIContactCategoryRef contactCategory { get; set; }

    /* private final Map<String, object> propertyMappings = new Map<String, Object>{
        'party_type' => 'partyType',
        'tax_id_number' => 'taxIdNumber',
        'first_name' => 'firstName',
        'last_name' => 'lastName',
        'middle_name' => 'middleName',
        'contact_category' => new List<String>{'contactCategory','GTVAPIContactCategoryRef'},
        'address_type' => 'addressType',
        'region_or_state' => 'regionOrState',
        'postal_code' => 'postalCode',
        'p_code' => 'pCode',
        'p_code_overridden' => 'pCodeOverridden',
        'dialing_prefix' => 'dialingPrefix',
        'country_code' => 'countryCode',
        'area_code' => 'areaCode',
        'number' => 'r_number'
        };
     */
    public override Map<String, object> getPropertyMappings() {
      Map<String, object> propertyMappings = new Map<String, Object>{
        'party_type' => 'partyType',
        'tax_id_number' => 'taxIdNumber',
        'first_name' => 'firstName',
        'last_name' => 'lastName',
        'middle_name' => 'middleName',
        'contact_category' => new List<String>{
          'contactCategory',
          'GTVAPIContactCategoryRef'
        },
        'address_type' => 'addressType',
        'region_or_state' => 'regionOrState',
        'postal_code' => 'postalCode',
        'p_code' => 'pCode',
        'p_code_overridden' => 'pCodeOverridden',
        'dialing_prefix' => 'dialingPrefix',
        'country_code' => 'countryCode',
        'area_code' => 'areaCode',
        'number' => 'r_number'
      };
      return propertyMappings;
    }

    public GTVAPIPerson() {
    }
  }
  /**
   * GTVAPIContactCategoryRef
   */
  public class GTVAPIContactCategoryRef extends GTVAPIEntityRef {
    /**
     * (unique_key) The internal entity id for this entity representation
     * @return id
     */
    public String id { get; set; }

    public String name { get; set; }
  }
  /**
   * A representation of a TRACT SegmentedMonthly Bill Cycle entity
   */
  public class GTVAPIPaymentTerm extends GTVAPIEntity implements GTVAPIRestClient.MappedProperties {
    /**
     * (unique_key)  The internal entity id for this entity representation
     * @return id
     */
    public String id { get; private set; }

    /**
     * (unique_key) The TRACT payment-term name
     * @return name
     */
    public String name { get; set; }

    /**
     * Get termDays
     * @return termDays
     */
    public Integer termDays { get; set; }

    /**
     * Get graceDays
     * @return graceDays
     */
    public Integer graceDays { get; set; }

    /*  private final Map<String, String> propertyMappings = new Map<String, String>{
        'term_days' => 'termDays',
        'grace_days' => 'graceDays'
        };
*/
    public Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'term_days' => 'termDays',
        'grace_days' => 'graceDays'
      };
      return propertyMappings;
    }
  }
  /**
   * A representation of a TRACT reason
   */
  public virtual class GTVAPIReason extends GTVAPIEntity {
    /**
     * (unique_key)  The internal entity id for this entity representation
     * @return id
     */

    /**
     * Get name
     * @return name
     */
    public String name { get; set; }

    /**
     * Get description
     * @return description
     */
    public String description { get; set; }

    /**
     * Get status
     * @return status
     */
    public String status { get; set; }
  }
  /**
   * GTVAPICustomFieldValue
   */
  public virtual class GTVAPICustomFieldValue extends GTVAPIEntity implements GTVAPIRestClient.MappedProperties {
    /**
     * (unique_key)  The internal entity id for this entity representation
     * @return id
     */
    public String id { get; private set; }

    /**
     * Get customFieldValueType
     * @return customFieldValueType
     */
    public String customFieldValueType { get; set; }

    /**
     * The custom field value.
     * @return value
     */
    public String value { get; set; }

    /**
     * Get customField
     * @return customField
     */
    public GTVAPICustomFieldRef customField { get; set; }

    /* private final Map<String, String> propertyMappings = new Map<String, String>{
        'custom_field_value_type' => 'customFieldValueType',
        'custom_field' => 'customField'
        };
*/
    public virtual Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'custom_field_value_type' => 'customFieldValueType',
        'custom_field' => 'customField'
      };
      return propertyMappings;
    }
  }

  /**
   * Creates a new order item custom field value.
   */
  public class GTVAPICreateOrderItemCustomFieldValue extends GTVAPICreateCustomFieldValue implements GTVAPIRestClient.MappedProperties {
    /**
     * Get customField
     * @return customField
     */
    public GTVAPIServiceCustomFieldRef customField { get; set; }

    /*private final Map<String, String> propertyMappings = new Map<String, String>{
        'custom_field_value_type' => 'customFieldValueType',
        'custom_field' => 'customField'
    };*/

    public override Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'custom_field_value_type' => 'customFieldValueType',
        'custom_field' => 'customField'
      };
      return propertyMappings;
    }
  }

  /**
   * Specifies the type of the order item to be created.
   */
  public enum GTVAPICreateOrderItemType {
    PRODUCT,
    TENANT_SUBSCRIPTION,
    ADD_ON
  }
  /**
   * Defines the notification mode when the threshold is reached.\nNONE - no notifications are sent when the threshold is reached.\nSINGLE - the notification is sent one time only once the first threshold is reached.\nMULTIPLE - notifications are sent each time when the threshold is reached.\n
   */
  public enum GTVAPICounterThresholdNotificationFrequ {
    NONE,
    SINGLE,
    MULTIPLE
  }

  /**
   * Creates the Order Item Counter core entity.
   */
  public class GTVAPICreateOrderItemCounter extends GTVAPICreateEntity implements GTVAPIRestClient.MappedProperties {
    /**
     * Get counterType
     * @return counterType
     */
    public GTVAPICounterType counterType { get; set; }

    /**
     * (unique_key) The name of the core order item counter.
     * @return name
     */
    public String name { get; set; }

    /**
     * Get description
     * @return description
     */
    public String description { get; set; }

    /**
     * Get resetCriteria
     * @return resetCriteria
     */
    public GTVAPICreateCounterResetCriteria resetCriteria { get; set; }

    /**
     * The associated product usage rules.
     * @return productUsageRules
     */
    public List<GTVAPIProductUsageRuleRef> productUsageRules { get; set; }

    /**
     * Get status
     * @return status
     */
    public GTVAPICounterStatus status { get; set; }

    /**
     * Get thresholdNotificationFrequency
     * @return thresholdNotificationFrequency
     */
    public GTVAPICounterThresholdNotificationFrequ thresholdNotificationFrequency {
      get;
      set;
    }

    /*private final Map<String, String> propertyMappings = new Map<String, String>{
        'counter_type' => 'counterType',
        'reset_criteria' => 'resetCriteria',
        'product_usage_rules' => 'productUsageRules',
        'threshold_notification_frequency' => 'thresholdNotificationFrequency'
    };
*/
    public Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'counter_type' => 'counterType',
        'reset_criteria' => 'resetCriteria',
        'product_usage_rules' => 'productUsageRules',
        'threshold_notification_frequency' => 'thresholdNotificationFrequency'
      };
      return propertyMappings;
    }

    public GTVAPICreateOrderItemCounter() {
      productUsageRules = new List<GTVAPIProductUsageRuleRef>();
    }
  }
  /**
   * Indicates the type of the counter.\nA usage-rule - the rule and associated action are triggered when the Counter\'s threshold is reached.\nA usage-event - the action is triggered after the specified number of events have occurred.\nA usage-charge - the action is triggered after the specified charges have been reached.\n
   */
  public enum GTVAPICounterType {
    EVENT,
    RULE,
    CHARGE
  }

  /**
   * A representation of the core Counter Reset Criteria Type entity.
   */
  public enum GTVAPICounterResetCriteriaType {
    SERVICE_PERIOD,
    AGREEMENT
  }

  /**
   * A representation of the core Counter Reset Criteria entity.
   */
  public class GTVAPICreateCounterResetCriteria extends GTVAPICreateEntity implements GTVAPIRestClient.MappedProperties {
    /**
     * Get resetCriteriaType
     * @return resetCriteriaType
     */
    public GTVAPICounterResetCriteriaType resetCriteriaType { get; set; }

    /* private final Map<String, String> propertyMappings = new Map<String, String>{
        'reset_criteria_type' => 'resetCriteriaType'
    };
*/
    public Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'reset_criteria_type' => 'resetCriteriaType'
      };
      return propertyMappings;
    }
  }
  /**
   * Defines the Usage Rule value types.
   */
  public enum GTVAPIUsageRuleType {
    ORDER_ITEM,
    PRODUCT,
    SERVICE
  }

  /**
   * A reference to the core Usage Rule Template entity.
   */
  public virtual class GTVAPIUsageRuleTemplateRef extends GTVAPIEntityRef implements GTVAPIRestClient.MappedProperties {
    /**
     * (unique_key) The ID of the entity.
     * @return id
     */
    public String id { get; set; }

    /**
     * Get usageRuleType
     * @return usageRuleType
     */
    public String usageRuleType { get; set; }

    /**
     * (unique_key) The name of this usage rule template.
     * @return name
     */
    public String name { get; set; }

    /*  private final Map<String, String> propertyMappings = new Map<String, String>{
        'usage_rule_type' => 'usageRuleType'
    };
*/
    public virtual Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'usage_rule_type' => 'usageRuleType'
      };
      return propertyMappings;
    }
  }

  /**
   * A reference to the core Product Usage Rule entity.
   */
  public class GTVAPIProductUsageRuleRef extends GTVAPIUsageRuleTemplateRef implements GTVAPIRestClient.MappedProperties {
    /*  private final Map<String, String> propertyMappings = new Map<String, String>{
        'usage_rule_type' => 'usageRuleType'
    };
*/
    public override Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'usage_rule_type' => 'usageRuleType'
      };
      return propertyMappings;
    }
  }
  /**
   * Indicates the status of the usage counter.
   */
  public enum GTVAPICounterStatus {
    DRAFT,
    ACTIVE,
    SUSPENDED
  }

  /**
   * Creates the Order Item entity.
   */
  public virtual class GTVAPICreateOrderItem extends GTVAPICreateEntity implements GTVAPIRestClient.MappedProperties, GTVAPIRestClient.ReverseMappedProperties {
    /**
     * Get orderItemType
     * @return orderItemType
     */
    public String order_item_type { get; set; }

    /**
     * Get orderItemCounters
     * @return orderItemCounters
     */
    public List<GTVAPICreateOrderItemCounter> orderItemCounters { get; set; }
    /*
    private final Map<String, String> propertyMappings = new Map<String, String>{
        'order_item_type' => 'order_item_type',
        'order_item_counters' => 'orderItemCounters'
    };
    private final Map<String, String> reversePropertyMappings = new Map<String, String>{
        'order_item_type' => 'order_item_type',
        'orderItemCounters' => 'order_item_counters'
    };
*/
    public virtual Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'order_item_type' => 'order_item_type',
        'order_item_counters' => 'orderItemCounters'
      };
      return propertyMappings;
    }
    public virtual Map<String, object> getReversePropertyMappings() {
      Map<String, object> reversePropertyMappings = new Map<String, object>{
        'order_item_type' => 'order_item_type',
        'orderItemCounters' => 'order_item_counters'
      };
      return reversePropertyMappings;
    }

    public GTVAPICreateOrderItem() {
      orderItemCounters = new List<GTVAPICreateOrderItemCounter>();
    }
  }
  /**
   * Creates a new service resource or add existing.
   */
  public class GTVAPICreateOrAddServiceResource extends GTVAPICreateEntity implements GTVAPIRestClient.MappedProperties {
    /**
     * The ID of the existing service resource.
     * @return id
     */
    public String id { get; set; }

    /**
     * Specifies whether the service resource can be auto-selected. If set to true, the service resource can be auto-selected. If set to false, the service resource cannot be auto-selected and needs to be selected manually.\n
     * @return autoSelect
     */
    public Boolean autoSelect { get; set; }

    /**
     * Get resourceType
     * @return resourceType
     */
    public GTVAPIResourceType resourceType { get; set; }

    /**
     * (unique_key) The name of the resource identifier.
     * @return identifier
     */
    public String identifier { get; set; }

    /**
     * The description of the resource.
     * @return description
     */
    public String description { get; set; }

    /**
     * Get category
     * @return category
     */
    public GTVAPIResourceCategoryRef category { get; set; }

    /*private final Map<String, String> propertyMappings = new Map<String, String>{
        'auto_select' => 'autoSelect',
        'resource_type' => 'resourceType'
    };*/

    public Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'auto_select' => 'autoSelect',
        'resource_type' => 'resourceType'
      };
      return propertyMappings;
    }
  }

  /**
   * Creates the relation between a discount and an order item.
   */
  public class GTVAPICreateOrderItemDiscount extends GTVAPICreateEntity implements GTVAPIRestClient.MappedProperties, GTVAPIRestClient.ReverseMappedProperties {
    /**
     * Get discountResource
     * @return discountResource
     */
    public GTVAPIDiscountResourceRef discountResource { get; set; }

    /**
     * The amount of the discount override.
     * @return overrideAmount
     */
    public Double overrideAmount { get; set; }

    /**
     * The percentage of the discount override.
     * @return overridePercentage
     */
    public Double overridePercentage { get; set; }

    /**
     * The length of time for the override.
     * @return overrideDuration
     */
    public Integer overrideDuration { get; set; }

    public Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'discount_resource' => 'discountResource',
        'override_amount' => 'overrideAmount',
        'override_percentage' => 'overridePercentage',
        'override_duration' => 'overrideDuration'
      };
      return propertyMappings;
    }

    public virtual Map<String, Object> getReversePropertyMappings() {
      Map<String, Object> reversePropertyMappings = new Map<String, Object>{
        'discountResource' => new List<String>{
          'discount_resource',
          'GTVAPIDiscountResourceRef'
        },
        'overrideAmount' => 'override_amount',
        'overridePercentage' => 'override_percentage',
        'overrideDuration' => 'override_duration'
      };
      return reversePropertyMappings;
    }
  }

  /**
   * Indicates the price type of the order item.
   */
  public enum GTVAPIOrderItemPriceType {
    ONE_TIME,
    RECURRING
  }
  /**
   * A reference to core Product Price Group entity.
   */
  public class GTVAPIProductPriceGroupRef extends GTVAPIEntityRef {
    /**
     * (unique_key) The ID of the entity.
     * @return id
     */
    public String id { get; set; }

    /**
     * (unique_key) A name of this price group.
     * @return name
     */
    public String name { get; set; }

    /**
     * (unique_key) An alphanumeric code used to identify the price group internally in Gotransverse core. You cannot change the price group code after the price group is created.
     * @return code
     */
    public String code { get; set; }
  }

  /**
   * A full representation of the core order item price group used to override the product price group on an order item.
   */
  public class GTVAPICreateOrderItemPriceGroup extends GTVAPICreateEntity implements GTVAPIRestClient.MappedProperties {
    /**
     * Get productPriceGroup
     * @return productPriceGroup
     */
    public GTVAPIProductPriceGroupRef productPriceGroup { get; set; }

    /* private final Map<String, String> propertyMappings = new Map<String, String>{
        'product_price_group' => 'productPriceGroup'
    };
*/
    public Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'product_price_group' => 'productPriceGroup'
      };
      return propertyMappings;
    }
  }

  /**
   * Creates the Order Item Price Range entity.
   */
  public class GTVAPICreateOrderItemPriceRange extends GTVAPICreateEntity implements GTVAPIRestClient.MappedProperties, GTVAPIRestClient.ReverseMappedProperties {
    /**
     * The first number in the price range.
     * @return quantityBeginRange
     */
    public Double quantity_begin_range { get; set; }

    /**
     * The last number in the price range. For the last tier, this value can and should be empty.
     * @return quantityEndRange
     */
    public Double quantity_end_range { get; set; }

    /**
     * The price of the item for this price tier.
     * @return price
     */
    public Double price { get; set; }

    /**
     * Indicates a level of pricing. Each level sets a different price for each item depending on the amount of the purchased items.
     * @return level
     */
    public Integer level { get; set; }

    /**
     * Get currencyCode
     * @return currencyCode
     */
    public String currency_code { get; set; }
    /*
    private final Map<String, String> propertyMappings = new Map<String, String>{
        'quantity_begin_range' => 'quantityBeginRange',
        'quantity_end_range' => 'quantityEndRange',
        'currency_code' => 'currency_code',
        'price' => 'price'
    };
    private final Map<String, String> reversePropertyMappings = new Map<String, String>{
        'quantityBeginRange' => 'quantity_begin_range',
        'quantityEndRange' => 'quantity_end_range',
        'currency_code' => 'currency_code',
        'price' => 'price'
    };
*/
    public Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'quantity_begin_range' => 'quantityBeginRange',
        'quantity_end_range' => 'quantityEndRange',
        'currency_code' => 'currency_code',
        'price' => 'price'
      };
      return propertyMappings;
    }
    public Map<String, String> getReversePropertyMappings() {
      Map<String, String> reversePropertyMappings = new Map<String, String>{
        'quantityBeginRange' => 'quantity_begin_range',
        'quantityEndRange' => 'quantity_end_range',
        'currency_code' => 'currency_code',
        'price' => 'price'
      };
      return reversePropertyMappings;
    }
  }

  /**
   * Confirms the Draft Gotransverse core Order.
   */
  public class GTVAPIConfirmDraftOrder extends GTVAPICommand {
    /**
     * Get payment
     * @return payment
     */
    public GTVAPICreatePayment payment { get; set; }
  }

  /**
   * Creates the Order Item Price entity. Order Item Price can be either recurring or one-time.
   */
  public virtual class GTVAPICreateOrderItemPrice extends GTVAPICreateEntity implements GTVAPIRestClient.MappedProperties, GTVAPIRestClient.ReverseMappedProperties {
    /**
     * Get orderItemPriceType
     * @return orderItemPriceType
     */
    public String order_item_price_type { get; set; }

    /**
     * Indicates the amount of taxable items.
     * @return taxableAmount
     */
    public Double taxableAmount { get; set; }

    /**
     * Get productPrice
     * @return productPrice
     */
    public GTVAPIProductPriceRef product_price { get; set; }

    /**
     * Indicates the product price ranges (tiers).
     * @return priceRanges
     */
    public List<GTVAPICreateOrderItemPriceRange> price_ranges { get; set; }

    /**
     * Get priceGroup
     * @return priceGroup
     */
    public GTVAPICreateOrderItemPriceGroup priceGroup { get; set; }
    /**
     * Get Schedule Charge
     * @return priceGroup
     */
    public list<GTVAPICreateOneTimePriceCharge> scheduled_charges { get; set; }

    /**
     * Get productUsageRules
     * @return productUsageRules
     */
    public List<GTVAPICreateUsageRuleTemplate> usage_rules { get; set; }
    /*
    private final Map<String, String> propertyMappings = new Map<String, String>{
        'order_item_price_type' => 'order_item_price_type',
        'taxable_amount' => 'taxableAmount',
        'product_price' => 'product_price',
        'price_ranges' => 'price_ranges',
        'price_group' => 'priceGroup'
    };
    private final Map<String, String> reversePropertyMappings = new Map<String, String>{
        'order_item_price_type' => 'order_item_price_type',
        'taxableAmount' => 'taxable_amount',
        'product_price' => 'product_price',
        'price_ranges' => 'price_ranges',
        'priceGroup' => 'price_group'
    };
*/
    public virtual Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'order_item_price_type' => 'order_item_price_type',
        'taxable_amount' => 'taxableAmount',
        'product_price' => 'product_price',
        'price_ranges' => 'price_ranges',
        'price_group' => 'priceGroup'
      };
      return propertyMappings;
    }
    public Map<String, Object> getReversePropertyMappings() {
      Map<String, Object> reversePropertyMappings = new Map<String, Object>{
        'order_item_price_type' => 'order_item_price_type',
        'taxableAmount' => 'taxable_amount',
        'product_price' => 'product_price',
        'price_ranges' => new List<String>{
          'price_ranges',
          'GTVAPICreateOrderItemPriceRange'
        },
        'priceGroup' => 'price_group',
        'scheduled_charges' => 'scheduled_charges'
      };
      return reversePropertyMappings;
    }

    public GTVAPICreateOrderItemPrice() {
      price_ranges = new List<GTVAPICreateOrderItemPriceRange>();
    }
  }

  /**
   * A base object for overriding an existing core entity.
   */
  public virtual class GTVAPIOverrideEntity {
  }
  /**
   * A discriminator field that indicates the type of Operation Run Attribute.
   */
  public enum GTVAPIOperationRunAttributeType {
    SALE
  }
  /**
   * A reference to the Operation core entity.
   */
  public class GTVAPIOperationRef extends GTVAPIEntityRef implements GTVAPIRestClient.MappedProperties {
    /**
     * (unique_key) The ID of the entity.
     * @return id
     */
    public String id { get; set; }

    /**
     * Get operationType
     * @return operationType
     */
    public GTVAPIOperationType operationType { get; set; }

    /**
     * (unique_key) The name of the operation.
     * @return name
     */
    public String name { get; set; }

    /* private final Map<String, String> propertyMappings = new Map<String, String>{
        'operation_type' => 'operationType'
    };*/

    public Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'operation_type' => 'operationType'
      };
      return propertyMappings;
    }
  }

  /**
   * A base entity for Override Product Sale Operation Run Attribute.
   */
  public class GTVAPIOverrideOperationRunAttribute extends GTVAPIOverrideEntity implements GTVAPIRestClient.MappedProperties {
    /**
     * Get operationRunAttributeType
     * @return operationRunAttributeType
     */
    public GTVAPIOperationRunAttributeType operationRunAttributeType {
      get;
      set;
    }

    /**
     * The email address that you specify if you enabled Email Override. This is different from the billing account email address.
     * @return emailAddress
     */
    public String emailAddress { get; set; }

    /**
     * Get operation
     * @return operation
     */
    public GTVAPIOperationRef operation { get; set; }
    /*
    private final Map<String, String> propertyMappings = new Map<String, String>{
        'operation_run_attribute_type' => 'operationRunAttributeType',
        'email_address' => 'emailAddress'
    };*/

    public Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'operation_run_attribute_type' => 'operationRunAttributeType',
        'email_address' => 'emailAddress'
      };

      return propertyMappings;
    }
  }
  /**
   * Indicates recurrence period of the CPQ discount.
   */
  public enum GTVAPICpqRecurrence {
    NONE,
    DAY,
    WEEK,
    MONTH,
    YEAR
  }

  /**
   * Indicates a type of the CPQ application. It indicates whether discount is calculated as a percentage of the product price or as a set amount. PERCENTAGE indicates that the CPQ discount is a percentage of the product price. FLAT indicates that the CPQ discount is a fixed amount.
   */
  public enum GTVAPICpqApplicationType {
    FLAT,
    PERCENTAGE
  }

  /**
   * Indicates the price type of the CPQ discount. It specifies whether the CPQ discount is a one-time event or it is recurring. ONE TIME discount type applies for one-time prices. RECURRING discount type applies for recurring prices. ALL discount type means that CPQ discount is applied to both one-time and recurring prices.
   */
  public enum GTVAPICpqPriceType {
    USAGE,
    ONE_TIME,
    RECURRING,
    ALL
  }
  /**
   * Creates a CPQ discount.
   */
  public class GTVAPICreateCpqDiscount extends GTVAPICreateEntity implements GTVAPIRestClient.MappedProperties {
    /**
     * The date and time when the CPQ discount starts.
     * @return startDate
     */
    public Datetime startDate { get; set; }

    /**
     * The number of service periods this CPQ discount can be used.
     * @return duration
     */
    public Integer duration { get; set; }

    /**
     * Get recurrence
     * @return recurrence
     */
    public GTVAPICpqRecurrence recurrence { get; set; }

    /**
     * The value of the CPQ discount. If the CPQ application is of the Flat type, the discount value is calculated as an amount of money defined in the currency that is set for your billing account. If the CPQ application is of the Percentage type, the value is the percent of the applied discount.
     * @return value
     */
    public Double value { get; set; }

    /**
     * Get applicationType
     * @return applicationType
     */
    public GTVAPICpqApplicationType applicationType { get; set; }

    /**
     * Get priceType
     * @return priceType
     */
    public GTVAPICpqPriceType priceType { get; set; }

    /**
     * The CPQ discount key, currently used to match usage based discounts.
     * @return discountKey
     */
    public String discountKey { get; set; }

    /*   private final Map<String, String> propertyMappings = new Map<String, String>{
        'start_date' => 'startDate',
        'application_type' => 'applicationType',
        'price_type' => 'priceType',
        'discount_key' => 'discountKey'
    };
*/
    public Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'start_date' => 'startDate',
        'application_type' => 'applicationType',
        'price_type' => 'priceType',
        'discount_key' => 'discountKey'
      };
      return propertyMappings;
    }
  }

  /**
   * Creates the Product Order Item entity.
   */
  public virtual class GTVAPICreateProductOrderItem extends GTVAPICreateOrderItem implements GTVAPIRestClient.MappedProperties, GTVAPIRestClient.ReverseMappedProperties {
    /**
     * The amount of purchased products.
     * @return quantity
     */
    public Double quantity { get; set; }

    /**
     * The description of this order item.
     * @return description
     */
    public String description { get; set; }

    /**
     * Get product
     * @return product
     */
    public GTVAPIProductRef product { get; set; }

    /**
     * Get priceList
     * @return priceList
     */
    public GTVAPIPriceListRef priceList { get; set; }

    /**
     * Identifies the sequence of an order item in the order. Sequences are used to identify the order item for which an approve or deny action command is used.
     * @return sequence
     */
    public Long sequence { get; set; }

    /**
     * The date when the purchase is effective. If no date is entered, then it is generated by the system.
     * @return requestedEffectiveDate
     */
    public String requestedEffectiveDate { get; set; }

    /**
     * If the product being purchased has the option of trial days, you can enter the number of trial days. In this case, you can change and override the number of trial days.
     * @return overrideTrialDays
     */
    public Integer overrideTrialDays { get; set; }

    /**
     * A collection of add-on product order items that will be created.
     * @return orderItems
     */
    public List<GTVAPICreateAddOnProductOrderItem> orderItems { get; set; }

    /**
     * A collection of product order item custom field values that will be created.
     * @return customFieldValues
     */
    public List<GTVAPICreateOrderItemCustomFieldValue> customFieldValues {
      get;
      set;
    }

    /**
     * A collection of addresses of the service that will be created.
     * @return addresses
     */
    public List<GTVAPICreatePostalAddress> addresses { get; set; }

    /**
     * Get orderItemAgreement
     * @return orderItemAgreement
     */
    public GTVAPICreateOrderItemAgreement order_item_agreement { get; set; }

    /**
     * A collection of service resources that will be created.
     * @return serviceResources
     */
    public List<GTVAPICreateOrAddServiceResource> service_resources {
      get;
      set;
    }

    /**
     * Get orderItemDiscount
     * @return orderItemDiscount
     */
    public GTVAPICreateOrderItemDiscount orderItemDiscount { get; set; }

    /**
     * Get productUsageRules
     * @return productUsageRules
     */
    public List<GTVAPICreateUsageRuleTemplate> productUsageRules { get; set; }
    /**
     * Indicates the overridden prices in the order. A link between the product prices and order item. Also, it includes taxable amount and order item price ranges (tiers).
     * @return orderItemPrices
     */

    public List<GTVAPICreateOrderItemPrice> order_item_prices { get; set; }

    /**
     * Indicates actions on the product level.
     * @return operationRunAttributes
     */
    public List<GTVAPIOverrideOperationRunAttribute> operationRunAttributes {
      get;
      set;
    }

    /**
     * This current CPQ driven discounts applicable. These are different the Resource driven discounts. Gotransverse core does not directly use these, but relies on the CPQ engine to use them.
     * @return cpqDiscounts
     */
    public List<GTVAPICreateCpqDiscount> cpqDiscounts { get; set; }

    /**
     * The end date for the first service period. Used to align service periods.
     * @return firstPeriodEndDate
     */
    public Date firstPeriodEndDate { get; set; }
    /**
     * Get parentService
     * @return parentService
     */
    public GTVAPIServiceRef parentService { get; set; }

    /*   private final Map<String, String> propertyMappings = new Map<String, String>{
        'order_item_type' => 'orderItemType',
        'order_item_counters' => 'orderItemCounters',
        'price_list' => 'priceList',
        'requested_effective_date' => 'requestedEffectiveDate',
        'override_trial_days' => 'overrideTrialDays',
        'order_items' => 'orderItems',
        'custom_field_values' => 'customFieldValues',
        'order_item_agreement' => 'order_item_agreement',
        'serviceResources' => 'service_resources',
        'order_item_discount' => 'orderItemDiscount',
        'product_usage_rules' => 'productUsageRules',
        'order_item_prices' => 'order_item_prices',
        'operation_run_attributes' => 'operationRunAttributes',
        'cpq_discounts' => 'cpqDiscounts',
        'first_period_end_date' => 'firstPeriodEndDate'
    };
        */
    public virtual override Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'order_item_type' => 'orderItemType',
        'order_item_counters' => 'orderItemCounters',
        'price_list' => 'priceList',
        'requested_effective_date' => 'requestedEffectiveDate',
        'override_trial_days' => 'overrideTrialDays',
        'order_items' => 'orderItems',
        'custom_field_values' => 'customFieldValues',
        'order_item_agreement' => 'order_item_agreement',
        'serviceResources' => 'service_resources',
        'order_item_discount' => 'orderItemDiscount',
        'product_usage_rules' => 'productUsageRules',
        'order_item_prices' => 'order_item_prices',
        'operation_run_attributes' => 'operationRunAttributes',
        'cpq_discounts' => 'cpqDiscounts',
        'first_period_end_date' => 'firstPeriodEndDate'
      };
      return propertyMappings;
    }

    public virtual override Map<String, object> getReversePropertyMappings() {
      Map<String, object> reversePropertyMappings = new Map<String, object>{
        'orderItemDiscount' => new List<String>{
          'order_item_discount',
          'GTVAPICreateOrderItemDiscount'
        },
        'order_item_agreement' => new List<String>{
          'order_item_agreement',
          'GTVAPICreateOrderItemAgreement'
        },
        'priceList' => 'price_list',
        'requestedEffectiveDate' => 'requested_effective_date'
      };
      return reversePropertyMappings;
    }

    public GTVAPICreateProductOrderItem() {
      orderItems = new List<GTVAPICreateAddOnProductOrderItem>();
      customFieldValues = new List<GTVAPICreateOrderItemCustomFieldValue>();
      addresses = new List<GTVAPICreatePostalAddress>();
      service_resources = new List<GTVAPICreateOrAddServiceResource>();
      order_item_prices = new List<GTVAPICreateOrderItemPrice>();
      operationRunAttributes = new List<GTVAPIOverrideOperationRunAttribute>();
      cpqDiscounts = new List<GTVAPICreateCpqDiscount>();
    }
  }

  /**
   * Creates the Add-on Product Order Item entity.
   */
  public virtual class GTVAPICreateAddOnProductOrderItem extends GTVAPICreateProductOrderItem implements GTVAPIRestClient.MappedProperties, GTVAPIRestClient.ReverseMappedProperties {
    /**
     * Get parentService
     * @return parentService
     */
    public GTVAPIServiceRef parentService { get; set; }
    /*
    private final Map<String, String> propertyMappings = new Map<String, String>{
        'order_item_type' => 'orderItemType',
        'order_item_counters' => 'orderItemCounters',
        'price_list' => 'priceList',
        'requested_effective_date' => 'requestedEffectiveDate',
        'override_trial_days' => 'overrideTrialDays',
        'order_items' => 'orderItems',
        'custom_field_values' => 'customFieldValues',
        'order_item_agreement' => 'orderItemAgreement',
        'service_resources' => 'serviceResources',
        'order_item_discount' => 'orderItemDiscount',
        'order_item_prices' => 'orderItemPrices',
        'operation_run_attributes' => 'operationRunAttributes',
        'cpq_discounts' => 'cpqDiscounts',
        'first_period_end_date' => 'firstPeriodEndDate',
        'parent_service' => 'parentService'
    };
    private final Map<String, String> reversePropertyMappings = new Map<String, String>{
        'orderItemAgreement' => 'order_item_agreement'
    };
*/
    public override Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'order_item_type' => 'orderItemType',
        'order_item_counters' => 'orderItemCounters',
        'price_list' => 'priceList',
        'requested_effective_date' => 'requestedEffectiveDate',
        'override_trial_days' => 'overrideTrialDays',
        'order_items' => 'orderItems',
        'custom_field_values' => 'customFieldValues',
        'order_item_agreement' => 'orderItemAgreement',
        'service_resources' => 'serviceResources',
        'order_item_discount' => 'orderItemDiscount',
        'order_item_prices' => 'orderItemPrices',
        'operation_run_attributes' => 'operationRunAttributes',
        'cpq_discounts' => 'cpqDiscounts',
        'first_period_end_date' => 'firstPeriodEndDate',
        'parent_service' => 'parentService'
      };
      return propertyMappings;
    }
    public override Map<String, Object> getReversePropertyMappings() {
      Map<String, Object> reversePropertyMappings = new Map<String, Object>{
        'orderItemAgreement' => 'order_item_agreement'
      };
      return reversePropertyMappings;
    }

    public GTVAPICreateAddOnProductOrderItem() {
    }
  }
  /*
   * TRACT Billing API
   * Create and manage billing accounts, products, orders, services, billing, invoicing, payments, and the general ledger. This microservice provides core functionality for the goTransverse billing platform.
   *
   * OpenAPI spec version: 2
   *
   *
   * NOTE: This class is auto generated by the swagger code generator program.
   * https://github.com/swagger-api/swagger-codegen.git
   * Do not edit the class manually.
   */

  /**
   * Creates the TRACT Price Charge entity.
   */
  public virtual class GTVAPICreatePriceCharge extends GTVAPICreateEntity implements GTVAPIRestClient.MappedProperties {
    /**
     * Get priceChargeType
     * @return priceChargeType
     */
    public String priceChargeType { get; set; }

    /**
     * A description of this price charge.
     * @return description
     */
    public String description { get; set; }

    /**
     * The amount of the charge.
     * @return amount
     */
    public Double amount { get; set; }

    /**
     * The date and time for when this charge is scheduled.
     * @return chargeDate
     */
    public Date chargeDate { get; set; }

    public virtual Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'price_charge_type' => 'priceChargeType',
        'charge_date' => 'chargeDate'
      };
      return propertyMappings;
    }
  }

  /**
   * A reference to the Service Custom Field core entity.
   */
  public virtual class GTVAPIServiceCustomFieldRef extends GTVAPICustomFieldRef implements GTVAPIRestClient.MappedProperties {
    /*  private final Map<String, String> propertyMappings = new Map<String, String>{
        'custom_field_type' => 'customFieldType'
    };*/

    public override Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'custom_field_type' => 'customFieldType'
      };
      return propertyMappings;
    }
  }

  /**
   * GTVAPICustomFieldRef
   */
  public virtual class GTVAPICustomFieldRef extends GTVAPIEntityRef implements GTVAPIRestClient.MappedProperties {
    /**
     * (unique_key) The internal entity id for this entity representation
     * @return id
     */
    //public String id { get; set; }

    /**
     * (unique_key)
     * @return name
     */
    public String name { get; set; }

    /**
     * Get custom_field_type
     * @return custom_field_type
     */
    public String custom_field_type { get; set; }

    /*    private final Map<String, String> propertyMappings = new Map<String, String>{
        'custom_field_type' => 'custom_field_type'
        };
*/
    public virtual Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'custom_field_type' => 'custom_field_type'
      };
      return propertyMappings;
    }
  }
  /**
   * A representation of the Agreement that is created on the specified service.
   */
  public virtual class GTVAPIAgreementServiceObject extends GTVAPIEntity implements GTVAPIRestClient.MappedProperties {
    /**
     * (unique_key) The ID of the entity.
     * @return id
     */
    public String id { get; private set; }

    /**
     * Get agreement
     * @return agreement
     */
    public GTVAPIAgreementRef agreement { get; set; }

    /**
     * The date when the agreement ends.
     * @return endDate
     */
    public Datetime endDate { get; set; }

    /**
     * Get endAction
     * @return endAction
     */
    public GTVAPIAgreementEndActionType endAction { get; set; }

    /**
     * Get nextAgreement
     * @return nextAgreement
     */
    public GTVAPIAgreementRef nextAgreement { get; set; }

    /**
     * Get nextEndAction
     * @return nextEndAction
     */
    public GTVAPIAgreementNextEndActionType nextEndAction { get; set; }

    /**
     * Get nextServiceProduct
     * @return nextServiceProduct
     */
    public GTVAPIProductRef nextServiceProduct { get; set; }

    /**
     * Get nextServiceProductPrice
     * @return nextServiceProductPrice
     */
    public GTVAPIProductRecurringPriceRef nextServiceProductPrice { get; set; }

    /**
     * Specifies whether the price of the renewed service will be the same as the original service price.
     * @return preserveServicePrice
     */
    public Boolean preserveServicePrice { get; set; }

    /**
     * Get nextPreserveServicePrice
     * @return nextPreserveServicePrice
     */
    public Boolean nextPreserveServicePrice { get; set; }

    /**
     * The length of the agreement.
     * @return agreementPeriod
     */
    public Integer agreementPeriod { get; private set; }

    /**
     * The minimum change for the agreement, used for true up charges.
     * @return minimumAmount
     */
    public Double minimumAmount { get; set; }

    /**
     * Get minimumAmountCurrencyCode
     * @return minimumAmountCurrencyCode
     */
    public GTVAPICurrencyCode minimumAmountCurrencyCode { get; set; }

    /**
     * Specifies whether the minimum amount that is minimum change for the agreement is omitted. If set to true, the minimum amount of the agreement is not taken into account. If set to false, the minimum amount is applied to the agreement service.\n
     * @return omitMinimumAmount
     */
    public Boolean omitMinimumAmount { get; set; }

    /**
     * Get trueUpChargeTypes
     * @return trueUpChargeTypes
     */
    public List<GTVAPITrueUpChargeType> trueUpChargeTypes { get; set; }
    /*
    private final Map<String, String> propertyMappings = new Map<String, String>{
        'end_date' => 'endDate',
        'end_action' => 'endAction',
        'next_agreement' => 'nextAgreement',
        'next_end_action' => 'nextEndAction',
        'next_service_product' => 'nextServiceProduct',
        'next_service_product_price' => 'nextServiceProductPrice',
        'preserve_service_price' => 'preserveServicePrice',
        'next_preserve_service_price' => 'nextPreserveServicePrice',
        'agreement_period' => 'agreementPeriod',
        'minimum_amount' => 'minimumAmount',
        'minimum_amount_currency_code' => 'minimumAmountCurrencyCode',
        'omit_minimum_amount' => 'omitMinimumAmount',
        'true_up_charge_types' => 'trueUpChargeTypes'
    };
*/
    public virtual Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'end_date' => 'endDate',
        'end_action' => 'endAction',
        'next_agreement' => 'nextAgreement',
        'next_end_action' => 'nextEndAction',
        'next_service_product' => 'nextServiceProduct',
        'next_service_product_price' => 'nextServiceProductPrice',
        'preserve_service_price' => 'preserveServicePrice',
        'next_preserve_service_price' => 'nextPreserveServicePrice',
        'agreement_period' => 'agreementPeriod',
        'minimum_amount' => 'minimumAmount',
        'minimum_amount_currency_code' => 'minimumAmountCurrencyCode',
        'omit_minimum_amount' => 'omitMinimumAmount',
        'true_up_charge_types' => 'trueUpChargeTypes'
      };
      return propertyMappings;
    }

    public GTVAPIAgreementServiceObject() {
      trueUpChargeTypes = new List<GTVAPITrueUpChargeType>();
    }
  }

  /**
   * GTVAPIGenericResource
   */
  public virtual class GTVAPIGenericResource extends GTVAPIEntity implements GTVAPIRestClient.MappedProperties {
    /**
     * (unique_key)  The internal entity id for this entity representation
     * @return id
     */
    public String id { get; private set; }

    /**
     * Get resourceType
     * @return resourceType
     */
    public GTVAPIResourceType resourceType { get; set; }

    /**
     * (unique_key)
     * @return identifier
     */
    public String identifier { get; set; }

    /**
     * Get description
     * @return description
     */
    public String description { get; set; }

    /**
     * Get category
     * @return category
     */
    public GTVAPIResourceCategoryRef category { get; set; }

    /*   private final Map<String, String> propertyMappings = new Map<String, String>{
        'resource_type' => 'resourceType'
        };
*/
    public virtual Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'resource_type' => 'resourceType'
      };
      return propertyMappings;
    }
  }

  /**
   * A representation of the core Agreement Service entity. It is an instance of agreement that is used for a particular customer service. When you create or change the product in the Gotransverse user interface, attach agreements to products. Then, when a customer purchases a product with an agreement, through the API, use Agreement Service to define the start date, end date, and the final action at the end of the service.\n
   */
  public class GTVAPIAgreementService extends GTVAPIAgreementServiceObject implements GTVAPIRestClient.MappedProperties {
    /**
     * (unique_key) The ID of the entity.
     * @return id
     */
    public String id { get; private set; }

    /**
     * Get agreement
     * @return agreement
     */
    public GTVAPIAgreementRef agreement { get; set; }

    /**
     * The date when the agreement ends.
     * @return endDate
     */
    public Datetime endDate { get; set; }

    /**
     * Get endAction
     * @return endAction
     */
    public GTVAPIAgreementEndActionType endAction { get; set; }

    /**
     * Get nextAgreement
     * @return nextAgreement
     */
    public GTVAPIAgreementRef nextAgreement { get; set; }

    /**
     * Get nextEndAction
     * @return nextEndAction
     */
    public GTVAPIAgreementNextEndActionType nextEndAction { get; set; }

    /**
     * Get nextServiceProduct
     * @return nextServiceProduct
     */
    public GTVAPIProductRef nextServiceProduct { get; set; }

    /**
     * Get nextServiceProductPrice
     * @return nextServiceProductPrice
     */
    public GTVAPIProductRecurringPriceRef nextServiceProductPrice { get; set; }

    /**
     * Specifies whether the price of the renewed service will be the same as the original service price.
     * @return preserveServicePrice
     */
    public Boolean preserveServicePrice { get; set; }

    /**
     * Get nextPreserveServicePrice
     * @return nextPreserveServicePrice
     */
    public Boolean nextPreserveServicePrice { get; set; }

    /**
     * The length of the agreement.
     * @return agreementPeriod
     */
    public Integer agreement_period { get; private set; }

    /**
     * The minimum change for the agreement, used for true up charges.
     * @return minimumAmount
     */
    public Double minimumAmount { get; set; }

    /**
     * Get minimumAmountCurrencyCode
     * @return minimumAmountCurrencyCode
     */
    public GTVAPICurrencyCode minimumAmountCurrencyCode { get; set; }

    /**
     * Specifies whether the minimum amount that is minimum change for the agreement is omitted. If set to true, the minimum amount of the agreement is not taken into account. If set to false, the minimum amount is applied to the agreement service.\n
     * @return omitMinimumAmount
     */
    public Boolean omitMinimumAmount { get; set; }

    /**
     * Get trueUpChargeTypes
     * @return trueUpChargeTypes
     */
    public List<GTVAPITrueUpChargeType> trueUpChargeTypes { get; set; }

    /**
     * The date when agreement starts.
     * @return startDate
     */
    public Datetime startDate { get; private set; }

    /**
     * Specifies whether the next service is paid for on purchase.
     * @return nextServicePayOnPurchase
     */
    public Boolean nextServicePayOnPurchase { get; set; }

    /**
     * Specifies whether the agreement is renewed.
     * @return renewed
     */
    public Boolean renewed { get; private set; }

    /**
     * The total amount of money on all invoices associated with this service agreement.
     * @return accumulatedChargesAmount
     */
    public Double accumulatedChargesAmount { get; set; }
    /*
    private final Map<String, String> propertyMappings = new Map<String, String>{
        'end_date' => 'endDate',
        'end_action' => 'endAction',
        'next_agreement' => 'nextAgreement',
        'next_end_action' => 'nextEndAction',
        'next_service_product' => 'nextServiceProduct',
        'next_service_product_price' => 'nextServiceProductPrice',
        'preserve_service_price' => 'preserveServicePrice',
        'next_preserve_service_price' => 'nextPreserveServicePrice',
        'agreement_period' => 'agreement_period',
        'minimum_amount' => 'minimumAmount',
        'minimum_amount_currency_code' => 'minimumAmountCurrencyCode',
        'omit_minimum_amount' => 'omitMinimumAmount',
        'true_up_charge_types' => 'trueUpChargeTypes',
        'start_date' => 'startDate',
        'next_service_pay_on_purchase' => 'nextServicePayOnPurchase',
        'accumulated_charges_amount' => 'accumulatedChargesAmount'
    };
*/
    public override Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'end_date' => 'endDate',
        'end_action' => 'endAction',
        'next_agreement' => 'nextAgreement',
        'next_end_action' => 'nextEndAction',
        'next_service_product' => 'nextServiceProduct',
        'next_service_product_price' => 'nextServiceProductPrice',
        'preserve_service_price' => 'preserveServicePrice',
        'next_preserve_service_price' => 'nextPreserveServicePrice',
        'agreement_period' => 'agreement_period',
        'minimum_amount' => 'minimumAmount',
        'minimum_amount_currency_code' => 'minimumAmountCurrencyCode',
        'omit_minimum_amount' => 'omitMinimumAmount',
        'true_up_charge_types' => 'trueUpChargeTypes',
        'start_date' => 'startDate',
        'next_service_pay_on_purchase' => 'nextServicePayOnPurchase',
        'accumulated_charges_amount' => 'accumulatedChargesAmount'
      };
      return propertyMappings;
    }

    public GTVAPIAgreementService() {
      trueUpChargeTypes = new List<GTVAPITrueUpChargeType>();
    }
  }

  /**
   * A representation of the core Service entity. A service is a product that has been sold to the customer. You can query, use, and update services through the API.
   */
  public class GTVAPIService extends GTVAPIEntity implements GTVAPIRestClient.MappedProperties {
    /**
     * (unique_key) The ID of the entity.
     * @return id
     */
    public String id { get; private set; }

    /**
     * The description of the service.
     * @return description
     */
    public String description { get; set; }

    /**
     * The cost of the service.
     * @return amount
     */
    public Double amount { get; private set; }

    /**
     * The date when the service started.
     * @return startDate
     */
    public Datetime startDate { get; private set; }

    /**
     * The date when the service ended if the service is not currently ongoing.
     * @return endDate
     */
    public Datetime endDate { get; private set; }

    /**
     * Get status
     * @return status
     */
    public GTVAPIServiceStatus status { get; set; }

    /**
     * Get statusReason
     * @return statusReason
     */
    public GTVAPIServiceReason statusReason { get; set; }

    /**
     * Get billingAccount
     * @return billingAccount
     */
    public GTVAPIBillingAccountRef billingAccount { get; set; }

    /**
     * The date when this service obtained its current status.
     * @return statusDate
     */
    public Datetime statusDate { get; private set; }

    /**
     * Get customFieldValues
     * @return customFieldValues
     */
    public List<GTVAPIServiceCustomFieldValue> customFieldValues { get; set; }

    /**
     * The prior level of the service.
     * @return oldLevel
     */
    public Integer oldLevel { get; private set; }

    /**
     * The current level of the service.
     * @return currentLevel
     */
    public Integer currentLevel { get; private set; }

    /**
     * The quantity of this service, meaning how many services there are at this price.
     * @return quantity
     */
    public Double quantity { get; private set; }

    /**
     * Specifies whether the service consumes a prepaid balance.
     * @return consumePrepaidBalance
     */
    public Boolean consumePrepaidBalance { get; private set; }

    /**
     * The service address, if any.
     * @return addresses
     */
    public List<GTVAPIPostalAddress> addresses { get; set; }

    /**
     * Get serviceResources
     * @return serviceResources
     */
    public List<GTVAPIServiceResource> serviceResources { get; set; }

    /**
     * Get product
     * @return product
     */
    public GTVAPIProductRef product { get; set; }

    /**
     * Get priceList
     * @return priceList
     */
    public GTVAPIPriceListRef priceList { get; set; }

    /**
     * Get parentService
     * @return parentService
     */
    public GTVAPIServiceRef parentService { get; set; }

    /**
     * Get currentAgreementService
     * @return currentAgreementService
     */
    public GTVAPIAgreementService currentAgreementService { get; set; }

    /**
     * Get servicePrices
     * @return servicePrices
     */
    public List<GTVAPIServicePrice> servicePrices { get; set; }

    /**
     * Each time this service is renewed on this billing account, Gotransverse core adds "1" to the renewal count. If this service has been renewed 3 times, then the renewal count is "3." The renewal count may include a future renewal that is scheduled but has not yet occurred. The renewal count does not include the original service, only the number of times it has been renewed.
     * @return renewalCount
     */
    public Integer renewalCount { get; private set; }

    /**
     * The date that the commitment to the service ended or will end. Depending on the next agreement service, the commitment end date can be different than the actual end date.
     * @return commitmentEndDate
     */
    public Datetime commitmentEndDate { get; private set; }

    /**
     * Get nextService
     * @return nextService
     */
    public GTVAPIServiceRef nextService { get; set; }

    /**
     * Get usageRules
     * @return usageRules
     */
    public List<GTVAPIServiceUsageRule> usage_rules { get; set; }
    /*
    private final Map<String, String> propertyMappings = new Map<String, String>{
        'start_date' => 'startDate',
        'end_date' => 'endDate',
        'status_reason' => 'statusReason',
        'billing_account' => 'billingAccount',
        'status_date' => 'statusDate',
        'custom_field_values' => 'customFieldValues',
        'old_level' => 'oldLevel',
        'current_level' => 'currentLevel',
        'consume_prepaid_balance' => 'consumePrepaidBalance',
        'service_resources' => 'serviceResources',
        'price_list' => 'priceList',
        'parent_service' => 'parentService',
        'current_agreement_service' => 'currentAgreementService',
        'service_prices' => 'servicePrices',
        'renewal_count' => 'renewalCount',
        'commitment_end_date' => 'commitmentEndDate',
        'next_service' => 'nextService',
        'usage_rules' => 'usageRules'
    };
*/
    public Map<String, Object> getPropertyMappings() {
      Map<String, Object> propertyMappings = new Map<String, Object>{
        'start_date' => 'startDate',
        'end_date' => 'endDate',
        'status_reason' => 'statusReason',
        'billing_account' => 'billingAccount',
        'status_date' => 'statusDate',
        'custom_field_values' => 'customFieldValues',
        'old_level' => 'oldLevel',
        'current_level' => 'currentLevel',
        'addresses' => 'addresses',
        'consume_prepaid_balance' => 'consumePrepaidBalance',
        'service_resources' => 'serviceResources',
        'price_list' => 'priceList',
        'parent_service' => 'parentService',
        'current_agreement_service' => 'currentAgreementService',
        'service_prices' => new List<String>{
          'servicePrices',
          'GTVAPIServicePrice'
        },
        'renewal_count' => 'renewalCount',
        'commitment_end_date' => 'commitmentEndDate',
        'next_service' => 'nextService',
        'usage_rules' => new List<String>{
          'usage_rules',
          'GTVAPIServiceUsageRule'
        }
      };
      return propertyMappings;
    }

    public GTVAPIService() {
      customFieldValues = new List<GTVAPIServiceCustomFieldValue>();
      addresses = new List<GTVAPIPostalAddress>();
      serviceResources = new List<GTVAPIServiceResource>();
      servicePrices = new List<GTVAPIServicePrice>();
      usage_rules = new List<GTVAPIServiceUsageRule>();
    }
  }
  /**
   * Gets or Sets ResourceType
   */
  public enum GTVAPIResourceType {
    SERVICE,
    DISCOUNT
  }
  /**
   * GTVAPIResourceCategoryRef
   */
  public class GTVAPIResourceCategoryRef extends GTVAPIEntityRef {
    /**
     * (unique_key) The internal entity id for this entity representation
     * @return id
     */
    public String id { get; set; }

    /**
     * (unique_key) The name of a TRACT service resource category
     * @return name
     */
    public String name { get; set; }
  }
  /**
   * GTVAPIChargeCategoryRef
   */
  public virtual class GTVAPIChargeCategoryRef extends GTVAPIEntityRef implements GTVAPIRestClient.MappedProperties {
    /**
     * (unique_key) The internal entity id for this entity representation
     * @return id
     */
    public String id { get; set; }

    /**
     * Get chargeCategoryType
     * @return chargeCategoryType
     */
    public String chargeCategoryType { get; set; }

    /**
     * (unique_key)
     * @return name
     */
    public String name { get; set; }

    /*   private final Map<String, String> propertyMappings = new Map<String, String>{
        'charge_category_type' => 'chargeCategoryType'
        };*/

    public virtual Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'charge_category_type' => 'chargeCategoryType'
      };

      return propertyMappings;
    }
  }
  /**
   * GTVAPIPrice
   */
  public virtual class GTVAPIPrice extends GTVAPIEntity implements GTVAPIRestClient.MappedProperties {
    /**
     * (unique_key)  The internal entity id for this entity representation
     * @return id
     */
    public String id { get; private set; }

    /**
     * Get priceType
     * @return priceType
     */
    public GTVAPIPriceType priceType { get; set; }

    /**
     * Get tapered
     * @return tapered
     */
    public Boolean tapered { get; private set; }

    /**
     * Get currencyCode
     * @return currencyCode
     */
    public GTVAPICurrencyCode currencyCode { get; set; }

    /**
     * Get category
     * @return category
     */
    public GTVAPIPriceCategoryRef category { get; set; }

    /*   private final Map<String, String> propertyMappings = new Map<String, String>{
        'price_type' => 'priceType',
        'currency_code' => 'currencyCode'
        };*/

    public virtual Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'price_type' => 'priceType',
        'currency_code' => 'currencyCode'
      };
      return propertyMappings;
    }
  }
  /**
   * Gets or Sets PriceType
   */
  public enum GTVAPIPriceType {
    ONE_TIME,
    RECURRING,
    SERVICE
  }
  /**
   * GTVAPIPriceCategoryRef
   */
  public class GTVAPIPriceCategoryRef extends GTVAPIChargeCategoryRef implements GTVAPIRestClient.MappedProperties, GTVAPIRestClient.ReverseMappedProperties {
    public override Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'charge_category_type' => 'chargeCategoryType'
      };
      return propertyMappings;
    }

    public Map<String, Object> getReversePropertyMappings() {
      Map<String, Object> reversePropertyMappings = new Map<String, Object>{
        'chargeCategoryType' => 'charge_category_type'
      };
      return reversePropertyMappings;
    }
  }
  /**
   * GTVAPIBaseOrderItemCharge
   */
  public virtual class GTVAPIBaseOrderItemCharge extends GTVAPIEntity implements GTVAPIRestClient.MappedProperties {
    /**
     * (unique_key)  The internal entity id for this entity representation
     * @return id
     */
    public String id { get; private set; }

    /**
     * Get productName
     * @return productName
     */
    public String productName { get; set; }

    /**
     * Get priceCategory
     * @return priceCategory
     */
    public GTVAPIPriceCategoryRef priceCategory { get; set; }

    /**
     * Get orderDate
     * @return orderDate
     */
    public DateTime orderDate { get; set; }

    /**
     * Get amount
     * @return amount
     */
    public Double amount { get; set; }

    /**
     * Get orderItemChargeType
     * @return orderItemChargeType
     */
    public String orderItemChargeType { get; set; }

    public List<GTVAPIServicePriceChargeRef> scheduledCharges { get; set; }

    public Boolean overridden { get; set; }

    /*
        private final Map<String, String> propertyMappings = new Map<String, String>{
        'product_name' => 'productName',
        'price_category' => 'priceCategory',
        'order_date' => 'orderDate',
        'order_item_charge_type' => 'orderItemChargeType'
        };
*/
    public virtual Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'product_name' => 'productName',
        'price_category' => 'priceCategory',
        'order_date' => 'orderDate',
        'order_item_charge_type' => 'orderItemChargeType',
        'scheduled_charges' => 'scheduledCharges'
      };
      return propertyMappings;
    }
  }
  /**
   * Gets or Sets OrderItemChargeType
   */
  public enum GTVAPIOrderItemChargeType {
    ORDER_ITEM,
    TAX
  }
  /**
   * GTVAPIProduct
   */
  public class GTVAPIProduct extends GTVAPIEntity implements GTVAPIRestClient.MappedProperties {
    /**
     * (unique_key)  The internal entity id for this entity representation
     * @return id
     */
    public String id { get; private set; }

    /**
     * Get productType
     * @return productType
     */
    public String productType { get; set; }

    /**
     * (unique_key) The product name
     * @return name
     */
    public String name { get; set; }

    /**
     * Get description
     * @return description
     */
    public String description { get; set; }

    /**
     * Get shortDescription
     * @return shortDescription
     */
    public String shortDescription { get; set; }

    /**
     * Get state
     * @return state
     */
    public GTVAPIProductState state { get; set; }

    /**
     * (unique_key) The product SKU
     * @return sku
     */
    public String sku { get; set; }

    /**
     * Get requiresAgreement
     * @return requiresAgreement
     */
    public Boolean requiresAgreement { get; set; }

    /**
     * Get serialized
     * @return serialized
     */
    public Boolean serialized { get; set; }

    /**
     * Get taxable
     * @return taxable
     */
    public Boolean taxable { get; set; }

    /**
     * Get trial
     * @return trial
     */
    public Boolean trial { get; set; }

    /**
     * Get trialDays
     * @return trialDays
     */
    public Integer trialDays { get; set; }

    /**
     * Get trialOverride
     * @return trialOverride
     */
    public Boolean trialOverride { get; set; }

    /**
     * Get defaultQuantity
     * @return defaultQuantity
     */
    public Double defaultQuantity { get; set; }

    /**
     * Get productLevel
     * @return productLevel
     */
    public Integer productLevel { get; set; }

    /**
     * Get prices
     * @return prices
     */
    public List<GTVAPIProductPrice> prices { get; set; }

    /**
     * Get productCategory
     * @return productCategory
     */
    public GTVAPIProductCategory productCategory { get; set; }

    /**
     * Get internalName
     * @return internalName
     */
    public String internalName { get; set; }

    /**
     * (unique_key) External product number
     * @return externalProductNumber
     */
    public String externalProductNumber { get; set; }

    /**
     * Get minServiceResources
     * @return minServiceResources
     */
    public Integer minServiceResources { get; set; }

    /**
     * Get maxServiceResources
     * @return maxServiceResources
     */
    public Integer maxServiceResources { get; set; }

    /**
     * Get serviceResourceCategory
     * @return serviceResourceCategory
     */
    public GTVAPIResourceCategory serviceResourceCategory { get; set; }

    /**
     * Get actions
     * @return actions
     */
    public List<GTVAPIAction> actions { get; set; }

    /**
     * Get productUsageRules
     * @return productUsageRules
     */
    public List<GTVAPIProductUsageRule> productUsageRules { get; set; }

    /**
     * Get productTags
     * @return productTags
     */
    public List<GTVAPIProductTag> productTags { get; set; }

    /**
     * Get ruleOverride
     * @return ruleOverride
     */
    public Boolean ruleOverride { get; set; }

    /**
     * Get ruleType
     * @return ruleType
     */
    public GTVAPIRuleType ruleType { get; set; }

    /*  
        private final Map<String, object> propertyMappings = new Map<String, object>{
        'product_type' => 'productType',
        'short_description' => 'shortDescription',
        'requires_agreement' => 'requiresAgreement',
        'trial_days' => 'trialDays',
        'trial_override' => 'trialOverride',
        'default_quantity' => 'defaultQuantity',
        'product_level' => 'productLevel',
        'product_category' => new List<String>{'productCategory','GTVAPIProductCategory'},
        'internal_name' => 'internalName',
        'external_product_number' => 'externalProductNumber',
        'min_service_resources' => 'minServiceResources',
        'max_service_resources' => 'maxServiceResources',
        'service_resource_category' => new List<String>{'serviceResourceCategory','GTVAPIResourceCategory'},
        'usage_rules' => new List<String>{'productUsageRules','GTVAPIProductUsageRule'},
        'product_tags' => new List<String>{'productTags','GTVAPIProductTag'},
        'rule_Override' => 'ruleOverride',
        'rule_Type' => 'ruleType',
        'prices' => new List<String>{'prices','GTVAPIProductPrice'}
        };
*/
    public Map<String, object> getPropertyMappings() {
      Map<String, object> propertyMappings = new Map<String, object>{
        'product_type' => 'productType',
        'short_description' => 'shortDescription',
        'requires_agreement' => 'requiresAgreement',
        'trial_days' => 'trialDays',
        'trial_override' => 'trialOverride',
        'default_quantity' => 'defaultQuantity',
        'product_level' => 'productLevel',
        'product_category' => new List<String>{
          'productCategory',
          'GTVAPIProductCategory'
        },
        'internal_name' => 'internalName',
        'external_product_number' => 'externalProductNumber',
        'min_service_resources' => 'minServiceResources',
        'max_service_resources' => 'maxServiceResources',
        'service_resource_category' => new List<String>{
          'serviceResourceCategory',
          'GTVAPIResourceCategory'
        },
        'usage_rules' => new List<String>{
          'productUsageRules',
          'GTVAPIProductUsageRule'
        },
        'product_tags' => new List<String>{ 'productTags', 'GTVAPIProductTag' },
        'rule_override' => 'ruleOverride',
        'rule_Type' => 'ruleType',
        'prices' => new List<String>{ 'prices', 'GTVAPIProductPrice' }
      };
      return propertyMappings;
    }

    public GTVAPIProduct() {
      prices = new List<GTVAPIProductPrice>();
      actions = new List<GTVAPIAction>();
      productUsageRules = new List<GTVAPIProductUsageRule>();
      productTags = new List<GTVAPIProductTag>();
    }
  }
  /**
   * Gets or Sets ProductState
   */
  public enum GTVAPIProductState {
    DRAFT,
    AVAILABLE,
    NOT_AVAILABLE
  }
  /**
   * GTVAPIProductPrice
   */
  public class GTVAPIProductPrice extends GTVAPIEntity implements GTVAPIRestClient.MappedProperties {
    /**
     * (unique_key)  The internal entity id for this entity representation
     * @return id
     */
    public String id { get; private set; }

    public Boolean tapered { get; set; }

    /**
     * Get priceType
     * @return priceType
     */
    public String priceType { get; set; }

    /**
     * Get fromDate
     * @return fromDate
     */

    /**
     * Get currencyCode
     * @return currencyCode
     */
    public GTVAPICurrencyCode currencyCode { get; set; }

    /**
     * Get priceCategory
     * @return priceCategory
     */
    public GTVAPIPriceCategory priceCategory { get; set; }

    public DateTime validFrom { get; set; }

    /**
     * Get thruDate
     * @return thruDate
     */
    public DateTime thruDate { get; set; }

    /**
     * Get priceOverride
     * @return priceOverride
     */
    public Boolean priceOverride { get; set; }

    /**
     * Get allowScheduledCharges
     * @return allowScheduledCharges
     */
    public Boolean allowScheduledCharges { get; set; }

    /**
     * Get priceRanges
     * @return priceRanges
     */
    public List<GTVAPIProductPriceRange> priceRanges { get; set; }

    /**
     * Get paymentOnPurchaseRequired
     * @return paymentOnPurchaseRequired
     */
    public Boolean paymentOnPurchaseRequired { get; set; }

    /**
     * Get priceGroup
     * @return priceGroup
     */
    public GTVAPIProductPriceGroupRef priceGroup { get; set; }

    public Boolean recurringPaymentRequired { get; set; }

    /**
     * Get recurrencePeriod
     * @return recurrencePeriod
     */
    public String recurrencePeriod { get; set; }

    public Boolean prorateOnOrder { get; set; }

    public Boolean prorateOnCancel { get; set; }

    public Boolean proratedOnOrderNoCharge { get; set; }

    /**
     * desc
     * @return billInAdvance
     */
    public Boolean billInAdvance { get; set; }

    /**
     * Get productUsageRules
     * @return productUsageRules
     */
    public List<GTVAPIProductUsageRule> productUsageRules { get; set; }

    /**
     * Get billInAdvanceConfiguration
     * @return billInAdvanceConfiguration
     */
    public GTVAPIBillInAdvanceConfiguration billInAdvanceConfiguration {
      get;
      set;
    }

    /*
        private final Map<String, object> propertyMappings = new Map<String, object>{
        'price_type' => 'priceType',
        'product_price_type' => 'priceType',
        'valid_from' => 'fromDate',
        'thru_date' => 'thruDate',
        'price_override' => 'priceOverride',
        'allow_scheduled_charges' => 'allowScheduledCharges',
        'price_ranges' => new List<String>{'priceRanges','GTVAPIProductPriceRange'},
        'payment_on_purchase_required' => 'paymentOnPurchaseRequired',
        'product_usage_rules' => 'productUsageRules',
        'currency_code' => 'currencyCode',
        'price_category' => 'priceCategory',
        'recurrence_period' => 'recurrencePeriod',
        'recurring_payment_required' => 'recurringPaymentRequired'

        };
*/
    public Map<String, object> getPropertyMappings() {
      Map<String, object> propertyMappings = new Map<String, object>{
        'price_type' => 'priceType',
        'product_price_type' => 'priceType',
        'valid_from' => 'validFrom',
        'valid_to' => 'thruDate',
        'price_override' => 'priceOverride',
        'allow_scheduled_charges' => 'allowScheduledCharges',
        'price_ranges' => new List<String>{
          'priceRanges',
          'GTVAPIProductPriceRange'
        },
        'payment_on_purchase_required' => 'paymentOnPurchaseRequired',
        'product_usage_rules' => 'productUsageRules',
        'currency_code' => 'currencyCode',
        'category' => 'priceCategory',
        'recurrence_period' => 'recurrencePeriod',
        'recurring_payment_required' => 'recurringPaymentRequired',
        'prorated_on_order' => 'prorateOnOrder',
        'prorated_on_cancel' => 'prorateOnCancel',
        'prorated_on_order_no_charge' => 'proratedOnOrderNoCharge',
        'bill_in_advance' => 'billInAdvance',
        'price_group' => 'priceGroup',
        'bill_in_advance_configuration' => 'billInAdvanceConfiguration'
      };
      return propertyMappings;
    }

    public GTVAPIProductPrice() {
      priceRanges = new List<GTVAPIProductPriceRange>();
      productUsageRules = new List<GTVAPIProductUsageRule>();
    }
  }
  /**
   * GTVAPIProductPriceRange
   */
  public class GTVAPIProductPriceRange extends GTVAPIEntity implements GTVAPIRestClient.MappedProperties {
    /**
     * (unique_key)  The internal entity id for this entity representation
     * @return id
     */
    public String id { get; private set; }

    /**
     * Get quantityBeginRange
     * @return quantityBeginRange
     */
    public Double quantityBeginRange { get; set; }

    /**
     * Get quantityEndRange
     * @return quantityEndRange
     */
    public Double quantityEndRange { get; set; }

    /**
     * Get price
     * @return price
     */
    public Double price { get; set; }

    /**
     * Get level
     * @return level
     */
    public Integer level { get; set; }

    /**
     * Get currencyCode
     * @return currencyCode
     */
    public GTVAPICurrencyCode currencyCode { get; set; }
    /*
        private final Map<String, String> propertyMappings = new Map<String, String>{
        'quantity_begin_range' => 'quantityBeginRange',
        'quantity_end_range' => 'quantityEndRange',
        'currency_code' => 'currencyCode'
        };
*/
    public Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'quantity_begin_range' => 'quantityBeginRange',
        'quantity_end_range' => 'quantityEndRange',
        'currency_code' => 'currencyCode'
      };
      return propertyMappings;
    }
  }
  /**
   * GTVAPIProductUsageRule
   */
  public class GTVAPIProductUsageRule extends GTVAPIUsageRuleTemplate implements GTVAPIRestClient.MappedProperties {
    /**
     * (unique_key)  The internal entity id for this entity representation
     * @return id
     */
    public String id { get; private set; }

    /**
     * Get r_limit
     * @return r_limit
     */
    public Double r_limit { get; set; }

    /**
     * Get usageUom
     * @return usageUom
     */
    public String usageUom { get; set; }

    /**
     * Get name
     * @return name
     */
    public String name { get; set; }

    /**
     * Get order
     * @return order
     */
    public Integer order { get; set; }

    /**
     * Get prorateOnOrder
     * @return prorateOnOrder
     */
    public Boolean prorateOnOrder { get; set; }

    /**
     * Get prorateOnCancel
     * @return prorateOnCancel
     */
    public Boolean prorateOnCancel { get; set; }

    /**
     * Get rolloverType
     * @return rolloverType
     */
    public GTVAPIRollOverType rolloverType { get; set; }

    /**
     * Get allowanceType
     * @return allowanceType
     */
    public GTVAPIAllowanceType allowanceType { get; set; }

    /**
     * Get validFrom
     * @return validFrom
     */
    public DateTime validFrom { get; set; }

    /**
     * Get validTo
     * @return validTo
     */
    public DateTime validTo { get; set; }

    /**
     * Get ruleType
     * @return ruleType
     */
    public GTVAPIRuleType ruleType { get; set; }

    /**
     * Get chargeCategory
     * @return chargeCategory
     */
    public GTVAPIUsageChargeCategory chargeCategory { get; set; }

    /**
     * Get usageRate
     * @return usageRate
     */
    public GTVAPIUsageRate usageRate { get; set; }

    /**
     * Get status
     * @return status
     */
    public GTVAPIServiceUsageRuleStatus status { get; set; }
    /**
     * Get allowanceUom
     * @return allowanceUom
     */
    public String allowanceUom { get; set; }
    /**
     * Get allowanceAmount
     * @return allowanceAmount
     */
    public String allowanceAmount { get; set; }
    /**
     * Get spec
     * @return spec
     */
    public GTVAPICreateUsageRuleSpecification spec { get; set; }

    /*   
        private final Map<String, object> propertyMappings = new Map<String, object>{
        'limit' => 'r_limit',
        'usage_uom' => 'usageUom',
        'prorated_on_order' => 'prorateOnOrder',
        'prorated_on_cancel' => 'prorateOnCancel',
        'roll_over_type' => 'rolloverType',
        'allowance_type' => 'allowanceType',
        'valid_from' => 'validFrom',
        'valid_to' => 'validTo', 
        'rule_type' => 'ruleType',
        'charge_category' =>  new List<String>{'chargeCategory','GTVAPIUsageChargeCategory'},
        'usage_rate' => new List<String>{'usageRate','GTVAPIUsageRate'}
        };
*/
    public override Map<String, object> getPropertyMappings() {
      Map<String, object> propertyMappings = new Map<String, object>{
        'limit' => 'r_limit',
        'usage_uom' => 'usageUom',
        'prorated_on_order' => 'prorateOnOrder',
        'prorated_on_cancel' => 'prorateOnCancel',
        'roll_over_type' => 'rolloverType',
        'allowance_type' => 'allowanceType',
        'valid_from' => 'validFrom',
        'valid_to' => 'validTo',
        'rule_type' => 'ruleType',
        'charge_category' => new List<String>{
          'chargeCategory',
          'GTVAPIUsageChargeCategory'
        },
        'usage_rate' => new List<String>{ 'usageRate', 'GTVAPIUsageRate' },
        'allowance_amount' => 'allowanceAmount',
        'spec' => new List<String>{
          'spec',
          'GTVAPICreateUsageRuleSpecification'
        },
        'allowance_uom' => 'allowanceUom'
      };
      return propertyMappings;
    }
  }
  /**
   * Gets or Sets RollOverType
   */
  public enum GTVAPIRollOverType {
    NONE,
    UNCAPPED
  }
  /**
   * Gets or Sets AllowanceType
   */
  public enum GTVAPIAllowanceType {
    UNLIMITED,
    RECURRING,
    ONE_TIME
  }
  /**
   * Gets or Sets RuleType
   */
  public enum GTVAPIRuleType {
    TAPERED,
    TIERED
  }
  /**
   * GTVAPIUsageChargeCategory
   */
  public class GTVAPIUsageChargeCategory extends GTVAPIChargeCategory implements GTVAPIRestClient.MappedProperties {
    /*      private final Map<String, String> propertyMappings = new Map<String, String>{
        'charge_category_type' => 'chargeCategoryType'
        };
*/
    public override Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'charge_category_type' => 'chargeCategoryType'
      };
      return propertyMappings;
    }
  }

  /**
   * Indicates the status of the usage rate. \nACTIVE status means that the rate table is available and can be used, or it is in use. \nSUSPENDED status means that the rate table cannot be used. \nDRAFT status means that the rate table is not ready to be used. The rule may need details changed or added. While in Draft status, the rate table can be deleted. \nAfter changing the table from Draft status to Active or Suspended, the rate table cannot be deleted.\n
   */
  public enum GTVAPIUsageRateStatus {
    ACTIVE,
    DRAFT,
    SUSPENDED
  }
  /**
   * A representation of the core Rate Table entity. A rate table contains a list of usage-based charges that can be applied to a given event based on the outcome of a usage rule.
   */
  public class GTVAPIRateTable extends GTVAPIEntity {
    /**
     * (unique_key) The ID of the entity.
     * @return id
     */
    //public String id { get; private set; }

    /**
     * (unique_key) The name of this rate table. Maximum 40 characters long (including spaces and punctuation).
     * @return name
     */
    public String name { get; set; }

    /**
     * The description of this rate table.
     * @return description
     */
    public String description { get; set; }

    /**
     * Get status
     * @return status
     */
    public GTVAPIUsageRateStatus status { get; set; }

    /**
     * Get uom
     * @return uom
     */
    public String uom { get; set; }
    /*  private final Map<String, String> propertyMappings = new Map<String, String>{
        'status' => 'status',
        'uom' => 'uom'
        };*/

    public Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'status' => 'status',
        'uom' => 'uom'
      };
      return propertyMappings;
    }
  }
  /**
   * GTVAPIUsageRate
   */
  public class GTVAPIUsageRate extends GTVAPIEntity implements GTVAPIRestClient.MappedProperties {
    /**
     * (unique_key)  The internal entity id for this entity representation
     * @return id
     */
    public String id { get; private set; }

    /**
     * Get usageRateType
     * @return usageRateType
     */
    public String usageRateType { get; set; }
    /**
     * Get usageRateType
     * @return usageRateType
     */
    public String usageFieldName { get; set; }

    /**
     * Get uom
     * @return uom
     */
    public String uom { get; set; }
    /**
     * Get rate
     * @return rate
     */
    public Decimal rate { get; set; }

    /**
     * Get validFrom
     * @return validFrom
     */
    public DateTime validFrom { get; set; }

    /**
     * Get validTo
     * @return validTo
     */
    public DateTime validTo { get; set; }
    /**
     * Get RateTable
     * @return Table
     */
    public GTVAPIRateTable rateTable { get; set; }
    /**
     * Get chargeCategory
     * @return chargeCategory
     */
    public GTVAPIUsageChargeCategory chargeCategory { get; set; }

    /*private final Map<String, String> propertyMappings = new Map<String, String>{
        'rate_type' => 'usageRateType',
        'valid_from' => 'validFrom',
        'valid_to' => 'validTo',
        'rate' => 'rate',
        'rate_table' => 'rateTable',
        'usage_field_name' => 'usageFieldName'
        };*/

    public Map<String, Object> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'rate_type' => 'usageRateType',
        'valid_from' => 'validFrom',
        'valid_to' => 'validTo',
        'rate' => 'rate',
        'rate_table' => 'rateTable',
        'charge_category' => 'chargeCategory',
        'usage_field_name' => 'usageFieldName'
      };
      return propertyMappings;
    }
  }
  /**
   * GTVAPIPriceCategory
   */
  public class GTVAPIPriceCategory extends GTVAPIChargeCategory implements GTVAPIRestClient.MappedProperties {
    /*   private final Map<String, String> propertyMappings = new Map<String, String>{
        'charge_category_type' => 'chargeCategoryType'
        };*/

    public override Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'charge_category_type' => 'chargeCategoryType'
      };
      return propertyMappings;
    }
  }
  /**
   * GTVAPIProductCategory
   */
  public class GTVAPIProductCategory extends GTVAPIEntity {
    /**
     * (unique_key)  The internal entity id for this entity representation
     * @return id
     */
    public String id { get; private set; }

    /**
     * Get name
     * @return name
     */
    public String name { get; set; }

    /**
     * Get description
     * @return description
     */
    public String description { get; set; }

    /**
     * Get status
     * @return status
     */
    public GTVAPIProductCategoryStatus status { get; set; }
  }
  /**
   * Gets or Sets ProductCategoryStatus
   */
  public enum GTVAPIProductCategoryStatus {
    ACTIVE,
    SUSPENDED,
    CANCELED
  }
  /**
   * GTVAPIResourceCategory
   */
  public class GTVAPIResourceCategory extends GTVAPIEntity implements GTVAPIRestClient.MappedProperties {
    /**
     * (unique_key)  The internal entity id for this entity representation
     * @return id
     */
    public String id { get; private set; }

    /**
     * (unique_key) The name of a TRACT service resource category
     * @return name
     */
    public String name { get; set; }

    /**
     * Get resourceType
     * @return resourceType
     */
    public GTVAPIResourceType resourceType { get; set; }

    /**
     * Get status
     * @return status
     */
    public GTVAPIResourceCategoryStatus status { get; set; }

    /**
     * Allows more than one service to use a service-resource
     * @return allowMultipleServices
     */
    public Boolean allowMultipleServices { get; set; }

    /* private final Map<String, String> propertyMappings = new Map<String, String>{
        'resource_type' => 'resourceType',
        'allow_multiple_services' => 'allowMultipleServices'
        };
*/
    public Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'resource_type' => 'resourceType',
        'allow_multiple_services' => 'allowMultipleServices'
      };

      return propertyMappings;
    }
  }

  /**
   * Gets or Sets ResourceCategoryStatus
   */
  public enum GTVAPIResourceCategoryStatus {
    ACTIVE,
    SUSPENDED,
    CANCELED
  }
  /**
   * GTVAPIAction
   */
  public virtual class GTVAPIAction extends GTVAPIEntity implements GTVAPIRestClient.MappedProperties {
    /**
     * (unique_key)  The internal entity id for this entity representation
     * @return id
     */
    public String id { get; private set; }

    /**
     * Get name
     * @return name
     */
    public String name { get; set; }

    /**
     * Get enabled
     * @return enabled
     */
    public Boolean enabled { get; set; }

    /**
     * Get friendlyName
     * @return friendlyName
     */
    public String friendlyName { get; set; }

    /**
     * Get supportApproval
     * @return supportApproval
     */
    public Boolean supportApproval { get; set; }

    /**
     * Get actionType
     * @return actionType
     */
    public GTVAPIActionType actionType { get; set; }

    /**
     * The list of operations in this page
     * @return operations
     */
    public List<GTVAPIOperation> operations { get; set; }

    /*  private final Map<String, String> propertyMappings = new Map<String, String>{
        'friendly_name' => 'friendlyName',
        'support_approval' => 'supportApproval',
        'action_type' => 'actionType'
        };
*/
    public virtual Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'friendly_name' => 'friendlyName',
        'support_approval' => 'supportApproval',
        'action_type' => 'actionType'
      };
      return propertyMappings;
    }

    public GTVAPIAction() {
      operations = new List<GTVAPIOperation>();
    }
  }
  /**
   * Gets or Sets ActionType
   */
  public enum GTVAPIActionType {
    BILLING_ACCOUNT,
    PRODUCT_SALE,
    SERVICE,
    SERVICE_CFV
  }
  /**
   * GTVAPIOperation
   */
  public class GTVAPIOperation extends GTVAPIEntity implements GTVAPIRestClient.MappedProperties {
    /**
     * (unique_key)  The internal entity id for this entity representation
     * @return id
     */
    public String id { get; private set; }

    /**
     * Get operationType
     * @return operationType
     */
    public GTVAPIOperationType operationType { get; set; }

    /**
     * Get name
     * @return name
     */
    public String name { get; set; }

    /**
     * Get enabled
     * @return enabled
     */
    public Boolean enabled { get; set; }

    /*      private final Map<String, String> propertyMappings = new Map<String, String>{
        'operation_type' => 'operationType'
        };
*/
    public Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'operation_type' => 'operationType'
      };
      return propertyMappings;
    }
  }
  /**
   * Gets or Sets OperationType
   */
  public enum GTVAPIOperationType {
    APPROVAL,
    EMAIL,
    FTP,
    HTTP_REQUEST
  }
  /**
   * GTVAPIProductTag
   */
  public class GTVAPIProductTag extends GTVAPIEntity {
    /**
     * (unique_key)  The internal entity id for this entity representation
     * @return id
     */
    public String id { get; private set; }

    /**
     * Get name
     * @return name
     */
    public String name { get; set; }

    /**
     * Get description
     * @return description
     */
    public String description { get; set; }

    /**
     * Get priority
     * @return priority
     */
    public Integer priority { get; set; }
  }
  /**
   * GTVAPIUsageRuleTemplate
   */
  public virtual class GTVAPIUsageRuleTemplate extends GTVAPIEntity implements GTVAPIRestClient.MappedProperties {
    /**
     * (unique_key)  The internal entity id for this entity representation
     * @return id
     */
    public String id { get; private set; }

    /**
     * Get r_limit
     * @return r_limit
     */
    public Double r_limit { get; set; }

    /**
     * Get usageUom
     * @return usageUom
     */
    public String usageUom { get; set; }

    /**
     * Get name
     * @return name
     */
    public String name { get; set; }

    /**
     * Get order
     * @return order
     */
    public Integer order { get; set; }
    /**
     * Get allowanceAmount
     * @return allowanceAmount
     */
    public String allowanceAmount { get; set; }

    /**
     * Get prorateOnOrder
     * @return prorateOnOrder
     */
    public Boolean prorateOnOrder { get; set; }

    /**
     * Get prorateOnCancel
     * @return prorateOnCancel
     */
    public Boolean prorateOnCancel { get; set; }

    /**
     * Get rolloverType
     * @return rolloverType
     */
    public GTVAPIRollOverType rolloverType { get; set; }

    /**
     * Get allowanceType
     * @return allowanceType
     */
    public GTVAPIAllowanceType allowanceType { get; set; }

    /**
     * Get validFrom
     * @return validFrom
     */
    public DateTime validFrom { get; set; }

    /**
     * Get validTo
     * @return validTo
     */
    public DateTime validTo { get; set; }

    /**
     * Get ruleType
     * @return ruleType
     */
    public GTVAPIRuleType ruleType { get; set; }

    /**
     * Get chargeCategory
     * @return chargeCategory
     */
    public GTVAPIUsageChargeCategory chargeCategory { get; set; }

    /**
     * Get usageRate
     * @return usageRate
     */
    public GTVAPIUsageRate usageRate { get; set; }
    /**
     * Get spec
     * @return spec
     */
    public GTVAPICreateUsageRuleSpecification spec { get; set; }

    /*
        private final Map<String, object> propertyMappings = new Map<String, object>{
        'limit' => 'r_limit',
        'usage_uom' => 'usageUom',
        'prorate_on_order' => 'prorateOnOrder',
        'prorate_on_cancel' => 'prorateOnCancel',
        'rollover_type' => 'rolloverType',
        'allowance_type' => 'allowanceType',
        'valid_from' => 'validFrom',
        'valid_to' => 'validTo',
        'rule_type' => 'ruleType',
        'charge_category' => 'chargeCategory',
        'usage_rate' => 'usageRate'
        };
*/
    public virtual Map<String, object> getPropertyMappings() {
      Map<String, object> propertyMappings = new Map<String, object>{
        'limit' => 'r_limit',
        'usage_uom' => 'usageUom',
        'prorate_on_order' => 'prorateOnOrder',
        'prorate_on_cancel' => 'prorateOnCancel',
        'rollover_type' => 'rolloverType',
        'allowance_type' => 'allowanceType',
        'valid_from' => 'validFrom',
        'valid_to' => 'validTo',
        'rule_type' => 'ruleType',
        'charge_category' => 'chargeCategory',
        'usage_rate' => 'usageRate',
        'spec' => new List<String>{
          'spec',
          'GTVAPICreateUsageRuleSpecification'
        },
        'usage_rule_specification_type' => 'usageRuleSpecificationType'
      };
      return propertyMappings;
    }
  }
  /**
   * Gets or Sets UsageDurationUom
   */
  public enum GTVAPIUsageDurationUom {
    MILLISECOND,
    SECOND,
    MINUTE,
    HOUR,
    DAY,
    WEEK,
    EVENT,
    BYTE1,
    KILOBYTE,
    MEGABYTE,
    GIGABYTE,
    TERABYTE,
    COUNT,
    BITS_PER_SECOND,
    KILOBITS_PER_SECOND,
    MEGABITS_PER_SECOND,
    GIGABITS_PER_SECOND,
    CURRENCY1,
    WATT,
    KILOWATT,
    MEGAWATT,
    GIGAWATT,
    WATTS_PER_HOUR,
    KILOWATTS_PER_HOUR,
    MEGAWATTS_PER_HOUR,
    GIGAWATTS_PER_HOUR
  }
  /**
   * GTVAPIChargeCategory
   */
  public virtual class GTVAPIChargeCategory extends GTVAPIEntity implements GTVAPIRestClient.MappedProperties {
    /**
     * (unique_key)  The internal entity id for this entity representation
     * @return id
     */
    public String id { get; private set; }

    /**
     * Get chargeCategoryType
     * @return chargeCategoryType
     */
    public String chargeCategoryType { get; set; }

    /**
     * (unique_key) The name of TRACT category
     * @return name
     */
    public String name { get; set; }

    /**
     * Get description
     * @return description
     */
    public String description { get; set; }

    /**
     * Get priority
     * @return priority
     */
    public Long priority { get; set; }

    /**
     * Get status
     * @return status
     */
    public GTVAPIPriceCategoryStatus status { get; set; }
    /*
        private final Map<String, String> propertyMappings = new Map<String, String>{
        'charge_category_type' => 'chargeCategoryType'
        };
*/
    public virtual Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'charge_category_type' => 'chargeCategoryType'
      };
      return propertyMappings;
    }
  }
  /**
   * Gets or Sets ChargeCategoryType
   */
  public enum GTVAPIChargeCategoryType {
    ADJUSTMENT,
    DISCOUNT,
    PRICE,
    USAGE_PRICE,
    ADDITIONAL_FEE,
    PAYMENT,
    TAX
  }
  /**
   * Gets or Sets PriceCategoryStatus
   */
  public enum GTVAPIPriceCategoryStatus {
    ACTIVE,
    SUSPENDED,
    CANCELED
  }
  /**
   * GTVAPIOrder
   */
  public virtual class GTVAPIOrder extends GTVAPIEntity implements GTVAPIRestClient.MappedProperties {
    /**
     * (unique_key)  The internal entity id for this entity representation
     * @return id
     */
    public String id { get; private set; }

    /**
     * Get orderType
     * @return orderType
     */
    public String orderType { get; set; }

    /**
     * Get orderNum
     * @return orderNum
     */
    public String orderNum { get; set; }

    /**
     * Get orderItems
     * @return orderItems
     */
    public List<GTVAPIOrderItem> orderItems { get; set; }

    /**
     * Get billingAccount
     * @return billingAccount
     */
    public GTVAPIBillingAccount billingAccount { get; set; }

    /**
     * Get payments
     * @return payments
     */
    public List<GTVAPIPayment> payments { get; set; }

    /**
     * Get note
     * @return note
     */
    public String note { get; set; }

    /**
     * Get purchaseOrderNumber
     * @return purchaseOrderNumber
     */
    public String purchaseOrderNumber { get; set; }

    /**
     * Get emaiReceipt
     * @return emaiReceipt
     */
    public Boolean emaiReceipt { get; set; }

    /**
     * Get referral
     * @return referral
     */
    public String referral { get; set; }

    /**
     * Get orderDate
     * @return orderDate
     */
    public DateTime orderDate { get; set; }

    /**
     * Get totalAmount
     * @return totalAmount
     */
    public Double totalAmount { get; set; }

    /**
     * Get customFieldValues
     * @return customFieldValues
     */
    public List<GTVAPIOrderCustomFieldValue> customFieldValues { get; set; }

    /**
     * Get status
     * @return status
     */
    public GTVAPIOrderStatus status { get; set; }

    /**
     * Get subTotal
     * @return subTotal
     */
    public Double subTotal { get; set; }

    /**
     * Get taxTotal
     * @return taxTotal
     */
    public Double taxTotal { get; set; }

    /**
     * Get dueNowTotal
     * @return dueNowTotal
     */
    public Double dueNowTotal { get; set; }

    /**
     * Get dueNowTaxTotal
     * @return dueNowTaxTotal
     */
    public Double dueNowTaxTotal { get; set; }

    /*    private final Map<String, object> propertyMappings = new Map<String,object>{
        'order_type' => 'orderType',
        'order_num' => 'orderNum',
        'order_items' => new List<String>{'orderItems','GTVAPIOrderItem'},
        'billing_account' => new List<String>{'billingAccount','GTVAPIBillingAccount'},
        'purchase_order_number' => 'purchaseOrderNumber',
        'emai_receipt' => 'emaiReceipt',
        'order_date' => 'orderDate',
        'total_amount' => 'totalAmount',
        'custom_field_values' => 'customFieldValues',
        'sub_total' => 'subTotal',
        'tax_total' => 'taxTotal',
        'due_now_total' => 'dueNowTotal',
        'due_now_tax_total' => 'dueNowTaxTotal'
        };
*/
    public virtual Map<String, object> getPropertyMappings() {
      Map<String, object> propertyMappings = new Map<String, object>{
        'order_type' => 'orderType',
        'order_num' => 'orderNum',
        'order_items' => new List<String>{ 'orderItems', 'GTVAPIOrderItem' },
        'billing_account' => new List<String>{
          'billingAccount',
          'GTVAPIBillingAccount'
        },
        'purchase_order_number' => 'purchaseOrderNumber',
        'emai_receipt' => 'emaiReceipt',
        'order_date' => 'orderDate',
        'total_amount' => 'totalAmount',
        'custom_field_values' => 'customFieldValues',
        'sub_total' => 'subTotal',
        'tax_total' => 'taxTotal',
        'due_now_total' => 'dueNowTotal',
        'due_now_tax_total' => 'dueNowTaxTotal'
      };
      return propertyMappings;
    }

    public GTVAPIOrder() {
      orderItems = new List<GTVAPIOrderItem>();
      payments = new List<GTVAPIPayment>();
      customFieldValues = new List<GTVAPIOrderCustomFieldValue>();
    }
  }

  /**
   * A representation of the core Change Order entity, represents change to an existing service.
   */
  public class GTVAPIChangeOrder extends GTVAPIOrder implements GTVAPIRestClient.MappedProperties {
    /*private final Map<String, String> propertyMappings = new Map<String, String>{
        'order_type' => 'orderType',
        'order_num' => 'orderNum',
        'order_items' => 'orderItems',
        'billing_account' => 'billingAccount',
        'purchase_order_number' => 'purchaseOrderNumber',
        'email_receipt' => 'emailReceipt',
        'order_date' => 'orderDate',
        'total_amount' => 'totalAmount',
        'custom_field_values' => 'customFieldValues',
        'sub_total' => 'subTotal',
        'tax_total' => 'taxTotal',
        'due_now_total' => 'dueNowTotal',
        'due_now_tax_total' => 'dueNowTaxTotal',
        'cpq_discounts' => 'cpqDiscounts'
    };
*/
    public override Map<String, Object> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'order_type' => 'orderType',
        'order_num' => 'orderNum',
        'order_items' => 'orderItems',
        'billing_account' => 'billingAccount',
        'purchase_order_number' => 'purchaseOrderNumber',
        'email_receipt' => 'emailReceipt',
        'order_date' => 'orderDate',
        'total_amount' => 'totalAmount',
        'custom_field_values' => 'customFieldValues',
        'sub_total' => 'subTotal',
        'tax_total' => 'taxTotal',
        'due_now_total' => 'dueNowTotal',
        'due_now_tax_total' => 'dueNowTaxTotal',
        'cpq_discounts' => 'cpqDiscounts'
      };

      return propertyMappings;
    }

    public GTVAPIChangeOrder() {
    }
  }

  /**
   * GTVAPIOrderItem
   */
  public virtual class GTVAPIOrderItem extends GTVAPIEntity implements GTVAPIRestClient.MappedProperties {
    /**
     * (unique_key)  The internal entity id for this entity representation
     * @return id
     */
    public String id { get; private set; }

    /**
     * Get orderItemType
     * @return orderItemType
     */
    public String orderItemType { get; set; }

    /**
     * Get description
     * @return description
     */
    public String description { get; set; }

    /**
     * Get quantity
     * @return quantity
     */
    public Double quantity { get; set; }

    /**
     * Get status
     * @return status
     */
    public GTVAPIOrderItemStatus status { get; set; }

    /**
     * Get sequence
     * @return sequence
     */
    public Long sequence { get; set; }

    /**
     * val
     * @return grantedValue
     */
    public Double grantedValue { get; set; }

    /**
     * amount
     * @return autoContributionAmount
     */
    public Double autoContributionAmount { get; set; }

    /**
     * threshhold
     * @return autoContributionThreshold
     */
    public Double autoContributionThreshold { get; set; }
    /**
     * Get parentService
     * @return parentService
     */
    public GTVAPIServiceRef parentService { get; set; }
    /**
     * Get parentService
     * @return parentService
     */
    public GTVAPIServiceRef service { get; set; }

    /**
     * value
     * @return autoContributionGrantedValue
     */
    public Double autoContributionGrantedValue { get; set; }

    /**
     * Get orderItems
     * @return orderItems
     */
    public List<GTVAPIAddonServiceProductOrderItem> orderItems { get; set; }

    /**
     * Get orderItemUsageRules
     * @return orderItemUsageRules
     */
    public List<GTVAPIOrderItemUsageRule> orderItemUsageRules { get; set; }

    /**
     * Get orderItemPrices
     * @return orderItemPrices
     */
    public List<GTVAPIOrderItemPrice> orderItemPrices { get; set; }

    public GTVAPIProduct product { get; set; }

    public List<GTVAPIServiceResource> serviceResources { get; set; }

    public GTVAPIPriceListRef priceList { get; set; }

    public GTVAPIOrderItemAgreement orderItemAgreement { get; set; }

    public Double extended_price { get; set; }

    /**
     * The date when the purchase is effective. If no date is entered, then it is generated by the system.
     * @return requestedEffectiveDate
     */
    public Datetime requestedEffectiveDate { get; set; }
    public Boolean consumedPrepaidBalance { get; set; }
    public List<GTVAPIPostalAddress> addresses { get; set; }

    public List<GTVAPIOrderItemCharge> charges { get; set; }

    /* private final Map<String, object> propertyMappings = new Map<String, object>{
        'order_item_type' => 'orderItemType',
        'granted_value' => 'grantedValue',
        'auto_contribution_amount' => 'autoContributionAmount',
        'auto_contribution_threshold' => 'autoContributionThreshold',
        'auto_contribution_granted_value' => 'autoContributionGrantedValue',
        'order_items' => new List<String>{'orderItems','GTVAPIAddonServiceProductOrderItem'},
        'order_item_usage_rules' =>new List<String>{'orderItemUsageRules','GTVAPIOrderItemUsageRule'},
        'order_item_prices' => new List<String>{'orderItemPrices','GTVAPIOrderItemPrice'},
        'product' => new List<String>{'product','GTVAPIProduct'},
        'service_resources' => new List<String>{'serviceResources','GTVAPIServiceResource'},
        'order_item_agreement' => new List<String>{'orderItemAgreement','GTVAPIOrderItemAgreement'}
        };
*/
    public virtual Map<String, object> getPropertyMappings() {
      Map<String, object> propertyMappings = new Map<String, object>{
        'order_item_type' => 'orderItemType',
        'granted_value' => 'grantedValue',
        'auto_contribution_amount' => 'autoContributionAmount',
        'auto_contribution_threshold' => 'autoContributionThreshold',
        'auto_contribution_granted_value' => 'autoContributionGrantedValue',
        'order_items' => new List<String>{
          'orderItems',
          'GTVAPIAddonServiceProductOrderItem'
        },
        'order_item_usage_rules' => new List<String>{
          'orderItemUsageRules',
          'GTVAPIOrderItemUsageRule'
        },
        'order_item_prices' => new List<String>{
          'orderItemPrices',
          'GTVAPIOrderItemPrice'
        },
        'product' => new List<String>{ 'product', 'GTVAPIProduct' },
        'parent_service' => 'parentService',
        'service' => 'service',
        'requested_effective_date' => 'requestedEffectiveDate',
        'consume_prepaid_balance' => 'consumedPrepaidBalance',
        'usage_rules' => 'usage_rules',
        'addresses' => new List<String>{ 'addresses', 'GTVAPIPostalAddress' },
        'service_resources' => new List<String>{
          'serviceResources',
          'GTVAPIServiceResource'
        },
        'order_item_agreement' => new List<String>{
          'orderItemAgreement',
          'GTVAPIOrderItemAgreement'
        }
      };
      return propertyMappings;
    }

    public GTVAPIOrderItem() {
      orderItems = new List<GTVAPIAddonServiceProductOrderItem>();
      orderItemUsageRules = new List<GTVAPIOrderItemUsageRule>();
      orderItemPrices = new List<GTVAPIOrderItemPrice>();
    }
  }
  /**
   * Gets or Sets OrderItemStatus
   */
  public enum GTVAPIOrderItemStatus {
    TRIAL,
    FULFILLMENT,
    IN_PROGRESS,
    COMPLETED,
    CANCELED,
    DENIED,
    ERROR,
    DRAFT
  }
  /**
   * GTVAPIAddonServiceProductOrderItem
   */
  public class GTVAPIAddonServiceProductOrderItem extends GTVAPIProductOrderItem implements GTVAPIRestClient.MappedProperties {
    /*   private final Map<String, object> propertyMappings = new Map<String, object>{
        'order_item_type' => 'orderItemType',
        'granted_value' => 'grantedValue',
        'auto_contribution_amount' => 'autoContributionAmount',
        'auto_contribution_threshold' => 'autoContributionThreshold',
        'auto_contribution_granted_value' => 'autoContributionGrantedValue',
        'order_items' => 'orderItems',
        'order_item_usage_rules' => 'orderItemUsageRules',
        'order_item_prices' => 'orderItemPrices',
        'awaiting_approval' => 'awaitingApproval',
        'price_list' => 'priceList',
        'order_item_agreement' => 'orderItemAgreement',
        'service_resources' => new List<String>{'serviceResources','GTVAPIServiceResource'},
        'requested_effective_date' => 'requestedEffectiveDate',
        'parent_service' => 'parentService',
        'override_trial_days' => 'overrideTrialDays',
        'operation_attributes' => 'operationAttributes',
        'scheduled_charges' => 'scheduledCharges',
        'scheduled_one_time_price_charges' => 'scheduledOneTimePriceCharges',
        'custom_field_values' => 'customFieldValues',
        'order_item_discounts' => 'orderItemDiscounts'
        };*/

    public override Map<String, object> getPropertyMappings() {
      Map<String, object> propertyMappings = new Map<String, object>{
        'order_item_type' => 'orderItemType',
        'granted_value' => 'grantedValue',
        'auto_contribution_amount' => 'autoContributionAmount',
        'auto_contribution_threshold' => 'autoContributionThreshold',
        'auto_contribution_granted_value' => 'autoContributionGrantedValue',
        'order_items' => 'orderItems',
        'order_item_usage_rules' => 'orderItemUsageRules',
        'order_item_prices' => 'orderItemPrices',
        'awaiting_approval' => 'awaitingApproval',
        'price_list' => 'priceList',
        'order_item_agreement' => 'orderItemAgreement',
        'service_resources' => new List<String>{
          'serviceResources',
          'GTVAPIServiceResource'
        },
        'requested_effective_date' => 'requestedEffectiveDate',
        'parent_service' => 'parentService',
        'override_trial_days' => 'overrideTrialDays',
        'operation_attributes' => 'operationAttributes',
        'scheduled_charges' => 'scheduledCharges',
        'scheduled_one_time_price_charges' => 'scheduledOneTimePriceCharges',
        'custom_field_values' => 'customFieldValues',
        'order_item_discounts' => 'orderItemDiscounts'
      };
      return propertyMappings;
    }

    public GTVAPIAddonServiceProductOrderItem() {
    }
  }
  public with sharing class GTVAPIOrderItemUsageRule {
    // ToDo get class details
  }
  /**
   * GTVAPIOrderItemPrice
   */
  public virtual class GTVAPIOrderItemPrice extends GTVAPIEntity implements GTVAPIRestClient.MappedProperties {
    /**
     * (unique_key)  The internal entity id for this entity representation
     * @return id
     */
    public String id { get; private set; }

    /**
     * Get orderItemPriceType
     * @return orderItemPriceType
     */
    public String orderItemPriceType { get; set; }
    /**
     * Get recurrencePeriod
     * @return String
     */
    public String recurrence_period { get; set; }

    /**
     * Get priceOverride
     * @return priceOverride
     */
    public Boolean priceOverride { get; private set; }
    /**
     * Get billInAdvance
     * @return Boolean
     */
    public Boolean billInAdvance { get; private set; }
    /**
     * Get prorateOnCancel
     * @return prorateOnCancel
     */
    public Boolean prorateOnCancel { get; private set; }

    /**
     * Get tapered
     * @return tapered
     */
    public Boolean tapered { get; private set; }

    /**
     * Get amount
     * @return amount
     */
    public Double amount { get; private set; }

    /**
     * Get taxableAmount
     * @return taxableAmount
     */
    public Double taxableAmount { get; private set; }

    /**
     * Get productPrice
     * @return productPrice
     */
    public GTVAPIProductPriceRef productPrice { get; set; }

    /**
     * Get orderItemPriceRanges
     * @return orderItemPriceRanges
     */
    public List<GTVAPIOrderItemPriceRange> orderItemPriceRanges { get; set; }

    /**
     * Get currencyCode
     * @return currencyCode
     */
    public GTVAPICurrencyCode currencyCode { get; set; }

    /**
     * Get category
     * @return category
     */
    public GTVAPIPriceCategoryRef category { get; set; }
    /**
     * Get validFrom
     * @return DateTime
     */
    public Datetime valid_from { get; set; }

    /**
     * Get scheduledCharges
     * @return scheduledCharges
     */
    public List<GTVAPIServicePriceChargeRef> scheduledCharges { get; set; }
    public List<GTVAPIServiceUsageRule> usage_rules { get; set; }

    /*    private final Map<String, object> propertyMappings = new Map<String, object>{
        'order_item_price_type' => 'orderItemPriceType',
        'price_override' => 'priceOverride',
        'taxable_amount' => 'taxableAmount',
        'product_price' => 'productPrice',
        'order_item_price_ranges' => 'orderItemPriceRanges',
        'currency_code' => 'currencyCode'
        };
*/
    public virtual Map<String, object> getPropertyMappings() {
      Map<String, object> propertyMappings = new Map<String, object>{
        'order_item_price_type' => 'orderItemPriceType',
        'price_override' => 'priceOverride',
        'taxable_amount' => 'taxableAmount',
        'product_price' => 'productPrice',
        'valid_from' => 'valid_from',
        'bill_in_advance' => 'billInAdvance',
        'prorated_on_cancel' => 'prorateOnCancel',
        'recurrence_period' => 'recurrence_period',
        'price_ranges' => 'orderItemPriceRanges',
        'scheduled_charges' => 'scheduledCharges',
        'usage_rules' => 'usage_rules'
      };

      return propertyMappings;
    }

    public GTVAPIOrderItemPrice() {
      orderItemPriceRanges = new List<GTVAPIOrderItemPriceRange>();
    }
  }
  /**
   * GTVAPIOrderItemPriceRange
   */
  public class GTVAPIOrderItemPriceRange extends GTVAPIEntity implements GTVAPIRestClient.MappedProperties {
    /**
     * (unique_key)  The internal entity id for this entity representation
     * @return id
     */
    public String id { get; private set; }

    /**
     * Get quantityBeginRange
     * @return quantityBeginRange
     */
    public Double quantityBeginRange { get; private set; }

    /**
     * Get quantityEndRange
     * @return quantityEndRange
     */
    public Double quantityEndRange { get; private set; }

    /**
     * Get price
     * @return price
     */
    public Double price { get; private set; }

    /**
     * Get level
     * @return level
     */
    public Integer level { get; private set; }

    /**
     * Get currencyCode
     * @return currencyCode
     */
    public GTVAPICurrencyCode currencyCode { get; set; }

    /*  private final Map<String, object> propertyMappings = new Map<String, String>{
        'quantity_begin_range' => 'quantityBeginRange',
        'quantity_end_range' => 'quantityEndRange',
        'currency_code' => 'currencyCode'
        };*/

    public Map<String, object> getPropertyMappings() {
      Map<String, object> propertyMappings = new Map<String, String>{
        'quantity_begin_range' => 'quantityBeginRange',
        'quantity_end_range' => 'quantityEndRange',
        'currency_code' => 'currencyCode'
      };
      return propertyMappings;
    }
  }
  /**
   * Creates the Rate Table entity.
   */
  public class GTVAPICreateRateTable extends GTVAPICreateEntity {
    /**
     * Get uom
     * @return uom
     */
    public GTVAPIUsageDurationUom uom { get; set; }

    /**
     * (unique_key) The name of this rate table. Maximum 40 characters long (including spaces and punctuation).
     * @return name
     */
    public String name { get; set; }

    /**
     * Get status
     * @return status
     */
    public GTVAPIUsageRateStatus status { get; set; }

    /**
     * The description of this rate table.
     * @return description
     */
    public String description { get; set; }
  }
  /*
   * TRACT Billing API
   * Create and manage billing accounts, products, orders, services, billing, invoicing, payments, and the general ledger. This microservice provides core functionality for the goTransverse billing platform.
   *
   * OpenAPI spec version: 2
   *
   *
   * NOTE: This class is auto generated by the swagger code generator program.
   * https://github.com/swagger-api/swagger-codegen.git
   * Do not edit the class manually.
   */

  /**
   * Creates the Rate Table Entry entity.
   */
  public class GTVAPICreateRateTableEntry extends GTVAPICreateEntity implements GTVAPIRestClient.MappedProperties {
    /**
     * The rate that applies to the lookup value to five decimal places. If you specify a rate that is fewer than five decimal places, remaining places are filled with zeros (0s). For example, entering 5.2 becomes 5.20000.
     * @return rate
     */
    public Double rate { get; set; }

    /**
     * Enter one or more alphanumeric characters to be the new lookup value to which the rate will apply. The lookup value cannot duplicate any existing lookup value in the table unless the date range for the new entry does not overlap the existing.
     * @return lookup
     */
    public String lookup { get; set; }

    /**
     * The date at which the Rate becomes effective. By default the current date is set, you can change it by entering the needed date. If the new entry\'s lookup value duplicates another existing lookup value, the valid from date cannot overlap the existing date range used by the other existing lookup value.
     * @return validFrom
     */
    public Datetime validFrom { get; set; }

    /**
     * The date at which the rate is no longer effective. If you leave this field empty, the rate will not expire. Enter a date. If the new entry\'s lookup value duplicates another existing lookup value, the valid to date cannot overlap the existing date range used by the other existing lookup value.
     * @return validTo
     */
    public Datetime validTo { get; set; }

    /*  private final Map<String, String> propertyMappings = new Map<String, String>{
        'valid_from' => 'validFrom',
        'valid_to' => 'validTo'
    };
*/
    public Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'valid_from' => 'validFrom',
        'valid_to' => 'validTo'
      };

      return propertyMappings;
    }
  }

  /**
   * A reference to the core Rate Table entity.
   */
  public class GTVAPIRateTableRef extends GTVAPIEntityRef {
    /**
     * (unique_key) The ID of the entity.
     * @return id
     */
    public String id { get; set; }

    /**
     * (unique_key) The name of this rate table. Maximum 40 characters long (including spaces and punctuation).
     * @return name
     */
    public String name { get; set; }
  }

  /**
   * A representation of the core Rate Table Entry entity.
   */
  public class GTVAPIRateTableEntry extends GTVAPIEntity implements GTVAPIRestClient.MappedProperties {
    /**
     * (unique_key) The ID of the entity.
     * @return id
     */
    public String id { get; private set; }

    /**
     * Get rateTable
     * @return rateTable
     */
    public GTVAPIRateTableRef rateTable { get; set; }

    /**
     * The rate that applies to the lookup value to five decimal places. If you specify a rate that is fewer than five decimal places, remaining places are filled with zeros (0s). For example, entering 5.2 becomes 5.20000.
     * @return rate
     */
    public Double rate { get; set; }

    /**
     * Enter one or more alphanumeric characters to be the new lookup value to which the rate will apply. The lookup value cannot duplicate any existing lookup value in the table unless the date range for the new entry does not overlap the existing.
     * @return lookup
     */
    public String lookup { get; set; }

    /**
     * The date at which the rate becomes effective. By default the current date is set, you can change it by entering the needed date. If the new entry\'s lookup value duplicates another existing lookup value, the valid from date cannot overlap the existing date range used by the other existing lookup value.
     * @return validFrom
     */
    public Datetime validFrom { get; set; }

    /**
     * The date at which the rate is no longer effective. If you leave this field empty, the rate will not expire. Enter a date. If the new entry\'s lookup value duplicates another existing lookup value, the valid to date cannot overlap the existing date range used by the other existing lookup value.
     * @return validTo
     */
    public Datetime validTo { get; set; }

    /*   private final Map<String, String> propertyMappings = new Map<String, String>{
        'rate_table' => 'rateTable',
        'valid_from' => 'validFrom',
        'valid_to' => 'validTo'
    };*/

    public Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'rate_table' => 'rateTable',
        'valid_from' => 'validFrom',
        'valid_to' => 'validTo'
      };
      return propertyMappings;
    }
  }

  /**
   * GTVAPIPriceListRef
   */
  public class GTVAPIPriceListRef extends GTVAPIEntityRef {
    /**
     * (unique_key) The internal entity id for this entity representation
     * @return id
     */
    public String id { get; set; }

    /**
     * Get name
     * @return name
     */
    public String name { get; set; }
  }
  /**
   * The Payment object.
   */
  public class GTVAPIPayment extends GTVAPIBasePayment implements GTVAPIRestClient.MappedProperties {
    /**
     * Get receivedAmount
     * @return receivedAmount
     */
    public Double receivedAmount { get; private set; }

    /**
     * Get refundedAmount
     * @return refundedAmount
     */
    public Double refundedAmount { get; private set; }

    /**
     * Get canceledAmount
     * @return canceledAmount
     */
    public Double canceledAmount { get; private set; }

    /**
     * Get receivedCurrencyCode
     * @return receivedCurrencyCode
     */
    public GTVAPICurrencyCode receivedCurrencyCode { get; set; }

    /**
     * Get conversionRate
     * @return conversionRate
     */
    public Double conversionRate { get; private set; }

    /**
     * Get effectiveConversionRate
     * @return effectiveConversionRate
     */
    public Double effectiveConversionRate { get; private set; }

    /**
     * Get applyAutomatically
     * @return applyAutomatically
     */
    public Boolean applyAutomatically { get; private set; }

    /**
     * Get refunds
     * @return refunds
     */
    public List<GTVAPIRefund> refunds { get; set; }

    public String id { get; set; }
    /*
        private final Map<String, Object> propertyMappings = new Map<String, Object>{
        'payment_type' => 'paymentType',
        'payment_method' => 'paymentMethod',
        'billing_account' => 'billingAccount',
        'occurred_on' => 'occurredOn',
        'use_recurring_payment' => 'useRecurringPayment',
        'unapplied_amount' => 'unappliedAmount',
        'ip_address' => 'ipAddress',
        'received_amount' => 'receivedAmount',
        'refunded_amount' => 'refundedAmount',
        'canceled_amount' => 'canceledAmount',
        'received_currency_code' => 'receivedCurrencyCode',
        'conversion_rate' => 'conversionRate',
        'effective_conversion_rate' => 'effectiveConversionRate',
        'apply_automatically' => 'applyAutomatically'
        };
*/
    public override Map<String, Object> getPropertyMappings() {
      Map<String, Object> propertyMappings = new Map<String, Object>{
        'payment_type' => 'paymentType',
        'payment_method' => 'paymentMethod',
        'billing_account' => 'billingAccount',
        'occurred_on' => 'occurredOn',
        'use_recurring_payment' => 'useRecurringPayment',
        'unapplied_amount' => 'unappliedAmount',
        'ip_address' => 'ipAddress',
        'received_amount' => 'receivedAmount',
        'refunded_amount' => 'refundedAmount',
        'canceled_amount' => 'canceledAmount',
        'received_currency_code' => 'receivedCurrencyCode',
        'conversion_rate' => 'conversionRate',
        'effective_conversion_rate' => 'effectiveConversionRate',
        'apply_automatically' => 'applyAutomatically'
      };
      return propertyMappings;
    }

    public GTVAPIPayment() {
      refunds = new List<GTVAPIRefund>();
    }
  }
  /**
   * The Payment object.
   */
  public class GTVAPIRefund extends GTVAPIBasePayment implements GTVAPIRestClient.MappedProperties {
    /**
     * Get paymentChangeReason
     * @return paymentChangeReason
     */
    public GTVAPIPaymentChangeReason paymentChangeReason { get; set; }

    /**
     * Get originalPayment
     * @return originalPayment
     */
    public GTVAPIPayment originalPayment { get; set; }
    /*
        private final Map<String, Object> propertyMappings = new Map<String, Object>{
        'payment_type' => 'paymentType',
        'payment_method' => 'paymentMethod',
        'billing_account' => 'billingAccount',
        'occurred_on' => 'occurredOn',
        'use_recurring_payment' => 'useRecurringPayment',
        'unapplied_amount' => 'unappliedAmount',
        'ip_address' => 'ipAddress',
        'payment_change_reason' => new List<String>{'paymentChangeReason','GTVAPIPaymentChangeReason'},
        'original_payment' => new List<String>{'originalPayment','GTVAPIPayment'}
        };
*/
    public override Map<String, Object> getPropertyMappings() {
      Map<String, Object> propertyMappings = new Map<String, Object>{
        'payment_type' => 'paymentType',
        'payment_method' => 'paymentMethod',
        'billing_account' => 'billingAccount',
        'occurred_on' => 'occurredOn',
        'use_recurring_payment' => 'useRecurringPayment',
        'unapplied_amount' => 'unappliedAmount',
        'ip_address' => 'ipAddress',
        'payment_change_reason' => new List<String>{
          'paymentChangeReason',
          'GTVAPIPaymentChangeReason'
        },
        'original_payment' => new List<String>{
          'originalPayment',
          'GTVAPIPayment'
        }
      };
      return propertyMappings;
    }
  }
  /**
   * GTVAPIPaymentChangeReason
   */
  public class GTVAPIPaymentChangeReason extends GTVAPIReason {
    /**
     * (unique_key)  The internal entity id for this entity representation
     * @return id
     */
    public String id { get; private set; }

    /**
     * Get name
     * @return name
     */
    public String name { get; set; }

    /**
     * Get description
     * @return description
     */
    public String description { get; set; }

    /**
     * Get status
     * @return status
     */
    public String status { get; set; }
  }
  /**
   * GTVAPIOrderCustomFieldValue
   */
  public class GTVAPIOrderCustomFieldValue extends GTVAPICustomFieldValue implements GTVAPIRestClient.MappedProperties {
    /* private final Map<String, String> propertyMappings = new Map<String, String>{
        'custom_field_value_type' => 'customFieldValueType',
        'custom_field' => 'customField'
        };*/

    public override Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'custom_field_value_type' => 'customFieldValueType',
        'custom_field' => 'customField'
      };

      return propertyMappings;
    }
  }
  /**
   * Gets or Sets OrderStatus
   */
  public enum GTVAPIOrderStatus {
    APPROVED,
    COMPLETED,
    DRAFT,
    CANCELED,
    ERROR,
    IN_PROGRESS
  }
  /**
   * GTVAPIProductOrderItem
   */
  public virtual class GTVAPIProductOrderItem extends GTVAPIOrderItem implements GTVAPIRestClient.MappedProperties {
    /**
     * Get awaitingApproval
     * @return awaitingApproval
     */
    public Boolean awaitingApproval { get; private set; }

    /**
     * Get product
     * @return product
     */
    public GTVAPIProductRef product { get; set; }

    /**
     * Get priceList
     * @return priceList
     */
    public GTVAPIPriceListRef priceList { get; set; }

    /**
     * Get orderItemAgreement
     * @return orderItemAgreement
     */
    public GTVAPIOrderItemAgreement orderItemAgreement { get; set; }

    /**
     * Get serviceResources
     * @return serviceResources
     */
    public List<GTVAPIServiceResource> serviceResources { get; set; }

    /**
     * Get requestedEffectiveDate
     * @return requestedEffectiveDate
     */
    public DateTime requestedEffectiveDate { get; private set; }

    /**
     * Get parentService
     * @return parentService
     */
    public GTVAPIServiceRef parentService { get; set; }

    /**
     * Get overrideTrialDays
     * @return overrideTrialDays
     */
    public Integer overrideTrialDays { get; private set; }

    /**
     * Get operationAttributes
     * @return operationAttributes
     */
    public List<GTVAPIOperationRunAttributeRef> operationAttributes {
      get;
      set;
    }

    /**
     * Get scheduledCharges
     * @return scheduledCharges
     */
    public List<GTVAPIServicePriceChargeRef> scheduledCharges { get; set; }

    /**
     * Get scheduledOneTimePriceCharges
     * @return scheduledOneTimePriceCharges
     */
    public List<GTVAPIServicePriceChargeRef> scheduledOneTimePriceCharges {
      get;
      set;
    }

    /**
     * Get customFieldValues
     * @return customFieldValues
     */
    public List<GTVAPIServiceCustomFieldValue> customFieldValues { get; set; }

    /**
     * Get orderItemDiscounts
     * @return orderItemDiscounts
     */
    public List<GTVAPIOrderItemDiscount> orderItemDiscounts { get; set; }

    /**
     * Get addresses
     * @return addresses
     */
    public List<GTVAPIPostalAddress> addresses { get; set; }

    public Double extended_price { get; set; }
    /*
        private final Map<String, object> propertyMappings = new Map<String, object>{
        'order_item_type' => 'orderItemType',
        'granted_value' => 'grantedValue',
        'auto_contribution_amount' => 'autoContributionAmount',
        'auto_contribution_threshold' => 'autoContributionThreshold',
        'auto_contribution_granted_value' => 'autoContributionGrantedValue',
        'order_items' => 'orderItems',
        'order_item_usage_rules' => 'orderItemUsageRules',
        'order_item_prices' => 'orderItemPrices',
        'awaiting_approval' => 'awaitingApproval',
        'price_list' => 'priceList',
        'order_item_agreement' => 'orderItemAgreement',
        'service_resources' => new List<String>{'serviceResources','GTVAPIServiceResource'},
        'requested_effective_date' => 'requestedEffectiveDate',
        'parent_service' => 'parentService',
        'override_trial_days' => 'overrideTrialDays',
        'operation_attributes' => 'operationAttributes',
        'scheduled_charges' => 'scheduledCharges',
        'scheduled_one_time_price_charges' => 'scheduledOneTimePriceCharges',
        'custom_field_values' => 'customFieldValues',
        'order_item_discounts' => new List<String>{'orderItemDiscounts','GTVAPIOrderItemDiscount'},
        'product' => new List<String>{'product','GTVAPIProductRef'}
        };
*/
    public virtual override Map<String, object> getPropertyMappings() {
      Map<String, object> propertyMappings = new Map<String, object>{
        'order_item_type' => 'orderItemType',
        'granted_value' => 'grantedValue',
        'auto_contribution_amount' => 'autoContributionAmount',
        'auto_contribution_threshold' => 'autoContributionThreshold',
        'auto_contribution_granted_value' => 'autoContributionGrantedValue',
        'order_items' => 'orderItems',
        'order_item_usage_rules' => 'orderItemUsageRules',
        'order_item_prices' => 'orderItemPrices',
        'awaiting_approval' => 'awaitingApproval',
        'price_list' => 'priceList',
        'order_item_agreement' => 'orderItemAgreement',
        'service_resources' => new List<String>{
          'serviceResources',
          'GTVAPIServiceResource'
        },
        'requested_effective_date' => 'requestedEffectiveDate',
        'parent_service' => 'parentService',
        'override_trial_days' => 'overrideTrialDays',
        'operation_attributes' => 'operationAttributes',
        'scheduled_charges' => 'scheduledCharges',
        'scheduled_one_time_price_charges' => 'scheduledOneTimePriceCharges',
        'custom_field_values' => 'customFieldValues',
        'order_item_discounts' => new List<String>{
          'orderItemDiscounts',
          'GTVAPIOrderItemDiscount'
        },
        'product' => new List<String>{ 'product', 'GTVAPIProductRef' }
      };
      return propertyMappings;
    }

    public GTVAPIProductOrderItem() {
      serviceResources = new List<GTVAPIServiceResource>();
      operationAttributes = new List<GTVAPIOperationRunAttributeRef>();
      scheduledCharges = new List<GTVAPIServicePriceChargeRef>();
      scheduledOneTimePriceCharges = new List<GTVAPIServicePriceChargeRef>();
      customFieldValues = new List<GTVAPIServiceCustomFieldValue>();
      orderItemDiscounts = new List<GTVAPIOrderItemDiscount>();
      addresses = new List<GTVAPIPostalAddress>();
    }
  }
  /**
   * models the OrderItemAgeeement object in TRACT
   */
  public class GTVAPIOrderItemAgreement implements GTVAPIRestClient.MappedProperties {
    /**
     * Get agreement
     * @return agreement
     */
    public GTVAPIAgreementRef agreement { get; set; }

    /**
     * Get endDate
     * @return endDate
     */
    public DateTime endDate { get; set; }

    /**
     * Get endAction
     * @return endAction
     */
    public GTVAPIAgreementEndActionType endAction { get; set; }

    /**
     * Get nextAgreement
     * @return nextAgreement
     */
    public GTVAPIAgreementRef nextAgreement { get; set; }

    /**
     * Get nextEndAction
     * @return nextEndAction
     */
    public GTVAPIAgreementNextEndActionType nextEndAction { get; set; }

    /**
     * Get nextServiceProduct
     * @return nextServiceProduct
     */
    public GTVAPIProductRef nextServiceProduct { get; set; }

    /**
     * Get nextServiceProductPrice
     * @return nextServiceProductPrice
     */
    public GTVAPIRecurringProductPriceRef nextServiceProductPrice { get; set; }

    /**
     * Get preserveServicePrice
     * @return preserveServicePrice
     */
    public Boolean preserveServicePrice { get; set; }

    /**
     * Get nextPreserveServicePrice
     * @return nextPreserveServicePrice
     */
    public Boolean nextPreserveServicePrice { get; set; }

    /**
     * Get agreementPeriod
     * @return agreementPeriod
     */
    public Integer agreementPeriod { get; set; }

    /**
     * Get minimumAmount
     * @return minimumAmount
     */
    public Double minimumAmount { get; set; }

    /**
     * Get minimumAmountCurrencyCode
     * @return minimumAmountCurrencyCode
     */
    public GTVAPICurrencyCode minimumAmountCurrencyCode { get; set; }

    /**
     * Get omitMinimumAmount
     * @return omitMinimumAmount
     */
    public Boolean omitMinimumAmount { get; set; }

    /*   private final Map<String, String> propertyMappings = new Map<String, String>{
        'end_date' => 'endDate',
        'end_action' => 'endAction',
        'next_agreement' => 'nextAgreement',
        'next_end_action' => 'nextEndAction',
        'next_service_product' => 'nextServiceProduct',
        'next_service_product_price' => 'nextServiceProductPrice',
        'preserve_service_price' => 'preserveServicePrice',
        'next_preserve_service_price' => 'nextPreserveServicePrice',
        'agreement_period' => 'agreementPeriod',
        'minimum_amount' => 'minimumAmount',
        'minimum_amount_currency_code' => 'minimumAmountCurrencyCode',
        'omit_minimum_amount' => 'omitMinimumAmount'
        };*/

    public Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'end_date' => 'endDate',
        'end_action' => 'endAction',
        'next_agreement' => 'nextAgreement',
        'next_end_action' => 'nextEndAction',
        'next_service_product' => 'nextServiceProduct',
        'next_service_product_price' => 'nextServiceProductPrice',
        'preserve_service_price' => 'preserveServicePrice',
        'next_preserve_service_price' => 'nextPreserveServicePrice',
        'agreement_period' => 'agreementPeriod',
        'minimum_amount' => 'minimumAmount',
        'minimum_amount_currency_code' => 'minimumAmountCurrencyCode',
        'omit_minimum_amount' => 'omitMinimumAmount'
      };
      return propertyMappings;
    }
  }
  /**
   * Gets or Sets AgreementNextEndActionType
   */
  public enum GTVAPIAgreementNextEndActionType {
    RENEW_AGREEMENT,
    SERVICE_ONLY,
    DEACTIVATE_SERVICE,
    CPQ_MANAGED
  }
  /**
   * GTVAPIOperationRunAttributeRef
   */
  public class GTVAPIOperationRunAttributeRef extends GTVAPIEntityRef {
    /**
     * (unique_key) The internal entity id for this entity representation
     * @return id
     */
    public String id { get; set; }
  }
  /**
   * GTVAPIServicePriceChargeRef
   */
  public class GTVAPIServicePriceChargeRef extends GTVAPIScheduledPriceChargeRef implements GTVAPIRestClient.MappedProperties {
    /*private final Map<String, object> propertyMappings = new Map<String, String>{ 
        'scheduled_price_charge_type' => 'scheduledPriceChargeType'
        };
*/
    public override Map<String, object> getPropertyMappings() {
      Map<String, object> propertyMappings = new Map<String, String>{
        'scheduled_price_charge_type' => 'scheduledPriceChargeType'
      };

      return propertyMappings;
    }
  }
  /**
   * GTVAPIOrderItemDiscount
   */
  public class GTVAPIOrderItemDiscount implements GTVAPIRestClient.MappedProperties {
    /**
     * Get discountResource
     * @return discountResource
     */
    public GTVAPIDiscountResourceRef discountResource { get; set; }

    /**
     * Get overrideAmount
     * @return overrideAmount
     */
    public Double overrideAmount { get; set; }

    /**
     * Get overridePercentage
     * @return overridePercentage
     */
    public Double overridePercentage { get; set; }

    /**
     * Get overrideDuration
     * @return overrideDuration
     */
    public Integer overrideDuration { get; set; }

    /*  private final Map<String, String> propertyMappings = new Map<String, String>{
        'discount_resource' => 'discountResource',
        'override_amount' => 'overrideAmount',
        'override_percentage' => 'overridePercentage',
        'override_duration' => 'overrideDuration'
        };
*/
    public Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'discount_resource' => 'discountResource',
        'override_amount' => 'overrideAmount',
        'override_percentage' => 'overridePercentage',
        'override_duration' => 'overrideDuration'
      };

      return propertyMappings;
    }
  }
  /**
   * GTVAPIDiscountResourceRef
   */
  public class GTVAPIDiscountResourceRef extends GTVAPIGenericResourceRef {
    /**
     * (unique_key) The internal entity id for this entity representation
     * @return id
     */
    //public String id { get; set; }

    /**
     * (unique_key)
     * @return identifier
     */
    //public String identifier { get; set; }

    public String resource_type { get; set; }
  }
  /**
   * The parent for a Payment object.
   */
  public virtual class GTVAPIBasePayment extends GTVAPIEntity implements GTVAPIRestClient.MappedProperties {
    /**
     * (unique_key)  The internal entity id for this entity representation
     * @return id
     */
    public String id { get; private set; }

    /**
     * Get paymentType
     * @return paymentType
     */
    public GTVAPIPaymentMethodType paymentType { get; set; }

    /**
     * Get amount
     * @return amount
     */
    public Double amount { get; private set; }

    /**
     * Get description
     * @return description
     */
    public String description { get; private set; }

    /**
     * Get paymentMethod
     * @return paymentMethod
     */
    public GTVAPIPaymentMethod paymentMethod { get; set; }

    /**
     * Get billingAccount
     * @return billingAccount
     */
    public GTVAPIBillingAccountRef billingAccount { get; set; }

    /**
     * Get occurredOn
     * @return occurredOn
     */
    public DateTime occurredOn { get; private set; }

    /**
     * Get authorization
     * @return authorization
     */
    public String authorization { get; private set; }

    /**
     * Get reference
     * @return reference
     */
    public String reference { get; private set; }

    /**
     * Get useRecurringPayment
     * @return useRecurringPayment
     */
    public Boolean useRecurringPayment { get; private set; }

    /**
     * Get unappliedAmount
     * @return unappliedAmount
     */
    public Double unappliedAmount { get; set; }

    /**
     * Get status
     * @return status
     */
    public String status { get; set; }

    /**
     * The IP address
     * @return ipAddress
     */
    public String ipAddress { get; set; }
    /*
        private final Map<String, object> propertyMappings = new Map<String, object>{
        'payment_type' => 'paymentType',
        'payment_method' => 'paymentMethod',
        'billing_account' => new List<String>{'billingAccount','GTVAPIBillingAccountRef'},
        'occurred_on' => 'occurredOn',
        'use_recurring_payment' => 'useRecurringPayment',
        'unapplied_amount' => 'unappliedAmount',
        'ip_address' => 'ipAddress'
        };
*/
    public virtual Map<String, Object> getPropertyMappings() {
      Map<String, object> propertyMappings = new Map<String, object>{
        'payment_type' => 'paymentType',
        'payment_method' => 'paymentMethod',
        'billing_account' => new List<String>{
          'billingAccount',
          'GTVAPIBillingAccountRef'
        },
        'occurred_on' => 'occurredOn',
        'use_recurring_payment' => 'useRecurringPayment',
        'unapplied_amount' => 'unappliedAmount',
        'ip_address' => 'ipAddress'
      };
      return propertyMappings;
    }
  }
  /**
   * Gets or Sets PaymentMethodType
   */
  public enum GTVAPIPaymentMethodType {
    BANK,
    CREDIT_CARD,
    CASH,
    CHECK,
    REFERENCED_CREDIT_CARD,
    PAYPAL,
    PAY_BY_PAYPAL,
    WIRE,
    MOBILE_CARRIER,
    CUSTOM,
    SEPA,
    payment
  }
  /**
   * Gets or Sets PaymentStatus
   */
  public enum GTVAPIPaymentStatus {
    DRAFT,
    PROCESSING,
    COMPLETED,
    VOID1,
    PROCESSING_ERROR,
    MERCHANT_VERIFICATION,
    MERCHANT_VERIFICATION_FAILED,
    CANCELED,
    ALLOCATION_ERROR
  }
  /**
   * GTVAPIRecurringProductPriceRef
   */
  public class GTVAPIRecurringProductPriceRef extends GTVAPIProductPriceRef implements GTVAPIRestClient.MappedProperties {
    /*  private final Map<String, object> propertyMappings = new Map<String, String>{
        'price_type' => 'priceType'
        };
*/
    public override Map<String, object> getPropertyMappings() {
      Map<String, object> propertyMappings = new Map<String, String>{
        'price_type' => 'priceType'
      };

      return propertyMappings;
    }
  }
  /**
   * GTVAPIScheduledPriceChargeRef
   */
  public virtual class GTVAPIScheduledPriceChargeRef extends GTVAPIEntityRef implements GTVAPIRestClient.MappedProperties {
    /**
     * (unique_key) The internal entity id for this entity representation
     * @return id
     */
    public String id { get; set; }

    /**
     * Get scheduledPriceChargeType
     * @return scheduledPriceChargeType
     */
    public GTVAPIPriceChargeType scheduledPriceChargeType { get; set; }
    /**
     * Get scheduledPriceChargeType
     * @return scheduledPriceChargeType
     */
    public String price_charge_type { get; set; }
    /**
     * Get scheduledPriceChargeType
     * @return scheduledPriceChargeType
     */
    public String status { get; set; }
    /**
     * Get scheduledPriceChargeType
     * @return scheduledPriceChargeType
     */
    public String description { get; set; }
    /**
     * Get scheduledPriceChargeType
     * @return scheduledPriceChargeType
     */
    public Decimal amount { get; set; }
    /**
     * Get scheduledPriceChargeType
     * @return scheduledPriceChargeType
     */
    public Boolean invoiced { get; set; }
    /**
     * Get scheduledPriceChargeType
     * @return scheduledPriceChargeType
     */
    public Datetime charge_date { get; set; }

    /*   private final Map<String, object> propertyMappings = new Map<String, String>{
        'scheduled_price_charge_type' => 'scheduledPriceChargeType'
        };*/

    public virtual Map<String, object> getPropertyMappings() {
      Map<String, object> propertyMappings = new Map<String, String>{
        'scheduled_price_charge_type' => 'scheduledPriceChargeType',
        'price_charge_type' => 'price_charge_type',
        'status' => 'status',
        'description' => 'description',
        'amount' => 'amount',
        'invoiced' => 'invoiced',
        'charge_date' => 'charge_date'
      };
      return propertyMappings;
    }
  }
  /**
   * Gets or Sets PriceChargeType
   */
  public enum GTVAPIPriceChargeType {
    ONE_TIME,
    RECURRING
  }
  /**
   * GTVAPIGenericResourceRef
   */
  public virtual class GTVAPIGenericResourceRef extends GTVAPIEntityRef {
    /**
     * (unique_key) The internal entity id for this entity representation
     * @return id
     */
    public String id { get; set; }

    /**
     * (unique_key)
     * @return identifier
     */
    public String identifier { get; set; }
  }

  /**
   * Creates the Billing Account Recurring Payment entity. It supports the following payment methods only - bank (an immediate electronically processed check), credit card, referenced credit card, PayPal, mobile carrier, custom payment method, SEPA Direct Debit, SEPA Direct Debit External Management, Direct Debit, tokenized credit card, or BPAY.
   */
  public class GTVAPICreateRecurringPayment implements GTVAPIRestClient.MappedProperties, GTVAPIRestClient.ReverseMappedProperties {
    /**
     * Get paymentMethod
     * @return paymentMethod
     */
    public GTVAPIPaymentMethod paymentMethod { get; set; }

    /**
     * Specifies whether the default payment method of this billing account is applied.
     * @return autoPayment
     */
    public Boolean autoPayment { get; set; }
    /*
    private final Map<String, String> propertyMappings = new Map<String, String>{
        'payment_method' => 'paymentMethod',
        'auto_payment' => 'autoPayment'
    };
*/
    public Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'payment_method' => 'paymentMethod',
        'auto_payment' => 'autoPayment'
      };
      return propertyMappings;
    }
    public Map<String, Object> getReversePropertyMappings() {
      Map<String, Object> reversePropertyMappings = new Map<String, Object>{
        'paymentMethod' => new List<String>{
          'payment_method',
          'GTVAPIPaymentMethod'
        },
        'autoPayment' => 'auto_payment'
      };
      return reversePropertyMappings;
    }
  }

  /**
   * A reference to the Order Custom Field core entity.
   */
  public class GTVAPIOrderCustomFieldRef extends GTVAPICustomFieldRef implements GTVAPIRestClient.MappedProperties {
    /* private final Map<String, String> propertyMappings = new Map<String, String>{
        'custom_field_type' => 'customFieldType'
    };*/

    public override Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'custom_field_type' => 'customFieldType'
      };
      return propertyMappings;
    }
  }
  /**
   * Indicates the scope type of the product relation.
   */
  public enum GTVAPIProductRelationScopeType {
    ACCOUNT,
    ORDER
  }

  /**
   * Indicates the type of the product relation.
   */
  public enum GTVAPIProductRelationType {
    RECOMMENDED,
    DEPENDENT,
    INCOMPATIBLE,
    CHILD,
    PARENT,
    REQUIRED,
    ADDON
  }
  /**
   * A representation of the core Product Relation entity.
   */
  public class GTVAPIProductRelation extends GTVAPIEntity implements GTVAPIRestClient.MappedProperties {
    /**
     * (unique_key) The ID of the entity.
     * @return id
     */
    public String id { get; private set; }

    /**
     * Get product
     * @return product
     */
    public GTVAPIProductRef product { get; set; }

    /**
     * Get productRelationType
     * @return productRelationType
     */
    public GTVAPIProductRelationType productRelationType { get; set; }

    /**
     * Get scope
     * @return scope
     */
    public GTVAPIProductRelationScopeType scope { get; set; }
    /*
    private final Map<String, String> propertyMappings = new Map<String, String>{
        'product_relation_type' => 'productRelationType'        
    };
*/
    public Map<String, Object> getPropertyMappings() {
      Map<String, Object> propertyMappings = new Map<String, Object>{
        'product_relation_type' => 'productRelationType',
        'product' => new List<String>{ 'product', 'GTVAPIProductRef' }
      };
      return propertyMappings;
    }
  }
  /**
   * A representation of the TRACT One Time Price Charge entity. Order Item One Time Price contains a list of One Time Price Charge entities which collectively create a scheduled charge.
   */
  public class GTVAPIOneTimePriceCharge extends GTVAPIPriceCharge implements GTVAPIRestClient.MappedProperties {
    private final Map<String, String> propertyMappings = new Map<String, String>{
      'price_charge_type' => 'priceChargeType',
      'charge_date' => 'chargeDate'
    };

    public override Map<String, String> getPropertyMappings() {
      return propertyMappings;
    }
  }
  /**
   * Indicates a status of the Price Charge.
   */
  public enum GTVAPIPriceChargeStatus {
    ACTIVE,
    CANCELED
  }

  /**
   * A representation of the TRACT Price Charge entity. Price charges are TRACT\&#39;s representation of the scheduled charges feature.
   */
  public virtual class GTVAPIPriceCharge extends GTVAPIEntity implements GTVAPIRestClient.MappedProperties {
    /**
     * (unique_key) The ID of the entity.
     * @return id
     */
    public String id { get; private set; }

    /**
     * Get priceChargeType
     * @return priceChargeType
     */
    public GTVAPIPriceChargeType priceChargeType { get; set; }

    /**
     * A description of this price charge.
     * @return description
     */
    public String description { get; private set; }

    /**
     * The amount of the charge.
     * @return amount
     */
    public Double amount { get; private set; }

    /**
     * Specifies whether the charge is invoiced.
     * @return invoiced
     */
    public Boolean invoiced { get; private set; }

    /**
     * The date and time for when this charge is scheduled.
     * @return chargeDate
     */
    public Datetime chargeDate { get; private set; }

    /**
     * Get status
     * @return status
     */
    public GTVAPIPriceChargeStatus status { get; set; }

    /*  private final Map<String, String> propertyMappings = new Map<String, String>{
        'price_charge_type' => 'priceChargeType',
        'charge_date' => 'chargeDate'
    };
*/
    public virtual Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'price_charge_type' => 'priceChargeType',
        'charge_date' => 'chargeDate'
      };
      return propertyMappings;
    }
  }
  /**
   * Creates the TRACT One Time Price Charge entity.
   */
  public virtual class GTVAPICreateOneTimePriceCharge extends GTVAPICreatePriceCharge implements GTVAPIRestClient.MappedProperties {
    /*private final Map<String, String> propertyMappings = new Map<String, String>{
        'price_charge_type' => 'priceChargeType',
        'charge_date' => 'chargeDate'
    };*/

    public override Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'price_charge_type' => 'priceChargeType',
        'charge_date' => 'chargeDate'
      };
      return propertyMappings;
    }
  }

  /**
   * Creates the Order Item One Time Price entity.
   */
  public class GTVAPICreateOrderItemOneTimePrice extends GTVAPICreateOrderItemPrice implements GTVAPIRestClient.MappedProperties {
    /**
     * The value granted to a register balance upon purchase of this product.
     * @return grantedValue
     */
    public Double grantedValue { get; set; }

    /**
     * (nullable) The expiration date of granted value.
     * @return grantedValueExpirationDate
     */
    public Datetime grantedValueExpirationDate { get; set; }

    /**
     * The amount to charge for future automatic contributions.
     * @return autoContributionAmount
     */
    public Double autoContributionAmount { get; set; }

    /**
     * The granted value gained when an automatic contribution occurs.
     * @return autoContributionGrantedValue
     */
    public Double autoContributionGrantedValue { get; set; }

    /**
     * The granted value threshold that determines when an automatic contribution occurs.
     * @return autoContributionThreshold
     */
    public Double autoContributionThreshold { get; set; }

    /**
     * Used to schedule a recurring charge on a specific date. These scheduled charges are automatically invoiced to a customer on the defined date.
     * @return scheduledCharges
     */
    public List<GTVAPICreateOneTimePriceCharge> scheduledCharges { get; set; }

    /*private final Map<String, String> propertyMappings = new Map<String, String>{
        'order_item_price_type' => 'orderItemPriceType',
        'taxable_amount' => 'taxableAmount',
        'product_price' => 'productPrice',
        'price_ranges' => 'priceRanges',
        'price_group' => 'priceGroup',
        'granted_value' => 'grantedValue',
        'granted_value_expiration_date' => 'grantedValueExpirationDate',
        'auto_contribution_amount' => 'autoContributionAmount',
        'auto_contribution_granted_value' => 'autoContributionGrantedValue',
        'auto_contribution_threshold' => 'autoContributionThreshold',
        'scheduled_charges' => 'scheduledCharges'
    };
*/
    public override Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'order_item_price_type' => 'orderItemPriceType',
        'taxable_amount' => 'taxableAmount',
        'product_price' => 'productPrice',
        'price_ranges' => 'priceRanges',
        'price_group' => 'priceGroup',
        'granted_value' => 'grantedValue',
        'granted_value_expiration_date' => 'grantedValueExpirationDate',
        'auto_contribution_amount' => 'autoContributionAmount',
        'auto_contribution_granted_value' => 'autoContributionGrantedValue',
        'auto_contribution_threshold' => 'autoContributionThreshold',
        'scheduled_charges' => 'scheduledCharges'
      };
      return propertyMappings;
    }

    public GTVAPICreateOrderItemOneTimePrice() {
      scheduledCharges = new List<GTVAPICreateOneTimePriceCharge>();
    }
  }

  /**
   * A representation of the core Order Item One Time Price entity. It stands for one-time prices. Also, it may contain a list of OneTimePriceCharge entities which collectively create a scheduled charge.
   */
  public class GTVAPIOrderItemOneTimePrice extends GTVAPIOrderItemPrice implements GTVAPIRestClient.MappedProperties {
    /**
     * The value granted to a register balance upon purchase of this product.
     * @return grantedValue
     */
    public Double grantedValue { get; private set; }

    /**
     * (nullable) The expiration date of granted value.
     * @return grantedValueExpirationDate
     */
    public Datetime grantedValueExpirationDate { get; set; }

    /**
     * Specifies whether the automatic contribution fields can be overridden.
     * @return autoContributionOverride
     */
    public Boolean autoContributionOverride { get; private set; }

    /**
     * The amount to charge for future automatic contributions.
     * @return autoContributionAmount
     */
    public Double autoContributionAmount { get; private set; }

    /**
     * The granted value gained when an automatic contribution occurs.
     * @return autoContributionGrantedValue
     */
    public Double autoContributionGrantedValue { get; private set; }

    /**
     * The granted value threshold that determines when an automatic contribution occurs.
     * @return autoContributionThreshold
     */
    public Double autoContributionThreshold { get; private set; }

    /**
     * Used to schedule a recurring charge on a specific date. These scheduled charges are automatically invoiced to a customer on the defined date.
     * @return scheduledCharges
     */
    public List<GTVAPIOneTimePriceCharge> scheduledCharges { get; set; }

    private final Map<String, String> propertyMappings = new Map<String, String>{
      'price_type' => 'priceType',
      'currency_code' => 'currencyCode',
      'order_item_price_type' => 'orderItemPriceType',
      'taxable_amount' => 'taxableAmount',
      'price_override' => 'priceOverride',
      'product_price' => 'productPrice',
      'price_ranges' => 'priceRanges',
      'price_group' => 'priceGroup',
      'granted_value' => 'grantedValue',
      'granted_value_expiration_date' => 'grantedValueExpirationDate',
      'auto_contribution_override' => 'autoContributionOverride',
      'auto_contribution_amount' => 'autoContributionAmount',
      'auto_contribution_granted_value' => 'autoContributionGrantedValue',
      'auto_contribution_threshold' => 'autoContributionThreshold',
      'scheduled_charges' => 'scheduledCharges'
    };

    public override Map<String, Object> getPropertyMappings() {
      return propertyMappings;
    }

    public GTVAPIOrderItemOneTimePrice() {
      scheduledCharges = new List<GTVAPIOneTimePriceCharge>();
    }
  }

  /**
   * Creates a new order custom field value.
   */
  public class GTVAPICreateOrderCustomFieldValue extends GTVAPICreateCustomFieldValue implements GTVAPIRestClient.MappedProperties {
    /**
     * Get customField
     * @return customField
     */
    public GTVAPIOrderCustomFieldRef custom_field { get; set; }
    /*
    private final Map<String, String> propertyMappings = new Map<String, String>{
        'custom_field_value_type' => 'customFieldValueType',
        'custom_field' => 'customField'
    };
*/
    public override Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'custom_field_value_type' => 'customFieldValueType',
        'custom_field' => 'custom_field'
      };
      return propertyMappings;
    }
  }
  /**
   * Indicates the status of the sales order that is being created.
   */
  public enum GTVAPICreateSalesOrderStatus {
    DRAFT,
    CONFIRMED
  }
  /**
   * Creates the Sales Order entity.
   */
  public class GTVAPICreateSalesOrder implements GTVAPIRestClient.MappedProperties, GTVAPIRestClient.ReverseMappedProperties {
    /**
     * The order number generated by Gotransverse core.
     * @return orderNum
     */
    public String orderNum { get; set; }

    /**
     * A list of order items.
     * @return orderItems
     */
    public List<GTVAPICreateProductOrderItem> orderItems { get; set; }

    /**
     * Get payment
     * @return payment
     */
    public GTVAPICreatePayment payment { get; set; }

    /**
     * A note on this order, if applicable.
     * @return note
     */
    public String note { get; set; }

    /**
     * The PO number associated with the order, if applicable.
     * @return purchaseOrderNumber
     */
    public String purchaseOrderNumber { get; set; }

    /**
     * Specifies whether the receipt is sent via email.
     * @return emailReceipt
     */
    public Boolean emailReceipt { get; set; }

    /**
     * The referrer of the order, if applicable.
     * @return referral
     */
    public String referral { get; set; }

    /**
     * The date and time when the order was created.
     * @return orderDate
     */
    public String orderDate { get; set; }

    /**
     * A list of custom field values associated with this order.
     * @return customFieldValues
     */
    public List<GTVAPICreateOrderCustomFieldValue> customFieldValues {
      get;
      set;
    }

    /**
     * Get initialStatus
     * @return initialStatus
     */
    public GTVAPICreateSalesOrderStatus initialStatus { get; set; }

    /**
     * This current CPQ driven discounts applicable. These are different the Resource driven discounts. Gotransverse core does not directly use these, but relies on the CPQ engine to use them.
     * @return cpqDiscounts
     */
    public List<GTVAPICreateCpqDiscount> cpqDiscounts { get; set; }

    /*   private final Map<String, String> propertyMappings = new Map<String, String>{
        'order_num' => 'orderNum',
        'order_items' => 'orderItems',
        'purchase_order_number' => 'purchaseOrderNumber',
        'email_receipt' => 'emailReceipt',
        'order_date' => 'orderDate',
        'custom_field_values' => 'customFieldValues',
        'initial_status' => 'initialStatus',
        'cpq_discounts' => 'cpqDiscounts'
    };
     private final Map<String, String> reversePropertyMappings = new Map<String, String>{
        'orderNum' => 'order_num',
        'orderItems' => 'order_items',
        'purchaseOrderNumber' => 'purchase_order_number',
        'emailReceipt' => 'email_receipt',
        'orderDate' => 'order_date',
        'customFieldValues' => 'custom_field_values',
        'initialStatus' => 'initial_status',
        'cpqDiscounts' => 'cpq_discounts'
    };
*/
    public Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'order_num' => 'orderNum',
        'order_items' => 'orderItems',
        'purchase_order_number' => 'purchaseOrderNumber',
        'email_receipt' => 'emailReceipt',
        'order_date' => 'orderDate',
        'custom_field_values' => 'customFieldValues',
        'initial_status' => 'initialStatus',
        'cpq_discounts' => 'cpqDiscounts'
      };
      return propertyMappings;
    }
    public Map<String, object> getReversePropertyMappings() {
      Map<String, object> reversePropertyMappings = new Map<String, object>{
        'orderNum' => 'order_num',
        'orderItems' => 'order_items',
        'purchaseOrderNumber' => 'purchase_order_number',
        'emailReceipt' => 'email_receipt',
        'orderDate' => 'order_date',
        'customFieldValues' => 'custom_field_values',
        'initialStatus' => 'initial_status',
        'cpqDiscounts' => 'cpq_discounts',
        'productUsageRules' => 'product_usage_rules',
        'usageRuleType' => 'usage_rule_type',
        'allowanceAmount' => 'allowance_amount',
        'allowanceUom' => 'allowance_uom',
        'allowanceType' => 'allowance_type',
        'ruleOrder' => 'rule_order',
        'proratedOnOrder' => 'prorated_on_order',
        'proratedOnCancel' => 'prorated_on_cancel',
        'rollOverType' => 'roll_over_type',
        'validFrom' => 'valid_from',
        'validTo' => 'valid_to',
        'ruleType' => 'rule_type',
        'usageRate' => 'usage_rate',
        'rateType' => 'rate_type',
        'productType' => 'product_type',
        'parentService' => 'parent_service',
        'usageRuleSpecificationType' => 'usage_rule_specification_type',
        'chargeCategory' => 'charge_category',
        'chargeCategoryType' => 'charge_category_type',
        'scheduled_charges' => 'scheduled_charges',
        'priceChargeType' => 'price_charge_type',
        'chargeDate' => 'charge_date',
        'orderItemDiscount' => new List<String>{
          'order_item_discount',
          'GTVAPICreateOrderItemDiscount'
        },
        'order_item_agreement' => new List<String>{
          'order_item_agreement',
          'GTVAPICreateOrderItemAgreement'
        },
        'priceList' => 'price_list'
      };
      return reversePropertyMappings;
    }

    public GTVAPICreateSalesOrder() {
      orderItems = new List<GTVAPICreateProductOrderItem>();
      customFieldValues = new List<GTVAPICreateOrderCustomFieldValue>();
      cpqDiscounts = new List<GTVAPICreateCpqDiscount>();
    }
  }

  /**
   * A representation of a TRACT billing account
   */
  public class GTVAPICreateBillingAccount implements GTVAPIRestClient.MappedProperties, GTVAPIRestClient.ReverseMappedProperties {
    /**
     * (unique_key) The TRACT account number
     * @return accountNum
     */
    public String accountNum { get; set; }

    /**
     * (unique_key) An account number for this account tied to an external system
     * @return external_account_num
     */
    public String external_account_num { get; set; }

    /**
     * Get bill_cycle
     * @return bill_cycle
     */
    public GTVAPIBillCycleRef bill_cycle { get; set; }

    /**
     * Get responsible_party
     * @return responsible_party
     */
    public GTVAPICreateParty responsible_party { get; set; }

    /**
     * Get billing_account_category
     * @return billing_account_category
     */
    public GTVAPIBillingAccountCategoryRef billing_account_category {
      get;
      set;
    }

    /**
     * Get bill_type
     * @return bill_type
     */
    public String bill_type { get; set; }

    /**
     * Is the recurring payment used automatically
     * @return autoPaymentAuthorized
     */
    public Boolean autoPaymentAuthorized { get; set; }

    /**
     * Get currencyCode
     * @return currencyCode
     */
    public String currencyCode { get; set; }

    /**
     * Get recurringPayment
     * @return recurringPayment
     */
    public GTVAPICreateRecurringPayment recurringPayment { get; set; }

    /**
     * Get custom_field_values
     * @return custom_field_values
     */
    public List<GTVAPICreateBillingAccountCustomFi> custom_field_values {
      get;
      set;
    }

    /**
     * Get contacts
     * @return contacts
     */
    public List<GTVAPIPerson> contacts { get; set; }

    /**
     * Get payment_term
     * @return payment_term
     */
    public GTVAPIPaymentTermRef payment_term { get; set; }

    /**
     * Get startDate
     * @return startDate
     */
    public String start_date { get; set; }

    /**
     * Get endDate
     * @return endDate
     */
    public DateTime endDate { get; set; }

    /**
     * tax exempt
     * @return taxExempt
     */
    public Boolean tax_exempt { get; set; }

    /**
     * Get salesOrder
     * @return salesOrder
     */

    public GTVAPICreateSalesOrder salesOrder { get; set; }

    /* private final Map<String, String> propertyMappings = new Map<String, String>{
        'account_num' => 'accountNum',
        'external_account_num' => 'external_account_num',
        'bill_cycle' => 'bill_cycle',
        'responsible_party' => 'responsible_party',
        'billing_account_category' => 'billing_account_category',
        'bill_type' => 'bill_type',
        'auto_payment_authorized' => 'autoPaymentAuthorized',
        'currency_code' => 'currencyCode',
        'recurring_payment' => 'recurringPayment',
        'custom_field_values' => 'custom_field_values',
        'payment_term' => 'payment_term',
        'start_date' => 'startDate',
        'end_date' => 'endDate',
        'tax_exempt' => 'taxExempt',
          'sales_order' => 'salesOrder'
        };*/

    public Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'account_num' => 'accountNum',
        'external_account_num' => 'external_account_num',
        'bill_cycle' => 'bill_cycle',
        'responsible_party' => 'responsible_party',
        'billing_account_category' => 'billing_account_category',
        'bill_type' => 'bill_type',
        'auto_payment_authorized' => 'autoPaymentAuthorized',
        'currency_code' => 'currencyCode',
        'recurring_payment' => 'recurringPayment',
        'custom_field_values' => 'custom_field_values',
        'payment_term' => 'payment_term',
        'start_date' => 'startDate',
        'end_date' => 'endDate',
        'tax_exempt' => 'taxExempt',
        'sales_order' => 'salesOrder'
      };
      return propertyMappings;
    }

    public Map<String, String> getReversePropertyMappings() {
      Map<String, String> reversePropertyMappings = new Map<String, String>{
        'currencyCode' => 'currency_code',
        'r_number' => 'number'
      };
      return reversePropertyMappings;
    }

    public GTVAPICreateBillingAccount() {
      autoPaymentAuthorized = false;
      custom_field_values = new List<GTVAPICreateBillingAccountCustomFi>();
      contacts = new List<GTVAPIPerson>();
    }
  }
  /**
   * A representation of a TRACT bill cycle
   */
  public class GTVAPIBillCycleRef extends GTVAPIEntityRef implements GTVAPIRestClient.MappedProperties {
    /**
     * (unique_key) The internal entity id for this entity representation
     * @return id
     */
    public String id { get; set; }

    /**
     * Get bill_cycle_type
     * @return bill_cycle_type
     */
    public String bill_cycle_type { get; set; }

    /**
     * (unique_key)
     * @return name
     */
    public String name { get; private set; }

    /* private final Map<String, Object> propertyMappings = new Map<String, Object>{
        'bill_cycle_type' => 'bill_cycle_type'
        };
*/
    public Map<String, Object> getPropertyMappings() {
      Map<String, Object> propertyMappings = new Map<String, Object>{
        'bill_cycle_type' => 'bill_cycle_type'
      };
      return propertyMappings;
    }
  }
  /**
   * A representation of a TRACT party - person or organization
   */
  public class GTVAPICreateParty implements GTVAPIRestClient.MappedProperties {
    /**
     * Get party_type
     * @return party_type
     */
    public GTVAPIPartyType party_type { get; set; }

    /**
     * Get taxIdNumber
     * @return taxIdNumber
     */
    public String taxIdNumber { get; set; }

    /**
     * Get addresses
     * @return addresses
     */
    public List<GTVAPICreateAddress> addresses { get; set; }

    public String organization_name { get; set; }

    /*  private final Map<String, String> propertyMappings = new Map<String, String>{
        'party_type' => 'party_type',
        'tax_id_number' => 'taxIdNumber'
        };*/

    public Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'party_type' => 'party_type',
        'tax_id_number' => 'taxIdNumber'
      };
      return propertyMappings;
    }

    public GTVAPICreateParty() {
      addresses = new List<GTVAPICreateAddress>();
    }
  }
  /**
   * A representation of a TRACT address
   */
  public virtual class GTVAPICreateAddress implements GTVAPIRestClient.MappedProperties {
    /**
     * Get address_type
     * @return address_type
     */
    public GTVAPIAddressType address_type { get; set; }

    public AddresssPurpose purpose { get; set; }

    /**
     * Get country
     * @return country
     */
    public String country { get; set; }

    /**
     * Get city
     * @return city
     */
    public String city { get; set; }

    /**
     * Get regionOrState
     * @return regionOrState
     */
    public String region_or_state { get; set; }

    /**
     * Get attention
     * @return attention
     */
    public String attention { get; set; }

    /**
     * Get postalCode
     * @return postalCode
     */
    public String postal_code { get; set; }

    /**
     * Get line1
     * @return line1
     */
    public String line1 { get; set; }

    /**
     * Get line2
     * @return line2
     */
    public String line2 { get; set; }

    /**
     * Get pCode
     * @return pCode
     */
    public Integer pCode { get; set; }

    /**
     * Get pCodeOverridden
     * @return pCodeOverridden
     */
    public Boolean pCodeOverridden { get; set; }

    /**
     * Get email
     * @return email
     */
    public String email { get; set; }

    /**
     * Get dialingPrefix
     * @return dialingPrefix
     */
    public String dialingPrefix { get; set; }

    /**
     * Get countryCode
     * @return countryCode
     */
    public String countryCode { get; set; }

    /**
     * Get areaCode
     * @return areaCode
     */
    public String areaCode { get; set; }

    /**
     * Get r_number
     * @return r_number
     */
    public String r_number { get; set; }

    /**
     * Get extension
     * @return extension
     */
    public String extension { get; set; }

    /*   private final Map<String, String> propertyMappings = new Map<String, String>{
        'address_type' => 'address_type'
        };
*/
    public virtual Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'address_type' => 'address_type'
      };

      return propertyMappings;
    }
  }
  /**
   * The account category for this account. Account categories are used for segmentation purposes and can be used to drive logic and behaviour throughout TRACT
   */
  public class GTVAPIBillingAccountCategoryRef extends GTVAPIEntityRef {
    /**
     * (unique_key) The internal entity id for this entity representation
     * @return id
     */
    public String id { get; set; }
  }
  /**
   * GTVAPICreateBillingAccountCustomFi
   */
  public class GTVAPICreateBillingAccountCustomFi extends GTVAPICreateCustomFieldValue implements GTVAPIRestClient.MappedProperties, GTVAPIRestClient.ReverseMappedProperties {
    /* private final Map<String, String> propertyMappings = new Map<String, String>{
        'custom_field_value_type' => 'customFieldValueType',
        'custom_field' => 'customField'
        };
        private final Map<String, String> reversePropertyMappings = new Map<String, String>{
        'customFieldValueType' => 'custom_field_value_type',
        'customField' => 'custom_field'
        };
*/
    public override Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'custom_field_value_type' => 'customFieldValueType',
        'custom_field' => 'customField'
      };
      return propertyMappings;
    }
    public Map<String, String> getReversePropertyMappings() {
      Map<String, String> reversePropertyMappings = new Map<String, String>{
        'customFieldValueType' => 'custom_field_value_type',
        'customField' => 'custom_field'
      };
      return reversePropertyMappings;
    }
  }
  /**
   * GTVAPICreateCustomFieldValue
   */
  public virtual class GTVAPICreateCustomFieldValue implements GTVAPIRestClient.MappedProperties {
    /**
     * Get custom_field_value_type
     * @return custom_field_value_type
     */
    public String custom_field_value_type { get; set; }

    /**
     * The custom field value.
     * @return value
     */
    public String value { get; set; }

    /**
     * Get custom_field
     * @return custom_field
     */
    public GTVAPICustomFieldRef custom_field { get; set; }

    /*  private final Map<String, String> propertyMappings = new Map<String, String>{
        'custom_field_value_type' => 'custom_field_value_type',
        'custom_field' => 'custom_field'
        };
*/
    public virtual Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'custom_field_value_type' => 'custom_field_value_type',
        'custom_field' => 'custom_field'
      };
      return propertyMappings;
    }
  }
  /**
   * A representation of a TRACT SegmentedMonthly Bill Cycle entity
   */
  public class GTVAPIPaymentTermRef extends GTVAPIEntityRef {
    /**
     * (unique_key) The internal entity id for this entity representation
     * @return id
     */
    public String id { get; set; }

    /**
     * (unique_key) The TRACT payment-term name
     * @return name
     */
    public String name { get; set; }
  }
  /**
   * A payment object to create
   */
  public class GTVAPICreatePayment extends GTVAPICreatePaymentOrRefund implements GTVAPIRestClient.MappedProperties, GTVAPIRestClient.ReverseMappedProperties {
    /**
     * Get paymentMethod
     * @return paymentMethod
     */
    public GTVAPICreatePaymentMethod paymentMethod { get; set; }

    /**
     * Date the payment occurs on
     * @return occursOn
     */
    public DateTime occursOn { get; set; }

    /**
     * Date the payment occurs on
     * @return receivedAmount
     */
    public Double receivedAmount { get; set; }
    /**
     * description of the payment
     * @return description
     */
    /*public String description { get; set; }

        *
         * Get receivedCurrencyCode
         * @return receivedCurrencyCode
         */
    public GTVAPICurrencyCode receivedCurrencyCode { get; set; }

    /**
     * Date the payment occurs on
     * @return applyAutomatically
     */
    public Boolean applyAutomatically { get; set; }

    /**
     * Date the payment occurs on
     * @return useRecurringPayment
     */
    public Boolean useRecurringPayment { get; set; }

    /* private final Map<String, String> propertyMappings = new Map<String, String>{
        'payment_type' => 'paymentType',
        'ip_address' => 'ipAddress',
        'payment_method' => 'paymentMethod',
        'occurs_on' => 'occursOn',
        'received_amount' => 'receivedAmount',
        'received_currency_code' => 'receivedCurrencyCode',   
        'apply_automatically' => 'applyAutomatically',
        'use_recurring_payment' => 'useRecurringPayment'
        };*/

    public override Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'payment_type' => 'paymentType',
        'ip_address' => 'ipAddress',
        'payment_method' => 'paymentMethod',
        'occurs_on' => 'occursOn',
        'received_amount' => 'receivedAmount',
        'received_currency_code' => 'receivedCurrencyCode',
        'apply_automatically' => 'applyAutomatically',
        'use_recurring_payment' => 'useRecurringPayment'
      };

      return propertyMappings;
    }
    public override Map<String, Object> getReversePropertyMappings() {
      Map<String, Object> reversePropertyMappings = new Map<String, Object>{
        'paymentType' => 'payment_type',
        'paymentMethod' => 'recurring_payment',
        'receivedAmount' => 'amount',
        'description' => 'description'
      };

      return reversePropertyMappings;
    }
  }

  /**
   * Gets or Sets CreatePaymentMethodType
   */
  public enum GTVAPICreatePaymentMethodType {
    BANK,
    CREDIT_CARD,
    CASH,
    CHECK,
    REFERENCED_CREDIT_CARD,
    PAYPAL,
    PAY_BY_PAYPAL,
    WIRE,
    MOBILE_CARRIER,
    CUSTOM
  }
  /**
   * GTVAPICreatePaymentMethodCustomFie
   */
  public class GTVAPICreatePaymentMethodCustomFie extends GTVAPICreateCustomFieldValue implements GTVAPIRestClient.MappedProperties {
    /*   private final Map<String, String> propertyMappings = new Map<String, String>{
        'custom_field_value_type' => 'customFieldValueType',
        'custom_field' => 'customField'
        };
*/
    public override Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'custom_field_value_type' => 'customFieldValueType',
        'custom_field' => 'customField'
      };
      return propertyMappings;
    }
  }
  /**
   * Base class for all create payment or  refund
   */
  public virtual class GTVAPICreatePaymentOrRefund implements GTVAPIRestClient.MappedProperties, GTVAPIRestClient.ReverseMappedProperties {
    /**
     * Get paymentType
     * @return paymentType
     */
    public GTVAPIPaymentType paymentType { get; set; }

    /**
     * The payment or refund amount
     * @return amount
     */
    public Double amount { get; set; }

    /**
     * Description of payment or refund
     * @return description
     */
    public String description { get; set; }

    /**
     * blah
     * @return ipAddress
     */
    public String ipAddress { get; set; }

    /**
     * blah
     * @return authorization
     */
    public String authorization { get; set; }

    /* private final Map<String, String> propertyMappings = new Map<String, String>{
        'payment_type' => 'paymentType',
        'ip_address' => 'ipAddress'
        };
*/
    public virtual Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'payment_type' => 'paymentType',
        'ip_address' => 'ipAddress'
      };
      return propertyMappings;
    }

    public virtual Map<String, Object> getReversePropertyMappings() {
      Map<String, Object> reversePropertyMappings = new Map<String, Object>{
        'paymentType' => 'payment_type',
        'paymentMethod' => 'recurring_payment',
        'receivedAmount' => 'amount',
        'description' => 'description'
      };

      return reversePropertyMappings;
    }
  }
  /**
   * Gets or Sets PaymentType
   */
  public enum GTVAPIPaymentType {
    payment,
    REFUND
  }
  /**
   * GTVAPIPaymentApplication
   */
  public class GTVAPIPaymentApplication extends GTVAPIEntity implements GTVAPIRestClient.MappedProperties {
    /**
     * (unique_key)  The internal entity id for this entity representation
     * @return id
     */
    public String id { get; private set; }

    /**
     * Get payment
     * @return payment
     */
    public GTVAPIPayment payment { get; set; }

    /**
     * Get updatedOn
     * @return updatedOn
     */
    public DateTime updatedOn { get; set; }

    /**
     * Get amount
     * @return amount
     */
    public Double amount { get; set; }

    /**
     * Get invoice
     * @return invoice
     */
    public GTVAPInvoiceRef invoice { get; set; }

    /**
     * Get paymentApplicationType
     * @return paymentApplicationType
     */
    public String paymentApplicationType { get; set; }

    /*  private final Map<String, Object> propertyMappings = new Map<String, Object>{
        'updated_on' => 'updatedOn',
        'payment_application_type' => 'paymentApplicationType',
        'invoice' => new List<String>{'invoice','GTVAPInvoiceRef'},
        'payment' => new List<String>{'payment','GTVAPIPayment'}
        };
*/
    public Map<String, Object> getPropertyMappings() {
      Map<String, Object> propertyMappings = new Map<String, Object>{
        'updated_on' => 'updatedOn',
        'payment_application_type' => 'paymentApplicationType',
        'invoice' => new List<String>{ 'invoice', 'GTVAPInvoiceRef' },
        'payment' => new List<String>{ 'payment', 'GTVAPIPayment' }
      };
      return propertyMappings;
    }
  }
  /**
   * Gets or Sets PaymentApplicationType
   */
  public enum GTVAPIPaymentApplicationType {
    STANDARD_INVOICE,
    REVERSED_INVOICE
  }
  /**
   * GTVAPInvoiceRef
   */
  public class GTVAPInvoiceRef extends GTVAPIEntityRef implements GTVAPIRestClient.MappedProperties {
    /**
     * (unique_key) The internal entity id for this entity representation
     * @return id
     */
    public String id { get; set; }

    /**
     * (unique-key) description
     * @return invoiceNum
     */
    public String invoiceNum { get; set; }

    /**
     * Get billingStatement
     * @return billingStatement
     */
    public GTVAPIBillingStatement billingStatement { get; set; }

    /**
     * Get billCycle
     * @return billCycle
     */
    public GTVAPIBillCycleRef billCycle { get; set; }

    /**
     * Get invoiceItems
     * @return invoiceItems
     */
    public List<GTVAPInvoiceItem> invoiceItems { get; set; }
    /*
        private final Map<String, Object> propertyMappings = new Map<String, Object>{
        'invoice_num' => 'invoiceNum',
        'billing_statement' => 'billingStatement',
        'bill_cycle' => new List<String>{'billCycle','GTVAPIBillCycleRef'},
        'invoice_items' => new List<String>{'invoiceItems','GTVAPInvoiceItem'}
        };
*/
    public Map<String, Object> getPropertyMappings() {
      Map<String, Object> propertyMappings = new Map<String, Object>{
        'invoice_num' => 'invoiceNum',
        'billing_statement' => 'billingStatement',
        'bill_cycle' => new List<String>{ 'billCycle', 'GTVAPIBillCycleRef' },
        'invoice_items' => new List<String>{
          'invoiceItems',
          'GTVAPInvoiceItem'
        }
      };
      return propertyMappings;
    }

    public GTVAPInvoiceRef() {
      invoiceItems = new List<GTVAPInvoiceItem>();
    }
  }
  /**
   * GTVAPIBillingStatement
   */
  public class GTVAPIBillingStatement extends GTVAPIEntity implements GTVAPIRestClient.MappedProperties {
    /**
     * (unique_key)  The internal entity id for this entity representation
     * @return id
     */
    public String id { get; private set; }

    /**
     * Get totalAmount
     * @return totalAmount
     */
    public Double totalAmount { get; set; }

    /**
     * Get balance
     * @return balance
     */
    public Double balance { get; set; }

    /**
     * Get serviceCharges
     * @return serviceCharges
     */
    public Double serviceCharges { get; set; }

    /**
     * Get activityCharges
     * @return activityCharges
     */
    public Double activityCharges { get; set; }

    /**
     * Get otherChargesAndCredits
     * @return otherChargesAndCredits
     */
    public Double otherChargesAndCredits { get; set; }

    /**
     * Get taxesAndFees
     * @return taxesAndFees
     */
    public Double taxesAndFees { get; set; }

    /**
     * Get totalCurrentCharges
     * @return totalCurrentCharges
     */
    public Double totalCurrentCharges { get; set; }

    /**
     * Get paymentsReceivedAmount
     * @return paymentsReceivedAmount
     */
    public Double paymentsReceivedAmount { get; set; }

    /**
     * Get paymentsCanceledAmount
     * @return paymentsCanceledAmount
     */
    public Double paymentsCanceledAmount { get; set; }

    /**
     * Get creditAdjustmentsPostedAmount
     * @return creditAdjustmentsPostedAmount
     */
    public Double creditAdjustmentsPostedAmount { get; set; }

    /**
     * Get creditAdjustmentsWriteOffAmount
     * @return creditAdjustmentsWriteOffAmount
     */
    public Double creditAdjustmentsWriteOffAmount { get; set; }

    /* private final Map<String, String> propertyMappings = new Map<String, String>{
        'total_amount' => 'totalAmount',
        'service_charges' => 'serviceCharges',
        'activity_charges' => 'activityCharges',
        'other_charges_and_credits' => 'otherChargesAndCredits',
        'taxes_and_fees' => 'taxesAndFees',
        'total_current_charges' => 'totalCurrentCharges',
        'payments_received_amount' => 'paymentsReceivedAmount',
        'payments_canceled_amount' => 'paymentsCanceledAmount',
        'credit_adjustments_posted_amount' => 'creditAdjustmentsPostedAmount',
        'credit_adjustments_write_off_amount' => 'creditAdjustmentsWriteOffAmount'
        };*/

    public Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'total_amount' => 'totalAmount',
        'service_charges' => 'serviceCharges',
        'activity_charges' => 'activityCharges',
        'other_charges_and_credits' => 'otherChargesAndCredits',
        'taxes_and_fees' => 'taxesAndFees',
        'total_current_charges' => 'totalCurrentCharges',
        'payments_received_amount' => 'paymentsReceivedAmount',
        'payments_canceled_amount' => 'paymentsCanceledAmount',
        'credit_adjustments_posted_amount' => 'creditAdjustmentsPostedAmount',
        'credit_adjustments_write_off_amount' => 'creditAdjustmentsWriteOffAmount'
      };
      return propertyMappings;
    }
  }
  /**
   * GTVAPInvoiceItem
   */
  public class GTVAPInvoiceItem extends GTVAPIEntity implements GTVAPIRestClient.MappedProperties {
    /**
     * (unique_key)  The internal entity id for this entity representation
     * @return id
     */
    public String id { get; private set; }

    /**
     * Get invoiceItemType
     * @return invoiceItemType
     */
    public GTVAPInvoiceItemType invoiceItemType { get; set; }

    /**
     * Get quantity
     * @return quantity
     */
    public Double quantity { get; set; }

    /**
     * Get unitAmount
     * @return unitAmount
     */
    public Double unitAmount { get; set; }

    /**
     * Get totalAmount
     * @return totalAmount
     */
    public Double totalAmount { get; set; }

    /**
     * Get description
     * @return description
     */
    public String description { get; set; }

    /**
     * Get taxable
     * @return taxable
     */
    public Boolean taxable { get; set; }

    /**
     * Get proratedPercentage
     * @return proratedPercentage
     */
    public Double proratedPercentage { get; set; }

    /**
     * Get startDate
     * @return startDate
     */
    public DateTime startDate { get; set; }

    /**
     * Get endDate
     * @return endDate
     */
    public DateTime endDate { get; set; }

    /**
     * Get lineItemType
     * @return lineItemType
     */
    public String lineItemType { get; set; }

    /**
     * Get invoiceItemCharges
     * @return invoiceItemCharges
     */
    public List<GTVAPInvoiceItemCharge> invoiceItemCharges { get; set; }

    /* private final Map<String, String> propertyMappings = new Map<String, String>{
        'invoice_item_type' => 'invoiceItemType',
        'unit_amount' => 'unitAmount',
        'total_amount' => 'totalAmount',
        'prorated_percentage' => 'proratedPercentage',
        'start_date' => 'startDate',
        'end_date' => 'endDate',
        'line_item_type' => 'lineItemType',
        'invoice_item_charges' => 'invoiceItemCharges'
        };
*/
    public Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'invoice_item_type' => 'invoiceItemType',
        'unit_amount' => 'unitAmount',
        'total_amount' => 'totalAmount',
        'prorated_percentage' => 'proratedPercentage',
        'start_date' => 'startDate',
        'end_date' => 'endDate',
        'line_item_type' => 'lineItemType',
        'invoice_item_charges' => 'invoiceItemCharges'
      };
      return propertyMappings;
    }

    public GTVAPInvoiceItem() {
      invoiceItemCharges = new List<GTVAPInvoiceItemCharge>();
    }
  }
  /**
   * Gets or Sets InvoiceItemType
   */
  public enum GTVAPInvoiceItemType {
    ADDIITIONAL_FEE,
    ADJUSTMENT,
    PRODUCT,
    SERVICE,
    TAX,
    USAGE
  }
  /**
   * GTVAPInvoiceItemCharge
   */
  public class GTVAPInvoiceItemCharge extends GTVAPIEntity implements GTVAPIRestClient.MappedProperties {
    /**
     * (unique_key)  The internal entity id for this entity representation
     * @return id
     */
    public String id { get; private set; }

    /**
     * Get invoiceItemChargeType
     * @return invoiceItemChargeType
     */
    public GTVAPInvoiceItemChargeType invoiceItemChargeType { get; set; }

    /**
     * Un prorated amount
     * @return unProratedAmount
     */
    public Double unProratedAmount { get; set; }

    /**
     * desc
     * @return amount
     */
    public Double amount { get; set; }

    /**
     * Get priceCategory
     * @return priceCategory
     */
    public GTVAPIChargeCategory priceCategory { get; set; }

    /**
     * desc
     * @return balance
     */
    public Double balance { get; set; }

    /**
     * desc
     * @return paid
     */
    public Boolean paid { get; set; }

    /**
     * desc
     * @return recurringCharge
     */
    public Boolean recurringCharge { get; set; }

    /**
     * desc
     * @return billInAdvance
     */
    public Boolean billInAdvance { get; set; }

    /**
     * desc
     * @return taxDescription
     */
    public String taxDescription { get; set; }

    /**
     * desc
     * @return description
     */
    public String description { get; set; }

    /**
     * desc
     * @return quantity
     */
    public Double quantity { get; set; }

    /**
     * desc
     * @return taxIdentifier
     */
    public String taxIdentifier { get; set; }

    /**
     * desc
     * @return taxPosted
     */
    public Boolean taxPosted { get; set; }

    /*  private final Map<String, String> propertyMappings = new Map<String, String>{
        'invoice_item_charge_type' => 'invoiceItemChargeType',
        'un_prorated_amount' => 'unProratedAmount',
        'price_category' => 'priceCategory',
        'recurring_charge' => 'recurringCharge',
        'bill_in_advance' => 'billInAdvance',
        'tax_description' => 'taxDescription',
        'tax_identifier' => 'taxIdentifier',
        'tax_posted' => 'taxPosted'
        };
*/
    public Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'invoice_item_charge_type' => 'invoiceItemChargeType',
        'un_prorated_amount' => 'unProratedAmount',
        'price_category' => 'priceCategory',
        'recurring_charge' => 'recurringCharge',
        'bill_in_advance' => 'billInAdvance',
        'tax_description' => 'taxDescription',
        'tax_identifier' => 'taxIdentifier',
        'tax_posted' => 'taxPosted'
      };
      return propertyMappings;
    }
  }
  /**
   * Gets or Sets InvoiceItemChargeType
   */
  public enum GTVAPInvoiceItemChargeType {
    ADHOC,
    ADDITIONAL_FEE,
    DISCOUNT,
    ONE_TIME_PRICE,
    TAX,
    USAGE
  }
  /**
   * GTVAPIInvoice
   */
  public class GTVAPIInvoice extends GTVAPIEntity implements GTVAPIRestClient.MappedProperties {
    /**
     * (unique_key)  The internal entity id for this entity representation
     * @return id
     */
    public String id { get; private set; }

    /**
     * (unique-key) description
     * @return invoiceNum
     */
    public String invoiceNum { get; set; }
    /**
     * (unique-key) type
     * @return invoiceNum
     */
    public String invoiceType { get; set; }

    /**
     * Get amount
     * @return amount
     */
    public Double amount { get; set; }

    /**
     * Get description
     * @return description
     */
    public String description { get; set; }

    /**
     * Get billingAccount
     * @return billingAccount
     */
    public GTVAPIBillingAccountRef billingAccount { get; set; }

    /**
     * Get occurredOn
     * @return occurredOn
     */
    public DateTime occurredOn { get; set; }

    //Added Due Date and Paid Date manually
    public Date dueDate { get; set; }
    public DateTime paidDate { get; set; }

    /**
     * Get amountToPay
     * @return amountToPay
     */
    public Double amountToPay { get; set; }

    /**
     * Get lateFeeCharged
     * @return lateFeeCharged
     */
    public Boolean lateFeeCharged { get; set; }

    /**
     * Get billCycle
     * @return billCycle
     */
    public GTVAPIBillCycle billCycle { get; set; }
    /**
     * Get billCycle
     * @return billCycle
     */
    public GTVAPIBillBatch billBatch { get; set; }

    /**
     * Get invoiceItems
     * @return invoiceItems
     */
    public List<GTVAPIInvoiceItem> invoiceItems { get; set; }

    /**
     * Get status
     * @return status
     */
    public GTVAPIInvoiceStatus status { get; set; }

    /**
     * Get billingStatement
     * @return billingStatement
     */
    public GTVAPIBillingStatement billingStatement { get; set; }
    /**
     * Get diputed
     * @return Boolean
     */
    public Boolean disputed { get; set; }

    /* private final Map<String, Object> propertyMappings = new Map<String, Object>{
        'invoice_num' => 'invoiceNum',
        'billing_account' => new List<String>{'billingAccount','GTVAPIBillingAccountRef'},
        'occurred_on' => 'occurredOn',
        'amount_to_pay' => 'amountToPay',
        'late_fee_charged' => 'lateFeeCharged',
        'bill_cycle' => new List<String>{'billCycle','GTVAPIBillCycle'},
        'invoice_items' => new List<String>{'invoiceItems','GTVAPIInvoiceItem'},
        'billing_statement' => new List<String>{'billingStatement','GTVAPIBillingStatement'},
        'due_date' => 'dueDate',
        'paid_date' => 'paidDate'
        };
*/
    public Map<String, Object> getPropertyMappings() {
      Map<String, Object> propertyMappings = new Map<String, Object>{
        'invoice_num' => 'invoiceNum',
        'billing_account' => new List<String>{
          'billingAccount',
          'GTVAPIBillingAccountRef'
        },
        'occurred_on' => 'occurredOn',
        'invoice_type' => 'invoiceType',
        'amount_to_pay' => 'amountToPay',
        'disputed' => 'disputed',
        'late_fee_charged' => 'lateFeeCharged',
        'bill_cycle' => new List<String>{ 'billCycle', 'GTVAPIBillCycle' },
        'bill_batch' => new List<String>{ 'billBatch', 'GTVAPIBillBatch' },
        'invoice_items' => new List<String>{
          'invoiceItems',
          'GTVAPIInvoiceItem'
        },
        'billing_statement' => new List<String>{
          'billingStatement',
          'GTVAPIBillingStatement'
        },
        'due_date' => 'dueDate',
        'paid_date' => 'paidDate'
      };
      return propertyMappings;
    }

    public GTVAPIInvoice() {
      invoiceItems = new List<GTVAPIInvoiceItem>();
    }
  }
  /**
   * GTVAPIInvoiceItem
   */
  public class GTVAPIInvoiceItem extends GTVAPIEntity implements GTVAPIRestClient.MappedProperties {
    /**
     * (unique_key)  The internal entity id for this entity representation
     * @return id
     */
    public String id { get; private set; }

    /**
     * Get invoiceItemType
     * @return invoiceItemType
     */
    public String invoiceItemType { get; set; }

    /**
     * Get quantity
     * @return quantity
     */
    public Double quantity { get; set; }

    /**
     * Get unitAmount
     * @return unitAmount
     */
    public Double unitAmount { get; set; }

    /**
     * Get totalAmount
     * @return totalAmount
     */
    public Double totalAmount { get; set; }

    /**
     * Get description
     * @return description
     */
    public String description { get; set; }

    /**
     * Get taxable
     * @return taxable
     */
    public Boolean taxable { get; set; }

    /**
     * Get proratedPercentage
     * @return proratedPercentage
     */
    public Double proratedPercentage { get; set; }

    /**
     * Get startDate
     * @return startDate
     */
    public DateTime startDate { get; set; }

    /**
     * Get endDate
     * @return endDate
     */
    public DateTime endDate { get; set; }

    /**
     * Get lineItemType
     * @return lineItemType
     */
    public String lineItemType { get; set; }

    /**
     * Get invoiceItemCharges
     * @return invoiceItemCharges
     */
    public List<GTVAPIInvoiceItemCharge> invoiceItemCharges { get; set; }
    /**
     * Get invoiceItemCharges
     * @return invoiceItemCharges
     */
    public GTVAPIService service { get; set; }

    /* private final Map<String, String> propertyMappings = new Map<String, String>{
        'invoice_item_type' => 'invoiceItemType',
        'unit_amount' => 'unitAmount',
        'total_amount' => 'totalAmount',
        'prorated_percentage' => 'proratedPercentage',
        'start_date' => 'startDate',
        'end_date' => 'endDate',
        'line_item_type' => 'lineItemType',
        'invoice_item_charges' => 'invoiceItemCharges'
        };
*/
    public Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'invoice_item_type' => 'invoiceItemType',
        'unit_amount' => 'unitAmount',
        'total_amount' => 'totalAmount',
        'prorated_percentage' => 'proratedPercentage',
        'start_date' => 'startDate',
        'end_date' => 'endDate',
        'line_item_type' => 'lineItemType',
        'service' => 'service',
        'charges' => 'invoiceItemCharges'
      };
      return propertyMappings;
    }

    public GTVAPIInvoiceItem() {
      invoiceItemCharges = new List<GTVAPIInvoiceItemCharge>();
    }
  }
  /**
   * Gets or Sets InvoiceItemType
   */
  public enum GTVAPIInvoiceItemType {
    ADDIITIONAL_FEE,
    ADJUSTMENT,
    PRODUCT,
    SERVICE,
    TAX,
    USAGE
  }
  /**
   * GTVAPIInvoiceItemCharge
   */
  public class GTVAPIInvoiceItemCharge extends GTVAPIEntity implements GTVAPIRestClient.MappedProperties {
    /**
     * (unique_key)  The internal entity id for this entity representation
     * @return id
     */
    public String id { get; private set; }

    /**
     * Get invoiceItemChargeType
     * @return invoiceItemChargeType
     */
    public GTVAPIInvoiceItemChargeType invoiceItemChargeType { get; set; }

    /**
     * Un prorated amount
     * @return unProratedAmount
     */
    public Double unProratedAmount { get; set; }

    /**
     * desc
     * @return amount
     */
    public Double amount { get; set; }

    /**
     * Get priceCategory
     * @return priceCategory
     */
    public GTVAPIChargeCategory priceCategory { get; set; }

    /**
     * desc
     * @return balance
     */
    public Double balance { get; set; }

    /**
     * desc
     * @return paid
     */
    public Boolean paid { get; set; }

    /**
     * desc
     * @return recurringCharge
     */
    public Boolean recurringCharge { get; set; }

    /**
     * desc
     * @return billInAdvance
     */
    public Boolean billInAdvance { get; set; }

    /**
     * desc
     * @return taxDescription
     */
    public String taxDescription { get; set; }

    /**
     * desc
     * @return description
     */
    public String description { get; set; }

    /**
     * desc
     * @return quantity
     */
    public Double quantity { get; set; }

    /**
     * desc
     * @return taxIdentifier
     */
    public String taxIdentifier { get; set; }

    /**
     * desc
     * @return taxPosted
     */
    public Boolean taxPosted { get; set; }

    /*  private final Map<String, String> propertyMappings = new Map<String, String>{
        'invoice_item_charge_type' => 'invoiceItemChargeType',
        'un_prorated_amount' => 'unProratedAmount',
        'price_category' => 'priceCategory',
        'recurring_charge' => 'recurringCharge',
        'bill_in_advance' => 'billInAdvance',
        'tax_description' => 'taxDescription',
        'tax_identifier' => 'taxIdentifier',
        'tax_posted' => 'taxPosted'
        };
*/
    public Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'invoice_item_charge_type' => 'invoiceItemChargeType',
        'un_prorated_amount' => 'unProratedAmount',
        'price_category' => 'priceCategory',
        'recurring_charge' => 'recurringCharge',
        'bill_in_advance' => 'billInAdvance',
        'tax_description' => 'taxDescription',
        'tax_identifier' => 'taxIdentifier',
        'tax_posted' => 'taxPosted'
      };
      return propertyMappings;
    }
  }
  /**
   * Gets or Sets InvoiceItemChargeType
   */
  public enum GTVAPIInvoiceItemChargeType {
    ADHOC,
    ADDITIONAL_FEE,
    DISCOUNT,
    ONE_TIME_PRICE,
    TAX,
    USAGE
  }
  /**
   * Gets or Sets InvoiceStatus
   */
  public enum GTVAPIInvoiceStatus {
    PROCESSING,
    OPEN,
    CLOSED
  }
  /**
   * A representation of a TRACT adjustment
   */
  public class GTVAPICreditAccountAdjustment extends GTVAPIAccountAdjustment implements GTVAPIRestClient.MappedProperties {
    /**
     * (unique_key)  The internal entity id for this entity representation
     * @return id
     */
    public String id { get; private set; }

    /**
     * Get occurredOn
     * @return occurredOn
     */
    public DateTime occurredOn { get; set; }

    /**
     * Get amount
     * @return amount
     */
    public Double amount { get; set; }

    /**
     * Get description
     * @return description
     */
    public String description { get; set; }

    /**
     * Get invoiced
     * @return invoiced
     */
    public Boolean invoiced { get; set; }

    /**
     * Get credit
     * @return credit
     */
    public Boolean credit { get; set; }

    /**
     * Get status
     * @return status
     */
    public GTVAPIAdjustmentStatus status { get; set; }

    /**
     * Get adjustmentType
     * @return adjustmentType
     */
    public GTVAPIAdjustmentType adjustmentType { get; set; }

    /**
     * Get billingAccount
     * @return billingAccount
     */
    public GTVAPIBillingAccountRef billingAccount { get; set; }

    /**
     * Get reason
     * @return reason
     */
    public GTVAPIAdjustmentReason reason { get; set; }

    /**
     * Get secondaryReason
     * @return secondaryReason
     */
    public GTVAPIAdjustmentReason secondaryReason { get; set; }

    /**
     * Get postedOn
     * @return postedOn
     */
    public DateTime postedOn { get; set; }

    /**
     * Get postedBy
     * @return postedBy
     */
    public String postedBy { get; set; }

    /**
     * Get manualInvoiceApplication
     * @return manualInvoiceApplication
     */
    public Boolean manualInvoiceApplication { get; set; }

    /**
     * Get adjustmentApplications
     * @return adjustmentApplications
     */
    public List<GTVAPIAdjustmentApplicationRef> adjustmentApplications {
      get;
      set;
    }

    /**
     * Get unappliedAmount
     * @return unappliedAmount
     */
    public Double unappliedAmount { get; set; }

    /**
     * Get creditNumber
     * @return creditNumber
     */
    public String creditNumber { get; set; }

    public List<GTVAPIAdjustmentItem> items { get; set; }

    /* private final Map<String, Object> propertyMappings = new Map<String, Object>{
        'occurred_on' => 'occurredOn',
        'adjustment_type' => 'adjustmentType',
        'billing_account' => new List<String>{'billingAccount','GTVAPIBillingAccountRef'},
        'secondary_reason' => new List<String>{'secondaryReason','GTVAPIAdjustmentReason'},
        'reason' => new List<String>{'reason','GTVAPIAdjustmentReason'},
        'posted_on' => 'postedOn',
        'posted_by' => 'postedBy',
        'manual_invoice_application' => 'manualInvoiceApplication',
        'adjustment_applications' => new List<String>{'adjustmentApplications','GTVAPIAdjustmentApplicationRef'},
        'unapplied_amount' => 'unappliedAmount',
        'credit_number' => 'creditNumber'
        };*/

    public override Map<String, Object> getPropertyMappings() {
      Map<String, Object> propertyMappings = new Map<String, Object>{
        'occurred_on' => 'occurredOn',
        'adjustment_type' => 'adjustmentType',
        'billing_account' => new List<String>{
          'billingAccount',
          'GTVAPIBillingAccountRef'
        },
        'secondary_reason' => new List<String>{
          'secondaryReason',
          'GTVAPIAdjustmentReason'
        },
        'reason' => new List<String>{ 'reason', 'GTVAPIAdjustmentReason' },
        'posted_on' => 'postedOn',
        'posted_by' => 'postedBy',
        'manual_invoice_application' => 'manualInvoiceApplication',
        'adjustment_applications' => new List<String>{
          'adjustmentApplications',
          'GTVAPIAdjustmentApplicationRef'
        },
        'unapplied_amount' => 'unappliedAmount',
        'credit_number' => 'creditNumber',
        'items' => new List<String>{ 'items', 'GTVAPIAdjustmentItem' }
      };
      return propertyMappings;
    }

    public GTVAPICreditAccountAdjustment() {
      adjustmentApplications = new List<GTVAPIAdjustmentApplicationRef>();
    }
  }
  /**
   * Gets or Sets AdjustmentStatus
   */
  public enum GTVAPIAdjustmentStatus {
    PENDING,
    POSTED,
    REVERSED
  }
  /**
   * Gets or Sets AdjustmentType
   */
  public enum GTVAPIAdjustmentType {
    MANUAL,
    LATE_FEE,
    TERMINATION_CHARGE,
    INVOICE_ADJUSTMENT,
    SERVICE,
    ORDER_ITEM
  }
  /**
   * GTVAPIAdjustmentReason
   */
  public virtual class GTVAPIAdjustmentReason extends GTVAPIEntity {
    /**
     * (unique_key)  The internal entity id for this entity representation
     * @return id
     */
    public String id { get; private set; }

    /**
     * (unique_key) The name of TRACT adjustment reason
     * @return name
     */
    public String name { get; set; }

    /**
     * An adjustment reason description
     * @return description
     */
    public String description { get; set; }

    /**
     * Get status
     * @return status
     */
    public GTVAPIAdjustmentReasonStatus status { get; set; }

    /**
     * Get level
     * @return level
     */
    public GTVAPIAdjustmentReasonLevel level { get; set; }
  }
  /**
   * Gets or Sets AdjustmentReasonStatus
   */
  public enum GTVAPIAdjustmentReasonStatus {
    ACTIVE,
    SUSPENDED,
    CANCELED
  }
  /**
   * Gets or Sets AdjustmentReasonLevel
   */
  public enum GTVAPIAdjustmentReasonLevel {
    PRIMARY,
    SECONDARY
  }
  /**
   * Adjustment application
   */
  public class GTVAPIAdjustmentApplicationRef extends GTVAPIEntityRef implements GTVAPIRestClient.MappedProperties {
    /**
     * (unique_key) The internal entity id for this entity representation
     * @return id
     */
    public String id { get; set; }

    /**
     * Get accountAdjustment
     * @return accountAdjustment
     */
    public GTVAPIAccountAdjustmentRef accountAdjustment { get; set; }

    /**
     * Get adjustmentApplicationType
     * @return adjustmentApplicationType
     */
    public GTVAPIAdjustmentApplicationType adjustmentApplicationType {
      get;
      set;
    }

    /*  private final Map<String, Object> propertyMappings = new Map<String, Object>{
        'account_adjustment' => new List<String>{'accountAdjustment','GTVAPIAccountAdjustmentRef'}
           // 'adjustment_application_type' => new list<String>{'adjustmentApplicationType','GTVAPIAdjustmentApplicationType'}
        };
*/
    public Map<String, Object> getPropertyMappings() {
      Map<String, Object> propertyMappings = new Map<String, Object>{
        'account_adjustment' => new List<String>{
          'accountAdjustment',
          'GTVAPIAccountAdjustmentRef'
        }
        // 'adjustment_application_type' => new list<String>{'adjustmentApplicationType','GTVAPIAdjustmentApplicationType'}
      };
      return propertyMappings;
    }
  }
  /**
   * A representation of a TRACT adjustment
   */
  public class GTVAPIAccountAdjustmentRef extends GTVAPIEntityRef implements GTVAPIRestClient.MappedProperties {
    /**
     * (unique_key) The internal entity id for this entity representation
     * @return id
     */
    public String id { get; set; }

    /**
     * Get reason
     * @return reason
     */
    public GTVAPIAdjustmentReasonRef reason { get; set; }

    /**
     * Get secondaryReason
     * @return secondaryReason
     */
    public GTVAPIAdjustmentReasonRef secondaryReason { get; set; }

    /*  private final Map<String, String> propertyMappings = new Map<String, String>{
        'secondary_reason' => 'secondaryReason'
        };
*/
    public Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'secondary_reason' => 'secondaryReason'
      };
      return propertyMappings;
    }
  }
  /**
   * Gets or Sets AdjustmentApplicationType
   */
  public enum GTVAPIAdjustmentApplicationType {
    STANDARD_INVOICE,
    NEGATIVE_INVOICE,
    REVERSED_INVOICE,
    WRITE_OFF
  }
  /**
   * A representation of a TRACT adjustment
   */
  public class GTVAPIDebitAccountAdjustment extends GTVAPIAccountAdjustment implements GTVAPIRestClient.MappedProperties {
    /**
     * (unique_key)  The internal entity id for this entity representation
     * @return id
     */
    public String id { get; private set; }

    /**
     * Get occurredOn
     * @return occurredOn
     */
    public DateTime occurredOn { get; set; }

    /**
     * Get amount
     * @return amount
     */
    public Double amount { get; set; }

    /**
     * Get description
     * @return description
     */
    public String description { get; set; }

    /**
     * Get invoiced
     * @return invoiced
     */
    public Boolean invoiced { get; set; }

    /**
     * Get credit
     * @return credit
     */
    public Boolean credit { get; set; }

    /**
     * Get status
     * @return status
     */
    public GTVAPIAdjustmentStatus status { get; set; }

    /**
     * Get adjustmentType
     * @return adjustmentType
     */
    public GTVAPIAdjustmentType adjustmentType { get; set; }

    /**
     * Get billingAccount
     * @return billingAccount
     */
    public GTVAPIBillingAccountRef billingAccount { get; set; }

    /**
     * Get reason
     * @return reason
     */
    public GTVAPIAdjustmentReason reason { get; set; }

    /**
     * Get secondaryReason
     * @return secondaryReason
     */
    public GTVAPIAdjustmentReason secondaryReason { get; set; }

    /**
     * Get postedOn
     * @return postedOn
     */
    public DateTime postedOn { get; set; }

    /**
     * Get postedBy
     * @return postedBy
     */
    public String postedBy { get; set; }

    /**
     * Get manualInvoiceApplication
     * @return manualInvoiceApplication
     */
    public Boolean manualInvoiceApplication { get; set; }

    /**
     * Get adjustmentApplications
     * @return adjustmentApplications
     */
    public List<GTVAPIAdjustmentApplicationRef> adjustmentApplications {
      get;
      set;
    }

    /**
     * Get unappliedAmount
     * @return unappliedAmount
     */
    public Double unappliedAmount { get; set; }

    /**
     * Get billedInvoice
     * @return billedInvoice
     */
    public GTVAPIInvoiceRef billedInvoice { get; set; }

    /*  private final Map<String, Object> propertyMappings = new Map<String, Object>{
        'occurred_on' => 'occurredOn',
        'adjustment_type' => 'adjustmentType',
        'billing_account' => new List<String>{'billingAccount','GTVAPIBillingAccountRef'},
        'secondary_reason' => new List<String>{'secondaryReason','GTVAPIAdjustmentReason'},
        'reason' => new List<String>{'reason','GTVAPIAdjustmentReason'},
        'posted_on' => 'postedOn',
        'posted_by' => 'postedBy',
        'manual_invoice_application' => 'manualInvoiceApplication',
        'adjustment_applications' => new List<String>{'adjustmentApplications','GTVAPIAdjustmentApplicationRef'},
        'unapplied_amount' => 'unappliedAmount',
        'billed_invoice' => new List<String>{'billedInvoice','GTVAPIInvoiceRef'},
        'adjustmentApplications' => new List<String>{'adjustmentApplications','GTVAPIAdjustmentApplicationRef'}
        };*/

    public override Map<String, Object> getPropertyMappings() {
      Map<String, Object> propertyMappings = new Map<String, Object>{
        'occurred_on' => 'occurredOn',
        'adjustment_type' => 'adjustmentType',
        'billing_account' => new List<String>{
          'billingAccount',
          'GTVAPIBillingAccountRef'
        },
        'secondary_reason' => new List<String>{
          'secondaryReason',
          'GTVAPIAdjustmentReason'
        },
        'reason' => new List<String>{ 'reason', 'GTVAPIAdjustmentReason' },
        'posted_on' => 'postedOn',
        'posted_by' => 'postedBy',
        'manual_invoice_application' => 'manualInvoiceApplication',
        'adjustment_applications' => new List<String>{
          'adjustmentApplications',
          'GTVAPIAdjustmentApplicationRef'
        },
        'unapplied_amount' => 'unappliedAmount',
        'billed_invoice' => new List<String>{
          'billedInvoice',
          'GTVAPIInvoiceRef'
        },
        'adjustmentApplications' => new List<String>{
          'adjustmentApplications',
          'GTVAPIAdjustmentApplicationRef'
        }
      };
      return propertyMappings;
    }

    public GTVAPIDebitAccountAdjustment() {
      adjustmentApplications = new List<GTVAPIAdjustmentApplicationRef>();
    }
  }
  /**
   * GTVAPIInvoiceRef
   */
  public class GTVAPIInvoiceRef extends GTVAPIEntityRef implements GTVAPIRestClient.MappedProperties {
    /**
     * (unique_key) The internal entity id for this entity representation
     * @return id
     */
    public String id { get; set; }

    /**
     * (unique-key) description
     * @return invoiceNum
     */
    public String invoiceNum { get; set; }

    /**
     * Get billingStatement
     * @return billingStatement
     */
    public GTVAPIBillingStatement billingStatement { get; set; }

    /**
     * Get billCycle
     * @return billCycle
     */
    public GTVAPIBillCycleRef billCycle { get; set; }

    /**
     * Get invoiceItems
     * @return invoiceItems
     */
    public List<GTVAPIInvoiceItem> invoiceItems { get; set; }

    /*private final Map<String, Object> propertyMappings = new Map<String, Object>{
        'invoice_num' => 'invoiceNum',
        'billing_statement' => 'billingStatement',
        'bill_cycle' => new List<String>{'billCycle','GTVAPIBillCycleRef'},
        'invoice_items' => new List<String>{'invoiceItems','GTVAPIInvoiceItem'}
        };
*/
    public Map<String, Object> getPropertyMappings() {
      Map<String, Object> propertyMappings = new Map<String, Object>{
        'invoice_num' => 'invoiceNum',
        'billing_statement' => 'billingStatement',
        'bill_cycle' => new List<String>{ 'billCycle', 'GTVAPIBillCycleRef' },
        'invoice_items' => new List<String>{
          'invoiceItems',
          'GTVAPIInvoiceItem'
        }
      };
      return propertyMappings;
    }

    public GTVAPIInvoiceRef() {
      invoiceItems = new List<GTVAPIInvoiceItem>();
    }
  }
  /**
   * A representation of a TRACT adjustment
   */
  public virtual class GTVAPIAccountAdjustment extends GTVAPIEntity implements GTVAPIRestClient.MappedProperties {
    /**
     * (unique_key)  The internal entity id for this entity representation
     * @return id
     */
    public String id { get; private set; }

    /**
     * Get occurredOn
     * @return occurredOn
     */
    public DateTime occurredOn { get; set; }

    /**
     * Get amount
     * @return amount
     */
    public Double amount { get; set; }

    /**
     * Get description
     * @return description
     */
    public String description { get; set; }

    /**
     * Get invoiced
     * @return invoiced
     */
    public Boolean invoiced { get; set; }

    /**
     * Get credit
     * @return credit
     */
    public Boolean credit { get; set; }

    /**
     * Get status
     * @return status
     */
    public GTVAPIAdjustmentStatus status { get; set; }

    /**
     * Get adjustmentType
     * @return adjustmentType
     */
    public GTVAPIAdjustmentType adjustmentType { get; set; }

    /**
     * Get billingAccount
     * @return billingAccount
     */
    public GTVAPIBillingAccountRef billingAccount { get; set; }

    /**
     * Get reason
     * @return reason
     */
    public GTVAPIAdjustmentReason reason { get; set; }

    /**
     * Get secondaryReason
     * @return secondaryReason
     */
    public GTVAPIAdjustmentReason secondaryReason { get; set; }

    /**
     * Get postedOn
     * @return postedOn
     */
    public DateTime postedOn { get; set; }

    /**
     * Get postedBy
     * @return postedBy
     */
    public String postedBy { get; set; }

    /**
     * Get manualInvoiceApplication
     * @return manualInvoiceApplication
     */
    public Boolean manualInvoiceApplication { get; set; }

    /**
     * Get adjustmentApplications
     * @return adjustmentApplications
     */
    public List<GTVAPIAdjustmentApplicationRef> adjustmentApplications {
      get;
      set;
    }

    /**
     * Get unappliedAmount
     * @return unappliedAmount
     */
    public Double unappliedAmount { get; set; }

    /*private final Map<String, Object> propertyMappings = new Map<String, Object>{
        'occurred_on' => 'occurredOn',
        'adjustment_type' => 'adjustmentType',
        'billing_account' => new List<String>{'billingAccount','GTVAPIBillingAccountRef'},
        'secondary_reason' => new List<String>{'secondaryReason','GTVAPIAdjustmentReason'},
        'reason' => new List<String>{'reason','GTVAPIAdjustmentReason'},
        'posted_on' => 'postedOn',
        'posted_by' => 'postedBy',
        'manual_invoice_application' => 'manualInvoiceApplication',
        'adjustment_applications' => 'adjustmentApplications',
        'unapplied_amount' => 'unappliedAmount',
        'adjustmentApplications' => new List<String>{'adjustmentApplications','GTVAPIAdjustmentApplicationRef'}
        };
*/
    public virtual Map<String, Object> getPropertyMappings() {
      Map<String, Object> propertyMappings = new Map<String, Object>{
        'occurred_on' => 'occurredOn',
        'adjustment_type' => 'adjustmentType',
        'billing_account' => new List<String>{
          'billingAccount',
          'GTVAPIBillingAccountRef'
        },
        'secondary_reason' => new List<String>{
          'secondaryReason',
          'GTVAPIAdjustmentReason'
        },
        'reason' => new List<String>{ 'reason', 'GTVAPIAdjustmentReason' },
        'posted_on' => 'postedOn',
        'posted_by' => 'postedBy',
        'manual_invoice_application' => 'manualInvoiceApplication',
        'adjustment_applications' => 'adjustmentApplications',
        'unapplied_amount' => 'unappliedAmount',
        'adjustmentApplications' => new List<String>{
          'adjustmentApplications',
          'GTVAPIAdjustmentApplicationRef'
        }
      };
      return propertyMappings;
    }

    public GTVAPIAccountAdjustment() {
      adjustmentApplications = new List<GTVAPIAdjustmentApplicationRef>();
    }
  }
  /**
   * GTVAPICreateAccountAdjustment
   */
  public class GTVAPICreateAccountAdjustment implements GTVAPIRestClient.MappedProperties {
    /**
     * Get amount
     * @return amount
     */
    public Double amount { get; set; }

    /**
     * Get description
     * @return description
     */
    public String description { get; set; }

    /**
     * Get adjustmentType
     * @return adjustmentType
     */
    public GTVAPIAdjustmentType adjustmentType { get; set; }

    /**
     * Get billing_account
     * @return billing_account
     */
    public GTVAPIBillingAccountRef billing_account { get; set; }

    /**
     * Get reason
     * @return reason
     */
    public GTVAPIAdjustmentReasonRef reason { get; set; }

    /**
     * Get secondaryReason
     * @return secondaryReason
     */
    public GTVAPIAdjustmentReasonRef secondaryReason { get; set; }

    /**
     * Get manual_invoice_application
     * @return manual_invoice_application
     */
    public Boolean manual_invoice_application { get; set; }

    /**
     * Get occurredOn
     * @return occurredOn
     */
    public String occurred_on { get; set; }

    /*  private final Map<String, String> propertyMappings = new Map<String, String>{
        'adjustment_type' => 'adjustmentType',
        'billing_account' => 'billing_account',
        'secondary_reason' => 'secondaryReason',
        'manual_invoice_application' => 'manual_invoice_application'
        };
*/
    public Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'adjustment_type' => 'adjustmentType',
        'billing_account' => 'billing_account',
        'secondary_reason' => 'secondaryReason',
        'manual_invoice_application' => 'manual_invoice_application'
      };
      return propertyMappings;
    }
  }
  /**
   * GTVAPIBillingAccountCustomField
   */
  public class GTVAPIBillingAccountCustomField extends GTVAPICustomField implements GTVAPIRestClient.MappedProperties {
    /* private final Map<String, String> propertyMappings = new Map<String, String>{
            'custom_field_type' => 'customFieldType',
            'reg_ex' => 'regEx',
            'field_type' => 'fieldType',
            'field_validation_type' => 'fieldValidationType'
        };
*/
    public override Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'custom_field_type' => 'customFieldType',
        'reg_ex' => 'regEx',
        'field_type' => 'fieldType',
        'field_validation_type' => 'fieldValidationType'
      };

      return propertyMappings;
    }

    public GTVAPIBillingAccountCustomField() {
    }
  }
  /**
   * GTVAPICustomField
   */
  public virtual class GTVAPICustomField extends GTVAPIEntity implements GTVAPIRestClient.MappedProperties {
    /**
     * (unique_key)  The internal entity id for this entity representation
     * @return id
     */
    public String id { get; private set; }

    /**
     * (unique_key)
     * @return name
     */
    public String name { get; private set; }

    /**
     * Get customFieldType
     * @return customFieldType
     */
    public String customFieldType { get; set; }

    /**
     * Get description
     * @return description
     */
    public String description { get; private set; }

    /**
     * Get enabled
     * @return enabled
     */
    public Boolean enabled { get; private set; }

    /**
     * Get searchable
     * @return searchable
     */
    public Boolean searchable { get; private set; }

    /**
     * Get regEx
     * @return regEx
     */
    public String regEx { get; private set; }

    /**
     * Get fieldType
     * @return fieldType
     */
    public String fieldType { get; set; }

    /**
     * Get fieldValidationType
     * @return fieldValidationType
     */
    public String fieldValidationType { get; set; }

    /**
     * Get references
     * @return references
     */
    public List<GTVAPICustomFieldValueReference> references { get; set; }

    /*private final Map<String, String> propertyMappings = new Map<String, String>{
        'custom_field_type' => 'customFieldType',
        'reg_ex' => 'regEx',
        'field_type' => 'fieldType',
        'field_validation_type' => 'fieldValidationType'
        };
*/
    public virtual Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'custom_field_type' => 'customFieldType',
        'reg_ex' => 'regEx',
        'field_type' => 'fieldType',
        'field_validation_type' => 'fieldValidationType'
      };

      return propertyMappings;
    }

    public GTVAPICustomField() {
      references = new List<GTVAPICustomFieldValueReference>();
    }
  }
  /**
   * GTVAPICustomFieldValueReference
   */
  public class GTVAPICustomFieldValueReference extends GTVAPIEntity {
    /**
     * (unique_key)  The internal entity id for this entity representation
     * @return id
     */
    public String id { get; private set; }

    /**
     * The value for this reference
     * @return value
     */
    public String value { get; set; }

    /**
     * Get status
     * @return status
     */
    public GTVAPICustomFieldValueReferenceSta status { get; set; }
  }
  /**
   * Gets or Sets CustomFieldValueReferenceStatus
   */
  public enum GTVAPICustomFieldValueReferenceSta {
    ACTIVE,
    SUSPENDED
  }
  /*
   * TRACT Billing API
   * Create and manage billing accounts, products, orders, services, billing, invoicing, payments, and the general ledger. This microservice provides core functionality for the goTransverse billing platform.
   *
   * OpenAPI spec version: 2
   *
   *
   * NOTE: This class is auto generated by the swagger code generator program.
   * https://github.com/swagger-api/swagger-codegen.git
   * Do not edit the class manually.
   */

  /**
   * A representation of the core Usage Event entity.
   */
  public class GTVAPIUsageEvent extends GTVAPIEntity implements GTVAPIRestClient.MappedProperties {
    /**
     * (unique_key) The ID of the entity.
     * @return id
     */
    public String id { get; private set; }

    /**
     * A description of this usage event.
     * @return description
     */
    public String description { get; private set; }

    /**
     * The date and time when the usage event started.
     * @return startTime
     */
    public Datetime startTime { get; private set; }

    /**
     * The date and time when the usage event ended.
     * @return endTime
     */
    public Datetime endTime { get; private set; }

    /**
     * The unique identifier associated with a service, which is used to show where the service is located in a service hierarchy. For products, it usually can represent installation keys, phone numbers, or some unique ID one needs to track for products. Usage rules use SRIDs to load usage into the system.
     * @return serviceResourceIdentifier
     */
    public String serviceResourceIdentifier { get; private set; }

    /**
     * Get usageUom
     * @return usageUom
     */
    public GTVAPIUsageDurationUom usageUom { get; set; }

    /**
     * The number of measured items used by the customer during the billing period for which a calculated charge will be levied.
     * @return usageAmount
     */
    public Double usageAmount { get; private set; }

    /**
     * Reference ID can be set from an external system and should be a unique value. It is used to ensure that duplicate usage events are not posted to Gotransverse core.
     * @return referenceId
     */
    public String referenceId { get; private set; }

    /**
     * Sequence ID can be set from an external system and should be a unique value. It is used to ensure that duplicate usage events are not posted to Gotransverse core.
     * @return sequenceId
     */
    public String sequenceId { get; private set; }

    /**
     * User-defined field used for customization.
     * @return text01
     */
    public String text01 { get; private set; }

    /**
     * User-defined field used for customization.
     * @return text02
     */
    public String text02 { get; private set; }

    /**
     * User-defined field used for customization.
     * @return text03
     */
    public String text03 { get; private set; }

    /**
     * User-defined field used for customization.
     * @return text04
     */
    public String text04 { get; private set; }

    /**
     * User-defined field used for customization.
     * @return text05
     */
    public String text05 { get; private set; }

    /**
     * User-defined field used for customization.
     * @return number01
     */
    public Double number01 { get; private set; }

    /**
     * User-defined field used for customization.
     * @return number02
     */
    public Double number02 { get; private set; }

    /**
     * User-defined field used for customization.
     * @return number03
     */
    public Double number03 { get; private set; }

    /**
     * User-defined field used for customization.
     * @return number04
     */
    public Double number04 { get; private set; }

    /**
     * User-defined field used for customization.
     * @return number05
     */
    public Double number05 { get; private set; }

    /**
     * User-defined field used for customization.
     * @return boolean01
     */
    public Boolean boolean01 { get; private set; }

    /**
     * User-defined field used for customization.
     * @return boolean02
     */
    public Boolean boolean02 { get; private set; }

    /**
     * User-defined field used for customization.
     * @return boolean03
     */
    public Boolean boolean03 { get; private set; }

    /**
     * User-defined field used for customization.
     * @return boolean04
     */
    public Boolean boolean04 { get; private set; }

    /**
     * User-defined field used for customization.
     * @return boolean05
     */
    public Boolean boolean05 { get; private set; }

    /**
     * User-defined field used for customization.
     * @return date01
     */
    public Datetime date01 { get; private set; }

    /**
     * User-defined field used for customization.
     * @return date02
     */
    public Datetime date02 { get; private set; }

    /**
     * User-defined field used for customization.
     * @return date03
     */
    public Datetime date03 { get; private set; }

    /**
     * User-defined field used for customization.
     * @return date04
     */
    public Datetime date04 { get; private set; }

    /**
     * User-defined field used for customization.
     * @return date05
     */
    public Datetime date05 { get; private set; }

    /**
     * The total charge for this usage event.
     * @return totalCharge
     */
    public Double totalCharge { get; private set; }

    /**
     * The number of times this event has been overwritten.
     * @return overwriteCounter
     */
    public Double overwriteCounter { get; private set; }

    /**
     * The identifier for the request.
     * @return requestId
     */
    public String requestId { get; private set; }

    /**
     * Get servicePeriod
     * @return servicePeriod
     */
    public GTVAPIServicePeriodRef servicePeriod { get; set; }

    /**
     * The charges for this event.
     * @return eventCharges
     */
    public List<GTVAPIEventCharge> eventCharges { get; set; }

    /**
     * Specifies ID of the voided event during OVERWRITE (if exists).
     * @return overwrittenEventId
     */
    public String overwrittenEventId { get; private set; }

    /*  private final Map<String, String> propertyMappings = new Map<String, String>{
            'start_time' => 'startTime',
            'end_time' => 'endTime',
            'service_resource_identifier' => 'serviceResourceIdentifier',
            'usage_uom' => 'usageUom',
            'usage_amount' => 'usageAmount',
            'reference_id' => 'referenceId',
            'sequence_id' => 'sequenceId',
            'total_charge' => 'totalCharge',
            'overwrite_counter' => 'overwriteCounter',
            'request_id' => 'requestId',
            'service_period' => 'servicePeriod',
            'event_charges' => 'eventCharges',
            'overwritten_event_id' => 'overwrittenEventId'
        };*/

    public Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'start_time' => 'startTime',
        'end_time' => 'endTime',
        'service_resource_identifier' => 'serviceResourceIdentifier',
        'usage_uom' => 'usageUom',
        'usage_amount' => 'usageAmount',
        'reference_id' => 'referenceId',
        'sequence_id' => 'sequenceId',
        'total_charge' => 'totalCharge',
        'overwrite_counter' => 'overwriteCounter',
        'request_id' => 'requestId',
        'service_period' => 'servicePeriod',
        'event_charges' => 'eventCharges',
        'overwritten_event_id' => 'overwrittenEventId'
      };
      return propertyMappings;
    }

    public GTVAPIUsageEvent() {
      eventCharges = new List<GTVAPIEventCharge>();
    }
  }
  /**
   * A reference to the Service Period core entity.
   */
  public class GTVAPIServicePeriodRef extends GTVAPIEntityRef {
    /**
     * (unique_key) The ID of the entity.
     * @return id
     */
    public String id { get; set; }
  }

  /**
   * A representation of the core Event Charge entity.
   */
  public class GTVAPIEventCharge extends GTVAPIEntity implements GTVAPIRestClient.MappedProperties {
    /**
     * (unique_key) The ID of the entity.
     * @return id
     */
    public String id { get; private set; }

    /**
     * Get usageUom
     * @return usageUom
     */
    public GTVAPIUsageDurationUom usageUom { get; set; }

    /**
     * The number of measured items used by the customer during the billing period for which a calculated charge will be levied.
     * @return usageAmount
     */
    public Double usageAmount { get; private set; }

    /**
     * Get usageRule
     * @return usageRule
     */
    public GTVAPIUsageRuleRef usageRule { get; set; }

    /**
     * The charge for this usage event.
     * @return charge
     */
    public Double charge { get; private set; }

    /**
     * Get chargeCategory
     * @return chargeCategory
     */
    public GTVAPIUsageChargeCategoryRef chargeCategory { get; set; }

    /*private final Map<String, String> propertyMappings = new Map<String, String>{
            'usage_uom' => 'usageUom',
            'usage_amount' => 'usageAmount',
            'usage_rule' => 'usageRule',
            'charge_category' => 'chargeCategory'
        };
*/
    public Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'usage_uom' => 'usageUom',
        'usage_amount' => 'usageAmount',
        'usage_rule' => 'usageRule',
        'charge_category' => 'chargeCategory'
      };
      return propertyMappings;
    }
  }

  /**
   * A reference to the core Usage Rule entity.
   */
  public class GTVAPIUsageRuleRef extends GTVAPIEntityRef {
    /**
     * (unique_key) The ID of the entity.
     * @return id
     */
    public String id { get; set; }
  }
  /**
   * A reference to the Usage Charge Category core entity.
   */
  public class GTVAPIUsageChargeCategoryRef extends GTVAPIChargeCategoryRef implements GTVAPIRestClient.MappedProperties {
    /*private final Map<String, String> propertyMappings = new Map<String, String>{
            'charge_category_type' => 'chargeCategoryType'
        };
*/
    public override Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'charge_category_type' => 'chargeCategoryType'
      };
      return propertyMappings;
    }
  }

  /**
   * A representation of the core Bulk Usage Events entity. Submits multiple Usage Events in bulk.
   */
  public class GTVAPIBulkUsageEvents implements GTVAPIRestClient.MappedProperties {
    /**
     * Get ratedEvents
     * @return ratedEvents
     */
    public List<GTVAPIUsageEvent> ratedEvents { get; set; }

    /**
     * Get erredEvents
     * @return erredEvents
     */
    public List<GTVAPIErredUsageEvent> erredEvents { get; set; }

    /*  private final Map<String, String> propertyMappings = new Map<String, String>{
        'rated_events' => 'ratedEvents',
        'erred_events' => 'erredEvents'
    };
*/
    public Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'rated_events' => 'ratedEvents',
        'erred_events' => 'erredEvents'
      };
      return propertyMappings;
    }

    public GTVAPIBulkUsageEvents() {
      ratedEvents = new List<GTVAPIUsageEvent>();
      erredEvents = new List<GTVAPIErredUsageEvent>();
    }
  }

  /**
   * A representation of the core Erred Void Usage Event entity.
   */
  public class GTVAPIErredUsageEvent implements GTVAPIRestClient.MappedProperties {
    /**
     * The identifier for the request.
     * @return requestId
     */
    public String requestId { get; private set; }

    /**
     * Get unratedUsageEvent
     * @return unratedUsageEvent
     */
    public GTVAPICreateUsageEvent unratedUsageEvent { get; set; }

    /**
     * A message indicating information about an error.
     * @return message
     */
    public String message { get; private set; }

    /**
     * A status code indicating the type of error.
     * @return code
     */
    public String code { get; private set; }

    /**
     * Specifies ID of the event voided during OVERWRITE attempt (if exists).
     * @return voidedEventId
     */
    public String voidedEventId { get; private set; }

    /* private final Map<String, String> propertyMappings = new Map<String, String>{
        'request_id' => 'requestId',
        'unrated_usage_event' => 'unratedUsageEvent',
        'voided_event_id' => 'voidedEventId'
    };
*/
    public Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'request_id' => 'requestId',
        'unrated_usage_event' => 'unratedUsageEvent',
        'voided_event_id' => 'voidedEventId'
      };
      return propertyMappings;
    }
  }

  /**
   * Creates the Usage Event entity.
   */
  public class GTVAPICreateUsageEvent implements GTVAPIRestClient.MappedProperties {
    /**
     * A description of this usage event.
     * @return description
     */
    public String description { get; set; }

    /**
     * The date and time when the usage event started.
     * @return startTime
     */
    public Datetime startTime { get; set; }

    /**
     * The date and time when the usage event ended.
     * @return endTime
     */
    public Datetime endTime { get; set; }

    /**
     * The unique identifier associated with a service that is used to show where the service is located in a service hierarchy. For products these usually represent installation keys, phone numbers, or unique IDs needed to track a product. Usage Rules use SRIDs to load usage into the system.
     * @return serviceResourceIdentifier
     */
    public String serviceResourceIdentifier { get; set; }

    /**
     * Get usageUom
     * @return usageUom
     */
    public GTVAPIUsageDurationUom usageUom { get; set; }

    /**
     * The number of measured items used by the customer during the billing period for which a calculated charge will be levied.
     * @return usageAmount
     */
    public Double usageAmount { get; set; }

    /**
     * Reference ID can be set from an external system and should be a unique value. It is used to ensure that duplicate usage events are not posted to Gotransverse core.
     * @return referenceId
     */
    public String referenceId { get; set; }

    /**
     * Sequence ID can be set from an external system and should be a unique value. It is used to ensure that duplicate usage events are not posted to Gotransverse core.
     * @return sequenceId
     */
    public String sequenceId { get; set; }

    /**
     * User-defined field used for customization.
     * @return text01
     */
    public String text01 { get; set; }

    /**
     * User-defined field used for customization.
     * @return text02
     */
    public String text02 { get; set; }

    /**
     * User-defined field used for customization.
     * @return text03
     */
    public String text03 { get; set; }

    /**
     * User-defined field used for customization.
     * @return text04
     */
    public String text04 { get; set; }

    /**
     * User-defined field used for customization.
     * @return text05
     */
    public String text05 { get; set; }

    /**
     * User-defined field used for customization.
     * @return number01
     */
    public Double number01 { get; set; }

    /**
     * User-defined field used for customization.
     * @return number02
     */
    public Double number02 { get; set; }

    /**
     * User-defined field used for customization.
     * @return number03
     */
    public Double number03 { get; set; }

    /**
     * User-defined field used for customization.
     * @return number04
     */
    public Double number04 { get; set; }

    /**
     * User-defined field used for customization.
     * @return number05
     */
    public Double number05 { get; set; }

    /**
     * User-defined field used for customization.
     * @return boolean01
     */
    public Boolean boolean01 { get; set; }

    /**
     * User-defined field used for customization.
     * @return boolean02
     */
    public Boolean boolean02 { get; set; }

    /**
     * User-defined field used for customization.
     * @return boolean03
     */
    public Boolean boolean03 { get; set; }

    /**
     * User-defined field used for customization.
     * @return boolean04
     */
    public Boolean boolean04 { get; set; }

    /**
     * User-defined field used for customization.
     * @return boolean05
     */
    public Boolean boolean05 { get; set; }

    /**
     * User-defined field used for customization.
     * @return date01
     */
    public Datetime date01 { get; set; }

    /**
     * User-defined field used for customization.
     * @return date02
     */
    public Datetime date02 { get; set; }

    /**
     * User-defined field used for customization.
     * @return date03
     */
    public Datetime date03 { get; set; }

    /**
     * User-defined field used for customization.
     * @return date04
     */
    public Datetime date04 { get; set; }

    /**
     * User-defined field used for customization.
     * @return date05
     */
    public Datetime date05 { get; set; }

    /* private final Map<String, String> propertyMappings = new Map<String, String>{
        'start_time' => 'startTime',
        'end_time' => 'endTime',
        'service_resource_identifier' => 'serviceResourceIdentifier',
        'usage_uom' => 'usageUom',
        'usage_amount' => 'usageAmount',
        'reference_id' => 'referenceId',
        'sequence_id' => 'sequenceId'
    };*/

    public Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'start_time' => 'startTime',
        'end_time' => 'endTime',
        'service_resource_identifier' => 'serviceResourceIdentifier',
        'usage_uom' => 'usageUom',
        'usage_amount' => 'usageAmount',
        'reference_id' => 'referenceId',
        'sequence_id' => 'sequenceId'
      };
      return propertyMappings;
    }
  }
  /*
   * TRACT Billing API
   * Create and manage billing accounts, products, orders, services, billing, invoicing, payments, and the general ledger. This microservice provides core functionality for the goTransverse billing platform.
   *
   * OpenAPI spec version: 2
   *
   *
   * NOTE: This class is auto generated by the swagger code generator program.
   * https://github.com/swagger-api/swagger-codegen.git
   * Do not edit the class manually.
   */

  /**
   * A representation of the core Bulk Void Usage Events entity. Through the API, you can void up to 50 usage events in a single request.
   */
  public class GTVAPIBulkVoidUsageEvents implements GTVAPIRestClient.MappedProperties {
    /**
     * Identifies how many usage events should be voided.
     * @return numVoided
     */
    public Integer numVoided { get; set; }

    /**
     * Get voidedEventCriterias
     * @return voidedEventCriterias
     */
    public List<GTVAPIVoidUsageEventCriteria> voidedEventCriterias { get; set; }

    /**
     * Get erredEventCriterias
     * @return erredEventCriterias
     */
    public List<GTVAPIErredVoidUsageEventCriteria> erredEventCriterias {
      get;
      set;
    }

    /* private final Map<String, String> propertyMappings = new Map<String, String>{
        'num_voided' => 'numVoided',
        'voided_event_criterias' => 'voidedEventCriterias',
        'erred_event_criterias' => 'erredEventCriterias'
    };
*/
    public Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'num_voided' => 'numVoided',
        'voided_event_criterias' => 'voidedEventCriterias',
        'erred_event_criterias' => 'erredEventCriterias'
      };
      return propertyMappings;
    }

    public GTVAPIBulkVoidUsageEvents() {
      voidedEventCriterias = new List<GTVAPIVoidUsageEventCriteria>();
      erredEventCriterias = new List<GTVAPIErredVoidUsageEventCriteria>();
    }
  }

  /**
   * A representation of the core Void Usage Event Criteria entity.
   */
  public class GTVAPIVoidUsageEventCriteria implements GTVAPIRestClient.MappedProperties {
    /**
     * The unique identity number assigned to all entities in Gotransverse core that is generated by the system.
     * @return id
     */
    public String id { get; private set; }

    /**
     * The reference ID can be set from an external system and should be a unique value. It is used to ensure that duplicate usage events are not posted to Gotransverse core.
     * @return referenceId
     */
    public String referenceId { get; private set; }

    /**
     * The sequence ID can be set from an external system and should be a unique value. It is used to ensure that duplicate usage events are not posted to Gotransverse core.
     * @return sequenceId
     */
    public String sequenceId { get; private set; }

    /* private final Map<String, String> propertyMappings = new Map<String, String>{
        'reference_id' => 'referenceId',
        'sequence_id' => 'sequenceId'
    };*/

    public Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'reference_id' => 'referenceId',
        'sequence_id' => 'sequenceId'
      };

      return propertyMappings;
    }
  }

  /**
   * A representation of the core Erred Void Usage Event Criteria entity. It includes information about why the usage event failed to proceed.
   */
  public class GTVAPIErredVoidUsageEventCriteria implements GTVAPIRestClient.MappedProperties {
    /**
     * A message indicating information about an error.
     * @return message
     */
    public String message { get; private set; }

    /**
     * A status code indicating the type of error.
     * @return code
     */
    public String code { get; private set; }

    /**
     * Get unvoidedEventCriteria
     * @return unvoidedEventCriteria
     */
    public GTVAPIVoidUsageEventCriteria unvoidedEventCriteria { get; set; }

    /*  private final Map<String, String> propertyMappings = new Map<String, String>{
        'unvoided_event_criteria' => 'unvoidedEventCriteria'
    };*/
    Map<String, String> propertyMappings = new Map<String, String>{
      'reference_id' => 'referenceId',
      'sequence_id' => 'sequenceId',
      'unvoided_event_criteria' => 'unvoidedEventCriteria'
    };

    public Map<String, String> getPropertyMappings() {
      return propertyMappings;
    }
  }
  /**
   * Represents the usage mode.
   */
  public enum GTVAPIUsageMode {
    FAIL_ON_EXISTING,
    OVERWRITE_ON_EXISTING
  }

  /**
   * Creates Usage Events in bulk. Through the API, you can submit up to 50 usage events in a single request.
   */
  public class GTVAPICreateBulkUsageEvents implements GTVAPIRestClient.MappedProperties {
    /**
     * Get mode
     * @return mode
     */
    public GTVAPIUsageMode mode { get; set; }

    /**
     * Get usageEvents
     * @return usageEvents
     */
    public List<GTVAPICreateUsageEvent> usageEvents { get; set; }

    /* private final Map<String, String> propertyMappings = new Map<String, String>{
        'usage_events' => 'usageEvents'
    };*/

    public Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'usage_events' => 'usageEvents'
      };
      return propertyMappings;
    }

    public GTVAPICreateBulkUsageEvents() {
      usageEvents = new List<GTVAPICreateUsageEvent>();
    }
  }

  /**
   * Creates the Bulk Void Usage Events entity.
   */
  public class GTVAPICreateBulkVoidUsageEvents implements GTVAPIRestClient.MappedProperties {
    /**
     * Get mode
     * @return mode
     */
    public GTVAPIVoidUsageMode mode { get; set; }

    /**
     * Get voidEventCriterias
     * @return voidEventCriterias
     */
    public List<GTVAPICreateVoidUsageEventCriteria> voidEventCriterias {
      get;
      set;
    }

    /* private final Map<String, String> propertyMappings = new Map<String, String>{
        'void_event_criterias' => 'voidEventCriterias'
    };
*/
    public Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'void_event_criterias' => 'voidEventCriterias'
      };
      return propertyMappings;
    }

    public GTVAPICreateBulkVoidUsageEvents() {
      voidEventCriterias = new List<GTVAPICreateVoidUsageEventCriteria>();
    }
  }
  /**
   * Represents the void usage mode.
   */
  public enum GTVAPIVoidUsageMode {
    ID,
    REF_SEQ
  }

  /**
   * Creates the Void Bulk Usage Events entity.
   */
  public class GTVAPICreateVoidUsageEventCriteria implements GTVAPIRestClient.MappedProperties {
    /**
     * The unique identity number assigned to all entities in core that is generated by the system.
     * @return id
     */
    public String id { get; set; }

    /**
     * The reference ID can be set from an external system and should be a unique value. It is used to ensure that duplicate usage events are not posted to Gotransverse core.
     * @return referenceId
     */
    public String referenceId { get; set; }

    /**
     * The sequence ID can be set from an external system and should be a unique value. It is used to ensure that duplicate usage events are not posted to Gotransverse core.
     * @return sequenceId
     */
    public String sequenceId { get; set; }

    /* private final Map<String, String> propertyMappings = new Map<String, String>{
        'reference_id' => 'referenceId',
        'sequence_id' => 'sequenceId'
    };*/

    public Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'reference_id' => 'referenceId',
        'sequence_id' => 'sequenceId'
      };
      return propertyMappings;
    }
  }

  /**
   * A representation of the core Price List entity. Price list is optional and is used with marketplaces to define multiple prices for the same product that is sold to different markets.
   */
  public class GTVAPIPriceList extends GTVAPIEntity {
    /**
     * (unique_key) The ID of the entity.
     * @return id
     */
    public String id { get; private set; }

    /**
     * The name of this price list.
     * @return name
     */
    public String name { get; set; }

    /**
     * The description of this price list.
     * @return description
     */
    public String description { get; set; }
  }

  /**
   * A representation of the core Service Custom Field entity. It is associated with products sold during the order process.
   */
  public class GTVAPIServiceCustomField extends GTVAPICustomField implements GTVAPIRestClient.MappedProperties {
    /*private final Map<String, String> propertyMappings = new Map<String, String>{
        'custom_field_type' => 'customFieldType',
        'reg_ex' => 'regEx',
        'field_type' => 'fieldType',
        'field_validation_type' => 'fieldValidationType'
    };
*/
    public override Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'custom_field_type' => 'customFieldType',
        'reg_ex' => 'regEx',
        'field_type' => 'fieldType',
        'field_validation_type' => 'fieldValidationType'
      };
      return propertyMappings;
    }

    public GTVAPIServiceCustomField() {
    }
  }
  /**
   * A representation of the core Order Custom Field entity. It is associated with the order at the time the order is created.
   */
  public class GTVAPIOrderCustomField extends GTVAPICustomField implements GTVAPIRestClient.MappedProperties {
    /*  private final Map<String, String> propertyMappings = new Map<String, String>{
        'custom_field_type' => 'customFieldType',
        'reg_ex' => 'regEx',
        'field_type' => 'fieldType',
        'field_validation_type' => 'fieldValidationType'
    };*/

    public override Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'custom_field_type' => 'customFieldType',
        'reg_ex' => 'regEx',
        'field_type' => 'fieldType',
        'field_validation_type' => 'fieldValidationType'
      };
      return propertyMappings;
    }

    public GTVAPIOrderCustomField() {
    }
  }
  /**
   * An object used to add a service address to an existing service.
   */
  public class GTVAPIAddServiceAddress extends GTVAPICommand implements GTVAPIRestClient.ReverseMappedProperties {
    /**
     * Get address
     * @return address
     */
    public GTVAPICreatePostalAddress address { get; set; }

    public Map<String, String> getReversePropertyMappings() {
      Map<String, String> reversePropertyMappings = new Map<String, String>{
        'regionOrState' => 'region_or_state',
        'postalCode' => 'postal_code'
      };
      return reversePropertyMappings;
    }
  }

  /**
   * An object used to add a new or existing service resource to an existing service.
   */
  public class GTVAPIAddServiceResource implements GTVAPIRestClient.MappedProperties, GTVAPIRestClient.ReverseMappedProperties {
    /**
     * Get serviceResource
     * @return serviceResource
     */
    public GTVAPICreateOrAddServiceResource serviceResource { get; set; }

    /**
     * The date when the service resource becomes valid in the service.
     * @return effectiveDate
     */
    public Date effectiveDate { get; set; }

    /*  private final Map<String, String> propertyMappings = new Map<String, String>{
        'service_resource' => 'serviceResource',
        'effective_date' => 'effectiveDate'
    };
    private final Map<String, String> reversePropertyMappings = new Map<String, String>{
        'serviceResource' => 'service_resource',
        'effectiveDate' => 'effective_date'
    };*/

    public Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'service_resource' => 'serviceResource',
        'effective_date' => 'effectiveDate'
      };
      return propertyMappings;
    }
    public Map<String, String> getReversePropertyMappings() {
      Map<String, String> reversePropertyMappings = new Map<String, String>{
        'serviceResource' => 'service_resource',
        'effectiveDate' => 'effective_date'
      };
      return reversePropertyMappings;
    }
  }

  /**
   * Imports the bulk of service resources.
   */
  public class GTVAPIImportBulkServiceResources implements GTVAPIRestClient.MappedProperties {
    /**
     * Get serviceResources
     * @return serviceResources
     */
    public List<GTVAPIAddServiceResource> serviceResources { get; set; }

    /* private final Map<String, String> propertyMappings = new Map<String, String>{
        'service_resources' => 'serviceResources'
    };
*/
    public Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'service_resources' => 'serviceResources'
      };
      return propertyMappings;
    }

    public GTVAPIImportBulkServiceResources() {
      serviceResources = new List<GTVAPIAddServiceResource>();
    }
  }
  /**
   * Deactivates an existing service and creates a new order. This links the existing service to the new services created in the order.
   */
  public class GTVAPIChangeService extends GTVAPICommand implements GTVAPIRestClient.MappedProperties, GTVAPIRestClient.ReverseMappedProperties {
    /**
     * Specifies whether the agreement is preserved after the service change.
     * @return preserveAgreement
     */
    public Boolean preserveAgreement { get; set; }

    /**
     * The date when the new order is placed.
     * @return effectiveDate
     */
    public Datetime effectiveDate { get; set; }

    /**
     * Get order
     * @return order
     */
    public GTVAPICreateSalesOrder order { get; set; }

    /* private final Map<String, String> propertyMappings = new Map<String, String>{
        'preserve_agreement' => 'preserveAgreement',
        'effective_date' => 'effectiveDate'
    };
*/
    public Map<String, Object> getPropertyMappings() {
      Map<String, Object> propertyMappings = new Map<String, Object>{
        'preserve_agreement' => 'preserveAgreement',
        'effective_date' => 'effectiveDate',
        'order' => new List<String>{ 'order', 'GTVAPICreateSalesOrder' }
      };
      return propertyMappings;
    }

    public Map<String, Object> getReversePropertyMappings() {
      Map<String, Object> reversePropertyMappings = new Map<String, Object>{
        'order' => new List<String>{ 'order', 'GTVAPICreateSalesOrder' }
      };
      return reversePropertyMappings;
    }
  }
  /**
   * Changes the quantity of the service.
   */
  public class GTVAPIChangeServiceQuantity extends GTVAPICommand implements GTVAPIRestClient.MappedProperties, GTVAPIRestClient.ReverseMappedProperties {
    /**
     * The new quantity of the service.
     * @return newQuantity
     */
    public Double newQuantity { get; set; }

    /**
     * The date when the service change becomes effective.
     * @return effectiveDate
     */
    public Date effectiveDate { get; set; }

    /* private final Map<String, String> propertyMappings = new Map<String, String>{
        'new_quantity' => 'newQuantity',
        'effective_date' => 'effectiveDate'
    };
*/
    public Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'new_quantity' => 'newQuantity',
        'effective_date' => 'effectiveDate'
      };
      return propertyMappings;
    }

    public Map<String, String> getReversePropertyMappings() {
      Map<String, String> reversePropertyMappings = new Map<String, String>{
        'newQuantity' => 'new_quantity',
        'effectiveDate' => 'effective_date'
      };
      return reversePropertyMappings;
    }
  }

  /**
   * Creates a new Agreement Service.
   */
  public class GTVAPICreateAgreementService extends GTVAPICreateAgreementServiceObject implements GTVAPIRestClient.MappedProperties {
    /**
     * Get agreement
     * @return agreement
     */
    public GTVAPIAgreementRef agreement { get; set; }

    /**
     * The date when the order item agreement ends.
     * @return endDate
     */
    public Datetime endDate { get; set; }

    /**
     * Get endAction
     * @return endAction
     */
    public GTVAPIAgreementEndActionType endAction { get; set; }

    /**
     * Get nextAgreement
     * @return nextAgreement
     */
    public GTVAPIAgreementRef nextAgreement { get; set; }

    /**
     * Get nextEndAction
     * @return nextEndAction
     */
    public GTVAPIAgreementNextEndActionType nextEndAction { get; set; }

    /**
     * Get nextServiceProduct
     * @return nextServiceProduct
     */
    public GTVAPIProductRef nextServiceProduct { get; set; }

    /**
     * Get nextServiceProductPrice
     * @return nextServiceProductPrice
     */
    public GTVAPIProductRecurringPriceRef nextServiceProductPrice { get; set; }

    /**
     * Specifies whether the price of the renewed service will be the same as the original service price.
     * @return preserveServicePrice
     */
    public Boolean preserveServicePrice { get; set; }

    /**
     * Get nextPreserveServicePrice
     * @return nextPreserveServicePrice
     */
    public Boolean nextPreserveServicePrice { get; set; }

    /**
     * The length of the agreement.
     * @return agreementPeriod
     */
    public Integer agreementPeriod { get; set; }

    /**
     * The minimum change for the agreement, used for true up charges.
     * @return minimumAmount
     */
    public Double minimumAmount { get; set; }

    /**
     * Specifies whether the minimum amount that is minimum change for the agreement is omitted. If set to true, the minimum amount of the agreement is not taken into account. If set to false, the minimum amount is applied to the agreement service.\n
     * @return omitMinimumAmount
     */
    public Boolean omitMinimumAmount { get; set; }

    /**
     * Get trueUpChargeTypes
     * @return trueUpChargeTypes
     */
    public List<GTVAPITrueUpChargeType> trueUpChargeTypes { get; set; }

    /**
     * The date when agreement starts.
     * @return startDate
     */
    public Datetime startDate { get; set; }

    /*   private final Map<String, String> propertyMappings = new Map<String, String>{
        'end_date' => 'endDate',
        'end_action' => 'endAction',
        'next_agreement' => 'nextAgreement',
        'next_end_action' => 'nextEndAction',
        'next_service_product' => 'nextServiceProduct',
        'next_service_product_price' => 'nextServiceProductPrice',
        'preserve_service_price' => 'preserveServicePrice',
        'next_preserve_service_price' => 'nextPreserveServicePrice',
        'agreement_period' => 'agreementPeriod',
        'minimum_amount' => 'minimumAmount',
        'omit_minimum_amount' => 'omitMinimumAmount',
        'true_up_charge_types' => 'trueUpChargeTypes',
        'start_date' => 'startDate'
    };
*/
    public override Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'end_date' => 'endDate',
        'end_action' => 'endAction',
        'next_agreement' => 'nextAgreement',
        'next_end_action' => 'nextEndAction',
        'next_service_product' => 'nextServiceProduct',
        'next_service_product_price' => 'nextServiceProductPrice',
        'preserve_service_price' => 'preserveServicePrice',
        'next_preserve_service_price' => 'nextPreserveServicePrice',
        'agreement_period' => 'agreementPeriod',
        'minimum_amount' => 'minimumAmount',
        'omit_minimum_amount' => 'omitMinimumAmount',
        'true_up_charge_types' => 'trueUpChargeTypes',
        'start_date' => 'startDate'
      };
      return propertyMappings;
    }

    public GTVAPICreateAgreementService() {
      trueUpChargeTypes = new List<GTVAPITrueUpChargeType>();
    }
  }

  /**
   * A representation of the Bill in Advance Period core enumeration which indicates a period type of the bill in advance additional offset.
   */
  public enum GTVAPIBillInAdvancePeriod {
    BILLCYCLE,
    DAY,
    WEEK,
    MONTH,
    YEAR
  }

  /**
   * Represents Bill in advance configurations such as a period type of the bill in advance additional offset and a number of these periods.
   */
  public class GTVAPIBillInAdvanceConfiguration {
    /**
     * The number of additional bill in advance periods.
     * @return amount
     */
    public Integer amount { get; set; }

    /**
     * Get period
     * @return period
     */
    public String period { get; set; }
  }
  /**
   * Indicates a type of the price range (tier). It can be either an order item, a product, or a service.
   */
  public enum GTVAPIPriceRangeType {
    ORDER_ITEM,
    PRODUCT,
    SERVICE
  }

  /**
   * Creates the Price Range core entity.
   */
  public virtual class GTVAPICreatePriceRange extends GTVAPICreateEntity implements GTVAPIRestClient.MappedProperties, GTVAPIRestClient.ReverseMappedProperties {
    /**
     * Get priceRangeType
     * @return priceRangeType
     */
    public String priceRangeType { get; set; }

    /**
     * The first number in the range (tier). For example, if the range (tier) is 4-7 for $79.99 each, then the first number in the range (tier) is "4."
     * @return quantityBeginRange
     */
    public Double quantityBeginRange { get; set; }

    /**
     * The last number in the range (tier). For example, if the range (tier) is 4-7 for $79.99 each, then the last number in the range (tier) is "7."
     * @return quantityEndRange
     */
    public Double quantityEndRange { get; set; }

    /**
     * The price of the product for this tier.
     * @return price
     */
    public Double price { get; set; }

    /*  private final Map<String, String> propertyMappings = new Map<String, String>{
        'price_range_type' => 'priceRangeType',
        'quantity_begin_range' => 'quantityBeginRange',
        'quantity_end_range' => 'quantityEndRange'
    };*/

    public virtual Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'price_range_type' => 'priceRangeType',
        'quantity_begin_range' => 'quantityBeginRange',
        'quantity_end_range' => 'quantityEndRange'
      };
      return propertyMappings;
    }

    public Map<String, String> getReversePropertyMappings() {
      Map<String, String> reversePropertyMappings = new Map<String, String>{
        'priceRangeType' => 'price_range_type',
        'quantityBeginRange' => 'quantity_begin_range',
        'quantityEndRange' => 'quantity_end_range'
      };
      return reversePropertyMappings;
    }
  }

  /**
   * Creates the core Price entity.
   */
  public virtual class GTVAPICreatePrice extends GTVAPICreateEntity implements GTVAPIRestClient.MappedProperties, GTVAPIRestClient.ReverseMappedProperties {
    /**
     * Get priceType
     * @return priceType
     */
    public GTVAPIPriceType priceType { get; set; }

    /* private final Map<String, String> propertyMappings = new Map<String, String>{
        'price_type' => 'priceType'
    };*/

    public virtual Map<String, Object> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'price_type' => 'priceType'
      };
      return propertyMappings;
    }

    public virtual Map<String, Object> getReversePropertyMappings() {
      Map<String, String> reversePropertyMappings = new Map<String, String>{
        'priceType' => 'price_type'
      };
      return reversePropertyMappings;
    }
  }

  /**
   * Creates the Service Price Range entity.
   */
  public class GTVAPICreateServicePriceRange extends GTVAPICreatePriceRange implements GTVAPIRestClient.MappedProperties {
    /*  private final Map<String, String> propertyMappings = new Map<String, String>{
        'price_range_type' => 'priceRangeType',
        'quantity_begin_range' => 'quantityBeginRange',
        'quantity_end_range' => 'quantityEndRange'
    };
*/
    public override Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'price_range_type' => 'priceRangeType',
        'quantity_begin_range' => 'quantityBeginRange',
        'quantity_end_range' => 'quantityEndRange'
      };
      return propertyMappings;
    }
  }
  /**
   * Creates the core Service Price entity. amount and ranges (tiers) are mutually exclusive.
   */
  public class GTVAPICreateServicePrice extends GTVAPICreatePrice implements GTVAPIRestClient.MappedProperties {
    /**
     * The ranges (tiers) for the service prices.
     * @return ranges
     */
    public List<GTVAPICreateServicePriceRange> ranges { get; set; }

    /**
     * Specifies whether to prorate the price based on cancellation.
     * @return prorateOnCancel
     */
    public Boolean prorateOnCancel { get; set; }

    /**
     * Specifies whether the customer is charged before the service period begins, and then before each service period afterward.
     * @return billInAdvance
     */
    public Boolean billInAdvance { get; set; }

    /**
     * Get billInAdvanceConfiguration
     * @return billInAdvanceConfiguration
     */
    public GTVAPIBillInAdvanceConfiguration billInAdvanceConfiguration {
      get;
      set;
    }
    /*
    private final Map<String, String> propertyMappings = new Map<String, String>{
        'price_type' => 'priceType',
        'prorate_on_cancel' => 'prorateOnCancel',
        'bill_in_advance' => 'billInAdvance',
        'bill_in_advance_configuration' => 'billInAdvanceConfiguration'
    };
*/
    public override Map<String, Object> getPropertyMappings() {
      Map<String, Object> propertyMappings = new Map<String, Object>{
        'price_type' => 'priceType',
        'prorate_on_cancel' => 'prorateOnCancel',
        'bill_in_advance' => 'billInAdvance',
        'bill_in_advance_configuration' => 'billInAdvanceConfiguration'
      };
      return propertyMappings;
    }

    public GTVAPICreateServicePrice() {
      ranges = new List<GTVAPICreateServicePriceRange>();
    }
  }
  /**
   * A discriminator value that specifies the type of the discount code.
   */
  public enum GTVAPIDiscountCodeType {
    SERVICE
  }

  /**
   * A base entity for creating a Discount Code associated with another entity.
   */
  public virtual class GTVAPICreateDiscountCodeEntityRelation extends GTVAPICreateEntity implements GTVAPIRestClient.MappedProperties {
    /**
     * Get discountCodeType
     * @return discountCodeType
     */
    public GTVAPIDiscountCodeType discountCodeType { get; set; }

    /**
     * Get discountResource
     * @return discountResource
     */
    public GTVAPIDiscountResourceRef discountResource { get; set; }

    /**
     * The amount of the discount.
     * @return amount
     */
    public Double amount { get; set; }

    /**
     * The percentage of the discount.
     * minimum: 0
     * maximum: 100.0
     * @return percentage
     */
    public Double percentage { get; set; }

    /**
     * The number of service periods to which the discount is applied on the related service.
     * @return duration
     */
    public Integer duration { get; set; }

    /**
     * The date and time when this discount becomes active on the related service.
     * @return validFrom
     */
    public Datetime validFrom { get; set; }

    /*private final Map<String, String> propertyMappings = new Map<String, String>{
        'discount_code_type' => 'discountCodeType',
        'discount_resource' => 'discountResource',
        'valid_from' => 'validFrom'
    };
*/
    public virtual Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'discount_code_type' => 'discountCodeType',
        'discount_resource' => 'discountResource',
        'valid_from' => 'validFrom'
      };
      return propertyMappings;
    }
  }

  /**
   * Creates the association between the discount resource, discount code, and a service.
   */
  public class GTVAPICreateDiscountCodeService extends GTVAPICreateDiscountCodeEntityRelation implements GTVAPIRestClient.MappedProperties {
    /*  private final Map<String, String> propertyMappings = new Map<String, String>{
        'discount_code_type' => 'discountCodeType',
        'discount_resource' => 'discountResource',
        'valid_from' => 'validFrom'
    };
*/
    public override Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'discount_code_type' => 'discountCodeType',
        'discount_resource' => 'discountResource',
        'valid_from' => 'validFrom'
      };
      return propertyMappings;
    }
  }
  /**
   * Changes the Quantity of the specified Service.
   */
  public class GTVAPICreateQuantityChange extends GTVAPICreateEntity implements GTVAPIRestClient.MappedProperties {
    /**
     * The date when the service change becomes effective. The date can not be after last quantity change effective date.
     * @return effectiveDate
     */
    public Datetime effectiveDate { get; set; }

    /**
     * The new quantity of the service.
     * @return quantity
     */
    public Double quantity { get; set; }
    /*
    private final Map<String, String> propertyMappings = new Map<String, String>{
        'effective_date' => 'effectiveDate'
    };
*/
    public Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'effective_date' => 'effectiveDate'
      };
      return propertyMappings;
    }
  }

  /**
   * Creates a new service custom field value.
   */
  public class GTVAPICreateServiceCustomFieldValue extends GTVAPICreateCustomFieldValue implements GTVAPIRestClient.MappedProperties {
    /**
     * Get customField
     * @return customField
     */
    public GTVAPIServiceCustomFieldRef customField { get; set; }
    /*
    private final Map<String, String> propertyMappings = new Map<String, String>{
        'custom_field_value_type' => 'customFieldValueType',
        'custom_field' => 'customField'
    };
*/
    public override Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'custom_field_value_type' => 'customFieldValueType',
        'custom_field' => 'customField'
      };
      return propertyMappings;
    }
  }
  /**
   * Defines the Usage Rate types.
   */
  public enum GTVAPIUsageRateType {
    FLAT,
    PASS_THROUGH,
    TABLE
  }

  /**
   * Creates the Usage Rate entity.
   */
  public class GTVAPICreateUsageRate extends GTVAPICreateEntity implements GTVAPIRestClient.MappedProperties {
    /**
     * Get rateType
     * @return rateType
     */
    public String rateType { get; set; }

    /**
     * The date and time from when this usage rate is valid.
     * @return validFrom
     */
    public Datetime validFrom { get; set; }

    /**
     * The date and time until when this usage rate is valid.
     * @return validTo
     */
    public Datetime validTo { get; set; }
    /**
     * The uom until when this usage rate is valid.
     * @return validTo
     */
    public String uom { get; set; }
    /**
     * The rate until when this usage rate is valid.
     * @return validTo
     */
    public Double rate { get; set; }

    /**
     * Get chargeCategory
     * @return chargeCategory
     */
    public GTVAPIUsageChargeCategoryRef chargeCategory { get; set; }
    /**
     * Get usageFieldName
     * @return chargeCategory
     */
    public String usage_field_name { get; set; }
    /**
     * Get usageFieldName
     * @return chargeCategory
     */
    public GTVAPIRateTable rate_table { get; set; }

    /*  private final Map<String, String> propertyMappings = new Map<String, String>{
        'rate_type' => 'rateType',
        'valid_from' => 'validFrom',
        'valid_to' => 'validTo',
        'charge_category' => 'chargeCategory'
    };*/

    public Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'rate_type' => 'rateType',
        'valid_from' => 'validFrom',
        'valid_to' => 'validTo',
        'charge_category' => 'chargeCategory'
      };

      return propertyMappings;
    }
  }

  /**
   * Defines the value types of usage rule specification.
   */
  public enum GTVAPIUsageRuleSpecificationType {
    FORMULA,
    MATCH_ALL
  }
  /**
   * Defines the value types of usage rule specification.
   */
  public enum GTVAPIOperatorType {
    EQUALS,
    NOT_EQUALS,
    GREATER_THAN,
    GREATER_THAN_EQUALS,
    LESS_THAN,
    LESS_THAN_EQUALS,
    LOOKUP
  }

  /**
   * Creates the Usage Rule Specification entity.
   */
  public class GTVAPICreateUsageRuleSpecification extends GTVAPICreateEntity implements GTVAPIRestClient.MappedProperties {
    /**
     * Get usageRuleSpecificationType
     * @return usageRuleSpecificationType
     */
    public String usageRuleSpecificationType { get; set; }
    /**
     * Get operator
     * @return operator
     */
    public String operator { get; set; }
    /**
     * Get name
     * @return name
     */
    public String name { get; set; }
    /**
     * Get usageRuleSpecificationType
     * @return usageRuleSpecificationType
     */
    public String field_name { get; set; }
    /**
     * Get usageRuleSpecificationType
     * @return usageRuleSpecificationType
     */
    public String field_value { get; set; }

    /* private final Map<String, String> propertyMappings = new Map<String, String>{
        'usage_rule_specification_type' => 'usageRuleSpecificationType'
    };*/

    public Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'usage_rule_specification_type' => 'usageRuleSpecificationType'
      };
      return propertyMappings;
    }
  }
  /**
   * Creates the Usage Rule Template entity.
   */
  public virtual class GTVAPICreateUsageRuleTemplate extends GTVAPICreateEntity implements GTVAPIRestClient.MappedProperties, GTVAPIRestClient.ReverseMappedProperties {
    /**
     * Get usageRuleType
     * @return usageRuleType
     */
    public String usageRuleType { get; set; }

    /**
     * (unique_key) The name of this usage rule template.
     * @return name
     */
    public String name { get; set; }

    /**
     * Defines the maximum available allowances.
     * @return allowanceAmount
     */
    public Double allowanceAmount { get; set; }

    /**
     * Get allowanceUom
     * @return allowanceUom
     */
    public GTVAPIUsageDurationUom allowanceUom { get; set; }

    /**
     * Get allowanceType
     * @return allowanceType
     */
    public GTVAPIAllowanceType allowanceType { get; set; }

    /**
     * The order in which usage rules are evaluated.
     * @return ruleOrder
     */
    public Integer ruleOrder { get; set; }

    /**
     * Specifies whether the usage rule template is prorated upon ordering.
     * @return proratedOnOrder
     */
    public Boolean proratedOnOrder { get; set; }

    /**
     * Specifies whether the usage rule template is prorated upon cancellation.
     * @return proratedOnCancel
     */
    public Boolean proratedOnCancel { get; set; }

    /**
     * Get rollOverType
     * @return rollOverType
     */
    public GTVAPIRollOverType rollOverType { get; set; }

    /**
     * The date and time from when this usage rule template is valid.
     * @return validFrom
     */
    public String validFrom { get; set; }

    /**
     * The date and time until when this usage rule template is valid.
     * @return validTo
     */
    public String validTo { get; set; }

    /**
     * Get ruleType
     * @return ruleType
     */
    public GTVAPIRuleType ruleType { get; set; }

    /**
     * Get usageRate
     * @return usageRate
     */
    public GTVAPICreateUsageRate usageRate { get; set; }

    /**
     * Get spec
     * @return spec
     */
    public GTVAPICreateUsageRuleSpecification spec { get; set; }
    /**
     * Get status
     * @return spec
     */
    public GTVAPIServiceUsageRuleStatus status { get; set; }

    /*  private final Map<String, String> propertyMappings = new Map<String, String>{
        'usage_rule_type' => 'usageRuleType',
        'allowance_amount' => 'allowanceAmount',
        'allowance_uom' => 'allowanceUom',
        'allowance_type' => 'allowanceType',
        'rule_order' => 'ruleOrder',
        'prorated_on_order' => 'proratedOnOrder',
        'prorated_on_cancel' => 'proratedOnCancel',
        'roll_over_type' => 'rollOverType',
        'valid_from' => 'validFrom',
        'valid_to' => 'validTo',
        'rule_type' => 'ruleType',
        'usage_rate' => 'usageRate'
    };
*/
    public virtual Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'usage_rule_type' => 'usageRuleType',
        'allowance_amount' => 'allowanceAmount',
        'allowance_uom' => 'allowanceUom',
        'allowance_type' => 'allowanceType',
        'rule_order' => 'ruleOrder',
        'prorated_on_order' => 'proratedOnOrder',
        'prorated_on_cancel' => 'proratedOnCancel',
        'roll_over_type' => 'rollOverType',
        'valid_from' => 'validFrom',
        'valid_to' => 'validTo',
        'rule_type' => 'ruleType',
        'usage_rate' => 'usageRate',
        'rate_type' => 'rateType'
      };
      return propertyMappings;
    }
    public virtual Map<String, String> getReversePropertyMappings() {
      Map<String, String> reversePropertyMappings = new Map<String, String>{
        'usageRuleType' => 'usage_rule_type',
        'allowanceAmount' => 'allowance_amount',
        'allowanceUom' => 'allowance_uom',
        'allowanceType' => 'allowance_type',
        'ruleOrder' => 'rule_order',
        'proratedOnOrder' => 'prorated_on_order',
        'proratedOnCancel' => 'prorated_on_cancel',
        'rollOverType' => 'roll_over_type',
        'validFrom' => 'valid_from',
        'validTo' => 'valid_to',
        'ruleType' => 'rule_type',
        'usageRate' => 'usage_rate',
        'rateType' => 'rate_type',
        'status' => 'status'
      };
      return reversePropertyMappings;
    }
  }

  /**
   * Creates a new Service Usage Rule entity.
   */
  public class GTVAPICreateServiceUsageRule extends GTVAPICreateUsageRuleTemplate implements GTVAPIRestClient.MappedProperties, GTVAPIRestClient.ReverseMappedProperties {
    /**
     * Get status
     * @return status
     */
    public GTVAPIServiceUsageRuleStatus status { get; set; }

    /*  private final Map<String, String> propertyMappings = new Map<String, String>{
        'usage_rule_type' => 'usageRuleType',
        'allowance_amount' => 'allowanceAmount',
        'allowance_uom' => 'allowanceUom',
        'allowance_type' => 'allowanceType',
        'rule_order' => 'ruleOrder',
        'prorated_on_order' => 'proratedOnOrder',
        'prorated_on_cancel' => 'proratedOnCancel',
        'roll_over_type' => 'rollOverType',
        'valid_from' => 'validFrom',
        'valid_to' => 'validTo',
        'rule_type' => 'ruleType',
        'usage_rate' => 'usageRate'
    };
    private final Map<String, String> reversePropertyMappings = new Map<String, String>{
        'usageRuleType' => 'usage_rule_type',
        'allowanceAmount' => 'allowance_amount',
        'allowanceUom' => 'allowance_uom',
        'allowanceType' => 'allowance_type',
        'ruleOrder' => 'rule_order',
        'proratedOnOrder' => 'prorated_on_order',
        'proratedOnCancel' => 'prorated_on_cancel',
        'rollOverType' => 'roll_over_type',
        'validFrom' => 'valid_from',
        'validTo' => 'valid_to',
        'ruleType' => 'rule_type',
        'usageRate' => 'usage_rate'
    };
*/
    public override Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'usage_rule_type' => 'usageRuleType',
        'allowance_amount' => 'allowanceAmount',
        'allowance_uom' => 'allowanceUom',
        'allowance_type' => 'allowanceType',
        'rule_order' => 'ruleOrder',
        'prorated_on_order' => 'proratedOnOrder',
        'prorated_on_cancel' => 'proratedOnCancel',
        'roll_over_type' => 'rollOverType',
        'valid_from' => 'validFrom',
        'valid_to' => 'validTo',
        'rule_type' => 'ruleType',
        'usage_rate' => 'usageRate',
        'rate_type' => 'rateType',
        'usage_rule_specification_type' => 'usageRuleSpecificationType',
        'charge_category' => 'chargeCategory',
        'charge_category_type' => 'chargeCategoryType'
      };
      return propertyMappings;
    }
    public override Map<String, String> getReversePropertyMappings() {
      Map<String, String> reversePropertyMappings = new Map<String, String>{
        'usageRuleType' => 'usage_rule_type',
        'allowanceAmount' => 'allowance_amount',
        'allowanceUom' => 'allowance_uom',
        'allowanceType' => 'allowance_type',
        'ruleOrder' => 'rule_order',
        'proratedOnOrder' => 'prorated_on_order',
        'proratedOnCancel' => 'prorated_on_cancel',
        'rollOverType' => 'roll_over_type',
        'validFrom' => 'valid_from',
        'validTo' => 'valid_to',
        'ruleType' => 'rule_type',
        'usageRate' => 'usage_rate',
        'rateType' => 'rate_type',
        'usageRuleSpecificationType' => 'usage_rule_specification_type',
        'chargeCategory' => 'charge_category',
        'chargeCategoryType' => 'charge_category_type'
      };
      return reversePropertyMappings;
    }
  }
  /**
   * Indicates the type of the reason. It can be of the billing-account, service, payment, or invoice type.
   */
  public enum GTVAPIReasonType {
    BILLING_ACCOUNT,
    SERVICE,
    PAYMENT,
    INVOICE
  }
  /**
   * A reference to the Reason core entity.
   */
  public virtual class GTVAPIReasonRef extends GTVAPIEntityRef implements GTVAPIRestClient.MappedProperties {
    /**
     * (unique_key) The ID of the entity.
     * @return id
     */
    // public String id { get; set; }

    /**
     * Get reasonEntityType
     * @return reasonEntityType
     */
    public GTVAPIReasonType reasonEntityType { get; set; }

    /**
     * (unique_key) The name of the reason.
     * @return name
     */
    public String name { get; set; }

    /*  private final Map<String, String> propertyMappings = new Map<String, String>{
        'reason_entity_type' => 'reasonEntityType'
    };
*/
    public virtual Map<String, Object> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'reason_entity_type' => 'reasonEntityType'
      };
      return propertyMappings;
    }
  }
  /**
   * A reference to the Service Reason core entity.
   */
  public virtual class GTVAPIServiceReasonRef extends GTVAPIReasonRef implements GTVAPIRestClient.MappedProperties {
    /**
     * Get reasonType
     * @return reasonType
     */
    public String reasonType { get; set; }

    /*private final Map<String, String> propertyMappings = new Map<String, String>{
        'reason_entity_type' => 'reasonEntityType',
        'reason_type' => 'reasonType'
    };*/

    public virtual override Map<String, Object> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'reason_entity_type' => 'reasonEntityType',
        'reason_type' => 'reasonType'
      };
      return propertyMappings;
    }
  }
  /**
   * A reference to the Service Deactivation Reason core entity.
   */
  public class GTVAPIServiceDeactivationReasonRef extends GTVAPIServiceReasonRef implements GTVAPIRestClient.MappedProperties {
    /* private final Map<String, String> propertyMappings = new Map<String, String>{
        'reason_entity_type' => 'reasonEntityType',
        'reason_type' => 'reasonType'
    };
*/
    public override Map<String, Object> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'reason_entity_type' => 'reasonEntityType',
        'reason_type' => 'reasonType'
      };

      return propertyMappings;
    }
  }
  /**
   * Deactives an existing service.
   */
  public class GTVAPIDeactivateService extends GTVAPICommand implements GTVAPIRestClient.MappedProperties, GTVAPIRestClient.ReverseMappedProperties {
    /**
     * The date when the service is deactivated.
     * @return effectiveDate
     */
    public String effectiveDate { get; set; }

    /**
     * Get reason
     * @return reason
     */
    public GTVAPIServiceDeactivationReasonRef reason { get; set; }

    /* private final Map<String, String> propertyMappings = new Map<String, String>{
        'effective_date' => 'effectiveDate'
    };
    private final Map<String, String> reversePropertyMappings = new Map<String, String>{
        'effectiveDate' => 'effective_date',
        'reasonType' => 'reason_type'
        
    };*/

    public Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'effective_date' => 'effectiveDate'
      };
      return propertyMappings;
    }
    public Map<String, String> getReversePropertyMappings() {
      Map<String, String> reversePropertyMappings = new Map<String, String>{
        'effectiveDate' => 'effective_date',
        'reasonType' => 'reason_type'
      };
      return reversePropertyMappings;
    }
  }

  /**
   * A representation of the core Price Range entity. It specifies the price range (tier) for tiered or tapered pricing.
   */
  public virtual class GTVAPIPriceRange extends GTVAPIEntity implements GTVAPIRestClient.MappedProperties {
    /**
     * (unique_key) The ID of the entity.
     * @return id
     */
    public String id { get; private set; }

    /**
     * Get priceRangeType
     * @return priceRangeType
     */
    public GTVAPIPriceRangeType priceRangeType { get; set; }

    /**
     * The first number in the range (tier). For example, if the range (tier) is 4-7 for $79.99 each, then the first number in the range (tier) is "4."
     * @return quantityBeginRange
     */
    public Double quantityBeginRange { get; set; }

    /**
     * The last number in the range (tier). For example, if the range (tier) is 4-7 for $79.99 each, then the last number in the range (tier) is "7."
     * @return quantityEndRange
     */
    public Double quantityEndRange { get; set; }

    /**
     * The price of the product for this tier.
     * @return price
     */
    public Double price { get; set; }

    /**
     * Get currencyCode
     * @return currencyCode
     */
    public GTVAPICurrencyCode currencyCode { get; set; }

    /*   private final Map<String, String> propertyMappings = new Map<String, String>{
        'price_range_type' => 'priceRangeType',
        'quantity_begin_range' => 'quantityBeginRange',
        'quantity_end_range' => 'quantityEndRange',
        'currency_code' => 'currencyCode'
    };
*/
    public virtual Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'price_range_type' => 'priceRangeType',
        'quantity_begin_range' => 'quantityBeginRange',
        'quantity_end_range' => 'quantityEndRange',
        'currency_code' => 'currencyCode'
      };
      return propertyMappings;
    }
  }
  /**
   * A representation of the core Service Price Range entity. It is the price range (tier) for the service as it was sold to a customer. Each service price is one tier per price. For example, customers can buy 1 - 3 of the item and the price for each is $99.99, buy 4 - 7 of the item and the price for each is $79.99, buy 8 - 20 of the item and the price for each is $49.99, and so on.
   */
  public class GTVAPIServicePriceRange extends GTVAPIPriceRange implements GTVAPIRestClient.MappedProperties {
    /*  private final Map<String, String> propertyMappings = new Map<String, String>{
        'price_range_type' => 'priceRangeType',
        'quantity_begin_range' => 'quantityBeginRange',
        'quantity_end_range' => 'quantityEndRange',
        'currency_code' => 'currencyCode'
    };
*/
    public override Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'price_range_type' => 'priceRangeType',
        'quantity_begin_range' => 'quantityBeginRange',
        'quantity_end_range' => 'quantityEndRange',
        'currency_code' => 'currencyCode'
      };
      return propertyMappings;
    }
  }

  /**
   * Indicates a status of the discount. DRAFT status means that the discount is not available to be used. The discount is in the process of being created or is created but has not yet been made available. In case you need to delete the discount in the Draft status, you can do this in the Gotransverse user interface. ACTIVE status means that the discount is available to be used or is currently in use. You can suspend the needed discount in the Gotransverse user interface, but you cannot delete it. SUSPENDED status means that the discount is not in use and can not be selected to be used. In the Gotransverse user interface, you can change the status back to Active, but you cannot delete it.
   */
  public enum GTVAPIDiscountStatus {
    DRAFT,
    ACTIVE,
    SUSPENDED
  }
  /**
   * Indicates a type of the discount. PERCENTAGE discount means that the discount is a percentage of the product price. FLAT discount means that the discount is a flat amount such as $10.00 off the product price.
   */
  public enum GTVAPIDiscountType {
    PERCENTAGE,
    FLAT
  }
  /**
   * A reference to the Discount Category core entity.
   */
  public class GTVAPIDiscountCategoryRef extends GTVAPIEntityRef {
    /**
     * (unique_key) The ID of the entity.
     * @return id
     */
    public String id { get; set; }

    /**
     * (unique_key) The name of the discount category.
     * @return name
     */
    public String name { get; set; }
  }

  /**
   * A representation of the core Discount entity. Discounts are associated with products and are applied at the time of sale. You can apply discounts to any number of service periods as a recurring discount or one-time discount.
   */
  public class GTVAPIDiscount extends GTVAPIEntity implements GTVAPIRestClient.MappedProperties {
    /**
     * (unique_key) The ID of the entity.
     * @return id
     */
    public String id { get; private set; }

    /**
     * The name of the discount.
     * @return name
     */
    public String name { get; private set; }

    /**
     * Get status
     * @return status
     */
    public GTVAPIDiscountStatus status { get; set; }

    /**
     * The description of the discount.
     * @return description
     */
    public String description { get; private set; }

    /**
     * Get discountType
     * @return discountType
     */
    public GTVAPIDiscountType discountType { get; set; }

    /**
     * The amount of the discount applied. The amount of the discount can be specified as a percentage of the service price or as a flat discount, meaning a certain amount of money.
     * @return amount
     */
    public Double amount { get; private set; }

    /**
     * Get currencyCode
     * @return currencyCode
     */
    public GTVAPICurrencyCode currencyCode { get; set; }

    /**
     * The percentage of the discount.
     * @return percentage
     */
    public Double percentage { get; private set; }

    /**
     * The number of service periods to which the discount applies.
     * @return duration
     */
    public Integer duration { get; private set; }

    /**
     * Specifies whether the discount is a one-time charge.
     * @return oneTime
     */
    public Boolean oneTime { get; private set; }

    /**
     * Specifies whether the discount is a recurring charge.
     * @return recurring
     */
    public Boolean recurring { get; private set; }

    /**
     * Get discountCategory
     * @return discountCategory
     */
    public GTVAPIDiscountCategoryRef discountCategory { get; set; }

    /**
     * Specifies whether this discount overrides an amount of the discount.
     * @return amountOverride
     */
    public Boolean amountOverride { get; private set; }

    /**
     * Specifies whether this discount has a duration.
     * @return durationOverride
     */
    public Boolean durationOverride { get; private set; }

    /* private static final Map<String, String> propertyMappings = new Map<String, String>{
        'discount_type' => 'discountType',
        'currency_code' => 'currencyCode',
        'one_time' => 'oneTime',
        'discount_category' => 'discountCategory',
        'amount_override' => 'amountOverride',
        'duration_override' => 'durationOverride'
    };
*/
    public Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'discount_type' => 'discountType',
        'currency_code' => 'currencyCode',
        'one_time' => 'oneTime',
        'discount_category' => 'discountCategory',
        'amount_override' => 'amountOverride',
        'duration_override' => 'durationOverride'
      };
      return propertyMappings;
    }
  }

  /**
   * A reference to the Discount Code core entity.
   */
  public class GTVAPIDiscountCodeRef extends GTVAPIEntityRef {
    /**
     * (unique_key) The ID of the entity.
     * @return id
     */
    public String id { get; set; }

    /**
     * (unique_key) The name of the discount code.
     * @return name
     */
    public String name { get; set; }
  }

  /**
   * Indicates a status of the discount resource. REQUESTED means that the discount resource has been requested but is not yet in use. AVAILABLE means that the discount resource is available to be selected. ACTIVE means that discount resource is in use and has been selected. DEACTIVATED means that discount resource has been deactivated and is not available for use. QUARANTINED means that the discount resource cannot be used until the quarantine period ends, then it moves to Available. USED means that the discount resource was used by customers before the expiry date. EXPIRED means that the discount resource has past the expiry date and now is not available to be used. RESERVED means that the discount resource has been added to an order but the order has erred and has not been completed.
   */
  public enum GTVAPIDiscountResourceStatus {
    REQUESTED,
    AVAILABLE,
    ACTIVE,
    DEACTIVATED,
    QUARANTINED,
    USED,
    EXPIRED,
    RESERVED
  }

  /**
   * A representation of the core Discount Identifier entity. If you use discounts through API, using discount resources is required.
   */
  public class GTVAPIDiscountResource extends GTVAPIGenericResource implements GTVAPIRestClient.MappedProperties {
    /**
     * Get status
     * @return status
     */
    public GTVAPIDiscountResourceStatus status { get; set; }

    /**
     * Specifies whether the discount resource is unlimited. If set to true, the discount resource is unlimited.
     * @return unlimited
     */
    public Boolean unlimited { get; set; }

    /**
     * The amount of the limit, if any.
     * @return r_limit
     */
    public Integer r_limit { get; set; }

    /**
     * The amount of uses the discount resource can have.
     * @return uses
     */
    public Integer uses { get; set; }

    /*private final Map<String, String> propertyMappings = new Map<String, String>{
        'resource_type' => 'resourceType',
        'limit' => 'r_limit'
    };
*/
    public override Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'resource_type' => 'resourceType',
        'limit' => 'r_limit'
      };
      return propertyMappings;
    }
  }

  /**
   * A base entity for the Discount Code Service entity.
   */
  public virtual class GTVAPIDiscountCodeEntityRelation extends GTVAPICreateEntity implements GTVAPIRestClient.MappedProperties {
    /**
     * (unique_key) The ID of the entity.
     * @return id
     */
    public String id { get; private set; }

    /**
     * Get discountCodeType
     * @return discountCodeType
     */
    public GTVAPIDiscountCodeType discountCodeType { get; set; }

    /**
     * Get discountCode
     * @return discountCode
     */
    public GTVAPIDiscountCodeRef discountCode { get; set; }

    /**
     * Get discountResource
     * @return discountResource
     */
    public GTVAPIDiscountResource discountResource { get; set; }

    /**
     * The date and time when the discount code becomes active.
     * @return validFrom
     */
    public Datetime validFrom { get; private set; }

    /**
     * The date and time when the discount code becomes inactive.
     * @return validTo
     */
    public Datetime validTo { get; private set; }

    /**
     * The number of service periods to which the discount code applies.
     * @return duration
     */
    public Integer duration { get; private set; }

    /**
     * The amount of the discount.
     * @return amount
     */
    public Double amount { get; private set; }

    /**
     * The percentage of the discount.
     * minimum: 0
     * maximum: 100.0
     * @return percentage
     */
    public Double percentage { get; private set; }

    /*  private final Map<String, String> propertyMappings = new Map<String, String>{
        'discount_code_type' => 'discountCodeType',
        'discount_code' => 'discountCode',
        'discount_resource' => 'discountResource',
        'valid_from' => 'validFrom',
        'valid_to' => 'validTo'
    };*/

    public virtual Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'discount_code_type' => 'discountCodeType',
        'discount_code' => 'discountCode',
        'discount_resource' => 'discountResource',
        'valid_from' => 'validFrom',
        'valid_to' => 'validTo'
      };

      return propertyMappings;
    }
  }

  /**
   * Indicates the status of the discount code. DRAFT status means that the discount code is being created but has not yet been used. You can edit the details of the discount code as needed. ACTIVE status means that the discount code is active and available to be used. SUSPENDED status means that the discount code currently is not available to be used. Suspended indicates a temporary state.
   */
  public enum GTVAPIDiscountCodeStatus {
    DRAFT,
    ACTIVE,
    SUSPENDED
  }
  /**
   * A reference to the Discount core entity.
   */
  public class GTVAPIDiscountRef extends GTVAPIEntityRef {
    /**
     * (unique_key) The ID of the entity.
     * @return id
     */
    public String id { get; set; }

    public String name { get; set; }
  }

  /**
   * A representation of the core Discount Code entity. It is a code used with the discount.
   */
  public class GTVAPIDiscountCode extends GTVAPIEntity implements GTVAPIRestClient.MappedProperties {
    /**
     * (unique_key) The ID of the entity.
     * @return id
     */
    public String id { get; private set; }

    /**
     * (unique_key) The name of the discount code.
     * @return name
     */
    public String name { get; private set; }

    /**
     * Get status
     * @return status
     */
    public GTVAPIDiscountCodeStatus status { get; set; }

    /**
     * A description of the discount code.
     * @return description
     */
    public String description { get; private set; }

    /**
     * The date and time when the discount code becomes active.
     * @return validFrom
     */
    public Datetime validFrom { get; private set; }

    /**
     * The date and time when the discount code becomes inactive.
     * @return validTo
     */
    public Datetime validTo { get; private set; }

    /**
     * Get discountChargeCategory
     * @return discountChargeCategory
     */
    public GTVAPIChargeCategoryRef discountChargeCategory { get; set; }

    /**
     * Get discount
     * @return discount
     */
    public GTVAPIDiscountRef discount { get; set; }

    /**
     * The amount of the limit, if any.
     * @return r_limit
     */
    public Integer r_limit { get; private set; }

    /**
     * The amount of uses the discount code can have.
     * @return uses
     */
    public Integer uses { get; private set; }

    /**
     * Specifies whether the discount code is unlimited. If set to true, the discount code is unlimited.
     * @return unlimited
     */
    public Boolean unlimited { get; private set; }

    /**
     * Get priceList
     * @return priceList
     */
    public GTVAPIPriceListRef priceList { get; set; }

    /*private final Map<String, String> propertyMappings = new Map<String, String>{
        'valid_from' => 'validFrom',
        'valid_to' => 'validTo',
        'discount_charge_category' => 'discountChargeCategory',
        'limit' => 'r_limit',
        'price_list' => 'priceList'
    };*/

    public Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'valid_from' => 'validFrom',
        'valid_to' => 'validTo',
        'discount_charge_category' => 'discountChargeCategory',
        'limit' => 'r_limit',
        'price_list' => 'priceList'
      };
      return propertyMappings;
    }
  }

  /**
   * A representation of the core Discount Code Service entity. It represents the relation between a discount code and a service.
   */
  public class GTVAPIDiscountCodeService extends GTVAPIDiscountCodeEntityRelation implements GTVAPIRestClient.MappedProperties {
    /**
     * Get service
     * @return service
     */
    public GTVAPIServiceRef service { get; set; }

    /*  private final Map<String, String> propertyMappings = new Map<String, String>{
        'discount_code_type' => 'discountCodeType',
        'discount_code' => 'discountCode',
        'discount_resource' => 'discountResource',
        'valid_from' => 'validFrom',
        'valid_to' => 'validTo'
    };*/

    public override Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'discount_code_type' => 'discountCodeType',
        'discount_code' => 'discountCode',
        'discount_resource' => 'discountResource',
        'valid_from' => 'validFrom',
        'valid_to' => 'validTo'
      };
      return propertyMappings;
    }
  }

  /**
   * Defines reasons for re-rating service periods (marking them as "dirty"). To mark the strategy for re-rating "dirty", you have to select one of the following values in system settings. EDIT when the usage event was edited; VOID when usage event was voided; OUT_OF_ORDER when a new usage event occurred earlier (start date) then the latest usage event; OVERWRITE when the usage event was overwritten (in the OVERWRITE_ON_EXISTING mode), and it impacts other usage events in the same service period; ROLLOVER when the usage rule rollover occurred; ADDON when a new addon with usage rules was added to the service; SPREAD_SHEET_RULE_DIRTY when the complex rule was edited.\n
   */
  public enum GTVAPIRerateStrategy {
    EDIT,
    OUT_OF_ORDER,
    OVERWRITE,
    ROLLOVER,
    ADDON,
    SPREAD_SHEET_RULE_DIRTY
  }

  /**
   * A reference to the core Usage Event entity.
   */
  public class GTVAPIUsageEventRef {
    /**
     * (unique_key) The ID of the usage event.
     * @return id
     */
    public String id { get; set; }
  }

  /**
   * A representation of the core Service Period dirty cause. It is the reason why this service period is re-rated.
   */
  public class GTVAPIServicePeriodDirtyCause implements GTVAPIRestClient.MappedProperties {
    /**
     * Get reRateStrategy
     * @return reRateStrategy
     */
    public GTVAPIRerateStrategy reRateStrategy { get; set; }

    /**
     * Get usageEvent
     * @return usageEvent
     */
    public GTVAPIUsageEventRef usageEvent { get; set; }

    /**
     * Map with any other supplemental information, if available, that caused the service period to become dirty.
     * @return description
     */
    public Map<String, String> description { get; set; }

    /* private final Map<String, String> propertyMappings = new Map<String, String>{
        're_rate_strategy' => 'reRateStrategy',
        'usage_event' => 'usageEvent'
    };
*/
    public Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        're_rate_strategy' => 'reRateStrategy',
        'usage_event' => 'usageEvent'
      };
      return propertyMappings;
    }

    public GTVAPIServicePeriodDirtyCause() {
      description = new Map<String, String>();
    }
  }

  /**
   * A reference to the core Order Item Usage Rule entity.
   */
  public class GTVAPIOrderItemUsageRuleRef extends GTVAPIUsageRuleTemplateRef implements GTVAPIRestClient.MappedProperties {
    /* private final Map<String, String> propertyMappings = new Map<String, String>{
        'usage_rule_type' => 'usageRuleType'
    };
*/
    public override Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'usage_rule_type' => 'usageRuleType'
      };

      return propertyMappings;
    }
  }
  /**
   * A representation of the core Service Usage Rule entity.
   */
  public class GTVAPIServiceUsageRule extends GTVAPIUsageRuleTemplate implements GTVAPIRestClient.MappedProperties {
    /**
     * Get orderItemUsageRule
     * @return orderItemUsageRule
     */
    public GTVAPIOrderItemUsageRuleRef orderItemUsageRule { get; set; }

    /**
     * Get status
     * @return status
     */
    public GTVAPIServiceUsageRuleStatus status { get; set; }

    /*  private final Map<String, Object> propertyMappings = new Map<String, Object>{
        'usage_rule_type' => 'usageRuleType',
        'allowance_amount' => 'allowanceAmount',
        'allowance_uom' => 'usageUom',
        'allowance_type' => 'allowanceType',
        'rule_order' => 'ruleOrder',
        'prorated_on_order' => 'proratedOnOrder',
        'prorated_on_cancel' => 'proratedOnCancel',
        'roll_over_type' => 'rollOverType',
        'valid_from' => 'validFrom',
        'valid_to' => 'validTo',
        'rule_type' => 'ruleType',
        'usage_rate' => new List<String>{'usageRate','GTVAPIUsageRate'},
        'order_item_usage_rule' => 'orderItemUsageRule'
    };
*/
    public override Map<String, Object> getPropertyMappings() {
      Map<String, Object> propertyMappings = new Map<String, Object>{
        'usage_rule_type' => 'usageRuleType',
        'allowance_amount' => 'allowanceAmount',
        'allowance_uom' => 'usageUom',
        'allowance_type' => 'allowanceType',
        'rule_order' => 'ruleOrder',
        'prorated_on_order' => 'proratedOnOrder',
        'prorated_on_cancel' => 'proratedOnCancel',
        'roll_over_type' => 'rollOverType',
        'valid_from' => 'validFrom',
        'valid_to' => 'validTo',
        'rule_type' => 'ruleType',
        'usage_rate' => new List<String>{ 'usageRate', 'GTVAPIUsageRate' },
        'spec' => new List<String>{
          'spec',
          'GTVAPICreateUsageRuleSpecification'
        },
        'order_item_usage_rule' => 'orderItemUsageRule'
      };

      return propertyMappings;
    }
  }
  /**
   * A representation of the core Service Period entity. Service period is the time period for which charges for a service occur and are billed to a customer billing account. It is used to determine to which billing period a usage event belongs.
   */
  public class GTVAPIServicePeriod extends GTVAPICreateEntity implements GTVAPIRestClient.MappedProperties {
    /**
     * (unique_key) The ID of the entity.
     * @return id
     */
    public String id { get; private set; }

    /**
     * The date and time when the service period started.
     * @return start
     */
    public Datetime start { get; private set; }

    /**
     * The date and time when the service period ended.
     * @return r_end
     */
    public Datetime r_end { get; private set; }

    /**
     * The date and time when the last event in this service period occured.
     * @return lastEventDate
     */
    public Datetime lastEventDate { get; private set; }

    /**
     * Specifies whether the service period is closed.
     * @return closed
     */
    public Boolean closed { get; private set; }

    /**
     * Get service
     * @return service
     */
    public GTVAPIServiceRef service { get; set; }

    /**
     * Specifies whether the re-rate function is enabled. If set to true, the service period is re-rated so that usage charges are current and accurate when they are invoiced. It cannot be updated for a service period that is already closed.
     * @return reRate
     */
    public Boolean reRate { get; set; }

    /**
     * Get reRateCause
     * @return reRateCause
     */
    public GTVAPIServicePeriodDirtyCause reRateCause { get; set; }

    /*    private final Map<String, String> propertyMappings = new Map<String, String>{
        'end' => 'r_end',
        'last_event_date' => 'lastEventDate',
        're_rate' => 'reRate',
        're_rate_cause' => 'reRateCause'
    };*/

    public Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'end' => 'r_end',
        'last_event_date' => 'lastEventDate',
        're_rate' => 'reRate',
        're_rate_cause' => 'reRateCause'
      };

      return propertyMappings;
    }
  }

  /**
   * A reference to the Service Suspension Reason core entity.
   */
  public class GTVAPIServiceSuspensionReasonRef extends GTVAPIServiceReasonRef implements GTVAPIRestClient.MappedProperties {
    /* private final Map<String, String> propertyMappings = new Map<String, String>{
        'reason_entity_type' => 'reasonEntityType',
        'reason_type' => 'reasonType'
    };
*/
    public override Map<String, Object> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'reason_entity_type' => 'reasonEntityType',
        'reason_type' => 'reasonType'
      };
      return propertyMappings;
    }
  }

  /**
   * Suspends an existing service.
   */
  public class GTVAPISuspendService extends GTVAPICommand implements GTVAPIRestClient.MappedProperties, GTVAPIRestClient.ReverseMappedProperties {
    /**
     * The date when the service is suspended.
     * @return effectiveDate
     */
    public Datetime effectiveDate { get; set; }

    /**
     * Get reason
     * @return reason
     */
    public GTVAPIServiceSuspensionReasonRef reason { get; set; }
    /*
    private final Map<String, String> propertyMappings = new Map<String, String>{
        'effective_date' => 'effectiveDate'
    };

    private final Map<String, String> reversePropertyMappings = new Map<String, String>{
        'effectiveDate' => 'effective_date',
        'reasonType' => 'reason_type'
    };
*/

    public Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'effective_date' => 'effectiveDate'
      };
      return propertyMappings;
    }

    public Map<String, String> getReversePropertyMappings() {
      Map<String, String> reversePropertyMappings = new Map<String, String>{
        'effectiveDate' => 'effective_date',
        'reasonType' => 'reason_type'
      };
      return reversePropertyMappings;
    }
  }
  /**
   * A discriminator field that indicates whether the reason specifies Billing Account Suspension or Billing Account Deactivation.
   */
  public enum GTVAPIBillingAccountReasonType {
    SUSPENSION,
    DEACTIVATION
  }
  /**
   * A base entity for the Billing Account Suspension Reason and Billing Account Deactivation Reason entities.
   */
  public virtual class GTVAPIBillingAccountReason extends GTVAPIReason implements GTVAPIRestClient.MappedProperties {
    /**
     * Get reasonType
     * @return reasonType
     */
    public String reasonType { get; set; }

    /*private final Map<String, String> propertyMappings = new Map<String, String>{
        'reason_entity_type' => 'reasonEntityType',
        'reason_type' => 'reasonType'
    };*/

    public virtual Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'reason_entity_type' => 'reasonEntityType',
        'reason_type' => 'reasonType'
      };
      return propertyMappings;
    }
  }
  /**
   * A representation of the core Billing Account Deactivation Reason. It specifies the reason for moving a billing account to the Deactivated status, meaning the billing account cannot be used any more.
   */
  public class GTVAPIBillingAccountDeactivationReason extends GTVAPIBillingAccountReason implements GTVAPIRestClient.MappedProperties {
    /*   private final Map<String, String> propertyMappings = new Map<String, String>{
        'reason_entity_type' => 'reasonEntityType',
        'reason_type' => 'reasonType'
    };
*/
    public override Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'reason_entity_type' => 'reasonEntityType',
        'reason_type' => 'reasonType'
      };
      return propertyMappings;
    }
  }

  /**
   * A reason for the invoice reissue.
   */
  public enum GTVAPIInvoiceReasonType {
    INVOICE
  }

  /**
   * A base entity for Manual Invoice Reason.
   */
  public virtual class GTVAPIInvoiceReason extends GTVAPIReason implements GTVAPIRestClient.MappedProperties {
    /**
     * Get reasonType
     * @return reasonType
     */
    public GTVAPIInvoiceReasonType reasonType { get; set; }

    /*private final Map<String, String> propertyMappings = new Map<String, String>{
        'reason_entity_type' => 'reasonEntityType',
        'reason_type' => 'reasonType'
    };
*/
    public virtual Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'reason_entity_type' => 'reasonEntityType',
        'reason_type' => 'reasonType'
      };
      return propertyMappings;
    }
  }

  /**
   * A representation of the core Manual Invoice Reason entity. It specifies a reason for creating manual invoices.
   */
  public class GTVAPIManualInvoiceReason extends GTVAPIInvoiceReason implements GTVAPIRestClient.MappedProperties {
    /*private final Map<String, String> propertyMappings = new Map<String, String>{
        'reason_entity_type' => 'reasonEntityType',
        'reason_type' => 'reasonType'
    };
*/
    public override Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'reason_entity_type' => 'reasonEntityType',
        'reason_type' => 'reasonType'
      };
      return propertyMappings;
    }
  }
  /**
   * A representation of the Service Deactivation Reason core entity. It specifies a reason for moving the service to the Deactivated status, meaning the service cannot be used any more.
   */
  public class GTVAPIServiceDeactivationReason extends GTVAPIServiceReason implements GTVAPIRestClient.MappedProperties {
    /*private final Map<String, String> propertyMappings = new Map<String, String>{
        'reason_entity_type' => 'reasonEntityType',
        'reason_type' => 'reasonType'
    };*/

    public override Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'reason_entity_type' => 'reasonEntityType',
        'reason_type' => 'reasonType'
      };
      return propertyMappings;
    }
  }

  /**
   * A representation of the core Billing Account Suspension Reason. It specifies the reason for moving a billing account to the Suspended status, meaning customers temporarily cannot use this billing account. After, you can change the status back to Active, or move it to the permanent Deactivated status.
   */
  public class GTVAPIBillingAccountSuspensionReason extends GTVAPIBillingAccountReason implements GTVAPIRestClient.MappedProperties {
    /* private final Map<String, String> propertyMappings = new Map<String, String>{
        'reason_entity_type' => 'reasonEntityType',
        'reason_type' => 'reasonType'
    };
*/
    public override Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'reason_entity_type' => 'reasonEntityType',
        'reason_type' => 'reasonType'
      };
      return propertyMappings;
    }
  }
  /**
   * A representation of the core Service Suspension Reason entity. It specifies the reason for moving a service to the Suspended status, meaning customers temporarily cannot use it. Then, you can change the status back to Active, or move it to the permanent Deactivated status.
   */
  public class GTVAPIServiceSuspensionReason extends GTVAPIServiceReason implements GTVAPIRestClient.MappedProperties {
    /* private final Map<String, String> propertyMappings = new Map<String, String>{
        'reason_entity_type' => 'reasonEntityType',
        'reason_type' => 'reasonType'
    };
*/
    public override Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'reason_entity_type' => 'reasonEntityType',
        'reason_type' => 'reasonType'
      };
      return propertyMappings;
    }
  }

  /**
   * A command for changing the status of billing account. Billing accounts can be in the Active, Suspended, Deactivated, or Closed status.
   */
  public virtual class GTVAPIBillingAccountStatusCommand extends GTVAPICommand implements GTVAPIRestClient.MappedProperties {
    /**
     * The date when the billing account was created.
     * @return startDate
     */
    public Datetime startDate { get; set; }

    /**
     * A representation of the note on a billing account. You can create, update, and query notes through the API.
     * @return notes
     */
    public String notes { get; set; }
    /*
        private final Map<String, String> propertyMappings = new Map<String, String>{
            'start_date' => 'startDate'
        };
*/
    public virtual Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'start_date' => 'startDate'
      };
      return propertyMappings;
    }
  }
  /**
   * Moves a billing account through the business processes to the Suspended status. After you moved the account to the Suspended status, with Resume Billing Account, you can change the status back to Active.
   */
  public class GTVAPISuspendBillingAccount extends GTVAPIBillingAccountStatusCommand implements GTVAPIRestClient.MappedProperties, GTVAPIRestClient.ReverseMappedProperties {
    /**
     * Get reason
     * @return reason
     */
    public GTVAPIBillingAccountSuspensionReasonRef reason { get; set; }

    private final Map<String, String> propertyMappings = new Map<String, String>{
      'start_date' => 'startDate'
    };

    public override Map<String, String> getPropertyMappings() {
      return propertyMappings;
    }

    /*  private final Map<String, String> reversePropertyMappings = new Map<String, String>{
        'startDate' => 'start_date',
        'reasonType' => 'reason_type'
        };*/

    public Map<String, String> getReversePropertyMappings() {
      Map<String, String> reversePropertyMappings = new Map<String, String>{
        'startDate' => 'start_date',
        'reasonType' => 'reason_type'
      };
      return reversePropertyMappings;
    }
  }

  /**
   * A reference to the Billing Account Reason core entity.
   */
  public virtual class GTVAPIBillingAccountReasonRef extends GTVAPIReasonRef implements GTVAPIRestClient.MappedProperties {
    /**
     * Get reasonType
     * @return reasonType
     */
    public String reasonType { get; set; }

    /*private final Map<String, String> propertyMappings = new Map<String, String>{
            'reason_entity_type' => 'reasonEntityType',
            'reason_type' => 'reasonType'
        };
*/
    public virtual override Map<String, Object> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'reason_entity_type' => 'reasonEntityType',
        'reason_type' => 'reasonType'
      };
      return propertyMappings;
    }
  }

  /**
   * A reference to the Billing Account Suspension Reason core entity.
   */
  public class GTVAPIBillingAccountSuspensionReasonRef extends GTVAPIBillingAccountReasonRef implements GTVAPIRestClient.MappedProperties {
    /* private final Map<String, String> propertyMappings = new Map<String, String>{
        'reason_entity_type' => 'reasonEntityType',
        'reason_type' => 'reasonType'
        };
*/
    public override Map<String, Object> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'reason_entity_type' => 'reasonEntityType',
        'reason_type' => 'reasonType'
      };
      return propertyMappings;
    }
  }

  /**
   * A reference to the Billing Account Deactivation Reason core entity.
   */
  public class GTVAPIBillingAccountDeactivationReasonR extends GTVAPIBillingAccountReasonRef implements GTVAPIRestClient.MappedProperties {
    private final Map<String, String> propertyMappings = new Map<String, String>{
      'reason_entity_type' => 'reasonEntityType',
      'reason_type' => 'reasonType'
    };

    public override Map<String, Object> getPropertyMappings() {
      return propertyMappings;
    }
  }

  /**
   * Moves a billing account through the business processes to the Deactivated status. The billing account is no longer usable by your customer who has this billing account. Deactivating a billing account is permanent and cannot be undone.
   */
  public class GTVAPIDeactivateBillingAccount extends GTVAPIBillingAccountStatusCommand implements GTVAPIRestClient.MappedProperties, GTVAPIRestClient.ReverseMappedProperties {
    /**
     * Get reason
     * @return reason
     */
    public GTVAPIBillingAccountDeactivationReasonR reason { get; set; }
    /*
        private final Map<String, String> propertyMappings = new Map<String, String>{
            'start_date' => 'startDate'
        };
*/
    public override Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'start_date' => 'startDate'
      };
      return propertyMappings;
    }

    /*  private final Map<String, String> reversePropertyMappings = new Map<String, String>{
        'startDate' => 'start_date',
        'reasonType' => 'reason_type'
        };
*/
    public Map<String, String> getReversePropertyMappings() {
      Map<String, String> reversePropertyMappings = new Map<String, String>{
        'startDate' => 'start_date',
        'reasonType' => 'reason_type'
      };
      return reversePropertyMappings;
    }
  }

  /**
   * Moves a billing account through the business processes from the Suspended to Active status.
   */
  public class GTVAPIResumeBillingAccount extends GTVAPIBillingAccountStatusCommand implements GTVAPIRestClient.MappedProperties {
    /**
     * The date when the billing account was created.
     * @return startDate
     */
    public Datetime startDate { get; set; }

    /**
     * A representation of the note on a billing account. You can create, update, and query notes through the API.
     * @return notes
     */
    public String notes { get; set; }
    /*
        private final Map<String, String> propertyMappings = new Map<String, String>{
            'start_date' => 'startDate'
        };
*/
    public override Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'start_date' => 'startDate'
      };

      return propertyMappings;
    }
  }

  public class GTVAPIOrderItemRef extends GTVAPIEntity implements GTVAPIRestClient.MappedProperties {
    /**
     * (unique_key) The ID of the entity.
     * @return id
     */
    public String id { get; set; }

    /**
     * Get orderItemType
     * @return orderItemType
     */
    public String orderItemType { get; set; }

    public Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'order_item_type' => 'orderItemType'
      };
      return propertyMappings;
    }
  }

  /**
   * A representation of adjustment item types.
   */
  public enum GTVAPIAdjustmentItemType {
    LATE_FEE,
    MANUAL,
    ORDER_ITEM,
    SERVICE,
    TERMINATION_CHARGE,
    TRUE_UP_CHARGE
  }

  public class GTVAPIAdjustmentItem extends GTVAPIEntity implements GTVAPIRestClient.MappedProperties {
    /**
     * (unique_key) The ID of the entity.
     * @return id
     */
    public String id { get; set; }

    public GTVAPIOrderItemRef orderItem { get; set; }

    /**
     * Get adjustmentItemType
     * @return adjustmentItemType
     */
    //public GTVAPIAdjustmentItemType adjustmentItemType { get; set; }

    /**
     * The amount of the adjustment.
     * @return amount
     */
    public Double amount { get; private set; }

    /**
     * A description of this adjustment item.
     * @return description
     */
    public String description { get; private set; }

    /**
     * Get reason
     * @return reason
     */
    public GTVAPIAdjustmentReasonRef reason { get; set; }

    /**
     * Get secondaryReason
     * @return secondaryReason
     */
    public GTVAPIAdjustmentReasonRef secondaryReason { get; set; }

    /**
     * Get category
     * @return category
     */
    public GTVAPIAdjustmentCategoryRef category { get; set; }

    public Map<String, Object> getPropertyMappings() {
      Map<String, Object> propertyMappings = new Map<String, Object>{
        'adjustment_item_type' => 'adjustmentItemType',
        'secondary_reason' => 'secondaryReason',
        'order_item' => new List<String>{ 'orderItem', 'GTVAPIOrderItemRef' }
      };
      return propertyMappings;
    }
  }

  /**
   * Creates a new product. A base entity for one time and customer subscription products.
   */
  public class GTVAPICreateProduct extends GTVAPIEntity implements GTVAPIRestClient.MappedProperties, GTVAPIRestClient.ReverseMappedProperties {
    /**
     * Get productType
     * @return productType
     */
    public String productType { get; set; }

    /**
     * (unique_key) The name of this product.
     * @return name
     */
    public String name { get; set; }

    /**
     * (unique_key) The stock keeping unit (SKU) for this product.
     * @return sku
     */
    public String sku { get; set; }

    /**
     * (unique_key) The external product number.
     * @return externalProductNumber
     */
    public String externalProductNumber { get; set; }

    /**
     * The internal name of the product. It is optional, and customers cannot see it.
     * @return internalName
     */
    public String internalName { get; set; }

    /**
     * The description of this product.
     * @return description
     */
    public String description { get; set; }

    /**
     * The short description of this product.
     * @return shortDescription
     */
    public String shortDescription { get; set; }

    /**
     * The date and time when this product became active.
     * @return introductionDate
     */
    public Datetime introductionDate { get; set; }

    /**
     * Get priceList
     * @return priceList
     */
    public GTVAPIPriceListRef priceList { get; set; }

    /**
     * Specifies whether the product requires an agreement.
     * @return requiresAgreement
     */
    public Boolean requiresAgreement { get; set; }

    /**
     * Get productTags
     * @return productTags
     */
    public List<GTVAPIProductTagRef> productTags { get; set; }

    /**
     * Specifies whether this product is serialized. In the Gotransverse user interface, the terms "Unique" and "Non-unique" are used instead of "Serialized" and "Non-serialized".
     * @return serialized
     */
    public Boolean serialized { get; set; }

    /**
     * Specifies whether this product is taxable.
     * @return taxable
     */
    public Boolean taxable { get; set; }

    /**
     * Specifies whether this product has a trial period.
     * @return trial
     */
    public Boolean trial { get; set; }

    /**
     * If the product has a trial period enabled, this property defines the number of days that the trial period can last.
     * @return trialDays
     */
    public Integer trialDays { get; set; }

    /**
     * Specifies whether the trial period or the number of trial days has been overridden.
     * @return trialOverride
     */
    public Boolean trialOverride { get; set; }

    /**
     * The default quantity of this product.
     * @return defaultQuantity
     */
    public Double defaultQuantity { get; set; }

    /**
     * The level of the product. With product levels, you can change the service to the one of the same level or higher.
     * @return productLevel
     */
    public Integer productLevel { get; set; }

    /**
     * All one-time and recurring prices associated with this product.
     * @return prices
     */
    public List<GTVAPIProductPrice> prices { get; set; }

    /**
     * Get productCategory
     * @return productCategory
     */
    public GTVAPIProductCategoryRef productCategory { get; set; }

    public String ruleMode { get; set; }

    public String ruleType { get; set; }

    public Boolean consumePrepaidBalance { get; set; }

    public Boolean fundPrepaidBalance { get; set; }

    public Integer minServiceResources { get; set; }

    public Integer maxServiceResources { get; set; }

    public GTVAPIResourceCategoryRef serviceResourceCategory { get; set; }

    /**
     * Get ruleOverride
     * @return ruleOverride
     */
    public Boolean ruleOverride { get; set; }

    /**
     * Get registerType
     * @return registerType
     */
    public GTVAPIProductRegisterTypeRef registerType { get; set; }

    /**
     * Get customFieldValues
     * @return customFieldValues
     */
    //public List<GTVAPICreateProductCustomFieldValue> customFieldValues { get; set; }

    public Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'product_type' => 'productType',
        'external_product_number' => 'externalProductNumber',
        'internal_name' => 'internalName',
        'short_description' => 'shortDescription',
        'introduction_date' => 'introductionDate',
        'price_list' => 'priceList',
        'requires_agreement' => 'requiresAgreement',
        'product_tags' => 'productTags',
        'trial_days' => 'trialDays',
        'trial_override' => 'trialOverride',
        'default_quantity' => 'defaultQuantity',
        'product_level' => 'productLevel',
        'product_category' => 'productCategory',
        'register_type' => 'registerType',
        'custom_field_values' => 'customFieldValues'
      };
      return propertyMappings;
    }

    public Map<String, String> getReversePropertyMappings() {
      Map<String, String> reversePropertyMappings = new Map<String, String>{
        'productType' => 'product_type',
        'externalProductNumber' => 'external_product_number',
        'internalName' => 'internal_name',
        'shortDescription' => 'short_description',
        'introductionDate' => 'introduction_date',
        'priceList' => 'price_list',
        'requiresAgreement' => 'requires_agreement',
        'productTags' => 'product_tags',
        'trialDays' => 'trial_days',
        'trialOverride' => 'trial_override',
        'defaultQuantity' => 'default_quantity',
        'productLevel' => 'product_level',
        'productCategory' => 'product_category',
        'ruleMode' => 'rule_mode',
        'ruleType' => 'rule_type',
        'consumePrepaidBalance' => 'consume_prepaid_balance',
        'minServiceResources' => 'min_service_resources',
        'maxServiceResources' => 'max_service_resources',
        'serviceResourceCategory' => 'service_resource_category',
        'ruleOverride' => 'rule_override',
        'fundPrepaidBalance' => 'fund_prepaid_balance',
        'registerType' => 'register_type'
      };
      return reversePropertyMappings;
    }

    public GTVAPICreateProduct() {
      productTags = new List<GTVAPIProductTagRef>();
      prices = new List<GTVAPIProductPrice>();
      //customFieldValues = new List<GTVAPICreateProductCustomFieldValue>();
    }
  }

  /**
   * A reference to the core Product Category entity.
   */
  public class GTVAPIProductCategoryRef extends GTVAPIEntity {
    /**
     * (unique_key) The ID of the entity.
     * @return id
     */
    public String id { get; set; }

    /**
     * (unique_key) The name of the product category.
     * @return name
     */
    public String name { get; set; }
  }

  /**
   * A reference to the core Product Tag entity.
   */
  public class GTVAPIProductTagRef extends GTVAPIEntity {
    /**
     * (unique_key) The ID of the entity.
     * @return id
     */
    public String id { get; set; }

    /**
     * (unique_key) The name of the product category.
     * @return name
     */
    public String name { get; set; }
  }

  /**
   * A representation of the core Product Register Type entity.
   */
  public class GTVAPIProductRegisterType extends GTVAPIEntity {
    /**
     * (unique_key) The ID of the entity.
     * @return id
     */
    public String id { get; private set; }

    /**
     * The unique ID used to identify the register in the stored value service.
     * @return name
     */
    public String name { get; private set; }

    public String code { get; private set; }

    public String status { get; private set; }

    public String uom { get; private set; }

    public String enforce_balance { get; private set; }
  }

  /**
   * A reference to the core Product Register Type entity.
   */
  public class GTVAPIProductRegisterTypeRef extends GTVAPIEntity {
    /**
     * (unique_key) The ID of the entity.
     * @return id
     */
    public String id { get; set; }

    /**
     * (unique_key) The unique ID used to identify the register in the stored value service.
     * @return name
     */
    public String name { get; private set; }
  }
  /**
   * Creates the Product Agreement Relation entity.
   */
  public class GTVAPICreateProductAgreementRelation extends GTVAPICreateEntity {
    /**
     * Get agreement
     * @return agreement
     */
    public GTVAPIAgreementRef agreement { get; set; }
  }

  /**
   * A full representation of the core product price group.
   */
  public class GTVAPIProductPriceGroup extends GTVAPIEntity implements GTVAPIRestClient.MappedProperties {
    /**
     * (unique_key) The ID of the entity.
     * @return id
     */
    public String id { get; private set; }

    /**
     * (unique_key) The name of this price group.
     * @return name
     */
    public String name { get; set; }

    /**
     * The description of this price group.
     * @return description
     */
    public String description { get; set; }

    /**
     * (unique_key) An alphanumeric code used to identify the price group internally in Gotransverse core. You cannot change the price group code after the price group is created.
     * @return code
     */
    public String code { get; set; }

    /**
     * Get status
     * @return status
     */
    public GTVAPIPriceGroupStatus status { get; set; }

    /**
     * Get pricingStrategy
     * @return pricingStrategy
     */
    public GTVAPIPricingStrategy pricingStrategy { get; set; }

    /**
     * Specifies whether this Product Price Group will create a global price group. If global is set to true, one Price Group instance is created for this Product Price Group. If it is set to false, the Price Group is non-global, meaning a Price Group instance exists on the billing account level for each order which contains a product with a price that has the non-global product price group assigned.
     * @return r_global
     */
    public Boolean r_global { get; set; }

    public Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'pricing_strategy' => 'pricingStrategy',
        'global' => 'r_global'
      };
      return propertyMappings;
    }
  }

  /**
   * Indicates the status of the Price Group. \nACTIVE status means that the price group is immediately available to be added to a charge price. \nDRAFT means that it is not yet available to be added to a charge price. \nNew price groups are always created in the Draft status.\nSUSPENDED status means that the price group is no longer available.\n
   */
  public enum GTVAPIPriceGroupStatus {
    ACTIVE,
    DRAFT,
    SUSPENDED
  }

  /**
   * Indicates a type of the Pricing Strategy. Pricing strategy defines how to apply a price group during a bill cycle. DAILY PRORATION means that the price is calculated based on quantity changes on a per-day basis. If quantity is changed, the price is re-evaluated each day of the period to provide accuracy to the day level. HIGH WATER MARK (currentyly unsupported) means that the service is priced based on the highest quantity reached during the period for all services in a price group.
   */
  public enum GTVAPIPricingStrategy {
    DAILY_PRORATION,
    HIGH_WATER_MARK
  }

  /**
   * Indicates the type of the recurrence period entity.
   */
  public enum GTVAPIRecurrencePeriod {
    BILL_CYCLE,
    DAY,
    FOUR_YEARS,
    FIVE_YEARS,
    MONTH,
    QUARTER,
    THREE_YEARS,
    TWICE_A_MONTH,
    TWICE_A_YEAR,
    TWO_WEEKS,
    TWO_YEARS,
    WEEK,
    YEAR,
    FOUR_MONTHS,
    TWELVE_WEEKS
  }

  /**
   * A representation of the Product Agreement Relation entity which specifies the association between an agreement and a product.
   */
  public class GTVAPIProductAgreementRelation extends GTVAPIEntity {
    /**
     * (unique_key) The ID of the entity.
     * @return id
     */
    public String id { get; private set; }

    /**
     * Get agreement
     * @return agreement
     */
    public GTVAPIAgreementRef agreement { get; set; }

    /**
     * Get product
     * @return product
     */
    public GTVAPIProductRef product { get; set; }
  }

  public class GTVAPICreateProductPrice extends GTVAPICreatePrice implements GTVAPIRestClient.MappedProperties, GTVAPIRestClient.ReverseMappedProperties {
    /**
     * Get category
     * @return category
     */
    public GTVAPIPriceCategoryRef category { get; set; }

    /**
     * Get currencyCode
     * @return currencyCode
     */
    public String currencyCode { get; set; }

    /**
     * Specifies whether the price belongs to the tapered pricing strategy.
     * @return tapered
     */
    public Boolean tapered { get; set; }

    /**
     * Get sourcePrice
     * @return sourcePrice
     */
    public GTVAPIProductPriceRef sourcePrice { get; set; }

    /**
     * Get productPriceType
     * @return productPriceType
     */
    public String productPriceType { get; set; }

    /**
     * The date and time from when this product price is valid.
     * @return validFrom
     */
    public String validFrom { get; set; }

    /**
     * Specifies whether the product price can be overridden.
     * @return priceOverride
     */
    public Boolean priceOverride { get; set; }

    /**
     * The price ranges (tiers) for the tiered or tapered pricing.
     * @return priceRanges
     */
    public List<GTVAPICreatePriceRange> priceRanges { get; set; }

    /**
     * Specifies whether the payment on purchase is required.
     * @return paymentOnPurchaseRequired
     */
    public Boolean paymentOnPurchaseRequired { get; set; }

    /**
     * Get priceGroup
     * @return priceGroup
     */
    public GTVAPIProductPriceGroupRef priceGroup { get; set; }

    /**
     * Get recurrencePeriod
     * @return recurrencePeriod
     */
    public String recurrencePeriod { get; set; }

    public Boolean proratedOnOrder { get; set; }

    public Boolean proratedOnCancel { get; set; }

    public Boolean proratedOnOrderNoCharge { get; set; }

    /**
     * Specifies whether the customer is charged before the service period begins, and then before each service period afterward.
     * @return billInAdvance
     */
    public Boolean billInAdvance { get; set; }

    /**
     * Get billInAdvanceConfiguration
     * @return billInAdvanceConfiguration
     */
    public GTVAPIBillInAdvanceConfiguration billInAdvanceConfiguration {
      get;
      set;
    }

    public Boolean allowScheduledCharges { get; set; }

    public Boolean chargeDuringRenewal { get; set; }

    public override Map<String, Object> getPropertyMappings() {
      Map<String, Object> propertyMappings = new Map<String, String>{
        'price_type' => 'priceType',
        'currency_code' => 'currencyCode',
        'source_price' => 'sourcePrice',
        'product_price_type' => 'productPriceType',
        'valid_from' => 'validFrom',
        'price_override' => 'priceOverride',
        'price_ranges' => 'priceRanges',
        'payment_on_purchase_required' => 'paymentOnPurchaseRequired',
        'price_group' => 'priceGroup'
      };
      return propertyMappings;
    }

    public override Map<String, Object> getReversePropertyMappings() {
      Map<String, Object> reversePropertyMappings = new Map<String, Object>{
        'priceType' => 'price_type',
        'currencyCode' => 'currency_code',
        'sourcePrice' => 'source_price',
        'productPriceType' => 'product_price_type',
        'validFrom' => 'valid_from',
        'priceOverride' => 'price_override',
        'priceRanges' => new List<String>{
          'price_ranges',
          'GTVAPICreatePriceRange'
        },
        'paymentOnPurchaseRequired' => 'payment_on_purchase_required',
        'priceGroup' => 'price_group',
        'recurrencePeriod' => 'recurrence_period',
        'proratedOnOrder' => 'prorated_on_order',
        'proratedOnCancel' => 'prorated_on_cancel',
        'proratedOnOrderNoCharge' => 'prorated_on_order_no_charge',
        'category' => new List<String>{ 'category', 'GTVAPIPriceCategoryRef' },
        'billInAdvance' => 'bill_in_advance',
        'billInAdvanceConfiguration' => 'bill_in_advance_configuration',
        'allowScheduledCharges' => 'allow_scheduled_charges',
        'chargeDuringRenewal' => 'charge_during_renewal'
      };
      return reversePropertyMappings;
    }
  }

  /**
   * Indicates a type of the Product Price. It can be either one-time or recurring. A recurring price is the charge that recurs for the whole recurrence period (a year, a month, two weeks, and so on). A one-time price is used for one-time charges.
   */
  public enum GTVAPIProductPriceType {
    ONE_TIME,
    RECURRING
  }

  /**
   * A representation of the core Product Custom Field entity.
   */
  public class GTVAPIProductCustomField extends GTVAPICustomField implements GTVAPIRestClient.MappedProperties {
    public override Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'custom_field_type' => 'customFieldType',
        'reg_ex' => 'regEx',
        'field_type' => 'fieldType',
        'field_validation_type' => 'fieldValidationType'
      };
      return propertyMappings;
    }

    public GTVAPIProductCustomField() {
    }
  }

  /**
   * The content in custom field values on products. It is associated with a product at the time the product is created.
   */
  public class GTVAPIProductCustomFieldValue extends GTVAPICustomFieldValue implements GTVAPIRestClient.MappedProperties {
    public override Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'custom_field_value_type' => 'customFieldValueType',
        'custom_field' => 'customField'
      };

      return propertyMappings;
    }
  }

  /**
   * Creates a new product custom field value.
   */
  public class GTVAPICreateProductCustomFieldValue extends GTVAPICreateCustomFieldValue implements GTVAPIRestClient.MappedProperties {
    /**
     * Get customField
     * @return customField
     */
    public GTVAPIProductCustomFieldRef customField { get; set; }

    public override Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'custom_field_value_type' => 'customFieldValueType',
        'custom_field' => 'custom_field'
      };
      return propertyMappings;
    }
  }

  /**
   * A reference to the Product Custom Field core entity.
   */
  public class GTVAPIProductCustomFieldRef extends GTVAPICustomFieldRef implements GTVAPIRestClient.MappedProperties {
    public override Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'custom_field_type' => 'customFieldType'
      };
      return propertyMappings;
    }
  }

  /**
   * Creates a new Marketplace entity.
   */
  public class GTVAPICreateMarketplace extends GTVAPICreateEntity {
    /**
     * (unique_key) The name of the marketplace.
     * @return name
     */
    public String name { get; set; }

    /**
     * Get description
     * @return description
     */
    public String description { get; set; }
  }

  /**
   * A representation of the core Marketplace entity.
   */
  public class GTVAPIMarketplace extends GTVAPIEntity implements GTVAPIRestClient.MappedProperties {
    /**
     * (unique_key) The ID of the entity.
     * @return id
     */
    public String id { get; private set; }

    /**
     * (unique_key) The name of this marketplace.
     * @return name
     */
    public String name { get; set; }

    /**
     * The date and time from when this marketplace is valid.
     * @return validFrom
     */
    public Datetime validFrom { get; private set; }

    /**
     * The date and time until when this marketplace is valid.
     * @return validTo
     */
    public Datetime validTo { get; private set; }

    /**
     * The description of this marketplace.
     * @return description
     */
    public String description { get; set; }

    public Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'valid_from' => 'validFrom',
        'valid_to' => 'validTo'
      };
      return propertyMappings;
    }
  }

  /**
   * A reference to the Marketplace core entity.
   */
  public class GTVAPIMarketplaceRef extends GTVAPIEntityRef {
    /**
     * (unique_key) The ID of the entity.
     * @return id
     */
    public String id { get; set; }

    /**
     * (unique_key) The name of this marketplace.
     * @return name
     */
    public String name { get; set; }
  }

  /**
   * Specifies the association between a price list and a marketplace.
   */
  public class GTVAPIPriceListRelation extends GTVAPIEntity implements GTVAPIRestClient.MappedProperties {
    /**
     * (unique_key) The ID of the entity.
     * @return id
     */
    public String id { get; private set; }

    /**
     * Get priceList
     * @return priceList
     */
    public GTVAPIPriceListRef priceList { get; set; }

    /**
     * Get marketplace
     * @return marketplace
     */
    public GTVAPIMarketplaceRef marketplace { get; set; }

    public Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'price_list' => 'priceList'
      };
      return propertyMappings;
    }
  }

  /**
   * Creates the association between a price list and a marketplace.
   */
  public class GTVAPICreatePriceListRelation extends GTVAPIEntity implements GTVAPIRestClient.MappedProperties {
    /**
     * Get priceList
     * @return priceList
     */
    public GTVAPIPriceListRef priceList { get; set; }

    public Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'price_list' => 'priceList'
      };
      return propertyMappings;
    }
  }
  /**
   * Creates the association between a price list and a marketplace.
   */
  public class GTVAPIPriceListProductRelation extends GTVAPIEntity implements GTVAPIRestClient.MappedProperties {
    /**
     * Get priceList
     * @return priceList
     */
    public GTVAPIPriceListRef priceList { get; set; }
    /**
     * Get product
     * @return product
     */
    public GTVAPIProductRef product { get; set; }
    /**
     * Get valid From
     * @return Datetime
     */
    public Datetime validFrom { get; set; }

    public Map<String, Object> getPropertyMappings() {
      Map<String, Object> propertyMappings = new Map<String, Object>{
        'price_list' => 'priceList',
        'product' => new List<String>{ 'product', 'GTVAPIProductRef' },
        'valid_from' => 'validFrom'
      };
      return propertyMappings;
    }
  }

  /**
   * Creates a new Service Usage Rule entity.
   */
  public class GTVAPICreateProductUsageRule extends GTVAPICreateUsageRuleTemplate implements GTVAPIRestClient.MappedProperties, GTVAPIRestClient.ReverseMappedProperties {
    /**
     * Get status
     * @return status
     */
    public GTVAPIProductUsageRuleStatus status { get; set; }

    public override Map<String, String> getPropertyMappings() {
      Map<String, String> propertyMappings = new Map<String, String>{
        'usage_rule_type' => 'usageRuleType',
        'allowance_amount' => 'allowanceAmount',
        'allowance_uom' => 'allowanceUom',
        'allowance_type' => 'allowanceType',
        'rule_order' => 'ruleOrder',
        'prorated_on_order' => 'proratedOnOrder',
        'prorated_on_cancel' => 'proratedOnCancel',
        'roll_over_type' => 'rollOverType',
        'valid_from' => 'validFrom',
        'valid_to' => 'validTo',
        'rule_type' => 'ruleType',
        'usage_rate' => 'usageRate',
        'rate_type' => 'rateType',
        'usage_rule_specification_type' => 'usageRuleSpecificationType',
        'charge_category' => 'chargeCategory',
        'charge_category_type' => 'chargeCategoryType'
      };
      return propertyMappings;
    }
    public override Map<String, String> getReversePropertyMappings() {
      Map<String, String> reversePropertyMappings = new Map<String, String>{
        'usageRuleType' => 'usage_rule_type',
        'allowanceAmount' => 'allowance_amount',
        'allowanceUom' => 'allowance_uom',
        'allowanceType' => 'allowance_type',
        'ruleOrder' => 'rule_order',
        'proratedOnOrder' => 'prorated_on_order',
        'proratedOnCancel' => 'prorated_on_cancel',
        'rollOverType' => 'roll_over_type',
        'validFrom' => 'valid_from',
        'validTo' => 'valid_to',
        'ruleType' => 'rule_type',
        'usageRate' => 'usage_rate',
        'rateType' => 'rate_type',
        'usageRuleSpecificationType' => 'usage_rule_specification_type',
        'chargeCategory' => 'charge_category',
        'chargeCategoryType' => 'charge_category_type'
      };
      return reversePropertyMappings;
    }
  }
  /**
   * Gets or Sets ProductUsageRuleStatus
   */
  public enum GTVAPIProductUsageRuleStatus {
    ACTIVE,
    DEACTIVATED,
    DRAFT
  }
  /**
   * Payment Referer Token URL.
   */
  public class GTVAPIPaymentRefererToken implements GTVAPIRestClient.MappedProperties, GTVAPIRestClient.ReverseMappedProperties {
    /**
     * (unique_key) The Error URL.
     * @return errorUrl
     */
    public String errorURL { get; set; }

    /**
     * (unique_key) The Cancel URL.
     * @return cancelURL
     */
    public String cancelURL { get; set; }
    /**
     * (unique_key) The Complete URL.
     * @return completeURL
     */
    public String completeURL { get; set; }

    public Map<String, Object> getPropertyMappings() {
      Map<String, Object> propertyMappings = new Map<String, Object>{};
      return propertyMappings;
    }

    public Map<String, Object> getReversePropertyMappings() {
      Map<String, Object> reversePropertyMappings = new Map<String, Object>{
        'errorURL' => 'error_url',
        'cancelURL' => 'cancel_url',
        'completeURL' => 'complete_url'
      };
      return reversePropertyMappings;
    }
  }
  /**
   * get Payment RefererRoken.
   */
  public class GTVAPIGetPaymentRefererToken implements GTVAPIRestClient.MappedProperties {
    /**
     * (unique_key) The Referer token.
     * @return token
     */
    public String token { get; set; }

    public Map<String, Object> getPropertyMappings() {
      Map<String, Object> propertyMappings = new Map<String, Object>{
        'token' => 'token'
      };
      return propertyMappings;
    }
  }
  /**
   * get Payment RefererRoken.
   */
  public class GTVAPICreatePaymentMethod implements GTVAPIRestClient.MappedProperties, GTVAPIRestClient.ReverseMappedProperties {
    /**
     * Id
     * @return paymentMethod ID
     */
    public String id { get; set; }

    /**
     * First Name
     * @return firstName
     */
    public String firstName { get; set; }
    /**
     * Middle Name
     * @return middleName
     */
    public String middleName { get; set; }
    /**
     * Last Name.
     * @return lastName
     */
    public String lastName { get; set; }
    /**
     * suffix
     * @return suffix
     */
    public String suffix { get; set; }
    /**
     * card Type
     * @return cardType
     */
    public String cardType { get; set; }
    /**
     * card Number
     * @return cardNumber
     */
    public String cardNumber { get; set; }
    /**
     * cvv
     * @return cvv
     */
    public String cvv { get; set; }
    /**
     * expiry Date
     * @return expiryDate
     */
    public String expiryDate { get; set; }
    /**
     * email Address
     * @return emailAddress
     */
    public String emailAddress { get; set; }
    /**
     * address line 1
     * @return address1
     */
    public String address1 { get; set; }
    /**
     * address line 2
     * @return address2
     */
    public String address2 { get; set; }
    /**
     * city
     * @return city
     */
    public String city { get; set; }
    /**
     * state
     * @return state
     */
    public String state { get; set; }
    /**
     * country
     * @return country
     */
    public String country { get; set; }
    /**
     * postalCode
     * @return postalCode
     */
    public String postalCode { get; set; }
    /**
     *  The auto payment
     * @return Boolean
     */
    public String autopayment { get; set; }
    /**
     *  The nickname
     * @return String
     */
    public String nickname { get; set; }
    /**
     * (unique_key) The Referer token.
     * @return token
     */
    public String token { get; set; }

    public Map<String, Object> getPropertyMappings() {
      Map<String, Object> propertyMappings = new Map<String, Object>{
        'token' => 'token'
      };
      return propertyMappings;
    }
    public Map<String, Object> getReversePropertyMappings() {
      Map<String, Object> reversePropertyMappings = new Map<String, Object>{
        'firstName' => 'first_name',
        'middleName' => 'middle_name',
        'lastName' => 'last_name',
        'suffix' => 'suffix',
        'cardType' => 'card_type',
        'cardNumber' => 'card_number',
        'cvv' => 'cvv',
        'expiryDate' => 'expire_date',
        'emailAddress' => 'email_address',
        'address1' => 'address_1',
        'address2' => 'address_2',
        'city' => 'city',
        'state' => 'state',
        'country' => 'country',
        'postalCode' => 'postal_code',
        'token' => 'token',
        'autopayment' => 'auto_payment',
        'nickname' => 'nickname'
      };
      return reversePropertyMappings;
    }
  }
  public class GTVAPIGetPaymentMethodResponse implements GTVAPIRestClient.MappedProperties {
    /**
     * reference paymentToken
     * @return reference
     */
    public String reference { get; set; }
    /**
     *  validation Status
     * @return status
     */
    public String status { get; set; }

    public Map<String, Object> getPropertyMappings() {
      Map<String, Object> propertyMappings = new Map<String, Object>{
        'reference' => 'reference',
        'validation_status' => 'status'
      };
      return propertyMappings;
    }
  }
}