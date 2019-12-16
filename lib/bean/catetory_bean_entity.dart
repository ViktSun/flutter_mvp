class CategoryBeanEntity {
	String bgColor;
	int defaultAuthorId;
	String headerImage;
	int tagId;
	String name;
	dynamic alias;
	String description;
	int id;
	String bgPicture;

	CategoryBeanEntity({this.bgColor, this.defaultAuthorId, this.headerImage, this.tagId, this.name, this.alias, this.description, this.id, this.bgPicture});

	CategoryBeanEntity.fromJson(Map<String, dynamic> json) {
		bgColor = json['bgColor'];
		defaultAuthorId = json['defaultAuthorId'];
		headerImage = json['headerImage'];
		tagId = json['tagId'];
		name = json['name'];
		alias = json['alias'];
		description = json['description'];
		id = json['id'];
		bgPicture = json['bgPicture'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['bgColor'] = this.bgColor;
		data['defaultAuthorId'] = this.defaultAuthorId;
		data['headerImage'] = this.headerImage;
		data['tagId'] = this.tagId;
		data['name'] = this.name;
		data['alias'] = this.alias;
		data['description'] = this.description;
		data['id'] = this.id;
		data['bgPicture'] = this.bgPicture;
		return data;
	}
}
