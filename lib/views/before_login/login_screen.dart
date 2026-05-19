import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../main.dart';
import '../../routes/app_routes.dart';
import 'register_screen.dart';
import '../../model/book_model.dart';
import '../../res/app_colors.dart';
import '../../utils/text_style.dart';
import '../custom_widgts/book_cover_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.navy,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              // Back
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.navyLight,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.arrow_back_ios_new_rounded,
                      size: 16, color: AppColors.textPrimary),
                ),
              ),

              const SizedBox(height: 24),

              const Text('WELCOME BACK', style: AppTextStyles.labelLarge),
              const SizedBox(height: 6),
              const Text('Login to Audiara', style: AppTextStyles.displayMedium),

              const SizedBox(height: 32),

              _buildLabel('EMAIL'),
              const SizedBox(height: 8),
              _buildField(
                hint: 'you@example.com',
                icon: Icons.mail_outline_rounded,
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 18),

              _buildLabel('PASSWORD'),
              const SizedBox(height: 8),
              _buildField(
                hint: 'Your password',
                icon: Icons.lock_outline_rounded,
                obscure: _obscure,
                suffixIcon: GestureDetector(
                  onTap: () => setState(() => _obscure = !_obscure),
                  child: Icon(
                    _obscure
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: AppColors.accent,
                    size: 20,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Forgot password
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Forgot password?',
                  style: const TextStyle(
                    color: AppColors.accent,
                    fontFamily: 'DMSans',
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              const SizedBox(height: 28),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(

                  onPressed: () =>  Get.offNamed(AppRoutes.mySheel),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('Sign In'),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward_rounded, size: 18),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Row(
                children: [
                  const Expanded(child: Divider(color: AppColors.navyLight)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text('or continue with',
                        style: AppTextStyles.bodySmall),
                  ),
                  const Expanded(child: Divider(color: AppColors.navyLight)),
                ],
              ),

              const SizedBox(height: 16),

              // Social buttons
              Row(
                children: [
                  Expanded(
                    child: _socialBtn(
                      icon: Icons.g_mobiledata_rounded,
                      label: 'Google',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _socialBtn(
                      icon: Icons.apple_rounded,
                      label: 'Apple',
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              Center(
                child: GestureDetector(
                  onTap: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const RegisterScreen()),
                  ),
                  child: RichText(
                    text: const TextSpan(
                      text: 'New here? ',
                      style: TextStyle(
                          color: AppColors.textMuted,
                          fontFamily: 'DMSans',
                          fontSize: 13),
                      children: [
                        TextSpan(
                          text: 'Create Account',
                          style: TextStyle(
                              color: AppColors.accent,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) =>
      Text(text, style: AppTextStyles.labelMedium);

  Widget _buildField({
    required String hint,
    required IconData icon,
    bool obscure = false,
    TextInputType keyboardType = TextInputType.text,
    Widget? suffixIcon,
  }) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: AppColors.navyMid,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.navyLight, width: 1.5),
      ),
      child: Row(
        children: [
          const SizedBox(width: 14),
          Icon(icon, color: AppColors.textMuted, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              obscureText: obscure,
              keyboardType: keyboardType,
              style: const TextStyle(
                  color: AppColors.textMuted,
                  fontFamily: 'DMSans',
                  fontSize: 14),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: AppTextStyles.bodyMedium,
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
          if (suffixIcon != null) ...[
            suffixIcon,
            const SizedBox(width: 14),
          ],
        ],
      ),
    );
  }

  Widget _socialBtn({required IconData icon, required String label}) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: AppColors.navyMid,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.navyLight, width: 1.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: AppColors.textMuted, size: 22),
          const SizedBox(width: 8),
          Text(label,
              style: const TextStyle(
                  color: AppColors.textMuted,
                  fontFamily: 'DMSans',
                  fontSize: 13,
                  fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}