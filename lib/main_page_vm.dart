import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'data/repository_data.dart';
import 'main_logic.dart';

final _logicProvider = Provider<Logic>((ref) => Logic());
final _repositoryQueryProvider = StateProvider<String>((ref) => "");
StateProvider<RepositoryDataItems> _navigationIndexProvider =
    StateProvider<RepositoryDataItems>(
  (ref) => const RepositoryDataItems(
    full_name: "",
    description: "",
    stargazers_count: 0,
    watchers_count: 0,
    language: "",
    forks_count: 0,
    open_issues_count: 0,
    owner: RepositoryDataOwner(avatar_url: ""),
  ),
);

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
  String get repositoryQuery => _ref.watch(_repositoryQueryProvider);
  RepositoryDataItems get tappedRepository =>
      _ref.watch(_navigationIndexProvider);

  AsyncValue<RepositoryData> repositoryDataWithFamily(String repositoryQuery) =>
      _ref.watch(_apiFamilyProvider(repositoryQuery));

  void setRef(WidgetRef ref) {
    _ref = ref;
  }

  // Pageで入力されたValueが入る
  void onQueryChaged(String repositoryQuery) {
    _ref
        .read(_repositoryQueryProvider.notifier)
        .update((state) => repositoryQuery);
  }

  // onTapで選択されたリストのindexを返す
  void onListTapped(RepositoryDataItems repositoryData) {
    _ref
        .read(_navigationIndexProvider.notifier)
        .update((state) => repositoryData);
  }
}
