part of 'models.dart';

class UserData {
  String? userId;
  String? nickName;
  String? name;
  String? email;
  String? password;
  String? state;
  String? city;
  String? photoUrl;
  String? authType; // 0 = Email/Password, 1 = Google, 2 = Apple, 3 = Facebook
  bool? isEnable;
  BankDetails? bankDetails;
  String? paypalId;
  String? deviceToken;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool? notification_approved;
  bool? notification_payout;
  bool? notification_newJobPost;

  UserData({
    this.userId,
    this.nickName,
    this.name,
    this.email,
    this.password,
    this.state,
    this.city,
    this.photoUrl,
    this.authType,
    this.isEnable,
    this.bankDetails,
    this.paypalId,
    this.deviceToken,
    this.createdAt,
    this.updatedAt,
    this.notification_approved,
    this.notification_newJobPost,
    this.notification_payout
  });

  factory UserData.fromMap(Map<String, dynamic> data) {
    return UserData(
      userId: data['userId'],
      nickName: data['nickName'],
      name: data['name'],
      email: data['email'],
      password: data['password'],
      state: data['state'],
      city: data['city'],
      photoUrl: data['photoUrl'],
      authType: data['authType'],
      isEnable: data['isEnable'],
      paypalId: data['paypalId'],
      deviceToken: data['deviceToken'],
      notification_payout: data['notification_payout'],
      notification_newJobPost: data['notification_newJobPost'],
      notification_approved: data['notification_approved'],
      bankDetails: data['bankDetails'] != null
          ? BankDetails.fromMap(data['bankDetails'])
          : null,
      createdAt:
          DateTime.fromMillisecondsSinceEpoch(int.parse(data['createdAt'])),
      updatedAt:
          DateTime.fromMillisecondsSinceEpoch(int.parse(data['updatedAt'])),
    );
  }

  bool get hasData => userId != null;

  factory UserData.empty() {
    return UserData(
      userId: null,
      nickName: null,
      name: null,
      email: null,
      password: null,
      state: null,
      city: null,
      photoUrl: null,
      authType: null,
      isEnable: null,
      bankDetails: null,
      paypalId: null,
      createdAt: null,
      updatedAt: null,
      deviceToken: null,
      notification_approved: true,
      notification_newJobPost: true,
      notification_payout: true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'nickName': nickName,
      'name': name,
      'email': email,
      'password': password,
      'state': state,
      'city': city,
      'photoUrl': photoUrl,
      'authType': authType,
      'isEnable': isEnable,
      'paypalId': paypalId,
      'deviceToken': deviceToken,
      'bankDetails': bankDetails?.toMap(),
      'createdAt': createdAt?.millisecondsSinceEpoch.toString(),
      'updatedAt': updatedAt?.millisecondsSinceEpoch.toString(),
      'notification_approved' : notification_approved,
      'notification_newJobPost': notification_newJobPost,
      'notification_payout' : notification_payout
    };
  }
}

class BankDetails {
  String? accountNumber;
  String? ifscCode;
  String? bankName;
  String? branchName;
  String? accountHolderName;

  BankDetails({
    this.accountNumber,
    this.ifscCode,
    this.bankName,
    this.branchName,
    this.accountHolderName,
  });

  factory BankDetails.fromMap(Map<String, dynamic> data) {
    return BankDetails(
      accountNumber: data['accountNumber'],
      ifscCode: data['ifscCode'],
      bankName: data['bankName'],
      branchName: data['branchName'],
      accountHolderName: data['accountHolderName'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'accountNumber': accountNumber,
      'ifscCode': ifscCode,
      'bankName': bankName,
      'branchName': branchName,
      'accountHolderName': accountHolderName,
    };
  }
}
