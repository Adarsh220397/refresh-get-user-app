import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:refresh_get_user/src/services/model/user_details.dart';

class LocationService {
  LocationService._internal();
  static LocationService instance = LocationService._internal();

  Future<UserDetailsModel> getUserDetails() async {
    //  String city = '';

    UserDetailsModel userDetails = UserDetailsModel(
        gender: 'gender',
        firstName: '',
        lastName: '',
        locationName: '',
        city: '',
        latitude: '',
        longitude: '');
    try {
      await http
          .get(Uri.parse(
        'https://randomuser.me/api',
      ))
          .then((value) async {
        // json.decode(value.body)['results'].toString();

        print(json.decode(value.body)['results'].toString());

        userDetails.gender = json.decode(value.body)['results'][0]['gender'];
        userDetails.firstName =
            json.decode(value.body)['results'][0]['name']['first'];
        userDetails.lastName =
            json.decode(value.body)['results'][0]['name']['last'];
        userDetails.locationName =
            json.decode(value.body)['results'][0]['location']['street']['name'];
        userDetails.city =
            json.decode(value.body)['results'][0]['location']['city'];
        userDetails.latitude = json.decode(value.body)['results'][0]['location']
            ['coordinates']['latitude'];
        userDetails.longitude = json.decode(value.body)['results'][0]
            ['location']['coordinates']['longitude'];

        print(userDetails.gender);
        print(userDetails.firstName);
        print(userDetails.lastName);
        print(userDetails.latitude);
        print(userDetails.longitude);
        print(userDetails.city);
      });
    } catch (err) {
      print(err);
    }
    return userDetails;
  }
}
