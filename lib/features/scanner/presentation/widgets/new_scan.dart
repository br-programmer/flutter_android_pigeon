import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_biometrics_app/features/features.dart';

class NewScan extends StatelessWidget {
  const NewScan({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => context.read<ScannerBloc>().add(
            const StartScanRequested(),
          ),
      icon: const Icon(Icons.qr_code),
    );
  }
}
