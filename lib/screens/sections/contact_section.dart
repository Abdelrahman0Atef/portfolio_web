import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/responsive.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';
import '../../data/cv_data.dart';
import '../../widgets/contact_button.dart';
import '../../widgets/reveal_on_scroll.dart';
import '../../widgets/section_header.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  Future<void> _open(BuildContext context, Uri uri, String label, String value) async {
    try {
      final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!ok && context.mounted) {
        await _copyFallback(context, label, value);
      }
    } catch (_) {
      if (context.mounted) await _copyFallback(context, label, value);
    }
  }

  Future<void> _copyFallback(
      BuildContext context, String label, String value) async {
    await Clipboard.setData(ClipboardData(text: value));
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Couldn\'t open $label — copied to clipboard instead.'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.inkRaised,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Phone digits stripped of spaces and the leading '+', used for the
    // wa.me deep link. WhatsApp expects a bare international number.
    final whatsappNumber =
        CvData.phone.replaceAll(RegExp(r'[^0-9]'), '');

    final entries = <_Entry>[
      _Entry(
        icon: PhosphorIconsRegular.envelopeSimple,
        label: 'Email',
        value: CvData.email,
        uri: Uri(scheme: 'mailto', path: CvData.email),
      ),
      _Entry(
        icon: PhosphorIconsRegular.whatsappLogo,
        label: 'WhatsApp',
        value: CvData.phone,
        uri: Uri.parse('https://wa.me/$whatsappNumber'),
      ),
      _Entry(
        icon: PhosphorIconsRegular.linkedinLogo,
        label: 'LinkedIn',
        value: CvData.linkedin,
        uri: Uri.parse(CvData.linkedinUrl),
      ),
      _Entry(
        icon: PhosphorIconsRegular.githubLogo,
        label: 'GitHub',
        value: CvData.github,
        uri: Uri.parse(CvData.githubUrl),
      ),
    ];

    // Always 2 columns on anything larger than a phone.
    final cols = context.responsive<int>(sm: 1, md: 2, lg: 2, xl: 2);

    return ContentColumn(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          0,
          context.responsive(sm: 32, md: 44, lg: 56),
          0,
          context.responsive(sm: 24, md: 32, lg: 40),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RevealOnScroll(
              revealKey: const ValueKey('contact_header'),
              child: const SectionHeader(
                index: '05',
                eyebrow: 'Contact',
                title: 'Let\'s build something.',
                subtitle:
                    'Currently open to Flutter roles and freelance work. The fastest reply is via email or LinkedIn.',
              ),
            ),
            const SizedBox(height: 24),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: entries.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: cols,
                mainAxisSpacing: 8,
                crossAxisSpacing: 10,
                childAspectRatio: context.responsive<double>(
                  sm: 3.4,
                  md: 3.0,
                  lg: 3.2,
                  xl: 4.6,
                ),
              ),
              itemBuilder: (_, i) {
                final e = entries[i];
                return RevealOnScroll(
                  revealKey: ValueKey('contact_$i'),
                  delay: Duration(milliseconds: (i % cols) * 80),
                  child: ContactButton(
                    icon: e.icon,
                    label: e.label,
                    value: e.value,
                    onTap: () => _open(context, e.uri, e.label, e.value),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            const _Footer(),
          ],
        ),
      ),
    );
  }
}

class _Entry {
  final IconData icon;
  final String label;
  final String value;
  final Uri uri;
  const _Entry({
    required this.icon,
    required this.label,
    required this.value,
    required this.uri,
  });
}

// kept around so the callout can be re-enabled later without re-implementing
// ignore: unused_element
class _CalloutCard extends StatelessWidget {
  const _CalloutCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.responsive(sm: 18, md: 22, lg: 26)),
      decoration: BoxDecoration(
        color: AppColors.accent.withValues(alpha: 0.04),
        border: Border.all(color: AppColors.accent.withValues(alpha: 0.35)),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppColors.accent,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                'CURRENT STATUS',
                style: AppTheme.mono(
                  size: 11,
                  color: AppColors.accent,
                  letterSpacing: 1.6,
                  weight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Open to opportunities — Flutter roles, contract & full-time.',
            style: AppTheme.display(
              size: context.responsive(sm: 20, md: 22, lg: 26),
              weight: FontWeight.w700,
              color: AppColors.textPrimary,
              letterSpacing: -0.6,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Based in ${CvData.location}. Comfortable working remote or hybrid; happy to chat through a project before any commitment.',
            style: AppTheme.body(
              size: 14,
              color: AppColors.textSecondary,
              height: 1.55,
            ),
          ),
        ],
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(height: 1, color: AppColors.stroke),
          const SizedBox(height: 18),
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 12,
            runSpacing: 12,
            children: [
              Text(
                '© ${DateTime.now().year}  ·  ${CvData.name}',
                style: AppTheme.mono(
                  size: 11,
                  color: AppColors.textSecondary,
                  letterSpacing: 1.2,
                ),
              ),
              Text(
                'BUILT WITH FLUTTER',
                style: AppTheme.mono(
                  size: 11,
                  color: AppColors.textMuted,
                  letterSpacing: 1.6,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Designed and developed end-to-end. View source on GitHub.',
            style: AppTheme.body(
              size: 13,
              color: AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}
