defmodule Challenge1 do
  def traverseCaves(currentCave, pathMap, result, visited, visitedTwice) do
    if currentCave == "end" do
      (result <> ", " <> currentCave)
    else
      if !MapSet.member?(visited, currentCave) || (MapSet.member?(visited, currentCave) && currentCave != "start" && MapSet.size(visitedTwice) == 0) do
        result =
          if currentCave != "start" do
            result <> ", " <> currentCave
          else
            result <> currentCave
          end

        visitedTwice =
          if String.downcase(currentCave) == currentCave && currentCave != "start" && MapSet.member?(visited, currentCave) do
            MapSet.put(visitedTwice, currentCave)
          else
            visitedTwice
          end

        visited =
          if String.downcase(currentCave) == currentCave do
            MapSet.put(visited, currentCave)
          else
            visited
          end
        for nextCave <- pathMap[currentCave] do
          traverseCaves(nextCave, pathMap, result, visited, visitedTwice)
        end
      end
    end
  end
end

resolveMapMergeConflicts =
  fn _k, list1, list2 ->
    list1 ++ list2
  end
reducePathMaps =
  fn array, accumulator ->
    Map.merge(accumulator, array, resolveMapMergeConflicts)
  end
createPathMaps =
  fn array ->
    [location1,location2] = array
    %{location1 => [location2], location2 => [location1]}
  end

inputPathMap = "input.txt"
        |> File.stream!
        |> Enum.map(&String.trim/1)
        |> Enum.map(&String.split(&1, "-"))
        |> Enum.map(createPathMaps)
        |> Enum.reduce(%{}, reducePathMaps)

traversalList = Challenge1.traverseCaves("start", inputPathMap, "", MapSet.new(), MapSet.new())
resultList = Enum.filter(List.flatten(traversalList), &!is_nil(&1))
IO.inspect resultList
IO.inspect length(resultList)
