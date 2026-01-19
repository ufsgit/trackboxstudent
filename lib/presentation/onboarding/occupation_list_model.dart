class OccupationListModel {
    int? occupationId;
  String? occupation;

  OccupationListModel({this.occupationId, this.occupation});

  OccupationListModel.fromJson(Map<String, dynamic> json) {
    occupationId = json['Occupation_Id'];
    occupation = json['occupation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Occupation_Id'] = this.occupationId;
    data['occupation'] = this.occupation;
    return data;
  }
}