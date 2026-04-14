# Healthpedia Frontend (Flutter)

Welcome to the Healthpedia mobile application project.

> [!NOTE]
> **Frontend Prototyping Phase**: Currently focusing on UI/UX implementation. Logic is mocked; tokens are real.

---

## 🤖 AI OPERATING GUIDELINES (Read this first!)
**To save credits and ensure accuracy across model switches, all AI agents MUST follow these rules:**

1. **Query the Graph first**: Before using `grep` or `ls`, check `graphify-out/GRAPH_REPORT.md`. Avoid expensive file-system crawling.
2. **Follow the Design System**: DO NOT hardcode colors or spacing. Use [AppColors](lib/core/constants/app_colors.dart), [AppTypography](lib/core/constants/app_typography.dart), and [AppSpacing](lib/core/constants/app_spacing.dart).
3. **Advanced Simplicity (Core Philosophy)**: Write code that is **Super Advanced but Simple**. Achieve results through professional, idiomatic, and robust patterns that a senior developer would respect. **Avoid "jugaad" (hacky) solutions** or over-complicating small features with unnecessary "ultra-advanced" techniques.
4. **Maintainability First**: Keep UI components focused and logic clean. Small changes (asset swaps, color fixes) should be implemented properly, not as convoluted workarounds.
5. **Reference the Map**: Always keep [SCREENS.md](./SCREENS.md) in context. It is the architectural source of truth.
6. **Icon Policy**: Always prioritize **Material Icons** (`Icons.xxx`) if a matching or sufficiently similar icon exists in the Flutter framework. Only use SVG/PNG assets from the `Figma MCP Assets` folder for unique brand assets or complex multi-color custom icons. This optimizes performance and ensures 100% reliability on the Apple App Store.
7. **Be Concise**: Prioritize execution and code over verbose explanations.

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
