import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

final List<String> titleCard = [
  '12.2 Crore Indians',
  '2.7 Crore of which are between the Age of 20-30',
  'Businesses Closed',
  'Huge Barrier',
  'Launch of SHRAVIK APP',
  'Centralized Database',
  'Breaking the Language Barrier',
];

final List<String> urls = [
  'https://firebasestorage.googleapis.com/v0/b/shramikvikas-app.appspot.com/o/1.jpg?alt=media&token=d7c0389d-2aea-4f8b-b5c5-5156a6e0ddb9',
  'https://firebasestorage.googleapis.com/v0/b/shramikvikas-app.appspot.com/o/2.jpg?alt=media&token=304f203e-ed17-49e7-a67f-2abdb8336d6d',
  'https://firebasestorage.googleapis.com/v0/b/shramikvikas-app.appspot.com/o/3.jpg?alt=media&token=e3c5cd9f-76ae-441f-bed4-96fbb3296634',
  'https://firebasestorage.googleapis.com/v0/b/shramikvikas-app.appspot.com/o/4.jpg?alt=media&token=1bf5d098-af53-49b1-99e7-e03ee0b24471',
  'https://firebasestorage.googleapis.com/v0/b/shramikvikas-app.appspot.com/o/5.jpg?alt=media&token=8b17b7fd-5fb5-4f68-939a-cf8f253ed74a',
  'https://firebasestorage.googleapis.com/v0/b/shramikvikas-app.appspot.com/o/6.png?alt=media&token=c204b18f-5d06-4feb-bd4f-872db29104fc',
  'https://firebasestorage.googleapis.com/v0/b/shramikvikas-app.appspot.com/o/7.png?alt=media&token=f36100e8-8c70-4d1f-8cb8-c1bacb299434',
];

final List<String> bodyCard = [
  'These are the number of people who lost their jobs due to the Covid-19 Pandemic.',
  'Most migrant labourers have returned to their homestate due to the lack of jobs in Metro Cities.',
  'Companies are hitting bankruptsy due to the lack of shortage of Workforce and Resources.',
  'A huge gap exists between Business Owners and Migrant Labour.',
  'SHRAVIK is an initiative to build a better India where Labour and Employers can contact and help each other during these hard times.',
  'The collected data is made available to Employers looking for Labour and Migrant Workers looking for Jobs.',
  'SHRAVIK APP is available in both ENGLISH and हिन्दी which makes is extremely accessible.'
];

final List<Widget> imageSliders = titleCard
    .map((item) => Container(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              color: Colors.white,
            ),
            margin: EdgeInsets.all(5.0),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    titleCard[titleCard.indexOf(item)],
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Container(
                    // child: Image.network(urls[titleCard.indexOf(item)])),
                    child: CachedNetworkImage(
                        imageUrl: urls[titleCard.indexOf(item)]),
                  ),
                  Text(
                    bodyCard[titleCard.indexOf(item)],
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ))
    .toList();
