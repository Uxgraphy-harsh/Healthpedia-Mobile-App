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
          // 1. Blue Top Glow (Exact Figma Ellipse 2: y=-781, size=1152)
          Positioned(
            top: -781,
            left: -381,
            child: Container(
              width: 1152,
              height: 1152,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFFD0E8FF).withOpacity(0.8),
                    const Color(0xFFF5F5F5).withOpacity(0),
                  ],
                ),
              ),
            ),
          ),

          // 2. Pink Bottom Glow (Large Soft Shape)
          Positioned(
            bottom: -200,
            left: -100,
            right: -100,
            child: Container(
              height: 600,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  center: const Alignment(0, 0.5),
                  colors: [
                    const Color(0xFFFF96BE).withOpacity(0.6),
                    const Color(0xFFFF96BE).withOpacity(0),
                  ],
                ),
              ),
            ),
          ),

          // 3. Central Watermark (Exact Figma Scale: 160px)
          Center(
            child: ColorFiltered(
              colorFilter: const ColorFilter.matrix(<double>[
                0.2126, 0.7152, 0.0722, 0, 0,
                0.2126, 0.7152, 0.0722, 0, 0,
                0.2126, 0.7152, 0.0722, 0, 0,
                0,      0,      0,      1, 0,
              ]),
              child: Image.asset(
                'assets/Figma MCP Assets/CommonAssets/Images/Repeat group 4.png',
                width: 160,
                fit: BoxFit.contain,
              ),
            ),
          ),

          // 4. Content Layer
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: constraints.maxHeight),
                    child: IntrinsicHeight(
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
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.black.withOpacity(0.05),
                                    ),
                                    child: const Icon(Icons.close, size: 24, color: Color(0xFF0A0A0A)),
                                  ),
                                ),
                                // Chat History Pill
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.6),
                                    borderRadius: BorderRadius.circular(999),
                                    border: Border.all(color: const Color(0xFFE5E5E5).withOpacity(0.5)),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/Figma MCP Assets/CommonAssets/Icons/ChatsCircle.svg',
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
                                          fontWeight: FontWeight.w400,
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

                          // Bottom Content
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Options Row
                                Row(
                                  children: [
                                    Expanded(
                                      child: _buildOptionCard(
                                        'Log symptoms',
                                        'assets/Figma MCP Assets/CommonAssets/Icons/Heartbeat.svg',
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: _buildOptionCard(
                                        'Analyze Reports',
                                        'assets/Figma MCP Assets/CommonAssets/Icons/Files.svg',
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
                                    color: Colors.white.withOpacity(0.9),
                                    borderRadius: BorderRadius.circular(32),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.05),
                                        blurRadius: 20,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
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
                                const SizedBox(height: 16),
                                // Home Indicator
                                Container(
                                  width: 134,
                                  height: 5,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ),
                  );
                },
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
            colorFilter: const ColorFilter.mode(Color(0xFF737373), BlendMode.srcIn),
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
