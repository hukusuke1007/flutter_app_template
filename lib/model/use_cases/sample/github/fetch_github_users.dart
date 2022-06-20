import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../entities/sample/github/user.dart';
import '../../../repositories/api/github_api/github_api_repository.dart';

final fetchGithubUsersProviders =
    FutureProvider.family.autoDispose<List<User>, int>(
  (ref, offset) async {
    final items = await ref.watch(githubApiRepositoryProvider).fetchUsers(
          since: offset,
          perPage: 20,
        );
    return items;
  },
);
