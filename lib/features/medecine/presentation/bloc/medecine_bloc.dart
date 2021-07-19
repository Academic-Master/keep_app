import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:keep_app/core/exceptions/local_database_exception.dart';
import 'package:keep_app/features/medecine/domain/entities/medecine.dart';
import 'package:keep_app/features/medecine/domain/usecases/get_medecines.dart'
    as Usescase;

part 'medecine_event.dart';
part 'medecine_state.dart';

class MedecineBloc extends Bloc<MedecineEvent, MedecineState> {
  late final Usescase.GetMedecines _getMedecines;

  MedecineBloc({required Usescase.GetMedecines getMedecines})
      : this._getMedecines = getMedecines,
        super(MedecineInitial());
  @override
  Stream<MedecineState> mapEventToState(
    MedecineEvent event,
  ) async* {
    if (event is GetMedecines) {
      yield IsLoadingState();

      //Fecth data
      final _response =
          await this._getMedecines.medecineRepository.getMedecines();
      yield _response.fold(
          (l) => FailedFetchMedecines(localDatabaseException: l),
          (r) => GotMedecinesList(medecines: r));
    }
  }
}
