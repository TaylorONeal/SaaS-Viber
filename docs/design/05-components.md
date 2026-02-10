# Component Inventory

> Complete inventory of UI components. Track what exists, what variants are
> available, and how to use each component.

---

## Component Categories

- **Layout** -- Page structure, containers, grids
- **Navigation** -- Menus, breadcrumbs, tabs, pagination
- **Data Display** -- Cards, tables, lists, badges, avatars
- **Data Input** -- Forms, inputs, selects, checkboxes, file uploads
- **Feedback** -- Toasts, alerts, progress, skeletons, spinners
- **Overlay** -- Modals, sheets, popovers, tooltips, dropdowns

---

## Layout Components

| Component | Variants | Key Props | Usage Notes |
|-----------|----------|-----------|-------------|
| `Container` | default, narrow, wide | `maxWidth`, `padding` | Centers content with max-width |
| `Stack` | vertical, horizontal | `gap`, `align`, `justify` | Flex container with consistent spacing |
| `Grid` | 2-col, 3-col, 4-col, auto | `cols`, `gap`, `responsive` | CSS grid wrapper |
| `Section` | default, padded, full-bleed | `padding`, `background` | Page section with vertical spacing |
| `Sidebar Layout` | left, right | `sidebarWidth`, `collapsible` | Two-panel layout with sidebar |
| `Card` | default, outlined, elevated | `padding`, `hoverable` | Content container with border/shadow |
| `Divider` | horizontal, vertical | `spacing`, `label` | Visual separator |

---

## Navigation Components

| Component | Variants | Key Props | Usage Notes |
|-----------|----------|-----------|-------------|
| `Navbar` | default, transparent, compact | `logo`, `items`, `actions` | Top navigation bar |
| `Sidebar` | expanded, collapsed, mobile | `items`, `activeItem`, `onNavigate` | Vertical navigation |
| `Breadcrumb` | default, with-icons | `items`, `separator` | Page hierarchy indicator |
| `Tabs` | default, pills, underline | `items`, `activeTab`, `onChange` | Content section switching |
| `Pagination` | default, simple, cursor | `total`, `page`, `onPageChange` | Page navigation for lists |
| `Steps` | horizontal, vertical | `steps`, `current`, `status` | Multi-step process indicator |
| `Menu` | dropdown, context | `items`, `trigger` | Action menu |

---

## Data Display Components

| Component | Variants | Key Props | Usage Notes |
|-----------|----------|-----------|-------------|
| `Table` | default, striped, compact | `columns`, `data`, `sortable` | Tabular data display |
| `DataTable` | with-filters, with-pagination | `columns`, `data`, `searchable` | Full-featured data table |
| `Badge` | default, outline, dot | `variant`, `size`, `color` | Status indicators, counts |
| `Avatar` | image, initials, icon | `src`, `name`, `size` | User/entity representation |
| `Avatar Group` | default, stacked | `avatars`, `max`, `size` | Multiple avatars |
| `Stat Card` | default, with-trend | `label`, `value`, `trend` | KPI display |
| `Empty State` | default, with-action | `icon`, `title`, `description`, `action` | No-data placeholder |
| `List` | default, with-actions | `items`, `renderItem` | Vertical list of items |
| `Timeline` | default, compact | `items` | Chronological event display |
| `Code Block` | default, with-copy | `code`, `language`, `copyable` | Syntax-highlighted code |

---

## Data Input Components

| Component | Variants | Key Props | Usage Notes |
|-----------|----------|-----------|-------------|
| `Input` | default, with-icon, with-addon | `type`, `placeholder`, `error` | Text input field |
| `Textarea` | default, auto-resize | `rows`, `maxLength`, `error` | Multi-line text input |
| `Select` | default, searchable, multi | `options`, `value`, `onChange` | Dropdown selection |
| `Combobox` | default, creatable | `options`, `value`, `onSearch` | Searchable select with autocomplete |
| `Checkbox` | default, indeterminate | `checked`, `onChange`, `label` | Boolean toggle |
| `Radio Group` | default, cards | `options`, `value`, `onChange` | Single selection from options |
| `Switch` | default, with-label | `checked`, `onChange`, `size` | On/off toggle |
| `Slider` | default, range | `min`, `max`, `step`, `value` | Numeric range selection |
| `Date Picker` | single, range | `value`, `onChange`, `minDate` | Date selection |
| `File Upload` | button, dropzone | `accept`, `maxSize`, `onUpload` | File input |
| `Color Picker` | default, with-presets | `value`, `onChange`, `presets` | Color selection |
| `Form` | default | `onSubmit`, `schema` | Form wrapper with validation |
| `Form Field` | default | `label`, `error`, `required` | Label + input + error wrapper |

---

## Feedback Components

| Component | Variants | Key Props | Usage Notes |
|-----------|----------|-----------|-------------|
| `Toast` | success, error, warning, info | `title`, `description`, `duration` | Temporary notification |
| `Alert` | success, error, warning, info | `title`, `description`, `closable` | Persistent inline notification |
| `Progress` | bar, circular, steps | `value`, `max`, `label` | Progress indication |
| `Skeleton` | text, avatar, card, table | `width`, `height`, `lines` | Loading placeholder |
| `Spinner` | default, dots, pulse | `size`, `color` | Loading indicator |
| `Banner` | info, warning, promo | `message`, `action`, `dismissable` | Full-width notification |
| `Confirmation` | default, destructive | `title`, `description`, `onConfirm` | Action confirmation |

---

## Overlay Components

| Component | Variants | Key Props | Usage Notes |
|-----------|----------|-----------|-------------|
| `Dialog` | default, alert, form | `open`, `onClose`, `title` | Modal dialog |
| `Sheet` | right, left, bottom | `open`, `onClose`, `side` | Slide-in panel |
| `Popover` | default | `trigger`, `content`, `placement` | Contextual overlay |
| `Tooltip` | default | `content`, `placement`, `delay` | Hover hint |
| `Dropdown Menu` | default, with-icons | `trigger`, `items` | Action dropdown |
| `Command Palette` | default | `commands`, `onSelect` | Search-driven command interface |
| `Context Menu` | default | `items`, `trigger` | Right-click menu |

---

## shadcn/ui Base Components

These are installed and available from `@/components/ui/`:

```
accordion      alert          alert-dialog    avatar
badge          breadcrumb     button          calendar
card           checkbox       collapsible     command
context-menu   dialog         dropdown-menu   form
hover-card     input          label           menubar
navigation-menu  pagination  popover         progress
radio-group    scroll-area    select          separator
sheet          skeleton       slider          switch
table          tabs           textarea        toast
toggle         toggle-group   tooltip
```

### Customization Pattern

Extend shadcn/ui components by wrapping them:

```tsx
// src/components/ui/button.tsx -- shadcn/ui base (don't modify)
// src/components/shared/submit-button.tsx -- your extension

import { Button } from '@/components/ui/button';
import { Loader2 } from 'lucide-react';

interface SubmitButtonProps extends React.ComponentProps<typeof Button> {
  isLoading?: boolean;
}

export function SubmitButton({ isLoading, children, ...props }: SubmitButtonProps) {
  return (
    <Button disabled={isLoading} {...props}>
      {isLoading && <Loader2 className="mr-2 h-4 w-4 animate-spin" />}
      {children}
    </Button>
  );
}
```

---

## Custom Component Template

Use this when adding a new custom component:

```markdown
### [Component Name]

**Category:** [Layout / Navigation / Data Display / Data Input / Feedback / Overlay]
**Location:** `src/components/[category]/[component-name].tsx`
**Based on:** [shadcn/ui component or custom]

**Variants:**
- [variant 1]: [description]
- [variant 2]: [description]

**Props:**
| Prop | Type | Default | Description |
|------|------|---------|-------------|
| [prop] | [type] | [default] | [description] |

**Usage:**
\`\`\`tsx
<ComponentName prop="value" />
\`\`\`

**Accessibility:**
- [ARIA attributes]
- [Keyboard interaction]
```
