class ResponseBody {
  const ResponseBody({required this.status, this.data, this.error});
  factory ResponseBody.fromJson(dynamic data) => _$fromJson(data);

  final int status;
  final dynamic data;
  final dynamic error;
  Map<String, dynamic> toJson() => _$toJson(this);
}

ResponseBody _$fromJson(dynamic data) {
  final json = Map<String, dynamic>.from(data as Map);
  return ResponseBody(
    status: json['status'] as int,
    data: json['data'] as dynamic,
    error: json['error'] as dynamic,
  );
}

Map<String, dynamic> _$toJson(ResponseBody instance) => <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'error': instance.error,
    };
