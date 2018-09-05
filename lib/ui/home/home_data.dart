class HomeItem {
  HomeItem({
    this.title,
    this.imageUrl,
    this.route
  });

  final String title;
  final String imageUrl;
  final String route;
}

final sampleItems = <HomeItem> [
  new HomeItem(title: 'Club1', imageUrl: 'images/clubbackground.png', route:'/ui/events/club1'),
  new HomeItem(title: 'Club2', imageUrl: 'images/clubbackground.png', route: '/ui/events/club2'),
  new HomeItem(title: 'Club3', imageUrl: 'images/clubbackground.png', route:'/ui/events/club3'),
  new HomeItem(title: 'Club\'s Administrator', imageUrl: 'images/clubbackground.png', route:'/ui/admin'),
//  new HomeItem(title: 'Create Account', imageUrl: 'images/clubbackground.png', route:'/createAccount')
];