import '../datasource/search_local_datasource.dart';
import '../datasource/search_remote_datasource.dart';
import '../../domain/repository/repository.dart';
class SearchRepositoryImpl implements SearchRepository {
SearchLocalDataSource searchLocalDataSource;
SearchRemoteDataSource searchRemoteDataSource;
SearchRepositoryImpl(this.searchLocalDataSource, this.searchRemoteDataSource);
}