import 'package:flutter/material.dart';

class DongTai extends StatefulWidget {
  @override
  _DongTaiState createState() => _DongTaiState();
}

class _DongTaiState extends State<DongTai> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {},
        ),
        appBar: AppBar(
          title: TabBar(
            labelColor: Colors.white,
            tabs: [
              Tab(
                text: "发现",
              ),
              Tab(
                text: "好友",
              ),
            ],
            indicatorColor: Colors.white,
          ),
        ),
        body: TabBarView(
          children: [
            Icon(Icons.directions_car),
            Icon(Icons.directions_transit),
          ],
        ),
      ),
    );
  }
}
