# BadgeChain API documentation version 1.0

## Use Cases




## /accounts

### /accounts

* **get**: Returns a collection of all Accounts.
* **post**: Added a new Issuer Organization

### /accounts/{eth-hash}

* **get**: Returns an Account by the given Ethereum Account Hash.
* **put**: Updates an Account by the given Ethereum Account Hash.
* **delete**: Deletes an Account by the given Ethereum Account Hash.

## /issuers

### /issuers

* **get**: Returns a collection of all IssuerOrganizations.
* **post**: Added a new IssuerOrganization

### /issuers/{id}

* **get**: Returns an IssuerOrganization by ID.
* **put**: Updates an IssuerOrganization by ID.
* **delete**: Deletes an IssuerOrganization by ID.

### /issuers/{id}/badges

* **get**: Returns a collection of all BadgeClasses belonging to the given IssuerOrganization ID.
* **post**: Added a new BadgeClass associated with the given IssuerOrganization ID.

### /issuers/{id}/badges/{id}

* **get**: Returns the a BadgeClass with the appropriate ID.
* **put**: Updates a BadgeClasses of the given ID.
* **delete**: Deletes a BadgeClasses with the given ID.

### /issuers/{id}/badges/{id}/assertions

* **get**: Returns a collection of all Assertions belonging to the given BadgeClass and IssuerOrganization.
* **post**: Added a new Assertion associated with the given BadgeClass and IssuerOrganization.

### /issuers/{id}/badges/{id}/assertions/{uid}

* **get**: Returns an Assertion with the appropriate UID.
* **put**: Updates an Assertion of the given UID.
* **delete**: Deletes an Assertion with the given UID.

