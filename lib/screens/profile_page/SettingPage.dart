import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controller/SettingsController.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SettingsController settingsController = Get.put(SettingsController());

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          return ListView(
            children: [
              // Language Selection
              ListTile(
                title: Text('Language'),
                subtitle: Text(settingsController.selectedLanguage.value),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () => _selectLanguage(settingsController),
              ),
              Divider(),

              // Country Selection
              ListTile(
                title: Text('Country'),
                subtitle: Text(settingsController.selectedCountry.value),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () => _selectCountry(settingsController),
              ),
            ],
          );
        }),
      ),
    );
  }

  // Method to select language
  void _selectLanguage(SettingsController settingsController) async {
    final selectedLanguage = await showDialog<String>(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Language'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: ['English', 'Hindi'].map((language) {
              return ListTile(
                title: Text(language),
                onTap: () => Navigator.of(context).pop(language),
              );
            }).toList(),
          ),
        );
      },
    );

    if (selectedLanguage != null) {
      settingsController.updateLanguage(selectedLanguage);
    }
  }

  // Method to select country
  void _selectCountry(SettingsController settingsController) async {
    final selectedCountry = await showDialog<String>(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Country'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: ['United States', 'India'].map((country) {
              return ListTile(
                title: Text(country),
                onTap: () => Navigator.of(context).pop(country),
              );
            }).toList(),
          ),
        );
      },
    );

    if (selectedCountry != null) {
      settingsController.updateCountry(selectedCountry);
    }
  }
}
