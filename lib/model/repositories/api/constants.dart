import 'package:dio/dio.dart';

const baseHeader = {
  'Content-Type': 'application/json',
};

final dioDefaultOptions = BaseOptions(
  headers: baseHeader,
  connectTimeout: const Duration(seconds: 30),
  receiveTimeout: const Duration(seconds: 30),
  sendTimeout: const Duration(seconds: 30),
);
