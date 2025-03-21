import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:qr_biometrics_app/core/core.dart';

class MockSessionRepository extends Mock implements ISessionRepository {}

void main() {
  late MockSessionRepository sessionRepository;

  setUp(() => sessionRepository = MockSessionRepository());

  group('AuthBloc', () {
    blocTest<AuthBloc, AuthState>(
      'emits [Loading, Authenticated] when sessionActive returns true',
      build: () {
        when(() => sessionRepository.sessionActive())
            .thenAnswer((_) async => Success(true));
        return AuthBloc(
          const AuthInitial(),
          sessionRepository: sessionRepository,
        );
      },
      act: (bloc) => bloc.add(const AuthCheckRequested()),
      expect: () => [
        const AuthLoading(),
        const Authenticated(),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [Loading, Unauthenticated] when sessionActive returns false',
      build: () {
        when(() => sessionRepository.sessionActive())
            .thenAnswer((_) async => Success(false));
        return AuthBloc(
          const AuthInitial(),
          sessionRepository: sessionRepository,
        );
      },
      act: (bloc) => bloc.add(const AuthCheckRequested()),
      expect: () => [
        const AuthLoading(),
        const Unauthenticated(),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [Loading, Unauthenticated] when sessionActive returns Failure',
      build: () {
        when(() => sessionRepository.sessionActive())
            .thenAnswer((_) async => Failure(const ReadSessionFailure()));
        return AuthBloc(
          const AuthInitial(),
          sessionRepository: sessionRepository,
        );
      },
      act: (bloc) => bloc.add(const AuthCheckRequested()),
      expect: () => [
        const AuthLoading(),
        const Unauthenticated(),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [Authenticated] when saveSession succeeds',
      build: () {
        when(() => sessionRepository.saveSession(true))
            .thenAnswer((_) async => Success(null));
        return AuthBloc(
          const AuthInitial(),
          sessionRepository: sessionRepository,
        );
      },
      act: (bloc) => bloc.add(const AuthSignedIn()),
      expect: () => [
        const Authenticated(),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [Unauthenticated] when saveSession fails',
      build: () {
        when(() => sessionRepository.saveSession(true))
            .thenAnswer((_) async => Failure(const SaveSessionFailure()));
        return AuthBloc(
          const AuthInitial(),
          sessionRepository: sessionRepository,
        );
      },
      act: (bloc) => bloc.add(const AuthSignedIn()),
      expect: () => [const Unauthenticated()],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [Unauthenticated] when signed out',
      build: () {
        when(() => sessionRepository.clearSession()).thenAnswer(
          (_) async => Success(null),
        );
        return AuthBloc(
          const AuthInitial(),
          sessionRepository: sessionRepository,
        );
      },
      act: (bloc) => bloc.add(const AuthSignedOut()),
      expect: () => [const Unauthenticated()],
    );
  });
}
