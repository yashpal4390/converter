import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Controller/Provider/profile_provider.dart';
import '../../Controller/Provider/theme_provider.dart';

class setting_page_android extends StatefulWidget {
  const setting_page_android({super.key});

  @override
  State<setting_page_android> createState() => _setting_page_androidState();
}

class _setting_page_androidState extends State<setting_page_android> {
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
            SwitchListTile(
              secondary: const Icon(Icons.person),
              title: const Text("Profile"),
              subtitle: const Text("Update Profile Data"),
              value: Provider.of<ProfileProvider>(context)
                  .profileModel
                  .profileSwitch,
              onChanged: (val) {
                Provider.of<ProfileProvider>(context, listen: false)
                    .changeProfileSwitchValue();
              },
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
                        Icons.add_a_photo_outlined,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller:
                    Provider.of<ProfileProvider>(context)
                        .profileModel
                        .userName,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter your name...",
                    ),
                  ),
                  TextFormField(
                    controller:
                    Provider.of<ProfileProvider>(context)
                        .profileModel
                        .userBio,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter your bio...",
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Provider.of<ProfileProvider>(context,
                              listen: false)
                              .saveDetails();
                        },
                        child: const Text("SAVE"),
                      ),
                      TextButton(
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
            SwitchListTile(
              secondary:
              (Provider.of<ThemeProvider>(context, listen: false)
                  .themeModel
                  .isDark)
                  ? const Icon(Icons.light_mode_outlined)
                  : const Icon(Icons.dark_mode_outlined),
              title: const Text("Theme"),
              subtitle: const Text("Change Theme"),
              value:
              Provider.of<ThemeProvider>(context).themeModel.isDark,
              onChanged: (val) {
                Provider.of<ThemeProvider>(context, listen: false)
                    .changeTheme();
              },
            ),
          ],
        ),
      ),
    );
  }
}
