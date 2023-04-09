import 'package:flutter/material.dart';
import '../../shared/components/colors.dart';

class DrawerItem extends StatelessWidget{
  List<Map<String,dynamic>> drawerData = [
    {
      'title' : 'خدماتي',
      'iconData' : Icons.home,
      'routeName' : 'dashboard_screen'
    },
    {
      'title' : 'الفعاليات',
      'iconData' : Icons.event_available_sharp,
      'routeName' : 'view_Events'
    },
    {
      'title' : 'الأندية',
      'iconData' : Icons.view_agenda,
      'routeName' : 'view_Clubs'
    },
  ];

  DrawerItem({super.key});
  @override
  Widget build(BuildContext context) => Drawer(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          const UserAccountsDrawerHeader(
            decoration: BoxDecoration(
                color: mainColor
            ),
            accountName: Text("محمد هاشم"),
            accountEmail: Text("mohamedhashimrezk73@gmail.com"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person,color: Colors.black,),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: drawerData.length,
                itemBuilder: (context,index){
                  return ListTile(
                    onTap: ()
                    {
                      Navigator.pushNamed(context, drawerData[index]['routeName']);
                    },
                    leading: Text(drawerData[index]['title']),
                    trailing: Icon(drawerData[index]['iconData']),
                  );
                }
            ),
          )
        ],
      )
  );
}