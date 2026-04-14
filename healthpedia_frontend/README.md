# Healthpedia Frontend

Welcome to the Healthpedia mobile application project.

> [!NOTE]
> **Frontend Prototyping Phase**: This project is currently focused entirely on the frontend design phase. It contains basic prototypes and UI implementations without real backend functional logic. The backend integration will be worked out in a later phase.

## Development Workflow

When working on the frontend codebase, please adhere to the following workflow rules:

Always check the [SCREENS.md](./SCREENS.md) file when working on the frontend code. This file contains the complete architectural map and explains the full app flow. Understanding how a screen connects to the rest of the application is mandatory before making modifications or adding new screens.

### Visual Analysis & Screenshots 📸
When the user provides screenshots for visual reference:
1. **Figma Reference Screenshots**: These are the ultimate source-of-truth for visual design (scale, spacing, proportion). You will recognize these as clean mobile frames without any code editor UI.
2. **Implementation Screenshots (Android Studio/Emulator)**: These show the literal codebase output on the device preview. If a screenshot contains Android Studio windows or IDE code alongside the emulator, it is meant to show you the current buggy implementation. Ignore the code text in these images and focus strictly on comparing the emulator screen against the pure Figma reference image to correct issues.

### Design Tokens & Figma MCP
Our design system is token-driven. You will find our extracted Figma tokens inside the `assets/tokens/` folder (such as `brand_tokens.json`). 

Whenever you are building or updating screens using the **Figma MCP**:
1. You strictly must utilize these design tokens rather than hardcoding hex colors, font sizes, or spacing.
2. Refer to the `assets/Figma MCP Assets/` folder, which contains relevant pre-exported image/icon assets. Use these assets to accurately replicate the pixel-perfect design.

### AI Assistants & Graphify 🧠
This project has [Graphify](https://github.com/safishamsi/graphify) installed and configured specifically to assist AI agents (like Antigravity). Agents can run `/graphify .` in the terminal to generate a full visual codebase mapping and analyze architecture, greatly improving context-awareness and reliability when coding features.

## Getting Started

To run this project:
```bash
flutter pub get
flutter run
```
