
import 'dart:convert';

FeedListModel feedListModelFromJson(String str) => FeedListModel.fromJson(json.decode(str));

String feedListModelToJson(FeedListModel data) => json.encode(data.toJson());

class FeedListModel {
  String feedId;
  String userId;
  BirthdayPosts birthdayPosts;

  FeedListModel({
    required this.feedId,
    required this.userId,
    required this.birthdayPosts,
  });

  factory FeedListModel.fromJson(Map<String, dynamic> json) => FeedListModel(
    feedId: json["feedId"],
    userId: json["userId"],
    birthdayPosts: BirthdayPosts.fromJson(json["birthdayPosts"]),
  );

  Map<String, dynamic> toJson() => {
    "feedId": feedId,
    "userId": userId,
    "birthdayPosts": birthdayPosts.toJson(),
  };
}

class BirthdayPosts {
  List<Result> results;
  int totalElements;
  int totalPages;
  int currentPage;
  int currentPageSize;

  BirthdayPosts({
    required this.results,
    required this.totalElements,
    required this.totalPages,
    required this.currentPage,
    required this.currentPageSize,
  });

  factory BirthdayPosts.fromJson(Map<String, dynamic> json) => BirthdayPosts(
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    totalElements: json["totalElements"],
    totalPages: json["totalPages"],
    currentPage: json["currentPage"],
    currentPageSize: json["currentPageSize"],
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
  String? birthdayUserId;
  UserInfo? birthdayUserInfo;
  List<Wish> wishes;
  dynamic wishedUsers;
  int lastWished;
  int totalWishCount;
  bool adminPosted;
  dynamic connectionStatus;
  UserInfo userInfo;
  dynamic prevBirthdayPost;
  dynamic nextBirthdayPost;

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
    createdBy: json["createdBy"],
    modifiedBy: json["modifiedBy"],
    createdAt: json["createdAt"],
    modifiedAt: json["modifiedAt"],
    id: json["id"],
    caption: json["caption"],
    birthdayUserId: json["birthdayUserId"],
    birthdayUserInfo: json["birthdayUserInfo"] == null ? null : UserInfo.fromJson(json["birthdayUserInfo"]),
    wishes: List<Wish>.from(json["wishes"].map((x) => Wish.fromJson(x))),
    wishedUsers: json["wishedUsers"],
    lastWished: json["lastWished"],
    totalWishCount: json["totalWishCount"],
    adminPosted: json["adminPosted"],
    connectionStatus: json["connectionStatus"],
    userInfo: UserInfo.fromJson(json["userInfo"]),
    prevBirthdayPost: json["prevBirthdayPost"],
    nextBirthdayPost: json["nextBirthdayPost"],
  );

  Map<String, dynamic> toJson() => {
    "createdBy": createdBy,
    "modifiedBy": modifiedBy,
    "createdAt": createdAt,
    "modifiedAt": modifiedAt,
    "id": id,
    "caption": caption,
    "birthdayUserId": birthdayUserId,
    "birthdayUserInfo": birthdayUserInfo?.toJson(),
    "wishes": List<dynamic>.from(wishes.map((x) => x.toJson())),
    "wishedUsers": wishedUsers,
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
  FirstName firstName;
  LastName lastName;
  String mobileNumber;
  String imageUrl;
  dynamic contactName;
  UserType userType;
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
    id: json["id"],
    firstName: firstNameValues.map[json["firstName"]]!,
    lastName: lastNameValues.map[json["lastName"]]!,
    mobileNumber: json["mobileNumber"],
    imageUrl: json["imageUrl"],
    contactName: json["contactName"],
    userType: userTypeValues.map[json["userType"]]!,
    connectionStatus: json["connectionStatus"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "firstName": firstNameValues.reverse[firstName],
    "lastName": lastNameValues.reverse[lastName],
    "mobileNumber": mobileNumber,
    "imageUrl": imageUrl,
    "contactName": contactName,
    "userType": userTypeValues.reverse[userType],
    "connectionStatus": connectionStatus,
  };
}

enum FirstName {
  AKASH,
  PRIYA
}

final firstNameValues = EnumValues({
  "Akash": FirstName.AKASH,
  "Priya": FirstName.PRIYA
});

enum LastName {
  SAI_RAJAGOPAL,
  T
}

final lastNameValues = EnumValues({
  "Sai Rajagopal": LastName.SAI_RAJAGOPAL,
  "T": LastName.T
});

enum UserType {
  ADMIN,
  APP_USER
}

final userTypeValues = EnumValues({
  "ADMIN": UserType.ADMIN,
  "APP_USER": UserType.APP_USER
});

class Wish {
  String createdBy;
  String modifiedBy;
  int createdAt;
  int modifiedAt;
  String id;
  String postId;
  String text;
  String imageUrl;
  dynamic connectionStatus;
  dynamic emojiCount;
  dynamic userInfo;
  dynamic birthdayPostUserId;
  String birthdayCardId;
  dynamic emojiStatus;
  dynamic totalEmojiCount;
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
    createdBy: json["createdBy"],
    modifiedBy: json["modifiedBy"],
    createdAt: json["createdAt"],
    modifiedAt: json["modifiedAt"],
    id: json["id"],
    postId: json["postId"],
    text: json["text"],
    imageUrl: json["imageUrl"],
    connectionStatus: json["connectionStatus"],
    emojiCount: json["emojiCount"],
    userInfo: json["userInfo"],
    birthdayPostUserId: json["birthdayPostUserId"],
    birthdayCardId: json["birthdayCardId"],
    emojiStatus: json["emojiStatus"],
    totalEmojiCount: json["totalEmojiCount"],
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
    "emojiCount": emojiCount,
    "userInfo": userInfo,
    "birthdayPostUserId": birthdayPostUserId,
    "birthdayCardId": birthdayCardId,
    "emojiStatus": emojiStatus,
    "totalEmojiCount": totalEmojiCount,
    "prevWish": prevWish,
    "nextWish": nextWish,
    "prevWishId": prevWishId,
    "nextWishId": nextWishId,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
