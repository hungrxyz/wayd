//
//  ViewController.swift
//  wayd
//
//  Created by Zel Marko on 2/15/16.
//  Copyright © 2016 Zel Marko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	let workData = ["first": "Did you do everything you planned today?", "firstYes": "Good, you can relax, tomorrow is another day", "firstNo": "Okay, get to work!"]
	let relaxData = ["first": "Did you do everything you planned today?", "firstYes": "Okay, you can relax.", "firstNo": "No relaxing yet, get to work!"]
	let sleepData = ["first": "Did you do everything you planned today?", "firstYes": "Okay, you can go to sleep.", "firstNo": "No slepping yet, get to work!"]
	let workoutData = ["first": "Did you workout today already?", "firstYes": "Did you do everything you planned today?", "firstNo": "Okay, go get that workout in.", "secondYes": "Okay, go get that workout in.", "secondNo": "Once a day is good, priorities man. Get that work done instead!"]
	let eatData = ["first": "When was the last time you ate?", "1": "Go get that fuel for your body", "2": "Alright, get a snack", "3": "NO! This is unercessary"]

	override func viewDidLoad() {
		super.viewDidLoad()
		
	}
	
	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
		
		let workQuestion = Question(text: "Did you do everything you planned today? 🤔",
			actions: [
				Action(title: "✔️ Yes", text: "Good, you can relax, tomorrow is another day 👍", question: nil),
				Action(title: "❌ No", text: "Okay, get to work! ✌️", question: nil)
			])
		let workAction = Action(title: "👷 Work", text: nil, question: workQuestion)
		
		let relaxQuestion = Question(text: "Did you do everything you planned today? 🤔",
			actions: [
				Action(title: "✔️ Yes", text: "Okay, you can relax. 👍", question: nil),
				Action(title: "❌ No", text: "No relaxing yet, get to work! 😤", question: nil)
			])
		let relaxAction = Action(title: "🕹 Relax", text: nil, question: relaxQuestion)
		
		let sleepQuestion = Question(text: "Did you do everything you planned today? 🤔",
			actions: [
				Action(title: "✔️ Yes", text: "Okay, you can go to sleep. 👍", question: nil),
				Action(title: "❌ No", text: "No sleeping yet, get to work! 😤", question: nil)
			])
		let sleepAction = Action(title: "💤 Sleep", text: nil, question: sleepQuestion)
		
		let workoutQuestion = Question(text: "Did you workout today alredy? 🤔",
			actions: [
				Action(title: "✔️ Yes", text: nil,
					question: Question(text: "Did you do everything you planned today? 🤔",
						actions: [
						Action(title: "✔️ Yes", text: "Okay go get that workout in 👊", question: nil),
						Action(title: "❌ No", text: "Once a day is good, priorities man. Get that work done instead! 😤", question: nil)
						])),
				Action(title: "❌ No", text: "Okay, go get that workout in. 👊", question: nil)
			])
		let workoutAction = Action(title: " 🏋 Workout", text: nil, question: workoutQuestion)
		
		let eatQuestion = Question(text: "When was the last time you ate? 🤔",
			actions: [
				Action(title: "😵 Didn't eat today yet", text: "Go get the body fuel. 🤗", question: nil),
				Action(title: "😇 Between 3 and 6 hours ago", text: "Okay, grab a snack. 🍫", question: nil),
				Action(title: "😆 Less than 3 hours ago", text: "No food for you, get back to what you were doing! 😏", question: nil)
			])
		let eatAction = Action(title: "🍽 Eat", text: nil, question: eatQuestion)

		
		let question = Question(text: "What were you going to do? 😀", actions: [workAction, relaxAction, sleepAction, workoutAction, eatAction])
		presentAlert(question)
	}
	
	func presentAlert(question: Question) {
		let alert = UIAlertController(title: question.text, message: nil, preferredStyle: .Alert)
		for action in question.actions {
			let alertAction = UIAlertAction(title: action.title, style: .Default) { _ in
				if let furtherQuestion = action.question {
					self.presentAlert(furtherQuestion)
				} else if let text = action.text {
					let q = Question(text: text, actions: [Action(title: "Okay", text: nil, question: nil)])
					self.presentAlert(q)
				}
			}
			alert.addAction(alertAction)
		}
		self.presentViewController(alert, animated: true, completion: nil)
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	
}

class Question {
	var text: String
	var actions: [Action]
	
	init(text: String, actions: [Action]) {
		self.text = text
		self.actions = actions
	}
}

class Action {
	var title: String
	var text: String?
	var question: Question?
	
	init(title: String, text: String?, question: Question?) {
		self.title = title
		if let text = text {
			self.text = text
		} else if let question = question {
			self.question = question
		}
	}
}

