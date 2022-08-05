function PrintTable(table )
  print(tostring(table) .. '\n')
  for index, value in pairs(table) do 
    print('    ' .. tostring(index) .. ' : ' .. tostring(value) .. '\n')
  end
end
