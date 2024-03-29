// ignore_for_file: camel_case_types, non_constant_identifier_names, depend_on_referenced_packages

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fff/Models/alert_opened_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import '../constants.dart';

class Open_Alert_Screen extends StatefulWidget {
  final String alertId;
  final String title;
  final String desc;
  final String level;
  final String dos;
  final String donts;

  const Open_Alert_Screen({
    super.key,
    required this.alertId,
    required this.title,
    required this.desc,
    required this.level,
    required this.dos,
    required this.donts,
  });

  @override
  State<Open_Alert_Screen> createState() => _Open_Alert_ScreenState();
}

class _Open_Alert_ScreenState extends State<Open_Alert_Screen> {
  String? finalUserType = "";
  String user_id = "";
  bool isLoading = true;
  String fetchedDid = '';
  String fetchedState = '';

  String fetchedCity = '';

  String fetchedSentTime = '';

  String fetchedDos = '';
  String fetchedDonts = '';

  @override
  void initState() {
    super.initState();
    //check if its NGO or Govt
    getUserType();
    fetchAlertDetails().then((value) => fetchDos());
    Future.delayed(const Duration(milliseconds: 1100), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 50,
        backgroundColor: Colors.black12,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(25),
                bottomLeft: Radius.circular(25))),
        title: const Text("$appbar_display_name - Alert details"),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SizedBox(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      const Text("Alert Details : ",
                          style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 18,
                              color: Colors.blueGrey)),
                      const SizedBox(height: 20),
                      //show alert details
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.blueGrey.withOpacity(0.1)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(Iconsax.hierarchy_square),
                                  const SizedBox(width: 12),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text("type of Disaster :",
                                          style: TextStyle(fontSize: 13)),
                                      const SizedBox(height: 4),
                                      Text(widget.title,
                                          style: const TextStyle(fontSize: 16)),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              const Divider(height: 2),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(Iconsax.firstline),
                                  const SizedBox(width: 12),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text("Description :",
                                          style: TextStyle(fontSize: 13)),
                                      const SizedBox(height: 4),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.65,
                                        // height:
                                        //     MediaQuery.of(context).size.height * 0.3,
                                        child: Flexible(
                                          child: Text(widget.desc,
                                              maxLines: 5,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontSize: 16)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              const Divider(height: 2),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(Iconsax.buildings),
                                  const SizedBox(width: 12),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.6,
                                        child: const Text("Alert Level :",
                                            style: TextStyle(fontSize: 13)),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(widget.level,
                                          style: const TextStyle(fontSize: 16)),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              const Divider(height: 2),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(Iconsax.building_3),
                                  const SizedBox(width: 12),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text("City :",
                                          style: TextStyle(fontSize: 13)),
                                      const SizedBox(height: 4),
                                      Text(fetchedCity,
                                          style: const TextStyle(fontSize: 16)),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text("Alert time :",
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.grey)),
                                      const SizedBox(width: 4),
                                      Text(
                                          DateFormat('dd-MM-yyyy , HH:mm')
                                              .format(DateTime.parse(
                                                  fetchedSentTime)),
                                          style: const TextStyle(
                                              fontSize: 11,
                                              color: Colors.grey)),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),

                      //dos
                      const Text("Dos & Dont's  : ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17)),
                      const SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.green.withOpacity(0.3),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          child: Row(
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Iconsax.tick_circle4),
                                    const SizedBox(width: 5),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.7, // Adjust the width as needed
                                      child: Text(
                                        widget.dos,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      //donts
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.red.withOpacity(0.3)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          child: Row(
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Iconsax.shield_cross),
                                    const SizedBox(width: 5),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.7, // Adjust the width as needed
                                      child: Text(
                                        widget.donts,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  //to check usertype
  Future<void> getUserType() async {
    final SharedPreferences sharedPref = await SharedPreferences.getInstance();
    var obtainedUserType = sharedPref.getString("userType");
    setState(() {
      finalUserType = obtainedUserType;
      if (finalUserType == "Citizen") {
        fetchCitizenData().then((value) => addAlertOpenedToDatabase());
      } else if (finalUserType == "NGO") {
        //iAmNGO = 'true';
        fetchNGOData().then((value) => addAlertOpenedToDatabase());
      } else if (finalUserType == "Govt") {
        //iAmGovt = 'true';
        fetchGovtData().then((value) => addAlertOpenedToDatabase());
      }
    });
  }

  //gets data if current user is Citizen
  Future<void> fetchCitizenData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      // Fetch data from Firestore
      DocumentSnapshot citizenSnapshot = await FirebaseFirestore.instance
          .collection('clc_citizen')
          .doc(user?.phoneNumber)
          .get();

      // Check if the document exists
      if (citizenSnapshot.exists) {
        // Access the fields from the document
        setState(() {
          user_id = citizenSnapshot.get('cid');
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

  //gets data if current user is NGO
  Future<void> fetchNGOData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      // Fetch data from Firestore
      DocumentSnapshot NGOSnapshot = await FirebaseFirestore.instance
          .collection('clc_ngo')
          .doc(user?.email)
          .get();

      // Check if the document exists
      if (NGOSnapshot.exists) {
        // Access the fields from the document
        setState(() {
          user_id = NGOSnapshot.get('nid');
        });
      } else {
        if (kDebugMode) {
          print('Document does not exist');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching NGO data: $e');
      }
    }
  }

  //gets data if current user is Govt
  Future<void> fetchGovtData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      // Fetch data from Firestore
      DocumentSnapshot GovtSnapshot = await FirebaseFirestore.instance
          .collection('clc_govt')
          .doc(user?.email)
          .get();
      //print(user!.email);
      //print(GovtSnapshot.get('GovtAgencyRegNo'));

      // Check if the document exists
      if (GovtSnapshot.exists) {
        // Access the fields from the document
        setState(() {
          user_id = GovtSnapshot.get('gid');
        });
      } else {
        if (kDebugMode) {
          print('Document does not exist');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching NGO data: $e');
      }
    }
  }

//Storing alert open data to database
  void addAlertOpenedToDatabase() async {
    //for unique doc numbering
    CollectionReference alertOpenCollection =
        FirebaseFirestore.instance.collection("clc_opened_alerts");

    QuerySnapshot snapshot = await alertOpenCollection.get();
    int totalDocCount = snapshot.size;
    totalDocCount++;

    var AlertOpenDocRef = FirebaseFirestore.instance
        .collection("clc_opened_alerts")
        .doc("Alert_Open_$totalDocCount");

    Alert_Opened_Registration AlertOpenData = Alert_Opened_Registration(
      alert_open_Id: "Alert_Open_$totalDocCount",
      alert_id: "Alert_${widget.alertId}",
      user_id: user_id,
    );

    Map<String, dynamic> AlertOpenJson = AlertOpenData.toJsonOpenAlert();

    try {
      await AlertOpenDocRef.set(AlertOpenJson);
    } catch (e) {
      // An error occurred
      if (kDebugMode) {
        print('Error adding alert open document : $e');
      }
    }
  }

  void fetchDos() async {
    try {
      DocumentSnapshot dosSnap = await FirebaseFirestore.instance
          .collection('clc_dos_donts')
          .doc(fetchedDid)
          .get();
      try {
        if (dosSnap.exists) {
          fetchedDos = dosSnap.get("dos");
          fetchedDonts = dosSnap.get("donts");
        } else {
          if (kDebugMode) {
            print('Dos document does not exist');
          }
        }
      } catch (e) {
        // Handle any errors that occur during the process
        if (kDebugMode) {
          print('Error fetching dos/donts: $e');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching did : $e');
      }
    }
    return null;
  }

  Future<void> fetchAlertDetails() async {
    try {
      DocumentSnapshot alertSnap = await FirebaseFirestore.instance
          .collection('clc_alert')
          .doc("Alert_${widget.alertId}")
          .get();
      try {
        if (alertSnap.exists) {
          fetchedDid = alertSnap.get("did");
          fetchedState = alertSnap.get("state");
          fetchedCity = alertSnap.get("city");
          fetchedSentTime = alertSnap.get("sentTime");
        } else {
          if (kDebugMode) {
            print('Dos document does not exist');
          }
        }
      } catch (e) {
        // Handle any errors that occur during the process
        if (kDebugMode) {
          print('Error fetching dos/donts: $e');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching did : $e');
      }
    }
    return;
  }
}
