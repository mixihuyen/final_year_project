class ProvinceModel {
  String id;
  String name;

  ProvinceModel({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  // Create a ProvinceModel object from Firestore Map
  factory ProvinceModel.fromMap(Map<String, dynamic> map, String documentId) {
    return ProvinceModel(
      id: documentId,
      name: map['name'] ?? '',
    );
  }
}
