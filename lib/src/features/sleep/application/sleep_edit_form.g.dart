// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sleep_edit_form.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sleepEditFormHash() => r'4b050dff6d53f9e18270e1c262bc7344d5effe89';

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

abstract class _$SleepEditForm
    extends BuildlessAutoDisposeNotifier<SleepEditFormState> {
  late final String sessionId;

  SleepEditFormState build(String sessionId);
}

/// See also [SleepEditForm].
@ProviderFor(SleepEditForm)
const sleepEditFormProvider = SleepEditFormFamily();

/// See also [SleepEditForm].
class SleepEditFormFamily extends Family<SleepEditFormState> {
  /// See also [SleepEditForm].
  const SleepEditFormFamily();

  /// See also [SleepEditForm].
  SleepEditFormProvider call(String sessionId) {
    return SleepEditFormProvider(sessionId);
  }

  @override
  SleepEditFormProvider getProviderOverride(
    covariant SleepEditFormProvider provider,
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
  String? get name => r'sleepEditFormProvider';
}

/// See also [SleepEditForm].
class SleepEditFormProvider
    extends AutoDisposeNotifierProviderImpl<SleepEditForm, SleepEditFormState> {
  /// See also [SleepEditForm].
  SleepEditFormProvider(String sessionId)
    : this._internal(
        () => SleepEditForm()..sessionId = sessionId,
        from: sleepEditFormProvider,
        name: r'sleepEditFormProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$sleepEditFormHash,
        dependencies: SleepEditFormFamily._dependencies,
        allTransitiveDependencies:
            SleepEditFormFamily._allTransitiveDependencies,
        sessionId: sessionId,
      );

  SleepEditFormProvider._internal(
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
  SleepEditFormState runNotifierBuild(covariant SleepEditForm notifier) {
    return notifier.build(sessionId);
  }

  @override
  Override overrideWith(SleepEditForm Function() create) {
    return ProviderOverride(
      origin: this,
      override: SleepEditFormProvider._internal(
        () => create()..sessionId = sessionId,
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
  AutoDisposeNotifierProviderElement<SleepEditForm, SleepEditFormState>
  createElement() {
    return _SleepEditFormProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SleepEditFormProvider && other.sessionId == sessionId;
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
mixin SleepEditFormRef on AutoDisposeNotifierProviderRef<SleepEditFormState> {
  /// The parameter `sessionId` of this provider.
  String get sessionId;
}

class _SleepEditFormProviderElement
    extends
        AutoDisposeNotifierProviderElement<SleepEditForm, SleepEditFormState>
    with SleepEditFormRef {
  _SleepEditFormProviderElement(super.provider);

  @override
  String get sessionId => (origin as SleepEditFormProvider).sessionId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
