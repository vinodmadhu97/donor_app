import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:donor_app/const/connection_enum.dart';
import 'package:donor_app/const/custom_dialog_box.dart';
import 'package:donor_app/controllers/network_controller.dart';
import 'package:donor_app/screens/main/dash_board_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../const/auth_exception_handler.dart';
import '../const/auth_result_status_enum.dart';
import '../const/constants.dart';
import '../const/custom_snack_bar.dart';
import '../screens/auth/register_screen.dart';
import '../screens/main/donation_question_records_screen.dart';

class FirebaseServices {
  AuthResultStatus? _status;
  String? errorMsg;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  NetworkController networkController = Get.find<NetworkController>();

  Future signupDonor(
      BuildContext context, String email, String password) async {
    if (networkController.connectionStatus.value != ConnectionEnum.noInternet) {
      try {
        CustomDialogBox.buildDialogBox();

        await auth
            .createUserWithEmailAndPassword(
                email: email.trim(), password: password.trim())
            .then((value) async {
          String? token = await FirebaseMessaging.instance.getToken();
          var userId = FirebaseAuth.instance.currentUser!.uid;
          if (token != null) {
            await firestore
                .collection("fcm")
                .doc(userId)
                .set({"token": token}, SetOptions(merge: true));
          }

          HttpsCallable callable = FirebaseFunctions.instance.httpsCallable(
              "addUserRole",
              options:
                  HttpsCallableOptions(timeout: const Duration(seconds: 5)));
          var result = await callable({"email": value.user?.email});
          print("------------custom claim ${result.data.toString()}");
        });

        User? currentUser = FirebaseAuth.instance.currentUser;
        if (currentUser != null) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (ctx) => const RegisterScreen()));
          print("register");
        }
      } catch (error) {
        _status = AuthExceptionHandler.handleException(error);
        errorMsg = AuthExceptionHandler.generateExceptionMessage(_status);
        Constants().showToast(errorMsg!);
        CustomSnackBar.buildSnackBar(title: "Alert", message: errorMsg!);
      }
    } else {
      CustomSnackBar.buildSnackBar(
          title: "Connection Problem", message: "No internet Connection");
    }
  }

  Future donorLogin(String email, String password, BuildContext context) async {
    if (networkController.connectionStatus.value != ConnectionEnum.noInternet) {
      try {
        CustomDialogBox.buildDialogBox();
        await auth
            .signInWithEmailAndPassword(
          email: email,
          password: password,
        )
            .then((auth) async {
          String? token = await FirebaseMessaging.instance.getToken();
          var userId = FirebaseAuth.instance.currentUser!.uid;
          if (token != null) {
            await firestore
                .collection("fcm")
                .doc(token)
                .set({"enable": true}, SetOptions(merge: true));
          }

          auth.user?.getIdTokenResult().then((idTokenResult) {
            print(idTokenResult.claims?['donor']);
            if (idTokenResult.claims?['donor']) {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const DashBoardScreen()));
            } else {
              Navigator.of(context).pop();
              CustomSnackBar.buildSnackBar(
                  title: "Alert", message: "Invalid User name or password");
            }
          });
        });
      } catch (error) {
        Navigator.of(context).pop();
        _status = AuthExceptionHandler.handleException(error);
        errorMsg = AuthExceptionHandler.generateExceptionMessage(_status);

        CustomSnackBar.buildSnackBar(
            title: "Connection Problem", message: errorMsg!);
      }
    } else {
      CustomSnackBar.buildSnackBar(
          title: "Connection Problem", message: "No internet Connection");
    }
  }

  void registerNewDonor(
      BuildContext context,
      String donorId,
      String imgUrl,
      String name,
      String nic,
      String address,
      String phone,
      String dob,
      String gender,
      String duration,
      String termsAgree) async {
    Map<String, dynamic> userData = {
      'donorId': donorId,
      'profileUrl': imgUrl,
      'fullName': name,
      'nic': nic,
      'address': address,
      'phone': phone,
      'dob': dob,
      'gender': gender,
      'nextDonation': duration,
      'agreement': termsAgree,
      'numberOfDonation': "0",
      'nextDonationDate': "",
      'bloodGroup': "",
    };

    if (networkController.connectionStatus.value != ConnectionEnum.noInternet) {
      try {
        firestore
            .collection("donors")
            .doc(auth.currentUser?.uid)
            .set(userData)
            .then((value) => Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => DashBoardScreen())));
      } catch (e) {
        CustomSnackBar.buildSnackBar(title: "Alert", message: e.toString());
      }
    } else {
      CustomSnackBar.buildSnackBar(
          title: "Connection Problem", message: "No internet Connection");
    }
  }

  void isValidCampaign(BuildContext context, String campaignId) {
    print("-------------------->campaignId $campaignId");

    firestore
        .collection("campaigns")
        .where("campaignId", isEqualTo: campaignId)
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.length == 1) {
        var date = querySnapshot.docs[0]["date"];
        var startTime = querySnapshot.docs[0]["startTime"];
        var endTime = querySnapshot.docs[0]["endTime"];

        var modifiedStartTime = date + " $startTime:00:00";
        var modifiedEndTime = date + " $endTime:00:00";

        DateTime formattedStartDate =
            DateFormat("yyyy-MM-dd hh:mm:ss").parse(modifiedStartTime);
        DateTime formattedEndDate =
            DateFormat("yyyy-MM-dd hh:mm:ss").parse(modifiedEndTime);

        DateTime now = DateTime.now();
        print("start : $formattedStartDate");
        print("end : $formattedEndDate");
        print("now : $now");
        print(formattedStartDate.isAfter(now));
        print(formattedEndDate.isBefore(now));

        if (!formattedStartDate.isBefore(now)) {
          CustomSnackBar.buildSnackBar(
              title: "Alert", message: "Campaign will be started soon");
        } else if (!formattedEndDate.isAfter(now)) {
          CustomSnackBar.buildSnackBar(
              title: "Alert", message: "Campaign has been ended");
        } else {
          CustomSnackBar.buildSnackBar(title: "Alert", message: "Done");

          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (_) => DonationQuestionRecordsScreen(
                campaignId: querySnapshot.docs[0].id),
          ));
        }
      } else {
        CustomSnackBar.buildSnackBar(
            title: "Alert", message: "Invalid QR Code");
      }
    });
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getAssessments() {
    var assessments =
        FirebaseFirestore.instance.collection('assessments').get();
    return assessments;
  }

  Future<void> sendDonationRequest(
      {required BuildContext context,
      required String campaignId,
      required Map<String, String> assessmentResult,
      required String donorId}) async {
    if (networkController.connectionStatus.value != ConnectionEnum.noInternet) {
      firestore
          .collection("donors")
          .doc(auth.currentUser!.uid)
          .get()
          .then((value) {
        //var data = value.data();
        var donorId = value["donorId"];
        var name = value["fullName"];
        var nic = value["nic"];

        final Map<String, String> mappedData = assessmentResult;
        /* mappedData["donorId"] = donorId;
      mappedData["donorName"] = name;
      mappedData["nic"] = nic;*/

        print(mappedData);

        try {
          firestore
              .collection("campaigns")
              .doc(campaignId)
              .collection("donorRequests")
              .doc(donorId)
              .set({
            "donorId": donorId,
            "donorName": name,
            "nic": nic,
            "request": "yes"
          }).then((value) {
            firestore
                .collection("campaigns")
                .doc(campaignId)
                .collection("donorRequests")
                .doc(donorId)
                .collection("answers")
                .doc("result")
                .set(assessmentResult)
                .then((value) {
              Constants().showToast("Request Sent. please wait until Confirm");
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (ctx) => DashBoardScreen()));
            });
          });
        } catch (e) {
          Constants().showToast("Something went wrong");
          CustomSnackBar.buildSnackBar(
              title: "Alert", message: "Something went wrong");
        }
      });
    } else {
      CustomSnackBar.buildSnackBar(
          title: "Connection Problem", message: "No internet Connection");
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getDonorData(String donorId) {
    return firestore.collection('donors').doc(donorId).get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getDonorHistory(String donorId) {
    return firestore
        .collection('donors')
        .doc(donorId)
        .collection("history")
        .get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getDonationRequests() {
    return firestore
        .collection('donationRequests')
        .orderBy('publishedAt', descending: true)
        .get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getCampaignPromotions() {
    return firestore
        .collection('campaignPromo')
        .orderBy('publishedAt', descending: true)
        .get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getPosters() {
    return firestore
        .collection('posters')
        .orderBy('publishedAt', descending: true)
        .get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getLatestCampaign() {
    return firestore
        .collection('campaignPromo')
        .orderBy('publishedAt', descending: false)
        .limitToLast(1)
        .get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getLatestRequest() {
    return firestore
        .collection('donationRequests')
        .orderBy('publishedAt', descending: true)
        .limitToLast(1)
        .get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getLatestPoster() {
    return firestore
        .collection('posters')
        .orderBy('publishedAt', descending: true)
        .limitToLast(1)
        .get();
  }

  Future<void> deleteFcmToken() async {
    try {
      if (networkController.connectionStatus.value !=
          ConnectionEnum.noInternet) {
        CustomDialogBox.buildDialogBox();

        await firestore
            .collection("fcm")
            .doc(auth.currentUser!.uid)
            .delete()
            .then((value) {
          Get.back();
        });
      } else {
        CustomSnackBar.buildSnackBar(
            title: "Connection Problem", message: "No internet Connection");
      }
    } catch (e) {
      Get.back();
      CustomSnackBar.buildSnackBar(
          title: "Error", message: "Something went wrong");
    }
  }
}
