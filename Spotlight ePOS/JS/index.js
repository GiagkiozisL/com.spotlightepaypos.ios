const CryptoJS = require('crypto.js')

export class Analyzer {
    static analyze(phrase) {
        // Make sure nativeLog is defined and is a function
        if (typeof nativeLog === 'function') {
            nativeLog(`Analyzing '${phrase}'`)
        }
        
        let sentiment = new CryptoJSt()
        let result = sentiment.analyze(phrase)
        return result['score']
    }
}
