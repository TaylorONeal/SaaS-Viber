# Audit & Compliance — [YOUR_APP_NAME]

> **Purpose:** Identify which compliance frameworks apply to your SaaS, define audit
> logging requirements, data retention policies, and security controls.
>
> **Last Updated:** [DATE]
> **Status:** [Template / In Progress / Complete]

---

## Compliance Framework Decision Tree

> Walk through this decision tree to determine which frameworks apply to your product.

```
START: What data does your application handle?

├── Personal data of EU residents?
│   └── YES → GDPR applies
│
├── Personal data of California residents?
│   └── YES → CCPA applies
│
├── Protected Health Information (PHI)?
│   └── YES → HIPAA applies (if US healthcare)
│
├── Payment card data?
│   └── YES → PCI DSS applies
│       └── Do you store card numbers directly?
│           ├── YES → Full PCI DSS compliance required
│           └── NO (using Stripe/Braintree) → SAQ-A (simplified) may suffice
│
├── Handling data for enterprise customers?
│   └── YES → SOC 2 Type II likely expected
│
├── Handling data for government entities?
│   └── YES → FedRAMP or equivalent may apply
│
└── None of the above?
    └── Still follow security best practices — compliance frameworks
        provide a useful checklist even if not legally required.
```

### Framework Applicability for [YOUR_APP_NAME]

| Framework | Applies? | Reason | Priority | Target Date |
|---|---|---|---|---|
| SOC 2 Type II | [Yes/No/TBD] | [e.g., "Enterprise customers require it"] | [High/Medium/Low] | [Date] |
| GDPR | [Yes/No/TBD] | [e.g., "We serve EU customers"] | [Priority] | [Date] |
| CCPA | [Yes/No/TBD] | [e.g., "We serve California residents"] | [Priority] | [Date] |
| HIPAA | [Yes/No/TBD] | [e.g., "We handle health data"] | [Priority] | [Date] |
| PCI DSS | [Yes/No/TBD] | [e.g., "We process payments via Stripe"] | [Priority] | [Date] |
| [Other] | [Yes/No/TBD] | [Reason] | [Priority] | [Date] |

---

## Framework Summaries

### SOC 2 Type II
- **What:** An audit of your organization's controls over security, availability, processing integrity, confidentiality, and privacy.
- **Who needs it:** SaaS companies selling to enterprises. Often a requirement in procurement.
- **Key requirements:**
  - Access controls and authentication
  - Encryption at rest and in transit
  - Monitoring and alerting
  - Incident response procedures
  - Change management processes
  - Vendor management
- **Effort:** 3-6 months to prepare, then annual audit ($20K-$100K for the audit)

### GDPR (General Data Protection Regulation)
- **What:** EU regulation governing the processing of personal data of EU residents.
- **Who needs it:** Any company processing data of EU residents, regardless of where the company is based.
- **Key requirements:**
  - Lawful basis for processing
  - Right to access, rectification, and erasure
  - Data portability
  - Privacy by design
  - Data Protection Impact Assessments (DPIA)
  - Data Processing Agreements (DPA) with vendors
  - 72-hour breach notification
- **Penalties:** Up to 4% of annual global turnover or 20M EUR

### CCPA (California Consumer Privacy Act)
- **What:** California law giving residents control over their personal data.
- **Who needs it:** Companies meeting revenue or data volume thresholds for California residents.
- **Key requirements:**
  - Right to know what data is collected
  - Right to delete personal data
  - Right to opt out of data sale
  - "Do Not Sell My Personal Information" link
  - Updated privacy policy

### HIPAA (Health Insurance Portability and Accountability Act)
- **What:** US regulation for protecting health information.
- **Who needs it:** Healthcare providers, health plans, clearinghouses, and their business associates.
- **Key requirements:**
  - Business Associate Agreements (BAA)
  - Encryption of PHI at rest and in transit
  - Access controls and audit trails
  - Physical safeguards
  - Breach notification within 60 days
- **Note:** Requires BAA with cloud providers (AWS, GCP, Azure all offer this)

### PCI DSS (Payment Card Industry Data Security Standard)
- **What:** Standards for securely handling credit card information.
- **Who needs it:** Any entity that stores, processes, or transmits cardholder data.
- **Key requirements:**
  - If using Stripe/Braintree/etc. and never touching raw card numbers, you may qualify for SAQ-A (Self-Assessment Questionnaire A), which is minimal
  - Secure network architecture
  - Encryption of card data
  - Regular vulnerability scans
  - Access control measures

---

## Audit Logging Requirements

### What to Log

| Event Category | Events | Priority |
|---|---|---|
| Authentication | Login, logout, failed login, password reset, MFA events | High |
| Authorization | Permission denied, role changed, impersonation started/ended | High |
| Data Access | View sensitive data, export data, download reports | Medium |
| Data Mutation | Create, update, delete of any entity | High |
| Billing | Plan changed, payment processed, payment failed, refund | High |
| Configuration | Settings changed, feature flag toggled, integration configured | Medium |
| System | Deployment, migration, error threshold exceeded | Medium |

### Audit Log Schema

```sql
CREATE TABLE audit_logs (
    id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    timestamp     TIMESTAMPTZ NOT NULL DEFAULT NOW(),

    -- Who
    actor_id      UUID REFERENCES users(id),
    actor_email   TEXT,                          -- Denormalized for persistence
    actor_role    TEXT,
    actor_ip      INET,
    actor_agent   TEXT,                          -- User agent string

    -- What
    action        TEXT NOT NULL,                 -- e.g., 'user.login', 'entity.create'
    entity_type   TEXT,                          -- e.g., 'user', '[core_entity]'
    entity_id     UUID,
    description   TEXT,                          -- Human-readable description

    -- Context
    organization_id UUID REFERENCES organizations(id),
    metadata      JSONB DEFAULT '{}',           -- Additional structured data
    changes       JSONB DEFAULT '{}',           -- Before/after for mutations

    -- Compliance
    retention_until TIMESTAMPTZ                 -- When this log can be deleted
);

-- Indexes for common query patterns
CREATE INDEX idx_audit_timestamp ON audit_logs(timestamp);
CREATE INDEX idx_audit_org ON audit_logs(organization_id);
CREATE INDEX idx_audit_actor ON audit_logs(actor_id);
CREATE INDEX idx_audit_entity ON audit_logs(entity_type, entity_id);
CREATE INDEX idx_audit_action ON audit_logs(action);
```

### Audit Log Implementation Pattern

```typescript
// src/services/auditLog.ts

interface AuditEntry {
  action: string;
  entityType?: string;
  entityId?: string;
  description?: string;
  metadata?: Record<string, unknown>;
  changes?: { before: Record<string, unknown>; after: Record<string, unknown> };
}

export async function logAudit(
  actor: { id: string; email: string; role: string },
  organizationId: string,
  entry: AuditEntry,
  request?: Request
): Promise<void> {
  await db.insert('audit_logs', {
    actor_id: actor.id,
    actor_email: actor.email,
    actor_role: actor.role,
    actor_ip: request?.ip,
    actor_agent: request?.headers?.['user-agent'],
    organization_id: organizationId,
    ...entry,
  });
}

// Usage:
// await logAudit(user, orgId, {
//   action: '[entity].create',
//   entityType: '[entity]',
//   entityId: newEntity.id,
//   description: `Created [entity] "${newEntity.name}"`,
//   metadata: { source: 'web' },
// });
```

### Immutability Rules
- Audit logs **must never be updated or deleted** through the application
- Use database-level protections (no UPDATE/DELETE grants, or use an append-only table)
- Consider write-once storage for long-term retention (e.g., S3 with Object Lock)

---

## Data Retention Policy

### Retention Schedule

| Data Category | Retention Period | After Expiry | Legal Basis |
|---|---|---|---|
| User account data | Duration of account + [X] days | Delete or anonymize | [Contract / Consent] |
| Domain entity data | Duration of account + [X] days | Delete or anonymize | [Contract] |
| Payment records | [X] years (often 7 years for tax) | Archive to cold storage | [Legal obligation] |
| Audit logs | [X] years (often 1-7 years) | Archive or delete | [Compliance requirement] |
| Analytics events | [X] months | Aggregate and delete raw | [Legitimate interest] |
| Session / auth tokens | [X] hours/days after expiry | Delete | [Technical necessity] |
| Backups | [X] days rolling | Overwrite with newer backups | [Legitimate interest] |
| Support tickets | [X] years after resolution | Archive | [Contract] |

### Data Deletion Process

1. **Identify data to delete:** Query for records past retention period
2. **Verify no legal hold:** Check if any legal or audit hold applies
3. **Delete or anonymize:** Remove PII while preserving aggregate data where needed
4. **Log the deletion:** Record what was deleted and when (in audit log)
5. **Verify deletion from backups:** Ensure backups older than retention are rotated out

### Right to Erasure (GDPR Article 17)

When a user requests data deletion:
- [ ] Delete user profile data
- [ ] Delete or anonymize user-generated content
- [ ] Remove user from all organizations
- [ ] Cancel active subscriptions
- [ ] Remove from email lists
- [ ] Delete from third-party integrations (analytics, email provider, etc.)
- [ ] Retain audit logs (with anonymized actor) for compliance
- [ ] Confirm deletion to the user within [X] days

---

## Security Controls Checklist

### Authentication
- [ ] Multi-factor authentication (MFA) available
- [ ] Password complexity requirements enforced
- [ ] Account lockout after [X] failed attempts
- [ ] Session timeout after [X] minutes of inactivity
- [ ] Secure password reset flow (token-based, time-limited)

### Encryption
- [ ] Data encrypted at rest (AES-256 or equivalent)
- [ ] Data encrypted in transit (TLS 1.2+ for all connections)
- [ ] Sensitive fields encrypted at the application level (if applicable)
- [ ] Encryption keys managed via KMS (not hardcoded)

### Network Security
- [ ] HTTPS enforced (HSTS headers)
- [ ] CORS configured to allow only trusted origins
- [ ] Rate limiting on authentication and API endpoints
- [ ] DDoS protection (CDN/WAF)
- [ ] Security headers (CSP, X-Frame-Options, X-Content-Type-Options)

### Application Security
- [ ] Input validation on all user inputs
- [ ] SQL injection prevention (parameterized queries / ORM)
- [ ] XSS prevention (output encoding, CSP)
- [ ] CSRF protection (tokens or SameSite cookies)
- [ ] File upload validation (type, size, content scanning)
- [ ] Dependency vulnerability scanning (automated)

### Access Control
- [ ] Principle of least privilege for all roles
- [ ] Row-level security on tenant-scoped data
- [ ] API keys scoped to specific permissions
- [ ] Admin actions require re-authentication
- [ ] Service accounts use minimal required permissions

### Monitoring & Incident Response
- [ ] Centralized logging (all application and infrastructure logs)
- [ ] Alerting on security events (failed logins, permission denied spikes)
- [ ] Incident response plan documented
- [ ] Regular security reviews / penetration testing
- [ ] Vulnerability disclosure policy published

---

## Prompt Guide Reference

See [PromptGuide-Architecture.md](./PromptGuide-Architecture.md) for the "Generate Security Architecture" prompt.

---

*Status: Template*
*Next review: [DATE]*
