import 'package:liulo/models/loading.dart';

class AddLoadingAction {
  final Loading loading;

  AddLoadingAction(this.loading);
}

class UpdateLoadingAction {
  final Loading loading;

  UpdateLoadingAction(this.loading);
}

class DeleteLoadingAction {
  final int id;

  DeleteLoadingAction(this.id);
}
