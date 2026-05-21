import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:screen_reader/utils/textstyle.dart';

import '../../res/app_colors.dart';
import '../../routes/app_routes.dart';
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
                'START FREE',
                style: text20(
                  fontWeight: FontWeight.w500,
                  color: AppColors.textMuted(context),
                  context: context,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Create your Account',
                style: text26(
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary(context),
                  context: context,
                ),
              ),

              const SizedBox(height: 40),

              // Form Fields
              _buildLabel(context, 'FULL NAME'),
              const SizedBox(height: 8),
              _buildField(
                context,
                hint: 'ex. Rahul Sharma',
                icon: Icons.person_outline_rounded,
              ),

              const SizedBox(height: 20),

              _buildLabel(context, 'EMAIL'),
              const SizedBox(height: 8),
              _buildField(
                context,
                hint: 'you@example.com',
                icon: Icons.mail_outline_rounded,
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 20),

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
                    size: 22,
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // Create Account Button
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
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Create Account',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward_rounded, size: 20),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Divider
              Row(
                children: [
                  Expanded(child: Divider(color: AppColors.navyLight(context))),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'or',
                      style: text13(
                        color: AppColors.textMuted(context),
                        context: context,
                      ),
                    ),
                  ),
                  Expanded(child: Divider(color: AppColors.navyLight(context))),
                ],
              ),

              const SizedBox(height: 20),

              // Sign In Link
              Center(
                child: GestureDetector(
                  onTap: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                  ),
                  child: RichText(
                    text: TextSpan(
                      text: 'Already a member? ',
                      style: text14(
                        color: AppColors.textMuted(context),
                        context: context,
                      ),
                      children: [
                        TextSpan(
                          text: 'Sign In',
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

              // Badges
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _badge(Icons.shield_outlined, 'SSL Secured'),
                  const SizedBox(width: 20),
                  _badge(Icons.verified_outlined, 'Privacy First'),
                ],
              ),

              const SizedBox(height: 30),
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

  // Badge
  Widget _badge(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.accent),
        const SizedBox(width: 6),
        Text(
          label,
          style: text11(
            color: AppColors.accent,
            fontWeight: FontWeight.w600,
            context: context,
          ),
        ),
      ],
    );
  }
}
