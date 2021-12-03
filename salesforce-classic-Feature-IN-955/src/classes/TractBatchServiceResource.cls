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
** Module Name   : ScheduleChargesWrapper
** 
**
** Revision History:-
** Version             Date            Author                Description of Action:
** 1.0                 22/04/2019      AMAN JAIN     /** 
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
** Module Name   : TractBatchServiceResource


** 
**
** Revision History:-
** Version             Date            Author                Description of Action:
** 1.0                 22/04/2019      AMAN JAIN    This class is no longer in use but it is global so can’t be deleted from the package.


******************************************************************************************************************************/



global class TractBatchServiceResource implements Database.Batchable<sObject>,Database.AllowsCallouts,Database.Stateful{
	global long  totalExecution=0;
	global Integer totalSizeOfService=0; 
	
	@deprecated
	global TractSetup__c  tractConfig;
	
	public Tract_Setup__c  tractSetup;
	
	global String entityType; 
	global String paramName;
	global String paramValue;
	global String queryScope;
	global long totalElements;
	global list<String> strCategoryId;
	global String serviceResourceCategoryEids;
	global Integer totalSize;
	global integer  checkMe = 0;
	  
	
	@deprecated
	global TractBatchServiceResource(TractSetup__c tractConfig,String entityType, String paramName, String paramValue, String queryScope, list<String> str, Integer totalSize){
		this.tractSetup = tractSetup;
		this.entityType = entityType; 
		this.paramName = paramName;
		this.paramValue = paramValue;
		this.queryScope = queryScope;
		this.totalElements = totalElements;
		this.strCategoryId = str; 
		this.totalSize = totalSize; 
	}
	
	public TractBatchServiceResource(Tract_Setup__c tractSetup,String entityType, String paramName, String paramValue, String queryScope, list<String> str, Integer totalSize){
		/*this.tractSetup = tractSetup;
		this.entityType = entityType; 
		this.paramName = paramName;
		this.paramValue = paramValue;
		this.queryScope = queryScope;
		this.totalElements = totalElements;
		this.strCategoryId = str; 
		this.totalSize = totalSize; */
	}
	
	global Database.QueryLocator start(Database.BatchableContext bc) {
		String query = 'select id FROM Account limit '+strCategoryId.size() ;
		
		return Database.getQueryLocator(query); 
	}
	
	 
	global void execute(Database.BatchableContext BC, list<sObject> scope){
		/*list<Tract_Setup__c> apiVersion= SoapApiGeneral.tractSetup();
		
		if(apiVersion != null && apiVersion.size() > 0){
			if(apiVersion[0].Api_Version__c == '30'){
				SoapApi30Domain.QueryResponse queryResponse1;
				queryResponse1 = SoapApi30Adapter.queryTractByParamAndValue(tractSetup, 'ServiceResource', 'serviceResourceCategoryEid',
		            									strCategoryId[checkMe], 1, 1, null );
				SoapApi30Domain.ServiceResource[] tempSRList;
				SoapApi30Domain.ServiceResource[] srList = new List<SoapApi30Domain.ServiceResource>();
				
				 if(queryResponse1.successful) {
				 		
					long totalElements = queryResponse1.serviceResources.totalElements;
					long totalPages = totalElements / 50 + 1;
				 	
								//Find total elements and query in batch of 50 till all products are found and added to list
				 	for(Integer counter = 1;counter <= totalPages; counter++) {
				 		SoapApi30Domain.QueryResponse qr1 = SoapApi30Adapter.queryTractByParamAndValue(tractSetup, 
				 											'ServiceResource', 'serviceResourceCategoryEid',
				 												strCategoryId.get(checkMe) , counter, 50, 'DEEP');
				 			
						if(qr1.successful && qr1.serviceResources != null
							 && qr1.serviceResources.serviceResource != null){
							srList.addAll(qr1.serviceResources.serviceResource);
						}
						
					}
					
					Integer[] updateList = SoapApi30Adapter.doServiceResource(srList);
					
				 }
				 
				 checkMe++;
			}
		}*/
	}
    
	
	global void finish(Database.BatchableContext BC){
	}
}