# Reusable Components And Screen Patterns

Use this file as a low-cost lookup before scanning the codebase. It is intentionally lightweight and should be updated whenever a reusable pattern is introduced or materially changed.

## Workflow

1. Check `graphify-out/GRAPH_REPORT.md` if the task is broad or architectural.
2. Check this file before opening many source files.
3. If the task is small, open only the most relevant file(s) listed here.
4. Reuse an existing pattern and make a small variation if needed.
5. Only scan wider if this file does not cover the use case.

## Global Foundations

- Design tokens: `lib/core/constants/app_colors.dart`, `lib/core/constants/app_spacing.dart`, `lib/core/constants/app_typography.dart`
- Theme: `lib/core/theme/app_theme.dart`
- Shared widgets: `lib/shared/widgets/app_button.dart`, `lib/shared/widgets/app_card.dart`, `lib/shared/widgets/app_text_field.dart`

## ❖ Premium Design System (Standardized Master Components)

All input components MUST derive from `BaseInputContainer` and ideally reuse `PremiumTextField` for consistent tactile depth.

### Core Implementation Rules
1. **Vertical Padding**: Mandatory **20px** vertical padding (Uber Tall) for all main fields.
2. **Corner Radius**: Default **16px** for forms. Use **100px** (Pill) for Search.
3. **Implicit Icon Reactivity**: Prefix icons MUST use the `prefixIcon` property to allow automated focus-state coloring (Primary Pink on focus).
4. **Automated State Icons**:
   - `state: PremiumFieldState.loading` → Shows automated Spinner.
   - `state: PremiumFieldState.success` → Shows automated Checkmark.
   - `state: PremiumFieldState.error` → Shows automated Exclamation.
5. **Selection Pattern**: Drodown-style selects (`PremiumSelect`) MUST appear as floating overlays under the field, not bottom sheets, unless accessibility requires otherwise.

### The Master Suite
- **PremiumTextField**: The foundation for all text-based entry.
- **PremiumSelect**: Stateful floating dropdown overlay.
- **PremiumCountryField**: Dual-box (Uber-style) layout for picker + input.
- **PremiumPINField**: Multi-box (Discrete) layout with 16px radius and 64px height.
- **PremiumSearchField**: Pill-shaped with automated clear-on-text logic.
- **PremiumPasswordField**: Includes synchronized visibility toggle and autofill support.
- **PremiumDatePicker**: Inherits field aesthetics and triggers themed selection.
- **PremiumSegmentedControl**: Tactical horizontal switch for gender, status toggles, etc.
- Specialized Master Inputs:
  - `lib/core/widgets/premium_inputs/premium_segmented_control.dart` (Official choice toggle pattern)
  - `lib/core/widgets/premium_inputs/premium_country_field.dart` (Integrated phone/flag logic)
  - `lib/core/widgets/premium_inputs/premium_pin_field.dart` (High-fidelity OTP/PIN entry)
  - `lib/core/widgets/premium_inputs/premium_field_group.dart` (Visual bonding for related fields)
- Note: Use this suite for all onboarding and core records screens to maintain the "Tactile Depth" design language.

## Onboarding Patterns

- Overview carousel shell and CTA style: `lib/features/onboarding/screens/overview_screen.dart`
- Maroon onboarding shell pattern:
  `lib/features/onboarding/screens/basic_details_screen.dart`
  `lib/features/onboarding/screens/health_condition_screen.dart`
  `lib/features/onboarding/screens/health_trackers_screen.dart`
  `lib/features/onboarding/screens/permissions_screen.dart`
- Repeated onboarding elements:
  progress bar
  watermark background
  bottom CTA row with back button
  glass-effect fields/cards

## Records Module Patterns

- Records tabs and tab-specific CTA behavior: `lib/features/main/screens/records_screen.dart`
- Notes tab list/card pattern: `lib/features/main/screens/records_screen.dart`
- Report folder/list card patterns: `lib/features/main/screens/report_folder_screen.dart`
- Symptom detail timeline/detail pattern: `lib/features/main/screens/symptom_detail_screen.dart`
- Report detail master pattern for:
  section titles
  detail tables
  prescribed medicine cards
  linked attachment cards
  bottom action bar
  Source: `lib/features/main/screens/report_detail_screen.dart`
- Prescription detail screen:
  `lib/features/main/screens/prescription_detail_screen.dart`
  Reuse this first for prescription-specific detail layouts instead of cloning from Figma again.
- Profile screen:
  `lib/features/main/screens/profile_screen.dart`
  Reuse this for:
  grouped settings/menu rows
  promo cards
  social footer block
  profile hero layout

## Bottom Sheet Patterns

- Add reminder sheet:
  `lib/features/main/widgets/add_reminder_bottom_sheet.dart`
  Reuse for field rows, section labels, time/date controls, and save CTA structure.
- Repeat selector sheet:
  `lib/features/main/widgets/repeat_bottom_sheet.dart`
- Sort selector sheet:
  `lib/features/main/widgets/sort_bottom_sheet.dart`
- Add symptom sheet:
  `lib/features/main/widgets/add_symptom_bottom_sheet.dart`
  Reuse for:
  constrained-height bottom sheet pattern
  sticky footer CTA pattern
  upload area
  attachment rows
  chip/toggle groups
- Prescription flow sheets:
  `lib/features/main/widgets/add_prescription_bottom_sheet.dart`
  Contains:
  base prescription entry sheet
  medicines list sheet
  medicine add-more editor sheet
  prescription details sheet
- Add note sheet:
  `lib/features/main/widgets/add_note_bottom_sheet.dart`
  Reuse for:
  compact text-entry sheet
  cancel/title header
  sticky single CTA footer

## Repeated Card Patterns

- Medicine card with:
  large image
  thumbnail strip
  medicine title/subtitle
  timing row
  quantity badge
  Source: `lib/features/main/screens/prescription_detail_screen.dart`
- Linked file card:
  PDF/file icon + title + size + trailing action
  Source: `lib/features/main/screens/prescription_detail_screen.dart`
- Linked record/reference card:
  left date block + metadata + title + subtitle + chevron
  Source: `lib/features/main/screens/prescription_detail_screen.dart`
- Notes list card:
  timestamp + title + multi-line body inside rounded bordered card
  Source: `lib/features/main/screens/records_screen.dart`

## Repeated Bottom Action Bars

- Report-style bottom action bar with `Ask AI` + `Share`:
  `lib/features/main/screens/report_detail_screen.dart`
  `lib/features/main/screens/prescription_detail_screen.dart`
- Sticky bottom CTA inside sheets:
  `lib/features/main/widgets/add_symptom_bottom_sheet.dart`
  `lib/features/main/widgets/add_prescription_bottom_sheet.dart`

## Credit-Saving Rules

- Do not rebuild a card if a near-identical one already exists.
- Do not create a new bottom sheet file if the flow belongs inside an existing multi-step sheet file.
- Do not scan every screen in a module when the task clearly belongs to one known pattern.
- If a component is 80-90% similar, extend or parameterize it rather than cloning it.
- Update this file when you introduce a new reusable pattern so future runs stay cheap.
