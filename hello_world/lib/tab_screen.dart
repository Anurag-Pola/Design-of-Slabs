import 'package:flutter/material.dart';

import 'simply_supported_slabs.dart';
import 'restrained_slabs.dart';

class TabScreen extends StatefulWidget {
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          appBar: TabBar(
            labelColor: Colors.red,
            unselectedLabelColor: Colors.black,
            tabs: <Widget>[
              Tab(text: "Restrained"),
              Tab(text: "Simply Supported"),
            ],
          ),
          body: TabBarView(
            children: [
              RestrainedSlabs(),
              SimplySupportedSlabs(),
            ],
          ),
        ),
      ),
    );
  }
}
