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
 * This class contains methods to store fields mapping for billing account creation.
 * @author AMAN JAIN
 */

public with sharing class AccountMappingController {
  /**
   * @params accountId Id of the currrent Account
   * @return AccountMappingWrapper details of the accountMapping
   * @description - To show the user field values based on the settings the user has applied
   */

  @AuraEnabled
  public static AccountMappingWrapper showAccountMap(String accountId) {
    TRACT_Mappings__c mapTract = [
      SELECT id, Name, TRACT_Account_Fields__c
      FROM TRACT_Mappings__c
      WHERE Name = 'TRACT Account Mapping'
    ];
    Map<String, Object> mapOfaccountFieldsVsValues = new Map<String, Object>();
    AccountMappingWrapper wrap = new AccountMappingWrapper();
    String fieldValues = '';
    String whereClauseName = '';
    String whereClauseNumber = '';
    list<string> returnString = new List<string>();
    if (mapTract != null) {
      mapOfaccountFieldsVsValues = (Map<String, Object>) JSON.deserializeUntyped(
        mapTract.TRACT_Account_Fields__c
      );
      wrap.mapOfNamesVsVales = new Map<String, String>();
      for (String accountFields : mapOfaccountFieldsVsValues.keySet()) {
        List<Object> strList = (List<Object>) mapOfaccountFieldsVsValues.get(
          accountFields
        );
        if (!(String.valueof(strList[1]) == 'Select from the Same Record')) {
          whereClauseName = '';
          if (
            String.valueOf(strList[2]) != null &&
            String.valueOf(strList[2]) != ''
          ) {
            if (String.valueOf(strList[2]).substringBetween(' ') == 'equals') {
              whereClauseName =
                String.valueOf(strList[2]).substringBefore(' ') +
                '=' +
                '\'' +
                String.valueOf(strList[2]).substringAfterLast(' ') +
                '\'';
            } else if (String.valueOf(strList[2]).contains('starts with')) {
              whereClauseName =
                String.valueOf(strList[2]).substringBefore(' ') +
                ' LIKE ' +
                '\'' +
                String.valueOf(strList[2]).substringAfter('starts with ') +
                '%' +
                '\'';
            } else if (String.valueOf(strList[2]).contains('ends with')) {
              whereClauseName =
                String.valueOf(strList[2]).substringBefore(' ') +
                ' LIKE ' +
                '\'' +
                '%' +
                String.valueOf(strList[2]).substringAfter('ends with ') +
                '\'';
            } else if (String.valueOf(strList[2]).contains('contains')) {
              whereClauseName =
                String.valueOf(strList[2]).substringBefore(' ') +
                ' LIKE ' +
                '\'' +
                '%' +
                String.valueOf(strList[2]).substringAfter('contains ') +
                '%' +
                '\'';
            }
          }
          fieldValues = getAccountFieldValue(
            accountId,
            String.valueOf(strList[0]),
            wrap,
            whereClauseName
          );
          wrap.mapOfNamesVsVales.put(accountFields, fieldValues);
        } else {
          fieldValues = getAccountFieldValue(
            accountId,
            String.valueOf(strList[0]),
            wrap,
            ''
          );
          wrap.mapOfNamesVsVales.put(accountFields, fieldValues);
        }
      }
    }
    return wrap;
  }

  /**
   * @params accountId Id of the currrent Account
   * @params valuesToQuery the partivular field
   * @params wrap mapping wrapper
   * @params whereClause where clause of the query
   * @return String to query the final value
   * @description - used by the above method to query the final value
   */

  @AuraEnabled
  public static String getAccountFieldValue(
    String accountId,
    String valuesToQuery,
    AccountMappingWrapper wrap,
    String whereClause
  ) {
    TRACT_Mappings__c getall = [
      SELECT id, Name
      FROM TRACT_Mappings__c
      WHERE Name = 'TRACT Account Mapping'
    ];
    list<string> returnString = new List<string>();
    String finalStringToQur = '';
    String fieldtoQuery = '';
    String nestedFIelds = '';
    String finalValue = '';
    String query = '';
    if (valuesToQuery.contains('.')) {
      fieldtoQuery = valuesToQuery.substringAfterLast('.');
      if (valuesToQuery.contains('Contact')) {
        nestedFIelds = fieldtoQuery;
        returnString.add(nestedFIelds);
        query =
          'SELECT ' +
          String.join(returnString, ', ') +
          ' from Contact where AccountId=:accountId';
        if (whereClause != '') {
          query = query + ' AND ' + whereClause;
        }
        query = query + ' order by CreatedDate ASC';
      } else {
        nestedFIelds = convertNametoQuery(
          valuesToQuery.substringBeforeLast('.'),
          'Account'
        );
        nestedFIelds = nestedFIelds + fieldtoQuery;
        returnString.add(nestedFIelds);
        query =
          'SELECT Id, ' +
          String.join(returnString, ', ') +
          ' from Account where id=:accountId limit 1';
      }

      List<sObject> objList = database.query(query);
      wrap.accountRelatedListRecords = objList;
      if (!objList.isEmpty()) {
        sobject obj = objList[0];
        for (String str : NestedFIelds.split('\\.')) {
          if (str != fieldtoQuery) {
            if (obj.getSObject(str) != null) {
              obj = (sObject) obj.getSObject(str);
            } else {
              finalValue = '';
              break;
            }
          } else {
            if (obj.get(str) != null) {
              finalValue = String.valueOf(obj.get(str));
            } else {
              finalValue = '';
              break;
            }
          }
        }
      }
    } else {
      fieldtoQuery = convertFieldName(valuesToQuery);
      if (fieldtoQuery != null) {
        returnString.add(fieldtoQuery);
        query =
          'SELECT ' +
          String.join(returnString, ', ') +
          ' from Account where id=:accountId limit 1';
        List<Account> accList = database.query(query);
        finalValue = String.valueOf(accList[0].get(returnString[0]));
      }
    }
    return finalValue;
  }

  /**
   * @params nestedString The String based on which the fields values are to be queried
   * @params objectName
   * @return String the final string to query
   * @description - used by the above method to query the final value
   */
  private static String convertNametoQuery(
    String nestedString,
    String objectName
  ) {
    String queryName = '';
    list<String> strList = new List<String>();
    for (String str : nestedString.split('\\.')) {
      if (
        Schema.getGlobalDescribe()
          .get(objectname)
          .getDescribe()
          .fields.getMap()
          .containsKey(str) &&
        !Schema.getGlobalDescribe()
          .get(objectname)
          .getDescribe()
          .fields.getMap()
          .get(str)
          .getDescribe()
          .getReferenceTo()
          .isEmpty()
      ) {
        objectname = Schema.getGlobalDescribe()
            .get(objectname)
            .getDescribe()
            .fields.getMap()
            .get(str)
            .getDescribe()
            .getReferenceTo()[0]
          .getDescribe()
          .getName();
        if (str.endsWith('__c')) {
          queryName = queryName + str.replace('__c', '__r') + '.';
        } else if (str.endsWith('Id')) {
          queryName = queryName + str.removeEnd('Id') + '.';
        }
      } else {
        queryName = queryName + str;
      }
    }
    return queryName;
  }
  /**
   * @params accInfo To convert the field name
   * @return String to query the final value
   * @description - used by the above method to query the final value
   */
  private static String convertFieldName(String accInfo) {
    list<String> strList = new List<String>();
    List<SelectOption> fieldsName = new List<SelectOption>();
    SObjectType accountType = Schema.getGlobalDescribe().get('Account');
    Map<String, Schema.SObjectField> mfields = accountType.getDescribe()
      .fields.getMap();
    if (mfields.containsKey(accInfo)) {
      return accInfo;
    } else {
      return null;
    }
  }
}