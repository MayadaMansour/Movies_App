import 'package:flutter/material.dart';
import 'package:moves_app_project/ui/utils/color_resource/color_resources.dart';

import '../watch_list_widgets/model.dart';

part '../watch_list_widgets/item.dart';

class WatchlistScreen extends StatelessWidget {
  WatchlistScreen({super.key});

  List<MovieModel> list = [
    MovieModel(
        image:
            'https://cdn11.bigcommerce.com/s-4c994/images/stencil/1280x1280/products/2216/3602/Alita_Battle_Angel__Poster__03329.1565530383.jpg?c=2',
        movieTitle: 'movieTitle1',
        releaseYear: 2019,
        movieSubtitle: 'movieSubtitle'),
    MovieModel(
        image:
            'https://m.media-amazon.com/images/M/MV5BZmFhMDgyZTUtNmZkNC00NjliLWI3NzQtMjVlZDlmMmEzMjI5XkEyXkFqcGdeQXVyNzI1NzMxNzM@._V1_.jpg',
        movieTitle: 'Dora',
        releaseYear: 2019,
        movieSubtitle: 'movieSubtitle'),
    MovieModel(
        image:
            'https://images.squarespace-cdn.com/content/v1/5b18735a3917ee20d18a2117/0220e150-3a54-4338-b9cd-aaa2e9048803/scale.png',
        movieTitle: 'movieTitle3',
        releaseYear: 2019,
        movieSubtitle: 'movieSubtitle'),
    MovieModel(
        image:
            'https://img1.hotstarext.com/image/upload/f_auto,t_web_hs_2_5x/sources/r1/cms/prod/1322/441322-h',
        movieTitle: 'movieTitle4',
        releaseYear: 2019,
        movieSubtitle: 'movieSubtitle'),
    MovieModel(
        image:
            'https://akm-img-a-in.tosshub.com/indiatoday/images/story/202302/f1eb4c7f5894ff214e19361cc94fe34116ebad1cea2c42617d1b4f8227165366-sixteen_nine.jpg?VersionId=vmO970bgamSIFtHtUFzZkZkMNgMo9wAF&size=690:388',
        movieTitle: 'movieTitle5',
        releaseYear: 2019,
        movieSubtitle: 'movieSubtitle'),
    MovieModel(
        image:
            'https://i0.wp.com/capesandtights.com/wp-content/uploads/2023/12/Movies2023.png',
        movieTitle: 'movieTitle6',
        releaseYear: 2019,
        movieSubtitle: 'movieSubtitle'),
    MovieModel(
        image:
            'https://cdn11.bigcommerce.com/s-4c994/images/stencil/1280x1280/products/2216/3602/Alita_Battle_Angel__Poster__03329.1565530383.jpg?c=2',
        movieTitle: 'movieTitle7',
        releaseYear: 2019,
        movieSubtitle: 'movieSubtitle'),
    MovieModel(
        image:
            'https://cdn11.bigcommerce.com/s-4c994/images/stencil/1280x1280/products/2216/3602/Alita_Battle_Angel__Poster__03329.1565530383.jpg?c=2',
        movieTitle: 'movieTitle8',
        releaseYear: 2019,
        movieSubtitle: 'movieSubtitle'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Watch List',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) => _Item(
          model: list[index],
        ),
        separatorBuilder: (context, index) =>
            Divider(color: ColorResources.grey),
        itemCount: list.length,
      ),
    );
  }
}
