import 'package:e_learning/constant/assets.dart';
import 'package:e_learning/core/colors/app_colors.dart';
import 'package:e_learning/core/style/app_padding.dart';
import 'package:e_learning/core/style/app_text_styles.dart';
import 'package:e_learning/features/home/presentation/widgets/articles_section.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ArticleDetailsPage extends StatelessWidget {
  const ArticleDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("news".tr()),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: AppPadding.appPadding,
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(height: 38),
                SizedBox(
                  width: double.infinity,
                  height: 240.h,
                  child: Image.asset(
                    Assets.resourceImagesPngHomeeBg,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 32),
                Text(
                  'Cloud vs. On-Premises: Infrastructure for the Evolving Data Center',
                  style: AppTextStyles.s18w600
                      .copyWith(fontWeight: FontWeight.w900),
                ),
                SizedBox(height: 24),
                Text(
                  ''' Every few years, it seems, the pendulum swings between the public cloud and on-premises data centers. 
          Recently, the cloud has largely dominated, with organizations rapidly deploying cloud-hosted artificial intelligence applications. However, we're already starting to see the limitations of this approach. As business and IT leaders increasingly seek to bring AI models to their data (rather than pushing their data out to AI models), there is a growing need for infrastructure at the edge of the enterprise network. 
          This rapid change creates a significant challenge for organizations: How can they build data center facilities meant to last for decades when the technology landscape changes every few years? 
          The answer lies in modularity. By outfitting facilities with modular (and sometimes custom) infrastructure, organizations can future proof their data centers and prepare for continued changes in the IT landscape over the coming decades. ''',
                  style: AppTextStyles.s14w500
                      .copyWith(color: AppColors.blackText),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                          color: AppColors.overLay,
                          borderRadius: BorderRadius.circular(16)),
                      child: Text(
                        'academic_guidance'.tr(),
                        style: AppTextStyles.s14w500
                            .copyWith(color: AppColors.primaryTextColor),
                      ),
                    ),
                    Text(
                      '10 Oct, 2025',
                      style: AppTextStyles.s14w500
                          .copyWith(color: AppColors.primaryTextColor),
                    ),
                  ],
                ),
                SizedBox(height: 64),
                Text(
                  'related_news'.tr(),
                  style: AppTextStyles.s16w600
                      .copyWith(fontWeight: FontWeight.w900),
                ),
                SizedBox(height: 24),
              ]),
            ),
          ),
          const ArticlesSection(
            itemsForShow: 3,
          ),
        ],
      ),
    );
  }
}
