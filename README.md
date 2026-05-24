<div align="center">

# Loti · 基于 Flutter 生态的音乐视唱插件

**MIDI 跟唱 · 实时音高 · KTV 风格打分 · 教培场景即用**

[![Flutter](https://img.shields.io/badge/Flutter-3.3%2B-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![License](https://img.shields.io/badge/License-Commercial-red)](LICENSE)
[![Version](https://img.shields.io/badge/Version-0.0.1--preview-lightgrey)](pubspec.yaml)

[版本与定价](#版本与定价) · [购买方式](#购买方式) · [路线图](docs/ROADMAP.md) · [详细定价页](docs/PRICING.md)

</div>

---

## 产品简介

**Loti 音乐视唱插件**是一款面向 **Flutter / Dart** 技术栈的智能视唱解决方案，帮助音乐教育 App、智慧校园、陪练类产品快速集成「看谱跟唱 + 实时反馈」能力，而无需从零自研音频解析、音高检测与打分逻辑。

### 为什么选择 Flutter 生态？

| 优势 | 说明 |
|------|------|
| **跨平台** | 同一套 Dart 代码覆盖 iOS、Android，Web 可按需扩展 |
| **可嵌入** | 以 Flutter Plugin / Module 形式接入现有 App |
| **可定制** | 源码交付版开放 UI 与业务层，适配机构品牌与教学流程 |
| **教培场景成熟** | 与钢琴陪练、乐理练习、作业打卡等模块天然组合 |

### 计划核心能力（授权交付）

- **MIDI 驱动**：支持 `.mid` / `.midi`，解析多轨并让用户确认主旋律轨  
- **KTV 音符条**：横向时间轴 + 音高轨道，跟唱过程可视化  
- **实时音高检测**：麦克风采集 + 音高分析，展示「标准音 / 你的音」  
- **按音符打分**：Perfect / Good / OK / Miss，连击与命中率统计  
- **iPad 优化**：默认无声跟唱，避免教室 / 家庭外放被麦克风录入导致误打分  
- **多种导入**：内置 demo、本地文件、在线 MIDI 地址（以交付版为准）  

> ⚠️ **重要说明**：本 GitHub 仓库当前为**公开的产品预览与占位工程**，用于展示产品定位、定价与收款渠道。**完整商业功能按授权版本单独交付**，不在此公开仓库中提供。

---

## 适用场景

- 音乐培训学校 / 艺术机构自有 App  
- K12 智慧校园音乐素养、视唱练耳模块  
- 在线陪练、AI 音乐助教类产品  
- 需要 **可编程、可二次开发** 视唱子系统的研发团队  

---

## 快速预览

```bash
git clone https://github.com/loti-edu/loti-flutter-sight-singing-plugin.git
cd loti_flutter_sight_singing_plugin/example
flutter pub get
flutter run
```

示例 App 展示产品介绍、三档定价与收款信息。插件 API 当前为占位实现：

```dart
import 'package:loti_flutter_sight_singing_plugin/loti_flutter_sight_singing_plugin.dart';

final plugin = LotiSightSingingPlugin();
final status = await plugin.getStatus();
// Loti Sight Singing Plugin 0.0.1-preview (preview) · ...
```

---

## 版本与定价

| 版本 | 价格 | 一句话说明 |
|:--|:--:|:--|
| **测试版** | **¥9.9** | 最低成本验证接入与产品方向，含占位 SDK 与说明文档 |
| **年度授权版** | **¥7,999 / 年** | 正式商用 SDK + 年度更新 + 技术支持 + 授权证书 |
| **源码交付 · 可编程版** | **¥19,998** | 完整 Flutter 源码，UI / 业务可改，适合深度定制 |

📄 完整对比、交付范围与 FAQ 见 **[docs/PRICING.md](docs/PRICING.md)**

---

## 购买方式

### 1. 扫码付款（推荐）

使用 **嘉联支付** 收款码，支持 **微信、支付宝、银联、云闪付** 扫码。

<div align="center">

![Loti 视唱插件 · 扫码付款](docs/assets/payment-qr.png)

**收款名称：loti科技插件** · 编号 `No.EQR1702454`  
客服电话：**952005**

</div>

| 项目 | 内容 |
|------|------|
| **支付渠道** | 嘉联支付 |
| **收款名称** | loti科技插件 |
| **收款编号** | `No.EQR1702454` |
| **支持方式** | 微信支付 · 支付宝 · 银联 · 云闪付 |
| **客服电话** | 952005 |

**付款备注建议：** `Loti视唱插件-版本名-联系人-手机号`  
（例如：`Loti视唱插件-年度授权-张三-138xxxx8888`）

> 收款主体：**杭州数掌科技有限公司**。请仅通过本仓库展示的官方二维码付款，勿向个人账号转账。

### 2. 发送付款凭证

付款完成后，请将以下信息发送至商务邮箱（请替换为您的实际邮箱并在 Issue 中留言获取最新联系方式）：

- 付款截图（含金额、时间、收款名称）
- 所需版本（测试版 / 年度授权 / 源码交付）
- 公司或个人名称、联系人、邮箱、电话

### 3. 交付

确认到账后 **1–3 个工作日** 内安排对应版本交付（SDK 包、文档或源码，以合同约定为准）。

---

## 仓库结构

```
loti_flutter_sight_singing_plugin/
├── lib/                    # 插件 Dart API（当前为占位）
├── example/                # 示例 App（产品介绍页）
├── docs/
│   ├── PRICING.md          # 定价与收款（详细版）
│   └── ROADMAP.md          # 能力路线图
├── android/ ios/ web/      # 插件平台壳
├── README.md
└── LICENSE                 # 商业授权说明
```

---

## 集成规划（交付后）

授权客户将收到集成指南，典型步骤：

1. 在 `pubspec.yaml` 依赖 Loti 插件包（私有 Git / 制品库）  
2. 初始化音频权限与路由  
3. 嵌入视唱页面或调用插件 API  
4. 按机构需求配置主题、曲目来源与打分策略  

具体 API 以交付文档为准。

---

## 技术支持

| 版本 | 支持范围 |
|------|----------|
| 测试版 | 文档自助 + Issue 提问（不保证响应时效） |
| 年度授权 | 邮件支持、缺陷修复、小版本更新 |
| 源码交付 | 含首次远程接入答疑 + 架构说明 |

---

## 法律与授权

- 本仓库公开代码与文档受 [LICENSE](LICENSE) 约束  
- **未经授权不得将商业 SDK / 源码用于生产环境或二次分发**  
- 「Loti」为产品名称，商标归属以杭州数掌科技有限公司声明为准  

---

## 联系我们

- **主体**：杭州数掌科技有限公司  
- **GitHub Issues**：[提交购买咨询](https://github.com/loti-edu/loti-flutter-sight-singing-plugin/issues/new?template=purchase.yml) · [其他问题](https://github.com/loti-edu/loti-flutter-sight-singing-plugin/issues)  
- **商务邮箱**：请在 Issue 中留言「购买咨询」，我们会回复最新联系方式  

---

<div align="center">

**Loti · 让 Flutter App 拥有专业级音乐视唱能力**

[⭐ Star 本仓库](https://github.com/loti-edu/loti-flutter-sight-singing-plugin) · [查看定价](docs/PRICING.md)

</div>
