import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gender_selection/gender_selection.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../styles/style.dart';
import '../utils/validation.dart';
import '../utils/format_date_time.dart';
import '../utils/firebase_storage_upload.dart';
import '../states/profile_state.dart';
import '../widgets/drawer_widget.dart';
import '../widgets/app_bar_widget.dart';
import '../widgets/text_form_field_widget.dart';
import '../widgets/multi_select_field_widget.dart';
import '../widgets/filled_button_widget.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _fireStore = Firestore.instance;
  final dateOfBirthController = TextEditingController();
  bool showSpinner = false;
  String name;
  String gender = 'male';
  String dateOfBirth;
  List disease;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBarWidget(title: 'Profile'),
      drawer: DrawerWidget(),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Consumer<ProfileState>(
                    builder: (context, profileState, child) => GestureDetector(
                      onTap: () => Navigator.pushNamed(
                          context, RouteConstant.uploadProfilePicture),
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 70.0,
                        child: ClipRRect(
                          child: (profileState.getProfile().profilePicture ==
                                  null)
                              ? Icon(
                                  Icons.add_a_photo,
                                  color: Colors.green,
                                )
                              : Image(
                                  image: FileImage(
                                      profileState.getProfile().profilePicture),
                                ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  TextFormFieldWidget(
                    onChanged: (value) => name = value,
                    validator: nameValidator,
                    keyBoardType: TextInputType.emailAddress,
                    hintText: 'Name',
                    icon: Icons.account_box,
                  ),
                  SizedBox(height: 10.0),
                  TextFormFieldWidget(
                    onChanged: (value) => dateOfBirth = value,
                    validator: dateOfBirthValidator,
                    controller: dateOfBirthController,
                    hintText: 'Date of Birth',
                    icon: Icons.date_range,
                    onTap: () {
                      FocusScope.of(context).requestFocus(new FocusNode());
                      DatePicker.showDatePicker(
                        context,
                        showTitleActions: true,
                        minTime: DateTime(1930, 1, 1),
                        maxTime: DateTime.now(),
                        currentTime: DateTime.now(),
                        locale: LocaleType.en,
                        onConfirm: (date) async {
                          String birthDate = formatToDate(date.toString());
                          dateOfBirthController.text = birthDate;
                          dateOfBirth = birthDate;
                        },
                      );
                    },
                  ),
                  GenderSelection(
                    maleText: "Male", //default Male
                    femaleText: "Female", //default Female
                    selectedGender: Gender.Male,
                    selectedGenderIconBackgroundColor: Colors.green,
                    onChanged: (Gender value) =>
                        gender = (value == Gender.Male) ? 'male' : 'female',
                    equallyAligned: true,
                    animationDuration: Duration(milliseconds: 400),
                    isSelectedGenderIconCircular: true,
                    size: 100, //default : 120
                  ),
                  MultiSelectFieldWidget(
                    titleText: 'Diseases',
                    dataSource: diseases,
                    hintText: "Please select your existing conditions",
                    onSaved: (value) =>
                        {if (value != null) print(value), disease = value},
                  ),
                  SizedBox(height: 25.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FillButtonWidget(
                        filledColour: Colors.green,
                        buttonText: 'Register',
                        filledButtonStyle: kLoginButtonTextStyle,
                        onPressed: addUpdateProfile,
                      ),
                      SizedBox(width: 15.0),
                      FillButtonWidget(
                        filledColour: Colors.red,
                        buttonText: 'Cancel',
                        filledButtonStyle: kRegisterButtonTextStyle,
                        onPressed: () => Navigator.pop(context),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void addUpdateProfile() async {
    setState(() => showSpinner = true);
    if (_formKey.currentState.validate()) {
      try {
        String profilePicturePath = await uploadProfilePicture(
            Provider.of<ProfileState>(context, listen: false)
                .getProfile()
                .profilePicture,
            'seawkerboon@gmail.com');

        print('profilePicturePath: $profilePicturePath');

        await _fireStore.collection('public_users').add(
          {
            'name': name,
            'dateOfBirth': dateOfBirth,
            'gender': gender,
            'diseases': disease,
            'profilePicturePath': profilePicturePath,
          },
        );

        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text('Profile added/updated'),
          ),
        );
      } catch (e) {
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Text('Unable to add/update user profile'),
          ),
        );

        print(e);
      }
    }
    setState(() => showSpinner = false);
  }
}
