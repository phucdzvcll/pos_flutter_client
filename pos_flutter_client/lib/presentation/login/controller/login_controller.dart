import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:pos_flutter_client/presentation/register/controller/register_state.dart';

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
      return await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
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
