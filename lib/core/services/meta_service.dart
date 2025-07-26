import 'package:metadata_fetch/metadata_fetch.dart';
import '../models/link_meta.dart';

class MetaService {
  static Future<LinkMeta?> fetchMeta(String url) async {
    final data = await MetadataFetch.extract(url);
    if (data == null) return null;
    return LinkMeta(
      url: url,
      title: data.title,
      description: data.description,
      image: data.image,
    );
  }
}
