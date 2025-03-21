import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:qr_biometrics_app/core/core.dart';
import 'package:qr_biometrics_app/features/features.dart';

class MockStorageRepository extends Mock implements IStorageRepository {}

void main() {
  late MockStorageRepository mockRepository;
  late ScanHistoryBloc bloc;

  setUp(() {
    mockRepository = MockStorageRepository();
    bloc = ScanHistoryBloc(
      const ScanHistoryInitial(),
      storageRepository: mockRepository,
    );
  });

  group('LoadScanHistory', () {
    test('emits [Loading, Loaded] when scans() succeeds', () async {
      when(() => mockRepository.scans())
          .thenAnswer((_) async => Success(['scan1', 'scan2']));

      bloc.add(const LoadScanHistory());

      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<ScanHistoryLoading>(),
          predicate<ScanHistoryState>((state) {
            return state is ScanHistoryLoaded &&
                state.scans.length == 2 &&
                state.scans.contains('scan1');
          }),
        ]),
      );
      verify(() => mockRepository.scans()).called(1);
    });

    test('emits [Loading, Error] when scans() fails', () async {
      when(() => mockRepository.scans())
          .thenAnswer((_) async => Failure(const StorageReadFailure()));

      bloc.add(const LoadScanHistory());

      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<ScanHistoryLoading>(),
          isA<ScanHistoryError>(),
        ]),
      );
      verify(() => mockRepository.scans()).called(1);
    });
  });

  group('SaveScan', () {
    test('emits [Loaded] with new scan, stays on same state on success',
        () async {
      bloc.emit(const ScanHistoryLoaded(['existing']));
      when(() => mockRepository.save('new_scan'))
          .thenAnswer((_) async => Success(null));

      bloc.add(const SaveScan('new_scan'));

      await expectLater(
        bloc.stream,
        emitsInOrder([
          predicate<ScanHistoryState>((state) {
            return state is ScanHistoryLoaded &&
                state.scans.contains('existing') &&
                state.scans.contains('new_scan');
          }),
        ]),
      );
      verify(() => mockRepository.save('new_scan')).called(1);
    });

    test('reverts state if save() fails', () async {
      bloc.emit(const ScanHistoryLoaded(['existing']));
      when(() => mockRepository.save('new_scan'))
          .thenAnswer((_) async => Failure(const StorageWriteFailure()));

      bloc.add(const SaveScan('new_scan'));

      await expectLater(
        bloc.stream,
        emitsInOrder([
          predicate<ScanHistoryState>(
            (state) =>
                state is ScanHistoryLoaded &&
                state.scans.contains('new_scan') &&
                state.scans.contains('existing'),
          ),
          predicate<ScanHistoryState>(
            (state) =>
                state is ScanHistoryLoaded &&
                state.scans.length == 1 &&
                state.scans.first == 'existing',
          ),
        ]),
      );
      verify(() => mockRepository.save('new_scan')).called(1);
    });
  });

  group('ClearScanHistory', () {
    test('emits [Loaded([])] then same state on success', () async {
      bloc.emit(const ScanHistoryLoaded(['scan1']));
      when(() => mockRepository.clear()).thenAnswer((_) async => Success(null));

      bloc.add(const ClearScanHistory());

      await expectLater(
        bloc.stream,
        emitsInOrder([
          predicate<ScanHistoryState>(
            (state) => state is ScanHistoryLoaded && state.scans.isEmpty,
          ),
        ]),
      );
      verify(() => mockRepository.clear()).called(1);
    });

    test('reverts scans if clear() fails', () async {
      bloc.emit(const ScanHistoryLoaded(['scan1']));
      when(() => mockRepository.clear())
          .thenAnswer((_) async => Failure(const StorageWriteFailure()));

      bloc.add(const ClearScanHistory());

      await expectLater(
        bloc.stream,
        emitsInOrder([
          predicate<ScanHistoryState>(
            (state) => state is ScanHistoryLoaded && state.scans.isEmpty,
          ),
          predicate<ScanHistoryState>(
            (state) =>
                state is ScanHistoryLoaded && state.scans.contains('scan1'),
          ),
        ]),
      );
      verify(() => mockRepository.clear()).called(1);
    });
  });

  group('ScanHistoryStateX', () {
    test('returns scans when state is ScanHistoryLoaded', () {
      const state = ScanHistoryLoaded(['scan1', 'scan2']);
      expect(state.scans, ['scan1', 'scan2']);
    });

    test('returns empty list for non-loaded states', () {
      const initial = ScanHistoryInitial();
      const loading = ScanHistoryLoading();
      const error = ScanHistoryError(StorageReadFailure());

      expect(initial.scans, <String>[]);
      expect(loading.scans, <String>[]);
      expect(error.scans, <String>[]);
    });
  });
}
