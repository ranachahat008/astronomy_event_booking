import 'package:astronomy_event_booking/controllers/booking_controller.dart';
import 'package:astronomy_event_booking/controllers/event_controller.dart';
import 'package:astronomy_event_booking/models/event_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class EventDetails extends StatefulWidget {
  final EventModel event;

  const EventDetails({super.key, required this.event});

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  final bookingController = Get.find<BookingController>();

  final eventController = Get.find<EventController>();

  final seatsController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _showBookingSheet(BuildContext context) {
    final currentEvent = eventController.events.firstWhereOrNull(
          (e) => e.id == widget.event.id,
    );
    final liveAvailableSeats = currentEvent?.availableSeats ?? 0;
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Book Seats',
                style: GoogleFonts.outfit(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                widget.event.name,
                style: GoogleFonts.outfit(
                  fontSize: 14,
                  color: Colors.grey.shade500,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: seatsController,
                keyboardType: TextInputType.number,
                style: GoogleFonts.outfit(fontWeight: FontWeight.w600),
                decoration: InputDecoration(
                  labelText: 'Number of Seats',
                  hintText: 'e.g. 2',
                  prefixIcon: const Icon(
                    Icons.event_seat_outlined,
                    color: Color(0xFF2D6A4F),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      color: Color(0xFF2D6A4F),
                      width: 2,
                    ),
                  ),
                ),
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Enter number of seats';
                  }
                  final seats = int.tryParse(val);
                  if (seats == null || seats <= 0) {
                    return 'Enter a valid number';
                  }
                  if (seats > liveAvailableSeats) {
                    return 'Only $liveAvailableSeats seats available';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    bookingController.addBookings(
                      widget.event.id,
                      widget.event.name,
                      int.parse(seatsController.text.trim()),
                    );
                    Get.back();
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 56),
                  backgroundColor: const Color(0xFF2D6A4F),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  'Confirm Booking',
                  style: GoogleFonts.outfit(fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

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
                  widget.event.name,
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
                widget.event.imageUrl,
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
              "' ${widget.event.description} '",
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
                _infoChip(CupertinoIcons.calendar, widget.event.date),
                _infoChip(CupertinoIcons.location, widget.event.location),
              ],
            ),
            const SizedBox(height: 20),
            Obx(() {
              final currentEvent = eventController.events.firstWhereOrNull(
                (e) => e.id == widget.event.id,
              );
              final liveSeats = currentEvent?.availableSeats ?? widget.event.availableSeats;
              return Container(
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
                      "$liveSeats seats available",
                      style: GoogleFonts.outfit(
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF2D6A4F),
                      ),
                    ),
                  ],
                ),
              );
            }),
            SizedBox(height: 30),
            Obx(() {
              final event = eventController.events.firstWhereOrNull(
                (e) => e.id == widget.event.id,
              );

              final availableSeats = event?.availableSeats ?? 0;
              final alreadyBookedSeats = bookingController.bookedSeatsForEvent(
                widget.event.id,
              );

              return Column(
                children: [
                  if (alreadyBookedSeats > 0)
                    Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: Colors.blue.shade700,
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'You have booked $alreadyBookedSeats seat(s). You can book more.',
                            style: GoogleFonts.outfit(
                              color: Colors.blue.shade700,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ElevatedButton(
                    onPressed: availableSeats == 0
                        ? null
                        : () => _showBookingSheet(context),
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
                      availableSeats == 0
                          ? "Sold Out"
                          : alreadyBookedSeats > 0
                          ? "Book More Seats"
                          : "Book Now",
                    ),
                  ),
                ],
              );
            }),
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
