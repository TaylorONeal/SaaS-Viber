# Role-Based Access Control (RBAC) — [YOUR_APP_NAME]

> **Purpose:** Define who can do what in the application. This document covers role
> hierarchy, feature access matrix, route protection, API authorization, and
> multi-tenant considerations.
>
> **Last Updated:** [DATE]
> **Status:** [Template / In Progress / Complete]

---

## Role Hierarchy

> Define the roles in your system from most privileged to least privileged.
> Each role inherits the permissions of the roles below it (unless explicitly restricted).

```
┌─────────────────────────────────────┐
│         PLATFORM ADMIN              │  ← Full system access (internal team only)
├─────────────────────────────────────┤
│         ORG ADMIN                   │  ← Full access within their organization
├─────────────────────────────────────┤
│         ORG MANAGER                 │  ← Manage operations, limited settings
├─────────────────────────────────────┤
│         ORG MEMBER                  │  ← Standard user within an organization
├─────────────────────────────────────┤
│         ORG VIEWER                  │  ← Read-only access within an organization
├─────────────────────────────────────┤
│         PUBLIC / UNAUTHENTICATED    │  ← Marketing pages, login, signup only
└─────────────────────────────────────┘
```

### Role Definitions

| Role | Slug | Scope | Description |
|---|---|---|---|
| Platform Admin | `platform_admin` | System-wide | Internal team. Can access all organizations, manage the platform, view system metrics. |
| Org Admin | `org_admin` | Organization | Owner of the organization. Can manage billing, members, settings, and all data. |
| Org Manager | `org_manager` | Organization | Manages day-to-day operations. Can create/edit/delete domain entities but cannot change billing or member roles. |
| Org Member | `org_member` | Organization | Standard user. Can perform core workflows and view data within their scope. |
| Org Viewer | `org_viewer` | Organization | Read-only access. Can view data but cannot create, edit, or delete anything. |
| Public | `public` | None | Unauthenticated visitor. Can only see marketing pages, login, and signup. |

### Custom Roles (Optional)

> If your application needs more granular roles, define them here.

| Role | Inherits From | Additional Permissions | Use Case |
|---|---|---|---|
| [Custom Role 1] | `org_member` | [List permissions] | [When this role is used] |
| [Custom Role 2] | `org_viewer` | [List permissions] | [When this role is used] |

---

## Feature Access Matrix

> Map every feature to the roles that can access it. Use checkmarks for allowed,
> dashes for denied, and notes for conditional access.

### Core Features

| Feature | Platform Admin | Org Admin | Org Manager | Org Member | Org Viewer | Public |
|---|---|---|---|---|---|---|
| View Dashboard | Yes | Yes | Yes | Yes | Yes | — |
| Create [Core Entity] | Yes | Yes | Yes | Yes | — | — |
| Edit [Core Entity] | Yes | Yes | Yes | Own only | — | — |
| Delete [Core Entity] | Yes | Yes | Yes | — | — | — |
| View [Core Entity] List | Yes | Yes | Yes | Yes | Yes | — |
| View [Core Entity] Detail | Yes | Yes | Yes | Yes | Yes | — |
| Search / Filter | Yes | Yes | Yes | Yes | Yes | — |

### Organization Management

| Feature | Platform Admin | Org Admin | Org Manager | Org Member | Org Viewer | Public |
|---|---|---|---|---|---|---|
| View Org Settings | Yes | Yes | Yes | — | — | — |
| Edit Org Settings | Yes | Yes | — | — | — | — |
| Invite Members | Yes | Yes | Yes | — | — | — |
| Remove Members | Yes | Yes | — | — | — | — |
| Change Member Roles | Yes | Yes | — | — | — | — |
| View Members List | Yes | Yes | Yes | Yes | — | — |

### Billing & Subscription

| Feature | Platform Admin | Org Admin | Org Manager | Org Member | Org Viewer | Public |
|---|---|---|---|---|---|---|
| View Billing Info | Yes | Yes | — | — | — | — |
| Change Plan | Yes | Yes | — | — | — | — |
| Update Payment Method | Yes | Yes | — | — | — | — |
| View Invoices | Yes | Yes | — | — | — | — |
| Cancel Subscription | Yes | Yes | — | — | — | — |

### Platform Administration

| Feature | Platform Admin | Org Admin | Org Manager | Org Member | Org Viewer | Public |
|---|---|---|---|---|---|---|
| View All Organizations | Yes | — | — | — | — | — |
| Impersonate User | Yes | — | — | — | — | — |
| View System Metrics | Yes | — | — | — | — | — |
| Manage Feature Flags | Yes | — | — | — | — | — |
| View Audit Logs (System) | Yes | — | — | — | — | — |
| View Audit Logs (Org) | Yes | Yes | — | — | — | — |

---

## Route Protection Patterns

### Middleware-Based Protection

```typescript
// src/middleware/auth.ts

import { NextRequest, NextResponse } from 'next/server';

// Define route access rules
const routeRoles: Record<string, string[]> = {
  '/dashboard':        ['org_admin', 'org_manager', 'org_member', 'org_viewer'],
  '/[entities]':       ['org_admin', 'org_manager', 'org_member', 'org_viewer'],
  '/[entities]/new':   ['org_admin', 'org_manager', 'org_member'],
  '/[entities]/*/edit':['org_admin', 'org_manager', 'org_member'],
  '/settings':         ['org_admin', 'org_manager'],
  '/billing':          ['org_admin'],
  '/members':          ['org_admin', 'org_manager', 'org_member'],
  '/admin':            ['platform_admin'],
};

export function middleware(request: NextRequest) {
  const { pathname } = request.nextUrl;
  const userRole = getUserRole(request); // Extract from session/JWT

  const requiredRoles = findMatchingRoute(pathname, routeRoles);

  if (requiredRoles && !requiredRoles.includes(userRole)) {
    return NextResponse.redirect(new URL('/unauthorized', request.url));
  }

  return NextResponse.next();
}
```

### Component-Level Protection

```tsx
// src/components/auth/RequireRole.tsx

interface RequireRoleProps {
  roles: string[];
  children: React.ReactNode;
  fallback?: React.ReactNode;
}

export function RequireRole({ roles, children, fallback = null }: RequireRoleProps) {
  const { user } = useAuth();

  if (!user || !roles.includes(user.role)) {
    return <>{fallback}</>;
  }

  return <>{children}</>;
}

// Usage:
// <RequireRole roles={['org_admin', 'org_manager']}>
//   <DeleteButton />
// </RequireRole>
```

### Hook-Based Permission Check

```typescript
// src/hooks/usePermission.ts

type Permission =
  | 'create:[entity]'
  | 'edit:[entity]'
  | 'delete:[entity]'
  | 'view:[entity]'
  | 'manage:members'
  | 'manage:billing'
  | 'manage:settings'
  | 'admin:platform';

const rolePermissions: Record<string, Permission[]> = {
  platform_admin: ['*'], // All permissions
  org_admin:      ['create:[entity]', 'edit:[entity]', 'delete:[entity]', 'view:[entity]',
                   'manage:members', 'manage:billing', 'manage:settings'],
  org_manager:    ['create:[entity]', 'edit:[entity]', 'delete:[entity]', 'view:[entity]',
                   'manage:members'],
  org_member:     ['create:[entity]', 'edit:[entity]', 'view:[entity]'],
  org_viewer:     ['view:[entity]'],
};

export function usePermission(permission: Permission): boolean {
  const { user } = useAuth();
  if (!user) return false;

  const permissions = rolePermissions[user.role] || [];
  return permissions.includes('*') || permissions.includes(permission);
}
```

---

## API Authorization Patterns

### Middleware Pattern

```typescript
// src/api/middleware/authorize.ts

export function authorize(...allowedRoles: string[]) {
  return (req: Request, res: Response, next: NextFunction) => {
    const user = req.user; // Set by auth middleware

    if (!user) {
      return res.status(401).json({ error: 'Authentication required' });
    }

    if (!allowedRoles.includes(user.role)) {
      return res.status(403).json({ error: 'Insufficient permissions' });
    }

    next();
  };
}

// Usage:
// router.delete('/[entities]/:id', authorize('org_admin', 'org_manager'), deleteEntity);
```

### Resource-Level Authorization

```typescript
// src/api/middleware/authorizeResource.ts

// Check that the user has access to the specific resource (not just the role)
export async function authorizeResource(
  userId: string,
  resourceId: string,
  resourceType: string,
  action: 'read' | 'write' | 'delete'
): Promise<boolean> {
  // 1. Get the user's role within the organization that owns this resource
  const membership = await getMembershipForResource(userId, resourceId, resourceType);

  if (!membership) return false;

  // 2. Check role-based permission
  const hasPermission = checkRolePermission(membership.role, resourceType, action);

  // 3. Check ownership for "own only" permissions
  if (!hasPermission) {
    const isOwner = await checkResourceOwnership(userId, resourceId, resourceType);
    return isOwner && action !== 'delete'; // Owners can edit but not always delete
  }

  return hasPermission;
}
```

### Row-Level Security (Database Level)

```sql
-- PostgreSQL / Supabase RLS Policies

-- Users can only see data in their organizations
CREATE POLICY "tenant_isolation" ON [core_entity_table]
  FOR ALL
  USING (
    organization_id IN (
      SELECT organization_id FROM memberships
      WHERE user_id = auth.uid()
    )
  );

-- Only admins and managers can insert
CREATE POLICY "insert_policy" ON [core_entity_table]
  FOR INSERT
  WITH CHECK (
    EXISTS (
      SELECT 1 FROM memberships
      WHERE user_id = auth.uid()
        AND organization_id = [core_entity_table].organization_id
        AND role IN ('org_admin', 'org_manager', 'org_member')
    )
  );

-- Only admins and managers can delete
CREATE POLICY "delete_policy" ON [core_entity_table]
  FOR DELETE
  USING (
    EXISTS (
      SELECT 1 FROM memberships
      WHERE user_id = auth.uid()
        AND organization_id = [core_entity_table].organization_id
        AND role IN ('org_admin', 'org_manager')
    )
  );
```

---

## Multi-Tenant Considerations

### Organization Switching

Users may belong to multiple organizations. The UI must clearly indicate which organization is currently active.

```typescript
// Current organization is determined by:
// Option A: URL path — /org/[org_slug]/dashboard
// Option B: Session/cookie — stored after org selection
// Option C: Subdomain — [org_slug].[YOUR_DOMAIN].com

interface OrgContext {
  currentOrg: Organization;
  userRole: string; // Role in current org (may differ per org)
  switchOrg: (orgId: string) => void;
}
```

### Cross-Org Access Prevention

| Rule | Implementation |
|---|---|
| Users cannot access another org's data | RLS policies + API middleware |
| API requests must include org context | Extract from session, not from request body |
| Admin impersonation is logged | Audit log entry for every impersonation action |
| Org switching resets all context | Clear caches, re-fetch permissions |

### Plan-Based Feature Gating (Entitlement)

> Separate from RBAC. Even if a user has the role-based permission, the org's
> plan may not include the feature.

```typescript
// src/hooks/useEntitlement.ts

export function useEntitlement(feature: string): boolean {
  const { currentOrg } = useOrg();
  const plan = currentOrg.subscription?.plan;

  if (!plan) return false;
  return plan.features.includes(feature);
}

// Usage: Check both role AND entitlement
// const canUseAdvancedReports =
//   usePermission('view:reports') && useEntitlement('advanced_reports');
```

---

## Implementation Checklist

- [ ] Role hierarchy defined and documented
- [ ] Feature access matrix completed for all features
- [ ] Route middleware protecting all authenticated routes
- [ ] Component-level `<RequireRole>` wrapper in use
- [ ] `usePermission` hook available for conditional UI rendering
- [ ] API authorization middleware on all endpoints
- [ ] Row-Level Security policies on all tenant-scoped tables
- [ ] Organization switching correctly resets role context
- [ ] Plan-based entitlement checks separate from role checks
- [ ] Audit logging for permission-sensitive actions
- [ ] Tests for each role accessing each protected resource

---

## Prompt Guide Reference

See [PromptGuide-Architecture.md](./PromptGuide-Architecture.md) for the "Generate Role Access Control" prompt.

---

*Status: Template*
*Next review: [DATE]*
