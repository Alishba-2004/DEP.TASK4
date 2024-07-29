import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('expenses.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const doubleType = 'REAL NOT NULL';

    await db.execute('''
CREATE TABLE expenses ( 
  ${ExpenseFields.id} $idType, 
  ${ExpenseFields.category} $textType,
  ${ExpenseFields.description} $textType,
  ${ExpenseFields.amount} $doubleType,
  ${ExpenseFields.type} $textType
  )
''');
  }

  Future<int> insertExpense(Map<String, dynamic> expense) async {
    final db = await instance.database;
    return await db.insert('expenses', expense);
  }
}

class ExpenseFields {
  static final List<String> values = [
    id, category, description, amount, type
  ];

  static const String id = '_id';
  static const String category = 'category';
  static const String description = 'description';
  static const String amount = 'amount';
  static const String type = 'type';
}