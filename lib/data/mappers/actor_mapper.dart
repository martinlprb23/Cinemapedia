import 'package:cinemapedia/data/models/moviedb/credits_response.dart';
import 'package:cinemapedia/domain/entities/actor.dart';

class ActorMaper {
  static Actor castToEntity(Cast cast) => Actor(
      id: cast.id,
      name: cast.name,
      image: cast.profilePath != null
          ? 'https://image.tmdb.org/t/p/w500/${cast.profilePath}'
          : 'https://www.bsn.eu/wp-content/uploads/2016/12/user-icon-image-placeholder-300-grey.jpg',
      character: cast.character);
}
