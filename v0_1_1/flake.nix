{
  description = ''Parser for Cirru syntax'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-cirruParser-v0_1_1.flake = false;
  inputs.src-cirruParser-v0_1_1.ref   = "refs/tags/v0.1.1";
  inputs.src-cirruParser-v0_1_1.owner = "Cirru";
  inputs.src-cirruParser-v0_1_1.repo  = "parser.nim";
  inputs.src-cirruParser-v0_1_1.dir   = "";
  inputs.src-cirruParser-v0_1_1.type  = "github";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-cirruParser-v0_1_1"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-cirruParser-v0_1_1";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}