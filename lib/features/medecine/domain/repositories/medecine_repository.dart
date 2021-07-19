import 'package:dartz/dartz.dart';
import 'package:keep_app/core/exceptions/local_database_exception.dart';
import 'package:keep_app/features/medecine/domain/entities/medecine.dart';

abstract class MedecineRepository {
  /// For getting list of medecine from the datastore
  Future<Either<LocalDatabaseException, List<Medecine>>> getMedecines();
}
