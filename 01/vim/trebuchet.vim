vim9script

# def Trebuchet(the_input: string): void
  var calibrations: list<number> = []

  # for line in readfile(expand("%:h:h") .. '/input/example.txt')
  for line in readfile(expand("%:h:h") .. '/input/part-1.txt')
    var digits = []
    line->substitute('\d', '\=digits->add(submatch(0))', 'g')
    calibrations->add((digits[0] .. digits[-1])->str2nr())
  endfor

  echo calibrations->reduce((sum, num) => sum + num, 0)
# enddef

# Trebuchet('/input/example.txt')

defcompile
