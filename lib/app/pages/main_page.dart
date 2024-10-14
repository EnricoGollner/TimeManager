import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:working_time_manager/app/data/models/register.dart';
import 'package:working_time_manager/app/controller/working_time_controller.dart';
import 'package:working_time_manager/app/pages/register_info_page.dart';
import 'package:working_time_manager/app/pages/widgets/time_register_modal.dart';
import 'package:working_time_manager/app/shared/components/custom_drawer.dart';
import 'package:working_time_manager/app/shared/components/register_tile.dart';
import 'package:working_time_manager/app/shared/util/formatter.dart';
import 'package:working_time_manager/core/theme/fonts.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async => await _getRegisters());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final WorkingTimeController controller = context.watch<WorkingTimeController>();
    List<Register> timeRegistersList = controller.registers;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: Text(
              'Registers',
              style: appBarTitleStyle(context)
            ),
      ),
      drawer: const CustomDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: timeRegistersList.length,
              itemBuilder: (context, index) {
                final time = timeRegistersList[index];
                return TiemRegisterTile(
                  text: '${time.company} - ${Formatter.monthYear(time.monthYear)}',
                  onTap: () => _openRegister(time),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Theme.of(context).colorScheme.primary,
        onPressed: _registerNewTime,
        label: Text(
          'New Dashboard',
          style: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
        ),
        icon: Icon(
          Icons.more_time,
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
    );
  }

  void _registerNewTime() {
    showDialog(
      context: context,
      builder: (context) {
        return const TimeRegisterModal();
      },
    );
  }

  Future<void> _getRegisters() async {
    await context.read<WorkingTimeController>().getTimeRegisters();
  }

  void _openRegister(Register register) {
    context.read<WorkingTimeController>().selectRegister(register);
    Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterInfoPage()));
  }
}
