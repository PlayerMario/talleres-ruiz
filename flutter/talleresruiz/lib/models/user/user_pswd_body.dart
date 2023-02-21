class UserEditarPswdBody {
  String? oldPassword;
  String? newPassword;
  String? verifyNewPassword;

  UserEditarPswdBody(
      {this.oldPassword, this.newPassword, this.verifyNewPassword});

  UserEditarPswdBody.fromJson(Map<String, dynamic> json) {
    oldPassword = json['oldPassword'];
    newPassword = json['newPassword'];
    verifyNewPassword = json['verifyNewPassword'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['oldPassword'] = this.oldPassword;
    data['newPassword'] = this.newPassword;
    data['verifyNewPassword'] = this.verifyNewPassword;
    return data;
  }
}
