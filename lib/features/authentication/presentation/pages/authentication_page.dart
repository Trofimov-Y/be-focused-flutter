import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:auto_route/auto_route.dart';
import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:be_focused/app/routing/router.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:icons_plus/icons_plus.dart';

part '../widgets/_spinning_curved_text.dart';

part '../widgets/_infinity_text.dart';

// TODO(Yuriy-Trofimov): Add localizations
@RoutePage()
class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({super.key});

  @override
  Widget build(BuildContext context) {
    const fontStyle = TextStyle(fontSize: 44, fontWeight: FontWeight.bold, color: Colors.white);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(context.mqPadding.top + 110),
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('WELCOME', style: fontStyle, textScaler: TextScaler.noScaling),
                    const Text('TO', style: fontStyle, textScaler: TextScaler.noScaling),
                    const Text('BE FOCUSED', style: fontStyle, textScaler: TextScaler.noScaling),
                    Container(
                      height: 1.5,
                      width: 256,
                      color: Colors.white,
                    ),
                  ],
                ),
                const Spacer(),
                const RepaintBoundary(
                  child: _SpinningCurvedText(
                    text: '  ZERO IN ON OBJECTIVES  STAY ON TRACK',
                    textStyle: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
                    textRadius: 120,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          const SizedBox(
            height: 88,
            child: _InfinityText(style: fontStyle, text: ' Stay committed  Maintain momentum'),
          ),
          const SizedBox(
            height: 68,
            child: _InfinityText(
              style: fontStyle,
              text: ' Concentrate on progress  Embrace the grind',
            ),
          ),
          const SizedBox(height: 56),
          Container(
            height: 260,
            width: double.infinity,
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Colors.white, width: 2)),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
              ),
            ),
            child: Column(
              children: [
                const Gap(52),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 48),
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      side: const BorderSide(color: Colors.white),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32),
                      ),
                    ),
                    onPressed: () {
                      context.router.push(const HomeRoute());
                    },
                    child: Row(
                      children: [
                        const Icon(BoxIcons.bxl_google),
                        const Gap(24),
                        Text(
                          'Continue with Google'.toUpperCase(),
                          style: context.titleMedium?.copyWith(color: Colors.white),
                          textAlign: TextAlign.center,
                          textScaler: TextScaler.noScaling,
                        ).expanded(),
                      ],
                    ),
                  ),
                ),
                const Gap(24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 48),
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      side: const BorderSide(color: Colors.white),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
                    ),
                    onPressed: () => context.router.push(const HomeRoute()),
                    child: Row(
                      children: [
                        const Icon(BoxIcons.bx_user),
                        Text(
                          'Continue as guest'.toUpperCase(),
                          style: context.titleMedium?.copyWith(color: Colors.white),
                          textAlign: TextAlign.center,
                          textScaler: TextScaler.noScaling,
                        ).expanded(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
