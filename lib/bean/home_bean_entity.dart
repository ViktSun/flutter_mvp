import 'package:flutter_mvp/bean/header_bean_entity.dart';

class HomeBeanEntity {
  int nextPublishTime;
  dynamic dialog;
  String newestIssueType;
  String nextPageUrl;
  List<HomeItemIssuelist> issueList;

  HomeBeanEntity(
      {this.nextPublishTime,
      this.dialog,
      this.newestIssueType,
      this.nextPageUrl,
      this.issueList});

  HomeBeanEntity.fromJson(Map<String, dynamic> json) {
    nextPublishTime = json['nextPublishTime'];
    dialog = json['dialog'];
    newestIssueType = json['newestIssueType'];
    nextPageUrl = json['nextPageUrl'];
    if (json['issueList'] != null) {
      issueList = new List<HomeItemIssuelist>();
      (json['issueList'] as List).forEach((v) {
        issueList.add(new HomeItemIssuelist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nextPublishTime'] = this.nextPublishTime;
    data['dialog'] = this.dialog;
    data['newestIssueType'] = this.newestIssueType;
    data['nextPageUrl'] = this.nextPageUrl;
    if (this.issueList != null) {
      data['issueList'] = this.issueList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HomeItemIssuelist {
  int date;
  int publishTime;
  int releaseTime;
  int count;
  int total=0;
  List<HomeItemIssuelistItemlist> itemList;
  String type;
  String nextPageUrl;

  HomeItemIssuelist(
      {this.date,
      this.publishTime,
      this.releaseTime,
      this.count,
      this.total,
      this.itemList,
      this.nextPageUrl,
      this.type});

  HomeItemIssuelist.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    publishTime = json['publishTime'];
    releaseTime = json['releaseTime'];
    count = json['count'];
    total = json['total'];
    if (json['itemList'] != null) {
      itemList = new List<HomeItemIssuelistItemlist>();
      (json['itemList'] as List).forEach((v) {
        itemList.add(new HomeItemIssuelistItemlist.fromJson(v));
      });
    }
    nextPageUrl = json['nextPageUrl'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['publishTime'] = this.publishTime;
    data['releaseTime'] = this.releaseTime;
    data['count'] = this.count;
    data['total'] = this.total;
    if (this.itemList != null) {
      data['itemList'] = this.itemList.map((v) => v.toJson()).toList();
    }
    data['type'] = this.type;
    data['nextPageUrl'] = this.nextPageUrl;
    return data;
  }
}

class HomeItemIssuelistItemlist {
  HomeItemIssuelistItemlistData data;
  int adIndex;
  dynamic tag;
  int id;
  String type;

  HomeItemIssuelistItemlist(
      {this.data, this.adIndex, this.tag, this.id, this.type});

  HomeItemIssuelistItemlist.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? new HomeItemIssuelistItemlistData.fromJson(json['data'])
        : null;
    adIndex = json['adIndex'];
    tag = json['tag'];
    id = json['id'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['adIndex'] = this.adIndex;
    data['tag'] = this.tag;
    data['id'] = this.id;
    data['type'] = this.type;
    return data;
  }
}

class HomeItemIssuelistItemlistData {
  int date;
  dynamic shareAdTrack;
  String text;
  String font;
  int releaseTime;
  String description;
  String remark;
  bool collected;
  String title;
  String type;
  dynamic favoriteAdTrack;
  dynamic waterMarks;
  String playUrl;
  HomeItemIssuelistItemlistDataCover cover;
  int duration;
  String xLibrary;
  String descriptionEditor;
  HomeItemIssuelistItemlistDataProvider provider;
  int id;
  dynamic descriptionPgc;
  dynamic titlePgc;
  dynamic adTrack;
  List<Null> subtitles;
  bool ad;
  dynamic src;
  HomeItemIssuelistItemlistDataAuthor author;
  String dataType;
  int searchWeight;
  dynamic playlists;
  HomeItemIssuelistItemlistDataConsumption consumption;
  dynamic label;
  bool played;
  List<HomeItemIssuelistItemlistDataTag> tags;
  dynamic webAdTrack;
  List<Null> labelList;
  dynamic lastViewTime;
  List<HomeItemIssuelistItemlistDataPlayinfo> playInfo;
  bool ifLimitVideo;
  HomeItemIssuelistItemlistDataWeburl webUrl;
  dynamic campaign;
  String category;
  int idx;
  String slogan;
  dynamic thumbPlayUrl;
  String resourceType;
  dynamic promotion;
  HeaderBeanEntity header;
  List<HomeItemIssuelistItemlist> itemList;

  HomeItemIssuelistItemlistData(
      {this.date,
      this.shareAdTrack,
      this.text,
      this.font,
      this.releaseTime,
      this.description,
      this.remark,
      this.collected,
      this.title,
      this.type,
      this.favoriteAdTrack,
      this.waterMarks,
      this.playUrl,
      this.cover,
      this.duration,
      this.xLibrary,
      this.descriptionEditor,
      this.provider,
      this.id,
      this.descriptionPgc,
      this.titlePgc,
      this.adTrack,
      this.subtitles,
      this.ad,
      this.src,
      this.author,
      this.dataType,
      this.searchWeight,
      this.playlists,
      this.consumption,
      this.label,
      this.played,
      this.tags,
      this.webAdTrack,
      this.labelList,
      this.lastViewTime,
      this.playInfo,
      this.ifLimitVideo,
      this.webUrl,
      this.campaign,
      this.category,
      this.idx,
      this.slogan,
      this.thumbPlayUrl,
      this.resourceType,
      this.header,
      this.itemList,
      this.promotion});

  HomeItemIssuelistItemlistData.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    shareAdTrack = json['shareAdTrack'];
    text = json["text"];
    font = json["font"];
    releaseTime = json['releaseTime'];
    description = json['description'];
    remark = json['remark'];
    collected = json['collected'];
    title = json['title'];
    type = json['type'];
    favoriteAdTrack = json['favoriteAdTrack'];
    waterMarks = json['waterMarks'];
    playUrl = json['playUrl'];
    cover = json['cover'] != null
        ? new HomeItemIssuelistItemlistDataCover.fromJson(json['cover'])
        : null;
    duration = json['duration'];
    xLibrary = json['library'];
    descriptionEditor = json['descriptionEditor'];
    provider = json['provider'] != null
        ? new HomeItemIssuelistItemlistDataProvider.fromJson(json['provider'])
        : null;
    id = json['id'];
    descriptionPgc = json['descriptionPgc'];
    titlePgc = json['titlePgc'];
    adTrack = json['adTrack'];
    if (json['subtitles'] != null) {
      subtitles = new List<Null>();
    }
    ad = json['ad'];
    src = json['src'];
    author = json['author'] != null
        ? new HomeItemIssuelistItemlistDataAuthor.fromJson(json['author'])
        : null;
    dataType = json['dataType'];
    searchWeight = json['searchWeight'];
    playlists = json['playlists'];
    consumption = json['consumption'] != null
        ? new HomeItemIssuelistItemlistDataConsumption.fromJson(
            json['consumption'])
        : null;
    label = json['label'];
    played = json['played'];
    if (json['tags'] != null) {
      tags = new List<HomeItemIssuelistItemlistDataTag>();
      (json['tags'] as List).forEach((v) {
        tags.add(new HomeItemIssuelistItemlistDataTag.fromJson(v));
      });
    }
    webAdTrack = json['webAdTrack'];
    if (json['labelList'] != null) {
      labelList = new List<Null>();
    }
    lastViewTime = json['lastViewTime'];
    if (json['playInfo'] != null) {
      playInfo = new List<HomeItemIssuelistItemlistDataPlayinfo>();
      (json['playInfo'] as List).forEach((v) {
        playInfo.add(new HomeItemIssuelistItemlistDataPlayinfo.fromJson(v));
      });
    }
    ifLimitVideo = json['ifLimitVideo'];
    webUrl = json['webUrl'] != null
        ? new HomeItemIssuelistItemlistDataWeburl.fromJson(json['webUrl'])
        : null;
    campaign = json['campaign'];
    category = json['category'];
    idx = json['idx'];
    slogan = json['slogan'];
    thumbPlayUrl = json['thumbPlayUrl'];
    resourceType = json['resourceType'];
    promotion = json['promotion'];

    header = json['header'] != null
        ? new HeaderBeanEntity.fromJson(json['header'])
        : null;

    if (json['itemList'] != null) {
      itemList = new List<HomeItemIssuelistItemlist>();
      (json['itemList'] as List).forEach((v) {
        itemList.add(new HomeItemIssuelistItemlist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['shareAdTrack'] = this.shareAdTrack;
    data['releaseTime'] = this.releaseTime;
    data['description'] = this.description;
    data['remark'] = this.remark;
    data['collected'] = this.collected;
    data['title'] = this.title;
    data['type'] = this.type;
    data['favoriteAdTrack'] = this.favoriteAdTrack;
    data['waterMarks'] = this.waterMarks;
    data['playUrl'] = this.playUrl;
    if (this.cover != null) {
      data['cover'] = this.cover.toJson();
    }
    data['duration'] = this.duration;
    data['library'] = this.xLibrary;
    data['descriptionEditor'] = this.descriptionEditor;
    if (this.provider != null) {
      data['provider'] = this.provider.toJson();
    }
    data['id'] = this.id;
    data['descriptionPgc'] = this.descriptionPgc;
    data['titlePgc'] = this.titlePgc;
    data['adTrack'] = this.adTrack;
    if (this.subtitles != null) {
      data['subtitles'] = [];
    }
    data['ad'] = this.ad;
    data['src'] = this.src;
    if (this.author != null) {
      data['author'] = this.author.toJson();
    }
    data['dataType'] = this.dataType;
    data['searchWeight'] = this.searchWeight;
    data['playlists'] = this.playlists;
    if (this.consumption != null) {
      data['consumption'] = this.consumption.toJson();
    }
    data['label'] = this.label;
    data['played'] = this.played;
    if (this.tags != null) {
      data['tags'] = this.tags.map((v) => v.toJson()).toList();
    }
    data['webAdTrack'] = this.webAdTrack;
    if (this.labelList != null) {
      data['labelList'] = [];
    }
    data['lastViewTime'] = this.lastViewTime;
    if (this.playInfo != null) {
      data['playInfo'] = this.playInfo.map((v) => v.toJson()).toList();
    }
    data['ifLimitVideo'] = this.ifLimitVideo;
    if (this.webUrl != null) {
      data['webUrl'] = this.webUrl.toJson();
    }
    data['campaign'] = this.campaign;
    data['category'] = this.category;
    data['idx'] = this.idx;
    data['slogan'] = this.slogan;
    data['thumbPlayUrl'] = this.thumbPlayUrl;
    data['resourceType'] = this.resourceType;
    data['promotion'] = this.promotion;

    if (this.header != null) {
      data['header'] = this.header.toJson();
    }

    if (this.itemList != null) {
      data['itemList'] = this.itemList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HomeItemIssuelistItemlistDataCover {
  String feed;
  String detail;
  dynamic sharing;
  String blurred;
  String homepage;

  HomeItemIssuelistItemlistDataCover(
      {this.feed, this.detail, this.sharing, this.blurred, this.homepage});

  HomeItemIssuelistItemlistDataCover.fromJson(Map<String, dynamic> json) {
    feed = json['feed'];
    detail = json['detail'];
    sharing = json['sharing'];
    blurred = json['blurred'];
    homepage = json['homepage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['feed'] = this.feed;
    data['detail'] = this.detail;
    data['sharing'] = this.sharing;
    data['blurred'] = this.blurred;
    data['homepage'] = this.homepage;
    return data;
  }
}

class HomeItemIssuelistItemlistDataProvider {
  String name;
  String icon;
  String alias;

  HomeItemIssuelistItemlistDataProvider({this.name, this.icon, this.alias});

  HomeItemIssuelistItemlistDataProvider.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    icon = json['icon'];
    alias = json['alias'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['icon'] = this.icon;
    data['alias'] = this.alias;
    return data;
  }
}

class HomeItemIssuelistItemlistDataAuthor {
  HomeItemIssuelistItemlistDataAuthorShield shield;
  bool expert;
  int approvedNotReadyVideoCount;
  String icon;
  String link;
  String description;
  int videoNum;
  HomeItemIssuelistItemlistDataAuthorFollow follow;
  int recSort;
  String name;
  bool ifPgc;
  int latestReleaseTime;
  int id;
  dynamic adTrack;

  HomeItemIssuelistItemlistDataAuthor(
      {this.shield,
      this.expert,
      this.approvedNotReadyVideoCount,
      this.icon,
      this.link,
      this.description,
      this.videoNum,
      this.follow,
      this.recSort,
      this.name,
      this.ifPgc,
      this.latestReleaseTime,
      this.id,
      this.adTrack});

  HomeItemIssuelistItemlistDataAuthor.fromJson(Map<String, dynamic> json) {
    shield = json['shield'] != null
        ? new HomeItemIssuelistItemlistDataAuthorShield.fromJson(json['shield'])
        : null;
    expert = json['expert'];
    approvedNotReadyVideoCount = json['approvedNotReadyVideoCount'];
    icon = json['icon'];
    link = json['link'];
    description = json['description'];
    videoNum = json['videoNum'];
    follow = json['follow'] != null
        ? new HomeItemIssuelistItemlistDataAuthorFollow.fromJson(json['follow'])
        : null;
    recSort = json['recSort'];
    name = json['name'];
    ifPgc = json['ifPgc'];
    latestReleaseTime = json['latestReleaseTime'];
    id = json['id'];
    adTrack = json['adTrack'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.shield != null) {
      data['shield'] = this.shield.toJson();
    }
    data['expert'] = this.expert;
    data['approvedNotReadyVideoCount'] = this.approvedNotReadyVideoCount;
    data['icon'] = this.icon;
    data['link'] = this.link;
    data['description'] = this.description;
    data['videoNum'] = this.videoNum;
    if (this.follow != null) {
      data['follow'] = this.follow.toJson();
    }
    data['recSort'] = this.recSort;
    data['name'] = this.name;
    data['ifPgc'] = this.ifPgc;
    data['latestReleaseTime'] = this.latestReleaseTime;
    data['id'] = this.id;
    data['adTrack'] = this.adTrack;
    return data;
  }
}

class HomeItemIssuelistItemlistDataAuthorShield {
  int itemId;
  String itemType;
  bool shielded;

  HomeItemIssuelistItemlistDataAuthorShield(
      {this.itemId, this.itemType, this.shielded});

  HomeItemIssuelistItemlistDataAuthorShield.fromJson(
      Map<String, dynamic> json) {
    itemId = json['itemId'];
    itemType = json['itemType'];
    shielded = json['shielded'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['itemId'] = this.itemId;
    data['itemType'] = this.itemType;
    data['shielded'] = this.shielded;
    return data;
  }
}

class HomeItemIssuelistItemlistDataAuthorFollow {
  int itemId;
  String itemType;
  bool followed;

  HomeItemIssuelistItemlistDataAuthorFollow(
      {this.itemId, this.itemType, this.followed});

  HomeItemIssuelistItemlistDataAuthorFollow.fromJson(
      Map<String, dynamic> json) {
    itemId = json['itemId'];
    itemType = json['itemType'];
    followed = json['followed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['itemId'] = this.itemId;
    data['itemType'] = this.itemType;
    data['followed'] = this.followed;
    return data;
  }
}

class HomeItemIssuelistItemlistDataConsumption {
  int shareCount;
  int replyCount;
  int collectionCount;

  HomeItemIssuelistItemlistDataConsumption(
      {this.shareCount, this.replyCount, this.collectionCount});

  HomeItemIssuelistItemlistDataConsumption.fromJson(Map<String, dynamic> json) {
    shareCount = json['shareCount'];
    replyCount = json['replyCount'];
    collectionCount = json['collectionCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shareCount'] = this.shareCount;
    data['replyCount'] = this.replyCount;
    data['collectionCount'] = this.collectionCount;
    return data;
  }
}

class HomeItemIssuelistItemlistDataTag {
  dynamic childTagIdList;
  String tagRecType;
  String headerImage;
  String name;
  String actionUrl;
  int communityIndex;
  int id;
  dynamic childTagList;
  String bgPicture;
  dynamic adTrack;
  dynamic desc;

  HomeItemIssuelistItemlistDataTag(
      {this.childTagIdList,
      this.tagRecType,
      this.headerImage,
      this.name,
      this.actionUrl,
      this.communityIndex,
      this.id,
      this.childTagList,
      this.bgPicture,
      this.adTrack,
      this.desc});

  HomeItemIssuelistItemlistDataTag.fromJson(Map<String, dynamic> json) {
    childTagIdList = json['childTagIdList'];
    tagRecType = json['tagRecType'];
    headerImage = json['headerImage'];
    name = json['name'];
    actionUrl = json['actionUrl'];
    communityIndex = json['communityIndex'];
    id = json['id'];
    childTagList = json['childTagList'];
    bgPicture = json['bgPicture'];
    adTrack = json['adTrack'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['childTagIdList'] = this.childTagIdList;
    data['tagRecType'] = this.tagRecType;
    data['headerImage'] = this.headerImage;
    data['name'] = this.name;
    data['actionUrl'] = this.actionUrl;
    data['communityIndex'] = this.communityIndex;
    data['id'] = this.id;
    data['childTagList'] = this.childTagList;
    data['bgPicture'] = this.bgPicture;
    data['adTrack'] = this.adTrack;
    data['desc'] = this.desc;
    return data;
  }
}

class HomeItemIssuelistItemlistDataPlayinfo {
  int width;
  String name;
  List<HomeItemIssuelistItemlistDataPlayinfoUrllist> urlList;
  String type;
  String url;
  int height;

  HomeItemIssuelistItemlistDataPlayinfo(
      {this.width, this.name, this.urlList, this.type, this.url, this.height});

  HomeItemIssuelistItemlistDataPlayinfo.fromJson(Map<String, dynamic> json) {
    width = json['width'];
    name = json['name'];
    if (json['urlList'] != null) {
      urlList = new List<HomeItemIssuelistItemlistDataPlayinfoUrllist>();
      (json['urlList'] as List).forEach((v) {
        urlList
            .add(new HomeItemIssuelistItemlistDataPlayinfoUrllist.fromJson(v));
      });
    }
    type = json['type'];
    url = json['url'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['width'] = this.width;
    data['name'] = this.name;
    if (this.urlList != null) {
      data['urlList'] = this.urlList.map((v) => v.toJson()).toList();
    }
    data['type'] = this.type;
    data['url'] = this.url;
    data['height'] = this.height;
    return data;
  }
}

class HomeItemIssuelistItemlistDataPlayinfoUrllist {
  int size;
  String name;
  String url;

  HomeItemIssuelistItemlistDataPlayinfoUrllist(
      {this.size, this.name, this.url});

  HomeItemIssuelistItemlistDataPlayinfoUrllist.fromJson(
      Map<String, dynamic> json) {
    size = json['size'];
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['size'] = this.size;
    data['name'] = this.name;
    data['url'] = this.url;
    return data;
  }
}

class HomeItemIssuelistItemlistDataWeburl {
  String forWeibo;
  String raw;

  HomeItemIssuelistItemlistDataWeburl({this.forWeibo, this.raw});

  HomeItemIssuelistItemlistDataWeburl.fromJson(Map<String, dynamic> json) {
    forWeibo = json['forWeibo'];
    raw = json['raw'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['forWeibo'] = this.forWeibo;
    data['raw'] = this.raw;
    return data;
  }
}
