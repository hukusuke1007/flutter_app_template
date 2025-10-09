// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'start_up.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(startUp)
const startUpProvider = StartUpProvider._();

final class StartUpProvider
    extends
        $FunctionalProvider<
          AsyncValue<StartUpResultType>,
          StartUpResultType,
          FutureOr<StartUpResultType>
        >
    with
        $FutureModifier<StartUpResultType>,
        $FutureProvider<StartUpResultType> {
  const StartUpProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'startUpProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$startUpHash();

  @$internal
  @override
  $FutureProviderElement<StartUpResultType> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<StartUpResultType> create(Ref ref) {
    return startUp(ref);
  }
}

String _$startUpHash() => r'94b3363feb1a6ed30d5cf4699be5648519f7bba9';
