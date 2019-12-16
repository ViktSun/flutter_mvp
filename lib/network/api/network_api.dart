class Api {
  //base Url
  static const String baseUrl = "http://baobab.kaiyanapp.com/api/";

  //首页精选数据
  static const String getFirstHomeData = "v2/feed?";

  //根据视频ID 获取视频
  static const String getRelatedData = "v4/video/related";

  //获取分类
  static const String getCategory ="v4/categories";

  //获取分类详情列表
  static const String getCategoryDetailList ="v4/categories/videoList";

  //获取全部排行榜的Info
  static const String getRankList = "v4/rankList";

  //获取关注数据
  static const String getFollowInfo = "v4/tabs/follow";

  ///获取热门搜索词
  static const String getHotWords = "v3/queries/hot";

  ///获取搜索结果
  static const String getSearchData = "v1/search?&num=10&start=10";

}
