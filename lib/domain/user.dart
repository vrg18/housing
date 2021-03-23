/// сущьность Пользователь приложения
class User {
  final String _phone;
  final String _token;
  final bool _demo;

  User(this._phone, this._token, this._demo);

  get email => _phone;

  get token => _token;

  get demo => _demo;
}
