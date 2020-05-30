import 'package:flutter/foundation.dart';
import '../models/disease/disease.dart';

class DiseaseState with ChangeNotifier {
  List<Disease> _diseases = List<Disease>();

  void setDiseases(List<Disease> diseases) {
    _diseases = diseases;
    notifyListeners();
  }

  List<Disease> getDiseases() {
    return _diseases;
  }
}
