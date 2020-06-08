import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/disease/disease.dart';
import '../../models/disease/symptom.dart';
import '../../models/disease/cause.dart';
import '../../models/disease/diagnosis.dart';
import '../../models/disease/treatment.dart';

Disease convertFirebaseDocToDisease(DocumentSnapshot doc) {
  List<String> synonyms = (doc.data['synonyms'] != null)
      ? List<String>.from(
          doc.data['synonyms'].map((synonym) => synonym.toString()))
      : [];

  Symptom symptom = (doc.data['symptoms'] != null)
      ? Symptom(
          name: doc.data['symptoms']['name'],
          symptoms: (doc.data['symptoms']['symptom'] != null)
              ? List<String>.from(doc.data['symptoms']['symptom']
                  .map((symptom) => symptom.toString()))
              : null,
        )
      : null;

  Cause cause = (doc.data['causes'] != null)
      ? Cause(
          name: doc.data['causes']['name'],
          causes: (doc.data['causes']['cause'] != null)
              ? List<String>.from(
                  doc.data['causes']['cause'].map((cause) => cause.toString()))
              : null,
        )
      : null;

  Diagnosis diagnosis = (doc.data['diagnosis'] != null)
      ? Diagnosis(
          name: doc.data['diagnosis']['name'],
          diagnosis: (doc.data['diagnosis']['diagnosis'] != null)
              ? List<String>.from(doc.data['diagnosis']['diagnosis']
                  .map((diagnosis) => diagnosis.toString()))
              : null,
        )
      : null;

  Treatment treatment = (doc.data['treatments'] != null)
      ? Treatment(
          name: doc.data['treatments']['name'],
          treatments: (doc.data['treatments']['treatment'] != null)
              ? List<String>.from(doc.data['treatments']['treatment']
                  .map((treatment) => treatment.toString()))
              : null,
        )
      : null;

  Disease disease = Disease(
    id: doc.documentID,
    name: doc['name'],
    image: doc['image'],
    synonyms: synonyms,
    description: doc['description'],
    symptoms: symptom,
    causes: cause,
    diagnosis: diagnosis,
    treatments: treatment,
  );
  return disease;
}
