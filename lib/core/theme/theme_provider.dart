import 'dart:async';

import 'package:chat_app/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_provider.g.dart';

@riverpod
class ThemeProvider extends _$ThemeProvider {
  @override
  FutureOr<ThemeData> build() {
    return ThemeClass.lightTheme;
  }

  @override
  AsyncValue<ThemeData> get state => super.state;

  @override
  set state(AsyncValue<ThemeData> newState) {
    super.state = newState;
  }
}
