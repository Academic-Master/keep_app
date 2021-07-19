part of 'medecine_bloc.dart';

abstract class MedecineState extends Equatable {}

class MedecineInitial extends MedecineState {
  @override
  List<Object> get props => [];
}

class IsLoadingState extends MedecineState {
  @override
  List<Object> get props => [];
}

class GotMedecinesList extends MedecineState {
  late final List<Medecine> medecines;

  GotMedecinesList({required this.medecines});

  @override
  List<Medecine> get props => this.medecines;
}

class FailedFetchMedecines extends MedecineState {
  late final LocalDatabaseException localDatabaseException;

  FailedFetchMedecines({required this.localDatabaseException});
  @override
  List<Object> get props => [localDatabaseException];
}
