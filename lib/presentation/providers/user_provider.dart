import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/user_repository_impl.dart';
import '../../data/services/api_service.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/get_users.dart';

// Provider for ApiService
final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService(
    Dio(
      BaseOptions(
        //baseUrl: 'https://jsonplaceholder.typicode.com/',
        // connectTimeout: Duration(milliseconds: 3000),
        // receiveTimeout: Duration(milliseconds: 3000),
      ),
    ),
  );
});

// Provider for UserRepository
final userRepositoryProvider = Provider<UserRepositoryImpl>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return UserRepositoryImpl(apiService);
});

// Provider for GetUsers use case
final getUsersProvider = Provider<GetUsers>((ref) {
  final repository = ref.watch(userRepositoryProvider);
  return GetUsers(repository);
});

// State for user data
class UserState {
  final bool isLoading;
  final List<User>? users;
  final String? error;

  UserState({this.isLoading = false, this.users, this.error});

  UserState copyWith({bool? isLoading, List<User>? users, String? error}) {
    return UserState(
      isLoading: isLoading ?? this.isLoading,
      users: users ?? this.users,
      error: error ?? this.error,
    );
  }
}

// StateNotifier for managing user data
class UserNotifier extends StateNotifier<UserState> {
  final GetUsers _getUsers;

  UserNotifier(this._getUsers) : super(UserState()) {
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final users = await _getUsers();
      state = state.copyWith(isLoading: false, users: users);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}

// Provider for UserNotifier
final userProvider = StateNotifierProvider<UserNotifier, UserState>((ref) {
  final getUsers = ref.watch(getUsersProvider);
  return UserNotifier(getUsers);
});
