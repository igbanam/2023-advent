vim9script

import "../../00/vim/utils.vim"

def CanPlay(theColor: string, theCount: number, theBag: dict<number>): bool
  return theBag[theColor] >= theCount
enddef

def ParseGames(gameSets: list<any>, theBag: dict<number>): number
  var result = []
  var i = 1
  for gameSet in gameSets
    var playableGames: list<bool>
    for game in gameSet
      var playableHands: list<bool>
      for hand in game
        var _hand = hand->split()
        if CanPlay(_hand[1], _hand[0]->str2nr(), theBag)
          playableHands->add(true)
        else
          playableHands->add(false)
        endif
      endfor
      if playableHands->filter((_, pl) => pl == false)->empty()
        playableGames->add(true)
      else
        playableGames->add(false)
      endif
    endfor
    if playableGames->filter((_, pg) => pg == false)->empty()
      result->add(i)
    endif
    i += 1
  endfor
  return result->reduce((p, v) => p + v, 0)
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
