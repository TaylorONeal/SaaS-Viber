# Consumer-Facing Pages Template

> Templates for designing and building the public-facing pages of your SaaS.
> These pages drive acquisition, conversion, and trust.

---

## Landing Page / Marketing Homepage

### Purpose

Convert visitors into trial signups or demo requests.

### Section Template

| Section | Content | Design Notes |
|---------|---------|--------------|
| **Hero** | Headline, subheadline, primary CTA, hero image/video | Above the fold. Clear value proposition in <8 words. |
| **Social Proof** | Logo bar of customers or press mentions | 4-6 logos. Grayscale for visual consistency. |
| **Problem Statement** | Describe the pain point you solve | 2-3 sentences max. Empathy-driven copy. |
| **Features** | 3-4 key features with icons and descriptions | Use a grid layout. Icon + title + 1-2 sentences each. |
| **How It Works** | 3-step process | Numbered steps with illustrations. Keep it simple. |
| **Testimonials** | 2-3 customer quotes | Photo, name, title, company. Real quotes only. |
| **Pricing Preview** | Plan overview or "Starting at $X" | Link to full pricing page. |
| **CTA Section** | Repeated primary CTA | Different angle on the value prop. |
| **Footer** | Links, legal, social | Standard SaaS footer layout. |

### Responsive Behavior

- Hero: Stack image below text on mobile
- Features: 2-column on tablet, single column on mobile
- Testimonials: Carousel on mobile, grid on desktop

---

## Pricing Page

### Purpose

Help users choose the right plan and convert.

### Section Template

| Section | Content | Design Notes |
|---------|---------|--------------|
| **Header** | Page title, brief description | "Simple, transparent pricing" |
| **Toggle** | Monthly / Annual switch | Show savings percentage for annual. |
| **Plan Cards** | 2-4 plan options | Highlight recommended plan. Equal-height cards. |
| **Feature Comparison** | Detailed table | Collapsible on mobile. Check/X icons. |
| **FAQ** | 5-8 common pricing questions | Accordion format. |
| **CTA** | Final conversion push | "Start your free trial" or "Contact sales" |

### Plan Card Template

```
[Plan Name]
[Price] /month
[Brief description - who this is for]

Features:
- [Feature 1]
- [Feature 2]
- [Feature 3]
- [Feature 4]

[CTA Button]
```

### Responsive Behavior

- Cards: Horizontal scroll or stack vertically on mobile
- Feature table: Collapse to accordion on mobile

---

## Feature Pages

### Purpose

Deep-dive on a specific feature for SEO and education.

### Section Template

| Section | Content |
|---------|---------|
| **Hero** | Feature name, value proposition, screenshot/demo |
| **Problem** | What pain does this feature address? |
| **Solution** | How your feature solves it (with visuals) |
| **Details** | 3-4 sub-features or capabilities |
| **Use Cases** | 2-3 specific scenarios |
| **Integration** | How it connects with other features |
| **CTA** | Try this feature / Start free trial |

---

## About Page

### Purpose

Build trust and humanize your company.

### Section Template

| Section | Content |
|---------|---------|
| **Mission** | Why your company exists (2-3 sentences) |
| **Story** | Brief founding story |
| **Values** | 3-5 company values with descriptions |
| **Team** | Key team members with photos and roles |
| **Stats** | Key metrics (customers, uptime, support response time) |
| **Careers** | Link to open positions |

---

## Contact / Support Page

### Purpose

Let users reach you easily and find self-service answers first.

### Section Template

| Section | Content |
|---------|---------|
| **Header** | "How can we help?" |
| **Quick Links** | Documentation, Status page, Community |
| **Contact Form** | Name, email, subject, category, message |
| **Support Tiers** | What level of support each plan includes |
| **Office Info** | Address, hours (if applicable) |
| **Social Links** | Twitter/X, LinkedIn, etc. |

---

## Blog / Content Pages

### Purpose

SEO, thought leadership, and user education.

### Blog Index Template

| Element | Design Notes |
|---------|--------------|
| **Featured post** | Large card at top with image |
| **Category filter** | Horizontal tabs or pills |
| **Post grid** | 2-3 columns, card format |
| **Pagination** | Load more or numbered pages |
| **Newsletter signup** | Inline CTA between posts |

### Blog Post Template

| Element | Design Notes |
|---------|--------------|
| **Title** | Large, prominent heading |
| **Metadata** | Author, date, reading time, category |
| **Hero image** | Full-width or contained |
| **Body** | Prose styling with proper heading hierarchy |
| **Code blocks** | Syntax-highlighted if technical |
| **CTA** | Product CTA at bottom |
| **Related posts** | 2-3 related articles |
| **Share buttons** | Social sharing links |

---

## Page Requirements Template

Use this template when planning any new page:

```markdown
## [Page Name]

### Goal
[What action should the user take after visiting this page?]

### Audience
[Who visits this page and what are they looking for?]

### SEO
- Primary keyword: [keyword]
- Page title: [title tag]
- Meta description: [description]

### Sections
1. [Section name] -- [purpose]
2. [Section name] -- [purpose]
3. [Section name] -- [purpose]

### States
- Loading: [description]
- Empty: [description]
- Error: [description]

### Mobile Considerations
- [How does layout adapt?]
- [What gets hidden or collapsed?]

### Performance
- Target LCP: <2.5s
- Images: [lazy load strategy]
- Above the fold: [what must load immediately]
```
