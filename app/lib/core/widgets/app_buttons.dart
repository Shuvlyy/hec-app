import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppPrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;

  const AppPrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            fontFamily: 'SF Pro',
          ),
        ),
        child: isLoading
            ? const CupertinoActivityIndicator(color: Colors.white)
            : Text(text),
      ),
    );
  }
}

class AppSecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const AppSecondaryButton({
    super.key,
    required this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          foregroundColor: Theme.of(context).colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontFamily: 'SF Pro',
          ),
        ),
        child: Text(text),
      ),
    );
  }
}

class AppCircularNextButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isLoading;

  const AppCircularNextButton({
    super.key,
    this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return SizedBox(
      width: 64,
      height: 64,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isDarkMode ? Colors.grey.shade900 : Colors.white,
          foregroundColor: isDarkMode ? Colors.white : Colors.black,
          elevation: 2,
          padding: EdgeInsets.zero,
          shape: const CircleBorder(),
          side: BorderSide(color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200),
        ),
        child: isLoading
            ? CupertinoActivityIndicator(color: isDarkMode ? Colors.white : Colors.black)
            : const Icon(Icons.arrow_forward_ios, size: 24),
      ),
    );
  }
}
