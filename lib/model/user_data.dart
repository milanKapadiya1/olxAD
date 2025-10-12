class UserDetails {
  final String uid;
   String? email;
   String? password;
   String? location;
  UserDetails({
    required this.uid,
    this.email,
     this.password,
    this.location
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
        uid: json["uid"],
        email: json["email"],
        password: json["password"],
        location: json["location"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "email": email,
        "password": password,
        "location": location,
      };
}