import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../res/app_colors.dart';
import '../../routes/app_routes.dart';
import '../../utils/text_style.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.navy(context),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              // ── Back ──────────────────────────────────────────────────────
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 36, height: 36,
                  decoration: BoxDecoration(
                    color: AppColors.navyLight(context),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.arrow_back_ios_new_rounded,
                      size: 16, color: AppColors.textPrimary(context)),
                ),
              ),

              const SizedBox(height: 24),

              Text('START FREE',
                  style: AppTextStyles.labelLarge.copyWith(
                      color: AppColors.textMuted(context))),
              const SizedBox(height: 6),
              Text('Create your Account',
                  style: AppTextStyles.displayMedium.copyWith(
                      color: AppColors.textPrimary(context))),

              const SizedBox(height: 32),

              _buildLabel(context, 'FULL NAME'),
              const SizedBox(height: 8),
              _buildField(context,
                  hint: 'ex. Rahul Sharma',
                  icon: Icons.person_outline_rounded),

              const SizedBox(height: 18),

              _buildLabel(context, 'EMAIL'),
              const SizedBox(height: 8),
              _buildField(context,
                  hint: 'you@example.com',
                  icon: Icons.mail_outline_rounded,
                  keyboardType: TextInputType.emailAddress),

              const SizedBox(height: 18),

              _buildLabel(context, 'PASSWORD'),
              const SizedBox(height: 8),
              _buildField(
                context,
                hint: 'Min. 8 characters',
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

              const SizedBox(height: 28),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () => Get.offNamed(AppRoutes.mySheel),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('Create Account'),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward_rounded, size: 18),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                      child: Divider(color: AppColors.navyLight(context))),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text('or',
                        style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.textMuted(context))),
                  ),
                  Expanded(
                      child: Divider(color: AppColors.navyLight(context))),
                ],
              ),

              const SizedBox(height: 16),

              Center(
                child: GestureDetector(
                  onTap: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                  ),
                  child: RichText(
                    text: TextSpan(
                      text: 'Already a member? ',
                      style: TextStyle(
                          color: AppColors.textMuted(context),
                          fontFamily: 'DMSans',
                          fontSize: 13),
                      children: const [
                        TextSpan(
                          text: 'Sign In',
                          style: TextStyle(
                              color: AppColors.accent,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _badge(Icons.shield_outlined, 'SSL Secured'),
                  const SizedBox(width: 12),
                  _badge(Icons.verified_outlined, 'Privacy First'),
                ],
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(BuildContext context, String text) => Text(
    text,
    style: AppTextStyles.labelMedium.copyWith(
        color: AppColors.textMuted(context)),
  );

  Widget _buildField(
      BuildContext context, {
        required String hint,
        required IconData icon,
        bool obscure = false,
        TextInputType keyboardType = TextInputType.text,
        Widget? suffixIcon,
      }) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: AppColors.navyMid(context),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.navyLight(context), width: 1.5),
      ),
      child: Row(
        children: [
          const SizedBox(width: 14),
          Icon(icon, color: AppColors.textMuted(context), size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              obscureText: obscure,
              keyboardType: keyboardType,
              style: TextStyle(
                  color: AppColors.textPrimary(context),
                  fontFamily: 'DMSans',
                  fontSize: 14),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textMuted(context)),
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

  Widget _badge(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 14, color: AppColors.accent),
        const SizedBox(width: 4),
        Text(label,
            style: const TextStyle(
                fontSize: 10,
                color: AppColors.accent,
                fontFamily: 'DMSans',
                fontWeight: FontWeight.w600)),
      ],
    );
  }
}