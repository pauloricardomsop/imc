import 'package:rxdart/subjects.dart';
import 'package:svr/app/core/models/api_response_model.dart';

class AppStreamResponse<T> {
  late ApiResponse<T> t;
  late BehaviorSubject<ApiResponse<T>> controller;
  void add(e) => controller.sink.add(e);
  void addInResponse(e) => controller.sink.add(ApiResponse.complete(e));
  Stream<ApiResponse<T>> get listen => controller.stream;
  T get value => controller.stream.value.data;

  bool get hasValidData => controller.hasValue && controller.value.hasData;

  AppStreamResponse() {
    controller = BehaviorSubject<ApiResponse<T>>();
  }

  AppStreamResponse.seeded(this.t) {
    controller = BehaviorSubject<ApiResponse<T>>.seeded(t);
  }

  ApiResponse<T>? lastAdded;

  void setLoading() {
    if (controller.hasValue) {
      lastAdded = controller.value;
    }
    controller.sink.add(ApiResponse.loading());
  }

  void setDefault() {
    if (lastAdded != null) {
      controller.sink.add(lastAdded!);
    } else {
      controller.sink.close();
      controller = BehaviorSubject<ApiResponse<T>>();
    }
  }

  void initialize(object) {
    controller.add(ApiResponse.complete(object as T));
  }
}
