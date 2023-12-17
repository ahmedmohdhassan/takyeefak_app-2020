import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_linkify/flutter_linkify.dart';

class AboutPage extends StatelessWidget {
  Future<void> _launchUrl(String url) async {
    if (await canLaunch(url)) {
      launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  final String conditionsUrl = 'http://tkyeefk.com/terms.php';
  final String privacyUrl = 'http://tkyeefk.com/privacy.php';
  final String technicalSupportUrl = 'http://tkyeefk.com/support.php';
  final String contactUrl = 'http://tkyeefk.com/contact.php';
  final String siteUrl = 'http://tkyeefk.com';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('عن التطبيق'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 15,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            child: ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              children: <Widget>[
                SizedBox(height: 15),
                AboutBullet(
                  text:
                      'شركة محجوب تكنولوجي هي القائم على تطوير وادارة موقع وتطبيق ( تكييفك )',
                ),
                AboutBullet(
                  text: 'اصدار التطبيق : V 0.0.2',
                ),
                AboutBullet(
                  text:
                      'يعرض التطبيق منتجات أصلية بحالة جديدة بغرض البيع من خلال التعاقد مع المصانع والموردين وشركات التكييف في جميع محافظات مصر و لا يقدم التطبيق خدمات التركيب بصفة اصيلة ولكن من خلال التعاقد مع موردين وشركات متخصصة يتم الاتفاق مع العميل عبر الهاتف على خدمة التركيب .',
                ),
                AboutBullet(
                  text: 'إخلاء المسؤلية : ',
                ),
                AboutBullet(
                  text:
                      '1- جميع المنتجات المباعة عبر تطبيق تكييفك هي منتجات اصلية بحالة جديدة  وبضمان المصنع لا نقدم ضمان خاص اطلاقاً .',
                ),
                AboutBullet(
                  text:
                      '2- يعرض التطبيق بيانات عدد من الفنيين بصفة مستقلة ولا تحمل مسؤلية التعاقد مع اي فني فهذه القائمة استرشادية وعليك توخي الحذر وتنبيهنا بأي تجاوز ليتم حذف بيانات الفني فوراً من التطبيق، و مع ذلك يعمل الموقع على توفير قائمة تحمل بيانات أفضل الفنيين في مختلف المدن المصرية ونعمل على التحقق من هوية الفنيين وبياناتهم الشخصية وملفهم الجنائي .',
                ),
                AboutBullet(
                  text:
                      '3- بمجرد إستخدامك لهذا التطبيق فأنت توافق على كافة تفاصيل ( الشروط والاحكام ) و ( سياسة الخصوصية ) .',
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Linkify(
                      onOpen: (_) {
                        _launchUrl(conditionsUrl);
                      },
                      text: '$conditionsUrl',
                    ),
                    AboutBullet(
                      text: 'رابط الشروط والاحكام  : ',
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Linkify(
                      onOpen: (_) {
                        _launchUrl(privacyUrl);
                      },
                      text: '$privacyUrl',
                    ),
                    AboutBullet(
                      text: 'رابط سياسة الخصوصية  : ',
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Linkify(
                      onOpen: (_) {
                        _launchUrl(technicalSupportUrl);
                      },
                      text: '$technicalSupportUrl',
                    ),
                    AboutBullet(
                      text: 'رابط الدعم الفني والمساعدة : ',
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Linkify(
                      onOpen: (_) {
                        _launchUrl(contactUrl);
                      },
                      text: '$contactUrl',
                    ),
                    AboutBullet(
                      text: 'رابط الإتصال بنا : ',
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Linkify(
                      onOpen: (_) {
                        _launchUrl(siteUrl);
                      },
                      text: '$siteUrl',
                    ),
                    AboutBullet(
                      text: 'رابط الموقع : ',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AboutBullet extends StatelessWidget {
  AboutBullet({
    this.text,
  });
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        textDirection: TextDirection.rtl,
        textAlign: TextAlign.justify,
        softWrap: true,
        style: TextStyle(
          color: Colors.black87,
          fontSize: 16,
        ),
      ),
    );
  }
}
