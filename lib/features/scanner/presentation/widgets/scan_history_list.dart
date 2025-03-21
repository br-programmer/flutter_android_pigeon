import 'package:flutter/material.dart';
import 'package:qr_biometrics_app/i18n/translations.g.dart';

class ScanHistoryList extends StatelessWidget {
  const ScanHistoryList({super.key, required this.scans});
  final List<String> scans;

  @override
  Widget build(BuildContext context) {
    return switch (scans.isEmpty) {
      true => Center(child: Text(context.texts.scan.dataEmpty)),
      false => ListView.separated(
          itemCount: scans.length,
          itemBuilder: (_, index) => ListTile(title: Text(scans[index])),
          separatorBuilder: (_, __) => const Divider(height: 0, thickness: .5),
        ),
    };
  }
}
