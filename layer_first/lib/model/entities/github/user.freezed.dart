// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$User {

 String get login; int get id;@JsonKey(name: 'node_id') String? get nodeId;@JsonKey(name: 'avatar_url') String? get avatarUrl;@JsonKey(name: 'gravatar_id') String? get gravatarId; String get url;@JsonKey(name: 'html_url') String? get htmlUrl;@JsonKey(name: 'followers_url') String? get followersUrl;@JsonKey(name: 'following_url') String? get followingUrl;@JsonKey(name: 'gists_url') String? get gistsUrl;@JsonKey(name: 'starred_url') String? get starredUrl;@JsonKey(name: 'subscriptions_url') String? get subscriptionsUrl;@JsonKey(name: 'organizations_url') String? get organizationsUrl;@JsonKey(name: 'repos_url') String? get reposUrl;@JsonKey(name: 'events_url') String? get eventsUrl;@JsonKey(name: 'received_events_url') String? get receivedEventsUrl; String? get type;@JsonKey(name: 'site_admin') bool get siteAdmin;
/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserCopyWith<User> get copyWith => _$UserCopyWithImpl<User>(this as User, _$identity);

  /// Serializes this User to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is User&&(identical(other.login, login) || other.login == login)&&(identical(other.id, id) || other.id == id)&&(identical(other.nodeId, nodeId) || other.nodeId == nodeId)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.gravatarId, gravatarId) || other.gravatarId == gravatarId)&&(identical(other.url, url) || other.url == url)&&(identical(other.htmlUrl, htmlUrl) || other.htmlUrl == htmlUrl)&&(identical(other.followersUrl, followersUrl) || other.followersUrl == followersUrl)&&(identical(other.followingUrl, followingUrl) || other.followingUrl == followingUrl)&&(identical(other.gistsUrl, gistsUrl) || other.gistsUrl == gistsUrl)&&(identical(other.starredUrl, starredUrl) || other.starredUrl == starredUrl)&&(identical(other.subscriptionsUrl, subscriptionsUrl) || other.subscriptionsUrl == subscriptionsUrl)&&(identical(other.organizationsUrl, organizationsUrl) || other.organizationsUrl == organizationsUrl)&&(identical(other.reposUrl, reposUrl) || other.reposUrl == reposUrl)&&(identical(other.eventsUrl, eventsUrl) || other.eventsUrl == eventsUrl)&&(identical(other.receivedEventsUrl, receivedEventsUrl) || other.receivedEventsUrl == receivedEventsUrl)&&(identical(other.type, type) || other.type == type)&&(identical(other.siteAdmin, siteAdmin) || other.siteAdmin == siteAdmin));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,login,id,nodeId,avatarUrl,gravatarId,url,htmlUrl,followersUrl,followingUrl,gistsUrl,starredUrl,subscriptionsUrl,organizationsUrl,reposUrl,eventsUrl,receivedEventsUrl,type,siteAdmin);

@override
String toString() {
  return 'User(login: $login, id: $id, nodeId: $nodeId, avatarUrl: $avatarUrl, gravatarId: $gravatarId, url: $url, htmlUrl: $htmlUrl, followersUrl: $followersUrl, followingUrl: $followingUrl, gistsUrl: $gistsUrl, starredUrl: $starredUrl, subscriptionsUrl: $subscriptionsUrl, organizationsUrl: $organizationsUrl, reposUrl: $reposUrl, eventsUrl: $eventsUrl, receivedEventsUrl: $receivedEventsUrl, type: $type, siteAdmin: $siteAdmin)';
}


}

/// @nodoc
abstract mixin class $UserCopyWith<$Res>  {
  factory $UserCopyWith(User value, $Res Function(User) _then) = _$UserCopyWithImpl;
@useResult
$Res call({
 String login, int id,@JsonKey(name: 'node_id') String? nodeId,@JsonKey(name: 'avatar_url') String? avatarUrl,@JsonKey(name: 'gravatar_id') String? gravatarId, String url,@JsonKey(name: 'html_url') String? htmlUrl,@JsonKey(name: 'followers_url') String? followersUrl,@JsonKey(name: 'following_url') String? followingUrl,@JsonKey(name: 'gists_url') String? gistsUrl,@JsonKey(name: 'starred_url') String? starredUrl,@JsonKey(name: 'subscriptions_url') String? subscriptionsUrl,@JsonKey(name: 'organizations_url') String? organizationsUrl,@JsonKey(name: 'repos_url') String? reposUrl,@JsonKey(name: 'events_url') String? eventsUrl,@JsonKey(name: 'received_events_url') String? receivedEventsUrl, String? type,@JsonKey(name: 'site_admin') bool siteAdmin
});




}
/// @nodoc
class _$UserCopyWithImpl<$Res>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._self, this._then);

  final User _self;
  final $Res Function(User) _then;

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? login = null,Object? id = null,Object? nodeId = freezed,Object? avatarUrl = freezed,Object? gravatarId = freezed,Object? url = null,Object? htmlUrl = freezed,Object? followersUrl = freezed,Object? followingUrl = freezed,Object? gistsUrl = freezed,Object? starredUrl = freezed,Object? subscriptionsUrl = freezed,Object? organizationsUrl = freezed,Object? reposUrl = freezed,Object? eventsUrl = freezed,Object? receivedEventsUrl = freezed,Object? type = freezed,Object? siteAdmin = null,}) {
  return _then(_self.copyWith(
login: null == login ? _self.login : login // ignore: cast_nullable_to_non_nullable
as String,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nodeId: freezed == nodeId ? _self.nodeId : nodeId // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,gravatarId: freezed == gravatarId ? _self.gravatarId : gravatarId // ignore: cast_nullable_to_non_nullable
as String?,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,htmlUrl: freezed == htmlUrl ? _self.htmlUrl : htmlUrl // ignore: cast_nullable_to_non_nullable
as String?,followersUrl: freezed == followersUrl ? _self.followersUrl : followersUrl // ignore: cast_nullable_to_non_nullable
as String?,followingUrl: freezed == followingUrl ? _self.followingUrl : followingUrl // ignore: cast_nullable_to_non_nullable
as String?,gistsUrl: freezed == gistsUrl ? _self.gistsUrl : gistsUrl // ignore: cast_nullable_to_non_nullable
as String?,starredUrl: freezed == starredUrl ? _self.starredUrl : starredUrl // ignore: cast_nullable_to_non_nullable
as String?,subscriptionsUrl: freezed == subscriptionsUrl ? _self.subscriptionsUrl : subscriptionsUrl // ignore: cast_nullable_to_non_nullable
as String?,organizationsUrl: freezed == organizationsUrl ? _self.organizationsUrl : organizationsUrl // ignore: cast_nullable_to_non_nullable
as String?,reposUrl: freezed == reposUrl ? _self.reposUrl : reposUrl // ignore: cast_nullable_to_non_nullable
as String?,eventsUrl: freezed == eventsUrl ? _self.eventsUrl : eventsUrl // ignore: cast_nullable_to_non_nullable
as String?,receivedEventsUrl: freezed == receivedEventsUrl ? _self.receivedEventsUrl : receivedEventsUrl // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,siteAdmin: null == siteAdmin ? _self.siteAdmin : siteAdmin // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [User].
extension UserPatterns on User {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _User value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _User() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _User value)  $default,){
final _that = this;
switch (_that) {
case _User():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _User value)?  $default,){
final _that = this;
switch (_that) {
case _User() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String login,  int id, @JsonKey(name: 'node_id')  String? nodeId, @JsonKey(name: 'avatar_url')  String? avatarUrl, @JsonKey(name: 'gravatar_id')  String? gravatarId,  String url, @JsonKey(name: 'html_url')  String? htmlUrl, @JsonKey(name: 'followers_url')  String? followersUrl, @JsonKey(name: 'following_url')  String? followingUrl, @JsonKey(name: 'gists_url')  String? gistsUrl, @JsonKey(name: 'starred_url')  String? starredUrl, @JsonKey(name: 'subscriptions_url')  String? subscriptionsUrl, @JsonKey(name: 'organizations_url')  String? organizationsUrl, @JsonKey(name: 'repos_url')  String? reposUrl, @JsonKey(name: 'events_url')  String? eventsUrl, @JsonKey(name: 'received_events_url')  String? receivedEventsUrl,  String? type, @JsonKey(name: 'site_admin')  bool siteAdmin)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _User() when $default != null:
return $default(_that.login,_that.id,_that.nodeId,_that.avatarUrl,_that.gravatarId,_that.url,_that.htmlUrl,_that.followersUrl,_that.followingUrl,_that.gistsUrl,_that.starredUrl,_that.subscriptionsUrl,_that.organizationsUrl,_that.reposUrl,_that.eventsUrl,_that.receivedEventsUrl,_that.type,_that.siteAdmin);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String login,  int id, @JsonKey(name: 'node_id')  String? nodeId, @JsonKey(name: 'avatar_url')  String? avatarUrl, @JsonKey(name: 'gravatar_id')  String? gravatarId,  String url, @JsonKey(name: 'html_url')  String? htmlUrl, @JsonKey(name: 'followers_url')  String? followersUrl, @JsonKey(name: 'following_url')  String? followingUrl, @JsonKey(name: 'gists_url')  String? gistsUrl, @JsonKey(name: 'starred_url')  String? starredUrl, @JsonKey(name: 'subscriptions_url')  String? subscriptionsUrl, @JsonKey(name: 'organizations_url')  String? organizationsUrl, @JsonKey(name: 'repos_url')  String? reposUrl, @JsonKey(name: 'events_url')  String? eventsUrl, @JsonKey(name: 'received_events_url')  String? receivedEventsUrl,  String? type, @JsonKey(name: 'site_admin')  bool siteAdmin)  $default,) {final _that = this;
switch (_that) {
case _User():
return $default(_that.login,_that.id,_that.nodeId,_that.avatarUrl,_that.gravatarId,_that.url,_that.htmlUrl,_that.followersUrl,_that.followingUrl,_that.gistsUrl,_that.starredUrl,_that.subscriptionsUrl,_that.organizationsUrl,_that.reposUrl,_that.eventsUrl,_that.receivedEventsUrl,_that.type,_that.siteAdmin);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String login,  int id, @JsonKey(name: 'node_id')  String? nodeId, @JsonKey(name: 'avatar_url')  String? avatarUrl, @JsonKey(name: 'gravatar_id')  String? gravatarId,  String url, @JsonKey(name: 'html_url')  String? htmlUrl, @JsonKey(name: 'followers_url')  String? followersUrl, @JsonKey(name: 'following_url')  String? followingUrl, @JsonKey(name: 'gists_url')  String? gistsUrl, @JsonKey(name: 'starred_url')  String? starredUrl, @JsonKey(name: 'subscriptions_url')  String? subscriptionsUrl, @JsonKey(name: 'organizations_url')  String? organizationsUrl, @JsonKey(name: 'repos_url')  String? reposUrl, @JsonKey(name: 'events_url')  String? eventsUrl, @JsonKey(name: 'received_events_url')  String? receivedEventsUrl,  String? type, @JsonKey(name: 'site_admin')  bool siteAdmin)?  $default,) {final _that = this;
switch (_that) {
case _User() when $default != null:
return $default(_that.login,_that.id,_that.nodeId,_that.avatarUrl,_that.gravatarId,_that.url,_that.htmlUrl,_that.followersUrl,_that.followingUrl,_that.gistsUrl,_that.starredUrl,_that.subscriptionsUrl,_that.organizationsUrl,_that.reposUrl,_that.eventsUrl,_that.receivedEventsUrl,_that.type,_that.siteAdmin);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _User extends User {
  const _User({required this.login, required this.id, @JsonKey(name: 'node_id') this.nodeId, @JsonKey(name: 'avatar_url') this.avatarUrl, @JsonKey(name: 'gravatar_id') this.gravatarId, required this.url, @JsonKey(name: 'html_url') this.htmlUrl, @JsonKey(name: 'followers_url') this.followersUrl, @JsonKey(name: 'following_url') this.followingUrl, @JsonKey(name: 'gists_url') this.gistsUrl, @JsonKey(name: 'starred_url') this.starredUrl, @JsonKey(name: 'subscriptions_url') this.subscriptionsUrl, @JsonKey(name: 'organizations_url') this.organizationsUrl, @JsonKey(name: 'repos_url') this.reposUrl, @JsonKey(name: 'events_url') this.eventsUrl, @JsonKey(name: 'received_events_url') this.receivedEventsUrl, this.type, @JsonKey(name: 'site_admin') this.siteAdmin = false}): super._();
  factory _User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

@override final  String login;
@override final  int id;
@override@JsonKey(name: 'node_id') final  String? nodeId;
@override@JsonKey(name: 'avatar_url') final  String? avatarUrl;
@override@JsonKey(name: 'gravatar_id') final  String? gravatarId;
@override final  String url;
@override@JsonKey(name: 'html_url') final  String? htmlUrl;
@override@JsonKey(name: 'followers_url') final  String? followersUrl;
@override@JsonKey(name: 'following_url') final  String? followingUrl;
@override@JsonKey(name: 'gists_url') final  String? gistsUrl;
@override@JsonKey(name: 'starred_url') final  String? starredUrl;
@override@JsonKey(name: 'subscriptions_url') final  String? subscriptionsUrl;
@override@JsonKey(name: 'organizations_url') final  String? organizationsUrl;
@override@JsonKey(name: 'repos_url') final  String? reposUrl;
@override@JsonKey(name: 'events_url') final  String? eventsUrl;
@override@JsonKey(name: 'received_events_url') final  String? receivedEventsUrl;
@override final  String? type;
@override@JsonKey(name: 'site_admin') final  bool siteAdmin;

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserCopyWith<_User> get copyWith => __$UserCopyWithImpl<_User>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _User&&(identical(other.login, login) || other.login == login)&&(identical(other.id, id) || other.id == id)&&(identical(other.nodeId, nodeId) || other.nodeId == nodeId)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl)&&(identical(other.gravatarId, gravatarId) || other.gravatarId == gravatarId)&&(identical(other.url, url) || other.url == url)&&(identical(other.htmlUrl, htmlUrl) || other.htmlUrl == htmlUrl)&&(identical(other.followersUrl, followersUrl) || other.followersUrl == followersUrl)&&(identical(other.followingUrl, followingUrl) || other.followingUrl == followingUrl)&&(identical(other.gistsUrl, gistsUrl) || other.gistsUrl == gistsUrl)&&(identical(other.starredUrl, starredUrl) || other.starredUrl == starredUrl)&&(identical(other.subscriptionsUrl, subscriptionsUrl) || other.subscriptionsUrl == subscriptionsUrl)&&(identical(other.organizationsUrl, organizationsUrl) || other.organizationsUrl == organizationsUrl)&&(identical(other.reposUrl, reposUrl) || other.reposUrl == reposUrl)&&(identical(other.eventsUrl, eventsUrl) || other.eventsUrl == eventsUrl)&&(identical(other.receivedEventsUrl, receivedEventsUrl) || other.receivedEventsUrl == receivedEventsUrl)&&(identical(other.type, type) || other.type == type)&&(identical(other.siteAdmin, siteAdmin) || other.siteAdmin == siteAdmin));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,login,id,nodeId,avatarUrl,gravatarId,url,htmlUrl,followersUrl,followingUrl,gistsUrl,starredUrl,subscriptionsUrl,organizationsUrl,reposUrl,eventsUrl,receivedEventsUrl,type,siteAdmin);

@override
String toString() {
  return 'User(login: $login, id: $id, nodeId: $nodeId, avatarUrl: $avatarUrl, gravatarId: $gravatarId, url: $url, htmlUrl: $htmlUrl, followersUrl: $followersUrl, followingUrl: $followingUrl, gistsUrl: $gistsUrl, starredUrl: $starredUrl, subscriptionsUrl: $subscriptionsUrl, organizationsUrl: $organizationsUrl, reposUrl: $reposUrl, eventsUrl: $eventsUrl, receivedEventsUrl: $receivedEventsUrl, type: $type, siteAdmin: $siteAdmin)';
}


}

/// @nodoc
abstract mixin class _$UserCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$UserCopyWith(_User value, $Res Function(_User) _then) = __$UserCopyWithImpl;
@override @useResult
$Res call({
 String login, int id,@JsonKey(name: 'node_id') String? nodeId,@JsonKey(name: 'avatar_url') String? avatarUrl,@JsonKey(name: 'gravatar_id') String? gravatarId, String url,@JsonKey(name: 'html_url') String? htmlUrl,@JsonKey(name: 'followers_url') String? followersUrl,@JsonKey(name: 'following_url') String? followingUrl,@JsonKey(name: 'gists_url') String? gistsUrl,@JsonKey(name: 'starred_url') String? starredUrl,@JsonKey(name: 'subscriptions_url') String? subscriptionsUrl,@JsonKey(name: 'organizations_url') String? organizationsUrl,@JsonKey(name: 'repos_url') String? reposUrl,@JsonKey(name: 'events_url') String? eventsUrl,@JsonKey(name: 'received_events_url') String? receivedEventsUrl, String? type,@JsonKey(name: 'site_admin') bool siteAdmin
});




}
/// @nodoc
class __$UserCopyWithImpl<$Res>
    implements _$UserCopyWith<$Res> {
  __$UserCopyWithImpl(this._self, this._then);

  final _User _self;
  final $Res Function(_User) _then;

/// Create a copy of User
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? login = null,Object? id = null,Object? nodeId = freezed,Object? avatarUrl = freezed,Object? gravatarId = freezed,Object? url = null,Object? htmlUrl = freezed,Object? followersUrl = freezed,Object? followingUrl = freezed,Object? gistsUrl = freezed,Object? starredUrl = freezed,Object? subscriptionsUrl = freezed,Object? organizationsUrl = freezed,Object? reposUrl = freezed,Object? eventsUrl = freezed,Object? receivedEventsUrl = freezed,Object? type = freezed,Object? siteAdmin = null,}) {
  return _then(_User(
login: null == login ? _self.login : login // ignore: cast_nullable_to_non_nullable
as String,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,nodeId: freezed == nodeId ? _self.nodeId : nodeId // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,gravatarId: freezed == gravatarId ? _self.gravatarId : gravatarId // ignore: cast_nullable_to_non_nullable
as String?,url: null == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String,htmlUrl: freezed == htmlUrl ? _self.htmlUrl : htmlUrl // ignore: cast_nullable_to_non_nullable
as String?,followersUrl: freezed == followersUrl ? _self.followersUrl : followersUrl // ignore: cast_nullable_to_non_nullable
as String?,followingUrl: freezed == followingUrl ? _self.followingUrl : followingUrl // ignore: cast_nullable_to_non_nullable
as String?,gistsUrl: freezed == gistsUrl ? _self.gistsUrl : gistsUrl // ignore: cast_nullable_to_non_nullable
as String?,starredUrl: freezed == starredUrl ? _self.starredUrl : starredUrl // ignore: cast_nullable_to_non_nullable
as String?,subscriptionsUrl: freezed == subscriptionsUrl ? _self.subscriptionsUrl : subscriptionsUrl // ignore: cast_nullable_to_non_nullable
as String?,organizationsUrl: freezed == organizationsUrl ? _self.organizationsUrl : organizationsUrl // ignore: cast_nullable_to_non_nullable
as String?,reposUrl: freezed == reposUrl ? _self.reposUrl : reposUrl // ignore: cast_nullable_to_non_nullable
as String?,eventsUrl: freezed == eventsUrl ? _self.eventsUrl : eventsUrl // ignore: cast_nullable_to_non_nullable
as String?,receivedEventsUrl: freezed == receivedEventsUrl ? _self.receivedEventsUrl : receivedEventsUrl // ignore: cast_nullable_to_non_nullable
as String?,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,siteAdmin: null == siteAdmin ? _self.siteAdmin : siteAdmin // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
