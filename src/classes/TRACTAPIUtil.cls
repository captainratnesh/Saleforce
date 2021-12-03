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

public with sharing class TRACTAPIUtil {
  /**************************************************************************
   * @description This Method is used to check field level security.
   * @param sObjectType sObject Name in form of string
   * @param commaDelimitedFields comma separated fields of sObject
   * @param typeOfDml dml type Create/Update/Query/Upsert
   * @return securityPass.
   */
  public static boolean checkFieldLevelSecurity(
    String sObjectType,
    String commaDelimitedFields,
    String typeOfDml
  ) {
    SObjectType schemaType = Schema.getGlobalDescribe().get(sObjectType);
    Map<String, SObjectField> fields = schemaType.getDescribe().fields.getMap();

    boolean securityPass = true;
    for (String field : commaDelimitedFields.split(',')) {
      if (
        fields.get(field) != null &&
        fields.get(field).getDescribe() != null &&
        fields.get(field).getDescribe().isPermissionable()
      ) {
        if (typeOfDml == 'Create') {
          if (!fields.get(field).getDescribe().isCreateable()) {
            securityPass = false;
          }
        } else if (typeOfDml == 'Update') {
          if (!fields.get(field).getDescribe().isUpdateable()) {
            securityPass = false;
          }
        } else if (typeOfDml == 'Query') {
          if (!fields.get(field).getDescribe().isAccessible()) {
            securityPass = false;
          }
        } else if (typeOfDml == 'Upsert') {
          if (
            (!fields.get(field).getDescribe().isUpdateable()) ||
            (!fields.get(field).getDescribe().isCreateable())
          ) {
            securityPass = false;
          }
        }
      }
    }
    return securityPass;
  }
}