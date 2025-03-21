import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:qr_biometrics_app/core/fp/result.dart';
import 'package:qr_biometrics_app/features/features.dart';

class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
  });

  group('SignInMethodsBloc', () {
    blocTest<SignInMethodsBloc, SignInMethodsState>(
      'emits [Loading, Loaded] when repository returns Success',
      build: () {
        when(() => mockRepository.getAvailableMethods())
            .thenAnswer((_) async => Success([AuthMethod.biometricStrong]));
        return SignInMethodsBloc(
          const SignInMethodsInitial(),
          authRepository: mockRepository,
        );
      },
      act: (bloc) => bloc.add(const SignInMethodsRequested()),
      expect: () => [
        const SignInMethodsLoading(),
        const SignInMethodsLoaded([AuthMethod.biometricStrong]),
      ],
      verify: (_) {
        verify(() => mockRepository.getAvailableMethods()).called(1);
      },
    );

    blocTest<SignInMethodsBloc, SignInMethodsState>(
      'emits [Loading, Error] when repository returns Failure',
      build: () {
        when(() => mockRepository.getAvailableMethods())
            .thenAnswer((_) async => Failure(const AuthenticationFailed()));
        return SignInMethodsBloc(
          const SignInMethodsInitial(),
          authRepository: mockRepository,
        );
      },
      act: (bloc) => bloc.add(const SignInMethodsRequested()),
      expect: () => [
        const SignInMethodsLoading(),
        isA<SignInMethodsError>().having(
          (s) => s.failure,
          'failure',
          isA<AuthenticationFailed>(),
        ),
      ],
      verify: (_) {
        verify(() => mockRepository.getAvailableMethods()).called(1);
      },
    );
  });
}
