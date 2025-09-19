Feature: ReqRes /api/users - User Management Tests


  Background:
    * url baseUrl
    * headers headers

    @getUserDetails
  Scenario: Get details of user with ID 2
    Given path 'users', 2
    When method get
    Then status 200
    * print 'Response:', response
    And match response.data.id == 2
    And match response.data.email == 'janet.weaver@reqres.in'
    And match response.data.first_name == 'Janet'
    And match response.data.last_name == 'Weaver'
    And match response.data.avatar == '#string'
    # Validate support object exists
    And match response.support.url == '#string'
    And match response.support.text == '#string'
    * assert responseTime < 2000


    @createUser
  Scenario: Create a new user with name and job
    Given path 'users'
    And request { name: 'John', job: 'developer' }
    When method post
    * def status = responseStatus
    * print 'Response status:', status
    Then status 201
    * print 'Response:', response
    And match response.name == 'John'
    And match response.job == 'developer'
    And match response.id == '#string'
    And match response.createdAt == '#string'
    * assert responseTime < 2000

    @pagination-validation
  Scenario: Validate pagination on user list
    Given path 'users'
    And param page = 2
    When method get
    * def status = responseStatus
    * print 'Response status:', status
    Then status 200
    * print 'Response:', response
    And match response.page == 2
    And match response.per_page == 6
    And match response.total == 12
    And match response.total_pages == 2
    And match response.data == '#[]'
    * assert response.data.length == 6
    * assert responseTime < 2000

    @delayed-response
  Scenario: Validate delayed response with delay parameter
    Given path 'users'
    And param delay = 4
    When method get
    * def status = responseStatus
    Then status 200
    * print 'Response time (ms):', responseTime
    * assert responseTime >= 4000
    * assert responseTime < 6000