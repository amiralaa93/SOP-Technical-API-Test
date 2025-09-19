# SOP Technical API Test Automation (KarateDSL)

This project contains automated API test scenarios for the [Reqres API](https://reqres.in/), implemented using **[Karate DSL](https://github.com/karatelabs/karate)**.  
The goal is to validate authentication, user management, pagination, delayed responses, and chained requests.  

> **Important:** All requests must include the header:  
> `x-api-key: reqres-free-v1`

---

## 🔧 Tech Stack
- **Language/Framework**: Karate DSL (API & E2E testing framework)  
- **Build Tool**: Maven / Gradle  
- **Test Runner**: JUnit 5  

---

## 📌 Test Scenarios  

### 1. Login API – `/api/login`
**Objective:** Validate user authentication.  
- ✅ Successful login with valid credentials  
- ❌ Failed login with invalid credentials  
- ❌ Missing required fields (email or password)  
- 🔍 Verify status codes and error messages  

**Example request:**
```json
{
  "email": "eve.holt@reqres.in",
  "password": "cityslicka"
}
```

### 2. Get User Details API – `/api/users/2`
**Objective:** Validate response structure and user details.  
- ✅ GET user with ID 2 returns correct data
- 🔍 Verify required fields (id, email, first_name, last_name, avatar)
- 🔍 Validate response status code and content-type

### 3. Create User API – `/api/users`
**Objective:** Validate user creation with valid and invalid inputs.  
- ✅ POST with valid name & job returns expected response
- ❌ Handle invalid/missing input fields
- 🔍 Validate response contains id and createdAt

**Example request:**
```json
{
  "name": "John",
  "job": "developer"
}
```

### 4. Pagination Validation – `/api/users?page=2`
**Objective:** Validate pagination behavior.  
- ✅ Correct number of users returned
- 🔍 Validate page, per_page, total, and total_pages values
- 🔍 Ensure page 1 and page 2 users are unique

### 5. Delayed Response Validation – `/api/users?delay=<number>`
**Objective:** Validate API behavior under delayed response.  
- 🔍 Verify response time handling
- 🔍 Ensure response structure remains correct 
- 🔍 Verify status codes and error messages  

### 6. Chained Requests
**Objective:** Fetch a list of users then retrieve detailed information about one of those users.
- ✅ GET list of users
- ✅ Select a user and GET /api/users/{id}
- 🔍 Validate consistency between list response and individual user details
- ♻️ Implement reusable test utilities

---

## 🚀 How to Run Tests
- **Using Maven**: mvn test -Dtest=TestRunner
- **Using IDE**: From TestRunner class → Run
---

## 📊 Deliverables

- ✅ Karate feature files covering all scenarios.
- ✅ Validations for positive and negative cases.
- ✅ Reusable test setup and clean assertions.
- ✅ Executable test suite via Maven.
- ✅ CI/CD with GitHub Actions

---

## 📌 Notes
- Uses modular and reusable feature files for maintainability.
- Tests are **independent and re-runnable**.  
- Validations cover **status codes**, **headers**, **response times**, and **JSON schema/content..**  

---