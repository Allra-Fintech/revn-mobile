import 'package:flutter/material.dart';
import 'package:revn/app/theme/app_component_themes.dart';

class SocialLinkNoticeCard extends StatefulWidget {
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
  State<SocialLinkNoticeCard> createState() => _SocialLinkNoticeCardState();
}

class _SocialLinkNoticeCardState extends State<SocialLinkNoticeCard> {
  /// Fade-in target: false until first frame, then true (matches TDD expectations).
  bool _fadeInTarget = false;

  /// After dismiss, content is removed so [AnimatedSize] can collapse.
  bool _removed = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() => _fadeInTarget = true);
      }
    });
  }

  void _handleDismiss() {
    setState(() => _removed = true);
    Future.delayed(const Duration(milliseconds: 250), () {
      if (mounted) {
        widget.onDismiss?.call();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final hasActions =
        (widget.primaryActionLabel != null && widget.onPrimaryAction != null) ||
        (widget.secondaryActionLabel != null &&
            widget.onSecondaryAction != null);

    final opacity = _removed ? 0.0 : (_fadeInTarget ? 1.0 : 0.0);

    return AnimatedOpacity(
      opacity: opacity,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      child: AnimatedSize(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeIn,
        child: _removed
            ? const SizedBox.shrink()
            : Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                    AppComponentThemes.cardBorderRadius,
                  ),
                  border: Border.all(color: colorScheme.outlineVariant),
                ),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: widget.onDismiss != null
                              ? const EdgeInsets.only(right: 32)
                              : EdgeInsets.zero,
                          child: Text(
                            widget.title,
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.description,
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: colorScheme.onSurfaceVariant),
                        ),
                        if (hasActions) ...[
                          const SizedBox(height: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              if (widget.primaryActionLabel != null &&
                                  widget.onPrimaryAction != null)
                                FilledButton(
                                  onPressed: widget.onPrimaryAction,
                                  child: Text(widget.primaryActionLabel!),
                                ),
                              if (widget.primaryActionLabel != null &&
                                  widget.onPrimaryAction != null &&
                                  widget.secondaryActionLabel != null &&
                                  widget.onSecondaryAction != null)
                                const SizedBox(height: 12),
                              if (widget.secondaryActionLabel != null &&
                                  widget.onSecondaryAction != null)
                                OutlinedButton(
                                  onPressed: widget.onSecondaryAction,
                                  child: Text(widget.secondaryActionLabel!),
                                ),
                            ],
                          ),
                        ],
                      ],
                    ),
                    if (widget.onDismiss != null)
                      Positioned(
                        right: 0,
                        top: 0,
                        child: InkWell(
                          onTap: _handleDismiss,
                          borderRadius: BorderRadius.circular(20),
                          child: Padding(
                            padding: const EdgeInsets.all(4),
                            child: Icon(
                              Icons.close,
                              size: 20,
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
      ),
    );
  }
}
