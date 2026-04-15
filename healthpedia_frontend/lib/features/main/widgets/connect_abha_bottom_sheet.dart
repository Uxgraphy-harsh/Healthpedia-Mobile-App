import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final List<TextEditingController> _otpControllers = List.generate(5, (_) => TextEditingController());
  final List<FocusNode> _otpFocusNodes = List.generate(5, (_) => FocusNode());

  @override
  void dispose() {
    _mobileController.dispose();
    _idController.dispose();
    for (var c in _otpControllers) {
      c.dispose();
    }
    for (var f in _otpFocusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _onSendOTP() {
    HapticFeedback.mediumImpact();
    setState(() => _currentStep = ConnectAbhaStep.otp);
    Future.delayed(const Duration(milliseconds: 300), () => _otpFocusNodes[0].requestFocus());
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
        left: 16,
        right: 16,
        top: 8,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40, height: 4,
            decoration: BoxDecoration(color: AppColors.neutral200, borderRadius: BorderRadius.circular(2)),
          ),
          const SizedBox(height: 16),
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
            child: Text(isInput ? 'Cancel' : 'Back', style: AppTypography.label1.copyWith(color: AppColors.blue600)),
          ),
        ),
        Text('Connect ABHA ID', style: AppTypography.h6.copyWith(color: AppColors.neutral950, fontWeight: FontWeight.w600)),
        if (!isInput)
          Align(
            alignment: Alignment.centerRight,
            child: Text('Resend code', style: AppTypography.label1.copyWith(color: AppColors.blue600)),
          ),
      ],
    );
  }

  Widget _buildInputStep() {
    return Column(
      children: [
        TextField(
          controller: _mobileController,
          decoration: InputDecoration(
            labelText: 'Mobile',
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 12, right: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/Figma MCP Assets/CommonAssets/Icons/India Flag.png', width: 20),
                  const SizedBox(width: 4),
                  Text('+91', style: AppTypography.label1.copyWith(color: AppColors.neutral950)),
                ],
              ),
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.neutral200)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.neutral200)),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _idController,
          decoration: InputDecoration(
            labelText: 'ABHA ID',
            hintText: '00-0000-0000-0000',
            floatingLabelBehavior: FloatingLabelBehavior.always,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.neutral200)),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.neutral200)),
          ),
        ),
      ],
    );
  }

  Widget _buildOTPStep() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(5, (index) => Container(
        width: 60, height: 60,
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(color: AppColors.green600.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: TextField(
            controller: _otpControllers[index],
            focusNode: _otpFocusNodes[index],
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            onChanged: (val) {
              if (val.isNotEmpty && index < 4) _otpFocusNodes[index + 1].requestFocus();
              if (val.isEmpty && index > 0) _otpFocusNodes[index - 1].requestFocus();
              setState(() {});
            },
            style: AppTypography.h3.copyWith(color: AppColors.neutral950, fontWeight: FontWeight.w400),
            decoration: const InputDecoration(border: InputBorder.none, counterText: ''),
          ),
        ),
      )),
    );
  }

  Widget _buildPrimaryButton() {
    bool isInput = _currentStep == ConnectAbhaStep.input;
    bool allOTP = _otpControllers.every((c) => c.text.isNotEmpty);
    
    return ElevatedButton(
      onPressed: isInput ? _onSendOTP : (allOTP ? _onVerify : null),
      style: ElevatedButton.styleFrom(
        backgroundColor: !isInput && allOTP ? AppColors.green600 : AppColors.neutral950,
        minimumSize: const Size(double.infinity, 56),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(99)),
        elevation: 0,
      ),
      child: !isInput && allOTP 
          ? const Icon(Icons.check, color: AppColors.white)
          : Text(isInput ? 'Send OTP' : 'Verify', style: AppTypography.label1.copyWith(color: AppColors.white)),
    );
  }
}
