
for script in $(ls programs/*.sh); do
    ($script download;\
     $script download_misc)&
done
wait $(jobs -p)
