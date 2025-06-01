import 'package:coingecko/core/ui/molecules/coin_selected_widget.dart';
import 'package:coingecko/core/ui/molecules/custom_appbar.dart';
import 'package:coingecko/feature/coin_details/presentation/bloc/coin_details_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CoinDetailsAppbar extends StatelessWidget implements PreferredSizeWidget {
  final CoinDetailsBloc bloc;
  final VoidCallback? onPressedBack;
  const CoinDetailsAppbar({super.key, required this.bloc, this.onPressedBack});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: BlocBuilder<CoinDetailsBloc, CoinDetailsState>(
        builder: (context, state) {
          final bloc = context.read<CoinDetailsBloc>();
          return CustomAppbar(
            title: "",
            onPressedBack: onPressedBack,
            mainWidget: CoinSelectedWidget(
              height: kIsWeb ? 90 : 70,
              imageUrl: bloc.coinItemEntity?.image?.small ?? "",
              name: bloc.coinItemEntity?.name ?? "",
              symbol: bloc.coinItemEntity?.symbol ?? "",
            ),
          );
        },
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(70.h);
}
