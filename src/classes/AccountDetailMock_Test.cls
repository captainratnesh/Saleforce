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
 * This class is a test class of AccountDetailMock class.
 * @author Anurag Srivastava
 */

@isTest
global class AccountDetailMock_Test implements WebServiceMock {
  global void doInvoke(
    Object stub,
    Object request,
    Map<String, Object> response,
    String endpoint,
    String soapAction,
    String requestName,
    String responseNS,
    String responseName,
    String responseType
  ) {
    //  docSample.EchoStringResponse_element respElement =
    //      new docSample.EchoStringResponse_element();
    //  respElement.EchoStringResult = 'Mock response';
    System.assertNotEquals(request, null);
    response.put('response_x', 'DEEP');
  }
}