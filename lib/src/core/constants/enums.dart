// --------------------------- Bloc Enums ---------------------------

enum RequestState { loading, success, error, initial }

enum AppbarIcons { logo, drawer, search, chat }

/// Generated enums derived from const.php to provide strong typing in the app.
///
/// Notes:
/// - Each enum has a `code` getter that returns the backend string code.
/// - Each enum has a `fromCode` that safely converts a backend code to the enum.
/// - Keep labels/i18n out of enums; localize via ARB or use server-provided labels.
