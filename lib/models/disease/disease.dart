import 'package:flutter/cupertino.dart';
import 'symptom.dart';
import 'cause.dart';
import 'diagnosis.dart';
import 'treatment.dart';

class Disease {
  String id;
  String name;
  String image = null;
  List<String> synonyms;
  String description;
  Symptom symptoms;
  Cause causes;
  Diagnosis diagnosis;
  Treatment treatments;

  Disease({
    @required this.id,
    @required this.name,
    this.image,
    this.synonyms,
    @required this.description,
    this.symptoms,
    this.causes,
    this.diagnosis,
    this.treatments,
  });
}
