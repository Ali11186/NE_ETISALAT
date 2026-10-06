import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../theme/app_theme.dart';

class RewardsScreen extends StatelessWidget {
  const RewardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppProvider>();

    final rewards = [
      (500, 'باقة إنترنت صغيرة', Icons.wifi),
      (1000, 'رصيد إضافي', Icons.account_balance_wallet_outlined),
      (2000, 'باقة إنترنت كبيرة', Icons.public),
    ];

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 110),
      children: [
        const Text(
          'المكافآت',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'رصيدك المتاح: ${app.points} نقطة',
          style: const TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 22),
        ...rewards.map(
          (reward) => Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 8,
              ),
              leading: CircleAvatar(
                backgroundColor: AppTheme.cyan.withOpacity(.14),
                child: Icon(reward.$3, color: AppTheme.blue),
              ),
              title: Text(
                reward.$2,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('${reward.$1} نقطة'),
              trailing: FilledButton(
                onPressed: app.points >= reward.$1
                    ? () {
                        final ok = app.redeem(reward.$1);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              ok
                                  ? 'تم تسجيل طلب الاستبدال بنجاح'
                                  : 'الرصيد غير كافٍ',
                            ),
                          ),
                        );
                      }
                    : null,
                child: const Text('استبدال'),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.amber.withOpacity(.12),
            borderRadius: BorderRadius.circular(18),
          ),
          child: const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.info_outline, color: Colors.amber),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'هذه نسخة تجريبية. لا يتم تنفيذ أي طلب خارجي أو خصم حقيقي من حسابك.',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
