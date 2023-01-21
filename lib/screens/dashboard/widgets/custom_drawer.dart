part of '../dashboard.dart';

class _CustomDrawer extends StatelessWidget {
  const _CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    App.init(context);
    final appProvider = Provider.of<AppProvider>(context);
    final authCubit = Provider.of<AuthCubit>(context);

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    final currentUser = FirebaseAuth.instance.currentUser;

    return SizedBox(
      width: width * 0.835,
      height: height,
      child: Material(
        color: appProvider.isDark ? Colors.grey[850] : Colors.white,
        child: Padding(
          padding: Space.all(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Space.y!,
              currentUser?.photoURL == null
                  ? Image.asset(
                      AppUtils.dp,
                      height: AppDimensions.normalize(50),
                    )
                  : CircleAvatar(
                      backgroundImage: NetworkImage(
                        currentUser!.photoURL!,
                      ),
                      radius: AppDimensions.normalize(40),
                    ),
              Space.y!,
              Center(
                child: Text(
                  currentUser != null ? currentUser.displayName! : 'Full Name',
                  style: AppText.h2b,
                ),
              ),
              Space.y1!,
              Card(
                color: appProvider.isDark ? Colors.grey[800] : Colors.white,
                child: ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('Edit Profile'),
                  onTap: () => Navigator.pushNamed(context, '/profile'),
                ),
              ),
              Card(
                color: appProvider.isDark ? Colors.grey[800] : Colors.white,
                child: ListTile(
                  onTap: () {},
                  leading: const Icon(Icons.pin),
                  title: const Text('Change Password'),
                ),
              ),
              Card(
                color: appProvider.isDark ? Colors.grey[800] : Colors.white,
                child: ListTile(
                  leading: const Icon(Icons.brightness_6_rounded),
                  title: const Text('Dark Theme'),
                  trailing: Switch(
                    activeColor: AppTheme.c!.primary,
                    value: appProvider.isDark,
                    onChanged: (value) {
                      appProvider
                          .setTheme(value ? ThemeMode.dark : ThemeMode.light);
                    },
                  ),
                ),
              ),
              Space.ym!,
              Card(
                color: appProvider.isDark ? Colors.grey[800] : Colors.white,
                child: ListTile(
                  title: BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is AuthLogoutFailed) {
                        CustomSnackBars.failure(context, state.message!);
                      } else if (state is AuthLogoutSuccess) {
                        Navigator.popAndPushNamed(context, '/login');
                      }
                    },
                    builder: (context, state) {
                      if (state is AuthLogoutLoading) {
                        return LinearProgressIndicator(
                          color: AppTheme.c!.primary,
                        );
                      }
                      return const Text('Logout');
                    },
                  ),
                  leading: const Icon(Icons.exit_to_app_rounded),
                  onTap: () {
                    authCubit.logout();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
