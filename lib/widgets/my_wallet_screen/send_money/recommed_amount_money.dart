import 'package:neko_wallet/widgets/list_item/amount_list_item.dart';
import 'package:flutter/material.dart';

class RecommendAmountMoney extends StatefulWidget {
  RecommendAmountMoney({Key? key, this.data: const [], this.onPressRecommended})
      : super(key: key);

  @required
  final List<int> data;

  @required
  final ValueChanged<int>? onPressRecommended;

  @override
  _RecommendAmountMoneyState createState() => _RecommendAmountMoneyState();
}

class _RecommendAmountMoneyState extends State<RecommendAmountMoney> {
  _buildListItem(int index, int amount) {
    return AmountListItem(
        key: Key('$index${amount}'),
        value: this.widget.data[index],
        data: this.widget.data,
        onPress: () =>
            this.widget.onPressRecommended!(this.widget.data[index]));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: (MediaQuery.of(context).size.width - 120) / 1.5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: this.widget.data.length,
              itemBuilder: (context, int index) =>
                  _buildListItem(index, this.widget.data[index])),
        ],
      ),
    );
  }
}
