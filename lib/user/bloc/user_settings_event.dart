part of 'user_settings_bloc.dart';

abstract class UserSettingsEvent extends Equatable {
  const UserSettingsEvent();

  @override
  List<Object> get props => [];
}

class ResetUserSettingsEvent extends UserSettingsEvent {
  const ResetUserSettingsEvent();
}

class GetUserSettingsEvent extends UserSettingsEvent {
  const GetUserSettingsEvent();
}

class UpdateUserSettingsEvent extends UserSettingsEvent {
  final bool? showReadPosts;
  final bool? showScores;
  final bool? showBotAccounts;
  final List<int>? discussionLanguages;
  final String? avatar;
  final String? banner;
  final String? bio;

  const UpdateUserSettingsEvent({this.showReadPosts, this.showScores, this.showBotAccounts, this.discussionLanguages, this.avatar, this.banner, this.bio});
}

class GetUserBlocksEvent extends UserSettingsEvent {
  const GetUserBlocksEvent();
}

class UnblockInstanceEvent extends UserSettingsEvent {
  final int instanceId;
  final bool unblock;

  const UnblockInstanceEvent({required this.instanceId, this.unblock = true});
}

class UnblockCommunityEvent extends UserSettingsEvent {
  final int communityId;
  final bool unblock;

  const UnblockCommunityEvent({required this.communityId, this.unblock = true});
}

class UnblockPersonEvent extends UserSettingsEvent {
  final int personId;
  final bool unblock;

  const UnblockPersonEvent({required this.personId, this.unblock = true});
}
