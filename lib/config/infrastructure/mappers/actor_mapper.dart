import 'package:cinemafan/config/constants/environment.dart';
import 'package:cinemafan/config/domain/entities/actor.dart';
import 'package:cinemafan/config/infrastructure/models/moviedb_models.dart';

class ActoMapper {
  static int _imageWidth = 200;
  static String _actorDefaultImage = 'https://simg.nicepng.com/png/small/811-8114232_silhouette-grey-person-icon.png';

  static Actor castFromMovieDbToEntity(Cast cast) {
    return Actor(
    id: cast.id,
    name: cast.name,
    character: cast.character,
    profilePath: cast.profilePath == null
      ? _actorDefaultImage
      : '${Environment.theMovieDbImageBaseUrl}/w$_imageWidth${cast.profilePath!}',
  );
  }
}