import 'dart:async';

import 'package:flutter/material.dart';
import 'package:healthpedia_frontend/core/constants/app_typography.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'package:healthpedia_frontend/core/widgets/app_modal_bottom_sheet.dart';
import 'package:healthpedia_frontend/core/widgets/premium_inputs/premium_field_states.dart';
import 'package:healthpedia_frontend/core/widgets/premium_inputs/premium_pin_field.dart';
import 'package:healthpedia_frontend/core/widgets/premium_inputs/premium_text_field.dart';
import 'package:healthpedia_frontend/features/main/widgets/profile_info_sheet_scaffold.dart';

/// Entry point to show the standardized Edit Phone sheet.
void showEditPhoneSheet(
  BuildContext context, {
  required String initialPhone,
  required ValueChanged<String> onUpdate,
}) {
  showAppModalBottomSheet(
    context: context,
    builder: (context) =>
        EditPhoneBottomSheet(initialPhone: initialPhone, onUpdate: onUpdate),
  );
}

enum EditPhoneStep { phoneInput, otpInput }

class EditPhoneBottomSheet extends StatefulWidget {
  const EditPhoneBottomSheet({
    super.key,
    required this.initialPhone,
    required this.onUpdate,
  });

  final String initialPhone;
  final ValueChanged<String> onUpdate;

  @override
  State<EditPhoneBottomSheet> createState() => _EditPhoneBottomSheetState();
}

class _EditPhoneBottomSheetState extends State<EditPhoneBottomSheet> {
  EditPhoneStep _currentStep = EditPhoneStep.phoneInput;
  final TextEditingController _phoneController = TextEditingController(
    text: '9039443124',
  );

  int _secondsRemaining = 49;
  Timer? _timer;
  bool _canResend = false;
  String _otpValue = '';
  ProfileInfoOtpStatus _otpStatus = ProfileInfoOtpStatus.none;

  @override
  void initState() {
    super.initState();
    _phoneController.text = widget.initialPhone;
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() {
      _secondsRemaining = 49;
      _canResend = false;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _canResend = true;
          _timer?.cancel();
        }
      });
    });
  }

  void _onStepContinue() {
    if (_currentStep == EditPhoneStep.phoneInput) {
      setState(() {
        _currentStep = EditPhoneStep.otpInput;
        _otpStatus = ProfileInfoOtpStatus.none;
        _otpValue = '';
      });
      _startTimer();
    } else if (_otpStatus == ProfileInfoOtpStatus.success) {
      widget.onUpdate(_phoneController.text.trim());
      Navigator.pop(context);
    } else {
      _handleVerify();
    }
  }

  void _handleVerify() {
    if (_otpValue.length < 5) return;
    setState(() {
      _otpStatus = _otpValue == '16889'
          ? ProfileInfoOtpStatus.success
          : ProfileInfoOtpStatus.error;
    });
  }

  void _handleOtpChanged(String value) {
    _otpValue = value;
    setState(() {
      _otpStatus = value.length == 5
          ? ProfileInfoOtpStatus.data
          : ProfileInfoOtpStatus.none;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isPhoneInput = _currentStep == EditPhoneStep.phoneInput;
    return ProfileInfoSheetScaffold(
      title: isPhoneInput ? 'Edit phone' : 'Edit phone',
      leadingLabel: isPhoneInput ? 'Cancel' : 'Back',
      onLeadingTap: () {
        if (isPhoneInput) {
          Navigator.pop(context);
        } else {
          setState(() {
            _currentStep = EditPhoneStep.phoneInput;
            _otpValue = '';
            _otpStatus = ProfileInfoOtpStatus.none;
          });
        }
      },
      trailingLabel: isPhoneInput
          ? null
          : (_canResend ? 'Resend code' : 'Resend ($_secondsRemaining sec)'),
      onTrailingTap: isPhoneInput ? null : (_canResend ? _startTimer : null),
      primaryLabel: isPhoneInput ? 'Send Code' : 'Verify',
      primaryEnabled: isPhoneInput || _otpStatus != ProfileInfoOtpStatus.none,
      primaryColor: _otpStatus == ProfileInfoOtpStatus.success
          ? AppColors.green500
          : null,
      primaryChild: _otpStatus == ProfileInfoOtpStatus.success
          ? const Icon(
              Icons.check_circle_outline_rounded,
              color: AppColors.white,
            )
          : null,
      onPrimaryTap: _onStepContinue,
      child: isPhoneInput ? _buildPhoneInputStep() : _buildOtpStep(),
    );
  }

  Widget _buildPhoneInputStep() {
    return PremiumTextField(
      label: 'Phone',
      controller: _phoneController,
      keyboardType: TextInputType.phone,
      isDark: false,
      prefix: Text(
        '+91',
        style: AppTypography.label1.copyWith(
          color: AppColors.neutral500,
          fontWeight: FontWeight.w400,
        ),
      ),
      onChanged: (value) {
        final digits = value.replaceAll(RegExp(r'[^0-9]'), '');
        if (digits != value) {
          _phoneController.value = TextEditingValue(
            text: digits,
            selection: TextSelection.collapsed(offset: digits.length),
          );
        }
      },
    );
  }

  Widget _buildOtpStep() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        PremiumPINField(
          length: 5,
          isDark: false,
          state: _otpStatus == ProfileInfoOtpStatus.error
              ? PremiumFieldState.error
              : _otpStatus == ProfileInfoOtpStatus.success
              ? PremiumFieldState.success
              : PremiumFieldState.defaultState,
          onChanged: _handleOtpChanged,
        ),
        if (_otpStatus == ProfileInfoOtpStatus.error)
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Text(
              'You have entered an incorrect code.',
              style: AppTypography.label2.copyWith(color: AppColors.red400),
            ),
          ),
      ],
    );
  }
}
