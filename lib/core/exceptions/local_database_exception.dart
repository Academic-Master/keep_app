class LocalDatabaseException implements Exception {
  late final error;
  LocalDatabaseException({required this.error});

  /// For getting the reason of the exception
  String reason() => this.error;
}
