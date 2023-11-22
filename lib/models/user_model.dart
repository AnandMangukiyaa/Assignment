part of 'models.dart';
List<UserData> userDataFromJson(dynamic str) => List<UserData>.from(str.map((x) => UserData.fromJson(x)));

String userDataToJson(List<UserData> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
class UserData {
  int? id;
  String? name;
  String? email;
  Gender? gender;
  Status? status;

  UserData({
    this.id,
    this.name,
    this.email,
    this.gender,
    this.status,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    gender: genderValues.map[json["gender"]]!,
    status: statusValues.map[json["status"]]!,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "gender": genderValues.reverse[gender],
    "status": statusValues.reverse[status],
  };

  factory UserData.empty() {
    return UserData(
      id: null,
      name: null,
      email: null,
      gender: null,
      status: null
    );
  }
}


enum Gender {
  FEMALE,
  MALE
}

final genderValues = EnumValues({
  "female": Gender.FEMALE,
  "male": Gender.MALE
});

enum Status {
  ACTIVE,
  INACTIVE
}

final statusValues = EnumValues({
  "active": Status.ACTIVE,
  "inactive": Status.INACTIVE
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
