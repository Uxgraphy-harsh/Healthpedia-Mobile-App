import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthpedia_frontend/core/widgets/premium_inputs/premium_field_states.dart';
import 'package:healthpedia_frontend/core/widgets/premium_inputs/premium_text_field.dart';
import 'package:healthpedia_frontend/core/widgets/premium_inputs/premium_country_field.dart';
import 'package:healthpedia_frontend/core/widgets/premium_inputs/premium_pin_field.dart';
import 'package:healthpedia_frontend/core/widgets/premium_inputs/premium_field_group.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'package:healthpedia_frontend/core/constants/app_spacing.dart';
import 'package:healthpedia_frontend/core/constants/app_typography.dart';

void showConnectAbhaSheet(BuildContext context, VoidCallback onConnected) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => ConnectAbhaBottomSheet(onConnected: onConnected),
  );
}

enum ConnectAbhaStep { input, otp }

class ConnectAbhaBottomSheet extends StatefulWidget {
  final VoidCallback onConnected;
  const ConnectAbhaBottomSheet({super.key, required this.onConnected});

  @override
  State<ConnectAbhaBottomSheet> createState() => _ConnectAbhaBottomSheetState();
}

class _ConnectAbhaBottomSheetState extends State<ConnectAbhaBottomSheet> {
  ConnectAbhaStep _currentStep = ConnectAbhaStep.input;
  final _mobileController = TextEditingController(text: '9039443124');
  final _idController = TextEditingController(text: '91-4829-6371-8294');
  String _currentOTP = '';

  @override
  void dispose() {
    _mobileController.dispose();
    _idController.dispose();
    super.dispose();
  }

  void _onSendOTP() {
    HapticFeedback.mediumImpact();
    setState(() => _currentStep = ConnectAbhaStep.otp);
  }

  void _onVerify() async {
    HapticFeedback.mediumImpact();
    Navigator.pop(context);
    widget.onConnected();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.space24,
        left: 20,
        right: 20,
        top: 8,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.neutral200,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 20),
          _buildHeader(),
          const SizedBox(height: 32),
          _currentStep == ConnectAbhaStep.input ? _buildInputStep() : _buildOTPStep(),
          const SizedBox(height: 32),
          _buildPrimaryButton(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    bool isInput = _currentStep == ConnectAbhaStep.input;
    return Stack(
      alignment: Alignment.center,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: GestureDetector(
            onTap: () {
              if (isInput) Navigator.pop(context);
              else setState(() => _currentStep = ConnectAbhaStep.input);
            },
            child: Text(
              isInput ? 'Cancel' : 'Back',
              style: AppTypography.label1.copyWith(color: AppColors.blue600),
            ),
          ),
        ),
        Text(
          'Connect ABHA ID',
          style: AppTypography.h6.copyWith(
            color: AppColors.neutral950,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (!isInput)
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'Resend',
              style: AppTypography.label1.copyWith(color: AppColors.blue600),
            ),
          ),
      ],
    );
  }

  Widget _buildInputStep() {
    return PremiumFieldGroup(
      children: [
        PremiumCountryField(
          controller: _mobileController,
          label: 'Mobile Number',
          onCountryChanged: (code) {
            // Handle country change if needed
          },
        ),
        PremiumTextField(
          controller: _idController,
          label: 'ABHA ID',
          placeholder: 'e.g. 91-4829-6371-8294',
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }

  Widget _buildOTPStep() {
    return Column(
      children: [
        Text(
          'Enter the 4-digit code sent to\n+91 ${_mobileController.text}',
          textAlign: TextAlign.center,
          style: AppTypography.body2.copyWith(color: AppColors.neutral500),
        ),
        const SizedBox(height: 24),
        PremiumPINField(
          length: 4,
          autofocus: true,
          onChanged: (val) {
            setState(() => _currentOTP = val);
          },
          onCompleted: (val) {
            _onVerify();
          },
        ),
      ],
    );
  }

  Widget _buildPrimaryButton() {
    bool isInput = _currentStep == ConnectAbhaStep.input;
    bool allOTP = _currentOTP.length == 4;
    
    return ElevatedButton(
      onPressed: isInput ? _onSendOTP : (allOTP ? _onVerify : null),
      style: ElevatedButton.styleFrom(
        backgroundColor: !isInput && allOTP ? AppColors.green600 : AppColors.neutral950,
        minimumSize: const Size(double.infinity, 56),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 0,
      ),
      child: Text(
        isInput ? 'Send OTP' : 'Verify',
        style: AppTypography.label1.copyWith(color: AppColors.white),
      ),
    );
  }
}
