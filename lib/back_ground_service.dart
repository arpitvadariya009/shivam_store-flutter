import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'package:shivam_stores/services/hive_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@pragma('vm:entry-point') // Required for background isolates
class BackgroundLocation {
  // Optional: Opens battery settings to disable optimization
  static Future<void> openBatterySettings() async {
    final intent = AndroidIntent(
      action: 'android.settings.IGNORE_BATTERY_OPTIMIZATION_SETTINGS',
    );
    await intent.launch();
  }

  /// Request permissions and ensure they are granted
  static Future<bool> ensurePermissionsReady() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print("🔴 Location service not enabled");
      await Geolocator.openLocationSettings();
      return false;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
    }

    if (permission != LocationPermission.always) {
      print("🔴 Location permission is not 'always'");
      await Geolocator.openAppSettings(); // User must manually allow "Always"
      return false;
    }

    print("✅ All location permissions are set");
    return true;
  }

  // @pragma('vm:entry-point')
  static Future<void> getLocationInBackground() async {
    try {
      print("🚀 Running getLocationInBackground...");

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission != LocationPermission.always) {
        print("🔴 Background location permission not granted");
        return;
      }

      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        print("🔴 Location service not enabled");
        return;
      }

      Position? position;

      try {
        position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
          timeLimit: const Duration(seconds: 10),
        );
        await HiveService().setValue(
          HiveService.location,
          "${position.latitude},${position.longitude}",
        );
      } catch (e) {
        print("⚠️ Reverting to last known location");
        position = await Geolocator.getLastKnownPosition();
      }

      if (position != null) {
        // 2. Get address from coordinates
        String address = 'Unknown';
        try {
          List<Placemark> placemarks = await placemarkFromCoordinates(
            position.latitude,
            position.longitude,
          );

          if (placemarks.isNotEmpty) {
            final place = placemarks.first;
            address =
                "${place.street}, ${place.subLocality}, ${place.locality}, ${place.administrativeArea}, ${place.postalCode}";
          }
        } catch (e) {
          print("⚠️ Failed to get address: $e");
        }

        print("📍 Location: ${position.latitude}, ${position.longitude}");
        try {
          // await Supabase.initialize(
          //   url: 'https://aykepdtrxxpbsmhfcsgj.supabase.co',
          //   anonKey:
          //       'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImF5a2VwZHRyeHhwYnNtaGZjc2dqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTEwODcyOTUsImV4cCI6MjA2NjY2MzI5NX0.XcQwPsRlYuIz5z7F2uwAEuCQKxMwVTYMsOl-tWNNKuQ', // ✅ Replace with your Supabase anon/public key
          // );
          // final supabase = Supabase.instance.client;

          // final response = await supabase.from('location').insert({
          //   'latitude': position.latitude,
          //   'longitude': position.longitude,
          //   'address': address,
          // });

          // print('✅ Location inserted: $response');
        } catch (e) {
          print('❌ Failed to insert location: $e');
        }
      } else {
        print("❌ Failed to get any location");
      }
    } catch (e) {
      print("❌ Error in background: $e");
    }
  }

  /// Schedule the task to run every 15 minutes
  @pragma('vm:entry-point')
  static Future<void> addScheduler() async {
    WidgetsFlutterBinding.ensureInitialized();

    // await AndroidAlarmManager.cancel(999); // Avoid duplicates
    await AndroidAlarmManager.periodic(
      const Duration(minutes: 1),
      999,
      getLocationInBackground,
      wakeup: true,
      exact: true,
      rescheduleOnReboot: true,
    );
    print("⏰ AlarmManager scheduled every 15 minutes");
  }
}
