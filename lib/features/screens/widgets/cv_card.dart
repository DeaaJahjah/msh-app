import 'package:flutter/material.dart';
import 'package:msh_app/core/config/constant/constant.dart';
import 'package:msh_app/features/models/cv_model.dart';

class CVCard extends StatelessWidget {
  final CVModel cv;

  const CVCard({super.key, required this.cv});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: cv.imageUrl != null ? NetworkImage(cv.imageUrl!) : null,
                  child: cv.imageUrl == null ? const Icon(Icons.person, size: 40) : null,
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cv.fullName,
                      style: meduimTextStyle,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      cv.job,
                      style: meduimTextStyle.copyWith(color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 4),
                    Text(cv.email),
                    const SizedBox(height: 4),
                    Text(cv.phone ?? ''),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'ملخص',
              style: meduimTextStyle,
            ),
            const SizedBox(height: 8),
            Text(cv.aboutYou),
            const SizedBox(height: 16),
            if (cv.certificates.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'الشهادات',
                    style: meduimTextStyle,
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: cv.certificates.map((certificate) => Chip(label: Text(certificate))).toList(),
                  ),
                ],
              ),
            if (cv.skills.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  const Text(
                    'المهارات',
                    style: meduimTextStyle,
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: cv.skills.map((skill) => Chip(label: Text(skill))).toList(),
                  ),
                ],
              ),
            if (cv.softSkills.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  const Text(
                    'المهارات الناعمة',
                    style: meduimTextStyle,
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: cv.softSkills.map((softSkill) => Chip(label: Text(softSkill))).toList(),
                  ),
                ],
              ),
            if (cv.languages.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  const Text(
                    'اللغات',
                    style: meduimTextStyle,
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: cv.languages.map((language) => Chip(label: Text(language))).toList(),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
