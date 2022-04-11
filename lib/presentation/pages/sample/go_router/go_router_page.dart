import 'package:flutter/material.dart';
import 'package:flutter_app_template/presentation/pages/sample/go_router/bottom_navigation_tab.dart';
import 'package:flutter_app_template/presentation/pages/sample/go_router/tab1_gage.dart';
import 'package:flutter_app_template/presentation/pages/sample/go_router/tab2_page.dart';
import 'package:go_router/go_router.dart';

class GoRouterPage extends StatelessWidget {
  const GoRouterPage({
    Key? key,
    required this.currentPageIndex,
  }) : super(key: key);

  final int currentPageIndex;

  static const pages = [
    Tab1Page(),
    Tab2Page(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('go_router_screen'),
        centerTitle: true,
      ),
      body: pages[currentPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPageIndex,
        onTap: (index) {
          final id = BottomNavigationTabExt.fromIndex(index).id;
          context.go('/goRouter/$id');
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'タブ1',
            tooltip: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'タブ2',
            tooltip: '',
          ),
        ],
      ),
    );
  }
}
