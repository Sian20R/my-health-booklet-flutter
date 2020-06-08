import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myhealthbooklet/screens/disease_screen.dart';
import 'package:provider/provider.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import '../styles/style.dart';
import '../utils/firebaseToModel/disease_firebase_model.dart';
import '../widgets/drawer_widget.dart';
import '../widgets/app_bar_widget.dart';
import '../models/disease/disease.dart';
import '../screens/disease_screen.dart';

class DiseasesScreen extends StatefulWidget {
  @override
  _DiseasesScreenState createState() => _DiseasesScreenState();
}

class _DiseasesScreenState extends State<DiseasesScreen> {
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
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DiseaseScreen(diseaseId: disease.id),
                  ),
                );
              },
              child: Container(
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
                            : Image.asset('images/no_image.png'),
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
                  )),
            );
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
