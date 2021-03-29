import 'package:flutter/foundation.dart';
import 'package:housing/data/repository/request_repository.dart';
import 'package:housing/data/repository/request_status_repository.dart';
import 'package:housing/data/res/mocks.dart';
import 'package:housing/data/res/properties.dart';
import 'package:housing/domain/client.dart';
import 'package:housing/domain/request.dart';
import 'package:housing/domain/request_status.dart';

class RequestService with ChangeNotifier {
  RequestRepository _requestRepository = RequestRepository();
  RequestStatusRepository _requestStatusRepository = RequestStatusRepository();
  bool _isStatusesLoaded = false;
  bool isAllLoaded = false;
  late Client _currentClient;
  late List<Request> requests;
  late List<RequestStatus> requestStatuses;

  // Получить список заявок
  Future<String> getRequests(Client client) async {
    _currentClient = client;

    if (!_isStatusesLoaded) {
      String returnedStatus = await _getRequestStatuses();
      if (returnedStatus.isNotEmpty) return returnedStatus;
    }

    if (_currentClient.isDemo) {
      requests = List.from(demoRequests);
    } else {
      dynamic returned = await _requestRepository.getRequests(_currentClient.token!);
      if (returned is Iterable<Request>) {
        requests = List.from(returned);
      } else {
        return returned;
      }
    }
    _fillRequestStatuses(requestStatuses);
    isAllLoaded = true;
    notifyListeners();
    return '';
  }

  // Создать новую заявку
  Future<String> addNewRequest(Request request) async {

    requests.add(request);
    notifyListeners();

    if (_currentClient.isDemo) {
      requests[requests.length - 1].id = requests[requests.length - 2].id! + 1;
      return '';
    } else {
      dynamic returned = await _requestRepository.postRequest(_currentClient.token!, request);
      if (returned is Request) {
        requests[requests.length - 1].id = returned.id;
        requests[requests.length - 1].status = returned.status!;
        requests[requests.length - 1].requestStatus = _findRequestStatus(returned.status!);
        requests[requests.length - 1].address.id = returned.address.id;
        return '';
      } else {
        return returned;
      }
    }
  }

  // Получить список статусов заявок
  Future<String> _getRequestStatuses() async {
    if (_currentClient.isDemo) {
      requestStatuses = List.from(demoStatuses);
    } else {
      dynamic returned = await _requestStatusRepository.getRequestStatusesRequest(_currentClient.token!);
      if (returned is Iterable<RequestStatus>) {
        requestStatuses = List.from(returned);
      } else {
        return returned;
      }
    }
    _fillColors();
    _isStatusesLoaded = true;
    return '';
  }

  // С бэка приходят только ID статусов заявок, сопоставим с классом RequestStatus...
  void _fillRequestStatuses(List<RequestStatus> requestStatuses) {
    requests.forEach((r) => r.requestStatus = _findRequestStatus(r.status!));
  }

  // Ищем по статусу заявки (int) статус заявки (RequestStatus)
  RequestStatus? _findRequestStatus(int status) {
    RequestStatus? requestStatus;
    requestStatuses.forEach((s) {
      if (status == s.id) {
        requestStatus = s;
      }
    });
    return requestStatus;
  }

  // С бэка приходят статусы заявок без цветов, заполняем сами
  void _fillColors() {
    requestStatuses.forEach((r) {
      matchOfColors.entries.forEach((c) {
        if (r.title.toLowerCase().contains(c.key)) {
          r.color = c.value;
        }
      });
    });
  }
}