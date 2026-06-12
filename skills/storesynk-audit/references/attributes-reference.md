# Storesynk attribute reference

The complete catalog of Storesynk identifiers, extracted from the engine (v2.1.0). Use it as the whitelist when auditing: an `sf-*` attribute on a page that is not listed here is almost certainly a typo.

Three kinds of identifiers share the `sf-` prefix — don't confuse them:

- **Component attributes** — authored by the developer on Webflow elements; they bind data/behavior.
- **Combo classes** — CSS classes *applied by the engine* to reflect state; developers style them, never type them as attributes.
- **Engine-managed attributes** — set by the engine at runtime (`sf-data-*`, `sf-current-*`); seeing them in served HTML is normal, authoring them is not.

For per-component usage details, fetch the component's doc page (see `doc-map.md`).

## Script tag and global config

The Storesynk engine (`shopyflow.js` — legacy naming, this is Storesynk) is loaded once per page from `cdn.shopyflow.io`, with `cdn2.shopyflow.com` as automatic backup. There are two install modes:

- **Auto-install (current default):** the page carries only a bootstrap script hosted on Webflow's CDN (`cdn.prod.website-files.com/.../shopyflow_auto_install-<loader-version>.js`, with a `data-shop-id` attribute). The bootstrap defines `window.shopyflowConfig` inline (token, domain, `shopyflowVersion`, tracking, customer accounts) and injects the engine script and stylesheet (`shopyflow.css`) at runtime with element ids `shopyflow-js` / `shopyflow-css`. The engine tag is therefore invisible in served HTML — fetch the bootstrap file to read the config.
- **Manual:** the engine `<script>` is in the HTML directly, configured via attributes on the tag or a `window.shopyflowConfig` defined **before** it.

| Script attribute | `shopyflowConfig` key | Purpose |
|---|---|---|
| `sf-token` | — | Storefront access token (required) |
| `sf-domain` | — | Shopify domain (required) |
| `sf-debug` | `debugMode` | Verbose console logging |
| `sf-delay` | `delayShopyflow` | Delay initialization (ms) |
| `auto-install` | — | Auto-install mode |
| `store-language` | `language.storeLanguage` | Store language override |
| `customer-accounts` | `customerAccounts.enabled` | Enable customer accounts module |
| `product-page-path` | `productPagePath` | Product page URL folder (default `products`) |
| `variant-id-in-url` | `showVariantInUrl` | Write selected variant into the URL (default true) |
| `analytics` | `tracking.googleAnalytics` | Google Analytics events |
| `shopify-analytics` | `tracking.shopifyAnalytics` | Shopify Analytics events |
| `klaviyo` | `tracking.klaviyo` | Klaviyo events |
| `pixel` | `tracking.pixel` | Meta Pixel events |
| `capi` | `tracking.capi` | Meta CAPI events |
| `tiktok` | `tracking.tiktok` | TikTok events |
| `pinterest` | `tracking.pinterest` | Pinterest events |
| — | `tracking.requireConsent` | Wait for cookie consent before tracking (default true) |
| — | `tracking.shopifyPrivacyBanner` | Use Shopify's privacy banner |

Additional `shopyflowConfig` keys seen in auto-install bootstraps (generated, not authored): `shopyflowVersion` (engine version to load), `shopId` (Shopify shop GID), `userId` (Storesynk account id), `price.currencyFormat` (Intl locale for price formatting), `customerAccounts.useCustomerAccountApi` / `customerAccounts.useShopifyCustomerPortal` / `customerAccounts.clientId` (customer accounts wiring).

JS globals at runtime: `window.Shopyflow` (API methods, debug queue) and `window.shopyflowConfig`.

## Product (Buy Module)

| Attribute | Component / purpose |
|---|---|
| `sf-product` | Product Container — value is the Shopify product ID (or CMS-bound) |
| `sf-sub-product` | Sub-product Container (bundled add-on inside a main container) |
| `sf-sub-product-state` | Sub-product staged-state element |
| `sf-product-id` | Product ID displayer |
| `sf-product-link` | Link to the product page |
| `sf-summary` | Binds a summary element to the product |
| `sf-add-to-cart` | Add to Cart Button |
| `sf-buy-now` | Buy Now button (straight to checkout) |
| `sf-redirect` | On the Add to Cart Button: URL to redirect to after adding |
| `sf-no-reload` | Suppress reload behavior |
| `sf-checkout-domain` | Override the checkout domain |
| `sf-show-title` | Product Title |
| `sf-show-desc` | Product Description |
| `sf-show-sku` | SKU |
| `sf-show-barcode` | Barcode |
| `sf-show-vendor` | Vendor |
| `sf-show-stock` | Stock Count |
| `sf-show-product-type` | Product Type |
| `sf-show-weight` | Variant weight |
| `sf-change-product-note` | Product note input |
| `sf-show-product-note` | Product note displayer |
| `sf-change-product-attribute` | Line-item attribute input |
| `sf-required` | Marks an input (note/attribute/option) as required before add-to-cart |
| `sf-gift-form` | Gift message form (fields inside it: `sf-name`, `sf-email`, `sf-message`) |
| `sf-button-text` | Text block inside the Add to Cart Button (swapped per state, e.g. loading/out-of-stock) |
| `sf-no-animation` | On the Add to Cart Button: disable the loading spinner |
| `sf-shop-pay` | Shop Pay button |
| `sf-show-sale` | Sale tag (visible when on sale) |
| `sf-sale-value` | Sale amount/percentage displayer |

## Price

| Attribute | Purpose |
|---|---|
| `sf-show-price` | Current price |
| `sf-show-min-price` / `sf-show-max-price` | Price range ends |
| `sf-show-compare-price` | Compare-at price |
| `sf-show-min-compare-price` / `sf-show-max-compare-price` | Compare-at range ends |
| `sf-show-prediscount-price` | Pre-discount price (cart) |
| `sf-show-unit-price` | Unit price |
| `sf-no-currency` | Render the number without the currency symbol |

Price attribute *values* modify behavior: `with-quantity` (multiply by selected quantity), `with-sub-product` (include staged sub-products), `all` (both).

## Quantity

| Attribute | Purpose |
|---|---|
| `sf-change-quantity` | Quantity input (must be a number input) |
| `sf-change-quantity-inc` / `sf-change-quantity-dec` | Increase / decrease buttons |
| `sf-show-quantity` | Quantity displayer |
| `sf-default-quantity` | Default quantity value |

## Variant options

| Attribute | Purpose |
|---|---|
| `sf-change-option` | Option selector — on a Select element it becomes a dropdown; on a container it's a Custom Option Wrapper. Value = option group name (e.g. `Size`) |
| `sf-option-value` | Custom Option Value (clickable) — value = option value (e.g. `XL`) |
| `sf-show-option` | Selected-option displayer — value = option group name |
| `sf-show-options` | All selected options displayer (cart items) |
| `sf-show-option-label` | Option group label displayer |
| `sf-show-option-title` | Option title displayer |
| `sf-change-variant` | Direct variant selector — value/binding is the variant ID |
| `sf-smart-change-option` | Smart option selector (Smart Options module) |
| `sf-smart-option-value` | Smart option value |
| `sf-current-<option>` | Engine-managed: current value per option group (do not author) |

## Images

| Attribute | Purpose |
|---|---|
| `sf-show-image` | Product image displayer |
| `sf-current-image` | Main image (updates with variant/thumbnail selection) |
| `sf-change-image` | Thumbnail (click to change main image) |
| `sf-thumbnail-wrapper` | Thumbnail list wrapper |
| `sf-filter-images` | Filter gallery images by selected variant |
| `sf-filter-images-mode` | Filtering mode — value `start-with-main` supported |
| `sf-set-bg` | Render the image as the element's background image |

## Cart

| Attribute | Purpose |
|---|---|
| `sf-cart` | Cart Wrapper |
| `sf-cart-popup` | Cart Popup container |
| `sf-cart-open` / `sf-cart-close` | Open / close the Cart Popup |
| `sf-cart-list` | Cart Items List (looping container) |
| `sf-cart-item` | Cart Item (the cloned template) |
| `sf-cart-item-remove` | Cart Item Remover |
| `sf-cart-count` | Cart item count |
| `sf-cart-subtotal` | Cart subtotal |
| `sf-cart-subtotal-wrapper` | Subtotal wrapper |
| `sf-cart-total` | Cart total |
| `sf-cart-tax` | Cart tax |
| `sf-cart-note` | Cart note input |
| `sf-checkout` | Checkout Button |
| `sf-cart-empty` | Empties the cart on click; also the empty-state class (`sf-cart-empty`) |
| `sf-data-variant` / `sf-data-product` / `sf-data-stock` | Engine-managed data attributes on cart items |

## Discounts

| Attribute | Purpose |
|---|---|
| `sf-change-discount-code` | Discount code input |
| `sf-apply-discount-code` | Apply button |
| `sf-discount-code-list` / `sf-discount-code-item` | Applied-codes list / item |
| `sf-show-discount-code` | Code displayer |
| `sf-show-discount-code-amount` | Code amount displayer |
| `sf-discount-code-remove` | Code remover |
| `sf-order-discount-list` / `sf-order-discount-item` | Order-level discount list / item |
| `sf-show-order-discount-title` / `sf-show-order-discount-amount` | Order discount title / amount |
| `sf-show-product-discount-title` | Product discount title (cart item) |

## Currency / markets

| Attribute | Purpose |
|---|---|
| `sf-change-currency` | Currency selector (select input) |
| `sf-currency-value` | Currency selector button (custom selector) |
| `sf-show-currency-selection` | Currency selector wrapper / current-selection displayer |
| `sf-currency` | Currency displayer |

## Collection, listing and filtering

| Attribute | Purpose |
|---|---|
| `sf-collection` | Collection Module wrapper |
| `sf-list` | Product list (looping container) |
| `sf-sortable` | Sort control — value = sort key |
| `sf-sort-direction` | Sort direction control |
| `sf-filter` | Taxonomy filter group |
| `sf-filterable` | Marks list items filterable by taxonomy |
| `sf-option-filter` | Variant-option filter group |
| `sf-option-filterable` | Marks list items filterable by option |
| `sf-filter-limit` | Max filter values to show |
| `sf-await` | Hide the element until Storesynk finishes loading (async visibility) |
| `sf-listen` / `sf-listen-class` | React to engine events by toggling a class |
| `sf-data-fetched` | Engine-managed: set when a container's data is loaded |

## Search

| Attribute | Purpose |
|---|---|
| `sf-product-search` | Search module wrapper |
| `sf-search-input` | Search input |
| `sf-search-result-list` / `sf-search-result-item` | Results list / item template |

## Subscriptions

| Attribute | Purpose |
|---|---|
| `sf-subscription` | Subscription Module wrapper |
| `sf-change-purchase-option` | Purchase option selector (one-time vs recurring) |
| `sf-purchase-option-value` | Purchase option value — values `single` (one-time) and `recurring` (subscription) |
| `sf-change-selling-plan` | Selling plan selector |
| `sf-selling-plan-value` | Selling plan value |
| `sf-show-selling-plan` | Selling plan displayer |
| `sf-show-subscription-title` | Subscription name displayer |
| `sf-current-subscription-state` | Engine-managed: current purchase-option state |

## Metafields

| Attribute | Purpose |
|---|---|
| `sf-show-metafield` | Product metafield displayer — value = metafield key |
| `sf-show-variant-metafield` | Variant metafield displayer |
| `sf-show-collection-metafield` | Collection metafield displayer |
| `sf-change-metafield-namespace` | Override the metafield namespace (default `custom`) |
| `sf-metafield-wrapper` / `sf-metafield-item` | Wrapper / item for list-type metafields |

## Recommendations and upsells

| Attribute | Purpose |
|---|---|
| `sf-related-products` | Related Products module wrapper |
| `sf-upsell-products` | Upsell Products module wrapper |
| `sf-source` | Recommendation source selector on the wrapper |
| `sf-related-products-list` / `sf-related-products-item` | Related list / item |
| `sf-upsell-products-list` / `sf-upsell-products-list-item` | Upsell list / item |
| `sf-free-shipping-upsell` | Free-shipping upsell wrapper |
| `sf-free-shipping-progress` | Free-shipping progress bar |
| `sf-free-shipping-remaining` | Remaining-amount displayer |
| `sf-add-all-to-cart` | Add all listed products to cart |
| `sf-recently-viewed-products` | Recently Viewed module wrapper |

## Klaviyo form (Klaviyo integration)

| Attribute | Purpose |
|---|---|
| `sf-klaviyo-form` | Klaviyo signup form wrapper (component library) |
| `sf-klaviyo-list-id` | On the form's submit button: Klaviyo list ID to subscribe to |
| `sf-klaviyo-prop` | On an input/textarea/checkbox/radio: custom Klaviyo profile property name |
| `sf-submit` | Form submit button (component library; also seen on the Klaviyo form submit) |

## Other modules

| Attribute | Purpose |
|---|---|
| `sf-file-uploader` | File Uploader (requires version ≥ 2.0) |
| `sf-request-a-quote-form` / `sf-request-a-quote-submit` | Request-a-Quote form / submit |
| `sf-wishlist` / `sf-add-to-wishlist` | Wishlist module / add button |
| `sf-bundle` | Bundle module wrapper |

Customer-account components (login, signup, addresses, order history) have their own attribute set documented in the accounts guides — fetch those doc pages when auditing account pages rather than relying on this file.

## Combo classes (applied by the engine — style these, never author as attributes)

| Class | Applied when |
|---|---|
| `sf-cart-opened` | Cart popup is open (on the popup/body) |
| `sf-cart-empty` | Cart is empty |
| `sf-active` | Selector value is the active one |
| `sf-active-thumbnail` | Thumbnail matches the current main image |
| `sf-out-of-stock` | Selected variant is out of stock (e.g. on the Add to Cart Button) |
| `sf-stock-exceeded` | Requested quantity exceeds stock |
| `sf-continue-selling` | Variant allows overselling |
| `sf-option-unavailable` | Option combination unavailable |
| `sf-loading` | Component is processing (e.g. add-to-cart in flight) |
| `sf-uploading` | File upload in flight |
| `sf-sub-product-added` | Sub-product is staged |
| `sf-error` | Component is in an error state |

## Cookies and storage (set by the engine)

| Key | Where | Purpose |
|---|---|---|
| `_sf-cart-id` | cookie | Current cart ID |
| `_sf-checkoutId` | cookie | Checkout ID |
| `_sf-customer-token` | cookie | Customer session token |
| `_sf-language` | cookie | Selected language |
| `_sf-currency` / `_sf-country` | localStorage | Selected currency / country |
| `_sf_config` | storage | Cached storefront config |

Internal engine attributes not listed here (e.g. `sf-current-_qty_`, `sf-current-_prc_` placeholder tokens) may appear in served HTML; they are engine state, not authoring mistakes.
