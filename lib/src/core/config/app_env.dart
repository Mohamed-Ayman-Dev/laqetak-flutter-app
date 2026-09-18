/// Compile-time secrets from `--dart-define-from-file=env.json`.
///
/// Copy `env.example.json` to `env.json` (gitignored), fill in the values,
/// then run: `flutter run --dart-define-from-file=env.json`
class AppEnv {
  AppEnv._();

  static const pusherKey = String.fromEnvironment('PUSHER_KEY');
  static const pusherCluster = String.fromEnvironment(
    'PUSHER_CLUSTER',
    defaultValue: 'eu',
  );

  static bool get hasPusherKey => pusherKey.isNotEmpty;
}
