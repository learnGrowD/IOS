
import UIKit

protocol LEDBoardSettingDelegate : AnyObject {
    func changedSetting(text : String?, textColor : UIColor, backGroundColor : UIColor)
}

class SettingVC: UIViewController {
    
    weak var delegate : LEDBoardSettingDelegate?
    
    lazy var ledInfo : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "전광판에 표시할 글자"
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    lazy var ledTf : UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.heightAnchor.constraint(equalToConstant: 40).isActive = true
        tf.placeholder = "글자를 입력해 주세요 : )"
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    var textColorIdentity = UIColor.yellow
    lazy var textColorInfo : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "텍스트 색상 설정"
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    lazy var tcStackView : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .leading
        stack.spacing = 16
        return stack
    }()
    
    lazy var btnTcYello : UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(tapTextColor(btn:)), for: .touchUpInside)
        btn.backgroundColor = .yellow
        btn.layer.masksToBounds = true
        btn.widthAnchor.constraint(equalToConstant: 64).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 64).isActive = true
        btn.layer.cornerRadius = 32
        return btn
    }()
    
    lazy var btnTcPurple : UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(tapTextColor(btn:)), for: .touchUpInside)
        btn.backgroundColor = .purple
        btn.layer.masksToBounds = true
        btn.widthAnchor.constraint(equalToConstant: 64).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 64).isActive = true
        btn.layer.cornerRadius = 32
        return btn
    }()
    
    lazy var btnTcGreen : UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(tapTextColor(btn:)), for: .touchUpInside)
        btn.backgroundColor = .green
        btn.layer.masksToBounds = true
        btn.widthAnchor.constraint(equalToConstant: 64).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 64).isActive = true
        btn.layer.cornerRadius = 32
        return btn
    }()
    
    var bgColorIdentity = UIColor.gray
    lazy var backgroundColorInfo : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "배경 색상 설정"
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    lazy var bcStackView : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .leading
        stack.spacing = 16
        return stack
    }()
    
    lazy var btnBcGray : UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(tapBackgroundColor(btn:)), for: .touchUpInside)
        btn.backgroundColor = .gray
        btn.layer.masksToBounds = true
        btn.widthAnchor.constraint(equalToConstant: 64).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 64).isActive = true
        btn.layer.cornerRadius = 32
        return btn
    }()
    
    lazy var btnBcBlue : UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(tapBackgroundColor(btn:)), for: .touchUpInside)
        btn.backgroundColor = .blue
        btn.layer.masksToBounds = true
        btn.widthAnchor.constraint(equalToConstant: 64).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 64).isActive = true
        btn.layer.cornerRadius = 32
        return btn
    }()
    
    lazy var btnBcGPink : UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(tapBackgroundColor(btn:)), for: .touchUpInside)
        btn.backgroundColor = .systemPink
        btn.layer.masksToBounds = true
        btn.widthAnchor.constraint(equalToConstant: 64).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 64).isActive = true
        btn.layer.cornerRadius = 32
        return btn
    }()

    
    lazy var positiveBtn : UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("저장", for: .normal)
        btn.addTarget(self, action: #selector(tapPositiveBtn), for: .touchUpInside)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        self.navigationItem.title = "설정"
        setColorEarlyUI()
        setConstraint()
        
        [btnTcYello, btnTcPurple, btnTcGreen].map {
            tcStackView.addArrangedSubview($0)
        }
        
        [btnBcGray, btnBcBlue, btnBcGPink].map {
            bcStackView.addArrangedSubview($0)
        }

    }
    
    func setColorEarlyUI() {
        self.btnTcYello.alpha = 0.2
        self.btnTcPurple.alpha = 0.2
        self.btnTcGreen.alpha = 0.2
        if textColorIdentity == UIColor.yellow {
            self.btnTcYello.alpha = 1.0
        }else if textColorIdentity == UIColor.purple {
            self.btnTcPurple.alpha = 1.0
        }else if textColorIdentity == UIColor.green {
            self.btnTcGreen.alpha = 1.0
        }
        
        self.btnBcGray.alpha = 0.2
        self.btnBcBlue.alpha = 0.2
        self.btnBcGPink.alpha = 0.2
        if bgColorIdentity == UIColor.gray {
            self.btnBcGray.alpha = 1.0
        }else if bgColorIdentity == UIColor.blue {
            self.btnBcBlue.alpha = 1.0
        }else {
            self.btnBcGPink.alpha = 1.0
        }
        
        
        
    }
    
    @objc private func tapTextColor(btn : UIButton) {
        self.btnTcYello.alpha = 0.2
        self.btnTcPurple.alpha = 0.2
        self.btnTcGreen.alpha = 0.2
        
        btn.alpha = 1.0
        textColorIdentity = btn.backgroundColor!
    
    }
    
    @objc private func tapBackgroundColor(btn : UIButton) {
        self.btnBcBlue.alpha = 0.2
        self.btnBcGray.alpha = 0.2
        self.btnBcGPink.alpha = 0.2
        
        btn.alpha = 1.0
        bgColorIdentity = btn.backgroundColor!
    }
    
    @objc private func tapPositiveBtn() {
        self.delegate?.changedSetting(
            text : ledTf.text,
            textColor : textColorIdentity,
            backGroundColor : bgColorIdentity
        )
        self.navigationController?.popViewController(animated: true)
    }
    
    
    private func setConstraint() {
        view.addSubview(ledInfo)
        view.addSubview(ledTf)
        
        view.addSubview(textColorInfo)
        view.addSubview(tcStackView)
        view.addSubview(btnTcYello)
        view.addSubview(btnTcPurple)
        view.addSubview(btnTcGreen)
        
        view.addSubview(backgroundColorInfo)
        view.addSubview(bcStackView)
        view.addSubview(btnBcGray)
        view.addSubview(btnBcBlue)
        view.addSubview(btnBcGPink)
        
        view.addSubview(positiveBtn)
        
        
        NSLayoutConstraint.activate([
            ledInfo.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            ledInfo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            
            ledTf.topAnchor.constraint(equalTo: ledInfo.bottomAnchor, constant: 24),
            ledTf.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            ledTf.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            
            textColorInfo.topAnchor.constraint(equalTo: ledTf.bottomAnchor, constant: 24),
            textColorInfo.leadingAnchor.constraint(equalTo: ledInfo.leadingAnchor),
            tcStackView.leadingAnchor.constraint(equalTo: ledInfo.leadingAnchor),
            tcStackView.topAnchor.constraint(equalTo: textColorInfo.bottomAnchor, constant: 24),
            
            backgroundColorInfo.topAnchor.constraint(equalTo: tcStackView.bottomAnchor, constant: 24),
            backgroundColorInfo.leadingAnchor.constraint(equalTo: ledInfo.leadingAnchor),
            bcStackView.topAnchor.constraint(equalTo: backgroundColorInfo.bottomAnchor, constant: 24),
            bcStackView.leadingAnchor.constraint(equalTo: ledInfo.leadingAnchor),
            
            positiveBtn.topAnchor.constraint(equalTo: bcStackView.bottomAnchor, constant: 24),
            positiveBtn.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
            
        ])
    }
    

}
