# UCP Panel Builder

An interactive layout tool for **Middle Atlantic FK2** connector panels — the 2RU
(3-1/2"), 19" rack frame that accepts five UCP punchout modules across a single tier.

Drag modules onto the frame, name the frame, type the engraving text that goes under
each punchout, and read off a parts list you can print straight to PDF.

> Reference layout tool. Confirm connector fit and part numbers against the current
> Middle Atlantic UCP documentation before ordering.

---

## What it does

| | |
| --- | --- |
| **Frame layout** | A schematic front elevation of the FK2 at a true 19" × 3-1/2" aspect, with the five slots drawn to scale. Punchouts render at their real proportions from the module's hole pattern. |
| **Module tray** | All 48 modules, filterable by category. Drag onto a slot, or click a module and then click a slot. |
| **Multiple frames** | Add as many FK2 frames as the job needs; each gets its own name, slots and labels. |
| **Engraving labels** | Up to 10 characters per punchout, shown under the hole on the panel drawing and collected in a per-frame sidebar. |
| **Parts list** | A live bill of materials — the FK2 frame kits plus every module, quantity-rolled across all frames, with published part numbers. |
| **Module catalog** | The full reference table, grouped by category. |
| **PDF export** | Print with a job name stamped on the sheet. Choose *Panel + parts list* or *Panel only*; UI chrome drops out of the print. |

### Module catalog

48 modules in 8 categories:

- **XLR & Neutrik** — `UNIV1`–`UNIV6` universal XLR female, `XLR IN` male
- **Combo & circular** — `COMBO2/4/6`, 4-bolt circular flange (`4SC1`, `4SC3`), Socapex 19 (`SPX-19`)
- **BNC & video** — `1/2BNC1`–`1/2BNC4`, `CANARE4`
- **Multipin** — Elco 38/56/90, Whirlwind, Cannon DL96
- **Data & serial** — DB9, DB15/HD15, DB25, DB37
- **Jacks & drilled holes** — 1/4", 3/8", 7/16" holes and dual banana
- **Power** — duplex AC outlets, twistlock
- **Blank & vented** — `UCPB1` blank, `UCP-VT` vented blank

Part numbers follow Middle Atlantic's own inconsistency: the `UCP-` prefix appears on
the XLR-female family and the vent module (`UCP-UNIV4`, `UCP-VT`); every other module is
listed by its bare code (`1/2BNC4`, `2ELCO38`).

---

## Running it

The page pulls React 18, ReactDOM and Babel from unpkg at runtime, so it needs an
**internet connection**. Serve it over HTTP rather than opening the file directly — the
runtime re-fetches the page's own source on boot, which `file://` blocks:

```bash
python3 -m http.server 8000
# then open http://localhost:8000/UCP%20Panel%20Builder.dc.html
```

---

## Repo layout

```
UCP Panel Builder.dc.html   The whole app: markup template + component logic
support.js                  Design-canvas runtime (generated — do not edit)
_ds/nocturne-…/             Nocturne design system: tokens, styles, component classes
```

### `UCP Panel Builder.dc.html`

A single-file design-canvas component, in two halves:

- **The template** (inside `<x-dc>`) — plain HTML with `{{ }}` bindings and `<sc-for>` /
  `<sc-if>` control flow.
- **The logic** (inside `<script type="text/x-dc">`) — a `DCLogic` class holding state
  (`frames`, `filter`, `picked`, `over`) and a `renderVals()` that returns everything the
  template binds to.

The hole geometry is computed, not drawn by hand. `grid(cols, rows, w, h, r)` lays out a
punchout pattern in real inches against a 3.4" module face (3.15" × 2.45" usable) and
converts to percentages, so every module's holes are positioned consistently and scale
with the frame.

Three props are exposed to the canvas editor: **Show Export to PDF button**,
**What the PDF contains** (`Panel + parts list` / `Panel only`), and
**Job name printed on the sheet**.

### `_ds/` — Nocturne

The design system the panel is styled with: a quiet, compact dark interface on a
near-neutral blue-grey ground, Inter at medium weight, 8px radii, and a single blurple
accent used as a line and a glow rather than a flood. Every color, font, space, radius
and shadow comes from a CSS variable in `styles.css` — see
[`_ds/nocturne-…/readme.md`](_ds/nocturne-56349b84-ffe9-4905-9825-98d3ee5d0820/readme.md)
for the full guide.
