(require '[clojure.string :as str])
(import java.util.LinkedList) 

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

(defn applySeqMap [charSeq iter]
  (if (> iter (- (count charSeq) 2))
    charSeq
    (let [k1 (.get charSeq iter) k2 (.get charSeq (+ iter 1))]
      (.add charSeq (+ 1 iter) (get (get transformMap k1) k2))
      (recur charSeq (+ iter 2))
    )
  )
)

(defn multiApplySeqMap [charSeq i limit]
  (if (< i limit)
      (recur (applySeqMap charSeq 0) (+ i 1) limit)
      charSeq)
)

(let [results (frequencies (apply str(multiApplySeqMap (new java.util.LinkedList (seq (first inputLines))) 0 40)))]
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







