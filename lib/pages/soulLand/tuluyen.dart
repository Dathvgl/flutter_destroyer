import 'package:flutter/material.dart';
import 'package:flutter_destroyer/components/widget.dart';
import 'package:flutter_destroyer/models/soulland/honlucs.dart';
import 'package:flutter_destroyer/models/soulland/tinhthanlucs.dart';
import 'package:flutter_destroyer/models/soulland/tutiens.dart';
import 'package:provider/provider.dart';

class TuLuyenPage extends StatefulWidget {
  const TuLuyenPage({super.key});

  @override
  State<TuLuyenPage> createState() => _TuLuyenPageState();
}

class _TuLuyenPageState extends State<TuLuyenPage> {
  double tuHonLuc(double honkhi) {
    HonLuc honluc = context.read<TuTien>().honluc;
    double progress = honkhi / honluc.capDo();

    if (progress > 1.0) {
      progress = 1.0;
    }

    if (progress < 0.0) {
      progress = 0.0;
    }

    if (context.read<TuTien>().honluc.dotpha) {
      return progress;
    }

    if (honluc.kinhNghiem(honkhi)) {
      if (honluc.honSu()) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          context.read<TuTien>().updateHonLucDotPha();
        });
        return progress;
      }

      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        context.read<TuTien>().updateHonLuc();
      });
      progress = 0;
    }
    return progress;
  }

  double tuTinhThanLuc(double honkhi) {
    TinhThanLuc tinhthanluc = context.read<TuTien>().tinhthanluc;
    double progress = honkhi / tinhthanluc.capDo();

    // if (context.read<TuTien>().honluc.dotpha) {
    //   return progress;
    // }

    if (progress > 1.0) {
      progress = 1.0;
    }

    if (progress < 0.0) {
      progress = 0.0;
    }

    if (tinhthanluc.kinhNghiem(honkhi)) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        context.read<TuTien>().updateTinhThanLuc();
      });
      progress = 0;
    }
    return progress;
  }

  @override
  Widget build(BuildContext context) {
    HonLuc honluc = context.watch<TuTien>().honluc;
    TinhThanLuc tinhthanluc = context.watch<TuTien>().tinhthanluc;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Tu Luyện',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 30.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/honSu/meditation.png',
                  width: 250.0,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Center(
                  child: Text(
                    context.read<TuTien>().honsu,
                    style: const TextStyle(
                      fontSize: 40.0,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CapTuLuyen(
                        exp: honluc.honluc,
                        name: context.read<TuTien>().honluc.tangcap,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Center(
                        child: SizedBox(
                          width: double.infinity,
                          height: 35.0,
                          child: PercentProgressBar(
                            textSize: 20.0,
                            progress: tuHonLuc(honluc.honkhi),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      CapTuLuyen(
                        exp: tinhthanluc.tinhthanluc,
                        name: context.read<TuTien>().tinhthanluc.tangcap,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Center(
                        child: SizedBox(
                          width: double.infinity,
                          height: 35.0,
                          child: ThanhTuLuyen(
                            color: TinhThanLuc.honsuMau[TinhThanLuc.capdo],
                            progress: tuTinhThanLuc(tinhthanluc.honkhi),
                            backColor: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CapTuLuyen extends StatelessWidget {
  final int exp;
  final Function name;

  const CapTuLuyen({
    super.key,
    required this.exp,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      '${name(exp)}: $exp',
      style: const TextStyle(
        fontSize: 25.0,
      ),
    );
  }
}

class ThanhTuLuyen extends StatelessWidget {
  final Color color;
  final Color backColor;
  final double progress;

  const ThanhTuLuyen({
    super.key,
    required this.color,
    required this.backColor,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    bool check = color == Colors.white ||
        color == Colors.amber ||
        color == Colors.lime ||
        color == Colors.yellow.shade300;

    return PercentProgressBar(
      textSize: 20.0,
      textColor: check ? Colors.black : Colors.white,
      progress: progress,
      progressColor: color,
      backgroundColor: backColor,
    );
  }
}
