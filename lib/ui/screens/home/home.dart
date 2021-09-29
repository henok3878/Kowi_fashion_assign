import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kowi_fashion/models/client.dart';
import 'package:kowi_fashion/ui/screens/home/components/client_profile.dart';
import 'package:kowi_fashion/utils/custom_colors.dart';
import 'package:responsive_grid/responsive_grid.dart';

import 'components/circular_avator.dart';

class Home extends StatelessWidget {
  final imageLink = "https://images.generated.photos/oYMWf2yqFM2yG3_PKN0iXwfNVfNQ86QjQJPmYOxhInE/rs:fit:256:256/czM6Ly9pY29uczgu/Z3Bob3Rvcy1wcm9k/LnBob3Rvcy92M18w/MDA2NjkxLmpwZw.jpg";
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title:  CircularAvatar(height: 42, width: 42, image: "https://images.generated.photos/oYMWf2yqFM2yG3_PKN0iXwfNVfNQ86QjQJPmYOxhInE/rs:fit:256:256/czM6Ly9pY29uczgu/Z3Bob3Rvcy1wcm9k/LnBob3Rvcy92M18w/MDA2NjkxLmpwZw.jpg"),
        actions: [
          buildButtonFromSvg(onPressed: ()=>{}, svgName: "notification.svg"),
    ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
            buildTitleSection(),
            SizedBox(height: 16),
            buildAppointmentSection(),
            buildNewClientSection(),
            buildClientList(),
            buildClientList(),
        ]
      ),
    );
  }
  Widget buildAppBar(){
    return Container(
     height: 64,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircularAvatar(height: 42, width: 42, image: "https://images.generated.photos/oYMWf2yqFM2yG3_PKN0iXwfNVfNQ86QjQJPmYOxhInE/rs:fit:256:256/czM6Ly9pY29uczgu/Z3Bob3Rvcy1wcm9k/LnBob3Rvcy92M18w/MDA2NjkxLmpwZw.jpg"),
          buildButtonFromSvg(onPressed: ()=>{}, svgName: "Share.svg"),

        ],
      ),
    );
  }

  Widget buildTitleSection(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Good Morning, Nikhil", style: GoogleFonts.quicksand(
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w700,
          fontSize: 20,

        ),),
        Row(children: [
          SvgPicture.asset('assets/Resume.svg',width: 20,height: 18,
              semanticsLabel: 'Resume Logo'),
          Text("NASM Certified Nutrition Coach", style: GoogleFonts.quicksand(
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),)
        ],)
      ],
    );
  }

  Widget buildAppointmentSection(){
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Upcoming Appointment",style: GoogleFonts.quicksand(
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.w500,
              fontSize: 18,

            ),),
            buildButtonFromSvg(svgName: "Meeting Room.svg", onPressed: ()=>{})
          ],
        ),
        Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    buildButtonFromSvg(svgName: "Person.svg", onPressed: ()=>{}),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Ashok Join", style: GoogleFonts.quicksand(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),),
                        Text("Client || Video Call || 12:30PM", style: GoogleFonts.quicksand(
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w500,
                          fontSize: 9,
                        ),)
                      ],
                    ),
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: KowiColours.mainColor
                  ),
                  onPressed: ()=>{}, child: Text("Join", style: GoogleFonts.quicksand(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),))
              ],
            ),
          ),
        )
      ]
    );
  }
  Widget buildSectionTitle(String title){
    return Text(title,
    style: GoogleFonts.quicksand(
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      fontSize: 18,
    ),);

  }

  Widget buildButtonFromSvg({required String svgName,required VoidCallback onPressed}){
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SvgPicture.asset(
            'assets/$svgName',width: 32,height: 32,
            semanticsLabel: '$svgName Logo'
        ),
      ),
    );
  }
  Widget buildNewClientSection(){
    List<Client> clients = [
      Client(name: "Shantanu", profilePicPath: "$imageLink"),
      Client(name: "Shantanu", profilePicPath: "$imageLink"),
      Client(name: "Shantanu", profilePicPath: "$imageLink"),
      Client(name: "Shantanu", profilePicPath: "$imageLink")
    ];
    List<ResponsiveGridCol> children = List<ResponsiveGridCol>.from(
      clients.map((e) => ResponsiveGridCol(
          xs: 3,
          child: ClientProfile(
        profilePath: e.profilePicPath,
        name: e.name,
      ))).toList()
    );
    
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 16),
      child: ListView(
        shrinkWrap: true,
        children: [
          buildSectionTitle("New Clients"),
          SizedBox(height: 16,),
          ResponsiveGridRow(
              children: [...children])
        ],
      ),
    );
  }
  Widget buildClientList(){
    List<Client> clients = [
      Client(name: "Shantanu", profilePicPath: "$imageLink"),
      Client(name: "Shantanu", profilePicPath: "$imageLink"),
      Client(name: "Shantanu", profilePicPath: "$imageLink"),
      Client(name: "Shantanu", profilePicPath: "$imageLink")
    ];
    List<ResponsiveGridCol> children = List<ResponsiveGridCol>.from(
        clients.map((e) => ResponsiveGridCol(
            xs: 3,
            child: ClientProfile(
              profilePath: e.profilePicPath,
              name: e.name,
            ))).toList()
    );

    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 16),
      child: ListView(
        shrinkWrap: true,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildSectionTitle("Client List"),
              Text("See All (10)", style: GoogleFonts.quicksand(
                fontWeight: FontWeight.w700,
                fontSize: 12,
                fontStyle: FontStyle.normal,
                color: KowiColours.mainColor
              ),)
            ],
          ),
          SizedBox(height: 16,),
          ResponsiveGridRow(
              children: [...children])
        ],
      ),
    );
  }


}




/*
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kowi/helper/api_helper.dart';
import 'package:kowi/models/auth.dart';
import 'package:kowi/models/chat/chat.dart';
import 'package:kowi/models/employee.dart';
import 'package:kowi/models/instructors.dart';
import 'package:kowi/ui/screens/chat_screen/chat_screen.dart';
import 'package:kowi/ui/screens/profile_screen/user_screen.dart';
import 'package:kowi/utils/colours.dart';
import 'package:kowi_fashion/utils/custom_colors.dart';
import 'package:responsive_grid/responsive_grid.dart';

import 'appointment_list.dart';

class Friend extends StatefulWidget {
  const Friend({Key? key}) : super(key: key);

  @override
  _FriendState createState() => _FriendState();
}

class _FriendState extends State<Friend> {
  @override
  void initState() {
    super.initState();
    setInstructors();
  }

  void setInstructors() async {
    final instructorController = Get.find<Instructors>();
    try {
      final response =
      await ApiHelper.getInstructors(token: Get.find<Auth>().token!);
      instructorController.setDataFromMap(response);
    } catch (e) {
      print(e);
    }
  }

  List<ResponsiveGridCol> get getInstructorList {
    var instructorList = <ResponsiveGridCol>[];
    final instructorController = Get.find<Instructors>();

    if (instructorController.hasDietician.value) {
      instructorList.add(
        otherUserDisplayPhoto(
          instructorController.dietician.value!.picture!,
          instructorController.dietician.value!.name!,
          chatWith: instructorController.dietician,
        ),
      );
    }
    if (instructorController.hasNutritionist.value) {
      instructorList.add(
        otherUserDisplayPhoto(
          instructorController.nutritionist.value!.picture!,
          instructorController.nutritionist.value!.name!,
          chatWith: instructorController.nutritionist,
        ),
      );
    }
    if (instructorController.hasFitnessTrainer.value) {
      instructorList.add(
        otherUserDisplayPhoto(
          instructorController.fitnessTrainer.value!.picture!,
          instructorController.fitnessTrainer.value!.name!,
          chatWith: instructorController.fitnessTrainer,
        ),
      );
    }

    if (instructorController.hasMarketingEmployee.value) {
      instructorList.add(
        otherUserDisplayPhoto(
          instructorController.marketingEmployee.value!.picture!,
          instructorController.marketingEmployee.value!.name!,
          chatWith: instructorController.marketingEmployee,
        ),
      );
    }

    return instructorList;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Your assistances",
                  style: GoogleFonts.quicksand(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Obx(
                      () => ResponsiveGridRow(children: getInstructorList),
                ),
              ],
            ),
          ),
          AppointmentList(),
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Recents",
                  style: GoogleFonts.quicksand(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                ResponsiveGridRow(
                  children: [
                    otherUserDisplayPhoto(
                        "https://i.pinimg.com/originals/15/18/db/1518db3d7073da8e5db2cd6b6b52d588.jpg",
                        "Shantanu"),
                    otherUserDisplayPhoto(
                        "https://pyxis.nymag.com/v1/imgs/34b/450/b5f07c683e370ef135ff42f39793755785-20-emily-ratajkowski.rsquare.w700.jpg",
                        "Rashmi"),
                    otherUserDisplayPhoto(
                        "https://metro.co.uk/wp-content/uploads/2019/07/SEI_74430577.jpg?quality=90&strip=all&zoom=1&resize=480%2C320",
                        "Sumedha"),
                    otherUserDisplayPhoto(
                        "https://www.byrdie.com/thmb/58_rMDSoS5pVW2Oy7dHiDJLW8mw=/1000x1000/filters:fill(auto,1)/GettyImages-1282775976-crop-27537568e6c14e35aa82fb54d917228a.jpg",
                        "Elon"),
                    otherUserDisplayPhoto(
                        "https://qph.fs.quoracdn.net/main-qimg-8626230a004e76ddee41ff64eb6b0576.webp",
                        "Shantanu"),
                    otherUserDisplayPhoto(
                        "https://hips.hearstapps.com/esquireuk.cdnds.net/17/06/1024x1024/square-1486567824-marilyn-monroe.jpg?resize=480:*",
                        "Rashmi"),
                    otherUserDisplayPhoto(
                        "https://images.unsplash.com/photo-1597393922738-085ea04b5a07?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8YmVhdXRpZnVsJTIwYmxhY2slMjB3b21hbnxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&w=1000&q=80",
                        "Sumedha"),
                    otherUserDisplayPhoto(
                        "https://cdns-images.dzcdn.net/images/cover/7e335b285b80d29a0e0f52bed78d4541/500x500.jpg",
                        "Elon"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ResponsiveGridCol otherUserDisplayPhoto(
      String image,
      String name, {
        bool isCall = false,
        String? notificationNumbers,
        Rx<Employee?>? chatWith,
      }) {
    return ResponsiveGridCol(
      xs: 3,
      child: InkWell(
        onTap: chatWith == null ? null : () => setChatWith(chatWith),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(2),
              margin:
              const EdgeInsets.only(left: 8, right: 8, top: 12, bottom: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: isCall ? Color(0x5eff5a5a) : Colors.white,
              ),
              child: Badge(
                badgeContent: Text(
                  notificationNumbers ?? "",
                  style: GoogleFonts.quicksand(
                    color: Colors.white,
                  ),
                ),
                badgeColor: KowiColours.mainColor,
                child: Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  height: 62,
                  width: 62,
                  child: Image.network(
                    image,
                    height: 62,
                    width: 62,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Text(
              name,
              style: GoogleFonts.quicksand(
                color: Color(0xffff5a5a),
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }*/
