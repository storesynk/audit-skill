# Storesynk known issues

The most frequent support issues, from the Storesynk support knowledge base. Match the user's symptom here before deep-diving — most reported problems are one of these. Where an issue is caused by a structural rule, the rule code from `diagnostic-rules.md` is given.

## Checkout

### Checkout sends the customer to a Shopify password page
In Shopify admin go to **Online Store > Preferences**, find the **Store access** section, deselect **Password protection**, and save.

### Checkout shows a 404
Almost always an incorrect domain setup in Shopify. In Shopify admin domain settings, make sure the Webflow custom domain is **not** used in Shopify (Shopify needs its own domain), and that the main Shopify domain is approved and not pending setup. Reference: `https://www.storesynk.com/docs-articles/launch-checklist` (domain section).

### Checkout language is wrong, or resets to English
Caused by setting a language in Webflow site settings. Make sure the Webflow language is **not** set in the site settings.

## Add to cart / cart

### Add to cart works on webflow.io but not on the custom domain
A Storesynk plan is required for custom domains. If the user already has one, walk through steps 1–4 of the launch checklist: `https://www.storesynk.com/docs-articles/launch-checklist`.

### Add to cart doesn't work on webflow.io either
Usually missing API scopes on the Headless app. Re-open the Headless app installation and enable **all** scopes: `https://www.storesynk.com/docs-articles/headless-installation`. (Check rules SF-102/SF-103/SF-201 too if the button itself looks inert.)

### Quantity selector increases by 2 per click
Two nested Product Containers — rule **SF-101**. Remove one.

### Cart popup opens on one page but not on others
The Cart Module must be present on **every** page where the cart should open. Add it to all pages (typically via a global component/symbol).

## Product display

### Image slider has too many slides
Two nested Product Containers — rule **SF-101**. Remove one.

### Option/variant selectors are duplicated
The Custom Option Value attributes are not connected to the CMS on a CMS page — related to rules **SF-201/SF-204**. Connect them: `https://www.storesynk.com/guides/building-cms-based-shopify-product-pages-in-webflow-with-storesynk`.

### Compare price is not visible
In Shopify **Markets** settings, turn on compare-at price. If already on, wait ~5 minutes and test in an incognito window (cached data).

### Product shows out of stock in only one market
Check Shopify delivery profiles and make sure there is stock in all of them.

### Adding an Add to Cart button on a listing/collection page
Not a bug — supported pattern: place a Product Container on the page, connect its attribute value to the CMS product ID field (or enter the ID manually), and put the Add to Cart Button inside it. Or add a full Buy Module and delete the inner elements that aren't needed.

## Data sync (Shopify → Webflow CMS)

### Some products don't import/sync to Webflow CMS
Two requirements: every product image must be **under 4 MB**, and products must be enabled on both the **Headless** and **Online Store** sales channels.

### Sync says "please publish" although the site is published
The site must also be published to the `*.webflow.io` (staging) domain — publish to both.

### Product missing from CMS / not updating despite correct sales channels
If the store uses catalogs, the products must also be published in **Catalogs > Regions**.

### CMS auto-sync with localization misses or overwrites translations
Translations for **all** locales must be complete in Shopify. Guide: `https://www.storesynk.com/guides/how-to-localize-your-shopify-store-with-the-webflow-storefront`.

### Product meta description doesn't sync
Shopify's auto-generated meta descriptions are drafts and cannot sync. Edit/save the meta description in Shopify manually, then it syncs.

### Can metafields sync to Webflow CMS?
Yes — some product metafield types can. Managed in **Storesynk Webflow App > Import & Manage Shopify Data**.

### Can't create metafields from the Webflow App
Shopify allows at most 50 pinned metafields — make sure the store has fewer than 50 pinned.

### Turning off auto-sync error emails
**Storesynk Webflow App > Import & Manage Shopify Data** has a toggle for sync error notifications.

## Customer accounts

### "Passwords can't be submitted" on the login page
The customer accounts module isn't enabled. Enable it in the Storesynk Webflow App: `https://www.storesynk.com/guides/how-to-use-passwordless-shopify-customer-accounts-in-webflow-with-storesynk`.

### Account page and login page redirect to each other in a loop
Caused by an account **reset form** placed on the account page. Remove it from that page.

### "Zone code must exist" when submitting an address form
The address form is missing a **province/state field**. Add it.

## Loading / network

### CORS errors in the console; products don't load
Domain configuration issue. Verify the Shopify domain in the **Storesynk Shopify App**, then check the **Storesynk Webflow App** for warnings, and republish the Webflow project.

## Versions and billing

### A specific component doesn't work (File Uploader, Cart Upsell, …)
Requires script version ≥ **2.0.0** — check the version in the script URL (`/main/<version>/`). Upgrade guide: `https://www.storesynk.com/docs-articles/upgrade-to-shopyflow-2-0`.

### Paid for a subscription but still asked to upgrade
The subscription was likely purchased through the legacy dashboard (v1 stores only). This needs the team: contact support (Discord `https://discord.com/invite/NddWajkVK3`, or hello@storesynk.com) — they will cancel/refund, and the user repurchases through the Storesynk Shopify App.

## Listing / filters

### Filters work, but the collection filter isn't preselected on the collection page
On the collection template page, the product list must also use Webflow's own CMS filter: **"Product collections > Contains > Current collection"**.

## Out of scope (but commonly asked)

### "How much should I charge for my project?"
Not a technical issue — varies by market and scope. For reference, point to Storesynk Studio's pricing: `https://www.storesynk.com/storesynk-studio`.
