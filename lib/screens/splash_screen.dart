import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../services/supabase_service.dart';
import '../theme/app_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  
  // عرض الشاشة فوراً بدون انتظار
  bool _showOffline = true;
  bool _isSupabaseReady = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 0.5, curve: Curves.easeIn),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut,
      ),
    );

    _controller.forward();
    
    // عرض الشاشة فوراً والتحقق من Supabase في الخلفية
    _checkSupabaseStatus();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _checkSupabaseStatus() async {
    // انتظر 2 ثانية ثم تحقق من Supabase
    await Future.delayed(const Duration(seconds: 2));
    
    // تحقق مما إذا كان Supabase جاهزاً
    if (SupabaseService.isAuthenticated) {
      setState(() {
        _showOffline = false;
        _isSupabaseReady = true;
      });
      // انتقل للصفحة الرئيسية فوراً
      Navigator.pushReplacementNamed(context, '/main');
    } else {
      // إذا لم يكن جاهزاً، استمر في عرض الشاشة مع مؤشر تحميل
      setState(() {
        _showOffline = false;
      });
    }
    
    // انتظر حتى 10 ثواني ثم انتقل للتسجيل إذا لم يكن متصلاً
    await Future.delayed(const Duration(seconds: 8));
    if (mounted && !_isSupabaseReady) {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              isDark ? AppTheme.darkBackground : AppTheme.lightBackground,
              isDark ? AppTheme.darkSurface : AppTheme.lightSurface,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // الشعار
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return FadeTransition(
                    opacity: _fadeAnimation,
                    child: ScaleTransition(
                      scale: _scaleAnimation,
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [AppTheme.goldColor, AppTheme.goldLight],
                          ),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.goldColor.withOpacity(0.4),
                              blurRadius: 30,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.shopping_bag,
                          size: 80,
                          color: AppTheme.darkText,
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 40),
              // اسم التطبيق
              FadeTransition(
                opacity: _fadeAnimation,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'FLEX',
                      style: TextStyle(
                        fontFamily: 'Changa',
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.goldColor,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'YEMEN',
                      style: TextStyle(
                        fontFamily: 'Changa',
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.goldLight,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // الشعار الفرعي
              FadeTransition(
                opacity: _fadeAnimation,
                child: Text(
                  'منصة التجارة الإلكترونية اليمنية',
                  style: TextStyle(
                    fontFamily: 'Changa',
                    fontSize: 16,
                    color: isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary,
                  ),
                ),
              ),
              const SizedBox(height: 60),
              // مؤشر التحميل
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppTheme.goldColor),
                strokeWidth: 3,
              ),
              const SizedBox(height: 16),
              // رسالة حالة الاتصال
              FadeTransition(
                opacity: _fadeAnimation,
                child: Text(
                  _showOffline ? 'جاري تحميل البيانات...' : 'جاري الاتصال بالخادم...',
                  style: TextStyle(
                    fontFamily: 'Changa',
                    fontSize: 12,
                    color: isDark ? AppTheme.darkTextSecondary : AppTheme.lightTextSecondary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
