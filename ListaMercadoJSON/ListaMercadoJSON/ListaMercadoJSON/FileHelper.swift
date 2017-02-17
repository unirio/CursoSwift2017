//
//  FileHelper.swift
//  ListaMercadoJSON
//
//  Created by Marcio Barros on 16/02/17.
//  Copyright © 2017 br.unirio.ios. All rights reserved.
//

import Foundation

typealias JSONObject = [String: Any]

typealias JSONArray = [Any]

class FileHelper {

	// Objeto de acesso aos arquivos
	private let fileManager = FileManager.default
	
	// Caminho completo do arquivo que será manipulado
	private let fullyQualifiedPath : String
	
	// Inicializa o gerenciador de arquivos com todos os dados
	init(fileName: String, subDirectory: String, directory: FileManager.SearchPathDirectory) {
		let directoryPath = NSSearchPathForDirectoriesInDomains(directory, .userDomainMask, true)[0]
		let filePath = directoryPath + "/" + subDirectory
		self.fullyQualifiedPath = "\(filePath)/\(fileName)"
		createDirectory(filePath: filePath)
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
			return fileManager.fileExists(atPath: fullyQualifiedPath)
		}
	}

	// Salva uma string no arquivo
	func save(string fileContents:String) {
		do {
			try fileContents.write(toFile: fullyQualifiedPath, atomically: true, encoding: String.Encoding.utf8)
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
			result = try String(contentsOfFile: fullyQualifiedPath, encoding: String.Encoding.utf8)
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
			fileManager.createFile(atPath: fullyQualifiedPath, contents: newData as Data, attributes: nil)
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
			let data = try NSData(contentsOfFile: fullyQualifiedPath, options: .mappedIfSafe)
			return try JSONSerialization.jsonObject(with: data as Data, options: .allowFragments) as! JSONObject
		}
		catch {
			return JSONObject()
		}
	}
}
