import 'package:equatable/equatable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../entities/sample/enum/operation_type.dart';
import '../../../../entities/sample/timeline/post.dart';

/// 操作データ
class OperationData extends Equatable {
  const OperationData({
    required this.type,
    required this.post,
  });
  final OperationType type;
  final Post post;

  @override
  List<Object?> get props => [type, post];
}

/// 投稿操作のオブザーバー
final postOperationObserverProvider = Provider(
  (ref) => PublishSubject<OperationData>(),
);
