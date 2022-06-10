import 'package:dio/dio.dart';

const baseHeader = {
  'Content-Type': 'application/json',
};

final dioDefaultOptions = BaseOptions(
  headers: baseHeader,
  connectTimeout: 30 * 1000,
  receiveTimeout: 30 * 1000,
  sendTimeout: 30 * 1000,
);
