import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:power_monitor_app/core/auth/presentation/bloc/auth_bloc.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/view.dart';

class ProfilePage extends StatelessWidget {
  Widget _changeNameDialog(BuildContext context) {
    final name = TextEditingController();
    return AlertDialog(
      content: Container(
        width: double.infinity,
        height: View.y * 23,
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Masukkan nama',
              ),
              controller: name,
            ),
            Container(
              margin: EdgeInsets.only(top: View.y * 3),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.all(View.x * 2),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.button,
                        borderRadius: BorderRadius.circular(View.x * 2),
                      ),
                      child: TextButton(
                        onPressed: () {
                          BlocProvider.of<AuthBloc>(context)
                              .add(ChangeNameEvent(name: name.text));
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Simpan',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.all(View.x * 2),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.redAccent.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(View.x * 2),
                      ),
                      child: TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(
                          'Batal',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

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
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        print(state);
        if (state is AuthLoading) {
          EasyLoading.show();
        }
        if (state is LogoutSuccess) {
          EasyLoading.dismiss();
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/login', (route) => false);
        }
      },
      child: Container(
        color: AppColors.primary,
        child: CustomScrollView(
          slivers: [
            _title(),
            _profilePageItem(
              icon: Icons.person,
              action: () => showDialog(
                context: context,
                builder: (context) => _changeNameDialog(context),
              ),
              hint: 'Ubah nama',
            ),
            _profilePageItem(
              icon: Icons.lock,
              action: () => null,
              hint: 'Ganti password',
            ),
            _profilePageItem(
              icon: Icons.logout,
              action: () =>
                  BlocProvider.of<AuthBloc>(context).add(SignOutEvent()),
              hint: 'Keluar',
            ),
          ],
        ),
      ),
    );
  }
}
