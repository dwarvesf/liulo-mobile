class User {
  String _name;
  String _email;
  String _token;

  User(this._name, this._email, this._token);

  User.map(dynamic obj) {
    this._name = obj["name"];
    this._email = obj["email"];
    this._token = obj["token"];
  }

  String get name => _name;

  String get email => _email;

  String get token => _token;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["name"] = _name;
    map["email"] = _email;
    map["token"] = _token;
    return map;
  }
}
