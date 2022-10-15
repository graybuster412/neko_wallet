import 'package:neko_wallet/models/contact_model.dart';
import 'package:flutter/material.dart';
import 'package:neko_wallet/shared/shared.dart';
import 'package:neko_wallet/widgets/style_text.dart';

class ContactListItem extends StatefulWidget {
  const ContactListItem({Key? key, required this.contact, this.onPress})
      : super(key: key);

  @required
  final Contact contact;

  @required
  final ValueChanged<Contact>? onPress;

  @override
  _ContactListItemState createState() => _ContactListItemState();
}

class _ContactListItemState extends State<ContactListItem>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: false);

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );

    _controller.forward();

    super.initState();
  }

  @override
  void didUpdateWidget(covariant ContactListItem oldWidget) {
    if (oldWidget.contact.isSelected != this.widget.contact.isSelected) {
      if (this.widget.contact.isSelected) {
        _controller.forward();
      } else if (this.widget.contact.isSelected) {
        _controller.reverse();
      }
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkResponse(
        containedInkWell: true,
        onTap: () => this.widget.onPress != null
            ? this.widget.onPress!(this.widget.contact)
            : () {},
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(mainAxisSize: MainAxisSize.min, children: [
                this.widget.contact.imageUrl?.isNotEmpty == true
                    ? Container(
                        height: 40,
                        width: 40,
                        child: CircleAvatar(
                          radius: 20,
                          backgroundImage:
                              AssetImage(this.widget.contact.imageUrl!),
                        ),
                      )
                    : Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                stops: [0.2, 0.9],
                                colors: [
                                  AppColors.primary,
                                  AppColors.blue1,
                                ],
                                tileMode: TileMode.clamp),
                            borderRadius: BorderRadius.circular(40 / 2)),
                        child: Center(
                            child: StyleText(
                          text: this
                                  .widget
                                  .contact
                                  .firstLetterOfName
                                  ?.toUpperCase() ??
                              '',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          textColor: AppColors.text,
                        ))),
                SizedBox(width: 20.0),
                this.widget.contact.name != null
                    ? StyleText(
                        text: this.widget.contact.name!,
                        fontSize: 14,
                      )
                    : Container(),
              ]),
              this.widget.contact.isSelected
                  ? ScaleTransition(
                      scale: _animation,
                      child: Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Container(
                            height: 34,
                            width: 34,
                            child: CommonWidget.svgImage('ic_correct')),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
