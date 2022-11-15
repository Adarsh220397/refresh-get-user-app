import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:refresh_get_user/src/screens/user_details_screen.dart';
import 'package:refresh_get_user/src/services/model/user_details.dart';

import '../services/location/location.dart';

class NewHomeScreen extends StatefulWidget {
  UserDetailsModel? user;
  List<UserDetailsModel>? maleUserList;
  List<UserDetailsModel>? femaleUserList;
  bool? bNavi;
  NewHomeScreen(
      {super.key,
      this.user,
      this.maleUserList,
      this.femaleUserList,
      this.bNavi});

  @override
  State<NewHomeScreen> createState() => _NewHomeScreenState();
}

class _NewHomeScreenState extends State<NewHomeScreen> {
  late ThemeData themeData;
  bool isLoading = false;
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
  void initState() {
    super.initState();

    filterData();
  }

  filterData() async {
    isLoading = true;
    // if (widget.user!.gender != 'male' || widget.user!.gender != 'female') {
    //   maleUserList = widget.maleUserList!;
    //   femaleUserList = widget.femaleUserList!;
    //   isLoading = false;
    //   setState(() {});
    //   return;
    // }
    if (widget.user!.gender == 'male') {
      widget.maleUserList!.removeWhere((element) =>
          element.firstName == widget.user!.firstName &&
          element.lastName == widget.user!.lastName);
      print('--------------');
      maleUserList = widget.maleUserList!;
      femaleUserList = widget.femaleUserList!;
    } else if (widget.user!.gender == 'female') {
      widget.femaleUserList!.removeWhere((element) =>
          element.firstName == widget.user!.firstName &&
          element.lastName == widget.user!.lastName);
      maleUserList = widget.maleUserList!;
      femaleUserList = widget.femaleUserList!;
    }
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);
    return isLoading
        ? CircularProgressIndicator()
        : Scaffold(
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
                child: const Icon(Icons.update, color: Colors.black)),
            body: SafeArea(child: newHomeScreenUI()));
  }

  Widget newHomeScreenUI() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text('Male Users',
                          style: themeData.textTheme.titleLarge!
                              .copyWith(color: Colors.white)),
                      for (UserDetailsModel user in maleUserList)
                        textWidgetUI(user, Colors.black, Colors.white)
                    ],
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.height,
                color: Colors.amber,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text('Female Users',
                          style: themeData.textTheme.titleLarge),
                      for (UserDetailsModel user in femaleUserList)
                        textWidgetUI(user, Colors.white, Colors.black)
                    ],
                  ),
                ),
              ),
            ],
          ),
          // Container(
          //   color: Colors.white,
          //   height: 1,
          // ),
        ],
      ),
    );
  }

  Widget textWidgetUI(
      UserDetailsModel user, Color containerColor, Color textColor) {
    return Column(
      children: [
        Container(
          color: containerColor,
          child: ListTile(
            title: Text(
              '${user.firstName} ${user.lastName}',
              style: themeData.textTheme.titleMedium!.copyWith(
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            onTap: () async {
              bool bNavi = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => UserDetailsScreen(
                          user: user,
                          femaleUserList: femaleUserList,
                          maleUserList: maleUserList,
                        )),
              );

              print(bNavi);
              if (bNavi) {
                filterData();
              }
            },
            subtitle: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Location : ${user.locationName}',
                  style: themeData.textTheme.bodyMedium!
                      .copyWith(color: textColor),
                ),
                Text(
                  'City : ${user.city}',
                  style: themeData.textTheme.bodyMedium!
                      .copyWith(color: textColor),
                ),
                Text(
                  'Latitude : ${user.latitude}',
                  style: themeData.textTheme.bodyMedium!
                      .copyWith(color: textColor),
                ),
                Text(
                  'Longitude : ${user.longitude}',
                  style: themeData.textTheme.bodyMedium!
                      .copyWith(color: textColor),
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        )
      ],
    );
  }
}
