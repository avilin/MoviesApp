//
//  CreateMovieViewController.swift
//  MoviesApp
//
//  Created by Andrés Vicente Linares on 3/6/17.
//  Copyright © 2017 Andrés Vicente Linares. All rights reserved.
//

import UIKit

class CreateMovieViewController: UITableViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var imageURLTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var movieLengthTextField: UITextField!
    @IBOutlet weak var releaseDateTextField: UITextField!
    @IBOutlet weak var genreTextField: UITextField!
    @IBOutlet weak var synopsisTextView: UITextView!

    @IBOutlet weak var saveButton: UIBarButtonItem!

    // MARK: - Properties
    var viewModel: CreateMovieViewModel?
    fileprivate let activityIndicator = AppActivityIndicator()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imageView.image = #imageLiteral(resourceName: "movieImagePlaceholder")

        initBindings()

        activityIndicator.configure(for: view)

    }

    // MARK: - IBActions
    @IBAction func editingChanged(_ sender: UITextField) {
        switch sender {
        case nameTextField:
            viewModel?.name.onViewUpdated?(nameTextField.text!)
        case movieLengthTextField:
            viewModel?.movieLength.onViewUpdated?(movieLengthTextField.text!)
        case releaseDateTextField:
            viewModel?.releaseDate.onViewUpdated?(releaseDateTextField.text!)
        case genreTextField:
            viewModel?.genre.onViewUpdated?(genreTextField.text!)
        default:
            break
        }
    }

    @IBAction func editingDidEnd(_ sender: UITextField) {
        switch sender {
        case imageURLTextField:
            viewModel?.imageURL.onViewUpdated?(imageURLTextField.text!)
        default:
            break
        }
    }

    @IBAction func pickFromGalleryTouched(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .photoLibrary
            imagePicker.delegate = self

            present(imagePicker, animated: true)
        }
    }

    @IBAction func clearImageSelectionTouched(_ sender: UIButton) {
        imageView.image = #imageLiteral(resourceName: "movieImagePlaceholder")
        viewModel?.imageData.onViewUpdated?(nil)
    }

    @IBAction func saveTouched(_ sender: UIBarButtonItem) {
        viewModel?.create()
    }

    // MARK: - Custom functions
    func initBindings() {
        viewModel?.name.bindAndFireOnModelUpdated { [unowned self] name in
            self.nameTextField.text = name
        }

        viewModel?.imageURL.bindAndFireOnModelUpdated { [unowned self] image in
            if let image = image, let url = URL(string: image), UIApplication.shared.canOpenURL(url) {
                self.imageView.load.request(with: image)
            } else {
                self.imageView.image = #imageLiteral(resourceName: "movieImagePlaceholder")
            }
        }

        viewModel?.synopsis.bindAndFireOnModelUpdated { [unowned self] synopsis in
            self.synopsisTextView.text = synopsis
        }

        viewModel?.movieLength.bindAndFireOnModelUpdated { [unowned self] movieLength in
            self.movieLengthTextField.text = "\(movieLength)"
        }

        viewModel?.releaseDate.bindAndFireOnModelUpdated { [unowned self] releaseDate in
            self.releaseDateTextField.text = "\(releaseDate)"
        }

        viewModel?.genre.bindAndFireOnModelUpdated { [unowned self] genre in
            self.genreTextField.text = genre
        }

        viewModel?.enableImageURL.bindAndFireOnModelUpdated { [unowned self] enableImageURL in
            self.imageURLTextField.isEnabled = enableImageURL
        }

        viewModel?.enableSave.bindAndFireOnModelUpdated { [unowned self] enableSave in
            self.saveButton.isEnabled = enableSave
        }
    }

}

extension CreateMovieViewController: UITextViewDelegate {

    func textViewDidChange(_ textView: UITextView) {
        switch textView {
        case synopsisTextView:
            viewModel?.synopsis.onViewUpdated?(synopsisTextView.text!)
        default:
            break
        }
    }

}

// MARK: - UIImagePickerControllerDelegate
extension CreateMovieViewController: UIImagePickerControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        imageView.image = image
        if let image = image?.resize(toWidth: 600) {
            let imageData = UIImagePNGRepresentation(image)
            viewModel?.imageData.onViewUpdated?(imageData)
        } else {
            viewModel?.imageData.onViewUpdated?(nil)
        }

        dismiss(animated: true)
    }

}

// MARK: - UINavigationControllerDelegate
extension CreateMovieViewController: UINavigationControllerDelegate {

}

// MARK: - BackgroundTaskEventDelegate
extension CreateMovieViewController: BackgroundTaskEventDelegate {

    func showActivityIndicator() {
        activityIndicator.show()
    }

    func hideActivityIndicator() {
        activityIndicator.hide()
    }

}

// MARK: - BackNavigationEventDelegate
extension CreateMovieViewController: BackNavigationEventDelegate {

    func goBack() {
        navigationController?.popViewController(animated: true)
    }

}
