(require '[clojure.string :as str])

(defn parseInputLines []
  (with-open [rdr (clojure.java.io/reader "input.txt")]
  (reduce conj [] (line-seq rdr))))
(def inputLines (parseInputLines))
(def transformMap
  (apply merge-with merge (into [] (for [mapLines (drop 2 inputLines)
    :let [linelist (str/split mapLines #" -> ")]
    :let [keylist (str/split (get linelist 0) #"")]
    :let [map (hash-map (get (get keylist 0) 0) (hash-map (get (get keylist 1) 0) (get (get linelist 1) 0)))]]
  map)))
)
(def startingList (seq (first inputLines)))
(defn mergeMaps
  [m1 m2]
  (merge-with + m1 m2))

(def startingMap
  (apply merge-with mergeMaps (into [] (for [i (range (- (count startingList) 1))
    :let [map (hash-map (nth startingList i) (hash-map (nth startingList (+ i 1)) 1))]]
  map)))
)

(defn applyStep[inputMap, currStep, maxSteps]
  (def updatedMap
    (apply merge-with mergeMaps 
      (for [key1 (keys inputMap) 
      :let [subMap (get inputMap key1)]]
        (apply merge-with mergeMaps 
          (for [key2 (keys subMap) 
          :let [newChar (get (get transformMap key1) key2)] 
          :let [oldPairCount (get subMap key2)]]
            (if (and (= key1 newChar) (= key2 newChar))
              (hash-map key1 (hash-map key2 (+ 1 oldPairCount)))
              (if (= key1 newChar)
                (hash-map key1 (hash-map newChar oldPairCount key2 oldPairCount)) 
                (hash-map key1 (hash-map newChar oldPairCount) newChar (hash-map key2 oldPairCount)) 
              )
            )
          )
        )
      )
    )
  )
  (if (< currStep maxSteps)
    (recur updatedMap (+ currStep 1) maxSteps)
    updatedMap
  )
)

(defn countCharsInMap[inputMap lastChar]
  (def countMap
    (apply merge-with + 
      (for [key1 (keys inputMap) 
      :let [subMap (get inputMap key1)]]
        (apply merge-with + 
          (for [key2 (keys subMap) 
          :let [newChar (get (get transformMap key1) key2)] 
          :let [oldPairCount (get subMap key2)]]
            (if (= key1 newChar)
              (hash-map key1 (* 2 oldPairCount))
              (hash-map key1 oldPairCount newChar oldPairCount)
            )
          )
        )
      )
    )
  )
  (merge-with + countMap (hash-map lastChar 1))  
)

(defn frequenciesAfterNSteps[inputMap numSteps lastChar]
  (countCharsInMap (applyStep inputMap 1 (- numSteps 1)) lastChar)
)

(let [ frequencyVals (sort (vals (frequenciesAfterNSteps startingMap 40 (last startingList))))
       maxMinusMin (- (last frequencyVals) (first frequencyVals))]                                      
  (println frequencyVals)
  (println maxMinusMin)
)