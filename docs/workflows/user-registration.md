# User Registration Workflow

## Overview

The registration workflow handles new user account creation through email,
social login, or SSO. It includes verification, initial profile setup,
and welcome sequence triggers.

---

## Trigger

- User clicks "Sign Up" or "Get Started" on the marketing site
- User receives and accepts a team invitation
- User initiates social login for the first time

## Actors

- **Visitor:** Unauthenticated person creating an account
- **System:** Auth service, database, email provider
- **External:** OAuth providers (Google, GitHub, etc.), SSO identity provider

---

## Flow Diagram

```mermaid
flowchart TD
    A([User Clicks Sign Up]) --> B{Registration Method?}
    B -->|Email| C[Show Email Registration Form]
    B -->|Social Login| D[Redirect to OAuth Provider]
    B -->|SSO| E[Redirect to SSO Provider]

    C --> F[Validate Input]
    F --> G{Valid?}
    G -->|No| H[Show Validation Errors]
    H --> C
    G -->|Yes| I{Email Already Exists?}
    I -->|Yes| J[Show "Account Exists" Message]
    J --> K[Offer Login or Password Reset]
    I -->|No| L[Create Account Record]
    L --> M[Send Verification Email]
    M --> N[Show "Check Your Email" Screen]
    N --> O{Clicks Verification Link?}
    O -->|Yes| P[Verify Email]
    O -->|Expired| Q[Show Expired Link Page]
    Q --> R[Resend Verification]
    R --> N

    D --> S{OAuth Successful?}
    S -->|Yes| T{Account Exists?}
    S -->|No| U[Show OAuth Error]
    U --> A
    T -->|Yes| V[Link OAuth to Existing Account]
    T -->|No| W[Create Account from OAuth Profile]

    E --> X{SSO Successful?}
    X -->|Yes| Y[Create or Update Account from SSO]
    X -->|No| Z[Show SSO Error]
    Z --> A

    P --> AA[Set Session Cookie]
    V --> AA
    W --> AA
    Y --> AA

    AA --> BB[Redirect to Onboarding]
    BB --> CC([Registration Complete])
```

---

## Registration Methods

### Email Registration

**Form Fields:**
| Field | Type | Required | Validation |
|-------|------|----------|------------|
| Email | email | Yes | Valid email format, not disposable domain |
| Password | password | Yes | Min 8 chars, 1 uppercase, 1 number, 1 special |
| Full Name | text | Yes | 2-100 characters |
| Terms accepted | checkbox | Yes | Must be checked |

**Password Requirements:**
- Minimum 8 characters
- At least 1 uppercase letter
- At least 1 number
- At least 1 special character
- Not in the common passwords list (top 10,000)
- Display strength indicator during input

### Social Login (OAuth 2.0)

**Supported Providers:**
| Provider | Data Retrieved | Notes |
|----------|---------------|-------|
| Google | Email, name, avatar | Most common for B2B SaaS |
| GitHub | Email, username, avatar | Good for developer tools |
| Microsoft | Email, name | Required for enterprise |
| [Your Provider] | [Fields] | [Notes] |

**OAuth Flow:**
1. User clicks provider button
2. Redirect to provider's authorization page
3. User grants consent
4. Provider redirects back with auth code
5. Server exchanges code for tokens
6. Fetch user profile from provider
7. Create or link account

### SSO (SAML / OIDC)

**Enterprise SSO Flow:**
1. User enters work email on login page
2. System looks up email domain in SSO configuration table
3. Redirect to organization's identity provider
4. User authenticates with their IdP
5. IdP posts assertion back to your callback URL
6. Parse assertion, extract user attributes
7. Create or update user account with SSO attributes
8. Provision into the correct organization

---

## Verification Flow

### Email Verification

1. Generate a cryptographically random token (32+ bytes)
2. Store token hash with expiry (24 hours) in the database
3. Send email with verification link: `https://app.example.com/auth/verify?token=TOKEN`
4. On click: validate token, mark email as verified, delete token
5. If expired: show expiry message with "Resend" button

### Rate Limiting

- Max 3 verification emails per email address per hour
- Max 5 registration attempts per IP per hour
- Use CAPTCHA after 2 failed attempts from the same IP

---

## Profile Setup

After verification, collect additional profile information:

| Field | Required | Default | Purpose |
|-------|----------|---------|---------|
| Display name | Yes | From registration | Shown in UI |
| Avatar | No | Generated initials | User identification |
| Timezone | No | Browser-detected | Scheduling, notifications |
| Role/Title | No | None | Personalization |
| How did you hear about us | No | None | Attribution tracking |

---

## Welcome Sequence

| Email | Timing | Content |
|-------|--------|---------|
| Welcome | Immediate (post-verify) | Thank them, link to first steps |
| Getting Started | +1 day | Top 3 features to try |
| Tips & Tricks | +3 days | Power user tips |
| Check-in | +7 days | How's it going? Offer help |
| Feature Highlight | +14 days | Showcase an underused feature |

---

## Decision Points

| Decision | Condition | Outcome |
|----------|-----------|---------|
| Registration method | User choice | Different auth flows |
| Email exists | Database lookup | Redirect to login or link accounts |
| OAuth account exists | Provider ID lookup | Link to existing vs create new |
| Email domain has SSO | Domain config lookup | Force SSO vs allow email/social |
| Invitation exists | Token in registration URL | Auto-join organization |

---

## Error Scenarios

| Error | Cause | User Sees | System Action |
|-------|-------|-----------|---------------|
| Duplicate email | Email already registered | "Account exists" with login link | Log attempt for security |
| Weak password | Fails complexity check | Inline error with requirements | Block submission |
| OAuth denied | User cancelled consent | "Login cancelled" message | Redirect back to signup |
| OAuth email mismatch | Different email than expected | Account linking prompt | Offer to link or create new |
| Verification expired | Link clicked after 24h | "Link expired" with resend button | Delete old token |
| Rate limited | Too many attempts | "Try again in X minutes" | Return 429, log for monitoring |
| Disposable email | Temporary email service | "Please use a permanent email" | Block registration |

---

## Security Considerations

- Hash passwords with bcrypt (cost factor 12+) or Argon2
- Store only token hashes, never raw tokens
- Rate-limit all registration endpoints
- Validate email format server-side (not just client-side)
- Log all registration attempts for security monitoring
- Sanitize all input before database insertion
- Set secure, httpOnly, sameSite cookies for sessions
- Implement CSRF protection on the registration form
