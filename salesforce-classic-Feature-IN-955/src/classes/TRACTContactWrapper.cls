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
 * This Wrapper is used to parse the API response for persons.
 * @author AMAN JAIN
 */

public with sharing class TRACTContactWrapper {
  @AuraEnabled
  public List<ContactWrapper> contactWrapperList { get; set; }
  @AuraEnabled
  public Integer totalPage { get; set; }
}