import '../datasource/onboard_local_datasource.dart';
import '../datasource/onboard_remote_datasource.dart';
import '../../domain/repository/repository.dart';
class OnboardRepositoryImpl implements OnboardRepository {
OnboardLocalDataSource onboardLocalDataSource;
OnboardRemoteDataSource onboardRemoteDataSource;
OnboardRepositoryImpl(this.onboardLocalDataSource, this.onboardRemoteDataSource);
}