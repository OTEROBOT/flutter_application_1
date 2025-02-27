import 'package:flutter/material.dart';
import 'drawer_menu.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Contact Management App by 110'),),
      
      drawer: drawerMenu(context),

      body: Center(
        child: //
          Text('Contact Management'),
          //
      ),
    );
  }
}