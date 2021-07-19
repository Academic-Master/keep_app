import 'package:equatable/equatable.dart';

class Medecine extends Equatable {
  late final String name;
  late final String dose;
  late final String strength;

  Medecine({required this.name, required this.dose, required this.strength});
  @override
  List<String> get props => [name, dose, strength];
}
