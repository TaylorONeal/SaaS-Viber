# Internationalization & Localization Planning — [YOUR_APP_NAME]

> **Purpose:** Plan and execute the internationalization (i18n) and localization (l10n)
> of your SaaS application. This template provides a framework for auditing translatable
> content, selecting libraries, prioritizing languages, and implementing in phases.
>
> **Last Updated:** [DATE]
> **i18n Status:** [Not Started / Planning / In Progress / Complete]

---

## Terminology

| Term | Abbreviation | Meaning |
|---|---|---|
| Internationalization | i18n | Engineering your app to support multiple languages/locales |
| Localization | l10n | Translating and adapting content for a specific locale |
| Locale | — | Language + region combination (e.g., `en-US`, `fr-FR`, `ja-JP`) |
| RTL | — | Right-to-left text direction (Arabic, Hebrew, etc.) |
| ICU | — | International Components for Unicode — message formatting standard |

---

## String Audit Framework

> Before you can localize, you need to know what needs translating.

### Step 1: Identify String Sources

| Source | Location | Estimated Count | Priority |
|---|---|---|---|
| UI Labels & Buttons | Components (`src/components/`) | [X] | High |
| Form Validation Messages | Validation schemas / form logic | [X] | High |
| Error Messages | API responses, error boundaries | [X] | High |
| Email Templates | `src/emails/` or email service | [X] | Medium |
| Notification Text | Notification system | [X] | Medium |
| Static Pages | About, Terms, Privacy, FAQ | [X] | Medium |
| Onboarding / Tooltips | Onboarding flow, help text | [X] | Medium |
| Admin Panel Text | Admin-only UI | [X] | Low |
| PDF / Export Templates | Report generation | [X] | Low |
| **Total** | | **[X]** | |

### Step 2: Audit Script

Run this script (or adapt it) to count hardcoded strings in your codebase:

```bash
# Count potential hardcoded strings in React/JSX components
# Adjust the path and patterns for your project structure

# Find strings in JSX
grep -rn ">[A-Z][a-z]" src/components/ --include="*.tsx" --include="*.jsx" | wc -l

# Find strings in attributes (placeholder, title, aria-label, etc.)
grep -rn 'placeholder="[A-Z]' src/ --include="*.tsx" --include="*.jsx" | wc -l
grep -rn 'title="[A-Z]' src/ --include="*.tsx" --include="*.jsx" | wc -l
grep -rn 'aria-label="[A-Z]' src/ --include="*.tsx" --include="*.jsx" | wc -l

# Find strings in validation/error messages
grep -rn '"[A-Z][a-z].*[a-z]"' src/ --include="*.ts" --include="*.tsx" | wc -l
```

### Step 3: Categorize Strings

| Category | Count | Extract Method | Notes |
|---|---|---|---|
| Static UI text | [X] | Automated extraction | Button labels, headings, descriptions |
| Dynamic text (with variables) | [X] | Manual review | "Hello, {name}" patterns |
| Pluralized text | [X] | Manual review | "1 item" vs "2 items" |
| Date/time formats | [X] | Library-handled | Use Intl API or library |
| Currency/number formats | [X] | Library-handled | Use Intl API or library |
| Legal text | [X] | Separate translation | Terms, privacy policy |
| User-generated content | N/A | Not translated | Stored as-is |

---

## Library Recommendation

### Recommended: react-i18next

| Criterion | react-i18next | react-intl | LinguiJS |
|---|---|---|---|
| Bundle size | ~15KB | ~25KB | ~5KB |
| React support | Excellent | Excellent | Excellent |
| TypeScript support | Excellent | Good | Excellent |
| Pluralization | ICU / built-in | ICU | ICU |
| Interpolation | `{{variable}}` | `{variable}` | `{variable}` |
| Namespacing | Yes | No (flat) | Yes |
| Lazy loading | Yes | Manual | Yes |
| SSR support | Yes | Yes | Yes |
| Community size | Largest | Large | Growing |
| Extraction tools | i18next-parser | formatjs CLI | LinguiJS CLI |

### Setup Skeleton (react-i18next)

```typescript
// src/i18n/config.ts
import i18n from 'i18next';
import { initReactI18next } from 'react-i18next';
import Backend from 'i18next-http-backend';
import LanguageDetector from 'i18next-browser-languagedetector';

i18n
  .use(Backend)
  .use(LanguageDetector)
  .use(initReactI18next)
  .init({
    fallbackLng: '[YOUR_DEFAULT_LOCALE]',
    supportedLngs: ['[LOCALE_1]', '[LOCALE_2]', '[LOCALE_3]'],
    ns: ['common', 'auth', 'dashboard', '[YOUR_NAMESPACES]'],
    defaultNS: 'common',
    interpolation: {
      escapeValue: false, // React already escapes
    },
    backend: {
      loadPath: '/locales/{{lng}}/{{ns}}.json',
    },
  });

export default i18n;
```

### File Structure

```
src/
├── i18n/
│   ├── config.ts                    # i18n configuration
│   └── types.ts                     # TypeScript types for translations
├── locales/
│   ├── en/
│   │   ├── common.json              # Shared strings (nav, buttons, labels)
│   │   ├── auth.json                # Login, signup, password reset
│   │   ├── dashboard.json           # Dashboard-specific strings
│   │   ├── [feature].json           # One namespace per feature area
│   │   └── errors.json              # Error messages
│   ├── [locale-2]/
│   │   ├── common.json
│   │   └── ...
│   └── [locale-3]/
│       ├── common.json
│       └── ...
```

---

## Target Language Selection Framework

### Selection Criteria

Score each candidate language (1-5) on these factors:

| Language | Market Size | Revenue Potential | User Requests | Competition Gap | Translation Cost | Total Score |
|---|---|---|---|---|---|---|
| English (baseline) | — | — | — | — | — | — |
| [Language 2] | [1-5] | [1-5] | [1-5] | [1-5] | [1-5] | [Sum] |
| [Language 3] | [1-5] | [1-5] | [1-5] | [1-5] | [1-5] | [Sum] |
| [Language 4] | [1-5] | [1-5] | [1-5] | [1-5] | [1-5] | [Sum] |
| [Language 5] | [1-5] | [1-5] | [1-5] | [1-5] | [1-5] | [Sum] |

### Recommended Priority by SaaS Domain

| If Your Market Is... | Consider First | Consider Next |
|---|---|---|
| Global B2B | Spanish, French, German, Japanese | Portuguese, Korean, Chinese (Simplified) |
| US / Americas | Spanish | Portuguese, French (Canadian) |
| Europe | German, French, Spanish | Italian, Dutch, Polish |
| Asia-Pacific | Japanese, Korean, Chinese (Simplified) | Thai, Vietnamese, Indonesian |
| Middle East / Africa | Arabic | Turkish, Swahili, French |

---

## Phased Implementation Plan

### Phase 1: Infrastructure (i18n Setup)
- [ ] Install i18n library and dependencies
- [ ] Configure i18n (languages, namespaces, fallbacks)
- [ ] Set up locale file structure
- [ ] Create extraction script for hardcoded strings
- [ ] Add language switcher component
- [ ] Configure date/time/number formatting with `Intl` API
- [ ] Set up CI check for missing translation keys

**Estimated Effort:** [X] developer-days

### Phase 2: String Extraction (English Baseline)
- [ ] Extract all hardcoded strings from UI components
- [ ] Extract validation and error messages
- [ ] Extract email template strings
- [ ] Extract notification strings
- [ ] Create English locale files (this is your source of truth)
- [ ] Verify all strings render correctly from locale files
- [ ] Remove all hardcoded strings from components

**Estimated Effort:** [X] developer-days (scales with string count)

### Phase 3: First Target Language
- [ ] Translate all namespaces for [FIRST_TARGET_LANGUAGE]
- [ ] Review translations with native speaker
- [ ] Test all user flows in target language
- [ ] Handle text expansion (some languages use 30-40% more space)
- [ ] Test email templates in target language
- [ ] Update screenshots and visual tests

**Estimated Effort:** [X] developer-days + [X] translation cost

### Phase 4: Additional Languages
- [ ] Repeat Phase 3 for each additional language
- [ ] Set up continuous translation workflow (for new features)
- [ ] Consider professional translation service or community translations
- [ ] Implement translation memory for consistency

---

## RTL (Right-to-Left) Support Considerations

> Required for: Arabic, Hebrew, Farsi/Persian, Urdu

### CSS Changes Required
- [ ] Use logical properties (`margin-inline-start` instead of `margin-left`)
- [ ] Use `dir="rtl"` attribute on `<html>` or container
- [ ] Mirror layouts (sidebar, navigation, icons with direction)
- [ ] Ensure text alignment follows `dir` attribute
- [ ] Test with bidirectional text (mixed LTR and RTL content)

### Component Changes
- [ ] Icons with directional meaning (arrows, chevrons) must flip
- [ ] Progress bars and sliders must reverse
- [ ] Tables may need column reordering
- [ ] Form layouts must mirror

### Testing Approach
```css
/* Quick RTL testing: add to global styles temporarily */
[dir="rtl"] {
  /* Verify no hardcoded left/right values break layout */
}

/* Use CSS logical properties throughout */
.container {
  margin-inline-start: 1rem;  /* NOT margin-left */
  padding-inline-end: 1rem;   /* NOT padding-right */
  border-inline-start: 1px solid;  /* NOT border-left */
}
```

---

## Date, Time, Currency, and Number Formatting

### Use the Intl API

```typescript
// Date formatting
const formatDate = (date: Date, locale: string) =>
  new Intl.DateTimeFormat(locale, {
    year: 'numeric',
    month: 'long',
    day: 'numeric',
  }).format(date);

// Currency formatting
const formatCurrency = (amount: number, locale: string, currency: string) =>
  new Intl.NumberFormat(locale, {
    style: 'currency',
    currency,
  }).format(amount);

// Number formatting
const formatNumber = (num: number, locale: string) =>
  new Intl.NumberFormat(locale).format(num);

// Relative time ("3 days ago")
const formatRelativeTime = (value: number, unit: Intl.RelativeTimeFormatUnit, locale: string) =>
  new Intl.RelativeTimeFormat(locale, { numeric: 'auto' }).format(value, unit);
```

### Locale-Specific Formatting Examples

| Locale | Date | Currency | Number | Notes |
|---|---|---|---|---|
| `en-US` | January 15, 2025 | $1,234.56 | 1,234.56 | Month/Day/Year |
| `de-DE` | 15. Januar 2025 | 1.234,56 EUR | 1.234,56 | Day.Month.Year |
| `ja-JP` | 2025年1月15日 | JPY 1,235 | 1,235 | Year/Month/Day, no decimals for JPY |
| `ar-SA` | ١٥ يناير ٢٠٢٥ | ١٬٢٣٤٫٥٦ ر.س | ١٬٢٣٤٫٥٦ | RTL, Arabic-Indic numerals |

---

## Prompt Guide for String Extraction

```
Analyze the codebase at [YOUR_REPO_PATH] and extract all hardcoded user-facing
strings that need internationalization. For each string:

1. Identify the file and line number
2. Suggest a translation key following this convention:
   - Namespace: match the feature area (auth, dashboard, settings, etc.)
   - Key format: camelCase, descriptive (e.g., auth.loginButton, dashboard.welcomeMessage)
3. Identify if the string contains:
   - Variables that need interpolation (e.g., "Hello, {name}")
   - Pluralization (e.g., "1 item" vs "N items")
   - HTML formatting that needs special handling
4. Output two files:
   - The refactored component using useTranslation() / t()
   - The corresponding English locale JSON file

Follow the i18n setup documented in docs/LOCALIZATION_ANALYSIS.md.
Namespace: [NAMESPACE_FOR_THIS_FEATURE]
```

---

## Translation Workflow

### For New Features
1. Developer writes UI with translation keys (never hardcoded strings)
2. Developer adds English strings to the appropriate namespace file
3. CI checks for missing keys in other locales
4. Translation request is created for missing keys
5. Translations are reviewed and merged
6. Visual regression tests verify layout with new translations

### Translation Tools to Consider
- **Professional:** Phrase, Crowdin, Lokalise, Transifex
- **Community:** Weblate (self-hosted), Crowdin (community plan)
- **AI-Assisted:** DeepL API, Google Cloud Translation API (for drafts, then human review)

---

*Status: Template*
*Next review: [DATE]*
