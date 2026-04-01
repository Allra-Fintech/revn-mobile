import 'package:flutter/material.dart';

class SocialLinkNoticeCard extends StatelessWidget {
  const SocialLinkNoticeCard({
    super.key,
    required this.title,
    required this.description,
    this.primaryActionLabel,
    this.onPrimaryAction,
    this.secondaryActionLabel,
    this.onSecondaryAction,
    this.onDismiss,
  });

  final String title;
  final String description;
  final String? primaryActionLabel;
  final VoidCallback? onPrimaryAction;
  final String? secondaryActionLabel;
  final VoidCallback? onSecondaryAction;
  final VoidCallback? onDismiss;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final hasActions =
        (primaryActionLabel != null && onPrimaryAction != null) ||
        (secondaryActionLabel != null && onSecondaryAction != null);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          if (hasActions) ...[
            const SizedBox(height: 16),
            Row(
              children: [
                if (primaryActionLabel != null && onPrimaryAction != null)
                  Expanded(
                    child: FilledButton(
                      onPressed: onPrimaryAction,
                      child: Text(primaryActionLabel!),
                    ),
                  ),
                if (primaryActionLabel != null &&
                    onPrimaryAction != null &&
                    secondaryActionLabel != null &&
                    onSecondaryAction != null)
                  const SizedBox(width: 12),
                if (secondaryActionLabel != null && onSecondaryAction != null)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: onSecondaryAction,
                      child: Text(secondaryActionLabel!),
                    ),
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
