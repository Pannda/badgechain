# BadgeChain API documentation version 1.0
---

## /issuers

### /issuers

* **get**: Returns a list of all Issuer Organizations.
* **post**: Added a new Issuer Organization

### /issuers/{id}

* **get**: Returns an Issuer Organization by ID.
* **put**: Updates an Issuer Organization by ID.
* **delete**: Deletes an Issuer Organization by ID.

### /issuers/{id}/badges

* **get**: Returns a list of all BadgeClass.
* **post**: Added a new BadgeClass

### /issuers/{id}/badges/{id}

* **get**: Returns the a BadgeClass with the appropriate ID.
* **put**: Updates a BadgeClasses of the given ID.
* **delete**: Deletes a BadgeClasses with the given ID.

### /issuers/{id}/badges/{id}/assertions

* **get**: Returns a list of all Assertions.
* **post**: Added a new Assertion

### /issuers/{id}/badges/{id}/assertions/{uid}

* **get**: Returns the an Assertion with the appropriate ID.
* **put**: Updates a Assertion of the given ID.
* **delete**: Deletes an Assertion with the given ID.

