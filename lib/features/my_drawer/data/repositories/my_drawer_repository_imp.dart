import 'package:chat_app/features/my_drawer/data/data_source/remote_data_source.dart';
import 'package:chat_app/features/my_drawer/data/models/my_drawer_model.dart';
import 'package:chat_app/features/my_drawer/domain/entities/my_drawer_entity.dart';
import 'package:chat_app/features/my_drawer/domain/repositories/my_drawer_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class MyDrawerRepositoryImp implements MyDrawerRepository {
  MyDrawerRemoteDataSource myDrawerRemoteDataSource;

  MyDrawerRepositoryImp(this.myDrawerRemoteDataSource);

  @override
  FutureOr<(MyDrawerModel?, String?)> myDrawer() async {
    final responsne = await myDrawerRemoteDataSource.myDrawer();
    return responsne;
  }

  @override
  FutureOr<(MyDrawerEntity?, String?)> updateImage({required image}) async {
    return await myDrawerRemoteDataSource.updateImage(image: image);
  }

  @override
  FutureOr<(MyDrawerEntity?, String?)> updateStatus({required status}) async {
    return await myDrawerRemoteDataSource.updateStatus(status: status);
  }
}
