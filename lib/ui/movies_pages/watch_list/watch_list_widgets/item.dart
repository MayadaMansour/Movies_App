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
            child: Stack(
                clipBehavior: Clip.none,

                children: [
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(height * 0.009),
                    color: Colors.transparent),
                child: Image.network(
                  model.image,
                  height: height * 0.12,
                  width: width * 0.8,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: -7,
                left: -11,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(
                      Icons.bookmark,
                      color: ColorResources.yellow.withOpacity(0.6),
                      size: 55,
                    ),
                    Icon(
                      Icons.check,
                      color: ColorResources.white,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ]),
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

//Positioned(
//           top: -10,
//           left: -12,
//           child: Stack(
//             alignment: Alignment.center,
//             children: [
//               Icon(
//                 Icons.bookmark,
//                 color: ColorResources.grey.withOpacity(0.6),
//                 size: 55,
//               ),
//               Icon(
//                 Icons.add,
//                 color: ColorResources.white,
//                 size: 20,
//               ),
//             ],
//           ),
//         ),
