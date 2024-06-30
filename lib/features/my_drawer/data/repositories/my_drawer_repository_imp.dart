import 'package:chat_app/features/my_drawer/data/data_source/remote_data_source.dart';
import 'package:chat_app/features/my_drawer/data/models/my_drawer_model.dart';
import 'package:chat_app/features/my_drawer/domain/repositories/my_drawer_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class MyDrawerRepositoryImp implements MyDrawerRepository {
  MyDrawerRemoteDataSource myDrawerRemoteDataSource;

  MyDrawerRepositoryImp(this.myDrawerRemoteDataSource);

  @override
  FutureOr<(MyDrawerModel?, String?)> myDrawer() async {
    print('before');
    final responsne = await myDrawerRemoteDataSource.myDrawer();
    print('after');

    print('${responsne.$1}  -  ${responsne.$2}');
    return responsne;
  }
}
