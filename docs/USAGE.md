# Loti 音乐视唱插件 · 使用说明

> **文档版本**：v0.0.1-preview  
> **适用 SDK**：Loti Sight Singing Plugin（Flutter 3.3+ / Dart 3.12+）  
> **版权主体**：杭州数掌科技有限公司

---

## 文档说明

| 标识 | 含义 |
|------|------|
| ✅ **预览可用** | 当前公开仓库已提供，可直接调用 |
| 🔒 **授权交付** | 完整商用 SDK 按购买版本单独交付（见 [PRICING.md](PRICING.md)） |

本说明采用**音乐教育行业通用术语**描述参数含义，便于视唱练耳教师、教研人员与 Flutter 工程师对齐需求。  
🔒 标记的 API 与参数为**正式版规格说明**，交付包版本号以授权合同为准。

---

## 目录

1. [核心概念与术语](#1-核心概念与术语)
2. [快速开始](#2-快速开始)
3. [会话生命周期](#3-会话生命周期)
4. [全局配置 LotiSightSingingConfig](#4-全局配置-lotisightsingingconfig)
5. [MIDI 与曲谱参数](#5-midi-与曲谱参数)
6. [音高检测参数](#6-音高检测参数)
7. [视唱打分参数](#7-视唱打分参数)
8. [音频会话与采集参数](#8-音频会话与采集参数)
9. [KTV 音符条 UI 参数](#9-ktv-音符条-ui-参数)
10. [教培场景专项设置](#10-教培场景专项设置)
11. [公开 API 参考](#11-公开-api-参考)
12. [事件回调](#12-事件回调)
13. [权限与平台配置](#13-权限与平台配置)
14. [常见问题](#14-常见问题)

---

## 1. 核心概念与术语

### 1.1 视唱相关

| 术语 | 英文 | 说明 |
|------|------|------|
| **标准音高** | Target Pitch | MIDI 主旋律事件中规定的音高（Hz 或 MIDI Note Number） |
| **演唱音高** | Sung Pitch | 麦克风实时分析得到的基频（F0） |
| **音分** | Cent (¢) | 音高偏差单位；100¢ = 半音（semitone）；A4 上方半音为 +100¢ |
| **起音时刻** | Onset | 音符实际开始发声的时间点 |
| **时值** | Duration | 音符从起音到收音的时长 |
| **音准分** | Intonation Score | 演唱音高与标准音高的偏差评估 |
| **节奏分** | Rhythm Score | 起音、收音与标准时间轴的偏差评估 |

### 1.2 MIDI 相关

| 术语 | 说明 |
|------|------|
| **SMF** | Standard MIDI File，标准 MIDI 文件（`.mid` / `.midi`） |
| **Track（轨）** | MIDI 文件中独立的事件序列；常见有旋律轨、伴奏轨、打击乐轨 |
| **Note On / Off** | 音符起音 / 收音事件，含音符号（0–127）与力度（Velocity） |
| **Tempo（BPM）** | 每分钟拍数；影响时间轴滚动速度 |
| **Time Signature** | 拍号，如 4/4、3/4、6/8 |
| **Tick** | MIDI 内部时间分辨率单位，需结合 Tempo 换算为毫秒 |

### 1.3 打分等级

Loti 采用四级音准—节奏综合评定（可在配置中调整权重）：

| 等级 | 典型含义（默认阈值见 §7） |
|------|---------------------------|
| **Perfect** | 音准、节奏均落在严格窗口内 |
| **Good** | 轻微偏差，不影响乐句完整性 |
| **OK** | 可辨识但偏差明显，需练习 |
| **Miss** | 未发声、严重跑调或节奏严重错位 |

---

## 2. 快速开始

### 2.1 添加依赖 ✅ 预览可用

**公开预览仓库（path / git）：**

```yaml
dependencies:
  loti_flutter_sight_singing_plugin:
    git:
      url: https://github.com/loti-flutter/loti-flutter-sight-singing-plugin.git
      ref: main
```

**🔒 授权交付后（私有制品库示例）：**

```yaml
dependencies:
  loti_flutter_sight_singing_plugin:
    hosted:
      name: loti_flutter_sight_singing_plugin
      url: https://your-private-pub.example.com
    version: ^1.0.0
```

### 2.2 最小示例 ✅ 预览可用

当前公开版本仅提供占位 API，用于验证插件接入与平台识别：

```dart
import 'package:loti_flutter_sight_singing_plugin/loti_flutter_sight_singing_plugin.dart';

Future<void> main() async {
  final plugin = LotiSightSingingPlugin();
  final status = await plugin.getStatus();
  // 示例输出：
  // Loti Sight Singing Plugin 0.0.1-preview (preview) · Android 14
  print(status);
}
```

### 2.3 完整视唱流程 🔒 授权交付

```dart
import 'package:loti_flutter_sight_singing_plugin/loti_flutter_sight_singing_plugin.dart';

Future<void> runSightSinging() async {
  final plugin = LotiSightSingingPlugin();

  // 1. 初始化（含授权校验、音频会话）
  await plugin.initialize(
    config: LotiSightSingingConfig(
      licenseKey: 'YOUR_LICENSE_KEY',
      referencePitchA4: 440.0,
      scoringProfile: ScoringProfile.standard,
    ),
  );

  // 2. 加载 MIDI
  final score = await plugin.loadMidi(
    source: MidiSource.asset('assets/scores/solfège_c_major.mid'),
  );

  // 3. 选择主旋律轨（多轨时由用户或程序指定）
  await plugin.selectMelodyTrack(
    trackId: score.recommendedMelodyTrackId ?? score.tracks.first.id,
  );

  // 4. 进入视唱会话
  await plugin.startSession(
    mode: SessionMode.silentFollow, // iPad 教培推荐
  );

  // 5. 监听实时事件（见 §12）
  plugin.events.listen((event) {
    // onPitchUpdate / onNoteScored / onSessionFinished ...
  });
}
```

---

## 3. 会话生命周期

```
initialize → loadMidi → selectMelodyTrack → [optional: previewMelody]
     → countdown → listen & follow → scoreNotes → sessionReport → dispose
```

| 阶段 | 说明 | 教师侧关注点 |
|------|------|--------------|
| `initialize` | 授权、音频、UI 主题加载 | 是否允许外放、采样率是否稳定 |
| `loadMidi` | 解析 SMF，提取轨、速度、拍号 | 曲谱是否为纯旋律轨 |
| `selectMelodyTrack` | 确认跟唱目标声部 | 多声部教材需选「学生视唱声部」 |
| `countdown` | 预备拍 / 倒计时 | 建议 2–4 拍，与拍号一致 |
| `listen & follow` | 实时采集 + 音符条滚动 | 教室环境是否开启静音跟唱 |
| `scoreNotes` | 逐音或逐句结算 | 阈值是否匹配学段（小学 / 艺考） |
| `sessionReport` | 命中率、连击、薄弱音级 | 用于作业点评与学情分析 |

---

## 4. 全局配置 `LotiSightSingingConfig`

🔒 授权交付 · 初始化时传入

### 4.1 基础参数

| 参数 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `licenseKey` | `String?` | `null` | 商业授权密钥；测试版可为空或试用 Key |
| `referencePitchA4` | `double` | `440.0` | 标准音 A4 频率（Hz）；调律非 440 时可设为 442 |
| `concertKey` | `String?` | 取自 MIDI | 调高（如 `C major`、`G major`）；影响唱名显示 |
| `locale` | `String` | `zh_CN` | 界面与唱名语言（`zh_CN` / `en`） |
| `scoringProfile` | `ScoringProfile` | `standard` | 打分预设，见 §7.3 |
| `edition` | `LotiSightSingingEdition` | — | 授权版本枚举，见 §11.2 |

### 4.2 会话默认行为

| 参数 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `defaultSessionMode` | `SessionMode` | `silentFollow` | 默认跟唱模式，见 §10 |
| `countdownBeats` | `int` | `2` | 开始前倒计时拍数（与曲谱拍号一致） |
| `autoAdvance` | `bool` | `true` | 当前句结束后自动进入下一句 |
| `allowPause` | `bool` | `true` | 是否允许学生暂停 |
| `allowRetry` | `bool` | `true` | 单句失败后是否允许重唱 |
| `maxRetries` | `int` | `3` | 每句最大重试次数 |

### 4.3 示例

```dart
const config = LotiSightSingingConfig(
  referencePitchA4: 440.0,
  scoringProfile: ScoringProfile.examStrict,
  defaultSessionMode: SessionMode.silentFollow,
  countdownBeats: 4,
  locale: 'zh_CN',
);
```

---

## 5. MIDI 与曲谱参数

### 5.1 加载来源 `MidiSource`

| 枚举值 | 说明 |
|--------|------|
| `MidiSource.asset(path)` | App 内置资源 |
| `MidiSource.file(path)` | 本地文件路径 |
| `MidiSource.url(uri)` | 在线 HTTPS 地址 |
| `MidiSource.bytes(data)` | 内存字节流（上传场景） |

**🔒 `loadMidi` 参数：**

| 参数 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `source` | `MidiSource` | 必填 | MIDI 来源 |
| `transposeSemitones` | `int` | `0` | 移调（半音数；+2 = 升高全全音） |
| `tempoOverrideBpm` | `double?` | `null` | 覆盖曲谱 Tempo；用于慢速练习 |
| `timeSignatureOverride` | `String?` | `null` | 强制拍号显示（一般不建议覆盖） |
| `quantizeGrid` | `QuantizeGrid` | `sixteenth` | 解析时的量化网格，见下表 |

**`QuantizeGrid` 量化网格：**

| 值 | 音乐含义 |
|----|----------|
| `whole` | 全音符 |
| `half` | 二分音符 |
| `quarter` | 四分音符 |
| `eighth` | 八分音符 |
| `sixteenth` | 十六分音符（默认，适合多数视唱条） |
| `thirtySecond` | 三十二分音符（快速跑句） |

### 5.2 轨选择 `selectMelodyTrack`

| 参数 | 类型 | 说明 |
|------|------|------|
| `trackId` | `int` | MIDI Track 索引或内部 ID |
| `channelFilter` | `List<int>?` | 仅保留指定 MIDI Channel（0–15） |
| `ignorePercussion` | `bool` | 默认 `true`，排除打击乐 Channel 10 |
| `minNoteCount` | `int` | 默认 `8`，过滤过短/无效轨 |

**轨摘要 `MidiTrackSummary`（回调 / 返回值）：**

| 字段 | 说明 |
|------|------|
| `id` | 轨标识 |
| `name` | 轨名称（Meta Track Name） |
| `noteCount` | 音符数量 |
| `pitchRange` | 最低音—最高音（MIDI Note Number） |
| `estimatedDifficulty` | 预估难度（音域跨度 + 节奏复杂度） |
| `isLikelyMelody` | 启发式判断是否为旋律轨 |

### 5.3 曲谱播放预览（可选）

| 参数 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `enableMelodyPreview` | `bool` | `false` | 跟唱前播放标准旋律 |
| `previewVolume` | `double` | `0.6` | 预览音量 0.0–1.0 |
| `previewInstrument` | `GeneralMidiProgram` | `AcousticGrandPiano` | General MIDI 音色（Program 0–127） |
| `accompanimentEnabled` | `bool` | `false` | 是否播放伴奏轨（需授权版混音支持） |

---

## 6. 音高检测参数

实时音高分析影响「你的音」曲线与音准打分，需在嘈杂教室内谨慎调参。

### 6.1 `PitchDetectionConfig`

| 参数 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `sampleRateHz` | `int` | `44100` | 采样率；低端机可降至 `22050` 换性能 |
| `bufferSizeMs` | `int` | `46` | 分析窗口（毫秒）；越小延迟越低，越大越稳 |
| `minFrequencyHz` | `double` | `80.0` | 最低检测频率（约 E2）；男低音视唱可略降 |
| `maxFrequencyHz` | `double` | `1200.0` | 最高检测频率（约 D6）；童声 / 女声足够 |
| `confidenceThreshold` | `double` | `0.65` | 置信度阈值 0–1；低于此值视为「未检测到音高」 |
| `smoothingFactor` | `double` | `0.35` | 音高曲线平滑系数；越大越稳、越不灵敏 |
| `silenceGateDb` | `double` | `-45.0` | 静音门限（dBFS）；低于此值不记为发声 |
| `algorithm` | `PitchAlgorithm` | `yin` | 检测算法，见下表 |

**`PitchAlgorithm`：**

| 值 | 特点 | 适用 |
|----|------|------|
| `yin` | 抗噪较好，计算量适中 | **默认**，教室跟唱 |
| `autocorrelation` | 响应快 | 短音、节奏型练习 |
| `crepe` | 神经网络，精度高 | 对设备性能有要求 |

### 6.2 音高显示

| 参数 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `displayUnit` | `PitchDisplayUnit` | `noteName` | 显示方式：`noteName`（唱名）、`midiNote`、`frequency` |
| `solfegeMovableDo` | `bool` | `true` | 首调唱名（Do/Re/Mi）；`false` 为固定调 |
| `showCentsDeviation` | `bool` | `true` | 是否显示 ±¢ 偏差 |
| `pitchLineColorTarget` | `Color` | 主题色 | 标准音高线颜色 |
| `pitchLineColorSung` | `Color` | 强调色 | 演唱音高线颜色 |

---

## 7. 视唱打分参数

### 7.1 音准窗口（单位：音分 ¢）

以标准音高为 0¢，向上下对称计算偏差。

| 参数 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `perfectCents` | `int` | `25` | ≤25¢ 为 Perfect 音准 |
| `goodCents` | `int` | `50` | ≤50¢ 为 Good |
| `okCents` | `int` | `100` | ≤100¢ 为 OK；超出为 Miss |
| `vibratoToleranceCents` | `int` | `15` | 允许的自然颤音波动幅度 |
| `ignoreGraceNotes` | `bool` | `true` | 倚音、短装饰音是否不计分 |
| `minSustainedMs` | `int` | `120` | 短于此时值的音可视为经过音，降低权重 |

### 7.2 节奏窗口（单位：毫秒 ms）

以 MIDI Note On 为基准，比较学生实际起音时刻。

| 参数 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `perfectTimingMs` | `int` | `80` | ±80 ms 内为 Perfect 节奏 |
| `goodTimingMs` | `int` | `150` | ±150 ms 为 Good |
| `okTimingMs` | `int` | `250` | ±250 ms 为 OK |
| `lateMissMs` | `int` | `400` | 晚于标准 400 ms 以上记 Miss |
| `earlyPenaltyMs` | `int` | `200` | 抢拍超过此值降级 |
| `tempoRubatoAllowed` | `bool` | `false` | 是否允许自由速度（抒情段） |

### 7.3 打分预设 `ScoringProfile`

| 预设 | 音准 Perfect | 节奏 Perfect | 适用场景 |
|------|-------------|-------------|----------|
| `relaxed` | ±35¢ | ±120 ms | 小学启蒙、兴趣培养 |
| `standard` | ±25¢ | ±80 ms | **默认**，日常视唱作业 |
| `examStrict` | ±15¢ | ±50 ms | 艺考、等级测评模拟 |
| `conservatory` | ±10¢ | ±40 ms | 专业院校视唱课 |

```dart
// 自定义：在预设基础上微调
final custom = ScoringProfile.standard.copyWith(
  perfectCents: 20,
  perfectTimingMs: 60,
);
```

### 7.4 综合计分

| 参数 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `intonationWeight` | `double` | `0.6` | 音准权重（0–1） |
| `rhythmWeight` | `double` | `0.4` | 节奏权重；两者之和应为 1.0 |
| `comboEnabled` | `bool` | `true` | 连击（连续 Perfect/Good 计数） |
| `comboBreakOn` | `NoteGrade` | `ok` | 低于 OK 时是否打断连击 |
| `missPenaltyScore` | `int` | `0` | Miss 音符扣分（若启用总分制） |

### 7.5 结算报告 `SessionReport`

| 字段 | 说明 |
|------|------|
| `totalNotes` | 参与计分音符总数 |
| `hitRate` | 命中率（Perfect+Good+OK / Total） |
| `perfectRate` | Perfect 占比 |
| `maxCombo` | 最大连击数 |
| `avgCentsDeviation` | 平均音分偏差 |
| `avgTimingMs` | 平均节奏偏差 |
| `weakPitchClasses` | 薄弱音级（如 `#F`、`B`） |
| `weakRhythmPatterns` | 薄弱节奏型（如附点、切分） |

---

## 8. 音频会话与采集参数

### 8.1 `AudioSessionConfig`

| 参数 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `category` | `AudioSessionCategory` | `playAndRecord` | iOS 音频会话类别 |
| `mode` | `AudioSessionMode` | `measurement` | 测量模式，减少系统音效处理 |
| `preferredInput` | `AudioInput` | `builtInMic` | 优先输入设备 |
| `allowBluetoothHeadset` | `bool` | `false` | 是否允许蓝牙耳麦（延迟较高，默认关） |
| `echoCancellation` | `bool` | `true` | 回声消除；外放跟唱时建议开启 |
| `noiseSuppression` | `bool` | `false` | 噪声抑制；可能损伤弱声部，教培默认关 |
| `agcEnabled` | `bool` | `false` | 自动增益；视唱场景建议关，避免动态被压 |

### 8.2 Android 专项

| 参数 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `androidAudioFocus` | `AudioFocus` | `gain` | 音频焦点策略 |
| `androidPerformanceMode` | `LowLatencyMode` | `lowLatency` | 低延迟模式 |

### 8.3 iOS 专项

| 参数 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `iosCategoryOptions` | `List<IosCategoryOption>` | `[defaultToSpeaker, allowBluetooth]` | 见 Apple AVAudioSession 文档 |
| `preferredSampleRate` | `double` | `44100` | 与 `PitchDetectionConfig.sampleRateHz` 对齐 |
| `preferredIOBufferDuration` | `double` | `0.005` | 5 ms IO 缓冲，平衡延迟与稳定性 |

---

## 9. KTV 音符条 UI 参数

### 9.1 `NoteBarStyle`

| 参数 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `orientation` | `Axis` | `horizontal` | 横向时间轴（KTV 风格） |
| `scrollSpeed` | `ScrollSpeed` | `matchTempo` | 滚动速度与 BPM 同步 |
| `lookaheadBeats` | `double` | `2.0` | 提前显示未来 2 拍音符 |
| `noteHeight` | `double` | `12.0` | 单音条高度（逻辑像素） |
| `pitchLaneHeight` | `double` | `240.0` | 音高区域总高度 |
| `showLyrics` | `bool` | `false` | 是否显示歌词轨（若 MIDI 含 Meta Lyric） |
| `showMeasureLines` | `bool` | `true` | 小节线 |
| `showBeatGrid` | `bool` | `true` | 拍点网格 |
| `highlightScaleDegrees` | `bool` | `true` | 高亮调内音（Ⅰ–Ⅶ 级） |

### 9.2 音符着色（按结算等级）

| 等级 | 默认色语义 |
|------|------------|
| Perfect | 金色 / 高亮绿 |
| Good | 绿色 |
| OK | 黄色 |
| Miss | 红色或灰显 |

可通过 `NoteBarTheme` 覆盖，源码交付版支持完全自定义 Widget 树。

### 9.3 嵌入方式

| 方式 | 说明 |
|------|------|
| `LotiSightSingingPage` | 开箱即用全页（含权限、倒计时、结果页） |
| `LotiNoteBarWidget` | 仅音符条，嵌入现有 Scaffold |
| `LotiPitchMeterWidget` | 仅音高仪表盘（调音/练声） |
| Headless API | 无 UI，自行绘制；适合完全定制品牌 |

---

## 10. 教培场景专项设置

### 10.1 跟唱模式 `SessionMode`

| 模式 | 说明 | 推荐场景 |
|------|------|----------|
| `silentFollow` | **无声跟唱**：不播放标准旋律，仅显示音符条 | **iPad 教室**、家庭练习（防外放串音） |
| `melodyFollow` | 播放标准旋律 + 跟唱 | 耳机单人练习 |
| `callAndResponse` | 先播一句，学生复述 | 启蒙、模唱训练 |
| `exam` | 无预览、限时、严格计分 | 模拟测评 |
| `practice` | 可暂停、降速、反复单句 | 日常作业 |

### 10.2 iPad / 教室防串音

| 参数 | 类型 | 默认值 | 说明 |
|------|------|--------|------|
| `forceSilentFollowOnIPad` | `bool` | `true` | iPad 自动启用无声跟唱 |
| `speakerMuteDuringCapture` | `bool` | `true` | 采集期间静音扬声器 |
| `headphoneRequired` | `bool` | `false` | 是否强制耳机（模考可选 `true`） |
| `bleedDetectionEnabled` | `bool` | `true` | 检测外放被麦克风拾取时提示 |

### 10.3 学段建议配置

**小学（7–9 岁）：**

```dart
LotiSightSingingConfig(
  scoringProfile: ScoringProfile.relaxed,
  defaultSessionMode: SessionMode.practice,
  countdownBeats: 4,
);
// PitchDetection: confidenceThreshold 0.55, minSustainedMs 150
```

**中学日常视唱：**

```dart
LotiSightSingingConfig(
  scoringProfile: ScoringProfile.standard,
  defaultSessionMode: SessionMode.silentFollow,
);
```

**艺考 / 等级测试：**

```dart
LotiSightSingingConfig(
  scoringProfile: ScoringProfile.examStrict,
  defaultSessionMode: SessionMode.exam,
  allowRetry: false,
  maxRetries: 0,
);
```

---

## 11. 公开 API 参考

### 11.1 ✅ 预览可用

#### `LotiSightSingingPlugin`

| 成员 | 类型 | 说明 |
|------|------|------|
| `packageVersion` | `String` | 当前包版本，如 `0.0.1-preview` |
| `getStatus()` | `Future<String>` | 插件与平台版本摘要 |

### 11.2 ✅ 预览可用 · 授权元数据

#### `LotiSightSingingEdition`

| 枚举值 | 显示名 | 定价 |
|--------|--------|------|
| `trial` | 测试版 | ¥9.9 |
| `annual` | 年度授权版 | ¥7,999 / 年 |
| `sourceCode` | 源码交付 · 可编程版 | ¥19,998 |

### 11.3 🔒 授权交付 · 核心 API（规格）

| 方法 | 说明 |
|------|------|
| `initialize(config)` | 初始化 SDK、授权、音频 |
| `dispose()` | 释放 native 资源 |
| `loadMidi(source, {...})` | 加载并解析 MIDI |
| `selectMelodyTrack({trackId, ...})` | 选择主旋律轨 |
| `previewMelody({enabled, volume})` | 标准旋律试听 |
| `startSession({mode})` | 开始视唱会话 |
| `pauseSession()` / `resumeSession()` | 暂停 / 继续 |
| `stopSession()` | 结束并生成报告 |
| `retryPhrase(phraseId)` | 重唱当前乐句 |
| `setTempoScale(double)` | 慢速练习（0.5 = 半速） |
| `events` | 事件流 `Stream<LotiSightSingingEvent>` |

---

## 12. 事件回调

🔒 授权交付 · `plugin.events` 主要事件：

### `OnPitchUpdate`

| 字段 | 类型 | 说明 |
|------|------|------|
| `frequencyHz` | `double?` | 当前 F0；null 表示未检测到 |
| `midiNote` | `double?` | 连续 MIDI 音高（含小数，如 60.3） |
| `centsDeviation` | `double?` | 相对当前目标音的偏差 |
| `confidence` | `double` | 0–1 |
| `timestampMs` | `int` | 会话内时间戳 |

### `OnNoteScored`

| 字段 | 类型 | 说明 |
|------|------|------|
| `noteId` | `String` | 音符唯一 ID |
| `targetMidiNote` | `int` | 标准音符号 |
| `grade` | `NoteGrade` | `perfect` / `good` / `ok` / `miss` |
| `intonationCents` | `double` | 音准偏差 |
| `timingMs` | `double` | 节奏偏差 |
| `combo` | `int` | 当前连击数 |

### `OnSessionFinished`

| 字段 | 类型 | 说明 |
|------|------|------|
| `report` | `SessionReport` | 完整结算报告 |
| `durationMs` | `int` | 会话总时长 |

### `OnError`

| 字段 | 说明 |
|------|------|
| `code` | 错误码（如 `midi_parse_failed`、`mic_permission_denied`） |
| `message` | 可读描述 |
| `recoverable` | 是否可重试 |

---

## 13. 权限与平台配置

### 13.1 Android

在宿主 App `AndroidManifest.xml` 中声明（🔒 正式版集成指南会提供完整清单）：

```xml
<uses-permission android:name="android.permission.RECORD_AUDIO" />
<uses-permission android:name="android.permission.MODIFY_AUDIO_SETTINGS" />
```

### 13.2 iOS

在宿主 App `Info.plist` 中：

```xml
<key>NSMicrophoneUsageDescription</key>
<string>需要使用麦克风进行视唱音高检测与打分</string>
```

### 13.3 Web

| 项 | 说明 |
|----|------|
| 麦克风 | 需 HTTPS 与用户授权 |
| 延迟 | 通常高于原生；建议标注「练习模式」 |
| MIDI 加载 | 注意 CORS；推荐同源或签名 URL |

---

## 14. 常见问题

**Q：为什么公开 GitHub 仓库调用不了 `loadMidi` / `startSession`？**  
A：当前公开版为预览占位，完整 API 需购买授权后从私有渠道获取。见 [PRICING.md](PRICING.md)。

**Q：教室 iPad 外放会导致误打分怎么办？**  
A：启用 `SessionMode.silentFollow` 与 `forceSilentFollowOnIPad: true`，并开启 `speakerMuteDuringCapture`。

**Q：学生唱名（Do/Re）与固定调（C/D）如何切换？**  
A：设置 `solfegeMovableDo: true`（首调）或 `false`（固定调），并配合 `concertKey`。

**Q：MIDI 有多条轨，如何自动选旋律？**  
A：可先展示 `MidiTrackSummary.isLikelyMelody`，或由教师在管理后台指定默认 `trackId`。

**Q：调律不是 A4=440 Hz 怎么办？**  
A：初始化时设置 `referencePitchA4: 442.0`（或 415 等历史调律）。

**Q：如何联系技术支持或售后？**  
A：**仅通过 [GitHub Issues 留言](https://github.com/loti-flutter/loti-flutter-sight-singing-plugin/issues)**。Loti 不设电话客服或商务邮箱；购买、交付、缺陷修复均在对应 Issue 跟评中处理。范例见 [ISSUES_QA.md](ISSUES_QA.md)。

**Q：如何对接机构作业系统？**  
A：在 `OnSessionFinished` 中取 `SessionReport` JSON 上传至 LMS；源码交付版可自定义上报字段。

---

## 相关文档

| 文档 | 说明 |
|------|------|
| [README.md](../README.md) | 产品概览与购买 |
| [PRICING.md](PRICING.md) | 版本与定价 |
| [ROADMAP.md](ROADMAP.md) | 能力路线图 |
| [USAGE.md](USAGE.md) | 使用说明与参数参考 |
| [ISSUES_QA.md](ISSUES_QA.md) | 社区问答（Issue 精选） |
| [example/README.md](../example/README.md) | 示例 App 运行 |

---

© 2026 杭州数掌科技有限公司 · Loti 音乐视唱插件
