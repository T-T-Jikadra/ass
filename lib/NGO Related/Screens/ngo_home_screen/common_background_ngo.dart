// ignore_for_file: camel_case_types, non_constant_identifier_names, depend_on_referenced_packages

import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../Admin Related/alert/alert_details_screen.dart';
import '../../../Citizen Related/Screens/citizen_request_screen/citizen_request_screen.dart';
import '../../../Components/Notification_related/notification_services.dart';
import 'package:intl/intl.dart';
import '../../../Utils/Utils.dart';

class commonbg_ngo extends StatefulWidget {
  const commonbg_ngo({super.key});

  @override
  State<commonbg_ngo> createState() => _commonbg_ngoState();
}

class _commonbg_ngoState extends State<commonbg_ngo> {
  NotificationServices notificationServices = NotificationServices();
  String fetchedState = "";
  String fetchedCity = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchNGOData();
    //for notification permission pop up
    notificationServices.requestNotificationPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //Just remove the 3 Positioned widgets as soon as possible
        // Positioned(
        //     width: MediaQuery.of(context).size.width * 1.7,
        //     bottom: 200,
        //     left: 100,
        //     child: Image.asset("assets/Backgrounds/Spline.png")),
        // Positioned.fill(
        //   child: BackdropFilter(
        //     filter: ImageFilter.blur(sigmaX: 78, sigmaY: 78),
        //   ),
        // ),
        // const RiveAnimation.asset("assets/RiveAssets/shapes.riv"),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
            child: const SizedBox(),
          ),
        ),

        //home page starts from here
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 80, top: 20),
              child: Row(
                children: [
                  const Image(
                      image: AssetImage("assets/images/logo.png"),
                      width: 33,
                      height: 33),
                  const Icon(Icons.location_on_outlined,
                      color: Colors.redAccent, size: 18),
                  const SizedBox(width: 8),
                  Text(
                    "$fetchedCity, $fetchedState",
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            //latest alert
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: const Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Latest Alerts :",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("clc_alert")
                  //.where("contactNumber", isEqualTo: mobileNo)
                      .orderBy('sentTime', descending: true)
                      .limit(5)
                      .snapshots(),
                  builder: (context, snapshot) {
                    //.where("city", isEqualTo: widget.selectedCity)
                    if (snapshot.connectionState ==
                        ConnectionState.active) {
                      if (snapshot.hasData) {
                        return Padding(
                            padding: const EdgeInsets.only(
                                left: 7, right: 7, top: 10),
                            child: snapshot.data!.docs.isEmpty
                                ? const Center(
                              child: Text(
                                'No records found for an alert !',
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                            )
                                : SizedBox(
                              height: 220,
                              width: double.infinity,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  String level = snapshot
                                      .data!.docs[index]['level'];
                                  Color cardColor =
                                  getColorForLevel(level);
                                  //snapshot.data!.docs[index]['sentTime'];
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        PageRouteBuilder(
                                          pageBuilder: (context,
                                              animation,
                                              secondaryAnimation) =>
                                              Alert_Details_Screen(
                                                documentSnapshot: snapshot
                                                    .data!.docs[index],
                                              ),
                                          transitionsBuilder:
                                              (context,
                                              animation,
                                              secondaryAnimation,
                                              child) {
                                            var begin = const Offset(
                                                1.0, 0.0);
                                            var end = Offset.zero;
                                            var curve = Curves.ease;

                                            var tween = Tween(
                                                begin: begin,
                                                end: end)
                                                .chain(CurveTween(
                                                curve: curve));
                                            var offsetAnimation =
                                            animation
                                                .drive(tween);

                                            return SlideTransition(
                                              position:
                                              offsetAnimation,
                                              child: child,
                                            );
                                          },
                                        ),
                                      );
                                    },
                                    child: SizedBox(
                                      width: MediaQuery.of(context)
                                          .size
                                          .width *
                                          0.75,
                                      child: Card(
                                        color: cardColor,
                                        margin: const EdgeInsets.only(
                                            bottom: 13,
                                            left: 7,
                                            right: 7),
                                        // Set margin to zero to remove white spaces
                                        elevation: 3,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(
                                              15),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment
                                              .start,
                                          children: [
                                            Padding(
                                              padding:
                                              const EdgeInsets
                                                  .symmetric(
                                                  vertical: 5,
                                                  horizontal: 7),
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment
                                                    .start,
                                                children: [
                                                  ListTile(
                                                    leading:
                                                    CircleAvatar(
                                                      maxRadius: 14,
                                                      backgroundColor:
                                                      Colors.grey,
                                                      child: Text(
                                                          "${index + 1}"),
                                                    ),
                                                    //textColor: Colors.white,
                                                    title: Column(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .start,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        Text(
                                                            snapshot.data!
                                                                .docs[index]
                                                            [
                                                            'typeofDisaster'],
                                                            style:
                                                            const TextStyle(
                                                              fontSize:
                                                              15,
                                                              color: Colors
                                                                  .black,
                                                            )),
                                                        const SizedBox(
                                                            height:
                                                            3),
                                                        Text(
                                                            "${snapshot.data!.docs[index]['state']} \t"
                                                                " ${snapshot.data!.docs[index]['city']}",
                                                            style:
                                                            const TextStyle(
                                                              color: Colors
                                                                  .black,
                                                              fontSize:
                                                              13,
                                                            )),

                                                        // Text(
                                                        //   snapshot.data!.docs[index]
                                                        //       ['userName'],
                                                        //   style: TextStyle(
                                                        //
                                                        //     fontWeight: FontWeight.w700,
                                                        //     color: Colors.black
                                                        //         .withOpacity(0.6),
                                                        //   ),
                                                        // ),
                                                      ],
                                                    ),
                                                  ),
                                                  //const SizedBox(height: 4),
                                                  // Padding(
                                                  //   padding:
                                                  //       const EdgeInsets.symmetric(
                                                  //           horizontal: 3),
                                                  //   child: Row(
                                                  //     children: [
                                                  //       const Text("Request type : ",
                                                  //           style: TextStyle(
                                                  //               fontWeight:
                                                  //                   FontWeight.bold)),
                                                  //       Text(
                                                  //           snapshot.data!.docs[index]
                                                  //               ['neededService'],
                                                  //           style: const TextStyle(
                                                  //               color: Colors.black)),
                                                  //     ],
                                                  //   ),
                                                  // ),
                                                  const SizedBox(height: 10),
                                                  const Divider(height: 2,color: Colors.black54),
                                                  const SizedBox(height: 10),
                                                  Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                                    child: SizedBox(
                                                      width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                          0.65,
                                                      child: Text(
                                                          snapshot.data!.docs[index]['description'],
                                                          maxLines: 5,
                                                          overflow: TextOverflow.ellipsis,
                                                          style: const TextStyle(
                                                              fontSize: 15)),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                      height: 5),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets
                                                        .only(
                                                        left: 15,
                                                        top: 5),
                                                    child: Row(
                                                      children: [
                                                        const Text(
                                                          "Level : ",
                                                          style:
                                                          TextStyle(
                                                            color: Colors
                                                                .black,
                                                          ),
                                                        ),
                                                        Text(
                                                            snapshot.data!
                                                                .docs[index]
                                                            [
                                                            'level'],
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                FontWeight.bold)),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                      height: 4),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets
                                                        .only(
                                                        right: 10,
                                                        bottom:
                                                        3),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .end,
                                                      children: [
                                                        //const Text("City : ",style: TextStyle(fontWeight: FontWeight.bold)),
                                                        const Icon(Icons.watch_later_outlined,size: 16),
                                                        const SizedBox(width: 3),
                                                        Text(
                                                            DateFormat('dd-MM-yyyy , HH:mm').format(DateTime.parse(snapshot
                                                                .data!
                                                                .docs[index]
                                                            [
                                                            'sentTime'])),
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .black54,
                                                                fontSize:
                                                                12)),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ));
                      }
                    } else if (snapshot.hasError) {
                      showToastMsg(snapshot.hasError.toString());
                    } else {
                      return const Center(
                          child: CircularProgressIndicator());
                    }
                    return const Center(child: CircularProgressIndicator());
                  }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Container(
                height: 150,
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: Colors.black12,
                ),
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    "Temsting",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                child: const Text("It's NGO Home Page"),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const userRequest_Screen()));
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> fetchNGOData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      // Fetch data from Firestore
      DocumentSnapshot GovtSnapshot = await FirebaseFirestore.instance
          .collection('clc_ngo')
          .doc(user?.email)
          .get();

      // Check if the document exists
      if (GovtSnapshot.exists) {
        // Access the fields from the document
        setState(() {
          fetchedState = GovtSnapshot.get('state');
          fetchedCity = GovtSnapshot.get('city');
        });
      } else {
        if (kDebugMode) {
          print('Document does not exist');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching user data: $e');
      }
    }
  }
}
