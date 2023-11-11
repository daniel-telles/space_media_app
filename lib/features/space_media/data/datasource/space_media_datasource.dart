import 'package:space_media_app/features/space_media/data/models/space_media_model.dart';

abstract class ISpaceMediaDatasource {


  Future<SpaceMediaModel> getSpaceMediaFromDate(DateTime date);
}
