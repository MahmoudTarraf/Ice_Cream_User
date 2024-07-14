import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';

class SecureStorageService {
  final _storage = const FlutterSecureStorage();

  Future<void> storeThatCondition(String condition) async {
    await _storage.write(key: 'thatCondition', value: condition);
  }

  Future<String?> getThatCondition() async {
    return await _storage.read(key: 'thatCondition');
  }

  //
  Future<void> storeImage(XFile image) async {
    await _storage.write(key: 'image', value: image.path);
  }

  Future getimage() async {
    return await _storage.read(key: 'image');
  }

  //
  Future<void> storeCondition(String condition) async {
    await _storage.write(key: 'condition', value: condition);
  }

  Future<String?> getCondition() async {
    return await _storage.read(key: 'condition');
  }

  Future<void> deleteCondition() async {
    await _storage.delete(key: 'condition');
  }

  //
  Future<void> storeEmail(String email) async {
    await _storage.write(key: 'email', value: email);
  }

  Future<String?> getEmail() async {
    return await _storage.read(key: 'email');
  }
}
