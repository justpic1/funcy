import 'package:flutter/material.dart';
import 'package:functional_spreadsheet/main_objects/main_pages.dart';
import 'package:functional_spreadsheet/popups/menu.dart';
import 'package:functional_spreadsheet/theme.dart';
import 'package:functional_spreadsheet/main_objects/select.dart';
class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context){
    MyTheme currentTheme = MyTheme.getCurrentTheme();
    return Scaffold(
      appBar: appBar(),
      body: body(),
      backgroundColor: currentTheme.mainBg,
    );
  }
  Column body(){
    return Column(children: [
      const SizedBox(height: 50,),
      select(),
      const SizedBox(height: 100,),
      
      const MainPages()
    ],);
  }
  Row select(){
    Select home = const Select(
      title: "Home",
      iconPath: "icons/house.svg", 
      colorFilter: ColorFilter.mode(Colors.brown, BlendMode.srcIn),
      selected: true,
      );
    Select home2 = const Select(
      title: "Open",
      iconPath: "icons/file.svg", 
      colorFilter: ColorFilter.mode(Colors.orange, BlendMode.srcIn)
    );
    Select home3 = const Select(
      title: "New",
      iconPath: "icons/box.svg", 
      colorFilter: ColorFilter.mode(Color.fromARGB(255, 79, 113, 150), BlendMode.srcIn)
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(flex: 2,),
        home,
        const Spacer(flex: 1,),
        home2,
        const Spacer(flex: 1,),
        home3,
        const Spacer(flex: 2,),
      ],
      
    );
  }
  AppBar appBar() {
    MyTheme currentTheme = MyTheme.getCurrentTheme();
    return AppBar(
      leading: const Row(children: [
        Menu(),
      ],),
      centerTitle: true,
      title: Text(
        'Func(y)',
        
        style: TextStyle(
          color: currentTheme.textColor,
          fontSize: 12,
          fontWeight: FontWeight.bold
        ),
      ),
      backgroundColor: currentTheme.colorAppBar,
      toolbarHeight: 20,
      
    );
  }
}