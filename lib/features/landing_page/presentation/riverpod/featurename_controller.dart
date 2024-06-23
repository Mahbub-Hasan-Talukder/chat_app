import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'featurename_controller.g.dart';

@riverpod
class FeatureName_Controller extends _$FeatureName_Controller {
  @override
  FutureOr<(FeatureName_Entity?, String?)> build() {
    return (null, null);
  }

  void featureName_({required var_}) async {
    state = const AsyncData((null, null));
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return await ref
          .read(featureName_UseCaseProvider)
          .featureName_(var_: var_);
    });
  }
}
