class HotBeanEntity {
	HotBeanTabinfo tabInfo;

	HotBeanEntity({this.tabInfo});

	HotBeanEntity.fromJson(Map<String, dynamic> json) {
		tabInfo = json['tabInfo'] != null ? new HotBeanTabinfo.fromJson(json['tabInfo']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.tabInfo != null) {
      data['tabInfo'] = this.tabInfo.toJson();
    }
		return data;
	}
}

class HotBeanTabinfo {
	List<HotBeanTabinfoTablist> tabList;
	int defaultIdx;

	HotBeanTabinfo({this.tabList, this.defaultIdx});

	HotBeanTabinfo.fromJson(Map<String, dynamic> json) {
		if (json['tabList'] != null) {
			tabList = new List<HotBeanTabinfoTablist>();(json['tabList'] as List).forEach((v) { tabList.add(new HotBeanTabinfoTablist.fromJson(v)); });
		}
		defaultIdx = json['defaultIdx'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.tabList != null) {
      data['tabList'] =  this.tabList.map((v) => v.toJson()).toList();
    }
		data['defaultIdx'] = this.defaultIdx;
		return data;
	}
}

class HotBeanTabinfoTablist {
	int nameType;
	String apiUrl;
	String name;
	int tabType;
	int id;
	dynamic adTrack;

	HotBeanTabinfoTablist({this.nameType, this.apiUrl, this.name, this.tabType, this.id, this.adTrack});

	HotBeanTabinfoTablist.fromJson(Map<String, dynamic> json) {
		nameType = json['nameType'];
		apiUrl = json['apiUrl'];
		name = json['name'];
		tabType = json['tabType'];
		id = json['id'];
		adTrack = json['adTrack'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['nameType'] = this.nameType;
		data['apiUrl'] = this.apiUrl;
		data['name'] = this.name;
		data['tabType'] = this.tabType;
		data['id'] = this.id;
		data['adTrack'] = this.adTrack;
		return data;
	}
}
