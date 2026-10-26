part of 'app_user_.dart';

import 'package:blog_app/core/common/entities/user.dart';
import 'package:flutter/material.dart';

@immutable
sealed class AppUserState {}

final class AppUserInitial extends AppUserState {}

final class AppUserLoggedIn extends AppUserState {
  final User user;
  AppUserLoggedIn(this.user);
}

// core cannot depend on other features but other features can depend on core
