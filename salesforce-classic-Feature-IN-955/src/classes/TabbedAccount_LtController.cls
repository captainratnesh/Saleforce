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
 * This class is used to call the API request to create a billing account from Salesforce to GTV.
 * @author AMAN JAIN
 */

public class TabbedAccount_LtController {
  /**
   *Method to check for billing account.
   *@param accountId
   *@return accountId
   */
  @AuraEnabled
  public static Account checkBilingAccount(string accountId) {
    Account thisAccount = [
      SELECT
        Id,
        Name,
        BillingStreet,
        BillingCity,
        BillingPostalCode,
        BillingState,
        BillingCountry,
        AccountNumber,
        ShippingStreet,
        ShippingCity,
        ShippingPostalCode,
        ShippingState,
        ShippingCountry,
        Description,
        Phone,
        NumberOfEmployees,
        Tract_Billing_Account__c,
        Email__c,
        Account_Create_Date__c,
        Currency_Type__c,
        Tax_Exempt__c
      FROM Account
      WHERE id = :accountId
      LIMIT 1
    ];
    return thisAccount;
  }
  /**
   *Method to save account after configuration.
   *@param accountId salesforce account ID
   *@return error message
   */
  @AuraEnabled
  public static string saveAccount(string accountId) {
    string error = 'NoError';
    list<TRACT_Setup__c> tractList = new List<TRACT_Setup__c>();
    tractList = [
      SELECT
        id,
        TPassword__c,
        Tract_User_Name__c,
        TRACT_URL__c,
        Mapped_Custom_Field_Id__c,
        Active__c
      FROM TRACT_Setup__c
      WHERE Active__c = TRUE
      LIMIT 1
    ];
    TRACT_Setup__c tract = new TRACT_Setup__c();
    if (tractList.size() > 0) {
      tract = tractList[0];
    }
    list<Account> thisAccountList = [
      SELECT
        Id,
        Name,
        BillingStreet,
        BillingCity,
        GTV_Bill_Cycle__c,
        BillingPostalCode,
        BillingState,
        BillingCountry,
        AccountNumber,
        ShippingStreet,
        ShippingCity,
        ShippingPostalCode,
        ShippingState,
        ShippingCountry,
        Description,
        Phone,
        NumberOfEmployees,
        Tract_Billing_Account__c,
        Email__c,
        GTV_Payment_Term__c,
        Account_Create_Date__c,
        GTV_Account_Category__c,
        Currency_Type__c,
        Tax_Exempt__c,
        Error_Message__c,
        Status__c,
        Gotransverse_Bill_Type__c
      FROM Account
      WHERE id = :accountId
      LIMIT 1
    ];
    Account thisAccount = thisAccountList[0];
    TRACTBillingAccountCategory__c bAC;
    List<TRACTBillingAccountCategory__c> bACList = [
      SELECT id, eid__c, type_x__c
      FROM TRACTBillingAccountCategory__c
      WHERE type_x__c = :thisAccount.GTV_Account_Category__c
      LIMIT 1
    ];
    if (bACList.size() > 0) {
      bAC = bACList[0];
    } else {
      error = 'Please select the Billing Account Category.';
      return error;
    }
    string bACEid = bAC.eid__c;
    string paymentTerm;
    map<String, Payment_Term__c> paymntTermMap = getPaymentTerm();

    if (paymntTermMap.containsKey(thisAccount.GTV_Payment_Term__c)) {
      paymentTerm = paymntTermMap.get(thisAccount.GTV_Payment_Term__c).eid__c;
    } else {
      if (paymntTermMap.containsKey('Net 30')) {
        paymentTerm = paymntTermMap.get('Net 30').eid__c;
      } else {
        return 'Please select a Payment Term';
      }
    }
    string currencyType;
    TRACT_Bill_Cycle__c billCycle;
    List<TRACT_Bill_Cycle__c> billCycleList = [
      SELECT
        id,
        Eid__c,
        Name,
        Bill_Cycle_Type__c,
        TRACT_Bill_Cycle_Currency_Type__c
      FROM TRACT_Bill_Cycle__c
      WHERE Name = :thisAccount.GTV_Bill_Cycle__c
      LIMIT 1
    ];
    if (billCycleList.size() > 0) {
      billCycle = billCycleList[0];
    } else {
      error = 'Please select the Bill Cycle.';
      return error;
    }
    if (null == billCycle) {
      return 'Bill Cycle does not exist with the Country.';
    }
    String billingAccountString;
    APIDataService dataService = GTVDataService.getService();
    try {
      dataService.BillingAccountCreationMapping(
        thisAccountList,
        billCycle,
        bACEid,
        paymentTerm,
        tract.Mapped_Custom_Field_Id__c
      );
    } catch (Exception exp) {
      string errorMessage;
      string exMessage = ' ' + exp.getMessage();
      if (exMessage.contains('Unexpected element')) {
        errorMessage = 'The TRACT Login UserId & Password is incorrect! Please Verify the input and try again.';
      } else if (exMessage.contains('WebService returned a SOAP Fault')) {
        errorMessage = exMessage.substring(
          exMessage.indexOf('WebService returned a SOAP Fault:') + 33,
          exMessage.indexOf('faultcode')
        );
      } else if (exMessage.contains('Validation Error:')) {
        errorMessage = exMessage.substringAfterLast('Validation Error:');
      } else if (exMessage.contains('IO Exception')) {
        errorMessage =
          'The TRACT URL is incorrect. ' +
          exMessage.substring(exMessage.indexOf('IO Exception') + 13);
      } else if (exMessage.contains('ApiException:')) {
        errorMessage = exMessage.substringAfterLast('Validation error:');
      } else {
        errorMessage = 'TRACT Server ' + exMessage;
      }
      error = errorMessage;
      thisAccount.status__c = 'Error Occurred';
      if (
        TRACTAPIUtil.checkFieldLevelSecurity('Account', 'status__c', 'Update')
      ) {
        update thisAccount;
      }
    }
    return error;
  }
  /**
   *Method to get payment term.
   *@return paymentTermMap [key:paymentTerm Name , value:paymentTerm]
   */

  public static map<String, Payment_Term__c> getPaymentTerm() {
    list<Payment_Term__c> paymentTermList = [
      SELECT Name, eid__c
      FROM Payment_Term__c
      LIMIT 1000
    ];
    map<String, Payment_Term__c> paymentTermMap = new Map<String, Payment_Term__c>();
    for (Payment_Term__c p : paymentTermList) {
      paymentTermMap.put(p.Name, p);
    }
    return paymentTermMap;
  }
}