import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/models/news_model.dart';
import 'package:news_app/repositories/news%20repository/news_repository.dart';
import 'package:news_app/screens/article_screen.dart';

class HomeScreen extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const HomeScreen() : super();

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<NewsModel> list = [];
  Widget _topAricle(NewsModel article) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                  color: Colors.black12, offset: Offset(0, 20), blurRadius: 30)
            ],
            borderRadius: BorderRadius.circular(20.r)),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 200.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(article.imageUrl))),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              child: Text(
                article.title.toString(),
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(article.author.toString(),
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400)),
                  Text("10 jun, 2021",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400)),
                ],
              ),
            )
          ],
        ));
  }

  Widget _buildArticle(NewsModel newsModel) {
    return GestureDetector(
      onTap: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => ArticleScreen(newsModel))),
      child: Container(
        margin: EdgeInsets.only(top: 14.h),
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(
              tag: newsModel.title.toString(),
              child: Container(
                width: 75,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: CachedNetworkImageProvider(newsModel.imageUrl))),
              ),
            ),
            Flexible(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 6.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      newsModel.title.toString(),
                      maxLines: 2,
                    ),
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Icon(
                              Icons.date_range,
                              size: 13.0,
                            ),
                            SizedBox(
                              width: 3.w,
                            ),
                            Text(
                              "Jan 10 , 2020",
                              style: TextStyle(fontSize: 10.sp),
                            )
                          ],
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Flexible(
                                child: const Icon(
                                  Icons.person,
                                  size: 13.0,
                                ),
                              ),
                              SizedBox(
                                width: 3.w,
                              ),
                              Flexible(
                                child: Text(
                                  newsModel.author.toString(),
                                  style: TextStyle(
                                      fontSize: 10.sp,
                                      overflow: TextOverflow.ellipsis),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Breaking News",
                  style: GoogleFonts.raleway(
                      fontSize: 26.sp,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 2.2),
                ),
                SizedBox(
                  height: 20.h,
                ),
                FutureBuilder(
                  future: NewsRepository().getNews(country: "us"),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<NewsModel>> snapshot) {
                    if (snapshot.hasData) {
                      List<NewsModel> list2 = [];

                      list2 = snapshot.data!;
                      final topArticle = list2[0];
                      return _topAricle(topArticle);
                    }
                    return Container();
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
                FutureBuilder(
                  future: NewsRepository().getNews(country: "us"),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<NewsModel>> snapshot) {
                    if (snapshot.hasData) {
                      list = snapshot.data!;

                      return ListView.builder(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: list!.length,
                        itemBuilder: (BuildContext context, int index) {
                          final news = list![index];
                          return _buildArticle(news);
                        },
                      );
                    }

                    return Center(child: CircularProgressIndicator());
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
