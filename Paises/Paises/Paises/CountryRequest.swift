//
//  PaisesRequest.swift
//  Paises
//
//  Created by Marcio Barros on 05/01/17.
//  Copyright © 2017 br.unirio.ios. All rights reserved.
//

import Foundation

public class CountryRequest {
	
	//
	// Mapeamento do código internacional de países para o código da CIA de países
	//
	private let countryMappings = [
		"as": "aq",
		"ad": "an",
		"ai": "av",
		"ag": "ac",
		"dz": "ag",
		"aw": "aa",
		"au": "as",
		"at": "au",
		"az": "aj",
		"bs": "bf",
		"bh": "ba",
		"bd": "bg",
		"bz": "bh",
		"bj": "bn",
		"bm": "bd",
		"by": "bo",
		"bo": "bl",
		"ba": "bk",
		"bw": "bc",
		"bn": "bx",
		"bg": "bu",
		"bf": "uv",
		"mm": "bm",
		"bi": "by",
		"kh": "cb",
		"cf": "ct",
		"td": "cd",
		"cl": "ci",
		"cn": "ch",
		"km": "cn",
		"cg": "cf",
		"cr": "cs",
		"ci": "iv",
		"cw": "cc",
		"cz": "ez",
		"cd": "cg",
		"dk": "da",
		"dm": "do",
		"do": "dr",
		"sv": "es",
		"ee": "en",
		"ph": "rp",
		"ga": "gb",
		"gm": "ga",
		"ge": "gg",
		"de": "gm",
		"gd": "gj",
		"gu": "gq",
		"gg": "gk",
		"gn": "gv",
		"gw": "pu",
		"gq": "gv",
		"ht": "ha",
		"hn": "ho",
		"is": "ic",
		"iq": "iz",
		"ie": "ei",
		"il": "is",
		"jp": "ja",
		"ki": "kr",
		"kw": "ku",
		"lb": "le",
		"ls": "lt",
		"lv": "lg",
		"lr": "li",
		"li": "ls",
		"lt": "lh",
		"mo": "mc",
		"mg": "ma",
		"mw": "mi",
		"mu": "mp",
		"mc": "mn",
		"mn": "mg",
		"me": "mj",
		"ms": "mh",
		"ma": "mo",
		"na": "wa",
		"ni": "nu",
		"ne": "ng",
		"ng": "ni",
		"nu": "ne",
		"kp": "kn",
		"om": "mu",
		"pw": "ps",
		"pa": "pm",
		"pg": "pp",
		"py": "pa",
		"pr": "rq",
		"pt": "po",
		"ru": "rs",
		"bl": "tb",
		"lc": "st",
		"st": "tp",
		"mf": "rn",
		"sn": "sg",
		"rs": "ri",
		"sc": "se",
		"sg": "sn",
		"sk": "lo",
		"za": "sf",
		"kr": "ks",
		"ss": "od",
		"es": "sp",
		"lk": "ce",
		"sd": "su",
		"sr": "ns",
		"sj": "sv",
		"sz": "wz",
		"se": "sw",
		"ch": "sz",
		"tj": "ti",
		"tl": "tt",
		"tg": "to",
		"tk": "tl",
		"to": "tn",
		"tt": "td",
		"tn": "ts",
		"tr": "tu",
		"tm": "tx",
		"ua": "up",
		"gb": "uk",
		"vu": "nh",
		"vn": "vm",
		"ye": "ym",
		"zm": "za",
		"zw": "zi"
	]

	//
	// Inicializa o objeto
	//
	public init() {
	}
	
	//
	// Captura as características de um país
	//
	public func getCountryData(code: String, callback: (CountryDetails) -> Void) -> Void {
		var countryCode = code
		
		if let ciaCode = countryMappings[code] {
			countryCode = ciaCode
		}

		let url = NSURL(string: "https://www.cia.gov/library/publications/the-world-factbook/geos/\(countryCode).html")!
		let request = NSURLRequest(URL: url)
		let config = NSURLSessionConfiguration.defaultSessionConfiguration()
		let session = NSURLSession(configuration: config)

		let task = session.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
			if error == nil {
				if let contentData = data {
					let content = self.convertDataString(contentData)
					let result = CountryParser().execute(content)
					callback(result)
				}
			}
		});

		task.resume()
	}
	
	//
	// Converte o resultado de uma consulta Web em uma string
	//
	private func convertDataString(data: NSData) -> String {
		if let content = String(data: data, encoding: NSUTF8StringEncoding) {
			return content
		}
		
		let content = NSMutableString()
		let bytes = UnsafeBufferPointer<UInt8>(start: UnsafePointer(data.bytes), count: data.length)

		for byte in bytes {
			content.appendFormat("%02hhx", byte)
		}
		
		return content as String
	}
}