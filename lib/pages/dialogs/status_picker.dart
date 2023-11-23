part of 'app_dialogs.dart';

class _StatusPicker extends StatefulWidget {
  final List<String> status = ["Active","Inactive"];

   _StatusPicker({Key? key}) : super(key: key);

  static Future<String?> showSheet(
      BuildContext context) async {
    return await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      elevation: 0,
      backgroundColor: Colors.white,
      barrierColor: Colors.black.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kDialogBorderRadius),
      ),
      builder: (context) {
        return _StatusPicker();
      },
    );
  }

  @override
  State<_StatusPicker> createState() => _StatusPickerState();
}

class _StatusPickerState extends State<_StatusPicker> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenUtil().screenHeight * 0.6,
      child: Column(
        children: [
          const DialogHeader(title: 'Select City'),
          Expanded(
            child: ListView.builder(
              itemCount: widget.status.length,
              itemBuilder: (context, index) {
                var state = widget.status[index];
                return ListTile(
                  title: Text(state ?? ''),
                  onTap: () {
                    Navigator.pop(context, state.toLowerCase());
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
