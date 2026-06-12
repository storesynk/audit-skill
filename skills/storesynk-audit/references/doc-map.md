# Storesynk documentation map

## URL patterns

- **Docs home (human-readable):** `https://www.storesynk.com/docs-home`
- **Full docs index (fetch this to find any page):** `https://www.storesynk.com/llms.txt` — a categorized list of every doc article and guide with a one-line summary and its raw-markdown URL.
- **Raw markdown per page:** `https://md.storesynk.com/docs-articles/<slug>.md` and `https://md.storesynk.com/guides/<slug>.md`
- **Public page (use this form when citing to users):** drop the `md.` subdomain and the `.md` extension — `https://www.storesynk.com/docs-articles/<slug>` / `https://www.storesynk.com/guides/<slug>`.

Notes:
- Some markdown-mirror slugs still contain the legacy name (e.g. `...-with-shopyflow.md`). The public site redirects these to the current slug, so the converted public URL always works — cite it as-is.
- Workflow: when you need page details, fetch `llms.txt` (or use the tables below), then fetch the page's markdown mirror, then cite the public URL in your answer.

## Key pages

| Topic | Public URL |
|---|---|
| Installation | `https://www.storesynk.com/guides/shopyflow-installation` |
| Launch checklist (go-live on custom domain) | `https://www.storesynk.com/docs-articles/launch-checklist` |
| Headless app installation (token, scopes, order emails) | `https://www.storesynk.com/docs-articles/headless-installation` |
| Adding products to the headless sales channel | `https://www.storesynk.com/docs-articles/adding-products-to-shopify-headless-sales-channel` |
| Upgrade to 2.0+ | `https://www.storesynk.com/docs-articles/upgrade-to-shopyflow-2-0` |
| Buy Module overview | `https://www.storesynk.com/guides/buy-module-overview` |
| All components list | `https://www.storesynk.com/guides/components` |
| Cart Module overview | `https://www.storesynk.com/guides/cart-module-overview` |
| Cart Items List | `https://www.storesynk.com/guides/cart-items-list` |
| Cart Summary (subtotal, discounts, checkout button) | `https://www.storesynk.com/guides/cart-summary` |
| Discount Code Block | `https://www.storesynk.com/guides/discount-code-block` |
| CMS product pages | `https://www.storesynk.com/guides/building-cms-based-shopify-product-pages-in-webflow-with-storesynk` |
| Import & sync Shopify data to Webflow CMS | `https://www.storesynk.com/guides/import-and-sync-shopify-data-to-webflow-cms` |
| Product Listing module (filterable lists) | `https://www.storesynk.com/guides/product-listing-module-build-filterable-shopify-product-listing-in-webflow` |
| Sub-products | `https://www.storesynk.com/guides/how-to-use-shopyflow-sub-product` |
| Subscriptions / selling plans | `https://www.storesynk.com/guides/how-to-sell-shopify-subscription-products-in-webflow-with-storesynk` |
| Multi-currency setup | `https://www.storesynk.com/guides/how-to-setup-a-multi-currency-shopify-store-in-webflow` |
| Localization | `https://www.storesynk.com/guides/how-to-localize-your-shopify-store-with-the-webflow-storefront` |
| Metafields in Webflow | `https://www.storesynk.com/guides/how-to-display-shopify-metafields-in-webflow` |
| Customer accounts (passwordless, current) | `https://www.storesynk.com/guides/how-to-use-passwordless-shopify-customer-accounts-in-webflow-with-storesynk` |
| File uploader | `https://www.storesynk.com/guides/how-to-upload-files-to-shopify-from-webflow` |
| Free shipping bar | `https://www.storesynk.com/guides/how-to-add-a-free-shipping-bar` |
| Upsell products (metafields) | `https://www.storesynk.com/guides/how-to-display-upsell-products-through-shopify-metafields` |
| Related products (metafields) | `https://www.storesynk.com/guides/how-to-display-related-products-through-shopify-metafields` |
| Price & currency formatting | `https://www.storesynk.com/guides/how-to-change-your-price-and-currency-formatting-in-webflow` |
| Tracking & analytics integrations | `https://www.storesynk.com/docs-articles/tracking-analytics-integrations` |
| JS events index | `https://www.storesynk.com/docs-articles/events` |
| JS methods index | `https://www.storesynk.com/docs-articles/methods` |

Component states (out-of-stock, loading, active option, empty cart, etc.) each have a short doc — find them in `llms.txt` under "Component States".

## Symptom → doc quick lookup

| Issue area | Primary doc |
|---|---|
| Nothing works / first install | Installation guide, then Launch checklist |
| Works on webflow.io, broken on custom domain | Launch checklist |
| Add to cart fails on webflow.io | Headless app installation (scopes) |
| Order confirmation emails missing | Headless app installation |
| Product page empty / components blank | Buy Module overview; CMS product pages (if CMS) |
| Variant selectors broken | Buy Module overview; components list (Custom Option Wrapper/Value) |
| Cart issues (popup, items, totals) | Cart Module overview; Cart Items List; Cart Summary |
| Discount codes | Discount Code Block |
| Product list / filters | Product Listing module guide |
| Sync issues (products missing in CMS) | Import & sync guide |
| Currency / markets | Multi-currency setup |
| Wrong language / localization | Localization guide |
| Customer accounts | Passwordless customer accounts guide |
| Metafields not showing | Metafields guide |
| Subscriptions | Subscriptions guide |
| Out-of-stock styling/behavior | Component States docs (out-of-stock, stock-exceeded) |
| Analytics / pixels | Tracking & analytics integrations |
| Custom JS questions | JS events + methods docs |
