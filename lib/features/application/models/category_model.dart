import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String id;
  String name;

  CategoryModel({
    required this.id,
    required this.name,
  });

  static CategoryModel empty() => CategoryModel(id: '', name: '');
  // Convert model to Json structure so that you can store data in Firebase
  Map<String, dynamic> toJson() {
    return{
      'Name' : name,
    };
  }

  // Map Json oriented document snapshot from Firebase to UserModel
  factory CategoryModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return CategoryModel(
        id: document.id,
        name: data['Name'] ?? '',
      );
    } else {
      return CategoryModel.empty();
    }
  }

}
