import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/models/news_model.dart';

class ArticleScreen extends StatefulWidget {
  final NewsModel newsModel;

  const ArticleScreen(this.newsModel) : super();

  @override
  _ArticleScreenState createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  Widget _topAricle(NewsModel article) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                  color: Colors.black12, offset: Offset(0, 2), blurRadius: 30)
            ],
            borderRadius: BorderRadius.circular(20.r)),
        child: Column(
          children: [
            Hero(
              tag: article.title.toString(),
              child: Container(
                width: double.infinity,
                height: 200.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: CachedNetworkImageProvider(article.imageUrl))),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              child: Text(
                article.title.toString(),
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 20.h,
          ),
          Container(
            height: 120,
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 24.w,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 40.w,
                      height: 40.h,
                      decoration: const BoxDecoration(boxShadow: [
                        BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0, 3),
                            blurRadius: 5.2)
                      ], color: Colors.white, shape: BoxShape.circle),
                      child: const Align(
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 40.w,
                    height: 40.h,
                    decoration: const BoxDecoration(boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, 3),
                          blurRadius: 5.2)
                    ], color: Colors.white, shape: BoxShape.circle),
                    child: const Align(
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.bookmark_add_outlined,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          _topAricle(widget.newsModel),
          SizedBox(
            height: 20.h,
          ),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              child: Text(widget.newsModel.description.toString()))
        ],
      ),
    );
  }
}
