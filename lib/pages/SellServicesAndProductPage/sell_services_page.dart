import 'package:flutter/material.dart';

Color _standardColor = Color.fromARGB(255, 130, 130, 255);
class SellServicesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: TabBar(
              labelColor: _standardColor,
              indicatorColor: _standardColor,
            tabs: [
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.storage),
                    Text("Склад"),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add),
                    Text("Продать услугу"),
                  ],
                ),
              ),
            ],
            ),
          ),
          body: Center(
            child: const TabBarView(
              children: [
                Icon(Icons.directions_car),
                Icon(Icons.directions_transit),
              ],
            ),
          ),
        ),
      ),
    );
  }
}