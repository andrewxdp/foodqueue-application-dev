class UserData {
  final String username;
  final String email;
  final List<ProfileData> profileData;

  // Constructor
  UserData(this.username, this.email, this.profileData);

  // json --> object
  UserData.fromJson(Map<String, dynamic> json)
      : username = json['username'],
        email = json['email'],
        profileData = (json['profileData'] as List)
            .map((profileJson) => ProfileData.fromJson(profileJson))
            .toList();

  // object --> json
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'profileData': profileData.map((profile) => profile.toJson()).toList(),
    };
  }
}

class ProfileData {
  final String? profileImage;
  final String? email;
  final String? description;

  // Constructor
  ProfileData(
      {required this.profileImage,
      required this.email,
      required this.description});

  // json --> object
  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
        profileImage: json['profileImage'],
        email: json['email'],
        description: json['description']);
  }

  // object --> json
  Map<String, dynamic> toJson() {
    return {
      'profileImage': profileImage,
      'email': email,
      'description': description
    };
  }
}
