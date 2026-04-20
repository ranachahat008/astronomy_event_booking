import 'package:astronomy_event_booking/controllers/booking_controller.dart';
import 'package:astronomy_event_booking/models/event_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class EventDetails extends StatelessWidget {
  final EventModel event;

  EventDetails({super.key, required this.event});

  final bookingController = Get.find<BookingController>();
  final seatsController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 48.0, left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(CupertinoIcons.back),
                ),
                SizedBox(width: 5),
                Text(
                  event.name,
                  style: GoogleFonts.outfit(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.network(
                event.imageUrl,
                width: double.infinity,
                height: Get.width / 2,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 25),
            Text(
              "About this event :",
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "' ${event.description} '",
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: Colors.black45,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 15,
              children: [
                _infoChip(CupertinoIcons.calendar, event.date),
                _infoChip(CupertinoIcons.location, event.location),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF2D6A4F).withOpacity(0.08),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.event_seat_outlined,
                    color: Color(0xFF2D6A4F),
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "${event.availableSeats} seats available",
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF2D6A4F),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Form(
              key: _formKey,
              child: TextFormField(
                controller: seatsController,
                keyboardType: TextInputType.number,
                maxLines: 1,
                style: GoogleFonts.outfit(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Enter number of seats';
                  }
                  final seats = int.tryParse(val);
                  if (seats == null || seats <= 0) {
                    return 'Enter a valid number';
                  }
                  if (seats > event.availableSeats) {
                    return 'Only ${event.availableSeats} seats available';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  prefixIcon: Container(
                    margin: const EdgeInsets.all(12),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.03),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.event_seat_outlined,
                      size: 18,
                      color: Color(0xFF2D6A4F),
                    ),
                  ),
                  labelText: "No of seats",
                  labelStyle: GoogleFonts.outfit(
                    color: Color(0xFF2D6A4F),
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                  ),
                  hintText: 'e.g. 2',
                  hintStyle: GoogleFonts.outfit(
                    color: Color(0xFF2D6A4F),
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Colors.grey.shade100,
                      width: 1,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Colors.grey.shade100,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Color(0xFF2D6A4F).withOpacity(0.7),
                      width: 2,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      color: Colors.red.shade100,
                      width: 1,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Obx(() => ElevatedButton(
              onPressed: bookingController.isBooked(event.id)
                  ? null
                  : () {
                if (_formKey.currentState!.validate()) {
                  bookingController.addBookings(
                    event.id,
                    event.name,
                    int.parse(seatsController.text.trim()),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 60),
                backgroundColor: const Color(0xFF2D6A4F),
                disabledBackgroundColor: Colors.grey.shade200,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 4,
              ),
              child: Text(
                bookingController.isBooked(event.id)
                    ? "Already Booked"
                    : "Book Now",
              ),
            ),)
          ],
        ),
      ),
    );
  }

  Widget _infoChip(IconData icon, String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: Colors.grey.shade600),
          const SizedBox(width: 6),
          Text(
            label,
            style: GoogleFonts.outfit(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}
