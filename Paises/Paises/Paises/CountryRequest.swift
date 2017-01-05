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
	// Inicializa o objeto
	//
	public init() {
	}
	
	//
	// Captura os identificadores de todos os países
	//
	public func getCountryIdentifiers(callback: ([CountryIdentifier]) -> Void) -> Void {
		let url = NSURL(string: "https://www.cia.gov/library/publications/the-world-factbook/docs/refmaps.html")!
		let request = NSURLRequest(URL: url)
		let config = NSURLSessionConfiguration.defaultSessionConfiguration()
		let session = NSURLSession(configuration: config)
		
		let task = session.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
			if error == nil {
				if let contentData = data {
					let content = self.convertDataString(contentData)
					let pattern = "<option value=\"\\.\\.\\/geos\\/(\\w{2})\\.html\">\\s+(.*)?\\s+<\\/option>"
					
					let regex = try! NSRegularExpression(pattern: pattern, options: [.CaseInsensitive])
					let range = NSMakeRange(0, content.characters.count)
					let matches = regex.matchesInString(content, options: [], range: range)
					
					var result : [CountryIdentifier] = []
					
					for match in matches {
						let code = (content as NSString).substringWithRange(match.rangeAtIndex(1))
						let name = (content as NSString).substringWithRange(match.rangeAtIndex(2))
						
						let country = CountryIdentifier(code: code, name: name)
						country.Code = code
						country.Name = name
						result.append(country)
					}
					
					callback(result)
				}
			}
			
		});
		
		task.resume()
	}
	
	//
	// Captura as características de um país
	//
	public func getCountryData(code: String, callback: (Country) -> Void) -> Void {
		let url = NSURL(string: "https://www.cia.gov/library/publications/the-world-factbook/geos/\(code).html")!
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