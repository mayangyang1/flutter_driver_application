class TrialerTruckMode {
  num code;
  TrialerTruckContent content;

  TrialerTruckMode({this.code, this.content});

  TrialerTruckMode.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    content = json['content'] != null ? new TrialerTruckContent.fromJson(json['content']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.content != null) {
      data['content'] = this.content.toJson();
    }
    return data;
  }
}

class TrialerTruckContent {
  String transportLicenseNo;
  String transportLicenseRecourseCode;
  String certStatus;
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
  String truckTowWeightUnitCode;
  String synchronousId;
  String regTonnageUnitCode;
  String updateTime;
  String updateUserCode;
  bool deleted;
  String ownerOrgCode;
  num regTonnage;
  String createTime;
  String truckLicenseType;
  String truckModelName;
  String creatorUsername;
  String updateUsername;
  String truckTotalWeightUnitCode;
  num truckLength;
  String truckLicenseNo;
  bool isTrailer;

  TrialerTruckContent(
      {this.transportLicenseNo,
      this.transportLicenseRecourseCode,
      this.certStatus,
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
      this.truckTowWeightUnitCode,
      this.synchronousId,
      this.regTonnageUnitCode,
      this.updateTime,
      this.updateUserCode,
      this.deleted,
      this.ownerOrgCode,
      this.regTonnage,
      this.createTime,
      this.truckLicenseType,
      this.truckModelName,
      this.creatorUsername,
      this.updateUsername,
      this.truckTotalWeightUnitCode,
      this.truckLength,
      this.truckLicenseNo,
      this.isTrailer});

  TrialerTruckContent.fromJson(Map<String, dynamic> json) {
    transportLicenseNo = json['transportLicenseNo'];
    transportLicenseRecourseCode = json['transportLicenseRecourseCode'];
    certStatus = json['certStatus'];
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
    truckTowWeightUnitCode = json['truckTowWeightUnitCode'];
    synchronousId = json['synchronousId'];
    regTonnageUnitCode = json['regTonnageUnitCode'];
    updateTime = json['updateTime'];
    updateUserCode = json['updateUserCode'];
    deleted = json['deleted'];
    ownerOrgCode = json['ownerOrgCode'];
    regTonnage = json['regTonnage'];
    createTime = json['createTime'];
    truckLicenseType = json['truckLicenseType'];
    truckModelName = json['truckModelName'];
    creatorUsername = json['creatorUsername'];
    updateUsername = json['updateUsername'];
    truckTotalWeightUnitCode = json['truckTotalWeightUnitCode'];
    truckLength = json['truckLength'];
    truckLicenseNo = json['truckLicenseNo'];
    isTrailer = json['isTrailer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['transportLicenseNo'] = this.transportLicenseNo;
    data['transportLicenseRecourseCode'] = this.transportLicenseRecourseCode;
    data['certStatus'] = this.certStatus;
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
    data['truckTowWeightUnitCode'] = this.truckTowWeightUnitCode;
    data['synchronousId'] = this.synchronousId;
    data['regTonnageUnitCode'] = this.regTonnageUnitCode;
    data['updateTime'] = this.updateTime;
    data['updateUserCode'] = this.updateUserCode;
    data['deleted'] = this.deleted;
    data['ownerOrgCode'] = this.ownerOrgCode;
    data['regTonnage'] = this.regTonnage;
    data['createTime'] = this.createTime;
    data['truckLicenseType'] = this.truckLicenseType;
    data['truckModelName'] = this.truckModelName;
    data['creatorUsername'] = this.creatorUsername;
    data['updateUsername'] = this.updateUsername;
    data['truckTotalWeightUnitCode'] = this.truckTotalWeightUnitCode;
    data['truckLength'] = this.truckLength;
    data['truckLicenseNo'] = this.truckLicenseNo;
    data['isTrailer'] = this.isTrailer;
    return data;
  }
}
