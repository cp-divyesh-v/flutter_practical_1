import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:practical_1/Data/Models/User.dart';
import 'package:practical_1/Helper/AppTextStyle.dart';
import 'package:practical_1/Data/Repositories/UserRepository.dart';

class ProfileViewStatefulWidget extends StatefulWidget {
  const ProfileViewStatefulWidget({super.key});

  @override
  State createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileViewStatefulWidget> {
  final UserRepository _userRepository = UserRepository.shared;
  User? _user;

  @override
  void initState() {
    super.initState();
    _fetchUser();
  }

  void _fetchUser() async {
    User user = await _userRepository.getUser();
    setState(() {
      _user = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _user == null
          ? const CircularProgressIndicator()
          : ListView(
              children: [
                _userProfile(context, _user!),
              ],
            ),
    );
  }

  Widget _getCoverAndProfileImageView(context) {
    double imageHeight = 130;
    double coverHeight = 120;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: coverHeight,
                ),
                SizedBox(height: imageHeight / 2)
              ],
            ),
            Container(
              alignment: Alignment.bottomCenter,
              height: coverHeight + (imageHeight / 2),
              child: _imageView(context, 'assets/images/profile_image.jpg',
                  radius: imageHeight / 2),
            ),
          ],
        ),
      ),
    );
  }

  Widget _userProfile(context, User user) {
    return Column(
      children: [
        Card(
          child: Column(
            children: [
              _getCoverAndProfileImageView(context),
              _useBioView(context, user)
            ],
          ),
        ),
        const SizedBox(height: 15),
        _informationView(context, user)
      ],
    );
  }

  Widget _imageView(context, String imagePath, {double radius = 56.0}) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(3), // Border radius
        child: ClipOval(child: Image.asset(imagePath)),
      ),
    );
  }

  Widget _useBioView(context, User user) {
    List<Interactions> options = [
      Interactions.follow,
      Interactions.message,
      Interactions.more
    ];

    String userFullName() {
      return "${user.firstName} ${user.lastName}";
    }

    // Body
    return Column(
      children: [
        _textView(
            context,
            user.username,
            AppTextStyle.textStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                fontColor: const Color(0xe29faaaf))),
        const SizedBox(height: 5),
        _textView(
            context,
            userFullName(),
            AppTextStyle.textStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            )),
        const SizedBox(height: 10),
        Center(
          child: Row(
            children: [
              const Spacer(),
              _textView(
                  context,
                  user.organization,
                  AppTextStyle.textStyle(
                      fontSize: 14, fontColor: const Color(0xFFEA9398))),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Container(
                  color: const Color(0xe29faaaf),
                  width: 1,
                  height: 12,
                ),
              ),
              _textView(
                context,
                user.joinedOn,
                AppTextStyle.textStyle(
                    fontSize: 14, fontColor: const Color(0xe29faaaf)),
              ),
              const Spacer()
            ],
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 15),
            child: _optionsList(context, options)),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: _textView(
              context,
              user.about,
              AppTextStyle.textStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              )),
        ),
        const SizedBox(height: 10),
      ],
    );
  }

  Widget _textView(context, String text, TextStyle textStyle,
      {TextAlign align = TextAlign.center}) {
    return Text(text, textAlign: align, style: textStyle);
  }

  Widget _optionsList(context, List<Interactions> options) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        options.length,
        (index) => Padding(
          padding: const EdgeInsets.only(left: 5, right: 5),
          child: Container(
            padding: const EdgeInsets.only(left: 8, right: 8, top: 5, bottom: 5),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
            ),
            child:
                _label(label: options[index].name, icon: options[index].icon),
          ),
        ),
      ),
    );
  }

  Widget _label(
      {context,
      required String label,
      required IconData icon,
      Color color = Colors.black,
      double iconSize = 25,
      TextAlign textAlign = TextAlign.left}) {
    return Row(
      children: [
        Icon(icon, size: iconSize, color: color),
        const SizedBox(width: 10),
        _textView(
            context,
            label,
            AppTextStyle.textStyle(
                fontSize: 16, fontWeight: FontWeight.w500, fontColor: color),
            align: textAlign),
      ],
    );
  }

  Widget _informationView(context, User user) {
    Map infoOptions = {
      InfoOption.website: user.email,
      InfoOption.phone: user.phone,
      InfoOption.email: user.email,
      InfoOption.joined: user.joinedOn
    };
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: _textView(
                  context,
                  'Information',
                  AppTextStyle.textStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  align: TextAlign.left),
            ),
            const SizedBox(height: 15),
            _infoOptionsListView(context, user),
            const SizedBox(height: 15),
            const Divider(
              thickness: 1,
              color: Colors.black12,
            ),
            const SizedBox(height: 15),
            _skillsListView(context, user.skills),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  Widget _infoOptionsListView(context, User user) {
    Map<InfoOption, String> infoOptions = {
      InfoOption.website: user.email,
      InfoOption.phone: user.phone,
      InfoOption.email: user.email,
      InfoOption.joined: user.joinedOn
    };
    List<InfoOption> infoKeys = infoOptions.keys.toList();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(infoKeys.length, (index) {
        return Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Container(
            child: _cell(
                context, infoKeys[index], infoOptions.values.toList()[index]),
          ),
        );
      }),
    );
  }

  Widget _cell(context, InfoOption info, String userInfo) {
    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _label(label: info.name, icon: info.icon, color: Colors.black26),
          _textView(
              context,
              userInfo,
              AppTextStyle.textStyle(
                fontSize: 18,
              )),
        ],
      ),
    );
  }

  Widget _skillsListView(context, List<String> skills) {
    return Align(
      alignment: Alignment.topLeft,
      child: Wrap(
        children: [
          ...skills.map((skill) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0x8cced7d9),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.black38,
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: _textView(context, skill, AppTextStyle.textStyle()),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
