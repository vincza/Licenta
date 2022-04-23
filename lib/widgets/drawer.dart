import 'package:flutter/material.dart';
import 'package:licenta/UI/change_password/change_password_view.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '/UI/home/home_viewmodel.dart';
import 'custom_circular_progress_indicator.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewmodel>.reactive(
      viewModelBuilder: () => HomeViewmodel(),
      builder: (context, model, child) => SafeArea(
        child: Drawer(
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 50,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: 'FIT',
                    style: Theme.of(context).textTheme.headline1!.copyWith(
                          fontSize: 35,
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -2,
                        ),
                    children: [
                      TextSpan(
                        text: 'tracker',
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                              fontSize: 35,
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondary
                                  .withOpacity(0.7),
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    SizedBox(
                      height: 40,
                      width: 40,
                      child: model.isBusy
                          ? const CustomCircularProgressIndicator(
                              size: 20,
                              strokeWidth: 2,
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(35),
                              child: model.getUpdatedImage != null
                                  ? Image.file(
                                      model.getUpdatedImage!,
                                      fit: BoxFit.cover,
                                    )
                                  : model.getUser!.profileImageUrl == null
                                      ? SvgPicture.asset(
                                          'assets/profile_placeholder.svg',
                                          fit: BoxFit.cover,
                                        )
                                      : CachedNetworkImage(
                                          imageUrl:
                                              model.getUser!.profileImageUrl!,
                                          fit: BoxFit.cover,
                                          placeholder: (context, _) =>
                                              const CustomCircularProgressIndicator(
                                            size: 20,
                                            strokeWidth: 2,
                                          ),
                                        ),
                            ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      model.getUser!.name,
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.background,
                          ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 35,
                ),
                GestureDetector(
                  onTap: () => model.changeProfilePicture(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.edit,
                        color: Theme.of(context).colorScheme.secondary,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Change Profile Picture',
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                              fontSize: 14,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                GestureDetector(
                  onTap: () => showModalBottomSheet(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    isScrollControlled: true,
                    context: context,
                    builder: (_) => const ChangePasswordView(),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.lock,
                        color: Theme.of(context).colorScheme.secondary,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Change Password',
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                              fontSize: 14,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                      )
                    ],
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => model.isBusy ? null : model.signOut(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.exit_to_app,
                        color: Theme.of(context).colorScheme.secondary,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Sign Out',
                        style: Theme.of(context).textTheme.headline1!.copyWith(
                              fontSize: 14,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
