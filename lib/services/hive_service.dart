import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static const String userId = 'userId';
  static const String isStaff = 'isStaff';
  static const String userData = 'userData';
  static final HiveService _instance = HiveService._internal();
  factory HiveService() => _instance;
  HiveService._internal();

  late Box _box;

  Future<void> init() async {
    await Hive.initFlutter();

    _box = await Hive.openBox('shivam_store');
  }

  // Save a value
  Future<void> setValue(String key, dynamic value) async {
    await _box.put(key, value);
  }

  // Get a value
  T? getValue<T>(String key) {
    return _box.get(key) as T?;
  }

  // Delete a value
  Future<void> deleteValue(String key) async {
    await _box.delete(key);
  }

  // Clear all values
  Future<void> clearAll() async {
    await _box.clear();
  }

  // Check if key exists
  bool containsKey(String key) {
    return _box.containsKey(key);
  }
}
