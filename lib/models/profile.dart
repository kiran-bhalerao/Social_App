class Profile {
  final String name;
  final String imagePath;
  final String country;
  final String city;
  final String bio;
  final int followers;
  final int posts;
  final int followings;

  Profile({
    this.name,
    this.imagePath,
    this.country,
    this.city,
    this.followers,
    this.posts,
    this.followings,
    this.bio,
  });
}

final List<Profile> profiles = [
  Profile(
    name: 'Lori Parez',
    imagePath: 'assets/girl.jpg',
    country: 'Canada',
    city: 'Toronto',
    followers: 232,
    posts: 2234,
    followings: 23,
    bio:
        'The best things in life are really expensive. You can have me for \$7 billion 😉',
  ),
  Profile(
    name: 'Gina Scot',
    imagePath: 'assets/girl2.jpg',
    country: 'China',
    city: 'Shanghai',
    followers: 132,
    posts: 2214,
    followings: 223,
    bio:
        'Enjoying every second of my life, follow along and see for yourself. Love 💗 and Peace ✌️',
  ),
  Profile(
    name: 'Megha Murti',
    imagePath: 'assets/girl3.jpg',
    country: 'India',
    city: 'Kochi',
    followers: 1132,
    posts: 214,
    followings: 93,
    bio:
        'I don’t come with instructions but my captions are the next best thing 📚. Just going with the flow 🌊',
  ),
];
