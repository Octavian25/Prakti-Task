import 'package:mockito/annotations.dart';
import 'package:praktitask/home/data/datasource/home_local_datasource.dart';
import 'package:praktitask/home/data/datasource/home_remote_datasource.dart';
import 'package:praktitask/home/domain/repository/repository.dart';
import 'package:praktitask/search/data/datasource/search_local_datasource.dart';
import 'package:praktitask/search/domain/repository/repository.dart';
import 'package:praktitask/utility/database.dart';

@GenerateMocks([
  HomeLocalDataSource,
  HomeRemoteDataSource,
  HomeRepository,
  SearchRepository,
  SearchLocalDataSource,
  DatabaseHelper
], customMocks: [])
void main() {}
