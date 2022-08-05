class FirestorePaths {
  // User
  static String get userCollection => 'users';

  // user document
  static String userDocument(String docId) => 'users/$docId';

  // user history document
  static String userHistoryDocument(String docId) => 'users/$docId/history';

  // care takers available
  static String usersAvailableCollection(String docId) => 'users_available/$docId';

  // ride request path
  static String eventRequestCollection(String rideId) => 'event_request/$rideId';

  // FirebaseStorage
  static String profilesImagesPath(String userId) => 'users/$userId/$userId';
}
