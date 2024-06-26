import 'dart:async';
import 'package:chat_app/features/forgot_password/data/data_source/remote_data_source.dart';
import 'package:chat_app/features/forgot_password/data/repositories/forgot_pass_repository_imp.dart';
import 'package:chat_app/features/forgot_password/domain/entities/forgot_pass_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'forgot_pass_repository.g.dart';

@riverpod
ForgotPassRepository forgotPassRepository(Ref ref) {
  final forgotPassRemoteDataSource =
      ref.read(forgotPassRemoteDataSourceProvider);
  return ForgotPassRepositoryImp(forgotPassRemoteDataSource);
}

abstract class ForgotPassRepository {
  FutureOr<(ForgotPassEntity?, String?)> forgotPass({
    required String email,
  });
}
