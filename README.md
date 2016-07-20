## Open Badges Specification

### Badge Objects

#### Assertion

Assertions are representations of an awarded badge, used to share information about a badge belonging to one earner.

| Property | Expected Type | Description |
|:--|:--|:--|
| **@context** | JSON-LD Context | [https://w3id.org/openbadges/v1](https://w3id.org/openbadges/v1) or valid JSON-LD context array or object including the 1.1 Open Badges Context.
| id | URL | Unique IRI for the Assertion. If using hosted verification, this should be the URL where the assertion is accessible. |
| **type** | JSON-LD type | A valid JSON-LD representation of the Assertion type. In most cases, this will simply be the string Assertion. An array including Assertion and other string elements that are either URLs or compact IRIs within the current context are allowed. |
| **uid** | Text | Unique Identifier for the badge. This is expected to be *locally* unique on a per-origin basis, not globally unique. |
| **recipient** | [IdentityObject]() | The recipient of the achievement. |
| **badge** | URL | URL that describes the type of badge being awarded. The endpoint should be a [BadgeClass](). |
| **verify** | [VerificationObject]() | Instructions for third parties to verify this assertion. |
| **issuedOn** | [DateTime]() | Date that the achievement was awarded. |
| image | URL | A URL of an image representing this user’s achievement. This must be a PNG or SVG image, and should be prepared via the [Baking specification](). An ‘unbaked’ image for the badge is defined in the [BadgeClass](). |
| evidence | URL | A URL of the work that the recipient did to earn the achievement. This can be a page that links out to other pages if linking directly to the work is infeasible. |
| expires | [DateTime]() | If the achievement has some notion of expiry, this indicates a date when a badge should no longer be considered valid. |

##### Example

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
