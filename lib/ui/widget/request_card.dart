import 'package:flutter/material.dart';
import 'package:housing/data/provider/is_web.dart';
import 'package:housing/domain/request.dart';
import 'package:housing/ui/res/styles.dart';
import 'package:housing/ui/screen/request_details.dart';
import 'package:housing/ui/screen/web_wrapper.dart';
import 'package:provider/provider.dart';

class RequestCard extends StatelessWidget {
  final Request request;

  RequestCard(this.request);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) =>
                  context.read<Web>().isWeb ? WebWrapper(RequestDetails(request)) : RequestDetails(request))),
      style: counterCardStyle,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  dateFormatter.format(request.createdAt!),
                  style: cardNameStyle,
                ),
              ),
              if (request.requestStatus != null) Flexible(
                child: Text(
                  request.requestStatus!.title,
                  style: cardNameStyle.merge(
                    TextStyle(color: request.requestStatus!.color),
                  ),
                ),
              ),
            ],
          ),
          _buildCardText(request.subject),
          _buildCardText(
              '${request.surname} ${request.name}${request.patronymic != null ? ' ' + request.patronymic! : ''}'),
          _buildCardText(request.address.toString()),
        ],
      ),
    );
  }

  Text _buildCardText(String string) {
    return Text(
      string,
      style: cardTextStyle,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
