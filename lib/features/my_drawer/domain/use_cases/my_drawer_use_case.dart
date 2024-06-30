import 'package:chat_app/features/my_drawer/domain/entities/my_drawer_entity.dart';
import 'package:chat_app/features/my_drawer/domain/repositories/my_drawer_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'my_drawer_use_case.g.dart';

@riverpod
MyDrawerUseCase myDrawerUseCase(MyDrawerUseCaseRef ref) {
  final myDrawerRepository = ref.read(myDrawerRepositoryProvider);
  return MyDrawerUseCase(myDrawerRepository: myDrawerRepository);
}

class MyDrawerUseCase {
  final MyDrawerRepository myDrawerRepository;

  MyDrawerUseCase({required this.myDrawerRepository});

  FutureOr<(MyDrawerEntity?, String?)> myDrawer() async {
    return await myDrawerRepository.myDrawer();
  }

  FutureOr<(MyDrawerEntity?, String?)> updateImage({required image}) async {
    return await myDrawerRepository.updateImage(image: image);
  }

  FutureOr<(MyDrawerEntity?, String?)> updateStatus({required status}) async {
    return await myDrawerRepository.updateStatus(status: status);
  }
}
