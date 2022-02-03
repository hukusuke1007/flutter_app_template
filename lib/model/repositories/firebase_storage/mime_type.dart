enum MimeType { applicationOctetStream }

extension MimeTypeExtensio on MimeType {
  String? get value {
    if (this == MimeType.applicationOctetStream) {
      return 'application/octet-stream';
    }
    throw AssertionError();
  }
}
