final: prev: {
  fio = (prev.fio.override { withGnuplot = true; }).overrideAttrs (previousAttrs: {
    postInstall = (previousAttrs.postInstall or "") + ''
      install --mode=755 t/io_uring $out/bin/fio-io-uring
    '';
  });
}
