// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sleep_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sleepSessionsHash() => r'ce2d6402e6fe3406080e02f61caaaf658f0bee06';

/// See also [sleepSessions].
@ProviderFor(sleepSessions)
final sleepSessionsProvider = AutoDisposeProvider<List<SleepSession>>.internal(
  sleepSessions,
  name: r'sleepSessionsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sleepSessionsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SleepSessionsRef = AutoDisposeProviderRef<List<SleepSession>>;
String _$sleepSessionHash() => r'2b18b5b866fae838e365413a073b62e05ecdab7d';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [sleepSession].
@ProviderFor(sleepSession)
const sleepSessionProvider = SleepSessionFamily();

/// See also [sleepSession].
class SleepSessionFamily extends Family<SleepSession?> {
  /// See also [sleepSession].
  const SleepSessionFamily();

  /// See also [sleepSession].
  SleepSessionProvider call(String id) {
    return SleepSessionProvider(id);
  }

  @override
  SleepSessionProvider getProviderOverride(
    covariant SleepSessionProvider provider,
  ) {
    return call(provider.id);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'sleepSessionProvider';
}

/// See also [sleepSession].
class SleepSessionProvider extends AutoDisposeProvider<SleepSession?> {
  /// See also [sleepSession].
  SleepSessionProvider(String id)
    : this._internal(
        (ref) => sleepSession(ref as SleepSessionRef, id),
        from: sleepSessionProvider,
        name: r'sleepSessionProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$sleepSessionHash,
        dependencies: SleepSessionFamily._dependencies,
        allTransitiveDependencies:
            SleepSessionFamily._allTransitiveDependencies,
        id: id,
      );

  SleepSessionProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    SleepSession? Function(SleepSessionRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SleepSessionProvider._internal(
        (ref) => create(ref as SleepSessionRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<SleepSession?> createElement() {
    return _SleepSessionProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SleepSessionProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SleepSessionRef on AutoDisposeProviderRef<SleepSession?> {
  /// The parameter `id` of this provider.
  String get id;
}

class _SleepSessionProviderElement
    extends AutoDisposeProviderElement<SleepSession?>
    with SleepSessionRef {
  _SleepSessionProviderElement(super.provider);

  @override
  String get id => (origin as SleepSessionProvider).id;
}

String _$sleepElapsedHash() => r'd58dccb823cd177cfaf49cb8c379c75d4dc48486';

/// See also [sleepElapsed].
@ProviderFor(sleepElapsed)
const sleepElapsedProvider = SleepElapsedFamily();

/// See also [sleepElapsed].
class SleepElapsedFamily extends Family<AsyncValue<Duration>> {
  /// See also [sleepElapsed].
  const SleepElapsedFamily();

  /// See also [sleepElapsed].
  SleepElapsedProvider call(String sessionId) {
    return SleepElapsedProvider(sessionId);
  }

  @override
  SleepElapsedProvider getProviderOverride(
    covariant SleepElapsedProvider provider,
  ) {
    return call(provider.sessionId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'sleepElapsedProvider';
}

/// See also [sleepElapsed].
class SleepElapsedProvider extends AutoDisposeStreamProvider<Duration> {
  /// See also [sleepElapsed].
  SleepElapsedProvider(String sessionId)
    : this._internal(
        (ref) => sleepElapsed(ref as SleepElapsedRef, sessionId),
        from: sleepElapsedProvider,
        name: r'sleepElapsedProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$sleepElapsedHash,
        dependencies: SleepElapsedFamily._dependencies,
        allTransitiveDependencies:
            SleepElapsedFamily._allTransitiveDependencies,
        sessionId: sessionId,
      );

  SleepElapsedProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.sessionId,
  }) : super.internal();

  final String sessionId;

  @override
  Override overrideWith(
    Stream<Duration> Function(SleepElapsedRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SleepElapsedProvider._internal(
        (ref) => create(ref as SleepElapsedRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        sessionId: sessionId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<Duration> createElement() {
    return _SleepElapsedProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SleepElapsedProvider && other.sessionId == sessionId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, sessionId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SleepElapsedRef on AutoDisposeStreamProviderRef<Duration> {
  /// The parameter `sessionId` of this provider.
  String get sessionId;
}

class _SleepElapsedProviderElement
    extends AutoDisposeStreamProviderElement<Duration>
    with SleepElapsedRef {
  _SleepElapsedProviderElement(super.provider);

  @override
  String get sessionId => (origin as SleepElapsedProvider).sessionId;
}

String _$sleepSelectedDateHash() => r'38b6abb786ba4d7f81a0ab121f7cdf64f7f15101';

/// See also [SleepSelectedDate].
@ProviderFor(SleepSelectedDate)
final sleepSelectedDateProvider =
    AutoDisposeNotifierProvider<SleepSelectedDate, DateTime>.internal(
      SleepSelectedDate.new,
      name: r'sleepSelectedDateProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$sleepSelectedDateHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SleepSelectedDate = AutoDisposeNotifier<DateTime>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
