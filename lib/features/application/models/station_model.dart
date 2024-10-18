class StationModel {
  String id;
  String name;

  StationModel({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  // Create a StationLocation object from Firestore Map
  factory StationModel.fromMap(Map<String, dynamic> map, String documentId) {
    return StationModel(
      id: documentId,
      name: map['name'] ?? '',
    );
  }
}
