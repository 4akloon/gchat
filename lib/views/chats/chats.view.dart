// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:gchat/components/app_icons_icons.dart';
import 'package:gchat/styles/styles.dart';

import '../../widgets/conversation/conversation_tile.dart';
import '../../widgets/inputs/capsute_text_input.dart';

part 'widgets/empty_state.dart';

class ChatsView extends StatelessWidget {
  ChatsView({super.key});
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
        actions: [
          IconButton(
            padding: const EdgeInsets.all(16),
            onPressed: () {},
            icon: const Icon(AppIcons.pencil_new),
          ),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CapsuleTextInput(
              controller: controller,
              hintText: 'Search',
              prefixIcon: AppIcons.search,
            ),
          ),
          const ConversationTile(),
        ],
      ),
    );
  }
}
