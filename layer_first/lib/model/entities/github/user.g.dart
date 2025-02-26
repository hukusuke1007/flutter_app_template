// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => $checkedCreate(
  r'_$UserImpl',
  json,
  ($checkedConvert) {
    final val = _$UserImpl(
      login: $checkedConvert('login', (v) => v as String),
      id: $checkedConvert('id', (v) => (v as num).toInt()),
      nodeId: $checkedConvert('node_id', (v) => v as String?),
      avatarUrl: $checkedConvert('avatar_url', (v) => v as String?),
      gravatarId: $checkedConvert('gravatar_id', (v) => v as String?),
      url: $checkedConvert('url', (v) => v as String),
      htmlUrl: $checkedConvert('html_url', (v) => v as String?),
      followersUrl: $checkedConvert('followers_url', (v) => v as String?),
      followingUrl: $checkedConvert('following_url', (v) => v as String?),
      gistsUrl: $checkedConvert('gists_url', (v) => v as String?),
      starredUrl: $checkedConvert('starred_url', (v) => v as String?),
      subscriptionsUrl: $checkedConvert(
        'subscriptions_url',
        (v) => v as String?,
      ),
      organizationsUrl: $checkedConvert(
        'organizations_url',
        (v) => v as String?,
      ),
      reposUrl: $checkedConvert('repos_url', (v) => v as String?),
      eventsUrl: $checkedConvert('events_url', (v) => v as String?),
      receivedEventsUrl: $checkedConvert(
        'received_events_url',
        (v) => v as String?,
      ),
      type: $checkedConvert('type', (v) => v as String?),
      siteAdmin: $checkedConvert('site_admin', (v) => v as bool? ?? false),
    );
    return val;
  },
  fieldKeyMap: const {
    'nodeId': 'node_id',
    'avatarUrl': 'avatar_url',
    'gravatarId': 'gravatar_id',
    'htmlUrl': 'html_url',
    'followersUrl': 'followers_url',
    'followingUrl': 'following_url',
    'gistsUrl': 'gists_url',
    'starredUrl': 'starred_url',
    'subscriptionsUrl': 'subscriptions_url',
    'organizationsUrl': 'organizations_url',
    'reposUrl': 'repos_url',
    'eventsUrl': 'events_url',
    'receivedEventsUrl': 'received_events_url',
    'siteAdmin': 'site_admin',
  },
);

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'login': instance.login,
      'id': instance.id,
      'node_id': instance.nodeId,
      'avatar_url': instance.avatarUrl,
      'gravatar_id': instance.gravatarId,
      'url': instance.url,
      'html_url': instance.htmlUrl,
      'followers_url': instance.followersUrl,
      'following_url': instance.followingUrl,
      'gists_url': instance.gistsUrl,
      'starred_url': instance.starredUrl,
      'subscriptions_url': instance.subscriptionsUrl,
      'organizations_url': instance.organizationsUrl,
      'repos_url': instance.reposUrl,
      'events_url': instance.eventsUrl,
      'received_events_url': instance.receivedEventsUrl,
      'type': instance.type,
      'site_admin': instance.siteAdmin,
    };
