function main()
  monitor = peripheral.wrap( "top" )
  monitor.setTextScale(0.5)
  monitor.setTextColor(colors.green)
  print()
end

function print()
  monitor.write("+-------------------------------------------------------------+")
end

main()