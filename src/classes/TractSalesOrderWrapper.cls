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
 * This Wrapper class is used to carry the Sales order information to the account detail lightning component.
 * @author AMAN JAIN
 */

public with sharing class TractSalesOrderWrapper {
    @AuraEnabled
    public Integer totalPage{get;set;}
    @AuraEnabled
    public List<SalesWrapper> salesOrderWrapperList{get;set;}
}