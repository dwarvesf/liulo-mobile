class User {
  String status;
  int id;
  String gender;
  String fullName;
  String email;

  User(this.status, this.id, this.gender, this.fullName, this.email);

  User.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    id = json['id'];
    gender = json['gender'];
    fullName = json['full_name'];
    email = json['email'];
  }

  User.map(dynamic obj) {
    this.status = obj["status"];
    this.id = obj["id"];
    this.gender = obj["gender"];
    this.fullName = obj["full_name"];
    this.email = obj["email"];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['gender'] = this.gender;
    data['full_name'] = this.fullName;
    data['email'] = this.email;
    return data;
  }
}
