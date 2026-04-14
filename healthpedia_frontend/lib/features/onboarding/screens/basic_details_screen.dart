import 'package:flutter/material.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'package:healthpedia_frontend/core/constants/app_typography.dart';
import 'package:healthpedia_frontend/core/constants/app_spacing.dart';
import 'package:healthpedia_frontend/features/onboarding/screens/health_condition_screen.dart';

/// The Basic Details onboarding screen.
/// Features a dark maroon theme, sliding avatar selector, and custom glass-effect input fields.
class BasicDetailsScreen extends StatefulWidget {
  const BasicDetailsScreen({super.key});

  @override
  State<BasicDetailsScreen> createState() => _BasicDetailsScreenState();
}

class _BasicDetailsScreenState extends State<BasicDetailsScreen> {
  // Mock list of avatar paths spanning children and adults
  final List<String> avatars = [
    'assets/Figma MCP Assets/Onboarding Screens/Onboarding Screens Images/M 84.png',
    'assets/Figma MCP Assets/Onboarding Screens/Onboarding Screens Images/F 84.png',
    'assets/Figma MCP Assets/Onboarding Screens/Onboarding Screens Images/M 85.png',
    'assets/Figma MCP Assets/Onboarding Screens/Onboarding Screens Images/F 85.png',
    'assets/Figma MCP Assets/Onboarding Screens/Onboarding Screens Images/M 86.png',
    'assets/Figma MCP Assets/Onboarding Screens/Onboarding Screens Images/F 86.png',
  ];

  late final PageController _avatarController;
  int selectedAvatarIndex = 2; // Default to center

  @override
  void initState() {
    super.initState();
    _avatarController = PageController(
      viewportFraction: 0.25,
      initialPage: selectedAvatarIndex,
    );
  }

  @override
  void dispose() {
    _avatarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.maroon700,
      body: Stack(
        children: [
          // ── Background Watermark ──────────
          Positioned(
            left: -327,
            top: 351,
            child: Opacity(
              opacity: 0.1, // Matches blush subtlety
              child: Image.asset(
                'assets/Figma MCP Assets/Onboarding Screens/Onboarding Screens Images/Repeat group 4.png',
                width: 1045,
                height: 1045,
                fit: BoxFit.cover,
                // Apply a slight color filter if the asset is not white/maroon by nature.
                // In Figma, opacity/blend modes define the look.
              ),
            ),
          ),

          // ── Main Content ──────────
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Progress Bar ──────────
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.space16,
                    vertical: AppSpacing.space16,
                  ),
                  child: Container(
                    height: 4,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.white.withOpacity(0.2), // Inactive track
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: 89.5, // 25% width per Figma
                        decoration: BoxDecoration(
                          color: AppColors.pink200, // Active indicator
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: AppSpacing.space24),
                          // ── Title ──────────
                          Text(
                            'Please enter basic details',
                            style: TextStyle(
                              fontFamily: 'Geist',
                              fontSize: 56, // Title-3
                              height: 68 / 56, // line-height
                              color: AppColors.rose50,
                              fontWeight: FontWeight.w400,
                            ),
                          ),

                          const SizedBox(height: AppSpacing.space32),

                          // ── Avatar Carousel ──────────
                          SizedBox(
                            height: 100,
                            child: PageView.builder(
                              controller: _avatarController,
                              onPageChanged: (index) {
                                setState(() {
                                  selectedAvatarIndex = index;
                                });
                              },
                              itemCount: avatars.length,
                              itemBuilder: (context, index) {
                                final isSelected = index == selectedAvatarIndex;
                                return GestureDetector(
                                  onTap: () {
                                    _avatarController.animateToPage(
                                      index,
                                      duration: const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut,
                                    );
                                  },
                                  child: AnimatedOpacity(
                                    duration: const Duration(milliseconds: 200),
                                    opacity: isSelected ? 1.0 : 0.7,
                                    child: Center(
                                      child: AnimatedContainer(
                                        duration: const Duration(milliseconds: 200),
                                        curve: Curves.easeOut,
                                        width: isSelected ? 80 : 60,
                                        height: isSelected ? 80 : 60,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: isSelected ? Colors.white : Colors.transparent,
                                            width: isSelected ? 3 : 0,
                                          ),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(50),
                                          child: Image.asset(
                                            avatars[index],
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),

                          const SizedBox(height: AppSpacing.space32),

                          // ── Form Fields ──────────
                          const _BasicDetailsField(hintText: 'Name'),
                          const SizedBox(height: AppSpacing.space16),
                          const _DatePickerField(
                            hintText: 'Date of Birth',
                          ),
                          const SizedBox(height: AppSpacing.space16),
                          const _GenderDropdownField(),
                          const SizedBox(height: AppSpacing.space16),
                          Row(
                            children: const [
                              Expanded(child: _BasicDetailsField(hintText: 'Height (cm)')),
                              SizedBox(width: AppSpacing.space16),
                              Expanded(child: _BasicDetailsField(hintText: 'Weight (kg)')),
                            ],
                          ),
                          
                          const SizedBox(height: 80.0), // Padding to clear bottom CTA
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ── Bottom Controls ──────────
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.only(
                left: AppSpacing.space24,
                right: AppSpacing.space24,
                bottom: AppSpacing.space48,
              ),
              child: Row(
                children: [
                  // Back button
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.white.withOpacity(0.5),
                        width: 1,
                      ),
                      color: Colors.transparent,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: AppColors.white),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.space16),
                  // Continue Button
                  Expanded(
                    child: SizedBox(
                      height: 52,
                      child: FilledButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const HealthConditionScreen()),
                          );
                        },
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.pink600, // Matching dark theme button
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(26), // Pill shape
                          ),
                        ),
                        child: Text(
                          'Continue',
                          style: AppTypography.body3SemiBold.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════
// Custom form field mimicking the glass design
// ═══════════════════════════════════════════════════════════
class _BasicDetailsField extends StatelessWidget {
  final String hintText;
  final IconData? trailingIcon;

  const _BasicDetailsField({
    required this.hintText,
    this.trailingIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        color: const Color(0x1AFFFFFF), // Hardcoded hex for 10% white to prevent solid rendering bugs
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0x26FFFFFF), // 15% white
          width: 0.5,
        ),
      ),
      child: Center(
        child: TextFormField(
          style: const TextStyle(
            color: AppColors.rose50,
            fontSize: 15,
            fontFamily: 'Geist',
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: AppColors.rose50.withOpacity(0.8),
              fontSize: 15,
              fontFamily: 'Geist',
            ),
            suffixIcon: trailingIcon != null
                ? Icon(
                    trailingIcon,
                    color: AppColors.rose50.withOpacity(0.8),
                    size: 20,
                  )
                : null,
            filled: false, // Ensures TextFormField does not paint its own solid background
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.space16,
              vertical: 16,
            ),
          ),
        ),
      ),
    );
  }
}

class _DatePickerField extends StatefulWidget {
  final String hintText;

  const _DatePickerField({required this.hintText});

  @override
  State<_DatePickerField> createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<_DatePickerField> {
  DateTime? _selectedDate;

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 365 * 20)), // Default 20 years old
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppColors.pink600,
              onPrimary: AppColors.white,
              surface: AppColors.maroon700,
              onSurface: AppColors.rose50,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.pink200, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        color: const Color(0x1AFFFFFF),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0x26FFFFFF),
          width: 0.5,
        ),
      ),
      child: InkWell(
        onTap: () => _pickDate(context),
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _selectedDate != null 
                    ? "${_selectedDate!.day.toString().padLeft(2, '0')}/${_selectedDate!.month.toString().padLeft(2, '0')}/${_selectedDate!.year}"
                    : widget.hintText,
                style: TextStyle(
                  color: _selectedDate != null ? AppColors.rose50 : AppColors.rose50.withOpacity(0.8),
                  fontSize: 15,
                  fontFamily: 'Geist',
                ),
              ),
              Icon(
                Icons.calendar_today_outlined,
                color: AppColors.rose50.withOpacity(0.8),
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GenderDropdownField extends StatelessWidget {
  const _GenderDropdownField();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space16),
      decoration: BoxDecoration(
        color: const Color(0x1AFFFFFF),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0x26FFFFFF),
          width: 0.5,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          dropdownColor: AppColors.maroon700,
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppColors.rose50.withOpacity(0.8),
            size: 24,
          ),
          hint: Text(
            'Gender',
            style: TextStyle(
              color: AppColors.rose50.withOpacity(0.8),
              fontSize: 15,
              fontFamily: 'Geist',
            ),
          ),
          items: ['Male', 'Female', 'Other'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: const TextStyle(
                  color: AppColors.rose50,
                  fontSize: 15,
                  fontFamily: 'Geist',
                ),
              ),
            );
          }).toList(),
          onChanged: (newValue) {
            // Handle change
          },
        ),
      ),
    );
  }
}
