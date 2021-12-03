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
 * This is a utility class for API callouts.
 * @author AMAN JAIN
 */

public with sharing class GTVAPIUtil {
  /**
   * @description: Fetch the payment id and invoice number from the GTV payment application and return a map of it.
   * @param tractPaymentApplicationList, The list of GTV payment application.
   * @return Map<String, String>, The Map of paymentId vs comma seprated Invoice number.
   */
  public static Map<String, String> getPaymentToInvoicesMapFromPaymentApp(
    List<RestAPI2Domain.GTVAPIPaymentApplication> tractPaymentApplicationList
  ) {
    Map<String, String> paymentToInvoices = new Map<String, String>();
    for (
      RestAPI2Domain.GTVAPIPaymentApplication payAppObject : tractPaymentApplicationList
    ) {
      if (paymentToInvoices.containsKey(payAppObject.payment.Id)) {
        String invoices = paymentToInvoices.get(payAppObject.payment.Id);
        invoices = invoices + ', ' + payAppObject.invoice.invoiceNum;
        paymentToInvoices.put(payAppObject.payment.Id, invoices);
      } else {
        paymentToInvoices.put(
          payAppObject.payment.Id,
          payAppObject.invoice.invoiceNum
        );
      }
    }
    return paymentToInvoices;
  }

  /**
   * @description: Fetch the string from the GTV telecom address.
   * @param paymentMethodObj, The RestAPI2Domain.GTVAPIRecurringPayment instance.
   * @return String, concatenated string genrated from GTV telecom address.
   */
  public static String getTelecomAddressDetails(
    RestAPI2Domain.GTVAPIRecurringPayment paymentMethodObj
  ) {
    String countryCode = '';
    String areaCode = '';
    String number_x = '';
    String extension = '';
    String phn;
    if (paymentMethodObj.paymentMethod.telecomAddress.countryCode != null) {
      countryCode =
        '+' + paymentMethodObj.paymentMethod.telecomAddress.countryCode;
    }
    if (paymentMethodObj.paymentMethod.telecomAddress.areaCode != null) {
      areaCode =
        ' (' +
        paymentMethodObj.paymentMethod.telecomAddress.areaCode +
        ') ';
    }
    if (paymentMethodObj.paymentMethod.telecomAddress.r_number != null) {
      number_x = paymentMethodObj.paymentMethod.telecomAddress.r_number;
    }
    if (paymentMethodObj.paymentMethod.telecomAddress.extension != null) {
      extension =
        ' Extn:' + paymentMethodObj.paymentMethod.telecomAddress.extension;
    }
    phn = countryCode + '' + areaCode + '' + number_x + '' + extension;
    return phn;
  }

  /**
   * @description: Fetch the string from the GTV postal address.
   * @param paymentMethodObj, The RestAPI2Domain.GTVAPIRecurringPayment instance.
   * @return String, concatenated string genrated from GTV postal address.
   */
  public static String getPostalAddress(
    RestAPI2Domain.GTVAPIRecurringPayment paymentMethodObj
  ) {
    String address;
    address = paymentMethodObj.paymentMethod.postalAddress.line1 + ' ';
    if (paymentMethodObj.paymentMethod.postalAddress.line2 != null) {
      address += paymentMethodObj.paymentMethod.postalAddress.line2 + ' ';
    }
    if (paymentMethodObj.paymentMethod.postalAddress.city != null) {
      address += paymentMethodObj.paymentMethod.postalAddress.city + ',';
    }
    if (paymentMethodObj.paymentMethod.postalAddress.regionOrState != null) {
      address +=
        paymentMethodObj.paymentMethod.postalAddress.regionOrState + ' ';
    }
    if (paymentMethodObj.paymentMethod.postalAddress.postalCode != null) {
      address += paymentMethodObj.paymentMethod.postalAddress.postalCode + ' ';
    }
    if (paymentMethodObj.paymentMethod.postalAddress.country != null) {
      address += paymentMethodObj.paymentMethod.postalAddress.country;
    }
    return address;
  }

  /**
   * @description: Fetch the nickname from the GTV recurring payment instance.
   * @param paymentMethodObj, The RestAPI2Domain.GTVAPIRecurringPayment instance.
   * @return String, nickname from the recurring payment instance.
   */
  public static String getNickName(
    RestAPI2Domain.GTVAPIRecurringPayment paymentMethodObj
  ) {
    String name;
    name = paymentMethodObj.paymentMethod.nickname;
    return name;
  }

  /**
   * @description: Fetch the email from the GTV recurring payment instance.
   * @param paymentMethodObj, The RestAPI2Domain.GTVAPIRecurringPayment instance.
   * @return String, email from the recurring payment instance.
   */
  public static String getEmail(
    RestAPI2Domain.GTVAPIRecurringPayment paymentMethodObj
  ) {
    String email;
    email = paymentMethodObj.paymentMethod.emailAddress.email;
    return email;
  }
}