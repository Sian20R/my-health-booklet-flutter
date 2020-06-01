import 'package:flappy_search_bar/scaled_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import '../styles/style.dart';
import '../widgets/drawer_widget.dart';
import '../widgets/app_bar_widget.dart';
import '../models/disease/disease.dart';
import '../models/disease/symptom.dart';
import '../models/disease/cause.dart';
import '../models/disease/diagnosis.dart';
import '../models/disease/treatment.dart';

class DiseaseScreen extends StatefulWidget {
  @override
  _DiseaseScreenState createState() => _DiseaseScreenState();
}

class _DiseaseScreenState extends State<DiseaseScreen> {
  final SearchBarController<Disease> _searchBarController =
      SearchBarController();
  final _fireStore = Firestore.instance;
  List<Disease> diseases;
  bool showSpinner = false;

  void initState() {
    super.initState();
    getDiseases();
  }

  void getDiseases() async {
    try {
      diseases = List<Disease>();
      _fireStore.collection("diseases").snapshots().listen((value) {
        value.documents.forEach((doc) {
          Disease disease = convertFirebaseDocToDisease(doc);
          diseases.add(disease);
        });
      });
    } catch (e) {
      print(e);
    }
  }

  Future<List<Disease>> onSearchDisease(String text) async {
    await Future.delayed(Duration(seconds: text.length == 4 ? 5 : 1));
    List<Disease> tempDisease;
    // Filter using name
    tempDisease = diseases
        .where((element) =>
            (element.name.toLowerCase()).contains(text.toLowerCase()))
        .toList();

    // Filter using synonym
    if (tempDisease.length == 0) {
      tempDisease = List<Disease>();
      diseases.forEach((result) {
        if (result.synonyms
                .where((synonym) =>
                    synonym.toLowerCase().contains(text.toLowerCase()))
                .length !=
            0) {
          tempDisease.add(result);
        }
      });
    }

    return tempDisease;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'Diseases'),
      drawer: DrawerWidget(),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SearchBar<Disease>(
          searchBarPadding: EdgeInsets.symmetric(horizontal: 10),
          headerPadding: EdgeInsets.symmetric(horizontal: 10),
          listPadding: EdgeInsets.symmetric(horizontal: 10),
          searchBarController: _searchBarController,
          hintText: 'Please enter the diseases',
          crossAxisCount: 1,
          onItemFound: (Disease disease, int index) {
            return Container(
                width: 10.0,
                margin: EdgeInsets.only(top: 10, bottom: 10),
                decoration: kCardContainerBoxDecoration.copyWith(boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                  ),
                ]),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      (disease.image != '')
                          ? Image.network(disease.image)
                          : Icon(
                              Icons.photo_album,
                              size: 200.0,
                            ),
                      Text(
                        disease.name,
                        style: TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10.0),
                      Text(shortenDescription(disease.description)),
                      SizedBox(height: 10.0),
                    ],
                  ),
                ));
          },
          onSearch: onSearchDisease,
        ),
      ),
    );
  }
}

String shortenDescription(String description) {
  if (description.length > 800) {
    String newDescription = description.substring(0, 800);
    return newDescription + ' Read More...';
  } else {
    return description;
  }
}

Disease convertFirebaseDocToDisease(DocumentSnapshot doc) {
  List<String> synonyms = List<String>.from(
      doc.data['synonyms'].map((synonym) => synonym.toString()));

  Symptom symptom = Symptom(
    name: doc.data['symptoms.name'],
    symptoms: (doc.data['symptom.symptoms'] != null)
        ? List<String>.from(
            doc.data['symptom.symptoms'].map((symptom) => symptom.toString()))
        : null,
  );

  Cause cause = Cause(
    name: doc.data['causes.name'],
    causes: (doc.data['causes.cause'] != null)
        ? List<String>.from(
            doc.data['causes.cause'].map((cause) => cause.toString()))
        : null,
  );

  Diagnosis diagnosis = Diagnosis(
    name: doc.data['diagnosis.name'],
    diagnosis: (doc.data['diagnosis.diagnosis'] != null)
        ? List<String>.from(doc.data['diagnosis.diagnosis']
            .map((diagnosis) => diagnosis.toString()))
        : null,
  );

  Treatment treatment = Treatment(
    name: doc.data['treatments.name'],
    treatments: (doc.data['treatments.treatment'] != null)
        ? List<String>.from(doc.data['treatments.treatment']
            .map((treatment) => treatment.toString()))
        : null,
  );

  Disease disease = Disease(
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
