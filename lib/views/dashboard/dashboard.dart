import 'package:astronomy_event_booking/controllers/dashboard_controller.dart';
import 'package:astronomy_event_booking/views/dashboard/booking_screen.dart';
import 'package:astronomy_event_booking/views/dashboard/home_screen.dart';
import 'package:astronomy_event_booking/views/dashboard/profile_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final controller = Get.find<DashboardController>();
  final List<Widget> screens = [
    HomeScreen(),
    BookingScreen(),
    ProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: screens[controller.selectedIndex.value],
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: controller.selectedIndex.value,
            onTap: (i) => controller.selectedIndex.value = i,
            items: [
              BottomNavigationBarItem(icon: Icon(CupertinoIcons.home),label: 'home'),
              BottomNavigationBarItem(icon: Icon(CupertinoIcons.book),label: 'bookings'),
              BottomNavigationBarItem(icon: Icon(CupertinoIcons.person),label: 'profile'),
            ]),
      ),
    );
  }
}
