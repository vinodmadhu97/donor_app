import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../const/constants.dart';

class ProfileShimmer extends StatelessWidget {
  const ProfileShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                      color: Constants.appColorGray,
                      borderRadius: BorderRadius.circular(75)),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 20,
                  width: 100,
                  decoration: BoxDecoration(
                      color: Constants.appColorGray,
                      borderRadius: BorderRadius.circular(4)),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 20,
                  width: 100,
                  decoration: BoxDecoration(
                      color: Constants.appColorGray,
                      borderRadius: BorderRadius.circular(4)),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          color: Constants.appColorGray,
                          borderRadius: BorderRadius.circular(6)),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          color: Constants.appColorGray,
                          borderRadius: BorderRadius.circular(6)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 30,
                  width: 200,
                  decoration: BoxDecoration(
                      color: Constants.appColorGray,
                      borderRadius: BorderRadius.circular(6)),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Constants.appColorGray,
                      borderRadius: BorderRadius.circular(6)),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 30,
                  width: 200,
                  decoration: BoxDecoration(
                      color: Constants.appColorGray,
                      borderRadius: BorderRadius.circular(6)),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Constants.appColorGray,
                      borderRadius: BorderRadius.circular(6)),
                ),
              ],
            ),
          ),
        ),
        baseColor: Colors.grey.shade500,
        highlightColor: Colors.grey.shade200);
  }
}
