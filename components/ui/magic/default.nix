{ stdenv, buildFractalideComponent, filterContracts, genName, upkeepers, ...}:

buildFractalideComponent rec {
  name = genName ./.;
  src = ./.;
  filteredContracts = filterContracts [];
  depsSha256 = "1y0kjbnrcr9klkk8qq53r279dd5nbgqd4pb0wjyp7dj95bh1063z";

  meta = with stdenv.lib; {
    description = "Component: dispatch the action to the output selection";
    homepage = https://github.com/fractalide/fractalide/tree/master/components/ip/clone;
    license = with licenses; [ mpl20 ];
    maintainers = with upkeepers; [ dmichiels sjmackenzie];
  };
}
