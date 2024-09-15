import UIKit

final class MovieQuizViewController: UIViewController {
    // MARK: - Public Properties
    private let questionsAmount: Int = 10
    private let questionFactory: QuestionFactoryProtocol = QuestionFactory()
    private var currentQuestion: QuizQuestion?
    private let alert = UIAlertController(
        title: "Этот раунд окончен!",
        message: "Ваш результат ???",
        preferredStyle: .alert)
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if let firstQuestion = questionFactory.requestNextQuestion() {
            currentQuestion = firstQuestion
            let viewModel = convert(model: firstQuestion)
            show(quiz: viewModel)
        }
    }
    // MARK: - IB Outlets
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var textLabel: UILabel!
    @IBOutlet private var counterLabel: UILabel!
    @IBOutlet var yesButton: UIButton!
    @IBOutlet var noButton: UIButton!
    
    
    
    // MARK: - Private Properties
    
    private var currentQuestionIndex = 0
    private var correctAnswers = 0
    
    // MARK: - IB Actions
    @IBAction private func yesButtonClocked(_ sender: UIButton) {
        guard let currentQuestion = currentQuestion else {
            return
        }
            let givenAnswer = true
            showAnswerResult(isCorrect: givenAnswer == currentQuestion.correctAnswer)
        yesButton.isEnabled = false
        noButton.isEnabled = false
        
    }
    @IBAction private func noButtonClicked(_ sender: UIButton) {
        guard let currentQuestion = currentQuestion else {
            return
        }
            let givenAnswer = false
            showAnswerResult(isCorrect: givenAnswer == currentQuestion.correctAnswer)
        yesButton.isEnabled = false
        noButton.isEnabled = false
        
    }
    
    // MARK: - Private Methods
    private func showAnswerResult(isCorrect: Bool) {
        if isCorrect{
            correctAnswers+=1
        }
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 8
        imageView.layer.borderColor = isCorrect ? UIColor.ypGreen.cgColor : UIColor.ypRed.cgColor
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.showNextQuestionOrResults()
        }
    }
    private func showNextQuestionOrResults() {
        if currentQuestionIndex == questionsAmount - 1 {
            let text = correctAnswers == questionsAmount ?
                    "Поздравляем, вы ответили на 10 из 10!" :
                    "Вы ответили на \(correctAnswers) из 10, попробуйте ещё раз!"
            let viewModel = QuizResultsViewModel(
                title: "Этот раунд окончен!",
                text: text,
                buttonText: "Сыграть ещё раз")
            show(quiz: viewModel)
        } else {
            currentQuestionIndex += 1
            if let nextQuestion = questionFactory.requestNextQuestion() {
                currentQuestion = nextQuestion
                let viewModel = convert(model: nextQuestion)
                show(quiz: viewModel)
            }
        }
    }
    private func convert(model: QuizQuestion) -> QuizStepViewModel {
        let questionStep = QuizStepViewModel(
            image: UIImage(named: model.image) ?? UIImage(),
            question: model.text,
            questionNumber: "\(currentQuestionIndex + 1)/\(questionsAmount)")
        return questionStep
    }
    private func show(quiz step: QuizStepViewModel) {
        yesButton.isEnabled = true
        noButton.isEnabled = true
      imageView.image = step.image
      textLabel.text = step.question
      counterLabel.text = step.questionNumber
        imageView.layer.borderColor = UIColor.clear.cgColor
    }
    private func show(quiz result: QuizResultsViewModel) {
        let alert = UIAlertController(
            title: result.title,
            message: result.text,
            preferredStyle: .alert)

        let action = UIAlertAction(title: result.buttonText, style: .default) { [weak self] _ in // слабая ссылка на self
            guard let self = self else { return } // разворачиваем слабую ссылку

            self.currentQuestionIndex = 0
            self.correctAnswers = 0

            if let firstQuestion = self.questionFactory.requestNextQuestion()
                {
                self.currentQuestion = firstQuestion
                let viewModel = self.convert(model: firstQuestion)
                self.show(quiz: viewModel)
                }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in // слабая ссылка на self
            guard let self = self else { return } // разворачиваем слабую ссылку
            self.showNextQuestionOrResults()
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
        }
    
}
/*
 Mock-данные
 
 
 Картинка: The Godfather
 Настоящий рейтинг: 9,2
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА
 
 
 Картинка: The Dark Knight
 Настоящий рейтинг: 9
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА
 
 
 Картинка: Kill Bill
 Настоящий рейтинг: 8,1
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА
 
 
 Картинка: The Avengers
 Настоящий рейтинг: 8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА
 
 
 Картинка: Deadpool
 Настоящий рейтинг: 8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА
 
 
 Картинка: The Green Knight
 Настоящий рейтинг: 6,6
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА
 
 
 Картинка: Old
 Настоящий рейтинг: 5,8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ
 
 
 Картинка: The Ice Age Adventures of Buck Wild
 Настоящий рейтинг: 4,3
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ
 
 
 Картинка: Tesla
 Настоящий рейтинг: 5,1
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ
 
 
 Картинка: Vivarium
 Настоящий рейтинг: 5,8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ
*/
