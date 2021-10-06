//
//  StubbedData.swift
//  CitySearchTests
//
//  Created by Dhananjay Dubey on 30/7/21.
//

import Foundation

struct Stubbed {
    static let successGetFilterLeadsStubbedData = Data("""
            [
              {
                  \"country\":\"UA\",
                   \"name\":\"Hurzuf\",
                   \"_id\":707860,
                   \"coord\": {
                       \"lon\":34.283333,
                       \"lat\":44.549999
            
             }
            }
            ]
            """.utf8)
    
    static let failureStubbedData = Data("""
                        [
                          {
                              \"country\":\"UA\",
                               \"name\":\"Hurzuf\",
                               \"_id\":707860,
                               \"coord\": {
                                   \"lon\": "34.283333",
                                   \"lat\": "44.549999"
                        
                         }
                        }
                        ]
            """.utf8)
    
    static let searchCityStubbedData = Data("""
                [
                {"country\":\"ES\",\"name\":\"Alfafara\",\"_id\":2522056,\"coord\":{\"lon\":-0.55551,\"lat\":38.773392}},
                {\"country\":\"ES\",\"name\":\"Alfacar\",\"_id\":6357647,\"coord\":{\"lon\":-3.55432,\"lat\":37.248131}},
                {\"country\":\"ES\",\"name\":\"Aldeire\",\"_id\":6357646,\"coord\":{\"lon\":-3.07647,\"lat\":37.168098}},
                {\"country\":\"ES\",\"name\":\"Benaocaz\",\"_id\":2521124,\"coord\":{\"lon\":-5.42222,\"lat\":36.700691}},
                {\"country\":\"ES\",\"name\":\"Benamocarra\",\"_id\":2521128,\"coord\":{\"lon\":-4.16146,\"lat\":36.790741}},
                {\"country\":\"ES\",\"name\":\"Benamaurel\",\"_id\":2521131,\"coord\":{\"lon\":-2.7025,\"lat\":37.608261}},
                {\"country\":\"ES\",\"name\":\"Benamargosa\",\"_id\":6359431,\"coord\":{\"lon\":-4.1957,\"lat\":36.8451}},
                {\"country\":\"ID\",\"name\":\"Baluburlimbangan\",\"_id\":1648564,\"coord\":{\"lon\":107.982903,\"lat\":-7.0357}},
                {\"country\":\"ID\",\"name\":\"Binangun\",\"_id\":1648744,\"coord\":{\"lon\":112.335999,\"lat\":-8.2343}},
                {\"country\":\"ID\",\"name\":\"Bilungala\",\"_id\":1648761,\"coord\":{\"lon\":123.213501,\"lat\":0.3815}},
                {\"country\":\"ID\",\"name\":\"Biha\",\"_id\":1648794,\"coord\":{\"lon\":104.029503,\"lat\":-5.3296}},
                {\"country\":\"ID\",\"name\":\"Belopa\",\"_id\":1649267,\"coord\":{\"lon\":120.367599,\"lat\":-3.3849}},
                {\"country\":\"ID\",\"name\":\"Bebandem\",\"_id\":1649458,\"coord\":{\"lon\":115.560204,\"lat\":-8.4403}},
                {\"country\":\"AU\",\"name\":\"Bangalow\",\"_id\":2176973,\"coord\":{\"lon\":153.516663,\"lat\":-28.700001}},
                {\"country\":\"IN\",\"name\":\"Bangalore\",\"_id\":1277333,\"coord\":{\"lon\":77.603287,\"lat\":12.97623}}
    ]
    """.utf8)
}
