Feature: ReqRes /api/login - User Login API Testing


  Background:
    * url baseUrl
    * headers headers

    @login-success
  Scenario: Successful login with valid credentials
     Given path 'login'
     And request { email: 'eve.holt@reqres.in', password: 'cityslicka' }
     When method post
     Then status 200
     And match response.token == '#string'
     And assert responseTime < 2000
    # Store token in a variable for later use
    # * def authToken = response.token
    # * print 'Auth token:', authToken
    # * karate.set('authToken', authToken)
    # * print 'Global authToken:', karate.get('authToken')  

    @login-invalid
    Scenario: Login fails with invalid credentials
    Given path 'login'
    And request { email: 'InValidEmail@reqres.in', password: 'InValidPassword' }
    When method post
    * def status = responseStatus
    * print 'Response status:', status
    * assert status == 400
    And match response.error == 'user not found'
    * print 'Response Time:', responseTime
    And assert responseTime < 2000

    @login-missing-email
    Scenario: Login fails when email is missing
    Given path 'login'
    And request { password: 'cityslicka' }
    When method post
    * def status = responseStatus
    * print 'Response status:', status
    * print 'Response error:', response.error
    Then status 400
    And match response.error == 'Missing email or username'
    And assert responseTime < 2000

    @login-password-missing
    Scenario: Login fails when password is missing
    Given path 'login'
    And request { email: 'eve.holt@reqres.in' }
    When method post
    * def status = responseStatus
    * print 'Response status:', status
    * print 'Response error:', response.error
    Then status 400
    And match response.error == 'Missing password'
    And assert responseTime < 2000