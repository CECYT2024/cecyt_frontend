import 'package:flutter/material.dart';

class BasePage extends StatelessWidget {
  const BasePage({
    required this.child,
    required this.title,
    this.faButton,
    super.key,
    this.titleInAppBar = false,
    this.appB,
    this.listV = false,
    this.children,
  });
  final Widget child;
  final String title;
  final bool titleInAppBar;
  final AppBar? appB;
  final FloatingActionButton? faButton;

  /// Variable de prueba
  final bool listV;
  final List<Widget>? children;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: SafeArea(
        child: Scaffold(
          floatingActionButton: faButton,
          appBar: titleInAppBar
              ? AppBar(
                  title: Text(
                    title,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  centerTitle: true,
                )
              : appB ?? AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: ListView(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BannerBienvenida(
                  title: titleInAppBar ? null : title,
                ),
                // Expanded(child: child),
                if (listV) ...children! else child
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// : Padding(
//                 padding: const EdgeInsets.all(20),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     BannerBienvenida(
//                       title: titleInAppBar ? null : title,
//                     ),
//                     Expanded(child: child),
//                   ],
//                 ),
//               ),
class BannerBienvenida extends StatelessWidget {
  const BannerBienvenida({this.title, super.key});
  final String? title;

  @override
  Widget build(BuildContext context) {
    const baseWidth = 375;
    final fem = MediaQuery.of(context).size.width / baseWidth;
    final ffem = fem * 0.97;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          // svggGSx (60:769)
          // margin: const EdgeInsets.all(10),
          width: 135.95 * fem,
          height: 128.99 * fem,
          child: const FlutterLogo(),
          // child: SvgPicture.asset(
          //   'assets/logo.svg',
          //   width: 135.95 * fem,
          //   height: 128.99 * fem,
          // ),
        ),
        // margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 17 * fem),
        if (title != null)
          Text(
            title ?? '',
            textAlign: TextAlign.center,
            // style: SafeGoogleFont(
            //   'Oswald',
            //   fontSize: 30 * ffem,
            //   fontWeight: FontWeight.w400,
            //   height: 1.4825 * ffem / fem,
            //   color: const Color(0xffffffff),
            // ),
            style: TextStyle(
              color: const Color(0xffffffff),
              fontWeight: FontWeight.w400,
              height: 1.4825 * ffem / fem,
              fontSize: 30 * ffem,
            ),
          ),
      ],
    );
  }
}
