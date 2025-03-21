enum QrBiometricRoutes {
  splash(path: '/splash', name: 'Splash'),
  auth(path: '/auth', name: 'Auth'),
  scanner(path: '/', name: 'Scanner List');

  const QrBiometricRoutes({required this.name, required this.path});
  final String name;
  final String path;
}
