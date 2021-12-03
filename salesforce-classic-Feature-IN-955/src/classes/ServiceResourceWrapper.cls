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
 * This Wrapper is used to carry service resource information to the Add service resource lightning component.
 * @author AMAN JAIN
 */

public with sharing class ServiceResourceWrapper {
  @AuraEnabled
  public String eid { get; set; }
  @AuraEnabled
  public String identifier { get; set; }
  @AuraEnabled
  public String errorMessage { get; set; }
}