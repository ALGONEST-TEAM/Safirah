// lib/core/sync/maltipart_payload.dart
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

class MultipartPayload {
  /// Converts `data` to FormData only if `__files` exists.
  /// Supports PHP-style nested keys:
  /// - map:   league[name]
  /// - list:  teams[0][name]
  static Future<dynamic> maybeToFormData(Map<String, dynamic> data) async {
    final files = _extractFiles(data);
    if (files.isEmpty) return data;

    final form = FormData();

    // 1) add non-file fields (flatten to PHP-style keys)
    final cleaned = Map<String, dynamic>.from(data)..remove('__files');
    _addFields(form, cleaned);

    // 2) add files
    for (final f in files) {
      final field = (f['field'] ?? '').toString();
      final path = (f['path'] ?? '').toString();
      if (field.isEmpty || path.isEmpty) continue;

      final file = File(path);
      final exists = await file.exists();
      if (!exists) {
        throw DioException(
          requestOptions: RequestOptions(path: 'multipart'),
          error: 'Missing file at path=$path for field=$field',
          type: DioExceptionType.unknown,
        );
      }

      final filename = (f['filename'] ?? path.split(Platform.pathSeparator).last).toString();
      final contentType = (f['contentType'] ?? '').toString();

      MediaType? mediaType;
      if (contentType.isNotEmpty && contentType.contains('/')) {
        final parts = contentType.split('/');
        mediaType = MediaType(parts[0], parts[1]);
      }

      form.files.add(
        MapEntry(
          field,
          await MultipartFile.fromFile(
            path,
            filename: filename,
            contentType: mediaType,
          ),
        ),
      );
    }

    return form;
  }

  static List<Map<String, dynamic>> _extractFiles(Map<String, dynamic> data) {
    final raw = data['__files'];
    if (raw is List) {
      return raw.whereType<Map>().map((e) => Map<String, dynamic>.from(e)).toList();
    }
    return const [];
  }

  static void _addFields(FormData form, Map<String, dynamic> map, {String? prefix}) {
    for (final entry in map.entries) {
      final key = prefix == null ? entry.key : '$prefix[${entry.key}]';
      final value = entry.value;

      if (value == null) continue;

      if (value is Map) {
        _addFields(form, value.cast<String, dynamic>(), prefix: key);
        continue;
      }

      if (value is List) {
        _addList(form, key, value);
        continue;
      }

      // Scalars: String/num/bool/DateTime
      form.fields.add(MapEntry(key, _scalarToString(value)));
    }
  }

  static void _addList(FormData form, String key, List list) {
    for (var i = 0; i < list.length; i++) {
      final itemKey = '$key[$i]';
      final item = list[i];

      if (item == null) continue;

      if (item is Map) {
        _addFields(form, item.cast<String, dynamic>(), prefix: itemKey);
        continue;
      }

      if (item is List) {
        _addList(form, itemKey, item);
        continue;
      }

      form.fields.add(MapEntry(itemKey, _scalarToString(item)));
    }
  }

  static String _scalarToString(Object v) {
    if (v is DateTime) return v.toIso8601String();
    if (v is bool) return v ? '1' : '0';
    return v.toString();
  }
}