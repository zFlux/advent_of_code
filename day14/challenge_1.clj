(require '[clojure.string :as str])

(defn parseInputLines []
  (with-open [rdr (clojure.java.io/reader "input.txt")]
  (reduce conj [] (line-seq rdr))))
(def inputLines (parseInputLines))
(def transformMap
  (into {} (for [mapLines (drop 2 inputLines)
    :let [map (apply hash-map (str/split mapLines #" -> "))]]
  map))
)

(defn applySeqMap [charSeq transformMap iter acc]
  (if (> iter (- (count charSeq) 2))
    (seq (apply str(conj acc (nth charSeq iter))))
    (let [key (str (nth charSeq iter) (nth charSeq (+ iter 1)))]
      (recur charSeq 
             transformMap 
             (inc iter) 
             (conj acc (str (nth charSeq iter) (get transformMap key))))
    )
  )
)

(defn multiApplySeqMap [charSeq transformMap i limit]
  (if (< i limit)
      (let [newCharSeq (applySeqMap charSeq, transformMap 0 [])]
        (recur newCharSeq transformMap (+ i 1) limit))
      charSeq)
)
   
(let [results (frequencies (apply str(multiApplySeqMap (seq (first inputLines)) transformMap 0 10)))]
   (let [sortedFrequencies
      (into (sorted-map-by 
              (fn [key1 key2]
              (compare [(get results key2) key2]
                      [(get results key1) key1])
              )
            )
      results)]
      (println   ( - (first (vals sortedFrequencies)) (last (vals sortedFrequencies))))
    )
)




