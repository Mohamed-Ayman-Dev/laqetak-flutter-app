import 'package:equatable/equatable.dart';

import '../../../../core/constants/enums.dart';
import '../../data/models/faq_model.dart';

class StaticPagesState extends Equatable {
  const StaticPagesState({
    this.faqs = const [],
    this.faqsStatus = RequestStatus.initial,
    this.contactStatus = RequestStatus.initial,
    this.errorMessage,
  });

  final List<FaqModel> faqs;
  final RequestStatus faqsStatus;
  final RequestStatus contactStatus;
  final String? errorMessage;

  bool get hasError =>
      faqsStatus == RequestStatus.error || contactStatus == RequestStatus.error;

  bool get hasFaqsError => faqsStatus == RequestStatus.error;

  bool get hasContactError => contactStatus == RequestStatus.error;

  StaticPagesState copyWith({
    List<FaqModel>? faqs,
    RequestStatus? faqsStatus,
    RequestStatus? contactStatus,
    String? errorMessage,
  }) => StaticPagesState(
    faqs: faqs ?? this.faqs,
    faqsStatus: faqsStatus ?? this.faqsStatus,
    contactStatus: contactStatus ?? this.contactStatus,
    errorMessage: errorMessage ?? this.errorMessage,
  );

  @override
  List<Object?> get props => [faqs, faqsStatus, contactStatus, errorMessage];
}
