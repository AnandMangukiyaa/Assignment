part of 'app_dialogs.dart';

class _GenderPicker extends StatefulWidget {
  final List<String> genders = ["Male","Female"];

   _GenderPicker({Key? key}) : super(key: key);

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
        return _GenderPicker();
      },
    );
  }

  @override
  State<_GenderPicker> createState() => _GenderPickerState();
}

class _GenderPickerState extends State<_GenderPicker> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenUtil().screenHeight * 0.6,
      child: Column(
        children: [
          const DialogHeader(title: 'Select Gender'),
          Expanded(
            child: ListView.builder(
              itemCount: widget.genders.length,
              itemBuilder: (context, index) {
                var state = widget.genders[index];
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
