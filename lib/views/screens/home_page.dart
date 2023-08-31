import 'package:budget_tracker_app/controllers/home_controller.dart';
import 'package:budget_tracker_app/views/components/add_category_component.dart';
import 'package:budget_tracker_app/views/components/graph_component.dart';
import 'package:budget_tracker_app/views/components/search_component.dart';
import 'package:budget_tracker_app/views/components/transaction_component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Budget Tracker"),
      ),
      body: SafeArea(
        child: PageView(
          controller: homeController.pageController,
          children: [
            TransactionComponent(),
            GraphComponent(),
            SearchComponet(),
            AddCategoryComponent(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.graphic_eq_outlined),
            label: 'Graph',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
