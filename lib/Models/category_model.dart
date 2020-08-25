class CategoryModel {
  final String imageUrl;
  final String categoryName;

  CategoryModel({this.imageUrl, this.categoryName});
}

List<CategoryModel> loadCategories() {
  List<CategoryModel> categories = [
    CategoryModel(
        imageUrl:
            'https://images.unsplash.com/photo-1519389950473-47ba0277781c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80',
        categoryName: 'Technology'),
    CategoryModel(
        imageUrl:
            'https://images.unsplash.com/photo-1444653614773-995cb1ef9efa?ixlib=rb-1.2.1&auto=format&fit=crop&w=755&q=80',
        categoryName: 'Business'),
    CategoryModel(
        imageUrl:
            'https://www.lifeofpix.com/wp-content/uploads/2018/08/pf-ake1200-ake-1600x1066.jpg',
        categoryName: 'Entertainment'),
    CategoryModel(
        imageUrl:
            'https://images.unsplash.com/photo-1542736667-069246bdbc6d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1502&q=80',
        categoryName: 'Health'),
    CategoryModel(
        imageUrl:
            'https://images.unsplash.com/photo-1518152006812-edab29b069ac?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80https://images.unsplash.com/photo-1518152006812-edab29b069ac?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80',
        categoryName: 'Science'),
    CategoryModel(
        imageUrl:
            'https://images.unsplash.com/photo-1461896836934-ffe607ba8211?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=750&q=80',
        categoryName: 'Sports'),
    CategoryModel(
        imageUrl:
            'https://images.unsplash.com/photo-1572949645841-094f3a9c4c94?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=334&q=80',
        categoryName: 'General'),
  ];
  return categories;
}
