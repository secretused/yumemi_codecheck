import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'data/repository_data.dart';
import 'main_logic.dart';

final _logicProvider = Provider<Logic>((ref) => Logic());
final _repositoryQueryProvider = StateProvider<String>((ref) => "");

AutoDisposeFutureProviderFamily<RepositoryData, String> _apiFamilyProvider =
    FutureProvider.autoDispose.family<RepositoryData, String>(
  (ref, repositoryQuery) async {
    Logic logic = ref.watch(_logicProvider);

    if (!logic.willProceed(repositoryQuery)) {
      return RepositoryData.empty;
    }

    return await logic.getRepositoryData(repositoryQuery);
  },
);

class MainPageVM {
  late final WidgetRef _ref;
  String get repositoryData => _ref.watch(_repositoryQueryProvider);

  AsyncValue<RepositoryData> repositoryDataWithFamily(String repositoryData) =>
      _ref.watch(_apiFamilyProvider(repositoryData));

  void setRef(WidgetRef ref) {
    this._ref = ref;
  }

  // Pageで入力されたValueが入る
  void onPostalCodeChaged(String repositoryQuery) {
    _ref
        .read(_repositoryQueryProvider.notifier)
        .update((state) => repositoryQuery);
  }
}
