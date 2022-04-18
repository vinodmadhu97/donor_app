import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../const/constants.dart';

class HomeShimmer extends StatelessWidget {
  const HomeShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.25,
                  width: MediaQuery.of(context).size.width,
                  color: Constants.appColorGray,
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
