import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_biometrics_app/core/core.dart';
import 'package:qr_biometrics_app/features/features.dart';
import 'package:qr_biometrics_app/i18n/translations.g.dart';

class ScanListScreen extends StatelessWidget {
  const ScanListScreen._();

  static Widget builder(BuildContext _, GoRouterState __) {
    return const ScanListScreen._();
  }

  void _listener(BuildContext context, ScannerState state) {
    final callback = switch (state) {
      ScannerSuccess(:final value) => () {
          context.read<ScanHistoryBloc>().add(SaveScan(value));
        },
      ScannerError() => () {},
      _ => null,
    };
    callback?.call();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ScanHistoryBloc(
            const ScanHistoryInitial(),
            storageRepository: context.read(),
          )..add(const LoadScanHistory()),
        ),
        BlocProvider(
          create: (_) => ScannerBloc(
            const ScannerInitial(),
            scannerRepository: context.read(),
          ),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.texts.scan.history),
          elevation: 2,
          actions: const [NewScan(), LogoutButton()],
        ),
        body: BlocListener<ScannerBloc, ScannerState>(
          listener: _listener,
          child: const ScanListLayout(),
        ),
      ),
    );
  }
}

class ScanListLayout extends StatelessWidget {
  const ScanListLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScanHistoryBloc, ScanHistoryState>(
      builder: (_, state) => switch (state) {
        ScanHistoryLoaded(:final scans) => ScanHistoryList(scans: scans),
        ScanHistoryError() => Text(context.texts.scan.errorLoadingHistory),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }
}
