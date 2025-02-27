import 'package:flutter_app_template/model/repositories/shared_preferences/shared_preference_repository.dart';
import 'package:flutter_app_template/model/use_cases/local_counter/local_counter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks([MockSpec<SharedPreferencesRepository>()])
import 'local_counter_test.mocks.dart';

void main() {
  late ProviderContainer container;
  late MockSharedPreferencesRepository mockRepository;

  setUp(() {
    mockRepository = MockSharedPreferencesRepository();
    container = ProviderContainer(
      overrides: [
        sharedPreferencesRepositoryProvider.overrideWithValue(mockRepository),
      ],
    );
    addTearDown(container.dispose);
  });

  group('LocalCounter Tests', () {
    test('initial build should fetch counter value', () {
      when(
        mockRepository.fetch<int>(LocalCounter.localCounterKey),
      ).thenReturn(5);

      final counter = container.read(localCounterProvider);

      expect(counter, equals(5));
      verify(mockRepository.fetch<int>(LocalCounter.localCounterKey)).called(1);
    });

    test('initial build should return 0 when no value stored', () {
      when(
        mockRepository.fetch<int>(LocalCounter.localCounterKey),
      ).thenReturn(null);

      final counter = container.read(localCounterProvider);

      expect(counter, equals(0));
      verify(mockRepository.fetch<int>(LocalCounter.localCounterKey)).called(1);
    });

    test('increment should increase counter and save', () async {
      when(
        mockRepository.fetch<int>(LocalCounter.localCounterKey),
      ).thenReturn(5);
      when(
        mockRepository.save<int>(LocalCounter.localCounterKey, 6),
      ).thenAnswer((_) async => true);

      final controller = container.read(localCounterProvider.notifier);
      await controller.increment();

      expect(container.read(localCounterProvider), equals(6));
      verify(
        mockRepository.save<int>(LocalCounter.localCounterKey, 6),
      ).called(1);
    });

    test('decrement should decrease counter and save', () async {
      when(
        mockRepository.fetch<int>(LocalCounter.localCounterKey),
      ).thenReturn(5);
      when(
        mockRepository.save<int>(LocalCounter.localCounterKey, 4),
      ).thenAnswer((_) async => true);

      final controller = container.read(localCounterProvider.notifier);
      await controller.decrement();

      expect(container.read(localCounterProvider), equals(4));
      verify(
        mockRepository.save<int>(LocalCounter.localCounterKey, 4),
      ).called(1);
    });

    test('should handle save error', () {
      when(
        mockRepository.fetch<int>(LocalCounter.localCounterKey),
      ).thenReturn(5);
      when(
        mockRepository.save<int>(LocalCounter.localCounterKey, 6),
      ).thenThrow(Exception('Save failed'));

      final controller = container.read(localCounterProvider.notifier);

      expect(controller.increment, throwsA(isA<Exception>()));
    });
  });
}
