class HeaderBeanEntity {
	bool ifShowNotificationIcon;
	bool expert;
	String icon;
	String actionUrl;
	String description;
	String title;
	HeaderBeanFollow follow;
	int uid;
	dynamic subTitle;
	String iconType;
	bool ifPgc;
	int id;
	dynamic adTrack;

	HeaderBeanEntity({this.ifShowNotificationIcon, this.expert, this.icon, this.actionUrl, this.description, this.title, this.follow, this.uid, this.subTitle, this.iconType, this.ifPgc, this.id, this.adTrack});

	HeaderBeanEntity.fromJson(Map<String, dynamic> json) {
		ifShowNotificationIcon = json['ifShowNotificationIcon'];
		expert = json['expert'];
		icon = json['icon'];
		actionUrl = json['actionUrl'];
		description = json['description'];
		title = json['title'];
		follow = json['follow'] != null ? new HeaderBeanFollow.fromJson(json['follow']) : null;
		uid = json['uid'];
		subTitle = json['subTitle'];
		iconType = json['iconType'];
		ifPgc = json['ifPgc'];
		id = json['id'];
		adTrack = json['adTrack'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['ifShowNotificationIcon'] = this.ifShowNotificationIcon;
		data['expert'] = this.expert;
		data['icon'] = this.icon;
		data['actionUrl'] = this.actionUrl;
		data['description'] = this.description;
		data['title'] = this.title;
		if (this.follow != null) {
      data['follow'] = this.follow.toJson();
    }
		data['uid'] = this.uid;
		data['subTitle'] = this.subTitle;
		data['iconType'] = this.iconType;
		data['ifPgc'] = this.ifPgc;
		data['id'] = this.id;
		data['adTrack'] = this.adTrack;
		return data;
	}
}

class HeaderBeanFollow {
	int itemId;
	String itemType;
	bool followed;

	HeaderBeanFollow({this.itemId, this.itemType, this.followed});

	HeaderBeanFollow.fromJson(Map<String, dynamic> json) {
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
