(use 'clojure.java.io)
(require '[clojure.string :as str])
(with-open [rdr (reader "input_test.txt")]
  (doseq [line (line-seq rdr)]
    (if (str/includes? line " -> ")
      (println (str/split line #" -> "))
      (println "Low")
      )))