//
//  IssueEnrollViewController.swift
//  IssueTracker
//
//  Created by kimn on 2020/11/08.
//

import UIKit
import MarkdownView
import SafariServices

class IssueEnrollViewController: UIViewController {
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var markdownSegment: UISegmentedControl!
    @IBOutlet weak var markdownUIView: UIView!
    @IBOutlet weak var textDescription: UITextView!
    
    private var markdown = ["Markdown", "Preview"]
    private let markdownView = MarkdownView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        titleView.layer.addBorder([.top, .bottom], color: UIColor.systemGray5, width: 1)
        markdownSetup()
        placeholderSetting()
    }
    
    private func markdownSetup() {
        markdownUIView.addSubview(markdownView)
        markdownView.translatesAutoresizingMaskIntoConstraints = false
        markdownView.topAnchor.constraint(equalTo: markdownUIView.topAnchor).isActive = true
        markdownView.leadingAnchor.constraint(equalTo: markdownUIView.leadingAnchor).isActive = true
        markdownView.trailingAnchor.constraint(equalTo: markdownUIView.trailingAnchor).isActive = true
        markdownView.bottomAnchor.constraint(equalTo: markdownUIView.bottomAnchor).isActive = true
        
        markdownSegment.addTarget(self, action: #selector(updateView), for: .valueChanged)
    }
    
    @objc func updateView() {
        let selectedSeg = markdown[markdownSegment.selectedSegmentIndex]
        if selectedSeg == "Markdown" {
            markdownUIView.isHidden = true
            textDescription.isHidden = false
        } else {
            markdownUIView.isHidden = false
            textDescription.isHidden = true
            if markdownView.subviews.count > 0 {
                markdownView.subviews[0].removeFromSuperview()
            }
            
            if textDescription.textColor != UIColor.lightGray {
                markdownView.onTouchLink = { [weak self] request in
                  guard let url = request.url else { return false }

                  if url.scheme == "file" {
                    return true
                  } else if url.scheme == "https" {
                    let safari = SFSafariViewController(url: url)
                    self?.present(safari, animated: true, completion: nil)
                    return false
                  } else {
                    return false
                  }
                }
                
                markdownView.load(markdown: textDescription.text, enableImage: true)
            }
        }
    }
    
    @IBAction func saveButton(_ sender: Any) {
        //
    }
}

extension IssueEnrollViewController: UITextViewDelegate {
    private func placeholderSetting() {
        textDescription.delegate = self
        textDescription.text = "코멘트는 여기에 작성하세요."
        textDescription.textColor = UIColor.lightGray
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textDescription.textColor == UIColor.lightGray {
            textDescription.text = nil
            textDescription.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textDescription.text.isEmpty {
            textDescription.text = "코멘트는 여기에 작성하세요."
            textDescription.textColor = UIColor.lightGray
        }
    }
}
