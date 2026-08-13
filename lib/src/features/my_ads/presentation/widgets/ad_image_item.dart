import 'package:image_picker/image_picker.dart';

import '../../../../core/shared/data/models/photo_model.dart';

sealed class AdImageItem {
  const AdImageItem();
}

class AdImageItemLocal extends AdImageItem {
  const AdImageItemLocal(this.file);

  final XFile file;
}

class AdImageItemNetwork extends AdImageItem {
  const AdImageItemNetwork(this.photo);

  final PhotoModel photo;
}
