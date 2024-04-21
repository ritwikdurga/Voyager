import 'dart:ui';

final Map<String, String> descrption = {
  'Goa':
      "Goa, a tiny emerald on the west coast of India, with its natural Scenic beauty, abundant greenery, attractive beaches, historical temples and churches, colourful feasts and festivals, and above all warm and hospitable people with a rich cultural milieu, has today emerged as an ideal tourist destination worldwide.",
  'Manali':
      "Manali is a town, near Kullu town in Kullu district in the Indian state of Himachal Pradesh.[2] It is situated in the northern end of the Kullu Valley, formed by the Beas River.he Kullu Valley in which Manali is situated is often referred to as the \"Valley of the Gods\". An old village in the town has an ancient temple dedicated to the sage Manu.",
  'Hyderabad':
      "Hyderabad is the capital of one of the most techno savvy state in India,Telangana. The previous name of this city was Bagyanagaram.This city is also called the ‘city of pearls’ because of the major dealing of pearls that is done from this part of the state. Hyderabad was founded in 1591 and planned as a grid with the Charminar at its centre.",
  "Delhi":
      "Delhi, the vibrant capital city of India, is a mesmerizing blend of rich history, diverse cultures, and bustling modernity. Nestled along the banks of the Yamuna River in the northern part of the country, Delhi is a kaleidoscope of sights, sounds, and flavors that leave every traveler enchanted.",
  "Chennai":
      "Chennai, city, capital of Tamil Nadu state, southern India, located on the Coromandel Coast of the Bay of Bengal. Known as the “Gateway to South India,” Chennai is a major administrative and cultural centre.",
  "Jaipur":
      'Jaipur became known as “The Pink City” when, in 1876, Maharaja Ram Singh had most of the buildings painted pink—the color of hospitality—in preparation for a visit by Britain\'s Queen Victoria. Today, the city is known for its bazaars, forts, temples, palaces, and wildlife sanctuaries.'
};

final List<String> places = [
  'Manali',
  'Delhi',
  'Goa',
  'Chennai',
  'Hyderabad',
  'Jaipur',
];

final Map<String, List<String>> destImg = {
  'Manali': [
    'https://www.holidify.com/images/cmsuploads/compressed/15655691644_c0a92b03d7_z_20190305135005.jpg',
    'https://www.holidify.com/images/cmsuploads/compressed/My_Manali_20190313142828.jpg',
    'https://www.holidify.com/images/cmsuploads/compressed/manali-1941788_960_720_20190313162556.jpg',
    'https://www.holidify.com/images/cmsuploads/compressed/28022192021_b8e82eb874_b_20190320141704.jpg',
    'https://www.holidify.com/images/compressed/490.jpg?v=1.1',
  ],
  'Chennai': [
    'https://www.holidify.com/images/compressed/3161.jpg?v=1.1',
    'https://www.holidify.com/images/cmsuploads/compressed/Tiruvallikeni1_20190802102357.jpg',
    'https://www.holidify.com/images/cmsuploads/compressed/Kapaleeswarar1_20190405110338.jpg',
    'https://www.holidify.com/images/compressed/dest_wiki_2985.jpg',
    'https://www.holidify.com/images/cmsuploads/compressed/_20f43414-11f3-11e7-be49-55692bf38950_20190802104320.jpg',
    'https://www.holidify.com/images/cmsuploads/compressed/MGR_Memorial_9_December_2007_20190802111445.jpg',
  ],
  'Delhi': [
    'https://www.holidify.com/images/cmsuploads/compressed/Redfortdelhi1_20190731143243.jpg',
    'https://www.holidify.com/images/cmsuploads/compressed/Qutub_Minar_932_20190731143921.jpg',
    'https://www.holidify.com/images/cmsuploads/compressed/Safdar_Jangs_Tomb_Delhi__20190731144059.jpg',
    'https://www.holidify.com/images/cmsuploads/compressed/Akshardham_angled_20190731153142.jpg',
    'https://www.holidify.com/images/cmsuploads/compressed/Jama_masjid_dilli6_20190731152644.jpg',
  ],
  'Goa': [
    'https://www.holidify.com/images/cmsuploads/compressed/download_20190305103317.jpeg',
    'https://www.holidify.com/images/cmsuploads/compressed/shutterstock_1122030473_20191021122828.jpg',
    'https://www.holidify.com/images/cmsuploads/compressed/butterfly-beach_20171116114709.jpg',
    'https://www.holidify.com/images/cmsuploads/compressed/Chapora_Fort_20180428123835.jpg',
    'https://www.holidify.com/images/compressed/dest_wiki_5251.jpg',
  ],
  'Hyderabad': [
    'https://www.holidify.com/images/compressed/1290.jpg?v=1.1',
    'https://www.holidify.com/blog/wp-content/uploads/2014/07/Golconda-fort.jpg',
    'https://www.holidify.com/images/cmsuploads/compressed/hqdefault_20190421132442.jpg',
    'https://www.holidify.com/images/cmsuploads/compressed/Falaknuma_Palace_20180806155019_20180806155054.jpg',
    'https://www.holidify.com/images/cmsuploads/compressed/6261970602_4dc62e5f4d_b(1)_20180806201136_20180806201207.jpg',
  ],
  'Jaipur': [
    'https://www.holidify.com/images/cmsuploads/compressed/JaipurJaigarhFort_20190206182007jpg',
    'https://www.holidify.com/images/cmsuploads/compressed/13515941894_d1880b9937_o_20190529165118.jpg',
    'https://www.holidify.com/images/cmsuploads/compressed/PATRIKA_GATE_AT_JAWAHAR_CIRCLE_JAIPUR_20190710121707.jpg',
    'https://www.holidify.com/images/cmsuploads/compressed/Amer-Fort_20190710175340.jpg',
    'https://www.holidify.com/images/cmsuploads/compressed/Monkey-Temple-in-Jaipur_20190710175937.jpg',
  ]
};

final Map<String, String> placeImgURL = {
  'Manali': "https://www.holidify.com/images/bgImages/MANALI.jpg",
  'Delhi': "https://www.holidify.com/images/bgImages/DELHI.jpg",
  'Goa': "https://www.holidify.com/images/bgImages/GOA.jpg",
  'Chennai': "https://www.holidify.com/images/bgImages/CHENNAI.jpg",
  'Hyderabad': "https://www.holidify.com/images/bgImages/HYDERABAD.jpg",
  'Jaipur': "https://www.holidify.com/images/bgImages/JAIPUR.jpg",
  'Hidimba Temple':
      'https://www.holidify.com/images/cmsuploads/compressed/attr_1888_20190308172811.jpg',
  'Solang Valley':
      'https://www.holidify.com/images/cmsuploads/compressed/shutterstock_633164246_20190904103856_20190904103926.jpg',
  'Rohtang Pass':
      'https://www.holidify.com/images/cmsuploads/compressed/490_20190308180742.jpg',
  'Vashisht Temple':
      'https://www.holidify.com/images/cmsuploads/compressed/Vashisht_temple_20230213165830.jpg',
  'Kullu': 'https://www.holidify.com/images/bgImages/KULLU.jpg',
  'Hampta Pass Trek':
      'https://www.holidify.com/images/cmsuploads/compressed/attr_wiki_3779_20180905111222.jpg',
  'Jogini Waterfall':
      'https://www.holidify.com/images/cmsuploads/compressed/Jogini_falls_20180430173032.jpg',
  'Nicholas Roerich Art Gallery':
      'https://www.holidify.com/images/cmsuploads/compressed/IMG_76581_20190403115406_20190403115422.jpg',
  'Marina Beach':
      'https://www.holidify.com/images/cmsuploads/compressed/attr_wiki_426_20200726215816.jpg',
  'India Gate': 'https://www.holidify.com/images/bgImages/DELHI.jpg',
  'Qutub Minar':
      'https://www.holidify.com/images/cmsuploads/compressed/Qutub_Minar_in_the_monsoons_20170908115259.jpg',
  "Humayun's Tomb":
      'https://www.holidify.com/images/cmsuploads/compressed/Humayun-tomb_20170809201316.jpg',
  "Lotus Temple":
      'https://www.holidify.com/images/cmsuploads/compressed/9713607938_4bd9507080_b_20180302141225.jpg',
  'Red Fort':
      'https://www.holidify.com/images/cmsuploads/compressed/Delhi_Red_fort_20190312151147.jpg',
  'Chandni Chowk':
      'https://www.holidify.com/images/cmsuploads/compressed/-26975_10253_20170814163325.jpg',
  'Gurudwara Bangla Sahib':
      'https://www.holidify.com/images/cmsuploads/compressed/BanglaSahib_20200417130034.jpg',
  'Jama Masjid Delhi':
      'https://www.holidify.com/images/cmsuploads/compressed/crowd-of-people-gathering-near-jama-masjid-delhi-2989625_20200427110709.jpg',
  'Connaught Place':
      'https://www.holidify.com/images/cmsuploads/compressed/museum-of-illusions-new-delhi-reverse-room-800x0-c-default_20220223180238.jpeg',
  'Rashtrapati Bhavan':
      'https://www.holidify.com/images/cmsuploads/compressed/RASHTRAPATI_BHAVAN_20170809125606.jpg',
  "Calangute Beach":
      'https://www.holidify.com/images/cmsuploads/compressed/shutterstock_1314723038_20190822145625.jpg',
  "Fort Aguada":
      'https://www.holidify.com/images/cmsuploads/compressed/shutterstock_1065727913_20190822150731.jpg',
  "Dudhsagar Falls":
      'https://www.holidify.com/images/cmsuploads/compressed/shutterstock_248465767_20190822151157.jpg',
  "Anjuna Beach":
      'https://www.holidify.com/images/cmsuploads/compressed/shutterstock_1065723824_20190822151024.jpg',
  "Chapora Fort":
      'https://www.holidify.com/images/cmsuploads/compressed/Chapora_Fort_20180428123835.jpg',
  "Basilica of Bom Jesus":
      'https://www.holidify.com/images/cmsuploads/compressed/shutterstock_1073481062_20190822145857.jpg',
  "Baga Beach":
      'https://www.holidify.com/images/compressed/attractions/attr_1828.jpg',
  "Butterfly Beach":
      'https://www.holidify.com/images/cmsuploads/compressed/butterfly-beach_20171116114709.jpg',
  "Scuba Diving in Goa":
      'https://www.holidify.com/images/cmsuploads/compressed/25542686_106125563518531_9100064433593671984_o_20180605124924.jpg',
  "Dona Paula":
      'https://www.holidify.com/images/cmsuploads/compressed/3205_20200511154307.jpg',
  "Government Museum":
      'https://www.holidify.com/images/cmsuploads/compressed/Madras_museum_theatre_in_October_2007_20181129222446.jpg',
  "Arignar Anna Zoological Park":
      'https://www.holidify.com/images/cmsuploads/compressed/a1_20170927161112.PNG',
  "Valluvar Kottam":
      'https://www.holidify.com/images/cmsuploads/compressed/Valluvar_Kottam_at_Night_20190222095525jpg',
  "Ashtalakshmi Temple":
      'https://www.holidify.com/images/cmsuploads/compressed/3167_20190304071019.jpg',
  "Elliot's Beach":
      'https://www.holidify.com/images/cmsuploads/compressed/Elliots_Beach_Chennai_20180105203119.jpg',
  "Dakshinachitra Museum":
      'https://www.holidify.com/images/cmsuploads/compressed/Dakshinachitra-Muttukadu_20180212125820.jpg',
  "Thousand Lights Mosque":
      'https://www.holidify.com/images/cmsuploads/compressed/Thousand-Lights-Mosque-1_20180510130631.jpg',
  "Fort St. George":
      'https://www.holidify.com/images/cmsuploads/compressed/1200px-Fort_St._George,_Chennai_2_20180511225120.jpg',
  "Royapuram Fishing Harbour":
      'https://www.holidify.com/images/cmsuploads/compressed/6677895083_4da1512e37_b_20180511162153.jpg',
  "Ramoji Film City":
      'https://www.holidify.com/images/compressed/attractions/attr_1595.jpg',
  "Hussain Sagar Lake":
      'https://www.holidify.com/images/cmsuploads/compressed/Hussain_Sagar_Lake2C_Hyderabad_20230309151019.jpg',
  "Golconda Fort":
      'https://www.holidify.com/images/cmsuploads/compressed/attr_1565_20180806200940.jpg',
  "Charminar":
      'https://www.holidify.com/images/cmsuploads/compressed/The-Charminar-321141-pixahive_20220523164753.jpeg',
  "Thrill City":
      'https://www.holidify.com/images/cmsuploads/compressed/144dc4c2-34b7-4a96-b1d6-29968c124db4_20220523155512.jpeg',
  "Wonderla":
      'https://www.holidify.com/images/cmsuploads/compressed/twccvrvb_20220523165223.jpeg',
  "Statue of Equality":
      'https://www.holidify.com/images/cmsuploads/compressed/LEELA-JALA-NEERAJANAM_20220523153756.jpeg',
  "GravityZip":
      'https://www.holidify.com/images/cmsuploads/compressed/HomeGravityZipPreview_20220523160405.jpeg',
  "Chowmahalla Palace":
      'https://www.holidify.com/images/cmsuploads/compressed/13761119445755c029184b_20220523165504.jpeg',
  "Shilparamam":
      'https://www.holidify.com/images/cmsuploads/compressed/Hyd_Shilparamam_Entrance_20180806155225_20180806155234.jpg',
  "Amber Palace":
      'https://www.holidify.com/images/cmsuploads/compressed/Amer-Fort_20220106125351.jpg',
  "City Palace Jaipur":
      'https://www.holidify.com/images/cmsuploads/compressed/shutterstock_1081660136(1)_20190904115748.jpg',
  "Jantar Mantar Jaipur":
      'https://www.holidify.com/images/cmsuploads/compressed/shutterstock_579266854_20190904113343.jpg',
  "Hawa Mahal":
      'https://www.holidify.com/images/cmsuploads/compressed/h4_20170822181427.PNG',
  "Nahargarh Fort":
      'https://www.holidify.com/images/cmsuploads/compressed/3308512331_ef4ff4cd95_b_20190904120123.jpg',
  "Birla Temple Jaipur":
      'https://www.holidify.com/images/cmsuploads/compressed/1830_20190228143437.jpg',
  "Jal Mahal":
      'https://www.holidify.com/images/cmsuploads/compressed/2133972013_3e75319129_b_20170908122016.jpg',
  "Albert Hall Museum (Central Museum)":
      'https://www.holidify.com/images/cmsuploads/compressed/Albert_Hall_Museum_Night_View_20171004165444.jpg',
  "Jaipur Zoo":
      'https://www.holidify.com/images/cmsuploads/compressed/1024px-Gharial_28Gavialis_gangeticus29_juvenile_281981204414929_20190618205613.jpg',
  "Chokhi Dhani":
      'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.makemytrip.com%2Fhotels%2Fchokhi_dhani_the_ethnic_village_and_desert_camp_resort-details-jaisalmer.html&psig=AOvVaw1kJ17Pti66uLqqVFspuaMp&ust=1713631127972000&source=images&cd=vfe&opi=89978449&ved=0CBIQjRxqFwoTCKjajcfbzoUDFQAAAAAdAAAAABAE',
};

final Map<String, List<String>> attractions = {
  'Manali': [
    'Hidimba Temple',
    'Solang Valley',
    'Rohtang Pass',
    'Vashisht Temple',
    'Kullu',
    'Hampta Pass Trek',
    'Jogini Waterfall',
    'Nicholas Roerich Art Gallery',
  ],
  'Delhi': [
    'India Gate',
    'Qutub Minar',
    "Humayun's Tomb",
    "Lotus Temple",
    'Red Fort',
    'Chandni Chowk',
    'Gurudwara Bangla Sahib',
    'Jama Masjid Delhi',
    'Connaught Place',
    'Rashtrapati Bhavan',
  ],
  'Goa': [
    "Calangute Beach",
    "Fort Aguada",
    "Dudhsagar Falls",
    "Anjuna Beach",
    "Chapora Fort",
    "Basilica of Bom Jesus",
    "Baga Beach",
    "Butterfly Beach",
    "Scuba Diving in Goa",
    "Dona Paula"
  ],
  'Chennai': [
    "Marina Beach",
    "Government Museum",
    "Arignar Anna Zoological Park",
    "Valluvar Kottam",
    "Ashtalakshmi Temple",
    "Elliot's Beach",
    "Dakshinachitra Museum",
    "Thousand Lights Mosque",
    "Fort St. George",
    "Royapuram Fishing Harbour"
  ],
  'Hyderabad': [
    "Ramoji Film City",
    "Hussain Sagar Lake",
    "Golconda Fort",
    "Charminar",
    "Thrill City",
    "Wonderla",
    "Statue of Equality",
    "GravityZip",
    "Chowmahalla Palace",
    "Shilparamam"
  ],
  'Jaipur': [
    "Amber Palace",
    "City Palace Jaipur",
    "Jantar Mantar Jaipur",
    "Hawa Mahal",
    "Nahargarh Fort",
    "Birla Temple Jaipur",
    "Jal Mahal",
    "Albert Hall Museum (Central Museum)",
    "Jaipur Zoo",
    "Chokhi Dhani"
  ],
};

final Map<String, String> attDes = {
  'Hidimba Temple':
      'Nestled amidst the lush forests of Manali, the Hidimba Temple is an ancient cave temple dedicated to Hidimbi Devi, a character from the Hindu epic Mahabharata. Built in the 16th century, its unique architectural style and tranquil surroundings make it a popular pilgrimage site and a serene spot for meditation.',
  'Solang Valley':
      'Located at a breathtaking altitude in the Himalayas, Solang Valley is a paradise for adventure enthusiasts. Offering a wide range of thrilling activities such as paragliding, zorbing, skiing, and snowmobiling, this picturesque valley captivates visitors with its panoramic vistas of snow-capped peaks and lush greenery.',
  'Rohtang Pass':
      'Situated on the eastern Pir Panjal Range of the Himalayas, Rohtang Pass is a high mountain pass renowned for its stunning natural beauty and adventurous terrain. Surrounded by towering snow-capped peaks, glaciers, and pristine valleys, it offers breathtaking panoramic views and is a popular destination for trekking, skiing, and snowboarding.',
  'Vashisht Temple':
      "Dedicated to Sage Vashisht, the Vashisht Temple is an ancient pilgrimage site famous for its natural hot springs. Believed to possess medicinal properties, the hot springs attract visitors seeking relaxation and rejuvenation. The temple's architecture, adorned with intricate carvings and sculptures, adds to its spiritual ambiance.",
  'Kullu':
      'Situated amidst the picturesque Kullu Valley, the town of Kullu is renowned for its natural beauty, vibrant culture, and adventure sports. Surrounded by snow-capped mountains and lush greenery, Kullu offers a serene retreat for nature lovers and spiritual seekers. Visitors can also enjoy thrilling activities like river rafting, trekking, and paragliding.',
  'Hampta Pass Trek':
      'The Hampta Pass Trek is a thrilling adventure that takes trekkers through some of the most breathtaking landscapes in the Himalayas. Starting from Manali, the trek winds through lush forests, alpine meadows, and rugged terrain, offering panoramic views of snow-capped peaks and pristine valleys. With its challenging trails and stunning scenery, the Hampta Pass Trek is a must-visit for adventure enthusiasts seeking an unforgettable experience.',
  'Jogini Waterfall':
      'Hidden amidst the scenic beauty of Manali, Jogini Waterfall is a mesmerizing cascade that offers a tranquil escape from the hustle and bustle of city life. Accessible via a scenic trek through lush greenery, the waterfall enchants visitors with its pristine beauty and serene ambiance, making it a perfect spot for nature lovers and photographers alike.',
  'Nicholas Roerich Art Gallery':
      'Dedicated to the renowned Russian artist Nicholas Roerich, this art gallery in Manali showcases a diverse collection of his paintings, sculptures, and artifacts. Set amidst picturesque surroundings with panoramic views of the Himalayas, the gallery offers visitors a glimpse into the life and works of this visionary artist, making it a must-visit for art enthusiasts and history buffs alike.',
  'India Gate':
      'Standing tall as a symbol of national pride, India Gate is a majestic war memorial located in the heart of Delhi. Built in memory of the soldiers who sacrificed their lives in World War I, it offers a solemn tribute and a peaceful retreat for visitors. Surrounded by lush lawns and illuminated by evening lights, India Gate is a popular gathering spot for locals and tourists alike.',
  'Qutub Minar':
      "A UNESCO World Heritage Site, Qutub Minar is an iconic symbol of Delhi's rich history and architectural grandeur. Built in the 12th century, this towering minaret is adorned with intricate carvings and inscriptions, showcasing the craftsmanship of the bygone era. Visitors can climb to the top for panoramic views of the surrounding area and explore the nearby archaeological complex, making it a must-visit destination for history enthusiasts.",
  'Humayun\'s Tomb':
      'A masterpiece of Mughal architecture, Humayun\'s Tomb is a UNESCO World Heritage Site and a treasure trove of history and culture. Built in the 16th century, this majestic mausoleum is the final resting place of Emperor Humayun and showcases the grandeur of Mughal design with its intricate marble work, sprawling gardens, and majestic dome. Surrounded by lush greenery and reflecting pools, Humayun\'s Tomb is a serene oasis in the heart of Delhi, attracting visitors from far and wide.',
  'Lotus Temple':
      'Renowned for its striking lotus-inspired design and tranquil ambiance, the Lotus Temple is a Bahá\'í House of Worship that welcomes people of all faiths to pray and meditate in harmony. Surrounded by lush gardens and pools, the temple\'s pristine white marble petals open up to embrace visitors in a serene atmosphere of peace and unity. With its unique architectural beauty and inclusive ethos, the Lotus Temple is a must-visit spiritual destination in Delhi.',
  'Red Fort':
      'A UNESCO World Heritage Site and an emblem of India\'s rich history and cultural heritage, the Red Fort is a majestic fortress that once served as the residence of Mughal emperors. Built in the 17th century, this imposing red sandstone structure is an architectural marvel, featuring intricate carvings, grand halls, and lush gardens. With its rich history and grandeur, the Red Fort offers visitors a captivating journey through India\'s royal past and is a must-visit destination in Delhi.',
  'Chandni Chowk':
      'A bustling market in the heart of Old Delhi, Chandni Chowk is a vibrant tapestry of sights, sounds, and smells that offers a sensory overload for visitors. From narrow lanes lined with centuries-old shops to bustling bazaars selling everything from spices and textiles to jewelry and electronics, Chandni Chowk is a shopper\'s paradise and a food lover\'s delight. Whether exploring its historic landmarks, sampling its delectable street food, or bargaining for souvenirs, a visit to Chandni Chowk is an unforgettable experience that captures the essence of Old Delhi\'s charm and character.',
  'Gurudwara Bangla Sahib':
      'A sacred Sikh gurdwara known for its serene ambiance and community kitchen serving free meals to all visitors, Gurudwara Bangla Sahib is a spiritual oasis in the heart of Delhi. Built in the 17th century, it commemorates the visit of the eighth Sikh Guru, Guru Har Krishan, and offers a peaceful retreat for devotees and travelers alike. With its shimmering pool, golden dome, and soothing hymns, Gurudwara Bangla Sahib is a must-visit destination for those seeking solace and spiritual upliftment.',
  'Jama Masjid Delhi':
      'One of the largest mosques in India, Jama Masjid Delhi is a magnificent architectural marvel that stands as a testament to the grandeur of Mughal design. Built in the 17th century by Emperor Shah Jahan, it boasts a vast courtyard, towering minarets, and intricate marble domes adorned with delicate calligraphy and floral motifs. As the call to prayer echoes through its halls, visitors are enveloped in a sense of peace and reverence, making it a must-visit destination for those exploring Delhi\'s rich cultural heritage.',
  'Connaught Place':
      'A bustling commercial and cultural hub in the heart of New Delhi, Connaught Place is a vibrant blend of colonial architecture, modern amenities, and lively street life. Surrounded by circular roads lined with shops, restaurants, and theaters, it offers a plethora of shopping and dining options for visitors. Whether strolling through its tree-lined avenues, exploring its historic landmarks, or indulging in its eclectic cuisine, a visit to Connaught Place is an immersive experience that captures the dynamic spirit of Delhi.',
  'Rashtrapati Bhavan':
      "The Rashtrapati Bhavan is the official residence of the President of India at the western end of Rajpath, Raisina Hill, New Delhi, India. It was formerly known as Viceroy's House and constructed during the zenith of British Empire.",
  'Calangute Beach':
      'Known as the "Queen of Beaches," Calangute Beach is a picturesque stretch of golden sand fringed by swaying palm trees and azure waters. Located in North Goa, it offers a perfect blend of natural beauty, water sports, and vibrant nightlife, making it a popular destination for travelers seeking sun, sand, and adventure. Whether sunbathing on its shores, indulging in water sports like parasailing and jet skiing, or exploring its bustling markets and beach shacks, Calangute Beach offers something for everyone and is a must-visit destination in Goa.',
  'Fort Aguada':
      'Perched atop a cliff overlooking the Arabian Sea, Fort Aguada is a historic Portuguese fort that once served as a crucial defense outpost. Built in the 17th century, it boasts sturdy walls, majestic bastions, and a towering lighthouse that offers panoramic views of the coastline. Surrounded by lush greenery and tranquil beaches, Fort Aguada is a tranquil oasis that transports visitors back in time to Goa\'s colonial era, making it a must-visit destination for history buffs and nature lovers alike.',
  'Dudhsagar Falls':
      'One of the tallest waterfalls in India, Dudhsagar Falls is a breathtaking cascade of milky-white water that plunges from a height of over 300 meters amidst lush greenery and rugged terrain. Located in the Western Ghats near the Goa-Karnataka border, it is surrounded by dense forests and offers a pristine natural setting for adventure seekers and nature enthusiasts. Whether trekking through its scenic trails, swimming in its refreshing pools, or simply admiring its majestic beauty, Dudhsagar Falls is a mesmerizing sight that leaves a lasting impression on all who visit.',
  'Anjuna Beach':
      'Famous for its vibrant atmosphere, lively parties, and stunning sunsets, Anjuna Beach is a popular destination for travelers seeking fun and relaxation in Goa. Located in North Goa, it offers a laid-back vibe with its sandy shores, rocky cliffs, and palm-fringed coastline. Whether lounging on the beach, exploring its colorful flea market, or dancing the night away at its beachside clubs, Anjuna Beach offers an unforgettable experience that captures the essence of Goa\'s bohemian spirit.',
  'Chapora Fort':
      'Perched atop a hill overlooking the Arabian Sea, Chapora Fort is a historic fortress that offers panoramic views of Goa\'s coastline and surrounding landscape. Built by the Portuguese in the 17th century, it boasts sturdy ramparts, ancient ruins, and a serene ambiance that transports visitors back in time to Goa\'s colonial era. Whether exploring its historic landmarks, admiring its scenic vistas, or simply soaking in its tranquil atmosphere, Chapora Fort is a must-visit destination for history enthusiasts and nature lovers alike.',
  'Basilica of Bom Jesus':
      'A UNESCO World Heritage Site and a symbol of Goa\'s rich religious heritage, the Basilica of Bom Jesus is a majestic church that houses the mortal remains of St. Francis Xavier. Built in the 16th century, it boasts exquisite Baroque architecture, intricate altars, and stunning frescoes that showcase the craftsmanship of the Portuguese colonial era. With its serene ambiance and spiritual significance, the Basilica of Bom Jesus is a sacred sanctuary that draws pilgrims and visitors from far and wide.',
  'Baga Beach':
      'Renowned for its vibrant nightlife, water sports, and beach parties, Baga Beach is a popular destination for travelers seeking fun and excitement in Goa. Located in North Goa, it offers a lively atmosphere with its sandy shores, bustling shacks, and beachside clubs. Whether sunbathing on its golden sands, indulging in water sports like parasailing and jet skiing, or dancing under the stars at its beachfront discos, Baga Beach offers an electrifying experience that captures the essence of Goa\'s party scene.',
  'Butterfly Beach':
      'Tucked away in a secluded cove on the southern coast of Goa, Butterfly Beach is a hidden gem known for its pristine beauty and diverse marine life. Accessible only by boat or a scenic trek through dense forests, it offers a tranquil escape from the crowds and a chance to commune with nature. Whether snorkeling in its crystal-clear waters, picnicking on its sandy shores, or simply admiring its breathtaking sunset views, Butterfly Beach offers an idyllic retreat for nature lovers and adventure seekers alike.',
  'Scuba Diving in Goa':
      'With its clear blue waters, vibrant coral reefs, and diverse marine life, Goa offers some of the best scuba diving experiences in India. From colorful coral gardens to underwater shipwrecks, its underwater world is teeming with exotic fish, sea turtles, and other fascinating creatures. Whether a beginner or experienced diver, there are plenty of dive sites to explore, each offering a unique glimpse into Goa\'s rich marine ecosystem. Whether exploring the underwater world of Grande Island, exploring the marine life of Netrani Island, or discovering the historic shipwrecks off the coast of Mormugao, scuba diving in Goa promises an unforgettable adventure for divers of all levels.',
  'Dona Paula':
      'Perched atop a picturesque cliff overlooking the Arabian Sea, Dona Paula is a popular tourist destination known for its stunning views, romantic sunsets, and vibrant atmosphere. Named after a historical figure, Dona Paula offers a scenic escape from the hustle and bustle of city life, with its tranquil beaches, lush greenery, and charming waterfront promenade. Whether relaxing on its sandy shores, indulging in water sports like windsurfing and parasailing, or exploring its bustling markets and beachside cafes, Dona Paula offers an unforgettable experience that captures the essence of Goa\'s coastal charm.',
  "Marina Beach":
      "Marina Beach is a picturesque shoreline that stretches along the Bay of Bengal in Chennai, Tamil Nadu. With its golden sands, rolling waves, and expansive coastline, it's not only the longest urban beach in India but also one of the most iconic. Locals and tourists alike flock to Marina Beach to enjoy leisurely walks, indulge in delicious street food offerings, and witness breathtaking sunsets over the shimmering waters of the Bay of Bengal. The beach also hosts various cultural events and activities, making it a vibrant hub of social gatherings and recreational opportunities for visitors of all ages.",

  "Government Museum":
      "The Government Museum, located in Chennai, Tamil Nadu, is a cultural institution that houses an extensive collection of artifacts, sculptures, and artworks that showcase the rich history and heritage of South India. Established in 1851, the museum's diverse exhibits span various periods and genres, including archaeology, numismatics, anthropology, and natural history. Visitors to the Government Museum can explore ancient relics, intricate sculptures, and historical artifacts that offer fascinating insights into the region's past and cultural evolution. The museum also organizes educational programs, workshops, and guided tours to enhance the visitor experience and promote an appreciation for art and history.",

  "Arignar Anna Zoological Park":
      "Arignar Anna Zoological Park, situated in Vandalur near Chennai, Tamil Nadu, is one of the largest zoological parks in India. Spanning over 1,265 acres of lush greenery, the park is home to a diverse array of wildlife, including mammals, birds, reptiles, and amphibians. Visitors can embark on safari tours, nature walks, and educational programs to learn about conservation efforts and wildlife conservation. Arignar Anna Zoological Park provides a unique opportunity for wildlife enthusiasts to observe and appreciate the beauty and diversity of the natural world. The park also features amenities such as picnic areas, children's play zones, and refreshment stalls, making it an ideal destination for family outings and outdoor adventures.",

  "Valluvar Kottam":
      "Valluvar Kottam is a monumental tribute to the renowned Tamil poet and philosopher, Thiruvalluvar, located in Chennai, Tamil Nadu. Constructed in 1976, the monument consists of a grand chariot-like structure adorned with intricate carvings and inscriptions from Thirukkural, Thiruvalluvar's seminal work. At the center of Valluvar Kottam stands a towering statue of Thiruvalluvar, symbolizing his enduring legacy and contributions to Tamil literature and philosophy. Visitors can explore the monument's tranquil surroundings, pay homage to the revered poet, and immerse themselves in the timeless wisdom of Thirukkural. The site also serves as a cultural and educational hub, hosting literary events, seminars, and cultural festivals that celebrate Thiruvalluvar's teachings and promote Tamil culture and heritage.",

  "Ashtalakshmi Temple":
      "Ashtalakshmi Temple, located in Besant Nagar, Chennai, Tamil Nadu, is a sacred Hindu shrine dedicated to the eight divine forms of Goddess Lakshmi, the goddess of wealth and prosperity. Each sanctum within the temple complex is dedicated to a specific manifestation of Goddess Lakshmi, representing different aspects of abundance and fortune. Devotees flock to Ashtalakshmi Temple to seek blessings for wealth, success, and happiness in their lives. The temple's serene ambiance and intricate architecture make it a popular pilgrimage destination and a haven for spiritual seekers. Visitors can participate in daily rituals, prayers, and religious ceremonies conducted at the temple, experiencing a sense of peace and tranquility amidst the divine presence of the goddess.",

  "Elliot's Beach":
      "Elliot's Beach, also known as Besant Nagar Beach, is a serene coastal retreat located in the Besant Nagar neighborhood of Chennai, Tamil Nadu. Named after Edward Elliot, the former Chief Magistrate and Superintendent of Police in Chennai, the beach offers a tranquil escape from the hustle and bustle of city life. Visitors can stroll along the sandy shores, soak in the warm rays of the sun, and breathe in the fresh sea breeze as they admire panoramic views of the Bay of Bengal. Elliot's Beach is a popular destination for picnics, family outings, and romantic sunset walks, with its picturesque surroundings and laid-back ambiance creating the perfect setting for relaxation and rejuvenation. The beach is also frequented by surfers and water sports enthusiasts who enjoy riding the waves and indulging in various beach activities.",

  "Dakshinachitra Museum":
      "Dakshinachitra Museum is a living museum located on the East Coast Road near Chennai, Tamil Nadu. It showcases the art, architecture, lifestyles, and crafts of South India through immersive exhibits, traditional homes, artifacts, and live demonstrations by skilled artisans. Visitors to Dakshinachitra can explore recreated village settings representing different states of South India, such as Tamil Nadu, Kerala, Karnataka, and Andhra Pradesh, and gain insights into the region's rich cultural heritage and diversity. The museum also hosts workshops, cultural performances, and educational programs that offer visitors an opportunity to engage with local traditions and crafts, making it a popular destination for both tourists and students of art and culture.",

  "Thousand Lights Mosque":
      "Thousand Lights Mosque is a historic mosque located in the Anna Salai area of Chennai, Tamil Nadu. Built in the early 19th century by Nawab Umdat-ul-Umrah, the mosque is renowned for its unique architecture and cultural significance. The name 'Thousand Lights' is derived from the magnificent chandeliers that adorn the mosque's interior, casting a warm glow and creating a mesmerizing ambiance during evening prayers. The mosque's elegant design features a central dome, minarets, and intricate arches adorned with Quranic inscriptions and geometric patterns. Thousand Lights Mosque is not only a place of worship for the Muslim community but also a symbol of religious harmony and architectural excellence, attracting visitors from diverse backgrounds who come to admire its beauty and heritage.",

  "Fort St. George":
      "Fort St. George is a historic fortress located in Chennai, Tamil Nadu, that holds the distinction of being the first English fortress in India. Built by the British East India Company in 1644, the fort served as a trading post and administrative center during the colonial era. Today, Fort St. George houses the Tamil Nadu Legislative Assembly and various government offices, making it a significant political and administrative landmark in the city. Visitors to the fort can explore its well-preserved structures, including St. Mary's Church, the oldest Anglican church in India, and the Fort Museum, which showcases artifacts, documents, and memorabilia from the colonial period. Fort St. George is not only a testament to Chennai's colonial past but also a living heritage site that offers insights into the city's rich history and cultural heritage.",

  "Royapuram Fishing Harbour":
      "Royapuram Fishing Harbour is a bustling fishing port located in the Royapuram neighborhood of Chennai, Tamil Nadu. Established in the late 18th century by the British East India Company, the harbor serves as a vital hub for the local fishing industry, with hundreds of fishing boats and trawlers docking daily to unload their catch. Visitors to Royapuram Fishing Harbour can witness the vibrant atmosphere of the fish market, where fishermen auction off their fresh catch to buyers and traders from nearby markets and restaurants. The harbor's strategic location along the coast also offers stunning views of the Arabian Sea and provides opportunities for photography enthusiasts to capture the daily lives of Chennai's fishing community.",

  // Hyderabad
  "Ramoji Film City":
      "Ramoji Film City, located in Hyderabad, Telangana, is the world's largest integrated film studio complex. Spanning over 2,000 acres, the film city offers a behind-the-scenes look at the magic of Indian cinema, with guided tours, live shows, and movie sets that recreate iconic scenes from Bollywood and Tollywood films. Visitors can explore thematic gardens, visit film sets, and watch live performances that showcase the art of filmmaking. Ramoji Film City also features luxury hotels, restaurants, and recreational facilities, making it a popular destination for film buffs, tourists, and entertainment enthusiasts alike.",

  "Hussain Sagar Lake":
      "Hussain Sagar Lake is a sprawling artificial lake located in the heart of Hyderabad, Telangana. Built during the reign of Ibrahim Quli Qutb Shah in the 16th century, the lake is renowned for its serene waters and picturesque surroundings. Visitors can enjoy boat rides, leisurely walks along the promenade, and panoramic views of the city skyline from the iconic Buddha statue installed in the middle of the lake. Hussain Sagar Lake is also a popular spot for recreational activities such as boating, jet skiing, and parasailing, attracting visitors of all ages to relax and unwind amidst nature's beauty.",

  "Golconda Fort":
      "Golconda Fort, a majestic citadel overlooking Hyderabad, Telangana, dates back to the 12th century. Originally built as a mud fort by the Kakatiya dynasty, it was later fortified and expanded by the Qutb Shahi kings into a formidable fortress known for its impressive architecture, intricate acoustics, and strategic location. Visitors to Golconda Fort can explore its imposing ramparts, grand gateways, and royal palaces, including the iconic Fateh Darwaza, which boasts an impressive acoustical effect that allows even the faintest whisper to be heard at the highest point of the fort. The fort also offers panoramic views of the surrounding landscape, making it a popular destination for history buffs, architecture enthusiasts, and photographers.",

  "Charminar":
      "Charminar, an iconic monument located in the heart of Hyderabad, Telangana, is a symbol of the city's rich history and architectural heritage. Built in 1591 by Muhammad Quli Qutb Shah, the fifth ruler of the Qutb Shahi dynasty, the monument is renowned for its distinctive Indo-Islamic architecture, with four grand arches and towering minarets that offer panoramic views of the bustling streets below. Charminar serves as a landmark and a bustling marketplace, with its surrounding lanes filled with vibrant bazaars selling traditional wares, jewelry, and street food delicacies. Visitors can climb up the spiral staircases to reach the upper levels of Charminar and marvel at the breathtaking vistas of Hyderabad's skyline and historic landmarks.",

  "Thrill City":
      "Thrill City is an amusement park located in Hyderabad, Telangana, offering a wide range of thrilling rides, entertainment attractions, and activities for visitors of all ages. From high-speed roller coasters to exhilarating water slides, the park promises adrenaline-pumping adventures and excitement for thrill-seekers. Thrill City also features family-friendly attractions, kiddie rides, and live entertainment shows, making it a popular destination for families, friends, and groups looking for fun-filled experiences. With its vibrant atmosphere, colorful ambiance, and variety of rides and attractions, Thrill City provides a memorable day out for visitors seeking adventure and entertainment.",

  "Wonderla":
      "Wonderla Hyderabad is a premier amusement park located on the outskirts of Hyderabad, Telangana, offering a thrilling escape for visitors of all ages. Spanning over 50 acres, the park features a wide range of adrenaline-pumping rides, water slides, and entertainment attractions that promise fun and excitement for the whole family. From gravity-defying roller coasters to lazy rivers and wave pools, Wonderla has something for everyone. The park also boasts landscaped gardens, themed zones, and dining options, making it a complete entertainment destination. With its world-class facilities, safety standards, and thrilling experiences, Wonderla Hyderabad is a must-visit destination for thrill-seekers and adventure enthusiasts.",

  "Statue of Equality":
      "The Statue of Equality, located in Hyderabad, Telangana, is a monumental tribute to the revered saint and philosopher, Ramanujacharya. Towering over the city at a height of 216 feet, the statue depicts Ramanujacharya with his disciples, symbolizing his teachings of equality, compassion, and social justice. The Statue of Equality stands as a beacon of hope and inspiration, reminding visitors of the importance of harmony and unity in diversity. Surrounding the statue is a sprawling complex that houses a temple, cultural center, and educational facilities dedicated to promoting Ramanujacharya's teachings and principles of equality. With its grandeur, symbolism, and cultural significance, the Statue of Equality serves as a landmark and a pilgrimage destination for devotees and spiritual seekers seeking enlightenment and spiritual fulfillment.",

  "GravityZip":
      "GravityZip is an adventure sports facility located in Hyderabad, Telangana, offering exhilarating zip-lining experiences amidst lush greenery and scenic landscapes. Spanning over acres of natural terrain, the park features a series of zip lines that allow visitors to soar through the air and enjoy panoramic views of the surrounding area. With varying lengths and heights, GravityZip offers thrills and excitement for adventurers of all levels, from beginners to experienced zip-liners. The park also provides safety equipment, trained instructors, and guided tours to ensure a safe and enjoyable experience for all visitors. Whether you're seeking an adrenaline rush or simply want to experience the thrill of flying, GravityZip offers an unforgettable adventure in the heart of nature.",

  "Chowmahalla Palace":
      "Chowmahalla Palace is a magnificent royal residence located in Hyderabad, Telangana, that served as the seat of the Nizams of Hyderabad during their rule. Built in the 18th century, the palace is renowned for its exquisite architecture, lavish interiors, and sprawling courtyards that reflect the opulence and grandeur of the Nizam era. Visitors to Chowmahalla Palace can explore its ornate halls, royal chambers, and ceremonial rooms, adorned with intricate carvings, chandeliers, and priceless artifacts. The palace also houses a vast collection of vintage cars, weaponry, and royal regalia, providing insights into the lifestyle and legacy of the Nizams. Chowmahalla Palace is not only a historic landmark but also a cultural treasure that offers a glimpse into Hyderabad's royal past and architectural heritage, making it a must-visit destination for history buffs, art enthusiasts, and culture seekers.",

  "Shilparamam":
      "Shilparamam is a traditional crafts village located in Hyderabad, Telangana, that showcases the rich cultural heritage and artistic traditions of India. Spread across acres of lush greenery, the village features a sprawling complex of artisan workshops, craft stalls, and cultural pavilions where visitors can experience the diverse crafts and traditions of different states and regions. From handloom textiles and pottery to wood carving and metalwork, Shilparamam offers a wide range of authentic handicrafts and artworks crafted by skilled artisans. Visitors can watch live demonstrations, participate in hands-on workshops, and shop for unique souvenirs and gifts. Shilparamam also hosts cultural events, folk performances, and food festivals that celebrate the vibrant diversity of Indian culture, making it a vibrant and immersive destination for art lovers, tourists, and cultural enthusiasts.",

  // Jaipur
  "Amber Palace":
      "Amber Palace, located in Jaipur, Rajasthan, is a magnificent fort complex that served as the royal residence of the Kachhawa Rajput rulers. Built in the 16th century, the palace is renowned for its stunning architecture, intricate carvings, and panoramic views of the surrounding hills. Visitors to Amber Palace can explore its grand courtyards, ornate halls, and beautifully landscaped gardens, including the iconic Sheesh Mahal (Hall of Mirrors) adorned with intricate mirror work and colorful frescoes. The palace also offers elephant rides, sound and light shows, and cultural performances that transport visitors back in time to the era of Rajput grandeur and opulence.",

  "City Palace Jaipur":
      "City Palace Jaipur is a majestic royal residence located in the heart of Jaipur, Rajasthan, that served as the seat of the Maharaja of Jaipur. Built in the 18th century, the palace is a fine example of Rajput and Mughal architecture, with its sprawling complex of courtyards, gardens, and palatial buildings. Visitors to City Palace Jaipur can explore its museum, which houses a priceless collection of royal artifacts, including weapons, textiles, and manuscripts. The palace also features ornate gates, pavilions, and galleries that showcase the rich cultural heritage and artistic traditions of Rajasthan. City Palace Jaipur is not only a historic landmark but also a cultural treasure that offers a glimpse into Jaipur's royal past and architectural splendor, making it a must-visit destination for history buffs, art enthusiasts, and culture seekers.",

  "Jantar Mantar Jaipur":
      "Jantar Mantar Jaipur is an astronomical observatory located in Jaipur, Rajasthan, that was built by Maharaja Jai Singh II in the 18th century. Recognized as a UNESCO World Heritage Site, Jantar Mantar is renowned for its unique collection of architectural instruments and astronomical instruments that were used to measure time, track celestial bodies, and study planetary movements. Visitors to Jantar Mantar can explore its various structures, including the world's largest stone sundial, which stands at a height of 27 meters and accurately measures time with an error margin of only two seconds. The observatory offers a fascinating glimpse into the scientific achievements and astronomical knowledge of ancient India, making it a must-visit destination for history buffs, astronomers, and curious travelers.",

  "Hawa Mahal":
      "Hawa Mahal, also known as the Palace of Winds, is an iconic landmark located in the heart of Jaipur, Rajasthan. Built in 1799 by Maharaja Sawai Pratap Singh, the palace is renowned for its unique honeycomb-like facade, which features over 900 intricately carved windows or 'jharokhas' that allow cool breeze to flow through the palace, keeping it cool during the hot summer months. Hawa Mahal served as a royal retreat for the women of the royal household, allowing them to observe the bustling street life and festivities of the city without being seen. Visitors to Hawa Mahal can admire its stunning architecture, intricate latticework, and panoramic views of the cityscape from its upper floors, making it a must-visit destination for history buffs, architecture enthusiasts, and photographers.",

  "Nahargarh Fort":
      "Nahargarh Fort is a historic fortress located on the Aravalli Hills overlooking Jaipur, Rajasthan. Built in 1734 by Maharaja Sawai Jai Singh II, the fort served as a defensive stronghold and royal retreat for the rulers of Jaipur. Nahargarh Fort offers panoramic views of the Pink City and its surrounding landscape, making it a popular destination for sightseeing, photography, and picnics. Visitors to the fort can explore its sprawling complex of palaces, temples, and gardens, including the iconic Nahargarh Step Well and the Madhavendra Bhawan, a royal palace known for its exquisite frescoes and architectural beauty. Nahargarh Fort is not only a historic landmark but also a cultural treasure that offers insights into Jaipur's royal past and architectural heritage, making it a must-visit destination for history buffs, architecture enthusiasts, and nature lovers.",

  "Birla Temple Jaipur":
      "Birla Temple Jaipur, also known as Lakshmi Narayan Temple, is a magnificent Hindu temple located at the base of Moti Dungari Hill in Jaipur, Rajasthan. Built in 1988 by the Birla family, the temple is dedicated to Lord Vishnu and Goddess Lakshmi, the presiding deities of wealth and prosperity. Birla Temple is renowned for its exquisite marble architecture, intricate carvings, and beautifully landscaped gardens, which create a serene and spiritual ambiance for devotees and visitors alike. The temple complex also features shrines dedicated to other Hindu gods and goddesses, as well as a museum showcasing religious artifacts and sculptures. Birla Temple Jaipur is not only a place of worship but also a symbol of religious harmony and architectural excellence, attracting visitors from all walks of life to seek blessings and spiritual solace in its divine presence.",

  "Jal Mahal":
      "Jal Mahal, or the Water Palace, is a stunning architectural marvel located amidst the tranquil waters of Man Sagar Lake in Jaipur, Rajasthan. Built in the 18th century by Maharaja Madho Singh I, the palace is renowned for its unique location, with only its top floor visible above the waterline while the rest of the structure remains submerged. Jal Mahal served as a royal retreat and hunting lodge for the Maharajas of Jaipur, offering breathtaking views of the surrounding hills and the Aravalli Range. Visitors to Jal Mahal can admire its exquisite Rajput and Mughal architectural elements, including chhatris, jharokhas, and ornate facades adorned with intricate carvings and motifs. The palace is illuminated with colorful lights during the evening, creating a magical ambiance that enchants visitors and photographers alike.",

  "Albert Hall Museum (Central Museum)":
      "Albert Hall Museum, also known as the Central Museum, is a majestic museum located in Jaipur, Rajasthan, that showcases the rich cultural heritage and artistic traditions of the region. Built in 1887 to commemorate the visit of Prince Albert, the museum is housed in a grand Indo-Saracenic-style building that features a blend of Rajput, Mughal, and European architectural elements. Albert Hall Museum's extensive collection includes rare artifacts, sculptures, paintings, and decorative arts from various periods and civilizations, including ancient India, medieval Rajasthan, and the Mughal Empire. Visitors to the museum can explore its diverse exhibits, including galleries dedicated to arms and armor, textiles, ceramics, and miniature paintings, gaining insights into the history, culture, and craftsmanship of Rajasthan. Albert Hall Museum is not only a historic landmark but also a cultural treasure that offers a glimpse into Jaipur's royal past and artistic heritage, making it a must-visit destination for history buffs, art enthusiasts, and culture seekers.",

  "Jaipur Zoo":
      "Jaipur Zoo, also known as the Zoological Garden, is a popular wildlife park located in Jaipur, Rajasthan, that houses a diverse collection of animals, birds, and reptiles from around the world. Established in 1877, the zoo is spread across acres of lush greenery and features spacious enclosures, natural habitats, and landscaped gardens that provide a comfortable and stimulating environment for its residents. Visitors to Jaipur Zoo can explore its various sections, including the big cat enclosure, aviary, reptile house, and primate section, where they can observe and learn about different species of mammals, birds, and reptiles. The zoo also offers educational programs, guided tours, and interactive exhibits that promote wildlife conservation and environmental awareness. Jaipur Zoo is not only a recreational destination but also a center for wildlife education and conservation, making it a favorite attraction for families, nature lovers, and wildlife enthusiasts.",

  "Chokhi Dhani":
      "Chokhi Dhani is an ethnic village resort located on the outskirts of Jaipur, Rajasthan, that offers a unique cultural experience of traditional Rajasthani hospitality and entertainment. Modeled after a Rajasthani village, the resort features rustic cottages, mud huts, and thatched-roof houses that reflect the region's rural charm and heritage. Visitors to Chokhi Dhani can enjoy a range of cultural activities and experiences, including folk dances, puppet shows, camel rides, and bullock cart rides, as well as traditional Rajasthani cuisine served in an open-air dining area. The resort also hosts themed events, festivals, and fairs that celebrate the vibrant culture and traditions of Rajasthan, allowing guests to immerse themselves in the colorful tapestry of Rajasthani life. Chokhi Dhani is not only a tourist attraction but also a cultural oasis that offers a glimpse into the timeless traditions and hospitality of Rajasthan, making it a memorable destination for travelers seeking an authentic Rajasthani experience."
};

Map<String, dynamic> locations = {
  'Manali': {'long': 77.188713, 'lat': 32.239632},
  'Delhi': {'long': 77.1025, 'lat': 28.7041},
  'Hyderabad': {'long': 78.4772, 'lat': 17.4065},
  'Goa': {'long': 74.1240, 'lat': 15.2993},
  'Jaipur': {'long': 75.778885, 'lat': 26.922070},
  'Chennai': {'long': 80.2707, 'lat': 13.0827}
};
