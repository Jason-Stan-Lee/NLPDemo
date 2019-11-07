//
//  NLP.swift
//  NLPDemo
//
//  Created by JasonLee on 2019/5/24.
//  Copyright © 2019 JasonStanLee. All rights reserved.
//

import Cocoa

class NLP {

    // https://www.appcoda.com/natural-language-processing-swift/
    let quote = "你是什么意思呢？中华人民共和国国歌。Here's to the crazy ones."//"Here's to the crazy ones. The misfits. The rebels. The troublemakers. The round pegs in the square holes. The ones who see things differently. They're not fond of rules. And they have no respect for the status quo. You can quote them, disagree with them, glorify or vilify them. About the only thing you can't do is ignore them. Because they change things. They push the human race forward. And while some may see them as the crazy ones, we see genius. Because the people who are crazy enough to think they can change the world, are the ones who do. - Steve Jobs (Founder of Apple Inc.)"

    // Initialize NSLinguisticTagger, pass in the NSLinguisticTagScheme you are interested in analyzing.
    let tagger = NSLinguisticTagger(tagSchemes:[.tokenType, .language, .lexicalClass, .nameType, .lemma], options: 0)

    //Setting various options, such as ignoring white spaces and punctuations
    let options: NSLinguisticTagger.Options = [.omitPunctuation, .omitWhitespace, .joinNames]

    /*
     Language Identification
     The first tag scheme type, language identification, attempts to identify the BCP-47 language most prominent at either a document, paragraph, or sentence level. You can retrieve this language by accessing the dominantLanguage property of the NSLinguisticTagger instance object:
     */
    func determineLanguage(for text: String) {
        tagger.string = text
        let language = tagger.dominantLanguage
        print("The language is \(language!)")
    }

    /*
     Tokenization is the process of demarcating and possibly classifying sections of a string of input characters. The resulting tokens are then passed on to some other form of processing. (source: Wikipedia)
     */
    func tokenization(for text: String) {
        tagger.string = text
        print("tokenization: -----")
        let range = NSRange(location: 0, length: text.utf16.count)
        tagger.enumerateTags(in: range, unit: .word, scheme: .tokenType, options: options) { tag, tokenRange, stop in
            let token = (text as NSString).substring(with: tokenRange)
            // Handle each token, (i.e add to array)
            print(token)
        }

    }

    /*
     Lemmatization groups together the inflected forms of a word to be analyzed as a singular item, allowing you to infer the intended meaning. Essentially, all you need to remember is that it is deriving the dictionary form of the word.
     */
    func lemmatization(for text: String) {
        tagger.string = text
        print("lemmatization: -----")
        let range = NSRange(location:0, length: text.utf16.count)
        // we would set the scheme in the tagger initialization to .lemma
        tagger.enumerateTags(in: range, unit: .word, scheme: .lemma, options: options) { tag, tokenRange, stop in
            if let lemma = tag?.rawValue {
                print(lemma)
            }
        }
    }

    /*
     Part of Speech (PoS)
     Part of Speech tagging aims to associate the part of the speech to each specific word, based on both the word's definition and context (its relationship to adjacent and related words). As an element of NLP, part of speech tagging allows us to focus on the nouns and verbs, which can help us infer the intent and meaning of text.
     */
    func partsOfSpeech(for text: String) {
        tagger.string = text
        print("partsOfSpeech: -----")
        let range = NSRange(location: 0, length: text.utf16.count)
        // Implementing part of speech tagging involves setting the tagger property to use .lexicalClass
        tagger.enumerateTags(in: range, unit: .word, scheme: .lexicalClass, options: options) { tag, tokenRange, _ in
            if let tag = tag {
                let word = (text as NSString).substring(with: tokenRange)
                print("\(word): \(tag.rawValue)")
            }
        }
    }

    /*
     Named Entity Recognition is one of the most powerful NLP classification tagging components, allowing you to classify named real-world entities or objects from your sentence (i.e. locations, people, names). As an iPhone user, you would have already seen this in action when you text your friends, and you would have observed certain keywords highlighted, such as phone numbers, names, or dates.
     */
    func namedEntityRecognition(for text: String) {
        tagger.string = text
        let range = NSRange(location: 0, length: text.utf16.count)
        print("namedEntityRecognition: -----")

        // Setting the tag scheme to .nameType
        tagger.enumerateTags(in: range, unit: .word, scheme: .nameType, options: options) { tag, tokenRange, _ in

            if let tag = tag {
                let word = (text as NSString).substring(with: tokenRange)
                print("\(word): \(tag.rawValue)")
            }
        }
    }

}
