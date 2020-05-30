import 'package:flappy_search_bar/scaled_tile.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import '../widgets/drawer_widget.dart';
import '../widgets/app_bar_widget.dart';
import '../models/disease/disease.dart';

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
      _fireStore.collection("diseases").snapshots().listen((value) {
        value.documents.forEach((doc) {
          print('disease: ${doc['name']}');
        });
      });
    } catch (e) {
      print(e);
    }
  }

  Future<List<Disease>> onSearchDisease(String text) async {
    return await diseases;
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
          indexedScaledTileBuilder: (int index) =>
              ScaledTile.count(1, index.isEven ? 2 : 1),
          onItemFound: (Disease post, int index) {
            return Container(
              color: Colors.lightBlue,
              child: ListTile(
                title: Text('Test'),
              ),
            );
          },
          onSearch: onSearchDisease,
        ),
      ),
    );
  }
}
