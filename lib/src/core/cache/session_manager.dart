

///SessionManager = memory only
///data is lost when the app is closed or restarted,
/// but it allows for quick access to the current user's information during the app's runtime.
/// This can be particularly useful for managing user state in a way that doesn't require persistent storage,
/// such as SharedPreferences or secure storage, which may be used for more long-term session management.
class SessionManager {
  //   User? _currentUser;
  //
  //   User? get currentUser => _currentUser;
  //
  //   bool get isUserLoggedIn => _currentUser != null;
  //
  //   // Call this after a successful login or profile fetch
  //   void startSession(User user) {
  //     _currentUser = user;
  //   }
  //
  //   // Call this on logout or when the session is invalidated
  //   void clearSession() {
  //     _currentUser = null;
  //   }
}
