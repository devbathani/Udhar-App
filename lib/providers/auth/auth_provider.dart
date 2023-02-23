import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:udhar_app/core/firebase_core.dart';
import 'package:udhar_app/core/prefs.dart';
import 'package:udhar_app/domain/auth/imp_auth_repo.dart';
import 'package:udhar_app/domain/auth/user_list_entity.dart';
import 'package:udhar_app/injection/injection.dart';
import 'package:udhar_app/routing/router.gr.dart';
import 'package:udhar_app/utils/logger.dart';

enum OtpVerificationState { unverified, checking, success, failure }

enum AuthButtonState { active, deactive }

enum OtpState { unsend, sent, sending }

@injectable
class AuthProvider extends ChangeNotifier {
  ImpAuthRepository repo;

  AuthProvider(this.repo);

  //Enums
  OtpVerificationState otpVerificationState = OtpVerificationState.unverified;
  AuthButtonState authButtonState = AuthButtonState.deactive;
  OtpState otpState = OtpState.unsend;

  //Controllers 
  final phoneNumberController = TextEditingController();
  final otpController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final upiIdController = TextEditingController();

  String verificationId = '';
  String uid = '';
  String? fcmToken = '';

  UserListEntity? userListEntity;

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

  Future<void> sendOtp(BuildContext context) async {
    otpState = OtpState.sending;
    notifyListeners();
    await FirebaseClient.firebaseAuth.verifyPhoneNumber(
      phoneNumber: "+91${phoneNumberController.text}",
      verificationCompleted: (PhoneAuthCredential credential) {
        logger.wtf("Verification Completed : ${credential.providerId}");
        notifyListeners();
      },
      verificationFailed: (FirebaseAuthException e) {
        logger.e(e);
        otpVerificationState = OtpVerificationState.failure;
        notifyListeners();
      },
      codeSent: (String verificationId, int? resendToken) {
        logger.i("OTP Sent");
        this.verificationId = verificationId;
        otpState = OtpState.sent;
        if (otpState == OtpState.sent) {
          AutoRouter.of(context).push(
            const EnterOtpScreen(),
          );
        }
        notifyListeners();
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        logger.i("Timeout");
      },
    );
    notifyListeners();
  }

  Future<void> verifyLoginOtp(BuildContext context) async {
    otpVerificationState = OtpVerificationState.checking;
    notifyListeners();
    await FirebaseClient.firebaseAuth
        .signInWithCredential(
      PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otpController.text,
      ),
    )
        .whenComplete(() async {
      logger.i("Otp Verified");
      final User user = FirebaseClient.firebaseAuth.currentUser!;
      uid = user.uid;
      getIt<AppPrefs>().uid.setValue(uid);
      otpVerificationState = OtpVerificationState.success;
      AutoRouter.of(context).pushAndPopUntil(
        const HomeScreen(),
        predicate: (route) => false,
      );
      notifyListeners();
    });
  }

  Future<void> verifyRegistrationOtp(BuildContext context) async {
    otpVerificationState = OtpVerificationState.checking;
    notifyListeners();
    await FirebaseClient.firebaseAuth
        .signInWithCredential(
      PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otpController.text,
      ),
    )
        .whenComplete(() async {
      logger.i("Otp Verified");
      fcmToken = await FirebaseClient.firebaseMessaging.getToken();
      getIt<AppPrefs>().fcmToken.setValue(fcmToken!);
      logger.wtf("FCMToken : ${getIt<AppPrefs>().fcmToken.getValue()}");
      userListEntity = UserListEntity(
        name: nameController.text,
        phoneNumber: phoneNumberController.text,
        email: emailController.text,
        upiId: upiIdController.text,
        fcmToken: fcmToken!,
      );
      await repo.registerUser(userListEntity: userListEntity!);
      final User user = FirebaseClient.firebaseAuth.currentUser!;
      uid = user.uid;
      getIt<AppPrefs>().uid.setValue(uid);
      getIt<AppPrefs>().name.setValue(nameController.text);
      getIt<AppPrefs>().phoneNumber.setValue(phoneNumberController.text);
      getIt<AppPrefs>().email.setValue(emailController.text);
      getIt<AppPrefs>().upiId.setValue(upiIdController.text);
      logger.wtf("UID : ${getIt<AppPrefs>().uid.getValue()}");
      otpVerificationState = OtpVerificationState.success;
      AutoRouter.of(context).pushAndPopUntil(
        const HomeScreen(),
        predicate: (route) => false,
      );
      notifyListeners();
    });
  }
}
