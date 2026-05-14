import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invastro/src/core/constants/enums.dart';
import 'package:invastro/src/core/shared/widgets/drawer_widgets/custom_drawer.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../core/extension/space_extensions_helper.dart';
import '../../../../core/shared/widgets/custom_appbar.dart';
import '../widgets/question_static_item.dart';

class QuestionsScreen extends StatefulWidget {
  static const routeName = '/questions-screen';

  const QuestionsScreen({super.key});

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  // int index = 0;

  // PageController pageViewController = PageController(initialPage: 0);
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // StaticPagesController.getFaqs();
    });
    super.initState();
  }

  final RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );

  Future<void> _refresh() async {
    // await StaticPagesController.getFaqs();
    _refreshController.refreshCompleted();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        icons: [AppbarIcons.logo, AppbarIcons.drawer],
        flexRight: 8,
      ),
      drawer: CustomDrawer(),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            12.heightSpace,
            Expanded(
              child:
                  // SmartRefresher(
                  //   controller: _refreshController,
                  //   onRefresh: _refresh,
                  //   header: const SmartRefresherHeader(),
                  //   child: Selector<StaticPages, List<FaqModel>?>(
                  //     selector: (context, provider) => provider.myFaqs,
                  //     builder: (context, myFaqs, child) {
                  //       return
                  SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 16).r,
                    child: Column(
                      children: [
                        // myFaqs != null && myFaqs.isEmpty
                        //     ? EmptyListPlaceholderWidget(
                        //         text: S
                        //             .of(context)
                        //             .thereAreNoMoreQuestionsYet,
                        //         paddingTop: 300,
                        //       )
                        //     :
                        ListView.separated(
                          padding: const EdgeInsets.symmetric(vertical: 24).r,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) =>
                              // myFaqs == null
                              // ? QuestionStaticItemShimmer()
                              // :
                              QuestionStaticItem(
                                question: 'طريقة استخدام التطبيق  ؟',
                                answer:
                                    'محتوى تجريبي يمكن استخدامه واستبداله فيما بعد بالمحتوى الفعلى للتطبيق من قبل فريق ادارة ووضع المحتوى العام محتوى تجريبي يمكن استخدامه واستبداله فيما بعد بالمحتوى الفعلى للتطبيق من قبل فريق ادارة ووضع المحتوى العام محتوى تجريبي يمكن استخدامه واستبداله فيما بعد بالمحتوى الفعلى للتطبيق من قبل فريق ادارة ووضع المحتوى العام محتوى تجريبي يمكن استخدامه واستبداله فيما بعد بالمحتوى الفعلى للتطبيق من قبل فريق ادارة ووضع المحتوى العام محتوى تجريبي يمكن استخدامه واستبداله فيما بعد بالمحتوى الفعلى للتطبيق من قبل فريق ادارة ووضع المحتوى العام محتوى تجريبي يمكن استخدامه واستبداله فيما بعد بالمحتوى الفعلى للتطبيق من قبل فريق ادارة ووضع المحتوى العام محتوى تجريبي يمكن استخدامه واستبداله فيما بعد بالمحتوى الفعلى للتطبيق من قبل فريق ادارة ووضع المحتوى العام محتوى تجريبي يمكن استخدامه واستبداله فيما بعد بالمحتوى الفعلى للتطبيق من قبل فريق ادارة ووضع المحتوى العام ',
                              ),
                          separatorBuilder: (context, index) => 16.heightSpace,
                          itemCount: 7,
                        ),
                      ],
                    ),
                  ),
              // ;
              //     },
              //   ),
              // ),
            ),
          ],
        ),
      ),
    );
  }
}
