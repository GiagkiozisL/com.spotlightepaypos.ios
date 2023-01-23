const Crypto = require('crypto-js')

export class Analyzer {
    static analyze(message, key) {
        // Make sure nativeLog is defined and is a function
        if (typeof nativeLog === 'function') {
            nativeLog(`Analyzing: '${message}' with key: 'r_u_looking_4_my_key?'`)
        }

        let hmacOut = Crypto.HmacSHA256(message, Crypto.MD5(key)); 
        nativeLog(`Analyzing hash: '${hmacOut}'`)
        return hmacOut
    }
}

