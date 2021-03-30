$2 ~ /\.puml$/ \
{
  path=gensub( /([[:alpha:][:digit:]\/-]+\/)?([[:alpha:][:digit:]-]+)\.puml$/,"\\1.svg/MODE/\\2.svg", "1", $2 )

  light=gensub(/MODE/, "light", "g", path);
  dark=gensub(/MODE/, "dark", "g", path);
  if( $1 !~ /^D$/ ) {
    # added or modified
    changed=( changed == "" ? "" : changed " " ) $2
    # light changed svg
    lcs=( lcs == "" ? "" : lcs " " ) light
    dcs=( dcs == "" ? "" : dcs " " ) dark
  }
  else {
    # removed
    lrs=( lrs == "" ? "" : lrs " " ) light
    drs=( drs == "" ? "" : drs " " ) light
  }
}
END {
  printf "::set-output name=config-change::%s\n", ( $2 ~ /(theme|config)\.puml$/ ) ? "true" : "false"
  printf "::set-output name=changed::%s\n", changed
  printf "::set-output name=changed-light::%s\n", lcs
  printf "::set-output name=changed-dark::%s\n", dcs
  printf "::set-output name=removed-light::%s\n", lrs
  printf "::set-output name=removed-dark::%s\n", drs

  printf "::warning::changed:%s\n", changed
  printf "::warning::changed-light:%s\n", lcs
  printf "::warning::changed-dark:%s\n", dcs
  printf "::warning::removed-light:%s\n", lrs
  printf "::warning::removed-dark:%s\n", drs
}
