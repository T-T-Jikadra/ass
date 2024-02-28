// ignore_for_file: camel_case_types

import 'package:fff/Govt%20Body%20Related/Screens/govt_home_screen/side_menu_govt.dart';
import 'package:fff/Utils/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../Utils/rive_utils.dart';
import '../../../Components/info_card.dart';
import 'menu_govt.dart';

class SideBar_govt extends StatefulWidget {
  const SideBar_govt({super.key});

  @override
  State<SideBar_govt> createState() => _SideBar_govtState();
}

class _SideBar_govtState extends State<SideBar_govt> {
  Menu_govt selectedSideMenu = sidebarMenus.first;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: 288,
        height: double.infinity,
        decoration: const BoxDecoration(
          //color: Colors.blueGrey,
          //light purple
          //color: Color(0xFF9999db),
          //dark bluish
          color: Sidebar_BG,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(25), bottomRight: Radius.circular(25)),
        ),
        child: DefaultTextStyle(
          style: const TextStyle(color: Colors.white),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => {
                  },
                  child: const InfoCard(
                    name: "User type :",
                    bio: "Government Agency...",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24, top: 32, bottom: 16),
                  child: Text(
                    "Browse".toUpperCase(),
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.white70),
                  ),
                ),
                ...sidebarMenus
                    .map((menu_govt) => SideMenu_govt(
                          menu: menu_govt,
                          selectedMenu: selectedSideMenu,

                          //on tap routes ..
                          press: () async {
                            RiveUtils.chnageSMIBoolState(menu_govt.rive.status!);
                            setState(() {
                              selectedSideMenu = menu_govt;
                            });
                            //extra (for testing only)
                            await Future.delayed(
                                const Duration(milliseconds: 500));

                            if (menu_govt.title.contains("Home")) {
                              // ignore: use_build_context_synchronously
                              // Navigator.of(context).push(
                              //   PageRouteBuilder(
                              //     pageBuilder: (context, animation,
                              //             secondaryAnimation) =>
                              //         const msgScreen(),
                              //     transitionsBuilder: (context, animation,
                              //         secondaryAnimation, child) {
                              //       var begin = const Offset(1.0, 0.0);
                              //       var end = Offset.zero;
                              //       var curve = Curves.ease;
                              //
                              //       var tween = Tween(begin: begin, end: end)
                              //           .chain(CurveTween(curve: curve));
                              //       var offsetAnimation =
                              //           animation.drive(tween);
                              //
                              //       return SlideTransition(
                              //         position: offsetAnimation,
                              //         child: child,
                              //       );
                              //     },
                              //   ),
                              // );
                            } else if (menu_govt.title.contains("Profile")) {
                              // ignore: use_build_context_synchronously
                              // Navigator.of(context).push(
                              //   PageRouteBuilder(
                              //     pageBuilder: (context, animation,
                              //             secondaryAnimation) =>
                              //         const ProfileScreen(),
                              //     transitionsBuilder: (context, animation,
                              //         secondaryAnimation, child) {
                              //       var begin = const Offset(1.0, 0.0);
                              //       var end = Offset.zero;
                              //       var curve = Curves.ease;
                              //
                              //       var tween = Tween(begin: begin, end: end)
                              //           .chain(CurveTween(curve: curve));
                              //       var offsetAnimation =
                              //           animation.drive(tween);
                              //
                              //       return SlideTransition(
                              //         position: offsetAnimation,
                              //         child: child,
                              //       );
                              //     },
                              //   ),
                              // );
                            } else if (menu_govt.title.contains("NGO")) {
                              // ignore: use_build_context_synchronously
                              // Navigator.of(context).push(
                              //   PageRouteBuilder(
                              //     pageBuilder: (context, animation,
                              //             secondaryAnimation) =>
                              //         const NGO_GA_ListScreen(),
                              //     transitionsBuilder: (context, animation,
                              //         secondaryAnimation, child) {
                              //       var begin = const Offset(1.0, 0.0);
                              //       var end = Offset.zero;
                              //       var curve = Curves.ease;
                              //
                              //       var tween = Tween(begin: begin, end: end)
                              //           .chain(CurveTween(curve: curve));
                              //       var offsetAnimation =
                              //           animation.drive(tween);
                              //
                              //       return SlideTransition(
                              //         position: offsetAnimation,
                              //         child: child,
                              //       );
                              //     },
                              //   ),
                              // );
                            } else if (menu_govt.title.contains("Req")) {
                              // ignore: use_build_context_synchronously
                              // Navigator.of(context).push(
                              //   PageRouteBuilder(
                              //     pageBuilder: (context, animation,
                              //             secondaryAnimation) =>
                              //         const Request_History_Screen(),
                              //     transitionsBuilder: (context, animation,
                              //         secondaryAnimation, child) {
                              //       var begin = const Offset(1.0, 0.0);
                              //       var end = Offset.zero;
                              //       var curve = Curves.ease;
                              //
                              //       var tween = Tween(begin: begin, end: end)
                              //           .chain(CurveTween(curve: curve));
                              //       var offsetAnimation =
                              //           animation.drive(tween);
                              //
                              //       return SlideTransition(
                              //         position: offsetAnimation,
                              //         child: child,
                              //       );
                              //     },
                              //   ),
                              // );
                            } else if (menu_govt.title.contains("Donation")) {
                              // ignore: use_build_context_synchronously
                              // Navigator.of(context).push(
                              //   PageRouteBuilder(
                              //     pageBuilder: (context, animation,
                              //             secondaryAnimation) =>
                              //         const Donation_History_Screen(),
                              //     transitionsBuilder: (context, animation,
                              //         secondaryAnimation, child) {
                              //       var begin = const Offset(1.0, 0.0);
                              //       var end = Offset.zero;
                              //       var curve = Curves.ease;
                              //
                              //       var tween = Tween(begin: begin, end: end)
                              //           .chain(CurveTween(curve: curve));
                              //       var offsetAnimation =
                              //           animation.drive(tween);
                              //
                              //       return SlideTransition(
                              //         position: offsetAnimation,
                              //         child: child,
                              //       );
                              //     },
                              //   ),
                              // );
                            }
                            //till above
                          },
                          riveOnInit: (artboard) {
                            menu_govt.rive.status = RiveUtils.getRiveInput(artboard,
                                stateMachineName: menu_govt.rive.stateMachineName);
                          },
                        ))
                    .toList(),
                Padding(
                  padding: const EdgeInsets.only(left: 24, top: 40, bottom: 16),
                  child: Text(
                    "Others".toUpperCase(),
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.white70),
                  ),
                ),
                ...sidebarMenus2
                    .map((menu_govt) => SideMenu_govt(
                          menu: menu_govt,
                          selectedMenu: selectedSideMenu,
                          press: () async {
                            RiveUtils.chnageSMIBoolState(menu_govt.rive.status!);
                            setState(() {
                              selectedSideMenu = menu_govt;
                            });
                            await Future.delayed(
                                const Duration(milliseconds: 500));

                            if (menu_govt.title.contains("FAQ")) {
                              // ignore: use_build_context_synchronously
                              // Navigator.of(context).push(
                              //   PageRouteBuilder(
                              //     pageBuilder: (context, animation,
                              //             secondaryAnimation) =>
                              //         const FAQScreen(),
                              //     transitionsBuilder: (context, animation,
                              //         secondaryAnimation, child) {
                              //       var begin = const Offset(1.0, 0.0);
                              //       var end = Offset.zero;
                              //       var curve = Curves.ease;
                              //
                              //       var tween = Tween(begin: begin, end: end)
                              //           .chain(CurveTween(curve: curve));
                              //       var offsetAnimation =
                              //           animation.drive(tween);
                              //
                              //       return SlideTransition(
                              //         position: offsetAnimation,
                              //         child: child,
                              //       );
                              //     },
                              //   ),
                              // );
                            } else if (menu_govt.title.contains("About")) {
                              // ignore: use_build_context_synchronously
                              // Navigator.of(context).push(
                              //   PageRouteBuilder(
                              //     pageBuilder: (context, animation,
                              //             secondaryAnimation) =>
                              //         const AboutUsScreen(),
                              //     transitionsBuilder: (context, animation,
                              //         secondaryAnimation, child) {
                              //       var begin = const Offset(1.0, 0.0);
                              //       var end = Offset.zero;
                              //       var curve = Curves.ease;
                              //
                              //       var tween = Tween(begin: begin, end: end)
                              //           .chain(CurveTween(curve: curve));
                              //       var offsetAnimation =
                              //           animation.drive(tween);
                              //
                              //       return SlideTransition(
                              //         position: offsetAnimation,
                              //         child: child,
                              //       );
                              //     },
                              //   ),
                              // );
                            }else if (menu_govt.title.contains("Logout")) {
                              // ignore: use_build_context_synchronously
                              //To logs out the current user ..
                              await FirebaseAuth.instance.signOut();
                              SystemNavigator.pop();
                            }
                          },
                          riveOnInit: (artboard) {
                            menu_govt.rive.status = RiveUtils.getRiveInput(artboard,
                                stateMachineName: menu_govt.rive.stateMachineName);
                          },
                        ))
                    .toList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
