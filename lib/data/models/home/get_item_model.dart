class GetItemCartModel {
  int id;
  DateTime createdAt;
  DateTime updatedAt;
  int courseId;
  int quantity;

  GetItemCartModel({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.courseId,
    required this.quantity,
  });

  factory GetItemCartModel.fromJson(Map<String, dynamic> json) =>
      GetItemCartModel(
        id: json["id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        courseId: json["course_id"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "course_id": courseId,
        "quantity": quantity,
      };
}
