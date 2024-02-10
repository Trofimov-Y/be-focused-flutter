import 'package:auto_route/annotations.dart';
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:be_focused/app/extensions/context_extensions.dart';
import 'package:be_focused/app/widgets/material/app_bar_with_blur.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:icons_plus/icons_plus.dart';

@RoutePage()
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBarWithBlur.medium(
            elevation: 0,
            scrolledUnderElevation: 0,
            titleSpacing: 12,
            backgroundColor: context.colors.onBackground,
            title: Text(
              'Settings',
              style: TextStyle(fontWeight: FontWeight.bold, color: context.colors.primary),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: context.colors.onSecondary)),
                ),
              ),
            ),
          ),
          SliverList.list(
            children: [
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                title: const Text('Share with friends'),
                leading: const Icon(Clarity.share_line),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
              const Gap(12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  'Account',
                  style: context.titleMedium?.bold.copyWith(color: context.colors.primary),
                ),
              ),
              const Gap(4),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                title: const Text('Log out'),
                leading: const Icon(Clarity.logout_line),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  FirebaseAuth.instance.signOut();
                },
              ),
              const Gap(12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  'Other',
                  style: context.titleMedium?.bold.copyWith(color: context.colors.primary),
                ),
              ),
              const Gap(4),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                title: const Text('Report a bug'),
                leading: const Icon(Clarity.bug_line),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                title: const Text('Privacy policy'),
                leading: const Icon(Clarity.shield_line),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                title: const Text('Terms of service'),
                leading: const Icon(Clarity.document_line),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
              const Gap(12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  'Danger zone',
                  style: context.titleMedium?.bold.copyWith(color: context.colors.primary),
                ),
              ),
              const Gap(4),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                title: const Text('Delete account', style: TextStyle(color: Colors.red)),
                leading: Icon(Clarity.trash_line, color: context.colors.onError),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
            ],
          ),
          SliverGap(24 + context.mediaQueryPadding.bottom),
        ],
      ),
    );
  }
}
