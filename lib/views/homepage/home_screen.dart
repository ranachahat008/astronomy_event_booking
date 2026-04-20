import 'dart:ffi';

import 'package:astronomy_event_booking/controllers/event_controller.dart';
import 'package:astronomy_event_booking/views/homepage/event_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final eventController = Get.find<EventController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F5),
      body: Padding(
        padding: const EdgeInsets.only(top: 48.0, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "ASTROBOOK",
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                  letterSpacing: 1.5,
                  color: Color(0xFF2D6A4F),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Astronomy Events',
              style: GoogleFonts.outfit(
                fontSize: 26,
                fontWeight: FontWeight.w700,
                letterSpacing: -1,
              ),
            ),
            Text(
              'Book your spot under the stars',
              style: GoogleFonts.outfit(
                fontSize: 16,
                color: Colors.grey.shade500,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (_,_) => const SizedBox(height: 16),
                itemCount: eventController.events.length,
                itemBuilder: (context,index) {
                  return EventCard(event: eventController.events[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
