import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:skillify/core/logging/app_logger.dart';
import 'package:skillify/core/services/network/interceptors/logger_interceptor.dart';

void main() {
  test('DioLogger logs a FormData body without throwing', () {
    AppLogger.setEnabled(true);
    final logger = DioLogger();

    final form = FormData();
    form.fields
      ..add(const MapEntry('Bio', 'test bio'))
      ..add(const MapEntry('OfferedMainSkill', '30'));
    form.files.add(
      MapEntry(
        'ProfilePicture',
        MultipartFile.fromBytes([1, 2, 3], filename: 'photo.png'),
      ),
    );

    final options = RequestOptions(path: '/Users/me/profile', method: 'PUT')
      ..data = form;

    expect(
      () => logger.onRequest(options, RequestInterceptorHandler()),
      returnsNormally,
    );
  });

  test('DioLogger still logs a JSON map body without throwing', () {
    AppLogger.setEnabled(true);
    final logger = DioLogger();

    final options = RequestOptions(path: '/Users/login', method: 'POST')
      ..data = {'email': 'a@b.com', 'password': 'x'};

    expect(
      () => logger.onRequest(options, RequestInterceptorHandler()),
      returnsNormally,
    );
  });
}
