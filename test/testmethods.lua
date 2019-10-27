-- call this programm with "<programmname> <right|left|top|bottom|front|back>" for a specified side
local arg = { ... }

function main()
  if #arg == 1 then
  local methods=peripheral.getMethods(arg[1])
  local advancedMethodsData = peripheral.wrap(arg[1]).getAdvancedMethodsData()
    print(serialize(methods))
    save("MethodNames",methods)
    print(serialize(advancedMethodsData))
    save("AdvancedMethodsData",advancedMethodsData)
  else
    print("usage: <programmname> <right|left|top|bottom|front|back>")
  end
end

function save(filename, table)
  local f = fs.open(filename, "w")
  f.write(serialize(table))
  f.close()
end

function serialize(table)
  local retString = "{"
  for i,v in pairs(table) do
    retString = retString.."["..i.."]="..textutils.serialize(v)..","
  end
  retString = retString.."}"
  return retString
end  
  main()