import 'package:flutter/material.dart';
class DonationStep1 extends StatelessWidget {
  final String id;
  const DonationStep1({
    Key? key,
    required this.id
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(id),),
    );
  }
}
