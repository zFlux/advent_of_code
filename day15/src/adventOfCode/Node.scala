package adventOfCode {
  class Node(val weight: Int, val row: Int, val column: Int, var distance: Int, var prev: Node) {
//    override def toString() = {
//      if distance == Int.MaxValue then
//        "-"
//      else
//        distance.toString
//    }

    override def toString() = {
        weight.toString
    }
  }
}
