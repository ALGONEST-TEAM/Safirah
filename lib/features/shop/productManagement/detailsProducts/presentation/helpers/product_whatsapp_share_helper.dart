import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../../../core/network/urls.dart';

String buildProductDeepLink(int productId) =>
    '${AppURL.base}/product/index.html?id=$productId';

String buildProductAppFallbackDeepLink(int productId) =>
    'safirah://product/$productId';

Uri buildSupportWhatsAppUri({String phone = '775076388'}) =>
    Uri.parse('https://wa.me/$phone');

String? normalizeProductShareImageUrl(String? imageUrl) {
  final raw = imageUrl?.trim() ?? '';
  if (raw.isEmpty) return null;

  if (raw.startsWith('http://') || raw.startsWith('https://')) return raw;
  if (raw.startsWith('//')) return 'https:$raw';

  final base = AppURL.base.replaceAll(RegExp(r'/+$'), '');
  final path = raw.replaceAll(RegExp(r'^/+'), '');
  return '$base/$path';
}

Future<File?> cacheProductShareImage({
  required int productId,
  String? imageUrl,
}) async {
  final normalizedUrl = normalizeProductShareImageUrl(imageUrl);
  if (normalizedUrl == null) return null;

  try {
    final uri = Uri.parse(normalizedUrl);
    final fileName = uri.pathSegments.isNotEmpty
        ? uri.pathSegments.last
        : 'product_$productId.jpg';
    final extension = fileName.contains('.')
        ? fileName.substring(fileName.lastIndexOf('.'))
        : '.jpg';

    final tempDir = await getTemporaryDirectory();
    final shareDir = Directory('${tempDir.path}/product_share_cache');
    if (!await shareDir.exists()) {
      await shareDir.create(recursive: true);
    }

    final file = File('${shareDir.path}/product_$productId$extension');
    if (await file.exists() && await file.length() > 0) {
      return file;
    }

    final response = await Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 30),
        responseType: ResponseType.bytes,
      ),
    ).get<List<int>>(normalizedUrl);

    final bytes = response.data;
    if (response.statusCode == null || response.statusCode! < 200 || response.statusCode! >= 300) {
      return null;
    }
    if (bytes == null || bytes.isEmpty) return null;

    await file.writeAsBytes(bytes, flush: true);
    return file;
  } catch (_) {
    return null;
  }
}

String buildProductWhatsAppMessage({
  required int productId,
  required String name,
  required String price,
  String? imageUrl,
}) {
  final normalizedName = name.trim();
  final normalizedPrice = price.trim();
  final webLink = buildProductDeepLink(productId);
  final appLink = buildProductAppFallbackDeepLink(productId);

  return <String>[
    'منتج من صافرة',
    if (normalizedName.isNotEmpty) 'الاسم: $normalizedName',
    if (normalizedPrice.isNotEmpty) 'السعر: $normalizedPrice',
    'افتح المنتج مباشرة:',
    webLink,
    'إذا لم يفتح الرابط داخل التطبيق تلقائيًا، استخدم هذا الرابط داخل التطبيق:',
    appLink,
  ].join('\n');
}
