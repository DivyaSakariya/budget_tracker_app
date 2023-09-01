import 'package:budget_tracker_app/controllers/category_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../modals/category_modal.dart';

class CategoryList extends StatelessWidget {
  CategoryList({super.key});

  CategoryController categoryController = Get.find<CategoryController>();
  CategoryModal categoryModal = CategoryModal.init();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Category"),
      ),
      body: ListView.builder(
        itemCount: categoryController.fetchAllCategory.length,
        itemBuilder: (context, index) => Card(
          child: ListTile(
            leading: Image.asset(categoryModal.image!),
            title: Text(categoryModal.title!),
          ),
        ),
      ),
    );
  }
}
