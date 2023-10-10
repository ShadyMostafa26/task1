abstract class AppStates{}

class AppInitialState extends AppStates{}

class GetAllProductsLoadingState extends AppStates{}
class GetAllProductsSuccessState extends AppStates{}
class GetAllProductsErrorState extends AppStates{}

class GetCategoriesSuccessState extends AppStates{}
class GetCategoriesErrorState extends AppStates{}


class GetByCategorySuccessState extends AppStates{}
class GetByCategoryErrorState extends AppStates{}



class AddProductSuccessState extends AppStates{}
class AddProductErrorState extends AppStates{}


class UpdateProductSuccessState extends AppStates{}
class UpdateProductLoadingState extends AppStates{}
class UpdateProductErrorState extends AppStates{}