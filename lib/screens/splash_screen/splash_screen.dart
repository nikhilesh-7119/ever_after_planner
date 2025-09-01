import 'package:ever_after_planner/screens/auth_gateway/auth_gateway.dart';
import 'package:ever_after_planner/screens/auth_screen/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  // Colors (match the mock)
  static const Color kBg = Color.fromARGB(255, 236, 233, 233);
  static const Color kCard = Color(0xFFFDF6F2);
  static const Color kText = Color(0xFF1B1B1B);
  static const Color kMuted = Color(0xFF6B6B6B);

  // @override
  // Widget build(BuildContext context) {
  //   final theme = Theme.of(context);
  //   return Scaffold(
  //     backgroundColor: kBg,
  //     body: Stack(
  //       children: [
  //         // subtle decorative circles
  //         const _SoftCircle(top: 48, left: 24, size: 28),
  //         const _SoftCircle(top: 140, left: 160, size: 18),
  //         const _SoftCircle(top: 70, right: 160, size: 32),
  //         const _SoftCircle(top: 250, right: 40, size: 32),
  //         const _SoftCircle(bottom: 32, right: 32, size: 22),
  //         const _SoftCircle(bottom: 70, left: 48, size: 22),

  //         // main content
  //         SafeArea(
  //           child: Center(
  //             child: ConstrainedBox(
  //               constraints: const BoxConstraints(maxWidth: 360),
  //               child: Padding(
  //                 padding: const EdgeInsets.symmetric(horizontal: 24),
  //                 child: Column(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     const SizedBox(height: 24),
  //                     // heart icon
  //                     const Icon(Icons.favorite, color: Color.fromARGB(255, 243, 163, 163), size: 48,),
  //                     const SizedBox(height: 20),
  //                     // title and subtitle
  //                     Text(
  //                       'EverAfter',
  //                       style: theme.textTheme.headlineMedium?.copyWith(
  //                         color: kText,
  //                         fontSize: 32,
  //                         fontWeight: FontWeight.w800,
  //                         letterSpacing: 1,
  //                       ),
  //                       textAlign: TextAlign.center,
  //                     ),
  //                     const SizedBox(height: 4),
  //                     Text(
  //                       'PLANNER',
  //                       style: theme.textTheme.labelLarge?.copyWith(
  //                         color: const Color.fromARGB(255, 59, 59, 59),
  //                         letterSpacing: 2.2,
  //                         fontSize: 20,
  //                       ),
  //                     ),
  //                     const SizedBox(height: 20),
  //                     Text(
  //                       'Your perfect wedding, beautifully\nplanned and effortlessly managed',
  //                       style: theme.textTheme.bodyMedium?.copyWith(
  //                         color: const Color.fromARGB(255, 59, 59, 59),
  //                         height: 1.4,
  //                         fontSize: 16
  //                       ),
  //                       textAlign: TextAlign.center,
  //                     ),
  //                     const SizedBox(height: 60),

  //                     // Get Started button (soft neumorphic)
  //                     _NeumorphicButton(
  //                       label: 'Get Started',
  //                       onTap: () {
  //                         Get.offAll(AuthScreen());
  //                       },
  //                     ),

  //                     const SizedBox(height: 32),

  //                     // footer
  //                     Opacity(
  //                       opacity: 0.9,
  //                       child: Text(
  //                         'Version 1.0 • Made with ♡',
  //                         style: theme.textTheme.bodySmall?.copyWith(
  //                           color: const Color.fromARGB(255, 41, 40, 40),
  //                           fontSize: 15
  //                         ),
  //                         textAlign: TextAlign.center,
  //                       ),
  //                     ),
  //                     const SizedBox(height: 24),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Responsive scale based on screen width (reference 390)
    final Size screen = MediaQuery.of(context).size; // width/height [7]
    final double s = (screen.width / 390).clamp(
      0.85,
      1.25,
    ); // guard extremes [1]

    return Scaffold(
      backgroundColor: kBg,
      body: Stack(
        children: [
          // subtle decorative circles (scaled)
          _SoftCircle(top: 48 * s, left: 24 * s, size: 28 * s),
          _SoftCircle(top: 140 * s, left: 160 * s, size: 18 * s),
          _SoftCircle(top: 70 * s, right: 160 * s, size: 32 * s),
          _SoftCircle(top: 250 * s, right: 40 * s, size: 32 * s),
          _SoftCircle(bottom: 32 * s, right: 32 * s, size: 22 * s),
          _SoftCircle(bottom: 70 * s, left: 48 * s, size: 22 * s),

          // main content
          SafeArea(
            // respects notches and system UI [2]
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 360),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24 * s),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 24 * s),

                      // heart icon
                      Icon(
                        Icons.favorite,
                        color: const Color.fromARGB(255, 243, 163, 163),
                        size: 48 * s,
                      ),
                      SizedBox(height: 20 * s),

                      // title and subtitle
                      Text(
                        'EverAfter',
                        style: theme.textTheme.headlineMedium?.copyWith(
                          color: kText,
                          fontSize: 32 * s,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1 * s,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 4 * s),
                      Text(
                        'PLANNER',
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: const Color.fromARGB(255, 59, 59, 59),
                          letterSpacing: 2.2 * s,
                          fontSize: 20 * s,
                        ),
                      ),
                      SizedBox(height: 20 * s),
                      Text(
                        'Your perfect wedding, beautifully\nplanned and effortlessly managed',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: const Color.fromARGB(255, 59, 59, 59),
                          height: 1.4,
                          fontSize: 16 * s,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 60 * s),

                      // Get Started button (soft neumorphic)
                      _NeumorphicButton(
                        label: 'Get Started',
                        onTap: () {
                          Get.offAll(const AuthGateway());
                        },
                      ),

                      SizedBox(height: 32 * s),

                      // footer
                      Opacity(
                        opacity: 0.9,
                        child: Text(
                          'Version 1.0 • Made with ♡',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: const Color.fromARGB(255, 41, 40, 40),
                            fontSize: 15 * s,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 24 * s),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SoftCircle extends StatelessWidget {
  final double size;
  final double? top, left, right, bottom;
  const _SoftCircle({
    this.size = 24,
    this.top,
    this.left,
    this.right,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 240, 143, 143).withOpacity(0.25),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.black12.withOpacity(0.05)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
      ),
    );
  }
}

class _NeumorphicButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const _NeumorphicButton({required this.label, required this.onTap});

  @override
  State<_NeumorphicButton> createState() => _NeumorphicButtonState();
}

class _NeumorphicButtonState extends State<_NeumorphicButton> {
  bool _pressed = false;

  // @override
  // Widget build(BuildContext context) {
  //   return Listener(
  //     onPointerDown: (_) => setState(() => _pressed = true),
  //     onPointerUp: (_) => setState(() => _pressed = false),
  //     child: GestureDetector(
  //       onTap: widget.onTap,
  //       child: AnimatedContainer(
  //         duration: const Duration(milliseconds: 150),
  //         padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
  //         decoration: BoxDecoration(
  //           color: SplashScreen.kCard,
  //           borderRadius: BorderRadius.circular(14),
  //           boxShadow: _pressed
  //               ? [
  //                   // pressed (inner) look by reducing elevation
  //                   BoxShadow(
  //                     color: const Color.fromARGB(255, 248, 134, 134),
  //                     blurRadius: 4,
  //                     offset: const Offset(0, 2),
  //                   ),
  //                 ]
  //               : [
  //                   BoxShadow(
  //                     color: const Color.fromARGB(255, 248, 134, 134),
  //                     blurRadius: 16,
  //                     spreadRadius: 1,
  //                     offset: const Offset(0, 6),
  //                   ),
  //                   const BoxShadow(
  //                     color: Colors.white,
  //                     blurRadius: 12,
  //                     offset: Offset(-2, -2),
  //                   ),
  //                 ],
  //         ),
  //         child: Text(
  //           widget.label,
  //           style: Theme.of(context).textTheme.labelLarge?.copyWith(
  //             color: SplashScreen.kText,
  //             fontSize: 20,
  //             fontWeight: FontWeight.w600,
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final double s = (MediaQuery.of(context).size.width / 390).clamp(
      0.85,
      1.25,
    ); // [7]
    return Listener(
      onPointerDown: (_) => setState(() => _pressed = true),
      onPointerUp: (_) => setState(() => _pressed = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: EdgeInsets.symmetric(horizontal: 24 * s, vertical: 16 * s),
          decoration: BoxDecoration(
            color: SplashScreen.kCard,
            borderRadius: BorderRadius.circular(14 * s),
            boxShadow: _pressed
                ? [
                    BoxShadow(
                      color: const Color.fromARGB(255, 248, 134, 134),
                      blurRadius: 4 * s,
                      offset: Offset(0, 2 * s),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: const Color.fromARGB(255, 248, 134, 134),
                      blurRadius: 16 * s,
                      spreadRadius: 1 * s,
                      offset: Offset(0, 6 * s),
                    ),
                    BoxShadow(
                      color: Colors.white,
                      blurRadius: 12 * s,
                      offset: Offset(-2 * s, -2 * s),
                    ),
                  ],
          ),
          child: Text(
            widget.label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: SplashScreen.kText,
              fontSize: 20 * s,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
