import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:refresh_get_user/src/services/model/user_details.dart';

import '../services/location/location.dart';

class NewHomeScreen extends StatefulWidget {
  const NewHomeScreen({super.key});

  @override
  State<NewHomeScreen> createState() => _NewHomeScreenState();
}

class _NewHomeScreenState extends State<NewHomeScreen> {
  UserDetailsModel userDetails = UserDetailsModel(
      gender: '',
      firstName: '',
      lastName: '',
      locationName: '',
      city: '',
      latitude: '',
      longitude: '');

  List<UserDetailsModel> maleUserList = [];
  List<UserDetailsModel> femaleUserList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: InkWell(
            onTap: () async {
              userDetails = await LocationService.instance.getUserDetails();
              if (userDetails.gender == 'male') {
                maleUserList.add(userDetails);
                setState(() {});
              } else if (userDetails.gender == 'female') {
                femaleUserList.add(userDetails);
                setState(() {});
              }
            },
            child: const Icon(Icons.update, color: Colors.white)),
        body: SafeArea(child: newHomeScreenUI()));
  }

  Widget newHomeScreenUI() {
    return Column(
      children: [
        Container(
          height: 250,
          child: SingleChildScrollView(
            child: Column(
              children: [
                for (UserDetailsModel user in maleUserList) cardUI(user)
              ],
            ),
          ),
        ),
        Container(
          height: 250,
          child: SingleChildScrollView(
            child: Column(
              children: [
                for (UserDetailsModel user in femaleUserList) cardUI(user)
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget cardUI(UserDetailsModel user) {
    return Card(
      child: Container(
          height: 250,
          color: Colors.black,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Text(
                user.firstName,
                style: TextStyle(color: Colors.white),
              ),
              Text(
                user.lastName,
                style: TextStyle(color: Colors.white),
              ),
              Text(
                user.locationName,
                style: TextStyle(color: Colors.white),
              ),
              Text(
                user.city,
                style: TextStyle(color: Colors.white),
              ),
              Text(
                user.longitude,
                style: TextStyle(color: Colors.white),
              ),
              Text(
                user.latitude,
                style: TextStyle(color: Colors.white),
              ),
            ],
          )),
    );
  }
}
