import 'package:astronomy_event_booking/controllers/auth_controller.dart';
import 'package:astronomy_event_booking/controllers/booking_controller.dart';
import 'package:astronomy_event_booking/controllers/dashboard_controller.dart';
import 'package:get/get.dart';
import 'controllers/event_controller.dart';

class InitialBinding extends Bindings{
  @override
  void dependencies(){
    Get.put(DashboardController());
    Get.put(AuthController());
    Get.put(BookingController());
    Get.put(EventController());
  }
}