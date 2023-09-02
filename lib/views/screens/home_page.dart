import 'package:budget_tracker_app/views/components/budget_component.dart';
import 'package:budget_tracker_app/views/components/graph_component.dart';
import 'package:budget_tracker_app/views/components/search_component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/home_controller.dart';
import '../../controllers/transaction_controller.dart';
import '../components/transaction_component.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  HomeController homeController = Get.put(HomeController());
  TransactionController transactionController =
      Get.put(TransactionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Budget Tracker"),
      ),
      body: PageView(
        controller: homeController.pageController,
        children: [
          TransactionComponent(),
          GraphComponent(),
          SearchComponent(),
          BudgetComponent(),
        ],
      ),
      bottomNavigationBar: Obx(
        () {
          return BottomNavigationBar(
            onTap: (index) {
              homeController.onPageChange(index: index);
              if (index == 3) {}
            },
            currentIndex: homeController.getCurrentIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.featured_play_list_outlined),
                label: 'Records',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.pie_chart),
                label: 'Analysis',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_balance_wallet_rounded),
                label: 'Budget',
              ),
            ],
            unselectedLabelStyle: TextStyle(color: Colors.grey.shade500),
            unselectedItemColor: Colors.grey,
            selectedItemColor: Colors.black,
            selectedLabelStyle: const TextStyle(color: Colors.grey),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed("/add_category_component");
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
