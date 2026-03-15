import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

part 'send_message_state.dart';

class SendMessageCubit extends Cubit<SendMessageState> {
  SendMessageCubit() : super(SendMessageInitial());

  Future<void> sendMessage({
    required String message,
    required String user,
  }) async {
    emit(SendMessageLoading());
    try {
      await FirebaseFirestore.instance.collection('messages').add({
        'message': message,
        'time': FieldValue.serverTimestamp(),
        'user': user,
      });
      emit(SendMessageSuccess());
    } catch (e) {
      emit(SendMessageFailure(error: e.toString()));
    }
  }
}
