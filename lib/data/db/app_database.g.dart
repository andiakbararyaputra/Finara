// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $MonthlyAllocationsTable extends MonthlyAllocations
    with TableInfo<$MonthlyAllocationsTable, MonthlyAllocation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MonthlyAllocationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _tahunMeta = const VerificationMeta('tahun');
  @override
  late final GeneratedColumn<int> tahun = GeneratedColumn<int>(
    'tahun',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bulanMeta = const VerificationMeta('bulan');
  @override
  late final GeneratedColumn<int> bulan = GeneratedColumn<int>(
    'bulan',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dibuatPadaMeta = const VerificationMeta(
    'dibuatPada',
  );
  @override
  late final GeneratedColumn<DateTime> dibuatPada = GeneratedColumn<DateTime>(
    'dibuat_pada',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, tahun, bulan, dibuatPada];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'monthly_allocations';
  @override
  VerificationContext validateIntegrity(
    Insertable<MonthlyAllocation> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('tahun')) {
      context.handle(
        _tahunMeta,
        tahun.isAcceptableOrUnknown(data['tahun']!, _tahunMeta),
      );
    } else if (isInserting) {
      context.missing(_tahunMeta);
    }
    if (data.containsKey('bulan')) {
      context.handle(
        _bulanMeta,
        bulan.isAcceptableOrUnknown(data['bulan']!, _bulanMeta),
      );
    } else if (isInserting) {
      context.missing(_bulanMeta);
    }
    if (data.containsKey('dibuat_pada')) {
      context.handle(
        _dibuatPadaMeta,
        dibuatPada.isAcceptableOrUnknown(data['dibuat_pada']!, _dibuatPadaMeta),
      );
    } else if (isInserting) {
      context.missing(_dibuatPadaMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {tahun, bulan},
  ];
  @override
  MonthlyAllocation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MonthlyAllocation(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      tahun: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tahun'],
      )!,
      bulan: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}bulan'],
      )!,
      dibuatPada: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}dibuat_pada'],
      )!,
    );
  }

  @override
  $MonthlyAllocationsTable createAlias(String alias) {
    return $MonthlyAllocationsTable(attachedDatabase, alias);
  }
}

class MonthlyAllocation extends DataClass
    implements Insertable<MonthlyAllocation> {
  final int id;
  final int tahun;
  final int bulan;
  final DateTime dibuatPada;
  const MonthlyAllocation({
    required this.id,
    required this.tahun,
    required this.bulan,
    required this.dibuatPada,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['tahun'] = Variable<int>(tahun);
    map['bulan'] = Variable<int>(bulan);
    map['dibuat_pada'] = Variable<DateTime>(dibuatPada);
    return map;
  }

  MonthlyAllocationsCompanion toCompanion(bool nullToAbsent) {
    return MonthlyAllocationsCompanion(
      id: Value(id),
      tahun: Value(tahun),
      bulan: Value(bulan),
      dibuatPada: Value(dibuatPada),
    );
  }

  factory MonthlyAllocation.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MonthlyAllocation(
      id: serializer.fromJson<int>(json['id']),
      tahun: serializer.fromJson<int>(json['tahun']),
      bulan: serializer.fromJson<int>(json['bulan']),
      dibuatPada: serializer.fromJson<DateTime>(json['dibuatPada']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tahun': serializer.toJson<int>(tahun),
      'bulan': serializer.toJson<int>(bulan),
      'dibuatPada': serializer.toJson<DateTime>(dibuatPada),
    };
  }

  MonthlyAllocation copyWith({
    int? id,
    int? tahun,
    int? bulan,
    DateTime? dibuatPada,
  }) => MonthlyAllocation(
    id: id ?? this.id,
    tahun: tahun ?? this.tahun,
    bulan: bulan ?? this.bulan,
    dibuatPada: dibuatPada ?? this.dibuatPada,
  );
  MonthlyAllocation copyWithCompanion(MonthlyAllocationsCompanion data) {
    return MonthlyAllocation(
      id: data.id.present ? data.id.value : this.id,
      tahun: data.tahun.present ? data.tahun.value : this.tahun,
      bulan: data.bulan.present ? data.bulan.value : this.bulan,
      dibuatPada: data.dibuatPada.present
          ? data.dibuatPada.value
          : this.dibuatPada,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MonthlyAllocation(')
          ..write('id: $id, ')
          ..write('tahun: $tahun, ')
          ..write('bulan: $bulan, ')
          ..write('dibuatPada: $dibuatPada')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, tahun, bulan, dibuatPada);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MonthlyAllocation &&
          other.id == this.id &&
          other.tahun == this.tahun &&
          other.bulan == this.bulan &&
          other.dibuatPada == this.dibuatPada);
}

class MonthlyAllocationsCompanion extends UpdateCompanion<MonthlyAllocation> {
  final Value<int> id;
  final Value<int> tahun;
  final Value<int> bulan;
  final Value<DateTime> dibuatPada;
  const MonthlyAllocationsCompanion({
    this.id = const Value.absent(),
    this.tahun = const Value.absent(),
    this.bulan = const Value.absent(),
    this.dibuatPada = const Value.absent(),
  });
  MonthlyAllocationsCompanion.insert({
    this.id = const Value.absent(),
    required int tahun,
    required int bulan,
    required DateTime dibuatPada,
  }) : tahun = Value(tahun),
       bulan = Value(bulan),
       dibuatPada = Value(dibuatPada);
  static Insertable<MonthlyAllocation> custom({
    Expression<int>? id,
    Expression<int>? tahun,
    Expression<int>? bulan,
    Expression<DateTime>? dibuatPada,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tahun != null) 'tahun': tahun,
      if (bulan != null) 'bulan': bulan,
      if (dibuatPada != null) 'dibuat_pada': dibuatPada,
    });
  }

  MonthlyAllocationsCompanion copyWith({
    Value<int>? id,
    Value<int>? tahun,
    Value<int>? bulan,
    Value<DateTime>? dibuatPada,
  }) {
    return MonthlyAllocationsCompanion(
      id: id ?? this.id,
      tahun: tahun ?? this.tahun,
      bulan: bulan ?? this.bulan,
      dibuatPada: dibuatPada ?? this.dibuatPada,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tahun.present) {
      map['tahun'] = Variable<int>(tahun.value);
    }
    if (bulan.present) {
      map['bulan'] = Variable<int>(bulan.value);
    }
    if (dibuatPada.present) {
      map['dibuat_pada'] = Variable<DateTime>(dibuatPada.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MonthlyAllocationsCompanion(')
          ..write('id: $id, ')
          ..write('tahun: $tahun, ')
          ..write('bulan: $bulan, ')
          ..write('dibuatPada: $dibuatPada')
          ..write(')'))
        .toString();
  }
}

class $MonthlyAllocationRevisionsTable extends MonthlyAllocationRevisions
    with
        TableInfo<$MonthlyAllocationRevisionsTable, MonthlyAllocationRevision> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MonthlyAllocationRevisionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _monthlyAllocationIdMeta =
      const VerificationMeta('monthlyAllocationId');
  @override
  late final GeneratedColumn<int> monthlyAllocationId = GeneratedColumn<int>(
    'monthly_allocation_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES monthly_allocations (id)',
    ),
  );
  static const VerificationMeta _nomorRevisiMeta = const VerificationMeta(
    'nomorRevisi',
  );
  @override
  late final GeneratedColumn<int> nomorRevisi = GeneratedColumn<int>(
    'nomor_revisi',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<RevisionStatus, String> status =
      GeneratedColumn<String>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<RevisionStatus>(
        $MonthlyAllocationRevisionsTable.$converterstatus,
      );
  static const VerificationMeta _alasanPerubahanMeta = const VerificationMeta(
    'alasanPerubahan',
  );
  @override
  late final GeneratedColumn<String> alasanPerubahan = GeneratedColumn<String>(
    'alasan_perubahan',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _catatanMeta = const VerificationMeta(
    'catatan',
  );
  @override
  late final GeneratedColumn<String> catatan = GeneratedColumn<String>(
    'catatan',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _penghasilanUtamaMeta = const VerificationMeta(
    'penghasilanUtama',
  );
  @override
  late final GeneratedColumn<int> penghasilanUtama = GeneratedColumn<int>(
    'penghasilan_utama',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kasPeganganBrimoMeta = const VerificationMeta(
    'kasPeganganBrimo',
  );
  @override
  late final GeneratedColumn<int> kasPeganganBrimo = GeneratedColumn<int>(
    'kas_pegangan_brimo',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _presetMeta = const VerificationMeta('preset');
  @override
  late final GeneratedColumn<String> preset = GeneratedColumn<String>(
    'preset',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _jagoBpMeta = const VerificationMeta('jagoBp');
  @override
  late final GeneratedColumn<int> jagoBp = GeneratedColumn<int>(
    'jago_bp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _investasiBpMeta = const VerificationMeta(
    'investasiBp',
  );
  @override
  late final GeneratedColumn<int> investasiBp = GeneratedColumn<int>(
    'investasi_bp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _danaBpMeta = const VerificationMeta('danaBp');
  @override
  late final GeneratedColumn<int> danaBp = GeneratedColumn<int>(
    'dana_bp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bibitBpMeta = const VerificationMeta(
    'bibitBp',
  );
  @override
  late final GeneratedColumn<int> bibitBp = GeneratedColumn<int>(
    'bibit_bp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stockbitBpMeta = const VerificationMeta(
    'stockbitBp',
  );
  @override
  late final GeneratedColumn<int> stockbitBp = GeneratedColumn<int>(
    'stockbit_bp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<RoundingOption, String>
  pembulatan =
      GeneratedColumn<String>(
        'pembulatan',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<RoundingOption>(
        $MonthlyAllocationRevisionsTable.$converterpembulatan,
      );
  @override
  late final GeneratedColumnWithTypeConverter<JagoSubAllocationMethod, String>
  metodeSubJago =
      GeneratedColumn<String>(
        'metode_sub_jago',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<JagoSubAllocationMethod>(
        $MonthlyAllocationRevisionsTable.$convertermetodeSubJago,
      );
  static const VerificationMeta _subJagoLanggananBpMeta =
      const VerificationMeta('subJagoLanggananBp');
  @override
  late final GeneratedColumn<int> subJagoLanggananBp = GeneratedColumn<int>(
    'sub_jago_langganan_bp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _subJagoDaruratBpMeta = const VerificationMeta(
    'subJagoDaruratBp',
  );
  @override
  late final GeneratedColumn<int> subJagoDaruratBp = GeneratedColumn<int>(
    'sub_jago_darurat_bp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _subJagoOperasionalBpMeta =
      const VerificationMeta('subJagoOperasionalBp');
  @override
  late final GeneratedColumn<int> subJagoOperasionalBp = GeneratedColumn<int>(
    'sub_jago_operasional_bp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<DanaTopUpFrequency, String>
  frekuensiTopUpDana =
      GeneratedColumn<String>(
        'frekuensi_top_up_dana',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<DanaTopUpFrequency>(
        $MonthlyAllocationRevisionsTable.$converterfrekuensiTopUpDana,
      );
  static const VerificationMeta _hariTopUpMingguanMeta = const VerificationMeta(
    'hariTopUpMingguan',
  );
  @override
  late final GeneratedColumn<int> hariTopUpMingguan = GeneratedColumn<int>(
    'hari_top_up_mingguan',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalPendapatanMeta = const VerificationMeta(
    'totalPendapatan',
  );
  @override
  late final GeneratedColumn<int> totalPendapatan = GeneratedColumn<int>(
    'total_pendapatan',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalPengeluaranWajibMeta =
      const VerificationMeta('totalPengeluaranWajib');
  @override
  late final GeneratedColumn<int> totalPengeluaranWajib = GeneratedColumn<int>(
    'total_pengeluaran_wajib',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _danaBersihMeta = const VerificationMeta(
    'danaBersih',
  );
  @override
  late final GeneratedColumn<int> danaBersih = GeneratedColumn<int>(
    'dana_bersih',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _alokasiJagoMeta = const VerificationMeta(
    'alokasiJago',
  );
  @override
  late final GeneratedColumn<int> alokasiJago = GeneratedColumn<int>(
    'alokasi_jago',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalAlokasiInvestasiMeta =
      const VerificationMeta('totalAlokasiInvestasi');
  @override
  late final GeneratedColumn<int> totalAlokasiInvestasi = GeneratedColumn<int>(
    'total_alokasi_investasi',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _alokasiDanaMeta = const VerificationMeta(
    'alokasiDana',
  );
  @override
  late final GeneratedColumn<int> alokasiDana = GeneratedColumn<int>(
    'alokasi_dana',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _alokasiBibitMeta = const VerificationMeta(
    'alokasiBibit',
  );
  @override
  late final GeneratedColumn<int> alokasiBibit = GeneratedColumn<int>(
    'alokasi_bibit',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _alokasiStockbitMeta = const VerificationMeta(
    'alokasiStockbit',
  );
  @override
  late final GeneratedColumn<int> alokasiStockbit = GeneratedColumn<int>(
    'alokasi_stockbit',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalDanaMasukJagoMeta =
      const VerificationMeta('totalDanaMasukJago');
  @override
  late final GeneratedColumn<int> totalDanaMasukJago = GeneratedColumn<int>(
    'total_dana_masuk_jago',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _subJagoLanggananMeta = const VerificationMeta(
    'subJagoLangganan',
  );
  @override
  late final GeneratedColumn<int> subJagoLangganan = GeneratedColumn<int>(
    'sub_jago_langganan',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _subJagoDanaDaruratMeta =
      const VerificationMeta('subJagoDanaDarurat');
  @override
  late final GeneratedColumn<int> subJagoDanaDarurat = GeneratedColumn<int>(
    'sub_jago_dana_darurat',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _subJagoOperasionalMeta =
      const VerificationMeta('subJagoOperasional');
  @override
  late final GeneratedColumn<int> subJagoOperasional = GeneratedColumn<int>(
    'sub_jago_operasional',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dibuatPadaMeta = const VerificationMeta(
    'dibuatPada',
  );
  @override
  late final GeneratedColumn<DateTime> dibuatPada = GeneratedColumn<DateTime>(
    'dibuat_pada',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    monthlyAllocationId,
    nomorRevisi,
    status,
    alasanPerubahan,
    catatan,
    penghasilanUtama,
    kasPeganganBrimo,
    preset,
    jagoBp,
    investasiBp,
    danaBp,
    bibitBp,
    stockbitBp,
    pembulatan,
    metodeSubJago,
    subJagoLanggananBp,
    subJagoDaruratBp,
    subJagoOperasionalBp,
    frekuensiTopUpDana,
    hariTopUpMingguan,
    totalPendapatan,
    totalPengeluaranWajib,
    danaBersih,
    alokasiJago,
    totalAlokasiInvestasi,
    alokasiDana,
    alokasiBibit,
    alokasiStockbit,
    totalDanaMasukJago,
    subJagoLangganan,
    subJagoDanaDarurat,
    subJagoOperasional,
    dibuatPada,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'monthly_allocation_revisions';
  @override
  VerificationContext validateIntegrity(
    Insertable<MonthlyAllocationRevision> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('monthly_allocation_id')) {
      context.handle(
        _monthlyAllocationIdMeta,
        monthlyAllocationId.isAcceptableOrUnknown(
          data['monthly_allocation_id']!,
          _monthlyAllocationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_monthlyAllocationIdMeta);
    }
    if (data.containsKey('nomor_revisi')) {
      context.handle(
        _nomorRevisiMeta,
        nomorRevisi.isAcceptableOrUnknown(
          data['nomor_revisi']!,
          _nomorRevisiMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_nomorRevisiMeta);
    }
    if (data.containsKey('alasan_perubahan')) {
      context.handle(
        _alasanPerubahanMeta,
        alasanPerubahan.isAcceptableOrUnknown(
          data['alasan_perubahan']!,
          _alasanPerubahanMeta,
        ),
      );
    }
    if (data.containsKey('catatan')) {
      context.handle(
        _catatanMeta,
        catatan.isAcceptableOrUnknown(data['catatan']!, _catatanMeta),
      );
    }
    if (data.containsKey('penghasilan_utama')) {
      context.handle(
        _penghasilanUtamaMeta,
        penghasilanUtama.isAcceptableOrUnknown(
          data['penghasilan_utama']!,
          _penghasilanUtamaMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_penghasilanUtamaMeta);
    }
    if (data.containsKey('kas_pegangan_brimo')) {
      context.handle(
        _kasPeganganBrimoMeta,
        kasPeganganBrimo.isAcceptableOrUnknown(
          data['kas_pegangan_brimo']!,
          _kasPeganganBrimoMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_kasPeganganBrimoMeta);
    }
    if (data.containsKey('preset')) {
      context.handle(
        _presetMeta,
        preset.isAcceptableOrUnknown(data['preset']!, _presetMeta),
      );
    }
    if (data.containsKey('jago_bp')) {
      context.handle(
        _jagoBpMeta,
        jagoBp.isAcceptableOrUnknown(data['jago_bp']!, _jagoBpMeta),
      );
    } else if (isInserting) {
      context.missing(_jagoBpMeta);
    }
    if (data.containsKey('investasi_bp')) {
      context.handle(
        _investasiBpMeta,
        investasiBp.isAcceptableOrUnknown(
          data['investasi_bp']!,
          _investasiBpMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_investasiBpMeta);
    }
    if (data.containsKey('dana_bp')) {
      context.handle(
        _danaBpMeta,
        danaBp.isAcceptableOrUnknown(data['dana_bp']!, _danaBpMeta),
      );
    } else if (isInserting) {
      context.missing(_danaBpMeta);
    }
    if (data.containsKey('bibit_bp')) {
      context.handle(
        _bibitBpMeta,
        bibitBp.isAcceptableOrUnknown(data['bibit_bp']!, _bibitBpMeta),
      );
    } else if (isInserting) {
      context.missing(_bibitBpMeta);
    }
    if (data.containsKey('stockbit_bp')) {
      context.handle(
        _stockbitBpMeta,
        stockbitBp.isAcceptableOrUnknown(data['stockbit_bp']!, _stockbitBpMeta),
      );
    } else if (isInserting) {
      context.missing(_stockbitBpMeta);
    }
    if (data.containsKey('sub_jago_langganan_bp')) {
      context.handle(
        _subJagoLanggananBpMeta,
        subJagoLanggananBp.isAcceptableOrUnknown(
          data['sub_jago_langganan_bp']!,
          _subJagoLanggananBpMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_subJagoLanggananBpMeta);
    }
    if (data.containsKey('sub_jago_darurat_bp')) {
      context.handle(
        _subJagoDaruratBpMeta,
        subJagoDaruratBp.isAcceptableOrUnknown(
          data['sub_jago_darurat_bp']!,
          _subJagoDaruratBpMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_subJagoDaruratBpMeta);
    }
    if (data.containsKey('sub_jago_operasional_bp')) {
      context.handle(
        _subJagoOperasionalBpMeta,
        subJagoOperasionalBp.isAcceptableOrUnknown(
          data['sub_jago_operasional_bp']!,
          _subJagoOperasionalBpMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_subJagoOperasionalBpMeta);
    }
    if (data.containsKey('hari_top_up_mingguan')) {
      context.handle(
        _hariTopUpMingguanMeta,
        hariTopUpMingguan.isAcceptableOrUnknown(
          data['hari_top_up_mingguan']!,
          _hariTopUpMingguanMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_hariTopUpMingguanMeta);
    }
    if (data.containsKey('total_pendapatan')) {
      context.handle(
        _totalPendapatanMeta,
        totalPendapatan.isAcceptableOrUnknown(
          data['total_pendapatan']!,
          _totalPendapatanMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalPendapatanMeta);
    }
    if (data.containsKey('total_pengeluaran_wajib')) {
      context.handle(
        _totalPengeluaranWajibMeta,
        totalPengeluaranWajib.isAcceptableOrUnknown(
          data['total_pengeluaran_wajib']!,
          _totalPengeluaranWajibMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalPengeluaranWajibMeta);
    }
    if (data.containsKey('dana_bersih')) {
      context.handle(
        _danaBersihMeta,
        danaBersih.isAcceptableOrUnknown(data['dana_bersih']!, _danaBersihMeta),
      );
    } else if (isInserting) {
      context.missing(_danaBersihMeta);
    }
    if (data.containsKey('alokasi_jago')) {
      context.handle(
        _alokasiJagoMeta,
        alokasiJago.isAcceptableOrUnknown(
          data['alokasi_jago']!,
          _alokasiJagoMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_alokasiJagoMeta);
    }
    if (data.containsKey('total_alokasi_investasi')) {
      context.handle(
        _totalAlokasiInvestasiMeta,
        totalAlokasiInvestasi.isAcceptableOrUnknown(
          data['total_alokasi_investasi']!,
          _totalAlokasiInvestasiMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalAlokasiInvestasiMeta);
    }
    if (data.containsKey('alokasi_dana')) {
      context.handle(
        _alokasiDanaMeta,
        alokasiDana.isAcceptableOrUnknown(
          data['alokasi_dana']!,
          _alokasiDanaMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_alokasiDanaMeta);
    }
    if (data.containsKey('alokasi_bibit')) {
      context.handle(
        _alokasiBibitMeta,
        alokasiBibit.isAcceptableOrUnknown(
          data['alokasi_bibit']!,
          _alokasiBibitMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_alokasiBibitMeta);
    }
    if (data.containsKey('alokasi_stockbit')) {
      context.handle(
        _alokasiStockbitMeta,
        alokasiStockbit.isAcceptableOrUnknown(
          data['alokasi_stockbit']!,
          _alokasiStockbitMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_alokasiStockbitMeta);
    }
    if (data.containsKey('total_dana_masuk_jago')) {
      context.handle(
        _totalDanaMasukJagoMeta,
        totalDanaMasukJago.isAcceptableOrUnknown(
          data['total_dana_masuk_jago']!,
          _totalDanaMasukJagoMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalDanaMasukJagoMeta);
    }
    if (data.containsKey('sub_jago_langganan')) {
      context.handle(
        _subJagoLanggananMeta,
        subJagoLangganan.isAcceptableOrUnknown(
          data['sub_jago_langganan']!,
          _subJagoLanggananMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_subJagoLanggananMeta);
    }
    if (data.containsKey('sub_jago_dana_darurat')) {
      context.handle(
        _subJagoDanaDaruratMeta,
        subJagoDanaDarurat.isAcceptableOrUnknown(
          data['sub_jago_dana_darurat']!,
          _subJagoDanaDaruratMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_subJagoDanaDaruratMeta);
    }
    if (data.containsKey('sub_jago_operasional')) {
      context.handle(
        _subJagoOperasionalMeta,
        subJagoOperasional.isAcceptableOrUnknown(
          data['sub_jago_operasional']!,
          _subJagoOperasionalMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_subJagoOperasionalMeta);
    }
    if (data.containsKey('dibuat_pada')) {
      context.handle(
        _dibuatPadaMeta,
        dibuatPada.isAcceptableOrUnknown(data['dibuat_pada']!, _dibuatPadaMeta),
      );
    } else if (isInserting) {
      context.missing(_dibuatPadaMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {monthlyAllocationId, nomorRevisi},
  ];
  @override
  MonthlyAllocationRevision map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MonthlyAllocationRevision(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      monthlyAllocationId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}monthly_allocation_id'],
      )!,
      nomorRevisi: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}nomor_revisi'],
      )!,
      status: $MonthlyAllocationRevisionsTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
      alasanPerubahan: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}alasan_perubahan'],
      ),
      catatan: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}catatan'],
      ),
      penghasilanUtama: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}penghasilan_utama'],
      )!,
      kasPeganganBrimo: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}kas_pegangan_brimo'],
      )!,
      preset: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}preset'],
      ),
      jagoBp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}jago_bp'],
      )!,
      investasiBp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}investasi_bp'],
      )!,
      danaBp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}dana_bp'],
      )!,
      bibitBp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}bibit_bp'],
      )!,
      stockbitBp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}stockbit_bp'],
      )!,
      pembulatan: $MonthlyAllocationRevisionsTable.$converterpembulatan.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}pembulatan'],
        )!,
      ),
      metodeSubJago: $MonthlyAllocationRevisionsTable.$convertermetodeSubJago
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.string,
              data['${effectivePrefix}metode_sub_jago'],
            )!,
          ),
      subJagoLanggananBp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sub_jago_langganan_bp'],
      )!,
      subJagoDaruratBp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sub_jago_darurat_bp'],
      )!,
      subJagoOperasionalBp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sub_jago_operasional_bp'],
      )!,
      frekuensiTopUpDana: $MonthlyAllocationRevisionsTable
          .$converterfrekuensiTopUpDana
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.string,
              data['${effectivePrefix}frekuensi_top_up_dana'],
            )!,
          ),
      hariTopUpMingguan: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}hari_top_up_mingguan'],
      )!,
      totalPendapatan: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_pendapatan'],
      )!,
      totalPengeluaranWajib: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_pengeluaran_wajib'],
      )!,
      danaBersih: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}dana_bersih'],
      )!,
      alokasiJago: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}alokasi_jago'],
      )!,
      totalAlokasiInvestasi: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_alokasi_investasi'],
      )!,
      alokasiDana: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}alokasi_dana'],
      )!,
      alokasiBibit: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}alokasi_bibit'],
      )!,
      alokasiStockbit: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}alokasi_stockbit'],
      )!,
      totalDanaMasukJago: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_dana_masuk_jago'],
      )!,
      subJagoLangganan: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sub_jago_langganan'],
      )!,
      subJagoDanaDarurat: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sub_jago_dana_darurat'],
      )!,
      subJagoOperasional: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sub_jago_operasional'],
      )!,
      dibuatPada: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}dibuat_pada'],
      )!,
    );
  }

  @override
  $MonthlyAllocationRevisionsTable createAlias(String alias) {
    return $MonthlyAllocationRevisionsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<RevisionStatus, String, String> $converterstatus =
      const EnumNameConverter<RevisionStatus>(RevisionStatus.values);
  static JsonTypeConverter2<RoundingOption, String, String>
  $converterpembulatan = const EnumNameConverter<RoundingOption>(
    RoundingOption.values,
  );
  static JsonTypeConverter2<JagoSubAllocationMethod, String, String>
  $convertermetodeSubJago = const EnumNameConverter<JagoSubAllocationMethod>(
    JagoSubAllocationMethod.values,
  );
  static JsonTypeConverter2<DanaTopUpFrequency, String, String>
  $converterfrekuensiTopUpDana = const EnumNameConverter<DanaTopUpFrequency>(
    DanaTopUpFrequency.values,
  );
}

class MonthlyAllocationRevision extends DataClass
    implements Insertable<MonthlyAllocationRevision> {
  final int id;
  final int monthlyAllocationId;
  final int nomorRevisi;
  final RevisionStatus status;
  final String? alasanPerubahan;
  final String? catatan;
  final int penghasilanUtama;
  final int kasPeganganBrimo;
  final String? preset;
  final int jagoBp;
  final int investasiBp;
  final int danaBp;
  final int bibitBp;
  final int stockbitBp;
  final RoundingOption pembulatan;
  final JagoSubAllocationMethod metodeSubJago;
  final int subJagoLanggananBp;
  final int subJagoDaruratBp;
  final int subJagoOperasionalBp;
  final DanaTopUpFrequency frekuensiTopUpDana;
  final int hariTopUpMingguan;
  final int totalPendapatan;
  final int totalPengeluaranWajib;
  final int danaBersih;
  final int alokasiJago;
  final int totalAlokasiInvestasi;
  final int alokasiDana;
  final int alokasiBibit;
  final int alokasiStockbit;
  final int totalDanaMasukJago;
  final int subJagoLangganan;
  final int subJagoDanaDarurat;
  final int subJagoOperasional;
  final DateTime dibuatPada;
  const MonthlyAllocationRevision({
    required this.id,
    required this.monthlyAllocationId,
    required this.nomorRevisi,
    required this.status,
    this.alasanPerubahan,
    this.catatan,
    required this.penghasilanUtama,
    required this.kasPeganganBrimo,
    this.preset,
    required this.jagoBp,
    required this.investasiBp,
    required this.danaBp,
    required this.bibitBp,
    required this.stockbitBp,
    required this.pembulatan,
    required this.metodeSubJago,
    required this.subJagoLanggananBp,
    required this.subJagoDaruratBp,
    required this.subJagoOperasionalBp,
    required this.frekuensiTopUpDana,
    required this.hariTopUpMingguan,
    required this.totalPendapatan,
    required this.totalPengeluaranWajib,
    required this.danaBersih,
    required this.alokasiJago,
    required this.totalAlokasiInvestasi,
    required this.alokasiDana,
    required this.alokasiBibit,
    required this.alokasiStockbit,
    required this.totalDanaMasukJago,
    required this.subJagoLangganan,
    required this.subJagoDanaDarurat,
    required this.subJagoOperasional,
    required this.dibuatPada,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['monthly_allocation_id'] = Variable<int>(monthlyAllocationId);
    map['nomor_revisi'] = Variable<int>(nomorRevisi);
    {
      map['status'] = Variable<String>(
        $MonthlyAllocationRevisionsTable.$converterstatus.toSql(status),
      );
    }
    if (!nullToAbsent || alasanPerubahan != null) {
      map['alasan_perubahan'] = Variable<String>(alasanPerubahan);
    }
    if (!nullToAbsent || catatan != null) {
      map['catatan'] = Variable<String>(catatan);
    }
    map['penghasilan_utama'] = Variable<int>(penghasilanUtama);
    map['kas_pegangan_brimo'] = Variable<int>(kasPeganganBrimo);
    if (!nullToAbsent || preset != null) {
      map['preset'] = Variable<String>(preset);
    }
    map['jago_bp'] = Variable<int>(jagoBp);
    map['investasi_bp'] = Variable<int>(investasiBp);
    map['dana_bp'] = Variable<int>(danaBp);
    map['bibit_bp'] = Variable<int>(bibitBp);
    map['stockbit_bp'] = Variable<int>(stockbitBp);
    {
      map['pembulatan'] = Variable<String>(
        $MonthlyAllocationRevisionsTable.$converterpembulatan.toSql(pembulatan),
      );
    }
    {
      map['metode_sub_jago'] = Variable<String>(
        $MonthlyAllocationRevisionsTable.$convertermetodeSubJago.toSql(
          metodeSubJago,
        ),
      );
    }
    map['sub_jago_langganan_bp'] = Variable<int>(subJagoLanggananBp);
    map['sub_jago_darurat_bp'] = Variable<int>(subJagoDaruratBp);
    map['sub_jago_operasional_bp'] = Variable<int>(subJagoOperasionalBp);
    {
      map['frekuensi_top_up_dana'] = Variable<String>(
        $MonthlyAllocationRevisionsTable.$converterfrekuensiTopUpDana.toSql(
          frekuensiTopUpDana,
        ),
      );
    }
    map['hari_top_up_mingguan'] = Variable<int>(hariTopUpMingguan);
    map['total_pendapatan'] = Variable<int>(totalPendapatan);
    map['total_pengeluaran_wajib'] = Variable<int>(totalPengeluaranWajib);
    map['dana_bersih'] = Variable<int>(danaBersih);
    map['alokasi_jago'] = Variable<int>(alokasiJago);
    map['total_alokasi_investasi'] = Variable<int>(totalAlokasiInvestasi);
    map['alokasi_dana'] = Variable<int>(alokasiDana);
    map['alokasi_bibit'] = Variable<int>(alokasiBibit);
    map['alokasi_stockbit'] = Variable<int>(alokasiStockbit);
    map['total_dana_masuk_jago'] = Variable<int>(totalDanaMasukJago);
    map['sub_jago_langganan'] = Variable<int>(subJagoLangganan);
    map['sub_jago_dana_darurat'] = Variable<int>(subJagoDanaDarurat);
    map['sub_jago_operasional'] = Variable<int>(subJagoOperasional);
    map['dibuat_pada'] = Variable<DateTime>(dibuatPada);
    return map;
  }

  MonthlyAllocationRevisionsCompanion toCompanion(bool nullToAbsent) {
    return MonthlyAllocationRevisionsCompanion(
      id: Value(id),
      monthlyAllocationId: Value(monthlyAllocationId),
      nomorRevisi: Value(nomorRevisi),
      status: Value(status),
      alasanPerubahan: alasanPerubahan == null && nullToAbsent
          ? const Value.absent()
          : Value(alasanPerubahan),
      catatan: catatan == null && nullToAbsent
          ? const Value.absent()
          : Value(catatan),
      penghasilanUtama: Value(penghasilanUtama),
      kasPeganganBrimo: Value(kasPeganganBrimo),
      preset: preset == null && nullToAbsent
          ? const Value.absent()
          : Value(preset),
      jagoBp: Value(jagoBp),
      investasiBp: Value(investasiBp),
      danaBp: Value(danaBp),
      bibitBp: Value(bibitBp),
      stockbitBp: Value(stockbitBp),
      pembulatan: Value(pembulatan),
      metodeSubJago: Value(metodeSubJago),
      subJagoLanggananBp: Value(subJagoLanggananBp),
      subJagoDaruratBp: Value(subJagoDaruratBp),
      subJagoOperasionalBp: Value(subJagoOperasionalBp),
      frekuensiTopUpDana: Value(frekuensiTopUpDana),
      hariTopUpMingguan: Value(hariTopUpMingguan),
      totalPendapatan: Value(totalPendapatan),
      totalPengeluaranWajib: Value(totalPengeluaranWajib),
      danaBersih: Value(danaBersih),
      alokasiJago: Value(alokasiJago),
      totalAlokasiInvestasi: Value(totalAlokasiInvestasi),
      alokasiDana: Value(alokasiDana),
      alokasiBibit: Value(alokasiBibit),
      alokasiStockbit: Value(alokasiStockbit),
      totalDanaMasukJago: Value(totalDanaMasukJago),
      subJagoLangganan: Value(subJagoLangganan),
      subJagoDanaDarurat: Value(subJagoDanaDarurat),
      subJagoOperasional: Value(subJagoOperasional),
      dibuatPada: Value(dibuatPada),
    );
  }

  factory MonthlyAllocationRevision.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MonthlyAllocationRevision(
      id: serializer.fromJson<int>(json['id']),
      monthlyAllocationId: serializer.fromJson<int>(
        json['monthlyAllocationId'],
      ),
      nomorRevisi: serializer.fromJson<int>(json['nomorRevisi']),
      status: $MonthlyAllocationRevisionsTable.$converterstatus.fromJson(
        serializer.fromJson<String>(json['status']),
      ),
      alasanPerubahan: serializer.fromJson<String?>(json['alasanPerubahan']),
      catatan: serializer.fromJson<String?>(json['catatan']),
      penghasilanUtama: serializer.fromJson<int>(json['penghasilanUtama']),
      kasPeganganBrimo: serializer.fromJson<int>(json['kasPeganganBrimo']),
      preset: serializer.fromJson<String?>(json['preset']),
      jagoBp: serializer.fromJson<int>(json['jagoBp']),
      investasiBp: serializer.fromJson<int>(json['investasiBp']),
      danaBp: serializer.fromJson<int>(json['danaBp']),
      bibitBp: serializer.fromJson<int>(json['bibitBp']),
      stockbitBp: serializer.fromJson<int>(json['stockbitBp']),
      pembulatan: $MonthlyAllocationRevisionsTable.$converterpembulatan
          .fromJson(serializer.fromJson<String>(json['pembulatan'])),
      metodeSubJago: $MonthlyAllocationRevisionsTable.$convertermetodeSubJago
          .fromJson(serializer.fromJson<String>(json['metodeSubJago'])),
      subJagoLanggananBp: serializer.fromJson<int>(json['subJagoLanggananBp']),
      subJagoDaruratBp: serializer.fromJson<int>(json['subJagoDaruratBp']),
      subJagoOperasionalBp: serializer.fromJson<int>(
        json['subJagoOperasionalBp'],
      ),
      frekuensiTopUpDana: $MonthlyAllocationRevisionsTable
          .$converterfrekuensiTopUpDana
          .fromJson(serializer.fromJson<String>(json['frekuensiTopUpDana'])),
      hariTopUpMingguan: serializer.fromJson<int>(json['hariTopUpMingguan']),
      totalPendapatan: serializer.fromJson<int>(json['totalPendapatan']),
      totalPengeluaranWajib: serializer.fromJson<int>(
        json['totalPengeluaranWajib'],
      ),
      danaBersih: serializer.fromJson<int>(json['danaBersih']),
      alokasiJago: serializer.fromJson<int>(json['alokasiJago']),
      totalAlokasiInvestasi: serializer.fromJson<int>(
        json['totalAlokasiInvestasi'],
      ),
      alokasiDana: serializer.fromJson<int>(json['alokasiDana']),
      alokasiBibit: serializer.fromJson<int>(json['alokasiBibit']),
      alokasiStockbit: serializer.fromJson<int>(json['alokasiStockbit']),
      totalDanaMasukJago: serializer.fromJson<int>(json['totalDanaMasukJago']),
      subJagoLangganan: serializer.fromJson<int>(json['subJagoLangganan']),
      subJagoDanaDarurat: serializer.fromJson<int>(json['subJagoDanaDarurat']),
      subJagoOperasional: serializer.fromJson<int>(json['subJagoOperasional']),
      dibuatPada: serializer.fromJson<DateTime>(json['dibuatPada']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'monthlyAllocationId': serializer.toJson<int>(monthlyAllocationId),
      'nomorRevisi': serializer.toJson<int>(nomorRevisi),
      'status': serializer.toJson<String>(
        $MonthlyAllocationRevisionsTable.$converterstatus.toJson(status),
      ),
      'alasanPerubahan': serializer.toJson<String?>(alasanPerubahan),
      'catatan': serializer.toJson<String?>(catatan),
      'penghasilanUtama': serializer.toJson<int>(penghasilanUtama),
      'kasPeganganBrimo': serializer.toJson<int>(kasPeganganBrimo),
      'preset': serializer.toJson<String?>(preset),
      'jagoBp': serializer.toJson<int>(jagoBp),
      'investasiBp': serializer.toJson<int>(investasiBp),
      'danaBp': serializer.toJson<int>(danaBp),
      'bibitBp': serializer.toJson<int>(bibitBp),
      'stockbitBp': serializer.toJson<int>(stockbitBp),
      'pembulatan': serializer.toJson<String>(
        $MonthlyAllocationRevisionsTable.$converterpembulatan.toJson(
          pembulatan,
        ),
      ),
      'metodeSubJago': serializer.toJson<String>(
        $MonthlyAllocationRevisionsTable.$convertermetodeSubJago.toJson(
          metodeSubJago,
        ),
      ),
      'subJagoLanggananBp': serializer.toJson<int>(subJagoLanggananBp),
      'subJagoDaruratBp': serializer.toJson<int>(subJagoDaruratBp),
      'subJagoOperasionalBp': serializer.toJson<int>(subJagoOperasionalBp),
      'frekuensiTopUpDana': serializer.toJson<String>(
        $MonthlyAllocationRevisionsTable.$converterfrekuensiTopUpDana.toJson(
          frekuensiTopUpDana,
        ),
      ),
      'hariTopUpMingguan': serializer.toJson<int>(hariTopUpMingguan),
      'totalPendapatan': serializer.toJson<int>(totalPendapatan),
      'totalPengeluaranWajib': serializer.toJson<int>(totalPengeluaranWajib),
      'danaBersih': serializer.toJson<int>(danaBersih),
      'alokasiJago': serializer.toJson<int>(alokasiJago),
      'totalAlokasiInvestasi': serializer.toJson<int>(totalAlokasiInvestasi),
      'alokasiDana': serializer.toJson<int>(alokasiDana),
      'alokasiBibit': serializer.toJson<int>(alokasiBibit),
      'alokasiStockbit': serializer.toJson<int>(alokasiStockbit),
      'totalDanaMasukJago': serializer.toJson<int>(totalDanaMasukJago),
      'subJagoLangganan': serializer.toJson<int>(subJagoLangganan),
      'subJagoDanaDarurat': serializer.toJson<int>(subJagoDanaDarurat),
      'subJagoOperasional': serializer.toJson<int>(subJagoOperasional),
      'dibuatPada': serializer.toJson<DateTime>(dibuatPada),
    };
  }

  MonthlyAllocationRevision copyWith({
    int? id,
    int? monthlyAllocationId,
    int? nomorRevisi,
    RevisionStatus? status,
    Value<String?> alasanPerubahan = const Value.absent(),
    Value<String?> catatan = const Value.absent(),
    int? penghasilanUtama,
    int? kasPeganganBrimo,
    Value<String?> preset = const Value.absent(),
    int? jagoBp,
    int? investasiBp,
    int? danaBp,
    int? bibitBp,
    int? stockbitBp,
    RoundingOption? pembulatan,
    JagoSubAllocationMethod? metodeSubJago,
    int? subJagoLanggananBp,
    int? subJagoDaruratBp,
    int? subJagoOperasionalBp,
    DanaTopUpFrequency? frekuensiTopUpDana,
    int? hariTopUpMingguan,
    int? totalPendapatan,
    int? totalPengeluaranWajib,
    int? danaBersih,
    int? alokasiJago,
    int? totalAlokasiInvestasi,
    int? alokasiDana,
    int? alokasiBibit,
    int? alokasiStockbit,
    int? totalDanaMasukJago,
    int? subJagoLangganan,
    int? subJagoDanaDarurat,
    int? subJagoOperasional,
    DateTime? dibuatPada,
  }) => MonthlyAllocationRevision(
    id: id ?? this.id,
    monthlyAllocationId: monthlyAllocationId ?? this.monthlyAllocationId,
    nomorRevisi: nomorRevisi ?? this.nomorRevisi,
    status: status ?? this.status,
    alasanPerubahan: alasanPerubahan.present
        ? alasanPerubahan.value
        : this.alasanPerubahan,
    catatan: catatan.present ? catatan.value : this.catatan,
    penghasilanUtama: penghasilanUtama ?? this.penghasilanUtama,
    kasPeganganBrimo: kasPeganganBrimo ?? this.kasPeganganBrimo,
    preset: preset.present ? preset.value : this.preset,
    jagoBp: jagoBp ?? this.jagoBp,
    investasiBp: investasiBp ?? this.investasiBp,
    danaBp: danaBp ?? this.danaBp,
    bibitBp: bibitBp ?? this.bibitBp,
    stockbitBp: stockbitBp ?? this.stockbitBp,
    pembulatan: pembulatan ?? this.pembulatan,
    metodeSubJago: metodeSubJago ?? this.metodeSubJago,
    subJagoLanggananBp: subJagoLanggananBp ?? this.subJagoLanggananBp,
    subJagoDaruratBp: subJagoDaruratBp ?? this.subJagoDaruratBp,
    subJagoOperasionalBp: subJagoOperasionalBp ?? this.subJagoOperasionalBp,
    frekuensiTopUpDana: frekuensiTopUpDana ?? this.frekuensiTopUpDana,
    hariTopUpMingguan: hariTopUpMingguan ?? this.hariTopUpMingguan,
    totalPendapatan: totalPendapatan ?? this.totalPendapatan,
    totalPengeluaranWajib: totalPengeluaranWajib ?? this.totalPengeluaranWajib,
    danaBersih: danaBersih ?? this.danaBersih,
    alokasiJago: alokasiJago ?? this.alokasiJago,
    totalAlokasiInvestasi: totalAlokasiInvestasi ?? this.totalAlokasiInvestasi,
    alokasiDana: alokasiDana ?? this.alokasiDana,
    alokasiBibit: alokasiBibit ?? this.alokasiBibit,
    alokasiStockbit: alokasiStockbit ?? this.alokasiStockbit,
    totalDanaMasukJago: totalDanaMasukJago ?? this.totalDanaMasukJago,
    subJagoLangganan: subJagoLangganan ?? this.subJagoLangganan,
    subJagoDanaDarurat: subJagoDanaDarurat ?? this.subJagoDanaDarurat,
    subJagoOperasional: subJagoOperasional ?? this.subJagoOperasional,
    dibuatPada: dibuatPada ?? this.dibuatPada,
  );
  MonthlyAllocationRevision copyWithCompanion(
    MonthlyAllocationRevisionsCompanion data,
  ) {
    return MonthlyAllocationRevision(
      id: data.id.present ? data.id.value : this.id,
      monthlyAllocationId: data.monthlyAllocationId.present
          ? data.monthlyAllocationId.value
          : this.monthlyAllocationId,
      nomorRevisi: data.nomorRevisi.present
          ? data.nomorRevisi.value
          : this.nomorRevisi,
      status: data.status.present ? data.status.value : this.status,
      alasanPerubahan: data.alasanPerubahan.present
          ? data.alasanPerubahan.value
          : this.alasanPerubahan,
      catatan: data.catatan.present ? data.catatan.value : this.catatan,
      penghasilanUtama: data.penghasilanUtama.present
          ? data.penghasilanUtama.value
          : this.penghasilanUtama,
      kasPeganganBrimo: data.kasPeganganBrimo.present
          ? data.kasPeganganBrimo.value
          : this.kasPeganganBrimo,
      preset: data.preset.present ? data.preset.value : this.preset,
      jagoBp: data.jagoBp.present ? data.jagoBp.value : this.jagoBp,
      investasiBp: data.investasiBp.present
          ? data.investasiBp.value
          : this.investasiBp,
      danaBp: data.danaBp.present ? data.danaBp.value : this.danaBp,
      bibitBp: data.bibitBp.present ? data.bibitBp.value : this.bibitBp,
      stockbitBp: data.stockbitBp.present
          ? data.stockbitBp.value
          : this.stockbitBp,
      pembulatan: data.pembulatan.present
          ? data.pembulatan.value
          : this.pembulatan,
      metodeSubJago: data.metodeSubJago.present
          ? data.metodeSubJago.value
          : this.metodeSubJago,
      subJagoLanggananBp: data.subJagoLanggananBp.present
          ? data.subJagoLanggananBp.value
          : this.subJagoLanggananBp,
      subJagoDaruratBp: data.subJagoDaruratBp.present
          ? data.subJagoDaruratBp.value
          : this.subJagoDaruratBp,
      subJagoOperasionalBp: data.subJagoOperasionalBp.present
          ? data.subJagoOperasionalBp.value
          : this.subJagoOperasionalBp,
      frekuensiTopUpDana: data.frekuensiTopUpDana.present
          ? data.frekuensiTopUpDana.value
          : this.frekuensiTopUpDana,
      hariTopUpMingguan: data.hariTopUpMingguan.present
          ? data.hariTopUpMingguan.value
          : this.hariTopUpMingguan,
      totalPendapatan: data.totalPendapatan.present
          ? data.totalPendapatan.value
          : this.totalPendapatan,
      totalPengeluaranWajib: data.totalPengeluaranWajib.present
          ? data.totalPengeluaranWajib.value
          : this.totalPengeluaranWajib,
      danaBersih: data.danaBersih.present
          ? data.danaBersih.value
          : this.danaBersih,
      alokasiJago: data.alokasiJago.present
          ? data.alokasiJago.value
          : this.alokasiJago,
      totalAlokasiInvestasi: data.totalAlokasiInvestasi.present
          ? data.totalAlokasiInvestasi.value
          : this.totalAlokasiInvestasi,
      alokasiDana: data.alokasiDana.present
          ? data.alokasiDana.value
          : this.alokasiDana,
      alokasiBibit: data.alokasiBibit.present
          ? data.alokasiBibit.value
          : this.alokasiBibit,
      alokasiStockbit: data.alokasiStockbit.present
          ? data.alokasiStockbit.value
          : this.alokasiStockbit,
      totalDanaMasukJago: data.totalDanaMasukJago.present
          ? data.totalDanaMasukJago.value
          : this.totalDanaMasukJago,
      subJagoLangganan: data.subJagoLangganan.present
          ? data.subJagoLangganan.value
          : this.subJagoLangganan,
      subJagoDanaDarurat: data.subJagoDanaDarurat.present
          ? data.subJagoDanaDarurat.value
          : this.subJagoDanaDarurat,
      subJagoOperasional: data.subJagoOperasional.present
          ? data.subJagoOperasional.value
          : this.subJagoOperasional,
      dibuatPada: data.dibuatPada.present
          ? data.dibuatPada.value
          : this.dibuatPada,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MonthlyAllocationRevision(')
          ..write('id: $id, ')
          ..write('monthlyAllocationId: $monthlyAllocationId, ')
          ..write('nomorRevisi: $nomorRevisi, ')
          ..write('status: $status, ')
          ..write('alasanPerubahan: $alasanPerubahan, ')
          ..write('catatan: $catatan, ')
          ..write('penghasilanUtama: $penghasilanUtama, ')
          ..write('kasPeganganBrimo: $kasPeganganBrimo, ')
          ..write('preset: $preset, ')
          ..write('jagoBp: $jagoBp, ')
          ..write('investasiBp: $investasiBp, ')
          ..write('danaBp: $danaBp, ')
          ..write('bibitBp: $bibitBp, ')
          ..write('stockbitBp: $stockbitBp, ')
          ..write('pembulatan: $pembulatan, ')
          ..write('metodeSubJago: $metodeSubJago, ')
          ..write('subJagoLanggananBp: $subJagoLanggananBp, ')
          ..write('subJagoDaruratBp: $subJagoDaruratBp, ')
          ..write('subJagoOperasionalBp: $subJagoOperasionalBp, ')
          ..write('frekuensiTopUpDana: $frekuensiTopUpDana, ')
          ..write('hariTopUpMingguan: $hariTopUpMingguan, ')
          ..write('totalPendapatan: $totalPendapatan, ')
          ..write('totalPengeluaranWajib: $totalPengeluaranWajib, ')
          ..write('danaBersih: $danaBersih, ')
          ..write('alokasiJago: $alokasiJago, ')
          ..write('totalAlokasiInvestasi: $totalAlokasiInvestasi, ')
          ..write('alokasiDana: $alokasiDana, ')
          ..write('alokasiBibit: $alokasiBibit, ')
          ..write('alokasiStockbit: $alokasiStockbit, ')
          ..write('totalDanaMasukJago: $totalDanaMasukJago, ')
          ..write('subJagoLangganan: $subJagoLangganan, ')
          ..write('subJagoDanaDarurat: $subJagoDanaDarurat, ')
          ..write('subJagoOperasional: $subJagoOperasional, ')
          ..write('dibuatPada: $dibuatPada')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    monthlyAllocationId,
    nomorRevisi,
    status,
    alasanPerubahan,
    catatan,
    penghasilanUtama,
    kasPeganganBrimo,
    preset,
    jagoBp,
    investasiBp,
    danaBp,
    bibitBp,
    stockbitBp,
    pembulatan,
    metodeSubJago,
    subJagoLanggananBp,
    subJagoDaruratBp,
    subJagoOperasionalBp,
    frekuensiTopUpDana,
    hariTopUpMingguan,
    totalPendapatan,
    totalPengeluaranWajib,
    danaBersih,
    alokasiJago,
    totalAlokasiInvestasi,
    alokasiDana,
    alokasiBibit,
    alokasiStockbit,
    totalDanaMasukJago,
    subJagoLangganan,
    subJagoDanaDarurat,
    subJagoOperasional,
    dibuatPada,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MonthlyAllocationRevision &&
          other.id == this.id &&
          other.monthlyAllocationId == this.monthlyAllocationId &&
          other.nomorRevisi == this.nomorRevisi &&
          other.status == this.status &&
          other.alasanPerubahan == this.alasanPerubahan &&
          other.catatan == this.catatan &&
          other.penghasilanUtama == this.penghasilanUtama &&
          other.kasPeganganBrimo == this.kasPeganganBrimo &&
          other.preset == this.preset &&
          other.jagoBp == this.jagoBp &&
          other.investasiBp == this.investasiBp &&
          other.danaBp == this.danaBp &&
          other.bibitBp == this.bibitBp &&
          other.stockbitBp == this.stockbitBp &&
          other.pembulatan == this.pembulatan &&
          other.metodeSubJago == this.metodeSubJago &&
          other.subJagoLanggananBp == this.subJagoLanggananBp &&
          other.subJagoDaruratBp == this.subJagoDaruratBp &&
          other.subJagoOperasionalBp == this.subJagoOperasionalBp &&
          other.frekuensiTopUpDana == this.frekuensiTopUpDana &&
          other.hariTopUpMingguan == this.hariTopUpMingguan &&
          other.totalPendapatan == this.totalPendapatan &&
          other.totalPengeluaranWajib == this.totalPengeluaranWajib &&
          other.danaBersih == this.danaBersih &&
          other.alokasiJago == this.alokasiJago &&
          other.totalAlokasiInvestasi == this.totalAlokasiInvestasi &&
          other.alokasiDana == this.alokasiDana &&
          other.alokasiBibit == this.alokasiBibit &&
          other.alokasiStockbit == this.alokasiStockbit &&
          other.totalDanaMasukJago == this.totalDanaMasukJago &&
          other.subJagoLangganan == this.subJagoLangganan &&
          other.subJagoDanaDarurat == this.subJagoDanaDarurat &&
          other.subJagoOperasional == this.subJagoOperasional &&
          other.dibuatPada == this.dibuatPada);
}

class MonthlyAllocationRevisionsCompanion
    extends UpdateCompanion<MonthlyAllocationRevision> {
  final Value<int> id;
  final Value<int> monthlyAllocationId;
  final Value<int> nomorRevisi;
  final Value<RevisionStatus> status;
  final Value<String?> alasanPerubahan;
  final Value<String?> catatan;
  final Value<int> penghasilanUtama;
  final Value<int> kasPeganganBrimo;
  final Value<String?> preset;
  final Value<int> jagoBp;
  final Value<int> investasiBp;
  final Value<int> danaBp;
  final Value<int> bibitBp;
  final Value<int> stockbitBp;
  final Value<RoundingOption> pembulatan;
  final Value<JagoSubAllocationMethod> metodeSubJago;
  final Value<int> subJagoLanggananBp;
  final Value<int> subJagoDaruratBp;
  final Value<int> subJagoOperasionalBp;
  final Value<DanaTopUpFrequency> frekuensiTopUpDana;
  final Value<int> hariTopUpMingguan;
  final Value<int> totalPendapatan;
  final Value<int> totalPengeluaranWajib;
  final Value<int> danaBersih;
  final Value<int> alokasiJago;
  final Value<int> totalAlokasiInvestasi;
  final Value<int> alokasiDana;
  final Value<int> alokasiBibit;
  final Value<int> alokasiStockbit;
  final Value<int> totalDanaMasukJago;
  final Value<int> subJagoLangganan;
  final Value<int> subJagoDanaDarurat;
  final Value<int> subJagoOperasional;
  final Value<DateTime> dibuatPada;
  const MonthlyAllocationRevisionsCompanion({
    this.id = const Value.absent(),
    this.monthlyAllocationId = const Value.absent(),
    this.nomorRevisi = const Value.absent(),
    this.status = const Value.absent(),
    this.alasanPerubahan = const Value.absent(),
    this.catatan = const Value.absent(),
    this.penghasilanUtama = const Value.absent(),
    this.kasPeganganBrimo = const Value.absent(),
    this.preset = const Value.absent(),
    this.jagoBp = const Value.absent(),
    this.investasiBp = const Value.absent(),
    this.danaBp = const Value.absent(),
    this.bibitBp = const Value.absent(),
    this.stockbitBp = const Value.absent(),
    this.pembulatan = const Value.absent(),
    this.metodeSubJago = const Value.absent(),
    this.subJagoLanggananBp = const Value.absent(),
    this.subJagoDaruratBp = const Value.absent(),
    this.subJagoOperasionalBp = const Value.absent(),
    this.frekuensiTopUpDana = const Value.absent(),
    this.hariTopUpMingguan = const Value.absent(),
    this.totalPendapatan = const Value.absent(),
    this.totalPengeluaranWajib = const Value.absent(),
    this.danaBersih = const Value.absent(),
    this.alokasiJago = const Value.absent(),
    this.totalAlokasiInvestasi = const Value.absent(),
    this.alokasiDana = const Value.absent(),
    this.alokasiBibit = const Value.absent(),
    this.alokasiStockbit = const Value.absent(),
    this.totalDanaMasukJago = const Value.absent(),
    this.subJagoLangganan = const Value.absent(),
    this.subJagoDanaDarurat = const Value.absent(),
    this.subJagoOperasional = const Value.absent(),
    this.dibuatPada = const Value.absent(),
  });
  MonthlyAllocationRevisionsCompanion.insert({
    this.id = const Value.absent(),
    required int monthlyAllocationId,
    required int nomorRevisi,
    required RevisionStatus status,
    this.alasanPerubahan = const Value.absent(),
    this.catatan = const Value.absent(),
    required int penghasilanUtama,
    required int kasPeganganBrimo,
    this.preset = const Value.absent(),
    required int jagoBp,
    required int investasiBp,
    required int danaBp,
    required int bibitBp,
    required int stockbitBp,
    required RoundingOption pembulatan,
    required JagoSubAllocationMethod metodeSubJago,
    required int subJagoLanggananBp,
    required int subJagoDaruratBp,
    required int subJagoOperasionalBp,
    required DanaTopUpFrequency frekuensiTopUpDana,
    required int hariTopUpMingguan,
    required int totalPendapatan,
    required int totalPengeluaranWajib,
    required int danaBersih,
    required int alokasiJago,
    required int totalAlokasiInvestasi,
    required int alokasiDana,
    required int alokasiBibit,
    required int alokasiStockbit,
    required int totalDanaMasukJago,
    required int subJagoLangganan,
    required int subJagoDanaDarurat,
    required int subJagoOperasional,
    required DateTime dibuatPada,
  }) : monthlyAllocationId = Value(monthlyAllocationId),
       nomorRevisi = Value(nomorRevisi),
       status = Value(status),
       penghasilanUtama = Value(penghasilanUtama),
       kasPeganganBrimo = Value(kasPeganganBrimo),
       jagoBp = Value(jagoBp),
       investasiBp = Value(investasiBp),
       danaBp = Value(danaBp),
       bibitBp = Value(bibitBp),
       stockbitBp = Value(stockbitBp),
       pembulatan = Value(pembulatan),
       metodeSubJago = Value(metodeSubJago),
       subJagoLanggananBp = Value(subJagoLanggananBp),
       subJagoDaruratBp = Value(subJagoDaruratBp),
       subJagoOperasionalBp = Value(subJagoOperasionalBp),
       frekuensiTopUpDana = Value(frekuensiTopUpDana),
       hariTopUpMingguan = Value(hariTopUpMingguan),
       totalPendapatan = Value(totalPendapatan),
       totalPengeluaranWajib = Value(totalPengeluaranWajib),
       danaBersih = Value(danaBersih),
       alokasiJago = Value(alokasiJago),
       totalAlokasiInvestasi = Value(totalAlokasiInvestasi),
       alokasiDana = Value(alokasiDana),
       alokasiBibit = Value(alokasiBibit),
       alokasiStockbit = Value(alokasiStockbit),
       totalDanaMasukJago = Value(totalDanaMasukJago),
       subJagoLangganan = Value(subJagoLangganan),
       subJagoDanaDarurat = Value(subJagoDanaDarurat),
       subJagoOperasional = Value(subJagoOperasional),
       dibuatPada = Value(dibuatPada);
  static Insertable<MonthlyAllocationRevision> custom({
    Expression<int>? id,
    Expression<int>? monthlyAllocationId,
    Expression<int>? nomorRevisi,
    Expression<String>? status,
    Expression<String>? alasanPerubahan,
    Expression<String>? catatan,
    Expression<int>? penghasilanUtama,
    Expression<int>? kasPeganganBrimo,
    Expression<String>? preset,
    Expression<int>? jagoBp,
    Expression<int>? investasiBp,
    Expression<int>? danaBp,
    Expression<int>? bibitBp,
    Expression<int>? stockbitBp,
    Expression<String>? pembulatan,
    Expression<String>? metodeSubJago,
    Expression<int>? subJagoLanggananBp,
    Expression<int>? subJagoDaruratBp,
    Expression<int>? subJagoOperasionalBp,
    Expression<String>? frekuensiTopUpDana,
    Expression<int>? hariTopUpMingguan,
    Expression<int>? totalPendapatan,
    Expression<int>? totalPengeluaranWajib,
    Expression<int>? danaBersih,
    Expression<int>? alokasiJago,
    Expression<int>? totalAlokasiInvestasi,
    Expression<int>? alokasiDana,
    Expression<int>? alokasiBibit,
    Expression<int>? alokasiStockbit,
    Expression<int>? totalDanaMasukJago,
    Expression<int>? subJagoLangganan,
    Expression<int>? subJagoDanaDarurat,
    Expression<int>? subJagoOperasional,
    Expression<DateTime>? dibuatPada,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (monthlyAllocationId != null)
        'monthly_allocation_id': monthlyAllocationId,
      if (nomorRevisi != null) 'nomor_revisi': nomorRevisi,
      if (status != null) 'status': status,
      if (alasanPerubahan != null) 'alasan_perubahan': alasanPerubahan,
      if (catatan != null) 'catatan': catatan,
      if (penghasilanUtama != null) 'penghasilan_utama': penghasilanUtama,
      if (kasPeganganBrimo != null) 'kas_pegangan_brimo': kasPeganganBrimo,
      if (preset != null) 'preset': preset,
      if (jagoBp != null) 'jago_bp': jagoBp,
      if (investasiBp != null) 'investasi_bp': investasiBp,
      if (danaBp != null) 'dana_bp': danaBp,
      if (bibitBp != null) 'bibit_bp': bibitBp,
      if (stockbitBp != null) 'stockbit_bp': stockbitBp,
      if (pembulatan != null) 'pembulatan': pembulatan,
      if (metodeSubJago != null) 'metode_sub_jago': metodeSubJago,
      if (subJagoLanggananBp != null)
        'sub_jago_langganan_bp': subJagoLanggananBp,
      if (subJagoDaruratBp != null) 'sub_jago_darurat_bp': subJagoDaruratBp,
      if (subJagoOperasionalBp != null)
        'sub_jago_operasional_bp': subJagoOperasionalBp,
      if (frekuensiTopUpDana != null)
        'frekuensi_top_up_dana': frekuensiTopUpDana,
      if (hariTopUpMingguan != null) 'hari_top_up_mingguan': hariTopUpMingguan,
      if (totalPendapatan != null) 'total_pendapatan': totalPendapatan,
      if (totalPengeluaranWajib != null)
        'total_pengeluaran_wajib': totalPengeluaranWajib,
      if (danaBersih != null) 'dana_bersih': danaBersih,
      if (alokasiJago != null) 'alokasi_jago': alokasiJago,
      if (totalAlokasiInvestasi != null)
        'total_alokasi_investasi': totalAlokasiInvestasi,
      if (alokasiDana != null) 'alokasi_dana': alokasiDana,
      if (alokasiBibit != null) 'alokasi_bibit': alokasiBibit,
      if (alokasiStockbit != null) 'alokasi_stockbit': alokasiStockbit,
      if (totalDanaMasukJago != null)
        'total_dana_masuk_jago': totalDanaMasukJago,
      if (subJagoLangganan != null) 'sub_jago_langganan': subJagoLangganan,
      if (subJagoDanaDarurat != null)
        'sub_jago_dana_darurat': subJagoDanaDarurat,
      if (subJagoOperasional != null)
        'sub_jago_operasional': subJagoOperasional,
      if (dibuatPada != null) 'dibuat_pada': dibuatPada,
    });
  }

  MonthlyAllocationRevisionsCompanion copyWith({
    Value<int>? id,
    Value<int>? monthlyAllocationId,
    Value<int>? nomorRevisi,
    Value<RevisionStatus>? status,
    Value<String?>? alasanPerubahan,
    Value<String?>? catatan,
    Value<int>? penghasilanUtama,
    Value<int>? kasPeganganBrimo,
    Value<String?>? preset,
    Value<int>? jagoBp,
    Value<int>? investasiBp,
    Value<int>? danaBp,
    Value<int>? bibitBp,
    Value<int>? stockbitBp,
    Value<RoundingOption>? pembulatan,
    Value<JagoSubAllocationMethod>? metodeSubJago,
    Value<int>? subJagoLanggananBp,
    Value<int>? subJagoDaruratBp,
    Value<int>? subJagoOperasionalBp,
    Value<DanaTopUpFrequency>? frekuensiTopUpDana,
    Value<int>? hariTopUpMingguan,
    Value<int>? totalPendapatan,
    Value<int>? totalPengeluaranWajib,
    Value<int>? danaBersih,
    Value<int>? alokasiJago,
    Value<int>? totalAlokasiInvestasi,
    Value<int>? alokasiDana,
    Value<int>? alokasiBibit,
    Value<int>? alokasiStockbit,
    Value<int>? totalDanaMasukJago,
    Value<int>? subJagoLangganan,
    Value<int>? subJagoDanaDarurat,
    Value<int>? subJagoOperasional,
    Value<DateTime>? dibuatPada,
  }) {
    return MonthlyAllocationRevisionsCompanion(
      id: id ?? this.id,
      monthlyAllocationId: monthlyAllocationId ?? this.monthlyAllocationId,
      nomorRevisi: nomorRevisi ?? this.nomorRevisi,
      status: status ?? this.status,
      alasanPerubahan: alasanPerubahan ?? this.alasanPerubahan,
      catatan: catatan ?? this.catatan,
      penghasilanUtama: penghasilanUtama ?? this.penghasilanUtama,
      kasPeganganBrimo: kasPeganganBrimo ?? this.kasPeganganBrimo,
      preset: preset ?? this.preset,
      jagoBp: jagoBp ?? this.jagoBp,
      investasiBp: investasiBp ?? this.investasiBp,
      danaBp: danaBp ?? this.danaBp,
      bibitBp: bibitBp ?? this.bibitBp,
      stockbitBp: stockbitBp ?? this.stockbitBp,
      pembulatan: pembulatan ?? this.pembulatan,
      metodeSubJago: metodeSubJago ?? this.metodeSubJago,
      subJagoLanggananBp: subJagoLanggananBp ?? this.subJagoLanggananBp,
      subJagoDaruratBp: subJagoDaruratBp ?? this.subJagoDaruratBp,
      subJagoOperasionalBp: subJagoOperasionalBp ?? this.subJagoOperasionalBp,
      frekuensiTopUpDana: frekuensiTopUpDana ?? this.frekuensiTopUpDana,
      hariTopUpMingguan: hariTopUpMingguan ?? this.hariTopUpMingguan,
      totalPendapatan: totalPendapatan ?? this.totalPendapatan,
      totalPengeluaranWajib:
          totalPengeluaranWajib ?? this.totalPengeluaranWajib,
      danaBersih: danaBersih ?? this.danaBersih,
      alokasiJago: alokasiJago ?? this.alokasiJago,
      totalAlokasiInvestasi:
          totalAlokasiInvestasi ?? this.totalAlokasiInvestasi,
      alokasiDana: alokasiDana ?? this.alokasiDana,
      alokasiBibit: alokasiBibit ?? this.alokasiBibit,
      alokasiStockbit: alokasiStockbit ?? this.alokasiStockbit,
      totalDanaMasukJago: totalDanaMasukJago ?? this.totalDanaMasukJago,
      subJagoLangganan: subJagoLangganan ?? this.subJagoLangganan,
      subJagoDanaDarurat: subJagoDanaDarurat ?? this.subJagoDanaDarurat,
      subJagoOperasional: subJagoOperasional ?? this.subJagoOperasional,
      dibuatPada: dibuatPada ?? this.dibuatPada,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (monthlyAllocationId.present) {
      map['monthly_allocation_id'] = Variable<int>(monthlyAllocationId.value);
    }
    if (nomorRevisi.present) {
      map['nomor_revisi'] = Variable<int>(nomorRevisi.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $MonthlyAllocationRevisionsTable.$converterstatus.toSql(status.value),
      );
    }
    if (alasanPerubahan.present) {
      map['alasan_perubahan'] = Variable<String>(alasanPerubahan.value);
    }
    if (catatan.present) {
      map['catatan'] = Variable<String>(catatan.value);
    }
    if (penghasilanUtama.present) {
      map['penghasilan_utama'] = Variable<int>(penghasilanUtama.value);
    }
    if (kasPeganganBrimo.present) {
      map['kas_pegangan_brimo'] = Variable<int>(kasPeganganBrimo.value);
    }
    if (preset.present) {
      map['preset'] = Variable<String>(preset.value);
    }
    if (jagoBp.present) {
      map['jago_bp'] = Variable<int>(jagoBp.value);
    }
    if (investasiBp.present) {
      map['investasi_bp'] = Variable<int>(investasiBp.value);
    }
    if (danaBp.present) {
      map['dana_bp'] = Variable<int>(danaBp.value);
    }
    if (bibitBp.present) {
      map['bibit_bp'] = Variable<int>(bibitBp.value);
    }
    if (stockbitBp.present) {
      map['stockbit_bp'] = Variable<int>(stockbitBp.value);
    }
    if (pembulatan.present) {
      map['pembulatan'] = Variable<String>(
        $MonthlyAllocationRevisionsTable.$converterpembulatan.toSql(
          pembulatan.value,
        ),
      );
    }
    if (metodeSubJago.present) {
      map['metode_sub_jago'] = Variable<String>(
        $MonthlyAllocationRevisionsTable.$convertermetodeSubJago.toSql(
          metodeSubJago.value,
        ),
      );
    }
    if (subJagoLanggananBp.present) {
      map['sub_jago_langganan_bp'] = Variable<int>(subJagoLanggananBp.value);
    }
    if (subJagoDaruratBp.present) {
      map['sub_jago_darurat_bp'] = Variable<int>(subJagoDaruratBp.value);
    }
    if (subJagoOperasionalBp.present) {
      map['sub_jago_operasional_bp'] = Variable<int>(
        subJagoOperasionalBp.value,
      );
    }
    if (frekuensiTopUpDana.present) {
      map['frekuensi_top_up_dana'] = Variable<String>(
        $MonthlyAllocationRevisionsTable.$converterfrekuensiTopUpDana.toSql(
          frekuensiTopUpDana.value,
        ),
      );
    }
    if (hariTopUpMingguan.present) {
      map['hari_top_up_mingguan'] = Variable<int>(hariTopUpMingguan.value);
    }
    if (totalPendapatan.present) {
      map['total_pendapatan'] = Variable<int>(totalPendapatan.value);
    }
    if (totalPengeluaranWajib.present) {
      map['total_pengeluaran_wajib'] = Variable<int>(
        totalPengeluaranWajib.value,
      );
    }
    if (danaBersih.present) {
      map['dana_bersih'] = Variable<int>(danaBersih.value);
    }
    if (alokasiJago.present) {
      map['alokasi_jago'] = Variable<int>(alokasiJago.value);
    }
    if (totalAlokasiInvestasi.present) {
      map['total_alokasi_investasi'] = Variable<int>(
        totalAlokasiInvestasi.value,
      );
    }
    if (alokasiDana.present) {
      map['alokasi_dana'] = Variable<int>(alokasiDana.value);
    }
    if (alokasiBibit.present) {
      map['alokasi_bibit'] = Variable<int>(alokasiBibit.value);
    }
    if (alokasiStockbit.present) {
      map['alokasi_stockbit'] = Variable<int>(alokasiStockbit.value);
    }
    if (totalDanaMasukJago.present) {
      map['total_dana_masuk_jago'] = Variable<int>(totalDanaMasukJago.value);
    }
    if (subJagoLangganan.present) {
      map['sub_jago_langganan'] = Variable<int>(subJagoLangganan.value);
    }
    if (subJagoDanaDarurat.present) {
      map['sub_jago_dana_darurat'] = Variable<int>(subJagoDanaDarurat.value);
    }
    if (subJagoOperasional.present) {
      map['sub_jago_operasional'] = Variable<int>(subJagoOperasional.value);
    }
    if (dibuatPada.present) {
      map['dibuat_pada'] = Variable<DateTime>(dibuatPada.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MonthlyAllocationRevisionsCompanion(')
          ..write('id: $id, ')
          ..write('monthlyAllocationId: $monthlyAllocationId, ')
          ..write('nomorRevisi: $nomorRevisi, ')
          ..write('status: $status, ')
          ..write('alasanPerubahan: $alasanPerubahan, ')
          ..write('catatan: $catatan, ')
          ..write('penghasilanUtama: $penghasilanUtama, ')
          ..write('kasPeganganBrimo: $kasPeganganBrimo, ')
          ..write('preset: $preset, ')
          ..write('jagoBp: $jagoBp, ')
          ..write('investasiBp: $investasiBp, ')
          ..write('danaBp: $danaBp, ')
          ..write('bibitBp: $bibitBp, ')
          ..write('stockbitBp: $stockbitBp, ')
          ..write('pembulatan: $pembulatan, ')
          ..write('metodeSubJago: $metodeSubJago, ')
          ..write('subJagoLanggananBp: $subJagoLanggananBp, ')
          ..write('subJagoDaruratBp: $subJagoDaruratBp, ')
          ..write('subJagoOperasionalBp: $subJagoOperasionalBp, ')
          ..write('frekuensiTopUpDana: $frekuensiTopUpDana, ')
          ..write('hariTopUpMingguan: $hariTopUpMingguan, ')
          ..write('totalPendapatan: $totalPendapatan, ')
          ..write('totalPengeluaranWajib: $totalPengeluaranWajib, ')
          ..write('danaBersih: $danaBersih, ')
          ..write('alokasiJago: $alokasiJago, ')
          ..write('totalAlokasiInvestasi: $totalAlokasiInvestasi, ')
          ..write('alokasiDana: $alokasiDana, ')
          ..write('alokasiBibit: $alokasiBibit, ')
          ..write('alokasiStockbit: $alokasiStockbit, ')
          ..write('totalDanaMasukJago: $totalDanaMasukJago, ')
          ..write('subJagoLangganan: $subJagoLangganan, ')
          ..write('subJagoDanaDarurat: $subJagoDanaDarurat, ')
          ..write('subJagoOperasional: $subJagoOperasional, ')
          ..write('dibuatPada: $dibuatPada')
          ..write(')'))
        .toString();
  }
}

class $IncomeSourcesTable extends IncomeSources
    with TableInfo<$IncomeSourcesTable, IncomeSource> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $IncomeSourcesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _revisionIdMeta = const VerificationMeta(
    'revisionId',
  );
  @override
  late final GeneratedColumn<int> revisionId = GeneratedColumn<int>(
    'revision_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES monthly_allocation_revisions (id)',
    ),
  );
  static const VerificationMeta _namaMeta = const VerificationMeta('nama');
  @override
  late final GeneratedColumn<String> nama = GeneratedColumn<String>(
    'nama',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nominalMeta = const VerificationMeta(
    'nominal',
  );
  @override
  late final GeneratedColumn<int> nominal = GeneratedColumn<int>(
    'nominal',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rutinMeta = const VerificationMeta('rutin');
  @override
  late final GeneratedColumn<bool> rutin = GeneratedColumn<bool>(
    'rutin',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("rutin" IN (0, 1))',
    ),
  );
  static const VerificationMeta _disertakanBulanAktifMeta =
      const VerificationMeta('disertakanBulanAktif');
  @override
  late final GeneratedColumn<bool> disertakanBulanAktif = GeneratedColumn<bool>(
    'disertakan_bulan_aktif',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("disertakan_bulan_aktif" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    revisionId,
    nama,
    nominal,
    rutin,
    disertakanBulanAktif,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'income_sources';
  @override
  VerificationContext validateIntegrity(
    Insertable<IncomeSource> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('revision_id')) {
      context.handle(
        _revisionIdMeta,
        revisionId.isAcceptableOrUnknown(data['revision_id']!, _revisionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_revisionIdMeta);
    }
    if (data.containsKey('nama')) {
      context.handle(
        _namaMeta,
        nama.isAcceptableOrUnknown(data['nama']!, _namaMeta),
      );
    } else if (isInserting) {
      context.missing(_namaMeta);
    }
    if (data.containsKey('nominal')) {
      context.handle(
        _nominalMeta,
        nominal.isAcceptableOrUnknown(data['nominal']!, _nominalMeta),
      );
    } else if (isInserting) {
      context.missing(_nominalMeta);
    }
    if (data.containsKey('rutin')) {
      context.handle(
        _rutinMeta,
        rutin.isAcceptableOrUnknown(data['rutin']!, _rutinMeta),
      );
    } else if (isInserting) {
      context.missing(_rutinMeta);
    }
    if (data.containsKey('disertakan_bulan_aktif')) {
      context.handle(
        _disertakanBulanAktifMeta,
        disertakanBulanAktif.isAcceptableOrUnknown(
          data['disertakan_bulan_aktif']!,
          _disertakanBulanAktifMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_disertakanBulanAktifMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  IncomeSource map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return IncomeSource(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      revisionId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}revision_id'],
      )!,
      nama: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nama'],
      )!,
      nominal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}nominal'],
      )!,
      rutin: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}rutin'],
      )!,
      disertakanBulanAktif: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}disertakan_bulan_aktif'],
      )!,
    );
  }

  @override
  $IncomeSourcesTable createAlias(String alias) {
    return $IncomeSourcesTable(attachedDatabase, alias);
  }
}

class IncomeSource extends DataClass implements Insertable<IncomeSource> {
  final int id;
  final int revisionId;
  final String nama;
  final int nominal;
  final bool rutin;
  final bool disertakanBulanAktif;
  const IncomeSource({
    required this.id,
    required this.revisionId,
    required this.nama,
    required this.nominal,
    required this.rutin,
    required this.disertakanBulanAktif,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['revision_id'] = Variable<int>(revisionId);
    map['nama'] = Variable<String>(nama);
    map['nominal'] = Variable<int>(nominal);
    map['rutin'] = Variable<bool>(rutin);
    map['disertakan_bulan_aktif'] = Variable<bool>(disertakanBulanAktif);
    return map;
  }

  IncomeSourcesCompanion toCompanion(bool nullToAbsent) {
    return IncomeSourcesCompanion(
      id: Value(id),
      revisionId: Value(revisionId),
      nama: Value(nama),
      nominal: Value(nominal),
      rutin: Value(rutin),
      disertakanBulanAktif: Value(disertakanBulanAktif),
    );
  }

  factory IncomeSource.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return IncomeSource(
      id: serializer.fromJson<int>(json['id']),
      revisionId: serializer.fromJson<int>(json['revisionId']),
      nama: serializer.fromJson<String>(json['nama']),
      nominal: serializer.fromJson<int>(json['nominal']),
      rutin: serializer.fromJson<bool>(json['rutin']),
      disertakanBulanAktif: serializer.fromJson<bool>(
        json['disertakanBulanAktif'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'revisionId': serializer.toJson<int>(revisionId),
      'nama': serializer.toJson<String>(nama),
      'nominal': serializer.toJson<int>(nominal),
      'rutin': serializer.toJson<bool>(rutin),
      'disertakanBulanAktif': serializer.toJson<bool>(disertakanBulanAktif),
    };
  }

  IncomeSource copyWith({
    int? id,
    int? revisionId,
    String? nama,
    int? nominal,
    bool? rutin,
    bool? disertakanBulanAktif,
  }) => IncomeSource(
    id: id ?? this.id,
    revisionId: revisionId ?? this.revisionId,
    nama: nama ?? this.nama,
    nominal: nominal ?? this.nominal,
    rutin: rutin ?? this.rutin,
    disertakanBulanAktif: disertakanBulanAktif ?? this.disertakanBulanAktif,
  );
  IncomeSource copyWithCompanion(IncomeSourcesCompanion data) {
    return IncomeSource(
      id: data.id.present ? data.id.value : this.id,
      revisionId: data.revisionId.present
          ? data.revisionId.value
          : this.revisionId,
      nama: data.nama.present ? data.nama.value : this.nama,
      nominal: data.nominal.present ? data.nominal.value : this.nominal,
      rutin: data.rutin.present ? data.rutin.value : this.rutin,
      disertakanBulanAktif: data.disertakanBulanAktif.present
          ? data.disertakanBulanAktif.value
          : this.disertakanBulanAktif,
    );
  }

  @override
  String toString() {
    return (StringBuffer('IncomeSource(')
          ..write('id: $id, ')
          ..write('revisionId: $revisionId, ')
          ..write('nama: $nama, ')
          ..write('nominal: $nominal, ')
          ..write('rutin: $rutin, ')
          ..write('disertakanBulanAktif: $disertakanBulanAktif')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, revisionId, nama, nominal, rutin, disertakanBulanAktif);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is IncomeSource &&
          other.id == this.id &&
          other.revisionId == this.revisionId &&
          other.nama == this.nama &&
          other.nominal == this.nominal &&
          other.rutin == this.rutin &&
          other.disertakanBulanAktif == this.disertakanBulanAktif);
}

class IncomeSourcesCompanion extends UpdateCompanion<IncomeSource> {
  final Value<int> id;
  final Value<int> revisionId;
  final Value<String> nama;
  final Value<int> nominal;
  final Value<bool> rutin;
  final Value<bool> disertakanBulanAktif;
  const IncomeSourcesCompanion({
    this.id = const Value.absent(),
    this.revisionId = const Value.absent(),
    this.nama = const Value.absent(),
    this.nominal = const Value.absent(),
    this.rutin = const Value.absent(),
    this.disertakanBulanAktif = const Value.absent(),
  });
  IncomeSourcesCompanion.insert({
    this.id = const Value.absent(),
    required int revisionId,
    required String nama,
    required int nominal,
    required bool rutin,
    required bool disertakanBulanAktif,
  }) : revisionId = Value(revisionId),
       nama = Value(nama),
       nominal = Value(nominal),
       rutin = Value(rutin),
       disertakanBulanAktif = Value(disertakanBulanAktif);
  static Insertable<IncomeSource> custom({
    Expression<int>? id,
    Expression<int>? revisionId,
    Expression<String>? nama,
    Expression<int>? nominal,
    Expression<bool>? rutin,
    Expression<bool>? disertakanBulanAktif,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (revisionId != null) 'revision_id': revisionId,
      if (nama != null) 'nama': nama,
      if (nominal != null) 'nominal': nominal,
      if (rutin != null) 'rutin': rutin,
      if (disertakanBulanAktif != null)
        'disertakan_bulan_aktif': disertakanBulanAktif,
    });
  }

  IncomeSourcesCompanion copyWith({
    Value<int>? id,
    Value<int>? revisionId,
    Value<String>? nama,
    Value<int>? nominal,
    Value<bool>? rutin,
    Value<bool>? disertakanBulanAktif,
  }) {
    return IncomeSourcesCompanion(
      id: id ?? this.id,
      revisionId: revisionId ?? this.revisionId,
      nama: nama ?? this.nama,
      nominal: nominal ?? this.nominal,
      rutin: rutin ?? this.rutin,
      disertakanBulanAktif: disertakanBulanAktif ?? this.disertakanBulanAktif,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (revisionId.present) {
      map['revision_id'] = Variable<int>(revisionId.value);
    }
    if (nama.present) {
      map['nama'] = Variable<String>(nama.value);
    }
    if (nominal.present) {
      map['nominal'] = Variable<int>(nominal.value);
    }
    if (rutin.present) {
      map['rutin'] = Variable<bool>(rutin.value);
    }
    if (disertakanBulanAktif.present) {
      map['disertakan_bulan_aktif'] = Variable<bool>(
        disertakanBulanAktif.value,
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('IncomeSourcesCompanion(')
          ..write('id: $id, ')
          ..write('revisionId: $revisionId, ')
          ..write('nama: $nama, ')
          ..write('nominal: $nominal, ')
          ..write('rutin: $rutin, ')
          ..write('disertakanBulanAktif: $disertakanBulanAktif')
          ..write(')'))
        .toString();
  }
}

class $MandatoryExpensesTable extends MandatoryExpenses
    with TableInfo<$MandatoryExpensesTable, MandatoryExpense> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MandatoryExpensesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _revisionIdMeta = const VerificationMeta(
    'revisionId',
  );
  @override
  late final GeneratedColumn<int> revisionId = GeneratedColumn<int>(
    'revision_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES monthly_allocation_revisions (id)',
    ),
  );
  static const VerificationMeta _namaMeta = const VerificationMeta('nama');
  @override
  late final GeneratedColumn<String> nama = GeneratedColumn<String>(
    'nama',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kategoriMeta = const VerificationMeta(
    'kategori',
  );
  @override
  late final GeneratedColumn<String> kategori = GeneratedColumn<String>(
    'kategori',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nominalMeta = const VerificationMeta(
    'nominal',
  );
  @override
  late final GeneratedColumn<int> nominal = GeneratedColumn<int>(
    'nominal',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tanggalJatuhTempoMeta = const VerificationMeta(
    'tanggalJatuhTempo',
  );
  @override
  late final GeneratedColumn<int> tanggalJatuhTempo = GeneratedColumn<int>(
    'tanggal_jatuh_tempo',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _rutinMeta = const VerificationMeta('rutin');
  @override
  late final GeneratedColumn<bool> rutin = GeneratedColumn<bool>(
    'rutin',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("rutin" IN (0, 1))',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<ExpenseAmountType, String>
  jenisNominal =
      GeneratedColumn<String>(
        'jenis_nominal',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<ExpenseAmountType>(
        $MandatoryExpensesTable.$converterjenisNominal,
      );
  static const VerificationMeta _kebutuhanPokokMeta = const VerificationMeta(
    'kebutuhanPokok',
  );
  @override
  late final GeneratedColumn<bool> kebutuhanPokok = GeneratedColumn<bool>(
    'kebutuhan_pokok',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("kebutuhan_pokok" IN (0, 1))',
    ),
  );
  static const VerificationMeta _dihitungDasarDanaDaruratMeta =
      const VerificationMeta('dihitungDasarDanaDarurat');
  @override
  late final GeneratedColumn<bool> dihitungDasarDanaDarurat =
      GeneratedColumn<bool>(
        'dihitung_dasar_dana_darurat',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: true,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("dihitung_dasar_dana_darurat" IN (0, 1))',
        ),
      );
  @override
  late final GeneratedColumnWithTypeConverter<PaymentChannel, String>
  kanalPembayaran =
      GeneratedColumn<String>(
        'kanal_pembayaran',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<PaymentChannel>(
        $MandatoryExpensesTable.$converterkanalPembayaran,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    revisionId,
    nama,
    kategori,
    nominal,
    tanggalJatuhTempo,
    rutin,
    jenisNominal,
    kebutuhanPokok,
    dihitungDasarDanaDarurat,
    kanalPembayaran,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'mandatory_expenses';
  @override
  VerificationContext validateIntegrity(
    Insertable<MandatoryExpense> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('revision_id')) {
      context.handle(
        _revisionIdMeta,
        revisionId.isAcceptableOrUnknown(data['revision_id']!, _revisionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_revisionIdMeta);
    }
    if (data.containsKey('nama')) {
      context.handle(
        _namaMeta,
        nama.isAcceptableOrUnknown(data['nama']!, _namaMeta),
      );
    } else if (isInserting) {
      context.missing(_namaMeta);
    }
    if (data.containsKey('kategori')) {
      context.handle(
        _kategoriMeta,
        kategori.isAcceptableOrUnknown(data['kategori']!, _kategoriMeta),
      );
    } else if (isInserting) {
      context.missing(_kategoriMeta);
    }
    if (data.containsKey('nominal')) {
      context.handle(
        _nominalMeta,
        nominal.isAcceptableOrUnknown(data['nominal']!, _nominalMeta),
      );
    } else if (isInserting) {
      context.missing(_nominalMeta);
    }
    if (data.containsKey('tanggal_jatuh_tempo')) {
      context.handle(
        _tanggalJatuhTempoMeta,
        tanggalJatuhTempo.isAcceptableOrUnknown(
          data['tanggal_jatuh_tempo']!,
          _tanggalJatuhTempoMeta,
        ),
      );
    }
    if (data.containsKey('rutin')) {
      context.handle(
        _rutinMeta,
        rutin.isAcceptableOrUnknown(data['rutin']!, _rutinMeta),
      );
    } else if (isInserting) {
      context.missing(_rutinMeta);
    }
    if (data.containsKey('kebutuhan_pokok')) {
      context.handle(
        _kebutuhanPokokMeta,
        kebutuhanPokok.isAcceptableOrUnknown(
          data['kebutuhan_pokok']!,
          _kebutuhanPokokMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_kebutuhanPokokMeta);
    }
    if (data.containsKey('dihitung_dasar_dana_darurat')) {
      context.handle(
        _dihitungDasarDanaDaruratMeta,
        dihitungDasarDanaDarurat.isAcceptableOrUnknown(
          data['dihitung_dasar_dana_darurat']!,
          _dihitungDasarDanaDaruratMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_dihitungDasarDanaDaruratMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MandatoryExpense map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MandatoryExpense(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      revisionId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}revision_id'],
      )!,
      nama: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nama'],
      )!,
      kategori: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kategori'],
      )!,
      nominal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}nominal'],
      )!,
      tanggalJatuhTempo: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tanggal_jatuh_tempo'],
      ),
      rutin: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}rutin'],
      )!,
      jenisNominal: $MandatoryExpensesTable.$converterjenisNominal.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}jenis_nominal'],
        )!,
      ),
      kebutuhanPokok: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}kebutuhan_pokok'],
      )!,
      dihitungDasarDanaDarurat: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}dihitung_dasar_dana_darurat'],
      )!,
      kanalPembayaran: $MandatoryExpensesTable.$converterkanalPembayaran
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.string,
              data['${effectivePrefix}kanal_pembayaran'],
            )!,
          ),
    );
  }

  @override
  $MandatoryExpensesTable createAlias(String alias) {
    return $MandatoryExpensesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ExpenseAmountType, String, String>
  $converterjenisNominal = const EnumNameConverter<ExpenseAmountType>(
    ExpenseAmountType.values,
  );
  static JsonTypeConverter2<PaymentChannel, String, String>
  $converterkanalPembayaran = const EnumNameConverter<PaymentChannel>(
    PaymentChannel.values,
  );
}

class MandatoryExpense extends DataClass
    implements Insertable<MandatoryExpense> {
  final int id;
  final int revisionId;
  final String nama;
  final String kategori;
  final int nominal;
  final int? tanggalJatuhTempo;
  final bool rutin;
  final ExpenseAmountType jenisNominal;
  final bool kebutuhanPokok;
  final bool dihitungDasarDanaDarurat;
  final PaymentChannel kanalPembayaran;
  const MandatoryExpense({
    required this.id,
    required this.revisionId,
    required this.nama,
    required this.kategori,
    required this.nominal,
    this.tanggalJatuhTempo,
    required this.rutin,
    required this.jenisNominal,
    required this.kebutuhanPokok,
    required this.dihitungDasarDanaDarurat,
    required this.kanalPembayaran,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['revision_id'] = Variable<int>(revisionId);
    map['nama'] = Variable<String>(nama);
    map['kategori'] = Variable<String>(kategori);
    map['nominal'] = Variable<int>(nominal);
    if (!nullToAbsent || tanggalJatuhTempo != null) {
      map['tanggal_jatuh_tempo'] = Variable<int>(tanggalJatuhTempo);
    }
    map['rutin'] = Variable<bool>(rutin);
    {
      map['jenis_nominal'] = Variable<String>(
        $MandatoryExpensesTable.$converterjenisNominal.toSql(jenisNominal),
      );
    }
    map['kebutuhan_pokok'] = Variable<bool>(kebutuhanPokok);
    map['dihitung_dasar_dana_darurat'] = Variable<bool>(
      dihitungDasarDanaDarurat,
    );
    {
      map['kanal_pembayaran'] = Variable<String>(
        $MandatoryExpensesTable.$converterkanalPembayaran.toSql(
          kanalPembayaran,
        ),
      );
    }
    return map;
  }

  MandatoryExpensesCompanion toCompanion(bool nullToAbsent) {
    return MandatoryExpensesCompanion(
      id: Value(id),
      revisionId: Value(revisionId),
      nama: Value(nama),
      kategori: Value(kategori),
      nominal: Value(nominal),
      tanggalJatuhTempo: tanggalJatuhTempo == null && nullToAbsent
          ? const Value.absent()
          : Value(tanggalJatuhTempo),
      rutin: Value(rutin),
      jenisNominal: Value(jenisNominal),
      kebutuhanPokok: Value(kebutuhanPokok),
      dihitungDasarDanaDarurat: Value(dihitungDasarDanaDarurat),
      kanalPembayaran: Value(kanalPembayaran),
    );
  }

  factory MandatoryExpense.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MandatoryExpense(
      id: serializer.fromJson<int>(json['id']),
      revisionId: serializer.fromJson<int>(json['revisionId']),
      nama: serializer.fromJson<String>(json['nama']),
      kategori: serializer.fromJson<String>(json['kategori']),
      nominal: serializer.fromJson<int>(json['nominal']),
      tanggalJatuhTempo: serializer.fromJson<int?>(json['tanggalJatuhTempo']),
      rutin: serializer.fromJson<bool>(json['rutin']),
      jenisNominal: $MandatoryExpensesTable.$converterjenisNominal.fromJson(
        serializer.fromJson<String>(json['jenisNominal']),
      ),
      kebutuhanPokok: serializer.fromJson<bool>(json['kebutuhanPokok']),
      dihitungDasarDanaDarurat: serializer.fromJson<bool>(
        json['dihitungDasarDanaDarurat'],
      ),
      kanalPembayaran: $MandatoryExpensesTable.$converterkanalPembayaran
          .fromJson(serializer.fromJson<String>(json['kanalPembayaran'])),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'revisionId': serializer.toJson<int>(revisionId),
      'nama': serializer.toJson<String>(nama),
      'kategori': serializer.toJson<String>(kategori),
      'nominal': serializer.toJson<int>(nominal),
      'tanggalJatuhTempo': serializer.toJson<int?>(tanggalJatuhTempo),
      'rutin': serializer.toJson<bool>(rutin),
      'jenisNominal': serializer.toJson<String>(
        $MandatoryExpensesTable.$converterjenisNominal.toJson(jenisNominal),
      ),
      'kebutuhanPokok': serializer.toJson<bool>(kebutuhanPokok),
      'dihitungDasarDanaDarurat': serializer.toJson<bool>(
        dihitungDasarDanaDarurat,
      ),
      'kanalPembayaran': serializer.toJson<String>(
        $MandatoryExpensesTable.$converterkanalPembayaran.toJson(
          kanalPembayaran,
        ),
      ),
    };
  }

  MandatoryExpense copyWith({
    int? id,
    int? revisionId,
    String? nama,
    String? kategori,
    int? nominal,
    Value<int?> tanggalJatuhTempo = const Value.absent(),
    bool? rutin,
    ExpenseAmountType? jenisNominal,
    bool? kebutuhanPokok,
    bool? dihitungDasarDanaDarurat,
    PaymentChannel? kanalPembayaran,
  }) => MandatoryExpense(
    id: id ?? this.id,
    revisionId: revisionId ?? this.revisionId,
    nama: nama ?? this.nama,
    kategori: kategori ?? this.kategori,
    nominal: nominal ?? this.nominal,
    tanggalJatuhTempo: tanggalJatuhTempo.present
        ? tanggalJatuhTempo.value
        : this.tanggalJatuhTempo,
    rutin: rutin ?? this.rutin,
    jenisNominal: jenisNominal ?? this.jenisNominal,
    kebutuhanPokok: kebutuhanPokok ?? this.kebutuhanPokok,
    dihitungDasarDanaDarurat:
        dihitungDasarDanaDarurat ?? this.dihitungDasarDanaDarurat,
    kanalPembayaran: kanalPembayaran ?? this.kanalPembayaran,
  );
  MandatoryExpense copyWithCompanion(MandatoryExpensesCompanion data) {
    return MandatoryExpense(
      id: data.id.present ? data.id.value : this.id,
      revisionId: data.revisionId.present
          ? data.revisionId.value
          : this.revisionId,
      nama: data.nama.present ? data.nama.value : this.nama,
      kategori: data.kategori.present ? data.kategori.value : this.kategori,
      nominal: data.nominal.present ? data.nominal.value : this.nominal,
      tanggalJatuhTempo: data.tanggalJatuhTempo.present
          ? data.tanggalJatuhTempo.value
          : this.tanggalJatuhTempo,
      rutin: data.rutin.present ? data.rutin.value : this.rutin,
      jenisNominal: data.jenisNominal.present
          ? data.jenisNominal.value
          : this.jenisNominal,
      kebutuhanPokok: data.kebutuhanPokok.present
          ? data.kebutuhanPokok.value
          : this.kebutuhanPokok,
      dihitungDasarDanaDarurat: data.dihitungDasarDanaDarurat.present
          ? data.dihitungDasarDanaDarurat.value
          : this.dihitungDasarDanaDarurat,
      kanalPembayaran: data.kanalPembayaran.present
          ? data.kanalPembayaran.value
          : this.kanalPembayaran,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MandatoryExpense(')
          ..write('id: $id, ')
          ..write('revisionId: $revisionId, ')
          ..write('nama: $nama, ')
          ..write('kategori: $kategori, ')
          ..write('nominal: $nominal, ')
          ..write('tanggalJatuhTempo: $tanggalJatuhTempo, ')
          ..write('rutin: $rutin, ')
          ..write('jenisNominal: $jenisNominal, ')
          ..write('kebutuhanPokok: $kebutuhanPokok, ')
          ..write('dihitungDasarDanaDarurat: $dihitungDasarDanaDarurat, ')
          ..write('kanalPembayaran: $kanalPembayaran')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    revisionId,
    nama,
    kategori,
    nominal,
    tanggalJatuhTempo,
    rutin,
    jenisNominal,
    kebutuhanPokok,
    dihitungDasarDanaDarurat,
    kanalPembayaran,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MandatoryExpense &&
          other.id == this.id &&
          other.revisionId == this.revisionId &&
          other.nama == this.nama &&
          other.kategori == this.kategori &&
          other.nominal == this.nominal &&
          other.tanggalJatuhTempo == this.tanggalJatuhTempo &&
          other.rutin == this.rutin &&
          other.jenisNominal == this.jenisNominal &&
          other.kebutuhanPokok == this.kebutuhanPokok &&
          other.dihitungDasarDanaDarurat == this.dihitungDasarDanaDarurat &&
          other.kanalPembayaran == this.kanalPembayaran);
}

class MandatoryExpensesCompanion extends UpdateCompanion<MandatoryExpense> {
  final Value<int> id;
  final Value<int> revisionId;
  final Value<String> nama;
  final Value<String> kategori;
  final Value<int> nominal;
  final Value<int?> tanggalJatuhTempo;
  final Value<bool> rutin;
  final Value<ExpenseAmountType> jenisNominal;
  final Value<bool> kebutuhanPokok;
  final Value<bool> dihitungDasarDanaDarurat;
  final Value<PaymentChannel> kanalPembayaran;
  const MandatoryExpensesCompanion({
    this.id = const Value.absent(),
    this.revisionId = const Value.absent(),
    this.nama = const Value.absent(),
    this.kategori = const Value.absent(),
    this.nominal = const Value.absent(),
    this.tanggalJatuhTempo = const Value.absent(),
    this.rutin = const Value.absent(),
    this.jenisNominal = const Value.absent(),
    this.kebutuhanPokok = const Value.absent(),
    this.dihitungDasarDanaDarurat = const Value.absent(),
    this.kanalPembayaran = const Value.absent(),
  });
  MandatoryExpensesCompanion.insert({
    this.id = const Value.absent(),
    required int revisionId,
    required String nama,
    required String kategori,
    required int nominal,
    this.tanggalJatuhTempo = const Value.absent(),
    required bool rutin,
    required ExpenseAmountType jenisNominal,
    required bool kebutuhanPokok,
    required bool dihitungDasarDanaDarurat,
    required PaymentChannel kanalPembayaran,
  }) : revisionId = Value(revisionId),
       nama = Value(nama),
       kategori = Value(kategori),
       nominal = Value(nominal),
       rutin = Value(rutin),
       jenisNominal = Value(jenisNominal),
       kebutuhanPokok = Value(kebutuhanPokok),
       dihitungDasarDanaDarurat = Value(dihitungDasarDanaDarurat),
       kanalPembayaran = Value(kanalPembayaran);
  static Insertable<MandatoryExpense> custom({
    Expression<int>? id,
    Expression<int>? revisionId,
    Expression<String>? nama,
    Expression<String>? kategori,
    Expression<int>? nominal,
    Expression<int>? tanggalJatuhTempo,
    Expression<bool>? rutin,
    Expression<String>? jenisNominal,
    Expression<bool>? kebutuhanPokok,
    Expression<bool>? dihitungDasarDanaDarurat,
    Expression<String>? kanalPembayaran,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (revisionId != null) 'revision_id': revisionId,
      if (nama != null) 'nama': nama,
      if (kategori != null) 'kategori': kategori,
      if (nominal != null) 'nominal': nominal,
      if (tanggalJatuhTempo != null) 'tanggal_jatuh_tempo': tanggalJatuhTempo,
      if (rutin != null) 'rutin': rutin,
      if (jenisNominal != null) 'jenis_nominal': jenisNominal,
      if (kebutuhanPokok != null) 'kebutuhan_pokok': kebutuhanPokok,
      if (dihitungDasarDanaDarurat != null)
        'dihitung_dasar_dana_darurat': dihitungDasarDanaDarurat,
      if (kanalPembayaran != null) 'kanal_pembayaran': kanalPembayaran,
    });
  }

  MandatoryExpensesCompanion copyWith({
    Value<int>? id,
    Value<int>? revisionId,
    Value<String>? nama,
    Value<String>? kategori,
    Value<int>? nominal,
    Value<int?>? tanggalJatuhTempo,
    Value<bool>? rutin,
    Value<ExpenseAmountType>? jenisNominal,
    Value<bool>? kebutuhanPokok,
    Value<bool>? dihitungDasarDanaDarurat,
    Value<PaymentChannel>? kanalPembayaran,
  }) {
    return MandatoryExpensesCompanion(
      id: id ?? this.id,
      revisionId: revisionId ?? this.revisionId,
      nama: nama ?? this.nama,
      kategori: kategori ?? this.kategori,
      nominal: nominal ?? this.nominal,
      tanggalJatuhTempo: tanggalJatuhTempo ?? this.tanggalJatuhTempo,
      rutin: rutin ?? this.rutin,
      jenisNominal: jenisNominal ?? this.jenisNominal,
      kebutuhanPokok: kebutuhanPokok ?? this.kebutuhanPokok,
      dihitungDasarDanaDarurat:
          dihitungDasarDanaDarurat ?? this.dihitungDasarDanaDarurat,
      kanalPembayaran: kanalPembayaran ?? this.kanalPembayaran,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (revisionId.present) {
      map['revision_id'] = Variable<int>(revisionId.value);
    }
    if (nama.present) {
      map['nama'] = Variable<String>(nama.value);
    }
    if (kategori.present) {
      map['kategori'] = Variable<String>(kategori.value);
    }
    if (nominal.present) {
      map['nominal'] = Variable<int>(nominal.value);
    }
    if (tanggalJatuhTempo.present) {
      map['tanggal_jatuh_tempo'] = Variable<int>(tanggalJatuhTempo.value);
    }
    if (rutin.present) {
      map['rutin'] = Variable<bool>(rutin.value);
    }
    if (jenisNominal.present) {
      map['jenis_nominal'] = Variable<String>(
        $MandatoryExpensesTable.$converterjenisNominal.toSql(
          jenisNominal.value,
        ),
      );
    }
    if (kebutuhanPokok.present) {
      map['kebutuhan_pokok'] = Variable<bool>(kebutuhanPokok.value);
    }
    if (dihitungDasarDanaDarurat.present) {
      map['dihitung_dasar_dana_darurat'] = Variable<bool>(
        dihitungDasarDanaDarurat.value,
      );
    }
    if (kanalPembayaran.present) {
      map['kanal_pembayaran'] = Variable<String>(
        $MandatoryExpensesTable.$converterkanalPembayaran.toSql(
          kanalPembayaran.value,
        ),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MandatoryExpensesCompanion(')
          ..write('id: $id, ')
          ..write('revisionId: $revisionId, ')
          ..write('nama: $nama, ')
          ..write('kategori: $kategori, ')
          ..write('nominal: $nominal, ')
          ..write('tanggalJatuhTempo: $tanggalJatuhTempo, ')
          ..write('rutin: $rutin, ')
          ..write('jenisNominal: $jenisNominal, ')
          ..write('kebutuhanPokok: $kebutuhanPokok, ')
          ..write('dihitungDasarDanaDarurat: $dihitungDasarDanaDarurat, ')
          ..write('kanalPembayaran: $kanalPembayaran')
          ..write(')'))
        .toString();
  }
}

class $BudgetFundingAssignmentsTable extends BudgetFundingAssignments
    with TableInfo<$BudgetFundingAssignmentsTable, BudgetFundingAssignment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BudgetFundingAssignmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  @override
  late final GeneratedColumn<String> itemId = GeneratedColumn<String>(
    'item_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _itemTypeMeta = const VerificationMeta(
    'itemType',
  );
  @override
  late final GeneratedColumn<String> itemType = GeneratedColumn<String>(
    'item_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _revisionIdMeta = const VerificationMeta(
    'revisionId',
  );
  @override
  late final GeneratedColumn<int> revisionId = GeneratedColumn<int>(
    'revision_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES monthly_allocation_revisions (id)',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<BudgetSource, String>
  fundingSource =
      GeneratedColumn<String>(
        'funding_source',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<BudgetSource>(
        $BudgetFundingAssignmentsTable.$converterfundingSource,
      );
  @override
  late final GeneratedColumnWithTypeConverter<PaymentChannel, String>
  paymentChannel =
      GeneratedColumn<String>(
        'payment_channel',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<PaymentChannel>(
        $BudgetFundingAssignmentsTable.$converterpaymentChannel,
      );
  static const VerificationMeta _includedInSpendingBudgetMeta =
      const VerificationMeta('includedInSpendingBudget');
  @override
  late final GeneratedColumn<bool> includedInSpendingBudget =
      GeneratedColumn<bool>(
        'included_in_spending_budget',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: true,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("included_in_spending_budget" IN (0, 1))',
        ),
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    itemId,
    itemType,
    revisionId,
    fundingSource,
    paymentChannel,
    includedInSpendingBudget,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'budget_funding_assignments';
  @override
  VerificationContext validateIntegrity(
    Insertable<BudgetFundingAssignment> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('item_id')) {
      context.handle(
        _itemIdMeta,
        itemId.isAcceptableOrUnknown(data['item_id']!, _itemIdMeta),
      );
    } else if (isInserting) {
      context.missing(_itemIdMeta);
    }
    if (data.containsKey('item_type')) {
      context.handle(
        _itemTypeMeta,
        itemType.isAcceptableOrUnknown(data['item_type']!, _itemTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_itemTypeMeta);
    }
    if (data.containsKey('revision_id')) {
      context.handle(
        _revisionIdMeta,
        revisionId.isAcceptableOrUnknown(data['revision_id']!, _revisionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_revisionIdMeta);
    }
    if (data.containsKey('included_in_spending_budget')) {
      context.handle(
        _includedInSpendingBudgetMeta,
        includedInSpendingBudget.isAcceptableOrUnknown(
          data['included_in_spending_budget']!,
          _includedInSpendingBudgetMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_includedInSpendingBudgetMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {itemId, itemType, revisionId},
  ];
  @override
  BudgetFundingAssignment map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BudgetFundingAssignment(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      itemId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}item_id'],
      )!,
      itemType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}item_type'],
      )!,
      revisionId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}revision_id'],
      )!,
      fundingSource: $BudgetFundingAssignmentsTable.$converterfundingSource
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.string,
              data['${effectivePrefix}funding_source'],
            )!,
          ),
      paymentChannel: $BudgetFundingAssignmentsTable.$converterpaymentChannel
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.string,
              data['${effectivePrefix}payment_channel'],
            )!,
          ),
      includedInSpendingBudget: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}included_in_spending_budget'],
      )!,
    );
  }

  @override
  $BudgetFundingAssignmentsTable createAlias(String alias) {
    return $BudgetFundingAssignmentsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<BudgetSource, String, String>
  $converterfundingSource = const EnumNameConverter<BudgetSource>(
    BudgetSource.values,
  );
  static JsonTypeConverter2<PaymentChannel, String, String>
  $converterpaymentChannel = const EnumNameConverter<PaymentChannel>(
    PaymentChannel.values,
  );
}

class BudgetFundingAssignment extends DataClass
    implements Insertable<BudgetFundingAssignment> {
  final int id;
  final String itemId;
  final String itemType;
  final int revisionId;
  final BudgetSource fundingSource;
  final PaymentChannel paymentChannel;
  final bool includedInSpendingBudget;
  const BudgetFundingAssignment({
    required this.id,
    required this.itemId,
    required this.itemType,
    required this.revisionId,
    required this.fundingSource,
    required this.paymentChannel,
    required this.includedInSpendingBudget,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['item_id'] = Variable<String>(itemId);
    map['item_type'] = Variable<String>(itemType);
    map['revision_id'] = Variable<int>(revisionId);
    {
      map['funding_source'] = Variable<String>(
        $BudgetFundingAssignmentsTable.$converterfundingSource.toSql(
          fundingSource,
        ),
      );
    }
    {
      map['payment_channel'] = Variable<String>(
        $BudgetFundingAssignmentsTable.$converterpaymentChannel.toSql(
          paymentChannel,
        ),
      );
    }
    map['included_in_spending_budget'] = Variable<bool>(
      includedInSpendingBudget,
    );
    return map;
  }

  BudgetFundingAssignmentsCompanion toCompanion(bool nullToAbsent) {
    return BudgetFundingAssignmentsCompanion(
      id: Value(id),
      itemId: Value(itemId),
      itemType: Value(itemType),
      revisionId: Value(revisionId),
      fundingSource: Value(fundingSource),
      paymentChannel: Value(paymentChannel),
      includedInSpendingBudget: Value(includedInSpendingBudget),
    );
  }

  factory BudgetFundingAssignment.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BudgetFundingAssignment(
      id: serializer.fromJson<int>(json['id']),
      itemId: serializer.fromJson<String>(json['itemId']),
      itemType: serializer.fromJson<String>(json['itemType']),
      revisionId: serializer.fromJson<int>(json['revisionId']),
      fundingSource: $BudgetFundingAssignmentsTable.$converterfundingSource
          .fromJson(serializer.fromJson<String>(json['fundingSource'])),
      paymentChannel: $BudgetFundingAssignmentsTable.$converterpaymentChannel
          .fromJson(serializer.fromJson<String>(json['paymentChannel'])),
      includedInSpendingBudget: serializer.fromJson<bool>(
        json['includedInSpendingBudget'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'itemId': serializer.toJson<String>(itemId),
      'itemType': serializer.toJson<String>(itemType),
      'revisionId': serializer.toJson<int>(revisionId),
      'fundingSource': serializer.toJson<String>(
        $BudgetFundingAssignmentsTable.$converterfundingSource.toJson(
          fundingSource,
        ),
      ),
      'paymentChannel': serializer.toJson<String>(
        $BudgetFundingAssignmentsTable.$converterpaymentChannel.toJson(
          paymentChannel,
        ),
      ),
      'includedInSpendingBudget': serializer.toJson<bool>(
        includedInSpendingBudget,
      ),
    };
  }

  BudgetFundingAssignment copyWith({
    int? id,
    String? itemId,
    String? itemType,
    int? revisionId,
    BudgetSource? fundingSource,
    PaymentChannel? paymentChannel,
    bool? includedInSpendingBudget,
  }) => BudgetFundingAssignment(
    id: id ?? this.id,
    itemId: itemId ?? this.itemId,
    itemType: itemType ?? this.itemType,
    revisionId: revisionId ?? this.revisionId,
    fundingSource: fundingSource ?? this.fundingSource,
    paymentChannel: paymentChannel ?? this.paymentChannel,
    includedInSpendingBudget:
        includedInSpendingBudget ?? this.includedInSpendingBudget,
  );
  BudgetFundingAssignment copyWithCompanion(
    BudgetFundingAssignmentsCompanion data,
  ) {
    return BudgetFundingAssignment(
      id: data.id.present ? data.id.value : this.id,
      itemId: data.itemId.present ? data.itemId.value : this.itemId,
      itemType: data.itemType.present ? data.itemType.value : this.itemType,
      revisionId: data.revisionId.present
          ? data.revisionId.value
          : this.revisionId,
      fundingSource: data.fundingSource.present
          ? data.fundingSource.value
          : this.fundingSource,
      paymentChannel: data.paymentChannel.present
          ? data.paymentChannel.value
          : this.paymentChannel,
      includedInSpendingBudget: data.includedInSpendingBudget.present
          ? data.includedInSpendingBudget.value
          : this.includedInSpendingBudget,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BudgetFundingAssignment(')
          ..write('id: $id, ')
          ..write('itemId: $itemId, ')
          ..write('itemType: $itemType, ')
          ..write('revisionId: $revisionId, ')
          ..write('fundingSource: $fundingSource, ')
          ..write('paymentChannel: $paymentChannel, ')
          ..write('includedInSpendingBudget: $includedInSpendingBudget')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    itemId,
    itemType,
    revisionId,
    fundingSource,
    paymentChannel,
    includedInSpendingBudget,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BudgetFundingAssignment &&
          other.id == this.id &&
          other.itemId == this.itemId &&
          other.itemType == this.itemType &&
          other.revisionId == this.revisionId &&
          other.fundingSource == this.fundingSource &&
          other.paymentChannel == this.paymentChannel &&
          other.includedInSpendingBudget == this.includedInSpendingBudget);
}

class BudgetFundingAssignmentsCompanion
    extends UpdateCompanion<BudgetFundingAssignment> {
  final Value<int> id;
  final Value<String> itemId;
  final Value<String> itemType;
  final Value<int> revisionId;
  final Value<BudgetSource> fundingSource;
  final Value<PaymentChannel> paymentChannel;
  final Value<bool> includedInSpendingBudget;
  const BudgetFundingAssignmentsCompanion({
    this.id = const Value.absent(),
    this.itemId = const Value.absent(),
    this.itemType = const Value.absent(),
    this.revisionId = const Value.absent(),
    this.fundingSource = const Value.absent(),
    this.paymentChannel = const Value.absent(),
    this.includedInSpendingBudget = const Value.absent(),
  });
  BudgetFundingAssignmentsCompanion.insert({
    this.id = const Value.absent(),
    required String itemId,
    required String itemType,
    required int revisionId,
    required BudgetSource fundingSource,
    required PaymentChannel paymentChannel,
    required bool includedInSpendingBudget,
  }) : itemId = Value(itemId),
       itemType = Value(itemType),
       revisionId = Value(revisionId),
       fundingSource = Value(fundingSource),
       paymentChannel = Value(paymentChannel),
       includedInSpendingBudget = Value(includedInSpendingBudget);
  static Insertable<BudgetFundingAssignment> custom({
    Expression<int>? id,
    Expression<String>? itemId,
    Expression<String>? itemType,
    Expression<int>? revisionId,
    Expression<String>? fundingSource,
    Expression<String>? paymentChannel,
    Expression<bool>? includedInSpendingBudget,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (itemId != null) 'item_id': itemId,
      if (itemType != null) 'item_type': itemType,
      if (revisionId != null) 'revision_id': revisionId,
      if (fundingSource != null) 'funding_source': fundingSource,
      if (paymentChannel != null) 'payment_channel': paymentChannel,
      if (includedInSpendingBudget != null)
        'included_in_spending_budget': includedInSpendingBudget,
    });
  }

  BudgetFundingAssignmentsCompanion copyWith({
    Value<int>? id,
    Value<String>? itemId,
    Value<String>? itemType,
    Value<int>? revisionId,
    Value<BudgetSource>? fundingSource,
    Value<PaymentChannel>? paymentChannel,
    Value<bool>? includedInSpendingBudget,
  }) {
    return BudgetFundingAssignmentsCompanion(
      id: id ?? this.id,
      itemId: itemId ?? this.itemId,
      itemType: itemType ?? this.itemType,
      revisionId: revisionId ?? this.revisionId,
      fundingSource: fundingSource ?? this.fundingSource,
      paymentChannel: paymentChannel ?? this.paymentChannel,
      includedInSpendingBudget:
          includedInSpendingBudget ?? this.includedInSpendingBudget,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (itemId.present) {
      map['item_id'] = Variable<String>(itemId.value);
    }
    if (itemType.present) {
      map['item_type'] = Variable<String>(itemType.value);
    }
    if (revisionId.present) {
      map['revision_id'] = Variable<int>(revisionId.value);
    }
    if (fundingSource.present) {
      map['funding_source'] = Variable<String>(
        $BudgetFundingAssignmentsTable.$converterfundingSource.toSql(
          fundingSource.value,
        ),
      );
    }
    if (paymentChannel.present) {
      map['payment_channel'] = Variable<String>(
        $BudgetFundingAssignmentsTable.$converterpaymentChannel.toSql(
          paymentChannel.value,
        ),
      );
    }
    if (includedInSpendingBudget.present) {
      map['included_in_spending_budget'] = Variable<bool>(
        includedInSpendingBudget.value,
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BudgetFundingAssignmentsCompanion(')
          ..write('id: $id, ')
          ..write('itemId: $itemId, ')
          ..write('itemType: $itemType, ')
          ..write('revisionId: $revisionId, ')
          ..write('fundingSource: $fundingSource, ')
          ..write('paymentChannel: $paymentChannel, ')
          ..write('includedInSpendingBudget: $includedInSpendingBudget')
          ..write(')'))
        .toString();
  }
}

class $ExpenseRealizationsTable extends ExpenseRealizations
    with TableInfo<$ExpenseRealizationsTable, ExpenseRealization> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExpenseRealizationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _transactionDateMeta = const VerificationMeta(
    'transactionDate',
  );
  @override
  late final GeneratedColumn<DateTime> transactionDate =
      GeneratedColumn<DateTime>(
        'transaction_date',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
    'category_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<BudgetSource, String>
  fundingSource =
      GeneratedColumn<String>(
        'funding_source',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<BudgetSource>(
        $ExpenseRealizationsTable.$converterfundingSource,
      );
  @override
  late final GeneratedColumnWithTypeConverter<PaymentChannel, String>
  paymentChannel =
      GeneratedColumn<String>(
        'payment_channel',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<PaymentChannel>(
        $ExpenseRealizationsTable.$converterpaymentChannel,
      );
  static const VerificationMeta _monthlyAllocationRevisionIdMeta =
      const VerificationMeta('monthlyAllocationRevisionId');
  @override
  late final GeneratedColumn<int> monthlyAllocationRevisionId =
      GeneratedColumn<int>(
        'monthly_allocation_revision_id',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES monthly_allocation_revisions (id)',
        ),
      );
  static const VerificationMeta _referenceItemIdMeta = const VerificationMeta(
    'referenceItemId',
  );
  @override
  late final GeneratedColumn<String> referenceItemId = GeneratedColumn<String>(
    'reference_item_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<VerificationStatus, String>
  verificationStatus =
      GeneratedColumn<String>(
        'verification_status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<VerificationStatus>(
        $ExpenseRealizationsTable.$converterverificationStatus,
      );
  static const VerificationMeta _userNotesMeta = const VerificationMeta(
    'userNotes',
  );
  @override
  late final GeneratedColumn<String> userNotes = GeneratedColumn<String>(
    'user_notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    transactionDate,
    amount,
    categoryId,
    fundingSource,
    paymentChannel,
    monthlyAllocationRevisionId,
    referenceItemId,
    verificationStatus,
    userNotes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'expense_realizations';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExpenseRealization> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('transaction_date')) {
      context.handle(
        _transactionDateMeta,
        transactionDate.isAcceptableOrUnknown(
          data['transaction_date']!,
          _transactionDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_transactionDateMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    }
    if (data.containsKey('monthly_allocation_revision_id')) {
      context.handle(
        _monthlyAllocationRevisionIdMeta,
        monthlyAllocationRevisionId.isAcceptableOrUnknown(
          data['monthly_allocation_revision_id']!,
          _monthlyAllocationRevisionIdMeta,
        ),
      );
    }
    if (data.containsKey('reference_item_id')) {
      context.handle(
        _referenceItemIdMeta,
        referenceItemId.isAcceptableOrUnknown(
          data['reference_item_id']!,
          _referenceItemIdMeta,
        ),
      );
    }
    if (data.containsKey('user_notes')) {
      context.handle(
        _userNotesMeta,
        userNotes.isAcceptableOrUnknown(data['user_notes']!, _userNotesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExpenseRealization map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExpenseRealization(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      transactionDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}transaction_date'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_id'],
      ),
      fundingSource: $ExpenseRealizationsTable.$converterfundingSource.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}funding_source'],
        )!,
      ),
      paymentChannel: $ExpenseRealizationsTable.$converterpaymentChannel
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.string,
              data['${effectivePrefix}payment_channel'],
            )!,
          ),
      monthlyAllocationRevisionId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}monthly_allocation_revision_id'],
      ),
      referenceItemId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reference_item_id'],
      ),
      verificationStatus: $ExpenseRealizationsTable.$converterverificationStatus
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.string,
              data['${effectivePrefix}verification_status'],
            )!,
          ),
      userNotes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_notes'],
      ),
    );
  }

  @override
  $ExpenseRealizationsTable createAlias(String alias) {
    return $ExpenseRealizationsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<BudgetSource, String, String>
  $converterfundingSource = const EnumNameConverter<BudgetSource>(
    BudgetSource.values,
  );
  static JsonTypeConverter2<PaymentChannel, String, String>
  $converterpaymentChannel = const EnumNameConverter<PaymentChannel>(
    PaymentChannel.values,
  );
  static JsonTypeConverter2<VerificationStatus, String, String>
  $converterverificationStatus = const EnumNameConverter<VerificationStatus>(
    VerificationStatus.values,
  );
}

class ExpenseRealization extends DataClass
    implements Insertable<ExpenseRealization> {
  final int id;
  final DateTime transactionDate;
  final int amount;
  final String? categoryId;
  final BudgetSource fundingSource;
  final PaymentChannel paymentChannel;
  final int? monthlyAllocationRevisionId;
  final String? referenceItemId;
  final VerificationStatus verificationStatus;
  final String? userNotes;
  const ExpenseRealization({
    required this.id,
    required this.transactionDate,
    required this.amount,
    this.categoryId,
    required this.fundingSource,
    required this.paymentChannel,
    this.monthlyAllocationRevisionId,
    this.referenceItemId,
    required this.verificationStatus,
    this.userNotes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['transaction_date'] = Variable<DateTime>(transactionDate);
    map['amount'] = Variable<int>(amount);
    if (!nullToAbsent || categoryId != null) {
      map['category_id'] = Variable<String>(categoryId);
    }
    {
      map['funding_source'] = Variable<String>(
        $ExpenseRealizationsTable.$converterfundingSource.toSql(fundingSource),
      );
    }
    {
      map['payment_channel'] = Variable<String>(
        $ExpenseRealizationsTable.$converterpaymentChannel.toSql(
          paymentChannel,
        ),
      );
    }
    if (!nullToAbsent || monthlyAllocationRevisionId != null) {
      map['monthly_allocation_revision_id'] = Variable<int>(
        monthlyAllocationRevisionId,
      );
    }
    if (!nullToAbsent || referenceItemId != null) {
      map['reference_item_id'] = Variable<String>(referenceItemId);
    }
    {
      map['verification_status'] = Variable<String>(
        $ExpenseRealizationsTable.$converterverificationStatus.toSql(
          verificationStatus,
        ),
      );
    }
    if (!nullToAbsent || userNotes != null) {
      map['user_notes'] = Variable<String>(userNotes);
    }
    return map;
  }

  ExpenseRealizationsCompanion toCompanion(bool nullToAbsent) {
    return ExpenseRealizationsCompanion(
      id: Value(id),
      transactionDate: Value(transactionDate),
      amount: Value(amount),
      categoryId: categoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryId),
      fundingSource: Value(fundingSource),
      paymentChannel: Value(paymentChannel),
      monthlyAllocationRevisionId:
          monthlyAllocationRevisionId == null && nullToAbsent
          ? const Value.absent()
          : Value(monthlyAllocationRevisionId),
      referenceItemId: referenceItemId == null && nullToAbsent
          ? const Value.absent()
          : Value(referenceItemId),
      verificationStatus: Value(verificationStatus),
      userNotes: userNotes == null && nullToAbsent
          ? const Value.absent()
          : Value(userNotes),
    );
  }

  factory ExpenseRealization.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExpenseRealization(
      id: serializer.fromJson<int>(json['id']),
      transactionDate: serializer.fromJson<DateTime>(json['transactionDate']),
      amount: serializer.fromJson<int>(json['amount']),
      categoryId: serializer.fromJson<String?>(json['categoryId']),
      fundingSource: $ExpenseRealizationsTable.$converterfundingSource.fromJson(
        serializer.fromJson<String>(json['fundingSource']),
      ),
      paymentChannel: $ExpenseRealizationsTable.$converterpaymentChannel
          .fromJson(serializer.fromJson<String>(json['paymentChannel'])),
      monthlyAllocationRevisionId: serializer.fromJson<int?>(
        json['monthlyAllocationRevisionId'],
      ),
      referenceItemId: serializer.fromJson<String?>(json['referenceItemId']),
      verificationStatus: $ExpenseRealizationsTable.$converterverificationStatus
          .fromJson(serializer.fromJson<String>(json['verificationStatus'])),
      userNotes: serializer.fromJson<String?>(json['userNotes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'transactionDate': serializer.toJson<DateTime>(transactionDate),
      'amount': serializer.toJson<int>(amount),
      'categoryId': serializer.toJson<String?>(categoryId),
      'fundingSource': serializer.toJson<String>(
        $ExpenseRealizationsTable.$converterfundingSource.toJson(fundingSource),
      ),
      'paymentChannel': serializer.toJson<String>(
        $ExpenseRealizationsTable.$converterpaymentChannel.toJson(
          paymentChannel,
        ),
      ),
      'monthlyAllocationRevisionId': serializer.toJson<int?>(
        monthlyAllocationRevisionId,
      ),
      'referenceItemId': serializer.toJson<String?>(referenceItemId),
      'verificationStatus': serializer.toJson<String>(
        $ExpenseRealizationsTable.$converterverificationStatus.toJson(
          verificationStatus,
        ),
      ),
      'userNotes': serializer.toJson<String?>(userNotes),
    };
  }

  ExpenseRealization copyWith({
    int? id,
    DateTime? transactionDate,
    int? amount,
    Value<String?> categoryId = const Value.absent(),
    BudgetSource? fundingSource,
    PaymentChannel? paymentChannel,
    Value<int?> monthlyAllocationRevisionId = const Value.absent(),
    Value<String?> referenceItemId = const Value.absent(),
    VerificationStatus? verificationStatus,
    Value<String?> userNotes = const Value.absent(),
  }) => ExpenseRealization(
    id: id ?? this.id,
    transactionDate: transactionDate ?? this.transactionDate,
    amount: amount ?? this.amount,
    categoryId: categoryId.present ? categoryId.value : this.categoryId,
    fundingSource: fundingSource ?? this.fundingSource,
    paymentChannel: paymentChannel ?? this.paymentChannel,
    monthlyAllocationRevisionId: monthlyAllocationRevisionId.present
        ? monthlyAllocationRevisionId.value
        : this.monthlyAllocationRevisionId,
    referenceItemId: referenceItemId.present
        ? referenceItemId.value
        : this.referenceItemId,
    verificationStatus: verificationStatus ?? this.verificationStatus,
    userNotes: userNotes.present ? userNotes.value : this.userNotes,
  );
  ExpenseRealization copyWithCompanion(ExpenseRealizationsCompanion data) {
    return ExpenseRealization(
      id: data.id.present ? data.id.value : this.id,
      transactionDate: data.transactionDate.present
          ? data.transactionDate.value
          : this.transactionDate,
      amount: data.amount.present ? data.amount.value : this.amount,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      fundingSource: data.fundingSource.present
          ? data.fundingSource.value
          : this.fundingSource,
      paymentChannel: data.paymentChannel.present
          ? data.paymentChannel.value
          : this.paymentChannel,
      monthlyAllocationRevisionId: data.monthlyAllocationRevisionId.present
          ? data.monthlyAllocationRevisionId.value
          : this.monthlyAllocationRevisionId,
      referenceItemId: data.referenceItemId.present
          ? data.referenceItemId.value
          : this.referenceItemId,
      verificationStatus: data.verificationStatus.present
          ? data.verificationStatus.value
          : this.verificationStatus,
      userNotes: data.userNotes.present ? data.userNotes.value : this.userNotes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExpenseRealization(')
          ..write('id: $id, ')
          ..write('transactionDate: $transactionDate, ')
          ..write('amount: $amount, ')
          ..write('categoryId: $categoryId, ')
          ..write('fundingSource: $fundingSource, ')
          ..write('paymentChannel: $paymentChannel, ')
          ..write('monthlyAllocationRevisionId: $monthlyAllocationRevisionId, ')
          ..write('referenceItemId: $referenceItemId, ')
          ..write('verificationStatus: $verificationStatus, ')
          ..write('userNotes: $userNotes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    transactionDate,
    amount,
    categoryId,
    fundingSource,
    paymentChannel,
    monthlyAllocationRevisionId,
    referenceItemId,
    verificationStatus,
    userNotes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExpenseRealization &&
          other.id == this.id &&
          other.transactionDate == this.transactionDate &&
          other.amount == this.amount &&
          other.categoryId == this.categoryId &&
          other.fundingSource == this.fundingSource &&
          other.paymentChannel == this.paymentChannel &&
          other.monthlyAllocationRevisionId ==
              this.monthlyAllocationRevisionId &&
          other.referenceItemId == this.referenceItemId &&
          other.verificationStatus == this.verificationStatus &&
          other.userNotes == this.userNotes);
}

class ExpenseRealizationsCompanion extends UpdateCompanion<ExpenseRealization> {
  final Value<int> id;
  final Value<DateTime> transactionDate;
  final Value<int> amount;
  final Value<String?> categoryId;
  final Value<BudgetSource> fundingSource;
  final Value<PaymentChannel> paymentChannel;
  final Value<int?> monthlyAllocationRevisionId;
  final Value<String?> referenceItemId;
  final Value<VerificationStatus> verificationStatus;
  final Value<String?> userNotes;
  const ExpenseRealizationsCompanion({
    this.id = const Value.absent(),
    this.transactionDate = const Value.absent(),
    this.amount = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.fundingSource = const Value.absent(),
    this.paymentChannel = const Value.absent(),
    this.monthlyAllocationRevisionId = const Value.absent(),
    this.referenceItemId = const Value.absent(),
    this.verificationStatus = const Value.absent(),
    this.userNotes = const Value.absent(),
  });
  ExpenseRealizationsCompanion.insert({
    this.id = const Value.absent(),
    required DateTime transactionDate,
    required int amount,
    this.categoryId = const Value.absent(),
    required BudgetSource fundingSource,
    required PaymentChannel paymentChannel,
    this.monthlyAllocationRevisionId = const Value.absent(),
    this.referenceItemId = const Value.absent(),
    required VerificationStatus verificationStatus,
    this.userNotes = const Value.absent(),
  }) : transactionDate = Value(transactionDate),
       amount = Value(amount),
       fundingSource = Value(fundingSource),
       paymentChannel = Value(paymentChannel),
       verificationStatus = Value(verificationStatus);
  static Insertable<ExpenseRealization> custom({
    Expression<int>? id,
    Expression<DateTime>? transactionDate,
    Expression<int>? amount,
    Expression<String>? categoryId,
    Expression<String>? fundingSource,
    Expression<String>? paymentChannel,
    Expression<int>? monthlyAllocationRevisionId,
    Expression<String>? referenceItemId,
    Expression<String>? verificationStatus,
    Expression<String>? userNotes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (transactionDate != null) 'transaction_date': transactionDate,
      if (amount != null) 'amount': amount,
      if (categoryId != null) 'category_id': categoryId,
      if (fundingSource != null) 'funding_source': fundingSource,
      if (paymentChannel != null) 'payment_channel': paymentChannel,
      if (monthlyAllocationRevisionId != null)
        'monthly_allocation_revision_id': monthlyAllocationRevisionId,
      if (referenceItemId != null) 'reference_item_id': referenceItemId,
      if (verificationStatus != null) 'verification_status': verificationStatus,
      if (userNotes != null) 'user_notes': userNotes,
    });
  }

  ExpenseRealizationsCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? transactionDate,
    Value<int>? amount,
    Value<String?>? categoryId,
    Value<BudgetSource>? fundingSource,
    Value<PaymentChannel>? paymentChannel,
    Value<int?>? monthlyAllocationRevisionId,
    Value<String?>? referenceItemId,
    Value<VerificationStatus>? verificationStatus,
    Value<String?>? userNotes,
  }) {
    return ExpenseRealizationsCompanion(
      id: id ?? this.id,
      transactionDate: transactionDate ?? this.transactionDate,
      amount: amount ?? this.amount,
      categoryId: categoryId ?? this.categoryId,
      fundingSource: fundingSource ?? this.fundingSource,
      paymentChannel: paymentChannel ?? this.paymentChannel,
      monthlyAllocationRevisionId:
          monthlyAllocationRevisionId ?? this.monthlyAllocationRevisionId,
      referenceItemId: referenceItemId ?? this.referenceItemId,
      verificationStatus: verificationStatus ?? this.verificationStatus,
      userNotes: userNotes ?? this.userNotes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (transactionDate.present) {
      map['transaction_date'] = Variable<DateTime>(transactionDate.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (fundingSource.present) {
      map['funding_source'] = Variable<String>(
        $ExpenseRealizationsTable.$converterfundingSource.toSql(
          fundingSource.value,
        ),
      );
    }
    if (paymentChannel.present) {
      map['payment_channel'] = Variable<String>(
        $ExpenseRealizationsTable.$converterpaymentChannel.toSql(
          paymentChannel.value,
        ),
      );
    }
    if (monthlyAllocationRevisionId.present) {
      map['monthly_allocation_revision_id'] = Variable<int>(
        monthlyAllocationRevisionId.value,
      );
    }
    if (referenceItemId.present) {
      map['reference_item_id'] = Variable<String>(referenceItemId.value);
    }
    if (verificationStatus.present) {
      map['verification_status'] = Variable<String>(
        $ExpenseRealizationsTable.$converterverificationStatus.toSql(
          verificationStatus.value,
        ),
      );
    }
    if (userNotes.present) {
      map['user_notes'] = Variable<String>(userNotes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExpenseRealizationsCompanion(')
          ..write('id: $id, ')
          ..write('transactionDate: $transactionDate, ')
          ..write('amount: $amount, ')
          ..write('categoryId: $categoryId, ')
          ..write('fundingSource: $fundingSource, ')
          ..write('paymentChannel: $paymentChannel, ')
          ..write('monthlyAllocationRevisionId: $monthlyAllocationRevisionId, ')
          ..write('referenceItemId: $referenceItemId, ')
          ..write('verificationStatus: $verificationStatus, ')
          ..write('userNotes: $userNotes')
          ..write(')'))
        .toString();
  }
}

class $SubscriptionsTable extends Subscriptions
    with TableInfo<$SubscriptionsTable, Subscription> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SubscriptionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _namaMeta = const VerificationMeta('nama');
  @override
  late final GeneratedColumn<String> nama = GeneratedColumn<String>(
    'nama',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<SubscriptionCycle, String>
  siklus = GeneratedColumn<String>(
    'siklus',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<SubscriptionCycle>($SubscriptionsTable.$convertersiklus);
  static const VerificationMeta _nominalMeta = const VerificationMeta(
    'nominal',
  );
  @override
  late final GeneratedColumn<int> nominal = GeneratedColumn<int>(
    'nominal',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bulanTagihanMeta = const VerificationMeta(
    'bulanTagihan',
  );
  @override
  late final GeneratedColumn<int> bulanTagihan = GeneratedColumn<int>(
    'bulan_tagihan',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tanggalTagihanMeta = const VerificationMeta(
    'tanggalTagihan',
  );
  @override
  late final GeneratedColumn<int> tanggalTagihan = GeneratedColumn<int>(
    'tanggal_tagihan',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<AnnualFundingMethod, String>
  metodeTahunan =
      GeneratedColumn<String>(
        'metode_tahunan',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<AnnualFundingMethod>(
        $SubscriptionsTable.$convertermetodeTahunan,
      );
  @override
  late final GeneratedColumnWithTypeConverter<SubscriptionFundingSource, String>
  sumberAnggaran =
      GeneratedColumn<String>(
        'sumber_anggaran',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<SubscriptionFundingSource>(
        $SubscriptionsTable.$convertersumberAnggaran,
      );
  static const VerificationMeta _saldoCadanganMeta = const VerificationMeta(
    'saldoCadangan',
  );
  @override
  late final GeneratedColumn<int> saldoCadangan = GeneratedColumn<int>(
    'saldo_cadangan',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _aktifMeta = const VerificationMeta('aktif');
  @override
  late final GeneratedColumn<bool> aktif = GeneratedColumn<bool>(
    'aktif',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("aktif" IN (0, 1))',
    ),
  );
  static const VerificationMeta _pengingatAktifMeta = const VerificationMeta(
    'pengingatAktif',
  );
  @override
  late final GeneratedColumn<bool> pengingatAktif = GeneratedColumn<bool>(
    'pengingat_aktif',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("pengingat_aktif" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nama,
    siklus,
    nominal,
    bulanTagihan,
    tanggalTagihan,
    metodeTahunan,
    sumberAnggaran,
    saldoCadangan,
    aktif,
    pengingatAktif,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'subscriptions';
  @override
  VerificationContext validateIntegrity(
    Insertable<Subscription> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nama')) {
      context.handle(
        _namaMeta,
        nama.isAcceptableOrUnknown(data['nama']!, _namaMeta),
      );
    } else if (isInserting) {
      context.missing(_namaMeta);
    }
    if (data.containsKey('nominal')) {
      context.handle(
        _nominalMeta,
        nominal.isAcceptableOrUnknown(data['nominal']!, _nominalMeta),
      );
    } else if (isInserting) {
      context.missing(_nominalMeta);
    }
    if (data.containsKey('bulan_tagihan')) {
      context.handle(
        _bulanTagihanMeta,
        bulanTagihan.isAcceptableOrUnknown(
          data['bulan_tagihan']!,
          _bulanTagihanMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_bulanTagihanMeta);
    }
    if (data.containsKey('tanggal_tagihan')) {
      context.handle(
        _tanggalTagihanMeta,
        tanggalTagihan.isAcceptableOrUnknown(
          data['tanggal_tagihan']!,
          _tanggalTagihanMeta,
        ),
      );
    }
    if (data.containsKey('saldo_cadangan')) {
      context.handle(
        _saldoCadanganMeta,
        saldoCadangan.isAcceptableOrUnknown(
          data['saldo_cadangan']!,
          _saldoCadanganMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_saldoCadanganMeta);
    }
    if (data.containsKey('aktif')) {
      context.handle(
        _aktifMeta,
        aktif.isAcceptableOrUnknown(data['aktif']!, _aktifMeta),
      );
    } else if (isInserting) {
      context.missing(_aktifMeta);
    }
    if (data.containsKey('pengingat_aktif')) {
      context.handle(
        _pengingatAktifMeta,
        pengingatAktif.isAcceptableOrUnknown(
          data['pengingat_aktif']!,
          _pengingatAktifMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_pengingatAktifMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Subscription map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Subscription(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nama: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nama'],
      )!,
      siklus: $SubscriptionsTable.$convertersiklus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}siklus'],
        )!,
      ),
      nominal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}nominal'],
      )!,
      bulanTagihan: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}bulan_tagihan'],
      )!,
      tanggalTagihan: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tanggal_tagihan'],
      ),
      metodeTahunan: $SubscriptionsTable.$convertermetodeTahunan.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}metode_tahunan'],
        )!,
      ),
      sumberAnggaran: $SubscriptionsTable.$convertersumberAnggaran.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}sumber_anggaran'],
        )!,
      ),
      saldoCadangan: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}saldo_cadangan'],
      )!,
      aktif: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}aktif'],
      )!,
      pengingatAktif: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}pengingat_aktif'],
      )!,
    );
  }

  @override
  $SubscriptionsTable createAlias(String alias) {
    return $SubscriptionsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<SubscriptionCycle, String, String>
  $convertersiklus = const EnumNameConverter<SubscriptionCycle>(
    SubscriptionCycle.values,
  );
  static JsonTypeConverter2<AnnualFundingMethod, String, String>
  $convertermetodeTahunan = const EnumNameConverter<AnnualFundingMethod>(
    AnnualFundingMethod.values,
  );
  static JsonTypeConverter2<SubscriptionFundingSource, String, String>
  $convertersumberAnggaran = const EnumNameConverter<SubscriptionFundingSource>(
    SubscriptionFundingSource.values,
  );
}

class Subscription extends DataClass implements Insertable<Subscription> {
  final int id;
  final String nama;
  final SubscriptionCycle siklus;

  /// Bulanan: nominal/bulan. Tahunan: biaya tahunan penuh.
  final int nominal;
  final int bulanTagihan;
  final int? tanggalTagihan;
  final AnnualFundingMethod metodeTahunan;
  final SubscriptionFundingSource sumberAnggaran;
  final int saldoCadangan;
  final bool aktif;
  final bool pengingatAktif;
  const Subscription({
    required this.id,
    required this.nama,
    required this.siklus,
    required this.nominal,
    required this.bulanTagihan,
    this.tanggalTagihan,
    required this.metodeTahunan,
    required this.sumberAnggaran,
    required this.saldoCadangan,
    required this.aktif,
    required this.pengingatAktif,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nama'] = Variable<String>(nama);
    {
      map['siklus'] = Variable<String>(
        $SubscriptionsTable.$convertersiklus.toSql(siklus),
      );
    }
    map['nominal'] = Variable<int>(nominal);
    map['bulan_tagihan'] = Variable<int>(bulanTagihan);
    if (!nullToAbsent || tanggalTagihan != null) {
      map['tanggal_tagihan'] = Variable<int>(tanggalTagihan);
    }
    {
      map['metode_tahunan'] = Variable<String>(
        $SubscriptionsTable.$convertermetodeTahunan.toSql(metodeTahunan),
      );
    }
    {
      map['sumber_anggaran'] = Variable<String>(
        $SubscriptionsTable.$convertersumberAnggaran.toSql(sumberAnggaran),
      );
    }
    map['saldo_cadangan'] = Variable<int>(saldoCadangan);
    map['aktif'] = Variable<bool>(aktif);
    map['pengingat_aktif'] = Variable<bool>(pengingatAktif);
    return map;
  }

  SubscriptionsCompanion toCompanion(bool nullToAbsent) {
    return SubscriptionsCompanion(
      id: Value(id),
      nama: Value(nama),
      siklus: Value(siklus),
      nominal: Value(nominal),
      bulanTagihan: Value(bulanTagihan),
      tanggalTagihan: tanggalTagihan == null && nullToAbsent
          ? const Value.absent()
          : Value(tanggalTagihan),
      metodeTahunan: Value(metodeTahunan),
      sumberAnggaran: Value(sumberAnggaran),
      saldoCadangan: Value(saldoCadangan),
      aktif: Value(aktif),
      pengingatAktif: Value(pengingatAktif),
    );
  }

  factory Subscription.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Subscription(
      id: serializer.fromJson<int>(json['id']),
      nama: serializer.fromJson<String>(json['nama']),
      siklus: $SubscriptionsTable.$convertersiklus.fromJson(
        serializer.fromJson<String>(json['siklus']),
      ),
      nominal: serializer.fromJson<int>(json['nominal']),
      bulanTagihan: serializer.fromJson<int>(json['bulanTagihan']),
      tanggalTagihan: serializer.fromJson<int?>(json['tanggalTagihan']),
      metodeTahunan: $SubscriptionsTable.$convertermetodeTahunan.fromJson(
        serializer.fromJson<String>(json['metodeTahunan']),
      ),
      sumberAnggaran: $SubscriptionsTable.$convertersumberAnggaran.fromJson(
        serializer.fromJson<String>(json['sumberAnggaran']),
      ),
      saldoCadangan: serializer.fromJson<int>(json['saldoCadangan']),
      aktif: serializer.fromJson<bool>(json['aktif']),
      pengingatAktif: serializer.fromJson<bool>(json['pengingatAktif']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nama': serializer.toJson<String>(nama),
      'siklus': serializer.toJson<String>(
        $SubscriptionsTable.$convertersiklus.toJson(siklus),
      ),
      'nominal': serializer.toJson<int>(nominal),
      'bulanTagihan': serializer.toJson<int>(bulanTagihan),
      'tanggalTagihan': serializer.toJson<int?>(tanggalTagihan),
      'metodeTahunan': serializer.toJson<String>(
        $SubscriptionsTable.$convertermetodeTahunan.toJson(metodeTahunan),
      ),
      'sumberAnggaran': serializer.toJson<String>(
        $SubscriptionsTable.$convertersumberAnggaran.toJson(sumberAnggaran),
      ),
      'saldoCadangan': serializer.toJson<int>(saldoCadangan),
      'aktif': serializer.toJson<bool>(aktif),
      'pengingatAktif': serializer.toJson<bool>(pengingatAktif),
    };
  }

  Subscription copyWith({
    int? id,
    String? nama,
    SubscriptionCycle? siklus,
    int? nominal,
    int? bulanTagihan,
    Value<int?> tanggalTagihan = const Value.absent(),
    AnnualFundingMethod? metodeTahunan,
    SubscriptionFundingSource? sumberAnggaran,
    int? saldoCadangan,
    bool? aktif,
    bool? pengingatAktif,
  }) => Subscription(
    id: id ?? this.id,
    nama: nama ?? this.nama,
    siklus: siklus ?? this.siklus,
    nominal: nominal ?? this.nominal,
    bulanTagihan: bulanTagihan ?? this.bulanTagihan,
    tanggalTagihan: tanggalTagihan.present
        ? tanggalTagihan.value
        : this.tanggalTagihan,
    metodeTahunan: metodeTahunan ?? this.metodeTahunan,
    sumberAnggaran: sumberAnggaran ?? this.sumberAnggaran,
    saldoCadangan: saldoCadangan ?? this.saldoCadangan,
    aktif: aktif ?? this.aktif,
    pengingatAktif: pengingatAktif ?? this.pengingatAktif,
  );
  Subscription copyWithCompanion(SubscriptionsCompanion data) {
    return Subscription(
      id: data.id.present ? data.id.value : this.id,
      nama: data.nama.present ? data.nama.value : this.nama,
      siklus: data.siklus.present ? data.siklus.value : this.siklus,
      nominal: data.nominal.present ? data.nominal.value : this.nominal,
      bulanTagihan: data.bulanTagihan.present
          ? data.bulanTagihan.value
          : this.bulanTagihan,
      tanggalTagihan: data.tanggalTagihan.present
          ? data.tanggalTagihan.value
          : this.tanggalTagihan,
      metodeTahunan: data.metodeTahunan.present
          ? data.metodeTahunan.value
          : this.metodeTahunan,
      sumberAnggaran: data.sumberAnggaran.present
          ? data.sumberAnggaran.value
          : this.sumberAnggaran,
      saldoCadangan: data.saldoCadangan.present
          ? data.saldoCadangan.value
          : this.saldoCadangan,
      aktif: data.aktif.present ? data.aktif.value : this.aktif,
      pengingatAktif: data.pengingatAktif.present
          ? data.pengingatAktif.value
          : this.pengingatAktif,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Subscription(')
          ..write('id: $id, ')
          ..write('nama: $nama, ')
          ..write('siklus: $siklus, ')
          ..write('nominal: $nominal, ')
          ..write('bulanTagihan: $bulanTagihan, ')
          ..write('tanggalTagihan: $tanggalTagihan, ')
          ..write('metodeTahunan: $metodeTahunan, ')
          ..write('sumberAnggaran: $sumberAnggaran, ')
          ..write('saldoCadangan: $saldoCadangan, ')
          ..write('aktif: $aktif, ')
          ..write('pengingatAktif: $pengingatAktif')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    nama,
    siklus,
    nominal,
    bulanTagihan,
    tanggalTagihan,
    metodeTahunan,
    sumberAnggaran,
    saldoCadangan,
    aktif,
    pengingatAktif,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Subscription &&
          other.id == this.id &&
          other.nama == this.nama &&
          other.siklus == this.siklus &&
          other.nominal == this.nominal &&
          other.bulanTagihan == this.bulanTagihan &&
          other.tanggalTagihan == this.tanggalTagihan &&
          other.metodeTahunan == this.metodeTahunan &&
          other.sumberAnggaran == this.sumberAnggaran &&
          other.saldoCadangan == this.saldoCadangan &&
          other.aktif == this.aktif &&
          other.pengingatAktif == this.pengingatAktif);
}

class SubscriptionsCompanion extends UpdateCompanion<Subscription> {
  final Value<int> id;
  final Value<String> nama;
  final Value<SubscriptionCycle> siklus;
  final Value<int> nominal;
  final Value<int> bulanTagihan;
  final Value<int?> tanggalTagihan;
  final Value<AnnualFundingMethod> metodeTahunan;
  final Value<SubscriptionFundingSource> sumberAnggaran;
  final Value<int> saldoCadangan;
  final Value<bool> aktif;
  final Value<bool> pengingatAktif;
  const SubscriptionsCompanion({
    this.id = const Value.absent(),
    this.nama = const Value.absent(),
    this.siklus = const Value.absent(),
    this.nominal = const Value.absent(),
    this.bulanTagihan = const Value.absent(),
    this.tanggalTagihan = const Value.absent(),
    this.metodeTahunan = const Value.absent(),
    this.sumberAnggaran = const Value.absent(),
    this.saldoCadangan = const Value.absent(),
    this.aktif = const Value.absent(),
    this.pengingatAktif = const Value.absent(),
  });
  SubscriptionsCompanion.insert({
    this.id = const Value.absent(),
    required String nama,
    required SubscriptionCycle siklus,
    required int nominal,
    required int bulanTagihan,
    this.tanggalTagihan = const Value.absent(),
    required AnnualFundingMethod metodeTahunan,
    required SubscriptionFundingSource sumberAnggaran,
    required int saldoCadangan,
    required bool aktif,
    required bool pengingatAktif,
  }) : nama = Value(nama),
       siklus = Value(siklus),
       nominal = Value(nominal),
       bulanTagihan = Value(bulanTagihan),
       metodeTahunan = Value(metodeTahunan),
       sumberAnggaran = Value(sumberAnggaran),
       saldoCadangan = Value(saldoCadangan),
       aktif = Value(aktif),
       pengingatAktif = Value(pengingatAktif);
  static Insertable<Subscription> custom({
    Expression<int>? id,
    Expression<String>? nama,
    Expression<String>? siklus,
    Expression<int>? nominal,
    Expression<int>? bulanTagihan,
    Expression<int>? tanggalTagihan,
    Expression<String>? metodeTahunan,
    Expression<String>? sumberAnggaran,
    Expression<int>? saldoCadangan,
    Expression<bool>? aktif,
    Expression<bool>? pengingatAktif,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nama != null) 'nama': nama,
      if (siklus != null) 'siklus': siklus,
      if (nominal != null) 'nominal': nominal,
      if (bulanTagihan != null) 'bulan_tagihan': bulanTagihan,
      if (tanggalTagihan != null) 'tanggal_tagihan': tanggalTagihan,
      if (metodeTahunan != null) 'metode_tahunan': metodeTahunan,
      if (sumberAnggaran != null) 'sumber_anggaran': sumberAnggaran,
      if (saldoCadangan != null) 'saldo_cadangan': saldoCadangan,
      if (aktif != null) 'aktif': aktif,
      if (pengingatAktif != null) 'pengingat_aktif': pengingatAktif,
    });
  }

  SubscriptionsCompanion copyWith({
    Value<int>? id,
    Value<String>? nama,
    Value<SubscriptionCycle>? siklus,
    Value<int>? nominal,
    Value<int>? bulanTagihan,
    Value<int?>? tanggalTagihan,
    Value<AnnualFundingMethod>? metodeTahunan,
    Value<SubscriptionFundingSource>? sumberAnggaran,
    Value<int>? saldoCadangan,
    Value<bool>? aktif,
    Value<bool>? pengingatAktif,
  }) {
    return SubscriptionsCompanion(
      id: id ?? this.id,
      nama: nama ?? this.nama,
      siklus: siklus ?? this.siklus,
      nominal: nominal ?? this.nominal,
      bulanTagihan: bulanTagihan ?? this.bulanTagihan,
      tanggalTagihan: tanggalTagihan ?? this.tanggalTagihan,
      metodeTahunan: metodeTahunan ?? this.metodeTahunan,
      sumberAnggaran: sumberAnggaran ?? this.sumberAnggaran,
      saldoCadangan: saldoCadangan ?? this.saldoCadangan,
      aktif: aktif ?? this.aktif,
      pengingatAktif: pengingatAktif ?? this.pengingatAktif,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nama.present) {
      map['nama'] = Variable<String>(nama.value);
    }
    if (siklus.present) {
      map['siklus'] = Variable<String>(
        $SubscriptionsTable.$convertersiklus.toSql(siklus.value),
      );
    }
    if (nominal.present) {
      map['nominal'] = Variable<int>(nominal.value);
    }
    if (bulanTagihan.present) {
      map['bulan_tagihan'] = Variable<int>(bulanTagihan.value);
    }
    if (tanggalTagihan.present) {
      map['tanggal_tagihan'] = Variable<int>(tanggalTagihan.value);
    }
    if (metodeTahunan.present) {
      map['metode_tahunan'] = Variable<String>(
        $SubscriptionsTable.$convertermetodeTahunan.toSql(metodeTahunan.value),
      );
    }
    if (sumberAnggaran.present) {
      map['sumber_anggaran'] = Variable<String>(
        $SubscriptionsTable.$convertersumberAnggaran.toSql(
          sumberAnggaran.value,
        ),
      );
    }
    if (saldoCadangan.present) {
      map['saldo_cadangan'] = Variable<int>(saldoCadangan.value);
    }
    if (aktif.present) {
      map['aktif'] = Variable<bool>(aktif.value);
    }
    if (pengingatAktif.present) {
      map['pengingat_aktif'] = Variable<bool>(pengingatAktif.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SubscriptionsCompanion(')
          ..write('id: $id, ')
          ..write('nama: $nama, ')
          ..write('siklus: $siklus, ')
          ..write('nominal: $nominal, ')
          ..write('bulanTagihan: $bulanTagihan, ')
          ..write('tanggalTagihan: $tanggalTagihan, ')
          ..write('metodeTahunan: $metodeTahunan, ')
          ..write('sumberAnggaran: $sumberAnggaran, ')
          ..write('saldoCadangan: $saldoCadangan, ')
          ..write('aktif: $aktif, ')
          ..write('pengingatAktif: $pengingatAktif')
          ..write(')'))
        .toString();
  }
}

class $SubscriptionReserveLedgersTable extends SubscriptionReserveLedgers
    with
        TableInfo<$SubscriptionReserveLedgersTable, SubscriptionReserveLedger> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SubscriptionReserveLedgersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _subscriptionIdMeta = const VerificationMeta(
    'subscriptionId',
  );
  @override
  late final GeneratedColumn<int> subscriptionId = GeneratedColumn<int>(
    'subscription_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES subscriptions (id)',
    ),
  );
  static const VerificationMeta _tahunMeta = const VerificationMeta('tahun');
  @override
  late final GeneratedColumn<int> tahun = GeneratedColumn<int>(
    'tahun',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bulanMeta = const VerificationMeta('bulan');
  @override
  late final GeneratedColumn<int> bulan = GeneratedColumn<int>(
    'bulan',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _saldoAwalMeta = const VerificationMeta(
    'saldoAwal',
  );
  @override
  late final GeneratedColumn<int> saldoAwal = GeneratedColumn<int>(
    'saldo_awal',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kontribusiMeta = const VerificationMeta(
    'kontribusi',
  );
  @override
  late final GeneratedColumn<int> kontribusi = GeneratedColumn<int>(
    'kontribusi',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pembayaranMeta = const VerificationMeta(
    'pembayaran',
  );
  @override
  late final GeneratedColumn<int> pembayaran = GeneratedColumn<int>(
    'pembayaran',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _saldoAkhirMeta = const VerificationMeta(
    'saldoAkhir',
  );
  @override
  late final GeneratedColumn<int> saldoAkhir = GeneratedColumn<int>(
    'saldo_akhir',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dibuatPadaMeta = const VerificationMeta(
    'dibuatPada',
  );
  @override
  late final GeneratedColumn<DateTime> dibuatPada = GeneratedColumn<DateTime>(
    'dibuat_pada',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    subscriptionId,
    tahun,
    bulan,
    saldoAwal,
    kontribusi,
    pembayaran,
    saldoAkhir,
    dibuatPada,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'subscription_reserve_ledgers';
  @override
  VerificationContext validateIntegrity(
    Insertable<SubscriptionReserveLedger> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('subscription_id')) {
      context.handle(
        _subscriptionIdMeta,
        subscriptionId.isAcceptableOrUnknown(
          data['subscription_id']!,
          _subscriptionIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_subscriptionIdMeta);
    }
    if (data.containsKey('tahun')) {
      context.handle(
        _tahunMeta,
        tahun.isAcceptableOrUnknown(data['tahun']!, _tahunMeta),
      );
    } else if (isInserting) {
      context.missing(_tahunMeta);
    }
    if (data.containsKey('bulan')) {
      context.handle(
        _bulanMeta,
        bulan.isAcceptableOrUnknown(data['bulan']!, _bulanMeta),
      );
    } else if (isInserting) {
      context.missing(_bulanMeta);
    }
    if (data.containsKey('saldo_awal')) {
      context.handle(
        _saldoAwalMeta,
        saldoAwal.isAcceptableOrUnknown(data['saldo_awal']!, _saldoAwalMeta),
      );
    } else if (isInserting) {
      context.missing(_saldoAwalMeta);
    }
    if (data.containsKey('kontribusi')) {
      context.handle(
        _kontribusiMeta,
        kontribusi.isAcceptableOrUnknown(data['kontribusi']!, _kontribusiMeta),
      );
    } else if (isInserting) {
      context.missing(_kontribusiMeta);
    }
    if (data.containsKey('pembayaran')) {
      context.handle(
        _pembayaranMeta,
        pembayaran.isAcceptableOrUnknown(data['pembayaran']!, _pembayaranMeta),
      );
    } else if (isInserting) {
      context.missing(_pembayaranMeta);
    }
    if (data.containsKey('saldo_akhir')) {
      context.handle(
        _saldoAkhirMeta,
        saldoAkhir.isAcceptableOrUnknown(data['saldo_akhir']!, _saldoAkhirMeta),
      );
    } else if (isInserting) {
      context.missing(_saldoAkhirMeta);
    }
    if (data.containsKey('dibuat_pada')) {
      context.handle(
        _dibuatPadaMeta,
        dibuatPada.isAcceptableOrUnknown(data['dibuat_pada']!, _dibuatPadaMeta),
      );
    } else if (isInserting) {
      context.missing(_dibuatPadaMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {subscriptionId, tahun, bulan},
  ];
  @override
  SubscriptionReserveLedger map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SubscriptionReserveLedger(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      subscriptionId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}subscription_id'],
      )!,
      tahun: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tahun'],
      )!,
      bulan: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}bulan'],
      )!,
      saldoAwal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}saldo_awal'],
      )!,
      kontribusi: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}kontribusi'],
      )!,
      pembayaran: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pembayaran'],
      )!,
      saldoAkhir: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}saldo_akhir'],
      )!,
      dibuatPada: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}dibuat_pada'],
      )!,
    );
  }

  @override
  $SubscriptionReserveLedgersTable createAlias(String alias) {
    return $SubscriptionReserveLedgersTable(attachedDatabase, alias);
  }
}

class SubscriptionReserveLedger extends DataClass
    implements Insertable<SubscriptionReserveLedger> {
  final int id;
  final int subscriptionId;
  final int tahun;
  final int bulan;
  final int saldoAwal;
  final int kontribusi;
  final int pembayaran;
  final int saldoAkhir;
  final DateTime dibuatPada;
  const SubscriptionReserveLedger({
    required this.id,
    required this.subscriptionId,
    required this.tahun,
    required this.bulan,
    required this.saldoAwal,
    required this.kontribusi,
    required this.pembayaran,
    required this.saldoAkhir,
    required this.dibuatPada,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['subscription_id'] = Variable<int>(subscriptionId);
    map['tahun'] = Variable<int>(tahun);
    map['bulan'] = Variable<int>(bulan);
    map['saldo_awal'] = Variable<int>(saldoAwal);
    map['kontribusi'] = Variable<int>(kontribusi);
    map['pembayaran'] = Variable<int>(pembayaran);
    map['saldo_akhir'] = Variable<int>(saldoAkhir);
    map['dibuat_pada'] = Variable<DateTime>(dibuatPada);
    return map;
  }

  SubscriptionReserveLedgersCompanion toCompanion(bool nullToAbsent) {
    return SubscriptionReserveLedgersCompanion(
      id: Value(id),
      subscriptionId: Value(subscriptionId),
      tahun: Value(tahun),
      bulan: Value(bulan),
      saldoAwal: Value(saldoAwal),
      kontribusi: Value(kontribusi),
      pembayaran: Value(pembayaran),
      saldoAkhir: Value(saldoAkhir),
      dibuatPada: Value(dibuatPada),
    );
  }

  factory SubscriptionReserveLedger.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SubscriptionReserveLedger(
      id: serializer.fromJson<int>(json['id']),
      subscriptionId: serializer.fromJson<int>(json['subscriptionId']),
      tahun: serializer.fromJson<int>(json['tahun']),
      bulan: serializer.fromJson<int>(json['bulan']),
      saldoAwal: serializer.fromJson<int>(json['saldoAwal']),
      kontribusi: serializer.fromJson<int>(json['kontribusi']),
      pembayaran: serializer.fromJson<int>(json['pembayaran']),
      saldoAkhir: serializer.fromJson<int>(json['saldoAkhir']),
      dibuatPada: serializer.fromJson<DateTime>(json['dibuatPada']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'subscriptionId': serializer.toJson<int>(subscriptionId),
      'tahun': serializer.toJson<int>(tahun),
      'bulan': serializer.toJson<int>(bulan),
      'saldoAwal': serializer.toJson<int>(saldoAwal),
      'kontribusi': serializer.toJson<int>(kontribusi),
      'pembayaran': serializer.toJson<int>(pembayaran),
      'saldoAkhir': serializer.toJson<int>(saldoAkhir),
      'dibuatPada': serializer.toJson<DateTime>(dibuatPada),
    };
  }

  SubscriptionReserveLedger copyWith({
    int? id,
    int? subscriptionId,
    int? tahun,
    int? bulan,
    int? saldoAwal,
    int? kontribusi,
    int? pembayaran,
    int? saldoAkhir,
    DateTime? dibuatPada,
  }) => SubscriptionReserveLedger(
    id: id ?? this.id,
    subscriptionId: subscriptionId ?? this.subscriptionId,
    tahun: tahun ?? this.tahun,
    bulan: bulan ?? this.bulan,
    saldoAwal: saldoAwal ?? this.saldoAwal,
    kontribusi: kontribusi ?? this.kontribusi,
    pembayaran: pembayaran ?? this.pembayaran,
    saldoAkhir: saldoAkhir ?? this.saldoAkhir,
    dibuatPada: dibuatPada ?? this.dibuatPada,
  );
  SubscriptionReserveLedger copyWithCompanion(
    SubscriptionReserveLedgersCompanion data,
  ) {
    return SubscriptionReserveLedger(
      id: data.id.present ? data.id.value : this.id,
      subscriptionId: data.subscriptionId.present
          ? data.subscriptionId.value
          : this.subscriptionId,
      tahun: data.tahun.present ? data.tahun.value : this.tahun,
      bulan: data.bulan.present ? data.bulan.value : this.bulan,
      saldoAwal: data.saldoAwal.present ? data.saldoAwal.value : this.saldoAwal,
      kontribusi: data.kontribusi.present
          ? data.kontribusi.value
          : this.kontribusi,
      pembayaran: data.pembayaran.present
          ? data.pembayaran.value
          : this.pembayaran,
      saldoAkhir: data.saldoAkhir.present
          ? data.saldoAkhir.value
          : this.saldoAkhir,
      dibuatPada: data.dibuatPada.present
          ? data.dibuatPada.value
          : this.dibuatPada,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SubscriptionReserveLedger(')
          ..write('id: $id, ')
          ..write('subscriptionId: $subscriptionId, ')
          ..write('tahun: $tahun, ')
          ..write('bulan: $bulan, ')
          ..write('saldoAwal: $saldoAwal, ')
          ..write('kontribusi: $kontribusi, ')
          ..write('pembayaran: $pembayaran, ')
          ..write('saldoAkhir: $saldoAkhir, ')
          ..write('dibuatPada: $dibuatPada')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    subscriptionId,
    tahun,
    bulan,
    saldoAwal,
    kontribusi,
    pembayaran,
    saldoAkhir,
    dibuatPada,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SubscriptionReserveLedger &&
          other.id == this.id &&
          other.subscriptionId == this.subscriptionId &&
          other.tahun == this.tahun &&
          other.bulan == this.bulan &&
          other.saldoAwal == this.saldoAwal &&
          other.kontribusi == this.kontribusi &&
          other.pembayaran == this.pembayaran &&
          other.saldoAkhir == this.saldoAkhir &&
          other.dibuatPada == this.dibuatPada);
}

class SubscriptionReserveLedgersCompanion
    extends UpdateCompanion<SubscriptionReserveLedger> {
  final Value<int> id;
  final Value<int> subscriptionId;
  final Value<int> tahun;
  final Value<int> bulan;
  final Value<int> saldoAwal;
  final Value<int> kontribusi;
  final Value<int> pembayaran;
  final Value<int> saldoAkhir;
  final Value<DateTime> dibuatPada;
  const SubscriptionReserveLedgersCompanion({
    this.id = const Value.absent(),
    this.subscriptionId = const Value.absent(),
    this.tahun = const Value.absent(),
    this.bulan = const Value.absent(),
    this.saldoAwal = const Value.absent(),
    this.kontribusi = const Value.absent(),
    this.pembayaran = const Value.absent(),
    this.saldoAkhir = const Value.absent(),
    this.dibuatPada = const Value.absent(),
  });
  SubscriptionReserveLedgersCompanion.insert({
    this.id = const Value.absent(),
    required int subscriptionId,
    required int tahun,
    required int bulan,
    required int saldoAwal,
    required int kontribusi,
    required int pembayaran,
    required int saldoAkhir,
    required DateTime dibuatPada,
  }) : subscriptionId = Value(subscriptionId),
       tahun = Value(tahun),
       bulan = Value(bulan),
       saldoAwal = Value(saldoAwal),
       kontribusi = Value(kontribusi),
       pembayaran = Value(pembayaran),
       saldoAkhir = Value(saldoAkhir),
       dibuatPada = Value(dibuatPada);
  static Insertable<SubscriptionReserveLedger> custom({
    Expression<int>? id,
    Expression<int>? subscriptionId,
    Expression<int>? tahun,
    Expression<int>? bulan,
    Expression<int>? saldoAwal,
    Expression<int>? kontribusi,
    Expression<int>? pembayaran,
    Expression<int>? saldoAkhir,
    Expression<DateTime>? dibuatPada,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (subscriptionId != null) 'subscription_id': subscriptionId,
      if (tahun != null) 'tahun': tahun,
      if (bulan != null) 'bulan': bulan,
      if (saldoAwal != null) 'saldo_awal': saldoAwal,
      if (kontribusi != null) 'kontribusi': kontribusi,
      if (pembayaran != null) 'pembayaran': pembayaran,
      if (saldoAkhir != null) 'saldo_akhir': saldoAkhir,
      if (dibuatPada != null) 'dibuat_pada': dibuatPada,
    });
  }

  SubscriptionReserveLedgersCompanion copyWith({
    Value<int>? id,
    Value<int>? subscriptionId,
    Value<int>? tahun,
    Value<int>? bulan,
    Value<int>? saldoAwal,
    Value<int>? kontribusi,
    Value<int>? pembayaran,
    Value<int>? saldoAkhir,
    Value<DateTime>? dibuatPada,
  }) {
    return SubscriptionReserveLedgersCompanion(
      id: id ?? this.id,
      subscriptionId: subscriptionId ?? this.subscriptionId,
      tahun: tahun ?? this.tahun,
      bulan: bulan ?? this.bulan,
      saldoAwal: saldoAwal ?? this.saldoAwal,
      kontribusi: kontribusi ?? this.kontribusi,
      pembayaran: pembayaran ?? this.pembayaran,
      saldoAkhir: saldoAkhir ?? this.saldoAkhir,
      dibuatPada: dibuatPada ?? this.dibuatPada,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (subscriptionId.present) {
      map['subscription_id'] = Variable<int>(subscriptionId.value);
    }
    if (tahun.present) {
      map['tahun'] = Variable<int>(tahun.value);
    }
    if (bulan.present) {
      map['bulan'] = Variable<int>(bulan.value);
    }
    if (saldoAwal.present) {
      map['saldo_awal'] = Variable<int>(saldoAwal.value);
    }
    if (kontribusi.present) {
      map['kontribusi'] = Variable<int>(kontribusi.value);
    }
    if (pembayaran.present) {
      map['pembayaran'] = Variable<int>(pembayaran.value);
    }
    if (saldoAkhir.present) {
      map['saldo_akhir'] = Variable<int>(saldoAkhir.value);
    }
    if (dibuatPada.present) {
      map['dibuat_pada'] = Variable<DateTime>(dibuatPada.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SubscriptionReserveLedgersCompanion(')
          ..write('id: $id, ')
          ..write('subscriptionId: $subscriptionId, ')
          ..write('tahun: $tahun, ')
          ..write('bulan: $bulan, ')
          ..write('saldoAwal: $saldoAwal, ')
          ..write('kontribusi: $kontribusi, ')
          ..write('pembayaran: $pembayaran, ')
          ..write('saldoAkhir: $saldoAkhir, ')
          ..write('dibuatPada: $dibuatPada')
          ..write(')'))
        .toString();
  }
}

class $EmergencyFundTargetsTable extends EmergencyFundTargets
    with TableInfo<$EmergencyFundTargetsTable, EmergencyFundTarget> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EmergencyFundTargetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _targetJumlahBulanMeta = const VerificationMeta(
    'targetJumlahBulan',
  );
  @override
  late final GeneratedColumn<int> targetJumlahBulan = GeneratedColumn<int>(
    'target_jumlah_bulan',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pengeluaranPokokManualMeta =
      const VerificationMeta('pengeluaranPokokManual');
  @override
  late final GeneratedColumn<int> pengeluaranPokokManual = GeneratedColumn<int>(
    'pengeluaran_pokok_manual',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _saldoSaatIniMeta = const VerificationMeta(
    'saldoSaatIni',
  );
  @override
  late final GeneratedColumn<int> saldoSaatIni = GeneratedColumn<int>(
    'saldo_saat_ini',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetTanggalTercapaiMeta =
      const VerificationMeta('targetTanggalTercapai');
  @override
  late final GeneratedColumn<DateTime> targetTanggalTercapai =
      GeneratedColumn<DateTime>(
        'target_tanggal_tercapai',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _diperbaruiPadaMeta = const VerificationMeta(
    'diperbaruiPada',
  );
  @override
  late final GeneratedColumn<DateTime> diperbaruiPada =
      GeneratedColumn<DateTime>(
        'diperbarui_pada',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    targetJumlahBulan,
    pengeluaranPokokManual,
    saldoSaatIni,
    targetTanggalTercapai,
    diperbaruiPada,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'emergency_fund_targets';
  @override
  VerificationContext validateIntegrity(
    Insertable<EmergencyFundTarget> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('target_jumlah_bulan')) {
      context.handle(
        _targetJumlahBulanMeta,
        targetJumlahBulan.isAcceptableOrUnknown(
          data['target_jumlah_bulan']!,
          _targetJumlahBulanMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_targetJumlahBulanMeta);
    }
    if (data.containsKey('pengeluaran_pokok_manual')) {
      context.handle(
        _pengeluaranPokokManualMeta,
        pengeluaranPokokManual.isAcceptableOrUnknown(
          data['pengeluaran_pokok_manual']!,
          _pengeluaranPokokManualMeta,
        ),
      );
    }
    if (data.containsKey('saldo_saat_ini')) {
      context.handle(
        _saldoSaatIniMeta,
        saldoSaatIni.isAcceptableOrUnknown(
          data['saldo_saat_ini']!,
          _saldoSaatIniMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_saldoSaatIniMeta);
    }
    if (data.containsKey('target_tanggal_tercapai')) {
      context.handle(
        _targetTanggalTercapaiMeta,
        targetTanggalTercapai.isAcceptableOrUnknown(
          data['target_tanggal_tercapai']!,
          _targetTanggalTercapaiMeta,
        ),
      );
    }
    if (data.containsKey('diperbarui_pada')) {
      context.handle(
        _diperbaruiPadaMeta,
        diperbaruiPada.isAcceptableOrUnknown(
          data['diperbarui_pada']!,
          _diperbaruiPadaMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_diperbaruiPadaMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EmergencyFundTarget map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EmergencyFundTarget(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      targetJumlahBulan: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target_jumlah_bulan'],
      )!,
      pengeluaranPokokManual: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pengeluaran_pokok_manual'],
      ),
      saldoSaatIni: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}saldo_saat_ini'],
      )!,
      targetTanggalTercapai: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}target_tanggal_tercapai'],
      ),
      diperbaruiPada: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}diperbarui_pada'],
      )!,
    );
  }

  @override
  $EmergencyFundTargetsTable createAlias(String alias) {
    return $EmergencyFundTargetsTable(attachedDatabase, alias);
  }
}

class EmergencyFundTarget extends DataClass
    implements Insertable<EmergencyFundTarget> {
  final int id;
  final int targetJumlahBulan;
  final int? pengeluaranPokokManual;
  final int saldoSaatIni;
  final DateTime? targetTanggalTercapai;
  final DateTime diperbaruiPada;
  const EmergencyFundTarget({
    required this.id,
    required this.targetJumlahBulan,
    this.pengeluaranPokokManual,
    required this.saldoSaatIni,
    this.targetTanggalTercapai,
    required this.diperbaruiPada,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['target_jumlah_bulan'] = Variable<int>(targetJumlahBulan);
    if (!nullToAbsent || pengeluaranPokokManual != null) {
      map['pengeluaran_pokok_manual'] = Variable<int>(pengeluaranPokokManual);
    }
    map['saldo_saat_ini'] = Variable<int>(saldoSaatIni);
    if (!nullToAbsent || targetTanggalTercapai != null) {
      map['target_tanggal_tercapai'] = Variable<DateTime>(
        targetTanggalTercapai,
      );
    }
    map['diperbarui_pada'] = Variable<DateTime>(diperbaruiPada);
    return map;
  }

  EmergencyFundTargetsCompanion toCompanion(bool nullToAbsent) {
    return EmergencyFundTargetsCompanion(
      id: Value(id),
      targetJumlahBulan: Value(targetJumlahBulan),
      pengeluaranPokokManual: pengeluaranPokokManual == null && nullToAbsent
          ? const Value.absent()
          : Value(pengeluaranPokokManual),
      saldoSaatIni: Value(saldoSaatIni),
      targetTanggalTercapai: targetTanggalTercapai == null && nullToAbsent
          ? const Value.absent()
          : Value(targetTanggalTercapai),
      diperbaruiPada: Value(diperbaruiPada),
    );
  }

  factory EmergencyFundTarget.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EmergencyFundTarget(
      id: serializer.fromJson<int>(json['id']),
      targetJumlahBulan: serializer.fromJson<int>(json['targetJumlahBulan']),
      pengeluaranPokokManual: serializer.fromJson<int?>(
        json['pengeluaranPokokManual'],
      ),
      saldoSaatIni: serializer.fromJson<int>(json['saldoSaatIni']),
      targetTanggalTercapai: serializer.fromJson<DateTime?>(
        json['targetTanggalTercapai'],
      ),
      diperbaruiPada: serializer.fromJson<DateTime>(json['diperbaruiPada']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'targetJumlahBulan': serializer.toJson<int>(targetJumlahBulan),
      'pengeluaranPokokManual': serializer.toJson<int?>(pengeluaranPokokManual),
      'saldoSaatIni': serializer.toJson<int>(saldoSaatIni),
      'targetTanggalTercapai': serializer.toJson<DateTime?>(
        targetTanggalTercapai,
      ),
      'diperbaruiPada': serializer.toJson<DateTime>(diperbaruiPada),
    };
  }

  EmergencyFundTarget copyWith({
    int? id,
    int? targetJumlahBulan,
    Value<int?> pengeluaranPokokManual = const Value.absent(),
    int? saldoSaatIni,
    Value<DateTime?> targetTanggalTercapai = const Value.absent(),
    DateTime? diperbaruiPada,
  }) => EmergencyFundTarget(
    id: id ?? this.id,
    targetJumlahBulan: targetJumlahBulan ?? this.targetJumlahBulan,
    pengeluaranPokokManual: pengeluaranPokokManual.present
        ? pengeluaranPokokManual.value
        : this.pengeluaranPokokManual,
    saldoSaatIni: saldoSaatIni ?? this.saldoSaatIni,
    targetTanggalTercapai: targetTanggalTercapai.present
        ? targetTanggalTercapai.value
        : this.targetTanggalTercapai,
    diperbaruiPada: diperbaruiPada ?? this.diperbaruiPada,
  );
  EmergencyFundTarget copyWithCompanion(EmergencyFundTargetsCompanion data) {
    return EmergencyFundTarget(
      id: data.id.present ? data.id.value : this.id,
      targetJumlahBulan: data.targetJumlahBulan.present
          ? data.targetJumlahBulan.value
          : this.targetJumlahBulan,
      pengeluaranPokokManual: data.pengeluaranPokokManual.present
          ? data.pengeluaranPokokManual.value
          : this.pengeluaranPokokManual,
      saldoSaatIni: data.saldoSaatIni.present
          ? data.saldoSaatIni.value
          : this.saldoSaatIni,
      targetTanggalTercapai: data.targetTanggalTercapai.present
          ? data.targetTanggalTercapai.value
          : this.targetTanggalTercapai,
      diperbaruiPada: data.diperbaruiPada.present
          ? data.diperbaruiPada.value
          : this.diperbaruiPada,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EmergencyFundTarget(')
          ..write('id: $id, ')
          ..write('targetJumlahBulan: $targetJumlahBulan, ')
          ..write('pengeluaranPokokManual: $pengeluaranPokokManual, ')
          ..write('saldoSaatIni: $saldoSaatIni, ')
          ..write('targetTanggalTercapai: $targetTanggalTercapai, ')
          ..write('diperbaruiPada: $diperbaruiPada')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    targetJumlahBulan,
    pengeluaranPokokManual,
    saldoSaatIni,
    targetTanggalTercapai,
    diperbaruiPada,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EmergencyFundTarget &&
          other.id == this.id &&
          other.targetJumlahBulan == this.targetJumlahBulan &&
          other.pengeluaranPokokManual == this.pengeluaranPokokManual &&
          other.saldoSaatIni == this.saldoSaatIni &&
          other.targetTanggalTercapai == this.targetTanggalTercapai &&
          other.diperbaruiPada == this.diperbaruiPada);
}

class EmergencyFundTargetsCompanion
    extends UpdateCompanion<EmergencyFundTarget> {
  final Value<int> id;
  final Value<int> targetJumlahBulan;
  final Value<int?> pengeluaranPokokManual;
  final Value<int> saldoSaatIni;
  final Value<DateTime?> targetTanggalTercapai;
  final Value<DateTime> diperbaruiPada;
  const EmergencyFundTargetsCompanion({
    this.id = const Value.absent(),
    this.targetJumlahBulan = const Value.absent(),
    this.pengeluaranPokokManual = const Value.absent(),
    this.saldoSaatIni = const Value.absent(),
    this.targetTanggalTercapai = const Value.absent(),
    this.diperbaruiPada = const Value.absent(),
  });
  EmergencyFundTargetsCompanion.insert({
    this.id = const Value.absent(),
    required int targetJumlahBulan,
    this.pengeluaranPokokManual = const Value.absent(),
    required int saldoSaatIni,
    this.targetTanggalTercapai = const Value.absent(),
    required DateTime diperbaruiPada,
  }) : targetJumlahBulan = Value(targetJumlahBulan),
       saldoSaatIni = Value(saldoSaatIni),
       diperbaruiPada = Value(diperbaruiPada);
  static Insertable<EmergencyFundTarget> custom({
    Expression<int>? id,
    Expression<int>? targetJumlahBulan,
    Expression<int>? pengeluaranPokokManual,
    Expression<int>? saldoSaatIni,
    Expression<DateTime>? targetTanggalTercapai,
    Expression<DateTime>? diperbaruiPada,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (targetJumlahBulan != null) 'target_jumlah_bulan': targetJumlahBulan,
      if (pengeluaranPokokManual != null)
        'pengeluaran_pokok_manual': pengeluaranPokokManual,
      if (saldoSaatIni != null) 'saldo_saat_ini': saldoSaatIni,
      if (targetTanggalTercapai != null)
        'target_tanggal_tercapai': targetTanggalTercapai,
      if (diperbaruiPada != null) 'diperbarui_pada': diperbaruiPada,
    });
  }

  EmergencyFundTargetsCompanion copyWith({
    Value<int>? id,
    Value<int>? targetJumlahBulan,
    Value<int?>? pengeluaranPokokManual,
    Value<int>? saldoSaatIni,
    Value<DateTime?>? targetTanggalTercapai,
    Value<DateTime>? diperbaruiPada,
  }) {
    return EmergencyFundTargetsCompanion(
      id: id ?? this.id,
      targetJumlahBulan: targetJumlahBulan ?? this.targetJumlahBulan,
      pengeluaranPokokManual:
          pengeluaranPokokManual ?? this.pengeluaranPokokManual,
      saldoSaatIni: saldoSaatIni ?? this.saldoSaatIni,
      targetTanggalTercapai:
          targetTanggalTercapai ?? this.targetTanggalTercapai,
      diperbaruiPada: diperbaruiPada ?? this.diperbaruiPada,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (targetJumlahBulan.present) {
      map['target_jumlah_bulan'] = Variable<int>(targetJumlahBulan.value);
    }
    if (pengeluaranPokokManual.present) {
      map['pengeluaran_pokok_manual'] = Variable<int>(
        pengeluaranPokokManual.value,
      );
    }
    if (saldoSaatIni.present) {
      map['saldo_saat_ini'] = Variable<int>(saldoSaatIni.value);
    }
    if (targetTanggalTercapai.present) {
      map['target_tanggal_tercapai'] = Variable<DateTime>(
        targetTanggalTercapai.value,
      );
    }
    if (diperbaruiPada.present) {
      map['diperbarui_pada'] = Variable<DateTime>(diperbaruiPada.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EmergencyFundTargetsCompanion(')
          ..write('id: $id, ')
          ..write('targetJumlahBulan: $targetJumlahBulan, ')
          ..write('pengeluaranPokokManual: $pengeluaranPokokManual, ')
          ..write('saldoSaatIni: $saldoSaatIni, ')
          ..write('targetTanggalTercapai: $targetTanggalTercapai, ')
          ..write('diperbaruiPada: $diperbaruiPada')
          ..write(')'))
        .toString();
  }
}

class $EmergencyFundContributionsTable extends EmergencyFundContributions
    with
        TableInfo<$EmergencyFundContributionsTable, EmergencyFundContribution> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EmergencyFundContributionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _tahunMeta = const VerificationMeta('tahun');
  @override
  late final GeneratedColumn<int> tahun = GeneratedColumn<int>(
    'tahun',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bulanMeta = const VerificationMeta('bulan');
  @override
  late final GeneratedColumn<int> bulan = GeneratedColumn<int>(
    'bulan',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nominalMeta = const VerificationMeta(
    'nominal',
  );
  @override
  late final GeneratedColumn<int> nominal = GeneratedColumn<int>(
    'nominal',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<PlanActualStatus, String> status =
      GeneratedColumn<String>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<PlanActualStatus>(
        $EmergencyFundContributionsTable.$converterstatus,
      );
  static const VerificationMeta _catatanMeta = const VerificationMeta(
    'catatan',
  );
  @override
  late final GeneratedColumn<String> catatan = GeneratedColumn<String>(
    'catatan',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dibuatPadaMeta = const VerificationMeta(
    'dibuatPada',
  );
  @override
  late final GeneratedColumn<DateTime> dibuatPada = GeneratedColumn<DateTime>(
    'dibuat_pada',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tahun,
    bulan,
    nominal,
    status,
    catatan,
    dibuatPada,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'emergency_fund_contributions';
  @override
  VerificationContext validateIntegrity(
    Insertable<EmergencyFundContribution> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('tahun')) {
      context.handle(
        _tahunMeta,
        tahun.isAcceptableOrUnknown(data['tahun']!, _tahunMeta),
      );
    } else if (isInserting) {
      context.missing(_tahunMeta);
    }
    if (data.containsKey('bulan')) {
      context.handle(
        _bulanMeta,
        bulan.isAcceptableOrUnknown(data['bulan']!, _bulanMeta),
      );
    } else if (isInserting) {
      context.missing(_bulanMeta);
    }
    if (data.containsKey('nominal')) {
      context.handle(
        _nominalMeta,
        nominal.isAcceptableOrUnknown(data['nominal']!, _nominalMeta),
      );
    } else if (isInserting) {
      context.missing(_nominalMeta);
    }
    if (data.containsKey('catatan')) {
      context.handle(
        _catatanMeta,
        catatan.isAcceptableOrUnknown(data['catatan']!, _catatanMeta),
      );
    }
    if (data.containsKey('dibuat_pada')) {
      context.handle(
        _dibuatPadaMeta,
        dibuatPada.isAcceptableOrUnknown(data['dibuat_pada']!, _dibuatPadaMeta),
      );
    } else if (isInserting) {
      context.missing(_dibuatPadaMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EmergencyFundContribution map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EmergencyFundContribution(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      tahun: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tahun'],
      )!,
      bulan: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}bulan'],
      )!,
      nominal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}nominal'],
      )!,
      status: $EmergencyFundContributionsTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
      catatan: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}catatan'],
      ),
      dibuatPada: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}dibuat_pada'],
      )!,
    );
  }

  @override
  $EmergencyFundContributionsTable createAlias(String alias) {
    return $EmergencyFundContributionsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<PlanActualStatus, String, String> $converterstatus =
      const EnumNameConverter<PlanActualStatus>(PlanActualStatus.values);
}

class EmergencyFundContribution extends DataClass
    implements Insertable<EmergencyFundContribution> {
  final int id;
  final int tahun;
  final int bulan;
  final int nominal;
  final PlanActualStatus status;
  final String? catatan;
  final DateTime dibuatPada;
  const EmergencyFundContribution({
    required this.id,
    required this.tahun,
    required this.bulan,
    required this.nominal,
    required this.status,
    this.catatan,
    required this.dibuatPada,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['tahun'] = Variable<int>(tahun);
    map['bulan'] = Variable<int>(bulan);
    map['nominal'] = Variable<int>(nominal);
    {
      map['status'] = Variable<String>(
        $EmergencyFundContributionsTable.$converterstatus.toSql(status),
      );
    }
    if (!nullToAbsent || catatan != null) {
      map['catatan'] = Variable<String>(catatan);
    }
    map['dibuat_pada'] = Variable<DateTime>(dibuatPada);
    return map;
  }

  EmergencyFundContributionsCompanion toCompanion(bool nullToAbsent) {
    return EmergencyFundContributionsCompanion(
      id: Value(id),
      tahun: Value(tahun),
      bulan: Value(bulan),
      nominal: Value(nominal),
      status: Value(status),
      catatan: catatan == null && nullToAbsent
          ? const Value.absent()
          : Value(catatan),
      dibuatPada: Value(dibuatPada),
    );
  }

  factory EmergencyFundContribution.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EmergencyFundContribution(
      id: serializer.fromJson<int>(json['id']),
      tahun: serializer.fromJson<int>(json['tahun']),
      bulan: serializer.fromJson<int>(json['bulan']),
      nominal: serializer.fromJson<int>(json['nominal']),
      status: $EmergencyFundContributionsTable.$converterstatus.fromJson(
        serializer.fromJson<String>(json['status']),
      ),
      catatan: serializer.fromJson<String?>(json['catatan']),
      dibuatPada: serializer.fromJson<DateTime>(json['dibuatPada']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tahun': serializer.toJson<int>(tahun),
      'bulan': serializer.toJson<int>(bulan),
      'nominal': serializer.toJson<int>(nominal),
      'status': serializer.toJson<String>(
        $EmergencyFundContributionsTable.$converterstatus.toJson(status),
      ),
      'catatan': serializer.toJson<String?>(catatan),
      'dibuatPada': serializer.toJson<DateTime>(dibuatPada),
    };
  }

  EmergencyFundContribution copyWith({
    int? id,
    int? tahun,
    int? bulan,
    int? nominal,
    PlanActualStatus? status,
    Value<String?> catatan = const Value.absent(),
    DateTime? dibuatPada,
  }) => EmergencyFundContribution(
    id: id ?? this.id,
    tahun: tahun ?? this.tahun,
    bulan: bulan ?? this.bulan,
    nominal: nominal ?? this.nominal,
    status: status ?? this.status,
    catatan: catatan.present ? catatan.value : this.catatan,
    dibuatPada: dibuatPada ?? this.dibuatPada,
  );
  EmergencyFundContribution copyWithCompanion(
    EmergencyFundContributionsCompanion data,
  ) {
    return EmergencyFundContribution(
      id: data.id.present ? data.id.value : this.id,
      tahun: data.tahun.present ? data.tahun.value : this.tahun,
      bulan: data.bulan.present ? data.bulan.value : this.bulan,
      nominal: data.nominal.present ? data.nominal.value : this.nominal,
      status: data.status.present ? data.status.value : this.status,
      catatan: data.catatan.present ? data.catatan.value : this.catatan,
      dibuatPada: data.dibuatPada.present
          ? data.dibuatPada.value
          : this.dibuatPada,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EmergencyFundContribution(')
          ..write('id: $id, ')
          ..write('tahun: $tahun, ')
          ..write('bulan: $bulan, ')
          ..write('nominal: $nominal, ')
          ..write('status: $status, ')
          ..write('catatan: $catatan, ')
          ..write('dibuatPada: $dibuatPada')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, tahun, bulan, nominal, status, catatan, dibuatPada);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EmergencyFundContribution &&
          other.id == this.id &&
          other.tahun == this.tahun &&
          other.bulan == this.bulan &&
          other.nominal == this.nominal &&
          other.status == this.status &&
          other.catatan == this.catatan &&
          other.dibuatPada == this.dibuatPada);
}

class EmergencyFundContributionsCompanion
    extends UpdateCompanion<EmergencyFundContribution> {
  final Value<int> id;
  final Value<int> tahun;
  final Value<int> bulan;
  final Value<int> nominal;
  final Value<PlanActualStatus> status;
  final Value<String?> catatan;
  final Value<DateTime> dibuatPada;
  const EmergencyFundContributionsCompanion({
    this.id = const Value.absent(),
    this.tahun = const Value.absent(),
    this.bulan = const Value.absent(),
    this.nominal = const Value.absent(),
    this.status = const Value.absent(),
    this.catatan = const Value.absent(),
    this.dibuatPada = const Value.absent(),
  });
  EmergencyFundContributionsCompanion.insert({
    this.id = const Value.absent(),
    required int tahun,
    required int bulan,
    required int nominal,
    required PlanActualStatus status,
    this.catatan = const Value.absent(),
    required DateTime dibuatPada,
  }) : tahun = Value(tahun),
       bulan = Value(bulan),
       nominal = Value(nominal),
       status = Value(status),
       dibuatPada = Value(dibuatPada);
  static Insertable<EmergencyFundContribution> custom({
    Expression<int>? id,
    Expression<int>? tahun,
    Expression<int>? bulan,
    Expression<int>? nominal,
    Expression<String>? status,
    Expression<String>? catatan,
    Expression<DateTime>? dibuatPada,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tahun != null) 'tahun': tahun,
      if (bulan != null) 'bulan': bulan,
      if (nominal != null) 'nominal': nominal,
      if (status != null) 'status': status,
      if (catatan != null) 'catatan': catatan,
      if (dibuatPada != null) 'dibuat_pada': dibuatPada,
    });
  }

  EmergencyFundContributionsCompanion copyWith({
    Value<int>? id,
    Value<int>? tahun,
    Value<int>? bulan,
    Value<int>? nominal,
    Value<PlanActualStatus>? status,
    Value<String?>? catatan,
    Value<DateTime>? dibuatPada,
  }) {
    return EmergencyFundContributionsCompanion(
      id: id ?? this.id,
      tahun: tahun ?? this.tahun,
      bulan: bulan ?? this.bulan,
      nominal: nominal ?? this.nominal,
      status: status ?? this.status,
      catatan: catatan ?? this.catatan,
      dibuatPada: dibuatPada ?? this.dibuatPada,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tahun.present) {
      map['tahun'] = Variable<int>(tahun.value);
    }
    if (bulan.present) {
      map['bulan'] = Variable<int>(bulan.value);
    }
    if (nominal.present) {
      map['nominal'] = Variable<int>(nominal.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $EmergencyFundContributionsTable.$converterstatus.toSql(status.value),
      );
    }
    if (catatan.present) {
      map['catatan'] = Variable<String>(catatan.value);
    }
    if (dibuatPada.present) {
      map['dibuat_pada'] = Variable<DateTime>(dibuatPada.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EmergencyFundContributionsCompanion(')
          ..write('id: $id, ')
          ..write('tahun: $tahun, ')
          ..write('bulan: $bulan, ')
          ..write('nominal: $nominal, ')
          ..write('status: $status, ')
          ..write('catatan: $catatan, ')
          ..write('dibuatPada: $dibuatPada')
          ..write(')'))
        .toString();
  }
}

class $OtherSavingsContributionsTable extends OtherSavingsContributions
    with TableInfo<$OtherSavingsContributionsTable, OtherSavingsContribution> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OtherSavingsContributionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _namaMeta = const VerificationMeta('nama');
  @override
  late final GeneratedColumn<String> nama = GeneratedColumn<String>(
    'nama',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nominalMeta = const VerificationMeta(
    'nominal',
  );
  @override
  late final GeneratedColumn<int> nominal = GeneratedColumn<int>(
    'nominal',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tahunMeta = const VerificationMeta('tahun');
  @override
  late final GeneratedColumn<int> tahun = GeneratedColumn<int>(
    'tahun',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bulanMeta = const VerificationMeta('bulan');
  @override
  late final GeneratedColumn<int> bulan = GeneratedColumn<int>(
    'bulan',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<PlanActualStatus, String> status =
      GeneratedColumn<String>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<PlanActualStatus>(
        $OtherSavingsContributionsTable.$converterstatus,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nama,
    nominal,
    tahun,
    bulan,
    status,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'other_savings_contributions';
  @override
  VerificationContext validateIntegrity(
    Insertable<OtherSavingsContribution> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nama')) {
      context.handle(
        _namaMeta,
        nama.isAcceptableOrUnknown(data['nama']!, _namaMeta),
      );
    } else if (isInserting) {
      context.missing(_namaMeta);
    }
    if (data.containsKey('nominal')) {
      context.handle(
        _nominalMeta,
        nominal.isAcceptableOrUnknown(data['nominal']!, _nominalMeta),
      );
    } else if (isInserting) {
      context.missing(_nominalMeta);
    }
    if (data.containsKey('tahun')) {
      context.handle(
        _tahunMeta,
        tahun.isAcceptableOrUnknown(data['tahun']!, _tahunMeta),
      );
    } else if (isInserting) {
      context.missing(_tahunMeta);
    }
    if (data.containsKey('bulan')) {
      context.handle(
        _bulanMeta,
        bulan.isAcceptableOrUnknown(data['bulan']!, _bulanMeta),
      );
    } else if (isInserting) {
      context.missing(_bulanMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OtherSavingsContribution map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OtherSavingsContribution(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nama: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nama'],
      )!,
      nominal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}nominal'],
      )!,
      tahun: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tahun'],
      )!,
      bulan: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}bulan'],
      )!,
      status: $OtherSavingsContributionsTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
    );
  }

  @override
  $OtherSavingsContributionsTable createAlias(String alias) {
    return $OtherSavingsContributionsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<PlanActualStatus, String, String> $converterstatus =
      const EnumNameConverter<PlanActualStatus>(PlanActualStatus.values);
}

class OtherSavingsContribution extends DataClass
    implements Insertable<OtherSavingsContribution> {
  final int id;
  final String nama;
  final int nominal;
  final int tahun;
  final int bulan;
  final PlanActualStatus status;
  const OtherSavingsContribution({
    required this.id,
    required this.nama,
    required this.nominal,
    required this.tahun,
    required this.bulan,
    required this.status,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nama'] = Variable<String>(nama);
    map['nominal'] = Variable<int>(nominal);
    map['tahun'] = Variable<int>(tahun);
    map['bulan'] = Variable<int>(bulan);
    {
      map['status'] = Variable<String>(
        $OtherSavingsContributionsTable.$converterstatus.toSql(status),
      );
    }
    return map;
  }

  OtherSavingsContributionsCompanion toCompanion(bool nullToAbsent) {
    return OtherSavingsContributionsCompanion(
      id: Value(id),
      nama: Value(nama),
      nominal: Value(nominal),
      tahun: Value(tahun),
      bulan: Value(bulan),
      status: Value(status),
    );
  }

  factory OtherSavingsContribution.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OtherSavingsContribution(
      id: serializer.fromJson<int>(json['id']),
      nama: serializer.fromJson<String>(json['nama']),
      nominal: serializer.fromJson<int>(json['nominal']),
      tahun: serializer.fromJson<int>(json['tahun']),
      bulan: serializer.fromJson<int>(json['bulan']),
      status: $OtherSavingsContributionsTable.$converterstatus.fromJson(
        serializer.fromJson<String>(json['status']),
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nama': serializer.toJson<String>(nama),
      'nominal': serializer.toJson<int>(nominal),
      'tahun': serializer.toJson<int>(tahun),
      'bulan': serializer.toJson<int>(bulan),
      'status': serializer.toJson<String>(
        $OtherSavingsContributionsTable.$converterstatus.toJson(status),
      ),
    };
  }

  OtherSavingsContribution copyWith({
    int? id,
    String? nama,
    int? nominal,
    int? tahun,
    int? bulan,
    PlanActualStatus? status,
  }) => OtherSavingsContribution(
    id: id ?? this.id,
    nama: nama ?? this.nama,
    nominal: nominal ?? this.nominal,
    tahun: tahun ?? this.tahun,
    bulan: bulan ?? this.bulan,
    status: status ?? this.status,
  );
  OtherSavingsContribution copyWithCompanion(
    OtherSavingsContributionsCompanion data,
  ) {
    return OtherSavingsContribution(
      id: data.id.present ? data.id.value : this.id,
      nama: data.nama.present ? data.nama.value : this.nama,
      nominal: data.nominal.present ? data.nominal.value : this.nominal,
      tahun: data.tahun.present ? data.tahun.value : this.tahun,
      bulan: data.bulan.present ? data.bulan.value : this.bulan,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OtherSavingsContribution(')
          ..write('id: $id, ')
          ..write('nama: $nama, ')
          ..write('nominal: $nominal, ')
          ..write('tahun: $tahun, ')
          ..write('bulan: $bulan, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nama, nominal, tahun, bulan, status);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OtherSavingsContribution &&
          other.id == this.id &&
          other.nama == this.nama &&
          other.nominal == this.nominal &&
          other.tahun == this.tahun &&
          other.bulan == this.bulan &&
          other.status == this.status);
}

class OtherSavingsContributionsCompanion
    extends UpdateCompanion<OtherSavingsContribution> {
  final Value<int> id;
  final Value<String> nama;
  final Value<int> nominal;
  final Value<int> tahun;
  final Value<int> bulan;
  final Value<PlanActualStatus> status;
  const OtherSavingsContributionsCompanion({
    this.id = const Value.absent(),
    this.nama = const Value.absent(),
    this.nominal = const Value.absent(),
    this.tahun = const Value.absent(),
    this.bulan = const Value.absent(),
    this.status = const Value.absent(),
  });
  OtherSavingsContributionsCompanion.insert({
    this.id = const Value.absent(),
    required String nama,
    required int nominal,
    required int tahun,
    required int bulan,
    required PlanActualStatus status,
  }) : nama = Value(nama),
       nominal = Value(nominal),
       tahun = Value(tahun),
       bulan = Value(bulan),
       status = Value(status);
  static Insertable<OtherSavingsContribution> custom({
    Expression<int>? id,
    Expression<String>? nama,
    Expression<int>? nominal,
    Expression<int>? tahun,
    Expression<int>? bulan,
    Expression<String>? status,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nama != null) 'nama': nama,
      if (nominal != null) 'nominal': nominal,
      if (tahun != null) 'tahun': tahun,
      if (bulan != null) 'bulan': bulan,
      if (status != null) 'status': status,
    });
  }

  OtherSavingsContributionsCompanion copyWith({
    Value<int>? id,
    Value<String>? nama,
    Value<int>? nominal,
    Value<int>? tahun,
    Value<int>? bulan,
    Value<PlanActualStatus>? status,
  }) {
    return OtherSavingsContributionsCompanion(
      id: id ?? this.id,
      nama: nama ?? this.nama,
      nominal: nominal ?? this.nominal,
      tahun: tahun ?? this.tahun,
      bulan: bulan ?? this.bulan,
      status: status ?? this.status,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nama.present) {
      map['nama'] = Variable<String>(nama.value);
    }
    if (nominal.present) {
      map['nominal'] = Variable<int>(nominal.value);
    }
    if (tahun.present) {
      map['tahun'] = Variable<int>(tahun.value);
    }
    if (bulan.present) {
      map['bulan'] = Variable<int>(bulan.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $OtherSavingsContributionsTable.$converterstatus.toSql(status.value),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OtherSavingsContributionsCompanion(')
          ..write('id: $id, ')
          ..write('nama: $nama, ')
          ..write('nominal: $nominal, ')
          ..write('tahun: $tahun, ')
          ..write('bulan: $bulan, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }
}

class $InvestmentPlatformAllocationsTable extends InvestmentPlatformAllocations
    with
        TableInfo<
          $InvestmentPlatformAllocationsTable,
          InvestmentPlatformAllocation
        > {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InvestmentPlatformAllocationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _revisionIdMeta = const VerificationMeta(
    'revisionId',
  );
  @override
  late final GeneratedColumn<int> revisionId = GeneratedColumn<int>(
    'revision_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES monthly_allocation_revisions (id)',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<InvestmentPlatform, String>
  platform =
      GeneratedColumn<String>(
        'platform',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<InvestmentPlatform>(
        $InvestmentPlatformAllocationsTable.$converterplatform,
      );
  static const VerificationMeta _targetPercentageBpMeta =
      const VerificationMeta('targetPercentageBp');
  @override
  late final GeneratedColumn<int> targetPercentageBp = GeneratedColumn<int>(
    'target_percentage_bp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetAmountMeta = const VerificationMeta(
    'targetAmount',
  );
  @override
  late final GeneratedColumn<int> targetAmount = GeneratedColumn<int>(
    'target_amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _roundedAmountMeta = const VerificationMeta(
    'roundedAmount',
  );
  @override
  late final GeneratedColumn<int> roundedAmount = GeneratedColumn<int>(
    'rounded_amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _plannedTransferDateMeta =
      const VerificationMeta('plannedTransferDate');
  @override
  late final GeneratedColumn<DateTime> plannedTransferDate =
      GeneratedColumn<DateTime>(
        'planned_transfer_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  @override
  late final GeneratedColumnWithTypeConverter<PlanActualStatus, String> status =
      GeneratedColumn<String>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<PlanActualStatus>(
        $InvestmentPlatformAllocationsTable.$converterstatus,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    revisionId,
    platform,
    targetPercentageBp,
    targetAmount,
    roundedAmount,
    plannedTransferDate,
    status,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'investment_platform_allocations';
  @override
  VerificationContext validateIntegrity(
    Insertable<InvestmentPlatformAllocation> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('revision_id')) {
      context.handle(
        _revisionIdMeta,
        revisionId.isAcceptableOrUnknown(data['revision_id']!, _revisionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_revisionIdMeta);
    }
    if (data.containsKey('target_percentage_bp')) {
      context.handle(
        _targetPercentageBpMeta,
        targetPercentageBp.isAcceptableOrUnknown(
          data['target_percentage_bp']!,
          _targetPercentageBpMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_targetPercentageBpMeta);
    }
    if (data.containsKey('target_amount')) {
      context.handle(
        _targetAmountMeta,
        targetAmount.isAcceptableOrUnknown(
          data['target_amount']!,
          _targetAmountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_targetAmountMeta);
    }
    if (data.containsKey('rounded_amount')) {
      context.handle(
        _roundedAmountMeta,
        roundedAmount.isAcceptableOrUnknown(
          data['rounded_amount']!,
          _roundedAmountMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_roundedAmountMeta);
    }
    if (data.containsKey('planned_transfer_date')) {
      context.handle(
        _plannedTransferDateMeta,
        plannedTransferDate.isAcceptableOrUnknown(
          data['planned_transfer_date']!,
          _plannedTransferDateMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {revisionId, platform},
  ];
  @override
  InvestmentPlatformAllocation map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InvestmentPlatformAllocation(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      revisionId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}revision_id'],
      )!,
      platform: $InvestmentPlatformAllocationsTable.$converterplatform.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}platform'],
        )!,
      ),
      targetPercentageBp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target_percentage_bp'],
      )!,
      targetAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target_amount'],
      )!,
      roundedAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rounded_amount'],
      )!,
      plannedTransferDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}planned_transfer_date'],
      ),
      status: $InvestmentPlatformAllocationsTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
    );
  }

  @override
  $InvestmentPlatformAllocationsTable createAlias(String alias) {
    return $InvestmentPlatformAllocationsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<InvestmentPlatform, String, String>
  $converterplatform = const EnumNameConverter<InvestmentPlatform>(
    InvestmentPlatform.values,
  );
  static JsonTypeConverter2<PlanActualStatus, String, String> $converterstatus =
      const EnumNameConverter<PlanActualStatus>(PlanActualStatus.values);
}

class InvestmentPlatformAllocation extends DataClass
    implements Insertable<InvestmentPlatformAllocation> {
  final int id;
  final int revisionId;
  final InvestmentPlatform platform;
  final int targetPercentageBp;
  final int targetAmount;
  final int roundedAmount;
  final DateTime? plannedTransferDate;
  final PlanActualStatus status;
  const InvestmentPlatformAllocation({
    required this.id,
    required this.revisionId,
    required this.platform,
    required this.targetPercentageBp,
    required this.targetAmount,
    required this.roundedAmount,
    this.plannedTransferDate,
    required this.status,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['revision_id'] = Variable<int>(revisionId);
    {
      map['platform'] = Variable<String>(
        $InvestmentPlatformAllocationsTable.$converterplatform.toSql(platform),
      );
    }
    map['target_percentage_bp'] = Variable<int>(targetPercentageBp);
    map['target_amount'] = Variable<int>(targetAmount);
    map['rounded_amount'] = Variable<int>(roundedAmount);
    if (!nullToAbsent || plannedTransferDate != null) {
      map['planned_transfer_date'] = Variable<DateTime>(plannedTransferDate);
    }
    {
      map['status'] = Variable<String>(
        $InvestmentPlatformAllocationsTable.$converterstatus.toSql(status),
      );
    }
    return map;
  }

  InvestmentPlatformAllocationsCompanion toCompanion(bool nullToAbsent) {
    return InvestmentPlatformAllocationsCompanion(
      id: Value(id),
      revisionId: Value(revisionId),
      platform: Value(platform),
      targetPercentageBp: Value(targetPercentageBp),
      targetAmount: Value(targetAmount),
      roundedAmount: Value(roundedAmount),
      plannedTransferDate: plannedTransferDate == null && nullToAbsent
          ? const Value.absent()
          : Value(plannedTransferDate),
      status: Value(status),
    );
  }

  factory InvestmentPlatformAllocation.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InvestmentPlatformAllocation(
      id: serializer.fromJson<int>(json['id']),
      revisionId: serializer.fromJson<int>(json['revisionId']),
      platform: $InvestmentPlatformAllocationsTable.$converterplatform.fromJson(
        serializer.fromJson<String>(json['platform']),
      ),
      targetPercentageBp: serializer.fromJson<int>(json['targetPercentageBp']),
      targetAmount: serializer.fromJson<int>(json['targetAmount']),
      roundedAmount: serializer.fromJson<int>(json['roundedAmount']),
      plannedTransferDate: serializer.fromJson<DateTime?>(
        json['plannedTransferDate'],
      ),
      status: $InvestmentPlatformAllocationsTable.$converterstatus.fromJson(
        serializer.fromJson<String>(json['status']),
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'revisionId': serializer.toJson<int>(revisionId),
      'platform': serializer.toJson<String>(
        $InvestmentPlatformAllocationsTable.$converterplatform.toJson(platform),
      ),
      'targetPercentageBp': serializer.toJson<int>(targetPercentageBp),
      'targetAmount': serializer.toJson<int>(targetAmount),
      'roundedAmount': serializer.toJson<int>(roundedAmount),
      'plannedTransferDate': serializer.toJson<DateTime?>(plannedTransferDate),
      'status': serializer.toJson<String>(
        $InvestmentPlatformAllocationsTable.$converterstatus.toJson(status),
      ),
    };
  }

  InvestmentPlatformAllocation copyWith({
    int? id,
    int? revisionId,
    InvestmentPlatform? platform,
    int? targetPercentageBp,
    int? targetAmount,
    int? roundedAmount,
    Value<DateTime?> plannedTransferDate = const Value.absent(),
    PlanActualStatus? status,
  }) => InvestmentPlatformAllocation(
    id: id ?? this.id,
    revisionId: revisionId ?? this.revisionId,
    platform: platform ?? this.platform,
    targetPercentageBp: targetPercentageBp ?? this.targetPercentageBp,
    targetAmount: targetAmount ?? this.targetAmount,
    roundedAmount: roundedAmount ?? this.roundedAmount,
    plannedTransferDate: plannedTransferDate.present
        ? plannedTransferDate.value
        : this.plannedTransferDate,
    status: status ?? this.status,
  );
  InvestmentPlatformAllocation copyWithCompanion(
    InvestmentPlatformAllocationsCompanion data,
  ) {
    return InvestmentPlatformAllocation(
      id: data.id.present ? data.id.value : this.id,
      revisionId: data.revisionId.present
          ? data.revisionId.value
          : this.revisionId,
      platform: data.platform.present ? data.platform.value : this.platform,
      targetPercentageBp: data.targetPercentageBp.present
          ? data.targetPercentageBp.value
          : this.targetPercentageBp,
      targetAmount: data.targetAmount.present
          ? data.targetAmount.value
          : this.targetAmount,
      roundedAmount: data.roundedAmount.present
          ? data.roundedAmount.value
          : this.roundedAmount,
      plannedTransferDate: data.plannedTransferDate.present
          ? data.plannedTransferDate.value
          : this.plannedTransferDate,
      status: data.status.present ? data.status.value : this.status,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InvestmentPlatformAllocation(')
          ..write('id: $id, ')
          ..write('revisionId: $revisionId, ')
          ..write('platform: $platform, ')
          ..write('targetPercentageBp: $targetPercentageBp, ')
          ..write('targetAmount: $targetAmount, ')
          ..write('roundedAmount: $roundedAmount, ')
          ..write('plannedTransferDate: $plannedTransferDate, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    revisionId,
    platform,
    targetPercentageBp,
    targetAmount,
    roundedAmount,
    plannedTransferDate,
    status,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InvestmentPlatformAllocation &&
          other.id == this.id &&
          other.revisionId == this.revisionId &&
          other.platform == this.platform &&
          other.targetPercentageBp == this.targetPercentageBp &&
          other.targetAmount == this.targetAmount &&
          other.roundedAmount == this.roundedAmount &&
          other.plannedTransferDate == this.plannedTransferDate &&
          other.status == this.status);
}

class InvestmentPlatformAllocationsCompanion
    extends UpdateCompanion<InvestmentPlatformAllocation> {
  final Value<int> id;
  final Value<int> revisionId;
  final Value<InvestmentPlatform> platform;
  final Value<int> targetPercentageBp;
  final Value<int> targetAmount;
  final Value<int> roundedAmount;
  final Value<DateTime?> plannedTransferDate;
  final Value<PlanActualStatus> status;
  const InvestmentPlatformAllocationsCompanion({
    this.id = const Value.absent(),
    this.revisionId = const Value.absent(),
    this.platform = const Value.absent(),
    this.targetPercentageBp = const Value.absent(),
    this.targetAmount = const Value.absent(),
    this.roundedAmount = const Value.absent(),
    this.plannedTransferDate = const Value.absent(),
    this.status = const Value.absent(),
  });
  InvestmentPlatformAllocationsCompanion.insert({
    this.id = const Value.absent(),
    required int revisionId,
    required InvestmentPlatform platform,
    required int targetPercentageBp,
    required int targetAmount,
    required int roundedAmount,
    this.plannedTransferDate = const Value.absent(),
    required PlanActualStatus status,
  }) : revisionId = Value(revisionId),
       platform = Value(platform),
       targetPercentageBp = Value(targetPercentageBp),
       targetAmount = Value(targetAmount),
       roundedAmount = Value(roundedAmount),
       status = Value(status);
  static Insertable<InvestmentPlatformAllocation> custom({
    Expression<int>? id,
    Expression<int>? revisionId,
    Expression<String>? platform,
    Expression<int>? targetPercentageBp,
    Expression<int>? targetAmount,
    Expression<int>? roundedAmount,
    Expression<DateTime>? plannedTransferDate,
    Expression<String>? status,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (revisionId != null) 'revision_id': revisionId,
      if (platform != null) 'platform': platform,
      if (targetPercentageBp != null)
        'target_percentage_bp': targetPercentageBp,
      if (targetAmount != null) 'target_amount': targetAmount,
      if (roundedAmount != null) 'rounded_amount': roundedAmount,
      if (plannedTransferDate != null)
        'planned_transfer_date': plannedTransferDate,
      if (status != null) 'status': status,
    });
  }

  InvestmentPlatformAllocationsCompanion copyWith({
    Value<int>? id,
    Value<int>? revisionId,
    Value<InvestmentPlatform>? platform,
    Value<int>? targetPercentageBp,
    Value<int>? targetAmount,
    Value<int>? roundedAmount,
    Value<DateTime?>? plannedTransferDate,
    Value<PlanActualStatus>? status,
  }) {
    return InvestmentPlatformAllocationsCompanion(
      id: id ?? this.id,
      revisionId: revisionId ?? this.revisionId,
      platform: platform ?? this.platform,
      targetPercentageBp: targetPercentageBp ?? this.targetPercentageBp,
      targetAmount: targetAmount ?? this.targetAmount,
      roundedAmount: roundedAmount ?? this.roundedAmount,
      plannedTransferDate: plannedTransferDate ?? this.plannedTransferDate,
      status: status ?? this.status,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (revisionId.present) {
      map['revision_id'] = Variable<int>(revisionId.value);
    }
    if (platform.present) {
      map['platform'] = Variable<String>(
        $InvestmentPlatformAllocationsTable.$converterplatform.toSql(
          platform.value,
        ),
      );
    }
    if (targetPercentageBp.present) {
      map['target_percentage_bp'] = Variable<int>(targetPercentageBp.value);
    }
    if (targetAmount.present) {
      map['target_amount'] = Variable<int>(targetAmount.value);
    }
    if (roundedAmount.present) {
      map['rounded_amount'] = Variable<int>(roundedAmount.value);
    }
    if (plannedTransferDate.present) {
      map['planned_transfer_date'] = Variable<DateTime>(
        plannedTransferDate.value,
      );
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $InvestmentPlatformAllocationsTable.$converterstatus.toSql(
          status.value,
        ),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InvestmentPlatformAllocationsCompanion(')
          ..write('id: $id, ')
          ..write('revisionId: $revisionId, ')
          ..write('platform: $platform, ')
          ..write('targetPercentageBp: $targetPercentageBp, ')
          ..write('targetAmount: $targetAmount, ')
          ..write('roundedAmount: $roundedAmount, ')
          ..write('plannedTransferDate: $plannedTransferDate, ')
          ..write('status: $status')
          ..write(')'))
        .toString();
  }
}

class $ChecklistItemsTable extends ChecklistItems
    with TableInfo<$ChecklistItemsTable, ChecklistItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChecklistItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _revisionIdMeta = const VerificationMeta(
    'revisionId',
  );
  @override
  late final GeneratedColumn<int> revisionId = GeneratedColumn<int>(
    'revision_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES monthly_allocation_revisions (id)',
    ),
  );
  static const VerificationMeta _urutanMeta = const VerificationMeta('urutan');
  @override
  late final GeneratedColumn<int> urutan = GeneratedColumn<int>(
    'urutan',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _kodeMeta = const VerificationMeta('kode');
  @override
  late final GeneratedColumn<String> kode = GeneratedColumn<String>(
    'kode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nominalMeta = const VerificationMeta(
    'nominal',
  );
  @override
  late final GeneratedColumn<int> nominal = GeneratedColumn<int>(
    'nominal',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _detailMeta = const VerificationMeta('detail');
  @override
  late final GeneratedColumn<String> detail = GeneratedColumn<String>(
    'detail',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _selesaiMeta = const VerificationMeta(
    'selesai',
  );
  @override
  late final GeneratedColumn<bool> selesai = GeneratedColumn<bool>(
    'selesai',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("selesai" IN (0, 1))',
    ),
  );
  static const VerificationMeta _diperbaruiPadaMeta = const VerificationMeta(
    'diperbaruiPada',
  );
  @override
  late final GeneratedColumn<DateTime> diperbaruiPada =
      GeneratedColumn<DateTime>(
        'diperbarui_pada',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    revisionId,
    urutan,
    kode,
    nominal,
    detail,
    selesai,
    diperbaruiPada,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'checklist_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<ChecklistItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('revision_id')) {
      context.handle(
        _revisionIdMeta,
        revisionId.isAcceptableOrUnknown(data['revision_id']!, _revisionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_revisionIdMeta);
    }
    if (data.containsKey('urutan')) {
      context.handle(
        _urutanMeta,
        urutan.isAcceptableOrUnknown(data['urutan']!, _urutanMeta),
      );
    } else if (isInserting) {
      context.missing(_urutanMeta);
    }
    if (data.containsKey('kode')) {
      context.handle(
        _kodeMeta,
        kode.isAcceptableOrUnknown(data['kode']!, _kodeMeta),
      );
    } else if (isInserting) {
      context.missing(_kodeMeta);
    }
    if (data.containsKey('nominal')) {
      context.handle(
        _nominalMeta,
        nominal.isAcceptableOrUnknown(data['nominal']!, _nominalMeta),
      );
    }
    if (data.containsKey('detail')) {
      context.handle(
        _detailMeta,
        detail.isAcceptableOrUnknown(data['detail']!, _detailMeta),
      );
    }
    if (data.containsKey('selesai')) {
      context.handle(
        _selesaiMeta,
        selesai.isAcceptableOrUnknown(data['selesai']!, _selesaiMeta),
      );
    } else if (isInserting) {
      context.missing(_selesaiMeta);
    }
    if (data.containsKey('diperbarui_pada')) {
      context.handle(
        _diperbaruiPadaMeta,
        diperbaruiPada.isAcceptableOrUnknown(
          data['diperbarui_pada']!,
          _diperbaruiPadaMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_diperbaruiPadaMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChecklistItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChecklistItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      revisionId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}revision_id'],
      )!,
      urutan: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}urutan'],
      )!,
      kode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kode'],
      )!,
      nominal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}nominal'],
      ),
      detail: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}detail'],
      ),
      selesai: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}selesai'],
      )!,
      diperbaruiPada: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}diperbarui_pada'],
      )!,
    );
  }

  @override
  $ChecklistItemsTable createAlias(String alias) {
    return $ChecklistItemsTable(attachedDatabase, alias);
  }
}

class ChecklistItem extends DataClass implements Insertable<ChecklistItem> {
  final int id;
  final int revisionId;
  final int urutan;

  /// Kode template item — dipetakan ke string ARB di presentasi.
  final String kode;
  final int? nominal;
  final String? detail;
  final bool selesai;
  final DateTime diperbaruiPada;
  const ChecklistItem({
    required this.id,
    required this.revisionId,
    required this.urutan,
    required this.kode,
    this.nominal,
    this.detail,
    required this.selesai,
    required this.diperbaruiPada,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['revision_id'] = Variable<int>(revisionId);
    map['urutan'] = Variable<int>(urutan);
    map['kode'] = Variable<String>(kode);
    if (!nullToAbsent || nominal != null) {
      map['nominal'] = Variable<int>(nominal);
    }
    if (!nullToAbsent || detail != null) {
      map['detail'] = Variable<String>(detail);
    }
    map['selesai'] = Variable<bool>(selesai);
    map['diperbarui_pada'] = Variable<DateTime>(diperbaruiPada);
    return map;
  }

  ChecklistItemsCompanion toCompanion(bool nullToAbsent) {
    return ChecklistItemsCompanion(
      id: Value(id),
      revisionId: Value(revisionId),
      urutan: Value(urutan),
      kode: Value(kode),
      nominal: nominal == null && nullToAbsent
          ? const Value.absent()
          : Value(nominal),
      detail: detail == null && nullToAbsent
          ? const Value.absent()
          : Value(detail),
      selesai: Value(selesai),
      diperbaruiPada: Value(diperbaruiPada),
    );
  }

  factory ChecklistItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChecklistItem(
      id: serializer.fromJson<int>(json['id']),
      revisionId: serializer.fromJson<int>(json['revisionId']),
      urutan: serializer.fromJson<int>(json['urutan']),
      kode: serializer.fromJson<String>(json['kode']),
      nominal: serializer.fromJson<int?>(json['nominal']),
      detail: serializer.fromJson<String?>(json['detail']),
      selesai: serializer.fromJson<bool>(json['selesai']),
      diperbaruiPada: serializer.fromJson<DateTime>(json['diperbaruiPada']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'revisionId': serializer.toJson<int>(revisionId),
      'urutan': serializer.toJson<int>(urutan),
      'kode': serializer.toJson<String>(kode),
      'nominal': serializer.toJson<int?>(nominal),
      'detail': serializer.toJson<String?>(detail),
      'selesai': serializer.toJson<bool>(selesai),
      'diperbaruiPada': serializer.toJson<DateTime>(diperbaruiPada),
    };
  }

  ChecklistItem copyWith({
    int? id,
    int? revisionId,
    int? urutan,
    String? kode,
    Value<int?> nominal = const Value.absent(),
    Value<String?> detail = const Value.absent(),
    bool? selesai,
    DateTime? diperbaruiPada,
  }) => ChecklistItem(
    id: id ?? this.id,
    revisionId: revisionId ?? this.revisionId,
    urutan: urutan ?? this.urutan,
    kode: kode ?? this.kode,
    nominal: nominal.present ? nominal.value : this.nominal,
    detail: detail.present ? detail.value : this.detail,
    selesai: selesai ?? this.selesai,
    diperbaruiPada: diperbaruiPada ?? this.diperbaruiPada,
  );
  ChecklistItem copyWithCompanion(ChecklistItemsCompanion data) {
    return ChecklistItem(
      id: data.id.present ? data.id.value : this.id,
      revisionId: data.revisionId.present
          ? data.revisionId.value
          : this.revisionId,
      urutan: data.urutan.present ? data.urutan.value : this.urutan,
      kode: data.kode.present ? data.kode.value : this.kode,
      nominal: data.nominal.present ? data.nominal.value : this.nominal,
      detail: data.detail.present ? data.detail.value : this.detail,
      selesai: data.selesai.present ? data.selesai.value : this.selesai,
      diperbaruiPada: data.diperbaruiPada.present
          ? data.diperbaruiPada.value
          : this.diperbaruiPada,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChecklistItem(')
          ..write('id: $id, ')
          ..write('revisionId: $revisionId, ')
          ..write('urutan: $urutan, ')
          ..write('kode: $kode, ')
          ..write('nominal: $nominal, ')
          ..write('detail: $detail, ')
          ..write('selesai: $selesai, ')
          ..write('diperbaruiPada: $diperbaruiPada')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    revisionId,
    urutan,
    kode,
    nominal,
    detail,
    selesai,
    diperbaruiPada,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChecklistItem &&
          other.id == this.id &&
          other.revisionId == this.revisionId &&
          other.urutan == this.urutan &&
          other.kode == this.kode &&
          other.nominal == this.nominal &&
          other.detail == this.detail &&
          other.selesai == this.selesai &&
          other.diperbaruiPada == this.diperbaruiPada);
}

class ChecklistItemsCompanion extends UpdateCompanion<ChecklistItem> {
  final Value<int> id;
  final Value<int> revisionId;
  final Value<int> urutan;
  final Value<String> kode;
  final Value<int?> nominal;
  final Value<String?> detail;
  final Value<bool> selesai;
  final Value<DateTime> diperbaruiPada;
  const ChecklistItemsCompanion({
    this.id = const Value.absent(),
    this.revisionId = const Value.absent(),
    this.urutan = const Value.absent(),
    this.kode = const Value.absent(),
    this.nominal = const Value.absent(),
    this.detail = const Value.absent(),
    this.selesai = const Value.absent(),
    this.diperbaruiPada = const Value.absent(),
  });
  ChecklistItemsCompanion.insert({
    this.id = const Value.absent(),
    required int revisionId,
    required int urutan,
    required String kode,
    this.nominal = const Value.absent(),
    this.detail = const Value.absent(),
    required bool selesai,
    required DateTime diperbaruiPada,
  }) : revisionId = Value(revisionId),
       urutan = Value(urutan),
       kode = Value(kode),
       selesai = Value(selesai),
       diperbaruiPada = Value(diperbaruiPada);
  static Insertable<ChecklistItem> custom({
    Expression<int>? id,
    Expression<int>? revisionId,
    Expression<int>? urutan,
    Expression<String>? kode,
    Expression<int>? nominal,
    Expression<String>? detail,
    Expression<bool>? selesai,
    Expression<DateTime>? diperbaruiPada,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (revisionId != null) 'revision_id': revisionId,
      if (urutan != null) 'urutan': urutan,
      if (kode != null) 'kode': kode,
      if (nominal != null) 'nominal': nominal,
      if (detail != null) 'detail': detail,
      if (selesai != null) 'selesai': selesai,
      if (diperbaruiPada != null) 'diperbarui_pada': diperbaruiPada,
    });
  }

  ChecklistItemsCompanion copyWith({
    Value<int>? id,
    Value<int>? revisionId,
    Value<int>? urutan,
    Value<String>? kode,
    Value<int?>? nominal,
    Value<String?>? detail,
    Value<bool>? selesai,
    Value<DateTime>? diperbaruiPada,
  }) {
    return ChecklistItemsCompanion(
      id: id ?? this.id,
      revisionId: revisionId ?? this.revisionId,
      urutan: urutan ?? this.urutan,
      kode: kode ?? this.kode,
      nominal: nominal ?? this.nominal,
      detail: detail ?? this.detail,
      selesai: selesai ?? this.selesai,
      diperbaruiPada: diperbaruiPada ?? this.diperbaruiPada,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (revisionId.present) {
      map['revision_id'] = Variable<int>(revisionId.value);
    }
    if (urutan.present) {
      map['urutan'] = Variable<int>(urutan.value);
    }
    if (kode.present) {
      map['kode'] = Variable<String>(kode.value);
    }
    if (nominal.present) {
      map['nominal'] = Variable<int>(nominal.value);
    }
    if (detail.present) {
      map['detail'] = Variable<String>(detail.value);
    }
    if (selesai.present) {
      map['selesai'] = Variable<bool>(selesai.value);
    }
    if (diperbaruiPada.present) {
      map['diperbarui_pada'] = Variable<DateTime>(diperbaruiPada.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChecklistItemsCompanion(')
          ..write('id: $id, ')
          ..write('revisionId: $revisionId, ')
          ..write('urutan: $urutan, ')
          ..write('kode: $kode, ')
          ..write('nominal: $nominal, ')
          ..write('detail: $detail, ')
          ..write('selesai: $selesai, ')
          ..write('diperbaruiPada: $diperbaruiPada')
          ..write(')'))
        .toString();
  }
}

class $RemindersTable extends Reminders
    with TableInfo<$RemindersTable, Reminder> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RemindersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<ReminderKind, String> jenis =
      GeneratedColumn<String>(
        'jenis',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<ReminderKind>($RemindersTable.$converterjenis);
  static const VerificationMeta _judulMeta = const VerificationMeta('judul');
  @override
  late final GeneratedColumn<String> judul = GeneratedColumn<String>(
    'judul',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _waktuMeta = const VerificationMeta('waktu');
  @override
  late final GeneratedColumn<DateTime> waktu = GeneratedColumn<DateTime>(
    'waktu',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _berulangBulananMeta = const VerificationMeta(
    'berulangBulanan',
  );
  @override
  late final GeneratedColumn<bool> berulangBulanan = GeneratedColumn<bool>(
    'berulang_bulanan',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("berulang_bulanan" IN (0, 1))',
    ),
  );
  static const VerificationMeta _aktifMeta = const VerificationMeta('aktif');
  @override
  late final GeneratedColumn<bool> aktif = GeneratedColumn<bool>(
    'aktif',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("aktif" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    jenis,
    judul,
    waktu,
    berulangBulanan,
    aktif,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reminders';
  @override
  VerificationContext validateIntegrity(
    Insertable<Reminder> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('judul')) {
      context.handle(
        _judulMeta,
        judul.isAcceptableOrUnknown(data['judul']!, _judulMeta),
      );
    } else if (isInserting) {
      context.missing(_judulMeta);
    }
    if (data.containsKey('waktu')) {
      context.handle(
        _waktuMeta,
        waktu.isAcceptableOrUnknown(data['waktu']!, _waktuMeta),
      );
    } else if (isInserting) {
      context.missing(_waktuMeta);
    }
    if (data.containsKey('berulang_bulanan')) {
      context.handle(
        _berulangBulananMeta,
        berulangBulanan.isAcceptableOrUnknown(
          data['berulang_bulanan']!,
          _berulangBulananMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_berulangBulananMeta);
    }
    if (data.containsKey('aktif')) {
      context.handle(
        _aktifMeta,
        aktif.isAcceptableOrUnknown(data['aktif']!, _aktifMeta),
      );
    } else if (isInserting) {
      context.missing(_aktifMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Reminder map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Reminder(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      jenis: $RemindersTable.$converterjenis.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}jenis'],
        )!,
      ),
      judul: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}judul'],
      )!,
      waktu: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}waktu'],
      )!,
      berulangBulanan: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}berulang_bulanan'],
      )!,
      aktif: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}aktif'],
      )!,
    );
  }

  @override
  $RemindersTable createAlias(String alias) {
    return $RemindersTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ReminderKind, String, String> $converterjenis =
      const EnumNameConverter<ReminderKind>(ReminderKind.values);
}

class Reminder extends DataClass implements Insertable<Reminder> {
  final int id;
  final ReminderKind jenis;
  final String judul;
  final DateTime waktu;
  final bool berulangBulanan;
  final bool aktif;
  const Reminder({
    required this.id,
    required this.jenis,
    required this.judul,
    required this.waktu,
    required this.berulangBulanan,
    required this.aktif,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['jenis'] = Variable<String>(
        $RemindersTable.$converterjenis.toSql(jenis),
      );
    }
    map['judul'] = Variable<String>(judul);
    map['waktu'] = Variable<DateTime>(waktu);
    map['berulang_bulanan'] = Variable<bool>(berulangBulanan);
    map['aktif'] = Variable<bool>(aktif);
    return map;
  }

  RemindersCompanion toCompanion(bool nullToAbsent) {
    return RemindersCompanion(
      id: Value(id),
      jenis: Value(jenis),
      judul: Value(judul),
      waktu: Value(waktu),
      berulangBulanan: Value(berulangBulanan),
      aktif: Value(aktif),
    );
  }

  factory Reminder.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Reminder(
      id: serializer.fromJson<int>(json['id']),
      jenis: $RemindersTable.$converterjenis.fromJson(
        serializer.fromJson<String>(json['jenis']),
      ),
      judul: serializer.fromJson<String>(json['judul']),
      waktu: serializer.fromJson<DateTime>(json['waktu']),
      berulangBulanan: serializer.fromJson<bool>(json['berulangBulanan']),
      aktif: serializer.fromJson<bool>(json['aktif']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'jenis': serializer.toJson<String>(
        $RemindersTable.$converterjenis.toJson(jenis),
      ),
      'judul': serializer.toJson<String>(judul),
      'waktu': serializer.toJson<DateTime>(waktu),
      'berulangBulanan': serializer.toJson<bool>(berulangBulanan),
      'aktif': serializer.toJson<bool>(aktif),
    };
  }

  Reminder copyWith({
    int? id,
    ReminderKind? jenis,
    String? judul,
    DateTime? waktu,
    bool? berulangBulanan,
    bool? aktif,
  }) => Reminder(
    id: id ?? this.id,
    jenis: jenis ?? this.jenis,
    judul: judul ?? this.judul,
    waktu: waktu ?? this.waktu,
    berulangBulanan: berulangBulanan ?? this.berulangBulanan,
    aktif: aktif ?? this.aktif,
  );
  Reminder copyWithCompanion(RemindersCompanion data) {
    return Reminder(
      id: data.id.present ? data.id.value : this.id,
      jenis: data.jenis.present ? data.jenis.value : this.jenis,
      judul: data.judul.present ? data.judul.value : this.judul,
      waktu: data.waktu.present ? data.waktu.value : this.waktu,
      berulangBulanan: data.berulangBulanan.present
          ? data.berulangBulanan.value
          : this.berulangBulanan,
      aktif: data.aktif.present ? data.aktif.value : this.aktif,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Reminder(')
          ..write('id: $id, ')
          ..write('jenis: $jenis, ')
          ..write('judul: $judul, ')
          ..write('waktu: $waktu, ')
          ..write('berulangBulanan: $berulangBulanan, ')
          ..write('aktif: $aktif')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, jenis, judul, waktu, berulangBulanan, aktif);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Reminder &&
          other.id == this.id &&
          other.jenis == this.jenis &&
          other.judul == this.judul &&
          other.waktu == this.waktu &&
          other.berulangBulanan == this.berulangBulanan &&
          other.aktif == this.aktif);
}

class RemindersCompanion extends UpdateCompanion<Reminder> {
  final Value<int> id;
  final Value<ReminderKind> jenis;
  final Value<String> judul;
  final Value<DateTime> waktu;
  final Value<bool> berulangBulanan;
  final Value<bool> aktif;
  const RemindersCompanion({
    this.id = const Value.absent(),
    this.jenis = const Value.absent(),
    this.judul = const Value.absent(),
    this.waktu = const Value.absent(),
    this.berulangBulanan = const Value.absent(),
    this.aktif = const Value.absent(),
  });
  RemindersCompanion.insert({
    this.id = const Value.absent(),
    required ReminderKind jenis,
    required String judul,
    required DateTime waktu,
    required bool berulangBulanan,
    required bool aktif,
  }) : jenis = Value(jenis),
       judul = Value(judul),
       waktu = Value(waktu),
       berulangBulanan = Value(berulangBulanan),
       aktif = Value(aktif);
  static Insertable<Reminder> custom({
    Expression<int>? id,
    Expression<String>? jenis,
    Expression<String>? judul,
    Expression<DateTime>? waktu,
    Expression<bool>? berulangBulanan,
    Expression<bool>? aktif,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (jenis != null) 'jenis': jenis,
      if (judul != null) 'judul': judul,
      if (waktu != null) 'waktu': waktu,
      if (berulangBulanan != null) 'berulang_bulanan': berulangBulanan,
      if (aktif != null) 'aktif': aktif,
    });
  }

  RemindersCompanion copyWith({
    Value<int>? id,
    Value<ReminderKind>? jenis,
    Value<String>? judul,
    Value<DateTime>? waktu,
    Value<bool>? berulangBulanan,
    Value<bool>? aktif,
  }) {
    return RemindersCompanion(
      id: id ?? this.id,
      jenis: jenis ?? this.jenis,
      judul: judul ?? this.judul,
      waktu: waktu ?? this.waktu,
      berulangBulanan: berulangBulanan ?? this.berulangBulanan,
      aktif: aktif ?? this.aktif,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (jenis.present) {
      map['jenis'] = Variable<String>(
        $RemindersTable.$converterjenis.toSql(jenis.value),
      );
    }
    if (judul.present) {
      map['judul'] = Variable<String>(judul.value);
    }
    if (waktu.present) {
      map['waktu'] = Variable<DateTime>(waktu.value);
    }
    if (berulangBulanan.present) {
      map['berulang_bulanan'] = Variable<bool>(berulangBulanan.value);
    }
    if (aktif.present) {
      map['aktif'] = Variable<bool>(aktif.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RemindersCompanion(')
          ..write('id: $id, ')
          ..write('jenis: $jenis, ')
          ..write('judul: $judul, ')
          ..write('waktu: $waktu, ')
          ..write('berulangBulanan: $berulangBulanan, ')
          ..write('aktif: $aktif')
          ..write(')'))
        .toString();
  }
}

class $AppSettingsTable extends AppSettings
    with TableInfo<$AppSettingsTable, AppSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _kunciMeta = const VerificationMeta('kunci');
  @override
  late final GeneratedColumn<String> kunci = GeneratedColumn<String>(
    'kunci',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nilaiMeta = const VerificationMeta('nilai');
  @override
  late final GeneratedColumn<String> nilai = GeneratedColumn<String>(
    'nilai',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [kunci, nilai];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('kunci')) {
      context.handle(
        _kunciMeta,
        kunci.isAcceptableOrUnknown(data['kunci']!, _kunciMeta),
      );
    } else if (isInserting) {
      context.missing(_kunciMeta);
    }
    if (data.containsKey('nilai')) {
      context.handle(
        _nilaiMeta,
        nilai.isAcceptableOrUnknown(data['nilai']!, _nilaiMeta),
      );
    } else if (isInserting) {
      context.missing(_nilaiMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {kunci};
  @override
  AppSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSetting(
      kunci: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kunci'],
      )!,
      nilai: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nilai'],
      )!,
    );
  }

  @override
  $AppSettingsTable createAlias(String alias) {
    return $AppSettingsTable(attachedDatabase, alias);
  }
}

class AppSetting extends DataClass implements Insertable<AppSetting> {
  final String kunci;
  final String nilai;
  const AppSetting({required this.kunci, required this.nilai});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['kunci'] = Variable<String>(kunci);
    map['nilai'] = Variable<String>(nilai);
    return map;
  }

  AppSettingsCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsCompanion(kunci: Value(kunci), nilai: Value(nilai));
  }

  factory AppSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSetting(
      kunci: serializer.fromJson<String>(json['kunci']),
      nilai: serializer.fromJson<String>(json['nilai']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'kunci': serializer.toJson<String>(kunci),
      'nilai': serializer.toJson<String>(nilai),
    };
  }

  AppSetting copyWith({String? kunci, String? nilai}) =>
      AppSetting(kunci: kunci ?? this.kunci, nilai: nilai ?? this.nilai);
  AppSetting copyWithCompanion(AppSettingsCompanion data) {
    return AppSetting(
      kunci: data.kunci.present ? data.kunci.value : this.kunci,
      nilai: data.nilai.present ? data.nilai.value : this.nilai,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSetting(')
          ..write('kunci: $kunci, ')
          ..write('nilai: $nilai')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(kunci, nilai);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSetting &&
          other.kunci == this.kunci &&
          other.nilai == this.nilai);
}

class AppSettingsCompanion extends UpdateCompanion<AppSetting> {
  final Value<String> kunci;
  final Value<String> nilai;
  final Value<int> rowid;
  const AppSettingsCompanion({
    this.kunci = const Value.absent(),
    this.nilai = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppSettingsCompanion.insert({
    required String kunci,
    required String nilai,
    this.rowid = const Value.absent(),
  }) : kunci = Value(kunci),
       nilai = Value(nilai);
  static Insertable<AppSetting> custom({
    Expression<String>? kunci,
    Expression<String>? nilai,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (kunci != null) 'kunci': kunci,
      if (nilai != null) 'nilai': nilai,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppSettingsCompanion copyWith({
    Value<String>? kunci,
    Value<String>? nilai,
    Value<int>? rowid,
  }) {
    return AppSettingsCompanion(
      kunci: kunci ?? this.kunci,
      nilai: nilai ?? this.nilai,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (kunci.present) {
      map['kunci'] = Variable<String>(kunci.value);
    }
    if (nilai.present) {
      map['nilai'] = Variable<String>(nilai.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsCompanion(')
          ..write('kunci: $kunci, ')
          ..write('nilai: $nilai, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AiProviderConfigurationsTable extends AiProviderConfigurations
    with TableInfo<$AiProviderConfigurationsTable, AiProviderConfiguration> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AiProviderConfigurationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _namaMeta = const VerificationMeta('nama');
  @override
  late final GeneratedColumn<String> nama = GeneratedColumn<String>(
    'nama',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _baseUrlMeta = const VerificationMeta(
    'baseUrl',
  );
  @override
  late final GeneratedColumn<String> baseUrl = GeneratedColumn<String>(
    'base_url',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _chatPathMeta = const VerificationMeta(
    'chatPath',
  );
  @override
  late final GeneratedColumn<String> chatPath = GeneratedColumn<String>(
    'chat_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('/chat/completions'),
  );
  static const VerificationMeta _modelsPathMeta = const VerificationMeta(
    'modelsPath',
  );
  @override
  late final GeneratedColumn<String> modelsPath = GeneratedColumn<String>(
    'models_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('/models'),
  );
  static const VerificationMeta _timeoutDetikMeta = const VerificationMeta(
    'timeoutDetik',
  );
  @override
  late final GeneratedColumn<int> timeoutDetik = GeneratedColumn<int>(
    'timeout_detik',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(60),
  );
  static const VerificationMeta _streamingAktifMeta = const VerificationMeta(
    'streamingAktif',
  );
  @override
  late final GeneratedColumn<bool> streamingAktif = GeneratedColumn<bool>(
    'streaming_aktif',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("streaming_aktif" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _modelDefaultMeta = const VerificationMeta(
    'modelDefault',
  );
  @override
  late final GeneratedColumn<String> modelDefault = GeneratedColumn<String>(
    'model_default',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<AIDataScope, String> izinData =
      GeneratedColumn<String>(
        'izin_data',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<AIDataScope>(
        $AiProviderConfigurationsTable.$converterizinData,
      );
  @override
  late final GeneratedColumnWithTypeConverter<AllowedModelsMode, String>
  allowedMode =
      GeneratedColumn<String>(
        'allowed_mode',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('izinkanSemua'),
      ).withConverter<AllowedModelsMode>(
        $AiProviderConfigurationsTable.$converterallowedMode,
      );
  static const VerificationMeta _fallbackModel1Meta = const VerificationMeta(
    'fallbackModel1',
  );
  @override
  late final GeneratedColumn<String> fallbackModel1 = GeneratedColumn<String>(
    'fallback_model1',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fallbackModel2Meta = const VerificationMeta(
    'fallbackModel2',
  );
  @override
  late final GeneratedColumn<String> fallbackModel2 = GeneratedColumn<String>(
    'fallback_model2',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dibuatPadaMeta = const VerificationMeta(
    'dibuatPada',
  );
  @override
  late final GeneratedColumn<DateTime> dibuatPada = GeneratedColumn<DateTime>(
    'dibuat_pada',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nama,
    baseUrl,
    chatPath,
    modelsPath,
    timeoutDetik,
    streamingAktif,
    modelDefault,
    izinData,
    allowedMode,
    fallbackModel1,
    fallbackModel2,
    dibuatPada,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ai_provider_configurations';
  @override
  VerificationContext validateIntegrity(
    Insertable<AiProviderConfiguration> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nama')) {
      context.handle(
        _namaMeta,
        nama.isAcceptableOrUnknown(data['nama']!, _namaMeta),
      );
    } else if (isInserting) {
      context.missing(_namaMeta);
    }
    if (data.containsKey('base_url')) {
      context.handle(
        _baseUrlMeta,
        baseUrl.isAcceptableOrUnknown(data['base_url']!, _baseUrlMeta),
      );
    } else if (isInserting) {
      context.missing(_baseUrlMeta);
    }
    if (data.containsKey('chat_path')) {
      context.handle(
        _chatPathMeta,
        chatPath.isAcceptableOrUnknown(data['chat_path']!, _chatPathMeta),
      );
    }
    if (data.containsKey('models_path')) {
      context.handle(
        _modelsPathMeta,
        modelsPath.isAcceptableOrUnknown(data['models_path']!, _modelsPathMeta),
      );
    }
    if (data.containsKey('timeout_detik')) {
      context.handle(
        _timeoutDetikMeta,
        timeoutDetik.isAcceptableOrUnknown(
          data['timeout_detik']!,
          _timeoutDetikMeta,
        ),
      );
    }
    if (data.containsKey('streaming_aktif')) {
      context.handle(
        _streamingAktifMeta,
        streamingAktif.isAcceptableOrUnknown(
          data['streaming_aktif']!,
          _streamingAktifMeta,
        ),
      );
    }
    if (data.containsKey('model_default')) {
      context.handle(
        _modelDefaultMeta,
        modelDefault.isAcceptableOrUnknown(
          data['model_default']!,
          _modelDefaultMeta,
        ),
      );
    }
    if (data.containsKey('fallback_model1')) {
      context.handle(
        _fallbackModel1Meta,
        fallbackModel1.isAcceptableOrUnknown(
          data['fallback_model1']!,
          _fallbackModel1Meta,
        ),
      );
    }
    if (data.containsKey('fallback_model2')) {
      context.handle(
        _fallbackModel2Meta,
        fallbackModel2.isAcceptableOrUnknown(
          data['fallback_model2']!,
          _fallbackModel2Meta,
        ),
      );
    }
    if (data.containsKey('dibuat_pada')) {
      context.handle(
        _dibuatPadaMeta,
        dibuatPada.isAcceptableOrUnknown(data['dibuat_pada']!, _dibuatPadaMeta),
      );
    } else if (isInserting) {
      context.missing(_dibuatPadaMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AiProviderConfiguration map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AiProviderConfiguration(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nama: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nama'],
      )!,
      baseUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}base_url'],
      )!,
      chatPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}chat_path'],
      )!,
      modelsPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}models_path'],
      )!,
      timeoutDetik: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}timeout_detik'],
      )!,
      streamingAktif: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}streaming_aktif'],
      )!,
      modelDefault: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}model_default'],
      ),
      izinData: $AiProviderConfigurationsTable.$converterizinData.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}izin_data'],
        )!,
      ),
      allowedMode: $AiProviderConfigurationsTable.$converterallowedMode.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}allowed_mode'],
        )!,
      ),
      fallbackModel1: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}fallback_model1'],
      ),
      fallbackModel2: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}fallback_model2'],
      ),
      dibuatPada: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}dibuat_pada'],
      )!,
    );
  }

  @override
  $AiProviderConfigurationsTable createAlias(String alias) {
    return $AiProviderConfigurationsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<AIDataScope, String, String> $converterizinData =
      const EnumNameConverter<AIDataScope>(AIDataScope.values);
  static JsonTypeConverter2<AllowedModelsMode, String, String>
  $converterallowedMode = const EnumNameConverter<AllowedModelsMode>(
    AllowedModelsMode.values,
  );
}

class AiProviderConfiguration extends DataClass
    implements Insertable<AiProviderConfiguration> {
  final int id;
  final String nama;
  final String baseUrl;
  final String chatPath;
  final String modelsPath;
  final int timeoutDetik;
  final bool streamingAktif;
  final String? modelDefault;
  final AIDataScope izinData;
  final AllowedModelsMode allowedMode;
  final String? fallbackModel1;
  final String? fallbackModel2;
  final DateTime dibuatPada;
  const AiProviderConfiguration({
    required this.id,
    required this.nama,
    required this.baseUrl,
    required this.chatPath,
    required this.modelsPath,
    required this.timeoutDetik,
    required this.streamingAktif,
    this.modelDefault,
    required this.izinData,
    required this.allowedMode,
    this.fallbackModel1,
    this.fallbackModel2,
    required this.dibuatPada,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nama'] = Variable<String>(nama);
    map['base_url'] = Variable<String>(baseUrl);
    map['chat_path'] = Variable<String>(chatPath);
    map['models_path'] = Variable<String>(modelsPath);
    map['timeout_detik'] = Variable<int>(timeoutDetik);
    map['streaming_aktif'] = Variable<bool>(streamingAktif);
    if (!nullToAbsent || modelDefault != null) {
      map['model_default'] = Variable<String>(modelDefault);
    }
    {
      map['izin_data'] = Variable<String>(
        $AiProviderConfigurationsTable.$converterizinData.toSql(izinData),
      );
    }
    {
      map['allowed_mode'] = Variable<String>(
        $AiProviderConfigurationsTable.$converterallowedMode.toSql(allowedMode),
      );
    }
    if (!nullToAbsent || fallbackModel1 != null) {
      map['fallback_model1'] = Variable<String>(fallbackModel1);
    }
    if (!nullToAbsent || fallbackModel2 != null) {
      map['fallback_model2'] = Variable<String>(fallbackModel2);
    }
    map['dibuat_pada'] = Variable<DateTime>(dibuatPada);
    return map;
  }

  AiProviderConfigurationsCompanion toCompanion(bool nullToAbsent) {
    return AiProviderConfigurationsCompanion(
      id: Value(id),
      nama: Value(nama),
      baseUrl: Value(baseUrl),
      chatPath: Value(chatPath),
      modelsPath: Value(modelsPath),
      timeoutDetik: Value(timeoutDetik),
      streamingAktif: Value(streamingAktif),
      modelDefault: modelDefault == null && nullToAbsent
          ? const Value.absent()
          : Value(modelDefault),
      izinData: Value(izinData),
      allowedMode: Value(allowedMode),
      fallbackModel1: fallbackModel1 == null && nullToAbsent
          ? const Value.absent()
          : Value(fallbackModel1),
      fallbackModel2: fallbackModel2 == null && nullToAbsent
          ? const Value.absent()
          : Value(fallbackModel2),
      dibuatPada: Value(dibuatPada),
    );
  }

  factory AiProviderConfiguration.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AiProviderConfiguration(
      id: serializer.fromJson<int>(json['id']),
      nama: serializer.fromJson<String>(json['nama']),
      baseUrl: serializer.fromJson<String>(json['baseUrl']),
      chatPath: serializer.fromJson<String>(json['chatPath']),
      modelsPath: serializer.fromJson<String>(json['modelsPath']),
      timeoutDetik: serializer.fromJson<int>(json['timeoutDetik']),
      streamingAktif: serializer.fromJson<bool>(json['streamingAktif']),
      modelDefault: serializer.fromJson<String?>(json['modelDefault']),
      izinData: $AiProviderConfigurationsTable.$converterizinData.fromJson(
        serializer.fromJson<String>(json['izinData']),
      ),
      allowedMode: $AiProviderConfigurationsTable.$converterallowedMode
          .fromJson(serializer.fromJson<String>(json['allowedMode'])),
      fallbackModel1: serializer.fromJson<String?>(json['fallbackModel1']),
      fallbackModel2: serializer.fromJson<String?>(json['fallbackModel2']),
      dibuatPada: serializer.fromJson<DateTime>(json['dibuatPada']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nama': serializer.toJson<String>(nama),
      'baseUrl': serializer.toJson<String>(baseUrl),
      'chatPath': serializer.toJson<String>(chatPath),
      'modelsPath': serializer.toJson<String>(modelsPath),
      'timeoutDetik': serializer.toJson<int>(timeoutDetik),
      'streamingAktif': serializer.toJson<bool>(streamingAktif),
      'modelDefault': serializer.toJson<String?>(modelDefault),
      'izinData': serializer.toJson<String>(
        $AiProviderConfigurationsTable.$converterizinData.toJson(izinData),
      ),
      'allowedMode': serializer.toJson<String>(
        $AiProviderConfigurationsTable.$converterallowedMode.toJson(
          allowedMode,
        ),
      ),
      'fallbackModel1': serializer.toJson<String?>(fallbackModel1),
      'fallbackModel2': serializer.toJson<String?>(fallbackModel2),
      'dibuatPada': serializer.toJson<DateTime>(dibuatPada),
    };
  }

  AiProviderConfiguration copyWith({
    int? id,
    String? nama,
    String? baseUrl,
    String? chatPath,
    String? modelsPath,
    int? timeoutDetik,
    bool? streamingAktif,
    Value<String?> modelDefault = const Value.absent(),
    AIDataScope? izinData,
    AllowedModelsMode? allowedMode,
    Value<String?> fallbackModel1 = const Value.absent(),
    Value<String?> fallbackModel2 = const Value.absent(),
    DateTime? dibuatPada,
  }) => AiProviderConfiguration(
    id: id ?? this.id,
    nama: nama ?? this.nama,
    baseUrl: baseUrl ?? this.baseUrl,
    chatPath: chatPath ?? this.chatPath,
    modelsPath: modelsPath ?? this.modelsPath,
    timeoutDetik: timeoutDetik ?? this.timeoutDetik,
    streamingAktif: streamingAktif ?? this.streamingAktif,
    modelDefault: modelDefault.present ? modelDefault.value : this.modelDefault,
    izinData: izinData ?? this.izinData,
    allowedMode: allowedMode ?? this.allowedMode,
    fallbackModel1: fallbackModel1.present
        ? fallbackModel1.value
        : this.fallbackModel1,
    fallbackModel2: fallbackModel2.present
        ? fallbackModel2.value
        : this.fallbackModel2,
    dibuatPada: dibuatPada ?? this.dibuatPada,
  );
  AiProviderConfiguration copyWithCompanion(
    AiProviderConfigurationsCompanion data,
  ) {
    return AiProviderConfiguration(
      id: data.id.present ? data.id.value : this.id,
      nama: data.nama.present ? data.nama.value : this.nama,
      baseUrl: data.baseUrl.present ? data.baseUrl.value : this.baseUrl,
      chatPath: data.chatPath.present ? data.chatPath.value : this.chatPath,
      modelsPath: data.modelsPath.present
          ? data.modelsPath.value
          : this.modelsPath,
      timeoutDetik: data.timeoutDetik.present
          ? data.timeoutDetik.value
          : this.timeoutDetik,
      streamingAktif: data.streamingAktif.present
          ? data.streamingAktif.value
          : this.streamingAktif,
      modelDefault: data.modelDefault.present
          ? data.modelDefault.value
          : this.modelDefault,
      izinData: data.izinData.present ? data.izinData.value : this.izinData,
      allowedMode: data.allowedMode.present
          ? data.allowedMode.value
          : this.allowedMode,
      fallbackModel1: data.fallbackModel1.present
          ? data.fallbackModel1.value
          : this.fallbackModel1,
      fallbackModel2: data.fallbackModel2.present
          ? data.fallbackModel2.value
          : this.fallbackModel2,
      dibuatPada: data.dibuatPada.present
          ? data.dibuatPada.value
          : this.dibuatPada,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AiProviderConfiguration(')
          ..write('id: $id, ')
          ..write('nama: $nama, ')
          ..write('baseUrl: $baseUrl, ')
          ..write('chatPath: $chatPath, ')
          ..write('modelsPath: $modelsPath, ')
          ..write('timeoutDetik: $timeoutDetik, ')
          ..write('streamingAktif: $streamingAktif, ')
          ..write('modelDefault: $modelDefault, ')
          ..write('izinData: $izinData, ')
          ..write('allowedMode: $allowedMode, ')
          ..write('fallbackModel1: $fallbackModel1, ')
          ..write('fallbackModel2: $fallbackModel2, ')
          ..write('dibuatPada: $dibuatPada')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    nama,
    baseUrl,
    chatPath,
    modelsPath,
    timeoutDetik,
    streamingAktif,
    modelDefault,
    izinData,
    allowedMode,
    fallbackModel1,
    fallbackModel2,
    dibuatPada,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AiProviderConfiguration &&
          other.id == this.id &&
          other.nama == this.nama &&
          other.baseUrl == this.baseUrl &&
          other.chatPath == this.chatPath &&
          other.modelsPath == this.modelsPath &&
          other.timeoutDetik == this.timeoutDetik &&
          other.streamingAktif == this.streamingAktif &&
          other.modelDefault == this.modelDefault &&
          other.izinData == this.izinData &&
          other.allowedMode == this.allowedMode &&
          other.fallbackModel1 == this.fallbackModel1 &&
          other.fallbackModel2 == this.fallbackModel2 &&
          other.dibuatPada == this.dibuatPada);
}

class AiProviderConfigurationsCompanion
    extends UpdateCompanion<AiProviderConfiguration> {
  final Value<int> id;
  final Value<String> nama;
  final Value<String> baseUrl;
  final Value<String> chatPath;
  final Value<String> modelsPath;
  final Value<int> timeoutDetik;
  final Value<bool> streamingAktif;
  final Value<String?> modelDefault;
  final Value<AIDataScope> izinData;
  final Value<AllowedModelsMode> allowedMode;
  final Value<String?> fallbackModel1;
  final Value<String?> fallbackModel2;
  final Value<DateTime> dibuatPada;
  const AiProviderConfigurationsCompanion({
    this.id = const Value.absent(),
    this.nama = const Value.absent(),
    this.baseUrl = const Value.absent(),
    this.chatPath = const Value.absent(),
    this.modelsPath = const Value.absent(),
    this.timeoutDetik = const Value.absent(),
    this.streamingAktif = const Value.absent(),
    this.modelDefault = const Value.absent(),
    this.izinData = const Value.absent(),
    this.allowedMode = const Value.absent(),
    this.fallbackModel1 = const Value.absent(),
    this.fallbackModel2 = const Value.absent(),
    this.dibuatPada = const Value.absent(),
  });
  AiProviderConfigurationsCompanion.insert({
    this.id = const Value.absent(),
    required String nama,
    required String baseUrl,
    this.chatPath = const Value.absent(),
    this.modelsPath = const Value.absent(),
    this.timeoutDetik = const Value.absent(),
    this.streamingAktif = const Value.absent(),
    this.modelDefault = const Value.absent(),
    required AIDataScope izinData,
    this.allowedMode = const Value.absent(),
    this.fallbackModel1 = const Value.absent(),
    this.fallbackModel2 = const Value.absent(),
    required DateTime dibuatPada,
  }) : nama = Value(nama),
       baseUrl = Value(baseUrl),
       izinData = Value(izinData),
       dibuatPada = Value(dibuatPada);
  static Insertable<AiProviderConfiguration> custom({
    Expression<int>? id,
    Expression<String>? nama,
    Expression<String>? baseUrl,
    Expression<String>? chatPath,
    Expression<String>? modelsPath,
    Expression<int>? timeoutDetik,
    Expression<bool>? streamingAktif,
    Expression<String>? modelDefault,
    Expression<String>? izinData,
    Expression<String>? allowedMode,
    Expression<String>? fallbackModel1,
    Expression<String>? fallbackModel2,
    Expression<DateTime>? dibuatPada,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nama != null) 'nama': nama,
      if (baseUrl != null) 'base_url': baseUrl,
      if (chatPath != null) 'chat_path': chatPath,
      if (modelsPath != null) 'models_path': modelsPath,
      if (timeoutDetik != null) 'timeout_detik': timeoutDetik,
      if (streamingAktif != null) 'streaming_aktif': streamingAktif,
      if (modelDefault != null) 'model_default': modelDefault,
      if (izinData != null) 'izin_data': izinData,
      if (allowedMode != null) 'allowed_mode': allowedMode,
      if (fallbackModel1 != null) 'fallback_model1': fallbackModel1,
      if (fallbackModel2 != null) 'fallback_model2': fallbackModel2,
      if (dibuatPada != null) 'dibuat_pada': dibuatPada,
    });
  }

  AiProviderConfigurationsCompanion copyWith({
    Value<int>? id,
    Value<String>? nama,
    Value<String>? baseUrl,
    Value<String>? chatPath,
    Value<String>? modelsPath,
    Value<int>? timeoutDetik,
    Value<bool>? streamingAktif,
    Value<String?>? modelDefault,
    Value<AIDataScope>? izinData,
    Value<AllowedModelsMode>? allowedMode,
    Value<String?>? fallbackModel1,
    Value<String?>? fallbackModel2,
    Value<DateTime>? dibuatPada,
  }) {
    return AiProviderConfigurationsCompanion(
      id: id ?? this.id,
      nama: nama ?? this.nama,
      baseUrl: baseUrl ?? this.baseUrl,
      chatPath: chatPath ?? this.chatPath,
      modelsPath: modelsPath ?? this.modelsPath,
      timeoutDetik: timeoutDetik ?? this.timeoutDetik,
      streamingAktif: streamingAktif ?? this.streamingAktif,
      modelDefault: modelDefault ?? this.modelDefault,
      izinData: izinData ?? this.izinData,
      allowedMode: allowedMode ?? this.allowedMode,
      fallbackModel1: fallbackModel1 ?? this.fallbackModel1,
      fallbackModel2: fallbackModel2 ?? this.fallbackModel2,
      dibuatPada: dibuatPada ?? this.dibuatPada,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nama.present) {
      map['nama'] = Variable<String>(nama.value);
    }
    if (baseUrl.present) {
      map['base_url'] = Variable<String>(baseUrl.value);
    }
    if (chatPath.present) {
      map['chat_path'] = Variable<String>(chatPath.value);
    }
    if (modelsPath.present) {
      map['models_path'] = Variable<String>(modelsPath.value);
    }
    if (timeoutDetik.present) {
      map['timeout_detik'] = Variable<int>(timeoutDetik.value);
    }
    if (streamingAktif.present) {
      map['streaming_aktif'] = Variable<bool>(streamingAktif.value);
    }
    if (modelDefault.present) {
      map['model_default'] = Variable<String>(modelDefault.value);
    }
    if (izinData.present) {
      map['izin_data'] = Variable<String>(
        $AiProviderConfigurationsTable.$converterizinData.toSql(izinData.value),
      );
    }
    if (allowedMode.present) {
      map['allowed_mode'] = Variable<String>(
        $AiProviderConfigurationsTable.$converterallowedMode.toSql(
          allowedMode.value,
        ),
      );
    }
    if (fallbackModel1.present) {
      map['fallback_model1'] = Variable<String>(fallbackModel1.value);
    }
    if (fallbackModel2.present) {
      map['fallback_model2'] = Variable<String>(fallbackModel2.value);
    }
    if (dibuatPada.present) {
      map['dibuat_pada'] = Variable<DateTime>(dibuatPada.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AiProviderConfigurationsCompanion(')
          ..write('id: $id, ')
          ..write('nama: $nama, ')
          ..write('baseUrl: $baseUrl, ')
          ..write('chatPath: $chatPath, ')
          ..write('modelsPath: $modelsPath, ')
          ..write('timeoutDetik: $timeoutDetik, ')
          ..write('streamingAktif: $streamingAktif, ')
          ..write('modelDefault: $modelDefault, ')
          ..write('izinData: $izinData, ')
          ..write('allowedMode: $allowedMode, ')
          ..write('fallbackModel1: $fallbackModel1, ')
          ..write('fallbackModel2: $fallbackModel2, ')
          ..write('dibuatPada: $dibuatPada')
          ..write(')'))
        .toString();
  }
}

class $AiModelsTable extends AiModels with TableInfo<$AiModelsTable, AiModel> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AiModelsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _providerIdMeta = const VerificationMeta(
    'providerId',
  );
  @override
  late final GeneratedColumn<int> providerId = GeneratedColumn<int>(
    'provider_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES ai_provider_configurations (id)',
    ),
  );
  static const VerificationMeta _modelIdMeta = const VerificationMeta(
    'modelId',
  );
  @override
  late final GeneratedColumn<String> modelId = GeneratedColumn<String>(
    'model_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _displayNameMeta = const VerificationMeta(
    'displayName',
  );
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
    'display_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _favoritMeta = const VerificationMeta(
    'favorit',
  );
  @override
  late final GeneratedColumn<bool> favorit = GeneratedColumn<bool>(
    'favorit',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("favorit" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _manualMeta = const VerificationMeta('manual');
  @override
  late final GeneratedColumn<bool> manual = GeneratedColumn<bool>(
    'manual',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("manual" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _diblokirMeta = const VerificationMeta(
    'diblokir',
  );
  @override
  late final GeneratedColumn<bool> diblokir = GeneratedColumn<bool>(
    'diblokir',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("diblokir" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _diizinkanMeta = const VerificationMeta(
    'diizinkan',
  );
  @override
  late final GeneratedColumn<bool> diizinkan = GeneratedColumn<bool>(
    'diizinkan',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("diizinkan" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  late final GeneratedColumnWithTypeConverter<CapabilityStatus, String>
  statusChat = GeneratedColumn<String>(
    'status_chat',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('unknown'),
  ).withConverter<CapabilityStatus>($AiModelsTable.$converterstatusChat);
  @override
  late final GeneratedColumnWithTypeConverter<CapabilityStatus, String>
  statusStreaming = GeneratedColumn<String>(
    'status_streaming',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('unknown'),
  ).withConverter<CapabilityStatus>($AiModelsTable.$converterstatusStreaming);
  static const VerificationMeta _hargaInputPerJutaMeta = const VerificationMeta(
    'hargaInputPerJuta',
  );
  @override
  late final GeneratedColumn<int> hargaInputPerJuta = GeneratedColumn<int>(
    'harga_input_per_juta',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _hargaOutputPerJutaMeta =
      const VerificationMeta('hargaOutputPerJuta');
  @override
  late final GeneratedColumn<int> hargaOutputPerJuta = GeneratedColumn<int>(
    'harga_output_per_juta',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _terakhirDipakaiMeta = const VerificationMeta(
    'terakhirDipakai',
  );
  @override
  late final GeneratedColumn<DateTime> terakhirDipakai =
      GeneratedColumn<DateTime>(
        'terakhir_dipakai',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    providerId,
    modelId,
    displayName,
    favorit,
    manual,
    diblokir,
    diizinkan,
    statusChat,
    statusStreaming,
    hargaInputPerJuta,
    hargaOutputPerJuta,
    terakhirDipakai,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ai_models';
  @override
  VerificationContext validateIntegrity(
    Insertable<AiModel> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('provider_id')) {
      context.handle(
        _providerIdMeta,
        providerId.isAcceptableOrUnknown(data['provider_id']!, _providerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_providerIdMeta);
    }
    if (data.containsKey('model_id')) {
      context.handle(
        _modelIdMeta,
        modelId.isAcceptableOrUnknown(data['model_id']!, _modelIdMeta),
      );
    } else if (isInserting) {
      context.missing(_modelIdMeta);
    }
    if (data.containsKey('display_name')) {
      context.handle(
        _displayNameMeta,
        displayName.isAcceptableOrUnknown(
          data['display_name']!,
          _displayNameMeta,
        ),
      );
    }
    if (data.containsKey('favorit')) {
      context.handle(
        _favoritMeta,
        favorit.isAcceptableOrUnknown(data['favorit']!, _favoritMeta),
      );
    }
    if (data.containsKey('manual')) {
      context.handle(
        _manualMeta,
        manual.isAcceptableOrUnknown(data['manual']!, _manualMeta),
      );
    }
    if (data.containsKey('diblokir')) {
      context.handle(
        _diblokirMeta,
        diblokir.isAcceptableOrUnknown(data['diblokir']!, _diblokirMeta),
      );
    }
    if (data.containsKey('diizinkan')) {
      context.handle(
        _diizinkanMeta,
        diizinkan.isAcceptableOrUnknown(data['diizinkan']!, _diizinkanMeta),
      );
    }
    if (data.containsKey('harga_input_per_juta')) {
      context.handle(
        _hargaInputPerJutaMeta,
        hargaInputPerJuta.isAcceptableOrUnknown(
          data['harga_input_per_juta']!,
          _hargaInputPerJutaMeta,
        ),
      );
    }
    if (data.containsKey('harga_output_per_juta')) {
      context.handle(
        _hargaOutputPerJutaMeta,
        hargaOutputPerJuta.isAcceptableOrUnknown(
          data['harga_output_per_juta']!,
          _hargaOutputPerJutaMeta,
        ),
      );
    }
    if (data.containsKey('terakhir_dipakai')) {
      context.handle(
        _terakhirDipakaiMeta,
        terakhirDipakai.isAcceptableOrUnknown(
          data['terakhir_dipakai']!,
          _terakhirDipakaiMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {providerId, modelId},
  ];
  @override
  AiModel map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AiModel(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      providerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}provider_id'],
      )!,
      modelId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}model_id'],
      )!,
      displayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name'],
      ),
      favorit: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}favorit'],
      )!,
      manual: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}manual'],
      )!,
      diblokir: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}diblokir'],
      )!,
      diizinkan: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}diizinkan'],
      )!,
      statusChat: $AiModelsTable.$converterstatusChat.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status_chat'],
        )!,
      ),
      statusStreaming: $AiModelsTable.$converterstatusStreaming.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status_streaming'],
        )!,
      ),
      hargaInputPerJuta: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}harga_input_per_juta'],
      ),
      hargaOutputPerJuta: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}harga_output_per_juta'],
      ),
      terakhirDipakai: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}terakhir_dipakai'],
      ),
    );
  }

  @override
  $AiModelsTable createAlias(String alias) {
    return $AiModelsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<CapabilityStatus, String, String>
  $converterstatusChat = const EnumNameConverter<CapabilityStatus>(
    CapabilityStatus.values,
  );
  static JsonTypeConverter2<CapabilityStatus, String, String>
  $converterstatusStreaming = const EnumNameConverter<CapabilityStatus>(
    CapabilityStatus.values,
  );
}

class AiModel extends DataClass implements Insertable<AiModel> {
  final int id;
  final int providerId;
  final String modelId;
  final String? displayName;
  final bool favorit;
  final bool manual;
  final bool diblokir;
  final bool diizinkan;

  /// Status kemampuan (§32): unknown/claimed/verified/unsupported.
  final CapabilityStatus statusChat;
  final CapabilityStatus statusStreaming;

  /// Harga per 1 juta token, diisi pengguna (§39); null = tak tersedia.
  final int? hargaInputPerJuta;
  final int? hargaOutputPerJuta;
  final DateTime? terakhirDipakai;
  const AiModel({
    required this.id,
    required this.providerId,
    required this.modelId,
    this.displayName,
    required this.favorit,
    required this.manual,
    required this.diblokir,
    required this.diizinkan,
    required this.statusChat,
    required this.statusStreaming,
    this.hargaInputPerJuta,
    this.hargaOutputPerJuta,
    this.terakhirDipakai,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['provider_id'] = Variable<int>(providerId);
    map['model_id'] = Variable<String>(modelId);
    if (!nullToAbsent || displayName != null) {
      map['display_name'] = Variable<String>(displayName);
    }
    map['favorit'] = Variable<bool>(favorit);
    map['manual'] = Variable<bool>(manual);
    map['diblokir'] = Variable<bool>(diblokir);
    map['diizinkan'] = Variable<bool>(diizinkan);
    {
      map['status_chat'] = Variable<String>(
        $AiModelsTable.$converterstatusChat.toSql(statusChat),
      );
    }
    {
      map['status_streaming'] = Variable<String>(
        $AiModelsTable.$converterstatusStreaming.toSql(statusStreaming),
      );
    }
    if (!nullToAbsent || hargaInputPerJuta != null) {
      map['harga_input_per_juta'] = Variable<int>(hargaInputPerJuta);
    }
    if (!nullToAbsent || hargaOutputPerJuta != null) {
      map['harga_output_per_juta'] = Variable<int>(hargaOutputPerJuta);
    }
    if (!nullToAbsent || terakhirDipakai != null) {
      map['terakhir_dipakai'] = Variable<DateTime>(terakhirDipakai);
    }
    return map;
  }

  AiModelsCompanion toCompanion(bool nullToAbsent) {
    return AiModelsCompanion(
      id: Value(id),
      providerId: Value(providerId),
      modelId: Value(modelId),
      displayName: displayName == null && nullToAbsent
          ? const Value.absent()
          : Value(displayName),
      favorit: Value(favorit),
      manual: Value(manual),
      diblokir: Value(diblokir),
      diizinkan: Value(diizinkan),
      statusChat: Value(statusChat),
      statusStreaming: Value(statusStreaming),
      hargaInputPerJuta: hargaInputPerJuta == null && nullToAbsent
          ? const Value.absent()
          : Value(hargaInputPerJuta),
      hargaOutputPerJuta: hargaOutputPerJuta == null && nullToAbsent
          ? const Value.absent()
          : Value(hargaOutputPerJuta),
      terakhirDipakai: terakhirDipakai == null && nullToAbsent
          ? const Value.absent()
          : Value(terakhirDipakai),
    );
  }

  factory AiModel.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AiModel(
      id: serializer.fromJson<int>(json['id']),
      providerId: serializer.fromJson<int>(json['providerId']),
      modelId: serializer.fromJson<String>(json['modelId']),
      displayName: serializer.fromJson<String?>(json['displayName']),
      favorit: serializer.fromJson<bool>(json['favorit']),
      manual: serializer.fromJson<bool>(json['manual']),
      diblokir: serializer.fromJson<bool>(json['diblokir']),
      diizinkan: serializer.fromJson<bool>(json['diizinkan']),
      statusChat: $AiModelsTable.$converterstatusChat.fromJson(
        serializer.fromJson<String>(json['statusChat']),
      ),
      statusStreaming: $AiModelsTable.$converterstatusStreaming.fromJson(
        serializer.fromJson<String>(json['statusStreaming']),
      ),
      hargaInputPerJuta: serializer.fromJson<int?>(json['hargaInputPerJuta']),
      hargaOutputPerJuta: serializer.fromJson<int?>(json['hargaOutputPerJuta']),
      terakhirDipakai: serializer.fromJson<DateTime?>(json['terakhirDipakai']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'providerId': serializer.toJson<int>(providerId),
      'modelId': serializer.toJson<String>(modelId),
      'displayName': serializer.toJson<String?>(displayName),
      'favorit': serializer.toJson<bool>(favorit),
      'manual': serializer.toJson<bool>(manual),
      'diblokir': serializer.toJson<bool>(diblokir),
      'diizinkan': serializer.toJson<bool>(diizinkan),
      'statusChat': serializer.toJson<String>(
        $AiModelsTable.$converterstatusChat.toJson(statusChat),
      ),
      'statusStreaming': serializer.toJson<String>(
        $AiModelsTable.$converterstatusStreaming.toJson(statusStreaming),
      ),
      'hargaInputPerJuta': serializer.toJson<int?>(hargaInputPerJuta),
      'hargaOutputPerJuta': serializer.toJson<int?>(hargaOutputPerJuta),
      'terakhirDipakai': serializer.toJson<DateTime?>(terakhirDipakai),
    };
  }

  AiModel copyWith({
    int? id,
    int? providerId,
    String? modelId,
    Value<String?> displayName = const Value.absent(),
    bool? favorit,
    bool? manual,
    bool? diblokir,
    bool? diizinkan,
    CapabilityStatus? statusChat,
    CapabilityStatus? statusStreaming,
    Value<int?> hargaInputPerJuta = const Value.absent(),
    Value<int?> hargaOutputPerJuta = const Value.absent(),
    Value<DateTime?> terakhirDipakai = const Value.absent(),
  }) => AiModel(
    id: id ?? this.id,
    providerId: providerId ?? this.providerId,
    modelId: modelId ?? this.modelId,
    displayName: displayName.present ? displayName.value : this.displayName,
    favorit: favorit ?? this.favorit,
    manual: manual ?? this.manual,
    diblokir: diblokir ?? this.diblokir,
    diizinkan: diizinkan ?? this.diizinkan,
    statusChat: statusChat ?? this.statusChat,
    statusStreaming: statusStreaming ?? this.statusStreaming,
    hargaInputPerJuta: hargaInputPerJuta.present
        ? hargaInputPerJuta.value
        : this.hargaInputPerJuta,
    hargaOutputPerJuta: hargaOutputPerJuta.present
        ? hargaOutputPerJuta.value
        : this.hargaOutputPerJuta,
    terakhirDipakai: terakhirDipakai.present
        ? terakhirDipakai.value
        : this.terakhirDipakai,
  );
  AiModel copyWithCompanion(AiModelsCompanion data) {
    return AiModel(
      id: data.id.present ? data.id.value : this.id,
      providerId: data.providerId.present
          ? data.providerId.value
          : this.providerId,
      modelId: data.modelId.present ? data.modelId.value : this.modelId,
      displayName: data.displayName.present
          ? data.displayName.value
          : this.displayName,
      favorit: data.favorit.present ? data.favorit.value : this.favorit,
      manual: data.manual.present ? data.manual.value : this.manual,
      diblokir: data.diblokir.present ? data.diblokir.value : this.diblokir,
      diizinkan: data.diizinkan.present ? data.diizinkan.value : this.diizinkan,
      statusChat: data.statusChat.present
          ? data.statusChat.value
          : this.statusChat,
      statusStreaming: data.statusStreaming.present
          ? data.statusStreaming.value
          : this.statusStreaming,
      hargaInputPerJuta: data.hargaInputPerJuta.present
          ? data.hargaInputPerJuta.value
          : this.hargaInputPerJuta,
      hargaOutputPerJuta: data.hargaOutputPerJuta.present
          ? data.hargaOutputPerJuta.value
          : this.hargaOutputPerJuta,
      terakhirDipakai: data.terakhirDipakai.present
          ? data.terakhirDipakai.value
          : this.terakhirDipakai,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AiModel(')
          ..write('id: $id, ')
          ..write('providerId: $providerId, ')
          ..write('modelId: $modelId, ')
          ..write('displayName: $displayName, ')
          ..write('favorit: $favorit, ')
          ..write('manual: $manual, ')
          ..write('diblokir: $diblokir, ')
          ..write('diizinkan: $diizinkan, ')
          ..write('statusChat: $statusChat, ')
          ..write('statusStreaming: $statusStreaming, ')
          ..write('hargaInputPerJuta: $hargaInputPerJuta, ')
          ..write('hargaOutputPerJuta: $hargaOutputPerJuta, ')
          ..write('terakhirDipakai: $terakhirDipakai')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    providerId,
    modelId,
    displayName,
    favorit,
    manual,
    diblokir,
    diizinkan,
    statusChat,
    statusStreaming,
    hargaInputPerJuta,
    hargaOutputPerJuta,
    terakhirDipakai,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AiModel &&
          other.id == this.id &&
          other.providerId == this.providerId &&
          other.modelId == this.modelId &&
          other.displayName == this.displayName &&
          other.favorit == this.favorit &&
          other.manual == this.manual &&
          other.diblokir == this.diblokir &&
          other.diizinkan == this.diizinkan &&
          other.statusChat == this.statusChat &&
          other.statusStreaming == this.statusStreaming &&
          other.hargaInputPerJuta == this.hargaInputPerJuta &&
          other.hargaOutputPerJuta == this.hargaOutputPerJuta &&
          other.terakhirDipakai == this.terakhirDipakai);
}

class AiModelsCompanion extends UpdateCompanion<AiModel> {
  final Value<int> id;
  final Value<int> providerId;
  final Value<String> modelId;
  final Value<String?> displayName;
  final Value<bool> favorit;
  final Value<bool> manual;
  final Value<bool> diblokir;
  final Value<bool> diizinkan;
  final Value<CapabilityStatus> statusChat;
  final Value<CapabilityStatus> statusStreaming;
  final Value<int?> hargaInputPerJuta;
  final Value<int?> hargaOutputPerJuta;
  final Value<DateTime?> terakhirDipakai;
  const AiModelsCompanion({
    this.id = const Value.absent(),
    this.providerId = const Value.absent(),
    this.modelId = const Value.absent(),
    this.displayName = const Value.absent(),
    this.favorit = const Value.absent(),
    this.manual = const Value.absent(),
    this.diblokir = const Value.absent(),
    this.diizinkan = const Value.absent(),
    this.statusChat = const Value.absent(),
    this.statusStreaming = const Value.absent(),
    this.hargaInputPerJuta = const Value.absent(),
    this.hargaOutputPerJuta = const Value.absent(),
    this.terakhirDipakai = const Value.absent(),
  });
  AiModelsCompanion.insert({
    this.id = const Value.absent(),
    required int providerId,
    required String modelId,
    this.displayName = const Value.absent(),
    this.favorit = const Value.absent(),
    this.manual = const Value.absent(),
    this.diblokir = const Value.absent(),
    this.diizinkan = const Value.absent(),
    this.statusChat = const Value.absent(),
    this.statusStreaming = const Value.absent(),
    this.hargaInputPerJuta = const Value.absent(),
    this.hargaOutputPerJuta = const Value.absent(),
    this.terakhirDipakai = const Value.absent(),
  }) : providerId = Value(providerId),
       modelId = Value(modelId);
  static Insertable<AiModel> custom({
    Expression<int>? id,
    Expression<int>? providerId,
    Expression<String>? modelId,
    Expression<String>? displayName,
    Expression<bool>? favorit,
    Expression<bool>? manual,
    Expression<bool>? diblokir,
    Expression<bool>? diizinkan,
    Expression<String>? statusChat,
    Expression<String>? statusStreaming,
    Expression<int>? hargaInputPerJuta,
    Expression<int>? hargaOutputPerJuta,
    Expression<DateTime>? terakhirDipakai,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (providerId != null) 'provider_id': providerId,
      if (modelId != null) 'model_id': modelId,
      if (displayName != null) 'display_name': displayName,
      if (favorit != null) 'favorit': favorit,
      if (manual != null) 'manual': manual,
      if (diblokir != null) 'diblokir': diblokir,
      if (diizinkan != null) 'diizinkan': diizinkan,
      if (statusChat != null) 'status_chat': statusChat,
      if (statusStreaming != null) 'status_streaming': statusStreaming,
      if (hargaInputPerJuta != null) 'harga_input_per_juta': hargaInputPerJuta,
      if (hargaOutputPerJuta != null)
        'harga_output_per_juta': hargaOutputPerJuta,
      if (terakhirDipakai != null) 'terakhir_dipakai': terakhirDipakai,
    });
  }

  AiModelsCompanion copyWith({
    Value<int>? id,
    Value<int>? providerId,
    Value<String>? modelId,
    Value<String?>? displayName,
    Value<bool>? favorit,
    Value<bool>? manual,
    Value<bool>? diblokir,
    Value<bool>? diizinkan,
    Value<CapabilityStatus>? statusChat,
    Value<CapabilityStatus>? statusStreaming,
    Value<int?>? hargaInputPerJuta,
    Value<int?>? hargaOutputPerJuta,
    Value<DateTime?>? terakhirDipakai,
  }) {
    return AiModelsCompanion(
      id: id ?? this.id,
      providerId: providerId ?? this.providerId,
      modelId: modelId ?? this.modelId,
      displayName: displayName ?? this.displayName,
      favorit: favorit ?? this.favorit,
      manual: manual ?? this.manual,
      diblokir: diblokir ?? this.diblokir,
      diizinkan: diizinkan ?? this.diizinkan,
      statusChat: statusChat ?? this.statusChat,
      statusStreaming: statusStreaming ?? this.statusStreaming,
      hargaInputPerJuta: hargaInputPerJuta ?? this.hargaInputPerJuta,
      hargaOutputPerJuta: hargaOutputPerJuta ?? this.hargaOutputPerJuta,
      terakhirDipakai: terakhirDipakai ?? this.terakhirDipakai,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (providerId.present) {
      map['provider_id'] = Variable<int>(providerId.value);
    }
    if (modelId.present) {
      map['model_id'] = Variable<String>(modelId.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (favorit.present) {
      map['favorit'] = Variable<bool>(favorit.value);
    }
    if (manual.present) {
      map['manual'] = Variable<bool>(manual.value);
    }
    if (diblokir.present) {
      map['diblokir'] = Variable<bool>(diblokir.value);
    }
    if (diizinkan.present) {
      map['diizinkan'] = Variable<bool>(diizinkan.value);
    }
    if (statusChat.present) {
      map['status_chat'] = Variable<String>(
        $AiModelsTable.$converterstatusChat.toSql(statusChat.value),
      );
    }
    if (statusStreaming.present) {
      map['status_streaming'] = Variable<String>(
        $AiModelsTable.$converterstatusStreaming.toSql(statusStreaming.value),
      );
    }
    if (hargaInputPerJuta.present) {
      map['harga_input_per_juta'] = Variable<int>(hargaInputPerJuta.value);
    }
    if (hargaOutputPerJuta.present) {
      map['harga_output_per_juta'] = Variable<int>(hargaOutputPerJuta.value);
    }
    if (terakhirDipakai.present) {
      map['terakhir_dipakai'] = Variable<DateTime>(terakhirDipakai.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AiModelsCompanion(')
          ..write('id: $id, ')
          ..write('providerId: $providerId, ')
          ..write('modelId: $modelId, ')
          ..write('displayName: $displayName, ')
          ..write('favorit: $favorit, ')
          ..write('manual: $manual, ')
          ..write('diblokir: $diblokir, ')
          ..write('diizinkan: $diizinkan, ')
          ..write('statusChat: $statusChat, ')
          ..write('statusStreaming: $statusStreaming, ')
          ..write('hargaInputPerJuta: $hargaInputPerJuta, ')
          ..write('hargaOutputPerJuta: $hargaOutputPerJuta, ')
          ..write('terakhirDipakai: $terakhirDipakai')
          ..write(')'))
        .toString();
  }
}

class $ModelListCachesTable extends ModelListCaches
    with TableInfo<$ModelListCachesTable, ModelListCache> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ModelListCachesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _providerIdMeta = const VerificationMeta(
    'providerId',
  );
  @override
  late final GeneratedColumn<int> providerId = GeneratedColumn<int>(
    'provider_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES ai_provider_configurations (id)',
    ),
  );
  static const VerificationMeta _jsonModelMeta = const VerificationMeta(
    'jsonModel',
  );
  @override
  late final GeneratedColumn<String> jsonModel = GeneratedColumn<String>(
    'json_model',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _diambilPadaMeta = const VerificationMeta(
    'diambilPada',
  );
  @override
  late final GeneratedColumn<DateTime> diambilPada = GeneratedColumn<DateTime>(
    'diambil_pada',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [providerId, jsonModel, diambilPada];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'model_list_caches';
  @override
  VerificationContext validateIntegrity(
    Insertable<ModelListCache> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('provider_id')) {
      context.handle(
        _providerIdMeta,
        providerId.isAcceptableOrUnknown(data['provider_id']!, _providerIdMeta),
      );
    }
    if (data.containsKey('json_model')) {
      context.handle(
        _jsonModelMeta,
        jsonModel.isAcceptableOrUnknown(data['json_model']!, _jsonModelMeta),
      );
    } else if (isInserting) {
      context.missing(_jsonModelMeta);
    }
    if (data.containsKey('diambil_pada')) {
      context.handle(
        _diambilPadaMeta,
        diambilPada.isAcceptableOrUnknown(
          data['diambil_pada']!,
          _diambilPadaMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_diambilPadaMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {providerId};
  @override
  ModelListCache map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ModelListCache(
      providerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}provider_id'],
      )!,
      jsonModel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}json_model'],
      )!,
      diambilPada: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}diambil_pada'],
      )!,
    );
  }

  @override
  $ModelListCachesTable createAlias(String alias) {
    return $ModelListCachesTable(attachedDatabase, alias);
  }
}

class ModelListCache extends DataClass implements Insertable<ModelListCache> {
  final int providerId;
  final String jsonModel;
  final DateTime diambilPada;
  const ModelListCache({
    required this.providerId,
    required this.jsonModel,
    required this.diambilPada,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['provider_id'] = Variable<int>(providerId);
    map['json_model'] = Variable<String>(jsonModel);
    map['diambil_pada'] = Variable<DateTime>(diambilPada);
    return map;
  }

  ModelListCachesCompanion toCompanion(bool nullToAbsent) {
    return ModelListCachesCompanion(
      providerId: Value(providerId),
      jsonModel: Value(jsonModel),
      diambilPada: Value(diambilPada),
    );
  }

  factory ModelListCache.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ModelListCache(
      providerId: serializer.fromJson<int>(json['providerId']),
      jsonModel: serializer.fromJson<String>(json['jsonModel']),
      diambilPada: serializer.fromJson<DateTime>(json['diambilPada']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'providerId': serializer.toJson<int>(providerId),
      'jsonModel': serializer.toJson<String>(jsonModel),
      'diambilPada': serializer.toJson<DateTime>(diambilPada),
    };
  }

  ModelListCache copyWith({
    int? providerId,
    String? jsonModel,
    DateTime? diambilPada,
  }) => ModelListCache(
    providerId: providerId ?? this.providerId,
    jsonModel: jsonModel ?? this.jsonModel,
    diambilPada: diambilPada ?? this.diambilPada,
  );
  ModelListCache copyWithCompanion(ModelListCachesCompanion data) {
    return ModelListCache(
      providerId: data.providerId.present
          ? data.providerId.value
          : this.providerId,
      jsonModel: data.jsonModel.present ? data.jsonModel.value : this.jsonModel,
      diambilPada: data.diambilPada.present
          ? data.diambilPada.value
          : this.diambilPada,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ModelListCache(')
          ..write('providerId: $providerId, ')
          ..write('jsonModel: $jsonModel, ')
          ..write('diambilPada: $diambilPada')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(providerId, jsonModel, diambilPada);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ModelListCache &&
          other.providerId == this.providerId &&
          other.jsonModel == this.jsonModel &&
          other.diambilPada == this.diambilPada);
}

class ModelListCachesCompanion extends UpdateCompanion<ModelListCache> {
  final Value<int> providerId;
  final Value<String> jsonModel;
  final Value<DateTime> diambilPada;
  const ModelListCachesCompanion({
    this.providerId = const Value.absent(),
    this.jsonModel = const Value.absent(),
    this.diambilPada = const Value.absent(),
  });
  ModelListCachesCompanion.insert({
    this.providerId = const Value.absent(),
    required String jsonModel,
    required DateTime diambilPada,
  }) : jsonModel = Value(jsonModel),
       diambilPada = Value(diambilPada);
  static Insertable<ModelListCache> custom({
    Expression<int>? providerId,
    Expression<String>? jsonModel,
    Expression<DateTime>? diambilPada,
  }) {
    return RawValuesInsertable({
      if (providerId != null) 'provider_id': providerId,
      if (jsonModel != null) 'json_model': jsonModel,
      if (diambilPada != null) 'diambil_pada': diambilPada,
    });
  }

  ModelListCachesCompanion copyWith({
    Value<int>? providerId,
    Value<String>? jsonModel,
    Value<DateTime>? diambilPada,
  }) {
    return ModelListCachesCompanion(
      providerId: providerId ?? this.providerId,
      jsonModel: jsonModel ?? this.jsonModel,
      diambilPada: diambilPada ?? this.diambilPada,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (providerId.present) {
      map['provider_id'] = Variable<int>(providerId.value);
    }
    if (jsonModel.present) {
      map['json_model'] = Variable<String>(jsonModel.value);
    }
    if (diambilPada.present) {
      map['diambil_pada'] = Variable<DateTime>(diambilPada.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ModelListCachesCompanion(')
          ..write('providerId: $providerId, ')
          ..write('jsonModel: $jsonModel, ')
          ..write('diambilPada: $diambilPada')
          ..write(')'))
        .toString();
  }
}

class $ChatConversationsTable extends ChatConversations
    with TableInfo<$ChatConversationsTable, ChatConversation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChatConversationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _judulMeta = const VerificationMeta('judul');
  @override
  late final GeneratedColumn<String> judul = GeneratedColumn<String>(
    'judul',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _providerIdMeta = const VerificationMeta(
    'providerId',
  );
  @override
  late final GeneratedColumn<int> providerId = GeneratedColumn<int>(
    'provider_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES ai_provider_configurations (id)',
    ),
  );
  static const VerificationMeta _modelIdMeta = const VerificationMeta(
    'modelId',
  );
  @override
  late final GeneratedColumn<String> modelId = GeneratedColumn<String>(
    'model_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dibuatPadaMeta = const VerificationMeta(
    'dibuatPada',
  );
  @override
  late final GeneratedColumn<DateTime> dibuatPada = GeneratedColumn<DateTime>(
    'dibuat_pada',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _diperbaruiPadaMeta = const VerificationMeta(
    'diperbaruiPada',
  );
  @override
  late final GeneratedColumn<DateTime> diperbaruiPada =
      GeneratedColumn<DateTime>(
        'diperbarui_pada',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    judul,
    providerId,
    modelId,
    dibuatPada,
    diperbaruiPada,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'chat_conversations';
  @override
  VerificationContext validateIntegrity(
    Insertable<ChatConversation> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('judul')) {
      context.handle(
        _judulMeta,
        judul.isAcceptableOrUnknown(data['judul']!, _judulMeta),
      );
    } else if (isInserting) {
      context.missing(_judulMeta);
    }
    if (data.containsKey('provider_id')) {
      context.handle(
        _providerIdMeta,
        providerId.isAcceptableOrUnknown(data['provider_id']!, _providerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_providerIdMeta);
    }
    if (data.containsKey('model_id')) {
      context.handle(
        _modelIdMeta,
        modelId.isAcceptableOrUnknown(data['model_id']!, _modelIdMeta),
      );
    } else if (isInserting) {
      context.missing(_modelIdMeta);
    }
    if (data.containsKey('dibuat_pada')) {
      context.handle(
        _dibuatPadaMeta,
        dibuatPada.isAcceptableOrUnknown(data['dibuat_pada']!, _dibuatPadaMeta),
      );
    } else if (isInserting) {
      context.missing(_dibuatPadaMeta);
    }
    if (data.containsKey('diperbarui_pada')) {
      context.handle(
        _diperbaruiPadaMeta,
        diperbaruiPada.isAcceptableOrUnknown(
          data['diperbarui_pada']!,
          _diperbaruiPadaMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_diperbaruiPadaMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChatConversation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChatConversation(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      judul: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}judul'],
      )!,
      providerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}provider_id'],
      )!,
      modelId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}model_id'],
      )!,
      dibuatPada: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}dibuat_pada'],
      )!,
      diperbaruiPada: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}diperbarui_pada'],
      )!,
    );
  }

  @override
  $ChatConversationsTable createAlias(String alias) {
    return $ChatConversationsTable(attachedDatabase, alias);
  }
}

class ChatConversation extends DataClass
    implements Insertable<ChatConversation> {
  final int id;
  final String judul;
  final int providerId;
  final String modelId;
  final DateTime dibuatPada;
  final DateTime diperbaruiPada;
  const ChatConversation({
    required this.id,
    required this.judul,
    required this.providerId,
    required this.modelId,
    required this.dibuatPada,
    required this.diperbaruiPada,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['judul'] = Variable<String>(judul);
    map['provider_id'] = Variable<int>(providerId);
    map['model_id'] = Variable<String>(modelId);
    map['dibuat_pada'] = Variable<DateTime>(dibuatPada);
    map['diperbarui_pada'] = Variable<DateTime>(diperbaruiPada);
    return map;
  }

  ChatConversationsCompanion toCompanion(bool nullToAbsent) {
    return ChatConversationsCompanion(
      id: Value(id),
      judul: Value(judul),
      providerId: Value(providerId),
      modelId: Value(modelId),
      dibuatPada: Value(dibuatPada),
      diperbaruiPada: Value(diperbaruiPada),
    );
  }

  factory ChatConversation.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChatConversation(
      id: serializer.fromJson<int>(json['id']),
      judul: serializer.fromJson<String>(json['judul']),
      providerId: serializer.fromJson<int>(json['providerId']),
      modelId: serializer.fromJson<String>(json['modelId']),
      dibuatPada: serializer.fromJson<DateTime>(json['dibuatPada']),
      diperbaruiPada: serializer.fromJson<DateTime>(json['diperbaruiPada']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'judul': serializer.toJson<String>(judul),
      'providerId': serializer.toJson<int>(providerId),
      'modelId': serializer.toJson<String>(modelId),
      'dibuatPada': serializer.toJson<DateTime>(dibuatPada),
      'diperbaruiPada': serializer.toJson<DateTime>(diperbaruiPada),
    };
  }

  ChatConversation copyWith({
    int? id,
    String? judul,
    int? providerId,
    String? modelId,
    DateTime? dibuatPada,
    DateTime? diperbaruiPada,
  }) => ChatConversation(
    id: id ?? this.id,
    judul: judul ?? this.judul,
    providerId: providerId ?? this.providerId,
    modelId: modelId ?? this.modelId,
    dibuatPada: dibuatPada ?? this.dibuatPada,
    diperbaruiPada: diperbaruiPada ?? this.diperbaruiPada,
  );
  ChatConversation copyWithCompanion(ChatConversationsCompanion data) {
    return ChatConversation(
      id: data.id.present ? data.id.value : this.id,
      judul: data.judul.present ? data.judul.value : this.judul,
      providerId: data.providerId.present
          ? data.providerId.value
          : this.providerId,
      modelId: data.modelId.present ? data.modelId.value : this.modelId,
      dibuatPada: data.dibuatPada.present
          ? data.dibuatPada.value
          : this.dibuatPada,
      diperbaruiPada: data.diperbaruiPada.present
          ? data.diperbaruiPada.value
          : this.diperbaruiPada,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChatConversation(')
          ..write('id: $id, ')
          ..write('judul: $judul, ')
          ..write('providerId: $providerId, ')
          ..write('modelId: $modelId, ')
          ..write('dibuatPada: $dibuatPada, ')
          ..write('diperbaruiPada: $diperbaruiPada')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, judul, providerId, modelId, dibuatPada, diperbaruiPada);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChatConversation &&
          other.id == this.id &&
          other.judul == this.judul &&
          other.providerId == this.providerId &&
          other.modelId == this.modelId &&
          other.dibuatPada == this.dibuatPada &&
          other.diperbaruiPada == this.diperbaruiPada);
}

class ChatConversationsCompanion extends UpdateCompanion<ChatConversation> {
  final Value<int> id;
  final Value<String> judul;
  final Value<int> providerId;
  final Value<String> modelId;
  final Value<DateTime> dibuatPada;
  final Value<DateTime> diperbaruiPada;
  const ChatConversationsCompanion({
    this.id = const Value.absent(),
    this.judul = const Value.absent(),
    this.providerId = const Value.absent(),
    this.modelId = const Value.absent(),
    this.dibuatPada = const Value.absent(),
    this.diperbaruiPada = const Value.absent(),
  });
  ChatConversationsCompanion.insert({
    this.id = const Value.absent(),
    required String judul,
    required int providerId,
    required String modelId,
    required DateTime dibuatPada,
    required DateTime diperbaruiPada,
  }) : judul = Value(judul),
       providerId = Value(providerId),
       modelId = Value(modelId),
       dibuatPada = Value(dibuatPada),
       diperbaruiPada = Value(diperbaruiPada);
  static Insertable<ChatConversation> custom({
    Expression<int>? id,
    Expression<String>? judul,
    Expression<int>? providerId,
    Expression<String>? modelId,
    Expression<DateTime>? dibuatPada,
    Expression<DateTime>? diperbaruiPada,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (judul != null) 'judul': judul,
      if (providerId != null) 'provider_id': providerId,
      if (modelId != null) 'model_id': modelId,
      if (dibuatPada != null) 'dibuat_pada': dibuatPada,
      if (diperbaruiPada != null) 'diperbarui_pada': diperbaruiPada,
    });
  }

  ChatConversationsCompanion copyWith({
    Value<int>? id,
    Value<String>? judul,
    Value<int>? providerId,
    Value<String>? modelId,
    Value<DateTime>? dibuatPada,
    Value<DateTime>? diperbaruiPada,
  }) {
    return ChatConversationsCompanion(
      id: id ?? this.id,
      judul: judul ?? this.judul,
      providerId: providerId ?? this.providerId,
      modelId: modelId ?? this.modelId,
      dibuatPada: dibuatPada ?? this.dibuatPada,
      diperbaruiPada: diperbaruiPada ?? this.diperbaruiPada,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (judul.present) {
      map['judul'] = Variable<String>(judul.value);
    }
    if (providerId.present) {
      map['provider_id'] = Variable<int>(providerId.value);
    }
    if (modelId.present) {
      map['model_id'] = Variable<String>(modelId.value);
    }
    if (dibuatPada.present) {
      map['dibuat_pada'] = Variable<DateTime>(dibuatPada.value);
    }
    if (diperbaruiPada.present) {
      map['diperbarui_pada'] = Variable<DateTime>(diperbaruiPada.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChatConversationsCompanion(')
          ..write('id: $id, ')
          ..write('judul: $judul, ')
          ..write('providerId: $providerId, ')
          ..write('modelId: $modelId, ')
          ..write('dibuatPada: $dibuatPada, ')
          ..write('diperbaruiPada: $diperbaruiPada')
          ..write(')'))
        .toString();
  }
}

class $ChatMessagesTable extends ChatMessages
    with TableInfo<$ChatMessagesTable, ChatMessage> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ChatMessagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _conversationIdMeta = const VerificationMeta(
    'conversationId',
  );
  @override
  late final GeneratedColumn<int> conversationId = GeneratedColumn<int>(
    'conversation_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES chat_conversations (id)',
    ),
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dibuatPadaMeta = const VerificationMeta(
    'dibuatPada',
  );
  @override
  late final GeneratedColumn<DateTime> dibuatPada = GeneratedColumn<DateTime>(
    'dibuat_pada',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    conversationId,
    role,
    content,
    dibuatPada,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'chat_messages';
  @override
  VerificationContext validateIntegrity(
    Insertable<ChatMessage> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('conversation_id')) {
      context.handle(
        _conversationIdMeta,
        conversationId.isAcceptableOrUnknown(
          data['conversation_id']!,
          _conversationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_conversationIdMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('dibuat_pada')) {
      context.handle(
        _dibuatPadaMeta,
        dibuatPada.isAcceptableOrUnknown(data['dibuat_pada']!, _dibuatPadaMeta),
      );
    } else if (isInserting) {
      context.missing(_dibuatPadaMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ChatMessage map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ChatMessage(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      conversationId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}conversation_id'],
      )!,
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      )!,
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      )!,
      dibuatPada: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}dibuat_pada'],
      )!,
    );
  }

  @override
  $ChatMessagesTable createAlias(String alias) {
    return $ChatMessagesTable(attachedDatabase, alias);
  }
}

class ChatMessage extends DataClass implements Insertable<ChatMessage> {
  final int id;
  final int conversationId;
  final String role;
  final String content;
  final DateTime dibuatPada;
  const ChatMessage({
    required this.id,
    required this.conversationId,
    required this.role,
    required this.content,
    required this.dibuatPada,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['conversation_id'] = Variable<int>(conversationId);
    map['role'] = Variable<String>(role);
    map['content'] = Variable<String>(content);
    map['dibuat_pada'] = Variable<DateTime>(dibuatPada);
    return map;
  }

  ChatMessagesCompanion toCompanion(bool nullToAbsent) {
    return ChatMessagesCompanion(
      id: Value(id),
      conversationId: Value(conversationId),
      role: Value(role),
      content: Value(content),
      dibuatPada: Value(dibuatPada),
    );
  }

  factory ChatMessage.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ChatMessage(
      id: serializer.fromJson<int>(json['id']),
      conversationId: serializer.fromJson<int>(json['conversationId']),
      role: serializer.fromJson<String>(json['role']),
      content: serializer.fromJson<String>(json['content']),
      dibuatPada: serializer.fromJson<DateTime>(json['dibuatPada']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'conversationId': serializer.toJson<int>(conversationId),
      'role': serializer.toJson<String>(role),
      'content': serializer.toJson<String>(content),
      'dibuatPada': serializer.toJson<DateTime>(dibuatPada),
    };
  }

  ChatMessage copyWith({
    int? id,
    int? conversationId,
    String? role,
    String? content,
    DateTime? dibuatPada,
  }) => ChatMessage(
    id: id ?? this.id,
    conversationId: conversationId ?? this.conversationId,
    role: role ?? this.role,
    content: content ?? this.content,
    dibuatPada: dibuatPada ?? this.dibuatPada,
  );
  ChatMessage copyWithCompanion(ChatMessagesCompanion data) {
    return ChatMessage(
      id: data.id.present ? data.id.value : this.id,
      conversationId: data.conversationId.present
          ? data.conversationId.value
          : this.conversationId,
      role: data.role.present ? data.role.value : this.role,
      content: data.content.present ? data.content.value : this.content,
      dibuatPada: data.dibuatPada.present
          ? data.dibuatPada.value
          : this.dibuatPada,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ChatMessage(')
          ..write('id: $id, ')
          ..write('conversationId: $conversationId, ')
          ..write('role: $role, ')
          ..write('content: $content, ')
          ..write('dibuatPada: $dibuatPada')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, conversationId, role, content, dibuatPada);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ChatMessage &&
          other.id == this.id &&
          other.conversationId == this.conversationId &&
          other.role == this.role &&
          other.content == this.content &&
          other.dibuatPada == this.dibuatPada);
}

class ChatMessagesCompanion extends UpdateCompanion<ChatMessage> {
  final Value<int> id;
  final Value<int> conversationId;
  final Value<String> role;
  final Value<String> content;
  final Value<DateTime> dibuatPada;
  const ChatMessagesCompanion({
    this.id = const Value.absent(),
    this.conversationId = const Value.absent(),
    this.role = const Value.absent(),
    this.content = const Value.absent(),
    this.dibuatPada = const Value.absent(),
  });
  ChatMessagesCompanion.insert({
    this.id = const Value.absent(),
    required int conversationId,
    required String role,
    required String content,
    required DateTime dibuatPada,
  }) : conversationId = Value(conversationId),
       role = Value(role),
       content = Value(content),
       dibuatPada = Value(dibuatPada);
  static Insertable<ChatMessage> custom({
    Expression<int>? id,
    Expression<int>? conversationId,
    Expression<String>? role,
    Expression<String>? content,
    Expression<DateTime>? dibuatPada,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (conversationId != null) 'conversation_id': conversationId,
      if (role != null) 'role': role,
      if (content != null) 'content': content,
      if (dibuatPada != null) 'dibuat_pada': dibuatPada,
    });
  }

  ChatMessagesCompanion copyWith({
    Value<int>? id,
    Value<int>? conversationId,
    Value<String>? role,
    Value<String>? content,
    Value<DateTime>? dibuatPada,
  }) {
    return ChatMessagesCompanion(
      id: id ?? this.id,
      conversationId: conversationId ?? this.conversationId,
      role: role ?? this.role,
      content: content ?? this.content,
      dibuatPada: dibuatPada ?? this.dibuatPada,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (conversationId.present) {
      map['conversation_id'] = Variable<int>(conversationId.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (dibuatPada.present) {
      map['dibuat_pada'] = Variable<DateTime>(dibuatPada.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ChatMessagesCompanion(')
          ..write('id: $id, ')
          ..write('conversationId: $conversationId, ')
          ..write('role: $role, ')
          ..write('content: $content, ')
          ..write('dibuatPada: $dibuatPada')
          ..write(')'))
        .toString();
  }
}

class $DanaPlusConfigurationsTable extends DanaPlusConfigurations
    with TableInfo<$DanaPlusConfigurationsTable, DanaPlusConfiguration> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DanaPlusConfigurationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<DanaPlusAvailability, String>
  availability =
      GeneratedColumn<String>(
        'availability',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<DanaPlusAvailability>(
        $DanaPlusConfigurationsTable.$converteravailability,
      );
  @override
  late final GeneratedColumnWithTypeConverter<DanaSplitMode, String>
  defaultSplitMode =
      GeneratedColumn<String>(
        'default_split_mode',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<DanaSplitMode>(
        $DanaPlusConfigurationsTable.$converterdefaultSplitMode,
      );
  @override
  late final GeneratedColumnWithTypeConverter<DanaExecutionStrategy, String>
  executionStrategy =
      GeneratedColumn<String>(
        'execution_strategy',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<DanaExecutionStrategy>(
        $DanaPlusConfigurationsTable.$converterexecutionStrategy,
      );
  static const VerificationMeta _persenBiasaBpMeta = const VerificationMeta(
    'persenBiasaBp',
  );
  @override
  late final GeneratedColumn<int> persenBiasaBp = GeneratedColumn<int>(
    'persen_biasa_bp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(5000),
  );
  static const VerificationMeta _bufferBiasaMeta = const VerificationMeta(
    'bufferBiasa',
  );
  @override
  late final GeneratedColumn<int> bufferBiasa = GeneratedColumn<int>(
    'buffer_biasa',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _targetPlusMeta = const VerificationMeta(
    'targetPlus',
  );
  @override
  late final GeneratedColumn<int> targetPlus = GeneratedColumn<int>(
    'target_plus',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _batasPlusMeta = const VerificationMeta(
    'batasPlus',
  );
  @override
  late final GeneratedColumn<int> batasPlus = GeneratedColumn<int>(
    'batas_plus',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tingkatRewardBpMeta = const VerificationMeta(
    'tingkatRewardBp',
  );
  @override
  late final GeneratedColumn<int> tingkatRewardBp = GeneratedColumn<int>(
    'tingkat_reward_bp',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<RewardRatePeriod, String>
  periodeReward =
      GeneratedColumn<String>(
        'periode_reward',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('perTahun'),
      ).withConverter<RewardRatePeriod>(
        $DanaPlusConfigurationsTable.$converterperiodeReward,
      );
  static const VerificationMeta _diperbaruiPadaMeta = const VerificationMeta(
    'diperbaruiPada',
  );
  @override
  late final GeneratedColumn<DateTime> diperbaruiPada =
      GeneratedColumn<DateTime>(
        'diperbarui_pada',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    availability,
    defaultSplitMode,
    executionStrategy,
    persenBiasaBp,
    bufferBiasa,
    targetPlus,
    batasPlus,
    tingkatRewardBp,
    periodeReward,
    diperbaruiPada,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'dana_plus_configurations';
  @override
  VerificationContext validateIntegrity(
    Insertable<DanaPlusConfiguration> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('persen_biasa_bp')) {
      context.handle(
        _persenBiasaBpMeta,
        persenBiasaBp.isAcceptableOrUnknown(
          data['persen_biasa_bp']!,
          _persenBiasaBpMeta,
        ),
      );
    }
    if (data.containsKey('buffer_biasa')) {
      context.handle(
        _bufferBiasaMeta,
        bufferBiasa.isAcceptableOrUnknown(
          data['buffer_biasa']!,
          _bufferBiasaMeta,
        ),
      );
    }
    if (data.containsKey('target_plus')) {
      context.handle(
        _targetPlusMeta,
        targetPlus.isAcceptableOrUnknown(data['target_plus']!, _targetPlusMeta),
      );
    }
    if (data.containsKey('batas_plus')) {
      context.handle(
        _batasPlusMeta,
        batasPlus.isAcceptableOrUnknown(data['batas_plus']!, _batasPlusMeta),
      );
    }
    if (data.containsKey('tingkat_reward_bp')) {
      context.handle(
        _tingkatRewardBpMeta,
        tingkatRewardBp.isAcceptableOrUnknown(
          data['tingkat_reward_bp']!,
          _tingkatRewardBpMeta,
        ),
      );
    }
    if (data.containsKey('diperbarui_pada')) {
      context.handle(
        _diperbaruiPadaMeta,
        diperbaruiPada.isAcceptableOrUnknown(
          data['diperbarui_pada']!,
          _diperbaruiPadaMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_diperbaruiPadaMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DanaPlusConfiguration map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DanaPlusConfiguration(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      availability: $DanaPlusConfigurationsTable.$converteravailability.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}availability'],
        )!,
      ),
      defaultSplitMode: $DanaPlusConfigurationsTable.$converterdefaultSplitMode
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.string,
              data['${effectivePrefix}default_split_mode'],
            )!,
          ),
      executionStrategy: $DanaPlusConfigurationsTable
          .$converterexecutionStrategy
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.string,
              data['${effectivePrefix}execution_strategy'],
            )!,
          ),
      persenBiasaBp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}persen_biasa_bp'],
      )!,
      bufferBiasa: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}buffer_biasa'],
      )!,
      targetPlus: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target_plus'],
      )!,
      batasPlus: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}batas_plus'],
      ),
      tingkatRewardBp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tingkat_reward_bp'],
      ),
      periodeReward: $DanaPlusConfigurationsTable.$converterperiodeReward
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.string,
              data['${effectivePrefix}periode_reward'],
            )!,
          ),
      diperbaruiPada: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}diperbarui_pada'],
      )!,
    );
  }

  @override
  $DanaPlusConfigurationsTable createAlias(String alias) {
    return $DanaPlusConfigurationsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<DanaPlusAvailability, String, String>
  $converteravailability = const EnumNameConverter<DanaPlusAvailability>(
    DanaPlusAvailability.values,
  );
  static JsonTypeConverter2<DanaSplitMode, String, String>
  $converterdefaultSplitMode = const EnumNameConverter<DanaSplitMode>(
    DanaSplitMode.values,
  );
  static JsonTypeConverter2<DanaExecutionStrategy, String, String>
  $converterexecutionStrategy = const EnumNameConverter<DanaExecutionStrategy>(
    DanaExecutionStrategy.values,
  );
  static JsonTypeConverter2<RewardRatePeriod, String, String>
  $converterperiodeReward = const EnumNameConverter<RewardRatePeriod>(
    RewardRatePeriod.values,
  );
}

class DanaPlusConfiguration extends DataClass
    implements Insertable<DanaPlusConfiguration> {
  final int id;
  final DanaPlusAvailability availability;
  final DanaSplitMode defaultSplitMode;
  final DanaExecutionStrategy executionStrategy;
  final int persenBiasaBp;
  final int bufferBiasa;
  final int targetPlus;
  final int? batasPlus;
  final int? tingkatRewardBp;
  final RewardRatePeriod periodeReward;
  final DateTime diperbaruiPada;
  const DanaPlusConfiguration({
    required this.id,
    required this.availability,
    required this.defaultSplitMode,
    required this.executionStrategy,
    required this.persenBiasaBp,
    required this.bufferBiasa,
    required this.targetPlus,
    this.batasPlus,
    this.tingkatRewardBp,
    required this.periodeReward,
    required this.diperbaruiPada,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['availability'] = Variable<String>(
        $DanaPlusConfigurationsTable.$converteravailability.toSql(availability),
      );
    }
    {
      map['default_split_mode'] = Variable<String>(
        $DanaPlusConfigurationsTable.$converterdefaultSplitMode.toSql(
          defaultSplitMode,
        ),
      );
    }
    {
      map['execution_strategy'] = Variable<String>(
        $DanaPlusConfigurationsTable.$converterexecutionStrategy.toSql(
          executionStrategy,
        ),
      );
    }
    map['persen_biasa_bp'] = Variable<int>(persenBiasaBp);
    map['buffer_biasa'] = Variable<int>(bufferBiasa);
    map['target_plus'] = Variable<int>(targetPlus);
    if (!nullToAbsent || batasPlus != null) {
      map['batas_plus'] = Variable<int>(batasPlus);
    }
    if (!nullToAbsent || tingkatRewardBp != null) {
      map['tingkat_reward_bp'] = Variable<int>(tingkatRewardBp);
    }
    {
      map['periode_reward'] = Variable<String>(
        $DanaPlusConfigurationsTable.$converterperiodeReward.toSql(
          periodeReward,
        ),
      );
    }
    map['diperbarui_pada'] = Variable<DateTime>(diperbaruiPada);
    return map;
  }

  DanaPlusConfigurationsCompanion toCompanion(bool nullToAbsent) {
    return DanaPlusConfigurationsCompanion(
      id: Value(id),
      availability: Value(availability),
      defaultSplitMode: Value(defaultSplitMode),
      executionStrategy: Value(executionStrategy),
      persenBiasaBp: Value(persenBiasaBp),
      bufferBiasa: Value(bufferBiasa),
      targetPlus: Value(targetPlus),
      batasPlus: batasPlus == null && nullToAbsent
          ? const Value.absent()
          : Value(batasPlus),
      tingkatRewardBp: tingkatRewardBp == null && nullToAbsent
          ? const Value.absent()
          : Value(tingkatRewardBp),
      periodeReward: Value(periodeReward),
      diperbaruiPada: Value(diperbaruiPada),
    );
  }

  factory DanaPlusConfiguration.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DanaPlusConfiguration(
      id: serializer.fromJson<int>(json['id']),
      availability: $DanaPlusConfigurationsTable.$converteravailability
          .fromJson(serializer.fromJson<String>(json['availability'])),
      defaultSplitMode: $DanaPlusConfigurationsTable.$converterdefaultSplitMode
          .fromJson(serializer.fromJson<String>(json['defaultSplitMode'])),
      executionStrategy: $DanaPlusConfigurationsTable
          .$converterexecutionStrategy
          .fromJson(serializer.fromJson<String>(json['executionStrategy'])),
      persenBiasaBp: serializer.fromJson<int>(json['persenBiasaBp']),
      bufferBiasa: serializer.fromJson<int>(json['bufferBiasa']),
      targetPlus: serializer.fromJson<int>(json['targetPlus']),
      batasPlus: serializer.fromJson<int?>(json['batasPlus']),
      tingkatRewardBp: serializer.fromJson<int?>(json['tingkatRewardBp']),
      periodeReward: $DanaPlusConfigurationsTable.$converterperiodeReward
          .fromJson(serializer.fromJson<String>(json['periodeReward'])),
      diperbaruiPada: serializer.fromJson<DateTime>(json['diperbaruiPada']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'availability': serializer.toJson<String>(
        $DanaPlusConfigurationsTable.$converteravailability.toJson(
          availability,
        ),
      ),
      'defaultSplitMode': serializer.toJson<String>(
        $DanaPlusConfigurationsTable.$converterdefaultSplitMode.toJson(
          defaultSplitMode,
        ),
      ),
      'executionStrategy': serializer.toJson<String>(
        $DanaPlusConfigurationsTable.$converterexecutionStrategy.toJson(
          executionStrategy,
        ),
      ),
      'persenBiasaBp': serializer.toJson<int>(persenBiasaBp),
      'bufferBiasa': serializer.toJson<int>(bufferBiasa),
      'targetPlus': serializer.toJson<int>(targetPlus),
      'batasPlus': serializer.toJson<int?>(batasPlus),
      'tingkatRewardBp': serializer.toJson<int?>(tingkatRewardBp),
      'periodeReward': serializer.toJson<String>(
        $DanaPlusConfigurationsTable.$converterperiodeReward.toJson(
          periodeReward,
        ),
      ),
      'diperbaruiPada': serializer.toJson<DateTime>(diperbaruiPada),
    };
  }

  DanaPlusConfiguration copyWith({
    int? id,
    DanaPlusAvailability? availability,
    DanaSplitMode? defaultSplitMode,
    DanaExecutionStrategy? executionStrategy,
    int? persenBiasaBp,
    int? bufferBiasa,
    int? targetPlus,
    Value<int?> batasPlus = const Value.absent(),
    Value<int?> tingkatRewardBp = const Value.absent(),
    RewardRatePeriod? periodeReward,
    DateTime? diperbaruiPada,
  }) => DanaPlusConfiguration(
    id: id ?? this.id,
    availability: availability ?? this.availability,
    defaultSplitMode: defaultSplitMode ?? this.defaultSplitMode,
    executionStrategy: executionStrategy ?? this.executionStrategy,
    persenBiasaBp: persenBiasaBp ?? this.persenBiasaBp,
    bufferBiasa: bufferBiasa ?? this.bufferBiasa,
    targetPlus: targetPlus ?? this.targetPlus,
    batasPlus: batasPlus.present ? batasPlus.value : this.batasPlus,
    tingkatRewardBp: tingkatRewardBp.present
        ? tingkatRewardBp.value
        : this.tingkatRewardBp,
    periodeReward: periodeReward ?? this.periodeReward,
    diperbaruiPada: diperbaruiPada ?? this.diperbaruiPada,
  );
  DanaPlusConfiguration copyWithCompanion(
    DanaPlusConfigurationsCompanion data,
  ) {
    return DanaPlusConfiguration(
      id: data.id.present ? data.id.value : this.id,
      availability: data.availability.present
          ? data.availability.value
          : this.availability,
      defaultSplitMode: data.defaultSplitMode.present
          ? data.defaultSplitMode.value
          : this.defaultSplitMode,
      executionStrategy: data.executionStrategy.present
          ? data.executionStrategy.value
          : this.executionStrategy,
      persenBiasaBp: data.persenBiasaBp.present
          ? data.persenBiasaBp.value
          : this.persenBiasaBp,
      bufferBiasa: data.bufferBiasa.present
          ? data.bufferBiasa.value
          : this.bufferBiasa,
      targetPlus: data.targetPlus.present
          ? data.targetPlus.value
          : this.targetPlus,
      batasPlus: data.batasPlus.present ? data.batasPlus.value : this.batasPlus,
      tingkatRewardBp: data.tingkatRewardBp.present
          ? data.tingkatRewardBp.value
          : this.tingkatRewardBp,
      periodeReward: data.periodeReward.present
          ? data.periodeReward.value
          : this.periodeReward,
      diperbaruiPada: data.diperbaruiPada.present
          ? data.diperbaruiPada.value
          : this.diperbaruiPada,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DanaPlusConfiguration(')
          ..write('id: $id, ')
          ..write('availability: $availability, ')
          ..write('defaultSplitMode: $defaultSplitMode, ')
          ..write('executionStrategy: $executionStrategy, ')
          ..write('persenBiasaBp: $persenBiasaBp, ')
          ..write('bufferBiasa: $bufferBiasa, ')
          ..write('targetPlus: $targetPlus, ')
          ..write('batasPlus: $batasPlus, ')
          ..write('tingkatRewardBp: $tingkatRewardBp, ')
          ..write('periodeReward: $periodeReward, ')
          ..write('diperbaruiPada: $diperbaruiPada')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    availability,
    defaultSplitMode,
    executionStrategy,
    persenBiasaBp,
    bufferBiasa,
    targetPlus,
    batasPlus,
    tingkatRewardBp,
    periodeReward,
    diperbaruiPada,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DanaPlusConfiguration &&
          other.id == this.id &&
          other.availability == this.availability &&
          other.defaultSplitMode == this.defaultSplitMode &&
          other.executionStrategy == this.executionStrategy &&
          other.persenBiasaBp == this.persenBiasaBp &&
          other.bufferBiasa == this.bufferBiasa &&
          other.targetPlus == this.targetPlus &&
          other.batasPlus == this.batasPlus &&
          other.tingkatRewardBp == this.tingkatRewardBp &&
          other.periodeReward == this.periodeReward &&
          other.diperbaruiPada == this.diperbaruiPada);
}

class DanaPlusConfigurationsCompanion
    extends UpdateCompanion<DanaPlusConfiguration> {
  final Value<int> id;
  final Value<DanaPlusAvailability> availability;
  final Value<DanaSplitMode> defaultSplitMode;
  final Value<DanaExecutionStrategy> executionStrategy;
  final Value<int> persenBiasaBp;
  final Value<int> bufferBiasa;
  final Value<int> targetPlus;
  final Value<int?> batasPlus;
  final Value<int?> tingkatRewardBp;
  final Value<RewardRatePeriod> periodeReward;
  final Value<DateTime> diperbaruiPada;
  const DanaPlusConfigurationsCompanion({
    this.id = const Value.absent(),
    this.availability = const Value.absent(),
    this.defaultSplitMode = const Value.absent(),
    this.executionStrategy = const Value.absent(),
    this.persenBiasaBp = const Value.absent(),
    this.bufferBiasa = const Value.absent(),
    this.targetPlus = const Value.absent(),
    this.batasPlus = const Value.absent(),
    this.tingkatRewardBp = const Value.absent(),
    this.periodeReward = const Value.absent(),
    this.diperbaruiPada = const Value.absent(),
  });
  DanaPlusConfigurationsCompanion.insert({
    this.id = const Value.absent(),
    required DanaPlusAvailability availability,
    required DanaSplitMode defaultSplitMode,
    required DanaExecutionStrategy executionStrategy,
    this.persenBiasaBp = const Value.absent(),
    this.bufferBiasa = const Value.absent(),
    this.targetPlus = const Value.absent(),
    this.batasPlus = const Value.absent(),
    this.tingkatRewardBp = const Value.absent(),
    this.periodeReward = const Value.absent(),
    required DateTime diperbaruiPada,
  }) : availability = Value(availability),
       defaultSplitMode = Value(defaultSplitMode),
       executionStrategy = Value(executionStrategy),
       diperbaruiPada = Value(diperbaruiPada);
  static Insertable<DanaPlusConfiguration> custom({
    Expression<int>? id,
    Expression<String>? availability,
    Expression<String>? defaultSplitMode,
    Expression<String>? executionStrategy,
    Expression<int>? persenBiasaBp,
    Expression<int>? bufferBiasa,
    Expression<int>? targetPlus,
    Expression<int>? batasPlus,
    Expression<int>? tingkatRewardBp,
    Expression<String>? periodeReward,
    Expression<DateTime>? diperbaruiPada,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (availability != null) 'availability': availability,
      if (defaultSplitMode != null) 'default_split_mode': defaultSplitMode,
      if (executionStrategy != null) 'execution_strategy': executionStrategy,
      if (persenBiasaBp != null) 'persen_biasa_bp': persenBiasaBp,
      if (bufferBiasa != null) 'buffer_biasa': bufferBiasa,
      if (targetPlus != null) 'target_plus': targetPlus,
      if (batasPlus != null) 'batas_plus': batasPlus,
      if (tingkatRewardBp != null) 'tingkat_reward_bp': tingkatRewardBp,
      if (periodeReward != null) 'periode_reward': periodeReward,
      if (diperbaruiPada != null) 'diperbarui_pada': diperbaruiPada,
    });
  }

  DanaPlusConfigurationsCompanion copyWith({
    Value<int>? id,
    Value<DanaPlusAvailability>? availability,
    Value<DanaSplitMode>? defaultSplitMode,
    Value<DanaExecutionStrategy>? executionStrategy,
    Value<int>? persenBiasaBp,
    Value<int>? bufferBiasa,
    Value<int>? targetPlus,
    Value<int?>? batasPlus,
    Value<int?>? tingkatRewardBp,
    Value<RewardRatePeriod>? periodeReward,
    Value<DateTime>? diperbaruiPada,
  }) {
    return DanaPlusConfigurationsCompanion(
      id: id ?? this.id,
      availability: availability ?? this.availability,
      defaultSplitMode: defaultSplitMode ?? this.defaultSplitMode,
      executionStrategy: executionStrategy ?? this.executionStrategy,
      persenBiasaBp: persenBiasaBp ?? this.persenBiasaBp,
      bufferBiasa: bufferBiasa ?? this.bufferBiasa,
      targetPlus: targetPlus ?? this.targetPlus,
      batasPlus: batasPlus ?? this.batasPlus,
      tingkatRewardBp: tingkatRewardBp ?? this.tingkatRewardBp,
      periodeReward: periodeReward ?? this.periodeReward,
      diperbaruiPada: diperbaruiPada ?? this.diperbaruiPada,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (availability.present) {
      map['availability'] = Variable<String>(
        $DanaPlusConfigurationsTable.$converteravailability.toSql(
          availability.value,
        ),
      );
    }
    if (defaultSplitMode.present) {
      map['default_split_mode'] = Variable<String>(
        $DanaPlusConfigurationsTable.$converterdefaultSplitMode.toSql(
          defaultSplitMode.value,
        ),
      );
    }
    if (executionStrategy.present) {
      map['execution_strategy'] = Variable<String>(
        $DanaPlusConfigurationsTable.$converterexecutionStrategy.toSql(
          executionStrategy.value,
        ),
      );
    }
    if (persenBiasaBp.present) {
      map['persen_biasa_bp'] = Variable<int>(persenBiasaBp.value);
    }
    if (bufferBiasa.present) {
      map['buffer_biasa'] = Variable<int>(bufferBiasa.value);
    }
    if (targetPlus.present) {
      map['target_plus'] = Variable<int>(targetPlus.value);
    }
    if (batasPlus.present) {
      map['batas_plus'] = Variable<int>(batasPlus.value);
    }
    if (tingkatRewardBp.present) {
      map['tingkat_reward_bp'] = Variable<int>(tingkatRewardBp.value);
    }
    if (periodeReward.present) {
      map['periode_reward'] = Variable<String>(
        $DanaPlusConfigurationsTable.$converterperiodeReward.toSql(
          periodeReward.value,
        ),
      );
    }
    if (diperbaruiPada.present) {
      map['diperbarui_pada'] = Variable<DateTime>(diperbaruiPada.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DanaPlusConfigurationsCompanion(')
          ..write('id: $id, ')
          ..write('availability: $availability, ')
          ..write('defaultSplitMode: $defaultSplitMode, ')
          ..write('executionStrategy: $executionStrategy, ')
          ..write('persenBiasaBp: $persenBiasaBp, ')
          ..write('bufferBiasa: $bufferBiasa, ')
          ..write('targetPlus: $targetPlus, ')
          ..write('batasPlus: $batasPlus, ')
          ..write('tingkatRewardBp: $tingkatRewardBp, ')
          ..write('periodeReward: $periodeReward, ')
          ..write('diperbaruiPada: $diperbaruiPada')
          ..write(')'))
        .toString();
  }
}

class $DanaBalanceLedgersTable extends DanaBalanceLedgers
    with TableInfo<$DanaBalanceLedgersTable, DanaBalanceLedger> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DanaBalanceLedgersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _tahunMeta = const VerificationMeta('tahun');
  @override
  late final GeneratedColumn<int> tahun = GeneratedColumn<int>(
    'tahun',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bulanMeta = const VerificationMeta('bulan');
  @override
  late final GeneratedColumn<int> bulan = GeneratedColumn<int>(
    'bulan',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _saldoAwalBiasaMeta = const VerificationMeta(
    'saldoAwalBiasa',
  );
  @override
  late final GeneratedColumn<int> saldoAwalBiasa = GeneratedColumn<int>(
    'saldo_awal_biasa',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _saldoAwalPlusMeta = const VerificationMeta(
    'saldoAwalPlus',
  );
  @override
  late final GeneratedColumn<int> saldoAwalPlus = GeneratedColumn<int>(
    'saldo_awal_plus',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _topUpKeBiasaMeta = const VerificationMeta(
    'topUpKeBiasa',
  );
  @override
  late final GeneratedColumn<int> topUpKeBiasa = GeneratedColumn<int>(
    'top_up_ke_biasa',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pindahKePlusMeta = const VerificationMeta(
    'pindahKePlus',
  );
  @override
  late final GeneratedColumn<int> pindahKePlus = GeneratedColumn<int>(
    'pindah_ke_plus',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pindahDariPlusMeta = const VerificationMeta(
    'pindahDariPlus',
  );
  @override
  late final GeneratedColumn<int> pindahDariPlus = GeneratedColumn<int>(
    'pindah_dari_plus',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pengeluaranBiasaMeta = const VerificationMeta(
    'pengeluaranBiasa',
  );
  @override
  late final GeneratedColumn<int> pengeluaranBiasa = GeneratedColumn<int>(
    'pengeluaran_biasa',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pengeluaranPlusMeta = const VerificationMeta(
    'pengeluaranPlus',
  );
  @override
  late final GeneratedColumn<int> pengeluaranPlus = GeneratedColumn<int>(
    'pengeluaran_plus',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rewardAktualMeta = const VerificationMeta(
    'rewardAktual',
  );
  @override
  late final GeneratedColumn<int> rewardAktual = GeneratedColumn<int>(
    'reward_aktual',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _saldoAkhirBiasaMeta = const VerificationMeta(
    'saldoAkhirBiasa',
  );
  @override
  late final GeneratedColumn<int> saldoAkhirBiasa = GeneratedColumn<int>(
    'saldo_akhir_biasa',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _saldoAkhirPlusMeta = const VerificationMeta(
    'saldoAkhirPlus',
  );
  @override
  late final GeneratedColumn<int> saldoAkhirPlus = GeneratedColumn<int>(
    'saldo_akhir_plus',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dibuatPadaMeta = const VerificationMeta(
    'dibuatPada',
  );
  @override
  late final GeneratedColumn<DateTime> dibuatPada = GeneratedColumn<DateTime>(
    'dibuat_pada',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tahun,
    bulan,
    saldoAwalBiasa,
    saldoAwalPlus,
    topUpKeBiasa,
    pindahKePlus,
    pindahDariPlus,
    pengeluaranBiasa,
    pengeluaranPlus,
    rewardAktual,
    saldoAkhirBiasa,
    saldoAkhirPlus,
    dibuatPada,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'dana_balance_ledgers';
  @override
  VerificationContext validateIntegrity(
    Insertable<DanaBalanceLedger> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('tahun')) {
      context.handle(
        _tahunMeta,
        tahun.isAcceptableOrUnknown(data['tahun']!, _tahunMeta),
      );
    } else if (isInserting) {
      context.missing(_tahunMeta);
    }
    if (data.containsKey('bulan')) {
      context.handle(
        _bulanMeta,
        bulan.isAcceptableOrUnknown(data['bulan']!, _bulanMeta),
      );
    } else if (isInserting) {
      context.missing(_bulanMeta);
    }
    if (data.containsKey('saldo_awal_biasa')) {
      context.handle(
        _saldoAwalBiasaMeta,
        saldoAwalBiasa.isAcceptableOrUnknown(
          data['saldo_awal_biasa']!,
          _saldoAwalBiasaMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_saldoAwalBiasaMeta);
    }
    if (data.containsKey('saldo_awal_plus')) {
      context.handle(
        _saldoAwalPlusMeta,
        saldoAwalPlus.isAcceptableOrUnknown(
          data['saldo_awal_plus']!,
          _saldoAwalPlusMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_saldoAwalPlusMeta);
    }
    if (data.containsKey('top_up_ke_biasa')) {
      context.handle(
        _topUpKeBiasaMeta,
        topUpKeBiasa.isAcceptableOrUnknown(
          data['top_up_ke_biasa']!,
          _topUpKeBiasaMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_topUpKeBiasaMeta);
    }
    if (data.containsKey('pindah_ke_plus')) {
      context.handle(
        _pindahKePlusMeta,
        pindahKePlus.isAcceptableOrUnknown(
          data['pindah_ke_plus']!,
          _pindahKePlusMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_pindahKePlusMeta);
    }
    if (data.containsKey('pindah_dari_plus')) {
      context.handle(
        _pindahDariPlusMeta,
        pindahDariPlus.isAcceptableOrUnknown(
          data['pindah_dari_plus']!,
          _pindahDariPlusMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_pindahDariPlusMeta);
    }
    if (data.containsKey('pengeluaran_biasa')) {
      context.handle(
        _pengeluaranBiasaMeta,
        pengeluaranBiasa.isAcceptableOrUnknown(
          data['pengeluaran_biasa']!,
          _pengeluaranBiasaMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_pengeluaranBiasaMeta);
    }
    if (data.containsKey('pengeluaran_plus')) {
      context.handle(
        _pengeluaranPlusMeta,
        pengeluaranPlus.isAcceptableOrUnknown(
          data['pengeluaran_plus']!,
          _pengeluaranPlusMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_pengeluaranPlusMeta);
    }
    if (data.containsKey('reward_aktual')) {
      context.handle(
        _rewardAktualMeta,
        rewardAktual.isAcceptableOrUnknown(
          data['reward_aktual']!,
          _rewardAktualMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_rewardAktualMeta);
    }
    if (data.containsKey('saldo_akhir_biasa')) {
      context.handle(
        _saldoAkhirBiasaMeta,
        saldoAkhirBiasa.isAcceptableOrUnknown(
          data['saldo_akhir_biasa']!,
          _saldoAkhirBiasaMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_saldoAkhirBiasaMeta);
    }
    if (data.containsKey('saldo_akhir_plus')) {
      context.handle(
        _saldoAkhirPlusMeta,
        saldoAkhirPlus.isAcceptableOrUnknown(
          data['saldo_akhir_plus']!,
          _saldoAkhirPlusMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_saldoAkhirPlusMeta);
    }
    if (data.containsKey('dibuat_pada')) {
      context.handle(
        _dibuatPadaMeta,
        dibuatPada.isAcceptableOrUnknown(data['dibuat_pada']!, _dibuatPadaMeta),
      );
    } else if (isInserting) {
      context.missing(_dibuatPadaMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {tahun, bulan},
  ];
  @override
  DanaBalanceLedger map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DanaBalanceLedger(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      tahun: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tahun'],
      )!,
      bulan: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}bulan'],
      )!,
      saldoAwalBiasa: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}saldo_awal_biasa'],
      )!,
      saldoAwalPlus: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}saldo_awal_plus'],
      )!,
      topUpKeBiasa: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}top_up_ke_biasa'],
      )!,
      pindahKePlus: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pindah_ke_plus'],
      )!,
      pindahDariPlus: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pindah_dari_plus'],
      )!,
      pengeluaranBiasa: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pengeluaran_biasa'],
      )!,
      pengeluaranPlus: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pengeluaran_plus'],
      )!,
      rewardAktual: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reward_aktual'],
      )!,
      saldoAkhirBiasa: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}saldo_akhir_biasa'],
      )!,
      saldoAkhirPlus: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}saldo_akhir_plus'],
      )!,
      dibuatPada: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}dibuat_pada'],
      )!,
    );
  }

  @override
  $DanaBalanceLedgersTable createAlias(String alias) {
    return $DanaBalanceLedgersTable(attachedDatabase, alias);
  }
}

class DanaBalanceLedger extends DataClass
    implements Insertable<DanaBalanceLedger> {
  final int id;
  final int tahun;
  final int bulan;
  final int saldoAwalBiasa;
  final int saldoAwalPlus;
  final int topUpKeBiasa;
  final int pindahKePlus;
  final int pindahDariPlus;
  final int pengeluaranBiasa;
  final int pengeluaranPlus;
  final int rewardAktual;
  final int saldoAkhirBiasa;
  final int saldoAkhirPlus;
  final DateTime dibuatPada;
  const DanaBalanceLedger({
    required this.id,
    required this.tahun,
    required this.bulan,
    required this.saldoAwalBiasa,
    required this.saldoAwalPlus,
    required this.topUpKeBiasa,
    required this.pindahKePlus,
    required this.pindahDariPlus,
    required this.pengeluaranBiasa,
    required this.pengeluaranPlus,
    required this.rewardAktual,
    required this.saldoAkhirBiasa,
    required this.saldoAkhirPlus,
    required this.dibuatPada,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['tahun'] = Variable<int>(tahun);
    map['bulan'] = Variable<int>(bulan);
    map['saldo_awal_biasa'] = Variable<int>(saldoAwalBiasa);
    map['saldo_awal_plus'] = Variable<int>(saldoAwalPlus);
    map['top_up_ke_biasa'] = Variable<int>(topUpKeBiasa);
    map['pindah_ke_plus'] = Variable<int>(pindahKePlus);
    map['pindah_dari_plus'] = Variable<int>(pindahDariPlus);
    map['pengeluaran_biasa'] = Variable<int>(pengeluaranBiasa);
    map['pengeluaran_plus'] = Variable<int>(pengeluaranPlus);
    map['reward_aktual'] = Variable<int>(rewardAktual);
    map['saldo_akhir_biasa'] = Variable<int>(saldoAkhirBiasa);
    map['saldo_akhir_plus'] = Variable<int>(saldoAkhirPlus);
    map['dibuat_pada'] = Variable<DateTime>(dibuatPada);
    return map;
  }

  DanaBalanceLedgersCompanion toCompanion(bool nullToAbsent) {
    return DanaBalanceLedgersCompanion(
      id: Value(id),
      tahun: Value(tahun),
      bulan: Value(bulan),
      saldoAwalBiasa: Value(saldoAwalBiasa),
      saldoAwalPlus: Value(saldoAwalPlus),
      topUpKeBiasa: Value(topUpKeBiasa),
      pindahKePlus: Value(pindahKePlus),
      pindahDariPlus: Value(pindahDariPlus),
      pengeluaranBiasa: Value(pengeluaranBiasa),
      pengeluaranPlus: Value(pengeluaranPlus),
      rewardAktual: Value(rewardAktual),
      saldoAkhirBiasa: Value(saldoAkhirBiasa),
      saldoAkhirPlus: Value(saldoAkhirPlus),
      dibuatPada: Value(dibuatPada),
    );
  }

  factory DanaBalanceLedger.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DanaBalanceLedger(
      id: serializer.fromJson<int>(json['id']),
      tahun: serializer.fromJson<int>(json['tahun']),
      bulan: serializer.fromJson<int>(json['bulan']),
      saldoAwalBiasa: serializer.fromJson<int>(json['saldoAwalBiasa']),
      saldoAwalPlus: serializer.fromJson<int>(json['saldoAwalPlus']),
      topUpKeBiasa: serializer.fromJson<int>(json['topUpKeBiasa']),
      pindahKePlus: serializer.fromJson<int>(json['pindahKePlus']),
      pindahDariPlus: serializer.fromJson<int>(json['pindahDariPlus']),
      pengeluaranBiasa: serializer.fromJson<int>(json['pengeluaranBiasa']),
      pengeluaranPlus: serializer.fromJson<int>(json['pengeluaranPlus']),
      rewardAktual: serializer.fromJson<int>(json['rewardAktual']),
      saldoAkhirBiasa: serializer.fromJson<int>(json['saldoAkhirBiasa']),
      saldoAkhirPlus: serializer.fromJson<int>(json['saldoAkhirPlus']),
      dibuatPada: serializer.fromJson<DateTime>(json['dibuatPada']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tahun': serializer.toJson<int>(tahun),
      'bulan': serializer.toJson<int>(bulan),
      'saldoAwalBiasa': serializer.toJson<int>(saldoAwalBiasa),
      'saldoAwalPlus': serializer.toJson<int>(saldoAwalPlus),
      'topUpKeBiasa': serializer.toJson<int>(topUpKeBiasa),
      'pindahKePlus': serializer.toJson<int>(pindahKePlus),
      'pindahDariPlus': serializer.toJson<int>(pindahDariPlus),
      'pengeluaranBiasa': serializer.toJson<int>(pengeluaranBiasa),
      'pengeluaranPlus': serializer.toJson<int>(pengeluaranPlus),
      'rewardAktual': serializer.toJson<int>(rewardAktual),
      'saldoAkhirBiasa': serializer.toJson<int>(saldoAkhirBiasa),
      'saldoAkhirPlus': serializer.toJson<int>(saldoAkhirPlus),
      'dibuatPada': serializer.toJson<DateTime>(dibuatPada),
    };
  }

  DanaBalanceLedger copyWith({
    int? id,
    int? tahun,
    int? bulan,
    int? saldoAwalBiasa,
    int? saldoAwalPlus,
    int? topUpKeBiasa,
    int? pindahKePlus,
    int? pindahDariPlus,
    int? pengeluaranBiasa,
    int? pengeluaranPlus,
    int? rewardAktual,
    int? saldoAkhirBiasa,
    int? saldoAkhirPlus,
    DateTime? dibuatPada,
  }) => DanaBalanceLedger(
    id: id ?? this.id,
    tahun: tahun ?? this.tahun,
    bulan: bulan ?? this.bulan,
    saldoAwalBiasa: saldoAwalBiasa ?? this.saldoAwalBiasa,
    saldoAwalPlus: saldoAwalPlus ?? this.saldoAwalPlus,
    topUpKeBiasa: topUpKeBiasa ?? this.topUpKeBiasa,
    pindahKePlus: pindahKePlus ?? this.pindahKePlus,
    pindahDariPlus: pindahDariPlus ?? this.pindahDariPlus,
    pengeluaranBiasa: pengeluaranBiasa ?? this.pengeluaranBiasa,
    pengeluaranPlus: pengeluaranPlus ?? this.pengeluaranPlus,
    rewardAktual: rewardAktual ?? this.rewardAktual,
    saldoAkhirBiasa: saldoAkhirBiasa ?? this.saldoAkhirBiasa,
    saldoAkhirPlus: saldoAkhirPlus ?? this.saldoAkhirPlus,
    dibuatPada: dibuatPada ?? this.dibuatPada,
  );
  DanaBalanceLedger copyWithCompanion(DanaBalanceLedgersCompanion data) {
    return DanaBalanceLedger(
      id: data.id.present ? data.id.value : this.id,
      tahun: data.tahun.present ? data.tahun.value : this.tahun,
      bulan: data.bulan.present ? data.bulan.value : this.bulan,
      saldoAwalBiasa: data.saldoAwalBiasa.present
          ? data.saldoAwalBiasa.value
          : this.saldoAwalBiasa,
      saldoAwalPlus: data.saldoAwalPlus.present
          ? data.saldoAwalPlus.value
          : this.saldoAwalPlus,
      topUpKeBiasa: data.topUpKeBiasa.present
          ? data.topUpKeBiasa.value
          : this.topUpKeBiasa,
      pindahKePlus: data.pindahKePlus.present
          ? data.pindahKePlus.value
          : this.pindahKePlus,
      pindahDariPlus: data.pindahDariPlus.present
          ? data.pindahDariPlus.value
          : this.pindahDariPlus,
      pengeluaranBiasa: data.pengeluaranBiasa.present
          ? data.pengeluaranBiasa.value
          : this.pengeluaranBiasa,
      pengeluaranPlus: data.pengeluaranPlus.present
          ? data.pengeluaranPlus.value
          : this.pengeluaranPlus,
      rewardAktual: data.rewardAktual.present
          ? data.rewardAktual.value
          : this.rewardAktual,
      saldoAkhirBiasa: data.saldoAkhirBiasa.present
          ? data.saldoAkhirBiasa.value
          : this.saldoAkhirBiasa,
      saldoAkhirPlus: data.saldoAkhirPlus.present
          ? data.saldoAkhirPlus.value
          : this.saldoAkhirPlus,
      dibuatPada: data.dibuatPada.present
          ? data.dibuatPada.value
          : this.dibuatPada,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DanaBalanceLedger(')
          ..write('id: $id, ')
          ..write('tahun: $tahun, ')
          ..write('bulan: $bulan, ')
          ..write('saldoAwalBiasa: $saldoAwalBiasa, ')
          ..write('saldoAwalPlus: $saldoAwalPlus, ')
          ..write('topUpKeBiasa: $topUpKeBiasa, ')
          ..write('pindahKePlus: $pindahKePlus, ')
          ..write('pindahDariPlus: $pindahDariPlus, ')
          ..write('pengeluaranBiasa: $pengeluaranBiasa, ')
          ..write('pengeluaranPlus: $pengeluaranPlus, ')
          ..write('rewardAktual: $rewardAktual, ')
          ..write('saldoAkhirBiasa: $saldoAkhirBiasa, ')
          ..write('saldoAkhirPlus: $saldoAkhirPlus, ')
          ..write('dibuatPada: $dibuatPada')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    tahun,
    bulan,
    saldoAwalBiasa,
    saldoAwalPlus,
    topUpKeBiasa,
    pindahKePlus,
    pindahDariPlus,
    pengeluaranBiasa,
    pengeluaranPlus,
    rewardAktual,
    saldoAkhirBiasa,
    saldoAkhirPlus,
    dibuatPada,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DanaBalanceLedger &&
          other.id == this.id &&
          other.tahun == this.tahun &&
          other.bulan == this.bulan &&
          other.saldoAwalBiasa == this.saldoAwalBiasa &&
          other.saldoAwalPlus == this.saldoAwalPlus &&
          other.topUpKeBiasa == this.topUpKeBiasa &&
          other.pindahKePlus == this.pindahKePlus &&
          other.pindahDariPlus == this.pindahDariPlus &&
          other.pengeluaranBiasa == this.pengeluaranBiasa &&
          other.pengeluaranPlus == this.pengeluaranPlus &&
          other.rewardAktual == this.rewardAktual &&
          other.saldoAkhirBiasa == this.saldoAkhirBiasa &&
          other.saldoAkhirPlus == this.saldoAkhirPlus &&
          other.dibuatPada == this.dibuatPada);
}

class DanaBalanceLedgersCompanion extends UpdateCompanion<DanaBalanceLedger> {
  final Value<int> id;
  final Value<int> tahun;
  final Value<int> bulan;
  final Value<int> saldoAwalBiasa;
  final Value<int> saldoAwalPlus;
  final Value<int> topUpKeBiasa;
  final Value<int> pindahKePlus;
  final Value<int> pindahDariPlus;
  final Value<int> pengeluaranBiasa;
  final Value<int> pengeluaranPlus;
  final Value<int> rewardAktual;
  final Value<int> saldoAkhirBiasa;
  final Value<int> saldoAkhirPlus;
  final Value<DateTime> dibuatPada;
  const DanaBalanceLedgersCompanion({
    this.id = const Value.absent(),
    this.tahun = const Value.absent(),
    this.bulan = const Value.absent(),
    this.saldoAwalBiasa = const Value.absent(),
    this.saldoAwalPlus = const Value.absent(),
    this.topUpKeBiasa = const Value.absent(),
    this.pindahKePlus = const Value.absent(),
    this.pindahDariPlus = const Value.absent(),
    this.pengeluaranBiasa = const Value.absent(),
    this.pengeluaranPlus = const Value.absent(),
    this.rewardAktual = const Value.absent(),
    this.saldoAkhirBiasa = const Value.absent(),
    this.saldoAkhirPlus = const Value.absent(),
    this.dibuatPada = const Value.absent(),
  });
  DanaBalanceLedgersCompanion.insert({
    this.id = const Value.absent(),
    required int tahun,
    required int bulan,
    required int saldoAwalBiasa,
    required int saldoAwalPlus,
    required int topUpKeBiasa,
    required int pindahKePlus,
    required int pindahDariPlus,
    required int pengeluaranBiasa,
    required int pengeluaranPlus,
    required int rewardAktual,
    required int saldoAkhirBiasa,
    required int saldoAkhirPlus,
    required DateTime dibuatPada,
  }) : tahun = Value(tahun),
       bulan = Value(bulan),
       saldoAwalBiasa = Value(saldoAwalBiasa),
       saldoAwalPlus = Value(saldoAwalPlus),
       topUpKeBiasa = Value(topUpKeBiasa),
       pindahKePlus = Value(pindahKePlus),
       pindahDariPlus = Value(pindahDariPlus),
       pengeluaranBiasa = Value(pengeluaranBiasa),
       pengeluaranPlus = Value(pengeluaranPlus),
       rewardAktual = Value(rewardAktual),
       saldoAkhirBiasa = Value(saldoAkhirBiasa),
       saldoAkhirPlus = Value(saldoAkhirPlus),
       dibuatPada = Value(dibuatPada);
  static Insertable<DanaBalanceLedger> custom({
    Expression<int>? id,
    Expression<int>? tahun,
    Expression<int>? bulan,
    Expression<int>? saldoAwalBiasa,
    Expression<int>? saldoAwalPlus,
    Expression<int>? topUpKeBiasa,
    Expression<int>? pindahKePlus,
    Expression<int>? pindahDariPlus,
    Expression<int>? pengeluaranBiasa,
    Expression<int>? pengeluaranPlus,
    Expression<int>? rewardAktual,
    Expression<int>? saldoAkhirBiasa,
    Expression<int>? saldoAkhirPlus,
    Expression<DateTime>? dibuatPada,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tahun != null) 'tahun': tahun,
      if (bulan != null) 'bulan': bulan,
      if (saldoAwalBiasa != null) 'saldo_awal_biasa': saldoAwalBiasa,
      if (saldoAwalPlus != null) 'saldo_awal_plus': saldoAwalPlus,
      if (topUpKeBiasa != null) 'top_up_ke_biasa': topUpKeBiasa,
      if (pindahKePlus != null) 'pindah_ke_plus': pindahKePlus,
      if (pindahDariPlus != null) 'pindah_dari_plus': pindahDariPlus,
      if (pengeluaranBiasa != null) 'pengeluaran_biasa': pengeluaranBiasa,
      if (pengeluaranPlus != null) 'pengeluaran_plus': pengeluaranPlus,
      if (rewardAktual != null) 'reward_aktual': rewardAktual,
      if (saldoAkhirBiasa != null) 'saldo_akhir_biasa': saldoAkhirBiasa,
      if (saldoAkhirPlus != null) 'saldo_akhir_plus': saldoAkhirPlus,
      if (dibuatPada != null) 'dibuat_pada': dibuatPada,
    });
  }

  DanaBalanceLedgersCompanion copyWith({
    Value<int>? id,
    Value<int>? tahun,
    Value<int>? bulan,
    Value<int>? saldoAwalBiasa,
    Value<int>? saldoAwalPlus,
    Value<int>? topUpKeBiasa,
    Value<int>? pindahKePlus,
    Value<int>? pindahDariPlus,
    Value<int>? pengeluaranBiasa,
    Value<int>? pengeluaranPlus,
    Value<int>? rewardAktual,
    Value<int>? saldoAkhirBiasa,
    Value<int>? saldoAkhirPlus,
    Value<DateTime>? dibuatPada,
  }) {
    return DanaBalanceLedgersCompanion(
      id: id ?? this.id,
      tahun: tahun ?? this.tahun,
      bulan: bulan ?? this.bulan,
      saldoAwalBiasa: saldoAwalBiasa ?? this.saldoAwalBiasa,
      saldoAwalPlus: saldoAwalPlus ?? this.saldoAwalPlus,
      topUpKeBiasa: topUpKeBiasa ?? this.topUpKeBiasa,
      pindahKePlus: pindahKePlus ?? this.pindahKePlus,
      pindahDariPlus: pindahDariPlus ?? this.pindahDariPlus,
      pengeluaranBiasa: pengeluaranBiasa ?? this.pengeluaranBiasa,
      pengeluaranPlus: pengeluaranPlus ?? this.pengeluaranPlus,
      rewardAktual: rewardAktual ?? this.rewardAktual,
      saldoAkhirBiasa: saldoAkhirBiasa ?? this.saldoAkhirBiasa,
      saldoAkhirPlus: saldoAkhirPlus ?? this.saldoAkhirPlus,
      dibuatPada: dibuatPada ?? this.dibuatPada,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tahun.present) {
      map['tahun'] = Variable<int>(tahun.value);
    }
    if (bulan.present) {
      map['bulan'] = Variable<int>(bulan.value);
    }
    if (saldoAwalBiasa.present) {
      map['saldo_awal_biasa'] = Variable<int>(saldoAwalBiasa.value);
    }
    if (saldoAwalPlus.present) {
      map['saldo_awal_plus'] = Variable<int>(saldoAwalPlus.value);
    }
    if (topUpKeBiasa.present) {
      map['top_up_ke_biasa'] = Variable<int>(topUpKeBiasa.value);
    }
    if (pindahKePlus.present) {
      map['pindah_ke_plus'] = Variable<int>(pindahKePlus.value);
    }
    if (pindahDariPlus.present) {
      map['pindah_dari_plus'] = Variable<int>(pindahDariPlus.value);
    }
    if (pengeluaranBiasa.present) {
      map['pengeluaran_biasa'] = Variable<int>(pengeluaranBiasa.value);
    }
    if (pengeluaranPlus.present) {
      map['pengeluaran_plus'] = Variable<int>(pengeluaranPlus.value);
    }
    if (rewardAktual.present) {
      map['reward_aktual'] = Variable<int>(rewardAktual.value);
    }
    if (saldoAkhirBiasa.present) {
      map['saldo_akhir_biasa'] = Variable<int>(saldoAkhirBiasa.value);
    }
    if (saldoAkhirPlus.present) {
      map['saldo_akhir_plus'] = Variable<int>(saldoAkhirPlus.value);
    }
    if (dibuatPada.present) {
      map['dibuat_pada'] = Variable<DateTime>(dibuatPada.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DanaBalanceLedgersCompanion(')
          ..write('id: $id, ')
          ..write('tahun: $tahun, ')
          ..write('bulan: $bulan, ')
          ..write('saldoAwalBiasa: $saldoAwalBiasa, ')
          ..write('saldoAwalPlus: $saldoAwalPlus, ')
          ..write('topUpKeBiasa: $topUpKeBiasa, ')
          ..write('pindahKePlus: $pindahKePlus, ')
          ..write('pindahDariPlus: $pindahDariPlus, ')
          ..write('pengeluaranBiasa: $pengeluaranBiasa, ')
          ..write('pengeluaranPlus: $pengeluaranPlus, ')
          ..write('rewardAktual: $rewardAktual, ')
          ..write('saldoAkhirBiasa: $saldoAkhirBiasa, ')
          ..write('saldoAkhirPlus: $saldoAkhirPlus, ')
          ..write('dibuatPada: $dibuatPada')
          ..write(')'))
        .toString();
  }
}

class $InvestmentActualsTable extends InvestmentActuals
    with TableInfo<$InvestmentActualsTable, InvestmentActual> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InvestmentActualsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<InvestmentPlatform, String>
  platform =
      GeneratedColumn<String>(
        'platform',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<InvestmentPlatform>(
        $InvestmentActualsTable.$converterplatform,
      );
  static const VerificationMeta _tahunMeta = const VerificationMeta('tahun');
  @override
  late final GeneratedColumn<int> tahun = GeneratedColumn<int>(
    'tahun',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bulanMeta = const VerificationMeta('bulan');
  @override
  late final GeneratedColumn<int> bulan = GeneratedColumn<int>(
    'bulan',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _depositEksternalMeta = const VerificationMeta(
    'depositEksternal',
  );
  @override
  late final GeneratedColumn<int> depositEksternal = GeneratedColumn<int>(
    'deposit_eksternal',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _penarikanMeta = const VerificationMeta(
    'penarikan',
  );
  @override
  late final GeneratedColumn<int> penarikan = GeneratedColumn<int>(
    'penarikan',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pembelianBersihMeta = const VerificationMeta(
    'pembelianBersih',
  );
  @override
  late final GeneratedColumn<int> pembelianBersih = GeneratedColumn<int>(
    'pembelian_bersih',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _penjualanBersihMeta = const VerificationMeta(
    'penjualanBersih',
  );
  @override
  late final GeneratedColumn<int> penjualanBersih = GeneratedColumn<int>(
    'penjualan_bersih',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _saldoRdnAwalMeta = const VerificationMeta(
    'saldoRdnAwal',
  );
  @override
  late final GeneratedColumn<int> saldoRdnAwal = GeneratedColumn<int>(
    'saldo_rdn_awal',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _saldoRdnAkhirMeta = const VerificationMeta(
    'saldoRdnAkhir',
  );
  @override
  late final GeneratedColumn<int> saldoRdnAkhir = GeneratedColumn<int>(
    'saldo_rdn_akhir',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _biayaMeta = const VerificationMeta('biaya');
  @override
  late final GeneratedColumn<int> biaya = GeneratedColumn<int>(
    'biaya',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dividenMeta = const VerificationMeta(
    'dividen',
  );
  @override
  late final GeneratedColumn<int> dividen = GeneratedColumn<int>(
    'dividen',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nilaiPortofolioMeta = const VerificationMeta(
    'nilaiPortofolio',
  );
  @override
  late final GeneratedColumn<int> nilaiPortofolio = GeneratedColumn<int>(
    'nilai_portofolio',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _modalInvestasiMeta = const VerificationMeta(
    'modalInvestasi',
  );
  @override
  late final GeneratedColumn<int> modalInvestasi = GeneratedColumn<int>(
    'modal_investasi',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<VerificationStatus, String>
  verifikasi =
      GeneratedColumn<String>(
        'verifikasi',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<VerificationStatus>(
        $InvestmentActualsTable.$converterverifikasi,
      );
  static const VerificationMeta _catatanMeta = const VerificationMeta(
    'catatan',
  );
  @override
  late final GeneratedColumn<String> catatan = GeneratedColumn<String>(
    'catatan',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _diperbaruiPadaMeta = const VerificationMeta(
    'diperbaruiPada',
  );
  @override
  late final GeneratedColumn<DateTime> diperbaruiPada =
      GeneratedColumn<DateTime>(
        'diperbarui_pada',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    platform,
    tahun,
    bulan,
    depositEksternal,
    penarikan,
    pembelianBersih,
    penjualanBersih,
    saldoRdnAwal,
    saldoRdnAkhir,
    biaya,
    dividen,
    nilaiPortofolio,
    modalInvestasi,
    verifikasi,
    catatan,
    diperbaruiPada,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'investment_actuals';
  @override
  VerificationContext validateIntegrity(
    Insertable<InvestmentActual> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('tahun')) {
      context.handle(
        _tahunMeta,
        tahun.isAcceptableOrUnknown(data['tahun']!, _tahunMeta),
      );
    } else if (isInserting) {
      context.missing(_tahunMeta);
    }
    if (data.containsKey('bulan')) {
      context.handle(
        _bulanMeta,
        bulan.isAcceptableOrUnknown(data['bulan']!, _bulanMeta),
      );
    } else if (isInserting) {
      context.missing(_bulanMeta);
    }
    if (data.containsKey('deposit_eksternal')) {
      context.handle(
        _depositEksternalMeta,
        depositEksternal.isAcceptableOrUnknown(
          data['deposit_eksternal']!,
          _depositEksternalMeta,
        ),
      );
    }
    if (data.containsKey('penarikan')) {
      context.handle(
        _penarikanMeta,
        penarikan.isAcceptableOrUnknown(data['penarikan']!, _penarikanMeta),
      );
    }
    if (data.containsKey('pembelian_bersih')) {
      context.handle(
        _pembelianBersihMeta,
        pembelianBersih.isAcceptableOrUnknown(
          data['pembelian_bersih']!,
          _pembelianBersihMeta,
        ),
      );
    }
    if (data.containsKey('penjualan_bersih')) {
      context.handle(
        _penjualanBersihMeta,
        penjualanBersih.isAcceptableOrUnknown(
          data['penjualan_bersih']!,
          _penjualanBersihMeta,
        ),
      );
    }
    if (data.containsKey('saldo_rdn_awal')) {
      context.handle(
        _saldoRdnAwalMeta,
        saldoRdnAwal.isAcceptableOrUnknown(
          data['saldo_rdn_awal']!,
          _saldoRdnAwalMeta,
        ),
      );
    }
    if (data.containsKey('saldo_rdn_akhir')) {
      context.handle(
        _saldoRdnAkhirMeta,
        saldoRdnAkhir.isAcceptableOrUnknown(
          data['saldo_rdn_akhir']!,
          _saldoRdnAkhirMeta,
        ),
      );
    }
    if (data.containsKey('biaya')) {
      context.handle(
        _biayaMeta,
        biaya.isAcceptableOrUnknown(data['biaya']!, _biayaMeta),
      );
    }
    if (data.containsKey('dividen')) {
      context.handle(
        _dividenMeta,
        dividen.isAcceptableOrUnknown(data['dividen']!, _dividenMeta),
      );
    }
    if (data.containsKey('nilai_portofolio')) {
      context.handle(
        _nilaiPortofolioMeta,
        nilaiPortofolio.isAcceptableOrUnknown(
          data['nilai_portofolio']!,
          _nilaiPortofolioMeta,
        ),
      );
    }
    if (data.containsKey('modal_investasi')) {
      context.handle(
        _modalInvestasiMeta,
        modalInvestasi.isAcceptableOrUnknown(
          data['modal_investasi']!,
          _modalInvestasiMeta,
        ),
      );
    }
    if (data.containsKey('catatan')) {
      context.handle(
        _catatanMeta,
        catatan.isAcceptableOrUnknown(data['catatan']!, _catatanMeta),
      );
    }
    if (data.containsKey('diperbarui_pada')) {
      context.handle(
        _diperbaruiPadaMeta,
        diperbaruiPada.isAcceptableOrUnknown(
          data['diperbarui_pada']!,
          _diperbaruiPadaMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_diperbaruiPadaMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {platform, tahun, bulan},
  ];
  @override
  InvestmentActual map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InvestmentActual(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      platform: $InvestmentActualsTable.$converterplatform.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}platform'],
        )!,
      ),
      tahun: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tahun'],
      )!,
      bulan: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}bulan'],
      )!,
      depositEksternal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}deposit_eksternal'],
      ),
      penarikan: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}penarikan'],
      ),
      pembelianBersih: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pembelian_bersih'],
      ),
      penjualanBersih: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}penjualan_bersih'],
      ),
      saldoRdnAwal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}saldo_rdn_awal'],
      ),
      saldoRdnAkhir: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}saldo_rdn_akhir'],
      ),
      biaya: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}biaya'],
      ),
      dividen: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}dividen'],
      ),
      nilaiPortofolio: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}nilai_portofolio'],
      ),
      modalInvestasi: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}modal_investasi'],
      ),
      verifikasi: $InvestmentActualsTable.$converterverifikasi.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}verifikasi'],
        )!,
      ),
      catatan: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}catatan'],
      ),
      diperbaruiPada: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}diperbarui_pada'],
      )!,
    );
  }

  @override
  $InvestmentActualsTable createAlias(String alias) {
    return $InvestmentActualsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<InvestmentPlatform, String, String>
  $converterplatform = const EnumNameConverter<InvestmentPlatform>(
    InvestmentPlatform.values,
  );
  static JsonTypeConverter2<VerificationStatus, String, String>
  $converterverifikasi = const EnumNameConverter<VerificationStatus>(
    VerificationStatus.values,
  );
}

class InvestmentActual extends DataClass
    implements Insertable<InvestmentActual> {
  final int id;
  final InvestmentPlatform platform;
  final int tahun;
  final int bulan;
  final int? depositEksternal;
  final int? penarikan;
  final int? pembelianBersih;
  final int? penjualanBersih;
  final int? saldoRdnAwal;
  final int? saldoRdnAkhir;
  final int? biaya;
  final int? dividen;
  final int? nilaiPortofolio;
  final int? modalInvestasi;
  final VerificationStatus verifikasi;
  final String? catatan;
  final DateTime diperbaruiPada;
  const InvestmentActual({
    required this.id,
    required this.platform,
    required this.tahun,
    required this.bulan,
    this.depositEksternal,
    this.penarikan,
    this.pembelianBersih,
    this.penjualanBersih,
    this.saldoRdnAwal,
    this.saldoRdnAkhir,
    this.biaya,
    this.dividen,
    this.nilaiPortofolio,
    this.modalInvestasi,
    required this.verifikasi,
    this.catatan,
    required this.diperbaruiPada,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['platform'] = Variable<String>(
        $InvestmentActualsTable.$converterplatform.toSql(platform),
      );
    }
    map['tahun'] = Variable<int>(tahun);
    map['bulan'] = Variable<int>(bulan);
    if (!nullToAbsent || depositEksternal != null) {
      map['deposit_eksternal'] = Variable<int>(depositEksternal);
    }
    if (!nullToAbsent || penarikan != null) {
      map['penarikan'] = Variable<int>(penarikan);
    }
    if (!nullToAbsent || pembelianBersih != null) {
      map['pembelian_bersih'] = Variable<int>(pembelianBersih);
    }
    if (!nullToAbsent || penjualanBersih != null) {
      map['penjualan_bersih'] = Variable<int>(penjualanBersih);
    }
    if (!nullToAbsent || saldoRdnAwal != null) {
      map['saldo_rdn_awal'] = Variable<int>(saldoRdnAwal);
    }
    if (!nullToAbsent || saldoRdnAkhir != null) {
      map['saldo_rdn_akhir'] = Variable<int>(saldoRdnAkhir);
    }
    if (!nullToAbsent || biaya != null) {
      map['biaya'] = Variable<int>(biaya);
    }
    if (!nullToAbsent || dividen != null) {
      map['dividen'] = Variable<int>(dividen);
    }
    if (!nullToAbsent || nilaiPortofolio != null) {
      map['nilai_portofolio'] = Variable<int>(nilaiPortofolio);
    }
    if (!nullToAbsent || modalInvestasi != null) {
      map['modal_investasi'] = Variable<int>(modalInvestasi);
    }
    {
      map['verifikasi'] = Variable<String>(
        $InvestmentActualsTable.$converterverifikasi.toSql(verifikasi),
      );
    }
    if (!nullToAbsent || catatan != null) {
      map['catatan'] = Variable<String>(catatan);
    }
    map['diperbarui_pada'] = Variable<DateTime>(diperbaruiPada);
    return map;
  }

  InvestmentActualsCompanion toCompanion(bool nullToAbsent) {
    return InvestmentActualsCompanion(
      id: Value(id),
      platform: Value(platform),
      tahun: Value(tahun),
      bulan: Value(bulan),
      depositEksternal: depositEksternal == null && nullToAbsent
          ? const Value.absent()
          : Value(depositEksternal),
      penarikan: penarikan == null && nullToAbsent
          ? const Value.absent()
          : Value(penarikan),
      pembelianBersih: pembelianBersih == null && nullToAbsent
          ? const Value.absent()
          : Value(pembelianBersih),
      penjualanBersih: penjualanBersih == null && nullToAbsent
          ? const Value.absent()
          : Value(penjualanBersih),
      saldoRdnAwal: saldoRdnAwal == null && nullToAbsent
          ? const Value.absent()
          : Value(saldoRdnAwal),
      saldoRdnAkhir: saldoRdnAkhir == null && nullToAbsent
          ? const Value.absent()
          : Value(saldoRdnAkhir),
      biaya: biaya == null && nullToAbsent
          ? const Value.absent()
          : Value(biaya),
      dividen: dividen == null && nullToAbsent
          ? const Value.absent()
          : Value(dividen),
      nilaiPortofolio: nilaiPortofolio == null && nullToAbsent
          ? const Value.absent()
          : Value(nilaiPortofolio),
      modalInvestasi: modalInvestasi == null && nullToAbsent
          ? const Value.absent()
          : Value(modalInvestasi),
      verifikasi: Value(verifikasi),
      catatan: catatan == null && nullToAbsent
          ? const Value.absent()
          : Value(catatan),
      diperbaruiPada: Value(diperbaruiPada),
    );
  }

  factory InvestmentActual.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InvestmentActual(
      id: serializer.fromJson<int>(json['id']),
      platform: $InvestmentActualsTable.$converterplatform.fromJson(
        serializer.fromJson<String>(json['platform']),
      ),
      tahun: serializer.fromJson<int>(json['tahun']),
      bulan: serializer.fromJson<int>(json['bulan']),
      depositEksternal: serializer.fromJson<int?>(json['depositEksternal']),
      penarikan: serializer.fromJson<int?>(json['penarikan']),
      pembelianBersih: serializer.fromJson<int?>(json['pembelianBersih']),
      penjualanBersih: serializer.fromJson<int?>(json['penjualanBersih']),
      saldoRdnAwal: serializer.fromJson<int?>(json['saldoRdnAwal']),
      saldoRdnAkhir: serializer.fromJson<int?>(json['saldoRdnAkhir']),
      biaya: serializer.fromJson<int?>(json['biaya']),
      dividen: serializer.fromJson<int?>(json['dividen']),
      nilaiPortofolio: serializer.fromJson<int?>(json['nilaiPortofolio']),
      modalInvestasi: serializer.fromJson<int?>(json['modalInvestasi']),
      verifikasi: $InvestmentActualsTable.$converterverifikasi.fromJson(
        serializer.fromJson<String>(json['verifikasi']),
      ),
      catatan: serializer.fromJson<String?>(json['catatan']),
      diperbaruiPada: serializer.fromJson<DateTime>(json['diperbaruiPada']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'platform': serializer.toJson<String>(
        $InvestmentActualsTable.$converterplatform.toJson(platform),
      ),
      'tahun': serializer.toJson<int>(tahun),
      'bulan': serializer.toJson<int>(bulan),
      'depositEksternal': serializer.toJson<int?>(depositEksternal),
      'penarikan': serializer.toJson<int?>(penarikan),
      'pembelianBersih': serializer.toJson<int?>(pembelianBersih),
      'penjualanBersih': serializer.toJson<int?>(penjualanBersih),
      'saldoRdnAwal': serializer.toJson<int?>(saldoRdnAwal),
      'saldoRdnAkhir': serializer.toJson<int?>(saldoRdnAkhir),
      'biaya': serializer.toJson<int?>(biaya),
      'dividen': serializer.toJson<int?>(dividen),
      'nilaiPortofolio': serializer.toJson<int?>(nilaiPortofolio),
      'modalInvestasi': serializer.toJson<int?>(modalInvestasi),
      'verifikasi': serializer.toJson<String>(
        $InvestmentActualsTable.$converterverifikasi.toJson(verifikasi),
      ),
      'catatan': serializer.toJson<String?>(catatan),
      'diperbaruiPada': serializer.toJson<DateTime>(diperbaruiPada),
    };
  }

  InvestmentActual copyWith({
    int? id,
    InvestmentPlatform? platform,
    int? tahun,
    int? bulan,
    Value<int?> depositEksternal = const Value.absent(),
    Value<int?> penarikan = const Value.absent(),
    Value<int?> pembelianBersih = const Value.absent(),
    Value<int?> penjualanBersih = const Value.absent(),
    Value<int?> saldoRdnAwal = const Value.absent(),
    Value<int?> saldoRdnAkhir = const Value.absent(),
    Value<int?> biaya = const Value.absent(),
    Value<int?> dividen = const Value.absent(),
    Value<int?> nilaiPortofolio = const Value.absent(),
    Value<int?> modalInvestasi = const Value.absent(),
    VerificationStatus? verifikasi,
    Value<String?> catatan = const Value.absent(),
    DateTime? diperbaruiPada,
  }) => InvestmentActual(
    id: id ?? this.id,
    platform: platform ?? this.platform,
    tahun: tahun ?? this.tahun,
    bulan: bulan ?? this.bulan,
    depositEksternal: depositEksternal.present
        ? depositEksternal.value
        : this.depositEksternal,
    penarikan: penarikan.present ? penarikan.value : this.penarikan,
    pembelianBersih: pembelianBersih.present
        ? pembelianBersih.value
        : this.pembelianBersih,
    penjualanBersih: penjualanBersih.present
        ? penjualanBersih.value
        : this.penjualanBersih,
    saldoRdnAwal: saldoRdnAwal.present ? saldoRdnAwal.value : this.saldoRdnAwal,
    saldoRdnAkhir: saldoRdnAkhir.present
        ? saldoRdnAkhir.value
        : this.saldoRdnAkhir,
    biaya: biaya.present ? biaya.value : this.biaya,
    dividen: dividen.present ? dividen.value : this.dividen,
    nilaiPortofolio: nilaiPortofolio.present
        ? nilaiPortofolio.value
        : this.nilaiPortofolio,
    modalInvestasi: modalInvestasi.present
        ? modalInvestasi.value
        : this.modalInvestasi,
    verifikasi: verifikasi ?? this.verifikasi,
    catatan: catatan.present ? catatan.value : this.catatan,
    diperbaruiPada: diperbaruiPada ?? this.diperbaruiPada,
  );
  InvestmentActual copyWithCompanion(InvestmentActualsCompanion data) {
    return InvestmentActual(
      id: data.id.present ? data.id.value : this.id,
      platform: data.platform.present ? data.platform.value : this.platform,
      tahun: data.tahun.present ? data.tahun.value : this.tahun,
      bulan: data.bulan.present ? data.bulan.value : this.bulan,
      depositEksternal: data.depositEksternal.present
          ? data.depositEksternal.value
          : this.depositEksternal,
      penarikan: data.penarikan.present ? data.penarikan.value : this.penarikan,
      pembelianBersih: data.pembelianBersih.present
          ? data.pembelianBersih.value
          : this.pembelianBersih,
      penjualanBersih: data.penjualanBersih.present
          ? data.penjualanBersih.value
          : this.penjualanBersih,
      saldoRdnAwal: data.saldoRdnAwal.present
          ? data.saldoRdnAwal.value
          : this.saldoRdnAwal,
      saldoRdnAkhir: data.saldoRdnAkhir.present
          ? data.saldoRdnAkhir.value
          : this.saldoRdnAkhir,
      biaya: data.biaya.present ? data.biaya.value : this.biaya,
      dividen: data.dividen.present ? data.dividen.value : this.dividen,
      nilaiPortofolio: data.nilaiPortofolio.present
          ? data.nilaiPortofolio.value
          : this.nilaiPortofolio,
      modalInvestasi: data.modalInvestasi.present
          ? data.modalInvestasi.value
          : this.modalInvestasi,
      verifikasi: data.verifikasi.present
          ? data.verifikasi.value
          : this.verifikasi,
      catatan: data.catatan.present ? data.catatan.value : this.catatan,
      diperbaruiPada: data.diperbaruiPada.present
          ? data.diperbaruiPada.value
          : this.diperbaruiPada,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InvestmentActual(')
          ..write('id: $id, ')
          ..write('platform: $platform, ')
          ..write('tahun: $tahun, ')
          ..write('bulan: $bulan, ')
          ..write('depositEksternal: $depositEksternal, ')
          ..write('penarikan: $penarikan, ')
          ..write('pembelianBersih: $pembelianBersih, ')
          ..write('penjualanBersih: $penjualanBersih, ')
          ..write('saldoRdnAwal: $saldoRdnAwal, ')
          ..write('saldoRdnAkhir: $saldoRdnAkhir, ')
          ..write('biaya: $biaya, ')
          ..write('dividen: $dividen, ')
          ..write('nilaiPortofolio: $nilaiPortofolio, ')
          ..write('modalInvestasi: $modalInvestasi, ')
          ..write('verifikasi: $verifikasi, ')
          ..write('catatan: $catatan, ')
          ..write('diperbaruiPada: $diperbaruiPada')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    platform,
    tahun,
    bulan,
    depositEksternal,
    penarikan,
    pembelianBersih,
    penjualanBersih,
    saldoRdnAwal,
    saldoRdnAkhir,
    biaya,
    dividen,
    nilaiPortofolio,
    modalInvestasi,
    verifikasi,
    catatan,
    diperbaruiPada,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InvestmentActual &&
          other.id == this.id &&
          other.platform == this.platform &&
          other.tahun == this.tahun &&
          other.bulan == this.bulan &&
          other.depositEksternal == this.depositEksternal &&
          other.penarikan == this.penarikan &&
          other.pembelianBersih == this.pembelianBersih &&
          other.penjualanBersih == this.penjualanBersih &&
          other.saldoRdnAwal == this.saldoRdnAwal &&
          other.saldoRdnAkhir == this.saldoRdnAkhir &&
          other.biaya == this.biaya &&
          other.dividen == this.dividen &&
          other.nilaiPortofolio == this.nilaiPortofolio &&
          other.modalInvestasi == this.modalInvestasi &&
          other.verifikasi == this.verifikasi &&
          other.catatan == this.catatan &&
          other.diperbaruiPada == this.diperbaruiPada);
}

class InvestmentActualsCompanion extends UpdateCompanion<InvestmentActual> {
  final Value<int> id;
  final Value<InvestmentPlatform> platform;
  final Value<int> tahun;
  final Value<int> bulan;
  final Value<int?> depositEksternal;
  final Value<int?> penarikan;
  final Value<int?> pembelianBersih;
  final Value<int?> penjualanBersih;
  final Value<int?> saldoRdnAwal;
  final Value<int?> saldoRdnAkhir;
  final Value<int?> biaya;
  final Value<int?> dividen;
  final Value<int?> nilaiPortofolio;
  final Value<int?> modalInvestasi;
  final Value<VerificationStatus> verifikasi;
  final Value<String?> catatan;
  final Value<DateTime> diperbaruiPada;
  const InvestmentActualsCompanion({
    this.id = const Value.absent(),
    this.platform = const Value.absent(),
    this.tahun = const Value.absent(),
    this.bulan = const Value.absent(),
    this.depositEksternal = const Value.absent(),
    this.penarikan = const Value.absent(),
    this.pembelianBersih = const Value.absent(),
    this.penjualanBersih = const Value.absent(),
    this.saldoRdnAwal = const Value.absent(),
    this.saldoRdnAkhir = const Value.absent(),
    this.biaya = const Value.absent(),
    this.dividen = const Value.absent(),
    this.nilaiPortofolio = const Value.absent(),
    this.modalInvestasi = const Value.absent(),
    this.verifikasi = const Value.absent(),
    this.catatan = const Value.absent(),
    this.diperbaruiPada = const Value.absent(),
  });
  InvestmentActualsCompanion.insert({
    this.id = const Value.absent(),
    required InvestmentPlatform platform,
    required int tahun,
    required int bulan,
    this.depositEksternal = const Value.absent(),
    this.penarikan = const Value.absent(),
    this.pembelianBersih = const Value.absent(),
    this.penjualanBersih = const Value.absent(),
    this.saldoRdnAwal = const Value.absent(),
    this.saldoRdnAkhir = const Value.absent(),
    this.biaya = const Value.absent(),
    this.dividen = const Value.absent(),
    this.nilaiPortofolio = const Value.absent(),
    this.modalInvestasi = const Value.absent(),
    required VerificationStatus verifikasi,
    this.catatan = const Value.absent(),
    required DateTime diperbaruiPada,
  }) : platform = Value(platform),
       tahun = Value(tahun),
       bulan = Value(bulan),
       verifikasi = Value(verifikasi),
       diperbaruiPada = Value(diperbaruiPada);
  static Insertable<InvestmentActual> custom({
    Expression<int>? id,
    Expression<String>? platform,
    Expression<int>? tahun,
    Expression<int>? bulan,
    Expression<int>? depositEksternal,
    Expression<int>? penarikan,
    Expression<int>? pembelianBersih,
    Expression<int>? penjualanBersih,
    Expression<int>? saldoRdnAwal,
    Expression<int>? saldoRdnAkhir,
    Expression<int>? biaya,
    Expression<int>? dividen,
    Expression<int>? nilaiPortofolio,
    Expression<int>? modalInvestasi,
    Expression<String>? verifikasi,
    Expression<String>? catatan,
    Expression<DateTime>? diperbaruiPada,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (platform != null) 'platform': platform,
      if (tahun != null) 'tahun': tahun,
      if (bulan != null) 'bulan': bulan,
      if (depositEksternal != null) 'deposit_eksternal': depositEksternal,
      if (penarikan != null) 'penarikan': penarikan,
      if (pembelianBersih != null) 'pembelian_bersih': pembelianBersih,
      if (penjualanBersih != null) 'penjualan_bersih': penjualanBersih,
      if (saldoRdnAwal != null) 'saldo_rdn_awal': saldoRdnAwal,
      if (saldoRdnAkhir != null) 'saldo_rdn_akhir': saldoRdnAkhir,
      if (biaya != null) 'biaya': biaya,
      if (dividen != null) 'dividen': dividen,
      if (nilaiPortofolio != null) 'nilai_portofolio': nilaiPortofolio,
      if (modalInvestasi != null) 'modal_investasi': modalInvestasi,
      if (verifikasi != null) 'verifikasi': verifikasi,
      if (catatan != null) 'catatan': catatan,
      if (diperbaruiPada != null) 'diperbarui_pada': diperbaruiPada,
    });
  }

  InvestmentActualsCompanion copyWith({
    Value<int>? id,
    Value<InvestmentPlatform>? platform,
    Value<int>? tahun,
    Value<int>? bulan,
    Value<int?>? depositEksternal,
    Value<int?>? penarikan,
    Value<int?>? pembelianBersih,
    Value<int?>? penjualanBersih,
    Value<int?>? saldoRdnAwal,
    Value<int?>? saldoRdnAkhir,
    Value<int?>? biaya,
    Value<int?>? dividen,
    Value<int?>? nilaiPortofolio,
    Value<int?>? modalInvestasi,
    Value<VerificationStatus>? verifikasi,
    Value<String?>? catatan,
    Value<DateTime>? diperbaruiPada,
  }) {
    return InvestmentActualsCompanion(
      id: id ?? this.id,
      platform: platform ?? this.platform,
      tahun: tahun ?? this.tahun,
      bulan: bulan ?? this.bulan,
      depositEksternal: depositEksternal ?? this.depositEksternal,
      penarikan: penarikan ?? this.penarikan,
      pembelianBersih: pembelianBersih ?? this.pembelianBersih,
      penjualanBersih: penjualanBersih ?? this.penjualanBersih,
      saldoRdnAwal: saldoRdnAwal ?? this.saldoRdnAwal,
      saldoRdnAkhir: saldoRdnAkhir ?? this.saldoRdnAkhir,
      biaya: biaya ?? this.biaya,
      dividen: dividen ?? this.dividen,
      nilaiPortofolio: nilaiPortofolio ?? this.nilaiPortofolio,
      modalInvestasi: modalInvestasi ?? this.modalInvestasi,
      verifikasi: verifikasi ?? this.verifikasi,
      catatan: catatan ?? this.catatan,
      diperbaruiPada: diperbaruiPada ?? this.diperbaruiPada,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (platform.present) {
      map['platform'] = Variable<String>(
        $InvestmentActualsTable.$converterplatform.toSql(platform.value),
      );
    }
    if (tahun.present) {
      map['tahun'] = Variable<int>(tahun.value);
    }
    if (bulan.present) {
      map['bulan'] = Variable<int>(bulan.value);
    }
    if (depositEksternal.present) {
      map['deposit_eksternal'] = Variable<int>(depositEksternal.value);
    }
    if (penarikan.present) {
      map['penarikan'] = Variable<int>(penarikan.value);
    }
    if (pembelianBersih.present) {
      map['pembelian_bersih'] = Variable<int>(pembelianBersih.value);
    }
    if (penjualanBersih.present) {
      map['penjualan_bersih'] = Variable<int>(penjualanBersih.value);
    }
    if (saldoRdnAwal.present) {
      map['saldo_rdn_awal'] = Variable<int>(saldoRdnAwal.value);
    }
    if (saldoRdnAkhir.present) {
      map['saldo_rdn_akhir'] = Variable<int>(saldoRdnAkhir.value);
    }
    if (biaya.present) {
      map['biaya'] = Variable<int>(biaya.value);
    }
    if (dividen.present) {
      map['dividen'] = Variable<int>(dividen.value);
    }
    if (nilaiPortofolio.present) {
      map['nilai_portofolio'] = Variable<int>(nilaiPortofolio.value);
    }
    if (modalInvestasi.present) {
      map['modal_investasi'] = Variable<int>(modalInvestasi.value);
    }
    if (verifikasi.present) {
      map['verifikasi'] = Variable<String>(
        $InvestmentActualsTable.$converterverifikasi.toSql(verifikasi.value),
      );
    }
    if (catatan.present) {
      map['catatan'] = Variable<String>(catatan.value);
    }
    if (diperbaruiPada.present) {
      map['diperbarui_pada'] = Variable<DateTime>(diperbaruiPada.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InvestmentActualsCompanion(')
          ..write('id: $id, ')
          ..write('platform: $platform, ')
          ..write('tahun: $tahun, ')
          ..write('bulan: $bulan, ')
          ..write('depositEksternal: $depositEksternal, ')
          ..write('penarikan: $penarikan, ')
          ..write('pembelianBersih: $pembelianBersih, ')
          ..write('penjualanBersih: $penjualanBersih, ')
          ..write('saldoRdnAwal: $saldoRdnAwal, ')
          ..write('saldoRdnAkhir: $saldoRdnAkhir, ')
          ..write('biaya: $biaya, ')
          ..write('dividen: $dividen, ')
          ..write('nilaiPortofolio: $nilaiPortofolio, ')
          ..write('modalInvestasi: $modalInvestasi, ')
          ..write('verifikasi: $verifikasi, ')
          ..write('catatan: $catatan, ')
          ..write('diperbaruiPada: $diperbaruiPada')
          ..write(')'))
        .toString();
  }
}

class $ImportedReportsTable extends ImportedReports
    with TableInfo<$ImportedReportsTable, ImportedReport> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ImportedReportsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<InvestmentPlatform, String>
  platform = GeneratedColumn<String>(
    'platform',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<InvestmentPlatform>($ImportedReportsTable.$converterplatform);
  static const VerificationMeta _jenisMeta = const VerificationMeta('jenis');
  @override
  late final GeneratedColumn<String> jenis = GeneratedColumn<String>(
    'jenis',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tahunMeta = const VerificationMeta('tahun');
  @override
  late final GeneratedColumn<int> tahun = GeneratedColumn<int>(
    'tahun',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bulanMeta = const VerificationMeta('bulan');
  @override
  late final GeneratedColumn<int> bulan = GeneratedColumn<int>(
    'bulan',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fileHashMeta = const VerificationMeta(
    'fileHash',
  );
  @override
  late final GeneratedColumn<String> fileHash = GeneratedColumn<String>(
    'file_hash',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _namaFileMeta = const VerificationMeta(
    'namaFile',
  );
  @override
  late final GeneratedColumn<String> namaFile = GeneratedColumn<String>(
    'nama_file',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _diimporPadaMeta = const VerificationMeta(
    'diimporPada',
  );
  @override
  late final GeneratedColumn<DateTime> diimporPada = GeneratedColumn<DateTime>(
    'diimpor_pada',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    platform,
    jenis,
    tahun,
    bulan,
    fileHash,
    namaFile,
    diimporPada,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'imported_reports';
  @override
  VerificationContext validateIntegrity(
    Insertable<ImportedReport> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('jenis')) {
      context.handle(
        _jenisMeta,
        jenis.isAcceptableOrUnknown(data['jenis']!, _jenisMeta),
      );
    } else if (isInserting) {
      context.missing(_jenisMeta);
    }
    if (data.containsKey('tahun')) {
      context.handle(
        _tahunMeta,
        tahun.isAcceptableOrUnknown(data['tahun']!, _tahunMeta),
      );
    }
    if (data.containsKey('bulan')) {
      context.handle(
        _bulanMeta,
        bulan.isAcceptableOrUnknown(data['bulan']!, _bulanMeta),
      );
    }
    if (data.containsKey('file_hash')) {
      context.handle(
        _fileHashMeta,
        fileHash.isAcceptableOrUnknown(data['file_hash']!, _fileHashMeta),
      );
    } else if (isInserting) {
      context.missing(_fileHashMeta);
    }
    if (data.containsKey('nama_file')) {
      context.handle(
        _namaFileMeta,
        namaFile.isAcceptableOrUnknown(data['nama_file']!, _namaFileMeta),
      );
    } else if (isInserting) {
      context.missing(_namaFileMeta);
    }
    if (data.containsKey('diimpor_pada')) {
      context.handle(
        _diimporPadaMeta,
        diimporPada.isAcceptableOrUnknown(
          data['diimpor_pada']!,
          _diimporPadaMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_diimporPadaMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ImportedReport map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ImportedReport(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      platform: $ImportedReportsTable.$converterplatform.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}platform'],
        )!,
      ),
      jenis: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}jenis'],
      )!,
      tahun: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tahun'],
      ),
      bulan: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}bulan'],
      ),
      fileHash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_hash'],
      )!,
      namaFile: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nama_file'],
      )!,
      diimporPada: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}diimpor_pada'],
      )!,
    );
  }

  @override
  $ImportedReportsTable createAlias(String alias) {
    return $ImportedReportsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<InvestmentPlatform, String, String>
  $converterplatform = const EnumNameConverter<InvestmentPlatform>(
    InvestmentPlatform.values,
  );
}

class ImportedReport extends DataClass implements Insertable<ImportedReport> {
  final int id;
  final InvestmentPlatform platform;
  final String jenis;
  final int? tahun;
  final int? bulan;
  final String fileHash;
  final String namaFile;
  final DateTime diimporPada;
  const ImportedReport({
    required this.id,
    required this.platform,
    required this.jenis,
    this.tahun,
    this.bulan,
    required this.fileHash,
    required this.namaFile,
    required this.diimporPada,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['platform'] = Variable<String>(
        $ImportedReportsTable.$converterplatform.toSql(platform),
      );
    }
    map['jenis'] = Variable<String>(jenis);
    if (!nullToAbsent || tahun != null) {
      map['tahun'] = Variable<int>(tahun);
    }
    if (!nullToAbsent || bulan != null) {
      map['bulan'] = Variable<int>(bulan);
    }
    map['file_hash'] = Variable<String>(fileHash);
    map['nama_file'] = Variable<String>(namaFile);
    map['diimpor_pada'] = Variable<DateTime>(diimporPada);
    return map;
  }

  ImportedReportsCompanion toCompanion(bool nullToAbsent) {
    return ImportedReportsCompanion(
      id: Value(id),
      platform: Value(platform),
      jenis: Value(jenis),
      tahun: tahun == null && nullToAbsent
          ? const Value.absent()
          : Value(tahun),
      bulan: bulan == null && nullToAbsent
          ? const Value.absent()
          : Value(bulan),
      fileHash: Value(fileHash),
      namaFile: Value(namaFile),
      diimporPada: Value(diimporPada),
    );
  }

  factory ImportedReport.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ImportedReport(
      id: serializer.fromJson<int>(json['id']),
      platform: $ImportedReportsTable.$converterplatform.fromJson(
        serializer.fromJson<String>(json['platform']),
      ),
      jenis: serializer.fromJson<String>(json['jenis']),
      tahun: serializer.fromJson<int?>(json['tahun']),
      bulan: serializer.fromJson<int?>(json['bulan']),
      fileHash: serializer.fromJson<String>(json['fileHash']),
      namaFile: serializer.fromJson<String>(json['namaFile']),
      diimporPada: serializer.fromJson<DateTime>(json['diimporPada']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'platform': serializer.toJson<String>(
        $ImportedReportsTable.$converterplatform.toJson(platform),
      ),
      'jenis': serializer.toJson<String>(jenis),
      'tahun': serializer.toJson<int?>(tahun),
      'bulan': serializer.toJson<int?>(bulan),
      'fileHash': serializer.toJson<String>(fileHash),
      'namaFile': serializer.toJson<String>(namaFile),
      'diimporPada': serializer.toJson<DateTime>(diimporPada),
    };
  }

  ImportedReport copyWith({
    int? id,
    InvestmentPlatform? platform,
    String? jenis,
    Value<int?> tahun = const Value.absent(),
    Value<int?> bulan = const Value.absent(),
    String? fileHash,
    String? namaFile,
    DateTime? diimporPada,
  }) => ImportedReport(
    id: id ?? this.id,
    platform: platform ?? this.platform,
    jenis: jenis ?? this.jenis,
    tahun: tahun.present ? tahun.value : this.tahun,
    bulan: bulan.present ? bulan.value : this.bulan,
    fileHash: fileHash ?? this.fileHash,
    namaFile: namaFile ?? this.namaFile,
    diimporPada: diimporPada ?? this.diimporPada,
  );
  ImportedReport copyWithCompanion(ImportedReportsCompanion data) {
    return ImportedReport(
      id: data.id.present ? data.id.value : this.id,
      platform: data.platform.present ? data.platform.value : this.platform,
      jenis: data.jenis.present ? data.jenis.value : this.jenis,
      tahun: data.tahun.present ? data.tahun.value : this.tahun,
      bulan: data.bulan.present ? data.bulan.value : this.bulan,
      fileHash: data.fileHash.present ? data.fileHash.value : this.fileHash,
      namaFile: data.namaFile.present ? data.namaFile.value : this.namaFile,
      diimporPada: data.diimporPada.present
          ? data.diimporPada.value
          : this.diimporPada,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ImportedReport(')
          ..write('id: $id, ')
          ..write('platform: $platform, ')
          ..write('jenis: $jenis, ')
          ..write('tahun: $tahun, ')
          ..write('bulan: $bulan, ')
          ..write('fileHash: $fileHash, ')
          ..write('namaFile: $namaFile, ')
          ..write('diimporPada: $diimporPada')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    platform,
    jenis,
    tahun,
    bulan,
    fileHash,
    namaFile,
    diimporPada,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ImportedReport &&
          other.id == this.id &&
          other.platform == this.platform &&
          other.jenis == this.jenis &&
          other.tahun == this.tahun &&
          other.bulan == this.bulan &&
          other.fileHash == this.fileHash &&
          other.namaFile == this.namaFile &&
          other.diimporPada == this.diimporPada);
}

class ImportedReportsCompanion extends UpdateCompanion<ImportedReport> {
  final Value<int> id;
  final Value<InvestmentPlatform> platform;
  final Value<String> jenis;
  final Value<int?> tahun;
  final Value<int?> bulan;
  final Value<String> fileHash;
  final Value<String> namaFile;
  final Value<DateTime> diimporPada;
  const ImportedReportsCompanion({
    this.id = const Value.absent(),
    this.platform = const Value.absent(),
    this.jenis = const Value.absent(),
    this.tahun = const Value.absent(),
    this.bulan = const Value.absent(),
    this.fileHash = const Value.absent(),
    this.namaFile = const Value.absent(),
    this.diimporPada = const Value.absent(),
  });
  ImportedReportsCompanion.insert({
    this.id = const Value.absent(),
    required InvestmentPlatform platform,
    required String jenis,
    this.tahun = const Value.absent(),
    this.bulan = const Value.absent(),
    required String fileHash,
    required String namaFile,
    required DateTime diimporPada,
  }) : platform = Value(platform),
       jenis = Value(jenis),
       fileHash = Value(fileHash),
       namaFile = Value(namaFile),
       diimporPada = Value(diimporPada);
  static Insertable<ImportedReport> custom({
    Expression<int>? id,
    Expression<String>? platform,
    Expression<String>? jenis,
    Expression<int>? tahun,
    Expression<int>? bulan,
    Expression<String>? fileHash,
    Expression<String>? namaFile,
    Expression<DateTime>? diimporPada,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (platform != null) 'platform': platform,
      if (jenis != null) 'jenis': jenis,
      if (tahun != null) 'tahun': tahun,
      if (bulan != null) 'bulan': bulan,
      if (fileHash != null) 'file_hash': fileHash,
      if (namaFile != null) 'nama_file': namaFile,
      if (diimporPada != null) 'diimpor_pada': diimporPada,
    });
  }

  ImportedReportsCompanion copyWith({
    Value<int>? id,
    Value<InvestmentPlatform>? platform,
    Value<String>? jenis,
    Value<int?>? tahun,
    Value<int?>? bulan,
    Value<String>? fileHash,
    Value<String>? namaFile,
    Value<DateTime>? diimporPada,
  }) {
    return ImportedReportsCompanion(
      id: id ?? this.id,
      platform: platform ?? this.platform,
      jenis: jenis ?? this.jenis,
      tahun: tahun ?? this.tahun,
      bulan: bulan ?? this.bulan,
      fileHash: fileHash ?? this.fileHash,
      namaFile: namaFile ?? this.namaFile,
      diimporPada: diimporPada ?? this.diimporPada,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (platform.present) {
      map['platform'] = Variable<String>(
        $ImportedReportsTable.$converterplatform.toSql(platform.value),
      );
    }
    if (jenis.present) {
      map['jenis'] = Variable<String>(jenis.value);
    }
    if (tahun.present) {
      map['tahun'] = Variable<int>(tahun.value);
    }
    if (bulan.present) {
      map['bulan'] = Variable<int>(bulan.value);
    }
    if (fileHash.present) {
      map['file_hash'] = Variable<String>(fileHash.value);
    }
    if (namaFile.present) {
      map['nama_file'] = Variable<String>(namaFile.value);
    }
    if (diimporPada.present) {
      map['diimpor_pada'] = Variable<DateTime>(diimporPada.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ImportedReportsCompanion(')
          ..write('id: $id, ')
          ..write('platform: $platform, ')
          ..write('jenis: $jenis, ')
          ..write('tahun: $tahun, ')
          ..write('bulan: $bulan, ')
          ..write('fileHash: $fileHash, ')
          ..write('namaFile: $namaFile, ')
          ..write('diimporPada: $diimporPada')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $MonthlyAllocationsTable monthlyAllocations =
      $MonthlyAllocationsTable(this);
  late final $MonthlyAllocationRevisionsTable monthlyAllocationRevisions =
      $MonthlyAllocationRevisionsTable(this);
  late final $IncomeSourcesTable incomeSources = $IncomeSourcesTable(this);
  late final $MandatoryExpensesTable mandatoryExpenses =
      $MandatoryExpensesTable(this);
  late final $BudgetFundingAssignmentsTable budgetFundingAssignments =
      $BudgetFundingAssignmentsTable(this);
  late final $ExpenseRealizationsTable expenseRealizations =
      $ExpenseRealizationsTable(this);
  late final $SubscriptionsTable subscriptions = $SubscriptionsTable(this);
  late final $SubscriptionReserveLedgersTable subscriptionReserveLedgers =
      $SubscriptionReserveLedgersTable(this);
  late final $EmergencyFundTargetsTable emergencyFundTargets =
      $EmergencyFundTargetsTable(this);
  late final $EmergencyFundContributionsTable emergencyFundContributions =
      $EmergencyFundContributionsTable(this);
  late final $OtherSavingsContributionsTable otherSavingsContributions =
      $OtherSavingsContributionsTable(this);
  late final $InvestmentPlatformAllocationsTable investmentPlatformAllocations =
      $InvestmentPlatformAllocationsTable(this);
  late final $ChecklistItemsTable checklistItems = $ChecklistItemsTable(this);
  late final $RemindersTable reminders = $RemindersTable(this);
  late final $AppSettingsTable appSettings = $AppSettingsTable(this);
  late final $AiProviderConfigurationsTable aiProviderConfigurations =
      $AiProviderConfigurationsTable(this);
  late final $AiModelsTable aiModels = $AiModelsTable(this);
  late final $ModelListCachesTable modelListCaches = $ModelListCachesTable(
    this,
  );
  late final $ChatConversationsTable chatConversations =
      $ChatConversationsTable(this);
  late final $ChatMessagesTable chatMessages = $ChatMessagesTable(this);
  late final $DanaPlusConfigurationsTable danaPlusConfigurations =
      $DanaPlusConfigurationsTable(this);
  late final $DanaBalanceLedgersTable danaBalanceLedgers =
      $DanaBalanceLedgersTable(this);
  late final $InvestmentActualsTable investmentActuals =
      $InvestmentActualsTable(this);
  late final $ImportedReportsTable importedReports = $ImportedReportsTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    monthlyAllocations,
    monthlyAllocationRevisions,
    incomeSources,
    mandatoryExpenses,
    budgetFundingAssignments,
    expenseRealizations,
    subscriptions,
    subscriptionReserveLedgers,
    emergencyFundTargets,
    emergencyFundContributions,
    otherSavingsContributions,
    investmentPlatformAllocations,
    checklistItems,
    reminders,
    appSettings,
    aiProviderConfigurations,
    aiModels,
    modelListCaches,
    chatConversations,
    chatMessages,
    danaPlusConfigurations,
    danaBalanceLedgers,
    investmentActuals,
    importedReports,
  ];
}

typedef $$MonthlyAllocationsTableCreateCompanionBuilder =
    MonthlyAllocationsCompanion Function({
      Value<int> id,
      required int tahun,
      required int bulan,
      required DateTime dibuatPada,
    });
typedef $$MonthlyAllocationsTableUpdateCompanionBuilder =
    MonthlyAllocationsCompanion Function({
      Value<int> id,
      Value<int> tahun,
      Value<int> bulan,
      Value<DateTime> dibuatPada,
    });

final class $$MonthlyAllocationsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $MonthlyAllocationsTable,
          MonthlyAllocation
        > {
  $$MonthlyAllocationsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<
    $MonthlyAllocationRevisionsTable,
    List<MonthlyAllocationRevision>
  >
  _monthlyAllocationRevisionsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.monthlyAllocationRevisions,
    aliasName:
        'monthly_allocations__id__monthly_allocation_revisions__monthly_allocation_id',
  );

  $$MonthlyAllocationRevisionsTableProcessedTableManager
  get monthlyAllocationRevisionsRefs {
    final manager =
        $$MonthlyAllocationRevisionsTableTableManager(
          $_db,
          $_db.monthlyAllocationRevisions,
        ).filter(
          (f) => f.monthlyAllocationId.id.sqlEquals($_itemColumn<int>('id')!),
        );

    final cache = $_typedResult.readTableOrNull(
      _monthlyAllocationRevisionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MonthlyAllocationsTableFilterComposer
    extends Composer<_$AppDatabase, $MonthlyAllocationsTable> {
  $$MonthlyAllocationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get tahun => $composableBuilder(
    column: $table.tahun,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get bulan => $composableBuilder(
    column: $table.bulan,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dibuatPada => $composableBuilder(
    column: $table.dibuatPada,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> monthlyAllocationRevisionsRefs(
    Expression<bool> Function($$MonthlyAllocationRevisionsTableFilterComposer f)
    f,
  ) {
    final $$MonthlyAllocationRevisionsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.monthlyAllocationRevisions,
          getReferencedColumn: (t) => t.monthlyAllocationId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$MonthlyAllocationRevisionsTableFilterComposer(
                $db: $db,
                $table: $db.monthlyAllocationRevisions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$MonthlyAllocationsTableOrderingComposer
    extends Composer<_$AppDatabase, $MonthlyAllocationsTable> {
  $$MonthlyAllocationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get tahun => $composableBuilder(
    column: $table.tahun,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get bulan => $composableBuilder(
    column: $table.bulan,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dibuatPada => $composableBuilder(
    column: $table.dibuatPada,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MonthlyAllocationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MonthlyAllocationsTable> {
  $$MonthlyAllocationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get tahun =>
      $composableBuilder(column: $table.tahun, builder: (column) => column);

  GeneratedColumn<int> get bulan =>
      $composableBuilder(column: $table.bulan, builder: (column) => column);

  GeneratedColumn<DateTime> get dibuatPada => $composableBuilder(
    column: $table.dibuatPada,
    builder: (column) => column,
  );

  Expression<T> monthlyAllocationRevisionsRefs<T extends Object>(
    Expression<T> Function(
      $$MonthlyAllocationRevisionsTableAnnotationComposer a,
    )
    f,
  ) {
    final $$MonthlyAllocationRevisionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.monthlyAllocationRevisions,
          getReferencedColumn: (t) => t.monthlyAllocationId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$MonthlyAllocationRevisionsTableAnnotationComposer(
                $db: $db,
                $table: $db.monthlyAllocationRevisions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$MonthlyAllocationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MonthlyAllocationsTable,
          MonthlyAllocation,
          $$MonthlyAllocationsTableFilterComposer,
          $$MonthlyAllocationsTableOrderingComposer,
          $$MonthlyAllocationsTableAnnotationComposer,
          $$MonthlyAllocationsTableCreateCompanionBuilder,
          $$MonthlyAllocationsTableUpdateCompanionBuilder,
          (MonthlyAllocation, $$MonthlyAllocationsTableReferences),
          MonthlyAllocation,
          PrefetchHooks Function({bool monthlyAllocationRevisionsRefs})
        > {
  $$MonthlyAllocationsTableTableManager(
    _$AppDatabase db,
    $MonthlyAllocationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MonthlyAllocationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MonthlyAllocationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MonthlyAllocationsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> tahun = const Value.absent(),
                Value<int> bulan = const Value.absent(),
                Value<DateTime> dibuatPada = const Value.absent(),
              }) => MonthlyAllocationsCompanion(
                id: id,
                tahun: tahun,
                bulan: bulan,
                dibuatPada: dibuatPada,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int tahun,
                required int bulan,
                required DateTime dibuatPada,
              }) => MonthlyAllocationsCompanion.insert(
                id: id,
                tahun: tahun,
                bulan: bulan,
                dibuatPada: dibuatPada,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MonthlyAllocationsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({monthlyAllocationRevisionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (monthlyAllocationRevisionsRefs)
                  db.monthlyAllocationRevisions,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (monthlyAllocationRevisionsRefs)
                    await $_getPrefetchedData<
                      MonthlyAllocation,
                      $MonthlyAllocationsTable,
                      MonthlyAllocationRevision
                    >(
                      currentTable: table,
                      referencedTable: $$MonthlyAllocationsTableReferences
                          ._monthlyAllocationRevisionsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$MonthlyAllocationsTableReferences(
                            db,
                            table,
                            p0,
                          ).monthlyAllocationRevisionsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.monthlyAllocationId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$MonthlyAllocationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MonthlyAllocationsTable,
      MonthlyAllocation,
      $$MonthlyAllocationsTableFilterComposer,
      $$MonthlyAllocationsTableOrderingComposer,
      $$MonthlyAllocationsTableAnnotationComposer,
      $$MonthlyAllocationsTableCreateCompanionBuilder,
      $$MonthlyAllocationsTableUpdateCompanionBuilder,
      (MonthlyAllocation, $$MonthlyAllocationsTableReferences),
      MonthlyAllocation,
      PrefetchHooks Function({bool monthlyAllocationRevisionsRefs})
    >;
typedef $$MonthlyAllocationRevisionsTableCreateCompanionBuilder =
    MonthlyAllocationRevisionsCompanion Function({
      Value<int> id,
      required int monthlyAllocationId,
      required int nomorRevisi,
      required RevisionStatus status,
      Value<String?> alasanPerubahan,
      Value<String?> catatan,
      required int penghasilanUtama,
      required int kasPeganganBrimo,
      Value<String?> preset,
      required int jagoBp,
      required int investasiBp,
      required int danaBp,
      required int bibitBp,
      required int stockbitBp,
      required RoundingOption pembulatan,
      required JagoSubAllocationMethod metodeSubJago,
      required int subJagoLanggananBp,
      required int subJagoDaruratBp,
      required int subJagoOperasionalBp,
      required DanaTopUpFrequency frekuensiTopUpDana,
      required int hariTopUpMingguan,
      required int totalPendapatan,
      required int totalPengeluaranWajib,
      required int danaBersih,
      required int alokasiJago,
      required int totalAlokasiInvestasi,
      required int alokasiDana,
      required int alokasiBibit,
      required int alokasiStockbit,
      required int totalDanaMasukJago,
      required int subJagoLangganan,
      required int subJagoDanaDarurat,
      required int subJagoOperasional,
      required DateTime dibuatPada,
    });
typedef $$MonthlyAllocationRevisionsTableUpdateCompanionBuilder =
    MonthlyAllocationRevisionsCompanion Function({
      Value<int> id,
      Value<int> monthlyAllocationId,
      Value<int> nomorRevisi,
      Value<RevisionStatus> status,
      Value<String?> alasanPerubahan,
      Value<String?> catatan,
      Value<int> penghasilanUtama,
      Value<int> kasPeganganBrimo,
      Value<String?> preset,
      Value<int> jagoBp,
      Value<int> investasiBp,
      Value<int> danaBp,
      Value<int> bibitBp,
      Value<int> stockbitBp,
      Value<RoundingOption> pembulatan,
      Value<JagoSubAllocationMethod> metodeSubJago,
      Value<int> subJagoLanggananBp,
      Value<int> subJagoDaruratBp,
      Value<int> subJagoOperasionalBp,
      Value<DanaTopUpFrequency> frekuensiTopUpDana,
      Value<int> hariTopUpMingguan,
      Value<int> totalPendapatan,
      Value<int> totalPengeluaranWajib,
      Value<int> danaBersih,
      Value<int> alokasiJago,
      Value<int> totalAlokasiInvestasi,
      Value<int> alokasiDana,
      Value<int> alokasiBibit,
      Value<int> alokasiStockbit,
      Value<int> totalDanaMasukJago,
      Value<int> subJagoLangganan,
      Value<int> subJagoDanaDarurat,
      Value<int> subJagoOperasional,
      Value<DateTime> dibuatPada,
    });

final class $$MonthlyAllocationRevisionsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $MonthlyAllocationRevisionsTable,
          MonthlyAllocationRevision
        > {
  $$MonthlyAllocationRevisionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $MonthlyAllocationsTable _monthlyAllocationIdTable(
    _$AppDatabase db,
  ) => db.monthlyAllocations.createAlias(
    'monthly_allocation_revisions__monthly_allocation_id__monthly_allocations__id',
  );

  $$MonthlyAllocationsTableProcessedTableManager get monthlyAllocationId {
    final $_column = $_itemColumn<int>('monthly_allocation_id')!;

    final manager = $$MonthlyAllocationsTableTableManager(
      $_db,
      $_db.monthlyAllocations,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_monthlyAllocationIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$IncomeSourcesTable, List<IncomeSource>>
  _incomeSourcesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.incomeSources,
    aliasName: 'monthly_allocation_revisions__id__income_sources__revision_id',
  );

  $$IncomeSourcesTableProcessedTableManager get incomeSourcesRefs {
    final manager = $$IncomeSourcesTableTableManager(
      $_db,
      $_db.incomeSources,
    ).filter((f) => f.revisionId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_incomeSourcesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MandatoryExpensesTable, List<MandatoryExpense>>
  _mandatoryExpensesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.mandatoryExpenses,
        aliasName:
            'monthly_allocation_revisions__id__mandatory_expenses__revision_id',
      );

  $$MandatoryExpensesTableProcessedTableManager get mandatoryExpensesRefs {
    final manager = $$MandatoryExpensesTableTableManager(
      $_db,
      $_db.mandatoryExpenses,
    ).filter((f) => f.revisionId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _mandatoryExpensesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $BudgetFundingAssignmentsTable,
    List<BudgetFundingAssignment>
  >
  _budgetFundingAssignmentsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.budgetFundingAssignments,
    aliasName:
        'monthly_allocation_revisions__id__budget_funding_assignments__revision_id',
  );

  $$BudgetFundingAssignmentsTableProcessedTableManager
  get budgetFundingAssignmentsRefs {
    final manager = $$BudgetFundingAssignmentsTableTableManager(
      $_db,
      $_db.budgetFundingAssignments,
    ).filter((f) => f.revisionId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _budgetFundingAssignmentsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $ExpenseRealizationsTable,
    List<ExpenseRealization>
  >
  _expenseRealizationsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.expenseRealizations,
    aliasName:
        'monthly_allocation_revisions__id__expense_realizations__monthly_allocation_revision_id',
  );

  $$ExpenseRealizationsTableProcessedTableManager get expenseRealizationsRefs {
    final manager =
        $$ExpenseRealizationsTableTableManager(
          $_db,
          $_db.expenseRealizations,
        ).filter(
          (f) => f.monthlyAllocationRevisionId.id.sqlEquals(
            $_itemColumn<int>('id')!,
          ),
        );

    final cache = $_typedResult.readTableOrNull(
      _expenseRealizationsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $InvestmentPlatformAllocationsTable,
    List<InvestmentPlatformAllocation>
  >
  _investmentPlatformAllocationsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.investmentPlatformAllocations,
    aliasName:
        'monthly_allocation_revisions__id__investment_platform_allocations__revision_id',
  );

  $$InvestmentPlatformAllocationsTableProcessedTableManager
  get investmentPlatformAllocationsRefs {
    final manager = $$InvestmentPlatformAllocationsTableTableManager(
      $_db,
      $_db.investmentPlatformAllocations,
    ).filter((f) => f.revisionId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _investmentPlatformAllocationsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ChecklistItemsTable, List<ChecklistItem>>
  _checklistItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.checklistItems,
    aliasName: 'monthly_allocation_revisions__id__checklist_items__revision_id',
  );

  $$ChecklistItemsTableProcessedTableManager get checklistItemsRefs {
    final manager = $$ChecklistItemsTableTableManager(
      $_db,
      $_db.checklistItems,
    ).filter((f) => f.revisionId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_checklistItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MonthlyAllocationRevisionsTableFilterComposer
    extends Composer<_$AppDatabase, $MonthlyAllocationRevisionsTable> {
  $$MonthlyAllocationRevisionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get nomorRevisi => $composableBuilder(
    column: $table.nomorRevisi,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<RevisionStatus, RevisionStatus, String>
  get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get alasanPerubahan => $composableBuilder(
    column: $table.alasanPerubahan,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get catatan => $composableBuilder(
    column: $table.catatan,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get penghasilanUtama => $composableBuilder(
    column: $table.penghasilanUtama,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get kasPeganganBrimo => $composableBuilder(
    column: $table.kasPeganganBrimo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get preset => $composableBuilder(
    column: $table.preset,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get jagoBp => $composableBuilder(
    column: $table.jagoBp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get investasiBp => $composableBuilder(
    column: $table.investasiBp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get danaBp => $composableBuilder(
    column: $table.danaBp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get bibitBp => $composableBuilder(
    column: $table.bibitBp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get stockbitBp => $composableBuilder(
    column: $table.stockbitBp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<RoundingOption, RoundingOption, String>
  get pembulatan => $composableBuilder(
    column: $table.pembulatan,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<
    JagoSubAllocationMethod,
    JagoSubAllocationMethod,
    String
  >
  get metodeSubJago => $composableBuilder(
    column: $table.metodeSubJago,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get subJagoLanggananBp => $composableBuilder(
    column: $table.subJagoLanggananBp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get subJagoDaruratBp => $composableBuilder(
    column: $table.subJagoDaruratBp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get subJagoOperasionalBp => $composableBuilder(
    column: $table.subJagoOperasionalBp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<DanaTopUpFrequency, DanaTopUpFrequency, String>
  get frekuensiTopUpDana => $composableBuilder(
    column: $table.frekuensiTopUpDana,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get hariTopUpMingguan => $composableBuilder(
    column: $table.hariTopUpMingguan,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalPendapatan => $composableBuilder(
    column: $table.totalPendapatan,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalPengeluaranWajib => $composableBuilder(
    column: $table.totalPengeluaranWajib,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get danaBersih => $composableBuilder(
    column: $table.danaBersih,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get alokasiJago => $composableBuilder(
    column: $table.alokasiJago,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalAlokasiInvestasi => $composableBuilder(
    column: $table.totalAlokasiInvestasi,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get alokasiDana => $composableBuilder(
    column: $table.alokasiDana,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get alokasiBibit => $composableBuilder(
    column: $table.alokasiBibit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get alokasiStockbit => $composableBuilder(
    column: $table.alokasiStockbit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalDanaMasukJago => $composableBuilder(
    column: $table.totalDanaMasukJago,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get subJagoLangganan => $composableBuilder(
    column: $table.subJagoLangganan,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get subJagoDanaDarurat => $composableBuilder(
    column: $table.subJagoDanaDarurat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get subJagoOperasional => $composableBuilder(
    column: $table.subJagoOperasional,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dibuatPada => $composableBuilder(
    column: $table.dibuatPada,
    builder: (column) => ColumnFilters(column),
  );

  $$MonthlyAllocationsTableFilterComposer get monthlyAllocationId {
    final $$MonthlyAllocationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.monthlyAllocationId,
      referencedTable: $db.monthlyAllocations,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MonthlyAllocationsTableFilterComposer(
            $db: $db,
            $table: $db.monthlyAllocations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> incomeSourcesRefs(
    Expression<bool> Function($$IncomeSourcesTableFilterComposer f) f,
  ) {
    final $$IncomeSourcesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.incomeSources,
      getReferencedColumn: (t) => t.revisionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IncomeSourcesTableFilterComposer(
            $db: $db,
            $table: $db.incomeSources,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> mandatoryExpensesRefs(
    Expression<bool> Function($$MandatoryExpensesTableFilterComposer f) f,
  ) {
    final $$MandatoryExpensesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.mandatoryExpenses,
      getReferencedColumn: (t) => t.revisionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MandatoryExpensesTableFilterComposer(
            $db: $db,
            $table: $db.mandatoryExpenses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> budgetFundingAssignmentsRefs(
    Expression<bool> Function($$BudgetFundingAssignmentsTableFilterComposer f)
    f,
  ) {
    final $$BudgetFundingAssignmentsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.budgetFundingAssignments,
          getReferencedColumn: (t) => t.revisionId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$BudgetFundingAssignmentsTableFilterComposer(
                $db: $db,
                $table: $db.budgetFundingAssignments,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> expenseRealizationsRefs(
    Expression<bool> Function($$ExpenseRealizationsTableFilterComposer f) f,
  ) {
    final $$ExpenseRealizationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.expenseRealizations,
      getReferencedColumn: (t) => t.monthlyAllocationRevisionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExpenseRealizationsTableFilterComposer(
            $db: $db,
            $table: $db.expenseRealizations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> investmentPlatformAllocationsRefs(
    Expression<bool> Function(
      $$InvestmentPlatformAllocationsTableFilterComposer f,
    )
    f,
  ) {
    final $$InvestmentPlatformAllocationsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.investmentPlatformAllocations,
          getReferencedColumn: (t) => t.revisionId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InvestmentPlatformAllocationsTableFilterComposer(
                $db: $db,
                $table: $db.investmentPlatformAllocations,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> checklistItemsRefs(
    Expression<bool> Function($$ChecklistItemsTableFilterComposer f) f,
  ) {
    final $$ChecklistItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.checklistItems,
      getReferencedColumn: (t) => t.revisionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChecklistItemsTableFilterComposer(
            $db: $db,
            $table: $db.checklistItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MonthlyAllocationRevisionsTableOrderingComposer
    extends Composer<_$AppDatabase, $MonthlyAllocationRevisionsTable> {
  $$MonthlyAllocationRevisionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get nomorRevisi => $composableBuilder(
    column: $table.nomorRevisi,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get alasanPerubahan => $composableBuilder(
    column: $table.alasanPerubahan,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get catatan => $composableBuilder(
    column: $table.catatan,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get penghasilanUtama => $composableBuilder(
    column: $table.penghasilanUtama,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get kasPeganganBrimo => $composableBuilder(
    column: $table.kasPeganganBrimo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get preset => $composableBuilder(
    column: $table.preset,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get jagoBp => $composableBuilder(
    column: $table.jagoBp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get investasiBp => $composableBuilder(
    column: $table.investasiBp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get danaBp => $composableBuilder(
    column: $table.danaBp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get bibitBp => $composableBuilder(
    column: $table.bibitBp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get stockbitBp => $composableBuilder(
    column: $table.stockbitBp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pembulatan => $composableBuilder(
    column: $table.pembulatan,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get metodeSubJago => $composableBuilder(
    column: $table.metodeSubJago,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get subJagoLanggananBp => $composableBuilder(
    column: $table.subJagoLanggananBp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get subJagoDaruratBp => $composableBuilder(
    column: $table.subJagoDaruratBp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get subJagoOperasionalBp => $composableBuilder(
    column: $table.subJagoOperasionalBp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get frekuensiTopUpDana => $composableBuilder(
    column: $table.frekuensiTopUpDana,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get hariTopUpMingguan => $composableBuilder(
    column: $table.hariTopUpMingguan,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalPendapatan => $composableBuilder(
    column: $table.totalPendapatan,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalPengeluaranWajib => $composableBuilder(
    column: $table.totalPengeluaranWajib,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get danaBersih => $composableBuilder(
    column: $table.danaBersih,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get alokasiJago => $composableBuilder(
    column: $table.alokasiJago,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalAlokasiInvestasi => $composableBuilder(
    column: $table.totalAlokasiInvestasi,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get alokasiDana => $composableBuilder(
    column: $table.alokasiDana,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get alokasiBibit => $composableBuilder(
    column: $table.alokasiBibit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get alokasiStockbit => $composableBuilder(
    column: $table.alokasiStockbit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalDanaMasukJago => $composableBuilder(
    column: $table.totalDanaMasukJago,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get subJagoLangganan => $composableBuilder(
    column: $table.subJagoLangganan,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get subJagoDanaDarurat => $composableBuilder(
    column: $table.subJagoDanaDarurat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get subJagoOperasional => $composableBuilder(
    column: $table.subJagoOperasional,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dibuatPada => $composableBuilder(
    column: $table.dibuatPada,
    builder: (column) => ColumnOrderings(column),
  );

  $$MonthlyAllocationsTableOrderingComposer get monthlyAllocationId {
    final $$MonthlyAllocationsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.monthlyAllocationId,
      referencedTable: $db.monthlyAllocations,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MonthlyAllocationsTableOrderingComposer(
            $db: $db,
            $table: $db.monthlyAllocations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MonthlyAllocationRevisionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MonthlyAllocationRevisionsTable> {
  $$MonthlyAllocationRevisionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get nomorRevisi => $composableBuilder(
    column: $table.nomorRevisi,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<RevisionStatus, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get alasanPerubahan => $composableBuilder(
    column: $table.alasanPerubahan,
    builder: (column) => column,
  );

  GeneratedColumn<String> get catatan =>
      $composableBuilder(column: $table.catatan, builder: (column) => column);

  GeneratedColumn<int> get penghasilanUtama => $composableBuilder(
    column: $table.penghasilanUtama,
    builder: (column) => column,
  );

  GeneratedColumn<int> get kasPeganganBrimo => $composableBuilder(
    column: $table.kasPeganganBrimo,
    builder: (column) => column,
  );

  GeneratedColumn<String> get preset =>
      $composableBuilder(column: $table.preset, builder: (column) => column);

  GeneratedColumn<int> get jagoBp =>
      $composableBuilder(column: $table.jagoBp, builder: (column) => column);

  GeneratedColumn<int> get investasiBp => $composableBuilder(
    column: $table.investasiBp,
    builder: (column) => column,
  );

  GeneratedColumn<int> get danaBp =>
      $composableBuilder(column: $table.danaBp, builder: (column) => column);

  GeneratedColumn<int> get bibitBp =>
      $composableBuilder(column: $table.bibitBp, builder: (column) => column);

  GeneratedColumn<int> get stockbitBp => $composableBuilder(
    column: $table.stockbitBp,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<RoundingOption, String> get pembulatan =>
      $composableBuilder(
        column: $table.pembulatan,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<JagoSubAllocationMethod, String>
  get metodeSubJago => $composableBuilder(
    column: $table.metodeSubJago,
    builder: (column) => column,
  );

  GeneratedColumn<int> get subJagoLanggananBp => $composableBuilder(
    column: $table.subJagoLanggananBp,
    builder: (column) => column,
  );

  GeneratedColumn<int> get subJagoDaruratBp => $composableBuilder(
    column: $table.subJagoDaruratBp,
    builder: (column) => column,
  );

  GeneratedColumn<int> get subJagoOperasionalBp => $composableBuilder(
    column: $table.subJagoOperasionalBp,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<DanaTopUpFrequency, String>
  get frekuensiTopUpDana => $composableBuilder(
    column: $table.frekuensiTopUpDana,
    builder: (column) => column,
  );

  GeneratedColumn<int> get hariTopUpMingguan => $composableBuilder(
    column: $table.hariTopUpMingguan,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalPendapatan => $composableBuilder(
    column: $table.totalPendapatan,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalPengeluaranWajib => $composableBuilder(
    column: $table.totalPengeluaranWajib,
    builder: (column) => column,
  );

  GeneratedColumn<int> get danaBersih => $composableBuilder(
    column: $table.danaBersih,
    builder: (column) => column,
  );

  GeneratedColumn<int> get alokasiJago => $composableBuilder(
    column: $table.alokasiJago,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalAlokasiInvestasi => $composableBuilder(
    column: $table.totalAlokasiInvestasi,
    builder: (column) => column,
  );

  GeneratedColumn<int> get alokasiDana => $composableBuilder(
    column: $table.alokasiDana,
    builder: (column) => column,
  );

  GeneratedColumn<int> get alokasiBibit => $composableBuilder(
    column: $table.alokasiBibit,
    builder: (column) => column,
  );

  GeneratedColumn<int> get alokasiStockbit => $composableBuilder(
    column: $table.alokasiStockbit,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalDanaMasukJago => $composableBuilder(
    column: $table.totalDanaMasukJago,
    builder: (column) => column,
  );

  GeneratedColumn<int> get subJagoLangganan => $composableBuilder(
    column: $table.subJagoLangganan,
    builder: (column) => column,
  );

  GeneratedColumn<int> get subJagoDanaDarurat => $composableBuilder(
    column: $table.subJagoDanaDarurat,
    builder: (column) => column,
  );

  GeneratedColumn<int> get subJagoOperasional => $composableBuilder(
    column: $table.subJagoOperasional,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get dibuatPada => $composableBuilder(
    column: $table.dibuatPada,
    builder: (column) => column,
  );

  $$MonthlyAllocationsTableAnnotationComposer get monthlyAllocationId {
    final $$MonthlyAllocationsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.monthlyAllocationId,
          referencedTable: $db.monthlyAllocations,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$MonthlyAllocationsTableAnnotationComposer(
                $db: $db,
                $table: $db.monthlyAllocations,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  Expression<T> incomeSourcesRefs<T extends Object>(
    Expression<T> Function($$IncomeSourcesTableAnnotationComposer a) f,
  ) {
    final $$IncomeSourcesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.incomeSources,
      getReferencedColumn: (t) => t.revisionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IncomeSourcesTableAnnotationComposer(
            $db: $db,
            $table: $db.incomeSources,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> mandatoryExpensesRefs<T extends Object>(
    Expression<T> Function($$MandatoryExpensesTableAnnotationComposer a) f,
  ) {
    final $$MandatoryExpensesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.mandatoryExpenses,
          getReferencedColumn: (t) => t.revisionId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$MandatoryExpensesTableAnnotationComposer(
                $db: $db,
                $table: $db.mandatoryExpenses,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> budgetFundingAssignmentsRefs<T extends Object>(
    Expression<T> Function($$BudgetFundingAssignmentsTableAnnotationComposer a)
    f,
  ) {
    final $$BudgetFundingAssignmentsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.budgetFundingAssignments,
          getReferencedColumn: (t) => t.revisionId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$BudgetFundingAssignmentsTableAnnotationComposer(
                $db: $db,
                $table: $db.budgetFundingAssignments,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> expenseRealizationsRefs<T extends Object>(
    Expression<T> Function($$ExpenseRealizationsTableAnnotationComposer a) f,
  ) {
    final $$ExpenseRealizationsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.expenseRealizations,
          getReferencedColumn: (t) => t.monthlyAllocationRevisionId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ExpenseRealizationsTableAnnotationComposer(
                $db: $db,
                $table: $db.expenseRealizations,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> investmentPlatformAllocationsRefs<T extends Object>(
    Expression<T> Function(
      $$InvestmentPlatformAllocationsTableAnnotationComposer a,
    )
    f,
  ) {
    final $$InvestmentPlatformAllocationsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.investmentPlatformAllocations,
          getReferencedColumn: (t) => t.revisionId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InvestmentPlatformAllocationsTableAnnotationComposer(
                $db: $db,
                $table: $db.investmentPlatformAllocations,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> checklistItemsRefs<T extends Object>(
    Expression<T> Function($$ChecklistItemsTableAnnotationComposer a) f,
  ) {
    final $$ChecklistItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.checklistItems,
      getReferencedColumn: (t) => t.revisionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChecklistItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.checklistItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MonthlyAllocationRevisionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MonthlyAllocationRevisionsTable,
          MonthlyAllocationRevision,
          $$MonthlyAllocationRevisionsTableFilterComposer,
          $$MonthlyAllocationRevisionsTableOrderingComposer,
          $$MonthlyAllocationRevisionsTableAnnotationComposer,
          $$MonthlyAllocationRevisionsTableCreateCompanionBuilder,
          $$MonthlyAllocationRevisionsTableUpdateCompanionBuilder,
          (
            MonthlyAllocationRevision,
            $$MonthlyAllocationRevisionsTableReferences,
          ),
          MonthlyAllocationRevision,
          PrefetchHooks Function({
            bool monthlyAllocationId,
            bool incomeSourcesRefs,
            bool mandatoryExpensesRefs,
            bool budgetFundingAssignmentsRefs,
            bool expenseRealizationsRefs,
            bool investmentPlatformAllocationsRefs,
            bool checklistItemsRefs,
          })
        > {
  $$MonthlyAllocationRevisionsTableTableManager(
    _$AppDatabase db,
    $MonthlyAllocationRevisionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MonthlyAllocationRevisionsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$MonthlyAllocationRevisionsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$MonthlyAllocationRevisionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> monthlyAllocationId = const Value.absent(),
                Value<int> nomorRevisi = const Value.absent(),
                Value<RevisionStatus> status = const Value.absent(),
                Value<String?> alasanPerubahan = const Value.absent(),
                Value<String?> catatan = const Value.absent(),
                Value<int> penghasilanUtama = const Value.absent(),
                Value<int> kasPeganganBrimo = const Value.absent(),
                Value<String?> preset = const Value.absent(),
                Value<int> jagoBp = const Value.absent(),
                Value<int> investasiBp = const Value.absent(),
                Value<int> danaBp = const Value.absent(),
                Value<int> bibitBp = const Value.absent(),
                Value<int> stockbitBp = const Value.absent(),
                Value<RoundingOption> pembulatan = const Value.absent(),
                Value<JagoSubAllocationMethod> metodeSubJago =
                    const Value.absent(),
                Value<int> subJagoLanggananBp = const Value.absent(),
                Value<int> subJagoDaruratBp = const Value.absent(),
                Value<int> subJagoOperasionalBp = const Value.absent(),
                Value<DanaTopUpFrequency> frekuensiTopUpDana =
                    const Value.absent(),
                Value<int> hariTopUpMingguan = const Value.absent(),
                Value<int> totalPendapatan = const Value.absent(),
                Value<int> totalPengeluaranWajib = const Value.absent(),
                Value<int> danaBersih = const Value.absent(),
                Value<int> alokasiJago = const Value.absent(),
                Value<int> totalAlokasiInvestasi = const Value.absent(),
                Value<int> alokasiDana = const Value.absent(),
                Value<int> alokasiBibit = const Value.absent(),
                Value<int> alokasiStockbit = const Value.absent(),
                Value<int> totalDanaMasukJago = const Value.absent(),
                Value<int> subJagoLangganan = const Value.absent(),
                Value<int> subJagoDanaDarurat = const Value.absent(),
                Value<int> subJagoOperasional = const Value.absent(),
                Value<DateTime> dibuatPada = const Value.absent(),
              }) => MonthlyAllocationRevisionsCompanion(
                id: id,
                monthlyAllocationId: monthlyAllocationId,
                nomorRevisi: nomorRevisi,
                status: status,
                alasanPerubahan: alasanPerubahan,
                catatan: catatan,
                penghasilanUtama: penghasilanUtama,
                kasPeganganBrimo: kasPeganganBrimo,
                preset: preset,
                jagoBp: jagoBp,
                investasiBp: investasiBp,
                danaBp: danaBp,
                bibitBp: bibitBp,
                stockbitBp: stockbitBp,
                pembulatan: pembulatan,
                metodeSubJago: metodeSubJago,
                subJagoLanggananBp: subJagoLanggananBp,
                subJagoDaruratBp: subJagoDaruratBp,
                subJagoOperasionalBp: subJagoOperasionalBp,
                frekuensiTopUpDana: frekuensiTopUpDana,
                hariTopUpMingguan: hariTopUpMingguan,
                totalPendapatan: totalPendapatan,
                totalPengeluaranWajib: totalPengeluaranWajib,
                danaBersih: danaBersih,
                alokasiJago: alokasiJago,
                totalAlokasiInvestasi: totalAlokasiInvestasi,
                alokasiDana: alokasiDana,
                alokasiBibit: alokasiBibit,
                alokasiStockbit: alokasiStockbit,
                totalDanaMasukJago: totalDanaMasukJago,
                subJagoLangganan: subJagoLangganan,
                subJagoDanaDarurat: subJagoDanaDarurat,
                subJagoOperasional: subJagoOperasional,
                dibuatPada: dibuatPada,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int monthlyAllocationId,
                required int nomorRevisi,
                required RevisionStatus status,
                Value<String?> alasanPerubahan = const Value.absent(),
                Value<String?> catatan = const Value.absent(),
                required int penghasilanUtama,
                required int kasPeganganBrimo,
                Value<String?> preset = const Value.absent(),
                required int jagoBp,
                required int investasiBp,
                required int danaBp,
                required int bibitBp,
                required int stockbitBp,
                required RoundingOption pembulatan,
                required JagoSubAllocationMethod metodeSubJago,
                required int subJagoLanggananBp,
                required int subJagoDaruratBp,
                required int subJagoOperasionalBp,
                required DanaTopUpFrequency frekuensiTopUpDana,
                required int hariTopUpMingguan,
                required int totalPendapatan,
                required int totalPengeluaranWajib,
                required int danaBersih,
                required int alokasiJago,
                required int totalAlokasiInvestasi,
                required int alokasiDana,
                required int alokasiBibit,
                required int alokasiStockbit,
                required int totalDanaMasukJago,
                required int subJagoLangganan,
                required int subJagoDanaDarurat,
                required int subJagoOperasional,
                required DateTime dibuatPada,
              }) => MonthlyAllocationRevisionsCompanion.insert(
                id: id,
                monthlyAllocationId: monthlyAllocationId,
                nomorRevisi: nomorRevisi,
                status: status,
                alasanPerubahan: alasanPerubahan,
                catatan: catatan,
                penghasilanUtama: penghasilanUtama,
                kasPeganganBrimo: kasPeganganBrimo,
                preset: preset,
                jagoBp: jagoBp,
                investasiBp: investasiBp,
                danaBp: danaBp,
                bibitBp: bibitBp,
                stockbitBp: stockbitBp,
                pembulatan: pembulatan,
                metodeSubJago: metodeSubJago,
                subJagoLanggananBp: subJagoLanggananBp,
                subJagoDaruratBp: subJagoDaruratBp,
                subJagoOperasionalBp: subJagoOperasionalBp,
                frekuensiTopUpDana: frekuensiTopUpDana,
                hariTopUpMingguan: hariTopUpMingguan,
                totalPendapatan: totalPendapatan,
                totalPengeluaranWajib: totalPengeluaranWajib,
                danaBersih: danaBersih,
                alokasiJago: alokasiJago,
                totalAlokasiInvestasi: totalAlokasiInvestasi,
                alokasiDana: alokasiDana,
                alokasiBibit: alokasiBibit,
                alokasiStockbit: alokasiStockbit,
                totalDanaMasukJago: totalDanaMasukJago,
                subJagoLangganan: subJagoLangganan,
                subJagoDanaDarurat: subJagoDanaDarurat,
                subJagoOperasional: subJagoOperasional,
                dibuatPada: dibuatPada,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MonthlyAllocationRevisionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                monthlyAllocationId = false,
                incomeSourcesRefs = false,
                mandatoryExpensesRefs = false,
                budgetFundingAssignmentsRefs = false,
                expenseRealizationsRefs = false,
                investmentPlatformAllocationsRefs = false,
                checklistItemsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (incomeSourcesRefs) db.incomeSources,
                    if (mandatoryExpensesRefs) db.mandatoryExpenses,
                    if (budgetFundingAssignmentsRefs)
                      db.budgetFundingAssignments,
                    if (expenseRealizationsRefs) db.expenseRealizations,
                    if (investmentPlatformAllocationsRefs)
                      db.investmentPlatformAllocations,
                    if (checklistItemsRefs) db.checklistItems,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (monthlyAllocationId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.monthlyAllocationId,
                                    referencedTable:
                                        $$MonthlyAllocationRevisionsTableReferences
                                            ._monthlyAllocationIdTable(db),
                                    referencedColumn:
                                        $$MonthlyAllocationRevisionsTableReferences
                                            ._monthlyAllocationIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (incomeSourcesRefs)
                        await $_getPrefetchedData<
                          MonthlyAllocationRevision,
                          $MonthlyAllocationRevisionsTable,
                          IncomeSource
                        >(
                          currentTable: table,
                          referencedTable:
                              $$MonthlyAllocationRevisionsTableReferences
                                  ._incomeSourcesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MonthlyAllocationRevisionsTableReferences(
                                db,
                                table,
                                p0,
                              ).incomeSourcesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.revisionId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (mandatoryExpensesRefs)
                        await $_getPrefetchedData<
                          MonthlyAllocationRevision,
                          $MonthlyAllocationRevisionsTable,
                          MandatoryExpense
                        >(
                          currentTable: table,
                          referencedTable:
                              $$MonthlyAllocationRevisionsTableReferences
                                  ._mandatoryExpensesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MonthlyAllocationRevisionsTableReferences(
                                db,
                                table,
                                p0,
                              ).mandatoryExpensesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.revisionId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (budgetFundingAssignmentsRefs)
                        await $_getPrefetchedData<
                          MonthlyAllocationRevision,
                          $MonthlyAllocationRevisionsTable,
                          BudgetFundingAssignment
                        >(
                          currentTable: table,
                          referencedTable:
                              $$MonthlyAllocationRevisionsTableReferences
                                  ._budgetFundingAssignmentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MonthlyAllocationRevisionsTableReferences(
                                db,
                                table,
                                p0,
                              ).budgetFundingAssignmentsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.revisionId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (expenseRealizationsRefs)
                        await $_getPrefetchedData<
                          MonthlyAllocationRevision,
                          $MonthlyAllocationRevisionsTable,
                          ExpenseRealization
                        >(
                          currentTable: table,
                          referencedTable:
                              $$MonthlyAllocationRevisionsTableReferences
                                  ._expenseRealizationsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MonthlyAllocationRevisionsTableReferences(
                                db,
                                table,
                                p0,
                              ).expenseRealizationsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.monthlyAllocationRevisionId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (investmentPlatformAllocationsRefs)
                        await $_getPrefetchedData<
                          MonthlyAllocationRevision,
                          $MonthlyAllocationRevisionsTable,
                          InvestmentPlatformAllocation
                        >(
                          currentTable: table,
                          referencedTable:
                              $$MonthlyAllocationRevisionsTableReferences
                                  ._investmentPlatformAllocationsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MonthlyAllocationRevisionsTableReferences(
                                db,
                                table,
                                p0,
                              ).investmentPlatformAllocationsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.revisionId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (checklistItemsRefs)
                        await $_getPrefetchedData<
                          MonthlyAllocationRevision,
                          $MonthlyAllocationRevisionsTable,
                          ChecklistItem
                        >(
                          currentTable: table,
                          referencedTable:
                              $$MonthlyAllocationRevisionsTableReferences
                                  ._checklistItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MonthlyAllocationRevisionsTableReferences(
                                db,
                                table,
                                p0,
                              ).checklistItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.revisionId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$MonthlyAllocationRevisionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MonthlyAllocationRevisionsTable,
      MonthlyAllocationRevision,
      $$MonthlyAllocationRevisionsTableFilterComposer,
      $$MonthlyAllocationRevisionsTableOrderingComposer,
      $$MonthlyAllocationRevisionsTableAnnotationComposer,
      $$MonthlyAllocationRevisionsTableCreateCompanionBuilder,
      $$MonthlyAllocationRevisionsTableUpdateCompanionBuilder,
      (MonthlyAllocationRevision, $$MonthlyAllocationRevisionsTableReferences),
      MonthlyAllocationRevision,
      PrefetchHooks Function({
        bool monthlyAllocationId,
        bool incomeSourcesRefs,
        bool mandatoryExpensesRefs,
        bool budgetFundingAssignmentsRefs,
        bool expenseRealizationsRefs,
        bool investmentPlatformAllocationsRefs,
        bool checklistItemsRefs,
      })
    >;
typedef $$IncomeSourcesTableCreateCompanionBuilder =
    IncomeSourcesCompanion Function({
      Value<int> id,
      required int revisionId,
      required String nama,
      required int nominal,
      required bool rutin,
      required bool disertakanBulanAktif,
    });
typedef $$IncomeSourcesTableUpdateCompanionBuilder =
    IncomeSourcesCompanion Function({
      Value<int> id,
      Value<int> revisionId,
      Value<String> nama,
      Value<int> nominal,
      Value<bool> rutin,
      Value<bool> disertakanBulanAktif,
    });

final class $$IncomeSourcesTableReferences
    extends BaseReferences<_$AppDatabase, $IncomeSourcesTable, IncomeSource> {
  $$IncomeSourcesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $MonthlyAllocationRevisionsTable _revisionIdTable(_$AppDatabase db) =>
      db.monthlyAllocationRevisions.createAlias(
        'income_sources__revision_id__monthly_allocation_revisions__id',
      );

  $$MonthlyAllocationRevisionsTableProcessedTableManager get revisionId {
    final $_column = $_itemColumn<int>('revision_id')!;

    final manager = $$MonthlyAllocationRevisionsTableTableManager(
      $_db,
      $_db.monthlyAllocationRevisions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_revisionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$IncomeSourcesTableFilterComposer
    extends Composer<_$AppDatabase, $IncomeSourcesTable> {
  $$IncomeSourcesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nama => $composableBuilder(
    column: $table.nama,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get nominal => $composableBuilder(
    column: $table.nominal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get rutin => $composableBuilder(
    column: $table.rutin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get disertakanBulanAktif => $composableBuilder(
    column: $table.disertakanBulanAktif,
    builder: (column) => ColumnFilters(column),
  );

  $$MonthlyAllocationRevisionsTableFilterComposer get revisionId {
    final $$MonthlyAllocationRevisionsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.revisionId,
          referencedTable: $db.monthlyAllocationRevisions,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$MonthlyAllocationRevisionsTableFilterComposer(
                $db: $db,
                $table: $db.monthlyAllocationRevisions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$IncomeSourcesTableOrderingComposer
    extends Composer<_$AppDatabase, $IncomeSourcesTable> {
  $$IncomeSourcesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nama => $composableBuilder(
    column: $table.nama,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get nominal => $composableBuilder(
    column: $table.nominal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get rutin => $composableBuilder(
    column: $table.rutin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get disertakanBulanAktif => $composableBuilder(
    column: $table.disertakanBulanAktif,
    builder: (column) => ColumnOrderings(column),
  );

  $$MonthlyAllocationRevisionsTableOrderingComposer get revisionId {
    final $$MonthlyAllocationRevisionsTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.revisionId,
          referencedTable: $db.monthlyAllocationRevisions,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$MonthlyAllocationRevisionsTableOrderingComposer(
                $db: $db,
                $table: $db.monthlyAllocationRevisions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$IncomeSourcesTableAnnotationComposer
    extends Composer<_$AppDatabase, $IncomeSourcesTable> {
  $$IncomeSourcesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nama =>
      $composableBuilder(column: $table.nama, builder: (column) => column);

  GeneratedColumn<int> get nominal =>
      $composableBuilder(column: $table.nominal, builder: (column) => column);

  GeneratedColumn<bool> get rutin =>
      $composableBuilder(column: $table.rutin, builder: (column) => column);

  GeneratedColumn<bool> get disertakanBulanAktif => $composableBuilder(
    column: $table.disertakanBulanAktif,
    builder: (column) => column,
  );

  $$MonthlyAllocationRevisionsTableAnnotationComposer get revisionId {
    final $$MonthlyAllocationRevisionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.revisionId,
          referencedTable: $db.monthlyAllocationRevisions,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$MonthlyAllocationRevisionsTableAnnotationComposer(
                $db: $db,
                $table: $db.monthlyAllocationRevisions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$IncomeSourcesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $IncomeSourcesTable,
          IncomeSource,
          $$IncomeSourcesTableFilterComposer,
          $$IncomeSourcesTableOrderingComposer,
          $$IncomeSourcesTableAnnotationComposer,
          $$IncomeSourcesTableCreateCompanionBuilder,
          $$IncomeSourcesTableUpdateCompanionBuilder,
          (IncomeSource, $$IncomeSourcesTableReferences),
          IncomeSource,
          PrefetchHooks Function({bool revisionId})
        > {
  $$IncomeSourcesTableTableManager(_$AppDatabase db, $IncomeSourcesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$IncomeSourcesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$IncomeSourcesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$IncomeSourcesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> revisionId = const Value.absent(),
                Value<String> nama = const Value.absent(),
                Value<int> nominal = const Value.absent(),
                Value<bool> rutin = const Value.absent(),
                Value<bool> disertakanBulanAktif = const Value.absent(),
              }) => IncomeSourcesCompanion(
                id: id,
                revisionId: revisionId,
                nama: nama,
                nominal: nominal,
                rutin: rutin,
                disertakanBulanAktif: disertakanBulanAktif,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int revisionId,
                required String nama,
                required int nominal,
                required bool rutin,
                required bool disertakanBulanAktif,
              }) => IncomeSourcesCompanion.insert(
                id: id,
                revisionId: revisionId,
                nama: nama,
                nominal: nominal,
                rutin: rutin,
                disertakanBulanAktif: disertakanBulanAktif,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$IncomeSourcesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({revisionId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (revisionId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.revisionId,
                                referencedTable: $$IncomeSourcesTableReferences
                                    ._revisionIdTable(db),
                                referencedColumn: $$IncomeSourcesTableReferences
                                    ._revisionIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$IncomeSourcesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $IncomeSourcesTable,
      IncomeSource,
      $$IncomeSourcesTableFilterComposer,
      $$IncomeSourcesTableOrderingComposer,
      $$IncomeSourcesTableAnnotationComposer,
      $$IncomeSourcesTableCreateCompanionBuilder,
      $$IncomeSourcesTableUpdateCompanionBuilder,
      (IncomeSource, $$IncomeSourcesTableReferences),
      IncomeSource,
      PrefetchHooks Function({bool revisionId})
    >;
typedef $$MandatoryExpensesTableCreateCompanionBuilder =
    MandatoryExpensesCompanion Function({
      Value<int> id,
      required int revisionId,
      required String nama,
      required String kategori,
      required int nominal,
      Value<int?> tanggalJatuhTempo,
      required bool rutin,
      required ExpenseAmountType jenisNominal,
      required bool kebutuhanPokok,
      required bool dihitungDasarDanaDarurat,
      required PaymentChannel kanalPembayaran,
    });
typedef $$MandatoryExpensesTableUpdateCompanionBuilder =
    MandatoryExpensesCompanion Function({
      Value<int> id,
      Value<int> revisionId,
      Value<String> nama,
      Value<String> kategori,
      Value<int> nominal,
      Value<int?> tanggalJatuhTempo,
      Value<bool> rutin,
      Value<ExpenseAmountType> jenisNominal,
      Value<bool> kebutuhanPokok,
      Value<bool> dihitungDasarDanaDarurat,
      Value<PaymentChannel> kanalPembayaran,
    });

final class $$MandatoryExpensesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $MandatoryExpensesTable,
          MandatoryExpense
        > {
  $$MandatoryExpensesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $MonthlyAllocationRevisionsTable _revisionIdTable(_$AppDatabase db) =>
      db.monthlyAllocationRevisions.createAlias(
        'mandatory_expenses__revision_id__monthly_allocation_revisions__id',
      );

  $$MonthlyAllocationRevisionsTableProcessedTableManager get revisionId {
    final $_column = $_itemColumn<int>('revision_id')!;

    final manager = $$MonthlyAllocationRevisionsTableTableManager(
      $_db,
      $_db.monthlyAllocationRevisions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_revisionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$MandatoryExpensesTableFilterComposer
    extends Composer<_$AppDatabase, $MandatoryExpensesTable> {
  $$MandatoryExpensesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nama => $composableBuilder(
    column: $table.nama,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kategori => $composableBuilder(
    column: $table.kategori,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get nominal => $composableBuilder(
    column: $table.nominal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get tanggalJatuhTempo => $composableBuilder(
    column: $table.tanggalJatuhTempo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get rutin => $composableBuilder(
    column: $table.rutin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<ExpenseAmountType, ExpenseAmountType, String>
  get jenisNominal => $composableBuilder(
    column: $table.jenisNominal,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<bool> get kebutuhanPokok => $composableBuilder(
    column: $table.kebutuhanPokok,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get dihitungDasarDanaDarurat => $composableBuilder(
    column: $table.dihitungDasarDanaDarurat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<PaymentChannel, PaymentChannel, String>
  get kanalPembayaran => $composableBuilder(
    column: $table.kanalPembayaran,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  $$MonthlyAllocationRevisionsTableFilterComposer get revisionId {
    final $$MonthlyAllocationRevisionsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.revisionId,
          referencedTable: $db.monthlyAllocationRevisions,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$MonthlyAllocationRevisionsTableFilterComposer(
                $db: $db,
                $table: $db.monthlyAllocationRevisions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$MandatoryExpensesTableOrderingComposer
    extends Composer<_$AppDatabase, $MandatoryExpensesTable> {
  $$MandatoryExpensesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nama => $composableBuilder(
    column: $table.nama,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kategori => $composableBuilder(
    column: $table.kategori,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get nominal => $composableBuilder(
    column: $table.nominal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get tanggalJatuhTempo => $composableBuilder(
    column: $table.tanggalJatuhTempo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get rutin => $composableBuilder(
    column: $table.rutin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get jenisNominal => $composableBuilder(
    column: $table.jenisNominal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get kebutuhanPokok => $composableBuilder(
    column: $table.kebutuhanPokok,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get dihitungDasarDanaDarurat => $composableBuilder(
    column: $table.dihitungDasarDanaDarurat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kanalPembayaran => $composableBuilder(
    column: $table.kanalPembayaran,
    builder: (column) => ColumnOrderings(column),
  );

  $$MonthlyAllocationRevisionsTableOrderingComposer get revisionId {
    final $$MonthlyAllocationRevisionsTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.revisionId,
          referencedTable: $db.monthlyAllocationRevisions,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$MonthlyAllocationRevisionsTableOrderingComposer(
                $db: $db,
                $table: $db.monthlyAllocationRevisions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$MandatoryExpensesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MandatoryExpensesTable> {
  $$MandatoryExpensesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nama =>
      $composableBuilder(column: $table.nama, builder: (column) => column);

  GeneratedColumn<String> get kategori =>
      $composableBuilder(column: $table.kategori, builder: (column) => column);

  GeneratedColumn<int> get nominal =>
      $composableBuilder(column: $table.nominal, builder: (column) => column);

  GeneratedColumn<int> get tanggalJatuhTempo => $composableBuilder(
    column: $table.tanggalJatuhTempo,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get rutin =>
      $composableBuilder(column: $table.rutin, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ExpenseAmountType, String>
  get jenisNominal => $composableBuilder(
    column: $table.jenisNominal,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get kebutuhanPokok => $composableBuilder(
    column: $table.kebutuhanPokok,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get dihitungDasarDanaDarurat => $composableBuilder(
    column: $table.dihitungDasarDanaDarurat,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<PaymentChannel, String>
  get kanalPembayaran => $composableBuilder(
    column: $table.kanalPembayaran,
    builder: (column) => column,
  );

  $$MonthlyAllocationRevisionsTableAnnotationComposer get revisionId {
    final $$MonthlyAllocationRevisionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.revisionId,
          referencedTable: $db.monthlyAllocationRevisions,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$MonthlyAllocationRevisionsTableAnnotationComposer(
                $db: $db,
                $table: $db.monthlyAllocationRevisions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$MandatoryExpensesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MandatoryExpensesTable,
          MandatoryExpense,
          $$MandatoryExpensesTableFilterComposer,
          $$MandatoryExpensesTableOrderingComposer,
          $$MandatoryExpensesTableAnnotationComposer,
          $$MandatoryExpensesTableCreateCompanionBuilder,
          $$MandatoryExpensesTableUpdateCompanionBuilder,
          (MandatoryExpense, $$MandatoryExpensesTableReferences),
          MandatoryExpense,
          PrefetchHooks Function({bool revisionId})
        > {
  $$MandatoryExpensesTableTableManager(
    _$AppDatabase db,
    $MandatoryExpensesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MandatoryExpensesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MandatoryExpensesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MandatoryExpensesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> revisionId = const Value.absent(),
                Value<String> nama = const Value.absent(),
                Value<String> kategori = const Value.absent(),
                Value<int> nominal = const Value.absent(),
                Value<int?> tanggalJatuhTempo = const Value.absent(),
                Value<bool> rutin = const Value.absent(),
                Value<ExpenseAmountType> jenisNominal = const Value.absent(),
                Value<bool> kebutuhanPokok = const Value.absent(),
                Value<bool> dihitungDasarDanaDarurat = const Value.absent(),
                Value<PaymentChannel> kanalPembayaran = const Value.absent(),
              }) => MandatoryExpensesCompanion(
                id: id,
                revisionId: revisionId,
                nama: nama,
                kategori: kategori,
                nominal: nominal,
                tanggalJatuhTempo: tanggalJatuhTempo,
                rutin: rutin,
                jenisNominal: jenisNominal,
                kebutuhanPokok: kebutuhanPokok,
                dihitungDasarDanaDarurat: dihitungDasarDanaDarurat,
                kanalPembayaran: kanalPembayaran,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int revisionId,
                required String nama,
                required String kategori,
                required int nominal,
                Value<int?> tanggalJatuhTempo = const Value.absent(),
                required bool rutin,
                required ExpenseAmountType jenisNominal,
                required bool kebutuhanPokok,
                required bool dihitungDasarDanaDarurat,
                required PaymentChannel kanalPembayaran,
              }) => MandatoryExpensesCompanion.insert(
                id: id,
                revisionId: revisionId,
                nama: nama,
                kategori: kategori,
                nominal: nominal,
                tanggalJatuhTempo: tanggalJatuhTempo,
                rutin: rutin,
                jenisNominal: jenisNominal,
                kebutuhanPokok: kebutuhanPokok,
                dihitungDasarDanaDarurat: dihitungDasarDanaDarurat,
                kanalPembayaran: kanalPembayaran,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MandatoryExpensesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({revisionId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (revisionId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.revisionId,
                                referencedTable:
                                    $$MandatoryExpensesTableReferences
                                        ._revisionIdTable(db),
                                referencedColumn:
                                    $$MandatoryExpensesTableReferences
                                        ._revisionIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$MandatoryExpensesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MandatoryExpensesTable,
      MandatoryExpense,
      $$MandatoryExpensesTableFilterComposer,
      $$MandatoryExpensesTableOrderingComposer,
      $$MandatoryExpensesTableAnnotationComposer,
      $$MandatoryExpensesTableCreateCompanionBuilder,
      $$MandatoryExpensesTableUpdateCompanionBuilder,
      (MandatoryExpense, $$MandatoryExpensesTableReferences),
      MandatoryExpense,
      PrefetchHooks Function({bool revisionId})
    >;
typedef $$BudgetFundingAssignmentsTableCreateCompanionBuilder =
    BudgetFundingAssignmentsCompanion Function({
      Value<int> id,
      required String itemId,
      required String itemType,
      required int revisionId,
      required BudgetSource fundingSource,
      required PaymentChannel paymentChannel,
      required bool includedInSpendingBudget,
    });
typedef $$BudgetFundingAssignmentsTableUpdateCompanionBuilder =
    BudgetFundingAssignmentsCompanion Function({
      Value<int> id,
      Value<String> itemId,
      Value<String> itemType,
      Value<int> revisionId,
      Value<BudgetSource> fundingSource,
      Value<PaymentChannel> paymentChannel,
      Value<bool> includedInSpendingBudget,
    });

final class $$BudgetFundingAssignmentsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $BudgetFundingAssignmentsTable,
          BudgetFundingAssignment
        > {
  $$BudgetFundingAssignmentsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $MonthlyAllocationRevisionsTable _revisionIdTable(
    _$AppDatabase db,
  ) => db.monthlyAllocationRevisions.createAlias(
    'budget_funding_assignments__revision_id__monthly_allocation_revisions__id',
  );

  $$MonthlyAllocationRevisionsTableProcessedTableManager get revisionId {
    final $_column = $_itemColumn<int>('revision_id')!;

    final manager = $$MonthlyAllocationRevisionsTableTableManager(
      $_db,
      $_db.monthlyAllocationRevisions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_revisionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$BudgetFundingAssignmentsTableFilterComposer
    extends Composer<_$AppDatabase, $BudgetFundingAssignmentsTable> {
  $$BudgetFundingAssignmentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get itemId => $composableBuilder(
    column: $table.itemId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get itemType => $composableBuilder(
    column: $table.itemType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<BudgetSource, BudgetSource, String>
  get fundingSource => $composableBuilder(
    column: $table.fundingSource,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<PaymentChannel, PaymentChannel, String>
  get paymentChannel => $composableBuilder(
    column: $table.paymentChannel,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<bool> get includedInSpendingBudget => $composableBuilder(
    column: $table.includedInSpendingBudget,
    builder: (column) => ColumnFilters(column),
  );

  $$MonthlyAllocationRevisionsTableFilterComposer get revisionId {
    final $$MonthlyAllocationRevisionsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.revisionId,
          referencedTable: $db.monthlyAllocationRevisions,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$MonthlyAllocationRevisionsTableFilterComposer(
                $db: $db,
                $table: $db.monthlyAllocationRevisions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$BudgetFundingAssignmentsTableOrderingComposer
    extends Composer<_$AppDatabase, $BudgetFundingAssignmentsTable> {
  $$BudgetFundingAssignmentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get itemId => $composableBuilder(
    column: $table.itemId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get itemType => $composableBuilder(
    column: $table.itemType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fundingSource => $composableBuilder(
    column: $table.fundingSource,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentChannel => $composableBuilder(
    column: $table.paymentChannel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get includedInSpendingBudget => $composableBuilder(
    column: $table.includedInSpendingBudget,
    builder: (column) => ColumnOrderings(column),
  );

  $$MonthlyAllocationRevisionsTableOrderingComposer get revisionId {
    final $$MonthlyAllocationRevisionsTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.revisionId,
          referencedTable: $db.monthlyAllocationRevisions,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$MonthlyAllocationRevisionsTableOrderingComposer(
                $db: $db,
                $table: $db.monthlyAllocationRevisions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$BudgetFundingAssignmentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BudgetFundingAssignmentsTable> {
  $$BudgetFundingAssignmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get itemId =>
      $composableBuilder(column: $table.itemId, builder: (column) => column);

  GeneratedColumn<String> get itemType =>
      $composableBuilder(column: $table.itemType, builder: (column) => column);

  GeneratedColumnWithTypeConverter<BudgetSource, String> get fundingSource =>
      $composableBuilder(
        column: $table.fundingSource,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<PaymentChannel, String> get paymentChannel =>
      $composableBuilder(
        column: $table.paymentChannel,
        builder: (column) => column,
      );

  GeneratedColumn<bool> get includedInSpendingBudget => $composableBuilder(
    column: $table.includedInSpendingBudget,
    builder: (column) => column,
  );

  $$MonthlyAllocationRevisionsTableAnnotationComposer get revisionId {
    final $$MonthlyAllocationRevisionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.revisionId,
          referencedTable: $db.monthlyAllocationRevisions,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$MonthlyAllocationRevisionsTableAnnotationComposer(
                $db: $db,
                $table: $db.monthlyAllocationRevisions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$BudgetFundingAssignmentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BudgetFundingAssignmentsTable,
          BudgetFundingAssignment,
          $$BudgetFundingAssignmentsTableFilterComposer,
          $$BudgetFundingAssignmentsTableOrderingComposer,
          $$BudgetFundingAssignmentsTableAnnotationComposer,
          $$BudgetFundingAssignmentsTableCreateCompanionBuilder,
          $$BudgetFundingAssignmentsTableUpdateCompanionBuilder,
          (BudgetFundingAssignment, $$BudgetFundingAssignmentsTableReferences),
          BudgetFundingAssignment,
          PrefetchHooks Function({bool revisionId})
        > {
  $$BudgetFundingAssignmentsTableTableManager(
    _$AppDatabase db,
    $BudgetFundingAssignmentsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BudgetFundingAssignmentsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$BudgetFundingAssignmentsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$BudgetFundingAssignmentsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> itemId = const Value.absent(),
                Value<String> itemType = const Value.absent(),
                Value<int> revisionId = const Value.absent(),
                Value<BudgetSource> fundingSource = const Value.absent(),
                Value<PaymentChannel> paymentChannel = const Value.absent(),
                Value<bool> includedInSpendingBudget = const Value.absent(),
              }) => BudgetFundingAssignmentsCompanion(
                id: id,
                itemId: itemId,
                itemType: itemType,
                revisionId: revisionId,
                fundingSource: fundingSource,
                paymentChannel: paymentChannel,
                includedInSpendingBudget: includedInSpendingBudget,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String itemId,
                required String itemType,
                required int revisionId,
                required BudgetSource fundingSource,
                required PaymentChannel paymentChannel,
                required bool includedInSpendingBudget,
              }) => BudgetFundingAssignmentsCompanion.insert(
                id: id,
                itemId: itemId,
                itemType: itemType,
                revisionId: revisionId,
                fundingSource: fundingSource,
                paymentChannel: paymentChannel,
                includedInSpendingBudget: includedInSpendingBudget,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$BudgetFundingAssignmentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({revisionId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (revisionId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.revisionId,
                                referencedTable:
                                    $$BudgetFundingAssignmentsTableReferences
                                        ._revisionIdTable(db),
                                referencedColumn:
                                    $$BudgetFundingAssignmentsTableReferences
                                        ._revisionIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$BudgetFundingAssignmentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BudgetFundingAssignmentsTable,
      BudgetFundingAssignment,
      $$BudgetFundingAssignmentsTableFilterComposer,
      $$BudgetFundingAssignmentsTableOrderingComposer,
      $$BudgetFundingAssignmentsTableAnnotationComposer,
      $$BudgetFundingAssignmentsTableCreateCompanionBuilder,
      $$BudgetFundingAssignmentsTableUpdateCompanionBuilder,
      (BudgetFundingAssignment, $$BudgetFundingAssignmentsTableReferences),
      BudgetFundingAssignment,
      PrefetchHooks Function({bool revisionId})
    >;
typedef $$ExpenseRealizationsTableCreateCompanionBuilder =
    ExpenseRealizationsCompanion Function({
      Value<int> id,
      required DateTime transactionDate,
      required int amount,
      Value<String?> categoryId,
      required BudgetSource fundingSource,
      required PaymentChannel paymentChannel,
      Value<int?> monthlyAllocationRevisionId,
      Value<String?> referenceItemId,
      required VerificationStatus verificationStatus,
      Value<String?> userNotes,
    });
typedef $$ExpenseRealizationsTableUpdateCompanionBuilder =
    ExpenseRealizationsCompanion Function({
      Value<int> id,
      Value<DateTime> transactionDate,
      Value<int> amount,
      Value<String?> categoryId,
      Value<BudgetSource> fundingSource,
      Value<PaymentChannel> paymentChannel,
      Value<int?> monthlyAllocationRevisionId,
      Value<String?> referenceItemId,
      Value<VerificationStatus> verificationStatus,
      Value<String?> userNotes,
    });

final class $$ExpenseRealizationsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ExpenseRealizationsTable,
          ExpenseRealization
        > {
  $$ExpenseRealizationsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $MonthlyAllocationRevisionsTable _monthlyAllocationRevisionIdTable(
    _$AppDatabase db,
  ) => db.monthlyAllocationRevisions.createAlias(
    'expense_realizations__monthly_allocation_revision_id__monthly_allocation_revisions__id',
  );

  $$MonthlyAllocationRevisionsTableProcessedTableManager?
  get monthlyAllocationRevisionId {
    final $_column = $_itemColumn<int>('monthly_allocation_revision_id');
    if ($_column == null) return null;
    final manager = $$MonthlyAllocationRevisionsTableTableManager(
      $_db,
      $_db.monthlyAllocationRevisions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(
      _monthlyAllocationRevisionIdTable($_db),
    );
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ExpenseRealizationsTableFilterComposer
    extends Composer<_$AppDatabase, $ExpenseRealizationsTable> {
  $$ExpenseRealizationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get transactionDate => $composableBuilder(
    column: $table.transactionDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<BudgetSource, BudgetSource, String>
  get fundingSource => $composableBuilder(
    column: $table.fundingSource,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<PaymentChannel, PaymentChannel, String>
  get paymentChannel => $composableBuilder(
    column: $table.paymentChannel,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get referenceItemId => $composableBuilder(
    column: $table.referenceItemId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<VerificationStatus, VerificationStatus, String>
  get verificationStatus => $composableBuilder(
    column: $table.verificationStatus,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get userNotes => $composableBuilder(
    column: $table.userNotes,
    builder: (column) => ColumnFilters(column),
  );

  $$MonthlyAllocationRevisionsTableFilterComposer
  get monthlyAllocationRevisionId {
    final $$MonthlyAllocationRevisionsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.monthlyAllocationRevisionId,
          referencedTable: $db.monthlyAllocationRevisions,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$MonthlyAllocationRevisionsTableFilterComposer(
                $db: $db,
                $table: $db.monthlyAllocationRevisions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$ExpenseRealizationsTableOrderingComposer
    extends Composer<_$AppDatabase, $ExpenseRealizationsTable> {
  $$ExpenseRealizationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get transactionDate => $composableBuilder(
    column: $table.transactionDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fundingSource => $composableBuilder(
    column: $table.fundingSource,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentChannel => $composableBuilder(
    column: $table.paymentChannel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get referenceItemId => $composableBuilder(
    column: $table.referenceItemId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get verificationStatus => $composableBuilder(
    column: $table.verificationStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userNotes => $composableBuilder(
    column: $table.userNotes,
    builder: (column) => ColumnOrderings(column),
  );

  $$MonthlyAllocationRevisionsTableOrderingComposer
  get monthlyAllocationRevisionId {
    final $$MonthlyAllocationRevisionsTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.monthlyAllocationRevisionId,
          referencedTable: $db.monthlyAllocationRevisions,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$MonthlyAllocationRevisionsTableOrderingComposer(
                $db: $db,
                $table: $db.monthlyAllocationRevisions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$ExpenseRealizationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExpenseRealizationsTable> {
  $$ExpenseRealizationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get transactionDate => $composableBuilder(
    column: $table.transactionDate,
    builder: (column) => column,
  );

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<BudgetSource, String> get fundingSource =>
      $composableBuilder(
        column: $table.fundingSource,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<PaymentChannel, String> get paymentChannel =>
      $composableBuilder(
        column: $table.paymentChannel,
        builder: (column) => column,
      );

  GeneratedColumn<String> get referenceItemId => $composableBuilder(
    column: $table.referenceItemId,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<VerificationStatus, String>
  get verificationStatus => $composableBuilder(
    column: $table.verificationStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get userNotes =>
      $composableBuilder(column: $table.userNotes, builder: (column) => column);

  $$MonthlyAllocationRevisionsTableAnnotationComposer
  get monthlyAllocationRevisionId {
    final $$MonthlyAllocationRevisionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.monthlyAllocationRevisionId,
          referencedTable: $db.monthlyAllocationRevisions,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$MonthlyAllocationRevisionsTableAnnotationComposer(
                $db: $db,
                $table: $db.monthlyAllocationRevisions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$ExpenseRealizationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExpenseRealizationsTable,
          ExpenseRealization,
          $$ExpenseRealizationsTableFilterComposer,
          $$ExpenseRealizationsTableOrderingComposer,
          $$ExpenseRealizationsTableAnnotationComposer,
          $$ExpenseRealizationsTableCreateCompanionBuilder,
          $$ExpenseRealizationsTableUpdateCompanionBuilder,
          (ExpenseRealization, $$ExpenseRealizationsTableReferences),
          ExpenseRealization,
          PrefetchHooks Function({bool monthlyAllocationRevisionId})
        > {
  $$ExpenseRealizationsTableTableManager(
    _$AppDatabase db,
    $ExpenseRealizationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExpenseRealizationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExpenseRealizationsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ExpenseRealizationsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> transactionDate = const Value.absent(),
                Value<int> amount = const Value.absent(),
                Value<String?> categoryId = const Value.absent(),
                Value<BudgetSource> fundingSource = const Value.absent(),
                Value<PaymentChannel> paymentChannel = const Value.absent(),
                Value<int?> monthlyAllocationRevisionId = const Value.absent(),
                Value<String?> referenceItemId = const Value.absent(),
                Value<VerificationStatus> verificationStatus =
                    const Value.absent(),
                Value<String?> userNotes = const Value.absent(),
              }) => ExpenseRealizationsCompanion(
                id: id,
                transactionDate: transactionDate,
                amount: amount,
                categoryId: categoryId,
                fundingSource: fundingSource,
                paymentChannel: paymentChannel,
                monthlyAllocationRevisionId: monthlyAllocationRevisionId,
                referenceItemId: referenceItemId,
                verificationStatus: verificationStatus,
                userNotes: userNotes,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime transactionDate,
                required int amount,
                Value<String?> categoryId = const Value.absent(),
                required BudgetSource fundingSource,
                required PaymentChannel paymentChannel,
                Value<int?> monthlyAllocationRevisionId = const Value.absent(),
                Value<String?> referenceItemId = const Value.absent(),
                required VerificationStatus verificationStatus,
                Value<String?> userNotes = const Value.absent(),
              }) => ExpenseRealizationsCompanion.insert(
                id: id,
                transactionDate: transactionDate,
                amount: amount,
                categoryId: categoryId,
                fundingSource: fundingSource,
                paymentChannel: paymentChannel,
                monthlyAllocationRevisionId: monthlyAllocationRevisionId,
                referenceItemId: referenceItemId,
                verificationStatus: verificationStatus,
                userNotes: userNotes,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ExpenseRealizationsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({monthlyAllocationRevisionId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (monthlyAllocationRevisionId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn:
                                    table.monthlyAllocationRevisionId,
                                referencedTable:
                                    $$ExpenseRealizationsTableReferences
                                        ._monthlyAllocationRevisionIdTable(db),
                                referencedColumn:
                                    $$ExpenseRealizationsTableReferences
                                        ._monthlyAllocationRevisionIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ExpenseRealizationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExpenseRealizationsTable,
      ExpenseRealization,
      $$ExpenseRealizationsTableFilterComposer,
      $$ExpenseRealizationsTableOrderingComposer,
      $$ExpenseRealizationsTableAnnotationComposer,
      $$ExpenseRealizationsTableCreateCompanionBuilder,
      $$ExpenseRealizationsTableUpdateCompanionBuilder,
      (ExpenseRealization, $$ExpenseRealizationsTableReferences),
      ExpenseRealization,
      PrefetchHooks Function({bool monthlyAllocationRevisionId})
    >;
typedef $$SubscriptionsTableCreateCompanionBuilder =
    SubscriptionsCompanion Function({
      Value<int> id,
      required String nama,
      required SubscriptionCycle siklus,
      required int nominal,
      required int bulanTagihan,
      Value<int?> tanggalTagihan,
      required AnnualFundingMethod metodeTahunan,
      required SubscriptionFundingSource sumberAnggaran,
      required int saldoCadangan,
      required bool aktif,
      required bool pengingatAktif,
    });
typedef $$SubscriptionsTableUpdateCompanionBuilder =
    SubscriptionsCompanion Function({
      Value<int> id,
      Value<String> nama,
      Value<SubscriptionCycle> siklus,
      Value<int> nominal,
      Value<int> bulanTagihan,
      Value<int?> tanggalTagihan,
      Value<AnnualFundingMethod> metodeTahunan,
      Value<SubscriptionFundingSource> sumberAnggaran,
      Value<int> saldoCadangan,
      Value<bool> aktif,
      Value<bool> pengingatAktif,
    });

final class $$SubscriptionsTableReferences
    extends BaseReferences<_$AppDatabase, $SubscriptionsTable, Subscription> {
  $$SubscriptionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<
    $SubscriptionReserveLedgersTable,
    List<SubscriptionReserveLedger>
  >
  _subscriptionReserveLedgersRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.subscriptionReserveLedgers,
        aliasName:
            'subscriptions__id__subscription_reserve_ledgers__subscription_id',
      );

  $$SubscriptionReserveLedgersTableProcessedTableManager
  get subscriptionReserveLedgersRefs {
    final manager = $$SubscriptionReserveLedgersTableTableManager(
      $_db,
      $_db.subscriptionReserveLedgers,
    ).filter((f) => f.subscriptionId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _subscriptionReserveLedgersRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$SubscriptionsTableFilterComposer
    extends Composer<_$AppDatabase, $SubscriptionsTable> {
  $$SubscriptionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nama => $composableBuilder(
    column: $table.nama,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<SubscriptionCycle, SubscriptionCycle, String>
  get siklus => $composableBuilder(
    column: $table.siklus,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get nominal => $composableBuilder(
    column: $table.nominal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get bulanTagihan => $composableBuilder(
    column: $table.bulanTagihan,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get tanggalTagihan => $composableBuilder(
    column: $table.tanggalTagihan,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<
    AnnualFundingMethod,
    AnnualFundingMethod,
    String
  >
  get metodeTahunan => $composableBuilder(
    column: $table.metodeTahunan,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<
    SubscriptionFundingSource,
    SubscriptionFundingSource,
    String
  >
  get sumberAnggaran => $composableBuilder(
    column: $table.sumberAnggaran,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get saldoCadangan => $composableBuilder(
    column: $table.saldoCadangan,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get aktif => $composableBuilder(
    column: $table.aktif,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get pengingatAktif => $composableBuilder(
    column: $table.pengingatAktif,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> subscriptionReserveLedgersRefs(
    Expression<bool> Function($$SubscriptionReserveLedgersTableFilterComposer f)
    f,
  ) {
    final $$SubscriptionReserveLedgersTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.subscriptionReserveLedgers,
          getReferencedColumn: (t) => t.subscriptionId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SubscriptionReserveLedgersTableFilterComposer(
                $db: $db,
                $table: $db.subscriptionReserveLedgers,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$SubscriptionsTableOrderingComposer
    extends Composer<_$AppDatabase, $SubscriptionsTable> {
  $$SubscriptionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nama => $composableBuilder(
    column: $table.nama,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get siklus => $composableBuilder(
    column: $table.siklus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get nominal => $composableBuilder(
    column: $table.nominal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get bulanTagihan => $composableBuilder(
    column: $table.bulanTagihan,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get tanggalTagihan => $composableBuilder(
    column: $table.tanggalTagihan,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get metodeTahunan => $composableBuilder(
    column: $table.metodeTahunan,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sumberAnggaran => $composableBuilder(
    column: $table.sumberAnggaran,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get saldoCadangan => $composableBuilder(
    column: $table.saldoCadangan,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get aktif => $composableBuilder(
    column: $table.aktif,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get pengingatAktif => $composableBuilder(
    column: $table.pengingatAktif,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SubscriptionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SubscriptionsTable> {
  $$SubscriptionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nama =>
      $composableBuilder(column: $table.nama, builder: (column) => column);

  GeneratedColumnWithTypeConverter<SubscriptionCycle, String> get siklus =>
      $composableBuilder(column: $table.siklus, builder: (column) => column);

  GeneratedColumn<int> get nominal =>
      $composableBuilder(column: $table.nominal, builder: (column) => column);

  GeneratedColumn<int> get bulanTagihan => $composableBuilder(
    column: $table.bulanTagihan,
    builder: (column) => column,
  );

  GeneratedColumn<int> get tanggalTagihan => $composableBuilder(
    column: $table.tanggalTagihan,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<AnnualFundingMethod, String>
  get metodeTahunan => $composableBuilder(
    column: $table.metodeTahunan,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<SubscriptionFundingSource, String>
  get sumberAnggaran => $composableBuilder(
    column: $table.sumberAnggaran,
    builder: (column) => column,
  );

  GeneratedColumn<int> get saldoCadangan => $composableBuilder(
    column: $table.saldoCadangan,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get aktif =>
      $composableBuilder(column: $table.aktif, builder: (column) => column);

  GeneratedColumn<bool> get pengingatAktif => $composableBuilder(
    column: $table.pengingatAktif,
    builder: (column) => column,
  );

  Expression<T> subscriptionReserveLedgersRefs<T extends Object>(
    Expression<T> Function(
      $$SubscriptionReserveLedgersTableAnnotationComposer a,
    )
    f,
  ) {
    final $$SubscriptionReserveLedgersTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.subscriptionReserveLedgers,
          getReferencedColumn: (t) => t.subscriptionId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$SubscriptionReserveLedgersTableAnnotationComposer(
                $db: $db,
                $table: $db.subscriptionReserveLedgers,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$SubscriptionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SubscriptionsTable,
          Subscription,
          $$SubscriptionsTableFilterComposer,
          $$SubscriptionsTableOrderingComposer,
          $$SubscriptionsTableAnnotationComposer,
          $$SubscriptionsTableCreateCompanionBuilder,
          $$SubscriptionsTableUpdateCompanionBuilder,
          (Subscription, $$SubscriptionsTableReferences),
          Subscription,
          PrefetchHooks Function({bool subscriptionReserveLedgersRefs})
        > {
  $$SubscriptionsTableTableManager(_$AppDatabase db, $SubscriptionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SubscriptionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SubscriptionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SubscriptionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nama = const Value.absent(),
                Value<SubscriptionCycle> siklus = const Value.absent(),
                Value<int> nominal = const Value.absent(),
                Value<int> bulanTagihan = const Value.absent(),
                Value<int?> tanggalTagihan = const Value.absent(),
                Value<AnnualFundingMethod> metodeTahunan = const Value.absent(),
                Value<SubscriptionFundingSource> sumberAnggaran =
                    const Value.absent(),
                Value<int> saldoCadangan = const Value.absent(),
                Value<bool> aktif = const Value.absent(),
                Value<bool> pengingatAktif = const Value.absent(),
              }) => SubscriptionsCompanion(
                id: id,
                nama: nama,
                siklus: siklus,
                nominal: nominal,
                bulanTagihan: bulanTagihan,
                tanggalTagihan: tanggalTagihan,
                metodeTahunan: metodeTahunan,
                sumberAnggaran: sumberAnggaran,
                saldoCadangan: saldoCadangan,
                aktif: aktif,
                pengingatAktif: pengingatAktif,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nama,
                required SubscriptionCycle siklus,
                required int nominal,
                required int bulanTagihan,
                Value<int?> tanggalTagihan = const Value.absent(),
                required AnnualFundingMethod metodeTahunan,
                required SubscriptionFundingSource sumberAnggaran,
                required int saldoCadangan,
                required bool aktif,
                required bool pengingatAktif,
              }) => SubscriptionsCompanion.insert(
                id: id,
                nama: nama,
                siklus: siklus,
                nominal: nominal,
                bulanTagihan: bulanTagihan,
                tanggalTagihan: tanggalTagihan,
                metodeTahunan: metodeTahunan,
                sumberAnggaran: sumberAnggaran,
                saldoCadangan: saldoCadangan,
                aktif: aktif,
                pengingatAktif: pengingatAktif,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SubscriptionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({subscriptionReserveLedgersRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (subscriptionReserveLedgersRefs)
                  db.subscriptionReserveLedgers,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (subscriptionReserveLedgersRefs)
                    await $_getPrefetchedData<
                      Subscription,
                      $SubscriptionsTable,
                      SubscriptionReserveLedger
                    >(
                      currentTable: table,
                      referencedTable: $$SubscriptionsTableReferences
                          ._subscriptionReserveLedgersRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$SubscriptionsTableReferences(
                            db,
                            table,
                            p0,
                          ).subscriptionReserveLedgersRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.subscriptionId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$SubscriptionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SubscriptionsTable,
      Subscription,
      $$SubscriptionsTableFilterComposer,
      $$SubscriptionsTableOrderingComposer,
      $$SubscriptionsTableAnnotationComposer,
      $$SubscriptionsTableCreateCompanionBuilder,
      $$SubscriptionsTableUpdateCompanionBuilder,
      (Subscription, $$SubscriptionsTableReferences),
      Subscription,
      PrefetchHooks Function({bool subscriptionReserveLedgersRefs})
    >;
typedef $$SubscriptionReserveLedgersTableCreateCompanionBuilder =
    SubscriptionReserveLedgersCompanion Function({
      Value<int> id,
      required int subscriptionId,
      required int tahun,
      required int bulan,
      required int saldoAwal,
      required int kontribusi,
      required int pembayaran,
      required int saldoAkhir,
      required DateTime dibuatPada,
    });
typedef $$SubscriptionReserveLedgersTableUpdateCompanionBuilder =
    SubscriptionReserveLedgersCompanion Function({
      Value<int> id,
      Value<int> subscriptionId,
      Value<int> tahun,
      Value<int> bulan,
      Value<int> saldoAwal,
      Value<int> kontribusi,
      Value<int> pembayaran,
      Value<int> saldoAkhir,
      Value<DateTime> dibuatPada,
    });

final class $$SubscriptionReserveLedgersTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $SubscriptionReserveLedgersTable,
          SubscriptionReserveLedger
        > {
  $$SubscriptionReserveLedgersTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $SubscriptionsTable _subscriptionIdTable(_$AppDatabase db) =>
      db.subscriptions.createAlias(
        'subscription_reserve_ledgers__subscription_id__subscriptions__id',
      );

  $$SubscriptionsTableProcessedTableManager get subscriptionId {
    final $_column = $_itemColumn<int>('subscription_id')!;

    final manager = $$SubscriptionsTableTableManager(
      $_db,
      $_db.subscriptions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_subscriptionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SubscriptionReserveLedgersTableFilterComposer
    extends Composer<_$AppDatabase, $SubscriptionReserveLedgersTable> {
  $$SubscriptionReserveLedgersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get tahun => $composableBuilder(
    column: $table.tahun,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get bulan => $composableBuilder(
    column: $table.bulan,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get saldoAwal => $composableBuilder(
    column: $table.saldoAwal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get kontribusi => $composableBuilder(
    column: $table.kontribusi,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pembayaran => $composableBuilder(
    column: $table.pembayaran,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get saldoAkhir => $composableBuilder(
    column: $table.saldoAkhir,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dibuatPada => $composableBuilder(
    column: $table.dibuatPada,
    builder: (column) => ColumnFilters(column),
  );

  $$SubscriptionsTableFilterComposer get subscriptionId {
    final $$SubscriptionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subscriptionId,
      referencedTable: $db.subscriptions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubscriptionsTableFilterComposer(
            $db: $db,
            $table: $db.subscriptions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SubscriptionReserveLedgersTableOrderingComposer
    extends Composer<_$AppDatabase, $SubscriptionReserveLedgersTable> {
  $$SubscriptionReserveLedgersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get tahun => $composableBuilder(
    column: $table.tahun,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get bulan => $composableBuilder(
    column: $table.bulan,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get saldoAwal => $composableBuilder(
    column: $table.saldoAwal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get kontribusi => $composableBuilder(
    column: $table.kontribusi,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pembayaran => $composableBuilder(
    column: $table.pembayaran,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get saldoAkhir => $composableBuilder(
    column: $table.saldoAkhir,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dibuatPada => $composableBuilder(
    column: $table.dibuatPada,
    builder: (column) => ColumnOrderings(column),
  );

  $$SubscriptionsTableOrderingComposer get subscriptionId {
    final $$SubscriptionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subscriptionId,
      referencedTable: $db.subscriptions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubscriptionsTableOrderingComposer(
            $db: $db,
            $table: $db.subscriptions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SubscriptionReserveLedgersTableAnnotationComposer
    extends Composer<_$AppDatabase, $SubscriptionReserveLedgersTable> {
  $$SubscriptionReserveLedgersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get tahun =>
      $composableBuilder(column: $table.tahun, builder: (column) => column);

  GeneratedColumn<int> get bulan =>
      $composableBuilder(column: $table.bulan, builder: (column) => column);

  GeneratedColumn<int> get saldoAwal =>
      $composableBuilder(column: $table.saldoAwal, builder: (column) => column);

  GeneratedColumn<int> get kontribusi => $composableBuilder(
    column: $table.kontribusi,
    builder: (column) => column,
  );

  GeneratedColumn<int> get pembayaran => $composableBuilder(
    column: $table.pembayaran,
    builder: (column) => column,
  );

  GeneratedColumn<int> get saldoAkhir => $composableBuilder(
    column: $table.saldoAkhir,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get dibuatPada => $composableBuilder(
    column: $table.dibuatPada,
    builder: (column) => column,
  );

  $$SubscriptionsTableAnnotationComposer get subscriptionId {
    final $$SubscriptionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.subscriptionId,
      referencedTable: $db.subscriptions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SubscriptionsTableAnnotationComposer(
            $db: $db,
            $table: $db.subscriptions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SubscriptionReserveLedgersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SubscriptionReserveLedgersTable,
          SubscriptionReserveLedger,
          $$SubscriptionReserveLedgersTableFilterComposer,
          $$SubscriptionReserveLedgersTableOrderingComposer,
          $$SubscriptionReserveLedgersTableAnnotationComposer,
          $$SubscriptionReserveLedgersTableCreateCompanionBuilder,
          $$SubscriptionReserveLedgersTableUpdateCompanionBuilder,
          (
            SubscriptionReserveLedger,
            $$SubscriptionReserveLedgersTableReferences,
          ),
          SubscriptionReserveLedger,
          PrefetchHooks Function({bool subscriptionId})
        > {
  $$SubscriptionReserveLedgersTableTableManager(
    _$AppDatabase db,
    $SubscriptionReserveLedgersTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SubscriptionReserveLedgersTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$SubscriptionReserveLedgersTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$SubscriptionReserveLedgersTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> subscriptionId = const Value.absent(),
                Value<int> tahun = const Value.absent(),
                Value<int> bulan = const Value.absent(),
                Value<int> saldoAwal = const Value.absent(),
                Value<int> kontribusi = const Value.absent(),
                Value<int> pembayaran = const Value.absent(),
                Value<int> saldoAkhir = const Value.absent(),
                Value<DateTime> dibuatPada = const Value.absent(),
              }) => SubscriptionReserveLedgersCompanion(
                id: id,
                subscriptionId: subscriptionId,
                tahun: tahun,
                bulan: bulan,
                saldoAwal: saldoAwal,
                kontribusi: kontribusi,
                pembayaran: pembayaran,
                saldoAkhir: saldoAkhir,
                dibuatPada: dibuatPada,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int subscriptionId,
                required int tahun,
                required int bulan,
                required int saldoAwal,
                required int kontribusi,
                required int pembayaran,
                required int saldoAkhir,
                required DateTime dibuatPada,
              }) => SubscriptionReserveLedgersCompanion.insert(
                id: id,
                subscriptionId: subscriptionId,
                tahun: tahun,
                bulan: bulan,
                saldoAwal: saldoAwal,
                kontribusi: kontribusi,
                pembayaran: pembayaran,
                saldoAkhir: saldoAkhir,
                dibuatPada: dibuatPada,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SubscriptionReserveLedgersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({subscriptionId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (subscriptionId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.subscriptionId,
                                referencedTable:
                                    $$SubscriptionReserveLedgersTableReferences
                                        ._subscriptionIdTable(db),
                                referencedColumn:
                                    $$SubscriptionReserveLedgersTableReferences
                                        ._subscriptionIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SubscriptionReserveLedgersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SubscriptionReserveLedgersTable,
      SubscriptionReserveLedger,
      $$SubscriptionReserveLedgersTableFilterComposer,
      $$SubscriptionReserveLedgersTableOrderingComposer,
      $$SubscriptionReserveLedgersTableAnnotationComposer,
      $$SubscriptionReserveLedgersTableCreateCompanionBuilder,
      $$SubscriptionReserveLedgersTableUpdateCompanionBuilder,
      (SubscriptionReserveLedger, $$SubscriptionReserveLedgersTableReferences),
      SubscriptionReserveLedger,
      PrefetchHooks Function({bool subscriptionId})
    >;
typedef $$EmergencyFundTargetsTableCreateCompanionBuilder =
    EmergencyFundTargetsCompanion Function({
      Value<int> id,
      required int targetJumlahBulan,
      Value<int?> pengeluaranPokokManual,
      required int saldoSaatIni,
      Value<DateTime?> targetTanggalTercapai,
      required DateTime diperbaruiPada,
    });
typedef $$EmergencyFundTargetsTableUpdateCompanionBuilder =
    EmergencyFundTargetsCompanion Function({
      Value<int> id,
      Value<int> targetJumlahBulan,
      Value<int?> pengeluaranPokokManual,
      Value<int> saldoSaatIni,
      Value<DateTime?> targetTanggalTercapai,
      Value<DateTime> diperbaruiPada,
    });

class $$EmergencyFundTargetsTableFilterComposer
    extends Composer<_$AppDatabase, $EmergencyFundTargetsTable> {
  $$EmergencyFundTargetsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get targetJumlahBulan => $composableBuilder(
    column: $table.targetJumlahBulan,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pengeluaranPokokManual => $composableBuilder(
    column: $table.pengeluaranPokokManual,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get saldoSaatIni => $composableBuilder(
    column: $table.saldoSaatIni,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get targetTanggalTercapai => $composableBuilder(
    column: $table.targetTanggalTercapai,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get diperbaruiPada => $composableBuilder(
    column: $table.diperbaruiPada,
    builder: (column) => ColumnFilters(column),
  );
}

class $$EmergencyFundTargetsTableOrderingComposer
    extends Composer<_$AppDatabase, $EmergencyFundTargetsTable> {
  $$EmergencyFundTargetsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get targetJumlahBulan => $composableBuilder(
    column: $table.targetJumlahBulan,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pengeluaranPokokManual => $composableBuilder(
    column: $table.pengeluaranPokokManual,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get saldoSaatIni => $composableBuilder(
    column: $table.saldoSaatIni,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get targetTanggalTercapai => $composableBuilder(
    column: $table.targetTanggalTercapai,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get diperbaruiPada => $composableBuilder(
    column: $table.diperbaruiPada,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$EmergencyFundTargetsTableAnnotationComposer
    extends Composer<_$AppDatabase, $EmergencyFundTargetsTable> {
  $$EmergencyFundTargetsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get targetJumlahBulan => $composableBuilder(
    column: $table.targetJumlahBulan,
    builder: (column) => column,
  );

  GeneratedColumn<int> get pengeluaranPokokManual => $composableBuilder(
    column: $table.pengeluaranPokokManual,
    builder: (column) => column,
  );

  GeneratedColumn<int> get saldoSaatIni => $composableBuilder(
    column: $table.saldoSaatIni,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get targetTanggalTercapai => $composableBuilder(
    column: $table.targetTanggalTercapai,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get diperbaruiPada => $composableBuilder(
    column: $table.diperbaruiPada,
    builder: (column) => column,
  );
}

class $$EmergencyFundTargetsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EmergencyFundTargetsTable,
          EmergencyFundTarget,
          $$EmergencyFundTargetsTableFilterComposer,
          $$EmergencyFundTargetsTableOrderingComposer,
          $$EmergencyFundTargetsTableAnnotationComposer,
          $$EmergencyFundTargetsTableCreateCompanionBuilder,
          $$EmergencyFundTargetsTableUpdateCompanionBuilder,
          (
            EmergencyFundTarget,
            BaseReferences<
              _$AppDatabase,
              $EmergencyFundTargetsTable,
              EmergencyFundTarget
            >,
          ),
          EmergencyFundTarget,
          PrefetchHooks Function()
        > {
  $$EmergencyFundTargetsTableTableManager(
    _$AppDatabase db,
    $EmergencyFundTargetsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EmergencyFundTargetsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EmergencyFundTargetsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$EmergencyFundTargetsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> targetJumlahBulan = const Value.absent(),
                Value<int?> pengeluaranPokokManual = const Value.absent(),
                Value<int> saldoSaatIni = const Value.absent(),
                Value<DateTime?> targetTanggalTercapai = const Value.absent(),
                Value<DateTime> diperbaruiPada = const Value.absent(),
              }) => EmergencyFundTargetsCompanion(
                id: id,
                targetJumlahBulan: targetJumlahBulan,
                pengeluaranPokokManual: pengeluaranPokokManual,
                saldoSaatIni: saldoSaatIni,
                targetTanggalTercapai: targetTanggalTercapai,
                diperbaruiPada: diperbaruiPada,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int targetJumlahBulan,
                Value<int?> pengeluaranPokokManual = const Value.absent(),
                required int saldoSaatIni,
                Value<DateTime?> targetTanggalTercapai = const Value.absent(),
                required DateTime diperbaruiPada,
              }) => EmergencyFundTargetsCompanion.insert(
                id: id,
                targetJumlahBulan: targetJumlahBulan,
                pengeluaranPokokManual: pengeluaranPokokManual,
                saldoSaatIni: saldoSaatIni,
                targetTanggalTercapai: targetTanggalTercapai,
                diperbaruiPada: diperbaruiPada,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$EmergencyFundTargetsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EmergencyFundTargetsTable,
      EmergencyFundTarget,
      $$EmergencyFundTargetsTableFilterComposer,
      $$EmergencyFundTargetsTableOrderingComposer,
      $$EmergencyFundTargetsTableAnnotationComposer,
      $$EmergencyFundTargetsTableCreateCompanionBuilder,
      $$EmergencyFundTargetsTableUpdateCompanionBuilder,
      (
        EmergencyFundTarget,
        BaseReferences<
          _$AppDatabase,
          $EmergencyFundTargetsTable,
          EmergencyFundTarget
        >,
      ),
      EmergencyFundTarget,
      PrefetchHooks Function()
    >;
typedef $$EmergencyFundContributionsTableCreateCompanionBuilder =
    EmergencyFundContributionsCompanion Function({
      Value<int> id,
      required int tahun,
      required int bulan,
      required int nominal,
      required PlanActualStatus status,
      Value<String?> catatan,
      required DateTime dibuatPada,
    });
typedef $$EmergencyFundContributionsTableUpdateCompanionBuilder =
    EmergencyFundContributionsCompanion Function({
      Value<int> id,
      Value<int> tahun,
      Value<int> bulan,
      Value<int> nominal,
      Value<PlanActualStatus> status,
      Value<String?> catatan,
      Value<DateTime> dibuatPada,
    });

class $$EmergencyFundContributionsTableFilterComposer
    extends Composer<_$AppDatabase, $EmergencyFundContributionsTable> {
  $$EmergencyFundContributionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get tahun => $composableBuilder(
    column: $table.tahun,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get bulan => $composableBuilder(
    column: $table.bulan,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get nominal => $composableBuilder(
    column: $table.nominal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<PlanActualStatus, PlanActualStatus, String>
  get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get catatan => $composableBuilder(
    column: $table.catatan,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dibuatPada => $composableBuilder(
    column: $table.dibuatPada,
    builder: (column) => ColumnFilters(column),
  );
}

class $$EmergencyFundContributionsTableOrderingComposer
    extends Composer<_$AppDatabase, $EmergencyFundContributionsTable> {
  $$EmergencyFundContributionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get tahun => $composableBuilder(
    column: $table.tahun,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get bulan => $composableBuilder(
    column: $table.bulan,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get nominal => $composableBuilder(
    column: $table.nominal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get catatan => $composableBuilder(
    column: $table.catatan,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dibuatPada => $composableBuilder(
    column: $table.dibuatPada,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$EmergencyFundContributionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $EmergencyFundContributionsTable> {
  $$EmergencyFundContributionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get tahun =>
      $composableBuilder(column: $table.tahun, builder: (column) => column);

  GeneratedColumn<int> get bulan =>
      $composableBuilder(column: $table.bulan, builder: (column) => column);

  GeneratedColumn<int> get nominal =>
      $composableBuilder(column: $table.nominal, builder: (column) => column);

  GeneratedColumnWithTypeConverter<PlanActualStatus, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get catatan =>
      $composableBuilder(column: $table.catatan, builder: (column) => column);

  GeneratedColumn<DateTime> get dibuatPada => $composableBuilder(
    column: $table.dibuatPada,
    builder: (column) => column,
  );
}

class $$EmergencyFundContributionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EmergencyFundContributionsTable,
          EmergencyFundContribution,
          $$EmergencyFundContributionsTableFilterComposer,
          $$EmergencyFundContributionsTableOrderingComposer,
          $$EmergencyFundContributionsTableAnnotationComposer,
          $$EmergencyFundContributionsTableCreateCompanionBuilder,
          $$EmergencyFundContributionsTableUpdateCompanionBuilder,
          (
            EmergencyFundContribution,
            BaseReferences<
              _$AppDatabase,
              $EmergencyFundContributionsTable,
              EmergencyFundContribution
            >,
          ),
          EmergencyFundContribution,
          PrefetchHooks Function()
        > {
  $$EmergencyFundContributionsTableTableManager(
    _$AppDatabase db,
    $EmergencyFundContributionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EmergencyFundContributionsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$EmergencyFundContributionsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$EmergencyFundContributionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> tahun = const Value.absent(),
                Value<int> bulan = const Value.absent(),
                Value<int> nominal = const Value.absent(),
                Value<PlanActualStatus> status = const Value.absent(),
                Value<String?> catatan = const Value.absent(),
                Value<DateTime> dibuatPada = const Value.absent(),
              }) => EmergencyFundContributionsCompanion(
                id: id,
                tahun: tahun,
                bulan: bulan,
                nominal: nominal,
                status: status,
                catatan: catatan,
                dibuatPada: dibuatPada,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int tahun,
                required int bulan,
                required int nominal,
                required PlanActualStatus status,
                Value<String?> catatan = const Value.absent(),
                required DateTime dibuatPada,
              }) => EmergencyFundContributionsCompanion.insert(
                id: id,
                tahun: tahun,
                bulan: bulan,
                nominal: nominal,
                status: status,
                catatan: catatan,
                dibuatPada: dibuatPada,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$EmergencyFundContributionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EmergencyFundContributionsTable,
      EmergencyFundContribution,
      $$EmergencyFundContributionsTableFilterComposer,
      $$EmergencyFundContributionsTableOrderingComposer,
      $$EmergencyFundContributionsTableAnnotationComposer,
      $$EmergencyFundContributionsTableCreateCompanionBuilder,
      $$EmergencyFundContributionsTableUpdateCompanionBuilder,
      (
        EmergencyFundContribution,
        BaseReferences<
          _$AppDatabase,
          $EmergencyFundContributionsTable,
          EmergencyFundContribution
        >,
      ),
      EmergencyFundContribution,
      PrefetchHooks Function()
    >;
typedef $$OtherSavingsContributionsTableCreateCompanionBuilder =
    OtherSavingsContributionsCompanion Function({
      Value<int> id,
      required String nama,
      required int nominal,
      required int tahun,
      required int bulan,
      required PlanActualStatus status,
    });
typedef $$OtherSavingsContributionsTableUpdateCompanionBuilder =
    OtherSavingsContributionsCompanion Function({
      Value<int> id,
      Value<String> nama,
      Value<int> nominal,
      Value<int> tahun,
      Value<int> bulan,
      Value<PlanActualStatus> status,
    });

class $$OtherSavingsContributionsTableFilterComposer
    extends Composer<_$AppDatabase, $OtherSavingsContributionsTable> {
  $$OtherSavingsContributionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nama => $composableBuilder(
    column: $table.nama,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get nominal => $composableBuilder(
    column: $table.nominal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get tahun => $composableBuilder(
    column: $table.tahun,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get bulan => $composableBuilder(
    column: $table.bulan,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<PlanActualStatus, PlanActualStatus, String>
  get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );
}

class $$OtherSavingsContributionsTableOrderingComposer
    extends Composer<_$AppDatabase, $OtherSavingsContributionsTable> {
  $$OtherSavingsContributionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nama => $composableBuilder(
    column: $table.nama,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get nominal => $composableBuilder(
    column: $table.nominal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get tahun => $composableBuilder(
    column: $table.tahun,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get bulan => $composableBuilder(
    column: $table.bulan,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$OtherSavingsContributionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $OtherSavingsContributionsTable> {
  $$OtherSavingsContributionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nama =>
      $composableBuilder(column: $table.nama, builder: (column) => column);

  GeneratedColumn<int> get nominal =>
      $composableBuilder(column: $table.nominal, builder: (column) => column);

  GeneratedColumn<int> get tahun =>
      $composableBuilder(column: $table.tahun, builder: (column) => column);

  GeneratedColumn<int> get bulan =>
      $composableBuilder(column: $table.bulan, builder: (column) => column);

  GeneratedColumnWithTypeConverter<PlanActualStatus, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);
}

class $$OtherSavingsContributionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $OtherSavingsContributionsTable,
          OtherSavingsContribution,
          $$OtherSavingsContributionsTableFilterComposer,
          $$OtherSavingsContributionsTableOrderingComposer,
          $$OtherSavingsContributionsTableAnnotationComposer,
          $$OtherSavingsContributionsTableCreateCompanionBuilder,
          $$OtherSavingsContributionsTableUpdateCompanionBuilder,
          (
            OtherSavingsContribution,
            BaseReferences<
              _$AppDatabase,
              $OtherSavingsContributionsTable,
              OtherSavingsContribution
            >,
          ),
          OtherSavingsContribution,
          PrefetchHooks Function()
        > {
  $$OtherSavingsContributionsTableTableManager(
    _$AppDatabase db,
    $OtherSavingsContributionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OtherSavingsContributionsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$OtherSavingsContributionsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$OtherSavingsContributionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nama = const Value.absent(),
                Value<int> nominal = const Value.absent(),
                Value<int> tahun = const Value.absent(),
                Value<int> bulan = const Value.absent(),
                Value<PlanActualStatus> status = const Value.absent(),
              }) => OtherSavingsContributionsCompanion(
                id: id,
                nama: nama,
                nominal: nominal,
                tahun: tahun,
                bulan: bulan,
                status: status,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nama,
                required int nominal,
                required int tahun,
                required int bulan,
                required PlanActualStatus status,
              }) => OtherSavingsContributionsCompanion.insert(
                id: id,
                nama: nama,
                nominal: nominal,
                tahun: tahun,
                bulan: bulan,
                status: status,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$OtherSavingsContributionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $OtherSavingsContributionsTable,
      OtherSavingsContribution,
      $$OtherSavingsContributionsTableFilterComposer,
      $$OtherSavingsContributionsTableOrderingComposer,
      $$OtherSavingsContributionsTableAnnotationComposer,
      $$OtherSavingsContributionsTableCreateCompanionBuilder,
      $$OtherSavingsContributionsTableUpdateCompanionBuilder,
      (
        OtherSavingsContribution,
        BaseReferences<
          _$AppDatabase,
          $OtherSavingsContributionsTable,
          OtherSavingsContribution
        >,
      ),
      OtherSavingsContribution,
      PrefetchHooks Function()
    >;
typedef $$InvestmentPlatformAllocationsTableCreateCompanionBuilder =
    InvestmentPlatformAllocationsCompanion Function({
      Value<int> id,
      required int revisionId,
      required InvestmentPlatform platform,
      required int targetPercentageBp,
      required int targetAmount,
      required int roundedAmount,
      Value<DateTime?> plannedTransferDate,
      required PlanActualStatus status,
    });
typedef $$InvestmentPlatformAllocationsTableUpdateCompanionBuilder =
    InvestmentPlatformAllocationsCompanion Function({
      Value<int> id,
      Value<int> revisionId,
      Value<InvestmentPlatform> platform,
      Value<int> targetPercentageBp,
      Value<int> targetAmount,
      Value<int> roundedAmount,
      Value<DateTime?> plannedTransferDate,
      Value<PlanActualStatus> status,
    });

final class $$InvestmentPlatformAllocationsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $InvestmentPlatformAllocationsTable,
          InvestmentPlatformAllocation
        > {
  $$InvestmentPlatformAllocationsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $MonthlyAllocationRevisionsTable _revisionIdTable(
    _$AppDatabase db,
  ) => db.monthlyAllocationRevisions.createAlias(
    'investment_platform_allocations__revision_id__monthly_allocation_revisions__id',
  );

  $$MonthlyAllocationRevisionsTableProcessedTableManager get revisionId {
    final $_column = $_itemColumn<int>('revision_id')!;

    final manager = $$MonthlyAllocationRevisionsTableTableManager(
      $_db,
      $_db.monthlyAllocationRevisions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_revisionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$InvestmentPlatformAllocationsTableFilterComposer
    extends Composer<_$AppDatabase, $InvestmentPlatformAllocationsTable> {
  $$InvestmentPlatformAllocationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<InvestmentPlatform, InvestmentPlatform, String>
  get platform => $composableBuilder(
    column: $table.platform,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get targetPercentageBp => $composableBuilder(
    column: $table.targetPercentageBp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get targetAmount => $composableBuilder(
    column: $table.targetAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get roundedAmount => $composableBuilder(
    column: $table.roundedAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get plannedTransferDate => $composableBuilder(
    column: $table.plannedTransferDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<PlanActualStatus, PlanActualStatus, String>
  get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  $$MonthlyAllocationRevisionsTableFilterComposer get revisionId {
    final $$MonthlyAllocationRevisionsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.revisionId,
          referencedTable: $db.monthlyAllocationRevisions,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$MonthlyAllocationRevisionsTableFilterComposer(
                $db: $db,
                $table: $db.monthlyAllocationRevisions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$InvestmentPlatformAllocationsTableOrderingComposer
    extends Composer<_$AppDatabase, $InvestmentPlatformAllocationsTable> {
  $$InvestmentPlatformAllocationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get platform => $composableBuilder(
    column: $table.platform,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get targetPercentageBp => $composableBuilder(
    column: $table.targetPercentageBp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get targetAmount => $composableBuilder(
    column: $table.targetAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get roundedAmount => $composableBuilder(
    column: $table.roundedAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get plannedTransferDate => $composableBuilder(
    column: $table.plannedTransferDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  $$MonthlyAllocationRevisionsTableOrderingComposer get revisionId {
    final $$MonthlyAllocationRevisionsTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.revisionId,
          referencedTable: $db.monthlyAllocationRevisions,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$MonthlyAllocationRevisionsTableOrderingComposer(
                $db: $db,
                $table: $db.monthlyAllocationRevisions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$InvestmentPlatformAllocationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $InvestmentPlatformAllocationsTable> {
  $$InvestmentPlatformAllocationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<InvestmentPlatform, String> get platform =>
      $composableBuilder(column: $table.platform, builder: (column) => column);

  GeneratedColumn<int> get targetPercentageBp => $composableBuilder(
    column: $table.targetPercentageBp,
    builder: (column) => column,
  );

  GeneratedColumn<int> get targetAmount => $composableBuilder(
    column: $table.targetAmount,
    builder: (column) => column,
  );

  GeneratedColumn<int> get roundedAmount => $composableBuilder(
    column: $table.roundedAmount,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get plannedTransferDate => $composableBuilder(
    column: $table.plannedTransferDate,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<PlanActualStatus, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  $$MonthlyAllocationRevisionsTableAnnotationComposer get revisionId {
    final $$MonthlyAllocationRevisionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.revisionId,
          referencedTable: $db.monthlyAllocationRevisions,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$MonthlyAllocationRevisionsTableAnnotationComposer(
                $db: $db,
                $table: $db.monthlyAllocationRevisions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$InvestmentPlatformAllocationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InvestmentPlatformAllocationsTable,
          InvestmentPlatformAllocation,
          $$InvestmentPlatformAllocationsTableFilterComposer,
          $$InvestmentPlatformAllocationsTableOrderingComposer,
          $$InvestmentPlatformAllocationsTableAnnotationComposer,
          $$InvestmentPlatformAllocationsTableCreateCompanionBuilder,
          $$InvestmentPlatformAllocationsTableUpdateCompanionBuilder,
          (
            InvestmentPlatformAllocation,
            $$InvestmentPlatformAllocationsTableReferences,
          ),
          InvestmentPlatformAllocation,
          PrefetchHooks Function({bool revisionId})
        > {
  $$InvestmentPlatformAllocationsTableTableManager(
    _$AppDatabase db,
    $InvestmentPlatformAllocationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InvestmentPlatformAllocationsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$InvestmentPlatformAllocationsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$InvestmentPlatformAllocationsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> revisionId = const Value.absent(),
                Value<InvestmentPlatform> platform = const Value.absent(),
                Value<int> targetPercentageBp = const Value.absent(),
                Value<int> targetAmount = const Value.absent(),
                Value<int> roundedAmount = const Value.absent(),
                Value<DateTime?> plannedTransferDate = const Value.absent(),
                Value<PlanActualStatus> status = const Value.absent(),
              }) => InvestmentPlatformAllocationsCompanion(
                id: id,
                revisionId: revisionId,
                platform: platform,
                targetPercentageBp: targetPercentageBp,
                targetAmount: targetAmount,
                roundedAmount: roundedAmount,
                plannedTransferDate: plannedTransferDate,
                status: status,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int revisionId,
                required InvestmentPlatform platform,
                required int targetPercentageBp,
                required int targetAmount,
                required int roundedAmount,
                Value<DateTime?> plannedTransferDate = const Value.absent(),
                required PlanActualStatus status,
              }) => InvestmentPlatformAllocationsCompanion.insert(
                id: id,
                revisionId: revisionId,
                platform: platform,
                targetPercentageBp: targetPercentageBp,
                targetAmount: targetAmount,
                roundedAmount: roundedAmount,
                plannedTransferDate: plannedTransferDate,
                status: status,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$InvestmentPlatformAllocationsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({revisionId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (revisionId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.revisionId,
                                referencedTable:
                                    $$InvestmentPlatformAllocationsTableReferences
                                        ._revisionIdTable(db),
                                referencedColumn:
                                    $$InvestmentPlatformAllocationsTableReferences
                                        ._revisionIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$InvestmentPlatformAllocationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InvestmentPlatformAllocationsTable,
      InvestmentPlatformAllocation,
      $$InvestmentPlatformAllocationsTableFilterComposer,
      $$InvestmentPlatformAllocationsTableOrderingComposer,
      $$InvestmentPlatformAllocationsTableAnnotationComposer,
      $$InvestmentPlatformAllocationsTableCreateCompanionBuilder,
      $$InvestmentPlatformAllocationsTableUpdateCompanionBuilder,
      (
        InvestmentPlatformAllocation,
        $$InvestmentPlatformAllocationsTableReferences,
      ),
      InvestmentPlatformAllocation,
      PrefetchHooks Function({bool revisionId})
    >;
typedef $$ChecklistItemsTableCreateCompanionBuilder =
    ChecklistItemsCompanion Function({
      Value<int> id,
      required int revisionId,
      required int urutan,
      required String kode,
      Value<int?> nominal,
      Value<String?> detail,
      required bool selesai,
      required DateTime diperbaruiPada,
    });
typedef $$ChecklistItemsTableUpdateCompanionBuilder =
    ChecklistItemsCompanion Function({
      Value<int> id,
      Value<int> revisionId,
      Value<int> urutan,
      Value<String> kode,
      Value<int?> nominal,
      Value<String?> detail,
      Value<bool> selesai,
      Value<DateTime> diperbaruiPada,
    });

final class $$ChecklistItemsTableReferences
    extends BaseReferences<_$AppDatabase, $ChecklistItemsTable, ChecklistItem> {
  $$ChecklistItemsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $MonthlyAllocationRevisionsTable _revisionIdTable(_$AppDatabase db) =>
      db.monthlyAllocationRevisions.createAlias(
        'checklist_items__revision_id__monthly_allocation_revisions__id',
      );

  $$MonthlyAllocationRevisionsTableProcessedTableManager get revisionId {
    final $_column = $_itemColumn<int>('revision_id')!;

    final manager = $$MonthlyAllocationRevisionsTableTableManager(
      $_db,
      $_db.monthlyAllocationRevisions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_revisionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ChecklistItemsTableFilterComposer
    extends Composer<_$AppDatabase, $ChecklistItemsTable> {
  $$ChecklistItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get urutan => $composableBuilder(
    column: $table.urutan,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kode => $composableBuilder(
    column: $table.kode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get nominal => $composableBuilder(
    column: $table.nominal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get detail => $composableBuilder(
    column: $table.detail,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get selesai => $composableBuilder(
    column: $table.selesai,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get diperbaruiPada => $composableBuilder(
    column: $table.diperbaruiPada,
    builder: (column) => ColumnFilters(column),
  );

  $$MonthlyAllocationRevisionsTableFilterComposer get revisionId {
    final $$MonthlyAllocationRevisionsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.revisionId,
          referencedTable: $db.monthlyAllocationRevisions,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$MonthlyAllocationRevisionsTableFilterComposer(
                $db: $db,
                $table: $db.monthlyAllocationRevisions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$ChecklistItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $ChecklistItemsTable> {
  $$ChecklistItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get urutan => $composableBuilder(
    column: $table.urutan,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kode => $composableBuilder(
    column: $table.kode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get nominal => $composableBuilder(
    column: $table.nominal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get detail => $composableBuilder(
    column: $table.detail,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get selesai => $composableBuilder(
    column: $table.selesai,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get diperbaruiPada => $composableBuilder(
    column: $table.diperbaruiPada,
    builder: (column) => ColumnOrderings(column),
  );

  $$MonthlyAllocationRevisionsTableOrderingComposer get revisionId {
    final $$MonthlyAllocationRevisionsTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.revisionId,
          referencedTable: $db.monthlyAllocationRevisions,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$MonthlyAllocationRevisionsTableOrderingComposer(
                $db: $db,
                $table: $db.monthlyAllocationRevisions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$ChecklistItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChecklistItemsTable> {
  $$ChecklistItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get urutan =>
      $composableBuilder(column: $table.urutan, builder: (column) => column);

  GeneratedColumn<String> get kode =>
      $composableBuilder(column: $table.kode, builder: (column) => column);

  GeneratedColumn<int> get nominal =>
      $composableBuilder(column: $table.nominal, builder: (column) => column);

  GeneratedColumn<String> get detail =>
      $composableBuilder(column: $table.detail, builder: (column) => column);

  GeneratedColumn<bool> get selesai =>
      $composableBuilder(column: $table.selesai, builder: (column) => column);

  GeneratedColumn<DateTime> get diperbaruiPada => $composableBuilder(
    column: $table.diperbaruiPada,
    builder: (column) => column,
  );

  $$MonthlyAllocationRevisionsTableAnnotationComposer get revisionId {
    final $$MonthlyAllocationRevisionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.revisionId,
          referencedTable: $db.monthlyAllocationRevisions,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$MonthlyAllocationRevisionsTableAnnotationComposer(
                $db: $db,
                $table: $db.monthlyAllocationRevisions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$ChecklistItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ChecklistItemsTable,
          ChecklistItem,
          $$ChecklistItemsTableFilterComposer,
          $$ChecklistItemsTableOrderingComposer,
          $$ChecklistItemsTableAnnotationComposer,
          $$ChecklistItemsTableCreateCompanionBuilder,
          $$ChecklistItemsTableUpdateCompanionBuilder,
          (ChecklistItem, $$ChecklistItemsTableReferences),
          ChecklistItem,
          PrefetchHooks Function({bool revisionId})
        > {
  $$ChecklistItemsTableTableManager(
    _$AppDatabase db,
    $ChecklistItemsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChecklistItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChecklistItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChecklistItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> revisionId = const Value.absent(),
                Value<int> urutan = const Value.absent(),
                Value<String> kode = const Value.absent(),
                Value<int?> nominal = const Value.absent(),
                Value<String?> detail = const Value.absent(),
                Value<bool> selesai = const Value.absent(),
                Value<DateTime> diperbaruiPada = const Value.absent(),
              }) => ChecklistItemsCompanion(
                id: id,
                revisionId: revisionId,
                urutan: urutan,
                kode: kode,
                nominal: nominal,
                detail: detail,
                selesai: selesai,
                diperbaruiPada: diperbaruiPada,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int revisionId,
                required int urutan,
                required String kode,
                Value<int?> nominal = const Value.absent(),
                Value<String?> detail = const Value.absent(),
                required bool selesai,
                required DateTime diperbaruiPada,
              }) => ChecklistItemsCompanion.insert(
                id: id,
                revisionId: revisionId,
                urutan: urutan,
                kode: kode,
                nominal: nominal,
                detail: detail,
                selesai: selesai,
                diperbaruiPada: diperbaruiPada,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ChecklistItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({revisionId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (revisionId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.revisionId,
                                referencedTable: $$ChecklistItemsTableReferences
                                    ._revisionIdTable(db),
                                referencedColumn:
                                    $$ChecklistItemsTableReferences
                                        ._revisionIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ChecklistItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ChecklistItemsTable,
      ChecklistItem,
      $$ChecklistItemsTableFilterComposer,
      $$ChecklistItemsTableOrderingComposer,
      $$ChecklistItemsTableAnnotationComposer,
      $$ChecklistItemsTableCreateCompanionBuilder,
      $$ChecklistItemsTableUpdateCompanionBuilder,
      (ChecklistItem, $$ChecklistItemsTableReferences),
      ChecklistItem,
      PrefetchHooks Function({bool revisionId})
    >;
typedef $$RemindersTableCreateCompanionBuilder =
    RemindersCompanion Function({
      Value<int> id,
      required ReminderKind jenis,
      required String judul,
      required DateTime waktu,
      required bool berulangBulanan,
      required bool aktif,
    });
typedef $$RemindersTableUpdateCompanionBuilder =
    RemindersCompanion Function({
      Value<int> id,
      Value<ReminderKind> jenis,
      Value<String> judul,
      Value<DateTime> waktu,
      Value<bool> berulangBulanan,
      Value<bool> aktif,
    });

class $$RemindersTableFilterComposer
    extends Composer<_$AppDatabase, $RemindersTable> {
  $$RemindersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<ReminderKind, ReminderKind, String>
  get jenis => $composableBuilder(
    column: $table.jenis,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get judul => $composableBuilder(
    column: $table.judul,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get waktu => $composableBuilder(
    column: $table.waktu,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get berulangBulanan => $composableBuilder(
    column: $table.berulangBulanan,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get aktif => $composableBuilder(
    column: $table.aktif,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RemindersTableOrderingComposer
    extends Composer<_$AppDatabase, $RemindersTable> {
  $$RemindersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get jenis => $composableBuilder(
    column: $table.jenis,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get judul => $composableBuilder(
    column: $table.judul,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get waktu => $composableBuilder(
    column: $table.waktu,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get berulangBulanan => $composableBuilder(
    column: $table.berulangBulanan,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get aktif => $composableBuilder(
    column: $table.aktif,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RemindersTableAnnotationComposer
    extends Composer<_$AppDatabase, $RemindersTable> {
  $$RemindersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ReminderKind, String> get jenis =>
      $composableBuilder(column: $table.jenis, builder: (column) => column);

  GeneratedColumn<String> get judul =>
      $composableBuilder(column: $table.judul, builder: (column) => column);

  GeneratedColumn<DateTime> get waktu =>
      $composableBuilder(column: $table.waktu, builder: (column) => column);

  GeneratedColumn<bool> get berulangBulanan => $composableBuilder(
    column: $table.berulangBulanan,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get aktif =>
      $composableBuilder(column: $table.aktif, builder: (column) => column);
}

class $$RemindersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RemindersTable,
          Reminder,
          $$RemindersTableFilterComposer,
          $$RemindersTableOrderingComposer,
          $$RemindersTableAnnotationComposer,
          $$RemindersTableCreateCompanionBuilder,
          $$RemindersTableUpdateCompanionBuilder,
          (Reminder, BaseReferences<_$AppDatabase, $RemindersTable, Reminder>),
          Reminder,
          PrefetchHooks Function()
        > {
  $$RemindersTableTableManager(_$AppDatabase db, $RemindersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RemindersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RemindersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RemindersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<ReminderKind> jenis = const Value.absent(),
                Value<String> judul = const Value.absent(),
                Value<DateTime> waktu = const Value.absent(),
                Value<bool> berulangBulanan = const Value.absent(),
                Value<bool> aktif = const Value.absent(),
              }) => RemindersCompanion(
                id: id,
                jenis: jenis,
                judul: judul,
                waktu: waktu,
                berulangBulanan: berulangBulanan,
                aktif: aktif,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required ReminderKind jenis,
                required String judul,
                required DateTime waktu,
                required bool berulangBulanan,
                required bool aktif,
              }) => RemindersCompanion.insert(
                id: id,
                jenis: jenis,
                judul: judul,
                waktu: waktu,
                berulangBulanan: berulangBulanan,
                aktif: aktif,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RemindersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RemindersTable,
      Reminder,
      $$RemindersTableFilterComposer,
      $$RemindersTableOrderingComposer,
      $$RemindersTableAnnotationComposer,
      $$RemindersTableCreateCompanionBuilder,
      $$RemindersTableUpdateCompanionBuilder,
      (Reminder, BaseReferences<_$AppDatabase, $RemindersTable, Reminder>),
      Reminder,
      PrefetchHooks Function()
    >;
typedef $$AppSettingsTableCreateCompanionBuilder =
    AppSettingsCompanion Function({
      required String kunci,
      required String nilai,
      Value<int> rowid,
    });
typedef $$AppSettingsTableUpdateCompanionBuilder =
    AppSettingsCompanion Function({
      Value<String> kunci,
      Value<String> nilai,
      Value<int> rowid,
    });

class $$AppSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get kunci => $composableBuilder(
    column: $table.kunci,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nilai => $composableBuilder(
    column: $table.nilai,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get kunci => $composableBuilder(
    column: $table.kunci,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nilai => $composableBuilder(
    column: $table.nilai,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get kunci =>
      $composableBuilder(column: $table.kunci, builder: (column) => column);

  GeneratedColumn<String> get nilai =>
      $composableBuilder(column: $table.nilai, builder: (column) => column);
}

class $$AppSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppSettingsTable,
          AppSetting,
          $$AppSettingsTableFilterComposer,
          $$AppSettingsTableOrderingComposer,
          $$AppSettingsTableAnnotationComposer,
          $$AppSettingsTableCreateCompanionBuilder,
          $$AppSettingsTableUpdateCompanionBuilder,
          (
            AppSetting,
            BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>,
          ),
          AppSetting,
          PrefetchHooks Function()
        > {
  $$AppSettingsTableTableManager(_$AppDatabase db, $AppSettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> kunci = const Value.absent(),
                Value<String> nilai = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppSettingsCompanion(
                kunci: kunci,
                nilai: nilai,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String kunci,
                required String nilai,
                Value<int> rowid = const Value.absent(),
              }) => AppSettingsCompanion.insert(
                kunci: kunci,
                nilai: nilai,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppSettingsTable,
      AppSetting,
      $$AppSettingsTableFilterComposer,
      $$AppSettingsTableOrderingComposer,
      $$AppSettingsTableAnnotationComposer,
      $$AppSettingsTableCreateCompanionBuilder,
      $$AppSettingsTableUpdateCompanionBuilder,
      (
        AppSetting,
        BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>,
      ),
      AppSetting,
      PrefetchHooks Function()
    >;
typedef $$AiProviderConfigurationsTableCreateCompanionBuilder =
    AiProviderConfigurationsCompanion Function({
      Value<int> id,
      required String nama,
      required String baseUrl,
      Value<String> chatPath,
      Value<String> modelsPath,
      Value<int> timeoutDetik,
      Value<bool> streamingAktif,
      Value<String?> modelDefault,
      required AIDataScope izinData,
      Value<AllowedModelsMode> allowedMode,
      Value<String?> fallbackModel1,
      Value<String?> fallbackModel2,
      required DateTime dibuatPada,
    });
typedef $$AiProviderConfigurationsTableUpdateCompanionBuilder =
    AiProviderConfigurationsCompanion Function({
      Value<int> id,
      Value<String> nama,
      Value<String> baseUrl,
      Value<String> chatPath,
      Value<String> modelsPath,
      Value<int> timeoutDetik,
      Value<bool> streamingAktif,
      Value<String?> modelDefault,
      Value<AIDataScope> izinData,
      Value<AllowedModelsMode> allowedMode,
      Value<String?> fallbackModel1,
      Value<String?> fallbackModel2,
      Value<DateTime> dibuatPada,
    });

final class $$AiProviderConfigurationsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $AiProviderConfigurationsTable,
          AiProviderConfiguration
        > {
  $$AiProviderConfigurationsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$AiModelsTable, List<AiModel>> _aiModelsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.aiModels,
    aliasName: 'ai_provider_configurations__id__ai_models__provider_id',
  );

  $$AiModelsTableProcessedTableManager get aiModelsRefs {
    final manager = $$AiModelsTableTableManager(
      $_db,
      $_db.aiModels,
    ).filter((f) => f.providerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_aiModelsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ModelListCachesTable, List<ModelListCache>>
  _modelListCachesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.modelListCaches,
    aliasName: 'ai_provider_configurations__id__model_list_caches__provider_id',
  );

  $$ModelListCachesTableProcessedTableManager get modelListCachesRefs {
    final manager = $$ModelListCachesTableTableManager(
      $_db,
      $_db.modelListCaches,
    ).filter((f) => f.providerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _modelListCachesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ChatConversationsTable, List<ChatConversation>>
  _chatConversationsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.chatConversations,
        aliasName:
            'ai_provider_configurations__id__chat_conversations__provider_id',
      );

  $$ChatConversationsTableProcessedTableManager get chatConversationsRefs {
    final manager = $$ChatConversationsTableTableManager(
      $_db,
      $_db.chatConversations,
    ).filter((f) => f.providerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _chatConversationsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$AiProviderConfigurationsTableFilterComposer
    extends Composer<_$AppDatabase, $AiProviderConfigurationsTable> {
  $$AiProviderConfigurationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nama => $composableBuilder(
    column: $table.nama,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get baseUrl => $composableBuilder(
    column: $table.baseUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get chatPath => $composableBuilder(
    column: $table.chatPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get modelsPath => $composableBuilder(
    column: $table.modelsPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get timeoutDetik => $composableBuilder(
    column: $table.timeoutDetik,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get streamingAktif => $composableBuilder(
    column: $table.streamingAktif,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get modelDefault => $composableBuilder(
    column: $table.modelDefault,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<AIDataScope, AIDataScope, String>
  get izinData => $composableBuilder(
    column: $table.izinData,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<AllowedModelsMode, AllowedModelsMode, String>
  get allowedMode => $composableBuilder(
    column: $table.allowedMode,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get fallbackModel1 => $composableBuilder(
    column: $table.fallbackModel1,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fallbackModel2 => $composableBuilder(
    column: $table.fallbackModel2,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dibuatPada => $composableBuilder(
    column: $table.dibuatPada,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> aiModelsRefs(
    Expression<bool> Function($$AiModelsTableFilterComposer f) f,
  ) {
    final $$AiModelsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.aiModels,
      getReferencedColumn: (t) => t.providerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AiModelsTableFilterComposer(
            $db: $db,
            $table: $db.aiModels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> modelListCachesRefs(
    Expression<bool> Function($$ModelListCachesTableFilterComposer f) f,
  ) {
    final $$ModelListCachesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.modelListCaches,
      getReferencedColumn: (t) => t.providerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ModelListCachesTableFilterComposer(
            $db: $db,
            $table: $db.modelListCaches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> chatConversationsRefs(
    Expression<bool> Function($$ChatConversationsTableFilterComposer f) f,
  ) {
    final $$ChatConversationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.chatConversations,
      getReferencedColumn: (t) => t.providerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChatConversationsTableFilterComposer(
            $db: $db,
            $table: $db.chatConversations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AiProviderConfigurationsTableOrderingComposer
    extends Composer<_$AppDatabase, $AiProviderConfigurationsTable> {
  $$AiProviderConfigurationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nama => $composableBuilder(
    column: $table.nama,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get baseUrl => $composableBuilder(
    column: $table.baseUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get chatPath => $composableBuilder(
    column: $table.chatPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get modelsPath => $composableBuilder(
    column: $table.modelsPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get timeoutDetik => $composableBuilder(
    column: $table.timeoutDetik,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get streamingAktif => $composableBuilder(
    column: $table.streamingAktif,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get modelDefault => $composableBuilder(
    column: $table.modelDefault,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get izinData => $composableBuilder(
    column: $table.izinData,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get allowedMode => $composableBuilder(
    column: $table.allowedMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fallbackModel1 => $composableBuilder(
    column: $table.fallbackModel1,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fallbackModel2 => $composableBuilder(
    column: $table.fallbackModel2,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dibuatPada => $composableBuilder(
    column: $table.dibuatPada,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AiProviderConfigurationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AiProviderConfigurationsTable> {
  $$AiProviderConfigurationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nama =>
      $composableBuilder(column: $table.nama, builder: (column) => column);

  GeneratedColumn<String> get baseUrl =>
      $composableBuilder(column: $table.baseUrl, builder: (column) => column);

  GeneratedColumn<String> get chatPath =>
      $composableBuilder(column: $table.chatPath, builder: (column) => column);

  GeneratedColumn<String> get modelsPath => $composableBuilder(
    column: $table.modelsPath,
    builder: (column) => column,
  );

  GeneratedColumn<int> get timeoutDetik => $composableBuilder(
    column: $table.timeoutDetik,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get streamingAktif => $composableBuilder(
    column: $table.streamingAktif,
    builder: (column) => column,
  );

  GeneratedColumn<String> get modelDefault => $composableBuilder(
    column: $table.modelDefault,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<AIDataScope, String> get izinData =>
      $composableBuilder(column: $table.izinData, builder: (column) => column);

  GeneratedColumnWithTypeConverter<AllowedModelsMode, String> get allowedMode =>
      $composableBuilder(
        column: $table.allowedMode,
        builder: (column) => column,
      );

  GeneratedColumn<String> get fallbackModel1 => $composableBuilder(
    column: $table.fallbackModel1,
    builder: (column) => column,
  );

  GeneratedColumn<String> get fallbackModel2 => $composableBuilder(
    column: $table.fallbackModel2,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get dibuatPada => $composableBuilder(
    column: $table.dibuatPada,
    builder: (column) => column,
  );

  Expression<T> aiModelsRefs<T extends Object>(
    Expression<T> Function($$AiModelsTableAnnotationComposer a) f,
  ) {
    final $$AiModelsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.aiModels,
      getReferencedColumn: (t) => t.providerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AiModelsTableAnnotationComposer(
            $db: $db,
            $table: $db.aiModels,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> modelListCachesRefs<T extends Object>(
    Expression<T> Function($$ModelListCachesTableAnnotationComposer a) f,
  ) {
    final $$ModelListCachesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.modelListCaches,
      getReferencedColumn: (t) => t.providerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ModelListCachesTableAnnotationComposer(
            $db: $db,
            $table: $db.modelListCaches,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> chatConversationsRefs<T extends Object>(
    Expression<T> Function($$ChatConversationsTableAnnotationComposer a) f,
  ) {
    final $$ChatConversationsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.chatConversations,
          getReferencedColumn: (t) => t.providerId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ChatConversationsTableAnnotationComposer(
                $db: $db,
                $table: $db.chatConversations,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$AiProviderConfigurationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AiProviderConfigurationsTable,
          AiProviderConfiguration,
          $$AiProviderConfigurationsTableFilterComposer,
          $$AiProviderConfigurationsTableOrderingComposer,
          $$AiProviderConfigurationsTableAnnotationComposer,
          $$AiProviderConfigurationsTableCreateCompanionBuilder,
          $$AiProviderConfigurationsTableUpdateCompanionBuilder,
          (AiProviderConfiguration, $$AiProviderConfigurationsTableReferences),
          AiProviderConfiguration,
          PrefetchHooks Function({
            bool aiModelsRefs,
            bool modelListCachesRefs,
            bool chatConversationsRefs,
          })
        > {
  $$AiProviderConfigurationsTableTableManager(
    _$AppDatabase db,
    $AiProviderConfigurationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AiProviderConfigurationsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$AiProviderConfigurationsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$AiProviderConfigurationsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nama = const Value.absent(),
                Value<String> baseUrl = const Value.absent(),
                Value<String> chatPath = const Value.absent(),
                Value<String> modelsPath = const Value.absent(),
                Value<int> timeoutDetik = const Value.absent(),
                Value<bool> streamingAktif = const Value.absent(),
                Value<String?> modelDefault = const Value.absent(),
                Value<AIDataScope> izinData = const Value.absent(),
                Value<AllowedModelsMode> allowedMode = const Value.absent(),
                Value<String?> fallbackModel1 = const Value.absent(),
                Value<String?> fallbackModel2 = const Value.absent(),
                Value<DateTime> dibuatPada = const Value.absent(),
              }) => AiProviderConfigurationsCompanion(
                id: id,
                nama: nama,
                baseUrl: baseUrl,
                chatPath: chatPath,
                modelsPath: modelsPath,
                timeoutDetik: timeoutDetik,
                streamingAktif: streamingAktif,
                modelDefault: modelDefault,
                izinData: izinData,
                allowedMode: allowedMode,
                fallbackModel1: fallbackModel1,
                fallbackModel2: fallbackModel2,
                dibuatPada: dibuatPada,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nama,
                required String baseUrl,
                Value<String> chatPath = const Value.absent(),
                Value<String> modelsPath = const Value.absent(),
                Value<int> timeoutDetik = const Value.absent(),
                Value<bool> streamingAktif = const Value.absent(),
                Value<String?> modelDefault = const Value.absent(),
                required AIDataScope izinData,
                Value<AllowedModelsMode> allowedMode = const Value.absent(),
                Value<String?> fallbackModel1 = const Value.absent(),
                Value<String?> fallbackModel2 = const Value.absent(),
                required DateTime dibuatPada,
              }) => AiProviderConfigurationsCompanion.insert(
                id: id,
                nama: nama,
                baseUrl: baseUrl,
                chatPath: chatPath,
                modelsPath: modelsPath,
                timeoutDetik: timeoutDetik,
                streamingAktif: streamingAktif,
                modelDefault: modelDefault,
                izinData: izinData,
                allowedMode: allowedMode,
                fallbackModel1: fallbackModel1,
                fallbackModel2: fallbackModel2,
                dibuatPada: dibuatPada,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$AiProviderConfigurationsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                aiModelsRefs = false,
                modelListCachesRefs = false,
                chatConversationsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (aiModelsRefs) db.aiModels,
                    if (modelListCachesRefs) db.modelListCaches,
                    if (chatConversationsRefs) db.chatConversations,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (aiModelsRefs)
                        await $_getPrefetchedData<
                          AiProviderConfiguration,
                          $AiProviderConfigurationsTable,
                          AiModel
                        >(
                          currentTable: table,
                          referencedTable:
                              $$AiProviderConfigurationsTableReferences
                                  ._aiModelsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AiProviderConfigurationsTableReferences(
                                db,
                                table,
                                p0,
                              ).aiModelsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.providerId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (modelListCachesRefs)
                        await $_getPrefetchedData<
                          AiProviderConfiguration,
                          $AiProviderConfigurationsTable,
                          ModelListCache
                        >(
                          currentTable: table,
                          referencedTable:
                              $$AiProviderConfigurationsTableReferences
                                  ._modelListCachesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AiProviderConfigurationsTableReferences(
                                db,
                                table,
                                p0,
                              ).modelListCachesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.providerId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (chatConversationsRefs)
                        await $_getPrefetchedData<
                          AiProviderConfiguration,
                          $AiProviderConfigurationsTable,
                          ChatConversation
                        >(
                          currentTable: table,
                          referencedTable:
                              $$AiProviderConfigurationsTableReferences
                                  ._chatConversationsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$AiProviderConfigurationsTableReferences(
                                db,
                                table,
                                p0,
                              ).chatConversationsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.providerId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$AiProviderConfigurationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AiProviderConfigurationsTable,
      AiProviderConfiguration,
      $$AiProviderConfigurationsTableFilterComposer,
      $$AiProviderConfigurationsTableOrderingComposer,
      $$AiProviderConfigurationsTableAnnotationComposer,
      $$AiProviderConfigurationsTableCreateCompanionBuilder,
      $$AiProviderConfigurationsTableUpdateCompanionBuilder,
      (AiProviderConfiguration, $$AiProviderConfigurationsTableReferences),
      AiProviderConfiguration,
      PrefetchHooks Function({
        bool aiModelsRefs,
        bool modelListCachesRefs,
        bool chatConversationsRefs,
      })
    >;
typedef $$AiModelsTableCreateCompanionBuilder =
    AiModelsCompanion Function({
      Value<int> id,
      required int providerId,
      required String modelId,
      Value<String?> displayName,
      Value<bool> favorit,
      Value<bool> manual,
      Value<bool> diblokir,
      Value<bool> diizinkan,
      Value<CapabilityStatus> statusChat,
      Value<CapabilityStatus> statusStreaming,
      Value<int?> hargaInputPerJuta,
      Value<int?> hargaOutputPerJuta,
      Value<DateTime?> terakhirDipakai,
    });
typedef $$AiModelsTableUpdateCompanionBuilder =
    AiModelsCompanion Function({
      Value<int> id,
      Value<int> providerId,
      Value<String> modelId,
      Value<String?> displayName,
      Value<bool> favorit,
      Value<bool> manual,
      Value<bool> diblokir,
      Value<bool> diizinkan,
      Value<CapabilityStatus> statusChat,
      Value<CapabilityStatus> statusStreaming,
      Value<int?> hargaInputPerJuta,
      Value<int?> hargaOutputPerJuta,
      Value<DateTime?> terakhirDipakai,
    });

final class $$AiModelsTableReferences
    extends BaseReferences<_$AppDatabase, $AiModelsTable, AiModel> {
  $$AiModelsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $AiProviderConfigurationsTable _providerIdTable(_$AppDatabase db) => db
      .aiProviderConfigurations
      .createAlias('ai_models__provider_id__ai_provider_configurations__id');

  $$AiProviderConfigurationsTableProcessedTableManager get providerId {
    final $_column = $_itemColumn<int>('provider_id')!;

    final manager = $$AiProviderConfigurationsTableTableManager(
      $_db,
      $_db.aiProviderConfigurations,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_providerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$AiModelsTableFilterComposer
    extends Composer<_$AppDatabase, $AiModelsTable> {
  $$AiModelsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get modelId => $composableBuilder(
    column: $table.modelId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get favorit => $composableBuilder(
    column: $table.favorit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get manual => $composableBuilder(
    column: $table.manual,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get diblokir => $composableBuilder(
    column: $table.diblokir,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get diizinkan => $composableBuilder(
    column: $table.diizinkan,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<CapabilityStatus, CapabilityStatus, String>
  get statusChat => $composableBuilder(
    column: $table.statusChat,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<CapabilityStatus, CapabilityStatus, String>
  get statusStreaming => $composableBuilder(
    column: $table.statusStreaming,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get hargaInputPerJuta => $composableBuilder(
    column: $table.hargaInputPerJuta,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get hargaOutputPerJuta => $composableBuilder(
    column: $table.hargaOutputPerJuta,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get terakhirDipakai => $composableBuilder(
    column: $table.terakhirDipakai,
    builder: (column) => ColumnFilters(column),
  );

  $$AiProviderConfigurationsTableFilterComposer get providerId {
    final $$AiProviderConfigurationsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.providerId,
          referencedTable: $db.aiProviderConfigurations,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$AiProviderConfigurationsTableFilterComposer(
                $db: $db,
                $table: $db.aiProviderConfigurations,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$AiModelsTableOrderingComposer
    extends Composer<_$AppDatabase, $AiModelsTable> {
  $$AiModelsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get modelId => $composableBuilder(
    column: $table.modelId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get favorit => $composableBuilder(
    column: $table.favorit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get manual => $composableBuilder(
    column: $table.manual,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get diblokir => $composableBuilder(
    column: $table.diblokir,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get diizinkan => $composableBuilder(
    column: $table.diizinkan,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get statusChat => $composableBuilder(
    column: $table.statusChat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get statusStreaming => $composableBuilder(
    column: $table.statusStreaming,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get hargaInputPerJuta => $composableBuilder(
    column: $table.hargaInputPerJuta,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get hargaOutputPerJuta => $composableBuilder(
    column: $table.hargaOutputPerJuta,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get terakhirDipakai => $composableBuilder(
    column: $table.terakhirDipakai,
    builder: (column) => ColumnOrderings(column),
  );

  $$AiProviderConfigurationsTableOrderingComposer get providerId {
    final $$AiProviderConfigurationsTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.providerId,
          referencedTable: $db.aiProviderConfigurations,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$AiProviderConfigurationsTableOrderingComposer(
                $db: $db,
                $table: $db.aiProviderConfigurations,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$AiModelsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AiModelsTable> {
  $$AiModelsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get modelId =>
      $composableBuilder(column: $table.modelId, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get favorit =>
      $composableBuilder(column: $table.favorit, builder: (column) => column);

  GeneratedColumn<bool> get manual =>
      $composableBuilder(column: $table.manual, builder: (column) => column);

  GeneratedColumn<bool> get diblokir =>
      $composableBuilder(column: $table.diblokir, builder: (column) => column);

  GeneratedColumn<bool> get diizinkan =>
      $composableBuilder(column: $table.diizinkan, builder: (column) => column);

  GeneratedColumnWithTypeConverter<CapabilityStatus, String> get statusChat =>
      $composableBuilder(
        column: $table.statusChat,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<CapabilityStatus, String>
  get statusStreaming => $composableBuilder(
    column: $table.statusStreaming,
    builder: (column) => column,
  );

  GeneratedColumn<int> get hargaInputPerJuta => $composableBuilder(
    column: $table.hargaInputPerJuta,
    builder: (column) => column,
  );

  GeneratedColumn<int> get hargaOutputPerJuta => $composableBuilder(
    column: $table.hargaOutputPerJuta,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get terakhirDipakai => $composableBuilder(
    column: $table.terakhirDipakai,
    builder: (column) => column,
  );

  $$AiProviderConfigurationsTableAnnotationComposer get providerId {
    final $$AiProviderConfigurationsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.providerId,
          referencedTable: $db.aiProviderConfigurations,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$AiProviderConfigurationsTableAnnotationComposer(
                $db: $db,
                $table: $db.aiProviderConfigurations,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$AiModelsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AiModelsTable,
          AiModel,
          $$AiModelsTableFilterComposer,
          $$AiModelsTableOrderingComposer,
          $$AiModelsTableAnnotationComposer,
          $$AiModelsTableCreateCompanionBuilder,
          $$AiModelsTableUpdateCompanionBuilder,
          (AiModel, $$AiModelsTableReferences),
          AiModel,
          PrefetchHooks Function({bool providerId})
        > {
  $$AiModelsTableTableManager(_$AppDatabase db, $AiModelsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AiModelsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AiModelsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AiModelsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> providerId = const Value.absent(),
                Value<String> modelId = const Value.absent(),
                Value<String?> displayName = const Value.absent(),
                Value<bool> favorit = const Value.absent(),
                Value<bool> manual = const Value.absent(),
                Value<bool> diblokir = const Value.absent(),
                Value<bool> diizinkan = const Value.absent(),
                Value<CapabilityStatus> statusChat = const Value.absent(),
                Value<CapabilityStatus> statusStreaming = const Value.absent(),
                Value<int?> hargaInputPerJuta = const Value.absent(),
                Value<int?> hargaOutputPerJuta = const Value.absent(),
                Value<DateTime?> terakhirDipakai = const Value.absent(),
              }) => AiModelsCompanion(
                id: id,
                providerId: providerId,
                modelId: modelId,
                displayName: displayName,
                favorit: favorit,
                manual: manual,
                diblokir: diblokir,
                diizinkan: diizinkan,
                statusChat: statusChat,
                statusStreaming: statusStreaming,
                hargaInputPerJuta: hargaInputPerJuta,
                hargaOutputPerJuta: hargaOutputPerJuta,
                terakhirDipakai: terakhirDipakai,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int providerId,
                required String modelId,
                Value<String?> displayName = const Value.absent(),
                Value<bool> favorit = const Value.absent(),
                Value<bool> manual = const Value.absent(),
                Value<bool> diblokir = const Value.absent(),
                Value<bool> diizinkan = const Value.absent(),
                Value<CapabilityStatus> statusChat = const Value.absent(),
                Value<CapabilityStatus> statusStreaming = const Value.absent(),
                Value<int?> hargaInputPerJuta = const Value.absent(),
                Value<int?> hargaOutputPerJuta = const Value.absent(),
                Value<DateTime?> terakhirDipakai = const Value.absent(),
              }) => AiModelsCompanion.insert(
                id: id,
                providerId: providerId,
                modelId: modelId,
                displayName: displayName,
                favorit: favorit,
                manual: manual,
                diblokir: diblokir,
                diizinkan: diizinkan,
                statusChat: statusChat,
                statusStreaming: statusStreaming,
                hargaInputPerJuta: hargaInputPerJuta,
                hargaOutputPerJuta: hargaOutputPerJuta,
                terakhirDipakai: terakhirDipakai,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$AiModelsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({providerId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (providerId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.providerId,
                                referencedTable: $$AiModelsTableReferences
                                    ._providerIdTable(db),
                                referencedColumn: $$AiModelsTableReferences
                                    ._providerIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$AiModelsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AiModelsTable,
      AiModel,
      $$AiModelsTableFilterComposer,
      $$AiModelsTableOrderingComposer,
      $$AiModelsTableAnnotationComposer,
      $$AiModelsTableCreateCompanionBuilder,
      $$AiModelsTableUpdateCompanionBuilder,
      (AiModel, $$AiModelsTableReferences),
      AiModel,
      PrefetchHooks Function({bool providerId})
    >;
typedef $$ModelListCachesTableCreateCompanionBuilder =
    ModelListCachesCompanion Function({
      Value<int> providerId,
      required String jsonModel,
      required DateTime diambilPada,
    });
typedef $$ModelListCachesTableUpdateCompanionBuilder =
    ModelListCachesCompanion Function({
      Value<int> providerId,
      Value<String> jsonModel,
      Value<DateTime> diambilPada,
    });

final class $$ModelListCachesTableReferences
    extends
        BaseReferences<_$AppDatabase, $ModelListCachesTable, ModelListCache> {
  $$ModelListCachesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $AiProviderConfigurationsTable _providerIdTable(_$AppDatabase db) =>
      db.aiProviderConfigurations.createAlias(
        'model_list_caches__provider_id__ai_provider_configurations__id',
      );

  $$AiProviderConfigurationsTableProcessedTableManager get providerId {
    final $_column = $_itemColumn<int>('provider_id')!;

    final manager = $$AiProviderConfigurationsTableTableManager(
      $_db,
      $_db.aiProviderConfigurations,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_providerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ModelListCachesTableFilterComposer
    extends Composer<_$AppDatabase, $ModelListCachesTable> {
  $$ModelListCachesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get jsonModel => $composableBuilder(
    column: $table.jsonModel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get diambilPada => $composableBuilder(
    column: $table.diambilPada,
    builder: (column) => ColumnFilters(column),
  );

  $$AiProviderConfigurationsTableFilterComposer get providerId {
    final $$AiProviderConfigurationsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.providerId,
          referencedTable: $db.aiProviderConfigurations,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$AiProviderConfigurationsTableFilterComposer(
                $db: $db,
                $table: $db.aiProviderConfigurations,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$ModelListCachesTableOrderingComposer
    extends Composer<_$AppDatabase, $ModelListCachesTable> {
  $$ModelListCachesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get jsonModel => $composableBuilder(
    column: $table.jsonModel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get diambilPada => $composableBuilder(
    column: $table.diambilPada,
    builder: (column) => ColumnOrderings(column),
  );

  $$AiProviderConfigurationsTableOrderingComposer get providerId {
    final $$AiProviderConfigurationsTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.providerId,
          referencedTable: $db.aiProviderConfigurations,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$AiProviderConfigurationsTableOrderingComposer(
                $db: $db,
                $table: $db.aiProviderConfigurations,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$ModelListCachesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ModelListCachesTable> {
  $$ModelListCachesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get jsonModel =>
      $composableBuilder(column: $table.jsonModel, builder: (column) => column);

  GeneratedColumn<DateTime> get diambilPada => $composableBuilder(
    column: $table.diambilPada,
    builder: (column) => column,
  );

  $$AiProviderConfigurationsTableAnnotationComposer get providerId {
    final $$AiProviderConfigurationsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.providerId,
          referencedTable: $db.aiProviderConfigurations,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$AiProviderConfigurationsTableAnnotationComposer(
                $db: $db,
                $table: $db.aiProviderConfigurations,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$ModelListCachesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ModelListCachesTable,
          ModelListCache,
          $$ModelListCachesTableFilterComposer,
          $$ModelListCachesTableOrderingComposer,
          $$ModelListCachesTableAnnotationComposer,
          $$ModelListCachesTableCreateCompanionBuilder,
          $$ModelListCachesTableUpdateCompanionBuilder,
          (ModelListCache, $$ModelListCachesTableReferences),
          ModelListCache,
          PrefetchHooks Function({bool providerId})
        > {
  $$ModelListCachesTableTableManager(
    _$AppDatabase db,
    $ModelListCachesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ModelListCachesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ModelListCachesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ModelListCachesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> providerId = const Value.absent(),
                Value<String> jsonModel = const Value.absent(),
                Value<DateTime> diambilPada = const Value.absent(),
              }) => ModelListCachesCompanion(
                providerId: providerId,
                jsonModel: jsonModel,
                diambilPada: diambilPada,
              ),
          createCompanionCallback:
              ({
                Value<int> providerId = const Value.absent(),
                required String jsonModel,
                required DateTime diambilPada,
              }) => ModelListCachesCompanion.insert(
                providerId: providerId,
                jsonModel: jsonModel,
                diambilPada: diambilPada,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ModelListCachesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({providerId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (providerId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.providerId,
                                referencedTable:
                                    $$ModelListCachesTableReferences
                                        ._providerIdTable(db),
                                referencedColumn:
                                    $$ModelListCachesTableReferences
                                        ._providerIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ModelListCachesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ModelListCachesTable,
      ModelListCache,
      $$ModelListCachesTableFilterComposer,
      $$ModelListCachesTableOrderingComposer,
      $$ModelListCachesTableAnnotationComposer,
      $$ModelListCachesTableCreateCompanionBuilder,
      $$ModelListCachesTableUpdateCompanionBuilder,
      (ModelListCache, $$ModelListCachesTableReferences),
      ModelListCache,
      PrefetchHooks Function({bool providerId})
    >;
typedef $$ChatConversationsTableCreateCompanionBuilder =
    ChatConversationsCompanion Function({
      Value<int> id,
      required String judul,
      required int providerId,
      required String modelId,
      required DateTime dibuatPada,
      required DateTime diperbaruiPada,
    });
typedef $$ChatConversationsTableUpdateCompanionBuilder =
    ChatConversationsCompanion Function({
      Value<int> id,
      Value<String> judul,
      Value<int> providerId,
      Value<String> modelId,
      Value<DateTime> dibuatPada,
      Value<DateTime> diperbaruiPada,
    });

final class $$ChatConversationsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ChatConversationsTable,
          ChatConversation
        > {
  $$ChatConversationsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $AiProviderConfigurationsTable _providerIdTable(_$AppDatabase db) =>
      db.aiProviderConfigurations.createAlias(
        'chat_conversations__provider_id__ai_provider_configurations__id',
      );

  $$AiProviderConfigurationsTableProcessedTableManager get providerId {
    final $_column = $_itemColumn<int>('provider_id')!;

    final manager = $$AiProviderConfigurationsTableTableManager(
      $_db,
      $_db.aiProviderConfigurations,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_providerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$ChatMessagesTable, List<ChatMessage>>
  _chatMessagesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.chatMessages,
    aliasName: 'chat_conversations__id__chat_messages__conversation_id',
  );

  $$ChatMessagesTableProcessedTableManager get chatMessagesRefs {
    final manager = $$ChatMessagesTableTableManager(
      $_db,
      $_db.chatMessages,
    ).filter((f) => f.conversationId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_chatMessagesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ChatConversationsTableFilterComposer
    extends Composer<_$AppDatabase, $ChatConversationsTable> {
  $$ChatConversationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get judul => $composableBuilder(
    column: $table.judul,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get modelId => $composableBuilder(
    column: $table.modelId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dibuatPada => $composableBuilder(
    column: $table.dibuatPada,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get diperbaruiPada => $composableBuilder(
    column: $table.diperbaruiPada,
    builder: (column) => ColumnFilters(column),
  );

  $$AiProviderConfigurationsTableFilterComposer get providerId {
    final $$AiProviderConfigurationsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.providerId,
          referencedTable: $db.aiProviderConfigurations,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$AiProviderConfigurationsTableFilterComposer(
                $db: $db,
                $table: $db.aiProviderConfigurations,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  Expression<bool> chatMessagesRefs(
    Expression<bool> Function($$ChatMessagesTableFilterComposer f) f,
  ) {
    final $$ChatMessagesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.chatMessages,
      getReferencedColumn: (t) => t.conversationId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChatMessagesTableFilterComposer(
            $db: $db,
            $table: $db.chatMessages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ChatConversationsTableOrderingComposer
    extends Composer<_$AppDatabase, $ChatConversationsTable> {
  $$ChatConversationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get judul => $composableBuilder(
    column: $table.judul,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get modelId => $composableBuilder(
    column: $table.modelId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dibuatPada => $composableBuilder(
    column: $table.dibuatPada,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get diperbaruiPada => $composableBuilder(
    column: $table.diperbaruiPada,
    builder: (column) => ColumnOrderings(column),
  );

  $$AiProviderConfigurationsTableOrderingComposer get providerId {
    final $$AiProviderConfigurationsTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.providerId,
          referencedTable: $db.aiProviderConfigurations,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$AiProviderConfigurationsTableOrderingComposer(
                $db: $db,
                $table: $db.aiProviderConfigurations,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$ChatConversationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChatConversationsTable> {
  $$ChatConversationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get judul =>
      $composableBuilder(column: $table.judul, builder: (column) => column);

  GeneratedColumn<String> get modelId =>
      $composableBuilder(column: $table.modelId, builder: (column) => column);

  GeneratedColumn<DateTime> get dibuatPada => $composableBuilder(
    column: $table.dibuatPada,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get diperbaruiPada => $composableBuilder(
    column: $table.diperbaruiPada,
    builder: (column) => column,
  );

  $$AiProviderConfigurationsTableAnnotationComposer get providerId {
    final $$AiProviderConfigurationsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.providerId,
          referencedTable: $db.aiProviderConfigurations,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$AiProviderConfigurationsTableAnnotationComposer(
                $db: $db,
                $table: $db.aiProviderConfigurations,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  Expression<T> chatMessagesRefs<T extends Object>(
    Expression<T> Function($$ChatMessagesTableAnnotationComposer a) f,
  ) {
    final $$ChatMessagesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.chatMessages,
      getReferencedColumn: (t) => t.conversationId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChatMessagesTableAnnotationComposer(
            $db: $db,
            $table: $db.chatMessages,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ChatConversationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ChatConversationsTable,
          ChatConversation,
          $$ChatConversationsTableFilterComposer,
          $$ChatConversationsTableOrderingComposer,
          $$ChatConversationsTableAnnotationComposer,
          $$ChatConversationsTableCreateCompanionBuilder,
          $$ChatConversationsTableUpdateCompanionBuilder,
          (ChatConversation, $$ChatConversationsTableReferences),
          ChatConversation,
          PrefetchHooks Function({bool providerId, bool chatMessagesRefs})
        > {
  $$ChatConversationsTableTableManager(
    _$AppDatabase db,
    $ChatConversationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChatConversationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChatConversationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChatConversationsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> judul = const Value.absent(),
                Value<int> providerId = const Value.absent(),
                Value<String> modelId = const Value.absent(),
                Value<DateTime> dibuatPada = const Value.absent(),
                Value<DateTime> diperbaruiPada = const Value.absent(),
              }) => ChatConversationsCompanion(
                id: id,
                judul: judul,
                providerId: providerId,
                modelId: modelId,
                dibuatPada: dibuatPada,
                diperbaruiPada: diperbaruiPada,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String judul,
                required int providerId,
                required String modelId,
                required DateTime dibuatPada,
                required DateTime diperbaruiPada,
              }) => ChatConversationsCompanion.insert(
                id: id,
                judul: judul,
                providerId: providerId,
                modelId: modelId,
                dibuatPada: dibuatPada,
                diperbaruiPada: diperbaruiPada,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ChatConversationsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({providerId = false, chatMessagesRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (chatMessagesRefs) db.chatMessages,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (providerId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.providerId,
                                    referencedTable:
                                        $$ChatConversationsTableReferences
                                            ._providerIdTable(db),
                                    referencedColumn:
                                        $$ChatConversationsTableReferences
                                            ._providerIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (chatMessagesRefs)
                        await $_getPrefetchedData<
                          ChatConversation,
                          $ChatConversationsTable,
                          ChatMessage
                        >(
                          currentTable: table,
                          referencedTable: $$ChatConversationsTableReferences
                              ._chatMessagesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ChatConversationsTableReferences(
                                db,
                                table,
                                p0,
                              ).chatMessagesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.conversationId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ChatConversationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ChatConversationsTable,
      ChatConversation,
      $$ChatConversationsTableFilterComposer,
      $$ChatConversationsTableOrderingComposer,
      $$ChatConversationsTableAnnotationComposer,
      $$ChatConversationsTableCreateCompanionBuilder,
      $$ChatConversationsTableUpdateCompanionBuilder,
      (ChatConversation, $$ChatConversationsTableReferences),
      ChatConversation,
      PrefetchHooks Function({bool providerId, bool chatMessagesRefs})
    >;
typedef $$ChatMessagesTableCreateCompanionBuilder =
    ChatMessagesCompanion Function({
      Value<int> id,
      required int conversationId,
      required String role,
      required String content,
      required DateTime dibuatPada,
    });
typedef $$ChatMessagesTableUpdateCompanionBuilder =
    ChatMessagesCompanion Function({
      Value<int> id,
      Value<int> conversationId,
      Value<String> role,
      Value<String> content,
      Value<DateTime> dibuatPada,
    });

final class $$ChatMessagesTableReferences
    extends BaseReferences<_$AppDatabase, $ChatMessagesTable, ChatMessage> {
  $$ChatMessagesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ChatConversationsTable _conversationIdTable(_$AppDatabase db) => db
      .chatConversations
      .createAlias('chat_messages__conversation_id__chat_conversations__id');

  $$ChatConversationsTableProcessedTableManager get conversationId {
    final $_column = $_itemColumn<int>('conversation_id')!;

    final manager = $$ChatConversationsTableTableManager(
      $_db,
      $_db.chatConversations,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_conversationIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ChatMessagesTableFilterComposer
    extends Composer<_$AppDatabase, $ChatMessagesTable> {
  $$ChatMessagesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dibuatPada => $composableBuilder(
    column: $table.dibuatPada,
    builder: (column) => ColumnFilters(column),
  );

  $$ChatConversationsTableFilterComposer get conversationId {
    final $$ChatConversationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.conversationId,
      referencedTable: $db.chatConversations,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChatConversationsTableFilterComposer(
            $db: $db,
            $table: $db.chatConversations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ChatMessagesTableOrderingComposer
    extends Composer<_$AppDatabase, $ChatMessagesTable> {
  $$ChatMessagesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dibuatPada => $composableBuilder(
    column: $table.dibuatPada,
    builder: (column) => ColumnOrderings(column),
  );

  $$ChatConversationsTableOrderingComposer get conversationId {
    final $$ChatConversationsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.conversationId,
      referencedTable: $db.chatConversations,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ChatConversationsTableOrderingComposer(
            $db: $db,
            $table: $db.chatConversations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ChatMessagesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ChatMessagesTable> {
  $$ChatMessagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<DateTime> get dibuatPada => $composableBuilder(
    column: $table.dibuatPada,
    builder: (column) => column,
  );

  $$ChatConversationsTableAnnotationComposer get conversationId {
    final $$ChatConversationsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.conversationId,
          referencedTable: $db.chatConversations,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ChatConversationsTableAnnotationComposer(
                $db: $db,
                $table: $db.chatConversations,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$ChatMessagesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ChatMessagesTable,
          ChatMessage,
          $$ChatMessagesTableFilterComposer,
          $$ChatMessagesTableOrderingComposer,
          $$ChatMessagesTableAnnotationComposer,
          $$ChatMessagesTableCreateCompanionBuilder,
          $$ChatMessagesTableUpdateCompanionBuilder,
          (ChatMessage, $$ChatMessagesTableReferences),
          ChatMessage,
          PrefetchHooks Function({bool conversationId})
        > {
  $$ChatMessagesTableTableManager(_$AppDatabase db, $ChatMessagesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ChatMessagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ChatMessagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ChatMessagesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> conversationId = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<String> content = const Value.absent(),
                Value<DateTime> dibuatPada = const Value.absent(),
              }) => ChatMessagesCompanion(
                id: id,
                conversationId: conversationId,
                role: role,
                content: content,
                dibuatPada: dibuatPada,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int conversationId,
                required String role,
                required String content,
                required DateTime dibuatPada,
              }) => ChatMessagesCompanion.insert(
                id: id,
                conversationId: conversationId,
                role: role,
                content: content,
                dibuatPada: dibuatPada,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ChatMessagesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({conversationId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (conversationId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.conversationId,
                                referencedTable: $$ChatMessagesTableReferences
                                    ._conversationIdTable(db),
                                referencedColumn: $$ChatMessagesTableReferences
                                    ._conversationIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ChatMessagesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ChatMessagesTable,
      ChatMessage,
      $$ChatMessagesTableFilterComposer,
      $$ChatMessagesTableOrderingComposer,
      $$ChatMessagesTableAnnotationComposer,
      $$ChatMessagesTableCreateCompanionBuilder,
      $$ChatMessagesTableUpdateCompanionBuilder,
      (ChatMessage, $$ChatMessagesTableReferences),
      ChatMessage,
      PrefetchHooks Function({bool conversationId})
    >;
typedef $$DanaPlusConfigurationsTableCreateCompanionBuilder =
    DanaPlusConfigurationsCompanion Function({
      Value<int> id,
      required DanaPlusAvailability availability,
      required DanaSplitMode defaultSplitMode,
      required DanaExecutionStrategy executionStrategy,
      Value<int> persenBiasaBp,
      Value<int> bufferBiasa,
      Value<int> targetPlus,
      Value<int?> batasPlus,
      Value<int?> tingkatRewardBp,
      Value<RewardRatePeriod> periodeReward,
      required DateTime diperbaruiPada,
    });
typedef $$DanaPlusConfigurationsTableUpdateCompanionBuilder =
    DanaPlusConfigurationsCompanion Function({
      Value<int> id,
      Value<DanaPlusAvailability> availability,
      Value<DanaSplitMode> defaultSplitMode,
      Value<DanaExecutionStrategy> executionStrategy,
      Value<int> persenBiasaBp,
      Value<int> bufferBiasa,
      Value<int> targetPlus,
      Value<int?> batasPlus,
      Value<int?> tingkatRewardBp,
      Value<RewardRatePeriod> periodeReward,
      Value<DateTime> diperbaruiPada,
    });

class $$DanaPlusConfigurationsTableFilterComposer
    extends Composer<_$AppDatabase, $DanaPlusConfigurationsTable> {
  $$DanaPlusConfigurationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<
    DanaPlusAvailability,
    DanaPlusAvailability,
    String
  >
  get availability => $composableBuilder(
    column: $table.availability,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<DanaSplitMode, DanaSplitMode, String>
  get defaultSplitMode => $composableBuilder(
    column: $table.defaultSplitMode,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<
    DanaExecutionStrategy,
    DanaExecutionStrategy,
    String
  >
  get executionStrategy => $composableBuilder(
    column: $table.executionStrategy,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get persenBiasaBp => $composableBuilder(
    column: $table.persenBiasaBp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get bufferBiasa => $composableBuilder(
    column: $table.bufferBiasa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get targetPlus => $composableBuilder(
    column: $table.targetPlus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get batasPlus => $composableBuilder(
    column: $table.batasPlus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get tingkatRewardBp => $composableBuilder(
    column: $table.tingkatRewardBp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<RewardRatePeriod, RewardRatePeriod, String>
  get periodeReward => $composableBuilder(
    column: $table.periodeReward,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get diperbaruiPada => $composableBuilder(
    column: $table.diperbaruiPada,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DanaPlusConfigurationsTableOrderingComposer
    extends Composer<_$AppDatabase, $DanaPlusConfigurationsTable> {
  $$DanaPlusConfigurationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get availability => $composableBuilder(
    column: $table.availability,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get defaultSplitMode => $composableBuilder(
    column: $table.defaultSplitMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get executionStrategy => $composableBuilder(
    column: $table.executionStrategy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get persenBiasaBp => $composableBuilder(
    column: $table.persenBiasaBp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get bufferBiasa => $composableBuilder(
    column: $table.bufferBiasa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get targetPlus => $composableBuilder(
    column: $table.targetPlus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get batasPlus => $composableBuilder(
    column: $table.batasPlus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get tingkatRewardBp => $composableBuilder(
    column: $table.tingkatRewardBp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get periodeReward => $composableBuilder(
    column: $table.periodeReward,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get diperbaruiPada => $composableBuilder(
    column: $table.diperbaruiPada,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DanaPlusConfigurationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DanaPlusConfigurationsTable> {
  $$DanaPlusConfigurationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<DanaPlusAvailability, String>
  get availability => $composableBuilder(
    column: $table.availability,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<DanaSplitMode, String>
  get defaultSplitMode => $composableBuilder(
    column: $table.defaultSplitMode,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<DanaExecutionStrategy, String>
  get executionStrategy => $composableBuilder(
    column: $table.executionStrategy,
    builder: (column) => column,
  );

  GeneratedColumn<int> get persenBiasaBp => $composableBuilder(
    column: $table.persenBiasaBp,
    builder: (column) => column,
  );

  GeneratedColumn<int> get bufferBiasa => $composableBuilder(
    column: $table.bufferBiasa,
    builder: (column) => column,
  );

  GeneratedColumn<int> get targetPlus => $composableBuilder(
    column: $table.targetPlus,
    builder: (column) => column,
  );

  GeneratedColumn<int> get batasPlus =>
      $composableBuilder(column: $table.batasPlus, builder: (column) => column);

  GeneratedColumn<int> get tingkatRewardBp => $composableBuilder(
    column: $table.tingkatRewardBp,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<RewardRatePeriod, String>
  get periodeReward => $composableBuilder(
    column: $table.periodeReward,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get diperbaruiPada => $composableBuilder(
    column: $table.diperbaruiPada,
    builder: (column) => column,
  );
}

class $$DanaPlusConfigurationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DanaPlusConfigurationsTable,
          DanaPlusConfiguration,
          $$DanaPlusConfigurationsTableFilterComposer,
          $$DanaPlusConfigurationsTableOrderingComposer,
          $$DanaPlusConfigurationsTableAnnotationComposer,
          $$DanaPlusConfigurationsTableCreateCompanionBuilder,
          $$DanaPlusConfigurationsTableUpdateCompanionBuilder,
          (
            DanaPlusConfiguration,
            BaseReferences<
              _$AppDatabase,
              $DanaPlusConfigurationsTable,
              DanaPlusConfiguration
            >,
          ),
          DanaPlusConfiguration,
          PrefetchHooks Function()
        > {
  $$DanaPlusConfigurationsTableTableManager(
    _$AppDatabase db,
    $DanaPlusConfigurationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DanaPlusConfigurationsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$DanaPlusConfigurationsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$DanaPlusConfigurationsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DanaPlusAvailability> availability = const Value.absent(),
                Value<DanaSplitMode> defaultSplitMode = const Value.absent(),
                Value<DanaExecutionStrategy> executionStrategy =
                    const Value.absent(),
                Value<int> persenBiasaBp = const Value.absent(),
                Value<int> bufferBiasa = const Value.absent(),
                Value<int> targetPlus = const Value.absent(),
                Value<int?> batasPlus = const Value.absent(),
                Value<int?> tingkatRewardBp = const Value.absent(),
                Value<RewardRatePeriod> periodeReward = const Value.absent(),
                Value<DateTime> diperbaruiPada = const Value.absent(),
              }) => DanaPlusConfigurationsCompanion(
                id: id,
                availability: availability,
                defaultSplitMode: defaultSplitMode,
                executionStrategy: executionStrategy,
                persenBiasaBp: persenBiasaBp,
                bufferBiasa: bufferBiasa,
                targetPlus: targetPlus,
                batasPlus: batasPlus,
                tingkatRewardBp: tingkatRewardBp,
                periodeReward: periodeReward,
                diperbaruiPada: diperbaruiPada,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DanaPlusAvailability availability,
                required DanaSplitMode defaultSplitMode,
                required DanaExecutionStrategy executionStrategy,
                Value<int> persenBiasaBp = const Value.absent(),
                Value<int> bufferBiasa = const Value.absent(),
                Value<int> targetPlus = const Value.absent(),
                Value<int?> batasPlus = const Value.absent(),
                Value<int?> tingkatRewardBp = const Value.absent(),
                Value<RewardRatePeriod> periodeReward = const Value.absent(),
                required DateTime diperbaruiPada,
              }) => DanaPlusConfigurationsCompanion.insert(
                id: id,
                availability: availability,
                defaultSplitMode: defaultSplitMode,
                executionStrategy: executionStrategy,
                persenBiasaBp: persenBiasaBp,
                bufferBiasa: bufferBiasa,
                targetPlus: targetPlus,
                batasPlus: batasPlus,
                tingkatRewardBp: tingkatRewardBp,
                periodeReward: periodeReward,
                diperbaruiPada: diperbaruiPada,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DanaPlusConfigurationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DanaPlusConfigurationsTable,
      DanaPlusConfiguration,
      $$DanaPlusConfigurationsTableFilterComposer,
      $$DanaPlusConfigurationsTableOrderingComposer,
      $$DanaPlusConfigurationsTableAnnotationComposer,
      $$DanaPlusConfigurationsTableCreateCompanionBuilder,
      $$DanaPlusConfigurationsTableUpdateCompanionBuilder,
      (
        DanaPlusConfiguration,
        BaseReferences<
          _$AppDatabase,
          $DanaPlusConfigurationsTable,
          DanaPlusConfiguration
        >,
      ),
      DanaPlusConfiguration,
      PrefetchHooks Function()
    >;
typedef $$DanaBalanceLedgersTableCreateCompanionBuilder =
    DanaBalanceLedgersCompanion Function({
      Value<int> id,
      required int tahun,
      required int bulan,
      required int saldoAwalBiasa,
      required int saldoAwalPlus,
      required int topUpKeBiasa,
      required int pindahKePlus,
      required int pindahDariPlus,
      required int pengeluaranBiasa,
      required int pengeluaranPlus,
      required int rewardAktual,
      required int saldoAkhirBiasa,
      required int saldoAkhirPlus,
      required DateTime dibuatPada,
    });
typedef $$DanaBalanceLedgersTableUpdateCompanionBuilder =
    DanaBalanceLedgersCompanion Function({
      Value<int> id,
      Value<int> tahun,
      Value<int> bulan,
      Value<int> saldoAwalBiasa,
      Value<int> saldoAwalPlus,
      Value<int> topUpKeBiasa,
      Value<int> pindahKePlus,
      Value<int> pindahDariPlus,
      Value<int> pengeluaranBiasa,
      Value<int> pengeluaranPlus,
      Value<int> rewardAktual,
      Value<int> saldoAkhirBiasa,
      Value<int> saldoAkhirPlus,
      Value<DateTime> dibuatPada,
    });

class $$DanaBalanceLedgersTableFilterComposer
    extends Composer<_$AppDatabase, $DanaBalanceLedgersTable> {
  $$DanaBalanceLedgersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get tahun => $composableBuilder(
    column: $table.tahun,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get bulan => $composableBuilder(
    column: $table.bulan,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get saldoAwalBiasa => $composableBuilder(
    column: $table.saldoAwalBiasa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get saldoAwalPlus => $composableBuilder(
    column: $table.saldoAwalPlus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get topUpKeBiasa => $composableBuilder(
    column: $table.topUpKeBiasa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pindahKePlus => $composableBuilder(
    column: $table.pindahKePlus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pindahDariPlus => $composableBuilder(
    column: $table.pindahDariPlus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pengeluaranBiasa => $composableBuilder(
    column: $table.pengeluaranBiasa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pengeluaranPlus => $composableBuilder(
    column: $table.pengeluaranPlus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rewardAktual => $composableBuilder(
    column: $table.rewardAktual,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get saldoAkhirBiasa => $composableBuilder(
    column: $table.saldoAkhirBiasa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get saldoAkhirPlus => $composableBuilder(
    column: $table.saldoAkhirPlus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dibuatPada => $composableBuilder(
    column: $table.dibuatPada,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DanaBalanceLedgersTableOrderingComposer
    extends Composer<_$AppDatabase, $DanaBalanceLedgersTable> {
  $$DanaBalanceLedgersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get tahun => $composableBuilder(
    column: $table.tahun,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get bulan => $composableBuilder(
    column: $table.bulan,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get saldoAwalBiasa => $composableBuilder(
    column: $table.saldoAwalBiasa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get saldoAwalPlus => $composableBuilder(
    column: $table.saldoAwalPlus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get topUpKeBiasa => $composableBuilder(
    column: $table.topUpKeBiasa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pindahKePlus => $composableBuilder(
    column: $table.pindahKePlus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pindahDariPlus => $composableBuilder(
    column: $table.pindahDariPlus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pengeluaranBiasa => $composableBuilder(
    column: $table.pengeluaranBiasa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pengeluaranPlus => $composableBuilder(
    column: $table.pengeluaranPlus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rewardAktual => $composableBuilder(
    column: $table.rewardAktual,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get saldoAkhirBiasa => $composableBuilder(
    column: $table.saldoAkhirBiasa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get saldoAkhirPlus => $composableBuilder(
    column: $table.saldoAkhirPlus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dibuatPada => $composableBuilder(
    column: $table.dibuatPada,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DanaBalanceLedgersTableAnnotationComposer
    extends Composer<_$AppDatabase, $DanaBalanceLedgersTable> {
  $$DanaBalanceLedgersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get tahun =>
      $composableBuilder(column: $table.tahun, builder: (column) => column);

  GeneratedColumn<int> get bulan =>
      $composableBuilder(column: $table.bulan, builder: (column) => column);

  GeneratedColumn<int> get saldoAwalBiasa => $composableBuilder(
    column: $table.saldoAwalBiasa,
    builder: (column) => column,
  );

  GeneratedColumn<int> get saldoAwalPlus => $composableBuilder(
    column: $table.saldoAwalPlus,
    builder: (column) => column,
  );

  GeneratedColumn<int> get topUpKeBiasa => $composableBuilder(
    column: $table.topUpKeBiasa,
    builder: (column) => column,
  );

  GeneratedColumn<int> get pindahKePlus => $composableBuilder(
    column: $table.pindahKePlus,
    builder: (column) => column,
  );

  GeneratedColumn<int> get pindahDariPlus => $composableBuilder(
    column: $table.pindahDariPlus,
    builder: (column) => column,
  );

  GeneratedColumn<int> get pengeluaranBiasa => $composableBuilder(
    column: $table.pengeluaranBiasa,
    builder: (column) => column,
  );

  GeneratedColumn<int> get pengeluaranPlus => $composableBuilder(
    column: $table.pengeluaranPlus,
    builder: (column) => column,
  );

  GeneratedColumn<int> get rewardAktual => $composableBuilder(
    column: $table.rewardAktual,
    builder: (column) => column,
  );

  GeneratedColumn<int> get saldoAkhirBiasa => $composableBuilder(
    column: $table.saldoAkhirBiasa,
    builder: (column) => column,
  );

  GeneratedColumn<int> get saldoAkhirPlus => $composableBuilder(
    column: $table.saldoAkhirPlus,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get dibuatPada => $composableBuilder(
    column: $table.dibuatPada,
    builder: (column) => column,
  );
}

class $$DanaBalanceLedgersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DanaBalanceLedgersTable,
          DanaBalanceLedger,
          $$DanaBalanceLedgersTableFilterComposer,
          $$DanaBalanceLedgersTableOrderingComposer,
          $$DanaBalanceLedgersTableAnnotationComposer,
          $$DanaBalanceLedgersTableCreateCompanionBuilder,
          $$DanaBalanceLedgersTableUpdateCompanionBuilder,
          (
            DanaBalanceLedger,
            BaseReferences<
              _$AppDatabase,
              $DanaBalanceLedgersTable,
              DanaBalanceLedger
            >,
          ),
          DanaBalanceLedger,
          PrefetchHooks Function()
        > {
  $$DanaBalanceLedgersTableTableManager(
    _$AppDatabase db,
    $DanaBalanceLedgersTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DanaBalanceLedgersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DanaBalanceLedgersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DanaBalanceLedgersTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> tahun = const Value.absent(),
                Value<int> bulan = const Value.absent(),
                Value<int> saldoAwalBiasa = const Value.absent(),
                Value<int> saldoAwalPlus = const Value.absent(),
                Value<int> topUpKeBiasa = const Value.absent(),
                Value<int> pindahKePlus = const Value.absent(),
                Value<int> pindahDariPlus = const Value.absent(),
                Value<int> pengeluaranBiasa = const Value.absent(),
                Value<int> pengeluaranPlus = const Value.absent(),
                Value<int> rewardAktual = const Value.absent(),
                Value<int> saldoAkhirBiasa = const Value.absent(),
                Value<int> saldoAkhirPlus = const Value.absent(),
                Value<DateTime> dibuatPada = const Value.absent(),
              }) => DanaBalanceLedgersCompanion(
                id: id,
                tahun: tahun,
                bulan: bulan,
                saldoAwalBiasa: saldoAwalBiasa,
                saldoAwalPlus: saldoAwalPlus,
                topUpKeBiasa: topUpKeBiasa,
                pindahKePlus: pindahKePlus,
                pindahDariPlus: pindahDariPlus,
                pengeluaranBiasa: pengeluaranBiasa,
                pengeluaranPlus: pengeluaranPlus,
                rewardAktual: rewardAktual,
                saldoAkhirBiasa: saldoAkhirBiasa,
                saldoAkhirPlus: saldoAkhirPlus,
                dibuatPada: dibuatPada,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int tahun,
                required int bulan,
                required int saldoAwalBiasa,
                required int saldoAwalPlus,
                required int topUpKeBiasa,
                required int pindahKePlus,
                required int pindahDariPlus,
                required int pengeluaranBiasa,
                required int pengeluaranPlus,
                required int rewardAktual,
                required int saldoAkhirBiasa,
                required int saldoAkhirPlus,
                required DateTime dibuatPada,
              }) => DanaBalanceLedgersCompanion.insert(
                id: id,
                tahun: tahun,
                bulan: bulan,
                saldoAwalBiasa: saldoAwalBiasa,
                saldoAwalPlus: saldoAwalPlus,
                topUpKeBiasa: topUpKeBiasa,
                pindahKePlus: pindahKePlus,
                pindahDariPlus: pindahDariPlus,
                pengeluaranBiasa: pengeluaranBiasa,
                pengeluaranPlus: pengeluaranPlus,
                rewardAktual: rewardAktual,
                saldoAkhirBiasa: saldoAkhirBiasa,
                saldoAkhirPlus: saldoAkhirPlus,
                dibuatPada: dibuatPada,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DanaBalanceLedgersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DanaBalanceLedgersTable,
      DanaBalanceLedger,
      $$DanaBalanceLedgersTableFilterComposer,
      $$DanaBalanceLedgersTableOrderingComposer,
      $$DanaBalanceLedgersTableAnnotationComposer,
      $$DanaBalanceLedgersTableCreateCompanionBuilder,
      $$DanaBalanceLedgersTableUpdateCompanionBuilder,
      (
        DanaBalanceLedger,
        BaseReferences<
          _$AppDatabase,
          $DanaBalanceLedgersTable,
          DanaBalanceLedger
        >,
      ),
      DanaBalanceLedger,
      PrefetchHooks Function()
    >;
typedef $$InvestmentActualsTableCreateCompanionBuilder =
    InvestmentActualsCompanion Function({
      Value<int> id,
      required InvestmentPlatform platform,
      required int tahun,
      required int bulan,
      Value<int?> depositEksternal,
      Value<int?> penarikan,
      Value<int?> pembelianBersih,
      Value<int?> penjualanBersih,
      Value<int?> saldoRdnAwal,
      Value<int?> saldoRdnAkhir,
      Value<int?> biaya,
      Value<int?> dividen,
      Value<int?> nilaiPortofolio,
      Value<int?> modalInvestasi,
      required VerificationStatus verifikasi,
      Value<String?> catatan,
      required DateTime diperbaruiPada,
    });
typedef $$InvestmentActualsTableUpdateCompanionBuilder =
    InvestmentActualsCompanion Function({
      Value<int> id,
      Value<InvestmentPlatform> platform,
      Value<int> tahun,
      Value<int> bulan,
      Value<int?> depositEksternal,
      Value<int?> penarikan,
      Value<int?> pembelianBersih,
      Value<int?> penjualanBersih,
      Value<int?> saldoRdnAwal,
      Value<int?> saldoRdnAkhir,
      Value<int?> biaya,
      Value<int?> dividen,
      Value<int?> nilaiPortofolio,
      Value<int?> modalInvestasi,
      Value<VerificationStatus> verifikasi,
      Value<String?> catatan,
      Value<DateTime> diperbaruiPada,
    });

class $$InvestmentActualsTableFilterComposer
    extends Composer<_$AppDatabase, $InvestmentActualsTable> {
  $$InvestmentActualsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<InvestmentPlatform, InvestmentPlatform, String>
  get platform => $composableBuilder(
    column: $table.platform,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get tahun => $composableBuilder(
    column: $table.tahun,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get bulan => $composableBuilder(
    column: $table.bulan,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get depositEksternal => $composableBuilder(
    column: $table.depositEksternal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get penarikan => $composableBuilder(
    column: $table.penarikan,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pembelianBersih => $composableBuilder(
    column: $table.pembelianBersih,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get penjualanBersih => $composableBuilder(
    column: $table.penjualanBersih,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get saldoRdnAwal => $composableBuilder(
    column: $table.saldoRdnAwal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get saldoRdnAkhir => $composableBuilder(
    column: $table.saldoRdnAkhir,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get biaya => $composableBuilder(
    column: $table.biaya,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get dividen => $composableBuilder(
    column: $table.dividen,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get nilaiPortofolio => $composableBuilder(
    column: $table.nilaiPortofolio,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get modalInvestasi => $composableBuilder(
    column: $table.modalInvestasi,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<VerificationStatus, VerificationStatus, String>
  get verifikasi => $composableBuilder(
    column: $table.verifikasi,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get catatan => $composableBuilder(
    column: $table.catatan,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get diperbaruiPada => $composableBuilder(
    column: $table.diperbaruiPada,
    builder: (column) => ColumnFilters(column),
  );
}

class $$InvestmentActualsTableOrderingComposer
    extends Composer<_$AppDatabase, $InvestmentActualsTable> {
  $$InvestmentActualsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get platform => $composableBuilder(
    column: $table.platform,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get tahun => $composableBuilder(
    column: $table.tahun,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get bulan => $composableBuilder(
    column: $table.bulan,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get depositEksternal => $composableBuilder(
    column: $table.depositEksternal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get penarikan => $composableBuilder(
    column: $table.penarikan,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pembelianBersih => $composableBuilder(
    column: $table.pembelianBersih,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get penjualanBersih => $composableBuilder(
    column: $table.penjualanBersih,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get saldoRdnAwal => $composableBuilder(
    column: $table.saldoRdnAwal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get saldoRdnAkhir => $composableBuilder(
    column: $table.saldoRdnAkhir,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get biaya => $composableBuilder(
    column: $table.biaya,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get dividen => $composableBuilder(
    column: $table.dividen,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get nilaiPortofolio => $composableBuilder(
    column: $table.nilaiPortofolio,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get modalInvestasi => $composableBuilder(
    column: $table.modalInvestasi,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get verifikasi => $composableBuilder(
    column: $table.verifikasi,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get catatan => $composableBuilder(
    column: $table.catatan,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get diperbaruiPada => $composableBuilder(
    column: $table.diperbaruiPada,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$InvestmentActualsTableAnnotationComposer
    extends Composer<_$AppDatabase, $InvestmentActualsTable> {
  $$InvestmentActualsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<InvestmentPlatform, String> get platform =>
      $composableBuilder(column: $table.platform, builder: (column) => column);

  GeneratedColumn<int> get tahun =>
      $composableBuilder(column: $table.tahun, builder: (column) => column);

  GeneratedColumn<int> get bulan =>
      $composableBuilder(column: $table.bulan, builder: (column) => column);

  GeneratedColumn<int> get depositEksternal => $composableBuilder(
    column: $table.depositEksternal,
    builder: (column) => column,
  );

  GeneratedColumn<int> get penarikan =>
      $composableBuilder(column: $table.penarikan, builder: (column) => column);

  GeneratedColumn<int> get pembelianBersih => $composableBuilder(
    column: $table.pembelianBersih,
    builder: (column) => column,
  );

  GeneratedColumn<int> get penjualanBersih => $composableBuilder(
    column: $table.penjualanBersih,
    builder: (column) => column,
  );

  GeneratedColumn<int> get saldoRdnAwal => $composableBuilder(
    column: $table.saldoRdnAwal,
    builder: (column) => column,
  );

  GeneratedColumn<int> get saldoRdnAkhir => $composableBuilder(
    column: $table.saldoRdnAkhir,
    builder: (column) => column,
  );

  GeneratedColumn<int> get biaya =>
      $composableBuilder(column: $table.biaya, builder: (column) => column);

  GeneratedColumn<int> get dividen =>
      $composableBuilder(column: $table.dividen, builder: (column) => column);

  GeneratedColumn<int> get nilaiPortofolio => $composableBuilder(
    column: $table.nilaiPortofolio,
    builder: (column) => column,
  );

  GeneratedColumn<int> get modalInvestasi => $composableBuilder(
    column: $table.modalInvestasi,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<VerificationStatus, String> get verifikasi =>
      $composableBuilder(
        column: $table.verifikasi,
        builder: (column) => column,
      );

  GeneratedColumn<String> get catatan =>
      $composableBuilder(column: $table.catatan, builder: (column) => column);

  GeneratedColumn<DateTime> get diperbaruiPada => $composableBuilder(
    column: $table.diperbaruiPada,
    builder: (column) => column,
  );
}

class $$InvestmentActualsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InvestmentActualsTable,
          InvestmentActual,
          $$InvestmentActualsTableFilterComposer,
          $$InvestmentActualsTableOrderingComposer,
          $$InvestmentActualsTableAnnotationComposer,
          $$InvestmentActualsTableCreateCompanionBuilder,
          $$InvestmentActualsTableUpdateCompanionBuilder,
          (
            InvestmentActual,
            BaseReferences<
              _$AppDatabase,
              $InvestmentActualsTable,
              InvestmentActual
            >,
          ),
          InvestmentActual,
          PrefetchHooks Function()
        > {
  $$InvestmentActualsTableTableManager(
    _$AppDatabase db,
    $InvestmentActualsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InvestmentActualsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InvestmentActualsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InvestmentActualsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<InvestmentPlatform> platform = const Value.absent(),
                Value<int> tahun = const Value.absent(),
                Value<int> bulan = const Value.absent(),
                Value<int?> depositEksternal = const Value.absent(),
                Value<int?> penarikan = const Value.absent(),
                Value<int?> pembelianBersih = const Value.absent(),
                Value<int?> penjualanBersih = const Value.absent(),
                Value<int?> saldoRdnAwal = const Value.absent(),
                Value<int?> saldoRdnAkhir = const Value.absent(),
                Value<int?> biaya = const Value.absent(),
                Value<int?> dividen = const Value.absent(),
                Value<int?> nilaiPortofolio = const Value.absent(),
                Value<int?> modalInvestasi = const Value.absent(),
                Value<VerificationStatus> verifikasi = const Value.absent(),
                Value<String?> catatan = const Value.absent(),
                Value<DateTime> diperbaruiPada = const Value.absent(),
              }) => InvestmentActualsCompanion(
                id: id,
                platform: platform,
                tahun: tahun,
                bulan: bulan,
                depositEksternal: depositEksternal,
                penarikan: penarikan,
                pembelianBersih: pembelianBersih,
                penjualanBersih: penjualanBersih,
                saldoRdnAwal: saldoRdnAwal,
                saldoRdnAkhir: saldoRdnAkhir,
                biaya: biaya,
                dividen: dividen,
                nilaiPortofolio: nilaiPortofolio,
                modalInvestasi: modalInvestasi,
                verifikasi: verifikasi,
                catatan: catatan,
                diperbaruiPada: diperbaruiPada,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required InvestmentPlatform platform,
                required int tahun,
                required int bulan,
                Value<int?> depositEksternal = const Value.absent(),
                Value<int?> penarikan = const Value.absent(),
                Value<int?> pembelianBersih = const Value.absent(),
                Value<int?> penjualanBersih = const Value.absent(),
                Value<int?> saldoRdnAwal = const Value.absent(),
                Value<int?> saldoRdnAkhir = const Value.absent(),
                Value<int?> biaya = const Value.absent(),
                Value<int?> dividen = const Value.absent(),
                Value<int?> nilaiPortofolio = const Value.absent(),
                Value<int?> modalInvestasi = const Value.absent(),
                required VerificationStatus verifikasi,
                Value<String?> catatan = const Value.absent(),
                required DateTime diperbaruiPada,
              }) => InvestmentActualsCompanion.insert(
                id: id,
                platform: platform,
                tahun: tahun,
                bulan: bulan,
                depositEksternal: depositEksternal,
                penarikan: penarikan,
                pembelianBersih: pembelianBersih,
                penjualanBersih: penjualanBersih,
                saldoRdnAwal: saldoRdnAwal,
                saldoRdnAkhir: saldoRdnAkhir,
                biaya: biaya,
                dividen: dividen,
                nilaiPortofolio: nilaiPortofolio,
                modalInvestasi: modalInvestasi,
                verifikasi: verifikasi,
                catatan: catatan,
                diperbaruiPada: diperbaruiPada,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$InvestmentActualsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InvestmentActualsTable,
      InvestmentActual,
      $$InvestmentActualsTableFilterComposer,
      $$InvestmentActualsTableOrderingComposer,
      $$InvestmentActualsTableAnnotationComposer,
      $$InvestmentActualsTableCreateCompanionBuilder,
      $$InvestmentActualsTableUpdateCompanionBuilder,
      (
        InvestmentActual,
        BaseReferences<
          _$AppDatabase,
          $InvestmentActualsTable,
          InvestmentActual
        >,
      ),
      InvestmentActual,
      PrefetchHooks Function()
    >;
typedef $$ImportedReportsTableCreateCompanionBuilder =
    ImportedReportsCompanion Function({
      Value<int> id,
      required InvestmentPlatform platform,
      required String jenis,
      Value<int?> tahun,
      Value<int?> bulan,
      required String fileHash,
      required String namaFile,
      required DateTime diimporPada,
    });
typedef $$ImportedReportsTableUpdateCompanionBuilder =
    ImportedReportsCompanion Function({
      Value<int> id,
      Value<InvestmentPlatform> platform,
      Value<String> jenis,
      Value<int?> tahun,
      Value<int?> bulan,
      Value<String> fileHash,
      Value<String> namaFile,
      Value<DateTime> diimporPada,
    });

class $$ImportedReportsTableFilterComposer
    extends Composer<_$AppDatabase, $ImportedReportsTable> {
  $$ImportedReportsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<InvestmentPlatform, InvestmentPlatform, String>
  get platform => $composableBuilder(
    column: $table.platform,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get jenis => $composableBuilder(
    column: $table.jenis,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get tahun => $composableBuilder(
    column: $table.tahun,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get bulan => $composableBuilder(
    column: $table.bulan,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fileHash => $composableBuilder(
    column: $table.fileHash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get namaFile => $composableBuilder(
    column: $table.namaFile,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get diimporPada => $composableBuilder(
    column: $table.diimporPada,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ImportedReportsTableOrderingComposer
    extends Composer<_$AppDatabase, $ImportedReportsTable> {
  $$ImportedReportsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get platform => $composableBuilder(
    column: $table.platform,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get jenis => $composableBuilder(
    column: $table.jenis,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get tahun => $composableBuilder(
    column: $table.tahun,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get bulan => $composableBuilder(
    column: $table.bulan,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fileHash => $composableBuilder(
    column: $table.fileHash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get namaFile => $composableBuilder(
    column: $table.namaFile,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get diimporPada => $composableBuilder(
    column: $table.diimporPada,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ImportedReportsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ImportedReportsTable> {
  $$ImportedReportsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<InvestmentPlatform, String> get platform =>
      $composableBuilder(column: $table.platform, builder: (column) => column);

  GeneratedColumn<String> get jenis =>
      $composableBuilder(column: $table.jenis, builder: (column) => column);

  GeneratedColumn<int> get tahun =>
      $composableBuilder(column: $table.tahun, builder: (column) => column);

  GeneratedColumn<int> get bulan =>
      $composableBuilder(column: $table.bulan, builder: (column) => column);

  GeneratedColumn<String> get fileHash =>
      $composableBuilder(column: $table.fileHash, builder: (column) => column);

  GeneratedColumn<String> get namaFile =>
      $composableBuilder(column: $table.namaFile, builder: (column) => column);

  GeneratedColumn<DateTime> get diimporPada => $composableBuilder(
    column: $table.diimporPada,
    builder: (column) => column,
  );
}

class $$ImportedReportsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ImportedReportsTable,
          ImportedReport,
          $$ImportedReportsTableFilterComposer,
          $$ImportedReportsTableOrderingComposer,
          $$ImportedReportsTableAnnotationComposer,
          $$ImportedReportsTableCreateCompanionBuilder,
          $$ImportedReportsTableUpdateCompanionBuilder,
          (
            ImportedReport,
            BaseReferences<
              _$AppDatabase,
              $ImportedReportsTable,
              ImportedReport
            >,
          ),
          ImportedReport,
          PrefetchHooks Function()
        > {
  $$ImportedReportsTableTableManager(
    _$AppDatabase db,
    $ImportedReportsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ImportedReportsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ImportedReportsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ImportedReportsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<InvestmentPlatform> platform = const Value.absent(),
                Value<String> jenis = const Value.absent(),
                Value<int?> tahun = const Value.absent(),
                Value<int?> bulan = const Value.absent(),
                Value<String> fileHash = const Value.absent(),
                Value<String> namaFile = const Value.absent(),
                Value<DateTime> diimporPada = const Value.absent(),
              }) => ImportedReportsCompanion(
                id: id,
                platform: platform,
                jenis: jenis,
                tahun: tahun,
                bulan: bulan,
                fileHash: fileHash,
                namaFile: namaFile,
                diimporPada: diimporPada,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required InvestmentPlatform platform,
                required String jenis,
                Value<int?> tahun = const Value.absent(),
                Value<int?> bulan = const Value.absent(),
                required String fileHash,
                required String namaFile,
                required DateTime diimporPada,
              }) => ImportedReportsCompanion.insert(
                id: id,
                platform: platform,
                jenis: jenis,
                tahun: tahun,
                bulan: bulan,
                fileHash: fileHash,
                namaFile: namaFile,
                diimporPada: diimporPada,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ImportedReportsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ImportedReportsTable,
      ImportedReport,
      $$ImportedReportsTableFilterComposer,
      $$ImportedReportsTableOrderingComposer,
      $$ImportedReportsTableAnnotationComposer,
      $$ImportedReportsTableCreateCompanionBuilder,
      $$ImportedReportsTableUpdateCompanionBuilder,
      (
        ImportedReport,
        BaseReferences<_$AppDatabase, $ImportedReportsTable, ImportedReport>,
      ),
      ImportedReport,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$MonthlyAllocationsTableTableManager get monthlyAllocations =>
      $$MonthlyAllocationsTableTableManager(_db, _db.monthlyAllocations);
  $$MonthlyAllocationRevisionsTableTableManager
  get monthlyAllocationRevisions =>
      $$MonthlyAllocationRevisionsTableTableManager(
        _db,
        _db.monthlyAllocationRevisions,
      );
  $$IncomeSourcesTableTableManager get incomeSources =>
      $$IncomeSourcesTableTableManager(_db, _db.incomeSources);
  $$MandatoryExpensesTableTableManager get mandatoryExpenses =>
      $$MandatoryExpensesTableTableManager(_db, _db.mandatoryExpenses);
  $$BudgetFundingAssignmentsTableTableManager get budgetFundingAssignments =>
      $$BudgetFundingAssignmentsTableTableManager(
        _db,
        _db.budgetFundingAssignments,
      );
  $$ExpenseRealizationsTableTableManager get expenseRealizations =>
      $$ExpenseRealizationsTableTableManager(_db, _db.expenseRealizations);
  $$SubscriptionsTableTableManager get subscriptions =>
      $$SubscriptionsTableTableManager(_db, _db.subscriptions);
  $$SubscriptionReserveLedgersTableTableManager
  get subscriptionReserveLedgers =>
      $$SubscriptionReserveLedgersTableTableManager(
        _db,
        _db.subscriptionReserveLedgers,
      );
  $$EmergencyFundTargetsTableTableManager get emergencyFundTargets =>
      $$EmergencyFundTargetsTableTableManager(_db, _db.emergencyFundTargets);
  $$EmergencyFundContributionsTableTableManager
  get emergencyFundContributions =>
      $$EmergencyFundContributionsTableTableManager(
        _db,
        _db.emergencyFundContributions,
      );
  $$OtherSavingsContributionsTableTableManager get otherSavingsContributions =>
      $$OtherSavingsContributionsTableTableManager(
        _db,
        _db.otherSavingsContributions,
      );
  $$InvestmentPlatformAllocationsTableTableManager
  get investmentPlatformAllocations =>
      $$InvestmentPlatformAllocationsTableTableManager(
        _db,
        _db.investmentPlatformAllocations,
      );
  $$ChecklistItemsTableTableManager get checklistItems =>
      $$ChecklistItemsTableTableManager(_db, _db.checklistItems);
  $$RemindersTableTableManager get reminders =>
      $$RemindersTableTableManager(_db, _db.reminders);
  $$AppSettingsTableTableManager get appSettings =>
      $$AppSettingsTableTableManager(_db, _db.appSettings);
  $$AiProviderConfigurationsTableTableManager get aiProviderConfigurations =>
      $$AiProviderConfigurationsTableTableManager(
        _db,
        _db.aiProviderConfigurations,
      );
  $$AiModelsTableTableManager get aiModels =>
      $$AiModelsTableTableManager(_db, _db.aiModels);
  $$ModelListCachesTableTableManager get modelListCaches =>
      $$ModelListCachesTableTableManager(_db, _db.modelListCaches);
  $$ChatConversationsTableTableManager get chatConversations =>
      $$ChatConversationsTableTableManager(_db, _db.chatConversations);
  $$ChatMessagesTableTableManager get chatMessages =>
      $$ChatMessagesTableTableManager(_db, _db.chatMessages);
  $$DanaPlusConfigurationsTableTableManager get danaPlusConfigurations =>
      $$DanaPlusConfigurationsTableTableManager(
        _db,
        _db.danaPlusConfigurations,
      );
  $$DanaBalanceLedgersTableTableManager get danaBalanceLedgers =>
      $$DanaBalanceLedgersTableTableManager(_db, _db.danaBalanceLedgers);
  $$InvestmentActualsTableTableManager get investmentActuals =>
      $$InvestmentActualsTableTableManager(_db, _db.investmentActuals);
  $$ImportedReportsTableTableManager get importedReports =>
      $$ImportedReportsTableTableManager(_db, _db.importedReports);
}
