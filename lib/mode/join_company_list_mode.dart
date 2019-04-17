class JoinCompanyListMode {
  num code;
  List<CompanyListContent> content;
  int total;

  JoinCompanyListMode({this.code, this.content, this.total});

  JoinCompanyListMode.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['content'] != null) {
      content = new List<CompanyListContent>();
      json['content'].forEach((v) {
        content.add(new CompanyListContent.fromJson(v));
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

class CompanyListContent {
  String orgStatus;
  num orgType;
  String orgName;
  String code;
  String certStatus;
  String createTime;
  String creatorUsername;
  String updateUsername;
  String orgFullName;
  String updateTime;

  CompanyListContent(
      {this.orgStatus,
      this.orgType,
      this.orgName,
      this.code,
      this.certStatus,
      this.createTime,
      this.creatorUsername,
      this.updateUsername,
      this.orgFullName,
      this.updateTime});

  CompanyListContent.fromJson(Map<String, dynamic> json) {
    orgStatus = json['orgStatus'];
    orgType = json['orgType'];
    orgName = json['orgName'];
    code = json['code'];
    certStatus = json['certStatus'];
    createTime = json['createTime'];
    creatorUsername = json['creatorUsername'];
    updateUsername = json['updateUsername'];
    orgFullName = json['orgFullName'];
    updateTime = json['updateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orgStatus'] = this.orgStatus;
    data['orgType'] = this.orgType;
    data['orgName'] = this.orgName;
    data['code'] = this.code;
    data['certStatus'] = this.certStatus;
    data['createTime'] = this.createTime;
    data['creatorUsername'] = this.creatorUsername;
    data['updateUsername'] = this.updateUsername;
    data['orgFullName'] = this.orgFullName;
    data['updateTime'] = this.updateTime;
    return data;
  }
}
