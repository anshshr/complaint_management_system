import 'package:complaint_management_system/provider/language_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void showLanguageDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: const BorderSide(color: Colors.blue, width: 2.0),
        ),
        shadowColor: Colors.blue,
        title: const Text(
          'Choose Language',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text(
                'English',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.blue,
                ),
              ),
              onTap: () {
                Provider.of<LanguageProvider>(context, listen: false)
                    .setLocale(const Locale('en'));
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: const Text(
                'Hindi',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                  fontSize: 20,
                ),
              ),
              onTap: () {
                Provider.of<LanguageProvider>(context, listen: false)
                    .setLocale(const Locale('hi'));
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    },
  );
}
