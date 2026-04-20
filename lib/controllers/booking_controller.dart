import 'package:astronomy_event_booking/models/booking_model.dart';
import 'package:get/get.dart';

class BookingController extends GetxController {
  var bookings = <BookingModel>[].obs;

  void addBookings(String eventId, String eventName, int seats) {

    //check for already Booked Seats

    // final alreadyBooked = bookings.firstWhereOrNull(
    //   (b) => b.eventId == eventId,
    // );
    // if (alreadyBooked != null) {
    //   Get.snackbar("Already Booked", "You have already book this event");
    //   return;
    // }

    bookings.add(
      BookingModel(eventId: eventId, eventName: eventName, seats: seats),
    );
  }
}
