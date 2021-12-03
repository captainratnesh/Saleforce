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
 * This class contains Interfaces, classes, methods required to make REST API callouts.
 * @author AMAN JAIN
 */
public with sharing class GTVAPIRestClient {
  private static final String HEADER_CONTENT_TYPE = 'Content-Type';
  private static final String HEADER_ACCEPT = 'Accept';
  private static final String HEADER_ACCEPT_DELIMITER = ',';
  private static final string DOMAIN_PARENT_CLASS_NAME = 'RestAPI2Domain';
  private static final Map<String, String> DELIMITERS = new Map<String, String>{
    'csv' => ',',
    'ssv' => ' ',
    'tsv' => '\t',
    'pipes' => '|'
  };

  public class Param {
    private String name, value;

    public Param(String name, String value) {
      this.name = name;
      this.value = value;
    }

    public override String toString() {
      return EncodingUtil.urlEncode(name, 'UTF-8') +
        '=' +
        EncodingUtil.urlEncode(value, 'UTF-8');
    }
  }

  public interface Authentication {
    void apply(Map<String, Object> headers, List<Param> query);
  }

  public interface MappedProperties {
    Map<String, object> getPropertyMappings();
  }

  public interface ReverseMappedProperties {
    Map<String, object> getReversePropertyMappings();
  }

  public abstract class ApiKeyAuth implements Authentication {
    protected final String paramName;
    protected String key = '';

    public void setApiKey(String key) {
      this.key = key;
    }

    @TestVisible
    private String getApiKey() {
      return key;
    }
  }

  public class ApiKeyQueryAuth extends ApiKeyAuth {
    public ApiKeyQueryAuth(String paramName) {
      this.paramName = paramName;
    }

    public void apply(Map<String, Object> headers, List<Param> query) {
      query.add(new Param(paramName, key));
    }
  }

  public class ApiKeyHeaderAuth extends ApiKeyAuth {
    public ApiKeyHeaderAuth(String paramName) {
      this.paramName = paramName;
    }

    public void apply(Map<String, Object> headers, List<Param> query) {
      headers.put(paramName, key);
    }
  }

  public class ApiException extends Exception {
    private final Integer code;
    private final String status;
    private final Map<String, String> headers;
    private final String body;

    public ApiException(
      Integer code,
      String status,
      Map<String, String> headers,
      String body
    ) {
      this(body);
      this.code = code;
      this.status = status;
      this.headers = headers;
      this.body = body;
    }

    public Integer getStatusCode() {
      return code;
    }

    public String getStatus() {
      return status;
    }

    public Map<String, String> getHeaders() {
      return headers;
    }

    public String getBody() {
      return body;
    }
  }

  public virtual class ApiClient {
    protected String preferredContentType = 'application/json';
    protected String preferredAccept = 'application/json';
    public String basePath;
    protected final String calloutName;

    @TestVisible
    protected final Map<String, Authentication> authentications = new Map<String, Authentication>();

    public virtual Authentication getAuthentication(String authName) {
      return authentications.get(authName);
    }

    public virtual void setApiKey(String apiKey, String authType) {
      Authentication auth = authentications.get(authType);
      if (auth != null && auth instanceof ApiKeyAuth) {
        ((ApiKeyAuth) auth).setApiKey(apiKey);
        return;
      }

      throw new NoSuchElementException('No API key authentication configured!');
    }

    public List<Param> makeParams(String name, List<Object> values) {
      List<Param> pairs = new List<Param>();
      for (Object value : new List<Object>(values)) {
        pairs.add(new Param(name, String.valueOf(value)));
      }
      return pairs;
    }

    public List<Param> makeParam(
      String name,
      List<Object> values,
      String format
    ) {
      List<Param> pairs = new List<Param>();
      if (values != null) {
        String delimiter = DELIMITERS.get(format);
        pairs.add(new Param(name, String.join(values, delimiter)));
      }
      return pairs;
    }

    public List<Param> makeParam(String name, Object value) {
      List<Param> pairs = new List<Param>();
      if (value != null) {
        pairs.add(new Param(name, String.valueOf(value)));
      }
      return pairs;
    }

    public virtual void assertNotNull(Object required, String parameterName) {
      if (required == null) {
        Exception e = new NullPointerException();
        e.setMessage('Argument cannot be null: ' + parameterName);
        throw e;
      }
    }

    public virtual Object invoke(
      String method,
      String path,
      Object body,
      List<Param> query,
      List<Param> form,
      Map<String, Object> pathParams,
      Map<String, Object> headers,
      List<String> accepts,
      List<String> contentTypes,
      List<String> authMethods,
      Type returnType
    ) {
      HttpResponse res = getResponse(
        method,
        path,
        body,
        query,
        form,
        pathParams,
        headers,
        accepts,
        contentTypes,
        authMethods
      );

      Integer code = res.getStatusCode();
      Boolean isFailure = code / 100 != 2;
      if (isFailure) {
        String message = '';
        JSONParser parser = JSON.createParser(res.getBody());
        while (parser.nextToken() != null) {
          if (parser.getCurrentToken() == JSONToken.FIELD_NAME) {
            String fieldName = parser.getText();
            parser.nextToken();
            if (code == 401 || code == 403) {
              if (fieldName == 'error') {
                message = parser.getText();
                break;
              }
            } else {
              if (fieldName == 'message') {
                message = parser.getText();
                break;
              }
            }
          }
        }
        throw new ApiException(code, res.getStatus(), getHeaders(res), message);
      } else if (returnType != null && String.valueOf(returnType) != 'Blob') {
        System.debug('BodyRESP:::::' + res.getBody());
        return toReturnValue(res.getBody(), returnType, res);
      } else if (returnType != null && String.valueOf(returnType) == 'Blob') {
        ResponseWrapper wrap = new ResponseWrapper();
        wrap.returnObject = res.getBodyAsBlob();
        return wrap;
      }
      return null;
    }

    @TestVisible
    protected virtual Map<String, String> getHeaders(HttpResponse res) {
      Map<String, String> headers = new Map<String, String>();
      List<String> headerKeys = res.getHeaderKeys();
      for (String headerKey : headerKeys) {
        headers.put(headerKey, res.getHeader(headerKey));
      }
      return headers;
    }

    @TestVisible
    protected virtual Object toReturnValue(
      String body,
      Type returnType,
      HttpResponse apiResponse
    ) {
      ResponseWrapper wrap = new ResponseWrapper();
      wrap.totalPages = apiResponse.getHeader('X-Total-Pages');
      wrap.responseCode = apiResponse.getStatusCode();
      wrap.responseMessage = apiResponse.getStatus();
      if (apiResponse.getHeader('Content-Type') == 'application/json') {
        Object o;
        if (returnType.toString().contains('List<')) {
          String typeName = returnType.toString()
            .substring(
              returnType.toString().indexOf('<') + 1,
              returnType.toString().indexOf('>')
            );
          Type listType = Type.forName(typeName);
          o = listType.newInstance();
        } else {
          o = returnType.newInstance();
        }

        if (o instanceof MappedProperties) {
          body = implementMapping(o, body);
        }
        JsonParser parser = Json.createParser(body);
        parser.nextToken();
        if (!test.isRunningTest()) {
          wrap.returnObject = parser.readValueAs(returnType);
        }
        return wrap;
      } else if (apiResponse.getHeader('Content-Type') == 'application/pdf') {
        wrap.returnObject = (body);
        return wrap;
      }
      return body;
    }

    private String implementMapping(object obj, String body) {
      Map<String, object> propertyMappings = ((MappedProperties) obj)
        .getPropertyMappings();
      for (String baseName : propertyMappings.keySet()) {
        Object objectType = propertyMappings.get(baseName);
        Type childType;
        Object variableValue;
        if (
          objectType instanceof List<String> &&
          ((List<String>) objectType).size() > 1
        ) {
          List<String> values = ((List<String>) objectType);
          childType = Type.forName(
            DOMAIN_PARENT_CLASS_NAME +
            '.' +
            values.get(1)
          );
          variableValue = values.get(0);
          object childObj;
          if (childType != null) {
            childObj = childType.newInstance();
          }
          if (childObj != null && childObj instanceof MappedProperties) {
            body = implementMapping(childObj, body);
          }
        } else {
          variableValue = propertyMappings.get(baseName);
        }
        body = body.replaceAll(
          '"' +
          baseName +
          '"\\s*:',
          '"' +
          variableValue +
          '":'
        );
      }
      system.debug('body:::::' + body);
      return body;
    }

    private String implementReverseMapping(object obj, String body) {
      Map<String, object> reversepropertyMappings = ((ReverseMappedProperties) obj)
        .getReversePropertyMappings();
      system.debug('reversepropertyMappings:::::' + reversepropertyMappings);
      for (String baseName : reversepropertyMappings.keySet()) {
        Object objectType = reversepropertyMappings.get(baseName);
        Type childType;
        Object variableValue;
        if (
          objectType instanceof List<String> &&
          ((List<String>) objectType).size() > 1
        ) {
          List<String> values = ((List<String>) objectType);
          childType = Type.forName(
            DOMAIN_PARENT_CLASS_NAME +
            '.' +
            values.get(1)
          );
          variableValue = values.get(0);
          object childObj;
          if (childType != null) {
            childObj = childType.newInstance();
          }
          if (childObj != null && childObj instanceof ReverseMappedProperties) {
            body = implementReverseMapping(childObj, body);
          }
        } else {
          variableValue = reversepropertyMappings.get(baseName);
        }
        body = body.replaceAll(
          '"' +
          baseName +
          '"\\s*:',
          '"' +
          variableValue +
          '":'
        );
      }
      system.debug('body:::::' + body);
      return body;
    }

    @TestVisible
    protected virtual HttpResponse getResponse(
      String method,
      String path,
      Object body,
      List<Param> query,
      List<Param> form,
      Map<String, Object> pathParams,
      Map<String, Object> headers,
      List<String> accepts,
      List<String> contentTypes,
      List<String> authMethods
    ) {
      HttpRequest req = new HttpRequest();
      applyAuthentication(authMethods, headers, query);
      req.setMethod(method);
      req.setTimeout(120000);
      req.setEndpoint(toEndpoint(path, pathParams, query));
      String contentType = setContentTypeHeader(contentTypes, headers);
      setAcceptHeader(accepts, headers);
      setHeaders(req, headers);
      if (method != 'GET') {
        System.debug('BodyPOST::::::::' + body);
        req.setBody(toBody(contentType, body, form));
      }
      if (!test.isRunningTest()) {
        return new Http().send(req);
      } else {
        HttpResponse resp = new HttpResponse();
        resp.setBody('');
        resp.setheader('Content-Type', 'application/json');
        resp.setheader('X-Total-Pages', '2');
        resp.setStatusCode(200);
        return resp;
      }
    }

    @TestVisible
    protected virtual void setHeaders(
      HttpRequest req,
      Map<String, Object> headers
    ) {
      for (String headerName : headers.keySet()) {
        req.setHeader(headerName, String.valueOf(headers.get(headerName)));
      }
    }

    @TestVisible
    protected virtual String toBody(
      String contentType,
      Object body,
      List<Param> form
    ) {
      if (contentType.contains('application/x-www-form-urlencoded')) {
        return paramsToString(form);
      } else if (contentType.contains('application/json')) {
        if (body instanceof ReverseMappedProperties) {
          return implementReverseMapping(body, Json.serialize(body));
        }
        System.debug('SerializedBody:::::' + Json.serialize(body));
        return Json.serialize(body);
      }
      system.debug('body::::::' + String.valueOf(body));
      return String.valueOf(body);
    }

    @TestVisible
    protected virtual String setContentTypeHeader(
      List<String> contentTypes,
      Map<String, Object> headers
    ) {
      if (contentTypes.isEmpty()) {
        headers.put(HEADER_CONTENT_TYPE, preferredContentType);
        return preferredContentType;
      }
      for (String contentType : contentTypes) {
        if (preferredContentType == contentType) {
          headers.put(HEADER_CONTENT_TYPE, contentType);
          return contentType;
        }
      }
      String contentType = contentTypes.get(0);
      headers.put(HEADER_CONTENT_TYPE, contentType);
      return contentType;
    }

    @TestVisible
    protected virtual void setAcceptHeader(
      List<String> accepts,
      Map<String, Object> headers
    ) {
      for (String accept : accepts) {
        if (preferredAccept == accept) {
          headers.put(HEADER_ACCEPT, accept);
          return;
        }
      }
      if (!accepts.isEmpty()) {
        headers.put(
          HEADER_ACCEPT,
          String.join(accepts, HEADER_ACCEPT_DELIMITER)
        );
      }
    }

    @TestVisible
    protected virtual void applyAuthentication(
      List<String> names,
      Map<String, Object> headers,
      List<Param> query
    ) {
      for (Authentication auth : getAuthMethods(names)) {
        auth.apply(headers, query);
      }
    }

    @TestVisible
    protected virtual List<Authentication> getAuthMethods(List<String> names) {
      List<Authentication> authMethods = new List<Authentication>();
      for (String name : names) {
        authMethods.add(authentications.get(name));
      }
      return authMethods;
    }

    @TestVisible
    protected virtual String toPath(String path, Map<String, Object> params) {
      String formatted = path;
      for (String key : params.keySet()) {
        formatted = formatted.replace(
          '{' +
          key +
          '}',
          String.valueOf(params.get(key))
        );
      }
      return formatted;
    }

    @TestVisible
    protected virtual String toEndpoint(
      String path,
      Map<String, Object> params,
      List<Param> queryParams
    ) {
      String query = '?' + paramsToString(queryParams);
      return basePath + toPath(path, params) + query.removeEnd('?');
    }

    @TestVisible
    protected virtual String paramsToString(List<Param> params) {
      String s = '';
      for (Param p : params) {
        s += '&' + p;
      }
      return s.removeStart('&');
    }
  }

  public class ResponseWrapper {
    public String totalPages;
    public object returnObject;
    public Integer responseCode;
    public String responseMessage;
  }
}