class Menu {
  final int id;
  final String name;

  Menu({this.id, this.name});
}

List<Menu> menu = [
  Menu(id: 0, name: 'Enrolled Courses'),

];

class Item {
  final int id;
  final String title;
  final String image;
  final String teacher;
  final String summary;


  Item({
    this.id,
    this.image,
    this.title,
    this.teacher,
    this.summary,
  });

}

List<Item> items = [
  Item(
    id: 0,
    image: 'assets/b.jpg',
    title: 'CPECC484',
    teacher: 'Figueras',
    summary: "Overall Progress : Passed"
  ),
  Item(
    id: 1,
    image: 'assets/c.jpg',
    title: 'ES031',
    teacher: 'Nathaniel',
    summary: "Overall Progress : Passed"
  ),
  Item(
    id: 2,
    image: 'assets/d.jpg',
    title: 'Technical Writing',
    teacher: 'Rex Seadiño',
    summary: "Overall Progress : Failed"
  ),
  
  // Item(
  //   id: 0,
  //   image: 'assets/e.jpg',
  //   title: 'Programming 1',
  //   teacher: 'James Dionson',
  //   summary: "Overall Progress : Failed",
  // ),
];

class Categories {
  final int id;
  final String image;
  final String name;

  Categories({this.id,this.image, this.name});
}

List<Categories> categories = [
  Categories(id: 0, image: 'assets/01.jpg', name: 'Mountains'),
  Categories(id: 1, image: 'assets/02.jpg', name: 'Countryside'),
  Categories(id: 2, image: 'assets/08.jpg', name: 'Snowfall'),
  Categories(id: 3, image: 'assets/05.jpg', name: 'Natura'),
  Categories(id: 4, image: 'assets/03.jpg', name: 'Mountains'),
  Categories(id: 5, image: 'assets/07.jpg', name: 'Countryside'),
];

class BottonNavData {
  final int id;

  final String image;

  BottonNavData({this.id, this.image});
}

List<BottonNavData> navData = [
  BottonNavData(id: 0, image: 'assets/icons/user.svg'),
];
