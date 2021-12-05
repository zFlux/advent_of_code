class BingoCard(input: Iterator<String>) {
    private val cardMap = HashMap<String, ArrayList<ArrayList<Int>>>()
    private val resultArray = ArrayList<ArrayList<Boolean>>()
    private val markedValues = ArrayList<String>()

    init {
        for (row in 0..4) {
            val cardValues = input.next().trim().split("\\s+".toRegex())
            for (column in cardValues.indices) {
                if (cardMap[cardValues[column]] == null) {
                    cardMap[cardValues[column]] = arrayListOf(arrayListOf(column, row))
                } else {
                    cardMap[cardValues[column]]?.add(arrayListOf(column, row))
                }
            }
        }

        for (row in 0..4) {
            resultArray.add(arrayListOf(false,false,false,false,false))
        }
    }

    fun markAndEvaluate(number: String): Boolean {
        val whereToMarkList = cardMap[number]
        if (whereToMarkList != null) {
            for (markCoordinates in whereToMarkList) {
                resultArray[markCoordinates[0]][markCoordinates[1]] = true
                markedValues.add(number)
            }
        }

        return this.evaluate()
    }

    private fun evaluate(): Boolean {
        return markedRow(0) || markedRow(1) || markedRow(2) || markedRow(3) || markedRow(4) ||
                markedColumn(0) || markedColumn(1) || markedColumn(2) || markedColumn(3) || markedColumn(4)
    }

    private fun markedRow(row: Int): Boolean {
        return resultArray[0][row] && resultArray[1][row] && resultArray[2][row] && resultArray[3][row] && resultArray[4][row]
    }

    private fun markedColumn(column: Int): Boolean {
        return resultArray[column][0] && resultArray[column][1] && resultArray[column][2] && resultArray[column][3] && resultArray[column][4]
    }

    fun cardScore(): Int {
        var result = 0
        for (key in cardMap.keys) {
            if (!markedValues.contains(key)) {
                result+=key.toInt()
            }
        }
        return result
    }

    fun cardMap(): String {
        return cardMap.toString()
    }

    fun cardResult(): String {
        return resultArray.toString()
    }
}