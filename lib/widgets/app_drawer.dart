import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/managers/route_manager.dart';

class AppDrawer extends StatefulWidget {
  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> with WidgetsBindingObserver {
  Widget getDrawerItem(BuildContext context, DrawerItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: ListTile(
          title: Text(
            item.title,
            // style: getBoldStyle(
            //   color: ColorManager.black,
            //   fontSize: FontSize.s18,
            // ),
          ),
          leading: Icon(
            item.icon,
            color: Colors.white,
          ),
          onTap: () {
            Navigator.pushNamed(
              context,
              item.route,
            );
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<DrawerItem> drawerItems = [
      DrawerItem(
        icon: Icons.add_circle,
        title: 'Vehicles',
        route: RoutesManager.vehiclesScreen,
      ),
    ];
    return SafeArea(
      child: Drawer(
        elevation: 100.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            // gradient: Provider.of<ThemeProvider>(context).isDarkMode
            //     ? LinearGradient(colors: [
            //         ColorManager.grey,
            //         ColorManager.darkGrey,
            //       ])
            //     : LinearGradient(
            //         colors: [
            //           ColorManager.lightPrimary,
            //           ColorManager.primary,
            //         ],
            //         begin: Alignment.topLeft,
            //         end: Alignment.bottomRight,
            //       ),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          padding: EdgeInsets.only(top: 40),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Center(
                    child: Column(
                      children: [
                        // GestureDetector(
                        //   onTap: () => Navigator.pushNamed(context,
                        //       RoutesManager.userProfileEditScreenRoute),
                        //   child: (_userProvider.user as User).image == null
                        //       ? CircleAvatar(
                        //           radius: 70,
                        //           backgroundImage:
                        //               AssetImage(ImageAssets.noProfile),
                        //         )
                        //       : CircleAvatar(
                        //           radius: 70,
                        //           backgroundImage: NetworkImage(
                        //               UserHelper.userProfileImage(
                        //                   (_userProvider.user as User))),
                        //         ),
                        // ),

                        SizedBox(height: 10),
                        // Text(
                        //   (_userProvider.user as User).firstName.toString(),
                        //   style: getBoldStyle(
                        //       fontSize: FontSize.s18,
                        //       color: ColorManager.white),

                        // ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: ListView.builder(
                      itemBuilder: (context, index) {
                        return getDrawerItem(context, drawerItems[index]);
                      },
                      itemCount: drawerItems.length),
                ),
                ListTile(
                  // tileColor: ColorManager.transparent,
                  tileColor: Colors.transparent,
                  leading: Icon(
                    Icons.logout,
                    // color: Provider.of<ThemeProvider>(context).isDarkMode
                    //     ? ColorManager.whiteWithOpacity
                    //     : ColorManager.white,
                  ),
                  title: Text(
                    'Log out',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();

                    prefs.remove('accessToken');
                    prefs.remove('refreshToken');
                    prefs.remove('isFirstTime');

                    Navigator.pushReplacementNamed(
                        context, RoutesManager.authScreenRoute);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DrawerItem {
  String title;
  IconData icon;
  String route;
  DrawerItem({required this.title, required this.icon, required this.route});
}
