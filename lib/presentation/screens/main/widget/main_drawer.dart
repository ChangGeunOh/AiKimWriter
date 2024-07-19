import 'package:flutter/material.dart';

import '../../../../common/const/color.dart';
import '../bloc/main_event.dart';
import 'drawer_list_bottom_item.dart';
import 'drawer_list_header.dart';
import 'drawer_list_item.dart';

class MainDrawer extends StatelessWidget {
  final Function(MainEvent) onTap;

  const MainDrawer({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 250,
            width: double.infinity,
            child: DrawerHeader(
              decoration: const BoxDecoration(
                color: primaryColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 48,
                    backgroundColor: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Image.asset(
                        'assets/images/img_launcher.png',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                    'AI 김작가',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                const DrawerListHeader(text: 'AUTHENTICATION'),
                DrawerListItem(
                  title: "비밀번호 변경",
                  iconData: Icons.lock_outline,
                  onTap: () {
                    onTap(MainEvent.onPassword);
                  },
                ),
                DrawerListItem(
                  title: "인증방법 변경",
                  iconData: Icons.password_rounded,
                  onTap: () {
                    onTap(MainEvent.onAuthMethod);
                  },
                ),
                const SizedBox(height: 24),
                const DrawerListHeader(text: 'INFORMATION'),
                DrawerListItem(
                  title: "공지사항",
                  iconData: Icons.notifications_outlined,
                  onTap: () {
                    onTap(MainEvent.onNotice);
                  },
                ),
                DrawerListItem(
                  title: "오픈소스 라이선스",
                  iconData: Icons.code_outlined,
                  onTap: () {
                    onTap(MainEvent.onOpenSource);
                  },
                ),
                DrawerListItem(
                  title: "App 정보",
                  iconData: Icons.info_outline,
                  onTap: () {
                    onTap(MainEvent.onAppInfo);
                  },
                ),
              ],
            ),
          ),
          DrawerListBottomItem(
            title: 'Logout',
            onTap: () {
              onTap(MainEvent.onLogout);
            },
          )
        ],
      ),
    );
  }
}
