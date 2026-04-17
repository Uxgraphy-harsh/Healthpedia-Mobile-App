import 'dart:async';

import 'package:flutter/material.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'package:healthpedia_frontend/core/constants/app_typography.dart';
import 'package:healthpedia_frontend/core/widgets/app_modal_bottom_sheet.dart';
import 'package:healthpedia_frontend/core/widgets/premium_inputs/premium_field_states.dart';
import 'package:healthpedia_frontend/core/widgets/premium_inputs/premium_pin_field.dart';
import 'package:healthpedia_frontend/core/widgets/premium_inputs/premium_text_field.dart';
import 'package:healthpedia_frontend/features/main/widgets/profile_info_sheet_scaffold.dart';

void showEditEmailSheet(
  BuildContext context, {
  required String initialEmail,
  required ValueChanged<String> onUpdate,
}) {
  showAppModalBottomSheet(
    context: context,
    builder: (context) =>
        EditEmailBottomSheet(initialEmail: initialEmail, onUpdate: onUpdate),
  );
}

enum EditEmailStep { emailInput, otpInput }

class EditEmailBottomSheet extends StatefulWidget {
  const EditEmailBottomSheet({
    super.key,
    required this.initialEmail,
    required this.onUpdate,
  });

  final String initialEmail;
  final ValueChanged<String> onUpdate;

  @override
  State<EditEmailBottomSheet> createState() => _EditEmailBottomSheetState();
}

class _EditEmailBottomSheetState extends State<EditEmailBottomSheet> {
  EditEmailStep _currentStep = EditEmailStep.emailInput;
  ProfileInfoOtpStatus _otpStatus = ProfileInfoOtpStatus.none;

  final TextEditingController _emailController = TextEditingController(
    text: 'harsh@uxgraphy.com',
  );
  Timer? _timer;
  int _secondsRemaining = 49;
  bool _canResend = false;
  String _otpValue = '';

  @override
  void initState() {
    super.initState();
    _emailController.text = widget.initialEmail;
  }

  @override
  void dispose() {
    _emailController.dispose();
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

  void _handleOTPChange(String value) {
    _otpValue = value;
    setState(() {
      _otpStatus = value.length == 5
          ? ProfileInfoOtpStatus.data
          : ProfileInfoOtpStatus.none;
    });
  }

  void _onVerify() async {
    if (_otpValue == '16889') {
      setState(() => _otpStatus = ProfileInfoOtpStatus.success);
    } else {
      setState(() => _otpStatus = ProfileInfoOtpStatus.error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEmailInput = _currentStep == EditEmailStep.emailInput;
    return ProfileInfoSheetScaffold(
      title: 'Edit email',
      leadingLabel: isEmailInput ? 'Cancel' : 'Back',
      onLeadingTap: () {
        if (isEmailInput) {
          Navigator.pop(context);
        } else {
          setState(() {
            _currentStep = EditEmailStep.emailInput;
            _otpStatus = ProfileInfoOtpStatus.none;
            _otpValue = '';
          });
        }
      },
      trailingLabel: isEmailInput
          ? null
          : (_canResend ? 'Resend code' : 'Resend ($_secondsRemaining sec)'),
      onTrailingTap: isEmailInput ? null : (_canResend ? _startTimer : null),
      primaryLabel: isEmailInput ? 'Send Code' : 'Verify',
      primaryEnabled: isEmailInput || _otpStatus != ProfileInfoOtpStatus.none,
      primaryColor: _otpStatus == ProfileInfoOtpStatus.success
          ? AppColors.green500
          : null,
      primaryChild: _otpStatus == ProfileInfoOtpStatus.success
          ? const Icon(
              Icons.check_circle_outline_rounded,
              color: AppColors.white,
            )
          : null,
      onPrimaryTap: () {
        if (isEmailInput) {
          setState(() => _currentStep = EditEmailStep.otpInput);
          _startTimer();
        } else if (_otpStatus == ProfileInfoOtpStatus.success) {
          widget.onUpdate(_emailController.text.trim());
          Navigator.pop(context);
        } else {
          _onVerify();
        }
      },
      child: isEmailInput ? _buildEmailInputStep() : _buildOTPInputStep(),
    );
  }

  Widget _buildEmailInputStep() {
    return PremiumTextField(
      label: 'Email',
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      isDark: false,
    );
  }

  Widget _buildOTPInputStep() {
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
          onChanged: _handleOTPChange,
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
