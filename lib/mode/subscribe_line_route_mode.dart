class SubScribeLineRouteMode {
  num code;
  List<SubScribeLineRouteContent> content;
  int total;

  SubScribeLineRouteMode({this.code, this.content, this.total});

  SubScribeLineRouteMode.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['content'] != null) {
      content = new List<SubScribeLineRouteContent>();
      json['content'].forEach((v) {
        content.add(new SubScribeLineRouteContent.fromJson(v));
      });
    }
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.content != null) {
      data['content'] = this.content.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    return data;
  }
}

class SubScribeLineRouteContent {
  String code;
  String moduleCode;
  String unloadingProvinceName;
  String creatorUserCode;
  String ip;
  String ownerUserCode;
  String unloadingCityCode;
  String synchronousId;
  String updateTime;
  String unloadingCityName;
  String updateUserCode;
  String ownerOrgName;
  bool deleted;
  String ownerOrgCode;
  String loadingCityName;
  String unloadingProvinceCode;
  String createTime;
  String loadingCityCode;
  String creatorUsername;
  String updateUsername;
  bool disabled;
  String loadingProvinceCode;
  num id;
  String loadingProvinceName;

  SubScribeLineRouteContent(
      {this.code,
      this.moduleCode,
      this.unloadingProvinceName,
      this.creatorUserCode,
      this.ip,
      this.ownerUserCode,
      this.unloadingCityCode,
      this.synchronousId,
      this.updateTime,
      this.unloadingCityName,
      this.updateUserCode,
      this.ownerOrgName,
      this.deleted,
      this.ownerOrgCode,
      this.loadingCityName,
      this.unloadingProvinceCode,
      this.createTime,
      this.loadingCityCode,
      this.creatorUsername,
      this.updateUsername,
      this.disabled,
      this.loadingProvinceCode,
      this.id,
      this.loadingProvinceName});

  SubScribeLineRouteContent.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    moduleCode = json['moduleCode'];
    unloadingProvinceName = json['unloadingProvinceName'];
    creatorUserCode = json['creatorUserCode'];
    ip = json['ip'];
    ownerUserCode = json['ownerUserCode'];
    unloadingCityCode = json['unloadingCityCode'];
    synchronousId = json['synchronousId'];
    updateTime = json['updateTime'];
    unloadingCityName = json['unloadingCityName'];
    updateUserCode = json['updateUserCode'];
    ownerOrgName = json['ownerOrgName'];
    deleted = json['deleted'];
    ownerOrgCode = json['ownerOrgCode'];
    loadingCityName = json['loadingCityName'];
    unloadingProvinceCode = json['unloadingProvinceCode'];
    createTime = json['createTime'];
    loadingCityCode = json['loadingCityCode'];
    creatorUsername = json['creatorUsername'];
    updateUsername = json['updateUsername'];
    disabled = json['disabled'];
    loadingProvinceCode = json['loadingProvinceCode'];
    id = json['id'];
    loadingProvinceName = json['loadingProvinceName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['moduleCode'] = this.moduleCode;
    data['unloadingProvinceName'] = this.unloadingProvinceName;
    data['creatorUserCode'] = this.creatorUserCode;
    data['ip'] = this.ip;
    data['ownerUserCode'] = this.ownerUserCode;
    data['unloadingCityCode'] = this.unloadingCityCode;
    data['synchronousId'] = this.synchronousId;
    data['updateTime'] = this.updateTime;
    data['unloadingCityName'] = this.unloadingCityName;
    data['updateUserCode'] = this.updateUserCode;
    data['ownerOrgName'] = this.ownerOrgName;
    data['deleted'] = this.deleted;
    data['ownerOrgCode'] = this.ownerOrgCode;
    data['loadingCityName'] = this.loadingCityName;
    data['unloadingProvinceCode'] = this.unloadingProvinceCode;
    data['createTime'] = this.createTime;
    data['loadingCityCode'] = this.loadingCityCode;
    data['creatorUsername'] = this.creatorUsername;
    data['updateUsername'] = this.updateUsername;
    data['disabled'] = this.disabled;
    data['loadingProvinceCode'] = this.loadingProvinceCode;
    data['id'] = this.id;
    data['loadingProvinceName'] = this.loadingProvinceName;
    return data;
  }
}
