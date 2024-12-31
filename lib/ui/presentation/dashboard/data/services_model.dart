import '../../../../utils/string_utils.dart';

class ServicesModel {
  final String image;
  final String desc;

  ServicesModel({required this.image, required this.desc});
}

List<ServicesModel> serviceList = [
  ServicesModel(
      image: '$imagePrefixIcons/building.png',
      desc: 'Building projects Constructing'),
  ServicesModel(
      image: '$imagePrefixIcons/brick.png',
      desc: 'Rehabitation & Renovation works'),
  ServicesModel(
      image: '$imagePrefixIcons/vehicle.png', desc: 'Mechanical construction'),
  ServicesModel(
      image: '$imagePrefixIcons/post.png', desc: 'Electrical Construction '),
  ServicesModel(
      image: '$imagePrefixIcons/settings.png', desc: 'Facility managment'),
  ServicesModel(image: '$imagePrefixIcons/tv.png', desc: 'ELV & ICT Systems'),
];

List<ServicesModel> aboutModel = [
  ServicesModel(
      image: 'ABOUT US ',
      desc:
          '''El Race Cons. & Gen. Cont. Co. LLC is one of the fastest growing construction firms in the United Arab
Emirates. Since its launch in 1985 in Al Ain alongside
its acquisition of a wide array of plant equipment and
team of highly qualified personnel, we were able to
seize and execute a diverse and far-reaching portfolio
of major construction projects in almost all sectors of
real estate and FM. Currently, our workload at hand
stands to hundreds of millions worth of contracts.'''),
  ServicesModel(image: 'MISSION', desc: '''
  El Race Cons. & Gen. Cont. Co. LLC is not just a construction company,
  We are a dedicated team striving to bring growth to our community,
heling to maintain
existing companies, and assisting our clients in 
making their dreams become
a reality.'''),
  ServicesModel(image: 'VISION', desc: '''
  El Race Cons. & Gen. Cont. Co. LLC is committed to building long-term relationships
based on integrity, performance, value, and client satisfaction. We will continue to meet the changing needs of our clients with our quality services
delivered by the most qualified people.''')
];

class ContactsModel {
  final String loction;
  final String telePhone;
  final String fax;
  final String po;
  final String email;

  ContactsModel({
    required this.loction,
    required this.telePhone,
    required this.fax,
    required this.po,
    required this.email,
  });
}

List<ContactsModel> contactList = [
  ContactsModel(
      loction: 'ALAIN | UAE ',
      telePhone: 'T | +971[3] 7825644',
      fax: 'FAX | +971[3] 7825600',
      po: 'P.O.BOX | 1841 ',
      email: 'EMAIL | INFO@ELRACE.COM'),
  ContactsModel(
      loction: 'ABU DHABI | UAE  ',
      telePhone: 'T | +971[2] 6337083',
      fax: 'FAX | +971[2]6337085',
      po: 'P.O.BOX | 53270 ',
      email: 'EMAIL | rcc12008@eim.ae'),
  ContactsModel(
      loction: 'ZAYED CITY | UAE  ',
      telePhone: 'T | +971[2] 8882488',
      fax: 'FAX | +971[2] 8845050',
      po: 'P.O.BOX | 294266 ',
      email: 'EMAIL l info.wrb@elrace.com'),
  ContactsModel(
      loction: 'DUBAI | UAE ',
      telePhone: 'T | +971[4] 3337374',
      fax: 'FAX l +971[4] 3337937',
      po: 'P.O.BOX | 624437',
      email: 'EMAIL | info.dubai@elrace.com')
];
