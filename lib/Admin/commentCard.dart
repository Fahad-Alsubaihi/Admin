import 'package:Admin/Admin/GymModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:Admin/Styles.dart';
import '../models/review.dart';
import '../models/user.dart';

class commentCard extends StatefulWidget {
  final Review review;
  final String gymId;
  const commentCard({Key? key, required this.review, required this.gymId})
      : super(key: key);

  @override
  State<commentCard> createState() => _commentCardState();
}

class _commentCardState extends State<commentCard> {
  deleteReview() {
    FirebaseFirestore.instance
        .collection('gyms')
        .doc(widget.gymId)
        .collection('Review')
        .doc(widget.review.uid)
        .delete()
        .whenComplete(() => FirebaseFirestore.instance
                .collection('gyms')
                .where('isWaiting', isEqualTo: false)
                .get()
                .then((value) {
              value.docs.forEach((element) {
                Review.setRateToGym(element.reference.id);
              });
            }));
    FirebaseFirestore.instance
        .collection('Customer')
        .doc(widget.review.uid)
        .update({
      'reviews': FieldValue.arrayRemove([widget.gymId])
    });
  }

  Widget AlertDialogs() {
    return AlertDialog(
      title: Text(
        'Delete Review?',
        style: TextStyle(color: colors.red_base),
      ),
      content: Text('Are you sure you want to delete this review?'),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
              deleteReview();
            },
            child: Text(
              'Yes',
              style: TextStyle(color: colors.red_base),
            )),
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'No',
              style: TextStyle(color: colors.blue_base),
            )),
      ],
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 24,
      // backgroundColor: colors.blue_smooth,
    );
  }

  bool readmore = false;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width - 100;
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ClipOval(
                    child: Image.network(
                      widget.review.profileimg,
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return CircleAvatar(
                          radius: 50,
                          backgroundColor: colors.blue_smooth,
                          child: Icon(
                            Icons.person,
                            size: 85,
                            color: colors.iconscolor,
                          ),
                        );
                      },
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: SizedBox(
                          // width: screenWidth,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 5),
                                      child: Text(
                                        widget.review.name,
                                        style: TextStyle(
                                            color: colors.blue_base,
                                            fontSize: 30),
                                      ),
                                    ),
                                  ]),
                              Padding(
                                padding: EdgeInsets.only(bottom: 5),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.6,
                                  child: Text(
                                    widget.review.comment,
                                    maxLines: readmore ? null : 2,
                                    overflow: readmore
                                        ? TextOverflow.visible
                                        : TextOverflow.fade,
                                    style: TextStyle(
                                        color: colors.black60, fontSize: 30),
                                  ),
                                ),
                              ),
                              if (widget.review.comment.length > 130)
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      readmore = !readmore;
                                    });
                                  },
                                  child: Text(
                                    readmore ? 'read less' : 'read more',
                                    style: TextStyle(
                                        color: colors.blue_base, fontSize: 13),
                                  ),
                                )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      for (var i = 0; i < widget.review.rate; i++)
                        Icon(
                          Icons.star,
                          size: 40,
                          color: colors.yellow_base,
                        ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(widget.review.time.toString()),
                    ],
                  ),
                ],
              ),
              SizedBox(
                width: 200,
              ),
              Container(
                margin: EdgeInsets.only(right: 30),
                child: TextButton(
                  child: Text(
                    'Delete Review',
                    style: TextStyle(color: colors.red_base),
                  ),
                  onPressed: () {
                    showDialog(
                        context: context, builder: (_) => AlertDialogs());
                  },
                ),
              ),
            ],
          ),
          Divider(
            color: colors.black60,
          ),
        ],
      ),
    );
  }
}
