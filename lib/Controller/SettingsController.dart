import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsController extends GetxController {
  RxString selectedLanguage = 'English'.obs;
  RxString selectedCountry = 'India'.obs;

  @override
  void onInit() {
    _loadSettings();
    super.onInit();
  }

  // Load settings from shared preferences
  void _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    selectedLanguage.value = prefs.getString('language') ?? 'English';
    selectedCountry.value = prefs.getString('country') ?? 'India';
  }

  // Update language and save to shared preferences
  void updateLanguage(String language) async {
    if (language == 'Hindi') {
      Get.snackbar(
        'Language Not Available',
        'Hindi language support will be available in the next update.',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 3),
      );
      return;
    }

    selectedLanguage.value = language;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', language);
  }

  // Update country and save to shared preferences
  void updateCountry(String country) async {
    selectedCountry.value = country;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('country', country);
  }
}
