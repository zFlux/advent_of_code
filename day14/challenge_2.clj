(require '[clojure.string :as str])

(defn parseInputLines []
  (with-open [rdr (clojure.java.io/reader "input_test.txt")]
  (reduce conj [] (line-seq rdr))))
(def inputLines (parseInputLines))
(def transformMap
  (apply merge-with merge (into [] (for [mapLines (drop 2 inputLines)
    :let [linelist (str/split mapLines #" -> ")]
    :let [keylist (str/split (get linelist 0) #"")]
    :let [map (hash-map (get (get keylist 0) 0) (hash-map (get (get keylist 1) 0) (get (get linelist 1) 0)))]]
  map)))
)
(def template (seq (first inputLines)))

(defn recurseOnSeqPair [c1 c2 currDepth maxDepth frequencyMap]
  (let [newChar (get (get transformMap c1) c2)]
    (if ( < currDepth maxDepth)
      (merge-with + (recurseOnSeqPair c1 newChar (+ currDepth 1) maxDepth frequencyMap) (recurseOnSeqPair newChar c2 (+ currDepth 1) maxDepth frequencyMap))
      (merge-with + (hash-map c1 1) (hash-map newChar 1) frequencyMap) 
    )
  )
)

(defn applyMapToSequence [i depth result]
  (if (> i (- (count template) 2))
    (merge-with + result (hash-map (.get template i) 1))
    (let [ newResult (merge-with + result (recurseOnSeqPair (.get template i) (.get template (+ 1 i)) 0 depth {}))]
      (recur (+ i 1) depth newResult)
    )
  )
)

(let [results (applyMapToSequence 0 39 {})]
  (let [sortedFrequencies
     (into (sorted-map-by 
             (fn [key1 key2]
             (compare [(get results key2) key2]
                     [(get results key1) key1])
             )
           )
     results)]
     (println "results")
     (println   ( - (first (vals sortedFrequencies)) (last (vals sortedFrequencies))))
   )
)







