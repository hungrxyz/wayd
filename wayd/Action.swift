//
//  Action.swift
//  wayd
//
//  Created by Zel Marko on 2/15/16.
//  Copyright © 2016 Zel Marko. All rights reserved.
//

import Foundation

class Action {
	var title: String
	var text: String?
	var question: Question?
	var result: String?
	
	init(title: String, text: String? = nil, question: Question? = nil, result: String? = nil) {
		self.title = title
		if let text = text, let result = result {
			self.text = text
			self.result = result
		} else if let question = question {
			self.question = question
		} else if let result = result {
			self.result = result
		}
	}
}
