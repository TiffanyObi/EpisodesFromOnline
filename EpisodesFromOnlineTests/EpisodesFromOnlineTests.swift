//
//  EpisodesFromOnlineTests.swift
//  EpisodesFromOnlineTests
//
//  Created by Tiffany Obi on 12/13/19.
//  Copyright © 2019 Tiffany Obi. All rights reserved.
//

import XCTest
@testable import EpisodesFromOnline

class EpisodesFromOnlineTests: XCTestCase {
    
    func testSearchChristmasCookies() {
        
        //arrange - note: were making the string a url friendly
        //        let searchQuery = "christmas cookies".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)! // the q part of the url
        let exp = XCTestExpectation(description: "search found") //need this
        
        let recipeEndpointURL = "https://api.tvmaze.com/search/shows?q=girls"
        
        let request = URLRequest(url: URL(string: recipeEndpointURL)!)
        
        //act
        NetworkHelper.shared.performDataTask(with: request) { (result) in
            
            switch result {
                
            case .failure(let appError):
                XCTFail("appError: \(appError)")
                
            case .success(let data):
                exp.fulfill() //need this
                //assert
                XCTAssertGreaterThan(data.count, 12_000, "data should be greater than \(data.count)")
                
            }
        }
        
        wait(for: [exp], timeout: 5.0) // wait for 5 seconds. //need this
    }
    
    
    func testfetchRecipes() {
        
        //        // async test
        //
        //        let exp = XCTestExpectation(description: "recipes found")
        //
        //        ShowsApiClient.getShows(for: "https://api.tvmaze.com/search/shows?q=girls") { (result) in
        //            switch result {
        //            case.failure(let appError):
        //                XCTFail("appError: \(appError)")
        //            case .success(let shows):
        //                exp.fulfill()
        //                XCTAssertNotEqual(shows.count,0,"showsCount:\(shows.count) is equal to zero and it shouldnt be" )
        //            }
        //        }
        //
        //        wait(for: [exp], timeout: 5.0)
    }
    
    func testShowModel() {
        struct SearchResult: Codable {
            let score: Double
            let show: ShowDetails
        }
        struct ShowDetails: Codable {
            let name: String
        }
        let json = """
           [{
                  "score": 17.01709,
                  "show": {
                      "id": 139,
                      "url": "http://www.tvmaze.com/shows/139/girls",
                      "name": "Girls",
                      "type": "Scripted",
                      "language": "English",
                      "genres": [
                          "Drama",
                          "Romance"
                      ],
                      "status": "Ended",
                      "runtime": 30,
                      "premiered": "2012-04-15",
                      "officialSite": "http://www.hbo.com/girls",
                      "schedule": {
                          "time": "22:00",
                          "days": [
                              "Sunday"
                          ]
                      },
                      "rating": {
                          "average": 6.8
                      },
                      "weight": 89,
                      "network": {
                          "id": 8,
                          "name": "HBO",
                          "country": {
                              "name": "United States",
                              "code": "US",
                              "timezone": "America/New_York"
                          }
                      },
                      "webChannel": null,
                      "externals": {
                          "tvrage": 30124,
                          "thetvdb": 220411,
                          "imdb": "tt1723816"
                      },
                      "image": {
                          "medium": "http://static.tvmaze.com/uploads/images/medium_portrait/31/78286.jpg",
                          "original": "http://static.tvmaze.com/uploads/images/original_untouched/31/78286.jpg"
                      },
                      "summary": "<p>This Emmy winning series is a comic look at the assorted humiliations and rare triumphs of a group of girls in their 20s.</p>",
                      "updated": 1573153623,
                      "_links": {
                          "self": {
                              "href": "http://api.tvmaze.com/shows/139"
                          },
                          "previousepisode": {
                              "href": "http://api.tvmaze.com/episodes/1079686"
                          }
                      }
                  }
              },
              {
                  "score": 13.097862,
                  "show": {
                      "id": 23542,
                      "url": "http://www.tvmaze.com/shows/23542/good-girls",
                      "name": "Good Girls",
                      "type": "Scripted",
                      "language": "English",
                      "genres": [
                          "Drama",
                          "Comedy",
                          "Crime"
                      ],
                      "status": "Running",
                      "runtime": 60,
                      "premiered": "2018-02-26",
                      "officialSite": "https://www.nbc.com/good-girls?nbc=1",
                      "schedule": {
                          "time": "22:00",
                          "days": [
                              "Sunday"
                          ]
                      },
                      "rating": {
                          "average": 7.2
                      },
                      "weight": 94,
                      "network": {
                          "id": 1,
                          "name": "NBC",
                          "country": {
                              "name": "United States",
                              "code": "US",
                              "timezone": "America/New_York"
                          }
                      },
                      "webChannel": null,
                      "externals": {
                          "tvrage": null,
                          "thetvdb": 328577,
                          "imdb": "tt6474378"
                      },
                      "image": {
                          "medium": "http://static.tvmaze.com/uploads/images/medium_portrait/182/456848.jpg",
                          "original": "http://static.tvmaze.com/uploads/images/original_untouched/182/456848.jpg"
                      },
                      "summary": "<p><b>Good Girls</b> follows three \"good girl\" suburban wives and mothers who suddenly find themselves in desperate circumstances and decide to stop playing it safe, and risk everything to take their power back.</p>",
                      "updated": 1574612816,
                      "_links": {
                          "self": {
                              "href": "http://api.tvmaze.com/shows/23542"
                          },
                          "previousepisode": {
                              "href": "http://api.tvmaze.com/episodes/1616190"
                          },
                          "nextepisode": {
                              "href": "http://api.tvmaze.com/episodes/1753736"
                          }
                      }
                  }
              }
           ]
        """.data(using: .utf8)!
        
        // act
        let shows = try! JSONDecoder().decode([SearchResult].self, from: json)
        
        // assert
        XCTAssertEqual(shows.count, 2)
    }
    
    
    
    
    
}
