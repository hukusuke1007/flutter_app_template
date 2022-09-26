import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_template/presentation/pages/sample/home/home_page.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../model/use_cases/auth/fetch_logged_in_with_anonymously.dart';
import '../../../model/use_cases/auth/sign_in_with_anonymously.dart';
import '../../presentation/custom_hooks/use_effect_once.dart';
import '../../utils/provider.dart';

class StartUpPage extends HookConsumerWidget {
  const StartUpPage({super.key});

  static String get pageName => 'start_up_page';
  static String get pagePath => '/';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffectOnce(() {
      Future(() async {
        final isLoggedIn = ref.read(fetchLoggedInWithAnonymouslyProvider)();
        if (isLoggedIn) {
          ref
              .read(authStateProvider.state)
              .update((state) => AuthState.signInWithAnonymously);
        } else {
          await ref.read(signInWithAnonymouslyProvider)();
        }
        print('fafafa');
        context.go(HomePage.pagePath);
      });
      return null;
    });
    return const Scaffold(
      body: Center(
        child: CupertinoActivityIndicator(),
      ),
    );
  }
}
