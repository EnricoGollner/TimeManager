import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:working_time_manager/app/data/models/register.dart';
import 'package:working_time_manager/app/controller/register_controller.dart';
import 'package:working_time_manager/app/pages/register_info_page.dart';
import 'package:working_time_manager/app/pages/widgets/register_modal.dart';
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
  late RegisterController controller;
  
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async => await _getRegisters());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    controller = context.watch<RegisterController>();
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
                final Register register = timeRegistersList[index];
                return TiemRegisterTile(
                  text: '${register.company} - ${Formatter.monthYear(register.monthYear)}',
                  onTap: () {
                    controller.selectRegister(register);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterInfoPage()));
                  },
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
          style: fabStyle(context),
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
        return const RegisterModal();
      },
    );
  }

  Future<void> _getRegisters() async => await context.read<RegisterController>().getRegisters();
}
