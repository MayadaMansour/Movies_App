part of '../watch_List_Screen/watch_list_screen.dart';

class _Item extends StatelessWidget {
  final MovieModel model;
  const _Item({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.all(height * 0.01),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(height * 0.02),
                  color: Colors.transparent),
              child: Image.network(
                model.image,
                height: height * 0.12,
                width: width * 0.8,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: height * 0.03, horizontal: width * 0.03),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.movieTitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  //
                  Text(
                    model.releaseYear.toString(),
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Text(
                    model.movieSubtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleSmall,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
