import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../styles/style.dart';
import '../models/disease/disease.dart';
import '../utils/firebaseToModel/disease_firebase_model.dart';
import '../widgets/filled_button_widget.dart';

class DiseaseScreen extends StatelessWidget {
  final _fireStore = Firestore.instance;
  String diseaseId;

  DiseaseScreen({@required this.diseaseId});

  @override
  Widget build(BuildContext context) {
    Disease disease = Disease();

    return StreamBuilder<DocumentSnapshot>(
      stream: _fireStore.collection('diseases').document(diseaseId).snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (!snapshot.hasData)
          return ModalProgressHUD(
            inAsyncCall: true,
            child: Container(),
          );
        else {
          disease = convertFirebaseDocToDisease(snapshot.data);
          print('Data: ${disease?.symptoms?.symptoms}');
        }
        return Scaffold(
          appBar: AppBar(
            leading: Icon(Icons.bug_report),
            title: Text('Disease'),
            backgroundColor: Colors.green,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // ignore: null_aware_in_condition
                  (disease?.image?.isNotEmpty)
                      ? Image.network(disease.image)
                      : Image.asset(
                          'images/no_image.png',
                        ),
                  SizedBox(height: 10.0),

                  ...generateWidgets('Name:', disease.name, null),
                  ...generateWidgets(
                      'Synonyms:', disease.synonyms.join(', '), null),
                  ...generateWidgets('Description:', disease.description, null),

                  if (disease.symptoms != null)
                    ...generateWidgets('Symptoms:', disease.symptoms?.name,
                        disease.symptoms?.symptoms),

                  if (disease.causes != null)
                    ...generateWidgets('Causes:', disease.causes?.name,
                        disease.causes?.causes),

                  if (disease.diagnosis != null)
                    ...generateWidgets('Diagnosis:', disease.diagnosis?.name,
                        disease.diagnosis?.diagnosis),

                  if (disease.treatments != null)
                    ...generateWidgets('Treatments:', disease.treatments?.name,
                        disease.treatments?.treatments),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FillButtonWidget(
                        filledColour: Colors.red,
                        buttonText: 'Back',
                        filledButtonStyle: kRegisterButtonTextStyle,
                        onPressed: () => Navigator.pop(context),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  List<Widget> generateWidgets(
      String titleLabel, String titleName, List<String> data) {
    List<Widget> widgets = List<Widget>();

    widgets.add(Text(
      titleLabel,
      style: kLabelTitleTextStyle,
    ));
    if (titleName != null) {
      widgets.add(SizedBox(height: 5.0));
      widgets.add(Text(titleName));
    }
    if (data != null) {
      data.forEach((element) {
        widgets.add(Text('- $element'));
        widgets.add(SizedBox(height: 8.0));
      });
    }
    widgets.add(SizedBox(height: 15.0));

    return widgets;
  }
}
