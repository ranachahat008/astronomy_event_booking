import 'package:get/get.dart';

class DashboardController extends GetxController {
  var selectedIndex = 0.obs;

  @override
  void onInit() {
    selectedIndex.value = 0;
    super.onInit();
  }
}
