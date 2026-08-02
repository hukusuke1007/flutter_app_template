import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';

import '../../extensions/context_extension.dart';
import '../../utils/vibration.dart';

enum AppMapType { apple, google }

Future<void> showMapLauncher(
  BuildContext context,
  String title,
  double latitude,
  double longitude,
) async {
  Vibration.select().ignore();
  final maps =
      (await MapLauncher.marker(
        LocationCoords(latitude, longitude, title: title),
      ).getSupportedMaps([MapApp.google, MapApp.apple])).where(
        (element) => element.isInstalled,
      );
  if (!context.mounted) {
    return;
  }
  await showLocationMapBottomSheet(
    context,
    title,
    google: maps.firstWhereOrNull(
      (element) => element.map.id == MapApp.google.id,
    ),
    apple: maps.firstWhereOrNull(
      (element) => element.map.id == MapApp.apple.id,
    ),
  );
}

Future<void> showLocationMapBottomSheet(
  BuildContext context,
  String title, {
  SupportedMap? google,
  SupportedMap? apple,
}) {
  final mapList = <Widget>[
    if (google != null)
      ListTile(
        leading: Image.memory(google.iconBytes, width: 40, height: 40),
        title: const Text('GoogleMapで開く'),
        onTap: () {
          google.show().ignore();
          Future.delayed(const Duration(milliseconds: 1000), () {
            if (context.mounted) {
              Navigator.of(context).pop();
            }
          });
        },
      ),
    if (apple != null)
      ListTile(
        leading: Image.memory(apple.iconBytes, width: 32, height: 32),
        title: const Text('Appleマップで開く'),
        onTap: () {
          apple.show().ignore();
          Future.delayed(const Duration(milliseconds: 1000), () {
            if (context.mounted) {
              Navigator.of(context).pop();
            }
          });
        },
      ),
  ];

  return showModalBottomSheet<void>(
    context: context,
    builder: (context) {
      return SafeArea(
        child: Container(
          height: 64 + 52.0 * mapList.length,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ).copyWith(top: 12),
                  child: Text(
                    '「$title」を確認する',
                    style: context.smallStyle.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              ...mapList,
            ],
          ),
        ),
      );
    },
  );
}
