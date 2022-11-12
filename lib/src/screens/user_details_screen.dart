import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:refresh_get_user/src/services/model/user_details.dart';

import 'new_home_screen.dart';

class UserDetailsScreen extends StatefulWidget {
  UserDetailsModel? user;
  List<UserDetailsModel>? maleUserList;
  List<UserDetailsModel>? femaleUserList;

  UserDetailsScreen(
      {super.key, required this.user, this.maleUserList, this.femaleUserList});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  late ThemeData themeData;
  @override
  Widget build(BuildContext context) {
    themeData = Theme.of(context);
    return WillPopScope(
      onWillPop: () async {
        print(widget.femaleUserList);
        return await Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => NewHomeScreen(
                      user: widget.user,
                      femaleUserList: widget.femaleUserList,
                      maleUserList: widget.maleUserList,
                      bNavi: true,
                    )),
            (Route<dynamic> route) => false);
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text('USER DETAILS'),
            backgroundColor: Colors.black,
          ),
          body: SafeArea(child: KeyboardDismissOnTap(child: userDetailsUI()))),
    );
  }

  Widget userDetailsUI() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          color: Colors.black,
          child: Container(
              padding: const EdgeInsets.all(8),
              //  height: 400,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.user!.firstName,
                        style: themeData.textTheme.titleLarge!
                            .copyWith(color: Colors.white),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        widget.user!.lastName,
                        style: themeData.textTheme.titleLarge!
                            .copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Colors.grey,
                        size: 24.0,
                      ),
                      Text(
                        widget.user!.locationName,
                        style: themeData.textTheme.titleMedium!
                            .copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_city,
                        color: Colors.grey,
                        size: 24.0,
                      ),
                      Text(
                        widget.user!.city,
                        style: themeData.textTheme.titleLarge!
                            .copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        'Latitude : ',
                        style: themeData.textTheme.titleLarge!
                            .copyWith(color: Colors.white),
                      ),
                      Text(
                        widget.user!.longitude,
                        style: themeData.textTheme.titleLarge!
                            .copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Text(
                        'Longitude : ',
                        style: themeData.textTheme.titleLarge!
                            .copyWith(color: Colors.white),
                      ),
                      Text(
                        widget.user!.latitude,
                        style: themeData.textTheme.titleLarge!
                            .copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'Gender : ',
                        style: themeData.textTheme.titleLarge!
                            .copyWith(color: Colors.white),
                      ),
                      Text(
                        widget.user!.gender,
                        style: themeData.textTheme.titleLarge!
                            .copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
