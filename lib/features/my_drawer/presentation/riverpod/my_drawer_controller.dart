import 'package:chat_app/features/my_drawer/domain/entities/my_drawer_entity.dart';
import 'package:chat_app/features/my_drawer/domain/use_cases/my_drawer_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'my_drawer_controller.g.dart';

@riverpod
class MyDrawerController extends _$MyDrawerController {
  @override
  FutureOr<(MyDrawerEntity?, String?)> build() {
    return (null, null);
  }

  void myDrawer() async {
    state = const AsyncData((null, null));
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return await ref.read(myDrawerUseCaseProvider).myDrawer();
    });
  }
}
