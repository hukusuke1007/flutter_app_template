enum MenuResultType {
  share,
  copy,
  issueReport;

  String get label {
    if (this == MenuResultType.share) {
      return 'シェアする';
    } else if (this == MenuResultType.copy) {
      return 'コピー';
    } else if (this == MenuResultType.issueReport) {
      return '通報する';
    }
    return '';
  }
}
