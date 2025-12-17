// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuoteDto _$QuoteDtoFromJson(Map<String, dynamic> json) => QuoteDto(
  quoteText: json['quoteText'] as String,
  quoteAuthor: json['quoteAuthor'] as String,
  quoteLink: json['quoteLink'] as String?,
  senderName: json['senderName'] as String?,
  senderLink: json['senderLink'] as String?,
);

Map<String, dynamic> _$QuoteDtoToJson(QuoteDto instance) => <String, dynamic>{
  'quoteText': instance.quoteText,
  'quoteAuthor': instance.quoteAuthor,
  'quoteLink': instance.quoteLink,
  'senderName': instance.senderName,
  'senderLink': instance.senderLink,
};
