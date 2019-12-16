
import 'package:flutter_mvp/base/provider/base_list_provider.dart';

class HomeProvider<T> extends BaseListProvider<T> {
  List<T> _bannerData = [];

  List<T> get banners => _bannerData;

  String _nextUrl = "";

  String get nextPageUrl => _nextUrl;

  void setNextPageUrl(String nextPage) {
    _nextUrl = nextPage;
  }

  void setBannerData(List<T> bannerData) {
    _bannerData = bannerData;
  }
}
