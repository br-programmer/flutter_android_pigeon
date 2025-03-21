import 'package:flutter/material.dart';
import 'package:qr_biometrics_app/i18n/translations.g.dart';

/// A widget that displays a list of scan history items.
///
/// The [ScanHistoryList] widget shows a list of previously scanned items (e.g., QR codes or barcodes).
/// If the list is empty, a message is displayed to inform the user. Otherwise, it presents the list
/// of scans using [ListView.separated] to display each scan with a separator between items.
///
/// - `scans`: A list of strings representing the scan data (e.g., QR code or barcode values).
class ScanHistoryList extends StatelessWidget {
  const ScanHistoryList({super.key, required this.scans});
  final List<String> scans;

  @override
  Widget build(BuildContext context) {
    return switch (scans.isEmpty) {
      // If there are no scans, show a message indicating the data is empty
      true => Center(child: Text(context.texts.scan.dataEmpty)),

      // If there are scans, display them in a list with separators
      false => ListView.separated(
          itemCount: scans.length,
          itemBuilder: (_, index) => ListTile(title: Text(scans[index])),
          separatorBuilder: (_, __) => const Divider(height: 0, thickness: .5),
        ),
    };
  }
}
