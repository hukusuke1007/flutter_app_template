import 'package:flutter_app_template/model/entities/github/user.dart';
import 'package:flutter_app_template/model/repositories/github_api/github_api_repository.dart';
import 'package:flutter_app_template/model/use_cases/github_users/github_users_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<GithubApiRepository>()])
import 'github_users_controller_test.mocks.dart';

void main() {
  late ProviderContainer container;
  late MockGithubApiRepository mockRepository;

  setUp(() {
    mockRepository = MockGithubApiRepository();
    container = ProviderContainer(
      overrides: [
        githubApiRepositoryProvider.overrideWithValue(mockRepository),
      ],
    );
    addTearDown(container.dispose);
  });

  group('GithubUsersController Tests', () {
    final mockUsers = [
      const User(
        id: 1,
        login: 'user1',
        avatarUrl: 'url1',
        url: 'https://api.github.com/users/user1',
      ),
      const User(
        id: 2,
        login: 'user2',
        avatarUrl: 'url2',
        url: 'https://api.github.com/users/user2',
      ),
      const User(
        id: 3,
        login: 'user3',
        avatarUrl: 'url3',
        url: 'https://api.github.com/users/user3',
      ),
    ];

    test('initial build should fetch users', () async {
      when(mockRepository.fetchUsers(since: 0, perPage: 20))
          .thenAnswer((_) async => List<User>.from(mockUsers));

      final controller = container.read(githubUsersControllerProvider.notifier);
      final result = await controller.future;

      expect(result, equals(mockUsers));
      verify(mockRepository.fetchUsers(since: 0, perPage: 20)).called(1);
    });

    test('onFetchMore should append new users', () async {
      final moreUsers = [
        const User(
          id: 4,
          login: 'user4',
          avatarUrl: 'url4',
          url: 'https://api.github.com/users/user4',
        ),
        const User(
          id: 5,
          login: 'user5',
          avatarUrl: 'url5',
          url: 'https://api.github.com/users/user5',
        ),
      ];

      when(mockRepository.fetchUsers(since: 0, perPage: 20))
          .thenAnswer((_) async => List<User>.from(mockUsers));
      when(mockRepository.fetchUsers(since: 3, perPage: 20))
          .thenAnswer((_) async => List<User>.from(moreUsers));

      final controller = container.read(githubUsersControllerProvider.notifier);
      await controller.future;

      await controller.onFetchMore();
      final result = await controller.future;

      expect(result.length, equals(5));
      expect(result, equals([...mockUsers, ...moreUsers]));
      verify(mockRepository.fetchUsers(since: 3, perPage: 20)).called(1);
    });

    test('should handle empty response', () async {
      when(mockRepository.fetchUsers(since: 0, perPage: 20))
          .thenAnswer((_) async => <User>[]);

      final controller = container.read(githubUsersControllerProvider.notifier);
      final result = await controller.future;

      expect(result, isEmpty);
      verify(mockRepository.fetchUsers(since: 0, perPage: 20)).called(1);
    });

    test('should handle error', () async {
      when(mockRepository.fetchUsers(since: 0, perPage: 20))
          .thenThrow(Exception('Network error'));

      final controller = container.read(githubUsersControllerProvider.notifier);

      expect(
        controller.future,
        throwsA(isA<Exception>()),
      );
      verify(mockRepository.fetchUsers(since: 0, perPage: 20)).called(1);
    });
  });
}
