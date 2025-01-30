import 'dart:async';
import 'package:flutter/material.dart';

class EmailVerificationDialog extends StatefulWidget {
  final Function() onResend;

  const EmailVerificationDialog({super.key, required this.onResend});

  @override
  _EmailVerificationDialogState createState() =>
      _EmailVerificationDialogState();
}

class _EmailVerificationDialogState extends State<EmailVerificationDialog> {
  int _secondsRemaining = 60;
  bool _isResendDisabled = true;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    startCooldown();
  }

  void startCooldown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        setState(() {
          _isResendDisabled = false;
          _timer?.cancel();
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFF3E2C5D),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: const DecorationImage(
                image: AssetImage("assets/images/bg_image.png"), 
                fit: BoxFit.cover,
              ),
            ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Verify Your Email",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius: 5,
                      color: Colors.purpleAccent.withOpacity(0.6),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
        
              if (_isResendDisabled)
                Text(
                  "You can resend in $_secondsRemaining seconds",
                  style: const TextStyle(color: Colors.redAccent, fontSize: 14),
                ),
              const SizedBox(height: 20),
        
              GestureDetector(
                onTap: _isResendDisabled
                    ? null
                    : () {
                        widget.onResend();
                        setState(() {
                          _secondsRemaining = 60;
                          _isResendDisabled = true;
                        });
                        startCooldown();
                      },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: _isResendDisabled
                        ? LinearGradient(colors: [
                            Colors.grey.shade400,
                            Colors.grey.shade500,
                          ])
                        : const LinearGradient(colors: [
                            Color(0xFFFF416C),
                            Color(0xFFFF4B2B),
                          ]),
                    boxShadow: _isResendDisabled
                        ? []
                        : [
                            BoxShadow(
                              color: Colors.pinkAccent.withOpacity(0.4),
                              blurRadius: 8,
                              spreadRadius: 1,
                              offset: const Offset(0, 3),
                            ),
                          ],
                  ),
                  child: Text(
                    "Resend",
                    style: TextStyle(
                      color: _isResendDisabled ? Colors.grey.shade800 : Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
