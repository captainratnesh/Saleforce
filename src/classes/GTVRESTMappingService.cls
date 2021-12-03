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
 * This Wrapper is used to map the REST API response to the salesforce wrapper classes.
 * @author AMAN JAIN
 */

public with sharing class GTVRESTMappingService {
  /**
   * Parse the queried billing Account and map it with Salesforce Account Object
   * @param tractBillingAccount The billing account response wrapper (required)
   * @param sfdcAccount The Salesforce billing account to be mapped (required)
   * @return TRACTAccountWrapper
   */
  public static TRACTAccountWrapper parseBillingAccount(
    RestAPI2Domain.GTVAPIBillingAccount tractBillingAccount
  ) {
    TRACTAccountWrapper sfdcBillingAccount = new TRACTAccountWrapper();
    Account sfdcAccount = new Account();
    if (null != tractBillingAccount) {
      sfdcAccount.Name = tractBillingAccount.responsibleParty.organizationName;
      sfdcBillingAccount.status = tractBillingAccount.status.name();
      sfdcBillingAccount.balance = TractSFDC_Util.setBalanceCurrencyType(
        String.valueOf(tractBillingAccount.balance),
        tractBillingAccount.currencyCode.name().toUpperCase()
      );
      sfdcBillingAccount.billCycleName = tractBillingAccount.billCycle.name;
      sfdcBillingAccount.billType = TractSFDC_Util.convertInvoiceTypeToCamelCase(
        tractBillingAccount.billType.name(),
        '_'
      );
      sfdcBillingAccount.accountCategory = tractBillingAccount.billingAccountCategory.name;
      sfdcAccount.Tract_Billing_Account__c = tractBillingAccount.accountNum;
      sfdcBillingAccount.TractBillingAccountNumber = tractBillingAccount.accountNum;
      sfdcBillingAccount.eid = tractBillingAccount.id;
      sfdcBillingAccount.accountCurrency = tractBillingAccount.currencyCode.name()
        .toUpperCase();
      sfdcBillingAccount.validFrom = Date.valueOf(
        tractBillingAccount.startDate
      );
      sfdcBillingAccount.taxExempt = tractBillingAccount.taxExempt;
      if (tractBillingAccount.paymentTerm != null) {
        sfdcBillingAccount.paymentTerm = tractBillingAccount.paymentTerm.name;
      }
      if (tractBillingAccount.responsibleParty.addresses != null) {
        for (
          RestAPI2Domain.GTVAPIAddress address : tractBillingAccount.responsibleParty.addresses
        ) {
          if (
            address.addressType.Name() == 'postal' &&
            address.purpose.Name() == 'billing'
          ) {
            sfdcAccount.BillingStreet = address.line1;
            sfdcAccount.BillingCity = address.city;
            sfdcAccount.BillingPostalCode = address.postalCode;
            sfdcAccount.BillingState = address.regionOrState;
            sfdcAccount.BillingCountry = address.country;
          } else if (
            address.addressType.Name() == 'postal' &&
            address.purpose.Name() == 'shipping'
          ) {
            sfdcAccount.ShippingStreet = address.line1;
            sfdcAccount.ShippingCity = address.city;
            sfdcAccount.ShippingPostalCode = address.postalCode;
            sfdcAccount.ShippingState = address.regionOrState;
            sfdcAccount.ShippingCountry = address.country;
          } else if (address.addressType.Name() == 'email') {
            sfdcBillingAccount.email = address.email;
          }
        }
      }
    }
    sfdcBillingAccount.billingAccount = sfdcAccount;
    return sfdcBillingAccount;
  }

  /**
   * Parse the queried payments for billing Account
   * @param tractPaymentsList The list of billing account payment response wrapper (required)
   * @param tractPaymentApplicationList The list of payment applications (required)
   * @param currencyType  (required)
   * @return TractPaymentWrapper
   */
  public static TractPaymentWrapper parsePayments(
    List<RestAPI2Domain.GTVAPIPayment> tractPaymentsList,
    List<RestAPI2Domain.GTVAPIPaymentApplication> tractPaymentApplicationList,
    String currencyType
  ) {
    TractPaymentWrapper sfdcPaymentUIWrapper = new TractPaymentWrapper();
    Map<String, String> paymentToInvoicesMap = new Map<String, String>();
    if (
      null != tractPaymentApplicationList &&
      !tractPaymentApplicationList.isEmpty()
    ) {
      paymentToInvoicesMap = GTVAPIUtil.getPaymentToInvoicesMapFromPaymentApp(
        tractPaymentApplicationList
      );
    }
    if (null != tractPaymentsList && !tractPaymentsList.isEmpty()) {
      List<PaymentWrapper> paymentListWrapper = new List<PaymentWrapper>();
      for (RestAPI2Domain.GTVAPIPayment tractPayment : tractPaymentsList) {
        if (
          tractPayment.status != 'Processing_error' &&
          tractPayment.status != 'Void'
        ) {
          PaymentWrapper sfdcPaymentWrap = new PaymentWrapper();
          sfdcPaymentWrap.PaymentAmount = TractSFDC_Util.setBalanceCurrencyType(
            String.valueOf(tractPayment.amount),
            currencyType
          );
          sfdcPaymentWrap.PaymentMethodType = String.valueOf(
            tractPayment.paymentType
          );
          sfdcPaymentWrap.Status = String.valueOf(tractPayment.status);
          sfdcPaymentWrap.OccurredOn = tractPayment.occurredOn;
          sfdcPaymentWrap.Description = tractPayment.description;
          sfdcPaymentWrap.Name = tractPayment.id;
          if (paymentToInvoicesMap.containsKey(tractPayment.id)) {
            sfdcPaymentWrap.InvoicesPaid = paymentToInvoicesMap.get(
              tractPayment.id
            );
          }
          paymentListWrapper.add(sfdcPaymentWrap);
        }
      }
      sfdcPaymentUIWrapper.paymentListWrapper = paymentListWrapper;
    }
    return sfdcPaymentUIWrapper;
  }

  /**
   * Parse the queried payments for billing Account
   * @param tractInvoiceList The list of billing account invoices response wrapper (required)
   * @param currencyType  (required)
   * @return TractPaymentWrapper
   */
  public static TractInvoiceWrapper parseInvoices(
    List<RestAPI2Domain.GTVAPIInvoice> tractInvoiceList,
    String currencyType
  ) {
    TractInvoiceWrapper sfdcInvoiceWrapper = new TractInvoiceWrapper();
    if (null != tractInvoiceList && !tractInvoiceList.isEmpty()) {
      List<InvoiceWrapper> invoiceListWrapper = new List<InvoiceWrapper>();
      for (RestAPI2Domain.GTVAPIInvoice gtvInvoiceObj : tractInvoiceList) {
        InvoiceWrapper invoiceWrapObj = new InvoiceWrapper();
        invoiceWrapObj.InvoicedDate = gtvInvoiceObj.occurredOn;
        invoiceWrapObj.Name = gtvInvoiceObj.invoiceNum;
        invoiceWrapObj.InvoiceAmount = TractSFDC_Util.setBalanceCurrencyType(
          String.valueOf(gtvInvoiceObj.amount),
          currencyType
        );
        invoiceWrapObj.InvoiceAmountToPay = TractSFDC_Util.setBalanceCurrencyType(
          String.valueOf(gtvInvoiceObj.amountToPay),
          currencyType
        );
        invoiceWrapObj.PaidDate = gtvInvoiceObj.paidDate;
        invoiceWrapObj.DueDate = gtvInvoiceObj.dueDate;
        invoiceWrapObj.InvoicePdf =
          'invoices/' +
          gtvInvoiceObj.id +
          '/downloads';
        invoiceWrapObj.CheckInvoiceStatus = gtvInvoiceObj.status.name() !=
          'PROCESSING'
          ? true
          : false;
        invoiceWrapObj.Status = gtvInvoiceObj.status.name().capitalize();
        invoiceWrapObj.currencyType = currencyType;
        invoiceListWrapper.add(invoiceWrapObj);
      }
      sfdcInvoiceWrapper.invoiceListWrapper = invoiceListWrapper;
    }
    return sfdcInvoiceWrapper;
  }

  /**
   * Parse the queried debit adjustments for billing Account
   * @param tractDebitAdjustmentList The list of billing account debit adjustments response wrapper (required)
   * @param currencyType  (required)
   * @return TractAdjustmentWrapper
   */
  public static TractAdjustmentWrapper parseDebitAdjustments(
    List<RestAPI2Domain.GTVAPIDebitAccountAdjustment> tractDebitAdjustmentList,
    String currencyType
  ) {
    TractAdjustmentWrapper sfdcDebitAdjustmentWrap = new TractAdjustmentWrapper();
    if (
      null != tractDebitAdjustmentList && !tractDebitAdjustmentList.isEmpty()
    ) {
      List<AdjustmentWrapper> adjustmentListWrapper = new List<AdjustmentWrapper>();
      for (
        RestAPI2Domain.GTVAPIDebitAccountAdjustment gtvDebitAdjustmentObj : tractDebitAdjustmentList
      ) {
        AdjustmentWrapper adjustmentWrapObj = new AdjustmentWrapper();
        adjustmentWrapObj.Name = gtvDebitAdjustmentObj.id;
        adjustmentWrapObj.credit = gtvDebitAdjustmentObj.credit;
        adjustmentWrapObj.ManuallyApply = gtvDebitAdjustmentObj.manualInvoiceApplication ==
          true
          ? 'Yes'
          : 'No';
        adjustmentWrapObj.postedOn = gtvDebitAdjustmentObj.postedOn;
        adjustmentWrapObj.reason = gtvDebitAdjustmentObj.reason.name != null
          ? gtvDebitAdjustmentObj.reason.name
          : '';
        adjustmentWrapObj.ShowAdjustmentAmount = TractSFDC_Util.setBalanceCurrencyType(
          String.valueOf(gtvDebitAdjustmentObj.amount),
          currencyType
        );
        adjustmentWrapObj.description = gtvDebitAdjustmentObj.description;
        adjustmentWrapObj.OccurredOn = gtvDebitAdjustmentObj.occurredOn;
        adjustmentWrapObj.Type = TractSFDC_Util.getAdjustmentType(
          gtvDebitAdjustmentObj.adjustmentType.name()
        );
        adjustmentWrapObj.Status = gtvDebitAdjustmentObj.status != null
          ? gtvDebitAdjustmentObj.status.name().capitalize()
          : '';
        adjustmentListWrapper.add(adjustmentWrapObj);
      }
      sfdcDebitAdjustmentWrap.adjustmentListWrapper = adjustmentListWrapper;
    }
    return sfdcDebitAdjustmentWrap;
  }
  /**
   * Parse the queried chargeCategory for billing Account
   * @param tractDebitAdjustmentList The list of billing account debit adjustments response wrapper (required)
   * @param currencyType  (required)
   * @return TractAdjustmentWrapper
   */

  public static list<SelectOption> mapChargeCategory(
    List<RestAPI2Domain.GTVAPIChargeCategory> categoryResponseMap
  ) {
    list<SelectOption> chargeCategoryList = new List<SelectOption>();
    chargeCategoryList.add(new SelectOption('Choose One', 'Choose One'));
    for (RestAPI2Domain.GTVAPIChargeCategory usagePrice : categoryResponseMap) {
      chargeCategoryList.add(new SelectOption(usagePrice.id, usagePrice.name));
    }
    return chargeCategoryList;
  }
  /**
   * Parse the queried RateTables for billing Account
   * @param tractDebitAdjustmentList The list of billing account debit adjustments response wrapper (required)
   * @param currencyType  (required)
   * @return TractAdjustmentWrapper
   */

  public static list<SelectOption> mapRateTables(
    List<RestAPI2Domain.GTVAPIRateTable> rateTableResponseMap
  ) {
    list<SelectOption> chargeCategoryList = new List<SelectOption>();
    chargeCategoryList.add(new SelectOption('Choose One', 'Choose One'));
    for (RestAPI2Domain.GTVAPIRateTable usagePrice : rateTableResponseMap) {
      chargeCategoryList.add(new SelectOption(usagePrice.id, usagePrice.name));
    }
    return chargeCategoryList;
  }
  /**
   * Parse the queried RateTables for billing Account
   * @param tractDebitAdjustmentList The list of billing account debit adjustments response wrapper (required)
   * @param currencyType  (required)
   * @return uom
   */
  public static String mapRateTablesUom(
    List<RestAPI2Domain.GTVAPIRateTable> rateTableResponseMap
  ) {
    RestAPI2Domain.GTVAPIRateTable usagePrice = rateTableResponseMap[0];
    String uom = usagePrice.uom;
    return uom;
  }

  /**
   * Parse the queried credit adjustments for billing Account
   * @param tractDebitAdjustmentList The list of billing account Credit Adjustments response wrapper (required)
   * @param currencyType  (required)
   * @return TractAdjustmentWrapper
   */
  public static TractAdjustmentWrapper parseCreditAdjustments(
    List<RestAPI2Domain.GTVAPICreditAccountAdjustment> tractCreditAdjustmentList,
    String currencyType
  ) {
    TractAdjustmentWrapper sfdcCreditAdjustmentWrap = new TractAdjustmentWrapper();
    if (
      null != tractCreditAdjustmentList && !tractCreditAdjustmentList.isEmpty()
    ) {
      List<AdjustmentWrapper> adjustmentListWrapper = new List<AdjustmentWrapper>();
      for (
        RestAPI2Domain.GTVAPICreditAccountAdjustment gtvCreditAdjustmentObj : tractCreditAdjustmentList
      ) {
        AdjustmentWrapper adjustmentWrapObj = new AdjustmentWrapper();
        adjustmentWrapObj.Name = gtvCreditAdjustmentObj.creditNumber;
        adjustmentWrapObj.credit = gtvCreditAdjustmentObj.credit;
        adjustmentWrapObj.ManuallyApply = gtvCreditAdjustmentObj.manualInvoiceApplication ==
          true
          ? 'Yes'
          : 'No';
        adjustmentWrapObj.postedOn = gtvCreditAdjustmentObj.postedOn;
        adjustmentWrapObj.reason = gtvCreditAdjustmentObj.reason.name != null
          ? gtvCreditAdjustmentObj.reason.name
          : '';
        adjustmentWrapObj.ShowAdjustmentAmount = TractSFDC_Util.setBalanceCurrencyType(
          String.valueOf(gtvCreditAdjustmentObj.amount),
          currencyType
        );
        adjustmentWrapObj.description = gtvCreditAdjustmentObj.description;
        adjustmentWrapObj.OccurredOn = gtvCreditAdjustmentObj.occurredOn;
        adjustmentWrapObj.Type = TractSFDC_Util.getAdjustmentType(
          gtvCreditAdjustmentObj.adjustmentType.name()
        );
        adjustmentWrapObj.Status = gtvCreditAdjustmentObj.status != null
          ? gtvCreditAdjustmentObj.status.name().capitalize()
          : '';
        if (
          gtvCreditAdjustmentObj.items != null &&
          gtvCreditAdjustmentObj.items.size() > 0 &&
          gtvCreditAdjustmentObj.items[0].orderItem != null
        ) {
          adjustmentWrapObj.orderItemId = gtvCreditAdjustmentObj.items[0]
            .orderItem.id;
        }
        adjustmentListWrapper.add(adjustmentWrapObj);
      }
      sfdcCreditAdjustmentWrap.adjustmentListWrapper = adjustmentListWrapper;
    }
    return sfdcCreditAdjustmentWrap;
  }

  /**
   * Parse the queried Contacts for billing Account
   * @param tractDebitAdjustmentList The list of billing account invoices response wrapper (required)
   * @return TRACTContactWrapper
   */
  public static TRACTContactWrapper parseContacts(
    List<RestAPI2Domain.GTVAPIPerson> tractContactList
  ) {
    TRACTContactWrapper sfdcContactWrap = new TRACTContactWrapper();
    if (null != tractContactList && !tractContactList.isEmpty()) {
      List<ContactWrapper> contactWrapperList = new List<ContactWrapper>();
      for (RestAPI2Domain.GTVAPIPerson gtvContactObj : tractContactList) {
        ContactWrapper contactWrapObj = new ContactWrapper();
        String firstName = '';
        String lastName = '';
        String middleName = '';
        String suffix = '';
        if (gtvContactObj.firstName != null) {
          firstName = gtvContactObj.firstName + ' ';
        }
        if (gtvContactObj.middleName != null) {
          middleName = gtvContactObj.middleName + ' ';
        }
        if (gtvContactObj.lastName != null) {
          lastName = gtvContactObj.lastName + ' ';
        }
        if (gtvContactObj.suffix != null) {
          suffix = gtvContactObj.suffix;
        }
        contactWrapObj.name = firstName + middleName + lastName + suffix;
        contactWrapObj.department = gtvContactObj.department;
        if (gtvContactObj.contactCategory != null) {
          contactWrapObj.categoryName = gtvContactObj.contactCategory.name;
        }
        if (
          gtvContactObj.addresses != null &&
          gtvContactObj.addresses.size() > 0
        ) {
          for (RestAPI2Domain.GTVAPIAddress address : gtvContactObj.addresses) {
            if (
              address.addressType.Name() == 'email' &&
              address.purpose.Name() == 'primary'
            ) {
              contactWrapObj.email = address.email;
            } else if (address.addressType.Name() == 'telecom') {
              contactWrapObj.phone = TractSFDC_Util.getPhone(
                address.countryCode,
                address.areaCode,
                address.r_number,
                address.extension
              );
            }
          }
        }
        contactWrapObj.title = gtvContactObj.title;
        contactWrapperList.add(contactWrapObj);
      }
      sfdcContactWrap.contactWrapperList = contactWrapperList;
    }
    return sfdcContactWrap;
  }

  /**
   * Parse the queried payment methods for billing Account
   * @param tractPaymentMethodList The list of billing account payments response wrapper (required)
   * @param currencyType  (required)
   * @return TRACTPaymentMethodWrapper
   */
  public static TRACTPaymentMethodWrapper parsePaymentMethodRecords(
    List<RestAPI2Domain.GTVAPIRecurringPayment> tractPaymentMethodList
  ) {
    TRACTPaymentMethodWrapper paymentMethodWrapper = new TRACTPaymentMethodWrapper();
    list<PaymentMethodWrapper> paymentMethodRecords = new List<PaymentMethodWrapper>();
    for (
      RestAPI2Domain.GTVAPIRecurringPayment paymentMethodObj : tractPaymentMethodList
    ) {
      PaymentMethodWrapper record = new PaymentMethodWrapper();
      if (
        paymentMethodObj.paymentMethod.paymentMethodType ==
        'tokenized-credit-card' ||
        paymentMethodObj.paymentMethod.paymentMethodType == 'credit-card'
      ) {
        if (paymentMethodObj.paymentMethod.nickname != null) {
          record.nickName = GTVAPIUtil.getNickName(paymentMethodObj);
        }
        record.description =
          paymentMethodObj.paymentMethod.cardType +
          ', ' +
          paymentMethodObj.paymentMethod.firstName +
          ' ' +
          paymentMethodObj.paymentMethod.lastName +
          ', ' +
          paymentMethodObj.paymentMethod.identifierNumber +
          ', ' +
          paymentMethodObj.paymentMethod.expirationDate;
        record.validFrom = paymentMethodObj.validFrom;
        record.validTo = paymentMethodObj.validTo;
        if (paymentMethodObj.paymentMethod.telecomAddress != null) {
          record.phone = GTVAPIUtil.getTelecomAddressDetails(paymentMethodObj);
        }
        if (paymentMethodObj.paymentMethod.emailAddress != null) {
          record.email = GTVAPIUtil.getEmail(paymentMethodObj);
        }
        if (paymentMethodObj.paymentMethod.postalAddress != null) {
          record.address = GTVAPIUtil.getPostalAddress(paymentMethodObj);
        } else {
          record.address = 'Same as Billing Address';
        }
        paymentMethodRecords.add(record);
      }

      if (paymentMethodObj.paymentMethod.paymentMethodType == 'bpay') {
        if (paymentMethodObj.paymentMethod.nickname != null) {
          record.nickName = GTVAPIUtil.getNickName(paymentMethodObj);
        }
        record.description = '';
        record.address = 'Same as Billing Address';
        record.validFrom = paymentMethodObj.validFrom;
        record.validTo = paymentMethodObj.validTo;
        paymentMethodRecords.add(record);
      }

      if (paymentMethodObj.paymentMethod.paymentMethodType == 'custom') {
        record.nickName = 'custom';
        record.description =
          'custom' + paymentMethodObj.paymentMethod.reference;
        record.address = 'Same as Billing Address';
        record.validFrom = paymentMethodObj.validFrom;
        record.validTo = paymentMethodObj.validTo;
        paymentMethodRecords.add(record);
      }
      if (paymentMethodObj.paymentMethod.paymentMethodType == 'pay-pal') {
        record.nickName = GTVAPIUtil.getNickName(paymentMethodObj);
        record.description = 'PayPal';
        if (paymentMethodObj.paymentMethod.postalAddress != null) {
          record.address = GTVAPIUtil.getPostalAddress(paymentMethodObj);
        } else {
          record.address = 'Same as Billing Address';
        }
        if (paymentMethodObj.paymentMethod.emailAddress != null) {
          record.email = GTVAPIUtil.getEmail(paymentMethodObj);
        }
        record.validFrom = paymentMethodObj.validFrom;
        record.validTo = paymentMethodObj.validTo;
        paymentMethodRecords.add(record);
      }

      if (paymentMethodObj.paymentMethod.paymentMethodType == 'bank') {
        if (paymentMethodObj.paymentMethod.nickname != null) {
          record.nickName = GTVAPIUtil.getNickName(paymentMethodObj);
        }
        if (paymentMethodObj.paymentMethod.emailAddress != null) {
          record.email = GTVAPIUtil.getEmail(paymentMethodObj);
        }
        record.description =
          paymentMethodObj.paymentMethod.bankName +
          ', ' +
          paymentMethodObj.paymentMethod.routingNumber +
          ', ' +
          paymentMethodObj.paymentMethod.accountType +
          ', ' +
          paymentMethodObj.paymentMethod.accountNumber;
        if (paymentMethodObj.paymentMethod.postalAddress != null) {
          record.address = GTVAPIUtil.getPostalAddress(paymentMethodObj);
        } else {
          record.address = 'Same as Billing Address';
        }
        if (paymentMethodObj.paymentMethod.telecomAddress != null) {
          record.phone = GTVAPIUtil.getTelecomAddressDetails(paymentMethodObj);
        }
        record.validFrom = paymentMethodObj.validFrom;
        record.validTo = paymentMethodObj.validTo;
        paymentMethodRecords.add(record);
      }

      if (paymentMethodObj.paymentMethod.paymentMethodType == 'direct-debit') {
        if (paymentMethodObj.paymentMethod.nickname != null) {
          record.nickName = GTVAPIUtil.getNickName(paymentMethodObj);
        }
        if (paymentMethodObj.paymentMethod.emailAddress != null) {
          record.email = GTVAPIUtil.getEmail(paymentMethodObj);
        }
        record.address = 'Same as Billing Address';
        record.validFrom = paymentMethodObj.validFrom;
        record.validTo = paymentMethodObj.validTo;
        paymentMethodRecords.add(record);
      }
    }
    paymentMethodWrapper.paymentMethodList = paymentMethodRecords;
    return paymentMethodWrapper;
  }

  /**
   * Parse the queried Sales Order for billing Account
   * @param tractSalesOrderList The list of billing account Sales Order response wrapper (required)
   * @return TractAdjustmentWrapper
   */
  public static TractSalesOrderWrapper parseSalesOrders(
    List<RestAPI2Domain.GTVAPIOrder> tractSalesOrderList
  ) {
    TractSalesOrderWrapper sfdcSalesOrderList = new TractSalesOrderWrapper();
    if (null != tractSalesOrderList && !tractSalesOrderList.isEmpty()) {
      List<SalesWrapper> salesOrderWrapperList = new List<SalesWrapper>();
      for (RestAPI2Domain.GTVAPIOrder tractSalesOrder : tractSalesOrderList) {
        SalesWrapper salesOrderWrapperObj = new SalesWrapper();
        salesOrderWrapperObj.Name = tractSalesOrder.orderNum;
        salesOrderWrapperObj.Note = tractSalesOrder.note;
        salesOrderWrapperObj.OrderDate = tractSalesOrder.orderDate;
        salesOrderWrapperObj.OrderStatus = tractSalesOrder.status.name();
        salesOrderWrapperObj.PurchaseOrderNumber = tractSalesOrder.purchaseOrderNumber;
        salesOrderWrapperList.add(salesOrderWrapperObj);
      }
      sfdcSalesOrderList.salesOrderWrapperList = salesOrderWrapperList;
    }
    return sfdcSalesOrderList;
  }
  /**
   * Parse the queried Sales Order for billing Account
   * @param tractSalesOrderList The list of billing account Sales Order response wrapper (required)
   * @return TractAdjustmentWrapper
   */
  public static TractServiceWrapper parseServices(
    List<RestAPI2Domain.GTVAPISFService> responseServiceMap
  ) {
    TractServiceWrapper sfdcServicesList = new TractServiceWrapper();
    List<Service__c> servicesList = new List<Service__c>();
    if (null != responseServiceMap && !responseServiceMap.isEmpty()) {
      for (RestAPI2Domain.GTVAPISFService srv : responseServiceMap) {
        Service__c servicesObj = new Service__c();
        servicesObj.Name = srv.description;
        servicesObj.Service_Agreement__c = null != srv.currentAgreementService
          ? srv.currentAgreementService.id
          : '';
        servicesObj.Amount__c = srv.amount;
        servicesObj.ServiceEid__c = srv.id;
        servicesObj.Quantity__c = srv.quantity;
        servicesObj.Service_Amount__c = srv.amount;
        servicesObj.Status__c = TractSFDC_Util.getServiceStatus(
          srv.status.name()
        );
        servicesObj.StatusDate__c = srv.status.name() == 'DEACTIVATED'
          ? srv.endDate.date()
          : srv.startDate.date();
        servicesObj.checkDeactivate__c = srv.status.name() == 'ACTIVE'
          ? true
          : false;
        servicesObj.SuspendService__c = srv.status.name() == 'SUSPENDED'
          ? true
          : false;
        servicesObj.ParentService__r = srv.parentService != null
          ? new Service__C(Name = srv.parentService.id)
          : new Service__C(Name = '');
        servicesObj.Parent_Service_Eid__c = srv.product.productType == 'ADDON'
          ? srv.parentService.id
          : '';
        servicesObj.ProductEid__c = srv.product.id;
        servicesObj.ServiceProductName__c = srv.product.name;
        servicesObj.ServiceProductCode__c = srv.product.productType != null
          ? srv.product.productType
          : '';
        servicesList.add(servicesObj);
      }
    }
    /* added the value into wrapper variable */
    sfdcServicesList.serviceList = servicesList;
    return sfdcServicesList;
  }
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
    List<RestAPI2Domain.GTVAPISFService> responseServiceList,
    Map<String, List<RestAPI2Domain.GTVAPIServiceResource>> servicesIDvsResoucesMap,
    Integer totalPages
  ) {
    TractServiceWrapper serviceWrapper = new TractServiceWrapper();
    list<ProductServiceWrapper> childServiceProducts = new List<ProductServiceWrapper>();
    list<ProductServiceWrapper> serviceProducts = new List<ProductServiceWrapper>();
    map<String, Product2> productMap = new Map<String, Product2>();
    map<String, list<ProductServiceWrapper>> productServiceEidVSServiceWrapperMap = new Map<String, list<ProductServiceWrapper>>();
    for (Product2 pro : [
      SELECT
        id,
        Name,
        maxServiceResources__c,
        minServiceResources__c,
        Serialized__c,
        RuleOverride__c
      FROM Product2
      LIMIT 50000
    ]) {
      productMap.put(pro.Name, pro);
    }
    String TRACTurl;
    TRACTurl = tract.TRACT_URL2_0__c.replace('api', 'ui');
    TRACTurl = TRACTurl.remove('/billing/2');
    String accID = thisAccount.Tract_Billing_Account__c;
    TRACTurl = TRACTurl + '/accounts/' + accID + '/summary';

    for (RestAPI2Domain.GTVAPISFService srv : responseServiceList) {
      system.debug('srv:::' + srv);
      ProductServiceWrapper proWrap = new ProductServiceWrapper();
      if (thisAccount.Tract_Billing_Account__c != null) {
        proWrap.createBillingAccount = true;
      }
      proWrap.thisAccount = thisAccount;
      proWrap.reasonList = serviceReasons;
      proWrap.suspendReasonList = suspendServicesReason;
      proWrap.TractUrl = TRACTurl;
      proWrap.thistract = tract;
      proWrap.chargeRuleWrapper = chargeRules;
      proWrap.countryListTract = countryList;
      proWrap.stateUsaTract = stateUsa;
      proWrap.stateMexTract = stateMex;
      proWrap.stateCanTract = stateCan;
      proWrap.serviceName = srv.description;
      proWrap.serviceProductCode = srv.product.productType != null
        ? srv.product.productType
        : '';
      Date commitedThru = srv.commitmentEndDate != null
        ? srv.commitmentEndDate.date()
        : null;
      if (null != commitedThru) {
        proWrap.committedThru = TractSFDC_Util.changeDateFormat(
          String.valueOf(commitedThru)
        );
      }
      if (
        srv.currentAgreementService != null &&
        srv.currentAgreementService.endAction != null
      ) {
        proWrap.renewAction = TractSFDC_Util.convertToCamelCase(
          srv.currentAgreementService.endAction.name(),
          '_'
        );
      } else {
        proWrap.renewAction = '';
      }
      proWrap.statusDate = TractSFDC_Util.changeDateFormat(
        String.valueOf(
          srv.status.name() == 'DEACTIVATED'
            ? srv.endDate.date()
            : srv.startDate.date()
        )
      );
      proWrap.status = srv.status.name();
      proWrap.checkTrailService = srv.status.name() == 'TRIAL' ? true : false;
      proWrap.checkDeactivateService = srv.status.name() == 'ACTIVE'
        ? true
        : false;
      proWrap.checkSuspendService = srv.status.name() == 'SUSPENDED'
        ? true
        : false;
      proWrap.serviceEid = srv.id;
      proWrap.servicProducteName = srv.product.name;
      proWrap.checkProductEid = srv.product.id;
      proWrap.Quantity = srv.quantity;
      proWrap.checkParentServiceEId = srv.product.productType == 'add-on'
        ? srv.parentService.id
        : '';
      proWrap.serviceResourceNumber = srv.serviceResources != null
        ? srv.serviceResources.size()
        : null;
      Decimal serviceAmount = srv.amount;
      if (productMap.containsKey(srv.product.name)) {
        Product2 inst = productMap.get(srv.product.name);
        if (inst.maxServiceResources__c > inst.minServiceResources__c) {
          proWrap.canAddServiceResource = true;
        } else {
          proWrap.canAddServiceResource = false;
        }
        proWrap.serialized = inst.Serialized__c;
        proWrap.checkRuleOverrideValue = inst.RuleOverride__c;
      }
      proWrap.servicePrice = TractSFDC_Util.setBalanceCurrencyType(
        String.valueOf(serviceAmount),
        tractBillingAccount.accountCurrency
      );
      proWrap.currencyType = tractBillingAccount.accountCurrency;
      //proWrap.canAddServiceResource = true;
      proWrap.childElements = new List<ProductServiceWrapper>();
      if (servicesIDvsResoucesMap.containsKey(proWrap.serviceEid)) {
        proWrap.checkChildElement = true;
        for (
          RestAPI2Domain.GTVAPIServiceResource service : servicesIDvsResoucesMap.get(
            proWrap.serviceEid
          )
        ) {
          ProductServiceWrapper proWrap2 = new ProductServiceWrapper();
          proWrap2.serviceName = service.identifier;
          proWrap2.serviceEid = service.id;
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

  public static list<ProductServiceWrapper> mapserviceResourcesByServiceEid(
    List<RestAPI2Domain.GTVAPIServiceResource> responseServiceResourceMap,
    ProductServiceWrapper proWrap
  ) {
    list<ProductServiceWrapper> childElements = new List<ProductServiceWrapper>();
    for (
      RestAPI2Domain.GTVAPIServiceResource service : responseServiceResourceMap
    ) {
      ProductServiceWrapper proWrap2 = new ProductServiceWrapper();
      proWrap2.serviceName = service.identifier;
      proWrap2.serviceEid = service.id;
      proWrap2.checkServiceResource = true;
      proWrap2.statusDate = proWrap.statusDate;
      proWrap2.checkDeactivateService = proWrap.checkDeactivateService;
      proWrap2.checkSuspendService = proWrap.checkSuspendService;
      proWrap2.status = proWrap.status;
      childElements.add(proWrap2);
    }
    return childElements;
  }
  /**
   * Parse the queried usage Events for billing Account
   */
  public static ActivityEventsWrapper parseUsageEvents(
    List<RestAPI2Domain.GTVAPIUsageEvent> tractUsageEventsList,
    String currencyType
  ) {
    ActivityEventsWrapper eventWrapperObj = new ActivityEventsWrapper();
    if (null != tractUsageEventsList && !tractUsageEventsList.isEmpty()) {
      list<ActivityUsagesWrapper> sfdcUsageEventsList = new List<ActivityUsagesWrapper>();
      for (
        RestAPI2Domain.GTVAPIUsageEvent tractUsageEvent : tractUsageEventsList
      ) {
        ActivityUsagesWrapper sfdcUsageEvents = new ActivityUsagesWrapper();
        sfdcUsageEvents.eventTime = tractUsageEvent.startTime;
        sfdcUsageEvents.serviceIdentifier = tractUsageEvent.serviceResourceIdentifier;
        sfdcUsageEvents.referenceID = tractUsageEvent.referenceId;
        sfdcUsageEvents.sequenceID = tractUsageEvent.sequenceId;
        sfdcUsageEvents.description = tractUsageEvent.description;
        sfdcUsageEvents.amount = TractSFDC_Util.setBalanceCurrencyType(
          String.valueOf(tractUsageEvent.usageAmount),
          currencyType
        );
        sfdcUsageEvents.totalCharge = String.valueOf(
          tractUsageEvent.totalCharge
        );
        sfdcUsageEvents.unitOfMeasure = tractUsageEvent.usageUom.name();
        sfdcUsageEventsList.add(sfdcUsageEvents);
      }
      eventWrapperObj.getevents = sfdcUsageEventsList;
    }
    return eventWrapperObj;
  }

  /**
   * Parse the queried Bill Cycle
   */
  public static list<TRACT_Bill_Cycle__c> parseBillCycles(
    list<RestAPI2Domain.GTVAPIBillCycle> tractBillCycleList
  ) {
    list<TRACT_Bill_Cycle__c> listOfBillCycles = new List<TRACT_Bill_Cycle__c>();
    if (null != tractBillCycleList) {
      for (RestAPI2Domain.GTVAPIBillCycle billCycle : tractBillCycleList) {
        if (billCycle.currencyCode != null) {
          TRACT_Bill_Cycle__c billCycleObj = new TRACT_Bill_Cycle__c();
          billCycleObj.Eid__c = billCycle.id;
          billCycleObj.Bill_Cycle_Type__c = billCycle.billCycleType;
          billCycleObj.Name = billCycle.name;
          billCycleObj.TRACT_Bill_Cycle_Currency_Type__c = billCycle.currencyCode.name();
          if (billCycle.billingAccountCategory != null) {
            billCycleObj.TRACT3__Billing_Account_Category_Eid__c = billCycle.billingAccountCategory.id;
          }
          listOfBillCycles.add(billCycleObj);
        }
      }
    }
    return listOfBillCycles;
  }
  public static list<ScheduleChargesWapper> mapServiceScheduleCharges(
    RestAPI2Domain.GTVAPIOrderItem thisOrderItem
  ) {
    list<ScheduleChargesWapper> chargeList = new List<ScheduleChargesWapper>();
    for (
      RestAPI2Domain.GTVAPIOrderItemPrice prices : thisOrderItem.orderItemPrices
    ) {
      if (prices.orderItemPriceType == 'one-time') {
      }
      if (
        prices.scheduledCharges != null && !prices.scheduledCharges.isEmpty()
      ) {
        for (
          RestAPI2Domain.GTVAPIServicePriceChargeRef charges : prices.scheduledCharges
        ) {
          ScheduleChargesWapper ch = new ScheduleChargesWapper();
          ch.amount = TractSFDC_Util.setBalanceCurrencyType(
            String.valueOf(charges.amount),
            prices.currencyCode.name()
          );
          ch.chargeDate = date.valueOf(charges.charge_date);
          ch.chargeType = charges.price_charge_type;
          ch.description = charges.description;
          ch.invoiced = charges.invoiced ? 'Yes' : 'No';
          ch.status = charges.status;
          chargeList.add(ch);
        }
        break;
      }
    }
    return chargeList;
  }
  public static DiscountCodeWrapper addDiscountCode(
    RestAPI2Domain.GTVAPIDiscount discountServiceResponseMap
  ) {
    DiscountCodeWrapper codeWrap = new DiscountCodeWrapper();
    codeWrap.name = discountServiceResponseMap.name;
    codeWrap.type = discountServiceResponseMap.discountType.name();
    codeWrap.amount = TractSFDC_Util.setBalanceCurrencyType(
      String.valueOf(discountServiceResponseMap.amount),
      discountServiceResponseMap.currencyCode.name()
    );
    codeWrap.duration = discountServiceResponseMap.duration;
    codeWrap.chargeCategory = discountServiceResponseMap.discountCategory.name;
    return codeWrap;
  }
  public static ServiceDetailWrapper mapServiceDetails(
    List<RestAPI2Domain.GTVAPIOrderItem> responseOrderItemMap
  ) {
    RestAPI2Domain.GTVAPIOrderItem orderItem = responseOrderItemMap[0];
    ServiceDetailWrapper servDetail = new ServiceDetailWrapper();
    list<AddressWrapper> addressList = new List<AddressWrapper>();
    list<OneTimePricesWrapper> oneTimeList = new List<OneTimePricesWrapper>();
    list<ProductUsesWrapper> usageRuleList = new List<ProductUsesWrapper>();
    list<ScheduleChargesWapper> chargeList = new List<ScheduleChargesWapper>();
    list<ServicePricesWrapper> servicePricesList = new List<ServicePricesWrapper>();
    servDetail.productName = orderItem.product.name;
    servDetail.priceListName = orderItem.priceList.name;
    servDetail.prepaidBalance = orderItem.consumedPrepaidBalance;
    for (
      RestAPI2Domain.GTVAPIOrderItemPrice price : orderItem.orderItemPrices
    ) {
      if (price.orderItemPriceType == 'recurring') {
        ServicePricesWrapper priceSample = new ServicePricesWrapper();
        priceSample.validFrom = Date.valueOf(orderItem.requestedEffectiveDate);
        priceSample.recurrence = TractSFDC_Util.convertToCamelCase(
          price.productPrice.recurrencePeriod,
          '_'
        );
        if(price.category!=Null){
        priceSample.priceCategory = price.category.name;
        }
        priceSample.InvoiceQuantity = orderItem.quantity;
        priceSample.bill = price.billInAdvance ? 'In advance' : 'In arrears';
        priceSample.proration = price.prorateOnCancel ? 'On cancel' : 'None';
        priceSample.price = TractSFDC_Util.setBalanceCurrencyType(
          String.valueOf(price.orderItemPriceRanges[0].price),
          price.currencyCode.name()
        );
        priceSample.amount = TractSFDC_Util.setBalanceCurrencyType(
          String.valueOf(price.amount),
          price.currencyCode.name()
        );
        servicePricesList.add(priceSample);
      }
      if (price.orderItemPriceType == 'one-time') {
        OneTimePricesWrapper priceSample = new OneTimePricesWrapper();
        priceSample.priceCategory = price.category.name;
        priceSample.overridden = price.priceOverride ? 'Yes' : 'No';
        priceSample.price = TractSFDC_Util.setBalanceCurrencyType(
          String.valueOf(price.orderItemPriceRanges[0].price),
          price.currencyCode.name()
        );
        oneTimeList.add(priceSample);
      }
      if (price.scheduledCharges != null && !price.scheduledCharges.isEmpty()) {
        for (
          RestAPI2Domain.GTVAPIServicePriceChargeRef charges : price.scheduledCharges
        ) {
          ScheduleChargesWapper ch = new ScheduleChargesWapper();
          ch.amount = TractSFDC_Util.setBalanceCurrencyType(
            String.valueOf(charges.amount),
            price.currencyCode.name()
          );
          ch.chargeDate = date.valueOf(charges.charge_date);
          ch.chargeType = charges.price_charge_type;
          ch.description = charges.description;
          ch.invoiced = charges.invoiced ? 'Yes' : 'No';
          ch.status = charges.status;
          chargeList.add(ch);
        }
      }
    }
    servDetail.servicePricesInf = servicePricesList;
    servDetail.scheduleChargeInf = chargeList;
    servDetail.oneTimePricesInf = oneTimeList;
    return servDetail;
  }
  /**
   * Parse the queried Billing Account Category
   */
  public static List<TRACTBillingAccountCategory__c> parseBillingAccountCategory(
    List<RestAPI2Domain.GTVAPIBillingAccountCategory> tractBillingAccountCategoryList
  ) {
    List<TRACTBillingAccountCategory__c> bacSFDCList = new List<TRACTBillingAccountCategory__c>();
    for (
      RestAPI2Domain.GTVAPIBillingAccountCategory billingAccountCategory : tractBillingAccountCategoryList
    ) {
      TRACTBillingAccountCategory__c tractBac = new TRACTBillingAccountCategory__c();
      tractBac.eid__c = billingAccountCategory.id;
      tractBac.description__c = billingAccountCategory.description;
      tractBac.status__c = billingAccountCategory.status.name();
      tractBac.Name = billingAccountCategory.Name;
      tractBac.type_x__c = billingAccountCategory.Name;
      bacSFDCList.add(tractBac);
    }
    return bacSFDCList;
  }
  /**
   * Parse the queried Order Custom Fields
   */
  public static list<Tract_Order_Custom_Field__c> parseOrderCustomFields(
    List<RestAPI2Domain.GTVAPIOrderCustomField> tractOrderCustomFieldsList
  ) {
    list<Tract_Order_Custom_Field__c> orderCustomFieldList = new List<Tract_Order_Custom_Field__c>();
    for (
      RestAPI2Domain.GTVAPIOrderCustomField orderCustomField : tractOrderCustomFieldsList
    ) {
      Tract_Order_Custom_Field__c torder = new Tract_Order_Custom_Field__c();
      torder.eid__c = orderCustomField.id;
      torder.Name = orderCustomField.name;
      torder.ValidationType__c = orderCustomField.fieldValidationType;
      torder.orderCustomFieldType__c = orderCustomField.fieldType;
      if (
        orderCustomField.fieldType == 'LIST' &&
        orderCustomField.references != null &&
        orderCustomField.references.size() > 0
      ) {
        for (
          RestAPI2Domain.GTVAPICustomFieldValueReference refrence : orderCustomField.references
        ) {
          if (torder.Store_Order_List_Value__c == null) {
            torder.Store_Order_List_Value__c = refrence.value;
          } else
            torder.Store_Order_List_Value__c += ',' + refrence.value;
        }
      }
      orderCustomFieldList.add(torder);
    }
    return orderCustomFieldList;
  }
  public static list<AccountCustomFieldWrapper> parseAccountCustomFields(
    List<RestAPI2Domain.GTVAPIBillingAccountCustomField> tractAccountCustomFieldsList,
    Map<String, String> accountCustomFieldValuesMap
  ) {
    list<AccountCustomFieldWrapper> listOfAccountCustomField = new List<AccountCustomFieldWrapper>();
    for (
      RestAPI2Domain.GTVAPIBillingAccountCustomField custFieldObj : tractAccountCustomFieldsList
    ) {
      if (!accountCustomFieldValuesMap.containsKey(custFieldObj.id)) {
        AccountCustomFieldWrapper wrapInstance = new AccountCustomFieldWrapper();
        wrapInstance.Name = custFieldObj.Name;
        wrapInstance.Eid = custFieldObj.id;
        wrapInstance.fieldValidationType = custFieldObj.fieldValidationType;
        if (custFieldObj.fieldType == 'LIST') {
          wrapInstance.checkListtype = true;
          list<SelectOption> storeListTypeValues = new List<SelectOption>();
          storeListTypeValues.add(new SelectOption('', 'Choose One'));
          for (
            RestAPI2Domain.GTVAPICustomFieldValueReference refrence : custFieldObj.references
          ) {
            storeListTypeValues.add(
              new SelectOption(refrence.value, refrence.value)
            );
          }
          wrapInstance.storeListTypeValues = new List<SelectOption>();
          wrapInstance.storeListTypeValues.addAll(storeListTypeValues);
        }

        listOfAccountCustomField.add(wrapInstance);
      }
    }
    return listOfAccountCustomField;
  }
  public static list<Price_List__c> parsePriceLists(
    List<RestAPI2Domain.GTVAPIPriceList> tractPriceList
  ) {
    list<Price_List__c> priceLists = new List<Price_List__c>();
    for (RestAPI2Domain.GTVAPIPriceList priceListInstance : tractPriceList) {
      Price_List__c priceList = new Price_List__c();
      priceList.Name = priceListInstance.Name;
      priceList.eid__c = priceListInstance.id;
      priceLists.add(priceList);
    }
    return priceLists;
  }
  public static InvoiceDetailWrapper mapInvoiceData(
    List<RestAPI2Domain.GTVAPIInvoice> tractInvoiceList,
    InvoiceWrapper wrapperObj,
    Map<String, String> invoiceItemServiceMap
  ) {
    RestAPI2Domain.GTVAPIInvoice currentInvoice = tractInvoiceList[0];
    InvoiceDetailWrapper detail = new InvoiceDetailWrapper();
    list<InvoiceItemWrapper> itemWrapList = new List<InvoiceItemWrapper>();
    detail.InvoiceType = currentInvoice.invoiceType;
    detail.DueDate = currentInvoice.dueDate;
    detail.OccuredOn = currentInvoice.occurredOn;
    detail.BillPeriod =
      String.valueOf(Date.valueOf(detail.OccuredOn)) +
      '-' +
      String.valueOf(detail.DueDate);
    if (currentInvoice.billCycle != null) {
      detail.BillCycle = currentInvoice.billCycle.name;
      detail.isBillCycle = true;
    } else {
      detail.isBillCycle = false;
    }
    if (currentInvoice.billBatch != null) {
      detail.BillBatch = currentInvoice.billBatch.name;
      detail.isBillBatch = true;
    } else {
      detail.isBillBatch = false;
    }
    if (currentInvoice.disputed) {
      detail.disputed = 'Yes';
    } else {
      detail.disputed = 'No';
    }
    detail.serviceCharges = TractSFDC_Util.setBalanceCurrencyType(
      String.valueOf(currentInvoice.billingStatement.serviceCharges),
      wrapperObj.currencyType
    );
    detail.serviceActivityCharge = TractSFDC_Util.setBalanceCurrencyType(
      String.valueOf(currentInvoice.billingStatement.activityCharges),
      wrapperObj.currencyType
    );
    detail.otherCharge = TractSFDC_Util.setBalanceCurrencyType(
      String.valueOf(currentInvoice.billingStatement.otherChargesAndCredits),
      wrapperObj.currencyType
    );
    detail.taxFees = TractSFDC_Util.setBalanceCurrencyType(
      String.valueOf(currentInvoice.billingStatement.taxesAndFees),
      wrapperObj.currencyType
    );
    detail.totalCharge = TractSFDC_Util.setBalanceCurrencyType(
      String.valueOf(currentInvoice.billingStatement.totalCurrentCharges),
      wrapperObj.currencyType
    );
    for (
      RestAPI2Domain.GTVAPIInvoiceItem itemWrap : currentInvoice.invoiceItems
    ) {
      InvoiceItemWrapper wrap = new InvoiceItemWrapper();
      wrap.Type = 'Product Sale';
      wrap.description = itemWrap.description;
      wrap.charges = TractSFDC_Util.setBalanceCurrencyType(
        String.valueOf(itemWrap.invoiceItemCharges[0].amount),
        wrapperObj.currencyType
      );
      wrap.totalAmount = TractSFDC_Util.setBalanceCurrencyType(
        String.valueOf(itemWrap.totalAmount),
        wrapperObj.currencyType
      );
      if (itemWrap.service != null) {
        wrap.serviceName = invoiceItemServiceMap.get(itemWrap.service.id);
      }
      itemWrapList.add(wrap);
    }
    detail.invoiceItems = itemWrapList;
    return detail;
  }
  public static list<AddressWrapper> mapServiceAddress(
    RestAPI2Domain.GTVAPIService serviceResponseMap
  ) {
    list<AddressWrapper> addressList = new List<AddressWrapper>();
    for (
      RestAPI2Domain.GTVAPIPostalAddress address : serviceResponseMap.addresses
    ) {
      AddressWrapper addressWrap = new AddressWrapper();
      addressWrap.type = address.address_type.name();
      addressWrap.city = address.city;
      addressWrap.country = address.country;
      addressWrap.line1 = address.line1;
      addressWrap.line2 = address.line2;
      addressWrap.state = address.region_or_state;
      addressWrap.zip = address.postal_code;
      addressWrap.purpose = address.purpose.name();
      addressList.add(addressWrap);
    }
    return addressList;
  }
  public static list<SelectOption> parseAccountCustomFieldsForSYnc(
    List<RestAPI2Domain.GTVAPIBillingAccountCustomField> tractAccountCustomFieldsList
  ) {
    List<SelectOption> options = new List<SelectOption>();
    for (
      RestAPI2Domain.GTVAPIBillingAccountCustomField theCus : tractAccountCustomFieldsList
    ) {
      if (
        theCus.customFieldType == 'billing-account' &&
        theCus.fieldType == 'TEXT_FIELD' &&
        theCus.fieldValidationType == 'TEXT'
      ) {
        options.add(new SelectOption(theCus.id, theCus.name));
      }
    }
    return options;
  }
  public static Map<String, String> mapAccountCustomFieldValues(
    List<RestAPI2Domain.GTVAPIBillingAccountCustomFieldVal> valueResponseMap
  ) {
    Map<String, String> accountCustomFieldValuesMap = new Map<String, String>();
    for (
      RestAPI2Domain.GTVAPIBillingAccountCustomFieldVal sample : valueResponseMap
    ) {
      accountCustomFieldValuesMap.put(sample.customField.id, sample.value);
    }
    return accountCustomFieldValuesMap;
  }

  public static list<Payment_Term__c> parsePaymentTerms(
    List<RestAPI2Domain.GTVAPIPaymentTerm> tractPaymentTerms
  ) {
    list<Payment_Term__c> paymentTerms = new List<Payment_Term__c>();
    for (
      RestAPI2Domain.GTVAPIPaymentTerm PaymentTermsInstance : tractPaymentTerms
    ) {
      Payment_Term__c term = new Payment_Term__c();
      term.name = PaymentTermsInstance.name;
      term.eid__c = PaymentTermsInstance.id;
      paymentTerms.add(term);
    }
    return paymentTerms;
  }
  public static list<ProductAgreementWrapper> parseAgreements(
    List<RestAPI2Domain.GTVAPIAgreement> tractAgreements
  ) {
    list<ProductAgreementWrapper> agreementWrapperList = new List<ProductAgreementWrapper>();
    for (RestAPI2Domain.GTVAPIAgreement ag : tractAgreements) {
      if (ag.status == 'ACTIVE') {
        ProductAgreementWrapper agreementObj = new ProductAgreementWrapper();
        agreementObj.Name = ag.name;
        agreementObj.eid = ag.id;
        agreementObj.status = ag.status;
        agreementObj.agreementPeriod = ag.agreementPeriod;
        if (ag.agreementPeriod == 1) {
          agreementObj.agreementPeriodType = ag.agreementPeriodType.name();
        } else {
          agreementObj.agreementPeriodType =
            ag.agreementPeriodType.name() + 's';
        }
        agreementObj.endAction = ag.endAction.name();
        if (ag.adjustmentCategory != null) {
          agreementObj.adjustmentCategory = ag.adjustmentCategory.name;
        }
        if (null != ag.terminationFeeCurrencyCode) {
          agreementObj.currencyType = ag.terminationFeeCurrencyCode.name();
        } else if (null != ag.minimumAmountCurrencyType) {
          agreementObj.currencyType = ag.minimumAmountCurrencyType.name();
        } else if (null != ag.minimumAmountCurrencyType) {
          agreementObj.currencyType = ag.minimumAmountCurrencyType.name();
        } else if (null != ag.maxTerminationFeeCurrencyCode) {
          agreementObj.currencyType = ag.maxTerminationFeeCurrencyCode.name();
        }

        if (ag.terminationFlatCharge != null) {
          agreementObj.terminationFlatCharge = TractSFDC_Util.setBalanceCurrencyType(
            String.valueof(ag.terminationFlatCharge),
            agreementObj.currencyType
          );
        } else if (ag.terminationPercentageCharge != null) {
          agreementObj.terminationFlatCharge =
            String.valueof((ag.terminationPercentageCharge * 100).setScale(2)) +
            '%';
        }
        agreementWrapperList.add(agreementObj);
      }
    }
    return agreementWrapperList;
  }

  public static void saveProducts(
    List<RestAPI2Domain.GTVAPIProduct> products,
    list<Price_List__c> listOfPriceList
  ) {
    Price_List__c priceList = listOfPriceList[0];
    //Prepare Different List for Products by Currency Types
    Map<String, PriceBook2> currencyVsPriceBook = new Map<String, PriceBook2>();
    list<PriceBook2> priceBookListToInsert = new List<PriceBook2>();
    //Selec all pricebooks
    Pricebook2[] priceBooks = [
      SELECT ID, Name, CurrencyType__c
      FROM Pricebook2
      LIMIT 50000
    ]; // where Name =: 'TRACT ' + currencyType + ' Price Book'];
    //Pricebook2[] priceBookList = new List<Pricebook2>();
    for (Pricebook2 priceBook : priceBooks) {
      currencyVsPriceBook.put(priceBook.CurrencyType__c, priceBook);
    }
    Pricebook2 standardPB = new Pricebook2();
    if (!Test.isRunningTest())
      standardPB = [
        SELECT ID, Name
        FROM Pricebook2
        WHERE Name = :'Standard Price Book'
        LIMIT 50000
      ];
    else
      standardPB.Id = Test.getStandardPricebookId();
    Product2[] productList = new List<Product2>();

    //Get Tract Product stored in SFDC
    Product2[] sfdcProducts = [
      SELECT id, Name, eid__c, PriceLists__c, Price_Information__c
      FROM Product2
      WHERE eid__c != NULL
      LIMIT 50000
    ];
    Map<String, Product2> eidProductMap = new Map<String, Product2>();
    for (Product2 tractSfdcProduct : sfdcProducts) {
      eidProductMap.put(tractSfdcProduct.eid__c, tractSfdcProduct);
    }
    Map<String, PricebookEntry> priceBookEntryMap = new Map<String, PricebookEntry>();
    PricebookEntry[] tractPiceBookEntryList = [
      SELECT id, Pricebook2Id, Product2Id, unitPrice, useStandardPrice
      FROM PricebookEntry
      LIMIT 50000
    ];
    PricebookEntry[] standardPriceBookEntryList = new List<PricebookEntry>();
    //Prepare Map of PriceBookEntry, Use PriceBookId and ProductId as unique key
    for (PricebookEntry pricebookEntry : tractPiceBookEntryList) {
      String key =
        String.valueOf(pricebookEntry.Pricebook2Id) +
        String.valueOf(pricebookEntry.Product2Id);
      priceBookEntryMap.put(key, pricebookEntry);
    }
    Map<String, Set<Product2>> currencyProductsMap = new Map<String, Set<Product2>>();
    //Create Map of Tract ProductPrice and Tract Price Range.
    for (RestAPI2Domain.GTVAPIProduct product : products) {
      Product2 currentProduct = eidProductMap.get(product.id);
      if (currentProduct == null) {
        currentProduct = new Product2();
        currentProduct.eid__c = product.id;
        //map priceList eid and Name
        currentProduct.PriceLists__c = priceList.Name + ':' + priceList.eid__c;
        eidProductMap.put(product.id, currentProduct);
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
      List<RestAPI2Domain.GTVAPIProductPrice> productPrices = product.prices;
      String productPriceInformation = '';
      if (productPrices != null) {
        ProductPriceWrapper sfdcProductPrice;
        list<ProductPriceWrapper> productPriceWrapperList = new List<ProductPriceWrapper>();
        PriceBook2 currencyPriceBookToInsert;
        for (RestAPI2Domain.GTVAPIProductPrice productPrice : productPrices) {
          System.debug('productPrice:::::' + productPrice);
          sfdcProductPrice = new ProductPriceWrapper();
          sfdcProductPrice.eid = productPrice.id;
          sfdcProductPrice.currencyType = productPrice.currencyCode.name();
          if (!currencyVsPriceBook.containsKey(sfdcProductPrice.currencyType)) {
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
          if (currencyProductsMap.containsKey(sfdcProductPrice.currencyType)) {
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
            currencyProductsMap.put(sfdcProductPrice.currencyType, productSet);
          }
          sfdcProductPrice.fromDate = TractSFDC_Util.productPriceFormat(
            productPrice.validFrom
          );
          sfdcProductPrice.thruDate = productPrice.thruDate;
          sfdcProductPrice.scheduledCharges = productPrice.allowScheduledCharges ==
            null
            ? false
            : productPrice.allowScheduledCharges;
          sfdcProductPrice.priceOverride = productPrice.priceOverride == null
            ? true
            : productPrice.priceOverride;
          sfdcProductPrice.priceType = productPrice.priceType;
          sfdcProductPrice.recurrencePeriod = TractSFDC_Util.convertToCamelCase(
            productPrice.recurrencePeriod,
            '_'
          );
          sfdcProductPrice.priceListEid = priceList.eid__c;
          if (productPrice.priceRanges != null) {
            sfdcProductPrice.priceRangesList = createPriceRangeList(
              productPrice.priceRanges
            );
          }
          if (productPrice.priceCategory != null) {
            sfdcProductPrice.priceCategory = productPrice.priceCategory.name;
            sfdcProductPrice.priceCategoryId = productPrice.priceCategory.Id;
          }
          if (productPrice.priceGroup != null) {
            sfdcProductPrice.priceGroupId = productPrice.priceGroup.Id;
          }
          if (productPrice.billInAdvanceConfiguration != null) {
            sfdcProductPrice.billInAdvanceAmount = productPrice.billInAdvanceConfiguration.amount;
            sfdcProductPrice.billInAdvanceUnit = productPrice.billInAdvanceConfiguration.period;
          }
          sfdcProductPrice.proratedOnOrderNoCharge = productPrice.proratedOnOrderNoCharge;
          sfdcProductPrice.proratedOnOrder = productPrice.prorateOnOrder;
          sfdcProductPrice.proratedOnCancel = productPrice.prorateOnCancel;
          sfdcProductPrice.recurringPaymentRequired = productPrice.recurringPaymentRequired;
          sfdcProductPrice.paymentOnPurchaseRequired = productPrice.paymentOnPurchaseRequired;
          sfdcProductPrice.billInAdvance = productPrice.billInAdvance;
          productPriceWrapperList.add(sfdcProductPrice);
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
        currentProduct.TRACT3__Price_Information__c = productPriceInformation;
      }
      /* Adding Product Category */
      ProductCategoryWrapper catWrap = new ProductCategoryWrapper();
      catWrap.categoryId = product.productCategory.id;
      catWrap.Name = product.productCategory.name;
      currentProduct.Gotransverse_Product_Category__c = JSON.serialize(catWrap);

      productList.add(currentProduct);
    }
    if (
      TRACTAPIUtil.checkFieldLevelSecurity(
        'Product2',
        'TRACT3__eid__c,TRACT3__PriceLists__c,TRACT3__Price_Information__c',
        'Upsert'
      )
    ) {
      upsert productList;
    }
    if (priceBookListToInsert.size() > 0) {
      if (
        TRACTAPIUtil.checkFieldLevelSecurity(
          'Pricebook2',
          'Description,IsActive,Name,TRACT3__currencyType__c',
          'Create'
        )
      ) {
        insert priceBookListToInsert;
      }
    }
    map<String, Pricebookentry> productIdVsPricebookentry = new Map<String, Pricebookentry>();
    for (String currencyType : currencyProductsMap.keySet()) {
      Id currencyPricebookId = currencyVsPriceBook.get(currencyType).Id;
      Set<Product2> currencyProducts = currencyProductsMap.get(currencyType);
      for (Product2 product2 : currencyProducts) {
        if (!productIdVsPricebookentry.containsKey(product2.id)) {
          PricebookEntry standardPBE = priceBookEntryMap.get(
            String.valueOf(standardPB.ID) + String.valueOf(product2.Id)
          );
          productIdVsPricebookentry.put(product2.id, standardPBE);
          if (standardPBE == null) {
            standardPBE = new PricebookEntry(
              Pricebook2Id = standardPB.ID,
              Product2Id = product2.Id,
              IsActive = true,
              UnitPrice = 0.0,
              UseStandardPrice = false
            );
            productIdVsPricebookentry.put(product2.id, standardPBE);
            standardPriceBookEntryList.add(standardPBE);
          }
        }
        PricebookEntry pbe = priceBookEntryMap.get(
          String.valueOf(currencyPricebookId) + String.valueOf(product2.Id)
        );
        if (pbe == null) {
          pbe = new PricebookEntry(
            Pricebook2Id = currencyPricebookId,
            Product2Id = product2.Id,
            IsActive = true,
            UnitPrice = 0.0,
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

  /*
   *Method for mapping of Product fields with the variable of GTVAPIProduct class.
   */
  private static void updateProductAttribute(
    Product2 sfdcProduct,
    RestAPI2Domain.GTVAPIProduct tractProduct
  ) {
    sfdcProduct.Name = tractProduct.name;
    sfdcProduct.Short_Desc__c = tractProduct.shortDescription;
    sfdcProduct.Description = tractProduct.description;
    sfdcProduct.IsActive = true;
    sfdcProduct.Family = 'TRACT';
    if (tractProduct.productType == 'GENERAL') {
      sfdcProduct.ProductCode = 'ONE-TIME';
    } else if (tractProduct.productType == 'add-on') {
      sfdcProduct.ProductCode = 'ADD-ON';
    } else if (tractProduct.productType == 'customer-subscription') {
      sfdcProduct.ProductCode = 'SUBSCRIPTION';
    } else {
      sfdcProduct.ProductCode = tractProduct.productType;
    }
    sfdcProduct.eid__c = tractProduct.id;
    sfdcProduct.Requires_Agreement__c = tractProduct.requiresAgreement;
    sfdcProduct.maxServiceResources__c = tractProduct.maxServiceResources;
    sfdcProduct.minServiceResources__c = tractProduct.minServiceResources;
    if (null != tractProduct.ruleOverride) {
      sfdcProduct.RuleOverride__c = tractProduct.ruleOverride;
    }
    if (null != tractProduct.ruleType) {
      sfdcProduct.RuleType__c = tractProduct.ruleType.name();
    }
    if (tractProduct.serviceResourceCategory != null) {
      sfdcProduct.Service_Resource_Category__c = tractProduct.serviceResourceCategory.name;
      sfdcProduct.SRC_eid__c = tractProduct.serviceResourceCategory.id;
    }
    sfdcProduct.Serialized__c = tractProduct.serialized;
  }

  private static list<ProductPriceRangeWrapper> createPriceRangeList(
    List<RestAPI2Domain.GTVAPIProductPriceRange> priceRangeList
  ) {
    list<ProductPriceRangeWrapper> priceRangeWrapperList = new List<ProductPriceRangeWrapper>();
    if (priceRangeList != null && !priceRangeList.isEmpty()) {
      ProductPriceRangeWrapper sfdcPriceRange;
      for (RestAPI2Domain.GTVAPIProductPriceRange priceRange : priceRangeList) {
        sfdcPriceRange = new ProductPriceRangeWrapper();
        sfdcPriceRange.eid = priceRange.id;
        sfdcPriceRange.currencyType = priceRange.currencyCode.Name();
        sfdcPriceRange.quantityEndRange = priceRange.quantityEndRange;
        sfdcPriceRange.level = priceRange.level;
        sfdcPriceRange.price = priceRange.price;
        sfdcPriceRange.quantityBeginRange = priceRange.quantityBeginRange;
        priceRangeWrapperList.add(sfdcPriceRange);
      }
    }
    return priceRangeWrapperList;
  }

  public static Product2AddWrapper mapDiscounts(
    Product2AddWrapper productWrapper,
    List<RestAPI2Domain.GTVAPIDiscountCode> valueResponseMap,
    string discountName
  ) {
    if (null != valueResponseMap && !valueResponseMap.isEmpty()) {
      for (RestAPI2Domain.GTVAPIDiscountCode code : valueResponseMap) {
        productWrapper.discountEid = code.id;
        productWrapper.discountName = discountName;
        break;
      }
    } else {
      productWrapper.errorMessage =
        discountName +
        ' is not applicable on this product' +
        '.';
    }
    return productWrapper;
  }
  public static ServiceResourceWrapper mapServiceResource(
    List<RestAPI2Domain.GTVAPIServiceResource> responseServiceResourceMap,
    String srId
  ) {
    ServiceResourceWrapper srWrapper = new ServiceResourceWrapper();
    if (
      null != responseServiceResourceMap &&
      !responseServiceResourceMap.isEmpty()
    ) {
      for (
        RestAPI2Domain.GTVAPIServiceResource resource : responseServiceResourceMap
      ) {
        if (resource.status.name() == 'AVAILABLE') {
          srWrapper.eid = resource.id;
          srWrapper.identifier = srId;
          srWrapper.errorMessage = 'NoError';
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
  public static list<String> mapProductRelation(
    List<RestAPI2Domain.GTVAPIProductRelation> responseRelationMap
  ) {
    list<string> listOfParentName = new List<string>();
    for (RestAPI2Domain.GTVAPIProductRelation relation : responseRelationMap) {
      if (relation.productRelationType.name() == 'PARENT') {
        listOfParentName.add(relation.product.name);
      }
    }
    return listOfParentName;
  }
  public static Set<String> mapProductRelationSelectService(
    List<RestAPI2Domain.GTVAPIProductRelation> responseRelationMap
  ) {
    Set<String> setOfParentId = new Set<String>();
    for (RestAPI2Domain.GTVAPIProductRelation relation : responseRelationMap) {
      if (relation.productRelationType.name() == 'PARENT') {
        setOfParentId.add(relation.product.id);
      }
    }
    return setOfParentId;
  }
  public static set<String> getRelatedChildProductNameList(
    List<RestAPI2Domain.GTVAPIProductRelation> responseRelationMap
  ) {
    set<String> setofRelatedProduct = new Set<String>();
    for (RestAPI2Domain.GTVAPIProductRelation relation : responseRelationMap) {
      if (relation.productRelationType.name() == 'CHILD') {
        setofRelatedProduct.add(relation.product.id);
      }
    }
    return setofRelatedProduct;
  }

  public static list<SelectOption> mapCreditAdjustmentReasons(
    List<RestAPI2Domain.GTVAPIAdjustmentReason> creditAdjustmentReasonResponse
  ) {
    list<SelectOption> creditadjustmentReasonList = new List<SelectOption>();
    creditadjustmentReasonList.add(new SelectOption('', 'Choose One'));
    for (
      RestAPI2Domain.GTVAPIAdjustmentReason adjustmentReasons : creditAdjustmentReasonResponse
    ) {
      creditadjustmentReasonList.add(
        new SelectOption(adjustmentReasons.id, adjustmentReasons.name)
      );
    }
    return creditadjustmentReasonList;
  }
  public static List<AccountCustomFieldValueWrapper> mapAccountCustomFieldsValue(
    List<RestAPI2Domain.GTVAPIBillingAccountCustomFieldVal> valueResponseMap
  ) {
    List<AccountCustomFieldValueWrapper> billingAccountCustomFieldValueWrapperList = new List<AccountCustomFieldValueWrapper>();
    for (
      RestAPI2Domain.GTVAPIBillingAccountCustomFieldVal customFieldVal : valueResponseMap
    ) {
      AccountCustomFieldValueWrapper customFieldWrapObj = new AccountCustomFieldValueWrapper();
      customFieldWrapObj.Value = customFieldVal.value;
      customFieldWrapObj.Name = customFieldVal.customField.name;
      billingAccountCustomFieldValueWrapperList.add(customFieldWrapObj);
    }
    return billingAccountCustomFieldValueWrapperList;
  }

  public static list<SelectOption> mapDebitAdjustmentReasons(
    List<RestAPI2Domain.GTVAPIAdjustmentReason> debitAdjustmentReasonResponse
  ) {
    list<SelectOption> debitadjustmentReasonList = new List<SelectOption>();
    debitadjustmentReasonList.add(new SelectOption('', 'Choose One'));
    for (
      RestAPI2Domain.GTVAPIAdjustmentReason adjustmentReasons : debitAdjustmentReasonResponse
    ) {
      debitadjustmentReasonList.add(
        new SelectOption(adjustmentReasons.id, adjustmentReasons.name)
      );
    }
    return debitadjustmentReasonList;
  }
  public static list<SelectOption> mapServiceDeactivationReasons(
    List<RestAPI2Domain.GTVAPIServiceDeactivationReason> serviceDeactivationReasonResponse
  ) {
    list<SelectOption> serviceDeactivationReasonList = new List<SelectOption>();
    serviceDeactivationReasonList.add(new SelectOption('', 'Choose One'));
    for (
      RestAPI2Domain.GTVAPIServiceDeactivationReason deactivationReason : serviceDeactivationReasonResponse
    ) {
      serviceDeactivationReasonList.add(
        new SelectOption(deactivationReason.id, deactivationReason.name)
      );
    }
    return serviceDeactivationReasonList;
  }
  public static list<SelectOption> mapServiceSuspentionReasons(
    List<RestAPI2Domain.GTVAPIServiceSuspensionReason> servicesSuspendReasonResponse
  ) {
    list<SelectOption> serviceSuspensionReasonList = new List<SelectOption>();
    serviceSuspensionReasonList.add(new SelectOption('', 'Choose One'));
    for (
      RestAPI2Domain.GTVAPIServiceSuspensionReason suspendReason : servicesSuspendReasonResponse
    ) {
      serviceSuspensionReasonList.add(
        new SelectOption(suspendReason.id, suspendReason.name)
      );
    }
    return serviceSuspensionReasonList;
  }
  public static list<DiscountCodeWrapper> mapDiscountCodeList(
    List<RestAPI2Domain.GTVAPIDiscountCode> gtvDiscounts
  ) {
    list<DiscountCodeWrapper> proDiscountWrapperList = new List<DiscountCodeWrapper>();
    for (RestAPI2Domain.GTVAPIDiscountCode proDiscountInstance : gtvDiscounts) {
      DiscountCodeWrapper proDiscountWrapper = new DiscountCodeWrapper();
      proDiscountWrapper.name = proDiscountInstance.name;
      proDiscountWrapper.status = (proDiscountInstance.status.name()
          .toLowerCase())
        .capitalize();
      proDiscountWrapper.description = proDiscountInstance.description;
      proDiscountWrapper.chargeCategory = proDiscountInstance.discountChargeCategory.name;
      if (null != proDiscountInstance.validFrom) {
        proDiscountWrapper.availableFrom = (proDiscountInstance.validFrom)
          .format('MM/dd/yyyy');
      }
      proDiscountWrapper.discount = proDiscountInstance.discount.id;
      proDiscountWrapperList.add(proDiscountWrapper);
    }
    return proDiscountWrapperList;
  }

  public static ChangeSubscriptionWrapper mapChangeService(
    RestAPI2Domain.GTVAPIChangeOrder chngeServiceResponsemap
  ) {
    ChangeSubscriptionWrapper subscriptionWrapper = new ChangeSubscriptionWrapper();
    list<String> productEidList = new List<String>();
    Map<String, List<ProductPriceWrapper>> productIdToProductPriceMap = new Map<String, List<ProductPriceWrapper>>();
    Map<String, List<ProductPriceRangeWrapper>> productPriceIdtoPriceRangesMap = new Map<String, List<ProductPriceRangeWrapper>>();
    map<String, String> productIdToEidMap = new Map<String, String>();
    List<SelectOption> newServiceNames = new List<SelectOption>();
    return subscriptionWrapper;
  }

  public static list<SelectOption> mapBillingAccountSuspensionReasons(
    List<RestAPI2Domain.GTVAPIBillingAccountSuspensionReason> billingAccountSuspensionReasonResponse
  ) {
    list<SelectOption> billingAccountSuspensionReasonList = new List<SelectOption>();
    billingAccountSuspensionReasonList.add(new SelectOption('', 'Choose One'));
    for (
      RestAPI2Domain.GTVAPIBillingAccountSuspensionReason suspensionReason : billingAccountSuspensionReasonResponse
    ) {
      billingAccountSuspensionReasonList.add(
        new SelectOption(suspensionReason.id, suspensionReason.name)
      );
    }
    return billingAccountSuspensionReasonList;
  }

  public static list<SelectOption> mapBillingAccountDeactivationReasons(
    List<RestAPI2Domain.GTVAPIBillingAccountDeactivationReason> billingAccountDeactivationReasonResponse
  ) {
    list<SelectOption> billingAccountDeactivationReasonList = new List<SelectOption>();
    billingAccountDeactivationReasonList.add(
      new SelectOption('', 'Choose One')
    );
    for (
      RestAPI2Domain.GTVAPIBillingAccountDeactivationReason deactivationReason : billingAccountDeactivationReasonResponse
    ) {
      billingAccountDeactivationReasonList.add(
        new SelectOption(deactivationReason.id, deactivationReason.name)
      );
    }
    return billingAccountDeactivationReasonList;
  }
  public static List<ProductUsesWrapper> mapServiceUsageRules(
    List<RestAPI2Domain.GTVAPIServiceUsageRule> usageRuleResponseMap
  ) {
    List<ProductUsesWrapper> listOfUsageRules = new List<ProductUsesWrapper>();
    map<String, String> specType = new Map<String, String>();
    specType.put('Choose One', 'Choose One');
    specType.put('EQUALS', '=');
    specType.put('NOT_EQUALS', '<>');
    specType.put('GREATER_THAN', '>');
    specType.put('GREATER_THAN_EQUALS', '>=');
    specType.put('LESS_THAN', '<');
    specType.put('LESS_THAN_EQUALS', '<=');
    specType.put('LOOKUP', 'Lookup');
    for (
      RestAPI2Domain.GTVAPIServiceUsageRule currentRule : usageRuleResponseMap
    ) {
      ProductUsesWrapper usageWrap = new ProductUsesWrapper();
      usageWrap.ChargeName = currentRule.Name;
      usageWrap.UsageRuleEid = currentRule.id;
      if (currentRule.spec.usageRuleSpecificationType == 'match-all') {
        usageWrap.Rule = 'Matches all';
      } else if (currentRule.spec.usageRuleSpecificationType == 'formula') {
        usageWrap.Rule =
          currentRule.spec.field_name.toLowerCase() +
          specType.get(currentRule.spec.operator) +
          currentRule.spec.field_value;
      } else if (currentRule.spec.usageRuleSpecificationType == 'global') {
        usageWrap.Rule = currentRule.spec.name;
      }
      usageWrap.ChargeType = 'MatchAll';
      if (currentRule.usageRate.usageRateType == 'flat') {
        usageWrap.Rate =
          String.valueOf(currentRule.usageRate.rate.setScale(2)) +
          ' per ' +
          currentRule.usageRate.uom.toLowerCase().capitalize();
      }
      if (currentRule.usageRate.usageRateType == 'table') {
        usageWrap.Rate = 'Table Rate ' + currentRule.usageRate.rateTable.name;
      }
      if (currentRule.usageRate.usageRateType == 'pass-through') {
        if (currentRule.usageRate.usageFieldName != null) {
          usageWrap.Rate =
            'Pass Through ' +
            currentRule.usageRate.usageFieldName.toLowerCase();
        } else {
          usageWrap.Rate = 'Rule Rating';
        }
        //usageWrap.Taper = String.valueOf(Decimal.valueOf(matchAll.limit_x).setScale(0)) + ' ' + matchAll.usageUom.toLowerCase().capitalize() + 's';
      }
      if (currentRule.allowanceType.name() == 'UNLIMITED') {
        usageWrap.Taper =
          'Unlimited' +
          ' ' +
          currentRule.usageUom.toLowerCase().capitalize();
      } else {
        usageWrap.Taper =
          String.valueOf(
            Decimal.valueOf(currentRule.allowanceAmount).setScale(0)
          ) +
          ' ' +
          currentRule.usageUom.toLowerCase().capitalize() +
          's';
      }
      usageWrap.Status = currentRule.status.name().toLowerCase().capitalize();
      listOfUsageRules.add(usageWrap);
    }
    return listOfUsageRules;
  }

  public static void mapBillingAccount(
    RestAPI2Domain.GTVAPIBillingAccount billingAccountResponse,
    list<Account> thisAccountList
  ) {
    list<Account> updateAccount = new List<Account>();
    Account thisAccount = thisAccountList[0];
    if (thisAccount != null) {
      if (string.isNotBlank(billingAccountResponse.currencyCode.name())) {
        thisAccount.Currency_Type__c = billingAccountResponse.currencyCode.name();
      } else {
        thisAccount.Currency_Type__c = 'USD';
      }
      thisAccount.Tract_Billing_Account__c = billingAccountResponse.accountNum;
      thisAccount.status__c = 'Moved';
      updateAccount.add(thisAccount);
      if (
        TRACTAPIUtil.checkFieldLevelSecurity(
          'Account',
          'status__c,Tract_Billing_Account__c',
          'Update'
        )
      ) {
        update updateAccount;
      }
    } else {
      thisAccount = new Account();
      thisAccount.Name = billingAccountResponse.responsibleParty.organizationName;
      if (string.isNotBlank(billingAccountResponse.currencyCode.name())) {
        thisAccount.Currency_Type__c = billingAccountResponse.currencyCode.name();
      } else {
        thisAccount.Currency_Type__c = 'USD';
      }
      thisAccount.Tract_Billing_Account__c = billingAccountResponse.accountNum;
      thisAccount.status__c = 'Moved';
      updateAccount.add(thisAccount);
      if (
        TRACTAPIUtil.checkFieldLevelSecurity(
          'Account',
          'name,status__c,Tract_Billing_Account__c,Currency_Type__c',
          'Create'
        )
      ) {
        insert updateAccount;
      }
    }
  }

  public static GTVSalesOrderDetailWrapper mapOrderItems(
    RestAPI2Domain.GTVAPIOrder orderResponse,
    String currencyType,
    Map<String, RestAPI2Domain.GTVAPIAgreement> mapOfOrderItemIdVSAgreement,
    Map<String, RestAPI2Domain.GTVAPIService> mapOfOrderItemIdVSParentService
  ) {
    GTVSalesOrderDetailWrapper salesOrderWrapper = new GTVSalesOrderDetailWrapper();
    list<GTVOrderItemWrapper> listOfOrderItemWrapper = new List<GTVOrderItemWrapper>();
    for (RestAPI2Domain.GTVAPIOrderItem orderItem : orderResponse.orderItems) {
      GTVOrderItemWrapper orderItemWrapper = new GTVOrderItemWrapper();
      orderItemWrapper.orderItem = true;
      orderItemWrapper.quantity = orderItem.quantity.intValue();
      orderItemWrapper.productName = orderItem.product.name;
      orderItemWrapper.orderItemUnitPrice = TractSFDC_Util.setBalanceCurrencyType(
        string.valueOf(orderItem.extended_price / orderItem.quantity),
        currencyType
      );
      orderItemWrapper.orderItemTotalPrice = TractSFDC_Util.setBalanceCurrencyType(
        string.valueOf(orderItem.extended_price),
        currencyType
      );
      for (
        RestAPI2Domain.GTVAPIOrderItemPrice orderItemPrice : orderItem.orderItemPrices
      ) {
        if (orderItemPrice.orderItemPriceType == 'RECURRING') {
          orderItemWrapper.recurringPrice = TractSFDC_Util.setBalanceCurrencyType(
            string.valueOf(orderItemPrice.amount / orderItem.quantity),
            currencyType
          );
        } else if (orderItemPrice.orderItemPriceType == 'ONE-TIME') {
          if (orderItemPrice.orderItemPriceRanges != null) {
            for (
              RestAPI2Domain.GTVAPIOrderItemPriceRange orderItemPriceRange : orderItemPrice.orderItemPriceRanges
            ) {
              if (orderItemPriceRange.quantityEndRange != null) {
                if (
                  orderItemPriceRange.quantityBeginRange <
                  orderItemWrapper.Quantity &&
                  orderItemPriceRange.quantityEndRange >=
                  orderItemWrapper.Quantity
                ) {
                  orderItemWrapper.unitPrice = TractSFDC_Util.setBalanceCurrencyType(
                    string.valueOf(orderItemPriceRange.price),
                    currencyType
                  );
                }
              } else {
                if (
                  orderItemPriceRange.quantityBeginRange <
                  orderItemWrapper.Quantity
                ) {
                  orderItemWrapper.unitPrice = TractSFDC_Util.setBalanceCurrencyType(
                    string.valueOf(orderItemPriceRange.price),
                    currencyType
                  );
                }
              }
            }
          }
        }
      }
      if (null != orderItem.description) {
        orderItemWrapper.hasShortDescription = true;
        orderItemWrapper.shortDescription = orderItem.description;
      }
      if (
        null != orderItem.serviceResources &&
        !orderItem.serviceResources.isEmpty()
      ) {
        orderItemWrapper.hasServiceResource = true;
        orderItemWrapper.listOfServiceResources = new List<string>();
        for (
          RestAPI2Domain.GTVAPIServiceResource serviceResource : orderItem.serviceResources
        ) {
          orderItemWrapper.listOfServiceResources.add(
            serviceResource.identifier
          );
        }
      }
      if (null != orderItem.orderItemAgreement) {
        orderItemWrapper.hasAgreement = true;
        orderItemWrapper.agreementName = orderItem.orderItemAgreement.agreement.name;
        orderItemWrapper.agreementEndDate = orderItem.orderItemAgreement.endDate.format(
          'MM/dd/yyyy'
        );
        orderItemWrapper.agreementEndAction = TractSFDC_Util.convertToCamelCase(
          orderItem.orderItemAgreement.endAction.name(),
          '_'
        );
        //orderItemWrapper.agreementPeriod = string.valueOf(orderItem.orderItemAgreement.agreementPeriod);
        if (mapOfOrderItemIdVSAgreement.containsKey(orderItem.id)) {
          if (orderItem.orderItemAgreement.agreementPeriod > 1) {
            orderItemWrapper.agreementPeriod =
              string.valueOf(orderItem.orderItemAgreement.agreementPeriod) +
              ' ' +
              (mapOfOrderItemIdVSAgreement.get(orderItem.id)
                .agreementPeriodType.name()
                .toLowerCase()
                .capitalize() + 's');
          } else {
            orderItemWrapper.agreementPeriod =
              string.valueOf(orderItem.orderItemAgreement.agreementPeriod) +
              ' ' +
              mapOfOrderItemIdVSAgreement.get(orderItem.id)
                .agreementPeriodType.name()
                .toLowerCase()
                .capitalize();
          }
        }
      }
      if (null != orderItem.parentService) {
        orderItemWrapper.hasParentService = true;
        orderItemWrapper.parentServiceName = mapOfOrderItemIdVSParentService.get(
            orderItem.id
          )
          .product.name;
      }
      listOfOrderItemWrapper.add(orderItemWrapper);
      if (null != orderItem.orderItems && !orderItem.orderItems.isEmpty()) {
        system.debug('orderItem.orderItems:::::' + orderItem.orderItems);
        for (
          RestAPI2Domain.GTVAPIAddonServiceProductOrderItem childOrderItem : orderItem.orderItems
        ) {
          GTVOrderItemWrapper childOrderItemWrapper = new GTVOrderItemWrapper();
          childOrderItemWrapper = mapChildOrderItems(
            childOrderItem,
            currencyType,
            mapOfOrderItemIdVSAgreement,
            mapOfOrderItemIdVSParentService
          );
          listOfOrderItemWrapper.add(childOrderItemWrapper);
          if (
            null != childOrderItem.orderItems &&
            !childOrderItem.orderItems.isEmpty()
          ) {
            for (
              RestAPI2Domain.GTVAPIAddonServiceProductOrderItem grandChildOrderItem : childOrderItem.orderItems
            ) {
              GTVOrderItemWrapper grandChildOrderItemWrapper = new GTVOrderItemWrapper();
              grandChildOrderItemWrapper = mapChildOrderItems(
                grandChildOrderItem,
                currencyType,
                mapOfOrderItemIdVSAgreement,
                mapOfOrderItemIdVSParentService
              );
              listOfOrderItemWrapper.add(grandChildOrderItemWrapper);
            }
          }
        }
      }
    }
    salesOrderWrapper.listOfOrderItems = listOfOrderItemWrapper;
    salesOrderWrapper.orderAmount = TractSFDC_Util.setBalanceCurrencyType(
      string.valueOf(orderResponse.subTotal),
      currencyType
    );
    salesOrderWrapper.totalOrderAmountWithTaxes = TractSFDC_Util.setBalanceCurrencyType(
      string.valueOf(orderResponse.totalAmount),
      currencyType
    );
    salesOrderWrapper.taxAmount = TractSFDC_Util.setBalanceCurrencyType(
      string.valueOf(orderResponse.taxTotal),
      currencyType
    );
    return salesOrderWrapper;
  }

  public static GTVOrderItemWrapper mapChildOrderItems(
    RestAPI2Domain.GTVAPIAddonServiceProductOrderItem childOrderItem,
    String currencyType,
    Map<String, RestAPI2Domain.GTVAPIAgreement> mapOfOrderItemIdVSAgreement,
    Map<String, RestAPI2Domain.GTVAPIService> mapOfOrderItemIdVSParentService
  ) {
    GTVOrderItemWrapper childOrderItemWrapper = new GTVOrderItemWrapper();
    childOrderItemWrapper.orderItem = true;
    childOrderItemWrapper.quantity = childOrderItem.quantity.intValue();
    childOrderItemWrapper.productName = childOrderItem.product.name;
    childOrderItemWrapper.orderItemUnitPrice = TractSFDC_Util.setBalanceCurrencyType(
      string.valueOf(childOrderItem.extended_price / childOrderItem.quantity),
      currencyType
    );
    childOrderItemWrapper.orderItemTotalPrice = TractSFDC_Util.setBalanceCurrencyType(
      string.valueOf(childOrderItem.extended_price),
      currencyType
    );
    for (
      RestAPI2Domain.GTVAPIOrderItemPrice childOrderItemPrice : childOrderItem.orderItemPrices
    ) {
      if (childOrderItemPrice.orderItemPriceType == 'RECURRING') {
        childOrderItemWrapper.recurringPrice = TractSFDC_Util.setBalanceCurrencyType(
          string.valueOf(childOrderItemPrice.amount / childOrderItem.quantity),
          currencyType
        );
      } else if (childOrderItemPrice.orderItemPriceType == 'ONE-TIME') {
        if (childOrderItemPrice.orderItemPriceRanges != null) {
          for (
            RestAPI2Domain.GTVAPIOrderItemPriceRange orderItemPriceRange : childOrderItemPrice.orderItemPriceRanges
          ) {
            if (orderItemPriceRange.quantityEndRange != null) {
              if (
                orderItemPriceRange.quantityBeginRange <
                childOrderItemWrapper.Quantity &&
                orderItemPriceRange.quantityEndRange >=
                childOrderItemWrapper.Quantity
              ) {
                childOrderItemWrapper.unitPrice = TractSFDC_Util.setBalanceCurrencyType(
                  string.valueOf(orderItemPriceRange.price),
                  currencyType
                );
              }
            } else {
              if (
                orderItemPriceRange.quantityBeginRange <
                childOrderItemWrapper.Quantity
              ) {
                childOrderItemWrapper.unitPrice = TractSFDC_Util.setBalanceCurrencyType(
                  string.valueOf(orderItemPriceRange.price),
                  currencyType
                );
              }
            }
          }
        }
      }
    }
    if (null != childOrderItem.description) {
      childOrderItemWrapper.hasShortDescription = true;
      childOrderItemWrapper.shortDescription = childOrderItem.description;
    }
    if (
      null != childOrderItem.serviceResources &&
      !childOrderItem.serviceResources.isEmpty()
    ) {
      childOrderItemWrapper.hasServiceResource = true;
      childOrderItemWrapper.listOfServiceResources = new List<string>();
      for (
        RestAPI2Domain.GTVAPIServiceResource serviceResource : childOrderItem.serviceResources
      ) {
        childOrderItemWrapper.listOfServiceResources.add(
          serviceResource.identifier
        );
      }
    }
    if (null != childOrderItem.orderItemAgreement) {
      childOrderItemWrapper.hasAgreement = true;
      childOrderItemWrapper.agreementName = childOrderItem.orderItemAgreement.agreement.name;
      childOrderItemWrapper.agreementEndDate = childOrderItem.orderItemAgreement.endDate.format(
        'MM/dd/yyyy'
      );
      childOrderItemWrapper.agreementEndAction = TractSFDC_Util.convertToCamelCase(
        childOrderItem.orderItemAgreement.endAction.name(),
        '_'
      );
      //childOrderItemWrapper.agreementPeriod = string.valueOf(childOrderItem.orderItemAgreement.agreementPeriod);
      if (mapOfOrderItemIdVSAgreement.containsKey(childOrderItem.id)) {
        if (childOrderItem.orderItemAgreement.agreementPeriod > 1) {
          childOrderItemWrapper.agreementPeriod =
            string.valueOf(childOrderItem.orderItemAgreement.agreementPeriod) +
            ' ' +
            (mapOfOrderItemIdVSAgreement.get(childOrderItem.id)
              .agreementPeriodType.name()
              .toLowerCase()
              .capitalize() + 's');
        } else {
          childOrderItemWrapper.agreementPeriod =
            string.valueOf(childOrderItem.orderItemAgreement.agreementPeriod) +
            ' ' +
            mapOfOrderItemIdVSAgreement.get(childOrderItem.id)
              .agreementPeriodType.name()
              .toLowerCase()
              .capitalize();
        }
      }
    }
    if (null != childOrderItem.parentService) {
      childOrderItemWrapper.hasParentService = true;
      childOrderItemWrapper.parentServiceName = mapOfOrderItemIdVSParentService.get(
          childOrderItem.id
        )
        .product.name;
    }
    return childOrderItemWrapper;
  }

  /**
   * Parse the queried Order Custom Fields
   */
  public static list<Tract_Service_Custom_Field__c> parseServiceCustomFields(
    List<RestAPI2Domain.GTVAPIServiceCustomField> tractServiceCustomFieldResponse
  ) {
    list<Tract_Service_Custom_Field__c> serviceCustomFieldList = new List<Tract_Service_Custom_Field__c>();
    for (
      RestAPI2Domain.GTVAPIServiceCustomField serviceCustomField : tractServiceCustomFieldResponse
    ) {
      Tract_Service_Custom_Field__c serviceCustomFieldObj = new Tract_Service_Custom_Field__c();
      serviceCustomFieldObj.eid__c = serviceCustomField.id;
      serviceCustomFieldObj.Name = serviceCustomField.name;
      serviceCustomFieldObj.ValidationType__c = serviceCustomField.fieldValidationType;
      serviceCustomFieldObj.FieldType__c = serviceCustomField.fieldType;
      if (
        serviceCustomField.fieldType == 'LIST' &&
        serviceCustomField.references != null &&
        serviceCustomField.references.size() > 0
      ) {
        for (
          RestAPI2Domain.GTVAPICustomFieldValueReference refrence : serviceCustomField.references
        ) {
          if (serviceCustomFieldObj.StoreListValue__c == null) {
            serviceCustomFieldObj.StoreListValue__c = refrence.value;
          } else
            serviceCustomFieldObj.StoreListValue__c += ',' + refrence.value;
        }
      }
      serviceCustomFieldList.add(serviceCustomFieldObj);
    }
    return serviceCustomFieldList;
  }
  public static List<DiscountCodeWrapper> mapDiscountCodeResponse(
    List<RestAPI2Domain.GTVAPIDiscountCode> discountCodeResponse
  ) {
    List<DiscountCodeWrapper> discountCodeList = new List<DiscountCodeWrapper>();
    for (
      RestAPI2Domain.GTVAPIDiscountCode discountCodeInstance : discountCodeResponse
    ) {
      DiscountCodeWrapper discountCodeObj = new DiscountCodeWrapper();
      discountCodeObj.status = discountCodeInstance.status.name()
        .toLowerCase()
        .capitalize();
      discountCodeObj.description = discountCodeInstance.description;
      if (null != discountCodeInstance.discountChargeCategory) {
        discountCodeObj.chargeCategory = discountCodeInstance.discountChargeCategory.name;
      }
      if (null != discountCodeInstance.validFrom) {
        discountCodeObj.availableFrom = (discountCodeInstance.validFrom)
          .format('MM/dd/yyyy');
      }
      discountCodeObj.name = discountCodeInstance.name;
      if (null != discountCodeInstance.discount) {
        discountCodeObj.discount = discountCodeInstance.discount.name;
      }
      discountCodeList.add(discountCodeObj);
    }
    return discountCodeList;
  }

  /**
   * Parse the one time order Item
   */
  public static List<GTVOneTimeOrderItemWrapper> parseOneTimeOrderItem(
    List<RestAPI2Domain.GTVAPIOrder> orderResponse,
    String currencyType
  ) {
    List<GTVOneTimeOrderItemWrapper> oneTimeOrderItemList = new List<GTVOneTimeOrderItemWrapper>();
    for (RestAPI2Domain.GTVAPIOrder orderInstance : orderResponse) {
      for (
        RestAPI2Domain.GTVAPIOrderItem orderItemInstance : orderInstance.orderItems
      ) {
        if (orderItemInstance.product.productType == 'general') {
          GTVOneTimeOrderItemWrapper orderItemObj = new GTVOneTimeOrderItemWrapper();
          orderItemObj.productName = orderItemInstance.product.Name;
          orderItemObj.status = orderItemInstance.status.name();
          orderItemObj.description = orderItemInstance.description;
          orderItemObj.productDescription = orderItemInstance.product.description;
          orderItemObj.quantity = Integer.valueof(orderItemInstance.quantity);
          orderItemObj.unitPrice = TractSFDC_Util.setBalanceCurrencyType(
            string.valueOf(
              orderItemInstance.extended_price / orderItemInstance.quantity
            ),
            currencyType
          );
          orderItemObj.totalPrice = TractSFDC_Util.setBalanceCurrencyType(
            string.valueOf(orderItemInstance.extended_price),
            currencyType
          );
          orderItemObj.orderNumber = orderInstance.orderNum;
          orderItemObj.purchaseDate = Date.valueOf(orderInstance.orderDate);
          orderItemObj.id = orderItemInstance.id;
          orderItemObj.scheduleChargeInf = new List<ScheduleChargesWapper>();
          if (orderItemInstance.charges != null) {
            for (
              RestAPI2Domain.GTVAPIOrderItemCharge charge : orderItemInstance.charges
            ) {
              if (charge.orderItemChargeType == 'product-one-time') {
                if (charge.priceCategory != null) {
                  orderItemObj.priceCategory = charge.priceCategory.name;
                }
                orderItemObj.overridden = charge.overridden ? 'Yes' : 'No';
                if (charge.scheduledCharges != null) {
                  for (
                    RestAPI2Domain.GTVAPIServicePriceChargeRef scheduleCharge : charge.scheduledCharges
                  ) {
                    ScheduleChargesWapper chargeWrap = new ScheduleChargesWapper();
                    chargeWrap.amount = TractSFDC_Util.setBalanceCurrencyType(
                      String.valueOf(scheduleCharge.amount),
                      currencyType
                    );
                    chargeWrap.chargeDate = date.valueOf(
                      scheduleCharge.charge_date
                    );
                    chargeWrap.chargeType = scheduleCharge.price_charge_type;
                    chargeWrap.description = scheduleCharge.description;
                    chargeWrap.invoiced = scheduleCharge.invoiced
                      ? 'Yes'
                      : 'No';
                    chargeWrap.status = scheduleCharge.status;
                    orderItemObj.scheduleChargeInf.add(chargeWrap);
                  }
                }
              }
            }
          }
          oneTimeOrderItemList.add(orderItemObj);
        }
      }
    }
    return oneTimeOrderItemList;
  }

  public static list<SelectOption> mapProductcategoryResponse(
    List<RestAPI2Domain.GTVAPIProductCategory> productCategoryResponse
  ) {
    list<SelectOption> productCategoryList = new List<SelectOption>();
    productCategoryList.add(new SelectOption('', 'Choose One'));
    for (
      RestAPI2Domain.GTVAPIProductCategory productCategory : productCategoryResponse
    ) {
      productCategoryList.add(
        new SelectOption(productCategory.id, productCategory.name)
      );
    }
    return productCategoryList;
  }

  public static list<SelectOption> mapServiceResourceCategoryResponse(
    List<RestAPI2Domain.GTVAPIResourceCategory> serviceResourceCategoryResponse
  ) {
    list<SelectOption> serviceResourceCategoryList = new List<SelectOption>();
    serviceResourceCategoryList.add(new SelectOption('', 'Choose One'));
    for (
      RestAPI2Domain.GTVAPIResourceCategory resourceCategory : serviceResourceCategoryResponse
    ) {
      serviceResourceCategoryList.add(
        new SelectOption(resourceCategory.id, resourceCategory.name)
      );
    }
    return serviceResourceCategoryList;
  }

  public static list<SelectOption> mapProductTagResponse(
    List<RestAPI2Domain.GTVAPIProductTag> productTagResponse
  ) {
    list<SelectOption> productTagList = new List<SelectOption>();
    for (RestAPI2Domain.GTVAPIProductTag productTag : productTagResponse) {
      productTagList.add(new SelectOption(productTag.id, productTag.name));
    }
    return productTagList;
  }

  public static void mapProductCreationResponse(
    String productId,
    RestAPI2Domain.GTVAPIProduct tractProduct
  ) {
    Product2 sfdcProduct = new Product2();
    sfdcProduct.id = productId;
    sfdcProduct.Name = tractProduct.name;
    sfdcProduct.Short_Desc__c = tractProduct.shortDescription;
    sfdcProduct.Description = tractProduct.description;
    if (tractProduct.state.name() == 'AVAILABLE') {
      sfdcProduct.IsActive = true;
    }
    sfdcProduct.Family = 'TRACT';
    if (tractProduct.productType == 'GENERAL') {
      sfdcProduct.ProductCode = 'ONE-TIME';
    } else if (tractProduct.productType == 'add-on') {
      sfdcProduct.ProductCode = 'ADD-ON';
    } else if (tractProduct.productType == 'customer-subscription') {
      sfdcProduct.ProductCode = 'SUBSCRIPTION';
    } else {
      sfdcProduct.ProductCode = tractProduct.productType;
    }
    sfdcProduct.eid__c = tractProduct.id;
    sfdcProduct.Requires_Agreement__c = tractProduct.requiresAgreement;
    sfdcProduct.maxServiceResources__c = tractProduct.maxServiceResources;
    sfdcProduct.minServiceResources__c = tractProduct.minServiceResources;
    if (null != tractProduct.ruleOverride) {
      sfdcProduct.RuleOverride__c = tractProduct.ruleOverride;
    }
    if (null != tractProduct.ruleType) {
      sfdcProduct.RuleType__c = tractProduct.ruleType.name();
    }
    if (tractProduct.serviceResourceCategory != null) {
      sfdcProduct.Service_Resource_Category__c = tractProduct.serviceResourceCategory.name;
      sfdcProduct.SRC_eid__c = tractProduct.serviceResourceCategory.id;
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

  public static list<SelectOption> mapProductRegisterTypeResponse(
    List<RestAPI2Domain.GTVAPIProductRegisterType> productRegisterTypeResponse
  ) {
    list<SelectOption> productRegisterTypeList = new List<SelectOption>();
    productRegisterTypeList.add(new SelectOption('', 'Choose One'));
    for (
      RestAPI2Domain.GTVAPIProductRegisterType productRegisterType : productRegisterTypeResponse
    ) {
      productRegisterTypeList.add(
        new SelectOption(productRegisterType.id, productRegisterType.name)
      );
    }
    return productRegisterTypeList;
  }
  public static List<ProductAgreementWrapper> mapAllAgreements(
    List<RestAPI2Domain.GTVAPIAgreement> tractAgreements
  ) {
    list<ProductAgreementWrapper> agreementWrapperList = new List<ProductAgreementWrapper>();
    Map<String, ProductAgreementWrapper> productFamilyMap = new Map<String, ProductAgreementWrapper>();
    Map<String, ProductAgreementWrapper> productFamilyMapSorted = new Map<String, ProductAgreementWrapper>();
    List<String> orderingList = new List<String>();
    for (RestAPI2Domain.GTVAPIAgreement ag : tractAgreements) {
      ProductAgreementWrapper agreementObj = new ProductAgreementWrapper();
      agreementObj.Name = ag.name;
      agreementObj.isSelected = false;
      agreementObj.eid = ag.id;
      agreementObj.status = ag.status;
      agreementObj.agreementPeriod = ag.agreementPeriod;
      if (ag.agreementPeriod == 1) {
        agreementObj.agreementPeriodType = ag.agreementPeriodType.name()
          .toLowerCase()
          .capitalize();
      } else {
        agreementObj.agreementPeriodType =
          ag.agreementPeriodType.name().toLowerCase().capitalize() + 's';
      }
      agreementObj.endAction = TractSFDC_Util.convertToCamelCase(
        ag.endAction.name(),
        '_'
      );
      if (ag.prorateOnCancel) {
        agreementObj.prorateOnCancel = 'Yes';
      } else {
        agreementObj.prorateOnCancel = 'No';
      }
      if (ag.adjustmentCategory != null) {
        agreementObj.adjustmentCategory = ag.adjustmentCategory.name;
      }
      if (null != ag.terminationFeeCurrencyCode) {
        agreementObj.currencyType = ag.terminationFeeCurrencyCode.name();
      } else if (null != ag.minimumAmountCurrencyType) {
        agreementObj.currencyType = ag.minimumAmountCurrencyType.name();
      } else if (null != ag.minimumAmountCurrencyType) {
        agreementObj.currencyType = ag.minimumAmountCurrencyType.name();
      } else if (null != ag.maxTerminationFeeCurrencyCode) {
        agreementObj.currencyType = ag.maxTerminationFeeCurrencyCode.name();
      }
      if (ag.maxTerminationCharge != null) {
        agreementObj.maxTerminationFlatCharge = TractSFDC_Util.setBalanceCurrencyType(
          String.valueof(ag.maxTerminationCharge),
          agreementObj.currencyType
        );
      }

      if (ag.terminationFlatCharge != null) {
        agreementObj.terminationFlatCharge = TractSFDC_Util.setBalanceCurrencyType(
          String.valueof(ag.terminationFlatCharge),
          agreementObj.currencyType
        );
      } else if (ag.terminationPercentageCharge != null) {
        agreementObj.terminationFlatCharge =
          String.valueof((ag.terminationPercentageCharge * 100).setScale(2)) +
          '%';
      }
      productFamilyMap.put(ag.Name.toUpperCase(), agreementObj);
    }
    orderingList.addAll(productFamilyMap.keyset());
    orderingList.sort();
    for (Integer i = 0; i < orderingList.size(); i++) {
      productFamilyMapSorted.put(
        orderingList[i],
        productFamilyMap.get(orderingList[i])
      );
    }
    agreementWrapperList = productFamilyMapSorted.values();
    return agreementWrapperList;
  }

  public static list<SelectOption> mapRecurrencePeriod(
    List<RestAPI2Domain.GTVAPIRecurrencePeriod> recurrencePeriodEnumList
  ) {
    list<SelectOption> recurrencePeriodList = new List<SelectOption>();
    for (
      RestAPI2Domain.GTVAPIRecurrencePeriod recurrencePeriod : recurrencePeriodEnumList
    ) {
      recurrencePeriodList.add(
        new SelectOption(
          recurrencePeriod.name(),
          TractSFDC_Util.convertToCamelCase(recurrencePeriod.name(), '_')
        )
      );
    }
    return recurrencePeriodList;
  }

  public static list<SelectOption> mapProductPriceGroupResponse(
    List<RestAPI2Domain.GTVAPIProductPriceGroup> productPriceGroupResponse
  ) {
    list<SelectOption> productPriceGroupList = new List<SelectOption>();
    productPriceGroupList.add(new SelectOption('', 'None'));
    for (
      RestAPI2Domain.GTVAPIProductPriceGroup productPriceGroup : productPriceGroupResponse
    ) {
      productPriceGroupList.add(
        new SelectOption(productPriceGroup.id, productPriceGroup.name)
      );
    }
    return productPriceGroupList;
  }

  public static list<SelectOption> mappriceCategoryResponse(
    List<RestAPI2Domain.GTVAPIChargeCategory> priceCategoryResponse
  ) {
    list<SelectOption> priceCategoryList = new List<SelectOption>();
    priceCategoryList.add(new SelectOption('', 'Choose One'));
    for (
      RestAPI2Domain.GTVAPIChargeCategory priceCategory : priceCategoryResponse
    ) {
      priceCategoryList.add(
        new SelectOption(priceCategory.id, priceCategory.name)
      );
    }
    return priceCategoryList;
  }

  public static void mapProductPriceCreationResponse(
    String productId,
    List<RestAPI2Domain.GTVAPIProductPrice> productPriceList
  ) {
    Product2 sfdcProduct = [
      SELECT id, Name, eid__c, PriceLists__c, Price_Information__c
      FROM Product2
      WHERE id = :productId
      LIMIT 1
    ];
    Price_List__c priceList = [
      SELECT id, name, TRACT3__eid__c
      FROM TRACT3__Price_List__c
      WHERE name = 'Default Price List'
    ];
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

    if (productPriceList != null && !productPriceList.isEmpty()) {
      for (RestAPI2Domain.GTVAPIProductPrice productPrice : productPriceList) {
        if (
          mapOfEidVsProductPrice.containsKey(productPrice.id) &&
          productPrice.thruDate == null
        ) {
          productPriceWrapperList.add(
            mapOfEidVsProductPrice.get(productPrice.id)
          );
        } else if (productPrice.thruDate == null) {
          ProductPriceWrapper sfdcProductPrice = new ProductPriceWrapper();
          sfdcProductPrice.eid = productPrice.id;
          sfdcProductPrice.currencyType = productPrice.currencyCode.name();
          sfdcProductPrice.fromDate = TractSFDC_Util.productPriceFormat(
            productPrice.validFrom
          );
          sfdcProductPrice.thruDate = productPrice.thruDate;
          sfdcProductPrice.scheduledCharges = productPrice.allowScheduledCharges ==
            null
            ? false
            : productPrice.allowScheduledCharges;
          sfdcProductPrice.priceOverride = productPrice.priceOverride == null
            ? true
            : productPrice.priceOverride;
          sfdcProductPrice.priceType = productPrice.priceType;
          sfdcProductPrice.recurrencePeriod = TractSFDC_Util.convertToCamelCase(
            productPrice.recurrencePeriod,
            '_'
          );
          sfdcProductPrice.paymentOnPurchaseRequired = productPrice.paymentOnPurchaseRequired;
          sfdcProductPrice.priceListEid = priceList.eid__c;
          if (productPrice.priceRanges != null) {
            sfdcProductPrice.priceRangesList = createPriceRangeList(
              productPrice.priceRanges
            );
          }
          if (productPrice.priceCategory != null) {
            sfdcProductPrice.priceCategory = productPrice.priceCategory.name;
            sfdcProductPrice.priceCategoryId = productPrice.priceCategory.Id;
          }
          if (productPrice.priceGroup != null) {
            sfdcProductPrice.priceGroupId = productPrice.priceGroup.Id;
          }
          if (productPrice.billInAdvanceConfiguration != null) {
            sfdcProductPrice.billInAdvanceAmount = productPrice.billInAdvanceConfiguration.amount;
            sfdcProductPrice.billInAdvanceUnit = productPrice.billInAdvanceConfiguration.period;
          }
          sfdcProductPrice.proratedOnOrderNoCharge = productPrice.proratedOnOrderNoCharge;
          sfdcProductPrice.proratedOnOrder = productPrice.prorateOnOrder;
          sfdcProductPrice.proratedOnCancel = productPrice.prorateOnCancel;
          sfdcProductPrice.recurringPaymentRequired = productPrice.recurringPaymentRequired;
          sfdcProductPrice.billInAdvance = productPrice.billInAdvance;
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
              WHERE Pricebook2Id = :priceBook[0].id AND Product2Id = :productId
              LIMIT 1
            ];

            if (
              tractPiceBookEntryList == null || tractPiceBookEntryList.isEmpty()
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

  public static list<ProductCustomFieldWrapper> parseproductCustomFields(
    List<RestAPI2Domain.GTVAPIProductCustomField> tractproductCustomFieldsList,
    Map<String, String> productCustomFieldValuesMap
  ) {
    list<productCustomFieldWrapper> listOfproductCustomField = new List<productCustomFieldWrapper>();
    for (
      RestAPI2Domain.GTVAPIProductCustomField custFieldObj : tractproductCustomFieldsList
    ) {
      if (!productCustomFieldValuesMap.containsKey(custFieldObj.id)) {
        productCustomFieldWrapper wrapInstance = new productCustomFieldWrapper();
        wrapInstance.Name = custFieldObj.Name;
        wrapInstance.Eid = custFieldObj.id;
        wrapInstance.fieldValidationType = custFieldObj.fieldValidationType;
        if (custFieldObj.fieldType == 'LIST') {
          wrapInstance.checkListtype = true;
          list<SelectOption> storeListTypeValues = new List<SelectOption>();
          storeListTypeValues.add(new SelectOption('', 'Choose One'));
          for (
            RestAPI2Domain.GTVAPICustomFieldValueReference refrence : custFieldObj.references
          ) {
            storeListTypeValues.add(
              new SelectOption(refrence.value, refrence.value)
            );
          }
          wrapInstance.storeListTypeValues = new List<SelectOption>();
          wrapInstance.storeListTypeValues.addAll(storeListTypeValues);
        }
        listOfproductCustomField.add(wrapInstance);
      }
    }
    return listOfproductCustomField;
  }

  public static Map<String, String> mapProductCustomFieldValues(
    List<RestAPI2Domain.GTVAPIProductCustomFieldValue> valueResponseMap
  ) {
    Map<String, String> ProductCustomFieldValuesMap = new Map<String, String>();
    for (
      RestAPI2Domain.GTVAPIProductCustomFieldValue sample : valueResponseMap
    ) {
      ProductCustomFieldValuesMap.put(sample.customField.id, sample.value);
    }
    return ProductCustomFieldValuesMap;
  }

  public static List<productCustomFieldValueWrapper> parseProductCustomFieldValues(
    List<RestAPI2Domain.GTVAPIProductCustomFieldValue> valueResponseMap
  ) {
    List<productCustomFieldValueWrapper> productCustomFieldValueList = new List<productCustomFieldValueWrapper>();
    for (
      RestAPI2Domain.GTVAPIProductCustomFieldValue sample : valueResponseMap
    ) {
      productCustomFieldValueWrapper prodCustomFieldValueWrap = new productCustomFieldValueWrapper();
      prodCustomFieldValueWrap.Name = sample.customField.Name;
      prodCustomFieldValueWrap.Eid = sample.customField.id;
      prodCustomFieldValueWrap.Value = sample.value;
      productCustomFieldValueList.add(prodCustomFieldValueWrap);
    }
    return productCustomFieldValueList;
  }
  public static list<MarketPlaceWrapper> parseMarketPlaceValues(
    List<RestAPI2Domain.GTVAPIMarketplace> valueResponseMap
  ) {
    List<MarketPlaceWrapper> marketPlaceValueList = new List<MarketPlaceWrapper>();
    for (RestAPI2Domain.GTVAPIMarketplace sample : valueResponseMap) {
      MarketPlaceWrapper marketPlaceValueWrap = new MarketPlaceWrapper();
      marketPlaceValueWrap.mplaceId = sample.id;
      marketPlaceValueWrap.Name = sample.name;
      marketPlaceValueWrap.Description = sample.description;
      marketPlaceValueWrap.FromDate = Date.valueOf(sample.validFrom);
      marketPlaceValueList.add(marketPlaceValueWrap);
    }
    return marketPlaceValueList;
  }
  public static list<PriceListWrapper> parseMarketPlacePriceLists(
    List<RestAPI2Domain.GTVAPIPriceList> valueResponseMap
  ) {
    List<PriceListWrapper> marketPlacePriceListValueList = new List<PriceListWrapper>();
    for (RestAPI2Domain.GTVAPIPriceList sample : valueResponseMap) {
      PriceListWrapper marketPlacePriceListWrap = new PriceListWrapper();
      marketPlacePriceListWrap.priceListId = sample.id;
      marketPlacePriceListWrap.Name = sample.name;
      marketPlacePriceListWrap.Description = sample.description;
      marketPlacePriceListValueList.add(marketPlacePriceListWrap);
    }
    return marketPlacePriceListValueList;
  }

  public static list<ProductRelationWrapper> mapProductRelationShip(
    List<RestAPI2Domain.GTVAPIProductRelation> productRelationResponse
  ) {
    list<ProductRelationWrapper> productRelationWrapperList = new List<ProductRelationWrapper>();
    for (
      RestAPI2Domain.GTVAPIProductRelation relation : productRelationResponse
    ) {
      ProductRelationWrapper productRelationWrap = new ProductRelationWrapper();
      productRelationWrap.productName = relation.product.name;
      productRelationWrap.relationShipType = relation.productRelationType.name();
      if (relation.scope != null) {
        productRelationWrap.scope = relation.scope.name();
      }
      productRelationWrap.productRelationShipEid = relation.id;
      productRelationWrapperList.add(productRelationWrap);
    }
    return productRelationWrapperList;
  }
  /**
   * Parse the queried billing Account and map it with Salesforce Account Object
   * @param tractBillingAccount The billing account response wrapper (required)
   * @param sfdcAccount The Salesforce billing account to be mapped (required)
   * @return TRACTAccountWrapper
   */
  public static list<TRACTAccountWrapper> parseChildAccountList(
    List<RestAPI2Domain.GTVAPIBillingAccount> tractBillingAccountList
  ) {
    list<TRACTAccountWrapper> sfdcBillingAccountWrapperList = new List<TRACTAccountWrapper>();
    for (
      RestAPI2Domain.GTVAPIBillingAccount tractBillingAccount : tractBillingAccountList
    ) {
      TRACTAccountWrapper sfdcBillingAccount = new TRACTAccountWrapper();
      Account sfdcAccount = new Account();
      if (null != tractBillingAccount) {
        sfdcAccount.Name = tractBillingAccount.responsibleParty.organizationName;
        sfdcBillingAccount.status = tractBillingAccount.status.name();
        sfdcBillingAccount.balance = TractSFDC_Util.setBalanceCurrencyType(
          String.valueOf(tractBillingAccount.balance),
          tractBillingAccount.currencyCode.name().toUpperCase()
        );
        sfdcBillingAccount.billCycleName = tractBillingAccount.billCycle.name;
        sfdcBillingAccount.billType = tractBillingAccount.billType.name();
        sfdcBillingAccount.accountCategory = tractBillingAccount.billingAccountCategory.name;
        sfdcAccount.Tract_Billing_Account__c = tractBillingAccount.accountNum;
        sfdcBillingAccount.TractBillingAccountNumber = tractBillingAccount.accountNum;
        sfdcBillingAccount.eid = tractBillingAccount.id;
        sfdcBillingAccount.validFrom = Date.valueOf(
          tractBillingAccount.startDate
        );
        sfdcBillingAccount.accountCurrency = tractBillingAccount.currencyCode.name()
          .toUpperCase();
        if (tractBillingAccount.responsibleParty.addresses != null) {
          for (
            RestAPI2Domain.GTVAPIAddress address : tractBillingAccount.responsibleParty.addresses
          ) {
            if (
              address.addressType.Name() == 'postal' &&
              address.purpose.Name() == 'billing'
            ) {
              sfdcAccount.BillingStreet = address.line1;
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
            } else if (
              address.addressType.Name() == 'postal' &&
              address.purpose.Name() == 'shipping'
            ) {
              sfdcAccount.ShippingStreet = address.line1;
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
            } else if (address.addressType.Name() == 'email') {
              sfdcBillingAccount.email = address.email;
            }
          }
        }
      }
      sfdcBillingAccount.billingAccount = sfdcAccount;
      sfdcBillingAccountWrapperList.add(sfdcBillingAccount);
    }

    return sfdcBillingAccountWrapperList;
  }

  public static Product2AddWrapper mapDiscountResource(
    Product2AddWrapper productWrapper,
    List<RestAPI2Domain.GTVAPIDiscountResource> valueResponseMap,
    string discountName
  ) {
    if (null != valueResponseMap && !valueResponseMap.isEmpty()) {
      for (RestAPI2Domain.GTVAPIDiscountResource resource : valueResponseMap) {
        productWrapper.discountEid = resource.id;
        productWrapper.discountName = discountName;
        break;
      }
    } else {
      productWrapper.errorMessage =
        discountName +
        ' is an invalid discount code' +
        '.';
    }
    return productWrapper;
  }
  public static list<SelectOption> parseMarketPlaces(
    List<RestAPI2Domain.GTVAPIMarketplace> valueResponseMap
  ) {
    list<SelectOption> listOfMarketPlace = new List<SelectOption>();
    for (RestAPI2Domain.GTVAPIMarketplace sample : valueResponseMap) {
      listOfMarketPlace.add(new SelectOption(sample.id, sample.name));
    }
    return listOfMarketPlace;
  }
  public static list<ProductUsesWrapper> parseProductUsageRule(
    List<RestAPI2Domain.GTVAPIProductUsageRule> valueResponseMap
  ) {
    map<String, String> specType = new Map<String, String>();
    specType.put('Choose One', 'Choose One');
    specType.put('EQUALS', '=');
    specType.put('NOT_EQUALS', '<>');
    specType.put('GREATER_THAN', '>');
    specType.put('GREATER_THAN_EQUALS', '>=');
    specType.put('LESS_THAN', '<');
    specType.put('LESS_THAN_EQUALS', '<=');
    specType.put('LOOKUP', 'Lookup');
    list<ProductUsesWrapper> listOfUsageRules = new List<ProductUsesWrapper>();
    for (RestAPI2Domain.GTVAPIProductUsageRule currentRule : valueResponseMap) {
      system.debug('currentRule:::::' + currentRule);
      ProductUsesWrapper usageWrap = new ProductUsesWrapper();
      usageWrap.ChargeName = currentRule.Name;
      usageWrap.UsageRuleEid = currentRule.id;
      usageWrap.FromDate = String.valueOf(currentRule.validFrom);
      usageWrap.ThruDate = String.valueOf(currentRule.validTo);
      usageWrap.ChargeCategory = currentRule.usageRate.chargeCategory.name;
      if (currentRule.spec.usageRuleSpecificationType == 'match-all') {
        usageWrap.Rule = 'Matches all';
      } else if (currentRule.spec.usageRuleSpecificationType == 'formula') {
        usageWrap.Rule =
          currentRule.spec.field_name.toLowerCase() +
          specType.get(currentRule.spec.operator) +
          currentRule.spec.field_value;
      } else if (currentRule.spec.usageRuleSpecificationType == 'global') {
        usageWrap.Rule = currentRule.spec.name;
      }
      usageWrap.ChargeType = 'MatchAll';
      if (currentRule.usageRate.usageRateType == 'flat') {
        usageWrap.Rate =
          String.valueOf(currentRule.usageRate.rate.setScale(2)) +
          ' per ' +
          currentRule.usageRate.uom.toLowerCase().capitalize();
      }
      if (currentRule.usageRate.usageRateType == 'table') {
        usageWrap.Rate = 'Table Rate ' + currentRule.usageRate.rateTable.name;
      }
      if (currentRule.usageRate.usageRateType == 'pass-through') {
        if (currentRule.usageRate.usageFieldName != null) {
          usageWrap.Rate =
            'Pass Through ' +
            currentRule.usageRate.usageFieldName.toLowerCase();
        } else {
          usageWrap.Rate = 'Rule Rating';
        }
        //usageWrap.Taper = String.valueOf(Decimal.valueOf(matchAll.limit_x).setScale(0)) + ' ' + matchAll.usageUom.toLowerCase().capitalize() + 's';
      }
      if (currentRule.allowanceType.name() == 'UNLIMITED') {
        usageWrap.Taper =
          'Unlimited' +
          ' ' +
          TractSFDC_Util.convertToCamelCase(currentRule.allowanceUom, '_');
      } else {
        usageWrap.Taper =
          String.valueOf(
            Decimal.valueOf(currentRule.allowanceAmount).setScale(0)
          ) +
          ' ' +
          TractSFDC_Util.convertToCamelCase(currentRule.allowanceUom, '_');
      }
      usageWrap.Status = currentRule.status.name().toLowerCase().capitalize();
      listOfUsageRules.add(usageWrap);
    }
    return listOfUsageRules;
  }

  public static GTVPaymentWrapper parsePaymentMethods(
    List<RestAPI2Domain.GTVAPIRecurringPayment> tractPaymentMethodList
  ) {
    GTVPaymentWrapper paymentMethodWrapper = new GTVPaymentWrapper();
    list<SelectOption> listOfPaymentMethods = new List<SelectOption>();
    Map<String, String> mapOfPaymentMethods = new Map<String, String>();
    for (
      RestAPI2Domain.GTVAPIRecurringPayment paymentMethodObj : tractPaymentMethodList
    ) {
      listOfPaymentMethods.add(
        new SelectOption(
          paymentMethodObj.id,
          paymentMethodObj.paymentMethod.nickname
        )
      );
      mapOfPaymentMethods.put(
        paymentMethodObj.id,
        paymentMethodObj.paymentMethod.paymentMethodType
      );
    }
    paymentMethodWrapper.listOfPaymentMethods = listOfPaymentMethods;
    paymentMethodWrapper.mapOfPaymentMethodEidVsType = mapOfPaymentMethods;
    return paymentMethodWrapper;
  }

  public static ChangeSubscriptionWrapper mapCompatibleProducts(
    List<RestAPI2Domain.GTVAPIProduct> compatibleProductResponse,
    String priceListEid,
    String currencyType,
    Boolean enablePreserveAgreement
  ) {
    ChangeSubscriptionWrapper subscriptionWrapper = new ChangeSubscriptionWrapper();
    list<String> compatibleProductEidList = new List<String>();
    List<SelectOption> compatibleProductOptions = new List<SelectOption>();
    Map<String, List<ProductPriceWrapper>> productIdToProductPriceMap = new Map<String, List<ProductPriceWrapper>>();
    Map<String, List<ProductPriceRangeWrapper>> productPriceIdtoPriceRangesMap = new Map<String, List<ProductPriceRangeWrapper>>();
    if (compatibleProductResponse.size() > 0) {
      for (
        RestAPI2Domain.GTVAPIProduct compatibleProducts : compatibleProductResponse
      ) {
        compatibleProductEidList.add(compatibleProducts.id);
      }
    }
    compatibleProductOptions.add(new SelectOption('', 'Choose One'));
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
        WHERE eid__c IN :compatibleProductEidList
      ]) {
        compatibleProductOptions.add(
          new SelectOption(proCode.Id, String.valueOf(proCode.name))
        );
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
    subscriptionWrapper.newServiceList = compatibleProductOptions;
    subscriptionWrapper.errorMessage = 'NoError';
    return subscriptionWrapper;
  }

  public static createChangeOrderWrapper getCreateChangeOrderWrapper(
    List<RestAPI2Domain.GTVAPIProduct> compatibleProductResponse,
    List<RestAPI2Domain.GTVAPIOrderItem> orderItemResponse,
    String currentServiceId,
    String currencyType
  ) {
    CreateChangeOrderWrapper changeOrderWrapper = new CreateChangeOrderWrapper();
    changeOrderWrapper.type = 'Subscription';
    changeOrderWrapper.currentServiceId = currentServiceId;
    changeOrderWrapper.currencyType = currencyType;
    if (null != orderItemResponse && !orderItemResponse.isEmpty()) {
      changeOrderWrapper.priceListId = orderItemResponse[0].priceList.id;
      changeOrderWrapper.CurrentProductId = orderItemResponse[0].product.id;
      if (orderItemResponse[0].product.shortDescription != null) {
        changeOrderWrapper.shortDescription = orderItemResponse[0]
          .product.shortDescription;
      } else {
        changeOrderWrapper.shortDescription = orderItemResponse[0].product.Name;
      }
      changeOrderWrapper.currentProductName = orderItemResponse[0].product.Name;
      changeOrderWrapper.originalServiceName =
        changeOrderWrapper.currentProductName +
        '(' +
        currentServiceId +
        ')';
      changeOrderWrapper.OrderDate = String.valueOf(System.today());
      changeOrderWrapper.EmailReciept = false;
      if (
        orderItemResponse[0].serviceResources != null &&
        orderItemResponse[0].serviceResources.size() > 0
      ) {
        changeOrderWrapper.srIdentifierList = new List<String>();
        for (
          RestAPI2Domain.GTVAPIServiceResource serviceResource : orderItemResponse[0]
            .serviceResources
        ) {
          changeOrderWrapper.srIdentifierList.add(serviceResource.identifier);
        }
      }
      if (orderItemResponse[0].orderItemAgreement != null) {
        changeOrderWrapper.enablePreserveAgreement = true;
        changeOrderWrapper.agreementId = orderItemResponse[0]
          .orderItemAgreement.agreement.id;
        changeOrderWrapper.agreementName = orderItemResponse[0]
          .orderItemAgreement.agreement.name;
        changeOrderWrapper.agreementPeriod = orderItemResponse[0]
          .orderItemAgreement.agreementPeriod;
        changeOrderWrapper.agreementEndAction = orderItemResponse[0]
          .orderItemAgreement.endAction.name();
        changeOrderWrapper.preserveAgreementPrice = orderItemResponse[0]
          .orderItemAgreement.preserveServicePrice;
        if (orderItemResponse[0].orderItemAgreement.endDate != null) {
          changeOrderWrapper.overrideAgreementEndDate = Date.valueof(
            orderItemResponse[0].orderItemAgreement.endDate
          );
        }
        if (orderItemResponse[0].orderItemAgreement.preserveServicePrice) {
          changeOrderWrapper.renewalPrice = 'Service Price';
        } else {
          changeOrderWrapper.renewalPrice = 'Product Price';
        }
      } else {
        changeOrderWrapper.enablePreserveAgreement = false;
      }
    }
    //changeOrderWrapper.CurrentProductId = CurrentProductId;
    changeOrderWrapper.Quantity = 1;
    list<String> compatibleProductEidList = new List<String>();
    List<SelectOption> compatibleProductOptions = new List<SelectOption>();
    Map<String, List<SelectOption>> productIdToRecurrenceProductPriceMap = new Map<String, List<SelectOption>>();
    Map<String, List<SelectOption>> productIdToOneTimeProductPriceMap = new Map<String, List<SelectOption>>();
    Map<String, boolean> MapofProductPriceEidVsPriceOverrideFlag = new Map<String, boolean>();
    Map<String, boolean> MapofProductEidVsSerializedFlag = new Map<String, boolean>();
    Map<String, Agreementwrapper> MapOfProductIdVsAgreementWrapper = new Map<String, Agreementwrapper>();
    Map<String, product2> MapofProductIdVsProduct = new Map<String, product2>();
    Map<String, list<ProductPriceRangeWrapper>> mapOfProductPriceEidVsPriceRangeList = new Map<String, list<ProductPriceRangeWrapper>>();
    if (changeOrderWrapper.CurrentProductId != null) {
      compatibleProductEidList.add(changeOrderWrapper.CurrentProductId);
    }
    if (compatibleProductResponse.size() > 0) {
      for (
        RestAPI2Domain.GTVAPIProduct compatibleProducts : compatibleProductResponse
      ) {
        compatibleProductEidList.add(compatibleProducts.id);
      }
    }
    //compatibleProductOptions.add(new SelectOption('', 'Choose One'));
    if (
      TRACTAPIUtil.checkFieldLevelSecurity(
        'Product2',
        'Id, name, eid__c, ProductCode, Price_Information__c',
        'Query'
      )
    ) {
      for (Product2 proCode : [
        SELECT
          Id,
          name,
          eid__c,
          maxServiceResources__c,
          minServiceResources__c,
          ProductCode,
          Price_Information__c,
          Agreement_Information__c,
          Requires_Agreement__c,
          SRC_eid__c,
          Short_Desc__c
        FROM Product2
        WHERE eid__c IN :compatibleProductEidList
      ]) {
        MapofProductIdVsProduct.put(proCode.eid__c, proCode);
        //if(proCode.eid__c == CurrentProductId){
        //    compatibleProductOptions.add(0,new SelectOption(proCode.eid__c, String.valueOf(proCode.name)));
        //}
        //else{
        compatibleProductOptions.add(
          new SelectOption(proCode.eid__c, String.valueOf(proCode.name))
        );
        //}
        List<SelectOption> recurrencePeriodList = new List<SelectOption>();
        List<SelectOption> OneTimePrices = new List<SelectOption>();
        for (
          ProductPriceWrapper productPriceObj : (list<ProductPriceWrapper>) JSON.deserialize(
            procode.Price_Information__c,
            list<ProductPriceWrapper>.class
          )
        ) {
          if (
            productPriceObj.currencyType == currencyType &&
            productPriceObj.priceType == 'Recurring' &&
            productPriceObj.priceListEid == changeOrderWrapper.priceListId
          ) {
            if (productPriceObj.thruDate != null) {
              Date myDate = date.newinstance(
                productPriceObj.thruDate.year(),
                productPriceObj.thruDate.month(),
                productPriceObj.thruDate.day()
              );
              if (myDate > Date.Today()) {
                MapofProductPriceEidVsPriceOverrideFlag.put(
                  productPriceObj.eid,
                  productPriceObj.priceOverride
                );
                mapOfProductPriceEidVsPriceRangeList.put(
                  productPriceObj.eid,
                  new List<ProductPriceRangeWrapper>()
                );
                for (
                  ProductPriceRangeWrapper productPriceRangeObj : productPriceObj.priceRangesList
                ) {
                  if (productPriceRangeObj.quantityBeginRange == 0.00) {
                    String Price =
                      productPriceObj.recurrencePeriod +
                      '/' +
                      String.valueOf(productPriceRangeObj.price);
                    recurrencePeriodList.add(
                      new SelectOption(productPriceObj.eid, Price)
                    );
                  }
                  mapOfProductPriceEidVsPriceRangeList.get(productPriceObj.eid)
                    .add(productPriceRangeObj);
                }
              }
            } else if (productPriceObj.thruDate == null) {
              MapofProductPriceEidVsPriceOverrideFlag.put(
                productPriceObj.eid,
                productPriceObj.priceOverride
              );
              mapOfProductPriceEidVsPriceRangeList.put(
                productPriceObj.eid,
                new List<ProductPriceRangeWrapper>()
              );
              for (
                ProductPriceRangeWrapper productPriceRangeObj : productPriceObj.priceRangesList
              ) {
                if (productPriceRangeObj.quantityBeginRange == 0.00) {
                  String Price =
                    productPriceObj.recurrencePeriod +
                    '/' +
                    String.valueOf(productPriceRangeObj.price);
                  recurrencePeriodList.add(
                    new SelectOption(productPriceObj.eid, Price)
                  );
                }
                mapOfProductPriceEidVsPriceRangeList.get(productPriceObj.eid)
                  .add(productPriceRangeObj);
              }
            }
            productIdToRecurrenceProductPriceMap.put(
              proCode.eid__c,
              recurrencePeriodList
            );
          }
          if (
            productPriceObj.priceListEid == changeOrderWrapper.priceListId &&
            (productPriceObj.priceType == 'OneTime' ||
            productPriceObj.priceType == 'one-time') &&
            productPriceObj.currencyType == currencyType
          ) {
            MapofProductPriceEidVsPriceOverrideFlag.put(
              productPriceObj.eid,
              productPriceObj.priceOverride
            );
            mapOfProductPriceEidVsPriceRangeList.put(
              productPriceObj.eid,
              new List<ProductPriceRangeWrapper>()
            );
            for (
              ProductPriceRangeWrapper productPriceRangeObj : productPriceObj.priceRangesList
            ) {
              if (productPriceRangeObj.quantityBeginRange == 0.00) {
                String Price =
                  'One-Time /' + String.valueOf(productPriceRangeObj.price);
                OneTimePrices.add(new SelectOption(productPriceObj.eid, Price));
              }
              mapOfProductPriceEidVsPriceRangeList.get(productPriceObj.eid)
                .add(productPriceRangeObj);
            }
            productIdToOneTimeProductPriceMap.put(
              proCode.eid__c,
              OneTimePrices
            );
          }
        }
        if (proCode.Agreement_Information__c != null) {
          Agreementwrapper agreementWrapper = getProductAgreement(
            proCode.Agreement_Information__c,
            currencyType,
            proCode.Requires_Agreement__c
          );
          MapOfProductIdVsAgreementWrapper.put(
            proCode.eid__c,
            agreementWrapper
          );
        }
      }
    }
    changeOrderWrapper.compatibleProductList = compatibleProductOptions;
    changeOrderWrapper.MapOfProductIdVsRecurrencePriceList = productIdToRecurrenceProductPriceMap;
    changeOrderWrapper.MapOfProductIdVsOneTimePriceList = productIdToOneTimeProductPriceMap;
    changeOrderWrapper.MapofProductPriceEidVsPriceOverrideFlag = MapofProductPriceEidVsPriceOverrideFlag;
    changeOrderWrapper.mapOfProductPriceEidVsPriceRangeList = mapOfProductPriceEidVsPriceRangeList;
    changeOrderWrapper.MapofProductEidVsSerializedFlag = MapofProductEidVsSerializedFlag;
    changeOrderWrapper.MapOfProductIdVsAgreementWrapper = MapOfProductIdVsAgreementWrapper;
    changeOrderWrapper.MapofProductIdVsProduct = MapofProductIdVsProduct;
    if (
      productIdToRecurrenceProductPriceMap.containsKey(
        changeOrderWrapper.CurrentProductId
      )
    ) {
      List<SelectOption> recurrencePriceList = productIdToRecurrenceProductPriceMap.get(
        changeOrderWrapper.CurrentProductId
      );
      if (recurrencePriceList.size() > 0) {
        changeOrderWrapper.RecurringpriceId = recurrencePriceList[0].getValue();
        changeOrderWrapper.Recurringprice = mapOfProductPriceEidVsPriceRangeList.get(
            changeOrderWrapper.RecurringpriceId
          )[0]
          .price;
        changeOrderWrapper.totalPrice = changeOrderWrapper.Recurringprice;
      }
    }
    if (
      productIdToOneTimeProductPriceMap.containsKey(
        changeOrderWrapper.CurrentProductId
      )
    ) {
      List<SelectOption> oneTimePriceList = productIdToOneTimeProductPriceMap.get(
        changeOrderWrapper.CurrentProductId
      );
      if (oneTimePriceList.size() > 0) {
        changeOrderWrapper.OneTimePriceId = oneTimePriceList[0].getValue();
        changeOrderWrapper.OneTimePrice = mapOfProductPriceEidVsPriceRangeList.get(
            changeOrderWrapper.OneTimePriceId
          )[0]
          .price;
        changeOrderWrapper.totalPrice += changeOrderWrapper.OneTimePrice;
      }
    }
    return changeOrderWrapper;
  }

  public static Agreementwrapper getProductAgreement(
    String AgreementInformation,
    String currencyType,
    boolean requireAgreement
  ) {
    Agreementwrapper agreementWrap = new Agreementwrapper();
    Map<String, Decimal> mapOfAgreementPeriod = new Map<String, Decimal>();
    Map<String, String> mapOfAgreementPeriodType = new Map<String, String>();
    Map<String, String> mapOfAgreementIdVsAgreementEndAction = new Map<String, String>();
    List<SelectOption> agreementOption = new List<SelectOption>();
    List<SelectOption> renewActionList = new List<SelectOption>();
    List<SelectOption> nextRenewActionList = new List<SelectOption>();
    list<ProductAgreementWrapper> agreementList = new List<ProductAgreementWrapper>();
    List<SelectOption> nextAgreementOption = new List<SelectOption>();
    List<SelectOption> renewalPricingOption = new List<SelectOption>();
    renewalPricingOption.add(
      new SelectOption('Product Price', 'Product Price')
    );
    renewalPricingOption.add(
      new SelectOption('Service Price', 'Service Price')
    );
    nextAgreementOption.add(new SelectOption(' ', '--Choose One--'));
    list<ProductAgreementWrapper> listofAgreements = (list<ProductAgreementWrapper>) JSON.deserialize(
      AgreementInformation,
      list<ProductAgreementWrapper>.class
    );
    if (null != listofAgreements) {
      for (ProductAgreementWrapper agInstance : listofAgreements) {
        if (agInstance.currencyType == currencyType) {
          agreementList.add(agInstance);
        }
      }
    }
    if (agreementList.size() > 0) {
      //if(!requireAgreement){
      agreementOption.add(new SelectOption(' ', '--None--'));
      //}
      for (ProductAgreementWrapper ag : agreementList) {
        if (ag.currencyType == currencyType) {
          agreementOption.add(
            new SelectOption(
              ag.eid,
              ag.name +
              ' [Termination-' +
              ag.terminationFlatCharge +
              ']'
            )
          );
          nextAgreementOption.add(new SelectOption(ag.eid, ag.name));
          mapOfAgreementPeriod.put(ag.eid, ag.agreementPeriod);
          mapOfAgreementPeriodType.put(
            ag.eid,
            TractSFDC_Util.convertToCamelCase(ag.agreementPeriodType, ' ')
          );
          mapOfAgreementIdVsAgreementEndAction.put(ag.eid, ag.endAction);
        }
      }
      renewActionList.add(new SelectOption(' ', '--Choose One--'));
      nextRenewActionList.add(new SelectOption(' ', '--Choose One--'));
      for (
        TractSFDC_Util.AgreementEndAction endAction : TractSFDC_Util.AgreementEndAction.values()
      ) {
        if (endAction.name() != 'CHANGE_AGREEMENT') {
          renewActionList.add(
            new SelectOption(
              endAction.name(),
              TractSFDC_Util.convertToCamelCase(endAction.name(), '_')
            )
          );
          nextRenewActionList.add(
            new SelectOption(
              endAction.name(),
              TractSFDC_Util.convertToCamelCase(endAction.name(), '_')
            )
          );
        }
      }
    }

    agreementWrap.agreementList = agreementOption;
    agreementWrap.renewAction = renewActionList;
    agreementWrap.mapOfAgreementPeriod = mapOfAgreementPeriod;
    agreementWrap.mapOfAgreementPeriodType = mapOfAgreementPeriodType;
    agreementWrap.nextAgreementList = nextAgreementOption;
    agreementWrap.nextRenewAction = nextRenewActionList;
    agreementWrap.renewalPricingOption = renewalPricingOption;
    agreementWrap.mapOfAgreementIdVsAgreementEndAction = mapOfAgreementIdVsAgreementEndAction;
    return agreementWrap;
  }

  public static List<selectOption> parseServiceResource(
    List<RestAPI2Domain.GTVAPIServiceResource> serviceResourceResponse
  ) {
    List<SelectOption> identifierList = new List<SelectOption>();
    for (
      RestAPI2Domain.GTVAPIServiceResource serviceResource : serviceResourceResponse
    ) {
      identifierList.add(
        new SelectOption(serviceResource.identifier, serviceResource.identifier)
      );
    }
    return identifierList;
  }

  public static List<GTVServiceWrapper> parseGTVServices(
    List<RestAPI2Domain.GTVAPISFService> gtvServiceList,
    String currencyType
  ) {
    List<GTVServiceWrapper> gtvServiceWrapList = new List<GTVServiceWrapper>();
    for (RestAPI2Domain.GTVAPISFService serviceWrap : gtvServiceList) {
      GTVServiceWrapper serviceWrapper = new GTVServiceWrapper();
      serviceWrapper.serviceId = serviceWrap.id;
      serviceWrapper.serviceName = serviceWrap.product.name;
      serviceWrapper.productType = serviceWrap.product.productType;
      serviceWrapper.description = serviceWrap.description;
      serviceWrapper.quantity = Integer.valueOf(serviceWrap.quantity);
      serviceWrapper.total =
        TractSFDC_Util.getCurrencySymbole(currencyType) +
        String.valueOf(serviceWrap.amount);
      gtvServiceWrapList.add(serviceWrapper);
    }

    return gtvServiceWrapList;
  }

  public static CreateAccountResponse mapBillingAccountCreationResponse(
    String salesforceAccountId,
    RestAPI2Domain.GTVAPIBillingAccount billingAccountCreationResponse,
    Integer responseCode,
    String responseMessage
  ) {
    CreateAccountResponse accountResponse = new CreateAccountResponse();
    accountResponse.responseMessage = responseMessage;
    accountResponse.salesforceAccountId = salesforceAccountId;
    accountResponse.responseSuccess = true;
    accountResponse.responseCode = responseCode;
    accountResponse.gtvAccountId = billingAccountCreationResponse.id;
    accountResponse.gtvAccountNumber = billingAccountCreationResponse.accountNum;
    return accountResponse;
  }

  public static CreateOrderResponse mapSalesOrderCreationResponse(
    String salesforceAccountId,
    RestAPI2Domain.GTVAPIOrder orderCreationResponse,
    Integer responseCode,
    String responseMessage,
    String gtvAccountId
  ) {
    CreateOrderResponse orderResponse = new CreateOrderResponse();
    orderResponse.responseMessage = responseMessage;
    orderResponse.salesforceAccountId = salesforceAccountId;
    orderResponse.responseSuccess = true;
    orderResponse.responseCode = responseCode;
    orderResponse.gtvOrderId = orderCreationResponse.id;
    orderResponse.gtvOrderNumber = orderCreationResponse.orderNum;
    orderResponse.gtvAccountId = gtvAccountId;
    return orderResponse;
  }

  public static QueryServiceResourceCategoryIdResponse mapServiceCategoryResponse(
    List<RestAPI2Domain.GTVAPIResourceCategory> resourceCategories,
    Integer responseCode,
    String responseMessage
  ) {
    QueryServiceResourceCategoryIdResponse categoryIdResponse = new QueryServiceResourceCategoryIdResponse();
    if (null != resourceCategories && !resourceCategories.isEmpty()) {
      categoryIdResponse.serviceResourceCategoryId = resourceCategories[0].id;
    }
    categoryIdResponse.responseMessage = responseMessage;
    categoryIdResponse.responseSuccess = true;
    categoryIdResponse.responseCode = responseCode;
    return categoryIdResponse;
  }

  public static queryServiceResourceResponse mapExistingServiceResourceResponse(
    List<RestAPI2Domain.GTVAPIServiceResource> serviceResources,
    Integer responseCode,
    String responseMessage
  ) {
    QueryServiceResourceResponse serviceResourceResponse = new QueryServiceResourceResponse();
    serviceResourceResponse.serviceResourceList = new List<GTVServiceResource>();
    if (null != serviceResources && !serviceResources.isEmpty()) {
      for (
        RestAPI2Domain.GTVAPIServiceResource serviceResource : serviceResources
      ) {
        GTVServiceResource gtvServiceResource = new GTVServiceResource();
        gtvServiceResource.id = serviceResource.id;
        gtvServiceResource.identifier = serviceResource.identifier;
        gtvServiceResource.description = serviceResource.description;
        if (serviceResource.category != null) {
          gtvServiceResource.resourceCategoryId = serviceResource.category.id;
        }
        serviceResourceResponse.serviceResourceList.add(gtvServiceResource);
      }
    }
    serviceResourceResponse.responseMessage = responseMessage;
    serviceResourceResponse.responseSuccess = true;
    serviceResourceResponse.responseCode = responseCode;
    return serviceResourceResponse;
  }

  public static QueryDiscountIdentifierResponse mapdiscountIdentifierResponse(
    List<RestAPI2Domain.GTVAPIDiscountCode> discountCodes,
    Integer responseCode,
    String responseMessage
  ) {
    QueryDiscountIdentifierResponse discountIdentifierResponse = new QueryDiscountIdentifierResponse();
    discountIdentifierResponse.discountIdentifierList = new List<String>();
    if (null != discountCodes && !discountCodes.isEmpty()) {
      for (RestAPI2Domain.GTVAPIDiscountCode discountCode : discountCodes) {
        discountIdentifierResponse.discountIdentifierList.add(
          discountCode.Name
        );
      }
    }
    discountIdentifierResponse.responseMessage = responseMessage;
    discountIdentifierResponse.responseSuccess = true;
    discountIdentifierResponse.responseCode = responseCode;
    return discountIdentifierResponse;
  }

  public static QueryDiscountResourceIdResponse mapdiscountResourceIdResponse(
    List<RestAPI2Domain.GTVAPIDiscountResource> discountResources,
    Integer responseCode,
    String responseMessage
  ) {
    QueryDiscountResourceIdResponse discountResourceIdResponse = new QueryDiscountResourceIdResponse();
    discountResourceIdResponse.responseMessage = responseMessage;
    if (null != discountResources && !discountResources.isEmpty()) {
      discountResourceIdResponse.discountResourceId = discountResources[0].id;
    }
    discountResourceIdResponse.responseSuccess = true;
    discountResourceIdResponse.responseCode = responseCode;
    return discountResourceIdResponse;
  }

  public static QueryUsageChargeCategoriesResposne mapUsageChargeCategoryResponse(
    List<RestAPI2Domain.GTVAPIChargeCategory> usageChargeCategories,
    Integer responseCode,
    String responseMessage
  ) {
    QueryUsageChargeCategoriesResposne usageChargeCategoriesResponse = new QueryUsageChargeCategoriesResposne();
    usageChargeCategoriesResponse.usageChargeCategoryList = new List<GTVUsageChargeCategory>();
    if (null != usageChargeCategories && !usageChargeCategories.isEmpty()) {
      for (
        RestAPI2Domain.GTVAPIChargeCategory usageChargeCategory : usageChargeCategories
      ) {
        GTVUsageChargeCategory chargeCategory = new GTVUsageChargeCategory();
        chargeCategory.id = usageChargeCategory.id;
        chargeCategory.name = usageChargeCategory.name;
        usageChargeCategoriesResponse.usageChargeCategoryList.add(
          chargeCategory
        );
      }
    }
    usageChargeCategoriesResponse.responseMessage = responseMessage;
    usageChargeCategoriesResponse.responseSuccess = true;
    usageChargeCategoriesResponse.responseCode = responseCode;
    return usageChargeCategoriesResponse;
  }

  public static QueryServiceCustomFieldResponse mapServiceCustomFieldsResponse(
    List<RestAPI2Domain.GTVAPIServiceCustomField> serviceCustomFields,
    Integer responseCode,
    String responseMessage
  ) {
    QueryServiceCustomFieldResponse serviceCustomFieldResponse = new QueryServiceCustomFieldResponse();
    serviceCustomFieldResponse.serviceCustomFieldList = new List<GTVServiceCustomField>();
    if (null != serviceCustomFields && !serviceCustomFields.isEmpty()) {
      for (
        RestAPI2Domain.GTVAPIServiceCustomField serviceCustomField : serviceCustomFields
      ) {
        GTVServiceCustomField gtvServiceCustomField = new GTVServiceCustomField();
        gtvServiceCustomField.id = serviceCustomField.id;
        gtvServiceCustomField.name = serviceCustomField.name;
        gtvServiceCustomField.fieldType = serviceCustomField.fieldType;
        gtvServiceCustomField.fieldValidationType = serviceCustomField.fieldValidationType;
        if (
          serviceCustomField.references != null &&
          serviceCustomField.references.size() > 0
        ) {
          gtvServiceCustomField.refrences = new List<GTVServiceCustomField.GTVCustomFieldRefrence>();
          for (
            RestAPI2Domain.GTVAPICustomFieldValueReference refrence : serviceCustomField.references
          ) {
            GTVServiceCustomField.GTVCustomFieldRefrence customFieldRefrence = new GTVServiceCustomField.GTVCustomFieldRefrence();
            customFieldRefrence.id = refrence.id;
            customFieldRefrence.status = refrence.status.name();
            customFieldRefrence.value = refrence.value;
            gtvServiceCustomField.refrences.add(customFieldRefrence);
          }
        }
        serviceCustomFieldResponse.serviceCustomFieldList.add(
          gtvServiceCustomField
        );
      }
    }
    serviceCustomFieldResponse.responseMessage = responseMessage;
    serviceCustomFieldResponse.responseSuccess = true;
    serviceCustomFieldResponse.responseCode = responseCode;
    return serviceCustomFieldResponse;
  }

  public static QueryOrderCustomFieldResponse mapOrderCustomFieldsResponse(
    List<RestAPI2Domain.GTVAPIOrderCustomField> orderCustomFields,
    Integer responseCode,
    String responseMessage
  ) {
    QueryOrderCustomFieldResponse orderCustomFieldResponse = new QueryOrderCustomFieldResponse();
    orderCustomFieldResponse.orderCustomFieldList = new List<GTVOrderCustomField>();
    if (null != orderCustomFields && !orderCustomFields.isEmpty()) {
      for (
        RestAPI2Domain.GTVAPIOrderCustomField orderCustomField : orderCustomFields
      ) {
        GTVOrderCustomField gtvOrderCustomField = new GTVOrderCustomField();
        gtvOrderCustomField.id = orderCustomField.id;
        gtvOrderCustomField.name = orderCustomField.name;
        gtvOrderCustomField.fieldType = orderCustomField.fieldType;
        gtvOrderCustomField.fieldValidationType = orderCustomField.fieldValidationType;
        if (
          orderCustomField.references != null &&
          orderCustomField.references.size() > 0
        ) {
          gtvOrderCustomField.refrences = new List<GTVOrderCustomField.GTVCustomFieldRefrence>();
          for (
            RestAPI2Domain.GTVAPICustomFieldValueReference refrence : orderCustomField.references
          ) {
            GTVOrderCustomField.GTVCustomFieldRefrence customFieldRefrence = new GTVOrderCustomField.GTVCustomFieldRefrence();
            customFieldRefrence.id = refrence.id;
            customFieldRefrence.status = refrence.status.name();
            customFieldRefrence.value = refrence.value;
            gtvOrderCustomField.refrences.add(customFieldRefrence);
          }
        }
        orderCustomFieldResponse.orderCustomFieldList.add(gtvOrderCustomField);
      }
    }
    orderCustomFieldResponse.responseMessage = responseMessage;
    orderCustomFieldResponse.responseSuccess = true;
    orderCustomFieldResponse.responseCode = responseCode;
    return orderCustomFieldResponse;
  }

  public static QueryRateTableResponse mapRateTableResponse(
    List<RestAPI2Domain.GTVAPIRateTable> rateTables,
    Integer responseCode,
    String responseMessage
  ) {
    QueryRateTableResponse rateTableResponse = new QueryRateTableResponse();
    rateTableResponse.rateTableList = new List<GTVRateTable>();
    if (null != rateTables && !rateTables.isEmpty()) {
      for (RestAPI2Domain.GTVAPIRateTable rateTable : rateTables) {
        GTVRateTable gtvRateTable = new GTVRateTable();
        gtvRateTable.id = rateTable.id;
        gtvRateTable.name = rateTable.name;
        gtvRateTable.uom = rateTable.uom;
        rateTableResponse.rateTableList.add(gtvRateTable);
      }
    }
    rateTableResponse.responseMessage = responseMessage;
    rateTableResponse.responseSuccess = true;
    rateTableResponse.responseCode = responseCode;
    return rateTableResponse;
  }

  public static QueryParentServiceResponse mapParentServiceResponse(
    List<RestAPI2Domain.GTVAPISFService> services,
    Set<String> parentProductIdSet,
    Integer responseCode,
    String responseMessage
  ) {
    QueryParentServiceResponse parentServiceResponse = new QueryParentServiceResponse();
    parentServiceResponse.parentServiceList = new List<GTVParentService>();
    if (null != services && !services.isEmpty()) {
      for (RestAPI2Domain.GTVAPISFService service : services) {
        if (parentProductIdSet.contains(service.product.id)) {
          System.debug('service.product.id:::::' + service.product.id);
          GTVParentService parentService = new GTVParentService();
          parentService.id = service.id;
          parentService.name =
            service.product.name +
            ' Start Date: ' +
            service.endDate.format();
          parentServiceResponse.parentServiceList.add(parentService);
        }
      }
    }
    parentServiceResponse.responseMessage = responseMessage;
    parentServiceResponse.responseSuccess = true;
    parentServiceResponse.responseCode = responseCode;
    return parentServiceResponse;
  }
}