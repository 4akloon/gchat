import 'package:flutter/material.dart';
import 'package:gchat/widgets/avatar/user_avatar.dart';

import '../../components/app_icons_icons.dart';
import '../../styles/styles.dart';

class ConversationTile extends StatelessWidget {
  const ConversationTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: Row(
            children: [
              const UserAvatar(online: true),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Daniel Atkins',
                      style: AppTextStyles.bodyBold
                          .withColor(AppColors.of(context).black),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'The weather will be perfect for the text text text text text text text text text text',
                      style: AppTextStyles.footnote
                          .copyWith(color: AppColors.of(context).grey),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Text(
                        '11:24 PM',
                        style: AppTextStyles.footnote
                            .copyWith(color: AppColors.of(context).grey),
                      ),
                      Icon(
                        AppIcons.check_all,
                        size: 16,
                        color: AppColors.of(context).accentBlue,
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.of(context).accentRed,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      '80',
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
