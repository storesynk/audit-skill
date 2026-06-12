# Storesynk diagnostic rules

Structural rules for auditing a Storesynk page from its served HTML. Each rule has a stable code, a severity, a DOM detection condition, and a fix. Codes are grouped by family:

- **SF-1xx** — nesting and required structure
- **SF-2xx** — attribute values and settings
- **SF-3xx** — element types (HTML tags)

"Ancestor"/"descendant" always means anywhere up/down the DOM tree, not just direct parent/child.

## Component vocabulary

The attribute that makes an element a given Storesynk component:

| Component | Attribute |
|---|---|
| Product Container | `sf-product` |
| Sub-product Container | `sf-sub-product` |
| Add to Cart Button | `sf-add-to-cart` |
| Product Title | `sf-show-title` |
| Product Description | `sf-show-desc` |
| Price | `sf-show-price` |
| Compare Price | `sf-show-compare-price` |
| Product Image | `sf-show-image` (current image: `sf-current-image`) |
| Thumbnail | `sf-change-image` (wrapper: `sf-thumbnail-wrapper`) |
| SKU | `sf-show-sku` |
| Stock Count | `sf-show-stock` |
| Quantity Changer | `sf-change-quantity` (buttons: `sf-change-quantity-inc`, `sf-change-quantity-dec`; displayer: `sf-show-quantity`) |
| Option Selector (select) | `sf-change-option` on a select element |
| Custom Option Wrapper | `sf-change-option` on a container element |
| Custom Option Value | `sf-option-value` |
| Option Displayer | `sf-show-option` |
| Cart Wrapper | `sf-cart` |
| Cart Popup | `sf-cart-popup` |
| Cart Items List | `sf-cart-list` |
| Cart Item | `sf-cart-item` |
| Cart Item Remover | `sf-cart-item-remove` |
| Cart Subtotal | `sf-cart-subtotal` |
| Checkout Button | `sf-checkout` |

The full attribute catalog (including modules not covered by these rules) is in `attributes-reference.md`.

## CMS pages

On a Webflow CMS Collection template page, the `sf-product` attribute value is bound to a CMS field (the Shopify product ID), so on the published page it renders as a real numeric ID. If the user reports the page is a CMS page, value rules (SF-2xx) still apply to the *rendered* HTML — an empty or placeholder value on a published CMS page means the CMS binding is missing or the field is empty.

---

## SF-1xx — Nesting and structure

### SF-101 — Nested Product Containers
- **Severity:** Error
- **Detect:** An element with `sf-product` (and without `sf-sub-product`) has an ancestor that also has `sf-product`.
- **Why it breaks:** Both containers process the same descendants, so every binding fires twice.
- **Known live symptoms:** image slider shows duplicate slides ("too many slides"); quantity increases by 2 per click; option selectors appear duplicated; items added to cart twice.
- **Fix:** Remove one of the two Product Containers. If the inner one is intentional (a bundled add-on product), give it the `sf-sub-product` attribute instead.

### SF-102 — Product component outside a Product Container
- **Severity:** Error
- **Detect:** A product-scoped component (`sf-show-title`, `sf-show-desc`, `sf-show-sku`, `sf-show-stock`, `sf-change-quantity`, `sf-change-quantity-inc`, `sf-change-quantity-dec`, `sf-show-quantity`, `sf-change-option`, `sf-option-value`, `sf-show-option`) has no ancestor with `sf-product` **and** no ancestor that is an engine-populated template item. Engine-populated template items provide their own product scope and are all valid hosts:
  - `sf-cart-item` (valid for `sf-show-price`, `sf-show-compare-price`, `sf-show-image`, `sf-current-image`, `sf-change-quantity`, `sf-show-title`, `sf-show-options`)
  - `sf-related-products-item`, `sf-upsell-products-list-item`, `sf-search-result-item` (display components inside these are populated per recommended/found product — verified on production sites)
- **Why it breaks:** Product components get their data from the closest Product Container (or template scope). Without one, the element stays empty or inert.
- **Fix:** Move the element inside a Product Container (or add the Buy Module from the Storesynk component library and place the element within it).

### SF-102.1 — Sub-product outside a Product Container
- **Severity:** Error
- **Detect:** An element with `sf-sub-product` has no ancestor with `sf-product`.
- **Fix:** Sub-products only work inside a main Product Container. Move it inside one.

### SF-103 — Product Container without an Add to Cart Button
- **Severity:** Error
- **Detect:** An element with `sf-product` (or `sf-sub-product`) has no descendant with `sf-add-to-cart`.
- **Why it breaks:** The container renders data but the customer cannot buy. (A container used purely for display may be intentional — report it, but note the exception.)
- **Fix:** Add an Add to Cart Button inside the container.

### SF-105 — Component contains incompatible Storesynk components
- **Severity:** Error
- **Detect:**
  - An element with `sf-show-price` or `sf-show-compare-price` has descendants carrying any `sf-*` component attribute (the engine rewrites the price element's text, destroying nested content).
  - An element with `sf-add-to-cart` contains *interactive* components (`sf-change-option`, `sf-option-value`, `sf-change-quantity` and its buttons, `sf-change-variant`, nested `sf-add-to-cart`/`sf-buy-now`, cart components).
  - **Allowed inside `sf-add-to-cart` — do not flag:** display-only components (`sf-show-price`, `sf-show-compare-price`, `sf-button-text` text blocks). Buttons showing the live price, or swapping inner text blocks per state (out-of-stock, loading), are a documented, supported pattern — verified on production sites.
- **Why it breaks:** Interactive components inside the button inherit its click handler; price elements rewrite their contents on update.
- **Fix:** Move the offending elements out so they are siblings, not children.

### SF-107 — Custom Option Wrapper without option values
- **Severity:** Error
- **Detect:** A non-`<select>` element with `sf-change-option` has no descendant with `sf-option-value`.
- **Why it breaks:** The wrapper has nothing to turn into clickable option buttons.
- **Fix:** Add Custom Option Value elements inside the wrapper, one per option value (or connect them to the CMS on CMS pages).

### SF-107.1 — Option value outside a Custom Option Wrapper
- **Severity:** Error
- **Detect:** An element with `sf-option-value` has no ancestor with `sf-change-option`.
- **Fix:** Wrap the option values in a Custom Option Wrapper (`sf-change-option` with the option group name as its value).

### SF-108 — Cart without a Cart Items List
- **Severity:** Error
- **Detect:** An element with `sf-cart` has no descendant with `sf-cart-list`.
- **Why it breaks:** There is nowhere to render the cart lines; the cart appears empty no matter what is added.
- **Fix:** Add a Cart Items List inside the Cart Wrapper.

### SF-109 — Cart without a Cart Subtotal
- **Severity:** Warning
- **Detect:** An element with `sf-cart` has no descendant with `sf-cart-subtotal`.
- **Fix:** Add a Cart Subtotal so customers see the total before checkout.

### SF-110 — Cart without a Checkout Button
- **Severity:** Warning
- **Detect:** An element with `sf-cart` has no descendant with `sf-checkout`.
- **Fix:** Add a Checkout Button inside the Cart Wrapper.

### SF-111 — Cart Items List outside a Cart
- **Severity:** Error
- **Detect:** An element with `sf-cart-list` has no ancestor with `sf-cart`.
- **Fix:** The Cart Items List must live inside the Cart Wrapper.

### SF-112 — Cart Items List without a Cart Item
- **Severity:** Error
- **Detect:** An element with `sf-cart-list` has no descendant with `sf-cart-item`.
- **Why it breaks:** The Cart Item is the template Storesynk clones per cart line. Without it, nothing renders.
- **Fix:** Add one Cart Item (with its inner displayers) inside the list.

### SF-113 — Cart Items List contains non-Cart-Item children
- **Severity:** Warning
- **Detect:** A direct child of an `sf-cart-list` element has no `sf-cart-item` attribute (or carries other `sf-*` attributes instead).
- **Why it breaks:** The list is a looping container; stray children get mixed in with the cloned cart lines.
- **Fix:** Keep only the Cart Item template inside the list; move everything else (headings, empty-state messages) outside it.

### SF-114 — Cart Item (or remover) outside a Cart Items List
- **Severity:** Error
- **Detect:** An element with `sf-cart-item` or `sf-cart-item-remove` has no ancestor with `sf-cart-list`.
- **Fix:** Move it inside the Cart Items List.

---

## SF-2xx — Attribute values and settings

### SF-201 — Product Container without a product
- **Severity:** Error
- **Detect:** The `sf-product` attribute value is empty, `"true"`, or `"1"` (placeholder values), or is not a numeric Shopify product ID.
- **Why it breaks:** The container doesn't know which product to load; every component inside stays empty.
- **Fix:** Static pages — select a product in the Product Container settings (or set the attribute value to the Shopify product ID). CMS pages — connect the attribute value to the product ID field of the CMS collection. If the rendered value *is* a numeric ID, verify it exists in the connected store via the Storefront API (see SKILL.md) — a `null` product means a deleted product or the wrong store.

### SF-202 — Invalid redirect URL
- **Severity:** Error
- **Detect:** An element with `sf-redirect` whose value is not a valid absolute or root-relative URL.
- **Why it breaks:** After add-to-cart the redirect silently fails (the engine rejects invalid redirect URLs).
- **Fix:** Use a full URL (`https://…`) or a path starting with `/`.

### SF-203 — Option group doesn't match the product
- **Severity:** Error
- **Detect:** The value of `sf-change-option` / `sf-show-option` is empty; or, after fetching the product from the Storefront API (see "Storefront API" in SKILL.md — do this proactively), the value matches none of the product's option names (comparison is case-insensitive).
- **Why it breaks:** The selector can't find the option group, so it renders nothing or never updates the variant.
- **Fix:** Set the attribute value to exactly the option name as defined in Shopify (e.g. `Size`, `Color`).

### SF-204 — Option value doesn't match the product
- **Severity:** Error
- **Detect:** The value of `sf-option-value` is empty; or, after fetching the product from the Storefront API (see SKILL.md), the value matches none of the product's option values (case-insensitive).
- **Fix:** Set the attribute value to exactly the option value as defined in Shopify (e.g. `XL`, `Blue`). On CMS pages, connect it to the CMS — unconnected custom option values are also the known cause of duplicated option selectors.

---

## SF-3xx — Element types

### SF-301 — Component must be a container element
- **Severity:** Error
- **Applies to:** `sf-product`, `sf-sub-product`, `sf-cart`, `sf-cart-list`, `sf-cart-item`, and non-select `sf-change-option` wrappers.
- **Detect:** The element is not a block container — flag tags like `<a>`, `<span>`, `<p>`, `<img>`, `<input>`, `<button>`. `<div>` and `<section>` (including Webflow Containers, Quick Stacks, H/V Flex — all render as `<div>`) are correct.
- **Fix:** Recreate the component on a Div (or Section/Quick Stack/Flex) element and move the children across.

### SF-302 — Price should be a text element
- **Severity:** Warning
- **Applies to:** `sf-show-price`, `sf-show-compare-price`.
- **Detect:** The element is not a text-type tag (`<div>` text block, `<p>`, `<span>`).
- **Why it breaks:** Storesynk writes the formatted price as the element's text; non-text elements can render badly or lose their function.
- **Fix:** Use a Text Block, Paragraph, or Span.

### SF-303 — Image component on wrong element
- **Severity:** Error
- **Applies to:** `sf-show-image`, `sf-current-image`, `sf-change-image`.
- **Detect:** The element is not an `<img>`, a Webflow Slider slide, a `<div>` (background-image mode — pair with `sf-set-bg`), or a Collection Item.
- **Fix:** Use an Image element, a Slider Slide, or a Div with `sf-set-bg`.

### SF-306 / SF-307 — Quantity Changer must be a number input
- **Severity:** Error (SF-306) / Warning (SF-307)
- **Applies to:** `sf-change-quantity`.
- **Detect:** SF-306 — the element is not an `<input>`. SF-307 — it is an input, but `type` is not `number`.
- **Why it breaks:** The quantity changer reads/writes the input's numeric value.
- **Fix:** Use a form Input element and set its type to Number.

---

## Reporting

Reference rules by code in audit reports (e.g. "SF-101"). When a rule's *known live symptoms* match what the user reported, say so explicitly — that connection is the answer they came for.
