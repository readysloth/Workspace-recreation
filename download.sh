mkdir downloaded
for script in $(ls programs/*.sh); do
    FULL_PATH=$(readlink -f $script)
    (pushd downloaded; \
         $FULL_PATH download;\
         $FULL_PATH download_dependencies; \
         $FULL_PATH download_misc; \
     popd)&
done
wait $(jobs -p)
