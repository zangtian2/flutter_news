import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:news/common/api/apis.dart';
import 'package:news/common/entity/entitys.dart';
import 'package:news/common/utils/screen.dart';
import 'package:news/common/utils/utils.dart';
import 'package:news/common/values/values.dart';
import 'package:news/common/widgets/widgets.dart';
import 'package:news/pages/main/categories_widget.dart';
import 'package:news/pages/main/channels_widget.dart';
import 'package:news/pages/main/news_item_widget.dart';
import 'package:news/pages/main/newsletter_widget.dart';
import 'package:news/pages/main/recommend_widget.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  EasyRefreshController _controller; // EasyRefresh控制器
  NewsPageListResponseEntity _newsPageList; // 新闻翻页
  NewsItem _newsRecommend; // 新闻推荐
  List<CategoryResponseEntity> _categories; // 分类
  List<ChannelResponseEntity> _channels; // 频道

  String _selCategoryCode; // 选中的分类Code

  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController();
    _loadAllData();
    _loadLatestWithDiskCache();
  }

  // 如果有磁盘缓存，延迟3秒拉取更新档案
  _loadLatestWithDiskCache() {
    if (CACHE_ENABLE == true) {
      var cacheData = StorageUtil().getJSON(STORAGE_INDEX_NEWS_CACHE_KEY);
      if (cacheData != null) {
        Timer(Duration(seconds: 3), () {
          _controller.callRefresh();
        });
      }
    }
  }

  // 读取所有数据
  _loadAllData() async {
    _categories = await NewsAPI.categories(
      context: context,
      cacheDisk: true,
    );
    _channels = await NewsAPI.channels(
      context: context,
      cacheDisk: true,
    );
    _newsRecommend = await NewsAPI.newsRecommend(
      context: context,
      cacheDisk: true,
    );
    _newsPageList = await NewsAPI.newsPageList(
      context: context,
      cacheDisk: true,
    );

    _selCategoryCode = _categories.first.code;

    if (mounted) {
      setState(() {});
    }
  }

  // 拉取推荐、新闻
  _loadNewsData(
    categoryCode, {
    bool refresh = false,
  }) async {
    _selCategoryCode = categoryCode;
    _newsRecommend = await NewsAPI.newsRecommend(
      context: context,
      params: NewsRecommendRequestEntity(categoryCode: categoryCode),
      refresh: refresh,
      cacheDisk: true,
    );
    _newsPageList = await NewsAPI.newsPageList(
      context: context,
      params: NewsPageListRequestEntity(categoryCode: categoryCode),
      refresh: refresh,
      cacheDisk: true,
    );

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return _newsPageList == null
        ? cardListSkeleton()
        : EasyRefresh(
            enableControlFinishRefresh: true,
            controller: _controller,
            header: ClassicalHeader(),
            onRefresh: () async {
              await _loadNewsData(
                _selCategoryCode,
                refresh: true,
              );
              _controller.finishRefresh(); //触发刷新
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildCategories(),
                  Divider(height: 1),
                  _buildRecommend(),
                  Divider(height: 1),
                  _buildChannels(),
                  Divider(height: 1),
                  _buildNewsList(),
                  Divider(height: 1),
                  _buildEmailSubscribe(),
                ],
              ),
            ),
          );
  }

  _buildCategories() {
    return _categories == null
        ? Container()
        : newsCategoriesWidget(
            categories: _categories,
            selCategoryCode: _selCategoryCode,
            onTap: (CategoryResponseEntity item) {
              _loadNewsData(item.code);
            },
          );
  }

  _buildRecommend() {
    return _newsRecommend == null // 数据没到位，可以用骨架图展示
        ? Container()
        : recommendWidget(_newsRecommend);
  }

  _buildChannels() {
    return _channels == null
        ? Container()
        : newsChannelsWidget(
            channels: _channels,
            onTap: (ChannelResponseEntity item) {},
          );
  }

  _buildNewsList() {
    return _newsPageList == null
        ? Container(
            height: duSetHeight(161 * 5 + 100.0),
          )
        : Column(
            children: _newsPageList.items.map((item) {
              // 新闻行
              List<Widget> widgets = <Widget>[
                newsItem(item),
                Divider(height: 1),
              ];
              // 返回
              return Column(
                children: widgets,
              );
            }).toList(),
          );
  }

  // ad 广告条
  // 邮件订阅
  Widget _buildEmailSubscribe() {
    return newsletterWidget();
  }
}
