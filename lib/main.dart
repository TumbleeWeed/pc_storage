import 'package:flutter/material.dart';
import 'pages/AddProductPage/add_product_page.dart';
import 'pages/BuildPCPage/build_pc_page.dart';
import 'pages/SellServicesAndProductPage/sell_services_page.dart';
import 'pages/StatisticsPage/statistics_page.dart';
import 'pages/SettingsPage/settings_page.dart';
import 'animations/navigationrail_destination.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://oswgcktjwlmhrgmtuvtm.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9zd2dja3Rqd2xtaHJnbXR1dnRtIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDA1NTY3MDEsImV4cCI6MjA1NjEzMjcwMX0.zpWRXxQCMKXBITZ9Y3OuSXMqZwwgiK4pWO2OviKf9lY',
  );

  runApp(
    MaterialApp(
      home: TapBarMenu(),
    ),
  );
}

class TapBarMenu extends StatefulWidget {
  @override
  _TapBarMenuState createState() => _TapBarMenuState();
}

class _TapBarMenuState extends State<TapBarMenu> {
  int _selectedIndex = 0;
  int _hoveredIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          Theme(
            data: ThemeData(
                highlightColor: Colors.transparent,
                splashFactory: NoSplash.splashFactory,
                colorScheme: ColorScheme.light(primary: Colors.transparent)),
            child: Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 130, 130, 255),
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: NavigationRail(
                backgroundColor: Colors.transparent,
                groupAlignment: 0,
                labelType: NavigationRailLabelType.all,
                useIndicator: false,
                selectedIndex: _selectedIndex,
                onDestinationSelected: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                destinations: [
                  _buildRailDestination(
                    icon: Icons.add,
                    label: "Добавить товар",
                    index: 0,
                  ),
                  _buildRailDestination(
                    icon: Icons.dataset,
                    label: "Сборка ПК",
                    index: 1,
                  ),
                  _buildRailDestination(
                    icon: Icons.warehouse,
                    label: "Склад/Продажа",
                    index: 2,
                  ),
                  _buildRailDestination(
                    icon: Icons.insert_chart,
                    label: "Статистика",
                    index: 3,
                  ),
                  _buildRailDestination(
                    icon: Icons.settings,
                    label: "Настройки",
                    index: 4,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: IndexedStack(
              index: _selectedIndex,
              children: [
                AddProductPage(),
                BuildPcPage(),
                SellServicesPage(),
                StatisticsPage(),
                SettingsPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  NavigationRailDestination _buildRailDestination({
    required IconData icon,
    required String label,
    required int index,
  }) {
    return NavigationRailDestination(
      icon: CustomNavigationRailDestination(
        icon: icon,
        label: label,
        isSelected: _selectedIndex == index,
        isHovered: _hoveredIndex == index,
        onTap: () {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      label: SizedBox.shrink(),
    );
  }
}
