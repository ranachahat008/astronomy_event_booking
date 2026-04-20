import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    _navigate();
    super.initState();
  }

  Future<void> _navigate() async {
    await Future.delayed(Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.nights_stay_rounded,
              color: Colors.white,
              size: 72,
            ),
            const SizedBox(height: 16),
            Text(
              "AstroBook",
              style: GoogleFonts.outfit(
                fontSize: 32,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                letterSpacing: -1,
              ),
            ),
            const SizedBox(height: 8),
            Text("Explore the Universe",
            style: GoogleFonts.outfit(
              fontSize: 14,
              color: Colors.white60
            ),)
          ],
        ),
      ),
    );
  }
}
