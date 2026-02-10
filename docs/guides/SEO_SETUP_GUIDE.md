# SEO Setup Guide

Practical search engine optimization for SaaS products. This is not an exhaustive SEO course -- it covers the technical foundations that most SaaS builders skip or get wrong.

---

## 1. Google Search Console

This is your single most important SEO tool. Set it up before anything else.

### Setup Steps

1. Go to https://search.google.com/search-console
2. Add your property (use the "Domain" option for full coverage)
3. Verify ownership via DNS TXT record (most reliable method)
4. Submit your sitemap URL: `https://yourapp.com/sitemap.xml`

### What to Monitor Weekly

- [ ] **Coverage report** -- Are all your important pages indexed?
- [ ] **Performance** -- What queries bring people to your site?
- [ ] **Core Web Vitals** -- Are you passing on mobile and desktop?
- [ ] **Manual actions** -- Any penalties? (Rare but check.)

### Common Issues

- Pages stuck in "Discovered - currently not indexed" -- Usually means thin content or crawl budget issues
- "Excluded by noindex" -- Check your meta tags and `robots.txt`
- Redirect errors -- Fix broken redirects immediately

---

## 2. Bing Webmaster Tools

Takes 5 minutes and covers Bing, Yahoo, and DuckDuckGo search.

1. Go to https://www.bing.com/webmasters
2. Import from Google Search Console (easiest) or add manually
3. Submit your sitemap
4. Verify ownership

Bing gets less traffic but the users tend to convert well, especially for B2B.

---

## 3. Structured Data

Structured data helps search engines understand your content. For SaaS, focus on these types:

### Organization

Add to your homepage:

```json
{
  "@context": "https://schema.org",
  "@type": "Organization",
  "name": "Your Product Name",
  "url": "https://yourapp.com",
  "logo": "https://yourapp.com/logo.png",
  "sameAs": [
    "https://twitter.com/yourproduct",
    "https://linkedin.com/company/yourproduct"
  ]
}
```

### SoftwareApplication

Add to your product/pricing page:

```json
{
  "@context": "https://schema.org",
  "@type": "SoftwareApplication",
  "name": "Your Product Name",
  "applicationCategory": "BusinessApplication",
  "operatingSystem": "Web",
  "offers": {
    "@type": "Offer",
    "price": "29",
    "priceCurrency": "USD"
  }
}
```

### FAQPage

Add to your FAQ or pricing page. Google often shows these as rich results:

```json
{
  "@context": "https://schema.org",
  "@type": "FAQPage",
  "mainEntity": [
    {
      "@type": "Question",
      "name": "What does Your Product do?",
      "acceptedAnswer": {
        "@type": "Answer",
        "text": "Your Product helps [target audience] do [core value]."
      }
    }
  ]
}
```

### Validation
- [ ] Test with https://search.google.com/test/rich-results
- [ ] Test with https://validator.schema.org/
- [ ] Check Google Search Console for structured data errors

---

## 4. Open Graph Tags

These control how your pages look when shared on social media, Slack, Discord, etc.

### Required Tags on Every Page

```html
<meta property="og:title" content="Page Title - Your Product" />
<meta property="og:description" content="Concise description of this page." />
<meta property="og:image" content="https://yourapp.com/og-image.png" />
<meta property="og:url" content="https://yourapp.com/current-page" />
<meta property="og:type" content="website" />
<meta property="og:site_name" content="Your Product" />
```

### OG Image Requirements

- **Size**: 1200x630 pixels (recommended)
- **Format**: PNG or JPG
- **File size**: Under 1MB
- **Content**: Product name, brief tagline, and visual. Text should be readable at thumbnail size.

### Testing

- Facebook: https://developers.facebook.com/tools/debug/
- LinkedIn: https://www.linkedin.com/post-inspector/
- X/Twitter: Share a link and check the card preview

---

## 5. Twitter Cards

```html
<meta name="twitter:card" content="summary_large_image" />
<meta name="twitter:site" content="@yourproduct" />
<meta name="twitter:title" content="Page Title" />
<meta name="twitter:description" content="Page description." />
<meta name="twitter:image" content="https://yourapp.com/og-image.png" />
```

Use `summary_large_image` for marketing pages (big preview) and `summary` for app pages (small preview).

---

## 6. Sitemap Configuration

### Generate a Sitemap

Your framework likely has a sitemap plugin. The sitemap should include:

- [ ] All public marketing pages
- [ ] Blog posts / documentation pages
- [ ] Pricing page
- [ ] Changelog (if public)

Do **not** include:
- Authenticated app pages
- API endpoints
- Admin pages
- Duplicate/parameterized pages

### Sitemap Format

```xml
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
  <url>
    <loc>https://yourapp.com/</loc>
    <lastmod>2025-01-15</lastmod>
    <changefreq>weekly</changefreq>
    <priority>1.0</priority>
  </url>
</urlset>
```

- [ ] Submit sitemap to Google Search Console
- [ ] Submit sitemap to Bing Webmaster Tools
- [ ] Verify all URLs in sitemap return 200 status codes
- [ ] Update `lastmod` dates when content changes

---

## 7. robots.txt Configuration

Place at `https://yourapp.com/robots.txt`:

```
User-agent: *
Allow: /
Disallow: /app/
Disallow: /api/
Disallow: /admin/

Sitemap: https://yourapp.com/sitemap.xml
```

### Rules

- Block authenticated routes (`/app/`, `/dashboard/`)
- Block API routes
- Block admin areas
- Allow all marketing/public pages
- Reference your sitemap

- [ ] Test with Google's robots.txt tester in Search Console
- [ ] Verify you are not accidentally blocking important pages

---

## 8. Page Speed Optimization

Speed directly affects rankings and conversion. Target 90+ on Lighthouse.

### Quick Wins

- [ ] Compress and properly size images (use WebP or AVIF)
- [ ] Enable text compression (gzip/brotli) on your server
- [ ] Use a CDN for static assets
- [ ] Lazy-load images below the fold
- [ ] Minimize JavaScript bundle size (code-split aggressively)
- [ ] Preload critical fonts
- [ ] Remove unused CSS

### Core Web Vitals Targets

| Metric | Target | What It Measures |
|---|---|---|
| LCP (Largest Contentful Paint) | < 2.5s | Loading speed |
| INP (Interaction to Next Paint) | < 200ms | Responsiveness |
| CLS (Cumulative Layout Shift) | < 0.1 | Visual stability |

### Tools

- Lighthouse (Chrome DevTools > Lighthouse tab)
- PageSpeed Insights: https://pagespeed.web.dev/
- WebPageTest: https://www.webpagetest.org/

---

## 9. Schema.org Markup for SaaS

Beyond the basics above, consider adding:

- [ ] **BreadcrumbList** -- For documentation and multi-level pages
- [ ] **HowTo** -- For tutorial/guide content
- [ ] **Article** -- For blog posts (with author, date, image)
- [ ] **Review/AggregateRating** -- If you have testimonials or ratings
- [ ] **PriceSpecification** -- Detailed pricing on your pricing page

### Implementation Tips

- Use JSON-LD format (script tags in `<head>`)
- One schema block per page is fine; multiple are also valid
- Do not mark up content that is not visible on the page
- Keep structured data in sync with visible content

---

## 10. LLM and AI Search Optimization

Search is evolving. AI assistants (ChatGPT, Perplexity, Google AI Overviews) increasingly answer queries directly. Here is how to be included in those answers.

### What Helps

- [ ] **Clear, structured content** -- Use headings, lists, tables. AI models parse these well.
- [ ] **Direct answers** -- Start sections with a clear answer, then elaborate.
- [ ] **Factual authority** -- Cite sources, show expertise, be specific.
- [ ] **Schema markup** -- Structured data helps AI models understand your content.
- [ ] **Comprehensive coverage** -- Long-form content that thoroughly covers a topic gets cited more.

### llms.txt (Emerging Standard)

Some sites are adopting a `/llms.txt` file that describes the site for AI crawlers:

```
# Your Product Name
> Brief description of what your product does.

## Documentation
- [Getting Started](https://yourapp.com/docs/getting-started)
- [API Reference](https://yourapp.com/docs/api)

## Key Pages
- [Pricing](https://yourapp.com/pricing)
- [About](https://yourapp.com/about)
```

This is not yet a standard but costs nothing to add and may help AI systems understand your site.

### What to Avoid

- Do not block AI crawlers unless you have a specific reason
- Do not stuff keywords -- AI models detect this and deprioritize it
- Do not create thin content pages hoping to rank -- depth wins

---

## SEO Maintenance Cadence

### Weekly
- Check Search Console for errors
- Review top queries and click-through rates

### Monthly
- Run Lighthouse on key pages
- Check for broken links
- Review and update meta descriptions for underperforming pages

### Quarterly
- Full technical SEO audit
- Update structured data
- Review and refresh content
- Check competitor rankings

---

*SEO is a long game. The technical foundations in this guide get you to the starting line. Consistent content and genuine authority in your niche are what move the needle over time.*
