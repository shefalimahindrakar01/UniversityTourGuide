//
//  QuizQuestionVC.swift
//  UONTourGuide
//
//  Created by Shefali Mahindrakar on 04/08/24.
//

import UIKit

class QuizQuestionVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var lblTotalQuestions: UILabel!
    @IBOutlet weak var lblTotalScore: UILabel!
    @IBOutlet weak var btnPrevious: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    
    var quizData: [(question: String, options: [String], correctAnswerIndex: Int, imageName: String, userSelectedAnswerIndex: Int?)] = []
    
    var currentQuestionIndex = 0
    var score = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Quiz"
        self.quizData = GlobalData.quizData
        updateUI()
        updateNavigationButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupCollectionView()
        navigationController?.navigationBar.tintColor = .textColor
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: view.bounds.width, height: view.bounds.height - 200)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        collectionView.setCollectionViewLayout(layout, animated: false)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "QuizQuestionCollectionCell", bundle: nil), forCellWithReuseIdentifier: "QuizQuestionCollectionCell")
        collectionView.isPagingEnabled = false // Disable paging to prevent direct scrolling
        collectionView.isScrollEnabled = false // Disable scrolling altogether
    }
    
    func updateUI() {
        lblTotalQuestions.text = "Question: \(currentQuestionIndex + 1) / \(quizData.count)"
        lblTotalScore.text = "Score: \(score)"
    }
    
    func updateNavigationButtons() {
        btnPrevious.isEnabled = (currentQuestionIndex > 0)
        btnNext.isEnabled = true // Always enable next button
    }
    
    @IBAction func btnPreviousTapped(_ sender: UIButton) {
        if currentQuestionIndex > 0 {
            currentQuestionIndex -= 1
            collectionView.reloadData() // Reload data to update visible cells
            collectionView.scrollToItem(at: IndexPath(item: currentQuestionIndex, section: 0), at: .left, animated: false)
            updateUI()
            updateNavigationButtons()
        }
    }
    
    @IBAction func btnNextTapped(_ sender: UIButton) {
        if currentQuestionIndex < quizData.count - 1 {
            currentQuestionIndex += 1
            collectionView.reloadData() // Reload data to update visible cells
            collectionView.scrollToItem(at: IndexPath(item: currentQuestionIndex, section: 0), at: .right, animated: false)
            updateUI()
            updateNavigationButtons()
        } else {
            // Show quiz result screen
            showQuizResult()
        }
    }
    
    func showQuizResult() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let quizResultVC = storyboard.instantiateViewController(withIdentifier: "QuizResultVC") as? QuizResultVC {
            quizResultVC.totalQuestions = quizData.count
            quizResultVC.score = score
            navigationController?.pushViewController(quizResultVC, animated: true)
        }
    }
}

extension QuizQuestionVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return quizData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuizQuestionCollectionCell", for: indexPath) as! QuizQuestionCollectionCell
        let questionData = quizData[indexPath.item]
        cell.configure(with: questionData)
        cell.delegate = self
        cell.cellIndex = indexPath.item // Set the index of the cell
        return cell
    }
    
}

extension QuizQuestionVC: QuizQuestionCollectionCellDelegate {
    
    func didSelectOption(optionIndex: Int, forCellAt index: Int) {
        let correctAnswerIndex = quizData[index].correctAnswerIndex
        
        if optionIndex == correctAnswerIndex {
            // Correct answer selected
            score += 1
            quizData[index].userSelectedAnswerIndex = optionIndex
        } else {
            // Incorrect answer selected
            quizData[index].userSelectedAnswerIndex = optionIndex
        }
        
        // Reload the cell to update UI after selection
        collectionView.reloadItems(at: [IndexPath(item: index, section: 0)])
        updateUI()
    }
    
}

