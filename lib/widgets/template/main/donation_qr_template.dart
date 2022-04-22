import 'dart:io';

import 'package:donor_app/const/constants.dart';
import 'package:donor_app/services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class DonationQrTemplate extends StatefulWidget {
  const DonationQrTemplate({Key? key}) : super(key: key);

  @override
  State<DonationQrTemplate> createState() => _DonationQrTemplateState();
}

class _DonationQrTemplateState extends State<DonationQrTemplate> {
  final qrKey = GlobalKey(debugLabel: "QR");
  QRViewController? controller;
  Barcode? barcode;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() async {
    super.reassemble();
    if (Platform.isAndroid) {
      await controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          buildQrView(context),
          Positioned(bottom: 150, child: buildResult()),
          Positioned(top: 100, child: buildControlButtons())
        ],
      ),
    );
  }

  Widget buildControlButtons() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Constants.appColorWhite.withOpacity(0.2)),
      child: Row(
        children: [
          IconButton(
              onPressed: () async {
                await controller?.toggleFlash();
                setState(() {});
              },
              icon: FutureBuilder<bool?>(
                future: controller?.getFlashStatus(),
                builder: (ctx, snapshot) {
                  if (snapshot.data != null) {
                    return Icon(
                        snapshot.data! ? Icons.flash_on : Icons.flash_off);
                  } else {
                    return Container();
                  }
                },
              )),
          SizedBox(
            width: 30,
          ),
          IconButton(
              onPressed: () async {
                await controller?.flipCamera();
                setState(() {});
              },
              icon: FutureBuilder(
                future: controller?.getCameraInfo(),
                builder: (ctx, snapshot) {
                  if (snapshot.data != null) {
                    return Icon(Icons.switch_camera);
                  } else {
                    return Container();
                  }
                },
              ))
        ],
      ),
    );
  }

  Widget buildResult() {
    print("------------------>>>>>>>${barcode?.code}");
    if (barcode != null) {
      controller?.dispose();
      var splitedList = barcode!.code.split(",");

      FirebaseServices().isValidCampaign(context, splitedList[0].trim());
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width * 0.6,
      child: Text(
        "please move your camera over the QR code".tr,
        textAlign: TextAlign.center,
        style: TextStyle(color: Constants.appColorGray),
      ),
      decoration: BoxDecoration(
          color: Constants.appColorBrownRed.withOpacity(0.3),
          borderRadius: BorderRadius.circular(10)),
    );
  }

  Widget buildQrView(BuildContext context) {
    return QRView(
      key: qrKey,
      onQRViewCreated: onQRViewCreated,
      overlay: QrScannerOverlayShape(
          cutOutSize: MediaQuery.of(context).size.width * 0.8,
          borderWidth: 10,
          borderLength: 20,
          borderRadius: 6,
          borderColor: Constants.appColorBrownRed),
    );
  }

  void onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });

    controller.scannedDataStream.listen((barcode) {
      setState(() {
        this.barcode = barcode;
      });
    });
  }
}
