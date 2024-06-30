
import 'package:chat_app/features/my_drawer/data/data_source/remote_data_source.dart';
import 'package:chat_app/features/my_drawer/data/repositories/my_drawer_repository_imp.dart';
import 'package:chat_app/features/my_drawer/domain/entities/my_drawer_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'my_drawer_repository.g.dart';

@riverpod
MyDrawerRepository myDrawerRepository(Ref ref) {
  final myDrawerRemoteDataSource = ref.read(myDrawerRemoteDataSourceProvider);
  return MyDrawerRepositoryImp(myDrawerRemoteDataSource);
}

abstract class MyDrawerRepository {
  FutureOr<(MyDrawerEntity?, String?)> myDrawer();
}
