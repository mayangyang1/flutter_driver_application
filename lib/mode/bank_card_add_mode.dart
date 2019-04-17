class BankCardAddMode {
  num code;
  BankCardAddContent content;

  BankCardAddMode({this.code, this.content});

  BankCardAddMode.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    content =
        json['content'] != null ? new BankCardAddContent.fromJson(json['content']) : null;
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

class BankCardAddContent {
  String bankAccountName;
  String bankAccountNo;
  String description;
  String bankName;

  BankCardAddContent(
      {this.bankAccountName,
      this.bankAccountNo,
      this.description,
      this.bankName});

  BankCardAddContent.fromJson(Map<String, dynamic> json) {
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
