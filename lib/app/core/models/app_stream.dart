import 'package:svr/app/core/models/api_response_model.dart';
import 'package:rxdart/rxdart.dart';

class AppStream<T> {
  late final T t;
  AppStream() {
    controller = BehaviorSubject<T>();
  }

  AppStream.seed(this.t) {
    controller = BehaviorSubject<T>.seeded(t);
  }

  late final BehaviorSubject<T> controller;
  void add(e) => controller.sink.add(e);
  Stream<T> get listen => controller.stream;
  T get value => controller.stream.value;
  void update() => controller.sink.add(controller.value);
}

class AppStreamResponse<T> {
  late ApiResponse<T> t;
  late BehaviorSubject<ApiResponse<T>> controller;
  void add(e) => controller.sink.add(e);
  void addInResponse(e) => controller.sink.add(ApiResponse.complete(e));
  Stream<ApiResponse<T>> get listen => controller.stream;
  T get value => controller.stream.value.data;
  void update() => controller.sink.add(controller.value);

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
