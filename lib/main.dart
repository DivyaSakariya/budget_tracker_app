import 'package:budget_tracker_app/views/components/add_category_component.dart';
import 'package:budget_tracker_app/views/components/category_list.dart';
import 'package:budget_tracker_app/views/components/edit_transaction.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'helpers/db_helper.dart';
import 'views/screens/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.dbHelper.init();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      getPages: [
        GetPage(
          name: '/',
          page: () => HomePage(),
        ),
        GetPage(
          name: '/add_category_component',
          page: () => AddCategoryComponent(),
          transition: Transition.rightToLeft,
          curve: Curves.easeInOut,
        ),
        GetPage(
          name: '/category_list',
          page: () => CategoryList(),
          transition: Transition.upToDown,
          curve: Curves.easeInOut,
        ),
        GetPage(
          name: '/edit_transaction',
          page: () => EditTransaction(),
          transition: Transition.upToDown,
          curve: Curves.easeInOut,
        ),
      ],
    );
  }
}
