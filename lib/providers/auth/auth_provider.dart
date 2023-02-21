import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:udhar_app/domain/auth/imp_auth_repo.dart';
import 'package:udhar_app/utils/logger.dart';

enum OtpVerificationState { unverified, checking, success, failure }

enum AuthButtonState { active, deactive }

@injectable
class AuthProvider extends ChangeNotifier {
  ImpAuthRepository repo;

  AuthProvider(this.repo);

  //Enums
  OtpVerificationState otpVerificationState = OtpVerificationState.unverified;
  AuthButtonState authButtonState = AuthButtonState.deactive;

  //Controllers for Phone Number and OTP
  final phoneNumberController = TextEditingController();
  final otpController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final upiIdController = TextEditingController();

  //Enums setters
  setOtpStateToUnverified() {
    otpVerificationState = OtpVerificationState.unverified;
    notifyListeners();
  }

  setAuthButtonToActive() {
    authButtonState = AuthButtonState.active;
    notifyListeners();
  }

  setAuthButtonToDeactive() {
    authButtonState = AuthButtonState.deactive;
    notifyListeners();
  }

  setOtpStateToFailure() {
    otpVerificationState = OtpVerificationState.failure;
    logger.w(otpVerificationState);
    notifyListeners();
  }

  //Otp Resend Timer
  Timer? timer;
  int start = 60;
  bool isTimerStarted = true;
  void startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start == 0) {
          timer.cancel();
          isTimerStarted = false;
          start = 60;
          notifyListeners();
        } else {
          start--;
          notifyListeners();
        }
      },
    );
    notifyListeners();
  }
}
