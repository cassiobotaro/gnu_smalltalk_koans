Koan subclass: TestCollectionsRevisited [
  <comment: 'A collection of advanced collection tests.'>

  testDo [
    | array sum orderedCollection |

    "Iterate over collection."

    array := #(1 2 3 4).
    sum := 0.
    array do: [ :number | sum := sum + number ].

    self expect: 10 toEqual: sum.

    orderedCollection := OrderedCollection new addAll: array; yourself.
    sum := 0.
    orderedCollection do: [ :number | sum := sum + number ].

    self expect: 10 toEqual: sum.

    "#do: also works on SortedCollection, Bag, Dictionary, and Set."
  ]

  testConform [
    | array result sortedCollection |

    "Meets condition(s)."

    array := #($m $n $o $p).
    result := array conform: [ :character | character > $l & character < $q ].

    self expect: true toEqual: result.

    sortedCollection := SortedCollection new addAll: array; yourself.
    result := sortedCollection conform: [ :character | character > $l & character < $q ].

    self expect: true toEqual: result.

    "#conform: also works on OrderedCollection, Bag, Dictionary, and Set."
  ]

  testSelect [
    | array result bag |

    "Return collection of elements that meets condition(s)."

    array := #(1 2 3 4 5).
    result := array select: [ :number | number even ].

    self expect: #(2 4) toEqual: result.

    bag := Bag new addAll: array; yourself.
    result := bag select: [ :number | number even ].

    self expect: #(2 4) asBag toEqual: result.

    "#select: also works on OrderedCollection, SortedCollection, Dictionary, and Set."
  ]

  testReject [
    | array result dictionary |

    "Return collection of elements that do not meet condition(s)."

    array := #(1 2 3 4 5).
    result := array reject: [ :number | number even ].

    self expect: #(1 3 5) toEqual: result.

    dictionary := Dictionary new
      add: #a -> 1;
      add: #b -> 2;
      add: #c -> 3;
      add: #d -> 4;
      add: #e -> 5;
      yourself.

    result := dictionary reject: [ :number | number even ].

    self expect: (Dictionary from: { #a->1. #e->5. #c->3. }) toEqual: result.

    "#reject: also works on OrderedCollection, SortedCollection, Bag, and Set."
  ]

  testCollect [
    | array result set |

    "Transform each element and return in a new collection."

    array := #($a $b $c $d $e).
    result := array collect: [ :character | character asUppercase ].

    self expect: #($A $B $C $D $E) toEqual: result.

    set := Set new addAll: array; yourself.
    result := set collect: [ :character | character asUppercase ].

    self expect: (Set from: #($A $B $C $D $E)) toEqual: (result).

    "#collect: also works on OrderedCollection, SortedCollection, Bag, and Dictionary."
  ]

  testDetect [
    | array result |

    array := #(56 81 16 77).
    result := array detect: [ :number | number sqrt = 4 ].

    self expect: 16  toEqual: result.

    "#detect: also works on OrderedCollection, SortedCollection, Bag, Dictionary, and Set."
  ]

  testInject [
    | array result |

    array := #(4 8 12 16).
    result := array inject: 0 into: [ :numOne :numTwo | numOne + numTwo ].

    self expect: 40 toEqual: result.

    "#inject: also works on OrderedCollection, SortedCollection, Bag, Dictionary, and Set."
  ]

  testCollectionConversion [
    | array orderedCollection sortedCollection bag set dictionary |

    array := Array with: 1 with: 2 with: 3.
    orderedCollection := OrderedCollection with: 1 with: 2 with: 3.
    sortedCollection := SortedCollection with: 1 with: 2 with: 3.
    bag := Bag with: 1 with: 2 with: 3.
    set := Set with: 1 with: 2 with: 3.
    dictionary := Dictionary new
      add: #a -> 1;
      add: #b -> 2;
      add: #c -> 3;
      yourself.

    self expect: true toEqual: (array = orderedCollection asArray).
    self expect: true toEqual: (array = sortedCollection asArray).
    self expect: true toEqual: (array = bag asArray).
    self expect: true toEqual: (array = set asArray).
    self expect: true toEqual: (array = dictionary asArray).

    "
    The following messages also can be used to convert from one collection to another:
     * asOrderedCollection
     * asSortedCollection
     * asBag
     * asSet
    "
  ]

  testFailSafeAccessToElements [
    | array |

    array := #(0 1 2 3).

    self expect: nil toEqual: (array at: 0 ifAbsent: [nil]).
    self expect: [ array at: 0 ] toRaise: SystemExceptions.IndexOutOfRange.

    "#at:ifAbsent: also works on OrderedCollection, SortedCollection, and Dictionary."
  ]

  testFailSafeRemoveElementsFromCollection [
    | orderedCollection |

    orderedCollection := OrderedCollection new addAll: #(0 1 2 3); yourself.

    self expect: nil toEqual: (orderedCollection remove: 4 ifAbsent: [nil]).
    self expect: [ orderedCollection remove: 4 ] toRaise: SystemExceptions.NotFound.
  ]
]
