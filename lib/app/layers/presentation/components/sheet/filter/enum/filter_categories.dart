enum FilterCategory {
  exhibitionExperience('Exhibition/Experience'),
  exhibitionMuseum('Exhibition/Museum'),
  exhibitionTour('Exhibition/Tour'),
  experience('Experience'),
  package('Package'),
  sportsLeisure('Sports/Leisure'),
  themePark('Theme Park'),
  restaurant('Restaurant'),
  performanceShow('Performance/Show'),
  marineTourism('Marine Tourism');

  final String label;
  const FilterCategory(this.label);
}

enum FilterDetailedCategory {
  family('Family'),
  friends('Friends'),
  couple('Couple'),
  alone('Alone'),
  indoors('Indoors');

  final String label;
  const FilterDetailedCategory(this.label);
}
