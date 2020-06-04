import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../styles/style.dart';
import '../models/disease/disease.dart';
import '../utils/firebaseToModel/disease_firebase_model.dart';

class DiseaseScreen extends StatefulWidget {
  final String diseaseId;

  // receive data from the FirstScreen as a parameter
  DiseaseScreen({Key key, @required this.diseaseId}) : super(key: key);

  @override
  _DiseaseScreenState createState() => _DiseaseScreenState();
}

class _DiseaseScreenState extends State<DiseaseScreen> {
  final _fireStore = Firestore.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Disease disease = Disease();

    return StreamBuilder<DocumentSnapshot>(
      stream: _fireStore
          .collection('diseases')
          .document(widget.diseaseId)
          .snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (!snapshot.hasData)
          return ModalProgressHUD(
            inAsyncCall: true,
            child: Container(),
          );
        else {
          disease = convertFirebaseDocToDisease(snapshot.data);
        }
        return Scaffold(
          appBar: AppBar(
            leading: Icon(Icons.bug_report),
            title: Text('Disease'),
            backgroundColor: Colors.green,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  // ignore: null_aware_in_condition
                  (disease?.image?.isNotEmpty)
                      ? Image.network(disease.image)
                      : Icon(
                          Icons.photo_album,
                          size: 200.0,
                        ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    initialValue: disease.name,
                    enabled: false,
                    style: TextStyle(color: Colors.black),
                    decoration: kTextFieldInputDecoration.copyWith(
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                          'Name: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
