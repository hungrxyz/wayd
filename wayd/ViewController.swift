//
//  ViewController.swift
//  wayd
//
//  Created by Zel Marko on 2/15/16.
//  Copyright © 2016 Zel Marko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	@IBOutlet weak var activityTableView: UITableView!
	
	var results = [(String, NSDate)]()

	override func viewDidLoad() {
		super.viewDidLoad()
		
	}
	
	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
		
		let workQuestion = Question(text: "Did you do everything you planned today? 🤔",
			actions: [
				Action(title: "✔️ Yes", text: "Good, you can relax, tomorrow is another day 👍", result: "relax"),
				Action(title: "❌ No", text: "Okay, get to work! ✌️", result: "work")
			])
		let workAction = Action(title: "👷 Work", text: nil, question: workQuestion)
		
		let relaxQuestion = Question(text: "Did you do everything you planned today? 🤔",
			actions: [
				Action(title: "✔️ Yes", text: "Okay, you can relax. 👍", result: "relax"),
				Action(title: "❌ No", text: "No relaxing yet, get to work! 😤", result: "work")
			])
		let relaxAction = Action(title: "🕹 Relax", text: nil, question: relaxQuestion)
		
		let sleepQuestion = Question(text: "Did you do everything you planned today? 🤔",
			actions: [
				Action(title: "✔️ Yes", text: "Okay, you can go to sleep. 👍", result: "sleep"),
				Action(title: "❌ No", text: "No sleeping yet, get to work! 😤", result: "work")
			])
		let sleepAction = Action(title: "💤 Sleep", text: nil, question: sleepQuestion)
		
		let workoutQuestion = Question(text: "Did you workout today alredy? 🤔",
			actions: [
				Action(title: "✔️ Yes", text: nil,
					question: Question(text: "Did you do everything you planned today? 🤔",
						actions: [
							Action(title: "✔️ Yes", text: "Okay go get that workout in 👊", result: "workout"),
							Action(title: "❌ No", text: "Once a day is good, priorities man. Get that work done instead! 😤", result: "work")
						])),
				Action(title: "❌ No", text: "Okay, go get that workout in. 👊", result: "workout")
			])
		let workoutAction = Action(title: " 🏋 Workout", text: nil, question: workoutQuestion)
		
		let eatQuestion = Question(text: "When was the last time you ate? 🤔",
			actions: [
				Action(title: "😵 Didn't eat today yet", text: "Go get the body fuel. 🤗", result: "eat"),
				Action(title: "😇 Between 3 and 6 hours ago", text: "Okay, grab a snack. 🍫", result: "snack"),
				Action(title: "😆 Less than 3 hours ago", text: "No food for you, get back to what you were doing! 😏", result: "no eating")
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
				} else if let text = action.text, let result = action.result {
					let q = Question(text: text, actions: [Action(title: "Okay", result: result)])
					self.presentAlert(q)
				} else if let result = action.result {
					self.results.append((result, NSDate()))
					self.activityTableView.reloadData()
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

extension ViewController: UITableViewDataSource {
	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		tableView.hidden = results.count > 0 ? false : true
		return results.count
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("ActivityCell", forIndexPath: indexPath)
		
		let activity = results[indexPath.row]
		
		cell.textLabel?.text = activity.0
		cell.detailTextLabel?.text = "\(activity.1)"
		
		return cell
	}
}

