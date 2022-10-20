import 'package:flutter/material.dart';

import '../../components/app_icons_icons.dart';
import '../../styles/styles.dart';
import '../chats/chats.tab.dart';
import '../contacts/contacts.tab.dart';
import '../ui_kit/ui_kit.view.dart';

class MainView extends StatefulWidget {
  static const String name = 'MainView';
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  late final PageController _pageController;
  late int _currentPage;

  @override
  void initState() {
    _currentPage = 1;
    _pageController = PageController(initialPage: _currentPage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: const [
          ContactsTab(),
          ChatsTab(),
          UIKitView(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPage,
        onTap: (i) {
          _pageController.jumpToPage(i);
          setState(() => _currentPage = i);
        },
        selectedFontSize: 12,
        unselectedFontSize: 12,
        selectedItemColor: AppColors.of(context).black,
        unselectedItemColor: AppColors.of(context).grey,
        selectedLabelStyle: AppTextStyles.footnoteBold,
        unselectedLabelStyle: AppTextStyles.footnoteBold,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(AppIcons.user),
            label: 'Contacts',
          ),
          BottomNavigationBarItem(
            icon: Icon(AppIcons.message),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon: Icon(AppIcons.mention),
            label: 'Mentions',
          ),
        ],
      ),
    );
  }
}
