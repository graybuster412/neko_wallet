import 'package:neko_wallet/extensions/hex_color.dart';
import 'package:neko_wallet/models/contact_model.dart';
import 'package:neko_wallet/shared/shared.dart';
import 'package:neko_wallet/widgets/button_primary.dart';
import 'package:neko_wallet/widgets/contact_list.dart';
import 'package:neko_wallet/widgets/header_ct.dart';
import 'package:neko_wallet/widgets/search_input.dart';
import 'package:flutter/material.dart';

class NewIncome extends StatefulWidget {
  const NewIncome({Key? key}) : super(key: key);

  @override
  _NewIncomeState createState() => _NewIncomeState();
}

class _NewIncomeState extends State<NewIncome> {
  Contact? _selectedContact = null;

  List<Contact> _contactList = [
    Contact(
        id: 1,
        name: 'King M’baku',
        isSelected: false,
        imageURL: 'assets/images/steven.jpg'),
    Contact(id: 2, name: 'Prince T’Challa', imageURL: null, isSelected: false),
    Contact(id: 3, name: 'Prince T’Challa', imageURL: null, isSelected: false),
    Contact(id: 4, name: 'Prince T’Challa', imageURL: null, isSelected: false),
    Contact(id: 5, name: 'Prince T’Challa', imageURL: null, isSelected: false)
  ];

  List<Contact> _searchResults = [];

  List<Contact> _recentContacts = [
    Contact(
        id: 1,
        name: 'King M’baku',
        isSelected: false,
        imageURL: 'assets/images/steven.jpg'),
    Contact(id: 2, name: 'Prince T’Challa', imageURL: null, isSelected: false),
  ];

  TextEditingController _textEditingController = TextEditingController();

  bool _isHiddenRecentContacts = false;

  @override
  void initState() {
    super.initState();
    _isHiddenRecentContacts = false;
  }

  _onPressContact(Contact contact, List<Contact> contactList) {
    FocusScope.of(context).unfocus();

    _isHiddenRecentContacts =
        contactList == _contactList || contactList == _searchResults;

    _selectedContact = contact;

    contactList.forEach((c) {
      c.isSelected = contact.id == c.id;
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        height: MediaQuery.of(context).size.height, // <---- changed
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: AppColors.gray4,
            borderRadius: BorderRadius.all(Radius.circular(16.0))),
        margin:
            EdgeInsets.only(left: 20.0, right: 20.0, bottom: 40.0, top: 75.0),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              HeaderCT(
                  title: 'Send money to',
                  iconSize: 30,
                  titleStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Poppins',
                    color: HexColor.fromHex('#353333'),
                  ),
                  onPressIcon: () => Navigator.pop(context),
                  rightIcon: AppSvgs.cancel),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: SearchInput(
                    controller: _textEditingController,
                    placeholder: 'Search contact',
                    onChangeText: (value) {
                      _contactList.forEach((contact) {
                        if ((contact.name != null &&
                                contact.name!.contains(value.trim())) ||
                            (contact.email != null &&
                                contact.email!.contains(value.trim()))) {
                          _searchResults.add(contact);
                        }
                      });

                      setState(() {});
                    }),
              ),
              !_isHiddenRecentContacts
                  ? ContactList(
                      title: 'Recent Contacts',
                      isScrollable: false,
                      onPressContact: (contact) =>
                          _onPressContact(contact, _recentContacts),
                      data: _recentContacts,
                    )
                  : Container(),
              SizedBox(height: 12.0),
              Expanded(
                  child: _searchResults.length != 0 ||
                          _textEditingController.text.isNotEmpty
                      ? ContactList(
                          title: 'All contacts',
                          onPressContact: (contact) =>
                              _onPressContact(contact, _searchResults),
                          data: _searchResults,
                        )
                      : ContactList(
                          title: 'All contacts',
                          onPressContact: (contact) =>
                              _onPressContact(contact, _contactList),
                          data: _contactList,
                        )),
              SizedBox(height: 12.0),
              ButtonCT(
                onPressButton: () {},
                title: 'Continue',
                buttonStyle: ButtonCTStyle(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  buttonColor: Colors.white,
                  titleColor: Colors.white,
                  borderColor: Colors.transparent,
                  radius: 8,
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.2, 0.9],
                      colors: [
                        HexColor.fromHex('#9DEB93'),
                        AppColors.blue1,
                      ],
                      tileMode: TileMode.clamp),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
