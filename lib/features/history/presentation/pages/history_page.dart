import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import '../bloc/history_bloc.dart';
import '../../../../injection_container.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/view.dart';
import '../widgets/history_item.dart';

class HistoryPage extends StatelessWidget {
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
                'Riwayat',
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

  Widget _history() {
    return BlocBuilder<HistoryBloc, HistoryState>(
      builder: (context, state) {
        print(state);
        if (state is HistoryInitial) {
          BlocProvider.of<HistoryBloc>(context).add(LoadHistoryEvent());
        }
        if (state is LoadingHistory) {
          EasyLoading.show();
        }
        if (state is LoadErrorHistory) {
          print('Load Error');
          EasyLoading.dismiss();
        }
        if (state is LoadedHistory) {
          EasyLoading.dismiss();
          return SliverFixedExtentList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return HistoryItem(
                    history: state.history[index],
                    action: () => Navigator.of(context).pushNamed('/detail'));
              },
              childCount: state.history.length,
            ),
            itemExtent: View.y * 18,
          );
        }
        return SliverToBoxAdapter(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<HistoryBloc>(),
      child: BlocBuilder<HistoryBloc, HistoryState>(
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: () async =>
                BlocProvider.of<HistoryBloc>(context).add(LoadHistoryEvent()),
            child: Container(
              color: AppColors.primary,
              child: CustomScrollView(
                slivers: [
                  _title(),
                  _history(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
