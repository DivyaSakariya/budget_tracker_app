import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helpers/db_helper.dart';
import '../modals/category_modal.dart';

class CategoryController extends GetxController {
  RxInt bIndex = (-1).obs;
  RxString type = "INCOME".obs;
  final RxList<CategoryModal> _allCategory = <CategoryModal>[].obs;

  RxString date = "".obs;
  RxString time = "".obs;

  CategoryController() {
    categoryInit();
    DateTime d = DateTime.now();

    String currentDate = "${d.day}/${d.month}/${d.year}";
    String currentTime =
        "${d.hour.toString().padLeft(2, '0')}:${d.minute.toString().padLeft(2, '0')}";

    date(currentDate);
    time(currentTime);
  }

  selectIndex({required int index}) {
    bIndex(index);
  }

  selectType({required String catType}) {
    type(catType);
  }

  categoryInit() async {
    _allCategory(await DBHelper.dbHelper.fetchAllCategory());
  }

  List<CategoryModal> get fetchAllCategory {
    return _allCategory.value;
  }

  showMyDate(BuildContext context) async {
    DateTime? pickDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1965),
      lastDate: DateTime(2999),
    );

    if (pickDate != null) {
      String formattedDate =
          "${pickDate.day}/${pickDate.month}/${pickDate.year}";
      // DateFormat("dd/MM/yyyy").format(pickDate);
      date(formattedDate);
    }
  }

  showMyTime(BuildContext context) async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (newTime != null) {
      TimeOfDay formattedTime =
          TimeOfDay(hour: newTime.hour, minute: newTime.minute);
      time(formattedTime.format(context));
    }
  }
}
