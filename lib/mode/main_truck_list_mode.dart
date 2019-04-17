class MainTruckListMode {
  num code;
  List<TruckContent> content;
  int total;

  MainTruckListMode({this.code, this.content, this.total});

  MainTruckListMode.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['content'] != null) {
      content = new List<TruckContent>();
      json['content'].forEach((v) {
        content.add(new TruckContent.fromJson(v));
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

class TruckContent {
  String standard;
  String transportLicenseNo;
  String transportLicenseRecourseCode;
  String code;
  String certStatus;
  String description;
  String ownerOrgName;
  String truckLengthUnitCode;
  String truckCode;
  num truckTotalWeight;
  bool disabled;
  num id;
  String drivingLicenseRecourseCode;
  String moduleCode;
  String creatorUserCode;
  String ip;
  String ownerUserCode;
  String truckModelCode;
  String synchronousId;
  String regTonnageUnitCode;
  String updateTime;
  num truckTowWeight;
  String truckBodyImageResourceCode;
  String updateUserCode;
  bool deleted;
  String ownerOrgCode;
  num regTonnage;
  String createTime;
  String truckLicenseType;
  String truckModelName;
  String creatorUsername;
  String updateUsername;
  num truckLength;
  String truckLicenseNo;
  bool isTrailer;
  String powerType;

  TruckContent(
      {this.standard,
      this.transportLicenseNo,
      this.transportLicenseRecourseCode,
      this.code,
      this.certStatus,
      this.description,
      this.ownerOrgName,
      this.truckLengthUnitCode,
      this.truckCode,
      this.truckTotalWeight,
      this.disabled,
      this.id,
      this.drivingLicenseRecourseCode,
      this.moduleCode,
      this.creatorUserCode,
      this.ip,
      this.ownerUserCode,
      this.truckModelCode,
      this.synchronousId,
      this.regTonnageUnitCode,
      this.updateTime,
      this.truckTowWeight,
      this.truckBodyImageResourceCode,
      this.updateUserCode,
      this.deleted,
      this.ownerOrgCode,
      this.regTonnage,
      this.createTime,
      this.truckLicenseType,
      this.truckModelName,
      this.creatorUsername,
      this.updateUsername,
      this.truckLength,
      this.truckLicenseNo,
      this.isTrailer,
      this.powerType});

  TruckContent.fromJson(Map<String, dynamic> json) {
    standard = json['standard'];
    transportLicenseNo = json['transportLicenseNo'];
    transportLicenseRecourseCode = json['transportLicenseRecourseCode'];
    code = json['code'];
    certStatus = json['certStatus'];
    description = json['description'];
    ownerOrgName = json['ownerOrgName'];
    truckLengthUnitCode = json['truckLengthUnitCode'];
    truckCode = json['truckCode'];
    truckTotalWeight = json['truckTotalWeight'];
    disabled = json['disabled'];
    id = json['id'];
    drivingLicenseRecourseCode = json['drivingLicenseRecourseCode'];
    moduleCode = json['moduleCode'];
    creatorUserCode = json['creatorUserCode'];
    ip = json['ip'];
    ownerUserCode = json['ownerUserCode'];
    truckModelCode = json['truckModelCode'];
    synchronousId = json['synchronousId'];
    regTonnageUnitCode = json['regTonnageUnitCode'];
    updateTime = json['updateTime'];
    truckTowWeight = json['truckTowWeight'];
    truckBodyImageResourceCode = json['truckBodyImageResourceCode'];
    updateUserCode = json['updateUserCode'];
    deleted = json['deleted'];
    ownerOrgCode = json['ownerOrgCode'];
    regTonnage = json['regTonnage'];
    createTime = json['createTime'];
    truckLicenseType = json['truckLicenseType'];
    truckModelName = json['truckModelName'];
    creatorUsername = json['creatorUsername'];
    updateUsername = json['updateUsername'];
    truckLength = json['truckLength'];
    truckLicenseNo = json['truckLicenseNo'];
    isTrailer = json['isTrailer'];
    powerType = json['powerType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['standard'] = this.standard;
    data['transportLicenseNo'] = this.transportLicenseNo;
    data['transportLicenseRecourseCode'] = this.transportLicenseRecourseCode;
    data['code'] = this.code;
    data['certStatus'] = this.certStatus;
    data['description'] = this.description;
    data['ownerOrgName'] = this.ownerOrgName;
    data['truckLengthUnitCode'] = this.truckLengthUnitCode;
    data['truckCode'] = this.truckCode;
    data['truckTotalWeight'] = this.truckTotalWeight;
    data['disabled'] = this.disabled;
    data['id'] = this.id;
    data['drivingLicenseRecourseCode'] = this.drivingLicenseRecourseCode;
    data['moduleCode'] = this.moduleCode;
    data['creatorUserCode'] = this.creatorUserCode;
    data['ip'] = this.ip;
    data['ownerUserCode'] = this.ownerUserCode;
    data['truckModelCode'] = this.truckModelCode;
    data['synchronousId'] = this.synchronousId;
    data['regTonnageUnitCode'] = this.regTonnageUnitCode;
    data['updateTime'] = this.updateTime;
    data['truckTowWeight'] = this.truckTowWeight;
    data['truckBodyImageResourceCode'] = this.truckBodyImageResourceCode;
    data['updateUserCode'] = this.updateUserCode;
    data['deleted'] = this.deleted;
    data['ownerOrgCode'] = this.ownerOrgCode;
    data['regTonnage'] = this.regTonnage;
    data['createTime'] = this.createTime;
    data['truckLicenseType'] = this.truckLicenseType;
    data['truckModelName'] = this.truckModelName;
    data['creatorUsername'] = this.creatorUsername;
    data['updateUsername'] = this.updateUsername;
    data['truckLength'] = this.truckLength;
    data['truckLicenseNo'] = this.truckLicenseNo;
    data['isTrailer'] = this.isTrailer;
    data['powerType'] = this.powerType;
    return data;
  }
}
