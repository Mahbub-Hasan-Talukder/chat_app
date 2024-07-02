import 'package:chat_app/features/my_drawer/domain/entities/my_drawer_entity.dart';
import 'package:chat_app/features/my_drawer/domain/use_cases/my_drawer_use_case.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'update_image_controller.g.dart';

@riverpod
class UpdateImageController extends _$UpdateImageController {
  @override
  FutureOr<(MyDrawerEntity?, String?)> build() {
    return (null, null);
  }

  void updateImage({required image}) async {
    state = const AsyncData((null, null));
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return await ref.read(myDrawerUseCaseProvider).updateImage(
            image: image,
          );
    });
  }
}
