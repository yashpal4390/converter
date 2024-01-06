import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Controller/Provider/profile_provider.dart';
import '../../Controller/Provider/theme_provider.dart';

class setting_page_ios extends StatefulWidget {
  const setting_page_ios({super.key});

  @override
  State<setting_page_ios> createState() => _setting_page_iosState();
}

class _setting_page_iosState extends State<setting_page_ios> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            CupertinoListTile(
              leading: const Icon(CupertinoIcons.person),
              title: const Text("Profile"),
              subtitle: const Text("Update Profile Data"),
              trailing: CupertinoSwitch(
                value: Provider.of<ProfileProvider>(context)
                    .profileModel
                    .profileSwitch,
                onChanged: (val) {
                  Provider.of<ProfileProvider>(context, listen: false)
                      .changeProfileSwitchValue();
                },
              ),
            ),
            (Provider.of<ProfileProvider>(context, listen: false)
                .profileModel
                .profileSwitch)
                ? Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Provider.of<ProfileProvider>(context,
                          listen: false)
                          .pickImage();
                    },
                    child: CircleAvatar(
                      radius: 60,
                      foregroundImage: FileImage(
                          Provider.of<ProfileProvider>(context)
                              .profileModel
                              .userImage),
                      child: const Icon(
                        CupertinoIcons.camera,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CupertinoTextFormFieldRow(
                    controller:
                    Provider.of<ProfileProvider>(context)
                        .profileModel
                        .userName,
                    textAlign: TextAlign.center,
                    placeholder: "Enter your name...",
                  ),
                  CupertinoTextFormFieldRow(
                    controller:
                    Provider.of<ProfileProvider>(context)
                        .profileModel
                        .userBio,
                    textAlign: TextAlign.center,
                    placeholder: "Enter your bio...",
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      CupertinoButton(
                        onPressed: () {
                          Provider.of<ProfileProvider>(context,
                              listen: false)
                              .saveDetails();
                        },
                        child: const Text("SAVE"),
                      ),
                      CupertinoButton(
                        onPressed: () {
                          Provider.of<ProfileProvider>(context,
                              listen: false)
                              .clearDetails();
                        },
                        child: const Text("CLEAR"),
                      ),
                    ],
                  ),
                ],
              ),
            )
                : const SizedBox(),
            const Divider(),
            CupertinoListTile(
              leading: (Provider.of<ThemeProvider>(context, listen: false)
                  .themeModel
                  .isDark)
                  ? const Icon(CupertinoIcons.sun_max)
                  : const Icon(CupertinoIcons.moon),
              title: const Text("Theme"),
              subtitle: const Text("Change Theme"),
              trailing: CupertinoSwitch(
                value:
                Provider.of<ThemeProvider>(context).themeModel.isDark,
                onChanged: (val) {
                  Provider.of<ThemeProvider>(context, listen: false)
                      .changeTheme();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
