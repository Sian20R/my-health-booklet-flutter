import 'symptom.dart';
import 'cause.dart';
import 'diagnosis.dart';
import 'treatment.dart';

class Disease {
  String name;
  String image;
  List<String> synonyms;
  String description;
  Symptom symptoms;
  Cause causes;
  Diagnosis diagnosis;
  Treatment treatments;
}
