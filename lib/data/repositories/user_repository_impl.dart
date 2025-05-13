import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../services/api_service.dart';

class UserRepositoryImpl implements UserRepository {
  final ApiService apiService;

  UserRepositoryImpl(this.apiService);

  @override
  Future<List<User>> getUsers() async {
    // try {
    final userModels = await apiService.getUsers();
    return userModels.users; // UserModel extends User, so no mapping needed
    // } catch (e) {
    //   throw Exception('Failed to fetch users: $e');
    // }
  }
}
