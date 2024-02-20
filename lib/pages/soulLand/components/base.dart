import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_destroyer/models/soulland/tutiens.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';

class LuaChonTuLuyen extends StatefulWidget {
  const LuaChonTuLuyen({super.key});

  @override
  State<LuaChonTuLuyen> createState() => _LuaChonTuLuyenState();
}

class _LuaChonTuLuyenState extends State<LuaChonTuLuyen> {
  final ValueNotifier<bool> isDial = ValueNotifier(false);

  Timer? tutien;

  void callbackDial() {
    isDial.value = false;
  }

  void thayTuLuyen() {
    if (context.read<TuTien>().vohon.ten == '') {
      return;
    }

    context.read<TuTien>().updateTuLuyen();
    tuHonkhi(context.read<TuTien>().tuluyen);
  }

  void tuHonkhi(bool tuluyen) {
    if (!tuluyen) {
      tutien?.cancel();
      return;
    }

    const interval = Duration(milliseconds: 50);
    tutien = Timer.periodic(interval, (Timer t) {
      context.read<TuTien>().updateHonKhi();
      context.read<TuTien>().updatePhamVoHon();
    });
  }

  void customDialog() {
    callbackDial();
    showDialog(
      context: context,
      builder: (_) => const ChinhTuLuyen(),
    );
  }

  void resetDialog() {
    callbackDial();
    showDialog(
      context: context,
      builder: (_) => const LaiTuLuyen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      renderOverlay: false,
      closeManually: true,
      openCloseDial: isDial,
      children: [
        SpeedDialChild(
          child: KhoiDongTuLuyen(
            callback: thayTuLuyen,
          ),
          backgroundColor: Colors.blue,
        ),
        SpeedDialChild(
          onTap: customDialog,
          child: const Icon(Icons.settings),
          backgroundColor: Colors.blue,
        ),
        SpeedDialChild(
          onTap: resetDialog,
          child: const Icon(Icons.close),
          backgroundColor: Colors.blue,
        ),
      ],
    );
  }
}

class KhoiDongTuLuyen extends StatelessWidget {
  final VoidCallback callback;

  const KhoiDongTuLuyen({
    super.key,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: callback,
      child: context.watch<TuTien>().tuluyen
          ? const Icon(Icons.pause)
          : const Icon(Icons.play_arrow),
    );
  }
}

class ChinhTuLuyen extends StatefulWidget {
  const ChinhTuLuyen({super.key});

  @override
  State<ChinhTuLuyen> createState() => _ChinhTuLuyenState();
}

class _ChinhTuLuyenState extends State<ChinhTuLuyen> {
  double maxSlider = 1.0;

  @override
  Widget build(BuildContext context) {
    List<double> slider = context.read<TuTien>().phanHonKhi;

    double allSlider() {
      double sum = slider[0] + slider[1] + slider[2] + slider[3];
      return double.parse(sum.toStringAsFixed(1));
    }

    void callbackSlider(index, rate) {
      setState(() {
        slider[index] = rate;
        context.read<TuTien>().updatePhanHonKhi(index, rate);
      });
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
              'Phân chia hồn khí',
              style: TextStyle(
                fontSize: 30.0,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Hồn lực'),
                ThanhPhanChia(
                  slider: 0,
                  honkhi: slider[0],
                  tongHonkhi: allSlider(),
                  maxHonkhi: maxSlider,
                  callback: callbackSlider,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Tinh thần lực'),
                ThanhPhanChia(
                  slider: 1,
                  honkhi: slider[1],
                  tongHonkhi: allSlider(),
                  maxHonkhi: maxSlider,
                  callback: callbackSlider,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Công pháp'),
                ThanhPhanChia(
                  slider: 2,
                  honkhi: slider[2],
                  tongHonkhi: allSlider(),
                  maxHonkhi: maxSlider,
                  callback: callbackSlider,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Hồn hoàn'),
                ThanhPhanChia(
                  slider: 3,
                  honkhi: slider[3],
                  tongHonkhi: allSlider(),
                  maxHonkhi: maxSlider,
                  callback: callbackSlider,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ThanhPhanChia extends StatelessWidget {
  final int slider;
  final double? honkhi;
  final double tongHonkhi;
  final double maxHonkhi;
  final Function(int, double) callback;

  const ThanhPhanChia({
    super.key,
    required this.slider,
    required this.honkhi,
    required this.tongHonkhi,
    required this.maxHonkhi,
    required this.callback,
  });

  void sliderHonkhi(double rate) {
    if (tongHonkhi < maxHonkhi) {
      callback(slider, rate);
      return;
    }

    if (tongHonkhi - honkhi! + rate < maxHonkhi) {
      callback(slider, rate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Slider(
      min: 0.0,
      max: maxHonkhi,
      divisions: 10,
      value: honkhi!,
      label: '$honkhi',
      onChanged: (rate) {
        sliderHonkhi(rate);
      },
    );
  }
}

class LaiTuLuyen extends StatelessWidget {
  const LaiTuLuyen({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(32.0)),
      ),
      title: const Text(
        'Trở lại làm tân thủ',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: const Text(
        'Khi nhấn thì tất cả tu vi sẽ mất',
        textAlign: TextAlign.justify,
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(
            bottom: 10.0,
            right: 10.0,
          ),
          child: TextButton(
            onPressed: () {
              context.read<TuTien>().updateReset();
              Navigator.pop(context, true);
            },
            child: const Text(
              'Chấp nhận?',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
