class SearchJoinCampanyList {
  num code;
  List<SearchListContent> content;
  int total;

  SearchJoinCampanyList({this.code, this.content, this.total});

  SearchJoinCampanyList.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['content'] != null) {
      content = new List<SearchListContent>();
      json['content'].forEach((v) {
        content.add(new SearchListContent.fromJson(v));
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

class SearchListContent {
  String orgName;
  String code;
  String certStatus;
  String linkmanFullName;
  String city;
  String transportCertificate;
  String county;
  String orgFullName;
  String updateTime;
  String orgStatus;
  int orgType;
  bool isChoice;
  String province;
  String createTime;
  String creatorUsername;
  String updateUsername;
  String linkmanPhone;

  SearchListContent(
      {this.orgName,
      this.code,
      this.certStatus,
      this.linkmanFullName,
      this.city,
      this.transportCertificate,
      this.county,
      this.orgFullName,
      this.updateTime,
      this.orgStatus,
      this.orgType,
      this.province,
      this.isChoice,
      this.createTime,
      this.creatorUsername,
      this.updateUsername,
      this.linkmanPhone});

  SearchListContent.fromJson(Map<String, dynamic> json) {
    orgName = json['orgName'];
    code = json['code'];
    certStatus = json['certStatus'];
    linkmanFullName = json['linkmanFullName'];
    city = json['city'];
    transportCertificate = json['transportCertificate'];
    county = json['county'];
    orgFullName = json['orgFullName'];
    updateTime = json['updateTime'];
    orgStatus = json['orgStatus'];
    orgType = json['orgType'];
    province = json['province'];
    isChoice = false;
    createTime = json['createTime'];
    creatorUsername = json['creatorUsername'];
    updateUsername = json['updateUsername'];
    linkmanPhone = json['linkmanPhone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orgName'] = this.orgName;
    data['code'] = this.code;
    data['certStatus'] = this.certStatus;
    data['linkmanFullName'] = this.linkmanFullName;
    data['city'] = this.city;
    data['transportCertificate'] = this.transportCertificate;
    data['county'] = this.county;
    data['orgFullName'] = this.orgFullName;
    data['updateTime'] = this.updateTime;
    data['orgStatus'] = this.orgStatus;
    data['orgType'] = this.orgType;
    data['province'] = this.province;
    data['isChoice'] = false;
    data['createTime'] = this.createTime;
    data['creatorUsername'] = this.creatorUsername;
    data['updateUsername'] = this.updateUsername;
    data['linkmanPhone'] = this.linkmanPhone;
    return data;
  }
}
