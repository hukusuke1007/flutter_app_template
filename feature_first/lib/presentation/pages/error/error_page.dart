import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../widgets/buttons/rounded_button.dart';
import '../main/main_page.dart';

class ErrorPage extends HookWidget {
  const ErrorPage({
    super.key,
  });

  static String get pageName => 'error';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ErrorPage',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'ErrorPage',
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: RoundedButton(
                width: 200,
                height: 40,
                child: const Text(
                  'Go Back',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {
                  MainPage.go(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
