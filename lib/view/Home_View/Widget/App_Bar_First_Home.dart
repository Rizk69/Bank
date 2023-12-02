import 'package:bank/Core/widgets/Styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBarFirstHome extends StatelessWidget {
  const AppBarFirstHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            onPressed: () {},
            icon: ImageIcon(AssetImage('Assets/images/Group.png'))),
        Text(
          'M',
          style: Styles.textStyleTitle24
              .copyWith(fontSize: 40, fontStyle: FontStyle.normal),
        ),
        // Image.asset('Assets/images/Logo Mbag without background 5.png',height: 120.h,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 43,
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: ImageIcon(
                        AssetImage(
                          'Assets/images/line-md_account.png',
                        ),
                        color: Colors.white),
                  ),
                  Positioned(
                    left: 25,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Icon(Icons.camera_alt_outlined,
                          color: Colors.white, size: 9),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              'My Account',
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.w300),
            )
          ],
        )
      ],
    );
  }
}
