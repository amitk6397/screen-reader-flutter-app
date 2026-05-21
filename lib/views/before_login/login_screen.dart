import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../res/app_colors.dart';
import '../../routes/app_routes.dart';
import 'package:screen_reader/utils/textstyle.dart';
import 'register_screen.dart';

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
      backgroundColor: AppColors.navy(context),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              // Back Button
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.navyLight(context),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 18,
                    color: AppColors.textPrimary(context),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              Text(
                'WELCOME BACK',
                style: text20(
                  fontWeight: FontWeight.w500,
                  color: AppColors.textMuted(context),
                  context: context,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Login to Audiara',
                style: text26(
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary(context),
                  context: context,
                ),
              ),

              const SizedBox(height: 40),

              // Email Field
              _buildLabel(context, 'EMAIL'),
              const SizedBox(height: 8),
              _buildField(
                context,
                hint: 'you@example.com',
                icon: Icons.mail_outline_rounded,
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 20),

              // Password Field
              _buildLabel(context, 'PASSWORD'),
              const SizedBox(height: 8),
              _buildField(
                context,
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
                    size: 22,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Forgot Password
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    // TODO: Add forgot password navigation
                  },
                  child: Text(
                    'Forgot password?',
                    style: text14(
                      color: AppColors.accent,
                      fontWeight: FontWeight.w600,
                      context: context,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // Sign In Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () => Get.offNamed(AppRoutes.mySheel),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accent,
                    foregroundColor: Colors.black,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Sign In',
                        style: text16(
                          fontWeight: FontWeight.w600,
                          context: context,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.arrow_forward_rounded, size: 20),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Divider
              Row(
                children: [
                  Expanded(child: Divider(color: AppColors.navyLight(context))),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'or continue with',
                      style: text14(
                        color: AppColors.textMuted(context),
                        context: context,
                      ),
                    ),
                  ),
                  Expanded(child: Divider(color: AppColors.navyLight(context))),
                ],
              ),

              const SizedBox(height: 20),

              // Social Buttons
              Row(
                children: [
                  Expanded(
                    child: _socialBtn(
                      context,
                      icon: Icons.g_mobiledata_rounded,
                      label: 'Google',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _socialBtn(
                      context,
                      icon: Icons.apple_rounded,
                      label: 'Apple',
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Register Link
              Center(
                child: GestureDetector(
                  onTap: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const RegisterScreen()),
                  ),
                  child: RichText(
                    text: TextSpan(
                      text: 'New here? ',
                      style: text14(
                        color: AppColors.textMuted(context),
                        context: context,
                      ),
                      children: [
                        TextSpan(
                          text: 'Create Account',
                          style: text15(
                            color: AppColors.accent,
                            fontWeight: FontWeight.w600,
                            context: context,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  // Label
  Widget _buildLabel(BuildContext context, String text) {
    return Text(
      text,
      style: text13(
        fontWeight: FontWeight.w500,
        color: AppColors.textMuted(context),
        context: context,
      ),
    );
  }

  // Input Field
  Widget _buildField(
    BuildContext context, {
    required String hint,
    required IconData icon,
    bool obscure = false,
    TextInputType keyboardType = TextInputType.text,
    Widget? suffixIcon,
  }) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: AppColors.navyMid(context),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.navyLight(context), width: 1.5),
      ),
      child: Row(
        children: [
          const SizedBox(width: 16),
          Icon(icon, color: AppColors.textMuted(context), size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              obscureText: obscure,
              keyboardType: keyboardType,
              style: text15(
                color: AppColors.textPrimary(context),
                context: context,
              ),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: text15(
                  color: AppColors.textMuted(context),
                  context: context,
                ),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
          if (suffixIcon != null) ...[suffixIcon, const SizedBox(width: 16)],
        ],
      ),
    );
  }

  // Social Button
  Widget _socialBtn(
    BuildContext context, {
    required IconData icon,
    required String label,
  }) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: AppColors.navyMid(context),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.navyLight(context), width: 1.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: AppColors.textPrimary(context), size: 24),
          const SizedBox(width: 10),
          Text(
            label,
            style: text15(
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary(context),
              context: context,
            ),
          ),
        ],
      ),
    );
  }
}
