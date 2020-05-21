import 'package:flutter/material.dart';
import '../widgets/drawer_widget.dart';
import '../widgets/app_bar_widget.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBarWidget(title: 'Home'),
        body: Text('Hello World!'),
        drawer: DrawerWidget(),
      ),
    );
  }
}
