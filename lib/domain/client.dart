/// сущьность Пользователь приложения
class Client {
  final String phone;
  final String? token;
  final bool isDemo;

  Client({required this.phone, this.token, this.isDemo = false});
}
