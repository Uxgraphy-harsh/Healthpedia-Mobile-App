# Healthpedia Frontend (Flutter)

Welcome to the Healthpedia mobile application project.

> [!NOTE]
> **Frontend Prototyping Phase**: Currently focusing on UI/UX implementation. Logic is mocked; tokens are real.

---

## 🤖 AI OPERATING GUIDELINES (Read this first!)
**To save credits and ensure accuracy across model switches, all AI agents MUST follow these rules:**

1. **Query the Graph first**: Before using `grep` or `ls`, check `graphify-out/GRAPH_REPORT.md`. Avoid expensive file-system crawling.
2. **Query the Reuse Map before scanning**: Check [REUSABLE_COMPONENTS.md](./REUSABLE_COMPONENTS.md) before opening many files. Reuse existing screens, cards, bottom sheets, section wrappers, and attachment patterns. Prefer small modifications to an existing component over building a parallel version from scratch.
3. **Follow the Design System**: DO NOT hardcode colors or spacing. Use [AppColors](lib/core/constants/app_colors.dart), [AppTypography](lib/core/constants/app_typography.dart), and [AppSpacing](lib/core/constants/app_spacing.dart).
4. **Advanced Simplicity (Core Philosophy)**: Write code that is **Super Advanced but Simple**. Achieve results through professional, idiomatic, and robust patterns that a senior developer would respect. **Avoid "jugaad" (hacky) solutions** or over-complicating small features with unnecessary "ultra-advanced" techniques.
5. **Maintainability First**: Keep UI components focused and logic clean. Small changes (asset swaps, color fixes, one-off variants for a specific use case) should be implemented by extending or reusing an existing pattern where possible, not as a separate duplicate component.
6. **Reference the Map**: Always keep [SCREENS.md](./SCREENS.md) in context. It is the architectural source of truth.
7. **Small Task Rule**: If the task is small, DO NOT do a broad codebase scan. Check the graph, then [REUSABLE_COMPONENTS.md](./REUSABLE_COMPONENTS.md), then only the directly relevant files. Scanning more files than needed increases credit usage.
8. **Icon Policy**: Always prioritize **Material Icons** (`Icons.xxx`) if a matching or sufficiently similar icon exists in the Flutter framework. Only use SVG/PNG assets from the `Figma MCP Assets` folder for unique brand assets or complex multi-color custom icons. This optimizes performance and ensures 100% reliability on the Apple App Store.
9. **Figma MCP-First Workflow**: DO NOT eyeball designs from screenshots/mockups. ALWAYS use `get_design_context` or `get_metadata` to extract precise offsets, opacity values, color hexes, and node hierarchies from the Figma source of truth. Failure to use the MCP tools correctly leads to loss of design fidelity.
10. **Asset Naming & Organization**: Maintain the `assets/Figma MCP Assets/CommonAssets/` structure for universal assets. Avoid renaming folders unless it drastically improves clarity and you have updated all code references.
11. **Git Commit Policy**: **NEVER** run `git commit` or `git push` automatically after completing a task. Only commit when the user **explicitly** says something like "commit to git", "push this", or "save to GitHub". Proactive commits waste credits and break the user's review flow.
12. **Be Concise**: Prioritize execution and code over verbose explanations.
13. **No Summaries**: After completing a task, do NOT give a detailed summary/table of what was built. Just say **"Done"** — the user will check the result themselves. Summaries waste tokens.
14. **No Ghost Fields**: When building editable list-style rows (e.g., in bottom sheets), DO NOT add a default `TextField` with its own border/label inside a custom-made row. Use `InputDecoration(border: InputBorder.none)` to integrate the input seamlessly into the row's design. Avoid "double-border" or "nested field" visual bugs.
15. **Responsive & Cross-Platform First**: Everything built MUST be fully responsive and cross-platform stable. Avoid fixed pixel heights/widths for containers containing content. Use dynamic sizing (MediaQuery/LayoutBuilder), flexible widgets (Flexible/Expanded), and `SingleChildScrollView` to handle varying screen sizes (Samsung, Google, iPhone, Tablets) and system-level font scaling. Ensure layouts work seamlessly for both Android and iOS without "Yellow Box" overflows.
16. **Master Premium Inputs**: NEVER hardcode individual borders or labels for input fields. ALWAYS use the `Premium` component suite (`lib/core/widgets/premium_inputs/`). These are the only components authorized to handle our "Tactile Depth" design language (glassmorphism, focus shadows, and state-based reactivity).
17. **Implicit Icon Reactivity**: When using `PremiumTextField`, prioritize the `prefixIcon` and `suffixIcon` (IconData) properties. These are precision-engineered to automatically animate from neutral colors to primary pink upon user focus. Manual `Icon` widgets via the `prefix` property should only be used for multi-color or complex brand assets as they do not support automated reactive coloring.
18. **Luxe Standard Spacing**: All text inputs in core flows (Onboarding, Records) must adhere to the "Uber Tall" profile: 20px internal vertical padding and `AppTypography.body1` (16px) for the primary input text.
19. **Tactile Depth Specs**: Our premium standard for interactive surfaces is currently: 16px corner radius, `white.withOpacity(0.15)` glass stroke, and 250ms `easeOutCubic` focus transitions with a primary-colored glow shadow.
20. **Responsive Utility Is Mandatory**: New screens must use `lib/core/utils/app_responsive.dart` for horizontal padding, content width, sheet width/height, title scaling, and onboarding spacing. Do not invent local breakpoint logic inside screens unless you first extend `AppResponsive`.
21. **Constrain Large Screens**: Phone UIs must not stretch edge-to-edge on tablets or desktop previews. Wrap major screen bodies in `ResponsiveConstrainedContent` and use `AppResponsive.contentMaxWidth(...)`, `AppResponsive.onboardingContentMaxWidth(...)`, or `AppResponsive.sheetMaxWidth(...)` as appropriate.
22. **Shared Modal Sheet Presenter Only**: All new modal sheets must be opened through `lib/core/widgets/app_modal_bottom_sheet.dart` so width, safe-area behavior, drag behavior, and cross-platform sheet presentation stay consistent.
23. **Shared Sheet Scaffold Only**: All editable profile/data-entry bottom sheets must use `ProfileInfoSheetScaffold` or a deliberate shared scaffold variant. Do not hand-roll new bottom-sheet headers, handles, keyboard padding, or docked CTA zones.
24. **Shared CTA Buttons Only**: Do not hardcode `ElevatedButton`, `FilledButton`, or ad hoc tappable containers for primary actions in core flows. Use `PremiumButton` / `PremiumButtonDock`, or extend those masters first if a state/variant is missing.
25. **No Fixed Heights For Content Blocks**: Fixed heights are allowed only for atomic controls whose size is part of the design spec, such as buttons, handles, OTP slots, and single-line fields. Do not set fixed heights on cards, sections, sheets, or scroll content that can grow with text, translations, or dynamic data.
26. **Keyboard and Font Scale Safety**: Any screen or sheet containing inputs must remain usable with the keyboard open and with larger system text sizes. Prefer `SingleChildScrollView`, safe-area padding, bounded sheet heights, and `Flexible`/`Expanded` layouts over clipping or overflow-prone stacks.
27. **Onboarding Action Row Standard**: Onboarding screens must use the shared footer pattern in `lib/features/onboarding/widgets/onboarding_footer_actions.dart` for back/navigation controls instead of local fixed-width button rows.

---

## 🎨 Design System & Assets
- **Tokens**: Located in `lib/core/constants/`. These are derived from `assets/tokens/`.
- **Figma Reference**: Use Node `59:438` for the Onboarding/Overview flow.
- **Design System Reference**: This project's input components follow the **Uber Base Gallery** design system. Our modernized, watermark-free reusable suite is implemented in `lib/core/widgets/premium_inputs/`. All legacy components in `premium_field.dart` are deprecated bridges and should be migrated to the new suite.
- **Assets**: Icons and photos are in `assets/Figma MCP Assets/`. Use `SvgPicture` for `.svg` and `Image.asset` for `.png/jpg`. 
  - *Note*: If an SVG asset fails to render correctly (e.g. contains complex patterns), check for a corresponding PNG in the `Icons/Onboarding/` subfolder.

---

## 🧠 Graphify & Knowledge Management
This project uses **Graphify** to maintain a persistent knowledge graph of the codebase.

- **To Rebuild the Graph**: Run `./graphify_rebuild.sh` (or `/graphify .` if configured).
- **Audit Trail**: Check [graphify-out/GRAPH_REPORT.md](./graphify-out/GRAPH_REPORT.md) for architectural "God Nodes".
- **Persistence**: Relationships in `graphify-out/graph.json` survive model switches.
- **Reuse First Workflow**: Graphify is useful for large tasks, but for smaller UI changes always consult [REUSABLE_COMPONENTS.md](./REUSABLE_COMPONENTS.md) first so the agent does not spend credits repeatedly rediscovering the same reusable cards, sheets, and screen structures.

---

## 🚦 Current Session State (Handover)
> [!IMPORTANT]
> **Current Task**: Shared responsiveness hardening and UI rule formalization.
> **Last Goal**: Standardize responsive behavior through shared primitives instead of screen-level hacks. Current focus: onboarding shells, modal sheet presentation, sheet scaffolds, and profile info flows.
> **Environment Status**: `node` and `pip` are currently missing/not in PATH.

---

## Getting Started
To run this project:
```bash
flutter pub get
flutter run
```
