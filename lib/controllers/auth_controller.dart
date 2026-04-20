import 'package:astronomy_event_booking/views/auth/login_screen.dart';
import 'package:astronomy_event_booking/views/dashboard/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  var user = Rxn<User>();

  @override
  void onInit() {
    user.bindStream(FirebaseAuth.instance.authStateChanges());
    ever(user, _handleAuthChanged);
    super.onInit();
  }
}

void _handleAuthChanged(User? user) {
  if (user == null) {
    Get.offAll(LoginScreen());
  } else {
    Get.offAll(DashboardScreen());
  }
}

Future<void> login(String email, String password) async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  } catch (e) {
    Get.snackbar("Error", e.toString());
  }
}

Future<void> signup(String email, String password) async {
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  } catch (e) {
    Get.snackbar("Error", e.toString());
  }
}
