import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_biometrics_app/features/features.dart';

/// A widget that represents a button for initiating a new scan.
///
/// The [NewScan] widget displays an icon button (QR code icon) that, when pressed,
/// triggers the scanning process by dispatching a [StartScanRequested] event to the
/// [ScannerBloc]. This event will initiate the scanning process to detect QR codes or barcodes.
///
/// It is typically placed in the app bar or other areas where users can initiate a new scan.
class NewScan extends StatelessWidget {
  const NewScan({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => context.read<ScannerBloc>().add(
            const StartScanRequested(),
          ),
      icon: const Icon(Icons.qr_code), // QR code icon for starting a scan
    );
  }
}
