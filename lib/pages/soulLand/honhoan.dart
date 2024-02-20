import 'package:flutter/material.dart';
import 'package:flutter_destroyer/components/widget.dart';
import 'package:flutter_destroyer/models/soulland/honhoans.dart';
import 'package:flutter_destroyer/models/soulland/tutiens.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'package:simple_shadow/simple_shadow.dart';

class HonHoanPage extends StatefulWidget {
  const HonHoanPage({super.key});

  @override
  State<HonHoanPage> createState() => _HonHoanPageState();
}

class _HonHoanPageState extends State<HonHoanPage> {
  late int count = -1;
  List<Widget> honhoans = [];

  void taohonhoan() {
    if (!context.read<TuTien>().honluc.dotpha) {
      return;
    }

    context.read<TuTien>().updateHonLucDotPha();

    setState(() {
      if (count + 1 >= HonLinh.honhieu.length) {
        return;
      }

      count++;
      if (honhoans.isNotEmpty) {
        honhoans.add(const SizedBox(
          height: 20.0,
        ));
      }

      context.read<TuTien>().honhoan.thuHonLinh();
      honhoans.add(ChiTietHonHoan(
        count: count,
        honhoan: context.read<TuTien>().honhoan.honlinh[count],
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          controller: ScrollController(),
          children: [
            ...honhoans,
          ],
        ),
        Positioned(
          child: Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: LuaChonHonHoan(
                callback: taohonhoan,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class LuaChonHonHoan extends StatelessWidget {
  final VoidCallback callback;

  LuaChonHonHoan({
    super.key,
    required this.callback,
  });

  final ValueNotifier<bool> isDial = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    void callbackDial() {
      isDial.value = false;
    }

    void customDialog() {
      callbackDial();
      showDialog(
        context: context,
        builder: (_) => const ChinhHonHoan(),
      );
    }

    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      renderOverlay: false,
      closeManually: true,
      openCloseDial: isDial,
      children: [
        SpeedDialChild(
          onTap: () {
            callbackDial();
            callback();
          },
          child: const Icon(Icons.add),
          backgroundColor: Colors.red,
        ),
        SpeedDialChild(
          onTap: customDialog,
          child: const Icon(Icons.rule),
          backgroundColor: Colors.amber,
        ),
      ],
    );
  }
}

class ChiTietHonHoan extends StatelessWidget {
  final int count;
  final HonLinh honhoan;

  final double leftTSHH = 135.0;

  const ChiTietHonHoan({
    super.key,
    required this.count,
    required this.honhoan,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green.shade100,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 20.0,
            ),
            child: ThongTinCongPhap(
              honhoan: context.watch<TuTien>().honhoan.honlinh[count],
            ),
          ),
          Positioned(
            bottom: 20.0,
            left: leftTSHH,
            child: ThongSoHonHoan(
              count: count,
              leftTSHH: leftTSHH,
            ),
          ),
        ],
      ),
    );
  }
}

class ThongTinCongPhap extends StatelessWidget {
  final HonLinh honhoan;

  const ThongTinCongPhap({
    super.key,
    required this.honhoan,
  });

  final TextStyle style = const TextStyle(
    fontSize: 20.0,
  );

  Image anhHonHoan() {
    if (honhoan.capdo + 1 == HonLinh.honmau.length) {
      return Image.asset(
        HonLinh.honanh[honhoan.capdo],
      );
    }

    return Image.asset(
      HonLinh.honanh[honhoan.capdo],
      color: HonLinh.honmau[honhoan.capdo],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            SizedBox.square(
              dimension: 120.0,
              child: SimpleShadow(
                opacity: 1.0,
                color: HonLinh.honmau[honhoan.capdo],
                sigma: 10.0,
                child: anhHonHoan(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 10.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    HonLinh.honten[honhoan.capdo],
                    style: style,
                  ),
                  Text(
                    'Năm: ${honhoan.sonam}',
                    style: style,
                  ),
                  Text(
                    honhoan.tenhon,
                    style: style,
                  ),
                ],
              ),
            ),
          ],
        ),
        Text(
          'Hệ số: ${honhoan.heso.toInt()}',
          style: style,
        ),
      ],
    );
  }
}

class ThongSoHonHoan extends StatelessWidget {
  final int count;
  final double leftTSHH;

  const ThongSoHonHoan({
    super.key,
    required this.count,
    required this.leftTSHH,
  });

  @override
  Widget build(BuildContext context) {
    double capnhatTuLuyen(double honkhi) {
      HonLinh honlinh = context.read<TuTien>().honhoan.honlinh[count];

      int kinhnghiem = honlinh.capDo();
      double progress = honkhi / kinhnghiem;

      if (progress > 1.0) {
        progress = 1.0;
      }

      if (progress < 0.0) {
        progress = 0.0;
      }

      if (!honlinh.tangnam) {
        return progress;
      }

      if (honkhi >= kinhnghiem.toDouble()) {
        if (honlinh.honSu()) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            context.read<TuTien>().updateHonHoanDotPha(count);
          });
          return progress;
        }

        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          context.read<TuTien>().updateHonHoan(count);
        });
        progress = 0;
      }
      return progress;
    }

    double widthSized(double extra) {
      double basePadding = 20.0;
      double screenW = MediaQuery.of(context).size.width;
      return screenW - basePadding - extra;
    }

    return SizedBox(
      width: widthSized(leftTSHH),
      height: 15.0,
      child: PercentProgressBar(
        textSize: 12.0,
        progress: capnhatTuLuyen(
          context.watch<TuTien>().honhoan.honlinh[count].honkhi,
        ),
      ),
    );
  }
}

class ChinhHonHoan extends StatelessWidget {
  const ChinhHonHoan({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> listTiles() {
      List<Widget> widgets = <Widget>[];

      List<HonLinh> honlinh = context.read<TuTien>().honhoan.honlinh;
      int n = honlinh.length;

      for (var i = 0; i < n; i++) {
        if (i != 0 || i == n - 1) {
          widgets.add(const Divider(
            thickness: 2,
            color: Colors.black,
          ));
        }

        widgets.add(ChinhTietHonLinh(
          count: i,
          honlinh: honlinh[i],
        ));
      }
      return widgets;
    }

    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(32.0)),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Phân tu hồn hoàn',
              style: TextStyle(
                fontSize: 30.0,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            ...listTiles()
          ],
        ),
      ),
    );
  }
}

class ChinhTietHonLinh extends StatelessWidget {
  final int count;
  final HonLinh honlinh;

  const ChinhTietHonLinh({
    super.key,
    required this.count,
    required this.honlinh,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(honlinh.tenhon),
        TichHonLinh(
          count: count,
        ),
      ],
    );
  }
}

class TichHonLinh extends StatelessWidget {
  final int count;

  const TichHonLinh({
    super.key,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: context.watch<TuTien>().honhoan.honlinh[count].tangnam,
      onChanged: (bool? value) {
        if (value != null) {
          context.read<TuTien>().updateTichHonLinh(count, value);
        }
      },
    );
  }
}
