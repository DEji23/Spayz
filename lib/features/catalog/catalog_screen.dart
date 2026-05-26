import 'package:flutter/material.dart';

import '../../core/theme/theme.dart';
import '../../core/widgets/widgets.dart';

/// Interactive component catalog — a living style guide for the Spayz DS.
///
/// In production this screen is removed; during design work it lets the
/// team preview every token and component in context on a real device.
class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  int _chipIndex = 0;
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Spayz Design System'),
        actions: [
          SpayzCoinBadge(coins: 2450, size: CoinBadgeSize.small),
          const SizedBox(width: SpayzSpacing.base),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: SpayzSpacing.base),
        children: [
          _Section(
            title: 'Color Tokens',
            child: _ColorSwatches(),
          ),
          _Section(
            title: 'Typography',
            child: _TypographyPreview(),
          ),
          _Section(
            title: 'Buttons',
            child: _ButtonsPreview(
              loading: _loading,
              onLoadingToggle: () => setState(() => _loading = !_loading),
            ),
          ),
          _Section(
            title: 'Cards',
            child: _CardsPreview(),
          ),
          _Section(
            title: 'Text Fields',
            child: _FieldsPreview(),
          ),
          _Section(
            title: 'Transaction Tiles',
            child: _TransactionPreview(),
          ),
          _Section(
            title: 'Spayz Coins',
            child: _CoinsPreview(),
          ),
          _Section(
            title: 'Budget Progress',
            child: _BudgetPreview(),
          ),
          _Section(
            title: 'Avatars',
            child: _AvatarsPreview(),
          ),
          _Section(
            title: 'Chips',
            child: _ChipsPreview(
              selectedIndex: _chipIndex,
              onChanged: (i) => setState(() => _chipIndex = i),
            ),
          ),
          const SizedBox(height: SpayzSpacing.xl4),
        ],
      ),
    );
  }
}

// ─── Section wrapper ──────────────────────────────────────────────────────────

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: SpayzSpacing.base,
        right: SpayzSpacing.base,
        bottom: SpayzSpacing.xl2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: SpayzTypography.overline
                .copyWith(color: SpayzColors.textSecondary),
          ),
          const SizedBox(height: SpayzSpacing.md),
          child,
        ],
      ),
    );
  }
}

// ─── Color swatches ───────────────────────────────────────────────────────────

class _ColorSwatches extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final swatches = [
      ('Brand Violet', SpayzColors.brandPrimary),
      ('Emerald', SpayzColors.brandSecondary),
      ('Coin Gold', SpayzColors.coinPrimary),
      ('Coral', SpayzColors.stateError),
      ('Surface', SpayzColors.bgCard),
      ('Elevated', SpayzColors.bgElevated),
    ];

    return Wrap(
      spacing: SpayzSpacing.sm,
      runSpacing: SpayzSpacing.sm,
      children: swatches.map((s) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: s.$2,
                borderRadius: SpayzRadius.cardRadius,
                border: Border.all(color: SpayzColors.borderDefault, width: 0.5),
              ),
            ),
            const SizedBox(height: 4),
            SizedBox(
              width: 56,
              child: Text(
                s.$1,
                style: SpayzTypography.caption
                    .copyWith(color: SpayzColors.textSecondary),
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}

// ─── Typography preview ───────────────────────────────────────────────────────

class _TypographyPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pairs = [
      (SpayzTypography.display, 'Display — ₦1,250,000'),
      (SpayzTypography.headingXL, 'Heading XL — Your Finances'),
      (SpayzTypography.headingL, 'Heading L — Transactions'),
      (SpayzTypography.headingM, 'Heading M — This Month'),
      (SpayzTypography.headingS, 'Heading S — Food & Drink'),
      (SpayzTypography.bodyL, 'Body L — Track every naira you spend.'),
      (SpayzTypography.bodyMMedium, 'Body M Medium — GTBank Savings'),
      (SpayzTypography.caption, 'Caption — 2:45 PM · Yesterday'),
      (SpayzTypography.overline, 'OVERLINE — CATEGORIES'),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: pairs.map((p) {
        return Padding(
          padding: const EdgeInsets.only(bottom: SpayzSpacing.sm),
          child: Text(
            p.$2,
            style: p.$1.copyWith(color: SpayzColors.textPrimary),
          ),
        );
      }).toList(),
    );
  }
}

// ─── Buttons preview ──────────────────────────────────────────────────────────

class _ButtonsPreview extends StatelessWidget {
  const _ButtonsPreview({
    required this.loading,
    required this.onLoadingToggle,
  });

  final bool loading;
  final VoidCallback onLoadingToggle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SpayzButton(
          label: 'Primary — Connect Account',
          onTap: onLoadingToggle,
          leading: const Icon(Icons.add_rounded),
        ),
        const SizedBox(height: SpayzSpacing.sm),
        SpayzButton(
          label: loading ? 'Loading…' : 'Primary Loading State',
          onTap: onLoadingToggle,
          loading: loading,
        ),
        const SizedBox(height: SpayzSpacing.sm),
        SpayzButton(
          label: 'Secondary — View Details',
          onTap: () {},
          variant: SpayzButtonVariant.secondary,
        ),
        const SizedBox(height: SpayzSpacing.sm),
        SpayzButton(
          label: 'Ghost — Skip for now',
          onTap: () {},
          variant: SpayzButtonVariant.ghost,
        ),
        const SizedBox(height: SpayzSpacing.sm),
        SpayzButton(
          label: 'Danger — Disconnect Account',
          onTap: () {},
          variant: SpayzButtonVariant.danger,
          leading: const Icon(Icons.link_off_rounded),
        ),
        const SizedBox(height: SpayzSpacing.sm),
        Row(
          children: [
            Expanded(
              child: SpayzButton(
                label: 'Medium',
                onTap: () {},
                size: SpayzButtonSize.medium,
              ),
            ),
            const SizedBox(width: SpayzSpacing.sm),
            SpayzButton(
              label: 'Sm',
              onTap: () {},
              size: SpayzButtonSize.small,
              fullWidth: false,
            ),
            const SizedBox(width: SpayzSpacing.sm),
            SpayzButton(
              label: 'Disabled',
              onTap: null,
              size: SpayzButtonSize.small,
              fullWidth: false,
              disabled: true,
            ),
          ],
        ),
      ],
    );
  }
}

// ─── Cards preview ────────────────────────────────────────────────────────────

class _CardsPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SpayzCard(
          child: Row(
            children: [
              const Icon(Icons.account_balance_rounded,
                  color: SpayzColors.brandPrimary),
              const SizedBox(width: SpayzSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Standard Card',
                        style: SpayzTypography.bodyLMedium
                            .copyWith(color: SpayzColors.textPrimary)),
                    Text('bgCard surface, subtle border',
                        style: SpayzTypography.caption
                            .copyWith(color: SpayzColors.textSecondary)),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: SpayzSpacing.sm),
        SpayzCard(
          style: SpayzCardStyle.elevated,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Elevated Card',
                  style: SpayzTypography.bodyLMedium
                      .copyWith(color: SpayzColors.textPrimary)),
              Text('bgElevated surface, stronger shadow',
                  style: SpayzTypography.caption
                      .copyWith(color: SpayzColors.textSecondary)),
            ],
          ),
        ),
        const SizedBox(height: SpayzSpacing.sm),
        SpayzCard(
          style: SpayzCardStyle.glass,
          glowColor: SpayzColors.brandPrimary,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Glass Card — Total Balance',
                  style: SpayzTypography.bodyLMedium
                      .copyWith(color: SpayzColors.textPrimary)),
              Text('₦1,250,000.00',
                  style: SpayzTypography.display
                      .copyWith(color: SpayzColors.textPrimary)),
              Text('Across 3 accounts',
                  style: SpayzTypography.caption
                      .copyWith(color: SpayzColors.textSecondary)),
            ],
          ),
        ),
        const SizedBox(height: SpayzSpacing.sm),
        SpayzCard(
          style: SpayzCardStyle.branded,
          onTap: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Branded Card',
                      style: SpayzTypography.bodyLMedium
                          .copyWith(color: SpayzColors.textPrimary)),
                  Text('Gradient border, tap-able',
                      style: SpayzTypography.caption
                          .copyWith(color: SpayzColors.textSecondary)),
                ],
              ),
              const Icon(Icons.chevron_right_rounded,
                  color: SpayzColors.textSecondary),
            ],
          ),
        ),
      ],
    );
  }
}

// ─── Text fields preview ──────────────────────────────────────────────────────

class _FieldsPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SpayzTextField(
          label: 'Full Name',
          hint: 'Adaeze Okafor',
          prefixIcon: const Icon(Icons.person_outline_rounded),
        ),
        const SizedBox(height: SpayzSpacing.base),
        SpayzNairaField(
          label: 'Monthly Food Budget',
          hint: '50,000.00',
        ),
        const SizedBox(height: SpayzSpacing.base),
        SpayzTextField(
          label: 'Password',
          hint: '••••••••',
          obscureText: true,
          prefixIcon: const Icon(Icons.lock_outline_rounded),
        ),
        const SizedBox(height: SpayzSpacing.base),
        SpayzTextField(
          label: 'PIN',
          hint: 'Enter 4-digit PIN',
          keyboardType: TextInputType.number,
          maxLength: 4,
          errorText: 'Incorrect PIN. 2 attempts left.',
        ),
      ],
    );
  }
}

// ─── Transaction tiles ────────────────────────────────────────────────────────

class _TransactionPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SpayzCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          SpayzTransactionTile(
            merchant: 'Shoprite Ikeja',
            amount: '₦12,400',
            direction: TxDirection.debit,
            category: 'Food & Groceries',
            categoryIcon: Icons.shopping_cart_outlined,
            categoryColor: SpayzColors.emerald500,
            timestamp: '2:30 PM',
            subLabel: 'GTBank •••• 4821',
            coinsEarned: 12,
          ),
          SpayzTransactionTile(
            merchant: 'Salary — TechCorp Ltd',
            amount: '₦450,000',
            direction: TxDirection.credit,
            category: 'Income',
            categoryIcon: Icons.work_outline_rounded,
            categoryColor: SpayzColors.brandPrimary,
            timestamp: 'Yesterday',
            subLabel: 'Access Bank •••• 9032',
          ),
          SpayzTransactionTile(
            merchant: 'Netflix',
            amount: '₦4,600',
            direction: TxDirection.debit,
            category: 'Entertainment',
            categoryIcon: Icons.movie_outlined,
            categoryColor: SpayzColors.coral500,
            timestamp: '10:12 AM',
            isPending: true,
            showDivider: false,
          ),
        ],
      ),
    );
  }
}

// ─── Coins preview ────────────────────────────────────────────────────────────

class _CoinsPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SpayzCoinBadge.hero(coins: 14850, onTap: () {}),
        const SizedBox(height: SpayzSpacing.base),
        Row(
          children: [
            SpayzCoinBadge(coins: 2450, size: CoinBadgeSize.medium),
            const SizedBox(width: SpayzSpacing.sm),
            SpayzCoinBadge(
                coins: 2450, size: CoinBadgeSize.medium, showLabel: true),
            const SizedBox(width: SpayzSpacing.sm),
            SpayzCoinBadge(coins: 99, size: CoinBadgeSize.small),
          ],
        ),
      ],
    );
  }
}

// ─── Budget progress preview ──────────────────────────────────────────────────

class _BudgetPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SpayzCard(
      child: Column(
        children: [
          SpayzBudgetProgress(
            category: 'Food & Groceries',
            spent: 28500,
            limit: 50000,
            categoryIcon: Icons.shopping_cart_outlined,
            coinsAvailable: 50,
          ),
          const SizedBox(height: SpayzSpacing.xl),
          SpayzBudgetProgress(
            category: 'Transport',
            spent: 43000,
            limit: 50000,
            categoryIcon: Icons.directions_car_outlined,
            categoryColor: SpayzColors.brandPrimary,
          ),
          const SizedBox(height: SpayzSpacing.xl),
          SpayzBudgetProgress(
            category: 'Entertainment',
            spent: 55000,
            limit: 50000,
            categoryIcon: Icons.movie_outlined,
            categoryColor: SpayzColors.coral500,
          ),
          const SizedBox(height: SpayzSpacing.xl),
          const Divider(),
          const SizedBox(height: SpayzSpacing.md),
          Text(
            'Compact mode',
            style: SpayzTypography.caption
                .copyWith(color: SpayzColors.textSecondary),
          ),
          const SizedBox(height: SpayzSpacing.sm),
          SpayzBudgetProgress(
            category: 'Dining out',
            spent: 18000,
            limit: 30000,
            compact: true,
          ),
        ],
      ),
    );
  }
}

// ─── Avatars preview ──────────────────────────────────────────────────────────

class _AvatarsPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: SpayzSpacing.base,
      runSpacing: SpayzSpacing.base,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        SpayzAvatar(
          initials: 'AO',
          size: SpayzAvatarSize.xl,
          showBrandRing: true,
          status: SpayzAvatarStatus.premium,
        ),
        SpayzAvatar(
          initials: 'TO',
          size: SpayzAvatarSize.lg,
          status: SpayzAvatarStatus.verified,
        ),
        SpayzAvatar(
          initials: 'KA',
          size: SpayzAvatarSize.md,
          backgroundColor: SpayzColors.emerald700,
          status: SpayzAvatarStatus.online,
        ),
        SpayzAvatar(
          initials: 'BB',
          size: SpayzAvatarSize.sm,
          backgroundColor: SpayzColors.coral700,
        ),
        SpayzAvatar(initials: '?', size: SpayzAvatarSize.xs),
        const SpayzBankAvatar(bankName: 'GT Bank', size: SpayzAvatarSize.lg),
        const SpayzBankAvatar(
            bankName: 'Access Bank', size: SpayzAvatarSize.md),
        const SpayzBankAvatar(
            bankName: 'First Bank', size: SpayzAvatarSize.sm),
      ],
    );
  }
}

// ─── Chips preview ────────────────────────────────────────────────────────────

class _ChipsPreview extends StatelessWidget {
  const _ChipsPreview({
    required this.selectedIndex,
    required this.onChanged,
  });

  final int selectedIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SpayzChipRow(
          labels: const ['All', 'Food', 'Transport', 'Bills', 'Income'],
          selectedIndex: selectedIndex,
          onChanged: onChanged,
          padding: EdgeInsets.zero,
        ),
        const SizedBox(height: SpayzSpacing.base),
        Wrap(
          spacing: SpayzSpacing.sm,
          runSpacing: SpayzSpacing.sm,
          children: [
            SpayzChip(
              label: 'Groceries',
              style: SpayzChipStyle.category,
              leading: const Icon(Icons.shopping_cart_outlined),
              selected: true,
              onTap: () {},
            ),
            SpayzChip(
              label: 'Transport',
              style: SpayzChipStyle.category,
              leading: const Icon(Icons.directions_car_outlined),
              onTap: () {},
            ),
            SpayzChip(
              label: '#groceries',
              style: SpayzChipStyle.tag,
            ),
            SpayzChip(
              label: 'Filter',
              count: 3,
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }
}
