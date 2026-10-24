/// Compile-time config from `--dart-define-from-file=env.json`.
///
/// Copy [env.example.json] to [env.json] (gitignored), then run or build with:
/// `flutter run --dart-define-from-file=env.json`
/// `flutter build apk --release --dart-define-from-file=env.json`
final class AppEnv {
  AppEnv._();

  static const String pusherKey = String.fromEnvironment('PUSHER_KEY');

  static const String pusherCluster = String.fromEnvironment(
    'PUSHER_CLUSTER',
    defaultValue: 'eu',
  );

  static const String baseUrl = String.fromEnvironment('BASE_URL');

  static const String userBaseUrl = String.fromEnvironment('USER_BASE_URL');

  static const String siteUrl = String.fromEnvironment('SITE_URL');

  static const String pusherAuthUrl = String.fromEnvironment('PUSHER_AUTH_URL');

  static const bool hasPusherKey = pusherKey != '';

  static void assertConfigured() {
    assert(
      baseUrl.isNotEmpty && userBaseUrl.isNotEmpty,
      'Missing compile-time config. Copy env.example.json to env.json and pass '
      '--dart-define-from-file=env.json',
    );
  }
}
