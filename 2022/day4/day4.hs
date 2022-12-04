import qualified Data.Text    as Text
import qualified Data.Text.IO as Text

splitDash = Text.splitOn (Text.pack "-")
splitComma = Text.splitOn (Text.pack ",")
splitInts :: Text.Text -> (Int, Int)
splitInts s = (read (Text.unpack a), read (Text.unpack b))
  where [a, b] = splitDash s

readInput = do
  input <- Text.readFile "input.txt"
  return $ Text.lines input

rangeStrings = do
  input <- readInput
  return $ map (splitComma) input

rangeLists = do
  input <- rangeStrings
  return $ map (map splitInts) input

-- Part 1
checkRangeContained :: (Int, Int) -> (Int, Int) -> Bool
checkRangeContained (a, b) (c, d) = (c >= a && d <= b) || (a >= c && b <= d)

checkRangesContained :: [(Int, Int)] -> Bool
checkRangesContained (x:xs) = any (checkRangeContained x) xs

checkAllRangesContained :: [[(Int, Int)]] -> [Bool]
checkAllRangesContained = map (checkRangesContained)

-- Part 2
checkRangeOverlap :: (Int, Int) -> (Int, Int) -> Bool
checkRangeOverlap (a, b) (c, d) = (c >= a && c <= b) || (d >= a && d <= b) || (a >= c && a <= d) || (b >= c && b <= d)

checkRangesOverlap :: [(Int, Int)] -> Bool
checkRangesOverlap (x:xs) = any (checkRangeOverlap x) xs

checkAllRangesOverlap :: [[(Int, Int)]] -> [Bool]
checkAllRangesOverlap = map (checkRangesOverlap)

countTrue :: [Bool] -> Int
countTrue = length . filter (== True)

main = do
  input <- rangeLists
  print $ "Part 1 Solution: " ++ (show $ countTrue $ checkAllRangesContained input)
  print $ "Part 2 Solution: " ++ (show $ countTrue $ checkAllRangesOverlap input)