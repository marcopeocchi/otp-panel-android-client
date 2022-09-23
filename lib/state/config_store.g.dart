// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ConfigStore on _ConfigStoreBase, Store {
  Computed<StoreState>? _$stateComputed;

  @override
  StoreState get state =>
      (_$stateComputed ??= Computed<StoreState>(() => super.state,
              name: '_ConfigStoreBase.state'))
          .value;

  late final _$configAtom =
      Atom(name: '_ConfigStoreBase.config', context: context);

  @override
  ConfigModel get config {
    _$configAtom.reportRead();
    return super.config;
  }

  @override
  set config(ConfigModel value) {
    _$configAtom.reportWrite(value, super.config, () {
      super.config = value;
    });
  }

  late final _$_configFutureAtom =
      Atom(name: '_ConfigStoreBase._configFuture', context: context);

  @override
  ObservableFuture<ConfigModel>? get _configFuture {
    _$_configFutureAtom.reportRead();
    return super._configFuture;
  }

  @override
  set _configFuture(ObservableFuture<ConfigModel>? value) {
    _$_configFutureAtom.reportWrite(value, super._configFuture, () {
      super._configFuture = value;
    });
  }

  late final _$getConfigAsyncAction =
      AsyncAction('_ConfigStoreBase.getConfig', context: context);

  @override
  Future<dynamic> getConfig() {
    return _$getConfigAsyncAction.run(() => super.getConfig());
  }

  late final _$setConfigAsyncAction =
      AsyncAction('_ConfigStoreBase.setConfig', context: context);

  @override
  Future<dynamic> setConfig(String url) {
    return _$setConfigAsyncAction.run(() => super.setConfig(url));
  }

  @override
  String toString() {
    return '''
config: ${config},
state: ${state}
    ''';
  }
}
