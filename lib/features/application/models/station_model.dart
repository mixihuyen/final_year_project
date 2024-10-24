class StationModel {
  String id;
  String name;
  String provinceId; // Add provinceId field

  StationModel({
    required this.id,
    required this.name,
    required this.provinceId, // Ensure this is required
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'provinceId': provinceId, // Include provinceId in JSON
    };
  }

  factory StationModel.fromMap(Map<String, dynamic> map, String id) {
    return StationModel(
      id: id,
      name: map['name'] ?? '',
      provinceId: map['provinceId'] ?? '', // Map the provinceId
    );
  }
}
