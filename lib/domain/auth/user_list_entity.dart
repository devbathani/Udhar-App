class UserListEntity {
  String name;
  String phoneNumber;
  String email;
  String upiId;
  String fcmToken;

  UserListEntity({
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.upiId,
    required this.fcmToken,
  });

  factory UserListEntity.fromJson(Map<String, dynamic> json) => UserListEntity(
        name: json["name"],
        phoneNumber: json["phoneNumber"],
        email: json["email"],
        upiId: json["upiId"],
        fcmToken: json["fcmToken"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "phoneNumber": phoneNumber,
        "email": email,
        "upiId": upiId,
        "fcmToken": fcmToken,
      };
}
