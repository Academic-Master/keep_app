import 'package:keep_app/features/medecine/domain/entities/medecine.dart';

class MedecineModel {
  late final List<Problems> problems;

  MedecineModel({required this.problems});

  MedecineModel.fromJson(Map<String, dynamic> json) {
    if (json['problems'] != null) {
      this.problems = <Problems>[];
      json['problems'].forEach((v) {
        problems.add(Problems.fromJson(v));
      });
    }
  }
}

class Problems {
  late final List<List<Seak>> problems;
  late final List<Seak> diabetes;
  late final List<Seak> asthma;

  Problems({required this.diabetes, required this.asthma});

  Problems.fromJson(Map<String, dynamic> json) {
    if (json['Diabetes'] != null) {
      diabetes = <Seak>[];
      json['Diabetes'].forEach((v) {
        diabetes.add(Seak.fromJson(v));
      });
    }
    if (json['Asthma'] != null) {
      asthma = <Seak>[];
      json['Asthma'].forEach((v) {
        asthma.add(Seak.fromJson(v));
      });
      this.problems = [this.diabetes, this.asthma];
    }
  }
}

class Seak {
  late final List<Medications> medications;
  late final List<Labs> labs;

  Seak({required this.medications, required this.labs});

  Seak.fromJson(Map<String, dynamic> json) {
    if (json['medications'] != null) {
      medications = <Medications>[];
      json['medications'].forEach((v) {
        medications.add(new Medications.fromJson(v));
      });
    }
    if (json['labs'] != null) {
      labs = <Labs>[];
      json['labs'].forEach((v) {
        labs.add(Labs.fromJson(v));
      });
    }
  }
}

class Medications {
  late final List<MedicationsClasses> medicationsClasses;

  Medications({required this.medicationsClasses});

  Medications.fromJson(Map<String, dynamic> json) {
    if (json['medicationsClasses'] != null) {
      medicationsClasses = <MedicationsClasses>[];
      json['medicationsClasses'].forEach((v) {
        medicationsClasses.add(new MedicationsClasses.fromJson(v));
      });
    }
  }
}

class MedicationsClasses {
  late final List<List<ClassName>> medicationClasses;
  late final List<ClassName> className;
  late final List<ClassName> className2;

  MedicationsClasses({required this.className, required this.className2});

  MedicationsClasses.fromJson(Map<String, dynamic> json) {
    if (json['className'] != null) {
      className = <ClassName>[];
      json['className'].forEach((v) {
        className.add(ClassName.fromJson(v));
      });
    }
    if (json['className2'] != null) {
      className2 = <ClassName>[];
      json['className2'].forEach((v) {
        className2.add(new ClassName.fromJson(v));
      });
    }
    this.medicationClasses = [this.className, this.className2];
  }
}

class ClassName {
  late final List<List<AssociatedDrug>> classNames;
  late final List<AssociatedDrug> associatedDrug;
  late final List<AssociatedDrug> associatedDrug2;

  ClassName({required this.associatedDrug, required this.associatedDrug2});

  ClassName.fromJson(Map<String, dynamic> json) {
    if (json['associatedDrug'] != null) {
      associatedDrug = <AssociatedDrug>[];
      json['associatedDrug'].forEach((v) {
        associatedDrug.add(new AssociatedDrug.fromJson(v));
      });
    }
    if (json['associatedDrug#2'] != null) {
      associatedDrug2 = <AssociatedDrug>[];
      json['associatedDrug#2'].forEach((v) {
        associatedDrug2.add(AssociatedDrug.fromJson(v));
      });
    }

    this.classNames = [this.associatedDrug, this.associatedDrug2];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.associatedDrug != null) {
      data['associatedDrug'] =
          this.associatedDrug.map((v) => v.toJson()).toList();
    }
    if (this.associatedDrug2 != null) {
      data['associatedDrug#2'] =
          this.associatedDrug2.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AssociatedDrug {
  late final String name;
  late final String dose;
  late final String strength;

  AssociatedDrug(
      {required this.name, required this.dose, required this.strength});

  AssociatedDrug.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    dose = json['dose'];
    strength = json['strength'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['dose'] = this.dose;
    data['strength'] = this.strength;
    return data;
  }
}

class Labs {
  late final String missingField;

  Labs({required this.missingField});

  Labs.fromJson(Map<String, dynamic> json) {
    missingField = json['missing_field'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['missing_field'] = this.missingField;
    return data;
  }
}
