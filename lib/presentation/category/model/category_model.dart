import 'dart:convert';

List<CategoryModel> categoryModelFromJson(String str) => List<CategoryModel>.from(json.decode(str).map((x) => CategoryModel.fromJson(x)));

String categoryModelToJson(List<CategoryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoryModel {

    int? categoryID;
    String? categoryName;
    int? deleteStatus;
    int? enabledStatus;

    CategoryModel({
        required this.categoryID,
        required this.categoryName,
        required this.deleteStatus,
        required this.enabledStatus,
    });

    factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(

        categoryID: json["Category_ID"],
        categoryName: json["Category_Name"],
        deleteStatus: json["Delete_Status"],
        enabledStatus: json["Enabled_Status"],
    );

    Map<String, dynamic> toJson() => {
        "Category_ID": categoryID,
        "Category_Name": categoryName,
        "Delete_Status": deleteStatus,
        "Enabled_Status": enabledStatus,
    };
}
