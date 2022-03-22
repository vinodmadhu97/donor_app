import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ShowProfileAvatar extends StatelessWidget {
  final String imagePath;

  const ShowProfileAvatar({
    Key? key,
    required this.imagePath,
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
    return CircleAvatar(
      radius: 75.0,
      child: ClipOval(
        child: CachedNetworkImage(
          height: 150,
          width: 150,
          fit: BoxFit.cover,
          imageUrl: imagePath,
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) =>
              Image.asset("assets/images/profile_avatar.jpg"),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
