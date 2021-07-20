import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:keep_app/features/medecine/data/models/medecine_model.dart';

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
      late List<MedecineModel> _data = [];
      ((_formattedJson['problems'] as List)[0] as Map<String, dynamic>)
          .entries
          .forEach((seakName) async {
        ((seakName.value as List)[0] as Map<String, dynamic>)
            .entries
            .forEach((element) {
          ((element.value as List)[0] as Map<String, dynamic>)
              .entries
              .forEach((element) {
            ((element.value)[0] as Map<String, dynamic>)
                .entries
                .forEach((element) {
              ((element.value as List)[0] as Map<String, dynamic>)
                  .entries
                  .forEach((element) {
                _data.add(MedecineModel(
                    name: element.value[0]['name'],
                    dose: element.value[0]['dose'],
                    strength: element.value[0]['strength']));
              });
            });
          });
        });
      });
      print(_data.length);
      return Right(_data);
    } catch (e) {
      return Left(LocalDatabaseException(error: e.toString()));
    }
  }
}
