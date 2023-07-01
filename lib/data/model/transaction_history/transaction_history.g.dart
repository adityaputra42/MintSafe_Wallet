// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_history.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetTransactionHistoryCollection on Isar {
  IsarCollection<TransactionHistory> get transactionHistorys =>
      this.collection();
}

const TransactionHistorySchema = CollectionSchema(
  name: r'TransactionHistory',
  id: 6353014656210365385,
  properties: {
    r'address': PropertySchema(
      id: 0,
      name: r'address',
      type: IsarType.string,
    ),
    r'amount': PropertySchema(
      id: 1,
      name: r'amount',
      type: IsarType.double,
    ),
    r'chainId': PropertySchema(
      id: 2,
      name: r'chainId',
      type: IsarType.string,
    ),
    r'contractAddress': PropertySchema(
      id: 3,
      name: r'contractAddress',
      type: IsarType.string,
    ),
    r'date': PropertySchema(
      id: 4,
      name: r'date',
      type: IsarType.dateTime,
    ),
    r'fromAddress': PropertySchema(
      id: 5,
      name: r'fromAddress',
      type: IsarType.string,
    ),
    r'isContractInteraction': PropertySchema(
      id: 6,
      name: r'isContractInteraction',
      type: IsarType.bool,
    ),
    r'networkFee': PropertySchema(
      id: 7,
      name: r'networkFee',
      type: IsarType.double,
    ),
    r'nonce': PropertySchema(
      id: 8,
      name: r'nonce',
      type: IsarType.long,
    ),
    r'status': PropertySchema(
      id: 9,
      name: r'status',
      type: IsarType.string,
    ),
    r'toAddress': PropertySchema(
      id: 10,
      name: r'toAddress',
      type: IsarType.string,
    ),
    r'txHash': PropertySchema(
      id: 11,
      name: r'txHash',
      type: IsarType.string,
    )
  },
  estimateSize: _transactionHistoryEstimateSize,
  serialize: _transactionHistorySerialize,
  deserialize: _transactionHistoryDeserialize,
  deserializeProp: _transactionHistoryDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _transactionHistoryGetId,
  getLinks: _transactionHistoryGetLinks,
  attach: _transactionHistoryAttach,
  version: '3.1.0+1',
);

int _transactionHistoryEstimateSize(
  TransactionHistory object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.address;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.chainId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.contractAddress;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.fromAddress;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.status;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.toAddress;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.txHash;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _transactionHistorySerialize(
  TransactionHistory object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.address);
  writer.writeDouble(offsets[1], object.amount);
  writer.writeString(offsets[2], object.chainId);
  writer.writeString(offsets[3], object.contractAddress);
  writer.writeDateTime(offsets[4], object.date);
  writer.writeString(offsets[5], object.fromAddress);
  writer.writeBool(offsets[6], object.isContractInteraction);
  writer.writeDouble(offsets[7], object.networkFee);
  writer.writeLong(offsets[8], object.nonce);
  writer.writeString(offsets[9], object.status);
  writer.writeString(offsets[10], object.toAddress);
  writer.writeString(offsets[11], object.txHash);
}

TransactionHistory _transactionHistoryDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = TransactionHistory(
    address: reader.readStringOrNull(offsets[0]),
    amount: reader.readDoubleOrNull(offsets[1]),
    chainId: reader.readStringOrNull(offsets[2]),
    contractAddress: reader.readStringOrNull(offsets[3]),
    date: reader.readDateTimeOrNull(offsets[4]),
    fromAddress: reader.readStringOrNull(offsets[5]),
    id: id,
    isContractInteraction: reader.readBoolOrNull(offsets[6]) ?? false,
    networkFee: reader.readDoubleOrNull(offsets[7]),
    nonce: reader.readLongOrNull(offsets[8]),
    status: reader.readStringOrNull(offsets[9]),
    toAddress: reader.readStringOrNull(offsets[10]),
    txHash: reader.readStringOrNull(offsets[11]),
  );
  return object;
}

P _transactionHistoryDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readDoubleOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 7:
      return (reader.readDoubleOrNull(offset)) as P;
    case 8:
      return (reader.readLongOrNull(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readStringOrNull(offset)) as P;
    case 11:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _transactionHistoryGetId(TransactionHistory object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _transactionHistoryGetLinks(
    TransactionHistory object) {
  return [];
}

void _transactionHistoryAttach(
    IsarCollection<dynamic> col, Id id, TransactionHistory object) {
  object.id = id;
}

extension TransactionHistoryQueryWhereSort
    on QueryBuilder<TransactionHistory, TransactionHistory, QWhere> {
  QueryBuilder<TransactionHistory, TransactionHistory, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension TransactionHistoryQueryWhere
    on QueryBuilder<TransactionHistory, TransactionHistory, QWhereClause> {
  QueryBuilder<TransactionHistory, TransactionHistory, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterWhereClause>
      idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension TransactionHistoryQueryFilter
    on QueryBuilder<TransactionHistory, TransactionHistory, QFilterCondition> {
  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      addressIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'address',
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      addressIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'address',
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      addressEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      addressGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      addressLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      addressBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'address',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      addressStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      addressEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      addressContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'address',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      addressMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'address',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      addressIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'address',
        value: '',
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      addressIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'address',
        value: '',
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      amountIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'amount',
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      amountIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'amount',
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      amountEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'amount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      amountGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'amount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      amountLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'amount',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      amountBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'amount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      chainIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'chainId',
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      chainIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'chainId',
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      chainIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'chainId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      chainIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'chainId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      chainIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'chainId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      chainIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'chainId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      chainIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'chainId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      chainIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'chainId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      chainIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'chainId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      chainIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'chainId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      chainIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'chainId',
        value: '',
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      chainIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'chainId',
        value: '',
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      contractAddressIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'contractAddress',
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      contractAddressIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'contractAddress',
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      contractAddressEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contractAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      contractAddressGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'contractAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      contractAddressLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'contractAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      contractAddressBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'contractAddress',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      contractAddressStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'contractAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      contractAddressEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'contractAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      contractAddressContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'contractAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      contractAddressMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'contractAddress',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      contractAddressIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'contractAddress',
        value: '',
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      contractAddressIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'contractAddress',
        value: '',
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      dateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'date',
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      dateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'date',
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      dateEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      dateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      dateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      dateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'date',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      fromAddressIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'fromAddress',
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      fromAddressIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'fromAddress',
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      fromAddressEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fromAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      fromAddressGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fromAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      fromAddressLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fromAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      fromAddressBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fromAddress',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      fromAddressStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'fromAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      fromAddressEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'fromAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      fromAddressContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'fromAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      fromAddressMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'fromAddress',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      fromAddressIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fromAddress',
        value: '',
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      fromAddressIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'fromAddress',
        value: '',
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      idEqualTo(Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      idGreaterThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      idLessThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      idBetween(
    Id? lower,
    Id? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      isContractInteractionEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isContractInteraction',
        value: value,
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      networkFeeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'networkFee',
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      networkFeeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'networkFee',
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      networkFeeEqualTo(
    double? value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'networkFee',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      networkFeeGreaterThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'networkFee',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      networkFeeLessThan(
    double? value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'networkFee',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      networkFeeBetween(
    double? lower,
    double? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'networkFee',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      nonceIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'nonce',
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      nonceIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'nonce',
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      nonceEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nonce',
        value: value,
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      nonceGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nonce',
        value: value,
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      nonceLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nonce',
        value: value,
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      nonceBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nonce',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      statusIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'status',
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      statusIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'status',
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      statusEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      statusGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      statusLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      statusBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'status',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      statusStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      statusEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      statusContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'status',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      statusMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'status',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      statusIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      statusIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'status',
        value: '',
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      toAddressIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'toAddress',
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      toAddressIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'toAddress',
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      toAddressEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'toAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      toAddressGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'toAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      toAddressLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'toAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      toAddressBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'toAddress',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      toAddressStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'toAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      toAddressEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'toAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      toAddressContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'toAddress',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      toAddressMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'toAddress',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      toAddressIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'toAddress',
        value: '',
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      toAddressIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'toAddress',
        value: '',
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      txHashIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'txHash',
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      txHashIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'txHash',
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      txHashEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'txHash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      txHashGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'txHash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      txHashLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'txHash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      txHashBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'txHash',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      txHashStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'txHash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      txHashEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'txHash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      txHashContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'txHash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      txHashMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'txHash',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      txHashIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'txHash',
        value: '',
      ));
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterFilterCondition>
      txHashIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'txHash',
        value: '',
      ));
    });
  }
}

extension TransactionHistoryQueryObject
    on QueryBuilder<TransactionHistory, TransactionHistory, QFilterCondition> {}

extension TransactionHistoryQueryLinks
    on QueryBuilder<TransactionHistory, TransactionHistory, QFilterCondition> {}

extension TransactionHistoryQuerySortBy
    on QueryBuilder<TransactionHistory, TransactionHistory, QSortBy> {
  QueryBuilder<TransactionHistory, TransactionHistory, QAfterSortBy>
      sortByAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'address', Sort.asc);
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterSortBy>
      sortByAddressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'address', Sort.desc);
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterSortBy>
      sortByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.asc);
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterSortBy>
      sortByAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.desc);
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterSortBy>
      sortByChainId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chainId', Sort.asc);
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterSortBy>
      sortByChainIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chainId', Sort.desc);
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterSortBy>
      sortByContractAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contractAddress', Sort.asc);
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterSortBy>
      sortByContractAddressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contractAddress', Sort.desc);
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterSortBy>
      sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterSortBy>
      sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterSortBy>
      sortByFromAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fromAddress', Sort.asc);
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterSortBy>
      sortByFromAddressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fromAddress', Sort.desc);
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterSortBy>
      sortByIsContractInteraction() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isContractInteraction', Sort.asc);
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterSortBy>
      sortByIsContractInteractionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isContractInteraction', Sort.desc);
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterSortBy>
      sortByNetworkFee() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'networkFee', Sort.asc);
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterSortBy>
      sortByNetworkFeeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'networkFee', Sort.desc);
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterSortBy>
      sortByNonce() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nonce', Sort.asc);
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterSortBy>
      sortByNonceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nonce', Sort.desc);
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterSortBy>
      sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterSortBy>
      sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterSortBy>
      sortByToAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toAddress', Sort.asc);
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterSortBy>
      sortByToAddressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toAddress', Sort.desc);
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterSortBy>
      sortByTxHash() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'txHash', Sort.asc);
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterSortBy>
      sortByTxHashDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'txHash', Sort.desc);
    });
  }
}

extension TransactionHistoryQuerySortThenBy
    on QueryBuilder<TransactionHistory, TransactionHistory, QSortThenBy> {
  QueryBuilder<TransactionHistory, TransactionHistory, QAfterSortBy>
      thenByAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'address', Sort.asc);
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterSortBy>
      thenByAddressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'address', Sort.desc);
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterSortBy>
      thenByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.asc);
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterSortBy>
      thenByAmountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'amount', Sort.desc);
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterSortBy>
      thenByChainId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chainId', Sort.asc);
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterSortBy>
      thenByChainIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chainId', Sort.desc);
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterSortBy>
      thenByContractAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contractAddress', Sort.asc);
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterSortBy>
      thenByContractAddressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'contractAddress', Sort.desc);
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterSortBy>
      thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterSortBy>
      thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterSortBy>
      thenByFromAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fromAddress', Sort.asc);
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterSortBy>
      thenByFromAddressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fromAddress', Sort.desc);
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterSortBy>
      thenByIsContractInteraction() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isContractInteraction', Sort.asc);
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterSortBy>
      thenByIsContractInteractionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isContractInteraction', Sort.desc);
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterSortBy>
      thenByNetworkFee() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'networkFee', Sort.asc);
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterSortBy>
      thenByNetworkFeeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'networkFee', Sort.desc);
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterSortBy>
      thenByNonce() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nonce', Sort.asc);
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterSortBy>
      thenByNonceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nonce', Sort.desc);
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterSortBy>
      thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterSortBy>
      thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterSortBy>
      thenByToAddress() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toAddress', Sort.asc);
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterSortBy>
      thenByToAddressDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'toAddress', Sort.desc);
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterSortBy>
      thenByTxHash() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'txHash', Sort.asc);
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QAfterSortBy>
      thenByTxHashDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'txHash', Sort.desc);
    });
  }
}

extension TransactionHistoryQueryWhereDistinct
    on QueryBuilder<TransactionHistory, TransactionHistory, QDistinct> {
  QueryBuilder<TransactionHistory, TransactionHistory, QDistinct>
      distinctByAddress({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'address', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QDistinct>
      distinctByAmount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'amount');
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QDistinct>
      distinctByChainId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'chainId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QDistinct>
      distinctByContractAddress({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'contractAddress',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QDistinct>
      distinctByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date');
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QDistinct>
      distinctByFromAddress({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fromAddress', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QDistinct>
      distinctByIsContractInteraction() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isContractInteraction');
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QDistinct>
      distinctByNetworkFee() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'networkFee');
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QDistinct>
      distinctByNonce() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nonce');
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QDistinct>
      distinctByStatus({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QDistinct>
      distinctByToAddress({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'toAddress', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<TransactionHistory, TransactionHistory, QDistinct>
      distinctByTxHash({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'txHash', caseSensitive: caseSensitive);
    });
  }
}

extension TransactionHistoryQueryProperty
    on QueryBuilder<TransactionHistory, TransactionHistory, QQueryProperty> {
  QueryBuilder<TransactionHistory, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<TransactionHistory, String?, QQueryOperations>
      addressProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'address');
    });
  }

  QueryBuilder<TransactionHistory, double?, QQueryOperations> amountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'amount');
    });
  }

  QueryBuilder<TransactionHistory, String?, QQueryOperations>
      chainIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'chainId');
    });
  }

  QueryBuilder<TransactionHistory, String?, QQueryOperations>
      contractAddressProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'contractAddress');
    });
  }

  QueryBuilder<TransactionHistory, DateTime?, QQueryOperations> dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }

  QueryBuilder<TransactionHistory, String?, QQueryOperations>
      fromAddressProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fromAddress');
    });
  }

  QueryBuilder<TransactionHistory, bool, QQueryOperations>
      isContractInteractionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isContractInteraction');
    });
  }

  QueryBuilder<TransactionHistory, double?, QQueryOperations>
      networkFeeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'networkFee');
    });
  }

  QueryBuilder<TransactionHistory, int?, QQueryOperations> nonceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nonce');
    });
  }

  QueryBuilder<TransactionHistory, String?, QQueryOperations> statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }

  QueryBuilder<TransactionHistory, String?, QQueryOperations>
      toAddressProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'toAddress');
    });
  }

  QueryBuilder<TransactionHistory, String?, QQueryOperations> txHashProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'txHash');
    });
  }
}
