class ProductModel {
  final int id;
  final String name;
  String? notes;
  String? imagePath;

  ProductModel({
    required this.id,
    required this.name,
    this.notes,
    this.imagePath,
  });

  bool get hasNotes => notes != null && notes!.isNotEmpty;
  bool get hasImage => imagePath != null;

  factory ProductModel.fromMapEntry(MapEntry<String, dynamic> entry) {
    return ProductModel(
      id: int.parse(entry.key),
      name: entry.value,
    );
  }

  // Add this method if you need to convert back to map
  Map<String, dynamic> toMap() {
    return {
      'id': id.toString(),
      'name': name,
      'notes': notes,
      'imagePath': imagePath,
    };
  }
}