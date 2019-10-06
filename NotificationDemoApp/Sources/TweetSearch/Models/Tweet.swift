//
//  TweetType.swift
//  NotificationDemoApp
//
//  Created by Margarita Blanc on 01/10/2019.
//  Copyright © 2019 Frederic Blanc. All rights reserved.
//

import Foundation

struct Tweet: Decodable {
    
    var statuses: [Statuses]
    
    struct Statuses: Decodable {
        var created_at: String
        var id: Int
        var text: String
        var user: User
        var favorite_count: Int
        var retweet_count: Int
    }
    
    struct User: Decodable {
        var id: Int
        var screen_name: String
        var profile_image_url_https: String
    }
}

//
//{
//"statuses": [
//    {
//        "created_at": "Tue Oct 01 17:51:06 +0000 2019",
//        "id": 1179091380498554880,
//        "id_str": "1179091380498554880",
//        "text": "@OptionGrail Try our mobile autotrader for @Binarydotcom | https://t.co/mCTqM2yXHQ #binarybot #autotrading https://t.co/K50tzlyG7o",
//        "truncated": false,
//        "entities": {
//            "hashtags": [
//                {
//                    "text": "binarybot",
//                    "indices": [
//                        83,
//                        93
//                    ]
//                },
//                {
//                    "text": "autotrading",
//                    "indices": [
//                        94,
//                        106
//                    ]
//                }
//            ],
//            "symbols": [],
//            "user_mentions": [
//                {
//                    "screen_name": "OptionGrail",
//                    "name": "Option Grail",
//                    "id": 1167854872340901891,
//                    "id_str": "1167854872340901891",
//                    "indices": [
//                        0,
//                        12
//                    ]
//                },
//                {
//                    "screen_name": "Binarydotcom",
//                    "name": "Binary.com",
//                    "id": 1663992488,
//                    "id_str": "1663992488",
//                    "indices": [
//                        43,
//                        56
//                    ]
//                }
//            ],
//            "urls": [
//                {
//                    "url": "https://t.co/mCTqM2yXHQ",
//                    "expanded_url": "https://binarybottrading.eu",
//                    "display_url": "binarybottrading.eu",
//                    "indices": [
//                        59,
//                        82
//                    ]
//                },
//                {
//                    "url": "https://t.co/K50tzlyG7o",
//                    "expanded_url": "https://twitter.com/TwitterDev/statuses/1179058762256207873",
//                    "display_url": "twitter.com/TwitterDev/sta…",
//                    "indices": [
//                        107,
//                        130
//                    ]
//                }
//            ]
//        },
//        "metadata": {
//            "iso_language_code": "en",
//            "result_type": "recent"
//        },
//        "source": "<a href=\"https://binarybottrading.eu\" rel=\"nofollow\">bbTrader</a>",
//        "in_reply_to_status_id": null,
//        "in_reply_to_status_id_str": null,
//        "in_reply_to_user_id": 1167854872340901891,
//        "in_reply_to_user_id_str": "1167854872340901891",
//        "in_reply_to_screen_name": "OptionGrail",
//        "user": {
//            "id": 1112293838440275970,
//            "id_str": "1112293838440275970",
//            "name": "binary-bot-trading",
//            "screen_name": "binarybotrading",
//            "location": "United Kingdom",
//            "description": "automated trading bot for https://t.co/Th1F7mnRKG\n\nMobile: https://t.co/S7g8GaAE2M\nLite: https://t.co/iaz7NEHQKI",
//            "url": "https://t.co/eDorn3t9DG",
//            "entities": {
//                "url": {
//                    "urls": [
//                        {
//                            "url": "https://t.co/eDorn3t9DG",
//                            "expanded_url": "https://binarybottrading.eu/",
//                            "display_url": "binarybottrading.eu",
//                            "indices": [
//                                0,
//                                23
//                            ]
//                        }
//                    ]
//                },
//                "description": {
//                    "urls": [
//                        {
//                            "url": "https://t.co/Th1F7mnRKG",
//                            "expanded_url": "http://binary.com",
//                            "display_url": "binary.com",
//                            "indices": [
//                                26,
//                                49
//                            ]
//                        },
//                        {
//                            "url": "https://t.co/S7g8GaAE2M",
//                            "expanded_url": "https://bbmobile.binarybottrading.eu/",
//                            "display_url": "bbmobile.binarybottrading.eu",
//                            "indices": [
//                                59,
//                                82
//                            ]
//                        },
//                        {
//                            "url": "https://t.co/iaz7NEHQKI",
//                            "expanded_url": "https://webtrader.binarybottrading.eu/",
//                            "display_url": "webtrader.binarybottrading.eu",
//                            "indices": [
//                                89,
//                                112
//                            ]
//                        }
//                    ]
//                }
//            },
//            "protected": false,
//            "followers_count": 107,
//            "friends_count": 877,
//            "listed_count": 1,
//            "created_at": "Sun Mar 31 10:01:31 +0000 2019",
//            "favourites_count": 0,
//            "utc_offset": null,
//            "time_zone": null,
//            "geo_enabled": false,
//            "verified": false,
//            "statuses_count": 605,
//            "lang": null,
//            "contributors_enabled": false,
//            "is_translator": false,
//            "is_translation_enabled": false,
//            "profile_background_color": "000000",
//            "profile_background_image_url": "http://abs.twimg.com/images/themes/theme1/bg.png",
//            "profile_background_image_url_https": "https://abs.twimg.com/images/themes/theme1/bg.png",
//            "profile_background_tile": false,
//            "profile_image_url": "http://pbs.twimg.com/profile_images/1154108311182159872/6TYkKMIi_normal.png",
//            "profile_image_url_https": "https://pbs.twimg.com/profile_images/1154108311182159872/6TYkKMIi_normal.png",
//            "profile_banner_url": "https://pbs.twimg.com/profile_banners/1112293838440275970/1554026858",
//            "profile_link_color": "3D2575",
//            "profile_sidebar_border_color": "000000",
//            "profile_sidebar_fill_color": "000000",
//            "profile_text_color": "000000",
//            "profile_use_background_image": false,
//            "has_extended_profile": false,
//            "default_profile": false,
//            "default_profile_image": false,
//            "following": false,
//            "follow_request_sent": false,
//            "notifications": false,
//            "translator_type": "none"
//        },
//        "geo": null,
//        "coordinates": null,
//        "place": null,
//        "contributors": null,
//        "is_quote_status": true,
//        "quoted_status_id": 1179058762256207873,
//        "quoted_status_id_str": "1179058762256207873",
//        "quoted_status": {
//            "created_at": "Tue Oct 01 15:41:29 +0000 2019",
//            "id": 1179058762256207873,
//            "id_str": "1179058762256207873",
//            "text": "Another good month, but I was some what disappointed that I didn’t top August by at least 25% #Optiongrail $SPY… https://t.co/hs7jKMtDPX",
//            "truncated": true,
//            "entities": {
//                "hashtags": [
//                    {
//                        "text": "Optiongrail",
//                        "indices": [
//                            94,
//                            106
//                        ]
//                    }
//                ],
//                "symbols": [
//                    {
//                        "text": "SPY",
//                        "indices": [
//                            107,
//                            111
//                        ]
//                    }
//                ],
//                "user_mentions": [],
//                "urls": [
//                    {
//                        "url": "https://t.co/hs7jKMtDPX",
//                        "expanded_url": "https://twitter.com/i/web/status/1179058762256207873",
//                        "display_url": "twitter.com/i/web/status/1…",
//                        "indices": [
//                            113,
//                            136
//                        ]
//                    }
//                ]
//            },
//            "metadata": {
//                "iso_language_code": "en",
//                "result_type": "recent"
//            },
//            "source": "<a href=\"http://twitter.com/download/iphone\" rel=\"nofollow\">Twitter for iPhone</a>",
//            "in_reply_to_status_id": null,
//            "in_reply_to_status_id_str": null,
//            "in_reply_to_user_id": null,
//            "in_reply_to_user_id_str": null,
//            "in_reply_to_screen_name": null,
//            "user": {
//                "id": 1167854872340901891,
//                "id_str": "1167854872340901891",
//                "name": "Option Grail",
//                "screen_name": "OptionGrail",
//                "location": "",
//                "description": "My shine put feeling in peg legs, grow hair on ball heads, and knowing the secret of walking on water - not knowing where the rocks are.",
//                "url": null,
//                "entities": {
//                    "description": {
//                        "urls": []
//                    }
//                },
//                "protected": false,
//                "followers_count": 104,
//                "friends_count": 415,
//                "listed_count": 2,
//                "created_at": "Sat Aug 31 17:41:45 +0000 2019",
//                "favourites_count": 145,
//                "utc_offset": null,
//                "time_zone": null,
//                "geo_enabled": false,
//                "verified": false,
//                "statuses_count": 109,
//                "lang": null,
//                "contributors_enabled": false,
//                "is_translator": false,
//                "is_translation_enabled": false,
//                "profile_background_color": "F5F8FA",
//                "profile_background_image_url": null,
//                "profile_background_image_url_https": null,
//                "profile_background_tile": false,
//                "profile_image_url": "http://pbs.twimg.com/profile_images/1167860304824426497/40mnrfEV_normal.jpg",
//                "profile_image_url_https": "https://pbs.twimg.com/profile_images/1167860304824426497/40mnrfEV_normal.jpg",
//                "profile_banner_url": "https://pbs.twimg.com/profile_banners/1167854872340901891/1567274570",
//                "profile_link_color": "1DA1F2",
//                "profile_sidebar_border_color": "C0DEED",
//                "profile_sidebar_fill_color": "DDEEF6",
//                "profile_text_color": "333333",
//                "profile_use_background_image": true,
//                "has_extended_profile": true,
//                "default_profile": true,
//                "default_profile_image": false,
//                "following": false,
//                "follow_request_sent": false,
//                "notifications": false,
//                "translator_type": "none"
//            },
//            "geo": null,
//            "coordinates": null,
//            "place": null,
//            "contributors": null,
//            "is_quote_status": false,
//            "retweet_count": 0,
//            "favorite_count": 1,
//            "favorited": false,
//            "retweeted": false,
//            "possibly_sensitive": false,
//            "lang": "en"
//        },
//        "retweet_count": 0,
//        "favorite_count": 0,
//        "favorited": false,
//        "retweeted": false,
//        "possibly_sensitive": false,
//        "lang": "en"
//    }
//}
