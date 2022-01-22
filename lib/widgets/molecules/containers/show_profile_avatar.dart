import 'dart:io';
import 'package:donor_app/const/constants.dart';
import 'package:flutter/material.dart';
class ShowProfileAvatar extends StatelessWidget {
  final String? imagePath;


  const ShowProfileAvatar({
    Key? key,
    this.imagePath,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return Center(
      child: Stack(
        children: [
          buildImage(),

        ],
      ),
    );
  }

  Widget buildImage() {
    final image = imagePath == null ? AssetImage("assets/images/profile_avatar.jpg") : AssetImage(imagePath!);

    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image,
          fit: BoxFit.cover,
          width: 160,
          height: 160,
          child: InkWell(onTap: (){}),
        ),
      ),
    );
  }

}
