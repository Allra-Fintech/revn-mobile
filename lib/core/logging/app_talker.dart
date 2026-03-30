import 'package:talker_flutter/talker_flutter.dart';

Talker createTalker() {
  return TalkerFlutter.init(
    settings: TalkerSettings(
      enabled: true,
      useConsoleLogs: true,
      useHistory: true,
      maxHistoryItems: 200,
      timeFormat: TimeFormat.timeAndSeconds,
    ),
  );
}
