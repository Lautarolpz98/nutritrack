// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $UserProfilesTable extends UserProfiles
    with TableInfo<$UserProfilesTable, UserProfile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserProfilesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
    'nombre',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _edadMeta = const VerificationMeta('edad');
  @override
  late final GeneratedColumn<int> edad = GeneratedColumn<int>(
    'edad',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<Sexo, String> sexo =
      GeneratedColumn<String>(
        'sexo',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<Sexo>($UserProfilesTable.$convertersexo);
  static const VerificationMeta _pesoKgMeta = const VerificationMeta('pesoKg');
  @override
  late final GeneratedColumn<double> pesoKg = GeneratedColumn<double>(
    'peso_kg',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _alturaCmMeta = const VerificationMeta(
    'alturaCm',
  );
  @override
  late final GeneratedColumn<double> alturaCm = GeneratedColumn<double>(
    'altura_cm',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<NivelActividad, String>
  nivelActividad = GeneratedColumn<String>(
    'nivel_actividad',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<NivelActividad>($UserProfilesTable.$converternivelActividad);
  @override
  late final GeneratedColumnWithTypeConverter<Objetivo, String> objetivo =
      GeneratedColumn<String>(
        'objetivo',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<Objetivo>($UserProfilesTable.$converterobjetivo);
  static const VerificationMeta _objetivoCaloriasMeta = const VerificationMeta(
    'objetivoCalorias',
  );
  @override
  late final GeneratedColumn<int> objetivoCalorias = GeneratedColumn<int>(
    'objetivo_calorias',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _objetivoProteinasGMeta =
      const VerificationMeta('objetivoProteinasG');
  @override
  late final GeneratedColumn<double> objetivoProteinasG =
      GeneratedColumn<double>(
        'objetivo_proteinas_g',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _objetivoCarbohidratosGMeta =
      const VerificationMeta('objetivoCarbohidratosG');
  @override
  late final GeneratedColumn<double> objetivoCarbohidratosG =
      GeneratedColumn<double>(
        'objetivo_carbohidratos_g',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _objetivoGrasasGMeta = const VerificationMeta(
    'objetivoGrasasG',
  );
  @override
  late final GeneratedColumn<double> objetivoGrasasG = GeneratedColumn<double>(
    'objetivo_grasas_g',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _objetivoAguaMlMeta = const VerificationMeta(
    'objetivoAguaMl',
  );
  @override
  late final GeneratedColumn<int> objetivoAguaMl = GeneratedColumn<int>(
    'objetivo_agua_ml',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _objetivoSuenoHorasMeta =
      const VerificationMeta('objetivoSuenoHoras');
  @override
  late final GeneratedColumn<double> objetivoSuenoHoras =
      GeneratedColumn<double>(
        'objetivo_sueno_horas',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
        defaultValue: const Constant(8),
      );
  static const VerificationMeta _unidadPesoMeta = const VerificationMeta(
    'unidadPeso',
  );
  @override
  late final GeneratedColumn<String> unidadPeso = GeneratedColumn<String>(
    'unidad_peso',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('kg'),
  );
  static const VerificationMeta _actualizadoEnMeta = const VerificationMeta(
    'actualizadoEn',
  );
  @override
  late final GeneratedColumn<DateTime> actualizadoEn =
      GeneratedColumn<DateTime>(
        'actualizado_en',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
        defaultValue: currentDateAndTime,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nombre,
    edad,
    sexo,
    pesoKg,
    alturaCm,
    nivelActividad,
    objetivo,
    objetivoCalorias,
    objetivoProteinasG,
    objetivoCarbohidratosG,
    objetivoGrasasG,
    objetivoAguaMl,
    objetivoSuenoHoras,
    unidadPeso,
    actualizadoEn,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_profiles';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserProfile> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nombre')) {
      context.handle(
        _nombreMeta,
        nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta),
      );
    }
    if (data.containsKey('edad')) {
      context.handle(
        _edadMeta,
        edad.isAcceptableOrUnknown(data['edad']!, _edadMeta),
      );
    } else if (isInserting) {
      context.missing(_edadMeta);
    }
    if (data.containsKey('peso_kg')) {
      context.handle(
        _pesoKgMeta,
        pesoKg.isAcceptableOrUnknown(data['peso_kg']!, _pesoKgMeta),
      );
    } else if (isInserting) {
      context.missing(_pesoKgMeta);
    }
    if (data.containsKey('altura_cm')) {
      context.handle(
        _alturaCmMeta,
        alturaCm.isAcceptableOrUnknown(data['altura_cm']!, _alturaCmMeta),
      );
    } else if (isInserting) {
      context.missing(_alturaCmMeta);
    }
    if (data.containsKey('objetivo_calorias')) {
      context.handle(
        _objetivoCaloriasMeta,
        objetivoCalorias.isAcceptableOrUnknown(
          data['objetivo_calorias']!,
          _objetivoCaloriasMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_objetivoCaloriasMeta);
    }
    if (data.containsKey('objetivo_proteinas_g')) {
      context.handle(
        _objetivoProteinasGMeta,
        objetivoProteinasG.isAcceptableOrUnknown(
          data['objetivo_proteinas_g']!,
          _objetivoProteinasGMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_objetivoProteinasGMeta);
    }
    if (data.containsKey('objetivo_carbohidratos_g')) {
      context.handle(
        _objetivoCarbohidratosGMeta,
        objetivoCarbohidratosG.isAcceptableOrUnknown(
          data['objetivo_carbohidratos_g']!,
          _objetivoCarbohidratosGMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_objetivoCarbohidratosGMeta);
    }
    if (data.containsKey('objetivo_grasas_g')) {
      context.handle(
        _objetivoGrasasGMeta,
        objetivoGrasasG.isAcceptableOrUnknown(
          data['objetivo_grasas_g']!,
          _objetivoGrasasGMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_objetivoGrasasGMeta);
    }
    if (data.containsKey('objetivo_agua_ml')) {
      context.handle(
        _objetivoAguaMlMeta,
        objetivoAguaMl.isAcceptableOrUnknown(
          data['objetivo_agua_ml']!,
          _objetivoAguaMlMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_objetivoAguaMlMeta);
    }
    if (data.containsKey('objetivo_sueno_horas')) {
      context.handle(
        _objetivoSuenoHorasMeta,
        objetivoSuenoHoras.isAcceptableOrUnknown(
          data['objetivo_sueno_horas']!,
          _objetivoSuenoHorasMeta,
        ),
      );
    }
    if (data.containsKey('unidad_peso')) {
      context.handle(
        _unidadPesoMeta,
        unidadPeso.isAcceptableOrUnknown(data['unidad_peso']!, _unidadPesoMeta),
      );
    }
    if (data.containsKey('actualizado_en')) {
      context.handle(
        _actualizadoEnMeta,
        actualizadoEn.isAcceptableOrUnknown(
          data['actualizado_en']!,
          _actualizadoEnMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserProfile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserProfile(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nombre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre'],
      )!,
      edad: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}edad'],
      )!,
      sexo: $UserProfilesTable.$convertersexo.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}sexo'],
        )!,
      ),
      pesoKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}peso_kg'],
      )!,
      alturaCm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}altura_cm'],
      )!,
      nivelActividad: $UserProfilesTable.$converternivelActividad.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}nivel_actividad'],
        )!,
      ),
      objetivo: $UserProfilesTable.$converterobjetivo.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}objetivo'],
        )!,
      ),
      objetivoCalorias: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}objetivo_calorias'],
      )!,
      objetivoProteinasG: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}objetivo_proteinas_g'],
      )!,
      objetivoCarbohidratosG: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}objetivo_carbohidratos_g'],
      )!,
      objetivoGrasasG: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}objetivo_grasas_g'],
      )!,
      objetivoAguaMl: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}objetivo_agua_ml'],
      )!,
      objetivoSuenoHoras: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}objetivo_sueno_horas'],
      )!,
      unidadPeso: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unidad_peso'],
      )!,
      actualizadoEn: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}actualizado_en'],
      )!,
    );
  }

  @override
  $UserProfilesTable createAlias(String alias) {
    return $UserProfilesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Sexo, String, String> $convertersexo =
      const EnumNameConverter<Sexo>(Sexo.values);
  static JsonTypeConverter2<NivelActividad, String, String>
  $converternivelActividad = const EnumNameConverter<NivelActividad>(
    NivelActividad.values,
  );
  static JsonTypeConverter2<Objetivo, String, String> $converterobjetivo =
      const EnumNameConverter<Objetivo>(Objetivo.values);
}

class UserProfile extends DataClass implements Insertable<UserProfile> {
  final int id;
  final String nombre;
  final int edad;
  final Sexo sexo;
  final double pesoKg;
  final double alturaCm;
  final NivelActividad nivelActividad;
  final Objetivo objetivo;
  final int objetivoCalorias;
  final double objetivoProteinasG;
  final double objetivoCarbohidratosG;
  final double objetivoGrasasG;
  final int objetivoAguaMl;
  final double objetivoSuenoHoras;
  final String unidadPeso;
  final DateTime actualizadoEn;
  const UserProfile({
    required this.id,
    required this.nombre,
    required this.edad,
    required this.sexo,
    required this.pesoKg,
    required this.alturaCm,
    required this.nivelActividad,
    required this.objetivo,
    required this.objetivoCalorias,
    required this.objetivoProteinasG,
    required this.objetivoCarbohidratosG,
    required this.objetivoGrasasG,
    required this.objetivoAguaMl,
    required this.objetivoSuenoHoras,
    required this.unidadPeso,
    required this.actualizadoEn,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nombre'] = Variable<String>(nombre);
    map['edad'] = Variable<int>(edad);
    {
      map['sexo'] = Variable<String>(
        $UserProfilesTable.$convertersexo.toSql(sexo),
      );
    }
    map['peso_kg'] = Variable<double>(pesoKg);
    map['altura_cm'] = Variable<double>(alturaCm);
    {
      map['nivel_actividad'] = Variable<String>(
        $UserProfilesTable.$converternivelActividad.toSql(nivelActividad),
      );
    }
    {
      map['objetivo'] = Variable<String>(
        $UserProfilesTable.$converterobjetivo.toSql(objetivo),
      );
    }
    map['objetivo_calorias'] = Variable<int>(objetivoCalorias);
    map['objetivo_proteinas_g'] = Variable<double>(objetivoProteinasG);
    map['objetivo_carbohidratos_g'] = Variable<double>(objetivoCarbohidratosG);
    map['objetivo_grasas_g'] = Variable<double>(objetivoGrasasG);
    map['objetivo_agua_ml'] = Variable<int>(objetivoAguaMl);
    map['objetivo_sueno_horas'] = Variable<double>(objetivoSuenoHoras);
    map['unidad_peso'] = Variable<String>(unidadPeso);
    map['actualizado_en'] = Variable<DateTime>(actualizadoEn);
    return map;
  }

  UserProfilesCompanion toCompanion(bool nullToAbsent) {
    return UserProfilesCompanion(
      id: Value(id),
      nombre: Value(nombre),
      edad: Value(edad),
      sexo: Value(sexo),
      pesoKg: Value(pesoKg),
      alturaCm: Value(alturaCm),
      nivelActividad: Value(nivelActividad),
      objetivo: Value(objetivo),
      objetivoCalorias: Value(objetivoCalorias),
      objetivoProteinasG: Value(objetivoProteinasG),
      objetivoCarbohidratosG: Value(objetivoCarbohidratosG),
      objetivoGrasasG: Value(objetivoGrasasG),
      objetivoAguaMl: Value(objetivoAguaMl),
      objetivoSuenoHoras: Value(objetivoSuenoHoras),
      unidadPeso: Value(unidadPeso),
      actualizadoEn: Value(actualizadoEn),
    );
  }

  factory UserProfile.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserProfile(
      id: serializer.fromJson<int>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
      edad: serializer.fromJson<int>(json['edad']),
      sexo: $UserProfilesTable.$convertersexo.fromJson(
        serializer.fromJson<String>(json['sexo']),
      ),
      pesoKg: serializer.fromJson<double>(json['pesoKg']),
      alturaCm: serializer.fromJson<double>(json['alturaCm']),
      nivelActividad: $UserProfilesTable.$converternivelActividad.fromJson(
        serializer.fromJson<String>(json['nivelActividad']),
      ),
      objetivo: $UserProfilesTable.$converterobjetivo.fromJson(
        serializer.fromJson<String>(json['objetivo']),
      ),
      objetivoCalorias: serializer.fromJson<int>(json['objetivoCalorias']),
      objetivoProteinasG: serializer.fromJson<double>(
        json['objetivoProteinasG'],
      ),
      objetivoCarbohidratosG: serializer.fromJson<double>(
        json['objetivoCarbohidratosG'],
      ),
      objetivoGrasasG: serializer.fromJson<double>(json['objetivoGrasasG']),
      objetivoAguaMl: serializer.fromJson<int>(json['objetivoAguaMl']),
      objetivoSuenoHoras: serializer.fromJson<double>(
        json['objetivoSuenoHoras'],
      ),
      unidadPeso: serializer.fromJson<String>(json['unidadPeso']),
      actualizadoEn: serializer.fromJson<DateTime>(json['actualizadoEn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nombre': serializer.toJson<String>(nombre),
      'edad': serializer.toJson<int>(edad),
      'sexo': serializer.toJson<String>(
        $UserProfilesTable.$convertersexo.toJson(sexo),
      ),
      'pesoKg': serializer.toJson<double>(pesoKg),
      'alturaCm': serializer.toJson<double>(alturaCm),
      'nivelActividad': serializer.toJson<String>(
        $UserProfilesTable.$converternivelActividad.toJson(nivelActividad),
      ),
      'objetivo': serializer.toJson<String>(
        $UserProfilesTable.$converterobjetivo.toJson(objetivo),
      ),
      'objetivoCalorias': serializer.toJson<int>(objetivoCalorias),
      'objetivoProteinasG': serializer.toJson<double>(objetivoProteinasG),
      'objetivoCarbohidratosG': serializer.toJson<double>(
        objetivoCarbohidratosG,
      ),
      'objetivoGrasasG': serializer.toJson<double>(objetivoGrasasG),
      'objetivoAguaMl': serializer.toJson<int>(objetivoAguaMl),
      'objetivoSuenoHoras': serializer.toJson<double>(objetivoSuenoHoras),
      'unidadPeso': serializer.toJson<String>(unidadPeso),
      'actualizadoEn': serializer.toJson<DateTime>(actualizadoEn),
    };
  }

  UserProfile copyWith({
    int? id,
    String? nombre,
    int? edad,
    Sexo? sexo,
    double? pesoKg,
    double? alturaCm,
    NivelActividad? nivelActividad,
    Objetivo? objetivo,
    int? objetivoCalorias,
    double? objetivoProteinasG,
    double? objetivoCarbohidratosG,
    double? objetivoGrasasG,
    int? objetivoAguaMl,
    double? objetivoSuenoHoras,
    String? unidadPeso,
    DateTime? actualizadoEn,
  }) => UserProfile(
    id: id ?? this.id,
    nombre: nombre ?? this.nombre,
    edad: edad ?? this.edad,
    sexo: sexo ?? this.sexo,
    pesoKg: pesoKg ?? this.pesoKg,
    alturaCm: alturaCm ?? this.alturaCm,
    nivelActividad: nivelActividad ?? this.nivelActividad,
    objetivo: objetivo ?? this.objetivo,
    objetivoCalorias: objetivoCalorias ?? this.objetivoCalorias,
    objetivoProteinasG: objetivoProteinasG ?? this.objetivoProteinasG,
    objetivoCarbohidratosG:
        objetivoCarbohidratosG ?? this.objetivoCarbohidratosG,
    objetivoGrasasG: objetivoGrasasG ?? this.objetivoGrasasG,
    objetivoAguaMl: objetivoAguaMl ?? this.objetivoAguaMl,
    objetivoSuenoHoras: objetivoSuenoHoras ?? this.objetivoSuenoHoras,
    unidadPeso: unidadPeso ?? this.unidadPeso,
    actualizadoEn: actualizadoEn ?? this.actualizadoEn,
  );
  UserProfile copyWithCompanion(UserProfilesCompanion data) {
    return UserProfile(
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      edad: data.edad.present ? data.edad.value : this.edad,
      sexo: data.sexo.present ? data.sexo.value : this.sexo,
      pesoKg: data.pesoKg.present ? data.pesoKg.value : this.pesoKg,
      alturaCm: data.alturaCm.present ? data.alturaCm.value : this.alturaCm,
      nivelActividad: data.nivelActividad.present
          ? data.nivelActividad.value
          : this.nivelActividad,
      objetivo: data.objetivo.present ? data.objetivo.value : this.objetivo,
      objetivoCalorias: data.objetivoCalorias.present
          ? data.objetivoCalorias.value
          : this.objetivoCalorias,
      objetivoProteinasG: data.objetivoProteinasG.present
          ? data.objetivoProteinasG.value
          : this.objetivoProteinasG,
      objetivoCarbohidratosG: data.objetivoCarbohidratosG.present
          ? data.objetivoCarbohidratosG.value
          : this.objetivoCarbohidratosG,
      objetivoGrasasG: data.objetivoGrasasG.present
          ? data.objetivoGrasasG.value
          : this.objetivoGrasasG,
      objetivoAguaMl: data.objetivoAguaMl.present
          ? data.objetivoAguaMl.value
          : this.objetivoAguaMl,
      objetivoSuenoHoras: data.objetivoSuenoHoras.present
          ? data.objetivoSuenoHoras.value
          : this.objetivoSuenoHoras,
      unidadPeso: data.unidadPeso.present
          ? data.unidadPeso.value
          : this.unidadPeso,
      actualizadoEn: data.actualizadoEn.present
          ? data.actualizadoEn.value
          : this.actualizadoEn,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserProfile(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('edad: $edad, ')
          ..write('sexo: $sexo, ')
          ..write('pesoKg: $pesoKg, ')
          ..write('alturaCm: $alturaCm, ')
          ..write('nivelActividad: $nivelActividad, ')
          ..write('objetivo: $objetivo, ')
          ..write('objetivoCalorias: $objetivoCalorias, ')
          ..write('objetivoProteinasG: $objetivoProteinasG, ')
          ..write('objetivoCarbohidratosG: $objetivoCarbohidratosG, ')
          ..write('objetivoGrasasG: $objetivoGrasasG, ')
          ..write('objetivoAguaMl: $objetivoAguaMl, ')
          ..write('objetivoSuenoHoras: $objetivoSuenoHoras, ')
          ..write('unidadPeso: $unidadPeso, ')
          ..write('actualizadoEn: $actualizadoEn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    nombre,
    edad,
    sexo,
    pesoKg,
    alturaCm,
    nivelActividad,
    objetivo,
    objetivoCalorias,
    objetivoProteinasG,
    objetivoCarbohidratosG,
    objetivoGrasasG,
    objetivoAguaMl,
    objetivoSuenoHoras,
    unidadPeso,
    actualizadoEn,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserProfile &&
          other.id == this.id &&
          other.nombre == this.nombre &&
          other.edad == this.edad &&
          other.sexo == this.sexo &&
          other.pesoKg == this.pesoKg &&
          other.alturaCm == this.alturaCm &&
          other.nivelActividad == this.nivelActividad &&
          other.objetivo == this.objetivo &&
          other.objetivoCalorias == this.objetivoCalorias &&
          other.objetivoProteinasG == this.objetivoProteinasG &&
          other.objetivoCarbohidratosG == this.objetivoCarbohidratosG &&
          other.objetivoGrasasG == this.objetivoGrasasG &&
          other.objetivoAguaMl == this.objetivoAguaMl &&
          other.objetivoSuenoHoras == this.objetivoSuenoHoras &&
          other.unidadPeso == this.unidadPeso &&
          other.actualizadoEn == this.actualizadoEn);
}

class UserProfilesCompanion extends UpdateCompanion<UserProfile> {
  final Value<int> id;
  final Value<String> nombre;
  final Value<int> edad;
  final Value<Sexo> sexo;
  final Value<double> pesoKg;
  final Value<double> alturaCm;
  final Value<NivelActividad> nivelActividad;
  final Value<Objetivo> objetivo;
  final Value<int> objetivoCalorias;
  final Value<double> objetivoProteinasG;
  final Value<double> objetivoCarbohidratosG;
  final Value<double> objetivoGrasasG;
  final Value<int> objetivoAguaMl;
  final Value<double> objetivoSuenoHoras;
  final Value<String> unidadPeso;
  final Value<DateTime> actualizadoEn;
  const UserProfilesCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
    this.edad = const Value.absent(),
    this.sexo = const Value.absent(),
    this.pesoKg = const Value.absent(),
    this.alturaCm = const Value.absent(),
    this.nivelActividad = const Value.absent(),
    this.objetivo = const Value.absent(),
    this.objetivoCalorias = const Value.absent(),
    this.objetivoProteinasG = const Value.absent(),
    this.objetivoCarbohidratosG = const Value.absent(),
    this.objetivoGrasasG = const Value.absent(),
    this.objetivoAguaMl = const Value.absent(),
    this.objetivoSuenoHoras = const Value.absent(),
    this.unidadPeso = const Value.absent(),
    this.actualizadoEn = const Value.absent(),
  });
  UserProfilesCompanion.insert({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
    required int edad,
    required Sexo sexo,
    required double pesoKg,
    required double alturaCm,
    required NivelActividad nivelActividad,
    required Objetivo objetivo,
    required int objetivoCalorias,
    required double objetivoProteinasG,
    required double objetivoCarbohidratosG,
    required double objetivoGrasasG,
    required int objetivoAguaMl,
    this.objetivoSuenoHoras = const Value.absent(),
    this.unidadPeso = const Value.absent(),
    this.actualizadoEn = const Value.absent(),
  }) : edad = Value(edad),
       sexo = Value(sexo),
       pesoKg = Value(pesoKg),
       alturaCm = Value(alturaCm),
       nivelActividad = Value(nivelActividad),
       objetivo = Value(objetivo),
       objetivoCalorias = Value(objetivoCalorias),
       objetivoProteinasG = Value(objetivoProteinasG),
       objetivoCarbohidratosG = Value(objetivoCarbohidratosG),
       objetivoGrasasG = Value(objetivoGrasasG),
       objetivoAguaMl = Value(objetivoAguaMl);
  static Insertable<UserProfile> custom({
    Expression<int>? id,
    Expression<String>? nombre,
    Expression<int>? edad,
    Expression<String>? sexo,
    Expression<double>? pesoKg,
    Expression<double>? alturaCm,
    Expression<String>? nivelActividad,
    Expression<String>? objetivo,
    Expression<int>? objetivoCalorias,
    Expression<double>? objetivoProteinasG,
    Expression<double>? objetivoCarbohidratosG,
    Expression<double>? objetivoGrasasG,
    Expression<int>? objetivoAguaMl,
    Expression<double>? objetivoSuenoHoras,
    Expression<String>? unidadPeso,
    Expression<DateTime>? actualizadoEn,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
      if (edad != null) 'edad': edad,
      if (sexo != null) 'sexo': sexo,
      if (pesoKg != null) 'peso_kg': pesoKg,
      if (alturaCm != null) 'altura_cm': alturaCm,
      if (nivelActividad != null) 'nivel_actividad': nivelActividad,
      if (objetivo != null) 'objetivo': objetivo,
      if (objetivoCalorias != null) 'objetivo_calorias': objetivoCalorias,
      if (objetivoProteinasG != null)
        'objetivo_proteinas_g': objetivoProteinasG,
      if (objetivoCarbohidratosG != null)
        'objetivo_carbohidratos_g': objetivoCarbohidratosG,
      if (objetivoGrasasG != null) 'objetivo_grasas_g': objetivoGrasasG,
      if (objetivoAguaMl != null) 'objetivo_agua_ml': objetivoAguaMl,
      if (objetivoSuenoHoras != null)
        'objetivo_sueno_horas': objetivoSuenoHoras,
      if (unidadPeso != null) 'unidad_peso': unidadPeso,
      if (actualizadoEn != null) 'actualizado_en': actualizadoEn,
    });
  }

  UserProfilesCompanion copyWith({
    Value<int>? id,
    Value<String>? nombre,
    Value<int>? edad,
    Value<Sexo>? sexo,
    Value<double>? pesoKg,
    Value<double>? alturaCm,
    Value<NivelActividad>? nivelActividad,
    Value<Objetivo>? objetivo,
    Value<int>? objetivoCalorias,
    Value<double>? objetivoProteinasG,
    Value<double>? objetivoCarbohidratosG,
    Value<double>? objetivoGrasasG,
    Value<int>? objetivoAguaMl,
    Value<double>? objetivoSuenoHoras,
    Value<String>? unidadPeso,
    Value<DateTime>? actualizadoEn,
  }) {
    return UserProfilesCompanion(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      edad: edad ?? this.edad,
      sexo: sexo ?? this.sexo,
      pesoKg: pesoKg ?? this.pesoKg,
      alturaCm: alturaCm ?? this.alturaCm,
      nivelActividad: nivelActividad ?? this.nivelActividad,
      objetivo: objetivo ?? this.objetivo,
      objetivoCalorias: objetivoCalorias ?? this.objetivoCalorias,
      objetivoProteinasG: objetivoProteinasG ?? this.objetivoProteinasG,
      objetivoCarbohidratosG:
          objetivoCarbohidratosG ?? this.objetivoCarbohidratosG,
      objetivoGrasasG: objetivoGrasasG ?? this.objetivoGrasasG,
      objetivoAguaMl: objetivoAguaMl ?? this.objetivoAguaMl,
      objetivoSuenoHoras: objetivoSuenoHoras ?? this.objetivoSuenoHoras,
      unidadPeso: unidadPeso ?? this.unidadPeso,
      actualizadoEn: actualizadoEn ?? this.actualizadoEn,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (edad.present) {
      map['edad'] = Variable<int>(edad.value);
    }
    if (sexo.present) {
      map['sexo'] = Variable<String>(
        $UserProfilesTable.$convertersexo.toSql(sexo.value),
      );
    }
    if (pesoKg.present) {
      map['peso_kg'] = Variable<double>(pesoKg.value);
    }
    if (alturaCm.present) {
      map['altura_cm'] = Variable<double>(alturaCm.value);
    }
    if (nivelActividad.present) {
      map['nivel_actividad'] = Variable<String>(
        $UserProfilesTable.$converternivelActividad.toSql(nivelActividad.value),
      );
    }
    if (objetivo.present) {
      map['objetivo'] = Variable<String>(
        $UserProfilesTable.$converterobjetivo.toSql(objetivo.value),
      );
    }
    if (objetivoCalorias.present) {
      map['objetivo_calorias'] = Variable<int>(objetivoCalorias.value);
    }
    if (objetivoProteinasG.present) {
      map['objetivo_proteinas_g'] = Variable<double>(objetivoProteinasG.value);
    }
    if (objetivoCarbohidratosG.present) {
      map['objetivo_carbohidratos_g'] = Variable<double>(
        objetivoCarbohidratosG.value,
      );
    }
    if (objetivoGrasasG.present) {
      map['objetivo_grasas_g'] = Variable<double>(objetivoGrasasG.value);
    }
    if (objetivoAguaMl.present) {
      map['objetivo_agua_ml'] = Variable<int>(objetivoAguaMl.value);
    }
    if (objetivoSuenoHoras.present) {
      map['objetivo_sueno_horas'] = Variable<double>(objetivoSuenoHoras.value);
    }
    if (unidadPeso.present) {
      map['unidad_peso'] = Variable<String>(unidadPeso.value);
    }
    if (actualizadoEn.present) {
      map['actualizado_en'] = Variable<DateTime>(actualizadoEn.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserProfilesCompanion(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('edad: $edad, ')
          ..write('sexo: $sexo, ')
          ..write('pesoKg: $pesoKg, ')
          ..write('alturaCm: $alturaCm, ')
          ..write('nivelActividad: $nivelActividad, ')
          ..write('objetivo: $objetivo, ')
          ..write('objetivoCalorias: $objetivoCalorias, ')
          ..write('objetivoProteinasG: $objetivoProteinasG, ')
          ..write('objetivoCarbohidratosG: $objetivoCarbohidratosG, ')
          ..write('objetivoGrasasG: $objetivoGrasasG, ')
          ..write('objetivoAguaMl: $objetivoAguaMl, ')
          ..write('objetivoSuenoHoras: $objetivoSuenoHoras, ')
          ..write('unidadPeso: $unidadPeso, ')
          ..write('actualizadoEn: $actualizadoEn')
          ..write(')'))
        .toString();
  }
}

class $FoodEntriesTable extends FoodEntries
    with TableInfo<$FoodEntriesTable, FoodEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FoodEntriesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
    'nombre',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _caloriasMeta = const VerificationMeta(
    'calorias',
  );
  @override
  late final GeneratedColumn<double> calorias = GeneratedColumn<double>(
    'calorias',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _proteinasGMeta = const VerificationMeta(
    'proteinasG',
  );
  @override
  late final GeneratedColumn<double> proteinasG = GeneratedColumn<double>(
    'proteinas_g',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _carbohidratosGMeta = const VerificationMeta(
    'carbohidratosG',
  );
  @override
  late final GeneratedColumn<double> carbohidratosG = GeneratedColumn<double>(
    'carbohidratos_g',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _grasasGMeta = const VerificationMeta(
    'grasasG',
  );
  @override
  late final GeneratedColumn<double> grasasG = GeneratedColumn<double>(
    'grasas_g',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _porcionGramosMeta = const VerificationMeta(
    'porcionGramos',
  );
  @override
  late final GeneratedColumn<double> porcionGramos = GeneratedColumn<double>(
    'porcion_gramos',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<MomentoComida, String> momento =
      GeneratedColumn<String>(
        'momento',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<MomentoComida>($FoodEntriesTable.$convertermomento);
  @override
  late final GeneratedColumnWithTypeConverter<OrigenRegistro, String> origen =
      GeneratedColumn<String>(
        'origen',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<OrigenRegistro>($FoodEntriesTable.$converterorigen);
  static const VerificationMeta _barcodeMeta = const VerificationMeta(
    'barcode',
  );
  @override
  late final GeneratedColumn<String> barcode = GeneratedColumn<String>(
    'barcode',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fechaMeta = const VerificationMeta('fecha');
  @override
  late final GeneratedColumn<DateTime> fecha = GeneratedColumn<DateTime>(
    'fecha',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nombre,
    calorias,
    proteinasG,
    carbohidratosG,
    grasasG,
    porcionGramos,
    momento,
    origen,
    barcode,
    fecha,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'food_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<FoodEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nombre')) {
      context.handle(
        _nombreMeta,
        nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta),
      );
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('calorias')) {
      context.handle(
        _caloriasMeta,
        calorias.isAcceptableOrUnknown(data['calorias']!, _caloriasMeta),
      );
    } else if (isInserting) {
      context.missing(_caloriasMeta);
    }
    if (data.containsKey('proteinas_g')) {
      context.handle(
        _proteinasGMeta,
        proteinasG.isAcceptableOrUnknown(data['proteinas_g']!, _proteinasGMeta),
      );
    }
    if (data.containsKey('carbohidratos_g')) {
      context.handle(
        _carbohidratosGMeta,
        carbohidratosG.isAcceptableOrUnknown(
          data['carbohidratos_g']!,
          _carbohidratosGMeta,
        ),
      );
    }
    if (data.containsKey('grasas_g')) {
      context.handle(
        _grasasGMeta,
        grasasG.isAcceptableOrUnknown(data['grasas_g']!, _grasasGMeta),
      );
    }
    if (data.containsKey('porcion_gramos')) {
      context.handle(
        _porcionGramosMeta,
        porcionGramos.isAcceptableOrUnknown(
          data['porcion_gramos']!,
          _porcionGramosMeta,
        ),
      );
    }
    if (data.containsKey('barcode')) {
      context.handle(
        _barcodeMeta,
        barcode.isAcceptableOrUnknown(data['barcode']!, _barcodeMeta),
      );
    }
    if (data.containsKey('fecha')) {
      context.handle(
        _fechaMeta,
        fecha.isAcceptableOrUnknown(data['fecha']!, _fechaMeta),
      );
    } else if (isInserting) {
      context.missing(_fechaMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FoodEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FoodEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nombre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre'],
      )!,
      calorias: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}calorias'],
      )!,
      proteinasG: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}proteinas_g'],
      )!,
      carbohidratosG: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}carbohidratos_g'],
      )!,
      grasasG: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}grasas_g'],
      )!,
      porcionGramos: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}porcion_gramos'],
      ),
      momento: $FoodEntriesTable.$convertermomento.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}momento'],
        )!,
      ),
      origen: $FoodEntriesTable.$converterorigen.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}origen'],
        )!,
      ),
      barcode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}barcode'],
      ),
      fecha: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fecha'],
      )!,
    );
  }

  @override
  $FoodEntriesTable createAlias(String alias) {
    return $FoodEntriesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<MomentoComida, String, String> $convertermomento =
      const EnumNameConverter<MomentoComida>(MomentoComida.values);
  static JsonTypeConverter2<OrigenRegistro, String, String> $converterorigen =
      const EnumNameConverter<OrigenRegistro>(OrigenRegistro.values);
}

class FoodEntry extends DataClass implements Insertable<FoodEntry> {
  final int id;
  final String nombre;
  final double calorias;
  final double proteinasG;
  final double carbohidratosG;
  final double grasasG;
  final double? porcionGramos;
  final MomentoComida momento;
  final OrigenRegistro origen;
  final String? barcode;
  final DateTime fecha;
  const FoodEntry({
    required this.id,
    required this.nombre,
    required this.calorias,
    required this.proteinasG,
    required this.carbohidratosG,
    required this.grasasG,
    this.porcionGramos,
    required this.momento,
    required this.origen,
    this.barcode,
    required this.fecha,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nombre'] = Variable<String>(nombre);
    map['calorias'] = Variable<double>(calorias);
    map['proteinas_g'] = Variable<double>(proteinasG);
    map['carbohidratos_g'] = Variable<double>(carbohidratosG);
    map['grasas_g'] = Variable<double>(grasasG);
    if (!nullToAbsent || porcionGramos != null) {
      map['porcion_gramos'] = Variable<double>(porcionGramos);
    }
    {
      map['momento'] = Variable<String>(
        $FoodEntriesTable.$convertermomento.toSql(momento),
      );
    }
    {
      map['origen'] = Variable<String>(
        $FoodEntriesTable.$converterorigen.toSql(origen),
      );
    }
    if (!nullToAbsent || barcode != null) {
      map['barcode'] = Variable<String>(barcode);
    }
    map['fecha'] = Variable<DateTime>(fecha);
    return map;
  }

  FoodEntriesCompanion toCompanion(bool nullToAbsent) {
    return FoodEntriesCompanion(
      id: Value(id),
      nombre: Value(nombre),
      calorias: Value(calorias),
      proteinasG: Value(proteinasG),
      carbohidratosG: Value(carbohidratosG),
      grasasG: Value(grasasG),
      porcionGramos: porcionGramos == null && nullToAbsent
          ? const Value.absent()
          : Value(porcionGramos),
      momento: Value(momento),
      origen: Value(origen),
      barcode: barcode == null && nullToAbsent
          ? const Value.absent()
          : Value(barcode),
      fecha: Value(fecha),
    );
  }

  factory FoodEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FoodEntry(
      id: serializer.fromJson<int>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
      calorias: serializer.fromJson<double>(json['calorias']),
      proteinasG: serializer.fromJson<double>(json['proteinasG']),
      carbohidratosG: serializer.fromJson<double>(json['carbohidratosG']),
      grasasG: serializer.fromJson<double>(json['grasasG']),
      porcionGramos: serializer.fromJson<double?>(json['porcionGramos']),
      momento: $FoodEntriesTable.$convertermomento.fromJson(
        serializer.fromJson<String>(json['momento']),
      ),
      origen: $FoodEntriesTable.$converterorigen.fromJson(
        serializer.fromJson<String>(json['origen']),
      ),
      barcode: serializer.fromJson<String?>(json['barcode']),
      fecha: serializer.fromJson<DateTime>(json['fecha']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nombre': serializer.toJson<String>(nombre),
      'calorias': serializer.toJson<double>(calorias),
      'proteinasG': serializer.toJson<double>(proteinasG),
      'carbohidratosG': serializer.toJson<double>(carbohidratosG),
      'grasasG': serializer.toJson<double>(grasasG),
      'porcionGramos': serializer.toJson<double?>(porcionGramos),
      'momento': serializer.toJson<String>(
        $FoodEntriesTable.$convertermomento.toJson(momento),
      ),
      'origen': serializer.toJson<String>(
        $FoodEntriesTable.$converterorigen.toJson(origen),
      ),
      'barcode': serializer.toJson<String?>(barcode),
      'fecha': serializer.toJson<DateTime>(fecha),
    };
  }

  FoodEntry copyWith({
    int? id,
    String? nombre,
    double? calorias,
    double? proteinasG,
    double? carbohidratosG,
    double? grasasG,
    Value<double?> porcionGramos = const Value.absent(),
    MomentoComida? momento,
    OrigenRegistro? origen,
    Value<String?> barcode = const Value.absent(),
    DateTime? fecha,
  }) => FoodEntry(
    id: id ?? this.id,
    nombre: nombre ?? this.nombre,
    calorias: calorias ?? this.calorias,
    proteinasG: proteinasG ?? this.proteinasG,
    carbohidratosG: carbohidratosG ?? this.carbohidratosG,
    grasasG: grasasG ?? this.grasasG,
    porcionGramos: porcionGramos.present
        ? porcionGramos.value
        : this.porcionGramos,
    momento: momento ?? this.momento,
    origen: origen ?? this.origen,
    barcode: barcode.present ? barcode.value : this.barcode,
    fecha: fecha ?? this.fecha,
  );
  FoodEntry copyWithCompanion(FoodEntriesCompanion data) {
    return FoodEntry(
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      calorias: data.calorias.present ? data.calorias.value : this.calorias,
      proteinasG: data.proteinasG.present
          ? data.proteinasG.value
          : this.proteinasG,
      carbohidratosG: data.carbohidratosG.present
          ? data.carbohidratosG.value
          : this.carbohidratosG,
      grasasG: data.grasasG.present ? data.grasasG.value : this.grasasG,
      porcionGramos: data.porcionGramos.present
          ? data.porcionGramos.value
          : this.porcionGramos,
      momento: data.momento.present ? data.momento.value : this.momento,
      origen: data.origen.present ? data.origen.value : this.origen,
      barcode: data.barcode.present ? data.barcode.value : this.barcode,
      fecha: data.fecha.present ? data.fecha.value : this.fecha,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FoodEntry(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('calorias: $calorias, ')
          ..write('proteinasG: $proteinasG, ')
          ..write('carbohidratosG: $carbohidratosG, ')
          ..write('grasasG: $grasasG, ')
          ..write('porcionGramos: $porcionGramos, ')
          ..write('momento: $momento, ')
          ..write('origen: $origen, ')
          ..write('barcode: $barcode, ')
          ..write('fecha: $fecha')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    nombre,
    calorias,
    proteinasG,
    carbohidratosG,
    grasasG,
    porcionGramos,
    momento,
    origen,
    barcode,
    fecha,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FoodEntry &&
          other.id == this.id &&
          other.nombre == this.nombre &&
          other.calorias == this.calorias &&
          other.proteinasG == this.proteinasG &&
          other.carbohidratosG == this.carbohidratosG &&
          other.grasasG == this.grasasG &&
          other.porcionGramos == this.porcionGramos &&
          other.momento == this.momento &&
          other.origen == this.origen &&
          other.barcode == this.barcode &&
          other.fecha == this.fecha);
}

class FoodEntriesCompanion extends UpdateCompanion<FoodEntry> {
  final Value<int> id;
  final Value<String> nombre;
  final Value<double> calorias;
  final Value<double> proteinasG;
  final Value<double> carbohidratosG;
  final Value<double> grasasG;
  final Value<double?> porcionGramos;
  final Value<MomentoComida> momento;
  final Value<OrigenRegistro> origen;
  final Value<String?> barcode;
  final Value<DateTime> fecha;
  const FoodEntriesCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
    this.calorias = const Value.absent(),
    this.proteinasG = const Value.absent(),
    this.carbohidratosG = const Value.absent(),
    this.grasasG = const Value.absent(),
    this.porcionGramos = const Value.absent(),
    this.momento = const Value.absent(),
    this.origen = const Value.absent(),
    this.barcode = const Value.absent(),
    this.fecha = const Value.absent(),
  });
  FoodEntriesCompanion.insert({
    this.id = const Value.absent(),
    required String nombre,
    required double calorias,
    this.proteinasG = const Value.absent(),
    this.carbohidratosG = const Value.absent(),
    this.grasasG = const Value.absent(),
    this.porcionGramos = const Value.absent(),
    required MomentoComida momento,
    required OrigenRegistro origen,
    this.barcode = const Value.absent(),
    required DateTime fecha,
  }) : nombre = Value(nombre),
       calorias = Value(calorias),
       momento = Value(momento),
       origen = Value(origen),
       fecha = Value(fecha);
  static Insertable<FoodEntry> custom({
    Expression<int>? id,
    Expression<String>? nombre,
    Expression<double>? calorias,
    Expression<double>? proteinasG,
    Expression<double>? carbohidratosG,
    Expression<double>? grasasG,
    Expression<double>? porcionGramos,
    Expression<String>? momento,
    Expression<String>? origen,
    Expression<String>? barcode,
    Expression<DateTime>? fecha,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
      if (calorias != null) 'calorias': calorias,
      if (proteinasG != null) 'proteinas_g': proteinasG,
      if (carbohidratosG != null) 'carbohidratos_g': carbohidratosG,
      if (grasasG != null) 'grasas_g': grasasG,
      if (porcionGramos != null) 'porcion_gramos': porcionGramos,
      if (momento != null) 'momento': momento,
      if (origen != null) 'origen': origen,
      if (barcode != null) 'barcode': barcode,
      if (fecha != null) 'fecha': fecha,
    });
  }

  FoodEntriesCompanion copyWith({
    Value<int>? id,
    Value<String>? nombre,
    Value<double>? calorias,
    Value<double>? proteinasG,
    Value<double>? carbohidratosG,
    Value<double>? grasasG,
    Value<double?>? porcionGramos,
    Value<MomentoComida>? momento,
    Value<OrigenRegistro>? origen,
    Value<String?>? barcode,
    Value<DateTime>? fecha,
  }) {
    return FoodEntriesCompanion(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      calorias: calorias ?? this.calorias,
      proteinasG: proteinasG ?? this.proteinasG,
      carbohidratosG: carbohidratosG ?? this.carbohidratosG,
      grasasG: grasasG ?? this.grasasG,
      porcionGramos: porcionGramos ?? this.porcionGramos,
      momento: momento ?? this.momento,
      origen: origen ?? this.origen,
      barcode: barcode ?? this.barcode,
      fecha: fecha ?? this.fecha,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (calorias.present) {
      map['calorias'] = Variable<double>(calorias.value);
    }
    if (proteinasG.present) {
      map['proteinas_g'] = Variable<double>(proteinasG.value);
    }
    if (carbohidratosG.present) {
      map['carbohidratos_g'] = Variable<double>(carbohidratosG.value);
    }
    if (grasasG.present) {
      map['grasas_g'] = Variable<double>(grasasG.value);
    }
    if (porcionGramos.present) {
      map['porcion_gramos'] = Variable<double>(porcionGramos.value);
    }
    if (momento.present) {
      map['momento'] = Variable<String>(
        $FoodEntriesTable.$convertermomento.toSql(momento.value),
      );
    }
    if (origen.present) {
      map['origen'] = Variable<String>(
        $FoodEntriesTable.$converterorigen.toSql(origen.value),
      );
    }
    if (barcode.present) {
      map['barcode'] = Variable<String>(barcode.value);
    }
    if (fecha.present) {
      map['fecha'] = Variable<DateTime>(fecha.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FoodEntriesCompanion(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('calorias: $calorias, ')
          ..write('proteinasG: $proteinasG, ')
          ..write('carbohidratosG: $carbohidratosG, ')
          ..write('grasasG: $grasasG, ')
          ..write('porcionGramos: $porcionGramos, ')
          ..write('momento: $momento, ')
          ..write('origen: $origen, ')
          ..write('barcode: $barcode, ')
          ..write('fecha: $fecha')
          ..write(')'))
        .toString();
  }
}

class $ExerciseEntriesTable extends ExerciseEntries
    with TableInfo<$ExerciseEntriesTable, ExerciseEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExerciseEntriesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _tipoMeta = const VerificationMeta('tipo');
  @override
  late final GeneratedColumn<String> tipo = GeneratedColumn<String>(
    'tipo',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _duracionMinMeta = const VerificationMeta(
    'duracionMin',
  );
  @override
  late final GeneratedColumn<int> duracionMin = GeneratedColumn<int>(
    'duracion_min',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _caloriasQuemadasMeta = const VerificationMeta(
    'caloriasQuemadas',
  );
  @override
  late final GeneratedColumn<double> caloriasQuemadas = GeneratedColumn<double>(
    'calorias_quemadas',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notasMeta = const VerificationMeta('notas');
  @override
  late final GeneratedColumn<String> notas = GeneratedColumn<String>(
    'notas',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fechaMeta = const VerificationMeta('fecha');
  @override
  late final GeneratedColumn<DateTime> fecha = GeneratedColumn<DateTime>(
    'fecha',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tipo,
    duracionMin,
    caloriasQuemadas,
    notas,
    fecha,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exercise_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExerciseEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('tipo')) {
      context.handle(
        _tipoMeta,
        tipo.isAcceptableOrUnknown(data['tipo']!, _tipoMeta),
      );
    } else if (isInserting) {
      context.missing(_tipoMeta);
    }
    if (data.containsKey('duracion_min')) {
      context.handle(
        _duracionMinMeta,
        duracionMin.isAcceptableOrUnknown(
          data['duracion_min']!,
          _duracionMinMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_duracionMinMeta);
    }
    if (data.containsKey('calorias_quemadas')) {
      context.handle(
        _caloriasQuemadasMeta,
        caloriasQuemadas.isAcceptableOrUnknown(
          data['calorias_quemadas']!,
          _caloriasQuemadasMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_caloriasQuemadasMeta);
    }
    if (data.containsKey('notas')) {
      context.handle(
        _notasMeta,
        notas.isAcceptableOrUnknown(data['notas']!, _notasMeta),
      );
    }
    if (data.containsKey('fecha')) {
      context.handle(
        _fechaMeta,
        fecha.isAcceptableOrUnknown(data['fecha']!, _fechaMeta),
      );
    } else if (isInserting) {
      context.missing(_fechaMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExerciseEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExerciseEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      tipo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tipo'],
      )!,
      duracionMin: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duracion_min'],
      )!,
      caloriasQuemadas: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}calorias_quemadas'],
      )!,
      notas: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notas'],
      ),
      fecha: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fecha'],
      )!,
    );
  }

  @override
  $ExerciseEntriesTable createAlias(String alias) {
    return $ExerciseEntriesTable(attachedDatabase, alias);
  }
}

class ExerciseEntry extends DataClass implements Insertable<ExerciseEntry> {
  final int id;
  final String tipo;
  final int duracionMin;
  final double caloriasQuemadas;
  final String? notas;
  final DateTime fecha;
  const ExerciseEntry({
    required this.id,
    required this.tipo,
    required this.duracionMin,
    required this.caloriasQuemadas,
    this.notas,
    required this.fecha,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['tipo'] = Variable<String>(tipo);
    map['duracion_min'] = Variable<int>(duracionMin);
    map['calorias_quemadas'] = Variable<double>(caloriasQuemadas);
    if (!nullToAbsent || notas != null) {
      map['notas'] = Variable<String>(notas);
    }
    map['fecha'] = Variable<DateTime>(fecha);
    return map;
  }

  ExerciseEntriesCompanion toCompanion(bool nullToAbsent) {
    return ExerciseEntriesCompanion(
      id: Value(id),
      tipo: Value(tipo),
      duracionMin: Value(duracionMin),
      caloriasQuemadas: Value(caloriasQuemadas),
      notas: notas == null && nullToAbsent
          ? const Value.absent()
          : Value(notas),
      fecha: Value(fecha),
    );
  }

  factory ExerciseEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExerciseEntry(
      id: serializer.fromJson<int>(json['id']),
      tipo: serializer.fromJson<String>(json['tipo']),
      duracionMin: serializer.fromJson<int>(json['duracionMin']),
      caloriasQuemadas: serializer.fromJson<double>(json['caloriasQuemadas']),
      notas: serializer.fromJson<String?>(json['notas']),
      fecha: serializer.fromJson<DateTime>(json['fecha']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tipo': serializer.toJson<String>(tipo),
      'duracionMin': serializer.toJson<int>(duracionMin),
      'caloriasQuemadas': serializer.toJson<double>(caloriasQuemadas),
      'notas': serializer.toJson<String?>(notas),
      'fecha': serializer.toJson<DateTime>(fecha),
    };
  }

  ExerciseEntry copyWith({
    int? id,
    String? tipo,
    int? duracionMin,
    double? caloriasQuemadas,
    Value<String?> notas = const Value.absent(),
    DateTime? fecha,
  }) => ExerciseEntry(
    id: id ?? this.id,
    tipo: tipo ?? this.tipo,
    duracionMin: duracionMin ?? this.duracionMin,
    caloriasQuemadas: caloriasQuemadas ?? this.caloriasQuemadas,
    notas: notas.present ? notas.value : this.notas,
    fecha: fecha ?? this.fecha,
  );
  ExerciseEntry copyWithCompanion(ExerciseEntriesCompanion data) {
    return ExerciseEntry(
      id: data.id.present ? data.id.value : this.id,
      tipo: data.tipo.present ? data.tipo.value : this.tipo,
      duracionMin: data.duracionMin.present
          ? data.duracionMin.value
          : this.duracionMin,
      caloriasQuemadas: data.caloriasQuemadas.present
          ? data.caloriasQuemadas.value
          : this.caloriasQuemadas,
      notas: data.notas.present ? data.notas.value : this.notas,
      fecha: data.fecha.present ? data.fecha.value : this.fecha,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseEntry(')
          ..write('id: $id, ')
          ..write('tipo: $tipo, ')
          ..write('duracionMin: $duracionMin, ')
          ..write('caloriasQuemadas: $caloriasQuemadas, ')
          ..write('notas: $notas, ')
          ..write('fecha: $fecha')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, tipo, duracionMin, caloriasQuemadas, notas, fecha);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExerciseEntry &&
          other.id == this.id &&
          other.tipo == this.tipo &&
          other.duracionMin == this.duracionMin &&
          other.caloriasQuemadas == this.caloriasQuemadas &&
          other.notas == this.notas &&
          other.fecha == this.fecha);
}

class ExerciseEntriesCompanion extends UpdateCompanion<ExerciseEntry> {
  final Value<int> id;
  final Value<String> tipo;
  final Value<int> duracionMin;
  final Value<double> caloriasQuemadas;
  final Value<String?> notas;
  final Value<DateTime> fecha;
  const ExerciseEntriesCompanion({
    this.id = const Value.absent(),
    this.tipo = const Value.absent(),
    this.duracionMin = const Value.absent(),
    this.caloriasQuemadas = const Value.absent(),
    this.notas = const Value.absent(),
    this.fecha = const Value.absent(),
  });
  ExerciseEntriesCompanion.insert({
    this.id = const Value.absent(),
    required String tipo,
    required int duracionMin,
    required double caloriasQuemadas,
    this.notas = const Value.absent(),
    required DateTime fecha,
  }) : tipo = Value(tipo),
       duracionMin = Value(duracionMin),
       caloriasQuemadas = Value(caloriasQuemadas),
       fecha = Value(fecha);
  static Insertable<ExerciseEntry> custom({
    Expression<int>? id,
    Expression<String>? tipo,
    Expression<int>? duracionMin,
    Expression<double>? caloriasQuemadas,
    Expression<String>? notas,
    Expression<DateTime>? fecha,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tipo != null) 'tipo': tipo,
      if (duracionMin != null) 'duracion_min': duracionMin,
      if (caloriasQuemadas != null) 'calorias_quemadas': caloriasQuemadas,
      if (notas != null) 'notas': notas,
      if (fecha != null) 'fecha': fecha,
    });
  }

  ExerciseEntriesCompanion copyWith({
    Value<int>? id,
    Value<String>? tipo,
    Value<int>? duracionMin,
    Value<double>? caloriasQuemadas,
    Value<String?>? notas,
    Value<DateTime>? fecha,
  }) {
    return ExerciseEntriesCompanion(
      id: id ?? this.id,
      tipo: tipo ?? this.tipo,
      duracionMin: duracionMin ?? this.duracionMin,
      caloriasQuemadas: caloriasQuemadas ?? this.caloriasQuemadas,
      notas: notas ?? this.notas,
      fecha: fecha ?? this.fecha,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tipo.present) {
      map['tipo'] = Variable<String>(tipo.value);
    }
    if (duracionMin.present) {
      map['duracion_min'] = Variable<int>(duracionMin.value);
    }
    if (caloriasQuemadas.present) {
      map['calorias_quemadas'] = Variable<double>(caloriasQuemadas.value);
    }
    if (notas.present) {
      map['notas'] = Variable<String>(notas.value);
    }
    if (fecha.present) {
      map['fecha'] = Variable<DateTime>(fecha.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseEntriesCompanion(')
          ..write('id: $id, ')
          ..write('tipo: $tipo, ')
          ..write('duracionMin: $duracionMin, ')
          ..write('caloriasQuemadas: $caloriasQuemadas, ')
          ..write('notas: $notas, ')
          ..write('fecha: $fecha')
          ..write(')'))
        .toString();
  }
}

class $SleepEntriesTable extends SleepEntries
    with TableInfo<$SleepEntriesTable, SleepEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SleepEntriesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _fechaMeta = const VerificationMeta('fecha');
  @override
  late final GeneratedColumn<DateTime> fecha = GeneratedColumn<DateTime>(
    'fecha',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _horasMeta = const VerificationMeta('horas');
  @override
  late final GeneratedColumn<double> horas = GeneratedColumn<double>(
    'horas',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _horaAcostarseMeta = const VerificationMeta(
    'horaAcostarse',
  );
  @override
  late final GeneratedColumn<DateTime> horaAcostarse =
      GeneratedColumn<DateTime>(
        'hora_acostarse',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _horaLevantarseMeta = const VerificationMeta(
    'horaLevantarse',
  );
  @override
  late final GeneratedColumn<DateTime> horaLevantarse =
      GeneratedColumn<DateTime>(
        'hora_levantarse',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    fecha,
    horas,
    horaAcostarse,
    horaLevantarse,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sleep_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<SleepEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('fecha')) {
      context.handle(
        _fechaMeta,
        fecha.isAcceptableOrUnknown(data['fecha']!, _fechaMeta),
      );
    } else if (isInserting) {
      context.missing(_fechaMeta);
    }
    if (data.containsKey('horas')) {
      context.handle(
        _horasMeta,
        horas.isAcceptableOrUnknown(data['horas']!, _horasMeta),
      );
    } else if (isInserting) {
      context.missing(_horasMeta);
    }
    if (data.containsKey('hora_acostarse')) {
      context.handle(
        _horaAcostarseMeta,
        horaAcostarse.isAcceptableOrUnknown(
          data['hora_acostarse']!,
          _horaAcostarseMeta,
        ),
      );
    }
    if (data.containsKey('hora_levantarse')) {
      context.handle(
        _horaLevantarseMeta,
        horaLevantarse.isAcceptableOrUnknown(
          data['hora_levantarse']!,
          _horaLevantarseMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SleepEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SleepEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      fecha: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fecha'],
      )!,
      horas: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}horas'],
      )!,
      horaAcostarse: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}hora_acostarse'],
      ),
      horaLevantarse: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}hora_levantarse'],
      ),
    );
  }

  @override
  $SleepEntriesTable createAlias(String alias) {
    return $SleepEntriesTable(attachedDatabase, alias);
  }
}

class SleepEntry extends DataClass implements Insertable<SleepEntry> {
  final int id;
  final DateTime fecha;
  final double horas;
  final DateTime? horaAcostarse;
  final DateTime? horaLevantarse;
  const SleepEntry({
    required this.id,
    required this.fecha,
    required this.horas,
    this.horaAcostarse,
    this.horaLevantarse,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['fecha'] = Variable<DateTime>(fecha);
    map['horas'] = Variable<double>(horas);
    if (!nullToAbsent || horaAcostarse != null) {
      map['hora_acostarse'] = Variable<DateTime>(horaAcostarse);
    }
    if (!nullToAbsent || horaLevantarse != null) {
      map['hora_levantarse'] = Variable<DateTime>(horaLevantarse);
    }
    return map;
  }

  SleepEntriesCompanion toCompanion(bool nullToAbsent) {
    return SleepEntriesCompanion(
      id: Value(id),
      fecha: Value(fecha),
      horas: Value(horas),
      horaAcostarse: horaAcostarse == null && nullToAbsent
          ? const Value.absent()
          : Value(horaAcostarse),
      horaLevantarse: horaLevantarse == null && nullToAbsent
          ? const Value.absent()
          : Value(horaLevantarse),
    );
  }

  factory SleepEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SleepEntry(
      id: serializer.fromJson<int>(json['id']),
      fecha: serializer.fromJson<DateTime>(json['fecha']),
      horas: serializer.fromJson<double>(json['horas']),
      horaAcostarse: serializer.fromJson<DateTime?>(json['horaAcostarse']),
      horaLevantarse: serializer.fromJson<DateTime?>(json['horaLevantarse']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'fecha': serializer.toJson<DateTime>(fecha),
      'horas': serializer.toJson<double>(horas),
      'horaAcostarse': serializer.toJson<DateTime?>(horaAcostarse),
      'horaLevantarse': serializer.toJson<DateTime?>(horaLevantarse),
    };
  }

  SleepEntry copyWith({
    int? id,
    DateTime? fecha,
    double? horas,
    Value<DateTime?> horaAcostarse = const Value.absent(),
    Value<DateTime?> horaLevantarse = const Value.absent(),
  }) => SleepEntry(
    id: id ?? this.id,
    fecha: fecha ?? this.fecha,
    horas: horas ?? this.horas,
    horaAcostarse: horaAcostarse.present
        ? horaAcostarse.value
        : this.horaAcostarse,
    horaLevantarse: horaLevantarse.present
        ? horaLevantarse.value
        : this.horaLevantarse,
  );
  SleepEntry copyWithCompanion(SleepEntriesCompanion data) {
    return SleepEntry(
      id: data.id.present ? data.id.value : this.id,
      fecha: data.fecha.present ? data.fecha.value : this.fecha,
      horas: data.horas.present ? data.horas.value : this.horas,
      horaAcostarse: data.horaAcostarse.present
          ? data.horaAcostarse.value
          : this.horaAcostarse,
      horaLevantarse: data.horaLevantarse.present
          ? data.horaLevantarse.value
          : this.horaLevantarse,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SleepEntry(')
          ..write('id: $id, ')
          ..write('fecha: $fecha, ')
          ..write('horas: $horas, ')
          ..write('horaAcostarse: $horaAcostarse, ')
          ..write('horaLevantarse: $horaLevantarse')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, fecha, horas, horaAcostarse, horaLevantarse);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SleepEntry &&
          other.id == this.id &&
          other.fecha == this.fecha &&
          other.horas == this.horas &&
          other.horaAcostarse == this.horaAcostarse &&
          other.horaLevantarse == this.horaLevantarse);
}

class SleepEntriesCompanion extends UpdateCompanion<SleepEntry> {
  final Value<int> id;
  final Value<DateTime> fecha;
  final Value<double> horas;
  final Value<DateTime?> horaAcostarse;
  final Value<DateTime?> horaLevantarse;
  const SleepEntriesCompanion({
    this.id = const Value.absent(),
    this.fecha = const Value.absent(),
    this.horas = const Value.absent(),
    this.horaAcostarse = const Value.absent(),
    this.horaLevantarse = const Value.absent(),
  });
  SleepEntriesCompanion.insert({
    this.id = const Value.absent(),
    required DateTime fecha,
    required double horas,
    this.horaAcostarse = const Value.absent(),
    this.horaLevantarse = const Value.absent(),
  }) : fecha = Value(fecha),
       horas = Value(horas);
  static Insertable<SleepEntry> custom({
    Expression<int>? id,
    Expression<DateTime>? fecha,
    Expression<double>? horas,
    Expression<DateTime>? horaAcostarse,
    Expression<DateTime>? horaLevantarse,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fecha != null) 'fecha': fecha,
      if (horas != null) 'horas': horas,
      if (horaAcostarse != null) 'hora_acostarse': horaAcostarse,
      if (horaLevantarse != null) 'hora_levantarse': horaLevantarse,
    });
  }

  SleepEntriesCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? fecha,
    Value<double>? horas,
    Value<DateTime?>? horaAcostarse,
    Value<DateTime?>? horaLevantarse,
  }) {
    return SleepEntriesCompanion(
      id: id ?? this.id,
      fecha: fecha ?? this.fecha,
      horas: horas ?? this.horas,
      horaAcostarse: horaAcostarse ?? this.horaAcostarse,
      horaLevantarse: horaLevantarse ?? this.horaLevantarse,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (fecha.present) {
      map['fecha'] = Variable<DateTime>(fecha.value);
    }
    if (horas.present) {
      map['horas'] = Variable<double>(horas.value);
    }
    if (horaAcostarse.present) {
      map['hora_acostarse'] = Variable<DateTime>(horaAcostarse.value);
    }
    if (horaLevantarse.present) {
      map['hora_levantarse'] = Variable<DateTime>(horaLevantarse.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SleepEntriesCompanion(')
          ..write('id: $id, ')
          ..write('fecha: $fecha, ')
          ..write('horas: $horas, ')
          ..write('horaAcostarse: $horaAcostarse, ')
          ..write('horaLevantarse: $horaLevantarse')
          ..write(')'))
        .toString();
  }
}

class $WaterEntriesTable extends WaterEntries
    with TableInfo<$WaterEntriesTable, WaterEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WaterEntriesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _fechaMeta = const VerificationMeta('fecha');
  @override
  late final GeneratedColumn<DateTime> fecha = GeneratedColumn<DateTime>(
    'fecha',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mlMeta = const VerificationMeta('ml');
  @override
  late final GeneratedColumn<int> ml = GeneratedColumn<int>(
    'ml',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(250),
  );
  @override
  List<GeneratedColumn> get $columns => [id, fecha, ml];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'water_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<WaterEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('fecha')) {
      context.handle(
        _fechaMeta,
        fecha.isAcceptableOrUnknown(data['fecha']!, _fechaMeta),
      );
    } else if (isInserting) {
      context.missing(_fechaMeta);
    }
    if (data.containsKey('ml')) {
      context.handle(_mlMeta, ml.isAcceptableOrUnknown(data['ml']!, _mlMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WaterEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WaterEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      fecha: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fecha'],
      )!,
      ml: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ml'],
      )!,
    );
  }

  @override
  $WaterEntriesTable createAlias(String alias) {
    return $WaterEntriesTable(attachedDatabase, alias);
  }
}

class WaterEntry extends DataClass implements Insertable<WaterEntry> {
  final int id;
  final DateTime fecha;
  final int ml;
  const WaterEntry({required this.id, required this.fecha, required this.ml});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['fecha'] = Variable<DateTime>(fecha);
    map['ml'] = Variable<int>(ml);
    return map;
  }

  WaterEntriesCompanion toCompanion(bool nullToAbsent) {
    return WaterEntriesCompanion(
      id: Value(id),
      fecha: Value(fecha),
      ml: Value(ml),
    );
  }

  factory WaterEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WaterEntry(
      id: serializer.fromJson<int>(json['id']),
      fecha: serializer.fromJson<DateTime>(json['fecha']),
      ml: serializer.fromJson<int>(json['ml']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'fecha': serializer.toJson<DateTime>(fecha),
      'ml': serializer.toJson<int>(ml),
    };
  }

  WaterEntry copyWith({int? id, DateTime? fecha, int? ml}) => WaterEntry(
    id: id ?? this.id,
    fecha: fecha ?? this.fecha,
    ml: ml ?? this.ml,
  );
  WaterEntry copyWithCompanion(WaterEntriesCompanion data) {
    return WaterEntry(
      id: data.id.present ? data.id.value : this.id,
      fecha: data.fecha.present ? data.fecha.value : this.fecha,
      ml: data.ml.present ? data.ml.value : this.ml,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WaterEntry(')
          ..write('id: $id, ')
          ..write('fecha: $fecha, ')
          ..write('ml: $ml')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, fecha, ml);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WaterEntry &&
          other.id == this.id &&
          other.fecha == this.fecha &&
          other.ml == this.ml);
}

class WaterEntriesCompanion extends UpdateCompanion<WaterEntry> {
  final Value<int> id;
  final Value<DateTime> fecha;
  final Value<int> ml;
  const WaterEntriesCompanion({
    this.id = const Value.absent(),
    this.fecha = const Value.absent(),
    this.ml = const Value.absent(),
  });
  WaterEntriesCompanion.insert({
    this.id = const Value.absent(),
    required DateTime fecha,
    this.ml = const Value.absent(),
  }) : fecha = Value(fecha);
  static Insertable<WaterEntry> custom({
    Expression<int>? id,
    Expression<DateTime>? fecha,
    Expression<int>? ml,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fecha != null) 'fecha': fecha,
      if (ml != null) 'ml': ml,
    });
  }

  WaterEntriesCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? fecha,
    Value<int>? ml,
  }) {
    return WaterEntriesCompanion(
      id: id ?? this.id,
      fecha: fecha ?? this.fecha,
      ml: ml ?? this.ml,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (fecha.present) {
      map['fecha'] = Variable<DateTime>(fecha.value);
    }
    if (ml.present) {
      map['ml'] = Variable<int>(ml.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WaterEntriesCompanion(')
          ..write('id: $id, ')
          ..write('fecha: $fecha, ')
          ..write('ml: $ml')
          ..write(')'))
        .toString();
  }
}

class $WeightEntriesTable extends WeightEntries
    with TableInfo<$WeightEntriesTable, WeightEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WeightEntriesTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _fechaMeta = const VerificationMeta('fecha');
  @override
  late final GeneratedColumn<DateTime> fecha = GeneratedColumn<DateTime>(
    'fecha',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pesoKgMeta = const VerificationMeta('pesoKg');
  @override
  late final GeneratedColumn<double> pesoKg = GeneratedColumn<double>(
    'peso_kg',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, fecha, pesoKg];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'weight_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<WeightEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('fecha')) {
      context.handle(
        _fechaMeta,
        fecha.isAcceptableOrUnknown(data['fecha']!, _fechaMeta),
      );
    } else if (isInserting) {
      context.missing(_fechaMeta);
    }
    if (data.containsKey('peso_kg')) {
      context.handle(
        _pesoKgMeta,
        pesoKg.isAcceptableOrUnknown(data['peso_kg']!, _pesoKgMeta),
      );
    } else if (isInserting) {
      context.missing(_pesoKgMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WeightEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WeightEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      fecha: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fecha'],
      )!,
      pesoKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}peso_kg'],
      )!,
    );
  }

  @override
  $WeightEntriesTable createAlias(String alias) {
    return $WeightEntriesTable(attachedDatabase, alias);
  }
}

class WeightEntry extends DataClass implements Insertable<WeightEntry> {
  final int id;
  final DateTime fecha;
  final double pesoKg;
  const WeightEntry({
    required this.id,
    required this.fecha,
    required this.pesoKg,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['fecha'] = Variable<DateTime>(fecha);
    map['peso_kg'] = Variable<double>(pesoKg);
    return map;
  }

  WeightEntriesCompanion toCompanion(bool nullToAbsent) {
    return WeightEntriesCompanion(
      id: Value(id),
      fecha: Value(fecha),
      pesoKg: Value(pesoKg),
    );
  }

  factory WeightEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WeightEntry(
      id: serializer.fromJson<int>(json['id']),
      fecha: serializer.fromJson<DateTime>(json['fecha']),
      pesoKg: serializer.fromJson<double>(json['pesoKg']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'fecha': serializer.toJson<DateTime>(fecha),
      'pesoKg': serializer.toJson<double>(pesoKg),
    };
  }

  WeightEntry copyWith({int? id, DateTime? fecha, double? pesoKg}) =>
      WeightEntry(
        id: id ?? this.id,
        fecha: fecha ?? this.fecha,
        pesoKg: pesoKg ?? this.pesoKg,
      );
  WeightEntry copyWithCompanion(WeightEntriesCompanion data) {
    return WeightEntry(
      id: data.id.present ? data.id.value : this.id,
      fecha: data.fecha.present ? data.fecha.value : this.fecha,
      pesoKg: data.pesoKg.present ? data.pesoKg.value : this.pesoKg,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WeightEntry(')
          ..write('id: $id, ')
          ..write('fecha: $fecha, ')
          ..write('pesoKg: $pesoKg')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, fecha, pesoKg);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WeightEntry &&
          other.id == this.id &&
          other.fecha == this.fecha &&
          other.pesoKg == this.pesoKg);
}

class WeightEntriesCompanion extends UpdateCompanion<WeightEntry> {
  final Value<int> id;
  final Value<DateTime> fecha;
  final Value<double> pesoKg;
  const WeightEntriesCompanion({
    this.id = const Value.absent(),
    this.fecha = const Value.absent(),
    this.pesoKg = const Value.absent(),
  });
  WeightEntriesCompanion.insert({
    this.id = const Value.absent(),
    required DateTime fecha,
    required double pesoKg,
  }) : fecha = Value(fecha),
       pesoKg = Value(pesoKg);
  static Insertable<WeightEntry> custom({
    Expression<int>? id,
    Expression<DateTime>? fecha,
    Expression<double>? pesoKg,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fecha != null) 'fecha': fecha,
      if (pesoKg != null) 'peso_kg': pesoKg,
    });
  }

  WeightEntriesCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? fecha,
    Value<double>? pesoKg,
  }) {
    return WeightEntriesCompanion(
      id: id ?? this.id,
      fecha: fecha ?? this.fecha,
      pesoKg: pesoKg ?? this.pesoKg,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (fecha.present) {
      map['fecha'] = Variable<DateTime>(fecha.value);
    }
    if (pesoKg.present) {
      map['peso_kg'] = Variable<double>(pesoKg.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WeightEntriesCompanion(')
          ..write('id: $id, ')
          ..write('fecha: $fecha, ')
          ..write('pesoKg: $pesoKg')
          ..write(')'))
        .toString();
  }
}

class $ProductsTable extends Products with TableInfo<$ProductsTable, Product> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _barcodeMeta = const VerificationMeta(
    'barcode',
  );
  @override
  late final GeneratedColumn<String> barcode = GeneratedColumn<String>(
    'barcode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
    'nombre',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _caloriasPor100gMeta = const VerificationMeta(
    'caloriasPor100g',
  );
  @override
  late final GeneratedColumn<double> caloriasPor100g = GeneratedColumn<double>(
    'calorias_por100g',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _proteinasPor100gMeta = const VerificationMeta(
    'proteinasPor100g',
  );
  @override
  late final GeneratedColumn<double> proteinasPor100g = GeneratedColumn<double>(
    'proteinas_por100g',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _carbohidratosPor100gMeta =
      const VerificationMeta('carbohidratosPor100g');
  @override
  late final GeneratedColumn<double> carbohidratosPor100g =
      GeneratedColumn<double>(
        'carbohidratos_por100g',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
        defaultValue: const Constant(0),
      );
  static const VerificationMeta _grasasPor100gMeta = const VerificationMeta(
    'grasasPor100g',
  );
  @override
  late final GeneratedColumn<double> grasasPor100g = GeneratedColumn<double>(
    'grasas_por100g',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _cacheadoEnMeta = const VerificationMeta(
    'cacheadoEn',
  );
  @override
  late final GeneratedColumn<DateTime> cacheadoEn = GeneratedColumn<DateTime>(
    'cacheado_en',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    barcode,
    nombre,
    caloriasPor100g,
    proteinasPor100g,
    carbohidratosPor100g,
    grasasPor100g,
    cacheadoEn,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'products';
  @override
  VerificationContext validateIntegrity(
    Insertable<Product> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('barcode')) {
      context.handle(
        _barcodeMeta,
        barcode.isAcceptableOrUnknown(data['barcode']!, _barcodeMeta),
      );
    } else if (isInserting) {
      context.missing(_barcodeMeta);
    }
    if (data.containsKey('nombre')) {
      context.handle(
        _nombreMeta,
        nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta),
      );
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('calorias_por100g')) {
      context.handle(
        _caloriasPor100gMeta,
        caloriasPor100g.isAcceptableOrUnknown(
          data['calorias_por100g']!,
          _caloriasPor100gMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_caloriasPor100gMeta);
    }
    if (data.containsKey('proteinas_por100g')) {
      context.handle(
        _proteinasPor100gMeta,
        proteinasPor100g.isAcceptableOrUnknown(
          data['proteinas_por100g']!,
          _proteinasPor100gMeta,
        ),
      );
    }
    if (data.containsKey('carbohidratos_por100g')) {
      context.handle(
        _carbohidratosPor100gMeta,
        carbohidratosPor100g.isAcceptableOrUnknown(
          data['carbohidratos_por100g']!,
          _carbohidratosPor100gMeta,
        ),
      );
    }
    if (data.containsKey('grasas_por100g')) {
      context.handle(
        _grasasPor100gMeta,
        grasasPor100g.isAcceptableOrUnknown(
          data['grasas_por100g']!,
          _grasasPor100gMeta,
        ),
      );
    }
    if (data.containsKey('cacheado_en')) {
      context.handle(
        _cacheadoEnMeta,
        cacheadoEn.isAcceptableOrUnknown(data['cacheado_en']!, _cacheadoEnMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {barcode};
  @override
  Product map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Product(
      barcode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}barcode'],
      )!,
      nombre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre'],
      )!,
      caloriasPor100g: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}calorias_por100g'],
      )!,
      proteinasPor100g: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}proteinas_por100g'],
      )!,
      carbohidratosPor100g: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}carbohidratos_por100g'],
      )!,
      grasasPor100g: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}grasas_por100g'],
      )!,
      cacheadoEn: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}cacheado_en'],
      )!,
    );
  }

  @override
  $ProductsTable createAlias(String alias) {
    return $ProductsTable(attachedDatabase, alias);
  }
}

class Product extends DataClass implements Insertable<Product> {
  final String barcode;
  final String nombre;
  final double caloriasPor100g;
  final double proteinasPor100g;
  final double carbohidratosPor100g;
  final double grasasPor100g;
  final DateTime cacheadoEn;
  const Product({
    required this.barcode,
    required this.nombre,
    required this.caloriasPor100g,
    required this.proteinasPor100g,
    required this.carbohidratosPor100g,
    required this.grasasPor100g,
    required this.cacheadoEn,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['barcode'] = Variable<String>(barcode);
    map['nombre'] = Variable<String>(nombre);
    map['calorias_por100g'] = Variable<double>(caloriasPor100g);
    map['proteinas_por100g'] = Variable<double>(proteinasPor100g);
    map['carbohidratos_por100g'] = Variable<double>(carbohidratosPor100g);
    map['grasas_por100g'] = Variable<double>(grasasPor100g);
    map['cacheado_en'] = Variable<DateTime>(cacheadoEn);
    return map;
  }

  ProductsCompanion toCompanion(bool nullToAbsent) {
    return ProductsCompanion(
      barcode: Value(barcode),
      nombre: Value(nombre),
      caloriasPor100g: Value(caloriasPor100g),
      proteinasPor100g: Value(proteinasPor100g),
      carbohidratosPor100g: Value(carbohidratosPor100g),
      grasasPor100g: Value(grasasPor100g),
      cacheadoEn: Value(cacheadoEn),
    );
  }

  factory Product.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Product(
      barcode: serializer.fromJson<String>(json['barcode']),
      nombre: serializer.fromJson<String>(json['nombre']),
      caloriasPor100g: serializer.fromJson<double>(json['caloriasPor100g']),
      proteinasPor100g: serializer.fromJson<double>(json['proteinasPor100g']),
      carbohidratosPor100g: serializer.fromJson<double>(
        json['carbohidratosPor100g'],
      ),
      grasasPor100g: serializer.fromJson<double>(json['grasasPor100g']),
      cacheadoEn: serializer.fromJson<DateTime>(json['cacheadoEn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'barcode': serializer.toJson<String>(barcode),
      'nombre': serializer.toJson<String>(nombre),
      'caloriasPor100g': serializer.toJson<double>(caloriasPor100g),
      'proteinasPor100g': serializer.toJson<double>(proteinasPor100g),
      'carbohidratosPor100g': serializer.toJson<double>(carbohidratosPor100g),
      'grasasPor100g': serializer.toJson<double>(grasasPor100g),
      'cacheadoEn': serializer.toJson<DateTime>(cacheadoEn),
    };
  }

  Product copyWith({
    String? barcode,
    String? nombre,
    double? caloriasPor100g,
    double? proteinasPor100g,
    double? carbohidratosPor100g,
    double? grasasPor100g,
    DateTime? cacheadoEn,
  }) => Product(
    barcode: barcode ?? this.barcode,
    nombre: nombre ?? this.nombre,
    caloriasPor100g: caloriasPor100g ?? this.caloriasPor100g,
    proteinasPor100g: proteinasPor100g ?? this.proteinasPor100g,
    carbohidratosPor100g: carbohidratosPor100g ?? this.carbohidratosPor100g,
    grasasPor100g: grasasPor100g ?? this.grasasPor100g,
    cacheadoEn: cacheadoEn ?? this.cacheadoEn,
  );
  Product copyWithCompanion(ProductsCompanion data) {
    return Product(
      barcode: data.barcode.present ? data.barcode.value : this.barcode,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      caloriasPor100g: data.caloriasPor100g.present
          ? data.caloriasPor100g.value
          : this.caloriasPor100g,
      proteinasPor100g: data.proteinasPor100g.present
          ? data.proteinasPor100g.value
          : this.proteinasPor100g,
      carbohidratosPor100g: data.carbohidratosPor100g.present
          ? data.carbohidratosPor100g.value
          : this.carbohidratosPor100g,
      grasasPor100g: data.grasasPor100g.present
          ? data.grasasPor100g.value
          : this.grasasPor100g,
      cacheadoEn: data.cacheadoEn.present
          ? data.cacheadoEn.value
          : this.cacheadoEn,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Product(')
          ..write('barcode: $barcode, ')
          ..write('nombre: $nombre, ')
          ..write('caloriasPor100g: $caloriasPor100g, ')
          ..write('proteinasPor100g: $proteinasPor100g, ')
          ..write('carbohidratosPor100g: $carbohidratosPor100g, ')
          ..write('grasasPor100g: $grasasPor100g, ')
          ..write('cacheadoEn: $cacheadoEn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    barcode,
    nombre,
    caloriasPor100g,
    proteinasPor100g,
    carbohidratosPor100g,
    grasasPor100g,
    cacheadoEn,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Product &&
          other.barcode == this.barcode &&
          other.nombre == this.nombre &&
          other.caloriasPor100g == this.caloriasPor100g &&
          other.proteinasPor100g == this.proteinasPor100g &&
          other.carbohidratosPor100g == this.carbohidratosPor100g &&
          other.grasasPor100g == this.grasasPor100g &&
          other.cacheadoEn == this.cacheadoEn);
}

class ProductsCompanion extends UpdateCompanion<Product> {
  final Value<String> barcode;
  final Value<String> nombre;
  final Value<double> caloriasPor100g;
  final Value<double> proteinasPor100g;
  final Value<double> carbohidratosPor100g;
  final Value<double> grasasPor100g;
  final Value<DateTime> cacheadoEn;
  final Value<int> rowid;
  const ProductsCompanion({
    this.barcode = const Value.absent(),
    this.nombre = const Value.absent(),
    this.caloriasPor100g = const Value.absent(),
    this.proteinasPor100g = const Value.absent(),
    this.carbohidratosPor100g = const Value.absent(),
    this.grasasPor100g = const Value.absent(),
    this.cacheadoEn = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProductsCompanion.insert({
    required String barcode,
    required String nombre,
    required double caloriasPor100g,
    this.proteinasPor100g = const Value.absent(),
    this.carbohidratosPor100g = const Value.absent(),
    this.grasasPor100g = const Value.absent(),
    this.cacheadoEn = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : barcode = Value(barcode),
       nombre = Value(nombre),
       caloriasPor100g = Value(caloriasPor100g);
  static Insertable<Product> custom({
    Expression<String>? barcode,
    Expression<String>? nombre,
    Expression<double>? caloriasPor100g,
    Expression<double>? proteinasPor100g,
    Expression<double>? carbohidratosPor100g,
    Expression<double>? grasasPor100g,
    Expression<DateTime>? cacheadoEn,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (barcode != null) 'barcode': barcode,
      if (nombre != null) 'nombre': nombre,
      if (caloriasPor100g != null) 'calorias_por100g': caloriasPor100g,
      if (proteinasPor100g != null) 'proteinas_por100g': proteinasPor100g,
      if (carbohidratosPor100g != null)
        'carbohidratos_por100g': carbohidratosPor100g,
      if (grasasPor100g != null) 'grasas_por100g': grasasPor100g,
      if (cacheadoEn != null) 'cacheado_en': cacheadoEn,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProductsCompanion copyWith({
    Value<String>? barcode,
    Value<String>? nombre,
    Value<double>? caloriasPor100g,
    Value<double>? proteinasPor100g,
    Value<double>? carbohidratosPor100g,
    Value<double>? grasasPor100g,
    Value<DateTime>? cacheadoEn,
    Value<int>? rowid,
  }) {
    return ProductsCompanion(
      barcode: barcode ?? this.barcode,
      nombre: nombre ?? this.nombre,
      caloriasPor100g: caloriasPor100g ?? this.caloriasPor100g,
      proteinasPor100g: proteinasPor100g ?? this.proteinasPor100g,
      carbohidratosPor100g: carbohidratosPor100g ?? this.carbohidratosPor100g,
      grasasPor100g: grasasPor100g ?? this.grasasPor100g,
      cacheadoEn: cacheadoEn ?? this.cacheadoEn,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (barcode.present) {
      map['barcode'] = Variable<String>(barcode.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (caloriasPor100g.present) {
      map['calorias_por100g'] = Variable<double>(caloriasPor100g.value);
    }
    if (proteinasPor100g.present) {
      map['proteinas_por100g'] = Variable<double>(proteinasPor100g.value);
    }
    if (carbohidratosPor100g.present) {
      map['carbohidratos_por100g'] = Variable<double>(
        carbohidratosPor100g.value,
      );
    }
    if (grasasPor100g.present) {
      map['grasas_por100g'] = Variable<double>(grasasPor100g.value);
    }
    if (cacheadoEn.present) {
      map['cacheado_en'] = Variable<DateTime>(cacheadoEn.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductsCompanion(')
          ..write('barcode: $barcode, ')
          ..write('nombre: $nombre, ')
          ..write('caloriasPor100g: $caloriasPor100g, ')
          ..write('proteinasPor100g: $proteinasPor100g, ')
          ..write('carbohidratosPor100g: $carbohidratosPor100g, ')
          ..write('grasasPor100g: $grasasPor100g, ')
          ..write('cacheadoEn: $cacheadoEn, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UserProfilesTable userProfiles = $UserProfilesTable(this);
  late final $FoodEntriesTable foodEntries = $FoodEntriesTable(this);
  late final $ExerciseEntriesTable exerciseEntries = $ExerciseEntriesTable(
    this,
  );
  late final $SleepEntriesTable sleepEntries = $SleepEntriesTable(this);
  late final $WaterEntriesTable waterEntries = $WaterEntriesTable(this);
  late final $WeightEntriesTable weightEntries = $WeightEntriesTable(this);
  late final $ProductsTable products = $ProductsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    userProfiles,
    foodEntries,
    exerciseEntries,
    sleepEntries,
    waterEntries,
    weightEntries,
    products,
  ];
}

typedef $$UserProfilesTableCreateCompanionBuilder =
    UserProfilesCompanion Function({
      Value<int> id,
      Value<String> nombre,
      required int edad,
      required Sexo sexo,
      required double pesoKg,
      required double alturaCm,
      required NivelActividad nivelActividad,
      required Objetivo objetivo,
      required int objetivoCalorias,
      required double objetivoProteinasG,
      required double objetivoCarbohidratosG,
      required double objetivoGrasasG,
      required int objetivoAguaMl,
      Value<double> objetivoSuenoHoras,
      Value<String> unidadPeso,
      Value<DateTime> actualizadoEn,
    });
typedef $$UserProfilesTableUpdateCompanionBuilder =
    UserProfilesCompanion Function({
      Value<int> id,
      Value<String> nombre,
      Value<int> edad,
      Value<Sexo> sexo,
      Value<double> pesoKg,
      Value<double> alturaCm,
      Value<NivelActividad> nivelActividad,
      Value<Objetivo> objetivo,
      Value<int> objetivoCalorias,
      Value<double> objetivoProteinasG,
      Value<double> objetivoCarbohidratosG,
      Value<double> objetivoGrasasG,
      Value<int> objetivoAguaMl,
      Value<double> objetivoSuenoHoras,
      Value<String> unidadPeso,
      Value<DateTime> actualizadoEn,
    });

class $$UserProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableFilterComposer({
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

  ColumnFilters<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get edad => $composableBuilder(
    column: $table.edad,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Sexo, Sexo, String> get sexo =>
      $composableBuilder(
        column: $table.sexo,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<double> get pesoKg => $composableBuilder(
    column: $table.pesoKg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get alturaCm => $composableBuilder(
    column: $table.alturaCm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<NivelActividad, NivelActividad, String>
  get nivelActividad => $composableBuilder(
    column: $table.nivelActividad,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<Objetivo, Objetivo, String> get objetivo =>
      $composableBuilder(
        column: $table.objetivo,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<int> get objetivoCalorias => $composableBuilder(
    column: $table.objetivoCalorias,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get objetivoProteinasG => $composableBuilder(
    column: $table.objetivoProteinasG,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get objetivoCarbohidratosG => $composableBuilder(
    column: $table.objetivoCarbohidratosG,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get objetivoGrasasG => $composableBuilder(
    column: $table.objetivoGrasasG,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get objetivoAguaMl => $composableBuilder(
    column: $table.objetivoAguaMl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get objetivoSuenoHoras => $composableBuilder(
    column: $table.objetivoSuenoHoras,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unidadPeso => $composableBuilder(
    column: $table.unidadPeso,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get actualizadoEn => $composableBuilder(
    column: $table.actualizadoEn,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UserProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableOrderingComposer({
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

  ColumnOrderings<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get edad => $composableBuilder(
    column: $table.edad,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sexo => $composableBuilder(
    column: $table.sexo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get pesoKg => $composableBuilder(
    column: $table.pesoKg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get alturaCm => $composableBuilder(
    column: $table.alturaCm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nivelActividad => $composableBuilder(
    column: $table.nivelActividad,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get objetivo => $composableBuilder(
    column: $table.objetivo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get objetivoCalorias => $composableBuilder(
    column: $table.objetivoCalorias,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get objetivoProteinasG => $composableBuilder(
    column: $table.objetivoProteinasG,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get objetivoCarbohidratosG => $composableBuilder(
    column: $table.objetivoCarbohidratosG,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get objetivoGrasasG => $composableBuilder(
    column: $table.objetivoGrasasG,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get objetivoAguaMl => $composableBuilder(
    column: $table.objetivoAguaMl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get objetivoSuenoHoras => $composableBuilder(
    column: $table.objetivoSuenoHoras,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unidadPeso => $composableBuilder(
    column: $table.unidadPeso,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get actualizadoEn => $composableBuilder(
    column: $table.actualizadoEn,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UserProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<int> get edad =>
      $composableBuilder(column: $table.edad, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Sexo, String> get sexo =>
      $composableBuilder(column: $table.sexo, builder: (column) => column);

  GeneratedColumn<double> get pesoKg =>
      $composableBuilder(column: $table.pesoKg, builder: (column) => column);

  GeneratedColumn<double> get alturaCm =>
      $composableBuilder(column: $table.alturaCm, builder: (column) => column);

  GeneratedColumnWithTypeConverter<NivelActividad, String> get nivelActividad =>
      $composableBuilder(
        column: $table.nivelActividad,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<Objetivo, String> get objetivo =>
      $composableBuilder(column: $table.objetivo, builder: (column) => column);

  GeneratedColumn<int> get objetivoCalorias => $composableBuilder(
    column: $table.objetivoCalorias,
    builder: (column) => column,
  );

  GeneratedColumn<double> get objetivoProteinasG => $composableBuilder(
    column: $table.objetivoProteinasG,
    builder: (column) => column,
  );

  GeneratedColumn<double> get objetivoCarbohidratosG => $composableBuilder(
    column: $table.objetivoCarbohidratosG,
    builder: (column) => column,
  );

  GeneratedColumn<double> get objetivoGrasasG => $composableBuilder(
    column: $table.objetivoGrasasG,
    builder: (column) => column,
  );

  GeneratedColumn<int> get objetivoAguaMl => $composableBuilder(
    column: $table.objetivoAguaMl,
    builder: (column) => column,
  );

  GeneratedColumn<double> get objetivoSuenoHoras => $composableBuilder(
    column: $table.objetivoSuenoHoras,
    builder: (column) => column,
  );

  GeneratedColumn<String> get unidadPeso => $composableBuilder(
    column: $table.unidadPeso,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get actualizadoEn => $composableBuilder(
    column: $table.actualizadoEn,
    builder: (column) => column,
  );
}

class $$UserProfilesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserProfilesTable,
          UserProfile,
          $$UserProfilesTableFilterComposer,
          $$UserProfilesTableOrderingComposer,
          $$UserProfilesTableAnnotationComposer,
          $$UserProfilesTableCreateCompanionBuilder,
          $$UserProfilesTableUpdateCompanionBuilder,
          (
            UserProfile,
            BaseReferences<_$AppDatabase, $UserProfilesTable, UserProfile>,
          ),
          UserProfile,
          PrefetchHooks Function()
        > {
  $$UserProfilesTableTableManager(_$AppDatabase db, $UserProfilesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nombre = const Value.absent(),
                Value<int> edad = const Value.absent(),
                Value<Sexo> sexo = const Value.absent(),
                Value<double> pesoKg = const Value.absent(),
                Value<double> alturaCm = const Value.absent(),
                Value<NivelActividad> nivelActividad = const Value.absent(),
                Value<Objetivo> objetivo = const Value.absent(),
                Value<int> objetivoCalorias = const Value.absent(),
                Value<double> objetivoProteinasG = const Value.absent(),
                Value<double> objetivoCarbohidratosG = const Value.absent(),
                Value<double> objetivoGrasasG = const Value.absent(),
                Value<int> objetivoAguaMl = const Value.absent(),
                Value<double> objetivoSuenoHoras = const Value.absent(),
                Value<String> unidadPeso = const Value.absent(),
                Value<DateTime> actualizadoEn = const Value.absent(),
              }) => UserProfilesCompanion(
                id: id,
                nombre: nombre,
                edad: edad,
                sexo: sexo,
                pesoKg: pesoKg,
                alturaCm: alturaCm,
                nivelActividad: nivelActividad,
                objetivo: objetivo,
                objetivoCalorias: objetivoCalorias,
                objetivoProteinasG: objetivoProteinasG,
                objetivoCarbohidratosG: objetivoCarbohidratosG,
                objetivoGrasasG: objetivoGrasasG,
                objetivoAguaMl: objetivoAguaMl,
                objetivoSuenoHoras: objetivoSuenoHoras,
                unidadPeso: unidadPeso,
                actualizadoEn: actualizadoEn,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nombre = const Value.absent(),
                required int edad,
                required Sexo sexo,
                required double pesoKg,
                required double alturaCm,
                required NivelActividad nivelActividad,
                required Objetivo objetivo,
                required int objetivoCalorias,
                required double objetivoProteinasG,
                required double objetivoCarbohidratosG,
                required double objetivoGrasasG,
                required int objetivoAguaMl,
                Value<double> objetivoSuenoHoras = const Value.absent(),
                Value<String> unidadPeso = const Value.absent(),
                Value<DateTime> actualizadoEn = const Value.absent(),
              }) => UserProfilesCompanion.insert(
                id: id,
                nombre: nombre,
                edad: edad,
                sexo: sexo,
                pesoKg: pesoKg,
                alturaCm: alturaCm,
                nivelActividad: nivelActividad,
                objetivo: objetivo,
                objetivoCalorias: objetivoCalorias,
                objetivoProteinasG: objetivoProteinasG,
                objetivoCarbohidratosG: objetivoCarbohidratosG,
                objetivoGrasasG: objetivoGrasasG,
                objetivoAguaMl: objetivoAguaMl,
                objetivoSuenoHoras: objetivoSuenoHoras,
                unidadPeso: unidadPeso,
                actualizadoEn: actualizadoEn,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UserProfilesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserProfilesTable,
      UserProfile,
      $$UserProfilesTableFilterComposer,
      $$UserProfilesTableOrderingComposer,
      $$UserProfilesTableAnnotationComposer,
      $$UserProfilesTableCreateCompanionBuilder,
      $$UserProfilesTableUpdateCompanionBuilder,
      (
        UserProfile,
        BaseReferences<_$AppDatabase, $UserProfilesTable, UserProfile>,
      ),
      UserProfile,
      PrefetchHooks Function()
    >;
typedef $$FoodEntriesTableCreateCompanionBuilder =
    FoodEntriesCompanion Function({
      Value<int> id,
      required String nombre,
      required double calorias,
      Value<double> proteinasG,
      Value<double> carbohidratosG,
      Value<double> grasasG,
      Value<double?> porcionGramos,
      required MomentoComida momento,
      required OrigenRegistro origen,
      Value<String?> barcode,
      required DateTime fecha,
    });
typedef $$FoodEntriesTableUpdateCompanionBuilder =
    FoodEntriesCompanion Function({
      Value<int> id,
      Value<String> nombre,
      Value<double> calorias,
      Value<double> proteinasG,
      Value<double> carbohidratosG,
      Value<double> grasasG,
      Value<double?> porcionGramos,
      Value<MomentoComida> momento,
      Value<OrigenRegistro> origen,
      Value<String?> barcode,
      Value<DateTime> fecha,
    });

class $$FoodEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $FoodEntriesTable> {
  $$FoodEntriesTableFilterComposer({
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

  ColumnFilters<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get calorias => $composableBuilder(
    column: $table.calorias,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get proteinasG => $composableBuilder(
    column: $table.proteinasG,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get carbohidratosG => $composableBuilder(
    column: $table.carbohidratosG,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get grasasG => $composableBuilder(
    column: $table.grasasG,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get porcionGramos => $composableBuilder(
    column: $table.porcionGramos,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<MomentoComida, MomentoComida, String>
  get momento => $composableBuilder(
    column: $table.momento,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<OrigenRegistro, OrigenRegistro, String>
  get origen => $composableBuilder(
    column: $table.origen,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get barcode => $composableBuilder(
    column: $table.barcode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fecha => $composableBuilder(
    column: $table.fecha,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FoodEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $FoodEntriesTable> {
  $$FoodEntriesTableOrderingComposer({
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

  ColumnOrderings<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get calorias => $composableBuilder(
    column: $table.calorias,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get proteinasG => $composableBuilder(
    column: $table.proteinasG,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get carbohidratosG => $composableBuilder(
    column: $table.carbohidratosG,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get grasasG => $composableBuilder(
    column: $table.grasasG,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get porcionGramos => $composableBuilder(
    column: $table.porcionGramos,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get momento => $composableBuilder(
    column: $table.momento,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get origen => $composableBuilder(
    column: $table.origen,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get barcode => $composableBuilder(
    column: $table.barcode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fecha => $composableBuilder(
    column: $table.fecha,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FoodEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $FoodEntriesTable> {
  $$FoodEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<double> get calorias =>
      $composableBuilder(column: $table.calorias, builder: (column) => column);

  GeneratedColumn<double> get proteinasG => $composableBuilder(
    column: $table.proteinasG,
    builder: (column) => column,
  );

  GeneratedColumn<double> get carbohidratosG => $composableBuilder(
    column: $table.carbohidratosG,
    builder: (column) => column,
  );

  GeneratedColumn<double> get grasasG =>
      $composableBuilder(column: $table.grasasG, builder: (column) => column);

  GeneratedColumn<double> get porcionGramos => $composableBuilder(
    column: $table.porcionGramos,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<MomentoComida, String> get momento =>
      $composableBuilder(column: $table.momento, builder: (column) => column);

  GeneratedColumnWithTypeConverter<OrigenRegistro, String> get origen =>
      $composableBuilder(column: $table.origen, builder: (column) => column);

  GeneratedColumn<String> get barcode =>
      $composableBuilder(column: $table.barcode, builder: (column) => column);

  GeneratedColumn<DateTime> get fecha =>
      $composableBuilder(column: $table.fecha, builder: (column) => column);
}

class $$FoodEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FoodEntriesTable,
          FoodEntry,
          $$FoodEntriesTableFilterComposer,
          $$FoodEntriesTableOrderingComposer,
          $$FoodEntriesTableAnnotationComposer,
          $$FoodEntriesTableCreateCompanionBuilder,
          $$FoodEntriesTableUpdateCompanionBuilder,
          (
            FoodEntry,
            BaseReferences<_$AppDatabase, $FoodEntriesTable, FoodEntry>,
          ),
          FoodEntry,
          PrefetchHooks Function()
        > {
  $$FoodEntriesTableTableManager(_$AppDatabase db, $FoodEntriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FoodEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FoodEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FoodEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nombre = const Value.absent(),
                Value<double> calorias = const Value.absent(),
                Value<double> proteinasG = const Value.absent(),
                Value<double> carbohidratosG = const Value.absent(),
                Value<double> grasasG = const Value.absent(),
                Value<double?> porcionGramos = const Value.absent(),
                Value<MomentoComida> momento = const Value.absent(),
                Value<OrigenRegistro> origen = const Value.absent(),
                Value<String?> barcode = const Value.absent(),
                Value<DateTime> fecha = const Value.absent(),
              }) => FoodEntriesCompanion(
                id: id,
                nombre: nombre,
                calorias: calorias,
                proteinasG: proteinasG,
                carbohidratosG: carbohidratosG,
                grasasG: grasasG,
                porcionGramos: porcionGramos,
                momento: momento,
                origen: origen,
                barcode: barcode,
                fecha: fecha,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nombre,
                required double calorias,
                Value<double> proteinasG = const Value.absent(),
                Value<double> carbohidratosG = const Value.absent(),
                Value<double> grasasG = const Value.absent(),
                Value<double?> porcionGramos = const Value.absent(),
                required MomentoComida momento,
                required OrigenRegistro origen,
                Value<String?> barcode = const Value.absent(),
                required DateTime fecha,
              }) => FoodEntriesCompanion.insert(
                id: id,
                nombre: nombre,
                calorias: calorias,
                proteinasG: proteinasG,
                carbohidratosG: carbohidratosG,
                grasasG: grasasG,
                porcionGramos: porcionGramos,
                momento: momento,
                origen: origen,
                barcode: barcode,
                fecha: fecha,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FoodEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FoodEntriesTable,
      FoodEntry,
      $$FoodEntriesTableFilterComposer,
      $$FoodEntriesTableOrderingComposer,
      $$FoodEntriesTableAnnotationComposer,
      $$FoodEntriesTableCreateCompanionBuilder,
      $$FoodEntriesTableUpdateCompanionBuilder,
      (FoodEntry, BaseReferences<_$AppDatabase, $FoodEntriesTable, FoodEntry>),
      FoodEntry,
      PrefetchHooks Function()
    >;
typedef $$ExerciseEntriesTableCreateCompanionBuilder =
    ExerciseEntriesCompanion Function({
      Value<int> id,
      required String tipo,
      required int duracionMin,
      required double caloriasQuemadas,
      Value<String?> notas,
      required DateTime fecha,
    });
typedef $$ExerciseEntriesTableUpdateCompanionBuilder =
    ExerciseEntriesCompanion Function({
      Value<int> id,
      Value<String> tipo,
      Value<int> duracionMin,
      Value<double> caloriasQuemadas,
      Value<String?> notas,
      Value<DateTime> fecha,
    });

class $$ExerciseEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $ExerciseEntriesTable> {
  $$ExerciseEntriesTableFilterComposer({
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

  ColumnFilters<String> get tipo => $composableBuilder(
    column: $table.tipo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get duracionMin => $composableBuilder(
    column: $table.duracionMin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get caloriasQuemadas => $composableBuilder(
    column: $table.caloriasQuemadas,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notas => $composableBuilder(
    column: $table.notas,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fecha => $composableBuilder(
    column: $table.fecha,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ExerciseEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $ExerciseEntriesTable> {
  $$ExerciseEntriesTableOrderingComposer({
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

  ColumnOrderings<String> get tipo => $composableBuilder(
    column: $table.tipo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get duracionMin => $composableBuilder(
    column: $table.duracionMin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get caloriasQuemadas => $composableBuilder(
    column: $table.caloriasQuemadas,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notas => $composableBuilder(
    column: $table.notas,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fecha => $composableBuilder(
    column: $table.fecha,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ExerciseEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExerciseEntriesTable> {
  $$ExerciseEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tipo =>
      $composableBuilder(column: $table.tipo, builder: (column) => column);

  GeneratedColumn<int> get duracionMin => $composableBuilder(
    column: $table.duracionMin,
    builder: (column) => column,
  );

  GeneratedColumn<double> get caloriasQuemadas => $composableBuilder(
    column: $table.caloriasQuemadas,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notas =>
      $composableBuilder(column: $table.notas, builder: (column) => column);

  GeneratedColumn<DateTime> get fecha =>
      $composableBuilder(column: $table.fecha, builder: (column) => column);
}

class $$ExerciseEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExerciseEntriesTable,
          ExerciseEntry,
          $$ExerciseEntriesTableFilterComposer,
          $$ExerciseEntriesTableOrderingComposer,
          $$ExerciseEntriesTableAnnotationComposer,
          $$ExerciseEntriesTableCreateCompanionBuilder,
          $$ExerciseEntriesTableUpdateCompanionBuilder,
          (
            ExerciseEntry,
            BaseReferences<_$AppDatabase, $ExerciseEntriesTable, ExerciseEntry>,
          ),
          ExerciseEntry,
          PrefetchHooks Function()
        > {
  $$ExerciseEntriesTableTableManager(
    _$AppDatabase db,
    $ExerciseEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExerciseEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExerciseEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExerciseEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> tipo = const Value.absent(),
                Value<int> duracionMin = const Value.absent(),
                Value<double> caloriasQuemadas = const Value.absent(),
                Value<String?> notas = const Value.absent(),
                Value<DateTime> fecha = const Value.absent(),
              }) => ExerciseEntriesCompanion(
                id: id,
                tipo: tipo,
                duracionMin: duracionMin,
                caloriasQuemadas: caloriasQuemadas,
                notas: notas,
                fecha: fecha,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String tipo,
                required int duracionMin,
                required double caloriasQuemadas,
                Value<String?> notas = const Value.absent(),
                required DateTime fecha,
              }) => ExerciseEntriesCompanion.insert(
                id: id,
                tipo: tipo,
                duracionMin: duracionMin,
                caloriasQuemadas: caloriasQuemadas,
                notas: notas,
                fecha: fecha,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ExerciseEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExerciseEntriesTable,
      ExerciseEntry,
      $$ExerciseEntriesTableFilterComposer,
      $$ExerciseEntriesTableOrderingComposer,
      $$ExerciseEntriesTableAnnotationComposer,
      $$ExerciseEntriesTableCreateCompanionBuilder,
      $$ExerciseEntriesTableUpdateCompanionBuilder,
      (
        ExerciseEntry,
        BaseReferences<_$AppDatabase, $ExerciseEntriesTable, ExerciseEntry>,
      ),
      ExerciseEntry,
      PrefetchHooks Function()
    >;
typedef $$SleepEntriesTableCreateCompanionBuilder =
    SleepEntriesCompanion Function({
      Value<int> id,
      required DateTime fecha,
      required double horas,
      Value<DateTime?> horaAcostarse,
      Value<DateTime?> horaLevantarse,
    });
typedef $$SleepEntriesTableUpdateCompanionBuilder =
    SleepEntriesCompanion Function({
      Value<int> id,
      Value<DateTime> fecha,
      Value<double> horas,
      Value<DateTime?> horaAcostarse,
      Value<DateTime?> horaLevantarse,
    });

class $$SleepEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $SleepEntriesTable> {
  $$SleepEntriesTableFilterComposer({
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

  ColumnFilters<DateTime> get fecha => $composableBuilder(
    column: $table.fecha,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get horas => $composableBuilder(
    column: $table.horas,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get horaAcostarse => $composableBuilder(
    column: $table.horaAcostarse,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get horaLevantarse => $composableBuilder(
    column: $table.horaLevantarse,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SleepEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $SleepEntriesTable> {
  $$SleepEntriesTableOrderingComposer({
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

  ColumnOrderings<DateTime> get fecha => $composableBuilder(
    column: $table.fecha,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get horas => $composableBuilder(
    column: $table.horas,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get horaAcostarse => $composableBuilder(
    column: $table.horaAcostarse,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get horaLevantarse => $composableBuilder(
    column: $table.horaLevantarse,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SleepEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $SleepEntriesTable> {
  $$SleepEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get fecha =>
      $composableBuilder(column: $table.fecha, builder: (column) => column);

  GeneratedColumn<double> get horas =>
      $composableBuilder(column: $table.horas, builder: (column) => column);

  GeneratedColumn<DateTime> get horaAcostarse => $composableBuilder(
    column: $table.horaAcostarse,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get horaLevantarse => $composableBuilder(
    column: $table.horaLevantarse,
    builder: (column) => column,
  );
}

class $$SleepEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SleepEntriesTable,
          SleepEntry,
          $$SleepEntriesTableFilterComposer,
          $$SleepEntriesTableOrderingComposer,
          $$SleepEntriesTableAnnotationComposer,
          $$SleepEntriesTableCreateCompanionBuilder,
          $$SleepEntriesTableUpdateCompanionBuilder,
          (
            SleepEntry,
            BaseReferences<_$AppDatabase, $SleepEntriesTable, SleepEntry>,
          ),
          SleepEntry,
          PrefetchHooks Function()
        > {
  $$SleepEntriesTableTableManager(_$AppDatabase db, $SleepEntriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SleepEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SleepEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SleepEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> fecha = const Value.absent(),
                Value<double> horas = const Value.absent(),
                Value<DateTime?> horaAcostarse = const Value.absent(),
                Value<DateTime?> horaLevantarse = const Value.absent(),
              }) => SleepEntriesCompanion(
                id: id,
                fecha: fecha,
                horas: horas,
                horaAcostarse: horaAcostarse,
                horaLevantarse: horaLevantarse,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime fecha,
                required double horas,
                Value<DateTime?> horaAcostarse = const Value.absent(),
                Value<DateTime?> horaLevantarse = const Value.absent(),
              }) => SleepEntriesCompanion.insert(
                id: id,
                fecha: fecha,
                horas: horas,
                horaAcostarse: horaAcostarse,
                horaLevantarse: horaLevantarse,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SleepEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SleepEntriesTable,
      SleepEntry,
      $$SleepEntriesTableFilterComposer,
      $$SleepEntriesTableOrderingComposer,
      $$SleepEntriesTableAnnotationComposer,
      $$SleepEntriesTableCreateCompanionBuilder,
      $$SleepEntriesTableUpdateCompanionBuilder,
      (
        SleepEntry,
        BaseReferences<_$AppDatabase, $SleepEntriesTable, SleepEntry>,
      ),
      SleepEntry,
      PrefetchHooks Function()
    >;
typedef $$WaterEntriesTableCreateCompanionBuilder =
    WaterEntriesCompanion Function({
      Value<int> id,
      required DateTime fecha,
      Value<int> ml,
    });
typedef $$WaterEntriesTableUpdateCompanionBuilder =
    WaterEntriesCompanion Function({
      Value<int> id,
      Value<DateTime> fecha,
      Value<int> ml,
    });

class $$WaterEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $WaterEntriesTable> {
  $$WaterEntriesTableFilterComposer({
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

  ColumnFilters<DateTime> get fecha => $composableBuilder(
    column: $table.fecha,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ml => $composableBuilder(
    column: $table.ml,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WaterEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $WaterEntriesTable> {
  $$WaterEntriesTableOrderingComposer({
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

  ColumnOrderings<DateTime> get fecha => $composableBuilder(
    column: $table.fecha,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ml => $composableBuilder(
    column: $table.ml,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WaterEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $WaterEntriesTable> {
  $$WaterEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get fecha =>
      $composableBuilder(column: $table.fecha, builder: (column) => column);

  GeneratedColumn<int> get ml =>
      $composableBuilder(column: $table.ml, builder: (column) => column);
}

class $$WaterEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WaterEntriesTable,
          WaterEntry,
          $$WaterEntriesTableFilterComposer,
          $$WaterEntriesTableOrderingComposer,
          $$WaterEntriesTableAnnotationComposer,
          $$WaterEntriesTableCreateCompanionBuilder,
          $$WaterEntriesTableUpdateCompanionBuilder,
          (
            WaterEntry,
            BaseReferences<_$AppDatabase, $WaterEntriesTable, WaterEntry>,
          ),
          WaterEntry,
          PrefetchHooks Function()
        > {
  $$WaterEntriesTableTableManager(_$AppDatabase db, $WaterEntriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WaterEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WaterEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WaterEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> fecha = const Value.absent(),
                Value<int> ml = const Value.absent(),
              }) => WaterEntriesCompanion(id: id, fecha: fecha, ml: ml),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime fecha,
                Value<int> ml = const Value.absent(),
              }) => WaterEntriesCompanion.insert(id: id, fecha: fecha, ml: ml),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WaterEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WaterEntriesTable,
      WaterEntry,
      $$WaterEntriesTableFilterComposer,
      $$WaterEntriesTableOrderingComposer,
      $$WaterEntriesTableAnnotationComposer,
      $$WaterEntriesTableCreateCompanionBuilder,
      $$WaterEntriesTableUpdateCompanionBuilder,
      (
        WaterEntry,
        BaseReferences<_$AppDatabase, $WaterEntriesTable, WaterEntry>,
      ),
      WaterEntry,
      PrefetchHooks Function()
    >;
typedef $$WeightEntriesTableCreateCompanionBuilder =
    WeightEntriesCompanion Function({
      Value<int> id,
      required DateTime fecha,
      required double pesoKg,
    });
typedef $$WeightEntriesTableUpdateCompanionBuilder =
    WeightEntriesCompanion Function({
      Value<int> id,
      Value<DateTime> fecha,
      Value<double> pesoKg,
    });

class $$WeightEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $WeightEntriesTable> {
  $$WeightEntriesTableFilterComposer({
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

  ColumnFilters<DateTime> get fecha => $composableBuilder(
    column: $table.fecha,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get pesoKg => $composableBuilder(
    column: $table.pesoKg,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WeightEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $WeightEntriesTable> {
  $$WeightEntriesTableOrderingComposer({
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

  ColumnOrderings<DateTime> get fecha => $composableBuilder(
    column: $table.fecha,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get pesoKg => $composableBuilder(
    column: $table.pesoKg,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WeightEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $WeightEntriesTable> {
  $$WeightEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get fecha =>
      $composableBuilder(column: $table.fecha, builder: (column) => column);

  GeneratedColumn<double> get pesoKg =>
      $composableBuilder(column: $table.pesoKg, builder: (column) => column);
}

class $$WeightEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WeightEntriesTable,
          WeightEntry,
          $$WeightEntriesTableFilterComposer,
          $$WeightEntriesTableOrderingComposer,
          $$WeightEntriesTableAnnotationComposer,
          $$WeightEntriesTableCreateCompanionBuilder,
          $$WeightEntriesTableUpdateCompanionBuilder,
          (
            WeightEntry,
            BaseReferences<_$AppDatabase, $WeightEntriesTable, WeightEntry>,
          ),
          WeightEntry,
          PrefetchHooks Function()
        > {
  $$WeightEntriesTableTableManager(_$AppDatabase db, $WeightEntriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WeightEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WeightEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WeightEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> fecha = const Value.absent(),
                Value<double> pesoKg = const Value.absent(),
              }) =>
                  WeightEntriesCompanion(id: id, fecha: fecha, pesoKg: pesoKg),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime fecha,
                required double pesoKg,
              }) => WeightEntriesCompanion.insert(
                id: id,
                fecha: fecha,
                pesoKg: pesoKg,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WeightEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WeightEntriesTable,
      WeightEntry,
      $$WeightEntriesTableFilterComposer,
      $$WeightEntriesTableOrderingComposer,
      $$WeightEntriesTableAnnotationComposer,
      $$WeightEntriesTableCreateCompanionBuilder,
      $$WeightEntriesTableUpdateCompanionBuilder,
      (
        WeightEntry,
        BaseReferences<_$AppDatabase, $WeightEntriesTable, WeightEntry>,
      ),
      WeightEntry,
      PrefetchHooks Function()
    >;
typedef $$ProductsTableCreateCompanionBuilder =
    ProductsCompanion Function({
      required String barcode,
      required String nombre,
      required double caloriasPor100g,
      Value<double> proteinasPor100g,
      Value<double> carbohidratosPor100g,
      Value<double> grasasPor100g,
      Value<DateTime> cacheadoEn,
      Value<int> rowid,
    });
typedef $$ProductsTableUpdateCompanionBuilder =
    ProductsCompanion Function({
      Value<String> barcode,
      Value<String> nombre,
      Value<double> caloriasPor100g,
      Value<double> proteinasPor100g,
      Value<double> carbohidratosPor100g,
      Value<double> grasasPor100g,
      Value<DateTime> cacheadoEn,
      Value<int> rowid,
    });

class $$ProductsTableFilterComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get barcode => $composableBuilder(
    column: $table.barcode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get caloriasPor100g => $composableBuilder(
    column: $table.caloriasPor100g,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get proteinasPor100g => $composableBuilder(
    column: $table.proteinasPor100g,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get carbohidratosPor100g => $composableBuilder(
    column: $table.carbohidratosPor100g,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get grasasPor100g => $composableBuilder(
    column: $table.grasasPor100g,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get cacheadoEn => $composableBuilder(
    column: $table.cacheadoEn,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProductsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get barcode => $composableBuilder(
    column: $table.barcode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get caloriasPor100g => $composableBuilder(
    column: $table.caloriasPor100g,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get proteinasPor100g => $composableBuilder(
    column: $table.proteinasPor100g,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get carbohidratosPor100g => $composableBuilder(
    column: $table.carbohidratosPor100g,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get grasasPor100g => $composableBuilder(
    column: $table.grasasPor100g,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get cacheadoEn => $composableBuilder(
    column: $table.cacheadoEn,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProductsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProductsTable> {
  $$ProductsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get barcode =>
      $composableBuilder(column: $table.barcode, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<double> get caloriasPor100g => $composableBuilder(
    column: $table.caloriasPor100g,
    builder: (column) => column,
  );

  GeneratedColumn<double> get proteinasPor100g => $composableBuilder(
    column: $table.proteinasPor100g,
    builder: (column) => column,
  );

  GeneratedColumn<double> get carbohidratosPor100g => $composableBuilder(
    column: $table.carbohidratosPor100g,
    builder: (column) => column,
  );

  GeneratedColumn<double> get grasasPor100g => $composableBuilder(
    column: $table.grasasPor100g,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get cacheadoEn => $composableBuilder(
    column: $table.cacheadoEn,
    builder: (column) => column,
  );
}

class $$ProductsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProductsTable,
          Product,
          $$ProductsTableFilterComposer,
          $$ProductsTableOrderingComposer,
          $$ProductsTableAnnotationComposer,
          $$ProductsTableCreateCompanionBuilder,
          $$ProductsTableUpdateCompanionBuilder,
          (Product, BaseReferences<_$AppDatabase, $ProductsTable, Product>),
          Product,
          PrefetchHooks Function()
        > {
  $$ProductsTableTableManager(_$AppDatabase db, $ProductsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> barcode = const Value.absent(),
                Value<String> nombre = const Value.absent(),
                Value<double> caloriasPor100g = const Value.absent(),
                Value<double> proteinasPor100g = const Value.absent(),
                Value<double> carbohidratosPor100g = const Value.absent(),
                Value<double> grasasPor100g = const Value.absent(),
                Value<DateTime> cacheadoEn = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProductsCompanion(
                barcode: barcode,
                nombre: nombre,
                caloriasPor100g: caloriasPor100g,
                proteinasPor100g: proteinasPor100g,
                carbohidratosPor100g: carbohidratosPor100g,
                grasasPor100g: grasasPor100g,
                cacheadoEn: cacheadoEn,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String barcode,
                required String nombre,
                required double caloriasPor100g,
                Value<double> proteinasPor100g = const Value.absent(),
                Value<double> carbohidratosPor100g = const Value.absent(),
                Value<double> grasasPor100g = const Value.absent(),
                Value<DateTime> cacheadoEn = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProductsCompanion.insert(
                barcode: barcode,
                nombre: nombre,
                caloriasPor100g: caloriasPor100g,
                proteinasPor100g: proteinasPor100g,
                carbohidratosPor100g: carbohidratosPor100g,
                grasasPor100g: grasasPor100g,
                cacheadoEn: cacheadoEn,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProductsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProductsTable,
      Product,
      $$ProductsTableFilterComposer,
      $$ProductsTableOrderingComposer,
      $$ProductsTableAnnotationComposer,
      $$ProductsTableCreateCompanionBuilder,
      $$ProductsTableUpdateCompanionBuilder,
      (Product, BaseReferences<_$AppDatabase, $ProductsTable, Product>),
      Product,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UserProfilesTableTableManager get userProfiles =>
      $$UserProfilesTableTableManager(_db, _db.userProfiles);
  $$FoodEntriesTableTableManager get foodEntries =>
      $$FoodEntriesTableTableManager(_db, _db.foodEntries);
  $$ExerciseEntriesTableTableManager get exerciseEntries =>
      $$ExerciseEntriesTableTableManager(_db, _db.exerciseEntries);
  $$SleepEntriesTableTableManager get sleepEntries =>
      $$SleepEntriesTableTableManager(_db, _db.sleepEntries);
  $$WaterEntriesTableTableManager get waterEntries =>
      $$WaterEntriesTableTableManager(_db, _db.waterEntries);
  $$WeightEntriesTableTableManager get weightEntries =>
      $$WeightEntriesTableTableManager(_db, _db.weightEntries);
  $$ProductsTableTableManager get products =>
      $$ProductsTableTableManager(_db, _db.products);
}
