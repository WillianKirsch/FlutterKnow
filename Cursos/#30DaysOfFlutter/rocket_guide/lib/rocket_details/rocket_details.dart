import 'package:flutter/material.dart';
import 'package:rck_guide/backend/backend.dart';

class RocketDetailsScreen extends StatelessWidget {
  final Rocket rocket;

  const RocketDetailsScreen({
    Key key,
    @required this.rocket,
  })  : assert(rocket != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(rocket.name),
      ),
      body: ListView(
        children: [
          if (rocket.flickrImages.isNotEmpty)
            Hero(
              tag: 'hero-${rocket.id}-image',
              child: _HeaderImage(images: rocket.flickrImages),
            ),

            
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              rocket.name,
              style: textTheme.headline5,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              rocket.description,
              style: textTheme.subtitle2,
            ),
          ),
          Text(rocket.wikipedia),
          Text('${rocket.firstFlight}'),
          Text('${rocket.height}'),
          Text('${rocket.diameter}'),
          Text('${rocket.mass}'),
        ],
      ),
    );
  }
}

class _HeaderImage extends StatelessWidget {
  final List<String> images;

  const _HeaderImage({
    Key key,
    this.images,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: PageView(
        children: [
          for (final image in images)
            Image.network(
              image,
              fit: BoxFit.cover,
            ),
        ],
      ),
    );
  }
}
