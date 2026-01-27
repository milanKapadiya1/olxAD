class UserDetails {
  final String uid;
  String? email;
  String? password;
  String? location;
  String? userName;
  String? phoneNumber;

  UserDetails({
    required this.uid,
    this.email,
    this.password,
    this.location,
    this.userName,
    this.phoneNumber,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
        uid: json["uid"] ?? '',
        email: json["email"],
        password: json["password"],
        location: json["location"],
        userName: json["userName"],
        phoneNumber: json["phoneNumber"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "email": email,
        "password": password,
        "location": location,
        "userName": userName,
        "phoneNumber": phoneNumber,
      };
}
