  import 'package:flutter/material.dart';
import 'package:tayaar/core/components/colors.dart';

Widget buildDetailRow(String label, String? value, bool isExpanded) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppColors.ivory,
            fontSize: isExpanded ? 18 : 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value ?? 'N/A',
            style: TextStyle(
              color: AppColors.ivory,
              fontSize: isExpanded ? 18 : 14,
              fontWeight: FontWeight.w400,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  String formatDate(DateTime? date) {
    if (date == null) return 'N/A';
    // Converts to local time if date is in UTC
    final localDate = date.toLocal();
    return '${localDate.year}-${localDate.month.toString().padLeft(2, '0')}-${localDate.day.toString().padLeft(2, '0')}';
  }

  String formatTime(DateTime? date) {
    if (date == null) return 'N/A';
    // Converts to local time if date is in UTC
    final localDate = date.toLocal();
    return '${localDate.hour.toString().padLeft(2, '0')}:${localDate.minute.toString().padLeft(2, '0')}:${localDate.second.toString().padLeft(2, '0')}';
  }