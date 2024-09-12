//
//  FeedbackVC.swift
//  UONTourGuide
//
//  Created by Shefali Mahindrakar on 04/08/24.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class FeedbackVC: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var btnClose: UIButton!
    @IBOutlet weak var starButton1: UIButton!
    @IBOutlet weak var starButton2: UIButton!
    @IBOutlet weak var starButton3: UIButton!
    @IBOutlet weak var starButton4: UIButton!
    @IBOutlet weak var starButton5: UIButton!
    @IBOutlet weak var feedbackTextView: UITextView!
    @IBOutlet weak var btnSubmit: UIButton!
    
    let placeholderText = "Type your feedback here..."
    var rating = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        starButton1.tag = 1
        starButton2.tag = 2
        starButton3.tag = 3
        starButton4.tag = 4
        starButton5.tag = 5
        feedbackTextView.layer.cornerRadius = 8
        feedbackTextView.layer.borderColor = UIColor.gray.cgColor
        feedbackTextView.layer.borderWidth = 1
        btnSubmit.layer.cornerRadius = 8
        feedbackTextView.delegate = self
        feedbackTextView.text = placeholderText
        feedbackTextView.textColor = UIColor.lightGray
    }
    
    @IBAction func starButtonTapped(_ sender: UIButton) {
        rating = sender.tag
        updateStars(rating: rating)
    }
    
    @IBAction func btnCloseTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnSubmitFeedbackTapped(_ sender: UIButton) {
        submitFeedback()
    }
    
    func updateStars(rating: Int) {
        let buttons = [starButton1, starButton2, starButton3, starButton4, starButton5]
        
        for (index, button) in buttons.enumerated() {
            if index < rating {
                button?.setImage(UIImage(systemName: "star.fill"), for: .normal)
            } else {
                button?.setImage(UIImage(systemName: "star"), for: .normal)
            }
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == placeholderText {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = placeholderText
            textView.textColor = UIColor.lightGray
        }
    }
    
    func submitFeedback() {
        guard let user = Auth.auth().currentUser else {
            showErrorSnackbar(message: "No user is signed in.")
            return
        }
        
        let email = user.email ?? "No Email Available"
        let feedback = feedbackTextView.text ?? ""
        
        if feedback.isEmpty || feedback == placeholderText {
            showErrorSnackbar(message: "Please enter your feedback.")
            return
        }
        
        let feedbackData: [String: Any] = [
            "email": email,
            "rating": rating,
            "feedback": feedback,
            "timestamp": Timestamp()
        ]
        
        showLoadingIndicator()
        
        let db = Firestore.firestore()
        db.collection("feedbacks").addDocument(data: feedbackData) { error in
            hideLoadingIndicator()
            if let error = error {
                showErrorSnackbar(message: "Error adding document: \(error.localizedDescription)")
            } else {
                showSuccessSnackbar(message: "Feedback submitted successfully.")
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}

