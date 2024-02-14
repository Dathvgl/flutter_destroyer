import 'package:flutter/material.dart';
import 'package:flutter_destroyer/components/widget.dart';
import 'package:flutter_destroyer/models/soulland/congphaps.dart';
import 'package:flutter_destroyer/models/soulland/tutiens.dart';
import 'package:provider/provider.dart';

class CongPhapPage extends StatefulWidget {
  const CongPhapPage({super.key});

  @override
  State<CongPhapPage> createState() => _CongPhapPageState();
}

class _CongPhapPageState extends State<CongPhapPage> {
  List<Widget> listTiles() {
    List<Widget> widgets = <Widget>[];

    List<CoSoChung> congphaps =
        context.read<TuTien>().congphap.huyenThienBaoLuc;
    int n = congphaps.length;

    for (var i = 0; i < n; i++) {
      if (i != 0 || i == n - 1) {
        widgets.add(const Divider());
      }

      widgets.add(ChiTietCongPhap(
        congphap: congphaps[i],
      ));
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Công Pháp',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.green,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: ListView(
              controller: ScrollController(),
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                  ),
                  child: Center(
                    child: Text(
                      context.read<TuTien>().congphap.bophap,
                      style: const TextStyle(
                        fontSize: 30.0,
                        color: Colors.deepPurpleAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const Divider(),
                ...listTiles(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChiTietCongPhap extends StatelessWidget {
  final CoSoChung congphap;

  const ChiTietCongPhap({
    super.key,
    required this.congphap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TuCongPhap(
            congphap: congphap,
          ),
        ],
      ),
    );
  }
}

class TuCongPhap extends StatelessWidget {
  final CoSoChung congphap;

  const TuCongPhap({
    super.key,
    required this.congphap,
  });

  @override
  Widget build(BuildContext context) {
    switch (congphap.id) {
      case HuyenThienCong.dacthu:
        congphap.canhGioi(context.watch<TuTien>().honluc.honluc);
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${congphap.ten}: ${congphap.canhgioi}'),
            Text('Hệ số: ${congphap.heso}'),
          ],
        );
      case TuCucMaDong.dacthu:
        congphap.canhGioi(context.watch<TuTien>().tinhthanluc.tinhthanluc);
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${congphap.ten}: ${congphap.canhgioi}'),
            Text('Hệ số: ${congphap.heso.toInt().toStringAsExponential(2)}'),
          ],
        );
      default:
        double exp = context
            .read<TuTien>()
            .congphap
            .luotCongPhap(context.watch<TuTien>().congphap.honkhi);

        double tuCongPhap(double honkhi) {
          CongPhap congphaps = context.read<TuTien>().congphap;

          CoSoChung cosochung = congphaps.huyenThienBaoLuc[congphap.id];
          if (cosochung == congphaps.huyenThienBaoLuc.last) {
            congphaps.honkhi = 0.0;
          }

          double progress = cosochung.linhngo / cosochung.kinhnghiem;

          if (progress > 1.0) {
            progress = 1.0;
          }

          if (progress < 0.0) {
            progress = 0.0;
          }

          cosochung.linhngo += honkhi;
          if (cosochung.kinhNghiem()) {
            cosochung.canhGioi(exp);
            progress = 0;

            congphaps.thayHeSo();
          }
          return progress;
        }

        Text heso() {
          if (congphap.heso < 1.0) {
            return Text('Hệ số: ${congphap.heso.toStringAsFixed(2)}');
          }
          return Text('Hệ số: ${congphap.heso.toInt()}');
        }

        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${congphap.ten}: Cấp ${congphap.capdo}'),
                heso(),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            ThanhTuLuyen(
              exp: context
                  .watch<TuTien>()
                  .congphap
                  .huyenThienBaoLuc[congphap.id]
                  .linhngo,
              progress: tuCongPhap(exp),
            ),
          ],
        );
    }
  }
}

class ThanhTuLuyen extends StatelessWidget {
  final double exp;
  final double progress;

  const ThanhTuLuyen({
    super.key,
    required this.exp,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 15.0,
      child: PercentProgressBar(
        textSize: 12.0,
        progress: progress,
      ),
    );
  }
}
