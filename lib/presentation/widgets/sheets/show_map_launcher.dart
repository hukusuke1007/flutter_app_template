import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:map_launcher/map_launcher.dart';

import '../../../extensions/context_extension.dart';
import '../../../utils/vibration.dart';

enum AppMapType {
  apple,
  google,
}

Future<void> showMapLauncher(
  BuildContext context,
  String title,
  double latitude,
  double longitude,
) async {
  unawaited(Vibration.select());
  final maps = (await MapLauncher.installedMaps).where(
    (element) =>
        element.mapType == MapType.google || element.mapType == MapType.apple,
  );
  await showLocationMapBottomSheet(
    context,
    title,
    latitude,
    longitude,
    google:
        maps.firstWhereOrNull((element) => element.mapType == MapType.google),
    apple: maps.firstWhereOrNull((element) => element.mapType == MapType.apple),
  );
}

Future<void> showLocationMapBottomSheet(
  BuildContext context,
  String title,
  double latitude,
  double longitude, {
  AvailableMap? google,
  AvailableMap? apple,
}) async {
  final mapList = <Widget>[
    if (google != null)
      ListTile(
        leading: SvgPicture.asset(
          google.icon,
          width: 40,
          height: 40,
        ),
        title: const Text('GoogleMapで開く'),
        onTap: () {
          MapLauncher.showMarker(
            mapType: MapType.google,
            coords: Coords(
              latitude,
              longitude,
            ),
            title: title,
          );
          Future.delayed(const Duration(milliseconds: 1000), () {
            Navigator.of(context).pop();
          });
        },
      ),
    if (apple != null)
      ListTile(
        leading: SvgPicture.asset(
          apple.icon,
          width: 32,
          height: 32,
        ),
        title: const Text('Appleマップで開く'),
        onTap: () {
          MapLauncher.showMarker(
            mapType: MapType.apple,
            coords: Coords(
              latitude,
              longitude,
            ),
            title: title,
          );
          Future.delayed(const Duration(milliseconds: 1000), () {
            Navigator.of(context).pop();
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8)
                          .copyWith(top: 12),
                  child: Text(
                    '「$title」を確認する',
                    style: context.smallStyle
                        .copyWith(fontWeight: FontWeight.bold),
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
