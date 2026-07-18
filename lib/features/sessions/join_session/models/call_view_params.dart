class CallViewParams {
  const CallViewParams({
    required this.callID,
    required this.userId,
    required this.userName,
  });

  final String callID;
  final String userId;
  final String userName;

  factory CallViewParams.fromMap(Map<String, dynamic> map) {
    return CallViewParams(
      callID: map['callID'] as String,
      userId: map['userId'] as String,
      userName: map['userName'] as String,
    );
  }

  Map<String, String> toMap() {
    return {
      'callID': callID,
      'userId': userId,
      'userName': userName,
    };
  }
}
