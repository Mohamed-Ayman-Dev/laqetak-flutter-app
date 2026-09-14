import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:invastro/src/core/constants/app_feedback.dart';
import 'package:invastro/src/core/constants/enums.dart';
import 'package:invastro/src/core/widgets/drawer_widgets/custom_drawer.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../../generated/l10n.dart';
import '../../../../core/extension/space_extensions_helper.dart';
import '../../../../core/widgets/custom_appbar.dart';
import '../../../../core/widgets/lists_widgets/empty_list_placeholder_widget.dart';
import '../../../../core/widgets/lists_widgets/smart_refresher_header.dart';
import '../cubit/static_pages_cubit.dart';
import '../cubit/static_pages_state.dart';
import '../widgets/question_static_item.dart';
import '../widgets/shimmers/question_static_item_shimmer.dart';

class QuestionsScreen extends StatefulWidget {
  static const routeName = '/questions-screen';

  const QuestionsScreen({super.key});

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<StaticPagesCubit>().getFaqs();
    });
    super.initState();
  }

  final RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );

  Future<void> _refresh() async {
    await context.read<StaticPagesCubit>().getFaqs();
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
      body: BlocListener<StaticPagesCubit, StaticPagesState>(
        listenWhen: (previous, current) =>
            current.hasFaqsError && !previous.hasFaqsError,
        listener: (context, state) =>
            AppFeedback.errorMessage(state.errorMessage),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              12.heightSpace,
              Expanded(
                child: SmartRefresher(
                  controller: _refreshController,
                  onRefresh: _refresh,
                  header: const SmartRefresherHeader(),
                  child: BlocBuilder<StaticPagesCubit, StaticPagesState>(
                    buildWhen: (previous, current) =>
                        previous.faqs != current.faqs ||
                        previous.faqsStatus != current.faqsStatus,
                    builder: (context, state) {
                      final faqs = state.faqs;
                      final showShimmer =
                          faqs.isEmpty &&
                          (state.faqsStatus == RequestStatus.initial ||
                              state.faqsStatus == RequestStatus.loading);
                      return SingleChildScrollView(
                        padding: EdgeInsets.symmetric(horizontal: 16).r,
                        child: Column(
                          children: [
                            !showShimmer && faqs.isEmpty
                                ? EmptyListPlaceholderWidget(
                                    text: S
                                        .of(context)
                                        .thereAreNoMoreQuestionsYet,
                                    paddingTop: 300,
                                  )
                                : ListView.separated(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 24,
                                    ).r,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) => showShimmer
                                        ? QuestionStaticItemShimmer()
                                        : QuestionStaticItem(
                                            question:
                                                faqs[index].question ?? '',
                                            answer: faqs[index].answer ?? '',
                                          ),
                                    separatorBuilder: (context, index) =>
                                        16.heightSpace,
                                    itemCount: showShimmer ? 7 : faqs.length,
                                  ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
