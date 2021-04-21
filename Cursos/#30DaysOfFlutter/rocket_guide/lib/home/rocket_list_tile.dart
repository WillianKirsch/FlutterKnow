import 'package:flutter/material.dart';
import 'package:rck_guide/backend/backend.dart';

class RocketListTile extends StatelessWidget {
  final VoidCallback onTap;
  final Rocket rocket;

  const RocketListTile({
    Key key,
    @required this.onTap,
    @required this.rocket,
  })  : assert(rocket != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      isThreeLine: true,
      leading: rocket.flickrImages.isEmpty
          ? null
          : AspectRatio(
              aspectRatio: 1,
              child: Hero(
                tag: 'hero-${rocket.id}-image',
                child: Image.network(
                  rocket.flickrImages.first,
                  fit: BoxFit.cover,
                ),
              ),
            ),
      title: Text(rocket.name),
      subtitle: Text(
        rocket.description,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: const Icon(Icons.chevron_right_sharp),
    );
  }
}
