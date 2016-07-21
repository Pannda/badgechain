# Open Badges Specification

## Table of Contents

- [Data Types](#data-types)
    - [Primitives](#primitives)
    - [JSON-LD Context](#json-ld-context)
        - [Schema Definiton](#json-ld-context-schema-definition)
    - [JSON-LD Type](#json-ld-type)
        - [Schema Definition](#json-ld-type-schema-definition)
    - [DateTime](#datetime)
        - [Generic DateTime](#generic-datetime)
            - [Schema Definition](#generic-datetime-schema-definition)
        - [ISO DateTime](#iso-datetime)
            - [Schema Definition](#iso-datetime-schema-definition) 
        - [UNIX DateTime](#unix-datetime)
            - [Schema Definition](#unix-datetime-schema-definition)
    - [Generic Types](#generic-types) 
        - [Identity](#identity)
            - [Schema Definition](#identity-schema-definition) 
        - [Hash String](#hash-string)
            - [Schema Definition](#hash-string-schema-definition)
        - [Verification](#verification)
            - [Schema Definition](#verification-schema-definition) 
    - [Image Date URL](#image-date-url)
        - [Generic Image Date URL](#generic-image-data-url)
            - [Schema Definition](#image-date-url-schema-definition)
        - [Badge Image](#badge-image)
            - [Schema Definition](#badge-image-schema-definition)
- [Badge Objects](#badge-objects)
    - [Assertion](#assertion)
        - [Example](#assertion-example)
        - [Schema Definition](#assertion-schema-definiton)
    - [BadgeClass](#badge-class)
        - [Example](#badge-class-example)
        - [Scema Definition](#badge-class-schema-definition)
    - [IssuerOrganization](#issuer-organization)
        - [Example](#issuer-organization-example)
        - [Schema Definition](#issuer-organization-schema-definition)
- [Helper Objects](#helper-objects)
    - [Alignment Object](#alignment-object)
        - [Schema Definition](#alignment-object-schema-definition)
    - [Identity Object](#identity-object)
        - [Schema Definition](#identity-object-schema-definition)
    - [Verification Object](#verification-object)
        - [Schema Definition](#verifiction-object-schema-definition) 
- [Extensions](#extensions)
    - [Schema Definition](#extension-schema-definition)
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

## Data Types

### Primitives

- Boolean
- Text
- Array
- DateTime
    - [ISO DateTime](#iso-datetime)
    - [UNIX Timestamp](#unix-timestamp)
- [type](#generic-types)
- [URL](#url)
- [IRI](#iri)
- [IdentityType](#identity)
- [IdentityHash](#hash-string)
- [VerificationType](#verification)

### JSON-LD Context

A link to a valid JSON-LD context file, that maps term names to contexts. Open Badges contexts may also define JSON-schema to validate Badge Objects against. In an Open Badges Object, this will almost always be a string:uri to a single context file, but might rarely be an array of links or context objects instead. This schema also allows direct mapping of terms to IRIs by using an object as an option within an array.

<h4 id="json-ld-context-schema-definition">Schema Definiton</h4>

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

### JSON-LD Type

<h4 id="json-ld-type-schema-definition">Schema Definiton</h4>

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

### DateTime

#### Generic DateTime

<h5 id="generic-datetime-schema-definition">Schema Definition</h5>

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

#### ISO DateTime

[ISO 8601](http://en.wikipedia.org/wiki/ISO_8601) date format string yyyy-MM-dd’T’HH:mm:ss.SSS with optional .SSS

<h5 id="iso-datetime-schema-definition">Schema Definiton</h5>

```json
{
  "ISODateTime": {
    "description": "ISO 8601 date format string yyyy-MM-dd'T'HH:mm:ss.SSS with optional .SSS milliseconds",
    "type": "string",
    "pattern": "^\\d{4}-[01]\\d-[0-3]\\d(T[0-2]\\d:[0-5]\\d(:[0-5]\\d)?([\\.,]\\d{1,3})?(Z|[+-][0-2]\\d(:?[0-5]\\d)?)?)?$"
  }
}
```

#### UNIX Timestamp

A 10-digit [UNIX timestamp](https://en.wikipedia.org/wiki/Unix_time), epoch time

<h5 id="unix-time-stamp-datetime-schema-definition">Schema Definiton</h5>

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

### Generic Types

A string expressing the type of a [Badge Object](#badge-objects) component. Currently applies to [identityType](#identity) and [verificationType](#verification).

#### Identity

Type of identity being represented. Currently the only supported value for many earner applications like the [Mozilla Backpack](http://backpack.openbadges.org/) is “email”.

<h5 id="identity-schema-definition">Schema Definiton</h5>

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

#### Hash String

A hash string preceded by a dollar sign (“$”) and the algorithm used to generate the hash. For example: **sha256$28d50415252ab6c689a54413da15b083034b66e5** represents the result of calculating a SHA256 hash on the string “mayze”. For more information, see [how to hash & salt in various languages](https://github.com/mozilla/openbadges/wiki/How-to-hash-&-salt-in-various-languages.).

<h5 id="hash-string-schema-definition">Schema Definiton</h5>

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

#### Verification

Type of verification. Can be either “hosted” or “signed”.

<h5 id="verification-schema-definition">Schema Definition</h5>

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

### Image Data URI

#### Generic Image Data URL

<h5 id="generic-image-data-url-schema-definition">Schema Definiton</h5>

```json
{
  "ImageDataUrl": {
    "type": "string",
    "pattern": "^data:"
  }
}
```

#### Badge Image

<h5 id="badge-image-schema-definition">Schema Definiton</h5>

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

### IRI

In JSON-LD and Linked Data, IRIs ([Internationalized Resource Identifiers](https://en.wikipedia.org/wiki/Internationalized_Resource_Identifier)) may look like fully [qualified URL](#url)s or be namespaced within the JSON-LD context to be expanded to a full IRI.

### URL

Fully *qualified URL*, including protocol, host, port if applicable, and path.

A qualifed URL is akin to an [Absolute URI](#http://tools.ietf.org/html/rfc3986#page-27).

- Absolute URI
```text
http://example.com/foo/bar.html
```
- Relative-path Reference
```
foo/bar.html
```
- Relative-path Reference *with an Absolute URI*
```
/foo/bar.html
```
- Network-path Reference
```
//example.com/foo/bar.html
```

## Badge Objects

### Assertion

Assertions are representations of an awarded badge, used to share information about a badge belonging to one earner.

**N.B.** Properties in **bold** are required.

| Property | Expected Type | Description |
|:--|:-:|:--|
| **@context** | [JSON-LD Context](#json-ld-context) | [https://w3id.org/openbadges/v1](https://w3id.org/openbadges/v1) or valid JSON-LD context array or object including the 1.1 Open Badges Context.
| id | [URL](#url) | Unique IRI for the Assertion. If using hosted verification, this should be the URL where the assertion is accessible. |
| **type** | [JSON-LD type](#json-ld-type) | A valid JSON-LD representation of the Assertion type. In most cases, this will simply be the string Assertion. An array including Assertion and other string elements that are either URLs or compact IRIs within the current context are allowed. |
| **uid** | Text | Unique Identifier for the badge. This is expected to be *locally* unique on a per-origin basis, not globally unique. |
| **recipient** | [IdentityObject](#identity) | The recipient of the achievement. |
| **badge** | [URL](#url) | URL that describes the type of badge being awarded. The endpoint should be a [BadgeClass](). |
| **verify** | [VerificationObject](#verification) | Instructions for third parties to verify this assertion. |
| **issuedOn** | [DateTime](#date-time-type) | Date that the achievement was awarded. |
| image | [URL](#url) | A URL of an image representing this user’s achievement. This must be a PNG or SVG image, and should be prepared via the [Baking specification](http://specification.openbadges.org/baking/). An ‘unbaked’ image for the badge is defined in the [BadgeClass](#badge-class). |
| evidence | [URL](#url) | A URL of the work that the recipient did to earn the achievement. This can be a page that links out to other pages if linking directly to the work is infeasible. |
| expires | [DateTime](#datetime) | If the achievement has some notion of expiry, this indicates a date when a badge should no longer be considered valid. |

<h4 id="assertion-example">Example</h4>

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

<h4 id="assertion-schema-definiton">Schema Definition</h4>

```json
{
    "$schema": "http://json-schema.org/draft-04/schema#",
    "title": "1.1-compliant assertion w/linked Badge Class",
    "description": "The 1.1 OBI specification mandates that the baked assertion be an object with linked Badge Class and that JSON-LD context and type declarations be present",
    "type": "object",
    "definitions": {
        "JsonLdContext": {
            "description": "A link to a valid JSON-LD context file, that maps term names to contexts. Open Badges contexts may also define JSON-schema to validate Badge Objects against. In an Open Badges Object, this will almost always be a string:uri to a single context file, but might rarely be an array of links or context objects instead. This schema also allows direct mapping of terms to IRIs by using an object as an option within an array.",
            "oneOf": [
                {
                    "type": "string"
                },
                {
                    "type": "array",
                    "items": { "oneOf": 
                      [   
                        { "type": "string" },
                        { "type": "object" },
                        { "type": "array" }
                      ]
                    }
                }
            ]
        },
        "JsonLdType": {
            "description": "A type or an array of types that the badge object represents. The first or only item should be 'assertion', and any others should each be an IRI (usually a URL) corresponding to a definition of the type itself. In almost all cases, an assertion will only have one type: 'assertion'",
            "oneOf": [
                {
                    "type": "string"
                },
                {
                    "type": "array",
                    "items": {
                        "type": "string"
                    }
                }
            ]
        },
        "ISODateTime": {
            "description": "ISO 8601 date format string yyyy-MM-dd'T'HH:mm:ss.SSS with optional .SSS milliseconds",
            "type": "string",
            "pattern": "^\\d{4}-[01]\\d-[0-3]\\d(T[0-2]\\d:[0-5]\\d(:[0-5]\\d)?([\\.,]\\d{1,3})?(Z|[+-][0-2]\\d(:?[0-5]\\d)?)?)?$"
        },
        "UNIXTimeStamp": {
            "description": "10-digit UNIX timestamp, epoch time",
            "type": "integer",
            "minimum": 0,
            "maximum": 9999999999
        },
        "DateTime": {
            "anyOf": [
                {
                    "$ref": "#/definitions/ISODateTime"
                },
                {
                    "$ref": "#/definitions/UNIXTimeStamp"
                }
            ]
        },
        "IdentityType": {
            "type": "string",
            "enum": [
                "email"
            ]
        },
        "HashString": {
            "allOf": [
                {
                    "type": "string"
                }
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
        },
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
        },
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
    },
    "properties": {
        "@context": { "$ref": "#/definitions/JsonLdContext" },
        "type": { "$ref": "#/definitions/JsonLdType" },
        "id": { "type": "string", "format": "uri" },
        "uid": {
            "type": "string"
        },
        "recipient": {
            "$ref": "#/definitions/IdentityObject"
        },
        "badge": {
            "type": "string",
            "format": "uri"
        },
        "verify": {
            "$ref": "#/definitions/VerificationObject"
        },
        "issuedOn": {
            "$ref": "#/definitions/DateTime"
        },
        "evidence": {
            "type": "string",
            "format": "uri"
        },
        "expires": {
            "$ref": "#/definitions/DateTime"
        }
    },
    "required": [
        "@context", "type", "uid", "recipient", "badge", "verify", "issuedOn"
    ],
    "additionalProperties": true
}
```

### Badge Class

A collection of information about the accomplishment recognized by the Open Badge. Many assertions may be created corresponding to one BadgeClass.

| Property | Expected Type | Description |
|:--|:-:|:--|
| **@context** | [JSON-LD Context](#json-ld-context) | [https://w3id.org/openbadges/v1](https://w3id.org/openbadges/v1) or valid JSON-LD context array or object including the 1.1 Open Badges Context |
| **id** | [URL](#url) | Unique IRI for the BadgeClass, the URL where it is published. |
| **type** | [JSON-LD type](#json-ld-type) | valid JSON-LD representation of the **BadgeClass** type. In most cases, this will simply be the string BadgeClass. An array including **BadgeClass** and other string elements that are either URLs or compact IRIs within the current context are allowed. |
| **name** | Text | The name of the achievement. |
| **description** | Text | A short description of the achievement. |
| **image** | [Data URI](#https://en.wikipedia.org/wiki/Data_URI_scheme) or [URL](#url) | A URL of an image representing the achievement. |
| **criteria** | [URL](#url) | URL of the criteria for earning the achievement. If the badge represents an educational achievement, consider marking up this up with [LRMI](http://lrmi.dublincore.net/). |
| **issuer** | [URL](#url) | URL of the organization that issued the badge. Endpoint should be an [IssuerOrganization](#issuer-organization). |
| alignment | Array of [AlignmentObjects](#alignment-object) | List of objects describing which educational standards this badge aligns to, if any. |
| tags | Array of Text | List of tags that describe the type of achievement. |

<h4 id="badge-class-example">Example</h4>

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

<h4 id="badge-class-schema-definition">Schema Definition</h4>

```json
{
  "$schema": "http://json-schema.org/draft-04/schema#",
  "title": "1.1-compliant Badge Class with linked Issuer",
  "description": "The 1.1 OBI specification mandates that a hosted Badge Class be a valid JSON-LD object with linked Issuer",
  "type": "object",
  "definitions": {
    "JsonLdContext": {
      "description": "A link to a valid JSON-LD context file, that maps term names to contexts. Open Badges contexts may also define JSON-schema to validate Badge Objects against. In an Open Badges Object, this will almost always be a string:uri to a single context file, but might rarely be an array of links or context objects instead. This schema also allows direct mapping of terms to IRIs by using an object as an option within an array.",
      "oneOf": [
        { "type": "string" },
        {
          "type": "array",
          "items": {
            "oneOf": [
              { "type": "string" },
              { "type": "object" },
              { "type": "array" }
            ]
          }
        }
      ]
    },
    "JsonLdType": {
      "description": "A type or an array of types that the badge object represents. The first or only item should be 'badgeclass', and any others should each be an IRI (usually a URL) corresponding to a definition of the type itself. In almost all cases, an assertion will only have one type: 'badgeclass'",
      "oneOf": [
        {
          "type": "string"
        },
        {
          "type": "array",
          "items": {
            "type": "string"
          }
        }
      ]
    },
    "ImageDataUrl": {
      "type": "string",
      "pattern": "^data:"
    },
    "BadgeImage": {
      "anyOf": [
        {
          "$ref": "#/definitions/ImageDataUrl"
        },
        {
          "type": "string",
          "format": "uri"
        }
      ]
    },
    "AlignmentObject": {
      "description": "Each object in an alignment array is an object that describes a particular standard or standard element and provides an appropriate link",
      "type": "object",
      "properties": {
        "name": {
          "type": "string"
        },
        "url": {
          "type": "string",
          "format": "uri"
        },
        "description": {
          "type": "string"
        }
      },
      "required": [
        "name",
        "url"
      ]
    },
    "AlignmentArray": {
      "description": "List of objects describing which educational standards this badge aligns to, if any, and linking to the appropriate standard.",
      "type": "array",
      "items": {
        "$ref": "#/definitions/AlignmentObject"
      }
    },
    "TagsArray": {
      "description": "An array of strings. TagsArray is not a controlled vocabulary; it's a folksonomy",
      "type": "array",
      "items": {
        "type": "string"
      },
      "uniqueness": true
    }
  },
  "properties": {
    "@context": { "$ref": "#/definitions/JsonLdContext" },
    "type": { "$ref": "#/definitions/JsonLdType" },
    "id": { "type": "string", "format": "uri" },
    "name": {
      "type": "string"
    },
    "description": {
      "type": "string"
    },
    "image": {
      "$ref": "#/definitions/BadgeImage"
    },
    "criteria": {
      "type": "string",
      "format": "uri"
    },
    "issuer": {
      "type": "string",
      "format": "uri"
    },
    "alignment": {
      "$ref": "#/definitions/AlignmentArray"
    },
    "tags": {
      "$ref": "#/definitions/TagsArray"
    }
  },
  "required": [
    "name",
    "description",
    "image",
    "criteria",
    "issuer"
  ],
  "additionalProperties": true
}
```

### Issuer Organization

A collection of information about the entity or organization issuing the Open Badge. Each issuer may correspond to many BadgeClasses. Anyone can create and host an Issuer file to start issuing Open Badges.

| Property | Expected Type | Description |
|:--|:-:|:--|
| **@context** | [JSON-LD Context](#json-ld-context) | [https://w3id.org/openbadges/v1](https://w3id.org/openbadges/v1) or valid JSON-LD context array or object including the 1.1 Open Badges Context |
| **id** | [URL](#url) | Unique IRI for the IssuerOrganization file. |
| **type** | [JSON-LD type](#json-ld-type) | valid JSON-LD representation of the [IssuerOrganization](#issuer-organization) type. In most cases, this will simply be the string [BadgeClass](#badge-class). An array including [IssuerOrganization](#issuer-organization) and other string elements that are either URLs or compact IRIs within the current context are allowed. |
| **name** | Text | The name of the issuing organization. |
| **url** | [URL](#url) | URL of the institution |
| description | Text | A short description of the institution |
| image | [Data URI](http://en.wikipedia.org/wiki/Data_URI_scheme) or [URL](#url) | An image representing the institution |
| email | Text | Contact address for someone at the organization. |
| revocationList | [URL](#url) | URL of the [Badge Revocation List](#revocation-list). The endpoint should be a JSON representation of an object where the keys are the uid or id of a revoked badge assertion, and the values are the reason for revocation. It is only recommended that signed badge issuers use this method when they have revoked at least one badge. |

<h4 id="issuer-organization-example">Example</h4>

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

<h4 id="issuer-organization-schema-definition">Schema Definition</h4>

```json
{
  "$schema": "http://json-schema.org/draft-04/schema#",
  "title": "1.1 Open Badges Issuer",
  "description": "The 1.1-compliant Open Badges Issuer definition file is a JSON-LD enabled version of the 1.0 version.",
  "type": "object",
  "definitions": {
    "JsonLdContext": {
        "description": "A link to a valid JSON-LD context file, that maps term names to contexts. Open Badges contexts may also define JSON-schema to validate Badge Objects against. In an Open Badges Object, this will almost always be a string:uri to a single context file, but might rarely be an array of links or context objects instead. This schema also allows direct mapping of terms to IRIs by using an object as an option within an array.",
        "oneOf": [
            {
                "type": "string"
            },
            {
                "type": "array",
                "items": { "oneOf": 
                  [   
                    { "type": "string" },
                    { "type": "object" },
                    { "type": "array" }
                  ]
                }
            }
        ]
    },
    "JsonLdType": {
        "description": "A type or an array of types that the badge object represents. The first or only item should be 'issuerorg', and any others should each be an IRI (usually a URL) corresponding to a definition of the type itself. In almost all cases, an assertion will only have one type: 'issuerorg'",
        "oneOf": [
            {
                "type": "string"
            },
            {
                "type": "array",
                "items": {
                    "type": "string"
                }
            }
        ]
    },
    "ImageDataUrl": {
      "type": "string",
      "pattern": "^data:"
    },
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
  },
  "properties": {
    "@context": { "$ref": "#/definitions/JsonLdContext" },
    "type": { "$ref": "#/definitions/JsonLdType" },
    "id": { "type": "string", "format": "uri" },
    "name": {
      "description": "Human-readable name of the issuing entity",
      "type": "string"
    },
    "url": {
      "description": "The URL of the issuer's website or homepage",
      "type": "string",
      "format": "uri"
    },
    "description": {
      "type": "string",
      "description": "A text description of the issuing organization"
    },
    "image": {
      "$ref": "#/definitions/BadgeImage"
    },
    "email": {
      "type": "string",
      "format": "email"
    },
    "revocationList": {
      "type": "string",
      "format": "uri"
    }
  },
  "required": [
    "name",
    "url"
  ],
  "additionalProperties": true
}
```

## Helper Objects

### Alignment Object

A collection of information about the educational standards of the badge to which they are assigned.

| Property | Expected Type | Description |
|:--|:-:|:--|
| **name** | Text | Name of alignment. |
| **url** | [URL](#url) | URL linking to the official description of the standard. |
| description | Text | Short description of the standard |

<h4 id="alignment-object-schema-definition">Schema Definition</h4>

```json
{
  "AlignmentObject": {
    "description": "Each object in an alignment array is an object that describes a particular standard or standard element and provides an appropriate link",
    "type": "object",
    "properties": {
      "name": {
        "type": "string"
      },
      "url": {
        "type": "string",
        "format": "uri"
      },
      "description": {
        "type": "string"
      }
    },
    "required": [
      "name",
      "url"
    ]
  }
}
```

### Identity Object

A collection of information about the recipient of a badge.

| Property | Expected Type | Description |
|:--|:-:|:--|
| **identity** | [IdentityHash](#hash-string) or Text | Either the hash of the identity or the plaintext value. If it’s possible that the plaintext transmission and storage of the identity value would leak personally identifiable information where there is an expectation of privacy, it is strongly recommended that an IdentityHash be used. |
| **type** | [IdentityType](#identity) | The type of identity. |
| **hashed** | Boolean | Whether or not the **identity** value is hashed. |
| salt | Text | If the recipient is hashed, this should contain the string used to salt the hash. If this value is not provided, it should be assumed that the hash was not salted. |

<h4 id="identity-object-schema-definition">Schema Definition</h4>

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

### Verification Object

A collection of information allowing a consumer to authenticate the Assertion.

| Property | Expected Type | Description |
|:--|:-:|:--|
| **type** | [VerificationType](#verification) | The type of verification method. |
| **url** | [URL](#url) | If the type is “hosted”, this should be a URL pointing to the assertion on the issuer’s server. If the type is “signed”, this should be a link to the issuer’s public key. |

<h4 id="verifiction-object-schema-definition">Schema Definition</h4>

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

## Extensions

For examples of Badge Object Extensions and community-developed extensions ready for implementation, see the [Extensions page](http://specification.openbadges.org/extensions/#ExampleExtension).

<h3 id="extension-schema-definition">Schema Definition</h3>

```json
{
  "$schema": "http://json-schema.org/draft-04/schema#",
  "title": "1.1 Open Badge Extension - Core Schema",
  "description": "The 1.1 OBI Standard allows extensions, as JSON-LD objects embedded in one of the standard Badge Objects (Issuer, Badge Class, or Assertion). 1.1 extensions should validate against this schema and any schema defined in the extension's JSON-LD context.",
  "type": "object",
  "definitions": {
    "JsonLdContext": {  
      "description": "A link to a valid JSON-LD context file, that maps term names to contexts. Open Badges contexts may also define JSON-schema to validate Badge Objects against. In an Open Badges Extension, this will almost always be a string:uri to a single context file, but might rarely be an array of links instead. Direct insertion of JSON-LD term mappings as a dictionary/object is not permitted in an OBI extension",
      "oneOf": [
        { "type": "string"},
        { 
          "type": "array", 
          "items": { "type": "string" }
        }
      ]
    }, 
    "JsonLdType": {
      "description": "An array of types that the extension represents. The first item should be 'extension', and the second should be an IRI (usually URL) corresponding to a definition of the extension itself. For extensions using the Open Badges Standard extension registry, you may use the 'extension:YourExtension' shorthand, where 'YourExtension' is replaced by the name of the extension registered with the Open Badges Standard.",
      "oneOf": [
        { "type": "string" }, 
        { 
          "type": "array",
          "items": { "type": "string" }
        }
      ]
    }
  },
  "properties": {
    "@context": { "$ref": "#/definitions/JsonLdContext" },
    "type": { "$ref": "#/definitions/JsonLdType" }
  },
  "required": ["@context", "@type"],
  "additionalProperties": true
}
```

## Signed Badges

A JSON Web Signature (JWS) for a signed badge looks like the following. (Space has been added here around the . separators for clarity.)

```text
eyJhbGciOiJSUzI1NiJ9
.
eyJ1aWQiOiJhYmMtMTIzNCIsInJlY2lwaWVudCI6eyJ0eXBlIjoiZW1haWwiLCJoYXNoZWQiOnRydWUsInNhbHQiOiJkZWFkc2VhIiwiaWQiOiJzaGEyNTYkYzdlZjg2NDA1YmE3MWI4NWFjZDhlMmU5NTE2NmM0YjExMTQ0ODA4OWYyZTE1OTlmNDJmZTFiYmE0NmU4NjVjNSJ9LCJpbWFnZSI6Imh0dHBzOi8vZXhhbXBsZS5vcmcvYmV0aHMtcm9ib3QtYmFkZ2UucG5nIiwiZXZpZGVuY2UiOiJodHRwczovL2V4YW1wbGUub3JnL2JldGhzLXJvYm90LXdvcmsuaHRtbCIsImlzc3VlZE9uIjoxMzU5MjE3OTEwLCJiYWRnZSI6Imh0dHBzOi8vZXhhbXBsZS5vcmcvcm9ib3RpY3MtYmFkZ2UuanNvbiIsInZlcmlmeSI6eyJ0eXBlIjoic2lnbmVkIiwidXJsIjoiaHR0cHM6Ly9leGFtcGxlLm9yZy9wdWJsaWNLZXkucGVtIn19
.
Liv4CLviFH20_6RciUWf-jrUvMAecxT4KZ_gLHAeT_chrsCvBEE1uwgtwiarIs9acFfMi0FJzrGye6mhdHf3Kjv_6P7BsG3RPkYgK6-5i9uZv4QAIlvfNclWAoWUt4j0_Kip2ftzzWwc5old01nJRtudZHxo5eGosSPlztGRE9G_g_cTj32tz3fG92E2azPmbt7026G91rq80Mi-9c4bZm2EgrcwNBjO0p1mbKYXLIAAkOMuJZ_8S4Go8S0Sg3xC6ZCn03zWuXCP6bdY_jJx2BpmvqC3H55xWIU8p5c9RxI8YifPMmJq8ZQhjld0pl-L8kHolJx7KGfTjQSegANUPg
```

When base64 decoded this corresponds to the three JSON objects below for a signed 1.0 Open Badge:

### Header

```json
{"alg" : "RS256"} // Use the RS256 algorithm to create the JWS token.

//or

{"alg" : "SHA256"} // Use the SHA256 algorithm to create the JWS token.
```

### Claims

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

### Signature

```text
Liv4CLviFH20_6RciUWf-jrUvMAecxT4KZ_gLHAeT_chrsCvBEE1uwgtwiarIs9acFfMi0FJzrGye6mhdHf3Kjv_6P7BsG3RPkYgK6-5i9uZv4QAIlvfNclWAoWUt4j0_Kip2ftzzWwc5old01nJRtudZHxo5eGosSPlztGRE9G_g_cTj32tz3fG92E2azPmbt7026G91rq80Mi-9c4bZm2EgrcwNBjO0p1mbKYXLIAAkOMuJZ_8S4Go8S0Sg3xC6ZCn03zWuXCP6bdY_jJx2BpmvqC3H55xWIU8p5c9RxI8YifPMmJq8ZQhjld0pl-L8kHolJx7KGfTjQSegANUPg
```

## Revocation List

A JSON dictionary of badge UIDs that have been revoked. The keys are the UIDs, and the value of each key is a string that could contain a reason for revocation. Checking this list is intended as part of the verification process for signed badges, just as checking for the hosted assertion is part of verifying a hosted badge.

```json
{
  "qp8g1s": "Issued in error",
  "2i9016k": "Issued in error",
  "1av09le": "Honor code violation"
}
```

## Validation

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

### Type Validation

Validators using the TypeValidation method match the schema indicated by the validator’s **validationSchema** property against a JSON badge object document or portion of such a document that matches the validator’s **validatesType** JSON-LD type.

| Property | Expected Type | Description |
|:--|:-:|:--|
| **type** | string/compact IRI | **TypeValidation** |
| **validatesType** | string/compact IRI | Valid JSON-LD type for a badge component, such as **Assertion**, **extensions:ApplyLink**, or [https://w3id.org/openbadges/extensions#ApplyLink](https://w3id.org/openbadges/extensions#ApplyLink). Compact forms preferred. |
| **validationSchema** | URL | Location of a hosted JSON-schema |

### Frame Validation

*status: proposed* Validators that someday use the proposed FrameValidation method pass JSON-LD objects through the JSON-LD Frame indicated by the **validationFrame** property and test the result against the JSON-schema indicated by the validator’s **validationSchema** property.