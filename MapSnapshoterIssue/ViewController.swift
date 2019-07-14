//
//  ViewController.swift
//  MapSnapshoterIssue
//
//  Created by Miquel Alvarado on 14/07/2019.
//  Copyright © 2019 Miquel Alvarado. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var snapshotImageView: UIImageView!

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        makeSnapshot()
    }

    private func makeSnapshot() {
        let options = MKMapSnapshotter.Options()
        let center = CLLocationCoordinate2D(latitude: 37.334722, longitude: -122.008889)
        let span = MKCoordinateSpan(latitudeDelta: 0.06, longitudeDelta: 0.06)
        options.region = MKCoordinateRegion(center: center, span: span)
        options.size = snapshotImageView.frame.size
        let snapshotter = MKMapSnapshotter(options: options)
        snapshotter.start(with: .global(qos: .userInitiated)) { (snapshot, _) in
            guard let snapshot = snapshot else { return }
            let image = snapshot.image
            UIGraphicsBeginImageContextWithOptions(image.size, true, image.scale)
            image.draw(at: .zero)

            let mapImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()

            DispatchQueue.main.async {
                self.snapshotImageView.image = mapImage
            }
        }
    }
}

