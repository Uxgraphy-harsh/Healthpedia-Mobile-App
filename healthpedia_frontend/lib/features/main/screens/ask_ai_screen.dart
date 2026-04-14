import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/app_colors.dart';

class AskAiScreen extends StatelessWidget {
  const AskAiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Neutral 100
      body: Stack(
        children: [
          // Top Elliptical Glow
          Positioned(
            top: -100,
            left: 0,
            right: 0,
            child: Container(
              height: 300,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.topCenter,
                  radius: 1.5,
                  colors: [
                    const Color(0xFFFFFFFF),
                    const Color(0xFFFFFFFF).withOpacity(0),
                  ],
                ),
              ),
            ),
          ),

          // Central Watermark
          Center(
            child: Opacity(
              opacity: 0.1, // Subtle watermark
              child: Image.asset(
                'assets/Figma MCP Assets/Shared Assets/Images/Repeat group 4.png',
                width: 250,
                color: Colors.black.withOpacity(0.2),
                colorBlendMode: BlendMode.dstIn,
              ),
            ),
          ),

          // Main Content
          SafeArea(
            child: Column(
              children: [
                // Top Bar
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Close Button
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.close, size: 24, color: Color(0xFF0A0A0A)),
                        ),
                      ),
                      // Chat History Pill
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(999),
                          border: Border.all(color: const Color(0xFFE5E5E5)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              'assets/Figma MCP Assets/Shared Assets/Icons/ChatsCircle.svg',
                              width: 20,
                              height: 20,
                              colorFilter: const ColorFilter.mode(Color(0xFF737373), BlendMode.srcIn),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Chat history',
                              style: TextStyle(
                                fontFamily: 'Geist',
                                fontSize: 16,
                                color: Color(0xFF737373),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                // Bottom Section with Gradient
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      center: const Alignment(0, 2),
                      radius: 1.5,
                      colors: [
                        const Color(0xFFFF96BE).withOpacity(0.3),
                        const Color(0xFFFF96BE).withOpacity(0),
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        // Options Row
                        Row(
                          children: [
                            Expanded(
                              child: _buildOptionCard(
                                'Log symptoms',
                                'assets/Figma MCP Assets/Shared Assets/Icons/Heartbeat.svg',
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: _buildOptionCard(
                                'Analyze Reports',
                                'assets/Figma MCP Assets/Shared Assets/Icons/Files.svg',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        // Ask Section
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(32),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Ask anything about your health',
                                style: TextStyle(
                                  fontFamily: 'Geist',
                                  fontSize: 18,
                                  color: Color(0xFF737373),
                                ),
                              ),
                              const SizedBox(height: 24),
                              Row(
                                children: [
                                  _buildRoundButton(Icons.attach_file),
                                  const Spacer(),
                                  _buildRoundButton(Icons.mic_none),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionCard(String title, String svgPath) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            svgPath,
            width: 24,
            height: 24,
            colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontFamily: 'Geist',
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoundButton(IconData? icon, {String? svgIcon}) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFFE5E5E5)),
      ),
      child: Center(
        child: icon != null
            ? Icon(icon, size: 20, color: const Color(0xFF737373))
            : SvgPicture.asset(
                svgIcon!,
                width: 20,
                height: 20,
                colorFilter: const ColorFilter.mode(Color(0xFF737373), BlendMode.srcIn),
              ),
      ),
    );
  }
}
