import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

class Backend {
  final String hostUrl;

  const Backend(this.hostUrl);

  Future<List<Rocket>> getRockets() async {
    final url = '$hostUrl/rockets';

    final response = await http.get(url);
    if (response.statusCode != 200) {
      throw Exception(response.reasonPhrase);
    }

    final body = response.body;
    final jsonData = json.decode(body) as List;

    final rockets =
        jsonData.map((jsonMap) => Rocket.fromJson(jsonMap)).toList();

    // TODO: Use the host url to get some rockets
    return rockets;
  }
}

class Rocket {
  final String id;
  final String name;
  final String description;
  final bool active;
  final int boosters;
  final List<String> flickrImages;
  final String wikipedia;
  final DateTime firstFlight;
  final double height;
  final double diameter;
  final double mass;

  const Rocket({
    @required this.id,
    @required this.name,
    @required this.description,
    @required this.active,
    @required this.boosters,
    @required this.flickrImages,
    @required this.wikipedia,
    @required this.firstFlight,
    @required this.height,
    @required this.diameter,
    @required this.mass,
  });

  factory Rocket.fromJson(Map<String, dynamic> jsonMap) {
    return Rocket(
      id: jsonMap['id'],
      name: jsonMap['name'],
      description: jsonMap['description'],
      active: jsonMap['active'],
      boosters: jsonMap['boosters'],
      flickrImages: List<String>.from(jsonMap['flickr_images']),
      wikipedia: jsonMap['wikipedia'],
      firstFlight: DateTime.parse(jsonMap['first_flight'].toString()),
      height: double.parse(jsonMap['height']['meters'].toString()),
      diameter: double.parse(jsonMap['diameter']['meters'].toString()),
      mass: double.parse(jsonMap['mass']['kg'].toString()),
    );
  }
}

/*

return const [
      Rocket(
        id: 'falcon_1',
        name: 'Falcon 1',
        description: 'The Falcon 1 was an expendable launch system privately '
            'developed and manufactured by SpaceX during 2006-2009 '
            'on 28 September 2008, Falcon 1 became the first'
            'privately-developed liquid fuel launch vehicle to go into orbit'
            'around the Earth',
        active: false,
        boosters: 0,
        flickrImages: [
          'https://imgur.com/DaCfMsj.jpg',
          'https://imgur.com/azYafd8.jpg',
        ],
      ),
      Rocket(
        id: 'falcon_heavy',
        name: 'Falcon Heavy',
        description: 'With the ability to lift into orbit over 54 metric tons '
            '(119,000 lb) - a mass equivalent to a 737 jetliner loaded with '
            'passengers, crew, luggage and fuel -- Falcon Heavy can lift more '
            'than twice the payload of the next closest operational vehicle, '
            'the Delta IV Heavy, at one-third the cost.',
        active: true,
        boosters: 2,
        flickrImages: [
          'https://farm5.staticflickr.com/4599/38583829295_581f34dd84_b.jpg',
          'https://farm5.staticflickr.com/4645/38583830575_3f0f7215e6_b.jpg',
          'https://farm5.staticflickr.com/4696/40126460511_b15bf84c85_b.jpg',
          'https://farm5.staticflickr.com/4711/40126461411_aabc643fd8_b.jpg',
        ],
      ),
    ];
    */
