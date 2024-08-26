import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Complaint extends StatelessWidget {
  const Complaint({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text((AppLocalizations.of(context)!.complaint)),
            Text((AppLocalizations.of(context)!.helloworld))
          ],
        ),
      ),
    );
  }
}
