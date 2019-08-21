import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_share/image_share.dart';

void main() {
  const MethodChannel channel = MethodChannel('de/brandad-systems/socialdear/image_share');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await ImageShare.platformVersion, '42');
  });
}
