import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hec_app/core/widgets/dot_stepper.dart';
import 'package:hec_app/core/widgets/app_buttons.dart';
import 'package:hec_app/core/widgets/app_text_fields.dart';
import 'package:hec_app/core/widgets/logo.dart';
import 'package:hec_app/l10n/l10n_extension.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final PageController _pageController = PageController();
  static final int _maxSteps = 3;
  int _currentStep = 0;
  bool _isCreatingAccount = false;
  String? _selectedRole;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _nextStep() {
    if (_currentStep < _maxSteps) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() => _currentStep++);
    } else {
      _createAccount();
    }
  }

  void _createAccount() async {
    setState(() => _isCreatingAccount = true);
    // Simulate account creation
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      context.go('/doctor-link');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    if (_isCreatingAccount) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppLogo(size: 72),
              const Gap(32),
              Text(
                context.l10n.creatingAccount,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20, 
                  fontWeight: FontWeight.bold, 
                  fontFamily: 'SF Pro',
                  color: theme.colorScheme.onSurface,
                ),
              ),
              const Gap(24),
              const CupertinoActivityIndicator(),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: _currentStep > 0
            ? IconButton(
                icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                onPressed: () {
                  _pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                  setState(() => _currentStep--);
                },
              )
            : null,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            children: [
              _buildProgressIndicator(isDark),
              const Gap(40),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _buildRoleSelection(theme),
                    _buildStep(
                      title: context.l10n.howShouldWeCallYou,
                      child: AppTextField(
                        label: context.l10n.fullName,
                        hint: context.l10n.fullNameHint,
                        controller: _nameController,
                        prefixIcon: const Icon(Icons.person_outline),
                      ),
                    ),
                    _buildStep(
                      title: context.l10n.registrationGreeting(_nameController.text.split(' ').first),
                      child: AppTextField(
                        label: context.l10n.email,
                        hint: context.l10n.emailHint,
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: const Icon(Icons.email_outlined),
                      ),
                    ),
                    _buildStep(
                      title: context.l10n.passwordTitle,
                      child: AppTextField(
                        label: context.l10n.password,
                        hint: context.l10n.passwordHint,
                        controller: _passwordController,
                        obscureText: true,
                        prefixIcon: const Icon(Icons.lock_outline),
                      ),
                    ),
                  ],
                ),
              ),
              if (_currentStep == 0) ...[
                const Spacer(),
                Text(context.l10n.alreadyHaveAccount, style: const TextStyle(color: Colors.blue, fontSize: 12)),
                const Gap(20),
              ] else ... [
                AppCircularNextButton(onPressed: _nextStep),
                const Gap(30),
                DotStepper(amount: _maxSteps, index: _currentStep),
                const Gap(50)
              ]
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgressIndicator(bool isDark) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildDot(0, Icons.person, Colors.red, isDark),
        _buildLine(0, isDark),
        _buildDot(1, Icons.circle, Colors.grey.shade400, isDark, isSmall: true),
        _buildLine(1, isDark),
        _buildDot(3, Icons.medical_services, Colors.blue, isDark),
      ],
    );
  }

  Widget _buildDot(int step, IconData icon, Color color, bool isDark, {bool isSmall = false}) {
    final isActive = _currentStep >= step;
    return Container(
      padding: EdgeInsets.all(isSmall ? 4 : 8),
      decoration: BoxDecoration(
        color: isActive ? color : (isDark ? Colors.grey.shade800 : Colors.grey.shade200),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: Colors.white, size: isSmall ? 8 : 14),
    );
  }

  Widget _buildLine(int step, bool isDark) {
    return Container(
      width: 30,
      height: 2,
      color: _currentStep > step 
          ? (isDark ? Colors.grey.shade600 : Colors.grey.shade400) 
          : (isDark ? Colors.grey.shade800 : Colors.grey.shade200),
    );
  }

  Widget _buildRoleSelection(ThemeData theme) {
    return Column(
      children: [
        Text(
          context.l10n.appName,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: theme.colorScheme.onSurface),
        ),
        const Gap(8),
        Text(
          context.l10n.selectRole,
          textAlign: TextAlign.center,
          style: TextStyle(color: theme.textTheme.bodySmall?.color, fontSize: 14),
        ),
        const Gap(60),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildRoleCard(context.l10n.doctor, Colors.red, 'doctor', theme),
            const Gap(24),
            _buildRoleCard(context.l10n.patient, Colors.blue, 'patient', theme),
          ],
        ),
      ],
    );
  }

  Widget _buildRoleCard(String label, Color color, String role, ThemeData theme) {
    final isSelected = _selectedRole == role;
    return GestureDetector(
      onTap: () {
        setState(() => _selectedRole = role);
        _nextStep();
      },
      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(24),
              border: isSelected ? Border.all(color: theme.colorScheme.onSurface, width: 2) : null,
            ),
          ),
          const Gap(12),
          Text(
            label, 
            style: TextStyle(
              fontWeight: FontWeight.w500, 
              color: theme.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep({required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            fontFamily: 'SF Pro',
            height: 1.2,
          ),
        ),
        const Gap(32),
        child,
      ],
    );
  }
}
