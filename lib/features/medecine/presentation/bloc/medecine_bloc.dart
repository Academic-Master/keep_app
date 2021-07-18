import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'medecine_event.dart';
part 'medecine_state.dart';
class MedecineBloc extends Bloc<MedecineEvent, MedecineState> {
  MedecineBloc() : super(MedecineInitial());
  @override
  Stream<MedecineState> mapEventToState(
    MedecineEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
