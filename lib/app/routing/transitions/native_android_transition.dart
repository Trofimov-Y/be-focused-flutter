import 'package:flutter/material.dart';

class NativeAndroidTransition extends StatelessWidget {
  const NativeAndroidTransition({
    required this.primaryRouteAnimation,
    required this.secondaryRouteAnimation,
    required this.child,
    super.key,
  });

  final Animation<double> primaryRouteAnimation;
  final Animation<double> secondaryRouteAnimation;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: Tween<double>(
        begin: 1,
        end: 0,
      ).animate(CurvedAnimation(parent: secondaryRouteAnimation, curve: Curves.fastOutSlowIn)),
      child: SlideTransition(
        position: Tween<Offset>(
          begin: Offset.zero,
          end: const Offset(-0.25, 0),
        ).animate(CurvedAnimation(parent: secondaryRouteAnimation, curve: Curves.fastOutSlowIn)),
        child: FadeTransition(
          opacity: Tween<double>(
            begin: 0,
            end: 1,
          ).animate(CurvedAnimation(parent: primaryRouteAnimation, curve: Curves.fastOutSlowIn)),
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.25, 0),
              end: Offset.zero,
            ).animate(CurvedAnimation(parent: primaryRouteAnimation, curve: Curves.fastOutSlowIn)),
            child: child,
          ),
        ),
      ),
    );
  }
}
