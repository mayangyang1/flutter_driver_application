class SelfInfoMode {
  num code;
  Content content;

  SelfInfoMode({this.code, this.content});

  SelfInfoMode.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    content =
        json['content'] != null ? new Content.fromJson(json['content']) : null;
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

class Content {
  String driverLicenseNo;
  String code;
  String userStatus;
  String certStatus;
  String gender;
  String qualificationCertificateResourceCode;
  String description;
  String userCode;
  String ownerOrgName;
  String identityNumber;
  bool disabled;
  String identityResourceCode;
  String moduleCode;
  String creatorUserCode;
  String driverLicenseResourceCode;
  String ip;
  String ownerUserCode;
  String driverLicenseAcceptType;
  String synchronousId;
  bool rootFlag;
  String fullName;
  String updateTime;
  String qualificationCertificateNumber;
  String updateUserCode;
  bool deleted;
  String ownerOrgCode;
  String phone;
  String createTime;
  String creatorUsername;
  String updateUsername;
  num userType;

  Content(
      {this.driverLicenseNo,
      this.code,
      this.userStatus,
      this.certStatus,
      this.gender,
      this.qualificationCertificateResourceCode,
      this.description,
      this.userCode,
      this.ownerOrgName,
      this.identityNumber,
      this.disabled,
      this.identityResourceCode,
      this.moduleCode,
      this.creatorUserCode,
      this.driverLicenseResourceCode,
      this.ip,
      this.ownerUserCode,
      this.driverLicenseAcceptType,
      this.synchronousId,
      this.rootFlag,
      this.fullName,
      this.updateTime,
      this.qualificationCertificateNumber,
      this.updateUserCode,
      this.deleted,
      this.ownerOrgCode,
      this.phone,
      this.createTime,
      this.creatorUsername,
      this.updateUsername,
      this.userType});

  Content.fromJson(Map<String, dynamic> json) {
    driverLicenseNo = json['driverLicenseNo'];
    code = json['code'];
    userStatus = json['userStatus'];
    certStatus = json['certStatus'];
    gender = json['gender'];
    qualificationCertificateResourceCode =
        json['qualificationCertificateResourceCode'];
    description = json['description'];
    userCode = json['userCode'];
    ownerOrgName = json['ownerOrgName'];
    identityNumber = json['identityNumber'];
    disabled = json['disabled'];
    identityResourceCode = json['identityResourceCode'];
    moduleCode = json['moduleCode'];
    creatorUserCode = json['creatorUserCode'];
    driverLicenseResourceCode = json['driverLicenseResourceCode'];
    ip = json['ip'];
    ownerUserCode = json['ownerUserCode'];
    driverLicenseAcceptType = json['driverLicenseAcceptType'];
    synchronousId = json['synchronousId'];
    rootFlag = json['rootFlag'];
    fullName = json['fullName'];
    updateTime = json['updateTime'];
    qualificationCertificateNumber = json['qualificationCertificateNumber'];
    updateUserCode = json['updateUserCode'];
    deleted = json['deleted'];
    ownerOrgCode = json['ownerOrgCode'];
    phone = json['phone'];
    createTime = json['createTime'];
    creatorUsername = json['creatorUsername'];
    updateUsername = json['updateUsername'];
    userType = json['userType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['driverLicenseNo'] = this.driverLicenseNo;
    data['code'] = this.code;
    data['userStatus'] = this.userStatus;
    data['certStatus'] = this.certStatus;
    data['gender'] = this.gender;
    data['qualificationCertificateResourceCode'] =
        this.qualificationCertificateResourceCode;
    data['description'] = this.description;
    data['userCode'] = this.userCode;
    data['ownerOrgName'] = this.ownerOrgName;
    data['identityNumber'] = this.identityNumber;
    data['disabled'] = this.disabled;
    data['identityResourceCode'] = this.identityResourceCode;
    data['moduleCode'] = this.moduleCode;
    data['creatorUserCode'] = this.creatorUserCode;
    data['driverLicenseResourceCode'] = this.driverLicenseResourceCode;
    data['ip'] = this.ip;
    data['ownerUserCode'] = this.ownerUserCode;
    data['driverLicenseAcceptType'] = this.driverLicenseAcceptType;
    data['synchronousId'] = this.synchronousId;
    data['rootFlag'] = this.rootFlag;
    data['fullName'] = this.fullName;
    data['updateTime'] = this.updateTime;
    data['qualificationCertificateNumber'] =
        this.qualificationCertificateNumber;
    data['updateUserCode'] = this.updateUserCode;
    data['deleted'] = this.deleted;
    data['ownerOrgCode'] = this.ownerOrgCode;
    data['phone'] = this.phone;
    data['createTime'] = this.createTime;
    data['creatorUsername'] = this.creatorUsername;
    data['updateUsername'] = this.updateUsername;
    data['userType'] = this.userType;
    return data;
  }
}
