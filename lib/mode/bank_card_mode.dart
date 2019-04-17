class BankCardMode {
  num code;
  BankCardContent content;

  BankCardMode({this.code, this.content});

  BankCardMode.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    content =
        json['content'] != null ? new BankCardContent.fromJson(json['content']) : null;
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

class BankCardContent {
  String bankAccountName;
  String bankAccountNo;
  String description;
  String bankName;

  BankCardContent(
      {this.bankAccountName,
      this.bankAccountNo,
      this.description,
      this.bankName});

  BankCardContent.fromJson(Map<String, dynamic> json) {
    bankAccountName = json['bankAccountName'];
    bankAccountNo = json['bankAccountNo'];
    description = json['description'];
    bankName = json['bankName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bankAccountName'] = this.bankAccountName;
    data['bankAccountNo'] = this.bankAccountNo;
    data['description'] = this.description;
    data['bankName'] = this.bankName;
    return data;
  }
}
