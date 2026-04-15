import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'package:healthpedia_frontend/core/constants/app_spacing.dart';
import 'package:healthpedia_frontend/core/constants/app_typography.dart';

void showEditEmailSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => const EditEmailBottomSheet(),
  );
}

enum EditEmailStep { emailInput, otpInput }
enum OTPStatus { none, data, error, success }

class EditEmailBottomSheet extends StatefulWidget {
  const EditEmailBottomSheet({super.key});

  @override
  State<EditEmailBottomSheet> createState() => _EditEmailBottomSheetState();
}

class _EditEmailBottomSheetState extends State<EditEmailBottomSheet> {
  EditEmailStep _currentStep = EditEmailStep.emailInput;
  OTPStatus _otpStatus = OTPStatus.none;
  
  final TextEditingController _emailController = TextEditingController(text: 'harsh@uxgraphy.com');
  final List<TextEditingController> _otpControllers = List.generate(5, (_) => TextEditingController());
  final List<FocusNode> _otpFocusNodes = List.generate(5, (_) => FocusNode());
  
  Timer? _timer;
  int _secondsRemaining = 49;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 5; i++) {
        _otpControllers[i].addListener(() {
            _handleOTPChange(i);
        });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    for (var c in _otpControllers) {
      c.dispose();
    }
    for (var f in _otpFocusNodes) {
      f.dispose();
    }
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

  void _handleOTPChange(int index) {
    String value = _otpControllers[index].text;
    
    // Auto-focus next field
    if (value.isNotEmpty && index < 4) {
      _otpFocusNodes[index + 1].requestFocus();
    }
    
    // Check if fully filled
    bool allFilled = _otpControllers.every((c) => c.text.isNotEmpty);
    setState(() {
        if (allFilled) {
            _otpStatus = OTPStatus.data;
        } else {
            _otpStatus = OTPStatus.none;
        }
    });
  }

  void _onVerify() async {
    HapticFeedback.mediumImpact();
    
    // Simulation: Mock "12345" as correct, anything else as error
    String otp = _otpControllers.map((c) => c.text).join();
    
    if (otp == '16889') { // Based on screenshot example
      setState(() => _otpStatus = OTPStatus.success);
      await Future.delayed(const Duration(milliseconds: 1500));
      if (mounted) Navigator.pop(context);
    } else {
      setState(() => _otpStatus = OTPStatus.error);
    }
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
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8),
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.neutral200,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),
          _buildHeader(),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _currentStep == EditEmailStep.emailInput 
                ? _buildEmailInputStep() 
                : _buildOTPInputStep(),
          ),
          const SizedBox(height: 24),
          _buildPrimaryButton(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    String title = _currentStep == EditEmailStep.emailInput ? 'Edit email' : 'Edit email';
    String leftLabel = _currentStep == EditEmailStep.emailInput ? 'Cancel' : 'Back';
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              if (_currentStep == EditEmailStep.otpInput) {
                setState(() => _currentStep = EditEmailStep.emailInput);
              } else {
                Navigator.pop(context);
              }
            },
            child: Text(
              leftLabel,
              style: AppTypography.label1.copyWith(
                color: AppColors.blue600,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Text(
            title,
            style: AppTypography.h6.copyWith(
              color: AppColors.neutral950,
              fontWeight: FontWeight.w600,
            ),
          ),
          if (_currentStep == EditEmailStep.otpInput)
            GestureDetector(
              onTap: _canResend ? _startTimer : null,
              child: Text(
                _canResend ? 'Resend code' : 'Resend (${_secondsRemaining} sec)',
                style: AppTypography.label1.copyWith(
                  color: AppColors.blue600,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
            )
          else
            const SizedBox(width: 40), // Placeholder to center title
        ],
      ),
    );
  }

  Widget _buildEmailInputStep() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Text(
              'Email',
              style: AppTypography.label1.copyWith(
                color: AppColors.neutral950,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextField(
                controller: _emailController,
                textAlign: TextAlign.right,
                style: AppTypography.label1.copyWith(
                  color: AppColors.neutral950,
                  fontWeight: FontWeight.w400,
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
                cursorColor: AppColors.neutral950,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOTPInputStep() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(5, (index) => _buildOTPSingleField(index)),
        ),
        if (_otpStatus == OTPStatus.error)
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Text(
              'You have entered an incorrect code.',
              style: AppTypography.label2.copyWith(color: AppColors.red600),
            ),
          ),
      ],
    );
  }

  Widget _buildOTPSingleField(int index) {
    Color borderColor;
    if (_otpStatus == OTPStatus.error) {
      borderColor = AppColors.red600;
    } else if (_otpStatus == OTPStatus.success) {
      borderColor = AppColors.green600;
    } else if (_otpFocusNodes[index].hasFocus) {
        borderColor = AppColors.neutral400;
    } else {
      borderColor = AppColors.neutral200;
    }

    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: TextField(
          controller: _otpControllers[index],
          focusNode: _otpFocusNodes[index],
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          inputFormatters: [
            LengthLimitingTextInputFormatter(1),
            FilteringTextInputFormatter.digitsOnly,
          ],
          onChanged: (val) {
              if (val.isEmpty && index > 0) {
                  _otpFocusNodes[index - 1].requestFocus();
              }
              setState(() {
                  if (_otpStatus == OTPStatus.error) _otpStatus = OTPStatus.data;
              });
          },
          style: AppTypography.h3.copyWith(
            color: AppColors.neutral950,
            fontWeight: FontWeight.w400,
          ),
          decoration: const InputDecoration(
            border: InputBorder.none,
            counterText: '',
          ),
          cursorColor: AppColors.neutral950,
        ),
      ),
    );
  }

  Widget _buildPrimaryButton() {
    String label = _currentStep == EditEmailStep.emailInput ? 'Send Code' : 'Verify';
    bool isActive = _currentStep == EditEmailStep.emailInput || _otpStatus == OTPStatus.data || _otpStatus == OTPStatus.error || _otpStatus == OTPStatus.success;
    
    Color bgColor;
    if (_otpStatus == OTPStatus.success && _currentStep == EditEmailStep.otpInput) {
        bgColor = AppColors.green600;
    } else if (isActive) {
        bgColor = AppColors.neutral950;
    } else {
        bgColor = AppColors.neutral200;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ElevatedButton(
        onPressed: isActive ? () {
            if (_currentStep == EditEmailStep.emailInput) {
                setState(() => _currentStep = EditEmailStep.otpInput);
                _startTimer();
                _otpFocusNodes[0].requestFocus();
            } else {
                _onVerify();
            }
        } : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: AppColors.white,
          minimumSize: const Size(double.infinity, 56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(99),
          ),
          elevation: 0,
        ),
        child: _otpStatus == OTPStatus.success && _currentStep == EditEmailStep.otpInput
            ? const Icon(Icons.check, color: AppColors.white)
            : Text(
                label,
                style: AppTypography.label1.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
      ),
    );
  }
}
