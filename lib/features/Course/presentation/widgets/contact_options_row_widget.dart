import 'package:e_learning/core/asset/app_icons.dart';
import 'package:e_learning/features/Course/presentation/widgets/contact_icon_widget.dart';
import 'package:flutter/material.dart';

class ContactOptionsRowWidget extends StatelessWidget {
  const ContactOptionsRowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ContactIconWidget(
          iconPath: AppIcons.iconWhatsApp,
          onTap: () {
            //todo action
          },
          nameApp: 'WhatsApp',
        ),
        ContactIconWidget(
          iconPath: AppIcons.iconTelegram,
          onTap: () {
            //todo action
          },
          nameApp: 'Telegram',
        ),
        ContactIconWidget(
          iconPath: AppIcons.iconGmail,
          onTap: () {
            //todo action
          },
          nameApp: 'Email',
        ),
      ],
    );
  }
}
