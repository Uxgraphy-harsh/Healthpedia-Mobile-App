# Project: Healthpedia

## What this app does
Healthpedia is a comprehensive mobile application designed to simplify healthcare management. It helps users easily access health information, manage medical records, and connect with healthcare services, solving the problem of fragmented and hard-to-navigate health data.

## Tech stack
- Flutter (Dart) — frontend only
- Target: Android and iOS
- State management: [we will decide — leave blank for now]
- Navigation: go_router

## Design system
- Design tokens are in lib/tokens/brand_tokens.json
- All colors must come from AppColors in core/constants/app_colors.dart
- All text styles from AppTypography
- All spacing from AppSpacing
- NEVER hardcode hex colors or font sizes directly in widgets

## Screen map
See SCREENS.md for the complete list of screens and how they connect.

## Rules for the AI agent
- NEVER delete or rename existing files without asking me first
- NEVER change the folder structure without asking me first
- Always read SCREENS.md before creating or modifying any screen
- Always read ARCHITECTURE.md before making any structural decision
- Build one screen at a time — never multiple screens in one task
- After finishing a screen, write a short summary of what was built
- When in doubt, ask — don't assume
- Keep each Dart file under 300 lines — split into widgets if longer
- Every widget must have a comment explaining what it does

## Figma MCP usage
When I give you a Figma frame link, do this:
1. Read the frame using Figma MCP
2. Read the design tokens from brand_tokens.json
3. Read SCREENS.md to understand where this screen connects
4. Build the screen using ONLY Flutter widgets and our token values
5. Show me a summary of what you built and any assumptions you made

## Do not
- Do not use any paid packages without asking first
- Do not call any external APIs — those live in core/network/ and are empty
- Do not add any analytics or tracking code
- Do not make the app require internet to display UI
