import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:gender_selection/gender_selection.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../styles/style.dart';
import '../utils/validation.dart';
import '../utils/format_date_time.dart';
import '../states/profile_state.dart';
import '../widgets/drawer_widget.dart';
import '../widgets/app_bar_widget.dart';
import '../widgets/text_form_field_widget.dart';
import '../widgets/multi_select_field_widget.dart';
import '../widgets/filled_button_widget.dart';

class ProfileScreen extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final dateOfBirthController = TextEditingController();
  final List illness = [
    {
      "display": "Running",
      "value": "Running",
    },
    {
      "display": "Climbing",
      "value": "Climbing",
    },
    {
      "display": "Walking",
      "value": "Walking",
    },
    {
      "display": "Swimming",
      "value": "Swimming",
    },
    {
      "display": "Soccer Practice",
      "value": "Soccer Practice",
    },
    {
      "display": "Baseball Practice",
      "value": "Baseball Practice",
    },
    {
      "display": "Football Practice",
      "value": "Football Practice",
    },
  ];

  String name;
  String gender;
  String dateOfBirth;

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileState>(
      builder: (context, profileState, child) => Scaffold(
        appBar: AppBarWidget(title: 'Profile'),
        drawer: DrawerWidget(),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  GestureDetector(
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
                    onChanged: (value) => name = value,
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
                          dateOfBirthController.text =
                              formatToDate(date.toString());
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
                    titleText: 'Illness',
                    dataSource: illness,
                    hintText: "Please select your existing conditions",
                  ),
                  SizedBox(height: 25.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FillButtonWidget(
                        filledColour: Colors.green,
                        buttonText: 'Register',
                        filledButtonStyle: kLoginButtonTextStyle,
                        onPressed: () {},
                      ),
                      SizedBox(width: 15.0),
                      FillButtonWidget(
                        filledColour: Colors.red,
                        buttonText: 'Cancel',
                        filledButtonStyle: kRegisterButtonTextStyle,
                        onPressed: () {},
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
}
