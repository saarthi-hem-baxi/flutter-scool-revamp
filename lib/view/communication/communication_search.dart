import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:students/constants/app_colors.dart';
import 'package:students/constants/app_strings.dart';
import 'package:students/constants/app_text_styles.dart';
import 'package:students/constants/communication_image_assets.dart';
import 'package:students/helpers/utils.dart';
import 'package:students/models/communication/communication_search_model.dart';
import 'package:students/widgets/common_app_image.dart';
import 'package:students/widgets/media/media_utils.dart';
import 'package:students/widgets/media/media_widget.dart';
import 'package:students/view/communication/communication_feed_list.dart';

class CommunicationSearch extends StatefulWidget {
  const CommunicationSearch({Key? key}) : super(key: key);

  @override
  State<CommunicationSearch> createState() => _CommunicationSearchState();
}

class _CommunicationSearchState extends State<CommunicationSearch> with SingleTickerProviderStateMixin {
  final TextEditingController _txtSearchController = TextEditingController(text: "");
  List<TagModel> tagList = [];
  List<SubjectModel> subjectList = [];
  List<String> chatPersonList = [];
  bool show = false;
  bool subjectShow = false;
  TagModel? tag;
  SubjectModel? subject;
  bool showListView = true;

  @override
  void initState() {
    super.initState();
    TagModel tagModel;
    tagModel = TagModel('Photos', CommunicationImageAssets.inActivePhotosTag, CommunicationImageAssets.activePhotosTag);
    tagList.add(tagModel);
    tagModel = TagModel('Videos', CommunicationImageAssets.inActiveVideosTag, CommunicationImageAssets.activeVideosTag);
    tagList.add(tagModel);
    tagModel = TagModel('Documents', CommunicationImageAssets.inActiveDocumentsTag, CommunicationImageAssets.activeDocumentsTag);
    tagList.add(tagModel);
    tagModel = TagModel('Links', CommunicationImageAssets.inActiveLinksTag, CommunicationImageAssets.activeLinksTag);
    tagList.add(tagModel);

    SubjectModel subjectModel;
    subjectModel = SubjectModel('English Grammer', CommunicationImageAssets.headerIcon, false);
    subjectList.add(subjectModel);
    subjectModel = SubjectModel('English', CommunicationImageAssets.headerIcon, false);
    subjectList.add(subjectModel);
    subjectModel = SubjectModel('Hindi', CommunicationImageAssets.headerIcon, false);
    subjectList.add(subjectModel);
    subjectModel = SubjectModel('Environmental Science', CommunicationImageAssets.headerIcon, false);
    subjectList.add(subjectModel);
    subjectModel = SubjectModel('Hindi Grammer', CommunicationImageAssets.headerIcon, false);
    subjectList.add(subjectModel);
    subjectModel = SubjectModel('Science', CommunicationImageAssets.headerIcon, false);
    subjectList.add(subjectModel);
    subjectModel = SubjectModel('Social Science', CommunicationImageAssets.headerIcon, false);
    subjectList.add(subjectModel);

    chatPersonList.add('J K Public school');
    chatPersonList.add('Radhika Mishra ma’am');
    chatPersonList.add('Nilesh Kacha sir');
    chatPersonList.add('Paresh Rana sir');
    chatPersonList.add('Ajay Dave sir');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorWhite,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                top: 10.h,
                bottom: 10.h,
              ),
              decoration: BoxDecoration(
                color: AppColors.colorWhite,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.gray900.withOpacity(0.1),
                    offset: const Offset(0, 1),
                    blurRadius: 2,
                    spreadRadius: 0,
                  ),
                  BoxShadow(
                    color: AppColors.gray900.withOpacity(0.06),
                    offset: const Offset(0, 1),
                    blurRadius: 3,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search,
                          size: 20.h,
                          color: AppColors.blueGray600,
                        ),
                        SizedBox(
                          width: 15.w,
                        ),
                        Visibility(
                          visible: show,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                show = !show;
                                tag = null;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                              margin: EdgeInsets.only(right: 5.w, bottom: 5.h),
                              decoration: BoxDecoration(
                                color: AppColors.gray50,
                                borderRadius: BorderRadius.circular(20.r),
                                border: Border.all(
                                  width: 1.w,
                                  color: AppColors.gray200,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset(
                                    (tag?.activeIcon ?? ''),
                                    height: 16.h,
                                    width: 16.w,
                                  ),
                                  SizedBox(
                                    width: 8.w,
                                  ),
                                  Text(
                                    (tag?.title ?? ''),
                                    style: AppTextStyle.readexTextStyle12Regular().copyWith(
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8.w,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Icon(
                                      Icons.clear,
                                      size: 15.h,
                                      color: AppColors.gray700,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: subjectShow,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                subjectShow = !subjectShow;
                                subject = null;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
                              margin: EdgeInsets.only(right: 5.w, bottom: 5.h),
                              decoration: BoxDecoration(
                                color: AppColors.gray50,
                                borderRadius: BorderRadius.circular(20.r),
                                border: Border.all(
                                  width: 1.w,
                                  color: AppColors.gray200,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  (subject?.isNetworkImage ?? false)
                                      ? ClipRRect(
                                          borderRadius: BorderRadius.circular(30.w),
                                          child: Container(
                                            height: 20.w,
                                            width: 20.w,
                                            decoration: const BoxDecoration(shape: BoxShape.circle),
                                            child: const CommonAppImage(imagePath: 'https://cdn-icons-png.flaticon.com/512/206/206881.png'),
                                          ),
                                        )
                                      : Image.asset(
                                          (subject?.filePath ?? ''),
                                          height: 16.h,
                                          width: 16.w,
                                        ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Text(
                                    (subject?.title ?? ''),
                                    style: AppTextStyle.readexTextStyle12Regular().copyWith(
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  Icon(
                                    Icons.clear,
                                    size: 15.h,
                                    color: AppColors.gray700,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            controller: _txtSearchController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              filled: true,
                              fillColor: Colors.transparent,
                              contentPadding: EdgeInsets.zero,
                              hintText: AppStrings.search_hint,
                              hintStyle: AppTextStyle.nunitoTextStyle16Regular(color: AppColors.gray400).copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                              labelStyle: AppTextStyle.nunitoTextStyle16Regular(color: AppColors.gray700).copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Visibility(
                          visible: tag?.title == 'Photos' || tag?.title == 'Videos' ? true : false,
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                showListView = !showListView;
                              });
                            },
                            iconSize: 20.h,
                            color: AppColors.blueGray600,
                            icon: Icon(
                              showListView ? Icons.toc : Icons.grid_view_sharp,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          iconSize: 20.h,
                          color: AppColors.blueGray600,
                          icon: const Icon(Icons.clear),
                        ),
                      ],
                    ),
                  ),
                  AnimatedSize(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.fastLinearToSlowEaseIn,
                    vsync: this,
                    child: !show
                        ? Column(
                            children: [
                              Column(
                                children: [
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  SizedBox(
                                    height: 30.h,
                                    child: ListView.builder(
                                      shrinkWrap: false,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: tagList.length,
                                      padding: EdgeInsets.only(left: 16.w),
                                      itemBuilder: (context, index) {
                                        TagModel item = tagList[index];
                                        return GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              show = !show;
                                              tag = item;
                                            });
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                                            margin: EdgeInsets.only(right: 5.w),
                                            decoration: BoxDecoration(
                                              color: AppColors.gray50,
                                              borderRadius: BorderRadius.circular(20.r),
                                              border: Border.all(
                                                width: 1.w,
                                                color: AppColors.gray200,
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                SvgPicture.asset(
                                                  item.inActiveIcon,
                                                  height: 14.h,
                                                  width: 16.w,
                                                ),
                                                SizedBox(
                                                  width: 8.w,
                                                ),
                                                Text(
                                                  item.title,
                                                  style: AppTextStyle.readexTextStyle12Regular().copyWith(
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                ],
                              ),
                              AnimatedSize(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.fastLinearToSlowEaseIn,
                                child: !subjectShow
                                    ? Column(
                                        children: [
                                          SizedBox(
                                            height: 15.h,
                                          ),
                                          SizedBox(
                                            height: 70.h,
                                            child: ListView.builder(
                                              shrinkWrap: false,
                                              scrollDirection: Axis.horizontal,
                                              padding: EdgeInsets.only(left: 16.w),
                                              itemCount: subjectList.length,
                                              itemBuilder: (context, index) {
                                                return GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      subjectShow = !subjectShow;
                                                      subject = subjectList[index];
                                                    });
                                                  },
                                                  child: Container(
                                                    width: 70.h,
                                                    height: 70.h,
                                                    padding: EdgeInsets.all(10.w),
                                                    margin: EdgeInsets.only(
                                                      right: 16.w,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: AppColors.gray50,
                                                      borderRadius: BorderRadius.circular(10.r),
                                                      border: Border.all(
                                                        width: 1.w,
                                                        color: AppColors.gray200,
                                                      ),
                                                    ),
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Image.asset(
                                                          subjectList[index].filePath,
                                                          height: 28.h,
                                                          width: 30.w,
                                                        ),
                                                        SizedBox(
                                                          height: 10.h,
                                                        ),
                                                        Flexible(
                                                          child: Text(
                                                            subjectList[index].title,
                                                            style: AppTextStyle.readexTextStyle10Regular(color: AppColors.gray600).copyWith(
                                                              fontWeight: FontWeight.w400,
                                                            ),
                                                            maxLines: 1,
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      )
                                    : const SizedBox(),
                              ),
                            ],
                          )
                        : const SizedBox(),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            // Visibility(
            //   visible: tag?.title == null && subject?.title == null ? true : false,
            //   child: Container(
            //     color: AppColors.colorwhite,
            //     padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
            //     child: ListView.builder(
            //       shrinkWrap: true,
            //       itemBuilder: (context, index) {
            //         return Container(
            //           margin: EdgeInsets.only(bottom: 30.h),
            //           child: Row(
            //             children: [
            //               ClipRRect(
            //                 borderRadius: BorderRadius.circular(30.w),
            //                 child: Container(
            //                   height: 48.w,
            //                   width: 48.w,
            //                   decoration: const BoxDecoration(shape: BoxShape.circle),
            //                   child: const CustomNetworkImage(imageUrl: 'https://cdn-icons-png.flaticon.com/512/206/206881.png'),
            //                 ),
            //               ),
            //               SizedBox(
            //                 width: 10.w,
            //               ),
            //               Text(
            //                 chatPersonList[index],
            //                 style: AppTextStyle.readexTextStyle14Regular.copyWith(
            //                   color: AppColors.gray800,
            //                   fontWeight: FontWeight.w400,
            //                 ),
            //               ),
            //             ],
            //           ),
            //         );
            //       },
            //       itemCount: chatPersonList.length,
            //     ),
            //   ),
            // ),

            tag?.title == null && subject?.title == null
                ? Container(
                    color: AppColors.colorWhite,
                    padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            SubjectModel subjectModel =
                                SubjectModel(chatPersonList[index], 'https://cdn-icons-png.flaticon.com/512/206/206881.png', true);
                            setState(() {
                              subjectShow = !subjectShow;
                              subject = subjectModel;
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: 30.h),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(30.w),
                                  child: Container(
                                    height: 48.w,
                                    width: 48.w,
                                    decoration: const BoxDecoration(shape: BoxShape.circle),
                                    child: const CommonAppImage(imagePath: 'https://cdn-icons-png.flaticon.com/512/206/206881.png'),
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Text(
                                  chatPersonList[index],
                                  style: AppTextStyle.readexTextStyle14Regular(color: AppColors.gray800).copyWith(
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: chatPersonList.length,
                    ),
                  )
                : const SizedBox(),
            Expanded(
              child: Visibility(
                visible: show || subjectShow,
                child: SingleChildScrollView(
                  child: CommunicationSearchList(
                    tag: tag,
                    subjectList: subjectList,
                    showListView: showListView,
                    selectedSubject: subject,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CommunicationSearchList extends StatefulWidget {
  const CommunicationSearchList({
    Key? key,
    required this.tag,
    required this.subjectList,
    required this.showListView,
    required this.selectedSubject,
  }) : super(key: key);
  final TagModel? tag;
  final SubjectModel? selectedSubject;
  final List<SubjectModel> subjectList;
  final bool showListView;

  @override
  State<CommunicationSearchList> createState() => _CommunicationSearchListState();
}

class _CommunicationSearchListState extends State<CommunicationSearchList> {
  List<Photos>? communicationSearchPhtotsList = [];
  List<Videos>? communicationSearchVideosList = [];
  List<Documents>? communicationSearchDocumentsList = [];
  List<Links>? communicationSearchLinksList = [];

  @override
  void initState() {
    super.initState();
    readJson();
  }

  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/communication_search.json');
    final data = await json.decode(response);
    CommunicationSearchModel communicationSearchModel = CommunicationSearchModel.fromJson(data);
    if (widget.tag?.title != null) {
      if (widget.tag?.title == 'Photos') {
        setState(() {
          communicationSearchPhtotsList = communicationSearchModel.photos;
        });
      } else if (widget.tag?.title == 'Videos') {
        setState(() {
          communicationSearchVideosList = communicationSearchModel.videos;
        });
      } else if (widget.tag?.title == 'Documents') {
        setState(() {
          communicationSearchDocumentsList = communicationSearchModel.documents;
        });
      } else {
        setState(() {
          communicationSearchLinksList = communicationSearchModel.links;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.tag?.title != null
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                height: 70.h,
                child: ListView.builder(
                  shrinkWrap: false,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.only(left: 16.w),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 70.h,
                        height: 70.h,
                        padding: EdgeInsets.all(10.w),
                        margin: EdgeInsets.only(
                          right: 10.w,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.gray50,
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                            width: 1.w,
                            color: AppColors.gray200,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              widget.subjectList[index].filePath,
                              height: 28.h,
                              width: 30.w,
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Flexible(
                              child: Text(
                                widget.subjectList[index].title,
                                style: AppTextStyle.readexTextStyle10Regular(color: AppColors.gray600).copyWith(
                                  fontWeight: FontWeight.w400,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: widget.subjectList.length,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              searchTagData(widget.tag?.title ?? '')
            ],
          )
        : const CommunicationFeedList(
            isScrollable: false,
          );
  }

  Container searchTagData(String tag) {
    if (tag == 'Photos') {
      return Container(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: widget.showListView
              ? Container(
                  key: const Key('gallary'),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    itemBuilder: (context, index) {
                      Photos communicationData = communicationSearchPhtotsList?[index] ?? Photos();
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 5.h, bottom: 5.h),
                            child: Text(
                              communicationData.date.toString(),
                              style: AppTextStyle.poppinsTextStyle12Medium(
                                color: AppColors.gray800,
                              ),
                            ),
                          ),
                          GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 4.0,
                              mainAxisSpacing: 4.0,
                            ),
                            itemCount: (communicationData.photosMedia ?? []).length,
                            itemBuilder: (context, index) {
                              PhotosMedia media = (communicationData.photosMedia ?? [])[index];
                              return AppMediaWidget(
                                mediaUrl: media.medialUrl.toString(),
                                mediaType: getMediaTypeFromUrl(media.medialUrl.toString()),
                                borderRadius: BorderRadius.zero,
                                size: Size(122.w, 122.w),
                              );
                            },
                          ),
                          SizedBox(
                            height: 10.h,
                          )
                        ],
                      );
                    },
                    itemCount: communicationSearchPhtotsList?.length ?? 0,
                  ),
                )
              : Container(
                  key: const Key('list'),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    itemBuilder: (context, index) {
                      Photos communicationData = communicationSearchPhtotsList?[index] ?? Photos();
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 5.h, bottom: 5.h),
                            child: Text(
                              communicationData.date.toString(),
                              style: AppTextStyle.poppinsTextStyle12Regular(
                                color: AppColors.gray500,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                communicationData.name.toString(),
                                style: AppTextStyle.poppinsTextStyle12Medium(
                                  color: AppColors.gray700,
                                ),
                              ),
                              Text(
                                communicationData.time.toString(),
                                style: AppTextStyle.poppinsTextStyle10Medium(color: AppColors.gray500),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          communicationData.description.toString().isNotEmpty
                              ? Row(
                                  children: [
                                    AppMediaWidget(
                                      mediaUrl: communicationData.photosMedia?[0].medialUrl ?? '',
                                      mediaType: getMediaTypeFromUrl(communicationData.photosMedia?[0].medialUrl ?? ''),
                                      size: Size(80.h, 80.h),
                                      borderRadius: BorderRadius.circular(15.r),
                                    ),
                                    SizedBox(
                                      width: 24.w,
                                    ),
                                    Flexible(
                                      child: Text(
                                        communicationData.description.toString(),
                                        style: AppTextStyle.poppinsTextStyle12Regular(
                                          color: AppColors.gray500,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : Container(
                                  margin: EdgeInsets.only(top: 10.h),
                                  child: GridView.builder(
                                    physics: const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4,
                                      crossAxisSpacing: 8.w,
                                      // mainAxisSpacing: 16.h,
                                      childAspectRatio: 0.8,
                                    ),
                                    itemCount: (communicationData.photosMedia ?? []).length,
                                    itemBuilder: (context, index) {
                                      PhotosMedia media = (communicationData.photosMedia ?? [])[index];
                                      return AppMediaWidget(
                                        mediaUrl: media.medialUrl.toString(),
                                        mediaType: getMediaTypeFromUrl(media.medialUrl.toString()),
                                        size: Size(80.h, 80.h),
                                        borderRadius: BorderRadius.circular(15.r),
                                      );
                                    },
                                  ),
                                ),
                          SizedBox(
                            height: 48.h,
                          )
                        ],
                      );
                    },
                    itemCount: communicationSearchPhtotsList?.length ?? 0,
                  ),
                ),
        ),
      );
    } else if (tag == 'Videos') {
      return Container(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: widget.showListView
              ? Container(
                  key: const Key('gallary'),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    itemBuilder: (context, index) {
                      Videos communicationData = communicationSearchVideosList?[index] ?? Videos();
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 5.h, bottom: 5.h),
                            child: Text(
                              communicationData.date.toString(),
                              style: AppTextStyle.poppinsTextStyle12Medium(
                                color: AppColors.gray800,
                              ),
                            ),
                          ),
                          // Wrap(
                          //   direction: Axis.horizontal,
                          //   spacing: 10,
                          //   runSpacing: 10,
                          //   children: (communicationData.videosMedia ?? []).map((media) {
                          //     return AppMediaWidget(
                          //       mediaUrl: media.medialUrl.toString(),
                          //       thumbUrl: media.thumbUrl.toString(),
                          //       mediaType: getMediaTypeFromUrl(media.medialUrl.toString()),
                          //       size: Size(122.w, 122.h),
                          //       borderRadius: BorderRadius.zero,
                          //       customWidget: Container(
                          //         height: 122.h,
                          //         width: 122.w,
                          //         child: Stack(
                          //           children: [
                          //             Container(
                          //               foregroundDecoration: BoxDecoration(
                          //                 gradient: LinearGradient(
                          //                   begin: Alignment.bottomCenter,
                          //                   end: Alignment.topCenter,
                          //                   colors: [
                          //                     AppColors.colorBlack.withOpacity(0.6),
                          //                     AppColors.colorBlack.withOpacity(0.0),
                          //                   ],
                          //                   stops: const [
                          //                     0.0,
                          //                     0.3,
                          //                   ],
                          //                 ),
                          //               ),
                          //               child: Image.network(
                          //                 media.thumbUrl.toString(),
                          //                 fit: BoxFit.cover,
                          //                 height: 100.h,
                          //                 width: 100.w,
                          //               ),
                          //             ),
                          //             Positioned(
                          //               bottom: 0,
                          //               child: Padding(
                          //                 padding: EdgeInsets.all(6.w),
                          //                 child: Row(
                          //                   crossAxisAlignment: CrossAxisAlignment.center,
                          //                   children: [
                          //                     Container(
                          //                       padding: EdgeInsets.zero,
                          //                       decoration: const BoxDecoration(
                          //                         color: AppColors.colorWhite,
                          //                         shape: BoxShape.circle,
                          //                       ),
                          //                       child: Icon(
                          //                         Icons.play_arrow_rounded,
                          //                         color: AppColors.gray500,
                          //                         size: 18.h,
                          //                       ),
                          //                     ),
                          //                     SizedBox(
                          //                       width: 5.w,
                          //                     ),
                          //                     Text(
                          //                       '1:25',
                          //                       style: AppTextStyle.poppinsTextStyle14Medium(
                          //                         color: AppColors.colorWhite,
                          //                       ).copyWith(
                          //                         fontWeight: FontWeight.w600,
                          //                       ),
                          //                     )
                          //                   ],
                          //                 ),
                          //               ),
                          //             )
                          //           ],
                          //         ),
                          //       ),
                          //     );
                          //   }).toList(),
                          // ),
                          GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 8.w,
                              mainAxisSpacing: 8.h,
                              childAspectRatio: 0.9,
                            ),
                            itemCount: (communicationData.videosMedia ?? []).length,
                            itemBuilder: (context, index) {
                              VideosMedia media = (communicationData.videosMedia ?? [])[index];
                              return AppMediaWidget(
                                mediaUrl: media.medialUrl.toString(),
                                mediaType: getMediaTypeFromUrl(media.medialUrl.toString()),
                                size: Size(122.h, 122.h),
                                customWidget: Container(
                                  height: 122.h,
                                  width: 122.h,
                                  child: Stack(
                                    children: [
                                      Container(
                                        foregroundDecoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.bottomCenter,
                                            end: Alignment.topCenter,
                                            colors: [
                                              AppColors.colorBlack.withOpacity(0.6),
                                              AppColors.colorBlack.withOpacity(0.0),
                                            ],
                                            stops: const [
                                              0.0,
                                              0.3,
                                            ],
                                          ),
                                        ),
                                        child: Image.network(
                                          media.thumbUrl.toString(),
                                          fit: BoxFit.cover,
                                          height: 122.h,
                                          width: 122.h,
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 4.h,
                                        child: Padding(
                                          padding: EdgeInsets.all(6.w),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.zero,
                                                decoration: const BoxDecoration(
                                                  color: AppColors.colorWhite,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: Icon(
                                                  Icons.play_arrow_rounded,
                                                  color: AppColors.gray500,
                                                  size: 16.h,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5.w,
                                              ),
                                              Text(
                                                '1:25',
                                                style: AppTextStyle.poppinsTextStyle14Medium(
                                                  color: AppColors.colorWhite,
                                                ).copyWith(
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(
                            height: 10.h,
                          )
                        ],
                      );
                    },
                    itemCount: communicationSearchVideosList?.length ?? 0,
                  ),
                )
              : Container(
                  key: const Key('list'),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    itemBuilder: (context, index) {
                      Videos communicationData = communicationSearchVideosList?[index] ?? Videos();
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 5.h, bottom: 5.h),
                            child: Text(
                              communicationData.date.toString(),
                              style: AppTextStyle.poppinsTextStyle12Regular(
                                color: AppColors.gray500,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                communicationData.name.toString(),
                                style: AppTextStyle.poppinsTextStyle12Medium(
                                  color: AppColors.gray700,
                                ),
                              ),
                              Text(
                                communicationData.time.toString(),
                                style: AppTextStyle.poppinsTextStyle12Regular(
                                  color: AppColors.gray700,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          communicationData.description.toString().isNotEmpty
                              ? Row(
                                  children: [
                                    AppMediaWidget(
                                      mediaUrl: communicationData.videosMedia?[0].medialUrl ?? '',
                                      thumbUrl: communicationData.videosMedia?[0].thumbUrl.toString(),
                                      mediaType: getMediaTypeFromUrl(communicationData.videosMedia?[0].medialUrl ?? ''),
                                      size: Size(80.w, 80.h),
                                      borderRadius: BorderRadius.circular(15.r),
                                      customWidget: Container(
                                        height: 80.h,
                                        width: 80.w,
                                        child: Stack(
                                          children: [
                                            Container(
                                              foregroundDecoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  begin: Alignment.bottomCenter,
                                                  end: Alignment.topCenter,
                                                  colors: [
                                                    AppColors.colorBlack.withOpacity(0.6),
                                                    AppColors.colorBlack.withOpacity(0.0),
                                                  ],
                                                  stops: const [
                                                    0.0,
                                                    0.3,
                                                  ],
                                                ),
                                              ),
                                              child: Image.network(
                                                communicationData.videosMedia?[0].thumbUrl.toString() ?? '',
                                                fit: BoxFit.cover,
                                                height: 80.h,
                                                width: 80.w,
                                              ),
                                            ),
                                            Positioned(
                                              bottom: 0,
                                              child: Padding(
                                                padding: EdgeInsets.all(6.w),
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      padding: EdgeInsets.zero,
                                                      decoration: const BoxDecoration(
                                                        color: AppColors.colorWhite,
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Icon(
                                                        Icons.play_arrow_rounded,
                                                        color: AppColors.gray500,
                                                        size: 18.h,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 5.w,
                                                    ),
                                                    Text(
                                                      '1:25',
                                                      style: AppTextStyle.poppinsTextStyle14Medium(
                                                        color: AppColors.colorWhite,
                                                      ).copyWith(
                                                        fontWeight: FontWeight.w600,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 24.w,
                                    ),
                                    Flexible(
                                      child: Text(
                                        communicationData.description.toString(),
                                        style: AppTextStyle.poppinsTextStyle12Regular(
                                          color: AppColors.gray500,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : Container(
                                  margin: EdgeInsets.only(top: 10.h),
                                  child: Wrap(
                                    direction: Axis.horizontal,
                                    spacing: 16,
                                    runSpacing: 16,
                                    children: (communicationData.videosMedia ?? []).map((media) {
                                      return AppMediaWidget(
                                        mediaUrl: media.medialUrl.toString(),
                                        thumbUrl: media.medialUrl.toString(),
                                        mediaType: getMediaTypeFromUrl(media.medialUrl.toString()),
                                        size: Size(70.w, 70.h),
                                        borderRadius: BorderRadius.circular(15.r),
                                        customWidget: Container(
                                          height: 80.h,
                                          width: 80.w,
                                          child: Stack(
                                            children: [
                                              Container(
                                                foregroundDecoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                    begin: Alignment.bottomCenter,
                                                    end: Alignment.topCenter,
                                                    colors: [
                                                      AppColors.colorBlack.withOpacity(0.6),
                                                      AppColors.colorBlack.withOpacity(0.0),
                                                    ],
                                                    stops: const [
                                                      0.0,
                                                      0.3,
                                                    ],
                                                  ),
                                                ),
                                                child: Image.network(
                                                  communicationData.videosMedia?[0].thumbUrl.toString() ?? '',
                                                  fit: BoxFit.cover,
                                                  height: 80.h,
                                                  width: 80.w,
                                                ),
                                              ),
                                              Positioned(
                                                bottom: 0,
                                                child: Padding(
                                                  padding: EdgeInsets.all(6.w),
                                                  child: Row(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      Container(
                                                        padding: EdgeInsets.zero,
                                                        decoration: const BoxDecoration(
                                                          color: AppColors.colorWhite,
                                                          shape: BoxShape.circle,
                                                        ),
                                                        height: 16.h,
                                                        width: 16.h,
                                                        child: Icon(
                                                          Icons.play_arrow_rounded,
                                                          color: AppColors.gray500,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 5.w,
                                                      ),
                                                      Text(
                                                        '1:251',
                                                        style: AppTextStyle.poppinsTextStyle14Medium(
                                                          color: AppColors.colorWhite,
                                                        ).copyWith(
                                                          fontWeight: FontWeight.w600,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                          SizedBox(
                            height: 48.h,
                          )
                        ],
                      );
                    },
                    itemCount: communicationSearchVideosList?.length ?? 0,
                  ),
                ),
        ),
      );
    } else if (tag == 'Documents') {
      return Container(
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          itemCount: communicationSearchDocumentsList?.length ?? 0,
          itemBuilder: (context, index) {
            Documents communicationData = communicationSearchDocumentsList?[index] ?? Documents();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 16.h, bottom: 16.h),
                  child: Text(
                    communicationData.date.toString(),
                    style: AppTextStyle.poppinsTextStyle12Regular(
                      color: AppColors.gray500,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      communicationData.name.toString(),
                      style: AppTextStyle.poppinsTextStyle12Medium(
                        color: AppColors.gray700,
                      ),
                    ),
                    Text(
                      communicationData.time.toString(),
                      style: AppTextStyle.poppinsTextStyle10Medium(
                        color: AppColors.gray500,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    color: AppColors.gray50,
                    borderRadius: BorderRadius.circular(14.r),
                    border: Border.all(color: AppColors.gray100, width: 1),
                  ),
                  child: Row(
                    children: [
                      AppMediaWidget(
                        mediaUrl: communicationData.documentsMedia?[0].medialUrl ?? '',
                        mediaType: getMediaTypeFromUrl(communicationData.documentsMedia?[0].medialUrl ?? ''),
                        size: Size(40.h, 40.h),
                        margin: EdgeInsets.zero,
                        backgroundColor: Colors.transparent,
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              fileNameFromUrl(communicationData.documentsMedia?[0].medialUrl ?? ''),
                              style: AppTextStyle.poppinsTextStyle14Regular(
                                color: AppColors.gray800,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              '30 kb',
                              style: AppTextStyle.poppinsTextStyle12Medium(
                                color: AppColors.gray500,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                ((communicationSearchDocumentsList ?? []).length - 1) == index
                    ? SizedBox(
                        height: 10.h,
                      )
                    : SizedBox()
              ],
            );
          },
        ),
      );
    } else if (tag == 'Links') {
      return Container(
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          itemBuilder: (context, index) {
            Links communicationData = communicationSearchLinksList?[index] ?? Links();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 24.h, bottom: 8.h),
                  child: Text(
                    communicationData.date.toString(),
                    style: AppTextStyle.poppinsTextStyle12Regular(
                      color: AppColors.gray500,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      communicationData.name.toString(),
                      style: AppTextStyle.poppinsTextStyle12Medium(
                        color: AppColors.gray700,
                      ),
                    ),
                    Text(
                      communicationData.time.toString(),
                      style: AppTextStyle.poppinsTextStyle10Medium(
                        color: AppColors.gray500,
                      ),
                    ),
                  ],
                ),
                communicationData.description.toString().isNotEmpty
                    ? Column(
                        children: [
                          SizedBox(
                            height: 4.h,
                          ),
                          Text(
                            communicationData.description.toString(),
                            style: AppTextStyle.poppinsTextStyle12Regular(
                              color: AppColors.gray500,
                            ),
                          ),
                        ],
                      )
                    : const SizedBox(),
                SizedBox(
                  height: 4.h,
                ),
                Container(
                  width: Utils.getScreenWidth,
                  decoration: BoxDecoration(
                    color: AppColors.gray50,
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Row(
                    children: [
                      AppMediaWidget(
                        mediaUrl: communicationData.linksMedia?[0].medialUrl ?? '',
                        mediaType: getMediaTypeFromUrl(communicationData.linksMedia?[0].medialUrl ?? ''),
                        // size: Size(78.w, 78.h),
                        margin: EdgeInsets.zero,
                        backgroundColor: Colors.transparent,
                        borderRadius: BorderRadius.circular(15.r),
                        customWidget: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15.r),
                            bottomLeft: Radius.circular(15.r),
                          ),
                          child: Image.network(
                            getThumbUrlFromYoutubeLink(videoUrl: communicationData.linksMedia?[0].medialUrl ?? ''),
                            height: 78.w,
                            width: 78.w,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'STEM - Numeracy Book - Saarthi Pedagogy',
                              style: AppTextStyle.poppinsTextStyle12Regular(
                                color: AppColors.gray800,
                              ),
                            ),
                            Text(
                              'www.youtube.com',
                              style: AppTextStyle.poppinsTextStyle12Regular(
                                color: AppColors.gray500,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                (communicationSearchLinksList ?? []).length - 1 == index
                    ? SizedBox(
                        height: 20.h,
                      )
                    : SizedBox()
              ],
            );
          },
          itemCount: communicationSearchLinksList?.length ?? 0,
        ),
      );
    } else {
      return Container();
    }
  }

  String fileNameFromUrl(String url) {
    return url.substring(url.lastIndexOf('/') + 1);
  }
}

class TagModel {
  final String title;
  final String inActiveIcon;
  final String activeIcon;

  TagModel(this.title, this.inActiveIcon, this.activeIcon);
}

class SubjectModel {
  final String title;
  final String filePath;
  final bool isNetworkImage;

  SubjectModel(this.title, this.filePath, this.isNetworkImage);
}
