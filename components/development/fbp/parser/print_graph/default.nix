{ stdenv, buildFractalideComponent, genName, upkeepers
  , fbp_graph
  , ...}:

buildFractalideComponent rec {
  name = genName ./.;
  src = ./.;
  contracts = [ fbp_graph ];
  depsSha256 = "1jcwwmwk6skg92mfsk0pyw18y31rfvpd8d9jfh168yw3xrplczjk";

  meta = with stdenv.lib; {
    description = "Component: Flow-based programming graph printer";
    homepage = https://github.com/fractalide/fractalide/tree/master/components/development/parser/fbp/print_graph;
    license = with licenses; [ mpl20 ];
    maintainers = with upkeepers; [ dmichiels sjmackenzie];
  };
}
