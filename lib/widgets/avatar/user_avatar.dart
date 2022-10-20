import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gchat/styles/styles.dart';
import 'package:gchat/widgets/avatar/online_indicator_clipper.dart';
import 'package:gchat/widgets/image/app_image.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    super.key,
    this.size = 40,
    this.imageUrl,
    this.identy = 0,
    this.online = false,
  });
  final double size;
  final String? imageUrl;
  final int identy;
  final bool online;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: OnlineIndicatorClipper(online),
          child: imageUrl != null
              ? CachedNetworkImage(
                  imageUrl: imageUrl!,
                  height: size,
                  width: size,
                  fit: BoxFit.cover,
                )
              : AppImage.avatar(identy % 10)
                  .size(height: size, width: size)
                  .fit(BoxFit.cover),
        ),
        if (online)
          Positioned(
            right: 1,
            bottom: 0,
            child: CircleAvatar(
              backgroundColor: AppColors.of(context).accentGreen,
              radius: 5,
            ),
          )
      ],
    );
  }
}
