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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                dateFormatter.format(request.createdAt!),
                style: cardNameStyle,
              ),
              if (request.requestStatus != null)
                Text(
                  request.requestStatus!.title,
                  style: cardNameStyle.merge(
                    TextStyle(color: request.requestStatus!.color),
                  ),
                ),
            ],
          ),
          _buildCardText(Icons.announcement, request.subject),
          _buildCardText(Icons.person, request.toPersonName()),
          _buildCardText(Icons.location_on, request.address.toString()),
        ],
      ),
    );
  }

  Widget _buildCardText(IconData icon, String string) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.grey[800]),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            string,
            style: cardTextStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
