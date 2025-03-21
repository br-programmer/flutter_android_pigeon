abstract interface class IStorageDatasource {
  Future<List<String>> scans();
  Future<void> save(String value);
  Future<void> clear();
}
