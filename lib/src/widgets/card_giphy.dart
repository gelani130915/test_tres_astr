import 'package:flutter/material.dart';
import 'package:test_tecn/src/widgets/like_button.dart';
import 'package:url_launcher/url_launcher.dart';

class CardGiphy extends StatefulWidget {
  String idGiphy;
  String title;
  CardGiphy({Key? key, required this.idGiphy, required this.title}) : super(key: key);

  @override
  State<CardGiphy> createState() => _CardGiphyState();
}

class _CardGiphyState extends State<CardGiphy> {
  @override
  Widget build(BuildContext context) {
    return Card( 
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5, right: 15),
                child: InkWell(
                  splashColor: Colors.transparent,
                  child: Icon(Icons.more_horiz, size: 26, color: Colors.grey[400]),
                  onTap: (){
                    showModalBottomSheet(
                      context: context, 
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      builder: (_){
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              leading: const Icon(Icons.public),
                              title: const Text(
                                'Visit Giphy', 
                              ),
                              onTap: ()async {
                                if(await canLaunchUrl(Uri.parse('https://giphy.com'))){
                                  launchUrl(Uri.parse('https://giphy.com'));
                                }
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.groups),
                              title: const Text(
                                'Visit Tres Artronautas', 
                              ),
                              onTap: ()async {
                                if(await canLaunchUrl(Uri.parse('https://www.tresastronautas.com'))){
                                  launchUrl(Uri.parse('https://www.tresastronautas.com'));
                                }
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.share),
                              title: const Text(
                                'Share', 
                              ),
                              onTap: (){},
                            ),
                          ],
                        ),
                      );
                    });
                  },
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20, left: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [ 
                Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.topCenter,
                      children: [
                        const Padding(child: CircularProgressIndicator(color: Colors.orange,), padding: EdgeInsets.all(10),),
                        Container(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: Container(
                            height: 100,
                            width: 150, 
                            decoration: BoxDecoration( 
                              border: Border.all(color: Colors.transparent),
                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                              image: DecorationImage(
                                image: NetworkImage('https://i.giphy.com/media/${widget.idGiphy}/200.gif'),
                                fit: BoxFit.cover
                              )
                            ),  
                          ),
                        ),
                      ],
                    ),
                    LikeButton() 
                  ],
                ), 
                const SizedBox(width: 20),
                Expanded(
                  child: Text(
                    widget.title,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle( 
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}