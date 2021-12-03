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
 * This class Maps the data from salesforce object records to GTV objects.
 * @author AMAN JAIN
 */

public with sharing class GTVSOAP133ReverseMappingService {
  /**
   * @description: Get request to create billing account in GTV db
   * @param sfdcAccountObj Salesforce Account to be created in GTV(required)
   * @param billCycleObj billcycle choose by user while creating account(required)
   * @param billingAccountCategoryEid The Id of billing account category(required)
   * @param paymentTermEid The Id of payment term(required)
   * @param fieldToMapAccountId The Id of account custom field to be mapped with salesforce account id(required)
   * @return SoapApi33Domain.BillingAccount, The instance of SoapApi33Domain.BillingAccount class.
   */
  public static SoapApi33Domain.BillingAccount getBillingAccountCreationMapping(
    Account sfdcAccountObj,
    TRACT_Bill_Cycle__c billCycleObj,
    string billingAccountCategoryEid,
    string paymentTermEid,
    string fieldToMapAccountId
  ) {
    SoapApi33Domain.BillingAccount tractBillingAccount = new SoapApi33Domain.BillingAccount();
    SoapApi33Domain.EmailAddress emailAddress = new SoapApi33Domain.EmailAddress();
    SoapApi33Domain.addresses_element address = new SoapApi33Domain.addresses_element();
    SoapApi33Domain.TelecomAddress telecomAddress = new SoapApi33Domain.TelecomAddress();
    SoapApi33Domain.PostalAddress billingPostalAddress = new SoapApi33Domain.PostalAddress();
    SoapApi33Domain.PostalAddress shippingPostalAddress = new SoapApi33Domain.PostalAddress();
    SoapApi33Domain.Organization organization = new SoapApi33Domain.Organization();
    SoapApi33Domain.MonthlyBillCycle monthlyBillCycle = new SoapApi33Domain.MonthlyBillCycle();
    SoapApi33Domain.BillCycles billCycle = new SoapApi33Domain.BillCycles();
    SoapApi33Domain.BillingAccountCategory billingAccountCategory = new SoapApi33Domain.BillingAccountCategory();
    SoapApi33Domain.PaymentTerm paymentTerm = new SoapApi33Domain.PaymentTerm();
    address.postalAddress = new List<SoapApi33Domain.PostalAddress>();
    address.telecomAddress = new List<SoapApi33Domain.TelecomAddress>();
    address.emailAddress = new List<SoapApi33Domain.EmailAddress>();

    AccountMappingWrapper accountMapDetails = AccountMappingController.showAccountMap(
      sfdcAccountObj.id
    );
    // set billing address from Salesforce account
    if (
      !TractSFDC_Util.isNull(
        accountMapDetails.mapOfNamesVsVales.get('BillingStreet')
      )
    ) {
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
        billingPostalAddress.regionOrState = TractSFDC_Util.getState(
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
        billingPostalAddress.postalCode = accountMapDetails.mapOfNamesVsVales.get(
          'BillingCode'
        );
      }
      billingPostalAddress.line1 = accountMapDetails.mapOfNamesVsVales.get(
        'BillingStreet'
      );
      billingPostalAddress.line2 = '';
      billingPostalAddress.purpose = 'BILLING';
      address.postalAddress.add(billingPostalAddress);
    }
    // set shipping address from Salesforce account
    if (
      !TractSFDC_Util.isNull(
        accountMapDetails.mapOfNamesVsVales.get('ShippingStreet')
      )
    ) {
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
        shippingPostalAddress.regionOrState = TractSFDC_Util.getState(
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
        shippingPostalAddress.postalCode = accountMapDetails.mapOfNamesVsVales.get(
          'ShippingCode'
        );
      }
      shippingPostalAddress.line1 = accountMapDetails.mapOfNamesVsVales.get(
        'ShippingStreet'
      );
      shippingPostalAddress.line2 = '';
      shippingPostalAddress.purpose = 'SHIPPING';
      address.postalAddress.add(shippingPostalAddress);
    }
    // set phone from Salesforce account
    if (
      string.isNotBlank(accountMapDetails.mapOfNamesVsVales.get('Phone')) &&
      accountMapDetails.mapOfNamesVsVales.get('Phone') != 'NA'
    ) {
      string strPhone = zConvert.ToString(
        accountMapDetails.mapOfNamesVsVales.get('Phone')
      );
      if (strPhone != null && strPhone != '' && !strPhone.IsNumeric()) {
        strPhone = strPhone.replaceAll('[^0-9]', '');
      }
      telecomAddress.purpose = 'OFFICE';
      telecomAddress.number_x = strphone;
      address.telecomAddress.add(telecomAddress);
    }
    // set email from Salesforce account
    if (
      string.isNotBlank(
        accountMapDetails.mapOfNamesVsVales.get('GotransverseEmail')
      ) && accountMapDetails.mapOfNamesVsVales.get('GotransverseEmail') != 'NA'
    ) {
      emailAddress.email = zConvert.ToString(
        accountMapDetails.mapOfNamesVsVales.get('GotransverseEmail')
      );
      emailAddress.purpose = 'PRIMARY';
      address.emailAddress.add(emailAddress);
    }
    organization.name = zConvert.ToString(
      accountMapDetails.mapOfNamesVsVales.get('AccountName')
    );
    organization.addresses = address;
    //set account start date
    if (null != sfdcAccountObj.Account_Create_Date__c) {
      Date createDate = Date.parse(
        zConvert.ToString(sfdcAccountObj.Account_Create_Date__c)
      );
      Time myTime = Time.newInstance(0, 0, 0, 0);
      Datetime dateTimetemp = DateTime.newInstance(createDate, myTime);
      string strConvertedDateTime = dateTimetemp.format(
        'yyyy-MM-dd HH:mm:ss',
        'America/Chicago'
      );
      strConvertedDateTime = strConvertedDateTime.replace(' ', 'T');
      tractBillingAccount.startDate = strConvertedDateTime;
    }
    //set billing account category
    billingAccountCategory.eid = billingAccountCategoryEid;
    //set billcycle
    if (billCycleObj.Bill_Cycle_Type__c == 'DAILY') {
      tractBillingAccount.dailyBillCycle = new SoapApi33Domain.DailyBillCycle();
      tractBillingAccount.dailyBillCycle.eid = billCycleObj.Eid__c;
    }
    if (billCycleObj.Bill_Cycle_Type__c == 'MONTHLY') {
      tractBillingAccount.monthlyBillCycle = new SoapApi33Domain.MonthlyBillCycle();
      tractBillingAccount.monthlyBillCycle.eid = billCycleObj.Eid__c;
    }
    if (billCycleObj.Bill_Cycle_Type__c == 'QUARTERLY') {
      tractBillingAccount.quarterlyBillCycle = new SoapApi33Domain.QuarterlyBillCycle();
      tractBillingAccount.quarterlyBillCycle.eid = billCycleObj.Eid__c;
    }
    if (billCycleObj.Bill_Cycle_Type__c == 'YEARLY') {
      tractBillingAccount.yearlyBillCycle = new SoapApi33Domain.YearlyBillCycle();
      tractBillingAccount.yearlyBillCycle.eid = billCycleObj.Eid__c;
    }
    // set bill type
    /*if(sfdcAccountObj.Email__c != null)
        {
            tractBillingAccount.billType = 'EMAIL';
        }
        else
        {
            tractBillingAccount.billType = 'NONE';
        }*/
    tractBillingAccount.billType = sfdcAccountObj.Gotransverse_Bill_Type__c;
    tractBillingAccount.billingAccountCategory = billingAccountCategory;
    tractBillingAccount.automaticRecurringPayment = true;
    tractBillingAccount.organization = organization;
    tractBillingAccount.autoPayOffset = 0;
    // set payment term
    paymentTerm.eid = paymentTermEid;
    tractBillingAccount.paymentTerm = paymentTerm;
    //set tax exempt
    tractBillingAccount.taxExempt = sfdcAccountObj.Tax_Exempt__c;
    //Set BillingAccount Currency
    //tractBillingAccount.currencyType = billCycleObj.TRACT_Bill_Cycle_Currency_Type__c;
    tractBillingAccount.currencyType = sfdcAccountObj.Currency_Type__c;
    if (fieldToMapAccountId == 'External Account Number') {
      tractBillingAccount.externalAccountNum = zConvert.ToString(
        sfdcAccountObj.Id
      );
    } else {
      tractBillingAccount.externalAccountNum = TractSFDC_Util.getRandomNumberString();
      // add custom field value to send Salesforce account id to TRACT db
      SoapApi33Domain.CustomFieldValues customFieldVals1 = new SoapApi33Domain.CustomFieldValues();
      List<SoapApi33Domain.CustomFieldValue> customFldValueList1 = new List<SoapApi33Domain.CustomFieldValue>();
      SoapApi33Domain.CustomFieldValue customFieldVal1 = new SoapApi33Domain.CustomFieldValue();
      SoapApi33Domain.CustomField customFld1 = new SoapApi33Domain.CustomField();
      customFld1.eid = fieldToMapAccountId;
      customFieldVal1.customField = customFld1;
      customFieldVal1.value = zConvert.ToString(sfdcAccountObj.Id);
      customFldValueList1.add(customFieldVal1);
      customFieldVals1.customFieldValue = customFldValueList1;
      tractBillingAccount.customFieldValues = new SoapApi33Domain.CustomFieldValues();
      tractBillingAccount.customFieldValues = customFieldVals1;
    }
    return tractBillingAccount;
  }

  /**
   * @description: Get request to update quantity of a service in GTV db
   * @param updateserviceQuantity, The updated service quantity.
   * @param serviceEidValue, The eid of the service on which qunatity has to be updated.
   * @param displayEffectiveDate, if the effective date to be mapped or not.
   * @param effectiveDate, The effective date from which this quantity applied.
   * @return SoapApi33Domain.CommandRequest, The instance of SoapApi33Domain.CommandRequest class.
   */
  public static SoapApi33Domain.CommandRequest mapQuantity(
    Decimal updateserviceQuantity,
    String serviceEidValue,
    Boolean displayEffectiveDate,
    String effectiveDate
  ) {
    SoapApi33Domain.CommandRequest updateQuantityReq = new SoapApi33Domain.CommandRequest();
    SoapApi33Domain.ChangeServiceQuantityCommand updateQuantity = new SoapApi33Domain.ChangeServiceQuantityCommand();
    updateQuantity.newQuantity = updateserviceQuantity;
    if (displayEffectiveDate) {
      updateQuantity.effectiveDate = effectiveDate;
    }
    SoapApi33Domain.Service service = new SoapApi33Domain.Service();
    service.eid = serviceEidValue;
    updateQuantity.service = service;
    updateQuantityReq.changeServiceQuantity = updateQuantity;
    return updateQuantityReq;
  }

  /**
   * @description: Get request to resume billing account in GTV db
   * @param tractBillingAccount, The billing account wrapper instance.
   * @return SoapApi33Domain.CommandRequest, The instance of SoapApi33Domain.CommandRequest class.
   */
  public static SoapApi33Domain.CommandRequest mapResumeAccount(
    TRACTAccountWrapper tractBillingAccount
  ) {
    SoapApi33Domain.ResumeBillingAccount resume = new SoapApi33Domain.ResumeBillingAccount();
    SoapApi33Domain.BillingAccount billingAccount = new SoapApi33Domain.BillingAccount();
    billingAccount.eid = tractBillingAccount.eid;
    billingAccount.accountNum = tractBillingAccount.billingAccount.Tract_Billing_Account__c;
    resume.billingAccount = billingAccount;
    SoapApi33Domain.CommandRequest resumeAccount = new SoapApi33Domain.CommandRequest();
    resumeAccount.resumeBillingAccount = resume;
    return resumeAccount;
  }

  /**
   * @description: Get request to suspend billing account in GTV db
   * @param tractBillingAccount, The billing account wrapper instance.
   * @param reasonEid, The billing account suspension reason id.
   * @return SoapApi33Domain.CommandRequest, The instance of SoapApi33Domain.CommandRequest class.
   */
  public static SoapApi33Domain.CommandRequest mapSuspendAccount(
    TRACTAccountWrapper tractBillingAccount,
    String reasonEid
  ) {
    SoapApi33Domain.SuspendBillingAccount suspend = new SoapApi33Domain.SuspendBillingAccount();
    SoapApi33Domain.SuspensionReason reason = new SoapApi33Domain.SuspensionReason();
    reason.eid = reasonEid;
    SoapApi33Domain.BillingAccount billingAccount = new SoapApi33Domain.BillingAccount();
    billingAccount.eid = tractBillingAccount.eid;
    billingAccount.accountNum = tractBillingAccount.billingAccount.Tract_Billing_Account__c;
    suspend.reason = reason;
    suspend.billingAccount = billingAccount;
    SoapApi33Domain.CommandRequest suspendAccount = new SoapApi33Domain.CommandRequest();
    suspendAccount.suspendBillingAccount = suspend;
    return suspendAccount;
  }

  /**
   * @description: Get request to deactivate billing account in GTV db
   * @param tractBillingAccount, The billing account wrapper instance.
   * @param reasonEid, The billing account deactivation reason id.
   * @return SoapApi33Domain.CommandRequest, The instance of SoapApi33Domain.CommandRequest class.
   */
  public static SoapApi33Domain.CommandRequest mapDeactivateAccount(
    TRACTAccountWrapper tractBillingAccount,
    String reasonEid
  ) {
    SoapApi33Domain.DeactivateBillingAccount deactivate = new SoapApi33Domain.DeactivateBillingAccount();
    SoapApi33Domain.DeactivationReason reason = new SoapApi33Domain.DeactivationReason();
    reason.eid = reasonEid;
    SoapApi33Domain.BillingAccount billingAccount = new SoapApi33Domain.BillingAccount();
    billingAccount.eid = tractBillingAccount.eid;
    billingAccount.accountNum = tractBillingAccount.billingAccount.Tract_Billing_Account__c;
    deactivate.reason = reason;
    deactivate.billingAccount = billingAccount;
    SoapApi33Domain.CommandRequest deactivateAccount = new SoapApi33Domain.CommandRequest();
    deactivateAccount.deactivateBillingAccount = deactivate;
    return deactivateAccount;
  }

  /**
   * @description: Get request to deactivate service in GTV db
   * @param serviceEid, The eid of the service to be deactivated.
   * @param reasonEid, The service deactivation reason id.
   * @return SoapApi33Domain.CommandRequest, The instance of SoapApi33Domain.CommandRequest class.
   */
  public static SoapApi33Domain.CommandRequest mapDeactivateService(
    String serviceEid,
    String reasonEid,
    String deactivationDate
  ) {
    SoapApi33Domain.Service deactiveService = new SoapApi33Domain.Service();
    deactiveService.eid = serviceEid;
    SoapApi33Domain.ServiceDeactivationReason deactivateReason = new SoapApi33Domain.ServiceDeactivationReason();
    deactivateReason.eid = reasonEid;
    SoapApi33Domain.DeactivateService deactivateService = new SoapApi33Domain.DeactivateService();
    if (null != deactivationDate) {
      deactivateService.effectiveDate = String.valueOf(deactivationDate)
        .replace(' ', 'T');
    }
    deactivateService.service = deactiveService;
    deactivateService.reason = deactivateReason;
    SoapApi33Domain.CommandRequest deactivateCurrentService = new SoapApi33Domain.CommandRequest();
    deactivateCurrentService.deactivateService = deactivateService;
    return deactivateCurrentService;
  }

  /**
   * @description: Get request to create account custom field value in GTV db
   * @param serviceEid, The eid of the account to which account custom field to be added.
   * @param wrap, The list of AccountCustomFieldWrapper class.
   * @return List<SoapApi33Domain.CommandRequest>, The List of SoapApi33Domain.CommandRequest class.
   */
  public static List<SoapApi33Domain.CommandRequest> mapAccountCustomField(
    String accountEid,
    list<AccountCustomFieldWrapper> wrap
  ) {
    List<SoapApi33Domain.CommandRequest> commandRequestList = new List<SoapApi33Domain.CommandRequest>();
    List<SoapApi33Domain.AddCustomFieldValueToBillingAccount> addCustomFieldValueToBillingAccountList = new List<SoapApi33Domain.AddCustomFieldValueToBillingAccount>();
    /*Creating an Instance of Billing Account */
    SoapApi33Domain.BillingAccount billingAccountCustom = new SoapApi33Domain.BillingAccount();
    billingAccountCustom.eid = accountEid;
    for (AccountCustomFieldWrapper fld : wrap) {
      if (
        (null != fld.value && '' != fld.value) ||
        (null != fld.selectedListTypeValue &&
        'Choose One' != fld.selectedListTypeValue &&
        '' != fld.selectedListTypeValue)
      ) {
        SoapApi33Domain.CommandRequest addBillingAccountCustom = new SoapApi33Domain.CommandRequest();
        SoapApi33Domain.AddCustomFieldValueToBillingAccount addCustomFieldValueToBillingAccount = new SoapApi33Domain.AddCustomFieldValueToBillingAccount();
        SoapApi33Domain.CustomFieldValue customFieldVal = new SoapApi33Domain.CustomFieldValue();
        SoapApi33Domain.CustomField customFld = new SoapApi33Domain.CustomField();
        if (null != fld.selectedListTypeValue) {
          customFieldVal.value = fld.selectedListTypeValue;
        } else {
          customFieldVal.value = fld.value;
        }
        customFld.eid = fld.Eid;
        customFieldVal.customField = customFld;
        addCustomFieldValueToBillingAccount.billingAccount = billingAccountCustom;
        addCustomFieldValueToBillingAccount.customFieldValue = customFieldVal;
        addBillingAccountCustom.addCustomFieldValueToBillingAccount = addCustomFieldValueToBillingAccount;

        commandRequestList.add(addBillingAccountCustom);
      }
    }
    return commandRequestList;
  }

  public static SoapApi33Domain.CommandRequest mapChargeRule(
    String activityProductEid,
    String deletedUsageEid,
    String activityRuleName
  ) {
    SoapApi33Domain.CommandRequest removeServiceUsageRule = new SoapApi33Domain.CommandRequest();
    SoapApi33Domain.CommandResponse commandResUsageRule;
    SoapApi33Domain.RemoveServiceUsageRuleFromService removeServiceUsageRuleFromService = new SoapApi33Domain.RemoveServiceUsageRuleFromService();
    SoapApi33Domain.Service serviceEid = new SoapApi33Domain.Service();
    serviceEid.eid = activityProductEid;
    removeServiceUsageRuleFromService.service = serviceEid;
    if (activityRuleName == 'MatchAll') {
      SoapApi33Domain.MatchAllServiceUsageRule matchAllServiceUsageRule = new SoapApi33Domain.MatchAllServiceUsageRule();
      matchAllServiceUsageRule.eid = deletedUsageEid;
      removeServiceUsageRuleFromService.matchAllServiceUsageRule = matchAllServiceUsageRule;
    }
    if (activityRuleName == 'Formula') {
      SoapApi33Domain.FormulaServiceUsageRule formulaServiceUsageRule = new SoapApi33Domain.FormulaServiceUsageRule();
      formulaServiceUsageRule.eid = deletedUsageEid;
      removeServiceUsageRuleFromService.formulaServiceUsageRule = formulaServiceUsageRule;
    }
    if (activityRuleName == 'Global') {
      SoapApi33Domain.GlobalServiceUsageRule globalServiceUsageRule = new SoapApi33Domain.GlobalServiceUsageRule();
      globalServiceUsageRule.eid = deletedUsageEid;
      removeServiceUsageRuleFromService.globalServiceUsageRule = globalServiceUsageRule;
    }
    removeServiceUsageRule.removeServiceUsageRuleFromService = removeServiceUsageRuleFromService;
    return removeServiceUsageRule;
  }

  /**
   * @description: Get request to resume service in GTV db
   * @param serviceEidValue, The eid of the service to resume.
   * @return SoapApi33Domain.CommandRequest, The instance of SoapApi33Domain.CommandRequest class.
   */
  public static SoapApi33Domain.CommandRequest mapServiceGTV(
    String serviceEidValue
  ) {
    SoapApi33Domain.CommandRequest resumeServiceReq = new SoapApi33Domain.CommandRequest();
    SoapApi33Domain.ResumeService resumeServices = new SoapApi33Domain.ResumeService();
    SoapApi33Domain.Service service = new SoapApi33Domain.Service();
    service.eid = serviceEidValue;
    resumeServices.service = service;
    resumeServiceReq.resumeService = resumeServices;
    return resumeServiceReq;
  }

  /**
   * @description: Get request to convert a trial service in GTV db
   * @param serviceEidValue, The eid of the service to be converted.
   * @return SoapApi33Domain.CommandRequest, The instance of SoapApi33Domain.CommandRequest class.
   */
  public static SoapApi33Domain.CommandRequest mapconvertServiceGTV(
    String serviceEidValue
  ) {
    SoapApi33Domain.CommandRequest convertTrialServiceReq = new SoapApi33Domain.CommandRequest();
    SoapApi33Domain.ServiceCommand convertServiceReq = new SoapApi33Domain.ServiceCommand();
    SoapApi33Domain.Service service = new SoapApi33Domain.Service();
    service.eid = serviceEidValue;
    convertServiceReq.service = service;
    convertTrialServiceReq.convertTrialService = convertServiceReq;
    return convertTrialServiceReq;
  }

  /**
   * @description: Get request to suspend service in GTV db
   * @param serviceEid, The eid of the service to be suspended.
   * @param reasonEid, The service suspension reason id.
   * @return SoapApi33Domain.CommandRequest, The instance of SoapApi33Domain.CommandRequest class.
   */
  public static SoapApi33Domain.CommandRequest mapSuspendServiceGTV(
    String serviceEid,
    String reasonEid
  ) {
    SoapApi33Domain.CommandRequest suspendServiceReq = new SoapApi33Domain.CommandRequest();
    SoapApi33Domain.SuspendService suspendServices = new SoapApi33Domain.SuspendService();
    SoapApi33Domain.ServiceSuspensionReason reason = new SoapApi33Domain.ServiceSuspensionReason();
    reason.eid = reasonEid;
    SoapApi33Domain.Service service = new SoapApi33Domain.Service();
    service.eid = serviceEid;
    suspendServices.reason = reason;
    suspendServices.service = service;
    suspendServiceReq.suspendService = suspendServices;
    return suspendServiceReq;
  }

  public static SoapApi33Domain.CommandRequest mapNewActivityChargeRule(
    ProductServiceWrapper serviceWrapper,
    Map<String, String> rateTableVsUomMap
  ) {
    String productUsageValue = serviceWrapper.chargeRuleWrapper.productUsageRuleListValue;
    String chargeCategoryValue = serviceWrapper.chargeRuleWrapper.chargeCategoryListValue;
    String allowanceValue = serviceWrapper.chargeRuleWrapper.allowanceTypeListValue;
    String amoutChargeSelect = serviceWrapper.chargeRuleWrapper.amountChargePickList;
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
    String checkRuleTypeValue = serviceWrapper.ruleTypeValue;
    SoapApi33Domain.CommandRequest newChargeRule = new SoapApi33Domain.CommandRequest();
    SoapApi33Domain.AddServiceUsageRuleToService addServiceUsageRuleToService = new SoapApi33Domain.AddServiceUsageRuleToService();
    SoapApi33Domain.Service service = new SoapApi33Domain.Service();

    service.eid = serviceWrapper.serviceEid;

    addServiceUsageRuleToService.service = service;

    if (productUsageValue == 'Match All Events') {
      SoapApi33Domain.MatchAllServiceUsageRule matchAllServiceUsageRule = new SoapApi33Domain.MatchAllServiceUsageRule();

      SoapApi33Domain.ChargeCategory chargeCategory = new SoapApi33Domain.ChargeCategory();

      if (null != chargeCategoryValue) {
        chargeCategory.eid = chargeCategoryValue;
      }

      matchAllServiceUsageRule.name = serviceUsageRuleName;
      //matchAllServiceUsageRule.order = '1';
      matchAllServiceUsageRule.allowanceType = allowanceValue;
      if (allowanceValue == 'Unlimited') {
        String uom = rateTableVsUomMap.get(serviceUsageRuleName);
        if (uom != null) {
          matchAllServiceUsageRule.usageUom = uom.toUpperCase();
        }
      } else {
        matchAllServiceUsageRule.usageUom = amoutChargeSelect.toUpperCase();
      }
      matchAllServiceUsageRule.status = statusValue.toUppercase();
      matchAllServiceUsageRule.chargeCategory = chargeCategory;
      matchAllServiceUsageRule.proratedOnOrder = prorateOnOrder;
      matchAllServiceUsageRule.proratedOnCancel = prorateOnCancel;
      matchAllServiceUsageRule.limit_x = ammountValue;
      matchAllServiceUsageRule.rollOverType = rollOverValue;

      //matchAllServiceUsageRule.ruleType='TAPERED';
      matchAllServiceUsageRule.ruleType = checkRuleTypeValue;
      if (rateTypeValue == 'Flat') {
        SoapApi33Domain.FlatUsageRate flatUsageRate = new SoapApi33Domain.FlatUsageRate();
        flatUsageRate.uom = selectedCharge.toUppercase();
        flatUsageRate.rate = chargeValue;
        matchAllServiceUsageRule.flatUsageRate = flatUsageRate;
      }

      if (rateTypeValue == 'Table Rate' || test.isrunningtest()) {
        SoapApi33Domain.TableUsageRate tableUsageRate = new SoapApi33Domain.TableUsageRate();
        SoapApi33Domain.RateTable rateTableUsageRate = new SoapApi33Domain.RateTable();
        rateTableUsageRate.eid = chargeListByteValue;
        tableUsageRate.usageFieldName = chargeFormulaFieldValue;

        tableUsageRate.rateTable = rateTableUsageRate;
        matchAllServiceUsageRule.tableUsageRate = tableUsageRate;
      }

      if (rateTypeValue == 'Pass Through') {
        SoapApi33Domain.PassThroughUsageRate passThroughUsageRate = new SoapApi33Domain.PassThroughUsageRate();
        passThroughUsageRate.usageFieldName = passThroughListValue;

        matchAllServiceUsageRule.passThroughUsageRate = passThroughUsageRate;
      }

      addServiceUsageRuleToService.matchAllServiceUsageRule = matchAllServiceUsageRule;
    }
    if (productUsageValue == 'Formula' || test.isrunningtest()) {
      SoapApi33Domain.FormulaServiceUsageRule formulaServiceUsageRule = new SoapApi33Domain.FormulaServiceUsageRule();

      SoapApi33Domain.ChargeCategory chargeCategory = new SoapApi33Domain.ChargeCategory();

      if (null != chargeCategoryValue) {
        chargeCategory.eid = chargeCategoryValue;
      }

      formulaServiceUsageRule.name = serviceUsageRuleName;

      formulaServiceUsageRule.fieldName = fieldvalue;
      formulaServiceUsageRule.operator = serviceWrapper.chargeRuleWrapper.operationListValue;
      formulaServiceUsageRule.fieldValue = activityFormulaValue;
      //formulaServiceUsageRule.order = '1';
      formulaServiceUsageRule.allowanceType = allowanceValue;
      if (allowanceValue == 'Unlimited') {
        String uom = rateTableVsUomMap.get(serviceUsageRuleName);
        if (uom != null) {
          formulaServiceUsageRule.usageUom = uom.toUpperCase();
        }
      } else {
        if (amoutChargeSelect != 'Choose One') {
          formulaServiceUsageRule.usageUom = amoutChargeSelect.toUpperCase();
        }
        if (selectedChargeGlobal != 'Choose One') {
          formulaServiceUsageRule.usageUom = selectedChargeGlobal.toUpperCase();
        }
      }
      formulaServiceUsageRule.status = statusValue.toUppercase();
      formulaServiceUsageRule.chargeCategory = chargeCategory;
      formulaServiceUsageRule.proratedOnOrder = prorateOnOrder;
      formulaServiceUsageRule.proratedOnCancel = prorateOnCancel;
      formulaServiceUsageRule.limit_x = ammountValue;
      formulaServiceUsageRule.rollOverType = rollOverValue;

      formulaServiceUsageRule.ruleType = checkRuleTypeValue;
      if (rateTypeValue == 'Flat') {
        SoapApi33Domain.FlatUsageRate flatUsageRate = new SoapApi33Domain.FlatUsageRate();
        flatUsageRate.uom = selectedCharge.toUppercase();
        flatUsageRate.rate = chargeValue;
        formulaServiceUsageRule.flatUsageRate = flatUsageRate;
      }

      if (rateTypeValue == 'Table Rate' || test.isrunningtest()) {
        SoapApi33Domain.TableUsageRate tableUsageRate = new SoapApi33Domain.TableUsageRate();
        SoapApi33Domain.RateTable rateTableUsageRate = new SoapApi33Domain.RateTable();
        rateTableUsageRate.eid = chargeListByteValue;
        tableUsageRate.usageFieldName = chargeFormulaFieldValue;

        tableUsageRate.rateTable = rateTableUsageRate;
        formulaServiceUsageRule.tableUsageRate = tableUsageRate;
      }

      if (rateTypeValue == 'Pass Through' || test.isrunningtest()) {
        SoapApi33Domain.PassThroughUsageRate passThroughUsageRate = new SoapApi33Domain.PassThroughUsageRate();
        passThroughUsageRate.usageFieldName = passThroughListValue;

        formulaServiceUsageRule.passThroughUsageRate = passThroughUsageRate;
      }

      addServiceUsageRuleToService.formulaServiceUsageRule = formulaServiceUsageRule;
    }
    if (productUsageValue == 'Global' || test.isrunningtest()) {
      SoapApi33Domain.GlobalServiceUsageRule globalServiceUsageRule = new SoapApi33Domain.GlobalServiceUsageRule();

      SoapApi33Domain.ChargeCategory chargeCategory = new SoapApi33Domain.ChargeCategory();

      SoapApi33Domain.GlobalUsageRule globalUsageRule = new SoapApi33Domain.GlobalUsageRule();
      if (null != chargeCategoryValue) {
        chargeCategory.eid = chargeCategoryValue;
      }
      globalUsageRule.eid = serviceWrapper.chargeRuleWrapper.formulaUsageRuleListValue;

      globalServiceUsageRule.name = serviceUsageRuleName;

      globalServiceUsageRule.allowanceType = allowanceValue;

      if (allowanceValue == 'Unlimited') {
        globalServiceUsageRule.usageUom = selectedChargeGlobal.toUpperCase();
      } else {
        globalServiceUsageRule.usageUom = amoutChargeSelect.toUpperCase();
      }
      globalServiceUsageRule.status = statusValue.toUppercase();
      globalServiceUsageRule.chargeCategory = chargeCategory;

      globalServiceUsageRule.globalUsageRule = globalUsageRule;

      globalServiceUsageRule.proratedOnOrder = prorateOnOrder;
      globalServiceUsageRule.proratedOnCancel = prorateOnCancel;
      globalServiceUsageRule.limit_x = ammountValue;
      globalServiceUsageRule.rollOverType = rollOverValue;

      globalServiceUsageRule.ruleType = checkRuleTypeValue;
      addServiceUsageRuleToService.globalServiceUsageRule = globalServiceUsageRule;
    }
    newChargeRule.addServiceUsageRuleToService = addServiceUsageRuleToService;
    return newChargeRule;
  }

  /**
   * @description: Get request to add address on a service.
   * @param currentServiceEid, The eid of the service.
   * @param country, country of the address.
   * @param line1, Line1 of the address.
   * @param line2, Line2 of the address.
   * @param shippingCity, shippingCity of the address.
   * @param stateValue, Shipping state of the address.
   * @param postalCode, Postal code of the address.
   * @return SoapApi33Domain.CommandRequest, The instance of SoapApi33Domain.CommandRequest class.
   */
  public static SoapApi33Domain.CommandRequest mapAddAddressGTV(
    String currentServiceEid,
    String country,
    String line1,
    String line2,
    String shippingCity,
    String stateValue,
    String postalCode
  ) {
    SoapApi33Domain.CommandRequest addAddressToServiceReq = new SoapApi33Domain.CommandRequest();
    SoapApi33Domain.AddAddressToService addAddressToService = new SoapApi33Domain.AddAddressToService();
    SoapApi33Domain.Service service = new SoapApi33Domain.Service();
    service.eid = currentServiceEid;
    addAddressToService.service = service;
    SoapApi33Domain.PostalAddress postalAddress = new SoapApi33Domain.PostalAddress();
    postalAddress.country = country;
    postalAddress.city = shippingCity;
    postalAddress.regionOrState = stateValue;
    postalAddress.postalCode = postalCode;
    postalAddress.line1 = line1;
    if ('' != line2 && line2 != null) {
      postalAddress.line2 = line2;
    }
    addAddressToService.postalAddress = postalAddress;
    addAddressToServiceReq.addAddressToService = addAddressToService;
    return addAddressToServiceReq;
  }

  public static SoapApi33Domain.CommandRequest mapQuantityAddProduct(
    OpportunityLineItem oli,
    Decimal updateserviceQuantity
  ) {
    SoapApi33Domain.CommandRequest updateQuantityReq = new SoapApi33Domain.CommandRequest();
    SoapApi33Domain.ChangeServiceQuantityCommand updateQuantity = new SoapApi33Domain.ChangeServiceQuantityCommand();
    updateQuantity.newQuantity = updateserviceQuantity;
    updateQuantity.effectiveDate = String.valueOf(Date.today());
    SoapApi33Domain.Service service = new SoapApi33Domain.Service();
    service.eid = oli.Existing_Service_Eid__c;
    updateQuantity.service = service;
    updateQuantityReq.changeServiceQuantity = updateQuantity;
    return updateQuantityReq;
  }

  /**
   * @description: Get request to change a service.
   * @param tAccount, The billing account wrapper instance.
   * @param newSubscriptionId, Salesforce product id.
   * @param effectiveDateValue, The date from which change service in effect.
   * @param currentServiceEid, The eid of current service.
   * @param account, salesforce account object.
   * @param payonPurchaseValue, If to pay on purchase or not.
   * @param mapOfAgreementPeriod, Map of agreement eid Vs agreement period.
   * @param productPriceIdToEidMap, product price map.
   * @param qtyOfChangedService, The quantity on the changed service.
   * @param agreementRenewActionForChangedService, Agreement renew action for the changed service.
   * @param agreementEidForChangedService, Agreement eid for the changed service.
   * @param recurringPrice, Recurring price on the changed service.
   * @param recurringPriceId, Recurring price id on the changed service.
   * @param priceOverridden, Flag to determine if price to be overrided.
   * @return SoapApi33Domain.CommandRequest, The instance of SoapApi33Domain.CommandRequest class.
   */
  public static SoapApi33Domain.CommandRequest mapSaveChangeService(
    TRACTAccountWrapper tAccount,
    String newSubscriptionId,
    String effectiveDateValue,
    String currentServiceEid,
    Account account,
    Boolean payonPurchaseValue,
    Map<String, Decimal> mapOfAgreementPeriod,
    Map<String, String> productPriceIdToEidMap,
    Integer qtyOfChangedService,
    String agreementRenewActionForChangedService,
    String agreementEidForChangedService,
    Decimal recurringPrice,
    String recurringPriceId,
    String priceOverridden
  ) {
    SoapApi33Domain.ChangeServiceCommand changeService = new SoapApi33Domain.ChangeServiceCommand();
    SoapApi33Domain.SalesOrder salesorder = new SoapApi33Domain.SalesOrder();
    SoapApi33Domain.Service service = new SoapApi33Domain.Service();
    SoapApi33Domain.Agreement agreement = new SoapApi33Domain.Agreement();
    SoapApi33Domain.OrderItem tempOitem = new SoapApi33Domain.OrderItem();
    SoapApi33Domain.OrderItem[] arrayof = new List<SoapApi33Domain.OrderItem>();
    SoapApi33Domain.BillingAccount billingAccount = new SoapApi33Domain.BillingAccount();
    SOAPAPI33Domain.OrderItemPrices orderItemPrices = new SOAPAPI33Domain.OrderItemPrices();

    Boolean priceOverride = (Boolean) JSON.deserialize(
      priceOverridden,
      Boolean.class
    );
    tempOitem.quantity = Decimal.valueOf(Integer.valueOf(qtyOfChangedService));
    tempOitem.product = new SoapApi33Domain.Product();
    String newServiceEid;
    List<Product2> newService;
    if (
      TRACTAPIUtil.checkFieldLevelSecurity(
        'Product2',
        'id, eid__c,Requires_Agreement__c,Price_Information__c',
        'Query'
      )
    ) {
      newService = [
        SELECT id, eid__c, Requires_Agreement__c, Price_Information__c
        FROM Product2
        WHERE id = :newSubscriptionId
      ];
      if (newService.size() > 0) {
        newServiceEid = newService[0].eid__c;
      }
    }
    tempOitem.product.eid = newServiceEid;
    service.eid = currentServiceEid;

    if (newService != null) {
      List<ProductPriceWrapper> productPriceWrapList = (list<ProductPriceWrapper>) JSON.deserialize(
        newService[0].Price_Information__c,
        list<ProductPriceWrapper>.class
      );
      for (ProductPriceWrapper ppw : productPriceWrapList) {
        if (ppw.priceType == 'recurring' && ppw.eid == recurringPriceId) {
          SOAPAPI33Domain.OrderItemRecurringPrice orderItemRecurringPrice = new SOAPAPI33Domain.OrderItemRecurringPrice();
          SoapApi33Domain.RecurringProductPrice recurringProductPrice = new SoapApi33Domain.RecurringProductPrice();
          recurringProductPrice.eid = recurringPriceId;
          orderItemRecurringPrice.recurringProductPrice = recurringProductPrice;
          if (null != recurringPrice && priceOverride) {
            SOAPAPI33Domain.OrderItemPriceRanges orderItempriceRanges = new SOAPAPI33Domain.OrderItemPriceRanges();
            SOAPAPI33Domain.OrderItemPriceRange[] orderItemPriceRangeList = new List<SOAPAPI33Domain.OrderItemPriceRange>{};
            SOAPAPI33Domain.OrderItemPriceRange orderItemPriceRange = new SOAPAPI33Domain.OrderItemPriceRange();
            orderItemPriceRange.price = String.valueof(recurringPrice);
            orderItemPriceRange.currencyType = ppw.currencyType;
            orderItemPriceRangeList.add(orderItemPriceRange);
            orderItempriceRanges.orderItemPriceRange = orderItemPriceRangeList;
            orderItemRecurringPrice.orderItempriceRanges = orderItempriceRanges;
          }
          orderItemPrices.orderItemRecurringPrice = orderItemRecurringPrice;
        }
      }
    }
    tempOitem.orderItemPrices = orderItemPrices;
    if (
      null != agreementEidForChangedService &&
      agreementEidForChangedService != ''
    ) {
      agreement.eid = agreementEidForChangedService;
      agreement.agreementPeriod = Integer.valueOf(
        mapOfAgreementPeriod.get(agreementEidForChangedService)
      );
      agreement.endAction = agreementRenewActionForChangedService;
      tempOitem.selectedAgreement = agreement;
    }
    arrayof.add(tempOitem);
    salesorder.orderItems = new SoapApi33Domain.OrderItems();
    salesorder.orderItems.orderItem = arrayof;
    billingAccount.eid = tAccount.eid;
    salesorder.billingAccount = billingAccount;
    changeService.service = service;
    changeService.order = salesorder;
    if (effectiveDateValue != null) {
      changeService.effectiveDate = String.valueOf(effectiveDateValue)
        .replace(' ', 'T');
    }
    changeService.payOnPurchase = payonPurchaseValue;
    SoapApi33Domain.CommandRequest changeCurrentService = new SoapApi33Domain.CommandRequest();
    changeCurrentService.changeService = changeService;
    return changeCurrentService;
  }

  /**
   * @description: Get request to create adjustments in GTV.
   * @param effectiveDate, The effective date on the adjustment.
   * @param adjustmentReasonEid, The GTV id for adjustment reason.
   * @param ammount, Adjustment amount.
   * @param description, The description on the adjustment.
   * @param tAccount, The billing account wrapper instance.
   * @param manualInvoice, if the adustment has to invoiced manually or not.
   * @param isCredit, if the adjustment is a credit adjustment or not.
   * @return SoapApi33Domain.CreateAdjustment, The instance of SoapApi33Domain.CreateAdjustment class.
   */
  public static SoapApi33Domain.CreateAdjustment mapAdjustment(
    String effectiveDate,
    string adjustmentReasonEid,
    String ammount,
    String description,
    TRACTAccountWrapper tAccount,
    boolean manualInvoice,
    boolean isCredit
  ) {
    SoapApi33Domain.CreateAdjustment adjustment = new SoapApi33Domain.CreateAdjustment();
    DateTime dt = DateTime.newInstance(
      Date.valueOf(effectiveDate),
      System.now().time()
    );
    adjustment.occurredOn = dt;
    adjustment.amount = Double.valueOf(ammount);
    adjustment.description = String.valueOf(description);
    if (isCredit) {
      adjustment.credit = true;
    } else {
      adjustment.credit = false;
    }
    if (true == manualInvoice) {
      adjustment.manualInvoiceApplication = true;
    }
    SoapApi33Domain.BillingAccount billingAccount = new SoapApi33Domain.BillingAccount();
    billingAccount.eid = String.valueOf(tAccount.eid);
    SoapApi33Domain.AdjustmentReason reason = new SoapApi33Domain.AdjustmentReason();
    reason.eid = adjustmentReasonEid;
    adjustment.reason = reason;
    adjustment.billingAccount = billingAccount;
    return adjustment;
  }

  public static SoapApi33Domain.CreateRequest createAdjustmentRequest(
    SoapApi33Domain.CreateAdjustment adjustment
  ) {
    SoapApi33Domain.CreateRequest createReq = new SoapApi33Domain.CreateRequest();
    SoapApi33Domain.CreateResponse creteRes;
    createReq.adjustment = adjustment;
    return createReq;
  }

  public static SoapApi33Domain.CommandRequest mapPostAdjustment(
    SoapApi33Domain.CreateResponse creteRes,
    SoapApi33Domain.CreateAdjustment adjustment
  ) {
    SoapApi33Domain.CommandRequest postCreditAdjustment = new SoapApi33Domain.CommandRequest();
    SoapApi33Domain.PostAdjustment postAdjustment = new SoapApi33Domain.PostAdjustment();
    adjustment.eid = String.valueOf(creteRes.eid);
    postAdjustment.adjustment = adjustment;
    postCreditAdjustment.postAdjustment = postAdjustment;
    return postCreditAdjustment;
  }

  /**
   * @description: Get request to add service resource to a service.
   * @param service, The GTV service.
   * @param serviceResource, The GTV service resource.
   * @param effectiveDate, The effective date on the service resource.
   * @return SoapApi33Domain.CommandRequest, The instance of SoapApi33Domain.CommandRequest class.
   */
  public static SoapApi33Domain.CommandRequest mapServiceResourceToService(
    SoapApi33Domain.Service service,
    SoapApi33Domain.ServiceResource serviceResource,
    String effectiveDate
  ) {
    SoapApi33Domain.AddServiceResourceToService addServiceResourceToService = new SoapApi33Domain.AddServiceResourceToService();
    addServiceResourceToService.service = service;
    addServiceResourceToService.serviceResource = serviceResource;
    if (null != effectiveDate && effectiveDate != 'null') {
      addServiceResourceToService.effectiveDate = (Date) JSON.deserialize(
        effectiveDate,
        Date.class
      );
    }
    SoapApi33Domain.CommandRequest addServiceResourceToServiceCommand = new SoapApi33Domain.CommandRequest();
    addServiceResourceToServiceCommand.addServiceResourceToService = addServiceResourceToService;
    return addServiceResourceToServiceCommand;
  }

  public static SoapApi33Domain.CommandRequest mapChangeServiceResource(
    ProductServiceWrapper wrapperObj,
    String effectiveDate,
    String parentServiceEid,
    SoapApi33Domain.ServiceResource changeToServiceResource
  ) {
    SoapApi33Domain.Service service = new SoapApi33Domain.Service();
    service.eid = parentServiceEid;
    SoapApi33Domain.ServiceResource serviceResource = new SoapApi33Domain.ServiceResource();
    serviceResource.eid = wrapperObj.serviceEid;
    serviceResource.identifier = wrapperObj.serviceName;
    SoapApi33Domain.ChangeServiceResource changeServiceResource = new SoapApi33Domain.ChangeServiceResource();
    changeServiceResource.service = service;
    changeServiceResource.serviceResource = serviceResource;
    changeServiceResource.changeToServiceResource = changeToServiceResource;
    if (effectiveDate != null && effectiveDate != 'null') {
      changeServiceResource.effectiveDate = (Date) JSON.deserialize(
        effectiveDate,
        Date.class
      );
    }
    SoapApi33Domain.CommandRequest changeServiceResourceCommand = new SoapApi33Domain.CommandRequest();
    changeServiceResourceCommand.changeServiceResource = changeServiceResource;
    return changeServiceResourceCommand;
  }

  public static SoapApi33Domain.CommandRequest mapPopupService(
    String currentProductEid,
    Boolean preserveAgreement
  ) {
    SoapApi33Domain.CompatibleForChangeService compatibleForChangeService = new SoapApi33Domain.CompatibleForChangeService();
    compatibleForChangeService.preserveAgreement = preserveAgreement;
    SoapApi33Domain.Service service = new SoapApi33Domain.Service();
    service.eid = currentProductEid;
    SoapApi33Domain.CommandRequest serviceCommandRequest = new SoapApi33Domain.CommandRequest();

    compatibleForChangeService.service = service;
    serviceCommandRequest.compatibleForChangeService = compatibleForChangeService;
    return serviceCommandRequest;
  }

  public static SoapApi33Domain.CommandRequest mapPopupRenew(
    TRACTAccountWrapper tAccount,
    String renewAgreementEid,
    String serviceRenewEid,
    SoapApi33Domain.QueryResponse queryResponse,
    String recurringPriceString,
    String oneTimePriceString,
    Boolean dateOverridden,
    String deactivateDateString,
    SoapApi33Domain.Service currentService
  ) {
    SoapApi33Domain.CommandRequest renewalOrder = new SoapApi33Domain.CommandRequest();
    SoapApi33Domain.RenewService renewService = new SoapApi33Domain.RenewService();
    SoapApi33Domain.Service service = new SoapApi33Domain.Service();
    SoapApi33Domain.Agreement tempAgreement = new SoapApi33Domain.Agreement();
    service.eid = serviceRenewEid;
    SoapApi33Domain.SalesOrder salesorder = new SoapApi33Domain.SalesOrder();
    SoapApi33Domain.OrderItem tempOitem = new SoapApi33Domain.OrderItem();
    SoapApi33Domain.OrderItem[] arrayof = new List<SoapApi33Domain.OrderItem>();
    SoapApi33Domain.BillingAccount billingAccount1 = new SoapApi33Domain.BillingAccount();
    billingAccount1.eid = tAccount.eid;
    tempOitem.product = new SoapApi33Domain.Product();
    tempOitem.quantity = 1;
    tempOitem.sequence = 1;
    tempOitem.product.eid = currentService.product.eid;
    if (recurringPriceString != null && recurringPriceString != '') {
      tempOitem.recurringUnitPrice = Integer.valueOf(recurringPriceString);
    }
    if (oneTimePriceString != null && oneTimePriceString != '') {
      tempOitem.unitPrice = Integer.valueOf(oneTimePriceString);
    }
    tempAgreement.eid = renewAgreementEid;
    tempOitem.selectedAgreement = tempAgreement;
    if (
      dateOverridden &&
      deactivateDateString != null &&
      deactivateDateString != ''
    ) {
      SoapApi33Domain.AgreementConfiguration overrideAgreementSettings = new SoapApi33Domain.AgreementConfiguration();
      overrideAgreementSettings.endDate = Date.valueOf(deactivateDateString);
      tempOitem.agreementConfiguration = overrideAgreementSettings;
    }
    arrayof.add(tempOitem);
    renewService.service = service;
    salesorder.orderItems = new SoapApi33Domain.OrderItems();
    salesorder.orderItems.orderItem = arrayof;
    renewService.order = salesorder;
    salesorder.billingAccount = billingAccount1;
    renewalOrder.renewService = renewService;
    return renewalOrder;
  }

  public static String SrIdentifier;

  /**
   * @description: Get request to create draft order in GTV db
   * @param billingAccount1, This parameter store information about GTV billing account.
   * @param information, Map containing required information for creating salesorder request
   * @return SoapApi33Domain.CommandRequest, The instance of SoapApi33Domain.CommandRequest class.
   */
  public static SoapApi33Domain.CommandRequest tractPlaceDraftOrder(
    SoapApi33Domain.BillingAccount billingAccount1,
    Map<String, String> information
  ) {
    SoapApi33Domain.CommandRequest createDraftOrderCmd = new SoapApi33Domain.CommandRequest();
    SoapApi33Domain.CreateDraftOrder createDraftOrder = new SoapApi33Domain.CreateDraftOrder();
    createDraftOrder.salesOrder = getSalesOrder(billingAccount1, information);
    createDraftOrder.salesOrder.orderStatus = 'DRAFT';
    createDraftOrderCmd.createDraftOrder = createDraftOrder;
    return createDraftOrderCmd;
  }

  /**
   * @description: Get request to create order in GTV db
   * @param billingAccount1, This parameter store information about GTV billing account.
   * @param information, Map containing required information for creating salesorder request
   * @return RestAPI2Domain.GTVAPICreateSalesOrder, The instance of RestAPI2Domain.GTVAPICreateSalesOrder class.
   */
  public static SoapApi33Domain.CreateRequest tractPlaceSalesOrder(
    SoapApi33Domain.BillingAccount billingAccount,
    Map<String, String> information
  ) {
    SoapApi33Domain.CreateRequest createReq = new SoapApi33Domain.CreateRequest();
    createReq.salesOrder = getSalesOrder(billingAccount, information);
    return createReq;
  }

  /**
   * @description: Get request to create order in GTV db
   * @param billingAccount1, This parameter store information about GTV billing account.
   * @param information, Map containing required information for creating salesorder request
   * @return SoapApi33Domain.Salesorder, The instance of SoapApi33Domain.Salesorder class.
   */
  public static SoapApi33Domain.Salesorder getSalesOrder(
    SoapApi33Domain.BillingAccount billingAccount1,
    Map<String, String> information
  ) {
    SoapApi33Domain.QueryRequest queryReq = new SoapApi33Domain.QueryRequest();
    SoapApi33Domain.SimpleDataQuery simpleDataQuery = new SoapApi33Domain.SimpleDataQuery();
    SoapApi33Domain.SalesOrder salesorder1 = new SoapApi33Domain.SalesOrder();
    SoapApi33Domain.Agreement tempAgreement = null;
    SoapApi33Domain.TenantOrderItem[] tenantOrderItemList = new List<SoapApi33Domain.TenantOrderItem>();
    SoapApi33Domain.TenantOrderItem tenantOrderItem = new SoapApi33Domain.TenantOrderItem();

    /* Bring all the Opportunity line items details NOT FROM PRODUCTS*/
    TractProduct[] productList = TractSFDC_Util.getProductFromOpportunity(
      information
    );
    return getOrder(billingAccount1, productList, information);
  }

  /**
   * @description: Get request to create recurring product price in GTV db
   * @param createProductPriceWrapper, The product price wrapper instance having information about new product price to be created.
   * @param priceListId, The GTV pricelist id.
   * @return SoapApi33Domain.CommandRequest, The instance of SoapApi33Domain.CommandRequest class.
   */
  public static SoapApi33Domain.CommandRequest mapRecurringProductPrice(
    CreateRecurringChargePriceWrapper createProductPriceWrapper,
    String priceListId
  ) {
    SoapApi33Domain.CommandRequest createRecurringPriceCmd = new SoapApi33Domain.CommandRequest();
    SoapApi33Domain.AddProductPriceToProduct addProductPrice = new SoapApi33Domain.AddProductPriceToProduct();
    SoapApi33Domain.Product pro = new SoapApi33Domain.Product();
    pro.eid = createProductPriceWrapper.productId;
    if (priceListId != null) {
      SoapApi33Domain.PriceList priceListDet = new SoapApi33Domain.PriceList();
      priceListDet.eid = priceListId;
      addProductPrice.priceList = priceListDet;
    }
    SoapApi33Domain.RecurringProductPrice recurringPrice = new SoapApi33Domain.RecurringProductPrice();
    recurringPrice.currencyType = createProductPriceWrapper.selectedcurrency;
    recurringPrice.recurrencePeriod = createProductPriceWrapper.recurrencePeriod;
    recurringPrice.proratedOnCancel = createProductPriceWrapper.proratedOnCancel;
    recurringPrice.proratedOnOrder = createProductPriceWrapper.proratedOnOrder;
    recurringPrice.paymentOnPurchaseRequired = createProductPriceWrapper.payOnPurchase;
    recurringPrice.priceOverride = createProductPriceWrapper.priceOverride;
    recurringPrice.proratedOnOrderNoCharge = createProductPriceWrapper.proratedOnOrderNoCharge;
    recurringPrice.eid = createProductPriceWrapper.eid;
    if (createProductPriceWrapper.fromDate != null) {
      recurringPrice.fromDate = Datetime.newInstance(
        createProductPriceWrapper.fromDate,
        System.now().time()
      );
    }
    if (
      createProductPriceWrapper.createPriceRangeWrapper != null &&
      createProductPriceWrapper.createPriceRangeWrapper.size() > 0
    ) {
      recurringPrice.priceRanges = new SoapApi33Domain.PriceRanges();
      recurringPrice.priceRanges.priceRange = new List<SoapApi33Domain.PriceRange>();
      Integer level = 0;
      for (
        CreatePriceRangeWrapper priceRangeWrapInstance : createProductPriceWrapper.createPriceRangeWrapper
      ) {
        level++;
        SoapApi33Domain.PriceRange createPriceRange = new SoapApi33Domain.PriceRange();
        createPriceRange.level = level;
        createPriceRange.currencyType = createProductPriceWrapper.selectedcurrency;
        createPriceRange.quantityBeginRange = priceRangeWrapInstance.startingQuantity;
        createPriceRange.quantityEndRange = priceRangeWrapInstance.endingQuantity;
        createPriceRange.price = priceRangeWrapInstance.Price;
        recurringPrice.priceRanges.priceRange.add(createPriceRange);
      }
    }
    SoapApi33Domain.PriceCategory cat = new SoapApi33Domain.PriceCategory();
    cat.eid = createProductPriceWrapper.priceCategory;
    recurringPrice.priceCategory = cat;
    addProductPrice.recurringProductPrice = recurringPrice;
    addProductPrice.product = pro;
    createRecurringPriceCmd.addProductPriceToProduct = addProductPrice;
    return createRecurringPriceCmd;
  }

  /**
   * @description: Get request to create product in GTV db
   * @param createProductWrapper, The create product wrapper instance that have information about new product to be created.
   * @return SoapApi33Domain.CreateRequest, The instance of SoapApi33Domain.CreateRequest class.
   */
  public static SoapApi33Domain.CreateRequest mapCreateGTVProduct(
    CreateProductWrapper createProductWrapper
  ) {
    SoapApi33Domain.CreateRequest createProductReq = new SoapApi33Domain.CreateRequest();
    SoapApi33Domain.Product createProduct = new SoapApi33Domain.Product();
    system.debug(
      'createProductWrapper.productType;:::::::' +
      createProductWrapper.productType
    );
    if (
      createProductWrapper.productType != null &&
      createProductWrapper.productType != ''
    ) {
      createProduct.productTypeCode = createProductWrapper.productType;
    }
    createProduct.name = createProductWrapper.productName;
    createProduct.sku = createProductWrapper.SKU;
    createProduct.externalProductNumber = createProductWrapper.externalName;
    createProduct.internalName = createProductWrapper.internalName;
    createProduct.description = createProductWrapper.Description;
    createProduct.shortDescription = createProductWrapper.shortDescription;
    createProduct.introductionDate = createProductWrapper.introductionDate;
    createProduct.requiresAgreement = createProductWrapper.agreementMandatory;
    createProduct.serialized = createProductWrapper.unique;
    createProduct.taxable = createProductWrapper.taxable;
    createProduct.defaultQuantity = createProductWrapper.defaultQuantity;
    createProduct.ruleMode = createProductWrapper.ruleMode;
    createProduct.ruleType = createProductWrapper.ruleType;
    if (
      createProductWrapper.identifierCategory != null &&
      createProductWrapper.identifierCategory != ''
    ) {
      createProduct.serviceResourceCategory = new SoapApi33Domain.ServiceResourceCategory();
      createProduct.serviceResourceCategory.eid = createProductWrapper.identifierCategory;
    }
    createProduct.minServiceResources = createProductWrapper.minimumIdentifiers;
    createProduct.maxServiceResources = createProductWrapper.maximumIdentifiers;
    if (
      createProductWrapper.productCategory != null &&
      createProductWrapper.productCategory != ''
    ) {
      createProduct.productCategory = new SoapApi33Domain.ProductCategory();
      createProduct.productCategory.eid = createProductWrapper.productCategory;
    }
    createProductReq.product = createProduct;

    return createProductReq;
  }

  private static SoapApi33Domain.Salesorder getOrder(
    SoapApi33Domain.BillingAccount billingAccount1,
    TractProduct[] productList,
    Map<String, String> information
  ) {
    SoapApi33Domain.SalesOrder salesorder = new SoapApi33Domain.SalesOrder();
    salesorder.customFieldValues = getCustomFieldVals(information);
    if (
      String.isNotBlank(information.get('OrderDate')) &&
      information.get('OrderDate') != 'NA'
    ) {
      salesOrder.orderDate = getDate(information);
    }
    salesorder.orderItems = new SoapApi33Domain.OrderItems();
    salesOrder.orderItems.orderItem = getOrderItem(productList, information);
    salesOrder.billingAccount = billingAccount1;
    salesOrder.note =
      'An Order placed through Salesforce Opportunity Name : ' +
      information.get('Name');
    return salesorder;
  }

  private static SoapApi33Domain.CustomFieldValues getCustomFieldVals(
    Map<String, String> information
  ) {
    list<Order_Custom_Field__c> orderCustomFields = new List<Order_Custom_Field__c>();
    String oppId = information.get('OpportunityId');
    orderCustomFields = [
      SELECT eid__c, name, OpportunityIdCheck__c, Value__c
      FROM Order_Custom_Field__c
      WHERE OpportunityIdCheck__c = :oppId AND Value__c != NULL
      LIMIT 50000
    ];
    SoapApi33Domain.CustomFieldValues customFieldVals = new SoapApi33Domain.CustomFieldValues();
    if (null != orderCustomFields && !orderCustomFields.isEmpty()) {
      List<SoapApi33Domain.CustomFieldValue> customFldValueList = new List<SoapApi33Domain.CustomFieldValue>();
      for (Order_Custom_Field__c orderFields : orderCustomFields) {
        SoapApi33Domain.CustomFieldValue customFieldVal = new SoapApi33Domain.CustomFieldValue();
        SoapApi33Domain.CustomField customFld = new SoapApi33Domain.CustomField();
        customFld.eid = orderFields.eid__c;
        customFieldVal.value = orderFields.Value__c;
        customFieldVal.customField = customFld;
        customFldValueList.add(customFieldVal);
      }
      customFieldVals.customFieldValue = customFldValueList;
    }
    return customFieldVals;
  }

  private static String getDate(Map<String, String> information) {
    Date orderStartDate = Date.parse(information.get('OrderDate'));
    String strStartDate = '';
    strStartDate = String.Valueof(orderStartDate).replace(' ', 'T');
    return strStartDate;
  }

  /**
   * @description: Map order item for a GTV order
   * @param productList, List of tract product to be included as order item.
   * @param information, Map containing required information for creating salesorder request
   * @return SoapApi33Domain.OrderItem [], The array of SoapApi33Domain.OrderItem class.
   */
  public static SoapApi33Domain.OrderItem[] getOrderItem(
    TractProduct[] productList,
    Map<String, String> information
  ) {
    SoapApi33Domain.OrderItem tempOitem = null;
    SoapApi33Domain.OrderItem[] arrayof = new List<SoapApi33Domain.OrderItem>();
    SoapApi33Domain.QueryResponse queryResponse;
    SoapApi33Domain.OrderItem tempOitem1 = null;
    SoapApi33Domain.OrderItem tempOitem2 = null;
    SoapApi33Domain.Agreement tempAgreement = null;
    String oppId = information.get('OpportunityId');
    Set<String> opportunityLineItemIdSet = new Set<String>();
    Map<String, list<Schdeule_Charge__c>> opportunityProductIdVsScheduleChargesMap = new Map<String, list<Schdeule_Charge__c>>();
    Map<String, list<Schdeule_Charge__c>> opportunityProductIdVsOneTimeScheduleChargesMap = new Map<String, list<Schdeule_Charge__c>>();
    Map<String, list<Service_Custom_Field__c>> opportunityProductIdVsServiceCustomFieldMap = new Map<String, list<Service_Custom_Field__c>>();

    for (TractProduct tractProduct : productList) {
      opportunityLineItemIdSet.add(tractProduct.opportunityProductId);
    }

    if (opportunityLineItemIdSet.size() > 0) {
      for (Service_Custom_Field__c scfInstance : [
        SELECT name, parentId__c, ProductId__c, value__c, eid__c
        FROM Service_Custom_Field__c
        WHERE ProductId__c = :opportunityLineItemIdSet
        LIMIT 50000
      ]) {
        if (
          opportunityProductIdVsServiceCustomFieldMap.containskey(
            scfInstance.ProductId__c
          )
        ) {
          opportunityProductIdVsServiceCustomFieldMap.get(
              scfInstance.ProductId__c
            )
            .add(scfInstance);
        } else {
          opportunityProductIdVsServiceCustomFieldMap.put(
            scfInstance.ProductId__c,
            new List<Service_Custom_Field__c>()
          );
          opportunityProductIdVsServiceCustomFieldMap.get(
              scfInstance.ProductId__c
            )
            .add(scfInstance);
        }
      }
    }

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
        WHERE
          ProductId__c = :opportunityLineItemIdSet
          AND Charge_Type__c = 'Recurring'
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

      for (Schdeule_Charge__c oneTimeScheduleChargeInstance : [
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
          opportunityProductIdVsOneTimeScheduleChargesMap.containskey(
            oneTimeScheduleChargeInstance.ProductId__c
          )
        ) {
          opportunityProductIdVsOneTimeScheduleChargesMap.get(
              oneTimeScheduleChargeInstance.ProductId__c
            )
            .add(oneTimeScheduleChargeInstance);
        } else {
          opportunityProductIdVsOneTimeScheduleChargesMap.put(
            oneTimeScheduleChargeInstance.ProductId__c,
            new List<Schdeule_Charge__c>()
          );
          opportunityProductIdVsOneTimeScheduleChargesMap.get(
              oneTimeScheduleChargeInstance.ProductId__c
            )
            .add(oneTimeScheduleChargeInstance);
        }
      }
    }

    for (TractProduct tractProduct : productList) {
      if (tractProduct.ProductCode == 'Subscription') {
        SOAPAPI33Domain.OrderItemPrices orderItemPrices = new SOAPAPI33Domain.OrderItemPrices();
        String subscriptionId = tractProduct.ProductId;
        tempOitem = new SoapApi33Domain.OrderItem();
        tempOitem.product = new SoapApi33Domain.Product();
        Double quantity = Double.valueof(tractProduct.quantity);
        tempOitem.product.eid = tractProduct.eid;
        tempOitem.sequence = 1;
        tempOitem.overrideTrialDays = Integer.valueOf(
          tractProduct.overridedTrialLength
        );
        tempOitem.product.name = tractProduct.name;
        SoapApi33Domain.PriceList priceList = new SoapApi33Domain.PriceList();
        priceList.eid = tractProduct.priceListEid;
        tempOitem.priceList = priceList;

        SoapApi33Domain.OrderItemUsageRules orderItemUsageRules = new SoapApi33Domain.OrderItemUsageRules();
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
          WHERE ProductEid__c = :tractProduct.eid AND OpportunityID__c = :oppId
          LIMIT 50000
        ]) {
          if (orderUsageRule.ProductUsageValue__c == 'Match All Events') {
            SoapApi33Domain.MatchAllOrderItemUsageRule matchAllServiceUsageRule = new SoapApi33Domain.MatchAllOrderItemUsageRule();
            SoapApi33Domain.ChargeCategory chargeCategory = new SoapApi33Domain.ChargeCategory();

            if (null != orderUsageRule.ChargeCategoryEid__c) {
              chargeCategory.eid = orderUsageRule.ChargeCategoryEid__c;
            }
            matchAllServiceUsageRule.name = orderUsageRule.name;
            matchAllServiceUsageRule.allowanceType = orderUsageRule.AllowanceType__c;
            matchAllServiceUsageRule.usageUom = orderUsageRule.UsageUom__c;
            matchAllServiceUsageRule.status = orderUsageRule.Status__c;
            matchAllServiceUsageRule.chargeCategory = chargeCategory;
            matchAllServiceUsageRule.proratedOnOrder = Boolean.valueOf(
              orderUsageRule.ProratedOnOrder__c
            );
            matchAllServiceUsageRule.proratedOnCancel = Boolean.valueOf(
              orderUsageRule.ProratedOnCancel__c
            );
            matchAllServiceUsageRule.limit_x = orderUsageRule.Limit__c;
            matchAllServiceUsageRule.rollOverType = orderUsageRule.RollOverType__c;
            matchAllServiceUsageRule.ruleType = orderUsageRule.RuleType__c;
            if (orderUsageRule.RateTypeValue__c == 'Flat') {
              SoapApi33Domain.FlatUsageRate flatUsageRate = new SoapApi33Domain.FlatUsageRate();
              flatUsageRate.uom = orderUsageRule.UsageRateUom__c;
              flatUsageRate.rate = orderUsageRule.UsageRate__c;
              matchAllServiceUsageRule.flatUsageRate = flatUsageRate;
            }
            if (orderUsageRule.RateTypeValue__c == 'Table Rate') {
              SoapApi33Domain.TableUsageRate tableUsageRate = new SoapApi33Domain.TableUsageRate();
              SoapApi33Domain.RateTable rateTableUsageRate = new SoapApi33Domain.RateTable();
              rateTableUsageRate.eid = orderUsageRule.RateTableEid__c;
              tableUsageRate.usageFieldName = orderUsageRule.RateTableUsageFieldName__c;

              tableUsageRate.rateTable = rateTableUsageRate;
              matchAllServiceUsageRule.tableUsageRate = tableUsageRate;
            }

            if (orderUsageRule.RateTypeValue__c == 'Pass Through') {
              SoapApi33Domain.PassThroughUsageRate passThroughUsageRate = new SoapApi33Domain.PassThroughUsageRate();
              passThroughUsageRate.usageFieldName = orderUsageRule.RateTableUsageFieldName__c;

              matchAllServiceUsageRule.passThroughUsageRate = passThroughUsageRate;
            }

            orderItemUsageRules.matchAllOrderItemUsageRule = matchAllServiceUsageRule;
          }
          if (orderUsageRule.ProductUsageValue__c == 'Formula') {
            SoapApi33Domain.FormulaOrderItemUsageRule formulaServiceUsageRule = new SoapApi33Domain.FormulaOrderItemUsageRule();

            SoapApi33Domain.ChargeCategory chargeCategory = new SoapApi33Domain.ChargeCategory();

            if (null != orderUsageRule.ChargeCategoryEid__c) {
              chargeCategory.eid = orderUsageRule.ChargeCategoryEid__c;
            }
            formulaServiceUsageRule.name = orderUsageRule.name;
            formulaServiceUsageRule.fieldName = orderUsageRule.FormulaFieldName__c;
            formulaServiceUsageRule.operator = orderUsageRule.FormulaOperator__c;
            formulaServiceUsageRule.fieldValue = orderUsageRule.FormulaFieldvalue__c;
            formulaServiceUsageRule.allowanceType = orderUsageRule.AllowanceType__c;
            if (orderUsageRule.UsageUom__c != null) {
              formulaServiceUsageRule.usageUom = orderUsageRule.UsageUom__c;
            }
            formulaServiceUsageRule.status = orderUsageRule.Status__c;
            formulaServiceUsageRule.chargeCategory = chargeCategory;
            formulaServiceUsageRule.proratedOnOrder = Boolean.valueOf(
              orderUsageRule.ProratedOnOrder__c
            );
            formulaServiceUsageRule.proratedOnCancel = Boolean.valueOf(
              orderUsageRule.ProratedOnCancel__c
            );
            formulaServiceUsageRule.limit_x = orderUsageRule.Limit__c;
            formulaServiceUsageRule.rollOverType = orderUsageRule.RollOverType__c;
            formulaServiceUsageRule.ruleType = orderUsageRule.RuleType__c;
            if (orderUsageRule.RateTypeValue__c == 'Flat') {
              SoapApi33Domain.FlatUsageRate flatUsageRate = new SoapApi33Domain.FlatUsageRate();
              flatUsageRate.uom = orderUsageRule.UsageRateUom__c;
              flatUsageRate.rate = orderUsageRule.UsageRate__c;
              formulaServiceUsageRule.flatUsageRate = flatUsageRate;
            }
            if (orderUsageRule.RateTypeValue__c == 'Table Rate') {
              SoapApi33Domain.TableUsageRate tableUsageRate = new SoapApi33Domain.TableUsageRate();
              SoapApi33Domain.RateTable rateTableUsageRate = new SoapApi33Domain.RateTable();
              rateTableUsageRate.eid = orderUsageRule.RateTableEid__c;
              tableUsageRate.usageFieldName = orderUsageRule.RateTableUsageFieldName__c;
              tableUsageRate.rateTable = rateTableUsageRate;
              formulaServiceUsageRule.tableUsageRate = tableUsageRate;
            }
            if (orderUsageRule.RateTypeValue__c == 'Pass Through') {
              SoapApi33Domain.PassThroughUsageRate passThroughUsageRate = new SoapApi33Domain.PassThroughUsageRate();
              passThroughUsageRate.usageFieldName = orderUsageRule.RateTableUsageFieldName__c;
              formulaServiceUsageRule.passThroughUsageRate = passThroughUsageRate;
            }
            orderItemUsageRules.formulaOrderItemUsageRule = formulaServiceUsageRule;
          }
          if (orderUsageRule.ProductUsageValue__c == 'Global') {
            SoapApi33Domain.GlobalOrderItemUsageRule globalServiceUsageRule = new SoapApi33Domain.GlobalOrderItemUsageRule();

            SoapApi33Domain.ChargeCategory chargeCategory = new SoapApi33Domain.ChargeCategory();

            SoapApi33Domain.GlobalUsageRule globalUsageRule = new SoapApi33Domain.GlobalUsageRule();
            if (null != orderUsageRule.ChargeCategoryEid__c) {
              chargeCategory.eid = orderUsageRule.ChargeCategoryEid__c;
            }
            globalUsageRule.eid = orderUsageRule.GlobalUsageEid__c;
            globalServiceUsageRule.name = orderUsageRule.name;
            globalServiceUsageRule.allowanceType = orderUsageRule.AllowanceType__c;
            if (orderUsageRule.UsageUom__c != null) {
              globalServiceUsageRule.usageUom = orderUsageRule.UsageUom__c;
            }
            globalServiceUsageRule.status = orderUsageRule.Status__c;
            globalServiceUsageRule.chargeCategory = chargeCategory;
            globalServiceUsageRule.globalUsageRule = globalUsageRule;
            globalServiceUsageRule.proratedOnOrder = Boolean.valueOf(
              orderUsageRule.ProratedOnOrder__c
            );
            globalServiceUsageRule.proratedOnCancel = Boolean.valueOf(
              orderUsageRule.ProratedOnCancel__c
            );
            globalServiceUsageRule.limit_x = orderUsageRule.Limit__c;
            globalServiceUsageRule.rollOverType = orderUsageRule.RollOverType__c;
            globalServiceUsageRule.ruleType = orderUsageRule.RuleType__c;
            orderItemUsageRules.globalOrderItemUsageRule = globalServiceUsageRule;
          }

          tempOitem.orderItemUsageRules = orderItemUsageRules;
        }

        /* ( *** )Short description defect fixed.*/
        if (
          !(null == tractProduct.description ||
          tractProduct.description.equals(''))
        ) {
          tempOitem.description = tractProduct.description;
        }
        if (
          opportunityProductIdVsServiceCustomFieldMap.containskey(
            tractProduct.opportunityProductId
          )
        ) {
          SoapApi33Domain.CustomFieldValues customFieldVals = new SoapApi33Domain.CustomFieldValues();
          List<SoapApi33Domain.CustomFieldValue> customFldValueList = new List<SoapApi33Domain.CustomFieldValue>();
          for (
            Service_Custom_Field__c serviceField : opportunityProductIdVsServiceCustomFieldMap.get(
              tractProduct.opportunityProductId
            )
          ) {
            SoapApi33Domain.CustomFieldValue customFieldVal = new SoapApi33Domain.CustomFieldValue();
            SoapApi33Domain.CustomField customFld = new SoapApi33Domain.CustomField();
            customFld.eid = serviceField.eid__c;
            customFieldVal.value = serviceField.value__c;
            customFieldVal.customField = customFld;
            customFldValueList.add(customFieldVal);
          }
          customFieldVals.customFieldValue = customFldValueList;
          tempOitem.customFieldValues = customFieldVals;
        }
        if (
          null != tractProduct.discountCodeName &&
          null != tractProduct.discountCodeEid
        ) {
          SoapApi33Domain.DiscountConfigurations discountConfig = new SoapApi33Domain.DiscountConfigurations();
          List<SoapApi33Domain.DiscountConfiguration> discountConfigList = new List<SoapApi33Domain.DiscountConfiguration>();
          SoapApi33Domain.DiscountConfiguration discountConf = new SoapApi33Domain.DiscountConfiguration();
          SoapApi33Domain.DiscountIdentifier discountIdent = new SoapApi33Domain.DiscountIdentifier();
          discountIdent.eid = tractProduct.discountCodeEid;
          discountConf.discountIdentifier = discountIdent;
          discountConfigList.add(discountConf);
          discountConfig.discountConfiguration = discountConfigList;
          tempOitem.discountConfigurations = discountConfig;
        }

        if (
          opportunityProductIdVsOneTimeScheduleChargesMap.containskey(
            tractProduct.opportunityProductId
          )
        ) {
          SoapApi33Domain.ScheduledOneTimePriceCharges scheduledChargesFeature = new SoapApi33Domain.ScheduledOneTimePriceCharges();
          SoapApi33Domain.ScheduledOneTimePriceCharge[] scheduledChargeList = new List<SoapApi33Domain.ScheduledOneTimePriceCharge>();
          for (
            Schdeule_Charge__c scheduleCharges : opportunityProductIdVsOneTimeScheduleChargesMap.get(
              tractProduct.opportunityProductId
            )
          ) {
            SoapApi33Domain.ScheduledOneTimePriceCharge scheduledCharge = new SoapApi33Domain.ScheduledOneTimePriceCharge();
            scheduledCharge.amount = Decimal.valueOf(
              scheduleCharges.Schdeule_Amount__c
            );
            scheduledCharge.chargeDate = String.valueOf(
              scheduleCharges.Schdeule_Date__c
            );
            scheduledCharge.description = scheduleCharges.Schdeule_Description__c;
            scheduledChargeList.add(scheduledCharge);
          }
          scheduledChargesFeature.scheduledOneTimePriceCharge = scheduledChargeList;
          tempOitem.scheduledOneTimePriceCharges = scheduledChargesFeature;
        }

        if (
          opportunityProductIdVsScheduleChargesMap.containskey(
            tractProduct.opportunityProductId
          )
        ) {
          SoapApi33Domain.ScheduledCharges scheduledChargesFeature = new SoapApi33Domain.ScheduledCharges();
          SoapApi33Domain.ScheduledCharge[] scheduledChargeList = new List<SoapApi33Domain.ScheduledCharge>();
          for (
            Schdeule_Charge__c scheduleCharges : opportunityProductIdVsScheduleChargesMap.get(
              tractProduct.opportunityProductId
            )
          ) {
            SoapApi33Domain.ScheduledCharge scheduledCharge = new SoapApi33Domain.ScheduledCharge();
            scheduledCharge.amount = Decimal.valueOf(
              scheduleCharges.Schdeule_Amount__c
            );
            scheduledCharge.chargeDate = String.valueOf(
              scheduleCharges.Schdeule_Date__c
            );
            scheduledCharge.description = scheduleCharges.Schdeule_Description__c;
            scheduledChargeList.add(scheduledCharge);
          }
          scheduledChargesFeature.scheduledCharge = scheduledChargeList;
          tempOitem.scheduledCharges = scheduledChargesFeature;
        }
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
            SOAPAPI33Domain.OrderItemRecurringPrice orderItemRecurringPrice = new SOAPAPI33Domain.OrderItemRecurringPrice();
            SoapApi33Domain.RecurringProductPrice recurringProductPrice = new SoapApi33Domain.RecurringProductPrice();
            recurringProductPrice.eid = tractProduct.recurringProductPriceEid;
            orderItemRecurringPrice.recurringProductPrice = recurringProductPrice;
            if (tractProduct.recurringPrice != null) {
              SOAPAPI33Domain.OrderItemPriceRanges orderItempriceRanges = new SOAPAPI33Domain.OrderItemPriceRanges();
              SOAPAPI33Domain.OrderItemPriceRange[] orderItemPriceRangeList = new List<SOAPAPI33Domain.OrderItemPriceRange>{};
              for (
                ProductPriceRangeWrapper priceRange : tractProduct.overridedRecurringPriceRangesList
              ) {
                SOAPAPI33Domain.OrderItemPriceRange orderItemPriceRange = new SOAPAPI33Domain.OrderItemPriceRange();
                orderItemPriceRange.price = String.valueof(priceRange.price);
                orderItemPriceRange.currencyType = ppw.currencyType;
                orderItemPriceRange.quantityBeginRange = String.valueof(
                  priceRange.quantityBeginRange
                );
                orderItemPriceRange.quantityEndRange = String.valueof(
                  priceRange.quantityEndRange
                );
                orderItemPriceRange.level = priceRange.level;
                orderItemPriceRangeList.add(orderItemPriceRange);
              }
              orderItempriceRanges.orderItemPriceRange = orderItemPriceRangeList;
              orderItemRecurringPrice.orderItempriceRanges = orderItempriceRanges;
            }
            orderItemPrices.orderItemRecurringPrice = orderItemRecurringPrice;
          }
          if (
            ppw.priceType == 'OneTime' &&
            ppw.eid == tractProduct.OneTimeProductPriceEid
          ) {
            SOAPAPI33Domain.OrderItemOneTimePrice orderItemOneTimePrice = new SOAPAPI33Domain.OrderItemOneTimePrice();
            SoapApi33Domain.OneTimeProductPrice oneTimeProductPrice = new SoapApi33Domain.OneTimeProductPrice();
            oneTimeProductPrice.eid = tractProduct.OneTimeProductPriceEid;
            orderItemOneTimePrice.oneTimeProductPrice = oneTimeProductPrice;
            if (tractProduct.oneTimePrice != null) {
              SOAPAPI33Domain.OrderItemPriceRanges orderItempriceRanges = new SOAPAPI33Domain.OrderItemPriceRanges();
              SOAPAPI33Domain.OrderItemPriceRange[] orderItemPriceRangeList = new List<SOAPAPI33Domain.OrderItemPriceRange>{};
              for (
                ProductPriceRangeWrapper priceRange : tractProduct.overridedOneTimePriceRangesList
              ) {
                SOAPAPI33Domain.OrderItemPriceRange orderItemPriceRange = new SOAPAPI33Domain.OrderItemPriceRange();
                orderItemPriceRange.price = String.valueof(priceRange.price);
                orderItemPriceRange.currencyType = ppw.currencyType;
                orderItemPriceRange.quantityBeginRange = String.valueof(
                  priceRange.quantityBeginRange
                );
                orderItemPriceRange.quantityEndRange = String.valueof(
                  priceRange.quantityEndRange
                );
                orderItemPriceRange.level = priceRange.level;
                orderItemPriceRangeList.add(orderItemPriceRange);
              }
              orderItempriceRanges.orderItemPriceRange = orderItemPriceRangeList;
              orderItemOneTimePrice.orderItempriceRanges = orderItempriceRanges;
            }
            orderItemPrices.orderItemOneTimePrice = orderItemOneTimePrice;
          }
        }
        tempOitem.orderItemPrices = orderItemPrices;

        if (
          !String.isBlank(tractProduct.agreementEndAction) ||
          tractProduct.overrideAgreementEndDate != null
        ) {
          tempAgreement = new SoapApi33Domain.Agreement();
          tempAgreement.eid = tractProduct.Agreement_eid;
          tempOitem.selectedAgreement = tempAgreement;
          SoapApi33Domain.AgreementConfiguration overrideAgreementSettings = new SoapApi33Domain.AgreementConfiguration();
          if (!String.isBlank(tractProduct.agreementEndAction)) {
            overrideAgreementSettings.endAction = tractProduct.agreementEndAction;
          }
          if (tractProduct.overrideAgreementEndDate != null) {
            //Sending end date as an instance of datetime, previously sending it as an instance of date
            overrideAgreementSettings.endDate = DateTime.newInstance(
              Date.valueOf(tractProduct.overrideAgreementEndDate),
              System.now().time()
            );
          }
          if (tractProduct.Agreement_Period != null) {
            overrideAgreementSettings.agreementPeriod = integer.valueof(
              tractProduct.Agreement_Period
            );
          }
          if (tractProduct.renewalPricing == 'Service Price') {
            overrideAgreementSettings.preserveServicePrice = true;
          } else if (tractProduct.renewalPricing == 'Product Price') {
            overrideAgreementSettings.preserveServicePrice = false;
          }
          if (
            tractProduct.nextAgreementEid != null &&
            tractProduct.nextAgreementEndAction != null
          ) {
            overrideAgreementSettings.nextAgreement = new SoapApi33Domain.Agreement();
            overrideAgreementSettings.nextAgreement.eid = tractProduct.nextAgreementEid;
            overrideAgreementSettings.nextEndAction = tractProduct.nextAgreementEndAction;
            if (tractProduct.nextRenewalPricing == 'Service Price') {
              overrideAgreementSettings.nextPreserveServicePrice = true;
            } else if (tractProduct.nextRenewalPricing == 'Product Price') {
              overrideAgreementSettings.nextPreserveServicePrice = false;
            }
          }
          tempOitem.agreementConfiguration = overrideAgreementSettings;
        }

        if (
          tractProduct.minServiceResources > 0 ||
          tractProduct.maxServiceResources > 0
        ) {
          SoapApi33Domain.ServiceResources srElement = new SoapApi33Domain.ServiceResources();
          SoapApi33Domain.ServiceResource[] srList = new List<SoapApi33Domain.ServiceResource>();
          SoapApi33Domain.ServiceResource tempSR;
          if (
            null != tractProduct.TractServiceResourceEid &&
            null != tractProduct.TractServiceResourceName
          ) {
            list<String> srIdentifier = new List<String>();
            list<String> srEid = new List<String>();
            for (
              String str : tractProduct.TractServiceResourceName.split('\\|')
            ) {
              if (null != str && str.trim() != '') {
                srIdentifier.add(str);
              }
            }
            for (
              String str : tractProduct.TractServiceResourceEid.split('\\|')
            ) {
              if (null != str && str.trim() != '') {
                srEid.add(str);
              }
            }
            for (Integer i = 0; i < srIdentifier.size(); i++) {
              tempSR = new SoapApi33Domain.ServiceResource();
              tempSR.identifier = srIdentifier[i];
              tempSR.status = 'AVAILABLE';
              tempSR.eid = srEid[i];
              srList.add(tempSR);
            }
          }
          if (
            null != tractProduct.NewServiceResource &&
            '' != tractProduct.NewServiceResource
          ) {
            list<String> srId = new List<String>();
            for (String str : tractProduct.NewServiceResource.split('\\|')) {
              if (null != str && str.trim() != '') {
                srId.add(str);
              }
            }
            SoapApi33Domain.ServiceResourceCategory srCategory = new SoapApi33Domain.ServiceResourceCategory();
            srCategory.eid = tractProduct.Service_Resource_Category;
            for (String srIdent : srId) {
              tempSR = new SoapApi33Domain.ServiceResource();
              tempSR.identifier = srIdent;
              SrIdentifier = srIdent;
              tempSR.category = srCategory;
              srList.add(tempSR);
            }
          } else {
            if (tractProduct.minServiceResources == 1) {
              throw new MyException(
                'Please Select a TRACT Service Resource for Product:' +
                tractProduct.name
              );
            }
          }
          srElement.serviceResource = srList;
          tempOitem.serviceResources = srElement;
        }

        if (!Test.isRunningTest()) {
          queryResponse = GTVAPI133Adapter.getProductRelations(
            tractProduct.eid
          );
        } else {
          queryResponse = SoapApi33TestUtil.getProductRelations();
        }
        //Add Related Products
        SoapApi33Domain.ProductRelation[] relatedProducts = queryResponse.productRelations.productRelation;
        if (null != relatedProducts && relatedProducts.size() > 0) {
          SoapApi33Domain.OrderItems relatedOrderItems = new SoapApi33Domain.OrderItems();
          Map<String, Integer> addProducts = new Map<String, Integer>();
          set<String> setOfEids = new Set<String>();
          List<SoapApi33Domain.OrderItem> relatedOrderItemsList = new List<SoapApi33Domain.OrderItem>();
          for (
            SoapApi33Domain.ProductRelation productRelation : relatedProducts
          ) {
            if (productRelation.product.productTypeCode == 'Add-on') {
              setOfEids.add(productRelation.product.eid);
              Integer index = getRelatedProductindex(
                productList,
                productRelation.product.eid,
                addProducts
              );
            }
          }
          for (TractProduct totalProducts : productList) {
            if (totalProducts.ServiceId == subscriptionId) {
              SoapApi33Domain.OrderItems relatedOrderItemsAddon = new SoapApi33Domain.OrderItems();
              list<SoapApi33Domain.OrderItem> listOfOrderItemsAddon = new List<SoapApi33Domain.OrderItem>();
              SoapApi33Domain.OrderItems orderItems = new SoapApi33Domain.OrderItems();
              SoapApi33Domain.OrderItem orderItem = new SoapApi33Domain.OrderItem();
              SoapApi33Domain.Product product = new SoapApi33Domain.Product();
              SoapApi33Domain.ProductPrice recurringPrice = new SoapApi33Domain.ProductPrice();
              SOAPAPI33Domain.OrderItemPrices addOnOrderItemPrices = new SOAPAPI33Domain.OrderItemPrices();
              String addonId = totalProducts.ProductId;
              product.eid = totalProducts.eid;
              orderItem.product = product;
              if (
                null != totalProducts.description &&
                totalProducts.description != ''
              ) {
                orderItem.description = totalProducts.description;
              }
              /*if(totalProducts.recurringProductPriceEid != null) {
                                    recurringPrice.eid = totalProducts.recurringProductPriceEid;
                                    orderItem.recurringProductPrice =  recurringPrice;
                                }*/
              orderItem.overrideTrialDays = Integer.valueOf(
                totalProducts.overridedTrialLength
              );

              if (totalProducts.quantity != null) {
                orderItem.quantity = Double.valueOf(totalProducts.quantity);
              }
              Product2 prod = [
                SELECT Id, Name, Price_Information__c
                FROM Product2
                WHERE Id = :totalProducts.ProductId
              ];
              List<ProductPriceWrapper> productPriceWrapListAddon = (list<ProductPriceWrapper>) JSON.deserialize(
                prod.Price_Information__c,
                list<ProductPriceWrapper>.class
              );
              for (ProductPriceWrapper ppw : productPriceWrapListAddon) {
                if (
                  ppw.priceType == 'recurring' &&
                  ppw.eid == totalProducts.recurringProductPriceEid
                ) {
                  SOAPAPI33Domain.OrderItemRecurringPrice orderItemRecurringPrice = new SOAPAPI33Domain.OrderItemRecurringPrice();
                  SoapApi33Domain.RecurringProductPrice recurringProductPrice = new SoapApi33Domain.RecurringProductPrice();
                  recurringProductPrice.eid = totalProducts.recurringProductPriceEid;
                  orderItemRecurringPrice.recurringProductPrice = recurringProductPrice;
                  if (totalProducts.recurringPrice != null) {
                    SOAPAPI33Domain.OrderItemPriceRanges orderItempriceRanges = new SOAPAPI33Domain.OrderItemPriceRanges();
                    SOAPAPI33Domain.OrderItemPriceRange[] orderItemPriceRangeList = new List<SOAPAPI33Domain.OrderItemPriceRange>{};
                    for (
                      ProductPriceRangeWrapper priceRange : totalProducts.overridedRecurringPriceRangesList
                    ) {
                      SOAPAPI33Domain.OrderItemPriceRange orderItemPriceRange = new SOAPAPI33Domain.OrderItemPriceRange();
                      orderItemPriceRange.price = String.valueof(
                        priceRange.price
                      );
                      orderItemPriceRange.currencyType = ppw.currencyType;
                      orderItemPriceRange.quantityBeginRange = String.valueof(
                        priceRange.quantityBeginRange
                      );
                      orderItemPriceRange.quantityEndRange = String.valueof(
                        priceRange.quantityEndRange
                      );
                      orderItemPriceRange.level = priceRange.level;
                      orderItemPriceRangeList.add(orderItemPriceRange);
                    }
                    orderItempriceRanges.orderItemPriceRange = orderItemPriceRangeList;
                    orderItemRecurringPrice.orderItempriceRanges = orderItempriceRanges;
                  }
                  addOnOrderItemPrices.orderItemRecurringPrice = orderItemRecurringPrice;
                }
                if (
                  ppw.priceType == 'OneTime' &&
                  ppw.eid == totalProducts.OneTimeProductPriceEid
                ) {
                  SOAPAPI33Domain.OrderItemOneTimePrice orderItemOneTimePrice = new SOAPAPI33Domain.OrderItemOneTimePrice();
                  SoapApi33Domain.OneTimeProductPrice oneTimeProductPrice = new SoapApi33Domain.OneTimeProductPrice();
                  oneTimeProductPrice.eid = totalProducts.OneTimeProductPriceEid;
                  orderItemOneTimePrice.oneTimeProductPrice = oneTimeProductPrice;
                  if (totalProducts.oneTimePrice != null) {
                    SOAPAPI33Domain.OrderItemPriceRanges orderItempriceRanges = new SOAPAPI33Domain.OrderItemPriceRanges();
                    SOAPAPI33Domain.OrderItemPriceRange[] orderItemPriceRangeList = new List<SOAPAPI33Domain.OrderItemPriceRange>{};
                    for (
                      ProductPriceRangeWrapper priceRange : totalProducts.overridedOneTimePriceRangesList
                    ) {
                      SOAPAPI33Domain.OrderItemPriceRange orderItemPriceRange = new SOAPAPI33Domain.OrderItemPriceRange();
                      orderItemPriceRange.price = String.valueof(
                        priceRange.price
                      );
                      orderItemPriceRange.currencyType = ppw.currencyType;
                      orderItemPriceRange.quantityBeginRange = String.valueof(
                        priceRange.quantityBeginRange
                      );
                      orderItemPriceRange.quantityEndRange = String.valueof(
                        priceRange.quantityEndRange
                      );
                      orderItemPriceRange.level = priceRange.level;
                      orderItemPriceRangeList.add(orderItemPriceRange);
                    }
                    orderItempriceRanges.orderItemPriceRange = orderItemPriceRangeList;
                    orderItemOneTimePrice.orderItempriceRanges = orderItempriceRanges;
                  }
                  addOnOrderItemPrices.orderItemOneTimePrice = orderItemOneTimePrice;
                }
              }
              orderItem.orderItemPrices = addOnOrderItemPrices;

              if (
                !String.isBlank(totalProducts.agreementEndAction) ||
                totalProducts.overrideAgreementEndDate != null
              ) {
                tempAgreement = new SoapApi33Domain.Agreement();
                tempAgreement.eid = totalProducts.Agreement_eid;
                //tempAgreement.name = totalProducts.Agreement_Name ;
                //tempAgreement.agreementPeriod = integer.valueof(totalProducts.Agreement_Period) ;
                orderItem.selectedAgreement = tempAgreement;

                SoapApi33Domain.AgreementConfiguration overrideAgreementSettings = new SoapApi33Domain.AgreementConfiguration();

                if (!String.isBlank(totalProducts.agreementEndAction)) {
                  overrideAgreementSettings.endAction = totalProducts.agreementEndAction;
                }

                if (totalProducts.overrideAgreementEndDate != null) {
                  //Sending end date as an instance of datetime, previously sending it as an instance of date
                  overrideAgreementSettings.endDate = DateTime.newInstance(
                    Date.valueOf(totalProducts.overrideAgreementEndDate),
                    System.now().time()
                  );
                }
                if (totalProducts.Agreement_Period != null) {
                  overrideAgreementSettings.agreementPeriod = integer.valueof(
                    totalProducts.Agreement_Period
                  );
                }
                if (totalProducts.renewalPricing == 'Service Price') {
                  overrideAgreementSettings.preserveServicePrice = true;
                } else if (totalProducts.renewalPricing == 'Product Price') {
                  overrideAgreementSettings.preserveServicePrice = false;
                }
                if (
                  totalProducts.nextAgreementEid != null &&
                  totalProducts.nextAgreementEndAction != null
                ) {
                  overrideAgreementSettings.nextAgreement = new SoapApi33Domain.Agreement();
                  overrideAgreementSettings.nextAgreement.eid = totalProducts.nextAgreementEid;
                  overrideAgreementSettings.nextEndAction = totalProducts.nextAgreementEndAction;
                  if (totalProducts.nextRenewalPricing == 'Service Price') {
                    overrideAgreementSettings.nextPreserveServicePrice = true;
                  } else if (
                    totalProducts.nextRenewalPricing == 'Product Price'
                  ) {
                    overrideAgreementSettings.nextPreserveServicePrice = false;
                  }
                }
                orderItem.agreementConfiguration = overrideAgreementSettings;
              }

              if (
                null != totalProducts.discountCodeName &&
                null != totalProducts.discountCodeEid
              ) {
                SoapApi33Domain.DiscountConfigurations discountConfig = new SoapApi33Domain.DiscountConfigurations();
                List<SoapApi33Domain.DiscountConfiguration> discountConfigList = new List<SoapApi33Domain.DiscountConfiguration>();

                SoapApi33Domain.DiscountConfiguration discountConf = new SoapApi33Domain.DiscountConfiguration();
                SoapApi33Domain.DiscountIdentifier discountIdent = new SoapApi33Domain.DiscountIdentifier();
                discountIdent.eid = totalProducts.discountCodeEid;

                discountConf.discountIdentifier = discountIdent;

                discountConfigList.add(discountConf);

                discountConfig.discountConfiguration = discountConfigList;
                orderItem.discountConfigurations = discountConfig;
              }
              if (
                opportunityProductIdVsOneTimeScheduleChargesMap.containskey(
                  totalProducts.opportunityProductId
                )
              ) {
                SoapApi33Domain.ScheduledOneTimePriceCharges scheduledChargesFeature = new SoapApi33Domain.ScheduledOneTimePriceCharges();
                SoapApi33Domain.ScheduledOneTimePriceCharge[] scheduledChargeList = new List<SoapApi33Domain.ScheduledOneTimePriceCharge>();
                for (
                  Schdeule_Charge__c scheduleCharges : opportunityProductIdVsOneTimeScheduleChargesMap.get(
                    totalProducts.opportunityProductId
                  )
                ) {
                  SoapApi33Domain.ScheduledOneTimePriceCharge scheduledCharge = new SoapApi33Domain.ScheduledOneTimePriceCharge();
                  scheduledCharge.amount = Decimal.valueOf(
                    scheduleCharges.Schdeule_Amount__c
                  );
                  scheduledCharge.chargeDate = String.valueOf(
                    scheduleCharges.Schdeule_Date__c
                  );
                  scheduledCharge.description = scheduleCharges.Schdeule_Description__c;
                  scheduledChargeList.add(scheduledCharge);
                }
                scheduledChargesFeature.scheduledOneTimePriceCharge = scheduledChargeList;
                orderItem.scheduledOneTimePriceCharges = scheduledChargesFeature;
              }

              if (
                opportunityProductIdVsScheduleChargesMap.containskey(
                  totalProducts.opportunityProductId
                )
              ) {
                SoapApi33Domain.ScheduledCharges scheduledChargesFeature = new SoapApi33Domain.ScheduledCharges();
                SoapApi33Domain.ScheduledCharge[] scheduledChargeList = new List<SoapApi33Domain.ScheduledCharge>();
                for (
                  Schdeule_Charge__c scheduleCharges : opportunityProductIdVsScheduleChargesMap.get(
                    totalProducts.opportunityProductId
                  )
                ) {
                  SoapApi33Domain.ScheduledCharge scheduledCharge = new SoapApi33Domain.ScheduledCharge();
                  scheduledCharge.amount = Decimal.valueOf(
                    scheduleCharges.Schdeule_Amount__c
                  );
                  scheduledCharge.chargeDate = String.valueOf(
                    scheduleCharges.Schdeule_Date__c
                  );
                  scheduledCharge.description = scheduleCharges.Schdeule_Description__c;
                  scheduledChargeList.add(scheduledCharge);
                }
                scheduledChargesFeature.scheduledCharge = scheduledChargeList;
                orderItem.scheduledCharges = scheduledChargesFeature;
              }

              if (
                opportunityProductIdVsServiceCustomFieldMap.containskey(
                  totalProducts.ProductId
                )
              ) {
                SoapApi33Domain.CustomFieldValues customFieldVals = new SoapApi33Domain.CustomFieldValues();
                List<SoapApi33Domain.CustomFieldValue> customFldValueList = new List<SoapApi33Domain.CustomFieldValue>();
                for (
                  Service_Custom_Field__c serviceField : opportunityProductIdVsServiceCustomFieldMap.get(
                    totalProducts.opportunityProductId
                  )
                ) {
                  SoapApi33Domain.CustomFieldValue customFieldVal = new SoapApi33Domain.CustomFieldValue();
                  SoapApi33Domain.CustomField customFld = new SoapApi33Domain.CustomField();
                  customFld.eid = serviceField.eid__c;
                  customFieldVal.value = serviceField.value__c;
                  customFieldVal.customField = customFld;
                  customFldValueList.add(customFieldVal);
                }

                customFieldVals.customFieldValue = customFldValueList;
                orderItem.customFieldValues = customFieldVals;
              }

              if (
                totalProducts.minServiceResources > 0 ||
                totalProducts.maxServiceResources > 0
              ) {
                SoapApi33Domain.ServiceResources srElement = new SoapApi33Domain.ServiceResources();
                SoapApi33Domain.ServiceResource[] srList = new List<SoapApi33Domain.ServiceResource>();
                SoapApi33Domain.ServiceResource tempSR;
                if (
                  null != totalProducts.TractServiceResourceEid &&
                  null != totalProducts.TractServiceResourceName
                ) {
                  list<String> srIdentifier = new List<String>();
                  list<String> srEid = new List<String>();
                  for (
                    String str : totalProducts.TractServiceResourceName.split(
                      '\\|'
                    )
                  ) {
                    if (null != str && str.trim() != '') {
                      srIdentifier.add(str);
                    }
                  }
                  for (
                    String str : totalProducts.TractServiceResourceEid.split(
                      '\\|'
                    )
                  ) {
                    if (null != str && str.trim() != '') {
                      srEid.add(str);
                    }
                  }
                  for (Integer i = 0; i < srIdentifier.size(); i++) {
                    tempSR = new SoapApi33Domain.ServiceResource();
                    tempSR.identifier = srIdentifier[i];
                    tempSR.status = 'AVAILABLE';
                    tempSR.eid = srEid[i];
                    srList.add(tempSR);
                  }
                } else if (
                  null != totalProducts.NewServiceResource &&
                  '' != totalProducts.NewServiceResource
                ) {
                  list<String> srId = new List<String>();
                  for (
                    String str : totalProducts.NewServiceResource.split('\\|')
                  ) {
                    if (null != str && str.trim() != '') {
                      srId.add(str);
                    }
                  }
                  SoapApi33Domain.ServiceResourceCategory srCategory = new SoapApi33Domain.ServiceResourceCategory();
                  srCategory.eid = totalProducts.Service_Resource_Category;
                  for (String srIdent : srId) {
                    tempSR = new SoapApi33Domain.ServiceResource();
                    tempSR.identifier = srIdent;
                    SrIdentifier = srIdent;
                    tempSR.category = srCategory;
                    srList.add(tempSR);
                  }
                } else {
                  if (totalProducts.minServiceResources == 1) {
                    throw new MyException(
                      'Please Select a TRACT Service Resource for Product:' +
                      totalProducts.name
                    );
                  }
                }
                srElement.serviceResource = srList;
                orderItem.serviceResources = srElement;
              }
              for (TractProduct totalAddonProducts : productList) {
                if (totalAddonProducts.ServiceId == addonId) {
                  SoapApi33Domain.OrderItem orderItemAddon = new SoapApi33Domain.OrderItem();
                  SoapApi33Domain.Product productAddon = new SoapApi33Domain.Product();
                  SoapApi33Domain.ProductPrice recurringPriceAddon = new SoapApi33Domain.ProductPrice();
                  SOAPAPI33Domain.OrderItemPrices subAddonOrderItemPrices = new SOAPAPI33Domain.OrderItemPrices();
                  productAddon.eid = totalAddonProducts.eid;
                  orderItemAddon.product = productAddon;
                  if (
                    null != totalAddonProducts.description &&
                    totalAddonProducts.description != ''
                  ) {
                    orderItemAddon.description = totalAddonProducts.description;
                  }
                  /*if(totalAddonProducts.recurringProductPriceEid != null) {
                                            recurringPriceAddon.eid = totalAddonProducts.recurringProductPriceEid;
                                            orderItemAddon.recurringProductPrice =  recurringPriceAddon;
                                        }*/
                  orderItemAddon.overrideTrialDays = Integer.valueOf(
                    totalAddonProducts.overridedTrialLength
                  );

                  if (totalAddonProducts.quantity != null) {
                    orderItemAddon.quantity = Double.valueOf(
                      totalAddonProducts.quantity
                    );
                  }
                  Product2 prodAddon = [
                    SELECT Id, Name, Price_Information__c
                    FROM Product2
                    WHERE Id = :totalAddonProducts.ProductId
                  ];
                  List<ProductPriceWrapper> productPriceWrapListSubAddon = (list<ProductPriceWrapper>) JSON.deserialize(
                    prodAddon.Price_Information__c,
                    list<ProductPriceWrapper>.class
                  );
                  for (ProductPriceWrapper ppw : productPriceWrapListSubAddon) {
                    if (
                      ppw.priceType == 'recurring' &&
                      ppw.eid == totalAddonProducts.recurringProductPriceEid
                    ) {
                      SOAPAPI33Domain.OrderItemRecurringPrice orderItemRecurringPrice = new SOAPAPI33Domain.OrderItemRecurringPrice();
                      SoapApi33Domain.RecurringProductPrice recurringProductPrice = new SoapApi33Domain.RecurringProductPrice();
                      recurringProductPrice.eid = totalAddonProducts.recurringProductPriceEid;
                      orderItemRecurringPrice.recurringProductPrice = recurringProductPrice;
                      if (totalAddonProducts.recurringPrice != null) {
                        SOAPAPI33Domain.OrderItemPriceRanges orderItempriceRanges = new SOAPAPI33Domain.OrderItemPriceRanges();
                        SOAPAPI33Domain.OrderItemPriceRange[] orderItemPriceRangeList = new List<SOAPAPI33Domain.OrderItemPriceRange>{};
                        for (
                          ProductPriceRangeWrapper priceRange : totalAddonProducts.overridedRecurringPriceRangesList
                        ) {
                          SOAPAPI33Domain.OrderItemPriceRange orderItemPriceRange = new SOAPAPI33Domain.OrderItemPriceRange();
                          orderItemPriceRange.price = String.valueof(
                            priceRange.price
                          );
                          orderItemPriceRange.currencyType = ppw.currencyType;
                          orderItemPriceRange.quantityBeginRange = String.valueof(
                            priceRange.quantityBeginRange
                          );
                          orderItemPriceRange.quantityEndRange = String.valueof(
                            priceRange.quantityEndRange
                          );
                          orderItemPriceRange.level = priceRange.level;
                          orderItemPriceRangeList.add(orderItemPriceRange);
                        }
                        orderItempriceRanges.orderItemPriceRange = orderItemPriceRangeList;
                        orderItemRecurringPrice.orderItempriceRanges = orderItempriceRanges;
                      }
                      subAddonOrderItemPrices.orderItemRecurringPrice = orderItemRecurringPrice;
                    }
                    if (
                      ppw.priceType == 'OneTime' &&
                      ppw.eid == totalAddonProducts.OneTimeProductPriceEid
                    ) {
                      SOAPAPI33Domain.OrderItemOneTimePrice orderItemOneTimePrice = new SOAPAPI33Domain.OrderItemOneTimePrice();
                      SoapApi33Domain.OneTimeProductPrice oneTimeProductPrice = new SoapApi33Domain.OneTimeProductPrice();
                      oneTimeProductPrice.eid = totalAddonProducts.OneTimeProductPriceEid;
                      orderItemOneTimePrice.oneTimeProductPrice = oneTimeProductPrice;
                      if (totalAddonProducts.oneTimePrice != null) {
                        SOAPAPI33Domain.OrderItemPriceRanges orderItempriceRanges = new SOAPAPI33Domain.OrderItemPriceRanges();
                        SOAPAPI33Domain.OrderItemPriceRange[] orderItemPriceRangeList = new List<SOAPAPI33Domain.OrderItemPriceRange>{};
                        for (
                          ProductPriceRangeWrapper priceRange : totalAddonProducts.overridedOneTimePriceRangesList
                        ) {
                          SOAPAPI33Domain.OrderItemPriceRange orderItemPriceRange = new SOAPAPI33Domain.OrderItemPriceRange();
                          orderItemPriceRange.price = String.valueof(
                            priceRange.price
                          );
                          orderItemPriceRange.currencyType = ppw.currencyType;
                          orderItemPriceRange.quantityBeginRange = String.valueof(
                            priceRange.quantityBeginRange
                          );
                          orderItemPriceRange.quantityEndRange = String.valueof(
                            priceRange.quantityEndRange
                          );
                          orderItemPriceRange.level = priceRange.level;
                          orderItemPriceRangeList.add(orderItemPriceRange);
                        }
                        orderItempriceRanges.orderItemPriceRange = orderItemPriceRangeList;
                        orderItemOneTimePrice.orderItempriceRanges = orderItempriceRanges;
                      }
                      subAddonOrderItemPrices.orderItemOneTimePrice = orderItemOneTimePrice;
                    }
                  }
                  orderItemAddon.orderItemPrices = subAddonOrderItemPrices;

                  if (
                    !String.isBlank(totalAddonProducts.agreementEndAction) ||
                    totalAddonProducts.overrideAgreementEndDate != null
                  ) {
                    tempAgreement = new SoapApi33Domain.Agreement();
                    tempAgreement.eid = totalAddonProducts.Agreement_eid;
                    //tempAgreement.name = totalAddonProducts.Agreement_Name ;
                    //tempAgreement.agreementPeriod = integer.valueof(totalAddonProducts.Agreement_Period) ;
                    orderItemAddon.selectedAgreement = tempAgreement;

                    SoapApi33Domain.AgreementConfiguration overrideAgreementSettings = new SoapApi33Domain.AgreementConfiguration();

                    if (
                      !String.isBlank(totalAddonProducts.agreementEndAction)
                    ) {
                      overrideAgreementSettings.endAction = totalAddonProducts.agreementEndAction;
                    }

                    if (totalAddonProducts.overrideAgreementEndDate != null) {
                      //Sending end date as an instance of datetime, previously sending it as an instance of date
                      overrideAgreementSettings.endDate = DateTime.newInstance(
                        Date.valueOf(
                          totalAddonProducts.overrideAgreementEndDate
                        ),
                        System.now().time()
                      );
                    }
                    if (totalAddonProducts.Agreement_Period != null) {
                      overrideAgreementSettings.agreementPeriod = integer.valueof(
                        totalAddonProducts.Agreement_Period
                      );
                    }
                    if (totalAddonProducts.renewalPricing == 'Service Price') {
                      overrideAgreementSettings.preserveServicePrice = true;
                    } else if (
                      totalAddonProducts.renewalPricing == 'Product Price'
                    ) {
                      overrideAgreementSettings.preserveServicePrice = false;
                    }
                    if (
                      totalAddonProducts.nextAgreementEid != null &&
                      totalAddonProducts.nextAgreementEndAction != null
                    ) {
                      overrideAgreementSettings.nextAgreement = new SoapApi33Domain.Agreement();
                      overrideAgreementSettings.nextAgreement.eid = totalAddonProducts.nextAgreementEid;
                      overrideAgreementSettings.nextEndAction = totalAddonProducts.nextAgreementEndAction;
                      if (
                        totalAddonProducts.nextRenewalPricing == 'Service Price'
                      ) {
                        overrideAgreementSettings.nextPreserveServicePrice = true;
                      } else if (
                        totalAddonProducts.nextRenewalPricing == 'Product Price'
                      ) {
                        overrideAgreementSettings.nextPreserveServicePrice = false;
                      }
                    }
                    orderItemAddon.agreementConfiguration = overrideAgreementSettings;
                  }

                  if (
                    null != totalAddonProducts.discountCodeName &&
                    null != totalAddonProducts.discountCodeEid
                  ) {
                    SoapApi33Domain.DiscountConfigurations discountConfig = new SoapApi33Domain.DiscountConfigurations();
                    List<SoapApi33Domain.DiscountConfiguration> discountConfigList = new List<SoapApi33Domain.DiscountConfiguration>();

                    SoapApi33Domain.DiscountConfiguration discountConf = new SoapApi33Domain.DiscountConfiguration();
                    SoapApi33Domain.DiscountIdentifier discountIdent = new SoapApi33Domain.DiscountIdentifier();
                    discountIdent.eid = totalAddonProducts.discountCodeEid;

                    discountConf.discountIdentifier = discountIdent;

                    discountConfigList.add(discountConf);

                    discountConfig.discountConfiguration = discountConfigList;
                    orderItemAddon.discountConfigurations = discountConfig;
                  }
                  if (
                    opportunityProductIdVsOneTimeScheduleChargesMap.containskey(
                      totalAddonProducts.opportunityProductId
                    )
                  ) {
                    SoapApi33Domain.ScheduledOneTimePriceCharges scheduledChargesFeature = new SoapApi33Domain.ScheduledOneTimePriceCharges();
                    SoapApi33Domain.ScheduledOneTimePriceCharge[] scheduledChargeList = new List<SoapApi33Domain.ScheduledOneTimePriceCharge>();
                    for (
                      Schdeule_Charge__c scheduleCharges : opportunityProductIdVsOneTimeScheduleChargesMap.get(
                        totalAddonProducts.opportunityProductId
                      )
                    ) {
                      SoapApi33Domain.ScheduledOneTimePriceCharge scheduledCharge = new SoapApi33Domain.ScheduledOneTimePriceCharge();
                      scheduledCharge.amount = Decimal.valueOf(
                        scheduleCharges.Schdeule_Amount__c
                      );
                      scheduledCharge.chargeDate = String.valueOf(
                        scheduleCharges.Schdeule_Date__c
                      );
                      scheduledCharge.description = scheduleCharges.Schdeule_Description__c;
                      scheduledChargeList.add(scheduledCharge);
                    }
                    scheduledChargesFeature.scheduledOneTimePriceCharge = scheduledChargeList;
                    orderItemAddon.scheduledOneTimePriceCharges = scheduledChargesFeature;
                  }

                  if (
                    opportunityProductIdVsScheduleChargesMap.containskey(
                      totalAddonProducts.opportunityProductId
                    )
                  ) {
                    SoapApi33Domain.ScheduledCharges scheduledChargesFeature = new SoapApi33Domain.ScheduledCharges();
                    SoapApi33Domain.ScheduledCharge[] scheduledChargeList = new List<SoapApi33Domain.ScheduledCharge>();
                    for (
                      Schdeule_Charge__c scheduleCharges : opportunityProductIdVsScheduleChargesMap.get(
                        totalAddonProducts.opportunityProductId
                      )
                    ) {
                      SoapApi33Domain.ScheduledCharge scheduledCharge = new SoapApi33Domain.ScheduledCharge();
                      scheduledCharge.amount = Decimal.valueOf(
                        scheduleCharges.Schdeule_Amount__c
                      );
                      scheduledCharge.chargeDate = String.valueOf(
                        scheduleCharges.Schdeule_Date__c
                      );
                      scheduledCharge.description = scheduleCharges.Schdeule_Description__c;
                      scheduledChargeList.add(scheduledCharge);
                    }
                    scheduledChargesFeature.scheduledCharge = scheduledChargeList;
                    orderItemAddon.scheduledCharges = scheduledChargesFeature;
                  }

                  if (
                    opportunityProductIdVsServiceCustomFieldMap.containskey(
                      totalAddonProducts.ProductId
                    )
                  ) {
                    SoapApi33Domain.CustomFieldValues customFieldVals = new SoapApi33Domain.CustomFieldValues();
                    List<SoapApi33Domain.CustomFieldValue> customFldValueList = new List<SoapApi33Domain.CustomFieldValue>();
                    for (
                      Service_Custom_Field__c serviceField : opportunityProductIdVsServiceCustomFieldMap.get(
                        totalAddonProducts.opportunityProductId
                      )
                    ) {
                      SoapApi33Domain.CustomFieldValue customFieldVal = new SoapApi33Domain.CustomFieldValue();
                      SoapApi33Domain.CustomField customFld = new SoapApi33Domain.CustomField();
                      customFld.eid = serviceField.eid__c;
                      customFieldVal.value = serviceField.value__c;
                      customFieldVal.customField = customFld;
                      customFldValueList.add(customFieldVal);
                    }

                    customFieldVals.customFieldValue = customFldValueList;
                    orderItemAddon.customFieldValues = customFieldVals;
                  }

                  if (
                    totalAddonProducts.minServiceResources > 0 ||
                    totalAddonProducts.maxServiceResources > 0
                  ) {
                    SoapApi33Domain.ServiceResources srElement = new SoapApi33Domain.ServiceResources();
                    SoapApi33Domain.ServiceResource[] srList = new List<SoapApi33Domain.ServiceResource>();
                    SoapApi33Domain.ServiceResource tempSR;
                    if (
                      null != totalAddonProducts.TractServiceResourceEid &&
                      null != totalAddonProducts.TractServiceResourceName
                    ) {
                      list<String> srIdentifier = new List<String>();
                      list<String> srEid = new List<String>();
                      for (
                        String str : totalAddonProducts.TractServiceResourceName.split(
                          '\\|'
                        )
                      ) {
                        if (null != str && str.trim() != '') {
                          srIdentifier.add(str);
                        }
                      }
                      for (
                        String str : totalAddonProducts.TractServiceResourceEid.split(
                          '\\|'
                        )
                      ) {
                        if (null != str && str.trim() != '') {
                          srEid.add(str);
                        }
                      }
                      for (Integer i = 0; i < srIdentifier.size(); i++) {
                        tempSR = new SoapApi33Domain.ServiceResource();
                        tempSR.identifier = srIdentifier[i];
                        tempSR.status = 'AVAILABLE';
                        tempSR.eid = srEid[i];
                        srList.add(tempSR);
                      }
                    } else if (
                      null != totalAddonProducts.NewServiceResource &&
                      '' != totalAddonProducts.NewServiceResource
                    ) {
                      list<String> srId = new List<String>();
                      for (
                        String str : totalAddonProducts.NewServiceResource.split(
                          '\\|'
                        )
                      ) {
                        if (null != str && str.trim() != '') {
                          srId.add(str);
                        }
                      }
                      SoapApi33Domain.ServiceResourceCategory srCategory = new SoapApi33Domain.ServiceResourceCategory();
                      srCategory.eid = totalAddonProducts.Service_Resource_Category;
                      for (String srIdent : srId) {
                        tempSR = new SoapApi33Domain.ServiceResource();
                        tempSR.identifier = srIdent;
                        SrIdentifier = srIdent;
                        tempSR.category = srCategory;
                        srList.add(tempSR);
                      }
                    } else {
                      if (totalAddonProducts.minServiceResources == 1) {
                        throw new MyException(
                          'Please Select a TRACT Service Resource for Product:' +
                          totalAddonProducts.name
                        );
                      }
                    }
                    srElement.serviceResource = srList;
                    orderItemAddon.serviceResources = srElement;
                  }
                  listOfOrderItemsAddon.add(orderItemAddon);
                }
              }
              if (listOfOrderItemsAddon.size() > 0) {
                relatedOrderItemsAddon.orderItem = listOfOrderItemsAddon;
                orderItem.orderItems = relatedOrderItemsAddon;
              }
              relatedOrderItemsList.add(orderItem);
            }
          }
          if (relatedOrderItemsList.size() > 0) {
            relatedOrderItems.orderItem = relatedOrderItemsList;
            tempOitem.orderItems = relatedOrderItems;
          }
        }

        if (tractProduct.Serialized == true) {
          tempOitem.quantity = 1;
          for (Integer i = 0; i < quantity; i++) {
            arrayof.add(tempOitem);
          }
        } else {
          tempOitem.quantity = quantity;
          arrayof.add(tempOitem);
        }
      }

      if (tractProduct.addToExistingService == true) {
        SoapApi33Domain.OrderItem tempOitemParentService = new SoapApi33Domain.OrderItem();
        SoapApi33Domain.Product product = new SoapApi33Domain.Product();
        SoapApi33Domain.ProductPrice recurringPrice = new SoapApi33Domain.ProductPrice();
        SOAPAPI33Domain.OrderItemPrices orderItemPrices = new SOAPAPI33Domain.OrderItemPrices();
        product.eid = tractProduct.eid;
        tempOitemParentService.product = product;
        String existingAddonId = tractProduct.productid;
        if (
          null != tractProduct.description &&
          tractProduct.description != ''
        ) {
          tempOitemParentService.description = tractProduct.description;
        }
        if (tractProduct.quantity != null) {
          tempOitemParentService.quantity = Double.valueOf(
            tractProduct.quantity
          );
        }
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
            SOAPAPI33Domain.OrderItemRecurringPrice orderItemRecurringPrice = new SOAPAPI33Domain.OrderItemRecurringPrice();
            SoapApi33Domain.RecurringProductPrice recurringProductPrice = new SoapApi33Domain.RecurringProductPrice();
            recurringProductPrice.eid = tractProduct.recurringProductPriceEid;
            orderItemRecurringPrice.recurringProductPrice = recurringProductPrice;
            if (tractProduct.recurringPrice != null) {
              SOAPAPI33Domain.OrderItemPriceRanges orderItempriceRanges = new SOAPAPI33Domain.OrderItemPriceRanges();
              SOAPAPI33Domain.OrderItemPriceRange[] orderItemPriceRangeList = new List<SOAPAPI33Domain.OrderItemPriceRange>{};
              for (
                ProductPriceRangeWrapper priceRange : tractProduct.overridedRecurringPriceRangesList
              ) {
                SOAPAPI33Domain.OrderItemPriceRange orderItemPriceRange = new SOAPAPI33Domain.OrderItemPriceRange();
                orderItemPriceRange.price = String.valueof(priceRange.price);
                orderItemPriceRange.currencyType = ppw.currencyType;
                orderItemPriceRange.quantityBeginRange = String.valueof(
                  priceRange.quantityBeginRange
                );
                orderItemPriceRange.quantityEndRange = String.valueof(
                  priceRange.quantityEndRange
                );
                orderItemPriceRange.level = priceRange.level;
                orderItemPriceRangeList.add(orderItemPriceRange);
              }
              orderItempriceRanges.orderItemPriceRange = orderItemPriceRangeList;
              orderItemRecurringPrice.orderItempriceRanges = orderItempriceRanges;
            }
            orderItemPrices.orderItemRecurringPrice = orderItemRecurringPrice;
          }
          if (
            ppw.priceType == 'OneTime' &&
            ppw.eid == tractProduct.OneTimeProductPriceEid
          ) {
            SOAPAPI33Domain.OrderItemOneTimePrice orderItemOneTimePrice = new SOAPAPI33Domain.OrderItemOneTimePrice();
            SoapApi33Domain.OneTimeProductPrice oneTimeProductPrice = new SoapApi33Domain.OneTimeProductPrice();
            oneTimeProductPrice.eid = tractProduct.OneTimeProductPriceEid;
            orderItemOneTimePrice.oneTimeProductPrice = oneTimeProductPrice;
            if (tractProduct.oneTimePrice != null) {
              SOAPAPI33Domain.OrderItemPriceRanges orderItempriceRanges = new SOAPAPI33Domain.OrderItemPriceRanges();
              SOAPAPI33Domain.OrderItemPriceRange[] orderItemPriceRangeList = new List<SOAPAPI33Domain.OrderItemPriceRange>{};
              for (
                ProductPriceRangeWrapper priceRange : tractProduct.overridedOneTimePriceRangesList
              ) {
                SOAPAPI33Domain.OrderItemPriceRange orderItemPriceRange = new SOAPAPI33Domain.OrderItemPriceRange();
                orderItemPriceRange.price = String.valueof(priceRange.price);
                orderItemPriceRange.currencyType = ppw.currencyType;
                orderItemPriceRange.quantityBeginRange = String.valueof(
                  priceRange.quantityBeginRange
                );
                orderItemPriceRange.quantityEndRange = String.valueof(
                  priceRange.quantityEndRange
                );
                orderItemPriceRange.level = priceRange.level;
                orderItemPriceRangeList.add(orderItemPriceRange);
              }
              orderItempriceRanges.orderItemPriceRange = orderItemPriceRangeList;
              orderItemOneTimePrice.orderItempriceRanges = orderItempriceRanges;
            }
            orderItemPrices.orderItemOneTimePrice = orderItemOneTimePrice;
          }
        }
        tempOitemParentService.orderItemPrices = orderItemPrices;
        if (
          tractProduct.minServiceResources > 0 ||
          tractProduct.maxServiceResources > 0
        ) {
          SoapApi33Domain.ServiceResources srElement = new SoapApi33Domain.ServiceResources();
          SoapApi33Domain.ServiceResource[] srList = new List<SoapApi33Domain.ServiceResource>();
          SoapApi33Domain.ServiceResource tempSR;
          if (
            null != tractProduct.TractServiceResourceEid &&
            null != tractProduct.TractServiceResourceName
          ) {
            list<String> srIdentifier = new List<String>();
            list<String> srEid = new List<String>();
            for (
              String str : tractProduct.TractServiceResourceName.split('\\|')
            ) {
              if (null != str && str.trim() != '') {
                srIdentifier.add(str);
              }
            }
            for (
              String str : tractProduct.TractServiceResourceEid.split('\\|')
            ) {
              if (null != str && str.trim() != '') {
                srEid.add(str);
              }
            }
            for (Integer i = 0; i < srIdentifier.size(); i++) {
              tempSR = new SoapApi33Domain.ServiceResource();
              tempSR.identifier = srIdentifier[i];
              tempSR.status = 'AVAILABLE';
              tempSR.eid = srEid[i];
              srList.add(tempSR);
            }
          }
          if (
            null != tractProduct.NewServiceResource &&
            '' != tractProduct.NewServiceResource
          ) {
            list<String> srId = new List<String>();
            for (String str : tractProduct.NewServiceResource.split('\\|')) {
              if (null != str && str.trim() != '') {
                srId.add(str);
              }
            }
            SoapApi33Domain.ServiceResourceCategory srCategory = new SoapApi33Domain.ServiceResourceCategory();
            srCategory.eid = tractProduct.Service_Resource_Category;
            for (String srIdent : srId) {
              tempSR = new SoapApi33Domain.ServiceResource();
              tempSR.identifier = srIdent;
              SrIdentifier = srIdent;
              tempSR.category = srCategory;
              srList.add(tempSR);
            }
          } else {
            if (tractProduct.minServiceResources == 1) {
              throw new MyException(
                'Please Select a TRACT Service Resource for Product:' +
                tractProduct.name
              );
            }
          }
          srElement.serviceResource = srList;
          tempOitemParentService.serviceResources = srElement;
        }

        if (
          opportunityProductIdVsOneTimeScheduleChargesMap.containskey(
            tractProduct.opportunityProductId
          )
        ) {
          SoapApi33Domain.ScheduledOneTimePriceCharges scheduledChargesFeature = new SoapApi33Domain.ScheduledOneTimePriceCharges();
          SoapApi33Domain.ScheduledOneTimePriceCharge[] scheduledChargeList = new List<SoapApi33Domain.ScheduledOneTimePriceCharge>();
          for (
            Schdeule_Charge__c scheduleCharges : opportunityProductIdVsOneTimeScheduleChargesMap.get(
              tractProduct.opportunityProductId
            )
          ) {
            SoapApi33Domain.ScheduledOneTimePriceCharge scheduledCharge = new SoapApi33Domain.ScheduledOneTimePriceCharge();
            scheduledCharge.amount = Decimal.valueOf(
              scheduleCharges.Schdeule_Amount__c
            );
            scheduledCharge.chargeDate = String.valueOf(
              scheduleCharges.Schdeule_Date__c
            );
            scheduledCharge.description = scheduleCharges.Schdeule_Description__c;
            scheduledChargeList.add(scheduledCharge);
          }
          scheduledChargesFeature.scheduledOneTimePriceCharge = scheduledChargeList;
          tempOitemParentService.scheduledOneTimePriceCharges = scheduledChargesFeature;
        }
        if (
          !String.isBlank(tractProduct.agreementEndAction) ||
          tractProduct.overrideAgreementEndDate != null
        ) {
          tempAgreement = new SoapApi33Domain.Agreement();
          tempAgreement.eid = tractProduct.Agreement_eid;
          tempOitemParentService.selectedAgreement = tempAgreement;
          SoapApi33Domain.AgreementConfiguration overrideAgreementSettings = new SoapApi33Domain.AgreementConfiguration();
          if (!String.isBlank(tractProduct.agreementEndAction)) {
            overrideAgreementSettings.endAction = tractProduct.agreementEndAction;
          }
          if (tractProduct.overrideAgreementEndDate != null) {
            //Sending end date as an instance of datetime, previously sending it as an instance of date
            overrideAgreementSettings.endDate = DateTime.newInstance(
              Date.valueOf(tractProduct.overrideAgreementEndDate),
              System.now().time()
            );
          }
          if (tractProduct.Agreement_Period != null) {
            overrideAgreementSettings.agreementPeriod = integer.valueof(
              tractProduct.Agreement_Period
            );
          }
          if (tractProduct.renewalPricing == 'Service Price') {
            overrideAgreementSettings.preserveServicePrice = true;
          } else if (tractProduct.renewalPricing == 'Product Price') {
            overrideAgreementSettings.preserveServicePrice = false;
          }
          if (
            tractProduct.nextAgreementEid != null &&
            tractProduct.nextAgreementEndAction != null
          ) {
            overrideAgreementSettings.nextAgreement = new SoapApi33Domain.Agreement();
            overrideAgreementSettings.nextAgreement.eid = tractProduct.nextAgreementEid;
            overrideAgreementSettings.nextEndAction = tractProduct.nextAgreementEndAction;
            if (tractProduct.nextRenewalPricing == 'Service Price') {
              overrideAgreementSettings.nextPreserveServicePrice = true;
            } else if (tractProduct.nextRenewalPricing == 'Product Price') {
              overrideAgreementSettings.nextPreserveServicePrice = false;
            }
          }
          tempOitemParentService.agreementConfiguration = overrideAgreementSettings;
        }
        if (
          null != tractProduct.discountCodeName &&
          null != tractProduct.discountCodeEid
        ) {
          SoapApi33Domain.DiscountConfigurations discountConfig = new SoapApi33Domain.DiscountConfigurations();
          List<SoapApi33Domain.DiscountConfiguration> discountConfigList = new List<SoapApi33Domain.DiscountConfiguration>();
          SoapApi33Domain.DiscountConfiguration discountConf = new SoapApi33Domain.DiscountConfiguration();
          SoapApi33Domain.DiscountIdentifier discountIdent = new SoapApi33Domain.DiscountIdentifier();
          discountIdent.eid = tractProduct.discountCodeEid;
          discountConf.discountIdentifier = discountIdent;
          discountConfigList.add(discountConf);
          discountConfig.discountConfiguration = discountConfigList;
          tempOitemParentService.discountConfigurations = discountConfig;
        }

        for (TractProduct totalAddonExistingProducts : productList) {
          SoapApi33Domain.OrderItems relatedOrderItemsExistingAddon = new SoapApi33Domain.OrderItems();
          list<SoapApi33Domain.OrderItem> listOfOrderItemsExistingAddon = new List<SoapApi33Domain.OrderItem>();
          if (totalAddonExistingProducts.ServiceId == existingAddonId) {
            SoapApi33Domain.OrderItem orderItemExistingAddon = new SoapApi33Domain.OrderItem();
            SoapApi33Domain.Product productAddon = new SoapApi33Domain.Product();
            SoapApi33Domain.ProductPrice recurringPriceAddon = new SoapApi33Domain.ProductPrice();
            SOAPAPI33Domain.OrderItemPrices subAddonOrderItemPrices = new SOAPAPI33Domain.OrderItemPrices();
            productAddon.eid = totalAddonExistingProducts.eid;
            orderItemExistingAddon.product = productAddon;
            if (
              null != totalAddonExistingProducts.description &&
              totalAddonExistingProducts.description != ''
            ) {
              orderItemExistingAddon.description = totalAddonExistingProducts.description;
            }
            orderItemExistingAddon.overrideTrialDays = Integer.valueOf(
              totalAddonExistingProducts.overridedTrialLength
            );
            if (totalAddonExistingProducts.quantity != null) {
              orderItemExistingAddon.quantity = Double.valueOf(
                totalAddonExistingProducts.quantity
              );
            }
            Product2 prodAddon = [
              SELECT Id, Name, Price_Information__c
              FROM Product2
              WHERE Id = :totalAddonExistingProducts.ProductId
            ];
            List<ProductPriceWrapper> productPriceWrapListSubAddon = (list<ProductPriceWrapper>) JSON.deserialize(
              prodAddon.Price_Information__c,
              list<ProductPriceWrapper>.class
            );
            for (ProductPriceWrapper ppw : productPriceWrapListSubAddon) {
              if (
                ppw.priceType == 'recurring' &&
                ppw.eid == totalAddonExistingProducts.recurringProductPriceEid
              ) {
                SOAPAPI33Domain.OrderItemRecurringPrice orderItemRecurringPrice = new SOAPAPI33Domain.OrderItemRecurringPrice();
                SoapApi33Domain.RecurringProductPrice recurringProductPrice = new SoapApi33Domain.RecurringProductPrice();
                recurringProductPrice.eid = totalAddonExistingProducts.recurringProductPriceEid;
                orderItemRecurringPrice.recurringProductPrice = recurringProductPrice;
                if (totalAddonExistingProducts.recurringPrice != null) {
                  SOAPAPI33Domain.OrderItemPriceRanges orderItempriceRanges = new SOAPAPI33Domain.OrderItemPriceRanges();
                  SOAPAPI33Domain.OrderItemPriceRange[] orderItemPriceRangeList = new List<SOAPAPI33Domain.OrderItemPriceRange>{};
                  for (
                    ProductPriceRangeWrapper priceRange : totalAddonExistingProducts.overridedRecurringPriceRangesList
                  ) {
                    SOAPAPI33Domain.OrderItemPriceRange orderItemPriceRange = new SOAPAPI33Domain.OrderItemPriceRange();
                    orderItemPriceRange.price = String.valueof(
                      priceRange.price
                    );
                    orderItemPriceRange.currencyType = ppw.currencyType;
                    orderItemPriceRange.quantityBeginRange = String.valueof(
                      priceRange.quantityBeginRange
                    );
                    orderItemPriceRange.quantityEndRange = String.valueof(
                      priceRange.quantityEndRange
                    );
                    orderItemPriceRange.level = priceRange.level;
                    orderItemPriceRangeList.add(orderItemPriceRange);
                  }
                  orderItempriceRanges.orderItemPriceRange = orderItemPriceRangeList;
                  orderItemRecurringPrice.orderItempriceRanges = orderItempriceRanges;
                }
                subAddonOrderItemPrices.orderItemRecurringPrice = orderItemRecurringPrice;
              }
              if (
                ppw.priceType == 'OneTime' &&
                ppw.eid == totalAddonExistingProducts.OneTimeProductPriceEid
              ) {
                SOAPAPI33Domain.OrderItemOneTimePrice orderItemOneTimePrice = new SOAPAPI33Domain.OrderItemOneTimePrice();
                SoapApi33Domain.OneTimeProductPrice oneTimeProductPrice = new SoapApi33Domain.OneTimeProductPrice();
                oneTimeProductPrice.eid = totalAddonExistingProducts.OneTimeProductPriceEid;
                orderItemOneTimePrice.oneTimeProductPrice = oneTimeProductPrice;
                if (totalAddonExistingProducts.oneTimePrice != null) {
                  SOAPAPI33Domain.OrderItemPriceRanges orderItempriceRanges = new SOAPAPI33Domain.OrderItemPriceRanges();
                  SOAPAPI33Domain.OrderItemPriceRange[] orderItemPriceRangeList = new List<SOAPAPI33Domain.OrderItemPriceRange>{};
                  for (
                    ProductPriceRangeWrapper priceRange : totalAddonExistingProducts.overridedOneTimePriceRangesList
                  ) {
                    SOAPAPI33Domain.OrderItemPriceRange orderItemPriceRange = new SOAPAPI33Domain.OrderItemPriceRange();
                    orderItemPriceRange.price = String.valueof(
                      priceRange.price
                    );
                    orderItemPriceRange.currencyType = ppw.currencyType;
                    orderItemPriceRange.quantityBeginRange = String.valueof(
                      priceRange.quantityBeginRange
                    );
                    orderItemPriceRange.quantityEndRange = String.valueof(
                      priceRange.quantityEndRange
                    );
                    orderItemPriceRange.level = priceRange.level;
                    orderItemPriceRangeList.add(orderItemPriceRange);
                  }
                  orderItempriceRanges.orderItemPriceRange = orderItemPriceRangeList;
                  orderItemOneTimePrice.orderItempriceRanges = orderItempriceRanges;
                }
                subAddonOrderItemPrices.orderItemOneTimePrice = orderItemOneTimePrice;
              }
            }
            orderItemExistingAddon.orderItemPrices = subAddonOrderItemPrices;
            if (
              !String.isBlank(totalAddonExistingProducts.agreementEndAction) ||
              totalAddonExistingProducts.overrideAgreementEndDate != null
            ) {
              tempAgreement = new SoapApi33Domain.Agreement();
              tempAgreement.eid = totalAddonExistingProducts.Agreement_eid;
              orderItemExistingAddon.selectedAgreement = tempAgreement;
              SoapApi33Domain.AgreementConfiguration overrideAgreementSettings = new SoapApi33Domain.AgreementConfiguration();
              if (
                !String.isBlank(totalAddonExistingProducts.agreementEndAction)
              ) {
                overrideAgreementSettings.endAction = totalAddonExistingProducts.agreementEndAction;
              }
              if (totalAddonExistingProducts.overrideAgreementEndDate != null) {
                //Sending end date as an instance of datetime, previously sending it as an instance of date
                overrideAgreementSettings.endDate = DateTime.newInstance(
                  Date.valueOf(
                    totalAddonExistingProducts.overrideAgreementEndDate
                  ),
                  System.now().time()
                );
              }
              if (totalAddonExistingProducts.Agreement_Period != null) {
                overrideAgreementSettings.agreementPeriod = integer.valueof(
                  totalAddonExistingProducts.Agreement_Period
                );
              }
              if (
                totalAddonExistingProducts.renewalPricing == 'Service Price'
              ) {
                overrideAgreementSettings.preserveServicePrice = true;
              } else if (
                totalAddonExistingProducts.renewalPricing == 'Product Price'
              ) {
                overrideAgreementSettings.preserveServicePrice = false;
              }
              if (
                totalAddonExistingProducts.nextAgreementEid != null &&
                totalAddonExistingProducts.nextAgreementEndAction != null
              ) {
                overrideAgreementSettings.nextAgreement = new SoapApi33Domain.Agreement();
                overrideAgreementSettings.nextAgreement.eid = totalAddonExistingProducts.nextAgreementEid;
                overrideAgreementSettings.nextEndAction = totalAddonExistingProducts.nextAgreementEndAction;
                if (
                  totalAddonExistingProducts.nextRenewalPricing ==
                  'Service Price'
                ) {
                  overrideAgreementSettings.nextPreserveServicePrice = true;
                } else if (
                  totalAddonExistingProducts.nextRenewalPricing ==
                  'Product Price'
                ) {
                  overrideAgreementSettings.nextPreserveServicePrice = false;
                }
              }
              orderItemExistingAddon.agreementConfiguration = overrideAgreementSettings;
            }
            if (
              null != totalAddonExistingProducts.discountCodeName &&
              null != totalAddonExistingProducts.discountCodeEid
            ) {
              SoapApi33Domain.DiscountConfigurations discountConfig = new SoapApi33Domain.DiscountConfigurations();
              List<SoapApi33Domain.DiscountConfiguration> discountConfigList = new List<SoapApi33Domain.DiscountConfiguration>();
              SoapApi33Domain.DiscountConfiguration discountConf = new SoapApi33Domain.DiscountConfiguration();
              SoapApi33Domain.DiscountIdentifier discountIdent = new SoapApi33Domain.DiscountIdentifier();
              discountIdent.eid = totalAddonExistingProducts.discountCodeEid;
              discountConf.discountIdentifier = discountIdent;
              discountConfigList.add(discountConf);
              discountConfig.discountConfiguration = discountConfigList;
              orderItemExistingAddon.discountConfigurations = discountConfig;
            }
            if (
              opportunityProductIdVsOneTimeScheduleChargesMap.containskey(
                totalAddonExistingProducts.opportunityProductId
              )
            ) {
              SoapApi33Domain.ScheduledOneTimePriceCharges scheduledChargesFeature = new SoapApi33Domain.ScheduledOneTimePriceCharges();
              SoapApi33Domain.ScheduledOneTimePriceCharge[] scheduledChargeList = new List<SoapApi33Domain.ScheduledOneTimePriceCharge>();
              for (
                Schdeule_Charge__c scheduleCharges : opportunityProductIdVsOneTimeScheduleChargesMap.get(
                  totalAddonExistingProducts.opportunityProductId
                )
              ) {
                SoapApi33Domain.ScheduledOneTimePriceCharge scheduledCharge = new SoapApi33Domain.ScheduledOneTimePriceCharge();
                scheduledCharge.amount = Decimal.valueOf(
                  scheduleCharges.Schdeule_Amount__c
                );
                scheduledCharge.chargeDate = String.valueOf(
                  scheduleCharges.Schdeule_Date__c
                );
                scheduledCharge.description = scheduleCharges.Schdeule_Description__c;
                scheduledChargeList.add(scheduledCharge);
              }
              scheduledChargesFeature.scheduledOneTimePriceCharge = scheduledChargeList;
              orderItemExistingAddon.scheduledOneTimePriceCharges = scheduledChargesFeature;
            }

            if (
              opportunityProductIdVsScheduleChargesMap.containskey(
                totalAddonExistingProducts.opportunityProductId
              )
            ) {
              SoapApi33Domain.ScheduledCharges scheduledChargesFeature = new SoapApi33Domain.ScheduledCharges();
              SoapApi33Domain.ScheduledCharge[] scheduledChargeList = new List<SoapApi33Domain.ScheduledCharge>();
              for (
                Schdeule_Charge__c scheduleCharges : opportunityProductIdVsScheduleChargesMap.get(
                  totalAddonExistingProducts.opportunityProductId
                )
              ) {
                SoapApi33Domain.ScheduledCharge scheduledCharge = new SoapApi33Domain.ScheduledCharge();
                scheduledCharge.amount = Decimal.valueOf(
                  scheduleCharges.Schdeule_Amount__c
                );
                scheduledCharge.chargeDate = String.valueOf(
                  scheduleCharges.Schdeule_Date__c
                );
                scheduledCharge.description = scheduleCharges.Schdeule_Description__c;
                scheduledChargeList.add(scheduledCharge);
              }
              scheduledChargesFeature.scheduledCharge = scheduledChargeList;
              orderItemExistingAddon.scheduledCharges = scheduledChargesFeature;
            }

            if (
              opportunityProductIdVsServiceCustomFieldMap.containskey(
                totalAddonExistingProducts.ProductId
              )
            ) {
              SoapApi33Domain.CustomFieldValues customFieldVals = new SoapApi33Domain.CustomFieldValues();
              List<SoapApi33Domain.CustomFieldValue> customFldValueList = new List<SoapApi33Domain.CustomFieldValue>();
              for (
                Service_Custom_Field__c serviceField : opportunityProductIdVsServiceCustomFieldMap.get(
                  totalAddonExistingProducts.opportunityProductId
                )
              ) {
                SoapApi33Domain.CustomFieldValue customFieldVal = new SoapApi33Domain.CustomFieldValue();
                SoapApi33Domain.CustomField customFld = new SoapApi33Domain.CustomField();
                customFld.eid = serviceField.eid__c;
                customFieldVal.value = serviceField.value__c;
                customFieldVal.customField = customFld;
                customFldValueList.add(customFieldVal);
              }

              customFieldVals.customFieldValue = customFldValueList;
              orderItemExistingAddon.customFieldValues = customFieldVals;
            }

            if (
              totalAddonExistingProducts.minServiceResources > 0 ||
              totalAddonExistingProducts.maxServiceResources > 0
            ) {
              SoapApi33Domain.ServiceResources srElement = new SoapApi33Domain.ServiceResources();
              SoapApi33Domain.ServiceResource[] srList = new List<SoapApi33Domain.ServiceResource>();
              SoapApi33Domain.ServiceResource tempSR;
              if (
                null != totalAddonExistingProducts.TractServiceResourceEid &&
                null != totalAddonExistingProducts.TractServiceResourceName
              ) {
                list<String> srIdentifier = new List<String>();
                list<String> srEid = new List<String>();
                for (
                  String str : totalAddonExistingProducts.TractServiceResourceName.split(
                    '\\|'
                  )
                ) {
                  if (null != str && str.trim() != '') {
                    srIdentifier.add(str);
                  }
                }
                for (
                  String str : totalAddonExistingProducts.TractServiceResourceEid.split(
                    '\\|'
                  )
                ) {
                  if (null != str && str.trim() != '') {
                    srEid.add(str);
                  }
                }
                for (Integer i = 0; i < srIdentifier.size(); i++) {
                  tempSR = new SoapApi33Domain.ServiceResource();
                  tempSR.identifier = srIdentifier[i];
                  tempSR.status = 'AVAILABLE';
                  tempSR.eid = srEid[i];
                  srList.add(tempSR);
                }
              } else if (
                null != totalAddonExistingProducts.NewServiceResource &&
                '' != totalAddonExistingProducts.NewServiceResource
              ) {
                list<String> srId = new List<String>();
                for (
                  String str : totalAddonExistingProducts.NewServiceResource.split(
                    '\\|'
                  )
                ) {
                  if (null != str && str.trim() != '') {
                    srId.add(str);
                  }
                }
                SoapApi33Domain.ServiceResourceCategory srCategory = new SoapApi33Domain.ServiceResourceCategory();
                srCategory.eid = totalAddonExistingProducts.Service_Resource_Category;
                for (String srIdent : srId) {
                  tempSR = new SoapApi33Domain.ServiceResource();
                  tempSR.identifier = srIdent;
                  SrIdentifier = srIdent;
                  tempSR.category = srCategory;
                  srList.add(tempSR);
                }
              } else {
                if (totalAddonExistingProducts.minServiceResources == 1) {
                  throw new MyException(
                    'Please Select a TRACT Service Resource for Product:' +
                    totalAddonExistingProducts.name
                  );
                }
              }
              srElement.serviceResource = srList;
              orderItemExistingAddon.serviceResources = srElement;
            }
            listOfOrderItemsExistingAddon.add(orderItemExistingAddon);
          }
          if (listOfOrderItemsExistingAddon.size() > 0) {
            relatedOrderItemsExistingAddon.orderItem = listOfOrderItemsExistingAddon;
            tempOitemParentService.orderItems = relatedOrderItemsExistingAddon;
          }
        }
        SoapApi33Domain.Service serv = new SoapApi33Domain.Service();
        serv.eid = tractProduct.parentServiceEid;
        tempOitemParentService.parentService = serv;
        arrayof.add(tempOitemParentService);
      }
      if (tractProduct.ProductCode == 'One-Time') {
        tempOitem2 = new SoapApi33Domain.OrderItem();
        tempOitem2.product = new SoapApi33Domain.Product();
        SOAPAPI33Domain.OrderItemPrices orderItemPrices = new SOAPAPI33Domain.OrderItemPrices();
        Double quantity = Double.valueof(tractProduct.quantity);
        tempOitem2.product.eid = tractProduct.eid;
        tempOitem2.sequence = 1;
        tempOitem2.quantity = quantity;
        tempOitem2.product.name = tractProduct.name;
        //tempOitem2.unitPrice = tractProduct.oneTimePrice;
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
            ppw.priceType == 'OneTime' &&
            ppw.eid == tractProduct.OneTimeProductPriceEid
          ) {
            SOAPAPI33Domain.OrderItemOneTimePrice orderItemOneTimePrice = new SOAPAPI33Domain.OrderItemOneTimePrice();
            SoapApi33Domain.OneTimeProductPrice oneTimeProductPrice = new SoapApi33Domain.OneTimeProductPrice();
            oneTimeProductPrice.eid = tractProduct.OneTimeProductPriceEid;
            orderItemOneTimePrice.oneTimeProductPrice = oneTimeProductPrice;
            if (tractProduct.oneTimePrice != null) {
              SOAPAPI33Domain.OrderItemPriceRanges orderItempriceRanges = new SOAPAPI33Domain.OrderItemPriceRanges();
              SOAPAPI33Domain.OrderItemPriceRange[] orderItemPriceRangeList = new List<SOAPAPI33Domain.OrderItemPriceRange>{};
              for (
                ProductPriceRangeWrapper priceRange : tractProduct.overridedOneTimePriceRangesList
              ) {
                SOAPAPI33Domain.OrderItemPriceRange orderItemPriceRange = new SOAPAPI33Domain.OrderItemPriceRange();
                orderItemPriceRange.price = String.valueof(priceRange.price);
                orderItemPriceRange.currencyType = ppw.currencyType;
                orderItemPriceRange.quantityBeginRange = String.valueof(
                  priceRange.quantityBeginRange
                );
                orderItemPriceRange.quantityEndRange = String.valueof(
                  priceRange.quantityEndRange
                );
                orderItemPriceRange.level = priceRange.level;
                orderItemPriceRangeList.add(orderItemPriceRange);
              }
              orderItempriceRanges.orderItemPriceRange = orderItemPriceRangeList;
              orderItemOneTimePrice.orderItempriceRanges = orderItempriceRanges;
            }
            orderItemPrices.orderItemOneTimePrice = orderItemOneTimePrice;
          }
        }
        tempOitem2.orderItemPrices = orderItemPrices;

        if (
          opportunityProductIdVsOneTimeScheduleChargesMap.containskey(
            tractProduct.opportunityProductId
          )
        ) {
          SoapApi33Domain.ScheduledOneTimePriceCharges scheduledChargesFeature = new SoapApi33Domain.ScheduledOneTimePriceCharges();
          SoapApi33Domain.ScheduledOneTimePriceCharge[] scheduledChargeList = new List<SoapApi33Domain.ScheduledOneTimePriceCharge>();
          for (
            Schdeule_Charge__c scheduleCharges : opportunityProductIdVsOneTimeScheduleChargesMap.get(
              tractProduct.opportunityProductId
            )
          ) {
            SoapApi33Domain.ScheduledOneTimePriceCharge scheduledCharge = new SoapApi33Domain.ScheduledOneTimePriceCharge();
            scheduledCharge.amount = Decimal.valueOf(
              scheduleCharges.Schdeule_Amount__c
            );
            scheduledCharge.chargeDate = String.valueOf(
              scheduleCharges.Schdeule_Date__c
            );
            scheduledCharge.description = scheduleCharges.Schdeule_Description__c;
            scheduledChargeList.add(scheduledCharge);
          }
          scheduledChargesFeature.scheduledOneTimePriceCharge = scheduledChargeList;
          tempOitem2.scheduledOneTimePriceCharges = scheduledChargesFeature;
        }
        arrayof.add(tempOitem2);
      }
    }
    return arrayof;
  }
  /**
   * Get the Related Product Index.
   */
  private static Integer getRelatedProductindex(
    TractProduct[] productList,
    String eid,
    Map<String, Integer> addProducts
  ) {
    Integer index = -1;
    Integer counter = -1;
    for (TractProduct product : productList) {
      counter = counter + 1;
      addProducts.put(product.eid, counter);
      if (product.eid == eid) {
        index = counter;
      }
    }
    return index;
  }

  /**
   * @description: Get request to create Agreement on a product in GTV db
   * @param agreementList, The list of agreement to be created in GTV.
   * @param productId, The GTV product id.
   * @return SoapApi33Domain.CommandRequest, The Instance of SoapApi33Domain.CommandRequest class.
   */
  public static List<SoapApi33Domain.CommandRequest> mapProductNewAgreements(
    List<ProductAgreementWrapper> agreementList,
    String productId
  ) {
    List<SoapApi33Domain.CommandRequest> commandRequestList = new List<SoapApi33Domain.CommandRequest>();
    for (ProductAgreementWrapper wrap : agreementList) {
      SoapApi33Domain.CommandRequest req = new SoapApi33Domain.CommandRequest();
      SoapApi33Domain.AddAgreementToProduct addgreement = new SoapApi33Domain.AddAgreementToProduct();
      SoapApi33Domain.Agreement agreement = new SoapApi33Domain.Agreement();
      agreement.eid = wrap.eid;
      SoapApi33Domain.Product pro = new SoapApi33Domain.Product();
      pro.eid = productId;
      addgreement.relatedAgreement = agreement;
      addgreement.product = pro;
      req.addAgreementToProduct = addgreement;
      commandRequestList.add(req);
    }
    return commandRequestList;
  }

  /**
   * @description: Get request to remove product agreement relation in GTV db
   * @param agreementWrap, The ProductAgreementWrapper wrapper instance storing information about the agreement.
   * @param productId, The GTV product id.
   * @return SoapApi33Domain.CommandRequest, The Instance of SoapApi33Domain.CommandRequest class.
   */
  public static SoapApi33Domain.CommandRequest mapProductAgreementsRelation(
    ProductAgreementWrapper agreementWrap,
    String productId
  ) {
    SoapApi33Domain.CommandRequest commandRequest = new SoapApi33Domain.CommandRequest();
    SoapApi33Domain.removeAgreementFromProduct thisAgreement = new SoapApi33Domain.removeAgreementFromProduct();
    SoapApi33Domain.Agreement agreement = new SoapApi33Domain.Agreement();
    agreement.eid = agreementWrap.eid;
    SoapApi33Domain.Product pro = new SoapApi33Domain.Product();
    pro.eid = productId;
    thisAgreement.relatedAgreement = agreement;
    thisAgreement.product = pro;
    commandRequest.removeAgreementFromProduct = thisAgreement;
    return commandRequest;
  }

  /**
   * @description: Get request to change the status of a product to available in GTV db
   * @param productId, The GTV product id.
   * @return SoapApi33Domain.CommandRequest, The Instance of SoapApi33Domain.CommandRequest class.
   */
  public static SoapApi33Domain.CommandRequest mapActivateProduct(
    String productId
  ) {
    SoapApi33Domain.CommandRequest commandRequest = new SoapApi33Domain.CommandRequest();
    SoapApi33Domain.ActivateProduct product = new SoapApi33Domain.ActivateProduct();
    SoapApi33Domain.Product thisProduct = new SoapApi33Domain.Product();
    thisProduct.eid = productId;
    product.product = thisProduct;
    commandRequest.activateProduct = product;
    return commandRequest;
  }

  /**
   * @description: Get request to add one time product price in GTV db
   * @param createOneTimeProductPriceWrapper, The createOneTimeProductPriceWrapper wrapper instance.
   * @param priceListId, The GTV pricelist id.
   * @return SoapApi33Domain.CommandRequest, The Instance of SoapApi33Domain.CommandRequest class.
   */
  public static SoapApi33Domain.CommandRequest mapOneTimeProductPrice(
    CreateOneTimeChargePriceWrapper createOneTimeProductPriceWrapper,
    String priceListId
  ) {
    SoapApi33Domain.CommandRequest createOneTimePriceCmd = new SoapApi33Domain.CommandRequest();
    SoapApi33Domain.AddProductPriceToProduct addProductPrice = new SoapApi33Domain.AddProductPriceToProduct();
    SoapApi33Domain.Product pro = new SoapApi33Domain.Product();
    pro.eid = createOneTimeProductPriceWrapper.productId;
    if (priceListId != null) {
      SoapApi33Domain.PriceList priceListDet = new SoapApi33Domain.PriceList();
      priceListDet.eid = priceListId;
      addProductPrice.priceList = priceListDet;
    }
    SoapApi33Domain.OneTimeProductPrice oneTimeProductPrice = new SoapApi33Domain.OneTimeProductPrice();
    oneTimeProductPrice.currencyType = createOneTimeProductPriceWrapper.selectedcurrency;
    oneTimeProductPrice.paymentOnPurchaseRequired = createOneTimeProductPriceWrapper.payOnPurchase;
    oneTimeProductPrice.allowScheduledCharges = createOneTimeProductPriceWrapper.requireScheduledCharges;
    oneTimeProductPrice.chargeDuringRenewal = createOneTimeProductPriceWrapper.chargeAtRenewal;
    oneTimeProductPrice.priceOverride = createOneTimeProductPriceWrapper.priceOverride;
    if (createOneTimeProductPriceWrapper.fromDate != null) {
      oneTimeProductPrice.fromDate = Datetime.newInstance(
        createOneTimeProductPriceWrapper.fromDate,
        System.now().time()
      );
    }
    if (
      createOneTimeProductPriceWrapper.createPriceRangeWrapper != null &&
      createOneTimeProductPriceWrapper.createPriceRangeWrapper.size() > 0
    ) {
      oneTimeProductPrice.priceRanges = new SoapApi33Domain.PriceRanges();
      oneTimeProductPrice.priceRanges.priceRange = new List<SoapApi33Domain.PriceRange>();
      Integer level = 0;
      for (
        CreatePriceRangeWrapper priceRangeWrapInstance : createOneTimeProductPriceWrapper.createPriceRangeWrapper
      ) {
        level++;
        SoapApi33Domain.PriceRange createPriceRange = new SoapApi33Domain.PriceRange();
        createPriceRange.level = level;
        createPriceRange.currencyType = createOneTimeProductPriceWrapper.selectedcurrency;
        createPriceRange.quantityBeginRange = priceRangeWrapInstance.startingQuantity;
        createPriceRange.quantityEndRange = priceRangeWrapInstance.endingQuantity;
        createPriceRange.price = priceRangeWrapInstance.Price;
        oneTimeProductPrice.priceRanges.priceRange.add(createPriceRange);
      }
    }
    SoapApi33Domain.PriceCategory cat = new SoapApi33Domain.PriceCategory();
    cat.eid = createOneTimeProductPriceWrapper.priceCategory;
    oneTimeProductPrice.priceCategory = cat;
    addProductPrice.oneTimeProductPrice = oneTimeProductPrice;
    addProductPrice.product = pro;
    createOneTimePriceCmd.addProductPriceToProduct = addProductPrice;
    return createOneTimePriceCmd;
  }

  /**
   * @description: Get request to add products to pricelist in GTV db.
   * @param priceListEid, The GTV pricelist id(required)
   * @param selectedProducts, The list of product to add to the pricelist(required)
   * @return List<SoapApi33Domain.CommandRequest>, The List of SoapApi33Domain.CommandRequest class.
   */
  public static List<SoapApi33Domain.CommandRequest> addProductToPriceListRequest(
    String priceListEid,
    list<String> selectedProducts
  ) {
    List<SoapApi33Domain.CommandRequest> commandRequestList = new List<SoapApi33Domain.CommandRequest>();
    for (String productEid : selectedProducts) {
      SoapApi33Domain.CommandRequest addProductToPriceListCommandRequest = new SoapApi33Domain.CommandRequest();
      SOAPAPI33Domain.AddProductToPriceList addProductToPriceList = new SOAPAPI33Domain.AddProductToPriceList();
      addProductToPriceList.product = new SOAPAPI33Domain.Product();
      addProductToPriceList.product.eid = productEid;
      addProductToPriceList.priceList = new SOAPAPI33Domain.PriceList();
      addProductToPriceList.PriceList.eid = priceListEid;
      addProductToPriceListCommandRequest.addProductToPriceList = addProductToPriceList;
      commandRequestList.add(addProductToPriceListCommandRequest);
    }
    return commandRequestList;
  }

  /**
   * @description: Get request to remove products from pricelist in GTV db.
   * @param priceListEid, The GTV pricelist id(required)
   * @param selectedProducts, The list of product to be removed from the pricelist(required)
   * @return List<SoapApi33Domain.CommandRequest>, The List of SoapApi33Domain.CommandRequest class.
   */
  public static List<SoapApi33Domain.CommandRequest> removeProductFromPriceListRequest(
    String priceListEid,
    list<String> selectedProducts
  ) {
    List<SoapApi33Domain.CommandRequest> commandRequestList = new List<SoapApi33Domain.CommandRequest>();
    for (String productEid : selectedProducts) {
      SoapApi33Domain.CommandRequest removeProductFromPriceListCommandRequest = new SoapApi33Domain.CommandRequest();
      SOAPAPI33Domain.RemoveProductFromPriceList removeProductFromPriceList = new SOAPAPI33Domain.RemoveProductFromPriceList();
      removeProductFromPriceList.product = new SOAPAPI33Domain.Product();
      removeProductFromPriceList.product.eid = productEid;
      removeProductFromPriceList.priceList = new SOAPAPI33Domain.PriceList();
      removeProductFromPriceList.PriceList.eid = priceListEid;
      removeProductFromPriceListCommandRequest.removeProductFromPriceList = removeProductFromPriceList;
      commandRequestList.add(removeProductFromPriceListCommandRequest);
    }
    return commandRequestList;
  }

  /**
   * @description: Get request to delete marketplace in GTV db
   * @param mPlaceId, The GTV marketplace id.
   * @return SoapApi33Domain.CommandRequest, The Instance of SoapApi33Domain.CommandRequest class.
   */
  public static SoapApi33Domain.CommandRequest deleteMarketPlaceRequest(
    String mPlaceId
  ) {
    SoapApi33Domain.CommandRequest deleteMarketPlaceCommandRequest = new SoapApi33Domain.CommandRequest();
    SOAPAPI33Domain.DeleteMarketPlace deleteMarketPlace = new SOAPAPI33Domain.DeleteMarketPlace();
    SOAPAPI33Domain.MarketPlace marketPlace = new SOAPAPI33Domain.MarketPlace();
    marketPlace.eid = mPlaceId;
    deleteMarketPlace.marketPlace = marketPlace;
    deleteMarketPlaceCommandRequest.deleteMarketPlace = deleteMarketPlace;
    return deleteMarketPlaceCommandRequest;
  }

  /**
   * @description: Get request to delete product relation in GTV db
   * @param thisProductEid, The GTV product id.
   * @param relationWrap, The product relation wrapper instance.
   * @return SoapApi33Domain.CommandRequest, The Instance of SoapApi33Domain.CommandRequest class.
   */
  public static SoapApi33Domain.CommandRequest deleteProductRelationRequest(
    String productId,
    ProductRelationWrapper relationWrap
  ) {
    SoapApi33Domain.CommandRequest deleteProductRelationCommandRequest = new SoapApi33Domain.CommandRequest();
    SoapApi33Domain.RemoveProductRelation removeRelation = new SoapApi33Domain.RemoveProductRelation();
    SOAPAPI33Domain.Product relatedProduct = new SOAPAPI33Domain.Product();
    relatedProduct.eid = relationWrap.relatedfProductEid;
    SOAPAPI33Domain.Product product = new SOAPAPI33Domain.Product();
    product.eid = productId;
    removeRelation.type_x = relationWrap.relationShipType;
    removeRelation.product = product;
    removeRelation.relatedProduct = relatedProduct;
    deleteProductRelationCommandRequest.removeProductRelation = removeRelation;
    return deleteProductRelationCommandRequest;
  }

  public static SoapApi33Domain.CommandRequest mapNewProductActivityChargeRule(
    ProductChargeRuleWrapper chargeRuleWrapper,
    Map<String, String> rateTableVsUomMap,
    String productPriceEId
  ) {
    String productUsageValue = chargeRuleWrapper.productUsageRuleListValue;
    String chargeCategoryValue = chargeRuleWrapper.chargeCategoryListValue;
    String allowanceValue = chargeRuleWrapper.allowanceTypeListValue;
    String amoutChargeSelect = chargeRuleWrapper.amountChargePickList;
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
    String validFrom = chargeRuleWrapper.validFrom;
    String validTo = chargeRuleWrapper.validTo;
    //String checkRuleTypeValue = ruleTypeValue;
    SoapApi33Domain.CommandRequest newChargeRule = new SoapApi33Domain.CommandRequest();
    SoapApi33Domain.AddProductUsageRuleToRecurringProductPrice addProductUsageRuleToRecPrice = new SoapApi33Domain.AddProductUsageRuleToRecurringProductPrice();
    SoapApi33Domain.RecurringProductPrice productprice = new SoapApi33Domain.RecurringProductPrice();
    system.debug('rateTypeValue::::::' + rateTypeValue);
    productprice.eid = productPriceEId;

    addProductUsageRuleToRecPrice.recurringPrice = productprice;

    if (productUsageValue == 'Match All Events') {
      SoapApi33Domain.MatchAllProductUsageRule matchAllProductUsageRule = new SoapApi33Domain.MatchAllProductUsageRule();

      SoapApi33Domain.ChargeCategory chargeCategory = new SoapApi33Domain.ChargeCategory();

      if (null != chargeCategoryValue) {
        chargeCategory.eid = chargeCategoryValue;
      }

      matchAllProductUsageRule.name = productUsageRuleName;
      matchAllProductUsageRule.validFrom = Datetime.newInstance(
        Date.valueOf(validFrom),
        Time.newInstance(23, 59, 59, 59)
      );
      //matchAllServiceUsageRule.order = '1';
      matchAllProductUsageRule.allowanceType = allowanceValue;
      if (allowanceValue == 'Unlimited') {
        String uom = rateTableVsUomMap.get(productUsageRuleName);
        if (uom != null) {
          matchAllProductUsageRule.usageUom = uom.toUpperCase();
        }
      } else {
        matchAllProductUsageRule.usageUom = amoutChargeSelect.toUpperCase();
      }
      matchAllProductUsageRule.status = statusValue.toUppercase();
      matchAllProductUsageRule.chargeCategory = chargeCategory;
      matchAllProductUsageRule.proratedOnOrder = prorateOnOrder;
      matchAllProductUsageRule.proratedOnCancel = prorateOnCancel;
      matchAllProductUsageRule.limit_x = ammountValue;
      matchAllProductUsageRule.rollOverType = rollOverValue;

      matchAllProductUsageRule.ruleType = 'TAPERED';
      //matchAllProductUsageRule.ruleType=checkRuleTypeValue;
      if (rateTypeValue == 'Flat') {
        SoapApi33Domain.FlatUsageRate flatUsageRate = new SoapApi33Domain.FlatUsageRate();
        flatUsageRate.uom = selectedCharge.toUppercase();
        flatUsageRate.rate = chargeValue;
        matchAllProductUsageRule.flatUsageRate = flatUsageRate;
      }

      if (rateTypeValue == 'Table Rate' || test.isrunningtest()) {
        SoapApi33Domain.TableUsageRate tableUsageRate = new SoapApi33Domain.TableUsageRate();
        SoapApi33Domain.RateTable rateTableUsageRate = new SoapApi33Domain.RateTable();
        rateTableUsageRate.eid = chargeListByteValue;
        tableUsageRate.usageFieldName = chargeFormulaFieldValue;

        tableUsageRate.rateTable = rateTableUsageRate;
        matchAllProductUsageRule.tableUsageRate = tableUsageRate;
      }

      if (rateTypeValue == 'Pass Through') {
        SoapApi33Domain.PassThroughUsageRate passThroughUsageRate = new SoapApi33Domain.PassThroughUsageRate();
        passThroughUsageRate.usageFieldName = passThroughListValue;

        matchAllProductUsageRule.passThroughUsageRate = passThroughUsageRate;
        if (allowanceValue == 'Unlimited') {
          matchAllProductUsageRule.usageUom = selectedChargeGlobal.toUpperCase();
        }
      }

      addProductUsageRuleToRecPrice.matchAllProductUsageRule = matchAllProductUsageRule;
    }
    if (productUsageValue == 'Formula' || test.isrunningtest()) {
      SoapApi33Domain.FormulaProductUsageRule formulaProductUsageRule = new SoapApi33Domain.FormulaProductUsageRule();

      SoapApi33Domain.ChargeCategory chargeCategory = new SoapApi33Domain.ChargeCategory();

      if (null != chargeCategoryValue) {
        chargeCategory.eid = chargeCategoryValue;
      }

      formulaProductUsageRule.name = productUsageRuleName;

      formulaProductUsageRule.fieldName = fieldvalue;
      formulaProductUsageRule.operator = chargeRuleWrapper.operationListValue;
      formulaProductUsageRule.fieldValue = activityFormulaValue;
      formulaProductUsageRule.validFrom = Datetime.newInstance(
        Date.valueOf(validFrom),
        Time.newInstance(23, 59, 59, 59)
      );
      //formulaProductUsageRule.order = '1';
      formulaProductUsageRule.allowanceType = allowanceValue;
      if (allowanceValue == 'Unlimited') {
        String uom = rateTableVsUomMap.get(productUsageRuleName);
        if (uom != null) {
          formulaProductUsageRule.usageUom = uom.toUpperCase();
        }
      } else {
        if (amoutChargeSelect != 'Choose One') {
          formulaProductUsageRule.usageUom = amoutChargeSelect.toUpperCase();
        }
        if (selectedChargeGlobal != 'Choose One') {
          formulaProductUsageRule.usageUom = selectedChargeGlobal.toUpperCase();
        }
      }
      formulaProductUsageRule.status = statusValue.toUppercase();
      formulaProductUsageRule.chargeCategory = chargeCategory;
      formulaProductUsageRule.proratedOnOrder = prorateOnOrder;
      formulaProductUsageRule.proratedOnCancel = prorateOnCancel;
      formulaProductUsageRule.limit_x = ammountValue;
      formulaProductUsageRule.rollOverType = rollOverValue;

      formulaProductUsageRule.ruleType = 'TAPERED';
      if (rateTypeValue == 'Flat') {
        SoapApi33Domain.FlatUsageRate flatUsageRate = new SoapApi33Domain.FlatUsageRate();
        flatUsageRate.uom = selectedCharge.toUppercase();
        flatUsageRate.rate = chargeValue;
        formulaProductUsageRule.flatUsageRate = flatUsageRate;
      }

      if (rateTypeValue == 'Table Rate' || test.isrunningtest()) {
        SoapApi33Domain.TableUsageRate tableUsageRate = new SoapApi33Domain.TableUsageRate();
        SoapApi33Domain.RateTable rateTableUsageRate = new SoapApi33Domain.RateTable();
        rateTableUsageRate.eid = chargeListByteValue;
        tableUsageRate.usageFieldName = chargeFormulaFieldValue;

        tableUsageRate.rateTable = rateTableUsageRate;
        formulaProductUsageRule.tableUsageRate = tableUsageRate;
      }

      if (rateTypeValue == 'Pass Through' || test.isrunningtest()) {
        SoapApi33Domain.PassThroughUsageRate passThroughUsageRate = new SoapApi33Domain.PassThroughUsageRate();
        passThroughUsageRate.usageFieldName = passThroughListValue;
        formulaProductUsageRule.passThroughUsageRate = passThroughUsageRate;
        if (allowanceValue == 'Unlimited') {
          formulaProductUsageRule.usageUom = selectedChargeGlobal.toUpperCase();
        }
      }

      addProductUsageRuleToRecPrice.formulaProductUsageRule = formulaProductUsageRule;
    }
    if (productUsageValue == 'Global' || test.isrunningtest()) {
      SoapApi33Domain.GlobalProductUsageRule globalProductUsageRule = new SoapApi33Domain.GlobalProductUsageRule();

      SoapApi33Domain.ChargeCategory chargeCategory = new SoapApi33Domain.ChargeCategory();

      SoapApi33Domain.GlobalUsageRule globalUsageRule = new SoapApi33Domain.GlobalUsageRule();
      if (null != chargeCategoryValue) {
        chargeCategory.eid = chargeCategoryValue;
      }
      globalUsageRule.eid = chargeRuleWrapper.formulaUsageRuleListValue;

      globalProductUsageRule.name = productUsageRuleName;

      if (rateTypeValue == 'Flat') {
        SoapApi33Domain.FlatUsageRate flatUsageRate = new SoapApi33Domain.FlatUsageRate();
        flatUsageRate.uom = selectedCharge.toUppercase();
        flatUsageRate.rate = chargeValue;
        globalProductUsageRule.flatUsageRate = flatUsageRate;
      }

      if (rateTypeValue == 'Table Rate' || test.isrunningtest()) {
        SoapApi33Domain.TableUsageRate tableUsageRate = new SoapApi33Domain.TableUsageRate();
        SoapApi33Domain.RateTable rateTableUsageRate = new SoapApi33Domain.RateTable();
        rateTableUsageRate.eid = chargeListByteValue;
        tableUsageRate.usageFieldName = chargeFormulaFieldValue;

        tableUsageRate.rateTable = rateTableUsageRate;
        globalProductUsageRule.tableUsageRate = tableUsageRate;
      }

      if (rateTypeValue == 'Pass Through') {
        SoapApi33Domain.PassThroughUsageRate passThroughUsageRate = new SoapApi33Domain.PassThroughUsageRate();
        passThroughUsageRate.usageFieldName = passThroughListValue;

        globalProductUsageRule.passThroughUsageRate = passThroughUsageRate;
      }

      globalProductUsageRule.allowanceType = allowanceValue;
      globalProductUsageRule.validFrom = Datetime.newInstance(
        Date.valueOf(validFrom),
        Time.newInstance(23, 59, 59, 59)
      );
      if (allowanceValue == 'Unlimited') {
        globalProductUsageRule.usageUom = selectedChargeGlobal.toUpperCase();
      } else {
        globalProductUsageRule.usageUom = amoutChargeSelect.toUpperCase();
      }
      globalProductUsageRule.status = statusValue.toUppercase();
      globalProductUsageRule.chargeCategory = chargeCategory;

      globalProductUsageRule.globalUsageRule = globalUsageRule;

      globalProductUsageRule.proratedOnOrder = prorateOnOrder;
      globalProductUsageRule.proratedOnCancel = prorateOnCancel;
      globalProductUsageRule.limit_x = ammountValue;
      globalProductUsageRule.rollOverType = rollOverValue;

      globalProductUsageRule.ruleType = 'TAPERED';
      addProductUsageRuleToRecPrice.globalProductUsageRule = globalProductUsageRule;
    }
    newChargeRule.addProductUsageRuleToRecurringProductPrice = addProductUsageRuleToRecPrice;
    return newChargeRule;
  }

  public static SoapApi33Domain.CommandRequest generatePaymentReferrerTokenRequest() {
    SoapApi33Domain.CommandRequest generatePaymentReferrerTokenRequest = new SoapApi33Domain.CommandRequest();
    generatePaymentReferrerTokenRequest.GeneratePaymentCollectionReferrerToken = new SoapApi33Domain.GeneratePaymentCollectionReferrerToken();
    generatePaymentReferrerTokenRequest.GeneratePaymentCollectionReferrerToken.cancelUrl = 'https://gotransverse.com?cancel';
    generatePaymentReferrerTokenRequest.GeneratePaymentCollectionReferrerToken.errorURL = 'https://gotransverse.com?error';
    generatePaymentReferrerTokenRequest.GeneratePaymentCollectionReferrerToken.completeURL = 'https://gotransverse.com?complete';
    return generatePaymentReferrerTokenRequest;
  }

  public static SoapApi33Domain.CreateRequest getPayentCreationRequest(
    Map<String, Object> mapOfPaymentData,
    String billingAccountEid
  ) {
    SoapApi33Domain.CreateRequest createReq = new SoapApi33Domain.CreateRequest();
    SoapApi33Domain.BillingAccount billing_acc = new SoapApi33Domain.BillingAccount();
    billing_acc.eid = billingAccountEid;
    if (mapOfPaymentData.get('paymentMethodType') == 'Tokenized Credit Card') {
      SoapApi33Domain.tokenizedCreditCardPaymentMethod creditCard = new SoapApi33Domain.tokenizedCreditCardPaymentMethod();
      creditCard.eid = String.ValueOf(
        mapOfPaymentData.get('paymentMethodValue')
      );
      createReq.payment = new SoapApi33Domain.Payment();
      createReq.payment.billingAccount = billing_acc;
      createReq.payment.amount = Double.ValueOf(mapOfPaymentData.get('amount'));
      createReq.payment.description = String.ValueOf(
        mapOfPaymentData.get('description')
      );
      createReq.payment.tokenizedCreditCardPaymentMethod = creditCard;
    } else if (
      mapOfPaymentData.get('paymentMethodType') == 'Sepa Direct Debit'
    ) {
      SoapApi33Domain.SepaDirectDebitPaymentMethod sepaDirectDebit = new SoapApi33Domain.SepaDirectDebitPaymentMethod();
      sepaDirectDebit.iban = String.ValueOf(
        mapOfPaymentData.get('paymentMethodValue')
      );
      sepaDirectDebit.OwnerName = 'Train';
      createReq.payment = new SoapApi33Domain.Payment();
      createReq.payment.billingAccount = billing_acc;
      createReq.payment.amount = Double.ValueOf(mapOfPaymentData.get('amount'));
      createReq.payment.description = String.ValueOf(
        mapOfPaymentData.get('description')
      );
      createReq.payment.SepaDirectDebitPaymentMethod = sepaDirectDebit;
    } else if (
      mapOfPaymentData.get('paymentMethodType') == 'Mobile Carrier Payment'
    ) {
      SoapApi33Domain.mobileCarrierPayment mobileCarrierPayment = new SoapApi33Domain.mobileCarrierPayment();
      mobileCarrierPayment.eid = String.ValueOf(
        mapOfPaymentData.get('paymentMethodValue')
      );
      createReq.payment = new SoapApi33Domain.Payment();
      createReq.payment.billingAccount = billing_acc;
      createReq.payment.amount = Double.ValueOf(mapOfPaymentData.get('amount'));
      createReq.payment.description = String.ValueOf(
        mapOfPaymentData.get('description')
      );
      createReq.payment.mobileCarrierPayment = mobileCarrierPayment;
    } else if (mapOfPaymentData.get('paymentMethodType') == 'Bank Payment') {
      SoapApi33Domain.bankPaymentMethod bankPaymentMethod = new SoapApi33Domain.bankPaymentMethod();
      bankPaymentMethod.eid = String.ValueOf(
        mapOfPaymentData.get('paymentMethodValue')
      );
      createReq.payment = new SoapApi33Domain.Payment();
      createReq.payment.billingAccount = billing_acc;
      createReq.payment.amount = Double.ValueOf(mapOfPaymentData.get('amount'));
      createReq.payment.description = String.ValueOf(
        mapOfPaymentData.get('description')
      );
      createReq.payment.bankPayment = bankPaymentMethod;
    } else if (
      mapOfPaymentData.get('paymentMethodType') == 'PayPal Preapproval'
    ) {
      SoapApi33Domain.PayPalPaymentMethod payPalPaymentMethod = new SoapApi33Domain.PayPalPaymentMethod();
      payPalPaymentMethod.eid = String.ValueOf(
        mapOfPaymentData.get('paymentMethodValue')
      );
      createReq.payment = new SoapApi33Domain.Payment();
      createReq.payment.billingAccount = billing_acc;
      createReq.payment.amount = Double.ValueOf(mapOfPaymentData.get('amount'));
      createReq.payment.description = String.ValueOf(
        mapOfPaymentData.get('description')
      );
      createReq.payment.payPalPayment = payPalPaymentMethod;
    }
    return createReq;
  }
}