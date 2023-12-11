vim9script

import "../../00/vim/utils.vim"

def ParseGames(gameSets: list<any>, theBag: dict<number>): number
  var result = []
  var i = 1
  for gameSet in gameSets
    var maxes: dict<number>
    for game in gameSet
      for hand in game
        var _hand = hand->split()
        if maxes->has_key(_hand[1])
          maxes[_hand[1]] = max([maxes[_hand[1]], _hand[0]->str2nr()])
        else
          maxes[_hand[1]] = _hand[0]->str2nr()
        endif
      endfor
    endfor
    result->add(maxes)
    i += 1
  endfor
  return result->reduce((p, v) => p + v->values()->reduce((p0, v0) => p0 * v0, 1), 0)
enddef

var bag: dict<number> = {
  "red": 12,
  "green": 13,
  "blue": 14
}

def ParseInput(filename: string): list<list<list<string>>>
  return utils.LoadInput(filename)
    ->mapnew((_, line) => line->split(':')[1])
    ->mapnew((_, gameset) =>
      gameset
      ->split(';')
      ->map((_, k) => k->trim()->split(',')->map((_, jk) => jk->trim())))
enddef

var input = ParseInput('input')
echo ParseGames(input, bag)

defcompile
