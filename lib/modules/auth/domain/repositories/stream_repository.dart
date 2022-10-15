import 'dart:async';

import 'package:safetech_app/modules/auth/domain/models/models.dart';
import 'package:safetech_app/modules/auth/domain/repositories/repositories.dart';


class StreamRepository {
  final _controller = StreamController<Status>();

  Stream<Status> get status async* {
    yield* checkAuthStatus();
    yield* _controller.stream;
  }

  Stream<Status> checkAuthStatus() async* {
    final cookie = await Storage.getCookie();
    yield cookie == null ? Status.unauthenticated : Status.authenticated;
  }

  void login() {
    _controller.add(Status.authenticated);
  }

  void logout() {
    _controller.add(Status.unauthenticated);
  }

  void dispose() => _controller.close();
}
