vim9script

import "../../00/vim/utils.vim"

var input = utils.LoadInput('part-1')

var records = input
  ->mapnew((_, o) =>
    o->split(':')[1]
     ->trim()
     ->mapnew((_, i) => i->substitute('\s\+', '', 'g')))

var experiments: number = records[0]->len()

def NoMotion(charge: number, timeLeft: number): bool
  return charge == 0 || timeLeft == 0
enddef

def CalculateDistance(charge: number, timeLeft: number): number
  if NoMotion(charge, timeLeft)
    return 0
  endif
  return (timeLeft * charge)
enddef

def CalculateRaces(time: number): list<any>
  var result = []
  result = time->range()->mapnew((_, charge) => CalculateDistance(charge, time - charge))
  return result
enddef

def WinningRaces(time: number, distance: number): list<any>
  var races = CalculateRaces(time)
  return races->filter((_, d) => d > distance)
enddef

echo WinningRaces(records[0]->str2nr(), records[1]->str2nr())->len()
