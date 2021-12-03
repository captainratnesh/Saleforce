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
 * The service custom field query response wrapper.
 * @author AMAN JAIN
 */
global class GTVServiceCustomField {
  public String id;
  public String name;
  public String fieldType;
  public String fieldValidationType;
  public List<GTVCustomFieldRefrence> refrences;

  global class GTVCustomFieldRefrence {
    public String id;
    public String status;
    public String value;
  }
}