Feature: ReqRes /api/users - Chained Requests


  Background:
    * url baseUrl
    * configure headers = headers

    @chainedRequests
  Scenario: Fetch user list from page 1 and get details of the first user
    # Step 1: Get user list from page 1
    Given path 'users'
    And param page = 1
    When method get
    Then status 200
    * print 'Users List in Page 1:', response
    And match response.page == 1
    And match response.per_page == 6

    # Step 2: Extract the ID of the first user
    * def userId = response.data[0].id
    * print 'Selected UserId:', userId

    # Step 3: Get details of the user with the extracted ID
    Given path 'users', userId
    When method get
    Then status 200
    * print 'User Details:', response
    And match response.data.id == userId
    And match response.data.email == 'george.bluth@reqres.in'
    And match response.data.first_name == 'George'
    And match response.data.last_name == 'Bluth'
    And match response.data.avatar == '#string'
    And match response.support.url == '#string'
    And match response.support.text == '#string'
    * assert responseTime < 10000
