import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:refresh_get_user/src/services/model/phone_auth_listener.dart';
import 'package:refresh_get_user/src/services/model/user_model.dart';
import 'package:refresh_get_user/src/services/user/user.dart';

class FirebasePhoneAuth {
  PhoneAuthListener phoneAuthListener;
  BuildContext context;

  ///--------( CONSTRUCTOR INITIALISATION )---------
  FirebasePhoneAuth(this.context, this.phoneAuthListener);

  void startPhoneAuth(String phoneNumber, int? resendToken) {
    print('---------$phoneNumber');
    assert(phoneNumber != null);
    print('Phone auth started');
    FirebaseAuth.instance.setSettings(
        // appVerificationDisabledForTesting: false,
        // forceRecaptchaFlow: true,
        );
    FirebaseAuth.instance
        .verifyPhoneNumber(
            phoneNumber: phoneNumber.toString(),
            timeout: const Duration(seconds: 60),
            verificationCompleted: (PhoneAuthCredential auth) {
              phoneAuthListener.onVerificationCompleted(auth.smsCode);
              /*
              FirebaseAuth.instance
                  .signInWithCredential(auth)
                  .then((UserCredential result) async {
                if (result.user != null) {
                  print(
                      'result of new user in verify is ${result.additionalUserInfo!.isNewUser}');

                  phoneAuthListener.onAuthenticationSuccess(result.user);
                } else {
                  phoneAuthListener.onAuthenticationFail();
                }
              }).catchError((error) {
                phoneAuthListener.onAuthenticationFail();
              }); */
            },
            verificationFailed: (FirebaseAuthException authException) {
              phoneAuthListener.onVerificationFailed(authException);
              print('${authException.message}');
            },
            codeSent: (String verificationId, int? resendToken) async {
              phoneAuthListener.onCodeSent(verificationId, resendToken);
            },
            codeAutoRetrievalTimeout: (String verificationId) {
              phoneAuthListener.onCodeAutoRetrievalTimeout(verificationId);
            },
            forceResendingToken: resendToken)
        .then((value) {
      print('Code sent');
    }).catchError((error) {
      print(error.toString());
      phoneAuthListener.onVerificationFailed(error);
    });
  }

  void signInWithPhoneNumber(
      String smsCode, String verificationId, UserModel userModel) async {
    var _authCredential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);
    FirebaseAuth.instance
        .signInWithCredential(_authCredential)
        .then((UserCredential result) async {
      result.user!.uid;

      print(
          'result of new user signin is ${result.additionalUserInfo!.isNewUser}');
      if (result.additionalUserInfo!.isNewUser) {
        userModel.uuid = result.user!.uid;
        await UserService.instance.addUserInformation(userModel);
      }

      await phoneAuthListener.onAuthenticationSuccess(result.user);
    }).catchError((error) {
      phoneAuthListener.onAuthenticationFail(error);
    });
  }
}
