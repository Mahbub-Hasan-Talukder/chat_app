import 'dart:async';

import 'package:chat_app/features/login/data/data_source/remote_data_source.dart';
import 'package:chat_app/features/login/data/repositories/login_repository_imp.dart';
import 'package:chat_app/features/login/domain/entities/login_entity.dart';
import 'package:chat_app/features/login/presentation/widgets/user_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_repository.g.dart';

@riverpod
LoginRepository loginRepository(Ref ref) {
  final loginRemoteDataSource = ref.read(loginRemoteDataSourceProvider);
  return LoginRepositoryImp(loginRemoteDataSource);
}

abstract class LoginRepository {
  FutureOr<(LoginEntity?, String?)> login({
    required UserData userData,
  });
}
