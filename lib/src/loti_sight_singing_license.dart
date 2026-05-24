/// 商业授权版本枚举（与 [docs/PRICING.md] 一致）。
enum LotiSightSingingEdition {
  /// 测试版 · ¥9.9
  trial,

  /// 年度授权 · ¥7,999 / 年
  annual,

  /// 源码交付 · 可编程版 · ¥19,998
  sourceCode,
}

extension LotiSightSingingEditionX on LotiSightSingingEdition {
  String get displayName => switch (this) {
        LotiSightSingingEdition.trial => '测试版',
        LotiSightSingingEdition.annual => '年度授权版',
        LotiSightSingingEdition.sourceCode => '源码交付 · 可编程版',
      };

  String get priceLabel => switch (this) {
        LotiSightSingingEdition.trial => '¥9.9',
        LotiSightSingingEdition.annual => '¥7,999 / 年',
        LotiSightSingingEdition.sourceCode => '¥19,998',
      };
}
