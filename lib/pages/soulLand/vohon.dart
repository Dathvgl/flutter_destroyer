import 'package:flutter/material.dart';
import 'package:flutter_destroyer/models/soulland/tutiens.dart';
import 'package:flutter_destroyer/models/soulland/vohons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class VoHonPage extends StatefulWidget {
  const VoHonPage({super.key});

  @override
  State<VoHonPage> createState() => _VoHonPageState();
}

class _VoHonPageState extends State<VoHonPage> {
  void taovohon(int index) {
    context.read<TuTien>().updateVoHon(index);
  }

  void customDialog() {
    showDialog(
      context: context,
      builder: (_) => const HuongDanVoHon(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Võ Hồn',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.cyan,
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 10.0,
            ),
            child: IconButton(
              onPressed: customDialog,
              icon: const FaIcon(
                FontAwesomeIcons.circleQuestion,
              ),
            ),
          )
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                child: ThuVoHon(
                  vohon: context.watch<TuTien>().vohon,
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              ThucTinhVoHon(
                callback: taovohon,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HuongDanVoHon extends StatefulWidget {
  const HuongDanVoHon({super.key});

  @override
  State<HuongDanVoHon> createState() => _HuongDanVoHonState();
}

class _HuongDanVoHonState extends State<HuongDanVoHon> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(32.0)),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              textAlign: TextAlign.justify,
              text: const TextSpan(
                style: TextStyle(
                  fontSize: 20.0,
                ),
                children: [
                  TextSpan(
                    text: 'Game Idle này tạo dựa trên tiểu thuyết ',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: 'ĐẤU LA ĐẠI LỤC',
                    style: TextStyle(
                      color: Color(0xFFB71C1C),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const Text('\n'),
            RichText(
              textAlign: TextAlign.justify,
              text: const TextSpan(
                style: TextStyle(
                  fontSize: 20.0,
                  // fontFamily: 'Satisfy',
                ),
                children: [
                  TextSpan(
                    text:
                        'Nơi đây không có ma pháp, không có đấu khí, cũng không có võ thuật, chỉ có duy nhất thứ gọi là ',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: 'Võ Hồn',
                    style: TextStyle(
                      color: Color(0xFF0D47A1),
                      fontWeight: FontWeight.bold,
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
}

class ThucTinhVoHon extends StatelessWidget {
  final Function callback;

  const ThucTinhVoHon({
    super.key,
    required this.callback,
  });

  @override
  Widget build(BuildContext context) {
    int honluc = context.watch<TuTien>().honluc.honluc;
    VoHon vohon = context.read<TuTien>().vohon;
    String hienthi = '${VoHon.honhieu[vohon.capdo]} ${vohon.phamchat}';

    if (honluc > 0) {
      return Column(
        children: [
          Text(
            hienthi,
            style: const TextStyle(
              fontSize: 30.0,
              color: Colors.blue,
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          SizedBox(
            width: 350.0,
            height: 10.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: const LinearProgressIndicator(
                value: 0.0,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                backgroundColor: Colors.lightBlue,
              ),
            ),
          )
        ],
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue.shade300,
            shape: const CircleBorder(),
            fixedSize: const Size(100, 100),
          ),
          onPressed: () => callback(0),
          child: const Text(
            'Thức tỉnh khí võ hồn',
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          width: 20.0,
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange.shade900,
            shape: const CircleBorder(),
            fixedSize: const Size(100, 100),
          ),
          onPressed: () => callback(1),
          child: const Text(
            'Thức tỉnh thú võ hồn',
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

class ThuVoHon extends StatelessWidget {
  final VoHon vohon;

  const ThuVoHon({
    super.key,
    required this.vohon,
  });

  @override
  Widget build(BuildContext context) {
    if (vohon.ten == '') {
      return const Text(
        'Chưa thức tỉnh võ hồn',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 30.0,
        ),
      );
    }
    return Text(
      vohon.ten,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 30.0,
      ),
    );
  }
}
