import 'package:json_annotation/json_annotation.dart';

part 'quote_dto.g.dart';

@JsonSerializable()
class QuoteDto {
  @JsonKey(name: 'quoteText')
  final String quoteText;
  @JsonKey(name: 'quoteAuthor')
  final String quoteAuthor;
  @JsonKey(name: 'quoteLink')
  final String? quoteLink;
  @JsonKey(name: 'senderName')
  final String? senderName;
  @JsonKey(name: 'senderLink')
  final String? senderLink;

  QuoteDto({
    required this.quoteText,
    required this.quoteAuthor,
    this.quoteLink,
    this.senderName,
    this.senderLink,
  });

  factory QuoteDto.fromJson(Map<String, dynamic> json) => _$QuoteDtoFromJson(json);
  Map<String, dynamic> toJson() => _$QuoteDtoToJson(this);
}
