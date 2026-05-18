import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../main.dart';
import '../../model/book_model.dart';
import '../../res/app_colors.dart';
import '../../routes/app_routes.dart';
import '../../utils/text_style.dart';
import '../custom_widgts/book_cover_widget.dart';
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
      backgroundColor: AppColors.navy,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              // Back button
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

              // Header
              const Text('START FREE', style: AppTextStyles.labelLarge),
              const SizedBox(height: 6),
              const Text('Create your Account', style: AppTextStyles.displayMedium),

              const SizedBox(height: 32),

              // Full Name
              _buildLabel('FULL NAME'),
              const SizedBox(height: 8),
              _buildField(
                hint: 'ex. Rahul Sharma',
                icon: Icons.person_outline_rounded,
              ),

              const SizedBox(height: 18),

              // Email
              _buildLabel('EMAIL'),
              const SizedBox(height: 8),
              _buildField(
                hint: 'you@example.com',
                icon: Icons.mail_outline_rounded,
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 18),

              // Password
              _buildLabel('PASSWORD'),
              const SizedBox(height: 8),
              _buildField(
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

              // CTA
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

              // Divider
              Row(
                children: [
                  const Expanded(child: Divider(color: AppColors.navyLight)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text('or', style: AppTextStyles.bodySmall),
                  ),
                  const Expanded(child: Divider(color: AppColors.navyLight)),
                ],
              ),

              const SizedBox(height: 16),

              // Footer
              Center(
                child: GestureDetector(
                  onTap: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                  ),
                  child: RichText(
                    text: const TextSpan(
                      text: 'Already a member? ',
                      style: TextStyle(
                          color: AppColors.textMuted,
                          fontFamily: 'DMSans',
                          fontSize: 13),
                      children: [
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

              // Trust badges
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

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: AppTextStyles.labelMedium,
    );
  }

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