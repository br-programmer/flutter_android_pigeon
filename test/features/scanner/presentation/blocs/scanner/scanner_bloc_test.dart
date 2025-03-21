import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:qr_biometrics_app/core/core.dart';
import 'package:qr_biometrics_app/features/features.dart';

class MockScannerRepository extends Mock implements IScannerRepository {}

void main() {
  late MockScannerRepository mockRepository;
  late ScannerBloc bloc;

  setUp(() {
    mockRepository = MockScannerRepository();
    bloc = ScannerBloc(
      const ScannerInitial(),
      scannerRepository: mockRepository,
    );
  });

  group('StartScanRequested', () {
    test('emits [Loading, Success] when scan succeeds', () async {
      when(() => mockRepository.scan())
          .thenAnswer((_) async => Success('qr_code_value'));

      bloc.add(const StartScanRequested());

      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<ScannerLoading>(),
          predicate<ScannerState>(
            (state) =>
                state is ScannerSuccess && state.value == 'qr_code_value',
          ),
        ]),
      );

      verify(() => mockRepository.scan()).called(1);
    });

    test('emits [Loading, Error] when scan fails', () async {
      when(() => mockRepository.scan())
          .thenAnswer((_) async => Failure(const PlatformScannerFailure()));

      bloc.add(const StartScanRequested());

      await expectLater(
        bloc.stream,
        emitsInOrder([
          isA<ScannerLoading>(),
          isA<ScannerError>(),
        ]),
      );

      verify(() => mockRepository.scan()).called(1);
    });
  });
}
