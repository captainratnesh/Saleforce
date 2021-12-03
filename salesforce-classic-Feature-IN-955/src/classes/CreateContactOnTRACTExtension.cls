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
 * This class is used to call the API request to create Contact from Salesforce to GTV.
 * @author Aman Jain
 */

public with sharing class CreateContactOnTRACTExtension {
  public Boolean contactAllreadyMovedToTract { get; set; }
  public Contact conObj { get; set; }
  public String userTheme { get; set; }
  public Boolean doReload { get; set; }
  /**
   *This a Standard Controller Contructor.
   */
  public CreateContactOnTRACTExtension(
    ApexPages.StandardController stdController
  ) {
    userTheme = UserInfo.getUIThemeDisplayed();
    doReload = false;
    List<Contact> conList = new List<Contact>();
    if (
      TRACTAPIUtil.checkFieldLevelSecurity(
        'Contact',
        'id,Tract_Contact_Eid__c',
        'Query'
      )
    ) {
      if (null != stdController.getRecord().id) {
        conList = [
          SELECT id, Account.Tract_Billing_Account__c, Tract_Contact_Eid__c
          FROM contact
          WHERE id = :stdController.getRecord().id
        ];
      }
    }
    if (conList.size() > 0) {
      conObj = conList[0];
      if (
        null != conObj.Tract_Contact_Eid__c &&
        conObj.Tract_Contact_Eid__c != ''
      ) {
        contactAllreadyMovedToTract = true;
      } else {
        contactAllreadyMovedToTract = false;
      }
    }
  }
  /**
   * Calls the method to make API callout on TRACT to create Contact from Salesforce.
   */
  public void createContactOnTract() {
    if (null != conObj.Account.Tract_Billing_Account__c) {
      String errorMessage = SoapApi30Adapter.contactUpdateOnAccount(conObj.Id);
      system.debug('errorMessage:::::::::' + errorMessage);
      if (
        errorMessage !=
        'Contact has been added to the billing Account successfully.'
      ) {
        ApexPages.Message errorMsg = new ApexPages.Message(
          ApexPages.Severity.WARNING,
          errorMessage
        );
        ApexPages.addMessage(errorMsg);
        doReload = false;
      } else {
        doReload = true;
      }
    } else {
      ApexPages.Message errorMsg = new ApexPages.Message(
        ApexPages.Severity.WARNING,
        'Error: Parent Account does not exist'
      );
      ApexPages.addMessage(errorMsg);
      doReload = false;
    }
  }
}