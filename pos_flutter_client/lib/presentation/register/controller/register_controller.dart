import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'register_state.dart';

class RegisterController extends GetxController {
  // final authenticationController = Get.find<AuthenticationController>();
  var obscureTextRx =
      Rx<ObscureTextState>(ObscureTextState(isObscureText: true));
  var errorMessageRx =
      Rx<ErrorMessageState>(ErrorMessageState(errorMessage: ""));

  void changeObscureText() {
    bool newObscureTextRx = !obscureTextRx.value.isObscureText;
    obscureTextRx.value = ObscureTextState(isObscureText: newObscureTextRx);
  }

  Future register(String email, String password) async {
    try {
      var userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      // if (userCredential.user != null) {
      //   authenticationController.authenticationRx.value =
      //       LoginState(email: userCredential.user!.email.defaultEmpty());
      // }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        errorMessageRx.value = ErrorMessageState(
            errorMessage: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        errorMessageRx.value = ErrorMessageState(
            errorMessage: 'The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}
