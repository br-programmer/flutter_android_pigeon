import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_biometrics_app/core/core.dart';
import 'package:qr_biometrics_app/features/features.dart';
import 'package:qr_biometrics_app/i18n/translations.g.dart';

/// A screen that displays the list of scanned data and allows users to initiate a new scan.
///
/// The [ScanListScreen] is the main screen that shows the scan history and provides
/// functionality for initiating new scans. It integrates with the [ScanHistoryBloc]
/// and [ScannerBloc] to manage scan data and initiate the scanning process.
/// It listens for changes in the scan state and updates the UI accordingly.
///
/// The screen includes:
/// - A list of historical scans.
/// - A button to initiate a new scan.
/// - A button to log out of the app.
class ScanListScreen extends StatelessWidget {
  const ScanListScreen._();

  /// Builder method for constructing the [ScanListScreen] widget.
  ///
  /// This is used by [GoRouter] to create the `ScanListScreen` widget when navigating
  /// to the scan list screen route.
  static Widget builder(BuildContext _, GoRouterState __) {
    return const ScanListScreen._();
  }

  /// Listener for changes in the [ScannerBloc] state.
  ///
  /// This method is called whenever the state of the [ScannerBloc] changes. It checks
  /// if the state is [ScannerSuccess] (i.e., a successful scan), and if so, it saves
  /// the scanned value to the history by dispatching the [SaveScan] event.
  ///
  /// It does nothing if the state is [ScannerError] or any other state.
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
        // Bloc to manage the scan history
        BlocProvider(
          create: (_) => ScanHistoryBloc(
            const ScanHistoryInitial(),
            storageRepository: context.read(),
          )..add(const LoadScanHistory()),
        ),
        // Bloc to handle the scanning process
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
          listener: _listener, // Listens to scanner state changes
          child: const ScanListLayout(), // Layout for the scan list
        ),
      ),
    );
  }
}

/// The layout for displaying the scan history list.
///
/// The [ScanListLayout] widget is responsible for rendering the scan history list,
/// or displaying appropriate messages depending on the state of the [ScanHistoryBloc].
/// It uses [BlocBuilder] to react to changes in the [ScanHistoryState].
class ScanListLayout extends StatelessWidget {
  const ScanListLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScanHistoryBloc, ScanHistoryState>(
      builder: (_, state) => switch (state) {
        // Display the list of scans when history is successfully loaded
        ScanHistoryLoaded(:final scans) => ScanHistoryList(scans: scans),
        // Display an error message if there is a failure loading history
        ScanHistoryError() => Text(context.texts.scan.errorLoadingHistory),
        // Display a loading indicator while the scan history is being fetched
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }
}
