import 'package:get/get.dart';

import '../helpers/db_helper.dart';
import '../modals/category_modal.dart';

class CategoryController extends GetxController {
  RxInt bIndex = (-1).obs;
  RxString type = "INCOME".obs;
  final RxList<CategoryModal> _allCategory = <CategoryModal>[].obs;

  CategoryController() {
    categoryInit();
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
}
