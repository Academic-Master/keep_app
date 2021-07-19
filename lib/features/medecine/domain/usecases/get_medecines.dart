import 'package:dartz/dartz.dart';
import 'package:keep_app/core/usescases/usescase.dart';
import 'package:keep_app/features/medecine/domain/entities/medecine.dart';
import 'package:keep_app/features/medecine/domain/repositories/medecine_repository.dart';
import 'package:keep_app/features/medecine/domain/usecases/params/get_medecines_params.dart';

class GetMedecines implements UsesCase<GetMedecinesParams, List<Medecine>> {
  late final MedecineRepository medecineRepository;

  GetMedecines({required this.medecineRepository});

  @override
  List<Object> get props => [];

  @override
  bool? get stringify => false;

  @override
  Future<Either<Exception, List<Medecine>>> trigger(
      GetMedecinesParams params) async {
    return (await this.medecineRepository.getMedecines());
  }
}
