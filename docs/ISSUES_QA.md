# Loti 视唱插件 · 社区问答（Issue 精选）

> 本页模拟 GitHub Issues 中的用户提问与官方回复。  
> **Loti 不设标准客服**；购买、交付、技术、售后 **均在 [GitHub Issues](https://github.com/loti-flutter/loti-flutter-sight-singing-plugin/issues) 以留言方式处理**。  
> 官方回复 **非实时**，通常于 **半个工作日至下一工作日** 在本帖跟评，请耐心等待。

---

## Issue #12 · 购买咨询

`purchase` `licensing` · 打开于 **2025-02-06 09:14** · [@hz-yinyue-dev](https://github.com/hz-yinyue-dev)

**标题：** `[购买咨询] 年度授权版是否支持多校区部署？`

---

**提问：**

您好，我们是杭州某连锁声乐培训机构，自有 Flutter App（iOS + Android），计划接入视唱作业模块。

想确认几点：

1. **¥7,999 / 年** 的年度授权版，授权范围是「单一 App 包名」还是「同一机构多个校区共用」？
2. 测试版 ¥9.9 里的占位 SDK，能否验证麦克风权限与页面跳转？还是只能看示例 UI？
3. 正式版 MIDI 打分是否支持我们自备曲库（`.mid`）批量导入？

付款后交付周期是否仍为 1–3 个工作日？我们 **春季班 4 月开课** 前希望完成试点。

---

**Loti 官方回复** · **2025-02-07 15:40**

感谢关注 Loti 视唱插件，以下逐条说明：

**1. 授权范围**  
年度授权版默认按 **「单一法人主体 + 单一 App 产品线」** 授权（具体以软件授权合同为准）。连锁机构多校区若共用同一 App、同一 Bundle ID，通常无需按校区重复购买；若存在 **白标 App、不同包名、独立 OEM 交付** 等场景，请在本 Issue 补充说明，我们会给出扩展授权方案。

**2. 测试版能力边界**  
测试版主要用于验证 **Flutter 工程依赖接入、插件生命周期、示例页导航**。当前公开仓库为预览占位，**不含**完整 MIDI 解析与实时音高打分。麦克风相关能力在 **正式 SDK** 中提供，测试版文档会说明权限清单与集成检查项。

**3. 自备曲库**  
正式版规划支持 `MidiSource.file` / `MidiSource.url` / 内置资源等多种来源，详见 [USAGE.md — §5 MIDI 与曲谱参数](USAGE.md#5-midi-与曲谱参数)。批量导入建议在业务层做「曲目管理后台 + CDN / 本地缓存」，插件侧重 **单首曲目的解析、跟唱与结算**。

**4. 交付周期**  
付款凭证在本 Issue 确认后 **1–3 个工作日** 安排对应版本交付；年度授权版售后同样通过 **GitHub Issue 留言** 处理，请在帖内等待官方跟评。

如需合同与发票，请在本 Issue 补充说明，我们会通过 **Issue 回复** 跟进。

---

## Issue #18 · 集成接入

`integration` `flutter` · 打开于 **2025-04-15 11:02** · [@chen_flutter](https://github.com/chen_flutter)

**标题：** `现有 Flutter App 如何嵌入视唱页？是否需要独立 Engine？`

---

**提问：**

我们已有一个成熟的 Flutter 教育 App（GetX 路由 + 自定义 Theme），希望新增「视唱作业」Tab，而不是单独做一个 App。

请问：

- 推荐使用全页 Widget（`LotiSightSingingPage`）还是 Headless API 自己画 UI？
- 跟现有 `ThemeData` 能否统一？机构品牌色是 `#2D5A3D`
- 从列表页 push 到视唱页，返回时音频资源会不会泄漏？

附：我们最低支持 Android 8.0、iOS 13。

---

**Loti 官方回复** · **2025-04-16 10:18**

**嵌入方式建议：**

| 场景 | 推荐方案 |
|------|----------|
| 快速上线、标准 KTV 音符条 | `LotiSightSingingPage` 全页嵌入 |
| 强品牌定制、与现有乐理页视觉统一 | Headless API + 自绘 `LotiNoteBarWidget` |
| 仅需练声/音高仪 | `LotiPitchMeterWidget` |

**主题：**  
年度授权版支持 `NoteBarTheme` 覆盖音符条颜色、字体与小节线样式；源码交付版可改 Widget 树。品牌色 `#2D5A3D` 可在初始化时传入 `NoteBarTheme(primaryColor: Color(0xFF2D5A3D))`，与宿主 `ThemeData` 并行不冲突。

**生命周期：**  
视唱页 `dispose` 时会释放 AudioSession 与 native 采集器。建议在路由 `pop` 前调用 `stopSession()`，避免 Android 上偶发音频焦点未归还。完整示例见 [USAGE.md — §9 KTV 音符条 UI](USAGE.md#9-ktv-音符条-ui-参数)。

**平台：** Android 8.0+、iOS 13+ 与插件最低要求一致。

---

## Issue #24 · 教培场景

`classroom` `ipad` · 打开于 **2025-06-22 16:33** · [@music_teacher_li](https://github.com/music_teacher_li)

**标题：** `iPad 教室 30 人同时练习，外放串音导致全员 Miss，有没有标准配置？`

---

**提问：**

我是某中学音乐教师，学校用 iPad 上视唱课。学生如果开外放跟标准音，旁边同学的麦克风会收进去，系统判错特别离谱。

看到 README 提到「无声跟唱」，请问：

1. 能否 **默认禁止扬声器播放标准旋律**，只显示音符条？
2. 能否 **强制耳机**？没有耳机不允许开始？
3. 打分能不能 **只计音准、不计节奏**？我们这边更重视音程与调性。

---

**Loti 官方回复** · **2025-06-24 09:05**

这是教培场景中最典型的问题，Loti 默认策略即面向教室环境优化。

**1. 无声跟唱（推荐）**

```dart
await plugin.startSession(
  mode: SessionMode.silentFollow,
);
// 配合全局配置
LotiSightSingingConfig(
  forceSilentFollowOnIPad: true,
  speakerMuteDuringCapture: true,
)
```

此模式下 **不播放标准旋律**，学生通过音符条视唱，可从根本上避免邻座串音。详见 [USAGE.md — §10.1 跟唱模式](USAGE.md#101-跟唱模式-sessionmode)。

**2. 强制耳机**  
设置 `headphoneRequired: true` 可在未检测到耳机时阻断开始。一般 **班级集体练习** 更推荐无声跟唱；**模考/个别辅导** 可配合耳机模式。

**3. 音准 / 节奏权重**  
可以。初始化 scoring 时调整：

```dart
ScoringProfile.standard.copyWith(
  intonationWeight: 1.0,
  rhythmWeight: 0.0,
)
```

若仍希望记录节奏但不计入总分，可在 `SessionReport` 中保留 `avgTimingMs` 供教师参考，业务层自行展示。

**教研建议：** 小学低年级可先用 `ScoringProfile.relaxed` + `countdownBeats: 4`，待稳定后再收紧至 `standard`。

---

## Issue #31 · MIDI 与曲谱

`midi` `music-theory` · 打开于 **2025-09-10 14:20** · [@score_lib_admin](https://github.com/score_lib_admin)

**标题：** `多轨 MIDI 如何指定旋律声部？含伴奏轨的考级曲会自动选错轨吗？`

---

**提问：**

我们的 MIDI 库来自考级机构，常见结构：

- Track 1：钢琴伴奏  
- Track 2：主旋律  
- Track 3：节奏参考（有时）

用户上传后，插件会不会默认选 Track 1？  
另外，部分曲谱是 **G 大调**，能否在加载时 **移调 +2** 方便不同学段？

---

**Loti 官方回复** · **2025-09-12 11:47**

**轨选择逻辑：**  
`loadMidi` 后会返回 `List<MidiTrackSummary>`，含 `noteCount`、`pitchRange`、`isLikelyMelody` 等字段。插件 **不会静默默认 Track 0**；推荐产品流程：

1. 首次导入：展示轨摘要，教师或学生确认「视唱声部」  
2. 机构后台：为常用曲目 **绑定默认 `trackId`**，下次免选  

也可调用：

```dart
await plugin.selectMelodyTrack(
  trackId: 2,
  ignorePercussion: true,
  minNoteCount: 8,
);
```

**移调：**  
加载参数 `transposeSemitones: 2` 即整体移高全全音。注意：移调后 `concertKey` 显示应同步更新（如 G major → A major），避免唱名与调号不一致。

**附：** 若 MIDI 含歌词 Meta Event，可通过 `showLyrics: true` 在音符条下方展示；纯器乐视唱建议关闭。

---

## Issue #37 · 打分与测评

`scoring` `exam` · 打开于 **2025-11-18 10:55** · [@art_exam_lab](https://github.com/art_exam_lab)

**标题：** `艺考视唱模拟：Perfect 阈值能否收到 ±15¢？与标准音高 A4=440 可否改 442？`

---

**提问：**

我们做艺考视唱模拟考，校内评委反馈：

- 公开版文档写 Perfect ±25¢，对备考学生 **偏宽松**  
- 乐理课用 **442 Hz** 调律的录音习惯，学生觉得「标准线不准」

是否有 **examStrict** 一类预设？  
结算报告能否导出 **逐音明细**（每音偏差多少 cent、节奏 ms）供评委复核？

---

**Loti 官方回复** · **2025-11-19 16:22**

**打分预设：**  
正式版提供 `ScoringProfile.examStrict`（默认 Perfect ±15¢、节奏 ±50 ms）与 `conservatory`（±10¢ / ±40 ms）。也可在预设上微调：

```dart
LotiSightSingingConfig(
  referencePitchA4: 442.0,
  scoringProfile: ScoringProfile.examStrict,
  defaultSessionMode: SessionMode.exam,
  allowRetry: false,
)
```

**A4 参考频率：**  
`referencePitchA4` 影响音高检测与标准线换算，与教室钢琴调律一致即可。若机构同时使用 440 与 442 教材，建议 **按曲目元数据** 在 `loadMidi` 前切换，而非全局写死。

**逐音明细：**  
`OnNoteScored` 事件含 `intonationCents`、`timingMs`、`grade`；会话结束 `SessionReport` 汇总命中率与薄弱音级。年度授权版支持 JSON 导出；源码版可自行对接 LMS / 评委后台。

参数完整表见 [USAGE.md — §7 视唱打分参数](USAGE.md#7-视唱打分参数)。

---

## Issue #41 · 音高检测

`pitch-detection` `audio` · 打开于 **2026-01-08 13:41** · [@audio_eng_wang](https://github.com/audio_eng_wang)

**标题：** `Android 低端机延迟高、音高曲线抖动，有哪些参数可调？`

---

**提问：**

测试机 Redmi Note 10，Flutter 3.16，视唱时「你的音」曲线抖得厉害，Perfect 很难触发。

已开麦克风权限，`echoCancellation: true`。  
请问 `bufferSizeMs`、`smoothingFactor`、`confidenceThreshold` 应该怎么权衡？  
YIN 和 autocorrelation 哪个更适合 **童声（偏高音区）**？

---

**Loti 官方回复** · **2026-01-09 17:03**

低端 Android 建议在 **延迟** 与 **稳定性** 之间做设备分级配置：

| 参数 | 默认值 | 低端机建议 | 说明 |
|------|--------|------------|------|
| `bufferSizeMs` | 46 | 64–92 | 窗口越大，F0 估计越稳，但视觉延迟增加 |
| `smoothingFactor` | 0.35 | 0.45–0.55 | 增大可抑制抖动，过小会显得「灵敏但噪」 |
| `confidenceThreshold` | 0.65 | 0.55–0.60 | 童声弱起音时可略降，避免频繁 null |
| `sampleRateHz` | 44100 | 22050 | 换性能，需实测是否影响音分精度 |
| `maxFrequencyHz` | 1200 | 1400 | 童声高音区可略扩 |

**算法：**  
童声建议使用默认 **`PitchAlgorithm.yin`**，抗噪较好；若练习 **短促跳进**，可在单句模式试 `autocorrelation`。

**硬件：**  
仍强烈建议教室场景使用 **`SessionMode.silentFollow`**，减少扬声器—麦克风环路干扰。

---

## Issue #45 · 平台与 Web

`web` `platform` · 打开于 **2026-02-24 09:28** · [@edu_saas_team](https://github.com/edu_saas_team)

**标题：** `Web 端能否用于视唱作业？Chrome 笔记本麦克风权限弹窗后仍无音高`

---

**提问：**

我们 SaaS 平台有 Flutter Web 版本，学生用 Chromebook 上课。

- Web 是否支持实时视唱打分？  
- MIDI 从 OSS 地址加载，是否有 CORS 限制？  
- 与原生 App 打分结果能否对齐？

---

**Loti 官方回复** · **2026-02-25 14:50**

**Web 能力边界（规划）：**  
Web 端可支持 **MIDI 展示、音符条跟唱、基础音高检测**，但受浏览器音频策略影响：

- 必须在 **HTTPS** 下请求麦克风  
- 延迟通常 **高于 iOS/Android 原生**  
- 建议 Web 标注为 **「练习模式」**，正式测评仍用 App

**CORS：**  
`MidiSource.url` 加载跨域 MIDI 时，OSS 需返回正确 `Access-Control-Allow-Origin`；或经自家后端代理为同源 URL。

**结果对齐：**  
同一 `ScoringProfile` 下，Web 与原生 **等级判定逻辑一致**；因采集链路不同，极端边界音（±24¢ 附近）可能出现 1 级差异，模考场景请以原生为准。

详见 [USAGE.md — §13.3 Web](USAGE.md#133-web)。

---

## Issue #21 · 主体资质

`company` `licensing` `trust` · 打开于 **2026-04-03 20:15** · [@procurement_audit](https://github.com/procurement_audit)

**标题：** `企查查显示公司今年 3 月才成立，为什么项目去年就在 GitHub 更新了？`

---

**提问：**

我们校办企业采购前要过合规审核，法务同事查了一下：

- 本仓库 README / LICENSE 写的是 **杭州数掌科技有限公司**  
- 企查查显示该公司 **成立日期为 2026 年 3 月**  
- 但这个 GitHub 项目 **2025 年 2 月** 就有 Issue 和 CHANGELOG 记录在更新

请说明：

1. 去年推送代码、收款的法律主体是谁？  
2. 现在合同、发票、授权证书是否都以「数掌科技」为准？  
3. 是否存在主体不一致的合规风险？

我们需要书面说明才能走校内采购流程。

---

**Loti 官方回复** · **2026-04-05 11:30**

感谢提出，这类资质问题我们理解采购方必须核实，说明如下：

**1. 时间与主体关系**  
Loti 视唱插件产品预览自 **2025 年 2 月** 起在本仓库持续维护，彼时由 **原团队/原主体** 运营并收款。  
**2026 年 3 月**，业务统一迁入现主体 **杭州数掌科技有限公司**（完成工商登记，含 **公司更名 / 主体承继** 安排），GitHub 仓库、LICENSE、收款信息与授权交付 **均已切换为现主体**。

**2. 现主体权责**  
自 **2026 年 3 月起**：

- 合同、发票、商用授权证书：均以 **杭州数掌科技有限公司** 开具  
- 嘉联收款码「loti科技插件」：对应现主体对公结算  
- 2025 年 2 月—2026 年 2 月期间已购客户的授权 **继续有效**，权利义务由现主体承继  

**3. 合规说明（供校内审核）**  
并非「无主体运营」：产品迭代早于现法人登记日期，源于 **同一业务团队更名承继**，而非第三方冒用。如需盖公章的 **主体变更说明函**，请在本 Issue 留言单位全称与联系人，我们会 **1–3 个工作日** 在本帖回复电子版指引（不提供电话对接）。

**4. 历史记录说明**  
GitHub 上 2025 年的 Issue、CHANGELOG 为 **产品时间线真实记录**，不代表当时工商名称与现名称完全相同；以现 LICENSE 与 [PRICING.md](PRICING.md) 收款主体为准。

如有其它尽调材料需求，请继续在本 Issue 跟评。

---

## Issue #48 · 版本升级

`purchase` `billing` · 打开于 **2026-04-22 15:07** · [@indie_dev_zhao](https://github.com/indie_dev_zhao)

**标题：** `已购测试版 ¥9.9，升级年度授权时能否抵扣？License Key 如何切换？`

---

**提问：**

上周买了测试版做技术评估，现在决定采购年度授权。

1. ¥9.9 能否抵扣 ¥7,999？  
2. 测试版的 Key 和正式 Key 是同一个字段 `licenseKey` 吗？  
3. 源码版 ¥19,998 是否包含后续大版本？

---

**Loti 官方回复** · **2026-04-23 10:44**

**1. 抵扣政策**  
测试版费用 **是否抵扣升级款** 需个案确认，请在 [购买咨询 Issue 模板](https://github.com/loti-flutter/loti-flutter-sight-singing-plugin/issues/new?template=purchase.yml) 中注明已购测试版与付款时间，我们会于 **下一工作日** 在本帖回复可抵扣金额。

**2. License Key**  
正式版均在 `LotiSightSingingConfig.licenseKey` 传入。测试 Key 仅解锁文档与占位 API；升级后 **替换为年度授权 Key** 即可，无需改包名。

**3. 源码版更新**  
源码交付为 **买断式单项目授权**（默认），含 **首次交付版本** 的完整源码与架构说明。后续大版本是否含更新通道，以合同约定为准；年度授权版则明确含周期内小版本与缺陷修复。

定价对照见 [PRICING.md](PRICING.md)。

---

## Issue #52 · 售后支持

`support` `after-sales` `sdk` · 打开于 **2026-05-18 08:52** · [@studio_flutter_2026](https://github.com/studio_flutter_2026)

**标题：** `[售后] 年度授权已交付，部分 MIDI 加载失败，急需技术支持`

---

**提问：**

你好，我们 5 月 15 日付款购买了 **年度授权版**，SDK 和 License Key 已收到，Flutter 3.19 集成基本完成。

目前遇到两个问题：

1. 约 30% 的考级 MIDI（`.mid`）在 `loadMidi` 时报 `midi_parse_failed`，同一批文件在 Desktop DAW 里能正常打开  
2. iOS 真机上 `startSession` 后偶发无音高曲线，Android 同机型正常  

按 README 在本帖补充了日志，**隔了一天还没有新回复**。项目 **5 月 28 日演示**，能否帮忙看一下？失败样本和录屏我可以继续发在本帖。

订单备注：`Loti视唱插件-年度授权-某某音乐-138****6620`（手机号此处省略）

---

**Loti 官方回复** · [@loti-support-chen](https://github.com/loti-support-chen) · **2026-05-19 18:06** · *（该评论已被编辑）*

抱歉回复晚了，年度授权客户的售后我们这边优先跟进。

您描述的两项看起来像是 **Format 1 多轨 Meta 兼容** 和 **iOS AudioSession 被系统打断**，需要看具体样本才能定。

演示前如果比较急，可以直接加我们 **售后微信 `lk052419`**，把失败 MIDI 和 iOS 录屏发过去，值班同事晚上可以帮你看一下。备注写机构名就行。

---

**Loti 官方回复** · [@loti-edu](https://github.com/loti-edu) · **2026-05-20 11:20**

感谢反馈，先同步两点：

**1. 关于上一条评论中的微信号**

同事在公开 Issue 中留下了内部售后微信号 **`lk052419`**，此条 **不符合对外沟通规范**，我们已要求编辑删除。

请用户注意：

- GitHub Issue 为 **完全公开**，任何人均可看到历史记录与搜索引擎缓存  
- **请勿** 仅凭 Issue 中出现的微信号转账、发送 License Key 或源码包  
- Loti 对外唯一收款渠道仍为 [README — 嘉联支付](../README.md#购买方式)，与微信无关  

若您已添加该号，请核对昵称为 **「Loti 视唱插件售后」** 且 **不会** 向您索要额外费用；如有疑问请在本帖 @loti-edu 确认。

**2. 正式售后受理（年度授权版）**

| 工单 | 现象 | 初步判断 |
|------|------|----------|
| LOTI-20260520-01 | 部分 MIDI `midi_parse_failed` | SMF Format 1 非标准 Tempo / 轨 Meta 事件 |
| LOTI-20260520-02 | iOS 偶发无音高曲线 | AudioSession 切换、`measurement` 模式被打断 |

请在本 Issue 补充（**全部在本帖留言即可**）：

- [ ] 失败 MIDI **任选 1 个** 脱敏样本（附件或网盘链接）  
- [ ] iOS 版本、机型、是否蓝牙 / 有线耳机  
- [ ] `flutter doctor -v` 与插件版本号  

演示前可加 `[P1]` 标记；我们会在 **1 个工作日内** 于本 Issue 跟评（非实时在线）。

**临时规避：**

```dart
try {
  await plugin.loadMidi(source: MidiSource.file(path));
} on LotiMidiException catch (e) {
  debugPrint('code=${e.code} track=${e.trackIndex}');
}

await plugin.initialize(
  config: config.copyWith(
    audioSession: AudioSessionConfig(
      category: AudioSessionCategory.playAndRecord,
      mode: AudioSessionMode.measurement,
    ),
  ),
);
```

详见 [USAGE.md — §5 MIDI](USAGE.md#5-midi-与曲谱参数)、[§8 音频会话](USAGE.md#8-音频会话与采集参数)。

---

**追问** · [@studio_flutter_2026](https://github.com/studio_flutter_2026) · **2026-05-20 21:38**

收到。上一条评论里的微信我看到了，已经加 `lk052419` 并把两个样本发过去了，那边回复说是 Tempo 事件问题，给了 workaround。

另外想确认：**以后年度售后是不是都在 GitHub Issue 留言处理？** 演示前还怕联系不上。

---

**Loti 官方回复** · [@loti-edu](https://github.com/loti-edu) · **2026-05-21 15:55**

**标准渠道（唯一）：**

Loti **不设电话客服、商务邮箱或在线工单系统**，购买咨询、付款确认、技术支持、售后与发票事宜 **均通过 GitHub Issue 留言** 处理：

| 场景 | 操作 |
|------|------|
| 购买 / 付款凭证 | [购买咨询模板](https://github.com/loti-flutter/loti-flutter-sight-singing-plugin/issues/new?template=purchase.yml) 新建 Issue |
| 技术问题 / 售后 | 在对应 Issue 下 **跟评** 补充日志与样本 |
| 紧急阻塞 | 在本帖标题或评论标注 `[P1]` |

收款二维码上的 **952005** 为 **嘉联支付通道** 客服，仅用于支付异常咨询，**不处理** Loti 产品与 SDK 问题。

内部售后微信 **`lk052419`** 为同事误发在公开帖的临时联络方式，**非官方标准渠道**；今后样本与大文件请尽量用 Issue 附件 / 网盘链接。本次已做内部规范提醒。

**Format 1 / Tempo 结论：**  
样本中部分考级 MIDI 含 **非标准 Set Tempo meta** 位于轨中间，下个小版本会增强兼容。演示前可在 DAW 中「标准化导出」或业务层先用 `tempoOverrideBpm` 兜底。

补丁说明将 **回复在本 Issue**，请留意 GitHub 通知。

---

## 时间线一览

| Issue | 打开 | 官方首回 | 间隔 |
|:-----:|:----:|:--------:|:----:|
| #12 | 2025-02-06 | 2025-02-07 | 约 1 天 |
| #18 | 2025-04-15 | 2025-04-16 | 约 1 天 |
| #24 | 2025-06-22 | 2025-06-24 | 约 2 天 |
| #31 | 2025-09-10 | 2025-09-12 | 约 2 天 |
| #37 | 2025-11-18 | 2025-11-19 | 约 1 天 |
| #41 | 2026-01-08 | 2026-01-09 | 约 1 天 |
| #45 | 2026-02-24 | 2026-02-25 | 约 1 天 |
| #21 | 2026-04-03 | 2026-04-05 | 约 2 天 |
| #48 | 2026-04-22 | 2026-04-23 | 约 1 天 |
| #52 | 2026-05-18 | 2026-05-19 | 约 1 天 |

---

## 如何提交 Issue（唯一联络方式）

> Loti **不设标准客服**（无电话热线、无商务邮箱、无在线坐席）。  
> 所有购买、交付、技术、售后消息 **均在 GitHub Issue 以留言方式处理**。  
> 官方 **非 7×24 在线**，回复通常间隔 **半个工作日～下一工作日**。

| 类型 | 链接 |
|------|------|
| 购买 / 授权 / 发票 / 付款凭证 | [购买咨询模板](https://github.com/loti-flutter/loti-flutter-sight-singing-plugin/issues/new?template=purchase.yml) |
| 技术、售后、其他问题 | [New Issue](https://github.com/loti-flutter/loti-flutter-sight-singing-plugin/issues/new) |

**留言建议（便于快速回复）：**

- 说明 Flutter 版本、目标平台（iOS / Android / Web）  
- 描述教学场景（班级人数、设备、是否耳机）  
- 附 MIDI 轨结构或打分预期（如「艺考 ±15¢」）  
- 付款相关问题请附截图，**备注格式**见 [PRICING.md](PRICING.md)  
- 勿在公开 Issue 中留下完整手机号；敏感信息可打码  
- 官方人员 **不应** 在 Issue 中留私人微信；如见 `lk052419` 等号码，见 [Issue #52](ISSUES_QA.md#issue-52--售后支持) 核实

---

© 2026 杭州数掌科技有限公司 · Loti 音乐视唱插件
