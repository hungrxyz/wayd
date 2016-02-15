//
//  Question.swift
//  wayd
//
//  Created by Zel Marko on 2/15/16.
//  Copyright © 2016 Zel Marko. All rights reserved.
//

import Foundation

class Question {
	var text: String
	var actions: [Action]
	
	init(text: String, actions: [Action]) {
		self.text = text
		self.actions = actions
	}
}