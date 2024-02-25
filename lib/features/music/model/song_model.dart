class Song {
  final String title;
  // final String singer;
  final String url;
  final String coverUrl;

  Song({
    required this.title,
    // required this.singer,
    required this.url,
    required this.coverUrl,
  });

  static List<Song> songs = [
    Song(
      title: 'Kinni Kinni',
      url: 'assets/music/kinni_kinni.mp3',
      coverUrl:
          'https://img.wynk.in/unsafe/248x248/http://s3.ap-south-1.amazonaws.com/wynk-music-cms/srch_hungama/859778016276_20231010185022/859778016276/1696945204122/resources/859778016276.jpg',
    ),
    Song(
      title: 'Showstopper',
      url: 'assets/music/showstopper.mp3',
      coverUrl:
          'https://a10.gaanacdn.com/gn_img/albums/w4MKPgOboj/MKPDDEpzKo/size_l.jpg',
    ),
    Song(
      title: 'Blinding Lights',
      url: 'assets/music/blinding_lights.mp3',
      coverUrl:
          'https://t2.genius.com/unsafe/425x425/https%3A%2F%2Fimages.genius.com%2Fbbc091dc215cb84f79de6b86c5437164.1000x1000x1.png',
    )
  ];
}
