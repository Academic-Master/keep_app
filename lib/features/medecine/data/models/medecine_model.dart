import 'package:keep_app/features/medecine/domain/entities/medecine.dart';

class MedecineModel extends Medecine {
  MedecineModel(
      {required String name, required String dose, required String strength})
      : super(dose: dose, name: name, strength: strength);

  factory MedecineModel.fromJson(Map<String, String> data) => MedecineModel(
      name: data['name']!, dose: data['dose']!, strength: data['strength']!);
}
