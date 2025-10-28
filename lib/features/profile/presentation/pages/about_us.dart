import 'package:e_learning/core/themes/theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:url_launcher/url_launcher.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  // Future<void> _launchUrl(String url) async {
  //   final Uri uri = Uri.parse(url);
  //   if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
  //     throw Exception('Could not launch $url');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final colors =context.colors;
    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.background,
        elevation: 1,
        // centerTitle: true,
        title: Text(
          'About Us',
          style: GoogleFonts.poppins(
            color: colors.textBlue,
            fontWeight: FontWeight.w600,
            fontSize: 22,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color.fromARGB(255, 178, 202, 232),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Section(
              icon: Icons.school_rounded,
              title: "About the App",
              description:
                  "E-Learning is an online platform that connects students with expert tutors and offers a wide range of courses tailored to your learning goals.",
            ),
            const SizedBox(height: 20),
            Section(
              icon: Icons.lightbulb_outline_rounded,
              title: "Vision & Mission",
              description:
                  "Our mission is to make quality education accessible to everyone. We believe in empowering learners worldwide through innovation and technology.",
            ),
            const SizedBox(height: 20),
            Section(
              icon: Icons.group_rounded,
              title: "Our Team",
              description:
                  "Our diverse team of educators, engineers, and designers is committed to delivering the best learning experience possible.",
            ),
            const SizedBox(height: 20),
            Section(
              icon: Icons.security_rounded,
              title: "Our Values",
              description:
                  "We prioritize trust, transparency, and continuous improvement to ensure a safe and inspiring learning environment.",
            ),

            SizedBox(height: 24),
             Divider(height: 40, thickness: 1,color: colors.dividerGrey,),
            Text(
              "Contact Us",
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: colors.textPrimary,
              ),
            ),
            const SizedBox(height: 16),

            _buildContactTile(
              icon: Icons.email_rounded,
              label: "support@deyram.com",
              onTap: () {},
              context: context
            ),
            const SizedBox(height: 12),

            _buildContactTile(
              icon: Icons.phone_rounded,
              label: "+1 555 123 4567",
              onTap: (){},
               context: context
            ),
            const SizedBox(height: 12),

            _buildContactTile(
              icon: Icons.language_rounded,
              label: "Visit our Website",
              onTap: () {},
               context: context
            ),
            const SizedBox(height: 12),

            _buildContactTile(
              icon: Icons.chat_rounded,
              label: "Chat on WhatsApp",
              onTap: () {},
               context: context
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}

class Section extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const Section({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        color: context.colors.buttonTapNotSelected,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black12.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: context.colors.buttonTapNotSelected,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: context.colors.textBlue),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: context.colors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: GoogleFonts.poppins(
                    fontSize: 14.5,
                    color: context.colors.textGrey,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _buildContactTile({
  required IconData icon,
  required String label,
  required VoidCallback onTap,
  required BuildContext  context,
}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(14),
    child: Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: context.colors.buttonTapNotSelected,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: context.colors.buttonTapNotSelected),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(36, 0, 0, 0),
            offset: Offset(5, 5),
            blurRadius: 15,
            spreadRadius: 1,
          ),
          // BoxShadow(
          //   color: context.colors.textWhite,
          //   offset: Offset(-5, -5),
          //   blurRadius: 15,
          //   spreadRadius: 1,
          // ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: context.colors.textBlue, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 15,
                color: context.colors.textGrey,
              ),
            ),
          ),
          Icon(
            Icons.arrow_forward_ios_rounded,
            color: context.colors.textGrey,
            size: 16,
          ),
        ],
      ),
    ),
  );
}
