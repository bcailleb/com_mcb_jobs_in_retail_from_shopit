import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/ProductDataBloc/product_bloc.dart';
import '../screens/Product/services/product_services.dart';
import '../utils/constants.dart';
import '../widgets/parent_appbar_widget.dart';
import '../widgets/product_show_list.dart';
import '../widgets/user_details_bar.dart';

import '../widgets/categories_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double offset = 0;

  ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();

    controller.addListener(() {
      setState(() {
        offset = controller.position.pixels;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc(
        RepositoryProvider.of<ProductServices>(context),
      )..add(GetProductDataEvent()),
      child: Scaffold(
        appBar: ParentAppBarWidget(
          hasBack: false,
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              controller: controller,
              child: Column(children: [
                const SizedBox(
                  height: kAppBarHeight / 2,
                ),
                const CategoriesView(),
               // const BannerAdWidget(),
                BlocBuilder<ProductBloc, ProductState>(
                  builder: (context, state) {
                    if (state is ProductLoading) {
                      return const ProductsShowCase(
                        title: '',
                        isLoading: true,
                        children: [],
                      );
                    }
                    return ProductsShowCase(
                      title: 'Dernières Offres',
                      children: state.productData!,
                    );
                  },
                ),
/*                const ShowProductsWithDiscountWidget(
                  discount: 50,
                  title: '50% Off Sale',
                ),
                const ShowProductsWithDiscountWidget(
                  discount: 60,
                  title: '60% Off Sale',
                ),
                const ShowProductsWithDiscountWidget(
                  discount: 70,
                  title: 'Shopit Bumper Sale',
                ),

 */
              ]),
            ),
            UserDetailsBar(
              offset: offset,
            )
          ],
        ),
      ),
    );
  }
}

class ShowProductsWithDiscountWidget extends StatelessWidget {
  final int discount;
  final String title;
  const ShowProductsWithDiscountWidget({
    Key? key,
    required this.discount,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: ProductServices().getProductDataFromDiscount(discount),
        builder: (context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const ProductsShowCase(
              title: '',
              isLoading: true,
              children: [],
            );
          }
          return ProductsShowCase(
            title: title,
            children: snapshot.data!,
          );
        });
  }
}
