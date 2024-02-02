import 'package:auto_route/annotations.dart';
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:be_focused/app/extensions/context_extensions.dart';
import 'package:be_focused/app/theme/colors.dart';
import 'package:be_focused/app/widgets/material/app_bar_with_blur.dart';
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
            backgroundColor: context.colorScheme.onBackground,
            title: Text(
              'Settings',
              style: TextStyle(fontWeight: FontWeight.bold, color: context.colorScheme.primary),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: context.colorScheme.onSecondary)),
                ),
              ),
            ),
          ),
          const SliverGap(8),
          SliverList.list(
            children: [
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                title: const Text('Share with friends'),
                leading: const Icon(Clarity.share_line),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                title: const Text('Make a suggestion'),
                leading: const Icon(Clarity.lightbulb_line),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  'General',
                  style: context.titleMedium?.bold.copyWith(color: context.colorScheme.primary),
                ),
              ),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                title: const Text('Notifications'),
                leading: const Icon(Clarity.bell_line),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                title: const Text('Start week on'),
                leading: const Icon(Clarity.calendar_line),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  'Account',
                  style: context.titleMedium?.bold.copyWith(color: context.colorScheme.primary),
                ),
              ),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                title: const Text('Subscription'),
                leading: const Icon(Clarity.crown_line),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
              const ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 12),
                title: Text('Log out'),
                leading: Icon(Clarity.logout_line),
                trailing: Icon(Icons.chevron_right),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  'Social',
                  style: context.titleMedium?.bold.copyWith(color: context.colorScheme.primary),
                ),
              ),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                title: const Text('Instagram'),
                leading: const Icon(BoxIcons.bxl_instagram),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                title: const Text('Twitter'),
                leading: const Icon(BoxIcons.bxl_twitter),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                title: const Text('Facebook'),
                leading: const Icon(BoxIcons.bxl_facebook),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                title: const Text('TikTok'),
                leading: const Icon(BoxIcons.bxl_tiktok),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {},
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  'Other',
                  style: context.titleMedium?.copyWith(color: context.colorScheme.primary),
                ),
              ),
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
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  'Danger zone',
                  style: context.titleMedium?.copyWith(color: context.colorScheme.primary),
                ),
              ),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                title: const Text('Delete account', style: TextStyle(color: Colors.red)),
                leading: Icon(Clarity.trash_line, color: context.colorScheme.onError),
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
