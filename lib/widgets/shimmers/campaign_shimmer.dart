import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../const/constants.dart';

class CampaignShimmer extends StatelessWidget {
  const CampaignShimmer({Key? key}) : super(key: key);

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
                ListView.builder(
                    itemCount: 4,
                    shrinkWrap: true,
                    itemBuilder: (ctx, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                                flex: 1,
                                child: Container(
                                  height: 150,
                                  width: 150,
                                  decoration: BoxDecoration(
                                      color: Constants.appColorGray,
                                      borderRadius: BorderRadius.circular(6)),
                                )),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 20,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          color: Constants.appColorGray,
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Container(
                                      height: 20,
                                      width: 80,
                                      decoration: BoxDecoration(
                                          color: Constants.appColorGray,
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Container(
                                      height: 20,
                                      width: 120,
                                      decoration: BoxDecoration(
                                          color: Constants.appColorGray,
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Container(
                                      height: 20,
                                      width: 150,
                                      decoration: BoxDecoration(
                                          color: Constants.appColorGray,
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      );
                    })
              ],
            ),
          ),
        ),
        baseColor: Colors.grey.shade500,
        highlightColor: Colors.grey.shade200);
  }
}
