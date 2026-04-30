import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../core/theme/app_colors.dart';
import '../core/theme/app_theme.dart';

class ContactButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback onTap;

  const ContactButton({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.onTap,
  });

  @override
  State<ContactButton> createState() => _ContactButtonState();
}

class _ContactButtonState extends State<ContactButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          // Generous breathing room so the card reads as a primary CTA at the bottom of the page.
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
          decoration: BoxDecoration(
            color:
                _hover ? AppColors.accent.withValues(alpha: 0.05) : AppColors.inkSoft,
            border: Border.all(
              color: _hover
                  ? AppColors.accent.withValues(alpha: 0.5)
                  : AppColors.stroke,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.ink,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.stroke),
                ),
                child: Icon(widget.icon, size: 18, color: AppColors.accent),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.label.toUpperCase(),
                      style: AppTheme.mono(
                        size: 9.5,
                        color: AppColors.textSecondary,
                        letterSpacing: 1.4,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.value,
                      style: AppTheme.body(
                        size: 14.5,
                        weight: FontWeight.w500,
                        color: AppColors.textPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                PhosphorIconsRegular.arrowUpRight,
                size: 16,
                color: _hover ? AppColors.accent : AppColors.textSecondary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
