import 'dart:io';

import 'package:asgate/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  int slideIndex = 0;
  PageController controller = PageController();
  bool isSmsAllowed = false;

  Widget _buildPageIndicator(bool isCurrentPage) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2.0),
      height: isCurrentPage ? 10.0 : 6.0,
      width: isCurrentPage ? 10.0 : 6.0,
      decoration: BoxDecoration(
        color: isCurrentPage ? Colors.grey : Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // mySLides = getSlides();
  }

  void getSmsPermission() async {
    var smsPermissionStatus = await Permission.sms.status;
    if (smsPermissionStatus.isDenied) {
      await Permission.sms.request();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient:
              LinearGradient(colors: [Color(0xff3C8CE7), Color(0xff00EAFF)])),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SizedBox(
          height: MediaQuery.of(context).size.height - 100,
          child: PageView(
            controller: controller,
            onPageChanged: (index) {
              setState(() {
                slideIndex = index;
              });
            },
            children: <Widget>[
              const Slide01(),
              FutureBuilder(
                future: Permission.sms.isGranted,
                builder: (context, snapshot) =>
                    Slide02(isSmsAllowed: snapshot.data),
              )
            ],
          ),
        ),
        bottomSheet: slideIndex != 1
            ? Container(
                margin: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      children: [
                        for (int i = 0; i < 2; i++)
                          i == slideIndex
                              ? _buildPageIndicator(true)
                              : _buildPageIndicator(false),
                      ],
                    ),
                  ],
                ),
              )
            : const GetStartedButton(),
      ),
    );
  }
}

class Slide02 extends StatelessWidget {
  const Slide02({
    Key? key,
    required this.isSmsAllowed,
  }) : super(key: key);
  final isSmsAllowed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 172,
            width: 172,
            child: SvgPicture.asset('assets/illust/illust02.svg'),
          ),
          const SizedBox(
            height: 40,
          ),
          const Text(
            'SMS Permissions',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text('First we need your permission for sending SMS of course.',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
          const SizedBox(
            height: 20,
          ),
          !isSmsAllowed
              ? TextButton(
                  onPressed: () async {
                    await Permission.sms.request();
                  },
                  child: const Text("Give Permission"))
              : const SizedBox(),
          Text(isSmsAllowed
              ? 'Sending SMS permission is granted.'
              : 'sending sms currently not permitted.'),
        ],
      ),
    );
  }
}

class Slide01 extends StatelessWidget {
  const Slide01({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 172,
            width: 172,
            child: SvgPicture.asset('assets/illust/illust01.svg'),
          ),
          const SizedBox(
            height: 40,
          ),
          const Text(
            'Welcome',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text('ASGate can turn your android phones to SMS gateway.',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14))
        ],
      ),
    );
  }
}

class GetStartedButton extends StatelessWidget {
  const GetStartedButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ));
      },
      child: Container(
        height: Platform.isIOS ? 70 : 60,
        color: Colors.blue,
        alignment: Alignment.center,
        child: const Text(
          "GET STARTED NOW",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
