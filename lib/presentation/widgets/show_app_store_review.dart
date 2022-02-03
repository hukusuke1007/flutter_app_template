import 'dart:io';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:app_review/app_review.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_template/utils/constants.dart';
import 'package:flutter_app_template/utils/logger.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:launch_review/launch_review.dart';

import '../../model/repositories/shared_preferences/shared_preference_key.dart';
import '../../model/repositories/shared_preferences/shared_preference_repository.dart';
import '../../utils/constants.dart';
import '../../utils/logger.dart';

final reviewAppProvider = Provider<ReviewApp>((ref) => ReviewApp(ref.read));

Future<void> showAppStoreReview(
  BuildContext context,
  Reader read,
) async {
  final reviewApp = read(reviewAppProvider);
  final reviewed = await reviewApp.fetchReviewed();
  if (reviewed) {
    logger.info('No showing review. already reviewed');
    return;
  }
  final showingDateAt = await reviewApp.fetchShowingReviewAt();
  final now = DateTime.now();
  if (showingDateAt != null && showingDateAt.isAfter(now)) {
    logger.info('No showing review. showingDateAt: $showingDateAt');
    return;
  }
  await reviewApp.saveShowingReviewAt(now.add(const Duration(days: 2)));
  if (Platform.isIOS) {
    await AppReview.requestReview;
  } else {
    final dialogResult = await showOkCancelAlertDialog(
      context: context,
      title: 'アプリレビューのお願い',
      message: 'ご利用ありがとうございます。開発者の励みになりますのでぜひレビューをお願いします。',
      barrierDismissible: false,
      okLabel: 'レビューする',
      cancelLabel: 'あとで',
    );
    if (dialogResult == OkCancelResult.ok) {
      await reviewApp.reviewed();
      await LaunchReview.launch(
        androidAppId: androidId,
        iOSAppId: appleId,
        writeReview: true,
      );
    }
  }
}

class ReviewApp {
  ReviewApp(this._read);

  final Reader _read;

  SharedPreferencesRepository get sharedPreferencesRepository =>
      _read(sharedPreferencesRepositoryProvider);

  Future<bool> fetchReviewed() async {
    final result = await sharedPreferencesRepository
        .fetch<bool>(SharedPreferencesKey.isReviewedAppStore);
    return result ?? false;
  }

  Future<void> reviewed() async {
    await sharedPreferencesRepository.save(
        SharedPreferencesKey.isReviewedAppStore, true);
  }

  Future<DateTime?> fetchShowingReviewAt() async {
    final result = await sharedPreferencesRepository
        .fetch<int>(SharedPreferencesKey.showingReviewAt);
    if (result == null) {
      return null;
    }
    return DateTime.fromMillisecondsSinceEpoch(result);
  }

  Future<void> saveShowingReviewAt(DateTime dateTime) async {
    await sharedPreferencesRepository.save(
        SharedPreferencesKey.showingReviewAt, dateTime.millisecondsSinceEpoch);
  }
}
