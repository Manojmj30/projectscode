import 'dart:convert';

FeedDetailmodel feedDetailmodelFromJson(String str) => FeedDetailmodel.fromJson(json.decode(str));

String feedDetailmodelToJson(FeedDetailmodel data) => json.encode(data.toJson());

class FeedDetailmodel {
  List<Result> results;
  int totalElements;
  int totalPages;
  int currentPage;
  int currentPageSize;

  FeedDetailmodel({
    required this.results,
    required this.totalElements,
    required this.totalPages,
    required this.currentPage,
    required this.currentPageSize,
  });

  factory FeedDetailmodel.fromJson(Map<String, dynamic> json) => FeedDetailmodel(
    results: List<Result>.from((json["results"] ?? []).map((x) => Result.fromJson(x))),
    totalElements: json["totalElements"] ?? 0,
    totalPages: json["totalPages"] ?? 0,
    currentPage: json["currentPage"] ?? 0,
    currentPageSize: json["currentPageSize"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
    "totalElements": totalElements,
    "totalPages": totalPages,
    "currentPage": currentPage,
    "currentPageSize": currentPageSize,
  };
}

class Result {
  String createdBy;
  String modifiedBy;
  int createdAt;
  int modifiedAt;
  String id;
  String caption;
  dynamic birthdayUserId;
  dynamic birthdayUserInfo;
  List<Wish> wishes;
  List<dynamic> wishedUsers;
  int lastWished;
  int totalWishCount;
  bool adminPosted;
  String connectionStatus;
  UserInfo userInfo;
  String prevBirthdayPost;
  String nextBirthdayPost;

  Result({
    required this.createdBy,
    required this.modifiedBy,
    required this.createdAt,
    required this.modifiedAt,
    required this.id,
    required this.caption,
    required this.birthdayUserId,
    required this.birthdayUserInfo,
    required this.wishes,
    required this.wishedUsers,
    required this.lastWished,
    required this.totalWishCount,
    required this.adminPosted,
    required this.connectionStatus,
    required this.userInfo,
    required this.prevBirthdayPost,
    required this.nextBirthdayPost,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    createdBy: json["createdBy"] ?? '',
    modifiedBy: json["modifiedBy"] ?? '',
    createdAt: json["createdAt"] ?? 0,
    modifiedAt: json["modifiedAt"] ?? 0,
    id: json["id"] ?? '',
    caption: json["caption"] ?? '',
    birthdayUserId: json["birthdayUserId"],
    birthdayUserInfo: json["birthdayUserInfo"],
    wishes: List<Wish>.from((json["wishes"] ?? []).map((x) => Wish.fromJson(x))),
    wishedUsers: List<dynamic>.from((json["wishedUsers"] ?? []).map((x) => x)),
    lastWished: json["lastWished"] ?? 0,
    totalWishCount: json["totalWishCount"] ?? 0,
    adminPosted: json["adminPosted"] ?? false,
    connectionStatus: json["connectionStatus"] ?? '',
    userInfo: UserInfo.fromJson(json["userInfo"] ?? {}),
    prevBirthdayPost: json["prevBirthdayPost"] ?? '',
    nextBirthdayPost: json["nextBirthdayPost"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "createdBy": createdBy,
    "modifiedBy": modifiedBy,
    "createdAt": createdAt,
    "modifiedAt": modifiedAt,
    "id": id,
    "caption": caption,
    "birthdayUserId": birthdayUserId,
    "birthdayUserInfo": birthdayUserInfo,
    "wishes": List<dynamic>.from(wishes.map((x) => x.toJson())),
    "wishedUsers": List<dynamic>.from(wishedUsers.map((x) => x)),
    "lastWished": lastWished,
    "totalWishCount": totalWishCount,
    "adminPosted": adminPosted,
    "connectionStatus": connectionStatus,
    "userInfo": userInfo.toJson(),
    "prevBirthdayPost": prevBirthdayPost,
    "nextBirthdayPost": nextBirthdayPost,
  };
}

class UserInfo {
  String id;
  String firstName;
  String lastName;
  String mobileNumber;
  String imageUrl;
  dynamic contactName;
  String userType;
  dynamic connectionStatus;

  UserInfo({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.mobileNumber,
    required this.imageUrl,
    required this.contactName,
    required this.userType,
    required this.connectionStatus,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
    id: json["id"] ?? '',
    firstName: json["firstName"] ?? '',
    lastName: json["lastName"] ?? '',
    mobileNumber: json["mobileNumber"] ?? '',
    imageUrl: json["imageUrl"] ?? '',
    contactName: json["contactName"],
    userType: json["userType"] ?? '',
    connectionStatus: json["connectionStatus"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "firstName": firstName,
    "lastName": lastName,
    "mobileNumber": mobileNumber,
    "imageUrl": imageUrl,
    "contactName": contactName,
    "userType": userType,
    "connectionStatus": connectionStatus,
  };
}

class Wish {
  String createdBy;
  String modifiedBy;
  int createdAt;
  int modifiedAt;
  String id;
  String postId;
  String text;
  String imageUrl;
  String connectionStatus;
  List<dynamic> emojiCount;
  UserInfo userInfo;
  dynamic birthdayPostUserId;
  String birthdayCardId;
  EmojiStatus emojiStatus;
  int totalEmojiCount;
  dynamic prevWish;
  dynamic nextWish;
  dynamic prevWishId;
  dynamic nextWishId;

  Wish({
    required this.createdBy,
    required this.modifiedBy,
    required this.createdAt,
    required this.modifiedAt,
    required this.id,
    required this.postId,
    required this.text,
    required this.imageUrl,
    required this.connectionStatus,
    required this.emojiCount,
    required this.userInfo,
    required this.birthdayPostUserId,
    required this.birthdayCardId,
    required this.emojiStatus,
    required this.totalEmojiCount,
    required this.prevWish,
    required this.nextWish,
    required this.prevWishId,
    required this.nextWishId,
  });

  factory Wish.fromJson(Map<String, dynamic> json) => Wish(
    createdBy: json["createdBy"] ?? '',
    modifiedBy: json["modifiedBy"] ?? '',
    createdAt: json["createdAt"] ?? 0,
    modifiedAt: json["modifiedAt"] ?? 0,
    id: json["id"] ?? '',
    postId: json["postId"] ?? '',
    text: json["text"] ?? '',
    imageUrl: json["imageUrl"] ?? '',
    connectionStatus: json["connectionStatus"] ?? '',
    emojiCount: List<dynamic>.from((json["emojiCount"] ?? []).map((x) => x)),
    userInfo: UserInfo.fromJson(json["userInfo"] ?? {}),
    birthdayPostUserId: json["birthdayPostUserId"],
    birthdayCardId: json["birthdayCardId"] ?? '',
    emojiStatus: EmojiStatus.fromJson(json["emojiStatus"] ?? {}),
    totalEmojiCount: json["totalEmojiCount"] ?? 0,
    prevWish: json["prevWish"],
    nextWish: json["nextWish"],
    prevWishId: json["prevWishId"],
    nextWishId: json["nextWishId"],
  );

  Map<String, dynamic> toJson() => {
    "createdBy": createdBy,
    "modifiedBy": modifiedBy,
    "createdAt": createdAt,
    "modifiedAt": modifiedAt,
    "id": id,
    "postId": postId,
    "text": text,
    "imageUrl": imageUrl,
    "connectionStatus": connectionStatus,
    "emojiCount": List<dynamic>.from(emojiCount.map((x) => x)),
    "userInfo": userInfo.toJson(),
    "birthdayPostUserId": birthdayPostUserId,
    "birthdayCardId": birthdayCardId,
    "emojiStatus": emojiStatus.toJson(),
    "totalEmojiCount": totalEmojiCount,
    "prevWish": prevWish,
    "nextWish": nextWish,
    "prevWishId": prevWishId,
    "nextWishId": nextWishId,
  };
}

class EmojiStatus {
  bool status;
  dynamic code;

  EmojiStatus({
    required this.status,
    required this.code,
  });

  factory EmojiStatus.fromJson(Map<String, dynamic> json) => EmojiStatus(
    status: json["status"] ?? false,
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
  };
}
