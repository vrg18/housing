/// Настройки доступа к Backend и пр.

const int pinCodeLength = 6;
const String baseUrl = 'http://dev.brain4you.ru';
const String apiAuthMobile = '/api/v1/auth/mobile';
const String apiAuthCustomToken = '/api/v1/auth/customtoken';

const int countdownTimerRepeatedPassword = 61 * 1000; // 61 секунда
