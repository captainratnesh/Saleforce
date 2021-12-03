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
 * This class Maps the SOAP API's response from GTV to salesforce objects and Wrapper class.
 * @author AMAN JAIN
 */

public with sharing class GTVSOAP133MappingService {
  /**
   * @description -Parsing Account Custom fields as AccountCustomFieldWrapper list
   */
  public static list<AccountCustomFieldWrapper> parseAccountCustomFields(
    SoapApi33Domain.QueryResponse accountCustomFieldQueryResponse,
    Map<string, string> mapOfEidVSName
  ) {
    list<AccountCustomFieldWrapper> wrapList = new List<AccountCustomFieldWrapper>();
    if (
      accountCustomFieldQueryResponse.successful &&
      null != accountCustomFieldQueryResponse.customFields.customField &&
      accountCustomFieldQueryResponse.customFields.customField.size() > 0
    ) {
      for (
        SoapApi33Domain.customField custFieldObj : accountCustomFieldQueryResponse.customFields.customField
      ) {
        if (
          custFieldObj.enabled && !mapOfEidVSName.containsKey(custFieldObj.eid)
        ) {
          AccountCustomFieldWrapper wrapInstance = new AccountCustomFieldWrapper();
          wrapInstance.Name = custFieldObj.Name;
          wrapInstance.Eid = custFieldObj.eid;
          wrapInstance.fieldValidationType = custFieldObj.fieldValidationType;
          wrapInstance.storeListTypeValues = new List<SelectOption>();
          Account_Custom_Field__c accountCustomField = new Account_Custom_Field__c();
          accountCustomField.field_type__c = custFieldObj.fieldType;
          if (custFieldObj.fieldType == 'LIST') {
            wrapInstance.checkListtype = true;
            wrapInstance.storeListTypeValues.add(
              new SelectOption('', 'Choose One')
            );
            if (null != custFieldObj.customFieldValueReferences) {
              SoapApi33Domain.CustomFieldValueReference[] customReference = custFieldObj.customFieldValueReferences.customFieldValueReference;
              for (
                SoapApi33Domain.CustomFieldValueReference refrence : customReference
              ) {
                wrapInstance.storeListTypeValues.add(
                  new SelectOption(refrence.value, refrence.value)
                );
              }
            }
          }
          wrapList.add(wrapInstance);
        }
      }
    }
    return wrapList;
  }

  /**
   * @description -Parsing Account Custom fields as Account_Custom_Field__c custom object list
   */
  public static list<Account_Custom_Field__c> mapAccountFieldsObjects(
    SoapApi33Domain.QueryResponse queryResponse
  ) {
    list<Account_Custom_Field__c> listOfAccountCustomField = new List<Account_Custom_Field__c>();
    if (
      queryResponse.successful &&
      null != queryResponse.customFields.customField &&
      queryResponse.customFields.customField.size() > 0
    ) {
      for (
        SoapApi33Domain.customField custFieldObj : queryResponse.customFields.customField
      ) {
        if (custFieldObj.enabled) {
          Account_Custom_Field__c accountCustomField = new Account_Custom_Field__c();
          accountCustomField.eid__c = custFieldObj.eid;
          accountCustomField.Name = custFieldObj.Name;
          accountCustomField.fieldValidationType__c = custFieldObj.fieldValidationType;
          accountCustomField.field_type__c = custFieldObj.fieldType;
          if (custFieldObj.fieldType == 'LIST') {
            if (null != custFieldObj.customFieldValueReferences) {
              SoapApi33Domain.CustomFieldValueReference[] customReference = custFieldObj.customFieldValueReferences.customFieldValueReference;
              for (
                SoapApi33Domain.CustomFieldValueReference refrence : customReference
              ) {
                if (accountCustomField.Store_Order_List_Value__c == null) {
                  accountCustomField.Store_Order_List_Value__c = refrence.value;
                } else
                  accountCustomField.Store_Order_List_Value__c +=
                    ',' + refrence.value;
              }
            }
          }
          listOfAccountCustomField.add(accountCustomField);
        }
      }
    }
    return listOfAccountCustomField;
  }

  /**
   * @description -Map Account Custom Fields Eid and Name
   */
  public static map<string, string> mapAccountCustomFields(
    SoapApi33Domain.QueryResponse queryResponse
  ) {
    Map<string, string> mapOfEidVSName = new Map<string, string>();
    for (
      SoapApi33Domain.CustomFieldValue fld : queryResponse.customFieldValues.customFieldValue
    ) {
      mapOfEidVSName.put(fld.customField.eid, fld.customField.name);
    }
    return mapOfEidVSName;
  }
  public static list<SelectOption> mapCustomFieldForBilling(
    SoapApi33Domain.QueryResponse queryResponse
  ) {
    List<SelectOption> options = new List<SelectOption>();
    if (
      queryResponse.successful && null != queryResponse.customFields.customField
    ) {
      for (
        SoapApi33Domain.customField theCus : queryResponse.customFields.customField
      ) {
        //query for User records with System Admin profile
        //for all records found - add them to the picklist options
        if (
          theCus.customFieldType == 'BILLING_ACCOUNT' &&
          theCus.fieldType == 'TEXT_FIELD' &&
          theCus.fieldValidationType == 'TEXT' &&
          theCus.enabled == true
        ) {
          options.add(new SelectOption(theCus.eid, theCus.name));
        }
      }
    }
    return options;
  }

  /**
   *@description -Parsing Account Custom fields as Wrapper
   */
  public static list<AccountCustomFieldValueWrapper> parseAccountCustomFieldValues(
    SoapApi33Domain.QueryResponse queryResponse
  ) {
    list<AccountCustomFieldValueWrapper> listOfConfiguredCustomField = new List<AccountCustomFieldValueWrapper>();
    if (
      queryResponse.successful &&
      null != queryResponse.customFieldValues.customFieldValue &&
      queryResponse.customFieldValues.customFieldValue.size() > 0
    ) {
      for (
        SoapApi33Domain.CustomFieldValue fld : queryResponse.customFieldValues.customFieldValue
      ) {
        AccountCustomFieldValueWrapper fieldValue = new AccountCustomFieldValueWrapper();
        fieldValue.Value = fld.value;
        fieldValue.Name = fld.customField.name;
        listOfConfiguredCustomField.add(fieldValue);
      }
    }
    return listOfConfiguredCustomField;
  }

  /**
   *@description -Parsing Billing Account as TRACTAccountWrapper
   */
  public static TRACTAccountWrapper parseBillingAccount(
    List<SoapApi33Domain.BillingAccount> accountsList,
    string queryScope
  ) {
    TRACTAccountWrapper sfdcBillingAccount = new TRACTAccountWrapper();
    Account sfdcAccount = new Account();
    if (queryScope.equals('SHALLOW') && accountsList.size() == 1) {
      SoapApi33Domain.BillingAccount tractAccount = accountsList.get(0);
      sfdcAccount.Tract_Billing_Account__c = tractAccount.accountNum;
      sfdcBillingAccount.TractBillingAccountNumber = tractAccount.accountNum;
      sfdcBillingAccount.eid = tractAccount.eid;
      sfdcBillingAccount.status = tractAccount.status;
      sfdcBillingAccount.accountCurrency = tractAccount.currencyType;
      sfdcBillingAccount.billType = TractSFDC_Util.convertInvoiceTypeToCamelCase(
        tractAccount.billType,
        '_'
      );
    } else if (queryScope.equals('DEEP') && accountsList.size() == 1) {
      SoapApi33Domain.BillingAccount tractAccount = accountsList.get(0);
      if (
        tractAccount.organization != null &&
        tractAccount.organization.name != null
      ) {
        sfdcAccount.Name = tractAccount.organization.name;
      }
      sfdcAccount.Tract_Billing_Account__c = tractAccount.accountNum;
      sfdcBillingAccount.TractBillingAccountNumber = tractAccount.accountNum;
      sfdcBillingAccount.eid = tractAccount.eid;
      sfdcBillingAccount.status = tractAccount.status;
      sfdcBillingAccount.accountCurrency = tractAccount.currencyType;
      sfdcBillingAccount.billType = TractSFDC_Util.convertInvoiceTypeToCamelCase(
        tractAccount.billType,
        '_'
      );
      sfdcBillingAccount.validFrom = Date.valueOf(tractAccount.startDate);
      sfdcBillingAccount.taxExempt = tractAccount.taxExempt;
      if (tractAccount.paymentTerm != null) {
        sfdcBillingAccount.paymentTerm = tractAccount.paymentTerm.name;
      }
      sfdcBillingAccount.balance = setAccountBalanceCurrencyType(
        string.valueOf(tractAccount.balance.setScale(2)),
        tractAccount.currencyType
      );
      if (tractAccount.billingAccountCategory != null) {
        sfdcBillingAccount.accountCategory = tractAccount.billingAccountCategory.type_x;
      }
      if (tractAccount.monthlyBillCycle != null) {
        sfdcBillingAccount.billCycleName = tractAccount.monthlyBillCycle.name;
      }
      if (tractAccount.dailyBillCycle != null) {
        sfdcBillingAccount.billCycleName = tractAccount.dailyBillCycle.name;
      }
      if (tractAccount.quarterlyBillCycle != null) {
        sfdcBillingAccount.billCycleName = tractAccount.quarterlyBillCycle.name;
      }
      if (tractAccount.yearlyBillCycle != null) {
        sfdcBillingAccount.billCycleName = tractAccount.yearlyBillCycle.name;
      }
      if (tractAccount.segmentedMonthlyBillCycle != null) {
        sfdcBillingAccount.billCycleName = tractAccount.segmentedMonthlyBillCycle.name;
      }
      if (
        tractAccount.person != null &&
        tractAccount.person.addresses != null
      ) {
        SoapApi33Domain.PostalAddress[] postalAddresses = tractAccount.person.addresses.postalAddress;
        if (postalAddresses != null && !postalAddresses.isEmpty()) {
          for (SoapApi33Domain.PostalAddress address : postalAddresses) {
            if (address.purpose.equals('SHIPPING')) {
              sfdcAccount.ShippingStreet =
                (address.line1 != null ? address.line1 : '') +
                ' ' +
                (address.line2 != null ? address.line2 : '');
              sfdcAccount.ShippingCity = address.city;
              sfdcAccount.ShippingPostalCode = address.postalCode;
              sfdcAccount.ShippingState = address.regionOrState;
              sfdcAccount.ShippingCountry = address.country;
            } else if (address.purpose.equals('BILLING')) {
              sfdcAccount.BillingStreet =
                (address.line1 != null ? address.line1 : '') +
                ' ' +
                (address.line2 != null ? address.line2 : '');
              sfdcAccount.BillingCity = address.city;
              sfdcAccount.BillingPostalCode = address.postalCode;
              sfdcAccount.BillingState = address.regionOrState;
              sfdcAccount.BillingCountry = address.country;
            }
          }
        }

        SoapApi33Domain.EmailAddress[] emailAddresses = tractAccount.person.addresses.emailAddress;
        if (emailAddresses != null && !emailAddresses.isEmpty()) {
          for (SoapApi33Domain.EmailAddress emailAdrs : emailAddresses) {
            if (emailAdrs.purpose.equals('PRIMARY')) {
              sfdcBillingAccount.email = emailAdrs.email;
            }
          }
        }
      }
      if (
        tractAccount.organization != null &&
        tractAccount.organization.addresses != null
      ) {
        SoapApi33Domain.PostalAddress[] postalAddresses = tractAccount.organization.addresses.postalAddress;
        if (postalAddresses != null && !postalAddresses.isEmpty()) {
          for (SoapApi33Domain.PostalAddress address : postalAddresses) {
            if (address.purpose.equals('SHIPPING')) {
              sfdcAccount.ShippingStreet =
                (address.line1 != null ? address.line1 : '') +
                ' ' +
                (address.line2 != null ? address.line2 : '');
              sfdcAccount.ShippingCity = address.city;
              sfdcAccount.ShippingPostalCode = address.postalCode;
              sfdcAccount.ShippingState = address.regionOrState;
              sfdcAccount.ShippingCountry = address.country;
            } else if (address.purpose.equals('BILLING')) {
              sfdcAccount.BillingStreet =
                (address.line1 != null ? address.line1 : '') +
                ' ' +
                (address.line2 != null ? address.line2 : '');
              sfdcAccount.BillingCity = address.city;
              sfdcAccount.BillingPostalCode = address.postalCode;
              sfdcAccount.BillingState = address.regionOrState;
              sfdcAccount.BillingCountry = address.country;
            }
          }
        }
        SoapApi33Domain.EmailAddress[] emailAddresses = tractAccount.organization.addresses.emailAddress;
        if (emailAddresses != null && !emailAddresses.isEmpty()) {
          for (SoapApi33Domain.EmailAddress emailAdrs : emailAddresses) {
            if (emailAdrs.purpose.equals('PRIMARY')) {
              sfdcBillingAccount.email = emailAdrs.email;
            }
          }
        }
      }
    }
    sfdcBillingAccount.billingAccount = sfdcAccount;
    return sfdcBillingAccount;
  }

  /**
   *@description - mapping Account Fields
   */
  public static void mapAccount(
    Account thisAccount,
    TRACTAccountWrapper tractBillingAccount
  ) {
    //Set Shipping Address
    thisAccount.ShippingStreet = tractBillingAccount.billingAccount.ShippingStreet;
    thisAccount.ShippingCity = tractBillingAccount.billingAccount.ShippingCity;
    thisAccount.ShippingPostalCode = tractBillingAccount.billingAccount.ShippingPostalCode;
    thisAccount.ShippingState = tractBillingAccount.billingAccount.ShippingState;
    thisAccount.ShippingCountry = tractBillingAccount.billingAccount.ShippingCountry;

    thisAccount.BillingStreet = tractBillingAccount.billingAccount.BillingStreet;
    thisAccount.BillingCity = tractBillingAccount.billingAccount.BillingCity;
    thisAccount.BillingPostalCode = tractBillingAccount.billingAccount.BillingPostalCode;
    thisAccount.BillingState = tractBillingAccount.billingAccount.BillingState;
    thisAccount.BillingCountry = tractBillingAccount.billingAccount.BillingCountry;
    thisAccount.Email__c = tractBillingAccount.billingAccount.Email__c;
  }

  /**
   *@description - Appending currency symbol in current balance
   */
  public static string setAccountBalanceCurrencyType(
    string balance,
    string currencyType
  ) {
    string value, location;
    for (System_Setting__c settings : System_Setting__c.getall().values()) {
      if (settings.name == 'Currency Identification') {
        value = settings.value__c;
      }
      if (settings.name == 'Currency Location') {
        location = settings.value__c;
      }
    }
    string currentBalance;
    if (value == 'ISO Code') {
      if (location == 'After') {
        currentBalance = balance + currencyType;
      } else {
        currentBalance = currencyType + balance;
      }
    } else {
      if (location == 'After') {
        currentBalance =
          balance + TractSFDC_Util.getCurrencySymbole(currencyType);
      } else {
        currentBalance =
          TractSFDC_Util.getCurrencySymbole(currencyType) + balance;
      }
    }
    return currentBalance;
  }

  /**
   * @description -This method return Payment Method Type used to make Payment. If Payment passed is null then it returns blank.
   *
   */
  private static string getPaymentMethodType(SoapApi33Domain.Payment payment) {
    string paymentMethodType = '';
    if (payment != null) {
      if (payment.cashPayment != null) {
        paymentMethodType = 'Cash';
      } else if (payment.bankPayment != null) {
        paymentMethodType = 'Bank Draft';
      } else if (payment.creditCardPayment != null) {
        paymentMethodType = 'Credit Card';
      } else if (payment.checkPayment != null) {
        paymentMethodType = 'Check';
      } else if (payment.payPalPayment != null) {
        paymentMethodType = 'Paypal';
      } else if (payment.wireTransferPayment != null) {
        paymentMethodType = 'Wire Transafer';
      } else if (payment.referencedCreditCardPayment != null) {
        paymentMethodType = 'Reference Credit Card';
      } else if (payment.mobileCarrierPayment != null) {
        paymentMethodType = 'Mobile Carrier';
      } else if (payment.TokenizedCreditCardPaymentMethod != null) {
        paymentMethodType = 'Tokenized Credit Card';
      }
    }
    return paymentMethodType;
  }

  /**
   *   @description -Method to get Adjustment Type
   *
   */
  private static string getAdjustmentType(string adjustmentType) {
    string result = '';
    if (adjustmentType == null) {
      return '';
    } else if (adjustmentType.equalsIgnoreCase('MANUAL')) {
      result = 'Manual Adjustment';
    } else if (adjustmentType.equalsIgnoreCase('LATE_FEE')) {
      result = 'Late Payment Fee';
    } else if (adjustmentType.equalsIgnoreCase('TERMINATION_CHARGE')) {
      result = 'Early Termination Charge';
    } else if (adjustmentType.equalsIgnoreCase('INVOICE_ADJUSTMENT')) {
      result = 'Invoice Adjustment';
    } else {
      result = adjustmentType.replace('_', ' ');
      result = result.toLowerCase().capitalize();
    }
    return result;
  }

  /**
   *   @description -Method to parse Payments to TractPaymentWrapper
   *
   */
  public static TractPaymentWrapper parsePayments(
    SoapApi33Domain.QueryResponse queryResponse,
    TRACTAccountWrapper tractBillingAccount
  ) {
    TractPaymentWrapper paymentwrap = new TractPaymentWrapper();
    List<PaymentWrapper> payments = new List<PaymentWrapper>();
    Integer totelpage;
    SoapApi33Domain.Payment[] accountPayments;
    if (queryResponse.successful && null != queryResponse.payments.payment) {
      accountPayments = queryResponse.payments.payment;
      /* Total number of record pages */
      if (queryResponse.payments.totalPages != null) {
        totelpage = queryResponse.payments.totalPages;
      }
    } else {
      //TODOs: Either request failed or Payments not found.
      accountPayments = new List<SoapApi33Domain.Payment>();
    }
    if (accountPayments != null && !accountPayments.isEmpty()) {
      for (SoapApi33Domain.Payment tempSO : accountPayments) {
        if (tempSO.status != 'Processing_error' && tempSO.status != 'Void') {
          PaymentWrapper wrap = new PaymentWrapper();
          {
            wrap.Name = tempSO.eid;
            wrap.PaymentAmount = setAccountBalanceCurrencyType(
              string.valueof(tempSO.amount.setScale(2)),
              tractBillingAccount.accountCurrency
            );
            wrap.Description = tempSO.description;
            wrap.OccurredOn = tempSO.occurredOn;
            wrap.PaymentMethodType = getPaymentMethodType(tempSO);
            wrap.Status = tempSO.status != null
              ? tempSO.status.toLowerCase().capitalize()
              : '';
          }
          payments.add(wrap);
        }
      }
    }
    paymentwrap.paymentListWrapper = payments;
    paymentwrap.totalPage = totelpage;
    return paymentwrap;
  }
  /**
   *   @description -Method to get Payment conditions
   *
   */
  public static string getConditions(TractPaymentWrapper paymentwrap) {
    string condition = '';
    for (PaymentWrapper wrap : paymentwrap.paymentListWrapper) {
      condition = condition + ' paymentEid eq \'' + wrap.Name + '\' or';
    }
    return condition;
  }
  /**
   *   @description -Method to map Payments to TractPaymentWrapper
   *
   */
  public static TractPaymentWrapper mapPayments(
    Map<string, string> paymentEidvsInvoiceIdMap,
    TractPaymentWrapper paymentwrap
  ) {
    for (PaymentWrapper paymentObj : paymentwrap.paymentListWrapper) {
      if (paymentEidvsInvoiceIdMap.containsKey(paymentObj.Name)) {
        paymentObj.InvoicesPaid = paymentEidvsInvoiceIdMap.get(paymentObj.Name);
      }
    }
    return paymentwrap;
  }

  public static TractInvoiceWrapper parseInvoices(
    SoapApi33Domain.QueryResponse queryResponse,
    TRACTAccountWrapper tractBillingAccount
  ) {
    TractInvoiceWrapper invoiceWrap = new TractInvoiceWrapper();
    SoapApi33Domain.Invoice[] accountInvoices;
    SoapApi33Domain.Invoice[] manualInvoices;
    SoapApi33Domain.Invoice[] onDemandInvoices;
    Integer totelpage;
    List<InvoiceWrapper> invoices = new List<InvoiceWrapper>();
    /* Check if Invoices exist or not */
    if (queryResponse.successful && null != queryResponse.invoices.invoice) {
      accountInvoices = queryResponse.invoices.invoice;
      if (queryResponse.invoices.totalPages != null) {
        totelpage = queryResponse.invoices.totalPages;
      }
    } else {
      //TODOs: Either request failed or Invoice(s) not found.
      accountInvoices = new List<SoapApi33Domain.Invoice>();
    }
    /* Check if Manual Invoices exist or not */
    if (
      queryResponse.successful && null != queryResponse.invoices.manualInvoice
    ) {
      manualInvoices = queryResponse.invoices.manualInvoice;
    } else {
      //TODOs: Either request failed or manualInvoice(s) not found.
      manualInvoices = new List<SoapApi33Domain.Invoice>();
    }
    /* Check if on demand Invoices exist or not */
    if (
      queryResponse.successful && null != queryResponse.invoices.onDemandInvoice
    ) {
      onDemandInvoices = queryResponse.invoices.onDemandInvoice;
    } else {
      //TODOs: Either request failed or manualInvoice(s) not found.
      onDemandInvoices = new List<SoapApi33Domain.Invoice>();
    }
    if (accountInvoices != null && !accountInvoices.isEmpty()) {
      invoices.addAll(mapInvoices(accountInvoices, tractBillingAccount));
    }
    if (manualInvoices != null && !manualInvoices.isEmpty()) {
      invoices.addAll(mapInvoices(manualInvoices, tractBillingAccount));
    }
    if (onDemandInvoices != null && !onDemandInvoices.isEmpty()) {
      invoices.addAll(mapInvoices(onDemandInvoices, tractBillingAccount));
    }

    /* added the value into wrapper variables */
    invoiceWrap.invoiceListWrapper = invoices;
    invoiceWrap.totalPage = totelpage;
    /* return the wrapper instance */
    return invoiceWrap;
  }

  /**
   *   @description -Mapping callout response for Invoices into salesforce invoice object
   *
   */
  public static List<InvoiceWrapper> mapInvoices(
    SoapApi33Domain.Invoice[] getinvoices,
    TRACTAccountWrapper tractBillingAccount
  ) {
    List<InvoiceWrapper> invoices = new List<InvoiceWrapper>();
    if (getinvoices != null && !getinvoices.isEmpty()) {
      for (SoapApi33Domain.Invoice inv : getinvoices) {
        if (inv.status != 'PROCESSING') {
          InvoiceWrapper wrap = new InvoiceWrapper();
          wrap.Name = inv.invoiceNum;
          wrap.InvoiceAmount = setAccountBalanceCurrencyType(
            string.valueof(inv.amount.setScale(2)),
            tractBillingAccount.accountCurrency
          );
          wrap.InvoicePdf = inv.pdfPath;
          wrap.InvoiceAmountToPay = setAccountBalanceCurrencyType(
            string.valueof(inv.amountToPay.setScale(2)),
            tractBillingAccount.accountCurrency
          );
          wrap.DueDate = inv.dueDate;
          wrap.InvoicedDate = inv.occurredOn.date();
          wrap.PaidDate = inv.paidDate;
          wrap.CheckInvoiceStatus = inv.status != 'PROCESSING' ? true : false;
          wrap.Status = inv.status != null
            ? inv.status.toLowerCase().capitalize()
            : '';
          wrap.currencyType = tractBillingAccount.accountCurrency;
          invoices.add(wrap);
        }
      }
    }
    return invoices;
  }

  /**
   *   @description -Method to parse adjustments to TractAdjustmentWrapper
   *
   */
  public static TractAdjustmentWrapper parseAdjustments(
    SoapApi33Domain.QueryResponse queryResponse,
    TRACTAccountWrapper tractBillingAccount,
    String adjustment
  ) {
    SoapApi33Domain.Adjustment[] accountAdjustments;
    List<AdjustmentWrapper> adjustments = new List<AdjustmentWrapper>();
    TractAdjustmentWrapper adjustmentWrap = new TractAdjustmentWrapper();
    Integer totelpage;
    /*Check if Adjustment records exist or not */
    if (
      queryResponse.successful && null != queryResponse.adjustments.adjustment
    ) {
      accountAdjustments = queryResponse.adjustments.adjustment;
      /* Total number of record pages */
      if (queryResponse.adjustments.totalPages != null) {
        totelpage = queryResponse.adjustments.totalPages;
      }
    } else {
      //TODOs: Either request failed or Adjustment(s) not found.
      accountAdjustments = new List<SoapApi33Domain.Adjustment>();
    }
    if (accountAdjustments != null && !accountAdjustments.isEmpty()) {
      for (SoapApi33Domain.Adjustment theAdjustment : accountAdjustments) {
        AdjustmentWrapper wrap = new AdjustmentWrapper();
        wrap.Name = theAdjustment.credit == true
          ? theAdjustment.creditNumber
          : theAdjustment.eid;
        wrap.credit = theAdjustment.credit;
        wrap.ManuallyApply = theAdjustment.manualInvoiceApplication == true
          ? 'Yes'
          : 'No';
        wrap.postedOn = theAdjustment.postedOn;
        wrap.reason = theAdjustment.reason != null
          ? theAdjustment.reason.name
          : '';
        wrap.AdjutsmentAmount = setAccountBalanceCurrencyType(
          string.valueOf(theAdjustment.amount.setScale(2)),
          tractBillingAccount.accountCurrency
        );
        wrap.description = theAdjustment.description;
        wrap.OccurredOn = theAdjustment.occurredOn;
        wrap.Type = getAdjustmentType(theAdjustment.type_x); //.toLowerCase().capitalize(),
        wrap.Status = theAdjustment.status != null
          ? theAdjustment.status.toLowerCase().capitalize()
          : '';
        wrap.eid = theAdjustment.eid;
        if (
          theAdjustment.adjustmentItems != null &&
          theAdjustment.adjustmentItems.orderItemAdjustmentItem != null &&
          theAdjustment.adjustmentItems.orderItemAdjustmentItem.orderItem !=
          null
        ) {
          wrap.orderItemId = theAdjustment.adjustmentItems.orderItemAdjustmentItem.orderItem.eid;
        }
        wrap.ShowAdjustmentAmount = setAccountBalanceCurrencyType(
          string.valueOf(theAdjustment.amount.setScale(2)),
          tractBillingAccount.accountCurrency
        );
        wrap.CreditUnappliedAmount = setAccountBalanceCurrencyType(
          string.valueOf(theAdjustment.unappliedAmount.setScale(2)),
          tractBillingAccount.accountCurrency
        );
        if (theAdjustment.credit == true && adjustment == 'credit') {
          adjustments.add(wrap);
        } else if (theAdjustment.credit == false && adjustment == 'debit') {
          adjustments.add(wrap);
        }
      }
    }
    adjustmentWrap.adjustmentListWrapper = adjustments;
    adjustmentWrap.totalPage = totelpage;
    return adjustmentWrap;
  }
  /**
   *   @description -Method to map adjustments to TractAdjustmentWrapper
   *
   */
  public static TractAdjustmentWrapper mapAdjustments(
    Map<string, string> adjustmentEidvsInvoiceIdMap,
    TractAdjustmentWrapper adjustmentWrap
  ) {
    for (
      AdjustmentWrapper adjustmentObj : adjustmentWrap.adjustmentListWrapper
    ) {
      if (adjustmentEidvsInvoiceIdMap.containsKey(adjustmentObj.eid)) {
        adjustmentObj.invoice = adjustmentEidvsInvoiceIdMap.get(
          adjustmentObj.Name
        );
      }
    }
    return adjustmentWrap;
  }
  /**
   *   @description -Method to parse Sales Order Wrapper
   *
   */
  public static SoapApi33Domain.SalesOrder[] getSalesOrders(
    SoapApi33Domain.QueryResponse queryResponse
  ) {
    SoapApi33Domain.SalesOrder[] results;
    if (
      queryResponse.successful && null != queryResponse.salesOrders.salesOrder
    ) {
      results = queryResponse.salesOrders.salesOrder;
    } else {
      //TODOs: Either request failed or SalesOrder(s) not found.
      results = new List<SoapApi33Domain.SalesOrder>();
    }
    return results;
  }
  /**
   *   @description -Method to parse Notes to TRACTNoteWrapper
   *
   */
  public static TRACTNoteWrapper parseNotes(
    SoapApi33Domain.QueryResponse queryResponse
  ) {
    list<NotesWrapper> listOfNotes = new List<NotesWrapper>();
    integer totalPages;
    if (
      queryResponse.successful &&
      queryResponse != null &&
      queryResponse.notes.note != null
    ) {
      totalPages = queryResponse.notes.totalPages;
      for (SoapApi33Domain.Note note : queryResponse.notes.note) {
        NotesWrapper noteWrapper = new NotesWrapper();
        if (note.organization != null) {
          noteWrapper.party = note.organization.name;
        } else if (note.person != null) {
          noteWrapper.party = note.person.firstName;
        }
        if (note.NoteType != null) {
          noteWrapper.typeOfNote = note.NoteType.name;
        }
        noteWrapper.userData = note.user.username;
        noteWrapper.noteContent = note.content;
        listOfNotes.add(noteWrapper);
      }
    }
    TRACTNoteWrapper wrapperObj = new TRACTNoteWrapper();
    wrapperObj.totalPage = totalPages;
    wrapperObj.noteWrapperList = listOfNotes;
    return wrapperObj;
  }
  /**
   *   @description -Method to parse Contacts to TRACTContactWrapper
   *
   */
  public static TRACTContactWrapper parseContacts(
    SoapApi33Domain.QueryResponse queryResponse
  ) {
    list<ContactWrapper> listOfContacts = new List<ContactWrapper>();
    Integer totalPages;
    if (
      queryResponse.successful &&
      queryResponse != null &&
      queryResponse.people.person != null
    ) {
      totalPages = queryResponse.people.totalPages;
      for (SoapApi33Domain.Person person : queryResponse.people.person) {
        ContactWrapper contactWrapper = new ContactWrapper();
        string firstName = '';
        string lastName = '';
        string middleName = '';
        string suffix = '';
        if (person.firstName != null) {
          firstName = person.firstName + ' ';
        }
        if (person.middleName != null) {
          middleName = person.middleName + ' ';
        }
        if (person.lastName != null) {
          lastName = person.lastName + ' ';
        }
        if (person.suffix != null) {
          suffix = person.suffix;
        }
        contactWrapper.name = firstName + middleName + lastName + suffix;
        if (person.category != null) {
          contactWrapper.categoryName = person.category.name;
        }
        if (person.department != null) {
          contactWrapper.department = person.department;
        }
        if (person.title != null) {
          contactWrapper.title = person.title;
        }
        if (person.addresses != null) {
          if (person.addresses.emailAddress != null) {
            for (
              SoapApi33Domain.EmailAddress emailAddress : person.addresses.emailAddress
            ) {
              if (emailAddress.purpose == 'PRIMARY') {
                contactWrapper.Email = emailAddress.email;
              }
            }
          }
          if (
            person.addresses.telecomAddress != null &&
            person.addresses.telecomAddress.size() > 0
          ) {
            contactWrapper.phone = getTelecomAddress(
              person.addresses.telecomAddress,
              'mobile'
            );
            if (contactWrapper.phone == null) {
              contactWrapper.phone = getTelecomAddress(
                person.addresses.telecomAddress,
                'home'
              );
            }
            if (contactWrapper.phone == null) {
              contactWrapper.phone = getTelecomAddress(
                person.addresses.telecomAddress,
                'office'
              );
            }
            if (contactWrapper.phone == null) {
              contactWrapper.phone = getTelecomAddress(
                person.addresses.telecomAddress,
                'fax'
              );
            }
          }
        }
        listOfContacts.add(contactWrapper);
      }
    }
    TRACTContactWrapper wrapperObj = new TRACTContactWrapper();
    wrapperObj.totalPage = totalPages;
    wrapperObj.contactWrapperList = listOfContacts;
    return wrapperObj;
  }
  /**
   *   @description -Method to get Telecom Address
   *
   */
  private static string getTelecomAddress(
    List<SoapApi33Domain.TelecomAddress> addresses,
    string purposeType
  ) {
    for (SoapApi33Domain.TelecomAddress telecomAddress : addresses) {
      if (telecomAddress.purpose == purposeType) {
        return getPhone(telecomAddress);
      }
    }
    return null;
  }
  /**
   *   @description -Method to get Phone
   *
   */
  private static string getPhone(
    SoapApi33Domain.TelecomAddress telecomAddress
  ) {
    string countryCode = '';
    string areaCode = '';
    string number_x = '';
    string extension = '';
    if (telecomAddress.countryCode != null) {
      countryCode = '+' + telecomAddress.countryCode;
    }
    if (telecomAddress.areaCode != null) {
      areaCode = ' (' + telecomAddress.areaCode + ') ';
    }
    if (telecomAddress.number_x != null) {
      number_x = telecomAddress.number_x;
    }
    if (telecomAddress.extension != null) {
      extension = ' Extension:' + telecomAddress.extension;
    }
    return countryCode + areaCode + number_x + extension;
  }
  /**
   *   @description -Method to parse Orders to TractSalesOrderWrapper
   *
   */
  public static TractSalesOrderWrapper parseOrders(
    SoapApi33Domain.QueryResponse queryResponse
  ) {
    SoapApi33Domain.SalesOrder[] accountOrders;
    Integer totelpage;
    List<SalesWrapper> salesOrders = new List<SalesWrapper>();
    if (
      queryResponse.successful && null != queryResponse.salesOrders.salesOrder
    ) {
      accountOrders = queryResponse.salesOrders.salesOrder;
      if (queryResponse.salesOrders.totalPages != null) {
        totelpage = queryResponse.salesOrders.totalPages;
      }
    } else {
      //TODOs: Either request failed or SalesOrder(s) not found.
      accountOrders = new List<SoapApi33Domain.SalesOrder>();
    }
    TractSalesOrderWrapper orderWrapper = new TractSalesOrderWrapper();
    for (SoapApi33Domain.SalesOrder tempSO : accountOrders) {
      if (tempSO.orderStatus == 'INPROGRESS') {
        tempSO.orderStatus = 'In Progress';
      }
      SalesWrapper wrap = new SalesWrapper();
      wrap.Name = tempSO.orderNum;
      wrap.Note = tempSO.note;
      wrap.OrderDate = Date.valueOf(tempSO.orderDate);
      wrap.PurchaseOrderNumber = tempSO.purchaseOrderNumber;
      wrap.OrderStatus = tempSO.orderStatus != null
        ? tempSO.orderStatus.toLowerCase().capitalize()
        : '';
      salesOrders.add(wrap);
    }
    orderWrapper.salesOrderWrapperList = salesOrders;
    orderWrapper.totalPage = totelpage;
    return orderWrapper;
  }
  /**
   *   @description -Method to parse Payment Methods to TRACTPaymentMethodWrapper
   *
   */
  public static TRACTPaymentMethodWrapper parsePaymentMethodRecords(
    SoapApi33Domain.QueryResponse queryResponse
  ) {
    list<PaymentMethodWrapper> paymentMethodRecords = new List<PaymentMethodWrapper>();
    Integer totalPages;
    if (
      queryResponse.successful &&
      queryResponse != null &&
      queryResponse.recurringPayments.recurringPayment != null
    ) {
      totalPages = queryResponse.recurringPayments.totalPages;
      for (
        SoapApi33Domain.BillingAccountRecurringPayment recurringPayment : queryResponse.recurringPayments.recurringPayment
      ) {
        if (recurringPayment.tokenizedCreditCardPaymentMethod != null) {
          PaymentMethodWrapper record = new PaymentMethodWrapper();
          if (
            recurringPayment.tokenizedCreditCardPaymentMethod.nickname != null
          ) {
            record.nickName = recurringPayment.tokenizedCreditCardPaymentMethod.nickname;
          }
          record.description =
            recurringPayment.tokenizedCreditCardPaymentMethod.cardType +
            ', ' +
            recurringPayment.tokenizedCreditCardPaymentMethod.cardHolderFirstName +
            ' ' +
            recurringPayment.tokenizedCreditCardPaymentMethod.cardHolderLastName +
            ', ' +
            recurringPayment.tokenizedCreditCardPaymentMethod.cardIdentifierNumber +
            ', ' +
            recurringPayment.tokenizedCreditCardPaymentMethod.cardExpiration;
          if (
            recurringPayment.tokenizedCreditCardPaymentMethod.postalAddress !=
            null
          ) {
            if (
              recurringPayment.tokenizedCreditCardPaymentMethod.postalAddress.line2 !=
              null
            ) {
              record.address =
                recurringPayment.tokenizedCreditCardPaymentMethod.postalAddress.line1 +
                ' ' +
                recurringPayment.tokenizedCreditCardPaymentMethod.postalAddress.line2 +
                ' ' +
                recurringPayment.tokenizedCreditCardPaymentMethod.postalAddress.city +
                ',' +
                recurringPayment.tokenizedCreditCardPaymentMethod.postalAddress.regionOrState +
                ' ' +
                recurringPayment.tokenizedCreditCardPaymentMethod.postalAddress.postalCode +
                ' ' +
                recurringPayment.tokenizedCreditCardPaymentMethod.postalAddress.country;
            } else {
              record.address =
                recurringPayment.tokenizedCreditCardPaymentMethod.postalAddress.line1 +
                ' ' +
                recurringPayment.tokenizedCreditCardPaymentMethod.postalAddress.city +
                ',' +
                recurringPayment.tokenizedCreditCardPaymentMethod.postalAddress.regionOrState +
                ' ' +
                recurringPayment.tokenizedCreditCardPaymentMethod.postalAddress.postalCode +
                ' ' +
                recurringPayment.tokenizedCreditCardPaymentMethod.postalAddress.country;
            }
          } else {
            record.address = 'Same as Billing Address';
          }
          if (
            recurringPayment.tokenizedCreditCardPaymentMethod.emailAddress !=
            null
          ) {
            record.email = recurringPayment.tokenizedCreditCardPaymentMethod.emailAddress.email;
          }
          if (
            recurringPayment.tokenizedCreditCardPaymentMethod.telecomAddress !=
            null
          ) {
            string countryCode = '';
            string areaCode = '';
            string number_x = '';
            string extension = '';
            if (
              recurringPayment.tokenizedCreditCardPaymentMethod.telecomAddress.countryCode !=
              null
            ) {
              countryCode =
                '+' +
                recurringPayment.tokenizedCreditCardPaymentMethod.telecomAddress.countryCode;
            }
            if (
              recurringPayment.tokenizedCreditCardPaymentMethod.telecomAddress.areaCode !=
              null
            ) {
              areaCode =
                ' (' +
                recurringPayment.tokenizedCreditCardPaymentMethod.telecomAddress.areaCode +
                ') ';
            }
            if (
              recurringPayment.tokenizedCreditCardPaymentMethod.telecomAddress.number_x !=
              null
            ) {
              number_x = recurringPayment.tokenizedCreditCardPaymentMethod.telecomAddress.number_x;
            }
            if (
              recurringPayment.tokenizedCreditCardPaymentMethod.telecomAddress.extension !=
              null
            ) {
              extension =
                ' Extn:' +
                recurringPayment.tokenizedCreditCardPaymentMethod.telecomAddress.extension;
            }
            record.phone =
              countryCode +
              '' +
              areaCode +
              '' +
              number_x +
              '' +
              extension;
          }
          record.validFrom = recurringPayment.validFrom;
          record.validTo = recurringPayment.validTo;
          paymentMethodRecords.add(record);
        }
        if (recurringPayment.creditCardPaymentMethod != null) {
          PaymentMethodWrapper record = new PaymentMethodWrapper();
          if (recurringPayment.creditCardPaymentMethod.nickname != null) {
            record.nickName = recurringPayment.creditCardPaymentMethod.nickname;
          }
          record.description =
            recurringPayment.creditCardPaymentMethod.cardType +
            ', ' +
            recurringPayment.creditCardPaymentMethod.cardHolderFirstName +
            ' ' +
            recurringPayment.creditCardPaymentMethod.cardHolderLastName +
            ', ' +
            recurringPayment.creditCardPaymentMethod.cardIdentifierNumber +
            ', ' +
            recurringPayment.creditCardPaymentMethod.cardExpiration;
          if (recurringPayment.creditCardPaymentMethod.postalAddress != null) {
            if (
              recurringPayment.creditCardPaymentMethod.postalAddress.line2 !=
              null
            ) {
              record.address =
                recurringPayment.creditCardPaymentMethod.postalAddress.line1 +
                ' ' +
                recurringPayment.creditCardPaymentMethod.postalAddress.line2 +
                ' ' +
                recurringPayment.creditCardPaymentMethod.postalAddress.city +
                ',' +
                recurringPayment.creditCardPaymentMethod.postalAddress.regionOrState +
                ' ' +
                recurringPayment.creditCardPaymentMethod.postalAddress.postalCode +
                ' ' +
                recurringPayment.creditCardPaymentMethod.postalAddress.country;
            } else {
              record.address =
                recurringPayment.creditCardPaymentMethod.postalAddress.line1 +
                ' ' +
                recurringPayment.creditCardPaymentMethod.postalAddress.city +
                ',' +
                recurringPayment.creditCardPaymentMethod.postalAddress.regionOrState +
                ' ' +
                recurringPayment.creditCardPaymentMethod.postalAddress.postalCode +
                ' ' +
                recurringPayment.creditCardPaymentMethod.postalAddress.country;
            }
          } else {
            record.address = 'Same as Billing Address';
          }
          if (recurringPayment.creditCardPaymentMethod.emailAddress != null) {
            record.email = recurringPayment.creditCardPaymentMethod.emailAddress.email;
          }
          if (recurringPayment.creditCardPaymentMethod.telecomAddress != null) {
            string countryCode = '';
            string areaCode = '';
            string number_x = '';
            string extension = '';
            if (
              recurringPayment.creditCardPaymentMethod.telecomAddress.countryCode !=
              null
            ) {
              countryCode =
                '+' +
                recurringPayment.creditCardPaymentMethod.telecomAddress.countryCode;
            }
            if (
              recurringPayment.creditCardPaymentMethod.telecomAddress.areaCode !=
              null
            ) {
              areaCode =
                ' (' +
                recurringPayment.creditCardPaymentMethod.telecomAddress.areaCode +
                ') ';
            }
            if (
              recurringPayment.creditCardPaymentMethod.telecomAddress.number_x !=
              null
            ) {
              number_x = recurringPayment.creditCardPaymentMethod.telecomAddress.number_x;
            }
            if (
              recurringPayment.creditCardPaymentMethod.telecomAddress.extension !=
              null
            ) {
              extension =
                ' Extn:' +
                recurringPayment.creditCardPaymentMethod.telecomAddress.extension;
            }
            record.phone =
              countryCode +
              '' +
              areaCode +
              '' +
              number_x +
              '' +
              extension;
          }
          record.validFrom = recurringPayment.validFrom;
          record.validTo = recurringPayment.validTo;
          paymentMethodRecords.add(record);
        }
        if (recurringPayment.mobileCarrierPayment != null) {
          PaymentMethodWrapper record = new PaymentMethodWrapper();
          if (recurringPayment.mobileCarrierPayment.nickname != null) {
            record.nickName = recurringPayment.mobileCarrierPayment.nickname;
          }
          record.description =
            recurringPayment.mobileCarrierPayment.carrierName +
            ': ' +
            recurringPayment.mobileCarrierPayment.msisdn;
          if (recurringPayment.mobileCarrierPayment.postalAddress != null) {
            if (
              recurringPayment.mobileCarrierPayment.postalAddress.line2 != null
            ) {
              record.address =
                recurringPayment.mobileCarrierPayment.postalAddress.line1 +
                ' ' +
                recurringPayment.mobileCarrierPayment.postalAddress.line2 +
                ' ' +
                recurringPayment.mobileCarrierPayment.postalAddress.city +
                ',' +
                recurringPayment.mobileCarrierPayment.postalAddress.regionOrState +
                ' ' +
                recurringPayment.mobileCarrierPayment.postalAddress.postalCode +
                ' ' +
                recurringPayment.mobileCarrierPayment.postalAddress.country;
            } else {
              record.address =
                recurringPayment.mobileCarrierPayment.postalAddress.line1 +
                ' ' +
                recurringPayment.mobileCarrierPayment.postalAddress.city +
                ',' +
                recurringPayment.mobileCarrierPayment.postalAddress.regionOrState +
                ' ' +
                recurringPayment.mobileCarrierPayment.postalAddress.postalCode +
                ' ' +
                recurringPayment.mobileCarrierPayment.postalAddress.country;
            }
          } else {
            record.address = 'Same as Billing Address';
          }
          if (recurringPayment.mobileCarrierPayment.emailAddress != null) {
            record.email = recurringPayment.mobileCarrierPayment.emailAddress.email;
          }
          if (recurringPayment.mobileCarrierPayment.telecomAddress != null) {
            string countryCode = '';
            string areaCode = '';
            string number_x = '';
            string extension = '';
            if (
              recurringPayment.mobileCarrierPayment.telecomAddress.countryCode !=
              null
            ) {
              countryCode =
                '+' +
                recurringPayment.mobileCarrierPayment.telecomAddress.countryCode;
            }
            if (
              recurringPayment.mobileCarrierPayment.telecomAddress.areaCode !=
              null
            ) {
              areaCode =
                ' (' +
                recurringPayment.mobileCarrierPayment.telecomAddress.areaCode +
                ') ';
            }
            if (
              recurringPayment.mobileCarrierPayment.telecomAddress.number_x !=
              null
            ) {
              number_x = recurringPayment.mobileCarrierPayment.telecomAddress.number_x;
            }
            if (
              recurringPayment.mobileCarrierPayment.telecomAddress.extension !=
              null
            ) {
              extension =
                ' Extn:' +
                recurringPayment.mobileCarrierPayment.telecomAddress.extension;
            }
            record.phone =
              countryCode +
              '' +
              areaCode +
              '' +
              number_x +
              '' +
              extension;
          }
          record.validFrom = recurringPayment.validFrom;
          record.validTo = recurringPayment.validTo;
          paymentMethodRecords.add(record);
        }
        if (recurringPayment.bankPaymentMethod != null) {
          PaymentMethodWrapper record = new PaymentMethodWrapper();
          if (recurringPayment.bankPaymentMethod.nickname != null) {
            record.nickName = recurringPayment.bankPaymentMethod.nickname;
          }
          if (recurringPayment.bankPaymentMethod.emailAddress != null) {
            record.email = recurringPayment.bankPaymentMethod.emailAddress.email;
          }
          record.description =
            recurringPayment.bankPaymentMethod.bankName +
            ', ' +
            recurringPayment.bankPaymentMethod.bankRoutingNumber +
            ', ' +
            recurringPayment.bankPaymentMethod.bankAccountType +
            ', ' +
            recurringPayment.bankPaymentMethod.bankAccountNumber;
          if (recurringPayment.bankPaymentMethod.postalAddress != null) {
            if (
              recurringPayment.bankPaymentMethod.postalAddress.line2 != null
            ) {
              record.address =
                recurringPayment.bankPaymentMethod.postalAddress.line1 +
                ' ' +
                recurringPayment.bankPaymentMethod.postalAddress.line2 +
                ' ' +
                recurringPayment.bankPaymentMethod.postalAddress.city +
                ',' +
                recurringPayment.bankPaymentMethod.postalAddress.regionOrState +
                ' ' +
                recurringPayment.bankPaymentMethod.postalAddress.postalCode +
                ' ' +
                recurringPayment.bankPaymentMethod.postalAddress.country;
            } else {
              record.address =
                recurringPayment.bankPaymentMethod.postalAddress.line1 +
                ' ' +
                recurringPayment.bankPaymentMethod.postalAddress.city +
                ',' +
                recurringPayment.bankPaymentMethod.postalAddress.regionOrState +
                ' ' +
                recurringPayment.bankPaymentMethod.postalAddress.postalCode +
                ' ' +
                recurringPayment.bankPaymentMethod.postalAddress.country;
            }
          } else {
            record.address = 'Same as Billing Address';
          }
          if (recurringPayment.bankPaymentMethod.telecomAddress != null) {
            string countryCode = '';
            string areaCode = '';
            string number_x = '';
            string extension = '';
            if (
              recurringPayment.bankPaymentMethod.telecomAddress.countryCode !=
              null
            ) {
              countryCode =
                '+' +
                recurringPayment.bankPaymentMethod.telecomAddress.countryCode;
            }
            if (
              recurringPayment.bankPaymentMethod.telecomAddress.areaCode != null
            ) {
              areaCode =
                ' (' +
                recurringPayment.bankPaymentMethod.telecomAddress.areaCode +
                ') ';
            }
            if (
              recurringPayment.bankPaymentMethod.telecomAddress.number_x != null
            ) {
              number_x = recurringPayment.bankPaymentMethod.telecomAddress.number_x;
            }
            if (
              recurringPayment.bankPaymentMethod.telecomAddress.extension !=
              null
            ) {
              extension =
                ' Extn:' +
                recurringPayment.bankPaymentMethod.telecomAddress.extension;
            }
            record.phone =
              countryCode +
              '' +
              areaCode +
              '' +
              number_x +
              '' +
              extension;
          }
          record.validFrom = recurringPayment.validFrom;
          record.validTo = recurringPayment.validTo;
          paymentMethodRecords.add(record);
        }
        if (recurringPayment.referencedCreditCardPaymentMethod != null) {
        }
        if (recurringPayment.bpayPaymentMethod != null) {
          PaymentMethodWrapper record = new PaymentMethodWrapper();
          record.nickName =
            'BPAY Ending ' +
            recurringPayment.bpayPaymentMethod.customerReferenceNumber.right(4);
          record.description = '';
          record.address = '';
          record.validFrom = recurringPayment.validFrom;
          record.validTo = recurringPayment.validTo;
          paymentMethodRecords.add(record);
        }
        if (recurringPayment.payPalPaymentMethod != null) {
          PaymentMethodWrapper record = new PaymentMethodWrapper();
          record.nickName = 'PayPal Preapproval';
          record.description = 'PayPal';
          record.address = '';
          record.validFrom = recurringPayment.validFrom;
          record.validTo = recurringPayment.validTo;
          paymentMethodRecords.add(record);
        }
        if (recurringPayment.sepaDirectDebitPaymentMethod != null) {
          PaymentMethodWrapper record = new PaymentMethodWrapper();
          record.nickName = 'Custom';
          record.description =
            'Custom' + recurringPayment.sepaDirectDebitPaymentMethod.reference;
          record.address = 'Same as Billing Address';
          record.validFrom = recurringPayment.validFrom;
          record.validTo = recurringPayment.validTo;
          paymentMethodRecords.add(record);
        }
        if (recurringPayment.customPaymentMethod != null) {
          PaymentMethodWrapper record = new PaymentMethodWrapper();
          record.nickName = 'Custom';
          if (recurringPayment.customPaymentMethod.reference != null) {
            record.description =
              'Custom' + recurringPayment.customPaymentMethod.reference;
          } else {
            record.description = 'Custom';
          }
          record.address = '';
          record.validFrom = recurringPayment.validFrom;
          record.validTo = recurringPayment.validTo;
          paymentMethodRecords.add(record);
        }
      }
    }
    TRACTPaymentMethodWrapper wrapperObj = new TRACTPaymentMethodWrapper();
    wrapperObj.paymentMethodList = paymentMethodRecords;
    wrapperObj.totalPage = totalPages;
    return wrapperObj;
  }
  /**
   *   @description -Method to get condition to query Adjustments
   *
   */
  public static string conditionToQueryInvoiceAdjustmentApp(
    TractAdjustmentWrapper adjustmentWrap
  ) {
    string condition = '';
    for (AdjustmentWrapper wrap : adjustmentWrap.adjustmentListWrapper) {
      condition = condition + ' adjustmentEid eq \'' + wrap.eid + '\' or';
    }
    return condition;
  }
  /**
   *   @description -Method to parse Activity Events to ActivityEventsWrapper
   *
   */
  public static ActivityEventsWrapper parseActivityEvents(
    SoapApi33Domain.QueryResponse queryResponse,
    TRACTAccountWrapper tractBillingAccount
  ) {
    ActivityEventsWrapper activityEventWrap = new ActivityEventsWrapper();
    List<ActivityUsagesWrapper> activityWrapperList = new List<ActivityUsagesWrapper>();
    Integer totalPages;
    if (
      queryResponse.successful &&
      queryResponse != null &&
      queryResponse.usageEvents != null
    ) {
      if (
        queryResponse.usageEvents.usageEvent != null &&
        !queryResponse.usageEvents.usageEvent.isEmpty()
      ) {
        if (queryResponse.usageEvents.totalPages != null) {
          totalPages = queryResponse.usageEvents.totalPages;
        }
        for (
          SoapApi33Domain.UsageEvent usageEvent : queryResponse.usageEvents.usageEvent
        ) {
          ActivityUsagesWrapper activityWrap = new ActivityUsagesWrapper();
          activityWrap.description = usageEvent.description;
          activityWrap.totalCharge = setAccountBalanceCurrencyType(
            string.valueOf(usageEvent.totalCharge.setScale(2)),
            tractBillingAccount.accountCurrency
          );
          activityWrap.eventTime = usageEvent.startTime;
          activityWrap.serviceIdentifier = usageEvent.serviceResourceId;
          activityWrap.unitOfMeasure = usageEvent.usageUom.toLowerCase()
            .capitalize();
          activityWrap.amount = string.valueOf(
            usageEvent.usageAmount.setScale(0)
          );
          activityWrap.referenceID = usageEvent.referenceId;
          activityWrap.sequenceID = usageEvent.sequenceId;
          activityWrapperList.add(activityWrap);
        }
      }
    }
    activityEventWrap.getevents = activityWrapperList;
    activityEventWrap.size = totalPages;
    return activityEventWrap;
  }
  /**
   *   @description -Method to parse PriceLists to Price_List__c custom object list
   *
   */
  public static list<Price_List__c> parsePriceLists(
    SoapApi33Domain.QueryResponse queryResponse
  ) {
    list<Price_List__c> priceLists = new List<Price_List__c>();
    if (
      queryResponse.successful && null != queryResponse.priceLists.priceList
    ) {
      for (
        SoapApi33Domain.PriceList tractPriceList : queryResponse.priceLists.priceList
      ) {
        Price_List__c priceList = new Price_List__c();
        priceList.Name = tractPriceList.Name;
        priceList.eid__c = tractPriceList.eid;
        priceLists.add(priceList);
      }
    }
    return priceLists;
  }
  /**
   *   @description -Method to save products fetched from Gotransverse to the product2 object in SAlesforce
   *
   */
  public static void saveProducts(
    SoapApi33Domain.Product[] products,
    list<Price_List__c> listOfPriceList
  ) {
    Price_List__c priceList = listOfPriceList[0];
    //Prepare Different List for Products by Currency Types
    Map<string, PriceBook2> currencyVsPriceBook = new Map<string, PriceBook2>();
    list<PriceBook2> priceBookListToInsert = new List<PriceBook2>();
    //Selec all pricebooks
    Pricebook2[] priceBooks = [
      SELECT
        // where Name =: 'TRACT ' + currencyType + ' Price Book'];

        ID,
        Name,
        CurrencyType__c
      FROM Pricebook2
      LIMIT 50000
    ];
    //Pricebook2[] priceBookList = new List<Pricebook2>();
    for (Pricebook2 priceBook : priceBooks) {
      currencyVsPriceBook.put(priceBook.CurrencyType__c, priceBook);
    }
    Pricebook2 standardPB = new Pricebook2();
    if (!Test.isRunningTest()) {
      standardPB = [
        SELECT ID, Name
        FROM Pricebook2
        WHERE Name = :'Standard Price Book'
        LIMIT 50000
      ];
    } else {
      standardPB.Id = Test.getStandardPricebookId();
    }
    Product2[] productList = new List<Product2>();
    //Get Tract Product stored in SFDC
    Product2[] sfdcProducts = [
      SELECT id, Name, eid__c, PriceLists__c, Price_Information__c
      FROM Product2
      WHERE eid__c != NULL
      LIMIT 50000
    ];
    Map<string, Product2> eidProductMap = new Map<string, Product2>();
    for (Product2 tractSfdcProduct : sfdcProducts) {
      eidProductMap.put(tractSfdcProduct.eid__c, tractSfdcProduct);
    }
    Map<string, PricebookEntry> priceBookEntryMap = new Map<string, PricebookEntry>();
    PricebookEntry[] tractPiceBookEntryList = [
      SELECT id, Pricebook2Id, Product2Id, unitPrice, useStandardPrice
      FROM PricebookEntry
      LIMIT 50000
    ];
    PricebookEntry[] standardPriceBookEntryList = new List<PricebookEntry>();
    //Prepare Map of PriceBookEntry, Use PriceBookId and ProductId as unique key
    for (PricebookEntry pricebookEntry : tractPiceBookEntryList) {
      string key =
        string.valueOf(pricebookEntry.Pricebook2Id) +
        string.valueOf(pricebookEntry.Product2Id);
      priceBookEntryMap.put(key, pricebookEntry);
    }
    Map<string, Set<Product2>> currencyProductsMap = new Map<string, Set<Product2>>();
    //Create Map of Tract ProductPrice and Tract Price Range.
    for (SoapApi33Domain.Product product : products) {
      Product2 currentProduct = eidProductMap.get(product.eid);
      if (currentProduct == null) {
        currentProduct = new Product2();
        currentProduct.eid__c = product.eid;
        //map priceList eid and Name
        currentProduct.PriceLists__c = priceList.Name + ':' + priceList.eid__c;
        eidProductMap.put(product.eid, currentProduct);
      } else {
        if (
          currentProduct.PriceLists__c == '' ||
          currentProduct.PriceLists__c == null
        ) {
          currentProduct.PriceLists__c = '';
          currentProduct.PriceLists__c =
            priceList.Name +
            ':' +
            priceList.eid__c;
        } else if (
          currentProduct.PriceLists__c != '' &&
          currentProduct.PriceLists__c != null
        ) {
          currentProduct.PriceLists__c +=
            ',' +
            priceList.Name +
            ':' +
            priceList.eid__c;
        }
      }
      currentProduct.Gotransverse_Trail__c = product.trial;
      if (product.trialOverride != null) {
        currentProduct.Gotransverse_Trial_Length_Override__c = product.trialOverride;
      }
      currentProduct.Gotransverse_Trail_Days__c = product.trialDays;
      updateProductAttribute(currentProduct, product);
      SoapApi33Domain.ProductPrices productPrices = product.productPrices;
      string productPriceInformation = '';
      if (productPrices != null) {
        ProductPriceWrapper sfdcProductPrice;
        SoapApi33Domain.RecurringProductPrice[] recurringProductPriceList = productPrices.recurringProductPrice;
        SoapApi33Domain.OneTimeProductPrice[] oneTimeProductPriceList = productPrices.oneTimeProductPrice;
        list<ProductPriceWrapper> productPriceWrapperList = new List<ProductPriceWrapper>();
        PriceBook2 currencyPriceBookToInsert;
        if (
          oneTimeProductPriceList != null && !oneTimeProductPriceList.isEmpty()
        ) {
          for (
            SoapApi33Domain.OneTimeProductPrice priceOneTime : oneTimeProductPriceList
          ) {
            if (priceOneTime.thruDate == null) {
              sfdcProductPrice = new ProductPriceWrapper();
              sfdcProductPrice.eid = priceOneTime.eid;
              sfdcProductPrice.currencyType = priceOneTime.currencyType;
              //check if PriceBook exist for the price currency
              if (
                !currencyVsPriceBook.containsKey(sfdcProductPrice.currencyType)
              ) {
                currencyPriceBookToInsert = new Pricebook2(
                  Description = ('Latest ' +
                  sfdcProductPrice.currencyType +
                  ' Price Book'),
                  IsActive = true,
                  Name = ('GTV ' +
                  sfdcProductPrice.currencyType +
                  ' Price Book'),
                  currencyType__c = sfdcProductPrice.currencyType
                );
                priceBookListToInsert.add(currencyPriceBookToInsert);
                currencyVsPriceBook.put(
                  sfdcProductPrice.currencyType,
                  currencyPriceBookToInsert
                );
              }
              // fill the map having list of products of each currency
              if (
                currencyProductsMap.containsKey(sfdcProductPrice.currencyType)
              ) {
                Set<Product2> productSet = currencyProductsMap.get(
                  sfdcProductPrice.currencyType
                );
                if (!productSet.contains(currentProduct)) {
                  productSet.add(currentProduct);
                  currencyProductsMap.put(
                    sfdcProductPrice.currencyType,
                    productSet
                  );
                }
              } else {
                Set<Product2> productSet = new Set<Product2>();
                productSet.add(currentProduct);
                currencyProductsMap.put(
                  sfdcProductPrice.currencyType,
                  productSet
                );
              }
              sfdcProductPrice.fromDate = TractSFDC_Util.productPriceFormat(
                priceOneTime.fromDate
              );
              sfdcProductPrice.thruDate = priceOneTime.thruDate;
              sfdcProductPrice.scheduledCharges = priceOneTime.allowScheduledCharges ==
                null
                ? false
                : priceOneTime.allowScheduledCharges;
              sfdcProductPrice.priceOverride = priceOneTime.priceOverride ==
                null
                ? true
                : priceOneTime.priceOverride;
              sfdcProductPrice.priceType = priceOneTime.type_x;
              sfdcProductPrice.priceListEid = priceList.eid__c;
              if (priceOneTime.priceRanges != null) {
                SoapApi33Domain.PriceRanges priceRanges = priceOneTime.priceRanges;
                SoapApi33Domain.PriceRange[] priceRangeList = priceRanges.priceRange;
                sfdcProductPrice.priceRangesList = createPriceRangeList(
                  priceRangeList
                );
              }
              if (priceOneTime.priceCategory != null) {
                sfdcProductPrice.priceCategory = priceOneTime.priceCategory.name;
                sfdcProductPrice.priceCategoryId = priceOneTime.priceCategory.eid;
              }
              sfdcProductPrice.paymentOnPurchaseRequired = priceOneTime.paymentOnPurchaseRequired;
              productPriceWrapperList.add(sfdcProductPrice);
            }
          }
        }
        if (
          recurringProductPriceList != null &&
          !recurringProductPriceList.isEmpty()
        ) {
          for (
            SoapApi33Domain.RecurringProductPrice price : recurringProductPriceList
          ) {
            if (price.thruDate == null) {
              sfdcProductPrice = new ProductPriceWrapper();
              sfdcProductPrice.eid = price.eid;
              sfdcProductPrice.recurringPaymentRequired = price.recurringPaymentRequired ==
                null
                ? false
                : price.recurringPaymentRequired;
              sfdcProductPrice.currencyType = price.currencyType;
              //check if PriceBook exist for the price currency
              if (
                !currencyVsPriceBook.containsKey(sfdcProductPrice.currencyType)
              ) {
                currencyPriceBookToInsert = new Pricebook2(
                  Description = ('Latest ' +
                  sfdcProductPrice.currencyType +
                  ' Price Book'),
                  IsActive = true,
                  Name = ('GTV ' +
                  sfdcProductPrice.currencyType +
                  ' Price Book'),
                  currencyType__c = sfdcProductPrice.currencyType
                );
                priceBookListToInsert.add(currencyPriceBookToInsert);
                currencyVsPriceBook.put(
                  sfdcProductPrice.currencyType,
                  currencyPriceBookToInsert
                );
              }
              // fill the map having list of products of each currency
              if (
                currencyProductsMap.containsKey(sfdcProductPrice.currencyType)
              ) {
                Set<Product2> productSet = currencyProductsMap.get(
                  sfdcProductPrice.currencyType
                );
                if (!productSet.contains(currentProduct)) {
                  productSet.add(currentProduct);
                  currencyProductsMap.put(
                    sfdcProductPrice.currencyType,
                    productSet
                  );
                }
              } else {
                Set<Product2> productSet = new Set<Product2>();
                productSet.add(currentProduct);
                currencyProductsMap.put(
                  sfdcProductPrice.currencyType,
                  productSet
                );
              }
              sfdcProductPrice.fromDate = TractSFDC_Util.productPriceFormat(
                price.fromDate
              );
              sfdcProductPrice.scheduledCharges = price.allowScheduledCharges ==
                null
                ? false
                : price.allowScheduledCharges;
              sfdcProductPrice.paymentOnPurchaseRequired = price.paymentOnPurchaseRequired ==
                null
                ? false
                : price.paymentOnPurchaseRequired;
              sfdcProductPrice.priceOverride = price.priceOverride == null
                ? true
                : price.priceOverride;
              sfdcProductPrice.recurrencePeriod = price.recurrencePeriod;
              sfdcProductPrice.thruDate = price.thruDate;
              sfdcProductPrice.priceType = price.type_x;
              sfdcProductPrice.priceListEid = priceList.eid__c;
              if (price.priceRanges != null) {
                SoapApi33Domain.PriceRanges priceRanges = price.priceRanges;
                SoapApi33Domain.PriceRange[] priceRangeList = priceRanges.priceRange;
                sfdcProductPrice.priceRangesList = createPriceRangeList(
                  priceRangeList
                );
              }
              if (price.priceCategory != null) {
                sfdcProductPrice.priceCategory = price.priceCategory.name;
                sfdcProductPrice.priceCategoryId = price.priceCategory.eid;
              }
              sfdcProductPrice.proratedOnOrderNoCharge = price.proratedOnOrderNoCharge;
              sfdcProductPrice.proratedOnOrder = price.proratedOnOrder;
              sfdcProductPrice.proratedOnCancel = price.proratedOnCancel;
              sfdcProductPrice.recurringPaymentRequired = price.recurringPaymentRequired;
              sfdcProductPrice.paymentOnPurchaseRequired = price.paymentOnPurchaseRequired;
              sfdcProductPrice.billInAdvance = price.billInAdvance;
              productPriceWrapperList.add(sfdcProductPrice);
            }
          }
        }
        if (currentProduct.Price_Information__c != null) {
          list<ProductPriceWrapper> existingProductPriceWrapperList = new List<ProductPriceWrapper>();
          existingProductPriceWrapperList = (List<ProductPriceWrapper>) JSON.deserialize(
            currentProduct.Price_Information__c,
            List<ProductPriceWrapper>.class
          );
          productPriceWrapperList.addall(existingProductPriceWrapperList);
        }
        productPriceInformation = JSON.serialize(productPriceWrapperList);
        currentProduct.Price_Information__c = productPriceInformation;
      }
      ProductCategoryWrapper catWrap = new ProductCategoryWrapper();
      catWrap.categoryId = product.productCategory.eid;
      catWrap.Name = product.productCategory.name;
      currentProduct.Gotransverse_Product_Category__c = JSON.serialize(catWrap);
      productList.add(currentProduct);
    }
    if (
      TRACTAPIUtil.checkFieldLevelSecurity(
        'Product2',
        'eid__c,PriceLists__c,',
        'Upsert'
      )
    ) {
      upsert productList;
    }
    if (priceBookListToInsert.size() > 0) {
      if (
        TRACTAPIUtil.checkFieldLevelSecurity(
          'Pricebook2',
          'Description,IsActive,Name,currencyType__c',
          'Create'
        )
      ) {
        insert priceBookListToInsert;
      }
    }
    map<string, Pricebookentry> productIdVsPricebookentry = new Map<string, Pricebookentry>();
    for (string currencyType : currencyProductsMap.keySet()) {
      Id currencyPricebookId = currencyVsPriceBook.get(currencyType).Id;
      Set<Product2> currencyProducts = currencyProductsMap.get(currencyType);
      for (Product2 product2 : currencyProducts) {
        if (!productIdVsPricebookentry.containsKey(product2.id)) {
          PricebookEntry standardPBE = priceBookEntryMap.get(
            string.valueOf(standardPB.ID) + string.valueOf(product2.Id)
          );
          productIdVsPricebookentry.put(product2.id, standardPBE);
          if (standardPBE == null) {
            standardPBE = new PricebookEntry(
              Pricebook2Id = standardPB.ID,
              Product2Id = product2.Id,
              IsActive = true,
              UnitPrice = 0,
              UseStandardPrice = false
            );
            productIdVsPricebookentry.put(product2.id, standardPBE);
            standardPriceBookEntryList.add(standardPBE);
          }
        }
        PricebookEntry pbe = priceBookEntryMap.get(
          string.valueOf(currencyPricebookId) + string.valueOf(product2.Id)
        );
        if (pbe == null) {
          pbe = new PricebookEntry(
            Pricebook2Id = currencyPricebookId,
            Product2Id = product2.Id,
            IsActive = true,
            UnitPrice = 0,
            UseStandardPrice = false
          );
          tractPiceBookEntryList.add(pbe);
        }
      }
    }
    if (
      TRACTAPIUtil.checkFieldLevelSecurity(
        'PricebookEntry',
        'Pricebook2Id,Product2Id,IsActive,UnitPrice,UseStandardPrice',
        'Upsert'
      )
    ) {
      upsert standardPriceBookEntryList;
      upsert tractPiceBookEntryList;
    }
  }
  /**
   *   @description -Method to save product based agreements to ProductAgreementWrapper list
   *
   */
  public static list<ProductAgreementWrapper> saveAgreements(
    SoapApi33Domain.QueryResponse queryResponse
  ) {
    list<ProductAgreementWrapper> agreementList = new List<ProductAgreementWrapper>();
    if (queryResponse.successful) {
      if (
        queryResponse.agreements.agreement != null &&
        queryResponse.agreements.agreement.size() > 0
      ) {
        for (
          SoapApi33Domain.Agreement ag : queryResponse.agreements.agreement
        ) {
          if (ag.status == 'ACTIVE') {
            ProductAgreementWrapper agreementObj = new ProductAgreementWrapper();
            agreementObj.Name = ag.name;
            agreementObj.eid = ag.eid;
            agreementObj.status = ag.status;
            agreementObj.agreementPeriod = ag.agreementPeriod;
            if (ag.agreementPeriod == 1) {
              agreementObj.agreementPeriodType = ag.agreementPeriodType.toLowerCase()
                .capitalize();
            } else {
              agreementObj.agreementPeriodType =
                ag.agreementPeriodType.toLowerCase().capitalize() + 's';
            }
            agreementObj.endAction = ag.endAction;
            if (ag.adjustmentCategory != null) {
              agreementObj.adjustmentCategory = ag.adjustmentCategory.name;
            }
            if (null != ag.maxTerminationFeeCurrencyType) {
              agreementObj.currencyType = ag.maxTerminationFeeCurrencyType;
            } else if (null != ag.minimumAmountCurrencyType) {
              agreementObj.currencyType = ag.minimumAmountCurrencyType;
            } else if (null != ag.terminationFeeCurrencyType) {
              agreementObj.currencyType = ag.terminationFeeCurrencyType;
            }
            if (ag.terminationFlatCharge != null) {
              agreementObj.terminationFlatCharge = setAccountBalanceCurrencyType(
                string.valueof(ag.terminationFlatCharge),
                agreementObj.currencyType
              );
            } else if (ag.terminationPercentageCharge != null) {
              agreementObj.terminationFlatCharge =
                string.valueof(
                  (ag.terminationPercentageCharge * 100).setScale(2)
                ) + '%';
            }
            agreementList.add(agreementObj);
          }
        }
      }
    }
    return agreementList;
  }
  /**
   *   @description -Method to parse Billing Account Services to TractServiceWrapper
   *
   */
  public static TractServiceWrapper parseBillingAccountServices(
    SoapApi33Domain.QueryResponse queryResponse
  ) {
    List<Service__c> services = new List<Service__c>();
    TractServiceWrapper serviceWrapper = new TractServiceWrapper();
    Integer totalpage;
    SoapApi33Domain.Service[] accountServices;
    /* Check if Services exist or not */
    if (queryResponse.successful && null != queryResponse.services.service) {
      accountServices = queryResponse.services.service;
      totalpage = queryResponse.services.totalPages;
    }
    if (accountServices != null && !accountServices.isEmpty()) {
      for (SoapApi33Domain.Service srv : accountServices) {
        Service__c temp = new Service__c(
          Name = srv.description,
          Service_Agreement__c = null != srv.currentAgreementService
            ? srv.currentAgreementService.agreement.eid
            : '',
          Amount__c = srv.amount,
          ServiceEid__c = srv.eid,
          Quantity__c = srv.quantity,
          Service_Amount__c = srv.amount.setScale(2),
          Status__c = getServiceStatus(srv.status),
          StatusDate__c = srv.status.equals('SERVICE_DEACTIVATED')
            ? srv.endDate.date()
            : srv.startDate.date(),
          checkDeactivate__c = srv.status == 'SERVICE_ACTIVE' ? true : false,
          SuspendService__c = srv.status == 'SERVICE_SUSPENDED' ? true : false,
          CommitedThru__c = srv.currentAgreementService != null
            ? srv.currentAgreementService.endDate.date()
            : null,
          RenewAction__c = srv.currentAgreementService != null
            ? TractSFDC_Util.convertToCamelCase(
                srv.currentAgreementService.endAction,
                '_'
              )
            : '',
          ParentService__r = srv.parentService != null
            ? new Service__C(Name = srv.parentService.description)
            : new Service__C(Name = ''),
          Parent_Service_Eid__c = srv.product.productTypeCode == 'ADDON'
            ? srv.parentService.eid
            : '',
          ProductEid__c = srv.product.eid,
          serialized__c = srv.product.serialized,
          ServiceProductName__c = srv.product.name,
          CheckRuleOverride__c = srv.product.ruleOverride,
          ProductRuleType__c = srv.product.ruleType,
          ServiceResourceNumber__c = srv.serviceResources != null
            ? srv.serviceResources.totalElements
            : null,
          ServiceProductCode__c = srv.product.productTypeCode != null
            ? srv.product.productTypeCode
            : '',
          canAddNewServiceResource__c = (srv.product.maxServiceResources > 0 &&
            (srv.serviceResources == null ||
            srv.product.maxServiceResources >
            srv.serviceResources.totalElements))
            ? true
            : false
        );
        services.add(temp);
      }
    }
    /* added the value into wrapper variable */
    serviceWrapper.serviceList = services;
    serviceWrapper.totalPage = totalpage;
    /* return the wrapper instance */
    return serviceWrapper;
  }
  //Common Utils
  public static string getServiceStatus(string status) {
    string result = '';
    string temp = status.substringAfter('_');
    temp = temp.toLowerCase();
    result = temp.capitalize();
    return result;
  }
  /**
   *   @description -Used by saveProduct method to update product Attributes
   *
   */
  private static void updateProductAttribute(
    Product2 sfdcProduct,
    SoapApi33Domain.Product tractProduct
  ) {
    sfdcProduct.Name = tractProduct.name;
    sfdcProduct.Short_Desc__c = tractProduct.shortDescription;
    sfdcProduct.Description = tractProduct.description;
    sfdcProduct.IsActive = true;
    sfdcProduct.Family = 'TRACT';
    sfdcProduct.ProductCode = tractProduct.productTypeCode == 'GENERAL_PRODUCT'
      ? 'One-Time'
      : tractProduct.productTypeCode == 'ADDON'
          ? 'Add-on'
          : tractProduct.productTypeCode.toLowerCase().capitalize();
    sfdcProduct.eid__c = tractProduct.eid;
    sfdcProduct.Requires_Agreement__c = tractProduct.requiresAgreement;
    sfdcProduct.maxServiceResources__c = tractProduct.maxServiceResources;
    sfdcProduct.minServiceResources__c = tractProduct.minServiceResources;
    if (true == tractProduct.ruleOverride) {
      sfdcProduct.RuleOverride__c = tractProduct.ruleOverride;
    }
    if (null != tractProduct.ruleType) {
      sfdcProduct.RuleType__c = tractProduct.ruleType;
    }
    if (tractProduct.serviceResourceCategory != null) {
      sfdcProduct.Service_Resource_Category__c = tractProduct.serviceResourceCategory.name;
      sfdcProduct.SRC_eid__c = tractProduct.serviceResourceCategory.eid;
      sfdcProduct.SRC_Status__c = tractProduct.serviceResourceCategory.status;
      sfdcProduct.SRC_Type__c = tractProduct.serviceResourceCategory.type_x;
    }
    sfdcProduct.Serialized__c = tractProduct.serialized;
  }
  /**
   *   @description -Method to create Price range list for a particular product
   *
   */
  private static list<ProductPriceRangeWrapper> createPriceRangeList(
    SoapApi33Domain.PriceRange[] priceRangeList
  ) {
    list<ProductPriceRangeWrapper> priceRangeWrapperList = new List<ProductPriceRangeWrapper>();
    if (priceRangeList != null && !priceRangeList.isEmpty()) {
      ProductPriceRangeWrapper sfdcPriceRange;
      for (SoapApi33Domain.PriceRange priceRange : priceRangeList) {
        sfdcPriceRange = new ProductPriceRangeWrapper();
        sfdcPriceRange.eid = priceRange.eid;
        sfdcPriceRange.currencyType = priceRange.currencyType;
        sfdcPriceRange.quantityEndRange = priceRange.quantityEndRange;
        sfdcPriceRange.level = priceRange.level;
        sfdcPriceRange.price = priceRange.price;
        sfdcPriceRange.quantityBeginRange = priceRange.quantityBeginRange;
        priceRangeWrapperList.add(sfdcPriceRange);
      }
    }
    return priceRangeWrapperList;
  }
  /**
   *   @description -Method to parse Payment terms to Payment_Term__c custom object list
   *
   */
  public static list<Payment_Term__c> parsePaymentTerms(
    SoapApi33Domain.QueryResponse queryResponse
  ) {
    list<Payment_Term__c> paymentTermList = new List<Payment_Term__c>();
    if (
      queryResponse.successful && null != queryResponse.paymentTerms.paymentTerm
    ) {
      Payment_Term__c paymentTermObj;
      for (
        SoapApi33Domain.paymentTerm paymentTrm : queryResponse.paymentTerms.paymentTerm
      ) {
        paymentTermObj = new Payment_Term__c();
        paymentTermObj.name = paymentTrm.name;
        paymentTermObj.eid__c = paymentTrm.eid;
        paymentTermList.add(paymentTermObj);
      }
    }
    return paymentTermList;
  }
  /**
   *   @description -Method to map Billing Account Services to TractServiceWrapper
   *
   */
  public static TractServiceWrapper mapBillingAccountServices(
    Account thisAccount,
    list<SelectOption> stateCan,
    list<SelectOption> stateMex,
    list<SelectOption> stateUsa,
    list<SelectOption> countryList,
    List<SelectOption> serviceReasons,
    List<SelectOption> suspendServicesReason,
    TRACTAccountWrapper tractBillingAccount,
    AccountDetailController_LT.ChargeRulesWrapper chargeRules,
    TRACT_Setup__c tract,
    SoapApi33Domain.Service[] accountServices,
    map<String, list<SoapApi33Domain.serviceResource>> servicesIDvsResoucesMap,
    Integer totalpages,
    Map<String, String> systemSettingAccountMap
  ) {
    TractServiceWrapper serviceWrapper = new TractServiceWrapper();
    list<ProductServiceWrapper> childServiceProducts = new List<ProductServiceWrapper>();
    list<ProductServiceWrapper> serviceProducts = new List<ProductServiceWrapper>();
    map<String, list<ProductServiceWrapper>> productServiceEidVSServiceWrapperMap = new Map<String, list<ProductServiceWrapper>>();
    String tractUrl;
    tractUrl = tract.TRACT_URL__c;
    tractUrl = tractUrl.substring(0, tractUrl.indexof('com') + 3);
    String accID = thisAccount.Tract_Billing_Account__c;
    tractUrl = tractUrl + '/t/w/billingAccount/billingAccountNumber/' + accID;

    for (SoapApi33Domain.Service srv : accountServices) {
      ProductServiceWrapper proWrap = new ProductServiceWrapper();
      if (thisAccount.Tract_Billing_Account__c != null) {
        proWrap.createBillingAccount = true;
      }
      proWrap.thisAccount = thisAccount;
      proWrap.reasonList = serviceReasons;
      proWrap.suspendReasonList = suspendServicesReason;
      proWrap.TractUrl = tractUrl;
      proWrap.thistract = tract;
      proWrap.chargeRuleWrapper = chargeRules;
      proWrap.countryListTract = countryList;
      proWrap.stateUsaTract = stateUsa;
      proWrap.stateMexTract = stateMex;
      proWrap.stateCanTract = stateCan;
      proWrap.serviceName = srv.description;
      proWrap.serviceProductCode = srv.product.productTypeCode != null
        ? srv.product.productTypeCode
        : '';
      proWrap.parentServiceName = srv.parentService != null
        ? srv.parentService.description
        : '';

      Date commitedThru = srv.currentAgreementService != null
        ? srv.currentAgreementService.endDate.date()
        : null;
      if (null != commitedThru) {
        proWrap.committedThru = TractSFDC_Util.changeDateFormat(
          String.valueOf(commitedThru)
        );
      }
      proWrap.renewAction = srv.currentAgreementService != null
        ? TractSFDC_Util.convertToCamelCase(
            srv.currentAgreementService.endAction,
            '_'
          )
        : '';
      proWrap.statusDate = TractSFDC_Util.changeDateFormat(
        String.valueOf(
          srv.status.equals('SERVICE_DEACTIVATED')
            ? srv.endDate.date()
            : srv.startDate.date()
        )
      );
      proWrap.status = getServiceStatus(srv.status);
      proWrap.checkDeactivateService = srv.status == 'SERVICE_ACTIVE'
        ? true
        : false;
      proWrap.checkSuspendService = srv.status == 'SERVICE_SUSPENDED'
        ? true
        : false;
      proWrap.checkTrailService = srv.status == 'SERVICE_TRIAL' ? true : false;
      proWrap.serviceEid = srv.eid;
      proWrap.servicProducteName = srv.product.name;
      proWrap.checkProductEid = srv.product.eid;
      proWrap.serialized = srv.product.serialized;
      proWrap.Quantity = srv.quantity;
      proWrap.checkRuleOverrideValue = srv.product.ruleOverride;
      proWrap.ruleTypeValue = srv.product.ruleType;
      proWrap.checkParentServiceEId = srv.product.productTypeCode == 'ADDON'
        ? srv.parentService.eid
        : '';
      proWrap.serviceResourceNumber = srv.serviceResources != null
        ? srv.serviceResources.totalElements
        : null;
      proWrap.canAddServiceResource = (srv.product.maxServiceResources > 0 &&
        (srv.serviceResources == null ||
        srv.product.maxServiceResources > srv.serviceResources.totalElements))
        ? true
        : false;
      Decimal serviceAmount = srv.amount.setScale(2);
      proWrap.servicePrice = TractSFDC_Util.setBalanceCurrencyType(
        String.valueOf(serviceAmount),
        tractBillingAccount.accountCurrency
      );
      proWrap.childElements = new List<ProductServiceWrapper>();
      if (servicesIDvsResoucesMap.containsKey(proWrap.serviceEid)) {
        proWrap.checkChildElement = true;
        for (
          SoapApi33Domain.serviceResource service : servicesIDvsResoucesMap.get(
            proWrap.serviceEid
          )
        ) {
          ProductServiceWrapper proWrap2 = new ProductServiceWrapper();
          proWrap2.serviceName = service.identifier;
          proWrap2.serviceEid = service.eid;
          proWrap2.checkServiceResource = true;
          proWrap2.statusDate = proWrap.statusDate;
          proWrap2.checkDeactivateService = proWrap.checkDeactivateService;
          proWrap2.checkSuspendService = proWrap.checkSuspendService;
          proWrap2.status = proWrap.status;
          proWrap.childElements.add(proWrap2);
        }
      }
      if (
        null != proWrap.checkParentServiceEId &&
        '' != proWrap.checkParentServiceEId
      ) {
        proWrap.parentServiceEId = proWrap.checkParentServiceEId;
        proWrap.productEid = proWrap.checkProductEid;
        if (
          productServiceEidVSServiceWrapperMap.containsKey(
            proWrap.parentServiceEId
          )
        ) {
          productServiceEidVSServiceWrapperMap.get(proWrap.parentServiceEId)
            .add(proWrap);
        } else {
          productServiceEidVSServiceWrapperMap.put(
            proWrap.parentServiceEId,
            new List<ProductServiceWrapper>()
          );
          productServiceEidVSServiceWrapperMap.get(proWrap.parentServiceEId)
            .add(proWrap);
        }
        childServiceProducts.add(proWrap);
      } else {
        proWrap.parentServiceEId = '';
        proWrap.productEid = proWrap.checkProductEid;
        serviceProducts.add(proWrap);
      }
    }
    for (ProductServiceWrapper proWrap : serviceProducts) {
      for (ProductServiceWrapper proWrap1 : childServiceProducts) {
        if (proWrap.serviceEid == proWrap1.parentServiceEId) {
          proWrap.checkChildElement = true;

          if (proWrap.checkSuspendService == proWrap1.checkSuspendService) {
            proWrap1.childServiceSuspendCheck = true;
          } else {
            proWrap1.childServiceSuspendCheck = false;
          }
          if (
            productServiceEidVSServiceWrapperMap.containsKey(
              proWrap1.serviceEid
            )
          ) {
            proWrap1.checkChildElement = true;
            proWrap1.childElements.addAll(
              productServiceEidVSServiceWrapperMap.get(proWrap1.serviceEid)
            );
          }
          proWrap.childElements.add(proWrap1);
        }
      }
    }
    serviceWrapper.productServiceWrap = serviceProducts;
    serviceWrapper.totalPage = (totalPages);
    return serviceWrapper;
  }
  /**
   *   @description -Method to map Service Resources to ProductServiceWrapper
   *
   */
  public static ProductServiceWrapper mapserviceResourcesByServiceEid(
    SoapApi33Domain.serviceResource service
  ) {
    ProductServiceWrapper proWrap2 = new ProductServiceWrapper();
    proWrap2.serviceName = service.identifier;
    proWrap2.serviceEid = service.eid;
    proWrap2.checkServiceResource = true;
    return proWrap2;
  }
  /**
   *   @description -Method to parse Bill Cycles to TRACT_Bill_Cycle__c custom object list
   *
   */
  public static list<TRACT_Bill_Cycle__c> parseBillCycles(
    SoapApi33Domain.QueryResponse queryResponse
  ) {
    list<TRACT_Bill_Cycle__c> listOfBillCycles = new List<TRACT_Bill_Cycle__c>();
    if (queryResponse.successful) {
      if (
        queryResponse.successful &&
        null != queryResponse.billCycles.dailyBillCycle
      ) {
        for (
          SoapApi33Domain.DailyBillCycle theBC : queryResponse.billCycles.dailyBillCycle
        ) {
          TRACT_Bill_Cycle__c dailyBillCycle = new TRACT_Bill_Cycle__c();
          dailyBillCycle.Eid__c = theBC.eid;
          dailyBillCycle.Bill_Cycle_Type__c = theBC.billCycleType;
          dailyBillCycle.Name = theBC.name;
          dailyBillCycle.TRACT_Bill_Cycle_Currency_Type__c = theBC.currencytype;
          if (theBC.billingAccountCategory != null) {
            dailyBillCycle.Billing_Account_Category_Eid__c = theBC.billingAccountCategory.eid;
          }
          listOfBillCycles.add(dailyBillCycle);
        }
      }
      if (
        queryResponse.successful &&
        null != queryResponse.billCycles.monthlyBillCycle
      ) {
        for (
          SoapApi33Domain.MonthlyBillCycle theBC : queryResponse.billCycles.monthlyBillCycle
        ) {
          TRACT_Bill_Cycle__c monthlyBillCycle = new TRACT_Bill_Cycle__c();
          monthlyBillCycle.Eid__c = theBC.eid;
          monthlyBillCycle.Bill_Cycle_Type__c = theBC.billCycleType;
          monthlyBillCycle.Name = theBC.name;
          monthlyBillCycle.TRACT_Bill_Cycle_Currency_Type__c = theBC.currencytype;
          if (theBC.billingAccountCategory != null) {
            monthlyBillCycle.Billing_Account_Category_Eid__c = theBC.billingAccountCategory.eid;
          }
          listOfBillCycles.add(monthlyBillCycle);
        }
      }
      if (
        queryResponse.successful &&
        null != queryResponse.billCycles.quarterlyBillCycle
      ) {
        for (
          SoapApi33Domain.QuarterlyBillCycle theBC : queryResponse.billCycles.quarterlyBillCycle
        ) {
          TRACT_Bill_Cycle__c quarterlyBillCycle = new TRACT_Bill_Cycle__c();
          quarterlyBillCycle.Eid__c = theBC.eid;
          quarterlyBillCycle.Bill_Cycle_Type__c = theBC.billCycleType;
          quarterlyBillCycle.Name = theBC.name;
          quarterlyBillCycle.TRACT_Bill_Cycle_Currency_Type__c = theBC.currencytype;
          if (theBC.billingAccountCategory != null) {
            quarterlyBillCycle.Billing_Account_Category_Eid__c = theBC.billingAccountCategory.eid;
          }
          listOfBillCycles.add(quarterlyBillCycle);
        }
      }
      if (
        queryResponse.successful &&
        null != queryResponse.billCycles.segmentedMonthlyBillCycle
      ) {
        for (
          SoapApi33Domain.SegmentedMonthlyBillCycle theBC : queryResponse.billCycles.segmentedMonthlyBillCycle
        ) {
          TRACT_Bill_Cycle__c segmentedMonthlyBillCycle = new TRACT_Bill_Cycle__c();
          segmentedMonthlyBillCycle.Eid__c = theBC.eid;
          segmentedMonthlyBillCycle.Bill_Cycle_Type__c = theBC.billCycleType;
          segmentedMonthlyBillCycle.Name = theBC.name;
          segmentedMonthlyBillCycle.TRACT_Bill_Cycle_Currency_Type__c = theBC.currencytype;
          if (theBC.billingAccountCategory != null) {
            segmentedMonthlyBillCycle.Billing_Account_Category_Eid__c = theBC.billingAccountCategory.eid;
          }
          listOfBillCycles.add(segmentedMonthlyBillCycle);
        }
      }
      if (
        queryResponse.successful &&
        null != queryResponse.billCycles.yearlyBillCycle
      ) {
        for (
          SoapApi33Domain.YearlyBillCycle theBC : queryResponse.billCycles.yearlyBillCycle
        ) {
          TRACT_Bill_Cycle__c yearlyBillCycle = new TRACT_Bill_Cycle__c();
          yearlyBillCycle.Eid__c = theBC.eid;
          yearlyBillCycle.Bill_Cycle_Type__c = theBC.billCycleType;
          yearlyBillCycle.Name = theBC.name;
          yearlyBillCycle.TRACT_Bill_Cycle_Currency_Type__c = theBC.currencytype;
          if (theBC.billingAccountCategory != null) {
            yearlyBillCycle.Billing_Account_Category_Eid__c = theBC.billingAccountCategory.eid;
          }
          listOfBillCycles.add(yearlyBillCycle);
        }
      }
    }
    return listOfBillCycles;
  }
  /**
   *   @description -Method to parse Billing Account Categories to TRACTBillingAccountCategory__c custom object list
   *
   */
  public static list<TRACTBillingAccountCategory__c> parseBillingAccountCategories(
    SoapApi33Domain.QueryResponse queryResponse
  ) {
    List<TRACTBillingAccountCategory__c> bacList = new List<TRACTBillingAccountCategory__c>();
    TRACTBillingAccountCategory__c tractBac;
    if (
      queryResponse.successful &&
      null != queryResponse.billingAccountCategories.billingAccountCategory
    ) {
      for (
        SoapApi33Domain.BillingAccountCategory theBAC : queryResponse.billingAccountCategories.billingAccountCategory
      ) {
        tractBac = new TRACTBillingAccountCategory__c();
        tractBac.eid__c = theBAC.eid;
        tractBac.description__c = theBAC.description;
        tractBac.type_x__c = theBAC.type_x;
        tractBac.status__c = theBAC.status;
        bacList.add(tractBac);
      }
    }
    return bacList;
  }
  /**
   *   @description -Method to parse Order Custom Field to Tract_Order_Custom_Field__c custom object list
   *
   */
  public static list<Tract_Order_Custom_Field__c> parseOrderCustomField(
    SoapApi33Domain.QueryResponse queryResponse
  ) {
    list<Tract_Order_Custom_Field__c> orderCustomFieldsList = new List<Tract_Order_Custom_Field__c>();
    if (
      queryResponse.successful && null != queryResponse.customFields.customField
    ) {
      Tract_Order_Custom_Field__c orderCustomFieldObj;
      string listValues;
      for (
        SoapApi33Domain.customField theCus : queryResponse.customFields.customField
      ) {
        listValues = '';
        orderCustomFieldObj = new Tract_Order_Custom_Field__c();
        orderCustomFieldObj.Eid__c = theCus.eid;
        orderCustomFieldObj.Name = theCus.Name;
        orderCustomFieldObj.ValidationType__c = theCus.fieldValidationType;
        if (theCus.fieldType == 'LIST') {
          orderCustomFieldObj.orderCustomFieldType__c = theCus.fieldType;
          if (null != theCus.customFieldValueReferences) {
            SoapApi33Domain.CustomFieldValueReference[] customReference = theCus.customFieldValueReferences.customFieldValueReference;
            for (
              SoapApi33Domain.CustomFieldValueReference addValues : customReference
            ) {
              listValues += ',' + addValues.value;
            }
            orderCustomFieldObj.Store_Order_List_Value__c = listValues.substring(
              1
            );
          }
        }
        orderCustomFieldsList.add(orderCustomFieldObj);
      }
    }
    return orderCustomFieldsList;
  }
  /**
   *   @description -Method to map Discounts to Product2AddWrapper
   *
   */
  public static Product2AddWrapper mapDiscounts(
    Product2AddWrapper productWrapper,
    SoapApi33Domain.QueryResponse queryResponse,
    string discountName
  ) {
    if (
      queryResponse.successful &&
      queryResponse != null &&
      queryResponse.discountIdentifiers != null &&
      queryResponse.discountIdentifiers.discountIdentifier != null &&
      !queryResponse.discountIdentifiers.discountIdentifier.isEmpty()
    ) {
      string discount100PercentIdentifeirEid = '';
      for (
        SoapApi33Domain.DiscountIdentifier dItentifier : queryResponse.discountIdentifiers.discountIdentifier
      ) {
        discount100PercentIdentifeirEid = dItentifier.eid;
        break;
      }
      productWrapper.discountEid = discount100PercentIdentifeirEid;
      productWrapper.discountName = discountName;
    } else {
      productWrapper.errorMessage =
        discountName +
        ' is an invalid discount code' +
        '.';
    }
    return productWrapper;
  }
  /**
   *   @description -Method to map Service Resource to ServiceResourceWrapper
   *
   */
  public static ServiceResourceWrapper mapServiceResource(
    SoapApi33Domain.QueryResponse queryResponse,
    string srId,
    ServiceResourceWrapper srWrapper
  ) {
    for (
      SoapApi33Domain.ServiceResource services : queryResponse.serviceResources.serviceResource
    ) {
      if (services.status == 'AVAILABLE') {
        srWrapper.eid = services.eid;
        srWrapper.identifier = srId;
      } else {
        srWrapper.errorMessage =
          srId +
          ' must have status as AVAILABLE to be applied on a order item.';
      }
      break;
    }
    return srWrapper;
  }
  /**
   *   @description -Method to map Global Usage Rules to SelectOption llist
   *
   */
  public static list<SelectOption> mapGlobalUsageRules(
    SoapApi33Domain.QueryResponse queryResponse
  ) {
    list<SelectOption> formulaUsageRuleSpecificationList = new List<SelectOption>();
    formulaUsageRuleSpecificationList.add(
      new SelectOption('Choose One', 'Choose One')
    );
    if (
      queryResponse.globalUsageRules.globalUsageRule != null &&
      !queryResponse.globalUsageRules.globalUsageRule.isEmpty()
    ) {
      SoapApi33Domain.GlobalUsageRule[] globalUsage = queryResponse.globalUsageRules.globalUsageRule;
      for (SoapApi33Domain.GlobalUsageRule globalRules : globalUsage) {
        if (globalRules.status == 'ACTIVE') {
          formulaUsageRuleSpecificationList.add(
            new SelectOption(globalRules.eid, globalRules.name)
          );
        }
      }
    }
    return formulaUsageRuleSpecificationList;
  }
  /**
   *   @description -Method to map Credit Adjustment Reasons to SelectOption llist
   *
   */
  public static list<SelectOption> mapCreditAdjustmentReasons(
    SoapApi33Domain.QueryResponse queryResponse
  ) {
    list<SelectOption> adjustmentReasonList = new List<SelectOption>();
    if (
      queryResponse.successful &&
      queryResponse != null &&
      queryResponse.adjustmentReasons != null
    ) {
      adjustmentReasonList.add(new SelectOption('', 'Choose One'));
      if (
        queryResponse.adjustmentReasons.adjustmentReason != null &&
        !queryResponse.adjustmentReasons.adjustmentReason.isEmpty()
      ) {
        for (
          SoapApi33Domain.AdjustmentReason adjustmentReasons : queryResponse.adjustmentReasons.adjustmentReason
        ) {
          if (
            true == adjustmentReasons.creditOnly &&
            adjustmentReasons.level != 'SECONDARY'
          ) {
            adjustmentReasonList.add(
              new SelectOption(adjustmentReasons.eid, adjustmentReasons.name)
            );
          }
        }
      }
    }
    return adjustmentReasonList;
  }
  /**
   *   @description -Method to map Debit Adjustment Reasons to SelectOption llist
   *
   */
  public static list<SelectOption> mapDebitAdjustmentReasons(
    SoapApi33Domain.QueryResponse queryResponse
  ) {
    list<SelectOption> adjustmentReasonList = new List<SelectOption>();
    if (
      queryResponse.successful &&
      queryResponse != null &&
      queryResponse.adjustmentReasons != null
    ) {
      adjustmentReasonList.add(new SelectOption('', 'Choose One'));
      if (
        queryResponse.adjustmentReasons.adjustmentReason != null &&
        !queryResponse.adjustmentReasons.adjustmentReason.isEmpty()
      ) {
        for (
          SoapApi33Domain.AdjustmentReason adjustmentReasons : queryResponse.adjustmentReasons.adjustmentReason
        ) {
          if (
            false == adjustmentReasons.creditOnly &&
            adjustmentReasons.level != 'SECONDARY'
          ) {
            adjustmentReasonList.add(
              new SelectOption(adjustmentReasons.eid, adjustmentReasons.name)
            );
          }
        }
      }
    }
    return adjustmentReasonList;
  }
  /**
   *   @description -Method to map Deactivate Reasons to SelectOption llist
   *
   */
  public static list<SelectOption> mapDeactivateReasons(
    SoapApi33Domain.QueryResponse queryResponse
  ) {
    list<SelectOption> reasonList = new List<SelectOption>();
    if (
      queryResponse.successful &&
      queryResponse != null &&
      queryResponse.reasons != null
    ) {
      reasonList.add(new SelectOption('undefined', 'Choose One'));
      if (
        queryResponse.reasons.serviceDeactivationReason != null &&
        !queryResponse.reasons.serviceDeactivationReason.isEmpty()
      ) {
        for (
          SoapApi33Domain.ServiceDeactivationReason serviceDeactivate : queryResponse.reasons.serviceDeactivationReason
        ) {
          reasonList.add(
            new SelectOption(serviceDeactivate.eid, serviceDeactivate.name)
          );
        }
      }
    }
    return reasonList;
  }
  /**
   *   @description -Method to map Suspend Reasons to SelectOption llist
   *
   */
  public static list<SelectOption> mapSuspendReasons(
    SoapApi33Domain.QueryResponse queryResponse
  ) {
    list<SelectOption> reasonList = new List<SelectOption>();
    reasonList.add(new SelectOption('undefined', 'Choose One'));
    if (
      queryResponse.reasons.serviceSuspensionReason != null &&
      !queryResponse.reasons.serviceSuspensionReason.isEmpty()
    ) {
      for (
        SoapApi33Domain.serviceSuspensionReason suspensionReason : queryResponse.reasons.serviceSuspensionReason
      ) {
        reasonList.add(
          new SelectOption(suspensionReason.eid, suspensionReason.name)
        );
      }
    }
    return reasonList;
  }
  /**
   *   @description -Method to map Billing Account Deactivate/Suspend Reasons to SelectOption llist
   *
   */
  public static list<SelectOption> mapBillingAccountChangeReason(
    SoapApi33Domain.QueryResponse queryResponse,
    String reasonFor
  ) {
    list<SelectOption> reasonList = new List<SelectOption>();
    if (
      queryResponse.successful &&
      queryResponse != null &&
      queryResponse.reasons != null
    ) {
      reasonList.add(new SelectOption('undefined', 'Choose One'));
      if (reasonFor == 'Suspend') {
        if (
          queryResponse.reasons.suspensionReason != null &&
          !queryResponse.reasons.suspensionReason.isEmpty()
        ) {
          for (
            SoapApi33Domain.SuspensionReason suspensionReason : queryResponse.reasons.suspensionReason
          ) {
            reasonList.add(
              new SelectOption(suspensionReason.eid, suspensionReason.name)
            );
          }
        }
      } else if (reasonFor == 'Deactivate') {
        if (
          queryResponse.reasons.deactivationReason != null &&
          !queryResponse.reasons.deactivationReason.isEmpty()
        ) {
          for (
            SoapApi33Domain.DeactivationReason deactivationReason : queryResponse.reasons.deactivationReason
          ) {
            reasonList.add(
              new SelectOption(deactivationReason.eid, deactivationReason.name)
            );
          }
        }
      }
    }
    return reasonList;
  }
  /**
   *   @description -Method to map Usage Price Categories to SelectOption llist
   *
   */
  public static list<SelectOption> mapUsagePriceCategories(
    SoapApi33Domain.QueryResponse queryResponse
  ) {
    list<SelectOption> chargeCategoryList = new List<SelectOption>();
    chargeCategoryList.add(new SelectOption('Choose One', 'Choose One'));
    if (
      queryResponse.usagePriceCategories.usagePriceCategory != null &&
      !queryResponse.usagePriceCategories.usagePriceCategory.isEmpty()
    ) {
      SoapApi33Domain.UsagePriceCategory[] usagePrceCtgry = queryResponse.usagePriceCategories.usagePriceCategory;
      for (SoapApi33Domain.UsagePriceCategory usagePrice : usagePrceCtgry) {
        if (usagePrice.status == 'ACTIVE') {
          chargeCategoryList.add(
            new SelectOption(usagePrice.eid, usagePrice.name)
          );
        }
      }
    }
    return chargeCategoryList;
  }
  /**
   *   @description -Method to map Product Relations to string llist
   *
   */
  public static list<string> mapProductRelations(
    SoapApi33Domain.QueryResponse queryResponse
  ) {
    list<string> listOfParentName = new List<string>();
    SoapApi33Domain.ProductRelation[] relatedProducts = queryResponse.productRelations.productRelation;
    if (null != relatedProducts && relatedProducts.size() > 0) {
      for (SoapApi33Domain.ProductRelation productRelation : relatedProducts) {
        if (productRelation.product.productTypeCode == 'Subscription') {
          listOfParentName.add(productRelation.product.name);
        }
      }
    }
    return listOfParentName;
  }
  /**
   *   @description -Method to map Order Items to GTVSalesOrderDetailWrapper
   *
   */
  public static GTVSalesOrderDetailWrapper mapOrderItems(
    SoapApi33Domain.OrderItem[] orderItemsList,
    string currencyType,
    decimal taxAmount,
    Map<string, List<SoapApi33Domain.serviceResource>> mapOfOrderItemEidVSServiceResourceList,
    Map<string, List<SoapApi33Domain.Service>> mapOfOrderItemEidVSService
  ) {
    GTVSalesOrderDetailWrapper salesOrderWrapper = new GTVSalesOrderDetailWrapper();
    list<GTVOrderItemWrapper> listOfOrderItemWrapper = new List<GTVOrderItemWrapper>();
    decimal orderAmount = 0;
    salesOrderWrapper.taxAmount = setAccountBalanceCurrencyType(
      string.valueOf(taxAmount),
      currencyType
    );
    for (SoapApi33Domain.orderItem orderItem : orderItemsList) {
      GTVOrderItemWrapper orderItemWrapper = new GTVOrderItemWrapper();
      orderItemWrapper.orderItem = true;
      orderItemWrapper.quantity = orderItem.quantity.intValue();
      orderItemWrapper.productName = orderItem.product.name;
      if (orderItem.orderItemPrices != null) {
        if (
          orderItem.orderItemPrices.OrderItemOneTimePrice != null &&
          orderItem.orderItemPrices.orderItemRecurringPrice != null
        ) {
          orderItemWrapper.unitPrice = string.valueOf(
            orderItem.orderItemPrices.OrderItemOneTimePrice.amount /
            orderItem.quantity.intValue()
          );
          orderItemWrapper.recurringPrice = string.valueOf(
            orderItem.orderItemPrices.orderItemRecurringPrice.amount /
            orderItem.quantity.intValue()
          );
          orderItemWrapper.orderItemUnitPrice = string.valueOf(
            Integer.valueof(orderItemWrapper.unitPrice) +
            Integer.valueof(orderItemWrapper.recurringPrice)
          );
          orderItemWrapper.orderItemTotalPrice = string.valueOf(
            orderItem.orderItemPrices.orderItemRecurringPrice.amount +
            orderItem.orderItemPrices.OrderItemOneTimePrice.amount
          );
        } else if (orderItem.orderItemPrices.orderItemRecurringPrice != null) {
          orderItemWrapper.recurringPrice = string.valueOf(
            orderItem.orderItemPrices.orderItemRecurringPrice.amount
          );
          orderItemWrapper.orderItemUnitPrice = string.valueOf(
            orderItem.orderItemPrices.orderItemRecurringPrice.amount /
            orderItem.quantity.intValue()
          );
          orderItemWrapper.orderItemTotalPrice = string.valueOf(
            orderItem.orderItemPrices.orderItemRecurringPrice.amount
          );
        } else if (orderItem.orderItemPrices.OrderItemOneTimePrice != null) {
          orderItemWrapper.unitPrice = string.valueOf(
            orderItem.orderItemPrices.OrderItemOneTimePrice.amount /
            orderItem.quantity.intValue()
          );
          orderItemWrapper.orderItemUnitPrice = orderItemWrapper.unitPrice;
          orderItemWrapper.orderItemTotalPrice = string.valueOf(
            orderItem.orderItemPrices.OrderItemOneTimePrice.amount
          );
        }
      }
      //orderItemWrapper.orderItemUnitPrice = string.valueOf(orderItem.recurringUnitPrice + orderItem.unitPrice);
      //orderItemWrapper.orderItemTotalPrice = string.valueOf(((orderItem.recurringUnitPrice + orderItem.unitPrice) * orderItem.quantity).setScale(2));
      orderAmount += decimal.valueOf(orderItemWrapper.orderItemTotalPrice);
      if (
        null != orderItem.product.shortDescription &&
        'ADDON' != orderItem.product.productTypeCode
      ) {
        orderItemWrapper.hasShortDescription = true;
        orderItemWrapper.shortDescription = orderItem.product.shortDescription;
      }
      if ('ADDON' == orderItem.product.productTypeCode) {
        orderItemWrapper.hasShortDescription = true;
        orderItemWrapper.shortDescription = 'Add-on';
      }
      if (
        'ADDON' == orderItem.product.productTypeCode &&
        orderItem.parentService != null
      ) {
        orderItemWrapper.hasParentService = true;
        orderItemWrapper.parentServiceName = orderItem.parentService.product.name;
      }
      if (mapOfOrderItemEidVSServiceResourceList.containsKey(orderItem.eid)) {
        orderItemWrapper.listOfServiceResources = new List<string>();
        for (
          SoapApi33Domain.serviceResource service : mapOfOrderItemEidVSServiceResourceList.get(
            orderItem.eid
          )
        ) {
          orderItemWrapper.hasServiceResource = true;
          orderItemWrapper.listOfServiceResources.add(service.identifier);
        }
      }
      if (orderItemWrapper.recurringPrice != null) {
        orderItemWrapper.recurringPrice = setAccountBalanceCurrencyType(
          orderItemWrapper.recurringPrice,
          currencyType
        );
      }
      if (orderItemWrapper.unitPrice != null) {
        orderItemWrapper.unitPrice = setAccountBalanceCurrencyType(
          orderItemWrapper.unitPrice,
          currencyType
        );
      }
      orderItemWrapper.orderItemUnitPrice = setAccountBalanceCurrencyType(
        orderItemWrapper.orderItemUnitPrice,
        currencyType
      );
      orderItemWrapper.orderItemTotalPrice = setAccountBalanceCurrencyType(
        orderItemWrapper.orderItemTotalPrice,
        currencyType
      );
      if (mapOfOrderItemEidVSService.containsKey(orderItem.eid)) {
        for (
          SoapApi33Domain.Service serviceInstance : mapOfOrderItemEidVSService.get(
            orderItem.eid
          )
        ) {
          if (null != serviceInstance.currentAgreementService) {
            orderItemWrapper.hasAgreement = true;
            orderItemWrapper.agreementName = serviceInstance.currentAgreementService.agreement.name;
            Date agreeementStartDate = serviceInstance.currentAgreementService.startDate.date();
            Date agreementEndDate = serviceInstance.currentAgreementService.endDate.date();
            orderItemWrapper.agreementEndDate = serviceInstance.currentAgreementService.endDate.format(
              'MM/dd/yyyy'
            );
            Integer period = serviceInstance.currentAgreementService.agreement.agreementPeriod;
            string periodType = serviceInstance.currentAgreementService.agreement.agreementPeriodType.toLowerCase()
              .capitalize();
            Integer agreementPeriod;
            if (periodType == 'Day') {
              agreementPeriod = agreeementStartDate.daysBetween(
                agreementEndDate
              );
            } else if (periodType == 'Month') {
              agreementPeriod = agreeementStartDate.monthsBetween(
                agreementEndDate
              );
            }
            if (agreementPeriod > 1) {
              orderItemWrapper.agreementPeriod =
                string.valueOf(agreementPeriod) +
                ' ' +
                (periodType + 's');
            } else {
              orderItemWrapper.agreementPeriod =
                string.valueOf(agreementPeriod) +
                ' ' +
                periodType;
            }
            orderItemWrapper.agreementEndAction = TractSFDC_Util.convertToCamelCase(
              serviceInstance.currentAgreementService.endAction,
              '_'
            );
          }
        }
      }
      listOfOrderItemWrapper.add(orderItemWrapper);
    }
    salesOrderWrapper.listOfOrderItems = listOfOrderItemWrapper;
    salesOrderWrapper.orderAmount = setAccountBalanceCurrencyType(
      string.valueOf(orderAmount),
      currencyType
    );
    Decimal total = orderAmount + taxAmount;
    salesOrderWrapper.totalOrderAmountWithTaxes = setAccountBalanceCurrencyType(
      string.valueOf(total),
      currencyType
    );
    return salesOrderWrapper;
  }
  /**
   *   @description -Method to map Service Usage Rule to ProductUsesWrapper list
   *
   */
  public static List<ProductUsesWrapper> mapServiceUsageRule(
    SoapApi33Domain.QueryResponse queryResponse
  ) {
    List<ProductUsesWrapper> ruleOverrides = new List<ProductUsesWrapper>();
    if (
      null != queryResponse.serviceUsageRules.matchAllServiceUsageRule &&
      !queryResponse.serviceUsageRules.matchAllServiceUsageRule.isEmpty()
    ) {
      SoapApi33Domain.MatchAllServiceUsageRule[] matchAllServiceUsageRule = queryResponse.serviceUsageRules.matchAllServiceUsageRule;
      for (
        SoapApi33Domain.MatchAllServiceUsageRule matchAll : matchAllServiceUsageRule
      ) {
        ProductUsesWrapper productUsesWrapper = new ProductUsesWrapper();
        productUsesWrapper.ChargeName = matchAll.Name;
        productUsesWrapper.Rule = 'Matches all';
        productUsesWrapper.UsageRuleEid = matchAll.eid;
        productUsesWrapper.ChargeType = 'MatchAll';
        //productUsesWrapper.ChargeCategory= matchAll.chargeCategory.name;

        if (null != matchAll.flatUsageRate) {
          productUsesWrapper.Rate =
            String.valueOf(matchAll.flatUsageRate.rate.setScale(2)) +
            ' per ' +
            matchAll.flatUsageRate.uom.toLowerCase().capitalize();
          if (matchAll.limit_x > 0)
            productUsesWrapper.Taper =
              String.valueOf(Decimal.valueOf(matchAll.limit_x).setScale(0)) +
              ' ' +
              matchAll.flatUsageRate.uom.toLowerCase().capitalize() +
              's';
          else
            productUsesWrapper.Taper =
              matchAll.allowanceType +
              ' ' +
              matchAll.flatUsageRate.uom.toLowerCase().capitalize();
        }
        if (null != matchAll.tableUsageRate) {
          productUsesWrapper.Rate =
            'Table Rate ' + matchAll.tableUsageRate.rateTable.name;
          productUsesWrapper.Taper =
            matchAll.allowanceType +
            ' ' +
            matchAll.tableUsageRate.rateTable.uom;
        }
        if (null != matchAll.passThroughUsageRate) {
          productUsesWrapper.Rate =
            'Pass Through ' + matchAll.passThroughUsageRate.usageFieldName;
          productUsesWrapper.Taper =
            String.valueOf(Decimal.valueOf(matchAll.limit_x).setScale(0)) +
            ' ' +
            matchAll.usageUom.toLowerCase().capitalize() +
            's';
        }
        //productUsesWrapper.FromDate = String.valueOf(matchAll.validFrom);
        //productUsesWrappe.ThruDate = matchAll
        productUsesWrapper.Status = matchAll.status.toLowerCase().capitalize();
        ruleOverrides.add(productUsesWrapper);
      }
    }
    if (
      null != queryResponse.serviceUsageRules.formulaServiceUsageRule &&
      !queryResponse.serviceUsageRules.formulaServiceUsageRule.isEmpty()
    ) {
      SoapApi33Domain.FormulaServiceUsageRule[] formulaAllServiceUsageRule = queryResponse.serviceUsageRules.formulaServiceUsageRule;
      for (
        SoapApi33Domain.FormulaServiceUsageRule matchAll : formulaAllServiceUsageRule
      ) {
        ProductUsesWrapper productUsesWrapper = new ProductUsesWrapper();
        productUsesWrapper.ChargeName = matchAll.name;
        productUsesWrapper.Rule =
          matchAll.fieldName +
          ' = ' +
          matchAll.fieldValue;
        productUsesWrapper.UsageRuleEid = matchAll.eid;
        productUsesWrapper.ChargeType = 'Formula';
        //productUsesWrapper.ChargeCategory= matchAll.chargeCategory.name;
        if (null != matchAll.flatUsageRate) {
          productUsesWrapper.Rate =
            String.valueOf(matchAll.flatUsageRate.rate.setScale(2)) +
            ' per ' +
            matchAll.flatUsageRate.uom.toLowerCase().capitalize();
          if (matchAll.limit_x > 0)
            productUsesWrapper.Taper =
              String.valueOf(Decimal.valueOf(matchAll.limit_x).setScale(0)) +
              ' ' +
              matchAll.usageUom.toLowerCase().capitalize() +
              's';
          else
            productUsesWrapper.Taper =
              matchAll.allowanceType +
              ' ' +
              matchAll.flatUsageRate.uom.toLowerCase().capitalize();
        }
        if (null != matchAll.tableUsageRate) {
          productUsesWrapper.Rate =
            'Table Rate ' + matchAll.tableUsageRate.rateTable.name;
          productUsesWrapper.Taper =
            matchAll.allowanceType +
            ' ' +
            matchAll.tableUsageRate.rateTable.uom;
        }
        if (null != matchAll.passThroughUsageRate) {
          productUsesWrapper.Rate =
            'Pass Through ' + matchAll.passThroughUsageRate.usageFieldName;
          productUsesWrapper.Taper =
            String.valueOf(Decimal.valueOf(matchAll.limit_x).setScale(0)) +
            ' ' +
            matchAll.usageUom.toLowerCase().capitalize() +
            's';
        }
        //productUsesWrapper.FromDate = String.valueOf(matchAll.validFrom);
        //productUsesWrappe.ThruDate = matchAll
        productUsesWrapper.Status = matchAll.status.toLowerCase().capitalize();
        ruleOverrides.add(productUsesWrapper);
      }
    }

    if (
      null != queryResponse.serviceUsageRules.globalServiceUsageRule &&
      !queryResponse.serviceUsageRules.globalServiceUsageRule.isEmpty()
    ) {
      SoapApi33Domain.GlobalServiceUsageRule[] globalAllServiceUsageRule = queryResponse.serviceUsageRules.globalServiceUsageRule;
      for (
        SoapApi33Domain.GlobalServiceUsageRule matchAll : globalAllServiceUsageRule
      ) {
        ProductUsesWrapper productUsesWrapper = new ProductUsesWrapper();
        productUsesWrapper.ChargeName = matchAll.name;
        productUsesWrapper.Rule = matchAll.globalUsageRule.name;
        productUsesWrapper.UsageRuleEid = matchAll.eid;
        productUsesWrapper.ChargeType = 'Global';
        //productUsesWrapper.ChargeCategory= matchAll.chargeCategory.name;

        if (null != matchAll.passThroughUsageRate) {
          productUsesWrapper.Rate = 'Rule rating';
          if (matchAll.limit_x < 0)
            productUsesWrapper.Taper =
              matchAll.allowanceType +
              ' ' +
              matchAll.usageUom.toLowerCase().capitalize();
          else
            productUsesWrapper.Taper =
              String.valueOf(Decimal.valueOf(matchAll.limit_x).setScale(0)) +
              ' ' +
              matchAll.usageUom.toLowerCase().capitalize() +
              's';
        }
        //productUsesWrapper.FromDate = String.valueOf(matchAll.validFrom);
        //productUsesWrappe.ThruDate = matchAll
        productUsesWrapper.Status = matchAll.status.toLowerCase().capitalize();
        ruleOverrides.add(productUsesWrapper);
      }
    }
    return ruleOverrides;
  }
  /**
   *   @description -Method to map Discount Code to DiscountCodeWrapper list
   *
   */
  public static list<DiscountCodeWrapper> mapDiscountCode(
    SoapApi33Domain.QueryResponse productDiscountCodeQueryResponse
  ) {
    list<DiscountCodeWrapper> discountCodeWrapperList = new List<DiscountCodeWrapper>();
    for (
      SoapApi33Domain.DiscountCode proDiscountInstance : productDiscountCodeQueryResponse.discountCodes.discountCode
    ) {
      DiscountCodeWrapper proDiscountWrapper = new DiscountCodeWrapper();
      proDiscountWrapper.name = proDiscountInstance.name;
      if (null != proDiscountInstance.status) {
        proDiscountWrapper.status = (proDiscountInstance.status.toLowerCase())
          .capitalize();
      }
      proDiscountWrapper.description = proDiscountInstance.description;
      if (null != proDiscountInstance.discountChargeCategory) {
        proDiscountWrapper.chargeCategory = proDiscountInstance.discountChargeCategory.name;
      }
      if (null != proDiscountInstance.validFrom) {
        proDiscountWrapper.availableFrom = (proDiscountInstance.validFrom)
          .format('MM/dd/yyyy');
      }
      if (null != proDiscountInstance.discount) {
        proDiscountWrapper.discount = proDiscountInstance.discount.name;
      }
      discountCodeWrapperList.add(proDiscountWrapper);
    }
    return discountCodeWrapperList;
  }
  /**
   *   @description -Method to parse System Settings to System_Setting__c list
   *
   */
  public static list<System_Setting__c> parseSystemSettingsResponse(
    SoapApi33Domain.QueryResponse systemSettingsQueryResponse
  ) {
    list<System_Setting__c> systemSettingListToInsert = new List<System_Setting__c>();
    if (
      systemSettingsQueryResponse.successful &&
      systemSettingsQueryResponse != null &&
      systemSettingsQueryResponse.systemSettings != null &&
      systemSettingsQueryResponse.systemSettings.systemSetting != null
    ) {
      System_Setting__c systemSetting;
      Map<string, System_Setting__c> existingSystemsettings = new Map<string, System_Setting__c>();
      existingSystemsettings = System_Setting__c.getall();
      for (
        SoapApi33Domain.SystemSetting settingInstance : systemSettingsQueryResponse.systemSettings.systemSetting
      ) {
        if (existingSystemsettings.containsKey(settingInstance.name)) {
          systemSetting = existingSystemsettings.get(settingInstance.name);
        } else {
          systemSetting = new System_Setting__c();
          systemSetting.name = settingInstance.name;
        }
        systemSetting.value__c = settingInstance.value;
        systemSettingListToInsert.add(systemSetting);
      }
    }
    return systemSettingListToInsert;
  }
  /**
   *   @description -Method to parse Discount Code to DiscountCodeWrapper list
   *
   */
  public static List<DiscountCodeWrapper> parseDiscountCode(
    SoapApi33Domain.QueryResponse discountCodeQueryResponse
  ) {
    List<DiscountCodeWrapper> productDiscountCodeList = new List<DiscountCodeWrapper>();
    if (
      discountCodeQueryResponse.discountCodes.discountCode != null &&
      !discountCodeQueryResponse.discountCodes.discountCode.isEmpty()
    ) {
      SoapApi33Domain.DiscountCode[] proDiscountCode = discountCodeQueryResponse.discountCodes.discountCode;
      for (SoapApi33Domain.DiscountCode proDiscountInstance : proDiscountCode) {
        DiscountCodeWrapper proDiscountWrapper = new DiscountCodeWrapper();
        proDiscountWrapper.name = proDiscountInstance.name;
        if (null != proDiscountInstance.status)
          proDiscountWrapper.status = (proDiscountInstance.status.toLowerCase())
            .capitalize();
        proDiscountWrapper.description = proDiscountInstance.description;
        if (null != proDiscountInstance.discountChargeCategory)
          proDiscountWrapper.chargeCategory = proDiscountInstance.discountChargeCategory.name;
        if (null != proDiscountInstance.validFrom)
          proDiscountWrapper.availableFrom = (proDiscountInstance.validFrom)
            .format('MM/dd/yyyy');
        if (null != proDiscountInstance.discount)
          proDiscountWrapper.discount = proDiscountInstance.discount.name;
        productDiscountCodeList.add(proDiscountWrapper);
      }
    }
    return productDiscountCodeList;
  }
  /**
   *   @description -Method to map System Settings
   *
   */
  public static Map<String, String> mapSystemSettings(
    SoapApi33Domain.QueryResponse queryResponse
  ) {
    Map<string, string> systemSettingMap = new Map<String, String>();
    if (
      queryResponse.successful &&
      queryResponse != null &&
      queryResponse.systemSettings != null &&
      queryResponse.systemSettings.systemSetting != null
    ) {
      for (
        SoapApi33Domain.SystemSetting settings : queryResponse.systemSettings.systemSetting
      ) {
        if (settings.name == 'Currency Identification') {
          systemSettingMap.put('Currency Identification', settings.value);
        }
        if (settings.name == 'Currency Location') {
          systemSettingMap.put('Currency Location', settings.value);
        }
      }
    }
    return systemSettingMap;
  }
  /**
   *   @description -Method to parse Service Custom Fields to Tract_Service_Custom_Field__c custom object list
   *
   */
  public static List<Tract_Service_Custom_Field__c> parseServiceCustomFields(
    SoapApi33Domain.QueryResponse queryResponse
  ) {
    list<Tract_Service_Custom_Field__c> serviceCustomFieldsList = new List<Tract_Service_Custom_Field__c>();
    if (
      queryResponse.successful &&
      null != queryResponse.customFields &&
      null != queryResponse.customFields.customField
    ) {
      Tract_Service_Custom_Field__c serviceCustomFieldObj;
      string listValues;
      for (
        SoapApi33Domain.CustomField custFieldObj : queryResponse.customFields.customField
      ) {
        listValues = '';
        serviceCustomFieldObj = new Tract_Service_Custom_Field__c();
        serviceCustomFieldObj.eid__c = custFieldObj.eid;
        serviceCustomFieldObj.Name = custFieldObj.Name;
        serviceCustomFieldObj.ValidationType__c = custFieldObj.fieldValidationType;
        if (custFieldObj.fieldType == 'LIST') {
          serviceCustomFieldObj.FieldType__c = custFieldObj.fieldType;
          if (null != custFieldObj.customFieldValueReferences) {
            SoapApi33Domain.CustomFieldValueReference[] customReference = custFieldObj.customFieldValueReferences.customFieldValueReference;
            for (
              SoapApi33Domain.CustomFieldValueReference addValues : customReference
            ) {
              listValues += ',' + addValues.value;
            }
            serviceCustomFieldObj.StoreListValue__c = listValues.substring(1);
          }
        }
        serviceCustomFieldsList.add(serviceCustomFieldObj);
      }
    }
    return serviceCustomFieldsList;
  }

  /**
   *   @description -Method to parse Service Resource to ServiceResourceWrapper
   *
   */
  public static ServiceResourceWrapper mapServiceResource(
    SoapApi33Domain.QueryResponse queryResponse1,
    String srId
  ) {
    ServiceResourceWrapper srWrapper = new ServiceResourceWrapper();
    if (
      queryResponse1.successful &&
      queryResponse1 != null &&
      queryResponse1.serviceResources != null &&
      queryResponse1.serviceResources.serviceResource != null &&
      !queryResponse1.serviceResources.serviceResource.isEmpty()
    ) {
      for (
        SoapApi33Domain.ServiceResource services : queryResponse1.serviceResources.serviceResource
      ) {
        if (services.status == 'AVAILABLE') {
          srWrapper.eid = services.eid;
          srWrapper.identifier = srId;
        } else {
          srWrapper.errorMessage =
            srId +
            ' must have status as AVAILABLE to be applied on a order item.';
        }
        break;
      }
    } else {
      srWrapper.errorMessage = srId + ' is an invalid service resource.';
    }
    return srWrapper;
  }
  /**
   *   @description -Method to map chargeListBytes to SelectOption list
   *
   */
  public static List<SelectOption> getchargeListBytes(
    SoapApi33Domain.QueryResponse queryResponse
  ) {
    list<SelectOption> chargeListBytes = new List<SelectOption>();
    if (
      queryResponse.successful &&
      queryResponse != null &&
      queryResponse.rateTables != null
    ) {
      chargeListBytes.add(new SelectOption('Choose One', 'Choose One'));
      if (
        queryResponse.rateTables.rateTable != null &&
        !queryResponse.rateTables.rateTable.isEmpty()
      ) {
        SoapApi33Domain.RateTable[] rateTable = queryResponse.rateTables.rateTable;
        for (SoapApi33Domain.RateTable ratesTables : rateTable) {
          if (ratesTables.status == 'ACTIVE') {
            chargeListBytes.add(
              new SelectOption(ratesTables.eid, ratesTables.name)
            );
          }
        }
      }
    }
    return chargeListBytes;
  }
  /**
   *   @description -Method to get Rate Tables
   *
   */
  public static String getRateTableUom(
    SoapApi33Domain.QueryResponse queryResponse
  ) {
    String uom;
    if (
      queryResponse.successful &&
      queryResponse != null &&
      queryResponse.rateTables != null
    ) {
      SoapApi33Domain.RateTable rateTable = queryResponse.rateTables.rateTable[0];
      uom = rateTable.uom;
    }
    return uom;
  }
  /**
   *   @description -Method to get parent Related ProductId Lists
   *
   */

  public static Set<String> getRelatedProductIdList(
    SoapApi33Domain.QueryResponse queryResponse
  ) {
    Set<String> setOfParentId = new Set<String>();
    SoapApi33Domain.ProductRelation[] relatedProducts = queryResponse.productRelations.productRelation;
    if (null != relatedProducts && relatedProducts.size() > 0) {
      for (SoapApi33Domain.ProductRelation productRelation : relatedProducts) {
        if (productRelation.type_x == 'PARENT') {
          setOfParentId.add(productRelation.product.eid);
        }
      }
    }
    return setOfParentId;
  }
  /**
   *   @description -Method to parse Services to RenewServiceWrapper
   *
   */
  public static RenewServiceWrapper parseServices(
    SoapApi33Domain.QueryResponse queryResponse,
    String serviceRenewEid
  ) {
    RenewServiceWrapper serviceWrapper = new RenewServiceWrapper();
    if (
      queryResponse.successful &&
      queryResponse != null &&
      queryResponse.services != null
    ) {
      SoapApi33Domain.Service[] allServices = queryResponse.services.service;
      for (SoapApi33Domain.Service currentService : allServices) {
        if (currentService.eid == serviceRenewEid) {
          serviceWrapper.serviceProductEid = currentService.product.eid;
          if (
            null != currentService.product.productPrices.oneTimeProductPrice
          ) {
            serviceWrapper.checkOneTimePrice = true;
          } else {
            serviceWrapper.checkOneTimePrice = false;
          }
        }
      }
    }
    return serviceWrapper;
  }
  /**
   *   @description -Method to parse Service Agreements to RenewServiceWrapper
   *
   */
  public static RenewServiceWrapper mapServiceAgreements(
    SoapApi33Domain.QueryResponse queryResponse,
    RenewServiceWrapper serviceWrapper
  ) {
    if (queryResponse.agreements.agreement != null) {
      serviceWrapper.ServiceAgreementList = new List<SelectOption>();
      SoapApi33Domain.Agreement[] allAgreements = queryResponse.agreements.agreement;
      serviceWrapper.ServiceAgreementList.add(
        new SelectOption('undefined', 'Choose One')
      );
      for (SoapApi33Domain.Agreement agreementName : allAgreements) {
        serviceWrapper.ServiceAgreementList.add(
          new SelectOption(agreementName.eid, agreementName.name)
        );
      }
    }
    return serviceWrapper;
  }
  /**
   *   @description -Method to parse Service Resource Category
   *
   */
  public static SoapApi33Domain.ServiceResource mapServiceResourceCategory(
    SoapApi33Domain.ServiceResourceCategory category,
    String serviceResourceToBeApplied
  ) {
    SoapApi33Domain.ServiceResource changeToServiceResource = new SoapApi33Domain.ServiceResource();
    changeToServiceResource.category = category;
    changeToServiceResource.identifier = serviceResourceToBeApplied;
    return changeToServiceResource;
  }
  /**
   *   @description -Method to parse Related Product Name List
   *
   */
  public static list<String> getRelatedProductNameList(
    SoapApi33Domain.QueryResponse queryResponse
  ) {
    list<String> listofRelatedProduct = new List<String>();
    SoapApi33Domain.ProductRelation[] relatedProducts = queryResponse.productRelations.productRelation;
    if (null != relatedProducts && relatedProducts.size() > 0) {
      for (SoapApi33Domain.ProductRelation productRelation : relatedProducts) {
        if (productRelation.type_x == 'PARENT') {
          listofRelatedProduct.add(productRelation.product.name);
        }
      }
    }
    return listofRelatedProduct;
  }
  /**
   *   @description -Method to parse Service to ChangeSubscriptionWrapper
   *
   */
  public static ChangeSubscriptionWrapper mapService(
    SoapApi33Domain.CommandResponse commandResponse,
    String currencyType,
    String priceListEid,
    Boolean enablePreserveAgreement,
    String emessage
  ) {
    ChangeSubscriptionWrapper subscriptionWrapper = new ChangeSubscriptionWrapper();
    list<String> productEidList = new List<String>();
    Map<String, List<ProductPriceWrapper>> productIdToProductPriceMap = new Map<String, List<ProductPriceWrapper>>();
    Map<String, List<ProductPriceRangeWrapper>> productPriceIdtoPriceRangesMap = new Map<String, List<ProductPriceRangeWrapper>>();
    map<String, String> productIdToEidMap = new Map<String, String>();
    List<SelectOption> newServiceNames = new List<SelectOption>();
    SoapApi33Domain.Product[] tractCompatibleProducts = commandResponse.compatibleForChangeServiceResponse.products.product;
    if (tractCompatibleProducts.size() != 0) {
      for (SoapApi33Domain.Product tractProduct : tractCompatibleProducts) {
        productEidList.add(tractProduct.eid);
      }
    }
    newServiceNames.add(new SelectOption('', 'Choose One'));
    if (
      TRACTAPIUtil.checkFieldLevelSecurity(
        'Product2',
        'Id, name, eid__c, ProductCode, Price_Information__c',
        'Query'
      )
    ) {
      for (Product2 proCode : [
        SELECT Id, name, eid__c, ProductCode, Price_Information__c
        FROM Product2
        WHERE eid__c IN :productEidList
      ]) {
        newServiceNames.add(
          new SelectOption(proCode.Id, String.valueOf(proCode.name))
        );
        productIdToEidMap.put(proCode.Id, proCode.Eid__c);
        list<ProductPriceWrapper> listProductPriceObj = new List<ProductPriceWrapper>();
        for (
          ProductPriceWrapper productPriceObj : (list<ProductPriceWrapper>) JSON.deserialize(
            procode.Price_Information__c,
            list<ProductPriceWrapper>.class
          )
        ) {
          if (
            productPriceObj.currencyType == currencyType &&
            productPriceObj.priceListEid == priceListEid
          ) {
            listProductPriceObj.add(productPriceObj);
          }
        }
        productIdToProductPriceMap.put(proCode.Id, listProductPriceObj);
        for (ProductPriceWrapper productPriceWrapperObj : listProductPriceObj) {
          productPriceIdtoPriceRangesMap.put(
            productPriceWrapperObj.eId,
            productPriceWrapperObj.priceRangesList
          );
        }
      }
    }
    subscriptionWrapper.productIdToProductPriceMap = productIdToProductPriceMap;
    subscriptionWrapper.productPriceIdtoPriceRangesMap = productPriceIdtoPriceRangesMap;
    subscriptionWrapper.enablePreserveAgreement = enablePreserveAgreement;
    subscriptionWrapper.newServiceList = newServiceNames;
    subscriptionWrapper.errorMessage = emessage;
    return subscriptionWrapper;
  }
  /**
   *   @description -Method to parse Related Child Product Name List
   *
   */
  public static set<String> getRelatedChildProductNameList(
    SoapApi33Domain.QueryResponse queryResponse
  ) {
    set<String> setofRelatedProduct = new Set<String>();
    SoapApi33Domain.ProductRelation[] relatedProducts = queryResponse.productRelations.productRelation;
    if (null != relatedProducts && relatedProducts.size() > 0) {
      for (SoapApi33Domain.ProductRelation productRelation : relatedProducts) {
        setofRelatedProduct.add(productRelation.product.eid);
      }
    }
    return setofRelatedProduct;
  }
  /**
   *   @description -Method to parse One Time Order Item to GTVOneTimeOrderItemWrapper
   *
   */
  public static List<GTVOneTimeOrderItemWrapper> parseOneTimeOrderItem(
    SoapApi33Domain.QueryResponse queryResponse,
    String currencyType
  ) {
    List<GTVOneTimeOrderItemWrapper> oneTimeOrderItemList = new List<GTVOneTimeOrderItemWrapper>();
    for (
      SoapApi33Domain.SalesOrder orderInstance : queryResponse.SalesOrders.salesOrder
    ) {
      for (
        SoapApi33Domain.orderItem orderItemInstance : orderInstance.orderItems.orderItem
      ) {
        if (orderItemInstance.product.productTypeCode == 'GENERAL_PRODUCT') {
          GTVOneTimeOrderItemWrapper orderItemObj = new GTVOneTimeOrderItemWrapper();
          orderItemObj.productName = orderItemInstance.product.Name;
          orderItemObj.status = orderItemInstance.status;
          orderItemObj.description = orderItemInstance.description;
          orderItemObj.productDescription = orderItemInstance.product.description;
          orderItemObj.quantity = Integer.valueof(orderItemInstance.quantity);
          if (orderItemInstance.orderItemPrices != null) {
            orderItemObj.unitPrice = TractSFDC_Util.setBalanceCurrencyType(
              string.valueOf(
                orderItemInstance.orderItemPrices.OrderItemOneTimePrice.amount
              ),
              currencyType
            );
            orderItemObj.totalPrice = TractSFDC_Util.setBalanceCurrencyType(
              string.valueOf(
                ((orderItemInstance.orderItemPrices.OrderItemOneTimePrice.amount) *
                  orderItemInstance.quantity)
                  .setScale(2)
              ),
              currencyType
            );
            if (
              orderItemInstance.orderItemPrices.OrderItemOneTimePrice.priceCategory !=
              null
            ) {
              orderItemObj.priceCategory = orderItemInstance.orderItemPrices.OrderItemOneTimePrice.priceCategory.name;
            }
          }
          orderItemObj.orderNumber = orderInstance.orderNum;
          orderItemObj.purchaseDate = Date.valueOf(orderInstance.orderDate);
          orderItemObj.id = orderItemInstance.eid;
          orderItemObj.scheduleChargeInf = new List<ScheduleChargesWapper>();
          if (
            orderItemInstance.scheduledOneTimePriceCharges != null &&
            orderItemInstance.scheduledOneTimePriceCharges.scheduledOneTimePriceCharge !=
            null
          ) {
            for (
              SoapApi33Domain.ScheduledOneTimePriceCharge scheduleCharge : orderItemInstance.scheduledOneTimePriceCharges.scheduledOneTimePriceCharge
            ) {
              ScheduleChargesWapper chargeWrap = new ScheduleChargesWapper();
              chargeWrap.amount = TractSFDC_Util.setBalanceCurrencyType(
                String.valueOf(scheduleCharge.amount),
                currencyType
              );
              chargeWrap.chargeDate = date.valueOf(scheduleCharge.chargeDate);
              //chargeWrap.chargeType = scheduleCharge.price_charge_type;
              chargeWrap.description = scheduleCharge.description;
              chargeWrap.invoiced = scheduleCharge.invoiced ? 'Yes' : 'No';
              chargeWrap.status = scheduleCharge.status;
              orderItemObj.scheduleChargeInf.add(chargeWrap);
            }
          }
          oneTimeOrderItemList.add(orderItemObj);
        }
      }
    }
    return oneTimeOrderItemList;
  }
  /**
   *   @description -Method to parse Invoice Detail to InvoiceDetailWrapper
   *
   */
  public static InvoiceDetailWrapper parseInvoiceDetail(
    SoapApi33Domain.QueryResponse queryResponse,
    InvoiceWrapper wrapperObj
  ) {
    InvoiceDetailWrapper detail = new InvoiceDetailWrapper();
    list<InvoiceItemWrapper> itemWrapList = new List<InvoiceItemWrapper>();
    SoapApi33Domain.Invoice thisInvoices;
    SoapApi33Domain.InvoiceItems invoiceItems;
    if (queryResponse.successful && null != queryResponse.invoices.invoice) {
      thisInvoices = queryResponse.invoices.invoice[0];
    } else if (
      queryResponse.successful && null != queryResponse.invoices.manualInvoice
    ) {
      /* Check if Manual Invoices exist or not */
      thisInvoices = queryResponse.invoices.manualInvoice[0];
    } else if (
      queryResponse.successful && null != queryResponse.invoices.onDemandInvoice
    ) {
      /* Check if on demand Invoices exist or not */
      thisInvoices = queryResponse.invoices.onDemandInvoice[0];
    } else {
      //TODOs: Either request failed or manualInvoice(s) not found.
      thisInvoices = new SoapApi33Domain.Invoice();
    }
    detail.InvoiceType = 'manual';
    detail.DueDate = thisInvoices.dueDate;
    detail.OccuredOn = thisInvoices.occurredOn;
    detail.BillPeriod =
      String.valueOf(Date.valueOf(detail.OccuredOn)) +
      '-' +
      String.valueOf(detail.DueDate);
    if (thisInvoices.monthlyBillCycle != null) {
      detail.BillCycle = thisInvoices.monthlyBillCycle.name;
      detail.isBillCycle = true;
    } else {
      detail.isBillCycle = false;
    }
    detail.isBillBatch = false;
    detail.disputed = 'No';
    if (thisInvoices.billingStatement != null) {
      detail.serviceCharges = TractSFDC_Util.setBalanceCurrencyType(
        String.valueOf(thisInvoices.billingStatement.serviceCharges),
        wrapperObj.currencyType
      );
      detail.serviceActivityCharge = TractSFDC_Util.setBalanceCurrencyType(
        String.valueOf(thisInvoices.billingStatement.activityCharges),
        wrapperObj.currencyType
      );
      detail.otherCharge = TractSFDC_Util.setBalanceCurrencyType(
        String.valueOf(thisInvoices.billingStatement.otherChargesAndCredits),
        wrapperObj.currencyType
      );
      detail.taxFees = TractSFDC_Util.setBalanceCurrencyType(
        String.valueOf(thisInvoices.billingStatement.taxesAndFees),
        wrapperObj.currencyType
      );
      detail.totalCharge = TractSFDC_Util.setBalanceCurrencyType(
        String.valueOf(thisInvoices.billingStatement.totalCurrentCharges),
        wrapperObj.currencyType
      );
    } else if (thisInvoices.adhocBillingStatement != null) {
      detail.serviceCharges = TractSFDC_Util.setBalanceCurrencyType(
        String.valueOf(thisInvoices.adhocBillingStatement.serviceCharges),
        wrapperObj.currencyType
      );
      detail.serviceActivityCharge = TractSFDC_Util.setBalanceCurrencyType(
        String.valueOf(thisInvoices.adhocBillingStatement.activityCharges),
        wrapperObj.currencyType
      );
      detail.otherCharge = TractSFDC_Util.setBalanceCurrencyType(
        String.valueOf(
          thisInvoices.adhocBillingStatement.otherChargesAndCredits
        ),
        wrapperObj.currencyType
      );
      detail.taxFees = TractSFDC_Util.setBalanceCurrencyType(
        String.valueOf(thisInvoices.adhocBillingStatement.taxesAndFees),
        wrapperObj.currencyType
      );
      detail.totalCharge = TractSFDC_Util.setBalanceCurrencyType(
        String.valueOf(thisInvoices.adhocBillingStatement.totalCurrentCharges),
        wrapperObj.currencyType
      );
    }
    invoiceItems = thisInvoices.invoiceItems;
    if (null != invoiceItems.manualInvoiceItem) {
      for (
        SoapApi33Domain.ManualInvoiceItem item : invoiceItems.manualInvoiceItem
      ) {
        InvoiceItemWrapper wrap = new InvoiceItemWrapper();
        wrap.Type = item.lineItemType;
        wrap.description = item.description;
        if (item.service != null) {
          wrap.serviceName = item.service.description;
        }
        wrap.charges = TractSFDC_Util.setBalanceCurrencyType(
          String.valueOf(item.unitAmount),
          wrapperObj.currencyType
        );
        wrap.totalAmount = TractSFDC_Util.setBalanceCurrencyType(
          String.valueOf(item.totalAmount),
          wrapperObj.currencyType
        );
        itemWrapList.add(wrap);
      }
    }
    if (null != invoiceItems.serviceInvoiceItem) {
      for (
        SoapApi33Domain.ServiceInvoiceItem item : invoiceItems.serviceInvoiceItem
      ) {
        InvoiceItemWrapper wrap = new InvoiceItemWrapper();
        wrap.Type = item.lineItemType;
        wrap.description = item.description;
        if (item.service != null) {
          wrap.serviceName = item.service.description;
        }
        wrap.charges = TractSFDC_Util.setBalanceCurrencyType(
          String.valueOf(item.unitAmount),
          wrapperObj.currencyType
        );
        wrap.totalAmount = TractSFDC_Util.setBalanceCurrencyType(
          String.valueOf(item.totalAmount),
          wrapperObj.currencyType
        );
        itemWrapList.add(wrap);
      }
    }
    if (null != invoiceItems.manualServiceInvoiceItem) {
      for (
        SoapApi33Domain.ManualServiceInvoiceItem item : invoiceItems.manualServiceInvoiceItem
      ) {
        InvoiceItemWrapper wrap = new InvoiceItemWrapper();
        wrap.Type = item.lineItemType;
        wrap.description = item.description;
        if (item.service != null) {
          wrap.serviceName = item.service.description;
        }
        wrap.charges = TractSFDC_Util.setBalanceCurrencyType(
          String.valueOf(item.unitAmount),
          wrapperObj.currencyType
        );
        wrap.totalAmount = TractSFDC_Util.setBalanceCurrencyType(
          String.valueOf(item.totalAmount),
          wrapperObj.currencyType
        );
        itemWrapList.add(wrap);
      }
    }
    detail.invoiceItems = itemWrapList;
    return detail;
  }
  /**
   *   @description -Method to parse Service Details to ServiceDetailWrapper
   *
   */
  public static ServiceDetailWrapper mapServiceDetails(
    SoapApi33Domain.QueryResponse queryResponse
  ) {
    ServiceDetailWrapper servDetail = new ServiceDetailWrapper();
    list<OneTimePricesWrapper> oneTimeList = new List<OneTimePricesWrapper>();
    list<ProductUsesWrapper> usageRuleList = new List<ProductUsesWrapper>();
    list<ScheduleChargesWapper> chargeList = new List<ScheduleChargesWapper>();
    list<ServicePricesWrapper> servicePricesList = new List<ServicePricesWrapper>();
    SoapApi33Domain.OrderItem orderItem = queryResponse.orderItems.orderItem[0];
    servDetail.startDate = Date.valueOf(orderItem.requestedEffectiveDate);
    servDetail.productName = orderItem.product.name;
    servDetail.priceListName = orderItem.priceList.name;

    SoapApi33Domain.ProductPrice recPrice = orderItem.recurringProductPrice;
    ServicePricesWrapper priceRecSample = new ServicePricesWrapper();
    priceRecSample.validFrom = Date.valueOf(recPrice.fromDate);
    priceRecSample.recurrence = recPrice.recurrencePeriod;
    priceRecSample.priceCategory = recPrice.priceCategory.name;
    priceRecSample.InvoiceQuantity = orderItem.quantity;
    priceRecSample.bill = recPrice.billInAdvance ? 'In advance' : 'In arrears';
    priceRecSample.proration = recPrice.proratedOnCancel ? 'On cancel' : 'None';
    priceRecSample.price = TractSFDC_Util.setBalanceCurrencyType(
      String.valueOf(recPrice.priceRanges.priceRange[0].price),
      recPrice.currencyType
    );
    priceRecSample.amount = TractSFDC_Util.setBalanceCurrencyType(
      String.valueOf(recPrice.priceRanges.priceRange[0].price),
      recPrice.currencyType
    );
    servicePricesList.add(priceRecSample);

    servDetail.servicePricesInf = servicePricesList;
    SoapApi33Domain.ProductPrices prices = orderItem.product.productPrices;
    if (null != prices.oneTimeProductPrice) {
      for (
        SoapApi33Domain.OneTimeProductPrice oneTimePrice : prices.oneTimeProductPrice
      ) {
        OneTimePricesWrapper priceSample = new OneTimePricesWrapper();
        priceSample.priceCategory = oneTimePrice.priceCategory.name;
        priceSample.overridden = oneTimePrice.priceOverride ? 'Yes' : 'No';
        priceSample.price = TractSFDC_Util.setBalanceCurrencyType(
          String.valueOf(oneTimePrice.priceRanges.priceRange[0].price),
          oneTimePrice.currencyType
        );
        oneTimeList.add(priceSample);
      }
    }
    servDetail.oneTimePricesInf = oneTimeList;
    if (
      null != orderItem.scheduledOneTimePriceCharges.scheduledOneTimePriceCharge
    ) {
      for (
        SoapApi33Domain.ScheduledOneTimePriceCharge scheduleCharge : orderItem.scheduledOneTimePriceCharges.scheduledOneTimePriceCharge
      ) {
        ScheduleChargesWapper ch = new ScheduleChargesWapper();
        ch.amount = TractSFDC_Util.setBalanceCurrencyType(
          String.valueOf(scheduleCharge.amount),
          orderItem.recurringProductPrice.currencyType
        );
        ch.chargeDate = date.valueOf(scheduleCharge.chargeDate);
        ch.chargeType = 'OneTime';
        ch.description = scheduleCharge.description;
        ch.invoiced = scheduleCharge.invoiced ? 'Yes' : 'No';
        ch.status = scheduleCharge.status;
        chargeList.add(ch);
      }
    }
    servDetail.scheduleChargeInf = chargeList;
    return servDetail;
  }
  /**
   *   @description -Method to parse Service Address to AddressWrapper list
   *
   */
  public static list<AddressWrapper> mapServiceAddress(
    SoapApi33Domain.Service serviceResponseMap
  ) {
    list<AddressWrapper> addressList = new List<AddressWrapper>();
    for (
      SoapApi33Domain.PostalAddress address : serviceResponseMap.addresses.postalAddress
    ) {
      AddressWrapper addressWrap = new AddressWrapper();
      addressWrap.type = 'postal';
      addressWrap.city = address.city;
      addressWrap.country = address.country;
      addressWrap.line1 = address.line1;
      addressWrap.line2 = address.line2;
      addressWrap.state = address.regionOrState;
      addressWrap.zip = address.postalCode;
      addressWrap.purpose = address.purpose;
      addressList.add(addressWrap);
    }
    return addressList;
  }
  /**
   *   @description -Method to parse Currency Type to SelectOption list
   *
   */
  public static list<SelectOption> mapCurrencyType(
    SoapApi33Domain.QueryResponse queryResponse
  ) {
    list<SelectOption> listOfCurrencyType = new List<SelectOption>();
    for (
      SoapApi33Domain.Currency_x currencies : queryResponse.currencies.currency_x
    ) {
      listOfCurrencyType.add(
        new SelectOption(currencies.currencyType, currencies.currencyType)
      );
    }
    return listOfCurrencyType;
  }
  /**
   *   @description -Method to parse Service Discount to DiscountCodeWrapper list
   *
   */
  public static List<DiscountCodeWrapper> mapServiceDiscount(
    SoapApi33Domain.QueryResponse queryResponse
  ) {
    List<DiscountCodeWrapper> codeList = new List<DiscountCodeWrapper>();
    if (null != queryResponse.discountCodeServices.discountCodeService) {
      for (
        SoapApi33Domain.DiscountCodeService codeService : queryResponse.discountCodeServices.discountCodeService
      ) {
        DiscountCodeWrapper wrap = new DiscountCodeWrapper();
        wrap.code = codeService.discountCode.name;
        wrap.name = codeService.discountCode.discount.name;
        wrap.chargeCategory = codeService.discountCode.discount.discountCategory.name;
        wrap.type = codeService.discountCode.discount.type_x;
        wrap.validFrom = Date.valueOf(codeService.validFrom);
        wrap.validTo = Date.valueOf(codeService.validTo);
        wrap.amount = TractSFDC_Util.setBalanceCurrencyType(
          string.valueOf(codeService.amount),
          codeService.discountCode.discount.currencyType
        );
        wrap.duration = codeService.duration;
        codeList.add(wrap);
      }
    }
    return codeList;
  }
  /**
   *   @description -Method to parse Service Discount to DiscountCodeWrapper list
   *
   */
  public static list<SelectOption> mapProductCategories(
    SoapApi33Domain.QueryResponse productCategoryQueryResponse
  ) {
    list<SelectOption> productCategoryList = new List<SelectOption>();
    productCategoryList.add(new SelectOption('', 'Choose One'));
    for (
      SoapApi33Domain.ProductCategory productCategory : productCategoryQueryResponse.productCategories.productCategories
    ) {
      productCategoryList.add(
        new SelectOption(productCategory.eid, productCategory.name)
      );
    }
    return productCategoryList;
  }
  /**
   *   @description -Method to parse Service Resource Categories to SelectOption list
   *
   */
  public static list<SelectOption> mapServiceResourceCategories(
    SoapApi33Domain.QueryResponse serviceResourceCategoryQueryResponse
  ) {
    list<SelectOption> serviceResourceCategoryList = new List<SelectOption>();
    serviceResourceCategoryList.add(new SelectOption('', 'Choose One'));
    for (
      SoapApi33Domain.ServiceResourceCategory serviceResourceCategory : serviceResourceCategoryQueryResponse.serviceResourceCategories.serviceResourceCategory
    ) {
      serviceResourceCategoryList.add(
        new SelectOption(
          serviceResourceCategory.eid,
          serviceResourceCategory.name
        )
      );
    }
    return serviceResourceCategoryList;
  }
  /**
   *   @description -Method to parse Product Tags to SelectOption list
   *
   */
  public static list<SelectOption> mapProductTags(
    SoapApi33Domain.QueryResponse productTagQueryResponse
  ) {
    list<SelectOption> productTagList = new List<SelectOption>();
    for (
      SoapApi33Domain.ProductTag productTag : productTagQueryResponse.productTags.productTags
    ) {
      productTagList.add(new SelectOption(productTag.eid, productTag.name));
    }
    return productTagList;
  }
  /**
   *   @description -Method to parse Product Creation Response
   *
   */
  public static void mapProductCreationResponse(
    SoapApi33Domain.Product tractProduct,
    CreateProductWrapper createProductWrapper
  ) {
    Product2 sfdcProduct = new Product2();
    sfdcProduct.id = createProductWrapper.sfdcProductId;
    sfdcProduct.Name = tractProduct.name;
    sfdcProduct.Short_Desc__c = tractProduct.shortDescription;
    sfdcProduct.Description = tractProduct.description;
    if (tractProduct.productState == 'PRODUCT_AVAILABLE') {
      sfdcProduct.IsActive = true;
    }
    sfdcProduct.Family = 'TRACT';
    if (tractProduct.productTypeCode == 'GENERAL_PRODUCT') {
      sfdcProduct.ProductCode = 'OneTime';
    } else if (tractProduct.productTypeCode == 'ADDON') {
      sfdcProduct.ProductCode = 'Add-on';
    } else if (tractProduct.productTypeCode == 'SUBSCRIPTION') {
      sfdcProduct.ProductCode = 'Subscription';
    } else {
      sfdcProduct.ProductCode = tractProduct.productTypeCode;
    }
    sfdcProduct.eid__c = tractProduct.eid;
    sfdcProduct.Requires_Agreement__c = tractProduct.requiresAgreement;
    sfdcProduct.maxServiceResources__c = tractProduct.maxServiceResources;
    sfdcProduct.minServiceResources__c = tractProduct.minServiceResources;
    if (null != tractProduct.ruleOverride) {
      sfdcProduct.RuleOverride__c = tractProduct.ruleOverride;
    }
    if (null != tractProduct.ruleType) {
      sfdcProduct.RuleType__c = tractProduct.ruleType;
    }
    if (tractProduct.serviceResourceCategory != null) {
      sfdcProduct.Service_Resource_Category__c = tractProduct.serviceResourceCategory.name;
      sfdcProduct.SRC_eid__c = tractProduct.serviceResourceCategory.eid;
    }
    sfdcProduct.Serialized__c = tractProduct.serialized;

    if (
      TRACTAPIUtil.checkFieldLevelSecurity(
        'Product2',
        'Name,ProductCode, eid__c,maxServiceResources__c,Short_Desc__c,Requires_Agreement__c, minServiceResources__c,RuleOverride__c,RuleType__c, Serialized__c, PriceLists__c,Price_Information__c',
        'Update'
      )
    ) {
      update sfdcProduct;
    }
  }
  public static list<ProductAgreementWrapper> mapAllAgreements(
    SoapApi33Domain.QueryResponse queryResponse
  ) {
    list<ProductAgreementWrapper> agreementList = new List<ProductAgreementWrapper>();
    Map<String, ProductAgreementWrapper> productFamilyMap = new Map<String, ProductAgreementWrapper>();
    Map<String, ProductAgreementWrapper> productFamilyMapSorted = new Map<String, ProductAgreementWrapper>();
    List<String> orderingList = new List<String>();
    if (queryResponse.successful) {
      if (
        queryResponse.agreements.agreement != null &&
        queryResponse.agreements.agreement.size() > 0
      ) {
        for (
          SoapApi33Domain.Agreement ag : queryResponse.agreements.agreement
        ) {
          if (ag.status == 'ACTIVE') {
            ProductAgreementWrapper agreementObj = new ProductAgreementWrapper();
            agreementObj.Name = ag.name;
            agreementObj.eid = ag.eid;
            agreementObj.status = ag.status;
            agreementObj.agreementPeriod = ag.agreementPeriod;
            if (ag.agreementPeriod == 1) {
              agreementObj.agreementPeriodType = ag.agreementPeriodType.toLowerCase()
                .capitalize();
            } else {
              agreementObj.agreementPeriodType =
                ag.agreementPeriodType.toLowerCase().capitalize() + 's';
            }
            agreementObj.endAction = ag.endAction;
            if (ag.prorateOnCancel) {
              agreementObj.prorateOnCancel = 'Yes';
            } else {
              agreementObj.prorateOnCancel = 'No';
            }
            if (ag.adjustmentCategory != null) {
              agreementObj.adjustmentCategory = ag.adjustmentCategory.name;
            }
            if (null != ag.maxTerminationFeeCurrencyType) {
              agreementObj.currencyType = ag.maxTerminationFeeCurrencyType;
            } else if (null != ag.minimumAmountCurrencyType) {
              agreementObj.currencyType = ag.minimumAmountCurrencyType;
            } else if (null != ag.terminationFeeCurrencyType) {
              agreementObj.currencyType = ag.terminationFeeCurrencyType;
            }
            if (ag.terminationFlatCharge != null) {
              agreementObj.terminationFlatCharge = setAccountBalanceCurrencyType(
                string.valueof(ag.terminationFlatCharge),
                agreementObj.currencyType
              );
            } else if (ag.terminationPercentageCharge != null) {
              agreementObj.terminationFlatCharge =
                string.valueof(
                  (ag.terminationPercentageCharge * 100).setScale(2)
                ) + '%';
            }
            productFamilyMap.put(ag.Name.toUpperCase(), agreementObj);
          }
        }
        orderingList.addAll(productFamilyMap.keyset());
        orderingList.sort();
        for (Integer i = 0; i < orderingList.size(); i++) {
          productFamilyMapSorted.put(
            orderingList[i],
            productFamilyMap.get(orderingList[i])
          );
        }
        agreementList = productFamilyMapSorted.values();
      }
    }
    return agreementList;
  }
  /**
   *   @description -Method to parse Price Categories to  SelectOption list
   *
   */
  public static list<SelectOption> mapPriceCategories(
    SoapApi33Domain.QueryResponse queryResponse
  ) {
    List<SelectOption> priceCategoryList = new List<SelectOption>();
    if (
      queryResponse.priceCategories.priceCategory != null &&
      queryResponse.priceCategories.priceCategory.size() > 0
    ) {
      priceCategoryList.add(new SelectOption('', 'Choose One'));
      list<SoapApi33Domain.PriceCategory> categories = queryResponse.priceCategories.priceCategory;
      for (SoapApi33Domain.PriceCategory thisCategory : categories) {
        priceCategoryList.add(
          new SelectOption(thisCategory.eid, thisCategory.name)
        );
      }
    }
    return priceCategoryList;
  }
  /**
   *   @description -Method to parse Price Categories Response
   *
   */
  public static void mapProductPriceCreationResponse(
    String productId,
    SoapApi33Domain.QueryResponse productPricequeryResponse,
    String priceListId
  ) {
    String priceListEid;
    Product2 sfdcProduct = [
      SELECT id, Name, eid__c, PriceLists__c, Price_Information__c
      FROM Product2
      WHERE id = :productId
      LIMIT 1
    ];
    if (priceListId != null) {
      priceListEid = priceListId;
    } else {
      Price_List__c priceList = [
        SELECT id, name, TRACT3__eid__c
        FROM TRACT3__Price_List__c
        WHERE name = 'Default Price List'
      ];
      priceListEid = priceList.TRACT3__eid__c;
    }
    Map<String, ProductPriceWrapper> mapOfEidVsProductPrice = new Map<String, ProductPriceWrapper>();
    if (sfdcProduct.Price_Information__c != null) {
      list<ProductPriceWrapper> existingProductPriceWrapperList = new List<ProductPriceWrapper>();
      existingProductPriceWrapperList = (List<ProductPriceWrapper>) JSON.deserialize(
        sfdcProduct.Price_Information__c,
        List<ProductPriceWrapper>.class
      );
      for (ProductPriceWrapper propriceWrap : existingProductPriceWrapperList) {
        mapOfEidVsProductPrice.put(propriceWrap.eid, propriceWrap);
      }
    }
    list<ProductPriceWrapper> productPriceWrapperList = new List<ProductPriceWrapper>();
    String productPriceInformation = '';
    PriceBook2 currencyPriceBookToInsert;
    Pricebook2 standardPB = new Pricebook2();
    if (!Test.isRunningTest()) {
      standardPB = [
        SELECT ID, Name
        FROM Pricebook2
        WHERE Name = :'Standard Price Book'
        LIMIT 50000
      ];
    } else {
      standardPB.Id = Test.getStandardPricebookId();
    }

    PricebookEntry[] standardPBEList = [
      SELECT id, Pricebook2Id, Product2Id, unitPrice, useStandardPrice
      FROM PricebookEntry
      WHERE Pricebook2Id = :standardPB.id AND Product2Id = :productId
      LIMIT 1
    ];
    if (standardPBEList == null || standardPBEList.isEmpty()) {
      PricebookEntry standardPBE = new PricebookEntry(
        Pricebook2Id = standardPB.ID,
        Product2Id = productId,
        IsActive = true,
        UnitPrice = 0.0,
        UseStandardPrice = false
      );
      if (
        TRACTAPIUtil.checkFieldLevelSecurity(
          'PricebookEntry',
          'Pricebook2Id,Product2Id,IsActive,UnitPrice,UseStandardPrice',
          'Create'
        )
      ) {
        insert standardPBE;
      }
    }

    if (productPricequeryResponse.productPrices != null) {
      ProductPriceWrapper sfdcProductPrice;
      SoapApi33Domain.RecurringProductPrice[] recurringProductPriceList = productPricequeryResponse.productPrices.recurringProductPrice;
      SoapApi33Domain.OneTimeProductPrice[] oneTimeProductPriceList = productPricequeryResponse.productPrices.oneTimeProductPrice;
      if (
        oneTimeProductPriceList != null && !oneTimeProductPriceList.isEmpty()
      ) {
        for (
          SoapApi33Domain.OneTimeProductPrice priceOneTime : oneTimeProductPriceList
        ) {
          if (
            mapOfEidVsProductPrice.containsKey(priceOneTime.eid) &&
            priceOneTime.thruDate != null
          ) {
            mapOfEidVsProductPrice.remove(priceOneTime.eid);
          } else if (
            !(mapOfEidVsProductPrice.containsKey(priceOneTime.eid)) &&
            priceOneTime.thruDate == null
          ) {
            system.debug('sfdcProductPrice::::::I am here');
            sfdcProductPrice = new ProductPriceWrapper();
            sfdcProductPrice.eid = priceOneTime.eid;
            sfdcProductPrice.currencyType = priceOneTime.currencyType;
            sfdcProductPrice.fromDate = TractSFDC_Util.productPriceFormat(
              priceOneTime.fromDate
            );
            sfdcProductPrice.thruDate = priceOneTime.thruDate;
            sfdcProductPrice.scheduledCharges = priceOneTime.allowScheduledCharges ==
              null
              ? false
              : priceOneTime.allowScheduledCharges;
            sfdcProductPrice.priceOverride = priceOneTime.priceOverride == null
              ? true
              : priceOneTime.priceOverride;
            sfdcProductPrice.priceType = priceOneTime.type_x;
            sfdcProductPrice.priceListEid = priceListEid;
            if (priceOneTime.priceRanges != null) {
              SoapApi33Domain.PriceRanges priceRanges = priceOneTime.priceRanges;
              SoapApi33Domain.PriceRange[] priceRangeList = priceRanges.priceRange;
              sfdcProductPrice.priceRangesList = createPriceRangeList(
                priceRangeList
              );
            }
            if (priceOneTime.priceCategory != null) {
              sfdcProductPrice.priceCategory = priceOneTime.priceCategory.name;
              sfdcProductPrice.priceCategoryId = priceOneTime.priceCategory.eid;
            }
            sfdcProductPrice.paymentOnPurchaseRequired = priceOneTime.paymentOnPurchaseRequired;
            productPriceWrapperList.add(sfdcProductPrice);
            Pricebook2[] priceBook = [
              SELECT ID, Name, CurrencyType__c
              FROM Pricebook2
              WHERE CurrencyType__c = :sfdcProductPrice.currencyType
              LIMIT 1
            ];
            System.debug('priceBook:::::::' + priceBook);
            if (priceBook == null || priceBook.isEmpty()) {
              currencyPriceBookToInsert = new Pricebook2(
                Description = ('Latest ' +
                sfdcProductPrice.currencyType +
                ' Price Book'),
                IsActive = true,
                Name = ('GTV ' +
                sfdcProductPrice.currencyType +
                ' Price Book'),
                currencyType__c = sfdcProductPrice.currencyType
              );
              if (
                TRACTAPIUtil.checkFieldLevelSecurity(
                  'Pricebook2',
                  'Description,IsActive,Name,TRACT3__currencyType__c',
                  'Create'
                )
              ) {
                insert currencyPriceBookToInsert;
              }
              PricebookEntry pbe = new PricebookEntry(
                Pricebook2Id = currencyPriceBookToInsert.id,
                Product2Id = productId,
                IsActive = true,
                UnitPrice = 0.0,
                UseStandardPrice = false
              );
              if (
                TRACTAPIUtil.checkFieldLevelSecurity(
                  'PricebookEntry',
                  'Pricebook2Id,Product2Id,IsActive,UnitPrice,UseStandardPrice',
                  'Create'
                )
              ) {
                insert pbe;
              }
            } else {
              PricebookEntry[] tractPiceBookEntryList = [
                SELECT id, Pricebook2Id, Product2Id, unitPrice, useStandardPrice
                FROM PricebookEntry
                WHERE
                  Pricebook2Id = :priceBook[0].id
                  AND Product2Id = :productId
                LIMIT 1
              ];

              if (
                tractPiceBookEntryList == null ||
                tractPiceBookEntryList.isEmpty()
              ) {
                PricebookEntry pbe = new PricebookEntry(
                  Pricebook2Id = priceBook[0].id,
                  Product2Id = productId,
                  IsActive = true,
                  UnitPrice = 0.0,
                  UseStandardPrice = false
                );
                if (
                  TRACTAPIUtil.checkFieldLevelSecurity(
                    'PricebookEntry',
                    'Pricebook2Id,Product2Id,IsActive,UnitPrice,UseStandardPrice',
                    'Create'
                  )
                ) {
                  insert pbe;
                }
              }
            }
          }
        }
      }

      if (
        recurringProductPriceList != null &&
        !recurringProductPriceList.isEmpty()
      ) {
        for (
          SoapApi33Domain.RecurringProductPrice price : recurringProductPriceList
        ) {
          if (
            mapOfEidVsProductPrice.containsKey(price.eid) &&
            price.thruDate != null
          ) {
            mapOfEidVsProductPrice.remove(price.eid);
          } else if (
            !(mapOfEidVsProductPrice.containsKey(price.eid)) &&
            price.thruDate == null
          ) {
            sfdcProductPrice = new ProductPriceWrapper();
            sfdcProductPrice.eid = price.eid;
            sfdcProductPrice.recurringPaymentRequired = price.recurringPaymentRequired ==
              null
              ? false
              : price.recurringPaymentRequired;
            sfdcProductPrice.currencyType = price.currencyType;
            sfdcProductPrice.fromDate = TractSFDC_Util.productPriceFormat(
              price.fromDate
            );
            sfdcProductPrice.scheduledCharges = price.allowScheduledCharges ==
              null
              ? false
              : price.allowScheduledCharges;
            sfdcProductPrice.paymentOnPurchaseRequired = price.paymentOnPurchaseRequired ==
              null
              ? false
              : price.paymentOnPurchaseRequired;
            sfdcProductPrice.priceOverride = price.priceOverride == null
              ? true
              : price.priceOverride;
            sfdcProductPrice.recurrencePeriod = price.recurrencePeriod;
            sfdcProductPrice.thruDate = price.thruDate;
            sfdcProductPrice.priceType = price.type_x;
            sfdcProductPrice.priceListEid = priceListEid;
            if (price.priceRanges != null) {
              SoapApi33Domain.PriceRanges priceRanges = price.priceRanges;
              SoapApi33Domain.PriceRange[] priceRangeList = priceRanges.priceRange;
              sfdcProductPrice.priceRangesList = createPriceRangeList(
                priceRangeList
              );
            }
            if (price.priceCategory != null) {
              sfdcProductPrice.priceCategory = price.priceCategory.name;
              sfdcProductPrice.priceCategoryId = price.priceCategory.eid;
            }
            sfdcProductPrice.proratedOnOrderNoCharge = price.proratedOnOrderNoCharge;
            sfdcProductPrice.proratedOnOrder = price.proratedOnOrder;
            sfdcProductPrice.proratedOnCancel = price.proratedOnCancel;
            sfdcProductPrice.recurringPaymentRequired = price.recurringPaymentRequired;
            sfdcProductPrice.paymentOnPurchaseRequired = price.paymentOnPurchaseRequired;
            sfdcProductPrice.billInAdvance = price.billInAdvance;
            productPriceWrapperList.add(sfdcProductPrice);
            Pricebook2[] priceBook = [
              SELECT ID, Name, CurrencyType__c
              FROM Pricebook2
              WHERE CurrencyType__c = :sfdcProductPrice.currencyType
              LIMIT 1
            ];
            if (priceBook == null || priceBook.isEmpty()) {
              currencyPriceBookToInsert = new Pricebook2(
                Description = ('Latest ' +
                sfdcProductPrice.currencyType +
                ' Price Book'),
                IsActive = true,
                Name = ('GTV ' +
                sfdcProductPrice.currencyType +
                ' Price Book'),
                currencyType__c = sfdcProductPrice.currencyType
              );
              if (
                TRACTAPIUtil.checkFieldLevelSecurity(
                  'Pricebook2',
                  'Description,IsActive,Name,TRACT3__currencyType__c',
                  'Create'
                )
              ) {
                insert currencyPriceBookToInsert;
              }
              PricebookEntry pbe = new PricebookEntry(
                Pricebook2Id = currencyPriceBookToInsert.id,
                Product2Id = productId,
                IsActive = true,
                UnitPrice = 0.0,
                UseStandardPrice = false
              );
              if (
                TRACTAPIUtil.checkFieldLevelSecurity(
                  'PricebookEntry',
                  'Pricebook2Id,Product2Id,IsActive,UnitPrice,UseStandardPrice',
                  'Create'
                )
              ) {
                insert pbe;
              }
            } else {
              PricebookEntry[] tractPiceBookEntryList = [
                SELECT id, Pricebook2Id, Product2Id, unitPrice, useStandardPrice
                FROM PricebookEntry
                WHERE
                  Pricebook2Id = :priceBook[0].id
                  AND Product2Id = :productId
                LIMIT 1
              ];

              if (
                tractPiceBookEntryList == null ||
                tractPiceBookEntryList.isEmpty()
              ) {
                PricebookEntry pbe = new PricebookEntry(
                  Pricebook2Id = priceBook[0].id,
                  Product2Id = productId,
                  IsActive = true,
                  UnitPrice = 0.0,
                  UseStandardPrice = false
                );
                if (
                  TRACTAPIUtil.checkFieldLevelSecurity(
                    'PricebookEntry',
                    'Pricebook2Id,Product2Id,IsActive,UnitPrice,UseStandardPrice',
                    'Create'
                  )
                ) {
                  insert pbe;
                }
              }
            }
          }
        }
      }
      for (
        ProductPriceWrapper existingValues : mapOfEidVsProductPrice.values()
      ) {
        productPriceWrapperList.add(existingValues);
      }
      productPriceInformation = JSON.serialize(productPriceWrapperList);
      sfdcProduct.Price_Information__c = productPriceInformation;
      if (
        TRACTAPIUtil.checkFieldLevelSecurity(
          'Product2',
          'Name, eid__c, PriceLists__c,Price_Information__c',
          'Upsert'
        )
      ) {
        upsert sfdcProduct;
      }
    }
  }
  /**
   *   @description -Method to parse MarketPlaces to MarketPlaceWrapper list
   *
   */
  public static list<MarketPlaceWrapper> mapMarketPlaces(
    SoapApi33Domain.QueryResponse marketPlaceQueryResponse
  ) {
    List<MarketPlaceWrapper> marketPlaceValueList = new List<MarketPlaceWrapper>();
    if (
      marketPlaceQueryResponse.marketPlaces.marketPlace != null &&
      marketPlaceQueryResponse.marketPlaces.marketPlace.size() > 0
    ) {
      for (
        SoapApi33Domain.MarketPlace marketPlace : marketPlaceQueryResponse.marketPlaces.marketPlace
      ) {
        MarketPlaceWrapper marketPlaceValueWrap = new MarketPlaceWrapper();
        marketPlaceValueWrap.mplaceId = marketPlace.eid;
        marketPlaceValueWrap.Name = marketPlace.name;
        marketPlaceValueWrap.Description = marketPlace.description;
        marketPlaceValueWrap.FromDate = Date.valueOf(marketPlace.fromDate);
        marketPlaceValueList.add(marketPlaceValueWrap);
      }
    }
    return marketPlaceValueList;
  }
  /**
   *   @description -Method to parse pricelist corresponding to MarketPlaces in PriceListWrapper list
   *
   */
  public static list<PriceListWrapper> mapMarketPlacePriceList(
    SoapApi33Domain.QueryResponse marketPlacePriceListQueryResponse
  ) {
    List<PriceListWrapper> marketPlacePriceListValueList = new List<PriceListWrapper>();
    if (
      marketPlacePriceListQueryResponse.priceLists.priceList != null &&
      marketPlacePriceListQueryResponse.priceLists.priceList.size() > 0
    ) {
      for (
        SoapApi33Domain.PriceList priceList : marketPlacePriceListQueryResponse.priceLists.priceList
      ) {
        PriceListWrapper marketPlacePriceListWrap = new PriceListWrapper();
        marketPlacePriceListWrap.priceListId = priceList.eid;
        marketPlacePriceListWrap.Name = priceList.name;
        marketPlacePriceListWrap.Description = priceList.description;
        marketPlacePriceListValueList.add(marketPlacePriceListWrap);
      }
    }
    return marketPlacePriceListValueList;
  }
  /**
   *   @description -Method to parse productRelation to ProductRelationWrapper list
   *
   */
  public static list<ProductRelationWrapper> mapProductRelation(
    SoapApi33Domain.QueryResponse queryResponse
  ) {
    list<ProductRelationWrapper> productRelationWrapperList = new List<ProductRelationWrapper>();
    SoapApi33Domain.ProductRelation[] relatedProducts = queryResponse.productRelations.productRelation;
    if (null != relatedProducts && relatedProducts.size() > 0) {
      for (SoapApi33Domain.ProductRelation productRelation : relatedProducts) {
        ProductRelationWrapper productRelationWrap = new ProductRelationWrapper();
        productRelationWrap.productName = productRelation.product.name;
        productRelationWrap.relatedfProductEid = productRelation.product.eid;
        productRelationWrap.relationShipType = productRelation.type_x;
        productRelationWrap.scope = productRelation.scope;
        productRelationWrap.productRelationShipEid = productRelation.eid;
        productRelationWrapperList.add(productRelationWrap);
      }
    }
    return productRelationWrapperList;
  }
  /**
   *   @description -Method to parse Responsible Accounts to BillingHierarchyWrapper
   *
   */
  public static BillingHierarchyWrapper mapResponsibleAccounts(
    SoapApi33Domain.QueryResponse queryResponse
  ) {
    BillingHierarchyWrapper billingHierarchyWrap = new BillingHierarchyWrapper();
    billingHierarchyWrap.managedAccountList = new List<TRACTAccountWrapper>();
    if (
      queryResponse.successful &&
      null != queryResponse.billingAccounts &&
      null != queryResponse.billingAccounts.billingAccount &&
      !queryResponse.billingAccounts.billingAccount.isEmpty()
    ) {
      if (
        queryResponse.billingAccounts.billingAccount[0].responsibleAccount !=
        null
      ) {
        SoapApi33Domain.BillingAccount responsibleAccount = queryResponse.billingAccounts.billingAccount[0]
          .responsibleAccount;
        if (
          responsibleAccount.organization != null &&
          responsibleAccount.organization.name != null
        ) {
          billingHierarchyWrap.responsibleAccountName = responsibleAccount.organization.name;
        }
        billingHierarchyWrap.responsibleAccountNumber = responsibleAccount.accountNum;
        if (
          responsibleAccount.responsibleAccountInvoiceRenderingType != null &&
          responsibleAccount.responsibleAccountInvoiceRenderingType != ''
        ) {
          billingHierarchyWrap.renderingType = responsibleAccount.responsibleAccountInvoiceRenderingType;
          billingHierarchyWrap.isAvailable = true;
        } else {
          billingHierarchyWrap.isAvailable = false;
        }
        if (responsibleAccount.monthlyBillCycle != null) {
          billingHierarchyWrap.billCycle = responsibleAccount.monthlyBillCycle.name;
        }
        if (responsibleAccount.dailyBillCycle != null) {
          billingHierarchyWrap.billCycle = responsibleAccount.dailyBillCycle.name;
        }
        if (responsibleAccount.quarterlyBillCycle != null) {
          billingHierarchyWrap.billCycle = responsibleAccount.quarterlyBillCycle.name;
        }
        if (responsibleAccount.yearlyBillCycle != null) {
          billingHierarchyWrap.billCycle = responsibleAccount.yearlyBillCycle.name;
        }
        if (responsibleAccount.segmentedMonthlyBillCycle != null) {
          billingHierarchyWrap.billCycle = responsibleAccount.segmentedMonthlyBillCycle.name;
        }
        //billingHierarchyWrap.responsibleAccountCompanyName =
      }
      for (
        SoapApi33Domain.BillingAccount billingAccount : queryResponse.billingAccounts.billingAccount
      ) {
        TRACTAccountWrapper managedAccount = new TRACTAccountWrapper();
        managedAccount.TractBillingAccountNumber = billingAccount.accountNum;
        managedAccount.eid = billingAccount.eid;
        managedAccount.status = billingAccount.status;
        managedAccount.validFrom = Date.valueof(billingAccount.startDate);
        if (
          billingAccount.organization != null &&
          billingAccount.organization.name != null
        ) {
          managedAccount.billingAccount = new account();
          managedAccount.billingAccount.Name = billingAccount.organization.name;
        }
        if (billingAccount.billingAccountCategory != null) {
          managedAccount.accountCategory = billingAccount.billingAccountCategory.type_x;
        }
        billingHierarchyWrap.managedAccountList.add(managedAccount);
      }
    }
    return billingHierarchyWrap;
  }
  /**
   *   @description -Method to parse Account Related child Accounts to TRACTAccountWrapper list
   *
   */
  public static list<TRACTAccountWrapper> parseChildAccountList(
    SoapApi33Domain.QueryResponse queryResponse
  ) {
    list<TRACTAccountWrapper> sfdcBillingAccountWrapperList = new List<TRACTAccountWrapper>();
    if (
      queryResponse.successful &&
      null != queryResponse.billingAccounts &&
      null != queryResponse.billingAccounts.billingAccount &&
      !queryResponse.billingAccounts.billingAccount.isEmpty()
    ) {
      list<SoapApi33Domain.BillingAccount> listOfBillingAccounts = queryResponse.billingAccounts.billingAccount;
      for (
        SoapApi33Domain.BillingAccount tractAccount : listOfBillingAccounts
      ) {
        TRACTAccountWrapper sfdcBillingAccount = new TRACTAccountWrapper();
        Account sfdcAccount = new Account();
        if (null != tractAccount) {
          if (
            tractAccount.organization != null &&
            tractAccount.organization.name != null
          ) {
            sfdcAccount.Name = tractAccount.organization.name;
          }
          sfdcAccount.Tract_Billing_Account__c = tractAccount.accountNum;
          sfdcBillingAccount.TractBillingAccountNumber = tractAccount.accountNum;
          sfdcBillingAccount.eid = tractAccount.eid;
          sfdcBillingAccount.balance = setAccountBalanceCurrencyType(
            string.valueOf(tractAccount.balance.setScale(2)),
            tractAccount.currencyType
          );
          sfdcBillingAccount.validFrom = Date.valueOf(tractAccount.startDate);
          if (
            tractAccount.person != null &&
            tractAccount.person.addresses != null
          ) {
            SoapApi33Domain.PostalAddress[] postalAddresses = tractAccount.person.addresses.postalAddress;
            if (postalAddresses != null && !postalAddresses.isEmpty()) {
              for (SoapApi33Domain.PostalAddress address : postalAddresses) {
                if (address.purpose.equals('SHIPPING')) {
                  sfdcAccount.ShippingStreet =
                    (address.line1 != null ? address.line1 : '') +
                    ' ' +
                    (address.line2 != null ? address.line2 : '');
                  sfdcAccount.ShippingCity = address.city;
                  sfdcAccount.ShippingPostalCode = address.postalCode;
                  sfdcAccount.ShippingState = address.regionOrState;
                  sfdcAccount.ShippingCountry = address.country;
                  sfdcBillingAccount.acccountAddress =
                    sfdcAccount.BillingStreet +
                    sfdcAccount.BillingCity +
                    ',' +
                    sfdcAccount.BillingPostalCode +
                    ',' +
                    sfdcAccount.BillingState +
                    ',' +
                    sfdcAccount.BillingCountry;
                } else if (address.purpose.equals('BILLING')) {
                  sfdcAccount.BillingStreet =
                    (address.line1 != null ? address.line1 : '') +
                    ' ' +
                    (address.line2 != null ? address.line2 : '');
                  sfdcAccount.BillingCity = address.city;
                  sfdcAccount.BillingPostalCode = address.postalCode;
                  sfdcAccount.BillingState = address.regionOrState;
                  sfdcAccount.BillingCountry = address.country;
                  sfdcBillingAccount.acccountAddress =
                    sfdcAccount.BillingStreet +
                    sfdcAccount.BillingCity +
                    ',' +
                    sfdcAccount.BillingPostalCode +
                    ',' +
                    sfdcAccount.BillingState +
                    ',' +
                    sfdcAccount.BillingCountry;
                }
              }
            }

            SoapApi33Domain.EmailAddress[] emailAddresses = tractAccount.person.addresses.emailAddress;
            if (emailAddresses != null && !emailAddresses.isEmpty()) {
              for (SoapApi33Domain.EmailAddress emailAdrs : emailAddresses) {
                if (emailAdrs.purpose.equals('PRIMARY')) {
                  sfdcBillingAccount.email = emailAdrs.email;
                }
              }
            }
          }
          if (
            tractAccount.organization != null &&
            tractAccount.organization.addresses != null
          ) {
            SoapApi33Domain.PostalAddress[] postalAddresses = tractAccount.organization.addresses.postalAddress;
            if (postalAddresses != null && !postalAddresses.isEmpty()) {
              for (SoapApi33Domain.PostalAddress address : postalAddresses) {
                if (address.purpose.equals('SHIPPING')) {
                  sfdcAccount.ShippingStreet =
                    (address.line1 != null ? address.line1 : '') +
                    ' ' +
                    (address.line2 != null ? address.line2 : '');
                  sfdcAccount.ShippingCity = address.city;
                  sfdcAccount.ShippingPostalCode = address.postalCode;
                  sfdcAccount.ShippingState = address.regionOrState;
                  sfdcAccount.ShippingCountry = address.country;
                  sfdcBillingAccount.acccountAddress =
                    sfdcAccount.BillingStreet +
                    sfdcAccount.BillingCity +
                    ',' +
                    sfdcAccount.BillingPostalCode +
                    ',' +
                    sfdcAccount.BillingState +
                    ',' +
                    sfdcAccount.BillingCountry;
                } else if (address.purpose.equals('BILLING')) {
                  sfdcAccount.BillingStreet =
                    (address.line1 != null ? address.line1 : '') +
                    ' ' +
                    (address.line2 != null ? address.line2 : '');
                  sfdcAccount.BillingCity = address.city;
                  sfdcAccount.BillingPostalCode = address.postalCode;
                  sfdcAccount.BillingState = address.regionOrState;
                  sfdcAccount.BillingCountry = address.country;
                  sfdcBillingAccount.acccountAddress =
                    sfdcAccount.BillingStreet +
                    sfdcAccount.BillingCity +
                    ',' +
                    sfdcAccount.BillingPostalCode +
                    ',' +
                    sfdcAccount.BillingState +
                    ',' +
                    sfdcAccount.BillingCountry;
                }
              }
            }
          }
        }
        sfdcBillingAccount.billingAccount = sfdcAccount;
        sfdcBillingAccountWrapperList.add(sfdcBillingAccount);
      }
    }
    return sfdcBillingAccountWrapperList;
  }
  /**
   *   @description -Method to parse Marketplace Response to SelectOption list
   *
   */
  public static list<SelectOption> mapMarketplaceResponse(
    SoapApi33Domain.QueryResponse marketPlaceQueryResponse
  ) {
    list<SelectOption> listOfMarketPlace = new List<SelectOption>();
    if (
      marketPlaceQueryResponse.marketPlaces.marketPlace != null &&
      marketPlaceQueryResponse.marketPlaces.marketPlace.size() > 0
    ) {
      for (
        SOAPAPI33Domain.MarketPlace sample : marketPlaceQueryResponse.marketPlaces.marketPlace
      ) {
        listOfMarketPlace.add(new SelectOption(sample.eid, sample.name));
      }
    }
    return listOfMarketPlace;
  }
  /**
   *   @description -Method to map Service Usage Rule to ProductUsesWrapper list
   *
   */
  public static List<ProductUsesWrapper> mapProductUsageRules(
    SoapApi33Domain.QueryResponse queryResponse
  ) {
    List<ProductUsesWrapper> ruleOverrides = new List<ProductUsesWrapper>();
    if (
      null != queryResponse.productUsageRules.matchAllProductUsageRule &&
      !queryResponse.productUsageRules.matchAllProductUsageRule.isEmpty()
    ) {
      SoapApi33Domain.MatchAllProductUsageRule[] matchAllProductUsageRule = queryResponse.productUsageRules.matchAllProductUsageRule;
      for (
        SoapApi33Domain.MatchAllProductUsageRule matchAll : matchAllProductUsageRule
      ) {
        ProductUsesWrapper productUsesWrapper = new ProductUsesWrapper();
        productUsesWrapper.ChargeName = matchAll.Name;
        productUsesWrapper.Rule = 'Matches all';
        productUsesWrapper.UsageRuleEid = matchAll.eid;
        productUsesWrapper.ChargeType = 'MatchAll';
        productUsesWrapper.ChargeCategory = matchAll.chargeCategory.name;

        if (null != matchAll.flatUsageRate) {
          productUsesWrapper.Rate =
            String.valueOf(matchAll.flatUsageRate.rate.setScale(2)) +
            ' per ' +
            matchAll.flatUsageRate.uom.toLowerCase().capitalize();
          if (matchAll.limit_x > 0)
            productUsesWrapper.Taper =
              String.valueOf(Decimal.valueOf(matchAll.limit_x).setScale(0)) +
              ' ' +
              matchAll.flatUsageRate.uom.toLowerCase().capitalize() +
              's';
          else
            productUsesWrapper.Taper =
              matchAll.allowanceType +
              ' ' +
              matchAll.flatUsageRate.uom.toLowerCase().capitalize();
        }
        if (null != matchAll.tableUsageRate) {
          productUsesWrapper.Rate =
            'Table Rate ' + matchAll.tableUsageRate.rateTable.name;
          productUsesWrapper.Taper =
            matchAll.allowanceType +
            ' ' +
            matchAll.tableUsageRate.rateTable.uom;
        }
        if (null != matchAll.passThroughUsageRate) {
          productUsesWrapper.Rate =
            'Pass Through ' + matchAll.passThroughUsageRate.usageFieldName;
          productUsesWrapper.Taper =
            String.valueOf(Decimal.valueOf(matchAll.limit_x).setScale(0)) +
            ' ' +
            matchAll.usageUom.toLowerCase().capitalize() +
            's';
        }
        productUsesWrapper.FromDate = String.valueOf(matchAll.validFrom);
        //productUsesWrappe.ThruDate = matchAll
        productUsesWrapper.Status = matchAll.status.toLowerCase().capitalize();
        ruleOverrides.add(productUsesWrapper);
      }
    }
    if (
      null != queryResponse.productUsageRules.formulaProductUsageRule &&
      !queryResponse.productUsageRules.formulaProductUsageRule.isEmpty()
    ) {
      SoapApi33Domain.FormulaProductUsageRule[] formulaAllProductUsageRule = queryResponse.productUsageRules.formulaProductUsageRule;
      for (
        SoapApi33Domain.FormulaProductUsageRule formulaAll : formulaAllProductUsageRule
      ) {
        ProductUsesWrapper productUsesWrapper = new ProductUsesWrapper();
        productUsesWrapper.ChargeName = formulaAll.name;
        productUsesWrapper.Rule =
          formulaAll.fieldName +
          ' = ' +
          formulaAll.fieldValue;
        productUsesWrapper.UsageRuleEid = formulaAll.eid;
        productUsesWrapper.ChargeType = 'Formula';
        productUsesWrapper.ChargeCategory = formulaAll.chargeCategory.name;
        if (null != formulaAll.flatUsageRate) {
          productUsesWrapper.Rate =
            String.valueOf(formulaAll.flatUsageRate.rate.setScale(2)) +
            ' per ' +
            formulaAll.flatUsageRate.uom.toLowerCase().capitalize();
          if (formulaAll.limit_x > 0)
            productUsesWrapper.Taper =
              String.valueOf(Decimal.valueOf(formulaAll.limit_x).setScale(0)) +
              ' ' +
              formulaAll.usageUom.toLowerCase().capitalize() +
              's';
          else
            productUsesWrapper.Taper =
              formulaAll.allowanceType +
              ' ' +
              formulaAll.flatUsageRate.uom.toLowerCase().capitalize();
        }
        if (null != formulaAll.tableUsageRate) {
          productUsesWrapper.Rate =
            'Table Rate ' + formulaAll.tableUsageRate.rateTable.name;
          productUsesWrapper.Taper =
            formulaAll.allowanceType +
            ' ' +
            formulaAll.tableUsageRate.rateTable.uom;
        }
        if (null != formulaAll.passThroughUsageRate) {
          productUsesWrapper.Rate =
            'Pass Through ' + formulaAll.passThroughUsageRate.usageFieldName;
          productUsesWrapper.Taper =
            String.valueOf(Decimal.valueOf(formulaAll.limit_x).setScale(0)) +
            ' ' +
            formulaAll.usageUom.toLowerCase().capitalize() +
            's';
        }
        productUsesWrapper.FromDate = String.valueOf(formulaAll.validFrom);
        //productUsesWrappe.ThruDate = matchAll
        productUsesWrapper.Status = formulaAll.status.toLowerCase()
          .capitalize();
        ruleOverrides.add(productUsesWrapper);
      }
    }

    if (
      null != queryResponse.productUsageRules.globalProductUsageRule &&
      !queryResponse.productUsageRules.globalProductUsageRule.isEmpty()
    ) {
      SoapApi33Domain.GlobalProductUsageRule[] globalAllProductUsageRule = queryResponse.productUsageRules.globalProductUsageRule;
      for (
        SoapApi33Domain.GlobalProductUsageRule globalAll : globalAllProductUsageRule
      ) {
        ProductUsesWrapper productUsesWrapper = new ProductUsesWrapper();
        productUsesWrapper.ChargeName = globalAll.name;
        productUsesWrapper.Rule = globalAll.globalUsageRule.name;
        productUsesWrapper.UsageRuleEid = globalAll.eid;
        productUsesWrapper.ChargeType = 'Global';
        productUsesWrapper.ChargeCategory = globalAll.chargeCategory.name;

        if (null != globalAll.passThroughUsageRate) {
          productUsesWrapper.Rate = 'Rule rating';
          if (globalAll.limit_x < 0)
            productUsesWrapper.Taper =
              globalAll.allowanceType +
              ' ' +
              globalAll.usageUom.toLowerCase().capitalize();
          else
            productUsesWrapper.Taper =
              String.valueOf(Decimal.valueOf(globalAll.limit_x).setScale(0)) +
              ' ' +
              globalAll.usageUom.toLowerCase().capitalize() +
              's';
        }
        productUsesWrapper.FromDate = String.valueOf(globalAll.validFrom);
        //productUsesWrappe.ThruDate = globalAll
        productUsesWrapper.Status = globalAll.status.toLowerCase().capitalize();
        ruleOverrides.add(productUsesWrapper);
      }
    }
    return ruleOverrides;
  }

  public static GTVPaymentWrapper parsePaymentMethods(
    SoapApi33Domain.QueryResponse queryResponse
  ) {
    GTVPaymentWrapper paymentWrap = new GTVPaymentWrapper();
    List<SelectOption> listOfPaymentMethods = new List<SelectOption>();
    Map<String, String> mapOfPaymentMethodEidVsType = new Map<String, String>();
    if (
      queryResponse.successful &&
      queryResponse != null &&
      queryResponse.recurringPayments.recurringPayment != null
    ) {
      for (
        SoapApi33Domain.BillingAccountRecurringPayment recurringPayment : queryResponse.recurringPayments.recurringPayment
      ) {
        if (recurringPayment.tokenizedCreditCardPaymentMethod != null) {
          listOfPaymentMethods.add(
            new SelectOption(
              recurringPayment.tokenizedCreditCardPaymentMethod.eid,
              recurringPayment.tokenizedCreditCardPaymentMethod.nickname
            )
          );
          mapOfPaymentMethodEidVsType.put(
            recurringPayment.tokenizedCreditCardPaymentMethod.eid,
            'Tokenized Credit Card'
          );
        }
        if (recurringPayment.creditCardPaymentMethod != null) {
          listOfPaymentMethods.add(
            new SelectOption(
              recurringPayment.eid,
              recurringPayment.creditCardPaymentMethod.nickname
            )
          );
        }
        if (recurringPayment.mobileCarrierPayment != null) {
          mapOfPaymentMethodEidVsType.put(
            recurringPayment.mobileCarrierPayment.eid,
            'Mobile Carrier Payment'
          );
          listOfPaymentMethods.add(
            new SelectOption(
              recurringPayment.mobileCarrierPayment.eid,
              recurringPayment.mobileCarrierPayment.nickname
            )
          );
        }
        if (recurringPayment.bankPaymentMethod != null) {
          mapOfPaymentMethodEidVsType.put(
            recurringPayment.bankPaymentMethod.eid,
            'Bank Payment'
          );
          listOfPaymentMethods.add(
            new SelectOption(
              recurringPayment.bankPaymentMethod.eid,
              recurringPayment.bankPaymentMethod.nickname
            )
          );
        }
        /*if(recurringPayment.referencedCreditCardPaymentMethod != null){
                    listOfPaymentMethods.add(new SelectOption(recurringPayment.referencedCreditCardPaymentMethod.eid, recurringPayment.referencedCreditCardPaymentMethod.nickname));                    
                }*/
        if (recurringPayment.bpayPaymentMethod != null) {
          String nickName =
            'BPAY Ending ' +
            recurringPayment.bpayPaymentMethod.customerReferenceNumber.right(4);
          listOfPaymentMethods.add(
            new SelectOption(recurringPayment.eid, nickName)
          );
        }
        if (recurringPayment.payPalPaymentMethod != null) {
          mapOfPaymentMethodEidVsType.put(
            recurringPayment.PayPalPaymentMethod.eid,
            'PayPal Preapproval'
          );
          listOfPaymentMethods.add(
            new SelectOption(
              recurringPayment.PayPalPaymentMethod.eid,
              'PayPal Preapproval'
            )
          );
        }
        if (recurringPayment.sepaDirectDebitPaymentMethod != null) {
          mapOfPaymentMethodEidVsType.put(
            recurringPayment.sepaDirectDebitPaymentMethod.iban,
            'Sepa Direct Debit'
          );
          String nickName =
            'SEPA Direct Debit EM Ending ' +
            recurringPayment.sepaDirectDebitPaymentMethod.iban;
          listOfPaymentMethods.add(
            new SelectOption(
              recurringPayment.sepaDirectDebitPaymentMethod.iban,
              nickName
            )
          );
        }
        if (recurringPayment.customPaymentMethod != null) {
          listOfPaymentMethods.add(
            new SelectOption(recurringPayment.eid, 'Custom')
          );
        }
      }
    }
    paymentWrap.listOfPaymentMethods = listOfPaymentMethods;
    paymentWrap.mapOfPaymentMethodEidVsType = mapOfPaymentMethodEidVsType;
    system.debug('listOfPaymentMethodsSOAP::::' + listOfPaymentMethods);
    return paymentWrap;
  }
}