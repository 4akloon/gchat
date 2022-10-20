import 'package:flutter/material.dart';
import 'package:gchat/components/app_icons_icons.dart';
import 'package:gchat/enums/message/message_sender.type.dart';
import 'package:gchat/models/message/message.model.dart';
import 'package:gchat/widgets/inputs/square_text_input.dart';

import '../../widgets/chat/chat_message.card.dart';
import '../../widgets/context_menu/app_context_menu.dart';
import '../../widgets/inputs/capsute_text_input.dart';

class UIKitView extends StatelessWidget {
  const UIKitView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Title')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ElevatedButton(
            onPressed: () {},
            child: const Text('Hello'),
          ),
          const SizedBox(height: 16),
          ChatMessageCard(
            message: MessageModel(text: 'Message'),
          ),
          const SizedBox(height: 16),
          ChatMessageCard(
            message: MessageModel(text: 'Message'),
            sender: MessageSenderType.isMe,
          ),
          const SizedBox(height: 16),
          AppContextMenu(
            actions: [
              Material(
                color: Colors.transparent,
                child: AppContextMenuAction(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  leading: AppIcons.curve_line_left_up,
                  child: const Text('Copy'),
                ),
              ),
              AppContextMenuAction(
                onPressed: () {
                  Navigator.pop(context);
                },
                leading: AppIcons.thread_reply,
                child: const Text('Share  '),
              ),
              AppContextMenuAction(
                onPressed: () {
                  Navigator.pop(context);
                },
                leading: AppIcons.delete,
                isDestructiveAction: true,
                child: const Text('Delete'),
              ),
            ],
            child: Material(
              color: Colors.transparent,
              child: ChatMessageCard(
                message: MessageModel(
                    text:
                        '“Attractive people doing attractive things in attractive places” '),
                sender: MessageSenderType.isNotMe,
              ),
            ),
          ),
          const SizedBox(height: 16),
          CapsuleTextInput(
            controller: TextEditingController(),
            hintText: 'Search',
            prefixIcon: AppIcons.search,
          ),
          const SizedBox(height: 16),
          SquareTextInput(
            controller: TextEditingController(),
            labelText: 'Search',
            onChange: (v) {},
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
