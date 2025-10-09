// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'github_api_client.dart';

// dart format off

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers,unused_element,unnecessary_string_interpolations,unused_element_parameter

class _GithubApiClient implements GithubApiClient {
  _GithubApiClient(this._dio, {this.baseUrl, this.errorLogger});

  final Dio _dio;

  String? baseUrl;

  final ParseErrorLogger? errorLogger;

  @override
  Future<List<User>> fetchUsers(int? since, int? perPage) async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'since': since,
      r'per_page': perPage,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<List<User>>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/users',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<List<dynamic>>(_options);
    late List<User> _value;
    try {
      _value = _result.data!
          .map((dynamic i) => User.fromJson(i as Map<String, dynamic>))
          .toList();
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    return _value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(String dioBaseUrl, String? baseUrl) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}

// dart format on

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(githubApiClient)
const githubApiClientProvider = GithubApiClientProvider._();

final class GithubApiClientProvider
    extends
        $FunctionalProvider<GithubApiClient, GithubApiClient, GithubApiClient>
    with $Provider<GithubApiClient> {
  const GithubApiClientProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'githubApiClientProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$githubApiClientHash();

  @$internal
  @override
  $ProviderElement<GithubApiClient> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GithubApiClient create(Ref ref) {
    return githubApiClient(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GithubApiClient value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GithubApiClient>(value),
    );
  }
}

String _$githubApiClientHash() => r'2f5294a93474bd49c96fdf3d21c009d965cc1ddd';
