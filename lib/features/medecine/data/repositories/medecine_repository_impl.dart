import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:keep_app/features/medecine/data/models/medecine_full_model.dart';

import 'package:keep_app/features/medecine/domain/entities/medecine.dart';
import 'package:keep_app/core/exceptions/local_database_exception.dart';
import 'package:dartz/dartz.dart';
import 'package:keep_app/features/medecine/domain/repositories/medecine_repository.dart';

class MedecineRepostoryImpl implements MedecineRepository {
  late final http.Client _client;
  final String _url = '';

  MedecineRepostoryImpl({required http.Client client}) : this._client = client;

  @override
  Future<Either<LocalDatabaseException, List<Medecine>>> getMedecines() async {
    try {
      final _response = await this._client.get(Uri.parse(this._url));
      final _formattedJson = json.decode(_response.body);
      final _data = MedecineModel.fromJson(_formattedJson);
      _data.problems.map((e) => e.problems.forEach((element) {
            element[1]
                .medications[0]
                .medicationsClasses[0]
                .medicationClasses
                .forEach((element) {
              element[0].classNames.forEach((element) {
                print(element[0].dose);
                print(element[0].name);
                print(element[0].strength);
              });
            });
          }));

      //  .forEach((element) {
      //   element.diabetes[0].medications[0].medicationsClasses[0]
      //       .className[0].associatedDrug[0].name
      // });
      return Right([]);
    } catch (e) {
      return Left(LocalDatabaseException(error: e.toString()));
    }
  }
}
