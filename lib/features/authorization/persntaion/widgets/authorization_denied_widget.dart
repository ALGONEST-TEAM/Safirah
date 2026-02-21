import 'package:flutter/material.dart';

class AuthorizationDeniedWidget extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final VoidCallback? onRetry;

  const AuthorizationDeniedWidget({
    super.key,
    this.title,
    this.subtitle,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final t = title ?? 'لا تملك صلاحية الوصول';
    final s = subtitle ?? 'ليس لديك الصلاحية اللازمة لتنفيذ هذا الإجراء.';

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.lock_outline, size: 44),
            const SizedBox(height: 12),
            Text(t, style: Theme.of(context).textTheme.titleMedium, textAlign: TextAlign.center),
            const SizedBox(height: 8),
            Text(s, style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center),
            if (onRetry != null) ...[
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: onRetry,
                child: const Text('إعادة المحاولة'),
              )
            ]
          ],
        ),
      ),
    );
  }
}

