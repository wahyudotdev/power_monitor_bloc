import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/view.dart';
import '../../../login/presentation/pages/login_page.dart';

class ProfilePage extends StatelessWidget {
  Widget _title() {
    return SliverToBoxAdapter(
      child: Container(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              alignment: Alignment.topRight,
              child: SvgPicture.asset('assets/bubble.svg'),
            ),
            Container(
              margin: EdgeInsets.only(
                left: View.x * 5,
                top: View.y * 5,
              ),
              child: Text(
                'Profil',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: View.x * 6,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _profilePageItem({
    required IconData icon,
    required String hint,
    required VoidCallback action,
  }) {
    return SliverToBoxAdapter(
      child: InkWell(
        onTap: action,
        child: Container(
          width: double.infinity,
          height: View.y * 12,
          margin: EdgeInsets.only(
            left: View.x * 5,
            right: View.x * 5,
            top: View.x * 2,
          ),
          decoration: BoxDecoration(
            color: AppColors.notification,
            borderRadius: BorderRadius.circular(View.x * 3),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  child: Icon(
                    icon,
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  child: Text(
                    hint,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: View.x * 5,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,
      child: CustomScrollView(
        slivers: [
          _title(),
          _profilePageItem(
            icon: Icons.person,
            action: () => null,
            hint: 'Ubah nama',
          ),
          _profilePageItem(
            icon: Icons.lock,
            action: () => null,
            hint: 'Ganti password',
          ),
          _profilePageItem(
            icon: Icons.logout,
            action: () => Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => LoginPage())),
            hint: 'Keluar',
          ),
        ],
      ),
    );
  }
}
