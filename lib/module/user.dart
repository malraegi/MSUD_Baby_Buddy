import 'dart:convert';

TUser userFromJson(String str) => TUser.fromJson(json.decode(str));

String userToJson(TUser data) => json.encode(data.toJson());

class TUser {
  TUser({
    this.age,
    this.email,
    this.fullName,
    this.gender,
    this.height,
    this.isoleuocine,
    this.leucine,
    this.userId,
    this.valine,
    this.weight,
  });

  String age;
  String email;
  String fullName;
  String gender;
  String height;
  String isoleuocine;
  String leucine;
  String userId;
  String valine;
  String weight;

  factory TUser.fromJson(Map<String, dynamic> json) => TUser(
    age: json["age"],
    email: json["email"],
    fullName: json["full-name"],
    gender: json["gender"],
    height: json["height"],
    isoleuocine: json["isoleuocine"],
    leucine: json["leucine"],
    userId: json["user-id"],
    valine: json["valine"],
    weight: json["weight"],
  );

  Map<String, dynamic> toJson() => {
    "age": age,
    "email": email,
    "full-name": fullName,
    "gender": gender,
    "height": height,
    "isoleuocine": isoleuocine,
    "leucine": leucine,
    "user-id": userId,
    "valine": valine,
    "weight": weight,
  };
}
