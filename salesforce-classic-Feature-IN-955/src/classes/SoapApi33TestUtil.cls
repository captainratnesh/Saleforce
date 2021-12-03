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
 * This class is the util class for providing fake responses for SOAP API callouts.
 * @author AMAN JAIN
 */

public with sharing class SoapApi33TestUtil {
  /**
   * @description: This method is used to get Dummy billing Accounts for test cases
   * @return SoapApi33Domain.QueryResponse, The instance of SoapApi33Domain.QueryResponse class.
   */
  public static SoapApi33Domain.QueryResponse getBillingAccounts() {
    SoapApi33Domain.QueryResponse qr = new SoapApi33Domain.QueryResponse();
    qr.successful = true;
    SoapApi33Domain.BillingAccount ba1 = new SoapApi33Domain.BillingAccount();
    ba1.Person = new SoapApi33Domain.Person();
    ba1.Person.addresses = new SoapApi33Domain.addresses_element();
    ba1.Person.addresses.postalAddress = new List<SoapApi33Domain.PostalAddress>();
    SoapApi33Domain.PostalAddress paddress = new SoapApi33Domain.PostalAddress();
    paddress.purpose = 'SHIPPING';
    ba1.Person.addresses.emailAddress = new List<SoapApi33Domain.EmailAddress>();
    SoapApi33Domain.EmailAddress emddress = new SoapApi33Domain.EmailAddress();
    emddress.purpose = 'PRIMARY';
    SoapApi33Domain.PostalAddress paddress1 = new SoapApi33Domain.PostalAddress();
    paddress1.purpose = 'BILLING';
    ba1.Person.addresses.postalAddress.add(paddress);
    ba1.Person.addresses.postalAddress.add(paddress1);
    ba1.Person.addresses.emailAddress.add(emddress);
    ba1.accountNum = '12345';
    ba1.eid = '12345';
    ba1.status = 'ACTIVE';
    ba1.balance = 100.00;
    ba1.currencyType = 'USD';
    ba1.billType = 'EMAIL';
    ba1.startDate = String.valueOf(system.today());
    ba1.externalAccountNum = '201302';
    SoapApi33Domain.BillingAccountCategory billingAccountCategory = new SoapApi33Domain.BillingAccountCategory();
    billingAccountCategory.type_x = 'All Accounts';
    billingAccountCategory.description = 'Default billing account category';
    billingAccountCategory.status = 'BA_CATEGORY_ACTIVE';
    billingAccountCategory.eid = '277';
    ba1.billingAccountCategory = billingAccountCategory;
    SoapApi33Domain.DailyBillCycle dailyBillCycle = new SoapApi33Domain.DailyBillCycle();
    dailyBillCycle.name = 'Dail BillCycle';
    ba1.dailyBillCycle = dailyBillCycle;
    SoapApi33Domain.QuarterlyBillCycle quarterBillCycle1 = new SoapApi33Domain.QuarterlyBillCycle();
    SoapApi33Domain.YearlyBillCycle yearBillCycle = new SoapApi33Domain.YearlyBillCycle();
    yearBillCycle.name = 'Quarter BillCycle';
    ba1.yearlyBillCycle = yearBillCycle;
    SoapApi33Domain.SegmentedMonthlyBillCycle segmentBillCycle = new SoapApi33Domain.SegmentedMonthlyBillCycle();
    segmentBillCycle.name = 'Quarter BillCycle';
    ba1.segmentedMonthlyBillCycle = segmentBillCycle;
    SoapApi33Domain.monthlyBillCycle monthBillCycle = new SoapApi33Domain.monthlyBillCycle();
    dailyBillCycle.name = 'Month BillCycle';
    dailyBillCycle.eid = 'Month BillCycle';
    dailyBillCycle.startDate = Date.valueOf('2014-8-9');
    dailyBillCycle.endDate = Date.valueOf('2016-8-9');
    dailyBillCycle.billCycleType = 'Month BillCycle';
    dailyBillCycle.autoBill = true;
    ba1.monthlyBillCycle = monthBillCycle;
    ba1.organization = new SoapApi33Domain.Organization();
    ba1.organization.addresses = new SoapApi33Domain.addresses_element();
    ba1.organization.addresses.emailAddress = new List<SoapApi33Domain.EmailAddress>();
    SoapApi33Domain.EmailAddress emailAddresses = new SoapApi33Domain.EmailAddress();
    emailAddresses.purpose = 'PRIMARY';
    ba1.organization.addresses.emailAddress.add(emailAddresses);
    SoapApi33Domain.PostalAddress[] postalAddresses = new List<SoapApi33Domain.PostalAddress>();
    SoapApi33Domain.PostalAddress billingAddress = new SoapApi33Domain.PostalAddress();
    billingAddress.purpose = 'BILLING';
    billingAddress.country = 'USA';
    billingAddress.city = 'Austin';
    billingAddress.regionOrState = 'TX';
    billingAddress.attention = 'Wiley Coyote';
    billingAddress.postalCode = '13345';
    billingAddress.line1 = '133 1st Ave.';
    postalAddresses.add(billingAddress);
    SoapApi33Domain.PostalAddress shippingAddress = new SoapApi33Domain.PostalAddress();
    shippingAddress.purpose = 'SHIPPING';
    shippingAddress.country = 'USA';
    shippingAddress.city = 'Austin';
    shippingAddress.regionOrState = 'TX';
    shippingAddress.attention = 'Wiley Coyote';
    shippingAddress.postalCode = '13345';
    shippingAddress.line1 = '133 1st Ave. 1';
    postalAddresses.add(shippingAddress);
    SoapApi33Domain.PostalAddress shippingAddress1 = new SoapApi33Domain.PostalAddress();
    shippingAddress1.purpose = 'BILLING';
    shippingAddress1.country = 'USA';
    shippingAddress1.city = 'Austin';
    shippingAddress1.regionOrState = 'TX';
    shippingAddress1.attention = 'Wiley Coyote';
    shippingAddress1.postalCode = '13345';
    shippingAddress1.line1 = '133 1st Ave. 1';
    postalAddresses.add(shippingAddress1);
    ba1.organization.addresses.postalAddress = postalAddresses;
    ba1.organization.addresses.emailAddress = new List<SoapApi33Domain.EmailAddress>();
    SoapApi33Domain.EmailAddress emailAdrsO = new SoapApi33Domain.EmailAddress();
    emailAdrsO.email = 'test@algo.com';
    emailAdrsO.purpose = 'PRIMARY';
    ba1.organization.addresses.emailAddress.add(emailAdrsO);
    SoapApi33Domain.BillingAccounts bass = new SoapApi33Domain.BillingAccounts();
    bass.billingAccount = new List<SoapApi33Domain.BillingAccount>{ ba1 };
    qr.billingAccounts = bass;
    return qr;
  }
  /**
   * @description: This method is used to get Dummy Services for test cases
   * @return SoapApi33Domain.QueryResponse, The instance of SoapApi33Domain.QueryResponse class.
   */
  public static SoapApi33Domain.QueryResponse getServices() {
    SoapApi33Domain.QueryResponse qr = new SoapApi33Domain.QueryResponse();
    qr.successful = true;
    qr.services = new SoapApi33Domain.Services();
    qr.services.totalPages = 1;
    qr.services.service = new List<SoapApi33Domain.Service>();
    SoapApi33Domain.addresses_element addresses = new SoapApi33Domain.addresses_element();
    SoapApi33Domain.PostalAddress[] postalAddresses = new List<SoapApi33Domain.PostalAddress>();
    SoapApi33Domain.PostalAddress billingAddress = new SoapApi33Domain.PostalAddress();
    billingAddress.purpose = 'BILLING';
    billingAddress.country = 'USA';
    billingAddress.city = 'Austin';
    billingAddress.regionOrState = 'TX';
    billingAddress.attention = 'Wiley Coyote';
    billingAddress.postalCode = '13345';
    billingAddress.line1 = '133 1st Ave.';
    postalAddresses.add(billingAddress);
    addresses.postalAddress = postalAddresses;
    SoapApi33Domain.Service activeService = new SoapApi33Domain.Service();
    SoapApi33Domain.ProductPrices productPrice = new SoapApi33Domain.ProductPrices();
    productPrice.OneTimeProductPrice = new List<SoapApi33Domain.OneTimeProductPrice>();
    SoapApi33Domain.Product product = new SoapApi33Domain.Product();
    product.productTypeCode = 'ADDON';
    product.eid = '12345';
    product.serviceResourceCategory = new SoapApi33Domain.ServiceResourceCategory();
    product.productPrices = productPrice;
    activeService.product = product;
    activeService.eid = '';
    SoapApi33Domain.Service parentService = new SoapApi33Domain.Service();
    parentService.eid = '12345';
    activeService.parentService = parentService;
    activeService.billingAccount = getTractBillingAccount();
    activeService.description = 'Simple Subscription';
    activeService.amount = 50.00;
    activeService.status = 'SERVICE_ACTIVE';
    activeService.startDate = System.now();
    activeService.endDate = System.now().addMonths(1);
    activeService.billingAccount = getTractBillingAccount();
    activeService.description = 'Simple Subscription';
    activeService.amount = 50.00;
    activeService.status = 'SERVICE_ACTIVE';
    activeService.startDate = System.now();
    activeService.endDate = System.now().addMonths(1);
    activeService.addresses = addresses;
    SoapApi33Domain.Service activeService1 = new SoapApi33Domain.Service();
    SoapApi33Domain.ProductPrices productPrice1 = new SoapApi33Domain.ProductPrices();
    productPrice1.OneTimeProductPrice = new List<SoapApi33Domain.OneTimeProductPrice>();
    SoapApi33Domain.Product product2 = new SoapApi33Domain.Product();
    product2.productTypeCode = 'ADDON';
    product2.eid = '35299';
    product2.serviceResourceCategory = new SoapApi33Domain.ServiceResourceCategory();
    product2.productPrices = productPrice1;
    activeService1.product = product2;
    activeService1.parentService = parentService;
    activeService1.billingAccount = getTractBillingAccount();
    activeService1.description = 'Simple Subscription';
    activeService1.amount = 50.00;
    activeService1.status = 'SERVICE_ACTIVE';
    activeService1.startDate = System.now();
    activeService1.endDate = System.now().addMonths(1);
    activeService1.billingAccount = getTractBillingAccount();
    activeService1.description = 'Simple Subscription';
    activeService1.amount = 50.00;
    activeService1.status = 'SERVICE_ACTIVE';
    activeService1.startDate = System.now();
    activeService1.endDate = System.now().addMonths(1);
    activeService1.addresses = addresses;
    SoapApi33Domain.Service deactivatedService = new SoapApi33Domain.Service();
    deactivatedService.billingAccount = getTractBillingAccount();
    deactivatedService.description = 'Simple Subscription';
    deactivatedService.amount = 50.00;
    deactivatedService.status = 'SERVICE_DEACTIVATED';
    deactivatedService.startDate = System.now().addMonths(-1);
    deactivatedService.endDate = System.now();
    deactivatedService.billingAccount = getTractBillingAccount();
    deactivatedService.description = 'Simple Subscription';
    deactivatedService.amount = 50.00;
    deactivatedService.status = 'SERVICE_DEACTIVATED';
    deactivatedService.startDate = System.now().addMonths(-1);
    deactivatedService.endDate = System.now();
    deactivatedService.addresses = addresses;
    SoapApi33Domain.Product product1 = new SoapApi33Domain.Product();
    product1.productTypeCode = 'ADDON';
    product1.productPrices = productPrice;
    deactivatedService.product = product1;
    SoapApi33Domain.Service parentService1 = new SoapApi33Domain.Service();
    parentService1.eid = '12345';
    deactivatedService.parentService = parentService1;
    SoapApi33Domain.Service activeService2 = new SoapApi33Domain.Service();
    parentService1.eid = '';
    deactivatedService.parentService = activeService2;
    qr.services.service.add(activeService);
    qr.services.service.add(activeService1);
    qr.services.service.add(deactivatedService);
    return qr;
  }
  /**
   * @description: This method is used to get Dummy Payments for test cases
   * @return SoapApi33Domain.QueryResponse, The instance of SoapApi33Domain.QueryResponse class.
   */
  public static SoapApi33Domain.QueryResponse getPayments() {
    SoapApi33Domain.QueryResponse qr = new SoapApi33Domain.QueryResponse();
    qr.successful = true;
    qr.Payments = new SoapApi33Domain.Payments();
    qr.Payments.payment = new List<SoapApi33Domain.Payment>();
    SoapApi33Domain.Payment p1 = new SoapApi33Domain.Payment();
    p1.cashPayment = new SoapApi33Domain.CashPaymentMethod();
    p1.amount = 32;
    p1.description = '329332323';
    p1.occurredOn = System.Now();
    p1.status = 'Completed';
    p1.invoicesPaid = '12, 24';
    p1.amount = 32;
    p1.description = '329332323';
    p1.occurredOn = System.Now();
    p1.status = 'Completed';
    p1.invoicesPaid = '12, 24';
    SoapApi33Domain.Payment p2 = new SoapApi33Domain.Payment();
    p2.bankPayment = new SoapApi33Domain.BankPaymentMethod();
    p2.amount = 32;
    p2.description = '329332323';
    p2.occurredOn = System.Now();
    p2.status = 'Completed';
    p2.invoicesPaid = '36, 48';
    p2.amount = 32;
    p2.description = '329332323';
    p2.occurredOn = System.Now();
    p2.status = 'Completed';
    p2.invoicesPaid = '36, 48';
    SoapApi33Domain.Payment p3 = new SoapApi33Domain.Payment();
    p3.creditCardPayment = new SoapApi33Domain.CreditCardPaymentMethod();
    p3.amount = 32;
    SoapApi33Domain.Payment p4 = new SoapApi33Domain.Payment();
    p4.checkPayment = new SoapApi33Domain.CheckPaymentMethod();
    p4.amount = 32;
    SoapApi33Domain.Payment p5 = new SoapApi33Domain.Payment();
    p5.payPalPayment = new SoapApi33Domain.PayPalPaymentMethod();
    p5.amount = 32;
    SoapApi33Domain.Payment p6 = new SoapApi33Domain.Payment();
    p6.wireTransferPayment = new SoapApi33Domain.WireTransferPaymentMethod();
    p6.amount = 32;
    SoapApi33Domain.Payment p7 = new SoapApi33Domain.Payment();
    p7.referencedCreditCardPayment = new SoapApi33Domain.ReferencedCreditCardPaymentMethod();
    p7.amount = 33;
    qr.payments.payment.add(p1);
    qr.payments.payment.add(p2);
    qr.payments.payment.add(p3);
    qr.payments.payment.add(p4);
    qr.payments.payment.add(p5);
    qr.payments.payment.add(p6);
    qr.payments.payment.add(p7);
    return qr;
  }
  /**
   * @description: This method is used to get Dummy Payment Terms for test cases
   * @return SoapApi33Domain.QueryResponse, The instance of SoapApi33Domain.QueryResponse class.
   */
  public static SoapApi33Domain.QueryResponse getPaymentTerms() {
    SoapApi33Domain.QueryResponse qr = new SoapApi33Domain.QueryResponse();
    qr.successful = true;
    qr.paymentTerms = new SoapApi33Domain.PaymentTerms();
    qr.paymentTerms.paymentTerm = new List<SoapApi33Domain.PaymentTerm>();
    SoapApi33Domain.PaymentTerm p1 = new SoapApi33Domain.PaymentTerm();
    p1.eid = '1';
    p1.name = '5DaysTerm';
    p1.termDays = 5;
    p1.graceDays = 5;
    SoapApi33Domain.PaymentTerm p2 = new SoapApi33Domain.PaymentTerm();
    p2.eid = '2';
    p2.name = '10DaysTerm';
    p2.termDays = 10;
    p2.graceDays = 10;
    qr.paymentTerms.paymentTerm.add(p1);
    qr.paymentTerms.paymentTerm.add(p2);
    return qr;
  }
  /**
   * @description: This method is used to get Dummy Sales Orders for test cases On basis of specific parameters
   * @return SoapApi33Domain.QueryResponse, The instance of SoapApi33Domain.QueryResponse class.
   */
  public static SoapApi33Domain.QueryResponse getSalesOrders() {
    SoapApi33Domain.QueryResponse qr = new SoapApi33Domain.QueryResponse();
    qr.successful = true;
    qr.salesOrders = new SoapApi33Domain.SalesOrders();
    qr.salesOrders.salesOrder = new List<SoapApi33Domain.SalesOrder>();
    SoapApi33Domain.SalesOrder p1 = new SoapApi33Domain.SalesOrder();
    p1.orderItems = new SoapApi33Domain.OrderItems();
    SoapApi33Domain.Product pro = new SoapApi33Domain.Product();
    pro.Name = 'test';
    SoapApi33Domain.OrderItem orderItem = new SoapApi33Domain.OrderItem();
    orderItem.product = pro;
    orderItem.status = 'ACTIVE';
    orderItem.description = 'test';
    orderItem.quantity = 5;
    orderItem.recurringUnitPrice = 50;
    orderItem.unitPrice = 50;
    SoapApi33Domain.ServiceResources serviceResources = new SoapApi33Domain.ServiceResources();
    serviceResources.ServiceResource = new List<SoapApi33Domain.ServiceResource>();
    SoapApi33Domain.ServiceResource serviceResource1 = new SoapApi33Domain.ServiceResource();
    serviceResource1.identifier = 'identidire';
    serviceResource1.eid = '12345';
    serviceResources.ServiceResource.add(serviceResource1);
    orderItem.serviceResources = serviceResources;
    p1.orderItems.orderItem = new List<SoapApi33Domain.OrderItem>();
    p1.orderItems.orderItem.add(orderItem);
    p1.eid = '32933';
    p1.orderDate = String.valueOf(System.Now());
    p1.purchaseOrderNumber = 'PO1234';
    p1.orderStatus = 'ACTIVE';
    p1.orderNum = 'sadf';
    p1.note = 'asdfasdf';
    p1.billingAccount = getTractBillingAccount();
    qr.salesOrders.salesOrder.add(p1);
    return qr;
  }
  /**
   * @description: This method is used to get Dummy Sales Orders for test cases
   * @return SoapApi33Domain.SalesOrder, The instance of SoapApi33Domain.SalesOrder class.
   */
  public static SoapApi33Domain.SalesOrder getSalesOrders1() {
    SoapApi33Domain.SalesOrder salesorder = new SoapApi33Domain.SalesOrder();
    salesorder.billingAccount = new SoapApi33Domain.BillingAccount();
    salesorder.orderNum = '12345';
    salesorder.billingAccount.accountNum = '12345';
    return salesorder;
  }
  /**
   * @description: This method is used to get Dummy Sales Orders for test cases On basis of specific parameters
   * @return  list of SoapApi33Domain.QueryResponse, list of The instance of SoapApi33Domain.QueryResponse class.
   */
  public static List<SoapApi33Domain.SalesOrder> getSalesOrders2() {
    List<SoapApi33Domain.SalesOrder> listOrder = new List<SoapApi33Domain.SalesOrder>();
    SoapApi33Domain.SalesOrder salesorder = new SoapApi33Domain.SalesOrder();
    SoapApi33Domain.BillingAccount bilingacc = new SoapApi33Domain.BillingAccount();
    bilingacc.accountNum = 'billaccount';
    salesorder.orderNum = '12345';
    salesorder.billingAccount = bilingacc;
    listOrder.add(salesorder);
    return listOrder;
  }

  /**
   * @description: This method is used to get Dummy Invoices for test cases
   * @return SoapApi33Domain.QueryResponse,The instance of SoapApi33Domain.QueryResponse class.
   */
  public static SoapApi33Domain.QueryResponse getInvoices() {
    SoapApi33Domain.QueryResponse qr = new SoapApi33Domain.QueryResponse();
    qr.successful = true;
    qr.invoices = new SoapApi33Domain.Invoices();
    qr.invoices.invoice = new List<SoapApi33Domain.Invoice>();
    qr.invoices.manualInvoice = new List<SoapApi33Domain.Invoice>();
    qr.invoices.onDemandInvoice = new List<SoapApi33Domain.Invoice>();
    SoapApi33Domain.Invoice p1 = new SoapApi33Domain.Invoice();
    p1.invoiceNum = '1234';
    p1.amount = 32;
    p1.amountToPay = 32;
    p1.dueDate = System.today();
    p1.occurredOn = System.Now();
    p1.paidDate = System.today();
    p1.status = 'Active';
    p1.invoiceNum = '1234';
    p1.amount = 32;
    p1.amountToPay = 32;
    p1.dueDate = System.today();
    p1.occurredOn = System.Now();
    p1.paidDate = System.today();
    p1.status = 'Active';
    p1.invoiceItems = getInvoiceItems();
    SoapApi33Domain.Invoice p2 = new SoapApi33Domain.Invoice();
    p2.invoiceNum = '2345';
    p2.amount = 32;
    p2.amountToPay = 32;
    p2.dueDate = System.today();
    p2.occurredOn = System.Now();
    p2.paidDate = System.today();
    p2.status = 'Active';
    p2.invoiceItems = getInvoiceItems();
    qr.invoices.invoice.add(p1);
    qr.invoices.manualInvoice.add(p2);
    qr.invoices.onDemandInvoice.add(p2);
    return qr;
  }
  /**
   * @description: This method is used to get Dummy Payment Application for test cases
   * @return SoapApi33Domain.QueryResponse,The instance of SoapApi33Domain.QueryResponse class.
   */
  public static SoapApi33Domain.QueryResponse getPaymentApplication() {
    SoapApi33Domain.QueryResponse qr = new SoapApi33Domain.QueryResponse();
    qr.successful = true;
    SoapApi33Domain.StandardInvoicePaymentApplication standardInvoicePaymentApplicationObj = new SoapApi33Domain.StandardInvoicePaymentApplication();
    standardInvoicePaymentApplicationObj.payment = getPayments()
      .payments.payment[0];
    standardInvoicePaymentApplicationObj.invoice = getInvoices()
      .invoices.invoice[0];
    SoapApi33Domain.PaymentApplications paymentApplications = new SoapApi33Domain.PaymentApplications();
    paymentApplications.standardInvoicePaymentApplication = new List<SoapApi33Domain.StandardInvoicePaymentApplication>();
    paymentApplications.standardInvoicePaymentApplication.add(
      standardInvoicePaymentApplicationObj
    );
    qr.PaymentApplications = paymentApplications;
    return qr;
  }
  /**
   * @description: This method is used to get Dummy Currencies for test cases
   * @return SoapApi33Domain.QueryResponse,The instance of SoapApi33Domain.QueryResponse class.
   */
  public static SoapApi33Domain.QueryResponse getCurrencies() {
    SoapApi33Domain.QueryResponse qr = new SoapApi33Domain.QueryResponse();
    qr.successful = true;
    qr.currencies = new SoapApi33Domain.Currencies();
    qr.currencies.currency_x = new List<SoapApi33Domain.Currency_x>();
    SoapApi33Domain.Currency_x c1 = new SoapApi33Domain.Currency_x();
    c1.currencyType = 'USD';
    c1.default_x = true;
    c1.name = 'US Dollar';
    c1.numericCode = '840';
    c1.symbol = '$';
    SoapApi33Domain.Currency_x c2 = new SoapApi33Domain.Currency_x();
    c2.currencyType = 'EUR';
    c2.default_x = false;
    c2.name = 'Euro';
    c2.numericCode = '978';
    c2.symbol = '€';
    qr.currencies.currency_x.add(c1);
    qr.currencies.currency_x.add(c2);
    return qr;
  }
  /**
   * @description: This method is used to get Dummy reasons for test cases
   * @return SoapApi33Domain.QueryResponse,The instance of SoapApi33Domain.QueryResponse class.
   */
  public static SoapApi33Domain.QueryResponse getreasons() {
    SoapApi33Domain.QueryResponse qr = new SoapApi33Domain.QueryResponse();
    qr.successful = true;
    qr.reasons = new SoapApi33Domain.reasons();
    qr.reasons.serviceDeactivationReason = new List<SoapApi33Domain.serviceDeactivationReason>();
    SoapApi33Domain.serviceDeactivationReason reason = new SoapApi33Domain.serviceDeactivationReason();
    reason.eid = '12345';
    reason.name = 'reason';
    qr.reasons.serviceDeactivationReason.add(reason);
    qr.reasons.serviceSuspensionReason = new List<SoapApi33Domain.serviceSuspensionReason>();
    SoapApi33Domain.serviceSuspensionReason reason1 = new SoapApi33Domain.serviceSuspensionReason();
    reason1.eid = '12345';
    reason1.name = 'reason';
    qr.reasons.serviceSuspensionReason.add(reason1);
    SoapApi33Domain.SuspensionReason suspensionReason = new SoapApi33Domain.SuspensionReason();
    suspensionReason.name = 'reason';
    suspensionReason.eid = '12345';
    SoapApi33Domain.SuspensionReason suspensionReason1 = new SoapApi33Domain.SuspensionReason();
    suspensionReason1.name = 'reason1';
    suspensionReason1.eid = '123451';
    qr.reasons.suspensionReason = new List<SoapApi33Domain.SuspensionReason>();
    qr.reasons.suspensionReason.add(suspensionReason);
    qr.reasons.suspensionReason.add(suspensionReason1);
    SoapApi33Domain.DeactivationReason deactivationReason = new SoapApi33Domain.DeactivationReason();
    deactivationReason.name = 'reason';
    deactivationReason.eid = '12345';
    SoapApi33Domain.DeactivationReason deactivationReason1 = new SoapApi33Domain.DeactivationReason();
    deactivationReason1.name = 'reason1';
    deactivationReason1.eid = '123451';
    qr.reasons.deactivationReason = new List<SoapApi33Domain.DeactivationReason>();
    qr.reasons.deactivationReason.add(deactivationReason);
    qr.reasons.deactivationReason.add(deactivationReason1);
    return qr;
  }

  /**
   * @description: This method is used to get Dummy usage Price Categories for test cases
   * @return SoapApi33Domain.QueryResponse,The instance of SoapApi33Domain.QueryResponse class.
   */
  public static SoapApi33Domain.QueryResponse getusagePriceCategories() {
    SoapApi33Domain.QueryResponse qr = new SoapApi33Domain.QueryResponse();
    qr.successful = true;
    qr.UsagePriceCategories = new SoapApi33Domain.UsagePriceCategories();
    qr.UsagePriceCategories.usagePriceCategory = new List<SoapApi33Domain.UsagePriceCategory>();
    SoapApi33Domain.UsagePriceCategory usaescategroy = new SoapApi33Domain.UsagePriceCategory();
    usaescategroy.status = 'ACTIVE ';
    usaescategroy.eid = '12345';
    qr.UsagePriceCategories.usagePriceCategory.add(usaescategroy);
    return qr;
  }
  /**
   * @description: This method is used to get Dummy rate Tables for test cases
   * @return SoapApi33Domain.QueryResponse,The instance of SoapApi33Domain.QueryResponse class.
   */
  public static SoapApi33Domain.QueryResponse getrateTables() {
    SoapApi33Domain.QueryResponse qr = new SoapApi33Domain.QueryResponse();
    qr.successful = true;
    qr.RateTables = new SoapApi33Domain.RateTables();
    qr.RateTables.rateTable = new List<SoapApi33Domain.RateTable>();
    SoapApi33Domain.RateTable ratetable = new SoapApi33Domain.RateTable();
    ratetable.status = 'ACTIVE ';
    ratetable.eid = '12345';
    qr.RateTables.rateTable.add(ratetable);
    return qr;
  }
  /**
   * @description: This method is used to get Dummy global Usage Rules for test cases
   * @return SoapApi33Domain.QueryResponse,The instance of SoapApi33Domain.QueryResponse class.
   */
  public static SoapApi33Domain.QueryResponse geglobalUsageRules() {
    SoapApi33Domain.QueryResponse qr = new SoapApi33Domain.QueryResponse();
    qr.successful = true;
    qr.globalUsageRules = new SoapApi33Domain.GlobalUsageRules();
    qr.globalUsageRules.globalUsageRule = new List<SoapApi33Domain.GlobalUsageRule>();
    SoapApi33Domain.GlobalUsageRule globalRule = new SoapApi33Domain.GlobalUsageRule();
    globalRule.status = 'ACTIVE ';
    globalRule.eid = '12345';
    qr.globalUsageRules.globalUsageRule.add(globalRule);
    return qr;
  }
  /**
   * @description: This method is used to get Dummy for Tract Billing Account test cases
   * @return SoapApi33Domain.BillingAccount,The instance of SoapApi33Domain.BillingAccount class.
   */
  public static SoapApi33Domain.BillingAccount getTractBillingAccount() {
    SoapApi33Domain.DailyBillCycle dailyBillCycle = new SoapApi33Domain.DailyBillCycle();
    SoapApi33Domain.MonthlyBillCycle monthlyBillCycle = new SoapApi33Domain.MonthlyBillCycle();
    SoapApi33Domain.QuarterlyBillCycle quarterlyBillCycle = new SoapApi33Domain.QuarterlyBillCycle();
    SoapApi33Domain.YearlyBillCycle yearlyBillCycle = new SoapApi33Domain.YearlyBillCycle();
    SoapApi33Domain.Person person = new SoapApi33Domain.Person();
    SoapApi33Domain.Organization organization = new SoapApi33Domain.Organization();
    SoapApi33Domain.BillingAccountRecurringPayments recurringPayments = new SoapApi33Domain.BillingAccountRecurringPayments();
    SoapApi33Domain.BillingAccountCategory billingAccountCategory = new SoapApi33Domain.BillingAccountCategory();
    SoapApi33Domain.Services services = new SoapApi33Domain.Services();
    SoapApi33Domain.OrderItemCharges pendingCharges = new SoapApi33Domain.OrderItemCharges();
    SoapApi33Domain.BillingAccount billAccount = new SoapApi33Domain.BillingAccount();
    billAccount.dailyBillCycle = dailyBillCycle;
    billAccount.monthlyBillCycle = monthlyBillCycle;
    billAccount.quarterlyBillCycle = quarterlyBillCycle;
    billAccount.yearlyBillCycle = yearlyBillCycle;
    billAccount.organization = organization;
    billAccount.recurringPayments = recurringPayments;
    billAccount.billingAccountCategory = billingAccountCategory;
    billAccount.person = person;
    billAccount.services = services;
    billAccount.pendingCharges = pendingCharges;
    billAccount.accountNum = '1234';
    billAccount.externalAccountNum = '1234';
    billAccount.billType = 'test';
    billAccount.automaticRecurringPayment = true;
    billAccount.status = 'success';
    billAccount.pendingChargesTotal = 100.0;
    billAccount.balance = 100.0;
    billAccount.dailyBillCycle = dailyBillCycle;
    billAccount.monthlyBillCycle = monthlyBillCycle;
    billAccount.quarterlyBillCycle = quarterlyBillCycle;
    billAccount.yearlyBillCycle = yearlyBillCycle;
    billAccount.organization = organization;
    billAccount.recurringPayments = recurringPayments;
    billAccount.billingAccountCategory = billingAccountCategory;
    billAccount.person = person;
    billAccount.services = services;
    billAccount.pendingCharges = pendingCharges;
    billAccount.accountNum = '1234';
    billAccount.externalAccountNum = '1234';
    billAccount.billType = 'test';
    billAccount.automaticRecurringPayment = true;
    billAccount.status = 'success';
    billAccount.pendingChargesTotal = 100.0;
    billAccount.balance = 100.0;
    return billAccount;
  }
  /**
   * @description: This method is used to get Dummy Products for test cases
   * @return SoapApi33Domain.QueryResponse,The instance of SoapApi33Domain.QueryResponse class.
   */
  public static SoapApi33Domain.QueryResponse getProducts() {
    SoapApi33Domain.QueryResponse qr = new SoapApi33Domain.QueryResponse();
    qr.successful = true;
    qr.products = new SoapApi33Domain.Products();
    qr.products.product = new List<SoapApi33Domain.Product>();
    SoapApi33Domain.Product p1 = new SoapApi33Domain.Product();
    p1.name = 'Simple Subscrption';
    p1.internalName = 'Simple Subscription';
    p1.description = 'A Simple Subscription product for tetsing';
    p1.productState = 'PRODUCT_AVAILABLE';
    p1.productCategory = new SoapApi33Domain.ProductCategory();
    p1.productCategory.description = '2323';
    p1.productCategory.name = 'TRACT';
    p1.productCategory.status = 'Available';
    p1.name = 'Simple Subscrption';
    p1.internalName = 'Simple Subscription';
    p1.description = 'A Simple Subscription product for tetsing';
    p1.productState = 'PRODUCT_AVAILABLE';
    p1.productCategory = new SoapApi33Domain.ProductCategory();
    p1.productCategory.description = '2323';
    p1.productCategory.name = 'TRACT';
    p1.productCategory.status = 'Available';
    p1.defaultQuantity = 1;
    p1.description = 'asdfasdfasdf';
    p1.externalProductNumber = 'asdfasdf';
    p1.internalName = 'asdfasdf';
    p1.maxServiceResources = 3;
    p1.minServiceResources = 0;
    p1.name = 'asdfasdf';
    p1.productState = 'AVAILABLE';
    p1.productTypeCode = 'SDFD';
    p1.requiresAgreement = true;
    p1.serialized = true;
    p1.shortDescription = 'asdfasdf';
    p1.sku = 'asdfasd';
    p1.taxable = true;
    p1.trial = true;
    p1.trialDays = 2;
    p1.trialOverride = true;
    p1.eid = '12345';
    SoapApi33Domain.ProductPrices productPrices = new SoapApi33Domain.ProductPrices();
    productPrices.oneTimeProductPrice = new List<SoapApi33Domain.OneTimeProductPrice>();
    SoapApi33Domain.OneTimeProductPrice oneproductPrices = new SoapApi33Domain.OneTimeProductPrice();
    SoapApi33Domain.PriceRanges priceRanges = new SoapApi33Domain.PriceRanges();
    SoapApi33Domain.PriceRange[] priceRange = new List<SoapApi33Domain.PriceRange>();
    priceRange.add(new SoapApi33Domain.PriceRange());
    priceRanges.priceRange = priceRange;
    oneproductPrices.priceRanges = priceRanges;
    oneproductPrices.eid = '12345';
    productPrices.oneTimeProductPrice.add(oneproductPrices);
    productPrices.recurringProductPrice = new List<SoapApi33Domain.RecurringProductPrice>();
    SoapApi33Domain.RecurringProductPrice recproductPrices = new SoapApi33Domain.RecurringProductPrice();
    recproductPrices.priceRanges = priceRanges;
    productPrices.recurringProductPrice.add(recproductPrices);
    p1.productPrices = productPrices;
    SoapApi33Domain.ServiceResourceCategory serviceResourceCategory = new SoapApi33Domain.ServiceResourceCategory();
    serviceResourceCategory.name = 'serviceResource';
    serviceResourceCategory.eid = '12345';
    serviceResourceCategory.status = 'status';
    serviceResourceCategory.type_x = 'type';
    p1.serviceResourceCategory = serviceResourceCategory;
    qr.products.product.add(p1);
    qr.products.totalElements = 50;
    qr.products.totalPages = 1;
    return qr;
  }
  /**
   * @description: This method is used to get Dummy Product for test cases
   * @return SoapApi33Domain.Product,The instance of SoapApi33Domain.Product class.
   */
  public static SoapApi33Domain.Product getProduct() {
    SoapApi33Domain.Product p1 = new SoapApi33Domain.Product();
    p1.name = 'Simple Subscrption';
    p1.eid = '12345';
    p1.internalName = 'Simple Subscription';
    p1.description = 'A Simple Subscription product for tetsing';
    p1.productState = 'PRODUCT_AVAILABLE';
    p1.productCategory = new SoapApi33Domain.ProductCategory();
    p1.productCategory.description = '2323';
    p1.productCategory.name = 'TRACT';
    p1.productCategory.status = 'Available';
    p1.productPrices = new SoapApi33Domain.ProductPrices();
    SoapApi33Domain.priceRange pricerange = new SoapApi33Domain.priceRange();
    pricerange.price = 100;
    pricerange.quantityBeginRange = 100;
    pricerange.quantityEndRange = 200;
    p1.productPrices.oneTimeProductPrice = new List<SoapApi33Domain.OneTimeProductPrice>();
    p1.productPrices.oneTimeProductPrice.add(
      new SoapApi33Domain.OneTimeProductPrice()
    );
    p1.productPrices.oneTimeProductPrice[0].priceOverride = true;
    p1.productPrices.oneTimeProductPrice[0]
      .priceRanges = new SoapApi33Domain.PriceRanges();
    p1.productPrices.oneTimeProductPrice[0]
      .priceRanges.priceRange = new List<SoapApi33Domain.priceRange>();
    p1.productPrices.oneTimeProductPrice[0]
      .priceRanges.priceRange.add(pricerange);
    p1.productPrices.recurringProductPrice = new List<SoapApi33Domain.RecurringProductPrice>();
    p1.productPrices.recurringProductPrice.add(
      new SoapApi33Domain.RecurringProductPrice()
    );
    p1.productPrices.recurringProductPrice[0].priceoverride = true;
    p1.productPrices.recurringProductPrice[0]
      .priceRanges = new SoapApi33Domain.PriceRanges();
    p1.productPrices.recurringProductPrice[0]
      .priceRanges.priceRange = new List<SoapApi33Domain.priceRange>();
    p1.productPrices.recurringProductPrice[0]
      .priceRanges.priceRange.add(pricerange);
    p1.defaultQuantity = 1;
    p1.description = 'asdfasdfasdf';
    p1.externalProductNumber = 'asdfasdf';
    p1.internalName = 'asdfasdf';
    p1.maxServiceResources = 3;
    p1.minServiceResources = 0;
    p1.productTypeCode = 'SDFD';
    p1.requiresAgreement = true;
    p1.serialized = true;
    p1.shortDescription = 'asdfasdf';
    p1.sku = 'asdfasd';
    p1.taxable = true;
    p1.trial = true;
    p1.trialDays = 2;
    p1.eid = '12345';
    p1.trialOverride = true;
    return p1;
  }
  /**
   * @description: This method is used to get Dummy Service Resource for test cases
   * @return SoapApi33Domain.ServiceResource,The instance of SoapApi33Domain.ServiceResource class.
   */
  public static SoapApi33Domain.ServiceResource getServiceResource() {
    SoapApi33Domain.ServiceResource serviceResourceObj = new SoapApi33Domain.ServiceResource();
    serviceResourceObj.status = 'AVAILABLES';
    serviceResourceObj.eid = '12345';
    return serviceResourceObj;
  }
  /**
   * @description: This method is used to get Dummy Sales Order for test cases
   * @return SoapApi33Domain.SalesOrder,The instance of SoapApi33Domain.SalesOrder class.
   */
  public static SoapApi33Domain.SalesOrder getSalesOrder() {
    SoapApi33Domain.SalesOrder salesOrderobj = new SoapApi33Domain.SalesOrder();
    salesOrderobj.orderItems = new SoapApi33Domain.orderItems();
    return salesOrderobj;
  }
  /**
   * @description: This method is used to get Dummy Billing Account for test cases
   * @return SoapApi33Domain.BillingAccount,The instance of SoapApi33Domain.BillingAccount class.
   */
  public static SoapApi33Domain.BillingAccount getBillingAccount() {
    SoapApi33Domain.BillingAccount billingAccount = new SoapApi33Domain.BillingAccount();
    return billingAccount;
  }
  /**
   * @description: This method is used to get Dummy order Items for test cases
   * @return SoapApi33Domain.QueryResponse,The instance of SoapApi33Domain.QueryResponse class.
   */
  public static SoapApi33Domain.QueryResponse getorderItems() {
    SoapApi33Domain.QueryResponse qr = new SoapApi33Domain.QueryResponse();
    qr.successful = true;
    qr.orderitems = new SoapApi33Domain.orderItems();
    List<SoapApi33Domain.taxOrderItem> taxOrderItemList = new List<SoapApi33Domain.taxOrderItem>();
    SoapApi33Domain.TaxOrderItem taxOrderItemobj = new SoapApi33Domain.TaxOrderItem();
    taxOrderItemobj.total = 100;
    List<SoapApi33Domain.orderItem> orderItemList = new List<SoapApi33Domain.orderItem>();
    SoapApi33Domain.OrderItem orderItemobj = new SoapApi33Domain.OrderItem();
    SoapApi33Domain.ProductPrice recPrice = new SoapApi33Domain.ProductPrice();
    recPrice.fromDate = System.Now();
    recPrice.recurrencePeriod = 'BillCycle';
    recPrice.billInAdvance = true;
    recPrice.proratedOnCancel = true;
    recPrice.currencyType = 'USD';
    SoapApi33Domain.priceCategory priceCategory = new SoapApi33Domain.priceCategory();
    priceCategory.name = 'Test';
    recPrice.priceCategory = priceCategory;
    SoapApi33Domain.priceRanges priceRanges = new SoapApi33Domain.PriceRanges();
    List<SoapApi33Domain.priceRange> priceRangeList = new List<SoapApi33Domain.PriceRange>();
    SoapApi33Domain.priceRange priceRange = new SoapApi33Domain.priceRange();
    priceRange.price = 20;
    priceRangeList.add(priceRange);
    priceRanges.priceRange = priceRangeList;
    recPrice.priceRanges = priceRanges;
    orderItemobj.recurringProductPrice = recPrice;
    SOAPAPI33Domain.OrderItemPrices orderItemPrices = new SOAPAPI33Domain.OrderItemPrices();
    SOAPAPI33Domain.OrderItemRecurringPrice orderItemRecurringPrice = new SOAPAPI33Domain.OrderItemRecurringPrice();
    orderItemRecurringPrice.amount = 2.0;
    orderItemPrices.orderItemRecurringPrice = orderItemRecurringPrice;
    SOAPAPI33Domain.OrderItemOneTimePrice orderItemOneTimePrice = new SOAPAPI33Domain.OrderItemOneTimePrice();
    orderItemOneTimePrice.amount = 2.0;
    orderItemPrices.orderItemOneTimePrice = orderItemOneTimePrice;
    orderItemobj.orderItemPrices = orderItemPrices;
    orderItemobj.eid = '12345';
    orderItemobj.quantity = 1;
    orderItemobj.recurringUnitPrice = 50;
    orderItemobj.unitPrice = 123;
    orderItemobj.priceList = new SoapApi33Domain.PriceList();
    orderItemobj.priceList.eid = '12345';
    orderItemobj.selectedAgreement = new SoapApi33Domain.Agreement();
    SoapApi33Domain.ScheduledOneTimePriceCharges scheduledChargesFeature = new SoapApi33Domain.ScheduledOneTimePriceCharges();
    SoapApi33Domain.ScheduledOneTimePriceCharge[] scheduledChargeList = new List<SoapApi33Domain.ScheduledOneTimePriceCharge>();
    SoapApi33Domain.ScheduledOneTimePriceCharge scheduledCharge = new SoapApi33Domain.ScheduledOneTimePriceCharge();
    scheduledCharge.amount = 2.0;
    scheduledCharge.chargeDate = String.valueOf(System.today());
    scheduledCharge.description = 'Test';
    scheduledCharge.invoiced = true;
    scheduledCharge.status = 'true';
    scheduledChargeList.add(scheduledCharge);
    scheduledChargesFeature.scheduledOneTimePriceCharge = scheduledChargeList;
    orderItemobj.scheduledOneTimePriceCharges = scheduledChargesFeature;
    SoapApi33Domain.Product p1 = new SoapApi33Domain.Product();
    p1.name = 'Simple Subscrption';
    p1.internalName = 'Simple Subscription';
    p1.description = 'A Simple Subscription product for tetsing';
    p1.productState = 'PRODUCT_AVAILABLE';
    p1.productCategory = new SoapApi33Domain.ProductCategory();
    p1.productCategory.description = '2323';
    p1.productCategory.name = 'TRACT';
    p1.productCategory.status = 'Available';
    p1.name = 'Simple Subscrption';
    p1.internalName = 'Simple Subscription';
    p1.description = 'A Simple Subscription product for tetsing';
    p1.productState = 'PRODUCT_AVAILABLE';
    p1.productCategory = new SoapApi33Domain.ProductCategory();
    p1.productCategory.description = '2323';
    p1.productCategory.name = 'TRACT';
    p1.productCategory.status = 'Available';
    p1.defaultQuantity = 1;
    p1.description = 'asdfasdfasdf';
    p1.externalProductNumber = 'asdfasdf';
    p1.internalName = 'asdfasdf';
    p1.maxServiceResources = 3;
    p1.minServiceResources = 0;
    p1.name = 'asdfasdf';
    p1.productState = 'AVAILABLE';
    p1.productTypeCode = 'SDFD';
    p1.requiresAgreement = true;
    p1.serialized = true;
    p1.shortDescription = 'asdfasdf';
    p1.sku = 'asdfasd';
    p1.taxable = true;
    p1.trial = true;
    p1.trialDays = 2;
    p1.trialOverride = true;
    p1.eid = '12345';
    SoapApi33Domain.ProductPrices productPrices = new SoapApi33Domain.ProductPrices();
    productPrices.oneTimeProductPrice = new List<SoapApi33Domain.OneTimeProductPrice>();
    SoapApi33Domain.OneTimeProductPrice oneproductPrices = new SoapApi33Domain.OneTimeProductPrice();
    oneproductPrices.eid = '12345';
    oneproductPrices.priceCategory = priceCategory;
    oneproductPrices.priceOverride = true;
    oneproductPrices.currencyType = 'USD';
    oneproductPrices.priceRanges = priceRanges;
    productPrices.oneTimeProductPrice.add(oneproductPrices);
    productPrices.recurringProductPrice = new List<SoapApi33Domain.RecurringProductPrice>();
    SoapApi33Domain.RecurringProductPrice recproductPrices = new SoapApi33Domain.RecurringProductPrice();
    recproductPrices.priceRanges = priceRanges;
    productPrices.recurringProductPrice.add(recproductPrices);
    p1.productPrices = productPrices;
    orderItemobj.product = p1;
    taxOrderItemList.add(taxOrderItemobj);
    orderItemList.add(orderItemobj);
    qr.orderItems.orderItem = orderItemList;
    qr.orderItems.taxOrderItem = taxOrderItemList;
    return qr;
  }

  /**
   * @description: This method is used to get Dummy for Product Relations test cases
   * @return SoapApi33Domain.QueryResponse,The instance of SoapApi33Domain.QueryResponse class.
   */
  public static SoapApi33Domain.QueryResponse getProductRelations() {
    SoapApi33Domain.QueryResponse qr = new SoapApi33Domain.QueryResponse();
    qr.ProductRelations = new SoapApi33Domain.ProductRelations();
    List<SoapApi33Domain.ProductRelation> proRelationList = new List<SoapApi33Domain.ProductRelation>();
    SoapApi33Domain.ProductRelation proRelation = new SoapApi33Domain.ProductRelation();
    qr.successful = true;
    SoapApi33Domain.Product p1 = new SoapApi33Domain.Product();
    p1.name = 'Simple Subscrption';
    p1.internalName = 'Simple Subscription';
    p1.description = 'A Simple Subscription product for tetsing';
    p1.productState = 'PRODUCT_AVAILABLE';
    p1.productCategory = new SoapApi33Domain.ProductCategory();
    p1.productCategory.description = '2323';
    p1.productCategory.name = 'TRACT';
    p1.productCategory.status = 'Available';
    p1.productPrices = new SoapApi33Domain.ProductPrices();
    p1.productPrices.recurringProductPrice = new List<SoapApi33Domain.RecurringProductPrice>();
    p1.productPrices.recurringProductPrice.add(
      new SoapApi33Domain.RecurringProductPrice()
    );
    p1.productPrices.recurringProductPrice[0]
      .priceRanges = new SoapApi33Domain.PriceRanges();
    p1.productPrices.recurringProductPrice[0]
      .priceRanges.priceRange = new List<SoapApi33Domain.PriceRange>();
    p1.productPrices.recurringProductPrice[0]
      .priceRanges.priceRange.add(new SoapApi33Domain.PriceRange());
    p1.productPrices.recurringProductPrice[0]
      .priceRanges.priceRange[0]
      .quantityBeginRange = 23;
    p1.productPrices.recurringProductPrice[0]
      .priceRanges.priceRange[0]
      .quantityEndRange = 32;
    p1.productPrices.recurringProductPrice[0]
      .priceRanges.priceRange[0]
      .price = 23;
    p1.productPrices.recurringProductPrice[0]
      .priceRanges.priceRange[0]
      .level = 2;
    p1.productPrices.recurringProductPrice[0].fromDate = System.Now();
    p1.productPrices.recurringProductPrice[0].thruDate = System.Now();
    p1.productPrices.recurringProductPrice[0].priceOverride = true;
    p1.productPrices.recurringProductPrice[0].type_x = 'asdf';
    p1.productPrices.recurringProductPrice[0].paymentOnPurchaseRequired = true;
    p1.productPrices.recurringProductPrice[0].recurringPaymentRequired = true;
    p1.eid = '35299';
    p1.defaultQuantity = 1;
    p1.description = 'asdfasdfasdf';
    p1.externalProductNumber = 'asdfasdf';
    p1.internalName = 'asdfasdf';
    p1.maxServiceResources = 3;
    p1.minServiceResources = 0;
    p1.name = 'asdfasdf';
    p1.productState = 'AVAILABLE';
    p1.productTypeCode = 'SDFD';
    p1.requiresAgreement = true;
    p1.serialized = true;
    p1.shortDescription = 'asdfasdf';
    p1.sku = 'asdfasd';
    p1.taxable = true;
    p1.trial = true;
    p1.trialDays = 2;
    p1.trialOverride = true;
    p1.defaultQuantity = 1;
    p1.description = 'asdfasdfasdf';
    p1.externalProductNumber = 'asdfasdf';
    p1.internalName = 'asdfasdf';
    p1.maxServiceResources = 3;
    p1.minServiceResources = 0;
    p1.name = 'asdfasdf';
    p1.productState = 'AVAILABLE';
    p1.productTypeCode = 'SDFD';
    p1.requiresAgreement = true;
    p1.serialized = true;
    p1.shortDescription = 'asdfasdf';
    p1.sku = 'asdfasd';
    p1.taxable = true;
    p1.trial = true;
    p1.trialDays = 2;
    p1.trialOverride = true;
    proRelation.product = p1;
    proRelationList.add(proRelation);
    qr.productRelations.productRelation = proRelationList;
    return qr;
  }

  /**
   * @description: This method is used to get Dummy Bill Cycles for test cases
   * @return SoapApi33Domain.QueryResponse,The instance of SoapApi33Domain.QueryResponse class.
   */
  public static SoapApi33Domain.QueryResponse getBillCycles() {
    SoapApi33Domain.QueryResponse qr = new SoapApi33Domain.QueryResponse();
    qr.successful = true;
    qr.billCycles = new SoapApi33Domain.BillCycles();
    qr.billCycles.dailyBillCycle = new List<SoapApi33Domain.DailyBillCycle>();
    qr.billCycles.quarterlyBillCycle = new List<SoapApi33Domain.QuarterlyBillCycle>();
    qr.billCycles.monthlyBillCycle = new List<SoapApi33Domain.MonthlyBillCycle>();
    qr.billCycles.yearlyBillCycle = new List<SoapApi33Domain.YearlyBillCycle>();
    SoapApi33Domain.BillingAccountCategory bac = new SoapApi33Domain.BillingAccountCategory();
    bac.eid = '12345';
    SoapApi33Domain.QuarterlyBillCycle qCycle = new SoapApi33Domain.QuarterlyBillCycle();
    qCycle.eid = '12345';
    qCycle.name = 'qCycle';
    qCycle.billCycleType = 'type';
    qCycle.billingAccountCategory = bac;
    qr.billCycles.quarterlyBillCycle.add(qCycle);
    qr.billCycles.segmentedMonthlyBillCycle = new List<SoapApi33Domain.SegmentedMonthlyBillCycle>();
    SoapApi33Domain.SegmentedMonthlyBillCycle sCycle = new SoapApi33Domain.SegmentedMonthlyBillCycle();
    sCycle.eid = '12345';
    sCycle.name = 'scycle';
    sCycle.startDate = date.valueOf('2014-4-4');
    sCycle.endDate = date.valueOf('2018-4-4');
    sCycle.billCycleType = 'scycle';
    sCycle.autoBill = true;
    sCycle.usePaymentTerm = true;
    sCycle.status = 'open';
    sCycle.currencyType = 'USD';
    sCycle.eid = '12345';
    sCycle.name = 'scycle';
    sCycle.startDate = date.valueOf('2014-4-4');
    sCycle.endDate = date.valueOf('2018-4-4');
    sCycle.billCycleType = 'scycle';
    sCycle.autoBill = true;
    sCycle.usePaymentTerm = true;
    sCycle.status = 'open';
    sCycle.currencyType = 'USD';
    sCycle.billingAccountCategory = bac;
    qr.billCycles.segmentedMonthlyBillCycle.add(sCycle);
    SoapApi33Domain.DailyBillCycle bCycle = new SoapApi33Domain.DailyBillCycle();
    bCycle.eid = '12345';
    bCycle.name = 'USD Cycle';
    bCycle.startDate = System.now();
    bCycle.endDate = System.now().addYears(5);
    bCycle.billCycleType = 'Daily';
    bCycle.autoBill = false;
    bCycle.usePaymentTerm = false;
    bCycle.currencyType = 'USD';
    bCycle.status = 'Active';
    bCycle.eid = '12345';
    bCycle.name = 'USD Cycle';
    bCycle.startDate = System.now();
    bCycle.endDate = System.now().addYears(5);
    bCycle.billCycleType = 'Daily';
    bCycle.autoBill = false;
    bCycle.usePaymentTerm = false;
    bCycle.currencyType = 'USD';
    bCycle.status = 'Active';
    bCycle.billingAccountCategory = bac;
    qr.billCycles.dailyBillCycle.add(bCycle);
    SoapApi33Domain.MonthlyBillCycle monthlyBillCycle = new SoapApi33Domain.MonthlyBillCycle();
    monthlyBillCycle.eid = '12346';
    monthlyBillCycle.name = 'USD MOnthly Cycle';
    monthlyBillCycle.startDate = System.now();
    monthlyBillCycle.endDate = System.now().addYears(5);
    monthlyBillCycle.billCycleType = 'Monthly';
    monthlyBillCycle.autoBill = false;
    monthlyBillCycle.usePaymentTerm = false;
    monthlyBillCycle.currencyType = 'USD';
    monthlyBillCycle.status = 'Active';
    monthlyBillCycle.eid = '12346';
    monthlyBillCycle.name = 'USD MOnthly Cycle';
    monthlyBillCycle.startDate = System.now();
    monthlyBillCycle.endDate = System.now().addYears(5);
    monthlyBillCycle.billCycleType = 'Monthly';
    monthlyBillCycle.autoBill = false;
    monthlyBillCycle.usePaymentTerm = false;
    monthlyBillCycle.currencyType = 'USD';
    monthlyBillCycle.status = 'Active';
    monthlyBillCycle.billingAccountCategory = bac;
    qr.billCycles.monthlyBillCycle.add(monthlyBillCycle);
    SoapApi33Domain.YearlyBillCycle yearlyBillCycle = new SoapApi33Domain.YearlyBillCycle();
    yearlyBillCycle.eid = '12346';
    yearlyBillCycle.name = 'USD Yearly Cycle';
    yearlyBillCycle.startDate = System.now().addYears(-2);
    yearlyBillCycle.endDate = System.now().addYears(5);
    yearlyBillCycle.billCycleType = 'Yearly';
    yearlyBillCycle.autoBill = false;
    yearlyBillCycle.usePaymentTerm = false;
    yearlyBillCycle.currencyType = 'USD';
    yearlyBillCycle.status = 'Active';
    yearlyBillCycle.eid = '12346';
    yearlyBillCycle.name = 'USD Yearly Cycle';
    yearlyBillCycle.startDate = System.now().addYears(-2);
    yearlyBillCycle.endDate = System.now().addYears(5);
    yearlyBillCycle.billCycleType = 'Yearly';
    yearlyBillCycle.autoBill = false;
    yearlyBillCycle.usePaymentTerm = false;
    yearlyBillCycle.currencyType = 'USD';
    yearlyBillCycle.status = 'Active';
    yearlyBillCycle.billingAccountCategory = bac;
    qr.billCycles.yearlyBillCycle.add(yearlyBillCycle);
    qr.billCycles.totalPages = 2;
    return qr;
  }
  /**
   * @description: This method is used to get Dummy Adjustments for test cases
   * @return SoapApi33Domain.QueryResponse,The instance of SoapApi33Domain.QueryResponse class.
   */
  public static SoapApi33Domain.QueryResponse getAdjustments() {
    SoapApi33Domain.QueryResponse qr = new SoapApi33Domain.QueryResponse();
    qr.successful = true;
    qr.adjustments = new SoapApi33Domain.Adjustments();
    qr.adjustments.adjustment = new List<SoapApi33Domain.Adjustment>();
    List<SoapApi33Domain.Adjustment> adjustmentList = new List<SoapApi33Domain.Adjustment>();
    SoapApi33Domain.Adjustment creditAdjustment = new SoapApi33Domain.Adjustment();
    creditAdjustment.amount = 5.0;
    creditAdjustment.unappliedAmount = 5.0;
    creditAdjustment.eid = '12345';
    creditAdjustment.occurredOn = System.now();
    creditAdjustment.credit = true;
    creditAdjustment.invoiced = false;
    creditAdjustment.postedOn = System.now();
    creditAdjustment.status = 'Posted';
    creditAdjustment.type_x = 'MANUAL';
    creditAdjustment.amount = 5.0;
    creditAdjustment.eid = '12345';
    creditAdjustment.occurredOn = System.now();
    creditAdjustment.credit = true;
    creditAdjustment.invoiced = false;
    creditAdjustment.postedOn = System.now();
    creditAdjustment.status = 'Posted';
    creditAdjustment.type_x = 'MANUAL';
    SoapApi33Domain.AdjustmentReason reason = new SoapApi33Domain.AdjustmentReason();
    reason.description = 'A reason for Credits';
    reason.creditOnly = true;
    creditAdjustment.reason = reason;
    adjustmentList.add(creditAdjustment);
    SoapApi33Domain.Adjustment debitAdjustment = new SoapApi33Domain.Adjustment();
    debitAdjustment.amount = 5.0;
    debitAdjustment.eid = '123456';
    debitAdjustment.occurredOn = System.now();
    debitAdjustment.credit = false;
    debitAdjustment.invoiced = false;
    debitAdjustment.postedOn = System.now();
    debitAdjustment.status = 'Posted';
    debitAdjustment.type_x = 'MANUAL';
    debitAdjustment.amount = 5.0;
    debitAdjustment.eid = '123456';
    debitAdjustment.occurredOn = System.now();
    debitAdjustment.credit = false;
    debitAdjustment.invoiced = false;
    debitAdjustment.postedOn = System.now();
    debitAdjustment.status = 'Posted';
    debitAdjustment.type_x = 'MANUAL';
    debitAdjustment.unappliedAmount = 5.0;
    SoapApi33Domain.AdjustmentReason debitReason = new SoapApi33Domain.AdjustmentReason();
    debitReason.description = 'A reason for Debits';
    debitReason.creditOnly = false;
    debitAdjustment.reason = reason;
    adjustmentList.add(debitAdjustment);
    qr.adjustments.adjustment = adjustmentList;
    return qr;
  }
  /**
   * @description: This method is used to get Dummy Billing Account Categories for test cases
   * @return SoapApi33Domain.QueryResponse,The instance of SoapApi33Domain.QueryResponse class.
   */
  public static SoapApi33Domain.QueryResponse getBillingAccountCategories() {
    SoapApi33Domain.QueryResponse qr = new SoapApi33Domain.QueryResponse();
    qr.successful = true;
    qr.billingAccountCategories = new SoapApi33Domain.BillingAccountCategories();
    qr.billingAccountCategories.billingAccountCategory = new List<SoapApi33Domain.BillingAccountCategory>();
    List<SoapApi33Domain.billingAccountCategory> billingAccountCategoryList = new List<SoapApi33Domain.billingAccountCategory>();
    SoapApi33Domain.billingAccountCategory billingAccountCategoryObject = new SoapApi33Domain.billingAccountCategory();
    billingAccountCategoryObject.eid = '12345';
    billingAccountCategoryObject.type_x = 'type';
    billingAccountCategoryList.add(billingAccountCategoryObject);
    qr.billingAccountCategories.billingAccountCategory = billingAccountCategoryList;
    return qr;
  }
  /**
   * @description: This method is used to get Dummy for test cases
   * @return SoapApi33Domain.QueryResponse,The instance of SoapApi33Domain.QueryResponse class.
   */
  public static SoapApi33Domain.QueryResponse getserviceResourceCategories() {
    SoapApi33Domain.QueryResponse qr = new SoapApi33Domain.QueryResponse();
    qr.successful = true;
    qr.serviceResourceCategories = new SoapApi33Domain.serviceResourceCategories();
    qr.serviceResourceCategories.serviceResourceCategory = new List<SoapApi33Domain.serviceResourceCategory>();
    List<SoapApi33Domain.serviceResourceCategory> serviceResourceCategoryList = new List<SoapApi33Domain.serviceResourceCategory>();
    SoapApi33Domain.serviceResourceCategory serviceResourceCategoryObject = new SoapApi33Domain.serviceResourceCategory();
    serviceResourceCategoryObject.eid = '12345';
    serviceResourceCategoryList.add(serviceResourceCategoryObject);
    qr.serviceResourceCategories.serviceResourceCategory = serviceResourceCategoryList;
    return qr;
  }
  /**
   * @description: This method is used to get Dummy party Categories for test cases
   * @return SoapApi33Domain.QueryResponse,The instance of SoapApi33Domain.QueryResponse class.
   */
  public static SoapApi33Domain.QueryResponse getpartyCategories() {
    SoapApi33Domain.QueryResponse qr = new SoapApi33Domain.QueryResponse();
    qr.successful = true;
    qr.partyCategories = new SoapApi33Domain.partyCategories();
    qr.partyCategories.partyCategory = new List<SoapApi33Domain.partyCategory>();
    List<SoapApi33Domain.partyCategory> partyCategoryList = new List<SoapApi33Domain.partyCategory>();
    SoapApi33Domain.partyCategory partyCategoryObject = new SoapApi33Domain.partyCategory();
    partyCategoryObject.eid = '12345';
    partyCategoryList.add(partyCategoryObject);
    qr.partyCategories.partyCategory = partyCategoryList;
    return qr;
  }
  /**
   * @description: This method is used to get Dummy Custom Fields for test cases
   * @return SoapApi33Domain.QueryResponse,The instance of SoapApi33Domain.QueryResponse class.
   */
  public static SoapApi33Domain.QueryResponse getCustomFields() {
    SoapApi33Domain.QueryResponse qr = new SoapApi33Domain.QueryResponse();
    qr.successful = true;
    qr.customFields = new SoapApi33Domain.CustomFields();
    qr.CustomFields.customField = new List<SoapApi33Domain.CustomField>();
    List<SoapApi33Domain.customField> customFieldList = new List<SoapApi33Domain.customField>();
    SoapApi33Domain.customField customFieldObject = new SoapApi33Domain.customField();
    customFieldObject.customFieldType = 'BILLING_ACCOUNT';
    customFieldObject.fieldType = 'TEXT_FIELD';
    customFieldObject.eid = '12345';
    customFieldObject.name = 'customObject';
    customFieldObject.enabled = true;
    customFieldList.add(customFieldObject);
    qr.CustomFields.totalPages = 1;
    qr.CustomFields.customField = customFieldList;
    return qr;
  }
  /**
   * @description: This method is used to get Dummy custom Field Values for test cases
   * @return SoapApi33Domain.QueryResponse,The instance of SoapApi33Domain.QueryResponse class.
   */
  public static SoapApi33Domain.QueryResponse getcustomFieldValues() {
    SoapApi33Domain.QueryResponse qr = new SoapApi33Domain.QueryResponse();
    qr.successful = true;
    qr.customFieldValues = new SoapApi33Domain.customFieldValues();
    qr.customFieldValues.customFieldValue = new List<SoapApi33Domain.customFieldValue>();
    List<SoapApi33Domain.customFieldValue> customFieldValueList = new List<SoapApi33Domain.customFieldValue>();
    SoapApi33Domain.customFieldValue customFieldValueObject = new SoapApi33Domain.customFieldValue();
    customFieldValueObject.value = 'value';
    customFieldValueObject.eid = '12345';
    SoapApi33Domain.CustomField cfield = new SoapApi33Domain.CustomField();
    cfield.eid = '12345';
    customFieldValueObject.customField = cfield;
    customFieldValueList.add(customFieldValueObject);
    qr.customFieldValues.customFieldValue = customFieldValueList;
    return qr;
  }
  /**
   * @description: This method is used to get Dummy agreements for test cases
   * @return SoapApi33Domain.QueryResponse,The instance of SoapApi33Domain.QueryResponse class.
   */
  public static SoapApi33Domain.QueryResponse getagreements() {
    SoapApi33Domain.QueryResponse qr = new SoapApi33Domain.QueryResponse();
    qr.successful = true;
    qr.agreements = new SoapApi33Domain.Agreements();
    qr.agreements.agreement = new List<SoapApi33Domain.Agreement>();
    SoapApi33Domain.agreement agr = new SoapApi33Domain.Agreement();
    agr.name = 'agriment';
    agr.agreementPeriod = 5;
    agr.status = 'open';
    agr.terminationFlatCharge = 500;
    agr.terminationPercentageCharge = 600;
    agr.maxTerminationCharge = 700;
    agr.prorateOnCancel = true;
    agr.endAction = 'endaction';
    agr.terminationFeeCurrencyType = 'USD';
    agr.maxTerminationFeeCurrencyType = 'USD';
    agr.minimumAmount = 300;
    agr.name = 'agriment';
    agr.agreementPeriod = 5;
    agr.status = 'open';
    agr.terminationFlatCharge = 500;
    agr.terminationPercentageCharge = 600;
    agr.maxTerminationCharge = 700;
    agr.prorateOnCancel = true;
    agr.endAction = 'endaction';
    agr.terminationFeeCurrencyType = 'USD';
    agr.maxTerminationFeeCurrencyType = 'USD';
    agr.minimumAmount = 300;
    qr.agreements.agreement.add(agr);
    return qr;
  }
  /**
   * @description: This method is used to get Dummy service Resources for test cases
   * @return SoapApi33Domain.QueryResponse,The instance of SoapApi33Domain.QueryResponse class.
   */
  public static SoapApi33Domain.QueryResponse getserviceResources() {
    SoapApi33Domain.QueryResponse qr = new SoapApi33Domain.QueryResponse();
    qr.successful = true;
    qr.serviceResources = new SoapApi33Domain.serviceResources();
    qr.serviceResources.serviceResource = new List<SoapApi33Domain.serviceResource>();
    SoapApi33Domain.serviceResource serviceResource = new SoapApi33Domain.serviceResource();
    serviceResource.identifier = 'identifire';
    serviceResource.eid = '12345';
    serviceResource.status = 'AVAILABLE';
    serviceResource.category = new SoapApi33Domain.ServiceResourceCategory();
    qr.serviceResources.totalElements = 10;
    qr.serviceResources.serviceResource.add(serviceResource);
    return qr;
  }
  /**
   * @description: This method is used to get Dummy Discount Codes for test cases
   * @return SoapApi33Domain.QueryResponse,The instance of SoapApi33Domain.QueryResponse class.
   */
  public static SoapApi33Domain.QueryResponse getDiscountCodes() {
    SoapApi33Domain.QueryResponse qr = new SoapApi33Domain.QueryResponse();
    qr.successful = true;
    qr.discountCodes = new SoapApi33Domain.DiscountCodes();
    qr.discountCodes.discountCode = new List<SoapApi33Domain.DiscountCode>();
    SoapApi33Domain.DiscountCode discountcode = new SoapApi33Domain.DiscountCode();
    discountcode.status = 'new_agreement';
    qr.discountCodes.discountCode.add(discountcode);
    return qr;
  }
  /**
   * @description: This method is used to get Dummy usage Rules for test cases
   * @return SoapApi33Domain.QueryResponse,The instance of SoapApi33Domain.QueryResponse class.
   */
  public static SoapApi33Domain.QueryResponse getusageRules() {
    SoapApi33Domain.QueryResponse qr = new SoapApi33Domain.QueryResponse();
    qr.successful = true;
    qr.usageEvents = new SoapApi33Domain.UsageEvents();
    qr.usageEvents.usageEvent = new List<SoapApi33Domain.UsageEvent>();
    SoapApi33Domain.UsageEvent usgesEvent1 = new SoapApi33Domain.UsageEvent();
    usgesEvent1.totalCharge = 12345;
    usgesEvent1.description = 'usesRules';
    usgesEvent1.serviceResourceId = '2345';
    usgesEvent1.usageAmount = 12345;
    usgesEvent1.referenceId = '12345';
    usgesEvent1.sequenceId = '12345';
    usgesEvent1.usageUom = '12345';
    qr.usageEvents.usageEvent.add(usgesEvent1);
    return qr;
  }
  /**
   * @description: This method is used to get Dummy System Settings for test cases
   * @return SoapApi33Domain.QueryResponse,The instance of SoapApi33Domain.QueryResponse class.
   */
  public static SoapApi33Domain.QueryResponse getSystemSettings() {
    SoapApi33Domain.QueryResponse qr = new SoapApi33Domain.QueryResponse();
    qr.successful = true;
    qr.systemSettings = new SoapApi33Domain.SystemSettings();
    qr.systemSettings.systemSetting = new List<SoapApi33Domain.SystemSetting>();
    SoapApi33Domain.SystemSetting settings = new SoapApi33Domain.SystemSetting();
    settings.name = 'Currency Identification';
    settings.value = 'ISO Code';
    qr.systemSettings.systemSetting.add(settings);
    return qr;
  }
  /**
   * @description: This method is used to get Dummy agreements for test cases
   * @return SoapApi33Domain.QueryResponse,The instance of SoapApi33Domain.QueryResponse class.
   */
  public static SoapApi33Domain.QueryResponse getagreements1() {
    SoapApi33Domain.QueryResponse qr = new SoapApi33Domain.QueryResponse();
    qr.successful = true;
    qr.agreements = new SoapApi33Domain.agreements();
    qr.agreements.agreement = new List<SoapApi33Domain.agreement>();
    List<SoapApi33Domain.agreement> agreementList = new List<SoapApi33Domain.agreement>();
    SoapApi33Domain.agreement agreementObject = new SoapApi33Domain.agreement();
    agreementObject.status = 'ACTIVE';
    agreementObject.name = 'object';
    agreementObject.eid = '12345';
    agreementObject.agreementPeriod = 10;
    agreementList.add(agreementObject);
    qr.agreements.agreement = agreementList;
    return qr;
  }
  /**
   * @description: This method is used to get Dummy Product Agreements for test cases
   * @return SoapApi33Domain.QueryResponse,The instance of SoapApi33Domain.QueryResponse class.
   */
  public static SoapApi33Domain.QueryResponse getProductAgreements() {
    SoapApi33Domain.QueryResponse qr = new SoapApi33Domain.QueryResponse();
    qr.successful = true;
    qr.agreements = new SoapApi33Domain.Agreements();
    qr.agreements.agreement = new List<SoapApi33Domain.Agreement>();
    SoapApi33Domain.Agreement agreement = new SoapApi33Domain.Agreement();
    agreement.name = 'Test Agreement 1';
    agreement.eid = '56789';
    agreement.agreementPeriod = 6;
    agreement.prorateOnCancel = false;
    agreement.endAction = 'Renew Agreement';
    agreement.terminationFlatCharge = 15;
    agreement.status = 'ACTIVE';
    agreement.terminationPercentageCharge = 0.0;
    agreement.name = 'Test Agreement 1';
    agreement.eid = '56789';
    agreement.agreementPeriodType = 'Month';
    agreement.prorateOnCancel = false;
    agreement.endAction = 'Renew Agreement';
    agreement.terminationFlatCharge = 15;
    agreement.status = 'ACTIVE';
    agreement.terminationPercentageCharge = 0.0;
    agreement.maxTerminationFeeCurrencyType = 'USD';
    qr.agreements.agreement.add(agreement);
    return qr;
  }
  /**
   * @description: This method is used to get Dummy Agreement for test cases
   * @return SoapApi33Domain.Agreement,The instance of SoapApi33Domain.Agreement class.
   */
  public static SoapApi33Domain.Agreement getAgreement() {
    SoapApi33Domain.Agreement agreement = new SoapApi33Domain.Agreement();
    agreement.name = 'Test Agreement 1';
    agreement.eid = '56789';
    agreement.agreementPeriod = 6;
    agreement.prorateOnCancel = false;
    agreement.endAction = 'Renew Agreement';
    agreement.terminationFlatCharge = 15;
    agreement.terminationPercentageCharge = 0.0;
    agreement.name = 'Test Agreement 1';
    agreement.eid = '56789';
    agreement.agreementPeriod = 6;
    agreement.prorateOnCancel = false;
    agreement.endAction = 'Renew Agreement';
    agreement.terminationFlatCharge = 15;
    agreement.terminationPercentageCharge = 0.0;
    return agreement;
  }
  /**
   * @description: This method is used to get Dummy Agreement Services for test cases
   * @return SoapApi33Domain.QueryResponse,The instance of SoapApi33Domain.QueryResponse class.
   */
  public static SoapApi33Domain.QueryResponse getAgreementServices() {
    SoapApi33Domain.QueryResponse qr = new SoapApi33Domain.QueryResponse();
    qr.successful = true;
    qr.AgreementServices = new SoapApi33Domain.AgreementServices();
    qr.AgreementServices.AgreementService = new List<SoapApi33Domain.AgreementService>();
    SoapApi33Domain.AgreementService agreementservice = new SoapApi33Domain.AgreementService();
    agreementservice.endDate = date.valueOf('2017-5-5');
    qr.AgreementServices.AgreementService.add(agreementservice);
    return qr;
  }
  /**
   * @description: This method is used to get Dummy tract Billing for test cases
   * @return SoapApi33Domain.CreateResponse,The instance of SoapApi33Domain.CreateResponse class.
   */
  public static SoapApi33Domain.CreateResponse gettractBilling() {
    SoapApi33Domain.CreateResponse qr = new SoapApi33Domain.CreateResponse();
    qr.successful = true;
    qr.eid = 12345;
    return qr;
  }
  /**
   * @description: This method is used to get Dummy invoice Adjustment Applications for test cases
   * @return SoapApi33Domain.QueryResponse,The instance of SoapApi33Domain.QueryResponse class.
   */
  public static SoapApi33Domain.QueryResponse getinvoiceAdjustmentApplications() {
    SoapApi33Domain.QueryResponse qr = new SoapApi33Domain.QueryResponse();
    qr.successful = true;

    qr.invoiceAdjustmentApplications = new SoapApi33Domain.invoiceAdjustmentApplications();
    qr.invoiceAdjustmentApplications.standardInvoiceAdjustmentApplication = new List<SoapApi33Domain.standardInvoiceAdjustmentApplication>();
    SoapApi33Domain.standardInvoiceAdjustmentApplication activeService = new SoapApi33Domain.standardInvoiceAdjustmentApplication();
    activeService.invoice = new SoapApi33Domain.Invoice();
    activeService.invoice.invoiceNum = 'invoiceNum';
    activeService.accountAdjustment = new SoapApi33Domain.Adjustment();
    activeService.accountAdjustment.eid = '1234';
    qr.invoiceAdjustmentApplications.standardInvoiceAdjustmentApplication.add(
      activeService
    );
    return qr;
  }

  /**
   * @description: This method is used to get Dummy service Usage Rules for test cases
   * @return SoapApi33Domain.QueryResponse,The instance of SoapApi33Domain.QueryResponse class.
   */
  public static SoapApi33Domain.QueryResponse getserviceUsageRules() {
    SoapApi33Domain.QueryResponse qr = new SoapApi33Domain.QueryResponse();
    qr.successful = true;
    qr.serviceUsageRules = new SoapApi33Domain.serviceUsageRules();
    qr.serviceUsageRules.matchAllServiceUsageRule = new List<SoapApi33Domain.matchAllServiceUsageRule>();
    SoapApi33Domain.matchAllServiceUsageRule usasesRule = new SoapApi33Domain.matchAllServiceUsageRule();
    usasesRule.status = 'Status';
    usasesRule.name = 'matchAll';
    usasesRule.eid = '12345 ';
    SoapApi33Domain.FlatUsageRate flatrate = new SoapApi33Domain.FlatUsageRate();
    flatrate.rate = 10;
    flatrate.uom = 'uom';
    usasesRule.flatUsageRate = flatrate;
    List<SoapApi33Domain.FormulaServiceUsageRule> formulaRuleList = new List<SoapApi33Domain.FormulaServiceUsageRule>();
    SoapApi33Domain.FormulaServiceUsageRule formulaRule = new SoapApi33Domain.FormulaServiceUsageRule();
    formulaRule.name = 'formularate';
    formulaRule.eid = '12345';
    formulaRule.status = 'Status';
    formulaRule.flatUsageRate = flatrate;
    formulaRuleList.add(formulaRule);
    List<SoapApi33Domain.GlobalServiceUsageRule> globalRuleList = new List<SoapApi33Domain.GlobalServiceUsageRule>();
    SoapApi33Domain.GlobalServiceUsageRule globalRule = new SoapApi33Domain.GlobalServiceUsageRule();
    globalRule.name = 'globalrate';
    globalRule.eid = '12345';
    globalRule.status = 'Status';
    globalRule.flatUsageRate = flatrate;
    globalRule.globalUsageRule = new SoapApi33Domain.GlobalUsageRule();
    globalRule.globalUsageRule.name = 'globalrule';
    globalRuleList.add(globalRule);
    qr.serviceUsageRules.formulaServiceUsageRule = formulaRuleList;
    qr.serviceUsageRules.globalServiceUsageRule = globalRuleList;
    qr.serviceUsageRules.matchAllServiceUsageRule.add(usasesRule);
    return qr;
  }

  /**
   * @description: This method is used to get Dummy product Usage Rules for test cases
   * @return SoapApi33Domain.QueryResponse,The instance of SoapApi33Domain.QueryResponse class.
   */
  public static SoapApi33Domain.QueryResponse getproductUsageRules() {
    SoapApi33Domain.QueryResponse qr = new SoapApi33Domain.QueryResponse();
    qr.successful = true;
    qr.productUsageRules = new SoapApi33Domain.productUsageRules();
    qr.productUsageRules.matchAllProductUsageRule = new List<SoapApi33Domain.MatchAllProductUsageRule>();
    SoapApi33Domain.MatchAllProductUsageRule usasesRule = new SoapApi33Domain.MatchAllProductUsageRule();
    SoapApi33Domain.FlatUsageRate flatUsageRate = new SoapApi33Domain.FlatUsageRate();
    flatUsageRate.rate = 10.25;
    flatUsageRate.uom = 'uomtoconvert';
    SoapApi33Domain.TableUsageRate tableUsageRate = new SoapApi33Domain.TableUsageRate();
    tableUsageRate.rateTable = new SoapApi33Domain.RateTable();
    tableUsageRate.rateTable.name = 'ratetable';
    SoapApi33Domain.PassThroughUsageRate passThroughUsageRate = new SoapApi33Domain.PassThroughUsageRate();
    passThroughUsageRate.usageFieldName = 'usageField';
    usasesRule.flatUsageRate = flatUsageRate;
    usasesRule.tableUsageRate = tableUsageRate;
    usasesRule.passThroughUsageRate = passThroughUsageRate;
    usasesRule.limit_x = 10.56;
    usasesRule.status = 'sucess';
    usasesRule.usageUom = 'usageUom';
    qr.productUsageRules.formulaProductUsageRule = new List<SoapApi33Domain.FormulaProductUsageRule>();
    SoapApi33Domain.FormulaProductUsageRule formulausasesRule = new SoapApi33Domain.FormulaProductUsageRule();
    formulausasesRule.flatUsageRate = flatUsageRate;
    formulausasesRule.tableUsageRate = tableUsageRate;
    formulausasesRule.passThroughUsageRate = passThroughUsageRate;
    formulausasesRule.limit_x = 10.56;
    formulausasesRule.status = 'sucess';
    formulausasesRule.usageUom = 'usageUom';
    qr.productUsageRules.globalProductUsageRule = new List<SoapApi33Domain.GlobalProductUsageRule>();
    SoapApi33Domain.GlobalProductUsageRule globalusasesRule = new SoapApi33Domain.GlobalProductUsageRule();
    SoapApi33Domain.GlobalUsageRule globalUsageRule = new SoapApi33Domain.GlobalUsageRule();
    globalUsageRule.Name = 'global';
    globalusasesRule.passThroughUsageRate = passThroughUsageRate;
    globalusasesRule.globalUsageRule = globalUsageRule;
    globalusasesRule.limit_x = 10.56;
    globalusasesRule.status = 'sucess';
    globalusasesRule.usageUom = 'usageUom';
    qr.productUsageRules.matchAllProductUsageRule.add(usasesRule);
    qr.productUsageRules.formulaProductUsageRule.add(formulausasesRule);
    qr.productUsageRules.globalProductUsageRule.add(globalusasesRule);
    return qr;
  }
  /**
   * @description: This method is used to get Dummy discount Identifiers for test cases
   * @return SoapApi33Domain.QueryResponse,The instance of SoapApi33Domain.QueryResponse class.
   */
  public static SoapApi33Domain.QueryResponse getdiscountIdentifiers() {
    SoapApi33Domain.QueryResponse qr = new SoapApi33Domain.QueryResponse();
    qr.successful = true;
    qr.DiscountIdentifiers = new SoapApi33Domain.DiscountIdentifiers();
    qr.DiscountIdentifiers.discountIdentifier = new List<SoapApi33Domain.discountIdentifier>();
    SoapApi33Domain.DiscountIdentifier didentifire = new SoapApi33Domain.DiscountIdentifier();
    didentifire.eid = '12345';
    qr.DiscountIdentifiers.discountIdentifier.add(didentifire);
    return qr;
  }
  /**
   * @description: This method is used to get Dummy instance of SoapApi33Domain.CreateResponse for test cases
   * @return SoapApi33Domain.CreateResponse,The instance of SoapApi33Domain.CreateResponse class.
   */
  public static SoapApi33Domain.CreateResponse getCreateresponce() {
    SoapApi33Domain.CreateResponse qr = new SoapApi33Domain.CreateResponse();
    qr.successful = true;
    qr.eid = 12345;
    return qr;
  }
  /**
   * @description: This method is used to get Dummy instance of SoapApi33Domain.CommandResponse class for test cases
   * @return SoapApi33Domain.CommandResponse,The instance of SoapApi33Domain.CommandResponse class.
   */
  public static SoapApi33Domain.CommandResponse getCommandresponse() {
    SoapApi33Domain.CommandResponse qr = new SoapApi33Domain.CommandResponse();
    qr.successful = true;
    SoapApi33Domain.OrderCommandResponse orderResponse1 = new SoapApi33Domain.OrderCommandResponse();
    orderResponse1.eid = 12345;
    qr.orderResponse = orderResponse1;
    return qr;
  }
  /**
   * @description: This method is used to get Dummy adjustment Reasons for test cases
   * @return SoapApi33Domain.QueryResponse,The instance of SoapApi33Domain.QueryResponse class.
   */
  public static SoapApi33Domain.QueryResponse getadjustmentReasons() {
    SoapApi33Domain.QueryResponse qr = new SoapApi33Domain.QueryResponse();
    qr.successful = true;
    qr.adjustmentReasons = new SoapApi33Domain.AdjustmentReasons();
    qr.adjustmentReasons.adjustmentReason = new List<SoapApi33Domain.AdjustmentReason>();
    SoapApi33Domain.AdjustmentReason reason = new SoapApi33Domain.AdjustmentReason();
    reason.eid = '12345';
    reason.name = 'reason';
    reason.creditOnly = true;
    qr.adjustmentReasons.adjustmentReason.add(reason);
    return qr;
  }
  /**
   * @description: This method is used to get Dummy TRACT Bill Cycle for test cases
   * @return List<TRACT_Bill_Cycle__c>
   */
  public static List<TRACT_Bill_Cycle__c> getTRACTBillCycle() {
    List<TRACT_Bill_Cycle__c> billCycleList = [
      SELECT id, Eid__c, Name, Bill_Cycle_Type__c
      FROM TRACT_Bill_Cycle__c
      LIMIT 100
    ];
    return billCycleList;
  }

  /**
   * @description: This method is used to get Dummy PriceList Value for test cases
   * @return SoapApi33Domain.QueryResponse,The instance of SoapApi33Domain.QueryResponse class.
   */
  public static SoapApi33Domain.QueryResponse getPriceListValue() {
    SoapApi33Domain.QueryResponse qr = new SoapApi33Domain.QueryResponse();
    SoapApi33Domain.PriceLists priceLists = new SoapApi33Domain.PriceLists();
    List<SoapApi33Domain.PriceList> priceList = new List<SoapApi33Domain.PriceList>();
    for (Integer i = 0; i < 10; i++) {
      SoapApi33Domain.PriceList price = new SoapApi33Domain.PriceList();
      price.name = 'test' + i;
      price.eid = '12345';
      priceList.add(price);
    }
    priceLists.priceList = priceList;
    qr.priceLists = priceLists;
    qr.successful = true;
    return qr;
  }
  /**
   * @description: This method is used to get Dummy Payment Methods for test cases
   * @return SoapApi33Domain.QueryResponse,The instance of SoapApi33Domain.QueryResponse class.
   */
  public static SoapApi33Domain.QueryResponse getPaymentMethods() {
    SoapApi33Domain.QueryResponse qr = new SoapApi33Domain.QueryResponse();
    qr.successful = true;
    qr.recurringPayments = new SoapApi33Domain.BillingAccountRecurringPayments();
    qr.recurringPayments.recurringPayment = new List<SoapApi33Domain.BillingAccountRecurringPayment>();
    SoapApi33Domain.TelecomAddress telecomAddress = new SoapApi33Domain.TelecomAddress();
    telecomAddress.purpose = 'Billing';
    telecomAddress.dialingPrefix = '+91';
    telecomAddress.countryCode = '123';
    telecomAddress.areaCode = '587';
    telecomAddress.number_x = '9748356214';
    telecomAddress.extension = '146';
    SoapApi33Domain.EmailAddress emailAddress = new SoapApi33Domain.EmailAddress();
    emailAddress.purpose = 'test';
    emailAddress.email = 'testmail@gmail.com';
    SoapApi33Domain.BillingAccountRecurringPayment rp1 = new SoapApi33Domain.BillingAccountRecurringPayment();
    SoapApi33Domain.BpayPaymentMethod bpayPaymentMethod = new SoapApi33Domain.BpayPaymentMethod();
    bpayPaymentMethod.billerCode = '122';
    bpayPaymentMethod.customerReferenceNumber = '1111885222';
    SoapApi33Domain.MobileCarrierPayment mobileCarrierPayment = new SoapApi33Domain.MobileCarrierPayment();
    mobileCarrierPayment.msisdn = '5128888888';
    mobileCarrierPayment.carrierName = 'Du';
    mobileCarrierPayment.nickname = 'Test';
    mobileCarrierPayment.eid = '1234';
    mobileCarrierPayment.telecomAddress = telecomAddress;
    mobileCarrierPayment.emailAddress = emailAddress;
    SoapApi33Domain.sepaDirectDebitPaymentMethod sepaDirectDebitPaymentMethod = new SoapApi33Domain.sepaDirectDebitPaymentMethod();
    sepaDirectDebitPaymentMethod.reference = '1234';
    SoapApi33Domain.TokenizedCreditCardPaymentMethod tokenizedCreditCardPaymentMethod = new SoapApi33Domain.TokenizedCreditCardPaymentMethod();
    tokenizedCreditCardPaymentMethod.token = 'test';
    tokenizedCreditCardPaymentMethod.cardType = 'visa';
    tokenizedCreditCardPaymentMethod.cardHolderFirstName = 'test';
    tokenizedCreditCardPaymentMethod.cardHolderLastName = 'test';
    tokenizedCreditCardPaymentMethod.cardIdentifierNumber = '1111';
    tokenizedCreditCardPaymentMethod.cardExpiration = '04/2022';
    tokenizedCreditCardPaymentMethod.nickname = 'testNickName';
    tokenizedCreditCardPaymentMethod.telecomAddress = telecomAddress;
    tokenizedCreditCardPaymentMethod.emailAddress = emailAddress;
    SoapApi33Domain.PayPalPaymentMethod payPalPaymentMethod = new SoapApi33Domain.PayPalPaymentMethod();
    payPalPaymentMethod.preapprovalKey = '147895';
    SoapApi33Domain.BankPaymentMethod bankPaymentMethod = new SoapApi33Domain.BankPaymentMethod();
    bankPaymentMethod.bankName = 'testBank';
    bankPaymentMethod.bankRoutingNumber = '147369';
    bankPaymentMethod.bankAccountType = 'savings';
    bankPaymentMethod.bankAccountNumber = '789423651';
    bankPaymentMethod.bankCheckNumber = '1473658';
    bankPaymentMethod.nickname = 'testNickName';
    bankPaymentMethod.telecomAddress = telecomAddress;
    bankPaymentMethod.emailAddress = emailAddress;
    SoapApi33Domain.creditCardPaymentMethod creditCardPaymentMethod = new SoapApi33Domain.creditCardPaymentMethod();
    creditCardPaymentMethod.cardType = 'visa';
    creditCardPaymentMethod.cardHolderFirstName = 'test';
    creditCardPaymentMethod.cardHolderLastName = 'test';
    creditCardPaymentMethod.cardIdentifierNumber = '1111';
    creditCardPaymentMethod.cardExpiration = '04/2022';
    creditCardPaymentMethod.nickname = 'testNickName';
    creditCardPaymentMethod.telecomAddress = telecomAddress;
    creditCardPaymentMethod.emailAddress = emailAddress;
    rp1.bankPaymentMethod = bankPaymentMethod;
    rp1.payPalPaymentMethod = payPalPaymentMethod;
    rp1.bpayPaymentMethod = bpayPaymentMethod;
    rp1.mobileCarrierPayment = mobileCarrierPayment;
    rp1.sepaDirectDebitPaymentMethod = sepaDirectDebitPaymentMethod;
    rp1.tokenizedCreditCardPaymentMethod = tokenizedCreditCardPaymentMethod;
    rp1.creditCardPaymentMethod = creditCardPaymentMethod;
    rp1.validFrom = System.Now();
    qr.recurringPayments.recurringPayment.add(rp1);
    return qr;
  }
  /**
   * @description: This method is used to get Dummy Notes for test cases
   * @return SoapApi33Domain.QueryResponse,The instance of SoapApi33Domain.QueryResponse class.
   */
  public static SoapApi33Domain.QueryResponse getNotes() {
    SoapApi33Domain.QueryResponse qr = new SoapApi33Domain.QueryResponse();
    qr.successful = true;
    qr.Notes = new SoapApi33Domain.Notes();
    qr.Notes.note = new List<SoapApi33Domain.note>();
    SoapApi33Domain.Note note = new SoapApi33Domain.Note();
    SoapApi33Domain.NoteType noteType = new SoapApi33Domain.NoteType();
    noteType.name = 'test';
    SoapApi33Domain.User user = new SoapApi33Domain.User();
    user.username = 'test';
    SoapApi33Domain.Person person = new SoapApi33Domain.Person();
    note.content = 'testContent';
    note.noteType = noteType;
    note.user = user;
    note.person = person;
    qr.Notes.note.add(note);
    return qr;
  }
  /*Method added to get order response in the test class */
  /**
   * @description: This method is used to get Dummy Orders for test cases
   * @return SoapApi33Domain.QueryResponse,The instance of SoapApi33Domain.QueryResponse class.
   */
  public static SoapApi33Domain.QueryResponse getOrders() {
    SoapApi33Domain.QueryResponse qr = new SoapApi33Domain.QueryResponse();
    qr.successful = true;
    qr.orders = new SoapApi33Domain.Orders();
    SoapApi33Domain.SalesOrder p1 = new SoapApi33Domain.SalesOrder();
    p1.orderItems = new SoapApi33Domain.OrderItems();
    SoapApi33Domain.OrderItem orderItem = new SoapApi33Domain.OrderItem();
    SoapApi33Domain.ServiceResources serviceResources = new SoapApi33Domain.ServiceResources();
    serviceResources.ServiceResource = new List<SoapApi33Domain.ServiceResource>();
    SoapApi33Domain.ServiceResource serviceResource1 = new SoapApi33Domain.ServiceResource();
    serviceResource1.identifier = 'identidire';
    serviceResource1.eid = '12345';
    serviceResources.ServiceResource.add(serviceResource1);
    orderItem.serviceResources = serviceResources;
    p1.orderItems.orderItem = new List<SoapApi33Domain.OrderItem>();
    p1.orderItems.orderItem.add(orderItem);
    p1.eid = '32933';
    p1.orderDate = String.valueOf(System.Now());
    p1.purchaseOrderNumber = 'PO1234';
    p1.orderStatus = 'ACTIVE';
    p1.orderNum = 'sadf';
    p1.note = 'asdfasdf';
    p1.billingAccount = getTractBillingAccount();
    p1.taxTotal = 3576;
    qr.orders.salesOrder = p1;
    return qr;
  }

  /*Method added to get service custom field response in the test class */
  /**
   * @description: This method is used to get Dummy Service Custom Fields for test cases
   * @return List<Tract_Service_Custom_Field__c>
   */
  public static List<Tract_Service_Custom_Field__c> queryServiceCustomFields() {
    List<Tract_Service_Custom_Field__c> fldList = new List<Tract_Service_Custom_Field__c>();
    Tract_Service_Custom_Field__c fld = new Tract_Service_Custom_Field__c();
    fld.Name = 'Test';
    fld.value__c = 'Test';
    fld.ValidationType__c = 'Test';
    fld.StoreListValue__c = 'Test';
    fld.eid__c = 'Test';
    fld.FieldType__c = 'Test';
    fldList.add(fld);
    return fldList;
  }

  /*Method added to get contact response in the test class */
  /**
   * @description: This method is used to get Dummy Contacts for test cases
   * @return SoapApi33Domain.QueryResponse,The instance of SoapApi33Domain.QueryResponse class.
   */
  public static SoapApi33Domain.QueryResponse getContacts() {
    SoapApi33Domain.QueryResponse qr = new SoapApi33Domain.QueryResponse();
    qr.successful = true;
    qr.people = new SoapApi33Domain.people();
    qr.people.totalPages = 1;
    List<SoapApi33Domain.person> personList = new List<SoapApi33Domain.person>();
    SoapApi33Domain.person p1 = new SoapApi33Domain.person();
    p1.firstName = 'Test';
    p1.middleName = 'Test';
    p1.lastName = 'Test';
    p1.suffix = 'Test';
    p1.title = 'Test';
    p1.department = 'Test';
    p1.addresses = new SoapApi33Domain.addresses_element();
    List<SoapApi33Domain.TelecomAddress> telecomAddressList = new List<SoapApi33Domain.TelecomAddress>();
    List<SoapApi33Domain.EmailAddress> emailAddressList = new List<SoapApi33Domain.EmailAddress>();
    SoapApi33Domain.TelecomAddress telecomAddress = new SoapApi33Domain.TelecomAddress();
    telecomAddress.purpose = 'mobile';
    telecomAddress.dialingPrefix = '+91';
    telecomAddress.countryCode = '123';
    telecomAddress.areaCode = '587';
    telecomAddress.number_x = '9748356214';
    telecomAddress.extension = '146';
    telecomAddressList.add(telecomAddress);
    SoapApi33Domain.EmailAddress emailAddress = new SoapApi33Domain.EmailAddress();
    emailAddress.purpose = 'test';
    emailAddress.email = 'testmail@gmail.com';
    emailAddressList.add(emailAddress);
    p1.addresses.emailAddress = emailAddressList;
    p1.addresses.telecomAddress = telecomAddressList;
    personList.add(p1);
    qr.people.person = personList;
    return qr;
  }
  /**
   * @description: This method is used to save Dummy Account Custom Field for test cases
   * @return SoapApi33Domain.BatchResponse,The instance of SoapApi33Domain.BatchResponse class.
   */
  public static SoapApi33Domain.BatchResponse saveAccountCustomField() {
    SoapApi33Domain.BatchResponse commandResAddBillingCustom = new SoapApi33Domain.BatchResponse();
    commandResAddBillingCustom.errorOccurred = true;
    commandResAddBillingCustom.errors = new SoapApi33Domain.errors_element();
    commandResAddBillingCustom.errors.error = new List<SoapApi33Service.FaultResponse>{};
    SoapApi33Service.FaultResponse faultError = new SoapApi33Service.FaultResponse();
    faultError.message = 'Validation : error messaage';
    commandResAddBillingCustom.errors.error.add(faultError);
    return commandResAddBillingCustom;
  }
  /**
   * @description: This method is used to get Dummy Discount Code Services for test cases
   * @return SoapApi33Domain.QueryResponse,The instance of SoapApi33Domain.QueryResponse class.
   */
  public static SoapApi33Domain.QueryResponse queryDiscountCodeServices() {
    SoapApi33Domain.QueryResponse qr = new SoapApi33Domain.QueryResponse();
    qr.successful = true;
    SoapApi33Domain.DiscountCodeServices discountCodeServices = new SoapApi33Domain.DiscountCodeServices();
    SoapApi33Domain.DiscountCodeService[] discountCodeServiceList = new List<SoapApi33Domain.DiscountCodeService>{};
    SoapApi33Domain.DiscountCodeService discountCodeService = new SoapApi33Domain.DiscountCodeService();
    discountCodeService.validFrom = System.now();
    discountCodeService.validTo = System.now();
    discountCodeService.amount = 20.0;
    discountCodeService.duration = 20;
    SoapApi33Domain.DiscountCode discountCode = new SoapApi33Domain.DiscountCode();
    discountCode.name = 'test';
    SoapApi33Domain.Discount discount = new SoapApi33Domain.Discount();
    discount.name = 'test';
    discount.type_x = 'test';
    discount.currencyType = 'USD';
    SoapApi33Domain.DiscountCategory discountCategory = new SoapApi33Domain.DiscountCategory();
    discountCategory.name = 'test';
    discount.discountCategory = discountCategory;
    discountCode.discount = discount;
    discountCodeService.discountCode = discountCode;
    discountCodeServiceList.add(discountCodeService);
    discountCodeServices.discountCodeService = discountCodeServiceList;
    qr.discountCodeServices = discountCodeServices;
    return qr;
  }
  /**
   * @description: This method is used to get Dummy Invoice Items for test cases
   * @return SoapApi33Domain.InvoiceItems,The instance of SoapApi33Domain.InvoiceItems class.
   */
  public static SoapApi33Domain.InvoiceItems getInvoiceItems() {
    SoapApi33Domain.Service service = new SoapApi33Domain.Service();
    service.description = 'Test';
    SoapApi33Domain.InvoiceItems invoiceItems = new SoapApi33Domain.InvoiceItems();
    InvoiceItems.manualInvoiceItem = new List<SoapApi33Domain.manualInvoiceItem>();
    SoapApi33Domain.ManualInvoiceItem manualInvoiceItem = new SoapApi33Domain.ManualInvoiceItem();
    manualInvoiceItem.lineItemType = 'Test';
    manualInvoiceItem.description = 'Test';
    manualInvoiceItem.unitAmount = 20;
    manualInvoiceItem.totalAmount = 20;
    manualInvoiceItem.service = service;
    InvoiceItems.manualInvoiceItem.add(manualInvoiceItem);
    InvoiceItems.serviceInvoiceItem = new List<SoapApi33Domain.serviceInvoiceItem>();
    SoapApi33Domain.serviceInvoiceItem serviceInvoiceItem = new SoapApi33Domain.serviceInvoiceItem();
    serviceInvoiceItem.lineItemType = 'Test';
    serviceInvoiceItem.description = 'Test';
    serviceInvoiceItem.unitAmount = 20;
    serviceInvoiceItem.totalAmount = 20;
    serviceInvoiceItem.service = service;
    InvoiceItems.serviceInvoiceItem.add(serviceInvoiceItem);
    InvoiceItems.ManualServiceInvoiceItem = new List<SoapApi33Domain.ManualServiceInvoiceItem>();
    SoapApi33Domain.ManualServiceInvoiceItem manualServiceInvoiceItem = new SoapApi33Domain.ManualServiceInvoiceItem();
    manualServiceInvoiceItem.lineItemType = 'Test';
    manualServiceInvoiceItem.description = 'Test';
    manualServiceInvoiceItem.unitAmount = 20;
    manualServiceInvoiceItem.totalAmount = 20;
    manualServiceInvoiceItem.service = service;
    InvoiceItems.ManualServiceInvoiceItem.add(ManualServiceInvoiceItem);
    return invoiceItems;
  }
  /**
   * @description: This method is used to get Dummy Product Category for test cases
   * @return SoapApi33Domain.QueryResponse,The instance of SoapApi33Domain.QueryResponse class.
   */
  public static SoapApi33Domain.QueryResponse queryProductCategory() {
    SoapApi33Domain.QueryResponse qr = new SoapApi33Domain.QueryResponse();
    qr.successful = true;
    SoapApi33Domain.ProductCategories catgs = new SoapApi33Domain.ProductCategories();
    list<SoapApi33Domain.ProductCategory> catList = new List<SoapApi33Domain.ProductCategory>();
    SoapApi33Domain.ProductCategory cat = new SoapApi33Domain.ProductCategory();
    cat.name = 'test';
    cat.eid = '12345';
    catList.add(cat);
    catgs.productCategories = catList;
    qr.productCategories = catgs;
    return qr;
  }
  /**
   * @description: This method is used to get Dummy Service Resource Categories for test cases
   * @return SoapApi33Domain.QueryResponse,The instance of SoapApi33Domain.QueryResponse class.
   */
  public static SoapApi33Domain.QueryResponse queryServiceResourceCategories() {
    SoapApi33Domain.QueryResponse qr = new SoapApi33Domain.QueryResponse();
    qr.successful = true;
    SoapApi33Domain.ServiceResourceCategories catgs = new SoapApi33Domain.ServiceResourceCategories();
    list<SoapApi33Domain.ServiceResourceCategory> catList = new List<SoapApi33Domain.ServiceResourceCategory>();
    SoapApi33Domain.ServiceResourceCategory cat = new SoapApi33Domain.ServiceResourceCategory();
    cat.name = 'test';
    cat.eid = '12345';
    catList.add(cat);
    catgs.serviceResourceCategory = catList;
    qr.serviceResourceCategories = catgs;
    return qr;
  }
  /**
   * @description: This method is used to get Dummy Product Tags for test cases
   * @return SoapApi33Domain.QueryResponse,The instance of SoapApi33Domain.QueryResponse class.
   */
  public static SoapApi33Domain.QueryResponse queryProductTags() {
    SoapApi33Domain.QueryResponse qr = new SoapApi33Domain.QueryResponse();
    qr.successful = true;
    SoapApi33Domain.ProductTags catgs = new SoapApi33Domain.ProductTags();
    list<SoapApi33Domain.ProductTag> catList = new List<SoapApi33Domain.ProductTag>();
    SoapApi33Domain.ProductTag cat = new SoapApi33Domain.ProductTag();
    cat.name = 'test';
    cat.eid = '12345';
    catList.add(cat);
    catgs.productTags = catList;
    qr.productTags = catgs;
    return qr;
  }
  /**
   * @description: This method is used to get Dummy Market Places for test cases
   * @return SoapApi33Domain.QueryResponse,The instance of SoapApi33Domain.QueryResponse class.
   */
  public static SoapApi33Domain.QueryResponse queryMarketPlaces() {
    SoapApi33Domain.QueryResponse qr = new SoapApi33Domain.QueryResponse();
    qr.successful = true;
    qr.marketPlaces = new SOAPAPI33Domain.MarketPlaces();
    qr.marketPlaces.marketPlace = new List<SOAPAPI33Domain.MarketPlace>();
    SOAPAPI33Domain.MarketPlace marketPlace = new SOAPAPI33Domain.MarketPlace();
    marketPlace.name = 'Test';
    marketPlace.fromDate = System.now();
    marketPlace.description = 'Test';
    marketPlace.eid = 'Test';
    qr.marketPlaces.marketPlace.add(marketPlace);
    return qr;
  }
}