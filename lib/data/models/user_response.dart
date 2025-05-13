import 'package:json_annotation/json_annotation.dart';
import 'user_model.dart';

part 'user_response.g.dart';

@JsonSerializable()
class UserResponse {
  final List<UserModel> users;

  UserResponse({required this.users});

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}
