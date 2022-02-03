import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../model/use_cases/auth/fetch_logged_in_with_anonymously.dart';
import '../../../model/use_cases/auth/sign_in_with_anonymously.dart';
import '../../../presentation/pages/main/main_page.dart';

class StartUpPage extends HookConsumerWidget {
  const StartUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      Future(() async {
        final isLoggedIn = ref.read(fetchLoggedInWithAnonymously)();
        if (!isLoggedIn) {
          await ref.read(signInWithAnonymously)();
        }
        unawaited(MainPage.show(context));
      });
      return;
    }, []);
    return const Scaffold(
      body: Center(
        child: CupertinoActivityIndicator(),
      ),
    );
  }
}
