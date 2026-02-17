import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static void removeKey(String key) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(key)) {
      prefs.remove(key);
    }
  }

  static Future<bool> versionChanged(String currentVersion) async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'version';
    String? lastSavedVersion = prefs.getString(key);

    if (lastSavedVersion != null) {
      if (lastSavedVersion != currentVersion) {
        saveVersion(currentVersion);
        return true;
      } else {
        return false;
      }
    } else {
      saveVersion(currentVersion);
      return false;
    }
  }

  static void saveVersion(String currentVersion) async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'version';
    prefs.setString(key, currentVersion);
  }

  static Future<String> readLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'language';
    return prefs.getString(key) ?? 'en_GB';
  }

  static void saveLanguage(String language) async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'language';
    prefs.setString(key, language);
  }

  static Future<String> readTimeFormat() async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'timeformat';
    return prefs.getString(key) ?? 'h:mm a';
  }

  static void saveTimeFormat(String timeFormat) async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'timeformat';
    prefs.setString(key, timeFormat);
  }

  static Future<String> readMainColor() async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'mainColor';
    return prefs.getString(key) ?? '0xff8800ff';
  }

  static void saveMainColor(String mainColor) async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'mainColor';
    prefs.setString(key, mainColor);
  }

  static void deleteMainColor() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('mainColor');
  }

  static Future<ImageProvider> readBgFilePath() async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'bgFilePath';
    String bgFilePath = prefs.getString(key) ?? 'assets/images/leaves.jpg';
    if (!await File(bgFilePath).exists()) {
      return const AssetImage('assets/images/leaves.jpg');
    } else {
      return FileImage(File(bgFilePath));
    }
  }

  static void saveBgFilePath(String bgFilePath) async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'bgFilePath';
    prefs.setString(key, bgFilePath);
  }

  static void deleteBgImagePath() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('bgFilePath');
  }

  static void saveCustomAlarmSoundPath(String customAlarmSoundPath) async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'customAlarmSoundPath';
    prefs.setString(key, customAlarmSoundPath);
  }

  static Future<String> readCustomAlarmSoundPath() async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'customAlarmSoundPath';
    String customAlarmSoundPath = prefs.getString(key) ?? '';
    if (customAlarmSoundPath != '' &&
        !await File(customAlarmSoundPath).exists()) {
      saveAlarmSoundIndex('0');
      return '';
    } else {
      return customAlarmSoundPath;
    }
  }

  static void saveAlarmSoundIndex(String alarmSoundIndex) async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'alarmSoundIndex';
    prefs.setString(key, alarmSoundIndex);
  }

  static Future<String> readAlarmSoundIndex() async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'alarmSoundIndex';
    return prefs.getString(key) ?? '0';
  }

  static void saveGlobalAlarmSoundVolume(String globalAlarmSoundVolume) async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'globalAlarmSoundVolume';
    prefs.setString(key, globalAlarmSoundVolume.toString());
  }

  static Future<String> readGlobalAlarmSoundVolume() async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'globalAlarmSoundVolume';
    return prefs.getString(key) ?? '60';
  }

  static void saveAlarmSnoozeIndex(String alarmSnoozeIndex) async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'alarmSnoozeIndex';
    prefs.setString(key, alarmSnoozeIndex);
  }

  static Future<String> readAlarmSnoozeIndex() async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'alarmSnoozeIndex';
    return prefs.getString(key) ?? '1';
  }

  // TODO: remove at 01.06.1026
  static void deleteAdjustDatabase() async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'databaseAdjustment';
    prefs.containsKey(key) ? prefs.remove('databaseAdjustment') : null;
  }
}
