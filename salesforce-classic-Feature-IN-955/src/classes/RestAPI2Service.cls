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
 * This class exposed GTV REST API's as apex class method.
 * @author AMAN JAIN
 */

public with sharing class RestAPI2Service {
  public with sharing class GTVAPIBillingAccountService {
    GTVAPIClient client;

    public GTVAPIBillingAccountService(GTVAPIClient client) {
      this.client = client;
    }

    public GTVAPIBillingAccountService() {
      this.client = new GTVAPIClient();
    }

    public GTVAPIClient getClient() {
      return this.client;
    }

    /**
     * Add a parent BillingAccount to the specified BillingAccount
     * @param id The internal id of an object. (required)
     * @param changeParentBillingAccount The payload for changing a parent billing account (required)
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    /*  public void addParentBillingAccount(Map<String, Object> params) {
        client.assertNotNull(params.get('id'), 'id');
        client.assertNotNull(params.get('changeParentBillingAccount'), 'changeParentBillingAccount');
        List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
        List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

        client.invoke(
            'POST', '/billing-accounts/{id}/parent',
            (GTVAPIChangeParentBillingAccount) params.get('changeParentBillingAccount'),
            query, form,
            new Map<String, Object>{
                'id' => (String) params.get('id')
            },
            new Map<String, Object>(),
            new List<String>{ 'application/json' },
            new List<String>{ 'application/json' },
            new List<String> { 'x-api-key', 'bearer' },
            null
        );
    }*/
    /**
     * Add a responsible BillingAccount to the specified BillingAccount
     * Add a responsible BillingAccount to the specified BillingAccount
     * @param id The internal id of an object. (required)
     * @param changeResponsibleAccount The payload for changing a responsible account (required)
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    /*public void addResponsibleAccount(Map<String, Object> params) {
        client.assertNotNull(params.get('id'), 'id');
        client.assertNotNull(params.get('changeResponsibleAccount'), 'changeResponsibleAccount');
        List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
        List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

        client.invoke(
            'POST', '/billing-accounts/{id}/responsible-account',
            (GTVAPIChangeResponsibleAccount) params.get('changeResponsibleAccount'),
            query, form,
            new Map<String, Object>{
                'id' => (String) params.get('id')
            },
            new Map<String, Object>(),
            new List<String>{ 'application/json' },
            new List<String>{ 'application/json' },
            new List<String> { 'x-api-key', 'bearer' },
            null
        );
    }*/
    /**
     * Change a parent BillingAccount to the specified BillingAccount
     * Change a parent BillingAccount to the specified BillingAccount
     * @param id The internal id of an object. (required)
     * @param changeParentBillingAccount The payload for changing a parent billing account (required)
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    /* public void changeParentBillingAccount(Map<String, Object> params) {
        client.assertNotNull(params.get('id'), 'id');
        client.assertNotNull(params.get('changeParentBillingAccount'), 'changeParentBillingAccount');
        List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
        List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

        client.invoke(
            'PUT', '/billing-accounts/{id}/parent',
            (GTVAPIChangeParentBillingAccount) params.get('changeParentBillingAccount'),
            query, form,
            new Map<String, Object>{
                'id' => (String) params.get('id')
            },
            new Map<String, Object>(),
            new List<String>{ 'application/json' },
            new List<String>{ 'application/json' },
            new List<String> { 'x-api-key', 'bearer' },
            null
        );
    }*/
    /**
     * Change a responsible BillingAccount to the specified BillingAccount
     * Change a responsible BillingAccount to the specified BillingAccount
     * @param id The internal id of an object. (required)
     * @param changeResponsibleAccount The payload for changing a responsible account (required)
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    /* public void changeResponsibleAccount(Map<String, Object> params) {
        client.assertNotNull(params.get('id'), 'id');
        client.assertNotNull(params.get('changeResponsibleAccount'), 'changeResponsibleAccount');
        List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
        List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

        client.invoke(
            'PUT', '/billing-accounts/{id}/responsible-account',
            (GTVAPIChangeResponsibleAccount) params.get('changeResponsibleAccount'),
            query, form,
            new Map<String, Object>{
                'id' => (String) params.get('id')
            },
            new Map<String, Object>(),
            new List<String>{ 'application/json' },
            new List<String>{ 'application/json' },
            new List<String> { 'x-api-key', 'bearer' },
            null
        );
    }*/
    /**
     * Create a new TRACT BillingAccount
     * Create a new account
     * @param billingAccount The TRACT billing account in JSON format (required)
     * @param prefer return&#x3D;[representation|minimal] The HTTP Prefer header. See https://tools.ietf.org/html/rfc7240 (optional)
     * @return GTVAPIBillingAccount
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper createBillingAccount(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('billingAccount'), 'billingAccount');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'POST',
        '/billing-accounts',
        (RestAPI2Domain.GTVAPICreateBillingAccount) params.get(
          'billingAccount'
        ),
        query,
        form,
        new Map<String, Object>(),
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIBillingAccount.class
      );
    }
    /**
     * Create a custom field value
     * Create a custom field value and add it to the billing account
     * @param id The internal id of an object. (required)
     * @param billingAccountCustomFieldValue The TRACT billing account custom field value in JSON format (required)
     * @param prefer return&#x3D;[representation|minimal] The HTTP Prefer header. See https://tools.ietf.org/html/rfc7240 (optional)
     * @return GTVAPIBillingAccountCustomFieldVal
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper createBillingAccountCustomFieldValue(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('id'), 'id');
      client.assertNotNull(
        params.get('billingAccountCustomFieldValue'),
        'billingAccountCustomFieldValue'
      );
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'POST',
        '/billing-accounts/{id}/custom-field-values',
        (RestAPI2Domain.GTVAPICreateBillingAccountCustomFi) params.get(
          'billingAccountCustomFieldValue'
        ),
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIBillingAccountCustomFieldVal.class
      );
    }
    /**
     * Create Order
     * Create Order
     * @param id The internal id of an object. (required)
     * @param order The TRACT order in JSON format (required)
     * @param prefer return&#x3D;[representation|minimal] The HTTP Prefer header. See https://tools.ietf.org/html/rfc7240 (optional)
     * @return GTVAPIOrder
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    /* public GTVAPIOrder createOrder(Map<String, Object> params) {
        client.assertNotNull(params.get('id'), 'id');
        client.assertNotNull(params.get('order'), 'order');
        List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
        List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

        return (GTVAPIOrder) client.invoke(
            'POST', '/billing-accounts/{id}/orders',
            (GTVAPICreateSalesOrder) params.get('order'),
            query, form,
            new Map<String, Object>{
                'id' => (String) params.get('id')
            },
            new Map<String, Object>{
                'Prefer' => (String) params.get('prefer')
            },
            new List<String>{ 'application/json' },
            new List<String>{ 'application/json' },
            new List<String> { 'x-api-key', 'bearer' },
            GTVAPIOrder.class
        );
    }*/
    /**
     * Create a payment
     * Create payment
     * @param id The internal id of an object. (required)
     * @param payment The TRACT payment in JSON format (required)
     * @param prefer return&#x3D;[representation|minimal] The HTTP Prefer header. See https://tools.ietf.org/html/rfc7240 (optional)
     * @return GTVAPIPayment
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper createPayment(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('id'), 'id');
      client.assertNotNull(params.get('payment'), 'payment');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'POST',
        '/billing-accounts/{id}/payments',
        (RestAPI2Domain.GTVAPICreatePayment) params.get('payment'),
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIPayment.class
      );
    }
    /**
     * Create Recurring Payment
     * Create Recurring Payment
     * @param id The internal id of an object. (required)
     * @param recurringPayment The TRACT recurring payment in JSON format (required)
     * @param prefer return&#x3D;[representation|minimal] The HTTP Prefer header. See https://tools.ietf.org/html/rfc7240 (optional)
     * @return GTVAPIRecurringPayment
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper createRecurringPayment(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('id'), 'id');
      client.assertNotNull(params.get('recurringPayment'), 'recurringPayment');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'POST',
        '/billing-accounts/{id}/recurring-payments',
        (RestAPI2Domain.GTVAPICreateRecurringPayment) params.get(
          'recurringPayment'
        ),
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIRecurringPayment.class
      );
    }
    /**
     * Get the billing account specified by the id
     * Get an account
     * @param id The internal id of an object. (required)
     * @param prefer return&#x3D;[representation|minimal] The HTTP Prefer header. See https://tools.ietf.org/html/rfc7240 (optional)
     * @param r_return Specifies the amount of detail to provide in a response. (optional, default to FULL)
     * @return GTVAPIBillingAccount
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper getBillingAccount(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('return', (String) params.get('r_return')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/billing-accounts/{id}',
        '',
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIBillingAccount.class
      );
    }
    /**
     * Get an existing custom field value associated with this account
     * Get an existing custom field value associated with this account
     * @param id The internal id of an object. (required)
     * @param customFieldValueId The id of a TRACT custom field value (required)
     * @param prefer return&#x3D;[representation|minimal] The HTTP Prefer header. See https://tools.ietf.org/html/rfc7240 (optional)
     * @param r_return Specifies the amount of detail to provide in a response. (optional, default to FULL)
     * @return GTVAPIBillingAccountCustomFieldVal
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper getBillingAccountCustomFieldValue(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('id'), 'id');
      client.assertNotNull(
        params.get('customFieldValueId'),
        'customFieldValueId'
      );
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('return', (String) params.get('r_return')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/billing-accounts/{id}/custom-field-values/{custom_field_value_id}',
        '',
        query,
        form,
        new Map<String, Object>{
          'id' => (String) params.get('id'),
          'custom_field_value_id' => (String) params.get('customFieldValueId')
        },
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIBillingAccountCustomFieldVal.class
      );
    }
    /**
     * Get Order
     * Get Order
     * @param id The internal id of an object. (required)
     * @param orderId The id of a TRACT order (required)
     * @param prefer return&#x3D;[representation|minimal] The HTTP Prefer header. See https://tools.ietf.org/html/rfc7240 (optional)
     * @param r_return Specifies the amount of detail to provide in a response. (optional, default to FULL)
     * @return GTVAPIOrder
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper getOrderByBillingAccount(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('id'), 'id');
      client.assertNotNull(params.get('orderId'), 'orderId');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('return', (String) params.get('r_return')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/billing-accounts/{id}/orders/{order_id}',
        '',
        query,
        form,
        new Map<String, Object>{
          'id' => (String) params.get('id'),
          'order_id' => (String) params.get('orderId')
        },
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIOrder.class
      );
    }
    /**
     * Get an existing parent account associated with this account
     * Get an existing parent account associated with this account
     * @param id The internal id of an object. (required)
     * @param prefer return&#x3D;[representation|minimal] The HTTP Prefer header. See https://tools.ietf.org/html/rfc7240 (optional)
     * @param r_return Specifies the amount of detail to provide in a response. (optional, default to FULL)
     * @return GTVAPIBillingAccount
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper getParentBillingAccount(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('return', (String) params.get('r_return')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/billing-accounts/{id}/parent',
        '',
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIBillingAccount.class
      );
    }
    /**
     * Get an existing payment associated with this account
     * Get an existing payment associated with this account
     * @param id The internal id of an object. (required)
     * @param paymentId The id of a TRACT payment (required)
     * @param prefer return&#x3D;[representation|minimal] The HTTP Prefer header. See https://tools.ietf.org/html/rfc7240 (optional)
     * @param r_return Specifies the amount of detail to provide in a response. (optional, default to FULL)
     * @return GTVAPIPayment
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper getPaymentByBillingAccount(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('id'), 'id');
      client.assertNotNull(params.get('paymentId'), 'paymentId');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('return', (String) params.get('r_return')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/billing-accounts/{id}/payments/{payment_id}',
        '',
        query,
        form,
        new Map<String, Object>{
          'id' => (String) params.get('id'),
          'payment_id' => (String) params.get('paymentId')
        },
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIPayment.class
      );
    }
    /**
     * Query current recurring payments. Currently there is only one per billing account
     * Query for a Recurring Payment
     * @param id The internal id of an object. (required)
     * @param recurringPaymentId The id of a TRACT recurring payment (required)
     * @param prefer return&#x3D;[representation|minimal] The HTTP Prefer header. See https://tools.ietf.org/html/rfc7240 (optional)
     * @param r_return Specifies the amount of detail to provide in a response. (optional, default to FULL)
     * @return GTVAPIRecurringPayment
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper getRecurringPaymentByBillingAccount(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('id'), 'id');
      client.assertNotNull(
        params.get('recurringPaymentId'),
        'recurringPaymentId'
      );
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('return', (String) params.get('r_return')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/billing-accounts/{id}/recurring-payments/{recurring_payment_id}',
        '',
        query,
        form,
        new Map<String, Object>{
          'id' => (String) params.get('id'),
          'recurring_payment_id' => (String) params.get('recurringPaymentId')
        },
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIRecurringPayment.class
      );
    }
    /**
     * Get an existing responsible account associated with this account
     * Get an existing responsible account associated with this account
     * @param id The internal id of an object. (required)
     * @param prefer return&#x3D;[representation|minimal] The HTTP Prefer header. See https://tools.ietf.org/html/rfc7240 (optional)
     * @param r_return Specifies the amount of detail to provide in a response. (optional, default to FULL)
     * @return GTVAPIBillingAccount
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper getResponsibleAccount(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('return', (String) params.get('r_return')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/billing-accounts/{id}/responsible-account',
        '',
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIBillingAccount.class
      );
    }
    /**
     * Query for custom field values
     * Query for custom field values
     * @param id The internal id of an object. (required)
     * @param filter API query language string (optional)
     * @param prefer return&#x3D;[representation|minimal] The HTTP Prefer header. See https://tools.ietf.org/html/rfc7240 (optional)
     * @param r_return Specifies the amount of detail to provide in a response. (optional, default to FULL)
     * @param id2 The internal id of an object. (optional)
     * @param customFieldValue A custom field value (optional)
     * @param customFieldName The name of a TRACT custom field (optional)
     * @param customFieldId The id of a TRACT custom field (optional)
     * @return List<GTVAPIBillingAccountCustomFieldVal>
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper queryBillingAccountCustomFieldValues(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('filter', (String) params.get('filter')));
      query.addAll(client.makeParam('return', (String) params.get('r_return')));
      query.addAll(client.makeParam('id', (String) params.get('id2')));
      query.addAll(
        client.makeParam(
          'custom_field_value',
          (String) params.get('customFieldValue')
        )
      );
      query.addAll(
        client.makeParam(
          'custom_field_name',
          (String) params.get('customFieldName')
        )
      );
      query.addAll(
        client.makeParam(
          'custom_field_id',
          (String) params.get('customFieldId')
        )
      );

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/billing-accounts/{id}/custom-field-values',
        '',
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        List<RestAPI2Domain.GTVAPIBillingAccountCustomFieldVal>.class
      );
    }
    /**
     * Query for billing accounts with the specified query
     * Query TRACT billing accounts
     * @param filter API query language string (optional)
     * @param prefer return&#x3D;[representation|minimal] The HTTP Prefer header. See https://tools.ietf.org/html/rfc7240 (optional)
     * @param r_return Specifies the amount of detail to provide in a response. (optional, default to FULL)
     * @param pageNumber The page number for multiple page queries (optional, default to 1)
     * @param pageSize The page size for multiple page queries. Default maximum is 50 (optional, default to 50)
     * @param id The internal id of an object. (optional)
     * @param accountNum The billing account number (optional)
     * @param externalAccountNum The external account number (optional)
     * @param status The billing account status (optional)
     * @param billingAccountCategoryId The id of a TRACT billing account category (optional)
     * @param partyId The id of a TRACT party (optional)
     * @param emailAddress An email address (optional)
     * @param purchaseOrderNumber An purchase order number (optional)
     * @param orderNum (unique_key) An order number (optional)
     * @param orderId The id of a TRACT order (optional)
     * @param billType the bill type (optional)
     * @param referral the order referral (optional)
     * @param billingAccountSegmentId The id of a TRACT billing account segment (optional)
     * @param currencyCode The currency_code for the amount. (optional)
     * @param productId The id of a TRACT product (optional)
     * @param serviceId The id of a TRACT service (optional)
     * @param parentId The id of a TRACT parent billing account segment (optional)
     * @param billCycleId The id of a TRACT bill cycle (optional)
     * @param customFieldValue A custom field value (optional)
     * @param customFieldValueId The id of a TRACT custom field value (optional)
     * @param customFieldId The id of a TRACT custom field (optional)
     * @param serviceCustomFieldValue An service custom field value (optional)
     * @param serviceCustomFieldId The id of a TRACT service custom field (optional)
     * @param orderCustomFieldValue An order custom field value (optional)
     * @param orderCustomFieldId The id of a TRACT order custom field (optional)
     * @param usagePoolId The id of a TRACT usage_pool (optional)
     * @return List<GTVAPIBillingAccount>
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper queryBillingAccounts(
      Map<String, Object> params
    ) {
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('filter', (String) params.get('filter')));
      query.addAll(client.makeParam('return', (String) params.get('r_return')));
      query.addAll(
        client.makeParam('page_number', (Integer) params.get('pageNumber'))
      );
      query.addAll(
        client.makeParam('page_size', (Integer) params.get('pageSize'))
      );
      query.addAll(client.makeParam('id', (String) params.get('id')));
      query.addAll(
        client.makeParam('account_num', (String) params.get('accountNum'))
      );
      query.addAll(
        client.makeParam(
          'external_account_num',
          (String) params.get('externalAccountNum')
        )
      );
      query.addAll(client.makeParam('status', (String) params.get('status')));
      query.addAll(
        client.makeParam(
          'billing_account_category_id',
          (String) params.get('billingAccountCategoryId')
        )
      );
      query.addAll(
        client.makeParam('party_id', (String) params.get('partyId'))
      );
      query.addAll(
        client.makeParam('email_address', (String) params.get('emailAddress'))
      );
      query.addAll(
        client.makeParam(
          'purchase_order_number',
          (String) params.get('purchaseOrderNumber')
        )
      );
      query.addAll(
        client.makeParam('order_num', (String) params.get('orderNum'))
      );
      query.addAll(
        client.makeParam('order_id', (String) params.get('orderId'))
      );
      query.addAll(
        client.makeParam('bill_type', (String) params.get('billType'))
      );
      query.addAll(
        client.makeParam('referral', (String) params.get('referral'))
      );
      query.addAll(
        client.makeParam(
          'billing_account_segment_id',
          (String) params.get('billingAccountSegmentId')
        )
      );
      query.addAll(
        client.makeParam('currency_code', (String) params.get('currencyCode'))
      );
      query.addAll(
        client.makeParam('product_id', (String) params.get('productId'))
      );
      query.addAll(
        client.makeParam('service_id', (String) params.get('serviceId'))
      );
      query.addAll(
        client.makeParam('parent_id', (String) params.get('parentId'))
      );
      query.addAll(
        client.makeParam('bill_cycle_id', (String) params.get('billCycleId'))
      );
      query.addAll(
        client.makeParam(
          'custom_field_value',
          (String) params.get('customFieldValue')
        )
      );
      query.addAll(
        client.makeParam(
          'custom_field_value_id',
          (String) params.get('customFieldValueId')
        )
      );
      query.addAll(
        client.makeParam(
          'custom_field_id',
          (String) params.get('customFieldId')
        )
      );
      query.addAll(
        client.makeParam(
          'service_custom_field_value',
          (String) params.get('serviceCustomFieldValue')
        )
      );
      query.addAll(
        client.makeParam(
          'service_custom_field_id',
          (String) params.get('serviceCustomFieldId')
        )
      );
      query.addAll(
        client.makeParam(
          'order_custom_field_value',
          (String) params.get('orderCustomFieldValue')
        )
      );
      query.addAll(
        client.makeParam(
          'order_custom_field_id',
          (String) params.get('orderCustomFieldId')
        )
      );
      query.addAll(
        client.makeParam('usage_pool_id', (String) params.get('usagePoolId'))
      );

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/billing-accounts',
        '',
        query,
        form,
        new Map<String, Object>(),
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        List<RestAPI2Domain.GTVAPIBillingAccount>.class
      );
    }
    /**
     * Query Orders by BillingAccount
     * Query Orders by BillingAccount
     * @param id The internal id of an object. (required)
     * @param filter API query language string (optional)
     * @param prefer return&#x3D;[representation|minimal] The HTTP Prefer header. See https://tools.ietf.org/html/rfc7240 (optional)
     * @param r_return Specifies the amount of detail to provide in a response. (optional, default to FULL)
     * @param pageNumber The page number for multiple page queries (optional, default to 1)
     * @param pageSize The page size for multiple page queries. Default maximum is 50 (optional, default to 50)
     * @param orderId The id of a TRACT order (optional)
     * @param orderType The order type (optional)
     * @param orderNum (unique_key) An order number (optional)
     * @param status The order status (optional)
     * @param orderDate The date that the order takes place (optional)
     * @param referral the order referral (optional)
     * @param purchaseOrderNumber An purchase order number (optional)
     * @param renewalDate The reneal date for a renewal order (optional)
     * @param customFieldId The id of a TRACT custom field (optional)
     * @param customFieldValue A custom field value (optional)
     * @param customFieldValueId The id of a TRACT custom field value (optional)
     * @return List<GTVAPIOrder>
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    /* public List<GTVAPIOrder> queryOrdersByBillingAccount(Map<String, Object> params) {
        client.assertNotNull(params.get('id'), 'id');
        List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

        // cast query params to verify their expected type
        query.addAll(client.makeParam('filter', (String) params.get('filter')));
        query.addAll(client.makeParam('return', (String) params.get('r_return')));
        query.addAll(client.makeParam('page_number', (Integer) params.get('pageNumber')));
        query.addAll(client.makeParam('page_size', (Integer) params.get('pageSize')));
        query.addAll(client.makeParam('order_id', (String) params.get('orderId')));
        query.addAll(client.makeParam('order_type', (String) params.get('orderType')));
        query.addAll(client.makeParam('order_num', (String) params.get('orderNum')));
        query.addAll(client.makeParam('status', (String) params.get('status')));
        query.addAll(client.makeParam('order_date', (OffsetDateTime) params.get('orderDate')));
        query.addAll(client.makeParam('referral', (String) params.get('referral')));
        query.addAll(client.makeParam('purchase_order_number', (String) params.get('purchaseOrderNumber')));
        query.addAll(client.makeParam('renewal_date', (OffsetDateTime) params.get('renewalDate')));
        query.addAll(client.makeParam('custom_field_id', (String) params.get('customFieldId')));
        query.addAll(client.makeParam('custom_field_value', (String) params.get('customFieldValue')));
        query.addAll(client.makeParam('custom_field_value_id', (String) params.get('customFieldValueId')));

        List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

        return (List<GTVAPIOrder>) client.invoke(
            'GET', '/billing-accounts/{id}/orders', '',
            query, form,
            new Map<String, Object>{
                'id' => (String) params.get('id')
            },
            new Map<String, Object>{
                'Prefer' => (String) params.get('prefer')
            },
            new List<String>{ 'application/json' },
            new List<String>{ 'application/json' },
            new List<String> { 'x-api-key', 'bearer' },
            List<GTVAPIOrder>.class
        );
    }*/
    /**
     *
     *
     * @param id The internal id of an object. (required)
     * @param filter API query language string (optional)
     * @param prefer return&#x3D;[representation|minimal] The HTTP Prefer header. See https://tools.ietf.org/html/rfc7240 (optional)
     * @param r_return Specifies the amount of detail to provide in a response. (optional, default to FULL)
     * @param pageNumber The page number for multiple page queries (optional, default to 1)
     * @param pageSize The page size for multiple page queries. Default maximum is 50 (optional, default to 50)
     * @param occurredOn The date that the payment occurred (optional)
     * @param reference The payment reference (optional)
     * @param status The payment status (optional)
     * @param authorization The payment authorization (optional)
     * @param unappliedAmount The unapplied payment amount (optional)
     * @param token The payment token (optional)
     * @return List<GTVAPIPayment>
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    /*public List<GTVAPIPayment> queryPaymentsByBillingAccount(Map<String, Object> params) {
        client.assertNotNull(params.get('id'), 'id');
        List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

        // cast query params to verify their expected type
        query.addAll(client.makeParam('filter', (String) params.get('filter')));
        query.addAll(client.makeParam('return', (String) params.get('r_return')));
        query.addAll(client.makeParam('page_number', (Integer) params.get('pageNumber')));
        query.addAll(client.makeParam('page_size', (Integer) params.get('pageSize')));
        query.addAll(client.makeParam('occurred_on', (OffsetDateTime) params.get('occurredOn')));
        query.addAll(client.makeParam('reference', (String) params.get('reference')));
        query.addAll(client.makeParam('status', (String) params.get('status')));
        query.addAll(client.makeParam('authorization', (String) params.get('authorization')));
        query.addAll(client.makeParam('unapplied_amount', (Double) params.get('unappliedAmount')));
        query.addAll(client.makeParam('token', (String) params.get('token')));

        List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

        return (List<GTVAPIPayment>) client.invoke(
            'GET', '/billing-accounts/{id}/payments', '',
            query, form,
            new Map<String, Object>{
                'id' => (String) params.get('id')
            },
            new Map<String, Object>{
                'Prefer' => (String) params.get('prefer')
            },
            new List<String>{ 'application/json' },
            new List<String>{ 'application/json' },
            new List<String> { 'x-api-key', 'bearer' },
            List<GTVAPIPayment>.class
        );
    }*/
    /**
     * Query current recurring payments. Currently there is only one per billing account
     * Query for Recurring Payment
     * @param id The internal id of an object. (required)
     * @param filter API query language string (optional)
     * @param prefer return&#x3D;[representation|minimal] The HTTP Prefer header. See https://tools.ietf.org/html/rfc7240 (optional)
     * @param r_return Specifies the amount of detail to provide in a response. (optional, default to FULL)
     * @param pageNumber The page number for multiple page queries (optional, default to 1)
     * @param pageSize The page size for multiple page queries. Default maximum is 50 (optional, default to 50)
     * @param token The payment token (optional)
     * @param validFrom The valid from date time (optional)
     * @param validTo The valid to date time (optional)
     * @param autoPayment Is the payment an auto payment? (optional)
     * @return List<GTVAPIRecurringPayment>
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    /* public List<GTVAPIRecurringPayment> queryRecurringPaymentsByBillingAccount(Map<String, Object> params) {
        client.assertNotNull(params.get('id'), 'id');
        List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

        // cast query params to verify their expected type
        query.addAll(client.makeParam('filter', (String) params.get('filter')));
        query.addAll(client.makeParam('return', (String) params.get('r_return')));
        query.addAll(client.makeParam('page_number', (Integer) params.get('pageNumber')));
        query.addAll(client.makeParam('page_size', (Integer) params.get('pageSize')));
        query.addAll(client.makeParam('token', (String) params.get('token')));
        query.addAll(client.makeParam('valid_from', (OffsetDateTime) params.get('validFrom')));
        query.addAll(client.makeParam('valid_to', (OffsetDateTime) params.get('validTo')));
        query.addAll(client.makeParam('auto_payment', (Boolean) params.get('autoPayment')));

        List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

        return (List<GTVAPIRecurringPayment>) client.invoke(
            'GET', '/billing-accounts/{id}/recurring-payments', '',
            query, form,
            new Map<String, Object>{
                'id' => (String) params.get('id')
            },
            new Map<String, Object>{
                'Prefer' => (String) params.get('prefer')
            },
            new List<String>{ 'application/json' },
            new List<String>{ 'application/json' },
            new List<String> { 'x-api-key', 'bearer' },
            List<GTVAPIRecurringPayment>.class
        );
    }*/
    /**
     * Remove an existing custom field value associated with this account
     * Remove an existing custom field value associated with this account
     * @param id The internal id of an object. (required)
     * @param customFieldValueId The id of a TRACT custom field value (required)
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public void removeBillingAccountCustomFieldValue(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('id'), 'id');
      client.assertNotNull(
        params.get('customFieldValueId'),
        'customFieldValueId'
      );
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      client.invoke(
        'DELETE',
        '/billing-accounts/{id}/custom-field-values/{custom_field_value_id}',
        '',
        query,
        form,
        new Map<String, Object>{
          'id' => (String) params.get('id'),
          'custom_field_value_id' => (String) params.get('customFieldValueId')
        },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        null
      );
    }
    /**
     * Remove an existing parent account associated with this account
     * Remove an existing parent account associated with this account
     * @param id The internal id of an object. (required)
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public void removeParentAccount(Map<String, Object> params) {
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      client.invoke(
        'DELETE',
        '/billing-accounts/{id}/parent',
        '',
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        null
      );
    }
    /**
     * Remove an existing responsible account associated with this account
     * Remove an existing responsible account associated with this account
     * @param id The internal id of an object. (required)
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public void removeResponsibleAccount(Map<String, Object> params) {
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      client.invoke(
        'DELETE',
        '/billing-accounts/{id}/responsible-account',
        '',
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        null
      );
    }
    /**
     * Update the billing account specified by the id
     * Update an account
     * @param id The internal id of an object. (required)
     * @param billingAccount The TRACT billing account in JSON format (required)
     * @param prefer return&#x3D;[representation|minimal] The HTTP Prefer header. See https://tools.ietf.org/html/rfc7240 (optional)
     * @return GTVAPIBillingAccount
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper updateBillingAccount(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('id'), 'id');
      client.assertNotNull(params.get('billingAccount'), 'billingAccount');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'PUT',
        '/billing-accounts/{id}',
        (RestAPI2Domain.GTVAPIBillingAccount) params.get('billingAccount'),
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIBillingAccount.class
      );
    }
    /**
     * Update an existing custom field value associated with this account
     * Update an existing custom field value associated with this account
     * @param id The internal id of an object. (required)
     * @param customFieldValueId The id of a TRACT custom field value (required)
     * @param billingAccountCustomFieldValue The TRACT billing account custom field value in JSON format (required)
     * @param prefer return&#x3D;[representation|minimal] The HTTP Prefer header. See https://tools.ietf.org/html/rfc7240 (optional)
     * @return GTVAPIBillingAccountCustomFieldVal
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    /* public GTVAPIBillingAccountCustomFieldVal updateBillingAccountCustomFieldValue(Map<String, Object> params) {
        client.assertNotNull(params.get('id'), 'id');
        client.assertNotNull(params.get('customFieldValueId'), 'customFieldValueId');
        client.assertNotNull(params.get('billingAccountCustomFieldValue'), 'billingAccountCustomFieldValue');
        List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
        List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

        return (GTVAPIBillingAccountCustomFieldVal) client.invoke(
            'PUT', '/billing-accounts/{id}/custom-field-values/{custom_field_value_id}',
            (GTVAPIUpdateBillingAccountCustomFi) params.get('billingAccountCustomFieldValue'),
            query, form,
            new Map<String, Object>{
                'id' => (String) params.get('id'),
                'custom_field_value_id' => (String) params.get('customFieldValueId')
            },
            new Map<String, Object>{
                'Prefer' => (String) params.get('prefer')
            },
            new List<String>{ 'application/json' },
            new List<String>{ 'application/json' },
            new List<String> { 'x-api-key', 'bearer' },
            GTVAPIBillingAccountCustomFieldVal.class
        );
    }*/

    /**
     * Suspend billing account
     * Suspends a billing account with the specified ID.
     * @param id The internal ID of the object. (required)
     * @param suspendBillingAccount A payload for suspending the billing account with the specified ID. (required)
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public void suspendBillingAccount(Map<String, Object> params) {
      client.assertNotNull(params.get('id'), 'id');
      client.assertNotNull(
        params.get('suspendBillingAccount'),
        'suspendBillingAccount'
      );
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      client.invoke(
        'POST',
        '/billing-accounts/{id}/suspend',
        (RestAPI2Domain.GTVAPISuspendBillingAccount) params.get(
          'suspendBillingAccount'
        ),
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        null
      );
    }

    /**
     * Deactivate billing account
     * Deactivates a billing account with the specified ID.
     * @param id The internal ID of the object. (required)
     * @param deactivateBillingAccount A payload for deactivating the billing account with the specified ID. (required)
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public void deactivateBillingAccount(Map<String, Object> params) {
      client.assertNotNull(params.get('id'), 'id');
      client.assertNotNull(
        params.get('deactivateBillingAccount'),
        'deactivateBillingAccount'
      );
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      client.invoke(
        'POST',
        '/billing-accounts/{id}/deactivate',
        (RestAPI2Domain.GTVAPIDeactivateBillingAccount) params.get(
          'deactivateBillingAccount'
        ),
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        null
      );
    }

    /**
     * Resume billing account
     * Resumes a billing account with the specified ID.
     * @param id The internal ID of the object. (required)
     * @param resumeBillingAccount A payload for resuming the billing account with the specified ID. (required)
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public void resumeBillingAccount(Map<String, Object> params) {
      client.assertNotNull(params.get('id'), 'id');
      client.assertNotNull(
        params.get('resumeBillingAccount'),
        'resumeBillingAccount'
      );
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      client.invoke(
        'POST',
        '/billing-accounts/{id}/resume',
        (RestAPI2Domain.GTVAPIResumeBillingAccount) params.get(
          'resumeBillingAccount'
        ),
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        null
      );
    }
  }
  /*
   * TRACT Billing API
   * Create and manage billing accounts, products, orders, services, billing, invoicing, payments, and the general ledger. This microservice provides core functionality for the goTransverse billing platform.
   *
   * OpenAPI spec version: 2
   *
   *
   * NOTE: This class is auto generated by the swagger code generator program.
   * https://github.com/swagger-api/swagger-codegen.git
   * Do not edit the class manually.
   */

  public class GTVAPIBillingAccountCategoryService {
    GTVAPIClient client;

    public GTVAPIBillingAccountCategoryService(GTVAPIClient client) {
      this.client = client;
    }

    public GTVAPIBillingAccountCategoryService() {
      this.client = new GTVAPIClient();
    }

    public GTVAPIClient getClient() {
      return this.client;
    }

    /**
     * Get billing account category by ID
     * Retrieves an existing billing acount category with the specified billing account category ID.
     * @param id The internal ID of the object. (required)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @return GTVBillingAccountCategory
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper getBillingAccountCategory(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('return', (String) params.get('r_return')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/billing-account-categories/{id}',
        '',
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVBillingAccountCategory.class
      );
    }
    /**
     * Get billing account categories
     * Retrieves the existing billing account categories.
     * @param filter API query language string. The syntax of the API query language is similar to SQL, the criteria are expressed in the form of predicates.\nOn the left side of the equation, there is a name of the available query parameter (for example, billing_account_id). On the right side, there is a constant value in single quotes (\&#39;sample value\&#39;). Brackets are used to group predicates, for example, \&#39;(start_date GT \&#39;1994-01-24T23:33:07+00:00\&#39;)\&#39;. Use the following logical operators: AND - conjunction, OR - disjunction, NOT - negation. Compare operators: NEQ - Not equals, EQ - Equals, LT - Less, LTE - Less or equals, GT - Greater, GTE - Greater or equals, IS NULL - Is null, IS NOT NULL - Is not null, LIKE - Match pattern (LIKE operator is only applicable to parameters of the string type). Wildcard characters: \&#39;%\&#39; - matches any number of characters, including no characters, \&#39;_\&#39; - matches exactly one character.\nHere is the sample query: the account_num GT \&#39;15\&#39; AND (name LIKE \&#39;start of name% end of name\&#39; OR status EQ \&#39;ACTIVE\&#39;).\n (optional)
     * @param r_sort Arranges search results in either ascending or descending order. By default, response results are sorted in the ascending order. To sort results in the descending order, use &quot;-&quot;. For example, the &quot;-name.&quot; value sorts the results in the descending order by name, and &quot;id&quot; sorts results in the ascending order by ID. (optional)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @param pageNumber The page number for multiple page queries. (optional, default to 1)
     * @param pageSize The page size for multiple page queries. Default maximum is 50. (optional, default to 50)
     * @param id The internal ID of the object. (optional)
     * @param categoryName The name of the billing account category. (optional)
     * @param categoryDescription The description of the billing account category. (optional)
     * @param status The status of the billing account category. (optional, default to ACTIVE)
     * @param preferredLanguageCode The preferred language on a billing account in the ISO-639-1 format. (optional)
     * @return List<GTVBillingAccountCategory>
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper queryBillingAccountCategories(
      Map<String, Object> params
    ) {
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('filter', (String) params.get('filter')));
      query.addAll(
        client.makeParam('sort', (List<String>) params.get('r_sort'), 'csv')
      );
      query.addAll(client.makeParam('return', (String) params.get('r_return')));
      query.addAll(
        client.makeParam('page_number', (Integer) params.get('pageNumber'))
      );
      query.addAll(
        client.makeParam('page_size', (Integer) params.get('pageSize'))
      );
      query.addAll(client.makeParam('id', (String) params.get('id')));
      query.addAll(
        client.makeParam('category_name', (String) params.get('categoryName'))
      );
      query.addAll(
        client.makeParam(
          'category_description',
          (String) params.get('categoryDescription')
        )
      );
      query.addAll(client.makeParam('status', (String) params.get('status')));
      query.addAll(
        client.makeParam(
          'preferred_language_code',
          (String) params.get('preferredLanguageCode')
        )
      );

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/billing-account-categories',
        '',
        query,
        form,
        new Map<String, Object>(),
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        List<RestAPI2Domain.GTVAPIBillingAccountCategory>.class
      );
    }
  }

  /*
   * TRACT Billing API
   * An API to retrieve and store TRACT objects for core operations.\nJSON looks like this:  \n```JSON\n{\n  "key": "value",\n  "anotherKey": "anotherValue"\n}\n```\n
   *
   * OpenAPI spec version: 2
   * Contact: support@gotransverse.com
   *
   * NOTE: This class is auto generated by the swagger code generator program.
   * https://github.com/swagger-api/swagger-codegen.git
   * Do not edit the class manually.
   */

  public class GTVAPIOrderService {
    GTVAPIClient client;

    public GTVAPIOrderService(GTVAPIClient client) {
      this.client = client;
    }

    public GTVAPIOrderService() {
      this.client = new GTVAPIClient();
    }

    public GTVAPIClient getClient() {
      return this.client;
    }

    /**
     * Confirm a Draft Order
     * Confirm a Draft Order
     * @param id The internal id of an object. (required)
     * @param order Payload used for confirming a DRAFT order (required)
     * @throws Swagger.ApiException if fails to make API call
     */
    public void confirmOrder(Map<String, Object> params) {
      client.assertNotNull(params.get('id'), 'id');
      client.assertNotNull(params.get('order'), 'order');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      client.invoke(
        'POST',
        '/orders/{id}/confirm',
        (RestAPI2Domain.GTVAPIConfirmDraftOrder) params.get('order'),
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        null
      );
    }
    /**
     * Create Order
     * Create Order
     * @param id The internal id of an object. (required)
     * @param order The TRACT order in JSON format (required)
     * @param prefer return&#x3D;[representation|minimal] The HTTP Prefer header. See https://tools.ietf.org/html/rfc7240 (optional)
     * @return GTVAPIOrder
     * @throws Swagger.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper createOrder(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('id'), 'id');
      client.assertNotNull(params.get('order'), 'order');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'POST',
        '/billing-accounts/{id}/orders',
        (RestAPI2Domain.GTVAPICreateSalesOrder) params.get('order'),
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIOrder.class
      );
    }
    /**
     * Create a custom field value
     * Create a custom field value and add it to the order
     * @param id The internal id of an object. (required)
     * @param orderCustomFieldValue The TRACT order custom field value in JSON format (required)
     * @param prefer return&#x3D;[representation|minimal] The HTTP Prefer header. See https://tools.ietf.org/html/rfc7240 (optional)
     * @return GTVAPIOrderCustomFieldValue
     * @throws Swagger.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper createOrderCustomFieldValue(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('id'), 'id');
      client.assertNotNull(
        params.get('orderCustomFieldValue'),
        'orderCustomFieldValue'
      );
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'POST',
        '/orders/{id}/custom-field-values',
        (RestAPI2Domain.GTVAPICreateOrderCustomFieldValue) params.get(
          'orderCustomFieldValue'
        ),
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIOrderCustomFieldValue.class
      );
    }
    /**
     * Get the order specified by the id
     * Get an account
     * @param id The internal id of an object. (required)
     * @param prefer return&#x3D;[representation|minimal] The HTTP Prefer header. See https://tools.ietf.org/html/rfc7240 (optional)
     * @param r_return Specifies the amount of detail to provide in a response. (optional, default to FULL)
     * @return GTVAPIOrder
     * @throws Swagger.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper getOrder(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('return', (String) params.get('r_return')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/orders/{id}',
        '',
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIOrder.class
      );
    }
    /**
     * Get Order
     * Get Order
     * @param id The internal id of an object. (required)
     * @param orderId The id of a TRACT order (required)
     * @param prefer return&#x3D;[representation|minimal] The HTTP Prefer header. See https://tools.ietf.org/html/rfc7240 (optional)
     * @param r_return Specifies the amount of detail to provide in a response. (optional, default to FULL)
     * @return GTVAPIOrder
     * @throws Swagger.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper getOrderByBillingAccount(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('id'), 'id');
      client.assertNotNull(params.get('orderId'), 'orderId');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('return', (String) params.get('r_return')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/billing-accounts/{id}/orders/{order_id}',
        '',
        query,
        form,
        new Map<String, Object>{
          'id' => (String) params.get('id'),
          'order_id' => (String) params.get('orderId')
        },
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIOrder.class
      );
    }
    /**
     * Get an existing custom field value associated with this account
     * Get an existing custom field value associated with this account
     * @param id The internal id of an object. (required)
     * @param customFieldValueId The id of a TRACT custom field value (required)
     * @param prefer return&#x3D;[representation|minimal] The HTTP Prefer header. See https://tools.ietf.org/html/rfc7240 (optional)
     * @param r_return Specifies the amount of detail to provide in a response. (optional, default to FULL)
     * @return GTVAPIOrderCustomFieldValue
     * @throws Swagger.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper getOrderCustomFieldValue(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('id'), 'id');
      client.assertNotNull(
        params.get('customFieldValueId'),
        'customFieldValueId'
      );
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('return', (String) params.get('r_return')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/orders/{id}/custom-field-values/{custom_field_value_id}',
        '',
        query,
        form,
        new Map<String, Object>{
          'id' => (String) params.get('id'),
          'custom_field_value_id' => (String) params.get('customFieldValueId')
        },
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIOrderCustomFieldValue.class
      );
    }
    /**
     * Get an existing payment associated with this order
     * Get an existing payment associated with this order
     * @param id The internal id of an object. (required)
     * @param paymentId The id of a TRACT payment (required)
     * @param prefer return&#x3D;[representation|minimal] The HTTP Prefer header. See https://tools.ietf.org/html/rfc7240 (optional)
     * @param r_return Specifies the amount of detail to provide in a response. (optional, default to FULL)
     * @return GTVAPIPayment
     * @throws Swagger.ApiException if fails to make API call
     */
    /*public GTVAPIPayment getPaymentByOrder(Map<String, Object> params) {
        client.assertNotNull(params.get('id'), 'id');
        client.assertNotNull(params.get('paymentId'), 'paymentId');
        List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

        // cast query params to verify their expected type
        query.addAll(client.makeParam('return', (String) params.get('r_return')));

        List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

        return (GTVAPIPayment) client.invoke(
            'GET', '/orders/{id}/payments/{payment_id}', '',
            query, form,
            new Map<String, Object>{
                'id' => (String) params.get('id'),
                'payment_id' => (String) params.get('paymentId')
            },
            new Map<String, Object>{
                'Prefer' => (String) params.get('prefer')
            },
            new List<String>{ 'application/json' },
            new List<String>{ 'application/json' },
            new List<String> { 'x-api-key', 'bearer' },
            GTVAPIPayment.class
        );
    }*/
    /**
     * Query for custom field values
     * Query for custom field values
     * @param id The internal id of an object. (required)
     * @param filter API query language string (optional)
     * @param prefer return&#x3D;[representation|minimal] The HTTP Prefer header. See https://tools.ietf.org/html/rfc7240 (optional)
     * @param r_return Specifies the amount of detail to provide in a response. (optional, default to FULL)
     * @param id2 The internal id of an object. (optional)
     * @param customFieldValue A custom field value (optional)
     * @param customFieldName The name of a TRACT custom field (optional)
     * @param customFieldId The id of a TRACT custom field (optional)
     * @return List<GTVAPIOrderCustomFieldValue>
     * @throws Swagger.ApiException if fails to make API call
     */
    /*public List<GTVAPIOrderCustomFieldValue> queryOrderCustomFieldValues(Map<String, Object> params) {
        client.assertNotNull(params.get('id'), 'id');
        List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

        // cast query params to verify their expected type
        query.addAll(client.makeParam('filter', (String) params.get('filter')));
        query.addAll(client.makeParam('return', (String) params.get('r_return')));
        query.addAll(client.makeParam('id', (String) params.get('id2')));
        query.addAll(client.makeParam('custom_field_value', (String) params.get('customFieldValue')));
        query.addAll(client.makeParam('custom_field_name', (String) params.get('customFieldName')));
        query.addAll(client.makeParam('custom_field_id', (String) params.get('customFieldId')));

        List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

        return (List<GTVAPIOrderCustomFieldValue>) client.invoke(
            'GET', '/orders/{id}/custom-field-values', '',
            query, form,
            new Map<String, Object>{
                'id' => (String) params.get('id')
            },
            new Map<String, Object>{
                'Prefer' => (String) params.get('prefer')
            },
            new List<String>{ 'application/json' },
            new List<String>{ 'application/json' },
            new List<String> { 'x-api-key', 'bearer' },
            List<GTVAPIOrderCustomFieldValue>.class
        );
    }*/
    /**
     * Query for orders with the specified query
     * Query TRACT orders
     * @param filter API query language string (optional)
     * @param prefer return&#x3D;[representation|minimal] The HTTP Prefer header. See https://tools.ietf.org/html/rfc7240 (optional)
     * @param r_return Specifies the amount of detail to provide in a response. (optional, default to FULL)
     * @param pageNumber The page number for multiple page queries (optional, default to 1)
     * @param pageSize The page size for multiple page queries. Default maximum is 50 (optional, default to 50)
     * @param id The internal id of an object. (optional)
     * @param orderType The order type (optional)
     * @param orderNum (unique_key) An order number (optional)
     * @param status The order status (optional)
     * @param orderDate The date that the order takes place (optional)
     * @param referral the order referral (optional)
     * @param purchaseOrderNumber An purchase order number (optional)
     * @param renewalDate The reneal date for a renewal order (optional)
     * @param customFieldId The id of a TRACT custom field (optional)
     * @param customFieldValue A custom field value (optional)
     * @param customFieldValueId The id of a TRACT custom field value (optional)
     * @param billingAccountId The id of a TRACT billing account (optional)
     * @param accountNum The billing account number (optional)
     * @param externalAccountNum The external account number (optional)
     * @return List<GTVAPIOrder>
     * @throws Swagger.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper queryOrders(
      Map<String, Object> params
    ) {
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('filter', (String) params.get('filter')));
      query.addAll(client.makeParam('return', (String) params.get('r_return')));
      query.addAll(
        client.makeParam('page_number', (Integer) params.get('pageNumber'))
      );
      query.addAll(
        client.makeParam('page_size', (Integer) params.get('pageSize'))
      );
      query.addAll(client.makeParam('id', (String) params.get('id')));
      query.addAll(
        client.makeParam('order_type', (String) params.get('orderType'))
      );
      query.addAll(
        client.makeParam('order_num', (String) params.get('orderNum'))
      );
      query.addAll(client.makeParam('status', (String) params.get('status')));
      query.addAll(
        client.makeParam('order_date', (DateTime) params.get('orderDate'))
      );
      query.addAll(
        client.makeParam('referral', (String) params.get('referral'))
      );
      query.addAll(
        client.makeParam(
          'purchase_order_number',
          (String) params.get('purchaseOrderNumber')
        )
      );
      query.addAll(
        client.makeParam('renewal_date', (DateTime) params.get('renewalDate'))
      );
      query.addAll(
        client.makeParam(
          'custom_field_id',
          (String) params.get('customFieldId')
        )
      );
      query.addAll(
        client.makeParam(
          'custom_field_value',
          (String) params.get('customFieldValue')
        )
      );
      query.addAll(
        client.makeParam(
          'custom_field_value_id',
          (String) params.get('customFieldValueId')
        )
      );
      query.addAll(
        client.makeParam(
          'billing_account_id',
          (String) params.get('billingAccountId')
        )
      );
      query.addAll(
        client.makeParam('account_num', (String) params.get('accountNum'))
      );
      query.addAll(
        client.makeParam(
          'external_account_num',
          (String) params.get('externalAccountNum')
        )
      );

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/orders',
        '',
        query,
        form,
        new Map<String, Object>(),
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        List<RestAPI2Domain.GTVAPIOrder>.class
      );
    }
    /**
     *
     *
     * @param id The internal id of an object. (required)
     * @param filter API query language string (optional)
     * @param prefer return&#x3D;[representation|minimal] The HTTP Prefer header. See https://tools.ietf.org/html/rfc7240 (optional)
     * @param r_return Specifies the amount of detail to provide in a response. (optional, default to FULL)
     * @param pageNumber The page number for multiple page queries (optional, default to 1)
     * @param pageSize The page size for multiple page queries. Default maximum is 50 (optional, default to 50)
     * @param occurredOn The date that the payment occurred (optional)
     * @param reference The payment reference (optional)
     * @param status The payment status (optional)
     * @param authorization The payment authorization (optional)
     * @param unappliedAmount The unapplied payment amount (optional)
     * @param token The payment token (optional)
     * @return List<GTVAPIPayment>
     * @throws Swagger.ApiException if fails to make API call
     */
    /*public List<GTVAPIPayment> queryPaymentsByOrder(Map<String, Object> params) {
        client.assertNotNull(params.get('id'), 'id');
        List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

        // cast query params to verify their expected type
        query.addAll(client.makeParam('filter', (String) params.get('filter')));
        query.addAll(client.makeParam('return', (String) params.get('r_return')));
        query.addAll(client.makeParam('page_number', (Integer) params.get('pageNumber')));
        query.addAll(client.makeParam('page_size', (Integer) params.get('pageSize')));
        query.addAll(client.makeParam('occurred_on', (DateTime) params.get('occurredOn')));
        query.addAll(client.makeParam('reference', (String) params.get('reference')));
        query.addAll(client.makeParam('status', (String) params.get('status')));
        query.addAll(client.makeParam('authorization', (String) params.get('authorization')));
        query.addAll(client.makeParam('unapplied_amount', (Double) params.get('unappliedAmount')));
        query.addAll(client.makeParam('token', (String) params.get('token')));

        List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

        return (List<GTVAPIPayment>) client.invoke(
            'GET', '/orders/{id}/payments', '',
            query, form,
            new Map<String, Object>{
                'id' => (String) params.get('id')
            },
            new Map<String, Object>{
                'Prefer' => (String) params.get('prefer')
            },
            new List<String>{ 'application/json' },
            new List<String>{ 'application/json' },
            new List<String> { 'x-api-key', 'bearer' },
            List<GTVAPIPayment>.class
        );
    }*/
    /**
     * Remove an existing custom field value associated with this account
     * Remove an existing custom field value associated with this account
     * @param id The internal id of an object. (required)
     * @param customFieldValueId The id of a TRACT custom field value (required)
     * @throws Swagger.ApiException if fails to make API call
     */
    /*public void removeOrderCustomFieldValue(Map<String, Object> params) {
        client.assertNotNull(params.get('id'), 'id');
        client.assertNotNull(params.get('customFieldValueId'), 'customFieldValueId');
        List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
        List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

        client.invoke(
            'DELETE', '/orders/{id}/custom-field-values/{custom_field_value_id}', '',
            query, form,
            new Map<String, Object>{
                'id' => (String) params.get('id'),
                'custom_field_value_id' => (String) params.get('customFieldValueId')
            },
            new Map<String, Object>(),
            new List<String>{ 'application/json' },
            new List<String>{ 'application/json' },
            new List<String> { 'x-api-key', 'bearer' },
            null
        );
    }*/
    /**
     * Update the order specified by the id
     * Update an account
     * @param id The internal id of an object. (required)
     * @param order The TRACT order in JSON format (required)
     * @param prefer return&#x3D;[representation|minimal] The HTTP Prefer header. See https://tools.ietf.org/html/rfc7240 (optional)
     * @return GTVAPIOrder
     * @throws Swagger.ApiException if fails to make API call
     */
    /*public GTVAPIOrder updateOrder(Map<String, Object> params) {
        client.assertNotNull(params.get('id'), 'id');
        client.assertNotNull(params.get('order'), 'order');
        List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
        List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

        return (GTVAPIOrder) client.invoke(
            'PUT', '/orders/{id}',
            (GTVAPIUpdateSalesOrder) params.get('order'),
            query, form,
            new Map<String, Object>{
                'id' => (String) params.get('id')
            },
            new Map<String, Object>{
                'Prefer' => (String) params.get('prefer')
            },
            new List<String>{ 'application/json' },
            new List<String>{ 'application/json' },
            new List<String> { 'x-api-key', 'bearer' },
            GTVAPIOrder.class
        );
    }*/
    /**
     * Get an existing custom field value associated with this account
     * Get an existing custom field value associated with this account
     * @param id The internal id of an object. (required)
     * @param customFieldValueId The id of a TRACT custom field value (required)
     * @param orderCustomFieldValue The TRACT order custom field value in JSON format (required)
     * @param prefer return&#x3D;[representation|minimal] The HTTP Prefer header. See https://tools.ietf.org/html/rfc7240 (optional)
     * @return GTVAPIOrderCustomFieldValue
     * @throws Swagger.ApiException if fails to make API call
     */
    /*public GTVAPIOrderCustomFieldValue updateOrderCustomFieldValue(Map<String, Object> params) {
        client.assertNotNull(params.get('id'), 'id');
        client.assertNotNull(params.get('customFieldValueId'), 'customFieldValueId');
        client.assertNotNull(params.get('orderCustomFieldValue'), 'orderCustomFieldValue');
        List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
        List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

        return (GTVAPIOrderCustomFieldValue) client.invoke(
            'PUT', '/orders/{id}/custom-field-values/{custom_field_value_id}',
            (GTVAPIUpdateOrderCustomFieldValue) params.get('orderCustomFieldValue'),
            query, form,
            new Map<String, Object>{
                'id' => (String) params.get('id'),
                'custom_field_value_id' => (String) params.get('customFieldValueId')
            },
            new Map<String, Object>{
                'Prefer' => (String) params.get('prefer') 
            },
            new List<String>{ 'application/json' },
            new List<String>{ 'application/json' },
            new List<String> { 'x-api-key', 'bearer' },
            GTVAPIOrderCustomFieldValue.class
        );
    }*/
    /**
     * Delete Draft Order
     * Delete Draft Order
     * @param id The internal id of an object. (required)
     * @throws Swagger.ApiException if fails to make API call
     */
    /*public void voidDraftOrder(Map<String, Object> params) {
        client.assertNotNull(params.get('id'), 'id');
        List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
        List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

        client.invoke(
            'DELETE', '/orders/{id}', '',
            query, form,
            new Map<String, Object>{
                'id' => (String) params.get('id')
            },
            new Map<String, Object>(),
            new List<String>{ 'application/json' },
            new List<String>{ 'application/json' },
            new List<String> { 'x-api-key', 'bearer' },
            null
        );
    }*/
  }

  /*
   * TRACT Billing API
   * Create and manage billing accounts, products, orders, services, billing, invoicing, payments, and the general ledger. This microservice provides core functionality for the goTransverse billing platform.
   *
   * OpenAPI spec version: 2
   *
   *
   * NOTE: This class is auto generated by the GTVAPIRestClient code generator program.
   * https://github.com/GTVAPIRestClient-api/GTVAPIRestClient-codegen.git
   * Do not edit the class manually.
   */

  public class GTVAPIPersonService {
    GTVAPIClient client;

    public GTVAPIPersonService(GTVAPIClient client) {
      this.client = client;
    }

    public GTVAPIPersonService() {
      this.client = new GTVAPIClient();
    }

    public GTVAPIClient getClient() {
      return this.client;
    }

    /**
     * Add address to person
     * Adds an address to the existing person with the associated ID. The payload can include any address type - email, postal, or telecom.
     * @param personId The ID of the person. (required)
     * @param addAddress A payload for adding an address. (required)
     * @param prefer The HTTP Prefer header per https://tools.ietf.org/html/rfc7240. The \&#39;return&#x3D;[representation|minimal]\&#39; preferences are the only implemented settings at the moment and are the same as \&#39;return&#x3D;SIMPLE\&#39;, and it indicates that the client wishes the server to return a minimal response to a successful request. The \&#39;return&#x3D;representation\&#39; preference in this header is the same as setting query parameter \&#39;return&#x3D;FULL\&#39;. (optional)
     * @return GTVAPIAddress
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper addPersonAddress(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('personId'), 'personId');
      client.assertNotNull(params.get('addAddress'), 'addAddress');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'POST',
        '/people/{person_id}/addresses',
        (RestAPI2Domain.GTVAPICreateAddress) params.get('addAddress'),
        query,
        form,
        new Map<String, Object>{
          'person_id' => (String) params.get('personId')
        },
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIAddress.class
      );
    }
    /**
     * Get person by ID
     * Retrieves a person that exists in the system by the associated ID.
     * @param id The internal ID of the object. (required)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @return GTVAPIPerson
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper getPerson(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('return', (String) params.get('r_return')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/people/{id}',
        '',
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIPerson.class
      );
    }
    /**
     * Get address by ID
     * Retrieves an address of the person that exists in the system by the associated person and address IDs.
     * @param personId The ID of the person. (required)
     * @param id The internal ID of the object. (required)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @return GTVAPIAddress
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper getPersonAddress(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('personId'), 'personId');
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('return', (String) params.get('r_return')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/people/{person_id}/addresses/{id}',
        '',
        query,
        form,
        new Map<String, Object>{
          'person_id' => (String) params.get('personId'),
          'id' => (String) params.get('id')
        },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIAddress.class
      );
    }
    /**
     * Get people
     * Uses query keys to retrieve a subset of people that currently exist in the system.
     * @param filter The API query language string which allows you to specify additional query criteria. (optional)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @param pageNumber The page number for multiple page queries. (optional, default to 1)
     * @param pageSize The page size for multiple page queries. Default maximum is 50. (optional, default to 50)
     * @param id The internal ID of the object. (optional)
     * @param firstName The first name of the person. (optional)
     * @param lastName The last name of the person. (optional)
     * @param billingAccountId The ID of the billing account. (optional)
     * @param accountNum The billing account number. (optional)
     * @param externalAccountNum The account number tied to an external system. (optional)
     * @return List<GTVAPIPerson>
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper queryPeople(
      Map<String, Object> params
    ) {
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('filter', (String) params.get('filter')));
      query.addAll(client.makeParam('return', (String) params.get('r_return')));
      query.addAll(
        client.makeParam('page_number', (Integer) params.get('pageNumber'))
      );
      query.addAll(
        client.makeParam('page_size', (Integer) params.get('pageSize'))
      );
      query.addAll(client.makeParam('id', (String) params.get('id')));
      query.addAll(
        client.makeParam('first_name', (String) params.get('firstName'))
      );
      query.addAll(
        client.makeParam('last_name', (String) params.get('lastName'))
      );
      query.addAll(
        client.makeParam(
          'billing_account_id',
          (String) params.get('billingAccountId')
        )
      );
      query.addAll(
        client.makeParam('account_num', (String) params.get('accountNum'))
      );
      query.addAll(
        client.makeParam(
          'external_account_num',
          (String) params.get('externalAccountNum')
        )
      );

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/people',
        '',
        query,
        form,
        new Map<String, Object>(),
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        List<RestAPI2Domain.GTVAPIPerson>.class
      );
    }
    /**
     * Get person addresses
     * Retrieves addresses of the person associated with the specified ID.
     * @param personId The ID of the person. (required)
     * @param filter The API query language string which allows you to specify additional query criteria. (optional)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @param pageNumber The page number for multiple page queries. (optional, default to 1)
     * @param pageSize The page size for multiple page queries. Default maximum is 50. (optional, default to 50)
     * @param id The internal ID of the object. (optional)
     * @param validFrom The date and time from when the resource is valid. (optional)
     * @param validTo The date and time until when the resource is valid. (optional)
     * @return List<GTVAPIAddress>
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper queryPersonAddresses(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('personId'), 'personId');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('filter', (String) params.get('filter')));
      query.addAll(client.makeParam('return', (String) params.get('r_return')));
      query.addAll(
        client.makeParam('page_number', (Integer) params.get('pageNumber'))
      );
      query.addAll(
        client.makeParam('page_size', (Integer) params.get('pageSize'))
      );
      query.addAll(client.makeParam('id', (String) params.get('id')));
      query.addAll(
        client.makeParam('valid_from', (DateTime) params.get('validFrom'))
      );
      query.addAll(
        client.makeParam('valid_to', (DateTime) params.get('validTo'))
      );

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/people/{person_id}/addresses',
        '',
        query,
        form,
        new Map<String, Object>{
          'person_id' => (String) params.get('personId')
        },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        List<RestAPI2Domain.GTVAPIAddress>.class
      );
    }
    /**
     * Update person
     * Updates information on a person that exists in the system by the specified ID.
     * @param id The internal ID of the object. (required)
     * @param person The payload for updating an existing person. (required)
     * @param prefer The HTTP Prefer header per https://tools.ietf.org/html/rfc7240. The \&#39;return&#x3D;[representation|minimal]\&#39; preferences are the only implemented settings at the moment and are the same as \&#39;return&#x3D;SIMPLE\&#39;, and it indicates that the client wishes the server to return a minimal response to a successful request. The \&#39;return&#x3D;representation\&#39; preference in this header is the same as setting query parameter \&#39;return&#x3D;FULL\&#39;. (optional)
     * @return GTVAPIPerson
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper updatePerson(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('id'), 'id');
      client.assertNotNull(params.get('person'), 'person');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'PUT',
        '/people/{id}',
        (RestAPI2Domain.GTVAPIPerson) params.get('person'),
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIPerson.class
      );
    }
  }

  public class GTVAPIInvoiceService {
    GTVAPIClient client;

    public GTVAPIInvoiceService(GTVAPIClient client) {
      this.client = client;
    }

    public GTVAPIInvoiceService() {
      this.client = new GTVAPIClient();
    }

    public GTVAPIClient getClient() {
      return this.client;
    }

    /**
     * Get an existing bill cycle
     * Get an existing bill cycle
     * @param id The internal id of an object. (required)
     * @param prefer return&#x3D;[representation|minimal] The HTTP Prefer header. See https://tools.ietf.org/html/rfc7240 (optional)
     * @param r_return Specifies the amount of detail to provide in a response. (optional, default to FULL)
     * @return GTVAPIInvoice
     * @throws GTVAPIClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper getInvoice(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('return', (String) params.get('r_return')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/invoices/{id}',
        '',
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIInvoice.class
      );
    }
    /**
     * Download invoice or usage
     * Downloads an existing invoice in PDF format or downloads usage in a CSV file.
     * @param id The internal ID of the object. (required)
     * @param accept The HTTP Accept header per https://tools.ietf.org/html/rfc7231 - section-5.3.2. (optional)
     * @return Blob
     * @throws Swagger.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper getRenderedInvoice(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/invoices/{id}/downloads',
        '',
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>{ 'Accept' => (String) params.get('accept') },
        new List<String>{ 'application/pdf' },
        new List<String>{ 'application/pdf' },
        new List<String>{ 'x-api-key', 'bearer' },
        Blob.class
      );
    }
    /**
     *
     *
     * @param filter API query language string (optional)
     * @param prefer return&#x3D;[representation|minimal] The HTTP Prefer header. See https://tools.ietf.org/html/rfc7240 (optional)
     * @param r_return Specifies the amount of detail to provide in a response. (optional, default to FULL)
     * @param pageNumber The page number for multiple page queries (optional, default to 1)
     * @param pageSize The page size for multiple page queries. Default maximum is 50 (optional, default to 50)
     * @param id The internal id of an object. (optional)
     * @param invoiceNum The number of a TRACT invoice (optional)
     * @param occurredOn The TRACT  invoice occured on date (optional)
     * @param dueDate The TRACT  invoice due date (optional)
     * @param status The TRACT status (optional, default to OPEN)
     * @param billingAccountId The id of a TRACT billing account (optional)
     * @param accountNum The billing account number (optional)
     * @param externalAccountNum The external account number (optional)
     * @param discountCodeServiceId The discount code service id limit (optional)
     * @param billCycleRunId The if of a TRACT bill cycle run (optional)
     * @param adjustmentId The id of a TRACT adjustment (optional)
     * @param usageEventId The id of a TRACT usage_event (optional)
     * @return List<GTVAPIInvoice>
     * @throws GTVAPIClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper queryInvoices(
      Map<String, Object> params
    ) {
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('filter', (String) params.get('filter')));
      query.addAll(client.makeParam('return', (String) params.get('r_return')));
      query.addAll(
        client.makeParam('page_number', (Integer) params.get('pageNumber'))
      );
      query.addAll(
        client.makeParam('page_size', (Integer) params.get('pageSize'))
      );
      query.addAll(client.makeParam('id', (String) params.get('id')));
      query.addAll(
        client.makeParam('invoice_num', (String) params.get('invoiceNum'))
      );
      query.addAll(
        client.makeParam('occurred_on', (DateTime) params.get('occurredOn'))
      );
      query.addAll(client.makeParam('due_date', (Date) params.get('dueDate')));
      query.addAll(client.makeParam('status', (String) params.get('status')));
      query.addAll(
        client.makeParam(
          'billing_account_id',
          (String) params.get('billingAccountId')
        )
      );
      query.addAll(
        client.makeParam('account_num', (String) params.get('accountNum'))
      );
      query.addAll(
        client.makeParam(
          'external_account_num',
          (String) params.get('externalAccountNum')
        )
      );
      query.addAll(
        client.makeParam(
          'discount_code_service_id',
          (String) params.get('discountCodeServiceId')
        )
      );
      query.addAll(
        client.makeParam(
          'bill_cycle_run_id',
          (String) params.get('billCycleRunId')
        )
      );
      query.addAll(
        client.makeParam('adjustment_id', (String) params.get('adjustmentId'))
      );
      query.addAll(
        client.makeParam('usage_event_id', (String) params.get('usageEventId'))
      );

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/invoices',
        '',
        query,
        form,
        new Map<String, Object>(),
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        List<RestAPI2Domain.GTVAPIInvoice>.class
      );
    }
  }

  public class GTVAPIPaymentService {
    GTVAPIClient client;

    public GTVAPIPaymentService(GTVAPIClient client) {
      this.client = client;
    }

    public GTVAPIPaymentService() {
      this.client = new GTVAPIClient();
    }

    public GTVAPIClient getClient() {
      return this.client;
    }

    /**
     * Create a payment
     * Create payment
     * @param id The internal id of an object. (required)
     * @param payment The TRACT payment in JSON format (required)
     * @param prefer return&#x3D;[representation|minimal] The HTTP Prefer header. See https://tools.ietf.org/html/rfc7240 (optional)
     * @return GTVAPIPayment
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper createPayment(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('id'), 'id');
      client.assertNotNull(params.get('payment'), 'payment');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'POST',
        '/billing-accounts/{id}/payments',
        (RestAPI2Domain.GTVAPICreatePayment) params.get('payment'),
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIPayment.class
      );
    }
    /**
     * Get an existing payment associated with this account
     * Get an existing payment associated with this account
     * @param id The internal id of an object. (required)
     * @param paymentId The id of a TRACT payment (required)
     * @param prefer return&#x3D;[representation|minimal] The HTTP Prefer header. See https://tools.ietf.org/html/rfc7240 (optional)
     * @param r_return Specifies the amount of detail to provide in a response. (optional, default to FULL)
     * @return GTVAPIPayment
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper getPaymentByBillingAccount(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('id'), 'id');
      client.assertNotNull(params.get('paymentId'), 'paymentId');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      // cast query params to verify their expected type
      query.addAll(client.makeParam('return', (String) params.get('r_return')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/billing-accounts/{id}/payments/{payment_id}',
        '',
        query,
        form,
        new Map<String, Object>{
          'id' => (String) params.get('id'),
          'payment_id' => (String) params.get('paymentId')
        },
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIPayment.class
      );
    }
    /**
     * Get an existing payment associated with this order
     * Get an existing payment associated with this order
     * @param id The internal id of an object. (required)
     * @param paymentId The id of a TRACT payment (required)
     * @param prefer return&#x3D;[representation|minimal] The HTTP Prefer header. See https://tools.ietf.org/html/rfc7240 (optional)
     * @param r_return Specifies the amount of detail to provide in a response. (optional, default to FULL)
     * @return GTVAPIPayment
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper getPaymentByOrder(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('id'), 'id');
      client.assertNotNull(params.get('paymentId'), 'paymentId');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('return', (String) params.get('r_return')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/orders/{id}/payments/{payment_id}',
        '',
        query,
        form,
        new Map<String, Object>{
          'id' => (String) params.get('id'),
          'payment_id' => (String) params.get('paymentId')
        },
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIPayment.class
      );
    }
    /**
     *
     *
     * @param id The internal id of an object. (required)
     * @param filter API query language string (optional)
     * @param prefer return&#x3D;[representation|minimal] The HTTP Prefer header. See https://tools.ietf.org/html/rfc7240 (optional)
     * @param r_return Specifies the amount of detail to provide in a response. (optional, default to FULL)
     * @param pageNumber The page number for multiple page queries (optional, default to 1)
     * @param pageSize The page size for multiple page queries. Default maximum is 50 (optional, default to 50)
     * @param occurredOn The date that the payment occurred (optional)
     * @param reference The payment reference (optional)
     * @param status The payment status (optional)
     * @param authorization The payment authorization (optional)
     * @param unappliedAmount The unapplied payment amount (optional)
     * @param token The payment token (optional)
     * @return List<GTVAPIPayment>
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper queryPaymentsByBillingAccount(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      // cast query params to verify their expected type
      query.addAll(client.makeParam('filter', (String) params.get('filter')));
      query.addAll(client.makeParam('return', (String) params.get('r_return')));
      query.addAll(
        client.makeParam('page_number', (Integer) params.get('pageNumber'))
      );
      query.addAll(
        client.makeParam('page_size', (Integer) params.get('pageSize'))
      );
      query.addAll(
        client.makeParam('occurred_on', (DateTime) params.get('occurredOn'))
      );
      query.addAll(
        client.makeParam('reference', (String) params.get('reference'))
      );
      query.addAll(client.makeParam('status', (String) params.get('status')));
      query.addAll(
        client.makeParam('authorization', (String) params.get('authorization'))
      );
      query.addAll(
        client.makeParam(
          'unapplied_amount',
          (Double) params.get('unappliedAmount')
        )
      );
      query.addAll(client.makeParam('token', (String) params.get('token')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/billing-accounts/{id}/payments',
        '',
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        List<RestAPI2Domain.GTVAPIPayment>.class
      );
    }
    /**
     *
     *
     * @param id The internal id of an object. (required)
     * @param filter API query language string (optional)
     * @param prefer return&#x3D;[representation|minimal] The HTTP Prefer header. See https://tools.ietf.org/html/rfc7240 (optional)
     * @param r_return Specifies the amount of detail to provide in a response. (optional, default to FULL)
     * @param pageNumber The page number for multiple page queries (optional, default to 1)
     * @param pageSize The page size for multiple page queries. Default maximum is 50 (optional, default to 50)
     * @param occurredOn The date that the payment occurred (optional)
     * @param reference The payment reference (optional)
     * @param status The payment status (optional)
     * @param authorization The payment authorization (optional)
     * @param unappliedAmount The unapplied payment amount (optional)
     * @param token The payment token (optional)
     * @return List<GTVAPIPayment>
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper queryPaymentsByOrder(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      // cast query params to verify their expected type
      query.addAll(client.makeParam('filter', (String) params.get('filter')));
      query.addAll(client.makeParam('return', (String) params.get('r_return')));
      query.addAll(
        client.makeParam('page_number', (Integer) params.get('pageNumber'))
      );
      query.addAll(
        client.makeParam('page_size', (Integer) params.get('pageSize'))
      );
      query.addAll(
        client.makeParam('occurred_on', (DateTime) params.get('occurredOn'))
      );
      query.addAll(
        client.makeParam('reference', (String) params.get('reference'))
      );
      query.addAll(client.makeParam('status', (String) params.get('status')));
      query.addAll(
        client.makeParam('authorization', (String) params.get('authorization'))
      );
      query.addAll(
        client.makeParam(
          'unapplied_amount',
          (Double) params.get('unappliedAmount')
        )
      );
      query.addAll(client.makeParam('token', (String) params.get('token')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/orders/{id}/payments',
        '',
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        List<RestAPI2Domain.GTVAPIPayment>.class
      );
    }
  }

  /*
   * TRACT Billing API
   * An API to retrieve and store TRACT objects for core operations.\nJSON looks like this:  \n```JSON\n{\n  "key": "value",\n  "anotherKey": "anotherValue"\n}\n```\n
   *
   * OpenAPI spec version: 2
   * Contact: support@gotransverse.com
   *
   * NOTE: This class is auto generated by the swagger code generator program.
   * https://github.com/swagger-api/swagger-codegen.git
   * Do not edit the class manually.
   */

  public class GTVAPIProductService {
    GTVAPIClient client;

    public GTVAPIProductService(GTVAPIClient client) {
      this.client = client;
    }

    public GTVAPIProductService() {
      this.client = new GTVAPIClient();
    }

    public GTVAPIClient getClient() {
      return this.client;
    }

    /**
     * Get an existing product
     * Get an existing product
     * @param id The internal id of an object. (required)
     * @param prefer return&#x3D;[representation|minimal] The HTTP Prefer header. See https://tools.ietf.org/html/rfc7240 (optional)
     * @param r_return Specifies the amount of detail to provide in a response. (optional, default to FULL)
     * @return GTVAPIProduct
     * @throws Swagger.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper getProduct(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('return', (String) params.get('r_return')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/products/{id}',
        '',
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIProduct.class
      );
    }
    /**
     * Activate product
     * Activates a product with the specified ID.
     * @param id The internal ID of the object. (required)
     * @throws Swagger.ApiException if fails to make API call
     */
    public void activateProduct(Map<String, Object> params) {
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      client.invoke(
        'POST',
        '/products/{id}/activate',
        '',
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        null
      );
    }
    /**
     *
     *
     * @param filter API query language string (optional)
     * @param prefer return&#x3D;[representation|minimal] The HTTP Prefer header. See https://tools.ietf.org/html/rfc7240 (optional)
     * @param r_return Specifies the amount of detail to provide in a response. (optional, default to FULL)
     * @param pageNumber The page number for multiple page queries (optional, default to 1)
     * @param pageSize The page size for multiple page queries. Default maximum is 50 (optional, default to 50)
     * @param id The internal id of an object. (optional)
     * @param name The name of a TRACT product (optional)
     * @param internalName The internal name of a TRACT product (optional)
     * @param externalProductNumber The external product number of a TRACT product (optional)
     * @param sku The sku of a TRACT product (optional)
     * @param productType The type of a TRACT product (optional)
     * @param productState The state  of a TRACT product (optional)
     * @param productCategoryId The product category id of a TRACT product (optional)
     * @param productCategoryName The product category name of a TRACT product (optional)
     * @param currencyCode The currency_code for the amount. (optional)
     * @param productTagId The product tag id of a TRACT product (optional)
     * @param discountCodeId The id of a TRACT discount code (optional)
     * @param discountResourceIdentifier The resource of a TRACT discount (optional)
     * @param agreementId The id of a TRACT agreement (optional)
     * @param resourceCategoryId The id of a TRACT service resource category (optional)
     * @param resourceCategoryName The name of a TRACT service resource category (optional)
     * @return List<GTVAPIProduct>
     * @throws Swagger.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper queryProducts(
      Map<String, Object> params
    ) {
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('filter', (String) params.get('filter')));
      query.addAll(client.makeParam('return', (String) params.get('r_return')));
      query.addAll(
        client.makeParam('page_number', (Integer) params.get('pageNumber'))
      );
      query.addAll(
        client.makeParam('page_size', (Integer) params.get('pageSize'))
      );
      query.addAll(client.makeParam('id', (String) params.get('id')));
      query.addAll(
        client.makeParam('price_list_id', (String) params.get('priceListId'))
      );
      query.addAll(client.makeParam('name', (String) params.get('name')));
      query.addAll(
        client.makeParam('internal_name', (String) params.get('internalName'))
      );
      query.addAll(
        client.makeParam(
          'external_product_number',
          (String) params.get('externalProductNumber')
        )
      );
      query.addAll(client.makeParam('sku', (String) params.get('sku')));
      query.addAll(
        client.makeParam('product_type', (String) params.get('productType'))
      );
      query.addAll(
        client.makeParam('product_state', (String) params.get('productState'))
      );
      query.addAll(
        client.makeParam(
          'product_category_id',
          (String) params.get('productCategoryId')
        )
      );
      query.addAll(
        client.makeParam(
          'product_category_name',
          (String) params.get('productCategoryName')
        )
      );
      query.addAll(
        client.makeParam('currency_code', (String) params.get('currencyCode'))
      );
      query.addAll(
        client.makeParam('product_tag_id', (String) params.get('productTagId'))
      );
      query.addAll(
        client.makeParam(
          'discount_code_id',
          (String) params.get('discountCodeId')
        )
      );
      query.addAll(
        client.makeParam(
          'discount_resource_identifier',
          (String) params.get('discountResourceIdentifier')
        )
      );
      query.addAll(
        client.makeParam('agreement_id', (String) params.get('agreementId'))
      );
      query.addAll(
        client.makeParam(
          'resource_category_id',
          (String) params.get('resourceCategoryId')
        )
      );
      query.addAll(
        client.makeParam(
          'resource_category_name',
          (String) params.get('resourceCategoryName')
        )
      );

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/products',
        '',
        query,
        form,
        new Map<String, Object>(),
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        List<RestAPI2Domain.GTVAPIProduct>.class
      );
    }
    /**
     * Get product agreement relation by ID
     * Retrieves an existing product agreement relation by the associated product and agreement relation IDs.
     * @param productId The ID of the product. (required)
     * @param id The internal ID of the object. (required)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @return GTVAPIProductAgreementRelation
     * @throws Swagger.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper getProductAgreementRelation(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('productId'), 'productId');
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('return', (String) params.get('r_return')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/products/{product_id}/agreement-relations/{id}',
        '',
        query,
        form,
        new Map<String, Object>{
          'product_id' => (String) params.get('productId'),
          'id' => (String) params.get('id')
        },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIProductAgreementRelation.class
      );
    }
    /**
     * Get product agreement relations
     * Retrieves a subset of existing product agreement relations by the associated product ID.
     * @param productId The ID of the product. (required)
     * @param filter API query language string. The syntax of the API query language is similar to SQL, the criteria are expressed in the form of predicates.\nOn the left side of the equation, there is a name of the available query parameter (for example, billing_account_id). On the right side, there is a constant value in single quotes (\&#39;sample value\&#39;). Brackets are used to group predicates, for example, \&#39;(start_date GT \&#39;1994-01-24T23:33:07+00:00\&#39;)\&#39;. Use the following logical operators: AND - conjunction, OR - disjunction, NOT - negation. Compare operators: NEQ - Not equals, EQ - Equals, LT - Less, LTE - Less or equals, GT - Greater, GTE - Greater or equals, IS NULL - Is null, IS NOT NULL - Is not null, LIKE - Match pattern (LIKE operator is only applicable to parameters of the string type). Wildcard characters: \&#39;%\&#39; - matches any number of characters, including no characters, \&#39;_\&#39; - matches exactly one character.\nHere is the sample query: the account_num GT \&#39;15\&#39; AND (name LIKE \&#39;start of name% end of name\&#39; OR status EQ \&#39;ACTIVE\&#39;).\n (optional)
     * @param r_sort Arranges search results in either ascending or descending order. By default, response results are sorted in the ascending order. To sort results in the descending order, use &quot;-&quot;. For example, the &quot;-name.&quot; value sorts the results in the descending order by name, and &quot;id&quot; sorts results in the ascending order by ID. (optional)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @param pageNumber The page number for multiple page queries. (optional, default to 1)
     * @param pageSize The page size for multiple page queries. Default maximum is 50. (optional, default to 50)
     * @param id The internal ID of the object. (optional)
     * @param agreementId The ID of the agreement. (optional)
     * @param agreementName The name of the agreement. (optional)
     * @return List<GTVAPIProductAgreementRelation>
     * @throws Swagger.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper queryProductAgreementRelations(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('productId'), 'productId');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('filter', (String) params.get('filter')));
      query.addAll(
        client.makeParam('sort', (List<String>) params.get('r_sort'), 'csv')
      );
      query.addAll(client.makeParam('return', (String) params.get('r_return')));
      query.addAll(
        client.makeParam('page_number', (Integer) params.get('pageNumber'))
      );
      query.addAll(
        client.makeParam('page_size', (Integer) params.get('pageSize'))
      );
      query.addAll(client.makeParam('id', (String) params.get('id')));
      query.addAll(
        client.makeParam('agreement_id', (String) params.get('agreementId'))
      );
      query.addAll(
        client.makeParam('agreement_name', (String) params.get('agreementName'))
      );

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/products/{product_id}/agreement-relations',
        '',
        query,
        form,
        new Map<String, Object>{
          'product_id' => (String) params.get('productId')
        },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        List<RestAPI2Domain.GTVAPIProductAgreementRelation>.class
      );
    }

    /**
     * Create product
     * Creates a new product.
     * @param createProduct The payload for creating a new product. (required)
     * @param prefer The HTTP Prefer header per https://tools.ietf.org/html/rfc7240. The \&#39;return&#x3D;[representation|minimal]\&#39; preferences are the only implemented settings at the moment and are the same as \&#39;return&#x3D;SIMPLE\&#39;, and it indicates that the client wishes the server to return a minimal response to a successful request. The \&#39;return&#x3D;representation\&#39; preference in this header is the same as setting query parameter \&#39;return&#x3D;FULL\&#39;. (optional)
     * @return GTVProduct
     * @throws Swagger.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper createProduct(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('createProduct'), 'createProduct');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'POST',
        '/products',
        (RestAPI2Domain.GTVAPICreateProduct) params.get('createProduct'),
        query,
        form,
        new Map<String, Object>(),
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIProduct.class
      );
    }
    /**
     * Create product agreement relation
     * Creates a product agreement relation to the specified product.
     * @param productId The ID of the product. (required)
     * @param createProductAgreementRelation  (required)
     * @param prefer The HTTP Prefer header per https://tools.ietf.org/html/rfc7240. The \&#39;return&#x3D;[representation|minimal]\&#39; preferences are the only implemented settings at the moment and are the same as \&#39;return&#x3D;SIMPLE\&#39;, and it indicates that the client wishes the server to return a minimal response to a successful request. The \&#39;return&#x3D;representation\&#39; preference in this header is the same as setting query parameter \&#39;return&#x3D;FULL\&#39;. (optional)
     * @return GTVAPIProductAgreementRelation
     * @throws Swagger.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper createProductAgreementRelation(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('productId'), 'productId');
      client.assertNotNull(
        params.get('createProductAgreementRelation'),
        'createProductAgreementRelation'
      );
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'POST',
        '/products/{product_id}/agreement-relations',
        (RestAPI2Domain.GTVAPICreateProductAgreementRelation) params.get(
          'createProductAgreementRelation'
        ),
        query,
        form,
        new Map<String, Object>{
          'product_id' => (String) params.get('productId')
        },
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIProductAgreementRelation.class
      );
    }
    /**
     * Delete product agreement relation
     * Removes an existing product agreement relation associated with the specified product and product agreement relation IDs.
     * @param productId The ID of the product. (required)
     * @param id The internal ID of the object. (required)
     * @throws Swagger.ApiException if fails to make API call
     */
    public void removeProductAgreementRelation(Map<String, Object> params) {
      client.assertNotNull(params.get('productId'), 'productId');
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      client.invoke(
        'DELETE',
        '/products/{product_id}/agreement-relations/{id}',
        '',
        query,
        form,
        new Map<String, Object>{
          'product_id' => (String) params.get('productId'),
          'id' => (String) params.get('id')
        },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        null
      );
    }

    /**
     * Create product price
     * Creates a one-time or recurring price and adds this price to the specified product. The price is added to the product from the default price list. If a price already exists on the specified product, this request puts an end date on the current product price and adds the new product price.
     * @param productId The ID of the product. (required)
     * @param createProductPrice The payload for creating a new product price. (required)
     * @param prefer The HTTP Prefer header per https://tools.ietf.org/html/rfc7240. The \&#39;return&#x3D;[representation|minimal]\&#39; preferences are the only implemented settings at the moment and are the same as \&#39;return&#x3D;SIMPLE\&#39;, and it indicates that the client wishes the server to return a minimal response to a successful request. The \&#39;return&#x3D;representation\&#39; preference in this header is the same as setting query parameter \&#39;return&#x3D;FULL\&#39;. (optional)
     * @return GTVProductPrice
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper createProductPrice(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('productId'), 'productId');
      client.assertNotNull(
        params.get('createProductPrice'),
        'createProductPrice'
      );
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'POST',
        '/products/{product_id}/prices',
        (RestAPI2Domain.GTVAPICreateProductPrice) params.get(
          'createProductPrice'
        ),
        query,
        form,
        new Map<String, Object>{
          'product_id' => (String) params.get('productId')
        },
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIProductPrice.class
      );
    }

    /**
     * Update product price
     * Update a one-time or recurring price and adds this price to the specified product. The price is added to the product from the default price list. If a price already exists on the specified product, this request puts an end date on the current product price and adds the new product price.
     * @param productId The ID of the product. (required)
     * @param id The ID of the product Price. (required)
     * @param updateProductPrice The payload for updating a new product price. (required)
     * @param prefer The HTTP Prefer header per https://tools.ietf.org/html/rfc7240. The \&#39;return&#x3D;[representation|minimal]\&#39; preferences are the only implemented settings at the moment and are the same as \&#39;return&#x3D;SIMPLE\&#39;, and it indicates that the client wishes the server to return a minimal response to a successful request. The \&#39;return&#x3D;representation\&#39; preference in this header is the same as setting query parameter \&#39;return&#x3D;FULL\&#39;. (optional)
     * @return GTVProductPrice
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper updateProductPrice(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('productId'), 'productId');
      client.assertNotNull(params.get('id'), 'id');
      client.assertNotNull(
        params.get('createProductPrice'),
        'createProductPrice'
      );
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();
      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'PUT',
        '/products/{product_id}/prices/{id}',
        (RestAPI2Domain.GTVAPICreateProductPrice) params.get(
          'createProductPrice'
        ),
        query,
        form,
        new Map<String, Object>{
          'product_id' => (String) params.get('productId'),
          'id' => (String) params.get('id')
        },
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIProductPrice.class
      );
    }
  }

  /*
   * TRACT Billing API
   * An API to retrieve and store TRACT objects for core operations.\nJSON looks like this:  \n```JSON\n{\n  "key": "value",\n  "anotherKey": "anotherValue"\n}\n```\n
   *
   * OpenAPI spec version: 2
   * Contact: support@gotransverse.com
   *
   * NOTE: This class is auto generated by the GTVAPIRestClient code generator program.
   * https://github.com/GTVAPIRestClient-api/GTVAPIRestClient-codegen.git
   * Do not edit the class manually.
   */

  public class GTVAPIOrderItemService {
    GTVAPIClient client;

    public GTVAPIOrderItemService(GTVAPIClient client) {
      this.client = client;
    }

    public GTVAPIOrderItemService() {
      this.client = new GTVAPIClient();
    }

    public GTVAPIClient getClient() {
      return this.client;
    }

    /**
     * Approve an OrderItem
     * Approve an OrderItem
     * @param id The internal id of an object. (required)
     * @param approveOrderItem The payload to approve an order-item (required)
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    /*   public void approveOrderItem(Map<String, Object> params) {
        client.assertNotNull(params.get('id'), 'id');
        client.assertNotNull(params.get('approveOrderItem'), 'approveOrderItem');
        List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
        List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

        client.invoke(
            'POST', '/order-items/{id}/approve',
            (GTVAPIApproveOrderItem) params.get('approveOrderItem'),
            query, form,
            new Map<String, Object>{
                'id' => (String) params.get('id')
            },
            new Map<String, Object>(),
            new List<String>{ 'application/json' },
            new List<String>{ 'application/json' },
            new List<String> { 'x-api-key', 'bearer' },
            null
        );
    }*/
    /**
     * Get the order item specified by the id
     * Get an order-item
     * @param id The internal id of an object. (required)
     * @param prefer return&#x3D;[representation|minimal] The HTTP Prefer header. See https://tools.ietf.org/html/rfc7240 (optional)
     * @param r_return Specifies the amount of detail to provide in a response. (optional, default to FULL)
     * @return GTVAPIOrderItem
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper getOrderItem(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('return', (String) params.get('r_return')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/order-items/{id}',
        '',
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIOrderItem.class
      );
    }
    /**
     * Query for order items with the specified query
     * Query TRACT order items
     * @param filter API query language string (optional)
     * @param prefer return&#x3D;[representation|minimal] The HTTP Prefer header. See https://tools.ietf.org/html/rfc7240 (optional)
     * @param r_return Specifies the amount of detail to provide in a response. (optional, default to FULL)
     * @param pageNumber The page number for multiple page queries (optional, default to 1)
     * @param pageSize The page size for multiple page queries. Default maximum is 50 (optional, default to 50)
     * @param id The internal id of an object. (optional)
     * @param parentOrderItemId The parent order item id (optional)
     * @param orderItemStatus the order-item status (optional)
     * @param orderId The id of a TRACT order (optional)
     * @param orderNum (unique_key) An order number (optional)
     * @param billingAccountId The id of a TRACT billing account (optional)
     * @param accountNum The billing account number (optional)
     * @param externalAccountNum The external account number (optional)
     * @param serviceId The id of a TRACT service (optional)
     * @param serviceResourceIdentifier The identifier of a TRACT service resource (optional)
     * @param discountResourceIdentifier The resource of a TRACT discount (optional)
     * @param productId The id of a TRACT product (optional)
     * @param productType The type of a TRACT product (optional)
     * @return List<GTVAPIOrderItem>
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper queryOrderItems(
      Map<String, Object> params
    ) {
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('filter', (String) params.get('filter')));
      query.addAll(client.makeParam('return', (String) params.get('r_return')));
      query.addAll(
        client.makeParam('page_number', (Integer) params.get('pageNumber'))
      );
      query.addAll(
        client.makeParam('page_size', (Integer) params.get('pageSize'))
      );
      query.addAll(client.makeParam('id', (String) params.get('id')));
      query.addAll(
        client.makeParam(
          'parent_order_item_id',
          (String) params.get('parentOrderItemId')
        )
      );
      query.addAll(
        client.makeParam(
          'order_item_status',
          (String) params.get('orderItemStatus')
        )
      );
      query.addAll(
        client.makeParam('order_id', (String) params.get('orderId'))
      );
      query.addAll(
        client.makeParam('order_num', (String) params.get('orderNum'))
      );
      query.addAll(
        client.makeParam(
          'billing_account_id',
          (String) params.get('billingAccountId')
        )
      );
      query.addAll(
        client.makeParam('account_num', (String) params.get('accountNum'))
      );
      query.addAll(
        client.makeParam(
          'external_account_num',
          (String) params.get('externalAccountNum')
        )
      );
      query.addAll(
        client.makeParam('service_id', (String) params.get('serviceId'))
      );
      query.addAll(
        client.makeParam(
          'service_resource_identifier',
          (String) params.get('serviceResourceIdentifier')
        )
      );
      query.addAll(
        client.makeParam(
          'discount_resource_identifier',
          (String) params.get('discountResourceIdentifier')
        )
      );
      query.addAll(
        client.makeParam('product_id', (String) params.get('productId'))
      );
      query.addAll(
        client.makeParam('product_type', (String) params.get('productType'))
      );

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/order-items',
        '',
        query,
        form,
        new Map<String, Object>(),
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        List<RestAPI2Domain.GTVAPIOrderItem>.class
      );
    }
  }

  public class GTVAPIAdjustmentService {
    GTVAPIClient client;

    public GTVAPIAdjustmentService(GTVAPIClient client) {
      this.client = client;
    }

    public GTVAPIAdjustmentService() {
      this.client = new GTVAPIClient();
    }

    public GTVAPIClient getClient() {
      return this.client;
    }

    /**
     * Create a credit adjustment
     *
     * @param adjustment The TRACT adjustment in JSON format (required)
     * @param prefer return&#x3D;[representation|minimal] The HTTP Prefer header. See https://tools.ietf.org/html/rfc7240 (optional)
     * @return GTVAPICreditAccountAdjustment
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper createCreditAdjustment(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('adjustment'), 'adjustment');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'POST',
        '/credit-adjustments',
        (RestAPI2Domain.GTVAPICreateAccountAdjustment) params.get('adjustment'),
        query,
        form,
        new Map<String, Object>(),
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPICreditAccountAdjustment.class
      );
    }
    /**
     * Create a debit adjustment
     *
     * @param adjustment The TRACT adjustment in JSON format (required)
     * @param prefer return&#x3D;[representation|minimal] The HTTP Prefer header. See https://tools.ietf.org/html/rfc7240 (optional)
     * @return GTVAPIDebitAccountAdjustment
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper createDebitAdjustment(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('adjustment'), 'adjustment');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'POST',
        '/debit-adjustments',
        (RestAPI2Domain.GTVAPICreateAccountAdjustment) params.get('adjustment'),
        query,
        form,
        new Map<String, Object>(),
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIDebitAccountAdjustment.class
      );
    }
    /**
     *
     *
     * @param id The internal id of an object. (required)
     * @param prefer return&#x3D;[representation|minimal] The HTTP Prefer header. See https://tools.ietf.org/html/rfc7240 (optional)
     * @param r_return Specifies the amount of detail to provide in a response. (optional, default to FULL)
     * @return GTVAPICreditAccountAdjustment
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper getCreditAdjustment(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('return', (String) params.get('r_return')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/credit-adjustments/{id}',
        '',
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPICreditAccountAdjustment.class
      );
    }
    /**
     *
     *
     * @param id The internal id of an object. (required)
     * @param prefer return&#x3D;[representation|minimal] The HTTP Prefer header. See https://tools.ietf.org/html/rfc7240 (optional)
     * @param r_return Specifies the amount of detail to provide in a response. (optional, default to FULL)
     * @return GTVAPIDebitAccountAdjustment
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    /*public GTVAPIDebitAccountAdjustment getDebitAdjustment(Map<String, Object> params) {
        client.assertNotNull(params.get('id'), 'id');
        List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

        // cast query params to verify their expected type
        query.addAll(client.makeParam('return', (String) params.get('r_return')));

        List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

        return (GTVAPIDebitAccountAdjustment) client.invoke(
            'GET', '/debit-adjustments/{id}', '',
            query, form,
            new Map<String, Object>{
                'id' => (String) params.get('id')
            },
            new Map<String, Object>{
                'Prefer' => (String) params.get('prefer')
            },
            new List<String>{ 'application/json' },
            new List<String>{ 'application/json' },
            new List<String> { 'x-api-key', 'bearer' },
            GTVAPIDebitAccountAdjustment.class
        );
    }*/
    /**
     *
     *
     * @param id The internal id of an object. (required)
     * @param prefer return&#x3D;[representation|minimal] The HTTP Prefer header. See https://tools.ietf.org/html/rfc7240 (optional)
     * @param r_return Specifies the amount of detail to provide in a response. (optional, default to FULL)
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public void postCreditAdjustment(Map<String, Object> params) {
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('return', (String) params.get('r_return')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      client.invoke(
        'POST',
        '/credit-adjustments/{id}/post',
        '',
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        null
      );
    }

    /*Added Manually for posting Debit Adjustments */
    public void postDebitAdjustment(Map<String, Object> params) {
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('return', (String) params.get('r_return')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      client.invoke(
        'POST',
        '/debit-adjustments/{id}/post',
        '',
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        null
      );
    }

    /**
     *
     *
     * @param filter API query language string (optional)
     * @param prefer return&#x3D;[representation|minimal] The HTTP Prefer header. See https://tools.ietf.org/html/rfc7240 (optional)
     * @param r_return Specifies the amount of detail to provide in a response. (optional, default to FULL)
     * @param pageNumber The page number for multiple page queries (optional, default to 1)
     * @param pageSize The page size for multiple page queries. Default maximum is 50 (optional, default to 50)
     * @param id The internal id of an object. (optional)
     * @param billingAccountId The id of a TRACT billing account (optional)
     * @param accountNum The billing account number (optional)
     * @param status The TRACT adjustment status (optional)
     * @param invoiceId The id of a TRACT invoice (optional)
     * @param invoiceNum The number of a TRACT invoice (optional)
     * @param occurredOn The date that the adjustment occurred (optional)
     * @param unappliedAmount The unapplied adjustment amount (optional)
     * @param creditNumber The cdit number (optional)
     * @return List<GTVAPICreditAccountAdjustment>
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper queryCreditAdjustments(
      Map<String, Object> params
    ) {
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('filter', (String) params.get('filter')));
      query.addAll(client.makeParam('return', (String) params.get('r_return')));
      query.addAll(
        client.makeParam('page_number', (Integer) params.get('pageNumber'))
      );
      query.addAll(
        client.makeParam('page_size', (Integer) params.get('pageSize'))
      );
      query.addAll(client.makeParam('id', (String) params.get('id')));
      query.addAll(
        client.makeParam(
          'billing_account_id',
          (String) params.get('billingAccountId')
        )
      );
      query.addAll(
        client.makeParam('account_num', (String) params.get('accountNum'))
      );
      query.addAll(client.makeParam('status', (String) params.get('status')));
      query.addAll(
        client.makeParam('invoice_id', (String) params.get('invoiceId'))
      );
      query.addAll(
        client.makeParam('invoice_num', (String) params.get('invoiceNum'))
      );
      query.addAll(
        client.makeParam('occurred_on', (DateTime) params.get('occurredOn'))
      );
      query.addAll(
        client.makeParam(
          'unapplied_amount',
          (Double) params.get('unappliedAmount')
        )
      );
      query.addAll(
        client.makeParam('credit_number', (Double) params.get('creditNumber'))
      );

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/credit-adjustments',
        '',
        query,
        form,
        new Map<String, Object>(),
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        List<RestAPI2Domain.GTVAPICreditAccountAdjustment>.class
      );
    }
    /**
     *
     *
     * @param filter API query language string (optional)
     * @param prefer return&#x3D;[representation|minimal] The HTTP Prefer header. See https://tools.ietf.org/html/rfc7240 (optional)
     * @param r_return Specifies the amount of detail to provide in a response. (optional, default to FULL)
     * @param pageNumber The page number for multiple page queries (optional, default to 1)
     * @param pageSize The page size for multiple page queries. Default maximum is 50 (optional, default to 50)
     * @param id The internal id of an object. (optional)
     * @param billingAccountId The id of a TRACT billing account (optional)
     * @param accountNum The billing account number (optional)
     * @param status The TRACT adjustment status (optional)
     * @param invoiceId The id of a TRACT invoice (optional)
     * @param invoiceNum The number of a TRACT invoice (optional)
     * @param occurredOn The date that the adjustment occurred (optional)
     * @param unappliedAmount The unapplied adjustment amount (optional)
     * @return List<GTVAPIDebitAccountAdjustment>
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper queryDebitAdjustments(
      Map<String, Object> params
    ) {
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('filter', (String) params.get('filter')));
      query.addAll(client.makeParam('return', (String) params.get('r_return')));
      query.addAll(
        client.makeParam('page_number', (Integer) params.get('pageNumber'))
      );
      query.addAll(
        client.makeParam('page_size', (Integer) params.get('pageSize'))
      );
      query.addAll(client.makeParam('id', (String) params.get('id')));
      query.addAll(
        client.makeParam(
          'billing_account_id',
          (String) params.get('billingAccountId')
        )
      );
      query.addAll(
        client.makeParam('account_num', (String) params.get('accountNum'))
      );
      query.addAll(client.makeParam('status', (String) params.get('status')));
      query.addAll(
        client.makeParam('invoice_id', (String) params.get('invoiceId'))
      );
      query.addAll(
        client.makeParam('invoice_num', (String) params.get('invoiceNum'))
      );
      query.addAll(
        client.makeParam('occurred_on', (DateTime) params.get('occurredOn'))
      );
      query.addAll(
        client.makeParam(
          'unapplied_amount',
          (Double) params.get('unappliedAmount')
        )
      );

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/debit-adjustments',
        '',
        query,
        form,
        new Map<String, Object>(),
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        List<RestAPI2Domain.GTVAPIDebitAccountAdjustment>.class
      );
    }
  }

  /*
   * TRACT Billing API
   * Create and manage billing accounts, products, orders, services, billing, invoicing, payments, and the general ledger. This microservice provides core functionality for the goTransverse billing platform.
   *
   * OpenAPI spec version: 2
   *
   *
   * NOTE: This class is auto generated by the GTVAPIRestClient code generator program.
   * https://github.com/GTVAPIRestClient-api/GTVAPIRestClient-codegen.git
   * Do not edit the class manually.
   */

  public class GTVAPIRecurringPaymentService {
    GTVAPIClient client;

    public GTVAPIRecurringPaymentService(GTVAPIClient client) {
      this.client = client;
    }

    public GTVAPIRecurringPaymentService() {
      this.client = new GTVAPIClient();
    }

    public GTVAPIClient getClient() {
      return this.client;
    }

    /**
     * Activate auto payment
     * Activates auto payment by setting the recurring payment associated with the specified ID as the default for its billing account.
     * @param id The internal ID of the object. (required)
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public void activateAutoPayment(Map<String, Object> params) {
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      client.invoke(
        'POST',
        '/recurring-payments/{id}/activate-auto-payment',
        '',
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        null
      );
    }
    /**
     * Deactivate auto payment
     * Deactivates auto payment by deselecting this recurring payment associated with the specified ID as default for its billing account.
     * @param id The internal ID of the object. (required)
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public void deactivateAutoPayment(Map<String, Object> params) {
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      client.invoke(
        'POST',
        '/recurring-payments/{id}/deactivate-auto-payment',
        '',
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        null
      );
    }
    /**
     * Get BPAY recurring payment
     * A special endpoint that is used only for BPAY. It retrieves an existing BPAY recurring payment. The BPAY payment method requires that it be queried with non-standard query parameters that do not apply to any other payment method type.
     * @param billerCode The biller code of BPAY. (required)
     * @param customerReferenceNumber The BPAY customer reference number. (required)
     * @param filter The API query language string which allows you to specify additional query criteria. (optional)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @param pageNumber The page number for multiple page queries. (optional, default to 1)
     * @param pageSize The page size for multiple page queries. Default maximum is 50. (optional, default to 50)
     * @param id The internal ID of the object. (optional)
     * @param autoPayment Specifies whether the auto-payment is applied. (optional)
     * @param validFrom The date and time from when the resource is valid. (optional)
     * @param validTo The date and time until when the resource is valid. (optional)
     * @param billingAccountId The ID of the billing account. (optional)
     * @param accountNum The billing account number. (optional)
     * @param externalAccountNum The account number tied to an external system. (optional)
     * @return GTVAPIRecurringPayment
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper getBPayRecurringPayment(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('billerCode'), 'billerCode');
      client.assertNotNull(
        params.get('customerReferenceNumber'),
        'customerReferenceNumber'
      );
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('filter', (String) params.get('filter')));
      query.addAll(client.makeParam('return', (String) params.get('r_return')));
      query.addAll(
        client.makeParam('page_number', (Integer) params.get('pageNumber'))
      );
      query.addAll(
        client.makeParam('page_size', (Integer) params.get('pageSize'))
      );
      query.addAll(client.makeParam('id', (String) params.get('id')));
      query.addAll(
        client.makeParam('biller_code', (String) params.get('billerCode'))
      );
      query.addAll(
        client.makeParam(
          'customer_reference_number',
          (String) params.get('customerReferenceNumber')
        )
      );
      query.addAll(
        client.makeParam('auto_payment', (Boolean) params.get('autoPayment'))
      );
      query.addAll(
        client.makeParam('valid_from', (DateTime) params.get('validFrom'))
      );
      query.addAll(
        client.makeParam('valid_to', (DateTime) params.get('validTo'))
      );
      query.addAll(
        client.makeParam(
          'billing_account_id',
          (String) params.get('billingAccountId')
        )
      );
      query.addAll(
        client.makeParam('account_num', (String) params.get('accountNum'))
      );
      query.addAll(
        client.makeParam(
          'external_account_num',
          (String) params.get('externalAccountNum')
        )
      );

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/recurring-payments/bpay',
        '',
        query,
        form,
        new Map<String, Object>(),
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIRecurringPayment.class
      );
    }
    /**
     * Get recurring payment by ID
     * Retrieves the recurring payment associated with the specified ID.
     * @param id The internal ID of the object. (required)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @return GTVAPIRecurringPayment
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper getRecurringPayment(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('return', (String) params.get('r_return')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/recurring-payments/{id}',
        '',
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIRecurringPayment.class
      );
    }
    /**
     * Get recurring payments
     * Uses query keys to retrieve a subset of existing recurring payments.
     * @param filter The API query language string which allows you to specify additional query criteria. (optional)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @param pageNumber The page number for multiple page queries. (optional, default to 1)
     * @param pageSize The page size for multiple page queries. Default maximum is 50. (optional, default to 50)
     * @param id The internal ID of the object. (optional)
     * @param billingAccountId The ID of the billing account. (optional)
     * @param accountNum The billing account number. (optional)
     * @param externalAccountNum The account number tied to an external system. (optional)
     * @param token A payment token (cooresponds to token in tokenized-credit-card payment method). (optional)
     * @param validFrom The date and time from when the resource is valid. (optional)
     * @param validTo The date and time until when the resource is valid. (optional)
     * @param autoPayment Specifies whether the auto-payment is applied. (optional)
     * @return List<GTVAPIRecurringPayment>
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper queryRecurringPayments(
      Map<String, Object> params
    ) {
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('filter', (String) params.get('filter')));
      query.addAll(client.makeParam('return', (String) params.get('r_return')));
      query.addAll(
        client.makeParam('page_number', (Integer) params.get('pageNumber'))
      );
      query.addAll(
        client.makeParam('page_size', (Integer) params.get('pageSize'))
      );
      query.addAll(client.makeParam('id', (String) params.get('id')));
      query.addAll(
        client.makeParam(
          'billing_account_id',
          (String) params.get('billingAccountId')
        )
      );
      query.addAll(
        client.makeParam('account_num', (String) params.get('accountNum'))
      );
      query.addAll(
        client.makeParam(
          'external_account_num',
          (String) params.get('externalAccountNum')
        )
      );
      query.addAll(client.makeParam('token', (String) params.get('token')));
      query.addAll(
        client.makeParam('valid_from', (DateTime) params.get('validFrom'))
      );
      query.addAll(
        client.makeParam('valid_to', (DateTime) params.get('validTo'))
      );
      query.addAll(
        client.makeParam('auto_payment', (Boolean) params.get('autoPayment'))
      );

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/recurring-payments',
        '',
        query,
        form,
        new Map<String, Object>(),
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        List<RestAPI2Domain.GTVAPIRecurringPayment>.class
      );
    }
  }

  public class GTVAPIPaymentApplicationService {
    GTVAPIClient client;

    public GTVAPIPaymentApplicationService(GTVAPIClient client) {
      this.client = client;
    }

    public GTVAPIPaymentApplicationService() {
      this.client = new GTVAPIClient();
    }

    public GTVAPIClient getClient() {
      return this.client;
    }

    /**
     *
     *
     * @param id The internal id of an object. (required)
     * @param prefer return&#x3D;[representation|minimal] The HTTP Prefer header. See https://tools.ietf.org/html/rfc7240 (optional)
     * @param r_return Specifies the amount of detail to provide in a response. (optional, default to FULL)
     * @return GTVAPIPaymentApplication
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper getPaymentApplication(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('return', (String) params.get('r_return')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/payment-applications/{id}',
        '',
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIPaymentApplication.class
      );
    }
    /**
     *
     *
     * @param filter API query language string (optional)
     * @param prefer return&#x3D;[representation|minimal] The HTTP Prefer header. See https://tools.ietf.org/html/rfc7240 (optional)
     * @param r_return Specifies the amount of detail to provide in a response. (optional, default to FULL)
     * @param pageNumber The page number for multiple page queries (optional, default to 1)
     * @param pageSize The page size for multiple page queries. Default maximum is 50 (optional, default to 50)
     * @param id The internal id of an object. (optional)
     * @param paymentId The payment id (optional)
     * @param invoiceId The id of a TRACT invoice (optional)
     * @param invoiceNum The number of a TRACT invoice (optional)
     * @param billingAccountId The id of a TRACT billing account (optional)
     * @param externalAccountNum The external account number (optional)
     * @param accountNum The billing account number (optional)
     * @param occurredOn The date that the payment occurred (optional)
     * @param updatedOn The date that the payment-application updated (optional)
     * @param unappliedAmount The unapplied payment amount (optional)
     * @param paymentApplicationType The payment application type (optional)
     * @return List<GTVAPIPaymentApplication>
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper queryPaymentApplications(
      Map<String, Object> params
    ) {
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('filter', (String) params.get('filter')));
      query.addAll(client.makeParam('return', (String) params.get('r_return')));
      query.addAll(
        client.makeParam('page_number', (Integer) params.get('pageNumber'))
      );
      query.addAll(
        client.makeParam('page_size', (Integer) params.get('pageSize'))
      );
      query.addAll(client.makeParam('id', (String) params.get('id')));
      query.addAll(
        client.makeParam('payment_id', (String) params.get('paymentId'))
      );
      query.addAll(
        client.makeParam('invoice_id', (String) params.get('invoiceId'))
      );
      query.addAll(
        client.makeParam('invoice_num', (String) params.get('invoiceNum'))
      );
      query.addAll(
        client.makeParam(
          'billing_account_id',
          (String) params.get('billingAccountId')
        )
      );
      query.addAll(
        client.makeParam(
          'external_account_num',
          (String) params.get('externalAccountNum')
        )
      );
      query.addAll(
        client.makeParam('account_num', (String) params.get('accountNum'))
      );
      query.addAll(
        client.makeParam('occurred_on', (DateTime) params.get('occurredOn'))
      );
      query.addAll(
        client.makeParam('updated_on', (DateTime) params.get('updatedOn'))
      );
      query.addAll(
        client.makeParam(
          'unapplied_amount',
          (Double) params.get('unappliedAmount')
        )
      );
      query.addAll(
        client.makeParam(
          'payment_application_type',
          (String) params.get('paymentApplicationType')
        )
      );

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/payment-applications',
        '',
        query,
        form,
        new Map<String, Object>(),
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        List<RestAPI2Domain.GTVAPIPaymentApplication>.class
      );
    }
  }

  /*
   * TRACT Billing API
   * Create and manage billing accounts, products, orders, services, billing, invoicing, payments, and the general ledger. This microservice provides core functionality for the goTransverse billing platform.
   *
   * OpenAPI spec version: 2
   *
   *
   * NOTE: This class is auto generated by the GTVAPIRestClient code generator program.
   * https://github.com/GTVAPIRestClient-api/GTVAPIRestClient-codegen.git
   * Do not edit the class manually.
   */

  public class GTVAPIDiscountService {
    GTVAPIClient client;

    public GTVAPIDiscountService(GTVAPIClient client) {
      this.client = client;
    }

    public GTVAPIDiscountService() {
      this.client = new GTVAPIClient();
    }

    public GTVAPIClient getClient() {
      return this.client;
    }

    /**
     * Get discount by ID
     * Retrieves an existing discount associated with the specified ID.
     * @param id The internal ID of the object. (required)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @return GTVAPIDiscount
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper getDiscount(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('return', (String) params.get('r_return')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/discounts/{id}',
        '',
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIDiscount.class
      );
    }
    /**
     * Get discounts
     * Uses query keys to retrieve a subset of existing discounts.
     * @param filter API query language string. The syntax of the API query language is similar to SQL, the criteria are expressed in the form of predicates.\nOn the left side of the equation, there is a name of the available query parameter (for example, billing_account_id). On the right side, there is a constant value in single quotes (\&#39;sample value\&#39;). Brackets are used to group predicates, for example, \&#39;(start_date GT \&#39;1994-01-24T23:33:07+00:00\&#39;)\&#39;. Use the following logical operators: AND - conjunction, OR - disjunction, NOT - negation. Compare operators: NEQ - Not equals, EQ - Equals, LT - Less, LTE - Less or equals, GT - Greater, GTE - Greater or equals, IS NULL - Is null, IS NOT NULL - Is not null, LIKE - Match pattern (LIKE operator is only applicable to parameters of the string type). Wildcard characters: \&#39;%\&#39; - matches any number of characters, including no characters, \&#39;_\&#39; - matches exactly one character.\nHere is the sample query: the account_num GT \&#39;15\&#39; AND (name LIKE \&#39;start of name% end of name\&#39; OR status EQ \&#39;ACTIVE\&#39;).\n (optional)
     * @param r_sort Arranges search results in either ascending or descending order. By default, response results are sorted in the ascending order. To sort results in the descending order, use &quot;-&quot;. For example, the &quot;-name.&quot; value sorts the results in the descending order by name, and &quot;id&quot; sorts results in the ascending order by ID. (optional)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @param pageNumber The page number for multiple page queries. (optional, default to 1)
     * @param pageSize The page size for multiple page queries. Default maximum is 50. (optional, default to 50)
     * @param id The internal ID of the object. (optional)
     * @param name The name of the discount. (optional)
     * @param status The status of the discount. (optional)
     * @param discountType The type of the discount. (optional, default to FLAT)
     * @param discountCategoryId The ID of the discount category. (optional)
     * @param oneTime Specifies whether the discount is a one-time charge. (optional)
     * @param recurring Specifies whether the discount is a recurring charge. (optional)
     * @param currencyCode The currency code of the discount. (optional)
     * @param discountResourceIdentifier A resource of the discount. (optional)
     * @param discountResourceId The resource ID of the discount. (optional)
     * @return List<GTVAPIDiscount>
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper queryDiscounts(
      Map<String, Object> params
    ) {
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('filter', (String) params.get('filter')));
      query.addAll(
        client.makeParam('sort', (List<String>) params.get('r_sort'), 'csv')
      );
      query.addAll(client.makeParam('return', (String) params.get('r_return')));
      query.addAll(
        client.makeParam('page_number', (Integer) params.get('pageNumber'))
      );
      query.addAll(
        client.makeParam('page_size', (Integer) params.get('pageSize'))
      );
      query.addAll(client.makeParam('id', (String) params.get('id')));
      query.addAll(client.makeParam('name', (String) params.get('name')));
      query.addAll(client.makeParam('status', (String) params.get('status')));
      query.addAll(
        client.makeParam('discount_type', (String) params.get('discountType'))
      );
      query.addAll(
        client.makeParam(
          'discount_category_id',
          (String) params.get('discountCategoryId')
        )
      );
      query.addAll(
        client.makeParam('one_time', (Boolean) params.get('oneTime'))
      );
      query.addAll(
        client.makeParam('recurring', (Boolean) params.get('recurring'))
      );
      query.addAll(
        client.makeParam('currency_code', (String) params.get('currencyCode'))
      );
      query.addAll(
        client.makeParam(
          'discount_resource_identifier',
          (String) params.get('discountResourceIdentifier')
        )
      );
      query.addAll(
        client.makeParam(
          'discount_resource_id',
          (String) params.get('discountResourceId')
        )
      );

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/discounts',
        '',
        query,
        form,
        new Map<String, Object>(),
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        List<RestAPI2Domain.GTVAPIDiscount>.class
      );
    }
  }

  public class GTVAPIUsageEventService {
    GTVAPIClient client;

    public GTVAPIUsageEventService(GTVAPIClient client) {
      this.client = client;
    }

    public GTVAPIUsageEventService() {
      this.client = new GTVAPIClient();
    }

    public GTVAPIClient getClient() {
      return this.client;
    }

    /**
     * Create usage events in bulk
     * Creates one or more usage events in a bulk process.
     * @param bulkUsageEventsRequest The payload for the bulk usage events. (required)
     * @param prefer The HTTP Prefer header per https://tools.ietf.org/html/rfc7240. The \&#39;return&#x3D;[representation|minimal]\&#39; preferences are the only implemented settings at the moment and are the same as \&#39;return&#x3D;SIMPLE\&#39;, and it indicates that the client wishes the server to return a minimal response to a successful request. The \&#39;return&#x3D;representation\&#39; preference in this header is the same as setting query parameter \&#39;return&#x3D;FULL\&#39;. (optional)
     * @return GTVAPIRestClient.ResponseWrapper
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper createUsageEvents(
      Map<String, Object> params
    ) {
      client.assertNotNull(
        params.get('bulkUsageEventsRequest'),
        'bulkUsageEventsRequest'
      );
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'POST',
        '/usage-events/bulk',
        (RestAPI2Domain.GTVAPICreateBulkUsageEvents) params.get(
          'bulkUsageEventsRequest'
        ),
        query,
        form,
        new Map<String, Object>(),
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIBulkUsageEvents.class
      );
    }
    /**
     * Get usage event by ID
     * Retrieves an existing usage event associated with the specified ID.
     * @param id The internal ID of the object. (required)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @return GTVAPIRestClient.ResponseWrapper
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper getUsageEvent(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('return', (String) params.get('r_return')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/usage-events/{id}',
        '',
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIUsageEvent.class
      );
    }
    /**
     * Get usage events
     * Uses query keys to retrieve a subset of existing usage events.
     * @param filter API query language string. The syntax of the API query language is similar to SQL, the criteria are expressed in the form of predicates.\nOn the left side of the equation, there is a name of the available query parameter (for example, billing_account_id). On the right side, there is a constant value in single quotes (\&#39;sample value\&#39;). Brackets are used to group predicates, for example, \&#39;(start_date GT \&#39;1994-01-24T23:33:07+00:00\&#39;)\&#39;. Use the following logical operators: AND - conjunction, OR - disjunction, NOT - negation. Compare operators: NEQ - Not equals, EQ - Equals, LT - Less, LTE - Less or equals, GT - Greater, GTE - Greater or equals, IS NULL - Is null, IS NOT NULL - Is not null, LIKE - Match pattern (LIKE operator is only applicable to parameters of the string type). Wildcard characters: \&#39;%\&#39; - matches any number of characters, including no characters, \&#39;_\&#39; - matches exactly one character.\nHere is the sample query: the account_num GT \&#39;15\&#39; AND (name LIKE \&#39;start of name% end of name\&#39; OR status EQ \&#39;ACTIVE\&#39;).\n (optional)
     * @param r_sort Arranges search results in either ascending or descending order. By default, response results are sorted in the ascending order. To sort results in the descending order, use &quot;-&quot;. For example, the &quot;-name.&quot; value sorts the results in the descending order by name, and &quot;id&quot; sorts results in the ascending order by ID. (optional)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @param pageNumber The page number for multiple page queries. (optional, default to 1)
     * @param pageSize The page size for multiple page queries. Default maximum is 50. (optional, default to 50)
     * @param id The internal ID of the object. (optional)
     * @param startTime The date and time when the usage event starts. (optional)
     * @param endTime The date and time when the usage event ends. (optional)
     * @param billingAccountId The ID of the billing account. (optional)
     * @param accountNum The billing account number. (optional)
     * @param servicePeriodId The ID of the service period to which this usage event belongs. (optional)
     * @param referenceId The reference ID associated with this usage event. The combination of the reference ID and sequence ID must be unique. (optional)
     * @param sequenceId The sequence ID associated with this usage event. The combination of the reference ID and sequence ID must be unique. (optional)
     * @param serviceResourceIdentifier The identifier of the service resource. (optional)
     * @param closed Identifies that the service period to which this usage event belongs is closed. (optional)
     * @param requestId Identifies the batch to which this usage event belongs. A request ID is generated for each API request. (optional)
     * @return GTVAPIRestClient.ResponseWrapper
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper queryUsageEvents(
      Map<String, Object> params
    ) {
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('filter', (String) params.get('filter')));
      query.addAll(
        client.makeParam('sort', (List<String>) params.get('r_sort'), 'csv')
      );
      query.addAll(client.makeParam('return', (String) params.get('r_return')));
      query.addAll(
        client.makeParam('page_number', (Integer) params.get('pageNumber'))
      );
      query.addAll(
        client.makeParam('page_size', (Integer) params.get('pageSize'))
      );
      query.addAll(client.makeParam('id', (String) params.get('id')));
      query.addAll(
        client.makeParam('start_time', (Datetime) params.get('startTime'))
      );
      query.addAll(
        client.makeParam('end_time', (Datetime) params.get('endTime'))
      );
      query.addAll(
        client.makeParam(
          'billing_account_id',
          (String) params.get('billingAccountId')
        )
      );
      query.addAll(
        client.makeParam('account_num', (String) params.get('accountNum'))
      );
      query.addAll(
        client.makeParam(
          'service_period_id',
          (String) params.get('servicePeriodId')
        )
      );
      query.addAll(
        client.makeParam('reference_id', (String) params.get('referenceId'))
      );
      query.addAll(
        client.makeParam('sequence_id', (String) params.get('sequenceId'))
      );
      query.addAll(
        client.makeParam(
          'service_resource_identifier',
          (String) params.get('serviceResourceIdentifier')
        )
      );
      query.addAll(client.makeParam('closed', (Boolean) params.get('closed')));
      query.addAll(
        client.makeParam('request_id', (String) params.get('requestId'))
      );

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/usage-events',
        '',
        query,
        form,
        new Map<String, Object>(),
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        List<RestAPI2Domain.GTVAPIUsageEvent>.class
      );
    }
    /**
     * Simulate creating usage event
     * Simulates a process of creating one or more usage events in a bulk process.
     * @param bulkUsageEventsRequest The payload for the bulk usage events. (required)
     * @param prefer The HTTP Prefer header per https://tools.ietf.org/html/rfc7240. The \&#39;return&#x3D;[representation|minimal]\&#39; preferences are the only implemented settings at the moment and are the same as \&#39;return&#x3D;SIMPLE\&#39;, and it indicates that the client wishes the server to return a minimal response to a successful request. The \&#39;return&#x3D;representation\&#39; preference in this header is the same as setting query parameter \&#39;return&#x3D;FULL\&#39;. (optional)
     * @return GTVAPIRestClient.ResponseWrapper
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper simulateUsageEvents(
      Map<String, Object> params
    ) {
      client.assertNotNull(
        params.get('bulkUsageEventsRequest'),
        'bulkUsageEventsRequest'
      );
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'POST',
        '/usage-events/simulate/bulk',
        (RestAPI2Domain.GTVAPICreateBulkUsageEvents) params.get(
          'bulkUsageEventsRequest'
        ),
        query,
        form,
        new Map<String, Object>(),
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIBulkUsageEvents.class
      );
    }
    /**
     * Void usage events in bulk
     * Voids one or more usage events in a bulk process.
     * @param bulkUsageEventsVoidRequest The payload for the void bulk usage events. (required)
     * @param prefer The HTTP Prefer header per https://tools.ietf.org/html/rfc7240. The \&#39;return&#x3D;[representation|minimal]\&#39; preferences are the only implemented settings at the moment and are the same as \&#39;return&#x3D;SIMPLE\&#39;, and it indicates that the client wishes the server to return a minimal response to a successful request. The \&#39;return&#x3D;representation\&#39; preference in this header is the same as setting query parameter \&#39;return&#x3D;FULL\&#39;. (optional)
     * @return GTVAPIRestClient.ResponseWrapper
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper voidUsageEvents(
      Map<String, Object> params
    ) {
      client.assertNotNull(
        params.get('bulkUsageEventsVoidRequest'),
        'bulkUsageEventsVoidRequest'
      );
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'POST',
        '/usage-events/bulk-void',
        (RestAPI2Domain.GTVAPICreateBulkVoidUsageEvents) params.get(
          'bulkUsageEventsVoidRequest'
        ),
        query,
        form,
        new Map<String, Object>(),
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIBulkVoidUsageEvents.class
      );
    }
  }
  /*
   * TRACT Billing API
   * Create and manage billing accounts, products, orders, services, billing, invoicing, payments, and the general ledger. This microservice provides core functionality for the goTransverse billing platform.
   *
   * OpenAPI spec version: 2
   *
   *
   * NOTE: This class is auto generated by the swagger code generator program.
   * https://github.com/swagger-api/swagger-codegen.git
   * Do not edit the class manually.
   */

  public class GTVAPIOrderCustomFieldService {
    GTVAPIClient client;

    public GTVAPIOrderCustomFieldService(GTVAPIClient client) {
      this.client = client;
    }

    public GTVAPIOrderCustomFieldService() {
      this.client = new GTVAPIClient();
    }

    public GTVAPIClient getClient() {
      return this.client;
    }

    /**
     * Get order custom field by ID
     * Retrieves an existing order custom field associated with the specified ID.
     * @param id The internal ID of the object. (required)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @return GTVOrderCustomField
     * @throws GTVAPIger.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper getOrderCustomField(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('return', (String) params.get('r_return')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/order-custom-fields/{id}',
        '',
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIOrderCustomField.class
      );
    }
    /**
     * Get order custom field references
     * Retrieves existing references for the specified order custom field.
     * @param customFieldId The ID of billing account custom field. (required)
     * @param filter API query language string. The syntax of the API query language is similar to SQL, the criteria are expressed in the form of predicates.\nOn the left side of the equation, there is a name of the available query parameter (for example, billing_account_id). On the right side, there is a constant value in single quotes (\&#39;sample value\&#39;). Brackets are used to group predicates, for example, \&#39;(start_date GT \&#39;1994-01-24T23:33:07+00:00\&#39;)\&#39;. Use the following logical operators: AND - conjunction, OR - disjunction, NOT - negation. Compare operators: NEQ - Not equals, EQ - Equals, LT - Less, LTE - Less or equals, GT - Greater, GTE - Greater or equals, IS NULL - Is null, IS NOT NULL - Is not null, LIKE - Match pattern (LIKE operator is only applicable to parameters of the string type). Wildcard characters: \&#39;%\&#39; - matches any number of characters, including no characters, \&#39;_\&#39; - matches exactly one character.\nHere is the sample query: the account_num GT \&#39;15\&#39; AND (name LIKE \&#39;start of name% end of name\&#39; OR status EQ \&#39;ACTIVE\&#39;).\n (optional)
     * @param r_sort Arranges search results in either ascending or descending order. By default, response results are sorted in the ascending order. To sort results in the descending order, use &quot;-&quot;. For example, the &quot;-name.&quot; value sorts the results in the descending order by name, and &quot;id&quot; sorts results in the ascending order by ID. (optional)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @param pageNumber The page number for multiple page queries. (optional, default to 1)
     * @param pageSize The page size for multiple page queries. Default maximum is 50. (optional, default to 50)
     * @param id The internal ID of the object. (optional)
     * @param status A custom field value reference status. (optional)
     * @return List<GTVCustomFieldValueReference>
     * @throws GTVAPIger.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper queryOrderCustomFieldValueReferences(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('customFieldId'), 'customFieldId');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('filter', (String) params.get('filter')));
      query.addAll(
        client.makeParam('sort', (List<String>) params.get('r_sort'), 'csv')
      );
      query.addAll(client.makeParam('return', (String) params.get('r_return')));
      query.addAll(
        client.makeParam('page_number', (Integer) params.get('pageNumber'))
      );
      query.addAll(
        client.makeParam('page_size', (Integer) params.get('pageSize'))
      );
      query.addAll(client.makeParam('id', (String) params.get('id')));
      query.addAll(client.makeParam('status', (String) params.get('status')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/order-custom-fields/{custom_field_id}/references',
        '',
        query,
        form,
        new Map<String, Object>{
          'custom_field_id' => (String) params.get('customFieldId')
        },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        List<RestAPI2Domain.GTVAPICustomFieldValueReference>.class
      );
    }
    /**
     * Get order custom fields
     * Retrieves existing order custom fields.
     * @param filter API query language string. The syntax of the API query language is similar to SQL, the criteria are expressed in the form of predicates.\nOn the left side of the equation, there is a name of the available query parameter (for example, billing_account_id). On the right side, there is a constant value in single quotes (\&#39;sample value\&#39;). Brackets are used to group predicates, for example, \&#39;(start_date GT \&#39;1994-01-24T23:33:07+00:00\&#39;)\&#39;. Use the following logical operators: AND - conjunction, OR - disjunction, NOT - negation. Compare operators: NEQ - Not equals, EQ - Equals, LT - Less, LTE - Less or equals, GT - Greater, GTE - Greater or equals, IS NULL - Is null, IS NOT NULL - Is not null, LIKE - Match pattern (LIKE operator is only applicable to parameters of the string type). Wildcard characters: \&#39;%\&#39; - matches any number of characters, including no characters, \&#39;_\&#39; - matches exactly one character.\nHere is the sample query: the account_num GT \&#39;15\&#39; AND (name LIKE \&#39;start of name% end of name\&#39; OR status EQ \&#39;ACTIVE\&#39;).\n (optional)
     * @param r_sort Arranges search results in either ascending or descending order. By default, response results are sorted in the ascending order. To sort results in the descending order, use &quot;-&quot;. For example, the &quot;-name.&quot; value sorts the results in the descending order by name, and &quot;id&quot; sorts results in the ascending order by ID. (optional)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @param pageNumber The page number for multiple page queries. (optional, default to 1)
     * @param pageSize The page size for multiple page queries. Default maximum is 50. (optional, default to 50)
     * @param id The internal ID of the object. (optional)
     * @param name The name of the custom field. (optional)
     * @param enabled The enabled property of the custom field. (optional)
     * @param searchable The searchable property of the custom field. (optional)
     * @return List<GTVOrderCustomField>
     * @throws GTVAPIger.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper queryOrderCustomFields(
      Map<String, Object> params
    ) {
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('filter', (String) params.get('filter')));
      query.addAll(
        client.makeParam('sort', (List<String>) params.get('r_sort'), 'csv')
      );
      query.addAll(client.makeParam('return', (String) params.get('r_return')));
      query.addAll(
        client.makeParam('page_number', (Integer) params.get('pageNumber'))
      );
      query.addAll(
        client.makeParam('page_size', (Integer) params.get('pageSize'))
      );
      query.addAll(client.makeParam('id', (String) params.get('id')));
      query.addAll(client.makeParam('name', (String) params.get('name')));
      query.addAll(
        client.makeParam('enabled', (Boolean) params.get('enabled'))
      );
      query.addAll(
        client.makeParam('searchable', (Boolean) params.get('searchable'))
      );

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/order-custom-fields',
        '',
        query,
        form,
        new Map<String, Object>(),
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        List<RestAPI2Domain.GTVAPIOrderCustomField>.class
      );
    }
  } /*
   * TRACT Billing API
   * Create and manage billing accounts, products, orders, services, billing, invoicing, payments, and the general ledger. This microservice provides core functionality for the goTransverse billing platform.
   *
   * OpenAPI spec version: 2
   *
   *
   * NOTE: This class is auto generated by the swagger code generator program.
   * https://github.com/swagger-api/swagger-codegen.git
   * Do not edit the class manually.
   */
  public class GTVAPIBillingAccountCustomFieldService {
    GTVAPIClient client;

    public GTVAPIBillingAccountCustomFieldService(GTVAPIClient client) {
      this.client = client;
    }

    public GTVAPIBillingAccountCustomFieldService() {
      this.client = new GTVAPIClient();
    }

    public GTVAPIClient getClient() {
      return this.client;
    }

    /**
     * Get billing account custom field by ID
     * Retrieves an existing billing account custom field associated with the specified ID.
     * @param id The internal ID of the object. (required)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @return GTVBillingAccountCustomField
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper getBillingAccountCustomField(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('return', (String) params.get('r_return')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/billing-account-custom-fields/{id}',
        '',
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVBillingAccountCustomField.class
      );
    }
    /**
     * Get billing account custom field references
     * Retrieves existing references for billing account custom field with the specified ID.
     * @param customFieldId The ID of billing account custom field. (required)
     * @param filter API query language string. The syntax of the API query language is similar to SQL, the criteria are expressed in the form of predicates.\nOn the left side of the equation, there is a name of the available query parameter (for example, billing_account_id). On the right side, there is a constant value in single quotes (\&#39;sample value\&#39;). Brackets are used to group predicates, for example, \&#39;(start_date GT \&#39;1994-01-24T23:33:07+00:00\&#39;)\&#39;. Use the following logical operators: AND - conjunction, OR - disjunction, NOT - negation. Compare operators: NEQ - Not equals, EQ - Equals, LT - Less, LTE - Less or equals, GT - Greater, GTE - Greater or equals, IS NULL - Is null, IS NOT NULL - Is not null, LIKE - Match pattern (LIKE operator is only applicable to parameters of the string type). Wildcard characters: \&#39;%\&#39; - matches any number of characters, including no characters, \&#39;_\&#39; - matches exactly one character.\nHere is the sample query: the account_num GT \&#39;15\&#39; AND (name LIKE \&#39;start of name% end of name\&#39; OR status EQ \&#39;ACTIVE\&#39;).\n (optional)
     * @param r_sort Arranges search results in either ascending or descending order. By default, response results are sorted in the ascending order. To sort results in the descending order, use &quot;-&quot;. For example, the &quot;-name.&quot; value sorts the results in the descending order by name, and &quot;id&quot; sorts results in the ascending order by ID. (optional)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @param pageNumber The page number for multiple page queries. (optional, default to 1)
     * @param pageSize The page size for multiple page queries. Default maximum is 50. (optional, default to 50)
     * @param id The internal ID of the object. (optional)
     * @param status A custom field value reference status. (optional)
     * @return List<GTVCustomFieldValueReference>
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper queryBillingAccountCustomFieldValueReferences(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('customFieldId'), 'customFieldId');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('filter', (String) params.get('filter')));
      query.addAll(
        client.makeParam('sort', (List<String>) params.get('r_sort'), 'csv')
      );
      query.addAll(client.makeParam('return', (String) params.get('r_return')));
      query.addAll(
        client.makeParam('page_number', (Integer) params.get('pageNumber'))
      );
      query.addAll(
        client.makeParam('page_size', (Integer) params.get('pageSize'))
      );
      query.addAll(client.makeParam('id', (String) params.get('id')));
      query.addAll(client.makeParam('status', (String) params.get('status')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/billing-account-custom-fields/{custom_field_id}/references',
        '',
        query,
        form,
        new Map<String, Object>{
          'custom_field_id' => (String) params.get('customFieldId')
        },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        List<RestAPI2Domain.GTVAPICustomFieldValueReference>.class
      );
    }
    /**
     * Get billing account custom fields
     * Retrieves the existing billing account custom fields.
     * @param filter API query language string. The syntax of the API query language is similar to SQL, the criteria are expressed in the form of predicates.\nOn the left side of the equation, there is a name of the available query parameter (for example, billing_account_id). On the right side, there is a constant value in single quotes (\&#39;sample value\&#39;). Brackets are used to group predicates, for example, \&#39;(start_date GT \&#39;1994-01-24T23:33:07+00:00\&#39;)\&#39;. Use the following logical operators: AND - conjunction, OR - disjunction, NOT - negation. Compare operators: NEQ - Not equals, EQ - Equals, LT - Less, LTE - Less or equals, GT - Greater, GTE - Greater or equals, IS NULL - Is null, IS NOT NULL - Is not null, LIKE - Match pattern (LIKE operator is only applicable to parameters of the string type). Wildcard characters: \&#39;%\&#39; - matches any number of characters, including no characters, \&#39;_\&#39; - matches exactly one character.\nHere is the sample query: the account_num GT \&#39;15\&#39; AND (name LIKE \&#39;start of name% end of name\&#39; OR status EQ \&#39;ACTIVE\&#39;).\n (optional)
     * @param r_sort Arranges search results in either ascending or descending order. By default, response results are sorted in the ascending order. To sort results in the descending order, use &quot;-&quot;. For example, the &quot;-name.&quot; value sorts the results in the descending order by name, and &quot;id&quot; sorts results in the ascending order by ID. (optional)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @param pageNumber The page number for multiple page queries. (optional, default to 1)
     * @param pageSize The page size for multiple page queries. Default maximum is 50. (optional, default to 50)
     * @param id The internal ID of the object. (optional)
     * @param name The name of the custom field. (optional)
     * @param enabled The enabled property of the custom field. (optional)
     * @param searchable The searchable property of the custom field. (optional)
     * @return List<GTVBillingAccountCustomField>
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper queryBillingAccountCustomFields(
      Map<String, Object> params
    ) {
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('filter', (String) params.get('filter')));
      query.addAll(
        client.makeParam('sort', (List<String>) params.get('r_sort'), 'csv')
      );
      query.addAll(client.makeParam('return', (String) params.get('r_return')));
      query.addAll(
        client.makeParam('page_number', (Integer) params.get('pageNumber'))
      );
      query.addAll(
        client.makeParam('page_size', (Integer) params.get('pageSize'))
      );
      query.addAll(client.makeParam('id', (String) params.get('id')));
      query.addAll(client.makeParam('name', (String) params.get('name')));
      query.addAll(
        client.makeParam('enabled', (Boolean) params.get('enabled'))
      );
      query.addAll(
        client.makeParam('searchable', (Boolean) params.get('searchable'))
      );

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/billing-account-custom-fields',
        '',
        query,
        form,
        new Map<String, Object>(),
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        List<RestAPI2Domain.GTVAPIBillingAccountCustomField>.class
      );
    }
  }

  /*
   * TRACT Billing API
   * Create and manage billing accounts, products, orders, services, billing, invoicing, payments, and the general ledger. This microservice provides core functionality for the goTransverse billing platform.
   *
   * OpenAPI spec version: 2
   *
   *
   * NOTE: This class is auto generated by the swagger code generator program.
   * https://github.com/swagger-api/swagger-codegen.git
   * Do not edit the class manually.
   */

  public class GTVAPIServiceCustomFieldService {
    GTVAPIClient client;

    public GTVAPIServiceCustomFieldService(GTVAPIClient client) {
      this.client = client;
    }

    public GTVAPIServiceCustomFieldService() {
      this.client = new GTVAPIClient();
    }

    public GTVAPIClient getClient() {
      return this.client;
    }

    /**
     * Get service custom field by ID
     * Retrieves an existing service custom field associated with the specified ID.
     * @param id The internal ID of the object. (required)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @return GTVServiceCustomField
     * @throws GTVAPIger.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper getServiceCustomField(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('return', (String) params.get('r_return')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/service-custom-fields/{id}',
        '',
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIServiceCustomField.class
      );
    }
    /**
     * Get service custom field references
     * Retrieves existing references for the service custom field associated with the specified ID.
     * @param customFieldId The ID of billing account custom field. (required)
     * @param filter API query language string. The syntax of the API query language is similar to SQL, the criteria are expressed in the form of predicates.\nOn the left side of the equation, there is a name of the available query parameter (for example, billing_account_id). On the right side, there is a constant value in single quotes (\&#39;sample value\&#39;). Brackets are used to group predicates, for example, \&#39;(start_date GT \&#39;1994-01-24T23:33:07+00:00\&#39;)\&#39;. Use the following logical operators: AND - conjunction, OR - disjunction, NOT - negation. Compare operators: NEQ - Not equals, EQ - Equals, LT - Less, LTE - Less or equals, GT - Greater, GTE - Greater or equals, IS NULL - Is null, IS NOT NULL - Is not null, LIKE - Match pattern (LIKE operator is only applicable to parameters of the string type). Wildcard characters: \&#39;%\&#39; - matches any number of characters, including no characters, \&#39;_\&#39; - matches exactly one character.\nHere is the sample query: the account_num GT \&#39;15\&#39; AND (name LIKE \&#39;start of name% end of name\&#39; OR status EQ \&#39;ACTIVE\&#39;).\n (optional)
     * @param r_sort Arranges search results in either ascending or descending order. By default, response results are sorted in the ascending order. To sort results in the descending order, use &quot;-&quot;. For example, the &quot;-name.&quot; value sorts the results in the descending order by name, and &quot;id&quot; sorts results in the ascending order by ID. (optional)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @param pageNumber The page number for multiple page queries. (optional, default to 1)
     * @param pageSize The page size for multiple page queries. Default maximum is 50. (optional, default to 50)
     * @param id The internal ID of the object. (optional)
     * @param status A custom field value reference status. (optional)
     * @return List<GTVCustomFieldValueReference>
     * @throws GTVAPIger.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper queryServiceCustomFieldValueReferences(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('customFieldId'), 'customFieldId');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('filter', (String) params.get('filter')));
      query.addAll(
        client.makeParam('sort', (List<String>) params.get('r_sort'), 'csv')
      );
      query.addAll(client.makeParam('return', (String) params.get('r_return')));
      query.addAll(
        client.makeParam('page_number', (Integer) params.get('pageNumber'))
      );
      query.addAll(
        client.makeParam('page_size', (Integer) params.get('pageSize'))
      );
      query.addAll(client.makeParam('id', (String) params.get('id')));
      query.addAll(client.makeParam('status', (String) params.get('status')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/service-custom-fields/{custom_field_id}/references',
        '',
        query,
        form,
        new Map<String, Object>{
          'custom_field_id' => (String) params.get('customFieldId')
        },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        List<RestAPI2Domain.GTVAPICustomFieldValueReference>.class
      );
    }
    /**
     * Get service custom fields
     * Uses query keys to retrieve a subset of existing service custom fields.
     * @param filter API query language string. The syntax of the API query language is similar to SQL, the criteria are expressed in the form of predicates.\nOn the left side of the equation, there is a name of the available query parameter (for example, billing_account_id). On the right side, there is a constant value in single quotes (\&#39;sample value\&#39;). Brackets are used to group predicates, for example, \&#39;(start_date GT \&#39;1994-01-24T23:33:07+00:00\&#39;)\&#39;. Use the following logical operators: AND - conjunction, OR - disjunction, NOT - negation. Compare operators: NEQ - Not equals, EQ - Equals, LT - Less, LTE - Less or equals, GT - Greater, GTE - Greater or equals, IS NULL - Is null, IS NOT NULL - Is not null, LIKE - Match pattern (LIKE operator is only applicable to parameters of the string type). Wildcard characters: \&#39;%\&#39; - matches any number of characters, including no characters, \&#39;_\&#39; - matches exactly one character.\nHere is the sample query: the account_num GT \&#39;15\&#39; AND (name LIKE \&#39;start of name% end of name\&#39; OR status EQ \&#39;ACTIVE\&#39;).\n (optional)
     * @param r_sort Arranges search results in either ascending or descending order. By default, response results are sorted in the ascending order. To sort results in the descending order, use &quot;-&quot;. For example, the &quot;-name.&quot; value sorts the results in the descending order by name, and &quot;id&quot; sorts results in the ascending order by ID. (optional)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @param pageNumber The page number for multiple page queries. (optional, default to 1)
     * @param pageSize The page size for multiple page queries. Default maximum is 50. (optional, default to 50)
     * @param id The internal ID of the object. (optional)
     * @param name The name of the custom field. (optional)
     * @param enabled The enabled property of the custom field. (optional)
     * @param searchable The searchable property of the custom field. (optional)
     * @return List<GTVServiceCustomField>
     * @throws GTVAPIger.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper queryServiceCustomFields(
      Map<String, Object> params
    ) {
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('filter', (String) params.get('filter')));
      query.addAll(
        client.makeParam('sort', (List<String>) params.get('r_sort'), 'csv')
      );
      query.addAll(client.makeParam('return', (String) params.get('r_return')));
      query.addAll(
        client.makeParam('page_number', (Integer) params.get('pageNumber'))
      );
      query.addAll(
        client.makeParam('page_size', (Integer) params.get('pageSize'))
      );
      query.addAll(client.makeParam('id', (String) params.get('id')));
      query.addAll(client.makeParam('name', (String) params.get('name')));
      query.addAll(
        client.makeParam('enabled', (Boolean) params.get('enabled'))
      );
      query.addAll(
        client.makeParam('searchable', (Boolean) params.get('searchable'))
      );
      query.addAll(
        client.makeParam('product_id', (String) params.get('productId'))
      );

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/service-custom-fields',
        '',
        query,
        form,
        new Map<String, Object>(),
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        List<RestAPI2Domain.GTVAPIServiceCustomField>.class
      );
    }
  }
  /*
   * TRACT Billing API
   * Create and manage billing accounts, products, orders, services, billing, invoicing, payments, and the general ledger. This microservice provides core functionality for the goTransverse billing platform.
   *
   * OpenAPI spec version: 2
   *
   *
   * NOTE: This class is auto generated by the swagger code generator program.
   * https://github.com/swagger-api/swagger-codegen.git
   * Do not edit the class manually.
   */

  public class GTVAPIPriceListService {
    GTVAPIClient client;

    public GTVAPIPriceListService(GTVAPIClient client) {
      this.client = client;
    }

    public GTVAPIPriceListService() {
      this.client = new GTVAPIClient();
    }

    public GTVAPIClient getClient() {
      return this.client;
    }

    /**
     * Get price list by ID
     * Retrieves an existing price list associated with the specified ID.
     * @param id The internal ID of the object. (required)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @return GTVPriceList
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper getPriceList(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('return', (String) params.get('r_return')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/price-lists/{id}',
        '',
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIPriceList.class
      );
    }
    /**
     * Get price list Relation by ID
     * Retrieves an existing price list associated with the specified ID.
     * @param id The internal ID of the object. (required)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @return GTVAPIPriceListProductRelation
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper getPriceListProductRelation(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('priceListId'), 'priceListId');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('return', (String) params.get('r_return')));
      query.addAll(client.makeParam('filter', (String) params.get('filter')));
      query.addAll(
        client.makeParam('sort', (List<String>) params.get('r_sort'), 'csv')
      );
      query.addAll(client.makeParam('return', (String) params.get('r_return')));
      query.addAll(
        client.makeParam('page_number', (Integer) params.get('pageNumber'))
      );
      query.addAll(
        client.makeParam('page_size', (Integer) params.get('pageSize'))
      );
      query.addAll(client.makeParam('id', (String) params.get('id')));
      query.addAll(
        client.makeParam('product_id', (String) params.get('productId'))
      );
      query.addAll(
        client.makeParam('product_name', (String) params.get('productName'))
      );
      query.addAll(
        client.makeParam('product_sku', (String) params.get('productSku'))
      );
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/price-lists/{price_list_id}/product-relations',
        '',
        query,
        form,
        new Map<String, Object>{
          'price_list_id' => (String) params.get('priceListId')
        },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        list<RestAPI2Domain.GTVAPIPriceListProductRelation>.class
      );
    }
    /**
     * Get price list Relation by ID
     * Retrieves an existing price list associated with the specified ID.
     * @param id The internal ID of the object. (required)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @return GTVAPIPriceListProductRelation
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    /**
     * Delete product priceList relation
     * Removes an existing product agreement relation associated with the specified product and product agreement relation IDs.
     * @param productId The ID of the product. (required)
     * @param id The internal ID of the object. (required)
     * @throws Swagger.ApiException if fails to make API call
     */
    public void removePriceListProductRelation(Map<String, Object> params) {
      client.assertNotNull(params.get('priceListId'), 'priceListId');
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      client.invoke(
        'DELETE',
        '/price-lists/{price_list_id}/product-relations/{id}',
        '',
        query,
        form,
        new Map<String, Object>{
          'price_list_id' => (String) params.get('priceListId'),
          'id' => (String) params.get('id')
        },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        null
      );
    }
    /**
     * Get price lists
     * Uses query keys to retrieve a subset of existing price lists.
     * @param filter API query language string. The syntax of the API query language is similar to SQL, the criteria are expressed in the form of predicates.\nOn the left side of the equation, there is a name of the available query parameter (for example, billing_account_id). On the right side, there is a constant value in single quotes (\&#39;sample value\&#39;). Brackets are used to group predicates, for example, \&#39;(start_date GT \&#39;1994-01-24T23:33:07+00:00\&#39;)\&#39;. Use the following logical operators: AND - conjunction, OR - disjunction, NOT - negation. Compare operators: NEQ - Not equals, EQ - Equals, LT - Less, LTE - Less or equals, GT - Greater, GTE - Greater or equals, IS NULL - Is null, IS NOT NULL - Is not null, LIKE - Match pattern (LIKE operator is only applicable to parameters of the string type). Wildcard characters: \&#39;%\&#39; - matches any number of characters, including no characters, \&#39;_\&#39; - matches exactly one character.\nHere is the sample query: the account_num GT \&#39;15\&#39; AND (name LIKE \&#39;start of name% end of name\&#39; OR status EQ \&#39;ACTIVE\&#39;).\n (optional)
     * @param r_sort Arranges search results in either ascending or descending order. By default, response results are sorted in the ascending order. To sort results in the descending order, use &quot;-&quot;. For example, the &quot;-name.&quot; value sorts the results in the descending order by name, and &quot;id&quot; sorts results in the ascending order by ID. (optional)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @param pageNumber The page number for multiple page queries. (optional, default to 1)
     * @param pageSize The page size for multiple page queries. Default maximum is 50. (optional, default to 50)
     * @param id The internal ID of the object. (optional)
     * @param name The name of the product price list. (optional)
     * @param description The description of the product price list. (optional)
     * @param marketplaceId The marketplace ID of the price list. (optional)
     * @return List<GTVPriceList>
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper queryPriceLists(
      Map<String, Object> params
    ) {
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('filter', (String) params.get('filter')));
      query.addAll(
        client.makeParam('sort', (List<String>) params.get('r_sort'), 'csv')
      );
      query.addAll(client.makeParam('return', (String) params.get('r_return')));
      query.addAll(
        client.makeParam('page_number', (Integer) params.get('pageNumber'))
      );
      query.addAll(
        client.makeParam('page_size', (Integer) params.get('pageSize'))
      );
      query.addAll(client.makeParam('id', (String) params.get('id')));
      query.addAll(client.makeParam('name', (String) params.get('name')));
      query.addAll(
        client.makeParam('description', (String) params.get('description'))
      );
      query.addAll(
        client.makeParam('marketplace_id', (String) params.get('marketplaceId'))
      );

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/price-lists',
        '',
        query,
        form,
        new Map<String, Object>(),
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        List<RestAPI2Domain.GTVAPIPriceList>.class
      );
    }
    /**
     * Associate product to price lists
     * Uses query keys to retrieve a subset of existing price lists.
     * @param filter API query language string. The syntax of the API query language is similar to SQL, the criteria are expressed in the form of predicates.\nOn the left side of the equation, there is a name of the available query parameter (for example, billing_account_id). On the right side, there is a constant value in single quotes (\&#39;sample value\&#39;). Brackets are used to group predicates, for example, \&#39;(start_date GT \&#39;1994-01-24T23:33:07+00:00\&#39;)\&#39;. Use the following logical operators: AND - conjunction, OR - disjunction, NOT - negation. Compare operators: NEQ - Not equals, EQ - Equals, LT - Less, LTE - Less or equals, GT - Greater, GTE - Greater or equals, IS NULL - Is null, IS NOT NULL - Is not null, LIKE - Match pattern (LIKE operator is only applicable to parameters of the string type). Wildcard characters: \&#39;%\&#39; - matches any number of characters, including no characters, \&#39;_\&#39; - matches exactly one character.\nHere is the sample query: the account_num GT \&#39;15\&#39; AND (name LIKE \&#39;start of name% end of name\&#39; OR status EQ \&#39;ACTIVE\&#39;).\n (optional)
     * @param r_sort Arranges search results in either ascending or descending order. By default, response results are sorted in the ascending order. To sort results in the descending order, use &quot;-&quot;. For example, the &quot;-name.&quot; value sorts the results in the descending order by name, and &quot;id&quot; sorts results in the ascending order by ID. (optional)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @param pageNumber The page number for multiple page queries. (optional, default to 1)
     * @param pageSize The page size for multiple page queries. Default maximum is 50. (optional, default to 50)
     * @param id The internal ID of the object. (optional)
     * @param name The name of the product price list. (optional)
     * @param description The description of the product price list. (optional)
     * @param marketplaceId The marketplace ID of the price list. (optional)
     * @return List<GTVPriceList>
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper associateProductToPriceList(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('priceListId'), 'priceListId');
      client.assertNotNull(params.get('productRelation'), 'productRelation');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'POST',
        '/price-lists/{price_list_id}/product-relations',
        (RestAPI2Domain.GTVAPIProductRelation) params.get('productRelation'),
        query,
        form,
        new Map<String, Object>{
          'price_list_id' => (String) params.get('priceListId')
        },
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        null
      );
    }
  }
  /*
   * TRACT Billing API
   * Create and manage billing accounts, products, orders, services, billing, invoicing, payments, and the general ledger. This microservice provides core functionality for the goTransverse billing platform.
   *
   * OpenAPI spec version: 2
   *
   *
   * NOTE: This class is auto generated by the swagger code generator program.
   * https://github.com/swagger-api/swagger-codegen.git
   * Do not edit the class manually.
   */

  public class GTVAPIBillCycleService {
    GTVAPIClient client;

    public GTVAPIBillCycleService(GTVAPIClient client) {
      this.client = client;
    }

    public GTVAPIBillCycleService() {
      this.client = new GTVAPIClient();
    }

    public GTVAPIClient getClient() {
      return this.client;
    }

    /**
     * Activate bill cycle
     * Activates the existing bill cycle with the specified ID.
     * @param id The internal ID of the object. (required)
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public void activateBillCycle(Map<String, Object> params) {
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      client.invoke(
        'POST',
        '/bill-cycles/{id}/activate',
        '',
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        null
      );
    }
    /**
     * Cancel bill cycle
     * Cancels the existing bill cycle.
     * @param id The internal ID of the object. (required)
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public void cancelBillCycle(Map<String, Object> params) {
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      client.invoke(
        'POST',
        '/bill-cycles/{id}/cancel',
        '',
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        null
      );
    }
    /**
     * Change bill cycle
     * Moves a billing account associated with the specified ID to a different bill cycle.
     * @param id The internal ID of the object. (required)
     * @param billCycle A payload for moving a billing account to the different bill cycle. (required)
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public void changeBillCycle(Map<String, Object> params) {
      client.assertNotNull(params.get('id'), 'id');
      client.assertNotNull(params.get('billCycle'), 'billCycle');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      client.invoke(
        'POST',
        '/billing-accounts/{id}/change-bill-cycle',
        (RestAPI2Domain.GTVAPIChangeBillCycleCommand) params.get('billCycle'),
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        null
      );
    }
    /**
     * Create bill cycle
     * Creates a new bill cycle.
     * @param billCycle A payload for creating a bill cycle. (required)
     * @param prefer The HTTP Prefer header per https://tools.ietf.org/html/rfc7240. The \&#39;return&#x3D;[representation|minimal]\&#39; preferences are the only implemented settings at the moment and are the same as \&#39;return&#x3D;SIMPLE\&#39;, and it indicates that the client wishes the server to return a minimal response to a successful request. The \&#39;return&#x3D;representation\&#39; preference in this header is the same as setting query parameter \&#39;return&#x3D;FULL\&#39;. (optional)
     * @return GTVBillCycle
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper createBillCycle(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('billCycle'), 'billCycle');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'POST',
        '/bill-cycles',
        (RestAPI2Domain.GTVAPICreateBillCycle) params.get('billCycle'),
        query,
        form,
        new Map<String, Object>(),
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIBillCycle.class
      );
    }
    /**
     * Get actions
     * Retrieves a subset of existing actions using query keys.
     * @param billCycleId The ID of the bill cycle. (required)
     * @param id The internal ID of the object. (required)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @return GTVBillCycleRunAction
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper getActionByBillCycle(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('billCycleId'), 'billCycleId');
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('return', (String) params.get('r_return')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/bill-cycles/{bill_cycle_id}/actions/{id}',
        '',
        query,
        form,
        new Map<String, Object>{
          'bill_cycle_id' => (String) params.get('billCycleId'),
          'id' => (String) params.get('id')
        },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIBillCycleRunAction.class
      );
    }
    /**
     * Get bill cycle by ID
     * Retrieves an existing bill cycle with the specified bill cycle ID.
     * @param id The internal ID of the object. (required)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @param expand Includes additional entities in the response. You can expand only those entities which have a specific extension for it. The primary value is a CSV of the available sub-entities. (optional)
     * @return GTVBillCycle
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper getBillCycle(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('return', (String) params.get('r_return')));
      query.addAll(
        client.makeParam('expand', (List<String>) params.get('expand'), 'csv')
      );

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/bill-cycles/{id}',
        '',
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIBillCycle.class
      );
    }
    /**
     * Get actions
     * Retrieves a subset of existing actions using query keys.
     * @param billCycleId The ID of the bill cycle. (required)
     * @param filter API query language string. The syntax of the API query language is similar to SQL, the criteria are expressed in the form of predicates.\nOn the left side of the equation, there is a name of the available query parameter (for example, billing_account_id). On the right side, there is a constant value in single quotes (\&#39;sample value\&#39;). Brackets are used to group predicates, for example, \&#39;(start_date GT \&#39;1994-01-24T23:33:07+00:00\&#39;)\&#39;. Use the following logical operators: AND - conjunction, OR - disjunction, NOT - negation. Compare operators: NEQ - Not equals, EQ - Equals, LT - Less, LTE - Less or equals, GT - Greater, GTE - Greater or equals, IS NULL - Is null, IS NOT NULL - Is not null, LIKE - Match pattern (LIKE operator is only applicable to parameters of the string type). Wildcard characters: \&#39;%\&#39; - matches any number of characters, including no characters, \&#39;_\&#39; - matches exactly one character.\nHere is the sample query: the account_num GT \&#39;15\&#39; AND (name LIKE \&#39;start of name% end of name\&#39; OR status EQ \&#39;ACTIVE\&#39;).\n (optional)
     * @param r_sort Arranges search results in either ascending or descending order. By default, response results are sorted in the ascending order. To sort results in the descending order, use &quot;-&quot;. For example, the &quot;-name.&quot; value sorts the results in the descending order by name, and &quot;id&quot; sorts results in the ascending order by ID. (optional)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @param pageNumber The page number for multiple page queries. (optional, default to 1)
     * @param pageSize The page size for multiple page queries. Default maximum is 50. (optional, default to 50)
     * @param id The internal ID of the object. (optional)
     * @return List<GTVBillCycleRunAction>
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper queryActionsByBillCycle(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('billCycleId'), 'billCycleId');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('filter', (String) params.get('filter')));
      query.addAll(
        client.makeParam('sort', (List<String>) params.get('r_sort'), 'csv')
      );
      query.addAll(client.makeParam('return', (String) params.get('r_return')));
      query.addAll(
        client.makeParam('page_number', (Integer) params.get('pageNumber'))
      );
      query.addAll(
        client.makeParam('page_size', (Integer) params.get('pageSize'))
      );
      query.addAll(client.makeParam('id', (String) params.get('id')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/bill-cycles/{bill_cycle_id}/actions',
        '',
        query,
        form,
        new Map<String, Object>{
          'bill_cycle_id' => (String) params.get('billCycleId')
        },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        List<RestAPI2Domain.GTVAPIBillCycleRunAction>.class
      );
    }
    /**
     * Get bill cyles
     * Uses query keys to retrieve a subset of existing bill cycles.
     * @param filter API query language string. The syntax of the API query language is similar to SQL, the criteria are expressed in the form of predicates.\nOn the left side of the equation, there is a name of the available query parameter (for example, billing_account_id). On the right side, there is a constant value in single quotes (\&#39;sample value\&#39;). Brackets are used to group predicates, for example, \&#39;(start_date GT \&#39;1994-01-24T23:33:07+00:00\&#39;)\&#39;. Use the following logical operators: AND - conjunction, OR - disjunction, NOT - negation. Compare operators: NEQ - Not equals, EQ - Equals, LT - Less, LTE - Less or equals, GT - Greater, GTE - Greater or equals, IS NULL - Is null, IS NOT NULL - Is not null, LIKE - Match pattern (LIKE operator is only applicable to parameters of the string type). Wildcard characters: \&#39;%\&#39; - matches any number of characters, including no characters, \&#39;_\&#39; - matches exactly one character.\nHere is the sample query: the account_num GT \&#39;15\&#39; AND (name LIKE \&#39;start of name% end of name\&#39; OR status EQ \&#39;ACTIVE\&#39;).\n (optional)
     * @param r_sort Arranges search results in either ascending or descending order. By default, response results are sorted in the ascending order. To sort results in the descending order, use &quot;-&quot;. For example, the &quot;-name.&quot; value sorts the results in the descending order by name, and &quot;id&quot; sorts results in the ascending order by ID. (optional)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @param expand Includes additional entities in the response. You can expand only those entities which have a specific extension for it. The primary value is a CSV of the available sub-entities. (optional)
     * @param pageNumber The page number for multiple page queries. (optional, default to 1)
     * @param pageSize The page size for multiple page queries. Default maximum is 50. (optional, default to 50)
     * @param name The name of the bill cycle. (optional)
     * @param billCycleType The type of the bill cycle. (optional, default to monthly)
     * @param status The accounting status, meaning the status of the General Ledger. (optional, default to ACTIVE)
     * @param currencyCode The currency code for the amount. (optional)
     * @param id The internal ID of the object. (optional)
     * @return List<GTVBillCycle>
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper queryBillCycles(
      Map<String, Object> params
    ) {
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('filter', (String) params.get('filter')));
      query.addAll(
        client.makeParam('sort', (List<String>) params.get('r_sort'), 'csv')
      );
      query.addAll(client.makeParam('return', (String) params.get('r_return')));
      query.addAll(
        client.makeParam('expand', (List<String>) params.get('expand'), 'csv')
      );
      query.addAll(
        client.makeParam('page_number', (Integer) params.get('pageNumber'))
      );
      query.addAll(
        client.makeParam('page_size', (Integer) params.get('pageSize'))
      );
      query.addAll(client.makeParam('name', (String) params.get('name')));
      query.addAll(
        client.makeParam(
          'bill_cycle_type',
          (String) params.get('billCycleType')
        )
      );
      query.addAll(client.makeParam('status', (String) params.get('status')));
      query.addAll(
        client.makeParam('currency_code', (String) params.get('currencyCode'))
      );
      query.addAll(client.makeParam('id', (String) params.get('id')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/bill-cycles',
        '',
        query,
        form,
        new Map<String, Object>(),
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        List<RestAPI2Domain.GTVAPIBillCycle>.class
      );
    }
    /**
     * Suspend bill cycle
     * Suspends the existing bill cycle with the specified ID.
     * @param id The internal ID of the object. (required)
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public void suspendBillCycle(Map<String, Object> params) {
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      client.invoke(
        'POST',
        '/bill-cycles/{id}/suspend',
        '',
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        null
      );
    }
    /**
     * Update bill cycle
     * Updates the existing bill cycle with the specified ID.
     * @param id The internal ID of the object. (required)
     * @param updateBillCycle A payload for updating a bill cycle. (required)
     * @param prefer The HTTP Prefer header per https://tools.ietf.org/html/rfc7240. The \&#39;return&#x3D;[representation|minimal]\&#39; preferences are the only implemented settings at the moment and are the same as \&#39;return&#x3D;SIMPLE\&#39;, and it indicates that the client wishes the server to return a minimal response to a successful request. The \&#39;return&#x3D;representation\&#39; preference in this header is the same as setting query parameter \&#39;return&#x3D;FULL\&#39;. (optional)
     * @return GTVBillCycle
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper updateBillCycle(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('id'), 'id');
      client.assertNotNull(params.get('updateBillCycle'), 'updateBillCycle');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'PUT',
        '/bill-cycles/{id}',
        (RestAPI2Domain.GTVAPIBillCycle) params.get('updateBillCycle'),
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIBillCycle.class
      );
    }
  }
  /*
   * TRACT Billing API
   * Create and manage billing accounts, products, orders, services, billing, invoicing, payments, and the general ledger. This microservice provides core functionality for the goTransverse billing platform.
   *
   * OpenAPI spec version: 2
   *
   *
   * NOTE: This class is auto generated by the swagger code generator program.
   * https://github.com/swagger-api/swagger-codegen.git
   * Do not edit the class manually.
   */

  public class GTVAPIPaymentTermService {
    GTVAPIClient client;

    public GTVAPIPaymentTermService(GTVAPIClient client) {
      this.client = client;
    }

    public GTVAPIPaymentTermService() {
      this.client = new GTVAPIClient();
    }

    public GTVAPIClient getClient() {
      return this.client;
    }

    /**
     * Get payment term by ID
     * Retrieves an existing payment term associated with the specified ID.
     * @param id The internal ID of the object. (required)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @return GTVPaymentTerm
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper getPaymentTerm(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('return', (String) params.get('r_return')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/payment-terms/{id}',
        '',
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIPaymentTerm.class
      );
    }
    /**
     * Get payment terms
     * Uses query keys to retrieve a subset of existing payment terms.
     * @param filter API query language string. The syntax of the API query language is similar to SQL, the criteria are expressed in the form of predicates.\nOn the left side of the equation, there is a name of the available query parameter (for example, billing_account_id). On the right side, there is a constant value in single quotes (\&#39;sample value\&#39;). Brackets are used to group predicates, for example, \&#39;(start_date GT \&#39;1994-01-24T23:33:07+00:00\&#39;)\&#39;. Use the following logical operators: AND - conjunction, OR - disjunction, NOT - negation. Compare operators: NEQ - Not equals, EQ - Equals, LT - Less, LTE - Less or equals, GT - Greater, GTE - Greater or equals, IS NULL - Is null, IS NOT NULL - Is not null, LIKE - Match pattern (LIKE operator is only applicable to parameters of the string type). Wildcard characters: \&#39;%\&#39; - matches any number of characters, including no characters, \&#39;_\&#39; - matches exactly one character.\nHere is the sample query: the account_num GT \&#39;15\&#39; AND (name LIKE \&#39;start of name% end of name\&#39; OR status EQ \&#39;ACTIVE\&#39;).\n (optional)
     * @param r_sort Arranges search results in either ascending or descending order. By default, response results are sorted in the ascending order. To sort results in the descending order, use &quot;-&quot;. For example, the &quot;-name.&quot; value sorts the results in the descending order by name, and &quot;id&quot; sorts results in the ascending order by ID. (optional)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @param pageNumber The page number for multiple page queries. (optional, default to 1)
     * @param pageSize The page size for multiple page queries. Default maximum is 50. (optional, default to 50)
     * @param id The internal ID of the object. (optional)
     * @param name The payment term name. (optional)
     * @param billingAccountId The ID of the billing account. (optional)
     * @param billingAccountCategoryId The ID of the billing account category. (optional)
     * @return List<GTVPaymentTerm>
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper queryPaymentTerms(
      Map<String, Object> params
    ) {
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('filter', (String) params.get('filter')));
      query.addAll(
        client.makeParam('sort', (List<String>) params.get('r_sort'), 'csv')
      );
      query.addAll(client.makeParam('return', (String) params.get('r_return')));
      query.addAll(
        client.makeParam('page_number', (Integer) params.get('pageNumber'))
      );
      query.addAll(
        client.makeParam('page_size', (Integer) params.get('pageSize'))
      );
      query.addAll(client.makeParam('id', (String) params.get('id')));
      query.addAll(client.makeParam('name', (String) params.get('name')));
      query.addAll(
        client.makeParam(
          'billing_account_id',
          (String) params.get('billingAccountId')
        )
      );
      query.addAll(
        client.makeParam(
          'billing_account_category_id',
          (String) params.get('billingAccountCategoryId')
        )
      );

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/payment-terms',
        '',
        query,
        form,
        new Map<String, Object>(),
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        List<RestAPI2Domain.GTVAPIPaymentTerm>.class
      );
    }
  }
  /*
   * TRACT Billing API
   * Create and manage billing accounts, products, orders, services, billing, invoicing, payments, and the general ledger. This microservice provides core functionality for the goTransverse billing platform.
   *
   * OpenAPI spec version: 2
   *
   *
   * NOTE: This class is auto generated by the swagger code generator program.
   * https://github.com/swagger-api/swagger-codegen.git
   * Do not edit the class manually.
   */

  public class GTVAPIAgreementService {
    GTVAPIClient client;

    public GTVAPIAgreementService(GTVAPIClient client) {
      this.client = client;
    }

    public GTVAPIAgreementService() {
      this.client = new GTVAPIClient();
    }

    public GTVAPIClient getClient() {
      return this.client;
    }

    /**
     * Get agreement by ID
     * Retrieves an existing agreement associated with the specified ID.
     * @param id The internal ID of the object. (required)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @return GTVAgreement
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper getAgreement(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('return', (String) params.get('r_return')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/agreements/{id}',
        '',
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIAgreement.class
      );
    }
    /**
     * Get agreements
     * Uses query keys to retrieve a subset of existing agreements.
     * @param filter API query language string. The syntax of the API query language is similar to SQL, the criteria are expressed in the form of predicates.\nOn the left side of the equation, there is a name of the available query parameter (for example, billing_account_id). On the right side, there is a constant value in single quotes (\&#39;sample value\&#39;). Brackets are used to group predicates, for example, \&#39;(start_date GT \&#39;1994-01-24T23:33:07+00:00\&#39;)\&#39;. Use the following logical operators: AND - conjunction, OR - disjunction, NOT - negation. Compare operators: NEQ - Not equals, EQ - Equals, LT - Less, LTE - Less or equals, GT - Greater, GTE - Greater or equals, IS NULL - Is null, IS NOT NULL - Is not null, LIKE - Match pattern (LIKE operator is only applicable to parameters of the string type). Wildcard characters: \&#39;%\&#39; - matches any number of characters, including no characters, \&#39;_\&#39; - matches exactly one character.\nHere is the sample query: the account_num GT \&#39;15\&#39; AND (name LIKE \&#39;start of name% end of name\&#39; OR status EQ \&#39;ACTIVE\&#39;).\n (optional)
     * @param r_sort Arranges search results in either ascending or descending order. By default, response results are sorted in the ascending order. To sort results in the descending order, use &quot;-&quot;. For example, the &quot;-name.&quot; value sorts the results in the descending order by name, and &quot;id&quot; sorts results in the ascending order by ID. (optional)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @param pageNumber The page number for multiple page queries. (optional, default to 1)
     * @param pageSize The page size for multiple page queries. Default maximum is 50. (optional, default to 50)
     * @param id The internal ID of the object. (optional)
     * @param validFrom The date and time from when the resource is valid. (optional)
     * @param validTo The date and time until when the resource is valid. (optional)
     * @param name The name of the agreement. (optional)
     * @param productId The ID of the product. (optional)
     * @param status The status of the agreement. (optional)
     * @param terminationFeeCurrencyCode The currency code for the agreement termination fee. (optional)
     * @param maxTerminationFeeCurrencyCode The currency code for the maximum agreement termination fee. (optional)
     * @return List<GTVAgreement>
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper queryAgreements(
      Map<String, Object> params
    ) {
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('filter', (String) params.get('filter')));
      query.addAll(
        client.makeParam('sort', (List<String>) params.get('r_sort'), 'csv')
      );
      query.addAll(client.makeParam('return', (String) params.get('r_return')));
      query.addAll(
        client.makeParam('page_number', (Integer) params.get('pageNumber'))
      );
      query.addAll(
        client.makeParam('page_size', (Integer) params.get('pageSize'))
      );
      query.addAll(client.makeParam('id', (String) params.get('id')));
      query.addAll(
        client.makeParam('valid_from', (Datetime) params.get('validFrom'))
      );
      query.addAll(
        client.makeParam('valid_to', (Datetime) params.get('validTo'))
      );
      query.addAll(client.makeParam('name', (String) params.get('name')));
      query.addAll(
        client.makeParam('product_id', (String) params.get('productId'))
      );
      query.addAll(client.makeParam('status', (String) params.get('status')));
      query.addAll(
        client.makeParam(
          'termination_fee_currency_code',
          (String) params.get('terminationFeeCurrencyCode')
        )
      );
      query.addAll(
        client.makeParam(
          'max_termination_fee_currency_code',
          (String) params.get('maxTerminationFeeCurrencyCode')
        )
      );

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/agreements',
        '',
        query,
        form,
        new Map<String, Object>(),
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        List<RestAPI2Domain.GTVAPIAgreement>.class
      );
    }
  }
  /*
   * TRACT Billing API
   * Create and manage billing accounts, products, orders, services, billing, invoicing, payments, and the general ledger. This microservice provides core functionality for the goTransverse billing platform.
   *
   * OpenAPI spec version: 2
   *
   *
   * NOTE: This class is auto generated by the swagger code generator program.
   * https://github.com/swagger-api/swagger-codegen.git
   * Do not edit the class manually.
   */

  public class GTVServiceApi {
    GTVAPIClient client;

    public GTVServiceApi(GTVAPIClient client) {
      this.client = client;
    }

    public GTVServiceApi() {
      this.client = new GTVAPIClient();
    }

    public GTVAPIClient getClient() {
      return this.client;
    }

    /**
     * Add service address
     * Adds an address to the existing service with the specified ID.
     * @param serviceId The ID of the service. (required)
     * @param addServiceAddress The payload for adding a service address. (required)
     * @param prefer The HTTP Prefer header per https://tools.ietf.org/html/rfc7240. The \&#39;return&#x3D;[representation|minimal]\&#39; preferences are the only implemented settings at the moment and are the same as \&#39;return&#x3D;SIMPLE\&#39;, and it indicates that the client wishes the server to return a minimal response to a successful request. The \&#39;return&#x3D;representation\&#39; preference in this header is the same as setting query parameter \&#39;return&#x3D;FULL\&#39;. (optional)
     * @return GTVAPIPostalAddress
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper addServiceAddress(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('serviceId'), 'serviceId');
      client.assertNotNull(
        params.get('addServiceAddress'),
        'addServiceAddress'
      );
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'POST',
        '/services/{service_id}/addresses',
        (RestAPI2Domain.GTVAPIAddServiceAddress) params.get(
          'addServiceAddress'
        ),
        query,
        form,
        new Map<String, Object>{
          'service_id' => (String) params.get('serviceId')
        },
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIPostalAddress.class
      );
    }
    /**
     * Create service resource
     * Adds a service resource to the specified service.
     * @param serviceId The ID of the service. (required)
     * @param addServiceResource The payload for adding a new or existing service resource to the existing service. (required)
     * @param prefer The HTTP Prefer header per https://tools.ietf.org/html/rfc7240. The \&#39;return&#x3D;[representation|minimal]\&#39; preferences are the only implemented settings at the moment and are the same as \&#39;return&#x3D;SIMPLE\&#39;, and it indicates that the client wishes the server to return a minimal response to a successful request. The \&#39;return&#x3D;representation\&#39; preference in this header is the same as setting query parameter \&#39;return&#x3D;FULL\&#39;. (optional)
     * @return GTVAPIServiceResource
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper addServiceResource(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('serviceId'), 'serviceId');
      client.assertNotNull(
        params.get('addServiceResource'),
        'addServiceResource'
      );
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'POST',
        '/services/{service_id}/service-resources',
        (RestAPI2Domain.GTVAPIAddServiceResource) params.get(
          'addServiceResource'
        ),
        query,
        form,
        new Map<String, Object>{
          'service_id' => (String) params.get('serviceId')
        },
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIServiceResource.class
      );
    }
    /**
     * Import a bulk of service resources
     * Imports a bulk of service resources associated with the specified service ID.
     * @param serviceId The ID of the service. (required)
     * @param importServiceResources A payload for importing the bulk of service resources. (required)
     * @param prefer The HTTP Prefer header per https://tools.ietf.org/html/rfc7240. The \&#39;return&#x3D;[representation|minimal]\&#39; preferences are the only implemented settings at the moment and are the same as \&#39;return&#x3D;SIMPLE\&#39;, and it indicates that the client wishes the server to return a minimal response to a successful request. The \&#39;return&#x3D;representation\&#39; preference in this header is the same as setting query parameter \&#39;return&#x3D;FULL\&#39;. (optional)
     * @return GTVAPIBulkServiceResources
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper addServiceResourcesBulk(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('serviceId'), 'serviceId');
      client.assertNotNull(
        params.get('importServiceResources'),
        'importServiceResources'
      );
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'POST',
        '/services/{service_id}/service-resources/bulk',
        (RestAPI2Domain.GTVAPIImportBulkServiceResources) params.get(
          'importServiceResources'
        ),
        query,
        form,
        new Map<String, Object>{
          'service_id' => (String) params.get('serviceId')
        },
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIBulkServiceResources.class
      );
    }
    /**
     * Change service
     * Changes an existing service associated with the specified ID to a new service created from the order specified in the payload.
     * @param id The internal ID of the object. (required)
     * @param changeService The payload for changing the order services. (required)
     * @param prefer The HTTP Prefer header per https://tools.ietf.org/html/rfc7240. The \&#39;return&#x3D;[representation|minimal]\&#39; preferences are the only implemented settings at the moment and are the same as \&#39;return&#x3D;SIMPLE\&#39;, and it indicates that the client wishes the server to return a minimal response to a successful request. The \&#39;return&#x3D;representation\&#39; preference in this header is the same as setting query parameter \&#39;return&#x3D;FULL\&#39;. (optional)
     * @return GTVAPIChangeOrder
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper changeService(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('id'), 'id');
      client.assertNotNull(params.get('changeService'), 'changeService');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();
      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'POST',
        '/services/{id}/change',
        (RestAPI2Domain.GTVAPIChangeService) params.get('changeService'),
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIChangeOrder.class
      );
    }

    //Get Compatible products for a service
    public GTVAPIRestClient.ResponseWrapper getCompatibleProducts(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();
      query.addAll(
        client.makeParam('page_number', (Integer) params.get('pageNumber'))
      );
      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/services/{id}/compatible-products',
        '',
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        List<RestAPI2Domain.GTVAPIProduct>.class
      );
    }
    /**
     * Change service quantity
     * Changes the service quantity associated with the specified service ID.
     * @param id The internal ID of the object. (required)
     * @param changeServiceQuantity The payload for changing the service quantity. (required)
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public void changeServiceQuantity(Map<String, Object> params) {
      client.assertNotNull(params.get('id'), 'id');
      client.assertNotNull(
        params.get('changeServiceQuantity'),
        'changeServiceQuantity'
      );
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      client.invoke(
        'POST',
        '/services/{id}/change-quantity',
        (RestAPI2Domain.GTVAPIChangeServiceQuantity) params.get(
          'changeServiceQuantity'
        ),
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        null
      );
    }
    /**
     * Convert trial service
     * Converts an existing trial service associated with the specified ID.
     * @param id The internal ID of the object. (required)
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public void convertTrialService(Map<String, Object> params) {
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      client.invoke(
        'POST',
        '/services/{id}/convert-trial',
        '',
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        null
      );
    }
    /**
     * Associate agreement with service
     * Associates an agreement with the existing service by service ID. You can associate the agreement only with the service which doesn\&#39;t have a current agreement assigned.
     * @param serviceId The ID of the service. (required)
     * @param createAgreementService The payload for creating an agreement service. (required)
     * @param prefer The HTTP Prefer header per https://tools.ietf.org/html/rfc7240. The \&#39;return&#x3D;[representation|minimal]\&#39; preferences are the only implemented settings at the moment and are the same as \&#39;return&#x3D;SIMPLE\&#39;, and it indicates that the client wishes the server to return a minimal response to a successful request. The \&#39;return&#x3D;representation\&#39; preference in this header is the same as setting query parameter \&#39;return&#x3D;FULL\&#39;. (optional)
     * @return GTVAPIAgreementService
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper createAgreementService(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('serviceId'), 'serviceId');
      client.assertNotNull(
        params.get('createAgreementService'),
        'createAgreementService'
      );
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'POST',
        '/services/{service_id}/agreement-service',
        (RestAPI2Domain.GTVAPICreateAgreementService) params.get(
          'createAgreementService'
        ),
        query,
        form,
        new Map<String, Object>{
          'service_id' => (String) params.get('serviceId')
        },
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIAgreementService.class
      );
    }
    /**
     * Replace recurring price for service
     * Replaces the current recurring price of the specified service with the new one.
     * @param serviceId The ID of the service. (required)
     * @param createRecurringPrice The payload for adding a recurring price. (required)
     * @param prefer The HTTP Prefer header per https://tools.ietf.org/html/rfc7240. The \&#39;return&#x3D;[representation|minimal]\&#39; preferences are the only implemented settings at the moment and are the same as \&#39;return&#x3D;SIMPLE\&#39;, and it indicates that the client wishes the server to return a minimal response to a successful request. The \&#39;return&#x3D;representation\&#39; preference in this header is the same as setting query parameter \&#39;return&#x3D;FULL\&#39;. (optional)
     * @return GTVAPIServicePrice
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper createCurrentRecurringPrice(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('serviceId'), 'serviceId');
      client.assertNotNull(
        params.get('createRecurringPrice'),
        'createRecurringPrice'
      );
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'POST',
        '/services/{service_id}/recurring-price',
        (RestAPI2Domain.GTVAPICreateServicePrice) params.get(
          'createRecurringPrice'
        ),
        query,
        form,
        new Map<String, Object>{
          'service_id' => (String) params.get('serviceId')
        },
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIServicePrice.class
      );
    }
    /**
     * Associate discount resources with service
     * Associates existing discount resources with the specified service ID.
     * @param serviceId The ID of the service. (required)
     * @param createDiscountCodeService A payload for creating the service to discount relation. (required)
     * @param prefer The HTTP Prefer header per https://tools.ietf.org/html/rfc7240. The \&#39;return&#x3D;[representation|minimal]\&#39; preferences are the only implemented settings at the moment and are the same as \&#39;return&#x3D;SIMPLE\&#39;, and it indicates that the client wishes the server to return a minimal response to a successful request. The \&#39;return&#x3D;representation\&#39; preference in this header is the same as setting query parameter \&#39;return&#x3D;FULL\&#39;. (optional)
     * @return GTVAPIDiscountCodeService
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper createDiscountCodeService(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('serviceId'), 'serviceId');
      client.assertNotNull(
        params.get('createDiscountCodeService'),
        'createDiscountCodeService'
      );
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'POST',
        '/services/{service_id}/discount-code-services',
        (RestAPI2Domain.GTVAPICreateDiscountCodeService) params.get(
          'createDiscountCodeService'
        ),
        query,
        form,
        new Map<String, Object>{
          'service_id' => (String) params.get('serviceId')
        },
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIDiscountCodeService.class
      );
    }
    /**
     * Create quantity change
     * Creates a new quantity change on the service with the specified ID.
     * @param serviceId The ID of the service. (required)
     * @param createQuantityChange The payload for changing the service quantity. (required)
     * @param prefer The HTTP Prefer header per https://tools.ietf.org/html/rfc7240. The \&#39;return&#x3D;[representation|minimal]\&#39; preferences are the only implemented settings at the moment and are the same as \&#39;return&#x3D;SIMPLE\&#39;, and it indicates that the client wishes the server to return a minimal response to a successful request. The \&#39;return&#x3D;representation\&#39; preference in this header is the same as setting query parameter \&#39;return&#x3D;FULL\&#39;. (optional)
     * @return GTVAPIQuantityChange
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper createQuantityChange(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('serviceId'), 'serviceId');
      client.assertNotNull(
        params.get('createQuantityChange'),
        'createQuantityChange'
      );
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'POST',
        '/services/{service_id}/quantity-changes',
        (RestAPI2Domain.GTVAPICreateQuantityChange) params.get(
          'createQuantityChange'
        ),
        query,
        form,
        new Map<String, Object>{
          'service_id' => (String) params.get('serviceId')
        },
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIQuantityChange.class
      );
    }
    /**
     * Create custom field value for service
     * Adds a custom field value to an existing custom field associated with the specified service ID.
     * @param serviceId The ID of the service. (required)
     * @param serviceCustomFieldValue A payload for creating the service custom field value. (required)
     * @param prefer The HTTP Prefer header per https://tools.ietf.org/html/rfc7240. The \&#39;return&#x3D;[representation|minimal]\&#39; preferences are the only implemented settings at the moment and are the same as \&#39;return&#x3D;SIMPLE\&#39;, and it indicates that the client wishes the server to return a minimal response to a successful request. The \&#39;return&#x3D;representation\&#39; preference in this header is the same as setting query parameter \&#39;return&#x3D;FULL\&#39;. (optional)
     * @return GTVAPIServiceCustomFieldValue
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper createServiceCustomFieldValue(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('serviceId'), 'serviceId');
      client.assertNotNull(
        params.get('serviceCustomFieldValue'),
        'serviceCustomFieldValue'
      );
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'POST',
        '/services/{service_id}/custom-field-values',
        (RestAPI2Domain.GTVAPICreateServiceCustomFieldValue) params.get(
          'serviceCustomFieldValue'
        ),
        query,
        form,
        new Map<String, Object>{
          'service_id' => (String) params.get('serviceId')
        },
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIServiceCustomFieldValue.class
      );
    }
    /**
     * Add service usage rule
     * Adds a new service usage rule on the service with the specified ID.
     * @param serviceId The ID of the service. (required)
     * @param createServiceUsageRule The payload for creating a new service usage rule. (required)
     * @param prefer The HTTP Prefer header per https://tools.ietf.org/html/rfc7240. The \&#39;return&#x3D;[representation|minimal]\&#39; preferences are the only implemented settings at the moment and are the same as \&#39;return&#x3D;SIMPLE\&#39;, and it indicates that the client wishes the server to return a minimal response to a successful request. The \&#39;return&#x3D;representation\&#39; preference in this header is the same as setting query parameter \&#39;return&#x3D;FULL\&#39;. (optional)
     * @return GTVAPIServiceUsageRule
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper createServiceUsageRules(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('serviceId'), 'serviceId');
      client.assertNotNull(
        params.get('createServiceUsageRule'),
        'createServiceUsageRule'
      );
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'POST',
        '/services/{service_id}/recurring-price/usage-rules',
        (RestAPI2Domain.GTVAPICreateServiceUsageRule) params.get(
          'createServiceUsageRule'
        ),
        query,
        form,
        new Map<String, Object>{
          'service_id' => (String) params.get('serviceId')
        },
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIServiceUsageRule.class
      );
    }
    /**
     * Deactivate service
     * Deactivates an existing service associated with the specified ID.
     * @param id The internal ID of the object. (required)
     * @param deactivateService The payload for deactivating a service. (required)
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public void deactivateService(Map<String, Object> params) {
      client.assertNotNull(params.get('id'), 'id');
      client.assertNotNull(
        params.get('deactivateService'),
        'deactivateService'
      );
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      client.invoke(
        'POST',
        '/services/{id}/deactivate',
        (RestAPI2Domain.GTVAPIDeactivateService) params.get(
          'deactivateService'
        ),
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        null
      );
    }
    /**
     * Get agreement service
     * Retrieves the current agreement for the existing service by service ID.
     * @param serviceId The ID of the service. (required)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @return GTVAPIAgreementService
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper getCurrentAgreementService(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('serviceId'), 'serviceId');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('return', (String) params.get('r_return')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/services/{service_id}/agreement-service',
        '',
        query,
        form,
        new Map<String, Object>{
          'service_id' => (String) params.get('serviceId')
        },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIAgreementService.class
      );
    }
    /**
     * Get currently active recurring price for this service.
     * Retrieves currently active recurring price associated with the specified service ID.
     * @param serviceId The ID of the service. (required)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @return GTVAPIServicePrice
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper getCurrentRecurringPrice(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('serviceId'), 'serviceId');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('return', (String) params.get('r_return')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/services/{service_id}/recurring-price',
        '',
        query,
        form,
        new Map<String, Object>{
          'service_id' => (String) params.get('serviceId')
        },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIServicePrice.class
      );
    }
    /**
     * Get range (tier) for the currently active recurring price for this service by ID
     * Gets the range (tier) for the existing currently active recurring price associated with the specified service ID.
     * @param serviceId The ID of the service. (required)
     * @param id The internal ID of the object. (required)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @return GTVAPIServicePriceRange
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper getCurrentRecurringPriceRange(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('serviceId'), 'serviceId');
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('return', (String) params.get('r_return')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/services/{service_id}/recurring-price/ranges/{id}',
        '',
        query,
        form,
        new Map<String, Object>{
          'service_id' => (String) params.get('serviceId'),
          'id' => (String) params.get('id')
        },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIServicePriceRange.class
      );
    }
    /**
     * Get association between discount resource and service by ID
     * Retrieves existing association between discount resource and service by the specified service and discount resource relation IDs.
     * @param serviceId The ID of the service. (required)
     * @param id The internal ID of the object. (required)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @param expand Includes additional entities in the response. You can expand only those entities which have a specific extension for it. The primary value is a CSV of the available sub-entities. (optional)
     * @return GTVAPIDiscountCodeService
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper getDiscountCodeService(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('serviceId'), 'serviceId');
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('return', (String) params.get('r_return')));
      query.addAll(
        client.makeParam('expand', (List<String>) params.get('expand'), 'csv')
      );

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/services/{service_id}/discount-code-services/{id}',
        '',
        query,
        form,
        new Map<String, Object>{
          'service_id' => (String) params.get('serviceId'),
          'id' => (String) params.get('id')
        },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIDiscountCodeService.class
      );
    }
    /**
     * Get quantity change by ID
     * Retrieves an existing quantity change associated with the specified service and quantity change IDs.
     * @param serviceId The ID of the service. (required)
     * @param id The internal ID of the object. (required)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @return GTVAPIQuantityChange
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper getQuantityChangeByService(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('serviceId'), 'serviceId');
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('return', (String) params.get('r_return')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/services/{service_id}/quantity-changes/{id}',
        '',
        query,
        form,
        new Map<String, Object>{
          'service_id' => (String) params.get('serviceId'),
          'id' => (String) params.get('id')
        },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIQuantityChange.class
      );
    }
    /**
     * Get service by ID
     * Retrieves an existing service associated with the specified ID.
     * @param id The internal ID of the object. (required)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @param expand Includes additional entities in the response. You can expand only those entities which have a specific extension for it. The primary value is a CSV of the available sub-entities. (optional)
     * @return GTVAPIService
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper getService(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('return', (String) params.get('r_return')));
      query.addAll(
        client.makeParam('expand', (List<String>) params.get('expand'), 'csv')
      );

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/services/{id}',
        '',
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIService.class
      );
    }
    /**
     * Get address by ID
     * Retrieves an address of a service that exists in the system by the associated service and address IDs.
     * @param serviceId The ID of the service. (required)
     * @param id The internal ID of the object. (required)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @return GTVAPIPostalAddress
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper getServiceAddress(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('serviceId'), 'serviceId');
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('return', (String) params.get('r_return')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/services/{service_id}/addresses/{id}',
        '',
        query,
        form,
        new Map<String, Object>{
          'service_id' => (String) params.get('serviceId'),
          'id' => (String) params.get('id')
        },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIPostalAddress.class
      );
    }
    /**
     * Get custom field value for service by ID
     * Retrieves an existing custom field value associated with the specified service and custom field value IDs.
     * @param serviceId The ID of the service. (required)
     * @param id The internal ID of the object. (required)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @return GTVAPIServiceCustomFieldValue
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper getServiceCustomFieldValue(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('serviceId'), 'serviceId');
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('return', (String) params.get('r_return')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/services/{service_id}/custom-field-values/{id}',
        '',
        query,
        form,
        new Map<String, Object>{
          'service_id' => (String) params.get('serviceId'),
          'id' => (String) params.get('id')
        },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIServiceCustomFieldValue.class
      );
    }
    /**
     * Get service period by ID
     * Retrieves the service period by the specified service and service period IDs.
     * @param serviceId The ID of the service. (required)
     * @param id The internal ID of the object. (required)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @return GTVAPIServicePeriod
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper getServicePeriodByService(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('serviceId'), 'serviceId');
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('return', (String) params.get('r_return')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/services/{service_id}/service-periods/{id}',
        '',
        query,
        form,
        new Map<String, Object>{
          'service_id' => (String) params.get('serviceId'),
          'id' => (String) params.get('id')
        },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIServicePeriod.class
      );
    }
    /**
     * Deprecated. Get service price by ID
     * (deprecated) Retrieves an existing service price associated with the specified service and service price IDs. Use recurring-price endpoint.
     * @param serviceId The ID of the service. (required)
     * @param id The internal ID of the object. (required)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @return GTVAPIServicePrice
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper getServicePriceByService(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('serviceId'), 'serviceId');
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('return', (String) params.get('r_return')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/services/{service_id}/prices/{id}',
        '',
        query,
        form,
        new Map<String, Object>{
          'service_id' => (String) params.get('serviceId'),
          'id' => (String) params.get('id')
        },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIServicePrice.class
      );
    }
    /**
     * Deprecated. Get service price range by ID
     * (deprecated) Retrieves an existing service price range associated with the specified service and service price IDs.
     * @param serviceId The ID of the service. (required)
     * @param servicePriceId The ID of the service price. (required)
     * @param id The internal ID of the object. (required)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @return GTVAPIServicePriceRange
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper getServicePriceRangeById(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('serviceId'), 'serviceId');
      client.assertNotNull(params.get('servicePriceId'), 'servicePriceId');
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('return', (String) params.get('r_return')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/services/{service_id}/prices/{service_price_id}/ranges/{id}',
        '',
        query,
        form,
        new Map<String, Object>{
          'service_id' => (String) params.get('serviceId'),
          'service_price_id' => (String) params.get('servicePriceId'),
          'id' => (String) params.get('id')
        },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIServicePriceRange.class
      );
    }
    /**
     * Get service resource by ID
     * Retrieves an existing service resource associated with the specified service and service resource IDs.
     * @param serviceId The ID of the service. (required)
     * @param id The internal ID of the object. (required)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @return GTVAPIServiceResource
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper getServiceResourceByService(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('serviceId'), 'serviceId');
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('return', (String) params.get('r_return')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/services/{service_id}/service-resources/{id}',
        '',
        query,
        form,
        new Map<String, Object>{
          'service_id' => (String) params.get('serviceId'),
          'id' => (String) params.get('id')
        },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIServiceResource.class
      );
    }
    /**
     * Get service usage rule by ID
     * Retrieves an existing service usage rule associated with the specified service and service usage rule IDs.
     * @param serviceId The ID of the service. (required)
     * @param id The internal ID of the object. (required)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @return GTVAPIServiceUsageRule
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper getServiceUsageRuleByService(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('serviceId'), 'serviceId');
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('return', (String) params.get('r_return')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/services/{service_id}/recurring-price/usage-rules/{id}',
        '',
        query,
        form,
        new Map<String, Object>{
          'service_id' => (String) params.get('serviceId'),
          'id' => (String) params.get('id')
        },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIServiceUsageRule.class
      );
    }
    /**
     * Deprecated. Get service usage rule by ID
     * (deprecated) Retrieves an existing service usage rule associated with the specified service and service usage rule IDs.
     * @param serviceId The ID of the service. (required)
     * @param id The internal ID of the object. (required)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @return GTVAPIServiceUsageRule
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper getServiceUsageRuleByService_0(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('serviceId'), 'serviceId');
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('return', (String) params.get('r_return')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/services/{service_id}/usage-rules/{id}',
        '',
        query,
        form,
        new Map<String, Object>{
          'service_id' => (String) params.get('serviceId'),
          'id' => (String) params.get('id')
        },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIServiceUsageRule.class
      );
    }
    /**
     * Get ranges (tiers) for the currently active recurring price for this service
     * Retrieves ranges (tiers) for the existing currently active recurring price associated with the specified service ID.
     * @param serviceId The ID of the service. (required)
     * @param id The internal ID of the object. (optional)
     * @return List<GTVAPIServicePriceRange>
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper queryCurrentRecurringPriceRanges(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('serviceId'), 'serviceId');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('id', (String) params.get('id')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/services/{service_id}/recurring-price/ranges',
        '',
        query,
        form,
        new Map<String, Object>{
          'service_id' => (String) params.get('serviceId')
        },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        List<RestAPI2Domain.GTVAPIServicePriceRange>.class
      );
    }
    /**
     * Get discount resource relations for service
     * Uses query keys to retrieve discount resource relations associated with the service ID.
     * @param serviceId The ID of the service. (required)
     * @param filter API query language string. The syntax of the API query language is similar to SQL, the criteria are expressed in the form of predicates.\nOn the left side of the equation, there is a name of the available query parameter (for example, billing_account_id). On the right side, there is a constant value in single quotes (\&#39;sample value\&#39;). Brackets are used to group predicates, for example, \&#39;(start_date GT \&#39;1994-01-24T23:33:07+00:00\&#39;)\&#39;. Use the following logical operators: AND - conjunction, OR - disjunction, NOT - negation. Compare operators: NEQ - Not equals, EQ - Equals, LT - Less, LTE - Less or equals, GT - Greater, GTE - Greater or equals, IS NULL - Is null, IS NOT NULL - Is not null, LIKE - Match pattern (LIKE operator is only applicable to parameters of the string type). Wildcard characters: \&#39;%\&#39; - matches any number of characters, including no characters, \&#39;_\&#39; - matches exactly one character.\nHere is the sample query: the account_num GT \&#39;15\&#39; AND (name LIKE \&#39;start of name% end of name\&#39; OR status EQ \&#39;ACTIVE\&#39;).\n (optional)
     * @param r_sort Arranges search results in either ascending or descending order. By default, response results are sorted in the ascending order. To sort results in the descending order, use &quot;-&quot;. For example, the &quot;-name.&quot; value sorts the results in the descending order by name, and &quot;id&quot; sorts results in the ascending order by ID. (optional)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @param expand Includes additional entities in the response. You can expand only those entities which have a specific extension for it. The primary value is a CSV of the available sub-entities. (optional)
     * @param pageNumber The page number for multiple page queries. (optional, default to 1)
     * @param pageSize The page size for multiple page queries. Default maximum is 50. (optional, default to 50)
     * @param id The internal ID of the object. (optional)
     * @param validFrom The date and time from when the resource is valid. (optional)
     * @param validTo The date and time until when the resource is valid. (optional)
     * @param discountResourceIdentifier A resource of the discount. (optional)
     * @param discountResourceId The resource ID of the discount. (optional)
     * @param discountCodeId The ID of the discount code. (optional)
     * @param discountType The type of the discount. (optional, default to FLAT)
     * @return List<GTVAPIDiscountCodeService>
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper queryDiscountCodeServices(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('serviceId'), 'serviceId');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('filter', (String) params.get('filter')));
      query.addAll(
        client.makeParam('sort', (List<String>) params.get('r_sort'), 'csv')
      );
      query.addAll(client.makeParam('return', (String) params.get('r_return')));
      query.addAll(
        client.makeParam('expand', (List<String>) params.get('expand'), 'csv')
      );
      query.addAll(
        client.makeParam('page_number', (Integer) params.get('pageNumber'))
      );
      query.addAll(
        client.makeParam('page_size', (Integer) params.get('pageSize'))
      );
      query.addAll(client.makeParam('id', (String) params.get('id')));
      query.addAll(
        client.makeParam('valid_from', (Datetime) params.get('validFrom'))
      );
      query.addAll(
        client.makeParam('valid_to', (Datetime) params.get('validTo'))
      );
      query.addAll(
        client.makeParam(
          'discount_resource_identifier',
          (String) params.get('discountResourceIdentifier')
        )
      );
      query.addAll(
        client.makeParam(
          'discount_resource_id',
          (String) params.get('discountResourceId')
        )
      );
      query.addAll(
        client.makeParam(
          'discount_code_id',
          (String) params.get('discountCodeId')
        )
      );
      query.addAll(
        client.makeParam('discount_type', (String) params.get('discountType'))
      );

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/services/{service_id}/discount-code-services',
        '',
        query,
        form,
        new Map<String, Object>{
          'service_id' => (String) params.get('serviceId')
        },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        List<RestAPI2Domain.GTVAPIDiscountCodeService>.class
      );
    }

    /**
     * Get service address
     * Retrieves the address associated with the service with the specified ID.
     * @param serviceId The ID of the service. (required)
     * @param filter API query language string. The syntax of the API query language is similar to SQL, the criteria are expressed in the form of predicates.\nOn the left side of the equation, there is a name of the available query parameter (for example, billing_account_id). On the right side, there is a constant value in single quotes (\&#39;sample value\&#39;). Brackets are used to group predicates, for example, \&#39;(start_date GT \&#39;1994-01-24T23:33:07+00:00\&#39;)\&#39;. Use the following logical operators: AND - conjunction, OR - disjunction, NOT - negation. Compare operators: NEQ - Not equals, EQ - Equals, LT - Less, LTE - Less or equals, GT - Greater, GTE - Greater or equals, IS NULL - Is null, IS NOT NULL - Is not null, LIKE - Match pattern (LIKE operator is only applicable to parameters of the string type). Wildcard characters: \&#39;%\&#39; - matches any number of characters, including no characters, \&#39;_\&#39; - matches exactly one character.\nHere is the sample query: the account_num GT \&#39;15\&#39; AND (name LIKE \&#39;start of name% end of name\&#39; OR status EQ \&#39;ACTIVE\&#39;).\n (optional)
     * @param r_sort Arranges search results in either ascending or descending order. By default, response results are sorted in the ascending order. To sort results in the descending order, use &quot;-&quot;. For example, the &quot;-name.&quot; value sorts the results in the descending order by name, and &quot;id&quot; sorts results in the ascending order by ID. (optional)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @param pageNumber The page number for multiple page queries. (optional, default to 1)
     * @param pageSize The page size for multiple page queries. Default maximum is 50. (optional, default to 50)
     * @param id The internal ID of the object. (optional)
     * @return List<GTVAPIPostalAddress>
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper queryServiceAddresses(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('serviceId'), 'serviceId');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('filter', (String) params.get('filter')));
      query.addAll(
        client.makeParam('sort', (List<String>) params.get('r_sort'), 'csv')
      );
      query.addAll(client.makeParam('return', (String) params.get('r_return')));
      query.addAll(
        client.makeParam('page_number', (Integer) params.get('pageNumber'))
      );
      query.addAll(
        client.makeParam('page_size', (Integer) params.get('pageSize'))
      );
      query.addAll(client.makeParam('id', (String) params.get('id')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/services/{service_id}/addresses',
        '',
        query,
        form,
        new Map<String, Object>{
          'service_id' => (String) params.get('serviceId')
        },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        List<RestAPI2Domain.GTVAPIPostalAddress>.class
      );
    }
    /**
     * Get custom field values for service
     * Retrieves custom field values for existing custom fields associated with the specified service ID.
     * @param serviceId The ID of the service. (required)
     * @param filter API query language string. The syntax of the API query language is similar to SQL, the criteria are expressed in the form of predicates.\nOn the left side of the equation, there is a name of the available query parameter (for example, billing_account_id). On the right side, there is a constant value in single quotes (\&#39;sample value\&#39;). Brackets are used to group predicates, for example, \&#39;(start_date GT \&#39;1994-01-24T23:33:07+00:00\&#39;)\&#39;. Use the following logical operators: AND - conjunction, OR - disjunction, NOT - negation. Compare operators: NEQ - Not equals, EQ - Equals, LT - Less, LTE - Less or equals, GT - Greater, GTE - Greater or equals, IS NULL - Is null, IS NOT NULL - Is not null, LIKE - Match pattern (LIKE operator is only applicable to parameters of the string type). Wildcard characters: \&#39;%\&#39; - matches any number of characters, including no characters, \&#39;_\&#39; - matches exactly one character.\nHere is the sample query: the account_num GT \&#39;15\&#39; AND (name LIKE \&#39;start of name% end of name\&#39; OR status EQ \&#39;ACTIVE\&#39;).\n (optional)
     * @param r_sort Arranges search results in either ascending or descending order. By default, response results are sorted in the ascending order. To sort results in the descending order, use &quot;-&quot;. For example, the &quot;-name.&quot; value sorts the results in the descending order by name, and &quot;id&quot; sorts results in the ascending order by ID. (optional)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @param pageNumber The page number for multiple page queries. (optional, default to 1)
     * @param pageSize The page size for multiple page queries. Default maximum is 50. (optional, default to 50)
     * @param id The internal ID of the object. (optional)
     * @param customFieldValue A custom field value. (optional)
     * @param customFieldName The name of the custom field. (optional)
     * @param customFieldId The ID of the custom field. (optional)
     * @return List<GTVAPIServiceCustomFieldValue>
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper queryServiceCustomFieldValues(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('serviceId'), 'serviceId');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('filter', (String) params.get('filter')));
      query.addAll(
        client.makeParam('sort', (List<String>) params.get('r_sort'), 'csv')
      );
      query.addAll(client.makeParam('return', (String) params.get('r_return')));
      query.addAll(
        client.makeParam('page_number', (Integer) params.get('pageNumber'))
      );
      query.addAll(
        client.makeParam('page_size', (Integer) params.get('pageSize'))
      );
      query.addAll(client.makeParam('id', (String) params.get('id')));
      query.addAll(
        client.makeParam(
          'custom_field_value',
          (String) params.get('customFieldValue')
        )
      );
      query.addAll(
        client.makeParam(
          'custom_field_name',
          (String) params.get('customFieldName')
        )
      );
      query.addAll(
        client.makeParam(
          'custom_field_id',
          (String) params.get('customFieldId')
        )
      );

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/services/{service_id}/custom-field-values',
        '',
        query,
        form,
        new Map<String, Object>{
          'service_id' => (String) params.get('serviceId')
        },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        List<RestAPI2Domain.GTVAPIServiceCustomFieldValue>.class
      );
    }
    /**
     * Get service periods
     * Uses query keys to retrieve a subset of existing service periods.
     * @param serviceId The ID of the service. (required)
     * @param filter API query language string. The syntax of the API query language is similar to SQL, the criteria are expressed in the form of predicates.\nOn the left side of the equation, there is a name of the available query parameter (for example, billing_account_id). On the right side, there is a constant value in single quotes (\&#39;sample value\&#39;). Brackets are used to group predicates, for example, \&#39;(start_date GT \&#39;1994-01-24T23:33:07+00:00\&#39;)\&#39;. Use the following logical operators: AND - conjunction, OR - disjunction, NOT - negation. Compare operators: NEQ - Not equals, EQ - Equals, LT - Less, LTE - Less or equals, GT - Greater, GTE - Greater or equals, IS NULL - Is null, IS NOT NULL - Is not null, LIKE - Match pattern (LIKE operator is only applicable to parameters of the string type). Wildcard characters: \&#39;%\&#39; - matches any number of characters, including no characters, \&#39;_\&#39; - matches exactly one character.\nHere is the sample query: the account_num GT \&#39;15\&#39; AND (name LIKE \&#39;start of name% end of name\&#39; OR status EQ \&#39;ACTIVE\&#39;).\n (optional)
     * @param r_sort Arranges search results in either ascending or descending order. By default, response results are sorted in the ascending order. To sort results in the descending order, use &quot;-&quot;. For example, the &quot;-name.&quot; value sorts the results in the descending order by name, and &quot;id&quot; sorts results in the ascending order by ID. (optional)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @param pageNumber The page number for multiple page queries. (optional, default to 1)
     * @param pageSize The page size for multiple page queries. Default maximum is 50. (optional, default to 50)
     * @param id The internal ID of the object. (optional)
     * @param startDate The date and time when the service period started. (optional)
     * @param endDate The date and time when the service period ended. (optional)
     * @param closed Specifies whether the service period is closed. (optional)
     * @return List<GTVAPIServicePeriod>
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper queryServicePeriodsByService(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('serviceId'), 'serviceId');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('filter', (String) params.get('filter')));
      query.addAll(
        client.makeParam('sort', (List<String>) params.get('r_sort'), 'csv')
      );
      query.addAll(client.makeParam('return', (String) params.get('r_return')));
      query.addAll(
        client.makeParam('page_number', (Integer) params.get('pageNumber'))
      );
      query.addAll(
        client.makeParam('page_size', (Integer) params.get('pageSize'))
      );
      query.addAll(client.makeParam('id', (String) params.get('id')));
      query.addAll(
        client.makeParam('start_date', (Datetime) params.get('startDate'))
      );
      query.addAll(
        client.makeParam('end_date', (Datetime) params.get('endDate'))
      );
      query.addAll(client.makeParam('closed', (Boolean) params.get('closed')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/services/{service_id}/service-periods',
        '',
        query,
        form,
        new Map<String, Object>{
          'service_id' => (String) params.get('serviceId')
        },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        List<RestAPI2Domain.GTVAPIServicePeriod>.class
      );
    }
    /**
     * Deprecated. Get service prices
     * (deprecated) Uses query keys to return a subset of existing service prices associated with the specified service ID. Use recurring-price endpoint.
     * @param serviceId The ID of the service. (required)
     * @param filter API query language string. The syntax of the API query language is similar to SQL, the criteria are expressed in the form of predicates.\nOn the left side of the equation, there is a name of the available query parameter (for example, billing_account_id). On the right side, there is a constant value in single quotes (\&#39;sample value\&#39;). Brackets are used to group predicates, for example, \&#39;(start_date GT \&#39;1994-01-24T23:33:07+00:00\&#39;)\&#39;. Use the following logical operators: AND - conjunction, OR - disjunction, NOT - negation. Compare operators: NEQ - Not equals, EQ - Equals, LT - Less, LTE - Less or equals, GT - Greater, GTE - Greater or equals, IS NULL - Is null, IS NOT NULL - Is not null, LIKE - Match pattern (LIKE operator is only applicable to parameters of the string type). Wildcard characters: \&#39;%\&#39; - matches any number of characters, including no characters, \&#39;_\&#39; - matches exactly one character.\nHere is the sample query: the account_num GT \&#39;15\&#39; AND (name LIKE \&#39;start of name% end of name\&#39; OR status EQ \&#39;ACTIVE\&#39;).\n (optional)
     * @param r_sort Arranges search results in either ascending or descending order. By default, response results are sorted in the ascending order. To sort results in the descending order, use &quot;-&quot;. For example, the &quot;-name.&quot; value sorts the results in the descending order by name, and &quot;id&quot; sorts results in the ascending order by ID. (optional)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @param pageNumber The page number for multiple page queries. (optional, default to 1)
     * @param pageSize The page size for multiple page queries. Default maximum is 50. (optional, default to 50)
     * @param id The internal ID of the object. (optional)
     * @param validFrom The date and time from when the resource is valid. (optional)
     * @param validTo The date and time until when the resource is valid. (optional)
     * @param recurrencePeriod The recurring product price for the recurrence period. (optional)
     * @param productPriceId The ID of the product price for the product. (optional)
     * @return List<GTVAPIServicePrice>
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper queryServicePricesByService(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('serviceId'), 'serviceId');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('filter', (String) params.get('filter')));
      query.addAll(
        client.makeParam('sort', (List<String>) params.get('r_sort'), 'csv')
      );
      query.addAll(client.makeParam('return', (String) params.get('r_return')));
      query.addAll(
        client.makeParam('page_number', (Integer) params.get('pageNumber'))
      );
      query.addAll(
        client.makeParam('page_size', (Integer) params.get('pageSize'))
      );
      query.addAll(client.makeParam('id', (String) params.get('id')));
      query.addAll(
        client.makeParam('valid_from', (Datetime) params.get('validFrom'))
      );
      query.addAll(
        client.makeParam('valid_to', (Datetime) params.get('validTo'))
      );
      query.addAll(
        client.makeParam(
          'recurrence_period',
          (String) params.get('recurrencePeriod')
        )
      );
      query.addAll(
        client.makeParam(
          'product_price_id',
          (String) params.get('productPriceId')
        )
      );

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/services/{service_id}/prices',
        '',
        query,
        form,
        new Map<String, Object>{
          'service_id' => (String) params.get('serviceId')
        },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        List<RestAPI2Domain.GTVAPIServicePrice>.class
      );
    }
    /**
     * Deprecated. Get service price ranges (tiers)
     * (deprecated) Uses query keys to return a subset of existing service price ranges (tiers) associated with the specified service and price IDs.
     * @param serviceId The ID of the service. (required)
     * @param servicePriceId The ID of the service price. (required)
     * @param filter API query language string. The syntax of the API query language is similar to SQL, the criteria are expressed in the form of predicates.\nOn the left side of the equation, there is a name of the available query parameter (for example, billing_account_id). On the right side, there is a constant value in single quotes (\&#39;sample value\&#39;). Brackets are used to group predicates, for example, \&#39;(start_date GT \&#39;1994-01-24T23:33:07+00:00\&#39;)\&#39;. Use the following logical operators: AND - conjunction, OR - disjunction, NOT - negation. Compare operators: NEQ - Not equals, EQ - Equals, LT - Less, LTE - Less or equals, GT - Greater, GTE - Greater or equals, IS NULL - Is null, IS NOT NULL - Is not null, LIKE - Match pattern (LIKE operator is only applicable to parameters of the string type). Wildcard characters: \&#39;%\&#39; - matches any number of characters, including no characters, \&#39;_\&#39; - matches exactly one character.\nHere is the sample query: the account_num GT \&#39;15\&#39; AND (name LIKE \&#39;start of name% end of name\&#39; OR status EQ \&#39;ACTIVE\&#39;).\n (optional)
     * @param r_sort Arranges search results in either ascending or descending order. By default, response results are sorted in the ascending order. To sort results in the descending order, use &quot;-&quot;. For example, the &quot;-name.&quot; value sorts the results in the descending order by name, and &quot;id&quot; sorts results in the ascending order by ID. (optional)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @param pageNumber The page number for multiple page queries. (optional, default to 1)
     * @param pageSize The page size for multiple page queries. Default maximum is 50. (optional, default to 50)
     * @param id The internal ID of the object. (optional)
     * @return List<GTVAPIServicePriceRange>
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper queryServicePricesRanges(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('serviceId'), 'serviceId');
      client.assertNotNull(params.get('servicePriceId'), 'servicePriceId');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('filter', (String) params.get('filter')));
      query.addAll(
        client.makeParam('sort', (List<String>) params.get('r_sort'), 'csv')
      );
      query.addAll(client.makeParam('return', (String) params.get('r_return')));
      query.addAll(
        client.makeParam('page_number', (Integer) params.get('pageNumber'))
      );
      query.addAll(
        client.makeParam('page_size', (Integer) params.get('pageSize'))
      );
      query.addAll(client.makeParam('id', (String) params.get('id')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/services/{service_id}/prices/{service_price_id}/ranges',
        '',
        query,
        form,
        new Map<String, Object>{
          'service_id' => (String) params.get('serviceId'),
          'service_price_id' => (String) params.get('servicePriceId')
        },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        List<RestAPI2Domain.GTVAPIServicePriceRange>.class
      );
    }
    /**
     * Get service resources
     * Retrieves existing service resources associated with the specified service.
     * @param serviceId The ID of the service. (required)
     * @param filter API query language string. The syntax of the API query language is similar to SQL, the criteria are expressed in the form of predicates.\nOn the left side of the equation, there is a name of the available query parameter (for example, billing_account_id). On the right side, there is a constant value in single quotes (\&#39;sample value\&#39;). Brackets are used to group predicates, for example, \&#39;(start_date GT \&#39;1994-01-24T23:33:07+00:00\&#39;)\&#39;. Use the following logical operators: AND - conjunction, OR - disjunction, NOT - negation. Compare operators: NEQ - Not equals, EQ - Equals, LT - Less, LTE - Less or equals, GT - Greater, GTE - Greater or equals, IS NULL - Is null, IS NOT NULL - Is not null, LIKE - Match pattern (LIKE operator is only applicable to parameters of the string type). Wildcard characters: \&#39;%\&#39; - matches any number of characters, including no characters, \&#39;_\&#39; - matches exactly one character.\nHere is the sample query: the account_num GT \&#39;15\&#39; AND (name LIKE \&#39;start of name% end of name\&#39; OR status EQ \&#39;ACTIVE\&#39;).\n (optional)
     * @param r_sort Arranges search results in either ascending or descending order. By default, response results are sorted in the ascending order. To sort results in the descending order, use &quot;-&quot;. For example, the &quot;-name.&quot; value sorts the results in the descending order by name, and &quot;id&quot; sorts results in the ascending order by ID. (optional)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @param pageNumber The page number for multiple page queries. (optional, default to 1)
     * @param pageSize The page size for multiple page queries. Default maximum is 50. (optional, default to 50)
     * @param id The internal ID of the object. (optional)
     * @param identifier The identifier of the service or discount resource. (optional)
     * @param resourceCategoryId The ID of the service resource category. (optional)
     * @param orderItemId The ID of the order item entity. (optional)
     * @param status The status of the service resource category. (optional)
     * @param description The description of the service resource category. (optional)
     * @return List<GTVAPIServiceResource>
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper queryServiceResourcesByService(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('serviceId'), 'serviceId');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('filter', (String) params.get('filter')));
      query.addAll(
        client.makeParam('sort', (List<String>) params.get('r_sort'), 'csv')
      );
      query.addAll(client.makeParam('return', (String) params.get('r_return')));
      query.addAll(
        client.makeParam('page_number', (Integer) params.get('pageNumber'))
      );
      query.addAll(
        client.makeParam('page_size', (Integer) params.get('pageSize'))
      );
      query.addAll(client.makeParam('id', (String) params.get('id')));
      query.addAll(
        client.makeParam('identifier', (String) params.get('identifier'))
      );
      query.addAll(
        client.makeParam(
          'resource_category_id',
          (String) params.get('resourceCategoryId')
        )
      );
      query.addAll(
        client.makeParam('order_item_id', (String) params.get('orderItemId'))
      );
      query.addAll(client.makeParam('status', (String) params.get('status')));
      query.addAll(
        client.makeParam('description', (String) params.get('description'))
      );

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/services/{service_id}/service-resources',
        '',
        query,
        form,
        new Map<String, Object>{
          'service_id' => (String) params.get('serviceId')
        },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        List<RestAPI2Domain.GTVAPIServiceResource>.class
      );
    }
    /**
     * Get service usage rules
     * Retrieves existing usage rules associated with the specified service ID.
     * @param serviceId The ID of the service. (required)
     * @param filter API query language string. The syntax of the API query language is similar to SQL, the criteria are expressed in the form of predicates.\nOn the left side of the equation, there is a name of the available query parameter (for example, billing_account_id). On the right side, there is a constant value in single quotes (\&#39;sample value\&#39;). Brackets are used to group predicates, for example, \&#39;(start_date GT \&#39;1994-01-24T23:33:07+00:00\&#39;)\&#39;. Use the following logical operators: AND - conjunction, OR - disjunction, NOT - negation. Compare operators: NEQ - Not equals, EQ - Equals, LT - Less, LTE - Less or equals, GT - Greater, GTE - Greater or equals, IS NULL - Is null, IS NOT NULL - Is not null, LIKE - Match pattern (LIKE operator is only applicable to parameters of the string type). Wildcard characters: \&#39;%\&#39; - matches any number of characters, including no characters, \&#39;_\&#39; - matches exactly one character.\nHere is the sample query: the account_num GT \&#39;15\&#39; AND (name LIKE \&#39;start of name% end of name\&#39; OR status EQ \&#39;ACTIVE\&#39;).\n (optional)
     * @param r_sort Arranges search results in either ascending or descending order. By default, response results are sorted in the ascending order. To sort results in the descending order, use &quot;-&quot;. For example, the &quot;-name.&quot; value sorts the results in the descending order by name, and &quot;id&quot; sorts results in the ascending order by ID. (optional)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @param pageNumber The page number for multiple page queries. (optional, default to 1)
     * @param pageSize The page size for multiple page queries. Default maximum is 50. (optional, default to 50)
     * @param id The internal ID of the object. (optional)
     * @param status The status of the service usage rule. (optional)
     * @return List<GTVAPIServiceUsageRule>
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper queryServiceUsageRulesByService(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('serviceId'), 'serviceId');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('filter', (String) params.get('filter')));
      query.addAll(
        client.makeParam('sort', (List<String>) params.get('r_sort'), 'csv')
      );
      query.addAll(client.makeParam('return', (String) params.get('r_return')));
      query.addAll(
        client.makeParam('page_number', (Integer) params.get('pageNumber'))
      );
      query.addAll(
        client.makeParam('page_size', (Integer) params.get('pageSize'))
      );
      query.addAll(client.makeParam('id', (String) params.get('id')));
      query.addAll(client.makeParam('status', (String) params.get('status')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/services/{service_id}/recurring-price/usage-rules',
        '',
        query,
        form,
        new Map<String, Object>{
          'service_id' => (String) params.get('serviceId')
        },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        List<RestAPI2Domain.GTVAPIServiceUsageRule>.class
      );
    }
    /**
     * Get services
     * Uses query keys to retrieve a subset of existing services.
     * @param filter API query language string. The syntax of the API query language is similar to SQL, the criteria are expressed in the form of predicates.\nOn the left side of the equation, there is a name of the available query parameter (for example, billing_account_id). On the right side, there is a constant value in single quotes (\&#39;sample value\&#39;). Brackets are used to group predicates, for example, \&#39;(start_date GT \&#39;1994-01-24T23:33:07+00:00\&#39;)\&#39;. Use the following logical operators: AND - conjunction, OR - disjunction, NOT - negation. Compare operators: NEQ - Not equals, EQ - Equals, LT - Less, LTE - Less or equals, GT - Greater, GTE - Greater or equals, IS NULL - Is null, IS NOT NULL - Is not null, LIKE - Match pattern (LIKE operator is only applicable to parameters of the string type). Wildcard characters: \&#39;%\&#39; - matches any number of characters, including no characters, \&#39;_\&#39; - matches exactly one character.\nHere is the sample query: the account_num GT \&#39;15\&#39; AND (name LIKE \&#39;start of name% end of name\&#39; OR status EQ \&#39;ACTIVE\&#39;).\n (optional)
     * @param r_sort Arranges search results in either ascending or descending order. By default, response results are sorted in the ascending order. To sort results in the descending order, use &quot;-&quot;. For example, the &quot;-name.&quot; value sorts the results in the descending order by name, and &quot;id&quot; sorts results in the ascending order by ID. (optional)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @param expand Includes additional entities in the response. You can expand only those entities which have a specific extension for it. The primary value is a CSV of the available sub-entities. (optional)
     * @param pageNumber The page number for multiple page queries. (optional, default to 1)
     * @param pageSize The page size for multiple page queries. Default maximum is 50. (optional, default to 50)
     * @param id The internal ID of the object. (optional)
     * @param invoiceItemId The ID of the invoice item. (optional)
     * @param status The status of the service. (optional)
     * @param startDate The date when the service started. (optional)
     * @param endDate The date when the service ended if the service is not currently ongoing. (optional)
     * @param parentId The ID of the parent service. (optional)
     * @param previousServiceId The ID of the previous service. (optional)
     * @param nextServiceId The ID of the next service. (optional)
     * @param originalOrderId The order ID of the order that created the service. (optional)
     * @param originalOrderNum The order number of the order that created the service. (optional)
     * @param originalOrderItemSequence The sequence number of the order item in a service. (optional)
     * @param renewalCount The renewal count for the renewed service. (optional)
     * @param billingAccountId The ID of the billing account. (optional)
     * @param accountNum The billing account number. (optional)
     * @param externalAccountNum The account number tied to an external system. (optional)
     * @param productId The ID of the product. (optional)
     * @param agreementId The ID of the agreement. (optional)
     * @param serviceResourceIdentifier The identifier of the service resource. (optional)
     * @param usagePoolId The ID of this usage pool. (optional)
     * @param customFieldId The ID of the custom field. (optional)
     * @param customFieldValue A custom field value. (optional)
     * @param customFieldValueId The ID of the custom field value. (optional)
     * @return List<GTVAPIService>
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper queryServices(
      Map<String, Object> params
    ) {
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('filter', (String) params.get('filter')));
      query.addAll(
        client.makeParam('sort', (List<String>) params.get('r_sort'), 'csv')
      );
      query.addAll(client.makeParam('return', (String) params.get('r_return')));
      query.addAll(
        client.makeParam('expand', (List<String>) params.get('expand'), 'csv')
      );
      query.addAll(
        client.makeParam('page_number', (Integer) params.get('pageNumber'))
      );
      query.addAll(
        client.makeParam('page_size', (Integer) params.get('pageSize'))
      );
      query.addAll(client.makeParam('id', (String) params.get('id')));
      query.addAll(
        client.makeParam(
          'invoice_item_id',
          (String) params.get('invoiceItemId')
        )
      );
      query.addAll(client.makeParam('status', (String) params.get('status')));
      query.addAll(
        client.makeParam('start_date', (Datetime) params.get('startDate'))
      );
      query.addAll(
        client.makeParam('end_date', (Datetime) params.get('endDate'))
      );
      query.addAll(
        client.makeParam('parent_id', (String) params.get('parentId'))
      );
      query.addAll(
        client.makeParam(
          'previous_service_id',
          (String) params.get('previousServiceId')
        )
      );
      query.addAll(
        client.makeParam(
          'next_service_id',
          (String) params.get('nextServiceId')
        )
      );
      query.addAll(
        client.makeParam(
          'original_order_id',
          (String) params.get('originalOrderId')
        )
      );
      query.addAll(
        client.makeParam(
          'original_order_num',
          (String) params.get('originalOrderNum')
        )
      );
      query.addAll(
        client.makeParam(
          'original_order_item_sequence',
          (Long) params.get('originalOrderItemSequence')
        )
      );
      query.addAll(
        client.makeParam('renewal_count', (Integer) params.get('renewalCount'))
      );
      query.addAll(
        client.makeParam(
          'billing_account_id',
          (String) params.get('billingAccountId')
        )
      );
      query.addAll(
        client.makeParam('account_num', (String) params.get('accountNum'))
      );
      query.addAll(
        client.makeParam(
          'external_account_num',
          (String) params.get('externalAccountNum')
        )
      );
      query.addAll(
        client.makeParam('product_id', (String) params.get('productId'))
      );
      query.addAll(
        client.makeParam('agreement_id', (String) params.get('agreementId'))
      );
      query.addAll(
        client.makeParam(
          'service_resource_identifier',
          (String) params.get('serviceResourceIdentifier')
        )
      );
      query.addAll(
        client.makeParam('usage_pool_id', (String) params.get('usagePoolId'))
      );
      query.addAll(
        client.makeParam(
          'custom_field_id',
          (String) params.get('customFieldId')
        )
      );
      query.addAll(
        client.makeParam(
          'custom_field_value',
          (String) params.get('customFieldValue')
        )
      );
      query.addAll(
        client.makeParam(
          'custom_field_value_id',
          (String) params.get('customFieldValueId')
        )
      );

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/services',
        '',
        query,
        form,
        new Map<String, Object>(),
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        List<RestAPI2Domain.GTVAPISFService>.class
      );
    }
    /**
     * Remove association between discount resource and service
     * Removes the association between discount resource and service by the associated service and discount resource relation IDs.
     * @param serviceId The ID of the service. (required)
     * @param id The internal ID of the object. (required)
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public void removeDiscountCodeService(Map<String, Object> params) {
      client.assertNotNull(params.get('serviceId'), 'serviceId');
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      client.invoke(
        'DELETE',
        '/services/{service_id}/discount-code-services/{id}',
        '',
        query,
        form,
        new Map<String, Object>{
          'service_id' => (String) params.get('serviceId'),
          'id' => (String) params.get('id')
        },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        null
      );
    }
    /**
     * Delete quantity change
     * Deletes the last existing quantity change by the associated service ID.
     * @param serviceId The ID of the service. (required)
     * @param id The internal ID of the object. (required)
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public void removeQuantityChange(Map<String, Object> params) {
      client.assertNotNull(params.get('serviceId'), 'serviceId');
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      client.invoke(
        'DELETE',
        '/services/{service_id}/quantity-changes/{id}',
        '',
        query,
        form,
        new Map<String, Object>{
          'service_id' => (String) params.get('serviceId'),
          'id' => (String) params.get('id')
        },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        null
      );
    }
    /**
     * Delete address for service
     * Removes an existing address associated with the specified service and address IDs.
     * @param serviceId The ID of the service. (required)
     * @param id The internal ID of the object. (required)
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public void removeServiceAddress(Map<String, Object> params) {
      client.assertNotNull(params.get('serviceId'), 'serviceId');
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      client.invoke(
        'DELETE',
        '/services/{service_id}/addresses/{id}',
        '',
        query,
        form,
        new Map<String, Object>{
          'service_id' => (String) params.get('serviceId'),
          'id' => (String) params.get('id')
        },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        null
      );
    }
    /**
     * Delete custom field value for service
     * Removes an existing custom field value associated with the specified service and custom field value IDs.
     * @param serviceId The ID of the service. (required)
     * @param id The internal ID of the object. (required)
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public void removeServiceCustomFieldValue(Map<String, Object> params) {
      client.assertNotNull(params.get('serviceId'), 'serviceId');
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      client.invoke(
        'DELETE',
        '/services/{service_id}/custom-field-values/{id}',
        '',
        query,
        form,
        new Map<String, Object>{
          'service_id' => (String) params.get('serviceId'),
          'id' => (String) params.get('id')
        },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        null
      );
    }
    /**
     * Delete service resource
     * Removes an existing service resource associated with the specified service and service resource IDs.
     * @param serviceId The ID of the service. (required)
     * @param id The internal ID of the object. (required)
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public void removeServiceResourceByService(Map<String, Object> params) {
      client.assertNotNull(params.get('serviceId'), 'serviceId');
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      client.invoke(
        'DELETE',
        '/services/{service_id}/service-resources/{id}',
        '',
        query,
        form,
        new Map<String, Object>{
          'service_id' => (String) params.get('serviceId'),
          'id' => (String) params.get('id')
        },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        null
      );
    }
    /**
     * Delete service usage rule
     * Deletes the existing service usage rule by the associated service and usage rule IDs.
     * @param serviceId The ID of the service. (required)
     * @param id The internal ID of the object. (required)
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public void removeServiceUsageRule(Map<String, Object> params) {
      client.assertNotNull(params.get('serviceId'), 'serviceId');
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      client.invoke(
        'DELETE',
        '/services/{service_id}/recurring-price/usage-rules/{id}',
        '',
        query,
        form,
        new Map<String, Object>{
          'service_id' => (String) params.get('serviceId'),
          'id' => (String) params.get('id')
        },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        null
      );
    }
    /**
     * Replace service resource on specified service
     * Replaces the existing service resource on the service associated with the specified IDs.
     * @param serviceId The ID of the service. (required)
     * @param id The internal ID of the object. (required)
     * @param replaceServiceResource The payload for replacing a service resource. (required)
     * @param prefer The HTTP Prefer header per https://tools.ietf.org/html/rfc7240. The \&#39;return&#x3D;[representation|minimal]\&#39; preferences are the only implemented settings at the moment and are the same as \&#39;return&#x3D;SIMPLE\&#39;, and it indicates that the client wishes the server to return a minimal response to a successful request. The \&#39;return&#x3D;representation\&#39; preference in this header is the same as setting query parameter \&#39;return&#x3D;FULL\&#39;. (optional)
     * @return GTVAPIServiceResource
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper replaceServiceResource(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('serviceId'), 'serviceId');
      client.assertNotNull(params.get('id'), 'id');
      client.assertNotNull(
        params.get('replaceServiceResource'),
        'replaceServiceResource'
      );
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'POST',
        '/services/{service_id}/service-resources/{id}/replace',
        (RestAPI2Domain.GTVAPIAddServiceResource) params.get(
          'replaceServiceResource'
        ),
        query,
        form,
        new Map<String, Object>{
          'service_id' => (String) params.get('serviceId'),
          'id' => (String) params.get('id')
        },
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIServiceResource.class
      );
    }
    /**
     * Resume service
     * Resumes an existing service associated with the specified ID.
     * @param id The internal ID of the object. (required)
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public void resumeService(Map<String, Object> params) {
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      client.invoke(
        'POST',
        '/services/{id}/resume',
        '',
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        null
      );
    }
    /**
     * Suspend service
     * Suspends an existing service associated with the specified ID.
     * @param id The internal ID of the object. (required)
     * @param suspendService The payload for suspending a service. (required)
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public void suspendService(Map<String, Object> params) {
      client.assertNotNull(params.get('id'), 'id');
      client.assertNotNull(params.get('suspendService'), 'suspendService');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      client.invoke(
        'POST',
        '/services/{id}/suspend',
        (RestAPI2Domain.GTVAPISuspendService) params.get('suspendService'),
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        null
      );
    }
    /**
     * Update service
     * Updates an existing service associated with the specified ID.
     * @param id The internal ID of the object. (required)
     * @param updateService The payload for updating the existing service. (required)
     * @param prefer The HTTP Prefer header per https://tools.ietf.org/html/rfc7240. The \&#39;return&#x3D;[representation|minimal]\&#39; preferences are the only implemented settings at the moment and are the same as \&#39;return&#x3D;SIMPLE\&#39;, and it indicates that the client wishes the server to return a minimal response to a successful request. The \&#39;return&#x3D;representation\&#39; preference in this header is the same as setting query parameter \&#39;return&#x3D;FULL\&#39;. (optional)
     * @return GTVAPIService
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper updateService(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('id'), 'id');
      client.assertNotNull(params.get('updateService'), 'updateService');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'PUT',
        '/services/{id}',
        (RestAPI2Domain.GTVAPISFService) params.get('updateService'),
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIService.class
      );
    }
    /**
     * Update custom field value for service
     * Updates the value of an existing custom field associated with the specified service and custom field value IDs.
     * @param serviceId The ID of the service. (required)
     * @param id The internal ID of the object. (required)
     * @param serviceCustomFieldValue A payload for updating the service account custom field value. (required)
     * @param prefer The HTTP Prefer header per https://tools.ietf.org/html/rfc7240. The \&#39;return&#x3D;[representation|minimal]\&#39; preferences are the only implemented settings at the moment and are the same as \&#39;return&#x3D;SIMPLE\&#39;, and it indicates that the client wishes the server to return a minimal response to a successful request. The \&#39;return&#x3D;representation\&#39; preference in this header is the same as setting query parameter \&#39;return&#x3D;FULL\&#39;. (optional)
     * @return GTVAPIServiceCustomFieldValue
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper updateServiceCustomFieldValue(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('serviceId'), 'serviceId');
      client.assertNotNull(params.get('id'), 'id');
      client.assertNotNull(
        params.get('serviceCustomFieldValue'),
        'serviceCustomFieldValue'
      );
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'PUT',
        '/services/{service_id}/custom-field-values/{id}',
        (RestAPI2Domain.GTVAPIServiceCustomFieldValue) params.get(
          'serviceCustomFieldValue'
        ),
        query,
        form,
        new Map<String, Object>{
          'service_id' => (String) params.get('serviceId'),
          'id' => (String) params.get('id')
        },
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIServiceCustomFieldValue.class
      );
    }
    /**
     * Update service period
     * Updates an existing service period associated with the specified service and service period IDs.
     * @param serviceId The ID of the service. (required)
     * @param id The internal ID of the object. (required)
     * @param updateServicePeriod The payload for updating an existing service period. (required)
     * @param prefer The HTTP Prefer header per https://tools.ietf.org/html/rfc7240. The \&#39;return&#x3D;[representation|minimal]\&#39; preferences are the only implemented settings at the moment and are the same as \&#39;return&#x3D;SIMPLE\&#39;, and it indicates that the client wishes the server to return a minimal response to a successful request. The \&#39;return&#x3D;representation\&#39; preference in this header is the same as setting query parameter \&#39;return&#x3D;FULL\&#39;. (optional)
     * @return GTVAPIServicePeriod
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper updateServicePeriod(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('serviceId'), 'serviceId');
      client.assertNotNull(params.get('id'), 'id');
      client.assertNotNull(
        params.get('updateServicePeriod'),
        'updateServicePeriod'
      );
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'PUT',
        '/services/{service_id}/service-periods/{id}',
        (RestAPI2Domain.GTVAPIServicePeriod) params.get('updateServicePeriod'),
        query,
        form,
        new Map<String, Object>{
          'service_id' => (String) params.get('serviceId'),
          'id' => (String) params.get('id')
        },
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIServicePeriod.class
      );
    }
  }
  /*
   * TRACT Billing API
   * Create and manage billing accounts, products, orders, services, billing, invoicing, payments, and the general ledger. This microservice provides core functionality for the goTransverse billing platform.
   *
   * OpenAPI spec version: 2
   *
   *
   * NOTE: This class is auto generated by the swagger code generator program.
   * https://github.com/swagger-api/swagger-codegen.git
   * Do not edit the class manually.
   */

  public class GTVAPIResourceCategoryService {
    GTVAPIClient client;

    public GTVAPIResourceCategoryService(GTVAPIClient client) {
      this.client = client;
    }

    public GTVAPIResourceCategoryService() {
      this.client = new GTVAPIClient();
    }

    public GTVAPIClient getClient() {
      return this.client;
    }

    /**
     * Get resource category by ID
     * Retrieves an existing resource category associated with the specified ID.
     * @param id The internal ID of the object. (required)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @return GTVResourceCategory
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper getResourceCategory(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('return', (String) params.get('r_return')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/resource-categories/{id}',
        '',
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIResourceCategory.class
      );
    }
    /**
     * Get resource categories
     * Uses query keys to retrieve a subset of existing resource categories.
     * @param filter API query language string. The syntax of the API query language is similar to SQL, the criteria are expressed in the form of predicates.\nOn the left side of the equation, there is a name of the available query parameter (for example, billing_account_id). On the right side, there is a constant value in single quotes (\&#39;sample value\&#39;). Brackets are used to group predicates, for example, \&#39;(start_date GT \&#39;1994-01-24T23:33:07+00:00\&#39;)\&#39;. Use the following logical operators: AND - conjunction, OR - disjunction, NOT - negation. Compare operators: NEQ - Not equals, EQ - Equals, LT - Less, LTE - Less or equals, GT - Greater, GTE - Greater or equals, IS NULL - Is null, IS NOT NULL - Is not null, LIKE - Match pattern (LIKE operator is only applicable to parameters of the string type). Wildcard characters: \&#39;%\&#39; - matches any number of characters, including no characters, \&#39;_\&#39; - matches exactly one character.\nHere is the sample query: the account_num GT \&#39;15\&#39; AND (name LIKE \&#39;start of name% end of name\&#39; OR status EQ \&#39;ACTIVE\&#39;).\n (optional)
     * @param r_sort Arranges search results in either ascending or descending order. By default, response results are sorted in the ascending order. To sort results in the descending order, use &quot;-&quot;. For example, the &quot;-name.&quot; value sorts the results in the descending order by name, and &quot;id&quot; sorts results in the ascending order by ID. (optional)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @param pageNumber The page number for multiple page queries. (optional, default to 1)
     * @param pageSize The page size for multiple page queries. Default maximum is 50. (optional, default to 50)
     * @param id The internal ID of the object. (optional)
     * @param resourceCategoryName The name of the service resource category. (optional)
     * @param resourceType The type of the resource. (optional)
     * @return List<GTVResourceCategory>
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper queryResourceCategories(
      Map<String, Object> params
    ) {
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('filter', (String) params.get('filter')));
      query.addAll(
        client.makeParam('sort', (List<String>) params.get('r_sort'), 'csv')
      );
      query.addAll(client.makeParam('return', (String) params.get('r_return')));
      query.addAll(
        client.makeParam('page_number', (Integer) params.get('pageNumber'))
      );
      query.addAll(
        client.makeParam('page_size', (Integer) params.get('pageSize'))
      );
      query.addAll(client.makeParam('id', (String) params.get('id')));
      query.addAll(
        client.makeParam(
          'resource_category_name',
          (String) params.get('resourceCategoryName')
        )
      );
      query.addAll(
        client.makeParam('resource_type', (String) params.get('resourceType'))
      );

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/resource-categories',
        '',
        query,
        form,
        new Map<String, Object>(),
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        List<RestAPI2Domain.GTVAPIResourceCategory>.class
      );
    }
    /**
     * Request service resource
     * Requests an available service resource and moves it to the Requested status.
     * @param id The internal ID of the object. (required)
     * @param prefer The HTTP Prefer header per https://tools.ietf.org/html/rfc7240. The \&#39;return&#x3D;[representation|minimal]\&#39; preferences are the only implemented settings at the moment and are the same as \&#39;return&#x3D;SIMPLE\&#39;, and it indicates that the client wishes the server to return a minimal response to a successful request. The \&#39;return&#x3D;representation\&#39; preference in this header is the same as setting query parameter \&#39;return&#x3D;FULL\&#39;. (optional)
     * @return GTVServiceResource
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper requestServiceResourceByCategory(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'POST',
        '/resource-categories/{id}/request-resource',
        '',
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIServiceResource.class
      );
    }
  }
  /*
   * TRACT Billing API
   * Create and manage billing accounts, products, orders, services, billing, invoicing, payments, and the general ledger. This microservice provides core functionality for the goTransverse billing platform.
   *
   * OpenAPI spec version: 2
   *
   *
   * NOTE: This class is auto generated by the GTVAPIRestClient code generator program.
   * https://github.com/GTVAPIRestClient-api/GTVAPIRestClient-codegen.git
   * Do not edit the class manually.
   */

  public class GTVAPIInvoiceItemService {
    GTVAPIClient client;

    public GTVAPIInvoiceItemService(GTVAPIClient client) {
      this.client = client;
    }

    public GTVAPIInvoiceItemService() {
      this.client = new GTVAPIClient();
    }

    public GTVAPIClient getClient() {
      return this.client;
    }

    /**
     * Get invoice item by ID
     * Retrieves an invoice item associated with the specified ID.
     * @param id The internal ID of the object. (required)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @return GTVAPIRestClient.ResponseWrapper
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper getInvoiceItem(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('return', (String) params.get('r_return')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/invoice-items/{id}',
        '',
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIInvoiceItem.class
      );
    }
    /**
     * Get invoice items
     * Retrieves a subset of invoice items using query keys.
     * @param filter API query language string. The syntax of the API query language is similar to SQL, the criteria are expressed in the form of predicates.\nOn the left side of the equation, there is a name of the available query parameter (for example, billing_account_id). On the right side, there is a constant value in single quotes (\&#39;sample value\&#39;). Brackets are used to group predicates, for example, \&#39;(start_date GT \&#39;1994-01-24T23:33:07+00:00\&#39;)\&#39;. Use the following logical operators: AND - conjunction, OR - disjunction, NOT - negation. Compare operators: NEQ - Not equals, EQ - Equals, LT - Less, LTE - Less or equals, GT - Greater, GTE - Greater or equals, IS NULL - Is null, IS NOT NULL - Is not null, LIKE - Match pattern (LIKE operator is only applicable to parameters of the string type). Wildcard characters: \&#39;%\&#39; - matches any number of characters, including no characters, \&#39;_\&#39; - matches exactly one character.\nHere is the sample query: the account_num GT \&#39;15\&#39; AND (name LIKE \&#39;start of name% end of name\&#39; OR status EQ \&#39;ACTIVE\&#39;).\n (optional)
     * @param r_sort Arranges search results in either ascending or descending order. By default, response results are sorted in the ascending order. To sort results in the descending order, use &quot;-&quot;. For example, the &quot;-name.&quot; value sorts the results in the descending order by name, and &quot;id&quot; sorts results in the ascending order by ID. (optional)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @param pageNumber The page number for multiple page queries. (optional, default to 1)
     * @param pageSize The page size for multiple page queries. Default maximum is 50. (optional, default to 50)
     * @param id The internal ID of the object. (optional)
     * @param invoiceId The ID of the invoice. (optional)
     * @param invoiceNum The number of the invoice. (optional)
     * @param r_type The type of the invoice item. (optional)
     * @param serviceId The ID of the service. (optional)
     * @return List<GTVAPIInvoiceItem>
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper queryInvoiceItems(
      Map<String, Object> params
    ) {
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('filter', (String) params.get('filter')));
      query.addAll(
        client.makeParam('sort', (List<String>) params.get('r_sort'), 'csv')
      );
      query.addAll(client.makeParam('return', (String) params.get('r_return')));
      query.addAll(
        client.makeParam('page_number', (Integer) params.get('pageNumber'))
      );
      query.addAll(
        client.makeParam('page_size', (Integer) params.get('pageSize'))
      );
      query.addAll(client.makeParam('id', (String) params.get('id')));
      query.addAll(
        client.makeParam('invoice_id', (String) params.get('invoiceId'))
      );
      query.addAll(
        client.makeParam('invoice_num', (String) params.get('invoiceNum'))
      );
      query.addAll(client.makeParam('type', (String) params.get('r_type')));
      query.addAll(
        client.makeParam('service_id', (String) params.get('serviceId'))
      );

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/invoice-items',
        '',
        query,
        form,
        new Map<String, Object>(),
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        List<RestAPI2Domain.GTVAPIInvoiceItem>.class
      );
    }
  }

  /*
   * TRACT Billing API
   * Create and manage billing accounts, products, orders, services, billing, invoicing, payments, and the general ledger. This microservice provides core functionality for the goTransverse billing platform.
   *
   * OpenAPI spec version: 2
   *
   *
   * NOTE: This class is auto generated by the swagger code generator program.
   * https://github.com/swagger-api/swagger-codegen.git
   * Do not edit the class manually.
   */

  public class GTVAPIReasonService {
    GTVAPIClient client;

    public GTVAPIReasonService(GTVAPIClient client) {
      this.client = client;
    }

    public GTVAPIReasonService() {
      this.client = new GTVAPIClient();
    }

    public GTVAPIClient getClient() {
      return this.client;
    }

    /**
     * Get billing account deactivation reason by ID
     * Retrieves the reason for deactivating a billing account associated with the specified ID.
     * @param id The internal ID of the object. (required)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @return GTVBillingAccountDeactivationReason
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper getBillingAccountDeactivationReason(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('return', (String) params.get('r_return')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/billing-account-deactivation-reasons/{id}',
        '',
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVBillingAccountDeactivationReason.class
      );
    }
    /**
     * Get billing account suspension reason by ID
     * Retrieves the reason for suspending a billing account associated with the specified ID.
     * @param id The internal ID of the object. (required)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @return GTVBillingAccountSuspensionReason
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper getBillingAccountSuspensionReason(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('return', (String) params.get('r_return')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/billing-account-suspension-reasons/{id}',
        '',
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVBillingAccountSuspensionReason.class
      );
    }
    /**
     * Get credit adjustment reason by ID
     * Retrieves the reason for creating a credit adjustment associated with the specified ID.
     * @param id The internal ID of the object. (required)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @return GTVAdjustmentReason
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper getCreditAdjustmentReason(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('return', (String) params.get('r_return')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/credit-adjustment-reasons/{id}',
        '',
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAdjustmentReason.class
      );
    }
    /**
     * Get debit adjustment reason by ID
     * Retrieves the reason for creating a debit adjustment associated with the specified ID.
     * @param id The internal ID of the object. (required)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @return GTVAdjustmentReason
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper getDebitAdjustmentReason(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('return', (String) params.get('r_return')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/debit-adjustment-reasons/{id}',
        '',
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAdjustmentReason.class
      );
    }
    /**
     * Get manual invoice reason by ID
     * Retrieves the reason for creating a manual invoice associated with the specified ID.
     * @param id The internal ID of the object. (required)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @return GTVManualInvoiceReason
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper getManualInvoiceReason(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('return', (String) params.get('r_return')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/manual-invoice-reasons/{id}',
        '',
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVManualInvoiceReason.class
      );
    }
    /**
     * Get payment change reason by ID
     * Retrieves the reason for payment change associated with the specified ID.
     * @param id The internal ID of the object. (required)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @return GTVPaymentChangeReason
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper getPaymentChangeReason(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('return', (String) params.get('r_return')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/payment-change-reasons/{id}',
        '',
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVPaymentChangeReason.class
      );
    }
    /**
     * Get service deactivation reason by ID
     * Retrieves the reason for deactivating a service associated with the specified ID.
     * @param id The internal ID of the object. (required)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @return GTVServiceDeactivationReason
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper getServiceDeactivationReason(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('return', (String) params.get('r_return')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/service-deactivation-reasons/{id}',
        '',
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIServiceDeactivationReason.class
      );
    }
    /**
     * Get service suspension reason by ID
     * Retrieves the reason for suspending a service associated with the specified ID.
     * @param id The internal ID of the object. (required)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @return GTVServiceSuspensionReason
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper getServiceSuspensionReason(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('return', (String) params.get('r_return')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/service-suspension-reasons/{id}',
        '',
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVServiceSuspensionReason.class
      );
    }
    /**
     * Get billing account deactivation reasons
     * Uses query keys to retrieve a subset of existing reasons for deactivating a billing account.
     * @param filter API query language string. The syntax of the API query language is similar to SQL, the criteria are expressed in the form of predicates.\nOn the left side of the equation, there is a name of the available query parameter (for example, billing_account_id). On the right side, there is a constant value in single quotes (\&#39;sample value\&#39;). Brackets are used to group predicates, for example, \&#39;(start_date GT \&#39;1994-01-24T23:33:07+00:00\&#39;)\&#39;. Use the following logical operators: AND - conjunction, OR - disjunction, NOT - negation. Compare operators: NEQ - Not equals, EQ - Equals, LT - Less, LTE - Less or equals, GT - Greater, GTE - Greater or equals, IS NULL - Is null, IS NOT NULL - Is not null, LIKE - Match pattern (LIKE operator is only applicable to parameters of the string type). Wildcard characters: \&#39;%\&#39; - matches any number of characters, including no characters, \&#39;_\&#39; - matches exactly one character.\nHere is the sample query: the account_num GT \&#39;15\&#39; AND (name LIKE \&#39;start of name% end of name\&#39; OR status EQ \&#39;ACTIVE\&#39;).\n (optional)
     * @param r_sort Arranges search results in either ascending or descending order. By default, response results are sorted in the ascending order. To sort results in the descending order, use &quot;-&quot;. For example, the &quot;-name.&quot; value sorts the results in the descending order by name, and &quot;id&quot; sorts results in the ascending order by ID. (optional)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @param pageNumber The page number for multiple page queries. (optional, default to 1)
     * @param pageSize The page size for multiple page queries. Default maximum is 50. (optional, default to 50)
     * @param id The internal ID of the object. (optional)
     * @param name The name the reason. (optional)
     * @return List<GTVBillingAccountDeactivationReason>
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper queryBillingAccountDeactivationReasons(
      Map<String, Object> params
    ) {
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('filter', (String) params.get('filter')));
      query.addAll(
        client.makeParam('sort', (List<String>) params.get('r_sort'), 'csv')
      );
      query.addAll(client.makeParam('return', (String) params.get('r_return')));
      query.addAll(
        client.makeParam('page_number', (Integer) params.get('pageNumber'))
      );
      query.addAll(
        client.makeParam('page_size', (Integer) params.get('pageSize'))
      );
      query.addAll(client.makeParam('id', (String) params.get('id')));
      query.addAll(client.makeParam('name', (String) params.get('name')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/billing-account-deactivation-reasons',
        '',
        query,
        form,
        new Map<String, Object>(),
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        List<RestAPI2Domain.GTVAPIBillingAccountDeactivationReason>.class
      );
    }
    /**
     * Get billing account suspension reasons
     * Uses query keys to retrieve a subset of existing reasons for suspending a billing account.
     * @param filter API query language string. The syntax of the API query language is similar to SQL, the criteria are expressed in the form of predicates.\nOn the left side of the equation, there is a name of the available query parameter (for example, billing_account_id). On the right side, there is a constant value in single quotes (\&#39;sample value\&#39;). Brackets are used to group predicates, for example, \&#39;(start_date GT \&#39;1994-01-24T23:33:07+00:00\&#39;)\&#39;. Use the following logical operators: AND - conjunction, OR - disjunction, NOT - negation. Compare operators: NEQ - Not equals, EQ - Equals, LT - Less, LTE - Less or equals, GT - Greater, GTE - Greater or equals, IS NULL - Is null, IS NOT NULL - Is not null, LIKE - Match pattern (LIKE operator is only applicable to parameters of the string type). Wildcard characters: \&#39;%\&#39; - matches any number of characters, including no characters, \&#39;_\&#39; - matches exactly one character.\nHere is the sample query: the account_num GT \&#39;15\&#39; AND (name LIKE \&#39;start of name% end of name\&#39; OR status EQ \&#39;ACTIVE\&#39;).\n (optional)
     * @param r_sort Arranges search results in either ascending or descending order. By default, response results are sorted in the ascending order. To sort results in the descending order, use &quot;-&quot;. For example, the &quot;-name.&quot; value sorts the results in the descending order by name, and &quot;id&quot; sorts results in the ascending order by ID. (optional)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @param pageNumber The page number for multiple page queries. (optional, default to 1)
     * @param pageSize The page size for multiple page queries. Default maximum is 50. (optional, default to 50)
     * @param id The internal ID of the object. (optional)
     * @param name The name the reason. (optional)
     * @return List<GTVBillingAccountSuspensionReason>
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper queryBillingAccountSuspensionReasons(
      Map<String, Object> params
    ) {
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('filter', (String) params.get('filter')));
      query.addAll(
        client.makeParam('sort', (List<String>) params.get('r_sort'), 'csv')
      );
      query.addAll(client.makeParam('return', (String) params.get('r_return')));
      query.addAll(
        client.makeParam('page_number', (Integer) params.get('pageNumber'))
      );
      query.addAll(
        client.makeParam('page_size', (Integer) params.get('pageSize'))
      );
      query.addAll(client.makeParam('id', (String) params.get('id')));
      query.addAll(client.makeParam('name', (String) params.get('name')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/billing-account-suspension-reasons',
        '',
        query,
        form,
        new Map<String, Object>(),
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        List<RestAPI2Domain.GTVAPIBillingAccountSuspensionReason>.class
      );
    }
    /**
     * Get credit adjustment reasons
     * Retrieves existing reasons for creating credit adjustments.
     * @param filter API query language string. The syntax of the API query language is similar to SQL, the criteria are expressed in the form of predicates.\nOn the left side of the equation, there is a name of the available query parameter (for example, billing_account_id). On the right side, there is a constant value in single quotes (\&#39;sample value\&#39;). Brackets are used to group predicates, for example, \&#39;(start_date GT \&#39;1994-01-24T23:33:07+00:00\&#39;)\&#39;. Use the following logical operators: AND - conjunction, OR - disjunction, NOT - negation. Compare operators: NEQ - Not equals, EQ - Equals, LT - Less, LTE - Less or equals, GT - Greater, GTE - Greater or equals, IS NULL - Is null, IS NOT NULL - Is not null, LIKE - Match pattern (LIKE operator is only applicable to parameters of the string type). Wildcard characters: \&#39;%\&#39; - matches any number of characters, including no characters, \&#39;_\&#39; - matches exactly one character.\nHere is the sample query: the account_num GT \&#39;15\&#39; AND (name LIKE \&#39;start of name% end of name\&#39; OR status EQ \&#39;ACTIVE\&#39;).\n (optional)
     * @param r_sort Arranges search results in either ascending or descending order. By default, response results are sorted in the ascending order. To sort results in the descending order, use &quot;-&quot;. For example, the &quot;-name.&quot; value sorts the results in the descending order by name, and &quot;id&quot; sorts results in the ascending order by ID. (optional)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @param pageNumber The page number for multiple page queries. (optional, default to 1)
     * @param pageSize The page size for multiple page queries. Default maximum is 50. (optional, default to 50)
     * @param id The internal ID of the object. (optional)
     * @param name The name the reason. (optional)
     * @param status The status of the reason. (optional)
     * @param level An adjustment level of the reason. (optional)
     * @return List<GTVAdjustmentReason>
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper queryCreditAdjustmentReasons(
      Map<String, Object> params
    ) {
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('filter', (String) params.get('filter')));
      query.addAll(
        client.makeParam('sort', (List<String>) params.get('r_sort'), 'csv')
      );
      query.addAll(client.makeParam('return', (String) params.get('r_return')));
      query.addAll(
        client.makeParam('page_number', (Integer) params.get('pageNumber'))
      );
      query.addAll(
        client.makeParam('page_size', (Integer) params.get('pageSize'))
      );
      query.addAll(client.makeParam('id', (String) params.get('id')));
      query.addAll(client.makeParam('name', (String) params.get('name')));
      query.addAll(client.makeParam('status', (String) params.get('status')));
      query.addAll(client.makeParam('level', (String) params.get('level')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/credit-adjustment-reasons',
        '',
        query,
        form,
        new Map<String, Object>(),
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        List<RestAPI2Domain.GTVAPIAdjustmentReason>.class
      );
    }
    /**
     * Get debit adjustment reasons
     * Retrieves existing reasons for creating debit adjustments.
     * @param filter API query language string. The syntax of the API query language is similar to SQL, the criteria are expressed in the form of predicates.\nOn the left side of the equation, there is a name of the available query parameter (for example, billing_account_id). On the right side, there is a constant value in single quotes (\&#39;sample value\&#39;). Brackets are used to group predicates, for example, \&#39;(start_date GT \&#39;1994-01-24T23:33:07+00:00\&#39;)\&#39;. Use the following logical operators: AND - conjunction, OR - disjunction, NOT - negation. Compare operators: NEQ - Not equals, EQ - Equals, LT - Less, LTE - Less or equals, GT - Greater, GTE - Greater or equals, IS NULL - Is null, IS NOT NULL - Is not null, LIKE - Match pattern (LIKE operator is only applicable to parameters of the string type). Wildcard characters: \&#39;%\&#39; - matches any number of characters, including no characters, \&#39;_\&#39; - matches exactly one character.\nHere is the sample query: the account_num GT \&#39;15\&#39; AND (name LIKE \&#39;start of name% end of name\&#39; OR status EQ \&#39;ACTIVE\&#39;).\n (optional)
     * @param r_sort Arranges search results in either ascending or descending order. By default, response results are sorted in the ascending order. To sort results in the descending order, use &quot;-&quot;. For example, the &quot;-name.&quot; value sorts the results in the descending order by name, and &quot;id&quot; sorts results in the ascending order by ID. (optional)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @param pageNumber The page number for multiple page queries. (optional, default to 1)
     * @param pageSize The page size for multiple page queries. Default maximum is 50. (optional, default to 50)
     * @param id The internal ID of the object. (optional)
     * @param name The name the reason. (optional)
     * @param status The status of the reason. (optional)
     * @param level An adjustment level of the reason. (optional)
     * @return List<GTVAdjustmentReason>
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper queryDebitAdjustmentReasons(
      Map<String, Object> params
    ) {
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('filter', (String) params.get('filter')));
      query.addAll(
        client.makeParam('sort', (List<String>) params.get('r_sort'), 'csv')
      );
      query.addAll(client.makeParam('return', (String) params.get('r_return')));
      query.addAll(
        client.makeParam('page_number', (Integer) params.get('pageNumber'))
      );
      query.addAll(
        client.makeParam('page_size', (Integer) params.get('pageSize'))
      );
      query.addAll(client.makeParam('id', (String) params.get('id')));
      query.addAll(client.makeParam('name', (String) params.get('name')));
      query.addAll(client.makeParam('status', (String) params.get('status')));
      query.addAll(client.makeParam('level', (String) params.get('level')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/debit-adjustment-reasons',
        '',
        query,
        form,
        new Map<String, Object>(),
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        List<RestAPI2Domain.GTVAPIAdjustmentReason>.class
      );
    }
    /**
     * Get manual invoice reasons
     * Uses query keys to retrieve all existing reasons for creating a manual invoice.
     * @param filter API query language string. The syntax of the API query language is similar to SQL, the criteria are expressed in the form of predicates.\nOn the left side of the equation, there is a name of the available query parameter (for example, billing_account_id). On the right side, there is a constant value in single quotes (\&#39;sample value\&#39;). Brackets are used to group predicates, for example, \&#39;(start_date GT \&#39;1994-01-24T23:33:07+00:00\&#39;)\&#39;. Use the following logical operators: AND - conjunction, OR - disjunction, NOT - negation. Compare operators: NEQ - Not equals, EQ - Equals, LT - Less, LTE - Less or equals, GT - Greater, GTE - Greater or equals, IS NULL - Is null, IS NOT NULL - Is not null, LIKE - Match pattern (LIKE operator is only applicable to parameters of the string type). Wildcard characters: \&#39;%\&#39; - matches any number of characters, including no characters, \&#39;_\&#39; - matches exactly one character.\nHere is the sample query: the account_num GT \&#39;15\&#39; AND (name LIKE \&#39;start of name% end of name\&#39; OR status EQ \&#39;ACTIVE\&#39;).\n (optional)
     * @param r_sort Arranges search results in either ascending or descending order. By default, response results are sorted in the ascending order. To sort results in the descending order, use &quot;-&quot;. For example, the &quot;-name.&quot; value sorts the results in the descending order by name, and &quot;id&quot; sorts results in the ascending order by ID. (optional)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @param pageNumber The page number for multiple page queries. (optional, default to 1)
     * @param pageSize The page size for multiple page queries. Default maximum is 50. (optional, default to 50)
     * @param id The internal ID of the object. (optional)
     * @param name The name the reason. (optional)
     * @return List<GTVManualInvoiceReason>
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper queryManualInvoiceReasons(
      Map<String, Object> params
    ) {
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('filter', (String) params.get('filter')));
      query.addAll(
        client.makeParam('sort', (List<String>) params.get('r_sort'), 'csv')
      );
      query.addAll(client.makeParam('return', (String) params.get('r_return')));
      query.addAll(
        client.makeParam('page_number', (Integer) params.get('pageNumber'))
      );
      query.addAll(
        client.makeParam('page_size', (Integer) params.get('pageSize'))
      );
      query.addAll(client.makeParam('id', (String) params.get('id')));
      query.addAll(client.makeParam('name', (String) params.get('name')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/manual-invoice-reasons',
        '',
        query,
        form,
        new Map<String, Object>(),
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        List<RestAPI2Domain.GTVAPIManualInvoiceReason>.class
      );
    }
    /**
     * Get payment change reasons
     * Uses query keys to retrieve all existing reasons for payment change.
     * @param filter API query language string. The syntax of the API query language is similar to SQL, the criteria are expressed in the form of predicates.\nOn the left side of the equation, there is a name of the available query parameter (for example, billing_account_id). On the right side, there is a constant value in single quotes (\&#39;sample value\&#39;). Brackets are used to group predicates, for example, \&#39;(start_date GT \&#39;1994-01-24T23:33:07+00:00\&#39;)\&#39;. Use the following logical operators: AND - conjunction, OR - disjunction, NOT - negation. Compare operators: NEQ - Not equals, EQ - Equals, LT - Less, LTE - Less or equals, GT - Greater, GTE - Greater or equals, IS NULL - Is null, IS NOT NULL - Is not null, LIKE - Match pattern (LIKE operator is only applicable to parameters of the string type). Wildcard characters: \&#39;%\&#39; - matches any number of characters, including no characters, \&#39;_\&#39; - matches exactly one character.\nHere is the sample query: the account_num GT \&#39;15\&#39; AND (name LIKE \&#39;start of name% end of name\&#39; OR status EQ \&#39;ACTIVE\&#39;).\n (optional)
     * @param r_sort Arranges search results in either ascending or descending order. By default, response results are sorted in the ascending order. To sort results in the descending order, use &quot;-&quot;. For example, the &quot;-name.&quot; value sorts the results in the descending order by name, and &quot;id&quot; sorts results in the ascending order by ID. (optional)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @param pageNumber The page number for multiple page queries. (optional, default to 1)
     * @param pageSize The page size for multiple page queries. Default maximum is 50. (optional, default to 50)
     * @param id The internal ID of the object. (optional)
     * @param name The name the reason. (optional)
     * @return List<GTVPaymentChangeReason>
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper queryPaymentChangeReasons(
      Map<String, Object> params
    ) {
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('filter', (String) params.get('filter')));
      query.addAll(
        client.makeParam('sort', (List<String>) params.get('r_sort'), 'csv')
      );
      query.addAll(client.makeParam('return', (String) params.get('r_return')));
      query.addAll(
        client.makeParam('page_number', (Integer) params.get('pageNumber'))
      );
      query.addAll(
        client.makeParam('page_size', (Integer) params.get('pageSize'))
      );
      query.addAll(client.makeParam('id', (String) params.get('id')));
      query.addAll(client.makeParam('name', (String) params.get('name')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/payment-change-reasons',
        '',
        query,
        form,
        new Map<String, Object>(),
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        List<RestAPI2Domain.GTVAPIPaymentChangeReason>.class
      );
    }
    /**
     * Get service deactivation reasons
     * Uses query keys to return a subset of existing reasons for deactivating a service.
     * @param filter API query language string. The syntax of the API query language is similar to SQL, the criteria are expressed in the form of predicates.\nOn the left side of the equation, there is a name of the available query parameter (for example, billing_account_id). On the right side, there is a constant value in single quotes (\&#39;sample value\&#39;). Brackets are used to group predicates, for example, \&#39;(start_date GT \&#39;1994-01-24T23:33:07+00:00\&#39;)\&#39;. Use the following logical operators: AND - conjunction, OR - disjunction, NOT - negation. Compare operators: NEQ - Not equals, EQ - Equals, LT - Less, LTE - Less or equals, GT - Greater, GTE - Greater or equals, IS NULL - Is null, IS NOT NULL - Is not null, LIKE - Match pattern (LIKE operator is only applicable to parameters of the string type). Wildcard characters: \&#39;%\&#39; - matches any number of characters, including no characters, \&#39;_\&#39; - matches exactly one character.\nHere is the sample query: the account_num GT \&#39;15\&#39; AND (name LIKE \&#39;start of name% end of name\&#39; OR status EQ \&#39;ACTIVE\&#39;).\n (optional)
     * @param r_sort Arranges search results in either ascending or descending order. By default, response results are sorted in the ascending order. To sort results in the descending order, use &quot;-&quot;. For example, the &quot;-name.&quot; value sorts the results in the descending order by name, and &quot;id&quot; sorts results in the ascending order by ID. (optional)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @param pageNumber The page number for multiple page queries. (optional, default to 1)
     * @param pageSize The page size for multiple page queries. Default maximum is 50. (optional, default to 50)
     * @param id The internal ID of the object. (optional)
     * @param name The name the reason. (optional)
     * @return List<GTVServiceDeactivationReason>
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper queryServiceDeactivationReasons(
      Map<String, Object> params
    ) {
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('filter', (String) params.get('filter')));
      query.addAll(
        client.makeParam('sort', (List<String>) params.get('r_sort'), 'csv')
      );
      query.addAll(client.makeParam('return', (String) params.get('r_return')));
      query.addAll(
        client.makeParam('page_number', (Integer) params.get('pageNumber'))
      );
      query.addAll(
        client.makeParam('page_size', (Integer) params.get('pageSize'))
      );
      query.addAll(client.makeParam('id', (String) params.get('id')));
      query.addAll(client.makeParam('name', (String) params.get('name')));
      query.addAll(client.makeParam('status', (String) params.get('status')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/service-deactivation-reasons',
        '',
        query,
        form,
        new Map<String, Object>(),
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        List<RestAPI2Domain.GTVAPIServiceDeactivationReason>.class
      );
    }
    /**
     * Get service suspension reasons
     * Uses query keys to retrieve a subset of existing reasons for suspending a service.
     * @param filter API query language string. The syntax of the API query language is similar to SQL, the criteria are expressed in the form of predicates.\nOn the left side of the equation, there is a name of the available query parameter (for example, billing_account_id). On the right side, there is a constant value in single quotes (\&#39;sample value\&#39;). Brackets are used to group predicates, for example, \&#39;(start_date GT \&#39;1994-01-24T23:33:07+00:00\&#39;)\&#39;. Use the following logical operators: AND - conjunction, OR - disjunction, NOT - negation. Compare operators: NEQ - Not equals, EQ - Equals, LT - Less, LTE - Less or equals, GT - Greater, GTE - Greater or equals, IS NULL - Is null, IS NOT NULL - Is not null, LIKE - Match pattern (LIKE operator is only applicable to parameters of the string type). Wildcard characters: \&#39;%\&#39; - matches any number of characters, including no characters, \&#39;_\&#39; - matches exactly one character.\nHere is the sample query: the account_num GT \&#39;15\&#39; AND (name LIKE \&#39;start of name% end of name\&#39; OR status EQ \&#39;ACTIVE\&#39;).\n (optional)
     * @param r_sort Arranges search results in either ascending or descending order. By default, response results are sorted in the ascending order. To sort results in the descending order, use &quot;-&quot;. For example, the &quot;-name.&quot; value sorts the results in the descending order by name, and &quot;id&quot; sorts results in the ascending order by ID. (optional)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @param pageNumber The page number for multiple page queries. (optional, default to 1)
     * @param pageSize The page size for multiple page queries. Default maximum is 50. (optional, default to 50)
     * @param id The internal ID of the object. (optional)
     * @param name The name the reason. (optional)
     * @return List<GTVServiceSuspensionReason>
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper queryServiceSuspensionReasons(
      Map<String, Object> params
    ) {
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('filter', (String) params.get('filter')));
      query.addAll(
        client.makeParam('sort', (List<String>) params.get('r_sort'), 'csv')
      );
      query.addAll(client.makeParam('return', (String) params.get('r_return')));
      query.addAll(
        client.makeParam('page_number', (Integer) params.get('pageNumber'))
      );
      query.addAll(
        client.makeParam('page_size', (Integer) params.get('pageSize'))
      );
      query.addAll(client.makeParam('id', (String) params.get('id')));
      query.addAll(client.makeParam('name', (String) params.get('name')));
      query.addAll(client.makeParam('status', (String) params.get('status')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/service-suspension-reasons',
        '',
        query,
        form,
        new Map<String, Object>(),
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        List<RestAPI2Domain.GTVAPIServiceSuspensionReason>.class
      );
    }
  }
  /*
   * TRACT Billing API
   * Create and manage billing accounts, products, orders, services, billing, invoicing, payments, and the general ledger. This microservice provides core functionality for the goTransverse billing platform.
   *
   * OpenAPI spec version: 2
   *
   *
   * NOTE: This class is auto generated by the swagger code generator program.
   * https://github.com/swagger-api/swagger-codegen.git
   * Do not edit the class manually.
   */

  public class GTVAPIServiceUsageRule {
    GTVAPIClient client;

    public GTVAPIServiceUsageRule(GTVAPIClient client) {
      this.client = client;
    }

    public GTVAPIServiceUsageRule() {
      this.client = new GTVAPIClient();
    }

    public GTVAPIClient getClient() {
      return this.client;
    }

    /**
     * Deprecated. Get service usage rule by ID
     * Deprecated. Retrieves an existing service usage rule associated with the specified ID.
     * @param id The internal ID of the object. (required)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @return GTVAPIServiceUsageRule
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper getServiceUsageRule(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('return', (String) params.get('r_return')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/service-usage-rules/{id}',
        '',
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIServiceUsageRule.class
      );
    }
    /**
     * Deprecated. Get service usage rule by ID
     * (deprecated) Retrieves an existing service usage rule associated with the specified service and service usage rule IDs.
     * @param serviceId The ID of the service. (required)
     * @param id The internal ID of the object. (required)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @return GTVAPIServiceUsageRule
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper getServiceUsageRuleByService(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('serviceId'), 'serviceId');
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('return', (String) params.get('r_return')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/services/{service_id}/usage-rules/{id}',
        '',
        query,
        form,
        new Map<String, Object>{
          'service_id' => (String) params.get('serviceId'),
          'id' => (String) params.get('id')
        },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIServiceUsageRule.class
      );
    }
    /**
     * Deprecated. Get service usage rules
     * Deprecated. Uses query keys to retrieve a subset of existing service usage rules.
     * @param filter API query language string. The syntax of the API query language is similar to SQL, the criteria are expressed in the form of predicates.\nOn the left side of the equation, there is a name of the available query parameter (for example, billing_account_id). On the right side, there is a constant value in single quotes (\&#39;sample value\&#39;). Brackets are used to group predicates, for example, \&#39;(start_date GT \&#39;1994-01-24T23:33:07+00:00\&#39;)\&#39;. Use the following logical operators: AND - conjunction, OR - disjunction, NOT - negation. Compare operators: NEQ - Not equals, EQ - Equals, LT - Less, LTE - Less or equals, GT - Greater, GTE - Greater or equals, IS NULL - Is null, IS NOT NULL - Is not null, LIKE - Match pattern (LIKE operator is only applicable to parameters of the string type). Wildcard characters: \&#39;%\&#39; - matches any number of characters, including no characters, \&#39;_\&#39; - matches exactly one character.\nHere is the sample query: the account_num GT \&#39;15\&#39; AND (name LIKE \&#39;start of name% end of name\&#39; OR status EQ \&#39;ACTIVE\&#39;).\n (optional)
     * @param r_sort Arranges search results in either ascending or descending order. By default, response results are sorted in the ascending order. To sort results in the descending order, use &quot;-&quot;. For example, the &quot;-name.&quot; value sorts the results in the descending order by name, and &quot;id&quot; sorts results in the ascending order by ID. (optional)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @param pageNumber The page number for multiple page queries. (optional, default to 1)
     * @param pageSize The page size for multiple page queries. Default maximum is 50. (optional, default to 50)
     * @param id The internal ID of the object. (optional)
     * @param serviceId The ID of the service. (optional)
     * @param status The status of the service usage rule. (optional)
     * @return List<GTVAPIServiceUsageRule>
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper queryServiceUsageRules(
      Map<String, Object> params
    ) {
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('filter', (String) params.get('filter')));
      query.addAll(
        client.makeParam('sort', (List<String>) params.get('r_sort'), 'csv')
      );
      query.addAll(client.makeParam('return', (String) params.get('r_return')));
      query.addAll(
        client.makeParam('page_number', (Integer) params.get('pageNumber'))
      );
      query.addAll(
        client.makeParam('page_size', (Integer) params.get('pageSize'))
      );
      query.addAll(client.makeParam('id', (String) params.get('id')));
      query.addAll(
        client.makeParam('service_id', (String) params.get('serviceId'))
      );
      query.addAll(client.makeParam('status', (String) params.get('status')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/service-usage-rules',
        '',
        query,
        form,
        new Map<String, Object>(),
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        List<RestAPI2Domain.GTVAPIServiceUsageRule>.class
      );
    }
    /**
     * Deprecated. Get service usage rules.
     * (deprecated) Retrieves existing usage rules associated with the specified service ID.
     * @param serviceId The ID of the service. (required)
     * @param filter API query language string. The syntax of the API query language is similar to SQL, the criteria are expressed in the form of predicates.\nOn the left side of the equation, there is a name of the available query parameter (for example, billing_account_id). On the right side, there is a constant value in single quotes (\&#39;sample value\&#39;). Brackets are used to group predicates, for example, \&#39;(start_date GT \&#39;1994-01-24T23:33:07+00:00\&#39;)\&#39;. Use the following logical operators: AND - conjunction, OR - disjunction, NOT - negation. Compare operators: NEQ - Not equals, EQ - Equals, LT - Less, LTE - Less or equals, GT - Greater, GTE - Greater or equals, IS NULL - Is null, IS NOT NULL - Is not null, LIKE - Match pattern (LIKE operator is only applicable to parameters of the string type). Wildcard characters: \&#39;%\&#39; - matches any number of characters, including no characters, \&#39;_\&#39; - matches exactly one character.\nHere is the sample query: the account_num GT \&#39;15\&#39; AND (name LIKE \&#39;start of name% end of name\&#39; OR status EQ \&#39;ACTIVE\&#39;).\n (optional)
     * @param r_sort Arranges search results in either ascending or descending order. By default, response results are sorted in the ascending order. To sort results in the descending order, use &quot;-&quot;. For example, the &quot;-name.&quot; value sorts the results in the descending order by name, and &quot;id&quot; sorts results in the ascending order by ID. (optional)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @param pageNumber The page number for multiple page queries. (optional, default to 1)
     * @param pageSize The page size for multiple page queries. Default maximum is 50. (optional, default to 50)
     * @param id The internal ID of the object. (optional)
     * @param status The status of the service usage rule. (optional)
     * @return List<GTVAPIServiceUsageRule>
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper queryServiceUsageRulesByService(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('serviceId'), 'serviceId');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('filter', (String) params.get('filter')));
      query.addAll(
        client.makeParam('sort', (List<String>) params.get('r_sort'), 'csv')
      );
      query.addAll(client.makeParam('return', (String) params.get('r_return')));
      query.addAll(
        client.makeParam('page_number', (Integer) params.get('pageNumber'))
      );
      query.addAll(
        client.makeParam('page_size', (Integer) params.get('pageSize'))
      );
      query.addAll(client.makeParam('id', (String) params.get('id')));
      query.addAll(client.makeParam('status', (String) params.get('status')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/services/{service_id}/usage-rules',
        '',
        query,
        form,
        new Map<String, Object>{
          'service_id' => (String) params.get('serviceId')
        },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        List<RestAPI2Domain.GTVAPIServiceUsageRule>.class
      );
    }
    /**
     * Deprecated. Update service usage rule
     * Deprecated. Updates an existing service usage rule associated with the specified ID.
     * @param id The internal ID of the object. (required)
     * @param serviceUsageRule The payload for the service usage rule. (required)
     * @param prefer The HTTP Prefer header per https://tools.ietf.org/html/rfc7240. The \&#39;return&#x3D;[representation|minimal]\&#39; preferences are the only implemented settings at the moment and are the same as \&#39;return&#x3D;SIMPLE\&#39;, and it indicates that the client wishes the server to return a minimal response to a successful request. The \&#39;return&#x3D;representation\&#39; preference in this header is the same as setting query parameter \&#39;return&#x3D;FULL\&#39;. (optional)
     * @return GTVAPIServiceUsageRule
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper updateServiceUsageRule(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('id'), 'id');
      client.assertNotNull(params.get('serviceUsageRule'), 'serviceUsageRule');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'PUT',
        '/service-usage-rules/{id}',
        (RestAPI2Domain.GTVAPIServiceUsageRule) params.get('serviceUsageRule'),
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIServiceUsageRule.class
      );
    }
    /**
     * Deprecated. Update service usage rule
     * (deprecated) Updates an existing service usage rule associated with the specified service and service usage rule IDs.
     * @param serviceId The ID of the service. (required)
     * @param id The internal ID of the object. (required)
     * @param serviceUsageRule The payload for the service usage rule. (required)
     * @param prefer The HTTP Prefer header per https://tools.ietf.org/html/rfc7240. The \&#39;return&#x3D;[representation|minimal]\&#39; preferences are the only implemented settings at the moment and are the same as \&#39;return&#x3D;SIMPLE\&#39;, and it indicates that the client wishes the server to return a minimal response to a successful request. The \&#39;return&#x3D;representation\&#39; preference in this header is the same as setting query parameter \&#39;return&#x3D;FULL\&#39;. (optional)
     * @return GTVAPIServiceUsageRule
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper updateServiceUsageRuleByService(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('serviceId'), 'serviceId');
      client.assertNotNull(params.get('id'), 'id');
      client.assertNotNull(params.get('serviceUsageRule'), 'serviceUsageRule');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'PUT',
        '/services/{service_id}/usage-rules/{id}',
        (RestAPI2Domain.GTVAPIServiceUsageRule) params.get('serviceUsageRule'),
        query,
        form,
        new Map<String, Object>{
          'service_id' => (String) params.get('serviceId'),
          'id' => (String) params.get('id')
        },
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIServiceUsageRule.class
      );
    }
  }
  /*
   * TRACT Billing API
   * Create and manage billing accounts, products, orders, services, billing, invoicing, payments, and the general ledger. This microservice provides core functionality for the goTransverse billing platform.
   *
   * OpenAPI spec version: 2
   *
   *
   * NOTE: This class is auto generated by the GTVAPIRestClient code generator program.
   * https://github.com/GTVAPIRestClient-api/GTVAPIRestClient-codegen.git
   * Do not edit the class manually.
   */

  public class GTVAPIProductRelationService {
    GTVAPIClient client;

    public GTVAPIProductRelationService(GTVAPIClient client) {
      this.client = client;
    }

    public GTVAPIProductRelationService() {
      this.client = new GTVAPIClient();
    }

    public GTVAPIClient getClient() {
      return this.client;
    }

    /**
     * Deprecated. Get product relation by ID
     * Deprecated. Retrieves an existing product relation associated with the specified ID.
     * @param id The internal ID of the object. (required)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @return GTVProductRelation
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper getProductRelation(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('return', (String) params.get('r_return')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/product-relations/{id}',
        '',
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIProductRelation.class
      );
    }
    /**
     * Deprecated. Get product relations
     * Deprecated. Uses query keys to retrieve a subset of existing product relations.
     * @param filter API query language string. The syntax of the API query language is similar to SQL, the criteria are expressed in the form of predicates.\nOn the left side of the equation, there is a name of the available query parameter (for example, billing_account_id). On the right side, there is a constant value in single quotes (\&#39;sample value\&#39;). Brackets are used to group predicates, for example, \&#39;(start_date GT \&#39;1994-01-24T23:33:07+00:00\&#39;)\&#39;. Use the following logical operators: AND - conjunction, OR - disjunction, NOT - negation. Compare operators: NEQ - Not equals, EQ - Equals, LT - Less, LTE - Less or equals, GT - Greater, GTE - Greater or equals, IS NULL - Is null, IS NOT NULL - Is not null, LIKE - Match pattern (LIKE operator is only applicable to parameters of the string type). Wildcard characters: \&#39;%\&#39; - matches any number of characters, including no characters, \&#39;_\&#39; - matches exactly one character.\nHere is the sample query: the account_num GT \&#39;15\&#39; AND (name LIKE \&#39;start of name% end of name\&#39; OR status EQ \&#39;ACTIVE\&#39;).\n (optional)
     * @param r_sort Arranges search results in either ascending or descending order. By default, response results are sorted in the ascending order. To sort results in the descending order, use &quot;-&quot;. For example, the &quot;-name.&quot; value sorts the results in the descending order by name, and &quot;id&quot; sorts results in the ascending order by ID. (optional)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @param pageNumber The page number for multiple page queries. (optional, default to 1)
     * @param pageSize The page size for multiple page queries. Default maximum is 50. (optional, default to 50)
     * @param id The internal ID of the object. (optional)
     * @param productId The ID of the product. (optional)
     * @param relatedProductId The ID of the related product. (optional)
     * @param productName The name of the product. (optional)
     * @param productSku The stock keeping unit (SKU) for the product. (optional)
     * @param relatedProductName The name of the related product. (optional)
     * @param relatedProductSku The stock keeping unit (SKU) of the related product. (optional)
     * @param r_type The type of product relation. Product relations can be child, parent, required, add-on, incompatible, recommended, or dependent. (optional)
     * @param scope The product relation scope type. (optional)
     * @return List<GTVProductRelation>
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper queryProductRelations(
      Map<String, Object> params
    ) {
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('filter', (String) params.get('filter')));
      query.addAll(
        client.makeParam('sort', (List<String>) params.get('r_sort'), 'csv')
      );
      query.addAll(client.makeParam('return', (String) params.get('r_return')));
      query.addAll(
        client.makeParam('page_number', (Integer) params.get('pageNumber'))
      );
      query.addAll(
        client.makeParam('page_size', (Integer) params.get('pageSize'))
      );
      query.addAll(client.makeParam('id', (String) params.get('id')));
      query.addAll(
        client.makeParam('product_id', (String) params.get('productId'))
      );
      query.addAll(
        client.makeParam(
          'related_product_id',
          (String) params.get('relatedProductId')
        )
      );
      query.addAll(
        client.makeParam('product_name', (String) params.get('productName'))
      );
      query.addAll(
        client.makeParam('product_sku', (String) params.get('productSku'))
      );
      query.addAll(
        client.makeParam(
          'related_product_name',
          (String) params.get('relatedProductName')
        )
      );
      query.addAll(
        client.makeParam(
          'related_product_sku',
          (String) params.get('relatedProductSku')
        )
      );
      query.addAll(client.makeParam('type', (String) params.get('r_type')));
      query.addAll(client.makeParam('scope', (String) params.get('scope')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/product-relations',
        '',
        query,
        form,
        new Map<String, Object>(),
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        List<RestAPI2Domain.GTVAPIProductRelation>.class
      );
    }

    /**
     * Remove association between products
     * Removes an existing relation of a certain type between products by the specified product and relation IDs.
     * @param productId The ID of the product. (required)
     * @param id The internal ID of the object. (required)
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public void removeProductRelation(Map<String, Object> params) {
      client.assertNotNull(params.get('productId'), 'productId');
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      client.invoke(
        'DELETE',
        '/products/{product_id}/relations/{id}',
        '',
        query,
        form,
        new Map<String, Object>{
          'product_id' => (String) params.get('productId'),
          'id' => (String) params.get('id')
        },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        null
      );
    }
  }
  /*
   * TRACT Billing API
   * Create and manage billing accounts, products, orders, services, billing, invoicing, payments, and the general ledger. This microservice provides core functionality for the goTransverse billing platform.
   *
   * OpenAPI spec version: 2
   *
   *
   * NOTE: This class is auto generated by the swagger code generator program.
   * https://github.com/swagger-api/swagger-codegen.git
   * Do not edit the class manually.
   */

  public class GTVAPIDiscountCodeService {
    GTVAPIClient client;

    public GTVAPIDiscountCodeService(GTVAPIClient client) {
      this.client = client;
    }

    public GTVAPIDiscountCodeService() {
      this.client = new GTVAPIClient();
    }

    public GTVAPIClient getClient() {
      return this.client;
    }

    /**
     * Get discount code by ID
     * Retrieves an existing discount code associated with the specified ID.
     * @param id The internal ID of the object. (required)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @return GTVAPIDiscountCode
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper getDiscountCode(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('return', (String) params.get('r_return')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/discount-codes/{id}',
        '',
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIDiscountCode.class
      );
    }
    /**
     * Get discount codes
     * Uses query keys to retrieve a subset of existing discount codes. If you have added the product ID as a query parameter but haven\&#39;t specified the ID of the desired product price group, the response will contain only the discount codes of the Default price list and not all price lists.
     * @param filter API query language string. The syntax of the API query language is similar to SQL, the criteria are expressed in the form of predicates.\nOn the left side of the equation, there is a name of the available query parameter (for example, billing_account_id). On the right side, there is a constant value in single quotes (\&#39;sample value\&#39;). Brackets are used to group predicates, for example, \&#39;(start_date GT \&#39;1994-01-24T23:33:07+00:00\&#39;)\&#39;. Use the following logical operators: AND - conjunction, OR - disjunction, NOT - negation. Compare operators: NEQ - Not equals, EQ - Equals, LT - Less, LTE - Less or equals, GT - Greater, GTE - Greater or equals, IS NULL - Is null, IS NOT NULL - Is not null, LIKE - Match pattern (LIKE operator is only applicable to parameters of the string type). Wildcard characters: \&#39;%\&#39; - matches any number of characters, including no characters, \&#39;_\&#39; - matches exactly one character.\nHere is the sample query: the account_num GT \&#39;15\&#39; AND (name LIKE \&#39;start of name% end of name\&#39; OR status EQ \&#39;ACTIVE\&#39;).\n (optional)
     * @param r_sort Arranges search results in either ascending or descending order. By default, response results are sorted in the ascending order. To sort results in the descending order, use &quot;-&quot;. For example, the &quot;-name.&quot; value sorts the results in the descending order by name, and &quot;id&quot; sorts results in the ascending order by ID. (optional)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @param pageNumber The page number for multiple page queries. (optional, default to 1)
     * @param pageSize The page size for multiple page queries. Default maximum is 50. (optional, default to 50)
     * @param id The internal ID of the object. (optional)
     * @param name The name of the discount code. (optional)
     * @param status The status of the discount code. (optional)
     * @param discountChargeCategoryId The ID of the discount charge category. (optional)
     * @param validFrom The date and time from when the resource is valid. (optional)
     * @param validTo The date and time until when the resource is valid. (optional)
     * @param discountId The ID of the discount. (optional)
     * @param discountResourceIdentifier A resource of the discount. (optional)
     * @param discountResourceId The resource ID of the discount. (optional)
     * @param priceListId The ID of the product price list. (optional)
     * @param priceListName The name of the product price list. (optional)
     * @param currencyCode The currency code for the amount. (optional)
     * @param productId The ID of the product. (optional)
     * @return List<GTVAPIDiscountCode>
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper queryDiscountCodes(
      Map<String, Object> params
    ) {
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('filter', (String) params.get('filter')));
      query.addAll(
        client.makeParam('sort', (List<String>) params.get('r_sort'), 'csv')
      );
      query.addAll(client.makeParam('return', (String) params.get('r_return')));
      query.addAll(
        client.makeParam('page_number', (Integer) params.get('pageNumber'))
      );
      query.addAll(
        client.makeParam('page_size', (Integer) params.get('pageSize'))
      );
      query.addAll(client.makeParam('id', (String) params.get('id')));
      query.addAll(client.makeParam('name', (String) params.get('name')));
      query.addAll(client.makeParam('status', (String) params.get('status')));
      query.addAll(
        client.makeParam(
          'discount_charge_category_id',
          (String) params.get('discountChargeCategoryId')
        )
      );
      query.addAll(
        client.makeParam('valid_from', (Datetime) params.get('validFrom'))
      );
      query.addAll(
        client.makeParam('valid_to', (Datetime) params.get('validTo'))
      );
      query.addAll(
        client.makeParam('discount_id', (String) params.get('discountId'))
      );
      query.addAll(
        client.makeParam(
          'discount_resource_identifier',
          (String) params.get('discountResourceIdentifier')
        )
      );
      query.addAll(
        client.makeParam(
          'discount_resource_id',
          (String) params.get('discountResourceId')
        )
      );
      query.addAll(
        client.makeParam('price_list_id', (String) params.get('priceListId'))
      );
      query.addAll(
        client.makeParam(
          'price_list_name',
          (String) params.get('priceListName')
        )
      );
      query.addAll(
        client.makeParam('currency_code', (String) params.get('currencyCode'))
      );
      query.addAll(
        client.makeParam('product_id', (String) params.get('productId'))
      );

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/discount-codes',
        '',
        query,
        form,
        new Map<String, Object>(),
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        List<RestAPI2Domain.GTVAPIDiscountCode>.class
      );
    }
  }
  /*
   * TRACT Billing API
   * Create and manage billing accounts, products, orders, services, billing, invoicing, payments, and the general ledger. This microservice provides core functionality for the goTransverse billing platform.
   *
   * OpenAPI spec version: 2
   *
   *
   * NOTE: This class is auto generated by the swagger code generator program.
   * https://github.com/swagger-api/swagger-codegen.git
   * Do not edit the class manually.
   */

  public class GTVAPIProductUsageRuleService {
    GTVAPIClient client;

    public GTVAPIProductUsageRuleService(GTVAPIClient client) {
      this.client = client;
    }

    public GTVAPIProductUsageRuleService() {
      this.client = new GTVAPIClient();
    }

    public GTVAPIClient getClient() {
      return this.client;
    }

    /**
     * Deprecated. Get product usage rule by ID
     * Deprecated. Retrieves an existing product usage rule associated with the specified ID.
     * @param id The internal ID of the object. (required)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @return GTVAPIProductUsageRule
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper getProductUsageRule(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('return', (String) params.get('r_return')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/product-usage-rules/{id}',
        '',
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIProductUsageRule.class
      );
    }
    /**
     * Deprecated. Get product usage rules
     * Deprecated. Uses query keys to retrieve a subset of existing product usage rules.
     * @param filter API query language string. The syntax of the API query language is similar to SQL, the criteria are expressed in the form of predicates.\nOn the left side of the equation, there is a name of the available query parameter (for example, billing_account_id). On the right side, there is a constant value in single quotes (\&#39;sample value\&#39;). Brackets are used to group predicates, for example, \&#39;(start_date GT \&#39;1994-01-24T23:33:07+00:00\&#39;)\&#39;. Use the following logical operators: AND - conjunction, OR - disjunction, NOT - negation. Compare operators: NEQ - Not equals, EQ - Equals, LT - Less, LTE - Less or equals, GT - Greater, GTE - Greater or equals, IS NULL - Is null, IS NOT NULL - Is not null, LIKE - Match pattern (LIKE operator is only applicable to parameters of the string type). Wildcard characters: \&#39;%\&#39; - matches any number of characters, including no characters, \&#39;_\&#39; - matches exactly one character.\nHere is the sample query: the account_num GT \&#39;15\&#39; AND (name LIKE \&#39;start of name% end of name\&#39; OR status EQ \&#39;ACTIVE\&#39;).\n (optional)
     * @param r_sort Arranges search results in either ascending or descending order. By default, response results are sorted in the ascending order. To sort results in the descending order, use &quot;-&quot;. For example, the &quot;-name.&quot; value sorts the results in the descending order by name, and &quot;id&quot; sorts results in the ascending order by ID. (optional)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @param pageNumber The page number for multiple page queries. (optional, default to 1)
     * @param pageSize The page size for multiple page queries. Default maximum is 50. (optional, default to 50)
     * @param id The internal ID of the object. (optional)
     * @param status The status of the product usage rule. (optional)
     * @param productId The ID of the product. (optional)
     * @param productPriceId The ID of the product price for the product. (optional)
     * @return List<GTVAPIProductUsageRule>
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper queryProductUsageRules(
      Map<String, Object> params
    ) {
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('filter', (String) params.get('filter')));
      query.addAll(
        client.makeParam('sort', (List<String>) params.get('r_sort'), 'csv')
      );
      query.addAll(client.makeParam('return', (String) params.get('r_return')));
      query.addAll(
        client.makeParam('page_number', (Integer) params.get('pageNumber'))
      );
      query.addAll(
        client.makeParam('page_size', (Integer) params.get('pageSize'))
      );
      query.addAll(client.makeParam('id', (String) params.get('id')));
      query.addAll(client.makeParam('status', (String) params.get('status')));
      query.addAll(
        client.makeParam('product_id', (String) params.get('productId'))
      );
      query.addAll(
        client.makeParam(
          'product_price_id',
          (String) params.get('productPriceId')
        )
      );

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/product-usage-rules',
        '',
        query,
        form,
        new Map<String, Object>(),
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        List<RestAPI2Domain.GTVAPIProductUsageRule>.class
      );
    }

    public GTVAPIRestClient.ResponseWrapper createProductUsageRule(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('productId'), 'productId');
      client.assertNotNull(params.get('productPriceId'), 'productPriceId');
      client.assertNotNull(params.get('usageRules'), 'usageRules');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'POST',
        '/products/{product_id}/recurring-prices/{product_price_id}/usage-rules',
        (RestAPI2Domain.GTVAPICreateProductUsageRule) params.get('usageRules'),
        query,
        form,
        new Map<String, Object>{
          'product_id' => (String) params.get('productId'),
          'product_price_id' => (String) params.get('productPriceId')
        },
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIProductUsageRule.class
      );
    }
  }
  /*
   * TRACT Billing API
   * Create and manage billing accounts, products, orders, services, billing, invoicing, payments, and the general ledger. This microservice provides core functionality for the goTransverse billing platform.
   *
   * OpenAPI spec version: 2
   *
   *
   * NOTE: This class is auto generated by the swagger code generator program.
   * https://github.com/swagger-api/swagger-codegen.git
   * Do not edit the class manually.
   */

  public class GTVAPIServiceResourceService {
    GTVAPIClient client;

    public GTVAPIServiceResourceService(GTVAPIClient client) {
      this.client = client;
    }

    public GTVAPIServiceResourceService() {
      this.client = new GTVAPIClient();
    }

    public GTVAPIClient getClient() {
      return this.client;
    }

    /**
     * Create service resource
     * Adds a service resource to the specified service.
     * @param serviceId The ID of the service. (required)
     * @param addServiceResource The payload for adding a new or existing service resource to the existing service. (required)
     * @param prefer The HTTP Prefer header per https://tools.ietf.org/html/rfc7240. The \&#39;return&#x3D;[representation|minimal]\&#39; preferences are the only implemented settings at the moment and are the same as \&#39;return&#x3D;SIMPLE\&#39;, and it indicates that the client wishes the server to return a minimal response to a successful request. The \&#39;return&#x3D;representation\&#39; preference in this header is the same as setting query parameter \&#39;return&#x3D;FULL\&#39;. (optional)
     * @return GTVAPIServiceResource
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper addServiceResource(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('serviceId'), 'serviceId');
      client.assertNotNull(
        params.get('addServiceResource'),
        'addServiceResource'
      );
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'POST',
        '/services/{service_id}/service-resources',
        (RestAPI2Domain.GTVAPIAddServiceResource) params.get(
          'addServiceResource'
        ),
        query,
        form,
        new Map<String, Object>{
          'service_id' => (String) params.get('serviceId')
        },
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIServiceResource.class
      );
    }
    /**
     * Add service resource
     * Adds service resource to order item associated with the specified ID.
     * @param orderItemId The ID of the order item. (required)
     * @param addCreateServiceResource The payload for creating or adding a new service resource. (required)
     * @param prefer The HTTP Prefer header per https://tools.ietf.org/html/rfc7240. The \&#39;return&#x3D;[representation|minimal]\&#39; preferences are the only implemented settings at the moment and are the same as \&#39;return&#x3D;SIMPLE\&#39;, and it indicates that the client wishes the server to return a minimal response to a successful request. The \&#39;return&#x3D;representation\&#39; preference in this header is the same as setting query parameter \&#39;return&#x3D;FULL\&#39;. (optional)
     * @return GTVAPIServiceResource
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper addServiceResourceByOrderItem(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('orderItemId'), 'orderItemId');
      client.assertNotNull(
        params.get('addCreateServiceResource'),
        'addCreateServiceResource'
      );
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'POST',
        '/order-items/{order_item_id}/service-resources',
        (RestAPI2Domain.GTVAPICreateOrAddServiceResource) params.get(
          'addCreateServiceResource'
        ),
        query,
        form,
        new Map<String, Object>{
          'order_item_id' => (String) params.get('orderItemId')
        },
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIServiceResource.class
      );
    }
    /**
     * Import a bulk of service resources
     * Imports a bulk of service resources associated with the specified service ID.
     * @param serviceId The ID of the service. (required)
     * @param importServiceResources A payload for importing the bulk of service resources. (required)
     * @param prefer The HTTP Prefer header per https://tools.ietf.org/html/rfc7240. The \&#39;return&#x3D;[representation|minimal]\&#39; preferences are the only implemented settings at the moment and are the same as \&#39;return&#x3D;SIMPLE\&#39;, and it indicates that the client wishes the server to return a minimal response to a successful request. The \&#39;return&#x3D;representation\&#39; preference in this header is the same as setting query parameter \&#39;return&#x3D;FULL\&#39;. (optional)
     * @return GTVAPIBulkServiceResources
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper addServiceResourcesBulk(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('serviceId'), 'serviceId');
      client.assertNotNull(
        params.get('importServiceResources'),
        'importServiceResources'
      );
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'POST',
        '/services/{service_id}/service-resources/bulk',
        (RestAPI2Domain.GTVAPIImportBulkServiceResources) params.get(
          'importServiceResources'
        ),
        query,
        form,
        new Map<String, Object>{
          'service_id' => (String) params.get('serviceId')
        },
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIBulkServiceResources.class
      );
    }
    /**
     * Make service resource available
     * Makes the existing service resource associated with the specified ID available, meaning available to be requested.
     * @param id The internal ID of the object. (required)
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public void availableServiceResource(Map<String, Object> params) {
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      client.invoke(
        'POST',
        '/service-resources/{id}/available',
        '',
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        null
      );
    }
    /**
     * Create service resource
     * Creates a new service resource.
     * @param createServiceResource The payload for creating a new service resource. (required)
     * @param prefer The HTTP Prefer header per https://tools.ietf.org/html/rfc7240. The \&#39;return&#x3D;[representation|minimal]\&#39; preferences are the only implemented settings at the moment and are the same as \&#39;return&#x3D;SIMPLE\&#39;, and it indicates that the client wishes the server to return a minimal response to a successful request. The \&#39;return&#x3D;representation\&#39; preference in this header is the same as setting query parameter \&#39;return&#x3D;FULL\&#39;. (optional)
     * @return GTVAPIServiceResource
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper createServiceResource(
      Map<String, Object> params
    ) {
      client.assertNotNull(
        params.get('createServiceResource'),
        'createServiceResource'
      );
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'POST',
        '/service-resources',
        (RestAPI2Domain.GTVAPICreateServiceResource) params.get(
          'createServiceResource'
        ),
        query,
        form,
        new Map<String, Object>(),
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIServiceResource.class
      );
    }
    /**
     * Deactivate service resource
     * Deactivates an existing service resource associated with the specified ID. Deactivating a service resource is permanent and that service resource cannot be resumed or reactivated.\n
     * @param id The internal ID of the object. (required)
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public void deactivateServiceResource(Map<String, Object> params) {
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      client.invoke(
        'POST',
        '/service-resources/{id}/deactivate',
        '',
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        null
      );
    }
    /**
     * Get service resource by ID
     * Retrieves an existing service resource associated with the specified ID.
     * @param id The internal ID of the object. (required)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @return GTVAPIServiceResource
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper getServiceResource(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('return', (String) params.get('r_return')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/service-resources/{id}',
        '',
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIServiceResource.class
      );
    }
    /**
     * Get service resource by ID
     * Retrieves an existing service resource for the order item associated with the specified ID.
     * @param orderItemId The ID of the order item. (required)
     * @param id The internal ID of the object. (required)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @return GTVAPIServiceResource
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper getServiceResourceByOrderItem(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('orderItemId'), 'orderItemId');
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('return', (String) params.get('r_return')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/order-items/{order_item_id}/service-resources/{id}',
        '',
        query,
        form,
        new Map<String, Object>{
          'order_item_id' => (String) params.get('orderItemId'),
          'id' => (String) params.get('id')
        },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIServiceResource.class
      );
    }
    /**
     * Get service resource by ID
     * Retrieves an existing service resource associated with the specified service and service resource IDs.
     * @param serviceId The ID of the service. (required)
     * @param id The internal ID of the object. (required)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @return GTVAPIServiceResource
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper getServiceResourceByService(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('serviceId'), 'serviceId');
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('return', (String) params.get('r_return')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/services/{service_id}/service-resources/{id}',
        '',
        query,
        form,
        new Map<String, Object>{
          'service_id' => (String) params.get('serviceId'),
          'id' => (String) params.get('id')
        },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIServiceResource.class
      );
    }
    /**
     * Get service resources
     * Uses query keys to retrieve a subset of existing service resources.
     * @param filter API query language string. The syntax of the API query language is similar to SQL, the criteria are expressed in the form of predicates.\nOn the left side of the equation, there is a name of the available query parameter (for example, billing_account_id). On the right side, there is a constant value in single quotes (\&#39;sample value\&#39;). Brackets are used to group predicates, for example, \&#39;(start_date GT \&#39;1994-01-24T23:33:07+00:00\&#39;)\&#39;. Use the following logical operators: AND - conjunction, OR - disjunction, NOT - negation. Compare operators: NEQ - Not equals, EQ - Equals, LT - Less, LTE - Less or equals, GT - Greater, GTE - Greater or equals, IS NULL - Is null, IS NOT NULL - Is not null, LIKE - Match pattern (LIKE operator is only applicable to parameters of the string type). Wildcard characters: \&#39;%\&#39; - matches any number of characters, including no characters, \&#39;_\&#39; - matches exactly one character.\nHere is the sample query: the account_num GT \&#39;15\&#39; AND (name LIKE \&#39;start of name% end of name\&#39; OR status EQ \&#39;ACTIVE\&#39;).\n (optional)
     * @param r_sort Arranges search results in either ascending or descending order. By default, response results are sorted in the ascending order. To sort results in the descending order, use &quot;-&quot;. For example, the &quot;-name.&quot; value sorts the results in the descending order by name, and &quot;id&quot; sorts results in the ascending order by ID. (optional)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @param pageNumber The page number for multiple page queries. (optional, default to 1)
     * @param pageSize The page size for multiple page queries. Default maximum is 50. (optional, default to 50)
     * @param id The internal ID of the object. (optional)
     * @param identifier The identifier of the service or discount resource. (optional)
     * @param resourceCategoryId The ID of the service resource category. (optional)
     * @param orderItemId The ID of the order item entity. (optional)
     * @param serviceId The ID of the service. (optional)
     * @param status The status of the service resource category. (optional)
     * @param description The description of the service resource category. (optional)
     * @return List<GTVAPIServiceResource>
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper queryServiceResources(
      Map<String, Object> params
    ) {
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('filter', (String) params.get('filter')));
      query.addAll(
        client.makeParam('sort', (List<String>) params.get('r_sort'), 'csv')
      );
      query.addAll(client.makeParam('return', (String) params.get('r_return')));
      query.addAll(
        client.makeParam('page_number', (Integer) params.get('pageNumber'))
      );
      query.addAll(
        client.makeParam('page_size', (Integer) params.get('pageSize'))
      );
      query.addAll(client.makeParam('id', (String) params.get('id')));
      query.addAll(
        client.makeParam('identifier', (String) params.get('identifier'))
      );
      query.addAll(
        client.makeParam(
          'resource_category_id',
          (String) params.get('resourceCategoryId')
        )
      );
      query.addAll(
        client.makeParam('order_item_id', (String) params.get('orderItemId'))
      );
      query.addAll(
        client.makeParam('service_id', (String) params.get('serviceId'))
      );
      query.addAll(client.makeParam('status', (String) params.get('status')));
      query.addAll(
        client.makeParam('description', (String) params.get('description'))
      );

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/service-resources',
        '',
        query,
        form,
        new Map<String, Object>(),
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        List<RestAPI2Domain.GTVAPIServiceResource>.class
      );
    }
    /**
     * Get service resources
     * Retrieves existing service resources associated with the specified order item ID.
     * @param orderItemId The ID of the order item. (required)
     * @param filter API query language string. The syntax of the API query language is similar to SQL, the criteria are expressed in the form of predicates.\nOn the left side of the equation, there is a name of the available query parameter (for example, billing_account_id). On the right side, there is a constant value in single quotes (\&#39;sample value\&#39;). Brackets are used to group predicates, for example, \&#39;(start_date GT \&#39;1994-01-24T23:33:07+00:00\&#39;)\&#39;. Use the following logical operators: AND - conjunction, OR - disjunction, NOT - negation. Compare operators: NEQ - Not equals, EQ - Equals, LT - Less, LTE - Less or equals, GT - Greater, GTE - Greater or equals, IS NULL - Is null, IS NOT NULL - Is not null, LIKE - Match pattern (LIKE operator is only applicable to parameters of the string type). Wildcard characters: \&#39;%\&#39; - matches any number of characters, including no characters, \&#39;_\&#39; - matches exactly one character.\nHere is the sample query: the account_num GT \&#39;15\&#39; AND (name LIKE \&#39;start of name% end of name\&#39; OR status EQ \&#39;ACTIVE\&#39;).\n (optional)
     * @param r_sort Arranges search results in either ascending or descending order. By default, response results are sorted in the ascending order. To sort results in the descending order, use &quot;-&quot;. For example, the &quot;-name.&quot; value sorts the results in the descending order by name, and &quot;id&quot; sorts results in the ascending order by ID. (optional)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @param pageNumber The page number for multiple page queries. (optional, default to 1)
     * @param pageSize The page size for multiple page queries. Default maximum is 50. (optional, default to 50)
     * @param id The internal ID of the object. (optional)
     * @param identifier The identifier of the service or discount resource. (optional)
     * @param resourceCategoryId The ID of the service resource category. (optional)
     * @param status The status of the service resource category. (optional)
     * @param description The description of the service resource category. (optional)
     * @return List<GTVAPIServiceResource>
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper queryServiceResourcesByOrderItem(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('orderItemId'), 'orderItemId');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('filter', (String) params.get('filter')));
      query.addAll(
        client.makeParam('sort', (List<String>) params.get('r_sort'), 'csv')
      );
      query.addAll(client.makeParam('return', (String) params.get('r_return')));
      query.addAll(
        client.makeParam('page_number', (Integer) params.get('pageNumber'))
      );
      query.addAll(
        client.makeParam('page_size', (Integer) params.get('pageSize'))
      );
      query.addAll(client.makeParam('id', (String) params.get('id')));
      query.addAll(
        client.makeParam('identifier', (String) params.get('identifier'))
      );
      query.addAll(
        client.makeParam(
          'resource_category_id',
          (String) params.get('resourceCategoryId')
        )
      );
      query.addAll(client.makeParam('status', (String) params.get('status')));
      query.addAll(
        client.makeParam('description', (String) params.get('description'))
      );

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/order-items/{order_item_id}/service-resources',
        '',
        query,
        form,
        new Map<String, Object>{
          'order_item_id' => (String) params.get('orderItemId')
        },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        List<RestAPI2Domain.GTVAPIServiceResource>.class
      );
    }
    /**
     * Get service resources
     * Retrieves existing service resources associated with the specified service.
     * @param serviceId The ID of the service. (required)
     * @param filter API query language string. The syntax of the API query language is similar to SQL, the criteria are expressed in the form of predicates.\nOn the left side of the equation, there is a name of the available query parameter (for example, billing_account_id). On the right side, there is a constant value in single quotes (\&#39;sample value\&#39;). Brackets are used to group predicates, for example, \&#39;(start_date GT \&#39;1994-01-24T23:33:07+00:00\&#39;)\&#39;. Use the following logical operators: AND - conjunction, OR - disjunction, NOT - negation. Compare operators: NEQ - Not equals, EQ - Equals, LT - Less, LTE - Less or equals, GT - Greater, GTE - Greater or equals, IS NULL - Is null, IS NOT NULL - Is not null, LIKE - Match pattern (LIKE operator is only applicable to parameters of the string type). Wildcard characters: \&#39;%\&#39; - matches any number of characters, including no characters, \&#39;_\&#39; - matches exactly one character.\nHere is the sample query: the account_num GT \&#39;15\&#39; AND (name LIKE \&#39;start of name% end of name\&#39; OR status EQ \&#39;ACTIVE\&#39;).\n (optional)
     * @param r_sort Arranges search results in either ascending or descending order. By default, response results are sorted in the ascending order. To sort results in the descending order, use &quot;-&quot;. For example, the &quot;-name.&quot; value sorts the results in the descending order by name, and &quot;id&quot; sorts results in the ascending order by ID. (optional)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @param pageNumber The page number for multiple page queries. (optional, default to 1)
     * @param pageSize The page size for multiple page queries. Default maximum is 50. (optional, default to 50)
     * @param id The internal ID of the object. (optional)
     * @param identifier The identifier of the service or discount resource. (optional)
     * @param resourceCategoryId The ID of the service resource category. (optional)
     * @param orderItemId The ID of the order item entity. (optional)
     * @param status The status of the service resource category. (optional)
     * @param description The description of the service resource category. (optional)
     * @return List<GTVAPIServiceResource>
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper queryServiceResourcesByService(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('serviceId'), 'serviceId');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('filter', (String) params.get('filter')));
      query.addAll(
        client.makeParam('sort', (List<String>) params.get('r_sort'), 'csv')
      );
      query.addAll(client.makeParam('return', (String) params.get('r_return')));
      query.addAll(
        client.makeParam('page_number', (Integer) params.get('pageNumber'))
      );
      query.addAll(
        client.makeParam('page_size', (Integer) params.get('pageSize'))
      );
      query.addAll(client.makeParam('id', (String) params.get('id')));
      query.addAll(
        client.makeParam('identifier', (String) params.get('identifier'))
      );
      query.addAll(
        client.makeParam(
          'resource_category_id',
          (String) params.get('resourceCategoryId')
        )
      );
      query.addAll(
        client.makeParam('order_item_id', (String) params.get('orderItemId'))
      );
      query.addAll(client.makeParam('status', (String) params.get('status')));
      query.addAll(
        client.makeParam('description', (String) params.get('description'))
      );

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/services/{service_id}/service-resources',
        '',
        query,
        form,
        new Map<String, Object>{
          'service_id' => (String) params.get('serviceId')
        },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        List<RestAPI2Domain.GTVAPIServiceResource>.class
      );
    }
    /**
     * Delete service resource
     * Deletes a service resource associated with the specified ID.
     * @param id The internal ID of the object. (required)
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public void removeServiceResource(Map<String, Object> params) {
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      client.invoke(
        'DELETE',
        '/service-resources/{id}',
        '',
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        null
      );
    }
    /**
     * Remove service resource by ID
     * Removes an existing service resource for the order item associated with the specified ID.
     * @param orderItemId The ID of the order item. (required)
     * @param id The internal ID of the object. (required)
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public void removeServiceResourceByOrderItem(Map<String, Object> params) {
      client.assertNotNull(params.get('orderItemId'), 'orderItemId');
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      client.invoke(
        'DELETE',
        '/order-items/{order_item_id}/service-resources/{id}',
        '',
        query,
        form,
        new Map<String, Object>{
          'order_item_id' => (String) params.get('orderItemId'),
          'id' => (String) params.get('id')
        },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        null
      );
    }
    /**
     * Delete service resource
     * Removes an existing service resource associated with the specified service and service resource IDs.
     * @param serviceId The ID of the service. (required)
     * @param id The internal ID of the object. (required)
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public void removeServiceResourceByService(Map<String, Object> params) {
      client.assertNotNull(params.get('serviceId'), 'serviceId');
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      client.invoke(
        'DELETE',
        '/services/{service_id}/service-resources/{id}',
        '',
        query,
        form,
        new Map<String, Object>{
          'service_id' => (String) params.get('serviceId'),
          'id' => (String) params.get('id')
        },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        null
      );
    }
    /**
     * Replace service resource on specified service
     * Replaces the existing service resource on the service associated with the specified IDs.
     * @param serviceId The ID of the service. (required)
     * @param id The internal ID of the object. (required)
     * @param replaceServiceResource The payload for replacing a service resource. (required)
     * @param prefer The HTTP Prefer header per https://tools.ietf.org/html/rfc7240. The \&#39;return&#x3D;[representation|minimal]\&#39; preferences are the only implemented settings at the moment and are the same as \&#39;return&#x3D;SIMPLE\&#39;, and it indicates that the client wishes the server to return a minimal response to a successful request. The \&#39;return&#x3D;representation\&#39; preference in this header is the same as setting query parameter \&#39;return&#x3D;FULL\&#39;. (optional)
     * @return GTVAPIServiceResource
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper replaceServiceResource(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('serviceId'), 'serviceId');
      client.assertNotNull(params.get('id'), 'id');
      client.assertNotNull(
        params.get('replaceServiceResource'),
        'replaceServiceResource'
      );
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'POST',
        '/services/{service_id}/service-resources/{id}/replace',
        (RestAPI2Domain.GTVAPIAddServiceResource) params.get(
          'replaceServiceResource'
        ),
        query,
        form,
        new Map<String, Object>{
          'service_id' => (String) params.get('serviceId'),
          'id' => (String) params.get('id')
        },
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIServiceResource.class
      );
    }
    /**
     * Make service resource requested
     * Moves the service resource to the Requested status.
     * @param id The internal ID of the object. (required)
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public void requestServiceResource(Map<String, Object> params) {
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      client.invoke(
        'POST',
        '/service-resources/{id}/requested',
        '',
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        null
      );
    }
    /**
     * Request service resource
     * Requests an available service resource and moves it to the Requested status.
     * @param id The internal ID of the object. (required)
     * @param prefer The HTTP Prefer header per https://tools.ietf.org/html/rfc7240. The \&#39;return&#x3D;[representation|minimal]\&#39; preferences are the only implemented settings at the moment and are the same as \&#39;return&#x3D;SIMPLE\&#39;, and it indicates that the client wishes the server to return a minimal response to a successful request. The \&#39;return&#x3D;representation\&#39; preference in this header is the same as setting query parameter \&#39;return&#x3D;FULL\&#39;. (optional)
     * @return GTVAPIServiceResource
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper requestServiceResourceByCategory(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'POST',
        '/resource-categories/{id}/request-resource',
        '',
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIServiceResource.class
      );
    }
    /**
     * Update service resource
     * Updates the existing service resource associated with the specified ID.
     * @param id The internal ID of the object. (required)
     * @param updateServiceResource The payload for updating a service resource. (required)
     * @param prefer The HTTP Prefer header per https://tools.ietf.org/html/rfc7240. The \&#39;return&#x3D;[representation|minimal]\&#39; preferences are the only implemented settings at the moment and are the same as \&#39;return&#x3D;SIMPLE\&#39;, and it indicates that the client wishes the server to return a minimal response to a successful request. The \&#39;return&#x3D;representation\&#39; preference in this header is the same as setting query parameter \&#39;return&#x3D;FULL\&#39;. (optional)
     * @return GTVAPIServiceResource
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper updateServiceResource(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('id'), 'id');
      client.assertNotNull(
        params.get('updateServiceResource'),
        'updateServiceResource'
      );
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'PUT',
        '/service-resources/{id}',
        (RestAPI2Domain.GTVAPIServiceResource) params.get(
          'updateServiceResource'
        ),
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIServiceResource.class
      );
    }
  }
  /*
   * TRACT Billing API
   * Create and manage billing accounts, products, orders, services, billing, invoicing, payments, and the general ledger. This microservice provides core functionality for the goTransverse billing platform.
   *
   * OpenAPI spec version: 2
   *
   *
   * NOTE: This class is auto generated by the swagger code generator program.
   * https://github.com/swagger-api/swagger-codegen.git
   * Do not edit the class manually.
   */

  public class GTVAPIChargeCategoryService {
    GTVAPIClient client;

    public GTVAPIChargeCategoryService(GTVAPIClient client) {
      this.client = client;
    }

    public GTVAPIChargeCategoryService() {
      this.client = new GTVAPIClient();
    }

    public GTVAPIClient getClient() {
      return this.client;
    }

    /**
     * Get charge category by ID
     * Retrieves an existing charge category associated with the specified ID.
     * @param id The internal ID of the object. (required)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @return GTVChargeCategory
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper getChargeCategory(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('return', (String) params.get('r_return')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/charge-categories/{id}',
        '',
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIChargeCategory.class
      );
    }
    /**
     * Get charge categories
     * Uses query keys to retrieve a subset of existing charge categories.
     * @param filter API query language string. The syntax of the API query language is similar to SQL, the criteria are expressed in the form of predicates.\nOn the left side of the equation, there is a name of the available query parameter (for example, billing_account_id). On the right side, there is a constant value in single quotes (\&#39;sample value\&#39;). Brackets are used to group predicates, for example, \&#39;(start_date GT \&#39;1994-01-24T23:33:07+00:00\&#39;)\&#39;. Use the following logical operators: AND - conjunction, OR - disjunction, NOT - negation. Compare operators: NEQ - Not equals, EQ - Equals, LT - Less, LTE - Less or equals, GT - Greater, GTE - Greater or equals, IS NULL - Is null, IS NOT NULL - Is not null, LIKE - Match pattern (LIKE operator is only applicable to parameters of the string type). Wildcard characters: \&#39;%\&#39; - matches any number of characters, including no characters, \&#39;_\&#39; - matches exactly one character.\nHere is the sample query: the account_num GT \&#39;15\&#39; AND (name LIKE \&#39;start of name% end of name\&#39; OR status EQ \&#39;ACTIVE\&#39;).\n (optional)
     * @param r_sort Arranges search results in either ascending or descending order. By default, response results are sorted in the ascending order. To sort results in the descending order, use &quot;-&quot;. For example, the &quot;-name.&quot; value sorts the results in the descending order by name, and &quot;id&quot; sorts results in the ascending order by ID. (optional)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @param pageNumber The page number for multiple page queries. (optional, default to 1)
     * @param pageSize The page size for multiple page queries. Default maximum is 50. (optional, default to 50)
     * @param id The internal ID of the object. (optional)
     * @param name The name of the charge category. (optional)
     * @param status The status of the charge category. (optional)
     * @param r_type The type of the charge category. (optional)
     * @return List<GTVChargeCategory>
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper queryChargeCategories(
      Map<String, Object> params
    ) {
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('filter', (String) params.get('filter')));
      query.addAll(
        client.makeParam('sort', (List<String>) params.get('r_sort'), 'csv')
      );
      query.addAll(client.makeParam('return', (String) params.get('r_return')));
      query.addAll(
        client.makeParam('page_number', (Integer) params.get('pageNumber'))
      );
      query.addAll(
        client.makeParam('page_size', (Integer) params.get('pageSize'))
      );
      query.addAll(client.makeParam('id', (String) params.get('id')));
      query.addAll(client.makeParam('name', (String) params.get('name')));
      query.addAll(client.makeParam('status', (String) params.get('status')));
      query.addAll(client.makeParam('type', (String) params.get('r_type')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/charge-categories',
        '',
        query,
        form,
        new Map<String, Object>(),
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        List<RestAPI2Domain.GTVAPIChargeCategory>.class
      );
    }
  }
  /*
   * TRACT Billing API
   * Create and manage billing accounts, products, orders, services, billing, invoicing, payments, and the general ledger. This microservice provides core functionality for the goTransverse billing platform.
   *
   * OpenAPI spec version: 2
   *
   *
   * NOTE: This class is auto generated by the swagger code generator program.
   * https://github.com/swagger-api/swagger-codegen.git
   * Do not edit the class manually.
   */

  public class GTVAPIRateTableService {
    GTVAPIClient client;

    public GTVAPIRateTableService(GTVAPIClient client) {
      this.client = client;
    }

    public GTVAPIRateTableService() {
      this.client = new GTVAPIClient();
    }

    public GTVAPIClient getClient() {
      return this.client;
    }

    /**
     * Add rate table
     * Creates a new rate table.
     * @param rateTable The payload for creating a new rate table. (required)
     * @param prefer The HTTP Prefer header per https://tools.ietf.org/html/rfc7240. The \&#39;return&#x3D;[representation|minimal]\&#39; preferences are the only implemented settings at the moment and are the same as \&#39;return&#x3D;SIMPLE\&#39;, and it indicates that the client wishes the server to return a minimal response to a successful request. The \&#39;return&#x3D;representation\&#39; preference in this header is the same as setting query parameter \&#39;return&#x3D;FULL\&#39;. (optional)
     * @return GTVAPIRateTable
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper addRateTable(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('rateTable'), 'rateTable');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'POST',
        '/rate-tables',
        (RestAPI2Domain.GTVAPICreateRateTable) params.get('rateTable'),
        query,
        form,
        new Map<String, Object>(),
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIRateTable.class
      );
    }
    /**
     * Add rate table entry
     * Inserts a new entry into the rate table associated with the specified ID.
     * @param rateTableId The ID of the rate table. (required)
     * @param rateTableEntry The payload for creating a new rate table entry. (required)
     * @param prefer The HTTP Prefer header per https://tools.ietf.org/html/rfc7240. The \&#39;return&#x3D;[representation|minimal]\&#39; preferences are the only implemented settings at the moment and are the same as \&#39;return&#x3D;SIMPLE\&#39;, and it indicates that the client wishes the server to return a minimal response to a successful request. The \&#39;return&#x3D;representation\&#39; preference in this header is the same as setting query parameter \&#39;return&#x3D;FULL\&#39;. (optional)
     * @return GTVAPIRateTableEntry
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper addRateTableEntry(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('rateTableId'), 'rateTableId');
      client.assertNotNull(params.get('rateTableEntry'), 'rateTableEntry');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'POST',
        '/rate-tables/{rate_table_id}/entries',
        (RestAPI2Domain.GTVAPICreateRateTableEntry) params.get(
          'rateTableEntry'
        ),
        query,
        form,
        new Map<String, Object>{
          'rate_table_id' => (String) params.get('rateTableId')
        },
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIRateTableEntry.class
      );
    }
    /**
     * Get rate table by ID
     * Retrieves an existing rate table associated with the specified ID.
     * @param id The internal ID of the object. (required)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @return GTVAPIRateTable
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper getRateTable(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('return', (String) params.get('r_return')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/rate-tables/{id}',
        '',
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIRateTable.class
      );
    }
    /**
     * Get entry by ID
     * Retrieves an existing rate table entry associated with the specified rate table and entry IDs.
     * @param rateTableId The ID of the rate table. (required)
     * @param id The internal ID of the object. (required)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @return GTVAPIRateTableEntry
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper getRateTableEntryByRateTable(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('rateTableId'), 'rateTableId');
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('return', (String) params.get('r_return')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/rate-tables/{rate_table_id}/entries/{id}',
        '',
        query,
        form,
        new Map<String, Object>{
          'rate_table_id' => (String) params.get('rateTableId'),
          'id' => (String) params.get('id')
        },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIRateTableEntry.class
      );
    }
    /**
     * Get rate tables
     * Uses query keys to retrieve a subset of existing rate tables.
     * @param filter API query language string. The syntax of the API query language is similar to SQL, the criteria are expressed in the form of predicates.\nOn the left side of the equation, there is a name of the available query parameter (for example, billing_account_id). On the right side, there is a constant value in single quotes (\&#39;sample value\&#39;). Brackets are used to group predicates, for example, \&#39;(start_date GT \&#39;1994-01-24T23:33:07+00:00\&#39;)\&#39;. Use the following logical operators: AND - conjunction, OR - disjunction, NOT - negation. Compare operators: NEQ - Not equals, EQ - Equals, LT - Less, LTE - Less or equals, GT - Greater, GTE - Greater or equals, IS NULL - Is null, IS NOT NULL - Is not null, LIKE - Match pattern (LIKE operator is only applicable to parameters of the string type). Wildcard characters: \&#39;%\&#39; - matches any number of characters, including no characters, \&#39;_\&#39; - matches exactly one character.\nHere is the sample query: the account_num GT \&#39;15\&#39; AND (name LIKE \&#39;start of name% end of name\&#39; OR status EQ \&#39;ACTIVE\&#39;).\n (optional)
     * @param r_sort Arranges search results in either ascending or descending order. By default, response results are sorted in the ascending order. To sort results in the descending order, use &quot;-&quot;. For example, the &quot;-name.&quot; value sorts the results in the descending order by name, and &quot;id&quot; sorts results in the ascending order by ID. (optional)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @param pageNumber The page number for multiple page queries. (optional, default to 1)
     * @param pageSize The page size for multiple page queries. Default maximum is 50. (optional, default to 50)
     * @param id The internal ID of the object. (optional)
     * @param name The name of the rate table. (optional)
     * @param status The status of the rate table. (optional)
     * @return List<GTVAPIRateTable>
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper queryRateTables(
      Map<String, Object> params
    ) {
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('filter', (String) params.get('filter')));
      query.addAll(
        client.makeParam('sort', (List<String>) params.get('r_sort'), 'csv')
      );
      query.addAll(client.makeParam('return', (String) params.get('r_return')));
      query.addAll(
        client.makeParam('page_number', (Integer) params.get('pageNumber'))
      );
      query.addAll(
        client.makeParam('page_size', (Integer) params.get('pageSize'))
      );
      query.addAll(client.makeParam('id', (String) params.get('id')));
      query.addAll(client.makeParam('name', (String) params.get('name')));
      query.addAll(client.makeParam('status', (String) params.get('status')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/rate-tables',
        '',
        query,
        form,
        new Map<String, Object>(),
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        List<RestAPI2Domain.GTVAPIRateTable>.class
      );
    }
    /**
     * Get rate table entries
     * Retrieves existing entries for the rate table associated with the specified ID.
     * @param rateTableId The ID of the rate table. (required)
     * @param filter API query language string. The syntax of the API query language is similar to SQL, the criteria are expressed in the form of predicates.\nOn the left side of the equation, there is a name of the available query parameter (for example, billing_account_id). On the right side, there is a constant value in single quotes (\&#39;sample value\&#39;). Brackets are used to group predicates, for example, \&#39;(start_date GT \&#39;1994-01-24T23:33:07+00:00\&#39;)\&#39;. Use the following logical operators: AND - conjunction, OR - disjunction, NOT - negation. Compare operators: NEQ - Not equals, EQ - Equals, LT - Less, LTE - Less or equals, GT - Greater, GTE - Greater or equals, IS NULL - Is null, IS NOT NULL - Is not null, LIKE - Match pattern (LIKE operator is only applicable to parameters of the string type). Wildcard characters: \&#39;%\&#39; - matches any number of characters, including no characters, \&#39;_\&#39; - matches exactly one character.\nHere is the sample query: the account_num GT \&#39;15\&#39; AND (name LIKE \&#39;start of name% end of name\&#39; OR status EQ \&#39;ACTIVE\&#39;).\n (optional)
     * @param r_sort Arranges search results in either ascending or descending order. By default, response results are sorted in the ascending order. To sort results in the descending order, use &quot;-&quot;. For example, the &quot;-name.&quot; value sorts the results in the descending order by name, and &quot;id&quot; sorts results in the ascending order by ID. (optional)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @param pageNumber The page number for multiple page queries. (optional, default to 1)
     * @param pageSize The page size for multiple page queries. Default maximum is 50. (optional, default to 50)
     * @param id The internal ID of the object. (optional)
     * @param lookup The value of the lookup table. (optional)
     * @param rate The rate that applies to the value in the lookup value table. (optional)
     * @param validFrom The date and time from when the resource is valid. (optional)
     * @param validTo The date and time until when the resource is valid. (optional)
     * @return List<GTVAPIRateTableEntry>
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper queryRateTablesEntries(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('rateTableId'), 'rateTableId');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('filter', (String) params.get('filter')));
      query.addAll(
        client.makeParam('sort', (List<String>) params.get('r_sort'), 'csv')
      );
      query.addAll(client.makeParam('return', (String) params.get('r_return')));
      query.addAll(
        client.makeParam('page_number', (Integer) params.get('pageNumber'))
      );
      query.addAll(
        client.makeParam('page_size', (Integer) params.get('pageSize'))
      );
      query.addAll(client.makeParam('id', (String) params.get('id')));
      query.addAll(client.makeParam('lookup', (String) params.get('lookup')));
      query.addAll(client.makeParam('rate', (Double) params.get('rate')));
      query.addAll(
        client.makeParam('valid_from', (Datetime) params.get('validFrom'))
      );
      query.addAll(
        client.makeParam('valid_to', (Datetime) params.get('validTo'))
      );

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/rate-tables/{rate_table_id}/entries',
        '',
        query,
        form,
        new Map<String, Object>{
          'rate_table_id' => (String) params.get('rateTableId')
        },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        List<RestAPI2Domain.GTVAPIRateTableEntry>.class
      );
    }
    /**
     * Delete rate table
     * Removes an existing rate table associated with the specified ID.
     * @param id The internal ID of the object. (required)
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public void removeRateTable(Map<String, Object> params) {
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      client.invoke(
        'DELETE',
        '/rate-tables/{id}',
        '',
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        null
      );
    }
    /**
     * Delete rate table entry
     * Removes an existing rate table entry associated with the specified rate table and entry IDs.
     * @param rateTableId The ID of the rate table. (required)
     * @param id The internal ID of the object. (required)
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public void removeRateTableEntry(Map<String, Object> params) {
      client.assertNotNull(params.get('rateTableId'), 'rateTableId');
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      client.invoke(
        'DELETE',
        '/rate-tables/{rate_table_id}/entries/{id}',
        '',
        query,
        form,
        new Map<String, Object>{
          'rate_table_id' => (String) params.get('rateTableId'),
          'id' => (String) params.get('id')
        },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        null
      );
    }
    /**
     * Update rate table
     * Updates an existing rate table associated with the specified ID.
     * @param id The internal ID of the object. (required)
     * @param rateTable The payload for updating the existing rate table. (required)
     * @param prefer The HTTP Prefer header per https://tools.ietf.org/html/rfc7240. The \&#39;return&#x3D;[representation|minimal]\&#39; preferences are the only implemented settings at the moment and are the same as \&#39;return&#x3D;SIMPLE\&#39;, and it indicates that the client wishes the server to return a minimal response to a successful request. The \&#39;return&#x3D;representation\&#39; preference in this header is the same as setting query parameter \&#39;return&#x3D;FULL\&#39;. (optional)
     * @return GTVAPIRateTable
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper updateRateTable(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('id'), 'id');
      client.assertNotNull(params.get('rateTable'), 'rateTable');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'PUT',
        '/rate-tables/{id}',
        (RestAPI2Domain.GTVAPIRateTable) params.get('rateTable'),
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIRateTable.class
      );
    }
    /**
     * Update rate table entry
     * Updates an existing rate table entry associated with the specified rate table and entry IDs.
     * @param rateTableId The ID of the rate table. (required)
     * @param id The internal ID of the object. (required)
     * @param rateTableEntry The payload for updating the existing rate table entry. (required)
     * @param prefer The HTTP Prefer header per https://tools.ietf.org/html/rfc7240. The \&#39;return&#x3D;[representation|minimal]\&#39; preferences are the only implemented settings at the moment and are the same as \&#39;return&#x3D;SIMPLE\&#39;, and it indicates that the client wishes the server to return a minimal response to a successful request. The \&#39;return&#x3D;representation\&#39; preference in this header is the same as setting query parameter \&#39;return&#x3D;FULL\&#39;. (optional)
     * @return GTVAPIRateTableEntry
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper updateRateTableEntry(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('rateTableId'), 'rateTableId');
      client.assertNotNull(params.get('id'), 'id');
      client.assertNotNull(params.get('rateTableEntry'), 'rateTableEntry');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'PUT',
        '/rate-tables/{rate_table_id}/entries/{id}',
        (RestAPI2Domain.GTVAPIRateTableEntry) params.get('rateTableEntry'),
        query,
        form,
        new Map<String, Object>{
          'rate_table_id' => (String) params.get('rateTableId'),
          'id' => (String) params.get('id')
        },
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIRateTableEntry.class
      );
    }
  }

  public class GTVAPIProductCategoryService {
    GTVAPIClient client;

    public GTVAPIProductCategoryService(GTVAPIClient client) {
      this.client = client;
    }

    public GTVAPIProductCategoryService() {
      this.client = new GTVAPIClient();
    }

    public GTVAPIClient getClient() {
      return this.client;
    }

    /**
     * Get product categories
     * Retrieves a list of product categories.
     * @param filter API query language string. The syntax of the API query language is similar to SQL, the criteria are expressed in the form of predicates.\nOn the left side of the equation, there is a name of the available query parameter (for example, billing_account_id). On the right side, there is a constant value in single quotes (\&#39;sample value\&#39;). Brackets are used to group predicates, for example, \&#39;(start_date GT \&#39;1994-01-24T23:33:07+00:00\&#39;)\&#39;. Use the following logical operators: AND - conjunction, OR - disjunction, NOT - negation. Compare operators: NEQ - Not equals, EQ - Equals, LT - Less, LTE - Less or equals, GT - Greater, GTE - Greater or equals, IS NULL - Is null, IS NOT NULL - Is not null, LIKE - Match pattern (LIKE operator is only applicable to parameters of the string type). Wildcard characters: \&#39;%\&#39; - matches any number of characters, including no characters, \&#39;_\&#39; - matches exactly one character.\nHere is the sample query: the account_num GT \&#39;15\&#39; AND (name LIKE \&#39;start of name% end of name\&#39; OR status EQ \&#39;ACTIVE\&#39;).\n (optional)
     * @param r_sort Arranges search results in either ascending or descending order. By default, response results are sorted in the ascending order. To sort results in the descending order, use &quot;-&quot;. For example, the &quot;-name.&quot; value sorts the results in the descending order by name, and &quot;id&quot; sorts results in the ascending order by ID. (optional)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @param pageNumber The page number for multiple page queries. (optional, default to 1)
     * @param pageSize The page size for multiple page queries. Default maximum is 50. (optional, default to 50)
     * @param id The internal ID of the object. (optional)
     * @param name The name of the product category. (optional)
     * @param status The status of the product category. (optional)
     * @return List<GTVProductCategory>
     * @throws Swagger.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper queryProductCategories(
      Map<String, Object> params
    ) {
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('filter', (String) params.get('filter')));
      query.addAll(
        client.makeParam('sort', (List<String>) params.get('r_sort'), 'csv')
      );
      query.addAll(client.makeParam('return', (String) params.get('r_return')));
      query.addAll(
        client.makeParam('page_number', (Integer) params.get('pageNumber'))
      );
      query.addAll(
        client.makeParam('page_size', (Integer) params.get('pageSize'))
      );
      query.addAll(client.makeParam('id', (String) params.get('id')));
      query.addAll(client.makeParam('name', (String) params.get('name')));
      query.addAll(client.makeParam('status', (String) params.get('status')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/product-categories',
        '',
        query,
        form,
        new Map<String, Object>(),
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        List<RestAPI2Domain.GTVAPIProductCategory>.class
      );
    }
  }

  public class GTVAPIProductTagService {
    GTVAPIClient client;

    public GTVAPIProductTagService(GTVAPIClient client) {
      this.client = client;
    }

    public GTVAPIProductTagService() {
      this.client = new GTVAPIClient();
    }

    public GTVAPIClient getClient() {
      return this.client;
    }

    /**
     * Get product tags
     * Uses query keys to retrieve a subset of existing product tags.
     * @param filter API query language string. The syntax of the API query language is similar to SQL, the criteria are expressed in the form of predicates.\nOn the left side of the equation, there is a name of the available query parameter (for example, billing_account_id). On the right side, there is a constant value in single quotes (\&#39;sample value\&#39;). Brackets are used to group predicates, for example, \&#39;(start_date GT \&#39;1994-01-24T23:33:07+00:00\&#39;)\&#39;. Use the following logical operators: AND - conjunction, OR - disjunction, NOT - negation. Compare operators: NEQ - Not equals, EQ - Equals, LT - Less, LTE - Less or equals, GT - Greater, GTE - Greater or equals, IS NULL - Is null, IS NOT NULL - Is not null, LIKE - Match pattern (LIKE operator is only applicable to parameters of the string type). Wildcard characters: \&#39;%\&#39; - matches any number of characters, including no characters, \&#39;_\&#39; - matches exactly one character.\nHere is the sample query: the account_num GT \&#39;15\&#39; AND (name LIKE \&#39;start of name% end of name\&#39; OR status EQ \&#39;ACTIVE\&#39;).\n (optional)
     * @param r_sort Arranges search results in either ascending or descending order. By default, response results are sorted in the ascending order. To sort results in the descending order, use &quot;-&quot;. For example, the &quot;-name.&quot; value sorts the results in the descending order by name, and &quot;id&quot; sorts results in the ascending order by ID. (optional)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @param pageNumber The page number for multiple page queries. (optional, default to 1)
     * @param pageSize The page size for multiple page queries. Default maximum is 50. (optional, default to 50)
     * @param id The internal ID of the object. (optional)
     * @param name The name of the product tag. (optional)
     * @param productId The ID of the product. (optional)
     * @return List<GTVProductTag>
     * @throws Swagger.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper queryProductTags(
      Map<String, Object> params
    ) {
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('filter', (String) params.get('filter')));
      query.addAll(
        client.makeParam('sort', (List<String>) params.get('r_sort'), 'csv')
      );
      query.addAll(client.makeParam('return', (String) params.get('r_return')));
      query.addAll(
        client.makeParam('page_number', (Integer) params.get('pageNumber'))
      );
      query.addAll(
        client.makeParam('page_size', (Integer) params.get('pageSize'))
      );
      query.addAll(client.makeParam('id', (String) params.get('id')));
      query.addAll(client.makeParam('name', (String) params.get('name')));
      query.addAll(
        client.makeParam('product_id', (String) params.get('productId'))
      );

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/product-tags',
        '',
        query,
        form,
        new Map<String, Object>(),
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        List<RestAPI2Domain.GTVAPIProductTag>.class
      );
    }
  }

  public class GTVAPIProductRegisterTypeService {
    GTVAPIClient client;

    public GTVAPIProductRegisterTypeService(GTVAPIClient client) {
      this.client = client;
    }

    public GTVAPIProductRegisterTypeService() {
      this.client = new GTVAPIClient();
    }

    public GTVAPIClient getClient() {
      return this.client;
    }

    public GTVAPIRestClient.ResponseWrapper queryProductRegisterTypes(
      Map<String, Object> params
    ) {
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/product-register-types',
        '',
        query,
        form,
        new Map<String, Object>(),
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        List<RestAPI2Domain.GTVAPIProductRegisterType>.class
      );
    }
  }

  public class GTVAPIProductPriceGroupService {
    GTVAPIClient client;

    public GTVAPIProductPriceGroupService(GTVAPIClient client) {
      this.client = client;
    }

    public GTVAPIProductPriceGroupService() {
      this.client = new GTVAPIClient();
    }

    public GTVAPIClient getClient() {
      return this.client;
    }

    public GTVAPIRestClient.ResponseWrapper queryProductPriceGroups(
      Map<String, Object> params
    ) {
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('filter', (String) params.get('filter')));
      query.addAll(
        client.makeParam('sort', (List<String>) params.get('r_sort'), 'csv')
      );
      query.addAll(client.makeParam('return', (String) params.get('r_return')));
      query.addAll(
        client.makeParam('page_number', (Integer) params.get('pageNumber'))
      );
      query.addAll(
        client.makeParam('page_size', (Integer) params.get('pageSize'))
      );
      query.addAll(client.makeParam('id', (String) params.get('id')));
      query.addAll(client.makeParam('name', (String) params.get('name')));
      query.addAll(client.makeParam('code', (String) params.get('code')));
      query.addAll(client.makeParam('status', (String) params.get('status')));
      query.addAll(
        client.makeParam('is_global', (Boolean) params.get('isGlobal'))
      );

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/product-price-groups',
        '',
        query,
        form,
        new Map<String, Object>(),
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        List<RestAPI2Domain.GTVAPIProductPriceGroup>.class
      );
    }
  }

  public class GTVAPIProductCustomFieldService {
    GTVAPIClient client;

    public GTVAPIProductCustomFieldService(GTVAPIClient client) {
      this.client = client;
    }

    public GTVAPIProductCustomFieldService() {
      this.client = new GTVAPIClient();
    }

    public GTVAPIClient getClient() {
      return this.client;
    }

    /**
     * Get product custom fields
     * Uses query keys to retrieve a subset of existing product custom fields.
     * @param filter API query language string. The syntax of the API query language is similar to SQL, the criteria are expressed in the form of predicates.\nOn the left side of the equation, there is a name of the available query parameter (for example, billing_account_id). On the right side, there is a constant value in single quotes (\&#39;sample value\&#39;). Brackets are used to group predicates, for example, \&#39;(start_date GT \&#39;1994-01-24T23:33:07+00:00\&#39;)\&#39;. Use the following logical operators: AND - conjunction, OR - disjunction, NOT - negation. Compare operators: NEQ - Not equals, EQ - Equals, LT - Less, LTE - Less or equals, GT - Greater, GTE - Greater or equals, IS NULL - Is null, IS NOT NULL - Is not null, LIKE - Match pattern (LIKE operator is only applicable to parameters of the string type). Wildcard characters: \&#39;%\&#39; - matches any number of characters, including no characters, \&#39;_\&#39; - matches exactly one character.\nHere is the sample query: the account_num GT \&#39;15\&#39; AND (name LIKE \&#39;start of name% end of name\&#39; OR status EQ \&#39;ACTIVE\&#39;).\n (optional)
     * @param r_sort Arranges search results in either ascending or descending order. By default, response results are sorted in the ascending order. To sort results in the descending order, use &quot;-&quot;. For example, the &quot;-name.&quot; value sorts the results in the descending order by name, and &quot;id&quot; sorts results in the ascending order by ID. (optional)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @param pageNumber The page number for multiple page queries. (optional, default to 1)
     * @param pageSize The page size for multiple page queries. Default maximum is 50. (optional, default to 50)
     * @param id The internal ID of the object. (optional)
     * @param name The name of the custom field. (optional)
     * @param enabled The enabled property of the custom field. (optional)
     * @param searchable The searchable property of the custom field. (optional)
     * @return List<GTVProductCustomField>
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper queryProductCustomFields(
      Map<String, Object> params
    ) {
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('filter', (String) params.get('filter')));
      query.addAll(
        client.makeParam('sort', (List<String>) params.get('r_sort'), 'csv')
      );
      query.addAll(client.makeParam('return', (String) params.get('r_return')));
      query.addAll(
        client.makeParam('page_number', (Integer) params.get('pageNumber'))
      );
      query.addAll(
        client.makeParam('page_size', (Integer) params.get('pageSize'))
      );
      query.addAll(client.makeParam('id', (String) params.get('id')));
      query.addAll(client.makeParam('name', (String) params.get('name')));
      query.addAll(
        client.makeParam('enabled', (Boolean) params.get('enabled'))
      );
      query.addAll(
        client.makeParam('searchable', (Boolean) params.get('searchable'))
      );

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/product-custom-fields',
        '',
        query,
        form,
        new Map<String, Object>(),
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        List<RestAPI2Domain.GTVAPIProductCustomField>.class
      );
    }
  }

  public class GTVAPIProductCustomFieldValueService {
    GTVAPIClient client;

    public GTVAPIProductCustomFieldValueService(GTVAPIClient client) {
      this.client = client;
    }

    public GTVAPIProductCustomFieldValueService() {
      this.client = new GTVAPIClient();
    }

    public GTVAPIClient getClient() {
      return this.client;
    }

    public GTVAPIRestClient.ResponseWrapper queryProductCustomFieldValues(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('productId'), 'productId');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('filter', (String) params.get('filter')));
      query.addAll(
        client.makeParam('sort', (List<String>) params.get('r_sort'), 'csv')
      );
      query.addAll(client.makeParam('return', (String) params.get('r_return')));
      query.addAll(
        client.makeParam('page_number', (Integer) params.get('pageNumber'))
      );
      query.addAll(
        client.makeParam('page_size', (Integer) params.get('pageSize'))
      );
      query.addAll(client.makeParam('id', (String) params.get('id')));
      query.addAll(
        client.makeParam(
          'custom_field_value',
          (String) params.get('customFieldValue')
        )
      );
      query.addAll(
        client.makeParam(
          'custom_field_name',
          (String) params.get('customFieldName')
        )
      );
      query.addAll(
        client.makeParam(
          'custom_field_id',
          (String) params.get('customFieldId')
        )
      );

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/products/{product_id}/custom-field-values',
        '',
        query,
        form,
        new Map<String, Object>{
          'product_id' => (String) params.get('productId')
        },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        List<RestAPI2Domain.GTVAPIProductCustomFieldValue>.class
      );
    }

    /**
     * Create custom field value for product
     * Adds a custom field value to an existing custom field associated with the specified product ID.
     * @param productId The ID of the product. (required)
     * @param productCustomFieldValue A payload for creating the product custom field value. (required)
     * @param prefer The HTTP Prefer header per https://tools.ietf.org/html/rfc7240. The \&#39;return&#x3D;[representation|minimal]\&#39; preferences are the only implemented settings at the moment and are the same as \&#39;return&#x3D;SIMPLE\&#39;, and it indicates that the client wishes the server to return a minimal response to a successful request. The \&#39;return&#x3D;representation\&#39; preference in this header is the same as setting query parameter \&#39;return&#x3D;FULL\&#39;. (optional)
     * @return GTVProductCustomFieldValue
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper createProductCustomFieldValue(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('productId'), 'productId');
      client.assertNotNull(
        params.get('productCustomFieldValue'),
        'productCustomFieldValue'
      );
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'POST',
        '/products/{product_id}/custom-field-values',
        (RestAPI2Domain.GTVAPICreateProductCustomFieldValue) params.get(
          'productCustomFieldValue'
        ),
        query,
        form,
        new Map<String, Object>{
          'product_id' => (String) params.get('productId')
        },
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVProductCustomFieldValue.class
      );
    }
  }

  /*
   * TRACT Billing API
   * Create and manage billing accounts, products, orders, services, billing, invoicing, payments, and the general ledger. This microservice provides core functionality for the goTransverse billing platform.
   *
   * OpenAPI spec version: 2
   *
   *
   * NOTE: This class is auto generated by the GTVAPIRestClient code generator program.
   * https://github.com/GTVAPIRestClient-api/GTVAPIRestClient-codegen.git
   * Do not edit the class manually.
   */

  public class GTVAPIMarketplaceService {
    GTVAPIClient client;

    public GTVAPIMarketplaceService(GTVAPIClient client) {
      this.client = client;
    }

    public GTVAPIMarketplaceService() {
      this.client = new GTVAPIClient();
    }

    public GTVAPIClient getClient() {
      return this.client;
    }

    /**
     * Create marketplace
     * Creates a new marketplace.
     * @param createMarketplace The payload for creating a new marketplace. (required)
     * @param prefer The HTTP Prefer header per https://tools.ietf.org/html/rfc7240. The \&#39;return&#x3D;[representation|minimal]\&#39; preferences are the only implemented settings at the moment and are the same as \&#39;return&#x3D;SIMPLE\&#39;, and it indicates that the client wishes the server to return a minimal response to a successful request. The \&#39;return&#x3D;representation\&#39; preference in this header is the same as setting query parameter \&#39;return&#x3D;FULL\&#39;. (optional)
     * @return GTVAPIMarketplace
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper createMarketplace(
      Map<String, Object> params
    ) {
      client.assertNotNull(
        params.get('createMarketplace'),
        'createMarketplace'
      );
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'POST',
        '/marketplaces',
        (RestAPI2Domain.GTVAPICreateMarketplace) params.get(
          'createMarketplace'
        ),
        query,
        form,
        new Map<String, Object>(),
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIMarketplace.class
      );
    }
    /**
     * Associate price lists with marketplace
     * Associates existing price lists with the specified marketplace ID.
     * @param marketplaceId The ID of the marketplace. (required)
     * @param createPriceListRelation The payload for creating the association between a price list and a marketplace. (required)
     * @param prefer The HTTP Prefer header per https://tools.ietf.org/html/rfc7240. The \&#39;return&#x3D;[representation|minimal]\&#39; preferences are the only implemented settings at the moment and are the same as \&#39;return&#x3D;SIMPLE\&#39;, and it indicates that the client wishes the server to return a minimal response to a successful request. The \&#39;return&#x3D;representation\&#39; preference in this header is the same as setting query parameter \&#39;return&#x3D;FULL\&#39;. (optional)
     * @return GTVAPIPriceListRelation
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper createPriceListsToMarketplaceRelation(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('marketplaceId'), 'marketplaceId');
      client.assertNotNull(
        params.get('createPriceListRelation'),
        'createPriceListRelation'
      );
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'POST',
        '/marketplaces/{marketplace_id}/price-list-relations',
        (RestAPI2Domain.GTVAPICreatePriceListRelation) params.get(
          'createPriceListRelation'
        ),
        query,
        form,
        new Map<String, Object>{
          'marketplace_id' => (String) params.get('marketplaceId')
        },
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIPriceListRelation.class
      );
    }
    /**
     * Get marketplace by ID
     * Retrieves an existing marketplace associated with the specified ID.
     * @param id The internal ID of the object. (required)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @return GTVAPIMarketplace
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper getMarketplace(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('return', (String) params.get('r_return')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/marketplaces/{id}',
        '',
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIMarketplace.class
      );
    }
    /**
     * Get association between price list and marketplace by ID
     * Retrieves existing association between price list and marketplace by the specified marketplace and price list relation IDs.
     * @param marketplaceId The ID of the marketplace. (required)
     * @param id The internal ID of the object. (required)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @param expand Includes additional entities in the response. You can expand only those entities which have a specific extension for it. The primary value is a CSV of the available sub-entities. (optional)
     * @return GTVAPIPriceListRelation
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper getPriceListRelation(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('marketplaceId'), 'marketplaceId');
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('return', (String) params.get('r_return')));
      query.addAll(
        client.makeParam('expand', (List<String>) params.get('expand'), 'csv')
      );

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/marketplaces/{marketplace_id}/price-list-relations/{id}',
        '',
        query,
        form,
        new Map<String, Object>{
          'marketplace_id' => (String) params.get('marketplaceId'),
          'id' => (String) params.get('id')
        },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIPriceListRelation.class
      );
    }
    /**
     * Get price lists for marketplace
     * Uses query keys to retrieve price lists associated with the marketplace ID.
     * @param marketplaceId The ID of the marketplace. (required)
     * @param filter API query language string. The syntax of the API query language is similar to SQL, the criteria are expressed in the form of predicates.\nOn the left side of the equation, there is a name of the available query parameter (for example, billing_account_id). On the right side, there is a constant value in single quotes (\&#39;sample value\&#39;). Brackets are used to group predicates, for example, \&#39;(start_date GT \&#39;1994-01-24T23:33:07+00:00\&#39;)\&#39;. Use the following logical operators: AND - conjunction, OR - disjunction, NOT - negation. Compare operators: NEQ - Not equals, EQ - Equals, LT - Less, LTE - Less or equals, GT - Greater, GTE - Greater or equals, IS NULL - Is null, IS NOT NULL - Is not null, LIKE - Match pattern (LIKE operator is only applicable to parameters of the string type). Wildcard characters: \&#39;%\&#39; - matches any number of characters, including no characters, \&#39;_\&#39; - matches exactly one character.\nHere is the sample query: the account_num GT \&#39;15\&#39; AND (name LIKE \&#39;start of name% end of name\&#39; OR status EQ \&#39;ACTIVE\&#39;).\n (optional)
     * @param r_sort Arranges search results in either ascending or descending order. By default, response results are sorted in the ascending order. To sort results in the descending order, use &quot;-&quot;. For example, the &quot;-name.&quot; value sorts the results in the descending order by name, and &quot;id&quot; sorts results in the ascending order by ID. (optional)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @param expand Includes additional entities in the response. You can expand only those entities which have a specific extension for it. The primary value is a CSV of the available sub-entities. (optional)
     * @param pageNumber The page number for multiple page queries. (optional, default to 1)
     * @param pageSize The page size for multiple page queries. Default maximum is 50. (optional, default to 50)
     * @param id The internal ID of the object. (optional)
     * @param priceListId The ID of the product price list. (optional)
     * @param priceListName The name of the price list. (optional)
     * @return List<GTVAPIPriceListRelation>
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper queryMarketplacePriceLists(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('marketplaceId'), 'marketplaceId');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('filter', (String) params.get('filter')));
      query.addAll(
        client.makeParam('sort', (List<String>) params.get('r_sort'), 'csv')
      );
      query.addAll(client.makeParam('return', (String) params.get('r_return')));
      query.addAll(
        client.makeParam('expand', (List<String>) params.get('expand'), 'csv')
      );
      query.addAll(
        client.makeParam('page_number', (Integer) params.get('pageNumber'))
      );
      query.addAll(
        client.makeParam('page_size', (Integer) params.get('pageSize'))
      );
      query.addAll(client.makeParam('id', (String) params.get('id')));
      query.addAll(
        client.makeParam('price_list_id', (String) params.get('priceListId'))
      );
      query.addAll(
        client.makeParam(
          'price_list_name',
          (String) params.get('priceListName')
        )
      );

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/marketplaces/{marketplace_id}/price-list-relations',
        '',
        query,
        form,
        new Map<String, Object>{
          'marketplace_id' => (String) params.get('marketplaceId')
        },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        List<RestAPI2Domain.GTVAPIPriceListRelation>.class
      );
    }
    /**
     * Get marketplaces
     * Uses query keys to retrieve a subset of existing marketplaces.
     * @param filter API query language string. The syntax of the API query language is similar to SQL, the criteria are expressed in the form of predicates.\nOn the left side of the equation, there is a name of the available query parameter (for example, billing_account_id). On the right side, there is a constant value in single quotes (\&#39;sample value\&#39;). Brackets are used to group predicates, for example, \&#39;(start_date GT \&#39;1994-01-24T23:33:07+00:00\&#39;)\&#39;. Use the following logical operators: AND - conjunction, OR - disjunction, NOT - negation. Compare operators: NEQ - Not equals, EQ - Equals, LT - Less, LTE - Less or equals, GT - Greater, GTE - Greater or equals, IS NULL - Is null, IS NOT NULL - Is not null, LIKE - Match pattern (LIKE operator is only applicable to parameters of the string type). Wildcard characters: \&#39;%\&#39; - matches any number of characters, including no characters, \&#39;_\&#39; - matches exactly one character.\nHere is the sample query: the account_num GT \&#39;15\&#39; AND (name LIKE \&#39;start of name% end of name\&#39; OR status EQ \&#39;ACTIVE\&#39;).\n (optional)
     * @param r_sort Arranges search results in either ascending or descending order. By default, response results are sorted in the ascending order. To sort results in the descending order, use &quot;-&quot;. For example, the &quot;-name.&quot; value sorts the results in the descending order by name, and &quot;id&quot; sorts results in the ascending order by ID. (optional)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @param pageNumber The page number for multiple page queries. (optional, default to 1)
     * @param pageSize The page size for multiple page queries. Default maximum is 50. (optional, default to 50)
     * @param id The internal ID of the object. (optional)
     * @param name The name of the marketplace. (optional)
     * @param validFrom The date and time from when the resource is valid. (optional)
     * @param validTo The date and time until when the resource is valid. (optional)
     * @param priceListId The ID of the product price list. (optional)
     * @param priceListName The name of the price list. (optional)
     * @return List<GTVAPIMarketplace>
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper queryMarketplaces(
      Map<String, Object> params
    ) {
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('filter', (String) params.get('filter')));
      query.addAll(
        client.makeParam('sort', (List<String>) params.get('r_sort'), 'csv')
      );
      query.addAll(client.makeParam('return', (String) params.get('r_return')));
      query.addAll(
        client.makeParam('page_number', (Integer) params.get('pageNumber'))
      );
      query.addAll(
        client.makeParam('page_size', (Integer) params.get('pageSize'))
      );
      query.addAll(client.makeParam('id', (String) params.get('id')));
      query.addAll(client.makeParam('name', (String) params.get('name')));
      query.addAll(
        client.makeParam('valid_from', (Datetime) params.get('validFrom'))
      );
      query.addAll(
        client.makeParam('valid_to', (Datetime) params.get('validTo'))
      );
      query.addAll(
        client.makeParam('price_list_id', (String) params.get('priceListId'))
      );
      query.addAll(
        client.makeParam(
          'price_list_name',
          (String) params.get('priceListName')
        )
      );

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/marketplaces',
        '',
        query,
        form,
        new Map<String, Object>(),
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        List<RestAPI2Domain.GTVAPIMarketplace>.class
      );
    }
    /**
     * Delete marketplace
     * Deletes an existing marketplace associated with the specified ID.
     * @param id The internal ID of the object. (required)
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public void removeMarketplace(Map<String, Object> params) {
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      client.invoke(
        'DELETE',
        '/marketplaces/{id}',
        '',
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        null
      );
    }
    /**
     * Remove association between price list and marketplace
     * Removes the association between price list and marketplace by the associated marketplace and price list relation IDs.
     * @param marketplaceId The ID of the marketplace. (required)
     * @param id The internal ID of the object. (required)
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public void removePriceListRelation(Map<String, Object> params) {
      client.assertNotNull(params.get('marketplaceId'), 'marketplaceId');
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      client.invoke(
        'DELETE',
        '/marketplaces/{marketplace_id}/price-list-relations/{id}',
        '',
        query,
        form,
        new Map<String, Object>{
          'marketplace_id' => (String) params.get('marketplaceId'),
          'id' => (String) params.get('id')
        },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        null
      );
    }
    /**
     * Update marketplace
     * Updates an existing marketplace associated with the specified ID.
     * @param id The internal ID of the object. (required)
     * @param updateMarketplace The payload for updating the existing marketplace. (required)
     * @param prefer The HTTP Prefer header per https://tools.ietf.org/html/rfc7240. The \&#39;return&#x3D;[representation|minimal]\&#39; preferences are the only implemented settings at the moment and are the same as \&#39;return&#x3D;SIMPLE\&#39;, and it indicates that the client wishes the server to return a minimal response to a successful request. The \&#39;return&#x3D;representation\&#39; preference in this header is the same as setting query parameter \&#39;return&#x3D;FULL\&#39;. (optional)
     * @return GTVAPIMarketplace
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper updateMarketplace(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('id'), 'id');
      client.assertNotNull(
        params.get('updateMarketplace'),
        'updateMarketplace'
      );
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();
      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'PUT',
        '/marketplaces/{id}',
        (RestAPI2Domain.GTVAPIMarketplace) params.get('updateMarketplace'),
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>{ 'Prefer' => (String) params.get('prefer') },
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIMarketplace.class
      );
    }
  }

  /*
   * TRACT Billing API
   * Create and manage billing accounts, products, orders, services, billing, invoicing, payments, and the general ledger. This microservice provides core functionality for the goTransverse billing platform.
   *
   * OpenAPI spec version: 2
   *
   *
   * NOTE: This class is auto generated by the swagger code generator program.
   * https://github.com/swagger-api/swagger-codegen.git
   * Do not edit the class manually.
   */

  public class GTVAPIProductPriceService {
    GTVAPIClient client;

    public GTVAPIProductPriceService(GTVAPIClient client) {
      this.client = client;
    }

    public GTVAPIProductPriceService() {
      this.client = new GTVAPIClient();
    }

    public GTVAPIClient getClient() {
      return this.client;
    }

    /**
     * Deprecated. Get product prices
     * Deprecated. Uses query keys to retrieve a subset of existing product prices. If you have added the product ID as a query parameter but haven\&#39;t specified the ID of the desired product price group, the response will contain only the discount codes of the Default price list and not all price lists.
     * @param filter API query language string. The syntax of the API query language is similar to SQL, the criteria are expressed in the form of predicates.\nOn the left side of the equation, there is a name of the available query parameter (for example, billing_account_id). On the right side, there is a constant value in single quotes (\&#39;sample value\&#39;). Brackets are used to group predicates, for example, \&#39;(start_date GT \&#39;1994-01-24T23:33:07+00:00\&#39;)\&#39;. Use the following logical operators: AND - conjunction, OR - disjunction, NOT - negation. Compare operators: NEQ - Not equals, EQ - Equals, LT - Less, LTE - Less or equals, GT - Greater, GTE - Greater or equals, IS NULL - Is null, IS NOT NULL - Is not null, LIKE - Match pattern (LIKE operator is only applicable to parameters of the string type). Wildcard characters: \&#39;%\&#39; - matches any number of characters, including no characters, \&#39;_\&#39; - matches exactly one character.\nHere is the sample query: the account_num GT \&#39;15\&#39; AND (name LIKE \&#39;start of name% end of name\&#39; OR status EQ \&#39;ACTIVE\&#39;).\n (optional)
     * @param r_sort Arranges search results in either ascending or descending order. By default, response results are sorted in the ascending order. To sort results in the descending order, use &quot;-&quot;. For example, the &quot;-name.&quot; value sorts the results in the descending order by name, and &quot;id&quot; sorts results in the ascending order by ID. (optional)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @param pageNumber The page number for multiple page queries. (optional, default to 1)
     * @param pageSize The page size for multiple page queries. Default maximum is 50. (optional, default to 50)
     * @param id The internal ID of the object. (optional)
     * @param productId The ID of the product. (optional)
     * @param productName The name of the product. (optional)
     * @param productSku The stock keeping unit (SKU) for the product. (optional)
     * @param externalProductNumber (unique_key) The external product number. (optional)
     * @param validFrom The date and time from when the resource is valid. (optional)
     * @param validTo The date and time until when the resource is valid. (optional)
     * @param priceListId The ID of the product price list. (optional)
     * @param productPriceType Indicates the type of the product price. (optional)
     * @param recurrencePeriod The recurring product price for the recurrence period. (optional)
     * @param recurrenceAmount The amount of money charged for the recurrence period. (optional)
     * @param recurringPaymentRequired Specifies whether a recurring payment for this product is required. (optional)
     * @param billInAdvance Specifies whether the invoice is sent in advance. (optional)
     * @param proratedOnCancel Specifies whether the recurring product price is prorated upon cancellation. (optional)
     * @param proratedOnOrder Specifies whether the recurring product price is prorated upon ordering. (optional)
     * @param proratedOnOrderNoCharge Specifies whether the recurring product price is prorated upon ordering. The prorated amount is the amount for the remainder of the current billing cycle but the customer is not charged with it, because there is no charge. The amount is tracked for accounting and reporting purposes. (optional)
     * @param chargeDuringRenewal Specifies whether a customer is charged the one-time price when the agreement is renewed. (optional)
     * @param currencyCode The currency code for the amount. (optional)
     * @return List<GTVProductPrice>
     * @throws Swagger.ApiException if fails to make API call
     */

    public GTVAPIRestClient.ResponseWrapper queryProductPrices(
      Map<String, Object> params
    ) {
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('filter', (String) params.get('filter')));
      query.addAll(
        client.makeParam('sort', (List<String>) params.get('r_sort'), 'csv')
      );
      query.addAll(client.makeParam('return', (String) params.get('r_return')));
      query.addAll(
        client.makeParam('page_number', (Integer) params.get('pageNumber'))
      );
      query.addAll(
        client.makeParam('page_size', (Integer) params.get('pageSize'))
      );
      query.addAll(client.makeParam('id', (String) params.get('id')));
      query.addAll(
        client.makeParam('product_id', (String) params.get('productId'))
      );
      query.addAll(
        client.makeParam('product_name', (String) params.get('productName'))
      );
      query.addAll(
        client.makeParam('product_sku', (String) params.get('productSku'))
      );
      query.addAll(
        client.makeParam(
          'external_product_number',
          (String) params.get('externalProductNumber')
        )
      );
      query.addAll(
        client.makeParam('valid_from', (Datetime) params.get('validFrom'))
      );
      query.addAll(
        client.makeParam('valid_to', (Datetime) params.get('validTo'))
      );
      query.addAll(
        client.makeParam('price_list_id', (String) params.get('priceListId'))
      );
      query.addAll(
        client.makeParam(
          'product_price_type',
          (String) params.get('productPriceType')
        )
      );
      query.addAll(
        client.makeParam(
          'recurrence_period',
          (String) params.get('recurrencePeriod')
        )
      );
      query.addAll(
        client.makeParam(
          'recurrence_amount',
          (Double) params.get('recurrenceAmount')
        )
      );
      query.addAll(
        client.makeParam(
          'recurring_payment_required',
          (Boolean) params.get('recurringPaymentRequired')
        )
      );
      query.addAll(
        client.makeParam(
          'bill_in_advance',
          (Boolean) params.get('billInAdvance')
        )
      );
      query.addAll(
        client.makeParam(
          'prorated_on_cancel',
          (Boolean) params.get('proratedOnCancel')
        )
      );
      query.addAll(
        client.makeParam(
          'prorated_on_order',
          (Boolean) params.get('proratedOnOrder')
        )
      );
      query.addAll(
        client.makeParam(
          'prorated_on_order_no_charge',
          (Boolean) params.get('proratedOnOrderNoCharge')
        )
      );
      query.addAll(
        client.makeParam(
          'charge_during_renewal',
          (Boolean) params.get('chargeDuringRenewal')
        )
      );
      query.addAll(
        client.makeParam('currency_code', (String) params.get('currencyCode'))
      );

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/product-prices',
        '',
        query,
        form,
        new Map<String, Object>(),
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        List<RestAPI2Domain.GTVAPIProductPrice>.class
      );
    }
  }

  /*
   * TRACT Billing API
   * Create and manage billing accounts, products, orders, services, billing, invoicing, payments, and the general ledger. This microservice provides core functionality for the goTransverse billing platform.
   *
   * OpenAPI spec version: 2
   *
   *
   * NOTE: This class is auto generated by the swagger code generator program.
   * https://github.com/swagger-api/swagger-codegen.git
   * Do not edit the class manually.
   */

  public class GTVAPIDiscountResourceService {
    GTVAPIClient client;

    public GTVAPIDiscountResourceService(GTVAPIClient client) {
      this.client = client;
    }

    public GTVAPIDiscountResourceService() {
      this.client = new GTVAPIClient();
    }

    public GTVAPIClient getClient() {
      return this.client;
    }

    /**
     * Get discount resource by ID
     * Retrieves an existing discount resource associated with the specified ID.
     * @param id The internal ID of the object. (required)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @return GTVDiscountResource
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper getDiscountResource(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('id'), 'id');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('return', (String) params.get('r_return')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/discount-resources/{id}',
        '',
        query,
        form,
        new Map<String, Object>{ 'id' => (String) params.get('id') },
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIDiscountResource.class
      );
    }

    /**
     * Get discount resources
     * Uses query keys to retrieve a subset of existing discount resources.
     * @param filter API query language string. The syntax of the API query language is similar to SQL, the criteria are expressed in the form of predicates.\nOn the left side of the equation, there is a name of the available query parameter (for example, billing_account_id). On the right side, there is a constant value in single quotes (\&#39;sample value\&#39;). Brackets are used to group predicates, for example, \&#39;(start_date GT \&#39;1994-01-24T23:33:07+00:00\&#39;)\&#39;. Use the following logical operators: AND - conjunction, OR - disjunction, NOT - negation. Compare operators: NEQ - Not equals, EQ - Equals, LT - Less, LTE - Less or equals, GT - Greater, GTE - Greater or equals, IS NULL - Is null, IS NOT NULL - Is not null, LIKE - Match pattern (LIKE operator is only applicable to parameters of the string type). Wildcard characters: \&#39;%\&#39; - matches any number of characters, including no characters, \&#39;_\&#39; - matches exactly one character.\nHere is the sample query: the account_num GT \&#39;15\&#39; AND (name LIKE \&#39;start of name% end of name\&#39; OR status EQ \&#39;ACTIVE\&#39;).\n (optional)
     * @param r_sort Arranges search results in either ascending or descending order. By default, response results are sorted in the ascending order. To sort results in the descending order, use &quot;-&quot;. For example, the &quot;-name.&quot; value sorts the results in the descending order by name, and &quot;id&quot; sorts results in the ascending order by ID. (optional)
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @param pageNumber The page number for multiple page queries. (optional, default to 1)
     * @param pageSize The page size for multiple page queries. Default maximum is 50. (optional, default to 50)
     * @param id The internal ID of the object. (optional)
     * @param identifier The identifier of the service or discount resource. (optional)
     * @param orderItemId The ID of the order item entity. (optional)
     * @param status The discount resource status. (optional, default to REQUESTED)
     * @param unlimited Specifies whether the discount code is unlimited. (optional)
     * @param r_limit The amount of limit in the discount resource if any. (optional)
     * @param discountCodeId The ID of the discount code. (optional)
     * @param discountId The ID of the discount. (optional)
     * @return List<GTVDiscountResource>
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */

    public GTVAPIRestClient.ResponseWrapper queryDiscountResources(
      Map<String, Object> params
    ) {
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('filter', (String) params.get('filter')));
      query.addAll(
        client.makeParam('sort', (List<String>) params.get('r_sort'), 'csv')
      );
      query.addAll(client.makeParam('return', (String) params.get('r_return')));
      query.addAll(
        client.makeParam('page_number', (Integer) params.get('pageNumber'))
      );
      query.addAll(
        client.makeParam('page_size', (Integer) params.get('pageSize'))
      );
      query.addAll(client.makeParam('id', (String) params.get('id')));
      query.addAll(
        client.makeParam('identifier', (String) params.get('identifier'))
      );
      query.addAll(
        client.makeParam('order_item_id', (String) params.get('orderItemId'))
      );
      query.addAll(client.makeParam('status', (String) params.get('status')));
      query.addAll(
        client.makeParam('unlimited', (Boolean) params.get('unlimited'))
      );
      query.addAll(client.makeParam('limit', (Integer) params.get('r_limit')));
      query.addAll(
        client.makeParam(
          'discount_code_id',
          (String) params.get('discountCodeId')
        )
      );
      query.addAll(
        client.makeParam('discount_id', (String) params.get('discountId'))
      );

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'GET',
        '/discount-resources',
        '',
        query,
        form,
        new Map<String, Object>(),
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        List<RestAPI2Domain.GTVAPIDiscountResource>.class
      );
    }
  }

  /*
   * TRACT Billing API
   * Create and manage billing accounts, products, orders, services, billing, invoicing, payments, and the general ledger. This microservice provides core functionality for the goTransverse billing platform.
   *
   * OpenAPI spec version: 2
   *
   *
   * NOTE: This class is auto generated by the swagger code generator program.
   * https://github.com/swagger-api/swagger-codegen.git
   * Do not edit the class manually.
   */

  public class GTVAPICreatePaymentService {
    GTVAPIClient client;

    public GTVAPICreatePaymentService(GTVAPIClient client) {
      this.client = client;
    }

    public GTVAPICreatePaymentService() {
      this.client = new GTVAPIClient();
    }

    public GTVAPIClient getClient() {
      return this.client;
    }

    /**
     * @param getRefererToken The input url
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @return GTVAPIGetPaymentRefererToken
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper getPaymentRefererToken(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('getRefererToken'), 'getRefererToken');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('return', (String) params.get('r_return')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'POST',
        '/payments/generate-token',
        (RestAPI2Domain.GTVAPIPaymentRefererToken) params.get(
          'getRefererToken'
        ),
        query,
        form,
        new Map<String, Object>{},
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIGetPaymentRefererToken.class
      );
    }

    /**
     * @param getRefererToken The input url
     * @param r_return Specifies the amount of detail to provide in a response, it may be SIMPLE or FULL. SIMPLE is the same as setting the Prefer header parameter to \&#39;return&#x3D;minimal\&#39;, and FULL is the same as the header parameter set to \&#39;return&#x3D;representation\&#39;. (optional, default to FULL)
     * @return GTVAPIGetPaymentRefererToken
     * @throws GTVAPIRestClient.ApiException if fails to make API call
     */
    public GTVAPIRestClient.ResponseWrapper getPaymentToken(
      Map<String, Object> params
    ) {
      client.assertNotNull(params.get('getPaymentToken'), 'getPaymentToken');
      List<GTVAPIRestClient.Param> query = new List<GTVAPIRestClient.Param>();

      // cast query params to verify their expected type
      query.addAll(client.makeParam('return', (String) params.get('r_return')));

      List<GTVAPIRestClient.Param> form = new List<GTVAPIRestClient.Param>();

      return (GTVAPIRestClient.ResponseWrapper) client.invoke(
        'POST',
        '/t/s/p/1.0/hosted-payment/reference-cc-payment-method',
        (RestAPI2Domain.GTVAPICreatePaymentMethod) params.get(
          'getPaymentToken'
        ),
        query,
        form,
        new Map<String, Object>{},
        new Map<String, Object>(),
        new List<String>{ 'application/json' },
        new List<String>{ 'application/json' },
        new List<String>{ 'x-api-key', 'bearer' },
        RestAPI2Domain.GTVAPIGetPaymentMethodResponse.class
      );
    }
  }
}