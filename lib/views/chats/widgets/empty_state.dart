part of '../chats.view.dart';

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Icon(
          AppIcons.no_channel,
          size: 136,
          color: AppColors.of(context).greyGainsboro,
        ),
        const SizedBox(height: 16),
        Text(
          'Let’s start chatting!',
          style: AppTextStyles.headline,
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
