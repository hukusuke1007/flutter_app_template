enum MenuResultType {
  share('シェアする'),
  copy('コピー'),
  issueReport('通報する'),
  mute('ミュート'),
  block('ブロック'),
  ;

  const MenuResultType(this.label);
  final String label;
}
