import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../const/constants.dart';

class HistoryShimmer extends StatelessWidget {
  const HistoryShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView.builder(
                  itemCount: 5,
                  shrinkWrap: true,
                  itemBuilder: (ctx, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                        width: MediaQuery.of(context).size.width,
                        color: Constants.appColorGray,
                      ),
                    );
                  })),
        ),
        baseColor: Colors.grey.shade500,
        highlightColor: Colors.grey.shade200);
  }
}
