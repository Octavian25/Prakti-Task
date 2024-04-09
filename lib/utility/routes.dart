import 'package:flutter/material.dart';
import 'package:os_basecode/os_basecode.dart';
import 'package:praktitask/home/presentation/pages/home_screen.dart';
import 'package:praktitask/onboard/presentation/pages/onboard_screen.dart';
import 'package:praktitask/search/presentation/pages/search_screen.dart';
import 'package:praktitask/utility/base_screen.dart';

final parentKey = GlobalKey<NavigatorState>();
final shellKey = GlobalKey<NavigatorState>();

GoRouter goRouter = GoRouter(navigatorKey: parentKey, initialLocation: "/onboard", routes: [
  GoRoute(
    path: "/onboard",
    builder: (context, state) => const OnboardScreen(),
  ),
  ShellRoute(
      parentNavigatorKey: parentKey,
      navigatorKey: shellKey,
      builder: (context, state, child) {
        var selectedMenu = 0;
        if (state.uri.toString().contains("home")) {
          selectedMenu = 0;
        }
        if (state.uri.toString().contains("search")) {
          selectedMenu = 1;
        }
        return BaseScreen(
          selectedMenu: selectedMenu,
          key: state.pageKey,
          child: child,
        );
      },
      routes: [
        GoRoute(
          path: "/home",
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: "/search",
          builder: (context, state) => const SearchScreen(),
        )
      ]),
]);
