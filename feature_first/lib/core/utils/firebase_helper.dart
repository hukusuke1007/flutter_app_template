import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

enum FirebaseEnvType { server, emulator }

class FirebaseHelper {
  FirebaseHelper._();

  /// エミュレータの情報取得
  static Settings getEmulatorSettings({
    int port = 8080,
    bool persistenceEnabled = false,
    bool sslEnabled = false,
  }) =>
      Settings(
        persistenceEnabled: persistenceEnabled,
        host: '${Platform.isAndroid ? '10.0.2.2' : 'localhost'}:$port',
        sslEnabled: sslEnabled,
      );

  /// FirebaseStorageのエミュレータ設定
  static Future<void> configureStorageEmulator({
    int port = 9199,
  }) =>
      FirebaseStorage.instance.useStorageEmulator(
        Platform.isAndroid ? '10.0.2.2' : 'localhost',
        port,
      );

  /// FirebaseAuthのエミュレータ設定
  static Future<void> configureAuthEmulator({
    int port = 9099,
  }) =>
      FirebaseAuth.instance.useAuthEmulator(
        Platform.isAndroid ? '10.0.2.2' : 'localhost',
        port,
      );

  /// Firebaseのエミュレータ設定
  static Future<void> configureEmulator({
    int firestorePort = 8080,
    int storagePort = 9099,
    int authPort = 9099,
  }) async {
    FirebaseFirestore.instance.settings =
        getEmulatorSettings(port: firestorePort);
    await Future.wait([
      configureStorageEmulator(port: storagePort),
      configureAuthEmulator(port: authPort),
    ]);
  }

  /// Firebaseの接続先環境
  static FirebaseEnvType get environment {
    const env = String.fromEnvironment('FIREBASE');
    if (env == 'emulator') {
      return FirebaseEnvType.emulator;
    }
    return FirebaseEnvType.server;
  }
}
