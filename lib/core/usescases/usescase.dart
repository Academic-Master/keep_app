import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

abstract class UsesCase<Params, Response> extends Equatable {
  /// Method to call for performing the action
  Future<Either<Exception, Response>> trigger(Params params);

  @override
  List<Object> get props => [];
}
