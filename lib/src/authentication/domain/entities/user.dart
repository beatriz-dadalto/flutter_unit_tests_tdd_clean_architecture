import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.avatar,
  });

  const User.empty()
    : this(
        id: '1',
        createdAt: '_empty.createdAt',
        name: '_empty.name',
        avatar: '_empty.avatar',
      );

  final String id;
  final String name;
  final String createdAt;
  final String avatar;

  @override
  String toString() {
    return 'User(id: $id, name: $name, createdAt: $createdAt, avatar: $avatar)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.id == id &&
        other.name == name &&
        other.createdAt == createdAt &&
        other.avatar == avatar;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ createdAt.hashCode ^ avatar.hashCode;
  }

  @override
  List<Object?> get props => [id, name, avatar];
}
