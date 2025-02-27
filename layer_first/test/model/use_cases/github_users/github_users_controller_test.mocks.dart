// Mocks generated by Mockito 5.4.5 from annotations
// in flutter_app_template/test/model/use_cases/github_users/github_users_controller_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:flutter_app_template/model/entities/github/user.dart' as _i4;
import 'package:flutter_app_template/model/repositories/github_api/github_api_repository.dart'
    as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: must_be_immutable
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [GithubApiRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockGithubApiRepository extends _i1.Mock
    implements _i2.GithubApiRepository {
  @override
  _i3.Future<List<_i4.User>> fetchUsers({int? since, int? perPage}) =>
      (super.noSuchMethod(
            Invocation.method(#fetchUsers, [], {
              #since: since,
              #perPage: perPage,
            }),
            returnValue: _i3.Future<List<_i4.User>>.value(<_i4.User>[]),
            returnValueForMissingStub: _i3.Future<List<_i4.User>>.value(
              <_i4.User>[],
            ),
          )
          as _i3.Future<List<_i4.User>>);
}
