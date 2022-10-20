// ignore_for_file: avoid_print

import 'package:get/instance_manager.dart';
import 'package:graphql/client.dart';

import '../../core/graphql/graph.core.dart';
import '../../core/network/app_response.dart';
import '../../models/contact/contact.model.dart';
import '../../models/paginator.model.dart';

part 'playground.dart';

class ContactRepository {
  ContactRepository._();
  factory ContactRepository() => Get.put(ContactRepository._());
  final _playground = _Playground();
  GraphCore get _core => GraphCore.instance;

  Future<AppResponse<PaginatorModel<ContactModel>?>> contacts({
    int? page,
    int? perPage,
    String? text,
  }) async {
    final options = QueryOptions(
      document: gql(_playground.contacts),
      variables: {'page': page, 'perPage': perPage, 'text': text},
    );

    final response = await _core.request(options);
    if (response.success) {
      try {
        return AppResponse(
          data: PaginatorModel.fromMap(
            response.data['contacts'],
            ContactModel.fromNetwork,
          ),
          success: true,
        );
      } catch (err) {
        print(err);
      }
    }
    return response.newGeneric(data: null, success: false);
  }

  Future<AppResponse<ContactModel?>> contact(String id) async {
    final options = QueryOptions(
      document: gql(_playground.contact),
      variables: {'id': id},
    );

    final response = await _core.request(options);
    if (response.success) {
      try {
        return AppResponse(
          data: ContactModel.fromNetwork(response.data['contact']),
          success: true,
        );
      } catch (err) {
        print(err);
      }
    }
    return response.newGeneric(data: null, success: false);
  }

  Future<AppResponse<ContactModel?>> addContact(String userId) async {
    final options = MutationOptions(
      document: gql(_playground.addContact),
      variables: {'userId': userId},
    );

    final response = await _core.request(options);
    if (response.success) {
      try {
        return AppResponse(
          data: ContactModel.fromNetwork(response.data['addContact']),
          success: true,
        );
      } catch (err) {
        print(err);
      }
    }
    return response.newGeneric(data: null, success: false);
  }
}
