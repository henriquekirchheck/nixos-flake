let
  filterAttrs =
    pred: set:
    removeAttrs set (builtins.filter (name: !pred name set.${name}) (builtins.attrNames set));
  unique = builtins.foldl' (acc: e: if builtins.elem e acc then acc else acc ++ [ e ]) [ ];

  recursiveMerge =
    attrList:
    let
      f =
        attrPath:
        builtins.zipAttrsWith (
          n: values:
          if builtins.tail values == [ ] then
            builtins.head values
          else if builtins.all builtins.isList values then
            unique (builtins.concatLists values)
          else if builtins.all builtins.isAttrs values then
            f (attrPath ++ [ n ]) values
          else
            builtins.last values
        );
    in
    f [ ] attrList;
in
recursiveMerge (
  map (v: import ./${v}) (
    builtins.attrNames (filterAttrs (n: v: v == "directory") (builtins.readDir ./.))
  )
)
