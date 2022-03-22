import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../const/connection_enum.dart';
import '../const/custom_snack_bar.dart';

class NetworkController extends GetxController {
  Rx<ConnectionEnum> connectionStatus = ConnectionEnum.noInternet.obs;
  final Connectivity _connectivity = Connectivity();

  late StreamSubscription _streamSubscription;

  @override
  void onInit() {
    getConnectionType();
    _streamSubscription =
        _connectivity.onConnectivityChanged.listen(_updateInternetStatus);
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  Future<void> getConnectionType() async {
    var connectivityResult;
    try {
      connectivityResult = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e);
    }
    return _updateInternetStatus(connectivityResult);
  }

  _updateInternetStatus(connectivityResult) {
    switch (connectivityResult) {
      case ConnectivityResult.wifi:
        connectionStatus.value = ConnectionEnum.wifi;
        break;
      case ConnectivityResult.mobile:
        connectionStatus.value = ConnectionEnum.mobile;

        break;

      case ConnectivityResult.ethernet:
        connectionStatus.value = ConnectionEnum.mobile;
        break;
      default:
        connectionStatus.value = ConnectionEnum.noInternet;
        print("No internet");
        CustomSnackBar.buildSnackBar(
            title: "Connection Problem", message: "No internet Connection");
    }
  }
}
