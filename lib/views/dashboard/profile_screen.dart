import 'dart:ffi' hide Size;

import 'package:astronomy_event_booking/controllers/auth_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Size;
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.green.shade50,
              radius: 50,
              child: Icon(
                CupertinoIcons.person,
                size: 38,
                color: Color(0xFF2D6A4F),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "${authController.user.value?.email}",
              style: GoogleFonts.outfit(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.all(38.0),
              child: ElevatedButton(
                onPressed: () {
                  authController.logout();
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity,64),
                  backgroundColor: Color(0xFF2D6A4F),
                  foregroundColor: Colors.white,
                  elevation: 8,
                  shadowColor: Color(0xFF2D6A4F).withOpacity(0.4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24)
                  )
                ),
                child: Text("LogOut"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
