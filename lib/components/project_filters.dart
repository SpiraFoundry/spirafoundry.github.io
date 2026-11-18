import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../data/site_content.dart';

class ProjectFilterTabs extends StatelessComponent {
  const ProjectFilterTabs({
    required this.selected,
    required this.onSelect,
    super.key,
  });

  final ProjectCategory selected;
  final void Function(ProjectCategory) onSelect;

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'filter-tabs',
      attributes: const {'role': 'tablist', 'aria-label': 'Filter projects'},
      [
        for (final category in ProjectCategory.values)
          button(
            classes: selected == category ? 'filter-tab t-label-md is-active' : 'filter-tab t-label-md',
            attributes: {'aria-pressed': selected == category ? 'true' : 'false'},
            onClick: () => onSelect(category),
            [.text(category.label)],
          ),
      ],
    );
  }
}

class ProjectEmptyState extends StatelessComponent {
  const ProjectEmptyState({
    required this.category,
    super.key,
  });

  final ProjectCategory category;

  @override
  Component build(BuildContext context) {
    return div(classes: 'glass-card', [
      div(classes: 'glass-card__tint', []),
      p(
        classes: 't-body-md story-copy__body',
        [.text('Upcoming ${category.label} project in progress. Stay tuned.')],
      ),
    ]);
  }
}
