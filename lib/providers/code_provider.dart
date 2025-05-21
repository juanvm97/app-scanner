import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'code_provider.g.dart';

@riverpod
class Message extends _$Message {
  @override
  String build() => '';

  void update(String newMessage) {
    state = newMessage;
  }

  void reset() {
    state = 'Mensaje reiniciado';
  }
}
