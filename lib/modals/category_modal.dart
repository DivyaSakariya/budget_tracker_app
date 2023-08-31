import 'dart:developer';
import 'dart:typed_data';

class CategoryModal {
  int? id;
  String? title;
  Uint8List? image;

  CategoryModal(
    this.id,
    this.title,
    this.image,
  );

  CategoryModal.init() {
    log("CategoryModal has been initialized...!!");
  }

  factory CategoryModal.fromMap({required Map data}) {
    return CategoryModal(
      data['Id'],
      data['Title'],
      data['Image'],
    );
  }
}
