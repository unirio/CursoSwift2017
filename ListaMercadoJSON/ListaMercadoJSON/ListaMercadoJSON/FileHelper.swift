//
//  FileHelper.swift
//  ListaMercadoJSON
//
//  Created by Marcio Barros on 16/02/17.
//  Copyright © 2017 br.unirio.ios. All rights reserved.
//

import UIKit
import Foundation

typealias JSONObject = [String: Any]

typealias JSONArray = [Any]

class FileHelper {

	// Objeto de acesso aos arquivos
	private let fileManager = FileManager.default
	
	// Caminho completo do arquivo que será manipulado
	private let filePath : String
	
	// Inicializa o gerenciador de arquivos com todos os dados
	init(fileName: String, subDirectory: String, directory: FileManager.SearchPathDirectory) {
		let directoryPath = NSSearchPathForDirectoriesInDomains(directory, .userDomainMask, true)[0]
		self.filePath = directoryPath + "/" + subDirectory + "/" + fileName
		createDirectory(filePath: self.filePath)
	}
	
	// Inicializa o gerenciador de arquivos assumindo o diretório de documentos
	convenience init(fileName: String, subDirectory: String) {
		self.init(fileName: fileName, subDirectory: subDirectory, directory: .documentDirectory)
	}
	
	// Inicializa o gerenciador de arquivos assumindo a raiz do diretório de documentos
	convenience init(fileName:String) {
		self.init(fileName: fileName, subDirectory: "", directory: .documentDirectory)
	}
	
	// Cria o diretorio do arquivo
	private func createDirectory(filePath: String) {
		var isDir = ObjCBool(true)

		if !fileManager.fileExists(atPath: filePath, isDirectory: &isDir) {
			do {
				try fileManager.createDirectory(at: NSURL(string: filePath) as! URL, withIntermediateDirectories: false, attributes: nil)
			}
			catch {
				print("An error was generated while creating the directory.")
			}
		}
	}
	
	// Verifica se o arquivo existe
	var fileExists: Bool {
		get {
			return fileManager.fileExists(atPath: filePath)
		}
	}

	// Salva uma string no arquivo
	func save(string fileContents:String) {
		do {
			try fileContents.write(toFile: filePath, atomically: true, encoding: .utf8)
		}
		catch  {
			print("An error was generated while saving the file.")
		}
	}
	
	// Carrega uma string do arquivo
	func load() -> String {
		guard fileExists else {
			return ""
		}
		
		var result = ""

		do {
			result = try String(contentsOfFile: filePath, encoding: .utf8)
		}
		catch {
			print("An error was generated while loading the file.")
		}
		
		return result
	}
	
	// Salva um JSON no arquivo
	func save(json: JSONObject) {
		do {
			let newData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
			fileManager.createFile(atPath: filePath, contents: newData as Data, attributes: nil)
		}
		catch {
			print("An error was generated while saving the file.")
		}
		
	}
	
	// Carrega um JSON do arquivo
	func loadJson() -> JSONObject {
		guard fileExists else {
			return JSONObject()
		}
		
		do {
			let data = try NSData(contentsOfFile: filePath, options: .mappedIfSafe)
			return try JSONSerialization.jsonObject(with: data as Data, options: .allowFragments) as! JSONObject
		}
		catch {
			return JSONObject()
		}
	}
	
	// Salva uma imagem no arquivo
	func save(image: UIImage) {
		if let data = UIImageJPEGRepresentation(image, 1.0) {
			fileManager.createFile(atPath: filePath, contents: data, attributes: nil)
		}
	}
	
	// Carrega uma imagem do arquivo
	func loadImage() -> UIImage? {
		guard fileExists else {
			return nil
		}
		
		if let image = UIImage(contentsOfFile: filePath) {
			return image
		}
		
		return nil
	}
}
