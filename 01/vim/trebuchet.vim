vim9script

def WordToNum(word: string): string
  return {
    '1':     '1',
    '2':     '2',
    '3':     '3',
    '4':     '4',
    '5':     '5',
    '6':     '6',
    '7':     '7',
    '8':     '8',
    '9':     '9',
    'one':   '1',
    'two':   '2',
    'three': '3',
    'four':  '4',
    'five':  '5',
    'six':   '6',
    'seven': '7',
    'eight': '8',
    'nine':  '9',
  }[word]
enddef

# def Trebuchet(the_input: string): void
  var calibrations: list<number> = []
  var the_regex: string = '\d\|one\|two\|three\|four\|five\|six\|seven\|eight\|nine'

  for line in readfile(expand("%:h:h") .. '/input/part-1.txt')
    var digits = []
    line->substitute(the_regex, '\=digits->add(submatch(0))', 'g')
    digits = digits->map((_, val) => val->WordToNum())
    calibrations->add((digits[0] .. digits[-1])->str2nr())
  endfor

  echo calibrations->reduce((sum, num) => sum + num, 0)
# enddef

# Trebuchet('/input/example.txt')

defcompile
