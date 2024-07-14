import 'apiUtil/response_wrappers.dart';

// This class is the medium between repositories
// and business logic which is provider in this case
// business model request data from the catalog
// and catalog redirect that request and retrieve
// that data and emitted back to business model

class CatalogFacadeService {
  const CatalogFacadeService(
      // required this.articlesRepository,
      );

  // final ArticlesRepository articlesRepository;

  // Future<ResponseWrapper<List<MostViewedArticle>>> getArticles({
  //   required String duration,
  // }) async {
  //   return await articlesRepository.getArticles(
  //     duration: duration,
  //   );
  // }
}
