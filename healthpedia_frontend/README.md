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

---

## 🎨 Design System & Assets
- **Tokens**: Located in `lib/core/constants/`. These are derived from `assets/tokens/`.
- **Figma Reference**: Use Node `59:438` for the Onboarding/Overview flow.
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
> **Current Task**: Onboarding Carousel Complete.
> **Last Goal**: Implemented "Apple Glass" CTAs with solid black Primary failsafe and PNG icon integration. Updated README with coding philosophy.
> **Environment Status**: `node` and `pip` are currently missing/not in PATH.

---

## Getting Started
To run this project:
```bash
flutter pub get
flutter run
```
