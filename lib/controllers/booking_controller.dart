import 'dart:async';

import 'package:astronomy_event_booking/models/booking_model.dart';
import 'package:astronomy_event_booking/models/event_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'event_controller.dart';

class BookingController extends GetxController {
  var bookings = <BookingModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _authSub =_auth.authStateChanges().listen((user){
      if(user != null) {
        fetchBooking();
      } else {
        bookings.clear();
      }
    });
  }

  @override
  void onClose() {
    _authSub?.cancel();
    super.onClose();
  }

  final eventController = Get.find<EventController>();
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  StreamSubscription? _authSub;

  String get _userId => _auth.currentUser!.uid;

  Future<void> fetchBooking() async {
    if(_userId == null) return;
    try {
      isLoading(true);
      final snapshot = await _firestore
          .collection('bookings')
          .where('userId', isEqualTo: _userId)
          .get();
      bookings.value = snapshot.docs
          .map((doc) => BookingModel.fromJson(doc.id, doc.data()))
          .toList();
    } catch (e) {
      Get.snackbar('error', 'Failed to load Bookings');
    } finally {
      isLoading(false);
    }
  }

  int bookedSeatsForEvent(String eventId) {
    final alreadyBooked = bookings.firstWhereOrNull(
      (b) => b.eventId == eventId,
    );
    return alreadyBooked?.seats ?? 0;
  }

  Future<void> addBookings(
    String eventId,
    String eventName,
    int newSeats,
  ) async {
    final eventDoc = await _firestore.collection('events').doc(eventId).get();
    final currentAvailableSeats = eventDoc.data()!['availableSeats'] as int;

    if(_userId == null) return;
    if (newSeats > currentAvailableSeats) {
      Get.snackbar(
        "Not Enough Seats",
        "only $currentAvailableSeats are available",
      );
      return;
    }

    final alreadyBooked = bookings.firstWhereOrNull(
      (b) => b.eventId == eventId,
    );

    //check for already Booked Seats
    if (alreadyBooked != null) {
      //to add more seats or to update the existing booking
      final updatedSeats = alreadyBooked.seats + newSeats;
      await _firestore.collection('bookings').doc(alreadyBooked.id).update({
        'seats': updatedSeats,
      });

      //this is to update deducted seats from firebase
      await _firestore.collection('events').doc(eventId).update({
        'availableSeats': FieldValue.increment(-newSeats),
      });

      // this is to update deducted seats from local list
      final index = bookings.indexOf(alreadyBooked);
      bookings[index] = BookingModel(
        id: alreadyBooked.id,
        eventId: alreadyBooked.eventId,
        eventName: alreadyBooked.eventName,
        seats: updatedSeats,
        userId: alreadyBooked.userId,
      );

      _updateLocalEventSeats(eventId, newSeats);
    } else {
      // this is for the new bookings
      try {
        isLoading(true);
        final booking = BookingModel(
          eventId: eventId,
          eventName: eventName,
          seats: newSeats,
          userId: _userId!,
          id: '',
        );

        final docRef = await _firestore
            .collection('bookings')
            .add(booking.toMap());
        bookings.add(
          BookingModel(
            id: docRef.id,
            eventId: eventId,
            eventName: eventName,
            seats: newSeats,
            userId: _userId,
          ),
        );

        // this is for update the no  of seats in firestore
        await _firestore.collection('events').doc(eventId).update({
          'availableSeats': FieldValue.increment(-newSeats),
        });

        // this is for update the no  of seats in local list
        _updateLocalEventSeats(eventId, newSeats);
      } catch (e) {
        Get.snackbar('error', 'Booking Failed. Try again');
      } finally {
        isLoading(false);
      }
    }
  }

  void _updateLocalEventSeats(String eventId, int deductedSeats){
    final eventIndex = eventController.events.indexWhere(
          (e) => e.id == eventId,
    );
    if (eventIndex != -1) {
      final e = eventController.events[eventIndex];
      eventController.events[eventIndex] = EventModel(
        id: e.id,
        name: e.name,
        description: e.description,
        date: e.date,
        location: e.location,
        availableSeats: e.availableSeats - deductedSeats,
        imageUrl: e.imageUrl,
        totalSeats: e.totalSeats,
      );
      eventController.events.refresh();
    }
  }

  bool isFullyBooked(String eventId) {
    final event = eventController.events.firstWhereOrNull(
      (b) => b.id == eventId,
    );
    return event?.availableSeats == 0;
  }
}
