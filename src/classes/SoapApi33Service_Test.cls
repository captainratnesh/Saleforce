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
 * This class is a test class of SoapApi33Service class.
 * @author Aman Jain
 */

@isTest
private class SoapApi33Service_Test {
  @isTest
  static void myUnitTest() {
    //Test.setMock(WebServiceMock.class, new SoapApi30Service_Mock());
    new SoapApi33Service.batchResponse();
    new SoapApi33Service.query();
    new SoapApi33Service.batch();
    new SoapApi33Service.createResponse();
    new SoapApi33Service.update_x();
    new SoapApi33Service.command();
    new SoapApi33Service.queryResponse();
    new SoapApi33Service.commandResponse();
    new SoapApi33Service.create();
    new SoapApi33Service.authorize();
    new SoapApi33Service.authorizeResponse();
    new SoapApi33Service.updateResponse();
    SoapApi33Domain.QueryRequest req = new SoapApi33Domain.QueryRequest();
    SoapApi33Service.TractPort services = new SoapApi33Service.TractPort();
    SoapApi33Service.TractRequest tractRequestobj = new SoapApi33Service.TractRequest();
    SoapApi33Service.TractResponse tractResponseobj = new SoapApi33Service.TractResponse();
    SoapApi33Service.fault faultobj = new SoapApi33Service.fault();
    SoapApi33Service.entityObject entityObjectobj = new SoapApi33Service.entityObject();
    SoapApi33Service.FaultResponse faultResponseobj = new SoapApi33Service.FaultResponse();
    SoapApi33Service.TractPort port = new SoapApi33Service.TractPort();
    System.assertNotEquals(req, null);
  }
}