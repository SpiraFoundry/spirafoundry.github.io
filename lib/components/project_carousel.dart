import 'package:jaspr/dom.dart';
import 'package:jaspr/jaspr.dart';

import '../data/site_content.dart';
import 'icons.dart';

class ProjectCarousel extends StatefulComponent {
  const ProjectCarousel({
    required this.projectSlug,
    super.key,
  });

  final String projectSlug;

  @override
  State<ProjectCarousel> createState() => _ProjectCarouselState();
}

class _ProjectCarouselState extends State<ProjectCarousel> {
  int currentIndex = 0;

  ProjectEntry get _project => SiteContent.projects.firstWhere(
    (entry) => entry.slug == component.projectSlug,
    orElse: () => SiteContent.projects.first,
  );

  void _previous(int total) {
    setState(() {
      currentIndex = (currentIndex - 1 + total) % total;
    });
  }

  void _next(int total) {
    setState(() {
      currentIndex = (currentIndex + 1) % total;
    });
  }

  @override
  Component build(BuildContext context) {
    final slides = _project.slides;
    if (slides.isEmpty) {
      return const Component.empty();
    }

    final safeIndex = currentIndex.clamp(0, slides.length - 1);
    final slide = slides[safeIndex];
    final slideNum = (safeIndex + 1).toString().padLeft(2, '0');
    final totalNum = slides.length.toString().padLeft(2, '0');

    return div(classes: 'carousel-shell', [
      // Screenshot Viewport
      div(classes: 'carousel-viewport', [
        if (slide.imageSrc case final src?)
          img(
            src: src,
            alt: '${_project.name}: ${slide.title}',
            classes: 'carousel-image',
          )
        else
          div(classes: 'carousel-placeholder', [
            div(classes: 'carousel-placeholder__grid', []),
            div(classes: 'carousel-placeholder__content', [
              div(classes: 'carousel-placeholder__icon', [
                const MaterialIcon('image', size: 32),
              ]),
              span(classes: 't-label-sm carousel-placeholder__tag', [.text(slide.tag)]),
              span(classes: 't-headline-md carousel-placeholder__title', [.text(slide.title)]),
              span(
                classes: 't-body-sm carousel-placeholder__hint',
                [.text('Screenshots and feature details coming soon.')],
              ),
            ]),
          ]),

        if (slides.length > 1) ...[
          button(
            classes: 'carousel-arrow carousel-arrow--prev',
            attributes: const {'aria-label': 'Previous screenshot'},
            onClick: () => _previous(slides.length),
            [const MaterialIcon('chevron_left', size: 22)],
          ),
          button(
            classes: 'carousel-arrow carousel-arrow--next',
            attributes: const {'aria-label': 'Next screenshot'},
            onClick: () => _next(slides.length),
            [const MaterialIcon('chevron_right', size: 22)],
          ),
          div(classes: 'carousel-counter t-label-sm', [
            .text('$slideNum / $totalNum'),
          ]),
        ],
      ]),

      // Slide Dots Bar
      if (slides.length > 1)
        div(classes: 'carousel-dots-row', [
          for (var i = 0; i < slides.length; i++)
            button(
              classes: i == safeIndex ? 'carousel-dot is-active' : 'carousel-dot',
              attributes: {'aria-label': 'View slide ${i + 1}: ${slides[i].title}'},
              onClick: () {
                setState(() {
                  currentIndex = i;
                });
              },
              [],
            ),
        ]),

      // Description & Features Under the Carousel
      div(classes: 'carousel-caption-panel', [
        div(classes: 'carousel-caption-panel__head', [
          span(classes: 't-label-sm section-kicker', [.text(slide.tag)]),
          h3(classes: 't-headline-md story-copy__title', [.text(slide.title)]),
          p(classes: 't-body-md story-copy__body', [.text(slide.description)]),
        ]),
        if (slide.features.isNotEmpty)
          ul(classes: 'carousel-feature-list', [
            for (final feature in slide.features)
              li(classes: 'carousel-feature-item t-body-sm', [
                const MaterialIcon('star', size: 16, classes: 'carousel-feature-icon'),
                span([.text(feature)]),
              ]),
          ]),
      ]),
    ]);
  }
}
