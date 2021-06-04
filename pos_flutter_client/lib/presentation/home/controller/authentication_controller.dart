import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:pos_flutter_client/common/common.dart';
import 'package:pos_flutter_client/presentation/home/home_state.dart';

class AuthenticationController extends GetxController {
  var authenticationRx = Rx<AuthenticationState>(LoadingState());
  final FirebaseAuth _auth = FirebaseAuth.instance;
  void getAuthenticationState() {
    if (_auth.currentUser != null) {
      authenticationRx.value =
          LoginState(email: _auth.currentUser!.email.defaultEmpty());
    } else {
      authenticationRx.value = LogoutState();
    }
  }
}
