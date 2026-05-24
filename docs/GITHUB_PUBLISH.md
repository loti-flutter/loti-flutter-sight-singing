# 发布到 GitHub

本文档说明如何将本仓库首次推送到 GitHub，并完成仓库页的基础配置。

---

## 发布前检查清单

- [ ] 已创建 GitHub 组织或账号（当前文档默认路径：`loti-edu/loti-flutter-sight-singing-plugin`）
- [ ] 本地已执行 `git init` 并完成首次提交
- [ ] `docs/assets/payment-qr.png` 与 `example/assets/payment-qr.png` 已纳入版本库
- [ ] `.github/ISSUE_TEMPLATE/purchase.yml` 购买咨询模板已存在
- [ ] README / PRICING / ROADMAP 中的链接与定价信息一致
- [ ] 未提交 `build/`、`*.log`、`local.properties`、`.dart_tool/` 等本地产物

若 GitHub 用户名或组织名**不是** `loti-edu`，请全局替换以下文件中的仓库路径：

- `README.md`
- `pubspec.yaml`（`homepage` / `repository` / `issue_tracker`）
- `lib/src/loti_sight_singing_plugin.dart`
- `.github/ISSUE_TEMPLATE/` 内各模板链接

---

## 1. 在 GitHub 创建空仓库

1. 打开 [GitHub New Repository](https://github.com/new)
2. **Repository name**：`loti-flutter-sight-singing-plugin`
3. **Description**：`Loti 基于 Flutter 生态的音乐视唱插件`
4. **Visibility**：Public（便于搜索与展示定价）
5. **不要**勾选「Add a README file」（本地已有）
6. 创建仓库

---

## 2. 本地初始化并推送

在项目根目录执行（将 `YOUR_GITHUB_USER` 替换为实际用户名或组织名）：

```bash
cd path/to/loti-flutter-sight-singing-plugin

git init
git add .
git commit -m "chore: initial preview — Loti Flutter 音乐视唱插件产品与定价"
git branch -M main
git remote add origin https://github.com/YOUR_GITHUB_USER/loti-flutter-sight-singing-plugin.git
git push -u origin main
```

---

## 3. 配置仓库 About 区域

在 GitHub 仓库页右上角 **About** → **Settings**（齿轮）中填写：

| 字段 | 建议内容 |
|------|----------|
| Description | Loti 基于 Flutter 生态的音乐视唱插件 — MIDI 跟唱、实时音高检测与 KTV 风格打分 |
| Website | `https://github.com/loti-edu/loti-flutter-sight-singing-plugin` |
| Topics | `flutter` `dart` `plugin` `music-education` `sight-singing` `midi` `ktv` |

---

## 4. 开启 Issues

1. 进入仓库 **Settings** → **General** → **Features**
2. 勾选 **Issues**
3. 可选：启用 **Issues templates**，确认「购买咨询」模板可用
4. 确认 README 已说明：**无标准客服，所有消息通过 Issue 留言处理**

验证：访问  
`https://github.com/YOUR_GITHUB_USER/loti-flutter-sight-singing-plugin/issues/new/choose`  
应能看到「购买咨询」选项。

---

## 5. 上线后快速验证

- [ ] 仓库首页 README 正常渲染，收款二维码图片可见
- [ ] [docs/PRICING.md](PRICING.md) 中相对路径图片正常显示
- [ ] Issues → New issue →「购买咨询」表单字段完整
- [ ] `git clone` 后 `example` 目录可 `flutter pub get`（需在本地 Flutter 环境验证）
- [ ] About 区域 Topics 已保存

---

## 6. 可选后续

- 添加 GitHub Actions 运行 `flutter test`（占位工程通过后可在 README 加 CI Badge）
- 创建 Release `v0.0.1-preview` 并附 CHANGELOG 摘要
- 在 README 购买章节确认 Issue 为唯一联络方式（不设商务邮箱）

---

© 杭州数掌科技有限公司
