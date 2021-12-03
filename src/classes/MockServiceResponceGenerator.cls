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
** Module Name   : MockServiceResponceGenerator
** 
**
** Revision History:-
** Version             Date            Author                Description of Action:
** 1.0                 22/04/2019      AMAN JAIN          This class is no longer in use but it is global so can’t be deleted from the package.

******************************************************************************************************************************/

@isTest
global class MockServiceResponceGenerator implements WebServiceMock{
  global void doInvoke ( Object stub,
           Object request,
           Map < String, Object > response,
           String endpoint,
           String soapAction,  
           String requestName,
           String responseNS,
           String responseName,
           String responseType ) {
               if(requestName.equalsIgnoreCase('create')) {
               	 
               }
                if(requestName.equalsIgnoreCase('authorize')) {
               	 
               }
               if(requestName.equalsIgnoreCase('command')) {
               	  
               }
               if(requestName.equalsIgnoreCase('update')) {
               	 
               }
               if(requestName.equalsIgnoreCase('batch')) {
               	 
               }  
               if(requestName.equalsIgnoreCase('query')) {
               	
               }
       }
}