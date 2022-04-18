import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../const/constants.dart';

class RequestShimmer extends StatelessWidget {
  const RequestShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        child: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (ctx, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0, left: 20),
                          child: Container(
                            height: 150,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Constants.appColorGray,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  offset: Offset(0.0, 0.5), //(x,y)
                                  blurRadius: 6.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Constants.appColorGray,
                          ),
                        ),
                      ],
                    ),
                  );
                })),
        baseColor: Colors.grey.shade500,
        highlightColor: Colors.grey.shade200);
  }
}
