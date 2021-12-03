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
 * The class contains the inner classes and methods to make SOAP API callouts for various entities
 * @author AMAN JAIN
 */

public class SoapApi33Service {
  public class batchResponse {
    public SoapApi33Domain.BatchResponse return_x;
    private String[] return_x_type_info = new List<String>{
      'return',
      'http://www.tractbilling.com/billing/1_33/service',
      null,
      '0',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/service',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'return_x' };
  }
  public class TractRequest {
    public Integer requestId;
    private String[] requestId_att_info = new List<String>{ 'requestId' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/service',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class query {
    public SoapApi33Domain.QueryRequest queryRequest;
    private String[] queryRequest_type_info = new List<String>{
      'queryRequest',
      'http://www.tractbilling.com/billing/1_33/service',
      null,
      '0',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/service',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'queryRequest' };
  }
  public class batch {
    public SoapApi33Domain.BatchRequest batchRequest;

    private String[] batchRequest_type_info = new List<String>{
      'batchRequest',
      'http://www.tractbilling.com/billing/1_33/service',
      null,
      '0',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/service',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'batchRequest' };
  }

  public class commandBatch {
    public SoapApi33Domain.CommandBatchRequest batchRequest;
    private String[] batchRequest_type_info = new List<String>{
      'batchRequest',
      'http://www.tractbilling.com/billing/1_33/service',
      null,
      '0',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/service',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'batchRequest' };
  }

  public class TractResponse {
    public Integer requestId;
    private String[] requestId_att_info = new List<String>{ 'requestId' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/service',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class fault {
    public String failureReason;
    public String description;
    private String[] failureReason_type_info = new List<String>{
      'failureReason',
      'http://www.tractbilling.com/billing/1_33/service',
      null,
      '1',
      '1',
      'true'
    };
    private String[] description_type_info = new List<String>{
      'description',
      'http://www.tractbilling.com/billing/1_33/service',
      null,
      '1',
      '1',
      'true'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/service',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'failureReason',
      'description'
    };
  }
  public class createResponse {
    public SoapApi33Domain.CreateResponse return_x;
    private String[] return_x_type_info = new List<String>{
      'return',
      'http://www.tractbilling.com/billing/1_33/service',
      null,
      '0',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/service',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'return_x' };
  }
  public class update_x {
    public SoapApi33Domain.UpdateRequest updateRequest;
    private String[] updateRequest_type_info = new List<String>{
      'updateRequest',
      'http://www.tractbilling.com/billing/1_33/service',
      null,
      '0',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/service',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'updateRequest'
    };
  }
  public class command {
    public SoapApi33Domain.CommandRequest commandRequest;
    private String[] commandRequest_type_info = new List<String>{
      'commandRequest',
      'http://www.tractbilling.com/billing/1_33/service',
      null,
      '0',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/service',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'commandRequest'
    };
  }
  public class entityObject {
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/service',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class queryResponse {
    public SoapApi33Domain.QueryResponse return_x;
    private String[] return_x_type_info = new List<String>{
      'return',
      'http://www.tractbilling.com/billing/1_33/service',
      null,
      '0',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/service',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'return_x' };
  }
  public class commandResponse {
    public SoapApi33Domain.CommandResponse return_x;
    private String[] return_x_type_info = new List<String>{
      'return',
      'http://www.tractbilling.com/billing/1_33/service',
      null,
      '0',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/service',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'return_x' };
  }
  public class create {
    public SoapApi33Domain.CreateRequest createRequest;
    private String[] createRequest_type_info = new List<String>{
      'createRequest',
      'http://www.tractbilling.com/billing/1_33/service',
      null,
      '0',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/service',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'createRequest'
    };
  }
  public class FaultResponse {
    public String description;
    public String failureReason;
    public String message;
    public Integer requestId;
    private String[] description_att_info = new List<String>{ 'description' };
    private String[] failureReason_att_info = new List<String>{
      'failureReason'
    };
    private String[] message_att_info = new List<String>{ 'message' };
    private String[] requestId_att_info = new List<String>{ 'requestId' };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/service',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{};
  }
  public class authorize {
    public SoapApi33Domain.AuthorizationRequest authorizationRequest;
    private String[] authorizationRequest_type_info = new List<String>{
      'authorizationRequest',
      'http://www.tractbilling.com/billing/1_33/service',
      null,
      '0',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/service',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{
      'authorizationRequest'
    };
  }
  public class authorizeResponse {
    public SoapApi33Domain.AuthorizationResponse return_x;
    private String[] return_x_type_info = new List<String>{
      'return',
      'http://www.tractbilling.com/billing/1_33/service',
      null,
      '0',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/service',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'return_x' };
  }
  public class updateResponse {
    public SoapApi33Domain.UpdateResponse return_x;
    private String[] return_x_type_info = new List<String>{
      'return',
      'http://www.tractbilling.com/billing/1_33/service',
      null,
      '0',
      '1',
      'false'
    };
    private String[] apex_schema_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/service',
      'true',
      'false'
    };
    private String[] field_order_type_info = new List<String>{ 'return_x' };
  }
  public class TractPort {
    public String endpoint_x = 'https://stage.gotransverse.com/t/s/billing/1.30';
    public Map<String, String> inputHttpHeaders_x;
    public Map<String, String> outputHttpHeaders_x;
    public String clientCertName_x;
    public String clientCert_x;
    public String clientCertPasswd_x;
    public Integer timeout_x;
    private String[] ns_map_type_info = new List<String>{
      'http://www.tractbilling.com/billing/1_33/service',
      'SoapApi33Service',
      'http://www.tractbilling.com/billing/1_33/domain',
      'SoapApi33Domain'
    };
    public SoapApi33Domain.AuthorizationResponse authorize(
      SoapApi33Domain.AuthorizationRequest authorizationRequest
    ) {
      SoapApi33Service.authorize request_x = new SoapApi33Service.authorize();
      request_x.authorizationRequest = authorizationRequest;
      SoapApi33Service.authorizeResponse response_x;
      Map<String, SoapApi33Service.authorizeResponse> response_map_x = new Map<String, SoapApi33Service.authorizeResponse>();
      response_map_x.put('response_x', response_x);
      WebServiceCallout.invoke(
        this,
        request_x,
        response_map_x,
        new List<String>{
          endpoint_x,
          '',
          'http://www.tractbilling.com/billing/1_33/service',
          'authorize',
          'http://www.tractbilling.com/billing/1_33/service',
          'authorizeResponse',
          'SoapApi33Service.authorizeResponse'
        }
      );
      response_x = response_map_x.get('response_x');
      return response_x.return_x;
    }
    public SoapApi33Domain.CommandResponse command(
      SoapApi33Domain.CommandRequest commandRequest
    ) {
      SoapApi33Service.command request_x = new SoapApi33Service.command();
      request_x.commandRequest = commandRequest;
      SoapApi33Service.commandResponse response_x;
      Map<String, SoapApi33Service.commandResponse> response_map_x = new Map<String, SoapApi33Service.commandResponse>();
      response_map_x.put('response_x', response_x);
      WebServiceCallout.invoke(
        this,
        request_x,
        response_map_x,
        new List<String>{
          endpoint_x,
          '',
          'http://www.tractbilling.com/billing/1_33/service',
          'command',
          'http://www.tractbilling.com/billing/1_33/service',
          'commandResponse',
          'SoapApi33Service.commandResponse'
        }
      );
      response_x = response_map_x.get('response_x');
      return response_x.return_x;
    }
    public SoapApi33Domain.BatchResponse batch(
      SoapApi33Domain.BatchRequest batchRequest
    ) {
      SoapApi33Service.batch request_x = new SoapApi33Service.batch();
      request_x.batchRequest = batchRequest;
      SoapApi33Service.batchResponse response_x;
      Map<String, SoapApi33Service.batchResponse> response_map_x = new Map<String, SoapApi33Service.batchResponse>();
      response_map_x.put('response_x', response_x);
      WebServiceCallout.invoke(
        this,
        request_x,
        response_map_x,
        new List<String>{
          endpoint_x,
          '',
          'http://www.tractbilling.com/billing/1_33/service',
          'batch',
          'http://www.tractbilling.com/billing/1_33/service',
          'batchResponse',
          'SoapApi33Service.batchResponse'
        }
      );
      response_x = response_map_x.get('response_x');
      return response_x.return_x;
    }

    public SoapApi33Domain.BatchResponse Batchcommand(
      SoapApi33Domain.CommandBatchRequest batchRequest
    ) {
      SoapApi33Service.commandBatch request_x = new SoapApi33Service.commandBatch();
      request_x.batchRequest = batchRequest;
      SoapApi33Service.batchResponse response_x;
      Map<String, SoapApi33Service.batchResponse> response_map_x = new Map<String, SoapApi33Service.batchResponse>();
      response_map_x.put('response_x', response_x);
      WebServiceCallout.invoke(
        this,
        request_x,
        response_map_x,
        new List<String>{
          endpoint_x,
          '',
          'http://www.tractbilling.com/billing/1_33/service',
          'batch',
          'http://www.tractbilling.com/billing/1_33/service',
          'batchResponse',
          'SoapApi33Service.batchResponse'
        }
      );
      response_x = response_map_x.get('response_x');
      return response_x.return_x;
    }

    public SoapApi33Domain.CreateResponse create(
      SoapApi33Domain.CreateRequest createRequest
    ) {
      SoapApi33Service.create request_x = new SoapApi33Service.create();
      request_x.createRequest = createRequest;
      SoapApi33Service.createResponse response_x;
      Map<String, SoapApi33Service.createResponse> response_map_x = new Map<String, SoapApi33Service.createResponse>();
      response_map_x.put('response_x', response_x);
      WebServiceCallout.invoke(
        this,
        request_x,
        response_map_x,
        new List<String>{
          endpoint_x,
          '',
          'http://www.tractbilling.com/billing/1_33/service',
          'create',
          'http://www.tractbilling.com/billing/1_33/service',
          'createResponse',
          'SoapApi33Service.createResponse'
        }
      );
      response_x = response_map_x.get('response_x');
      return response_x.return_x;
    }
    public SoapApi33Domain.UpdateResponse update_x(
      SoapApi33Domain.UpdateRequest updateRequest
    ) {
      SoapApi33Service.update_x request_x = new SoapApi33Service.update_x();
      request_x.updateRequest = updateRequest;
      SoapApi33Service.updateResponse response_x;
      Map<String, SoapApi33Service.updateResponse> response_map_x = new Map<String, SoapApi33Service.updateResponse>();
      response_map_x.put('response_x', response_x);
      WebServiceCallout.invoke(
        this,
        request_x,
        response_map_x,
        new List<String>{
          endpoint_x,
          '',
          'http://www.tractbilling.com/billing/1_33/service',
          'update',
          'http://www.tractbilling.com/billing/1_33/service',
          'updateResponse',
          'SoapApi33Service.updateResponse'
        }
      );
      response_x = response_map_x.get('response_x');
      return response_x.return_x;
    }
    public SoapApi33Domain.QueryResponse query(
      SoapApi33Domain.QueryRequest queryRequest
    ) {
      SoapApi33Service.query request_x = new SoapApi33Service.query();
      request_x.queryRequest = queryRequest;
      SoapApi33Service.queryResponse response_x;
      Map<String, SoapApi33Service.queryResponse> response_map_x = new Map<String, SoapApi33Service.queryResponse>();
      response_map_x.put('response_x', response_x);
      WebServiceCallout.invoke(
        this,
        request_x,
        response_map_x,
        new List<String>{
          endpoint_x,
          '',
          'http://www.tractbilling.com/billing/1_33/service',
          'query',
          'http://www.tractbilling.com/billing/1_33/service',
          'queryResponse',
          'SoapApi33Service.queryResponse'
        }
      );
      response_x = response_map_x.get('response_x');
      return response_x.return_x;
    }
  }
}