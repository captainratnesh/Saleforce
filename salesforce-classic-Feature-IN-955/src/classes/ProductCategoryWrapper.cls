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

/*******************************************************************************************************************
** Module Name   : ProductCategoryWrapper
** 
**
** Revision History:-
** Version             Date            Author                Description of Action:
** 1.0                 22/04/2019      AMAN JAIN       This Wrapper is used to parse the API response for the Product category.
******************************************************************************************************************************/

public with sharing class ProductCategoryWrapper {
    @AuraEnabled public String Name; 
    @AuraEnabled public String categoryId;
}