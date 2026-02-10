# Data Taxonomy Template

> A structured framework for classifying, managing, and governing all data
> in your SaaS application. Customize this for your domain.

---

## Data Entity Categories

### Category Overview

| Category | Description | Examples |
|----------|-------------|---------|
| **Identity** | User and account data | Users, organizations, profiles, roles |
| **Transactional** | Business event records | Orders, subscriptions, invoices, payments |
| **Content** | User-generated or system content | Posts, files, comments, messages |
| **Configuration** | System and user settings | Preferences, feature flags, plan configs |
| **Behavioral** | Usage and interaction data | Page views, clicks, feature usage, sessions |
| **Communication** | Messages and notifications | Emails sent, push notifications, in-app messages |
| **Audit** | Change tracking and compliance | Audit logs, access logs, change history |
| **Reference** | Static lookup data | Countries, currencies, categories, tags |

### Entity Inventory Template

| Entity | Category | Owner | Primary Key | Description |
|--------|----------|-------|-------------|-------------|
| `users` | Identity | Auth Service | `id (UUID)` | Registered user accounts |
| `organizations` | Identity | Core Service | `id (UUID)` | Customer organizations |
| `memberships` | Identity | Core Service | `user_id + org_id` | User-to-organization mapping |
| `subscriptions` | Transactional | Billing Service | `id (UUID)` | Active and historical subscriptions |
| `invoices` | Transactional | Billing Service | `id (UUID)` | Payment records |
| `[your_entity]` | [Category] | [Service] | [Key] | [Description] |

---

## Classification Framework

### Data Classification Levels

| Level | Label | Description | Examples |
|-------|-------|-------------|---------|
| **1** | Public | Safe for public access | Marketing content, public profiles, pricing |
| **2** | Internal | For authenticated users only | Feature usage stats, general settings |
| **3** | Confidential | Restricted to authorized roles | User emails, billing info, org data |
| **4** | Restricted | Highly sensitive, strict controls | Passwords, API keys, payment tokens, PII |

### Classification Rules

| Data Type | Classification | Justification |
|-----------|---------------|---------------|
| User email address | Confidential (3) | PII, required for auth |
| Password hash | Restricted (4) | Security credential |
| Payment method token | Restricted (4) | Financial data |
| User display name | Internal (2) | Visible to other users |
| Organization name | Internal (2) | Visible to members |
| Usage analytics | Internal (2) | Business intelligence |
| Audit logs | Confidential (3) | Security and compliance |
| Public profile bio | Public (1) | User-chosen to share |
| IP address | Confidential (3) | PII under GDPR |
| Feature flags | Internal (2) | System configuration |

---

## Sensitivity Levels

### Personally Identifiable Information (PII)

| Data Field | PII Type | Special Handling |
|------------|----------|-----------------|
| Email address | Direct PII | Encrypt at rest, mask in logs |
| Full name | Direct PII | Encrypt at rest |
| Phone number | Direct PII | Encrypt at rest, mask in UI |
| IP address | Indirect PII | Hash in analytics, purge from logs |
| Billing address | Direct PII | Stored in payment provider, not locally |
| Device fingerprint | Indirect PII | Anonymize after session |

### Protected Data Categories

| Category | Regulation | Requirements |
|----------|-----------|-------------|
| Personal data (EU residents) | GDPR | Consent, right to erasure, data portability |
| Personal data (California residents) | CCPA | Right to know, delete, opt-out of sale |
| Payment card data | PCI DSS | Never store raw card numbers; use tokenization |
| Health data | HIPAA | Only if applicable; requires BAA with providers |
| Children's data | COPPA | Age verification, parental consent if under 13 |

---

## Retention Policies

### Default Retention Schedule

| Data Category | Active Retention | Archive Period | Deletion |
|---------------|-----------------|----------------|----------|
| User account data | While account is active | 30 days after deletion request | Hard delete after archive |
| Authentication logs | 90 days | 1 year | Purge |
| Audit trail | 1 year active | 6 years archived | Purge after 7 years |
| Transaction records | While subscription active | 7 years (tax compliance) | Purge after 7 years |
| Usage analytics | 2 years detailed | Aggregate indefinitely | Delete detailed records |
| Support tickets | While account active | 2 years after resolution | Purge |
| Email communications | 1 year | Delete | Delete |
| Session data | Session duration | 30 days | Purge |
| Temporary files | 24 hours | None | Auto-delete |

### Retention Implementation

```sql
-- Example: automated cleanup of expired sessions
DELETE FROM sessions WHERE expires_at < NOW() - INTERVAL '30 days';

-- Example: anonymize old analytics
UPDATE analytics_events
SET user_id = NULL, ip_address = NULL
WHERE created_at < NOW() - INTERVAL '2 years';
```

### Data Deletion Process

1. **Soft delete** -- mark record as deleted, retain for archive period
2. **Anonymize** -- remove PII, keep aggregate data for analytics
3. **Hard delete** -- permanently remove from database and backups
4. **Cascade** -- identify and handle all related records

---

## Domain-Specific Taxonomy Template

Customize this section for your specific business domain.

### [Your Domain] Entities

```
[Domain Object 1]
  |-- [Attribute A]: [type] -- [description]
  |-- [Attribute B]: [type] -- [description]
  |-- [Relationship to Object 2]: [one-to-many / many-to-many]

[Domain Object 2]
  |-- [Attribute A]: [type] -- [description]
  |-- [Relationship to Object 3]: [one-to-one]
```

### Entity Relationship Map

```
[User] 1--* [Organization Membership] *--1 [Organization]
[Organization] 1--* [Subscription]
[Subscription] 1--* [Invoice]
[User] 1--* [Session]
[User] 1--* [Audit Log Entry]
[Organization] 1--* [YOUR_DOMAIN_ENTITY]
```

---

## Access Control Matrix

| Data Entity | Admin | Owner | Member | Viewer | Public |
|-------------|-------|-------|--------|--------|--------|
| User profile (own) | CRUD | CRUD | R | R | - |
| User profile (others) | CRUD | R | R | R | - |
| Organization settings | CRUD | CRUD | R | R | - |
| Billing information | CRUD | CRUD | - | - | - |
| Audit logs | R | R | - | - | - |
| [Your entity] | [perms] | [perms] | [perms] | [perms] | [perms] |

**Legend:** C=Create, R=Read, U=Update, D=Delete, -=No Access

---

## Maintenance

- Review taxonomy quarterly as your data model evolves
- Update classification when adding new data fields
- Audit retention compliance annually
- Review access control matrix when adding new roles
- Update PII inventory when adding new user-facing fields
