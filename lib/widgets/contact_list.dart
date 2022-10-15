import 'package:neko_wallet/extensions/hex_color.dart';
import 'package:neko_wallet/models/contact_model.dart';
import 'package:flutter/material.dart';
import 'package:neko_wallet/widgets/style_text.dart';

import '../shared/shared.dart';
import 'list_item/contact_list_item.dart';

class ContactList extends StatelessWidget {
  ContactList(
      {Key? key,
      this.data: const [],
      required this.title,
      required this.onPressContact,
      this.isScrollable = true})
      : super(key: key);

  @required
  final String title;

  @required
  final List<Contact> data;

  @required
  final ValueChanged<Contact> onPressContact;

  final bool isScrollable;

  _buildListItem(int index, Contact contact) {
    return ContactListItem(
        key: Key('$index${contact.id}'),
        contact: contact,
        onPress: onPressContact);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StyleText(
          text: title,
          fontSize: CommonConstants.text16,
          fontWeight: FontWeight.w500,
          textColor: HexColor.fromHex('#353333'),
        ),
        SizedBox(height: 12.0),
        Container(
          constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height > 700
                  ? double.infinity
                  : 120),
          child: ListView.builder(
              shrinkWrap: true,
              physics: isScrollable ? null : NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: data.length,
              itemBuilder: (context, int index) =>
                  _buildListItem(index, data[index])),
        ),
      ],
    );
  }
}
