import 'package:flutter/material.dart';
import 'package:rick_and_morty/common/app_colors.dart';
import 'package:rick_and_morty/feature/domain/entities/person_entity.dart';
import 'package:rick_and_morty/feature/presentation/widgets/person_cache_image_widget.dart';

class PersonDetailPage extends StatelessWidget {
  final PersonEntity person;

  const PersonDetailPage({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Character'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(
              height: 24,
            ),
            Text(
              person.name,
              style: const TextStyle(
                  fontSize: 28,
                  color: Colors.white,
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 12,
            ),
            SizedBox(
              child: PersonCacheImage(
                height: 260,
                wight: 260,
                imageUrl: person.image,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: person.status == 'Alive' ? Colors.green : Colors.red,
                  ),
                  width: 12,
                  height: 12,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  person.status,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  maxLines: 1,
                )
              ],
            ),
            if (person.type.isNotEmpty) ...buildText('Type:', person.type),
            ...buildText('Gender:', person.gender),
            ...buildText(
                'Number of episodes:', person.episode.length.toString()),
            ...buildText('Species:', person.species),
            ...buildText('Last known location:', person.location.name),
            ...buildText('Origin', person.origin.name),
            ...buildText('Was created', person.created.toString()),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> buildText(String label, String value) {
    return [
      const SizedBox(
        height: 16,
      ),
      Text(
        label,
        style: const TextStyle(
          color: AppColors.greyColor,
        ),
      ),
      Text(
        value,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    ];
  }
}
