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
      'name' : name,
    };
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }
  factory CategoryModel.fromMap(Map<String, dynamic> map, String documentId) {
    return CategoryModel(
      id: documentId,
      name: map['name'] ?? '',
    );
  }

  // Map Json oriented document snapshot from Firebase to UserModel
  factory CategoryModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return CategoryModel(
        id: document.id,
        name: data['name'] ?? '',
      );
    } else {
      return CategoryModel.empty();
    }
  }

}
