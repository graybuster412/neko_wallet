import 'package:get/get.dart';
import 'package:neko_wallet/extensions/hex_color.dart';
import 'package:neko_wallet/models/contact_model.dart';
import 'package:neko_wallet/shared/shared.dart';
import 'package:neko_wallet/theme/fonts.dart';
import 'package:neko_wallet/widgets/button_primary.dart';
import 'package:neko_wallet/widgets/contact_list.dart';
import 'package:neko_wallet/widgets/header_ct.dart';
import 'package:neko_wallet/widgets/my_wallet_screen/send_money/payment_receipt.dart';
import 'package:neko_wallet/widgets/my_wallet_screen/send_money/send_money_amount.dart';
import 'package:neko_wallet/widgets/my_wallet_screen/send_money/sent_money_successfully.dart';
import 'package:neko_wallet/widgets/search_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

enum SendMoneyState {
  selectContact,
  inputAmount,
  sentMoney,
  receipt,
}

class SendMoney extends StatefulWidget {
  const SendMoney({Key? key}) : super(key: key);

  @override
  _SendMoneyState createState() => _SendMoneyState();
}

class _SendMoneyState extends State<SendMoney> {
  Contact? _selectedContact = null;

  SendMoneyState _state = SendMoneyState.selectContact;

  List<Contact> _contactList = [];

  List<Contact> _searchResults = [];

  List<Contact> _recentContacts = [];

  TextEditingController _textEditingController = TextEditingController();

  bool _isHiddenRecentContacts = false;

  @override
  void initState() {
    _recentContacts = [
      Contact(
          id: 1,
          name: 'King M’baku',
          isSelected: false,
          imageURL: 'assets/images/steven.jpg'),
      Contact(
          id: 2, name: 'Prince T’Challa', imageURL: null, isSelected: false),
    ];

    _contactList = [
      Contact(
          id: 1,
          name: 'King M’baku',
          isSelected: false,
          imageURL: 'assets/images/steven.jpg'),
      Contact(id: 2, name: 'Prince T’Chal', imageURL: null, isSelected: false),
      Contact(id: 3, name: 'R’Challa', imageURL: null, isSelected: false),
      Contact(id: 4, name: 'Rhalla', imageURL: null, isSelected: false),
      Contact(id: 5, name: 'Talla', imageURL: null, isSelected: false)
    ];

    super.initState();
  }

  _onPressContact(Contact contact, List<Contact> contactList) {
    FocusScope.of(context).unfocus();

    _isHiddenRecentContacts =
        contactList == _contactList || contactList == _searchResults;

    _selectedContact = contact;

    contactList.forEach((c) {
      c.isSelected = contact.id == c.id;
    });

    Future.delayed(Duration(milliseconds: 1000), () {
      // Wait until checked animation ended
      _state = SendMoneyState.inputAmount;

      setState(() {});
    });
  }

  _onChangeState(SendMoneyState state) {
    _state = state;

    setState(() {});
  }

  Widget _renderSendMoney() {
    switch (_state) {
      case SendMoneyState.receipt:
        return PaymentReceipt(selectedContact: _selectedContact);
      case SendMoneyState.sentMoney:
        return SentMoneySuccessfully(onChangeState: _onChangeState);
      case SendMoneyState.inputAmount:
        return SendMoneyAmount(
            selectedContact: _selectedContact, onChangeState: _onChangeState);
      case SendMoneyState.selectContact:
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            decoration: BoxDecoration(
                color: AppColors.gray4,
                borderRadius: BorderRadius.all(Radius.circular(16.0))),
            margin: EdgeInsets.only(
                left: 20.0, right: 20.0, bottom: 40.0, top: 75.0),
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  HeaderCT(
                      title: 'send_money_to'.tr,
                      iconSize: 30,
                      titleStyle: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        fontFamily: AppFonts.primary,
                        color: HexColor.fromHex('#353333'),
                      ),
                      onPressIcon: () => Get.back(),
                      rightIcon: AppSvgs.cancel),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: SearchInput(
                        controller: _textEditingController,
                        placeholder: 'search_contact'.tr,
                        onChangeText: (value) {
                          if (value.trim().isNotEmpty) {
                            _searchResults = _contactList
                                .where((c) =>
                                    (c.name != null &&
                                        c.name!.contains(value.trim())) ||
                                    (c.email != null &&
                                        c.email!.contains(value.trim())))
                                .toList();
                          } else {
                            _searchResults.forEach((element) {
                              _searchResults.remove(element);
                            });
                          }

                          setState(() {});
                        }),
                  ),
                  !_isHiddenRecentContacts
                      ? ContactList(
                          title: 'recent_contacts'.tr,
                          isScrollable: false,
                          onPressContact: (contact) =>
                              _onPressContact(contact, _recentContacts),
                          data: _recentContacts,
                        )
                      : Container(),
                  SizedBox(height: 12.0),
                  Expanded(
                      child: _searchResults.isNotEmpty ||
                              _textEditingController.text.isNotEmpty
                          ? ContactList(
                              title: 'all_contacts'.tr,
                              onPressContact: (contact) =>
                                  _onPressContact(contact, _searchResults),
                              data: _searchResults,
                            )
                          : ContactList(
                              title: 'all_contacts'.tr,
                              onPressContact: (contact) =>
                                  _onPressContact(contact, _contactList),
                              data: _contactList,
                            )),
                  // SizedBox(height: 12.0),
                  ButtonCT(
                    onPressButton: () {},
                    title: 'continue'.tr,
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
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return _renderSendMoney();
  }
}
