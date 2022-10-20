import 'package:flutter/material.dart';

import '../../enums/message/message_sender.type.dart';
import '../../models/message/message.model.dart';
import '../../styles/styles.dart';

class ChatMessageCard extends StatelessWidget {
  const ChatMessageCard({
    super.key,
    required this.message,
    this.sender = MessageSenderType.common,
    this.isLast = true,
  });
  final MessageModel message;
  final MessageSenderType sender;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: sender == MessageSenderType.isNotMe
            ? AppColors.of(context).white
            : AppColors.of(context).greyWhisper,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(16),
          topRight: const Radius.circular(16),
          bottomLeft: (sender == MessageSenderType.isNotMe && isLast)
              ? Radius.zero
              : const Radius.circular(16),
          bottomRight: (sender == MessageSenderType.isMe && isLast)
              ? Radius.zero
              : const Radius.circular(16),
        ),
        border: Border.all(color: AppColors.of(context).greyWhisper),
      ),
      child: message.text != null
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                message.text!,
                style: AppTextStyles.body.copyWith(
                  color: AppColors.of(context).black,
                ),
              ),
            )
          : null,
    );
  }
}
