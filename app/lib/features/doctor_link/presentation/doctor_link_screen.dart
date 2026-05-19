import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/widgets/app_buttons.dart';
import '../../../core/widgets/doctor_avatar.dart';
import '../../../core/widgets/app_status_indicator.dart';
import '../../../core/utils/mock_repositories.dart';
import '../../../l10n/l10n_extension.dart';

class DoctorLinkScreen extends StatefulWidget {
  const DoctorLinkScreen({super.key});

  @override
  State<DoctorLinkScreen> createState() => _DoctorLinkScreenState();
}

class _DoctorLinkScreenState extends State<DoctorLinkScreen> {
  bool _showConfirmation = false;
  bool _isLoading = false;

  void _startLinking() {
    setState(() => _isLoading = true);
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _showConfirmation = true;
        });
      }
    });
  }

  void _showManualInputDialog() {
    final controller = TextEditingController();
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(context.l10n.enterDoctorId),
        content: Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: CupertinoTextField(
            controller: controller,
            placeholder: context.l10n.doctorId,
            autofocus: true,
            style: const TextStyle(color: CupertinoColors.label),
          ),
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.pop(context),
            child: Text(context.l10n.cancel),
          ),
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              if (controller.text.isNotEmpty) {
                Navigator.pop(context);
                _startLinking();
              }
            },
            child: Text(context.l10n.confirm),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: AppStatusIndicator(isDoctorLinked: _showConfirmation),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: [
              if (!_showConfirmation) ... [
                const SizedBox(height: 20),
                Text(
                  context.l10n.linkWithDoctor,
                  style: TextStyle(
                    fontSize: 24, 
                    fontWeight: FontWeight.bold, 
                    fontFamily: 'SF Pro',
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  context.l10n.linkWithDoctorDescription,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: theme.textTheme.bodySmall?.color, 
                    fontSize: 14,
                  ),
                ),
                const Spacer(),
                Icon(Icons.qr_code_scanner, size: 80, color: theme.colorScheme.onSurface.withOpacity(0.3)),
                const Spacer(),
                AppPrimaryButton(
                  text: context.l10n.scanQrCode,
                  onPressed: _startLinking,
                  isLoading: _isLoading,
                ),
                const SizedBox(height: 12),
                AppSecondaryButton(
                  text: context.l10n.proceedManually,
                  onPressed: _showManualInputDialog,
                ),
              ] else ...[
                const SizedBox(height: 20),
                Text(
                  context.l10n.doctorFound,
                  style: TextStyle(
                    fontSize: 24, 
                    fontWeight: FontWeight.bold, 
                    fontFamily: 'SF Pro',
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 40),
                Consumer(
                  builder: (context, ref, child) {
                    final doctor = ref.watch(mockDoctorProvider);
                    return Column(
                      children: [
                        DoctorAvatar(name: doctor.name, radius: 50, fontSize: 32),
                        const SizedBox(height: 24),
                        Text(
                          doctor.name,
                          style: TextStyle(
                            fontSize: 20, 
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildInfoRow(Icons.medical_services_outlined, doctor.specialty, theme),
                        const SizedBox(height: 8),
                        _buildInfoRow(Icons.location_on_outlined, doctor.workplace, theme),
                      ],
                    );
                  },
                ),
                const Spacer(),
                AppPrimaryButton(
                  text: context.l10n.confirmAndLink,
                  onPressed: () => context.go('/home'),
                ),
                const SizedBox(height: 12),
                AppSecondaryButton(
                  text: context.l10n.rescanQrCode,
                  onPressed: () => setState(() => _showConfirmation = false),
                ),
              ],
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text, ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 16, color: theme.textTheme.bodySmall?.color),
        const SizedBox(width: 8),
        Text(
          text, 
          style: TextStyle(color: theme.textTheme.bodySmall?.color),
        ),
      ],
    );
  }
}
