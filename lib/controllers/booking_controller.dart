import 'package:astronomy_event_booking/models/booking_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BookingController extends GetxController {
  var bookings = <BookingModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    fetchBooking();
    super.onInit();
  }

  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  String get _userId => _auth.currentUser!.uid;

  Future<void> fetchBooking() async {
    try {
      isLoading(true);
      final snapshot = await _firestore
          .collection('bookings')
          .where('userId', isEqualTo: _userId)
          .get();
      bookings.value = snapshot.docs
          .map((doc) => BookingModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      Get.snackbar('error', 'Failed to load Bookings');
    } finally {
      isLoading(false);
    }
  }

  Future<void> addBookings(String eventId, String eventName, int seats) async {
    //check for already Booked Seats
    if (isBooked(eventId)) {
      Get.snackbar("Already Booked", "You have already book this event");
      return;
    }

    try {
      isLoading(true);
      final booking = BookingModel(
        eventId: eventId,
        eventName: eventName,
        seats: seats,
        userId: _userId,
      );

      await _firestore.collection('bookings').add(booking.toMap());
      bookings.add(booking);
    } catch (e) {
      Get.snackbar('error', 'Booking Failed. Try again');
    } finally {
      isLoading(false);
    }
  }

  bool isBooked(String eventId) {
    return bookings.any((b) => b.eventId == eventId);
  }
}
