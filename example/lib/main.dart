import 'package:flutter/material.dart';
import 'package:loti_flutter_sight_singing_plugin/loti_flutter_sight_singing_plugin.dart';

void main() {
  runApp(const LotiSightSingingDemoApp());
}

class LotiSightSingingDemoApp extends StatelessWidget {
  const LotiSightSingingDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loti 音乐视唱插件',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1A1A1A),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        fontFamily: 'PingFang SC',
      ),
      home: const ProductIntroPage(),
    );
  }
}

class ProductIntroPage extends StatefulWidget {
  const ProductIntroPage({super.key});

  @override
  State<ProductIntroPage> createState() => _ProductIntroPageState();
}

class _ProductIntroPageState extends State<ProductIntroPage> {
  String _status = '加载中…';

  @override
  void initState() {
    super.initState();
    LotiSightSingingPlugin().getStatus().then((value) {
      if (mounted) setState(() => _status = value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        title: const Text('Loti 音乐视唱插件'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF1A1A1A),
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: const Color(0xFFE5E7EF)),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _heroCard(),
          const SizedBox(height: 16),
          _sectionTitle('版本与定价'),
          _pricingCard(
            title: '测试版',
            price: '¥9.9',
            desc: '验证 Flutter 接入与产品方向，含占位 SDK 与说明文档。',
          ),
          _pricingCard(
            title: '年度授权版',
            price: '¥7,999 / 年',
            desc: '正式商用 SDK、年度更新、技术支持与授权证书。',
            highlighted: true,
          ),
          _pricingCard(
            title: '源码交付 · 可编程版',
            price: '¥19,998',
            desc: '完整 Flutter 源码，UI 与业务可二次开发，含接入指导。',
          ),
          const SizedBox(height: 8),
          _sectionTitle('收款信息'),
          _paymentCard(),
          const SizedBox(height: 16),
          _sectionTitle('插件状态'),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE5E7EF)),
            ),
            child: Text(
              _status,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF4A5568),
                fontFamily: 'Consolas',
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            '© 杭州数掌科技有限公司 · 本示例为产品预览，完整功能按授权版本交付',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  Widget _heroCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EF)),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Loti · 基于 Flutter 生态的音乐视唱插件',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1A1A1A),
            ),
          ),
          SizedBox(height: 10),
          Text(
            'MIDI 跟唱 · 实时音高检测 · KTV 风格打分 · iPad 教室场景优化',
            style: TextStyle(fontSize: 14, color: Color(0xFF4A5568), height: 1.5),
          ),
          SizedBox(height: 10),
          Text(
            '当前仓库为公开预览占位工程。完整 MIDI 解析、跟唱打分等能力在购买对应版本后交付。',
            style: TextStyle(fontSize: 13, color: Color(0xFF788698), height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, top: 4),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Color(0xFF1A1A1A),
        ),
      ),
    );
  }

  Widget _pricingCard({
    required String title,
    required String price,
    required String desc,
    bool highlighted = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: highlighted ? const Color(0xFFF5F6F8) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: highlighted ? const Color(0xFF1A1A1A) : const Color(0xFFE5E7EF),
          width: highlighted ? 1.5 : 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  desc,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF788698),
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Text(
            price,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: highlighted ? const Color(0xFF1A1A1A) : const Color(0xFF4A5568),
            ),
          ),
        ],
      ),
    );
  }

  Widget _paymentCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              'assets/payment-qr.png',
              width: 240,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            '嘉联支付 · 欢迎扫码付款',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'loti科技插件',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFFE67E22),
            ),
          ),
          const SizedBox(height: 12),
          const _PayRow(label: '收款编号', value: 'No.EQR1702454'),
          const SizedBox(height: 8),
          const _PayRow(
            label: '支持方式',
            value: '微信 · 支付宝 · 银联 · 云闪付',
          ),
          const SizedBox(height: 8),
          const _PayRow(label: '客服电话', value: '952005'),
          const SizedBox(height: 8),
          const _PayRow(label: '法律主体', value: '杭州数掌科技有限公司'),
          const SizedBox(height: 12),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '付款备注：Loti视唱插件 + 版本 + 联系人 + 手机',
              style: TextStyle(fontSize: 12, color: Color(0xFF788698)),
            ),
          ),
        ],
      ),
    );
  }
}

class _PayRow extends StatelessWidget {
  const _PayRow({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 72,
          child: Text(
            label,
            style: const TextStyle(fontSize: 13, color: Color(0xFF788698)),
          ),
        ),
        Expanded(
          child: SelectableText(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1A1A1A),
            ),
          ),
        ),
      ],
    );
  }
}
