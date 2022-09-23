import 'package:mobx/mobx.dart';
import 'package:sms_listener/models/config_model.dart';
import 'package:sms_listener/repository/config_repository.dart';

part 'config_store.g.dart';

enum StoreState { initial, loading, loaded }

class ConfigStore extends _ConfigStoreBase with _$ConfigStore {
  ConfigStore(ConfigRepository configRepository) : super(configRepository);
}

abstract class _ConfigStoreBase with Store {
  final ConfigRepository _repository;

  _ConfigStoreBase(this._repository);

  @observable
  ConfigModel config = ConfigModel.emptyConfig();

  @observable
  ObservableFuture<ConfigModel>? _configFuture;

  @computed
  StoreState get state {
    if (_configFuture == null) {
      return StoreState.initial;
    }
    return _configFuture!.status == FutureStatus.pending
        ? StoreState.loading
        : StoreState.loaded;
  }

  @action
  Future getConfig() async {
    _configFuture = ObservableFuture(_repository.getSettings());

    config = await _configFuture!;
  }

  @action
  Future setConfig(String url) async {
    final newSettings = ConfigModel(url: url);
    _configFuture = ObservableFuture(_repository.saveSettings(newSettings));

    config = await _configFuture!;
  }
}
