import 'package:flutter/material.dart';
import 'package:housing/domain/request.dart';
import 'package:housing/ui/res/styles.dart';

class RequestCard extends StatelessWidget {
  final Request request;
  final int index;
  final Function callBack;
  final bool isOpened;

  RequestCard(this.request, this.index, this.callBack, this.isOpened);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => isOpened ? callBack(null) : callBack(index),
      style: counterCardStyle,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
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
            if (isOpened) _buildCardText(Icons.location_on, request.address.toString()),
            if (isOpened) _buildCardText(Icons.person, request.toPersonName()),
            if (isOpened) _buildCardText(Icons.phone, request.phone),
            if (isOpened && request.email != null && request.email!.isNotEmpty) _buildCardText(Icons.email, request.email!),
            if (isOpened) _buildCardText(Icons.text_snippet, request.text),
          ],
        ),
      ),
    );
  }

  Widget _buildCardText(IconData icon, String string) {
    return Row(
      children: [
        Icon(icon, size: 15, color: Colors.grey[800]),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            string,
            style: cardTextStyle,
          ),
        ),
      ],
    );
  }
}
