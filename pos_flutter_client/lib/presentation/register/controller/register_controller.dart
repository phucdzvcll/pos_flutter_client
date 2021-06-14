import 'package:easy_localization/easy_localization.dart' as easyLocalization;
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:pos_flutter_client/common/common.dart';
import 'package:pos_flutter_client/generated/locale_keys.g.dart';
import 'package:pos_flutter_client/presentation/home/controller/authentication_controller.dart';
import 'package:pos_flutter_client/presentation/home/home_state.dart';

import 'register_state.dart';

class RegisterController extends GetxController {
  var warningEmailRx = Rx<WarningEmailState>(WarningEmailState(isEmail: true));
  var warningPasswordRx =
      Rx<WarningPasswordState>(WarningPasswordState(isPassword: true));
  final authenticationController = Get.find<AuthenticationController>();
  var obscureTextRx =
      Rx<ObscureTextState>(ObscureTextState(isObscureText: true));
  var errorMessageRx =
      Rx<ErrorMessageState>(ErrorMessageState(errorMessage: ""));

  void changeObscureText() {
    bool newObscureTextRx = !obscureTextRx.value.isObscureText;
    obscureTextRx.value = ObscureTextState(isObscureText: newObscureTextRx);
  }

  void warningEmail(String value) {
    var isEmail = EmailValidator.validate(value);
    warningEmailRx.value = WarningEmailState(isEmail: isEmail);
  }

  void warningPassword(String value) {
    var isPassword = value.length >= 6;
    warningPasswordRx.value = WarningPasswordState(isPassword: isPassword);
  }

  Future register(String email, String password) async {
    try {
      var userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        authenticationController.authenticationRx.value =
            LoginState(email: userCredential.user!.email.defaultEmpty());
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        errorMessageRx.value = ErrorMessageState(
            errorMessage: easyLocalization.tr(LocaleKeys.password_weak));
      } else if (e.code == 'email-already-in-use') {
        errorMessageRx.value = ErrorMessageState(
            errorMessage: easyLocalization.tr(LocaleKeys.email_already_in_use));
      }
    } catch (e) {
      print(e);
    }
  }
}
