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
 * This Wrapper is used to carry the permission set information to the Tract Configuration lightning component.
 * @author Aman Jain
 */

global class PermSetWrapper {
  @AuraEnabled
  global String getsets { get; set; }
  @AuraEnabled
  global boolean status { get; set; }
  @AuraEnabled
  global String name { get; set; }
  @AuraEnabled
  global Integer order { get; set; }
}