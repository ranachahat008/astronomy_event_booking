import 'dart:async';

import 'package:astronomy_event_booking/views/auth/login_screen.dart';
import 'package:astronomy_event_booking/views/dashboard/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  var user = Rxn<User>();
  StreamSubscription? _authSub;

  @override
  void onInit() {
    _authSub = FirebaseAuth.instance.authStateChanges().listen((firebaseUser) {
      user.value = firebaseUser;
      _handleAuthChanged(firebaseUser);
    });
    super.onInit();
  }

  @override
  void onClose() {
    _authSub?.cancel();
    super.onClose();
  }

  void _handleAuthChanged(User? firebaseUser) {
   WidgetsBinding.instance.addPostFrameCallback((_){
     if (firebaseUser == null) {
       Get.offAll(() => LoginScreen());
     } else {
       Get.offAll(() =>DashboardScreen());
     }
   });
  }

  Future<void> login(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", e.code);
    }
  }

  Future<void> signup(String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", e.code);
    }
  }

  void logout() {
    FirebaseAuth.instance.signOut();
  }

}
