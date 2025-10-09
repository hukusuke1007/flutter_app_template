// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PostController)
const postControllerProvider = PostControllerFamily._();

final class PostControllerProvider
    extends $AsyncNotifierProvider<PostController, Post?> {
  const PostControllerProvider._({
    required PostControllerFamily super.from,
    required ({String? posterId, String? postId}) super.argument,
  }) : super(
         retry: null,
         name: r'postControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$postControllerHash();

  @override
  String toString() {
    return r'postControllerProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  PostController create() => PostController();

  @override
  bool operator ==(Object other) {
    return other is PostControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$postControllerHash() => r'e66146e9dff0784eb9bfc1f6e75bb466e8924060';

final class PostControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          PostController,
          AsyncValue<Post?>,
          Post?,
          FutureOr<Post?>,
          ({String? posterId, String? postId})
        > {
  const PostControllerFamily._()
    : super(
        retry: null,
        name: r'postControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  PostControllerProvider call({
    required String? posterId,
    required String? postId,
  }) => PostControllerProvider._(
    argument: (posterId: posterId, postId: postId),
    from: this,
  );

  @override
  String toString() => r'postControllerProvider';
}

abstract class _$PostController extends $AsyncNotifier<Post?> {
  late final _$args = ref.$arg as ({String? posterId, String? postId});
  String? get posterId => _$args.posterId;
  String? get postId => _$args.postId;

  FutureOr<Post?> build({required String? posterId, required String? postId});
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(posterId: _$args.posterId, postId: _$args.postId);
    final ref = this.ref as $Ref<AsyncValue<Post?>, Post?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<Post?>, Post?>,
              AsyncValue<Post?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
