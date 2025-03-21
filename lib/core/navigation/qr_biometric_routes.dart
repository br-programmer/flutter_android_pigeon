/// An enum representing the different routes in the QrBiometrics app.
///
/// Each route is defined by a `name` and a `path`, which can be used for
/// navigation within the app.
///
/// - `splash`: Represents the splash screen route with the path `/splash`.
/// - `auth`: Represents the authentication screen route with the path `/auth`.
/// - `scanner`: Represents the scanner list screen route with the path `/`.
enum QrBiometricRoutes {
  splash(path: '/splash', name: 'Splash'),
  auth(path: '/auth', name: 'Auth'),
  scanner(path: '/', name: 'Scanner List');

  const QrBiometricRoutes({required this.name, required this.path});

  /// The name of the route.
  final String name;

  /// The path associated with the route.
  final String path;
}
