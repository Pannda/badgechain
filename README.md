## Open Badges Specification

### Table of Contents

- [Badge Objects](#badge-objects)
    - [Assertion](#assertion)
        - [Example](#assertion-example)
    - [BadgeClass](#badge-class)
        - [Example](#badge-class-example)
    - [IssuerOrganization](#issuer-organization)
        - [Example](#issuer-organization-example) 
- [Helper Objects](#helper-objects)
    - [Alignment Object](#alignment-object)
    - [Identity Object](#identity-object)
    - [Verification Object](#verification-object)
- [Extensions](#extensions)
- [Signed Badges](#signed-badges)
    - [Header](#header)
    - [Claims](#claims)
    - [Signature](#signature)
- [Revocation List](#revocation-list)
- [Validation](#validation)
    - [Type Validation](#type-validation)
    - [Frame Validation](#frame-validation)
- [Miscellaneous](#miscellaneous)
    - [Data Type Primitives](#data-type-primitives)

### Badge Objects

#### Assertion

Assertions are representations of an awarded badge, used to share information about a badge belonging to one earner.

| Property | Expected Type | Description |
|:--|:-:|:--|
| **@context** | JSON-LD Context | [https://w3id.org/openbadges/v1](https://w3id.org/openbadges/v1) or valid JSON-LD context array or object including the 1.1 Open Badges Context.
| id | URL | Unique IRI for the Assertion. If using hosted verification, this should be the URL where the assertion is accessible. |
| **type** | JSON-LD type | A valid JSON-LD representation of the Assertion type. In most cases, this will simply be the string Assertion. An array including Assertion and other string elements that are either URLs or compact IRIs within the current context are allowed. |
| **uid** | Text | Unique Identifier for the badge. This is expected to be *locally* unique on a per-origin basis, not globally unique. |
| **recipient** | [IdentityObject](#identity-object) | The recipient of the achievement. |
| **badge** | URL | URL that describes the type of badge being awarded. The endpoint should be a [BadgeClass](). |
| **verify** | [VerificationObject](#verification-object) | Instructions for third parties to verify this assertion. |
| **issuedOn** | [DateTime](#date-time-type) | Date that the achievement was awarded. |
| image | URL | A URL of an image representing this user’s achievement. This must be a PNG or SVG image, and should be prepared via the [Baking specification](http://specification.openbadges.org/baking/). An ‘unbaked’ image for the badge is defined in the [BadgeClass](#badge-class). |
| evidence | URL | A URL of the work that the recipient did to earn the achievement. This can be a page that links out to other pages if linking directly to the work is infeasible. |
| expires | [DateTime](#date-time-type) | If the achievement has some notion of expiry, this indicates a date when a badge should no longer be considered valid. |

<h5 id="assertion-example">Example</h5>

```json
{
  "@context": "https://w3id.org/openbadges/v1",
  "type": "Assertion",
  "id": "https://example.org/beths-robotics-badge.json",
  "uid": "f2c20",
  "recipient": {
    "type": "email",
    "hashed": true,
    "salt": "deadsea",
    "identity": "sha256$c7ef86405ba71b85acd8e2e95166c4b111448089f2e1599f42fe1bba46e865c5"
  },
  "image": "https://example.org/beths-robot-badge.png",
  "evidence": "https://example.org/beths-robot-work.html",
  "issuedOn": 1359217910,
  "expires": 1609458300,
  "badge": "https://example.org/robotics-badge.json",
  "verify": {
    "type": "hosted",
    "url": "https://example.org/beths-robotics-badge.json"
  }
}
```

#### Badge Class

A collection of information about the accomplishment recognized by the Open Badge. Many assertions may be created corresponding to one BadgeClass.

| Property | Expected Type | Description |
|:--|:-:|:--|
| **@context** | JSON-LD Context | [https://w3id.org/openbadges/v1](https://w3id.org/openbadges/v1) or valid JSON-LD context array or object including the 1.1 Open Badges Context |
| **id** | URL | Unique IRI for the BadgeClass, the URL where it is published. |
| **type** | JSON-LD type | valid JSON-LD representation of the **BadgeClass** type. In most cases, this will simply be the string BadgeClass. An array including **BadgeClass** and other string elements that are either URLs or compact IRIs within the current context are allowed. |
| **name** | Text | The name of the achievement. |
| **description** | Text | A short description of the achievement. |
| **image** | [Date URI](http://en.wikipedia.org/wiki/Data_URI_scheme) or URL | A URL of an image representing the achievement. |
| **criteria** | URL | URL of the criteria for earning the achievement. If the badge represents an educational achievement, consider marking up this up with [LRMI](http://lrmi.dublincore.net/). |
| **issuer** | URL | URL of the organization that issued the badge. Endpoint should be an [IssuerOrganization](#issuer-organization). |
| alignment | Array of [AlignmentObjects](#alignment-object) | List of objects describing which educational standards this badge aligns to, if any. |
| tags | Array of Text | List of tags that describe the type of achievement. |

<h5 id="badge-class-example">Example</h5>

```json
{
  "@context": "https://w3id.org/openbadges/v1",
  "type": "BadgeClass",
  "id": "https://example.org/robotics-badge.json",
  "name": "Awesome Robotics Badge",
  "description": "For doing awesome things with robots that people think is pretty great.",
  "image": "https://example.org/robotics-badge.png",
  "criteria": "https://example.org/robotics-badge.html",
  "tags": ["robots", "awesome"],
  "issuer": "https://example.org/organization.json",
  "alignment": [
    { "name": "CCSS.ELA-Literacy.RST.11-12.3",
      "url": "http://www.corestandards.org/ELA-Literacy/RST/11-12/3",
      "description": "Follow precisely a complex multistep procedure when 
      carrying out experiments, taking measurements, or performing technical 
      tasks; analyze the specific results based on explanations in the text."
    },
    { "name": "CCSS.ELA-Literacy.RST.11-12.9",
      "url": "http://www.corestandards.org/ELA-Literacy/RST/11-12/9",
      "description": " Synthesize information from a range of sources (e.g.,
      texts, experiments, simulations) into a coherent understanding of a
      process, phenomenon, or concept, resolving conflicting information when
      possible."
    }
  ]
}
```

#### Issuer Organization

A collection of information about the entity or organization issuing the Open Badge. Each issuer may correspond to many BadgeClasses. Anyone can create and host an Issuer file to start issuing Open Badges.

| Property | Expected Type | Description |
|:--|:-:|:--|
| **@context** | JSON-LD Context | [https://w3id.org/openbadges/v1](https://w3id.org/openbadges/v1) or valid JSON-LD context array or object including the 1.1 Open Badges Context |
| **id** | URL | Unique IRI for the IssuerOrganization file. |
| **type** | JSON-LD type | valid JSON-LD representation of the **IssuerOrg.** type. In most cases, this will simply be the string BadgeClass. An array including **IssuerOrg.** and other string elements that are either URLs or compact IRIs within the current context are allowed. |
| **name** | Text | The name of the issuing organization. |
| **url** | URL | URL of the institution |
| description | Text | A short description of the institution |
| image | [Data URI](http://en.wikipedia.org/wiki/Data_URI_scheme) or URL | An image representing the institution |
| email | Text | Contact address for someone at the organization. |
| revocationList | URL | URL of the Badge Revocation List. The endpoint should be a JSON representation of an object where the keys are the uid or id of a revoked badge assertion, and the values are the reason for revocation. It is only recommended that signed badge issuers use this method when they have revoked at least one badge. |

<h5 id="issuer-organization-example">Example</h5>

```json
{
  "@context": "https://w3id.org/openbadges/v1",
  "type": "Issuer",
  "id": "https://example.org/organization.json",
  "name": "An Example Badge Issuer",
  "image": "https://example.org/logo.png",
  "url": "https://example.org",
  "email": "steved@example.org",
  "revocationList": "https://example.org/revoked.json"
}
```

### Helper Objects

#### Alignment Object

A collection of information about the educational standards of the badge to which they are assigned.

| Property | Expected Type | Description |
|:--|:-:|:--|
| **name** | Text | Name of alignment. |
| **url** | URL | URL linking to the official description of the standard. |
| description | Text | Short description of the standard |

#### Identity Object

A collection of information about the recipient of a badge.

| Property | Expected Type | Description |
|:--|:-:|:--|
| **identity** | [IdentityHash](#identity-hash) or Text | Either the hash of the identity or the plaintext value. If it’s possible that the plaintext transmission and storage of the identity value would leak personally identifiable information where there is an expectation of privacy, it is strongly recommended that an IdentityHash be used. |
| **type** | [IdentityType](#identity-type) | The type of identity. |
| **hashed** | Boolean | Whether or not the **identity** value is hashed. |
| salt | Text | If the recipient is hashed, this should contain the string used to salt the hash. If this value is not provided, it should be assumed that the hash was not salted. |

#### Verification Object

A collection of information allowing a consumer to authenticate the Assertion.

| Property | Expected Type | Description |
|:--|:-:|:--|
| **type** | [VerificationType](#verification-type) | The type of verification method. |
| **url** | URL | If the type is “hosted”, this should be a URL pointing to the assertion on the issuer’s server. If the type is “signed”, this should be a link to the issuer’s public key. |

### Extensions

For examples of Badge Object Extensions and community-developed extensions ready for implementation, see the [Extensions page](http://specification.openbadges.org/extensions/#ExampleExtension).

### Signed Badges

A JSON Web Signature (JWS) for a signed badge looks like the following. (Space has been added here around the . separators for clarity.)

```text
eyJhbGciOiJSUzI1NiJ9
.
eyJ1aWQiOiJhYmMtMTIzNCIsInJlY2lwaWVudCI6eyJ0eXBlIjoiZW1haWwiLCJoYXNoZWQiOnRydWUsInNhbHQiOiJkZWFkc2VhIiwiaWQiOiJzaGEyNTYkYzdlZjg2NDA1YmE3MWI4NWFjZDhlMmU5NTE2NmM0YjExMTQ0ODA4OWYyZTE1OTlmNDJmZTFiYmE0NmU4NjVjNSJ9LCJpbWFnZSI6Imh0dHBzOi8vZXhhbXBsZS5vcmcvYmV0aHMtcm9ib3QtYmFkZ2UucG5nIiwiZXZpZGVuY2UiOiJodHRwczovL2V4YW1wbGUub3JnL2JldGhzLXJvYm90LXdvcmsuaHRtbCIsImlzc3VlZE9uIjoxMzU5MjE3OTEwLCJiYWRnZSI6Imh0dHBzOi8vZXhhbXBsZS5vcmcvcm9ib3RpY3MtYmFkZ2UuanNvbiIsInZlcmlmeSI6eyJ0eXBlIjoic2lnbmVkIiwidXJsIjoiaHR0cHM6Ly9leGFtcGxlLm9yZy9wdWJsaWNLZXkucGVtIn19
.
Liv4CLviFH20_6RciUWf-jrUvMAecxT4KZ_gLHAeT_chrsCvBEE1uwgtwiarIs9acFfMi0FJzrGye6mhdHf3Kjv_6P7BsG3RPkYgK6-5i9uZv4QAIlvfNclWAoWUt4j0_Kip2ftzzWwc5old01nJRtudZHxo5eGosSPlztGRE9G_g_cTj32tz3fG92E2azPmbt7026G91rq80Mi-9c4bZm2EgrcwNBjO0p1mbKYXLIAAkOMuJZ_8S4Go8S0Sg3xC6ZCn03zWuXCP6bdY_jJx2BpmvqC3H55xWIU8p5c9RxI8YifPMmJq8ZQhjld0pl-L8kHolJx7KGfTjQSegANUPg
```

When base64 decoded this corresponds to the three JSON objects below for a signed 1.0 Open Badge:

#### Header

```json
{"alg" : "RS256"} // Use the RS256 algorithm to create the JWS token.

//or

{"alg" : "SHA256"} // Use the SHA256 algorithm to create the JWS token.
```

#### Claims

```json
{
  "issuedOn" : 1359217910, //UNIX Time Stamp
  "uid" : "abc-1234",
  "recipient" : {
    "salt" : "deadsea",
    "type" : "email",
    "hashed" : true,
    "id" : "sha256$c7ef86405ba71b85acd8e2e95166c4b111448089f2e1599f42fe1bba46e865c5"
  },
  "image" : "https://example.org/beths-robot-badge.png",
  "evidence" : "https://example.org/beths-robot-work.html",
  "verify" : {
    "url" : "https://example.org/publicKey.pem",
    "type" : "signed" 
  },
  "badge" : "https://example.org/robotics-badge.json"
}
```

#### Signature

```text
Liv4CLviFH20_6RciUWf-jrUvMAecxT4KZ_gLHAeT_chrsCvBEE1uwgtwiarIs9acFfMi0FJzrGye6mhdHf3Kjv_6P7BsG3RPkYgK6-5i9uZv4QAIlvfNclWAoWUt4j0_Kip2ftzzWwc5old01nJRtudZHxo5eGosSPlztGRE9G_g_cTj32tz3fG92E2azPmbt7026G91rq80Mi-9c4bZm2EgrcwNBjO0p1mbKYXLIAAkOMuJZ_8S4Go8S0Sg3xC6ZCn03zWuXCP6bdY_jJx2BpmvqC3H55xWIU8p5c9RxI8YifPMmJq8ZQhjld0pl-L8kHolJx7KGfTjQSegANUPg
```

### Revocation List

A JSON dictionary of badge UIDs that have been revoked. The keys are the UIDs, and the value of each key is a string that could contain a reason for revocation. Checking this list is intended as part of the verification process for signed badges, just as checking for the hosted assertion is part of verifying a hosted badge.

```json
{
  "qp8g1s": "Issued in error",
  "2i9016k": "Issued in error",
  "1av09le": "Honor code violation"
}
```

### Validation

Open Badges v1.1 implements an optional JSON-schema based mechanism of ensuring badge objects conform to syntactic requirements of the specification. JSON-schema can ensure that required properties exist and that expected data types are used. From the contexts for badge objects and extensions, a **validation** array may contain links to various JSON-schema against which badge objects may be tested. There are two proposed methods of specifying which component of a badge object should be matched against the JSON-schema validator: TypeValidation and FrameValidation. As of 1.1, only TypeValidation is implemented.

For example, this portion of the current Open Badges context links to a validator for Assertions. It indicates through TypeValidation that it should be run against JSON objects with the JSON-LD type of **Assertion** ([https://w3id.org/openbadges#Assertion](https://w3id.org/openbadges#Assertion)).

```json
{
  ...
  "validation": [
    {
      "type": "TypeValidation",
      "validatesType": "Assertion",
      "validationSchema": "https://openbadgespec.org/v1/schema/assertion.json"
    },
    ...
  ]
}
```

#### Type Validation

Validators using the TypeValidation method match the schema indicated by the validator’s **validationSchema** property against a JSON badge object document or portion of such a document that matches the validator’s **validatesType** JSON-LD type.

| Property | Expected Type | Description |
|:--|:-:|:--|
| **type** | string/compact IRI | **TypeValidation** |
| **validatesType** | string/compact IRI | Valid JSON-LD type for a badge component, such as **Assertion**, **extensions:ApplyLink**, or [https://w3id.org/openbadges/extensions#ApplyLink](https://w3id.org/openbadges/extensions#ApplyLink). Compact forms preferred. |
| **validationSchema** | URL | Location of a hosted JSON-schema |

#### Frame Validation

*status: proposed* Validators that someday use the proposed FrameValidation method pass JSON-LD objects through the JSON-LD Frame indicated by the **validationFrame** property and test the result against the JSON-schema indicated by the validator’s **validationSchema** property.

### Miscellaneous

#### Data Type Primitives

- Boolean
- Text
- Array
- <span id="date-time-type">DateTime</span>
    - Either an [ISO 8601](http://en.wikipedia.org/wiki/ISO_8601) date or a standard 10-digit Unix timestamp.
- type
    - A string expressing the type of a Badge Object component. Currently applies to identityType and verificationType.
- URL
    - Fully qualified URL, including protocol, host, port if applicable, and path.
- IRI
    - In JSON-LD and Linked Data, IRIs (Internationalized Resource Identifiers) may look like fully qualified URLs or be namespaced within the JSON-LD context to be expanded to a full IRI.
- <span id="identity-type">IdentityType</span>
    - Type of identity being represented. Currently the only supported value for many earner applications like the [Mozilla Backpack](http://backpack.openbadges.org/) is “email”.
- <span id="identity-hash">IdentityHash</span>
    - A hash string preceded by a dollar sign (“$”) and the algorithm used to generate the hash. For example: **sha256$28d50415252ab6c689a54413da15b083034b66e5** represents the result of calculating a SHA256 hash on the string “mayze”. For more information, see [how to hash & salt in various languages](https://github.com/mozilla/openbadges/wiki/How-to-hash-&-salt-in-various-languages.).
- <span id="verification-type">VerificationType
    - Type of verification. Can be either “hosted” or “signed”.

#### Data Type Definitions

- JSON-LD Context
    - Description
    A link to a valid JSON-LD context file, that maps term names to contexts. Open Badges contexts may also define JSON-schema to validate Badge Objects against. In an Open Badges Object, this will almost always be a string:uri to a single context file, but might rarely be an array of links or context objects instead. This schema also allows direct mapping of terms to IRIs by using an object as an option within an array.
    - Definition
    ```json
    {
      "JsonLdContext": {
        "description": "A link to a valid JSON-LD context file, that maps term names to contexts. Open Badges contexts may also define JSON-schema to validate Badge Objects against. In an Open Badges Object, this will almost always be a string:uri to a single context file, but might rarely be an array of links or context objects instead. This schema also allows direct mapping of terms to IRIs by using an object as an option within an array.",
        "oneOf": [
          {"type": "string"},
          {
            "type": "array",
            "items": {
              "oneOf": [
                {"type": "string"},
                {"type": "object"},
                {"type": "array"}
              ]
            }
          }
        ]
      }
    }
    ```

- JSON-LD Type
    - Description
    A type or an array of types.
    - Definition
    ```json
    {
      "JsonLdType": {
        "description": "A type of an array of types.",
        "oneOf": [
          {"type": "string"},
          {
            "type": "array",
            "items": {
              {"type": "string"}
            }
          }
        ]
      }
    }
    ```

- Image Data URL
    - Description
    - Definition
    ```json
    {
      "ImageDataUrl": {
        "type": "string",
        "pattern": "^data:"
      }
    }
    ```

- Badge Image
    - Description
    An image representative of the entity
    - Definition
    ```json
    {
      "BadgeImage": {
        "description": "An image representative of the entity",
        "oneOf": [
          {
            "$ref": "#/definitions/ImageDataUrl"
          },
          {
            "type": "string",
            "format": "uri"
          }
        ]
      }
    }
    ```

- ISO Date Time
    - Description
    ISO 8601 date format string yyyy-MM-dd'T'HH:mm:ss.SSS with optional .SSS milliseconds
    - Definition
    ```json
    {
      "ISODateTime": {
        "description": "ISO 8601 date format string yyyy-MM-dd'T'HH:mm:ss.SSS with optional .SSS milliseconds",
        "type": "string",
        "pattern": "^\\d{4}-[01]\\d-[0-3]\\d(T[0-2]\\d:[0-5]\\d(:[0-5]\\d)?([\\.,]\\d{1,3})?(Z|[+-][0-2]\\d(:?[0-5]\\d)?)?)?$"
      }
    }
    ```

- UNIX Time Stamp
    - Description
    10-digit UNIX timestamp, epoch time
    - Definition
    ```json
    {
      "UNIXTimeStamp": {
            "description": "10-digit UNIX timestamp, epoch time",
            "type": "integer",
            "minimum": 0,
            "maximum": 9999999999
        }
    }
    ```

- DateTime
    - Description
    A DateTime index
    - Definition
    ```json
    {
      "DateTime": {
        "anyOf": [
          {"$ref": "#/definitions/ISODateTime"},
          {"$ref": "#/definitions/UNIXTimeStamp"}
        ]
      }
    }
    ```

- IdentityType
    - Description
    The type of identity
    - Definition
    ```json
    {
      "IdentityType": {
        "type": "string",
        "enum": [
          "email"
        ]
      }
    }
    ```

- HashString
    - Description
    The type of hash string
    - Definition
    ```json
    {
      "HashString": {
            "allOf": [
                {"type": "string"}
            ],
            "oneOf": [
                {
                    "title": "Open Badges SHA-1 Hash",
                    "pattern": "^sha1\\$[a-fA-F0-9]{40}$"
                },
                {
                    "title": "Open Badges SHA-256 Hash",
                    "pattern": "^sha256\\$[a-fA-F0-9]{64}$"
                }
            ]
        }
    }
    ```

- Assertion Object
    - Description
    Badge Assertion Object
    - Definition
    ```json
    {
      "AssertionObject": {
        "title": "Badge Assertion Object",
        "type": "object",
        "properties": {
          "@context": {"$ref": "#/definitions/JsonLdContext"},
          "type": {"$ref": "#/definitions/JsonLdType"},
          "id": {"type": "string", "format": "uri"},
          "uid": {"type": "string"},
          "recipient": {"$ref": "#/definitions/IdentityObject"},
          "badge": {"type": "string", "format": "uri"},
          "verify": {"$ref": "#/definitions/VerificationObject"},
          "issuedOn": {"$ref": "#/definitions/DateTime"},
          "evidence": {"type": "string", "format": "uri"},
          "expires": {"$ref": "#/definitions/DateTime"}
        }
        "required": [
          "@context", "type", "uid", "recipient", "badge", "verify", "issuedOn"
        ],
        "additionalProperties": true
      }
    }
    ```

- Identity Object
    - Description
    Badge Identity Object
    - Definition
    ```json
    {
      "IdentityObject": {
            "title": "Badge Identity Object",
            "type": "object",
            "properties": {
                "identity": {
                    "oneOf": [
                        {
                            "$ref": "#/definitions/HashString"
                        },
                        {
                            "type": "string",
                            "format": "email"
                        }
                    ]
                },
                "type": {
                    "$ref": "#/definitions/IdentityType"
                },
                "hashed": {
                    "type": "boolean"
                },
                "salt": {
                    "type": "string"
                }
            },
            "required": [
                "identity",
                "type",
                "hashed"
            ]
        }
    }
    ```

- Verification Object
    - Description
    Badge Verification Object
    - Definition
    ```json
    {
      "VerificationObject": {
            "type": "object",
            "properties": {
                "type": {
                    "title": "VerificationType",
                    "type": "string",
                    "enum": [
                        "hosted",
                        "signed"
                    ]
                },
                "url": {
                    "type": "string",
                    "format": "uri"
                }
            },
            "required": [
                "type"
            ]
        }
    }
    ```

- Type
    - Description
    - Definition
    ```json

    ```