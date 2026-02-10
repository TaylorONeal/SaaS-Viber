# Data Interoperability

> Your users' data belongs to them. This document defines how your SaaS handles data ownership, portability, and compliance.

<!-- TEMPLATE: Data interoperability is increasingly important for SaaS products. -->
<!-- Users expect to be able to export their data, regulators require it, and it -->
<!-- builds trust. Fill in this template based on your data model and jurisdiction. -->

---

## Data Ownership Principles

<!-- TEMPLATE: Define your stance on data ownership. These principles should -->
<!-- align with your Terms of Service and Privacy Policy. -->

[YOUR_APP_NAME] operates under these data ownership principles:

1. **Users own their data.** We are custodians, not owners. All content created by users belongs to them.
2. **Data is portable.** Users can export their data in standard, machine-readable formats at any time.
3. **Data is deletable.** Users can request complete deletion of their data and account.
4. **Data use is transparent.** We clearly communicate what data we collect, why, and how it's used.
5. **Data is secure.** We protect user data with industry-standard encryption and access controls.

<!-- TEMPLATE: Customize these principles to match your product's values and -->
<!-- legal requirements. Remove or add principles as needed. -->

---

## Data Categories

<!-- TEMPLATE: Categorize all the data your application stores. -->
<!-- This helps with export, deletion, and compliance planning. -->

| Category | Description | Examples | Retention |
|----------|-------------|----------|-----------|
| **Account data** | User identity and authentication | Email, name, avatar, password hash | Until account deletion |
| **Profile data** | User-provided information | Bio, preferences, settings | Until account deletion |
| **Content data** | User-created content | [Your app's content types] | Until user/account deletion |
| **Usage data** | How users interact with the product | Page views, feature usage, session duration | [Your retention period] |
| **Billing data** | Payment and subscription information | Plan, invoices, payment method (via Stripe) | As required by law |
| **Communication data** | Messages and notifications | Support tickets, notification preferences | [Your retention period] |
| **System data** | Technical data for operations | Logs, error reports, performance metrics | [Your retention period] |

---

## Import Capabilities

<!-- TEMPLATE: Define what data users can import and in what formats. -->

### Supported Import Formats

| Data Type | Format(s) | Max Size | Notes |
|-----------|-----------|----------|-------|
| [Data type 1] | CSV, JSON | [Size] | [Notes] |
| [Data type 2] | [Formats] | [Size] | [Notes] |
| [Bulk import] | [Formats] | [Size] | [Notes] |

### Import API

<!-- TEMPLATE: Document your import API if you have one. -->

```
POST /api/v1/import/[resource]
Content-Type: multipart/form-data

Parameters:
  file: [file]           # The import file
  format: csv|json       # File format
  options: { ... }       # Import options (merge strategy, etc.)
```

### Migration from Competitors

<!-- TEMPLATE: If you support migration from specific competitors, document it here. -->

| Competitor | Migration Path | Automation Level |
|------------|---------------|-----------------|
| [Competitor 1] | [How to migrate] | [Manual / Semi-auto / Fully auto] |
| [Competitor 2] | [How to migrate] | [Manual / Semi-auto / Fully auto] |

---

## Export Capabilities

<!-- TEMPLATE: Define what data users can export and in what formats. -->
<!-- This is critical for GDPR compliance and user trust. -->

### Self-Service Export

Users can export their data at any time from **Settings > Data > Export**.

| Data Type | Format(s) | Includes |
|-----------|-----------|----------|
| **All user data** | JSON, CSV | Complete data archive |
| [Content type 1] | JSON, CSV, [native format] | [What's included] |
| [Content type 2] | JSON, CSV, [native format] | [What's included] |
| **Account data** | JSON | Profile, settings, preferences |
| **Billing history** | CSV, PDF | Invoices and payment history |

### Export API

```
GET /api/v1/export/[resource]
Accept: application/json | text/csv

Parameters:
  format: json|csv       # Output format
  date_from: [ISO date]  # Filter by date range (optional)
  date_to: [ISO date]    # Filter by date range (optional)
  include: [fields]      # Specific fields to include (optional)
```

### Full Data Export (GDPR/CCPA)

For a complete data export as required by privacy regulations:

```
POST /api/v1/export/full
```

This initiates an asynchronous export of all user data. The user receives an email with a download link when the export is ready. The export includes:

- All data categories listed above
- Data in machine-readable JSON format
- A manifest file describing the export contents
- Processing typically completes within [timeframe]

---

## API Access

<!-- TEMPLATE: Define how users and third parties can programmatically access data. -->

### REST API

| Resource | Endpoints | Auth Required |
|----------|-----------|--------------|
| [Resource 1] | `GET /api/v1/[resource]` | Yes |
| [Resource 2] | `GET /api/v1/[resource]` | Yes |
| User data | `GET /api/v1/me` | Yes |

### Rate Limits

| Plan | Requests/Minute | Requests/Day |
|------|----------------|-------------|
| Free | [Number] | [Number] |
| Pro | [Number] | [Number] |
| Enterprise | Custom | Custom |

### Webhooks

<!-- TEMPLATE: If your app supports webhooks, document the events. -->

| Event | Payload | Description |
|-------|---------|-------------|
| `[resource].created` | [Resource object] | Fired when a [resource] is created |
| `[resource].updated` | [Resource object] | Fired when a [resource] is updated |
| `[resource].deleted` | `{ id }` | Fired when a [resource] is deleted |

---

## Data Format Standards

<!-- TEMPLATE: Define the data formats and standards you follow. -->

### Output Formats

| Format | Content-Type | Use Case |
|--------|-------------|----------|
| **JSON** | `application/json` | API responses, full exports |
| **CSV** | `text/csv` | Spreadsheet-compatible exports |
| **PDF** | `application/pdf` | Reports and invoices |

### Schema Standards

- **Dates**: ISO 8601 format (`2024-01-15T09:30:00Z`)
- **IDs**: UUID v4 (`550e8400-e29b-41d4-a716-446655440000`)
- **Currency**: ISO 4217 codes with minor units (`{ "amount": 1999, "currency": "USD" }`)
- **Language**: BCP 47 tags (`en-US`, `fr-FR`)
- **Country**: ISO 3166-1 alpha-2 (`US`, `GB`, `DE`)

### API Versioning

The API is versioned via URL path (`/api/v1/`, `/api/v2/`). Deprecated versions receive a minimum of 12 months notice before removal.

---

## Vendor Lock-in Mitigation

<!-- TEMPLATE: Document how you minimize dependency on specific vendors. -->
<!-- This builds trust and demonstrates thoughtful architecture. -->

### Architecture Decisions

| Layer | Strategy | Implementation |
|-------|----------|---------------|
| **Database** | Standard SQL / portable schema | [Details] |
| **Auth** | Abstraction layer over auth provider | [Details] |
| **Storage** | S3-compatible API | [Details] |
| **Email** | Provider-agnostic interface | [Details] |
| **Payments** | Webhook-based integration | [Details] |

### Migration Path

If you decide to leave [YOUR_APP_NAME]:

1. **Export all data** using the full export feature
2. **Download via API** for programmatic migration
3. **Cancel subscription** -- your data remains available for [X days] after cancellation
4. **Request deletion** when migration is complete

### Open Standards Used

| Standard | Where Used | Why |
|----------|-----------|-----|
| OAuth 2.0 / OIDC | Authentication | Industry standard, provider-portable |
| REST | API | Universal, tooling-rich |
| JSON Schema | Data validation | Machine-readable, language-agnostic |
| OpenAPI 3.0 | API documentation | Generates clients for any language |
| [Standard] | [Where] | [Why] |

---

## GDPR Compliance

<!-- TEMPLATE: Fill in if you serve users in the European Union. -->
<!-- Consult a lawyer for your specific situation. -->

### Data Subject Rights

| Right | How We Support It |
|-------|------------------|
| **Right to access** | Self-service data export (Settings > Data > Export) |
| **Right to rectification** | Users can edit all personal data in their profile |
| **Right to erasure** | Account deletion removes all personal data within [X days] |
| **Right to portability** | Full data export in machine-readable JSON format |
| **Right to restrict processing** | [How you handle this] |
| **Right to object** | [How you handle this] |

### Data Processing

| Purpose | Legal Basis | Data Involved |
|---------|-------------|--------------|
| Account management | Contract performance | Email, name, password |
| Service delivery | Contract performance | [Content data types] |
| Analytics | Legitimate interest | Usage data (anonymized) |
| Marketing emails | Consent | Email |
| Error tracking | Legitimate interest | Technical logs (no PII) |

### Data Processing Agreements

We have DPAs in place with all sub-processors:

| Sub-processor | Purpose | Location |
|--------------|---------|----------|
| [Cloud provider] | Hosting | [Region] |
| [Auth provider] | Authentication | [Region] |
| [Payment provider] | Billing | [Region] |
| [Email provider] | Transactional email | [Region] |
| [Monitoring tool] | Error tracking | [Region] |

---

## CCPA Compliance

<!-- TEMPLATE: Fill in if you serve users in California. -->
<!-- Consult a lawyer for your specific situation. -->

### Consumer Rights

| Right | How We Support It |
|-------|------------------|
| **Right to know** | Privacy Policy details all data collection |
| **Right to delete** | Account deletion feature |
| **Right to opt-out** | Cookie preferences and marketing opt-out |
| **Right to non-discrimination** | Equal service regardless of privacy choices |

### Data Sale Disclosure

[YOUR_APP_NAME] does **not** sell personal information as defined by the CCPA.

<!-- TEMPLATE: If you do share data with third parties in ways that could -->
<!-- constitute a "sale" under CCPA, disclose it here. -->

---

## Contact

For data-related inquiries:

- **Data Protection Officer**: [NAME] ([EMAIL])
- **Privacy inquiries**: privacy@[YOUR_DOMAIN]
- **Data export requests**: [How to request]
- **Data deletion requests**: [How to request]

---

*Last updated: [DATE]. This document should be reviewed quarterly and updated whenever data handling practices change.*
