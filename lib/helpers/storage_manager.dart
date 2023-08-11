import 'package:get_storage/get_storage.dart';
import 'package:students/models/auth/user.dart';

/// Storage manager to store and retrieve data from local storage
class StorageManager {
  static final StorageManager _instance = StorageManager._internal();

  factory StorageManager() {
    return _instance;
  }

  StorageManager._internal();

  final String authToken = 'auth_token';
  final String currentUser = 'current_user'; // represent a single user that are current login
  final String allUsers = 'all_users'; // represet all users from users are from single login
  final String isLogin = 'isLogin'; // quick check to user is logged in or not
  final String pdfAuthToken = 'pdfAuthToken';

  GetStorage localStorage = GetStorage();

  /// set auth token after login-signup
  void setAuthToken(String token) {
    localStorage.write(authToken, token);
  }

  /// get auth token
  String? getAuthToken() {
    return localStorage.read(authToken);
  }

  /// set current user
  void setCurrentUserToLocalStorage(User? user) {
    localStorage.write(currentUser, user);
  }

  /// get current user
  User? getCurrentUserFromLocalStorage() {
    var user = localStorage.read(currentUser);
    if (user == null || user is User) {
      return user;
    } else {
      return User.fromJson(user);
    }
  }

  /// set all users
  void setUsersToLocalStorage(List<User>? users) {
    localStorage.write(allUsers, users);
  }

  /// get all users
  List<User>? getUsersFromLocalStorage() {
    return localStorage.read(allUsers);
  }

  /// set bool for user logged in or not
  void setUserIsLoggedIn(bool isLoggedIn) {
    localStorage.write(isLogin, isLoggedIn);
  }

  /// get bool for user logged in or not
  bool? getUserIsLogeedInFromLocalStorage() {
    return localStorage.read(isLogin);
  }

  void setPdfAuthToken(String token) {
    localStorage.write(pdfAuthToken, token);
  }

  String? getPdfAuthTokenFromLocalStorage() {
    return localStorage.read(pdfAuthToken);
  }

  /// Clear all data stored in local
  void clearSession() {
    localStorage.erase();
  }
}
