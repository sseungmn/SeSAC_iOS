import Foundation

// NOTE: Uncommment following two lines for use in a Playground
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

let url = URL(string: "https://api.openrouteservice.org/v2/directions/cycling-regular?api_key=5b3ce3597851110001cf62483c07b42b237d4522942eb9cbfe5f658d&start=127.115275,%2037.485605&end=126.95766807257243,%2037.50332655110263")!
var request = URLRequest(url: url)
request.addValue("application/json, application/geo+json, application/gpx+xml, img/png; charset=utf-8", forHTTPHeaderField: "Accept")

let task = URLSession.shared.dataTask(with: request) { data, response, error in
  if let response = response, let data = data {
    print(response)
    print(String(decoding: data, as: UTF8.self))
  } else {
    print(error)
  }
}

task.resume()
