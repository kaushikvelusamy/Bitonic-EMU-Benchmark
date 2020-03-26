#!/bin/sh
for n in {25..28}
do
  for r in {0..7}
  do
    for c in {0..7}
    do
      echo "time emu_handler_and_loader 0 0 -- Bitonic_EMU_smart.mwx -n $n -R $r -C $c "
      time emu_handler_and_loader 0 0 -- Bitonic_EMU_smart.mwx -n $n -R $r -C $c
      sleep 5s
      echo "time emu_handler_and_loader 0 0 -- Bitonic_EMU_smart.mwx -n $n -R $r -C $c -s"
      time emu_handler_and_loader 0 0 -- Bitonic_EMU_smart.mwx -n $n -R $r -C $c -s
      sleep 5s
    done
  done
done

