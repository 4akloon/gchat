import 'package:flutter/material.dart';

import '../../models/user/user.model.dart';
import '../../styles/styles.dart';
import '../avatar/user_avatar.dart';

class UserTile extends StatelessWidget {
  const UserTile({
    Key? key,
    required this.user,
    this.onTap,
  }) : super(key: key);
  final UserModel user;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: Row(
            children: [
              UserAvatar(identy: user.id.hashCode),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      user.fullName,
                      style: AppTextStyles.bodyBold.withColor(
                        AppColors.of(context).black,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (user.bio != null)
                      Text(
                        user.bio!,
                        style: AppTextStyles.footnote.withColor(
                          AppColors.of(context).grey,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
