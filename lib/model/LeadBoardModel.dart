class LeadBoardModel {
  String? region;
  List<Leaders>? leaders;

  LeadBoardModel({this.region, this.leaders});

  LeadBoardModel.fromJson(Map<String, dynamic> json) {
    region = json['region'];
    if (json['leaders'] != null) {
      leaders = <Leaders>[];
      json['leaders'].forEach((v) {
        leaders!.add(new Leaders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['region'] = this.region;
    if (this.leaders != null) {
      data['leaders'] = this.leaders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Leaders {
  String? userId;
  String? name;
  String? profilePic;
  int? points;

  Leaders({this.userId, this.name, this.profilePic, this.points});

  Leaders.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    name = json['name'];
    profilePic = json['profilePic'];
    points = json['points'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['profilePic'] = this.profilePic;
    data['points'] = this.points;
    return data;
  }
}