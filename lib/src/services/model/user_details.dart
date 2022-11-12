class UserDetailsModel {
  String gender;
  String firstName;
  String lastName;
  String locationName;
  String city;
  String latitude;
  String longitude;

  UserDetailsModel({
    required this.gender,
    required this.firstName,
    required this.lastName,
    required this.locationName,
    required this.city,
    required this.latitude,
    required this.longitude,
  });

  factory UserDetailsModel.fromJson(dynamic json) {
    return UserDetailsModel(
      gender: json['gender'] == null ? '' : json['gender'] as String,
      firstName: json['first'] == null ? '' : json['first'] as String,
      lastName: json['last'] == null ? '' : json['last'] as String,
      locationName: json['name'] == null ? '' : json['name'] as String,
      city: json['city'] == null ? '' : json['city'] as String,
      latitude: json['latitude'] == null ? '' : json['latitude'] as String,
      longitude: json['longitude'] == null ? '' : json['longitude'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['gender'] = gender;
    data['first'] = firstName;
    data['last'] = lastName;
    data['name'] = locationName;
    data['city'] = city;
    data['latitude'] = latitude;
    data['longitude'] = longitude;

    return data;
  }
}
