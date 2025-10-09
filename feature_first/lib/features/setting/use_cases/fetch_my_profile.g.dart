// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fetch_my_profile.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FetchMyProfile)
const fetchMyProfileProvider = FetchMyProfileProvider._();

final class FetchMyProfileProvider
    extends $StreamNotifierProvider<FetchMyProfile, Developer?> {
  const FetchMyProfileProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fetchMyProfileProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fetchMyProfileHash();

  @$internal
  @override
  FetchMyProfile create() => FetchMyProfile();
}

String _$fetchMyProfileHash() => r'323e431340843bd88853ab1dccdb5518ce074d27';

abstract class _$FetchMyProfile extends $StreamNotifier<Developer?> {
  Stream<Developer?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<Developer?>, Developer?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Developer?>, Developer?>,
              AsyncValue<Developer?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
