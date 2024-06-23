import 'dart:async';
import 'package:chat_app/features/sign_up/data/data_source/remote_data_source.dart';
import 'package:chat_app/features/sign_up/data/repositories/sign_up_repository_imp.dart';
import 'package:chat_app/features/sign_up/domain/entities/sign_up_entity.dart';
import 'package:chat_app/features/sign_up/presentation/widgets/user_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sign_up_repository.g.dart';

@riverpod
SignUpRepository signUpRepository(Ref ref) {
  final signUpRemoteDataSource = ref.read(signUpRemoteDataSourceProvider);
  return SignUpRepositoryImp(signUpRemoteDataSource);
}

abstract class SignUpRepository {
  FutureOr<(SignUpEntity?, String?)> signUp({
    required UserData userData,
  });
}
