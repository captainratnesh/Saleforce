/**
 * Unpublished Work. Copyright 2009-2018 Transverse, LLC. All Rights Reserved.
 * This software contains confidential and trade secret information of:GTV
 * Transverse, LLC.
 * 620 Congress Ave.
 * Suite 200
 * Austin, TX 78701
 * USA
 * Use, duplication or disclosure of this software is prohibited
 * without prior written permission of Transverse, LLC.
 */

/**
 * This class Maps the data from salesforce object records to GTV objects.
 * @Author AMAN JAIN
 */

public with sharing class GTVRESTReverseMappingService {
  /**
   * @description: Map the salesforce Address to the GTV Address object.
   * @param ShippingCountry, Shipping country of the address.
   * @param addressLine1, Line1 of the address.
   * @param addressLine2, Line2 of the address.
   * @param ShippingCity, ShippingCity of the address.
   * @param stateValue, Shipping state of the address.
   * @param postalCode, Postal code of the address.
   * @return RestAPI2Domain.GTVAPIAddServiceAddress, The instance of RestAPI2Domain.GTVAPIAddServiceAddress class.
   */
  public static RestAPI2Domain.GTVAPIAddServiceAddress mapAddAddressGTV(
    String shippingCountry,
    String addressLine1,
    String addressLine2,
    String shippingCity,
    String stateValue,
    String postalCode
  ) {
    RestAPI2Domain.GTVAPIAddServiceAddress addAddressToService = new RestAPI2Domain.GTVAPIAddServiceAddress();
    RestAPI2Domain.GTVAPICreatePostalAddress postalAddress = new RestAPI2Domain.GTVAPICreatePostalAddress();
    postalAddress.purpose = RestAPI2Domain.GTVAPIPostalAddressPurpose.SERVICE;
    postalAddress.country = shippingCountry;
    postalAddress.city = shippingCity;
    postalAddress.regionOrState = stateValue;
    postalAddress.postalCode = postalCode;
    postalAddress.line1 = addressLine1;
    postalAddress.address_type = RestAPI2Domain.GTVAPIAddressType.postal;
    if ('' != addressLine2 && addressLine2 != null) {
      postalAddress.line2 = addressLine2;
    }
    addAddressToService.address = postalAddress;

    return addAddressToService;
  }

  /**
   * @description: Map the user input for adjustment to the GTV Adjustment object.
   * @param effectiveDate, The effective date on the adjustment.
   * @param adjustmentReasonEid, The GTV id for adjustment reason.
   * @param ammount, Adjustment amount.
   * @param description, The description on the adjustment.
   * @param tAccount, The billing account wrapper instance.
   * @param manualInvoice, if the adustment has to invoiced manually or not.
   * @param isCredit, if the adjustment is a credit adjustment or not.
   * @return RestAPI2Domain.GTVAPICreateAccountAdjustment, The instance of RestAPI2Domain.GTVAPICreateAccountAdjustment class.
   */
  public static RestAPI2Domain.GTVAPICreateAccountAdjustment mapAdjustment(
    String effectiveDate,
    string adjustmentReasonEid,
    String ammount,
    String description,
    TRACTAccountWrapper tAccount,
    boolean manualInvoice,
    boolean isCredit
  ) {
    RestAPI2Domain.GTVAPICreateAccountAdjustment createAdjustment = new RestAPI2Domain.GTVAPICreateAccountAdjustment();
    createAdjustment.amount = Double.valueof(ammount);
    createAdjustment.description = description;
    RestAPI2Domain.GTVAPIBillingAccountRef billingAccountRef = new RestAPI2Domain.GTVAPIBillingAccountRef();
    billingAccountRef.id = tAccount.eid;
    createAdjustment.billing_account = billingAccountRef;
    RestAPI2Domain.GTVAPIAdjustmentReasonRef adjustmentReasonRef = new RestAPI2Domain.GTVAPIAdjustmentReasonRef();
    adjustmentReasonRef.id = adjustmentReasonEid;
    createAdjustment.reason = adjustmentReasonRef;
    createAdjustment.occurred_on = ZConvert.getFormattedDateTimeString(
      Date.valueOf(effectiveDate),
      'yyyy-MM-dd\'T\'HH:mm:ss.SSSXXX'
    );
    if (isCredit) {
      createAdjustment.manual_invoice_application = manualInvoice;
    }
    return createAdjustment;
  }

  /**
   * @description: Map the user input for deactivating service to the GTV deactivate service object.
   * @param reasonEid, The GTV id for deactivation reason.
   * @param deactivationDate, The deactivation date on the service.
   * @return RestAPI2Domain.GTVAPIDeactivateService, The instance of RestAPI2Domain.GTVAPIDeactivateService class.
   */
  public static RestAPI2Domain.GTVAPIDeactivateService mapDeactivateService(
    String reasonEid,
    String deactivationDate
  ) {
    RestAPI2Domain.GTVAPIDeactivateService deactivateService = new RestAPI2Domain.GTVAPIDeactivateService();
    if (deactivationDate != null) {
      deactivationDate = deactivationDate.replace(' ', 'T');
      deactivateService.effectiveDate = (deactivationDate);
    }
    RestAPI2Domain.GTVAPIServiceDeactivationReasonRef reasonRef = new RestAPI2Domain.GTVAPIServiceDeactivationReasonRef();
    reasonRef.id = reasonEid;
    reasonRef.reasonType = 'service-deactivation';
    reasonRef.reasonEntityType = RestAPI2Domain.GTVAPIReasonType.SERVICE;
    deactivateService.reason = reasonRef;
    return deactivateService;
  }

  /**
   * @description: Map the user input for suspending service to the GTV suspend service object.
   * @param reasonEid, The GTV id for suspension reason.
   * @return RestAPI2Domain.GTVAPISuspendService, The instance of RestAPI2Domain.GTVAPISuspendService class.
   */
  public static RestAPI2Domain.GTVAPISuspendService mapSuspendService(
    String reasonEid
  ) {
    RestAPI2Domain.GTVAPISuspendService suspendService = new RestAPI2Domain.GTVAPISuspendService();
    RestAPI2Domain.GTVAPIServiceSuspensionReasonRef reasonRef = new RestAPI2Domain.GTVAPIServiceSuspensionReasonRef();
    reasonRef.id = reasonEid;
    reasonRef.reasonType = 'service-suspension';
    suspendService.reason = reasonRef;
    return suspendService;
  }

  /**
   * @description: Map the user input for service resource to the GTV add service resource object.
   * @param srId, The service resource identifier.
   * @param serviceResponsemap, The service resource category list.
   * @param effectiveDate, The effective date on the service resource.
   * @return RestAPI2Domain.GTVAPISuspendService, The instance of RestAPI2Domain.GTVAPISuspendService class.
   */
  public static RestAPI2Domain.GTVAPIAddServiceResource mapAddServiceResoure(
    String srId,
    list<RestAPI2Domain.GTVAPIResourceCategory> serviceResponsemap,
    String effectiveDate
  ) {
    RestAPI2Domain.GTVAPIAddServiceResource addServiceResource = new RestAPI2Domain.GTVAPIAddServiceResource();
    if (null != effectiveDate && effectiveDate != 'null') {
      addServiceResource.effectiveDate = (Date) JSON.deserialize(
        effectiveDate,
        Date.class
      );
    }
    RestAPI2Domain.GTVAPICreateOrAddServiceResource createResource = new RestAPI2Domain.GTVAPICreateOrAddServiceResource();
    createResource.identifier = srId;
    createResource.resourceType = RestAPI2Domain.GTVAPIResourceType.SERVICE;
    RestAPI2Domain.GTVAPIResourceCategoryRef resourceCategory = new RestAPI2Domain.GTVAPIResourceCategoryRef();
    resourceCategory.id = serviceResponsemap[0].id;
    createResource.category = resourceCategory;
    addServiceResource.serviceResource = createResource;
    return addServiceResource;
  }

  /* API not available */
  public static RestAPI2Domain.GTVAPIChangeService mapChangeServiceRequest(
    List<RestAPI2Domain.GTVAPIOrderItem> responseOrderItemMap,
    Boolean preserveAgreement
  ) {
    RestAPI2Domain.GTVAPIChangeService suspendService = new RestAPI2Domain.GTVAPIChangeService();
    suspendService.preserveAgreement = preserveAgreement;
    return suspendService;
  }

  /**
   * @description: Map the user input for activity charge rule to the GTV create service usage rule object.
   * @param serviceWrapper, The ProductServiceWrapper class instance.
   * @return RestAPI2Domain.GTVAPICreateServiceUsageRule, The instance of RestAPI2Domain.GTVAPICreateServiceUsageRule class.
   */
  public static RestAPI2Domain.GTVAPICreateServiceUsageRule mapNewActivityChargeRule(
    ProductServiceWrapper serviceWrapper
  ) {
    String productUsageValue = serviceWrapper.chargeRuleWrapper.productUsageRuleListValue;
    String chargeCategoryValue = serviceWrapper.chargeRuleWrapper.chargeCategoryListValue;
    String allowanceValue = serviceWrapper.chargeRuleWrapper.allowanceTypeListValue;
    String amoutChargeSelect = serviceWrapper.chargeRuleWrapper.amountChargePickList !=
      null
      ? serviceWrapper.chargeRuleWrapper.amountChargePickList
      : '';
    String statusValue = serviceWrapper.chargeRuleWrapper.selectStatusListValue;
    String rateTypeValue = serviceWrapper.chargeRuleWrapper.rateTypeListValue;
    String selectedCharge = serviceWrapper.chargeRuleWrapper.chargesPicklistValue;
    String chargeListByteValue = serviceWrapper.chargeRuleWrapper.chargeListBytesValue;
    String chargeFormulaFieldValue = serviceWrapper.chargeRuleWrapper.formulaFieldValue;
    String passThroughListValue = serviceWrapper.chargeRuleWrapper.passThroughChargeListValue;
    String fieldvalue = serviceWrapper.chargeRuleWrapper.formulaFieldValue;
    String selectedChargeGlobal = serviceWrapper.chargeRuleWrapper.chargesPicklistValue;
    String rollOverValue = serviceWrapper.chargeRuleWrapper.roleOverListValue;
    String serviceUsageRuleName = serviceWrapper.chargeRuleWrapper.ServiceUsageRuleName;
    Boolean prorateOnOrder = serviceWrapper.chargeRuleWrapper.prorateOnOrder;
    Boolean prorateOnCancel = serviceWrapper.chargeRuleWrapper.prorateOnCancel;
    Double ammountValue = serviceWrapper.chargeRuleWrapper.ammountValue;
    String activityFormulaValue = serviceWrapper.chargeRuleWrapper.ActivityFormulaValue;
    Decimal chargeValue = serviceWrapper.chargeRuleWrapper.chargeValue;
    String operationListValue = serviceWrapper.chargeRuleWrapper.operationListValue;
    String checkRuleTypeValue = serviceWrapper.ruleTypeValue;
    RestAPI2Domain.GTVAPICreateServiceUsageRule serviceUsageRule = new RestAPI2Domain.GTVAPICreateServiceUsageRule();
    serviceUsageRule.usageRuleType = 'service';
    serviceUsageRule.name = serviceUsageRuleName;
    serviceUsageRule.ruleType = RestAPI2Domain.GTVAPIRuleType.TAPERED;
    for (
      RestAPI2Domain.GTVAPIServiceUsageRuleStatus status : RestAPI2Domain.GTVAPIServiceUsageRuleStatus.values()
    ) {
      if (status.name() == statusValue.toUpperCase()) {
        serviceUsageRule.status = status;
      }
    }
    serviceUsageRule.allowanceAmount = ammountValue;
    for (
      RestAPI2Domain.GTVAPIUsageDurationUom uom : RestAPI2Domain.GTVAPIUsageDurationUom.values()
    ) {
      if (uom.name() == amoutChargeSelect.toUpperCase()) {
        serviceUsageRule.allowanceUom = uom;
      }
    }
    serviceUsageRule.proratedOnOrder = prorateOnOrder;
    serviceUsageRule.proratedOnCancel = prorateOnCancel;
    for (
      RestAPI2Domain.GTVAPIRollOverType type : RestAPI2Domain.GTVAPIRollOverType.values()
    ) {
      if (type.name() == rollOverValue.toUpperCase()) {
        serviceUsageRule.rollOverType = type;
      }
    }
    for (
      RestAPI2Domain.GTVAPIAllowanceType type : RestAPI2Domain.GTVAPIAllowanceType.values()
    ) {
      if (type.name() == allowanceValue.toUpperCase()) {
        serviceUsageRule.allowanceType = type;
      }
    }
    if (productUsageValue == 'Match All Events') {
      RestAPI2Domain.GTVAPICreateUsageRuleSpecification spec = new RestAPI2Domain.GTVAPICreateUsageRuleSpecification();
      spec.usageRuleSpecificationType = 'match-all';
      serviceUsageRule.spec = spec;
    } else if (productUsageValue == 'Formula') {
      RestAPI2Domain.GTVAPICreateUsageRuleSpecification spec = new RestAPI2Domain.GTVAPICreateUsageRuleSpecification();
      spec.usageRuleSpecificationType = 'formula';
      spec.operator = operationListValue;
      spec.field_name = chargeFormulaFieldValue.toUpperCase();
      spec.field_value = activityFormulaValue;
      serviceUsageRule.spec = spec;
    }

    if (rateTypeValue == 'Flat') {
      RestAPI2Domain.GTVAPICreateUsageRate rate = new RestAPI2Domain.GTVAPICreateUsageRate();
      rate.rateType = 'flat';
      rate.uom = selectedCharge.toUpperCase();
      rate.rate = chargeValue;
      RestAPI2Domain.GTVAPIUsageChargeCategoryRef cat = new RestAPI2Domain.GTVAPIUsageChargeCategoryRef();
      cat.chargeCategoryType = 'usage-charge';
      cat.id = chargeCategoryValue;
      rate.chargeCategory = cat;
      serviceUsageRule.usageRate = rate;
    }
    if (rateTypeValue == 'Table Rate') {
      RestAPI2Domain.GTVAPICreateUsageRate rate = new RestAPI2Domain.GTVAPICreateUsageRate();
      rate.rateType = 'table';
      rate.uom = amoutChargeSelect.toUpperCase();
      rate.usage_field_name = chargeFormulaFieldValue.toUpperCase();
      RestAPI2Domain.GTVAPIRateTable rateTable = new RestAPI2Domain.GTVAPIRateTable();
      rateTable.id = chargeListByteValue;
      rate.rate_table = rateTable;
      RestAPI2Domain.GTVAPIUsageChargeCategoryRef cat = new RestAPI2Domain.GTVAPIUsageChargeCategoryRef();
      cat.chargeCategoryType = 'usage-charge';
      cat.id = chargeCategoryValue;
      rate.chargeCategory = cat;
      serviceUsageRule.usageRate = rate;
    }
    if (rateTypeValue == 'Pass Through') {
      RestAPI2Domain.GTVAPICreateUsageRate rate = new RestAPI2Domain.GTVAPICreateUsageRate();
      rate.rateType = 'pass-through';
      rate.uom = 'EVENT';
      rate.usage_field_name = passThroughListValue.toUpperCase();
      RestAPI2Domain.GTVAPIUsageChargeCategoryRef cat = new RestAPI2Domain.GTVAPIUsageChargeCategoryRef();
      cat.chargeCategoryType = 'usage-charge';
      cat.id = chargeCategoryValue;
      rate.chargeCategory = cat;
      serviceUsageRule.usageRate = rate;
    }
    return serviceUsageRule;
  }

  /**
   * @description:Get request to update quantity of a service in GTV db.
   * @param updateserviceQuantity, The updated service quantity.
   * @param displayEffectiveDate, if the effective date to be mapped or not.
   * @param effectiveDate, The effective date from which this quantity applied.
   * @return RestAPI2Domain.GTVAPIChangeServiceQuantity, The instance of RestAPI2Domain.GTVAPIChangeServiceQuantity class.
   */
  public static RestAPI2Domain.GTVAPIChangeServiceQuantity mapServiceQuantity(
    Decimal updateserviceQuantity,
    Boolean displayEffectiveDate,
    String effectiveDate
  ) {
    RestAPI2Domain.GTVAPIChangeServiceQuantity changeServiceQuantityObj = new RestAPI2Domain.GTVAPIChangeServiceQuantity();
    changeServiceQuantityObj.newQuantity = updateserviceQuantity;
    if (displayEffectiveDate) {
      changeServiceQuantityObj.effectiveDate = Date.valueof(effectiveDate);
    }
    return changeServiceQuantityObj;
  }

  /**
   * @description: Map the user input for suspending billing account to the GTV suspend billing account object.
   * @param reasonEid, The GTV id for suspension reason.
   * @return RestAPI2Domain.GTVAPISuspendBillingAccount, The instance of RestAPI2Domain.GTVAPISuspendBillingAccount class.
   */
  public static RestAPI2Domain.GTVAPISuspendBillingAccount mapSuspendBillingAccount(
    String reasonEid
  ) {
    RestAPI2Domain.GTVAPISuspendBillingAccount suspendBillingAccountObj = new RestAPI2Domain.GTVAPISuspendBillingAccount();
    suspendBillingAccountObj.reason = new RestAPI2Domain.GTVAPIBillingAccountSuspensionReasonRef();
    suspendBillingAccountObj.reason.id = reasonEid;
    suspendBillingAccountObj.reason.reasonType = 'billing-account-suspension';
    return suspendBillingAccountObj;
  }

  /**
   * @description: Map the user input for deactivating billing account to the GTV deactivate billing account object.
   * @param reasonEid, The GTV id for suspension reason.
   * @return RestAPI2Domain.GTVAPIDeactivateBillingAccount, The instance of RestAPI2Domain.GTVAPIDeactivateBillingAccount class.
   */
  public static RestAPI2Domain.GTVAPIDeactivateBillingAccount mapDeactivateBillingAccount(
    String reasonEid
  ) {
    RestAPI2Domain.GTVAPIDeactivateBillingAccount deactivateBillingAccountObj = new RestAPI2Domain.GTVAPIDeactivateBillingAccount();
    deactivateBillingAccountObj.reason = new RestAPI2Domain.GTVAPIBillingAccountDeactivationReasonR();
    deactivateBillingAccountObj.reason.id = reasonEid;
    deactivateBillingAccountObj.reason.reasonType = 'billing-account-deactivation';
    return deactivateBillingAccountObj;
  }

  /**
   * @description: Map the user input for creating billing account custom field to the GTV create billing account custom field object.
   * @param wrap, The list of account custom field wrapper.
   * @return list<RestAPI2Domain.GTVAPICreateBillingAccountCustomFi>, The list of RestAPI2Domain.GTVAPICreateBillingAccountCustomFi class.
   */
  public static list<RestAPI2Domain.GTVAPICreateBillingAccountCustomFi> mapSaveAccountCustomField(
    list<AccountCustomFieldWrapper> wrap
  ) {
    list<RestAPI2Domain.GTVAPICreateBillingAccountCustomFi> requestList = new List<RestAPI2Domain.GTVAPICreateBillingAccountCustomFi>();
    for (AccountCustomFieldWrapper fld : wrap) {
      if (
        (null != fld.value && '' != fld.value) ||
        (null != fld.selectedListTypeValue &&
        'Choose One' != fld.selectedListTypeValue &&
        '' != fld.selectedListTypeValue)
      ) {
        RestAPI2Domain.GTVAPICreateBillingAccountCustomFi customFieldVal = new RestAPI2Domain.GTVAPICreateBillingAccountCustomFi();
        customFieldVal.custom_field_value_type = 'billing-account';
        if (null != fld.selectedListTypeValue) {
          customFieldVal.value = fld.selectedListTypeValue;
        } else {
          customFieldVal.value = fld.value;
        }
        RestAPI2Domain.GTVAPICustomFieldRef ref = new RestAPI2Domain.GTVAPICustomFieldRef();
        ref.name = fld.name;
        ref.id = fld.Eid;
        ref.custom_field_type = 'billing-account';
        customFieldVal.custom_field = ref;
        requestList.add(customFieldVal);
      }
    }
    return requestList;
  }

  /* API not available */
  public static RestAPI2Domain.GTVAPIResumeBillingAccount mapResumeBillingAccount() {
    RestAPI2Domain.GTVAPIResumeBillingAccount resumeBillingAccountObj = new RestAPI2Domain.GTVAPIResumeBillingAccount();
    return resumeBillingAccountObj;
  }

  /**
   * @description: Get request to create billing account in GTV db
   * @param sfdcAccountObj Salesforce Account to be created in GTV(required)
   * @param billCycleObj billcycle choose by user while creating account(required)
   * @param billingAccountCategoryEid The Id of billing account category(required)
   * @param paymentTermEid The Id of payment term(required)
   * @param fieldToMapAccountId The Id of account custom field to be mapped with salesforce account id(required)
   * @return RestAPI2Domain.GTVAPICreateBillingAccount, The instance of RestAPI2Domain.GTVAPICreateBillingAccount class.
   */
  public static RestAPI2Domain.GTVAPICreateBillingAccount getBillingAccountCreationMapping(
    Account sfdcAccountObj,
    TRACT_Bill_Cycle__c billCycleObj,
    string billingAccountCategoryEid,
    string paymentTermEid,
    string fieldToMapAccountId
  ) {
    RestAPI2Domain.GTVAPICreateBillingAccount createBillingAccountObj = new RestAPI2Domain.GTVAPICreateBillingAccount();
    RestAPI2Domain.GTVAPICreateParty responsiblePartyObj = new RestAPI2Domain.GTVAPICreateParty();
    RestAPI2Domain.GTVAPICreateAddress billingPostalAddress;
    RestAPI2Domain.GTVAPICreateAddress shippingPostalAddress;
    RestAPI2Domain.GTVAPICreateAddress emailAddress;
    RestAPI2Domain.GTVAPICreateAddress telecomAddress;
    RestAPI2Domain.GTVAPICreateBillingAccountCustomFi billingAccountCustomFieldObj;
    RestAPI2Domain.GTVAPIBillingAccountCategoryRef billingAccountCategoryObj = new RestAPI2Domain.GTVAPIBillingAccountCategoryRef();
    RestAPI2Domain.GTVAPIPaymentTermRef paymentTermObj = new RestAPI2Domain.GTVAPIPaymentTermRef();
    RestAPI2Domain.GTVAPIBillCycleRef billCycle = new RestAPI2Domain.GTVAPIBillCycleRef();

    AccountMappingWrapper accountMapDetails = AccountMappingController.showAccountMap(
      sfdcAccountObj.id
    );
    billCycle.id = billCycleObj.Eid__c;
    billCycle.bill_cycle_type = billCycleObj.Bill_Cycle_Type__c;
    createBillingAccountObj.bill_cycle = billCycle;
    // set payment term
    paymentTermObj.id = paymentTermEid;
    createBillingAccountObj.payment_term = paymentTermObj;
    //set billing account category
    billingAccountCategoryObj.id = billingAccountCategoryEid;
    createBillingAccountObj.billing_account_category = billingAccountCategoryObj;
    responsiblePartyObj.addresses = new List<RestAPI2Domain.GTVAPICreateAddress>();
    // setting the currency code
    //createBillingAccountObj.currencyCode = billCycleObj.TRACT_Bill_Cycle_Currency_Type__c;
    createBillingAccountObj.currencyCode = sfdcAccountObj.Currency_Type__c;
    // setting the responsible party
    createBillingAccountObj.responsible_party = responsiblePartyObj;
    // set billing address from Salesforce account
    if (
      !TractSFDC_Util.isNull(
        accountMapDetails.mapOfNamesVsVales.get('BillingStreet')
      )
    ) {
      billingPostalAddress = new RestAPI2Domain.GTVAPICreateAddress();
      if (
        !TractSFDC_Util.isNull(
          accountMapDetails.mapOfNamesVsVales.get('BillingCountry')
        )
      ) {
        billingPostalAddress.country = TractSFDC_Util.getCountry(
          accountMapDetails.mapOfNamesVsVales.get('BillingCountry')
        );
      } else {
        //throw error
        throw new MyException('Please enter correct Billing Country.');
      }
      if (
        !TractSFDC_Util.isNull(
          accountMapDetails.mapOfNamesVsVales.get('BillingCity')
        )
      ) {
        billingPostalAddress.city = accountMapDetails.mapOfNamesVsVales.get(
          'BillingCity'
        );
      }
      if (
        !TractSFDC_Util.isNull(
          accountMapDetails.mapOfNamesVsVales.get('BillingState')
        )
      ) {
        billingPostalAddress.region_or_state = TractSFDC_Util.getState(
          accountMapDetails.mapOfNamesVsVales.get('BillingState')
        );
      } else {
        //throw error
        throw new MyException('Please enter correct Billing State.');
      }
      if (
        !TractSFDC_Util.isNull(
          accountMapDetails.mapOfNamesVsVales.get('BillingCode')
        )
      ) {
        billingPostalAddress.postal_code = accountMapDetails.mapOfNamesVsVales.get(
          'BillingCode'
        );
      }
      billingPostalAddress.line1 = accountMapDetails.mapOfNamesVsVales.get(
        'BillingStreet'
      );
      billingPostalAddress.line2 = '';
      billingPostalAddress.purpose = RestAPI2Domain.AddresssPurpose.BILLING;
      billingPostalAddress.address_type = RestAPI2Domain.GTVAPIAddressType.postal;
      responsiblePartyObj.addresses.add(billingPostalAddress);
    }

    if (
      !TractSFDC_Util.isNull(
        accountMapDetails.mapOfNamesVsVales.get('ShippingStreet')
      )
    ) {
      shippingPostalAddress = new RestAPI2Domain.GTVAPICreateAddress();
      if (
        !TractSFDC_Util.isNull(
          accountMapDetails.mapOfNamesVsVales.get('ShippingCountry')
        )
      ) {
        shippingPostalAddress.country = TractSFDC_Util.getCountry(
          accountMapDetails.mapOfNamesVsVales.get('ShippingCountry')
        );
      } else {
        //throw error
        throw new MyException('Please enter correct Shipping Country.');
      }
      if (
        !TractSFDC_Util.isNull(
          accountMapDetails.mapOfNamesVsVales.get('ShippingCity')
        )
      ) {
        shippingPostalAddress.city = accountMapDetails.mapOfNamesVsVales.get(
          'ShippingCity'
        );
      }
      if (
        !TractSFDC_Util.isNull(
          accountMapDetails.mapOfNamesVsVales.get('ShippingState')
        )
      ) {
        shippingPostalAddress.region_or_state = TractSFDC_Util.getState(
          accountMapDetails.mapOfNamesVsVales.get('ShippingState')
        );
      } else {
        //throw error
        throw new MyException('Please enter correct Shipping State.');
      }
      if (
        !TractSFDC_Util.isNull(
          accountMapDetails.mapOfNamesVsVales.get('ShippingCode')
        )
      ) {
        shippingPostalAddress.postal_code = accountMapDetails.mapOfNamesVsVales.get(
          'ShippingCode'
        );
      }
      shippingPostalAddress.line1 = accountMapDetails.mapOfNamesVsVales.get(
        'ShippingStreet'
      );
      shippingPostalAddress.line2 = '';
      shippingPostalAddress.purpose = RestAPI2Domain.AddresssPurpose.SHIPPING;
      shippingPostalAddress.address_type = RestAPI2Domain.GTVAPIAddressType.postal;
      responsiblePartyObj.addresses.add(shippingPostalAddress);
    }
    // set email from Salesforce account
    if (
      string.isNotBlank(
        accountMapDetails.mapOfNamesVsVales.get('GotransverseEmail')
      ) && accountMapDetails.mapOfNamesVsVales.get('GotransverseEmail') != 'NA'
    ) {
      emailAddress = new RestAPI2Domain.GTVAPICreateAddress();
      emailAddress.email = zConvert.ToString(
        accountMapDetails.mapOfNamesVsVales.get('GotransverseEmail')
      );
      emailAddress.purpose = RestAPI2Domain.AddresssPurpose.PRIMARY;
      emailAddress.address_type = RestAPI2Domain.GTVAPIAddressType.email;
      responsiblePartyObj.addresses.add(emailAddress);
    }
    // set phone from Salesforce account
    if (
      string.isNotBlank(accountMapDetails.mapOfNamesVsVales.get('Phone')) &&
      accountMapDetails.mapOfNamesVsVales.get('Phone') != 'NA'
    ) {
      telecomAddress = new RestAPI2Domain.GTVAPICreateAddress();
      string strPhone = zConvert.ToString(
        accountMapDetails.mapOfNamesVsVales.get('Phone')
      );
      if (strPhone != null && strPhone != '' && !strPhone.IsNumeric()) {
        strPhone = strPhone.replaceAll('[^0-9]', '');
      }
      telecomAddress.purpose = RestAPI2Domain.AddresssPurpose.OFFICE;
      telecomAddress.r_number = strphone;
      telecomAddress.address_type = RestAPI2Domain.GTVAPIAddressType.telecom;
      responsiblePartyObj.addresses.add(telecomAddress);
    }
    //set the account Name
    responsiblePartyObj.party_type = RestAPI2Domain.GTVAPIPartyType.organization;
    responsiblePartyObj.organization_name = zConvert.ToString(
      accountMapDetails.mapOfNamesVsVales.get('AccountName')
    );
    // set bill type
    /*if(accountMapDetails.mapOfNamesVsVales.get('GotransverseEmail') != null){
            createBillingAccountObj.bill_type = 'EMAIL';
        }
        else{
            createBillingAccountObj.bill_type = 'NONE';
        }*/
    createBillingAccountObj.bill_type = sfdcAccountObj.Gotransverse_Bill_Type__c;
    //set tax exempt
    createBillingAccountObj.tax_exempt = sfdcAccountObj.Tax_Exempt__c;
    //set account start date
    if (null != sfdcAccountObj.Account_Create_Date__c) {
      createBillingAccountObj.start_date = ZConvert.getFormattedDateTimeString(
        sfdcAccountObj.Account_Create_Date__c,
        'yyyy-MM-dd\'T\'HH:mm:ss.SSSXXX'
      );
    }
    if (fieldToMapAccountId == 'External Account Number') {
      createBillingAccountObj.external_account_num = zConvert.ToString(
        sfdcAccountObj.Id
      );
    } else {
      createBillingAccountObj.external_account_num = TractSFDC_Util.getRandomNumberString();
      billingAccountCustomFieldObj = new RestAPI2Domain.GTVAPICreateBillingAccountCustomFi();
      billingAccountCustomFieldObj.custom_field_value_type = 'billing-account';
      billingAccountCustomFieldObj.value = zConvert.ToString(sfdcAccountObj.Id);
      RestAPI2Domain.GTVAPICustomFieldRef customFieldObj = new RestAPI2Domain.GTVAPICustomFieldRef();
      customFieldObj.id = fieldToMapAccountId;
      customFieldObj.custom_field_type = 'billing-account';
      billingAccountCustomFieldObj.custom_field = customFieldObj;
      createBillingAccountObj.custom_field_values = new List<RestAPI2Domain.GTVAPICreateBillingAccountCustomFi>();
      createBillingAccountObj.custom_field_values.add(
        billingAccountCustomFieldObj
      );
    }
    return createBillingAccountObj;
  }

  /**
   * @description: Get request to create draft order in GTV db
   * @param information, Map containing required information for creating salesorder request
   * @return RestAPI2Domain.GTVAPICreateSalesOrder, The instance of RestAPI2Domain.GTVAPICreateSalesOrder class.
   */
  public static RestAPI2Domain.GTVAPICreateSalesOrder getDraftOrderRequest(
    Map<String, String> information
  ) {
    RestAPI2Domain.GTVAPICreateSalesOrder createDraftOrderRequest = new RestAPI2Domain.GTVAPICreateSalesOrder();
    createDraftOrderRequest = getSalesOrderRequest(information);
    createDraftOrderRequest.initialStatus = RestAPI2Domain.GTVAPICreateSalesOrderStatus.DRAFT;
    return createDraftOrderRequest;
  }

  /**
   * @description: Get request to create order in GTV db
   * @param information, Map containing required information for creating salesorder request
   * @return RestAPI2Domain.GTVAPICreateSalesOrder, The instance of RestAPI2Domain.GTVAPICreateSalesOrder class.
   */
  public static RestAPI2Domain.GTVAPICreateSalesOrder getSalesOrderRequest(
    Map<String, String> information
  ) {
    RestAPI2Domain.GTVAPICreateSalesOrder createSalesOrderRequest = new RestAPI2Domain.GTVAPICreateSalesOrder();
    List<RestAPI2Domain.GTVAPICreateProductOrderItem> orderItemList = new List<RestAPI2Domain.GTVAPICreateProductOrderItem>();
    // Mapping the order date
    if (
      String.isNotBlank(information.get('OrderDate')) &&
      information.get('OrderDate') != 'NA'
    ) {
      createSalesOrderRequest.orderDate = getDate(information);
    }
    // Mapping the order custom fields
    if (String.isNotBlank(information.get('OpportunityId'))) {
      String opportunityId = information.get('OpportunityId');
      list<Order_Custom_Field__c> listOfOrderCustomFields = [
        SELECT eid__c, name, OpportunityIdCheck__c, Value__c
        FROM Order_Custom_Field__c
        WHERE OpportunityIdCheck__c = :opportunityId AND Value__c != NULL
        LIMIT 50000
      ];
      if (null != listOfOrderCustomFields) {
        createSalesOrderRequest.customFieldValues = new List<RestAPI2Domain.GTVAPICreateOrderCustomFieldValue>();
        RestAPI2Domain.GTVAPICreateOrderCustomFieldValue customFieldValueObj;
        for (Order_Custom_Field__c orderField : listOfOrderCustomFields) {
          customFieldValueObj = new RestAPI2Domain.GTVAPICreateOrderCustomFieldValue();
          customFieldValueObj.custom_field = new RestAPI2Domain.GTVAPIOrderCustomFieldRef();
          customFieldValueObj.custom_field.id = orderField.eid__c;
          customFieldValueObj.custom_field.custom_field_type = 'order';
          customFieldValueObj.custom_field_value_type = 'order';
          customFieldValueObj.value = orderField.value__c;
          createSalesOrderRequest.customFieldValues.add(customFieldValueObj);
        }
      }
    }
    /* Bring all the Opportunity line items details in a wrapper variable*/
    TractProduct[] productList = TractSFDC_Util.getProductFromOpportunity(
      information
    );
    orderItemList = getOrderItemList(productList, information);
    createSalesOrderRequest.orderItems = orderItemList;
    return createSalesOrderRequest;
  }

  private static String getDate(Map<String, String> information) {
    return ZConvert.getFormattedDateTimeString(
      Date.parse(information.get('OrderDate')),
      'yyyy-MM-dd\'T\'HH:mm:ss.SSSXXX'
    );
  }

  /**
   * @description: Map order item for a GTV order
   * @param productList, List of tract product to be included as order item.
   * @param information, Map containing required information for creating salesorder request
   * @return List< RestAPI2Domain.GTVAPICreateProductOrderItem>, The list of RestAPI2Domain.GTVAPICreateProductOrderItem class.
   */
  public static List<RestAPI2Domain.GTVAPICreateProductOrderItem> getOrderItemList(
    TractProduct[] productList,
    Map<String, String> information
  ) {
    List<RestAPI2Domain.GTVAPICreateProductOrderItem> orderItemList = new List<RestAPI2Domain.GTVAPICreateProductOrderItem>();
    RestAPI2Domain.GTVAPICreateProductOrderItem orderItem = new RestAPI2Domain.GTVAPICreateProductOrderItem();
    Set<String> opportunityLineItemIdSet = new Set<String>();
    Map<String, list<Schdeule_Charge__c>> opportunityProductIdVsScheduleChargesMap = new Map<String, list<Schdeule_Charge__c>>();
    Map<String, list<Service_Custom_Field__c>> productIdVsServiceCustomFieldMap = new Map<String, list<Service_Custom_Field__c>>();
    map<String, String> serviceIdVsProductIdMap = new Map<String, String>();
    for (TractProduct tractProduct : productList) {
      opportunityLineItemIdSet.add(tractProduct.opportunityProductId);
      if (tractProduct.ServiceId != null) {
        serviceIdVsProductIdMap.put(
          tractProduct.ServiceId,
          tractProduct.ProductId
        );
      }
    }

    // getting the service custom field stored in salesforce db by SOQL query
    if (opportunityLineItemIdSet.size() > 0) {
      for (Service_Custom_Field__c scfInstance : [
        SELECT name, parentId__c, ProductId__c, value__c, eid__c
        FROM Service_Custom_Field__c
        WHERE ProductId__c = :opportunityLineItemIdSet
        LIMIT 50000
      ]) {
        if (
          productIdVsServiceCustomFieldMap.containskey(scfInstance.ProductId__c)
        ) {
          productIdVsServiceCustomFieldMap.get(scfInstance.ProductId__c)
            .add(scfInstance);
        } else {
          productIdVsServiceCustomFieldMap.put(
            scfInstance.ProductId__c,
            new List<Service_Custom_Field__c>()
          );
          productIdVsServiceCustomFieldMap.get(scfInstance.ProductId__c)
            .add(scfInstance);
        }
      }
    }

    // getting the schedule charges stored in salesforce db by SOQL query
    if (opportunityLineItemIdSet.size() > 0) {
      for (Schdeule_Charge__c scheduleInstance : [
        SELECT
          Name,
          Schdeule_Amount__c,
          Charge_Type__c,
          Schdeule_Date__c,
          Schdeule_Description__c,
          ProductId__c
        FROM Schdeule_Charge__c
        WHERE ProductId__c = :opportunityLineItemIdSet
        ORDER BY Schdeule_Date__c ASC
        LIMIT 50000
      ]) {
        if (
          opportunityProductIdVsScheduleChargesMap.containskey(
            scheduleInstance.ProductId__c
          )
        ) {
          opportunityProductIdVsScheduleChargesMap.get(
              scheduleInstance.ProductId__c
            )
            .add(scheduleInstance);
        } else {
          opportunityProductIdVsScheduleChargesMap.put(
            scheduleInstance.ProductId__c,
            new List<Schdeule_Charge__c>()
          );
          opportunityProductIdVsScheduleChargesMap.get(
              scheduleInstance.ProductId__c
            )
            .add(scheduleInstance);
        }
      }
    }
    for (TractProduct tractProduct : productList) {
      if (tractProduct.ProductCode == 'SUBSCRIPTION') {
        orderItem = getOrderItemSubscrption(
          tractProduct,
          information,
          opportunityProductIdVsScheduleChargesMap,
          productIdVsServiceCustomFieldMap
        );
        if (serviceIdVsProductIdMap.containsKey(tractProduct.ProductId)) {
          orderitem.orderItems = new List<RestAPI2Domain.GTVAPICreateAddOnProductOrderItem>();
          orderitem.orderItems = getOrderItemsAddON(
            tractProduct,
            productList,
            opportunityProductIdVsScheduleChargesMap,
            information,
            serviceIdVsProductIdMap
          );
        }
        orderItemList.add(orderItem);
      } else if (tractProduct.addToExistingService == true) {
        orderitem = getAddonWithExistingService(
          tractProduct,
          opportunityProductIdVsScheduleChargesMap,
          information
        );
        if (serviceIdVsProductIdMap.containsKey(tractProduct.ProductId)) {
          orderitem.orderItems = new List<RestAPI2Domain.GTVAPICreateAddOnProductOrderItem>();
          orderitem.orderItems = getOrderItemsAddON(
            tractProduct,
            productList,
            opportunityProductIdVsScheduleChargesMap,
            information,
            serviceIdVsProductIdMap
          );
        }
        orderItemList.add(orderItem);
      } else if (tractProduct.ProductCode == 'One-Time') {
        orderItem = getOrderItemOneTime(
          tractProduct,
          information,
          opportunityProductIdVsScheduleChargesMap
        );
        orderItemList.add(orderItem);
      }
    }
    return orderItemList;
  }

  /**
   * @description: Map subscription order item for a GTV order
   * @param productList, List of tract product to be included as order item.
   * @param information, Map containing required information for creating salesorder request
   * @return RestAPI2Domain.GTVAPICreateProductOrderItem, The instance of RestAPI2Domain.GTVAPICreateProductOrderItem class.
   */
  public static RestAPI2Domain.GTVAPICreateProductOrderItem getOrderItemSubscrption(
    TractProduct tractProduct,
    Map<String, String> information,
    Map<String, list<Schdeule_Charge__c>> opportunityProductIdVsScheduleChargesMap,
    Map<String, list<Service_Custom_Field__c>> productIdVsServiceCustomFieldMap
  ) {
    list<RestAPI2Domain.GTVAPICreateOneTimePriceCharge> orderItemScheduleCharge = new List<RestAPI2Domain.GTVAPICreateOneTimePriceCharge>();
    RestAPI2Domain.GTVAPICreateProductOrderItem orderItem = new RestAPI2Domain.GTVAPICreateProductOrderItem();
    List<RestAPI2Domain.GTVAPICreateUsageRuleTemplate> productUsageRulesList = new List<RestAPI2Domain.GTVAPICreateUsageRuleTemplate>();
    RestAPI2Domain.GTVAPICreateOrderItemPrice itemPrice;
    RestAPI2Domain.GTVAPIProductPriceRef productPrice;
    RestAPI2Domain.GTVAPICreateOrderItemPriceRange itemPriceRange;
    List<RestAPI2Domain.GTVAPICreateAddOnProductOrderItem> addOnOrderItemsList = new List<RestAPI2Domain.GTVAPICreateAddOnProductOrderItem>();
    list<RestAPI2Domain.GTVAPICreateOrderItemPriceRange> orderItemListOfPriceRange;
    list<RestAPI2Domain.GTVAPICreateOrderItemPrice> orderItemListOfPrice = new List<RestAPI2Domain.GTVAPICreateOrderItemPrice>();
    orderItem.quantity = Double.valueof(tractProduct.quantity);
    orderItem.sequence = 1;
    orderItem.overrideTrialDays = Integer.valueOf(
      tractProduct.overridedTrialLength
    );
    if (
      !(null == tractProduct.description || tractProduct.description.equals(''))
    ) {
      orderItem.description = tractProduct.description;
    }
    // mapping the product data
    orderItem.product = new RestAPI2Domain.GTVAPIProductRef();
    orderItem.product.id = tractProduct.eid;
    orderItem.product.name = tractProduct.name;
    orderItem.product.productType = 'customer-subscription';
    // mapping the pricelist data
    orderItem.priceList = new RestAPI2Domain.GTVAPIPriceListRef();
    orderItem.priceList.id = tractProduct.priceListEid;
    orderItem.order_item_type = 'product';

    // mapping the discount code
    if (
      null != tractProduct.discountCodeName &&
      null != tractProduct.discountCodeEid
    ) {
      orderItem.orderItemDiscount = new RestAPI2Domain.GTVAPICreateOrderItemDiscount();
      orderItem.orderItemDiscount.discountResource = new RestAPI2Domain.GTVAPIDiscountResourceRef();
      orderItem.orderItemDiscount.discountResource.id = tractProduct.discountCodeEid;
      orderItem.orderItemDiscount.discountResource.identifier = tractProduct.discountCodeName;
      orderItem.orderItemDiscount.discountResource.resource_type = 'discount';
    }

    // mapping the agreement
    if (
      !String.isBlank(tractProduct.agreementEndAction) ||
      tractProduct.overrideAgreementEndDate != null
    ) {
      orderItem.order_item_agreement = new RestAPI2Domain.GTVAPICreateOrderItemAgreement();
      orderItem.order_item_agreement.agreement = new RestAPI2Domain.GTVAPIAgreementRef();
      orderItem.order_item_agreement.agreement.id = tractProduct.Agreement_eid;
      if (null != tractProduct.overrideAgreementEndDate) {
        orderItem.order_item_agreement.endDate = ZConvert.getFormattedDateTimeString(
          Date.valueOf(tractProduct.overrideAgreementEndDate),
          'yyyy-MM-dd\'T\'HH:mm:ss.SSSXXX'
        );
      }
      if (!String.isBlank(tractProduct.agreementEndAction)) {
        orderItem.order_item_agreement.endAction = tractProduct.agreementEndAction;
      }
      if (tractProduct.Agreement_Period != null) {
        orderItem.order_item_agreement.agreement_period = integer.valueof(
          tractProduct.Agreement_Period
        );
      }
      if (tractProduct.renewalPricing == 'Service Price') {
        orderItem.order_item_agreement.preserveServicePrice = true;
      } else if (tractProduct.renewalPricing == 'Product Price') {
        orderItem.order_item_agreement.preserveServicePrice = false;
      }
      if (
        tractProduct.nextAgreementEid != null &&
        tractProduct.nextAgreementEndAction != null
      ) {
        orderItem.order_item_agreement.nextAgreement = new RestAPI2Domain.GTVAPIAgreementRef();
        orderItem.order_item_agreement.nextAgreement.id = tractProduct.nextAgreementEid;
        orderItem.order_item_agreement.nextEndAction = tractProduct.nextAgreementEndAction;
        if (tractProduct.nextRenewalPricing == 'Service Price') {
          orderItem.order_item_agreement.nextPreserveServicePrice = true;
        } else if (tractProduct.nextRenewalPricing == 'Product Price') {
          orderItem.order_item_agreement.nextPreserveServicePrice = false;
        }
      }
    }
    //mapping the Product Prices
    Product2 pro = [
      SELECT Id, Name, Price_Information__c
      FROM Product2
      WHERE Id = :tractProduct.ProductId
    ];
    List<ProductPriceWrapper> productPriceWrapList = (list<ProductPriceWrapper>) JSON.deserialize(
      pro.Price_Information__c,
      list<ProductPriceWrapper>.class
    );
    for (ProductPriceWrapper ppw : productPriceWrapList) {
      if (
        ppw.priceType == 'recurring' &&
        ppw.eid == tractProduct.recurringProductPriceEid
      ) {
        itemPrice = new RestAPI2Domain.GTVAPICreateOrderItemPrice();
        itemPrice.order_item_price_type = 'recurring';
        productPrice = new RestAPI2Domain.GTVAPIProductPriceRef();
        productPrice.product_price_type = ppw.priceType;
        productPrice.id = ppw.eid;
        itemPrice.product_price = productPrice;
        if (tractProduct.recurringPrice != null) {
          orderItemListOfPriceRange = new List<RestAPI2Domain.GTVAPICreateOrderItemPriceRange>();
          for (
            ProductPriceRangeWrapper priceRange : tractProduct.overridedRecurringPriceRangesList
          ) {
            itemPriceRange = new RestAPI2Domain.GTVAPICreateOrderItemPriceRange();
            itemPriceRange.price = priceRange.price;
            itemPriceRange.currency_code = ppw.currencyType;
            itemPriceRange.quantity_begin_range = priceRange.quantityBeginRange;
            if (priceRange.quantityEndRange != null) {
              itemPriceRange.quantity_end_range = priceRange.quantityEndRange;
            }
            itemPriceRange.level = priceRange.level;
            orderItemListOfPriceRange.add(itemPriceRange);
          }
          itemPrice.price_ranges = orderItemListOfPriceRange;
        }
        itemPrice.usage_rules = getOrderItemProductUsageList(
          tractProduct.eid,
          information.get('OpportunityId')
        );
        orderItemListOfPrice.add(itemPrice);
      }
      if (
        ppw.priceType == 'one-time' &&
        ppw.eid == tractProduct.OneTimeProductPriceEid
      ) {
        itemPrice = new RestAPI2Domain.GTVAPICreateOrderItemPrice();
        itemPrice.order_item_price_type = 'one-time';
        productPrice = new RestAPI2Domain.GTVAPIProductPriceRef();
        productPrice.product_price_type = ppw.priceType;
        productPrice.id = ppw.eid;
        itemPrice.product_price = productPrice;
        if (tractProduct.oneTimePrice != null) {
          orderItemListOfPriceRange = new List<RestAPI2Domain.GTVAPICreateOrderItemPriceRange>();
          for (
            ProductPriceRangeWrapper priceRange : tractProduct.overridedOneTimePriceRangesList
          ) {
            itemPriceRange = new RestAPI2Domain.GTVAPICreateOrderItemPriceRange();
            itemPriceRange.price = priceRange.price;
            itemPriceRange.currency_code = ppw.currencyType;
            itemPriceRange.quantity_begin_range = priceRange.quantityBeginRange;
            if (priceRange.quantityEndRange != null) {
              itemPriceRange.quantity_end_range = priceRange.quantityEndRange;
            }
            itemPriceRange.level = priceRange.level;
            orderItemListOfPriceRange.add(itemPriceRange);
          }
          itemPrice.price_ranges = orderItemListOfPriceRange;
        }
        if (
          opportunityProductIdVsScheduleChargesMap.containsKey(
            tractProduct.opportunityProductId
          )
        ) {
          for (
            Schdeule_Charge__c charge : opportunityProductIdVsScheduleChargesMap.get(
              tractProduct.opportunityProductId
            )
          ) {
            RestAPI2Domain.GTVAPICreateOneTimePriceCharge priceCharge = new RestAPI2Domain.GTVAPICreateOneTimePriceCharge();
            priceCharge.priceChargeType = charge.Charge_Type__c;
            priceCharge.description = charge.Schdeule_Description__c;
            priceCharge.amount = Double.valueOf(charge.Schdeule_Amount__c);
            priceCharge.chargeDate = charge.Schdeule_Date__c;
            orderItemScheduleCharge.add(priceCharge);
          }
          itemPrice.scheduled_charges = orderItemScheduleCharge;
        }
        orderItemListOfPrice.add(itemPrice);
      }
    }
    orderItem.order_item_prices = orderItemListOfPrice;

    // mapping the service resources
    if (
      tractProduct.minServiceResources > 0 ||
      tractProduct.maxServiceResources > 0
    ) {
      orderItem.service_resources = new List<RestAPI2Domain.GTVAPICreateOrAddServiceResource>();
      RestAPI2Domain.GTVAPICreateOrAddServiceResource serviceResourceObj;
      if (
        null != tractProduct.TractServiceResourceEid &&
        null != tractProduct.TractServiceResourceName
      ) {
        list<String> srIdentifier = new List<String>();
        list<String> srEid = new List<String>();
        for (String str : tractProduct.TractServiceResourceName.split('\\|')) {
          if (null != str && str.trim() != '') {
            srIdentifier.add(str);
          }
        }
        for (String str : tractProduct.TractServiceResourceEid.split('\\|')) {
          if (null != str && str.trim() != '') {
            srEid.add(str);
          }
        }
        for (Integer i = 0; i < srIdentifier.size(); i++) {
          serviceResourceObj = new RestAPI2Domain.GTVAPICreateOrAddServiceResource();
          serviceResourceObj.id = srEid[i];
          serviceResourceObj.identifier = srIdentifier[i];
          serviceResourceObj.resourceType = RestAPI2Domain.GTVAPIResourceType.SERVICE;
          orderItem.service_resources.add(serviceResourceObj);
        }
      }
      if (
        null != tractProduct.NewServiceResource &&
        '' != tractProduct.NewServiceResource
      ) {
        for (
          String newSrIdenfier : tractProduct.NewServiceResource.split('\\|')
        ) {
          if (!String.isBlank(newSrIdenfier) && newSrIdenfier != null) {
            serviceResourceObj = new RestAPI2Domain.GTVAPICreateOrAddServiceResource();
            serviceResourceObj.identifier = newSrIdenfier;
            serviceResourceObj.resourceType = RestAPI2Domain.GTVAPIResourceType.SERVICE;
            serviceResourceObj.category = new RestAPI2Domain.GTVAPIResourceCategoryRef();
            serviceResourceObj.category.id = tractProduct.Service_Resource_Category;
            orderItem.service_resources.add(serviceResourceObj);
          }
        }
      }
    }

    // mapping service custom fields
    if (productIdVsServiceCustomFieldMap.containskey(tractProduct.ProductId)) {
      orderItem.customFieldValues = new List<RestAPI2Domain.GTVAPICreateOrderItemCustomFieldValue>();
      RestAPI2Domain.GTVAPICreateOrderItemCustomFieldValue customFieldValueObj;
      for (
        Service_Custom_Field__c serviceField : productIdVsServiceCustomFieldMap.get(
          tractProduct.ProductId
        )
      ) {
        customFieldValueObj = new RestAPI2Domain.GTVAPICreateOrderItemCustomFieldValue();
        customFieldValueObj.customField = new RestAPI2Domain.GTVAPIServiceCustomFieldRef();
        customFieldValueObj.customField.id = serviceField.eid__c;
        customFieldValueObj.customField.custom_field_type = 'service';
        customFieldValueObj.custom_field_value_type = 'service';
        customFieldValueObj.value = serviceField.value__c;
        orderItem.customFieldValues.add(customFieldValueObj);
      }
    }
    return orderItem;
  }

  /**
   * @description: Map addon's order item on a subscription order item for a GTV order
   * @param tractProduct, subscription order item.
   * @param productList, List of tract product to be included as order item.
   * @param opportunityProductIdVsScheduleChargesMap, Map of OLIId and Schedulecharge.
   * @param information, Map containing required information for creating salesorder request
   * @return List<RestAPI2Domain.GTVAPICreateAddOnProductOrderItem>, The List of RestAPI2Domain.GTVAPICreateAddOnProductOrderItem class.
   */
  public static List<RestAPI2Domain.GTVAPICreateAddOnProductOrderItem> getOrderItemsAddON(
    TractProduct tractProduct,
    TractProduct[] productList,
    Map<String, list<Schdeule_Charge__c>> opportunityProductIdVsScheduleChargesMap,
    Map<String, String> information,
    map<String, String> serviceIdVsProductIdMap
  ) {
    List<RestAPI2Domain.GTVAPICreateAddOnProductOrderItem> addOnOrderItemsList = new List<RestAPI2Domain.GTVAPICreateAddOnProductOrderItem>();
    RestAPI2Domain.GTVAPICreateProductOrderItem orderItem = new RestAPI2Domain.GTVAPICreateProductOrderItem();
    list<RestAPI2Domain.GTVAPICreateOneTimePriceCharge> orderItemScheduleCharge;
    RestAPI2Domain.GTVAPICreateOrderItemPrice itemPrice;
    RestAPI2Domain.GTVAPIProductPriceRef productPrice;
    RestAPI2Domain.GTVAPICreateOrderItemPriceRange itemPriceRange;
    list<RestAPI2Domain.GTVAPICreateOrderItemPriceRange> orderItemListOfPriceRange;
    list<RestAPI2Domain.GTVAPICreateOrderItemPrice> orderItemListOfPrice;
    String subscriptionId = tractProduct.ProductId;
    for (TractProduct totalProducts : productList) {
      if (totalProducts.ServiceId == subscriptionId) {
        orderItemListOfPrice = new List<RestAPI2Domain.GTVAPICreateOrderItemPrice>();
        orderItemScheduleCharge = new List<RestAPI2Domain.GTVAPICreateOneTimePriceCharge>();
        RestAPI2Domain.GTVAPICreateAddOnProductOrderItem addOnOrderItem = new RestAPI2Domain.GTVAPICreateAddOnProductOrderItem();
        addOnOrderItem.quantity = Double.valueof(totalProducts.quantity);
        addOnOrderItem.sequence = 1;

        if (
          !(null == totalProducts.description ||
          totalProducts.description.equals(''))
        ) {
          addOnOrderItem.description = totalProducts.description;
        }
        addOnOrderItem.overrideTrialDays = Integer.valueof(
          totalProducts.overridedTrialLength
        );
        // mapping the product data
        addOnOrderItem.product = new RestAPI2Domain.GTVAPIProductRef();
        addOnOrderItem.product.id = totalProducts.eid;
        addOnOrderItem.product.name = totalProducts.name;
        addOnOrderItem.product.productType = 'add-on';

        // mapping the pricelist data
        addOnOrderItem.priceList = new RestAPI2Domain.GTVAPIPriceListRef();
        addOnOrderItem.priceList.id = totalProducts.priceListEid;

        addOnOrderItem.order_item_type = 'add-on';

        // mapping the discount code
        if (
          null != totalProducts.discountCodeName &&
          null != totalProducts.discountCodeEid
        ) {
          addOnOrderItem.orderItemDiscount = new RestAPI2Domain.GTVAPICreateOrderItemDiscount();
          addOnOrderItem.orderItemDiscount.discountResource = new RestAPI2Domain.GTVAPIDiscountResourceRef();
          addOnOrderItem.orderItemDiscount.discountResource.id = totalProducts.discountCodeEid;
          addOnOrderItem.orderItemDiscount.discountResource.identifier = totalProducts.discountCodeName;
        }

        // mapping the agreement
        if (
          !String.isBlank(totalProducts.agreementEndAction) ||
          totalProducts.overrideAgreementEndDate != null
        ) {
          addOnOrderItem.order_item_agreement = new RestAPI2Domain.GTVAPICreateOrderItemAgreement();
          addOnOrderItem.order_item_agreement.agreement = new RestAPI2Domain.GTVAPIAgreementRef();
          addOnOrderItem.order_item_agreement.agreement.id = totalProducts.Agreement_eid;
          if (null != totalProducts.overrideAgreementEndDate) {
            addOnOrderItem.order_item_agreement.endDate = ZConvert.getFormattedDateTimeString(
              Date.valueOf(totalProducts.overrideAgreementEndDate),
              'yyyy-MM-dd\'T\'HH:mm:ss.SSSXXX'
            );
          }
          if (!String.isBlank(totalProducts.agreementEndAction)) {
            addOnOrderItem.order_item_agreement.endAction = totalProducts.agreementEndAction;
          }
          if (totalProducts.Agreement_Period != null) {
            addOnOrderItem.order_item_agreement.agreement_period = integer.valueof(
              totalProducts.Agreement_Period
            );
          }
          if (totalProducts.renewalPricing == 'Service Price') {
            addOnOrderItem.order_item_agreement.preserveServicePrice = true;
          } else if (totalProducts.renewalPricing == 'Product Price') {
            addOnOrderItem.order_item_agreement.preserveServicePrice = false;
          }
          if (
            totalProducts.nextAgreementEid != null &&
            totalProducts.nextAgreementEndAction != null
          ) {
            addOnOrderItem.order_item_agreement.nextAgreement = new RestAPI2Domain.GTVAPIAgreementRef();
            addOnOrderItem.order_item_agreement.nextAgreement.id = totalProducts.nextAgreementEid;
            addOnOrderItem.order_item_agreement.nextEndAction = totalProducts.nextAgreementEndAction;
            if (totalProducts.nextRenewalPricing == 'Service Price') {
              addOnOrderItem.order_item_agreement.nextPreserveServicePrice = true;
            } else if (totalProducts.nextRenewalPricing == 'Product Price') {
              addOnOrderItem.order_item_agreement.nextPreserveServicePrice = false;
            }
          }
        }

        //mapping the Product Prices
        Product2 pro = [
          SELECT Id, Name, Price_Information__c
          FROM Product2
          WHERE Id = :totalProducts.ProductId
        ];
        List<ProductPriceWrapper> productPriceWrapList = (list<ProductPriceWrapper>) JSON.deserialize(
          pro.Price_Information__c,
          list<ProductPriceWrapper>.class
        );
        for (ProductPriceWrapper ppw : productPriceWrapList) {
          if (
            ppw.priceType == 'recurring' &&
            ppw.eid == totalProducts.recurringProductPriceEid
          ) {
            itemPrice = new RestAPI2Domain.GTVAPICreateOrderItemPrice();
            itemPrice.order_item_price_type = 'recurring';
            productPrice = new RestAPI2Domain.GTVAPIProductPriceRef();
            productPrice.product_price_type = ppw.priceType;
            productPrice.id = ppw.eid;
            itemPrice.product_price = productPrice;
            if (totalProducts.recurringPrice != null) {
              orderItemListOfPriceRange = new List<RestAPI2Domain.GTVAPICreateOrderItemPriceRange>();
              for (
                ProductPriceRangeWrapper priceRange : totalProducts.overridedRecurringPriceRangesList
              ) {
                itemPriceRange = new RestAPI2Domain.GTVAPICreateOrderItemPriceRange();
                itemPriceRange.price = priceRange.price;
                itemPriceRange.currency_code = ppw.currencyType;
                itemPriceRange.quantity_begin_range = priceRange.quantityBeginRange;
                if (priceRange.quantityEndRange != null) {
                  itemPriceRange.quantity_end_range = priceRange.quantityEndRange;
                }
                itemPriceRange.level = priceRange.level;
                orderItemListOfPriceRange.add(itemPriceRange);
              }
              itemPrice.price_ranges = orderItemListOfPriceRange;
            }
            itemPrice.usage_rules = getOrderItemProductUsageList(
              totalProducts.eid,
              information.get('OpportunityId')
            );
            orderItemListOfPrice.add(itemPrice);
          }

          if (
            ppw.priceType == 'one-time' &&
            ppw.eid == totalProducts.OneTimeProductPriceEid
          ) {
            itemPrice = new RestAPI2Domain.GTVAPICreateOrderItemPrice();
            itemPrice.order_item_price_type = 'one-time';
            productPrice = new RestAPI2Domain.GTVAPIProductPriceRef();
            productPrice.product_price_type = ppw.priceType;
            productPrice.id = ppw.eid;
            itemPrice.product_price = productPrice;
            if (totalProducts.oneTimePrice != null) {
              orderItemListOfPriceRange = new List<RestAPI2Domain.GTVAPICreateOrderItemPriceRange>();
              for (
                ProductPriceRangeWrapper priceRange : totalProducts.overridedOneTimePriceRangesList
              ) {
                itemPriceRange = new RestAPI2Domain.GTVAPICreateOrderItemPriceRange();
                itemPriceRange.price = priceRange.price;
                itemPriceRange.currency_code = ppw.currencyType;
                itemPriceRange.quantity_begin_range = priceRange.quantityBeginRange;
                if (priceRange.quantityEndRange != null) {
                  itemPriceRange.quantity_end_range = priceRange.quantityEndRange;
                }
                itemPriceRange.level = priceRange.level;
                orderItemListOfPriceRange.add(itemPriceRange);
              }
              itemPrice.price_ranges = orderItemListOfPriceRange;
            }
            if (
              opportunityProductIdVsScheduleChargesMap.containsKey(
                totalProducts.opportunityProductId
              )
            ) {
              for (
                Schdeule_Charge__c charge : opportunityProductIdVsScheduleChargesMap.get(
                  totalProducts.opportunityProductId
                )
              ) {
                RestAPI2Domain.GTVAPICreateOneTimePriceCharge priceCharge = new RestAPI2Domain.GTVAPICreateOneTimePriceCharge();
                priceCharge.priceChargeType = charge.Charge_Type__c;
                priceCharge.description = charge.Schdeule_Description__c;
                priceCharge.amount = Double.valueOf(charge.Schdeule_Amount__c);
                priceCharge.chargeDate = charge.Schdeule_Date__c;
                orderItemScheduleCharge.add(priceCharge);
              }
              itemPrice.scheduled_charges = orderItemScheduleCharge;
            }
            orderItemListOfPrice.add(itemPrice);
          }
        }
        addOnOrderItem.order_item_prices = orderItemListOfPrice;

        // mapping the service resources
        if (
          totalProducts.minServiceResources > 0 ||
          totalProducts.maxServiceResources > 0
        ) {
          addOnOrderItem.service_resources = new List<RestAPI2Domain.GTVAPICreateOrAddServiceResource>();
          RestAPI2Domain.GTVAPICreateOrAddServiceResource serviceResourceObj;
          if (
            null != totalProducts.TractServiceResourceEid &&
            null != totalProducts.TractServiceResourceName
          ) {
            list<String> srIdentifier = new List<String>();
            list<String> srEid = new List<String>();
            for (
              String str : totalProducts.TractServiceResourceName.split('\\|')
            ) {
              if (null != str && str.trim() != '') {
                srIdentifier.add(str);
              }
            }
            for (
              String str : totalProducts.TractServiceResourceEid.split('\\|')
            ) {
              if (null != str && str.trim() != '') {
                srEid.add(str);
              }
            }
            for (Integer i = 0; i < srIdentifier.size(); i++) {
              serviceResourceObj = new RestAPI2Domain.GTVAPICreateOrAddServiceResource();
              serviceResourceObj.id = srEid[i];
              serviceResourceObj.identifier = srIdentifier[i];
              serviceResourceObj.resourceType = RestAPI2Domain.GTVAPIResourceType.SERVICE;
              addOnOrderItem.service_resources.add(serviceResourceObj);
            }
          }
          if (
            null != totalProducts.NewServiceResource &&
            '' != totalProducts.NewServiceResource
          ) {
            for (
              String newSrIdenfier : totalProducts.NewServiceResource.split(
                '\\|'
              )
            ) {
              if (!String.isBlank(newSrIdenfier) && newSrIdenfier != null) {
                serviceResourceObj = new RestAPI2Domain.GTVAPICreateOrAddServiceResource();
                serviceResourceObj.identifier = newSrIdenfier;
                serviceResourceObj.resourceType = RestAPI2Domain.GTVAPIResourceType.SERVICE;
                serviceResourceObj.category = new RestAPI2Domain.GTVAPIResourceCategoryRef();
                serviceResourceObj.category.id = totalProducts.Service_Resource_Category;
                addOnOrderItem.service_resources.add(serviceResourceObj);
              }
            }
          }
        }
        // Configure addon to a addon
        if (serviceIdVsProductIdMap.containsKey(totalProducts.ProductId)) {
          addOnOrderItem.orderItems = new List<RestAPI2Domain.GTVAPICreateAddOnProductOrderItem>();
          addOnOrderItem.orderItems = getAddOnOrderItemsOnAddON(
            totalProducts,
            productList,
            opportunityProductIdVsScheduleChargesMap,
            information
          );
        }
        addOnOrderItemsList.add(addOnOrderItem);
      }
    }
    return addOnOrderItemsList;
  }

  /**
   * @description: Map addon's order item on a addon product for a GTV order
   * @param tractProduct, parent addon order item.
   * @param productList, List of tract product to be included as order item.
   * @param opportunityProductIdVsScheduleChargesMap, Map of OLIId and Schedulecharge.
   * @param information, Map containing required information for creating salesorder request
   * @return List<RestAPI2Domain.GTVAPICreateAddOnProductOrderItem>, The List of RestAPI2Domain.GTVAPICreateAddOnProductOrderItem class.
   */
  public static List<RestAPI2Domain.GTVAPICreateAddOnProductOrderItem> getAddOnOrderItemsOnAddON(
    TractProduct tractProduct,
    TractProduct[] productList,
    Map<String, list<Schdeule_Charge__c>> opportunityProductIdVsScheduleChargesMap,
    Map<String, String> information
  ) {
    List<RestAPI2Domain.GTVAPICreateAddOnProductOrderItem> addOnOrderItemsList = new List<RestAPI2Domain.GTVAPICreateAddOnProductOrderItem>();
    RestAPI2Domain.GTVAPICreateProductOrderItem orderItem = new RestAPI2Domain.GTVAPICreateProductOrderItem();
    list<RestAPI2Domain.GTVAPICreateOneTimePriceCharge> orderItemScheduleCharge;
    RestAPI2Domain.GTVAPICreateOrderItemPrice itemPrice;
    RestAPI2Domain.GTVAPIProductPriceRef productPrice;
    RestAPI2Domain.GTVAPICreateOrderItemPriceRange itemPriceRange;
    list<RestAPI2Domain.GTVAPICreateOrderItemPriceRange> orderItemListOfPriceRange;
    list<RestAPI2Domain.GTVAPICreateOrderItemPrice> orderItemListOfPrice;
    String subscriptionId = tractProduct.ProductId;
    for (TractProduct totalProducts : productList) {
      if (totalProducts.ServiceId == subscriptionId) {
        orderItemListOfPrice = new List<RestAPI2Domain.GTVAPICreateOrderItemPrice>();
        orderItemScheduleCharge = new List<RestAPI2Domain.GTVAPICreateOneTimePriceCharge>();
        RestAPI2Domain.GTVAPICreateAddOnProductOrderItem addOnOrderItem = new RestAPI2Domain.GTVAPICreateAddOnProductOrderItem();
        addOnOrderItem.quantity = Double.valueof(totalProducts.quantity);
        addOnOrderItem.sequence = 1;

        if (
          !(null == totalProducts.description ||
          totalProducts.description.equals(''))
        ) {
          addOnOrderItem.description = totalProducts.description;
        }
        addOnOrderItem.overrideTrialDays = Integer.valueof(
          totalProducts.overridedTrialLength
        );
        // mapping the product data
        addOnOrderItem.product = new RestAPI2Domain.GTVAPIProductRef();
        addOnOrderItem.product.id = totalProducts.eid;
        addOnOrderItem.product.name = totalProducts.name;
        addOnOrderItem.product.productType = 'add-on';

        // mapping the pricelist data
        addOnOrderItem.priceList = new RestAPI2Domain.GTVAPIPriceListRef();
        addOnOrderItem.priceList.id = totalProducts.priceListEid;

        addOnOrderItem.order_item_type = 'add-on';

        // mapping the discount code
        if (
          null != totalProducts.discountCodeName &&
          null != totalProducts.discountCodeEid
        ) {
          addOnOrderItem.orderItemDiscount = new RestAPI2Domain.GTVAPICreateOrderItemDiscount();
          addOnOrderItem.orderItemDiscount.discountResource = new RestAPI2Domain.GTVAPIDiscountResourceRef();
          addOnOrderItem.orderItemDiscount.discountResource.id = totalProducts.discountCodeEid;
          addOnOrderItem.orderItemDiscount.discountResource.identifier = totalProducts.discountCodeName;
        }

        // mapping the agreement
        if (
          !String.isBlank(totalProducts.agreementEndAction) ||
          totalProducts.overrideAgreementEndDate != null
        ) {
          addOnOrderItem.order_item_agreement = new RestAPI2Domain.GTVAPICreateOrderItemAgreement();
          addOnOrderItem.order_item_agreement.agreement = new RestAPI2Domain.GTVAPIAgreementRef();
          addOnOrderItem.order_item_agreement.agreement.id = totalProducts.Agreement_eid;
          if (null != totalProducts.overrideAgreementEndDate) {
            addOnOrderItem.order_item_agreement.endDate = ZConvert.getFormattedDateTimeString(
              Date.valueOf(totalProducts.overrideAgreementEndDate),
              'yyyy-MM-dd\'T\'HH:mm:ss.SSSXXX'
            );
          }
          if (!String.isBlank(totalProducts.agreementEndAction)) {
            addOnOrderItem.order_item_agreement.endAction = totalProducts.agreementEndAction;
          }
          if (totalProducts.Agreement_Period != null) {
            addOnOrderItem.order_item_agreement.agreement_period = integer.valueof(
              totalProducts.Agreement_Period
            );
          }
          if (totalProducts.renewalPricing == 'Service Price') {
            addOnOrderItem.order_item_agreement.preserveServicePrice = true;
          } else if (totalProducts.renewalPricing == 'Product Price') {
            addOnOrderItem.order_item_agreement.preserveServicePrice = false;
          }
          if (
            totalProducts.nextAgreementEid != null &&
            totalProducts.nextAgreementEndAction != null
          ) {
            addOnOrderItem.order_item_agreement.nextAgreement = new RestAPI2Domain.GTVAPIAgreementRef();
            addOnOrderItem.order_item_agreement.nextAgreement.id = totalProducts.nextAgreementEid;
            addOnOrderItem.order_item_agreement.nextEndAction = totalProducts.nextAgreementEndAction;
            if (totalProducts.nextRenewalPricing == 'Service Price') {
              addOnOrderItem.order_item_agreement.nextPreserveServicePrice = true;
            } else if (totalProducts.nextRenewalPricing == 'Product Price') {
              addOnOrderItem.order_item_agreement.nextPreserveServicePrice = false;
            }
          }
        }

        //mapping the Product Prices
        Product2 pro = [
          SELECT Id, Name, Price_Information__c
          FROM Product2
          WHERE Id = :totalProducts.ProductId
        ];
        List<ProductPriceWrapper> productPriceWrapList = (list<ProductPriceWrapper>) JSON.deserialize(
          pro.Price_Information__c,
          list<ProductPriceWrapper>.class
        );
        for (ProductPriceWrapper ppw : productPriceWrapList) {
          if (
            ppw.priceType == 'recurring' &&
            ppw.eid == totalProducts.recurringProductPriceEid
          ) {
            itemPrice = new RestAPI2Domain.GTVAPICreateOrderItemPrice();
            itemPrice.order_item_price_type = 'recurring';
            productPrice = new RestAPI2Domain.GTVAPIProductPriceRef();
            productPrice.product_price_type = ppw.priceType;
            productPrice.id = ppw.eid;
            itemPrice.product_price = productPrice;
            if (totalProducts.recurringPrice != null) {
              orderItemListOfPriceRange = new List<RestAPI2Domain.GTVAPICreateOrderItemPriceRange>();
              for (
                ProductPriceRangeWrapper priceRange : totalProducts.overridedRecurringPriceRangesList
              ) {
                itemPriceRange = new RestAPI2Domain.GTVAPICreateOrderItemPriceRange();
                itemPriceRange.price = priceRange.price;
                itemPriceRange.currency_code = ppw.currencyType;
                itemPriceRange.quantity_begin_range = priceRange.quantityBeginRange;
                if (priceRange.quantityEndRange != null) {
                  itemPriceRange.quantity_end_range = priceRange.quantityEndRange;
                }
                itemPriceRange.level = priceRange.level;
                orderItemListOfPriceRange.add(itemPriceRange);
              }
              itemPrice.price_ranges = orderItemListOfPriceRange;
            }
            itemPrice.usage_rules = getOrderItemProductUsageList(
              totalProducts.eid,
              information.get('OpportunityId')
            );
            orderItemListOfPrice.add(itemPrice);
          }

          if (
            ppw.priceType == 'one-time' &&
            ppw.eid == totalProducts.OneTimeProductPriceEid
          ) {
            itemPrice = new RestAPI2Domain.GTVAPICreateOrderItemPrice();
            itemPrice.order_item_price_type = 'one-time';
            productPrice = new RestAPI2Domain.GTVAPIProductPriceRef();
            productPrice.product_price_type = ppw.priceType;
            productPrice.id = ppw.eid;
            itemPrice.product_price = productPrice;
            if (totalProducts.oneTimePrice != null) {
              orderItemListOfPriceRange = new List<RestAPI2Domain.GTVAPICreateOrderItemPriceRange>();
              for (
                ProductPriceRangeWrapper priceRange : totalProducts.overridedOneTimePriceRangesList
              ) {
                itemPriceRange = new RestAPI2Domain.GTVAPICreateOrderItemPriceRange();
                itemPriceRange.price = priceRange.price;
                itemPriceRange.currency_code = ppw.currencyType;
                itemPriceRange.quantity_begin_range = priceRange.quantityBeginRange;
                if (priceRange.quantityEndRange != null) {
                  itemPriceRange.quantity_end_range = priceRange.quantityEndRange;
                }
                itemPriceRange.level = priceRange.level;
                orderItemListOfPriceRange.add(itemPriceRange);
              }
              itemPrice.price_ranges = orderItemListOfPriceRange;
            }
            if (
              opportunityProductIdVsScheduleChargesMap.containsKey(
                totalProducts.opportunityProductId
              )
            ) {
              for (
                Schdeule_Charge__c charge : opportunityProductIdVsScheduleChargesMap.get(
                  totalProducts.opportunityProductId
                )
              ) {
                RestAPI2Domain.GTVAPICreateOneTimePriceCharge priceCharge = new RestAPI2Domain.GTVAPICreateOneTimePriceCharge();
                priceCharge.priceChargeType = charge.Charge_Type__c;
                priceCharge.description = charge.Schdeule_Description__c;
                priceCharge.amount = Double.valueOf(charge.Schdeule_Amount__c);
                priceCharge.chargeDate = charge.Schdeule_Date__c;
                orderItemScheduleCharge.add(priceCharge);
              }
              itemPrice.scheduled_charges = orderItemScheduleCharge;
            }
            orderItemListOfPrice.add(itemPrice);
          }
        }
        addOnOrderItem.order_item_prices = orderItemListOfPrice;

        // mapping the service resources
        if (
          totalProducts.minServiceResources > 0 ||
          totalProducts.maxServiceResources > 0
        ) {
          addOnOrderItem.service_resources = new List<RestAPI2Domain.GTVAPICreateOrAddServiceResource>();
          RestAPI2Domain.GTVAPICreateOrAddServiceResource serviceResourceObj;
          if (
            null != totalProducts.TractServiceResourceEid &&
            null != totalProducts.TractServiceResourceName
          ) {
            list<String> srIdentifier = new List<String>();
            list<String> srEid = new List<String>();
            for (
              String str : totalProducts.TractServiceResourceName.split('\\|')
            ) {
              if (null != str && str.trim() != '') {
                srIdentifier.add(str);
              }
            }
            for (
              String str : totalProducts.TractServiceResourceEid.split('\\|')
            ) {
              if (null != str && str.trim() != '') {
                srEid.add(str);
              }
            }
            for (Integer i = 0; i < srIdentifier.size(); i++) {
              serviceResourceObj = new RestAPI2Domain.GTVAPICreateOrAddServiceResource();
              serviceResourceObj.id = srEid[i];
              serviceResourceObj.identifier = srIdentifier[i];
              serviceResourceObj.resourceType = RestAPI2Domain.GTVAPIResourceType.SERVICE;
              addOnOrderItem.service_resources.add(serviceResourceObj);
            }
          }
          if (
            null != totalProducts.NewServiceResource &&
            '' != totalProducts.NewServiceResource
          ) {
            for (
              String newSrIdenfier : totalProducts.NewServiceResource.split(
                '\\|'
              )
            ) {
              if (!String.isBlank(newSrIdenfier) && newSrIdenfier != null) {
                serviceResourceObj = new RestAPI2Domain.GTVAPICreateOrAddServiceResource();
                serviceResourceObj.identifier = newSrIdenfier;
                serviceResourceObj.resourceType = RestAPI2Domain.GTVAPIResourceType.SERVICE;
                serviceResourceObj.category = new RestAPI2Domain.GTVAPIResourceCategoryRef();
                serviceResourceObj.category.id = totalProducts.Service_Resource_Category;
                addOnOrderItem.service_resources.add(serviceResourceObj);
              }
            }
          }
        }
        addOnOrderItemsList.add(addOnOrderItem);
      }
    }
    return addOnOrderItemsList;
  }

  /**
   * @description: Map addon's having existing service on account as parent service for a GTV order
   * @param totalProducts, addon order item.
   * @param opportunityProductIdVsScheduleChargesMap, Map of OLIId and Schedulecharge.
   * @param information, Map containing required information for creating salesorder request
   * @return RestAPI2Domain.GTVAPICreateProductOrderItem, The List of RestAPI2Domain.GTVAPICreateProductOrderItem class.
   */
  public static RestAPI2Domain.GTVAPICreateProductOrderItem getAddonWithExistingService(
    TractProduct totalProducts,
    Map<String, list<Schdeule_Charge__c>> opportunityProductIdVsScheduleChargesMap,
    Map<String, String> information
  ) {
    list<RestAPI2Domain.GTVAPICreateOrderItemPrice> orderItemListOfPrice = new List<RestAPI2Domain.GTVAPICreateOrderItemPrice>();
    RestAPI2Domain.GTVAPICreateProductOrderItem addOnOrderItem = new RestAPI2Domain.GTVAPICreateProductOrderItem();
    RestAPI2Domain.GTVAPICreateOrderItemPrice itemPrice;
    RestAPI2Domain.GTVAPIProductPriceRef productPrice;
    RestAPI2Domain.GTVAPICreateOrderItemPriceRange itemPriceRange;
    list<RestAPI2Domain.GTVAPICreateOneTimePriceCharge> orderItemScheduleCharge = new List<RestAPI2Domain.GTVAPICreateOneTimePriceCharge>();
    list<RestAPI2Domain.GTVAPICreateOrderItemPriceRange> orderItemListOfPriceRange;
    addOnOrderItem.quantity = Double.valueof(totalProducts.quantity);
    addOnOrderItem.sequence = 1;
    if (
      !(null == totalProducts.description ||
      totalProducts.description.equals(''))
    ) {
      addOnOrderItem.description = totalProducts.description;
    }
    // mapping the product data
    addOnOrderItem.product = new RestAPI2Domain.GTVAPIProductRef();
    addOnOrderItem.product.id = totalProducts.eid;
    addOnOrderItem.product.name = totalProducts.name;
    addOnOrderItem.product.productType = 'add-on';
    addOnOrderItem.overrideTrialDays = Integer.valueof(
      totalProducts.overridedTrialLength
    );
    // mapping the pricelist data
    addOnOrderItem.priceList = new RestAPI2Domain.GTVAPIPriceListRef();
    addOnOrderItem.priceList.id = totalProducts.priceListEid;
    if (totalProducts.ProductCode == 'ADD-ON') {
      addOnOrderItem.order_item_type = 'add-on';
      // mapping the discount code
      if (
        null != totalProducts.discountCodeName &&
        null != totalProducts.discountCodeEid
      ) {
        addOnOrderItem.orderItemDiscount = new RestAPI2Domain.GTVAPICreateOrderItemDiscount();
        addOnOrderItem.orderItemDiscount.discountResource = new RestAPI2Domain.GTVAPIDiscountResourceRef();
        addOnOrderItem.orderItemDiscount.discountResource.id = totalProducts.discountCodeEid;
        addOnOrderItem.orderItemDiscount.discountResource.identifier = totalProducts.discountCodeName;
      }
      // mapping the agreement
      if (
        !String.isBlank(totalProducts.agreementEndAction) ||
        totalProducts.overrideAgreementEndDate != null
      ) {
        addOnOrderItem.order_item_agreement = new RestAPI2Domain.GTVAPICreateOrderItemAgreement();
        addOnOrderItem.order_item_agreement.agreement = new RestAPI2Domain.GTVAPIAgreementRef();
        addOnOrderItem.order_item_agreement.agreement.id = totalProducts.Agreement_eid;
        if (null != totalProducts.overrideAgreementEndDate) {
          addOnOrderItem.order_item_agreement.endDate = ZConvert.getFormattedDateTimeString(
            Date.valueOf(totalProducts.overrideAgreementEndDate),
            'yyyy-MM-dd\'T\'HH:mm:ss.SSSXXX'
          );
        }
        if (!String.isBlank(totalProducts.agreementEndAction)) {
          addOnOrderItem.order_item_agreement.endAction = totalProducts.agreementEndAction;
        }
        if (totalProducts.Agreement_Period != null) {
          addOnOrderItem.order_item_agreement.agreement_period = integer.valueof(
            totalProducts.Agreement_Period
          );
        }
        if (totalProducts.renewalPricing == 'Service Price') {
          addOnOrderItem.order_item_agreement.preserveServicePrice = true;
        } else if (totalProducts.renewalPricing == 'Product Price') {
          addOnOrderItem.order_item_agreement.preserveServicePrice = false;
        }
        if (
          totalProducts.nextAgreementEid != null &&
          totalProducts.nextAgreementEndAction != null
        ) {
          addOnOrderItem.order_item_agreement.nextAgreement = new RestAPI2Domain.GTVAPIAgreementRef();
          addOnOrderItem.order_item_agreement.nextAgreement.id = totalProducts.nextAgreementEid;
          addOnOrderItem.order_item_agreement.nextEndAction = totalProducts.nextAgreementEndAction;
          if (totalProducts.nextRenewalPricing == 'Service Price') {
            addOnOrderItem.order_item_agreement.nextPreserveServicePrice = true;
          } else if (totalProducts.nextRenewalPricing == 'Product Price') {
            addOnOrderItem.order_item_agreement.nextPreserveServicePrice = false;
          }
        }
      }
      //mapping the Product Prices
      Product2 pro = [
        SELECT Id, Name, Price_Information__c
        FROM Product2
        WHERE Id = :totalProducts.ProductId
      ];
      List<ProductPriceWrapper> productPriceWrapList = (list<ProductPriceWrapper>) JSON.deserialize(
        pro.Price_Information__c,
        list<ProductPriceWrapper>.class
      );
      for (ProductPriceWrapper ppw : productPriceWrapList) {
        if (
          ppw.priceType == 'recurring' &&
          ppw.eid == totalProducts.recurringProductPriceEid
        ) {
          itemPrice = new RestAPI2Domain.GTVAPICreateOrderItemPrice();
          itemPrice.order_item_price_type = 'recurring';
          productPrice = new RestAPI2Domain.GTVAPIProductPriceRef();
          productPrice.product_price_type = ppw.priceType;
          productPrice.id = ppw.eid;
          itemPrice.product_price = productPrice;
          if (totalProducts.recurringPrice != null) {
            orderItemListOfPriceRange = new List<RestAPI2Domain.GTVAPICreateOrderItemPriceRange>();
            for (
              ProductPriceRangeWrapper priceRange : totalProducts.overridedRecurringPriceRangesList
            ) {
              itemPriceRange = new RestAPI2Domain.GTVAPICreateOrderItemPriceRange();
              itemPriceRange.price = priceRange.price;
              itemPriceRange.currency_code = ppw.currencyType;
              itemPriceRange.quantity_begin_range = priceRange.quantityBeginRange;
              if (priceRange.quantityEndRange != null) {
                itemPriceRange.quantity_end_range = priceRange.quantityEndRange;
              }
              itemPriceRange.level = priceRange.level;
              orderItemListOfPriceRange.add(itemPriceRange);
            }
            itemPrice.price_ranges = orderItemListOfPriceRange;
          }
          itemPrice.usage_rules = getOrderItemProductUsageList(
            totalProducts.eid,
            information.get('OpportunityId')
          );
          orderItemListOfPrice.add(itemPrice);
        }
        if (
          ppw.priceType == 'one-time' &&
          ppw.eid == totalProducts.OneTimeProductPriceEid
        ) {
          itemPrice = new RestAPI2Domain.GTVAPICreateOrderItemPrice();
          itemPrice.order_item_price_type = 'one-time';
          productPrice = new RestAPI2Domain.GTVAPIProductPriceRef();
          productPrice.product_price_type = ppw.priceType;
          productPrice.id = ppw.eid;
          itemPrice.product_price = productPrice;
          if (totalProducts.oneTimePrice != null) {
            orderItemListOfPriceRange = new List<RestAPI2Domain.GTVAPICreateOrderItemPriceRange>();
            for (
              ProductPriceRangeWrapper priceRange : totalProducts.overridedOneTimePriceRangesList
            ) {
              itemPriceRange = new RestAPI2Domain.GTVAPICreateOrderItemPriceRange();
              itemPriceRange.price = priceRange.price;
              itemPriceRange.currency_code = ppw.currencyType;
              itemPriceRange.quantity_begin_range = priceRange.quantityBeginRange;
              if (priceRange.quantityEndRange != null) {
                itemPriceRange.quantity_end_range = priceRange.quantityEndRange;
              }
              itemPriceRange.level = priceRange.level;
              orderItemListOfPriceRange.add(itemPriceRange);
            }
            itemPrice.price_ranges = orderItemListOfPriceRange;
          }
          if (
            opportunityProductIdVsScheduleChargesMap.containsKey(
              totalProducts.opportunityProductId
            )
          ) {
            for (
              Schdeule_Charge__c charge : opportunityProductIdVsScheduleChargesMap.get(
                totalProducts.opportunityProductId
              )
            ) {
              RestAPI2Domain.GTVAPICreateOneTimePriceCharge priceCharge = new RestAPI2Domain.GTVAPICreateOneTimePriceCharge();
              priceCharge.priceChargeType = charge.Charge_Type__c;
              priceCharge.description = charge.Schdeule_Description__c;
              priceCharge.amount = Double.valueOf(charge.Schdeule_Amount__c);
              priceCharge.chargeDate = charge.Schdeule_Date__c;
              orderItemScheduleCharge.add(priceCharge);
            }
            itemPrice.scheduled_charges = orderItemScheduleCharge;
          }
          orderItemListOfPrice.add(itemPrice);
        }
      }
      addOnOrderItem.order_item_prices = orderItemListOfPrice;
      if (
        totalProducts.minServiceResources > 0 ||
        totalProducts.maxServiceResources > 0
      ) {
        RestAPI2Domain.GTVAPICreateOrAddServiceResource serviceResourceObj;
        if (
          null != totalProducts.TractServiceResourceEid &&
          null != totalProducts.TractServiceResourceName
        ) {
          list<String> srIdentifier = new List<String>();
          list<String> srEid = new List<String>();
          for (
            String str : totalProducts.TractServiceResourceName.split('\\|')
          ) {
            if (null != str && str.trim() != '') {
              srIdentifier.add(str);
            }
          }
          for (
            String str : totalProducts.TractServiceResourceEid.split('\\|')
          ) {
            if (null != str && str.trim() != '') {
              srEid.add(str);
            }
          }
          for (Integer i = 0; i < srIdentifier.size(); i++) {
            serviceResourceObj = new RestAPI2Domain.GTVAPICreateOrAddServiceResource();
            serviceResourceObj.id = srEid[i];
            serviceResourceObj.identifier = srIdentifier[i];
            serviceResourceObj.resourceType = RestAPI2Domain.GTVAPIResourceType.SERVICE;
            addOnOrderItem.service_resources.add(serviceResourceObj);
          }
        }
        if (
          null != totalProducts.NewServiceResource &&
          '' != totalProducts.NewServiceResource
        ) {
          for (
            String newSrIdenfier : totalProducts.NewServiceResource.split('\\|')
          ) {
            if (!String.isBlank(newSrIdenfier) && newSrIdenfier != null) {
              serviceResourceObj = new RestAPI2Domain.GTVAPICreateOrAddServiceResource();
              serviceResourceObj.identifier = newSrIdenfier;
              serviceResourceObj.resourceType = RestAPI2Domain.GTVAPIResourceType.SERVICE;
              serviceResourceObj.category = new RestAPI2Domain.GTVAPIResourceCategoryRef();
              serviceResourceObj.category.id = totalProducts.Service_Resource_Category;
              addOnOrderItem.service_resources.add(serviceResourceObj);
            }
          }
        }
      }
    }
    RestAPI2Domain.GTVAPIServiceRef parentService = new RestAPI2Domain.GTVAPIServiceRef();
    parentService.id = totalProducts.parentServiceEid;
    addOnOrderItem.parentService = parentService;
    return addOnOrderItem;
  }

  /**
   * @description: Map one-time order item for a GTV order
   * @param tractProduct, one-time order item.
   * @param opportunityProductIdVsOneTimeScheduleChargesMap, Map of OLIId and Schedulecharge.
   * @param information, Map containing required information for creating salesorder request
   * @return RestAPI2Domain.GTVAPICreateProductOrderItem, The List of RestAPI2Domain.GTVAPICreateProductOrderItem class.
   */
  public static RestAPI2Domain.GTVAPICreateProductOrderItem getOrderItemOneTime(
    TractProduct tractProduct,
    Map<String, String> information,
    Map<String, list<Schdeule_Charge__c>> opportunityProductIdVsOneTimeScheduleChargesMap
  ) {
    RestAPI2Domain.GTVAPICreateProductOrderItem orderItem = new RestAPI2Domain.GTVAPICreateProductOrderItem();
    RestAPI2Domain.GTVAPIProductPriceRef productPrice;
    RestAPI2Domain.GTVAPICreateOrderItemPriceRange itemPriceRange;
    list<RestAPI2Domain.GTVAPICreateOrderItemPriceRange> orderItemListOfPriceRange = new List<RestAPI2Domain.GTVAPICreateOrderItemPriceRange>();
    list<RestAPI2Domain.GTVAPICreateOneTimePriceCharge> orderItemScheduleCharge = new List<RestAPI2Domain.GTVAPICreateOneTimePriceCharge>();
    list<RestAPI2Domain.GTVAPICreateOrderItemPrice> orderItemListOfPrice = new List<RestAPI2Domain.GTVAPICreateOrderItemPrice>();
    orderItem.quantity = Double.valueof(tractProduct.quantity);
    orderItem.sequence = 1;
    orderItem.order_item_type = 'product';
    if (
      !(null == tractProduct.description || tractProduct.description.equals(''))
    ) {
      orderItem.description = tractProduct.name;
    }
    // mapping the product data
    orderItem.overrideTrialDays = Integer.valueof(
      tractProduct.overridedTrialLength
    );
    orderItem.product = new RestAPI2Domain.GTVAPIProductRef();
    orderItem.product.id = tractProduct.eid;
    orderItem.product.name = tractProduct.name;
    orderItem.product.productType = 'general';
    //mapping the Product Prices
    Product2 pro = [
      SELECT Id, Name, Price_Information__c
      FROM Product2
      WHERE Id = :tractProduct.ProductId
    ];
    List<ProductPriceWrapper> productPriceWrapList = (list<ProductPriceWrapper>) JSON.deserialize(
      pro.Price_Information__c,
      list<ProductPriceWrapper>.class
    );
    for (ProductPriceWrapper ppw : productPriceWrapList) {
      if (
        ppw.priceType == 'one-time' &&
        ppw.eid == tractProduct.OneTimeProductPriceEid
      ) {
        RestAPI2Domain.GTVAPICreateOrderItemPrice itemPrice = new RestAPI2Domain.GTVAPICreateOrderItemPrice();
        itemPrice.order_item_price_type = 'one-time';
        productPrice = new RestAPI2Domain.GTVAPIProductPriceRef();
        productPrice.product_price_type = ppw.priceType;
        productPrice.id = ppw.eid;
        itemPrice.product_price = productPrice;
        if (tractProduct.oneTimePrice != null) {
          orderItemListOfPriceRange = new List<RestAPI2Domain.GTVAPICreateOrderItemPriceRange>();
          for (
            ProductPriceRangeWrapper priceRange : tractProduct.overridedOneTimePriceRangesList
          ) {
            itemPriceRange = new RestAPI2Domain.GTVAPICreateOrderItemPriceRange();
            itemPriceRange.price = priceRange.price;
            itemPriceRange.currency_code = ppw.currencyType;
            itemPriceRange.quantity_begin_range = priceRange.quantityBeginRange;
            if (priceRange.quantityEndRange != null) {
              itemPriceRange.quantity_end_range = priceRange.quantityEndRange;
            }
            itemPriceRange.level = priceRange.level;
            orderItemListOfPriceRange.add(itemPriceRange);
          }
          itemPrice.price_ranges = orderItemListOfPriceRange;
        }
        if (
          opportunityProductIdVsOneTimeScheduleChargesMap.containsKey(
            tractProduct.opportunityProductId
          )
        ) {
          for (
            Schdeule_Charge__c charge : opportunityProductIdVsOneTimeScheduleChargesMap.get(
              tractProduct.opportunityProductId
            )
          ) {
            RestAPI2Domain.GTVAPICreateOneTimePriceCharge priceCharge = new RestAPI2Domain.GTVAPICreateOneTimePriceCharge();
            priceCharge.priceChargeType = charge.Charge_Type__c;
            priceCharge.description = charge.Schdeule_Description__c;
            priceCharge.amount = Double.valueOf(charge.Schdeule_Amount__c);
            priceCharge.chargeDate = charge.Schdeule_Date__c;
            orderItemScheduleCharge.add(priceCharge);
          }
          itemPrice.scheduled_charges = orderItemScheduleCharge;
        }
        orderItemListOfPrice.add(itemPrice);
      }
    }
    orderItem.order_item_prices = orderItemListOfPrice;
    return orderItem;
  }

  /**
   * @description: Map order item usage rule
   * @param productEid, GTV product id.
   * @param opportunityId, salesforce opportunity Id.
   * @param information, Map containing required information for creating salesorder request
   * @return List<RestAPI2Domain.GTVAPICreateUsageRuleTemplate>, The List of RestAPI2Domain.GTVAPICreateUsageRuleTemplate class.
   */
  public static List<RestAPI2Domain.GTVAPICreateUsageRuleTemplate> getOrderItemProductUsageList(
    String productEid,
    String opportunityId
  ) {
    List<RestAPI2Domain.GTVAPICreateUsageRuleTemplate> productUsageRulesList = new List<RestAPI2Domain.GTVAPICreateUsageRuleTemplate>();
    for (OrderUsageRule__c orderUsageRule : [
      SELECT
        id,
        ProductEid__c,
        AllowanceType__c,
        ChargeCategory__c,
        ChargeCategoryEid__c,
        FormulaFieldName__c,
        FormulaFieldvalue__c,
        FormulaOperator__c,
        GlobalUsageEid__c,
        Limit__c,
        ProductUsageValue__c,
        ProratedOnCancel__c,
        ProratedOnOrder__c,
        RateTableEid__c,
        RateTableUsageFieldName__c,
        RateTypeValue__c,
        RollOverType__c,
        RuleType__c,
        Status__c,
        UsageRate__c,
        name,
        UsageUom__c,
        UsageRateUom__c
      FROM OrderUsageRule__c
      WHERE ProductEid__c = :productEid AND OpportunityID__c = :opportunityId
      LIMIT 50000
    ]) {
      RestAPI2Domain.GTVAPICreateUsageRuleTemplate productUsageRule = new RestAPI2Domain.GTVAPICreateUsageRuleTemplate();
      productUsageRule.usageRuleType = 'order-item';
      productUsageRule.name = orderUsageRule.name;
      productUsageRule.ruleType = RestAPI2Domain.GTVAPIRuleType.TAPERED;
      for (
        RestAPI2Domain.GTVAPIServiceUsageRuleStatus status : RestAPI2Domain.GTVAPIServiceUsageRuleStatus.values()
      ) {
        if (status.name() == orderUsageRule.Status__c.toUpperCase()) {
          productUsageRule.status = status;
        }
      }
      productUsageRule.allowanceAmount = orderUsageRule.Limit__c;
      for (
        RestAPI2Domain.GTVAPIUsageDurationUom uom : RestAPI2Domain.GTVAPIUsageDurationUom.values()
      ) {
        if (uom.name() == orderUsageRule.UsageUom__c.toUpperCase()) {
          productUsageRule.allowanceUom = uom;
        }
      }
      productUsageRule.proratedOnOrder = Boolean.valueOf(
        orderUsageRule.ProratedOnOrder__c
      );
      productUsageRule.proratedOnCancel = Boolean.valueOf(
        orderUsageRule.ProratedOnCancel__c
      );
      for (
        RestAPI2Domain.GTVAPIRollOverType type : RestAPI2Domain.GTVAPIRollOverType.values()
      ) {
        if (type.name() == orderUsageRule.RollOverType__c.toUpperCase()) {
          productUsageRule.rollOverType = type;
        }
      }
      for (
        RestAPI2Domain.GTVAPIAllowanceType type : RestAPI2Domain.GTVAPIAllowanceType.values()
      ) {
        if (type.name() == orderUsageRule.AllowanceType__c.toUpperCase()) {
          productUsageRule.allowanceType = type;
        }
      }
      if (orderUsageRule.ProductUsageValue__c == 'Match All Events') {
        RestAPI2Domain.GTVAPICreateUsageRuleSpecification spec = new RestAPI2Domain.GTVAPICreateUsageRuleSpecification();
        spec.usageRuleSpecificationType = 'match-all';
        productUsageRule.spec = spec;
      } else if (orderUsageRule.ProductUsageValue__c == 'Formula') {
        RestAPI2Domain.GTVAPICreateUsageRuleSpecification spec = new RestAPI2Domain.GTVAPICreateUsageRuleSpecification();
        spec.usageRuleSpecificationType = 'formula';
        spec.operator = orderUsageRule.FormulaOperator__c.toUpperCase();
        spec.field_name = orderUsageRule.FormulaFieldName__c.toUpperCase();
        spec.field_value = orderUsageRule.FormulaFieldvalue__c;
        productUsageRule.spec = spec;
      }
      if (orderUsageRule.RateTypeValue__c == 'Flat') {
        RestAPI2Domain.GTVAPICreateUsageRate rate = new RestAPI2Domain.GTVAPICreateUsageRate();
        rate.rateType = 'flat';
        rate.uom = orderUsageRule.UsageRateUom__c.toUpperCase();
        rate.rate = orderUsageRule.UsageRate__c;
        RestAPI2Domain.GTVAPIUsageChargeCategoryRef cat = new RestAPI2Domain.GTVAPIUsageChargeCategoryRef();
        cat.chargeCategoryType = 'usage-charge';
        cat.id = orderUsageRule.ChargeCategoryEid__c;
        rate.chargeCategory = cat;
        productUsageRule.usageRate = rate;
      }
      if (orderUsageRule.RateTypeValue__c == 'Table Rate') {
        RestAPI2Domain.GTVAPICreateUsageRate rate = new RestAPI2Domain.GTVAPICreateUsageRate();
        rate.rateType = 'table';
        rate.uom = orderUsageRule.UsageUom__c.toUpperCase();
        rate.usage_field_name = orderUsageRule.RateTableUsageFieldName__c.toUpperCase();
        RestAPI2Domain.GTVAPIRateTable rateTable = new RestAPI2Domain.GTVAPIRateTable();
        rateTable.id = orderUsageRule.RateTableEid__c;
        rate.rate_table = rateTable;
        RestAPI2Domain.GTVAPIUsageChargeCategoryRef cat = new RestAPI2Domain.GTVAPIUsageChargeCategoryRef();
        cat.chargeCategoryType = 'usage-charge';
        cat.id = orderUsageRule.ChargeCategoryEid__c;
        rate.chargeCategory = cat;
        productUsageRule.usageRate = rate;
      }
      if (orderUsageRule.RateTypeValue__c == 'Pass Through') {
        RestAPI2Domain.GTVAPICreateUsageRate rate = new RestAPI2Domain.GTVAPICreateUsageRate();
        rate.rateType = 'pass-through';
        rate.uom = 'EVENT';
        rate.usage_field_name = orderUsageRule.RateTableUsageFieldName__c.toUpperCase();
        RestAPI2Domain.GTVAPIUsageChargeCategoryRef cat = new RestAPI2Domain.GTVAPIUsageChargeCategoryRef();
        cat.chargeCategoryType = 'usage-charge';
        cat.id = orderUsageRule.ChargeCategoryEid__c;
        rate.chargeCategory = cat;
        productUsageRule.usageRate = rate;
      }
      productUsageRulesList.add(productUsageRule);
    }
    return productUsageRulesList;
  }

  /**
   * @description: Get request to create product in GTV db
   * @param createProductWrapper, The create product wrapper instance.
   * @return RestAPI2Domain.GTVAPICreateProduct, The instance of RestAPI2Domain.GTVAPICreateProduct class.
   */
  public static RestAPI2Domain.GTVAPICreateProduct getCreateProductRequest(
    CreateProductWrapper createProductWrapper
  ) {
    RestAPI2Domain.GTVAPICreateProduct createProductReq = new RestAPI2Domain.GTVAPICreateProduct();
    createProductReq.productType = createProductWrapper.productType;
    createProductReq.name = createProductWrapper.productName;
    createProductReq.sku = createProductWrapper.SKU;
    createProductReq.externalProductNumber = createProductWrapper.externalName;
    createProductReq.internalName = createProductWrapper.internalName;
    createProductReq.description = createProductWrapper.Description;
    createProductReq.shortDescription = createProductWrapper.shortDescription;
    createProductReq.introductionDate = createProductWrapper.introductionDate;
    createProductReq.serialized = createProductWrapper.unique;
    createProductReq.taxable = createProductWrapper.taxable;
    if (createProductWrapper.selectedproductTagsList.size() > 0) {
      for (String productTagId : createProductWrapper.selectedproductTagsList) {
        RestAPI2Domain.GTVAPIProductTagRef productTag = new RestAPI2Domain.GTVAPIProductTagRef();
        productTag.id = productTagId;
        createProductReq.productTags.add(productTag);
      }
    }
    if (
      createProductWrapper.productCategory != null &&
      createProductWrapper.productCategory != ''
    ) {
      createProductReq.productCategory = new RestAPI2Domain.GTVAPIProductCategoryRef();
      createProductReq.productCategory.id = createProductWrapper.productCategory;
    }
    if (!createProductWrapper.unique) {
      createProductReq.defaultQuantity = createProductWrapper.defaultQuantity;
    }

    if (
      createProductWrapper.productType == 'general' &&
      createProductWrapper.fundPrepaidBalance
    ) {
      if (
        createProductWrapper.productRegisterType != null &&
        createProductWrapper.productRegisterType != ''
      ) {
        createProductReq.registerType = new RestAPI2Domain.GTVAPIProductRegisterTypeRef();
        createProductReq.registerType.id = createProductWrapper.productRegisterType;
      }
    }

    if (
      (createProductWrapper.productType == 'add-on' ||
      createProductWrapper.productType == 'customer-subscription') &&
      createProductWrapper.consumePrepaidBalance
    ) {
      if (
        createProductWrapper.productRegisterType != null &&
        createProductWrapper.productRegisterType != ''
      ) {
        createProductReq.registerType = new RestAPI2Domain.GTVAPIProductRegisterTypeRef();
        createProductReq.registerType.id = createProductWrapper.productRegisterType;
      }
    }

    if (createProductWrapper.productType == 'general') {
      createProductReq.fundPrepaidBalance = createProductWrapper.fundPrepaidBalance;
    } else if (
      createProductWrapper.productType == 'add-on' ||
      createProductWrapper.productType == 'customer-subscription'
    ) {
      createProductReq.requiresAgreement = createProductWrapper.agreementMandatory;
      createProductReq.ruleMode = createProductWrapper.ruleMode;
      createProductReq.ruleType = createProductWrapper.ruleType;
      createProductReq.ruleOverride = createProductWrapper.ruleOverride;
      createProductReq.consumePrepaidBalance = createProductWrapper.consumePrepaidBalance;
      createProductReq.minServiceResources = createProductWrapper.minimumIdentifiers;
      createProductReq.maxServiceResources = createProductWrapper.maximumIdentifiers;
      if (
        createProductWrapper.identifierCategory != null &&
        createProductWrapper.identifierCategory != ''
      ) {
        createProductReq.serviceResourceCategory = new RestAPI2Domain.GTVAPIResourceCategoryRef();
        createProductReq.serviceResourceCategory.id = createProductWrapper.identifierCategory;
      }
    }
    return createProductReq;
  }

  /**
   * @description: Get request to create product agreement relation in GTV db
   * @param agreement, The product agreement wrapper instance.
   * @return RestAPI2Domain.GTVAPICreateProductAgreementRelation, The instance of RestAPI2Domain.GTVAPICreateProductAgreementRelation class.
   */
  public static RestAPI2Domain.GTVAPICreateProductAgreementRelation mapProductNewAgreements(
    ProductAgreementWrapper agreement
  ) {
    RestAPI2Domain.GTVAPICreateProductAgreementRelation agreementRelation = new RestAPI2Domain.GTVAPICreateProductAgreementRelation();
    RestAPI2Domain.GTVAPIAgreementRef currentAgreement = new RestAPI2Domain.GTVAPIAgreementRef();
    currentAgreement.id = agreement.eid;
    agreementRelation.agreement = currentAgreement;
    return agreementRelation;
  }

  /**
   * @description: Get request to create product price in GTV db
   * @param createProductPriceWrapper, The product price wrapper instance.
   * @return RestAPI2Domain.GTVAPICreateProductPrice, The instance of RestAPI2Domain.GTVAPICreateProductPrice class.
   */
  public static RestAPI2Domain.GTVAPICreateProductPrice getCreateProductPriceRequest(
    CreateRecurringChargePriceWrapper createProductPriceWrapper
  ) {
    RestAPI2Domain.GTVAPICreateProductPrice createProductPriceReq = new RestAPI2Domain.GTVAPICreateProductPrice();
    if (
      createProductPriceWrapper.priceCategory != null &&
      createProductPriceWrapper.priceCategory != ''
    ) {
      createProductPriceReq.category = new RestAPI2Domain.GTVAPIPriceCategoryRef();
      createProductPriceReq.category.id = createProductPriceWrapper.priceCategory;
      createProductPriceReq.category.chargeCategoryType = 'price';
    }
    createProductPriceReq.currencyCode = createProductPriceWrapper.selectedcurrency;
    createProductPriceReq.tapered = createProductPriceWrapper.taperedPricing;
    createProductPriceReq.productPriceType = 'recurring';
    if (createProductPriceWrapper.fromDate != null) {
      createProductPriceReq.validFrom = ZConvert.getFormattedDateTimeString(
        createProductPriceWrapper.fromDate,
        'yyyy-MM-dd\'T\'HH:mm:ss.SSSXXX'
      );
    }
    createProductPriceReq.priceOverride = createProductPriceWrapper.priceOverride;
    createProductPriceReq.recurrencePeriod = createProductPriceWrapper.recurrencePeriod;
    createProductPriceReq.proratedOnOrder = createProductPriceWrapper.proratedOnOrder;
    createProductPriceReq.proratedOnCancel = createProductPriceWrapper.proratedOnCancel;
    createProductPriceReq.proratedOnOrderNoCharge = createProductPriceWrapper.proratedOnOrderNoCharge;

    createProductPriceReq.paymentOnPurchaseRequired = createProductPriceWrapper.payOnPurchase;
    if (
      createProductPriceWrapper.productPriceGroup != null &&
      createProductPriceWrapper.productPriceGroup != ''
    ) {
      createProductPriceReq.priceGroup = new RestAPI2Domain.GTVAPIProductPriceGroupRef();
      createProductPriceReq.priceGroup.id = createProductPriceWrapper.productPriceGroup;
    }
    if (createProductPriceWrapper.billingType == 'Bill In Advance') {
      createProductPriceReq.billInAdvance = true;
      if (createProductPriceWrapper.billInAdvance != null) {
        createProductPriceReq.billInAdvanceConfiguration = new RestAPI2Domain.GTVAPIBillInAdvanceConfiguration();
        createProductPriceReq.billInAdvanceConfiguration.amount = createProductPriceWrapper.billInAdvance;
        createProductPriceReq.billInAdvanceConfiguration.period = createProductPriceWrapper.billInAdvanceUnit;
      }
    } else {
      createProductPriceReq.billInAdvance = false;
    }
    if (
      createProductPriceWrapper.createPriceRangeWrapper != null &&
      createProductPriceWrapper.createPriceRangeWrapper.size() > 0
    ) {
      createProductPriceReq.priceRanges = new List<RestAPI2Domain.GTVAPICreatePriceRange>();
      for (
        CreatePriceRangeWrapper priceRangeWrapInstance : createProductPriceWrapper.createPriceRangeWrapper
      ) {
        RestAPI2Domain.GTVAPICreatePriceRange createPriceRange = new RestAPI2Domain.GTVAPICreatePriceRange();
        createPriceRange.priceRangeType = 'product';
        createPriceRange.quantityBeginRange = priceRangeWrapInstance.startingQuantity;
        createPriceRange.quantityEndRange = priceRangeWrapInstance.endingQuantity;
        createPriceRange.price = priceRangeWrapInstance.Price;
        createProductPriceReq.priceRanges.add(createPriceRange);
      }
    }

    return createProductPriceReq;
  }

  /**
   * @description: Get request to create onetime product price in GTV db
   * @param createOneTimeProductPriceWrapper, The create onetime product price wrapper instance.
   * @return RestAPI2Domain.GTVAPICreateProductPrice, The instance of RestAPI2Domain.GTVAPICreateProductPrice class.
   */
  public static RestAPI2Domain.GTVAPICreateProductPrice getCreateOneTimeProductPriceRequest(
    CreateOneTimeChargePriceWrapper createOneTimeProductPriceWrapper
  ) {
    RestAPI2Domain.GTVAPICreateProductPrice createOneTimeProductPriceReq = new RestAPI2Domain.GTVAPICreateProductPrice();
    if (
      createOneTimeProductPriceWrapper.priceCategory != null &&
      createOneTimeProductPriceWrapper.priceCategory != ''
    ) {
      createOneTimeProductPriceReq.category = new RestAPI2Domain.GTVAPIPriceCategoryRef();
      createOneTimeProductPriceReq.category.id = createOneTimeProductPriceWrapper.priceCategory;
      createOneTimeProductPriceReq.category.chargeCategoryType = 'price';
    }
    createOneTimeProductPriceReq.currencyCode = createOneTimeProductPriceWrapper.selectedcurrency;
    createOneTimeProductPriceReq.tapered = createOneTimeProductPriceWrapper.taperedPricing;
    createOneTimeProductPriceReq.productPriceType = 'one-time';
    if (createOneTimeProductPriceWrapper.fromDate != null) {
      createOneTimeProductPriceReq.validFrom = ZConvert.getFormattedDateTimeString(
        createOneTimeProductPriceWrapper.fromDate,
        'yyyy-MM-dd\'T\'HH:mm:ss.SSSXXX'
      );
    }
    createOneTimeProductPriceReq.priceOverride = createOneTimeProductPriceWrapper.priceOverride;
    createOneTimeProductPriceReq.paymentOnPurchaseRequired = createOneTimeProductPriceWrapper.payOnPurchase;
    createOneTimeProductPriceReq.allowScheduledCharges = createOneTimeProductPriceWrapper.requireScheduledCharges;
    createOneTimeProductPriceReq.chargeDuringRenewal = createOneTimeProductPriceWrapper.chargeAtRenewal;
    if (
      createOneTimeProductPriceWrapper.productPriceGroup != null &&
      createOneTimeProductPriceWrapper.productPriceGroup != ''
    ) {
      createOneTimeProductPriceReq.priceGroup = new RestAPI2Domain.GTVAPIProductPriceGroupRef();
      createOneTimeProductPriceReq.priceGroup.id = createOneTimeProductPriceWrapper.productPriceGroup;
    }
    if (
      createOneTimeProductPriceWrapper.createPriceRangeWrapper != null &&
      createOneTimeProductPriceWrapper.createPriceRangeWrapper.size() > 0
    ) {
      createOneTimeProductPriceReq.priceRanges = new List<RestAPI2Domain.GTVAPICreatePriceRange>();
      for (
        CreatePriceRangeWrapper priceRangeWrapInstance : createOneTimeProductPriceWrapper.createPriceRangeWrapper
      ) {
        RestAPI2Domain.GTVAPICreatePriceRange createPriceRange = new RestAPI2Domain.GTVAPICreatePriceRange();
        createPriceRange.priceRangeType = 'product';
        createPriceRange.quantityBeginRange = priceRangeWrapInstance.startingQuantity;
        createPriceRange.quantityEndRange = priceRangeWrapInstance.endingQuantity;
        createPriceRange.price = priceRangeWrapInstance.Price;
        createOneTimeProductPriceReq.priceRanges.add(createPriceRange);
      }
    }
    return createOneTimeProductPriceReq;
  }

  /**
   * @description: Get request to create product custom field value in GTV db
   * @param wrap, The list of ProductCustomFieldWrapper.
   * @return list<RestAPI2Domain.GTVAPICreateProductCustomFieldValue>, The list of RestAPI2Domain.GTVAPICreateProductCustomFieldValue class.
   */
  public static list<RestAPI2Domain.GTVAPICreateProductCustomFieldValue> mapProductCustomFieldValueRequest(
    list<ProductCustomFieldWrapper> wrap
  ) {
    list<RestAPI2Domain.GTVAPICreateProductCustomFieldValue> requestList = new List<RestAPI2Domain.GTVAPICreateProductCustomFieldValue>();
    for (ProductCustomFieldWrapper fld : wrap) {
      if (
        (null != fld.value && '' != fld.value) ||
        (null != fld.selectedListTypeValue &&
        'Choose One' != fld.selectedListTypeValue &&
        '' != fld.selectedListTypeValue)
      ) {
        RestAPI2Domain.GTVAPICreateProductCustomFieldValue customFieldVal = new RestAPI2Domain.GTVAPICreateProductCustomFieldValue();
        customFieldVal.custom_field_value_type = 'product';
        if (null != fld.selectedListTypeValue) {
          customFieldVal.value = fld.selectedListTypeValue;
        } else {
          customFieldVal.value = fld.value;
        }
        RestAPI2Domain.GTVAPICustomFieldRef ref = new RestAPI2Domain.GTVAPICustomFieldRef();
        ref.name = fld.name;
        ref.id = fld.Eid;
        ref.custom_field_type = 'product';
        customFieldVal.custom_field = ref;
        requestList.add(customFieldVal);
      }
    }
    return requestList;
  }

  /**
   * @description: Get request to create product relation with pricelist in GTV db
   * @param thisProductEid, The GTV product id.
   * @return RestAPI2Domain.GTVAPIProductRelation, The Instance of RestAPI2Domain.GTVAPIProductRelation class.
   */
  public static RestAPI2Domain.GTVAPIProductRelation mapProductToPriceList(
    String thisProductEid
  ) {
    RestAPI2Domain.GTVAPIProductRelation relation = new RestAPI2Domain.GTVAPIProductRelation();
    RestAPI2Domain.GTVAPIProductRef productRef = new RestAPI2Domain.GTVAPIProductRef();
    productRef.id = thisProductEid;
    relation.product = productRef;
    return relation;
  }
  /**
   * @description: Map the user input for activity charge rule to the GTV create service usage rule object.
   * @param serviceWrapper, The ProductServiceWrapper class instance.
   * @return RestAPI2Domain.GTVAPICreateServiceUsageRule, The instance of RestAPI2Domain.GTVAPICreateServiceUsageRule class.
   */
  public static RestAPI2Domain.GTVAPICreateProductUsageRule mapNewProductActivityChargeRule(
    ProductChargeRuleWrapper chargeRuleWrapper
  ) {
    String productUsageValue = chargeRuleWrapper.productUsageRuleListValue;
    String chargeCategoryValue = chargeRuleWrapper.chargeCategoryListValue;
    String allowanceValue = chargeRuleWrapper.allowanceTypeListValue;
    String amoutChargeSelect = chargeRuleWrapper.amountChargePickList != null
      ? chargeRuleWrapper.amountChargePickList
      : '';
    String statusValue = chargeRuleWrapper.selectStatusListValue;
    String rateTypeValue = chargeRuleWrapper.rateTypeListValue;
    String selectedCharge = chargeRuleWrapper.chargesPicklistValue;
    String chargeListByteValue = chargeRuleWrapper.chargeListBytesValue;
    String chargeFormulaFieldValue = chargeRuleWrapper.formulaFieldValue;
    String passThroughListValue = chargeRuleWrapper.passThroughChargeListValue;
    String fieldvalue = chargeRuleWrapper.formulaFieldValue;
    String selectedChargeGlobal = chargeRuleWrapper.chargesPicklistValue;
    String rollOverValue = chargeRuleWrapper.roleOverListValue;
    String productUsageRuleName = chargeRuleWrapper.productUsageRuleName;
    Boolean prorateOnOrder = chargeRuleWrapper.prorateOnOrder;
    Boolean prorateOnCancel = chargeRuleWrapper.prorateOnCancel;
    Double ammountValue = chargeRuleWrapper.ammountValue;
    String activityFormulaValue = chargeRuleWrapper.ActivityFormulaValue;
    Decimal chargeValue = chargeRuleWrapper.chargeValue;
    String operationListValue = chargeRuleWrapper.operationListValue;
    String validFrom = chargeRuleWrapper.validFrom;
    String validTo = chargeRuleWrapper.validTo;

    map<String, String> mapOfAllowanceType = new Map<String, String>();
    mapOfAllowanceType.put('UNLIMITED', 'UNLIMITED');
    mapOfAllowanceType.put('RECURRING', 'RECURRING');
    mapOfAllowanceType.put('ONETIME', 'ONE_TIME');
    // String checkRuleTypeValue = ruleTypeValue;
    RestAPI2Domain.GTVAPICreateproductUsageRule productUsageRule = new RestAPI2Domain.GTVAPICreateproductUsageRule();
    productUsageRule.usageRuleType = 'product';
    productUsageRule.name = productUsageRuleName;
    productUsageRule.ruleType = RestAPI2Domain.GTVAPIRuleType.TAPERED;

    productUsageRule.validFrom = validFrom;
    productUsageRule.validTo = validTo;

    for (
      RestAPI2Domain.GTVAPIproductUsageRuleStatus status : RestAPI2Domain.GTVAPIproductUsageRuleStatus.values()
    ) {
      if (status.name() == statusValue.toUpperCase()) {
        productUsageRule.status = status;
      }
    }
    productUsageRule.allowanceAmount = ammountValue;
    for (
      RestAPI2Domain.GTVAPIUsageDurationUom uom : RestAPI2Domain.GTVAPIUsageDurationUom.values()
    ) {
      if (uom.name() == amoutChargeSelect.toUpperCase()) {
        productUsageRule.allowanceUom = uom;
      }
    }
    for (
      RestAPI2Domain.GTVAPIAllowanceType type : RestAPI2Domain.GTVAPIAllowanceType.values()
    ) {
      if (type.name() == mapOfAllowanceType.get(allowanceValue.toUpperCase())) {
        productUsageRule.allowanceType = type;
        if (
          mapOfAllowanceType.get(allowanceValue.toUpperCase()) != 'UNLIMITED'
        ) {
          for (
            RestAPI2Domain.GTVAPIRollOverType rollType : RestAPI2Domain.GTVAPIRollOverType.values()
          ) {
            if (rollType.name() == rollOverValue.toUpperCase()) {
              productUsageRule.rollOverType = rollType;
            }
          }
        }
        if (
          mapOfAllowanceType.get(allowanceValue.toUpperCase()) == 'RECURRING'
        ) {
          productUsageRule.proratedOnOrder = prorateOnOrder;
          productUsageRule.proratedOnCancel = prorateOnCancel;
        } else {
          productUsageRule.proratedOnOrder = null;
          productUsageRule.proratedOnOrder = null;
        }
      }
    }
    if (productUsageValue == 'Match All Events') {
      RestAPI2Domain.GTVAPICreateUsageRuleSpecification spec = new RestAPI2Domain.GTVAPICreateUsageRuleSpecification();
      spec.usageRuleSpecificationType = 'match-all';
      productUsageRule.spec = spec;
    } else if (productUsageValue == 'Formula') {
      RestAPI2Domain.GTVAPICreateUsageRuleSpecification spec = new RestAPI2Domain.GTVAPICreateUsageRuleSpecification();
      spec.usageRuleSpecificationType = 'formula';
      spec.operator = operationListValue;
      spec.field_name = chargeFormulaFieldValue.toUpperCase();
      spec.field_value = activityFormulaValue;
      productUsageRule.spec = spec;
    }

    if (rateTypeValue == 'Flat') {
      RestAPI2Domain.GTVAPICreateUsageRate rate = new RestAPI2Domain.GTVAPICreateUsageRate();
      rate.rateType = 'flat';
      rate.uom = selectedCharge.toUpperCase();
      rate.rate = chargeValue;
      RestAPI2Domain.GTVAPIUsageChargeCategoryRef cat = new RestAPI2Domain.GTVAPIUsageChargeCategoryRef();
      cat.chargeCategoryType = 'usage-charge';
      cat.id = chargeCategoryValue;
      rate.chargeCategory = cat;
      productUsageRule.usageRate = rate;
    }
    if (rateTypeValue == 'Table Rate') {
      RestAPI2Domain.GTVAPICreateUsageRate rate = new RestAPI2Domain.GTVAPICreateUsageRate();
      rate.rateType = 'table';
      rate.uom = amoutChargeSelect.toUpperCase();
      rate.usage_field_name = chargeFormulaFieldValue.toUpperCase();
      RestAPI2Domain.GTVAPIRateTable rateTable = new RestAPI2Domain.GTVAPIRateTable();
      rateTable.id = chargeListByteValue;
      rate.rate_table = rateTable;
      RestAPI2Domain.GTVAPIUsageChargeCategoryRef cat = new RestAPI2Domain.GTVAPIUsageChargeCategoryRef();
      cat.chargeCategoryType = 'usage-charge';
      cat.id = chargeCategoryValue;
      rate.chargeCategory = cat;
      productUsageRule.usageRate = rate;
    }
    if (rateTypeValue == 'Pass Through') {
      RestAPI2Domain.GTVAPICreateUsageRate rate = new RestAPI2Domain.GTVAPICreateUsageRate();
      rate.rateType = 'pass-through';
      rate.uom = 'EVENT';
      rate.usage_field_name = passThroughListValue.toUpperCase();
      RestAPI2Domain.GTVAPIUsageChargeCategoryRef cat = new RestAPI2Domain.GTVAPIUsageChargeCategoryRef();
      cat.chargeCategoryType = 'usage-charge';
      cat.id = chargeCategoryValue;
      rate.chargeCategory = cat;
      productUsageRule.usageRate = rate;
      if (mapOfAllowanceType.get(allowanceValue.toUpperCase()) == 'UNLIMITED') {
        for (
          RestAPI2Domain.GTVAPIUsageDurationUom uom : RestAPI2Domain.GTVAPIUsageDurationUom.values()
        ) {
          if (uom.name() == selectedChargeGlobal.toUpperCase()) {
            productUsageRule.allowanceUom = uom;
          }
        }
      }
    }

    return productUsageRule;
  }
  public static RestAPI2Domain.GTVAPIPaymentRefererToken mapReferTokenURL() {
    RestAPI2Domain.GTVAPIPaymentRefererToken paymentURL = new RestAPI2Domain.GTVAPIPaymentRefererToken();
    paymentURL.errorURL = 'https://gotransverse.com?error';
    paymentURL.cancelURL = 'https://gotransverse.com?cancel';
    paymentURL.completeURL = 'https://gotransverse.com?complete';
    return paymentURL;
  }
  public static RestAPI2Domain.GTVAPICreatePaymentMethod mapNewPaymentMethodData(
    Map<String, Object> paymentDataMap
  ) {
    RestAPI2Domain.GTVAPICreatePaymentMethod paymentMethod = new RestAPI2Domain.GTVAPICreatePaymentMethod();
    paymentMethod.firstName = String.ValueOf(paymentDataMap.get('firstName'));
    paymentMethod.middleName = String.ValueOf(paymentDataMap.get('middleName'));
    paymentMethod.lastName = String.ValueOf(paymentDataMap.get('lastName'));
    paymentMethod.suffix = String.ValueOf(paymentDataMap.get('suffix'));
    paymentMethod.cardType = String.ValueOf(
      paymentDataMap.get('cardTypeSelect')
    );
    paymentMethod.cardNumber = String.ValueOf(paymentDataMap.get('cardNumber'));
    paymentMethod.cvv = String.ValueOf(paymentDataMap.get('cvv'));
    paymentMethod.expiryDate = String.ValueOf(paymentDataMap.get('expiryDate'));
    paymentMethod.emailAddress = String.ValueOf(paymentDataMap.get('email'));
    paymentMethod.address1 = String.ValueOf(paymentDataMap.get('street'));
    paymentMethod.city = String.ValueOf(paymentDataMap.get('city'));
    paymentMethod.state = String.ValueOf(paymentDataMap.get('state'));
    paymentMethod.country = String.ValueOf(paymentDataMap.get('country'));
    paymentMethod.postalCode = String.ValueOf(paymentDataMap.get('postalCode'));
    paymentMethod.token = String.ValueOf(paymentDataMap.get('token'));
    paymentMethod.nickname = String.ValueOf(paymentDataMap.get('nickname'));
    return paymentMethod;
  }
  public static RestAPI2Domain.GTVAPICreateRecurringPayment mapPaymentMethodCreate(
    String paymentToken,
    boolean isAutoPayment
  ) {
    RestAPI2Domain.GTVAPICreateRecurringPayment createPaymentMethod = new RestAPI2Domain.GTVAPICreateRecurringPayment();
    RestAPI2Domain.GTVAPIPaymentMethod methodType = new RestAPI2Domain.GTVAPIPaymentMethod();
    methodType.paymentMethodType = 'referenced';
    methodType.reference = paymentToken;
    createPaymentMethod.paymentMethod = methodType;
    createPaymentMethod.autoPayment = isAutoPayment;
    return createPaymentMethod;
  }
  public static RestAPI2Domain.GTVAPICreatePayment mapBillingPaymentCreate(
    Map<String, Object> mapOfPaymentData
  ) {
    RestAPI2Domain.GTVAPICreatePayment createPayment = new RestAPI2Domain.GTVAPICreatePayment();
    createPayment.paymentType = RestAPI2Domain.GTVAPIPaymentType.payment;
    RestAPI2Domain.GTVAPICreatePaymentMethod paymentMethod = new RestAPI2Domain.GTVAPICreatePaymentMethod();
    paymentMethod.Id = String.ValueOf(
      mapOfPaymentData.get('paymentMethodValue')
    );
    createPayment.paymentMethod = paymentMethod;
    createPayment.receivedAmount = Double.ValueOf(
      mapOfPaymentData.get('amount')
    );
    createPayment.description = String.ValueOf(
      mapOfPaymentData.get('description')
    );
    return createPayment;
  }

  public static RestAPI2Domain.GTVAPIChangeService getChangeCreateOrderRequest(
    CreatechangeOrderWrapper changeOrderWrapper
  ) {
    RestAPI2Domain.GTVAPIChangeService changeOrderRequest = new RestAPI2Domain.GTVAPIChangeService();
    //if(mapOfcreateChangeOrder.get('enablePreserveAgreement') != null){
    changeOrderRequest.preserveAgreement = changeOrderWrapper.enablePreserveAgreement;
    //}
    changeOrderRequest.order = new RestAPI2Domain.GTVAPICreateSalesOrder();
    changeOrderRequest.order.emailReceipt = changeOrderWrapper.EmailReciept;
    changeOrderRequest.order.orderDate = changeOrderWrapper.OrderDate;
    changeOrderRequest.order.orderItems = new List<RestAPI2Domain.GTVAPICreateProductOrderItem>();
    RestAPI2Domain.GTVAPICreateProductOrderItem orderItem = new RestAPI2Domain.GTVAPICreateProductOrderItem();
    orderItem.quantity = changeOrderWrapper.Quantity;
    orderItem.description = changeOrderWrapper.shortDescription;
    orderItem.product = new RestAPI2Domain.GTVAPIProductRef();
    orderItem.product.id = changeOrderWrapper.currentProductId;
    orderItem.product.productType = 'customer-subscription';
    orderItem.priceList = new RestAPI2Domain.GTVAPIPriceListRef();
    orderItem.priceList.id = changeOrderWrapper.priceListId;
    orderItem.order_item_type = 'product';
    orderItem.order_item_prices = new List<RestAPI2Domain.GTVAPICreateOrderItemPrice>();
    if (changeOrderWrapper.RecurringpriceId != null) {
      RestAPI2Domain.GTVAPICreateOrderItemPrice orderItemRecurringPrice = new RestAPI2Domain.GTVAPICreateOrderItemPrice();
      orderItemRecurringPrice.order_item_price_type = 'recurring';
      orderItemRecurringPrice.product_price = new RestAPI2Domain.GTVAPIProductPriceRef();
      orderItemRecurringPrice.product_price.product_price_type = 'recurring';
      orderItemRecurringPrice.product_price.Id = changeOrderWrapper.RecurringpriceId;
      if (changeOrderWrapper.Recurringprice != null) {
        orderItemRecurringPrice.price_ranges = new List<RestAPI2Domain.GTVAPICreateOrderItemPriceRange>();
        Map<String, list<ProductPriceRangeWrapper>> mapOfProductPriceEidVsPriceRangeList = changeOrderWrapper.mapOfProductPriceEidVsPriceRangeList;
        List<ProductPriceRangeWrapper> recurringPriceRangeList = mapOfProductPriceEidVsPriceRangeList.get(
          changeOrderWrapper.RecurringpriceId
        );
        for (ProductPriceRangeWrapper priceRange : recurringPriceRangeList) {
          RestAPI2Domain.GTVAPICreateOrderItemPriceRange itemPriceRange = new RestAPI2Domain.GTVAPICreateOrderItemPriceRange();
          itemPriceRange.price = priceRange.price;
          if (priceRange.quantityEndRange != null) {
            if (
              priceRange.quantityBeginRange < changeOrderWrapper.Quantity &&
              priceRange.quantityEndRange >= changeOrderWrapper.Quantity
            ) {
              itemPriceRange.price = changeOrderWrapper.Recurringprice;
            }
          } else {
            if (priceRange.quantityBeginRange < changeOrderWrapper.Quantity) {
              itemPriceRange.price = changeOrderWrapper.Recurringprice;
            }
          }

          itemPriceRange.quantity_begin_range = priceRange.quantityBeginRange;
          if (priceRange.quantityEndRange != null) {
            itemPriceRange.quantity_end_range = priceRange.quantityEndRange;
          }
          itemPriceRange.level = priceRange.level;
          itemPriceRange.currency_code = changeOrderWrapper.currencyType;
          orderItemRecurringPrice.price_ranges.add(itemPriceRange);
        }
      }
      orderItem.order_item_prices.add(orderItemRecurringPrice);
    }
    if (changeOrderWrapper.OneTimePriceId != null) {
      RestAPI2Domain.GTVAPICreateOrderItemPrice orderItemOneTimePrice = new RestAPI2Domain.GTVAPICreateOrderItemPrice();
      orderItemOneTimePrice.order_item_price_type = 'one-time';
      orderItemOneTimePrice.product_price = new RestAPI2Domain.GTVAPIProductPriceRef();
      orderItemOneTimePrice.product_price.product_price_type = 'one-time';
      orderItemOneTimePrice.product_price.Id = changeOrderWrapper.OneTimePriceId;
      if (changeOrderWrapper.OneTimePrice != null) {
        orderItemOneTimePrice.price_ranges = new List<RestAPI2Domain.GTVAPICreateOrderItemPriceRange>();
        Map<String, list<ProductPriceRangeWrapper>> mapOfProductPriceEidVsPriceRangeList = changeOrderWrapper.mapOfProductPriceEidVsPriceRangeList;
        List<ProductPriceRangeWrapper> oneTimePriceRangeList = mapOfProductPriceEidVsPriceRangeList.get(
          changeOrderWrapper.OneTimePriceId
        );
        for (ProductPriceRangeWrapper priceRange : oneTimePriceRangeList) {
          RestAPI2Domain.GTVAPICreateOrderItemPriceRange itemPriceRange = new RestAPI2Domain.GTVAPICreateOrderItemPriceRange();
          itemPriceRange.price = priceRange.price;
          if (priceRange.quantityEndRange != null) {
            if (
              priceRange.quantityBeginRange < changeOrderWrapper.Quantity &&
              priceRange.quantityEndRange >= changeOrderWrapper.Quantity
            ) {
              itemPriceRange.price = changeOrderWrapper.OneTimePrice;
            }
          } else {
            if (priceRange.quantityBeginRange < changeOrderWrapper.Quantity) {
              itemPriceRange.price = changeOrderWrapper.OneTimePrice;
            }
          }

          itemPriceRange.quantity_begin_range = priceRange.quantityBeginRange;
          if (priceRange.quantityEndRange != null) {
            itemPriceRange.quantity_end_range = priceRange.quantityEndRange;
          }
          itemPriceRange.level = priceRange.level;
          itemPriceRange.currency_code = changeOrderWrapper.currencyType;
          orderItemOneTimePrice.price_ranges.add(itemPriceRange);
        }
      }
      orderItem.order_item_prices.add(orderItemOneTimePrice);
    }
    if (
      changeOrderWrapper.agreementId != null &&
      changeOrderWrapper.agreementId != '' &&
      !String.isBlank(changeOrderWrapper.agreementId)
    ) {
      orderItem.order_item_agreement = new RestAPI2Domain.GTVAPICreateOrderItemAgreement();
      orderItem.order_item_agreement.agreement = new RestAPI2Domain.GTVAPIAgreementRef();
      orderItem.order_item_agreement.agreement.id = changeOrderWrapper.agreementId;
      orderItem.order_item_agreement.endAction = changeOrderWrapper.agreementEndAction;
      if (changeOrderWrapper.renewalPrice == 'Service Price') {
        orderItem.order_item_agreement.preserveServicePrice = true;
      }
      orderItem.order_item_agreement.agreement_period = Integer.valueof(
        changeOrderWrapper.agreementPeriod
      );
      if (changeOrderWrapper.overrideAgreementEndDate != null) {
        orderItem.order_item_agreement.endDate = ZConvert.getFormattedDateTimeString(
          Date.valueOf(changeOrderWrapper.overrideAgreementEndDate),
          'yyyy-MM-dd\'T\'HH:mm:ss.SSSXXX'
        );
      }
    }
    /*if(changeOrderWrapper.srIdentifierList != null && changeOrderWrapper.srIdentifierList.size() > 0){
            orderItem.service_resources = new List<RestAPI2Domain.GTVAPICreateOrAddServiceResource>();
            for(String srIdentifier: changeOrderWrapper.srIdentifierList){
                RestAPI2Domain.GTVAPICreateOrAddServiceResource createServiceResource = new RestAPI2Domain.GTVAPICreateOrAddServiceResource();
                createServiceResource.identifier = srIdentifier;
                //createServiceResource.category = new RestAPI2Domain.GTVAPIResourceCategoryRef();
                //createServiceResource.category.id = MapofProductIdVsProduct.get();
                createServiceResource.resourceType = RestAPI2Domain.GTVAPIResourceType.SERVICE;
                orderItem.service_resources.add(createServiceResource);
            }
        }*/
    changeOrderRequest.order.orderItems.add(orderItem);
    return changeOrderRequest;
  }

  public static RestAPI2Domain.GTVAPICreateServiceResource getCreateserviceResourceRequest(
    String Identifier,
    String resourceCategoryId
  ) {
    RestAPI2Domain.GTVAPICreateServiceResource createServiceResource = new RestAPI2Domain.GTVAPICreateServiceResource();
    createServiceResource.identifier = Identifier;
    createServiceResource.category = new RestAPI2Domain.GTVAPIResourceCategoryRef();
    createServiceResource.category.id = resourceCategoryId;
    createServiceResource.resourceType = RestAPI2Domain.GTVAPIResourceType.SERVICE;
    return createServiceResource;
  }

  public static RestAPI2Domain.GTVAPIChangeService getChangeCreateOrderRequest(
    OpportunityLIneItem Oli
  ) {
    RestAPI2Domain.GTVAPIChangeService changeOrderRequest = new RestAPI2Domain.GTVAPIChangeService();
    changeOrderRequest.order = new RestAPI2Domain.GTVAPICreateSalesOrder();
    changeOrderRequest.order.emailReceipt = Oli.Email_Reciept__c;
    changeOrderRequest.order.orderDate = String.valueof(Oli.ServiceDate);
    changeOrderRequest.order.orderItems = new List<RestAPI2Domain.GTVAPICreateProductOrderItem>();
    RestAPI2Domain.GTVAPICreateProductOrderItem orderItem = new RestAPI2Domain.GTVAPICreateProductOrderItem();
    orderItem.quantity = Oli.Quantity;
    orderItem.product = new RestAPI2Domain.GTVAPIProductRef();
    orderItem.product.id = Oli.ProductID__c;
    orderItem.product.productType = 'customer-subscription';
    orderItem.priceList = new RestAPI2Domain.GTVAPIPriceListRef();
    orderItem.priceList.id = Oli.priceList_Eid__c;
    orderItem.order_item_type = 'product';
    orderItem.order_item_prices = new List<RestAPI2Domain.GTVAPICreateOrderItemPrice>();
    if (Oli.RecurringProductPriceEid__c != null) {
      RestAPI2Domain.GTVAPICreateOrderItemPrice orderItemRecurringPrice = new RestAPI2Domain.GTVAPICreateOrderItemPrice();
      orderItemRecurringPrice.order_item_price_type = 'recurring';
      orderItemRecurringPrice.product_price = new RestAPI2Domain.GTVAPIProductPriceRef();
      orderItemRecurringPrice.product_price.product_price_type = 'recurring';
      orderItemRecurringPrice.product_price.Id = Oli.RecurringProductPriceEid__c;
      if (Oli.RecurringPrice__c != null) {
        orderItemRecurringPrice.price_ranges = new List<RestAPI2Domain.GTVAPICreateOrderItemPriceRange>();
        List<ProductPriceRangeWrapper> recurringPriceRangeList = (list<ProductPriceRangeWrapper>) JSON.deserialize(
          oLI.GTV_Recurring_Price_Range_Information__c,
          list<ProductPriceRangeWrapper>.class
        );
        for (ProductPriceRangeWrapper priceRange : recurringPriceRangeList) {
          RestAPI2Domain.GTVAPICreateOrderItemPriceRange itemPriceRange = new RestAPI2Domain.GTVAPICreateOrderItemPriceRange();
          itemPriceRange.price = priceRange.price;
          if (priceRange.quantityEndRange != null) {
            if (
              priceRange.quantityBeginRange < Oli.Quantity &&
              priceRange.quantityEndRange >= Oli.Quantity
            ) {
              itemPriceRange.price = Oli.RecurringPrice__c;
            }
          } else {
            if (priceRange.quantityBeginRange < Oli.Quantity) {
              itemPriceRange.price = Oli.RecurringPrice__c;
            }
          }

          itemPriceRange.quantity_begin_range = priceRange.quantityBeginRange;
          if (priceRange.quantityEndRange != null) {
            itemPriceRange.quantity_end_range = priceRange.quantityEndRange;
          }
          itemPriceRange.level = priceRange.level;
          itemPriceRange.currency_code = oli.Opportunity.account.TRACT3__Currency_Type__c;
          orderItemRecurringPrice.price_ranges.add(itemPriceRange);
        }
      }
      orderItem.order_item_prices.add(orderItemRecurringPrice);
    }
    if (Oli.OneTimeProductPriceEid__c != null) {
      RestAPI2Domain.GTVAPICreateOrderItemPrice orderItemOneTimePrice = new RestAPI2Domain.GTVAPICreateOrderItemPrice();
      orderItemOneTimePrice.order_item_price_type = 'one-time';
      orderItemOneTimePrice.product_price = new RestAPI2Domain.GTVAPIProductPriceRef();
      orderItemOneTimePrice.product_price.product_price_type = 'one-time';
      orderItemOneTimePrice.product_price.Id = Oli.OneTimeProductPriceEid__c;
      if (Oli.OneTimePrice__c != null) {
        orderItemOneTimePrice.price_ranges = new List<RestAPI2Domain.GTVAPICreateOrderItemPriceRange>();
        List<ProductPriceRangeWrapper> oneTimePriceRangeList = (list<ProductPriceRangeWrapper>) JSON.deserialize(
          oLI.GTV_OneTime_Price_Range_Information__c,
          list<ProductPriceRangeWrapper>.class
        );
        for (ProductPriceRangeWrapper priceRange : oneTimePriceRangeList) {
          RestAPI2Domain.GTVAPICreateOrderItemPriceRange itemPriceRange = new RestAPI2Domain.GTVAPICreateOrderItemPriceRange();
          itemPriceRange.price = priceRange.price;
          if (priceRange.quantityEndRange != null) {
            if (
              priceRange.quantityBeginRange < Oli.Quantity &&
              priceRange.quantityEndRange >= Oli.Quantity
            ) {
              itemPriceRange.price = Oli.OneTimePrice__c;
            }
          } else {
            if (priceRange.quantityBeginRange < Oli.Quantity) {
              itemPriceRange.price = Oli.OneTimePrice__c;
            }
          }

          itemPriceRange.quantity_begin_range = priceRange.quantityBeginRange;
          if (priceRange.quantityEndRange != null) {
            itemPriceRange.quantity_end_range = priceRange.quantityEndRange;
          }
          itemPriceRange.level = priceRange.level;
          itemPriceRange.currency_code = oli.Opportunity.account.TRACT3__Currency_Type__c;
          orderItemOneTimePrice.price_ranges.add(itemPriceRange);
        }
      }
      orderItem.order_item_prices.add(orderItemOneTimePrice);
    }
    if (
      oli.Applied_Agreement_Eid__c != null &&
      oli.Applied_Agreement_Eid__c != '' &&
      !String.isBlank(oli.Applied_Agreement_Eid__c)
    ) {
      orderItem.order_item_agreement = new RestAPI2Domain.GTVAPICreateOrderItemAgreement();
      orderItem.order_item_agreement.agreement = new RestAPI2Domain.GTVAPIAgreementRef();
      orderItem.order_item_agreement.agreement.id = oli.Applied_Agreement_Eid__c;
      orderItem.order_item_agreement.endAction = oli.agreementEndAction__c;
      if (oli.GTV_Renewal_Price__c == 'Service Price') {
        orderItem.order_item_agreement.preserveServicePrice = true;
      }
      orderItem.order_item_agreement.agreement_period = Integer.valueOf(
        oli.Agreement_Period__c
      );
      if (oli.overrideAgreementEndDate__c != null) {
        orderItem.order_item_agreement.endDate = ZConvert.getFormattedDateTimeString(
          oli.overrideAgreementEndDate__c,
          'yyyy-MM-dd\'T\'HH:mm:ss.SSSXXX'
        );
      }
    }

    changeOrderRequest.order.orderItems.add(orderItem);
    return changeOrderRequest;
  }

  public static RestAPI2Domain.GTVAPICreateBillingAccount getBillingAccountCreationRequest(
    String salesforceAccountId,
    GTVAccount gtvAccount
  ) {
    RestAPI2Domain.GTVAPICreateBillingAccount createBillingAccountObj = new RestAPI2Domain.GTVAPICreateBillingAccount();
    RestAPI2Domain.GTVAPICreateParty responsiblePartyObj = new RestAPI2Domain.GTVAPICreateParty();
    RestAPI2Domain.GTVAPICreateAddress billingPostalAddress;
    RestAPI2Domain.GTVAPICreateAddress shippingPostalAddress;
    RestAPI2Domain.GTVAPICreateAddress emailAddress;
    RestAPI2Domain.GTVAPICreateAddress telecomAddress;
    RestAPI2Domain.GTVAPICreateBillingAccountCustomFi billingAccountCustomFieldObj;
    RestAPI2Domain.GTVAPIBillingAccountCategoryRef billingAccountCategoryObj = new RestAPI2Domain.GTVAPIBillingAccountCategoryRef();
    RestAPI2Domain.GTVAPIPaymentTermRef paymentTermObj = new RestAPI2Domain.GTVAPIPaymentTermRef();
    RestAPI2Domain.GTVAPIBillCycleRef billCycleObj = new RestAPI2Domain.GTVAPIBillCycleRef();
    list<TRACT_Setup__c> tractList = [
      SELECT Id, Mapped_Custom_Field_Id__c, Active__c
      FROM TRACT_Setup__c
      WHERE Active__c = TRUE
      LIMIT 1
    ];
    if (tractList.size() > 0) {
      // setting the responsible party
      createBillingAccountObj.responsible_party = responsiblePartyObj;
      if (gtvAccount.accountName != null) {
        responsiblePartyObj.party_type = RestAPI2Domain.GTVAPIPartyType.organization;
        responsiblePartyObj.organization_name = zConvert.ToString(
          gtvAccount.accountName
        );
      } else {
        throw new MyException('Please provide the account name.');
      }

      if (gtvAccount.billCycleName != null) {
        List<TRACT_Bill_Cycle__c> billCycleList = [
          SELECT
            Id,
            Eid__c,
            Name,
            Bill_Cycle_Type__c,
            TRACT_Bill_Cycle_Currency_Type__c
          FROM TRACT_Bill_Cycle__c
          WHERE Name = :gtvAccount.billCycleName
          LIMIT 1
        ];
        if (billCycleList.size() > 0) {
          billCycleObj.id = billCycleList[0].Eid__c;
          billCycleObj.bill_cycle_type = billCycleList[0].Bill_Cycle_Type__c;
          createBillingAccountObj.bill_cycle = billCycleObj;
        } else {
          throw new MyException('Please provide the correct bill cycle.');
        }
      } else {
        throw new MyException('Please provide the bill cycle.');
      }
      if (gtvAccount.billingAccountCategoryName != null) {
        List<TRACTBillingAccountCategory__c> billingAccountCategoryList = [
          SELECT Id, Eid__c, Name
          FROM TRACTBillingAccountCategory__c
          WHERE name = :gtvAccount.billingAccountCategoryName
          LIMIT 1
        ];
        if (billingAccountCategoryList.size() > 0) {
          billingAccountCategoryObj.id = billingAccountCategoryList[0].Eid__c;
          createBillingAccountObj.billing_account_category = billingAccountCategoryObj;
        } else {
          throw new MyException(
            'Please provide the correct billing account category.'
          );
        }
      } else {
        throw new MyException('Please provide the billing account category.');
      }
      Map<String, String> mapOfPaymentTermNameVsPaymentTermEid = new Map<String, String>();
      for (Payment_Term__c paymentTerm : [
        SELECT Name, Eid__c
        FROM Payment_Term__c
        LIMIT 1000
      ]) {
        mapOfPaymentTermNameVsPaymentTermEid.put(
          paymentTerm.Name,
          paymentTerm.Eid__c
        );
      }
      if (
        gtvAccount.paymentTermName != null &&
        mapOfPaymentTermNameVsPaymentTermEid.containsKey(
          gtvAccount.paymentTermName
        )
      ) {
        paymentTermObj.Id = mapOfPaymentTermNameVsPaymentTermEid.get(
          gtvAccount.paymentTermName
        );
        createBillingAccountObj.payment_term = paymentTermObj;
      } else if (mapOfPaymentTermNameVsPaymentTermEid.containsKey('Net 30')) {
        paymentTermObj.Id = mapOfPaymentTermNameVsPaymentTermEid.get('Net 30');
        createBillingAccountObj.payment_term = paymentTermObj;
      } else {
        throw new MyException('Please provide the payment term.');
      }
      if (string.isNotBlank(gtvAccount.email) && gtvAccount.email != 'NA') {
        emailAddress = new RestAPI2Domain.GTVAPICreateAddress();
        emailAddress.email = gtvAccount.email;
        emailAddress.purpose = RestAPI2Domain.AddresssPurpose.PRIMARY;
        emailAddress.address_type = RestAPI2Domain.GTVAPIAddressType.email;
        responsiblePartyObj.addresses.add(emailAddress);
      }
      if (gtvAccount.currencyType != null) {
        createBillingAccountObj.currencyCode = gtvAccount.currencyType;
      } else {
        throw new MyException('Please provide the currency.');
      }
      if (!TractSFDC_Util.isNull(gtvAccount.billingStreet)) {
        billingPostalAddress = new RestAPI2Domain.GTVAPICreateAddress();
        if (!TractSFDC_Util.isNull(gtvAccount.billingCountry)) {
          billingPostalAddress.country = TractSFDC_Util.getCountry(
            gtvAccount.billingCountry
          );
        } else {
          throw new MyException('Please provide the correct Billing Country.');
        }
        if (!TractSFDC_Util.isNull(gtvAccount.billingCity)) {
          billingPostalAddress.city = gtvAccount.billingCity;
        }
        if (!TractSFDC_Util.isNull(gtvAccount.billingState)) {
          billingPostalAddress.region_or_state = TractSFDC_Util.getState(
            gtvAccount.billingState
          );
        } else {
          throw new MyException('Please provide the correct Billing State.');
        }
        if (!TractSFDC_Util.isNull(gtvAccount.billingPostalCode)) {
          billingPostalAddress.postal_code = gtvAccount.billingPostalCode;
        }
        billingPostalAddress.line1 = gtvAccount.billingStreet;
        billingPostalAddress.line2 = '';
        billingPostalAddress.purpose = RestAPI2Domain.AddresssPurpose.BILLING;
        billingPostalAddress.address_type = RestAPI2Domain.GTVAPIAddressType.postal;
        responsiblePartyObj.addresses.add(billingPostalAddress);
      }
      if (!TractSFDC_Util.isNull(gtvAccount.shippingStreet)) {
        shippingPostalAddress = new RestAPI2Domain.GTVAPICreateAddress();
        if (!TractSFDC_Util.isNull(gtvAccount.shippingCountry)) {
          shippingPostalAddress.country = TractSFDC_Util.getCountry(
            gtvAccount.shippingCountry
          );
        } else {
          throw new MyException('Please provide the correct Shipping Country.');
        }
        if (!TractSFDC_Util.isNull(gtvAccount.shippingCity)) {
          shippingPostalAddress.city = gtvAccount.shippingCity;
        }
        if (!TractSFDC_Util.isNull(gtvAccount.shippingState)) {
          shippingPostalAddress.region_or_state = TractSFDC_Util.getState(
            gtvAccount.shippingState
          );
        } else {
          throw new MyException('Please provide the correct Shipping State.');
        }
        if (!TractSFDC_Util.isNull(gtvAccount.shippingPostalCode)) {
          shippingPostalAddress.postal_code = gtvAccount.shippingPostalCode;
        }
        shippingPostalAddress.line1 = gtvAccount.shippingStreet;
        shippingPostalAddress.line2 = '';
        shippingPostalAddress.purpose = RestAPI2Domain.AddresssPurpose.SHIPPING;
        shippingPostalAddress.address_type = RestAPI2Domain.GTVAPIAddressType.postal;
        responsiblePartyObj.addresses.add(shippingPostalAddress);
      }
      if (gtvAccount.taxExempt != null) {
        createBillingAccountObj.tax_exempt = gtvAccount.taxExempt;
      }
      if (gtvAccount.billType != null) {
        createBillingAccountObj.bill_type = gtvAccount.billType;
      }

      if (null != gtvAccount.createDate) {
        createBillingAccountObj.start_date = ZConvert.getFormattedDateTimeString(
          gtvAccount.createDate,
          'yyyy-MM-dd\'T\'HH:mm:ss.SSSXXX'
        );
      }
      if (string.isNotBlank(gtvAccount.phone) && gtvAccount.phone != 'NA') {
        telecomAddress = new RestAPI2Domain.GTVAPICreateAddress();
        string strPhone = zConvert.ToString(gtvAccount.phone);
        if (strPhone != null && strPhone != '' && !strPhone.IsNumeric()) {
          strPhone = strPhone.replaceAll('[^0-9]', '');
        }
        telecomAddress.purpose = RestAPI2Domain.AddresssPurpose.OFFICE;
        telecomAddress.r_number = strphone;
        telecomAddress.address_type = RestAPI2Domain.GTVAPIAddressType.telecom;
        responsiblePartyObj.addresses.add(telecomAddress);
      }
      if (tractList[0].Mapped_Custom_Field_Id__c == 'External Account Number') {
        createBillingAccountObj.external_account_num = zConvert.ToString(
          salesforceAccountId
        );
      } else {
        createBillingAccountObj.external_account_num = TractSFDC_Util.getRandomNumberString();
        billingAccountCustomFieldObj = new RestAPI2Domain.GTVAPICreateBillingAccountCustomFi();
        billingAccountCustomFieldObj.custom_field_value_type = 'billing-account';
        billingAccountCustomFieldObj.value = zConvert.ToString(
          salesforceAccountId
        );
        RestAPI2Domain.GTVAPICustomFieldRef customFieldObj = new RestAPI2Domain.GTVAPICustomFieldRef();
        customFieldObj.id = tractList[0].Mapped_Custom_Field_Id__c;
        customFieldObj.custom_field_type = 'billing-account';
        billingAccountCustomFieldObj.custom_field = customFieldObj;
        createBillingAccountObj.custom_field_values = new List<RestAPI2Domain.GTVAPICreateBillingAccountCustomFi>();
        createBillingAccountObj.custom_field_values.add(
          billingAccountCustomFieldObj
        );
      }
    } else {
      throw new MyException(
        'Please ask your administrator to setup the TRACT Configuration.'
      );
    }
    return createBillingAccountObj;
  }

  public static RestAPI2Domain.GTVAPICreateSalesOrder getSalesOrderCreationRequest(
    String salesforceAccountId,
    GTVOrder gtvOrder
  ) {
    RestAPI2Domain.GTVAPICreateSalesOrder salesOrderRequest = new RestAPI2Domain.GTVAPICreateSalesOrder();
    if (gtvOrder.orderStatus != null) {
      salesOrderRequest.initialStatus = RestAPI2Domain.GTVAPICreateSalesOrderStatus.valueOf(
        gtvOrder.orderStatus
      );
    }
    if (gtvOrder.orderPlacedDate != null) {
      salesOrderRequest.orderDate = ZConvert.ToString(
        gtvOrder.orderPlacedDate,
        'yyyy-MM-dd\'T\'HH:mm:ss.SSSXXX'
      );
    }
    salesOrderRequest.emailReceipt = gtvOrder.emailReceipt;
    salesOrderRequest.purchaseOrderNumber = gtvOrder.purchaseOrderNumber;
    salesOrderRequest.note = gtvOrder.note;
    if (
      gtvOrder.orderCustomFieldValues != null &&
      gtvOrder.orderCustomFieldValues.size() > 0
    ) {
      salesOrderRequest.customFieldValues = new List<RestAPI2Domain.GTVAPICreateOrderCustomFieldValue>();
      RestAPI2Domain.GTVAPICreateOrderCustomFieldValue createOrderCustomFieldValue;
      for (
        GTVOrder.GTVCustomFieldValue orderCustomFieldValue : gtvOrder.orderCustomFieldValues
      ) {
        createOrderCustomFieldValue = new RestAPI2Domain.GTVAPICreateOrderCustomFieldValue();
        createOrderCustomFieldValue.custom_field = new RestAPI2Domain.GTVAPIOrderCustomFieldRef();
        createOrderCustomFieldValue.custom_field.id = orderCustomFieldValue.id;
        createOrderCustomFieldValue.custom_field.custom_field_type = 'order';
        createOrderCustomFieldValue.custom_field_value_type = 'order';
        createOrderCustomFieldValue.value = orderCustomFieldValue.value;
        salesOrderRequest.customFieldValues.add(createOrderCustomFieldValue);
      }
    }
    if (gtvOrder.orderItems != null && gtvOrder.orderItems.size() > 0) {
      salesOrderRequest.orderItems = new List<RestAPI2Domain.GTVAPICreateProductOrderItem>();
      for (GTVOrder.GTVOrderItem orderItem : gtvOrder.orderItems) {
        salesOrderRequest.orderItems.add(getOrderItem(orderItem));
      }
    }
    return salesOrderRequest;
  }

  public static RestAPI2Domain.GTVAPICreateProductOrderItem getOrderItem(
    GTVOrder.GTVOrderItem orderItem
  ) {
    RestAPI2Domain.GTVAPICreateProductOrderItem createOrderItem = new RestAPI2Domain.GTVAPICreateProductOrderItem();
    createOrderItem.order_item_type = 'product';
    createOrderItem.quantity = orderItem.quantity;
    createOrderItem.sequence = orderItem.sequence;
    createOrderItem.overrideTrialDays = orderItem.overrideTrialDays;
    createOrderItem.description = orderItem.description;
    if (orderItem.requestedEffectiveDate != null) {
      createOrderItem.requestedEffectiveDate = ZConvert.ToString(
        orderItem.requestedEffectiveDate,
        'yyyy-MM-dd\'T\'HH:mm:ss.SSSXXX'
      );
    }
    if (orderItem.product != null) {
      createOrderItem.product = new RestAPI2Domain.GTVAPIProductRef();
      createOrderItem.product.id = orderItem.product.id;
      createOrderItem.product.name = orderItem.product.name;
      createOrderItem.product.productType = orderItem.product.productType;
    }
    if (orderItem.priceListId != null) {
      createOrderItem.priceList = new RestAPI2Domain.GTVAPIPriceListRef();
      createOrderItem.priceList.id = orderItem.priceListId;
    }
    if (orderItem.orderItemDiscount != null) {
      createOrderItem.orderItemDiscount = new RestAPI2Domain.GTVAPICreateOrderItemDiscount();
      createOrderItem.orderItemDiscount.discountResource = new RestAPI2Domain.GTVAPIDiscountResourceRef();
      createOrderItem.orderItemDiscount.discountResource.id = orderItem.orderItemDiscount.id;
      createOrderItem.orderItemDiscount.discountResource.identifier = orderItem.orderItemDiscount.identifier;
      createOrderItem.orderItemDiscount.discountResource.resource_type = 'discount';
    }
    if (
      orderItem.orderItemAgreement != null &&
      orderItem.orderItemAgreement.agreementId != null &&
      orderItem.orderItemAgreement.endAction != null
    ) {
      createOrderItem.order_item_agreement = new RestAPI2Domain.GTVAPICreateOrderItemAgreement();
      createOrderItem.order_item_agreement.agreement = new RestAPI2Domain.GTVAPIAgreementRef();
      createOrderItem.order_item_agreement.agreement.id = orderItem.orderItemAgreement.agreementId;
      if (orderItem.orderItemAgreement.endDate != null) {
        createOrderItem.order_item_agreement.endDate = ZConvert.ToString(
          orderItem.orderItemAgreement.endDate,
          'yyyy-MM-dd\'T\'HH:mm:ss.SSSXXX'
        );
      }
      createOrderItem.order_item_agreement.agreement_period = orderItem.orderItemAgreement.agreementPeriod;
      createOrderItem.order_item_agreement.preserveServicePrice = orderItem.orderItemAgreement.preserveServicePrice;
      if (
        orderItem.orderItemAgreement.nextAgreementId != null &&
        orderItem.orderItemAgreement.nextEndAction != null
      ) {
        createOrderItem.order_item_agreement.nextAgreement = new RestAPI2Domain.GTVAPIAgreementRef();
        createOrderItem.order_item_agreement.nextAgreement.id = orderItem.orderItemAgreement.nextAgreementId;
        createOrderItem.order_item_agreement.nextEndAction = orderItem.orderItemAgreement.nextEndAction;
        createOrderItem.order_item_agreement.nextPreserveServicePrice = orderItem.orderItemAgreement.nextPreserveServicePrice;
      }
    }

    if (
      orderItem.orderItemPrices != null &&
      orderItem.orderItemPrices.size() > 0
    ) {
      createOrderItem.order_item_prices = new List<RestAPI2Domain.GTVAPICreateOrderItemPrice>();
      RestAPI2Domain.GTVAPICreateOrderItemPrice createOrderItemPrice;
      for (GTVOrder.GTVPrice orderItemPrice : orderItem.orderItemPrices) {
        createOrderItemPrice = new RestAPI2Domain.GTVAPICreateOrderItemPrice();
        createOrderItemPrice.order_item_price_type = orderItemPrice.priceType;
        createOrderItemPrice.product_price = new RestAPI2Domain.GTVAPIProductPriceRef();
        createOrderItemPrice.product_price.product_price_type = orderItemPrice.priceType;
        createOrderItemPrice.product_price.id = orderItemPrice.id;
        if (
          orderItemPrice.priceRanges != null &&
          orderItemPrice.priceRanges.size() > 0
        ) {
          createOrderItemPrice.price_ranges = new List<RestAPI2Domain.GTVAPICreateOrderItemPriceRange>();
          RestAPI2Domain.GTVAPICreateOrderItemPriceRange createOrderItemPriceRange;
          for (
            GTVOrder.GTVPriceRange orderItemPriceRange : orderItemPrice.priceRanges
          ) {
            createOrderItemPriceRange = new RestAPI2Domain.GTVAPICreateOrderItemPriceRange();
            createOrderItemPriceRange.price = orderItemPriceRange.price;
            createOrderItemPriceRange.currency_code = orderItemPriceRange.currencyCode;
            createOrderItemPriceRange.quantity_begin_range = orderItemPriceRange.quantityBeginRange;
            createOrderItemPriceRange.quantity_end_range = orderItemPriceRange.quantityEndRange;
            createOrderItemPriceRange.level = orderItemPriceRange.level;
            createOrderItemPrice.price_ranges.add(createOrderItemPriceRange);
          }
        }
        if (
          orderItemPrice.scheduledCharges != null &&
          orderItemPrice.scheduledCharges.size() > 0
        ) {
          createOrderItemPrice.scheduled_charges = new List<RestAPI2Domain.GTVAPICreateOneTimePriceCharge>();
          RestAPI2Domain.GTVAPICreateOneTimePriceCharge createOrderItempriceCharge;
          for (
            GTVOrder.GTVPriceCharge orderItemPriceCharge : orderItemPrice.scheduledCharges
          ) {
            createOrderItempriceCharge = new RestAPI2Domain.GTVAPICreateOneTimePriceCharge();
            createOrderItempriceCharge.priceChargeType = 'one-time';
            createOrderItempriceCharge.description = orderItemPriceCharge.description;
            createOrderItempriceCharge.amount = orderItemPriceCharge.amount;
            createOrderItempriceCharge.chargeDate = orderItemPriceCharge.chargeDate;
            createOrderItemPrice.scheduled_charges.add(
              createOrderItempriceCharge
            );
          }
        }
        if (
          orderItemPrice.usageRules != null &&
          orderItemPrice.usageRules.size() > 0
        ) {
          createOrderItemPrice.usage_rules = getOrderItemProductUsageList(
            orderItemPrice.usageRules
          );
        }
        createOrderItem.order_item_prices.add(createOrderItemPrice);
      }
    }

    if (
      orderItem.serviceResources != null &&
      orderItem.serviceResources.size() > 0
    ) {
      createOrderItem.service_resources = new List<RestAPI2Domain.GTVAPICreateOrAddServiceResource>();
      RestAPI2Domain.GTVAPICreateOrAddServiceResource createOrderItemServiceResource;
      for (
        GTVOrder.GTVServiceResource orderItemServiceResource : orderItem.serviceResources
      ) {
        createOrderItemServiceResource = new RestAPI2Domain.GTVAPICreateOrAddServiceResource();
        createOrderItemServiceResource.id = orderItemServiceResource.id;
        createOrderItemServiceResource.identifier = orderItemServiceResource.identifier;
        createOrderItemServiceResource.resourceType = RestAPI2Domain.GTVAPIResourceType.SERVICE;
        if (orderItemServiceResource.resourceCategoryId != null) {
          createOrderItemServiceResource.category = new RestAPI2Domain.GTVAPIResourceCategoryRef();
          createOrderItemServiceResource.category.id = orderItemServiceResource.resourceCategoryId;
        }
        createOrderItem.service_resources.add(createOrderItemServiceResource);
      }
    }

    if (
      orderItem.orderItemCustomFieldValues != null &&
      orderItem.orderItemCustomFieldValues.size() > 0
    ) {
      createOrderItem.customFieldValues = new List<RestAPI2Domain.GTVAPICreateOrderItemCustomFieldValue>();
      RestAPI2Domain.GTVAPICreateOrderItemCustomFieldValue createOrderItemCustomFieldValue;
      for (
        GTVOrder.GTVCustomFieldValue orderItemCustomFieldValue : orderItem.orderItemCustomFieldValues
      ) {
        createOrderItemCustomFieldValue = new RestAPI2Domain.GTVAPICreateOrderItemCustomFieldValue();
        createOrderItemCustomFieldValue.customField = new RestAPI2Domain.GTVAPIServiceCustomFieldRef();
        createOrderItemCustomFieldValue.customField.id = orderItemCustomFieldValue.id;
        createOrderItemCustomFieldValue.customField.custom_field_type = 'service';
        createOrderItemCustomFieldValue.custom_field_value_type = 'order-item';
        createOrderItemCustomFieldValue.value = orderItemCustomFieldValue.value;
        createOrderItem.customFieldValues.add(createOrderItemCustomFieldValue);
      }
    }
    return createOrderItem;
  }

  public static List<RestAPI2Domain.GTVAPICreateUsageRuleTemplate> getOrderItemProductUsageList(
    List<GTVOrder.GTVUsageRule> orderItemUsageRuleList
  ) {
    List<RestAPI2Domain.GTVAPICreateUsageRuleTemplate> createOrderItemProductUsageRulesList = new List<RestAPI2Domain.GTVAPICreateUsageRuleTemplate>();
    RestAPI2Domain.GTVAPICreateUsageRuleTemplate createOrderItemUsageRule;
    for (GTVOrder.GTVUsageRule orderItemUsageRule : orderItemUsageRuleList) {
      createOrderItemUsageRule = new RestAPI2Domain.GTVAPICreateUsageRuleTemplate();
      createOrderItemUsageRule.usageRuleType = 'order-item';
      createOrderItemUsageRule.name = orderItemUsageRule.name;
      createOrderItemUsageRule.ruleType = RestAPI2Domain.GTVAPIRuleType.valueOf(
        orderItemUsageRule.ruleType
      );
      createOrderItemUsageRule.status = RestAPI2Domain.GTVAPIServiceUsageRuleStatus.valueOf(
        orderItemUsageRule.status
      );
      createOrderItemUsageRule.allowanceAmount = orderItemUsageRule.allowanceAmount;
      createOrderItemUsageRule.allowanceUom = RestAPI2Domain.GTVAPIUsageDurationUom.valueOf(
        orderItemUsageRule.allowanceUom
      );
      createOrderItemUsageRule.proratedOnOrder = orderItemUsageRule.proratedOnOrder;
      createOrderItemUsageRule.proratedOnCancel = orderItemUsageRule.proratedOnCancel;
      createOrderItemUsageRule.rollOverType = RestAPI2Domain.GTVAPIRollOverType.valueOf(
        orderItemUsageRule.rollOverType
      );
      createOrderItemUsageRule.allowanceType = RestAPI2Domain.GTVAPIAllowanceType.valueOf(
        orderItemUsageRule.allowanceType
      );
      if (orderItemUsageRule.spec != null) {
        createOrderItemUsageRule.spec = new RestAPI2Domain.GTVAPICreateUsageRuleSpecification();
        createOrderItemUsageRule.spec.usageRuleSpecificationType = orderItemUsageRule.spec.specificationType;
        createOrderItemUsageRule.spec.operator = orderItemUsageRule.spec.operator;
        createOrderItemUsageRule.spec.field_name = orderItemUsageRule.spec.fieldName;
        createOrderItemUsageRule.spec.field_value = orderItemUsageRule.spec.fieldValue;
      }
      if (orderItemUsageRule.usageRate != null) {
        createOrderItemUsageRule.usageRate = new RestAPI2Domain.GTVAPICreateUsageRate();
        createOrderItemUsageRule.usageRate.rateType = orderItemUsageRule.usageRate.rateType;
        createOrderItemUsageRule.usageRate.uom = orderItemUsageRule.usageRate.uom;
        createOrderItemUsageRule.usageRate.uom = orderItemUsageRule.usageRate.uom;
        createOrderItemUsageRule.usageRate.usage_field_name = orderItemUsageRule.usageRate.usageFieldName;
        if (orderItemUsageRule.usageRate.rateTableId != null) {
          createOrderItemUsageRule.usageRate.rate_table = new RestAPI2Domain.GTVAPIRateTable();
          createOrderItemUsageRule.usageRate.rate_table.id = orderItemUsageRule.usageRate.rateTableId;
        }
        if (orderItemUsageRule.usageRate.usageChargeCategoryId != null) {
          createOrderItemUsageRule.usageRate.chargeCategory = new RestAPI2Domain.GTVAPIUsageChargeCategoryRef();
          createOrderItemUsageRule.usageRate.chargeCategory.chargeCategoryType = 'usage-charge';
          createOrderItemUsageRule.usageRate.chargeCategory.id = orderItemUsageRule.usageRate.usageChargeCategoryId;
        }
      }
      createOrderItemProductUsageRulesList.add(createOrderItemUsageRule);
    }
    return createOrderItemProductUsageRulesList;
  }
}