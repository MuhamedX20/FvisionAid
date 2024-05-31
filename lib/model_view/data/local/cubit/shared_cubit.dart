import 'package:flutter_bloc/flutter_bloc.dart';

import '../../network/dio_custom.dart';
import '../../network/endpoints.dart';
import '../shared_custom.dart';
import '../sharedkeys.dart';

part 'shared_state.dart';

class SharedCubit extends Cubit<SharedState> {
  SharedCubit() : super(SharedInitial());

  static SharedCubit get(context) => BlocProvider.of(context);

  Future<void> SharedHelp()async{
    emit(LoadingSharedInitial());
    await DioHelper.post(
      endpoint: EndPoint.moneyapi,

    ).then((value)async {
      await ShardHelper.set(key: SharedKeys.token, value: value?.data["data"]["token"]);
      await ShardHelper.set(key: SharedKeys.userId, value: value?.data["data"]["user"]["id"]);
      await ShardHelper.set(key: SharedKeys.username, value: value?.data["data"]["user"]["name"]);
      await ShardHelper.set(key: SharedKeys.useremail, value: value?.data["data"]["user"]["email"]);
      emit(SuccessSharedInitial());
    }).catchError((Error)
    {
      emit(FailSharedInitial());
      throw Error;
    }
    );

}
}