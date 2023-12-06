vim9script

var input = readfile($'{expand("%:h:h")}/input/example.txt')

var records = input
  ->mapnew((_, o) =>
    o->split(':')[1]
     ->trim()
     ->split()
     ->mapnew((_, k) => k->str2nr()))
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

# This may be a problem when all experiments run distances of 0. Overcorrecting
# for this may be a problem when all races run a distance of 1.

var errorMargin = 1
for i in experiments->range()
  errorMargin = errorMargin * WinningRaces(records[0][i], records[1][i])->len()
endfor

echo errorMargin
