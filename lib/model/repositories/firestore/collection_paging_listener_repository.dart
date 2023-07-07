import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

import 'document.dart';

class DocumentChangeData<T extends Object> {
  DocumentChangeData({
    required this.entity,
    required this.docChange,
  });
  final T entity;
  final DocumentChange docChange;
}

class CollectionPagingListenerRepository<T extends Object> {
  CollectionPagingListenerRepository({
    required this.query,
    this.initialLimit,
    this.pagingLimit,
    required this.decode,
  })  : _limit = initialLimit,
        _pagingListenerController =
            _PagingListener(query: query, limit: initialLimit, decode: decode);

  final Query<Map<String, dynamic>> query;
  final int? initialLimit;
  final int? pagingLimit;
  final T Function(Map<String, dynamic>) decode;

  ValueStream<List<Document<T>>> get data => _dataController.stream;
  Stream<List<DocumentChangeData<T>>> get docChanges =>
      _docChangesController.stream;
  int get count => _dataController.value.length;
  bool get hasMore => _hasMore;

  final _PagingListener<T> _pagingListenerController;
  final BehaviorSubject<List<Document<T>>> _dataController =
      BehaviorSubject<List<Document<T>>>.seeded([]);
  final PublishSubject<List<DocumentChangeData<T>>> _docChangesController =
      PublishSubject<List<DocumentChangeData<T>>>();

  bool _hasMore = true;
  bool _initLoaded = false;
  int? _limit;

  StreamSubscription<List<Document<T>>>? _disposer;

  Future<void> dispose() async {
    await _disposer?.cancel();
    await _pagingListenerController.dispose();
    await _dataController.close();
    await _docChangesController.close();
    _disposer = null;
  }

  void fetch() {
    assert(!_initLoaded);
    _disposer = _pagingListenerController.data.listen((event) {
      if (_limit != null) {
        _hasMore = event.length >= _limit!;
      } else {
        _hasMore = false;
      }
      _dataController.add(event);
    });
    _pagingListenerController.docChanges
        .where((event) => event.isNotEmpty)
        .pipe(_docChangesController);
    _pagingListenerController.onFetch.add(_limit);
    _initLoaded = true;
  }

  void fetchMore() {
    final limit = _limit;
    final pagingCount = pagingLimit;
    if (_hasMore && limit != null && pagingCount != null) {
      _limit = limit + pagingCount;
      _pagingListenerController.onFetch.add(_limit);
    }
  }
}

class _PagingListener<T extends Object> {
  _PagingListener({
    required this.query,
    this.limit,
    required this.decode,
    this.collectionReference,
  }) {
    _fetchController.switchMap<int>(Stream.value).listen(_fetch);
  }

  final Query<Map<String, dynamic>> query;
  final int? limit;
  final T Function(Map<String, dynamic>) decode;
  final CollectionReference? collectionReference;

  ValueStream<List<Document<T>>> get data => _dataController.stream;
  Stream<List<DocumentChangeData<T>>> get docChanges =>
      _docChangesController.stream;
  Sink<int?> get onFetch => _fetchController.sink;

  final BehaviorSubject<List<Document<T>>> _dataController =
      BehaviorSubject<List<Document<T>>>.seeded([]);
  final PublishSubject<List<DocumentChangeData<T>>> _docChangesController =
      PublishSubject<List<DocumentChangeData<T>>>();
  final PublishSubject<int> _fetchController = PublishSubject<int>();

  StreamSubscription<QuerySnapshot>? _disposer;

  Future<void> dispose() async {
    await _disposer?.cancel();
    await _dataController.close();
    await _docChangesController.close();
    await _fetchController.close();
  }

  Future<void> _fetch(int? limit) async {
    if (_disposer != null) {
      await _disposer?.cancel();
      _disposer = null;
      _dataController.value.clear();
    }
    var dataSource = query;
    if (limit != null) {
      dataSource = dataSource.limit(limit);
    }
    _disposer = dataSource.snapshots().listen((event) {
      final docs = _dataController.value;
      final changes = <DocumentChangeData<T>>[];
      for (final change in event.docChanges) {
        final entity = decode(change.doc.data()!);
        final doc = Document<T>(
          ref: change.doc.reference,
          exists: change.doc.exists,
          entity: entity,
        );
        if (change.type == DocumentChangeType.added) {
          docs.insert(change.newIndex, doc);
        } else if (change.type == DocumentChangeType.modified) {
          if (change.oldIndex == change.newIndex) {
            docs[change.newIndex] = doc;
          } else {
            docs
              ..removeAt(change.oldIndex)
              ..insert(change.newIndex, doc);
          }
        } else if (change.type == DocumentChangeType.removed) {
          docs.removeAt(change.oldIndex);
        }
        changes.add(DocumentChangeData<T>(entity: entity, docChange: change));
      }
      _dataController.add(docs);
      _docChangesController.add(changes);
    });
  }
}
