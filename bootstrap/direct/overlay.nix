final: prev: {
  fio = (prev.fio.override { withGnuplot = true; }).overrideAttrs (
    finalAttrs: previousAttrs: {
      version = "3.43";
      src = prev.fetchFromGitHub {
        owner = "axboe";
        repo = "fio";
        tag = "fio-${finalAttrs.version}";
        hash = "";
      };
      postInstall = (previousAttrs.postInstall or "") + ''
        install --mode=755 t/io_uring $out/bin/fio-io-uring
      '';
    }
  );
}
