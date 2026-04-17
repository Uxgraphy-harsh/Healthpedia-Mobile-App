import 'package:flutter/material.dart';
import 'package:healthpedia_frontend/core/constants/app_colors.dart';
import 'base_input_container.dart';

class PremiumFieldGroup extends StatelessWidget {
  const PremiumFieldGroup({
    super.key,
    this.label,
    this.description,
    required this.children,
    this.compact = false,
  });

  final String? label;
  final String? description;
  final List<Widget> children;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(label!, style: BaseInputContainer.labelTextStyle(context)),
          const SizedBox(height: 8),
        ],
        if (description != null) ...[
          Text(
            description!,
            style: BaseInputContainer.contentTextStyle(
              context,
              color: AppColors.neutral600,
            ),
          ),
          const SizedBox(height: 8),
        ],
        Column(
          children: children
              .asMap()
              .entries
              .map(
                (entry) => Padding(
                  padding: EdgeInsets.only(
                    bottom: entry.key == children.length - 1 ? 0 : (compact ? 12 : 16),
                  ),
                  child: entry.value,
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
