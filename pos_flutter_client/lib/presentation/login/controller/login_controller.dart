import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'login_state.dart';

class LoginController extends GetxController {
  var obscureTextRx =
      Rx<ObscureTextState>(ObscureTextState(isObscureText: true));
  var errorMessageRx =
      Rx<ErrorMessageState>(ErrorMessageState(errorMessage: ""));

  void changeObscureText() {
    bool newObscureTextRx = !obscureTextRx.value.isObscureText;
    obscureTextRx.value = ObscureTextState(isObscureText: newObscureTextRx);
  }

  Future login(String email, String password) async {
    try {
      var userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      // if (userCredential.user != null) {
      //   authenticationController.authenticationRx.value =
      //       // LoginState(email: userCredential.user!.email.defaultEmpty());
      // }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        errorMessageRx.value = ErrorMessageState(errorMessage: e.code);
      } else if (e.code == 'wrong-password') {
        errorMessageRx.value = ErrorMessageState(errorMessage: e.code);
      }
    } catch (e) {
      errorMessageRx.value = ErrorMessageState(errorMessage: e.toString());
    }
  }
}
