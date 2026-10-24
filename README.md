# Laqetak

A Flutter marketplace app: browse ads, filter them, open a seller, chat, publish your own ad, and manage favorites. This repository is a sanitized portfolio copy of a production app I built. Client name, keys, and private URLs are not in the current tree.

## Architecture

Feature-first. Each feature owns its data and its screens. There is no domain / use-case layer on purpose: those use cases would only forward the repository call.

```
UI  →  Cubit  →  Repository  →  Remote data source  →  ApiClient
```

- The repository is an interface plus an implementation. The implementation returns `ApiResult`, so the cubit does not catch `DioException`.
- The data source is split the same way: interface in one file, implementation in another.
- `ApiClient` is the only Dio stack. An interceptor attaches the language and the bearer token from cubit state on every request.
- Cubits are GetIt singletons, provided once with `BlocProvider.value`.

`core/` is infrastructure: network, cache, DI, errors, theme, and shared widgets. `core/shared/` is only state used by more than one feature (cities and categories, app settings, OTP timers, network connectivity). `AdModel` lives there because home, details, my ads, and favorites all use the same object.

## State in the UI

| Widget | Job |
|---|---|
| `context.read` | Call a method. The widget does not rebuild. |
| `BlocSelector` | Rebuild one widget when one field changes. |
| `BlocBuilder` | Rebuild when several fields on that state matter together. |
| `BlocListener` | Run once: navigation, dialog, toast. It sits on the screen that started the action. |

`app.dart` does not host those listeners. It only rebuilds `MaterialApp` when language or theme changes.

A few toasts that are not owned by one screen (favorite toggle, a report sent from a dialog that closes immediately, a background profile refresh) are shown from the cubit through `AppFeedback`.

Favorites and profile are screens over shared cubits (`AdsCubit`, `AuthCubit`). They do not have their own data layer.

## Layout

```
lib/src/
  config/            app, routes, BlocProviders
  core/
    network/         ApiClient, endpoints, ApiResult, NetworkInfo
    env/             AppEnv (compile-time)
    di/              GetIt
    shared/          others, settings, timers, network, AdModel
    widgets/
  features/
    auth/  home/  ad_details/  my_ads/  favorite/
    chat/  notifications/  profile/  static_pages/
```

Inside a feature:

```
data/datasources/     interface + impl
data/models/
data/repositories/    interface + impl
presentation/cubit/
presentation/screens/
```

## Run

Copy the example env file and fill in real values. `env.json` is gitignored.

```bash
cp env.example.json env.json
```

Android Studio run configuration **main.dart** already passes `--dart-define-from-file=env.json`. Release on a device is **Run → Flutter Run 'main.dart' in Release Mode**. That flag is compile-time: `flutter build` does not read the run configuration, so a store build must pass the file too.

```bash
flutter run --dart-define-from-file=env.json
flutter build apk --release --dart-define-from-file=env.json
flutter build appbundle --release --dart-define-from-file=env.json
```

`String.fromEnvironment` reads the host, the site URL, and the Pusher client key. Endpoint paths stay in `EndPoints`. Nothing in the binary is a real secret; a privileged key would stay on the server.

## Connectivity & Offline Handling

Network awareness uses three complementary layers so no single check is a false positive:

```
┌─────────────────────────────────────────────────────┐
│              Layer 1 — DNS Lookup                   │
│  InternetAddress.lookup('google.com')               │
│  OS-level resolve, ~15 ms, zero HTTP overhead       │
├─────────────────────────────────────────────────────┤
│         Layer 2 — Connection Stream                 │
│  InternetConnectionChecker (connectivity_plus)      │
│  Polls Google captive-portal & Cloudflare every 5 s │
├─────────────────────────────────────────────────────┤
│       Layer 3 — Real Traffic (Dio Interceptor)      │
│  onResponse → markConnected()                       │
│  connectionError / timeout → markDisconnected()     │
└─────────────────────────────────────────────────────┘
```

**Why not `http.head()` against dummy APIs alone?**  The default addresses shipped with `internet_connection_checker` (`dummyapi.online`, `fakestoreapi.com`) are free hobby servers that frequently go offline, causing false "no internet" reports even though the device is connected. The DNS lookup (`dart:io InternetAddress.lookup`) resolves at the OS kernel level in milliseconds, consumes no data, and never hits a flaky third-party server. The Dio interceptor is the most truthful signal: if the app's own API responded, the connection is real.

**What the user sees:**

| Scenario | UX |
|---|---|
| Internet drops mid-session | A red pill banner slides in from the top: *"No Internet Connection"*. The user keeps browsing cached data. |
| Internet returns | The banner turns green: *"Internet connection restored"*, then auto-dismisses after 3 seconds. |
| Cold start with no connection and no cache | Full-screen retry page (`InternetConnection`) with a Retry button. |

Key files:

| File | Role |
|---|---|
| `core/network/network_info.dart` | `NetworkInfo` interface + `NetworkInfoImpl` (DNS + checker) |
| `core/shared/network/presentation/cubit/` | `NetworkCubit` + `NetworkState` |
| `core/shared/network/presentation/widgets/offline_banner.dart` | Non-intrusive animated banner |
| `core/shared/network/presentation/screens/no_internet_connection_page.dart` | Full-screen fallback for critical flows |
| `core/network/app_interceptors.dart` | Dio `onResponse` / `onError` wired to the cubit |

## What is intentional

- No domain layer. A use case that only calls the repository is noise.
- One `AuthCubit` for login, OTP, profile, and logout. Profile is not a second cubit.
- One `AdsCubit` for the feed and favorites.
- Lookup lists (`OthersCubit`) are one state with a status per list, so loading cities does not wipe categories.
- Errors are `errorMessage` on the state. The screen listener shows the toast. The cubit does not navigate.
